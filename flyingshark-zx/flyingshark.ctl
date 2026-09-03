@ $5B00 org
b $5B00 Movement-script entry-point table (41 entries, half-byte-offset into $5BAF)
N $5B00 Read by #R$BB62's object-init tail using a byte read from the fixed-slot address (template bytes 7/8, see #R$5B55) as index - not from the template directly. The resulting byte is doubled and added to $5BAF to give a byte offset into the shared movement-script bytecode pool there, stored at IX+$15/$16 as the script start address (the field #R$B94E reads scripts from). Values are strictly ascending ($00-$89, i.e. real offsets 0-274) - stored halved so a single byte can address the whole pool. Scripts are variable-length (no fixed record size), so consecutive entries aren't evenly spaced. Since the index comes from a live fixed-slot byte rather than a template constant, the chosen script can vary at runtime.
b $5B29 Formation-tag to group-index lookup table (44 entries, indexed by tag & $3F)
N $5B29 Indexed by #R$BA5F from the spawn-timeline's tag byte (C, masked to bits 0-5, though only 44 entries are populated); each entry is a group index used to look up the per-group spawn budget in the table at $5CF4. Values are strictly ascending ($00-$FB), consistent with a byte-offset/threshold table rather than raw group indices.
b $5B55 Spawn-template table (9 bytes/entry, indexed by #R$BA5F as index*9 + $5B55)
N $5B55 Each 9-byte template initializes a newly-spawned object (field mapping confirmed by matching self-modified write targets to their instruction operands in #R$BB62's init block): byte 0 -> IX+$05; byte 1 -> IX+$12; byte 2 -> IX+$1A; byte 3 (+difficulty offset $9C41, clamped) -> IX+$1B; byte 4 -> IX+$11; bytes 5/6 (little-endian) -> IX+$02/$03; bytes 7/8 (little-endian) -> a fixed-slot address ($9D1E/$9D24/$9D2A, one of #R$B730's 4 persistent object slots - $9D30 never observed). IX+$02/$03 is NOT a code pointer despite resembling one: every one of the 10 templates' values resolves exactly to either a record on the #R$6B42 17-byte descriptor grid ($6B42+17*n - $6BCA=record 8, $6B64/$6B75/$6B86/$6BA8=records 2/3/4/6) or an entry in the #R$6BDB 6-byte explosion/state-descriptor table ($6BDB+6*n - $6BDB/$6BF9/$6BFF/$6C05=entries 0/5/6/7); $6B42's own IY+$02/$03 field is itself something #R$7DC9 *writes* (a decoded graphics sub-pointer) rather than executable code, and the raw bytes at these addresses don't decode as coherent Z80. So IX+$02/$03 is an index/pointer into one of two shared descriptor-record tables, read as data by an as-yet-unlocated per-object routine, not called as a handler. Bytes 7/8's address is used twice: #R$BB62 reads one byte from it to select the object's movement script (see #R$5B00), and after all objects for this call are spawned, a word at that address is read, swapped via EX (SP),HL, and written back - apparently linking the slot to the newly-spawned object(s), exact mechanism not fully traced. Byte 1 also happens to land on $5B56, the same address written directly as a screen/timing poke by #R$A612's config word $0A and timeline command $FB - unrelated dual use of that literal address, not a field alias.
B $5B55,5,5
W $5B5A,4,4
B $5B5E,5,5
W $5B63,4,4
B $5B67,5,5
W $5B6C,4,4
B $5B70,5,5
W $5B75,4,4
B $5B79,5,5
W $5B7E,4,4
B $5B82,5,5
W $5B87,4,4
B $5B8B,5,5
W $5B90,4,4
B $5B94,5,5
W $5B99,4,4
B $5B9D,5,5
W $5BA2,4,4
B $5BA6,5,5
W $5BAB,4,4
b $5BAF Shared movement-script bytecode pool (variable-length scripts, entry points via $5B00)
N $5BAF One continuous stream of movement-script bytecode in #R$B8F9/#R$B920's format (bit 7 set = wait byte; else bits 0-2 select one of 8 opcodes via $A076/$A082, bits 3-6 are the opcode's parameter). #R$BB62 computes an entry point as $5BAF + 2*(byte from $5B00) and stores it at a spawned object's IX+$15/$16; #R$B94E then reads bytes sequentially from there. Not an array of fixed-size records - each script runs until its own content ends.
B $5BAF,4,8
B $5BB3,4,8
B $5BB7,10,8
B $5BC1,14,8
B $5BCF,14,8
B $5BDD,14,8
B $5BEB,16,8
B $5BFB,8,8
B $5C03,14,8
B $5C11,14,8
B $5C1F,8,8
B $5C27,16,8
B $5C37,8,8
B $5C3F,10,8
B $5C49,4,8
B $5C4D,6,8
B $5C53,6,8
B $5C59,6,8
B $5C5F,4,8
B $5C63,10,8
B $5C6D,6,8
B $5C73,6,8
B $5C79,4,8
B $5C7D,6,8
B $5C83,6,8
B $5C89,10,8
B $5C93,6,8
B $5C99,14,8
B $5CA7,6,8
B $5CAD,10,8
B $5CB7,10,8
B $5CC1,10,8
B $5CCB,6,8
B $5CD1,8,8
B $5CD9,4,8
B $5CDD,10,8
B $5CE7,2,8
B $5CE9,2,8
B $5CEB,2,8
B $5CED,2,8
B $5CEF,5,8
b $5CF4 Per-group spawn budget table (2 bytes/entry, indexed via $5B29)
N $5CF4 Indexed by #R$BA5F using the group index looked up from $5B29 (entry = group*2 + $5CF4). Byte 0 is the max object count to spawn for this group in one call, clamped against the remaining wave counter ($9D18); byte 1 is read afterwards (into A, via HL left pointing at it) but its role in the spawn-template setup that follows is not yet confirmed.
b $5EEA Level 1 timeline table
b $5F87 Level 2 timeline table
b $6042 Level 3 timeline table
b $60F1 Level 4 timeline table
b $61E2 Levels colour-scheme tables
B $61E2
B $61E5
b $61E8 Per-level configuration table (20 bytes/row)
N $61E8 Read by #R$A612: row = $61D4 + 20*(wave-formation-tag+1).
N $61E8 One 20-byte per-level row, confirmed field-by-field from #R$A612's 6-word SP-trick pop (offsets are byte offsets into the row): $00 word -> $9C57, cursor into the colour-scheme table (see #R$A54D, values land in $9C59/$9C5A); $02 word -> $9BA5, cursor into this level's timeline table (3 bytes/entry, see #R$C9AF); $04 word -> $9BFD, this level's scenery-script pointer (see #R$A3A0); $06 word -> combined with the current object's IX+$0A into $9C40/$9C41 (difficulty-scaled fire-rate baseline); $08 word -> low byte to $9C42/$9C43 (fire-timer reload value), high byte to $9C71; $0A word -> low byte to $5B56 and $C2E1 (SRL'd), high byte to $5B7A (screen/timing pokes, exact purpose unconfirmed); $0C-$13 (8 bytes) -> wave-formation-tag threshold table, scanned by #R$A4E7 (base address kept at $9BA7).
W $61E8,2,2 Address of colour-scheme table
W $61EA,2,2 Address of timeline table
W $61EC,2,2 Address of scenery-script
W $61EE,2,2 Fire-rate baseline (combined with IX+$0A)
W $61F0,2,2 Fire-timer reload
W $61F2,2,2
B $61F4,8
W $61FC,2,2 Address of colour-scheme table
W $61FE,2,2 Address of timeline table
W $6200,2,2 Address of scenery-script
W $6202,2,2 Fire-rate baseline (combined with IX+$0A)
W $6204,2,2 Fire-timer reload
W $6206,2,2
B $6208,8
W $6210,2,2 Address of colour-scheme table
W $6212,2,2 Address of timeline table
W $6214,2,2 Address of scenery-script
W $6216,2,2 Fire-rate baseline (combined with IX+$0A)
W $6218,2,2 Fire-timer reload
W $621A,2,2
B $621C,8
W $6224,2,2 Address of colour-scheme table
W $6226,2,2 Address of timeline table
W $6228,2,2 Address of scenery-script
W $622A,2,2 Fire-rate baseline (combined with IX+$0A)
W $622C,2,2 Fire-timer reload
W $622E,2,2
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
c $647A (Unused)
N $647A Blanks the whole screen: clears the attribute area to black, then fills the bitmap with a diagonal ramp pattern.
c $6498 Init menu screen: wipe, draw player boxes, labels, fill buffer
@ $6498 label=init_menu_screen
R $6498 A colour/type for the wipe transition ($9C59)
N $6498 Sets the wipe colour, runs the #R$C6A6 wipe effect, draws the player-panel box graphics (#R$6AD4, which uses #R$6B09), prints the "PLAYER ONE"/"PLAYER TWO" label, draws two box variants via #R$66DE, then fast-fills a buffer at $FA79 downward with the word $3D00 (261 words) using a PUSH-based stack trick, and finally calls #R$C772.
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
C $64C4,3 Fast column mover
C $64C7,3 !!MUT-ARG!! reset SP (restored by caller) (patched by $64B0)
C $64CA,2 re-enable interrupts, return
c $64CC Print character to screen using ROM font (fattened, double-height)
@ $64CC label=print_char
R $64CC A ASCII character code to print
N $64CC Draws an ASCII character at the cursor (#R$9CC7) as an emboldened, double-height glyph spanning two character cells. Each ROM font row (table at $3C00 + code * 8) is smeared one pixel left and right so the glyph prints bold, then written to two consecutive screen rows to stretch it vertically, and the two bytes at $9CC9 colour both cells. Control codes below $20 are dispatched instead through the small jump table at #R$65B3, and the character just printed is left in $9CCB.
C $64CC,4 Save AF/HL/DE/BC
C $64D1,5 Printing is suppressed while the skip flag ($9CCB) holds a control code
C $64D9,3 Codes below $20 print nothing
C $64DF,2 Nor does the $FE space-pad code
C $64EB,9 Colour this cell and the one 32 bytes below it from the two bytes at $9CC9
C $64F7,12 ROM font address for this character = $3C00 + code * 8
C $6503,8 Convert the attribute address into the matching screen bitmap address
C $650B,8 Blank the three pixel rows above the glyph
C $6513,27 Row 0: fatten the glyph byte to (b | b<<1 | b>>1), mask it and store to two screen rows
C $652E,14 Row 1
C $653C,13 Row 2
C $6549,10 Carry the destination across into the next screen third
C $6553,12 Row 3
C $655F,14 Row 4
C $656D,11 Row 5
C $6578,14 Row 6: narrower smear, masked so it cannot bleed into the next cell
C $6586,6 Blank the four pixel rows below the glyph
C $658C,4 Restore BC/DE/HL/AF
C $6598,4 Double the control code into a word offset
C $659F,10 Fetch the handler address and enter it with $65A9 pushed as its return
C $65A9,2 Codes $09 and above just count as a space
C $65AB,8 Record it as the skip flag, restore and return
C $64D0,1 C=char code
C $64D6,3 jump to control-code path if printing suppressed
C $64DC,3 jump to blank-glyph exit if char<$20
C $64E1,3 jump to blank-glyph exit if char=$FE
C $64E4,7 load cursor position
C $64F4,3 store advanced cursor column
C $6590,3 store last-printed char as new skip-print flag
C $6594,2 control-code path: codes >=9 treated as space
C $659C,3 dispatch via jump table #R$65B3
w $65B3 Control-code dispatch table (9 entries, codes 0-8, used by $6594)
N $65B3 Control codes are two-byte escapes: printing a byte below $20 leaves it in $9CCB, and the next character #R$64CC receives is consumed as that code's parameter (in C) rather than being drawn. This table maps the code to its handler; codes $00 and $08 chain by discarding their return address and re-entering $65AB with a second code, so those take two parameter bytes. Anything from $09 up is treated as a space.
c $65C5 Control code $00: set the top cell's colour, then chain into code $07
@ $65C5 label=pcc_set_colour_pair
N $65C5 Resets the cursor's row and skips ahead 7 characters, like a "start new row" print control code.
C $65C5,4 zero the low byte of $9CC9 (cursor row reset)
C $65C9,2 skip-count = 7
C $65CB,3 discard pushed return address, jump into skip-flag setter
c $65CE Control code $07: set the bottom cell's colour ($9CCA)
@ $65CE label=pcc_set_colour2
N $65CE Simplest handler: just LD ($9CCA),C then return. $9CCA's purpose is not otherwise confirmed.
c $65D3 Control code $01: set the top cell's ink (bits 0-2 of $9CC9)
@ $65D3 label=pcc_set_ink
N $65D3 Sets the print cursor's column (low 3 bits of $9CC9) from the control code's parameter.
C $65D9,1 OR in code value (1) to low 3 bits of $9CC9
c $65DC Control code $02: set the top cell's paper (bits 3-5 of $9CC9)
@ $65DC label=pcc_set_paper
N $65DC Sets the print cursor's row (bits 3-5 of $9CC9) from the control code's parameter.
C $65E7,1 OR in code value<<3 to bits 3-5 of $9CC9
c $65EA Control code $08: set the column via code $03, then chain into code $04
@ $65EA label=pcc_set_column_addr
N $65EA Runs control code $03's conversion, then arms a 4-character skip count.
C $65EA,3 Control code $03
C $65ED,2 skip-count = 4
c $65F2 Control code $03: set the cursor column (bits 0-4 of #R$9CC7)
@ $65F2 label=pcc_set_column
N $65F2 Shared: also called by control code $08 with C=8 instead of 3.
C $65F8,1 OR C into bits 0-4 of #R$9CC7
c $65FB Control code $04: fold the row into #R$9CC7 and convert it to a screen address
@ $65FB label=pcc_cursor_to_addr
N $65FB Shared: also reached from control code $06 with a different C value. Converts the cursor field #R$9CC7 into a screen pixel address (same bit-twiddle as #R$64CC's blit), folding in C.
C $65FB,8 Rotate C into the row-third bits
C $6603,5 Fold in the screen-third base ($58xx)
C $6608,6 Combine column and row bits into the low byte
C $660E,3 store converted pixel address back into #R$9CC7
c $6612 Control code $05: advance the cursor by the parameter
@ $6612 label=pcc_advance_cursor
N $6612 Nudges the print position along by the control code's parameter.
C $6616,1 add code value (5) to low byte of #R$9CC7
c $6619 Control code $06: derive the row from #R$9CC7, then reuse code $04's conversion
@ $6619 label=pcc_set_row
N $6619 Rescales the cursor field into a column index, folds in the control code's parameter, and reuses code $04's address conversion.
C $6620,3 mask to 5 bits, add code value (6)
C $6624,2 reuse control code $04's conversion with this C
c $6626 Print string (control codes + ROM-font text) from HL
@ $6626 label=print_string
N $6626 Prints a $FF-terminated string, treating bytes below $20 as control codes (position/attribute changes) rather than characters.
R $6626 HL pointer to $FF-terminated string
C $6626,2 save AF/HL
C $6628,3 check skip-print flag at $9CCB
C $662D,4 read next byte, advance HL; branch if control code (<$20)
C $6631,2 check string terminator $FF
C $6633,2 exit if string terminated
C $6635,4 check position/attribute control code $1B
C $6639,3 Print character to screen using ROM font
C $663C,2 loop for next character
C $663E,5 read control parameter byte, apply via #R$6648
C $6643,2 loop back
C $6645,3 restore AF/HL and return
c $6648 Print message N from table $627A
@ $6648 label=print_message
N $6648 Looks up a message by its number and prints it via #R$6626.
R $6648 A message number (0-based) to print
C $6648,4 save AF/HL/DE/BC
C $664C,3 point HL at string index table #R$627A
C $664F,4 init search count E=A+1, set terminator byte $FF
C $6653,3 search table for the (A+1)th $FF-terminated string using CPIR
C $6656,3 loop until count exhausted
C $6659,3 Print string (control codes + ROM-font text) from HL
C $665C,4 restore AF/HL/DE/BC
C $6660,1 return
s $6661
c $6663 Print packed-BCD number with leading-zero suppression
@ $6663 label=print_bcd_number
R $6663 HL pointer to 3-byte packed-BCD value
R $6663 A fill character for suppressed leading zeros ($FE = pad remainder with spaces instead)
N $6663 Copies the BCD value to scratch ($9C2B), then unpacks its 6 nibbles via RLD (one per digit), printing each through #R$64CC; nibbles that are still zero before the first nonzero digit print the fill character A instead of "0". If A was $FE on entry, once all 6 digits are printed it pads the unused width with spaces (count = original 6 minus digits actually printed, tracked in D).
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
@ $66B5 label=add_score
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
@ $66DE label=print_player_score
R $66DE A player number (1 or 2)
N $66DE Selects the score cursor coordinates ($9C1D/$9C1F, active vs. other player via $9C76) and the score data pointer (player 1: $9C79/fill=$FE space-pad; player 2: $9C85/fill=$20 plain space), sets the print cursor (#R$9CC7/$9CC9), then calls #R$6663 to print the BCD score.
C $66DF,3 compare entry player number to active player ($9C76)
C $66E9,4 other player: use $9C1F cursor coordinate
C $66ED,2 is this player 1?
C $66F6,2 player 1: fill character = $FE (space-pad)
C $6701,2 player 2: fill character = $20 (plain space)
C $6703,4 set print cursor column (#R$9CC7)
C $6707,4 set print cursor row ($9CC9)
C $670B,3 IX = score data pointer
C $6712,3 Print packed-BCD number with leading-zero suppression
c $6717 Compare 3 bytes at (DE) vs (HL); NC if all equal
N $6717 Checks whether two 3-character sequences match, such as a player's initials against a high-score entry.
R $6717 DE,HL pointers to the two 3-byte sequences
R $6717 O:Cy set if any byte differs, clear if all 3 match
C $671C,2 Compare a byte pair
C $671E,2 Bail out on first mismatch
C $6724,2 Loop the 3 bytes
C $6726,1 All matched: flag equal (SCF)
C $6727,1 Invert so carry = "differs"
c $672C Draw lives/bombs icon rows for a player
@ $672C label=draw_lives_bombs
R $672C A player number (1 or 2)
R $672C IX player struct base
N $672C Draws two icon rows via #R$6751: lives (from IX+3, colour $46) and bombs (from IX+9, colour $42), at attribute base $59A0 (player 1) or $59BA (player 2).
C $6741,3 Draw icon row
C $674C,3 Draw icon row
c $6751 Draw icon row: up to 6 filled cells (colour C), rest blank
N $6751 Paints one HUD icon row as a run of coloured cells followed by blank ones, writing both attribute rows so each icon is two cells tall.
@ $6751 label=draw_icon_row
R $6751 A icon count x2
R $6751 C fill colour
R $6751 IY attribute row base
C $6751,2 B = filled-cell count (count doubled)
C $6753,4 Clamp filled cells to max 6
C $675A,5 Blank count = 6 - filled
C $675F,6 Paint filled cell in both attribute rows (IY+0 and IY+$20)
C $6767,2 Loop filled cells
C $6769,4 Switch to blank cells (colour 0)
C $676E,2 Loop blank cells
c $6771 Update player's HUD panel (score + lives/bombs icons)
N $6771 Redraws one player's whole HUD panel - score plus the lives and bombs icon rows.
@ $6771 label=update_hud_panel
R $6771 A player number (1 or 2)
C $6771,3 Print a player's score at its HUD position
C $6774,3 Draw lives/bombs icon rows for a player
c $6778 Paint attribute colour-wipe column (menu highlight effect)
@ $6778 label=paint_wipe_column
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
@ $67C7 label=redefine_keys
N $67C7 Loops 5 times (E=$0A..$0E), printing the "FIRE"/"UP"/"DOWN"/"LEFT"/"RIGHT" labels via #R$6648, waiting for a keypress via #R$6829/#R$686A (keyboard scan with animated highlight), then storing the chosen key's row/mask (B,C) into the redefinable-key table at $9CE0 - the same table #R$68B1 reads when decoding keyboard input.
C $67D3,3 Print message N from table $627A
C $67D9,3 Print a redefined key's name
C $67DC,3 Scan keyboard for a keypress
C $67DF,3 Print a redefined key's name
C $67E2,3 Copy 16 bytes from wrapping sequence ($9C25) into screen at $5A68
c $67F1 Print a redefined key's name (character or CS/SS/SP/EN)
R $67F1 B key bit mask within its half-row (as read from the $9CE0 pairs)
R $67F1 C half-row port value for that key
R $67F1 AF,HL,BC preserved; the print cursor #R$9CC7 is saved and restored
N $67F1 Prints the name of one redefined key: the key's bit position within its keyboard half-row is found by shifting, and the resulting code either selects a name message for the four special keys (CAPS SHIFT, SYMBOL SHIFT, SPACE, ENTER) or is printed directly as a character. The print cursor is saved and restored around it so callers can lay keys out in a table.
@ $67F1 label=print_key_name
C $67F1,3 Save AF/HL/BC
C $67F4,8 Count the key's half-row: +5 per set bit rotated out of C
C $67FC,6 Add the key's bit position within that half-row, scanning B
C $6802,7 Index the redefined-key table at $9CF0 by that flat key number
C $6809,1 Fetch the key's code
C $680A,4 Save the print cursor ($9CC7)
C $680E,4 Codes 0-3 are the four special keys; anything else prints as a character
C $6817,2 Skip the character path
C $681C,2 Follow the name with a space
C $6821,4 Restore the print cursor
C $6825,4 Restore AF/HL/BC and return
C $6812,2 map key-code 0-3 to message $06-$09 (CS/SS/SP/EN)
C $6814,3 Print message N from table $627A
C $6819,3 Print character to screen using ROM font
C $681E,3 Print character to screen using ROM font
c $6829 Scan keyboard for a keypress (animated wait, debounced)
N $6829 Waits for a keypress while animating the screen, scanning the six keyboard half-rows listed at $9CEA until exactly one key is down. It then waits for that key to be released before returning, so a single press cannot be read twice.
@ $6829 label=wait_keypress
R $6829 O:B,C row/mask of the key pressed
C $6829,3 Save AF/HL/DE
C $6832,5 Point at the half-row port table ($9CEA); scan 6 half-rows
C $6837,6 Read this half-row, invert and mask to its 5 key bits
C $683D,2 Nothing pressed here: move on to the next half-row
C $683F,5 Isolate the lowest set bit; a non-zero remainder means 2+ keys are down
C $6844,2 Exactly one key down: accept it
C $6846,3 Next half-row
C $6849,2 All 6 scanned with nothing valid: animate a frame and rescan
C $684B,2 B = key bit mask, C = its half-row port (the pair #R$67F1 decodes)
C $6850,8 Read every half-row at once; keep animating until all keys are released
C $685B,2 Keep animating until the colour sequence wraps ($686A returns carry set)
C $685D,4 Restore AF/HL/DE and return
C $682C,3 Reset animated-sequence pointer
C $682F,3 Copy 16 bytes from wrapping sequence ($9C25) into screen at $5A68
C $684D,3 Copy 16 bytes from wrapping sequence ($9C25) into screen at $5A68
C $6858,3 Copy 16 bytes from wrapping sequence ($9C25) into screen at $5A68
c $6861 Reset animated-sequence pointer ($9C25 = $9CCC)
N $6861 Rewinds the animated colour sequence back to its start ($9CCC).
c $686A Copy 16 bytes from wrapping sequence ($9C25) into screen at $5A68
R $686A O:F carry set when the sequence hit its $FF terminator and wrapped
R $686A O:A corrupted; BC,DE,HL,IX preserved
N $686A Waits 2 frames, then copies B=16 bytes from the repeating $FF-terminated sequence at $9CCC (tracked via pointer $9C25, same source used by #R$6778's colour-wipe effect), wrapping back to the start on the terminator, into a fixed screen destination at $5A68.
C $686A,2 Wait 2 frames
C $6874,4 DE = sequence cursor ($9C25)
C $6878,2 Copy 16 bytes
C $687C,2 On $FF terminator, wrap to sequence start
C $6881,4 Reload cursor to $9CCC
C $6885,6 Write byte to two rows ($5A68 and +$20)
C $688F,4 Save advanced cursor back to $9C25
c $6898 Wait N frames
N $6898 Waits A frames.
@ $6898 label=wait_n_frames
R $6898 A number of frames to wait
C $6899,1 B = frame count
c $689F Wait up to N frames, exit early on fire
N $689F Waits up to A frames, returning early if fire is pressed.
@ $689F label=wait_frames_or_fire
R $689F A number of frames to wait
C $68A2,3 Read input
C $68A5,5 check fire pressed
C $68AB,2 exit early if fire pressed
c $68B1 Read input (Kempston or keyboard)
R $68B1 O:$9CDC fire-hold count (incremented while fire is down, 0 on release)
R $68B1 O:$9CDD $FF on a fire press or release edge
R $68B1 O:$9CDE direction bits, fire bit stripped
R $68B1 AF,HL,DE,BC all preserved
N $68B1 Reads the player's controls into a single direction+fire byte, merging three input sources: the Kempston joystick (if enabled), the fixed CAPS SHIFT direction keys, and the user's redefined keys. It also watches for the fire+redefine combo that toggles the redefine mode, debounced so one press registers once.
@ $68B1 label=read_input
C $68B1,4 Save AF/HL/DE/BC
C $68B9,3 Point at the redefined-key table ($9CE0): 5 x [half-row port, key mask]
C $68BC,5 Read this key's half-row and mask it down to that key's bit
C $68C5,3 Next key pair
C $68CB,4 Kempston not enabled: fall through to the keyboard
C $68D5,2 Kempston reading is the whole answer
C $68DB,4 Invert and mask to the row's 5 key bits
C $68E1,2 Read the SPACE/redefine half-row
C $68E7,4 Combo already debounced: treat as a normal read
C $68F1,2 Fire held: set bit 1 of the output byte (B, free now the scan loop ended)
C $68F9,15 Shift the remaining direction bits out of E into the output byte
C $690D,2 Fire not also held: not the combo, treat as a normal read
C $6920,6 E = previous fire-hold count; A = one more
C $6926,5 Fire still down? otherwise reset the count to zero
C $692B,3 Store the new fire-hold count ($9CDC), drop the fire bit from C
C $692E,5 D = $FF when fire is down now
C $6933,7 A = $FF when fire was down before; XOR leaves $FF only on a press or release edge ($9CDD)
C $693A,4 Store the direction bits ($9CDE)
C $693E,5 Restore BC/DE/HL/AF and return
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
R $6971 AF,HL,BC preserved (DE untouched); returns once the controls read clear for 3 frames
N $6971 Waits for all controls to be released, requiring them to stay clear for 3 consecutive frames so a held key does not carry over.
@ $6971 label=wait_for_input
C $697A,3 Read input
C $697D,3 get Input state / action code
c $6989 High-score entry: check the score, shuffle the table and type in initials
@ $6989 label=check_high_score
N $6989 Returns straight away unless the player's score beats one of the six high-score entries. Otherwise it congratulates them, shuffles the table down to open a slot, and runs the initials-entry screen where up/down cycle each letter through A-Z and fire accepts it.
C $698C,11 IX and DE point at the player's score record ($9C77)
C $6997,5 Point at the high-score table ($6240); 6 entries
C $699F,2 Score beats this entry: go and insert it
C $69A1,6 Otherwise step on to the next entry (11 bytes each)
C $69A7,3 Loop 6 entries; return if the score beat none of them
C $69AA,2 Save the beaten entry's address and the player's score pointer
C $69B1,6 Point at entry 5's name field ($6272); the first copy goes to $0000 and is discarded
C $69B7,9 Copy this entry's 8-byte name/position field down into the entry below
C $69C0,6 Step back to the previous entry (-$0B)
C $69C6,2 Recover the insert position and the player's score
C $69C8,5 Copy the player's 3-byte score into the freed slot
C $69CD,4 Back up 8 bytes to that entry's name field
C $69D1,10 IX = screen position, IY = initials buffer ($9CC4); 3 letters to enter
C $69DB,4 Save the letter counter
C $69DF,4 Arm the auto-accept timeout (100 ticks, held in shadow A)
C $69E3,5 Set the print cursor and load the letter being edited
C $69F1,3 Fire pressed: accept this letter
C $69F4,2 Wait 5 frames between repeats
C $69F9,4 Time the letter out once the 100 ticks run down
C $69FE,10 Fold the up/down bits out of the direction byte ($9CDE)
C $6A08,5 Combine them with left/right, keep the two step bits
C $6A0D,6 Any movement: re-arm the timeout
C $6A13,10 Step the letter one place up or down
C $6A1D,13 Wrap 'Z'+1 round to 'A' and 'A'-1 round to 'Z'
C $6A2A,2 Redraw and keep editing this letter
C $6A2C,7 Store the accepted letter into both the table and the buffer
C $6A36,5 Move on to the next letter
C $6A3B,2 Start music track 2
C $6989,3 Wait for input
C $699C,3 Compare 3 bytes at (DE) vs
C $69AC,2 "CONGRATULATIONS!...A GREAT SCORE...???"
C $69AE,3 Print message N from table $627A
C $69E8,3 Print character to screen using ROM font
C $69EB,3 Read input
C $69EE,3 get Input state / action code
C $69F6,3 Wait N frames
C $6A33,3 Wait for input
C $6A3D,3 Start playing music track A
C $6A46,3 Paint attribute colour-wipe column
c $6A4A Main menu key dispatcher (1P/2P select, redefine keys)
@ $6A4A label=menu_dispatch
N $6A4A Guarded by re-entrancy flag $9C29 (set by #R$A927). Reads keyboard row $F7 (SPACE/SYM SHIFT/M/N/B) and dispatches by bit: bit 0 -> #R$6A6D (select player 1), bit 1 -> #R$6A72 (select player 2), bit 2 -> #R$67C7 (redefine keys menu).
C $6A53,4 read keyboard row $F7
C $6A59,3 Print "PLAYER 1"/"PLAYER 2" turn indicator
C $6A65,3 Redefine keys
c $6A6D Print "PLAYER 1"/"PLAYER 2" turn indicator
N $6A6D Announces whose turn it is: stores the player number, prints the matching "1 PLAYER"/"2 PLAYER" message and wipes a colour column beside it.
@ $6A6D label=print_turn_indicator
C $6A6D,5 entry: set player number to 1
C $6A72,3 entry: set player number to 2
C $6A75,3 store player number at $9C75
C $6A78,2 map player number to message $0F/$10 ("1 PLAYER"/"2 PLAYERS")
C $6A7A,3 Print message N from table $627A
C $6A83,3 Paint attribute colour-wipe column
c $6A88 Show credits screen: highlight active player, update HUD, wipe out
@ $6A88 label=show_credits_screen
N $6A88 Inits state, prints "PLAYER ONE"/"PLAYER TWO" and draws the credits box (#R$6AD4), colours the active player's border white (C=$07, chosen via $9C76), updates both players' HUD panels via #R$6771, then transitions out with the #R$C6A6 wipe.
C $6A94,3 Build wrapped scroll-window row into $F6D1 buffer
C $6A97,3 Object render pass
C $6A9A,3 Fast column mover
C $6A9F,2 "PLAYER ONE"/"PLAYER TWO" (credits screen)
C $6AA1,3 Print message N from table $627A
C $6AA4,3 Draw both players' panel borders
C $6AA7,3 get Active player
C $6AC9,3 Update player's HUD panel
C $6ACD,3 Update player's HUD panel
C $6AD0,3 Screen wipe transition effect
c $6AD4 Draw both players' panel borders
@ $6AD4 label=draw_panel_borders
N $6AD4 Draws a 3-cell border segment for player 1 (bitmap $6CD1 at $59A0, via #R$6AF4), two single corner-cap boxes ($58C4/$58DA), then a 3-cell border segment for player 2 (bitmap $6CF1 at $5A00).
C $6ADA,3 Draw a 3-cell border segment
C $6AE1,3 Draw bordered box graphic (colour + bitmap) at HL
C $6AE7,3 Draw bordered box graphic (colour + bitmap) at HL
C $6AF0,3 Draw a 3-cell border segment
c $6AF4 Draw a 3-cell border segment
N $6AF4 Draws a border segment as two rows of three box graphics, separated by a fixed screen stride.
R $6AF4 DE bitmap data pointer
R $6AF4 HL attribute base
C $6AF7,3 Draw bordered box graphic (colour + bitmap) at HL
C $6B03,3 Draw bordered box graphic (colour + bitmap) at HL
c $6B09 Draw bordered box graphic (colour + bitmap) at HL
@ $6B09 label=draw_box
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
b $6B40 Object descriptor-record table: 17-byte records from $6B42, pointed at by an object's IY+$02/$03
B $6B42,17,17
B $6B53,17,17
B $6B64,17,17
B $6B75,17,17
B $6B86,17,17
B $6B97,17,17
B $6BA8,17,17
b $6BB9 Spawn-parameter table for the player's bomb (#R$BF42) and enemy bullets (#R$C43C)
B $6BB9,17,17
B $6BCA,17,17
N $6BDB Explosion/state descriptor table (6 bytes/entry: $B8,$AC marker, word sub-pointer, 2 params). Indexed by #R$5B55 spawn-template bytes 5/6 (#R$C5D2 uses entry 4, $6BF3); also the natural continuation past #R$6B42's 17-byte-record table ($6BDB is record 9 of that grid too - #R$6BCA is record 8). Entry 6 ($6BFF) breaks the 2,2 trailing-params pattern (has 4,5 instead); entry 7 ($6C05) breaks the whole format (marker $F4, 8 bytes) and leads into a longer byte-array region ($6C11+) that looks like shape/coordinate data, not yet decoded.
B $6BDB,6,6
B $6BE1,6,6
B $6BE7,6,6
B $6BED,6,6
B $6BF3,6,6
B $6BF9,6,6
B $6BFF,6,6
B $6C05,8,8
B $6C11
B $6CD1
B $6CF1
b $6D71 Levels scenery scripts
N $6D71 Level 1 scenery script
N $6D92 Level 2 scenery script
N $6DC3 Level 3 scenery script
N $6DDF Level 4 scenery script
b $7900 Tile block 2x2 table (cell -> 2x2 character block)
N $7900 Four parallel 256-entry lookup tables (#R$7900/$7A00/$7B00/$7C00). A background map cell is a single byte, used as the index into all four tables at once; the four bytes read out are the four character codes of a 2x2 tile block: #R$7900=top-left, $7A00=top-right, $7B00=bottom-left, $7C00=bottom-right. The column decoder #R$C941 reads one cell, writes the top pair (#R$7900/$7A00) into buffer row A and the bottom pair ($7B00/$7C00) into row B, so each cell renders as a 2-char-wide by 2-char-tall tile block. See docs/Level-Format.md.
N $7900 Page 0: top-left character code of each block.
N $7A00 Page 1: top-right character code of each block.
N $7B00 Page 2: bottom-left character code of each block.
N $7C00 Page 3: bottom-right character code of each block.
c $7D00 Initialize IM 2 interrupt vector table and set light ISR
@ $7D00 label=init_im2
N $7D00 Sets up the interrupt system (IM 2) and starts it pointing at the light per-frame handler.
C $7D01,6 Set interrupt mode 2, vector table at #R$FE00
C $7D07,5 Fill the vector table so every vector reads $FDFD
C $7D12,5 Plant a JP opcode at $FDFD, turning it into a trampoline
C $7D17,3 point to per-frame handler #R$A0B0 (light ISR)
C $7D1A,3 set ISR handler address
c $7D1F Clear screen and draw title screen graphics
@ $7D1F label=draw_title_screen
N $7D1F Clears the screen to black, then draws the title-screen logo/artwork.
C $7D20,2 Set border colour to black
C $7D22,7 Clear the bitmap ($4000-$5AFE)
C $7D2E,4 IY = attribute data for the graphic blocks (#R$7D4E)
C $7D36,3 Left half source data (#R$CB91)
C $7D3C,3 Draw title screen graphic block
C $7D44,3 Right half source data (#R$CA09)
C $7D4A,3 Draw title screen graphic block
b $7D4E Title-screen attribute data (IY source for #R$7D5C)
c $7D5C Draw title screen graphic block (attribute rows + bitmap columns)
N $7D5C Paints a 7x7 block of coloured character cells onto the screen, using one data stream for the colours and another for the pixel shapes.
@ $7D5C label=draw_title_block
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
N $7D98 Decodes 9 graphic blocks into the #R$CA09 sprite area, then runs a second pass to mirror half the decoded bytes.
C $7DA3,2 9 block-descriptor entries
C $7DA6,3 Decode one graphic-block descriptor entry; HL (the output cursor) is shared and left advancing across all 9 calls
C $7DAC,2 Advance IY to the next 17-byte entry
C $7DAF,2 Loop 9 times
C $7DB5,2 Total bytes written = HL - #R$CA09
C $7DB8,4 Halve the byte count (process every other byte)
C $7DBF,3 Substitute this byte via table #R$9A00
C $7DC2,1 Skip the alternate (untouched) byte
C $7DC6,2 Loop until the halved count reaches zero
c $7DC9 Decode one graphic-block descriptor entry (IY-indexed)
N $7DC9 Decodes one 17-byte block descriptor, expanding its graphic data one or more times as the descriptor requests.
R $7DC9 IY 17-byte block descriptor (called once per entry from #R$7D98's loop)
C $7DCC,6 Store the decoded data pointer into the descriptor (IY+$02/$03)
C $7DD5,4 Repeat count (IY+$0E); skip the extra loop if zero
C $7DE5,4 Shift a flag in the descriptor (IY+$0A)
C $7DE9,6 Bump a counter (IY+$0B) if a flag (IY+$06) is set
C $7DC9,3 Expand one graphic block
C $7DD2,3 Build bit-shifted copies of a graphic block
C $7DDC,3 Expand one graphic block
C $7DDF,3 Build bit-shifted copies of a graphic block
c $7DF3 Expand one graphic block (with optional blank-row padding)
R $7DF3 HL destination cursor (in/out, advanced past the written data)
R $7DF3 IX source graphic data pointer (in/out, advanced past the block)
R $7DF3 IY block descriptor
N $7DF3 Expands one graphic block into interleaved pixel/mask data at HL, optionally padded with blank rows above and below.
C $7DF3,3 IY+$06 selects optional blank-row padding
C $7DF7,2 Skip leading padding if flag clear
C $7DF9,3 Padding row count (IY+$07)
C $7DFC,3 Write one blank padding row
C $7DFF,2 Pad blank rows before the block
C $7E02,7 Sum per-row column width (IY+$0A x IY+$0B) into A
C $7E09,2 Sum column width into A (total block width)
C $7E0B,3 Stash total block width for later
C $7E0E,3 Row count (IY+$0B)
C $7E11,3 Column count for this row (IY+$0A)
C $7E19,3 !!MUT-ARG!! patched by $7E0B
C $7E20,2 Write interleaved byte pair for this column
C $7E23,2 Next row
C $7E29,2 Skip trailing padding if flag clear
C $7E2E,3 Write one blank padding row
C $7E31,2 Pad blank rows after the block
C $7E39,2 Advance IX by the block's total width
c $7E3D Write one blank padding row (8x $00/$FF byte pairs)
N $7E3D Called from #R$7DF3 to pad a leading/trailing blank row. Writes 8 columns of the same interleaved byte-pair layout #R$7DF3 writes for real data (pixel byte $00, mask/second-plane byte $FF - i.e. blank pixels, fully transparent).
c $7E4A Build bit-shifted copies of a graphic block (smooth-scroll variants)
R $7E4A HL working cursor (in/out, advanced past the block and its copies)
R $7E4A IY block descriptor
N $7E4A Makes extra copies of a graphic block, each shifted one bit further right, for smooth sub-pixel horizontal scrolling.
C $7E4E,2 Skip shift generation if flag is zero: just advance pointer
C $7E54,2 Shift-step count = lowest set bit of doubled flag
C $7E61,2 Duplicate block into working copy (offset by IY+$0C)
C $7E68,2 Bit-shift amount = (8 - flag) mod 8
C $7E81,2 Shift this column right by 1 bit (carry-propagate)
C $7E89,2 Next column
C $7E8D,2 Next shift amount
C $7E90,2 Next shift step
C $7E97,1 Advance pointer past this block
b $7E99 Collision buffer, Y projection (tail of the $7Exx page)
N $7E99 The high end of the row-indexed collision buffer #R$BBE5 stamps object identity bits into and #R$BCE9 reads back. Only this tail is free RAM - the low part of the $7Exx page holds the graphics routines #R$7DF3/#R$7E3D/#R$7E4A, so how far down the buffer is actually indexed has not been traced.
b $7F00 Collision buffer, X projection
N $7F00 The column-indexed half of the pair; #R$BCE9 ANDs a read of this against a read of the $7Exx page to get an object's overlap mask. Cleared every frame by #R$BBC2 along with the first page of the work buffer at #R$8000.
b $8000 Off-screen work buffer (6144 bytes, ZX screen geometry)
N $8000 A full display-file-shaped buffer, $8000-$97FF, that the sprite and tile blitters draw into: they build a destination page as width+$78 (#R$B005 and friends) or frame+$88 (#R$AC8D), landing in the $80-$97 range. Its geometry is the real thing - content repeats at the same offset across each $100 page, so a character row's 8 scanlines sit $100 apart exactly as at $4000, and the three 2048-byte thirds are $8000/$8800/$9000. Nothing writes to $4000 outside the screen-clear routines, so the strip copiers (#R$B55E, #R$B61A) working from $9C0F/$9C11 are the likely path onto the real display, though that has not been traced end to end.
b $9800 Spare RAM above the work buffer
b $98C8 Game work RAM (variables)
b $9A00 Byte bit-reversal (mirror) table: $9A00[i] = reverse of i's 8 bits
N $9A00 256-byte lookup where entry i is i with its bit order reversed (bit 0<->7, 1<->6, ...). Used to horizontally mirror sprite bytes: #R$7D98 builds each sprite's mirrored half by bit-reversing every other byte through this table, and the masked tile blitters (#R$B1BE etc.) XOR the bit-reversed pixel byte to draw mirrored sprites.
b $9B00 Game work RAM (variables, continued)
B $9B4C,3,3 Player bank-frame table: bank value 0-2 to sprite frame (see #R$BEC7)
B $9B4F,16,2 Formation slots: 8 x [objects-remaining, object-bitmask] pairs (see #R$BA5F, #R$B79F)
W $9BA5,2,2 Timeline table cursor (current level, 3-byte entries)
W $9BA9,2,2 Background column-source pointer (map-cell stream)
W $9BAB,2,2 Scenery data pointer
B $9BA4,1,1 Level progress / index
B $9BAF,1,1 Scenery-script wait value (doubles as sub-pixel shift)
W $9BF9,2,2 Scroll-buffer base pointer
W $9BFD,2,2 Scenery-script pointer (current level)
B $9BFF,1,1 Scenery-script active flag ($FF = active)
W $9C13,2,2 Blit destination screen address
W $9C15,2,2 Blit source data pointer (POP-fed)
B $9C1A,1,1 Blit width / column count
B $9C1B,1,1 Blit height / Y offset
W $9C25,2,2 Animated colour-sequence pointer (source $9CCC)
B $9C59,1,1 Active colour scheme (wipe/fill colour)
W $9C6D,2,2 Player's plane object (set by #R$C559; every homing enemy's aim target)
B $9C72,1,1 Wave type / group id
W $9C73,2,2 Explosion-data pointer (13-byte stride)
B $9C76,1,1 Active player (1 or 2)
W $9C77,2,2 Current player state-block pointer
B $9C7C,1,1
B $9C81,1,1
B $9C88,1,1
B $9C8D,1,1
t $9CC7 Print cursor (screen address $9CC7, coords $9CC9) and animated colour sequence ($9CCC)
b $9CD1 Colour-sequence tail, input state, and the keyboard scan tables
N $9CD1 Holds the end of the animated colour sequence started at $9CCC ($45..$40 then the $FF terminator #R$686A wraps on), the input state bytes #R$68B1 writes ($9CDC hold count, $9CDD edge flag, $9CDE directions), the five [half-row port, key mask] pairs at $9CE0 that #R$68B1 scans for the redefined keys, the six half-row port values at $9CEA that #R$6829 scans, immediately before the keyboard character map at #R$9CF0.
B $9CDC,1,1 Input state / action code
b $9CF0 Keyboard character map (8 half-rows x 5 keys)
N $9CF0 One entry per key in half-row scan order, indexed by #R$67F1 as $9CF0 + 5*row + key: CS,Z,X,C,V then A,S,D,F,G, Q,W,E,R,T, 1,2,3,4,5, 0,9,8,7,6, P,O,I,U,Y, ENTER,L,K,J,H and SPACE,SYM SHIFT,M,N,B. Entries hold the key's character, except codes $00-$03 which stand in for CAPS SHIFT, SYM SHIFT, SPACE and ENTER - #R$67F1 prints those from messages $06-$09 instead of as characters.
b $9D18 Object-group counters (remaining spawn budget per group)
N $9D18 Four counters #R$B730 seeds to 6/8/4/1 - together exactly the 19 slots in the pool at #R$9D40. #R$BA5F spends them when spawning and the handlers give them back on retirement, so they cap how many objects of each group can be alive at once.
B $9D18,1,1 Object-group counter
B $9D19,1,1 Object-group counter
B $9D1A,1,1 Object-group counter
B $9D1B,1,1 Object-group counter
w $9D1C Free-object-list head pointer
W $9D1C,2,2 Head of the free list chained through each object's +$00 (see #R$B730)
b $9D1E Persistent object-list head slots (4 x 6 bytes)
N $9D1E Four 6-byte records, too small to be objects: they act as list heads and sentinels. #R$BDAE walks the object list from $9D1E and #R$B730 pre-sets bits 2 and 3 of each record's +$04 flags byte. Each one's +$02 descriptor field points at the vector record #R$9D36.
B $9D1E,6,6 Slot 0: the object-list head walked by #R$BDAE
B $9D24,6,6 Slot 1
B $9D2A,6,6 Slot 2
W $9D30,2,2 Slot 3: secondary object-stack pointer
B $9D32,4,4 Slot 3's descriptor pointer and flags
w $9D36 Vector record the persistent slots point at
N $9D36 The address every persistent slot's +$02 field holds ($9D3C) lands two words into this record, where $9D3C holds #R$AC95 (the render pass's toggle-loop head) and $9D3E holds $ACB4 (its SP-restore tail). Nothing in code references either address, so they are presumably reached indirectly through this record - the dereference has not been traced.
W $9D36,10,2
b $9D40 Object pool: 19 objects of 29 bytes
N $9D40 Every actor in the game - the player's plane, enemy planes, tanks, boats, cannons, bullets, explosions and bonus items - is one 29-byte ($1D) object out of the pool at $9D40, chained through a singly-linked list and dispatched through a single state index. Field layout: +$00 next-object pointer; +$02 descriptor-record pointer (data, not code - see #R$5B55); +$04 status flags (bit 0 busy/suppress-redraw, bit 1 alive/retire, bit 2 active, bit 3 fixed-slot, bit 4 in-transition, bit 5 on-screen, bit 6 mirror, bit 7 facing left); +$05 state index, selecting the per-frame handler as jump-table entry $29+n (see #R$A000, base $A052); +$06 animation frame; +$07 dx and +$09 dy (fixed-point velocity, set by #R$B8A2); +$0B X and +$0D Y (fixed-point position, low byte fraction, high byte cell); +$0F respawn/blink timer (player); +$10 heading 0-63 ($FF on a projectile = not yet launched); +$11 speed; +$12 health; +$13 formation-slot id ($FF = none); +$14 collision hit-mask (see #R$BCE9); +$15/+$16 reused per object type - movement-script pointer for script-driven enemies (#R$B94E), bank-delay timer plus current bank frame for the player (#R$BE4A), the group-counter address for an explosion (#R$C5AF), the direction-rate for the weave handler (#R$C3C7); +$17 script byte cache / player bank target; +$18 script frame-delay timer or player invulnerability countdown; +$19 script loop counter; +$1A target reference ($FF = none) or stage counter; +$1B from spawn-template byte 3 plus difficulty, purpose unconfirmed; +$1C heading steered toward the target by #R$C43C (distinct from +$10). Because +$15/+$16, +$17 and +$18 all mean different things depending on +$05, a port must key their meaning off the state index rather than assuming one role per byte. See docs/Actors.md.
B $9D40,551,29 19 objects of 29 bytes ($9D40-$9F66), chained into the free list by #R$B730
b $9F67 Spare RAM above the object pool
w $A000 Object state/animation jump-table (used with $B7F6, various offsets)
N $A000 One continuous 73-entry word table of code addresses, live-verified: every entry (#R$A000-$A091) points into valid code (#R$A445-#R$C3C7 range). Different routines index into different sub-ranges of this same table via #R$B7F6 (e.g. $A02A, $A02E, $A038, $A042, $A052, $A076 are all just offsets into it, not separate tables). Ends at #R$A092, immediately followed by the score-value table at $A094 (see #R$66B5).
W $A000,2,2 $00 - Update tile-block tables
W $A002,2,2 $01 - Masked blit setup (to tile-block table)
W $A004,2,2 $02 - Opaque tile blit
W $A006,2,2 $03 - Masked tile blit setup
W $A008,2,2 $04 - Update tile-block tables
W $A00A,2,2 $05 - Masked blit setup (to tile-block table)
W $A00C,2,2 $06 - Opaque tile blit
W $A00E,2,2 $07 - Masked blit setup
W $A010,2,2 $08 - Draw masked sprite 8-row mask-rev
W $A012,2,2 $09 - Draw masked sprite 16-row mask-rev
W $A014,2,2 $0A - Draw masked sprite 8-row pixel-rev
W $A016,2,2 $0B - Draw masked sprite 16-row pixel-rev
W $A018,2,2 $0C - Draw masked sprite 8-row mask-rev
W $A01A,2,2 $0D - Draw masked sprite 16-row mask-rev
W $A01C,2,2 $0E - Draw masked sprite 8-row pixel-rev
W $A01E,2,2 $0F - Draw masked sprite 16-row pixel-rev
W $A020,2,2 $10 - OR-composite tile-block pages onto screen
W $A022,2,2 $11 - Copy 8-wide screen strips
W $A024,2,2 $12 - Copy 8-wide screen strips (transparent)
W $A026,2,2 $13 - => Formation script
W $A028,2,2 $14 - Jump to (IX)
W $A02A,2,2 $15 - Draw scrolling scenery column using tile generator
W $A02C,2,2 $16 - Draw scrolling scenery column
W $A02E,2,2 $17 - Start game
W $A030,2,2 $18 - Start game
W $A032,2,2 $19 - Start game
W $A034,2,2 $1A - Show bonus-points award screen, transition onward
W $A036,2,2 $1B - Player death-check entry
W $A038,2,2 $1C - No-op
W $A03A,2,2 $1D - Start game
W $A03C,2,2 $1E
W $A03E,2,2 $1F - Exit gameplay
W $A040,2,2 $20 - Exit gameplay
W $A042,2,2 $21 - No-op
W $A044,2,2 $22 - No-op
W $A046,2,2 $23 - No-op
W $A048,2,2 $24 - No-op
W $A04A,2,2 $25 - Restrict event mask to bit 7, run scenery script
W $A04C,2,2 $26 - Redraw HUD (deferred)
W $A04E,2,2 $27 - Redraw score, check bonus life (deferred)
W $A050,2,2 $28 - Load pending sound effect (deferred)
W $A052,2,2 $29 - No-op
W $A054,2,2 $2A - Player frozen
W $A056,2,2 $2B - Player
W $A058,2,2 $2C - Check for bullet hit, start explosion
W $A05A,2,2 $2D - Move straight down at fixed speed; advance animation frame
W $A05C,2,2 $2E - Multi-hit enemy
W $A05E,2,2 $2F - Multi-hit enemy
W $A060,2,2 $30 - Movement handler $30
W $A062,2,2 $31 - Movement handler $31
W $A064,2,2 $32 - Multi-hit enemy
W $A066,2,2 $33 - Multi-hit enemy
W $A068,2,2 $34 - Movement handler $34
W $A06A,2,2 $35 - Scripted-movement enemy
W $A06C,2,2 $36 - Launch and move projectile; explode on hit
W $A06E,2,2 $37 - Movement handler $37
W $A070,2,2 $38 - Movement handler $38
W $A072,2,2 $39 - Movement handler $39
W $A074,2,2 $3A - Multi-hit enemy
N $A076 Movement script opcodes (see #R$B8F9)
W $A076,2,2 $3B - mvop $00 dispatch sub-command (C bits 3-6) via $A082
W $A078,2,2 $3C - mvop $01 set field IY+$19 (from C or next script byte)
W $A07A,2,2 $3D - mvop $02 set absolute heading, apply velocity
W $A07C,2,2 $3E - mvop $03 turn heading relative, apply velocity
W $A07E,2,2 $3F - mvop $04 set/clear mirror flag (IY+$04 bit 6)
W $A080,2,2 $40 - mvop $05 set N object fields from script (offset,value pairs)
W $A082,2,2 $41 - clear velocity (dx,dy = 0)
W $A084,2,2 $42 - loop back in script until counter IY+$19 expires
W $A086,2,2 $43 - Apply object velocity
W $A088,2,2 $44 - no-op
W $A08A,2,2 $45 - set object alive flag (IY+$04 bit 1)
W $A08C,2,2 $46 - turn heading toward target ($9C6D)
W $A08E,2,2 $47 - set random column (IY+$0C)
W $A090,2,2 $48 - randomly set/clear direction flag (IY+$04 bit 7)
b $A092 Jump-table terminator, then the score-value table at $A094 (3 bytes/entry, see #R$66B5)
c $A0B0 Interrupt handler (light): bump frame counter, set vblank flag
@ $A0B0 label=isr_light
N $A0B0 Live-traced: this is the active per-frame handler right after pressing "1" to start. Which game phase uses this vs #R$A0C4 is not yet confirmed.
C $A0B2,5 Set vblank flag ($9BA2 bit 7)
C $A0B7,4 Bump frame counter ($9BA0)
C $A0BB,5 Reset $A1BB to $7F
c $A0C4 Interrupt handler (heavy): saves shadow regs, dispatches enemy/player/collision/sprite updates
@ $A0C4 label=isr_heavy
N $A0C4 The main per-frame handler: saves all registers, updates the frame counter and a couple of pseudo-random values, burns some fixed time, then runs the frame's game logic before restoring everything and returning.
C $A0C4,14 Save all registers (both banks)
C $A0D2,5 Set vblank flag ($9BA2 bit 7)
C $A0D7,5 Bump frame counter and rotate a byte ($9BA0/$9BA1)
C $A0DE,5 Reset $A1BB to $7F
C $A0E3,11 Advance pseudo-random shift value ($9C35/$9C34)
C $A0EE,11 Advance another pseudo-random shift value ($9C39/$9C38)
C $A0F9,10 Burn fixed time in a delay loop
C $A106,3 Animate active player's indicator box colour
C $A109,3 Mark active objects into the attribute-buffer collision mask
C $A10C,3 Draw active objects' collision masks into attribute buffer
C $A10F,3 Clear buffers at $7F00-$7FFF and $8000-$80FF
C $A112,3 Fast column mover
C $A115,3 Scroll background
C $A118,3 Advance background scroll
C $A11B,3 Build wrapped scroll-window row into $F6D1 buffer
C $A11E,3 Advance enemy timeline
C $A121,3 Update randomized countdown, then enter player update
C $A124,3 Object render pass
C $A127,3 Player respawn/continue state check
c $A13A Dispatch highest-priority pending deferred event
@ $A13A label=dispatch_deferred_event
N $A13A Picks the highest-priority pending deferred event (bits set by #R$66B5, $A1EA, $A8CF/$BF57/$C33B/$C373, $C8C9) and dispatches its handler.
C $A13A,6 Pending events ($9C27) ANDed with enable/priority mask ($9C28)
C $A140,2 Exit if no enabled event pending
C $A142,2 Save current enable mask
C $A148,5 Find lowest set bit (highest priority)
C $A14D,4 Clear the chosen bit from $9C27
C $A151,4 B = bit index -> jump-table selector
C $A155,3 Jump-table dispatcher
C $A159,3 Restore the enable mask
c $A15E No-op
@ $A15E label=noop_A15E
N $A15E Handler for indices $21, $22, $23, $24 of the #R$A000 jump table (see #R$B7F6).
C $A166,3 get Active player
C $A169,3 Update player's HUD panel
C $A174,3 Load parameters for the pending sound effect
c $A15F Deferred event $26: mask event bits, redraw active player's HUD
N $A15F Restricts the event-enable mask $9C28 to bit 7 only, then redraws the active player's HUD panel (#R$6771).
c $A16D Deferred event $28: clear event bit 0, load pending sound effect
N $A16D Clears bit 0 of the event-enable mask $9C28, then loads the pending sound effect via #R$A1F2.
c $A178 Deferred event $27: mask event bits, redraw score and check bonus life
N $A178 Restricts the event-enable mask $9C28 to bit 7 only, then reprints the active player's score (#R$66DE) and awards a bonus life if the threshold was crossed (#R$A189).
C $A17F,3 get Active player
C $A182,3 Print a player's score at its HUD position
C $A185,3 Award bonus life when score threshold reached
c $A189 Award bonus life when score threshold reached
@ $A189 label=award_bonus_life
R $A189 IX active player's data block
N $A189 Checks a player's score against the next bonus-life threshold, and if crossed, grants an extra life (up to a cap) and redraws the lives/bombs icons.
C $A189,4 Threshold index (IX+$04)
C $A192,7 Compare score (IX+$00) against threshold table $9CB8
C $A19B,3 Advance threshold index
C $A19E,7 Cap lives at 10 (IX+$03), else grant one more life
C $A1A8,3 get Active player
C $A1AB,3 Draw lives/bombs icon rows for a player
N $A1AF Handler for index $25 of the #R$A000 jump table (see #R$B7F6).
c $A1AF Restrict event mask to bit 7, run scenery script
N $A1AF Restricts which deferred events can interrupt to only the highest-priority class, then runs the scenery/event script interpreter.
C $A1AF,7 Mask event-enable mask ($9C28) down to bit 7 only
C $A1B6,3 Scenery/event script interpreter
b $A1BA Sound-effect state: pending priority ($A1BA), segment marker ($A1BB), parameter working buffer ($A1BC)
c $A1C8 Clear pending sound-effect priority
N $A1C8 Clears the pending sound-effect priority, silencing any request that has not been picked up yet.
@ $A1C8 label=sfx_clear
c $A1CE Request sound effect at maximum priority
N $A1CE Requests a sound effect at the highest priority, so it always displaces whatever is pending.
@ $A1CE label=sfx_req_max
C $A1D0,3 Request sound effect if higher priority than current
c $A1D4 Request sound effect if higher priority than current
@ $A1D4 label=sfx_request
R $A1D4 A effect priority (high nibble)
N $A1D4 Compares the high nibble of A against the currently pending effect's priority (stored at (#R$A1BA)); if A's priority is >= the current one, updates it, marks ($A1BB)=$80, and sets bit 0 of $9C27 to request dispatch via #R$A13A/#R$A222.
C $A1DB,3 Mask current pending priority (high nibble)
C $A1DF,2 Mask new request's priority (high nibble)
C $A1E2,2 Skip if new priority is lower
C $A1E4,1 Store new priority as pending
C $A1E5,5 Mark ready flag $A1BB=$80
C $A1EA,5 Request dispatch via $9C27 bit 0
c $A1F2 Load parameters for the pending sound effect
@ $A1F2 label=sfx_load_params
N $A1F2 Loads the parameters for the currently-pending sound effect from a table into a working buffer, ready for #R$A222 to play it.
C $A1F5,5 Check priority nibble; jump to idle if zero
C $A1FA,4 (priority-1)*8 -> byte offset into #R$A329 table
C $A201,4 Point HL at this priority's 8-byte parameter entry
C $A208,5 Copy first 7 bytes into working buffer $A1BC
C $A20D,4 Low nibble of 8th byte -> extra field
C $A212,6 Combine+rotate for second extra field (high nibble)
C $A218,4 C = last copied parameter byte
C $A21C,6 HL -> tone-length source; A = first parameter byte
c $A222 Play sound effect (timed speaker-bit toggle)
@ $A222 label=sfx_play_tone
N $A222 Plays the loaded sound effect as a square-wave tone by toggling the speaker bit in a timed delay loop, the same technique used by the music engine.
C $A222,6 Store two more parameter bytes into the working buffer
C $A228,6 Copy $A1C3 into $A1C7 (setup source pointer)
C $A22E,2 Select tone-length source via C bit 7
C $A236,2 Pick $A1C5 vs $A1C6 pointer variant
C $A241,2 A=$18: toggle-on value (border+speaker bit)
C $A244,2 Write toggle value to port $FE
C $A249,2 Hold half-cycle for B ticks (NOP-counted delay)
C $A24B,1 Swap duration-source pointer for next half-cycle
C $A24E,3 Loop 2 half-cycles (one full square-wave period)
c $A255 Between-segment handler for the sound-effect player
@ $A255 label=sfx_next_segment
N $A255 Called between tone segments of #R$A222's player when $A1BB (segment-remaining counter) is nonzero. Dispatches other pending deferred events via #R$A13A (same "poll between beats" pattern as the music engine's #R$A94C), then checks a completion marker: if it equals $80, reloads a new pending sound effect via #R$A1F2; otherwise continues the current effect's tone loop.
C $A256,2 If no segments remain, resume tone loop (#R$A23E)
C $A25C,3 Dispatch highest-priority pending deferred event
C $A263,6 Read and clear completion marker $A1BB
C $A269,4 Marker $80: effect done, load next effect (#R$A1F2)
C $A26D,2 Mode bit (C bit 7) selects which delta pair to apply
C $A293,6 Decrement segment counter; resume tone loop if more remain
C $A29C,4 Decrement repeat count; idle (#R$A324) when it hits zero
C $A2B0,2 C bit 5: toggle the $A1C3 sub-counter
C $A2BC,2 C bit 3: negate pitch delta ($A1BD) - sweep reversal
C $A2CF,2 C bit 4: negate duration delta ($A1BF) - sweep reversal
C $A2E2,2 C bit 6: reload base pitch/duration from $A1BC/$A1BE
c $A31D Sound-effect helper entry points, ending in priority-clear idle path
N $A31D Two shared tail entry points for the sound-effect player: one resumes the tone loop, the other clears the pending effect to idle.
C $A31E,3 Store A, resume #R$A222's tone loop
C $A324,4 Clear pending sound-effect priority (idle)
b $A329 Sound-effect parameter table (9 entries, 8 bytes each)
c $A371 Reset various state pointers/counters to defaults
N $A371 Resets a batch of scenery/event-script state variables to their default values, run when (re)starting a level.
C $A379,3 Sentinel/default pointer value ($9BA9)
C $A37C,3 set Scenery data pointer
C $A38A,6 Menu fill-buffer target ($9BF9)
C $A394,5 Script-active flag ($9BFF)
C $A399,6 Default scenery-script pointer ($9BFB)
c $A3A0 Scenery/event script interpreter (wait or dispatch event)
@ $A3A0 label=scenery_script
N $A3A0 Steps the background scenery/event script one instruction at a time. It takes nothing in registers - the script pointer is $9BFD and $9BFF gates whether the script runs at all. Each script byte is either a wait delay, a loop-back-to-start marker, or an event to dispatch; once a wait or event has been actioned, this also renders the sub-pixel scrolled scenery graphic. Distinct from the enemy-formation (#R$AFB8) and object-movement (#R$B8F9) script systems.
C $A3A0,7 Bail out if the script isn't currently active
C $A3A7,8 Read next script byte; if not top-bit-set, handle wait/loop below
C $A3AF,4 $FF: loop-back marker
C $A3B3,5 Otherwise: wait delay = byte's low nibble
C $A3B8,6 Advance pointer past a wait byte, loop
C $A3BE,8 Rewind script pointer to default, loop
C $A3C6,13 Top bit set: sum offset-chain table $6E06 to find event target
C $A3D3,9 Store event pointer, reset its parameter-nibble parity
C $A3DC,0 Extract the event's first parameter nibble
C $A3E2,7 Advance the wait/shift timer; return early while still counting
C $A3E9,5 Reset a per-event byte counter
C $A3EE,0 Extract this event's next parameter nibble
C $A3F1,3 Point to jump table
C $A3FA,7 Advance past the consumed script byte
C $A401,9 Reset wait timer and mark script active again
C $A3DC,3 Extract next 4-bit parameter from scenery-event data
C $A3EE,3 Extract next 4-bit parameter from scenery-event data
C $A3F4,3 Jump-table dispatcher
C $A3F7,3 Render sub-pixel scrolled graphic
c $A40B Render sub-pixel scrolled graphic (shift amount from scenery script)
N $A40B Renders the scenery graphic shifted by the scenery-script's wait value, for smooth sub-pixel horizontal scrolling.
C $A418,4 C = pass count
C $A40F,2 Skip render if wait value is zero
C $A413,2 Displacement = 8 - wait value
C $A415,3 Self-modify the shifted-read operand at $A436
C $A41C,3 get Scenery data pointer
C $A423,2 Outer: 9-byte copy loop setup
C $A427,8 Duplicate byte into both halves of the double buffer (wrap-safe shift)
C $A434,3 !!MUT-ARG!! Read back from the self-modified shifted offset (patched by $A415)
C $A43A,1 Write shifted byte, walking backward
C $A43F,2 Repeat for C passes
C $A441,3 set Scenery data pointer
N $A445 Handler for index $15 of the #R$A000 jump table (see #R$B7F6).
c $A445 Draw scrolling scenery column using tile generator
C $A44E,3 Generate next scenery/terrain cell value
C $A45F,3 Generate next scenery/terrain cell value
C $A445,3 get Scenery data pointer
C $A458,4 Wrap column offset back +8 rows for the descending pass
N $A46C Handler for index $16 of the #R$A000 jump table (see #R$B7F6).
c $A46C Draw scrolling scenery column (variant, using tile generator)
C $A46C,9 HL = source pointer; C = pass count; E = 5 (outer loop count)
C $A47A,7 Store cell, advance column by +9, loop
C $A481,6 Wrap column back -8 for the descending pass
C $A48C,7 Store cell, advance column by -9, loop
C $A493,5 Wrap column back +10, loop the outer pass
N $A46C Structurally similar to #R$A445 (same #R$A499 tile-generator calls building a column into HL) but with a +9 row stride and 5-row outer loop instead of #R$A445's layout - likely a different scenery band/type sharing the same generator.
C $A477,3 Generate next scenery/terrain cell value
C $A489,3 Generate next scenery/terrain cell value
c $A499 Generate next scenery/terrain cell value
R $A499 O:A generated cell value (base $9C0B + next script nibble)
R $A499 HL preserved
N $A499 Generates the next terrain cell value, periodically refreshing its base value from the scenery data.
C $A49A,7 Refresh counter ($9C0A) hit zero? refresh base value below
C $A4A1,3 Read next byte (2 nibbles) from scenery-event data
C $A4AB,1 Otherwise just count down to the next refresh
C $A4A7,3 Read next byte (2 nibbles) from scenery-event data
C $A4AC,3 Extract next 4-bit parameter from scenery-event data
c $A4B5 Read next byte (2 nibbles) from scenery-event data
N $A4B5 Combines two calls to #R$A4C4 (high nibble then low nibble) into a full byte. Corrects an earlier guess at #R$A499 - this is just a byte reader, not a PRNG source.
C $A4B6,3 Extract next 4-bit parameter from scenery-event data
C $A4BE,3 Extract next 4-bit parameter from scenery-event data
c $A4C4 Extract next 4-bit parameter from scenery-event data
R $A4C4 O:A the extracted nibble (0-15)
N $A4C4 Unpacks the next 4-bit parameter from the scenery-event data, alternating between a byte's high and low nibble on successive calls.
C $A4C6,3 HL = current byte pointer ($9C0C)
C $A4CC,2 Mask out the selected nibble
C $A4D1,6 Flip nibble-select mask ($9C0E); test which nibble just finished
C $A4D8,2 Skip shift if this was the low-nibble read
C $A4DA,6 Advance byte pointer (low nibble just consumed) and return
C $A4E0,4 Shift high nibble down to low bits
c $A4E7 Find level index from formation tag, reset state, select colour scheme
@ $A4E7 label=select_level_colour
N $A4E7 Finds which level a wave belongs to, resets scenery/event state for it, and selects that level's colour scheme.
C $A4E7,10 IX = current object's data; set a status flag
C $A4F1,8 Point at 8-entry threshold table; B=8, A=wave's tag (IX+$07)
C $A4F9,9 Search for the first entry >= the wave's tag
C $A503,3 set Level progress / index
C $A50C,11 Level index * 16 + $D0 -> starting scroll offset
C $A51E,6 Decrement offset, loop until column exhausted
C $A52A,4 DE = 3 (table stride)
C $A530,4 Advance cursor until entry covers the level index
C $A537,19 Init a couple of timer/event fields for the new level
C $A54D,5 Scan colour-scheme table until the level's threshold entry
C $A555,2 Step back to the entry, read its colour/type value
C $A506,3 Reset various state pointers/counters to defaults
C $A509,3 get Level progress / index
C $A518,3 Scenery/event script interpreter
C $A51B,3 Advance background scroll
C $A524,3 get Timeline table cursor
C $A527,3 get Level progress / index
C $A534,3 set Timeline table cursor
C $A54A,3 get Level progress / index
C $A557,3 set Active colour scheme
c $A561 Player respawn/continue state check
@ $A561 label=respawn_check
N $A561 Runs the death/recovery timer, or if it's disabled, polls ENTER for a manual continue, then dispatches the player's next state.
C $A561,15 Death/recovery timer ($9C3C); count down, A=4 on expiry
C $A570,12 Timer disabled: poll ENTER key, A=0 if held else A=2
C $A57C,3 Ratchet player state forward
C $A585,3 Jump-table dispatcher
@ $A588 label=noop_A588
C $A58F,3 Request sound effect at maximum priority
C $A592,3 point to per-frame handler #R$A0B0 (light ISR)
C $A595,3 set ISR handler address
N $A588 Handler for index $1C of the #R$A000 jump table (see #R$B7F6).
N $A589 Handler for indices $1F, $20 of the #R$A000 jump table (see #R$B7F6).
c $A588 No-op state (index $1C)
c $A589 Exit gameplay: mirror state, play alert sound, switch to light ISR
N $A589 Takes the game out of active gameplay: confirms the player state, plays an alert sound, and switches back to the light per-frame handler.
C $A589,3 Confirm the player state ($9C3D -> $9C3E)
c $A599 Ratchet player state forward (only increase, never decrease)
R $A599 A candidate new state value
N $A599 Updates $9C3D (the state #R$A561/$A57F reads for its dispatch) only if A is >= the current value; otherwise leaves it unchanged. Ensures the respawn/continue state only ever advances.
c $A5A0 Start music track 0
N $A5A0 Starts music track 0.
@ $A5A0 label=music_start_0
C $A5A1,3 Start playing music track A
c $A5A5 Show title screen once, then (re)initialize interrupts
N $A5A5 Draws the title screen once (on first call), then (re)builds the graphics tables and points the ISR back at the light per-frame handler.
C $A5A5,10 "Shown once" flag ($9B9F); skip drawing if already set
C $A5B8,3 point to per-frame handler #R$A0B0 (light ISR)
C $A5BB,3 set ISR handler address
C $A5AF,3 Clear screen and draw title screen graphics
C $A5B2,3 Decode 9 graphic blocks, then substitute every other byte via table $9A00
C $A5B5,3 Initialize IM 2 interrupt vector table and set light ISR
c $A5C0 Initialize both players' game state (lives, bombs, HUD)
@ $A5C0 label=init_players
N $A5C0 Sets up both players' game state (lives, bombs, HUD pointers) at the start of a new game.
C $A5C5,13 Zero player 1's 11-byte state block ($9C79)
C $A5D2,13 Zero player 2's 11-byte state block ($9C85)
C $A5ED,6 HUD pointer for the active player ($9C77)
C $A601,8 Reset explosion-data index ($9C84/$9C90)
C $A5C2,3 Init menu screen
C $A5DF,2 POKE 42464,N sets starting lives count
C $A5EA,3 set Active player
C $A5F9,2 POKE 42490,N sets starting bomb count
c $A612 Initialize wave-group counters and load group data tables
@ $A612 label=load_wave_config
N $A612 Sets up everything a new wave needs: scatters the level's config row into the working pointers that the background, scenery and colour subsystems read each frame, and derives the enemy fire-rate and reload values from the player's difficulty fields. Finishes by initialising the wave, selecting the colour scheme and showing the credits screen.
C $A612,7 IX = the current player's record ($9C77); A = its wave-group id
C $A61F,7 Point at the explosion-data table ($9C84), stride 13
C $A629,3 set Explosion-data pointer
C $A62C,5 Reset the wave's spawn budget ($9C6F = 6)
C $A631,11 Index the per-level config table ($61D4) by the player's level index, stride 20
C $A63F,10 Clear the wave progress and bonus counters
C $A649,5 Point SP at the config row so its fields can be popped off in order
C $A663,4 Wave type 3 reads its colour scheme 4 bytes further into the row
C $A667,7 Fire-rate baseline = difficulty (IX+$0A) * 8 + the row's low byte
C $A672,10 Store the fire-rate baseline ($9C41/$9C40)
C $A67C,12 Fire-timer reload value ($9C42/$9C43) and its high byte ($9C71)
C $A688,14 Screen/timing pokes ($5B56, $C2E1 and $5B7A)
C $A696,4 SP now points at the row's wave-tag threshold table; keep it ($9BA7)
C $A69D,9 An easier difficulty (4+ bombs) earns an extra bonus step
C $A6A9,5 So does still holding 3+ lives
C $A619,3 Save wave-group id ($9C68)
C $A61C,3 set Wave type / group id
C $A626,3 Index 13-byte table at $9C84 for explosion data
C $A63C,3 Index 20-byte per-level table at $61D4
C $A64E,14 SP-trick: pop level-config pointers (colour scheme/level index/scenery script)
C $A65C,3 get Wave type / group id
C $A65F,4 Adjust cursor if wave-type is 3
C $A66E,2 Clamp fire-timer high byte on overflow
C $A69A,3 !!MUT-ARG!! Restore SP (patched by $A64A)
C $A6A6,2 Bump bonus counter past difficulty threshold
C $A6AE,2 Bump bonus counter past second threshold
C $A6B1,3 Initialize wave
C $A6B4,3 Find level index from formation tag, reset state, select colour scheme
C $A6B7,3 Show credits screen
c $A6BB Show title screen and credits (attract sequence)
@ $A6BB label=show_title_attract
N $A6BB Shows the title screen with music, then (via the #R$A6C9 entry) the credits screen, waiting for fire to skip ahead at either point.
C $A6DB,2 Wait up to 200 frames (or until fire is pressed)
C $A6BD,3 Init menu screen
C $A6C0,2 "FIREBIRD...FLYING SHARK...GRAFTGOLD LTD...COPYRIGHT 1987"
C $A6C2,3 Print message N from table $627A
C $A6C5,3 Start music track 0
C $A6CB,3 Init menu screen
C $A6CE,2 credits: "SOFTWARE DESIGN AND PROGRAMMING BY DOMINIC ROBINSON, GRAPHICS BY JOHN CUMMING, MUSIC BY STEVE TURNER"
C $A6D0,3 Print message N from table $627A
C $A6D5,3 set Active colour scheme
C $A6D8,3 Screen wipe transition effect
C $A6DE,3 Read fire button (Kempston/keyboard) with debounce
c $A6E5 Print high-score table
@ $A6E5 label=print_high_scores
N $A6E5 Prints the 6-row high-score table, one row of name and score per iteration, then runs a wipe transition into the table screen.
C $A6E7,3 Init menu screen
C $A6EA,6 set cursor position, point HL at high-score name table #R$6238
C $A6F3,3 loop 6 rows
C $A6F6,3 Print string (control codes + ROM-font text) from HL
C $A6FF,3 Print character to screen using ROM font
C $A705,3 Print packed-BCD number with leading-zero suppression
C $A715,3 Print packed-BCD number with leading-zero suppression
C $A71D,3 set Active colour scheme
C $A720,3 Screen wipe transition effect
C $A72D,3 Paint attribute colour-wipe column
C $A735,3 Read fire button (Kempston/keyboard) with debounce
C $A73E,3 Print message N from table $627A
C $A762,3 Read fire button (Kempston/keyboard) with debounce
C $A76D,3 Init menu screen
c $A773 Handle player death (respawn, or Game Over if out of lives)
N $A773 Redraws the HUD, waits for the controls to be released, then dispatches the player's next state through the #R$A02E sub-table.
@ $A773 label=handle_player_death
C $A773,3 Update player's HUD panel
C $A776,3 Wait for input
C $A779,10 wait for frame-done flag $9C3E, run state table at $A02E
C $A783,4 load player object pointer into IX
N $A783 Handler for index $1B of the #R$A000 jump table (see #R$B7F6).
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
C $A7CA,3 set Active colour scheme
C $A7CD,3 Screen wipe transition effect
C $A7D0,3 Decrement current player's lives
c $A7D7 Decrement current player's lives; switch turn to other player if any remain
@ $A7D7 label=player_lose_life
R $A7D7 IX current player's state block base (lives at IX+$03)
N $A7D7 Handles a player's death: in 2-player mode, hands control to the other player if they still have lives, then decrements the (now-current) player's life count.
C $A7DB,2 Single-player: skip switch, just decrement lives
C $A7E1,4 Default: select the other player's state block
C $A7E6,2 Active player was 2: keep player-1 block selected instead
C $A7F0,2 Other player is out of lives: don't switch turns
C $A7F6,4 Switch current-player pointer to the other player
C $A7FB,2 Toggle active-player flag
C $A7FE,3 Decrement the (now-current) player's lives
c $A802 Show bonus-points award screen, transition onward
N $A802 Shows the end-of-wave bonus-points award screen (message and box graphics, score/life update, music and tone effect), then wipes into the next screen.
C $A806,3 get Wave type / group id
C $A80C,2 "3000 POINTS"
C $A80E,3 Print message N from table $627A
C $A819,3 Draw bordered box graphic (colour + bitmap) at HL
C $A821,2 "BONUS-"
C $A825,3 Print message N from table $627A
C $A837,3 Draw bordered box graphic (colour + bitmap) at HL
C $A83D,3 Add BCD score value to current player's score
C $A840,3 get Active player
C $A843,3 Print a player's score at its HUD position
C $A846,3 Award bonus life when score threshold reached
C $A863,3 Print message N from table $627A
C $A868,3 Start playing music track A
C $A86D,3 set Active colour scheme
C $A870,3 Screen wipe transition effect
N $A894 Handler for indices $17, $18, $19, $1D of the #R$A000 jump table (see #R$B7F6).
C $A8A0,3 Init menu screen
N $A8A7 Handler for index $1E of the #R$A000 jump table (see #R$B7F6).
C $A8A7,3 Request sound effect at maximum priority
C $A8B5,3 Read fire button (Kempston/keyboard) with debounce
c $A894 Start game: switch ISR to $A0B0, enter main loop
@ $A894 label=start_game
C $A894,3 point to per-frame handler #R$A0B0 (light ISR)
C $A897,3 set ISR handler address
c $A8A7 Post-death prompt: alert, then wait for Q or fire to pick the next player state
@ $A8A7 label=post_death_prompt
N $A8A7 Reached as player state 2 from #R$A561 once the death/recovery timer expires: it sounds a maximum-priority alert and then blocks until Q or fire is pressed, Q handing on to #R$A894 (state 1, restart) and fire leaving state 0 for the no-op #R$A588.
C $A8AA,3 HL = the player state #R$A561 dispatches on ($9C3D)
C $A8AD,6 Poll keyboard half-row $FB and test bit 0 (Q)
C $A8B3,2 Q is down: take the restart path
C $A8B8,4 Hold the state at 0 while waiting; loop until fire is pressed
C $A8BD,3 Q chosen: state 1, so the next dispatch starts play
c $A8C0 Start new game: reset game state
@ $A8C0 label=new_game_reset
N $A8C0 Resets core per-game state at the start of a new game, then waits for the first deferred event (player death/continue) before returning.
C $A8C0,3 Wait for input
C $A8C6,11 Clear the deferred-event mask ($9C27), mark event bit 2 pending
C $A8D1,5 Player state $9C3D=0
C $A8D6,3 Player state $9C3E=0
C $A8D9,4 Immobilise flag $9C3B=0
C $A8E0,4 Disable the death/recovery timer (#R$A561 sentinel, $9C3C=$FF)
C $A8EF,0 point to per-frame handler #R$A0C4 (heavy ISR)
C $A8F2,0 set ISR handler address
C $A8F8,6 Poll deferred events until player state $9C3E is set
C $A8C3,3 Clear pending sound-effect priority
C $A8DD,3 set Input state / action code
C $A8E5,3 Clear buffers at $7F00-$7FFF and $8000-$80FF
C $A8E8,3 Draw active objects' collision masks into attribute buffer
C $A8EC,3 Scenery/event script interpreter
C $A8EF,3 point to per-frame handler #R$A0C4 (heavy ISR)
C $A8F2,3 set ISR handler address
C $A8F5,3 Dispatch highest-priority pending deferred event
C $A905,3 Show title screen once, then (re)initialize interrupts
C $A909,3 Show title screen and credits
C $A90C,3 Print high-score table
C $A914,3 Initialize both players' game state
C $A917,3 Initialize wave-group counters and load group data tables
C $A91A,3 Start new game
C $A91D,3 Handle player death
c $A927 Start playing music track A
@ $A927 label=music_start
R $A927 A music track number
N $A927 Starts playing a music track: marks the menu system busy, then points the music engine's note reader at the requested track's score data.
C $A927,3 Mark menu/music busy ($9C29 guard used by #R$6A4A)
C $A92B,4 Track number * 2 -> byte offset into #R$AB03
C $A92F,8 Look up the track's score pointer
c $A937 Point score reader at next event, check for end
N $A937 Advances the music score reader to the next event, stopping the track on the $FF end marker, otherwise loading that event's pattern pointer.
C $A937,3 Save score pointer ($AA8E)
C $A93B,5 End marker $FF: stop the track (#R$AA32)
C $A943,5 Index pattern-pointer table #R$AACB (2 bytes/entry)
C $A948,4 Load the pattern pointer into HL
c $A94C Parse next music score byte (note/duration/rest)
@ $A94C label=music_parse_note
N $A94C Reads score bytes and classifies by value range: >=$D0 sets an instrument/octave value ($AA98), $60-$6F indexes a note-pitch table at #R$AA9B (3 bytes/entry) to play a note, other ranges set duration ($AA92) or rest. Also polls the menu dispatcher (#R$6A4A) and fire button each event, so music playback and menu input share this loop while on the title screen.
C $A94F,3 Main menu key dispatcher
C $A952,3 Read fire button (Kempston/keyboard) with debounce
C $A955,3 Abort playback if fire/menu action pressed
C $A95C,5 End-of-score marker $FF: fetch next event (#R$AA2B)
C $A961,5 Below $60: play a note (#R$A98A)
C $A966,3 Exactly $60: reset instrument (#R$A97A)
C $A96B,3 $61-$6F: set instrument/octave value (#R$A972)
C $A970,2 $70-$CF: set note duration (#R$A981)
C $A972,5 Store instrument/octave low nibble ($AA98)
C $A978,2 => Parse next music score byte
C $A97F,2 => Parse next music score byte
C $A984,3 Store note duration ($AA92)
C $A988,2 => Parse next music score byte
C $A990,6 Index note-pitch table #R$AA9B (3 bytes/entry)
C $A996,4 Store the entry's tone byte to #R$AA8D
C $A99A,5 Read the 16-bit base period from the table into HL
C $A99F,10 Octave = high nibble of score byte -> $AA93
C $A9AC,6 Halve the period once per octave
C $A9B2,7 Adjust period (-12) and store as $AA96
C $A9C1,4 Reload the tone byte (#R$AA8D)
C $A9DF,4 Scale by duration via repeated addition
C $A9E3,8 Add half of the result (x1.5)
C $A9EB,3 Store the second period parameter ($AA99)
N $A9F1 Look up note pitch period and apply octave shift
N $A9F1 Called from #R$A94C for a $60-$6F score byte. Low nibble of the byte indexes the pitch-period table at #R$AA9B (3 bytes/entry, note within octave); high nibble is the octave number - if nonzero, #R$AA0F halves the pitch period that many times (one halving per octave) before the note is played via #R$AA34.
C $A9F6,2 Note index (low nibble)
C $AA06,5 Octave number (high nibble); skip halving if zero
N $AA0F Halve note period HL by octave count in A
C $AA22,3 Play beeper music note
C $AA28,3 => Parse next music score byte
C $AA2F,3 => Point score reader at next event, check for end
c $AA34 Play beeper music note (square-wave tone generator)
@ $AA34 label=beep_play_note
N $AA34 Plays one note for its duration as a square wave, with a short attack click at the start. Timing is derived directly from the note's pitch period, the same technique used by the sound-effect player at #R$A222.
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
b $AA8D Music engine work variables and note-pitch table
B $AA8D,1,1 Current note's first pitch-table byte (second-tone parameter)
W $AA8E,2,2 Track/score note pointer (set by $A927/$A937)
W $AA90,2,2 Score-reader temp pointer
B $AA92,1,1 Note duration
B $AA93,1,1 Octave shift for current note
W $AA94,2,2 Beeper period parameter A ($AA34 dual-tone)
W $AA96,2,2 Beeper period parameter B ($AA34 dual-tone)
B $AA98,1,1 Instrument/octave value
W $AA99,2,2 Note period parameter (BC for $AA34)
b $AA9B Note-pitch table: 16 notes, 3 bytes/entry (tone byte + 16-bit period)
B $AA9B,48,3
b $AACB Table of note patterns (sounds)
N $AACB See #R$A937 routine.
W $AACB,,2
b $AB03 Table of note patterns (sounds)
W $AB03,6,2
b $AB09 Note patterns by #R$AB03 table
N $AB09 Note pattern 0 by #R$AB03 table
N $AB4B Note pattern 1 by #R$AB03 table
N $AB56 Note pattern 2 by #R$AB03 table
b $AB64 Note patterns by #R$AACB table
N $AB64 Note pattern 0 by #R$AACB table
N $AB70 Note pattern 1 by #R$AACB table
N $AB85 Note pattern 2 by #R$AACB table
N $AB93 Note pattern 3 by #R$AACB table
N $ABA1 Note pattern 4 by #R$AACB table
N $ABA7 Note pattern 5 by #R$AACB table
N $ABAD Note pattern 6 by #R$AACB table
N $ABB7 Note pattern 7 by #R$AACB table
N $ABBD Note pattern 8 by #R$AACB table
N $ABC6 Note pattern 9 by #R$AACB table
N $ABCF Note pattern 10 by #R$AACB table
N $ABD8 Note pattern 11 by #R$AACB table
N $ABE2 Note pattern 12 by #R$AACB table
N $ABEB Note pattern 13 by #R$AACB table
N $ABF4 Note pattern 14 by #R$AACB table
N $AC05 Note pattern 15 by #R$AACB table
N $AC10 Note pattern 16 by #R$AACB table
N $AC1A Note pattern 17 by #R$AACB table
N $AC24 Note pattern 18 by #R$AACB table
N $AC2E Note pattern 19 by #R$AACB table
N $AC39 Note pattern 20 by #R$AACB table
N $AC42 Note pattern 21 by #R$AACB table
N $AC4C Note pattern 22 by #R$AACB table
N $AC55 Note pattern 23 by #R$AACB table
N $AC60 Note pattern 24 by #R$AACB table
N $AC6B Note pattern 25 by #R$AACB table
N $AC75 Note pattern 26 by #R$AACB table
N $AC83 Note pattern 27 by #R$AACB table
c $AC8D Object render pass: clip each object's sprite and emit a drawing program
@ $AC8D label=render_objects
R $AC8D IY object struct base
N $AC8D Draws one object per call: works out its screen address from its position, tests how much scenery its footprint covers, then looks up and clips its sprite frame via #R$AF2A and hands the result to the blitters. The blit is not called directly - the routine patches a blit-variant opcode into a two- or three-byte formation-script program held inline (at $AE3B, $AEB3, $AEDC, $AEEF, $AF18 and $AF25, which disassemble as nonsense because they are script data, not code) and runs it through #R$AFB8. Objects wider than one sprite are drawn as two halves, the second taken from the table at $6B55, and a mirrored object (IY+$04 bit 6) takes a separate path. Interleaved throughout is a border/speaker toggle loop (#R$AC95) the routine keeps returning to between phases; see docs/Actors.md.
C $AC8D,4 Save SP (restored at $ACB4)
C $AC91,4 Point IY at fixed-object list head $9D1E
C $AC98,6 Toggle border/speaker bit of state byte at $9C37 and output it
C $ACA0,6 Pop next loop/duration word via SP-trick into IY
C $ACA6,4 Loop while duration bit (IY+$04 bit 2) is clear
C $ACAC,4 Clear "busy" flag ($9D1E+$04 bit 0) once duration elapses
@ $ACB4 label=render_objects_restore_sp
C $ACB4,4 !!MUT-ARG!! Restore the SP saved by #R$AC8D's prologue (operand at $ACB5 is patched there) and return (patched by $AC8D)
C $ACB8,4 Entry: request toggle loop (sets IY+$04 bit 5)
C $ACBC,4 Only continue toggling while bit 4 flag is set
C $ACC3,3 Start of object-column draw phase (separate from the border-toggle head)
C $ACF4,4 Alternate entry: request toggle loop (mirrors $ACB8)
C $AE38,3 => Formation script
C $AEB0,3 => Formation script
C $AED9,3 => Formation script
C $AEEC,3 => Formation script
C $AF15,3 => Formation script
C $AF22,3 => Formation script
C $AC95,3 Loop head: point at the toggle state byte ($9C37)
C $AC9E,2 Write the toggled value to port $FE
C $ACB0,4 Unwind the SP-trick stack and return
C $ACC0,3 Keep toggling while bit 4 is still set
C $ACC6,3 Offset the address by the animation frame
C $ACC9,4 DE = 8 (cell stride)
C $ACCD,9 X offset = (column - 6) * 2
C $ACD6,8 Index the row-address table at $9B00 by (row+1)*2
C $ACDE,4 Fetch the row's screen base, add the X offset
C $ACE3,5 Stack 3 cell addresses across the row (stride 8)
C $ACE8,5 Step down one screen row ($24)
C $ACEE,3 Stack 2 more cell addresses on that row
C $ACF1,3 Back to the toggle loop
C $ACF8,16 Vertical sub-cell offset from the scroll position ($9C01) and Y fraction
C $AD08,4 Back the source pointer off by that offset
C $AD0C,6 Self-modify the scan phase's source operand ($AD86) and row adjust ($AD65)
C $AD12,7 Self-modify the first LDI chain's entry point ($AD4A) - clips the copy
C $AD19,7 Self-modify the second LDI chain's entry point ($AD68)
C $AD22,9 X offset = (column - 8) * 2
C $AD2B,16 Row index, rounded up when the Y fraction has crossed the scroll position
C $AD3B,6 Row base + X offset -> the scan phase's start operand ($AD82)
C $AD41,5 DE = $B4 source stride; 4 passes
C $AD46,3 Point SP at this pass's source, fetch the destination
C $AD49,2 !!MUT-ARG!! Self-modified jump: skip N of the LDIs below to clip the row (patched by $AD16)
C $AD4B,14 Copy up to 7 cells
C $AD59,5 Advance the destination by $28 to the next row
C $AD5E,4 Advance the source pointer to match
C $AD62,2 Fetch the next destination, apply the self-modified row adjust
C $AD64,2 !!MUT-ARG!! patched by $AD0F
C $AD67,2 !!MUT-ARG!! Self-modified jump: skip N of the LDIs below to clip the row (patched by $AD1D)
C $AD69,16 Copy up to 8 cells
C $AD79,6 Rewind the source pointer for the next pass
C $AD7F,2 Loop 4 passes
C $AD81,4 !!MUT-ARG!! HL = scan start on screen (operand patched at $AD3E) (patched by $AD3E)
C $AD85,6 !!MUT-ARG!! Shadow HL = scan start in the source (patched at $AD0C); C = 24 cells (patched by $AD0C)
C $AD8B,5 DE = $24 row stride; 6 rows
C $AD90,2 Point SP at this row
C $AD92,3 DE = $30 cell stride
C $AD95,8 Cell 1: count it if non-blank (PUSH/POP pads both paths to equal timing)
C $AD9D,9 Cell 2
C $ADA6,9 Cell 3
C $ADAF,9 Cell 4
C $ADB8,7 Step both pointers back a row ($FF78)
C $ADBF,2 Loop 6 rows
C $ADC1,7 Fewer than 8 cells left blank: leave the flag alone
C $ADC8,7 Otherwise mark the object ready to draw (IY+$04 bit 0)
C $ADCF,4 Assume off-screen: clear the drawable flag
C $ADD3,4 A = animation frame
C $ADD7,9 Look up and clip the sprite; #R$AF2A returns to $ADE0 if any of it is visible, else to $AE3E
C $ADE0,5 Visible: mark the object drawable again
C $ADE5,3 set Blit source data pointer (the clipped sprite)
C $ADE8,8 Blit width from C, height from E/2
C $ADF0,8 Destination page derived from the frame
C $ADF8,4 E = column byte offset
C $ADFC,11 Screen row from the object's Y (IY+$0D/$0E)
C $AE0A,12 Compare the row against the scroll offset ($9C00); back up a row group if behind
C $AE16,6 Fold the scroll offset back into the row ($9C0F)
C $AE1C,11 Index the row-address table at $9B00
C $AE27,6 Row base + column offset -> $9C11
C $AE2E,6 Patch the blit opcode into the drawing program at $AE3C
C $AE34,4 Run the drawing program at $AE3B through #R$AFB8
C $AE3B,3 !!MUT-ARG!! Drawing program (formation-script bytes, not code): blit opcode patched at $AE3C (patched by $AE31)
C $AE3E,3 Back to the toggle loop
C $AE41,4 Second draw variant: assume off-screen
C $AE45,4 A = animation frame
C $AE49,9 Look up and clip the sprite; returns to $AE52 if visible, else $AEDE
C $AE52,5 Visible: mark the object drawable again
C $AE57,3 set Blit source data pointer (the clipped sprite)
C $AE5A,8 Blit width from C, height from E/2
C $AE62,8 Destination page derived from the frame
C $AE6A,4 E = column byte offset
C $AE6E,11 Screen row from the object's Y (IY+$0D/$0E)
C $AE7C,12 Compare the row against the scroll offset ($9C00); back up a row group if behind
C $AE88,6 Fold the scroll offset back into the row ($9C0F)
C $AE8E,11 Index the row-address table at $9B00
C $AE99,6 Row base + column offset -> $9C11
C $AEA0,7 Mirror flag (IY+$04 bit 6) clear: take the plain path at $AEE1
C $AEA7,5 Mirrored: patch the blit opcode into the drawing program at $AEB4
C $AEAC,4 Run the drawing program at $AEB3 through #R$AFB8
C $AEB3,1 Drawing program (formation-script bytes, not code): blit opcode patched at $AEB4
C $AEB4,1 !!MUT-CMD!! Blit-variant selector of the drawing program above - script data, not an opcode; $AEA9 writes (C OR $10)
C $AEB7,6 Second sprite half needed? skip if the frame index is $08 or above
C $AEBD,4 Point SP at the second-half sprite table ($6B55)
C $AEC1,9 Look up and clip that half; returns to $AECA if visible, else $AEDE
C $AECA,5 set Blit source data pointer (the clipped second half)
C $AECF,6 Patch the blit opcode into the drawing program at $AEDC
C $AED5,4 Run the drawing program at $AEDC through #R$AFB8
C $AEDC,5 !!MUT-CMD!! Drawing program - script data, not code; $AED2 writes (C OR $10) into the selector byte at $AEDC
C $AEE1,7 Unmirrored path: patch the blit opcode into the drawing program at $AEF0
C $AEE8,4 Run the drawing program at $AEEF through #R$AFB8
C $AEEF,1 Drawing program (formation-script bytes, not code): blit opcode patched at $AEF0
C $AEF0,1 !!MUT-CMD!! Blit-variant selector of the drawing program above - script data, not an opcode; $AEE5 writes (A AND $FC)
C $AEF3,6 Second sprite half needed? skip if the frame index is $08 or above
C $AEF9,4 Point SP at the second-half sprite table ($6B55)
C $AEFD,9 Look up and clip that half; returns to $AF06 if visible, else $AF1E
C $AF06,5 set Blit source data pointer (the clipped second half)
C $AF0B,6 Patch the blit opcode into the drawing program at $AF18
C $AF11,4 Run the drawing program at $AF18 through #R$AFB8
C $AF18,3 !!MUT-CMD!! Drawing program - script data, not code; $AF0E writes (C OR $02) into the selector byte at $AF18
C $AF1B,3 Back to the toggle loop
C $AF1E,4 Fully clipped: run the bare drawing program at $AF25
C $AF25,2 Drawing program (formation-script bytes, not code)
C $AF27,3 Back to the toggle loop
C $AF2A,7 Read this frame's sprite descriptor byte from the table at $9B3C
C $AF31,2 Pop the caller's "visible" and "clipped out" return addresses
C $AF33,9 Advance the sprite pointer by (descriptor AND 7) strides
C $AF3C,7 Fold the descriptor into the blit-variant selector
C $AF43,6 C = blit variant; store the row count ($9C19)
C $AF49,7 Sub-cell X shift from the object's X fraction (IY+$0B)
C $AF50,16 Descriptor bit 3: on a shift wrap, back the pointer up one row ($FFE0)
C $AF60,8 Advance the sprite pointer by the remaining shift steps
C $AF68,5 Clip out entirely if the object's row (IY+$0E) is 0
C $AF6D,8 Clip out entirely if the row is $1A or beyond
C $AF75,7 Column relative to the left edge (IY+$0C - 8); branch if positive
C $AF7C,9 Off the left edge: clip out entirely if the whole sprite is past it
C $AF85,10 Skip the source advance for a mask-reversed variant (descriptor bit 3)
C $AF8F,7 Trim the visible width by the clipped amount, return via the visible path
C $AF96,14 Off the right edge: clip out entirely if the whole sprite is past it
C $AFA4,10 Skip the source advance for a mask-reversed variant (descriptor bit 3)
C $AFAE,4 Trim the visible width by the clipped amount
C $AFB2,3 Return to the caller's "visible" continuation
C $AFB5,3 Return to the caller's "clipped out" continuation
c $AFB8 Formation script: read next byte, dispatch via $A000 table (SP=addr/RET trick)
@ $AFB8 label=formation_dispatch
R $AFB8 IX formation-script pointer
C $AFB8,5 read next script byte from (IX), advance script pointer
C $AFBD,4 form address $A0xx from script byte, jump there via faked RET
N $AFB8 The shared bytecode-dispatch core of the enemy formation/wave scripting system: reads the next script byte and jumps to its handler in the #R$A000 table.
C $B002,0 => Formation script
N $B005 Handler for index $02 of the #R$A000 jump table (see #R$B7F6).
C $B06F,0 => Formation script
C $B0B1,0 => Formation script
N $B0B4 Handler for index $06 of the #R$A000 jump table (see #R$B7F6).
C $B11E,0 => Formation script
c $AFC1 Formation opcode $14: jump to (IX)
@ $AFC1 label=jp_ix
N $AFC1 Handler for index $14 of the #R$A000 jump table (see #R$B7F6). A single JP (IX) - an indirect dispatch that continues execution at whatever address IX currently holds.
c $AFC3 Update tile-block tables ($7900+) from SP-fed data (index $00, INC L)
N $AFC3 Handler for index $00 of the #R$A000 jump table. Fills a page of the 2x2 tile-block tables from popped stack data, ascending; twin of #R$B072 which fills descending. Continues into the formation script (#R$AFB8).
C $AFC3,4 Source data via SP (POP-fed)
C $AFC7,3 B = column/pass count ($9C1A)
C $AFCB,2 H=$79: destination tile-block table page
C $AFCD,2 A=$F0: row index start (writes ascending)
C $AFCF,1 Set row index for this pass
C $AFD0,3 Store low byte of popped word, ascending (iteration 1/16)
C $AFD3,3 iteration 2/16
C $AFD6,3 iteration 3/16
C $AFD9,3 iteration 4/16
C $AFDC,3 iteration 5/16
C $AFDF,3 iteration 6/16
C $AFE2,3 iteration 7/16
C $AFE5,3 iteration 8/16
C $AFE8,3 iteration 9/16
C $AFEB,3 iteration 10/16
C $AFEE,3 iteration 11/16
C $AFF1,3 iteration 12/16
C $AFF4,3 iteration 13/16
C $AFF7,3 iteration 14/16
C $AFFA,3 iteration 15/16
C $AFFD,2 iteration 16/16 (no INC L, next page picks up at $F0)
C $AFFF,1 Next page ($7A/$7B/$7C)
C $B000,2 Loop B passes
C $B002,3 => Formation script
c $B005 Opaque tile blit (index $02): copy $9A00[C] to screen, INC E stride
C $B00A,4 Source tile data via SP (POP-fed)
C $B00E,3 Destination high byte = width + $78
C $B013,3 Self-modify row-start column operand
C $B016,2 H=$9A: point at the #R$9A00 lookup table
C $B01A,2 !!MUT-ARG!! patched by $B013
C $B01C,5 Copy column: store #R$9A00[C] straight to screen (opaque, no mask) (iteration 1/16)
C $B021,5 iteration 2/16
C $B026,5 iteration 3/16
C $B02B,5 iteration 4/16
C $B030,5 iteration 5/16
C $B035,5 iteration 6/16
C $B03A,5 iteration 7/16
C $B03F,5 iteration 8/16
C $B044,5 iteration 9/16
C $B049,5 iteration 10/16
C $B04E,5 iteration 11/16
C $B053,5 iteration 12/16
C $B058,5 iteration 13/16
C $B05D,5 iteration 14/16
C $B062,5 iteration 15/16
C $B067,4 iteration 16/16 (no INC E, row-base decrement follows)
C $B06B,1 Next row column-base
C $B06D,2 Loop $9C1A rows
C $B06F,3 => Formation script
c $B072 Update tile-block tables ($7900+) from SP-fed data (index $04)
N $B072 Handler for index $04 of the #R$A000 jump table. Fills a page of the 2x2 tile-block tables from popped stack data, descending; twin of #R$AFC3 which fills ascending. Continues into the formation script (#R$AFB8).
C $B072,4 Source data via SP (POP-fed)
C $B076,3 B = column/pass count ($9C1A)
C $B07A,2 H=$79: destination tile-block table page
C $B07C,2 A=$FF: row index start (writes descending)
C $B07E,1 Set row index for this pass
C $B07F,3 Store low byte of popped word, descending (iteration 1/16)
C $B082,3 iteration 2/16
C $B085,3 iteration 3/16
C $B088,3 iteration 4/16
C $B08B,3 iteration 5/16
C $B08E,3 iteration 6/16
C $B091,3 iteration 7/16
C $B094,3 iteration 8/16
C $B097,3 iteration 9/16
C $B09A,3 iteration 10/16
C $B09D,3 iteration 11/16
C $B0A0,3 iteration 12/16
C $B0A3,3 iteration 13/16
C $B0A6,3 iteration 14/16
C $B0A9,3 iteration 15/16
C $B0AC,2 iteration 16/16 (no DEC L, next page picks up at $FF)
C $B0AE,1 Next page ($7A/$7B/$7C)
C $B0AF,2 Loop B passes
C $B0B1,3 => Formation script
c $B0B4 Opaque tile blit (index $06): copy $9A00[C] to screen, no masking
C $B0B9,4 Source tile data via SP (POP-fed)
C $B0BD,3 Destination high byte = width + $78
C $B0C2,3 Self-modify row-start column operand
C $B0C5,2 H=$9A: point at the #R$9A00 lookup table
C $B0C9,2 !!MUT-ARG!! patched by $B0C2
C $B0CB,5 Copy column: store #R$9A00[C] straight to screen (opaque, no mask) (iteration 1/16)
C $B0D0,5 iteration 2/16
C $B0D5,5 iteration 3/16
C $B0DA,5 iteration 4/16
C $B0DF,5 iteration 5/16
C $B0E4,5 iteration 6/16
C $B0E9,5 iteration 7/16
C $B0EE,5 iteration 8/16
C $B0F3,5 iteration 9/16
C $B0F8,5 iteration 10/16
C $B0FD,5 iteration 11/16
C $B102,5 iteration 12/16
C $B107,5 iteration 13/16
C $B10C,5 iteration 14/16
C $B111,5 iteration 15/16
C $B116,4 iteration 16/16 (no DEC E, row-base decrement follows)
C $B11A,1 Next row column-base
C $B11C,2 Loop $9C1A rows
C $B11E,3 => Formation script
c $B121 Masked tile blit setup (index $01): to tile-block table, run $B1BE body
N $B121 Sets up a masked blit with destination $79F0 (into the 2x2 tile-block tables, not the screen) and jumps into the shared body at #R$B1C6 inside #R$B1BE.
C $B121,4 Source tile data via SP (POP-fed)
C $B125,3 Destination = tile-block buffer $79F0
C $B128,3 Run the shared masked-blit body (#R$B1BE)
c $B12B Masked tile blit setup (index $03): configure, then run $B24A body
N $B12B Handler for index $03 of the #R$A000 jump table (see #R$B7F6). Sets up a masked tile blit (source via SP, dest high = width+$78, self-modified row-start operand = $F0) and jumps into the shared blit body at #R$B25E inside #R$B24A.
C $B130,4 Source tile data via SP (POP-fed)
C $B134,3 Destination high byte = width + $78
C $B139,3 Self-modify #R$B24A's row-start operand ($F0)
C $B13C,3 Run the shared masked-blit body (#R$B25E)
c $B13F Masked tile blit setup (index $05): to tile-block table, run $B2DA body
N $B13F Sets up a masked blit with destination page $79 (into the 2x2 tile-block tables, not the screen) and jumps into the shared body at #R$B2E7 inside #R$B2DA.
C $B13F,4 Source tile data via SP (POP-fed)
C $B143,2 Destination page = $79 (tile-block table)
C $B147,3 Run the shared masked-blit body (#R$B2DA)
c $B14A Masked tile blit setup (index $07): run $B36A body
N $B14A Sets up a masked blit with destination high byte = width+$78 (screen) and jumps into the shared body at #R$B37F inside #R$B36A.
C $B14A,3 B = column/pass count ($9C1A)
C $B14F,4 Source tile data via SP (POP-fed)
C $B153,3 Destination high byte = width + $78
C $B158,3 Run the shared masked-blit body (#R$B36A)
c $B15B OR-composite tile-block pages onto screen (index $10)
N $B15B Handler for index $10 of the #R$A000 jump table. OR-merges the tile-block table pages onto the destination screen (additive overlay, not opaque). Continues into the formation script (#R$AFB8).
C $B15B,4 Destination screen address ($9C13)
C $B160,3 Self-modify row-start column operand
C $B163,3 Source = tile-block buffer $79F0
C $B16C,1 Source via SP (POP-fed)
C $B16D,2 !!MUT-ARG!! patched by $B160
C $B16F,9 OR-merge two source bytes into consecutive dest cells (iteration 1/8)
C $B178,9 iteration 2/8
C $B181,9 iteration 3/8
C $B18A,9 iteration 4/8
C $B193,9 iteration 5/8
C $B19C,9 iteration 6/8
C $B1A5,9 iteration 7/8
C $B1AE,8 iteration 8/8 (no final INC E, next page/row follows)
C $B1B6,1 Next source page ($7A/$7B/$7C)
C $B1B7,1 Next dest row
C $B1B9,2 Loop $9C1A passes
C $B1BB,3 => Formation script
C $B247,0 => Formation script
C $B2D7,0 => Formation script
C $B367,0 => Formation script
C $B3FB,0 => Formation script
N $B3FE Handler for index $08 of the #R$A000 jump table (see #R$B7F6).
C $B44F,0 => Formation script
N $B452 Handler for index $0A of the #R$A000 jump table (see #R$B7F6).
C $B4A7,0 => Formation script
N $B4AA Handler for index $0C of the #R$A000 jump table (see #R$B7F6).
C $B4FF,3 => Formation script
N $B502 Handler for index $0E of the #R$A000 jump table (see #R$B7F6).
c $B1BE Draw masked sprite 16-row, mask-rev (index $09): AND $9A00[B], XOR C, INC E
N $B1BE Draws a masked sprite column by column onto the screen, blending each byte with the background through a lookup-table mask. Handler for index $09 of the #R$A000 jump table; continues into the formation script (#R$AFB8).
C $B1BE,4 Source sprite data via SP (POP-fed)
C $B1C2,4 Destination screen address ($9C13)
C $B1C6,2 H=$9A: point at the #R$9A00 lookup table
C $B1C9,3 Self-modify row-start column operand
C $B1D2,2 !!MUT-ARG!! patched by $B1C9
C $B1D4,7 Blit column: mask via #R$9A00[B], merge XOR C, store (iteration 1/16)
C $B1DB,7 iteration 2/16
C $B1E2,7 iteration 3/16
C $B1E9,7 iteration 4/16
C $B1F0,7 iteration 5/16
C $B1F7,7 iteration 6/16
C $B1FE,7 iteration 7/16
C $B205,7 iteration 8/16
C $B20C,7 iteration 9/16
C $B213,7 iteration 10/16
C $B21A,7 iteration 11/16
C $B221,7 iteration 12/16
C $B228,7 iteration 13/16
C $B22F,7 iteration 14/16
C $B236,7 iteration 15/16
C $B23D,6 iteration 16/16 (no final INC E, row-base decrement follows)
C $B243,1 Next row column-base
C $B245,2 Loop $9C1A rows
C $B247,3 => Formation script
c $B24A Draw masked sprite 16-row, pixel-rev (index $0B): AND B, XOR $9A00[C], INC E
N $B24A Draws a masked sprite column by column onto the screen, same technique as #R$B1BE but with the mask/pixel roles swapped. Handler for index $0B of the #R$A000 jump table; continues into the formation script (#R$AFB8).
C $B24F,4 Source sprite data via SP (POP-fed)
C $B253,4 Destination screen address ($9C13)
C $B25B,3 Self-modify row-start column operand
C $B25E,2 H=$9A: point at the #R$9A00 lookup table
C $B262,2 !!MUT-ARG!! patched by $B139
C $B264,7 Blit column: mask background (AND B), merge sprite (XOR #R$9A00[C]), store (iteration 1/16)
C $B26B,7 iteration 2/16
C $B272,7 iteration 3/16
C $B279,7 iteration 4/16
C $B280,7 iteration 5/16
C $B287,7 iteration 6/16
C $B28E,7 iteration 7/16
C $B295,7 iteration 8/16
C $B29C,7 iteration 9/16
C $B2A3,7 iteration 10/16
C $B2AA,7 iteration 11/16
C $B2B1,7 iteration 12/16
C $B2B8,7 iteration 13/16
C $B2BF,7 iteration 14/16
C $B2C6,7 iteration 15/16
C $B2CD,6 iteration 16/16 (no final INC E, row-base decrement follows)
C $B2D3,1 Next row column-base
C $B2D5,2 Loop $9C1A rows
C $B2D7,3 => Formation script
c $B2DA Draw masked sprite 16-row, mask-rev (index $0D): AND $9A00[B], XOR C, DEC E
N $B2DA Draws a masked sprite column by column onto the screen, same technique as #R$B1BE but scanning right-to-left. Handler for index $0D of the #R$A000 jump table; continues into the formation script (#R$AFB8).
C $B2DA,4 Source sprite data via SP (POP-fed)
C $B2DE,4 Destination screen address ($9C13)
C $B2E9,3 Self-modify row-start column operand
C $B2E7,2 H=$9A: point at the #R$9A00 lookup table
C $B2F2,2 !!MUT-ARG!! patched by $B2E9
C $B2F4,7 Blit column (DEC E stride): mask via #R$9A00[B], merge XOR C, store (iteration 1/16)
C $B2FB,7 iteration 2/16
C $B302,7 iteration 3/16
C $B309,7 iteration 4/16
C $B310,7 iteration 5/16
C $B317,7 iteration 6/16
C $B31E,7 iteration 7/16
C $B325,7 iteration 8/16
C $B32C,7 iteration 9/16
C $B333,7 iteration 10/16
C $B33A,7 iteration 11/16
C $B341,7 iteration 12/16
C $B348,7 iteration 13/16
C $B34F,7 iteration 14/16
C $B356,7 iteration 15/16
C $B35D,6 iteration 16/16 (no final DEC E, row-base increment follows)
C $B363,1 Next row column-base
C $B365,2 Loop rows
C $B367,3 => Formation script
c $B36A Draw masked sprite 16-row, pixel-rev (index $0F): AND B, XOR $9A00[C], DEC E
N $B36A Draws a masked sprite column by column onto the screen, same technique as #R$B24A but scanning right-to-left. Handler for index $0F of the #R$A000 jump table; continues into the formation script (#R$AFB8).
C $B36F,4 Source sprite data via SP (POP-fed)
C $B373,4 Destination screen address ($9C13)
C $B377,3 Add X offset ($9C1A) to dest high byte
C $B37A,3 Add Y offset ($9C1B) to dest low byte
C $B37F,3 Self-modify row-start column operand
C $B382,2 H=$9A: point at the #R$9A00 lookup table
C $B386,2 !!MUT-ARG!! patched by $B37F
C $B388,7 Blit column: mask background (AND B), merge sprite (XOR #R$9A00[C]), store (iteration 1/16)
C $B38F,7 iteration 2/16
C $B396,7 iteration 3/16
C $B39D,7 iteration 4/16
C $B3A4,7 iteration 5/16
C $B3AB,7 iteration 6/16
C $B3B2,7 iteration 7/16
C $B3B9,7 iteration 8/16
C $B3C0,7 iteration 9/16
C $B3C7,7 iteration 10/16
C $B3CE,7 iteration 11/16
C $B3D5,7 iteration 12/16
C $B3DC,7 iteration 13/16
C $B3E3,7 iteration 14/16
C $B3EA,7 iteration 15/16
C $B3F1,6 iteration 16/16 (no final DEC E, row-base decrement follows)
C $B3F7,1 Next row column-base
C $B3F9,2 Loop rows
C $B3FB,3 => Formation script
c $B3FE Draw masked sprite 8-row, mask-rev (index $08): AND $9A00[B], XOR C, INC E
N $B3FE Draws a masked sprite column by column onto the screen, same technique as #R$B1BE but 8 rows tall. Handler for index $08 of the #R$A000 jump table; continues into the formation script (#R$AFB8).
C $B3FE,4 Source tile data via SP (POP-fed)
C $B402,4 Destination screen address ($9C13)
C $B406,2 H=$9A: point at the #R$9A00 lookup table
C $B409,3 Self-modify row-start column operand
C $B412,2 !!MUT-ARG!! patched by $B409
C $B414,7 Blit column: mask via #R$9A00[B], merge XOR C, store (iteration 1/8)
C $B41B,7 iteration 2/8
C $B422,7 iteration 3/8
C $B429,7 iteration 4/8
C $B430,7 iteration 5/8
C $B437,7 iteration 6/8
C $B43E,7 iteration 7/8
C $B445,6 iteration 8/8 (no final INC E, row-base increment follows)
C $B44B,1 Next row column-base
C $B44D,2 Loop $9C1A rows
C $B44F,3 => Formation script
c $B452 Draw masked sprite 8-row, pixel-rev (index $0A): AND B, XOR $9A00[C], INC E
N $B452 Draws a masked sprite column by column onto the screen, same technique as #R$B24A but 8 rows tall. Handler for index $0A of the #R$A000 jump table; continues into the formation script (#R$AFB8).
C $B457,4 Source tile data via SP (POP-fed)
C $B45B,4 Destination screen address ($9C13)
C $B45F,3 Add X offset ($9C1A) to dest high byte
C $B463,3 Self-modify row-start column operand
C $B466,2 H=$9A: point at the #R$9A00 lookup table
C $B46A,2 !!MUT-ARG!! patched by $B463
C $B46C,7 Blit column: mask background (AND B), merge sprite (XOR #R$9A00[C]), store (iteration 1/8)
C $B473,7 iteration 2/8
C $B47A,7 iteration 3/8
C $B481,7 iteration 4/8
C $B488,7 iteration 5/8
C $B48F,7 iteration 6/8
C $B496,7 iteration 7/8
C $B49D,6 iteration 8/8 (no final INC E, row-base decrement follows)
C $B4A3,1 Next row column-base
C $B4A5,2 Loop $9C1A rows
C $B4A7,3 => Formation script
c $B4AA Draw masked sprite 8-row, mask-rev (index $0C): AND $9A00[B], XOR C, DEC E
N $B4AA Draws a masked sprite column by column onto the screen, same technique as #R$B1BE but 8 rows tall and scanning right-to-left. Handler for index $0C of the #R$A000 jump table; continues into the formation script (#R$AFB8).
C $B4AA,4 Source tile data via SP (POP-fed)
C $B4AE,4 Destination screen address ($9C13)
C $B4B2,3 Add Y offset ($9C1B) to dest low byte
C $B4B7,2 H=$9A: point at the #R$9A00 lookup table
C $B4B9,3 Self-modify row-start column operand
C $B4C2,2 !!MUT-ARG!! patched by $B4B9
C $B4C4,7 Blit column: mask via #R$9A00[B], merge XOR C, store (iteration 1/8)
C $B4CB,7 iteration 2/8
C $B4D2,7 iteration 3/8
C $B4D9,7 iteration 4/8
C $B4E0,7 iteration 5/8
C $B4E7,7 iteration 6/8
C $B4EE,7 iteration 7/8
C $B4F5,6 iteration 8/8 (no final DEC E, row-base increment follows)
C $B4FB,1 Next row column-base
C $B4FD,2 Loop $9C1A rows
c $B502 Draw masked sprite 8-row, pixel-rev (index $0E): AND B, XOR $9A00[C], DEC E
N $B502 Draws a masked sprite column by column onto the screen, same technique as #R$B24A but 8 rows tall and scanning right-to-left. Handler for index $0E of the #R$A000 jump table; continues into the formation script (#R$AFB8).
C $B507,4 Source tile data via SP (POP-fed)
C $B50B,4 Destination screen address ($9C13)
C $B50F,3 Add X offset ($9C1A) to dest high byte
C $B512,3 Add Y offset ($9C1B) to dest low byte
C $B517,3 Self-modify row-start column operand
C $B51A,2 H=$9A: point at the #R$9A00 lookup table
C $B51E,2 !!MUT-ARG!! patched by $B517
C $B520,7 Blit column: mask background (AND B), merge sprite (XOR #R$9A00[C]), store (iteration 1/8)
C $B527,7 iteration 2/8
C $B52E,7 iteration 3/8
C $B535,7 iteration 4/8
C $B53C,7 iteration 5/8
C $B543,7 iteration 6/8
C $B54A,7 iteration 7/8
C $B551,6 iteration 8/8 (no final DEC E, row-base decrement follows)
C $B557,1 Next row column-base
C $B559,2 Loop $9C1A rows
C $B55B,3 => Formation script
c $B55E Copy 8-wide screen strips (SP-trick, screen-third aware)
N $B55E Handler for index $11 of the #R$A000 jump table. Copies vertical 8-byte-wide screen strips, picking one of three copy loops so the blit steps correctly across the ZX screen's non-linear thirds. Continues into the formation script (#R$AFB8).
C $B561,5 Row count from $9C19 (+1)
C $B56C,4 Pick copy variant by column vs $C8 (screen-third boundary)
C $B577,1 Point SP at strip for the pointer-swap trick
C $B57A,2 Swap source/dest pointers via EX (SP),HL
C $B57C,16 Copy 8 bytes of this strip row
C $B58E,3 Advance column (+8) and dest row (+$24)
C $B591,2 Loop rows
C $B593,3 => Formation script
C $B599,5 Point SP at this strip, swap source/dest pointers via EX (SP),HL
C $B59E,16 Copy 8 bytes of this strip row
C $B5AE,5 Advance to the next screen third (INC H), point at the next strip
C $B5B3,16 Copy 8 bytes of this strip row
C $B5C3,2 Mirror back (DEC H) after crossing the third
C $B5CB,3 => Formation script
C $B5CE,1 B = row count
C $B5CF,5 Point SP at this strip, swap source/dest pointers via EX (SP),HL
C $B5D4,16 Copy 8 bytes of this strip row
C $B5E4,5 Advance to the next screen third (INC H), point at the next strip
C $B5E9,16 Copy 8 bytes of this strip row
C $B5F9,5 Advance to the next screen third (INC H), point at the next strip
C $B5FE,16 Copy 8 bytes of this strip row
C $B60E,3 Mirror back (2x DEC H) after crossing both thirds
C $B617,3 => Formation script
c $B61A Copy 8-wide screen strips with transparency skip (screen-third aware)
N $B61A Handler for index $12 of the #R$A000 jump table. Same vertical strip copy as #R$B55E, but skips strips that are entirely blank - a transparent-strip blit. Continues into the formation script (#R$AFB8).
C $B61D,5 Row count from $9C19 (+1)
C $B62C,4 Pick copy variant by column vs $C8 (screen-third boundary)
C $B623,4 Column source ($9C0F)
C $B637,1 Point SP at this strip
C $B63A,1 Read the strip's first word
C $B65A,7 Check whether the last strip was the rightmost column
C $B63B,5 Skip strip if high byte masks to zero (transparent)
C $B642,16 Copy 8 bytes of this strip
C $B653,3 Advance column (+8)
C $B657,1 Advance dest row (+$24)
C $B658,2 Loop rows
C $B664,4 Set redraw flag (IY+$04 bit 0)
C $B661,3 => Formation script
C $B668,3 => Formation script
C $B6B4,3 => Formation script
C $B6BB,3 => Formation script
C $B723,3 => Formation script
C $B72A,3 => Formation script
N $B72D Handler for index $13 of the #R$A000 jump table (see #R$B7F6).
c $B72D => Formation script
@ $B72D label=jp_formation_dispatch
C $B72D,3 => Formation script
c $B730 Initialize wave: build object pool, reset counts, spawn first object
N $B730 Sets up the object pool and enemy-group counters for a new wave, then spawns the first object.
C $B733,3 Free-list head ($9D1C) = first pool slot
C $B742,10 Link each slot to the next (IY+0/+1), clear IY+$14
C $B74F,2 Loop 19 pool slots
C $B75D,8 Init 4 fixed slots: set active+alive flags
C $B765,8 Store next-pointer, advance to next fixed slot
C $B781,4 Clear the 8 formation-slot pairs ($9B4F, 16 bytes)
C $B785,20 Set the four per-group enemy counts
C $B79A,3 Allocate object from free-list pool and initialize
c $B79F Mark formation slot done, trigger completion effect when group empties
R $B79F IY object struct base
N $B79F Marks an object's formation slot done. Once its whole group has emptied, triggers the group's completion effect (explosion or score-award) and decrements the group counter. The tail from #R$B7DC onward (an SP=IY stack trick) is not yet analyzed.
C $B79F,4 entry: normal call, C=0
C $B7A3,3 entry: alternate call, C=$FF
C $B7A6,7 clear flag at IY+14; read formation-slot index from IY+13
C $B7AD,4 skip if slot unused ($FF)
C $B7B1,8 index this slot's mask byte ($9B50 + 2*slot), clear the object's bit via C
C $B7B9,1 write back masked bitmap byte
C $B7BA,4 step back to the slot's count byte and decrement it; skip if still nonzero
C $B7BE,3 skip if counter was already zero
C $B7C1,6 mark slot done; check completion mode
C $B7C7,2 branch to alternate completion path
C $B7C9,5 Decrement wave-group counter
C $B7CE,6 check game mode flag at $9C3F
C $B7D4,3 Convert object to explosion
C $B7D7,5 decrement group counter at $9D18, return
C $B7E3,3 !!MUT-ARG!! patched by $BDBF
C $B7EE,3 !!MUT-ARG!! patched by $B7DC
c $B7F6 Jump-table dispatcher: JP to word-sized table entry A
N $B7F6 Jumps to the routine whose address sits at entry A of the word table pointed to by HL.
@ $B7F6 label=jump_table_dispatch
R $B7F6 A word index into the jump table
R $B7F6 HL jump table base address
c $B7FE Pseudo-random number generator (advances LFSR state at $9C2B-$9C32)
@ $B7FE label=random
N $B7FE Advances an 8-byte shift-register state and returns a new pseudo-random byte, without disturbing the caller's registers.
R $B7FE O:A pseudo-random byte
R $B7FE BC,DE,HL preserved (saved into self-modified operands at entry, restored before RET)
C $B7FE,3 Self-modify: save caller's HL (restored at $B841)
C $B801,4 Self-modify: save caller's DE (restored at $B83E)
C $B805,4 Self-modify: save caller's BC (restored at $B83B)
C $B809,3 Point HL at LFSR state top byte
C $B80C,2 Rotate top byte through carry
C $B827,2 Mix rotated nibbles into new state byte
C $B83B,3 !!MUT-ARG!! Restore caller's BC (patched by $B805)
C $B83E,3 !!MUT-ARG!! Restore caller's DE (patched by $B801)
C $B841,3 !!MUT-ARG!! Restore caller's HL (patched by $B7FE)
c $B845 Compute angle from object IX to target IY
@ $B845 label=calc_angle
R $B845 IX object position (shooter)
R $B845 IY target position (e.g. player)
N $B845 Computes the coarse angle (0-63) from the shooter to its target, for use by aiming/movement code such as #R$C43C. A rough atan2 built from position deltas and a linear-search division, not a lookup table.
C $B84E,3 Delta X = rounded IX position minus IY column
C $B85B,3 Delta Y = rounded IX position minus IY row
C $B863,3 Skip abs-negate if delta Y already positive
C $B86D,3 Skip abs-negate if delta X already positive
C $B879,2 Swap X/Y (octant refinement) if X >= Y
C $B884,2 Clamp check against threshold $03
C $B896,2 Division-loop exit when remainder hits zero
C $B89A,2 Division loop: continue while remainder >= Y
c $B8A2 Compute velocity vector (dx,dy) from angle and speed
@ $B8A2 label=angle_to_velocity
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
@ $B8DB label=set_object_position
N $B8DB Sets an object's on-screen position, keeping its column within the playable screen area.
R $B8DB IY object struct base (writes position fields IY+$0B/$0C/$0D)
C $B8DB,10 Snap Y to the top ($9C01), reset X to the left edge
C $B8E5,5 Read the object's column
C $B8EA,2 Skip left-edge clamp if column is already in range
C $B8EC,5 Clamp column at the left edge (8)
C $B8F1,3 Skip right-edge clamp if column is already in range
C $B8F4,5 Clamp column at the right edge ($18)
c $B8F9 Movement-pattern script interpreter
@ $B8F9 label=movement_script_run
R $B8F9 IY object struct base
N $B8F9 Runs an object's movement-pattern script one step at a time, waiting out a per-object timer between steps before continuing into #R$B920 to decode the next script byte.
C $B8F9,11 Count down the frame-delay timer (IY+$18); branch when it expires
C $B904,3 Dispatched step's script byte (IY+$17)
C $B907,6 Mask to 0-7, dispatch via the #R$A076 sub-table
C $B914,10 Timer expired: default to 1 frame, load the script pointer
C $B90D,3 Jump-table dispatcher
C $B911,3 => Movement-pattern script interpreter
c $B920 Decode movement-script "wait" byte (bit 7 set = wait N or random frames)
N $B920 Decodes the next movement-script byte: a wait command reloads the frame-delay timer, otherwise it's a step index handled by the fallthrough at #R$B935.
R $B920 A script byte to decode
C $B920,4 High bit clear: not a wait, fall through to step dispatch
C $B924,4 Low 7 bits = wait frame count
C $B928,2 Value 1 means random wait
C $B92A,3 Pseudo-random number generator
C $B92D,3 Random wait = 1-32 frames
N $B941 Handler for index $3B of the #R$A000 jump table (see #R$B7F6).
c $B941 Movement opcode $3B: dispatch sub-command (C bits 3-6) via $A082
@ $B941 label=mvop_dispatch_sub
C $B94A,3 Jump-table dispatcher
c $B94E Read next movement-script byte into E
@ $B94E label=movement_next_byte
N $B94E Fetches the next byte of an object's movement script and advances its script pointer.
R $B94E IY object struct base (script pointer at IY+$15/$16)
R $B94E O:E the fetched script byte
R $B94E HL preserved; advances the object's script pointer (IY+$15/$16)
N $B95F Handler for index $3C of the #R$A000 jump table (see #R$B7F6).
C $B96C,3 Read next movement-script byte into E
N $B974 Handler for index $3D of the #R$A000 jump table (see #R$B7F6).
C $B98A,3 Compute velocity vector (dx,dy) from angle and speed
c $B95F Movement opcode $3C: set field IY+$19 (from C or next script byte)
@ $B95F label=mvop_set_iy19
N $B95F Sets a per-object field, its value either packed into the opcode byte itself or, if that's zero, read as a following script byte.
C $B95F,3 C's high nibble as the value; skip if zero
C $B964,7 Extract the value, store, signal continue
C $B96F,3 Otherwise: store the value read by #R$B94E, signal continue
c $B974 Movement opcode $3D: set absolute heading, apply velocity
N $B974 Sets the object's heading to a value packed into the opcode byte, mirroring it if the object faces left, then moves it.
C $B974,4 Extract heading value from C
C $B978,6 Mirror the heading if the object faces left (IY+$04 bit 7)
C $B984,3 Store the new heading
C $B987,3 B = speed (IY+$11)
@ $B974 label=mvop_set_heading
C $B98D,3 Apply object velocity (dx,dy) to position
c $B992 Movement opcode $3E: turn heading relative, apply velocity
@ $B992 label=mvop_turn_heading
N $B992 Turns the object's heading by an amount and sign packed into the opcode byte, then moves it.
C $B992,6 Mirror the turn direction if the object faces left (IY+$04 bit 7)
C $B99C,7 Extract turn amount from C
C $B9A3,6 Negate the turn if C bit 6 is set
C $B9A9,8 Apply the turn to the current heading (IY+$10)
C $B9B1,3 B = speed (IY+$11)
C $B9B4,3 Compute velocity vector (dx,dy) from angle and speed
C $B9B7,3 Apply object velocity (dx,dy) to position
N $B9BC Handler for index $3F of the #R$A000 jump table (see #R$B7F6).
N $B9CA Handler for index $40 of the #R$A000 jump table (see #R$B7F6).
C $B9D2,3 Read next movement-script byte into E
C $B9D9,3 Read next movement-script byte into E
C $B9DC,3 !!MUT-ARG!! patched by $B9D6
N $B9E3 Handler for index $41 of the #R$A000 jump table (see #R$B7F6).
c $B9BC Movement opcode $3F: set/clear mirror flag (IY+$04 bit 6)
@ $B9BC label=mvop_set_mirror
c $B9CA Movement opcode $40: set N object fields from script (offset,value pairs)
@ $B9CA label=mvop_set_fields
c $B9E3 Movement opcode $41: clear velocity (dx,dy = 0)
@ $B9E3 label=clear_velocity
c $B9F1 Movement opcode $42: loop back in script until counter IY+$19 expires
@ $B9F1 label=mvop_loop
N $B9F1 Handler for index $42 of the #R$A000 jump table (see #R$B7F6).
C $B9F1,3 Read next movement-script byte into E
C $B9F4,5 Decrement loop counter (IY+$19), return if it hit zero
C $B9F9,15 Otherwise rewind the script pointer by E bytes
c $BA0A Apply object velocity (dx,dy) to position
@ $BA0A label=apply_velocity
R $BA0A IY object struct base
N $BA0A SP=IY stack trick: adds the velocity fields (set by #R$B8A2, IY+7/+8 and IY+9/+10) onto the position fields (IY+11/+12 and IY+13/+14). The generic "move by velocity" step; also index $43 of the #R$A000 jump table.
C $BA0A,4 Save caller's SP (restored at $BA1E)
C $BA0E,7 Point SP at the object's velocity fields (IY+7)
C $BA15,3 Pop dx, dy, X into HL/DE/BC
C $BA18,2 X += dx
C $BA1A,2 Y += dy
C $BA1C,2 Write both updated coordinates back
C $BA1E,3 !!MUT-ARG!! Restore SP (patched by $BA0A)
N $BA23 Handler for index $44 of the #R$A000 jump table (see #R$B7F6).
c $BA23 Movement opcode $44: no-op
@ $BA23 label=mvop_nop
N $BA25 Handler for index $45 of the #R$A000 jump table (see #R$B7F6).
N $BA2B Handler for index $46 of the #R$A000 jump table (see #R$B7F6).
c $BA25 Movement opcode $45: set object alive flag (IY+$04 bit 1)
@ $BA25 label=mvop_set_alive
c $BA2B Movement opcode $46: turn heading toward target ($9C6D)
@ $BA2B label=mvop_aim_target
C $BA2F,3 Compute angle from object IX to target IY
C $BA3F,3 Movement opcode $3E
C $BA43,3 Pseudo-random number generator
N $BA43 Handler for index $47 of the #R$A000 jump table (see #R$B7F6).
C $BA4F,3 Pseudo-random number generator
N $BA4F Handler for index $48 of the #R$A000 jump table (see #R$B7F6).
c $BA43 Movement opcode $47: set random column (IY+$0C)
@ $BA43 label=mvop_random_column
c $BA4F Movement opcode $48: randomly set/clear direction flag (IY+$04 bit 7)
@ $BA4F label=mvop_random_dir
c $BA5F Spawn a group of formation objects from the free-list pool
N $BA5F Called from #R$C981 (column spawn markers) and #R$C9AF (enemy timeline). Finds the first free formation slot at $9B4F, works out how many objects to spawn from the remaining wave counter ($9D18) against a per-group budget table at $5CF4, then pops that many objects off the free list ($9D1C) via an SP-trick and initializes each from a spawn-template table at $5B55 (index*9 + $5B55), applying a difficulty offset ($9C41). Returns carry set on success.
R $BA5F O:Cy set if a group was spawned
C $BA63,2 Exit if wave counter is zero
C $BA65,3 Scan the 8 formation slots ($9B4F, stride 2) for the first free one
C $BA74,2 Compute slot index (8-B)
C $BA77,3 Store slot index at $BB55
C $BA7B,6 E = (D high nibble) + $30
C $BA81,10 D = (D low nibble * 16) + 8
C $BA8B,6 Save C's top 2 bits to self-modified operand $BB41
C $BA91,1 Clear those bits from C (mask to 0-$3F)
C $BA92,5 HL = $5B29 + masked C: index tag-to-group table
C $BA97,3 C = looked-up group index (BC for word math)
C $BAAF,3 Pop head of free-object list ($9D1C)
C $BAB5,4 Save SP (self-modified operand, restored below)
C $BA9A,5 Index group-budget table at $5CF4 (2 bytes/entry)
C $BAA3,3 Clamp spawn count to remaining wave counter ($9D18)
C $BAA7,4 Deduct spawned count from wave counter
C $BAB9,4 SP-trick: pop B objects off the free list
C $BABD,3 Update free-list head ($9D1C)
C $BAC2,4 Store allocated object pointer at $BBB4
C $BAC6,3 !!MUT-ARG!! Restore SP (patched by $BAB5)
C $BACD,2 Write object-index byte
C $BAD3,4 Type 1: consume a $9C69 credit
C $BAEA,3 Read spawn-template index byte
C $BAEF,6 Index template table at $5B55 (index*9 + $5B55)
C $BAF8,5 Template byte 0 -> IX+$05
C $BAFD,5 Template byte 1 -> IX+$12
C $BB02,5 Template byte 2 -> IX+$1A
C $BB07,8 Add difficulty offset ($9C41), clamp to $FF; template byte 3 -> IX+$1B
C $BB13,5 Template byte 4 -> IX+$11
C $BB18,5 Template byte 5 -> IX+$02 (not a code pointer - see #R$5B55)
C $BB1D,5 Template byte 6 -> IX+$03
C $BB22,4 Template bytes 7,8 (little-endian) = a fixed-slot address ($9D1E/$9D24/$9D2A)
C $BB26,6 Save that address into the read-modify-write tail's operands ($BBB6/$BBBA)
C $BB3E,4 !!MUT-ARG!! Init object fields from the self-modified operands just patched above (patched by $BA8E)
C $BB42,4 !!MUT-ARG!! patched by $BB1A
C $BB46,4 !!MUT-ARG!! patched by $BB1F
C $BB4A,4 !!MUT-ARG!! patched by $BAFF
C $BB4E,4 !!MUT-ARG!! patched by $BAFA
C $BB52,4 !!MUT-ARG!! patched by $BA77
C $BB56,4 !!MUT-ARG!! patched by $BB04
C $BB5A,4 !!MUT-ARG!! patched by $BB10
C $BB5E,4 !!MUT-ARG!! patched by $BB15
C $BB72,3 Read the byte at the fixed-slot address (movement-script selector)
C $BB75,3 Index $5B00 table by that byte
C $BB78,3 E = looked-up offset, D = 0
C $BB7B,5 HL = $5BAF + 2*offset: entry point into the shared script bytecode
C $BB80,6 Store script entry point at object's IX+$15/$16
C $BBB3,3 !!MUT-ARG!! Restore SP (patched by $BAC2)
C $BBB6,3 !!MUT-ARG!! Read the word currently at the fixed-slot address (patched by $BB26)
C $BBB9,1 Swap it with the stack top
C $BBBA,3 !!MUT-ARG!! Write the swapped value back to the fixed-slot address (patched by $BB29)
C $BBBD,3 !!MUT-ARG!! patched by $BB3A
c $BBC2 Clear buffers at $7F00-$7FFF and $8000-$80FF (fast PUSH fill)
@ $BBC2 label=clear_buffers
N $BBC2 Zeroes two 256-byte buffers each frame using a fast PUSH-unroll fill, the same technique shared by other fast-fill routines in this game.
C $BBC2,3 DE=$0000 (fill value)
C $BBC5,5 Point HL/B at first buffer ($7F00, 16 groups of 8)
C $BBCA,3 Fill first buffer, then set up second buffer ($8000)
C $BBD2,4 SP-trick: save caller's SP, point SP at fill destination
C $BBD7,8 Unrolled PUSH DE x8, looped B times
C $BBE1,3 !!MUT-ARG!! Restore SP and return (patched by $BBD2)
c $BBE5 Mark active objects into the attribute-buffer collision mask
@ $BBE5 label=mark_collision_masks
N $BBE5 Marks each active object's position into the collision attribute buffers, one distinct bit per object, for damage/collision checks to test against later.
C $BBE5,4 Save SP (restored via the $7E-page LD SP tail)
C $BBE9,0 IY = object list head ($9D30)
C $BBED,0 B = 6 - active object count ($9D19)
C $BBF6,3 B = object count; C = 1: first object's mask bit
C $BBF9,0 E = object's mask bit only when type (IY+$05) is 3
C $BC03,2 H=$7E: point at the low-page attribute buffer
C $BC05,0 Compute $7Exx attribute-row address from object Y (IY+$0D/$0E)
C $BC12,0 OR mask bit into this attribute row (row 1/12)
C $BC15,4 row 2/12
C $BC19,4 row 3/12
C $BC1D,4 row 4/12
C $BC21,4 row 5/12
C $BC25,4 row 6/12
C $BC29,4 row 7/12
C $BC2D,4 row 8/12
C $BC31,4 row 9/12
C $BC35,4 row 10/12
C $BC39,4 row 11/12
C $BC3D,4 row 12/12
C $BC41,2 H=$7F: point at the high-page attribute buffer
C $BC43,12 Compute $7Fxx attribute-row address from object Y (IY+$0B/$0C)
C $BC4F,3 OR mask bit into this attribute row (row 1/8)
C $BC52,4 row 2/8
C $BC56,4 row 3/8
C $BC5A,4 row 4/8
C $BC5E,4 row 5/8
C $BC62,4 row 6/8
C $BC66,4 row 7/8
C $BC6A,4 row 8/8
C $BC6E,5 Store the object's mask bit (IY+$14), rotate C for the next object
C $BC73,4 Advance to the next object in the list
C $BBE9,4 IY = object list head ($9D30)
C $BBED,6 B = 6 - active object count ($9D19)
C $BBF3,3 POKE 48115,58 corrupts this JP Z, disabling the damage/collision branch (Immunity)
C $BBF9,10 E = object's mask bit only when type (IY+$05) is 3
C $BC05,13 Compute $7Exx attribute-row address from object Y (IY+$0D/$0E)
C $BC12,3 OR mask bit into this attribute row
N $BC79 Entry point reached from #R$BBE5's mask-draw loop; also entered directly when POKE 48115,58 (Immunity) forces the mask byte to $80, skipping the normal per-object bit rotation (RLC C) at $BC71 and disabling the damage/collision branch.
c $BC7D Draw fixed 8-row collision mask into both attribute buffers
N $BC7D Marks a fixed 8-row collision mask into both attribute buffers around the object's position; the fixed-height counterpart to #R$BCE9's variable-height masks.
R $BC7D C object's mask bit
R $BC7D IY object struct base
C $BC7D,3 Row offset from object Y (IY+$0D/$0E)
C $BC8B,3 OR mask bit into this attribute row (row 1/8)
C $BC8F,4 row 2/8
C $BC93,4 row 3/8
C $BC97,4 row 4/8
C $BC9B,4 row 5/8
C $BC9F,4 row 6/8
C $BCA3,4 row 7/8
C $BCA7,3 row 8/8
C $BCAC,0 Row offset from object Y (IY+$0B/$0C)
C $BCBA,3 OR mask bit into this attribute row (row 1/8)
C $BCBD,4 row 2/8
C $BCC1,4 row 3/8
C $BCC5,4 row 4/8
C $BCC9,4 row 5/8
C $BCCD,4 row 6/8
C $BCD1,4 row 7/8
C $BCD5,4 row 8/8
C $BCAA,2 Switch to second attribute page ($7Fxx)
C $BCAC,3 Row offset from object Y (IY+$0B/$0C)
C $BCD9,3 !!MUT-ARG!! Restore SP (patched by $BBE5)
C $BCE0,1 Exit if no objects to process ($9D19 counter is zero)
c $BCE9 Draw active objects' collision masks into attribute buffer
@ $BCE9 label=draw_object_masks
N $BCE9 Marks each active object's variable-height collision mask into the attribute buffers, the variable-height counterpart to #R$BC7D's fixed 8-row mask.
C $BCE9,4 Save SP (restored at $BD7F)
C $BCED,5 Optional player-hit row/page setup, gated by flag $9C70
C $BCF5,15 Compute the player's attribute row for the collision test below
C $BD04,3 Stash that row for later use
C $BD07,7 IY = object list head ($9D1E)
C $BD0E,8 B = active object count
C $BD19,3 DE = 8 (attribute-row stride)
C $BD1E,4 Skip normal draw path for a special object type (IY+$04 bit 3)
C $BD25,5 Reset accumulator; check IY+$04 status bits
C $BD32,2 Point SP at the object's mask-pointer fields (IY)
C $BD34,3 Pop the object's mask row-count pointer (IX)
C $BD37,2 H=$7E: point at the low-page attribute buffer
C $BD39,12 Compute $7Exx attribute-row address from object Y (IY+$0D/$0E)
C $BD45,4 !!MUT-ARG!! Clamp row start if it wrapped past the top (patched by $BD04)
C $BD4C,3 B = mask row count (IX-$01)
C $BD4F,4 OR mask row into buffer, advance to next row
C $BD53,2 OR the final row, stash accumulated mask in C
C $BD55,2 H=$7F: point at the high-page attribute buffer
C $BD57,12 Compute $7Fxx attribute-row address from object Y (IY+$0B/$0C)
C $BD63,2 A=$40 (mask row seed)
C $BD65,3 B = mask row count (IX-$02)
C $BD68,4 OR mask row into buffer, advance to next row
C $BD6C,2 OR the final row, AND with the low-page accumulator
C $BCF2,2 Skip row/page setup if flag at $9C70 is zero
C $BD17,2 No objects to draw: skip to cleanup
C $BD22,2 Skip normal draw path if IY+$04 bit 3 is set
C $BD2A,2 Skip mask draw if IY+$04 bit 0 is set
C $BD30,2 Skip mask draw unless IY+$04 bit 5 is set
C $BD49,2 Clamp row start if carry
C $BD76,2 Next object
C $BD7F,3 !!MUT-ARG!! Restore SP (patched by $BCE9)
c $BD99 Update randomized countdown, then enter player update ($BDAE)
N $BD99 Randomly ticks down a shared timer used elsewhere for homing/steering, then falls through into the per-frame player update loop.
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
N $BE01 Handler for index $2A of the #R$A000 jump table (see #R$B7F6).
N $BE02 Handler for index $29 of the #R$A000 jump table (see #R$B7F6).
C $BE03,7 skip movement if immobilised flag at $9C3B set
N $BE03 Handler for index $2B of the #R$A000 jump table (see #R$B7F6).
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
C $BE44,2 if Right held, branch to add step (#R$BE4C)
C $BE46,4 Left held: bank-left target (B=0), subtract step
c $BE01 Player frozen: unwind an extra call level, then no-op
c $BE02 Player idle: no-op
@ $BE02 label=noop_BE02
c $BE03 Player: skip movement if immobilised, else read input and move
c $BE4A Clamp player position to screen bounds, update bank animation
@ $BE4A label=clamp_player_pos
N $BE4A Clamps the player's position to the screen bounds, then converts left/right input into a banking-tilt sprite frame - stepping the bank angle one frame at a time rather than snapping directly to it.
R $BE4A B bank-frame target (2=right, 0=left, 1=level)
R $BE4A IY player object struct base
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
@ $BF22 label=player_hit
R $BF22 IY player object base (inherited from $BDAE's caller)
N $BF22 Switches the player into its hit/explosion animation and arms the death/respawn recovery timer.
C $BF22,4 IX = object that hit the player
C $BF26,6 tag it with current wave/formation id
C $BF2C,8 arm hit-reaction timer; set player's IX+$02/$03 (record ptr, not code) to $6B86...
C $BF34,8 ...(hit/explosion animation); set visual state
C $BF3C,5 arm 38-frame recovery/death timer at $9C3C
C $BF41,1 return
c $BF42 Use bomb: consume inventory, trigger flash effect
N $BF42 Handles the bomb key: consumes a bomb and triggers the screen-flash effect on press, then spawns the actual bomb-explosion object once the key is released.
C $BF46,4 Trigger only when input state ($9CDC) is $09
C $BF54,3 Consume one bomb (IX+$09)
C $BF5A,2 Request the screen-flash deferred event ($9C27 bit 2)
C $BF6B,2 Spawn only once input state reaches 1 (key released)
C $BF71,3 BC = spawn-parameter table #R$6BB9
C $BF75,7 DE = per-type spawn data ($9C73); B = object count
C $BF7F,11 Skip spawn if the object pool is full (difficulty $9C72 vs $9D19)
C $BF8C,12 Pop a free object slot ($9D1C)
C $BFB9,13 Position new object at the player (IY+$0D/$0E)
C $BFC6,17 Copy velocity/offset fields from spawn data
C $BFE0,2 Next object
C $BFE2,3 !!MUT-ARG!! Restore SP (patched by $BF6D)
C $BFE7,3 Request sound effect if higher priority than current
N $BFEB Checks whether this object has been hit and starts its explosion, otherwise moves it and retires it once it leaves the play area.
C $BFFE,3 Start object explosion sequence
C $C002,3 Apply object velocity (dx,dy) to position
C $C011,3 Mark formation slot done, trigger completion effect when group empties
N $C015 Handler for index $36 of the #R$A000 jump table (see #R$B7F6).
C $C020,3 Compute velocity vector (dx,dy) from angle and speed
C $C023,3 Apply object velocity (dx,dy) to position
C $C02A,3 Apply object velocity (dx,dy) to position
C $C045,3 Start object explosion sequence
C $C04D,3 Mark formation slot done, trigger completion effect when group empties
N $C051 Handler for index $2D of the #R$A000 jump table (see #R$B7F6).
N $C075 Handler for indices $2E, $2F of the #R$A000 jump table (see #R$B7F6).
C $C078,12 Retiring (IY+$04 bit 1)? explode if also mid-transition, otherwise retire
C $C084,4 Count the object out of its group ($9D18)
C $C08C,6 Already mid-transition (bit 4): just step the animation
C $C092,7 Not hit this frame: skip to the movement tail
C $C099,6 OR the hit bits into the global hit-flag ($9C6B)
C $C09F,5 Decrement the hit counter; nothing more to do while it survives
C $C0A4,7 Only a state-$05 enemy can transform; other types explode
C $C0AE,10 IY+$14 bit 7 set always transforms, otherwise only a 1-in-4 chance
C $C0B8,11 Pick the new facing from the random number's low bit
C $C0C3,16 Point its movement script at $5CF1, run it next frame, mark it transitioning
C $C0D4,2 Award the destruction score
C $C0D9,3 Group counter for the explosion to bump when it ends
C $C0E0,7 Retire once past a Y bound ($1E)
C $C0E7,13 Sprite frame from the heading, quantised to 8 directions
C $C0F4,7 A state-$0C enemy ramps a counter before it may fire
C $C0FB,10 Hold fire until that counter reaches $58
C $C075,3 Movement-pattern script interpreter
C $C088,3 Mark formation slot done, trigger completion effect when group empties
C $C0AB,3 Pseudo-random number generator
c $BFEB Check for bullet hit, start explosion
c $C015 Launch and move projectile; explode on hit
N $C015 Launches a projectile on its first call, then moves it every frame; explodes it on a confirmed hit, or retires it and signals formation completion once its lifetime flag clears.
C $C015,8 First call only (IY+$10 != $FF)
C $C01D,3 B = launch speed (IY+$11)
C $C026,4 Mark launched, so this only fires once
C $C02D,6 Skip hit/retire handling unless flag bit 5 (IY+$04) is set
C $C033,7 Skip if IY+$14 bit 6 is set (not a hit)
C $C03A,3 Bail out unless IY+$14 bit 7 (hit) is set
C $C03D,5 Set the global hit flag ($9C6B)
C $C049,4 Otherwise: mark this formation group's slot count
c $C051 Move straight down at fixed speed; advance animation frame
C $C051,8 add fixed step $20 to Y position low byte
C $C059,5 carry into Y position high byte
C $C05E,6 advance animation frame, check wrap at 16
C $C064,2 branch when frame wraps
C $C066,4 store frame, return
C $C06A,6 load the group-counter address stored at IY+$15/$16 by #R$C5AF
C $C070,4 animation finished: bump that group counter, notify #R$B7A3
C $C074,1 return
c $C075 Multi-hit enemy: take damage, retire after hit counter (IY+12) expires
N $C075 A multi-hit enemy: every hit is ORed into the global hit-flag $9C6B and knocks one off its hit counter (IY+$12), and it only reacts once that counter runs out. At that point a state-$05 enemy may transform rather than die - taking a fresh movement script and a random facing - while other types always explode. Otherwise it just picks a sprite frame from its heading and runs its fire-decision timer.
C $C0D6,3 Add BCD score value to current player's score
C $C0DC,3 Start object explosion sequence
C $C106,3 Enemy fire-decision timer and heading steering
C $C10A,12 step sprite frame (IY+6), 8-direction wrap, mirrored via IY+4 bit 7
N $C11C Runs an enemy's movement script, applies variable damage on a hit and explodes it once destroyed, otherwise handles its fire timing and aim-based sprite frame.
c $C11C Scripted-movement enemy: take variable damage, explode when destroyed
C $C11C,3 Movement-pattern script interpreter
C $C11F,6 Skip damage handling and retire if flag bit 1 (IY+$04) is set
C $C125,7 Skip damage handling entirely if not hit (IY+$14 zero)
C $C12C,6 Decode whether this hit deals extra (+2) damage
C $C134,9 Mask hit byte to the aim-angle range, stash it ($9C6C)
C $C13D,21 Otherwise: decode a variable damage amount via 6 rotate/add steps
C $C152,6 OR the hit flag into the global hit-flag ($9C6B)
C $C158,7 Subtract damage from health (IY+$12)
C $C15F,3 Skip explosion unless health went negative
C $C162,2 Award a destruction score bonus
C $C164,3 Add BCD score value to current player's score
C $C16A,3 Start object explosion sequence
C $C18D,3 Enemy fire-decision timer and heading steering
C $C195,3 Mark formation slot done, trigger completion effect when group empties
N $C199 Handler for indices $32, $33, $3A of the #R$A000 jump table (see #R$B7F6).
c $C199 Multi-hit enemy: move straight down, take damage
N $C199 Runs a multi-hit enemy's movement script, moves it straight down, and applies damage on a hit - exploding it once its hit-point counter and a secondary stage counter both run out. Otherwise sets its sprite frame and fire-decision timer.
C $C199,3 Movement-pattern script interpreter
C $C19C,6 Skip movement/damage handling and retire if "alive" flag is set
C $C1A2,8 Move straight down at fixed speed ($0020/frame)
C $C1AF,7 Retire once past a Y boundary ($1C)
C $C1B6,8 Mask hit byte to 7 bits; skip damage handling if not hit
C $C1BE,6 OR the hit flag into the global hit-flag ($9C6B)
C $C1C4,5 Decrement health; skip the rest while still nonzero
C $C1C9,5 Check secondary stage counter (IY+$1A) against $08
C $C1D0,8 First stage cleared: reset stage counter, arm 1 more hit
C $C1DA,3 Add BCD score value to current player's score
C $C1E1,3 Add BCD score value to current player's score
C $C1E7,3 Start object explosion sequence
C $C1EF,3 Mark formation slot done, trigger completion effect when group empties
C $C213,3 Enemy fire-decision timer and heading steering
N $C217 Handler for index $37 of the #R$A000 jump table (see #R$B7F6).
C $C217,3 Movement-pattern script interpreter
C $C26D,3 Add BCD score value to current player's score
C $C273,3 Start object explosion sequence
C $C279,3 Add BCD score value to current player's score
C $C294,3 Enemy fire-decision timer and heading steering
N $C298 Handler for index $34 of the #R$A000 jump table (see #R$B7F6).
c $C217 Movement handler $37: run movement script, then advance and act on IY+$14 flags
R $C217 IY object struct base (status IY+$04 bit 1, Y at IY+$0D/$0E, action flags IY+$14)
N $C217 Runs an enemy's movement script, moves it down, and applies variable damage on a hit - exploding it once destroyed. Otherwise sets its sprite frame and fire-decision timer.
C $C21A,6 Skip movement/damage handling and retire if flag bit 1 (IY+$04) is set
C $C220,8 Move straight down at fixed speed ($0020/frame)
C $C22D,6 Skip damage handling entirely if not hit (IY+$14 zero)
C $C235,8 Decode whether this hit deals extra (+2) damage
C $C23D,9 Mask hit byte to the aim-angle range, stash it ($9C6C)
C $C246,21 Otherwise: decode a variable damage amount via 6 rotate/add steps
C $C25B,6 OR the hit flag into the global hit-flag ($9C6B)
C $C261,7 Subtract damage from health (IY+$12)
C $C268,3 Skip to lower-score award unless health went negative
C $C26B,2 Award the higher destruction score bonus
C $C277,2 Award the lower destruction score bonus
c $C298 Movement handler $34: advance object down-screen, then act on IY+$14 flags
R $C298 IY object struct base (Y at IY+$0D/$0E, action flags IY+$14)
N $C298 Moves an enemy down, applies variable damage on a hit and explodes it once destroyed - switching to a near-death animation just before that. Otherwise retires it once it leaves the play area.
C $C298,8 Move straight down at fixed speed ($0020/frame)
C $C2A5,8 Skip damage handling entirely if not hit (IY+$14 zero)
C $C2AD,6 Decode whether this hit deals extra (+2) damage
C $C2B5,9 Mask hit byte to the aim-angle range, stash it ($9C6C)
C $C2BE,21 Otherwise: decode a variable damage amount via 6 rotate/add steps
C $C2D3,6 OR the hit flag into the global hit-flag ($9C6B)
C $C2D9,7 Subtract damage from health (IY+$12)
C $C2E0,4 !!MUT-ARG!! Skip near-death switch unless health dropped below 3 (patched by $A68F)
C $C2E4,8 Point at the near-death animation record (IY+$02/$03)
C $C2EC,4 Skip to lower-score award unless health went negative
C $C2F0,2 Award the higher destruction score bonus
C $C2F2,3 Add BCD score value to current player's score
C $C2F8,3 Start object explosion sequence
C $C2FC,2 Award the lower destruction score bonus
C $C301,7 Retire once past a Y boundary ($1B)
C $C2FE,3 Add BCD score value to current player's score
C $C30C,3 Mark formation slot done, trigger completion effect when group empties
C $C310,3 Enemy fire-decision timer and heading steering
N $C31A Handler for index $31 of the #R$A000 jump table (see #R$B7F6).
C $C342,3 Add BCD score value to current player's score
C $C355,3 Mark formation slot done, trigger completion effect when group empties
N $C359 Handler for index $39 of the #R$A000 jump table (see #R$B7F6).
C $C384,3 Mark formation slot done, trigger completion effect when group empties
N $C388 Handler for index $38 of the #R$A000 jump table (see #R$B7F6).
C $C3B2,3 Add BCD score value to current player's score
C $C3C3,3 Mark formation slot done, trigger completion effect when group empties
N $C3C7 Handler for index $30 of the #R$A000 jump table (see #R$B7F6).
c $C31A Movement handler $31: advance object down-screen; on flag, score and mark progress
R $C31A IY object struct base (Y at IY+$0D/$0E, action flag IY+$14 bit 7)
N $C31A Moves an enemy down; when its action flag fires, awards score and bumps a per-object counter (up to a cap) before joining the shared wave-completion tail. Otherwise retires it once it leaves the play area.
C $C31A,8 Move straight down at fixed speed ($0020/frame)
C $C327,4 Skip scoring unless the action flag (IY+$14 bit 7) is set
C $C32D,4 IX = the object that hit the player
C $C331,5 Skip scoring once the per-object counter (IX+$09) hits its cap
C $C338,8 Otherwise bump the counter and request the screen-flash event
C $C340,2 Award a fixed score bonus
C $C347,5 Otherwise: retire once past a Y boundary ($1B)
C $C34D,4 Decrement the wave-progress counter ($9C3F)
c $C359 Movement handler $39: advance object down-screen; on flag, bump IX+$03
R $C359 IY object struct base (Y at IY+$0D/$0E, action flag IY+$14 bit 7)
N $C359 Moves an enemy down, then either bumps a field on the object that hit the player and requests the screen-flash event, or retires it once it leaves the play area.
C $C359,8 Move straight down at fixed speed ($0020/frame)
C $C366,4 Skip the flag-triggered step unless IY+$14 bit 7 is set
C $C36C,4 IX = the object that hit the player
C $C370,8 Bump a field on it (IX+$03), request the screen-flash event
C $C37A,5 Otherwise: retire once past a Y boundary ($1B)
c $C388 Movement handler $38: advance object down-screen; on flag, score and mark completion
R $C388 IY object struct base (Y at IY+$0D/$0E, action flag IY+$14 bit 7)
N $C388 Flickers a visual flag periodically, moves an enemy down, and when its action flag fires, awards score and bumps a wave-progress counter. Otherwise decrements a countdown before completing the formation slot.
C $C388,5 Every 4th frame ($9BA0): flicker a visual flag (IY+$04 bit 4)
C $C39D,8 Move straight down at fixed speed ($0020/frame)
C $C3AA,4 Skip scoring unless the action flag (IY+$14 bit 7) is set
C $C3B0,2 Award a fixed score bonus
C $C3B5,4 Bump a wave-progress counter ($9C6A)
C $C3BB,3 Otherwise: count down before completing (IY+$15)
c $C3C7 Movement handler $30: angle-steered weave with edge bounce, velocity apply
R $C3C7 IY object struct base (column IY+$0C, angle IY+$10, direction-rate IY+$15, speed IY+$11, action flag IY+$14 bit 7)
N $C3C7 Steers an enemy in a zigzag weave, bouncing its heading back when it strays outside a central column band. When its action flag fires, awards score and advances the wave/explosion-data trackers; otherwise moves it down and retires it once it leaves the play area.
C $C3C7,7 Outside a central column band (IY+$0C-6 not in 0-$14)
C $C3D0,8 Flip the direction-rate sign (IY+$15), edge-bounce
C $C3D8,7 Mirror the angle target, masked to 0-$3F
C $C3E2,11 Advance angle (IY+$10) by the direction-rate
C $C3ED,3 B = speed (IY+$11)
C $C3F6,4 Skip scoring unless the action flag (IY+$14 bit 7) is set
C $C3FC,4 Bump the wave counter ($9C68)
C $C400,2 Award a fixed score bonus
C $C405,11 Advance the explosion-data pointer once its group counter allows
C $C41D,11 Otherwise: move straight down at fixed speed ($0020/frame)
C $C42E,6 Retire once outside a Y band ($1C-$22)
C $C3F0,3 Compute velocity vector (dx,dy) from angle and speed
C $C3F3,3 Apply object velocity (dx,dy) to position
C $C402,3 Add BCD score value to current player's score
C $C438,3 Mark formation slot done, trigger completion effect when group empties
c $C43C Enemy fire-decision timer and heading steering
@ $C43C label=enemy_fire_steer
R $C43C IY enemy object struct base (status IY+$04, target ref IY+$1A, heading IY+$1C)
N $C43C Runs an enemy's shared fire-decision timer, and once it expires, steers the enemy's heading toward its target one rate-limited step at a time rather than snapping to it. The enemy only actually fires once its heading lines up closely enough with the target and a free bullet slot is available.
C $C43F,2 Fire timer countdown; exit until it expires
C $C441,4 Reload fire timer from $9C43
C $C445,5 Exit if busy flag set (IY+$04 bit 0)
C $C44A,5 Exit unless active flag set (IY+$04 bit 5)
C $C44F,6 Exit if no target (IY+$1A = $FF)
C $C459,3 Compute angle from object IX to target IY
C $C469,3 Angle difference (target minus current heading)
C $C480,3 Step heading toward target by +-4
C $C483,3 Store new heading (IY+$1C)
C $C48E,3 Store target sector (IY+$1A)
C $C4A0,5 Fire only if free-object slots remain ($9D1A - $9D1B)
C $C4A6,0 Random fire chance
C $C4A9,4 Fire only below probability threshold (IY+$1B)
C $C500,12 Pop a bullet object from the free list ($9D1C)
C $C52C,12 Position bullet at the firing enemy
C $C538,0 Random per-bullet spread angle
C $C548,3 Set bullet heading (IX+$10)
C $C550,4 Advance spread angle for next bullet
C $C555,2 Loop for each bullet
C $C557,2 Signal fired (carry set) and return
C $C4A6,3 Pseudo-random number generator
C $C514,3 !!MUT-ARG!! patched by $C4FC
C $C538,3 Pseudo-random number generator
C $C54B,4 !!MUT-ARG!! patched by $C4D5
c $C559 Allocate and initialize the player's plane object
@ $C559 label=alloc_object
N $C559 Allocates the player's plane from the free-list pool at wave start (called only from #R$B730) and places it at the bottom centre of the screen. Its state index IY+$05=$02 selects the player handler #R$BE03, and its address is published to $9C6D, which every homing enemy reads as its aim target.
C $C559,4 Save caller's SP (restored at $C56F)
C $C55D,7 Pop free-list head ($9D1C) into IX
C $C567,8 Push old head onto secondary stack ($9D30)
C $C56F,3 !!MUT-ARG!! patched by $C559
C $C572,8 Clear status, set "active" bit 2
C $C57A,4 Per-frame handler pointer -> $6B42
C $C59E,4 Default column (IX+$0C=$10)
C $C5A6,4 Default row (IX+$0E=$16)
C $C5AA,4 Publish object as current aim target ($9C6D)
c $C5AF Start object explosion sequence
@ $C5AF label=start_explosion
R $C5AF IY object struct base
R $C5AF DE address of the group counter to bump when the explosion finishes ($9D18/$9D19/$9D1A)
N $C5AF The shared "object destroyed" entry point: switches an object into its explosion animation and resets two global explosion-growth timers.
C $C5AF,8 set object's IX+$02/$03 (record ptr into #R$6B42's table, not code) to $6BCA (record 8)
C $C5B7,8 init state fields IY+5=4, IY+6=8
C $C5BF,6 store the group-counter address (DE) into IY+$15/$16; #R$C051 bumps it when the animation ends
C $C5C5,6 reset global timer/counter $9C35
C $C5CB,6 reset global timer/counter $9C39
C $C5D1,1 return
c $C5D2 Convert object to explosion (set state-record pointer to $6BF3)
@ $C5D2 label=object_to_explosion
R $C5D2 IY object struct base
N $C5D2 Converts an object into an explosion, the sibling of #R$C5AF. The alternate #R$C5EE entry additionally awards score and sets up a follow-up object based on how many bonus objects remain, either upgrading it to a bigger explosion or spawning the next object in the sequence.
C $C5D2,4 Bump the shared explosion-conversion counter ($9C3F)
C $C5D9,4 Clear the banking-in-progress flag
C $C5DD,8 Point at the explosion state-record entry ($6BF3)
C $C5E5,8 Init state fields (IY+$05/$06)
C $C5F1,2 Award a fixed score bonus
C $C5F6,4 Clear the banking-in-progress flag
C $C5FA,4 Reset frame
C $C5FE,6 Snap Y to the top ($9C01)
C $C604,4 Reset X to the left edge
C $C608,4 IX = the object that hit the player
C $C60C,6 Check whether it has bonus follow-up objects remaining (IX+$0B)
C $C612,7 Skip the upgrade check once the group-clear rate cap is reached
C $C61C,4 Otherwise randomly decide whether to upgrade
C $C620,8 Upgrade to a bigger explosion (record $ED)
C $C628,8 Init state fields (IY+$05, growth rate IY+$15)
C $C631,4 Otherwise: reset the group-clear rate counter
C $C638,3 Consume one bonus follow-up object (IX+$0B)
C $C63B,8 Spawn the next object in the sequence (record $E7)
C $C643,4 Init state field (IY+$05)
C $C5D6,3 Set object position from $9C01, clamp column (IY+$0C) to 8-24
C $C5EE,3 Set object position from $9C01, clamp column (IY+$0C) to 8-24
C $C5F3,3 Add BCD score value to current player's score
C $C619,3 Pseudo-random number generator
C $C635,3 Set object position from $9C01, clamp column (IY+$0C) to 8-24
c $C648 Decrement wave-group counter; trigger group-clear bonus when it hits zero
N $C648 Decrements the wave-group counter; once the whole group is cleared, sets up a bonus-award animation, otherwise falls through to per-kill scoring.
C $C648,4 Decrement the wave-group counter ($9C68)
C $C64E,0 Group cleared: reload the counter from $9C72
C $C652,8 Point at the bonus-animation record ($6B97)
C $C65A,8 Init state fields (IY+$05/$06)
C $C662,5 Pick the animation's direction based on column (IY+$0C vs $12)
C $C669,8 Rightward outcome: set growth rate and angle
C $C673,8 Otherwise: leftward outcome, no angle
C $C67B,4 Set the animation's duration (IY+$11)
C $C64E,3 get Wave type / group id
c $C680 Scroll background (periodic LDDR shift, gated by counter $9C2A)
@ $C680 label=scroll_background
N $C680 Shifts the background graphics one byte, but only every 3rd frame.
C $C683,2 Act only every 3rd frame ($9C2A countdown)
C $C685,2 Reload the frame counter (3)
C $C687,3 First 16-byte ring ($8500-$850F): rotate its bytes up one place
C $C691,2 Shift 15 bytes down (LDDR)
C $C693,3 Wrap the scrolled-off byte to $8500
C $C696,3 Second 16-byte ring ($8510-$851F): rotate its bytes up one place
C $C6A0,2 Shift 15 bytes down (LDDR)
C $C6A2,3 Wrap the scrolled-off byte to $8510
c $C6A6 Screen wipe transition effect (colour set in $9C59)
@ $C6A6 label=screen_wipe
N $C6A6 Wipes the screen to a solid colour (from $9C59, set by the caller beforehand) with a diamond/cross pattern growing outward from the centre.
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
@ $C6D3 label=fill_attr_column
N $C6D3 Fills one full-height screen column with the wipe colour, ignoring out-of-range columns.
R $C6D3 A screen column (7-24 valid, else no-op)
C $C6D3,6 Ignore out-of-range columns (valid range 7-24)
C $C6D9,9 Point at the attribute-area column start ($58xx)
C $C6E2,3 get Active colour scheme
c $C6EB Fill screen attribute row with colour from $9C59
@ $C6EB label=fill_attr_row
N $C6EB Fills one full-width screen row with the wipe colour.
R $C6EB A row/column offset (encodes screen position)
C $C6EC,3 Rotate position code into attribute-row high bits
C $C6F8,3 Form attribute-area address in $58xx
C $C6FD,4 Set up LDIR: dest = src+1, length 17
C $C701,4 Load fill colour from $9C59
C $C705,2 Propagate colour across the row (18 cells)
c $C709 Fill entire attribute screen with colour A (fast SP-push fill)
@ $C709 label=fill_attr_screen
N $C709 Fills the whole screen attribute area with a single colour, using a fast PUSH-unroll fill.
R $C709 A attribute colour
C $C709,4 Save caller's SP (restored at $C726)
C $C70F,2 A = 23 row groups to fill
C $C711,3 HL = attribute area start ($5819)
C $C717,1 Point SP at this row for the PUSH fill
C $C718,9 Fast fill: 9x PUSH BC (18 attribute bytes)
C $C721,2 Advance HL to next row ($20 stride)
C $C723,3 Loop 23 rows
C $C726,3 !!MUT-ARG!! Restore SP (patched by $C709)
c $C72A Animate active player's indicator box colour
@ $C72A label=animate_player_box
N $C72A Cycles the active player's corner-box indicator through a repeating colour sequence, one step per interrupt. Also drives the full-screen flash effect if one is pending.
C $C72A,4 Read next byte of the colour sequence ($9C45)
C $C732,7 Sequence exhausted: check repeat count, reload if any remain
C $C73B,5 Reload the sequence pointer from its start ($9C47)
C $C740,5 Advance the sequence pointer, C = colour to apply
C $C748,6 Point at the active player's corner box ($58C4 or $58DA)
C $C750,10 Paint the box's 4 corner cells
C $C745,3 get Active player
C $C75A,3 read next full-screen flash colour byte (sequence $9C5B, set by #R$6A88)
C $C766,3 get Active colour scheme
C $C76E,3 Fill entire attribute screen with colour A
c $C772 Fast column mover: copy the built scroll row to the attribute screen
@ $C772 label=fast_attr_mover
N $C772 Called every frame from the main loop. Uses an unrolled POP/self-modified-store SP-trick to move the scroll-window row prepared by #R$C84C into the on-screen attribute area, with #R$C825 selecting the per-frame store-opcode variant and $C804 advancing between row groups.
C $C772,3 Configure $C772 mover
C $C775,4 Save caller's SP
C $C779,3 SP=#R$F6D1: fast POP-based read pointer into source data
C $C782,3 Stash E in shadow A', A=D (destination page high byte)
C $C785,9 Patch destination high byte into 3 self-modified store targets ($C7A0/$C7BC/$C7D8)
C $C78E,2 EXX: switch to shadow registers for the unroll loop
C $C790,2 E=$18: outer pass counter
C $C792,2 Inner unroll count B=$06 (6x3 stores per pass)
C $C799,4 Save source read pointer (SP) before switching back
C $C79D,1 SP=HL: point stack at destination write area
C $C79E,1 EXX: back to normal registers for the unrolled store sequence
C $C79F,2 !!MUT-ARG!! patched by $C785
C $C7A1,20 Store 4 pairs from HL-fed source (source 1/3)
C $C7B5,6 Switch page, advance to next source (SP=IX)
C $C7BB,2 !!MUT-ARG!! patched by $C788
C $C7BD,20 Store 4 pairs from IX-fed source (source 2/3)
C $C7D1,6 Switch page, advance to next source (SP=IY)
C $C7D7,2 !!MUT-ARG!! patched by $C78B
C $C7D9,20 Store 4 pairs from IY-fed source (source 3/3)
C $C7ED,4 Switch page, reset source pointer for next pass
C $C7F1,3 !!MUT-ARG!! patched by $C799
C $C7F5,2 Loop $C792's inner unroll count
C $C80A,14 Advance the 3 self-modified destination operands by 8
C $C81A,1 Next row-group
C $C81B,3 Loop back into the unrolled mover body
C $C81E,3 !!MUT-ARG!! Done: restore SP (patched by $C775)
C $C821,3 Reset $C772 mover body opcodes to INC H
c $C825 Configure $C772 mover: set fill displacement, patch 3 body opcodes to EX DE,HL
N $C825 Reconfigures #R$C772's self-modifying mover for the current frame's row displacement.
C $C828,3 Frame counter $9C00 mod 8
C $C830,2 Index byte table at $9C02
C $C832,3 Patch fill-loop IX displacement operand ($C846)
C $C835,2 A=$EB (EX DE,HL opcode)
c $C839 Reset $C772 mover body opcodes to INC H
N $C839 Alternate entry to #R$C825's tail: writes $24 (INC H) into the three opcode slots instead of $EB.
C $C839,2 A=$24 (INC H opcode)
C $C83B,5 Set up 3-slot patch loop (stride $1C from $C7A1)
C $C844,3 !!MUT-ARG!! Write opcode into this store-body slot (patched by $C832)
C $C847,2 Advance to next slot (+$1C)
C $C849,2 Loop 3 slots
c $C84C Build wrapped scroll-window row into $F6D1 buffer
@ $C84C label=build_scroll_row
N $C84C Copies the next window of the circular scroll buffer into #R$F6D1, wrapping around to the buffer's start if the window runs past its end. The resulting row is what #R$C772 draws to the screen.
C $C84C,10 HL = scroll-window source pointer, DE = dest #R$F6D1
C $C859,9 C = scroll offset, B = bytes remaining before wrap ($18-offset)
C $C862,2 C=$FF: BC = byte count for the LDI runs below
C $C864,72 Copy up to 36 bytes into #R$F6D1, one LDI per byte
C $C8AE,9 Wrap: continue remaining bytes from buffer start $FA79
c $C8B8 Advance background scroll: every 8th frame swap column buffer and render row
N $C8B8 Advances the background scroll one column every 8th frame: decodes the next column of scenery tiles and converts it into attribute codes for the on-screen scroll buffer.
C $C8BD,2 Test for 8th frame (mod-8 wrap)
C $C8C7,2 Only continue every 8th call
C $C8CC,2 Mark deferred event bit 3 pending
C $C8D2,2 Toggle ping-pong buffer selector
C $C8DC,2 Select this pass's ping-pong buffer
C $C8EB,2 Copy 18-byte row into staging buffer $9BD4
C $C8ED,3 Decode next column's tile data into ping-pong buffer
C $C8F0,9 HL/DE = staging row / on-screen scroll target; B = 18 cells
C $C8FB,5 Get this cell's character code, advance the ping-pong buffer
C $C907,15 Clamp tile-set index ranges to a valid attribute code
C $C917,4 Rotate character code into position for the pair
C $C91B,9 Write the attribute-code pair, advance the write pointer
C $C926,8 Advance the scroll target pointer, back up 36 bytes
C $C92E,5 Level-progress counter ($9BAD); clamp at $1C
C $C93B,5 Store the new scroll target pointer
c $C941 Decode next column's tile data into ping-pong buffer
@ $C941 label=decode_column
N $C941 Decodes the next 9 map cells into the ping-pong tile buffer, expanding each cell into its 2x2 tile block, and advances the level-progress counter. First spawns any enemies queued in the previous column.
C $C944,2 Check "column ready" flag before advancing
C $C946,3 Scan incoming column for spawn markers and allocate enemy objects
C $C949,11 HL = column-source pointer; IX = ping-pong buffer; C = table page
C $C954,1 Start of 9-entry decode loop
C $C955,20 Read the cell's 4 tile-block bytes, store as a 2x2 char block
C $C969,4 Advance to next buffer entry (IX+=2)
C $C96D,5 Advance source cell (L), bump table row (shadow A')
C $C972,2 Loop 9 times
C $C974,7 Store the advanced source pointer ($9BA9)
C $C97B,2 Clamp progress counter at $1C
C $C97D,1 Stop if counter already at max
c $C981 Scan incoming column for spawn markers and allocate enemy objects
@ $C981 label=scan_spawn_markers
N $C981 Scans the newly-decoded column for enemy spawn markers and allocates an object for each one found, marking cells that couldn't be spawned due to a full object pool.
C $C984,2 Skip if column-ready flag already set
C $C987,7 HL = column-source pointer; B = 9 entries; C = table page
C $C98F,2 Check for spawn marker $05
C $C993,4 Check for spawn marker $55; skip entry if neither
C $C997,7 D = entry offset (enemy row/type); A = 9 (formation size)
C $C99E,3 Spawn a group of formation objects from the free-list pool
C $C9A3,2 Skip the $33 write if the spawn succeeded (carry set)
C $C9A5,2 Pool full (carry clear): mark cell $33 (consumed/blocked)
C $C9AC,2 Loop 9 entries
c $C9AF Advance enemy timeline: fire due entries and dispatch their commands
@ $C9AF label=enemy_timeline
N $C9AF Fires the level's due timeline entries: special commands (screen pokes, flag sets) or, for anything else, spawning an enemy formation. Runs once every 16 frames.
C $C9AF,3 POKE 51631,201 patches entry to RET, disabling this routine (No Enemies)
C $C9B3,4 Advance tick counter mod 16; act only every 16th tick
C $C9BB,1 Advance level-progress counter ($9BA4)
C $C9BD,3 Point at current timeline entry ($9BA5)
C $C9C1,4 End of table when trigger byte is $FF
C $C9C5,3 get Level progress / index
C $C9C8,3 Fire only when progress counter matches the trigger byte
C $C9CB,8 Read param D and command byte; advance past 3-byte entry
C $C9D3,4 Command $FC: reset $9D1B
C $C9D7,4 Command $FE: set $9C3B=$FF
C $C9DB,4 Command $FD: bump counter $9C69
C $C9DF,4 Command $FB: screen/timing poke ($5B56/$C2E1)
C $C9E3,1 Else: command byte is a formation tag (falls into $C9E4)
C $C9E6,3 Spawn a group of formation objects from the free-list pool
b $CA09 Player-plane masked sprite (24x16, interleaved pixel/mask, mask bit-reversed)
N $CA09 Each frame is 24px wide x 16px tall = 3 vertical 8px strips of 32 bytes (16 rows of a [pixel, mask] pair). The mask byte is stored bit-reversed and must be flipped through the #R$9A00 table to align with the pixel byte. Successive frames are pre-shifted horizontal copies (each +1px) built by #R$7E4A for smooth sub-pixel movement; #R$7DF3 interleaves the pixel/mask pairs and #R$7D98 generates mirrored halves via #R$9A00.
B $CA09,32,8 32-byte gap before sprite group
N $CA29 Masked sprites: Plane
B $CA29,96,8 #HTML[<img src="images/sprites/spriteCA29.png" />] Plane shift 0
B $CA89,96,8 #HTML[<img src="images/sprites/spriteCA89.png" />] Plane shift 1
B $CAE9,96,8 #HTML[<img src="images/sprites/spriteCAE9.png" />] Plane shift 2
B $CB49,96,8 #HTML[<img src="images/sprites/spriteCB49.png" />] Plane shift 3
B $CBA9,96,8 #HTML[<img src="images/sprites/spriteCBA9.png" />] Plane shift 4
B $CC09,96,8 #HTML[<img src="images/sprites/spriteCC09.png" />] Plane shift 5
B $CC69,96,8 #HTML[<img src="images/sprites/spriteCC69.png" />] Plane shift 6
B $CCC9,96,8 #HTML[<img src="images/sprites/spriteCCC9.png" />] Plane shift 7
B $CD29,32,8 32-byte gap between sprite groups
N $CD49 Masked sprites: Plane moving
B $CD49,96,8 #HTML[<img src="images/sprites/spriteCD49.png" />] Plane moving shift 0
B $CDA9,96,8 #HTML[<img src="images/sprites/spriteCDA9.png" />] Plane moving shift 1
B $CE09,96,8 #HTML[<img src="images/sprites/spriteCE09.png" />] Plane moving shift 2
B $CE69,96,8 #HTML[<img src="images/sprites/spriteCE69.png" />] Plane moving shift 3
B $CEC9,96,8 #HTML[<img src="images/sprites/spriteCEC9.png" />] Plane moving shift 4
B $CF29,96,8 #HTML[<img src="images/sprites/spriteCF29.png" />] Plane moving shift 5
B $CF89,96,8 #HTML[<img src="images/sprites/spriteCF89.png" />] Plane moving shift 6
B $CFE9,96,8 #HTML[<img src="images/sprites/spriteCFE9.png" />] Plane moving shift 7
B $D049,32,8 32-byte gap between sprite groups
N $D069 Masked sprites: Cannon N
B $D069,96,8 #HTML[<img src="images/sprites/spriteD069.png" />] Cannon N shift 0
B $D0C9,96,8 #HTML[<img src="images/sprites/spriteD0C9.png" />] Cannon N shift 1
B $D129,96,8 #HTML[<img src="images/sprites/spriteD129.png" />] Cannon N shift 2
B $D189,96,8 #HTML[<img src="images/sprites/spriteD189.png" />] Cannon N shift 3
B $D1E9,96,8 #HTML[<img src="images/sprites/spriteD1E9.png" />] Cannon N shift 4
B $D249,96,8 #HTML[<img src="images/sprites/spriteD249.png" />] Cannon N shift 5
B $D2A9,96,8 #HTML[<img src="images/sprites/spriteD2A9.png" />] Cannon N shift 6
B $D309,96,8 #HTML[<img src="images/sprites/spriteD309.png" />] Cannon N shift 7
B $D369,32,8 32-byte gap between sprite groups
N $D389 Masked sprites: Cannon E
B $D389,96,8 #HTML[<img src="images/sprites/spriteD389.png" />] Cannon E shift 0
B $D3E9,96,8 #HTML[<img src="images/sprites/spriteD3E9.png" />] Cannon E shift 1
B $D449,96,8 #HTML[<img src="images/sprites/spriteD449.png" />] Cannon E shift 2
B $D4A9,96,8 #HTML[<img src="images/sprites/spriteD4A9.png" />] Cannon E shift 3
B $D509,96,8 #HTML[<img src="images/sprites/spriteD509.png" />] Cannon E shift 4
B $D569,96,8 #HTML[<img src="images/sprites/spriteD569.png" />] Cannon E shift 5
B $D5C9,96,8 #HTML[<img src="images/sprites/spriteD5C9.png" />] Cannon E shift 6
B $D629,96,8 #HTML[<img src="images/sprites/spriteD629.png" />] Cannon E shift 7
B $D689,32,8 32-byte gap between sprite groups
N $D6A9 Masked sprites: Cannon NE
B $D6A9,96,8 #HTML[<img src="images/sprites/spriteD6A9.png" />] Cannon NE shift 0
B $D709,96,8 #HTML[<img src="images/sprites/spriteD709.png" />] Cannon NE shift 1
B $D769,96,8 #HTML[<img src="images/sprites/spriteD769.png" />] Cannon NE shift 2
B $D7C9,96,8 #HTML[<img src="images/sprites/spriteD7C9.png" />] Cannon NE shift 3
B $D829,96,8 #HTML[<img src="images/sprites/spriteD829.png" />] Cannon NE shift 4
B $D889,96,8 #HTML[<img src="images/sprites/spriteD889.png" />] Cannon NE shift 5
B $D8E9,96,8 #HTML[<img src="images/sprites/spriteD8E9.png" />] Cannon NE shift 6
B $D949,96,8 #HTML[<img src="images/sprites/spriteD949.png" />] Cannon NE shift 7
B $D9A9,32,8 32-byte gap between sprite groups
N $D9C9 Masked sprites: Tank broken N
B $D9C9,96,8 #HTML[<img src="images/sprites/spriteD9C9.png" />] Tank broken N shift 0
B $DA29,96,8 #HTML[<img src="images/sprites/spriteDA29.png" />] Tank broken N shift 1
B $DA89,96,8 #HTML[<img src="images/sprites/spriteDA89.png" />] Tank broken N shift 2
B $DAE9,96,8 #HTML[<img src="images/sprites/spriteDAE9.png" />] Tank broken N shift 3
B $DB49,96,8 #HTML[<img src="images/sprites/spriteDB49.png" />] Tank broken N shift 4
B $DBA9,96,8 #HTML[<img src="images/sprites/spriteDBA9.png" />] Tank broken N shift 5
B $DC09,96,8 #HTML[<img src="images/sprites/spriteDC09.png" />] Tank broken N shift 6
B $DC69,96,8 #HTML[<img src="images/sprites/spriteDC69.png" />] Tank broken N shift 7
B $DCC9,32,8 32-byte gap between sprite groups
N $DCE9 Masked sprites: Tank broken E
B $DCE9,96,8 #HTML[<img src="images/sprites/spriteDCE9.png" />] Tank broken E shift 0
B $DD49,96,8 #HTML[<img src="images/sprites/spriteDD49.png" />] Tank broken E shift 1
B $DDA9,96,8 #HTML[<img src="images/sprites/spriteDDA9.png" />] Tank broken E shift 2
B $DE09,96,8 #HTML[<img src="images/sprites/spriteDE09.png" />] Tank broken E shift 3
B $DE69,96,8 #HTML[<img src="images/sprites/spriteDE69.png" />] Tank broken E shift 4
B $DEC9,96,8 #HTML[<img src="images/sprites/spriteDEC9.png" />] Tank broken E shift 5
B $DF29,96,8 #HTML[<img src="images/sprites/spriteDF29.png" />] Tank broken E shift 6
B $DF89,96,8 #HTML[<img src="images/sprites/spriteDF89.png" />] Tank broken E shift 7
B $DFE9,32,8 32-byte gap between sprite groups
N $E009 Masked sprites: Boat broken N
B $E009,96,8 #HTML[<img src="images/sprites/spriteE009.png" />] Boat broken N shift 0
B $E069,96,8 #HTML[<img src="images/sprites/spriteE069.png" />] Boat broken N shift 1
B $E0C9,96,8 #HTML[<img src="images/sprites/spriteE0C9.png" />] Boat broken N shift 2
B $E129,96,8 #HTML[<img src="images/sprites/spriteE129.png" />] Boat broken N shift 3
B $E189,96,8 #HTML[<img src="images/sprites/spriteE189.png" />] Boat broken N shift 4
B $E1E9,96,8 #HTML[<img src="images/sprites/spriteE1E9.png" />] Boat broken N shift 5
B $E249,96,8 #HTML[<img src="images/sprites/spriteE249.png" />] Boat broken N shift 6
B $E2A9,96,8 #HTML[<img src="images/sprites/spriteE2A9.png" />] Boat broken N shift 7
B $E309,32,8 32-byte gap between sprite groups
N $E329 Masked sprites: Boat broken E
B $E329,96,8 #HTML[<img src="images/sprites/spriteE329.png" />] Boat broken E shift 0
B $E389,96,8 #HTML[<img src="images/sprites/spriteE389.png" />] Boat broken E shift 1
B $E3E9,96,8 #HTML[<img src="images/sprites/spriteE3E9.png" />] Boat broken E shift 2
B $E449,96,8 #HTML[<img src="images/sprites/spriteE449.png" />] Boat broken E shift 3
B $E4A9,96,8 #HTML[<img src="images/sprites/spriteE4A9.png" />] Boat broken E shift 4
B $E509,96,8 #HTML[<img src="images/sprites/spriteE509.png" />] Boat broken E shift 5
B $E569,96,8 #HTML[<img src="images/sprites/spriteE569.png" />] Boat broken E shift 6
B $E5C9,96,8 #HTML[<img src="images/sprites/spriteE5C9.png" />] Boat broken E shift 7
B $E629,32,8 32-byte gap between sprite groups
N $E649 Masked sprites: Enemy plane N
B $E649,96,8 #HTML[<img src="images/sprites/spriteE649.png" />] Enemy plane N shift 0
B $E6A9,96,8 #HTML[<img src="images/sprites/spriteE6A9.png" />] Enemy plane N shift 1
B $E709,96,8 #HTML[<img src="images/sprites/spriteE709.png" />] Enemy plane N shift 2
B $E769,96,8 #HTML[<img src="images/sprites/spriteE769.png" />] Enemy plane N shift 3
B $E7C9,96,8 #HTML[<img src="images/sprites/spriteE7C9.png" />] Enemy plane N shift 4
B $E829,96,8 #HTML[<img src="images/sprites/spriteE829.png" />] Enemy plane N shift 5
B $E889,96,8 #HTML[<img src="images/sprites/spriteE889.png" />] Enemy plane N shift 6
B $E8E9,96,8 #HTML[<img src="images/sprites/spriteE8E9.png" />] Enemy plane N shift 7
B $E949,32,8 32-byte gap between sprite groups
N $E969 Masked sprites: Enemy plane E
B $E969,96,8 #HTML[<img src="images/sprites/spriteE969.png" />] Enemy plane E shift 0
B $E9C9,96,8 #HTML[<img src="images/sprites/spriteE9C9.png" />] Enemy plane E shift 1
B $EA29,96,8 #HTML[<img src="images/sprites/spriteEA29.png" />] Enemy plane E shift 2
B $EA89,96,8 #HTML[<img src="images/sprites/spriteEA89.png" />] Enemy plane E shift 3
B $EAE9,96,8 #HTML[<img src="images/sprites/spriteEAE9.png" />] Enemy plane E shift 4
B $EB49,96,8 #HTML[<img src="images/sprites/spriteEB49.png" />] Enemy plane E shift 5
B $EBA9,96,8 #HTML[<img src="images/sprites/spriteEBA9.png" />] Enemy plane E shift 6
B $EC09,96,8 #HTML[<img src="images/sprites/spriteEC09.png" />] Enemy plane E shift 7
B $EC69,32,8 32-byte gap between sprite groups
N $EC89 Masked sprites: Enemy plane NE
B $EC89,96,8 #HTML[<img src="images/sprites/spriteEC89.png" />] Enemy plane NE shift 0
B $ECE9,96,8 #HTML[<img src="images/sprites/spriteECE9.png" />] Enemy plane NE shift 1
B $ED49,96,8 #HTML[<img src="images/sprites/spriteED49.png" />] Enemy plane NE shift 2
B $EDA9,96,8 #HTML[<img src="images/sprites/spriteEDA9.png" />] Enemy plane NE shift 3
B $EE09,96,8 #HTML[<img src="images/sprites/spriteEE09.png" />] Enemy plane NE shift 4
B $EE69,96,8 #HTML[<img src="images/sprites/spriteEE69.png" />] Enemy plane NE shift 5
B $EEC9,96,8 #HTML[<img src="images/sprites/spriteEEC9.png" />] Enemy plane NE shift 6
B $EF29,96,8 #HTML[<img src="images/sprites/spriteEF29.png" />] Enemy plane NE shift 7
B $EF89,32,8 32-byte gap between sprite groups
N $EFA9 Masked sprites: "S" box
B $EFA9,96,8 #HTML[<img src="images/sprites/spriteEFA9.png" />] "S" box shift 0
B $F009,96,8 #HTML[<img src="images/sprites/spriteF009.png" />] "S" box shift 2
B $F069,96,8 #HTML[<img src="images/sprites/spriteF069.png" />] "S" box shift 4
B $F0C9,96,8 #HTML[<img src="images/sprites/spriteF0C9.png" />] "S" box shift 6
N $F129 Masked sprites: Big Plane
B $F129,96,8 #HTML[<img src="images/sprites/spriteF129.png" />] Big Plane
B $F189,16,8 16-byte gap between sprite groups
N $F199 Masked sprites: Bullet ball (16x8)
B $F199,32,8 #HTML[<img src="images/sprites/spriteF199.png" />] Bullet ball shift 0
B $F1B9,32,8 #HTML[<img src="images/sprites/spriteF1B9.png" />] Bullet ball shift 1
B $F1D9,32,8 #HTML[<img src="images/sprites/spriteF1D9.png" />] Bullet ball shift 2
B $F1F9,32,8 #HTML[<img src="images/sprites/spriteF1F9.png" />] Bullet ball shift 3
B $F219,32,8 #HTML[<img src="images/sprites/spriteF219.png" />] Bullet ball shift 4
B $F239,32,8 #HTML[<img src="images/sprites/spriteF239.png" />] Bullet ball shift 5
B $F259,32,8 #HTML[<img src="images/sprites/spriteF259.png" />] Bullet ball shift 6
B $F279,32,8 #HTML[<img src="images/sprites/spriteF279.png" />] Bullet ball shift 7
N $F299 Masked sprites: Explosion (16x16, animation phases)
B $F299,64,8 #HTML[<img src="images/sprites/spriteF299.png" />] Explosion phase 1
B $F2D9,64,8 #HTML[<img src="images/sprites/spriteF2D9.png" />] Explosion phase 2
B $F319,64,8 #HTML[<img src="images/sprites/spriteF319.png" />] Explosion phase 3
B $F359,64,8 #HTML[<img src="images/sprites/spriteF359.png" />] Explosion phase 4
B $F399,64,8 #HTML[<img src="images/sprites/spriteF399.png" />] Explosion phase 5
B $F3D9,64,8 #HTML[<img src="images/sprites/spriteF3D9.png" />] Explosion phase 6
B $F419,64,8 #HTML[<img src="images/sprites/spriteF419.png" />] Explosion phase 7
B $F459,64,8 #HTML[<img src="images/sprites/spriteF459.png" />] Explosion phase 8
b $F499
b $F6D1 Scroll ring buffer: staging row at $F6D1 built by #R$C84C, ring wrapping at $FA79
c $FDFD IM2 interrupt trampoline and vector table
@ $FDFD label=im2_trampoline
N $FDFD The IM2 vector register I=$FE, so every interrupt reads the word at #R$FDFD/$FDFE. #R$FDFD holds a JP opcode ($C3, planted by #R$7D00), so the CPU executes JP #R$A0B0 (the ISR). #R$FE00 onward is the vector table itself, filled with $FD by #R$7D00 so every table entry points back here to #R$FDFD; it continues past this block's end ($FE7B) up to $FFFF.
C $FDFD,3 !!MUT-CMD!! Built at run time, never assembled: #R$7D00 plants the $C3 (JP) opcode here, and $7D1A/$A595/$A5BB/$A897/$A8F2 each write the handler address into $FDFE
b $FE00 IM 2 vector table (257 bytes of $FD, so every vector reaches the trampoline at #R$FDFD)
W $FE00,256,8 Interrupt vector table: all vectors resolve to $FDFD
b $FF00 PDS development monitor (left in the snapshot, not game code)
N $FF00 Leftover tooling from the PDS (Programmers Development System) cross-development setup, not part of the game: this region is Z80 code rather than data, talking to the PDS host interface over ports $1F and $3F. Its banner string sits at #R$FFC4.
W $FF00,2,2
t $FFC4 PDS monitor banner string
b $FFE0
