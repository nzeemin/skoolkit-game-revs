# Secondary Object Tables

Besides the main enemy-object array at `$5B11` (see Object-Record.md), the game keeps five smaller flat tables for other moving things. Each is a plain array of fixed-size records with a sentinel/end marker, scanned once per frame from the main loop (`$DEEF`, "Game's main loop, Part 2").

| Table | Record size | Scanner | Frame order | Identity | Confidence |
|---|---|---|---|---|---|
| `$F82D` | 5 bytes | `$F24A`/`$F26E` (via `$F20C`/`$F209`) | 1st | Player bullets | High |
| `$F7C9` | 14 bytes | `$F37B` (only called from `$F36D`) | 2nd (with grenades) | Secondary projectile/vehicle | Unconfirmed |
| `$F81E` | 14 bytes | `$F36D` (via `$F212`) | 2nd | Grenades | High |
| `$F73C` | 14 bytes | `$F381` (via `$F203`) | 3rd | Primary projectile/vehicle | Unconfirmed |
| `$F856` | 20 bytes | `$F707`/`$F6C2` (via `$F206`) | 5th | Explosion/death effects | Medium |

## How the identifications were made

**Player bullets ($F82D)** — traced from [$ECC1](commando-zx/commando.ctl) ("Check fire button and joystick input"). Its `$ED1A` branch reads the player's sub-state byte (`$5BE6`), looks up `$ED31`, then calls `$F20C` (spawns into `$F82D`) and triggers sound `$06`. 5 bytes is enough for a simple bullet (position, direction, timer).

**Grenades ($F81E)** — traced from the *other* branch of the same `$ECC1` routine: if the fire button is held and `($FDE7)` (grenades count) is nonzero, it computes the player's position, calls `$F21B` (spawns into `$F81E`), decrements the grenade count, and jumps to the "We've got A more grenades" UI update. This is the one solid anchor — everything else is inferred from its *sibling* table.

**`$F7C9` / `$F73C`** — both are 14-byte records processed by the same shared body (`$F385`, in the routine now titled "Set up grenade table $F81E, dispatch" / friends), which computes a full direction+speed+target motion vector (`$F4F6`) — much richer than a bullet needs. `$F73C` is scanned on its own main-loop step; `$F7C9` is scanned only as a side effect of the grenade step (`$F36D` calls `$F37B` first, then does the grenade table). Given the game has multiple vehicle enemies with dedicated flag bits already noted elsewhere (`$FDC7` "Motorbike??", `$FDCB` "Jeep??"), these are plausibly two vehicle/complex-enemy pools rather than more bullets — but this hasn't been confirmed against sprite-draw calls for a specific vehicle.

**Explosions ($F856)** — `$F6C2` fills a new `$F856` entry with a type byte (`$07`) and derived position, immediately after a kill sequence at [$F30F](commando-zx/commando.skool) that finds a free enemy slot, plays sound `$05`, and awards +1000 points. `$F707`'s per-entry logic decrements a delay field and picks between animation-stage values (`$12`/`$17`/`$18`) — consistent with a short explosion/death animation, but not confirmed against the actual sprite data.

Note: `$F4E3`/`$F4E9` set up `$F81E`/`$F7C9` too, but through a *different* code path (the generic `$F200`/`$F4F6` "compute and store motion vector" spawn routine, called e.g. from an explosion-position calculation and from `$EC52`) — meaning grenades and/or the `$F7C9`/`$F73C` pools can also be spawned by enemy-side code, not just the player's fire button.

## Open questions

- What exactly `$F7C9` and `$F73C` hold — need to trace a specific vehicle's draw call back to one of these tables to confirm.
- Whether `$F81E` (grenades) is shared between player-thrown and enemy-thrown grenades, given the second spawn path via `$F4E3`.
- Exact meaning of the `$F707` animation-stage constants ($12/$17/$18) for `$F856`.
