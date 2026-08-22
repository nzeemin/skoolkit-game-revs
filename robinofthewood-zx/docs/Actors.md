# Robin of the Wood — Actors

Every moving thing in the game — Robin, guards, the arrow, the special enemy, the
ambush figure — is driven from the same per-frame loop at `$BF80` and, with two
exceptions, shares one object-record layout. This document covers that shared
machinery and then each actor in turn. Room drawing and the block/token system are
covered in `Room-Format.md`; screen buffers and audio in `General.md`.

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
  cancels opposite direction bits (`$D1F1`), then tests each surviving direction
  against the shadow attributes (`$DD6F`/`$DD80`/`$DD93`/`$DD9F`) before committing the
  step to `$CC85`/`$CC86`.
- **Actions**: `$C9E7` picks sword or arrow when the action bit is set and he is
  standing still on a cell boundary, then jumps through the 16-entry handler table at
  `$CD42` indexed by `$CC87`. Entries 0-5 are walking/turning, 6-D are per-facing
  stubs, E/F finish a pickup.
- **Damage**: `$BE25` decrements energy at `$BF6F`. At critical energy it sets action
  code `$6E`, which routes to `$CB9D` — a stagger with a recovery timer, not a death.
- **Frames**: pointer table `$8D80`.

## Room guards

- **Table**: `$AC13`, 5 entries of 11 bytes.
- **Built**: by `$C276` on every room change, from the room's map-block flags. Bits 4
  and 7 of the block byte choose which movement-table pair each guard starts with.
- **Update**: `$AA31`, one guard per call, rate-divided by 4 via the counter at `$AA32`.
  It compares the guard's row against Robin's, picks a direction table from `$DEAB`,
  and occasionally flips a direction bit on an R-register roll.
- **Routes**: `$DDF0` refreshes each guard's route-availability flags on room entry,
  scanning `$DEAB` for the entry matching the guard's home-room nibble.
- **Hit by**: `$BD49` (arrow, compares columns) and `$BE43` (sword, bounding box via
  `$BEE3`). Both skip entries whose +4 bit 0 is clear or bit 5 already set, and mark a
  hit through `$BF1A`.

Live-traced entry layout: `[0]` home-room low nibble, `[1]` route-availability flag
(tested by `$DDF0`), `[2:3]` frame-list pointer, `[4]` status flags, `[5:7]` and
`[8:10]` two 3-byte triples. Offset `[9]` genuinely advances during movement (observed
`$63`→`$72` while animating), so the wrapping-position mechanic applies to ordinary
patrol guards, not just the special enemy. `[5:7]` mirrored `[8:10]` exactly in every
sample taken — idle or moving, across all 4 entries, never diverging — so whatever
writes one writes both; it is not a "target vs current" split, and the reason for the
duplicate is unconfirmed.

On a hit, `$BF1A` sets bit 5 of the status byte and switches the frame-list pointer to
a hit-reaction list. The guard then takes a knockback step (position wrapped through
the `$70` boundary, e.g. `$25`→`$12`) and within about a second its entry stops
updating entirely — consistent with `$C8F7` unlinking it once its countdown expires,
leaving a static "corpse".

## Door guards

- **Table**: `$DD05`, 4 entries, same 11-byte layout as `$AC13`.
- **Built**: by `$C276` from the door data at `$DD3F`.
- **Update**: `$DBF8`, one entry per call, every 4th call. Steps (IX+9) one position
  toward its target with `$70` wraparound, then picks a frame table from
  `$DD31`/`$DD38` by facing.
- **Contact**: `$BDE0` tests Robin against them via `$BEE3` — only in multi-column
  rooms, only while he is idle, and only about one call in eight.

## The arrow

- **Record**: `$BF67` — not the standard layout. Two bytes: position (bit 7 = "gone")
  and direction/frame (bits 6-7 direction, bits 0-6 frame; `$0A`-`$0D` means in flight).
- **Launch**: `$BC81`, from Robin's facing/state handlers `$CB03`/`$CB0A`. Only fires
  when the animation timer is exactly 7 and no arrow is already active.
- **Update**: `$BCC2` steps it one cell along a diagonal per frame, self-modifying its
  own step operands from the direction bits, and marks the cell dirty via `$BD2A`.
- **Ends**: `$BD09` clears it at the screen edges.

## The special enemy

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
- **Defeated**: `$BEB1` — on contact it flashes the screen, refills Robin's energy to
  maximum, prints a kill message and marks the enemy done.

## The roaming object

- **Record**: `$BC59`, standard layout.
- **Update**: `$BBC1`, every 4th call. Tracks a room-distance counter at `$BC64` and
  steps (IX+9) toward or away from Robin's current room, alternating between the frame
  lists at `$BC69` and `$BC75`.
- **Init**: `$CFC7` at game start points it at the second random scenario room.

## The ambush figure

- **Record**: `$B8FB`, standard layout, with its four frame lists immediately after it.
- **Trigger**: `$B867`, but only in the room rolled by `$CFB3` into `$D3B8`. While
  Robin is in the centre band of that room it arms the ambush, plays the laugh
  (`$8C8D`), and once the figure reaches frame `$02` warps Robin to room `$9C`.

## Per-frame order

`$BF80` runs the actors in a fixed order every frame:

1. `$C6A2` — Robin
2. `$BCC2` — arrow step
3. `$AA31` — one room guard
4. `$DBF8` — one door guard
5. `$BD49`, `$BDA3`, `$BDE0`, `$BE43` — arrow hits, hotspots, door-guard contact, sword hits
6. `$B867` — ambush check
7. `$BBC1`, `$B919`, `$BEB1` — roaming object, special enemy, its defeat check
8. `$C85C` — flush changed cells to the real screen

Note that both guard updaters advance only one entry per call and are themselves
rate-divided, so a single guard actually moves once every ~16 frames.

## Open questions

- Whether door guards are ever actually populated. Checked live in 4 rooms (including a
  `$C549 != 0` room and one with Robin at point-blank range against the door): the
  layout matches `$AC13` and room entry does pick the frame-list pointer
  (`$DD31`/`$DD38`) from the door's block flag, and `$DBF8` visibly cycles IX across
  each entry's fields every frame — but no entry was ever seen setting its flags or
  stepping its position, staying at the `00 00 00 / 00 00 $60` default throughout.
  Likely none of the doors sampled had a guard assigned; the block's door-flag only
  picks a default frame-list constant at room setup, it does not guarantee a live
  patrol. Real door guards may exist only on specific story doors not yet found.
- The `$DEAB` region has two conflicting readings: `$DDF0` walks it as 28-byte entries
  from `$DEAB`, while `$DE8D`/`$DE97`/`$DEA1` treat `$DEAF`/`$DEE7` as templates around
  a working copy at `$DECB`. Those bases differ by 4 and cannot both be right. Live-read
  confirms the conflict is real: with no guarded room loaded, `$DEAB` (the 28-byte-stride
  table) reads all zero, while `$DECB` holds live non-zero data (`46 46 04 04 04 04`).
  `$DECB` sits at `$DEAB+32`, not a multiple of 28, so it cannot be entry 0/1/2... of the
  28-byte table — the two schemes address genuinely different structures, not just an
  off-by-4 in one description. Checked again with an active room guard on screen: `$DEAB`
  still reads all zero, and `$DECB` had gone back to all zero too (its earlier `46 46 04
  04 04 04` was read at the title/intro state, not during gameplay) — so that data was
  likely leftover from init/the title sequence, not a live per-room route table populated
  by ordinary room guards. Door-guard routing may be what actually populates this region;
  not yet checked with a confirmed live door guard.
- Exact meaning of the guard flag bits beyond bit 0 (active) and bit 5 (hit). Live-read of
  `$AC13` with a room guard present: entry 4 (`$AC34`) had flags `$03` (bits 0 and 1 both
  set) — bit 1 not yet explained by the existing bit 0/bit 5 model.
- `$B919`'s trigger logic — which bits of `$BB9F` gate what.
- Whether a true game-over path exists distinct from the `$B867` capture; `$CB9D` is
  only a stagger, and nothing found so far ends the game on energy loss.
