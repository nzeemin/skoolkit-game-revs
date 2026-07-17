# Tower map cell format

The tower for the current level is stored column-major, one byte per row
cell, in the work-buffers map at $F000+ (page $F0..$F3, 128 columns x 32
rows, addressed as page=$F0+(row>>3)... see player_cell_addr $9516 /
read_actor_cell $9657 for the exact address math). Cell bytes are read by
several routines that each test a different bit group of the same byte:
draw_tower_cell ($8F31, rendering), test_cell_special ($952A), check_conveyor
($9540), consume_cell ($955B), check_step_cell ($957A).

## Byte layout

```
bit:  7 6 5 4 3 2 1 0
      | | \-+-/ \-+-/
      | |   |     type (bits 0-1)
      | |   subtype (bits 4-5, meaning depends on type)
      | flag bit (bit 6, meaning depends on type)
      occupied (bit 7)
```

- **Bit 7 (occupied)**: 0 = empty/open cell (nothing there -- every reader
  RETs immediately without drawing or reacting). 1 = a feature is present;
  keep decoding the rest of the byte.
- **Bits 0-1 (type)**, tested via `AND $03`:
  - `0` and `2` -- solid/wall geometry. draw_tower_cell renders both through
    the same offset table (tbl_cell_offsets_c, $8FA1) -- not yet confirmed
    whether 0 vs 2 is "block" vs "gap" or a facing/orientation bit; needs a
    live-game cross-check (place the player at a known door/block/gap and
    read the byte).
  - `1` -- **interactive** cell. Bits 4-5 (`AND $30`) select the subtype:
    - `$00` (bits 4-5 clear) -- **conveyor/lift**, but identified by the
      *whole byte value*, not just the type bits: `$85` = belt direction +1,
      `$89` = belt direction -1, `$8D` = belt present but stationary
      (check_conveyor, $9540). All three share type=1, subtype=$00 and only
      differ in the low nibble.
    - `$10` -- **collectable/pickup**. consume_cell ($955B) zeroes the cell
      (`LD (HL),$00`) and plays sound 9 when the player walks over it.
    - `$20` -- **step/ledge, direction A**. check_step_cell ($957A) returns
      auto-step code $01 (used by rotate_if_idle, $8460, to nudge the player
      onto it automatically when idle).
    - `$30` -- **step/ledge, direction B**. Same mechanism, opposite auto-step
      code $FF.
    - any other bits 4-5 value with type=1 -- not recognised by
      check_step_cell/consume_cell (falls through, no effect).
  - `3` -- **special** cell. draw_tower_cell explicitly skips rendering
    anything for type 3 (invisible). test_cell_special ($952A) returns CY set
    and A = bit 6 of the byte (`AND $40`) -- so there are two special
    sub-kinds distinguished by bit 6, meaning not yet identified (candidates:
    level-end trigger, checkpoint, scoring zone -- needs a live-game
    cross-check).

## Rendering (draw_tower_cell, $8F31)

Only reached for occupied cells whose type isn't the reserved/invalid combo.
The type/subtype bits above select one of three sibling offset tables
(tbl_cell_offsets_a $8F75 / _b $8F8B / _c $8FA1):

- type bit0==0 (types 0, 2) -> table_c ($8FA1)
- type bit0==1, bits 2-3==0 (i.e. type==1 with the low nibble's bit2-3 clear)
  -> table_a ($8F75)
- type bit0==1, bits 2-3!=0 -> table_b ($8F8B)

The chosen table is indexed by DE (a caller-supplied sub-position index, not
part of the cell byte itself) to get a signed offset; negative (bit7 set,
`$FF` in the table dumps) means "nothing to draw at this sub-position" --
RET. A non-negative entry is multiplied by 3 and used to index
sprite_shift_masks ($8C1E) for 3 AND-mask bytes, which are ANDed into 3
consecutive destination screen bytes at (BC) to punch out the feature's
silhouette. A self-mod counter at $8C78 is bumped on every successful draw
(used elsewhere to know how many features were drawn this pass).

## Column source data (load_level_col, $B346)

Each level column's byte-stream lives in level data starting at $6A00,
addressed via a column-major pointer table at $7A00 (stride 8 bytes per
column-table-row): for the current column index (#R$6039), the low pointer
byte is at table+0 and the high pointer byte at table+8 (both offset by
$6A00), forming the 16-bit source address (IX). A third byte at table+16 is
the column's "property byte", stashed in $603A (level-column height/type
property, consumed elsewhere e.g. by enemy state 6/9 dispatch and
pstate_9's level-shift countdown).

setup_level ($81D7) copies this column's bytes into the live $F000 map when
building/rebuilding the current level.

## Open questions

- Confirm types 0 vs 2 semantics (block vs gap, or a facing bit) by reading
  a live cell byte at a known visible block/gap boundary.
- Confirm the two test_cell_special sub-kinds (bit 6 = 0 vs 1).
- Map out sprite_shift_masks' offset-table entries against actual rendered
  shapes (door/block/gap silhouettes) to give the render side of the format
  named shapes instead of just table indices.
- Cross-reference $6A00 level data bytes for a real level against this
  bitfield spec to build a human-readable level map dump tool.
