# Flying Shark — Level Format

How a level's background (relief/scenery), colour scheme, enemy-wave timeline
and difficulty are encoded, and where the data lives. Addresses are hex;
`$XXXX` refs point into the disassembly.

## Overview

A level is not one contiguous blob. It is assembled from several independent
tables, all keyed off the current level, and tied together by the per-level
**configuration table** at `$61D4`. When a new wave/level starts, `$A612` reads
one 20-byte config row and scatters its fields into RAM working pointers; those
pointers then drive four largely-separate subsystems each frame:

| Subsystem | Driven by | Data source | Purpose |
|-----------|-----------|-------------|---------|
| Background relief | `$C941` / `$C84C` | tile block 2x2 table `$7900-$7CFF`, cell columns | scrolling terrain/water graphics |
| Scenery script | `$A3A0` | script bytes at `$9BFD` ptr | timed scenery events / sub-pixel scroll |
| Enemy timeline | `$C9AF` | 3-byte-entry table at `$9BA5` ptr | when/what enemy formations spawn |
| Colour scheme | `$A4E7` / `$A54D` | colour tables at `$61E2` | level-dependent palette |

## 1. Per-level configuration table (`$61D4`)

20 bytes per row. Row for a level is selected in `$A612` as:

```
row = $61D4 + 20 * (wave-formation-tag + 1)
```

The first 20-byte span (`$61D4-$61E7`) is therefore row "−1" — never selected by
that formula. Its bytes are pointed **into** by other rows' cursor words rather
than being a level's own config (it holds the colour-scheme tables `$61E2` and
misc header bytes).

Real level rows live at `$61E8`, `$61FC`, `$6210`, `$6224` (4 levels). Field
layout, confirmed field-by-field from `$A612`'s 6-word `SP`-trick pop (byte
offsets into the row):

| Offset | Size | Field | Destination | Meaning |
|--------|------|-------|-------------|---------|
| `$00` | word | colour-scheme cursor | `$9C57` | cursor into colour table (see `$A54D`), values land in `$9C59/$9C5A` |
| `$02` | word | timeline cursor | `$9BA5` | pointer into this level's enemy-timeline table (3 bytes/entry, `$C9AF`) |
| `$04` | word | scenery-script ptr | `$9BFD` | this level's scenery-script pointer (`$A3A0`) |
| `$06` | word | fire-rate baseline | `$9C40/$9C41` | combined with the spawning object's `IX+$0A` (difficulty scaling) |
| `$08` | word | fire-timer reload | `$9C42/$9C43` (lo), `$9C71` (hi) | enemy fire-decision timer reload value |
| `$0A` | word | screen/timing pokes | `$5B56`+`$C2E1` (lo, `SRL`'d), `$5B7A` (hi) | exact purpose unconfirmed |
| `$0C` | 8 bytes | wave-tag thresholds | scanned by `$A4E7` | ascending threshold table; base address kept at `$9BA7` |

In the `.ctl` each real row is split `W addr,12,2` (the 6 pointer/param words)
+ `B addr+12,8` (the tag table), with the first four words individually
labelled.

## 2. Background relief (scrolling terrain)

The visible background is a horizontally-scrolling field of 8×8 tiles, rebuilt
one column at a time as the screen scrolls.

### Tile block 2×2 table — `$7900-$7CFF`

Four parallel 256-entry lookup tables: `$79xx / $7Axx / $7Bxx / $7Cxx`. A map
cell is a single **cell byte**, used as the index into all four tables at once.
The four bytes read out are the four **character codes of a 2×2 block**:

```
$7900[cell] = top-left     $7A00[cell] = top-right
$7B00[cell] = bottom-left   $7C00[cell] = bottom-right
```

So one cell byte expands to a 2-char-wide × 2-char-tall block. The decode writes
the top pair into buffer row A and the bottom pair into row B (see below). These
are **not** pixel rows — a later pass (`$C8B8`) treats each code with ×8 scaling
and screen-address math to place the actual character graphics, so the pixel
artwork is reached indirectly through these codes.

### Column decode — `$C941`

Runs every 8th frame (from `$C8B8`). For each of 9 vertical cells in the
incoming column:

1. `E` = next **cell byte** from the column-source pointer `$9BA9`.
2. Read the cell's 2×2 block — one char code from each page `$79/$7A/$7B/$7C`
   at the **same** low-byte `E`.
3. Store them into the ping-pong staging buffer `$9BB0` at offsets
   `0/1/$12/$13`: top pair `$79/$7A` → row A (bytes 0,1), bottom pair `$7B/$7C`
   → row B (bytes `$12,$13`). Across 9 cells each row fills to 18 bytes
   (2 chars/cell), i.e. a column of 9 blocks = 18 chars tall × 2 chars wide.

After the 9 cells it advances `$9BA9` and bumps the level-progress counter
`$9BAD` (clamped at `$1C`). Before decoding, if the column isn't already marked
ready (`$9BA2` bit 5), `$C981` scans the *previous* column's cell bytes for
spawn markers `$05`/`$55` and allocates enemy objects for them (via `$BA5F`),
marking spawned cells `$33`. So enemy spawn points are embedded in the same
9-cell column stream as the relief.

### Scroll window — `$C84C`

Builds the on-screen 24-byte row from the circular scroll buffer (base `$9BF9`
+ wrap at `$FA79`) into `$F6D1`, which `$C772`'s fast attribute mover then
blits. This is the smooth pixel/byte scroll on top of the column rebuild.

## 3. Scenery script (`$A3A0`)

A separate byte-code stream (pointer `$9BFD`, seeded from the config row's word
`$04`; default `$6D71` via `$A371`). Distinct from the enemy-formation
(`$AFB8`) and object-movement (`$B8F9`) script systems. Drives background
timing / scenery set-pieces. Byte classification:

- **top bit set** → dispatch a scene event through the offset-chain table at
  `$6E06` (sum `B` `DE`-strides to find the target; result stored at `$9C0C`).
- **`$FF`** → rewind the script pointer to the default (`$9BFB`) and loop.
- **anything else** → a "wait" delay: low nibble stored at `$9BAF`, pointer
  advances.

The wait value `$9BAF` doubles as a **sub-pixel shift amount** consumed by
`$A40B`, which copies 9 bytes from the scenery data pointer `$9BAB` into the
double buffer `$9BE6` and does a shift-based blit — a smoothly-scrolling
scenery/marquee graphic.

### Scenery tile generator — `$A499` / `$A445` / `$A46C`

`$A445` (jump-table handler `$15`) and `$A46C` (handler `$16`) draw a scrolling
scenery column by calling `$A499` per cell. `$A499` produces each cell value as
`base ($9C0B) + next script nibble`, periodically refreshing `base` from the
scenery-event data (via `$A4B5`). So scenery relief cells are *generated* from
the script's nibble stream plus a slowly-changing base, not stored as a flat
bitmap.

## 4. Enemy-wave timeline (`$C9AF`)

Per-level table of **3-byte entries**, cursor at `$9BA5` (config word `$02`).
Level tables: `$5EEA` (L1), `$5F87` (L2), `$6042` (L3), `$60F1` (L4).

Each entry `[trigger, D, cmd]`:

- **`trigger`** — compared against progress counter `$9BA4`; entry fires only
  when they match (else the routine returns and retries next tick). `$FF` in
  this position ends the table.
- **`D`** — parameter byte (used by some commands).
- **`cmd`** — dispatched:

| `cmd` | Action |
|-------|--------|
| `$FB` | `LD A,D` → `$5B56`, `SRL` → `$C2E1` (screen/timing poke) |
| `$FC` | clear `$9D1B` |
| `$FD` | increment `$9C69` |
| `$FE` | set `$9C3B = $FF` |
| `$FF` | end of table |
| other | treated as a **formation tag**: allocate an object via `$BA5F` (`$C9E4` entry) |

`$C9AF` is entry-patched to `RET` by POKE 51631,201 (the "No Enemies" cheat),
confirming this is the enemy-scheduling routine. `$9BA4` (the level index /
progress) is advanced here and also set by `$A4E7`.

## 5. Colour scheme (`$A4E7` / `$A54D`)

`$A4E7` selects the active palette when a level starts: it searches the config
row's 8-byte threshold table (base `$9BA7`) for the first entry ≥ the object's
wave/formation tag (`IX+7`), storing the level index into `$9BA4`; then scans a
3-byte-stride colour table (cursor `$9BA5`) until `$9BA4 ≥` its threshold byte,
loading the level's colour/type value into `$9C59` and `$9C5A`. That value is
used everywhere for the wipe-effect colour, screen fills, etc. (`$C6A6`,
`$66B5`). Colour-scheme tables themselves sit at `$61E2` (within the `$61D4`
header row).

## Data location summary

| Data | Address | Notes |
|------|---------|-------|
| Per-level config table | `$61D4` | header row + 4 level rows × 20 bytes |
| Colour-scheme tables | `$61E2` | inside the config header row |
| Level 1-4 timeline tables | `$5EEA` / `$5F87` / `$6042` / `$60F1` | 3-byte entries |
| Background tile block 2x2 table | `$7900-$7CFF` | 4 parallel 256-byte tables = 2×2 char block per cell (TL/TR/BL/BR) |
| Scenery script (default) | `$6D71` | seeded per level from config word `$04` |
| Scenery offset-chain table | `$6E06` | scene-event dispatch |

## Open questions

- Config-row word `$0A` (`$5B56`/`$C2E1`/`$5B7A` pokes) — exact effect on
  screen/timing not confirmed.
- Where the **column-source pointer `$9BA9`** is first pointed at real level
  data each level (it is reset to the sentinel `$7D00` by `$A371`; the live
  hand-off point that makes it walk the relief cell stream is not yet traced).
- Full decode of a colour-scheme table entry (3-byte stride assumed from
  `$A4E7`, individual byte meanings not confirmed).
- Formation-tag → actual enemy-formation-script mapping (the `other` timeline
  command path into `$BA5F`/formation selection) is only partly traced.
- Whether the scenery-script event table `$6E06` entries are per-level or global.
- What the 2×2-block character codes (`$7900-$7CFF`) resolve to as pixel
  graphics — the `$C8B8` pass scales each code (×8) into screen writes, but the
  actual character-graphics source they point at is not yet traced.
