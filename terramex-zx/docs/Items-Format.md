# Items / Objects

All collectible items share one 72-byte sprite format (3 columns x 3 rows of UDGs,
column-major, see the `#R$8400` block in `terramex.ctl`). The sprite table starts
at $8400, one entry per item, `index = (address - $8400) / 72`. The same index is
used by the inventory log (see below) and by the sprite-draw dispatcher at `#R$9DE3`
(`sprite address = $8400 + index*72`).

## Item table

| Index | Address | Name |
|---|---|---|
| 0 | $8400 | Unicycle |
| 1 | $8448 | Flashgun |
| 2 | $8490 | Cricket Ball |
| 3 | $84D8 | Spurs |
| 4 | $8520 | Beer Barrel |
| 5 | $8568 | Umbrella |
| 6 | $85B0 | Bellows |
| 7 | $85F8 | Party Manifesto |
| 8 | $8640 | Cannon |
| 9 | $8688 | Barrel Medium |
| 10 | $86D0 | Vacuum Cleaner |
| 11 | $8718 | ACME Expanding Bridge |
| 12 | $8760 | Flute |
| 13 | $87A8 | Silver Lining |
| 14 | $87F0 | Spring |
| 15 | $8838 | Formula |
| 16 | $8880 | Switch |
| 17 | $88C8 | Button |
| 18 | $8910 | Battery |
| 19 | $8958 | Coat Hanger |
| 20 | $89A0 | Trampoline |
| 21 | $89E8 | Atomic Pile |
| 22 | $8A30 | Anti Radiation Pills |
| 23 | $8A78 | Cup of tea |
| 24 | $8AC0 | Energy Crystal |
| 25 | $8B08 | Busket |
| 26 | $8B50 | Balloon |
| 27 | $8B98 | Barrel Big |
| 28 | $8BE0 | Barrel Small |
| 29 | $8C28 | Silver Cross |
| 30 | $8C70 | Busket |
| 31 | $8CB8 | Lift |

All 32 items are now named.

## Inventory ($5B7C, 27 bytes)

`$5B7C` is a sequential item-pickup log, one byte per collected item, holding the
item's table index (0-31, see above). `$FF` marks a slot not yet used.

- Items fill the log left to right in pickup order — it's a log, not a fixed-size
  per-slot inventory.
- The **last non-`$FF` entry is the item currently carried/in-hand**.
- Cleared to all-`$FF` at game init (`#R$8F47`).

Both rules are confirmed live. A log read during play held
`01 02 0D 05 0B 00 03 0A 07 0C 06 1B FF FF ...`, with the last filled slot
($1B = #27, "Barrel Big") matching the item the hero was carrying, and the
earlier entries matching items picked up before it. Writing a different index
into the last filled slot changes the held item accordingly.

## Open questions

- Whether indices 25 and 30 are really both "Busket" - the ctl gives both
  $8B08 and $8C70 that name, so one of them is probably a different object
  that has not been told apart from the other yet.
- What happens once all 27 slots are full - `$BB5D` simply finds no free
  entry and skips the pickup; whether the game is winnable without ever
  needing a 28th slot hasn't been checked.
