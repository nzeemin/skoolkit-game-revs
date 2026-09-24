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
  `$CD42` indexed by `$CC87`. Entries 0/1 sit, 2/3 run, 4/5 run up/down, 6/7 sword
  swing (probable), 8/9 arrow, **0A/0B are STICK SWING right/left** (see below), 0C/0D
  per-facing stubs (meaning unconfirmed), E/F finish a pickup/stagger recovery.
- **The pre-sword "stick swing"**: confirmed against player-reported footage. Pressing
  fire before Robin owns the sword doesn't just replay a walk frame -
  it's a dedicated animation. `$C9E7` dispatches through `$CA44`/`$CA4C` as normal, but
  `$CAB5` finds the sword flag `$D59D` clear and falls to `$CAE1`, which sets Robin's
  state to `$0A`/`$0B` (STICK RIGHT/LEFT, `$CD42` table renamed accordingly) and picks
  frame table `$CCDF`/`$CCEA` - previously mislabeled "WALK RIGHT/LEFT" in the ctl, but
  those frames (`$1D`-`$20`, data at `$A190`/`$A1B0`/`$A1D0`/`$A1F0`) are used by no
  other frame table in the game (the real RUN tables at `$CCFC`/`$CD11`/`$CD26`/`$CD2D`
  use frames `$00`-`$0C` instead), so they're a genuine dedicated pose, not walk-cycle
  reuse. Since `$D59D` never resets once the sword is bought, this whole animation
  becomes permanently unreachable for the rest of a playthrough after that purchase.
- **Sprite frame format, wide class**: discovered while decoding the stick-swing
  frames. A frame's byte 0 is a header whose low nibble is a width class, tested by
  `$C585` (`CP $4`); classes `$4`+ ("wide") don't draw via `$C6D6`'s own row-tuple loop
  at `$C723` at all (confirmed live: that address is never hit for these frames) -
  instead `$C585` falls through into the old glyph-string drawer (`$C5D8`/`$C5E4`),
  treating the frame's own bytes from offset 1 onward as a sequence of **character
  codes into the `$9AB3` HUD font** - the same mechanism as icons like `$B495`'s sword,
  not a bespoke sprite pixel format. Confirmed live: `$C6A0` (the glyph-string pointer
  `$C5E4` reads from) equals the frame's own address + 1. Layout is fixed at 6 columns
  x 5 rows (30 glyph bytes, matching `$C682`'s exact 5 groups of 6 mirror-remap
  entries) plus the header and one trailing byte = 32 bytes/frame; `$00` is a blank
  cell (skipped but still advances the column). The trailing byte is a **flat
  attribute** applied to the whole frame (confirmed: every header-`$86` frame sampled
  this session has `$44` there, matching the bright green seen live) - not a stray
  pad byte. A second, richer 61-byte format also exists (header + 30 glyphs + 30
  **per-cell** attribute bytes, one per glyph) - used by the Sheriff/Bishop/boar
  shared base `$8DEA` (confirmed via its pointer table's 61-byte stride and by
  rendering `$A230` in the Sheriff's real yellow/magenta colours). Which format a
  given frame uses is not yet tied to a specific header bit - still open. Rendered
  and confirmed against the live game for frames `$1D`-`$20` (images in the ctl at
  `$A190`/`$A1B0`/`$A1D0`/`$A1F0`) - narrow-class frames (nibble `<4`) presumably do
  use `$C6D6`'s row-tuple path instead, but that hasn't been confirmed live for any
  specific frame yet.
- **Only sword and arrow actually hurt a guard - the stick swing is cosmetic.**
  `$BE43` (sword) tests Robin's current animation frame and only proceeds for the
  swing/thrust frames `$1A`/`$1F`/`$1C`, building a hit-rectangle off `$CC85`/`$CC86`
  (mirrored by facing) and scanning the 5-entry guard table `$AC13` via `$BEE3` for
  overlap. `$BD49` (arrow) does the equivalent for the arrow's own in-flight frames
  `$0A`-`$0D`, testing column proximity against the same table. Either hit calls
  `$BF1A` (sets bit 5 "hit" on both the guard's `(IX+4)` flags byte and the matching
  entry in `$8A39`) then falls into the shared `$BD84` hit/scream sound (border-flash,
  $14 outer passes, rising pitch to $28). The stick-swing state (`$CAE1`, frames
  `$0A`/`$0B`) has no equivalent hit-test anywhere - no routine scans `$AC13` while
  Robin is in the STICK RIGHT/LEFT state, so waving the stick before buying the sword
  cannot defeat a guard; it's purely the wind-up animation with no gameplay effect.
- **Damage**: `$BE25` decrements energy at `$BF6F`. At critical energy it sets action
  code `$6E`, which routes to `$CB9D` — a stagger with a recovery timer, not a death by
  itself. It does penalise the extra-life counter at `$D5A4` by 2 though, and at 0 or 1
  extra lives left this underflows to `$FE`/`$FF` (bit 7 set), which `$C055` reads as
  "game over" and shows the GAME OVER screen (see `General.md`) - so the actual death
  path is running out of extra lives via repeated staggers, not a direct energy check.
- **Frames**: pointer table `$8D80`.

## Room guards

- **Table**: `$AC13`, 5 entries of 11 bytes (4 live room slots + Bishop's escort at
  the 5th).
- **Built**: by `$C276` on every room change - but only `(IX+2/3)` (frame-list pointer)
  and `(IX+4)` (redraw flags) are set here, from the matching `$8A39` entry's byte 2 (not
  the room's own map-block byte, despite the resemblance). Bit 4 set (dead/away) gives
  frame table `$AC7F` plus `SET 5,(IX+4)` so hit tests skip it; otherwise bit 7 picks
  between the two walk cycles `$AC5C` and `$AC51`.
- **Where they live — `$8A39`**: there is no authored per-room guard roster. `$8A39` is
  48 bytes read as **4 groups of 12** (4 guards x 3 bytes), the group picked by `$C3FA`
  from bits 4-5 of the room byte. Since a room packs as `(row << 4) | column`, that index
  is the **map row mod 4**: every room in the same row-band shares one group of 4 guards.
  Seeded once at game start by `$CE0A`. Per entry: **byte 0** = home column 0-15,
  **byte 1** = fine patrol cursor over 0-`$6F`, **byte 2** = flags (bit 7 step direction,
  bit 6 facing/mirror, bit 5 just-hit, bit 4 dead/away).
- **Which rooms a guard shows up in — exactly 3 columns.** `$AA31` computes
  `A = (byte0 - column + 1) AND $0F` from the room's own column nibble (`$C548 AND $0F`)
  and bails unless `A < 3`. So the guard is live only where `column` is `byte0+1`, `byte0`
  or `byte0-1`: three adjacent columns within its row-band, not a wide roaming range. That
  same `A` (0/1/2) is then the index into `$DEAB`, so the route data a guard follows
  depends on which of the three columns Robin is currently in.
- **Spawned once at game start by `$CE0A`**, which seeds all 16 entries (all 4 bands) with
  three random draws each: byte 0 masked to `$0F` (home column), byte 1 taken whole (the
  cursor, so it can start outside `0`-`$6F` — the first wrap in `$AA31`, or `$DDF0`'s
  re-derivation, normalises it), and byte 2 masked to **bit 7 only**. That mask is the
  whole initial state: direction is a coin flip, and facing/just-hit/dead all start clear,
  so every guard begins alive and already facing the way it walks.
- **Direction and frame list — bits 7 and 6 are a turn-detector.** Bit 7 is the direction
  the guard wants to walk; bit 6 is the facing its animation is currently showing. Both of
  `$AA31`'s direction-change paths deliberately leave bit 6 holding the *previous* bit 7,
  so the two bits disagree exactly when a turn has been decided but not yet animated:
  - `$AB51`'s `AND $C0` / `JP PE` is a bit-6-vs-bit-7 comparison dressed up as a parity
    test — `$00`/`$C0` (agree) is even parity and jumps away leaving the frame list alone;
    `$40`/`$80` (differ) is odd parity and falls through.
  - On disagreement it installs a lead-in — `$AC67` if bit 7 is set, `$AC6B` if clear, each
    one turn frame (`$0C`) running into the matching walk cycle — then syncs bit 6 to bit 7
    so the next update sees agreement.
  - `$C276` assigns the initial list the same way (`$C353`): bit 7 set → `$AC5C` forward,
    clear → `$AC51` backward, and it forces bit 6 to match, so a guard entering a room
    never starts with a pending turn.

  Full list map: `$AC51` backward walk (`$0B`-`$08`, twice), `$AC5C` forward walk
  (`$00`-`$07`), `$AC67`/`$AC6B` turn lead-ins, `$AC6F`/`$AC75` kneel/aim lead-ins (frames
  `$0D`/`$0E`, assigned by the shooting check at `$ABD5`), `$AC7B` death, `$AC7F` its
  corpse-only entry point.
- **How they move**: `$AA31`, one guard per call, rate-divided by 4 via the counter at
  `$AA32`. Byte 2 bit 7 picks an increment or decrement path over byte 1; byte 1 steps one
  unit per update and, on wrapping off either end of its `0`-`$6F` range, carries `±1` into
  byte 0 - that carry is what walks a guard from one room-column to the next. Direction
  changes come from the `$DEAB` step table (indexed by the column distance, with a 3- or
  4-byte step budget from byte 1's low 2 bits): a non-zero step byte toggles byte 2's
  mirror bits 6-7, while an all-zero scan instead compares Robin's column against the
  `$DEC7` reference table to pick a facing and, about 1 call in 16, rotates a fresh
  direction bit through byte 2. Separately it picks the animation-frame-list pointer for
  `(IX+2/3)` from one of six lists at `$AC4A` (two full walk cycles at `$AC51`/`$AC5C`,
  four short lead-ins joining one of them, or `$AC7B` once the guard is flagged dead).
- **Two things write a guard's position, not one.** `$AA31` steps the cursor by ±1 per
  update (above), but `$DDF0` — called from `$C276` on every room entry, immediately before
  its four `$AA31` calls — **re-derives the cursor outright**: it masks off the low 2 bits
  in place, uses `cursor >> 2` as an offset into the guard's `$DEAB` entry, and if the
  3-byte window there is not all zero, scans forward up to 25 bytes for the first all-zero
  window and stores `4 x bytes_stepped` back into the cursor. So the cursor is snapped to
  "distance to the next open spot on the route, x4", and a guard's X can **jump** between
  rooms rather than only drifting. Since `$AA31` stage 6 copies the cursor straight into
  `(IX+9)`, that re-derived value is where the guard appears on the first frame in a room.
  Side effect: the cursor's low 2 bits are left clear, so the step budget `$AA31` reads
  from them is always 3 right after a room entry.
- **Routes — `$DEAB`, 3 entries of 28 bytes, each a 4-byte header plus a 24-byte body.**
  The long-standing "two conflicting readings" of this region was a false alarm: the
  template/working-copy addresses are simply the entry *bodies*, at entry start + 4.

  | Entry | Start | Body (start+4) | Used when |
  |---|---|---|---|
  | 0 | `$DEAB` | `$DEAF` | Robin's column = `byte0 + 1` |
  | 1 | `$DEC7` | `$DECB` | Robin's column = `byte0` |
  | 2 | `$DEE3` | `$DEE7` | Robin's column = `byte0 - 1` |

  The old objection - "`$DECB` is `$DEAB+32`, not a multiple of 28, so it can't be an
  entry" - assumed those addresses had to be entry *starts*. `$DEAB+32` is `28+4`: entry 1's
  body. Independently confirmed by `$AA31` itself, which hard-codes `LD BC,$DEC7` at
  `$AAB7` as its column reference - `$DEC7` being exactly `$DEAB + 1x$1C`, an entry
  boundary that only makes sense under the 28-byte-stride reading. So `$DDF0` walking
  28-byte entries and `$DE8D`/`$DE97`/`$DEA1` shuffling `$DEAF`/`$DECB`/`$DEE7` are the
  same structure at two granularities. **Nothing pre-fills this region with route data at
  game start** — what ships there is one-shot startup code, which runs once and is then
  recycled as the buffer. Disassembling from `$DEB1` in the snapshot gives
  `CALL $CFEE` / `CALL $D004` / `CALL $D095` (the IM2 install) / `CALL $D067`, the screen
  set-up that loads `$B587` and `$B5C0` (the two side ornaments) via `$CFE1`,
  `XOR A` / `OUT ($FE),A`, `LD ($CC7B),A` / `LD ($CC7A),A`, `CALL $CBA3`, `DI`,
  `CALL $AC83` (draw the main menu), then a keyboard scan on `$EFFE`/`$F7FE`. So the
  all-zero live reads during gameplay are that code having been blanked, not an empty table.

  The three `$C276` variants work as a **shift register** over the bodies, run on every
  room entry:

  | Variant | Effect |
  |---|---|
  | `$DE97` | `$DECB` → `$DEE7`, blank `$DEAF`, reload `$DECB` from `$E982` |
  | `$DEA1` | `$DECB` → `$DEAF`, blank `$DEE7`, reload `$DECB` from `$E982` |
  | `$DE8D` | blank both neighbours, reload `$DECB` from `$E982` |

  Entry 1 is always reloaded for the column Robin is now in; the column he just left is
  either shifted out into the matching neighbour slot or discarded. Note the copy
  direction: `$DE6E`/`$DE69` set the *destination* in `DE` and the shared `LDIR` at
  `$DE71` always sources from `$DECB` — our older notes had this backwards.
  `$DDF0` scans for the entry matching the home-column nibble - that nibble and the
  route-availability flag it tests live in `$8A39` (reached via `$C54C`), not in `$AC13`.
- **Shoots Robin — only at range.** `$AB79` skips the whole
  mechanic when the horizontal distance is **under** `$30`, so a guard shoots only from a
  distance and just walks into Robin close up. Given that distance and a facing matching
  the side Robin is on (gated by the arrow flag `$D59E`, or a coin-flip
  otherwise), `$AA31` claims a free slot in the 3-entry room-hotspot table at `$BF69`
  with the guard's own position and switches to a kneel/aim frame (`$AC6F`/`$AC75`).
  **Guard bullets are real flying projectiles.** `$BF67` is a **4-entry array of 2-byte
  projectile objects**: object 0 is Robin's arrow, objects 1-3 (`$BF69`, `$BF6B`, `$BF6D`)
  are the guard bullets. `$BCC2` steps and draws **all four** every frame — its `LD B,$04`
  is the object count, and the loop closes at `$BD23` with `POP BC / POP HL / INC HL /
  INC HL / DJNZ`.

  Each object is **column, then row** — not "position then direction/flags" as the byte
  count alone might suggest:
  - **Byte 0 = character column.** `$00` marks the slot empty. Bit 7 is the projectile's
    **persistent** horizontal step direction, folded in at launch from facing via a
    rotate trick (`$ABCC`-`$ABD0` for a bullet, the same pattern at `$BCBB`-`$BCBF` for
    the arrow) that leaves the column bits untouched, and read every step at `$BCF7`.
  - **Byte 1 = character row.** This is genuinely Y, not an animation frame - Robin's
    arrow inherits his own row at launch (`$CC86 >> 3`, bias `+1`), so it varies with
    where he was standing when he fired; a guard's bullet always gets the same row
    (`(IX+$0A) >> 3`, bias `+2`) because guards never move vertically (see `$AC13`'s
    fixed-Y bullet above). Bits 7 and 6 ride on top of the row as two **one-shot** request
    flags, each tested and cleared the moment `$BCC2` reads them, before the row value
    itself is used: bit 7 = skip this step's erase (set at launch, since there is nothing
    on screen yet to erase), bit 6 = destroy after erasing (set by `$BDA3`/`$BD49` on a
    hit, so the object erases once more then vanishes rather than being drawn again).

  - **Launch** — `$AA31` `$ABB0`-`$ABC7`: writes the guard's own column and row (from
    `(IX+9)`/`(IX+$0A)`) as the bullet's start, sets the skip-erase flag, then folds
    facing into the direction bit.
  - **Flight** — `$BCC2`: consumes the two one-shot flags (patching self-modified step
    operands at `$BCF2`/`$BD03`), then moves the object ±1 in column and row per frame - a
    diagonal - and `$BD09` clears it (column byte back to `$00`) at the screen edges.
  - **Draw** — `$BD2A`: XORs `$FF` into one byte of the `$EB00` shadow pixel buffer, i.e.
    a solid **8×1 horizontal bar**, and writes `$46` into the matching `$E500` cell, which
    `$C85C` uses as that cell's attribute — `$46` is **bright yellow**. Being an XOR, the
    next step's draw at the old position erases it, which is why no separate erase bit
    exists for the ordinary case.
  - **Hit on Robin** — `$BDA3`: `(column + 2) * 4` vs Robin's X within 8, row `* 8` vs his
    Y within 24; on a hit sets the destroy flag, calls `$BE25` (damage) and `$BF54`
    (border flash).
  - **Hit on a guard** — `$BD49`: the arrow's row is first checked against the fixed band
    `$0A`-`$0D` - not an "in-flight frame" test (there is no such field), but a coarse
    vertical filter that happens to center on a guard's own fixed row (`$0C`), cheaper
    than comparing against every guard's Y individually. Only then does it scan `$AC13`
    for a column match.

  All four objects are cleared on room change by `$C276`'s 7-byte fill at `$C3BF`.
- **Hit by**: `$BD49` (arrow, compares columns) and `$BE43` (sword, bounding box via
  `$BEE3`). Both skip entries whose +4 bit 0 is clear or bit 5 already set, and mark a
  hit through `$BF1A`.
- **No vertical movement at all.** `(IX+$0A)`, the guard's row, is `$50` in all five
  `$AC13` slots in the table's shipped data and is never written on the guard path:
  `$C276`'s rebuild loop sets only `(IX+2/3)` and `(IX+4)`, `$AA31` sets only `(IX+9)`,
  and `$C8F7` only *reads* `[8:10]` when copying down to `[5:7]`. The single
  `LD (IX+$0A)` in the game (`$C30F`) belongs to `$C276`'s Sheriff setup. `$50` is the
  same ground line Robin spawns on, so guards are pinned to it and every guard movement
  is horizontal.
- **Dying animation — `$AC7B`, and why `$AC7F` exists**: the list reads
  `0C 0C 10 11 12 FF 7F AC`, i.e. two turn frames, then front / dying / dead, then an
  `$FF` terminator whose loop pointer is `$AC7F` - so it parks on the dead frame forever.
  `$AC7F` is that same list entered 4 bytes in, directly at the `$12` byte. A fresh kill
  (`$AB42`/`$AB4A`) starts at `$AC7B` and plays the whole sequence; `$C276` re-entering a
  room that already holds a corpse (`$C34A`) starts at `$AC7F` instead, so the corpse
  reappears in its final pose with no death animation replay.
- **Sprite format switches as a guard dies.** Guards index the shared frame base `$8DC4`
  (set at `$AA3E`). Frames `$00`-`$0F` - every walk, turn and aim pose - are header `$03`,
  i.e. **narrow-class row-tuple bitmaps** drawn by `$C6D6`'s own loop, carrying no
  attribute bytes (colour comes from the `$8E1C`/`$E500` stamp). The three death frames
  `$10`-`$12` (`$9A36`/`$9A56`/`$9A76`) are **wide-class glyph-grid** instead, headers
  `$86`/`$86`/`$06`, the last with a real per-cell attribute stream. A port has to handle
  both formats for this one actor. See `Render.md` for the two formats.

Live-traced `$AC13` entry layout (11 bytes, standard object record - `[0]` is the
`$C8F7` countdown byte, generic across every object, not a home-room field as
previously guessed here - that field is actually in `$8A39`, see "Routes" above):
`[2:3]` frame-list pointer, `[4]` status flags, `[5:7]` and `[8:10]` two 3-byte triples.
Offset `[9]` genuinely advances during movement (observed `$63`→`$72` while animating),
so the wrapping-position mechanic applies to ordinary patrol guards, not just Bishop.
`[5:7]` mirrored `[8:10]` in every sample taken. That is `$C8F7`'s erase-then-draw double
buffer, the same mechanism traced on Robin's own record: `[8:10]` is the new frame/X/Y and
`[5:7]` the previous one, and `$C8F7` draws the old, `LDDR`-copies new down into old, then
draws the new — so no saved background is needed. They read identical whenever a guard has
not moved between the two samples, which for a guard updating once every ~16 frames is most
of the time.

On a hit, `$BF1A` sets bit 5 of the status byte and switches the frame-list pointer to
a hit-reaction list. The guard then takes a knockback step (position wrapped through
the `$70` boundary, e.g. `$25`→`$12`) and within about a second its entry stops
updating entirely — consistent with `$C8F7` unlinking it once its countdown expires,
leaving a static "corpse".

**Corpses do persist, and the reason is a 2-row index bias in `$C276`.** `$AC13` itself
keeps nothing - `$C276` really does zero every slot's status byte (`LD (IX+4),$00`) on
each room entry - but the surviving state lives in `$8A39`, and `$C276` never clears the
band Robin is standing in. It calls `$C3FA` twice with *different* inputs: the respawn
loop at `$C282` indexes with `room - $20` (`$C278`), while the live group pointer stored
to `$C54C` at `$C291` indexes with the plain room number. Because a room byte packs as
`(row << 4) | column`, `$C3FA`'s bits 4-5 are the map row mod 4, so the respawn lands on
the band **2 rows away** from the one being entered. The kill flag therefore survives:
`$BF1A` sets `$8A39` byte 2 bit 5, `$AA31` promotes that to the persistent bit 4
(`RES 5`/`SET 4` at `$AB3E`), and on the next entry `$C276`'s rebuild loop reads bit 4
and re-marks the fresh `$AC13` record as already-hit (`SET 5,(IX+4)`, frame table
`$AC7F`). Home column (byte 0) and patrol cursor (byte 1) are untouched, so the corpse
reappears in the same spot.

This matches observed hardware behaviour exactly: stepping out of a room and straight
back - or moving one room in any direction - re-rolls some *other* band, so guards and
corpses hold their positions; only on reaching a room 2 map rows away does that entry
re-roll the original band, giving every guard in it a fresh random home column and
clearing the dead flag. Moving purely along a row never re-rolls your own band at all,
no matter how far. The respawn is a full re-placement rather than a revive: byte 0 gets
a new random column, byte 2 bits 4-5 clear, and byte 1's cursor is left running.

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

The sprite drawn is `$A965`'s wild boar - the "door" in
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
- **Where the gold actually goes**: `$D997` is the same routine that logs Robin's own
  position into the room-position log at `$D543` (see `Objects.md`) - so each of
  Bishop's `$B512` prints also drops a real `$02` entry into that log at his tracked
  position. From there it's the ordinary pickup pipeline: `$D5A7` redraws the icon on
  room re-entry, `$D7F3` collects it when Robin walks over it and pushes `$02` into the
  carried-items queue at `$D595` via `$D94B`, and `$DF03` spends 3 of those `$02`
  slots per Ent transaction (sword, bow, each magic arrow). Bishop's escort death
  doesn't hand gold to Robin directly - it plants pickups the same way the world's
  authored flower/quiver spots do, just triggered by a kill instead of game-start
  placement. See `Objects.md` for the full placement-to-spending pipeline. Note:
  `$D5A1` (the counter that picks/caps the magic-arrow purchases in `$DF03`) counts only
  arrows bought (0-3) - sword and bow are gated solely by their own flags and never touch
  it, so it is not a total-transaction counter.

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
- `$E982`, the live source `$DE5D` refreshes the `$DEAB` entry bodies from, has still not
  been read live and is otherwise undocumented. The data flow is template-select ->
  `$E982` -> entry body, so what actually seeds `$E982` is the remaining gap in the route
  system. (The old "two conflicting readings of `$DEAB`" question is resolved — see the
  Room guards section.)
- `$B919`'s trigger logic — which bits of `$BB9F` gate what.
