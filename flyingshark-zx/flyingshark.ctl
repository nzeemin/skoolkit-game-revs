@ $5B00 org
b $5B00
b $5EEA Level 1 timeline table
b $5F87 Level 2 timeline table
b $6042 Level 3 timeline table
b $60F1 Level 4 timeline table
b $61E2 Levels colour-scheme tables
B $61E2
B $61E5
b $61E8 Per-level configuration table (20 bytes/row)
N $61E8 Read by $A612: row = $61D4 + 20*(wave-formation-tag+1).
N $61E8 One 20-byte per-level row, confirmed field-by-field from $A612's 6-word SP-trick pop (offsets are byte offsets into the row): $00 word -> $9C57, cursor into the colour-scheme table (see $A54D, values land in $9C59/$9C5A); $02 word -> $9BA5, cursor into this level's timeline table (3 bytes/entry, see #R$C9AF); $04 word -> $9BFD, this level's scenery-script pointer (see #R$A3A0); $06 word -> combined with the current object's IX+$0A into $9C40/$9C41 (difficulty-scaled fire-rate baseline); $08 word -> low byte to $9C42/$9C43 (fire-timer reload value), high byte to $9C71; $0A word -> low byte to $5B56 and $C2E1 (SRL'd), high byte to $5B7A (screen/timing pokes, exact purpose unconfirmed); $0C-$13 (8 bytes) -> wave-formation-tag threshold table, scanned by $A4E7 (base address kept at $9BA7).
W $61E8,2,2 Address of colour-scheme table
W $61EA,2,2 Address of timeline table
W $61EC,2,2 Address of scenery-script
W $61EE,2,2 Fire-rate baseline (combined with IX+$0A)
W $61F0,4,2
B $61F4,8
W $61FC,2,2 Address of colour-scheme table
W $61FE,2,2 Address of timeline table
W $6200,2,2 Address of scenery-script
W $6202,2,2 Fire-rate baseline (combined with IX+$0A)
W $6204,4,2
B $6208,8
W $6210,2,2 Address of colour-scheme table
W $6212,2,2 Address of timeline table
W $6214,2,2 Address of scenery-script
W $6216,2,2 Fire-rate baseline (combined with IX+$0A)
W $6218,4,2
B $621C,8
W $6224,2,2 Address of colour-scheme table
W $6226,2,2 Address of timeline table
W $6228,2,2 Address of scenery-script
W $622A,2,2 Fire-rate baseline (combined with IX+$0A)
W $622C,4,2
B $6230,8
b $6238 Default high-score table (6 $FF-terminated name entries)
N $6238 Live-confirmed against title screen: entries are "EGO", "BAV", "SRT", "AEB", "AJW", "G.G." matching the 6 default high-score rows (68000/50000/40000/1000/100/10).
T $6238,8,16 Entry 0: "EGO"
T $6240,11,16 Entry 1: "BAV"
T $624B,11,16 Entry 2: "SRT"
T $6256,11,16 Entry 3: "AEB"
T $6261,11,16 Entry 4: "AJW"
T $626C,11,16 Entry 5: "G.G."
b $627A Messages
B $627A,1,1 Message $FF
B $627B,1,1 Message $00
T $627C,99,16 Message $01
T $62DF,123,16 Message $02
T $635A,37,16 Message $03
T $637F,21,16 Message $04
T $6394,57,16 Message $05
T $63CD,3 Message $06
T $63D0,3 Message $07
T $63D3,3 Message $08
T $63D6,3 Message $09
T $63D9,20,16 Message $0A
T $63ED,11 Message $0B
T $63F8,11 Message $0C
T $6403,11 Message $0D
T $640E,11 Message $0E
T $6419,17 Message $0F
T $642A,17 Message $10
T $643B,19 Message $11
T $644E,22 Message $12
T $6464,10 Message $13
T $646E,12 Message $14
c $647A
c $6498 Init menu screen: wipe, draw player boxes, labels, fill buffer
R $6498 A colour/type for the wipe transition ($9C59)
N $6498 Sets the wipe colour, runs the $C6A6 wipe effect, draws the player-panel box graphics ($6AD4, which uses $6B09), prints the "PLAYER ONE"/"PLAYER TWO" label, draws two box variants via $66DE, then fast-fills a buffer at $FA79 downward with the word $3D00 (261 words) using a PUSH-based stack trick, and finally calls $C772.
C $6498,3 set active colour/type for the wipe effect
C $649B,3 Screen wipe transition effect
C $649E,3 Draw both players' panel borders
C $64A1,2 "PLAYER ONE"/"PLAYER TWO"
C $64A3,3 Print message N from table $627A
C $64A6,2 select box variant 1
C $64A8,3 Print a player's score at its HUD position
C $64AB,4 draw box variant 2
C $64AF,8 disable interrupts, save SP, point SP at fill target $FA79
C $64B7,6 HL=fill value $3D00, BC=261 (word count)
C $64BD,7 fill loop: push HL twice per iteration (fast memory fill via stack)
C $64C4,3 run $C772
C $64C7,3 reset SP (restored by caller)
C $64CA,2 re-enable interrupts, return
c $64CC Print character to screen using ROM font (pixel-shifted blit)
R $64CC A ASCII character code to print
N $64CC Draws an ASCII character (ROM font table at $3D00+) at a pixel-precise screen position from cursor $9CC7/$9CC9, merging glyph rows into the destination via OR (HL) rather than overwriting. Live-traced: HL=$3D06 (char code 32/space, row 6) confirms ROM font table use. If the skip-print flag ($9CCB) is set instead of a real character, control transfers to $6594, a separate small dispatcher for control codes 0-8 via a jump table at $65B3.
C $64D0,1 C=char code
C $64D6,3 jump to control-code path if printing suppressed
C $64DC,3 jump to blank-glyph exit if char<$20
C $64E1,3 jump to blank-glyph exit if char=$FE
C $64E4,7 load cursor position
C $64F4,3 store advanced cursor column
C $6513,1 start of unrolled pixel-shift blit (glyph rows 0-7)
C $6549,3 advance destination to next screen third (row wrap)
C $658C,1 restore registers and return
C $6590,3 store last-printed char as new skip-print flag
C $6594,2 control-code path: codes >=9 treated as space
C $659C,3 dispatch via jump table $65B3
w $65B3 Control-code dispatch table (9 entries, codes 0-8, used by $6594)
c $65C5 Control code $00: reset $9CC9 row, skip-count 7
N $65C5 C still holds the control code value (0, since dispatch index = code). Zeroes the low byte of $9CC9 (part of the cursor position pair), sets a skip-count of 7 into A, then jumps into $65AB (the tail of the space-handling path) to store that count as the new skip-print flag ($9CCB) and return. Reads like a "reset row / pad N characters" control character; not fully confirmed against live behaviour.
C $65C5,4 zero the low byte of $9CC9 (cursor row reset)
C $65C9,2 skip-count = 7
C $65CB,3 discard pushed return address, jump into skip-flag setter
c $65CE Control code $07: set $9CCA to code value
N $65CE Simplest handler: just LD ($9CCA),C then return. $9CCA's purpose is not otherwise confirmed.
c $65D3 Control code $01: set $9CC9 bits 0-2
C $65D9,1 OR in code value (1) to low 3 bits of $9CC9
c $65DC Control code $02: set $9CC9 bits 3-5
C $65E7,1 OR in code value<<3 to bits 3-5 of $9CC9
c $65EA Control code $08: set $9CC7 bits 0-4 (via code $03), skip-count 4
C $65EA,3 Control code $03
C $65ED,2 skip-count = 4
c $65F2 Control code $03: set $9CC7 bits 0-4
N $65F2 Shared: also called by control code $08 with C=8 instead of 3.
C $65F8,1 OR C into bits 0-4 of $9CC7
c $65FB Control code $04: convert $9CC7 to screen pixel address
N $65FB Shared: also reached from control code $06 with a different C value. Converts the cursor field $9CC7 into a screen pixel address (same bit-twiddle as $64CC's blit), folding in C.
C $660E,3 store converted pixel address back into $9CC7
c $6612 Control code $05: add code value to $9CC7 low byte
C $6616,1 add code value (5) to low byte of $9CC7
c $6619 Control code $06: compute C, reuse code $04's conversion
C $6620,3 mask to 5 bits, add code value (6)
C $6624,2 reuse control code $04's conversion with this C
c $6626 Print string (control codes + ROM-font text) from HL
R $6626 HL pointer to $FF-terminated string
C $6626,2 save AF/HL
C $6628,3 check skip-print flag at $9CCB
C $662D,4 read next byte, advance HL; branch if control code (<$20)
C $6631,2 check string terminator $FF
C $6633,2 exit if string terminated
C $6635,4 check position/attribute control code $1B
C $6639,3 Print character to screen using ROM font
C $663C,2 loop for next character
C $663E,5 read control parameter byte, apply via $6648
C $6643,2 loop back
C $6645,3 restore AF/HL and return
c $6648 Print message N from table $627A
@ $6648 label=print_message
R $6648 A message number (0-based) to print
C $6648,4 save AF/HL/DE/BC
C $664C,3 point HL at string index table $627A
C $664F,4 init search count E=A+1, set terminator byte $FF
C $6653,3 search table for the (A+1)th $FF-terminated string using CPIR
C $6656,3 loop until count exhausted
C $6659,3 Print string (control codes + ROM-font text) from HL
C $665C,4 restore AF/HL/DE/BC
C $6660,1 return
s $6661
c $6663 Print packed-BCD number with leading-zero suppression
R $6663 HL pointer to 3-byte packed-BCD value
R $6663 A fill character for suppressed leading zeros ($FE = pad remainder with spaces instead)
N $6663 Copies the BCD value to scratch ($9C2B), then unpacks its 6 nibbles via RLD (one per digit), printing each through $64CC; nibbles that are still zero before the first nonzero digit print the fill character A instead of "0". If A was $FE on entry, once all 6 digits are printed it pads the unused width with spaces (count = original 6 minus digits actually printed, tracked in D).
C $6664,3 copy source BCD value to scratch $9C2B
C $666C,1 C = fill character (from entry A)
C $6677,2 unpack next BCD digit (RLD)
C $6687,1 leading zero: print fill character instead of digit
C $6688,3 Print character to screen using ROM font
C $669C,3 Print character to screen using ROM font
C $66A6,2 check for space-padding mode (A=$FE)
C $66AC,1 B = remaining width to pad
C $66AF,3 Print character to screen using ROM font
c $66B5 Add BCD score value to current player's score
R $66B5 A table index into $A094 (0=use HL directly)
R $66B5 HL score value to add, when A=0
N $66B5 Adds a 3-byte packed-BCD value to the active player's score field ($9C7B for player 1, $9C87 for player 2, selected via $9C76), then sets bit 1 of $9C27 (likely a "score changed, redraw HUD" flag). If A=0 the value is added directly from HL; otherwise A indexes a table of preset score values at $A094 (3 bytes per entry).
C $66B5,6 if A=0 use HL as score value directly; else point HL at score-value table $A094
C $66BB,7 index into table: HL += 3*A
C $66C2,9 point DE at player 1 score field; check active player
C $66CB,3 player 2: point DE at player 2 score field instead
C $66CE,2 3-byte BCD add loop count
C $66D0,8 add BCD byte with carry, store back, advance pointers, repeat for 3 bytes
C $66D8,5 set score-changed/redraw flag at $9C27
C $66DD,1 return
c $66DE Print a player's score at its HUD position
R $66DE A player number (1 or 2)
N $66DE Selects the score cursor coordinates ($9C1D/$9C1F, active vs. other player via $9C76) and the score data pointer (player 1: $9C79/fill=$FE space-pad; player 2: $9C85/fill=$20 plain space), sets the print cursor ($9CC7/$9CC9), then calls $6663 to print the BCD score.
C $66DF,3 compare entry player number to active player ($9C76)
C $66E9,4 other player: use $9C1F cursor coordinate
C $66ED,2 is this player 1?
C $66F6,2 player 1: fill character = $FE (space-pad)
C $6701,2 player 2: fill character = $20 (plain space)
C $6703,4 set print cursor column ($9CC7)
C $6707,4 set print cursor row ($9CC9)
C $670B,3 IX = score data pointer
C $6712,3 Print packed-BCD number with leading-zero suppression
c $6717 Compare 3 bytes at (DE) vs (HL); NC if all equal
R $6717 DE,HL pointers to the two 3-byte sequences
R $6717 O:Cy set if any byte differs, clear if all 3 match
c $672C Draw lives/bombs icon rows for a player
R $672C A player number (1 or 2)
R $672C IX player struct base
N $672C Draws two icon rows via $6751: lives (from IX+3, colour $46) and bombs (from IX+9, colour $42), at attribute base $59A0 (player 1) or $59BA (player 2).
C $6741,3 Draw icon row
C $674C,3 Draw icon row
c $6751 Draw icon row: up to 6 filled cells (colour C), rest blank
R $6751 A icon count x2
R $6751 C fill colour
R $6751 IY attribute row base
c $6771 Update player's HUD panel (score + lives/bombs icons)
R $6771 A player number (1 or 2)
C $6771,3 Print a player's score at its HUD position
C $6774,3 Draw lives/bombs icon rows for a player
c $6778 Paint attribute colour-wipe column (menu highlight effect)
R $6778 A row/column count (used as both position and loop count B)
R $6778 C flags (bit 7: special mode, unconfirmed)
R $6778 E screen column
N $6778 Paints a 2-row-tall column of screen attributes at (row A, col E) with bytes from a repeating $FF-terminated sequence at $9CCC, B columns wide, synced to HALT and interruptible by fire. Looks like a colour-wipe/highlight-bar effect (e.g. for menu selection); exact meaning of the high/low bits of C is unconfirmed.
C $6778,7 B=column count; compute row pixel offset from A
C $677F,5 start attribute address calc from column E
C $6784,8 combine row/column bits into attribute address
C $678C,3 add attribute-memory base, store into IX
C $678F,3 load computed attribute address into IX
C $6792,6 DE=pointer into repeating colour sequence; HL=fire-debounce flag
C $6798,1 sync to frame
C $6799,2 check special-mode flag in C
C $679B,2 skip input poll if special mode
C $679D,3 Read input
C $67A0,4 check fire pressed
C $67A4,1 return if fire pressed
C $67A5,1 sync to frame
C $67A6,4 read next colour byte, check sequence terminator $FF
C $67AA,2 skip wrap if not terminated
C $67AC,3 wrap sequence pointer to start
C $67AF,1 reload first colour byte after wrap
C $67B0,3 save loop state
C $67B3,6 paint attribute cell and the cell 4 rows below (32-byte stride)
C $67B9,2 advance to next column
C $67BB,2 repeat for B columns
C $67BD,3 restore loop state
C $67C0,3 mask special-mode flag off C
c $67C7 Redefine keys: prompt for and store each direction/fire key
N $67C7 Loops 5 times (E=$0A..$0E), printing the "FIRE"/"UP"/"DOWN"/"LEFT"/"RIGHT" labels via $6648, waiting for a keypress via $6829/$686A (keyboard scan with animated highlight), then storing the chosen key's row/mask (B,C) into the redefinable-key table at $9CE0 - the same table $68B1 reads when decoding keyboard input.
C $67D3,3 Print message N from table $627A
C $67D9,3 Print a redefined key's name
C $67DC,3 Scan keyboard for a keypress
C $67DF,3 Print a redefined key's name
C $67E2,3 Copy 16 bytes from wrapping sequence ($9C25) into screen at $5A68
c $67F1 Print a redefined key's name (character or CS/SS/SP/EN)
C $6812,2 map key-code 0-3 to message $06-$09 (CS/SS/SP/EN)
C $6814,3 Print message N from table $627A
C $6819,3 Print character to screen using ROM font
C $681E,3 Print character to screen using ROM font
c $6829 Scan keyboard for a keypress (animated wait, debounced)
R $6829 O:B,C row/mask of the key pressed
C $682C,3 Reset animated-sequence pointer
C $682F,3 Copy 16 bytes from wrapping sequence ($9C25) into screen at $5A68
C $684D,3 Copy 16 bytes from wrapping sequence ($9C25) into screen at $5A68
C $6858,3 Copy 16 bytes from wrapping sequence ($9C25) into screen at $5A68
c $6861 Reset animated-sequence pointer ($9C25 = $9CCC)
c $686A Copy 16 bytes from wrapping sequence ($9C25) into screen at $5A68
N $686A Waits 2 frames, then copies B=16 bytes from the repeating $FF-terminated sequence at $9CCC (tracked via pointer $9C25, same source used by $6778's colour-wipe effect), wrapping back to the start on the terminator, into a fixed screen destination at $5A68.
C $686A,2 Wait 2 frames
C $6874,4 DE = sequence cursor ($9C25)
C $6878,2 Copy 16 bytes
C $687C,2 On $FF terminator, wrap to sequence start
C $6881,4 Reload cursor to $9CCC
C $6885,6 Write byte to two rows ($5A68 and +$20)
C $688F,4 Save advanced cursor back to $9C25
c $6898 Wait N frames
R $6898 A number of frames to wait
C $6899,1 B = frame count
c $689F Wait up to N frames, exit early on fire
R $689F A number of frames to wait
C $68A2,3 Read input
C $68A5,5 check fire pressed
C $68AB,2 exit early if fire pressed
c $68B1 Read input (Kempston or keyboard)
@ $68B1 label=read_input
C $68B5,4 init direction accumulator C=0, loop counter B=5
N $68BC Reads Kempston joystick (port $1F) and keyboard (port $FE) into shift register at $9CE0-$9CE1.
C $68C1,4 shift key state bit into C
C $68C8,3 check Kempston-enabled flag at $9CDF
C $68CF,2 read Kempston joystick
C $68D3,2 mark Kempston active
C $68D7,4 read CAPS SHIFT+direction keys (port $FE row $EF)
C $68DF,2 read SPACE+redefine keys (port $FE row $F7)
C $68E3,4 skip redefine-toggle if not held
C $68EB,2 clear redefine-toggle debounce flag
C $68ED,4 fire button from row $EF bit 4
C $68F3,6 decode direction bits from E into B
C $6908,3 return combined direction+fire byte
C $690B,2 check fire+redefine combo held
C $690F,2 set redefine-toggle debounce flag
C $6911,13 encode redefined-key row into direction bits
C $691E,2 combine keyboard bits with accumulator
c $6943 Read fire button (Kempston/keyboard) with debounce
@ $6943 label=read_fire
R $6943 O:Cy fire button pressed
N $6943 Reads Kempston joystick fire button (port $1F, bit 4) combined with keyboard debounce (port $FE); returns pressed state in carry flag.
C $6945,6 save and set debounce flag at $9CDF
C $694B,2 read Kempston joystick fire
C $6951,2 skip if Kempston fire not pressed
C $6953,5 clear debounce flag, point to keyboard debounce mask
C $695A,2 read keyboard, compare against debounce mask
C $695D,2 skip if key not held
C $695F,4 read keyboard row $EF (SPACE bar)
C $6966,3 restore debounce flag if fire release confirmed
c $6971 Wait for input (debounced, up to 3 frames)
C $697A,3 Read input
c $6989 Check for new high score, congratulate and reset defaults if so
N $6989 Waits for input, then compares the score's initials (via IX/$9C77) against each entry of the high-score name table ($6240) using $6717. On the first mismatch it prints the "CONGRATULATIONS!" message ($05) and copies fresh default name/score data back over the table (from $6272). If every entry matches, it just returns. Exact match/mismatch semantics not fully verified against live play.
C $6989,3 Wait for input
C $699C,3 Compare 3 bytes at (DE) vs
C $69AC,2 "CONGRATULATIONS!...A GREAT SCORE...???"
C $69AE,3 Print message N from table $627A
C $69E8,3 Print character to screen using ROM font
C $69EB,3 Read input
C $69F6,3 Wait N frames
C $6A33,3 Wait for input
C $6A3D,3 Start playing music track A
C $6A46,3 Paint attribute colour-wipe column
c $6A4A Main menu key dispatcher (1P/2P select, redefine keys)
N $6A4A Guarded by re-entrancy flag $9C29 (set by $A927). Reads keyboard row $F7 (SPACE/SYM SHIFT/M/N/B) and dispatches by bit: bit 0 -> $6A6D (select player 1), bit 1 -> $6A72 (select player 2), bit 2 -> $67C7 (redefine keys menu).
C $6A53,4 read keyboard row $F7
C $6A59,3 Print "PLAYER 1"/"PLAYER 2" turn indicator
C $6A65,3 Redefine keys
c $6A6D Print "PLAYER 1"/"PLAYER 2" turn indicator
C $6A6D,5 entry: set player number to 1
C $6A72,3 entry: set player number to 2
C $6A75,3 store player number at $9C75
C $6A78,2 map player number to message $0F/$10 ("1 PLAYER"/"2 PLAYERS")
C $6A7A,3 Print message N from table $627A
C $6A83,3 Paint attribute colour-wipe column
c $6A88 Show credits screen: highlight active player, update HUD, wipe out
N $6A88 Inits state, prints "PLAYER ONE"/"PLAYER TWO" and draws the credits box ($6AD4), colours the active player's border white (C=$07, chosen via $9C76), updates both players' HUD panels via $6771, then transitions out with the $C6A6 wipe.
C $6A94,3 Build wrapped scroll-window row into $F6D1 buffer
C $6A9F,2 "PLAYER ONE"/"PLAYER TWO" (credits screen)
C $6AA1,3 Print message N from table $627A
C $6AA4,3 Draw both players' panel borders
C $6AC9,3 Update player's HUD panel
C $6ACD,3 Update player's HUD panel
C $6AD0,3 Screen wipe transition effect
c $6AD4 Draw both players' panel borders
N $6AD4 Draws a 3-cell border segment for player 1 (bitmap $6CD1 at $59A0, via $6AF4), two single corner-cap boxes ($58C4/$58DA), then a 3-cell border segment for player 2 (bitmap $6CF1 at $5A00).
C $6ADA,3 Draw a 3-cell border segment
C $6AE1,3 Draw bordered box graphic (colour + bitmap) at HL
C $6AE7,3 Draw bordered box graphic (colour + bitmap) at HL
C $6AF0,3 Draw a 3-cell border segment
c $6AF4 Draw a 3-cell border segment
R $6AF4 DE bitmap data pointer
R $6AF4 HL attribute base
C $6AF7,3 Draw bordered box graphic (colour + bitmap) at HL
C $6B03,3 Draw bordered box graphic (colour + bitmap) at HL
c $6B09 Draw bordered box graphic (colour + bitmap) at HL
R $6B09 A attribute colour
R $6B09 HL attribute-memory address (top-left of the box)
R $6B09 DE pointer to 32-byte bitmap data (4 columns x 8 rows)
N $6B09 Fills a 2x2 attribute cell block with colour A, converts that attribute address to the corresponding pixel address, then copies an 8-byte-tall bitmap column from DE into it. Repeats for 4 character columns, alternating between the top and bottom row of the block (BIT 0,C) and stepping to the next attribute row pair every 2 columns (+$22 to L). Used to draw small bordered graphics/tiles (e.g. UI boxes) at a fixed screen position.
C $6B09,3 save registers
C $6B0C,3 fill attribute pair (top row)
C $6B0F,7 move down one attribute row, fill pair (bottom row)
C $6B16,2 restore original HL, keep a copy
C $6B18,8 convert attribute row to pixel-address row; advance column
C $6B20,2 4 columns to draw
C $6B22,3 save column pointer; 8 pixel rows
C $6B25,6 copy 8 bitmap bytes from DE into this pixel column
C $6B2B,5 restore column pointer, move to previous attribute column; exit if done
C $6B30,4 continue same character row if column count odd
C $6B34,6 move to next character row pair, loop
C $6B3A,5 restore registers, advance HL past the box
C $6B3F,1 return
b $6B40
B $6B42,17,17
B $6B53,17,17
B $6B64,17,17
B $6B75,17,17
B $6B86,17,17
B $6B97,17,17
B $6BA8,17,17
b $6BB9
B $6BB9,17,17
B $6BCA,17,17
b $6D71 Levels scenery scripts
N $6D71 Level 1 scenery script
N $6D92 Level 2 scenery script
N $6DC3 Level 3 scenery script
N $6DDF Level 4 scenery script
b $7900 Tile block 2x2 table (cell -> 2x2 character block)
N $7900 Four parallel 256-entry lookup tables ($7900/$7A00/$7B00/$7C00). A background map cell is a single byte, used as the index into all four tables at once; the four bytes read out are the four character codes of a 2x2 tile block: $7900=top-left, $7A00=top-right, $7B00=bottom-left, $7C00=bottom-right. The column decoder $C941 reads one cell, writes the top pair ($7900/$7A00) into buffer row A and the bottom pair ($7B00/$7C00) into row B, so each cell renders as a 2-char-wide by 2-char-tall tile block. See docs/Level-Format.md.
N $7900 Page 0: top-left character code of each block.
N $7A00 Page 1: top-right character code of each block.
N $7B00 Page 2: bottom-left character code of each block.
N $7C00 Page 3: bottom-right character code of each block.
c $7D00 Initialize IM 2 interrupt vector table and set light ISR
N $7D00 Standard IM 2 setup: I=$FE (vector table at $FE00), fills $FE00-$FFFF with $FD so every vector reads the byte at $FDFD, which is set to $C3 (JP opcode) - making $FDFD/$FDFE act as a self-modifying "JP (isr-handler)" trampoline used by $A0C4/$A0B0 elsewhere. Points that trampoline at $A0B0 (the light/per-frame ISR) before returning.
C $7D17,3 point to per-frame handler $A0B0 (light ISR)
C $7D1A,3 set ISR handler address
c $7D1F Clear screen and draw title screen graphics
N $7D1F Clears the bitmap ($4000-$5AFE), sets border black, then draws two compressed graphic blocks (data at $CB91 and $CA09, via the decompressor at $7D5C) onto the screen at $4000/$5800 and $4019/$5819 - almost certainly the title-screen logo/artwork. The block at $7D4E-$7D5B is likely parameter data, currently mistyped as code in the ctl (renders as garbage "LD B,x" instructions) - not yet fixed.
C $7D3C,3 Draw title screen graphic block
C $7D4A,3 Draw title screen graphic block
b $7D4E
c $7D5C Draw title screen graphic block (attribute rows + bitmap columns)
R $7D5C IY attribute data pointer
R $7D5C DE bitmap data pointer
R $7D5C HL destination screen address
C $7D62,2 Row 3: shadow-HL needs an extra bitmap-third adjustment
C $7D67,2 Bump shadow H for the bitmap-third boundary
C $7D72,2 Write attribute byte across 7 columns
C $7D75,3 Advance to next attribute row (+$19)
C $7D80,2 Copy 8 bitmap scanlines for this column
C $7D85,2 Next of 7 columns
C $7D8D,2 Row 4: crossing into next screen third
C $7D92,3 Bump H to next screen third (+$10)
C $7D95,2 Next of 7 rows
c $7D98 Decode 9 graphic blocks, then substitute every other byte via table $9A00
N $7D98 Called from $A5A5/$A5B2. HL starts at $CA09 and is threaded, unsaved, through all 9 calls to $7DC9/$7DF3 as their shared output cursor - $7DF3 writes decoded graphics data to (HL) and advances it, so HL ends up pointing past everything written by the 9 blocks (overwriting the $CA09 descriptor data in place as it's consumed). The total byte count written (HL-$CA09) is then halved and used as a loop count for a second pass: walking from $CA09, every other byte is treated as an index into a fixed 256-entry table at $9A00 and replaced with the looked-up value in place - a substitution/palette pass over half the decoded stream (the alternating bytes are left untouched).
C $7DA3,2 9 block-descriptor entries
C $7DA6,3 Decode one graphic-block descriptor entry
C $7DAC,2 Advance IY to the next 17-byte entry
C $7DAF,2 Loop 9 times
C $7DB5,2 Total bytes written = HL - $CA09
C $7DB8,4 Halve the byte count (process every other byte)
C $7DBF,3 Substitute this byte via table $9A00
C $7DC2,1 Skip the alternate (untouched) byte
C $7DC6,2 Loop until the halved count reaches zero
c $7DC9 Decode one graphic-block descriptor entry (IY-indexed)
N $7DC9 Called 9 times from $7D98's loop, once per 17-byte ($11) IY-indexed entry. Calls $7DF3 to decode the block's data, stores the resulting pointer into IY+$02/$03, then calls $7E4A; if IY+$0E (a repeat count) is nonzero, repeats the $7DF3/$7E4A pair that many more times. Finishes by shifting a flag at IY+$0A and, if IY+$06 is set, incrementing a counter at IY+$0B.
C $7DC9,3 Expand one graphic block
C $7DD2,3 Build bit-shifted copies of a graphic block
C $7DDC,3 Expand one graphic block
C $7DDF,3 Build bit-shifted copies of a graphic block
c $7DF3 Expand one graphic block (with optional blank-row padding)
R $7DF3 HL destination cursor (in/out, advanced past the written data)
N $7DF3 Called from $7DC9. If IY+$06 is set, first pads (IY+$07) blank rows via $7E3D. Writes (IY+$0B) rows of (IY+$0A) columns, each column as two interleaved source bytes ($20 apart) from IX; the per-row column count is summed into a self-modified operand at $7E1B for later use. If IY+$06 is set, pads (IY+$07) more blank rows afterwards, then advances IX by the total column width read back from $7E1B.
C $7DF7,2 Skip leading padding if flag clear
C $7DFC,3 Write one blank padding row
C $7DFF,2 Pad blank rows before the block
C $7E09,2 Sum column width into A (total block width)
C $7E20,2 Write interleaved byte pair for this column
C $7E23,2 Next row
C $7E29,2 Skip trailing padding if flag clear
C $7E2E,3 Write one blank padding row
C $7E31,2 Pad blank rows after the block
C $7E39,2 Advance IX by the block's total width
c $7E3D Write one blank padding row (8x $00/$FF byte pairs)
N $7E3D Called from $7DF3 to pad a leading/trailing blank row. Writes 8 columns of the same interleaved byte-pair layout $7DF3 writes for real data (pixel byte $00, mask/second-plane byte $FF - i.e. blank pixels, fully transparent).
c $7E4A Build bit-shifted copies of a graphic block (smooth-scroll variants)
N $7E4A Called from $7DC9 after $7DF3 has expanded the block. If IY+$06 is zero, just advances HL past the block (+IY+$0C) and returns. Otherwise: derives a shift-step count from the lowest set bit of IY+$06 doubled, and for each step duplicates the block (LDIR, offset by IY+$0C) into a working copy, then right-shifts every column of it by 1 bit with carry propagating between bytes (RLA/RR (HL)/RRA/ADD HL,DE) - building successive sub-pixel-shifted copies of the graphic for smooth horizontal scrolling.
C $7E4E,2 Skip shift generation if flag is zero: just advance pointer
C $7E54,2 Shift-step count = lowest set bit of doubled flag
C $7E61,2 Duplicate block into working copy (offset by IY+$0C)
C $7E68,2 Bit-shift amount = (8 - flag) mod 8
C $7E81,2 Shift this column right by 1 bit (carry-propagate)
C $7E89,2 Next column
C $7E8D,2 Next shift amount
C $7E90,2 Next shift step
C $7E97,1 Advance pointer past this block
b $7E99
t $9458
b $945D
t $9854
b $9857
t $9858
b $985C
t $9890
b $989D
t $989E
b $98A5
t $98BA
b $98BD
t $98BE
b $98C8
B $9C76,1,1
W $9C77,2,2
B $9C7C,1,1
B $9C81,1,1
B $9C88,1,1
B $9C8D,1,1
t $9C91
b $9C95
t $9CA3
b $9CA7
t $9CAC
b $9CB0
t $9CC0
b $9CC3
t $9CC7
b $9CD1
t $9CFA
b $9CFD
t $9DF0
b $9DF4
t $9DFE
b $9E02
t $9E10
b $9E14
t $9ECD
b $9ED0
t $9ED7
b $9EDB
t $9EF7
b $9EFA
t $9F18
b $9F1B
t $9F25
b $9F29
t $9FBC
b $9FBF
t $9FC4
b $9FC8
t $9FCF
b $9FD3
t $9FDA
b $9FDE
t $9FE5
b $9FE9
t $9FF0
b $9FF4
t $9FFB
b $9FFF
w $A000 Object state/animation jump-table (used with $B7F6, various offsets)
N $A000 One continuous 73-entry word table of code addresses, live-verified: every entry ($A000-$A091) points into valid code ($A445-$C3C7 range). Different routines index into different sub-ranges of this same table via $B7F6 (e.g. $A02A, $A02E, $A038, $A042, $A052, $A076 are all just offsets into it, not separate tables). Ends at $A092, immediately followed by the score-value table at $A094 (see $66B5).
W $A026,2,2 => Formation script
W $A038,2,2 No-op
W $A042,2,2 No-op
W $A044,2,2 No-op
W $A046,2,2 No-op
W $A048,2,2 No-op
W $A052,2,2 No-op
b $A092
c $A0B0 Interrupt handler (light): bump frame counter, set vblank flag
N $A0B0 Live-traced: this is the active per-frame handler right after pressing "1" to start. Which game phase uses this vs $A0C4 is not yet confirmed.
c $A0C4 Interrupt handler (heavy): saves shadow regs, dispatches enemy/player/collision/sprite updates
C $A106,3 Animate active player's indicator box colour
C $A109,3 Mark active objects into the attribute-buffer collision mask
C $A10C,3 Draw active objects' collision masks into attribute buffer
C $A10F,3 Clear buffers at $7F00-$7FFF and $8000-$80FF
C $A115,3 Scroll background
C $A11B,3 Build wrapped scroll-window row into $F6D1 buffer
C $A11E,3 Advance enemy timeline
C $A121,3 Update randomized countdown, then enter player update
C $A127,3 Player respawn/continue state check
c $A13A Dispatch highest-priority pending deferred event
N $A13A Reads a pending-events bitmask ($9C27) masked by an enable/priority mask ($9C28); if any bit survives, finds the lowest-numbered set bit (highest priority), clears it from $9C27, and dispatches the corresponding handler via the $A042 sub-range of the shared $A000 jump table. $9C27's bits are set from several places for different deferred actions - bit 1 is "score changed, redraw HUD" (set by $66B5), bit 0 by $A1EA, bit 2 by $A8CF/$BF57/$C33B/$C373, bit 3 by $C8C9 - so this is a general deferred-event dispatcher, not sound-specific (despite looping through $A222's tone generator via $A255).
C $A155,3 Jump-table dispatcher
N $A15E Handler for indices $21, $22, $23, $24 of the $A000 jump table (see $B7F6).
N $A15F Handler for index $26 of the $A000 jump table (see $B7F6).
C $A169,3 Update player's HUD panel
N $A16D Handler for index $28 of the $A000 jump table (see $B7F6).
C $A174,3 Load parameters for the pending sound effect
N $A178 Handler for index $27 of the $A000 jump table (see $B7F6).
c $A15E
c $A15F
c $A16D
c $A178
C $A182,3 Print a player's score at its HUD position
C $A185,3 Award bonus life when score threshold reached
c $A189 Award bonus life when score threshold reached
N $A189 Compares a progress value (IX+0) against a threshold table at $9CB8 (indexed by IX+4); if not yet crossed, returns. Otherwise advances the threshold index (IX+4) and, unless lives are already at the cap of 10 (IX+3), grants an extra life and redraws the lives/bombs icon row via $672C.
C $A1AB,3 Draw lives/bombs icon rows for a player
N $A1AF Handler for index $25 of the $A000 jump table (see $B7F6).
c $A1AF Restrict event mask to bit 7, run scenery script
N $A1AF Masks the deferred-event enable mask ($9C28) down to just bit 7 (only the highest-priority event class stays enabled), then runs the scenery/event script interpreter ($A3A0). Likely used during a state where only critical events (e.g. game-over) may interrupt while background scenery keeps animating.
C $A1B6,3 Scenery/event script interpreter
b $A1BA
c $A1C8 Clear pending sound-effect priority
c $A1CE Request sound effect at maximum priority
C $A1D0,3 Request sound effect if higher priority than current
c $A1D4 Request sound effect if higher priority than current
R $A1D4 A effect priority (high nibble)
N $A1D4 Compares the high nibble of A against the currently pending effect's priority (stored at ($A1BA)); if A's priority is >= the current one, updates it, marks ($A1BB)=$80, and sets bit 0 of $9C27 to request dispatch via $A13A/$A222.
C $A1DB,3 Mask current pending priority (high nibble)
C $A1DF,2 Mask new request's priority (high nibble)
C $A1E2,2 Skip if new priority is lower
C $A1E4,1 Store new priority as pending
C $A1E5,5 Mark ready flag $A1BB=$80
C $A1EA,5 Request dispatch via $9C27 bit 0
c $A1F2 Load parameters for the pending sound effect
N $A1F2 Reads the pending sound-effect priority (low nibble of $A1BA, set by $A1D4); if zero, jumps to the idle path ($A324). Otherwise indexes an 8-byte-stride parameter table at $A329 by (priority-1), copies 7 bytes into a working buffer at $A1BC, and unpacks further fields from it via nibble/bit extraction. Continues the sound-effect pipeline started by $A1CE/$A1D4/$A13A.
C $A1F5,5 Check priority nibble; jump to idle if zero
C $A1FA,4 (priority-1)*8 -> byte offset into $A329 table
C $A201,4 Point HL at this priority's 8-byte parameter entry
C $A208,5 Copy first 7 bytes into working buffer $A1BC
C $A20D,4 Low nibble of 8th byte -> extra field
C $A212,6 Combine+rotate for second extra field (high nibble)
C $A218,4 C = last copied parameter byte
C $A21C,6 HL -> tone-length source; A = first parameter byte
c $A222 Play sound effect (timed speaker-bit toggle)
N $A222 Alternates the value written to port $FE between $18 and $00 (toggling bit 4, the speaker/EAR bit, along with border colour bits) inside a precisely NOP-counted delay loop - a square-wave tone generator, same technique as the $AA0F/$AA34 music engine but used here for a sound effect rather than music. Exact trigger context not confirmed.
C $A228,6 Copy $A1C3 into $A1C7 (setup source pointer)
C $A22E,2 Select tone-length source via C bit 7
C $A236,2 Pick $A1C5 vs $A1C6 pointer variant
C $A241,2 A=$18: toggle-on value (border+speaker bit)
C $A244,2 Write toggle value to port $FE
C $A249,2 Hold half-cycle for B ticks (NOP-counted delay)
C $A24B,1 Swap duration-source pointer for next half-cycle
C $A24E,3 Loop 2 half-cycles (one full square-wave period)
c $A255 Between-segment handler for the sound-effect player
N $A255 Called between tone segments of $A222's player when $A1BB (segment-remaining counter) is nonzero. Dispatches other pending deferred events via $A13A (same "poll between beats" pattern as the music engine's $A94C), then checks a completion marker: if it equals $80, reloads a new pending sound effect via $A1F2; otherwise continues the current effect's tone loop.
C $A256,2 If no segments remain, resume tone loop ($A23E)
C $A25C,3 Dispatch highest-priority pending deferred event
C $A263,6 Read and clear completion marker $A1BB
C $A269,4 Marker $80: effect done, load next effect ($A1F2)
C $A26D,2 Mode bit (C bit 7) selects which delta pair to apply
C $A293,6 Decrement segment counter; resume tone loop if more remain
C $A29C,4 Decrement repeat count; idle ($A324) when it hits zero
C $A2B0,2 C bit 5: toggle the $A1C3 sub-counter
C $A2BC,2 C bit 3: negate pitch delta ($A1BD) - sweep reversal
C $A2CF,2 C bit 4: negate duration delta ($A1BF) - sweep reversal
C $A2E2,2 C bit 6: reload base pitch/duration from $A1BC/$A1BE
c $A31D Sound-effect helper entry points, ending in priority-clear idle path
N $A31D Entry $A31E stores A into $A1C7 then jumps back into $A222's border loop ($A23E). Entry $A324 (used by both $A1F2 and $A255) clears the pending sound-effect priority ($A1BA) and returns - the "no sound active" idle state. The bytes right after ($A329 onward) are the 8-byte-stride parameter table indexed by $A1F2.
b $A329 Sound-effect parameter table (9 entries, 8 bytes each)
c $A371 Reset various state pointers/counters to defaults
N $A371 Resets $9BAD=$1C, $9BA9/$9BAB=$7D00 (the system-init routine, used here as a sentinel/default value rather than being called), $9BAE/$9C00/$9BF8=0, $9BF9=$FA79 (the menu fill-buffer target from $6498), $9BAF=0, $9BFF=$FF, $9BFB=$6D71. Looks like a general "clear pointers to defaults" step run when (re)starting a level, called from $A4E7.
c $A3A0 Scenery/event script interpreter (wait or dispatch event)
N $A3A0 Reads bytes from a script pointer ($9BFD, defaulting to $6D71 via $A371). If the script-active flag ($9BFF) isn't $FF, returns immediately (see $A3E2 continuation). Otherwise: a byte with the top bit set dispatches a scene event via an offset-chain table at $6E06 (summing B DE-strides to find the target, stored into $9C0C); $FF rewinds the script pointer back to the default ($9BFB) and loops; anything else is a "wait" delay (masked to a nibble, stored at $9BAF) and the script pointer advances. Distinct from the enemy-formation ($AFB8) and object-movement ($B8F9) script systems - likely drives background/scenery timing.
C $A3DC,3 Extract next 4-bit parameter from scenery-event data
C $A3EE,3 Extract next 4-bit parameter from scenery-event data
C $A3F4,3 Jump-table dispatcher
C $A3F7,3 Render sub-pixel scrolled graphic
c $A40B Render sub-pixel scrolled graphic (shift amount from scenery script)
N $A40B If the scenery-script wait value ($9BAF) is zero, skips ahead ($A441). Otherwise uses it as a pixel-shift amount (self-modifies an operand at $A436 with NEG+8), then copies 9 bytes from the scenery data pointer ($9BAB) into a double buffer at $9BE6 (both IX+0 and IX+9), continuing into shift-based blit logic. Looks like a smoothly-scrolling scenery/marquee graphic renderer, reusing $A3A0's wait-timer as the sub-pixel offset.
C $A40F,2 Skip render if wait value is zero
C $A413,2 Displacement = 8 - wait value
C $A415,3 Self-modify the shifted-read operand at $A436
C $A423,2 Outer: 9-byte copy loop setup
C $A427,8 Duplicate byte into both halves of the double buffer (wrap-safe shift)
C $A434,3 Read back from the self-modified shifted offset
C $A43A,1 Write shifted byte, walking backward
C $A43F,2 Repeat for C passes
N $A445 Handler for index $15 of the $A000 jump table (see $B7F6).
c $A445 Draw scrolling scenery column using tile generator
C $A44E,3 Generate next scenery/terrain cell value
C $A45F,3 Generate next scenery/terrain cell value
N $A46C Handler for index $16 of the $A000 jump table (see $B7F6).
c $A46C Draw scrolling scenery column (variant, using tile generator)
N $A46C Structurally similar to $A445 (same $A499 tile-generator calls building a column into HL) but with a +9 row stride and 5-row outer loop instead of $A445's layout - likely a different scenery band/type sharing the same generator.
C $A477,3 Generate next scenery/terrain cell value
C $A489,3 Generate next scenery/terrain cell value
c $A499 Generate next scenery/terrain cell value
R $A499 O:A generated cell value (base $9C0B + next script nibble)
R $A499 HL preserved
N $A499 Every $9C0A calls, refreshes a base value ($9C0B) by reading a fresh byte from the scenery-event data via $A4B5; otherwise decrements the counter. Adds the next scenery-script nibble parameter ($A4C4) to that base value to produce the returned cell value - so the base periodically re-reads from the script data, not from randomness.
C $A4A1,3 Read next byte (2 nibbles) from scenery-event data
C $A4A7,3 Read next byte (2 nibbles) from scenery-event data
C $A4AC,3 Extract next 4-bit parameter from scenery-event data
c $A4B5 Read next byte (2 nibbles) from scenery-event data
N $A4B5 Combines two calls to $A4C4 (high nibble then low nibble) into a full byte. Corrects an earlier guess at $A499 - this is just a byte reader, not a PRNG source.
C $A4B6,3 Extract next 4-bit parameter from scenery-event data
C $A4BE,3 Extract next 4-bit parameter from scenery-event data
c $A4C4 Extract next 4-bit parameter from scenery-event data
R $A4C4 O:A the extracted nibble (0-15)
N $A4C4 Reads a byte from the event-data pointer $9C0C and, alternating via the flag $9C0E (which flips $0F/$F0 each call), returns first its high nibble then its low nibble; the pointer only advances after both nibbles of a byte have been consumed. Used by $A3A0's scenery/event script system to unpack 2 packed 4-bit parameters per data byte.
C $A4C6,3 HL = current byte pointer ($9C0C)
C $A4CC,2 Mask out the selected nibble
C $A4D1,6 Flip nibble-select mask ($9C0E); test which nibble just finished
C $A4D8,2 Skip shift if this was the low-nibble read
C $A4DA,6 Advance byte pointer (low nibble just consumed) and return
C $A4E0,4 Shift high nibble down to low bits
c $A4E7 Find level index from formation tag, reset state, select colour scheme
N $A4E7 Searches an 8-entry table (from ($9BA7)) for the first entry >= the current object's wave/formation tag (IX+7), storing the found level index into $9BA4. Calls $A371 to reset various state pointers. Then scans a second, 3-byte-stride table (cursor persisted at $9BA5) while $9BA4 >= the table's threshold byte, and once found, reads the level's colour/type value into $9C59 and $9C5A - the value used throughout the game for wipe-effect colour, screen fills etc (see $C6A6, $66B5). So the active colour scheme is level-dependent, selected here.
C $A506,3 Reset various state pointers/counters to defaults
C $A518,3 Scenery/event script interpreter
c $A561 Player respawn/continue state check
N $A561 Called every frame from $A0C4. If the death/recovery timer ($9C3C, armed by $BF22) is active, counts it down and signals A=4 on expiry; if disabled ($FF), instead polls the ENTER key (row $F7 bit 3) for a manual continue (A=0 if held, else A=2). Either way calls $A599 then dispatches the player's next state via the $A038 sub-range of the shared $A000 table (the same range used by $BE03's index $2B handler).
C $A57C,3 Ratchet player state forward
C $A585,3 Jump-table dispatcher
C $A58F,3 Request sound effect at maximum priority
C $A592,3 point to per-frame handler $A0B0 (light ISR)
C $A595,3 set ISR handler address
N $A588 Handler for index $1C of the $A000 jump table (see $B7F6).
N $A589 Handler for indices $1F, $20 of the $A000 jump table (see $B7F6).
c $A588 No-op state (index $1C)
c $A589 Exit gameplay: mirror state, play alert sound, switch to light ISR
N $A589 Copies $9C3D into $9C3E (a mirrored/confirmed-state value), requests the maximum-priority sound effect via $A1CE (likely a game-over/death jingle), then repoints the ISR ($FDFE) back to the light handler $A0B0 - taking the game out of active gameplay. Handler for indices $1F/$20 of the shared table.
c $A599 Ratchet player state forward (only increase, never decrease)
R $A599 A candidate new state value
N $A599 Updates $9C3D (the state $A561/$A57F reads for its dispatch) only if A is >= the current value; otherwise leaves it unchanged. Ensures the respawn/continue state only ever advances.
c $A5A0 Start music track 0
C $A5A1,3 Start playing music track A
c $A5A5 Show title screen once, then (re)initialize interrupts
N $A5A5 Used by $A902's menu loop. Checks a "shown once" flag at $9B9F; if not yet set, sets it and calls $7D1F to clear the screen and draw the title artwork. Either way falls through into $A5B2: CALL $7D98 (build the shift-copy tables), CALL $7D00 (re-init IM 2 vectors), then point the ISR trampoline at $A0B0 and EI/RET.
C $A5AF,3 Clear screen and draw title screen graphics
C $A5B2,3 Decode 9 graphic blocks, then substitute every other byte via table $9A00
C $A5B5,3 Initialize IM 2 interrupt vector table and set light ISR
c $A5C0 Initialize both players' game state (lives, bombs, HUD)
N $A5C0 Used by $A8C0 when starting a new game. Zeroes each player's 11-byte state block ($9C79/$9C85), then sets starting lives ($9C88/$9C7C, POKE 42464), starting bombs ($9C82/$9C8E, POKE 42490), and other per-player defaults (active-player flag $9C76, HUD pointer $9C77, misc fields).
C $A5C2,3 Init menu screen
C $A5DF,2 POKE 42464,N sets starting lives count
C $A5F9,2 POKE 42490,N sets starting bomb count
c $A612 Initialize wave-group counters and load group data tables
N $A612 Loads the current wave's config from $9C84 (explosion data, 13-byte stride) and $61D4 (per-level pointers: colour scheme/level index/scenery script, 20-byte stride, $61D4 is the per-level config table), derives fire-timer reload values, then falls through at $A696 into $B730/$A4E7/$6A88 (wave init, level select, credits screen).
C $A619,3 Save wave-group id ($9C68)
C $A626,3 Index 13-byte table at $9C84 for explosion data
C $A63C,3 Index 20-byte per-level table at $61D4
C $A64E,14 SP-trick: pop level-config pointers (colour scheme/level index/scenery script)
C $A65F,4 Adjust cursor if wave-type is 3
C $A66E,2 Clamp fire-timer high byte on overflow
C $A69A,3 Restore SP
C $A6A6,2 Bump bonus counter past difficulty threshold
C $A6AE,2 Bump bonus counter past second threshold
C $A6B1,3 Initialize wave
C $A6B4,3 Find level index from formation tag, reset state, select colour scheme
C $A6B7,3 Show credits screen
c $A6BB
C $A6BD,3 Init menu screen
C $A6C0,2 "FIREBIRD...FLYING SHARK...GRAFTGOLD LTD...COPYRIGHT 1987"
C $A6C2,3 Print message N from table $627A
C $A6C5,3 Start music track 0
C $A6CB,3 Init menu screen
C $A6CE,2 credits: "SOFTWARE DESIGN AND PROGRAMMING BY DOMINIC ROBINSON, GRAPHICS BY JOHN CUMMING, MUSIC BY STEVE TURNER"
C $A6D0,3 Print message N from table $627A
C $A6D8,3 Screen wipe transition effect
C $A6DE,3 Read fire button (Kempston/keyboard) with debounce
c $A6E5 Print high-score table
C $A6E7,3 Init menu screen
C $A6EA,6 set cursor position, point HL at high-score name table $6238
C $A6F3,3 loop 6 rows
C $A6F6,3 Print string (control codes + ROM-font text) from HL
C $A6FF,3 Print character to screen using ROM font
C $A705,3 Print packed-BCD number with leading-zero suppression
C $A715,3 Print packed-BCD number with leading-zero suppression
C $A720,3 Screen wipe transition effect
C $A72D,3 Paint attribute colour-wipe column
C $A735,3 Read fire button (Kempston/keyboard) with debounce
C $A73E,3 Print message N from table $627A
C $A762,3 Read fire button (Kempston/keyboard) with debounce
C $A76D,3 Init menu screen
c $A773 Handle player death (respawn, or Game Over if out of lives)
C $A773,3 Update player's HUD panel
C $A776,3 Wait for input
C $A779,10 wait for frame-done flag $9C3E, run state table at $A02E
C $A783,4 load player object pointer into IX
N $A783 Handler for index $1B of the $A000 jump table (see $B7F6).
C $A787,3 increment death/state counter at IX+5
C $A78A,8 init respawn state fields IX+8=1, IX+9=3
C $A792,6 check lives-remaining field at IX+3; skip Game Over if lives left
N $A798 Out of lives, Game Over.
C $A798,2 save IX
C $A79A,2 "GAME OVER"
C $A79C,3 Print message N from table $627A
C $A79F,6 position first Game Over text line (row $0A, col $90/8)
C $A7A5,3 Paint attribute colour-wipe column
C $A7A8,6 position second Game Over text line (row $0A, col $40/8)
C $A7AE,3 Paint attribute colour-wipe column
C $A7B1,3 Check for new high score, congratulate and reset defaults if so
C $A7B4,5 restore IX, re-init player state
C $A7B9,5 set active-object type $9C59=9
C $A7BE,3 Screen wipe transition effect
C $A7C1,7 check IX+3 sign, branch if negative
C $A7C8,1 return
c $A783 Player death-check entry (mid-point of $A773, skips input/frame update)
C $A7CD,3 Screen wipe transition effect
C $A7D0,3 Decrement current player's lives
c $A7D7 Decrement current player's lives; switch turn to other player if any remain
R $A7D7 IX current player's state block base (lives at IX+$03)
N $A7D7 Called on death/wave-loss (from $A7B6/$A7D0). If only one player ($9C75==1), just decrements the current player's lives (IX+$03) and returns. In 2-player mode, checks the *other* player's lives (IY, selected as the block that isn't the active one at $9C76); if they still have lives, switches control to them (updates the current-player pointer $9C77, toggles the active-player flag at $9C76). Either way, finishes by decrementing the now-current player's lives.
C $A7DB,2 Single-player: skip switch, just decrement lives
C $A7E1,4 Default: select the other player's state block
C $A7E6,2 Active player was 2: keep player-1 block selected instead
C $A7F0,2 Other player is out of lives: don't switch turns
C $A7F6,4 Switch current-player pointer to the other player
C $A7FB,2 Toggle active-player flag
C $A7FE,3 Decrement the (now-current) player's lives
c $A802 Show bonus-points award screen, transition onward
N $A802 Prints "3000 POINTS" (message $12), draws a box graphic ($6B09), then (further in, at $A862/$A866) prints another message, starts music track 1, resets the colour scheme, and runs the $C6A6 wipe transition. Also plays a tone effect ($A84D-$A85B, same timed border/speaker-toggle technique as $A222) partway through. Handler for index $1A of the shared table.
C $A80C,2 "3000 POINTS"
C $A80E,3 Print message N from table $627A
C $A819,3 Draw bordered box graphic (colour + bitmap) at HL
C $A821,2 "BONUS-"
C $A825,3 Print message N from table $627A
C $A837,3 Draw bordered box graphic (colour + bitmap) at HL
C $A83D,3 Add BCD score value to current player's score
C $A843,3 Print a player's score at its HUD position
C $A846,3 Award bonus life when score threshold reached
C $A863,3 Print message N from table $627A
C $A868,3 Start playing music track A
C $A870,3 Screen wipe transition effect
N $A894 Handler for indices $17, $18, $19, $1D of the $A000 jump table (see $B7F6).
C $A8A0,3 Init menu screen
N $A8A7 Handler for index $1E of the $A000 jump table (see $B7F6).
C $A8A7,3 Request sound effect at maximum priority
C $A8B5,3 Read fire button (Kempston/keyboard) with debounce
c $A894 Start game: switch ISR to $A0B0, enter main loop
C $A894,3 point to per-frame handler $A0B0 (light ISR)
C $A897,3 set ISR handler address
c $A8A7
c $A8C0 Start new game: reset game state
N $A8C0 Waits for input, then resets core per-game state: deferred-event mask $9C27 (via $A1C8/$FF00), player state $9C3D/$9C3E, immobilise flag $9C3B, redefine-key debounce $9CDC, and disables the death/recovery timer ($9C3C=$FF, the sentinel $A561 checks). Called at the start of a new game (from the game-start sequence via $A6BB/$A6C9).
C $A8C0,3 Wait for input
C $A8C3,3 Clear pending sound-effect priority
C $A8E5,3 Clear buffers at $7F00-$7FFF and $8000-$80FF
C $A8E8,3 Draw active objects' collision masks into attribute buffer
C $A8EC,3 Scenery/event script interpreter
C $A8EF,3 point to per-frame handler $A0C4 (heavy ISR)
C $A8F2,3 set ISR handler address
C $A8F5,3 Dispatch highest-priority pending deferred event
C $A905,3 Show title screen once, then (re)initialize interrupts
C $A90C,3 Print high-score table
C $A914,3 Initialize both players' game state
C $A917,3 Initialize wave-group counters and load group data tables
C $A91A,3 Start new game
C $A91D,3 Handle player death
c $A927 Start playing music track A
R $A927 A music track number
N $A927 Sets $9C29 = A (also used by $6A4A as a "menu busy" guard - only one track/menu action active at a time), then looks up a pointer from the track table at $AB03 (indexed by A*2) and stores it into $AA8E, the note pointer consumed by the $AA0F/$AA34 music engine.
c $A937 Point score reader at next event, check for end
c $A94C Parse next music score byte (note/duration/rest)
N $A94C Reads score bytes and classifies by value range: >=$D0 sets an instrument/octave value ($AA98), $60-$6F indexes a note-pitch table at $AA9B (3 bytes/entry) to play a note, other ranges set duration ($AA92) or rest. Also polls the menu dispatcher ($6A4A) and fire button each event, so music playback and menu input share this loop while on the title screen.
C $A94F,3 Main menu key dispatcher
C $A952,3 Read fire button (Kempston/keyboard) with debounce
N $A9F1 Look up note pitch period and apply octave shift
N $A9F1 Called from $A94C for a $60-$6F score byte. Low nibble of the byte indexes the pitch-period table at $AA9B (3 bytes/entry, note within octave); high nibble is the octave number - if nonzero, $AA0F halves the pitch period that many times (one halving per octave) before the note is played via $AA34.
C $A9F6,2 Note index (low nibble)
C $AA06,5 Octave number (high nibble); skip halving if zero
N $AA0F Halve note period HL by octave count in A
C $AA22,3 Play beeper music note
C $AA28,3 => Parse next music score byte
C $AA2F,3 => Point score reader at next event, check for end
c $AA34 Play beeper music note (square-wave tone generator)
C $AA35,4 Save note period parameters ($AA94)
C $AA39,3 Initial 32-step attack/click burst
C $AA3F,2 Toggle border/speaker bit during attack
C $AA52,2 Phase accumulator step (HL -= period)
C $AA54,6 Decrement duration (BC); finish when zero
C $AA5A,6 delay loop: hold current tone half-cycle for HL ticks
C $AA61,4 Toggle speaker bit, output to port $FE
C $AA68,6 Hold second half-cycle for DE ticks
C $AA6F,4 Toggle speaker bit again (full square-wave period)
C $AA74,11 Recompute period via Bresenham blend ($AA94/$AA96)
C $AA85,3 Loop back for next cycle
C $AA88,5 Silence pad and return
b $AA8D
b $AAA5
t $AAE6
b $AAE9
t $AB49
b $AB4C
t $AB4D
b $AB50
t $AB54
b $AB64
t $AB75
b $AB79
t $AB7A
b $AB84
t $AB85
b $AB88
t $AB8C
b $AB8F
t $AB90
b $AB94
t $AB96
b $AB9F
t $ABC1
b $ABC4
t $ABF4
b $ABF7
t $ABFB
b $ABFE
t $AC33
b $AC39
t $AC7F
b $AC82
t $AC87
b $AC8B
c $AC8D
C $AC8D,4 Save SP (restored at $ACB4)
C $AC91,4 Point IY at sound state block $9D1E
C $AC98,6 Toggle border/speaker bit of state byte at $9C37 and output it
C $ACA0,6 Pop next loop/duration word via SP-trick into IY
C $ACA6,4 Loop while duration bit (IY+$04 bit 2) is clear
C $ACAC,4 Clear "busy" flag ($9D1E+$04 bit 0) once duration elapses
C $ACB4,3 Entry: force-stop (reset SP, no toggle)
C $ACB8,4 Entry: request toggle loop (sets IY+$04 bit 5)
C $ACBC,4 Only continue toggling while bit 4 flag is set
c $ADB8
C $AE38,3 => Formation script
C $AEB0,3 => Formation script
C $AED9,3 => Formation script
C $AEEC,3 => Formation script
C $AF15,3 => Formation script
C $AF22,3 => Formation script
c $AFB8 Formation script: read next byte, dispatch via $A000 table (SP=addr/RET trick)
R $AFB8 IX formation-script pointer
C $AFB8,5 read next script byte from (IX), advance script pointer
C $AFBD,4 form address $A0xx from script byte, jump there via faked RET
N $AFB8 Reads the byte at (IX), advances IX, then forms address $A0xx (xx = that byte) and jumps there by setting SP to it and executing RET - the byte value doubles as a direct low-byte offset into the same $A000 word table used by $B7F6 elsewhere. Called by 17 different formation/wave routines ($ADB8, $AFC3, $B005, $B072, $B0B4, $B15B, $B1BE, $B24A, $B2DA, $B36A, $B3FE, $B452, $B4AA, $B567, $B5FE, $B61A, $B6BF, $B72D) - this is the shared bytecode-dispatch core of the enemy formation/wave scripting system.
N $AFC1 Handler for index $14 of the $A000 jump table (see $B7F6).
C $B002,3 => Formation script
N $B005 Handler for index $02 of the $A000 jump table (see $B7F6).
C $B06F,3 => Formation script
C $B0B1,3 => Formation script
N $B0B4 Handler for index $06 of the $A000 jump table (see $B7F6).
C $B11E,3 => Formation script
N $B121 Handler for index $01 of the $A000 jump table (see $B7F6).
N $B12B Handler for index $03 of the $A000 jump table (see $B7F6).
c $AFC1
c $AFC3 Update tile-block tables ($7900+) from SP-fed data (index $00, INC L)
N $AFC3 Handler for index $00 of the $A000 jump table (see $B7F6). Twin of $B072 but fills ascending: writes the low byte of each popped word into a page of the 2x2 tile-block tables ($7900-$7CFF, see $7900), L rising from $F0, then INC H advances to the next page ($7A/$7B/$7C) for each of B ($9C1A) passes. Continues into the formation script ($AFB8).
C $AFC3,4 Source data via SP (POP-fed)
C $AFC7,3 B = column/pass count ($9C1A)
C $AFCB,2 H=$79: destination tile-block table page
C $AFCD,2 A=$F0: row index start (writes ascending)
C $AFCF,1 Set row index for this pass
C $AFD0,3 Store low byte of popped word, ascending
C $AFFF,1 Next page ($7A/$7B/$7C)
C $B000,2 Loop B passes
C $B002,3 => Formation script
c $B005 Opaque tile blit (index $02): copy $9A00[C] to screen, INC E stride
C $B00A,4 Source tile data via SP (POP-fed)
C $B00E,3 Destination high byte = width + $78
C $B013,3 Self-modify row-start column operand
C $B016,2 H=$9A: point at the $9A00 lookup table
C $B01C,5 Copy column: store $9A00[C] straight to screen (opaque, no mask)
C $B06B,1 Next row column-base
C $B06D,2 Loop $9C1A rows
C $B06F,3 => Formation script
c $B072 Update tile-block tables ($7900+) from SP-fed data (index $04)
N $B072 Handler for index $04 of the $A000 jump table (see $B7F6). Writes into the 2x2 tile-block lookup tables at $7900-$7CFF (see $7900) rather than to the screen. For B ($9C1A) passes it fills a descending run of one page (H=$79, L from $FF down) with the low byte of each popped word, then INC H advances to the next page ($7A/$7B/$7C) - so successive passes populate the parallel quadrant tables. Continues into the formation script ($AFB8).
C $B072,4 Source data via SP (POP-fed)
C $B076,3 B = column/pass count ($9C1A)
C $B07A,2 H=$79: destination tile-block table page
C $B07C,2 A=$FF: row index start (writes descending)
C $B07E,1 Set row index for this pass
C $B07F,3 Store low byte of popped word, descending
C $B0AE,1 Next page ($7A/$7B/$7C)
C $B0AF,2 Loop B passes
C $B0B1,3 => Formation script
c $B0B4 Opaque tile blit (index $06): copy $9A00[C] to screen, no masking
C $B0B9,4 Source tile data via SP (POP-fed)
C $B0BD,3 Destination high byte = width + $78
C $B0C2,3 Self-modify row-start column operand
C $B0C5,2 H=$9A: point at the $9A00 lookup table
C $B0CB,5 Copy column: store $9A00[C] straight to screen (opaque, no mask)
C $B11A,1 Next row column-base
C $B11C,2 Loop $9C1A rows
C $B11E,3 => Formation script
c $B121
c $B12B
c $B13F
N $B13F Handler for index $05 of the $A000 jump table (see $B7F6).
c $B14A
N $B14A Handler for index $07 of the $A000 jump table (see $B7F6).
c $B15B OR-composite tile-block pages onto screen (index $10)
N $B15B Handler for index $10 of the $A000 jump table (see $B7F6). Reads the four tile-block table pages ($79F0 upward, SP-fed) and OR-merges them onto the destination screen area at $9C13: for each of B ($9C1A) passes it ORs a run of source bytes into consecutive dest cells (additive overlay, not opaque), then INC H moves to the next source page ($7A/$7B/$7C) and INC D to the next dest row. Continues into the formation script ($AFB8).
C $B15B,4 Destination screen address ($9C13)
C $B160,3 Self-modify row-start column operand
C $B163,3 Source = tile-block buffer $79F0
C $B16C,1 Source via SP (POP-fed)
C $B16F,9 OR-merge two source bytes into consecutive dest cells
C $B1B6,1 Next source page ($7A/$7B/$7C)
C $B1B7,1 Next dest row
C $B1B9,2 Loop $9C1A passes
C $B1BB,3 => Formation script
N $B1BE Handler for index $09 of the $A000 jump table (see $B7F6).
C $B247,3 => Formation script
N $B24A Handler for index $0B of the $A000 jump table (see $B7F6).
C $B2D7,3 => Formation script
N $B2DA Handler for index $0D of the $A000 jump table (see $B7F6).
C $B367,3 => Formation script
N $B36A Handler for index $0F of the $A000 jump table (see $B7F6).
C $B3FB,3 => Formation script
N $B3FE Handler for index $08 of the $A000 jump table (see $B7F6).
C $B44F,3 => Formation script
N $B452 Handler for index $0A of the $A000 jump table (see $B7F6).
C $B4A7,3 => Formation script
N $B4AA Handler for index $0C of the $A000 jump table (see $B7F6).
C $B4FF,3 => Formation script
N $B502 Handler for index $0E of the $A000 jump table (see $B7F6).
c $B1BE
C $B1BE,4 Source sprite data via SP (POP-fed)
C $B1C2,4 Destination screen address ($9C13)
C $B1C6,2 H=$9A: point at the $9A00 lookup table
C $B1C9,3 Self-modify row-start column operand
C $B1D4,7 Blit column: mask via $9A00[B], merge XOR C, store
C $B243,1 Next row column-base
C $B245,2 Loop $9C1A rows
C $B247,3 => Formation script
c $B24A
C $B24F,4 Source sprite data via SP (POP-fed)
C $B253,4 Destination screen address ($9C13)
C $B25B,3 Self-modify row-start column operand
C $B25E,2 H=$9A: point at the $9A00 lookup table
C $B264,7 Blit column: mask background (AND B), merge sprite (XOR $9A00[C]), store
C $B2D3,1 Next row column-base
C $B2D5,2 Loop $9C1A rows
C $B2D7,3 => Formation script
c $B2DA
C $B2DA,4 Source sprite data via SP (POP-fed)
C $B2DE,4 Destination screen address ($9C13)
C $B2E9,3 Self-modify row-start column operand
C $B2E7,2 H=$9A: point at the $9A00 lookup table
C $B2F4,7 Blit column (DEC E stride): mask via $9A00[B], merge XOR C, store
C $B363,1 Next row column-base
C $B365,2 Loop rows
C $B367,3 => Formation script
c $B36A
C $B36F,4 Source sprite data via SP (POP-fed)
C $B373,4 Destination screen address ($9C13)
C $B377,3 Add X offset ($9C1A) to dest high byte
C $B37A,3 Add Y offset ($9C1B) to dest low byte
C $B37F,3 Self-modify row-start column operand
C $B382,2 H=$9A: point at the $9A00 lookup table
C $B388,7 Blit column: mask background (AND B), merge sprite (XOR $9A00[C]), store
C $B3F7,1 Next row column-base
C $B3F9,2 Loop rows
C $B3FB,3 => Formation script
c $B3FE Masked tile blit (index $08): AND $9A00[B], XOR C, INC E stride
C $B3FE,4 Source tile data via SP (POP-fed)
C $B402,4 Destination screen address ($9C13)
C $B406,2 H=$9A: point at the $9A00 lookup table
C $B409,3 Self-modify row-start column operand
C $B414,7 Blit column: mask via $9A00[B], merge XOR C, store
C $B44B,1 Next row column-base
C $B44D,2 Loop $9C1A rows
C $B44F,3 => Formation script
c $B452 Masked tile blit (index $0A): AND background, XOR $9A00[C], INC E stride
C $B457,4 Source tile data via SP (POP-fed)
C $B45B,4 Destination screen address ($9C13)
C $B45F,3 Add X offset ($9C1A) to dest high byte
C $B463,3 Self-modify row-start column operand
C $B466,2 H=$9A: point at the $9A00 lookup table
C $B46C,7 Blit column: mask background (AND B), merge sprite (XOR $9A00[C]), store
C $B4A3,1 Next row column-base
C $B4A5,2 Loop $9C1A rows
C $B4A7,3 => Formation script
c $B4AA Masked tile blit (index $0C): AND $9A00[B], XOR C, DEC E stride
C $B4AA,4 Source tile data via SP (POP-fed)
C $B4AE,4 Destination screen address ($9C13)
C $B4B2,3 Add Y offset ($9C1B) to dest low byte
C $B4B7,2 H=$9A: point at the $9A00 lookup table
C $B4B9,3 Self-modify row-start column operand
C $B4C4,7 Blit column: mask via $9A00[B], merge XOR C, store
C $B4FB,1 Next row column-base
C $B4FD,2 Loop $9C1A rows
c $B502 Masked tile blit (index $0E): AND background, XOR $9A00[C], DEC E stride
C $B507,4 Source tile data via SP (POP-fed)
C $B50B,4 Destination screen address ($9C13)
C $B50F,3 Add X offset ($9C1A) to dest high byte
C $B512,3 Add Y offset ($9C1B) to dest low byte
C $B517,3 Self-modify row-start column operand
C $B51A,2 H=$9A: point at the $9A00 lookup table
C $B520,7 Blit column: mask background (AND B), merge sprite (XOR $9A00[C]), store
C $B557,1 Next row column-base
C $B559,2 Loop $9C1A rows
C $B55B,3 => Formation script
c $B55E
N $B55E Handler for index $11 of the $A000 jump table (see $B7F6).
c $B567
C $B593,3 => Formation script
C $B5CB,3 => Formation script
C $B617,3 => Formation script
N $B61A Handler for index $12 of the $A000 jump table (see $B7F6).
c $B61A
C $B661,3 => Formation script
C $B668,3 => Formation script
C $B6B4,3 => Formation script
C $B6BB,3 => Formation script
c $B6BF
C $B723,3 => Formation script
C $B72A,3 => Formation script
N $B72D Handler for index $13 of the $A000 jump table (see $B7F6).
c $B72D => Formation script
C $B72D,3 => Formation script
c $B730 Initialize wave: build object pool, reset counts, spawn first object
N $B730 Builds the 19-slot object free-list at $9D40 (linked via IY+0/+1, head at $9D1C), inits 4 fixed slots at $9D1E (player etc, stride 6, "active"+"alive" flags set), clears the 15-byte formation-slot bitmap at $9B4F-$9B5E, sets four per-group enemy counts ($9D19=6, $9D18=8, $9D1A=4, $9D1B=1 - totalling 19, matching the pool size), then allocates the first object via $C559 - presumably a formation-spawner that runs an $AFB8 script. Called by $A696 (not yet traced - likely the actual "start level N" entry point).
C $B79A,3 Allocate object from free-list pool and initialize
c $B79F Mark formation slot done, trigger completion effect when group empties
R $B79F IY object struct base
N $B79F Clears/masks a bit in a table at $9B50 (indexed by IY+13, a formation-slot id) then decrements an adjacent per-formation counter; when that counter reaches zero, marks the slot done (IY+13=$FF) and either calls $C648 or $C5D2 (start explosion) depending on the $9C3F flag, then decrements a group counter at $9D18. Entry at $B79F uses C=0 (set bit), entry at $B7A3 uses C=$FF (clear bit) - exact meaning of the $9B50 bitmap not yet confirmed. The tail from $B7DC onward (an SP=IY stack trick) is not yet analyzed.
C $B79F,4 entry: normal call, C=0
C $B7A3,3 entry: alternate call, C=$FF
C $B7A6,7 clear flag at IY+14; read formation-slot index from IY+13
C $B7AD,4 skip if slot unused ($FF)
C $B7B1,8 index into bitmap table $9B50, mask bit via C
C $B7B9,1 write back masked bitmap byte
C $B7BA,4 decrement adjacent slot counter; skip if still nonzero
C $B7BE,3 skip if counter was already zero
C $B7C1,6 mark slot done; check completion mode
C $B7C7,2 branch to alternate completion path
C $B7C9,5 Decrement wave-group counter
C $B7CE,6 check game mode flag at $9C3F
C $B7D4,3 start object explosion sequence
C $B7D7,5 decrement group counter at $9D18, return
c $B7F6 Jump-table dispatcher: JP to word-sized table entry A
@ $B7F6 label=jump_table_dispatch
R $B7F6 A word index into the jump table
R $B7F6 HL jump table base address
c $B7FE Pseudo-random number generator (advances LFSR state at $9C2B-$9C32)
@ $B7FE label=random
R $B7FE O:A pseudo-random byte
R $B7FE BC,DE,HL preserved (saved into self-modified operands at entry, restored before RET)
C $B7FE,3 Self-modify: save caller's HL (restored at $B841)
C $B801,4 Self-modify: save caller's DE (restored at $B83E)
C $B805,4 Self-modify: save caller's BC (restored at $B83B)
C $B809,3 Point HL at LFSR state top byte
C $B80C,2 Rotate top byte through carry
C $B827,2 Mix rotated nibbles into new state byte
C $B83B,3 Restore caller's BC
C $B83E,3 Restore caller's DE
C $B841,3 Restore caller's HL
c $B845 Compute angle from object IX to target IY
R $B845 IX object position (shooter)
R $B845 IY target position (e.g. player)
N $B845 Rounds IX's fixed-point X/Y position (lo/hi at IX+$0B/$0C and IX+$0D/$0E) to the nearest integer (RLA into the low byte's top bit, then ADC A,$00 on the high byte), subtracts IY's integer column/row (IY+$0C/$0E) to get delta X (C) and delta Y (B), takes their absolute values while recording quadrant bits in D, then refines to an octant and runs a linear-search division ($B889-$B89C) to approximate the angle - a coarse atan2 feeding aiming/movement code such as $C43C.
C $B84E,3 Delta X = rounded IX position minus IY column
C $B85B,3 Delta Y = rounded IX position minus IY row
C $B863,3 Skip abs-negate if delta Y already positive
C $B86D,3 Skip abs-negate if delta X already positive
C $B879,2 Swap X/Y (octant refinement) if X >= Y
C $B884,2 Clamp check against threshold $03
C $B896,2 Division-loop exit when remainder hits zero
C $B89A,2 Division loop: continue while remainder >= Y
c $B8A2 Compute velocity vector (dx,dy) from angle and speed
R $B8A2 A angle (0-63, index into sine table $9B5F)
R $B8A2 B speed/magnitude
R $B8A2 IY object struct base
N $B8A2 Looks up sin(A) in the table at $9B5F, sign-extends it, then multiplies by speed B via repeated addition to get dx (stored at IY+7/+8). Then computes angle-16 (mod 64, a quarter-turn) for cos(A) the same way, to get dy (stored at IY+9/+10). Classic 8-bit "aim/fire toward angle" trajectory calculation.
C $B8A2,5 save speed (B->C), point HL at sine table $9B5F
C $B8A7,4 index table by angle A
C $B8AB,5 sign-extend table value into DE
C $B8B0,3 HL=0 (accumulator)
C $B8B3,3 multiply table value by speed B (repeated add)
C $B8B6,6 store dx at IY+7/+8
C $B8BC,2 restore speed and angle
C $B8BE,4 angle-16 mod 64: quarter-turn offset for cosine
C $B8C2,3 point HL at sine table again
C $B8C5,4 index table by cosine angle
C $B8C9,5 sign-extend table value into DE
C $B8CE,3 HL=0 (accumulator)
C $B8D1,3 multiply table value by speed B (repeated add)
C $B8D4,6 store dy at IY+9/+10
C $B8DA,1 return
c $B8DB Set object position from $9C01, clamp column (IY+$0C) to 8-24
R $B8DB IY object struct base (writes position fields IY+$0B/$0C/$0D)
c $B8F1
c $B8F9 Movement-pattern script interpreter
R $B8F9 IY object struct base
N $B8F9 Counts down a per-object frame-delay timer (IY+18); once it expires, reads the next byte of a movement script (pointer at IY+15/16) into IY+17, masks it to 0-7, and dispatches that step through the $A076 sub-table (indices $3B-$48) via $B7F6. If a dispatched step signals carry, it loops back immediately to process the next script byte in the same frame; otherwise it returns and waits for the timer to expire again.
C $B90D,3 Jump-table dispatcher
C $B911,3 => Movement-pattern script interpreter
c $B920 Decode movement-script "wait" byte (bit 7 set = wait N or random frames)
N $B920 Continues $B8F9/$B920's script reader: if the script byte's high bit is set, it's a wait command - the low 7 bits give the frame count directly, except value 1 which means "random wait" (1-32 frames via $B7FE). Result is stored into the frame-delay timer at IY+18. If the high bit is clear, the byte is instead a movement-step index, handled by the fallthrough at $B935.
C $B92A,3 Pseudo-random number generator
N $B941 Handler for index $3B of the $A000 jump table (see $B7F6).
c $B941
C $B94A,3 Jump-table dispatcher
c $B94E Read next movement-script byte into E
R $B94E IY object struct base (script pointer at IY+$15/$16)
R $B94E O:E the fetched script byte
R $B94E HL preserved; advances the object's script pointer (IY+$15/$16)
N $B95F Handler for index $3C of the $A000 jump table (see $B7F6).
C $B96C,3 Read next movement-script byte into E
N $B974 Handler for index $3D of the $A000 jump table (see $B7F6).
C $B98A,3 Compute velocity vector (dx,dy) from angle and speed
c $B95F
c $B974
C $B98D,3 Apply object velocity (dx,dy) to position
c $B992
N $B992 Handler for index $3E of the $A000 jump table (see $B7F6).
C $B9B4,3 Compute velocity vector (dx,dy) from angle and speed
C $B9B7,3 Apply object velocity (dx,dy) to position
N $B9BC Handler for index $3F of the $A000 jump table (see $B7F6).
N $B9CA Handler for index $40 of the $A000 jump table (see $B7F6).
C $B9D2,3 Read next movement-script byte into E
C $B9D9,3 Read next movement-script byte into E
N $B9E3 Handler for index $41 of the $A000 jump table (see $B7F6).
c $B9BC
c $B9CA
c $B9E3
c $B9F1
N $B9F1 Handler for index $42 of the $A000 jump table (see $B7F6).
C $B9F1,3 Read next movement-script byte into E
c $BA0A Apply object velocity (dx,dy) to position
R $BA0A IY object struct base
N $BA0A Uses the SP=IY stack trick to add the velocity fields (set by $B8A2, at IY+7/+8 and IY+9/+10) onto the position fields (IY+11/+12 and IY+13/+14). Called every frame by many object-update handlers (e.g. $C015) after the initial launch, confirming this is the generic "move by velocity" step. Also reachable as index $43 of the $A000 jump table (see $B7F6).
N $BA23 Handler for index $44 of the $A000 jump table (see $B7F6).
c $BA23
N $BA25 Handler for index $45 of the $A000 jump table (see $B7F6).
N $BA2B Handler for index $46 of the $A000 jump table (see $B7F6).
c $BA25
c $BA2B
C $BA2F,3 Compute angle from object IX to target IY
C $BA43,3 Pseudo-random number generator
N $BA43 Handler for index $47 of the $A000 jump table (see $B7F6).
C $BA4F,3 Pseudo-random number generator
N $BA4F Handler for index $48 of the $A000 jump table (see $B7F6).
c $BA43
c $BA4F
c $BA5F
C $BA63,2 Exit if wave counter is zero
C $BA65,3 Scan 8-slot bitmap at $9B4F for first free (zero) slot
C $BA74,2 Compute slot index (8-B)
C $BA77,3 Store slot index at $BB55
C $BAAF,3 Pop head of free-object list ($9D1C)
C $BAB5,4 Save SP (self-modified operand, restored below)
C $BAC2,4 Store allocated object pointer at $BBB4
C $BAC6,3 Restore SP
c $BBC2 Clear buffers at $7F00-$7FFF and $8000-$80FF (fast PUSH fill)
N $BBC2 Called once per frame from the main loop ($A10F). Fills 256 bytes at $7F00 then 256 bytes at $8000 with DE ($0000), using the SP-trick PUSH-unroll pattern (B=$10 outer, 8 PUSHes/inner) shared with other fast fill routines in this game.
C $BBC2,3 DE=$0000 (fill value)
C $BBC5,5 Point HL/B at first buffer ($7F00, 16 groups of 8)
C $BBCA,3 Fill first buffer, then set up second buffer ($8000)
C $BBD2,4 SP-trick: save caller's SP, point SP at fill destination
C $BBD7,8 Unrolled PUSH DE x8, looped B times
C $BBE1,3 Restore SP and return
c $BBE5 Mark active objects into the attribute-buffer collision mask
N $BBE5 Called every interrupt from $A0C4. Iterates the object list at $9D30 (B = $06 minus the count at $9D19; falls straight to $BC79 if none remain - the branch corrupted by POKE 48115,58/Immunity). For each object: E is set to C if (IY+$05)==$03, else 0; a row is computed from the object's Y (IY+$0D/$0E, then IY+$0B/$0C), and E is ORed into that row across the $7Exx/$7Fxx attribute buffers ($BC35/$BC3D continue the row loop started here). The object's bit is then stored at IY+$14 and C is rotated left (RLC C) so each object gets a distinct single-bit identifier for the next pass.
C $BBE5,4 Save SP (restored via the $7E-page LD SP tail)
C $BBE9,4 IY = object list head ($9D30)
C $BBED,6 B = 6 - active object count ($9D19)
C $BBF3,3 POKE 48115,58 corrupts this JP Z, disabling the damage/collision branch (Immunity)
C $BBF9,10 E = object's mask bit only when type (IY+$05) is 3
C $BC05,13 Compute $7Exx attribute-row address from object Y (IY+$0D/$0E)
C $BC12,3 OR mask bit into this attribute row
N $BC79 Entry point reached from $BBE5's mask-draw loop; also entered directly when POKE 48115,58 (Immunity) forces the mask byte to $80, skipping the normal per-object bit rotation (RLC C) at $BC71 and disabling the damage/collision branch.
c $BC7D
C $BC7D,3 Row offset from object Y (IY+$0D/$0E)
C $BCAA,2 Switch to second attribute page ($7Fxx)
C $BCAC,3 Row offset from object Y (IY+$0B/$0C)
C $BCD9,3 Restore SP
C $BCE0,1 Exit if no objects to process ($9D19 counter is zero)
c $BCE9 Draw active objects' collision masks into attribute buffer
N $BCE9 Called every interrupt from $A0C4 and $A8E8. Iterates the object linked list (via $9D18/EXX, same list style as $BC7D/$BBE5), and for each object with the right IY+$04 status bits, computes an attribute row from its Y position (IY+$0D/$0E and IY+$0B/$0C) and ORs a variable-height mask (row count from IX-$01/IX-$02) into the $7Exx/$7Fxx attribute buffers - building the per-object hit/collision mask consumed elsewhere.
C $BCE9,4 Save SP (restored at $BD7F)
C $BCF2,2 Skip row/page setup if flag at $9C70 is zero
C $BD17,2 No objects to draw: skip to cleanup
C $BD22,2 Skip normal draw path if IY+$04 bit 3 is set
C $BD2A,2 Skip mask draw if IY+$04 bit 0 is set
C $BD30,2 Skip mask draw unless IY+$04 bit 5 is set
C $BD49,2 Clamp row start if carry
C $BD76,2 Next object
C $BD7F,3 Restore SP
c $BD99 Update randomized countdown, then enter player update ($BDAE)
C $BD99,3 Pseudo-random number generator
C $BDAE,7 flip and mask border colour bits at $9C33/$9C34, output to port $FE
C $BDB9,10 load player object pointer into IY, save previous IY
C $BDC6,4 branch on object state flag bit 2
C $BDCC,9 self-loop: advance frame counter, run per-frame update at $A052
C $BDD7,4 branch on respawn/blink flag bit 7
C $BDDD,10 count down respawn blink timer
C $BDE7,10 advance blink phase, loop
C $BDF6,3 count down remaining blink cycles
C $BDFB,6 clear blink state, resume normal update
N $BE01 Handler for index $2A of the $A000 jump table (see $B7F6).
N $BE02 Handler for index $29 of the $A000 jump table (see $B7F6).
C $BE03,7 skip movement if immobilised flag at $9C3B set
N $BE03 Handler for index $2B of the $A000 jump table (see $B7F6).
C $BE0A,15 count down invulnerability timer, refresh sprite frame when it expires
C $BE1C,3 Start object explosion sequence
C $BE20,5 check immunity flag at $9C6B
C $BE25,2 POKE 48677,24 forces unconditional JR, disabling damage call (Immunity alt)
C $BE27,3 Handle player hit
C $BE2B,3 Read input
C $BE2E,8 decode horizontal direction bits from input (Kempston layout: bit 0=Right, bit 1=Left)
C $BE36,2 no horizontal input: skip straight to vertical/banking step
C $BE38,9 load X position, DE=step distance $0060
C $BE41,3 shift Right bit into carry; assume bank-right target (B=2)
C $BE44,2 if Right held, branch to add step ($BE4C)
C $BE46,4 Left held: bank-left target (B=0), subtract step
c $BE01 Player frozen: unwind an extra call level, then no-op
c $BE02 Player idle: no-op
c $BE03 Player: skip movement if immobilised, else read input and move
c $BE4A Clamp player position to screen bounds, update bank animation
N $BE4A Clamps the player object's X position ($IY+0B/0C) between $0700 and $18E0, then its Y position (IY+0D/0E) between $0300 and $18E0, then steps a "bank angle" frame (IY+16, target IY+17) toward its target by 1 per call (with a short delay after a direction change) and looks up the resulting sprite frame from a table at $9B4C. Entered from $BE2E/$BE4C with B already set to the bank-frame target: 2 if Right is held (X increasing), 0 if Left is held (X decreasing), 1 if neither (level flight, no X movement) - this is the actual Left/Right-to-plane-tilt conversion.
C $BE4A,2 entry: X delta already applied, skip add
C $BE4C,1 entry: add X delta (HL+=DE)
C $BE4D,6 check X within left bound
C $BE53,5 clamp X to left edge ($0700)
C $BE58,4 check X within right bound
C $BE5C,3 clamp X to right edge ($18E0)
C $BE5F,6 store clamped X position
C $BE65,8 save frame-select param; decode vertical direction bits
C $BE6D,2 skip vertical move if no direction bit set
C $BE6F,9 load Y position, DE=step size
C $BE78,3 check vertical direction bit
C $BE7B,4 move up
C $BE7F,1 move down
C $BE80,6 check Y within top bound
C $BE86,5 clamp Y to top edge ($0300)
C $BE8B,4 check Y within bottom bound
C $BE8F,3 clamp Y to bottom edge ($18E0)
C $BE92,6 store clamped Y position
C $BE98,7 read current bank frame; check banking-in-progress flag
C $BE9F,2 skip if already banking
C $BEA1,5 no bank change needed if already at target
C $BEA6,8 start banking, set delay timer=5
C $BEAE,5 count down bank-delay timer
C $BEB3,10 clear banking flag; compare target vs current bank
C $BEC0,7 step current bank frame toward target by 1
C $BEC7,6 index sprite-frame table by bank value
C $BECD,3 store new sprite frame
C $BED0,3 Use bomb
C $BEF7,3 Compute angle from object IX to target IY
C $BEFC,3 Compute velocity vector (dx,dy) from angle and speed
C $BEFF,3 Apply object velocity (dx,dy) to position
C $BF1E,3 Ratchet player state forward
c $BF22 Handle player hit: switch to hit/explosion animation, arm recovery timer
R $BF22 IY player object base (inherited from $BDAE's caller)
N $BF22 Called from $BDAE right after the immunity flag check fails (both immunity POKEs disable that call). Tags the object at $9C77 (the thing that hit the player) with the current wave/formation id from $9BA4, then repoints the player's per-frame update-routine pointer (IY+2/+3, little-endian) to $6B86 - the hit/explosion animation handler, same pointer-swap trick used by $C5AF for enemies - and arms a 38-frame ($26) timer at $9C3C, presumably the death/respawn delay.
C $BF22,4 IX = object that hit the player
C $BF26,6 tag it with current wave/formation id
C $BF2C,8 arm hit-reaction timer; point player's per-frame handler at $6B86...
C $BF34,8 ...(hit/explosion animation); set visual state
C $BF3C,5 arm 38-frame recovery/death timer at $9C3C
C $BF41,1 return
c $BF42 Use bomb: consume inventory, trigger flash effect
N $BF42 Triggered when the input state at $9CDC equals $09. Decrements the player's bomb count (IX+9, confirmed via $66DE), sets bit 2 of the deferred-event mask $9C27, adds to a bonus accumulator ($9C70), and points the screen-flash sequence pointer $9C5B at $9C5E - the same mechanism $6A88 and $C72A use for the corner-box/screen flash. Once the input state reaches exactly 1 (key released), it also allocates a new object from the free-list pool ($9D1C, same trick as $C559), copies initial fields from a spawn-parameter data table at $6BB9 (BC points there; NOT a code handler), and positions it at the player's location (from IY+0D/0E) - spawning the actual bomb-explosion object.
C $BF46,4 Trigger only when input state ($9CDC) is $09
C $BF54,3 Consume one bomb (IX+$09)
C $BF5A,2 Request the screen-flash deferred event ($9C27 bit 2)
C $BF6B,2 Spawn only once input state reaches 1 (key released)
C $BF71,3 BC = spawn-parameter table $6BB9
C $BF75,7 DE = per-type spawn data ($9C73); B = object count
C $BF7F,11 Skip spawn if the object pool is full (difficulty $9C72 vs $9D19)
C $BF8C,12 Pop a free object slot ($9D1C)
C $BFB9,13 Position new object at the player (IY+$0D/$0E)
C $BFC6,17 Copy velocity/offset fields from spawn data
C $BFE0,2 Next object
C $BFE2,3 Restore SP
C $BFE7,3 Request sound effect if higher priority than current
N $BFEB Handler for index $2C of the $A000 jump table (see $B7F6).
C $BFFE,3 Start object explosion sequence
C $C002,3 Apply object velocity (dx,dy) to position
C $C011,3 Mark formation slot done, trigger completion effect when group empties
N $C015 Handler for index $36 of the $A000 jump table (see $B7F6).
C $C020,3 Compute velocity vector (dx,dy) from angle and speed
C $C023,3 Apply object velocity (dx,dy) to position
C $C02A,3 Apply object velocity (dx,dy) to position
C $C045,3 Start object explosion sequence
C $C04D,3 Mark formation slot done, trigger completion effect when group empties
N $C051 Handler for index $2D of the $A000 jump table (see $B7F6).
N $C075 Handler for indices $2E, $2F of the $A000 jump table (see $B7F6).
C $C075,3 Movement-pattern script interpreter
C $C088,3 Mark formation slot done, trigger completion effect when group empties
C $C0AB,3 Pseudo-random number generator
c $BFEB Check for bullet hit, start explosion
c $C015 Launch and move projectile; explode on hit
N $C015 On first call (IY+10 != $FF) computes a launch velocity via $B8A2 from angle IY+10/speed IY+11, then marks IY+10=$FF so it only fires once. Every call then moves the object via $BA0A. If flag bit 5 of IY+4 is set and IY+14 indicates a hit (bit 7 set, not bit 6), sets the global hit flag at $9C6B and starts an explosion via $C5AF; otherwise, once flag bit 5 is clear, retires the object and signals formation completion via $B79F.
c $C051 Move straight down at fixed speed; advance animation frame
C $C051,8 add fixed step $20 to Y position low byte
C $C059,5 carry into Y position high byte
C $C05E,6 advance animation frame, check wrap at 16
C $C064,2 branch when frame wraps
C $C066,4 store frame, return
C $C06A,6 load pointer stored at IY+15/16
C $C070,4 increment counter at that pointer, notify $B7A3
C $C074,1 return
c $C075 Multi-hit enemy: take damage, retire after hit counter (IY+12) expires
N $C075 On each hit (IY+14 nonzero), ORs it into the global hit-flag $9C6B and decrements a per-object hit counter at IY+12; the object only dies once that counter reaches zero (unlike $C015's one-hit projectile). Also handles retirement via $B79F when the "alive" flag (bit 1 of IY+4) or "dying" flag (bit 4) indicate the object is done.
C $C0D6,3 Add BCD score value to current player's score
C $C0DC,3 Start object explosion sequence
C $C106,3 Enemy fire-decision timer and heading steering
C $C10A,12 step sprite frame (IY+6), 8-direction wrap, mirrored via IY+4 bit 7
N $C11C Handler for index $35 of the $A000 jump table (see $B7F6). Runs the movement script, then handles retirement (IY+4 bit 1 -> $C191/$B79F). On a hit (IY+14 nonzero), decodes a variable damage amount from it via 6 rotate/add steps into E, ORs the hit flag into the global $9C6B, and subtracts the damage from health (IY+12); once health goes negative it awards a score bonus ($66B5) and explodes ($C5AF). Otherwise falls through to $C16E, which handles fire timing and 8-direction sprite-frame selection from the aim angle (IY+0F/+10).
c $C11C Scripted-movement enemy: take variable damage, explode when destroyed
C $C11C,3 Movement-pattern script interpreter
C $C164,3 Add BCD score value to current player's score
C $C16A,3 Start object explosion sequence
C $C18D,3 Enemy fire-decision timer and heading steering
C $C195,3 Mark formation slot done, trigger completion effect when group empties
N $C199 Handler for indices $32, $33, $3A of the $A000 jump table (see $B7F6).
c $C199 Multi-hit enemy: move straight down, take damage
N $C199 Runs the movement script, retires if the "alive" flag (IY+4 bit 1) is set. Otherwise moves straight down ($0020/frame, same as $C051) and retires once past a Y boundary ($1C). On a hit (IY+14, masked to 7 bits), ORs it into the global hit flag $9C6B and decrements health (IY+12); once health reaches zero, checks a secondary counter (IY+1A, cp $08) suggesting a multi-stage/multi-hit-phase enemy - not fully traced.
C $C199,3 Movement-pattern script interpreter
C $C1DA,3 Add BCD score value to current player's score
C $C1E1,3 Add BCD score value to current player's score
C $C1E7,3 Start object explosion sequence
C $C1EF,3 Mark formation slot done, trigger completion effect when group empties
C $C213,3 Enemy fire-decision timer and heading steering
N $C217 Handler for index $37 of the $A000 jump table (see $B7F6).
C $C217,3 Movement-pattern script interpreter
C $C26D,3 Add BCD score value to current player's score
C $C273,3 Start object explosion sequence
C $C279,3 Add BCD score value to current player's score
C $C294,3 Enemy fire-decision timer and heading steering
N $C298 Handler for index $34 of the $A000 jump table (see $B7F6).
c $C217 Movement handler $37: run movement script, then advance and act on IY+$14 flags
R $C217 IY object struct base (status IY+$04 bit 1, Y at IY+$0D/$0E, action flags IY+$14)
N $C217 Handler for index $37 of the $A000 jump table. First calls $B8F9 to run the object's movement-pattern script. Unless status flag IY+$04 bit 1 is set, advances Y (IY+$0D/$0E) by $20 like the other movement handlers ($C298/$C31A/$C359/$C388), then decodes the IY+$14 action byte into a steering/target angle stored at $9C6C.
c $C298 Movement handler $34: advance object down-screen, then act on IY+$14 flags
R $C298 IY object struct base (Y at IY+$0D/$0E, action flags IY+$14)
C $C2F2,3 Add BCD score value to current player's score
C $C2F8,3 Start object explosion sequence
C $C2FE,3 Add BCD score value to current player's score
C $C30C,3 Mark formation slot done, trigger completion effect when group empties
C $C310,3 Enemy fire-decision timer and heading steering
N $C31A Handler for index $31 of the $A000 jump table (see $B7F6).
C $C342,3 Add BCD score value to current player's score
C $C355,3 Mark formation slot done, trigger completion effect when group empties
N $C359 Handler for index $39 of the $A000 jump table (see $B7F6).
C $C384,3 Mark formation slot done, trigger completion effect when group empties
N $C388 Handler for index $38 of the $A000 jump table (see $B7F6).
C $C3B2,3 Add BCD score value to current player's score
C $C3C3,3 Mark formation slot done, trigger completion effect when group empties
N $C3C7 Handler for index $30 of the $A000 jump table (see $B7F6).
c $C31A Movement handler $31: advance object down-screen; on flag, score and mark progress
R $C31A IY object struct base (Y at IY+$0D/$0E, action flag IY+$14 bit 7)
c $C359 Movement handler $39: advance object down-screen; on flag, bump IX+$03
R $C359 IY object struct base (Y at IY+$0D/$0E, action flag IY+$14 bit 7)
c $C388 Movement handler $38: advance object down-screen; on flag, score and mark completion
R $C388 IY object struct base (Y at IY+$0D/$0E, action flag IY+$14 bit 7)
c $C3C7 Movement handler $30: angle-steered weave with edge bounce, velocity apply
R $C3C7 IY object struct base (column IY+$0C, angle IY+$10, direction-rate IY+$15, speed IY+$11, action flag IY+$14 bit 7)
N $C3C7 Handler for index $30 of the $A000 jump table. Outside a central column band (IY+$0C-6 not in 0-$14), flips the direction-rate sign (IY+$15) and mirrors the angle target ($20-(IY+$10), masked to 0-$3F) - an edge-bounce for a zigzag/weaving movement. Advances angle (IY+$10) by the direction-rate, computes velocity via $B8A2 and applies it via $BA0A. If the action flag (IY+$14 bit 7) is set, scores +5, conditionally bumps the wave counter $9C68 and the explosion-data pointer $9C73 (13-byte stride, see $A612), then joins the plain down-screen-advance tail shared with $C388/$C298/$C31A/$C359.
C $C3F0,3 Compute velocity vector (dx,dy) from angle and speed
C $C3F3,3 Apply object velocity (dx,dy) to position
C $C402,3 Add BCD score value to current player's score
C $C438,3 Mark formation slot done, trigger completion effect when group empties
c $C43C Enemy fire-decision timer and heading steering
R $C43C IY enemy object struct base (status IY+$04, target ref IY+$1A, heading IY+$1C)
N $C43C Decrements the shared randomized-reload timer at $9C42 (reloaded from $9C43 on expiry - same mechanism as $BD99). Once expired, checks activity flags (IY+4 bits 0 and 5) and a target reference (IY+1A, $FF = no target), computes an aim angle via $B845 toward the target (IX=($9C6D)), then turns the enemy's current heading (IY+1C) toward that angle by a rate-limited step (clamped to +-4) rather than snapping directly to it - a homing/steering behaviour.
C $C459,3 Compute angle from object IX to target IY
C $C4A6,3 Pseudo-random number generator
C $C538,3 Pseudo-random number generator
c $C559 Allocate object from free-list pool and initialize
N $C559 Pops a free object slot from the linked list at $9D1C (pushing the previous head onto a secondary stack at $9D30), then initializes its struct: per-frame handler pointer -> $6B42, state flags, default position, and stores the new object's address into $9C6D - the same field $C43C reads as its aim/steering target. Looks like the enemy-bullet or enemy-spawn allocator.
C $C559,4 Save caller's SP (restored at $C56F)
C $C55D,7 Pop free-list head ($9D1C) into IX
C $C567,8 Push old head onto secondary stack ($9D30)
C $C572,8 Clear status, set "active" bit 2
C $C57A,4 Per-frame handler pointer -> $6B42
C $C59E,4 Default column (IX+$0C=$10)
C $C5A6,4 Default row (IX+$0E=$16)
C $C5AA,4 Publish object as current aim target ($9C6D)
c $C5AF Start object explosion sequence
R $C5AF IY object struct base
R $C5AF D,E position offset for the explosion
N $C5AF Sets the object's per-frame update-routine pointer (IY+2/+3, little-endian) to $6BCA and initializes state fields IY+5/IY+6, then resets two global countdown/growth values at $9C35 and $9C39. Called by 7 different enemy/object update routines (BDAE, BF42, C0B2, C168, C1E0, C1E8, C2D6), very likely the shared "object destroyed, switch to explosion animation" entry point. $6BCA itself and the exact role of $9C35/$9C39 not yet traced.
C $C5AF,8 point object's per-frame handler at $6BCA
C $C5B7,8 init state fields IY+5=4, IY+6=8
C $C5BF,6 store caller's position offset (D,E) into object struct
C $C5C5,6 reset global timer/counter $9C35
C $C5CB,6 reset global timer/counter $9C39
C $C5D1,1 return
c $C5D2
C $C5D6,3 Set object position from $9C01, clamp column (IY+$0C) to 8-24
C $C5EE,3 Set object position from $9C01, clamp column (IY+$0C) to 8-24
C $C5F3,3 Add BCD score value to current player's score
C $C619,3 Pseudo-random number generator
C $C635,3 Set object position from $9C01, clamp column (IY+$0C) to 8-24
c $C648 Decrement wave-group counter; trigger group-clear bonus when it hits zero
N $C648 Called from $B79F when a formation slot finishes. Decrements the wave-group counter at $9C68; while nonzero, falls through into $C5EE (per-kill score/bonus handling). Once it reaches zero, reloads it from $9C72 and sets up a bonus-animation script on IY (pointer $6B97, duration fields), choosing between two outcomes based on IY+$0C vs $12.
c $C680 Scroll background (periodic LDDR shift, gated by counter $9C2A)
N $C680 Called every frame from $A0C4. Decrements counter $9C2A; every 3rd call ($9C2A reloaded to 3) it shifts two 15-byte blocks ($850E-$851D and $851E-$852D) backward by one byte via LDDR - the periodic scroll-step mechanism for the background graphics.
c $C6A6 Screen wipe transition effect (colour set in $9C59)
R $C6A6 none; uses colour from $9C59 (set by caller beforehand)
N $C6A6 Diamond/cross wipe: repeatedly paints a full-height column and full-width row on each side of screen centre, growing outward frame by frame, using $C6D3 (fill column) and $C6EB (fill row) with the attribute byte at $9C59. All callers set $9C59 to the desired colour just before calling this.
C $C6A6,2 wait ~18 frames before starting wipe
C $C6A8,3 loop: wait 18 frames
C $C6AB,3 wait one more frame; init centre offset
C $C6AE,3 Fill screen attribute row with colour from $9C59
C $C6B1,1 B = wipe step count
C $C6B2,1 save loop counter
C $C6B3,4 compute column right of centre, wait a frame
C $C6B7,3 Fill screen attribute column with colour from $9C59
C $C6BA,4 mirror to column left of centre
C $C6BE,3 Fill screen attribute column with colour from $9C59
C $C6C1,4 restore counter, compute row below centre
C $C6C5,3 Fill screen attribute row with colour from $9C59
C $C6C8,4 mirror to row above centre
C $C6CC,3 Fill screen attribute row with colour from $9C59
C $C6CF,3 repeat, shrinking step outward
C $C6D2,1 return
c $C6D3 Fill screen attribute column with colour from $9C59
R $C6D3 A screen column (7-24 valid, else no-op)
c $C6EB Fill screen attribute row with colour from $9C59
R $C6EB A row/column offset (encodes screen position)
C $C6EC,3 Rotate position code into attribute-row high bits
C $C6F8,3 Form attribute-area address in $58xx
C $C6FD,4 Set up LDIR: dest = src+1, length 17
C $C701,4 Load fill colour from $9C59
C $C705,2 Propagate colour across the row (18 cells)
c $C709 Fill entire attribute screen with colour A (fast SP-push fill)
R $C709 A attribute colour
C $C709,4 Save caller's SP (restored at $C726)
C $C70F,2 A = 23 row groups to fill
C $C711,3 HL = attribute area start ($5819)
C $C717,1 Point SP at this row for the PUSH fill
C $C718,9 Fast fill: 9x PUSH BC (18 attribute bytes)
C $C721,2 Advance HL to next row ($20 stride)
C $C723,3 Loop 23 rows
C $C726,3 Restore SP
c $C72A Animate active player's indicator box colour
N $C72A Called every interrupt from $A0C4. Reads the next colour byte from a repeating sequence (pointer $9C45, reset via $9C44/$9C47 on terminator $FF), then applies it to the active player's corner box ($58C4 or $58DA, chosen via $9C76) - the same corner boxes highlighted (statically) by $6A88's credits screen.
C $C75A,3 read next full-screen flash colour byte (sequence $9C5B, set by $6A88)
C $C76E,3 Fill entire attribute screen with colour A
c $C772
C $C772,3 Configure $C772 mover
C $C775,4 Save caller's SP
C $C779,3 SP=$F6D1: fast POP-based read pointer into source data
C $C782,3 Stash E in shadow A', A=D (destination page high byte)
C $C785,9 Patch destination high byte into 3 self-modified store targets ($C7A0/$C7BC/$C7D8)
C $C78E,2 EXX: switch to shadow registers for the unroll loop
C $C790,2 E=$18: outer pass counter
C $C792,2 Inner unroll count B=$06 (6x3 stores per pass)
C $C799,4 Save source read pointer (SP) before switching back
C $C79D,1 SP=HL: point stack at destination write area
C $C79E,1 EXX: back to normal registers for the unrolled store sequence
C $C80A,14 Advance the 3 self-modified destination operands by 8
C $C81A,1 Next row-group
C $C81B,3 Loop back into the unrolled mover body
C $C81E,3 Done: restore SP
C $C821,3 Reset $C772 mover body opcodes to INC H
c $C825 Configure $C772 mover: set fill displacement, patch 3 body opcodes to EX DE,HL
N $C825 Patches the IX-displacement operand at $C846 from the frame-indexed table ($9C02 + $9C00 mod 8), then via the shared tail writes $EB (EX DE,HL) into three opcode slots ($C7A1/$C7BD/$C7D9) in $C772's unrolled store body.
C $C828,3 Frame counter $9C00 mod 8
C $C830,2 Index byte table at $9C02
C $C832,3 Patch fill-loop IX displacement operand ($C846)
C $C835,2 A=$EB (EX DE,HL opcode)
c $C839 Reset $C772 mover body opcodes to INC H
N $C839 Alternate entry to $C825's tail: writes $24 (INC H) into the three opcode slots instead of $EB.
C $C839,2 A=$24 (INC H opcode)
C $C83B,5 Set up 3-slot patch loop (stride $1C from $C7A1)
C $C844,3 Write opcode into this store-body slot
C $C847,2 Advance to next slot (+$1C)
C $C849,2 Loop 3 slots
c $C84C Build wrapped scroll-window row into $F6D1 buffer
N $C84C Called every interrupt from $A0C4. Source is the circular scroll buffer: base pointer ($9BF9)+$0024 plus a wrap count derived from the scroll offset at $9BF8. Copies up to 24 bytes via LDI into $F6D1, and if the window runs past the buffer end, continues the remaining bytes from the wrap point at $FA79 (the same circular buffer filled by $6498). The resulting $F6D1 row is consumed by $C772's fast attribute mover.
C $C84C,10 HL = scroll-window source pointer, DE = dest $F6D1
C $C859,9 C = scroll offset, B = bytes remaining before wrap ($18-offset)
C $C8AE,9 Wrap: continue remaining bytes from buffer start $FA79
c $C8B8
C $C8BD,2 Test for 8th frame (mod-8 wrap)
C $C8C7,2 Only continue every 8th call
C $C8CC,2 Mark deferred event bit 3 pending
C $C8D2,2 Toggle ping-pong buffer selector
C $C8DC,2 Select this pass's ping-pong buffer
C $C8EB,2 Copy 18-byte row into staging buffer $9BD4
C $C8ED,3 Decode next column's tile data into ping-pong buffer
c $C941 Decode next column's tile data into ping-pong buffer
N $C941 Called from $C8B8 every 8th frame. If the column-ready flag ($9BA2 bit 5) is clear, first calls $C981 to scan/spawn enemies from the previous column. Then decodes 9 map cells from the column-source pointer ($9BA9) into the ping-pong buffer at $9BB0: each cell byte indexes the four 2x2 tile-block tables at $7900-$7CFF (see $7900), and the four resulting character codes are stored as top pair ($7900/$7A00 -> IX+0/IX+1, row A) and bottom pair ($7B00/$7C00 -> IX+$12/IX+$13, row B). So the 9 cells expand to two 18-char column rows. Advances the source pointer ($9BA9) and bumps a level-progress counter ($9BAD) clamped at $1C.
C $C944,2 Check "column ready" flag before advancing
C $C946,3 Scan incoming column for spawn markers and allocate enemy objects
C $C954,1 Start of 9-entry decode loop
C $C969,4 Advance to next buffer entry (IX+=2)
C $C972,2 Loop 9 times
C $C97B,2 Clamp progress counter at $1C
C $C97D,1 Stop if counter already at max
c $C981 Scan incoming column for spawn markers and allocate enemy objects
N $C981 Called from $C941 when the "column ready" flag ($9BA2 bit 5) is clear. Scans 9 entries of the newly-decoded column buffer ($9BA9, stride $10) for spawn markers $05/$55; for each match, calls $BA5F to allocate an object slot (D = entry offset, used there as the enemy's row/type), and marks the column byte $33 ("spawned") once allocated - or leaves the marker in place if $BA5F found no free slot (carry set).
C $C984,2 Skip if column-ready flag already set
C $C98F,2 Check for spawn marker $05
C $C993,4 Check for spawn marker $55; skip entry if neither
C $C99E,3 Call $BA5F to allocate an object slot (D = row/type)
C $C9A3,2 Skip if no free slot was found (carry set)
C $C9A5,2 Mark column byte as already spawned ($33)
C $C9AC,2 Loop 9 entries
c $C9AF Advance enemy timeline: fire due entries and dispatch their commands
N $C9AF Called every frame from $A0C4. Every 16th tick, advances the level-progress counter ($9BA4) and processes all timeline entries whose trigger byte matches it: each 3-byte entry [trigger, param D, command] either dispatches a special command ($FB-$FE) or, for any other value, treats it as a formation tag and spawns via $C9E4/$BA5F. Ends the frame's processing at the first non-matching or $FF entry. See docs/Level-Format.md.
C $C9AF,3 POKE 51631,201 patches entry to RET, disabling this routine (No Enemies)
C $C9B3,4 Advance tick counter mod 16; act only every 16th tick
C $C9BB,1 Advance level-progress counter ($9BA4)
C $C9BD,3 Point at current timeline entry ($9BA5)
C $C9C1,4 End of table when trigger byte is $FF
C $C9C8,3 Fire only when progress counter matches the trigger byte
C $C9CB,8 Read param D and command byte; advance past 3-byte entry
C $C9D3,4 Command $FC: reset $9D1B
C $C9D7,4 Command $FE: set $9C3B=$FF
C $C9DB,4 Command $FD: bump counter $9C69
C $C9DF,4 Command $FB: screen/timing poke ($5B56/$C2E1)
C $C9E3,1 Else: command byte is a formation tag (falls into $C9E4)
b $CA09
b $CA60
t $CA65
b $CA68
t $CAF8
b $CAFB
t $CBCF
b $CBD3
t $CC84
b $CC87
t $CD4A
b $CD4D
t $CD53
b $CD56
t $CD91
b $CD97
t $CDB0
b $CDB3
t $CDC6
b $CDC9
t $CDF6
b $CDFA
t $CE23
b $CE26
t $CE37
b $CE3B
t $CE5D
b $CE60
t $CE66
b $CE69
t $CE9A
b $CE9F
t $CED6
b $CED9
t $CEE6
b $CEE9
t $CEEE
b $CEF2
t $CEFF
b $CF02
t $CF24
b $CF27
t $CF76
b $CF79
t $CFA0
b $CFA3
t $CFF5
b $CFF8
t $D101
b $D105
t $D334
b $D338
B $D4BE,1,1 POKE 54462,201 overwrites this data byte (not code); effect on lives unconfirmed
t $D55D
b $D560
t $D574
b $D579
t $D5B0
b $D5B5
t $D5E5
b $D5E8
t $D683
b $D687
t $D6C8
b $D6CB
t $D732
b $D736
t $D777
b $D77A
t $D7EE
b $D7F1
t $D80D
b $D810
t $DA31
b $DA34
t $DBC9
b $DBCC
t $DE6C
b $DE6F
t $DE72
b $DE76
t $DEE5
b $DEE8
t $DEEC
b $DEEF
t $DF2A
b $DF2D
t $DF34
b $DF37
t $E14E
b $E151
t $E1AD
b $E1B1
t $E1DD
b $E1E0
t $E22E
b $E231
t $E3E2
b $E3E5
t $E3E8
b $E3EB
t $E5F5
b $E5F9
t $E641
b $E644
t $E73A
b $E73E
t $E748
b $E74B
t $E750
b $E754
t $E7DB
b $E7DE
t $E7EE
b $E7F1
t $E858
b $E85B
t $E874
b $E879
t $E8D6
b $E8D9
t $E8F7
b $E8FA
t $E96F
b $E972
t $EA6D
b $EA70
t $EAB3
b $EAB7
t $EABD
b $EAC0
t $EAC1
b $EAC4
t $EAC9
b $EACC
t $EB75
b $EB78
t $EBAB
b $EBAE
t $ED93
b $ED96
t $EDB2
b $EDB6
t $EDC6
b $EDC9
t $EDF4
b $EDF7
t $EDFD
b $EE00
t $EE03
b $EE06
t $EE09
b $EE0C
t $EE0F
b $EE15
t $EE1E
b $EE21
t $EE5B
b $EE5F
t $EE60
b $EE64
t $EE65
b $EE69
t $EE6A
b $EE6E
t $EE77
b $EE7B
t $EE7C
b $EE80
t $EE81
b $EE85
t $EE86
b $EE8A
t $EE93
b $EE97
t $EE98
b $EE9C
t $EE9D
b $EEA1
t $EEA2
b $EEA6
t $EF17
b $EF1B
t $F05E
b $F062
t $F07C
b $F07F
t $F0B7
b $F0BB
t $F148
b $F14B
t $F179
b $F17C
t $F199
b $F19C
t $F1A1
b $F1A4
t $F1BB
b $F1BE
t $F237
b $F23A
t $F24F
b $F253
t $F297
b $F29B
t $F2BF
b $F2C3
t $F2E4
b $F2E7
t $F2F1
b $F2F4
t $F39B
b $F39F
t $F42F
b $F434
t $F46D
b $F473
t $F47F
b $F482
t $F4DF
b $F4E9
t $F4EE
b $F4F1
t $F519
b $F51E
t $F5D7
b $F5DC
t $F5DD
b $F5E0
t $F61D
b $F620
t $F65E
b $F662
t $F6F3
b $F6FB
t $F735
b $F73B
t $F881
b $F884
t $F8DE
b $F8E1
t $F913
b $F917
t $F93D
b $F940
t $F97B
b $F97E
t $F983
b $F986
t $F9E3
b $F9E6
t $F9E9
b $F9EC
c $FDFD IM2 interrupt trampoline and vector table
N $FDFD The IM2 vector register I=$FE, so every interrupt reads the word at $FDFD/$FDFE. $FDFD holds a JP opcode ($C3, planted by $7D00), so the CPU executes JP $A0B0 (the ISR). $FE00 onward is the vector table itself, filled with $FD by $7D00 so every table entry points back here to $FDFD; it continues past this block's end ($FE7B) up to $FFFF.
C $FDFD,3 => Interrupt handler
b $FE00
W $FE00,256,8 Interrupt vector table: all vectors resolve to $FDFD
b $FF00
t $FFC4
b $FFE0
