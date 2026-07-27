# Object Record Format ($5B11 array, 20 bytes wide)

Shared 20-byte record layout used for the player ([$5BDA](../commando.ctl)), enemies (array at `$5B11`), and other moving game objects. Fields are addressed via `IX`, with `IX+$00` as the record base. The player has its own fixed instance at `$5BDA` (not part of the `$5B11` array — `$5BDA - $5B11` is not a multiple of 20); its individual bytes are documented separately at `$5BD9`-`$5BEE` but follow the same offsets.

Confidence varies a lot by field: position/frame/flags are solid (confirmed from multiple independent call sites); the `+$0C`/`+$0D`/`+$0E`/`+$0F`/`+$10`/`+$13` group is a best-effort reading and may differ in meaning between object *kinds* (enemy vs bullet vs explosion vs scenery) that all reuse the same struct shape.

## Confirmed fields

| Offset | Field | Evidence |
|---|---|---|
| `+$00` | Current column (X) | [$9922](../commando.ctl) draws from here, then overwrites with `+$04` |
| `+$01` | Current row (Y) | paired with `+$00`; read throughout the `$9922` draw/clip chain |
| `+$02` | Sprite frame index (current) | `$9922` computes `frame*2` into the `$98E2` offset table |
| `+$03` | Sprite page (current), used as `(IX+$03)+$A0` | `$9922` |
| `+$04` | Target/new column (X) | `$9922` copies `+$04` into `+$00` at the start of each draw |
| `+$05` | Target/new row (Y); also reused generically as a clip/collision bound in non-draw contexts | `$9922`, `$9A6E`/`$9AE6` clip family, `$EBE1` |
| `+$06` | Sprite frame index (next) — copied into `+$02` after drawing | `$9922` |
| `+$07` | Sprite page (next) — copied into `+$03`; also reused as a plain state/type byte in the map-marking routines (`$806B`, `$82C1`) | `$9922`, `$806B` |
| `+$08` | X-axis clip bound (right/width) | bounds checks in `$9922`, `$9B61`/`$9B97`/`$9BCB`/`$9BF5`, `$9C23` |
| `+$09` | Y-axis clip bound (bottom/height) | same bounds-check family |
| `+$0A` | secondary X/Y clip bound, used alongside `+$08`/`+$09` | same family |
| `+$0B` | Flags byte: bit 2 = sprite flip/mirror, bit 4 = wall-solid/breakable (enemy/bullet context), bit 5 = draw-active (set by `$9922`), bits 6-7 tested but purpose unconfirmed | `$9922`, `$8497`-family clip, `$822B` |
| `+$11` | AI action delay timer — decremented every frame, action fires at zero, reloaded with a new countdown per state transition | `$EB13`, `$E972` state machine, dozens of `LD (IX+$11),n` sites |
| `+$12` | AI state — main dispatch key for `$E972`; states seen include `$00`,`$01`,`$04`,`$06`,`$09`,`$0A`,`$0C`,`$0D`,`$0F` | `$E972`, `$DDB6`, `$E7EA` |

## Less-certain fields

| Offset | Best guess | Notes |
|---|---|---|
| `+$0C` | Sub-state / type byte, meaning depends on object kind | Set to various small constants (`$12`, `$13`, `$01`...) around AI state changes; also used by `$6FF5` (door/scroll trigger lookup) and the map-marking pair `$806B`/`$82C1` in an apparently unrelated sense |
| `+$0D` | Hit/frame counter, or a position snapshot | `$EB7B` increments it and compares against a threshold; `$EC65`-area code copies `+$05` (row) into it |
| `+$0E`, `+$0F` | Secondary target coordinates (X, Y) — distinct from `+$04`/`+$05` | `$E5DB`/`$E5FE` load `D=(IX+$0F)`, `E=(IX+$0E)`, clamp via `$F21E`, store back |
| `+$10` | Current heading/direction value, or a movement-phase counter | Tested with `BIT 0` in several places (`$E650`, `$E681`, `$E6B0`, `$E6E3`); incremented at `$E806`; added into a frame-table index at `$DDA4` |
| `+$13` | Secondary delay value, sometimes doubled (`ADD A,A`) and copied to/from `+$11` | `$E9AE` "alternate delay field"; `$E064` adds it into a running value |

## Open questions

- Whether `+$0C`-`+$10`/`+$13` mean the same thing across all object kinds, or whether the struct is reinterpreted per record "type" (enemy/bullet/explosion/scenery) — the evidence so far comes from mixed call sites and hasn't been isolated per kind.
- Exact meaning of `+$0B` bits 6-7.
- Whether `+$08`/`+$09`/`+$0A` are a fixed (width, height, depth) triple or vary in role by routine.
