# Robin of the Wood — Actors

Every moving thing in the game — Robin, guards, the arrow, Bishop, the Sheriff of
Nottingham — is driven from the same per-frame loop at `$BF80` and, with two
exceptions, shares one object-record layout. This document covers that shared
machinery and then each actor in turn. Room drawing and the block/token system are
covered in `Room-Format.md`; screen buffers and audio in `General.md`.

The Ent - who Robin pays 3 bags of gold per transaction to obtain the sword, then the
bow, then each of 3 magic arrows one at a time (5 payments total; one of 4 possible
rooms per game) - is not in this per-frame actor list at all: it's a fixed room
decoration (see `General.md`'s landmark-rooms section), and the "transaction" is
`$DF03`'s check on the `$D595` token queue, not an object-table interaction.

## The object record

11 bytes. `$C8F7` is the shared "advance this object" routine and takes `IX` pointing
at one.

| offset | meaning |
|---|---|
| +0 | countdown timer; decremented each update, `-1` unlinks the record |
| +1 | link / table index (use varies per actor) |
| +2, +3 | pointer to the current animation frame list |
| +4 | flags — bit 0 active, bit 1 "erase current frame", bit 2 "advance to next frame", bit 5 hit |
| +5 | current frame number |
| +8 | list marker; `$FF` means end-of-list |
| +9 | X position |
| +A | Y position |

`$C8F7` does three things with it: decrements +0 and splices the record out of its
linked list when it underflows; if bit 1 of +4 is set, redraws the current frame via
`$C6D6` to erase it; if bit 2 is set, advances to the next frame and draws that.
Setting bits 1 and 2 together is the normal "move me" idiom — erase, step, redraw.

### Animation frame lists

A frame list is a run of frame numbers terminated by `$FF`, followed by a 2-byte
pointer back to the list's own loop point — so a list can loop over a tail rather than
restarting from the top. `$B8FB`'s lists are the clearest example (`01 02 FF 07 B9` =
play frames 1 and 2, then loop to `$B907`).

Frame numbers index a pointer table whose base is written to `$C6D8` before drawing;
`$C6D6` doubles the frame number to reach the entry. Robin's table is `$8D80`, other
actors point `$C6D8` at `$8DEA` or `$8DC4` first. Bit 7 of a frame number selects the
mirrored variant, handled by `$C8B7`.

## Robin

- **Record**: `$CC7C`. `$CC7A`/`$CC7B` immediately before it are animation timers, and
  `$CC87` immediately after is the facing/state byte.
- **Update**: `$C6A2`, once per frame. Runs every *other* frame unless he is
  mid-animation, in which case every frame.
- **Movement**: `$C95A` reads the chosen input device (via `$D1E9`'s dispatch),
  cancels opposite direction bits (`$D1F1`), then only lets a *changed* direction (or
  the fire bit) through once Robin is aligned to a cell boundary on that axis - a
  direction pressed mid-cell is simply dropped for the frame, taking effect only once
  he reaches the next cell. The filtered mask is saved to `$CC8B`, then each surviving
  direction bit is tested against the shadow attributes
  (`$DD6F`/`$DD80`/`$DD93`/`$DD9F`) before committing the step to `$CC85`/`$CC86`.
- **Actions**: `$C9E7` picks sword or arrow when the action bit is set and he is
  standing still on a cell boundary, then jumps through the 16-entry handler table at
  `$CD42` indexed by `$CC87`. Entries 0-5 are walking/turning, 6-D are per-facing
  stubs, E/F finish a pickup.
- **Damage**: `$BE25` decrements energy at `$BF6F`. At critical energy it sets action
  code `$6E`, which routes to `$CB9D` — a stagger with a recovery timer, not a death by
  itself. It does penalise the extra-life counter at `$D5A4` by 2 though, and at 0 or 1
  extra lives left this underflows to `$FE`/`$FF` (bit 7 set), which `$C055` reads as
  "game over" and shows the GAME OVER screen (see `General.md`) - so the actual death
  path is running out of extra lives via repeated staggers, not a direct energy check.
- **Frames**: pointer table `$8D80`.

## Room guards

- **Table**: `$AC13`, 5 entries of 11 bytes.
- **Built**: by `$C276` on every room change, from the room's map-block flags. Bits 4
  and 7 of the block byte choose which movement-table pair each guard starts with.
- **Update**: `$AA31`, one guard per call, rate-divided by 4 via the counter at `$AA32`.
  It compares the guard's row against Robin's, reads a step direction from `$DEAB`,
  and occasionally flips that direction bit on an R-register roll; separately, it picks
  the guard's new animation-frame-list pointer for `(IX+2/3)` from one of six frame
  lists at `$AC4A` (the two full walk cycles at `$AC51`/`$AC5C`, four short lead-ins
  joining one of them, or `$AC7B` when a room block's bit 5 is set).
- **Routes**: `$DDF0` refreshes each guard's route-availability flags on room entry,
  scanning `$DEAB` for the entry matching the guard's home-room nibble.
- **Shoots Robin**: confirmed live via Emu80. When a guard is within `$30` cells of
  Robin and correctly facing him (gated by the arrow flag `$D59E`, or a coin-flip
  otherwise), `$AA31` claims a free slot in the 3-entry room-hotspot table at `$BF69`
  with the guard's own position and switches to a kneel/aim frame (`$AC6F`/`$AC75`).
  There is no separate flying-bullet object - `$BDA3` (shared with authored room
  hazards) is what actually hits Robin if he walks into that claimed cell.
- **Hit by**: `$BD49` (arrow, compares columns) and `$BE43` (sword, bounding box via
  `$BEE3`). Both skip entries whose +4 bit 0 is clear or bit 5 already set, and mark a
  hit through `$BF1A`.

Live-traced entry layout: `[0]` home-room low nibble, `[1]` route-availability flag
(tested by `$DDF0`), `[2:3]` frame-list pointer, `[4]` status flags, `[5:7]` and
`[8:10]` two 3-byte triples. Offset `[9]` genuinely advances during movement (observed
`$63`→`$72` while animating), so the wrapping-position mechanic applies to ordinary
patrol guards, not just Bishop. `[5:7]` mirrored `[8:10]` exactly in every
sample taken — idle or moving, across all 4 entries, never diverging — so whatever
writes one writes both; it is not a "target vs current" split, and the reason for the
duplicate is unconfirmed.

On a hit, `$BF1A` sets bit 5 of the status byte and switches the frame-list pointer to
a hit-reaction list. The guard then takes a knockback step (position wrapped through
the `$70` boundary, e.g. `$25`→`$12`) and within about a second its entry stops
updating entirely — consistent with `$C8F7` unlinking it once its countdown expires,
leaving a static "corpse".

## The Witch

Interaction mechanic confirmed in full against a player-sourced walkthrough (see
`General.md`'s special-event-rooms bullet for the trace): she appears in the 9 rooms
listed at `$DBCD`, but only if Robin is carrying at least one gold bag or flower
(tokens queued at `$D595`, written by `$D94B` when he picks one up anywhere). On
resolution (`$DB18`, once the room's door-flash animation completes a cycle): flowers
are always taken first, one at a time - 1 taken outright, 2 refills energy to full,
3 warps Robin to room `$CC` (leaving any beyond 3 still queued) - and only once no
flowers remain does she take a single gold bag, giving nothing back either way.

Her own sprite (`$A2E7`/`$A35F`/`$A3D7`, 3 frames) is not referenced by the shared
`$8D80` frame table or any of the 3 known `$C6D8` bases, unlike every other actor -
how/whether her appearance is actually drawn (and gated on the token queue being
non-empty) is not confirmed; this section covers the take/reward logic only.

## Boars

Confirmed live via Emu80 that the sprite drawn is `$A965`'s wild boar - the "door" in
`$DD3F`'s name describes the per-room position/gating data this table is built from,
not what gets drawn.

- **Table**: `$DD05`, 4 entries, same 11-byte layout as `$AC13` - the fixed cap of 4
  matches a player-sourced walkthrough: "4 looped boar trails on the map, used as
  landmarks." Each boar patrols only within its own room (same `$70`-wrap stepping as
  room guards), so the "trail" is the pattern of which connected rooms are assigned a
  boar via `$DD3F`, not one boar roaming across rooms.
- **Built**: by `$C276` from the door data at `$DD3F`.
- **Update**: `$DBF8`, one entry per call, every 4th call. Steps (IX+9) one position
  toward its target with `$70` wraparound, then picks a frame table from `$DD31`
  (frames `$10`-`$13`) or `$DD38` (mirrored, `$90`-`$93`) by facing - both resolve
  through the shared frame base `$8DEA` to `$A965`'s boar sprite.
- **Contact**: `$BDE0` tests Robin against them via `$BEE3` — only in multi-column
  rooms, only while he is idle, and only about one call in eight. On overlap, `$BE25`
  applies the hit (energy loss) - the CRASH review's "boars run loose in the forest,
  and contact... leads to injuries."

## The arrow

- **Record**: `$BF67` — not the standard layout. Two bytes: position (bit 7 = "gone")
  and direction/frame (bits 6-7 direction, bits 0-6 frame; `$0A`-`$0D` means in flight).
- **Launch**: `$BC81`, from Robin's facing/state handlers `$CB03`/`$CB0A`. Only fires
  when the animation timer is exactly 7 and no arrow is already active.
- **Update**: `$BCC2` steps it one cell along a diagonal per frame, self-modifying its
  own step operands from the direction bits, and marks the cell dirty via `$BD2A`.
- **Ends**: `$BD09` clears it at the screen edges.

## Bishop of Peterborough

Per CRASH's Jan 1986 review (`docs/Crash-24-Jan-1986.md`): the Evil Bishop of
Peterborough possesses the gold Robin needs, guarded by crossbow-wielding Norman
escorts; robbing him yields money bags, which Robin then pays to the Ent (three bags
per weapon) to buy the bow, sword and three magic arrows.

- **Sprite**: `$A83C`, 3 frames, confirmed both visually and statically — frame `$03`
  in Bishop's own direction table `$BB7F` resolves to `$A83C` via the shared frame
  base `$8DEA`, and the Hermit (below) never uses frame `$03`.
- **State**: `$BB9x`/`$AC4x` variables rather than a shared record — the one actor that
  does not use the object table.
- **Update**: `$B919`. Every 4th call it may roll a new patrol route from the 8-entry
  (start room, end room) table at `$BBA1` (R-register roll, reroll on a repeat), then
  calls `$BA85` to take one step toward the current endpoint, reversing at each end.
  Every entry's two rooms share the same row (`room = row*16+column`), so each route is
  a straight horizontal patrol across part of one row — confirmed against a player-made
  map that independently plots these same 8 spans, e.g. row 6 columns 0-7, row 19
  columns 6-9. The full list (row, column range): row 1 cols 13-2, row 3 cols 1-3, row 6
  cols 0-7, row 7 cols 15-1, row 12 cols 15-1, row 14 cols 13-0, row 15 cols 15-0, row 19
  cols 6-9.
- **Scared by killing his escort**: confirmed against a player-sourced walkthrough.
  `$B919` independently polls the hit-flag of `$AC13`'s 5th/last guard slot (`IX=$AC3F`)
  every cycle - not a push notification from the kill itself, `$BF1A` never touches
  Bishop's state. While that guard is alive, Bishop just steps normally (`$BA38`). Once
  it's dead (bit 5 set), `$B919` instead points `$D9B3`/`$D9BD` at Bishop's tracked
  target room (`$BB9D`) and calls `$D997` twice (8 pixels apart) - printing the
  bag-of-money icon (`$B512`) once per call if Bishop's tracked room matches Robin's
  current room, up to 2 prints - matching "pays off with two bags of gold" exactly.
  Whether this same event also forces an early route reroll ("changes his location")
  isn't confirmed: `$BB9F` bit 2 is set here, but bits 0-1 (which gate `$B919`'s route
  reroll) are left untouched. On arrival at the target room the pointer switches to
  live room/position variables instead, so the same check keeps firing once Bishop is
  actually in Robin's room. The same type-`$02` value also feeds the general
  proximity-trigger queue at `$D94B`/`$D59B` (fed from `$D7F3`'s zone scan), which
  prints the icon as its default fallback for any queued value other than `$05`
  (flower). No direct Robin-vs-Bishop bounding-box test (`$BEE3`) was found; the
  effect is triggered by room-match, not a close-range hit test. Exactly why the
  effect is described as "three bags" is not confirmed from the static code alone.

## The Hermit

Confirmed in full against a player-sourced walkthrough (previously documented here as
"the roaming object" before this was traced).

- **Record**: `$BC59`, standard layout.
- **Room**: `$D3B4`, rolled once at game start (`$D392` - 4 slots but entries 3/4
  duplicate, so only 3 distinct rooms - "3 possible dwelling places for the hermit").
  Same room as his hut (`Room-Format.md`).
- **Update**: `$BBC1`, every 4th call. Tracks a room-distance counter at `$BC64` and
  steps (IX+9) toward or away from Robin's current room, alternating between the frame
  lists at `$BC69` and `$BC75` - the walkthrough's "travels back and forth left and
  right of his hut."
- **Init**: `$CFC7` at game start points him at his room.
- **Heals Robin**: `$BEB1` — on contact (via `$BEE3`, comparing `$BC62` against
  Robin's position) flashes the screen, refills Robin's energy to maximum, prints a
  message via `$D91A` (which also increments the displayed extra-life counter
  `$D5A4`), and sets bit 6 of `$BC67` to mark the reward given. That same bit is what
  gates the reward (`$BEB1` bails out while it's set) - and `$BE25`/`$BE35` clears it
  again whenever Robin takes a critical-energy hit. This is exactly the walkthrough's
  rule: the first meeting always pays out; later meetings only pay out if Robin has
  been critically hit ("died") since the last one, otherwise nothing happens.

## Sheriff of Nottingham

- **Record**: `$B8FB`, standard layout, with its four frame lists immediately after it.
- **Trigger**: `$B867`, but only in the room rolled by `$CFB3` into `$D3B8` (one of 8
  entries, 7 distinct rooms, in `$D3A2`). While Robin is in the centre band of that
  room it arms the ambush, plays the laugh (`$8C8D`), and once the figure reaches
  frame `$02` warps Robin to room `$9C`. The check itself is purely room-number-based
  - `$B867` never looks at room type - but all 7 candidate rooms happen to be room
  type `$00`, a bush-clearing layout confirmed (by a player screenshot) as the
  ambush's dedicated scenery, reused at every possible location.

## Per-frame order

`$BF80` runs the actors in a fixed order every frame:

1. `$C6A2` — Robin
2. `$BCC2` — arrow step
3. `$AA31` — one room guard
4. `$DBF8` — one boar
5. `$BD49`, `$BDA3`, `$BDE0`, `$BE43` — arrow hits, hotspots, boar contact, sword hits
6. `$B867` — Sheriff of Nottingham ambush check
7. `$BBC1`, `$B919`, `$BEB1` — Hermit, Bishop, his reward check
8. `$C85C` — flush changed cells to the real screen

Note that both guard updaters advance only one entry per call and are themselves
rate-divided, so a single guard actually moves once every ~16 frames.

## Open questions

- Bishop's "scare" mechanic is now confirmed for the money payout (see his section
  above: `$B919` polls his escort's hit-flag, not a push from the kill). What's still
  open is whether killing the escort also forces an early route reroll ("changes his
  location", per the walkthrough) - `$BB9F` bit 2 is set on the scare, but bits 0-1
  (which actually gate `$B919`'s reroll at the top of the routine) are left untouched
  by this branch, and no other write to them was found outside `$B919` itself and
  game-start init. Needs live confirmation.
- The Witch's own sprite (`$A2E7`/`$A35F`/`$A3D7`) is not reachable from the shared
  `$8D80` frame table or any of the 3 known `$C6D8` bases, unlike every other actor.
  The take/reward logic (`$DB18`) is fully confirmed, but how or whether her sprite is
  actually drawn - and whether it's suppressed when Robin carries nothing - is not.
- The `$DEAB` region has two conflicting readings: `$DDF0` walks it as 28-byte entries
  from `$DEAB`, while `$DE8D`/`$DE97`/`$DEA1` treat `$DEAF`/`$DEE7` as templates around
  a working copy at `$DECB`. Those bases differ by 4 and cannot both be right. A third
  piece since found: `$DE5D` refreshes `$DECB` not from `$DEAF`/`$DEE7` directly but from
  a live source at `$E982` (a region not otherwise documented), after
  `$DE8D`/`$DE97`/`$DEA1` have picked which template that source should reflect - so the
  actual data flow is template-select -> `$E982` -> `$DECB`, one step more indirect than
  previously described. Live-read confirms the conflict is real: with no guarded room
  loaded, `$DEAB` (the 28-byte-stride table) reads all zero, while `$DECB` holds live
  non-zero data (`46 46 04 04 04 04`). `$DECB` sits at `$DEAB+32`, not a multiple of 28,
  so it cannot be entry 0/1/2... of the 28-byte table — the two schemes address genuinely
  different structures, not just an off-by-4 in one description. Checked again with an
  active room guard on screen: `$DEAB` still reads all zero, and `$DECB` had gone back to
  all zero too (its earlier `46 46 04 04 04 04` was read at the title/intro state, not
  during gameplay) — so that data was likely leftover from init/the title sequence, not a
  live per-room route table populated by ordinary room guards. Boar routing may be
  what actually populates this region; not yet checked with a confirmed live boar,
  and `$E982`'s own contents haven't been read live either.
- `$B919`'s trigger logic — which bits of `$BB9F` gate what.
