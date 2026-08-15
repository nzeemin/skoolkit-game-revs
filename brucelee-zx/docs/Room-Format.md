# Room Format

How a room (level screen) is stored, and how it is unpacked and drawn when the
player enters it. The routine that does all of this is `prepare_level` (`$C16E`).

## Rooms table

`rooms_table` at `$6400` is an array of 20 word pointers, one per room. The
current room number lives in `current_room` (`$FE03`); the game indexes the
table by `room * 2` to get the address of that room's descriptor.

```
room descriptor address = (word at $6400 + current_room*2)
```

## Room descriptor

Each descriptor is a 64-byte header immediately followed by the room's
run-length-encoded tile data. `prepare_level` copies the 64-byte header into the
working area at `current_room_playing_data` (`$6000`), so all header field
addresses below are given as their live `$60xx` address (offset from `$6000`).

| Offset | Addr  | Size | Field |
|--------|-------|------|-------|
| +$00   | $6000 | 2    | Address of the room's scene graphics primitives |
| +$03   | $6003 | 1    | Colour palette selector |
| +$06   | $6006 | 2    | Address of the room's extra data (key placement list) |
| +$08   | $6008 | 4    | Respawn point: X, Y, direction, 0 |
| +$0C   | $600C | 2    | Per-player "visited" flags (byte 0 = player 1, byte 1 = player 2) |
| +$0E   | $600E | 4    | Zone thresholds: X1, X2, Y1, Y2 |
| +$12   | $6012 | 27   | Exit table: 9 zones × 3 bytes |
| +$2D   | $602D | 19   | Additional room configuration |
| +$40   | $6040 | ...  | RLE tile data (unpacked in place to the tile map) |

The descriptor bytes not listed (+$01, +$02, +$04, +$05, +$07, +$0B) are used but
their exact meaning is not yet pinned down.

## Tile map

The live room layout occupies `$6040`, **22 rows × 32 columns = 704 bytes**, one
byte per 8×8 cell. Each byte is an index; the scene-drawing code
(`draw_scene_element`, `$C2C0`) turns it into an 8×8 graphic. Tile pixel data
lives at `$9800` and the per-tile colour lookup at `bktile_colors` (`$6300`).

## RLE encoding

The compressed tile data starts at descriptor offset +$40 and is unpacked into
the tile map at `$6040` by the loop at `room_extract_loop` (`$C197`). It is a
simple byte stream:

| Lead byte | Meaning |
|-----------|---------|
| `$00`     | End of data |
| `$01`–`$7F` (n) | Repeat the **next** byte `n` times |
| `$80`–`$FF` (n) | Copy the next `n - $80` bytes literally |

After unpacking, `$6000`–`$62FF` (768 bytes: header + first part of the map) is
copied to a shadow copy at `$5D00`, used as the untouched background reference
while the game later repaints tiles.

## Exits and zones

The screen is divided into up to **9 exit zones** — a 3×3 grid formed by two X
thresholds (`$600E`, `$600F`) and two Y thresholds (`$6010`, `$6011`). When a
character walks off the edge of the room, the main loop (`$C714`, from `$C875`)
works out which zone it left through, counting how many X and Y thresholds its
position passed:

```
zone = (X thresholds passed: 0..2) + 3 * (Y thresholds passed: 0..2)   ; 0..8
```

That zone indexes the 3-byte exit table at `$6012`:

```
entry = $6012 + zone*3   ->   [ new room number, spawn X, spawn Y ]
```

A new-room byte of `$FF` means "no exit here" (the character has fallen out of
the world rather than walked to an adjacent room). Otherwise the new room number
is stored for that player and the room is reloaded via `$C790` with the
character placed at the given spawn coordinate.

## Key placement (room extra data)

The pointer at `$6006` gives a per-room list of collectable objects (keys, lamps,
etc.) to drop into the tile map. `place_keys_loop` (`$C1C0`) walks the list,
placing each object's tile at its folded map coordinate:

- A leading byte of `$FF` ends the list.
- Bit 7 of an entry's first byte marks a **respawning** object — one that
  reappears even after being collected.
- For a normal object, the entry's first byte is ANDed with the active player
  number (`$FE04`); a zero result means the object belongs to the other player
  (or is already taken) and the entry is skipped.
- Otherwise the entry's coordinate is folded (the standard row/column bit-fold
  used throughout the tile code) into an offset into the `$6040` map, and the
  object's tile byte is written there.

## Load sequence (`prepare_level`, `$C16E`)

1. Look up the descriptor from `rooms_table` by `current_room`.
2. Copy its 64-byte header to `$6000`.
3. Mark the room visited for the current player (`$600C`/`$600D`).
4. RLE-unpack the tile data into `$6040`.
5. Copy `$6000`–`$62FF` to the `$5D00` shadow background.
6. Place the room's keys/objects from the extra-data list.
7. Draw every tile of the scene into the offline buffer, then clear the
   per-character state ready for play.

## Open questions

- Exact meaning of header bytes +$01, +$02, +$04, +$05, +$07, +$0B.
- Precise byte layout of a single key-list entry (the skip path advances a
  variable number of bytes, so entries may not be fixed-length).
- What the "scene graphics primitives" pointer (+$00) indexes, versus the tile
  pixel data at `$9800`.
- Meaning of the 19-byte "additional room configuration" block (+$2D).
