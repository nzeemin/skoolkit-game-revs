# Room Format

How Joe Blade rooms are addressed, stored, and drawn to the screen. Joe/soldier behaviour (collectible effects, shooting, soldier AI) is covered in [Actors.md](Actors.md).

## Room addressing

- `$8203` - room number within the current level, masked to `& $07` (0-7) wherever used for indexing.
- `$8204` - level/row number, masked to `& $0F` (0-15) wherever used for indexing. Incremented/decremented by 1 (wrapping `& $0F`) inside $7E32 when Joe walks off the top/bottom edge of a room - i.e. this is a vertical room coordinate in a 16-row x 8-column room grid, not a separate "campaign level".
- `$8202` - combined room-tile index, computed once per frame at $8114 as `room + 8*level` (range 0-127). This is the index used everywhere else: $8300 (per-frame tile lookup), $9700/$7900 (threshold tables), and the collision code around $8CF0/$9134+.

## Background tile format (confirmed)

Every background/sprite tile is a 32x32 1bpp block, 128 bytes (32 rows x 4 bytes).

## Room-selector table at $C000+ - confirmed

$8C00 computes an offset into the paged-in RAM bank ($C000+offset, same 128K bank mechanism used around $8A12) from room/level:

```
offset = level*128 + room*16
```

**Confirmed live (ZEsarUX/ZRCP session)**: this is a flat 16-level x 8-room x 16-byte table, 2048 bytes, $C000-$C7FF, and it never requires a bank switch - the whole grid lives in the single RAM bank (bank0) that's already paged in at $C000 by the time the game starts, and stays paged in throughout. Sampled several rooms directly from the running game (not a frozen menu-time snapshot): level0/room0 ($C000), level1/room0 ($C080), level3/room0 ($C300), and the actual starting room level15/room3 ($C7B0) - all decode cleanly through the selector formula below to plausible $E000-$FFFF tile addresses, no opcode-looking bytes anywhere.

An earlier pass, based on decompressing a `.z80` snapshot frozen at the main menu (before 'S' was pressed, so not necessarily the bank the game actually uses once running), found what looked like Z80 code past room 3 in one sampled bank and concluded the table only covered a few rooms before code took over. That was mistaken - it was sampling a bank the live game never actually pages in. There is no per-level `OUT ($7FFD)` anywhere in the reachable code (confirmed by scanning the full $0000-$BFFF for `LD BC,$7FFD`/`OUT (C),A`; the only such sites, at $6001-$602A and $8A1C-$8AF6, toggle only between bank0/bank1 for UI double-buffering, unrelated to rooms). This matches the standalone 48K release of the game, which has no level/room-bank split at all - the 128K release simply doesn't need one either, the whole table fits in one bank.

Each 16-byte room-slot is exactly the 2x8 grid of selector bytes $8C00 draws (one byte per 32x32 tile, 2 rows x 8 columns = 256x64px).

### Selector byte format (confirmed)

```
bit 0       : tile variant select (0/1)
bits 1-5    : tile index (0-31)
```

Decoded source address of the tile bitmap:

```
D = $E0 + ((byte >> 1) & $1F)
E = bit0 ? $80 : $00
addr = D*256 + E          ; range $E000-$FFC0
```

i.e. tile bitmaps live at $E000-$FFFF: 64 tiles x 128 bytes = 8192 bytes, matching "every tile is 32x32 B/W".

$C800-$DFFF, right after the 2048-byte selector table, is not more table data or code - it's sprite/mask graphics ($C800-$CFFF inmate sprites, $D000-$DFFF Joe sprites, see [Actors.md](Actors.md)), which is consistent with bank0 being the one and only bank ever paged in: these addresses behave as fixed graphics banks precisely because nothing ever pages them out.

## Draw pipeline (confirmed)

1. $8114 - per-frame setup: computes $8202 from $8203/$8204, looks up the current tile in the table at $8300, redraws the room's attribute colours (not a status bar - see Terrain-flags below), then falls through $FFAD, $7D96 (clamps $9700+/$7900+ threshold tables) into $8F00 (main game loop).
2. $8C00 - reads the room's 16-byte selector block from the paged bank, decodes each byte via $8C5A into a 32x32 tile stamp, builds a 2x8 grid (256x64px) into a shadow buffer at $B800.
3. $8CF0 - draws one more row of 8 tiles using a *different*, non-paged selector table at $6C00 (indexed by `$8202 * 8`), straight onto the live screen at $4080 - bypassing the shadow buffer. Reason: the shadow buffer only covers the 2-tile-tall band that changes frame-to-frame (Joe/soldier movement + jump height); this row is static per-room, so it's drawn once directly (see Open questions for the original note). Table decoded below.
4. $8C78 - later in $8F00, flushes the shadow buffer at $B800 into the real screen bitmap starting at $4800.

### $6C00 table (confirmed)

128 x 8-byte rows, one per tile ($8202, 0-127), spanning exactly $6C00-$6FFF (1024 bytes - ends precisely where the sprite/mask data at $7000 begins, confirming the bounds). Same selector-byte format as the paged $C000 table: `bit0=variant, bits1-5=tile index (0-31)`, decoding to a source address `$E0+((byte>>1)&$1F) : (bit0?$80:0)` in the $E000-$FFFF tile range.

The ctl for this whole region was fragmented into ~50 spurious `t`/`b` blocks by the same text-detection heuristic that mangled $9D00 - fixed into one clean 128-row array. Spot-checked tile $7B's row ($6FD8-$6FDF: bytes `$21,$20,...,$16,$16,$16`) - all decode to plausible $E000-$FFFF addresses, consistent with real tile data (not code, unlike parts of the paged $C000 table).

Total background coverage from steps 2-3: 3 tile-rows = 96px vertical (roughly the top half of the 192px screen). The bottom portion of the screen is filled separately by $8250 (called from $828C, called from $8114) using a **fixed**, non-paged data table at $8380/$82BE - this looks like a static HUD/border decoration shared by all rooms, not per-room graphics.

## $9700/$7900: per-tile tables

Both are word arrays, 128 entries (256 bytes) indexed by `$8202`. Each pair is `[low byte][high byte]` at `$9700/$7900 + 2*idx` and `+2*idx+1`.

**Low byte of $9700** is a soldier movement-pattern selector - see [Actors.md](Actors.md) for the full breakdown (confirmed 4/4 against known room layout). **Low byte of $7900 is a second movement-pattern selector, sharing the same dispatch code** ($8E53 sets H=$79 and falls into $96CE, the shared body of $9700's dispatcher $96CC - see [Actors.md](Actors.md)'s "Per-frame soldier update" section). If nonzero (1-6), it overrides the normal per-frame soldier update: execution jumps straight into the matching movement-pattern routine instead of $8E64's usual sprite-copy/dispatch/shoot-gate sequence.

**High byte of each pair** is what $7D96 clamps every frame: $7900+ into range $4E-$9D, $9700+ into range $46-$A5. Originally guessed as per-tile ceiling/floor Y collision bounds. Revised after exploring the shooting mechanic (see [Actors.md](Actors.md)): $7869 (the shot-hit check) reads the $7900 entry for the current tile and compares it against Joe's **X**, not Y. So the high byte may be a per-tile X threshold (e.g. a soldier post/wall position used for hit detection) rather than - or in addition to - a Y bound. Not yet live-verified.

## Terrain-flags byte $820C

Set every frame at $8114 from the table at $8300 (indexed by the same $8202 tile index). Cross-referencing every masked read of it across the codebase gives this bit map:

```
bit 0       : blocks rightward room-jump (checked mid-jump in $7F6E)
bit 1       : blocks leftward room-jump (checked mid-jump in $7FA0)
bit 2       : up-transition on the right side (level $8204++)
bit 3       : down-transition on the right side (level $8204--)
bit 4       : up-transition on the left side (level $8204++)
bit 5       : down-transition on the left side (level $8204--)
bits 6-7    : room colour zone (2-bit value, decoded below)
```

**Bits 6-7, decoded (confirmed live):** $8114 computes `attr = ((820C>>6)&3) + $44` and fills 0x1C0 (448) bytes at $5880 with it - that's 14 rows of the attribute file (roughly the whole play area, not a thin status bar as originally assumed). `$44` = `01000100`: BRIGHT=1, PAPER=black, INK=4. Adding the 2-bit zone value cycles INK through 4-7 = green/cyan/yellow/white, so bits6-7 select the room's colour (bright INK-on-black, PAPER always black) for most of the screen.

Checked against actual observed room colours (PAPER confirmed always black):

```
$7B (initial room)        white  -> zone 3   $8300[$7B]=$C1 (bits6-7=11) ✓
$7A (left of initial)     white  -> zone 3   $8300[$7A]=$E2 (bits6-7=11) ✓
$72 (down from $7A)       yellow -> zone 2   $8300[$72]=$91 (bits6-7=10) ✓
$71 (left from $72)       yellow -> zone 2   $8300[$71]=$8A (bits6-7=10) ✓
```

4/4 exact match - bits6-7 fully confirmed, not just internally consistent.

**Bit 0/1 direction corrected** - an earlier pass had $7F6E/$7FA0 (and the UP+LEFT/UP+RIGHT jump-arc triggers that feed them) backwards. Rederived directly from the code: $7F6E's "else" branch increments Joe's X (`INC A; INC A`) and is reached via $8209 bit0, which $7F09 sets on input `$820A & $0B == $09` = bit0(right) + bit3(up) - so $7F6E is the **rightward** jump-arc (boundary X=$E6, room++), and $7FA0 is the **leftward** one (boundary X=$00, room--, triggered by UP+LEFT). Confirmed against real room data - see "Ground-truth room check" below.

Bits 2-5 line up exactly with the four edge-transition blocks in $7E32 (up/down x left/right level change). The combined `bits4-5` also recurs as a left/right-edge *selector* (not a gate) in the collectible-pickup routines (see [Actors.md](Actors.md)) and in $7B29/$8D3C/$9118 - so "doors" may have been too narrow a label; bits4-5 more likely mean "this tile's interactions are edge-triggered, and this is which edge", used by both the level-transition system and the collectible system. Confirmed by cross-reference of AND-masks at every read site.

## Per-room event/object flags at $9500

128-byte array ($9500), one byte per room-tile ($8202), read every frame by $9602. Bit map:

```
bit 0, 1     : unused (NOPed out in this build)
bit 2        : draw door graphic column 1 ($90AA)
bit 3        : draw door graphic column 2 ($85DC)
bit 4        : draw door graphic column 3 ($95E6)
bit 5        : key-gated door (confirmed - see below)
bit 6, 7     : unused (NOPed out in this build)
```

Bits 2/3/4 each draw one column of what's presumably a single 3-column-wide door/gate object, all animated from the same per-frame table at $8600+ indexed by counter $8206 (bits 1-2, 4 frames) - just at 3 different destination columns in the shadow buffer ($B884/$B890, $B888/$B894, $B88C/$B898 respectively).

**Bit 5, decoded (confirmed):** gates $FFE8 -> $9880, which only runs while Joe isn't mid-jump ($8209=0). $9880 checks whether the current tile has an up-door flag in $820C (bit4=left side, bit2=right side) and Joe is standing at that edge with UP pressed. With keys in stock ($8215), it consumes one and redraws the key-count digit; with none, it **clears the UP bit in $820A before $7E32 processes it**, blocking the level-up transition outright. So bit5 marks specific doors as toll-gated: you need a spare key to open them, on top of whatever $820C's door bits already require. This is a second role for the key counter beyond the simple pickup tally (see [Actors.md](Actors.md)).

**$9602 turned out not to be the room-transition code** - it only draws in-room animated door/object graphics for the *current* room-tile. $8D3C looked like a room-transition trigger (compares the current tile $8202 against a table of 6 tile IDs at $9D18, fires when Joe is at the screen edge X=$20/$C0 on a matching tile) but **$7800, its target, is actually the bomb-deactivation minigame** ("SELF DESTRUCT IN 30 SECONDS", confirmed by decoding $7BA8's message text): it clears the screen and drops into the access-code sorting puzzle (two cursor-selected "green" letters swap places, see [Actors.md](Actors.md) for the full breakdown) - solving it returns to gameplay via $7AE5; running out the 30s timer ends the game via $8EB4. So the 6 tagged tiles at $9D18 are the **bomb tiles** (same table used for the bomb-pickup counter, see Collectibles in [Actors.md](Actors.md)) - touching one at the screen edge triggers deactivation rather than a simple pickup. Live-decoded, they're scattered rather than clustered: `$67,$05,$24,$49,$5A,$6A` decode (`room=byte&7, level=byte>>3`) to levels 12,0,4,9,11,13 - spread across most of the level range, same pattern as the keys table. An earlier pass mislabeled this whole cluster ($7800/$7A28/$7A78/$7BC4/$7BE8/$7C3F/$7C65/$7CA4) as a "control-options screen" - corrected after decoding the message text.

**Resolved**: room-to-room movement is two different mechanisms depending on axis:

- **Level (row, $8204) transitions**: handled directly in $7E32. Four near-identical blocks check an up/down input bit AND a 'door' flag bit in $820C (the current tile's terrain-flags byte, built at $8114) AND Joe standing at the screen edge (X&$E0 = $20 or $C0). If all three match, $8204 is incremented/decremented (wrapping 0-15) and execution jumps straight back into $8114 to redraw the new level's background. No jump/animation involved - it's an instant flip gated by a per-tile flag, i.e. only "door" tiles at the room edges allow a level change.
- **Room (column, $8203) transitions**: happen as a side effect of jumping off the edge. $7E32 detects an UP+RIGHT or UP+LEFT input combo and sets $8209 to 1 or 2, which routes into the jump-arc step routines $7FD2/$7FDC (called every frame while the jump is in progress). Those, in turn, call $7F6E (rightward arc, X increasing) or $7FA0 (leftward arc, X decreasing), which watch Joe's X and once it wraps past the edge ($E6 for the rightward arc, $00 for the leftward one), increment/decrement $8203 (wrapping 0-7) and reset X. So changing rooms requires an actual jump off the left/right edge, not just walking. (An earlier pass had the left/right labels on $7F6E/$7FA0 swapped - corrected after ground-truth room data exposed the inconsistency, see below.)

Both mechanisms only touch $8203/$8204 - no $7FFD paging is triggered by either, consistent with the confirmed finding that bank0 holds the entire room grid and no bank switching happens during gameplay at all (see the Room-selector table section).

## Ground-truth room check

From live gameplay knowledge: the starting room (only a left exit, no items, no soldiers) and its left neighbour (a key, two exits: down-door-left and right, plus a soldier).

Initial state: room=$8203=3, level=$8204=$0F(15) (from the $8228 init-values block), so $8202 = 3+8*15 = $7B. The room to the left = room 2, same level, $8202 = 2+8*15 = $7A.

- **Tile $7A is the 10th entry in the keys table ($9D00)** - exact match for "has a key", and independent confirmation of the `$8202 = room + 8*level` formula.
- **$8300[$7B] = $C1 = 1100 0001**: bit0=1 (blocks rightward jump - matches, no right exit), bit1=0 (leftward jump open - matches, left is the only exit).
- **$8300[$7A] = $E2 = 1110 0010**: bit0=0 (rightward jump open - matches the right exit), bit1=1 (leftward jump blocked - matches: this room's "left" exit is actually the down-door, not a plain room-jump), bit5=1 (down-door on the left side - matches the "left-down" exit exactly).

All four bits check out once bit0/bit1 were corrected to mean "blocks rightward/leftward jump" (see Terrain-flags section) rather than the originally-guessed "left wall/right wall".

Extended one level further via the down-door-left from $7A: level 14, same room (2), tile $72 = 2+8*14. Then a plain leftward jump from there: room 1, same level, tile $71 = 1+8*14.

- **Room down from $7A** (level 14, room 2, tile $72): exits left-up and left, no items/soldier. $8300[$72] = $91 = 1001 0001: bit0=1 (right blocked - matches, no right exit), bit1=0 (left open - matches "left" exit), bit4=1 (up-door-left - matches "left-up" exit), bits2/3/5=0 (no other doors - matches). **All bits match.**
- **Left from there** (room 1, level 14, tile $71): exits right-down and right, has a soldier. $8300[$71] = $8A = 1000 1010: bit0=0 (right open - matches "right" exit), bit1=1 (left blocked - matches, no left exit), bit3=1 (down-door-right - matches "right-down" exit), bits2/4/5=0 (matches). **All bits match.**

Six data points, six matches - the $820C bit map (as corrected) is now solidly confirmed by cross-reference against real room layout, no live tracing needed for this part.

Soldier presence at these 4 tiles was also checked - see [Actors.md](Actors.md)'s "Soldier placement" section (4/4 match against $9700's low byte).

## Open questions

- The 2-byte gaps between tables ($9D1E-$9D1F, $9D22-$9D23) - unexplored, might be more table data or padding.
- Whether $7900's per-tile value is genuinely reused for both a Y clamp ($7D96) and an X threshold ($7869), or whether one of those readings is wrong.
