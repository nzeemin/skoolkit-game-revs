# Robin of the Wood — Rendering

How anything reaches the screen: the shadow buffers, the room/sprite/glyph draw paths, and
the dirty-cell flush. Room and block *data formats* are in `Room-Format.md`; actor state and
frame selection are in `Actors.md`; the message/icon system is in `General.md`.

## The short version

The game never draws directly to the Spectrum screen during play. Everything is composed into
a **shadow screen** in high RAM, and only changed character cells are copied out to `$4000`
afterwards. Three different writers compose into that shadow buffer, and they do not agree on
a single blending rule:

| Writer | Routine | Blend onto shadow |
|---|---|---|
| Room blocks (scenery) | `$C0D1` | **overwrite** (`LD (HL),A`) |
| Sprites (actors) | `$C6D6` | **XOR** (`XOR E`/`XOR D`/`XOR C`) |
| Font glyphs (HUD/icons) | `$C5E4` | **XOR** (`XOR (HL)`) |
| Message text/icons | `$D6DB` | **XOR**, or plain overwrite when `$D7F2` is set |
| Witch door-flash noise | `$DACB` | **XOR / OR, alternating** (self-modified, see below) |

## Memory map

| Address | Size | Contents |
|---|---|---|
| `$4000` | 6144 | Real Spectrum screen pixels (written only by `$C85C`/`$C806`/`$CE81`) |
| `$5800` | 768 | Real Spectrum attributes (written by `$C18E` on room change, and per changed cell by `$C85C` each frame) |
| `$9AB3` | — | HUD/status font used by the `$C5E4` glyph plotter |
| `$AD31`-`$B432` | 2048 | Message font, 256 glyphs `$00`-`$FF` (see `General.md`) |
| `$8D80` | — | Robin's sprite-frame pointer table (frame number x2) |
| `$8E12` | 10 | Source-run pointers for the sprite background save |
| `$5B00` / `$5BA8` | — | Block address table / block pixel+attribute data |
| `$C682` | — | Horizontal-mirror index remap for 6-cell glyph rows |
| `$E500` | 576 | Changed-cell flag area, 18 rows x 32 (28 used, 4 padding) |
| `$E800` | 576 | Shadow attributes |
| `$EB00` | 4608 | Shadow screen pixels, 144 lines x 32 bytes |
| `$FD00` | 256 | Bit-reverse lookup table (entry N = N with bits reversed) |
| `$FE00` | 384 | Screen row-address table, 192 entries of 2 bytes |

The playfield is **18 character rows x 28 columns**, inset from the full 32-column screen —
`$C18E` and `$C85C` both skip the left/right margins, and `$C18E` copies from `$E802` to
`$5802` rather than from the buffer bases.

**Sprite clipping is this window, not a test.** Neither `$C6D6` nor `$C790` bounds-checks a
sprite's position — `$C6D6` masks the shadow column to `AND $1F` and lets an off-edge sprite
wrap within its 32-byte row; `$C790` flags margin cells like any other. What stops a sprite
drawing over the border is that `$C85C` scans only columns 2-29 (`LD HL,$E502`, `LD B,$1C`,
then `INC L/INC HL/INC L/INC L` to the next row) and rows 0-17 (`LD IXl,$12`), and `$C18E`
uses the same 28-wide window. The vine border sits in / against columns 0-1 and 30-31, which
no flush ever writes, so a sprite walked to the edge is drawn and flagged in the shadow
buffer there but never copied out — it slides under the border and is cut at the playfield
edge with no explicit clip.

### The two startup tables

Both are built once at startup and then used everywhere instead of recomputing addresses:

- **`$FD00`** (built by `$CFEE`): bit-reverse table. Every horizontal mirror in the game goes
  through it — block mirroring (`$C1D6`), glyph mirroring (`$C5E4`), sprite mirroring
  (`$C8B7`), and the message printer's `$02`/`$03` mirror control codes (`$D6C0`). Each use
  works by **self-modifying the low byte of a `LD A,($FD00)` operand** with the value to
  reverse, then reading the patched address — i.e. the table index is written into the
  instruction, not held in a register.
- **`$FE00`** (built by `$D004`): entry N is the pixel address of screen line N, so the ZX
  screen's non-linear third/row/scanline layout is worked out exactly once. `$C806`, `$C85C`
  and `$CE81` index it via IX/IY.

Note the `$FE00` bytes visible in the snapshot are tape-loader leftovers from before `$D004`
ran, not table data.

### `$E500` is triple-purpose

The same 576 bytes serve as:
1. the **changed-cell flag area** — one byte per cell, non-zero = dirty (`$C85C` scans it).
   The flag byte is not a boolean: it holds an **attribute value**, and `$C85C` uses it as
   the cell's colour whenever the underlying scenery attribute is `$00` — see "How actors
   stay visible" below. `$C790` writes the flags for a sprite's footprint (from the fixed
   colour ramp at `$8E1C`); `$BD2A` writes `$46` for the arrow;
2. a **startup speech bitstream buffer** — `$CD6C` plays from `$E500` before the game proper
   begins.

## Draw pipeline, per frame

`$BF80` (main loop) runs in this order:

1. Actor updates (`$C6A2` Robin, `$AA31`/`$DBF8`/`$BBC1`/`$B919` others) — each calls `$C6D6`
   to plot its sprite into the shadow screen and mark its cells dirty.
2. Collision/hit checks (`$BD49`/`$BDA3`/`$BDE0`/`$BE43`).
3. **`$C85C`** — flush changed cells from `$E500` to the real screen.
4. Event/message scanning (`$D7F3`/`$DF03`) — may print glyphs/icons via `$D619`/`$D631`.
5. HUD draw (`$C055` game-over check, `$C4D2` special-event redraw).
6. Room-edge check, scroll to the adjacent room via `$C22F` if reached.

A full room change instead goes: clear shadow → `$C072` draw room → `$C15E`/`$C40E`/`$C517`
recolour passes → `$C18E` blit all attributes → `$C806` expand rows → `$C85C` flush.

## Room blocks — overwrite

`$C0D1` draws one block token. It looks up the block's data address in the table at `$5B00`,
then:

- copies `(header AND $1F) x 8` pixel rows, 4 bytes each, into `$EB00` — with plain
  `LD (HL),A` stores;
- copies `(header AND $7)` attribute rows (4 bytes each), or a single byte reused for every
  cell if the header's flat-attribute flag is set, into `$E800`.

Mirroring is decided by XORing three separate bits together — the block header's own
natural-mirror bit, the placing token's bit 7, and the room's world-map bit 7 — then applied
by `$C1D6`, which bit-reverses each pixel byte through `$FD00` *and* swaps bytes from the two
ends of each row inward. The column adjustment for mirrored blocks is itself self-modified
(`$C0E7`/`$C102`/`$C144`, patched with `$1C` or `$00` from the room byte).

Because blocks overwrite, the room is composed bottom-up with no blending: room-type tokens
first, then the additional-elements tokens painted on top (`$C072` calls `$C0AF` twice).

### Empty space and attribute coverage

There is **no background colour pre-fill**. The room redraw clears the shadow buffers first —
`$C029 XOR A` then `$D03F`, which fills `$E800`-`$EAFF` attributes with A and `$EB00`-`$FCFF`
pixels with `$00` — and then `$C072` goes straight to the token list. `$D03F`'s fill byte is
whatever the caller puts in A: the in-game room paths (`$C02A`, `$B8E3`, `$C4ED`, `$CE39`,
`$D086`) all pass `$00`, so a character cell that no block token covers is left as `$00`
pixels + `$00` attribute: black ink on black paper. (The main menu `$AC83` passes `$47` and
`$D0FF` passes `$45`, but those are not gameplay room draws.) It is never `$04`. `$C40E`'s
recolour pass explicitly skips zero attribute cells (`$C427 OR A / JR Z`), and only ever
writes `$07` or `$45`; the sole blanket-`$04` writer is `$C444`, which runs in room `$BB`
only and only on cells that already have a non-black paper colour.

Every cell that *is* covered gets its attribute from the block's own data. Sampling the
block table: block `$00` attrs are `$04` x12 then `$06` x4; block `$01` is
`$04,$04,$46,$46,$06,$06,$06,$04`; block `$0A`'s flat attr is `$04`. So the forest palette
is `$04` (green ink / black paper) almost everywhere, with `$06` (yellow) accents.

Blocks are 4 cells wide and up to ~4 cells tall (header `$04` = 32 pixel rows), so one token
paints a 16-cell swath, but the room token lists do **not** tile the whole playfield.
Confirmed live: in a forest room the shadow attribute area has large `$00` runs
across the open walkable band (e.g. cols 2-11 and 20-29 of several rows), and `$C18E`'s blit
copies them to the real screen verbatim (`LD A,(HL) / AND $7F / LD (DE),A`, no skip-zero). So
"empty" walkable space genuinely is `$00` — black ink on black paper — not `$04`.

### How actors stay visible over blank space

Robin still reads as green on that black background because `$C85C`, the per-frame flush,
substitutes a colour for blank cells. Its inner path (`$C876`-`$C887`) for each dirty cell:

1. reads the cell's `$E500` flag byte — which the draw routines set to an **attribute value**,
   not `1` (Robin's cells came up `$44` bright green; the arrow uses `$46`);
2. reads the cell's shadow attribute (`flag_addr + $0300`);
3. if that shadow attribute is **non-zero**, uses it — scenery keeps its own colour;
4. if it is **`$00`**, uses the flag byte instead (via a double `EX AF,AF'`);
5. writes the result to the real screen attribute (`+ $7000`), bit 7 cleared.

Verified live: with Robin standing on an untiled cell, `$E964`… (shadow attr) held `$00`,
`$E678`… (the `$E500` flags) held `$44`, and `$C85C` was caught at `$C887` writing `$44` to
`$5979` (real attr). So the sprite drags a green attribute patch with it: the colour is
injected by the flush from the flag byte, not carried by the frame data and not present in
the room. This also means an actor on a cell a block *did* paint takes that block's colour
(step 3), which is why Robin can briefly tint to a scenery colour where he overlaps foliage.

## Sprites — two frame formats, XORed onto scenery

`$C6D6` is the single sprite plotter for every actor. Its calling convention is unusual: the
**frame base is self-modified into the routine** — callers do `LD ($C6D8),HL` before calling,
so `$C6D7 LD HL,$0000` is a lie in the listing (`$8D80` for Robin, `$8DC4` for regular guards,
`$8DEA` shared by the Sheriff/Bishop/boars/the digit-blink object). A is the frame number,
doubled to index that base and fetch the frame's data address.

A frame's own byte 0 is a header whose low nibble is a **width class**, tested by `$C585`
(`CP $4`). This splits sprite frames into two entirely different formats:

- **Wide (nibble >= `$4`)** — a **glyph-grid** format, confirmed this session by rendering and
  cross-checking against live footage. `$C585` doesn't return; it falls through into the old
  glyph-string drawer (`$C5D8`/`$C5E4`) and treats the frame's own bytes from offset 1 onward
  as a sequence of character codes into the **`$9AB3` tile sheet** (180 tiles, `$00`-`$B3`,
  8 bytes each — the same mechanism icons like `$B495`'s sword use, and mostly interchangeable
  body-part pieces rather than text glyphs). Fixed layout: 6 columns x 5 rows of codes (`$00`
  = blank cell, skipped but still advances the column), plus the header. Two attribute
  sub-formats exist: 32 bytes total (header + 30 codes + 1 **flat** attribute byte covering
  the whole frame — Robin's own action frames use this, confirmed `$44` bright green
  throughout) or 61 bytes (header + 30 codes + 30 **per-cell** attribute bytes, one per glyph —
  the shared `$8DEA` base uses this, confirmed via the Sheriff's real yellow/magenta colours).
  Which format a given frame uses isn't tied to a specific header bit yet — open question.
- **Narrow (nibble < `$4`)** — `$C585` returns immediately (`RET C`) and `$C6D6` uses its own
  row-tuple loop instead (below) — a true bitmap, not a tile mosaic. Byte 1 is a raw scanline
  count; from byte 2, 3 pixel bytes (24 px wide) per scanline. Confirmed by rendering (e.g. a
  32-scanline frame at `$9454`); no per-frame attribute bytes exist for this format, so colour
  for these frames still comes from the `$8E1C` stamp below.

Sequence, either format:

1. `$C585` — sets up the draw as above; for both formats, B/C (row/column, see "Position" below)
   get converted into a shadow-screen address (`$C5D1 LD BC,$EB00`).
2. `$C790` — **stamps the frame's cell-colour pattern into `$E500`**. It copies the fixed
   attribute run at `$8E1C` (`44 45 07 45 05 47 43 42` — a shared bright-colour ramp, not
   per-actor) over the footprint, one byte per cell, `$20` down per row. `$8E12` (indexed by
   the frame's flag byte) picks the start offset and length (8/7/3/2/1). Flag-byte bit 7
   NOPs the `$C7F0 INC BC` so one colour repeats across a row (mirrored frames); bit 6 does
   the same for the row step at `$C7FB`. These bytes are the dirty flags `$C85C` reads, and
   — for narrow-class frames, which carry no attribute data of their own — the colour it
   falls back to on `$00` scenery.
3. `$C8B7` — horizontally mirrors the frame's row data if needed (via `$FD00`).
4. **Narrow-class only**: the row-tuple plot loop at `$C723`-`$C739` — for each scanline, a
   3-byte tuple is read, shifted to the sub-cell pixel offset by `$C74D` (a shift-copy chain
   at `$C74F` with a `RET` **patched in** at the right place to stop after `(column AND 3)*2`
   bits), then the shifted bytes are XORed onto 4 consecutive shadow-screen bytes.
   **Wide-class**: pixels are drawn instead by the glyph loop at `$C5E4`/`$C601`-`$C611`
   (8x8 tile blit, XOR `$AE`, never patched) as part of `$C585`'s fall-through.

### Position: X is 2-pixel units, Y is real pixels

`$CC85` (X) and `$CC86` (Y) do **not** share a pixel scale. Confirmed from `$C95A`'s movement
step (`LD HL,($CC85)`, so L=X, H=Y):

```
right: INC L        ; X += 1
left:  DEC L         ; X -= 1
down:  INC H; INC H  ; Y += 2
up:    DEC H; DEC H  ; Y -= 2
```

X moves 1 unit/frame, Y moves 2 units/frame — matched so that **both axes cover the same 2
real screen pixels per frame**: X is stored in 2-pixel units (real X = `$CC85`*2), Y in real
pixels. This also makes the cell-boundary gates in `$C95A`/`$C9E7` symmetric once converted:
X's `AND $03` (multiple of 4 stored units = 8 real px) and Y's `AND $07` (multiple of 8 real
px) both mean "aligned to one 8px character cell." Robin's spawn position, `$CC85`=`$40`
(64) / `$CC86`=`$50` (80) — baked into the ROM, never written by game-start init — is
`$40*2 = 128` real pixels horizontally: the exact center of the 256px-wide display.

`$C585` converts the incoming B (row)/C (column) — Robin's `$CC86`/`$CC85` for his own sprite
— into a screen-cell address with a real bias, not a literal top-left placement:

```
char_row = (Y >> 3) - 1        ; $C5B9-$C5CF: H = B/8, then DEC H (Y already real pixels)
char_col = (X >> 2) - 3        ; $C5C0-$C5C5: A = C/4, then SUB $03 (X>>2 == real_X>>3,
           (- 1 more column if the glyph is mirrored, bit 7 of the caller's own A)   given the 2px encoding)
```

Both formulas are secretly the same `real_pixels >> 3` (character-cell) division — X's `>>2`
only looks different because it's still in 2-pixel units at this point. For frames 6-9
glyph-columns wide, `-3` is close to half that width — **X is used as the sprite's
horizontal center**. `-1` row (8 px) is nowhere near centering a 3-4-row-tall sprite, so
**Y anchors near the top of the sprite** (roughly head/shoulders height), not its center and
not a bounding-box corner on either axis.

**`$D543`/`$D4AD`'s stored positions use the same raw scale as `$CC85`/`$CC86`, not
character-cell col/row.** Confirmed from `$D997`, their writer:

```
position D = $CC85, floored at $10          ; Robin's raw (2px-unit) X
position E = ($CC86 AND $F8) + $10          ; Robin's raw Y, snapped to an 8px cell boundary, +$10 bias
```

Cell-snapped and offset, but never converted into the 0-27/0-17 char-cell range — `$D7F3`'s
own position-match test against these bytes uses the identical raw-unit, `$18`/`$10`-biased
comparison (see `Objects.md`).

**Icon print position is a literal top-left corner, unlike Robin's own centered/anchored
sprite draw.** `$D631` receives the same posD/posE in DE, pushes it twice, and pass 1
(`$D661`-`$D686`) uses it with no bias constant at all:

```
row_offset = posE * 32   ; 5 doublings total, onto the $EB02 shadow base - posE used as a
                          ; literal raw pixel row (0-191), not divided down to a char row first
column     = posD / 4    ; SRL C twice - exact character column (posD/4 == real_X/8), no offset
```

`posE` is the literal top scanline the glyphs draw from (the loop proceeds downward);
`posD/4` is the literal left column. No `-3`/`-1` centering subtraction anywhere in this
path — that bias is specific to `$C585`'s sprite placement. The second pushed `DE` copy is
popped again at `$D746` (confirmed via the peek-then-restore at `$D719`/`$D71A` and the
`$D72C`/`$D745` pops) for the attribute pass's own row/col derivation from the *same*
posD/posE bytes, reinterpreted with `$D746`'s own bias (`row = posD/4 + 2`).

### Erasure — a double-buffered position/frame triple

`$C8F7` (the per-object animate/redraw step) keeps **two copies** of the frame/X/Y in the
object record, `(IX+5..7)` (old) and `(IX+8..10)` (new — for Robin, `IX+9`/`IX+10` *are*
`$CC85`/`$CC86` directly, no separate copy):

```
status bit 1 (erase): A,C,B = (IX+5),(IX+6),(IX+7)   ; old frame/X/Y -> CALL $C6D6 (XOR off)
status bit 2 (step):   A,C,B = (IX+8),(IX+9),(IX+10)  ; new frame/X/Y (Robin's live position)
                        LDDR: copy (IX+8..10) down into (IX+5..7)
                        CALL $C6D6 (XOR on, at the new position)
```

So erasure is just the same XOR-plot run a second time at the *previous* position before the
step redraws at the current one — no saved background, no separate erase routine. This
resolves the open question below (previous revisions of this doc left it unconfirmed).

## Glyphs and message text

Two separate glyph plotters exist:

- **`$C5E4`** (HUD/status font at `$9AB3`, set up by `$C585`): XOR-plots 8 rows per glyph into
  `$EB00`, with a blank-glyph shortcut when the row lookup yields zero, then packs the
  row/column into an `$E500` offset to mark the cells dirty. `$C682` remaps indices for
  6-cell glyph rows when mirrored.
- **`$D619`/`$D631` → `$D661`** (message font at `$AD31`): the two-pass message printer
  described in `General.md`. Its first pass XOR-plots glyph rows (`$D6DB XOR (HL)`) **unless**
  `$D7F2` is non-zero, in which case it takes the `$D6D7` branch and stores the byte directly
  — an explicit **overwrite mode**. Its second pass writes one attribute byte per glyph.

The arrow is a special case: `$BD2A` toggles it by XORing `$FF` into its collision byte and
writing `$46` into the `$E500` buffer as its dirty flag — that byte doubles as the arrow's
fallback attribute (bright yellow) when the cell under it is blank, see below.

## Getting it onto the real screen

- **`$C85C`** (per-frame): scans the `$E500` flag area, 28 columns x 18 rows, from `$E502`.
  For each non-zero flag it (a) writes the cell's **attribute** to the real screen — the
  shadow attribute if non-zero, else the flag byte itself (the "How actors stay visible"
  path above), bit 7 cleared — and (b) computes the real screen pixel address from the
  cell's row/column and copies that cell's 8 bytes from the shadow pixels, then clears the
  flag. This is the only per-frame path to `$4000`, and the per-frame path to the playfield
  attributes at `$5800`.
- **`$C18E`** (on room change): unconditional blit of the whole shadow attribute area
  `$E802` → `$5802`, 18 rows x 28 bytes, **clearing bit 7 of each byte as it copies**.
- **`$C806`** (on room change): walks `$FE00` with IX and copies 32 bytes per row from each
  listed address into the shadow area from `$EAFE`, 18 rows.
- **`$CE81`**: the side-wipe transition used by the intro/victory screens.
- **`$C517`**: a left-to-right wipe — marks each column dirty in turn and calls `$C85C` after
  each, so the flush itself produces the wipe animation.

## Attributes

Attributes live in the shadow area at `$E800` and are written by:

- `$C0D1`, per block, from the block's own attribute rows (or one flat byte) — this leaves
  every cell no token covered at `$00`;
- recolour passes on room entry — `$C40E` (scans the 26 bytes at `$C550` for the room and
  recolours `$E800`-`$E9FF` on a match; skips `$00` cells) and `$C444` (room `$BB` only:
  forces every cell with a non-zero paper colour to attribute `$04`, flattening the
  background);
- the message printer's second pass, per glyph.

The real-screen playfield attributes at `$5800` come from `$C18E` on room change (a straight
blit of the shadow area, `$00` cells included) and then, every frame, from `$C85C` per
changed cell — which is where the `$00`-cell → flag-byte colour substitution happens.

The energy display is purely an attribute effect: the antler artwork (font glyphs at `$AF0B`
and `$AF83`) never changes shape — `$BF37` just recolours a 63-byte attribute strip over it.

## Did the author use OR to place sprites?

**No — the sprite plotter uses XOR, and the opcodes are never patched.** Verified against the
snapshot bytes rather than the disassembly text.

The inner plot loop at `$C72E` reads as:

```
C72E  7E        LD A,(HL)
C72F  AB        XOR E
C730  77        LD (HL),A
C731  23        INC HL
C732  7E        LD A,(HL)
C733  AA        XOR D
C734  77        LD (HL),A
C735  23        INC HL
C736  7E        LD A,(HL)
C737  A9        XOR C
C738  77        LD (HL),A
```

`$AB`/`$AA`/`$A9` are `XOR E`/`XOR D`/`XOR C`. The OR equivalents would be `$B3`/`$B2`/`$B1`.
The same holds for the two glyph plotters: `$C60A` and `$D6DB` are both `$AE` (`XOR (HL)`);
`OR (HL)` would be `$B6`. `selfmod.py` reports **no writes to `$C72F`/`$C733`/`$C737`/`$C60A`/
`$D6DB`**, so these are not self-modified into OR at runtime either — unlike the several
genuinely mutable opcodes elsewhere in the game, which the audit does find.

A search of the whole disassembly finds only three `OR (HL)` sites, none of them a pixel plot:

- `$C866` — `$C85C`'s dirty-flag test (is this cell non-zero);
- `$DDBB`, `$DDCC` — flag-byte manipulation in the boar code;
- `$DAC9`/`$DACB` — the Witch's door-flash **attribute** noise effect, which masks a
  pseudorandom byte and then blends it with `AND (HL)` + an opcode that genuinely
  **ping-pongs between `$AE` (XOR) and `$B6` (OR)** each cycle (`$DAEE`-`$DAF7`). This is an
  attribute flicker, not sprite placement.

Where the recollection probably comes from: the engine *does* have a non-XOR placement path,
just not an OR one. The message printer's `$D7F2` overwrite mode stores bytes directly, and
room blocks are plain overwrite copies — so "sprites are not XORed in" is half-true for
scenery and text, while actors specifically are XORed. And the one place OR really is used to
combine pixels-on-screen — `$DACB` — is both an attribute effect and only half the time an
OR at all.

## Open questions

- `$C806`'s purpose: what the rows it expands from `$FE00` into `$EAFE` actually represent
  (assembled per-row pixel or attribute data) is not fully confirmed.
- The exact meaning of each of `$C585`'s three self-modified branch targets
  (`$C603`/`$C5E3`/`$C647`) and the `$C651` patch byte.
- `$C517`'s flag-area row stride is `$1F` here versus `$1C` used elsewhere; not reconciled.
- Which header bit selects between the wide-class glyph-grid format's two attribute layouts
  (32-byte flat vs 61-byte per-cell): **header bit 7 correlates perfectly across every frame
  sampled so far** — `$86` frames (`$9A36`, `$9A56`, Robin's `$A190`-`$A210` action frames)
  are all 32-byte flat, `$06` frames (`$9A76`, `$A153`, `$A230`) all carry a real 30-byte
  per-cell stream. Not yet confirmed by finding the instruction that tests it, so it is a
  strong inference from data rather than a traced fact.
- Narrow-class row-tuple frames' colour: confirmed they carry no per-frame attribute bytes,
  so they must rely on the `$8E1C`/`$E500` stamp, but that hasn't been verified live for a
  specific narrow-class frame. (Narrow class itself is definitely live: guard frames
  `$00`-`$0F` off the `$8DC4` base — every walk, turn and aim pose — are all header `$03`.
  `$9454` is guard frame `$00`, the ordinary walking guard.)
