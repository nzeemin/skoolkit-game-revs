# Actors (Joe & Soldiers)

Joe's collectibles/combat state and soldier AI behaviour. Room/tile data formats live in [Room-Format.md](Room-Format.md); this doc covers what Joe and the soldiers actually *do*.

## Collectible tiles

Small tables of tile IDs mark collectible-item locations, each checked against the current tile ($8202) both to draw an icon ($912C/$9118, or $A2F6 for ammo/uniform) and to detect pickup ($926E/$92A0/$9300/$9328/$A328/$7B1E, the first 5 called from $A3BA every frame; $7B1E called directly from $8F00):

```
$9D00  (15 entries)  keys      -> counter $8215, collected via $92A0
$9D0F  (6 entries)   food      -> refills the energy gauge ($9456 -> $A23C -> $A228-$A239),
                                  collected via $9328; no on-screen counter, consumed
                                  immediately
$9D18  (6 entries)   bombs     -> counter $8216, collected via $9300 -> $92DE at most
                                  edges; at the screen edge specifically, $8D3C
                                  intercepts the same tile match and routes into the
                                  bomb-deactivation minigame ($7800) instead - see below
$9D20  (2 entries)   ammo      -> ammo count $8225 += 10, collected via $A328;
                                  sprite/mask $A500/$A580
$9D24  (6 entries)   hostages  -> counter $8214, collected via $86E4
$9D2B  (2 entries)   uniform   -> disguise flag $7B08=1 + duration timer $7B06,
                                  collected via $7B1E; sprite/mask $A400/$A480
```

2-byte gaps exist between some of these tables ($9D1E-$9D1F, $9D22-$9D23) that aren't part of any known table - unexplored. Table addresses/sizes are documented in [Room-Format.md](Room-Format.md); this section covers what picking each one up actually does.

Counter order/labels confirmed against the HUD sign text at $90E0 ("HOSTAGES ", "KEYS ", "BOMBS ", "SCORE") for keys/bombs/hostages; ammo/uniform confirmed against the sprite-graphic labels at $A500/$A580 ("ammo") and $A400/$A480 ("uniform"), and against live gameplay knowledge. Two corrections from earlier passes:

- **Food, not score.** $9328's pickup routine calls $9456, which calls $A23C - the exact same "fill gauge" routine used at game-start init, targeting the energy-gauge byte array $A228-$A239 (the same array $93A0 decrements on taking damage, and whose depletion triggers the "YOU ARE DEAD" screen $935E). No literal "SCORE" pickup tile exists - score most likely accrues from other events (defusing bombs, freeing hostages, etc.), not a dedicated tile.
- **$9D20 = ammo (not uniform), $9D2B = uniform (not a 2nd ammo table).** Originally lumped together as one split "5th category" since $A2F6 draws icons for both. They're separate items with separate pickup handlers: $A328 (ammo, $9D20) adds to $8225 and shows a message; $7B1E (uniform, $9D2B) sets the disguise flag/timer directly, no counter. $A798 - checked every frame, fires a shot and consumes one $8225 on the fire button - is the ammo consumer, not a "hold fire to stay disguised" mechanic. The disguise itself is purely time-limited: $7B84 counts $7B06 up every frame while $7B08 is set and auto-clears it (reverting Joe's sprite) once it expires, regardless of input.

Pickup only registers when Joe is standing on a matching tile *and* at the screen edge (X=$20 or X=$C0) - the same edge-tile pattern used by the level/room transitions and $8D3C. Which edge to check is selected by $820C bits4-5 (zero -> check left edge first, non-zero -> check right edge) - see [Room-Format.md](Room-Format.md)'s Terrain-flags section. On pickup: the tile byte is marked visited ($FF, or bit7 set for bombs), the relevant counter increments, a digit is redrawn, and the room background is rebuilt via $8C00 so the collected item disappears.

Key-gated staircases (a second role for the key counter $8215, spending 1 key per climb on certain stairs) are documented under $9500 bit5 in [Room-Format.md](Room-Format.md).

## Bomb deactivation minigame ($7800)

Confirmed by decoding the screen's own text (see below) and live gameplay knowledge: touching a bomb tile at the screen edge doesn't just add to the bomb counter like a normal pickup - it drops into a dedicated full-screen puzzle instead. $8D3C intercepts the bomb-tile match ($9D18) at the edge and routes to $7800 rather than the normal pickup path ($9300).

**The screen**: clears completely, plays a scrolling message **"SELF DESTRUCT IN 30 SECONDS"** (decoded from $7BA8; the scroll effect is $78E7 - already documented in Room-Format's draw pipeline), then shows the 5-letter **access code**. Two letters are green (the "swap cursors"), the rest red. The player must sort the access code alphabetically by repeatedly swapping the two green-cursor positions.

**Mechanics**:
- $7BE8 sets up the screen and scrambles the access code: picks one of 8 preset scrambles from the table at $7A00 (R-register pseudo-random index) into the working slots $7B01-$7B05.
- $7A28 handles input: right/left move cursor 1 ($7B09, wraps 1-5), another input moves cursor 2 ($7B0A, wraps 1-5), a third swaps the access-code letters at the two cursor positions - these two cursor-selected letters are the "green, exchangeable" ones.
- $7A78 draws the green highlight at the two cursor positions each frame.
- $7C3F/$7BC4 draw the access code's 5 big letter glyphs (looked up in a table at $6250).
- $7C65/$7CA4 drive a blink/symbol-preview animation, independent of the sort logic.
- $7800 itself checks the 5 slots ($7B05 down to $7B01) against sorted order (compares against a descending counter B=5..1); if any comparison fails, loops back to $780C to keep playing; once all 5 match, falls through to $8EB4 (menu or high-score entry).

**Corrected from an earlier pass**: this whole cluster was originally mislabeled as a "control-options screen" (a superficially similar UI shape - cursor, highlighted selection, icon grid - led to the wrong read). The actual control-options screen is a separate feature ($8BB4/$8B64/$7C65's *sibling* routines were conflated). Corrected once the screen's own message text was decoded and matched your live gameplay description exactly.

**Open**: what happens if the 30-second timer runs out before sorting is complete - not yet traced (the timer/countdown mechanism itself hasn't been located for this specific screen; it may reuse the "20:00" countdown at $85FA or be a separate one).

## Win condition ($FF14, confirmed)

Checked every frame from $8F00. The game is won when all three hold at once:

- current tile ($8202) = $7B - **the exact same tile as Joe's starting room** (see [Room-Format.md](Room-Format.md)'s Ground-truth section)
- hostage counter $8214 = 6
- bomb counter $8216 = 6

i.e. rescue all 6 hostages, defuse all 6 bombs, and make it back to the starting room. On match, $FEB4 plays the win screen (redraws the title sign, congratulations text, a pause), then returns to the menu/hi-score flow via $8EB4.

## Shooting ($A798)

Checked every frame from $8F5A (called from $8E64). Fire pressed + ammo ($8225) non-zero:

1. Consume one round ($8225--).
2. $FFF0 - plays the gunshot sound: two chained descending-pitch beeper (`OUT ($FE)`) sweeps, $A2BE then falling into $A28C, repeated 3x.
3. $7869 - hit check: looks up the $7900 entry for the current tile and compares it against Joe's X, setting the flag $7B10 depending on which side of the threshold Joe is on (also gated by $8209/$820B - Joe's orientation/facing). Reads as "is a soldier (or the tile's shootable point) within range/on this side".
4. $7B10 is picked up elsewhere by $789D (per-frame soldier update, called from $8E64), which drives the **kill-sparkle animation**: on the first tick it snapshots the soldier's screen/mask address as an anchor ($8FA4/$8FA7 -> $7B11/$7B12), then each frame picks a sparkle sprite frame from the $6400+ bank (see Sprite graphics banks below) based on that anchor and the $8206 counter, counting up to $1E (~30 frames) before resetting.
5. Sets $8226 based on Joe's X relative to a $9700 entry for the current tile - same threshold-table pattern as $7869.

**$8226 resolved**: $FF3E (called from $8E64, same as $789D) is byte-for-byte the same kill-sparkle animator as $789D/$7B10, just gated on $8226 with its own anchor ($8217/$8227 instead of $7B11/$7B12) and end-flag ($8F94 instead of $8FA8). A second, independent sparkle slot - lets two kills animate at once (e.g. two soldiers, or a soldier plus something else).

No ammo -> $A7DC shows an "out of ammo" message ($A7EC, "YOUR GUN'S EMPTY").

## Joe's facing/orientation ($8209/$820B)

- `$820B` - Joe's facing direction (0/1), set by the jump-arc routines $7F6E/$7FA0 when a room-jump starts, consumed by "Draw Joe sprite" ($80A0) to pick the sprite/mask column.
- `$8209` - Joe's orientation/special-move state:
  - bit0/1: set by $7F0F/$7F1D on an UP+RIGHT/UP+LEFT input combo, routes into the jump-arc dispatch in $7E32 (see [Room-Format.md](Room-Format.md)'s room-transition section)
  - bit5: flips Joe's facing (`$820B XOR 1`) in $80A0 - **dead code**, nothing anywhere in the disassembled 64K ever sets this bit
  - bits0/1/7: select the alternate sprite bank $D0 (climbing costume) in $80A0
  - cleared to 0 every ~48 ticks by $7FE6's jump timer

`$820A` bit5 was also checked and is similarly never set anywhere (input reader $8032 only ever produces bits 0-4) - both are seemingly-unused bits in an otherwise fully-populated 5/6-bit field, possibly leftover from a feature not present in this build (or gated by paged-bank code we can't see statically).

## Sprite graphics banks (confirmed)

Identified from the generated HTML sprite gallery:

- **$6400-$6BFF - sparkle (kill effect) sprites/masks**: 8 animation frames + 8 masks, plays when someone (soldier/inmate) is killed.
- **$7000-$77FF - soldier sprites/masks**: 8 frames + 8 masks. Distinct from the $A800/$AA00 addresses the movement-pattern code ($900A/$8164/$9464) picks between for left/right facing - relationship between this bank and those two addresses not yet traced (animation sub-frames? a different soldier type?).
- **$C800-$CFFF - inmate sprites/masks**: 8 sprite frames ($C800-$CBFF) + 8 masks ($CC00-$CFFF), 128 bytes each (32x32 1bpp). Distinct from the "hostage" collectible tiles ($9D24) - an inmate is presumably an actor Joe frees/interacts with, not the same as a hostage pickup icon.
- **$D000-$DFFF - Joe sprites/masks**: 16 sprite frames ($D000-$D3FF, $D800-$DBFF) + 16 masks ($D400-$D7FF, $DC00-$DFFF) - twice the inmate count, consistent with Joe needing more animation states (walk L/R, climb/jump costume via the alt sprite bank $D0 selected by $8209 bits0/1/7, disguise costume via $7B1E, etc).

Neither bank is referenced by a hardcoded address in code (Joe's base at $80CD is `!!MUT-ARG!!`, patched dynamically) - which specific frame plays for a given animation state hasn't been traced frame-by-frame yet.

## Soldier placement (low byte of $9700)

Confirmed: the low byte of $9700's per-tile word pair (see [Room-Format.md](Room-Format.md)) is a soldier movement-pattern selector, read every frame by $96CC/$96CE: 0 = no soldier (clears the soldier's screen address $8F93), 1-6 = one of six movement routines.

Checked against 4 known ground-truth tiles (see [Room-Format.md](Room-Format.md)'s Ground-truth section for how these were established):

```
$71 (soldier)  low byte = 2
$7A (soldier)  low byte = 1
$72 (empty)    low byte = 0
$7B (empty)    low byte = 0
```

4/4 match - soldier presence and its movement pattern are both read from this one byte. ($9500's door-flags byte was checked too and is *not* a reliable soldier indicator - $00 for one known soldier tile, $08 for the other.)

## Soldier movement patterns (selected by $9700's low byte)

Called every frame via $96CC/$96CE. Three underlying horizontal behaviors, two of which also get a "+ vertical drift" variant:

```
1  $900A            chase Joe's X (steps 1 toward Joe, picks facing sprite)
2  $9464            synchronized patrol, group A (bounces X between 2 and $E6,
                     shared direction byte $8213 - all group-A soldiers turn
                     around in lockstep)
3  $8164            synchronized patrol, group B (same as group A, shared
                     direction byte $8212 - independent from group A)
4  $7D64            pattern 1 (chase) + slow vertical drift (BC=$0800/frame
                     added to fine-position $8F8D, deriving coarse row $8F90)
5  $7D82            pattern 1 (chase) + fast vertical drift (BC=$2000/frame,
                     4x pattern 4's rate)
6  $7D8C            pattern 3 (patrol group B) + slow vertical drift (BC=$0800)
```

Patterns 1/4/5 (chase-based) and 3/6 (patrol-group-B-based) share the same X-movement logic; 4/5/6 add a vertical fine-position accumulator on top via a common tail ($7D6A). Patterns 1/2/3 fall into a shared routine at $9028 that turns the soldier's X into a screen address ($8F93) and picks a sprite/mask variant ($8F90/$8F8D) based on X's low bits.

## Open questions

- Where does score actually come from, if not a tile pickup?
- Does $789D's kill-sparkle sequence actually remove the soldier from play (clear $9700's low byte / $8F93) once it finishes, or just play the effect?
- $8209/$820A bit5 - confirmed dead in the visible 64K; would a paged bank ever set them? Needs live tracing to rule out entirely.
