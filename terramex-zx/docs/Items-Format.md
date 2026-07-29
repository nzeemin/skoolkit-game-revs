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

## Inventory ($5B7C, 26 bytes)

`$5B7C` is a sequential item-pickup log, one byte per collected item, holding the
item's table index (0-31, see above). `$FF` marks a slot not yet used.

- Items fill the log left to right in pickup order — it's a log, not a fixed-size
  per-slot inventory.
- The **last non-`$FF` entry is the item currently carried/in-hand**.
- Cleared to all-`$FF` at game init (`#R$8F47`).

Confirmed live via the Emu80 MCP debugger: after collecting Umbrella (#5), ACME
Expanding Bridge (#11), Unicycle (#0), and a small barrel, the log read
`01 02 0D 05 0B 00 03 0A 07 0C 06 1B FF FF ...` — the last filled slot ($1B = #27,
"Barrel Big") matched the barrel actually being held, and #5/#11/#0 both appeared
earlier in the log, matching Umbrella/Bridge/Unicycle from an earlier pickup.

A "Barrel Medium" (#9) was live-poked into slot 12 of this log via `mem_write` to
test the theory, and it did equip as the held item — confirming both the log
mechanism and the "last slot = held item" rule.

## Open questions

- What items #21 and #31 actually are (sprites drawn but not yet seen in-game with
  a name attached).
- Whether there's a fourth barrel size not yet found (Small/Medium/Big/Beer Barrel
  confirmed so far).
- Whether the log has a fixed capacity of 26 (matching $5B7C's 26-byte size) or
  whether some other mechanism (e.g. wrap-around, or per-bearer slots) kicks in
  once all 26 are used — not tested.
