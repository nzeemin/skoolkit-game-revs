# Hydrofool Room Format

Reference for the room/level data format in the ZX Spectrum game Hydrofool.
All addresses refer to the 48K snapshot `hydrofool.sna`.

## 1. Overview

Each room is built in two stages when the player enters it:

1. **`$6269`** reads the room's compact description record (§2) and
   extracts its header fields into RAM variables.
2. **`$6295`–`$62F8`** clears and rebuilds the 8×8 room grid (§3) from a
   shared room-type template (§4), then overlays any room-specific "extra"
   objects from the description record. Certain special values spawn
   dynamic objects (§5) instead of writing into the static grid.

## 2. The world: a 6×6×6 cube of rooms

The game world is 6 levels stacked vertically, each a 6×6 grid of rooms —
216 room slots total (about 15 are vacant). Horizontal neighbours (same
level) connect via doors (§3a); vertical neighbours connect via whirlpools
(down) and bubble sources (up).

The room description table (§4) has 216 records (`$00`-`$D7`), one per cube
slot. The in-game room number is 1 higher than its 0-based cube index:

```
n     = room_number - 1
level = n / 36
row   = (n % 36) / 6
col   = n % 6
```
(level/row/col all 0-based; `room_number` is the live value at `$6126`)

The table is divided into 6 contiguous blocks of 36 records each: level 1 at
`$6CCF` (room `$00`), level 2 at `$6DB4` (room `$24`), level 3 at `$6E9B`
(room `$48`), level 4 at `$6F83` (room `$6C`), level 5 at `$706B` (room
`$90`), level 6 at `$718C` (room `$B4`).

### Game start / menu entry points

The title-screen menu offers 4 starting locations, selectable via keys
A/B/C/D (also the four Elvis-song-named locations from the CVG review:
Return to Sender, Jail House Rock, O Sole O Mio, Heartbreak Hotel). `$8567`
is a literal 4-byte lookup table, `$52 $C0 $1A $84`, one starting room
number per entry key in order A/B/C/D:

| Entry key | Room# | Level | Row | Col |
|---|---|---|---|---|
| A | `$52` (82) | 3 | 1 | 3 |
| B | `$C0` (192) | 6 | 1 | 5 |
| C | `$1A` (26) | 1 | 4 | 1 |
| D | `$84` (132) | 4 | 3 | 5 |

## 3. Room grid (`$612C`, 64 bytes)

An 8×8 grid, row-major (`grid_offset = row*8 + col`), representing static
terrain only. Cleared to `$00` by `$6295`, then populated by `$62A2`
onward.

### Static object codes

| Code | Object |
|---|---|
| `$01` | small seaweed |
| `$02` | flat rock |
| `$03` | clam shell (no pearl) |
| `$04` | small rock |
| `$09` | rock |
| `$0D` | seaweed |
| `$7F` | solid wall (always seen as a contiguous 3×3 corner block) |
| `$0A`-`$10` | decorative display cubes/cases (varying item glyph; seen in Plug Rooms, §4b) |

Creatures, pickup items, and the dynamic objects in §5 never appear in the
grid — they're spawned separately and drawn on top.

### Example: room `$2E` (SEA SLUG)

```
        col0 col1 col2 col3 col4 col5 col6 col7
row0:   7F   7F   7F   00   00   09   00   00
row1:   7F   7F   7F   00   00   00   00   00
row2:   7F   7F   7F   00   00   00   00   00
row3:   00   00   00   00   00   00   00   00
row4:   00   00   00   09   00   00   00   00
row5:   00   00   00   00   00   00   00   00
row6:   00   00   00   00   00   00   00   00
row7:   00   09   00   00   00   00   00   00
```
Three `$09` rocks, plus the fixed 3×3 solid-wall corner (§3a).

### 3a. Fixed wall/decoration layout (`$6129`, byte3 bit 6)

`$6129` (0 or 1) indexes a 2-entry pointer table at `$63DE`, selected by
`$642F`. Each layout list has two parts:

1. A sequence of 4-byte records (`count`, screen Y, screen X), each drawn
   via `CALL $8128`, terminated by `$FF`.
2. A sequence of single bytes (grid indices), terminated by `$FF`, each
   poked into the room grid (`$612B + index`, i.e. `grid_offset = index -
   1`) as solid wall (`$7F`).

This is the source of the recurring 3×3 solid-wall corner block seen in
every room grid — it is not part of the room-type template (§4); it's this
fixed, `$6129`-selected layout, applied uniformly on top of whatever the
type template drew.

## 4. Room description record (table at `$6CCF`)

Room *N*'s record is found by walking *N* variable-length records from the
table start (`$6269`).

| Offset | Field | Meaning |
|---|---|---|
| `+0` | `byte0` | Record length in bytes (offset to the next room's record), including this header. |
| `+1` | `byte1` | Door/exit bitfield. Stored to `$612B` (after merging by `$6329` — §4a). Bits 0-3 each control one door's graphic, drawn by `$6344`/`$6377`. |
| `+2` | `byte2` | Bits 4-7: room type (0-15), stored to `$612A`. Selects the grid template (§5) via the `$72B1` pointer table, and doubles as the room's creature/inhabitant index. |
| `+3` | `byte3` | Bit 6: room shape/layout selector (0 or 1), stored to `$6129` (§3a). Bits 0-5 (`byte3 AND $3F`): a 6-bit index into the room/creature title table at `$73B5` — selects the message-window title text ("DEATHBOWL", "PIRANHA", "SEAHORSE", ...), printed by `$65FD`. |
| `+4..` | extra pairs | If `byte0 > 4`: room-specific `(index,value)` pairs, same format as a room-type template's pairs (§5) — appended on top of the shared template when the grid is built. |

### 4a. Byte1 — the door/exit bitfield

`byte1` (stored to `$612B`) is a 4-bit door bitfield. `$6329` re-reads it
from the room description, merges bit 4 into bit 0 and bit 7 into bit 3
(folding two legacy bit positions into the 4 that matter), writes the
result back into both the room description and `$612B`.

Doors are not part of the dynamic-object system (§5) — they're drawn
directly during room construction, as fixed graphics at fixed screen
positions:

- `$6344` tests bits 0 and 3 — a single-piece door each, drawn via `CALL
  $8128`.
- `$6377` (calls `$6344` first) tests bits 1 and 2 — a three-piece door
  each, also via `CALL $8128`.

The number of bits set is a direct exit count. Bit-to-direction mapping,
from the room-move routine `$67F1` (reads a direction code from `$8DC1`,
tests one bit of `$612B` per direction before allowing the move):

| Bit | Direction | Room-number delta |
|---|---|---|
| bit 0 | North | `-6` (row − 1) |
| bit 1 | East | `+1` (col + 1) |
| bit 2 | South | `+6` (row + 1) |
| bit 3 | West | `-1` (col − 1) |

**Vertical** room transitions (whirlpool down / bubble source up) go
through a different routine, `$8A87`, which computes `$6126 - $24` (-36,
one level down) or `$6126 + $24` (+36, one level up) — the cube's
level-stride. It special-cases room numbers 1 and 2 (reason unconfirmed).

## 5. Room-type templates (`$72D1`–`$73B4`) and the extra-object encoding

`$612A` (the room's type, 0-15) indexes a 16-entry pointer table at `$72B1`
(2 bytes/entry) to find one of 11 distinct template blocks (types 9-14
share the same template).

### Template format

```
byte0: total byte count of this template block (matches the address gap
       to the next template's pointer)
byte1..byteN: a sequence of (index, value) pairs
```

Both the shared template and a room's own "extra" bytes (§4, `+4..`) use
the exact same pair encoding, consumed by the same routine (`$62C8`),
called once per sequence from `$6269` (template pass via `$62A2`, extras
via `$62BB`):

- `index`: a grid-cell position. Target address = `$612B + index`, i.e.
  `grid_offset = index - 1` from the grid's base (`$612C`).
- `value`: either a plain static terrain code (§3) stored directly at that
  grid cell, or one of `$66`/`$67`/`$68`/`$69`/`$6A`/`$6B`, which instead
  triggers a dynamic-object spawn (§6) and leaves the grid cell at `$00`.
- The pair count comes from the byte-count prefix via a `DJNZ`-driven loop,
  2 bytes/iteration — except that a special-value pair consumes 2
  *additional* bytes beyond its own pair, and its spawn routine forces the
  loop counter down by 2 more to compensate (§6.2). This is why a record's
  trailing byte count doesn't always come out even.

### Template sizes

| Type | Address | Bytes |
|---|---|---|
| `$0` | `$72D1` | 19 |
| `$1` | `$72E4` | 15 |
| `$2` | `$72F3` | 39 |
| `$3` | `$731A` | 15 |
| `$4` | `$7329` | 21 |
| `$5` | `$733E` | 17 |
| `$6` | `$734F` | 19 |
| `$7` | `$7362` | 39 |
| `$8` | `$7389` | 23 |
| `$9`-`$E` | `$73A0` | 19 (shared by all 6 types) |
| `$F` | `$73B3` | 2 |

## 4b. The four Plug Rooms

Room type `$F` is used by exactly 4 rooms in the entire table, all with
title index 8 ("PLUG ROOM"):

| Room | Address | Level | Row | Col |
|---|---|---|---|---|
| `$32` | `$6DFB` | 2 | 2 | 1 |
| `$65` | `$6F4F` | 3 | 4 | 4 |
| `$9B` | `$70B8` | 5 | 1 | 4 |
| `$D8` | `$7276` | 6 | 5 | 5 |

Type `$F`'s template (`$73B3`, 2 bytes: just the length byte + 1 more) is
too short to hold a real `(index,value)` pair — the Plug Rooms are static
-content-free apart from their room-specific extras.

Every Plug Room's extras follow the same pattern:

```
$32 extras: $13,$0F,$17,$0E,$33,$0E,$37,$0F, $25,$6B,$25,$69
$65 extras: $13,$0B,$17,$0C,$33,$0A,$37,$0B, $25,$6B,$25,$69
$9B extras: $13,$10,$17,$10,$33,$10,$37,$10, $25,$6B,$25,$69
$D8 extras: $13,$0F,$17,$0E,$33,$0E,$37,$0F, $25,$6B,$25,$69
```

- The first 4 pairs place decor cubes (§3) at grid offsets `$13`/`$17`/
  `$33`/`$37` — a symmetric 4-corner layout (`(row,col)` = `(2,2)`,
  `(2,6)`, `(6,2)`, `(6,6)`), values in the `$0A`-`$10` range.
- The last pair, repeated with two different values at the same grid index
  `$25`, spawns a Plug (`$6B`) and a Whirlpool (`$69`) co-located at the
  same cell (§6.3).

Per the game's instructions: *"the gigantic planetary aquarium ... is now
so polluted that the only remedy is to completely empty it of water by
pulling each of the four main plugs."* These 4 rooms are the win-condition
rooms: each corner cube represents an item still owed to that room, and
delivering all 4 pops the plug — see `Items-Combat-Format.md` §4-§5 for
the full delivery-detection and win-trigger mechanism (including the score
counters it drives).

## 6. Dynamic objects — one unified object system

Everything that moves or can be interacted with — the player, the room's
creature, snakes, bubbles, whirlpools, plugs — is the same kind of entity:
a 24-byte **object record** with a room byte, a swappable behaviour-handler
pointer, and a position, linked into one **active-object chain** that the
per-frame dispatcher (`$983C`) walks.

- **Chain head**: `$610E` points at the most recently spawned object.
  Each record's `+0/+1` links to the next; the chain ends via three fixed
  (statically allocated) records: the **player** at `$8DB6` → `$8DCF` →
  `$8DEF` → `$0000`.
- **Pool**: spawned objects live in slots at `$A900` onward, recycled
  through a free list (head at `$618B`; the free list can extend outside
  the pool — observed pointing into scratch at `$5B00`).
- **Insertion point = list position**: the allocator (`$84AE`) head-inserts
  at whatever pointer it's handed in `IX`. Most spawns pass `$610E` (front
  of chain); the creature spawn passes `$8DEF` (a fixed record's own link
  field), splicing the creature in *after* the player — processing order
  is controlled by choosing the insertion point.

### 6.0 The player is an object record (`$8DB6`)

| Offset | Live value (room `$2E`) | Meaning |
|---|---|---|
| +0/+1 | `$8DCF` | link to next record |
| +2 | `$2E` | current room (mirrors `$6126`) |
| +3/+4 | `$8968` | **player per-frame handler** — swappable: `$955A` tests `($8DB9)==$8968` ("normal state?"), `$9564` swaps in `$8D11` (alternate state). Handler-swapping on the player record is how player states are implemented. |
| +5/+6 | `$34,$34` | player Y/X — the `$8DBB`/`$8DBC` bytes referenced by proximity checks throughout the code |
| +16..+19 | `$32,$32,$35,$35` | previous/target position pair (probable) |

`$8968` being the player handler explains its special cases (ending-room
check, the vertical room transitions at `$8A87`, etc.) — it's simply the
player's per-frame behaviour, dispatched like any other object's.

The other two fixed records: `$8DCF` (purpose unidentified) and `$8DEF`
(the creature insertion point; its link reads `$0000` when the room has no
creature). Both get their state blocks (+2 onward) re-initialized with 22
bytes from `$5C92` by `$8F82` during room setup. Two further fixed records
were observed at `$8E0F` (handler `$9471`) and `$8E27` (handler `$949E`) —
identities not yet known.

### 6.0a The room's creature

`$6663`, called during room build, spawns the room's creature: `IX=$8DEF`
into `$84AE`, handler **`$9341`**. The creature type comes from the room
description's `byte2` (§4). `$9341` is not a simple creature AI — it's
dual-purpose (item-delivery detector in Plug Rooms, settle physics + hit
detection elsewhere) — see `Items-Combat-Format.md` §4.

### Special grid values

Special grid values (`$66`-`$6B`) in the template/extras stream don't
populate the static grid. Instead they spawn an object into this system.

### 6.1 Special values, spawn routines, and object types

| Value | Spawn routine | Handler | Object |
|---|---|---|---|
| `$66` | `$8EA7` | `$957C` | Source of bubbles (weak/incomplete variant) |
| `$6A` | `$8EA7` | `$957C` | Source of bubbles (full-strength variant) |
| `$67` | `$8EF2` | `$94EE` | Plant/coral (decoration) |
| `$68` | `$8E3F` | `$9684` | Rearing snake |
| `$69` | `$8F1E` | `$952D` | Whirlpool |
| `$6B` | `$8F4C` | `$94F4` | Plug |

All 5 spawn routines share the same underlying mechanism (§6.2); they
differ in what fixed values they write into the new object's slot fields
before/after calling the allocator, and in their handler's per-frame
behaviour.

**Identification method**: `$6B`/`$69` were identified structurally — `$6B`
appears in exactly the 4 Plug Rooms' extras and nowhere else game-wide
(never in any shared template), and `$69` is co-located with `$6B` at the
same grid cell in every Plug Room. `$66`/`$67`/`$69`/`$6A` were confirmed
via their animation sprite-number tables (§6.4), matched against
independently-identified sprite graphics. `$68` was confirmed via its
handler's sprite-number sequence matching the "Snake, rearing phase"
sprites (§6.6).

### 6.2 Spawn mechanism (`$8EA7`, `$84AE`)

`$8EA7` (the `$66`/`$6A` spawn routine, traced in full — the other 4 share
the same mechanism):

1. Self-modifies its own later instruction so the object's "kind" byte
   matches the triggering value.
2. Clears the grid cell to `$00`.
3. Reads 2 more bytes from the stream beyond the normal `(index,value)`
   pair. These aren't accounted for by the outer `$62C8` loop's own `HL`
   advancement — instead, `$8EA7` forces two extra `DEC B`s to end that
   loop one iteration early to compensate. (Example: room `$52`'s extras
   have 3 leftover bytes after its 4-byte header; its single special pair
   `$37,$6A` consumes only 2 of them — the double-decrement ends the loop
   before the 3rd byte is read.)
4. Sets `IX=$610E` (the active-chain head) and calls `$84AE` to allocate an
   object slot.
5. Populates further slot fields: offset `+7=$18`, `+0xA=$06`,
   `+9=`(triggering value), `+0xB` and `+0xE=`(first extra byte),
   `+0x14=`(second extra byte).
6. Calls `$9A60` to finalize.

`$84AE` — the object allocator:

- `$618C` (byte): if zero, takes an early-exit path — no object is
  allocated.
- `$618B` (word): free-list head pointer. Each free slot's first 2 bytes
  point to the next free slot.
- Pops the next free slot off the free list, then **head-inserts it into
  the active chain at the insertion point `IX`**: copies the old head word
  from `(IX+0/1)` into the new slot's `+0/+1` link field, writes the new
  slot's address back to `(IX+0/1)`, then switches `IX` to the slot's own
  address.
- Stores the current room number (`$6126`) at slot offset `+2`.
- Every `CALL $84AE` site has 2 bytes immediately after the call — the
  hardcoded per-object behaviour-handler address (§6.1's table). On
  success, `$84AE` pops the return address (pointing at those 2 bytes),
  copies them as literal data into slot offset `+3`/`+4` via `LDI`/`LDI`,
  then resumes execution 2 bytes past the `CALL` either way. These 2 bytes
  are never executed as code on either path.
- Copies a fixed 19-byte block from `$5C92` into the rest of the slot.
- Returns with `IX` = the new slot's address.

`$983C` — per-frame object dispatcher: walks the active-object chain
(pool slots, player, creature alike); for each record, compares offset
`+2` (owning room) against the current room and skips it if it doesn't
match, otherwise calls the handler at offset `+3`/`+4`.

### Object record layout (pool at `$A900`; same layout for the player)

| Offset | Field |
|---|---|
| `+0`/`+1` | Link to the next object record in the active chain |
| `+2` | Room number the object belongs to |
| `+3`/`+4` | Per-object behaviour-handler function pointer (swappable) |
| `+5`/`+6` | Y/X position |
| `+5`..`+23` | Initially a fixed 19-byte default state block from `$5C92` |
| `+7` | `$18` (constant, set by `$8EA7`-style spawn routines) |
| `+8` | Current sprite number (confirmed for snakes: `$23`-`$26`) |
| `+9` | Triggering grid value; cleared to `$00` after finalization |
| `+0xA` | `$06` (constant) |
| `+0xB`, `+0xE` | Duplicated "first extra" byte from the template pair |
| `+0xF` | Animation phase counter (used by `$99D5`) |
| `+0x14` | "Second extra" byte from the template pair |

### 6.3 `$66` vs `$6A` — real vs. weak bubble source

`$957C` (the bubble-source handler) periodically spawns a child object
(handler `$9602`) — the individual rising bubble particle, separate from
the stationary bubble-source icon. The child inherits the parent's
triggering value (`$66` or `$6A`) and `$9602` branches on it:

- `$6A`-triggered bubbles: set a flag bit (bit 4 of `+0x0D`) and switch to
  a movement table that steps position at double the rate of the default
  (`$66`) table.
- That flag is later tested right after the sprite is drawn; only if set
  does a second flag (bit 6) get set.
- Bit 6 being set causes the bubble to immediately self-destruct (a clean
  completion state).

Only `$6A`-triggered bubbles ever reach that clean completion state; `$66`
bubbles never do. This is a real functional difference, not cosmetic — a
full-strength bubble stream that reaches the top and completes (`$6A`) vs.
a weak one that never does (`$66`), consistent with some bubble sources not
lifting the player all the way.

### 6.4 Animation sprite tables (`$99D5`)

`$957C`, `$94EE`, and `$952D` each drive their object's animation through
`$99D5`: `HL` points at a small per-object table of raw sprite numbers;
`$99D5` reads the next byte, indexed by a per-object phase counter at slot
offset `+0x0F` (auto-incremented each call). `$FF` in the table means "wrap
to the start"; `$FD` is a second special marker. Otherwise, the byte read
is the next sprite number to display.

| Object | Handler | Table | Sprite numbers | Sprites |
|---|---|---|---|---|
| Whirlpool | `$952D` | `$9526` | `$4C,$4C,$4D,$4D` | `$BDAE`/`$BDEE`, "Whirlpool, animation phase" |
| Source of bubbles | `$957C` | `$9577` | `$68,$68,$69,$69` | `$C38E`/`$C39E`, "Bubble" |
| Plant/coral | `$94EE` | `$94E9` | `$4E,$4E,$50,$50` | `$BE2E`/`$BEEE`, "Plant/coral" |

### 6.5 `$8128` — sprite draw

Called by door drawing (§4a), the fixed wall layout (§3a), and object
handlers. Parameter convention only partly traced: `A` selects a graphic
via a table at `$6C06`, `DE` is screen position; `$8126`/`$8127` (flagged
elsewhere as holding a sprite number) and `CALL $84ED` (load sprite record
by number, §6.7) are involved but the exact indexing isn't fully resolved.

### 6.6 `$68` — Rearing snake

`$9684` (the `$68` handler) drives its sprite number directly rather than
through `$99D5`:

- On spawn, `$8E3F` sets the sprite number to `$23`.
- `$9684` cycles the sprite `$23` → `$24` → `$25` → `$26` while
  incrementing position by `+8` each step (rising), then back down `$26` →
  `$23` while decrementing position by `-8` (retracting) — a full
  rise/pause/retract/pause loop, gated by countdown timers between phases.
- Sprites `$23`-`$26` are independently labeled "Snake, rearing phase",
  with sizes increasing monotonically: 16×8 → 16×16 → 16×24 → 16×32 — more
  of the snake's body visible as it rises.

### 6.7 Sprite loading (`$84ED`, `$A5DC`, `$7E4F`)

`$A5DC` is a table of 201 sprite records, 4 bytes each: `+0`/`+1` = sprite
graphic data address, `+2` = height in 8px rows (bit 7 masked off before
use), `+3` = width in 8px columns (bit 7 is a live flip-flop flag, toggled
in place on each use — meaning depends on caller).

`$84ED` loads a sprite record by number (input: `L`) into the "current
sprite" scratch variables at `$618D`-`$6190`, ready for `$8128` to draw it.

`$7E4F` builds a horizontally-mirrored copy of a sprite's graphic data
(bit-reversed within each byte, byte order reversed) in place, using the
toggling flip-flop bit in `$A5DC` record byte 3 to alternate between normal
and mirrored draws on successive calls.

## 7. Special / non-navigable rooms

Room `$01` is the special ending/winning room, forced via room `$6126=$01`:
a walless room (floating rocks/seaweed and the player sprite) with a
"DEATHBOWL DIVINED" stats screen overlaid — score percentage, "Score
Scraped", "Plugs Pulled" (`$6124`), "Goodies Gathered" (`$6123`), "Gnomes
Gnabbed" (`$6122`) — see `Items-Combat-Format.md` §1 for the counters.
Normally
reached via the final whirlpool after solving the game's last puzzle, not
through ordinary cube navigation. Its record is the first entry in the room
description table.

### The "no walls" mechanism

Rooms `$01` and `$02` are the only two rooms using type `$E`, and share a
special-cased "no walls" rendering path. The room-draw routine `$676D`
checks whether the current room is 1 or 2, and if so skips:

- the fixed wall/layout draw (§3a)
- the door-graphic draw (§4a)
- the message window (`$65DB`)
- several creature/object placement calls

The room's grid contents (rocks, seaweed, etc.) are still drawn via a
separate, non-skipped path.

Room `$01` gets one further special call that room `$02` does not: `$86CC`
(gated on `room==1`) — the routine that draws the "DEATHBOWL DIVINED"
end-game stats overlay. Room `$02`'s purpose (same "no walls" treatment,
without the stats screen) is not yet confirmed.

## 8. Open questions

- What do the two "extra" template bytes actually encode? (screen
  position, direction, linked room, something else) For the one bubble
  source fully traced (type `$0`, template index `$1C`), they were `$37`
  and `$40`.
- What do the `$0A`-`$10` decor-cube values (§4b) actually look like on
  screen? Not yet catalogued individually.
- What does `$9A60` do? The two roles previously attributed to it — writing
  the handler address into slot `+3`/`+4`, and linking the object into the
  active chain — both turned out to happen inside `$84AE` itself. Observed
  effect: slot `+9` (triggering value) reads `$00` afterwards. Internals
  not traced.
- What do `$9602`'s and `$9684`'s unidentified sub-calls do (`$9B5D`, the
  player-position proximity checks)?
- What is `$618C`'s early-exit path for, exactly?
- Why does `$8A87` (vertical room transition) special-case room numbers 1
  and 2 instead of using its generic `±36` arithmetic?
- ~~How are pickup items tracked?~~ RESOLVED for persistence (a 4-byte
  `(room,Y,X,sprite)` table, room zeroed on pickup) and for the
  pick-up/drop control flow (`$8AFB`) — see `Items-Combat-Format.md`
  §2-§3. Still open: how items/decorations are actually *spawned* per room
  (a separate `$75B5`-region table with per-type handler words, not yet
  connected to the persistence table).
- What are the fixed object records at `$8DCF`, `$8E0F` (handler `$9471`)
  and `$8E27` (handler `$949E`)?
- What are the player record's `+16`..`+19` fields exactly (previous/target
  position pair is a guess)?
- `$8128`'s exact parameter/indexing convention (§6.5) isn't fully
  resolved.
