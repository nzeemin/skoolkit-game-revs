# Room Format

## World map

World map in hex room numbers:

```
07 08 09 0A 0B 00 01 02 03 04 05 06
13 14 15 16 17 0C 0D 0E 0F 10 11 12
      21 22 23 18 19 1A 1B 1C 1D 1E 1F 20
               24 25 26 27 28 29 2A 2B 2C
               30 31 32 33 34 35 36 37 38 39 3A 3B
               3C 3D 3E 3F 40 41 42 43 44 45
```

$14 = start room
$12 = telescope room

## Room numbering

Rooms are numbered `room = level*12 + col`, where `level` is 0-5 (6 vertical
levels) and `col` is 0-11 (12 rooms per level, wrapping horizontally: col 11+1
wraps to col 0 on the same level). Confirmed live via the Emu80 MCP debugger
across all 4 directions (right/left/up/down) and a fall-into-well transition.

- `$5C01` holds the current room number.
- `$AEEF` decodes a room number to (row, col) via divmod by 12 (`B`=row,
  `C`=col).
- `$AEFD` encodes (row, col) back to a room number (`room = B*12 + C`).
- Edge-transition handlers: `$A671` (right), `$A640` (left), `$A69B` (up a
  level, blocked at row<0), `$A6AE` (down a level, blocked at row=6 -
  confirms exactly 6 levels).
- **Portal rooms**: a 5-entry table at `$A66C` ($2D, $2E, $2F, $46, $47)
  lists rooms that, on exit-right, jump straight to a fixed room ($29)
  instead of normal col+1 math. Likely how the special "space visualization"
  (SP) room seen on player-made maps connects in.
- Confirmed max room number seen: $45 (69 decimal) - 70 rooms total ($00-$45).
  The game has 66+ rooms per a player-made map; the exact count including any
  unreachable/unused table slots isn't nailed down.

See the World map section above for the player-mapped layout with room numbers filled in.

## Room data table ($C152, 12 bytes/room)

See `Actors.md` for what happens to these slots after decoding: per-type
spawn dispatch ($BE98/$BECA), the shared object-record format ($5B04-based
array), and the movement/collision/behavior primitives creatures actually
run on. Note there's a *second*, separate room-tagged creature/encounter
table at $B99D (31 entries, own format) feeding a different pair of object
slots ($5C0E/$5C13) via $B93F/$B95F - not indexed by room number the way
this table is, and not covered by this section. See Actors.md's Creatures
section for both.

Indexed directly by room number. Decoded by `$BE42`. Each room has **3
creature/hazard slots**, 4 bytes each:

- byte0 low nibble: creature/hazard type ID
- byte0 bit7: flag (meaning unconfirmed)
- byte0 bits4-6: a 3-bit field (meaning unconfirmed)
- byte1: creature Y position (tentative - see below)
- byte2: creature X position (tentative - see below)
- byte3: low 7 bits + bit7 decoded separately (meaning unconfirmed)

An all-zero sub-record means the slot is empty.

**Confirmed creature type IDs** (from byte0 low nibble):
| Nibble | Creature |
|---|---|
| $01 / $03 | Flying Lizard (two nibble variants seen, likely same creature/animation state) |
| $05 | Water Drop |
| $07 | Tentacles in concrete block |

Confirmed live: room $08 has 2 Water Drops (both same byte1, different
byte2 - consistent with two drips from the same ceiling height at different
X positions). Room $12 has 0 creatures. Room $14 (start room) has a
Tentacles-block + a Flying Lizard.

**byte1/byte2 as Y/X**: within a room, byte1 tends to cluster tightly across
slots (e.g. both Water Drops in room $08 share the exact same byte1), while
byte2 varies widely. That's the expected signature for Y (drops share a
ceiling height, creatures share a rough ground level) vs X (spread across the
room's width). Not fully confirmed - the exact coordinate system (pixel vs
character-cell) isn't pinned down.

## Room background: back tiles and tiles

Two-level tile system, confirmed live to match a player's description of a
32x16-character screen:

- **Back tile**: a 32x32px (4x4 character) block. Each room has 32 back-tiles,
  arranged 8 across x 4 down (see $D600 table below).
- **Tile**: an 8x8px (1 character) block. Each back-tile expands to a 4x4
  arrangement of tiles.

### $D600 - per-room back-tile index table

32 bytes per room (8x4 back-tile indices), indexed directly by room number
(`$D600 + room*32`). Confirmed for all 70 rooms ($00-$45).

Back-tile index range observed across all rooms: **$00-$F4** (0-244). $00 is
by far the most common (empty background).

### $C600 - back-tile definition table

16 bytes per back-tile index, `$C600 + index*16`. Table spans exactly
$C600-$D5FF (4096 bytes = 256 possible entries, index $00-$FF) - lines up
exactly with $D600 being the very next table. All 256 slots have B-lines in
the ctl now, even though only indices up to $F4 are actually used by any
room.

Each 16-byte back-tile definition is very likely a 4x4 arrangement of 8x8
**tile** indices (not raw pixel data - 16 bytes is too small to be 16 rows of
pixels for a 4-row-tall shape, but fits perfectly as "16 single-byte tile
indices" for a 4x4 grid). Decoded and copied by `$9914` into a 32x16 room
tile-index map at `$F800`.

### $F800 - room tile-index map

32x16 bytes (one per 8x8 tile position on screen), built fresh each time a
room loads by `$9914` expanding the room's 32 back-tile indices through the
$C600 definitions.

### $99A4 - blit $F800 to the real screen

Found. Iterates 512 times (32x16, one per tile position - loop exit checks
`BIT 1,H` on an HL counter, stopping at H=2 i.e. HL=512). For each tile:

- Reads the tile index from `$F800`.
- Looks it up in a 256-byte table at **$DF00** to get an attribute byte,
  written to the attribute file (`$5800 + ...`).
- Looks up an 8-byte pixel bitmap at **`($5B72) + tile_index*8`** and copies
  it to the real screen bitmap address, one byte per pixel row.

So there's no separate "tile bitmap table" address - tile pixel data lives
wherever `$5B72` currently points (set to `$F000` at game init, `#R$8F47`),
8 bytes per tile index. `$DF00` is the tile-index -> attribute/color lookup.

## Room setup dispatcher ($9855 / $9880 / $9914)

Called every time `$5C01` changes (edge transition, respawn, or game init) -
this is the "build new room" entry point:

- `$9855`: entry point. Room-number based special-case check via a
  bit7-terminated list at $9AF5, then falls through to $9880.
- `$9880`: per-room setup - selects music track (15-entry table at $9AC6),
  clears/rebuilds a 31-byte command/animation list at $9AD5 via `$9A8C`,
  resets several per-room counters, tunes `$A6F5` for room $10 (=6, default
  7), and for room $1C (if `$5C24` set) initializes a 12-entry moving-lift
  table at $F808 (pointers to $9998, stride 31 - ties to sprite #31 "Lift").
- `$9914`: builds the room's tile background (see above).

## Related memory files

- `project_terramex_map.md` - player-made world maps, 6-level/12-column
  layout facts.
- `Items-Format.md` - the $8400 sprite/item table and inventory log at
  $5B7C.
- `Actors.md` - hero input/movement/status-code machinery, and creature
  spawn dispatch + behavior primitives fed by the $C152 table above.
