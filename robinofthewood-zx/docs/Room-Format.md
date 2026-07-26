# Robin of the Wood — Room Format

Data formats for the world map, room types, additional elements, and blocks. Runtime rendering (shadow screen, sprites, object system) is covered in `General.md`.

## World map — `$79F9`

320 bytes (16 columns x 20 rows), one byte per room — see `$79F9`. Index = room number (packed 16-bit: high nibble = column 0-15, rest = row 0-19; see `General.md`).

Byte layout:

- **bits 0-6**: room type, `$00`-`$26` (39 types)
- **bit 7**: flag, read by `$C072` when drawing the room (affects which additional-room-elements table entry attribute constant is used — `$3838` vs `$4850` at `$C072`/`$C300`) and elsewhere as a horizontal-mirror indicator for the room's blocks

Two of the 320 cells are unused (318 real rooms).

## Room type descriptors — `$7B39`

39 entries, `$00`-`$26`, one per room type. Each entry:

```
count:  1 byte  — number of tokens that follow
tokens: count x 2 bytes
```

Entries are variable length and packed sequentially (no fixed stride) — to reach entry N, walk forward from the start summing `2*count+1` for each preceding entry (this is what `$C1C1` does, given a target index in `$C547`).

## Additional room elements — `$8511`

Indexed by **room number** (not room type) — 256 entries, `$00`-`$FF`, one per room in that range. Same per-entry format as room type descriptors (count byte + count*2-byte tokens; `$00` count = no additional elements). Rooms `$0100`-`$013D` (256-317) have no entries — `$C072` returns early when the room number's high byte is non-zero.

A room is drawn as: room-type tokens, then (if the room number is < 256) additional-element tokens on top.

## Token format

Each token is 2 bytes: **coordinate byte** + **block number**.

Coordinate byte:
- bits 0-2: X, in units of 4 character-cells (0-7 → columns 0,4,8,...,28)
- bits 3-7: Y, character row 0-17

Block number: index into the block table (see below); bit 7 of the block number selects horizontal mirroring for that placement (consumed by `$C0D1`/`$C1D6`).

## Blocks — `$5BA8`

Blocks are the actual graphic tiles placed by tokens, always 4 character-cells (32 pixels) wide. Table of block addresses at `$5B00` (pointer table, one entry per block) points into the block data starting at `$5BA8`.

Each block:

```
header: 1 byte  — see below
pixels: (header AND $1F) x 8 rows, 4 bytes each (32 pixels/row)
attrs:  (header AND $07) rows, 4 bytes each — or 1 byte total if the flat-attribute flag is set
```

Header byte, decoded by `$C0D1`:

| bits | meaning |
|---|---|
| 7 | natural-mirror flag — XORed with the placing token's own mirror bit (bit 7 of the block number) and the room's world-map bit 7 to decide whether to mirror this instance at draw time |
| 6 | flat-attribute flag — 1: a single attribute byte is read once and reused for every attribute cell in the block (the source stream advances only once); 0: one 4-byte attribute row is read per row |
| 5 | unused (not read anywhere in `$C0D1`) |
| 0-4 | pixel row count, `pixel_rows = (header AND $1F) x 8` |
| 0-2 | (reused) attribute row count, `attr_rows = header AND $07` |

Pixel row count and attribute row count share header bits 0-2, so a block's attribute-row count is always congruent to its pixel-row-count-divided-by-8, mod 8.

Verified against the raw block data: block `$00` (header `$04`) has 32 pixel rows (128 bytes, exact) and 4 attribute rows (16 bytes, exactly filling the gap before block `$01`); blocks `$01`/`$02`/`$0A` check out the same way (16 pixel rows/64 bytes with 2 attribute rows/8 bytes; 8 pixel rows/32 bytes with a flat 1-byte attribute).

If the mirror flag ends up set for a placement, `$C1D6` bit-reverses each pixel byte (via the table at `$FD00`) and swaps bytes from the two ends of each row inward, doing the same for the attribute row(s) unless the flat-attribute flag is set.

## Drawing pipeline

1. `$C072` (draw current room): looks up the map byte, sets up the room-type descriptor pointer (`$7B39`) and index (`$C547`), clears bit 7, calls `$C0AF` to draw room-type tokens, then (if room number < 256) repoints to the additional-elements table (`$8511`) and calls `$C0AF` again.
2. `$C0AF` (draw given room type): walks the token list — reads count, then for each token calls `$C0D1` to draw the block.
3. `$C0D1` (draw one block): looks up the block's pixel data address via the table at `$5B00`, computes the shadow-screen pixel address (`$EB00`) from the token's coordinate byte, copies pixel rows, then computes the shadow attribute address (`$E800`) and copies attribute rows. If the block number's bit 7 is set, calls `$C1D6` first to horizontally mirror the block's pixel and attribute bytes in place (using the bit-reverse table at `$FD00`).

Result: the room is fully rendered into the shadow buffers `$EB00`/`$E800`, ready for `$C18E`/`$C806`/`$C85C` to transfer to the real screen (see `General.md`).

Between the room-type descriptor table and the additional-elements table sits `$8432`-`$8510`, 223 bytes, all zero — confirmed via a raw memory dump. Unused padding, not a hidden table.

## Open questions

- Precise meaning of world-map bit 7 in all its uses (confirmed as an attribute-constant selector in `$C072`; whether it always means "mirror this room's blocks" is not fully verified against every block-drawing path).
- Purpose of header bit 5 (never read by `$C0D1`) — reserved, or a leftover unused authoring flag.
