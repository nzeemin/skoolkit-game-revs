# Hydrofool Player Movement and Collision

Reference for input handling, walk-direction resolution, and collision
detection. All addresses refer to the 48K snapshot `hydrofool.sna`. The
player is a dynamic object record (see `Room-Format.md` §6.0) — this
document covers its movement-specific behaviour, driven from its per-frame
handler `$8968`.

## 1. Input reading (`$7EBE`)

Runs every frame, regardless of which control method is active (selector
byte **`$617B`**: `0`=keyboard, `1`=Kempston, `2`=Sinclair, else=Cursor
keys). Produces one normalized 5-bit mask at **`$6186`**:

| Bit | Meaning |
|---|---|
| 0 | Right |
| 1 | Left |
| 2 | Down |
| 3 | Up |
| 4 | Fire / pick-up / drop |

- **Kempston** (port `$001F`): read directly and used as the mask verbatim
  — this is the canonical bit layout all other methods are normalized into.
- **Sinclair** (port `$EFFE`): bit-rotated into the same layout.
- **Cursor keys**: read from ports `$EFFE`/`$F7FE`.
- **Keyboard**: 6 row snapshots (`$6182`-`$6184`, `$617D`-`$617F`) are
  tested and OR'd into the mask; two different rows both set bit 4
  (fire), matching the game's documented dual-key layout for
  pick-up/drop/fire (`SPACE`, per the instructions).

The result is masked against the previous frame's value at `$6188`
(edge-detection) before being stored to `$6186`, and accumulated into a
held-key counter at `$617C` (key-repeat timing).

Per the game's own instructions, the keyboard control scheme is diagonal
groups of keys, not individual direction keys:

```
Q W E R T       Up/left
Y U I O P       Up/right
A S D F G       Down/left
H J K L         Down/right
SPACE           Pick up/Drop/Fire if carrying weapon
```

(The exact half-row-to-diagonal mapping into `$6186`'s 4 direction bits
hasn't been pinned down key-by-key — only the resulting bit layout is
confirmed.)

## 2. Direction resolution (`$8968`)

The player's per-frame handler ORs `$80` into `$6186` (a wildcard
sentinel) and scans a **(mask, direction) priority table at `$88F0`**:

| Mask | Matches | Direction code |
|---|---|---|
| `$08` | Up | `$01` |
| `$04` | Down | `$02` |
| `$02` | Left | `$06` |
| `$01` | Right | `$04` |
| `$80` | (always — no input) | `$00` |

Entries are tried in this fixed order; the first whose mask bit overlaps
`($6186 \| $80)` wins — so Up beats Down beats Left beats Right when
multiple are held, and the `$80` entry always matches last as a catch-all
"idle" result.

The resolved direction code is compared against the player's current
facing (`(IX+$0B)`):
- **Same** → call `$8AD9` immediately, taking a step.
- **Different, nonzero** → just latch the new direction into `$8DC1`
  (turning costs one frame before the first step in the new direction).
- **`$00`** (no input) → no movement this frame.

## 3. Taking a step (`$8AD9`, `$8ABB`)

`$8ABB` applies the facing direction to the object's position (`+5`/`+6`
in its record), looking up a **screen-space `(dx, dy)` delta** in a table
at `$8AB3`, indexed by `facing_code AND $0E`:

| Direction code | Delta `(dx, dy)` |
|---|---|
| `$00`/`$01` (Up) | `(-2, 0)` |
| `$02`/`$03` (Down) | `(+2, 0)` |
| `$04`/`$05` (Right) | `(0, +2)` |
| `$06`/`$07` (Left) | `(0, -2)` |

(The low bit of the direction code is masked off — it likely distinguishes
a walk sub-phase, not a different direction.) Note the diagonal-looking
screen deltas: because rooms are drawn as an isometric diamond, each
in-game cardinal direction moves the sprite along a single screen axis by
2px, not both axes.

`$8AD9` then:
1. Calls `$8ABB` (moves the position, saves the old position in `BC`).
2. Calls `$67F1` (door/room-transition check — see `Room-Format.md` §4a).
3. Calls `$9BF0` (collision check).
4. If `$9BF0` reports **no collision**: keeps the new position.
5. If it reports a **collision**: reverts position to the saved `BC`,
   resets the walk-animation countdown (`+0x0E`), and — if the collision
   was specifically with another object (`Z` flag) — pokes `$FF` into that
   object's record offset `+9` (disabling it).

## 4. Collision detection (`$9BF0`, `$9ABC`)

`$9BF0` tests the object's **bounding box**, defined by fields `+0x10`
(left X), `+0x11` (top Y), `+0x12` (right X), `+0x13` (bottom Y):

1. All 4 corners — `(left,top)`, `(left,bottom)`, `(right,bottom)`,
   `(right,top)` — are tested against the room grid via `$9ABC`. Any
   corner hitting solid terrain aborts with Carry set.
2. If all 4 corners are clear, `$9B5A` (object-vs-object overlap scan —
   see `Room-Format.md` §6.2) checks for collision with another object in
   the same room.

`$9ABC` — the per-corner terrain test — converts a screen coordinate
`(B=X, C=Y)` to a grid cell:

```
grid_offset = ((Y AND $F8) >> 3) * 8 + ((X AND $F8) >> 3)
```

(confirming the `$612C` grid's `row*8+col` indexing operates on 8px-aligned
screen tiles). Then:

- `$00` → passable, no collision.
- `$7F` → solid wall, hard block.
- any other nonzero code → looked up in a **per-terrain-code shape table
  at `$7556`** (the same table `$8E6E` reads during creature setup) —
  meaning individual terrain codes (rocks, seaweed, etc.) may have
  different collision shapes rather than being uniformly solid or passable.
  Not yet decoded.

## 5. Walk animation (`$99A1`)

A direction-aware variant of the shared sprite-animation stepper
(`$99D5` — see `Room-Format.md` §6.4): `(IX+$1D)/(IX+$1E)` points at a
table of 4 sub-table addresses, one per facing direction (selected via
`(IX+$0B)`). The chosen sub-table is then run through `$99D5`'s
byte-code interpreter (`$FD`/`$FC`/`$FE`/`$FB` position-delta markers,
otherwise a sprite number) — this is how the player's walk cycle picks the
correct sprite frames and fine position adjustments for whichever
direction it's currently facing.

## 6. Open questions

- The keyboard half-row → diagonal-group mapping (which of `$6182`-`$6184`/
  `$617D`-`$617F` corresponds to which documented key group) isn't
  decoded key-by-key.
- The `$7556` per-terrain-code shape table (partial-block shapes for
  non-wall, non-empty grid codes) is unread.
- `$9BF0`'s leading `CALL $9A60` (same address as the dynamic-object
  finalizer — see `Room-Format.md` §6.2) returning early on Carry: unclear
  why a collision check calls the object finalizer, or whether this is a
  second, coincidentally-identical entry point.
- The exact meaning of bit 7 in `(IX+$0D)` used elsewhere isn't tied back
  to movement state yet.
