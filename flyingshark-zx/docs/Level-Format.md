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

### Formation-tag spawning — `$BA5F`

The `other` timeline command (a formation tag, held in `C`) resolves through
three lookup tables before an object is actually spawned:

1. `C` is masked to `C & $3F` and indexed into **`$5B29`** (44 populated
   entries, strictly ascending `$00-$FB`) — a formation-tag → group-index
   table.
2. That group index selects a 2-byte entry in **`$5CF4`** — the per-group spawn
   budget: byte 0 is the max object count to spawn this call, clamped against
   the remaining wave counter `$9D18`; byte 1's role is not yet confirmed.
3. `$BA5F` pops that many objects off the free-object list (`$9D1C`) via an
   SP-trick, and initializes each from a spawn-template table at **`$5B55`**
   (`index*9 + $5B55`, 9 bytes/entry).

**Spawn-template fields** (confirmed by matching each self-modified write
target to its instruction operand in `$BB62`'s init block):

| Byte | Destination | Notes |
|------|-------------|-------|
| 0 | `IX+$05` | |
| 1 | `IX+$12` | |
| 2 | `IX+$1A` | |
| 3 | `IX+$1B` | + difficulty offset (`$9C41`), clamped to `$FF` |
| 4 | `IX+$11` | |
| 5,6 | `IX+$02/$03` | little-endian, **not a code pointer** — see below |
| 7,8 | — | little-endian — a **fixed-slot address**: `$9D1E`, `$9D24`, or `$9D2A` (3 of `$B730`'s 4 persistent object slots; `$9D30` never observed here) |

**`IX+$02/$03` is a record pointer, not executable code.** It looks
address-shaped (`$6Bxx` range) and was initially assumed to be a "per-frame
handler", but the raw bytes at those addresses don't decode as coherent Z80
(random `CP`/`XOR`/`RET PO`/`LD (BC),A` with no control flow). Checking the
values against `$6B42`'s 17-byte descriptor-record table (used by `$7D98`'s
title-screen decoder, record `n` at `$6B42 + 17*n`) resolves it: 6 of the 10
spawn templates' values land **exactly** on that grid — `$6BCA`=record 8,
`$6BDB`=record 9, `$6B64`=record 2, `$6B86`=record 4, `$6BA8`=record 6,
`$6B75`=record 3 — and `$C559`'s object-init default is `$6B42` itself
(record 0). `$6B42`'s own record field at offset `$02/$03` is documented as
something `$7DC9` *writes* at runtime (a decoded graphics sub-pointer), not
fixed code, which fits: `IX+$02/$03` is most likely an index/pointer into a
shared state-descriptor record format, read as data by an as-yet-unlocated
per-object routine — not called as a handler. The remaining ~4 values (and
`$C5D2`'s `$6BF3`, which does *not* land on the grid) are unconfirmed.

The fixed-slot address (bytes 7/8) is used twice:
- `$BB62` reads **one byte** from it to index the movement-script offset table
  `$5B00` (see below) — so the spawned object's script is chosen by a *live*
  value at the slot, not a template constant.
- After all objects for this call are spawned, a **word** at that address is
  read, swapped via `EX (SP),HL`, and written back — apparently linking the
  slot to the newly-spawned object(s); the exact mechanism isn't fully traced.

(Template byte 1 happens to land on `$5B56`, the same literal address written
directly as a "screen/timing poke" by `$A612`'s config word `$0A` and timeline
command `$FB` — unrelated dual use of that address, not a field alias.)

### Movement-script bytecode pool — `$5B00` / `$5BAF`

`$5BAF` is one continuous stream of movement-script bytecode in
`$B8F9`/`$B920`'s format (bit 7 set = wait byte; else bits 0-2 select one of 8
opcodes via `$A076`/`$A082`, bits 3-6 are the parameter) — **not** an array of
fixed-size records. `$5B00` (41 ascending entries, `$00-$89`) gives each
script's entry point as a half-byte-offset into the pool (doubled at runtime,
`$5BAF + 2*value`), so a single table byte can address the whole ~325-byte
pool and several spawns can share one script by indexing the same `$5B00`
entry. Scripts are variable-length — they simply run until their own content
ends — which is why consecutive `$5B00` offsets aren't evenly spaced.

`$BA5F` also handles `$C981`'s column-embedded spawn markers (`$05`/`$55`, see
§2) through the same allocation path. Returns carry set on success; a failed
spawn (pool full) leaves the trigger in place to retry.

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
| Formation-tag → group-index table | `$5B29` | 44 entries, ascending, indexed by tag `& $3F` |
| Per-group spawn budget table | `$5CF4` | 2 bytes/entry, indexed via `$5B29` |
| Spawn-template table | `$5B55` | 9 bytes/entry, indexed as `index*9 + $5B55` |
| Movement-script entry-point table | `$5B00` | 41 entries, ascending, half-byte-offset into `$5BAF` |
| Movement-script bytecode pool | `$5BAF` | shared, variable-length scripts (`$B8F9`/`$B920` format) |
| Fixed persistent object slots | `$9D1E` / `$9D24` / `$9D2A` | set up by `$B730`; referenced by spawn-template bytes 7/8 |

## Open questions

- Config-row word `$0A` (`$5B56`/`$C2E1`/`$5B7A` pokes) — exact effect on
  screen/timing not confirmed.
- Where the **column-source pointer `$9BA9`** is first pointed at real level
  data each level (it is reset to the sentinel `$7D00` by `$A371`; the live
  hand-off point that makes it walk the relief cell stream is not yet traced).
- Full decode of a colour-scheme table entry (3-byte stride assumed from
  `$A4E7`, individual byte meanings not confirmed).
- Formation-tag → group-index → spawn-budget → spawn-template chain
  (`$5B29`/`$5CF4`/`$5B55`) and the full 9-byte template field layout are now
  confirmed (see §4). Still open: `$5CF4` byte 1's role; template bytes 0-4's
  individual meaning beyond their destination fields; the exact purpose of the
  fixed-slot read/`EX (SP),HL`/write sequence after the spawn loop (looks like
  a linked-list link-in, not confirmed); and why template byte 1 coincidentally
  lands on the unrelated `$5B56` screen/timing-poke address.
- Whether the scenery-script event table `$6E06` entries are per-level or global.
- What the 2×2-block character codes (`$7900-$7CFF`) resolve to as pixel
  graphics — the `$C8B8` pass scales each code (×8) into screen writes, but the
  actual character-graphics source they point at is not yet traced. (Note:
  the *sprite* format for objects — player/enemy planes, tanks, boats — is a
  separate, fully-decoded system; see the masked-sprite data at `$CA09`+ and
  the `draw_sprite_*` routines, not covered by this document.)
