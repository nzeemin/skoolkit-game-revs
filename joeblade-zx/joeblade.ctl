@ $5B00 start
@ $5B00 org
t $5CEB
b $5CF0
t $5CFC
b $5D69
t $5D6F
b $5DEA
t $5E1D
b $5E22
t $5E2B
b $5E30
t $5E3F
b $5E43
t $5E62
b $5E68
t $5E6F
b $5E79
b $6400 Sparkle (kill effect) sprites and masks
N $6400 Sparkle frame 1
B $6400,128,8 #HTML[#UDGARRAY4,7,4,4,,($6400-$647F-1-32)(spr6400)]
N $6480 Sparkle frame 2
B $6480,128,8 #HTML[#UDGARRAY4,7,4,4,,($6480-$64FF-1-32)(spr6480)]
N $6500 Sparkle frame 3
B $6500,128,8 #HTML[#UDGARRAY4,7,4,4,,($6500-$657F-1-32)(spr6500)]
N $6580 Sparkle frame 4
B $6580,128,8 #HTML[#UDGARRAY4,7,4,4,,($6580-$65FF-1-32)(spr6580)]
N $6600 Sparkle mask 1
B $6600,128,8 #HTML[#UDGARRAY4,7,4,4,,($6600-$667F-1-32)(msk6600)]
N $6680 Sparkle mask 2
B $6680,128,8 #HTML[#UDGARRAY4,7,4,4,,($6680-$66FF-1-32)(msk6680)]
N $6700 Sparkle mask 3
B $6700,128,8 #HTML[#UDGARRAY4,7,4,4,,($6700-$677F-1-32)(msk6700)]
N $6780 Sparkle mask 4
B $6780,128,8 #HTML[#UDGARRAY4,7,4,4,,($6780-$67FF-1-32)(msk6780)]
N $6800 Sparkle frame 5
B $6800,128,8 #HTML[#UDGARRAY4,7,4,4,,($6800-$687F-1-32)(spr6800)]
N $6880 Sparkle frame 6
B $6880,128,8 #HTML[#UDGARRAY4,7,4,4,,($6880-$68FF-1-32)(spr6880)]
N $6900 Sparkle frame 7
B $6900,128,8 #HTML[#UDGARRAY4,7,4,4,,($6900-$697F-1-32)(spr6900)]
N $6980 Sparkle frame 8
B $6980,128,8 #HTML[#UDGARRAY4,7,4,4,,($6980-$69FF-1-32)(spr6980)]
N $6A00 Sparkle mask 5
B $6A00,128,8 #HTML[#UDGARRAY4,7,4,4,,($6A00-$6A7F-1-32)(msk6A00)]
N $6A80 Sparkle mask 6
B $6A80,128,8 #HTML[#UDGARRAY4,7,4,4,,($6A80-$6AFF-1-32)(msk6A80)]
N $6B00 Sparkle mask 7
B $6B00,128,8 #HTML[#UDGARRAY4,7,4,4,,($6B00-$6B7F-1-32)(msk6B00)]
N $6B80 Sparkle mask 8
B $6B80,128,8 #HTML[#UDGARRAY4,7,4,4,,($6B80-$6BFF-1-32)(msk6B80)]
b $6C00 Per-tile top-row selector table (128 x 8 bytes), used by $8CF0
N $6C00 One 8-byte row per tile ($8202, 0-127), spanning exactly $6C00-$6FFF (128*8=1024 bytes, ending precisely at $7000 where the sprite/mask data begins). Same selector-byte format as the paged-bank table at $C000 (#R$8C00): bit0=variant, bits1-5=tile index (0-31), source addr=$E0+((byte>>1)&$1F):(bit0?$80:0), tiles at $E000-$FFFF. Read by #R$8CF0 to draw one extra background row directly onto the live screen (bypassing the shadow buffer, unlike #R$8C00's rows). Decode spot-checked against tile $7B's row ($6FD8-$6FDF): bytes $21/$20/$16 all decode to plausible $E000-$FFFF addresses.
B $6C00,1024,8
b $7000 Soldier sprites and masks
N $7000 Soldier sprite 1
B $7000,128,8 #HTML[#UDGARRAY4,7,4,4,,($7000-$707F-1-32)(spr7000)]
N $7080 Soldier sprite 2
B $7080,128,8 #HTML[#UDGARRAY4,7,4,4,,($7080-$70FF-1-32)(spr7080)]
N $7100 Soldier sprite 3
B $7100,128,8 #HTML[#UDGARRAY4,7,4,4,,($7100-$717F-1-32)(spr7100)]
N $7180 Soldier sprite 4
B $7180,128,8 #HTML[#UDGARRAY4,7,4,4,,($7180-$71FF-1-32)(spr7180)]
N $7200 Soldier sprite 5
B $7200,128,8 #HTML[#UDGARRAY4,7,4,4,,($7200-$727F-1-32)(spr7200)]
N $7280 Soldier sprite 6
B $7280,128,8 #HTML[#UDGARRAY4,7,4,4,,($7280-$72FF-1-32)(spr7280)]
N $7300 Soldier sprite 7
B $7300,128,8 #HTML[#UDGARRAY4,7,4,4,,($7300-$737F-1-32)(spr7300)]
N $7380 Soldier sprite 8
B $7380,128,8 #HTML[#UDGARRAY4,7,4,4,,($7380-$73FF-1-32)(spr7380)]
N $7400 Soldier mask 1
B $7400,128,8 #HTML[#UDGARRAY4,7,4,4,,($7400-$747F-1-32)(msk7400)]
N $7480 Soldier mask 2
B $7480,128,8 #HTML[#UDGARRAY4,7,4,4,,($7480-$74FF-1-32)(msk7480)]
N $7500 Soldier mask 3
B $7500,128,8 #HTML[#UDGARRAY4,7,4,4,,($7500-$757F-1-32)(msk7500)]
N $7580 Soldier mask 4
B $7580,128,8 #HTML[#UDGARRAY4,7,4,4,,($7580-$75FF-1-32)(msk7580)]
N $7600 Soldier mask 5
B $7600,128,8 #HTML[#UDGARRAY4,7,4,4,,($7600-$767F-1-32)(msk7600)]
N $7680 Soldier mask 6
B $7680,128,8 #HTML[#UDGARRAY4,7,4,4,,($7680-$76FF-1-32)(msk7680)]
N $7700 Soldier mask 7
B $7700,128,8 #HTML[#UDGARRAY4,7,4,4,,($7700-$777F-1-32)(msk7700)]
N $7780 Soldier mask 8
B $7780,128,8 #HTML[#UDGARRAY4,7,4,4,,($7780-$77FF-1-32)(msk7780)]
c $7800 Bomb deactivation minigame: sort 5 letters, "SELF DESTRUCT IN 30 SECONDS"
N $7800 Reached only from #R$8D3C's edge-tile check on a bomb tile ($9D18) - NOT a room-to-room flip or level-exit. Clears the screen, plays the "SELF DESTRUCT IN 30 SECONDS" message (#R$78E7 scrolling text + #R$7BA8/#R$7BE8 setup), then loops #R$7A28 (letter-swap cursor input) while checking a 5-slot letter array at $7B01-$7B05 against sorted order ($7B05 down to $7B01, comparing against B=5..1) - fails back to #R$780C to keep playing until the 5 letters (2 of them swappable via the two cursors $7B09/$7B0A) are in alphabetical order. On success, falls through to #R$8EB4 (menu or high-score entry) - what happens on running out of time (30s) is not yet traced.
C $7809,3 Wait for a key or timeout
C $781B,3 Bomb minigame
C $781E,3 Bomb minigame
C $7821,3 Bomb minigame
C $7824,3 Bomb minigame
C $7853,3 Draw string IX
C $7859,3 Draw string IX
C $7862,3 Wait for a key or timeout
C $7866,3 => Post-game hub
c $7869 Shot hit check: compare Joe X against #R$7900 threshold, set $7B10
N $7869 Called by #R$A798 when Joe fires. Looks up the #R$7900 entry for the current tile ($8202) and compares it against Joe's X (not a Y value, despite #R$7900's "ceiling" label - see that table's note) to decide which side of the threshold Joe is on, setting $7B10 accordingly (also gated by $8209 and $820B). $7B10 is read back by #R$789D to trigger a soldier hit/reaction animation - likely "is a soldier within range of this shot".
C $7869,7 HL = #R$7900 entry for current tile ($8202)
C $7870,7 $8209 non-zero? skip the $7B10 idle-check
C $7877,5 Not mid-shot: bail unless $7B10 already set
C $787C,11 Mark $7B10 active; check $820B direction
C $7887,3 get Joe X
C $7892,3 get Joe X
c $789D Kill-sparkle animation, gated on $7B10
N $789D Called from #R$8E64 (per-frame soldier update). While $7B10 is non-zero (set by #R$7869 on a hit): first hit ($7B10=1) snapshots the soldier's screen/mask address into $7B11/$7B12 as the sparkle anchor; each following frame picks a sparkle sprite frame (the $6400+ bank) from that anchor plus the $8206 counter, and $7B10 counts up to $1E (~30 frames) before resetting to 0.
C $789D,5 Check $7B10; return if inactive
C $78A2,7 First tick ($7B10=1)?
C $78A9,12 Snapshot $8FA7/$8FA4 into $7B11/$7B12 (sparkle anchor)
C $78D3,9 Advance $7B10; done at $1E?
c $78E7
b $78F6
b $7900 Per-tile threshold table, indexed by $8202
N $7900 Word pairs indexed by 2*$8202+1 (current room-tile index, see #R$8114). #R$7D96 clamps the odd byte of each pair into $4E-$9D each frame; even byte is untouched, purpose unclear. $8202 is used all over the movement/collision code ($8CF0, $9134+, $9602, $A2FE etc.), so this table likely holds a per-tile boundary alongside #R$9700 - unconfirmed, needs live tracing. $8202 ranges 0-127 (room 0-7 + 8*subtile 0-15), so the array proper is 128 words (256 bytes); the trailing 40 bytes are unaccounted for.
N $7900 Originally guessed as a per-tile ceiling Y-bound. #R$7869 (the shot-hit check, called from #R$A798 when firing) compares this table's entry against Joe's X, not Y - so it may instead (or also) be a per-tile X threshold, e.g. a soldier post/wall position used for hit detection. The two uses aren't necessarily contradictory (same stored value reused as a generic "boundary coordinate" by different consumers) but the "ceiling" label is now uncertain - needs live tracing to settle.
W $7900,256,2
B $7A00,40,8 8 preset 5-letter scrambles for the bomb-deactivation minigame (see #R$7BE8)
c $7A28 Bomb minigame: letter-swap cursor input handler
N $7A28 Edge-detects new key presses ($7B0F). Right/left move cursor 1 ($7B09, wraps 1-5); some other input moves cursor 2 ($7B0A, wraps 1-5); a third input swaps the letters at $7B00+cursor1 and $7B00+cursor2 - the two cursor positions are the "green, exchangeable" letters.
C $7A28,3 Read input into $820A
C $7A2B,3 get input state
C $7A37,3 get input state
C $7A4E,3 get input state
C $7A65,3 get input state
c $7A78 Bomb minigame: highlight the two swap-cursor letters (green)
N $7A78 Part of the bomb-deactivation minigame ($7800/$7A28): clears an attribute row, then highlights the two letters currently selected for swapping (green), using cursor positions $7B09/$7B0A.
C $7A78,6 Clear attribute row $5960
C $7A82,12 HL = highlight position from cursor row $7B09
C $7A8E,5 B = 3 rows, DE = row stride
C $7A93,11 Fill 3 cells per row with attribute $44
b $7AB6
c $7AE5
C $7AE8,3 Copy shadow screen to real screen
C $7AEB,3 Draw Joe sprite
C $7AEE,3 Draw soldier ??
b $7AF2
B $7B08,1,1 uniform/disguise active flag ($00=normal, $01=disguised - suspends energy loss); auto-cleared by #R$7B84's timer
B $7B0E,1,1
c $7B1E Uniform pickup: check $9D2B tile at screen edge
@ $7B1E label=PickupUniform
N $7B1E Same edge-triggered pattern as #R$926E, for the uniform tile table $9D2B. On match: marks the tile visited, swaps Joe's sprite to the soldier costume ($80CF/$80D8 -> $A8/$70), sets the disguise flag $7B08=1, shows a message (#R$7B73, undeciphered), resets the duration timer $7B06, and rebuilds the background. Disguise is time-limited, not fire-consumed - see #R$7B84.
C $7B1E,5 HL = $9D2B (uniform tile table); B = 2
C $7B23,6 Compare current tile ($8202) against table entry
C $7B29,5 $820C bits4-5: pick which edge to check
C $7B30,3 get Joe X
C $7B39,3 get Joe X
C $7B46,2 Mark tile visited ($FF)
C $7B48,10 Swap Joe's sprite to the soldier costume
C $7B54,3 disguise active
C $7B57,3 Draw black box on the screen
C $7B61,3 Draw string IX
C $7B64,3 Pickup/beep sound effect
C $7B67,3 Delay
C $7B6A,6 Reset disguise duration timer $7B06
C $7B70,3 => Build room background into shadow buffer $B800
b $7B73
c $7B84 Disguise duration timer: auto-expire and revert
@ $7B84 label=UniformTime
N $7B84 Called every frame from #R$8F00. While disguised ($7B08<>0), increments the 16-bit timer $7B06; once its high byte reaches 5 (~1280 frames), clears $7B08 and restores Joe's normal sprite ($80CF/$80D8 -> $D8/$D0). No player input involved - the disguise just runs out.
C $7B84,5 Check disguise flag $7B08; return if not disguised
C $7B89,10 Increment timer $7B06; not yet expired -> return
C $7B94,14 Expired: clear $7B08, restore normal sprite
b $7BA8 "SELF DESTRUCT IN 30 SECONDS" (bomb minigame message)
c $7BC4 Draw a small 3x3-block icon (used by the bomb-deactivation minigame)
C $7BC4,3 Outer loop: 3 columns
C $7BC7,5 Inner loop: 8 pixel rows
C $7BCC,16 Copy 3 bytes/row (DE->HL)
C $7BE3,5 HL += 6 (advance past icon)
c $7BE8 Bomb minigame: clear/redraw, scramble the 5 letters
N $7BE8 Clears the bitmap third at $4800, fills the top/bottom attribute strips, draws the "SELF DESTRUCT IN 30 SECONDS" instructions text, resets the cursor state ($7B00/$7B0B), then picks one of 8 5-letter scrambles from the table at $7A00 using the R register as a pseudo-random index, copying it into $7B01-$7B05 as the letters to sort.
C $7BE8,12 Clear bitmap third at $4800
C $7BF4,10 Fill 64 bytes at $5900 with attribute $45
C $7BFE,7 Fill 192 bytes with attribute $41
C $7C1D,7 E = R register & 7 (pseudo-random 0-7)
C $7C24,8 HL = $7A00 + E*5 (random 5-byte preset)
C $7C31,6 Copy 5 bytes into $7B01 (current key assignment)
C $7C38,7 $7B09 = $0103 (init cursor position)
C $7C0C,3 Draw string IX
c $7C3F Bomb minigame: draw the 5 big letters
N $7C3F For each of the 5 letter slots ($7B01-$7B05), looks up a glyph in a 72-byte-stride table at $6250 by letter code and draws it via #R$7BC4.
C $7C3F,4 IX = $7B01 (key assignment slots); B = 5
C $7C4A,10 HL = $6250 + key_code*72 (symbol lookup)
C $7C5C,3 Draw a small 3x3-block icon
c $7C65 Bomb minigame: cursor blink timer + scanline effect
N $7C65 Per-frame tick for the bomb-deactivation minigame. Increments the blink timer $7B0B, and every 48 frames (wrap at $30) advances a displayed symbol ($7B00/$7B0D wrap $09-$FF) and redraws via #R$7CA4. Then runs a 6-column left-rotate ("running line") effect over the block at $491F, independent of the blink timer.
C $7C65,9 Increment blink timer $7B0B; wrap at 48 frames?
C $7C6E,7 Advance displayed key index ($7B00)
C $7C83,3 Bomb minigame
C $7C86,5 HL = $491F; B = 6 columns (scanline effect)
s $7CA0
c $7CA4 Bomb minigame: draw the two symbol-preview columns
N $7CA4 Draws two 7-byte columns onto the screen (at $48xx, column from $7B00) from two lookup tables at $A700+ (indexed by $7B0C) and a second at $48xx-1 (indexed by $7B0D) - split across two source tables.
C $7CA4,14 DE = $A700 + $7B0C*8 (symbol source, column 1)
C $7CB5,6 Draw 7-byte column 1
C $7CBD,10 DE = $7B0D*8 (symbol source, column 2)
C $7CC7,6 Draw 7-byte column 2
c $7CD4
c $7CDA
c $7CE1
C $7CF4,3 => Bomb minigame
c $7CF7 Reduce energy, if allowed
C $7CFC,3 => Reduce energy
b $7CFF
c $7D00 Start game: draw sign, reset variables, drop into game loop
@ $7D00 label=StartGame
N $7D00 Entered from #R$8B37 when 'S' is pressed on the main menu. Redraws the "JOE BLADE" sign and title strings, resets game variables to their initial values, then re-enables energy loss ($7D45) before falling into the main game loop.
C $7D00,3 Entry-point trampoline
C $7D06,3 Clear screen, border to black
C $7D0C,3 Address on the screen
C $7D0F,3 Show "JOE BLADE" big sign; HL = screen address
C $7D19,3 Draw string IX
C $7D1F,3 Draw string IX
C $7D25,3 Draw string IX
C $7D2B,3 Draw string IX
C $7D31,3 Draw string IX
C $7D37,3 Draw string IX
C $7D3D,3 Draw string IX
C $7D40,3 Set initial values
C $7D45,3 allow to reduce energy
C $7D61,3 => Per-frame room-tile lookup, then hand off to game loop
c $7D64 Soldier pattern 4: chase + slow vertical drift
N $7D64 #R$900A (horizontal chase of Joe's X) plus a fixed vertical drift: adds $0800 to the 16-bit fine-position accumulator $8F8D every frame, deriving the coarse row address $8F90 from it (H-4). Shared tail #R$7D6A also used by patterns 5/6.
C $7D64,3 Soldier pattern 1
C $7D67,3 BC = $0800 (slow drift rate)
C $7D6A,14 $8F8D += BC; derive coarse row $8F90 from it
b $7D79
c $7D82 Soldier pattern 5: chase + fast vertical drift
N $7D82 Same as #R$7D64 but BC=$2000 (4x the drift rate).
C $7D82,3 Soldier pattern 1
s $7D8B
c $7D8C Soldier pattern 6: patrol (group B) + slow vertical drift
N $7D8C #R$8164 (synchronized left-right patrol, group B) plus the same slow vertical drift as pattern 4.
C $7D8C,3 Soldier pattern 3
C $7D8F,3 BC = $0800 (slow drift rate)
s $7D95
c $7D96 Clamp room-tile pointers, hand off to game loop $8F00
C $7D96,13 Clamp tile pointer at $9700+ to range $40-$A5
C $7DAD,13 Clamp tile pointer at $7900+ to range $40-$A5
C $7DC3,4 Clear $7B10 flag
C $7DC7,5 Continue at #R$8F00
c $7DCC
C $7DD9,3 get input state
C $7DDF,3 get Joe X
b $7DFB
c $7E32 Movement/collision: jump dispatch, then level (row) edge transitions
N $7E32 Dispatches on $8209 first (bit0 -> #R$7FD2 -> #R$7F6E, a rightward jump-arc; bit1 -> #R$7FDC -> #R$7FA0, a leftward jump-arc - these handle horizontal room changes; bit7 -> jump timer #R$7FE6), then checks the 4 up/down x left/right edge combos below to change the current level/row ($8204). Room (column, $8203) changes are not handled here directly - they happen inside the jump-arc routines when a jump carries Joe past the screen edge.
C $7E32,6 Dispatch: $8209 bit0 -> #R$7FD2 (jump right), bit1 -> #R$7FDC (jump left)
C $7E41,6 Dispatch: $8209 bit7 -> #R$7FE6 (jump timer)
C $7E54,15 UP input + 'stair' tile ($820C bit4)?
C $7E63,11 At left edge (X&$E0=$20)?
C $7E6E,9 level++ ($8204, wraps 0-15)
C $7E7B,3 => Per-frame room-tile lookup, then hand off to game loop
C $7E83,12 DOWN input + 'stair' tile ($820C bit5)?
C $7E8F,11 At left edge (X&$E0=$20)?
C $7E9A,9 level-- ($8204, wraps 0-15)
C $7EA7,3 => Per-frame room-tile lookup, then hand off to game loop
C $7EAF,12 UP input + 'stair' tile ($820C bit2)?
C $7EBB,11 At right edge (X&$E0=$C0)?
C $7EC6,9 level++ ($8204, wraps 0-15)
C $7ED3,3 => Per-frame room-tile lookup, then hand off to game loop
C $7EDB,12 DOWN input + 'stair' tile ($820C bit3)?
C $7EE7,11 At right edge (X&$E0=$C0)?
C $7EF2,9 level-- ($8204, wraps 0-15)
C $7EFF,3 => Per-frame room-tile lookup, then hand off to game loop
C $7F05,15 UP+RIGHT combo ($820A&$0B=$09, bit0=right/bit3=up) -> $8209=1, retry #R$7E32
C $7F14,3 => Movement/collision
C $7F17,9 UP+LEFT combo (else &$0B=$0A, bit1=left/bit3=up) -> $8209=2, retry #R$7E32
C $7F20,3 => Movement/collision
C $7F2C,3 => Movement/collision
C $7F36,3 => Jump-arc step
C $7F3C,3 => Jump-arc step
s $7F44
c $7F64
C $7F64,3 => Sound effect (descending pitch sweep), used at a room edge
b $7F67
c $7F6E Jump-arc step (right): room change when Joe reaches X=$E6
N $7F6E Called every frame during a rightward jump-arc (#R$7FD2, triggered by UP+RIGHT). X increases by 2/frame; once it reaches $E6 (right edge), room++ ($8203, wraps 0-7) and X resets to $00 - i.e. this is where horizontal ROOM (column) transitions actually happen, as a side effect of completing a jump off the edge. Blocked (no room change, X still clamped) if $820C bit0 is set - see that variable's bit map.
C $7F70,3 set Joe's facing direction
C $7F79,3 get Joe X
C $7F85,3 set Joe X
C $7F88,3 get room number
C $7F8E,3 set room number
C $7F92,3 => Per-frame room-tile lookup, then hand off to game loop
C $7F95,3 get Joe X
C $7F9A,3 set Joe X
b $7F9E
c $7FA0 Jump-arc step (left): room change when Joe reaches X=$00
N $7FA0 Mirror of #R$7F6E for a leftward jump-arc (#R$7FDC, triggered by UP+LEFT): X decreases by 2/frame; once it reaches $00 (left edge), room-- ($8203, wraps 0-7) and X resets to $E6. Blocked if $820C bit1 is set.
C $7FA2,3 set Joe's facing direction
C $7FA5,3 get Joe X
C $7FB4,3 set Joe X
C $7FB7,3 get room number
C $7FBD,3 set room number
C $7FC1,3 => Per-frame room-tile lookup, then hand off to game loop
C $7FC4,3 get Joe X
C $7FC9,3 set Joe X
b $7FCD
c $7FD2
C $7FD2,3 Jump timer tick
C $7FD5,3 => Jump-arc step
b $7FD8
c $7FDC
C $7FDC,3 Jump timer tick
C $7FDF,3 => Jump-arc step
b $7FE2
c $7FE6 Jump timer tick; clears $8209 on wrap
N $7FE6 Increments the jump timer $820D; when it wraps at $30 (48), resets both $820D and $8209 to 0. Called from #R$7E32 and the jump-arc routines #R$7FD2/#R$7FDC.
C $7FEA,3 set jump counter
C $7FF6,3 set jump counter
b $7FFD
c $8032 Read input into $820A: Kempston, digit-key, or redefinable-key scheme
@ $8032 label=ReadInput
N $8032 Writes a 5-bit direction/fire mask to #R$820A. If $820E==1, reads Kempston joystick (port $1F) and uses it directly if non-zero, skipping the keyboard entirely. Otherwise tries a fixed digit-key scheme (row $F7FE, keys 1-5) first; if that row is idle, falls back to the redefinable keyboard scheme matching the control-options text (#R$8400 signs): row $FDFE (A-G) = down, row $FBFE (Q-T) = up, row $7FFE (B/space) = fire, row $DFFE bits0-1 (O/P) = left/right.
C $8032,5 $820E==1? (Kempston mode selected)
C $8041,9 Read Kempston joystick (port $1F); use directly if non-zero
C $804B,5 Read digit-key row $F7FE (keys 1-5)
C $8055,9 Remap digit-row bits into result: bits2-4 passthrough, bit1->bit0, bit0->bit1
C $8068,3 set input state
C $806C,9 Read row $DFFE (O/P); bits0-1 -> result bits0-1 (left/right)
C $8075,10 Read row $FDFE (A-G); non-zero -> result bit2 (down)
C $8081,10 Read row $FBFE (Q-T); non-zero -> result bit3 (up)
C $808D,10 Read row $7FFE (B/space); non-zero -> result bit4 (fire)
C $809A,3 set input state
b $809E
c $80A0 Draw Joe sprite
@ $80A0 label=DrawJoe
C $80A9,3 get jump counter
N $80CC HL = destination addr
C $80CD,3 !!MUT-ARG!! Joe sprites base address
C $80D0,5 $8209 bits0/1/7: use alt sprite bank $D0 (climbing costume)
C $80D9,4 C = $820B (Joe's facing direction: 0/1)
C $80DD,5 $8209 bit5: flip facing (C ^= 1) - dead code, nothing ever sets this bit
C $80F0,3 get Joe X
C $80F9,3 get Joe X
N $8101 BC = sprite addr
C $8101,2 DE = BC
C $8103,4 DE = DE + $0400
N $8107 BC = sprite addr, DE = mask addr, HL = destination
C $8107,3 Set Joe's screen address HL and sprite mask DE
C $810A,3 => Draw sprite 32x32 with mask
s $810D
c $8114 Per-frame room-tile lookup, then hand off to game loop
N $8114 Bridges #R$7D00 into the game loop: computes the current room-tile offset from $8203/$8204, looks it up in the table at $8300, stores it as the terrain-flags byte $820C (bit map documented at that variable), redraws the status bar from bits6-7 of it (LDIR to $5880), then falls through #R$FFAD, #R$7D96 into #R$8F00.
C $8114,14 Look up current room tile from table at $8300
C $8127,4 Store tile byte in $820C
C $812B,3 Build room background into shadow buffer $B800
C $812E,13 Attribute byte = (($820C>>6)&3) + $44: bright green/cyan/yellow/white ink on black, by room zone
C $813B,12 Fill 14 attribute rows at $5880 (0x1C0 bytes) - most of the play area, not just a status bar
C $8147,3 Detect collectible tile under Joe, draw its icon
C $814A,3 Draw down-stair indicator icons in the HUD
C $814D,8 Clear $587F and $5860
C $8157,3 => Clear $8226, hand off to $7D96
b $815A
c $8164 Soldier pattern 3: synchronized left-right patrol (group B)
N $8164 Adds a shared direction step ($8212, +2 or -2) to the soldier's X (IX+1); on hitting X=2 or X=$E6, flips $8212's sign - so every soldier using this pattern shares one direction byte and turns around in lockstep. Picks left/right-facing sprite from the sign of $8212, then builds the screen/sprite address via #R$9028 (shared with #R$900A/#R$9464).
C $8164,17 X += $8212 (shared step); hit X=2 or $E6?
C $8175,8 Flip $8212's sign
C $817D,10 C = soldier X; pick sprite by $8212 sign, continue at #R$9028
b $8193
c $81AA Draw sprite 32x32 with mask (masked blit)
@ $81AA label=DrawSpriteMasked
N $81AA BC=sprite addr, DE=mask addr, HL=dest. Standard AND-mask/OR-pixels blit, 4 rows x 8 rows x 4 bytes = 32x32. Used by #R$8F8C (draw soldier) and #R$9118 (draw collectible icon).
C $81AA,2 Outer loop: 4 column-groups
C $81AE,2 Inner loop: 8 rows
C $81B2,6 AND mask, OR pixels, write (one 8-pixel strip)
c $81E6
C $81ED,3 Wait for a key or timeout
b $81F8
b $8200 Variables
B $8201,1,1 Joe X; initial = $3C
B $8202,1,1 current room-tile index = room + 8*subtile; indexes $8300, $9700, $7900
B $8203,1,1 room number: 0..7; initial = 3
B $8204,1,1 room level: $00..$0F, initial = $0F
B $8206,1,1 counter
B $8209,1,1 Joe orientation/special-move state: bit0/1 set by #R$7F0F/#R$7F1D (jump-arc direction), bit5 flips facing in #R$80A0 (dead code, never written), bits0/1/7 select alt sprite bank $D0. Cleared to 0 by #R$7FE6's timer.
B $820A,1,1 input state FUDLR: bit0=right, bit1=left, bit2=down, bit3=up, bit4=fire
B $820B,1,1 Joe's facing direction (0/1), set in #R$7F6E/#R$7FA0; drawn via #R$80A0
B $820C,1,1 current tile's terrain flags (from $8300, set at $8114): bit0=blocks rightward room-jump, bit1=blocks leftward room-jump, bit2=up-stair right, bit3=down-stair right, bit4=up-stair left, bit5=down-stair left, bits6-7=room colour zone (0-3, picks INK 4-7 = green/cyan/yellow/white bright-on-black for most of the attribute file). All 8 bits confirmed against known room layout and observed room colours (see docs/Room-Format.md).
B $820D,1,1 jump counter
B $8214,1,1 hostage counter (collected via #R$86E4)
B $8215,1,1 key counter (collected via #R$92A0); also spent 1/climb on key-gated staircases (#R$9880, gated by $9500 bit5)
B $8216,1,1 bomb counter (collected via #R$92DE)
B $821F,1,1 counter
B $8220,1,1 slower counter
W $8221,2,2 Joe screen address
W $8223,2,2 Joe sprite mask address
B $8225,1,1 ammo/bullet count (+=10 via #R$A328, consumed 1/shot via #R$A798); initial=$14
B $8226,1,1 kill-sparkle animation counter, 2nd slot (set by #R$A798/#R$7869 on a hit; driven by #R$FF3E, cleared by #R$FFAD)
B $8227,1,1 kill-sparkle anchor byte (#R$FF3E), pairs with $8217
b $8228 Variables initial values, 40 bytes
B $8228,40,8
c $8250 Fill status-bar decoration from fixed data $82BE
N $8250 Called from #R$828C. Copies the fixed (non-paged) tile data at $82BE into the bottom-screen HUD/border area starting $5000, in a 4x2x8 nested-loop pattern (8 columns x 2 rows x 4-byte strips). Same shared for every room - see the Draw pipeline section in docs/Room-Format.md.
C $8250,8 HL = $5000, DE = $82BE (fixed source data)
C $8258,2 Shared entry point (B/DE/HL from caller) - used by #R$828C to draw a single icon of arbitrary size/source/destination
C $8264,6 Copy a 4-byte strip
b $8280
c $828C Draw down-stair indicator icons in the HUD
N $828C Called from #R$8114 after #R$8250. Checks $820C bits 5/3 (down-stair left/right) and draws a small icon (source $8380, via #R$8258) at $5004 (left) or $5018 (right) when the current tile has that stair.
C $828C,3 Fill status-bar decoration from fixed data $82BE
C $828F,5 $820C bit5 (down-stair-left)?
C $82A3,5 $820C bit3 (down-stair-right)?
b $82B7
b $8300
c $83C0 Clear screen, border to black
@ $83C0 label=ClearScreen
N $83C0 Clears the full bitmap ($4000-$57FF), fills attributes ($5800-$5AFF) with bright white-on-black, and sets the border black.
C $83C0,11 Clear bitmap $4000-$57FF
C $83CD,5 Fill attributes with bright white-on-black
b $83D9
c $83E1
C $83E8,3 Wait for a key or timeout
C $83F0,3 => Main menu loop
b $83F3
b $8400 Signs for title/menu screens
B $8400,11,11 'WRITTEN BY '
B $840B,16,16 'COLIN SWINBOURNE'
B $841B,1,1
B $841C,11,11 'REMIXED BY '
B $8427,6,6 'FLUPPY'
B $842D,1,1
B $842E,6,6 ' PRESS'
B $8434,1,1
B $8435,6,6 'C FOR '
B $843B,15,15 'CONTROL OPTIONS'
B $844A,1,1
B $844B,10,10 'S TO START'
B $8455,1,1
B $8456,11,11 'H FOR HIGH '
B $8461,12,12 'SCORES TABLE'
B $846D,1,1
B $846E,6,6 ' K FOR KEYBOARD'
B $8484,1,1
B $8485,14,14 'J FOR KEMPSTON '
B $8493,8,8 'JOYSTICK'
B $849B,1,1
B $849C,14,14 'S FOR SINCLAIR '
B $84AA,1,1
B $84AC,8,8 'KEYBOARD'
B $84B4,1,1
B $84B5,10,10 'LEFT.....O'
B $84BF,1,1
B $84C0,10,10 'RIGHT....P'
B $84CA,1,1
B $84CB,10,10 'UP.....Q-T'
B $84D5,1,1
B $84D6,10,10 'DOWN...A-G'
B $84E0,1,1
B $84E1,14,14 'FIRE...B-SPACE'
B $84EF,1,1
b $84F0
t $8502
b $8509
c $850E Rolling-digit counter increment (pending tick from $820F)
N $850E Called every frame from #R$8F00. If $820F (a pending-increment countdown, scheduled by #R$855B) is non-zero, decrements it and increments the counter selected by $8210 (row of 16 bytes at $89xx: a 16-bit value plus its ASCII digit string), carrying '9'->'0' through the digits, then continues into #R$8982 for the redraw if $8210's counter is active.
C $850E,9 Check pending tick $820F; return if none
C $8517,11 HL = counter row at $89xx (selected by $8210)
C $8522,8 Increment the 16-bit counter value
C $852A,17 Roll the ASCII digit string ('9'->'0' carry)
C $8541,3 => High-score table
s $8544
c $8546
C $8558,3 => Draw string IX
c $855B
s $8567
c $856E Pickup/beep sound effect (descending pitch sweep)
@ $856E label=SFX_pickup
N $856E Generic short beep played whenever a counter changes (called from the collectible-pickup routines, #R$9650, etc). Border-toggle (`OUT ($FE)`) sweep from $2E00 down to $24xx.
C $856E,7 HL/DE = sweep start/rate
C $8580,5 Toggle border, delay
C $858D,7 HL reached $24xx? loop or return
b $8594
c $8596 Draw string IX and play sound
C $8596,3 Draw string IX
C $8599,3 => Pickup/beep sound effect
b $859C
c $85DC
B $85A0,12,12 'GOOD SCORING'
C $85ED,3 Copy an 8x4-byte column (DE->HL), used by the door-drawing routines
C $85F4,3 => Copy an 8x4-byte column (DE->HL), used by the door-drawing routines
b $85F7
b $85FA Countdown timer display "20:00" (digit,digit,separator,digit,digit)
N $85FA Digit glyphs are $20-$29 ('0'-'9', confirmed from #R$9650's underflow check `CP $1F`->reset and #R$850E's overflow check `CP $2A`->reset). #R$9650's decrement cascade only touches $85FE/$85FD/$85FB (not $85FC) confirming $85FC ($1D) is a separator glyph, not a digit. Init bytes $22,$20,$1D,$20,$20 decode to "20:00". $85FB wraps to $25 ('5') on underflow instead of $29 ('9') like the other two - that digit position is capped 0-5, consistent with a MM:SS-style seconds-tens digit.
b $8600
c $8680 Wait for a key or timeout
@ $8680 label=WaitKeyTimeout
N $8680 Busy-waits for HL*BC ticks (both caller-supplied), flashing the border on two independent countdowns (BC = fast, DE = slow) as a "waiting" indicator. Does not itself poll the keyboard - callers check for a keypress separately and just use this for the timed pause/flash.
C $8680,15 Save BC and BC+1 as two independent countdowns
C $8690,5 Fast tick: flash border when BC reaches 0
C $86AD,6 HL reached 0? loop or return (EI)
s $86B3
c $86C0
C $86C0,3 Draw black box on the screen
C $86D2,3 Draw string IX
C $86D8,3 Draw string IX
C $86DB,3 Pickup/beep sound effect
C $86DE,3 => Delay
b $86E1
c $86E4 Collect a hostage tile: mark, count, redraw
@ $86E4 label=PickupHostage
N $86E4 Called by #R$926E when Joe touches a $9D24-table tile at the screen edge. Marks the tile visited ($FF), increments the hostage counter $8214, draws the updated digit, and rebuilds the room background (the collected tile disappears).
C $86E4,7 Mark tile visited ($FF); increment hostage counter $8214
C $86EE,3 Draw one digit/character glyph
C $86F1,3 Build room background into shadow buffer $B800
s $86FA
t $8700
b $8733
t $8749
b $875A
t $8775
b $877C
t $877F
b $8783
t $8796
b $8799
b $8901 High-score table (name + score rows), indexed by $8210
N $8901 Read/written by #R$850E/#R$8982 as `$8900 + $8210*16` (16-byte rows). Each visible row looks like: name text (same font encoding as the HUD strings, terminated $FF) followed by a numeric score field. Row boundaries don't cleanly divide the observed $8901-$8963 span into fixed 16-byte chunks though (name lengths vary 7-8 chars) - the $8210*16 stride from the code doesn't match what's visible here byte-for-byte, so exact row layout is unconfirmed; needs live tracing (watch $8210 and this region during an actual high-score entry). Was previously fragmented into ~13 spurious t/b blocks by the same sna2skool text-detection heuristic fixed for $9D00/$6C00.
B $8901,99,8
c $8964 High-score name entry: store selected character
N $8964 Called from #R$9580 (the name-entry cursor loop). During hi-score name entry, $8201/$8202 are repurposed as the cursor column and selected character. Writes the selected character ($8202) into the current table row at $8900 + $8210*16 + $0A + cursor column ($8201), then plays a beep (#R$856E). Part of the same cluster as #R$850E/#R$8982 (digit-roll + sort) - together they implement entering initials for a new high score.
C $8964,9 HL = row + $0A + cursor column ($8201)
C $896E,3 get Joe X
C $8975,3 get current room-tile index = room + 8*subtile
C $8979,3 Pickup/beep sound effect
b $897D
c $8982 High-score table: bubble the current row into sorted order
N $8982 Called from #R$850E after a digit increment. Compares the current 16-byte table row (HL, at $89xx) against the previous row (HL-$10); if their first 2 bytes match(?) swaps the two 16-byte rows, decrements $8210 (row index) and repeats - i.e. bubbles an updated entry up through the table until it's back in sorted order. The $8900+ data itself looks like a name+score table: name text (same encoding as HUD strings, $1F-padded) terminated by $FF, followed by a numeric score field - not yet given clean ctl boundaries (still fragmented by the same text-heuristic issue fixed elsewhere for $9D00/$6C00).
C $8982,5 DE = HL - $10 (previous table row)
C $8987,8 Compare leading bytes of both rows; return if different
C $898F,15 Swap the two 16-byte rows
C $899E,16 Decrement row index $8210; loop
b $89AE
c $89B4 Show main menu
@ $89B4 label=ShowMainMenu
N $89B4 Draws title screen (big "JOE BLADE" sign, credits, copyright), sets 3 rows of attributes, then waits for all keys to be released before returning. Does not wait for a keypress itself; the wait-for-keypress loop is elsewhere ($8A12 group).
C $89B4,3 Clear screen, border to black
C $89B7,3 Show "JOE BLADE" big sign on the screen
C $89BA,4 'WRITTEN BY ' - start of title signs
C $89C1,3 Draw string IX
C $89C7,3 Draw string IX
C $89CD,3 Draw string IX
C $89D0,10 Fill 7 attribute bytes at $59CC with $57 (INK 7, PAPER 2, BRIGHT)
C $89DD,3 Draw string IX
C $89E3,3 Draw string IX
C $89E9,3 Draw string IX
C $89EC,11 Set attribute byte $57 at $5A25, $5A6A and $5AA4
C $89F7,9 Wait until no key is pressed
c $8A00 Show main menu => $8A12
N $8A00 Entry-point trampoline (one-instruction JP) used by callers outside this module; the real routine is at $8A12.
C $8A00,3 => Show main menu and wait for start
c $8A03 Poll main menu state => $8A3C
N $8A03 Entry-point trampoline; real routine at $8A3C.
C $8A03,3 => Check menu-done flag, dispatch to $8E96
c $8A06 Poll main menu state => $8A44
N $8A06 Entry-point trampoline; real routine at $8A44.
C $8A06,3 => Check menu-done flag, run paged-bank routine at $C006
c $8A09 Poll main menu state => $8A5E
N $8A09 Entry-point trampoline; real routine at $8A5E.
C $8A09,3 => Check menu-done flag, run paged-bank routine at $8A7A
c $8A0C Poll main menu state => $8AAE
N $8A0C Entry-point trampoline; real routine at $8AAE.
C $8A0C,3 => Check menu-done flag, run paged-bank routine
c $8A0F Poll main menu state => $8AD0
N $8A0F Entry-point trampoline; real routine at $8AD0.
C $8A0F,3 => Check menu-done flag, run paged-bank routine via HALT+$C003
c $8A12 Show main menu and wait for start
N $8A12 Draws title screen, then pages in RAM bank 1 and checks a condition byte at $C000. $8AFF is a "menu done" flag read by the other routines in this group ($8A3C-$8AD0). $C000/$C003/$C006 in bank 1 look like a 3-entry vector table (init/step/finish) for code resident in that bank; not yet identified further.
C $8A12,4 Clear $8AFF menu-done flag
C $8A16,3 Show main menu
C $8A19,3 DI; select bank 1
C $8A1C,5 Page in RAM bank 1
C $8A21,7 Check byte at $C000 (bank 1) against $26
C $8A28,3 Run paged-bank routine, wait for keypress
C $8A2B,4 DI; prepare port $7FFD
C $8A2F,4 Restore bank 0 paging
C $8A35,5 Set $8AFF=1 (menu done); bank 1 stays paged in
c $8A3C Check menu-done flag, dispatch to $8E96
N $8A3C Once the menu is done ($8AFF<>0), hands off to $8E96.
C $8A3C,5 Check $8AFF flag; return if menu not done
C $8A41,3 => Dispatch target from $8A41
c $8A44 Check menu-done flag, run paged-bank routine at $C006
N $8A44 Runs the bank-1 "finish" entry ($C006) once, while the menu is still active ($8AFF=0).
C $8A44,5 Check $8AFF flag; return if menu already done
C $8A49,3 DI; select bank 1
C $8A4C,5 Page in RAM bank 1
C $8A51,3 Call bank-1 finish entry ($C006)
C $8A54,3 DI; select bank 0
C $8A57,5 Restore bank 0 paging
c $8A5E Check menu-done flag, run paged-bank routine at $8A7A
N $8A5E While the menu is active, runs #R$8A7A in bank 1; once done, hands off into ROM at #R$FFD5 (unconfirmed).
C $8A5E,4 Check $8AFF flag
C $8A62,3 Jump to #R$FFD5 if menu done
C $8A65,3 DI; select bank 1
C $8A68,5 Page in RAM bank 1
C $8A6D,3 Run paged-bank routine, wait ~3 frames polling $C003
C $8A70,3 DI; select bank 0
C $8A73,5 Restore bank 0 paging
c $8A7A Run paged-bank routine, wait ~3 frames polling $C003
N $8A7A Drives the bank-1 vector table (init/step/finish) for a fixed 768-frame duration.
C $8A7A,5 Set $C009=3
C $8A7F,3 Call bank-1 init entry ($C000)
C $8A82,3 BC = 768 frame counter
C $8A85,2 Wait a frame (EI; HALT)
C $8A87,4 Call bank-1 step entry ($C003)
C $8A8B,5 Loop until counter=0
C $8A90,3 Call bank-1 finish entry ($C006)
c $8A94 Run paged-bank routine, wait for keypress
N $8A94 Drives the bank-1 vector table (init/step/finish) until a key is pressed.
C $8A94,4 Set $C009=0
C $8A98,3 Call bank-1 init entry ($C000)
C $8A9B,2 Wait a frame (EI; HALT)
C $8A9D,4 Call bank-1 step entry ($C003)
C $8AA1,6 Poll keyboard
C $8AA7,2 Loop until a key is pressed
C $8AA9,3 Call bank-1 finish entry ($C006)
c $8AAE Check menu-done flag, run paged-bank routine ($C009=1)
N $8AAE While the menu is active, runs the bank-1 finish entry then the init entry with $C009=1.
C $8AAE,5 Check $8AFF flag; return if menu already done
C $8AB3,3 DI; select bank 1
C $8AB6,5 Page in RAM bank 1
C $8ABB,3 Call bank-1 finish entry ($C006)
C $8ABE,5 Set $C009=1
C $8AC3,3 Call bank-1 init entry ($C000)
C $8AC6,3 DI; select bank 0
C $8AC9,5 Restore bank 0 paging
c $8AD0 Check menu-done flag, run paged-bank routine via HALT+$C003
N $8AD0 While the menu is active, waits a frame and runs the bank-1 step entry once.
C $8AD0,5 Check $8AFF flag; return if menu already done
C $8AD5,3 DI; select bank 1
C $8AD8,5 Page in RAM bank 1
C $8ADD,2 Wait a frame (EI; HALT)
C $8ADF,3 Call bank-1 step entry ($C003)
C $8AE2,3 DI; select bank 0
C $8AE5,5 Restore bank 0 paging
b $8AEC
c $8B02 Show "JOE BLADE" big sign on the screen
@ $8B02 label=ShowJoeBladeSign
C $8B02,3 Address on the screen
N $8B05 Show "JOE BLADE" big sign; HL = screen address
C $8B28,3 Address in screen attributes
b $8B33
c $8B37 Main menu loop: poll keys, dispatch to Control/Start/High-scores
@ $8B37 label=MainMenu
N $8B37 Draws the menu once, then polls C/S/H each frame (matches the "C FOR CONTROL OPTIONS", "S TO START", "H FOR HIGH SCORES" prompts): C enters #R$8BB4 (control options), S jumps into #R$7D00 (start the game), H jumps into #R$8DBE (high scores).
C $8B37,3 Show main menu => $8A12
C $8B3A,3 Poll main menu state => $8A3C
C $8B3D,5 Read keyboard row $FEFE (CAPS,Z,X,C,V)
C $8B45,3 'C' pressed => #R$8BB4 (control options)
C $8B48,5 Read keyboard row $FDFE (A,S,D,F,G)
C $8B50,3 => Start game
C $8B53,5 Read keyboard row $BFFE (B,N,M,SS,SPACE)
C $8B5B,3 'H' pressed => #R$8DBE (high scores)
C $8B5E,3 Loop back and poll again
b $8B61
c $8B64 Control-options screen: J/S/K input method selector
N $8B64 Part of the control-options screen ($8BB4). Polls J (Kempston), S (Sinclair), K (keyboard) and highlights the chosen option, setting $FFFF as a persisted "input method" flag (read back into $820E at init - see #R$8032).
C $8B64,10 Read row $BFFE bit3 (J = Kempston)
C $8B8B,9 Read row $FDFE bit1 (S = Sinclair)
C $8B9C,10 Read row $BFFE bit2 (K = keyboard)
s $8BB3
c $8BB4
C $8BB4,3 Clear screen, border to black
C $8BBE,3 Draw string IX
C $8BC4,3 Draw string IX
C $8BCA,3 Draw string IX
C $8BD0,3 Draw string IX
C $8BE7,3 => Control-options screen
b $8BEA
c $8C00 Build room background into shadow buffer $B800
@ $8C00 label=BuildRoom
N $8C00 Reads room-layout selector bytes from the paged RAM bank at $C000+offset (offset from room number $8203 and subtile $8204 - same 128K bank paged in around #R$8A12). Each selector byte is decoded into the source address of a pre-made 32x32 "back sprite" (#R$8C5A) and a 2x8 grid of them is stamped into the shadow buffer at $B800. Falls through to #R$8CF0 for one more row. The shadow buffer is later copied to the real screen by #R$8C78.
N $8C00 Offset = level*128 + room*16 (level=$8204&$0F, room=$8203&$07). Selector byte: bit0 = tile variant, bits1-5 = tile index; decodes to source addr $E0+((byte>>1)&$1F) : (bit0?$80:0) - tiles live at $E000-$FFFF, 64 tiles x 128 bytes (32x32 1bpp). Full details, confirmation method and open questions in joeblade-zx/docs/Room-Format.md - in short: only the first 3 room-slots in the one bank sampled decode to real tile data, the rest of that region is code, and which bank is actually paged in during gameplay is still unconfirmed.
C $8C00,4 IX = $C000 (paged-bank tile-selector table)
C $8C04,9 E = (room $8203 & 7) * 16
C $8C0E,7 D = (subtile $8204 & $0E) >> 1
C $8C15,10 If subtile bit0 set, E += $80
C $8C20,2 IX += DE (selector-table offset for this room/subtile)
C $8C22,5 HL = $B800 (shadow buffer); outer loop, 2 rows
C $8C29,4 Inner loop, 8 columns; DE = 0
C $8C30,7 If selector byte bit0 set, E = $80
C $8C39,8 D = $E0 + ((selector byte >> 1) & $1F): back-sprite source address
C $8C42,2 Advance to next selector byte
C $8C44,3 Draw back sprite 32x32
C $8C47,5 HL += 4 (advance dest column)
C $8C4F,4 Restore HL row start, advance to next row (L += $80)
C $8C55,3 => Draw one more background row directly onto the real screen
s $8C58
c $8C5A Draw back sprite 32x32
@ $8C5A label=DrawBackTile
N $8C5A Stamps one 32x32 "back sprite" (a pre-made room-background block) into the shadow/real screen. DE = back sprite source addr, HL = destination addr.
C $8C5A,2 Outer loop: 4 column-groups
C $8C5E,2 Inner loop: 8 rows
C $8C64,6 Copy 4 bytes/row (DE->HL)
c $8C78 Copy shadow screen to real screen
@ $8C78 label=ShowScreen
N $8C78 Pops the stack-built shadow buffer at $B800 and writes it into the real screen bitmap starting at $4800, restoring SP afterwards.
C $8C7A,6 save SP to IX
C $8C80,3 buffer start address
C $8C83,3 screen address
C $8C88,1 0
C $8C8D,1 1
C $8C92,1 2
C $8C97,1 3
C $8C9C,1 4
C $8CA1,1 5
C $8CA6,1 6
C $8CAB,1 7
C $8CB0,1 8
C $8CB5,1 9
C $8CBA,1 10
C $8CBF,1 11
C $8CC4,1 12
C $8CC9,1 13
C $8CCE,1 14
C $8CD3,1 15
C $8CDA,2 restore SP from IX
b $8CDF
c $8CF0 Draw one more background row directly onto the real screen
N $8CF0 Unlike #R$8C00, this draws straight to the live screen at $4080 instead of the shadow buffer, using a separate per-column selector table at $6C00 indexed by $8202 - purpose of the split (top HUD-adjacent strip?) unconfirmed.
C $8CF0,9 HL = $8202 * 8 (byte offset into table at $6C00)
C $8CF9,7 IX = $6C00 + offset (one selector byte per screen column)
C $8D12,5 HL = $4080 (top strip of the real screen); 8 columns
C $8D19,3 DE = 0
C $8D1C,7 If selector byte bit0 set, E = $80
C $8D25,8 D = $E0 + ((selector byte >> 1) & $1F): back-sprite source address
C $8D2E,2 Advance to next selector byte
C $8D30,3 Draw back sprite 32x32
C $8D33,5 HL += 4 (advance dest column)
c $8D3C Check for room-edge tile, trigger transition/control screen
N $8D3C Scans the bomb tile table $9D18 (same table used for bomb pickup, see docs/Actors.md); if the current room-tile ($8202) matches one of them AND $820C bits 4-5 are clear AND Joe's X is at the screen edge ($20 or $C0), jumps to #R$7800 - the bomb-deactivation minigame ("SELF DESTRUCT IN 30 SECONDS", sort 5 letters). Not a room-to-room transition.
C $8D3C,5 HL = $9D18 (table of 6 edge-tile IDs); B = 6
C $8D41,6 Compare current tile ($8202) against table entry
C $8D47,7 Check $820C bits 4-5 (tile flags)
C $8D4E,5 Joe at left edge (X=$20)? => #R$7800
C $8D53,3 => Bomb deactivation minigame
C $8D57,5 Joe at right edge (X=$C0)? => #R$7800
C $8D5C,3 => Bomb deactivation minigame
b $8D64
B $8D64,10,1
c $8D6E Draw sprite 32x32 with mask
N $8D6E BC = sprite addr, DE = mask addr, HL = destination
C $8D71,1 get mask byte
C $8D72,1 apply mask
C $8D74,1 get pixels byte
C $8D75,1 apply pixels
c $8DB4
b $8DB7
c $8DBE
C $8DBE,3 Clear screen, border to black
C $8DC8,3 Draw string IX
C $8DDC,3 Draw string IX and play sound
C $8DF7,3 Poll main menu state => $8AAE
C $8DFB,3 Poll main menu state => $8AD0
C $8DFF,3 Wait until every key on the keyboard is released
C $8E04,3 => Main menu loop
b $8E07
B $8E0D,7,7 ' SCORES'
c $8E16
C $8E1A,3 Clear screen, border to black
C $8E20,3 Draw string IX
C $8E30,3 Draw string IX
C $8E36,3 Draw string IX
C $8E3C,3 Draw string IX
C $8E42,3 Draw string IX
C $8E48,3 Draw string IX
C $8E4B,3 Wait until every key on the keyboard is released
C $8E50,3 => Main menu loop
c $8E53 Copy soldier sprite template to working area
N $8E53 Calls #R$96CE (checks the current tile's soldier movement pattern), then copies 13 bytes from the soldier sprite template at $8F8C to the working area $8FA0.
c $8E64 Per-frame soldier update
@ $8E64 label=ProcessSoldier
N $8E64 Called from #R$FF96 (via #R$8F0C in the main loop). Refreshes the soldier's movement pattern (#R$8E53/#R$96CC), draws it (#R$8F5A/#R$FF3E), then reacts to a shot hit via #R$789D.
C $8E64,3 Copy soldier sprite template to working area
C $8E67,3 Soldier presence/movement-pattern dispatch for the current tile
C $8E6D,3 Kill-sparkle animation, 2nd slot
C $8E70,3 => Kill-sparkle animation, gated on $7B10
b $8E73
c $8E96 Dispatch target from $8A41
N $8E96 Reached via #R$8A3C (JP $8E96) once the main menu is done.
C $8EB0,3 => Wait for a key or timeout
c $8EB4 Post-game hub: menu, or high-score name entry
@ $8EB4 label=FinalizeGame
C $8EB4,3 Clear screen, border to black
C $8EBC,3 => Main menu loop
C $8EBF,4 'GOOD SCORING'
C $8EC6,3 Draw string IX
C $8ECC,3 Draw string IX
C $8ED2,3 Draw string IX
C $8EDF,3 Wait until every key on the keyboard is released
C $8EE4,3 => High-score name entry
s $8EE7
c $8F00 Main game loop
@ $8F00 label=GameLoop
N $8F00 Reached from #R$7D00 via #R$8114/#R$FFAD/#R$7D96 when 'S' starts the game. One iteration per HALT: runs room/collision/energy/door subsystems, redraws Joe and the soldier, then polls the '0' key on row $EFFE - loop back to itself while not pressed, otherwise reset the stack and jump to #R$8EB4 (back to the menu/game-over flow).
C $8F00,3 Check for room-edge tile, trigger transition/control screen
C $8F03,3 Jump sound effect, gated on jump counter $820D
C $8F06,3 Countdown timer tick, MM:SS-style display at $85FA
C $8F09,3 Uniform pickup
C $8F0C,3 Per-frame soldier update
C $8F0F,3 Rolling-digit counter increment
C $8F12,3 Disguise duration timer
C $8F15,3 Per-frame collectible items scan
C $8F1B,3 Read input into $820A
C $8F1E,3 Draw per-room door/object graphics from event-flags table
C $8F21,4 Increment room counter at $8206
C $8F25,3 Movement/collision
C $8F29,2 Wait a frame (EI; HALT)
C $8F2B,3 Running line of symbols
C $8F2E,3 Win-condition check
C $8F31,3 Call $8546
C $8F34,3 Pause
C $8F37,3 Running line of symbols
C $8F3A,3 Copy shadow screen to real screen
C $8F3E,3 Draw Joe sprite
C $8F41,3 Draw soldier ??
C $8F44,3 Something with energy ??
C $8F48,8 Poll '0' key (row $EFFE)
C $8F50,3 => Main game loop
C $8F53,6 '0' pressed: reset stack, jump to #R$8EB4
b $8F59
c $8F5A
C $8F5F,3 => Shoot
b $8F62
c $8F78 Pause
b $8F82
c $8F8C Draw soldier ??
C $8F8C,3 !!MUT-ARG!! Soldier mask
C $8F8F,3 !!MUT-ARG!! Soldier sprite
C $8F92,3 !!MUT-ARG!! screen address
C $8F95,3 Draw sprite 32x32 with mask
C $8FA0,3 !!MUT-ARG!! Soldier mask
C $8FA9,3 Draw sprite 32x32 with mask
b $8FB1
c $8FB4 Set interrupt-vector page register I=$8A
N $8FB4 Called once at game start via #R$A3CB. Sets I=$8A - would only matter under IM2, but no `IM 2` instruction exists anywhere in the currently-disassembled 64K, so this may be vestigial/defensive rather than load-bearing.
b $8FC1
c $900A Soldier pattern 1: chase Joe's X; shared screen/sprite-address builder
N $900A Compares Joe's X against the soldier's X (IX+1); moves the soldier one step toward Joe (INC/DEC), picking a left/right-facing sprite (DE=$A800/$AA00) accordingly. Falls into $9028 (also entered directly by #R$8164/#R$9464) which turns the soldier's X (C) into a screen address (HL, $8F93) and sprite/mask address (DE, $8F90/$8F8D) - bit1 of X selects sprite half, bit2 selects sprite row.
C $900A,13 Compare Joe X vs soldier X (IX+1); step toward Joe
C $9017,5 Moving right: DE = $AA00 (right-facing sprite)
C $901C,6 Moving left: DE = $A800 (left-facing sprite)
C $9022,3 C = soldier X
C $9028,11 HL = screen address from soldier X
C $9033,7 Bit1 of X: E = $80 (sprite half)
C $903A,7 Bit2 of X: D += 1 (sprite row)
C $9041,11 Store $8F90 = DE, $8F93 = HL; D += 4
C $904C,5 Store $8F8D = DE
s $9051
c $905A Running line of symbols
N $905A Called every frame from #R$8F00. Bit-rotates 5 rows of pixels at $407F left through carry (a scrolling decorative border effect), then advances a slower secondary animation frame ($821F/$8220-gated) sourced from a table at $9E00.
C $905A,5 HL = $407F; C = 5 rows
C $906C,4 Advance frame counter $821F
C $90A0,1 read character pixels
C $90A2,1 write character pixels
s $90A7
c $90AA Draw door graphic column 1 (animated, via $8206)
C $90BB,3 Copy an 8x4-byte column (DE->HL), used by the door-drawing routines
C $90C2,3 => Copy an 8x4-byte column (DE->HL), used by the door-drawing routines
s $90C5
c $90C8 Copy an 8x4-byte column (DE->HL), used by the door-drawing routines
N $90C8 Shared column-copy primitive for #R$85DC/#R$90AA/#R$95E6 (the 3 door-graphic columns in #R$9602).
C $90C8,2 B = 8 lines
C $90DC,1 next line
b $90E0
B $90E0,1,1 'Z'
B $90E1,9,9 'HOSTAGES '
B $90EA,1,1 '0' = number of hostages collected
B $90EC,5,5 'KEYS '
B $90F1,1,1 '0' = number of keys collected
B $90F3,6,6 'BOMBS '
B $90F9,1,1 '0' = number of bombs collected
B $90FB,5,5 'SCORE'
t $9101
b $9106
c $9118 Draw a collectible-item sprite, left or right variant
@ $9118 label=DrawItemSprite
N $9118 Called by #R$912C once a collectible tile has been matched (DE/other regs already set up by the caller for #R$81AA). Picks between two destination columns in the shadow buffer ($B898 or $B884) based on $820C bits4-5, then draws via #R$81AA.
C $9122,3 => Draw sprite 32x32 with mask
C $9128,3 => Draw sprite 32x32 with mask
s $912B
c $912C Detect collectible tile under Joe, draw its icon
@ $912C label=DetectItem
N $912C Scans the same 4 tile-ID tables used by #R$926E/#R$92A0/#R$9300/#R$9328 for a match against the current tile ($8202): $9D00 (15 entries, keys), $9D0F (6 entries, food), $9D18 (6 entries, bombs - also checked by #R$8D3C's level-exit test), $9D24 (6 entries, hostages). On a match, sets up the item's sprite/mask data and draws it via #R$9118. No match in any table -> falls through to #R$A2F6, which checks ammo ($9D20) and uniform ($9D2B - see #R$A328/#R$7B1E).
C $9134,3 get current room-tile index = room + 8*subtile
C $913D,3 => Draw a collectible-item sprite, left or right variant
C $914C,3 get current room-tile index = room + 8*subtile
C $9155,3 => Draw a collectible-item sprite, left or right variant
C $9163,3 get current room-tile index = room + 8*subtile
C $9170,3 => Draw a collectible-item sprite, left or right variant
C $917F,3 get current room-tile index = room + 8*subtile
C $9188,3 => Draw a collectible-item sprite, left or right variant
C $918E,3 => Detect ammo or uniform tile under Joe, draw its icon
s $9191
c $9196 Draw string IX
@ $9196 label=DrawStringIX
C $91B6,1 read character pixels
C $91B7,1 write character pixels
C $91BE,3 => Draw string IX
s $91C1
c $91C8 Sound effect (descending pitch sweep), used at a room edge
N $91C8 Called from #R$7F64 (a jump-arc edge case in #R$7E32). Same border-toggle (`OUT ($FE)`) sweep pattern as #R$856E/#R$A2BE, from $3800 down to $28xx.
C $91C8,6 HL/E = sweep start/rate
C $91D8,5 Toggle border, delay
C $91DD,16 HL -= 16
c $91FA Wait until every key on the keyboard is released
@ $91FA label=WaitKeyUp
N $91FA Reads and ANDs all 8 keyboard half-rows together, returning non-zero only when nothing at all is pressed - a full-keyboard version of the single-row "no key pressed" checks used elsewhere.
C $91FA,5 Read row $FEFE
C $9229,3 Invert and mask result
s $922E
c $923C Draw black box on the screen
@ $923C label=DrawPopupBox
N $923C Clears a 4x8-column, 20-byte-tall bitmap rectangle starting at $4846 - the popup box background behind pickup/message text (called before drawing item-collected messages and similar dialogs).
C $923C,5 HL = $4846; B = 4 columns
C $9243,3 B = 8 groups
C $9247,7 B = $14 (20); clear a byte strip
c $925C Draw one digit/character glyph
c $926E Hostage pickup: check $9D24 tile at screen edge
@ $926E label=CheckHostage
N $926E Scans the 6-entry hostage tile table $9D24; on a match, checks $820C bits4-5 to pick which screen edge to test Joe's X against ($20 or $C0), and if Joe is there, collects it via #R$86E4.
C $926E,5 HL = $9D24 (hostage tile table); B = 6
C $9273,6 Compare current tile ($8202) against table entry
C $9279,5 $820C bits4-5: pick which edge to check
C $9280,3 get Joe X
C $9285,3 => Collect a hostage tile
C $9289,3 get Joe X
C $928E,3 => Collect a hostage tile
c $9296 Delay (redirect)
C $9296,3 => Delay
b $9299
c $92A0 Key pickup: check $9D00 tile at screen edge
@ $92A0 label=CheckKey
N $92A0 Same pattern as #R$926E but for the 15-entry key tile table $9D00; collects directly inline at $92C8 (mark tile $FF, increment key counter $8215, redraw digit, rebuild background).
C $92A0,5 HL = $9D00 (key tile table); B = 15
C $92A5,6 Compare current tile ($8202) against table entry
C $92AB,5 $820C bits4-5: pick which edge to check
C $92B2,3 get Joe X
C $92BB,3 get Joe X
N $92C8 Pickup the key
C $92C8,7 Mark tile visited ($FF); increment key counter $8215
C $92D2,3 Draw one digit/character glyph
C $92D5,3 Build room background into shadow buffer $B800
c $92DE Bomb pickup: mark tile, count, rebuild
N $92DE Called by #R$9300 when Joe touches a $9D18-table tile at the screen edge. Sets bit7 on the tile's byte (rather than $FF like the other 3 pickups), increments the bomb counter $8216, redraws the digit, and does an extra countdown-timer tick at $85F9 (shared with #R$9650) before rebuilding.
C $92DE,7 Set bit7 on tile byte; increment bomb counter $8216
C $92EA,3 Draw one digit/character glyph
b $92FA
c $9300 Bomb pickup: check $9D18 tile at screen edge
@ $9300 label=CheckBomb
N $9300 Same pattern as #R$926E, for the 6-entry bomb tile table $9D18 (also scanned by #R$8D3C's level-exit check - collecting the last bomb at the edge may be what triggers that). On match, hands off to #R$92DE.
C $9300,5 HL = $9D18 (bomb tile table); B = 6
C $9305,6 Compare current tile ($8202) against table entry
C $930B,5 $820C bits4-5: pick which edge to check
C $9312,3 get Joe X
C $9317,3 => Bomb pickup
C $931B,3 get Joe X
C $9320,3 => Bomb pickup
c $9328 Food pickup: check $9D0F tile at screen edge
@ $9328 label=CheckFood
N $9328 Same pattern as #R$926E, for the 6-entry food tile table $9D0F. Collects inline at $9350 (mark tile $FF, rebuild background, then #R$9456 - refills the energy gauge via #R$A23C). No dedicated on-screen counter byte like the other pickups (it's consumed immediately as a health refill, not stockpiled).
C $9328,5 HL = $9D0F (food tile table); B = 6
C $932D,6 Compare current tile ($8202) against table entry
C $9333,5 $820C bits4-5: pick which edge to check
C $933A,3 get Joe X
C $9343,3 get Joe X
N $9350 Pickup the food
C $9350,2 Mark tile visited ($FF)
C $9352,3 Build room background into shadow buffer $B800
C $935A,3 Refill energy gauge
c $935E "YOU ARE DEAD" message and finalize the game
@ $935E label=JoeDead
C $935F,3 Draw black box on the screen
C $9362,4 '  YOU ARE DEAD'
C $9366,3 screen address
C $9369,3 Draw string IX
C $936C,3 Poll main menu state => $8A5E
C $936F,3 Wait until every key on the keyboard is released
C $9374,3 => Post-game hub
b $9377
B $9382,14 '  YOU ARE DEAD'
B $9390,1,1
c $9396 Set Joe's screen address HL and sprite mask DE
N $9396 DE = mask addr, HL = destination addr
C $9399,4 set current Joe sprite mask address
s $939E
c $93A0 Reduce energy
C $93B7,3 Draw a string of 8x8 glyphs
C $93BE,3 => "YOU ARE DEAD" message and finalize the game
b $93C2
c $93DC Something with energy ??
C $93DF,4 get current Joe sprite mask address
C $93E3,3 B = D - 4
C $93E6,1 now BC = Joe sprite addr, DE = mask addr, HL = screen addr
C $93F0,3 => Reduce energy, if allowed
C $93FC,3 => Reduce energy, if allowed
C $9408,3 => Reduce energy, if allowed
C $9414,3 => Reduce energy, if allowed
s $9442
c $9446 B = D - 4
b $944C
c $9456 Refill energy gauge (food pickup effect)
N $9456 Calls #R$A23C to refill the energy gauge $A228-$A239 back to full, then clears $8205.
C $9456,3 Energy gauge initial fill
s $945F
c $9464 Soldier pattern 2: synchronized left-right patrol (group A)
N $9464 Byte-identical to #R$8164 but uses $8213 as the shared direction step instead of $8212 - a second, independent synchronized patrol group.
C $9464,17 X += $8213 (shared step); hit X=2 or $E6?
C $9475,8 Flip $8213's sign
C $947D,10 C = soldier X; pick sprite by $8213 sign, continue at #R$9028
b $9493
c $9498 Set initial values
C $94A1,2 set variables initial values
C $94AF,3 Poll main menu state => $8A44
C $94BD,3 Energy gauge initial fill
b $9500 Per-room event/object flags, indexed by $8202
N $9500 One byte per room-tile ($8202, 0-127). Read by #R$9602 each frame; each bit conditionally draws a door/object graphic (see #R$9602 for the bit map).
c $9580 High-score name entry: cursor loop
N $9580 Repurposes $8201 as the cursor column and $8202 as the selected character for entering initials into a new high-score row. Up/down cycles the character (#R$8964 stores it), left/right likely moves the cursor (unconfirmed in detail) - reached from #R$8EB4 when $8210=5.
C $9582,3 set Joe X
C $9585,3 set current room-tile index = room + 8*subtile
C $9588,3 Read input into $820A
C $958B,3 get input state
C $9592,3 High-score name entry
C $959F,3 get input state
C $95B1,3 get input state
C $95D0,3 get current room-tile index = room + 8*subtile
s $95E1
c $95E6
C $95F7,3 Copy an 8x4-byte column (DE->HL), used by the door-drawing routines
C $95FE,3 => Copy an 8x4-byte column (DE->HL), used by the door-drawing routines
s $9601
c $9602 Draw per-room door/object graphics from event-flags table
N $9602 Not room-transition code (that appears to be #R$8D3C, unconfirmed) - this draws animated door/object graphics for the current room-tile. IX = #R$9500 + $8202 (the current room-tile's event-flags byte). Bits 0,1,6,7 are NOPed out in this build (disabled/unused). Bits 2,3,4 each draw a different column of a door graphic (#R$90AA, #R$85DC, #R$95E6 - all index the same per-frame animation table at $8600+ via counter $8206, just at different destination columns in the shadow buffer: $B884/$B890, $B888/$B894, $B88C/$B898). Bit 5 (#R$FFE8) is gated on $8209==0 and leads into #R$9880: a key-gated staircase check - marks this tile as requiring a key to climb.
C $9602,6 IX = $9500 + $8202 (this room's event-flags byte)
C $960B,5 Bit0: unused (NOPed out)
C $9613,5 Bit1: unused (NOPed out)
C $961B,8 Bit2: draw door column 1 (#R$90AA)
C $9623,8 Bit3: draw door column 2 (#R$85DC)
C $962B,8 Bit4: draw door column 3 (#R$95E6)
C $9633,8 Bit5: key-gated staircase check (#R$FFE8)
C $963B,5 Bit6: unused (NOPed out)
C $9643,5 Bit7: unused (NOPed out)
s $964C
c $9650 Countdown timer tick, MM:SS-style display at $85FA
C $968C,3 => Draw string IX
C $968F,3 Draw black box on the screen
C $9699,3 Draw string IX
C $969C,3 Pickup/beep sound effect
C $969F,3 Pickup/beep sound effect
C $96A2,3 Pickup/beep sound effect
C $96A5,3 Pickup/beep sound effect
C $96A8,3 Pickup/beep sound effect
C $96AB,3 Pickup/beep sound effect
C $96AE,3 Pickup/beep sound effect
C $96B1,3 Pickup/beep sound effect
C $96B4,3 Pickup/beep sound effect
C $96B7,3 Pickup/beep sound effect
C $96BA,3 Pickup/beep sound effect
C $96BD,3 => "YOU ARE DEAD" message and finalize the game
b $96C0
c $96CC Soldier presence/movement-pattern dispatch for the current tile
N $96CC The even (low) byte of #R$9700's word pair for the current tile ($8202) is a soldier movement-pattern selector, not unused padding: 0 = no soldier (clears the soldier screen address $8F93 and returns), 1-6 select one of 6 movement routines (#R$900A/#R$9464/#R$8164/#R$7D64/#R$7D82/#R$7D8C). Confirmed 4/4 against known room layout: tiles $71/$7A (have a soldier) hold pattern 2/1; tiles $72/$7B (no soldier) hold pattern 0 - see docs/Actors.md.
C $96CC,10 IX = #R$9700 entry for current tile ($8202)
C $96D6,3 A = movement-pattern byte (0 = no soldier)
C $96DB,3 => Soldier pattern 1
C $96E0,3 => Soldier pattern 2
C $96E5,3 => Soldier pattern 3
C $96EA,3 => Soldier pattern 4
C $96EF,3 => Soldier pattern 5
C $96F4,3 => Soldier pattern 6
C $96F7,6 No/unknown pattern: clear soldier screen address $8F93
b $96FE
b $9700 Per-tile soldier movement pattern (low byte) + boundary value (high byte)
N $9700 Word pairs indexed by $8202 (low byte at $9700+2*idx, high byte at +2*idx+1 - the one #R$7D96 clamps into $46-$A5 each frame). The low byte is a soldier movement-pattern selector (0 = no soldier, 1-6 = a movement routine) - see #R$96CC and docs/Actors.md. Confirmed 4/4 against known room layout. Array proper is 128 words (256 bytes, index range 0-127); the trailing 128 bytes are unaccounted for.
W $9700,256,2
B $9800,128,8 Unidentified trailing bytes
c $9880 Key-gated staircase: consume a key to climb, or block the UP input
N $9880 Called (via #R$FFE8) whenever Joe isn't mid-jump ($8209=0) and the current tile has an up-stair flag set in $820C (bit4=left side, bit2=right side). If Joe is standing at that stair's screen edge with UP pressed: with keys in stock ($8215), consumes one and redraws the key-count digit (#R$925C); with none, clears the UP bit in $820A before #R$7E32 processes it - blocking the level-up transition outright. Confirms $8215's "key" role extends beyond a simple pickup counter: keys are also the toll for certain staircases. Left-edge and right-edge halves are otherwise identical.
C $9880,7 UP pressed?
C $9887,11 Joe at left edge (X&$E0=$20)?
C $9892,7 $820C bit4 (up-stair-left) set?
C $9899,6 Have keys ($8215)?
C $989F,10 No keys: clear UP bit in $820A
C $98A9,11 Have a key: decrement $8215, redraw digit
C $98B4,6 UP pressed? (right-side mirror)
C $98BA,10 Joe at right edge (X&$E0=$C0)?
C $98C4,6 $820C bit2 (up-stair-right) set?
C $98CA,6 Have keys ($8215)?
C $98D0,9 No keys: clear UP bit in $820A
C $989F,3 get input state
C $98A4,3 set input state
C $98B4,3 get input state
C $98BA,3 get Joe X
C $98D0,3 get input state
C $98D5,3 set input state
s $98D9
c $98DA Have a key (right-side stair): decrement $8215, redraw digit
C $98E2,3 => Draw one digit/character glyph
b $98E5
b $9900 Sprites and masks for objects
N $9900 Sprite 32x32 bomb
B $9900,128,8 #HTML[#UDGARRAY4,7,4,4,,($9900-$997F-1-32)(spr9900)]
N $9980 Mask 32x32 bomb
B $9980,128,8 #HTML[#UDGARRAY4,56,4,4,,($9980-$99FF-1-32)(msk9980)]
N $9A00 Sprite 32x32 key
B $9A00,128,8 #HTML[#UDGARRAY4,7,4,4,,($9A00-$9A7F-1-32)(spr9A00)]
N $9A80 Mask 32x32 key
B $9A80,128,8 #HTML[#UDGARRAY4,56,4,4,,($9A80-$9AFF-1-32)(msk9A80)]
N $9B00 Sprite 32x32 food
B $9B00,128,8 #HTML[#UDGARRAY4,7,4,4,,($9B00-$9B7F-1-32)(spr9B00)]
N $9B80 Mask 32x32 food
B $9B80,128,8 #HTML[#UDGARRAY4,56,4,4,,($9B80-$9BFF-1-32)(msk9B80)]
N $9C00 Sprite 32x32 hostage
B $9C00,128,8 #HTML[#UDGARRAY4,7,4,4,,($9C00-$9C7F-1-32)(spr9C00)]
N $9C80 Mask 32x32 hostage
B $9C80,128,8 #HTML[#UDGARRAY4,56,4,4,,($9C80-$9CFF-1-32)(msk9C80)]
b $9D00 Collectible tile-ID tables (keys/food/bombs/ammo/hostages/uniform)
N $9D00 Flat byte arrays of raw room-tile indices ($8202-space, 0-127), one byte per collectible instance, not sorted. No count/header stored in the data - the scanning code (#R$912C/#R$926E/#R$92A0/#R$9300/#R$9328 for the first 4, #R$A2F6/#R$A328/#R$7B1E for ammo/uniform) has the entry count hardcoded. 2-byte gaps between some tables (e.g. $9D1E-$9D1F, $9D22-$9D23) are unaccounted for - not yet part of any known table.
B $9D00,15,15 Keys (15 tiles)
B $9D0F,6,6 Food (6 tiles) - refills energy, see #R$9328/#R$9456
B $9D18,6,6 Bombs (6 tiles)
B $9D20,2,2 Ammo (2 tiles) - see #R$A2F6/#R$A328/#R$A798
B $9D24,6,6 Hostages (6 tiles)
B $9D2B,2,2 Uniform/disguise (2 tiles) - see #R$A2F6/#R$7B1E
t $9D2E
b $9D32
t $9D38
b $9D3B
t $9D3D
b $9D41
t $9D43
b $9D46
t $9D47
b $9D4B
t $9D4C
b $9D50
t $9D51
b $9D55
t $9D56
b $9D5A
t $9D60
b $9D7B
t $9D86
b $9D89
t $9D8B
b $9D8F
t $9D91
b $9D94
t $9D95
b $9D99
t $9D9A
b $9D9E
t $9D9F
b $9DA3
t $9DA4
b $9DA8
t $9DAE
b $9DB2
t $9DB8
b $9DBB
t $9DBD
b $9DC1
t $9DC3
b $9DC6
t $9DC7
b $9DCB
t $9DCC
b $9DD0
t $9DD1
b $9DD5
t $9DD6
b $9DDA
t $9DE0
b $9DFB
b $9E00 Text for running line of symbols
B $9E00,8,8 ' MISSION '
B $9E09,12,12 'BRIEFING....'
B $9E15,3,3 ' 'x3
B $9E18,11,11 'TERRORISTS '
B $9E23,12,12 'LED BY CRAX '
B $9E2F,12,12 'BLOODFINGER '
B $9E3B,5,5 'HAVE '
B $9E40,10,10 'KIDNAPPED '
B $9E4A,10,10 'SIX WORLD '
B $9E54,11,11 'LEADERS....'
B $9E5F,4,4 ' 'x4
B $9E63,8,8 'YOU ARE '
B $9E6B,11,11 'THEIR ONLY '
B $9E76,8,8 'HOPE....'
B $9E7E,4,4 ' 'x4
B $9E82,11,11 'INFILTRATE '
B $9E8D,13,13 'THE RANKS OF '
B $9E9A,13,13 'BLOODFINGERS '
B $9EA7,8,8 'ARMY....'
B $9EAF,4,4 ' 'x4
B $9EB3,9,9 'LIBERATE '
B $9EBC,4,4 'THE '
B $9EC0,9,9 'HOSTAGES,'
B $9EC9,6,6 'PRIME '
B $9ECF,4,4 'THE '
B $9ED3,11,11 'EXPLOSIVES '
B $9EDE,4,4 'AND '
B $9EE2,5,5 'MAKE '
B $9EE7,5,5 'YOUR '
B $9EEC,10,10 'ESCAPE....'
B $9EF6,10,10 ' 'x10
b $9F00
b $A000 "JOE BLADE" sign
b $A200
B $A228,18,10 Energy gauge
c $A23C Energy gauge initial fill
@ $A23C label=EnergyFill
N $A23C Refills the 18-byte gauge array $A228-$A239 to full ($04 each), redraws its attribute/border strips, then draws the gauge via #R$FFB5. Used both at game-start init and by the food pickup (#R$9456).
C $A23C,5 HL = $A228 (energy gauge); B = 18
C $A246,5 Fill gauge attribute strip $5AA1
C $A26F,3 Draw a string of 8x8 glyphs
s $A28B
c $A28C Descending-pitch beeper sweep (2nd stage)
N $A28C Border/speaker OUT ($FE) sweep, shorter duration (E=5) than #R$A2BE - second stage of the gunshot sound played by #R$FFF0.
C $A28C,6 HL = $3200, E = 5 (short sweep)
C $A292,7 Toggle border on, delay
C $A299,8 Toggle border off, delay
C $A2A1,16 HL -= 16 (pitch step)
C $A2B1,4 L reached 0? adjust E
C $A2B7,6 H reached $28? loop or return
s $A2BD
c $A2BE Descending-pitch beeper sweep (1st stage), falls into #R$A28C
N $A2BE First stage of the gunshot sound: OUT ($FE) sweep from $3200 down to $2Exx, then falls into #R$A28C for a second, shorter sweep.
C $A2BE,6 HL = $3200, E = $1E (long sweep)
C $A2C4,7 Toggle border on, delay
C $A2CB,8 Toggle border off, delay
C $A2D3,16 HL -= 16 (pitch step)
C $A2E3,4 L reached 0? adjust E
C $A2E9,8 H reached $2E? loop, else continue into #R$A28C
b $A2F1
c $A2F6 Detect ammo or uniform tile under Joe, draw its icon
@ $A2F6 label=DetectAmmoUniform
N $A2F6 Same pattern as #R$912C but for two more collectibles: ammo (table $9D20, sprite/mask $A500/$A580) and uniform (table $9D2B, sprite/mask $A400/$A480). Pickup is handled separately by #R$A328 (ammo) and #R$7B1E (uniform).
C $A2FE,3 get current room-tile index = room + 8*subtile
C $A307,3 => Draw a collectible-item sprite, left or right variant
C $A315,3 get current room-tile index = room + 8*subtile
C $A31E,3 => Draw a collectible-item sprite, left or right variant
c $A328 Ammo pickup: check $9D20 tile at screen edge
@ $A328 label=CheckAmmo
N $A328 Same edge-triggered pattern as #R$926E, for the ammo tile table $9D20. On match: marks the tile visited, rebuilds the background, shows a message (#R$A370, undeciphered) and a black-box popup, adds 10 to the ammo count $8225, then continues at #R$9296.
C $A328,5 HL = $9D20 (ammo tile table); B = 2
C $A32D,6 Compare current tile ($8202) against table entry
C $A333,5 $820C bits4-5: pick which edge to check
C $A33A,3 get Joe X
C $A343,3 get Joe X
@ $A350 label=PickupAmmo
N $A350 Pickup the ammo
C $A350,2 Mark tile visited ($FF)
C $A352,3 Build room background into shadow buffer $B800
C $A355,3 Draw black box on the screen
C $A35F,3 Draw string IX
C $A362,3 Pickup/beep sound effect
C $A365,5 $8225 += 10 (ammo)
C $A36D,3 => Delay
b $A370
B $A370,16 "SOME AMMUNITION" (ammo pickup message)
c $A3AA Fill screen attributes with room attribute
c $A3BA Per-frame collectible items scan
C $A3BA,3 Ammo pickup
C $A3BD,3 Food pickup
C $A3C0,3 Bomb pickup
C $A3C3,3 Key pickup
C $A3C6,3 Hostage pickup
b $A3CA
c $A3CB Entry-point trampoline; real routine at $8FB4
C $A3CB,3 => Set interrupt-vector page register I=$8A
b $A3CE
b $A400 Sprites and masks for objects
N $A400 Sprite 32x32 uniform
B $A400,128,8 #HTML[#UDGARRAY4,7,4,4,,($A400-$A47F-1-32)(sprA400)]
N $A480 Mask 32x32 uniform
B $A480,128,8 #HTML[#UDGARRAY4,7,4,4,,($A480-$A4FF-1-32)(mskA480)]
N $A500 Sprite 32x32 ammo
B $A500,128,8 #HTML[#UDGARRAY4,7,4,4,,($A500-$A57F-1-32)(sprA500)]
N $A580 Mask 32x32 ammo
B $A580,128,8 #HTML[#UDGARRAY4,7,4,4,,($A580-$A5FF-1-32)(mskA580)]
b $A600 Font
@ $A600 label=Font
N $A600 #HTML[#UDGARRAY16($A600-$A67F-8)(font0.png)]
B $A600,8,8 'A' = $00
B $A608,8,8 'B' = $01
B $A610,8,8 'C' = $02
B $A618,8,8 'D' = $03
B $A620,8,8 'E' = $04
B $A628,8,8 'F' = $05
B $A630,8,8 'G' = $06
B $A638,8,8 'H' = $07
B $A640,8,8 'I' = $08
B $A648,8,8 'J' = $09
B $A650,8,8 'K' = $0A
B $A658,8,8 'L' = $0B
B $A670,8,8 'O' = $0E
B $A678,8,8 'P' = $0F
N $A680 #HTML[#UDGARRAY16($A680-$A6FF-8)(font1.png)]
B $A680,8,8 'Q' = $10
B $A688,8,8 'R' = $11
B $A690,8,8 'S' = $12
B $A698,8,8 'T' = $13
B $A6A0,8,8 'U' = $14
B $A6A8,8,8 'V' = $15
B $A6B0,8,8 'W' = $16
B $A6B8,8,8 'X' = $17
B $A6C0,8,8 'Y' = $18
B $A6C8,8,8 'Z' = $19
B $A6D0,8,8 space
B $A6D8,8,8 apostrophe
B $A6E0,8,8 '-'
B $A6E8,8,8 '.'
B $A6F0,8,8 ','
B $A6F8,8,8 space
N $A700 #HTML[#UDGARRAY10($A700-$A74F-8)(font2.png)]
B $A700,8,8 '0' = $20
B $A748,8,8 '9'
c $A750 Jump sound effect, gated on jump counter $820D
N $A750 While Joe is jumping ($820D <> 0), looks up a tone period from the table at $8000+ (indexed by $820D) and toggles the border 3 times at that pitch.
C $A750,5 Check jump counter $820D; return if not jumping
C $A755,9 Look up tone period from table at $8000
b $A775
c $A77C Fast-forward the rolling-digit counter (score tally animation)
N $A77C Sets the pending-tick countdown $820F to $FA (250) and runs #R$850E 250 times in a tight loop, instead of once per frame - forces the counter to roll all the way up immediately. Called 40 times in a row by #R$FEB4's win screen, giving a rapid score-tally-up effect.
C $A77C,5 $820F = $FA (250 ticks)
C $A786,3 Loop until A (tick count) reaches 0
C $A782,3 Rolling-digit counter increment
c $A78A Delay
@ $A78A label=Delay
s $A797
c $A798 Shoot: fire button consumes one round of ammo ($8225)
@ $A798 label=Shoot
N $A798 Checked from #R$8F5A (called from #R$8E64). If fire is pressed ($820A bit4) and $8225 (ammo count) is non-zero, consumes one round, calls #R$FFF0 and #R$7869 (soldier hit/reaction logic), then sets $8226 based on Joe's X relative to a $9700-table entry for the current tile (bullet range/collision against the current room?). Out of ammo -> #R$A7DC (draw an "out of ammo" message, #R$A7EC).
C $A798,5 Check fire button ($820A bit4)
C $A79E,6 $8225 (ammo count): none left -> #R$A7DC
C $A7A4,4 Consume one round
C $A7A8,3 Play gunshot sound effect
C $A7AB,3 Shot hit check
C $A7B0,3 get current room-tile index = room + 8*subtile
C $A7B9,5 Set $8226=1
C $A7BF,3 get Joe's facing direction
C $A7C5,3 get Joe X
C $A7CC,3 set kill-sparkle animation counter
C $A7D0,3 get Joe X
C $A7D7,3 set kill-sparkle animation counter
s $A7DB
c $A7DC Out of ammo
@ $A7DC label=OutOfAmmo
C $A7DC,3 Draw black box on the screen
C $A7DF,4 "YOUR GUN'S EMPTY"
C $A7E6,3 Draw string IX
C $A7E9,3 => Delay
b $A7EC "YOUR GUN'S EMPTY" (out-of-ammo message)
b $A800 Sprites and masks
N $A800 Sprite 32x32 soldier goes left
B $A800,128,8 #HTML[#UDGARRAY4,7,4,4,,($A800-$A87F-1-32)(sprA800)]
N $A880 Sprite 32x32 soldier goes left
B $A880,128,8 #HTML[#UDGARRAY4,7,4,4,,($A880-$A8FF-1-32)(sprA880)]
N $A900 Sprite 32x32 soldier goes left
B $A900,128,8 #HTML[#UDGARRAY4,7,4,4,,($A900-$A97F-1-32)(sprA900)]
N $A980 Sprite 32x32 soldier goes left
B $A980,128,8 #HTML[#UDGARRAY4,7,4,4,,($A980-$A9FF-1-32)(sprA980)]
N $AA00 Sprite 32x32 soldier goes right
B $AA00,128,8 #HTML[#UDGARRAY4,7,4,4,,($AA00-$AA7F-1-32)(sprAA00)]
N $AA80 Sprite 32x32 soldier goes right
B $AA80,128,8 #HTML[#UDGARRAY4,7,4,4,,($AA80-$AAFF-1-32)(sprAA80)]
N $AB00 Sprite 32x32 soldier goes right
B $AB00,128,8 #HTML[#UDGARRAY4,7,4,4,,($AB00-$AB7F-1-32)(sprAB00)]
N $AB80 Sprite 32x32 soldier goes right
B $AB80,128,8 #HTML[#UDGARRAY4,7,4,4,,($AB80-$ABFF-1-32)(sprAB80)]
N $AC00 Mask 32x32 soldier goes left
B $AC00,128,8 #HTML[#UDGARRAY4,7,4,4,,($AC00-$AC7F-1-32)(mskAC00)]
N $AC80 Mask 32x32 soldier goes left
B $AC80,128,8 #HTML[#UDGARRAY4,7,4,4,,($AC80-$ACFF-1-32)(mskAC80)]
N $AD00 Mask 32x32 soldier goes left
B $AD00,128,8 #HTML[#UDGARRAY4,7,4,4,,($AD00-$AD7F-1-32)(mskAD00)]
N $AD80 Mask 32x32 soldier goes left
B $AD80,128,8 #HTML[#UDGARRAY4,7,4,4,,($AD80-$ADFF-1-32)(mskAD80)]
N $AE00 Mask 32x32 32x32 soldier goes right
B $AE00,128,8 #HTML[#UDGARRAY4,7,4,4,,($AE00-$AE7F-1-32)(mskAE00)]
N $AE80 Mask 32x32 32x32 soldier goes right
B $AE80,128,8 #HTML[#UDGARRAY4,7,4,4,,($AE80-$AEFF-1-32)(mskAE80)]
N $AF00 Mask 32x32 32x32 soldier goes right
B $AF00,128,8 #HTML[#UDGARRAY4,7,4,4,,($AF00-$AF7F-1-32)(mskAF00)]
N $AF80 Mask 32x32 32x32 soldier goes right
B $AF80,128,8 #HTML[#UDGARRAY4,7,4,4,,($AF80-$AFFF-1-32)(mskAF80)]
N $B000 Sprite 32x32 Inmate with knife goes left
B $B000,128,8 #HTML[#UDGARRAY4,7,4,4,,($B000-$B07F-1-32)(sprB000)]
N $B080 Sprite 32x32 Inmate with knife goes left
B $B080,128,8 #HTML[#UDGARRAY4,7,4,4,,($B080-$B0FF-1-32)(sprB080)]
N $B100 Sprite 32x32 Inmate with knife goes left
B $B100,128,8 #HTML[#UDGARRAY4,7,4,4,,($B100-$B17F-1-32)(sprB100)]
N $B180 Sprite 32x32 Inmate with knife goes left
B $B180,128,8 #HTML[#UDGARRAY4,7,4,4,,($B180-$B1FF-1-32)(sprB180)]
N $B200 Sprite 32x32 Inmate with knife goes right
B $B200,128,8 #HTML[#UDGARRAY4,7,4,4,,($B200-$B27F-1-32)(sprB200)]
N $B280 Sprite 32x32 Inmate with knife goes right
B $B280,128,8 #HTML[#UDGARRAY4,7,4,4,,($B280-$B2FF-1-32)(sprB280)]
N $B300 Sprite 32x32 Inmate with knife goes right
B $B300,128,8 #HTML[#UDGARRAY4,7,4,4,,($B300-$B37F-1-32)(sprB300)]
N $B380 Sprite 32x32 Inmate with knife goes right
B $B380,128,8 #HTML[#UDGARRAY4,7,4,4,,($B380-$B3FF-1-32)(sprB380)]
N $B400 Mask 32x32 Inmate with knife goes left
B $B400,128,8 #HTML[#UDGARRAY4,7,4,4,,($B400-$B47F-1-32)(mskB400)]
N $B480 Mask 32x32 Inmate with knife goes left
B $B480,128,8 #HTML[#UDGARRAY4,7,4,4,,($B480-$B4FF-1-32)(mskB480)]
N $B500 Mask 32x32 Inmate with knife goes left
B $B500,128,8 #HTML[#UDGARRAY4,7,4,4,,($B500-$B57F-1-32)(mskB500)]
N $B580 Mask 32x32 Inmate with knife goes left
B $B580,128,8 #HTML[#UDGARRAY4,7,4,4,,($B580-$B5FF-1-32)(mskB580)]
N $B600 Mask 32x32 Inmate with knife goes right
B $B600,128,8 #HTML[#UDGARRAY4,7,4,4,,($B600-$B67F-1-32)(mskB600)]
N $B680 Mask 32x32 Inmate with knife goes right
B $B680,128,8 #HTML[#UDGARRAY4,7,4,4,,($B680-$B6FF-1-32)(mskB680)]
N $B700 Mask 32x32 Inmate with knife goes right
B $B700,128,8 #HTML[#UDGARRAY4,7,4,4,,($B700-$B77F-1-32)(mskB700)]
N $B780 Mask 32x32 Inmate with knife goes right
B $B780,128,8 #HTML[#UDGARRAY4,7,4,4,,($B780-$B7FF-1-32)(mskB780)]
b $B800 Shadow screen, 64 lines
B $B800,32,32*64
b $C000
B $C7B0,16,8
b $C800 Inmate sprites and masks
N $C800 Inmate sprite 1
B $C800,128,8 #HTML[#UDGARRAY4,7,4,4,,($C800-$C87F-1-32)(sprC800)]
N $C880 Inmate sprite 2
B $C880,128,8 #HTML[#UDGARRAY4,7,4,4,,($C880-$C8FF-1-32)(sprC880)]
N $C900 Inmate sprite 3
B $C900,128,8 #HTML[#UDGARRAY4,7,4,4,,($C900-$C97F-1-32)(sprC900)]
N $C980 Inmate sprite 4
B $C980,128,8 #HTML[#UDGARRAY4,7,4,4,,($C980-$C9FF-1-32)(sprC980)]
N $CA00 Inmate sprite 5
B $CA00,128,8 #HTML[#UDGARRAY4,7,4,4,,($CA00-$CA7F-1-32)(sprCA00)]
N $CA80 Inmate sprite 6
B $CA80,128,8 #HTML[#UDGARRAY4,7,4,4,,($CA80-$CAFF-1-32)(sprCA80)]
N $CB00 Inmate sprite 7
B $CB00,128,8 #HTML[#UDGARRAY4,7,4,4,,($CB00-$CB7F-1-32)(sprCB00)]
N $CB80 Inmate sprite 8
B $CB80,128,8 #HTML[#UDGARRAY4,7,4,4,,($CB80-$CBFF-1-32)(sprCB80)]
N $CC00 Inmate mask 1
B $CC00,128,8 #HTML[#UDGARRAY4,7,4,4,,($CC00-$CC7F-1-32)(mskCC00)]
N $CC80 Inmate mask 2
B $CC80,128,8 #HTML[#UDGARRAY4,7,4,4,,($CC80-$CCFF-1-32)(mskCC80)]
N $CD00 Inmate mask 3
B $CD00,128,8 #HTML[#UDGARRAY4,7,4,4,,($CD00-$CD7F-1-32)(mskCD00)]
N $CD80 Inmate mask 4
B $CD80,128,8 #HTML[#UDGARRAY4,7,4,4,,($CD80-$CDFF-1-32)(mskCD80)]
N $CE00 Inmate mask 5
B $CE00,128,8 #HTML[#UDGARRAY4,7,4,4,,($CE00-$CE7F-1-32)(mskCE00)]
N $CE80 Inmate mask 6
B $CE80,128,8 #HTML[#UDGARRAY4,7,4,4,,($CE80-$CEFF-1-32)(mskCE80)]
N $CF00 Inmate mask 7
B $CF00,128,8 #HTML[#UDGARRAY4,7,4,4,,($CF00-$CF7F-1-32)(mskCF00)]
N $CF80 Inmate mask 8
B $CF80,128,8 #HTML[#UDGARRAY4,7,4,4,,($CF80-$CFFF-1-32)(mskCF80)]
b $D000 Joe sprites and masks
N $D000 Joe sprite 1
B $D000,128,8 #HTML[#UDGARRAY4,7,4,4,,($D000-$D07F-1-32)(sprD000)]
N $D080 Joe sprite 2
B $D080,128,8 #HTML[#UDGARRAY4,7,4,4,,($D080-$D0FF-1-32)(sprD080)]
N $D100 Joe sprite 3
B $D100,128,8 #HTML[#UDGARRAY4,7,4,4,,($D100-$D17F-1-32)(sprD100)]
N $D180 Joe sprite 4
B $D180,128,8 #HTML[#UDGARRAY4,7,4,4,,($D180-$D1FF-1-32)(sprD180)]
N $D200 Joe sprite 5
B $D200,128,8 #HTML[#UDGARRAY4,7,4,4,,($D200-$D27F-1-32)(sprD200)]
N $D280 Joe sprite 6
B $D280,128,8 #HTML[#UDGARRAY4,7,4,4,,($D280-$D2FF-1-32)(sprD280)]
N $D300 Joe sprite 7
B $D300,128,8 #HTML[#UDGARRAY4,7,4,4,,($D300-$D37F-1-32)(sprD300)]
N $D380 Joe sprite 8
B $D380,128,8 #HTML[#UDGARRAY4,7,4,4,,($D380-$D3FF-1-32)(sprD380)]
N $D400 Joe mask 1
B $D400,128,8 #HTML[#UDGARRAY4,7,4,4,,($D400-$D47F-1-32)(mskD400)]
N $D480 Joe mask 2
B $D480,128,8 #HTML[#UDGARRAY4,7,4,4,,($D480-$D4FF-1-32)(mskD480)]
N $D500 Joe mask 3
B $D500,128,8 #HTML[#UDGARRAY4,7,4,4,,($D500-$D57F-1-32)(mskD500)]
N $D580 Joe mask 4
B $D580,128,8 #HTML[#UDGARRAY4,7,4,4,,($D580-$D5FF-1-32)(mskD580)]
N $D600 Joe mask 5
B $D600,128,8 #HTML[#UDGARRAY4,7,4,4,,($D600-$D67F-1-32)(mskD600)]
N $D680 Joe mask 6
B $D680,128,8 #HTML[#UDGARRAY4,7,4,4,,($D680-$D6FF-1-32)(mskD680)]
N $D700 Joe mask 7
B $D700,128,8 #HTML[#UDGARRAY4,7,4,4,,($D700-$D77F-1-32)(mskD700)]
N $D780 Joe mask 8
B $D780,128,8 #HTML[#UDGARRAY4,7,4,4,,($D780-$D7FF-1-32)(mskD780)]
N $D800 Joe sprite 9
B $D800,128,8 #HTML[#UDGARRAY4,7,4,4,,($D800-$D87F-1-32)(sprD800)]
N $D880 Joe sprite 10
B $D880,128,8 #HTML[#UDGARRAY4,7,4,4,,($D880-$D8FF-1-32)(sprD880)]
N $D900 Joe sprite 11
B $D900,128,8 #HTML[#UDGARRAY4,7,4,4,,($D900-$D97F-1-32)(sprD900)]
N $D980 Joe sprite 12
B $D980,128,8 #HTML[#UDGARRAY4,7,4,4,,($D980-$D9FF-1-32)(sprD980)]
N $DA00 Joe sprite 13
B $DA00,128,8 #HTML[#UDGARRAY4,7,4,4,,($DA00-$DA7F-1-32)(sprDA00)]
N $DA80 Joe sprite 14
B $DA80,128,8 #HTML[#UDGARRAY4,7,4,4,,($DA80-$DAFF-1-32)(sprDA80)]
N $DB00 Joe sprite 15
B $DB00,128,8 #HTML[#UDGARRAY4,7,4,4,,($DB00-$DB7F-1-32)(sprDB00)]
N $DB80 Joe sprite 16
B $DB80,128,8 #HTML[#UDGARRAY4,7,4,4,,($DB80-$DBFF-1-32)(sprDB80)]
N $DC00 Joe mask 9
B $DC00,128,8 #HTML[#UDGARRAY4,7,4,4,,($DC00-$DC7F-1-32)(mskDC00)]
N $DC80 Joe mask 10
B $DC80,128,8 #HTML[#UDGARRAY4,7,4,4,,($DC80-$DCFF-1-32)(mskDC80)]
N $DD00 Joe mask 11
B $DD00,128,8 #HTML[#UDGARRAY4,7,4,4,,($DD00-$DD7F-1-32)(mskDD00)]
N $DD80 Joe mask 12
B $DD80,128,8 #HTML[#UDGARRAY4,7,4,4,,($DD80-$DDFF-1-32)(mskDD80)]
N $DE00 Joe mask 13
B $DE00,128,8 #HTML[#UDGARRAY4,7,4,4,,($DE00-$DE7F-1-32)(mskDE00)]
N $DE80 Joe mask 14
B $DE80,128,8 #HTML[#UDGARRAY4,7,4,4,,($DE80-$DEFF-1-32)(mskDE80)]
N $DF00 Joe mask 15
B $DF00,128,8 #HTML[#UDGARRAY4,7,4,4,,($DF00-$DF7F-1-32)(mskDF00)]
N $DF80 Joe mask 16
B $DF80,128,8 #HTML[#UDGARRAY4,7,4,4,,($DF80-$DFFF-1-32)(mskDF80)]
b $E000 Background sprites
N $E000 Back 32x32 wall
B $E000,128,8 #HTML[#UDGARRAY4,7,4,4,,($E000-$E07F-1-32)(bckE000)]
N $E080 Back 32x32 wall and floor
B $E080,128,8 #HTML[#UDGARRAY4,7,4,4,,($E080-$E0FF-1-32)(bckE080)]
N $E100 Back 32x32 cabinet lower part
B $E100,128,8 #HTML[#UDGARRAY4,7,4,4,,($E100-$E17F-1-32)(bckE100)]
N $E180 Back 32x32 cabinet upper part
B $E180,128,8 #HTML[#UDGARRAY4,7,4,4,,($E180-$E1FF-1-32)(bckE180)]
N $E200 Back 32x32 wall left corner
B $E200,128,8 #HTML[#UDGARRAY4,7,4,4,,($E200-$E27F-1-32)(bckE200)]
N $E280 Back 32x32 window with bars
B $E280,128,8 #HTML[#UDGARRAY4,7,4,4,,($E280-$E2FF-1-32)(bckE280)]
N $E300 Back 32x32 window with broken bars
B $E300,128,8 #HTML[#UDGARRAY4,7,4,4,,($E300-$E37F-1-32)(bckE300)]
N $E380 Back 32x32 wall and boxes
B $E380,128,8 #HTML[#UDGARRAY4,7,4,4,,($E380-$E3FF-1-32)(bckE380)]
N $E400 Back 32x32 wall and boxes
B $E400,128,8 #HTML[#UDGARRAY4,7,4,4,,($E400-$E47F-1-32)(bckE400)]
N $E480 Back 32x32 door upper part
B $E480,128,8 #HTML[#UDGARRAY4,7,4,4,,($E480-$E4FF-1-32)(bckE480)]
N $E500 Back 32x32 door lower part
B $E500,128,8 #HTML[#UDGARRAY4,7,4,4,,($E500-$E57F-1-32)(bckE500)]
N $E580 Back 32x32 toilet upper part
B $E580,128,8 #HTML[#UDGARRAY4,7,4,4,,($E580-$E5FF-1-32)(bckE580)]
N $E600 Back 32x32 toilet lower part
B $E600,128,8 #HTML[#UDGARRAY4,7,4,4,,($E600-$E67F-1-32)(bckE600)]
N $E680 Back 32x32 wall
B $E680,128,8 #HTML[#UDGARRAY4,7,4,4,,($E680-$E6FF-1-32)(bckE680)]
N $E700 Back 32x32 wall and floor
B $E700,128,8 #HTML[#UDGARRAY4,7,4,4,,($E700-$E77F-1-32)(bckE700)]
N $E780 Back 32x32 sink
B $E780,128,8 #HTML[#UDGARRAY4,7,4,4,,($E780-$E7FF-1-32)(bckE780)]
N $E800 Back 32x32 mirror over sink
B $E800,128,8 #HTML[#UDGARRAY4,7,4,4,,($E800-$E87F-1-32)(bckE800)]
N $E880 Back 32x32 wall and window
B $E880,128,8 #HTML[#UDGARRAY4,7,4,4,,($E880-$E8FF-1-32)(bckE880)]
N $E900 Back 32x32 wall and table
B $E900,128,8 #HTML[#UDGARRAY4,7,4,4,,($E900-$E97F-1-32)(bckE900)]
N $E980 Back 32x32 wall and chair
B $E980,128,8 #HTML[#UDGARRAY4,7,4,4,,($E980-$E9FF-1-32)(bckE980)]
N $EA00 Back 32x32 wall and picture
B $EA00,128,8 #HTML[#UDGARRAY4,7,4,4,,($EA00-$EA7F-1-32)(bckEA00)]
N $EA80 Back 32x32 window with bars
B $EA80,128,8 #HTML[#UDGARRAY4,7,4,4,,($EA80-$EAFF-1-32)(bckEA80)]
N $EB00 Back 32x32 brick wall
B $EB00,128,8 #HTML[#UDGARRAY4,7,4,4,,($EB00-$EB7F-1-32)(bckEB00)]
N $EB80 Back 32x32 wall with hole
B $EB80,128,8 #HTML[#UDGARRAY4,7,4,4,,($EB80-$EBFF-1-32)(bckEB80)]
N $EC00 Back 32x32 garden fence
B $EC00,128,8 #HTML[#UDGARRAY4,7,4,4,,($EC00-$EC7F-1-32)(bckEC00)]
N $EC80 Back 32x32 cell door upper part
B $EC80,128,8 #HTML[#UDGARRAY4,7,4,4,,($EC80-$ECFF-1-32)(bckEC80)]
N $ED00 Back 32x32 cell door lower part
B $ED00,128,8 #HTML[#UDGARRAY4,7,4,4,,($ED00-$ED7F-1-32)(bckED00)]
N $ED80 Back 32x32 wall corner
B $ED80,128,8 #HTML[#UDGARRAY4,7,4,4,,($ED80-$EDFF-1-32)(bckED80)]
N $EE00 Back 32x32 wall corner
B $EE00,128,8 #HTML[#UDGARRAY4,7,4,4,,($EE00-$EE7F-1-32)(bckEE00)]
N $EE80 Back 32x32 wall corner
B $EE80,128,8 #HTML[#UDGARRAY4,7,4,4,,($EE80-$EEFF-1-32)(bckEE80)]
N $EF00 Back 32x32 wall right corner and floor
B $EF00,128,8 #HTML[#UDGARRAY4,7,4,4,,($EF00-$EF7F-1-32)(bckEF00)]
N $EF80 Back 32x32 wall left cornet and floor
B $EF80,128,8 #HTML[#UDGARRAY4,7,4,4,,($EF80-$EFFF-1-32)(bckEF80)]
N $F000 Back 32x32 tree
B $F000,128,8 #HTML[#UDGARRAY4,7,4,4,,($F000-$F07F-1-32)(bckF000)]
N $F080 Back 32x32 tree
B $F080,128,8 #HTML[#UDGARRAY4,7,4,4,,($F080-$F0FF-1-32)(bckF080)]
N $F100 Back 32x32 inmate behind bars upper part
B $F100,128,8 #HTML[#UDGARRAY4,7,4,4,,($F100-$F17F-1-32)(bckF100)]
N $F180 Back 32x32 inmate behind bars lower part
B $F180,128,8 #HTML[#UDGARRAY4,7,4,4,,($F180-$F1FF-1-32)(bckF180)]
N $F200 Back 32x32 wall right corner
B $F200,128,8 #HTML[#UDGARRAY4,7,4,4,,($F200-$F27F-1-32)(bckF200)]
N $F280 Back 32x32 wall right corner and floor
B $F280,128,8 #HTML[#UDGARRAY4,7,4,4,,($F280-$F2FF-1-32)(bckF280)]
N $F300 Back 32x32 wall left corner
B $F300,128,8 #HTML[#UDGARRAY4,7,4,4,,($F300-$F37F-1-32)(bckF300)]
N $F380 Back 32x32 wall left corner and floor
B $F380,128,8 #HTML[#UDGARRAY4,7,4,4,,($F380-$F3FF-1-32)(bckF380)]
N $F400 Back 32x32 wall upper part
B $F400,128,8 #HTML[#UDGARRAY4,7,4,4,,($F400-$F47F-1-32)(bckF400)]
N $F480 Back 32x32 wall lower part
B $F480,128,8 #HTML[#UDGARRAY4,7,4,4,,($F480-$F4FF-1-32)(bckF480)]
N $F500 Back 32x32 wall upper part
B $F500,128,8 #HTML[#UDGARRAY4,7,4,4,,($F500-$F57F-1-32)(bckF500)]
N $F580 Back 32x32 wall lower part
B $F580,128,8 #HTML[#UDGARRAY4,7,4,4,,($F580-$F5FF-1-32)(bckF580)]
N $F600 Back 32x32 empty
B $F600,128,8 #HTML[#UDGARRAY4,7,4,4,,($F600-$F67F-1-32)(bckF600)]
N $F680 Back 32x32 tree upper part
B $F680,128,8 #HTML[#UDGARRAY4,7,4,4,,($F680-$F6FF-1-32)(bckF680)]
N $F700 Back 32x32 tree lower part
B $F700,128,8 #HTML[#UDGARRAY4,7,4,4,,($F700-$F77F-1-32)(bckF700)]
N $F780 Back 32x32
B $F780,128,8 #HTML[#UDGARRAY4,7,4,4,,($F780-$F7FF-1-32)(bckF780)]
N $F800 Back 32x32 garden fence lower part
B $F800,128,8 #HTML[#UDGARRAY4,7,4,4,,($F800-$F87F-1-32)(bckF800)]
N $F880 Back 32x32 tree
B $F880,128,8 #HTML[#UDGARRAY4,7,4,4,,($F880-$F8FF-1-32)(bckF880)]
N $F900 Back 32x32 trash bin
B $F900,128,8 #HTML[#UDGARRAY4,7,4,4,,($F900-$F97F-1-32)(bckF900)]
N $F980 Back 32x32 skull
B $F980,128,8 #HTML[#UDGARRAY4,7,4,4,,($F980-$F9FF-1-32)(bckF980)]
N $FA00 Back 32x32 box
B $FA00,128,8 #HTML[#UDGARRAY4,7,4,4,,($FA00-$FA7F-1-32)(bckFA00)]
N $FA80 Back 32x32 EXIT sign over door
B $FA80,128,8 #HTML[#UDGARRAY4,7,4,4,,($FA80-$FAFF-1-32)(bckFA80)]
N $FB00 Back 32x32 tree upper part
B $FB00,128,8 #HTML[#UDGARRAY4,7,4,4,,($FB00-$FB7F-1-32)(bckFB00)]
N $FB80 Back 32x32 tree lower part
B $FB80,128,8 #HTML[#UDGARRAY4,7,4,4,,($FB80-$FBFF-1-32)(bckFB80)]
N $FC00 Back 32x32 window with broken bars
B $FC00,128,8 #HTML[#UDGARRAY4,7,4,4,,($FC00-$FC7F-1-32)(bckFC00)]
N $FC80 Back 32x32 garden fence
B $FC80,128,8 #HTML[#UDGARRAY4,7,4,4,,($FC80-$FCFF-1-32)(bckFC80)]
N $FD00 Back 32x32 Wire
B $FD00,128,8 #HTML[#UDGARRAY4,7,4,4,,($FD00-$FD7F-1-32)(bckFD00)]
b $FD80
c $FDB0
C $FDBA,3 => Fill screen attributes with room attribute
b $FDBD
b $FE00
c $FDCE
C $FDD8,3 => Draw string IX and play sound
b $FDDB
c $FEB4 Win screen: redraw title, congratulations text, wait, return to menu
N $FEB4 Triggered by #R$FF14 on game completion. Redraws the "JOE BLADE" sign and several congratulation strings, pauses (28 iterations of #R$A77C), then falls into a HL-countdown delay before JP $8EB4 (back to the menu/hi-score flow).
C $FEB4,3 Clear screen, border to black
C $FEC1,3 Show "JOE BLADE" big sign on the screen
C $FECB,3 Draw string IX
C $FEDB,3 Draw string IX
C $FEE1,3 Draw string IX
C $FEE7,3 Draw string IX
C $FEED,3 Draw string IX
C $FEF3,3 Draw string IX
C $FEF9,3 Fast-forward the rolling-digit counter
C $FF0C,3 => Post-game hub
s $FF0F
c $FF14 Win-condition check: back at the start room, all hostages+bombs
N $FF14 Called every frame from #R$8F00. Wins the game when the current tile ($8202) is $7B (the same tile as Joe's starting room), the hostage counter $8214=6, and the bomb counter $8216=6 - i.e. rescue all hostages, defuse all bombs, and return to the start. On match, calls #R$FEB4 (win screen) and waits for all keys to release before returning to the menu ($8EB4).
C $FF14,6 Current tile = starting room ($7B)?
C $FF1A,6 Hostages ($8214) = 6?
C $FF20,6 Bombs ($8216) = 6?
C $FF27,3 Win screen
C $FF36,3 Wait until every key on the keyboard is released
C $FF3B,3 => Post-game hub
c $FF3E Kill-sparkle animation, 2nd slot (gated on $8226)
N $FF3E Byte-for-byte the same pattern as #R$789D, gated on $8226 instead of $7B10 (anchor $8217/$8227 instead of $7B11/$7B12, clears $8F94 instead of $8FA8 when done). A second, independent sparkle-effect slot - resolves $8226's purpose (set by #R$A798/#R$7869 on a hit): it's the same kill-sparkle mechanism as $7B10, letting two kills animate at once.
C $FF3E,5 Check $8226; return if inactive
C $FF4F,3 get kill-sparkle animation counter
C $FF59,3 set kill-sparkle anchor byte
C $FF62,3 get kill-sparkle anchor byte
C $FF82,9 Advance $8226; done at $1E?
C $FF8D,3 set kill-sparkle animation counter
c $FF96 Per-frame soldier update (redirect)
C $FF96,3 => Per-frame soldier update
b $FF99
c $FFA0
C $FFA6,3 get kill-sparkle animation counter
c $FFAD Clear $8226, hand off to $7D96
C $FFAD,5 Clear $8226 flag
C $FFB2,3 => Clamp room-tile pointers, hand off to game loop $8F00
c $FFB5 Draw a string of 8x8 glyphs (energy gauge segments)
N $FFB5 IX = byte string (each byte a glyph index, $FF-terminated), HL = destination. Each glyph is an 8-byte (8x8 1bpp) block at $A200+index*8. Used by #R$93A0 (energy loss) and #R$A23C (gauge fill) to draw the energy-gauge bar.
C $FFB5,9 C = glyph index; $FF terminates
C $FFBE,10 DE = $A200 + index*8 (glyph source)
c $FFD5
C $FFDB,3 => Wait for a key or timeout
b $FFDE
c $FFE8 Key-gated staircase check, if not mid-jump
N $FFE8 Skips #R$9880 while $8209<>0 (Joe mid-jump/climb).
C $FFED,3 => Key-gated staircase
c $FFF0 Play gunshot sound effect (3x)
@ $FFF0 label=SFX_shoot
N $FFF0 Called by #R$A798 when firing. Plays the descending-pitch beeper sweep #R$A2BE three times in a row.
C $FFF0,3 Descending-pitch beeper sweep (1st stage), falls into #R$A28C
C $FFF3,3 Descending-pitch beeper sweep (1st stage), falls into #R$A28C
C $FFF6,3 => Descending-pitch beeper sweep (1st stage), falls into #R$A28C
b $FFF9
