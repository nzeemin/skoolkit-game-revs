# General

Cross-cutting reference for porting: memory map, text encoding, and the menu/UI flow. Room/tile/collectible mechanics are in [Room-Format.md](Room-Format.md); Joe/soldier behaviour is in [Actors.md](Actors.md).

## Game memory map

Coarse map of the 64K address space as currently disassembled. `$C000-$C7FF` is the one RAM bank the game ever pages in (bank0) - see [Room-Format.md](Room-Format.md)'s Room-selector table section; everything else below is always-resident.

```
$0000-$3FFF  128K editor ROM (not part of this disassembly)
$4000-$57FF  Screen bitmap (standard ZX interleaved-thirds layout)
$5800-$5AFF  Screen attributes
$5CEB-$61FF  Unused/unreferenced gap (no code reads or writes here)
$6200-$6297  Bomb minigame instructions text ("...EXPLOSIVE DEVICES...")
$6298-$63FF  Bomb minigame access-code letter icons (5 x 24x24, 'A'-'E')
$6400-$67FF  Sparkle (kill effect) sprites + masks, 8 frames each
$6C00-$6FFF  Per-tile top-row selector table (128 x 8 bytes, used by $8CF0)
$7000-$77FF  Soldier sprites + masks - unreferenced by any code (see Actors.md)
$7800-$81A9  Code: bomb minigame, pickups, movement/collision, jump-arc
$81AA-$81E5  DrawSpriteMasked (32x32 masked blit primitive)
$81E6-$81FF  Code: control-options 'K' branch
$8200-$8227  Live game variables (Joe/room/soldier state)
$8228-$824F  Variables' initial values (copied to $8200 at game start)
$8250-$82BD  Code: bottom-screen graphics blitter ($8250), door drawing ($828C)
$82BE-$82FD  Bottom-screen fixed graphic source (64 bytes)
$82FE-$82FF  2 zero padding bytes
$8300-$837F  Per-tile terrain flags (128 bytes, indexed by $8202 -> $820C)
$8380-$83BF  Down-door graphic source (64 bytes)
$83C0-$83FF  Code: screen/border utilities
$8400-$84FF  Signs for title/menu screens
$8500-$86FF  Code: score/counter digit drawing, sound effects, popups
$8700-$88FF  (menu-adjacent code/data, not fully catalogued)
$8900-$895F  High-score table (6 x 16-byte rows, indexed by $8210)
$8964-$8FFF  Code: high-score entry, main menu, control options, game loop
$9000-$91FF  Code: soldier movement helpers, DrawStringIX
$9200-$94FF  Code: glyph drawing, collectible pickups, energy/death
$9500-$957F  Per-room event/object flags (128 bytes, indexed by $8202)
$9580-$96FF  Code: high-score name entry, door graphics, soldier dispatch
$9700-$97FF  Per-tile soldier movement pattern + boundary table (128 words)
$9880-$98FF  Code: key-gated doors
$9900-$99FF  Object sprites + masks
$9D00-$9D7A  Collectible tile-ID tables (keys/food/bombs/ammo/hostages/uniform)
$9D80-$9DFF  Item-placement scratch table (rotated by $9498 each game start)
$9E00-$9FFF  Running-line-of-symbols text/data
$A000-$A11F  "JOE BLADE" title sign bitmap
$A200-$A3FF  Digit/character glyph table (used by $FFB5) + collectible-scan code
$A400-$A5FF  Object sprites + masks (uniform, ammo)
$A600-$A74F  Font (A-Z, digits, punctuation - see Strings encoding below)
$A750-$A7FF  Code: jump/pickup sound effects, delay
$A800-$AFFF  Soldier sprites + masks (the ones actually drawn: $A800 facing
             left, $AA00 facing right, mask = sprite+$0400)
$B800-$B8FF  Shadow screen buffer (64 lines - only the band that changes per frame)
$C000-$C7FF  Paged bank0: room-selector table (16 levels x 8 rooms x 16 bytes)
$C800-$CFFF  Inmate sprites + masks
$D000-$DFFF  Joe sprites + masks (16 frames + 16 masks)
$E000-$FDAF  Background tile bitmaps (32x32 1bpp blocks)
$FDB0-$FFFF  Code: HUD attributes, high-score scroll, win/death screens,
             win-condition check, kill-sparkle (2nd slot), shoot logic
```

Font/tile/sprite data blocks are documented individually (with `#UDGARRAY` previews) in the `.ctl`/generated HTML - this table is for orientation, not a substitute for the per-block detail.

## Text encoding (DrawStringIX, $9196)

All in-game text - menus, HUD counters, popups, the bomb-minigame instructions - uses one custom font-code table, not ASCII:

```
'A'-'Z'      $00-$19   (A=0, Z=25)
'0'-'9'      $20-$29   (0=$20, 9=$29)
space        $1F
apostrophe   $1B
colon ':'    $1D
hyphen '-'   $1C
terminator   $FF        (ends the string)
```

**Drawing mechanism** (`$9196`, DrawStringIX): `IX` = string address (char-code array, `$FF`-terminated), `HL` = destination screen address. For each character:

1. Read the code, check for `$FF` (stop) or advance `IX`.
2. Decode a font-table source address: `D = $A6 + (code >> 5)`, `E = (code & $1F) * 8` - i.e. the code's high 3 bits select one of the font's 128-byte pages (`$A600`/`$A680`/`$A700`/`$A780`), the low 5 bits select the 8-byte glyph within that page.
3. Copy 8 bytes (one column of pixels per screen third-row) from the font source to the destination, advancing one scanline (`INC H`) per byte.
4. Advance `HL` to the next screen column, and recurse (`JP $9196`) for the next character.

Every on-screen string in the game (menus, HUD digits via `$925C`, popups, high-score names) is just an array of these codes fed through this one routine - useful as a single choke point when porting: retarget `$9196`'s screen-addressing and font source, and every text draw in the game follows.

## Menu/UI flow

```
Power-on / tape load
  -> $7D00 area (initial boot code)
  -> $8A12 (MenuWait): draws title, pages in bank1, waits via a
     poll-trampoline cluster ($8A00-$8A0F / $8A3C-$8AD0 - each variant
     runs a different bank1 sub-routine while the title animates)
  -> $8E96 (MenuIdleFlash): once ready, idles with a variable-duration
     border-flash effect while polling for a keypress
  -> $89B4 / $8B37: main menu loop, polls C / S / H
```

From the main menu (`$8B37`):

- **'C'** -> `$8BB4` (ControlOptionsEntry) -> `$8B64` (control-options screen): polls J (Kempston) / S (Sinclair) / K (keyboard), persists the choice to `$FFFF` (read back into `$820E` by the input reader `$8032`).
  - 'J' chosen -> `$83E1` (MenuKempston): brief pause, back to main menu.
  - 'K' chosen -> `$81E6` (MenuKeyboard): brief pause, into `$8E16` (InfoScreen) - instructions/help.
- **'S'** -> `$7D00` (StartGame): redraws the sign, resets variables via `$9498`, falls into the main game loop `$8F00`.
- **'H'** -> `$8DBE` (HiScoreScreen): reveals the high-score table row by row (`$FDCE`), waits for a key, returns to the menu.

**Post-game** (`$8EB4`, reached from death `$935E`, win `$FEB4`/`FF14`, or a bomb-minigame timeout `$783F`): if `$8210=5` (no new high score), returns straight to the main menu; otherwise shows "GOOD SCORING" and drops into `$9580` (HiScoreNameEntry) - a cursor loop for entering initials, storing each character via `$8964`, then back to `$8DBE`.

**In-game overlay** (not a menu screen, but the same "takes over the whole display" shape): the bomb-deactivation minigame (`$7800`) - triggered by touching a bomb tile at the screen edge (`$8D3C`), not from any menu. Solving it (or the 30s timer expiring) returns to gameplay via `$7AE5` or ends the game via `$8EB4`, same as the rest of the post-game flow.

## Porting gotchas

Traps that have actually caught people reading this code:

- **Data that looks like code pointers.** The $9700 per-tile table's entry for tile 22 ($972C) holds bytes $05,$93 - pattern 5, boundary 147, both entirely normal - but read as a little-endian word it spells $9305, which is a genuine mid-routine entry point inside $9300 (CheckBomb). Symbol-resolving disassemblers print it as a label reference. It is not one. Nothing in $9700 or $7900 is a pointer; every entry is two independent bytes.

- **`DJNZ` into the middle of an instruction.** $8250's loops jump to $825B and $8254 - the *operand* bytes of `LD B,$02` and `LD B,$08`. Landing there decodes the operand as a fresh opcode ($02 = `LD (BC),A`, $08 = `EX AF,AF'`, both harmless here) and falls through to the rest of the block. This is deliberate: it re-enters the loop body while *skipping* the `LD B,n` that would otherwise reset the loop counter. Any port that "cleans this up" into a normal loop must preserve the skipped-reload semantics.

- **The soldier is drawn twice per frame, one frame apart.** $8F8C has two operand triples; $8E53 copies the live one into the stale one before each frame's movement update. The kill-sparkle only ever patches the stale copy. See Actors.md - this is why shot soldiers keep moving and keep hurting you.

- **Adjacent tables with no boundary marker.** $82BE (bottom graphic, 64 bytes), $8300 (terrain flags, 128 bytes) and $8380 (door graphic, 64 bytes) sit back-to-back with only 2 padding bytes between the first two. Byte-consumption math is the only thing separating them; an earlier pass of this disassembly had all three merged into one undifferentiated block.

- **Off-by-one block starts corrupt whole-table analysis.** The high-score table starts at $8900, not $8901. Starting one byte late makes its 16-byte row stride appear not to divide evenly and hides the real row layout entirely.

## Open questions

- Exact code/data boundaries within `$8700-$88FF` and `$A200-$A3FF` - not individually catalogued line-by-line, only known to hold a mix of code and small data tables.
- Whether `$E000-$FDAF` is entirely tile bitmaps or has non-tile data mixed in - the original "64 tiles x 128 bytes = 8192 bytes" estimate doesn't leave room for the code known to resume at `$FDB0`, so the real tile/code boundary is narrower than first assumed and hasn't been pinned down exactly.
