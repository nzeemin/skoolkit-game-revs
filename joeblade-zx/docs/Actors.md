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

Key-gated doors (a second role for the key counter $8215, spending 1 key per climb on certain doors) are documented under $9500 bit5 in [Room-Format.md](Room-Format.md).

### Item placement is deterministic, but drifts across playthroughs

Confirmed live (ZEsarUX/ZRCP session, comparing consecutive game starts): $9498 (SetInitialValues, called once per "Start Game" from $7D00) copies the live $9D00 tables from a 128-byte scratch buffer at $9D80-$9DFF via a self-referencing rotate - it backs up 5 bytes ($9D80-$9D84 -> $9DE4), shifts the following 105 bytes down by 5 ($9D85+ -> $9D80), then copies the resulting buffer into $9D00. $9D80 itself holds the master 45-byte table (same categories as $9D00) repeated ~3 times back-to-back plus a short filler tail - so each call doesn't randomize anything, it advances the whole cyclic table by 5 bytes **in place**, permanently, for the rest of that emulator/hardware session.

Verified by capturing $9D00 at the identical breakpoint (entry to $9498, before that call's own rotate) across two separate "Start Game" presses: the second run's table was the first run's table rotated left by exactly 5 more bytes. No RNG instruction is involved anywhere in this path (searched the full reachable code for R-register/other pseudo-random reads near $9D00/$9D80 - the only RNG use found, at $7C1D, is the unrelated bomb-minigame letter scramble) and nothing outside $9498 ever touches $9D80.

So item layout is **not randomized per playthrough** in the traditional sense - it's a fixed, deterministic table that just keeps sliding by a constant 5-byte step every time a new game starts, with no reset back to a "base" state short of powering the machine off. Across many sessions (which is how players actually experience the game) this reads exactly like items landing in different places each time, even though the underlying mechanism has no real randomness in it.

**Does not persist across a cold restart.** Confirmed live: restarting the emulator (fresh load) and starting a game reproduces the exact same $9D80/$9D00 byte sequence as the very first "Run 1" capture. The drift only accumulates in RAM across repeated "press S" restarts within one power-on session - reloading the game (tape/snapshot) resets $9D80 back to its baked-in starting phase every time, it isn't seeded from anything external (clock, R register, etc.).

## Bomb deactivation minigame ($7800)

Confirmed by decoding the screen's own text (see below) and live gameplay knowledge: touching a bomb tile at the screen edge doesn't just add to the bomb counter like a normal pickup - it drops into a dedicated full-screen puzzle instead. $8D3C intercepts the bomb-tile match ($9D18) at the edge and routes to $7800 rather than the normal pickup path ($9300).

**The screen**: clears completely, plays a scrolling message **"SELF DESTRUCT IN 30 SECONDS"** (decoded from $7BA8; the scroll effect is $78E7 - already documented in Room-Format's draw pipeline), then shows the 5-letter **access code**. Two letters are green (the "swap cursors"), the rest red. The player must sort the access code alphabetically by repeatedly swapping the two green-cursor positions.

**Mechanics**:
- $7BE8 sets up the screen and scrambles the access code: picks one of 8 preset scrambles from the table at $7A00 (R-register pseudo-random index) into the working slots $7B01-$7B05.
- $7A28 handles input: right/left move cursor 1 ($7B09, wraps 1-5), another input moves cursor 2 ($7B0A, wraps 1-5), a third swaps the access-code letters at the two cursor positions - these two cursor-selected letters are the "green, exchangeable" ones.
- $7A78 draws the green highlight at the two cursor positions each frame.
- $7C3F/$7BC4 draw the access code's 5 big letter glyphs (looked up in a table at $6250).
- $7C65/$7CA4 drive a blink/symbol-preview animation - and, confirmed live, this is also what drives the 30-second timer (see below).
- $7800 itself checks the 5 slots ($7B05 down to $7B01) against sorted order (compares against a descending counter B=5..1) and the timer $7B0C/$7B0D for expiry; if the sort isn't done and time remains, loops back to $780C to keep playing; once all 5 match, falls through to $7AE5 (back to normal gameplay).

**30-second timeout - confirmed live (ZEsarUX/ZRCP session).** $7B0C/$7B0D is a countdown, decremented inside $7C65's per-frame tick (previously thought purely cosmetic): every 48 frames (one blink-wrap), it decrements a base-10 digit pair - low byte cycles 9-0 repeating, high byte drops once per full low-digit cycle. Starting value $7B0C=0/$7B0D=3 (set by $7CDA, called from setup $7BE8) takes exactly 30 ticks to reach 0/0 - 30*48 = 1440 frames, ~28.8s at 50Hz, matching the "30 SECONDS" message text almost exactly. On expiry, $7800 falls into $783F: clears the attribute row, draws **"SELF DESTRUCT ACTIVATED"** (decoded from $7AB6) twice, waits for a keypress, then jumps to $8EB4 (post-game hub) - i.e. **running out of time ends the game**, unlike solving in time which returns to normal gameplay via $7AE5.

**Corrected from an earlier pass**: this whole cluster was originally mislabeled as a "control-options screen" (a superficially similar UI shape - cursor, highlighted selection, icon grid - led to the wrong read). The actual control-options screen is a separate feature ($8BB4/$8B64/$7C65's *sibling* routines were conflated). Corrected once the screen's own message text was decoded and matched your live gameplay description exactly.

**$85FA countdown confirmed tied to bomb tiles**: $85F9 is a gate byte - $9650 (the "20:00" tick routine) is a no-op while $85F9=$FF. $92DE (bomb-tile touch/pickup tally) takes it out of that disabled state on the first touch, matching live-player observation that the 20-minute countdown starts on first bomb contact.

## Score (confirmed)

Not a per-item point value - it's an emergent side effect of a shared digit-animation mechanism, confirmed live.

$925C (DrawGlyph - called every time *any* HUD digit is redrawn, including on every pickup) always starts with $855B, which bumps a pending-tick budget $820F by $87 (135). Every frame, $850E (called from the main loop $8F00) spends down $820F one tick at a time; each tick increments and rolls the digit string of the high-score table row selected by $8210.

$8210 defaults to $05 (from the $8228 init block) and stays 5 throughout normal play - row 5 is a permanently-reserved "current game" slot in the high-score table ($8900+). Since $8210<>0, $850E also re-sorts that row into the live leaderboard via $8982 on every tick: **the on-screen score is continuously bubble-sorted into its real ranked position as it climbs**, not just tallied once at game end.

So: any pickup that triggers a digit redraw schedules ~135 frames of score-row auto-increment. There's no distinct point value per item type - score is effectively "how often you've triggered any HUD digit redraw." The end-of-game rolling animation ($A77C, called 40x by $FEB4's win screen) is just a cosmetic forced-fast version of this same mechanism (250 ticks/call), not a separate score computation.

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
4. $7B10 is picked up elsewhere by $789D (per-frame soldier update, called from $8E64), which drives the **kill-sparkle animation**: on the first tick it snapshots the soldier's screen/mask address as an anchor ($8FA4/$8FA7 -> $7B11/$7B12), then each frame picks a sparkle sprite frame from the $6400+ bank (see Sprite graphics banks below) based on that anchor and the $8206 counter, counting up to $1E (~30 frames) before freezing (never resets to 0 or clears anything). **The soldier is never actually removed from play** (player-confirmed: sparkles still deal contact damage) - $789D only overwrites the sprite/mask source addresses ($8FA4/$8FA1/$8FA7), it never touches $9700's pattern byte or $8F93 (screen position), so the soldier keeps standing at the same spot with its movement pattern still running underneath the sparkle graphic. Once frozen, $789D stops touching those addresses and the normal per-frame sprite-copy ($8E53, runs every frame regardless) resumes drawing the real soldier sprite. Since $93DC's contact-damage check is pure pixel-overlap against whatever's on screen, walking into the sparkle still registers as contact - "killing" a soldier is purely cosmetic.
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

`$820A` bit5 was also checked and is similarly never set anywhere (input reader $8032 only ever produces bits 0-4) - both are seemingly-unused bits in an otherwise fully-populated 5/6-bit field, leftover from a feature not present in this build. **Confirmed genuinely dead**, not just "dead in the visible 64K": there's no other bank that could set them - bank0 is the only RAM bank the game ever pages in (see [Room-Format.md](Room-Format.md)), so no hidden paged-bank code exists to reach for.

## Jump-arc implementation ($7F6E/$7FA0)

Confirmed: there's no per-frame velocity/curve table driving the "arc" - it's a hardcoded literal step baked directly into the instruction stream. `$7F6E` (rightward) ends with `INC A; INC A` on Joe's X ($8201); `$7FA0` (leftward) is the mirror (`DEC A; DEC A`). So the jump is a flat **2 pixels/frame** horizontal walk, gated by the 48-frame timeout in $7FE6, until X crosses the room-edge boundary ($E6 rightward, $00 leftward) - at which point X wraps to the opposite edge and the room number $8203 increments/decrements.

There's no vertical component or eased motion in this routine at all. Whatever visual "arc"/jump look the player sees comes entirely from the sprite/costume swap (the climbing sprite bank $D0, selected by $8209 bits0/1/7 in $80A0), not from the X-stepping logic - the underlying movement is just a straight sideways walk.

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

**$7900's low byte is a second, override movement-pattern selector, using the same dispatch code.** $8E64 (ProcessSoldier, per-frame soldier update) first calls $8E53, which sets H=$79 then falls into $96CE - the shared body of $9700's dispatcher $96CC (entered mid-routine, skipping its `LD H,$97`). This reads `(IX+0)` from the *current tile's $7900 entry* instead of $9700's, and runs the identical 1-6 pattern-jump chain. If the value is 0 (or unmatched), it just clears $8F93 and returns, letting $8E64 continue on to its own sprite-copy and $96CC dispatch as normal. But if it's 1-6, execution jumps straight into that movement-pattern routine instead - bypassing $8E64's sprite-template copy, its own $96CC dispatch, and the shoot-gate ($8F5A) entirely for that frame. Real sample data at $7900 ($6602,$1203,$6903,$2002 - low bytes $02,$03,$03,$02) falls squarely in the 1-6 range, so this override path is live, not dead code.

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

**"Jump-safe" vs "must-shoot" soldiers (player-reported) - not a type flag.** There's no dedicated lethality bit anywhere; it's a pure side effect of which movement pattern a soldier has. A soldier that walks straight stays clear once Joe jumps over it; one that reverses/turns back mid-patrol can walk back under Joe during the jump, triggering $93DC's plain pixel-overlap contact check and costing energy. No visual cue distinguishes them in advance.
