b $60C2
W $60E9,2 Saved SP
B $60EB,1 Draw-queue length (number of object-record pointers at $60EC; see #R$9900)
W $60EC,10,8 Draw queue: object-record pointers, drawn by #R$9900
W $610A,2
W $610C,2
W $610E,2 Active object list HEAD pointer: points at the most recently spawned object record; each record's +0/+1 links to the next, ending in the fixed records #R$8DB6 (player) -> $8DCF -> $8DEF -> $0000. Passed as IX into #R$84AE, which head-inserts the new object here. Other insertion points exist (e.g. $8DEF for creatures -- see #R$6663), placing objects later in the list.
W $6110,2 Currently-held item: pointer to its 4-byte item-table record (room,Y,X,sprite). Equals the fixed "empty hands" sentinel record at $788A when nothing is held. Set by #R$8AFB on pickup; the pointed-to record's room byte is zeroed on pickup and restored (to the current room, at the player's position) on drop.
B $611B,5 SCORE (5-digit BCD, most-significant byte first). Added to by #R$8879, subtracted by #R$8894, displayed (last 4 digits) by #R$885A via #R$8523.
B $6122,1 "Gnomes Gnabbed" end-game stat counter (BCD), printed by #R$86CC via #R$854F
B $6123,1 "Goodies Gathered" end-game stat counter (BCD), printed by #R$86CC via #R$854F; incremented by #R$9341 on each successful item delivery to a Plug Room corner cube
B $6124,1 "Plugs Pulled" end-game stat counter (BCD), printed by #R$86CC via #R$854F
B $6125,1 Entry-point room number choosen selecting A/B/C/D in menu, see table #R$8567
B $6126,1 Room number
W $6127,2 Room description address
B $6129,1 Room shape/layout selector (0 or 1; bit 6 from byte 3 of Room description, shifted to bit 0). Selects one of 2 fixed wall/decoration layouts drawn by #R$642F.
B $612A,1 Bits 4-7 from byte 2 of Room description, shifted to bits 0-3
B $612B,1 Room exit/door bitfield (from room description byte1; see #R$6329). Also reused throughout the code as a numeric base address for room-grid cell addressing ($612B+index, grid starting at $612C) -- these are two unrelated uses of the same address, not a conflict.
B $612C,64,8 Room grid 8x8
N $612C 8x8 grid (row-major, offset = row*8+col), cleared to 0 then populated by #R$62A2 from a shared room-type template (#R$72D1 family, selected by $612A via the #R$72B1 pointer table), plus any per-room extra pairs from the room description itself (see #R$6CCF). Each entry's grid cell address is $612B+index (i.e. grid_offset = index-1); the stored value is either a plain content code (see table below), or one of $66/$67/$68/$69/$6A/$6B which additionally triggers a dedicated object-spawn routine (#R$8EA7/#R$8EF2/#R$8F1E/#R$8F4C/#R$8E3F) -- these special values do NOT persist in the finished grid; they spawn a dynamic object instead (see #R$84AE) and the grid cell they occupied stays part of the static terrain layout only incidentally.
N $612C Static object codes: $01=small seaweed, $02=flat rock, $03=clam shell (no pearl), $04=small rock, $09=rock, $0D=seaweed, $7F=solid wall (seen as a contiguous 3x3 corner block), $0A-$10=display cubes/cases with varying item glyphs (seen in Plug Rooms). Creatures, pickups (spoon/ball/horseshoe/etc), and air-bubble sources are NEVER on the grid -- they're separate dynamic objects (see #R$84AE), not static terrain.
B $6174,1
B $6175,1 Room color 0..15
B $6179,1
B $617A,1
B $617B,1 Input device selector, read by #R$7EBE: 0=keyboard, 1=Kempston joystick, 2=Sinclair joystick, else=Cursor keys
B $617C,1 Cumulative input-held counter, incremented each frame by #R$6186's mask value (used for key-repeat timing)
B $617D,1 Keyboard row snapshot (contributes bit 4 -- fire/pick-up -- to #R$6186 via #R$7EBE)
B $617E,1 Keyboard row snapshot (contributes bit 2 to #R$6186 via #R$7EBE)
B $617F,1 Keyboard row snapshot (contributes bit 1 to #R$6186 via #R$7EBE)
B $6182,1 Keyboard row snapshot (contributes bit 3 to #R$6186 via #R$7EBE)
B $6183,1 Keyboard row snapshot (contributes bit 0 to #R$6186 via #R$7EBE)
B $6184,1 Keyboard row snapshot (also contributes bit 4 -- fire/pick-up -- to #R$6186 via #R$7EBE)
N $6186 Resolved 5-bit input mask, produced every frame by #R$7EBE from whichever control method $617B selects. Bit0=Right, bit1=Left, bit2=Down, bit3=Up (Kempston-port convention: reading Kempston directly copies its byte here unmodified), bit4=Fire/pick-up. Consumed by #R$8968 (movement -- resolved to a single direction via the table at #R$88F0) and #R$8AFB (fire button). Masked against a "previously pressed" copy at $6188 by #R$7EBE itself (edge-detection), and accumulated into a repeat counter at $617C.
B $6186,1 Resolved input mask (bit0=Right, bit1=Left, bit2=Down, bit3=Up, bit4=Fire/pick-up) -- see N-line
B $6188,1 Previous frame's #R$6186 value, used by #R$7EBE for key-repeat/edge detection
B $618A,1 Message-window restore timer (counts down in #R$9808; the room/creature title is redrawn when it expires)
W $618B,2 Free-list head pointer for the dynamic object pool (#R$A900), consumed/updated by #R$84AE. Its high byte (at $618C) is also read standalone as an empty/enabled check.
W $618D,2 Current sprite: data address (copied from a #R$A5DC record by #R$84ED)
B $618F,1 Current sprite: height, in 8px rows (copied from a #R$A5DC record by #R$84ED)
B $6190 Current sprite: width, in 8px columns, bit 7 = flip-flop flag (copied from a #R$A5DC record by #R$84ED, unmasked)
B $6193,1
W $6194,2
W $6196,2
B $6198,1 Oil cans remaining (BCD), decremented by #R$6622 on pickup/use
B $6199,1 Flag, set to 1 by #R$6622 (oil can used) -- purpose of the flag itself not confirmed
B $619A,1 Room number copy
W $619B,2
B $619D,1
B $619E,1 Weapon ammo count (BCD-ish, decremented by #R$68C1 per shot), also acts as the weapon-held flag: tested by #R$8AFB on fire/pick-up to decide attack vs. pick-up/drop; hitting 0 auto-drops the weapon
B $619F,1
B $61A0,1
B $61A1,1
B $61A2,1
B $61A3,1
B $61A6,1
c $61A7 JP (HL) trampoline
N $61A7 Used by #R$983C to call a dynamic object's per-frame behaviour handler
c $61A8 Initialize the object free list: chain B 24-byte records starting at DE (each record's first word points to the next)
N $61A8 Chains B records of 24 bytes each, starting at DE, writing each record's own first word as the address of the next. The last record links onto the existing free-list head at $618B instead of another new record, then $618B is updated to point at the chain's own start, prepending it to the free list.
C $61A8,1 Save DE, the chain's start address
C $61A9,1 B -= 1, the last record links to the existing free list instead of another new record
C $61AA,4 HL = the next record's address, current + 24 bytes
C $61AE,4 Write it as the current record's next-pointer, low then high byte, advance HL past it
C $61B2,2 Loop for each record
C $61B4,5 Swap back, DE = the existing free-list head at $618B
C $61B9,3 Write it as the last record's next-pointer
C $61BC,1 Restore HL, the chain's start address
C $61BD,3 Store it as the new free-list head at $618B
c $61C1 Reset object system
N $61C1 Clears the free/active-list pointers, then initializes two object-record free lists, at $5B00 and $A900, 8 records each, via #R$61A8.
C $61D0,3 set Active object list HEAD pointer
C $61D8,3 Initialize the object free list
C $61E0,3 => Initialize the object free list
c $61E3 New-game initialization
N $61E3 Resets oil/rust state, restocks the item table from a master template, clears per-level Plug Room progress and per-room flags, and zeroes the score/end-game counters.
C $61E3,4 clear rust timer #R$6502
C $61E7,3 clear oil-used flag #R$6199
C $61EA,5 oil cans = 42 (BCD) #R$6198
C $61EF,6 DE = item table base #R$788A, A = master item count from $7C82
C $61F5,15 loop: copy each 4-byte master item record into the live item table
C $6204,3 DE = spawner table base #R$75B5
C $6207,18 loop: skip terminator ($01) records, else mark not-yet-triggered and step to the next record by its length byte
C $6219,11 zero the score and end-game counters ($611B-$6124) via LDIR from a fixed all-zero block at $5C92
C $6224,3 DE = room description table #R$6CCF
C $6227,18 per-room flag reset: clear high nibble of byte1, clear bit 7 of byte3
C $6239,9 advance to the next room's record by its byte0 length
C $6242,2 loop until the table terminator
C $6244,15 clear all 6 levels' Plug Room delivery-progress state bytes (#R$7287 family, stride from #R$72AB) to 0
C $6224,3 Room descriptions start address
c $6254 Set object position (IX+5/+6) from grid index A (cell centre: row*8+4, col*8+4)
N $6254 A -= 1 first, then column = (A AND $F8) + 4 becomes X (+5); the original A AND $07 rotated left 3 (*8) + 4 becomes Y (+6). Converts a raw 0-63 grid index into the screen-position centre of that cell.
C $6254,1 A -= 1, adjust before extracting the column bits
C $6255,1 Save A
C $6256,4 Isolate the column value and add 4 for the cell centre
C $625A,3 Store as the object's X (IX+5)
C $625D,3 Restore A, isolate the row bits
C $6260,5 Multiply by 8, three left shifts, add 4 for the cell centre
C $6265,4 Store as the object's Y (IX+6) and return
c $6269 Set current room to A: locate its description record and build the room
N $6269 Stores the room number to $6126, walks the room-description chain from room 0 (each record's own length-byte offsets to the next) to find record A, storing its address at $6127. Extracts byte1 (door/exit bitfield) to $612B, byte2's high nibble (room-type template index into #R$72B1) to $612A, and byte3 bit 6 (shape selector) to $6129. Clears the 64-byte room grid at $612C, stamps in the room-type template via #R$62C8, then overlays this room's own extra (index,value) pairs, if its description is longer than the base 4 bytes, via the same #R$62C8 grid-writer.
C $6269,3 set room number
C $626D,3 Room descriptions start address
C $6275,1 get offset to the next room description
C $6279,3 Store room description address
C $6295,13 Clear room grid - 64 bytes at 612C
C $62A2,25 place the room-type template ($612A indexes the #R$72B1 pointer table) into the grid via #R$62C8
C $62BB,13 place this room's own extra (index,value) pairs (if its description is longer than 4 bytes) into the grid via #R$62C8
C $62C8,14 grid-entry writer: E=(HL)=index, IX=$612B+E=target address, A=(HL+1)=value, store A at (IX+0)
C $62D6,30 dispatch: check A against each special value ($66/$67/$68/$69/$6A/$6B), CALL the matching spawn routine
C $62F4,4 advance to the next pair, loop B times (a special-value spawn routine can decrement B as a side effect, see #R$8EA7)
c $62F9 Test whether the current room is this level's Plug Room
N $62F9 Via the per-level table at $7287; returns Z if so, with HL pointing at the entry's state byte.
C $62F9,3 get room number
C $62FC,2 B = the room number, A -= 1
C $62FE,3 HL = the per-level table $7281
C $6301,3 DE = 6, the per-level entry stride
C $6304,5 Advance to the next level's entry, subtracting 36 rooms per level, loop while still short
C $6309,3 A = this level's title-index base, advance HL, compare against the room number
c $630D Plug Room grid setup
N $630D For each of 4 slots in this level's delivery-state nibble, pokes marker $13 into the corresponding room-grid cell listed at $72AC when the slot's bit is set.
C $630D,3 Test whether the current room is this level's Plug Room
C $6310,1 Not the Plug Room: return
C $6311,1 A = the Plug Room's delivery-state nibble byte
C $6312,3 HL = the per-slot grid-cell table $72AC
C $6315,3 BC = $612B, the room grid base
C $6318,2 Isolate the low nibble, the 4 undelivered-slot bits
C $631A,1 All slots delivered: return
C $631B,3 Test this slot's bit, rotate into carry, skip the poke below if clear
C $631E,4 If set, read the cell offset (E,D) from the table
C $6322,4 Poke marker $13 into that grid cell
C $6326,3 Advance to the next table entry, loop for the next slot
c $6329 Build the door/exit bitfield at $612B from the room description's byte1
N $6329 Re-reads room description byte1 (at room_base+1), merges bit4 into bit0 and bit7 into bit3 (via AND $90, RRCA x4, OR), writes the result back into the room description itself AND into $612B. Bits 0-3 of the result are then tested by #R$6344/#R$6377 to conditionally draw door graphics at fixed screen positions -- one bit per exit direction: bit0=North, bit1=East, bit2=South, bit3=West (see #R$67F1).
C $6329,3 Save BC, DE, HL
C $632C,4 HL points at the room description's byte1 (advance past the 2-byte pointer at $6127)
C $6330,3 A = byte1 masked to bits 4 and 7 (the two door-exit flag bits)
C $6333,4 Rotate right 4 places, moving bits 4/7 down into bits 0/3
C $6337,1 OR back into byte1's other bits
C $6338,1 Compare against the original byte1 value
C $6339,1 Store the merged value back into byte1
C $633A,3 Store the same merged value into $612B, the door bitfield
C $633D,3 Draw single-piece doors, for $612B bits 0 and 3
C $6340,4 Restore HL, DE, BC and return
c $6344 Draw single-piece doors, for $612B bits 0 and 3
N $6344 Tests bit 0 of $612B (North), drawing one door-graphic piece via #R$8128 at a fixed screen position if set; then bit 3 (West), drawing a different fixed-position piece if set.
C $6344,6 BC = mask/colour $C7C7, A = the door bitfield $612B
C $634A,4 Test bit 0 (North); if set, skip to the alternate mask below
C $634E,7 Otherwise BC = $BBBB, test bit 4; if clear, skip drawing entirely
C $6355,6 A = sprite $83, D/E = the fixed screen position for the North door piece
C $635B,3 Draw sprite C with its mask at screen position DE
C $635E,6 BC = mask/colour $C7C7 again, A = the door bitfield
C $6364,4 Test bit 3 (West); if set, skip to the alternate mask below
C $6368,6 Otherwise BC = $BBBB, test bit 7; if clear, return without drawing
C $636E,6 A = sprite $03, D/E = the fixed screen position for the West door piece
C $6374,3 => Draw sprite C with its mask at screen position DE
c $6377 Draw three-piece doors, for $612B bits 1 and 2
N $6377 Tests bit 1 of $612B (East), drawing three door-graphic pieces via #R$8128 (three fixed screen positions) if set; then bit 2 (South), drawing three different fixed-position pieces if set. Calls #R$6344 first.
C $6377,3 Draw single-piece doors, for $612B bits 0 and 3
C $638A,3 Draw sprite C with its mask at screen position DE
C $6396,3 Draw sprite C with its mask at screen position DE
C $63A2,3 Draw sprite C with its mask at screen position DE
C $63B4,3 Draw sprite C with its mask at screen position DE
C $63C0,3 Draw sprite C with its mask at screen position DE
C $63CC,3 Draw sprite C with its mask at screen position DE
c $63D0 Clear shadow screen
N $63D0 Zeroes the entire shadow screen buffer, $E390 through $17FF bytes, via a single-byte seed plus LDIR fill.
C $63D0,3 Shadow screen address
b $63DE
c $642F Draw the fixed wall/decoration layout selected by $6129
N $642F Uses $6129 (0 or 1) to index a 2-entry pointer table at $63DE, selecting one of two fixed layout lists. Each list has two parts: a sequence of 4-byte records (count, screen Y, screen X -- drawn via #R$8128) terminated by $FF, immediately followed by a sequence of single bytes (grid indices) terminated by $FF, each poked into the room grid ($612B+index, i.e. grid_offset=index-1) as solid wall ($7F). This is the source of the 3x3 solid-wall corner block seen in every room grid -- it is not part of the room-type template; it is this fixed, $6129-selected layout.
C $642F,9 index the layout pointer table $63DE by $6129 (0 or 1)
C $6438,4 HL = the table entry address
C $643C,6 DE = the selected layout pointer, IX = DE
C $6442,7 *loop: read this entry's count, jump away at the terminator ($FF)
C $6449,10 C/B = count, DE = screen position
C $6453,3 draw via #R$8128
C $6456,7 advance IX by 4 (next entry), loop back
C $645D,5 terminator reached: IX++ (skip the $FF), read the next byte
C $6462,3 test for the outer terminator ($FF), return if done
C $6465,3 C = grid index, B = 0
C $6468,6 poke solid wall ($7F) into the grid cell, loop back
C $6453,3 Draw sprite C with its mask at screen position DE
c $6470 Redraw one terrain grid cell (index in BC), used to restore terrain hidden behind an object's sprite
N $6470 Called by #R$9745 (occlusion redraw) and #R$9341 (Plug Room item delivery). Looks up the cell's grid value in the #R$7556 shape table, then falls into #R$64BB's draw loop.
C $6470,8 save row (B) to $649A, C = column
C $6478,5 HL = grid cell address, read its content
C $647D,10 bail out if solid wall ($7F) or already-redrawn (masked $7F)
C $6487,26 compute the screen address from the grid column
C $64A1,3 store the computed screen row byte
C $64A4,8 compute the screen column offset
C $64AC,4 HL = grid content value * 2
C $64B0,11 look up the #R$7556 shape table, extract count (C) and target (B), fall into #R$64BB's draw loop
c $64BB Draw loop shared with #R$6470: resolve a grid/terrain value to a sprite via the #R$74CE/#R$750B tables and draw it
N $64BB For a grid cell whose terrain value (A) resolves via #R$9AAB/$750B to a sprite/column entry, computes a screen sub-position threshold against $D0 to pick between adjacent sprite variants, then draws it via #R$8128 with colour 0, adjusting the returned D (screen row-delta) via a small per-entry table before looping across the row, count B, called by #R$6470 for each terrain cell.
C $64BB,3 save BC/HL, A = grid value
C $64C1,9 index the #R$750B table by the lookup result
C $64CA,5 C = column index, compare against a $D0 threshold
C $64CF,7 branch on the threshold result
C $64D6,4 D -= next table byte
C $64DA,2 A = 0 (colour parameter)
C $64DF,2 branch on the draw result
C $64E1,4 adjust D via the mask table
C $64E5,3 restore D, HL, BC
C $64E8,3 advance, loop #R$64BB count (B) times
C $64EB,2 restore AF, return
C $64ED,6 alternate branch: adjust and rejoin the exit path
C $64BE,3 Search the (key,data) pair table at $74CE for key A
C $64DC,3 Draw sprite C with its mask at screen position DE
c $64F3 Redraw the whole room's terrain grid
N $64F3 Loops A from 0 up to $3F, all 64 grid cells, with B fixed at $17, calling #R$6470 once per cell to redraw it.
C $64F6,3 Redraw one terrain grid cell (index in BC), used to restore terrain hidden behind an object's sprite
b $64FF
B $6500 Oil level??
B $6501 Rust/oil timer -- reset to 0 (full oil) by #R$6622 on using an oil can; per the game instructions, rust accumulates on contact with water and is reversed by oil
B $6502 Oil level??
c $6503 Per-frame rust/oil tick: advances the rust timer, killing the player at $52
N $6503 Does nothing if a game-over flag ($617A) is set, or in rooms 1/2 (ending/menu). If the oil-used flag ($6199) is set, just calls #R$6580 to tick the gauge display. Otherwise decrements a countdown at $6501, and every time it wraps, decrements a cycle counter at $6500; when that hits zero, reloads it from $64FF and increments the rust level at $6502. Once rust reaches $52, the player is killed: switches the player's per-frame handler to $8C48 and sets the game-over flag.
C $6507,1 POKE 201 (RET) here for infinite Oil
C $6508,3 get room number
C $6515,3 => Tick the rust/oil gauge
C $6536,3 set player behaviour-handler pointer
b $653F
c $6543 Draw one rust-gauge segment: compute its screen column from A and its sprite from table $653F, then draw via #R$8128
N $6543 Screen column comes from A rotated into a fixed base ($AD, masked to 4-pixel steps); the sprite number is looked up in a 4-entry table at $653F, indexed by (A+1) AND $03, so the segment's appearance cycles through 4 sprite variants as the gauge fills. Draws via #R$8128 with a fixed row/mask setup (B=C=the looked-up sprite, colour 5).
C $6543,1 B = the gauge position parameter A
C $6544,4 Compute the screen column: add $AD and mask to a 4-pixel boundary
C $6548,3 DE = the column address, high byte fixed at $FC
C $654B,6 A = the saved position, compute (A+1) AND 3, the 4-way sprite-variant index
C $6551,5 BC = the index, HL = the sprite-variant table $653F
C $6556,3 Look up the sprite number, C = B = that value
C $6559,2 A = 5, the colour parameter
C $655B,3 => Draw sprite C with its mask at screen position DE
c $655E Draw the rust/oil gauge: base icon plus repeated #R$6543 icons, scaled by the rust timer $6502
N $655E Draws a fixed base icon, sprite $C5 colour 3, at $FCD4, then repeated rust-gauge segments via #R$6543 at increasing positions, A stepping by 3, up to the rust timer $6502, finishing with one more segment at the timer's exact value unless it's already zero.
C $6566,3 Draw sprite C with its mask at screen position DE
C $6572,3 Draw one rust-gauge segment
C $657D,3 => Draw one rust-gauge segment
c $6580 Tick the rust/oil gauge
N $6580 Decrements timer $6502 by up to 2 and redraws via #R$655E, or when already zero, clears the oil-used flag $6199.
C $6588,3 => Draw the rust/oil gauge
C $658C,3 => Draw the rust/oil gauge
c $6593 Draw the message window's border/frame: corner icon plus 8-wide top and bottom edge strips, all via #R$8128
N $6593 Draws the window's top-left corner icon at $EC2C, then two 8-wide edge strips: the top edge starting at $C408 stepping +8,+16 per tile, and the bottom edge starting at $C4F8 stepping +8,-16 per tile, all via #R$8128.
C $6593,6 DE = the corner icon's screen position $EC2C, B = C = its sprite $C8
C $6599,2 A = 2, the colour parameter
C $659B,3 Draw sprite C with its mask at screen position DE
C $659E,8 DE = the top-edge start position $C408, B = C = sprite $C3, H = 8, the tile count
C $65A6,2 A = 2, the colour parameter
C $65A8,3 Draw sprite C with its mask at screen position DE
C $65AB,8 Advance the screen position: +8 rows, +16 columns
C $65B3,3 Decrement the tile count, loop for the top edge
C $65B6,8 DE = the bottom-edge start position $C4F8, B = C = sprite $C4, H = 8
C $65BE,2 A = 2, the colour parameter
C $65C0,3 Draw sprite C with its mask at screen position DE
C $65C3,8 Advance the screen position: +8 rows, -16 columns
C $65CB,3 Decrement the tile count, loop for the bottom edge
b $65CF
B $65D3
W $65D7
W $65D9
c $65DB Draw message window: room/creature title line + rotating clue/joke message line
N $65DB Prints the fixed "DEATHBOWL" banner via #R$65CF's prefix, then computes and prints this room's title string, looked up in a table at $73B5 indexed by the room description's byte3 low 6 bits (title index) times 8. Follows with a second, rotating clue/joke message line from a pointer at $65D7 (wrapping to $7441 at the $FF terminator), advancing that pointer by $14, one entry, each call so successive room visits cycle through the message list.
C $65DE,3 Print string routine
C $65F6,3 "  DEATHBOWL  "
C $65FD,3 Print string routine
C $6603,3 Print string routine
C $6614,3 Print string routine
c $6622 Use an oil can (kind $6E pickup, see #R$8AFB): resets rust timer, decrements oil-can count, plays sound
N $6622 Sets $6199=1, resets the rust/oil timer $6501 to 0 (full), decrements oil-can count $6198 (BCD), calls $6646 (unidentified), plays sound effect $09.
C $6622,5 Set the oil-used flag $6199
C $6627,4 Clear the rust timer $6501
C $662B,8 HL = the oil-can count $6198, decrement it in BCD
C $6636,2 A = sound effect $09
C $6638,3 => Request sound effect A
c $663B Draw the oil-can icon and its remaining count on HUD ($6198)
N $663B Draws the fixed oil-can icon, sprite $6E colour 5, at screen position $D408 via #R$8128, then prints the remaining oil-can count from $6198 as a BCD number via #R$854F.
C $6643,3 Draw sprite C with its mask at screen position DE
C $6646,3 Print an inline string embedded right after the caller's CALL instruction
T $6649,4 cursor position only, no visible text
C $6650,3 => Print BCD byte A as two digits, high digit blanked to a space if zero
c $6653 Prepare room with color 0
C $6654,3 => Draw the room's background
c $6657 Get room color from room description and store to 6175
N $6657 Reads byte3 of the current room description ($6127+3), masks to the low nibble, colour, ignoring the size bits, and stores it to $6175.
C $6657,3 get room description address
C $665C,1 get Byte 3: Room colour and Room Size
C $665D,2 color only
C $665F,3 Store room color
c $6663 Spawn the room's creature (dynamic object)
N $6663 Fires during room build. Passes IX=$8DEF (the creature insertion point -- see #R$8DB6) into #R$84AE, so the creature is spliced into the active object list right after the fixed records, i.e. processed after the player. Handler is #R$9341.
C $6669,3 Dynamic object allocator
W $666C,2 Dynamic object handler address (#R$9341)
C $6679,3 Set object position (IX+5/+6) from grid index A
C $6685,3 Search the (key,data) pair table at $74CE for key A
C $668C,3 Dynamic object finalizer
c $6692 Insert a record pointer (DE) into the draw queue (#R$60EC), sorted by the record's offset+2 byte
N $6692 Insertion-sorts DE into the queue, keeping it ordered by each record's offset+2 byte (normally the "owning room" field elsewhere -- its role as a sort key here isn't confirmed). Shifts later entries down to make room; consumed by #R$9900.
C $6692,11 save BC/HL, DE = the new record pointer, IX = queue base $60EC, A = queue count
C $669D,2 branch to the append path if the queue is empty
C $669F,10 *loop: save the count, HL = this queue entry's record pointer, advance both pointers to offset+2
C $66A9,7 compare the fields, restore the pointers to record base
C $66B0,9 skip the shift if not before this entry, else shift this entry's pointer up one slot
C $66B9,4 advance to the next queue slot
C $66BD,4 restore the count, loop
C $66C1,6 store the new record pointer into the current queue slot
C $66C7,4 increment the queue count
C $66CB,3 restore HL/BC, return
c $66CE Room build: spawn each active object then settle it to the ground (height field +0x07, via collision test #R$9BF0)
N $66CE Saves and clears a global "building" flag byte at $8DB8 for the duration. For each active object (count $60EB, records at $60EC), calls #R$6663 to spawn/refresh it, then settles its height field (+0x07) toward the ground: decrements by 4 with a #R$9BF0 collision test each step while above $18, or increments by 4 while blocked below $18, clamping to whichever bound clears the test. Clears bit 7 of the flags byte (+0x0D) and writes the settled height into the record's linked height-shadow field (offset+2 via +0x0E/+0x0F), then restores $8DB8 on completion. Called after #R$6728 queues the room's items.
C $66CE,3 HL = the "building" flag byte $8DB8
C $66D1,4 Save its value, clear it to 0
C $66D5,4 B = the active-object count from $60EB
C $66D9,2 If zero, nothing to build, skip to the end
C $66DB,5 B = count, IX = the active-object record-pointer list at $60EC
C $66E0,1 Save BC, the outer loop counter
C $66E1,5 Save IX, load the record pointer into HL
C $66E6,3 HL = the record pointer
C $66EC,8 Decrement the height field (+0x07) by 4
C $66F4,4 Compare against the rest height $18, skip the extra push below if still above it
C $66FB,2 Loop back while still settling
C $66FD,8 Blocked: increment the height field (+0x07) by 4 instead
C $6708,2 Loop back while still blocked
C $670A,4 Clear bit 7 of the flags byte (+0x0D)
C $670E,8 HL = the record's linked height-shadow field (offset+2 via +0x0E/+0x0F)
C $6716,4 Write the settled height into it
C $671A,6 Restore IX, advance it past this record
C $6720,3 Restore BC, loop for the next object
C $6723,4 Restore the saved flag byte, write it back to $8DB8
C $66E9,3 Spawn the room's creature
C $66F8,3 Collision test
C $6705,3 Collision test
c $6728 Queue this room's dropped items for drawing
N $6728 Scans the item table at $788A for entries in the current room, inserting each via #R$6692, then builds the room.
C $6733,3 get room number
C $6737,3 Insert a record pointer (DE) into the draw queue (#R$60EC), sorted by the record's offset+2 byte
C $6740,3 => Room build
c $6743 Draw the room title, awarding a first-visit bonus the first time this room is entered
N $6743 Tests bit 7 of the room description's byte3 (a "room already visited" flag, distinct from bit 6's shape selector and bits 0-5's title index -- see Room-Format.md section 4). If not yet set: marks it, draws the title via #R$88D7, and adds 5 (BCD) to a counter at $6120/$6121. If already visited, just draws the title via #R$88DD (no bonus).
C $6743,6 HL = room description byte3 (address + 3)
C $6749,4 test the "room visited" flag (bit 7), skip the bonus if already set
C $674D,2 mark the room as visited (set bit 7)
C $674F,7 draw the room title (first-visit variant) via #R$88D7
C $6756,4 HL = the BCD bonus counter $6120
C $675A,4 add 5, store
C $675E,7 propagate the carry into the counter's high byte, return
C $6765,4 already-visited path: IY = title data $7C9A
C $6769,3 Subtract a BCD value from the score, value from a circular queue via #R$88B9
c $676D Draw current room
N $676D Draw the full room (walls, doors, message window, creatures/objects) -- or the reduced special-room variant for rooms $01/$02
N $676D Rooms $01 and $02 are the only two type $E rooms, and are special "no walls" rooms (see #R$6CCF -- room $01 is the ending/winning room). At #R$67AB, this routine checks if the current room ($6126) is 1 or 2 and, if so, skips straight to #R$67E0, bypassing: the wall/layout draw (#R$642F), door-graphic draw (#R$6377), the message window (#R$65DB), and several creature/object placement calls (#R$6593/$655E/$663B/$6743/$8F82/$6895/$885A). The room's grid contents (rocks/seaweed etc, from its type $E template) still get drawn via a separate, non-skipped path -- consistent with the "just floating rocks and seaweed, no walls" appearance of room $01. Room $01 additionally gets one extra call, #R$86CC (CALL Z at #R$67E8, gated on room==1 specifically, not room==2) -- draws the "DEATHBOWL DIVINED" end-game stats overlay (see #R$86CC).
C $6776,3 get room number
C $678D,3 Snap the object's position (IX+5/+6) to its grid-cell centre, then finalize via #R$9A60
C $6796,3 Reset object system
C $679C,3 Set current room to A
C $679F,3 Plug Room grid setup
C $67A2,3 Reset the sprite-draw clip window ($610A-$610D) to the full play-field
C $67A5,3 Reset the redraw bounding-box trackers ($6194-$6197) to empty
C $67A8,3 Clear shadow screen
C $67AB,3 get Room number
C $67AE,8 if room $6126 is 1 or 2, skip to #R$67E0 (special "no walls" room -- see #R$676D)
C $67B6,3 Draw the fixed wall/decoration layout selected by $6129
C $67B9,3 Redraw the whole room's terrain grid
C $67BC,3 Draw the message window's border/frame
C $67BF,3 Draw three-piece doors, for $612B bits 1 and 2
C $67C2,3 Draw the rust/oil gauge
C $67C5,3 Draw message window
C $67C8,3 Draw the oil-can icon and its remaining count on HUD
C $67CB,3 Draw the room title, awarding a first-visit bonus the first time this room is entered
C $67CE,3 Prepare room with color 0
C $67D1,3 Get room color from room description and store to 6175
C $67D4,3 Spawn room-membership-gated decoration pairs
C $67D7,3 Draw the currently-held item's icon, and its ammo count if it's a weapon, on HUD
C $67DA,3 Redraw the score display on HUD
C $67DD,3 => Queue this room's dropped items for drawing
N $67E0 Special-room path for rooms $01/$02: skips walls/doors/message-window/most creature calls; room $01 additionally calls #R$86CC (likely the end-game stats overlay)
C $67E0,3 Redraw the whole room's terrain grid
C $67E3,3 get Room number
C $67E8,3 Draw the end-game stats screen
C $67EB,3 Prepare room with color 0
C $67EE,3 => Get room color from room description and store to 6175
c $67F1 Attempt to move to an adjacent room (horizontal, via a door) in the direction given by ($8DC1)
N $67F1 Reads a direction code from ($8DC1) -- 1, 2, 4, or else (fallback case) -- and for each, tests one bit of the door bitfield at #R$612B via HL (set to $612B just before this dispatch) before allowing the move: bit 0 (direction code 1) gates "room number - 6" (row-1, NORTH); bit 1 (direction code 4) gates "room number + 1" (col+1, EAST); bit 2 (direction code 2) gates "room number + 6" (row+1, SOUTH); bit 3 (the fallback case) gates "room number - 1" (col-1, WEST). Also does on-screen player-position bounds checks (against D/E, likely screen row/col) before allowing the move, presumably to require the player to be near the room edge on that side. #R$97FC is called with the new room number to actually perform the transition.
C $6819,3 get room number
C $6824,3 => Change current room to A = new room number
C $681C,2 change room number: -6 (row-1, move NORTH)
C $683D,3 get room number
C $6840,1 change room number: +1 (col+1, move EAST)
C $685B,3 get room number
C $685E,2 change room number: +6 (row+1, move SOUTH)
C $6876,3 get room number
C $6879,1 change room number: -1 (col-1, move WEST)
c $6880 Count item-table entries whose room byte matches A
N $6880 Walks the item table at $788A (count from $7C81, entry stride 8), counting entries whose room byte equals A, returning the count in A. Used to check how many of a room's dropped items remain.
C $6880,3 HL = the item table $788A
C $6883,3 DE = the entry stride, 8 bytes
C $6886,4 BC = the table's entry count
C $688A,2 C = 0, the match counter
C $688C,1 Compare A against this entry's room byte
C $688D,2 If different, skip the increment below
C $688F,1 Match: C += 1
C $6890,3 Advance to the next entry, loop
C $6893,1 A = the match count, return
c $6895 Draw the currently-held item's icon, and its ammo count if it's a weapon, on HUD
N $6895 Draws the sprite from the held-item record (#R$6110, offset +3) at fixed HUD position $D4F8 via #R$8128, then checks (via #R$88E3) whether it's a weapon; if so also prints its ammo count (#R$619E, BCD) via #R$854F.
C $68A4,3 Draw sprite C with its mask at screen position DE
C $68A8,3 Search the buffer at $7C83 for byte A
C $68B1,3 Print an inline string embedded right after the caller's CALL instruction
T $68B4,4 cursor position only, no visible text
C $68B8,3 get Weapon-held flag
C $68BB,3 Print BCD byte A as two digits, high digit blanked to a space if zero
c $68C1 Consume one shot of ammo; auto-drop the weapon when empty
N $68C1 Decrements #R$619E (ammo, BCD); if still nonzero, just redraws the HUD ammo count. If it reached 0: clears the HUD digits, resets #R$6110 (held item) to the "empty hands" sentinel #R$788A, and redraws the HUD icon via #R$6895.
C $68CC,3 Print an inline string embedded right after the caller's CALL instruction
T $68CF,6 two spaces at cursor position
C $68DB,3 => Draw the currently-held item's icon, and its ammo count if it's a weapon, on HUD
b $68DE
t $6997
c $69AC Draw the room's background
N $69AC Fills the diamond floor/border with the room colour, special-cased for room 1 (ending screen) and room 2 (menu screen).
C $69AC,8 build the border attribute byte (room colour OR $40), store to $6175, enable interrupts
C $69B4,3 HL = frame counter $5C78 (system variable)
C $69B7,4 wait for the next frame interrupt
C $69BB,5 save IX, A = room colour
C $69C0,8 index the per-colour table $6994 by room colour * 3
C $69CB,2 test the table entry
C $69CD,2 branch to $69DF if empty
C $69CF,13 branch on room number: room 1 -> ending screen prep, room 2 -> menu screen prep, else fall through
C $69DF,3 HL = $6175 (fallback path, no per-colour table entry)
C $69E2,9 DE = $6176, copy the 3-byte room-colour record via LDI
C $69EB,4 IX = wall-piece table $68DE
C $69EF,6 read this entry's screen address (IX+0/1)
C $69F5,4 stop the loop at the table terminator
C $69F9,3 B = row count (IX+4)
C $69FC,3 DE = $6174
C $69FF,3 advance DE by B, read a colour byte from the table row
C $6A02,4 read and store the row colour for the fill below
C $6A06,7 A = column count (IX+3) minus 1, store it, then negate and add $20 for the row stride
C $6A14,5 A = paint count (IX+2), B = 0
C $6A19,2 *loop: poke attribute pattern $40 into the current cell
C $6A1B,5 DE = HL+1, C = 1
C $6A20,2 copy the row's pattern via LDIR
C $6A22,6 advance HL by the row stride ($1F), loop A times
C $6A28,5 advance IX to the next table entry (5 bytes), loop back
C $6A2F,2 restore IX, return
C $6A32,6 room 1: fill the top attribute rows with a striped pattern
C $6A38,16 fill an 8-byte block, then the room-colour block, then a further striped block via LDIR
C $6A4F,8 copy that pattern across the whole screen attribute area
C $6A5D,25 room 1: fill the $5920 block (message-window area) with room colour and striped patterns via LDIR
C $6A7E,13 room 2: fill the whole screen attribute area with the room colour via LDIR
C $6A8D,16 room 2: fill two further attribute blocks ($5800, $5954) with a fixed pattern ($45) via LDIR
C $69CF,3 get room number
R $69AC A Room color
C $6A32,3 Screen attribute area start address
c $6AAA Interrupt service routine: advance the frame counter, drive the AY music chip, then run per-frame game logic
N $6AAA Increments the ROM frame counter $5C78, and unless sound is disabled ($61A0), drives the 128K AY sound chip via port $7FFD and the ROM's PLAY_SOUND routines ($F424/$F427) to advance the music. Calls #R$6AFB for the actual per-frame game update, then restores everything and re-enables interrupts.
C $6AAA,8 save all registers
C $6AB2,7 increment the frame counter $5C78
C $6AB9,6 test the sound-enable flag $61A0, skip the music update if set
C $6ABF,5 select AY register 17 via port $7FFD
C $6AC6,7 compare the current/previous melody-period byte at $61A2/$61A3, update it
C $6ACD,3 if it changed, call the ROM sound routine $F424
C $6AD0,3 call the ROM routine $F427 to advance the sound driver
C $6AD3,7 restore the AY register select to $10
C $6ADA,3 Self-modified per-frame hook, called by the ISR #R$6AAA
C $6ADD,8 restore all registers
C $6AE5,2 enable interrupts, return
c $6AE7 ISR continuation setup: latch the resume address and clear the frame-ready flag
N $6AE7 Pops the return address off the stack and stores it to the self-modified jump target at $6AF9, clears the frame-ready flag byte at $6AFB, then re-enables interrupts and returns.
c $6AF1 Idle loop: enable interrupts, drive the sound-effect player each pass
C $6AF1,1 Enable interrupts
C $6AF2,3 Per-frame sound-effect player
C $6AF5,3 => Idle loop
C $6AF2,3 Per-frame sound-effect player
c $6AF8 Jump to new-game initialization
C $6AF8,3 => New-game initialization
C $6AF8,3 => New-game initialization
c $6AFB Self-modified per-frame hook, called by the ISR #R$6AAA (currently a RET stub, patched by #R$6AFC)
C $6AFB,1 Do nothing, until self-modified
c $6AFC Patch #R$6AFB to RET (disabling the hook), then jump to new-game initialization
C $6AFC,2 A = $C9, the RET opcode
C $6AFE,3 Patch it into #R$6AFB, disabling further triggers
C $6B01,1 Enable interrupts
C $6B02,3 => Jump to new-game initialization
c $6B05 New-game initialization
N $6B05 Sets up the player object, global state, and 128K sound, draws the starting room, then enters the main loop.
C $6B05,3 New-game initialization
C $6B0B,3 set player behaviour-handler pointer
C $6B1F,3 Set object position (IX+5/+6) from grid index A
C $6B27,3 set Weapon-held flag
C $6B39,3 set Entry-point room number choosen selecting A/B/C/D in menu
C $6B68,3 Draw current room
C $6B6B,3 Per-frame main loop entry
C $6B6E,3 System/interrupt setup before the main menu
c $6B71 Main game loop
N $6B71 Frame-rate pacing, per-frame updates (redraw flush, oil timer, screen flip), game-over restart check, and pause/menu key handling.
C $6B7D,3 ISR continuation setup
C $6B8F,3 Per-frame rust/oil tick
C $6B92,3 End-of-frame screen flip
C $6B95,3 get room number
C $6BA5,3 Flush the queued redraw requests at $9D3C
C $6BA8,3 Per-frame main loop entry
C $6BB0,3 => New-game initialization
C $6BC3,3 => New-game initialization
b $6C06 Sprite number -> mask sprite number table (indexed by sprite number, read by #R$8128)
b $6CCF Room descriptions.
N $6CCF The world is a 6x6x6 cube of room slots (6 levels, each a 6x6 grid), per an external game map. The highest room number in this table is $D7=215=6*6*6-1, and the table has 216 records total ($00-$D7) -- one per cube slot, including ~15 unused/vacant ones (no room actually there). Horizontal (same-level) neighbours connect via doors (#R$612B); vertical neighbours connect via whirlpools (down, #R$8A87) and bubbles (up, also #R$8A87).
N $6CCF The room number decodes to its cube position via n=room_number-1, then level=n/36, row=(n%36)/6, col=n%6 (0-based). Cross-checked against the 4 menu entry points (A/B/C/D) and an external game map (see x-docs/Room-Format.md).
N $6CCF Room description format (consumed by #R$6269/#R$62BB):
N $6CCF byte 0: record length (offset to the next room's description);
N $6CCF byte 1: door/exit bitfield, stored to $612B (bit0=North, bit1=East, bit2=South, bit3=West -- see #R$6329/#R$67F1);
N $6CCF byte 2 bits 4-7: room type index (0-15), stored to $612A -- selects the grid template from the #R$72B1 pointer table AND the room's creature/inhabitant (via the same value used again below);
N $6CCF byte 3 bit 6: wall/decoration layout selector, stored to $6129 (selects one of 2 fixed layouts drawn by #R$642F);
N $6CCF byte 3 bits 0-5: a 6-bit index (byte3 AND $3F) into the #R$73B5 room/creature title table -- selects the message-window title text (DEATHBOWL/PIRANHA/SEAHORSE/etc), printed by #R$65FD. NOT door/exit flags -- exits are encoded in byte1 (see #R$6329).
N $6CCF bytes 4+ (if record length > 4): extra (index,value) pairs specific to this room, laid out and consumed identically to a room-type template (see #R$72D1) -- appended on top of the shared room-type template when the room grid is built. The loop counter B starts at (length-4), but a special-value pair (value in $66/$67/$68/$69/$6A/$6B) makes its spawn routine (e.g. #R$8EA7) decrement B as a side effect, ending the loop early. Example: room $52 (#R$6ECF) has 3 trailing bytes $37/$6A/$20 -- its single special pair ($37,$6A) consumes 2, and the double-decrement ends the loop before the last byte ($20) is read. Odd leftover-byte counts are therefore normal whenever a special-value entry is present.
N $6CCF The "Room $XX" labels below match the in-game room number as read from $6126 (i.e. 1-based: the first record is room $01).
N $6CCF Level 1 of 6 (room numbers $01-$24, cube rows/cols 0-5 -- see x-docs/Room-Format.md) -- entry point 'C' lands in this level (room $1A)
B $6CCF,4 Room $01 description, type $E -- the special ENDING/WINNING room
B $6CD3,3
B $6CD6,4 Room $02 description, type $E -- the special MENU room
B $6CDA,2
B $6CDC,4 Room $03 description, type $0
B $6CE0,4 Room $04 description, type $5
B $6CE4,4 Room $05 description, type $0
B $6CE8,6
B $6CEE,4 Room $06 description, type $1
B $6CF2,4
B $6CF6,4 Room $07 description, type $4
B $6CFA,4
B $6CFE,4 Room $08 description, type $6
B $6D02,2
B $6D04,4 Room $09 description, type $3
B $6D08,4 Room $0A description, type $7
B $6D0C,4 Room $0B description, type $1
B $6D10,4 Room $0C description, type $0
B $6D14,2
B $6D16,4 Room $0D description, type $1
B $6D1A,4 Room $0E description, type $0
B $6D1E,4 Room $0F description, type $0
B $6D22,10
B $6D2C,4 Room $10 description, type $0
B $6D30,4 Room $11 description, type $5
B $6D34,6
B $6D3A,4 Room $12 description, type $4
B $6D3E,6
B $6D44,4 Room $13 description, type $7
B $6D48,8
B $6D50,4 Room $14 description, type $1
B $6D54,2
B $6D56,4 Room $15 description, type $3
B $6D5A,4 Room $16 description, type $2
B $6D5E,2
B $6D60,4 Room $17 description, type $0
B $6D64,4
B $6D68,4 Room $18 description, type $7
B $6D6C,4 Room $19 description, type $0
B $6D70,4 Room $1A description, type $0
B $6D74,4 Room $1B description, type $2
B $6D78,4 Room $1C description, type $3
B $6D7C,2
B $6D7E,4 Room $1D description, type $0
B $6D82,2
B $6D84,4 Room $1E description, type $1
B $6D88,2
B $6D8A,4 Room $1F description, type $2
B $6D8E,6
B $6D94,4 Room $20 description, type $6
B $6D98,2
B $6D9A,4 Room $21 description, type $2
B $6D9E,4 Room $22 description, type $1
B $6DA2,6
B $6DA8,4 Room $23 description, type $1
B $6DAC,4
B $6DB0,4 Room $24 description, type $5
N $6DB4 Level 2 of 6 (room numbers $25-$48)
B $6DB4,4 Room $25 description, type $0
B $6DB8,4 Room $26 description, type $0
B $6DBC,4 Room $27 description, type $0
B $6DC0,4 Room $28 description, type $7
B $6DC4,4 Room $29 description, type $0
B $6DC8,6
B $6DCE,4 Room $2A description, type $1
B $6DD2,4
B $6DD6,4 Room $2B description, type $6
B $6DDA,5
B $6DDF,4 Room $2C description, type $8
B $6DE3,4 Room $2D description, type $3
B $6DE7,2
B $6DE9,4 Room $2E description, type $2
B $6DED,4 Room $2F description, type $5
B $6DF1,4 Room $30 description, type $0
B $6DF5,2
B $6DF7,4 Room $31 description, type $7
B $6DFB,4 Room $32 description, type $F -- one of 4 PLUG ROOMs (see #R$73B3), cube position level 2, row 2, col 1
B $6DFF,12 4 decor cubes at grid corners (2,2)/(2,6)/(6,2)/(6,6), values $0F/$0E/$0E/$0F; then Plug+Whirlpool co-located at grid cell $25 -- see #R$8F4C/#R$8F1E
B $6E0B,4 Room $33 description, type $1
B $6E0F,6
B $6E15,4 Room $34 description, type $0
B $6E19,2
B $6E1B,4 Room $35 description, type $3
B $6E1F,6
B $6E25,4 Room $36 description, type $0
B $6E29,2
B $6E2B,4 Room $37 description, type $2
B $6E2F,4 Room $38 description, type $0
B $6E33,2
B $6E35,4 Room $39 description, type $2
B $6E39,4 Room $3A description, type $3
B $6E3D,4 Room $3B description, type $1
B $6E41,4 Room $3C description, type $3
B $6E45,4 Room $3D description, type $7
B $6E49,4 Room $3E description, type $5
B $6E4D,6
B $6E53,4 Room $3F description, type $3
B $6E57,4 Room $40 description, type $0
B $6E5B,4 Room $41 description, type $1
B $6E5F,6
B $6E65,4 Room $42 description, type $0
B $6E69,2
B $6E6B,4 Room $43 description, type $0
B $6E6F,4
B $6E73,4 Room $44 description, type $8
B $6E77,4 Room $45 description, type $7
B $6E7B,4
B $6E7F,4 Room $46 description, type $3
B $6E83,4 Room $47 description, type $5
B $6E87,2
B $6E89,4 Room $48 description, type $4
B $6E8D,14
N $6E9B Level 3 of 6 (room numbers $49-$6C) -- entry point 'A' lands in this level (room $52)
B $6E9B,4 Room $49 description, type $3
B $6E9F,2
B $6EA1,4 Room $4A description, type $6
B $6EA5,10
B $6EAF,4 Room $4B description, type $0
B $6EB3,4 Room $4C description, type $1
B $6EB7,4
B $6EBB,4 Room $4D description, type $3
B $6EBF,4 Room $4E description, type $0
B $6EC3,4 Room $4F description, type $0
B $6EC7,4 Room $50 description, type $2
B $6ECB,4 Room $51 description, type $1
B $6ECF,4 Room $52 description, type $0
B $6ED3,3
B $6ED6,4 Room $53 description, type $6
B $6EDA,4 Room $54 description, type $5
B $6EDE,6
B $6EE4,4 Room $55 description, type $1
B $6EE8,4 Room $56 description, type $5
B $6EEC,4 Room $57 description, type $2
B $6EF0,4 Room $58 description, type $3
B $6EF4,4 Room $59 description, type $4
B $6EF8,4
B $6EFC,4 Room $5A description, type $0
B $6F00,4
B $6F04,4 Room $5B description, type $4
B $6F08,8
B $6F10,4 Room $5C description, type $6
B $6F14,4 Room $5D description, type $1
B $6F18,4
B $6F1C,4 Room $5E description, type $0
B $6F20,4
B $6F24,4 Room $5F description, type $0
B $6F28,4
B $6F2C,4 Room $60 description, type $5
B $6F30,9
B $6F39,4 Room $61 description, type $0
B $6F3D,4 Room $62 description, type $0
B $6F41,6
B $6F47,4 Room $63 description, type $4
B $6F4B,4 Room $64 description, type $2
B $6F4F,4 Room $65 description, type $F -- one of 4 PLUG ROOMs (see #R$73B3), cube position level 3, row 4, col 4
B $6F53,12 4 decor cubes at grid corners (2,2)/(2,6)/(6,2)/(6,6), values $0B/$0C/$0A/$0B; then Plug+Whirlpool co-located at grid cell $25 -- see #R$8F4C/#R$8F1E
B $6F5F,4 Room $66 description, type $4
B $6F63,2
B $6F65,4 Room $67 description, type $8
B $6F69,4 Room $68 description, type $1
B $6F6D,4 Room $69 description, type $0
B $6F71,4 Room $6A description, type $1
B $6F75,4
B $6F79,4 Room $6B description, type $3
B $6F7D,2
B $6F7F,4 Room $6C description, type $0
N $6F83 Level 4 of 6 (room numbers $6D-$90) -- entry point 'D' lands in this level (room $84)
B $6F83,4 Room $6D description, type $8
B $6F87,4 Room $6E description, type $1
B $6F8B,4 Room $6F description, type $3
B $6F8F,9
B $6F98,4 Room $70 description, type $2
B $6F9C,4 Room $71 description, type $7
B $6FA0,4 Room $72 description, type $2
B $6FA4,2
B $6FA6,4 Room $73 description, type $0
B $6FAA,4 Room $74 description, type $6
B $6FAE,2
B $6FB0,4 Room $75 description, type $0
B $6FB4,4 Room $76 description, type $4
B $6FB8,10
B $6FC2,4 Room $77 description, type $5
B $6FC6,3
B $6FC9,4 Room $78 description, type $6
B $6FCD,4 Room $79 description, type $0
B $6FD1,4 Room $7A description, type $0
B $6FD5,4 Room $7B description, type $5
B $6FD9,4 Room $7C description, type $0
B $6FDD,16
B $6FED,4 Room $7D description, type $8
B $6FF1,4
B $6FF5,4 Room $7E description, type $3
B $6FF9,4 Room $7F description, type $7
B $6FFD,18
B $700F,4 Room $80 description, type $3
B $7013,3
B $7016,4 Room $81 description, type $8
B $701A,4 Room $82 description, type $4
B $701E,2
B $7020,4 Room $83 description, type $0
B $7024,4 Room $84 description, type $7
B $7028,4 Room $85 description, type $1
B $702C,4 Room $86 description, type $0
B $7030,4 Room $87 description, type $6
B $7034,4 Room $88 description, type $3
B $7038,2
B $703A,4 Room $89 description, type $6
B $703E,4 Room $8A description, type $3
B $7042,4 Room $8B description, type $4
B $7046,2
B $7048,4 Room $8C description, type $8
B $704C,4 Room $8D description, type $1
B $7050,4
B $7054,4 Room $8E description, type $0
B $7058,4
B $705C,4 Room $8F description, type $0
B $7060,5
B $7065,4 Room $90 description, type $2
B $7069,2
N $706B Level 5 of 6 (room numbers $91-$B4)
B $706B,4 Room $91 description, type $8
B $706F,10
B $7079,4 Room $92 description, type $0
B $707D,2
B $707F,4 Room $93 description, type $1
B $7083,8
B $708B,4 Room $94 description, type $0
B $708F,4 Room $95 description, type $1
B $7093,2
B $7095,4 Room $96 description, type $3
B $7099,4 Room $97 description, type $0
B $709D,4 Room $98 description, type $7
B $70A1,4 Room $99 description, type $8
B $70A5,8
B $70AD,4 Room $9A description, type $5
B $70B1,7
B $70B8,4 Room $9B description, type $F -- one of 4 PLUG ROOMs (see #R$73B3), cube position level 5, row 1, col 4
B $70BC,12 4 decor cubes at grid corners (2,2)/(2,6)/(6,2)/(6,6), all value $10; then Plug+Whirlpool co-located at grid cell $25 -- see #R$8F4C/#R$8F1E
B $70C8,4 Room $9C description, type $6
B $70CC,2
B $70CE,4 Room $9D description, type $1
B $70D2,6
B $70D8,4 Room $9E description, type $2
B $70DC,4
B $70E0,4 Room $9F description, type $4
B $70E4,7
B $70EB,4 Room $A0 description, type $7
B $70EF,10
B $70F9,4 Room $A1 description, type $0
B $70FD,6
B $7103,4 Room $A2 description, type $1
B $7107,6
B $710D,4 Room $A3 description, type $5
B $7111,2
B $7113,4 Room $A4 description, type $4
B $7117,20
B $712B,4 Room $A5 description, type $1
B $712F,2
B $7131,4 Room $A6 description, type $3
B $7135,6
B $713B,4 Room $A7 description, type $6
B $713F,4 Room $A8 description, type $8
B $7143,4
B $7147,4 Room $A9 description, type $5
B $714B,4 Room $AA description, type $0
B $714F,4 Room $AB description, type $1
B $7153,4 Room $AC description, type $8
B $7157,4 Room $AD description, type $4
B $715B,14
B $7169,4 Room $AE description, type $3
B $716D,3
B $7170,4 Room $AF description, type $0
B $7174,4 Room $B0 description, type $2
B $7178,4 Room $B1 description, type $2
B $717C,4 Room $B2 description, type $0
B $7180,4 Room $B3 description, type $3
B $7184,2
B $7186,4 Room $B4 description, type $1
B $718A,2
N $718C Level 6 of 6 (room numbers $B5-$D8) -- entry point 'B' lands in this level (room $C0)
B $718C,4 Room $B5 description, type $1
B $7190,12
B $719C,4 Room $B6 description, type $4
B $71A0,8
B $71A8,4 Room $B7 description, type $0
B $71AC,6
B $71B2,4 Room $B8 description, type $8
B $71B6,3
B $71B9,4 Room $B9 description, type $1
B $71BD,4 Room $BA description, type $8
B $71C1,4 Room $BB description, type $7
B $71C5,4 Room $BC description, type $8
B $71C9,4 Room $BD description, type $3
B $71CD,4 Room $BE description, type $0
B $71D1,4 Room $BF description, type $0
B $71D5,4 Room $C0 description, type $0
B $71D9,14
B $71E7,4 Room $C1 description, type $6
B $71EB,9
B $71F4,4 Room $C2 description, type $5
B $71F8,4 Room $C3 description, type $1
B $71FC,4
B $7200,4 Room $C4 description, type $6
B $7204,4 Room $C5 description, type $1
B $7208,4
B $720C,4 Room $C6 description, type $4
B $7210,10
B $721A,4 Room $C7 description, type $5
B $721E,4 Room $C8 description, type $1
B $7222,2
B $7224,4 Room $C9 description, type $8
B $7228,4 Room $CA description, type $1
B $722C,4 Room $CB description, type $5
B $7230,3
B $7233,4 Room $CC description, type $0
B $7237,3
B $723A,4 Room $CD description, type $4
B $723E,9
B $7247,4 Room $CE description, type $3
B $724B,4 Room $CF description, type $0
B $724F,4
B $7253,4 Room $D0 description, type $8
B $7257,4 Room $D1 description, type $0
B $725B,4 Room $D2 description, type $0
B $725F,4 Room $D3 description, type $8
B $7263,4 Room $D4 description, type $2
B $7267,4 Room $D5 description, type $0
B $726B,4 Room $D6 description, type $0
B $726F,4 Room $D7 description, type $8
B $7273,3
B $7276,4 Room $D8 description, type $F -- one of 4 PLUG ROOMs (see #R$73B3), cube position level 6, row 5, col 5
B $727A,12 4 decor cubes at grid corners (2,2)/(2,6)/(6,2)/(6,6), values $0F/$0E/$0E/$0F; then Plug+Whirlpool co-located at grid cell $25 -- see #R$8F4C/#R$8F1E
b $7286
N $7287 Per-level Plug Room table: 6 entries (levels 1-6), 6 bytes each. byte0 = the level's Plug Room number ($00 = none; $32/$65/$9B/$D8 for levels 2/3/5/6), byte1 = state byte (low nibble checked against $0F by #R$8F4C/#R$94F4 to suppress the plug spawn -- plug already pulled?), bytes 2-5 = purpose not yet known. Looked up by #R$62F9.
B $7287,36,6
b $72AB
b $72B1 Room-type template pointer table
N $72B1 16 words, indexed by $612A (room type 0-15, from room description byte2 bits 4-7); each points to a template block below. Types 9-14 all share the same template ($73A0).
W $72B1,32,8
b $72D1 Room-type templates
N $72D1 Each template starts with a byte0 giving the total byte count of that template block (not a pair count -- matches the gap to the next template's pointer exactly), followed by (index,value) pairs consumed by #R$62C8 to populate the room grid (see #R$612C).
N $72D1 Room type $0 (19 bytes)
B $72D1,1 byte count for this template (19)
B $72D2,18
N $72E4 Room type $1 (15 bytes)
B $72E4,1 byte count for this template (15)
B $72E5,14
N $72F3 Room type $2 (39 bytes)
B $72F3,1 byte count for this template (39)
B $72F4,38
N $731A Room type $3 (15 bytes)
B $731A,1 byte count for this template (15)
B $731B,14
N $7329 Room type $4 (21 bytes)
B $7329,1 byte count for this template (21)
B $732A,20
N $733E Room type $5 (17 bytes)
B $733E,1 byte count for this template (17)
B $733F,16
N $734F Room type $6 (19 bytes)
B $734F,1 byte count for this template (19)
B $7350,18
N $7362 Room type $7 (39 bytes)
B $7362,1 byte count for this template (39)
B $7363,38
N $7389 Room type $8 (23 bytes)
B $7389,1 byte count for this template (23)
B $738A,22
N $73A0 Room type $9..$E (19 bytes)
B $73A0,1 byte count for this template (19)
B $73A1,18
N $73B3 Room type $F (2 bytes) -- used by exactly 4 rooms in the whole table -- $32, $65, $9B, $D8 (cube positions level2/row2/col1, level3/row4/col4, level5/row1/col4, level6/row5/col5 respectively) -- all four "PLUG ROOM" (title index 8). Per the game's own instructions text (x-docs/Instructions.txt): "the gigantic planetary aquarium... is now so polluted that the only remedy is to completely empty it of water by pulling each of the four main plugs" -- these 4 rooms are the win-condition rooms: pulling all four plugs completes the game. The template itself (2 bytes: length + 1 more) is too short to hold any real (index,value) pair, consistent with Plug Rooms being a distinct, mostly-static-content-free category built around the plug-placement mechanic rather than normal terrain.
B $73B3,1 byte count for this template (2)
B $73B4,1
t $73B5 Room/creature title table
N $73B5 10 entries, 14 bytes each, terminated by $5E. Indexed by room type (see #R$72D1); printed as the message window's title line by #R$65DB and restored by #R$9808. Entries $A onward (from #R$7441) are reused as the rotating clue/joke message table printed by #R$65DB via #R$65D7.
T $73B5 "  DEATHBOWL  "
T $73C3 "   PIRANHA   "
T $73D1 "  SEAHORSE   "
T $73DF "  WOLF FISH  "
T $73ED "   ANEMONE   "
T $73FB "  SEA SLUG   "
T $7409 "   OYSTER    "
T $7417 "  JELLYFISH  "
T $7425 "  PLUG ROOM  "
T $7433 " BABY WHALE  "
t $7441 Warning-sign / clue message table
N $7441 7 entries, 20 bytes each, terminated by $FF; alias into the tail of the #R$73B5 table.
T $7441 "FEEDING PROHIBITED "
T $7455 "BATHING NOT ALLOWED"
T $7469 "DONT TAP THE GLASS "
T $747D "NOW WASH YOUR HANDS"
T $7491 "NOT DRINKING WATER "
T $74A5 "DONT BITE THE FISH "
T $74B9 " PLEASE GO QUIETLY "
b $74CE
B $750B,75
b $7556
N $7556 Per-terrain-code shape/behaviour pointer table, indexed by grid content code * 2 (code $00, unused since a $00 grid cell means "empty" and is never looked up, has a dummy entry). Read by #R$9ABC (player/object collision -- looks up the pointer, then reads further bytes for shape data) and #R$8E6E (creature/object setup, same table). 21 entries (codes $00-$14) pointing into the shape-record area starting at $7580; codes above $14 are never used as static grid content and have no entry.
W $7556,42,2
B $7580,2 Shape record for terrain code $01 (#R$7556)
B $7582,2 Shape record for terrain code $02 (#R$7556)
B $7584,2 Shape record for terrain code $03 (#R$7556)
B $7586,2 Shape record for terrain code $04 (#R$7556)
B $7588,2 Shape record for terrain code $05 (#R$7556)
B $758A,2 Shape record for terrain code $06 (#R$7556)
B $758C,2 Shape record for terrain code $07 (#R$7556)
B $758E,2 Shape record for terrain code $08 (#R$7556)
B $7590,2 Shape record for terrain code $09 (#R$7556)
B $7592,3 Shape record for terrain code $0A (#R$7556)
B $7595,3 Shape record for terrain code $0B (#R$7556)
B $7598,3 Shape record for terrain code $0C (#R$7556)
B $759B,2 Shape record for terrain code $0D (#R$7556)
B $759D,3 Shape record for terrain code $0E (#R$7556)
B $75A0,3 Shape record for terrain code $0F (#R$7556)
B $75A3,3 Shape record for terrain code $10 (#R$7556)
B $75A6,3 Shape record for terrain code $11 (#R$7556)
B $75A9,2 Shape record for terrain code $12 (#R$7556)
B $75AB,3 Shape record for terrain code $13 (#R$7556)
b $75AE
b $75B5
B $788A,4 "Empty hands" sentinel item record (room,Y,X,sprite) -- #R$6110 (currently-held item) points here when nothing is held; #R$8AFB compares against this fixed address to decide pick-up vs. drop
W $7C81,2
B $7C88,1
W $7C9A,4,4
B $7C9E
B $7CA0
W $7CAC,4,4
B $7CB0
B $7CB2
W $7CBC,4,4
B $7CC0
B $7CC2
W $7CCA,4,4
B $7CCE
B $7CD0
W $7CD8,4,4
B $7CDC
B $7CDE
W $7CE8,2 Print char routine vector (current print-engine mode; self-modified by #R$7D2D)
W $7CEA,2 Print cursor: current shadow screen print address
c $7CEC Print engine entry point
N $7CEC Prints the char/control code in A by jumping through the vector at (#R$7CE8).
R $7CEC A char to print, or a control code ($14/$16)
C $7CEC,4 save registers
C $7CF0,3 disable interrupt-driven redraw flag at #R$61A6 while printing
C $7CF5,3 get Print char routine address
C $7CF8,1 jump to current print-engine mode handler
c $7CF9 Print char routine (default mode)
N $7CF9 Prints char A as a font glyph at (#R$7CEA), or switches mode for control codes $14/$16.
R $7CF9 A char to print, or a control code ($14/$16)
C $7CF9,2 skip control codes (<$20), fall through for printable chars
C $7CFD,6 convert char code to font glyph offset (glyph = (A-$20)*8, using codes starting at font base -$20*8)
C $7D03,3 Font base address
C $7D08,6 copy 8 rows of the glyph to the shadow screen at (#R$7CEA), stepping by 32 bytes/row
C $7D15,1 next line
C $7D1A,7 advance print cursor (#R$7CEA) to the next character column
C $7D26,7 control code $14: switch mode to #R$7D32 (set inverse/highlight flag)
c $7D32 Print engine mode: set inverse video flag
N $7D32 Self-modifies the LD A at #R$7D12 to CPL/NOP for subsequent chars.
R $7D32 A flag: zero sets inverse video (CPL), non-zero sets normal video (NOP)
c $7D3F Print engine mode: dispatch control code $16
N $7D3F Control code $16 switches mode to #R$7D48 (set cursor row); else return.
R $7D3F A char to test against control code $16
c $7D48 Print engine mode: set cursor row
N $7D48 Sets print cursor row from A (row*256 + shadow screen base).
R $7D48 A cursor row
C $7D4B,3 Shadow screen address
c $7D57 Print engine mode: set cursor column
N $7D57 Sets print cursor column from A, then switches back to default char-printing mode.
R $7D57 A cursor column offset
b $7D63
W $7D63,2 Print string cursor: current shadow screen address for #R$7D68 string printer
B $7D65,1
B $7D66,2
c $7D68 Print string routine
N $7D68 Prints the string at (HL) to the shadow screen until terminator $5E; handles control codes $16 (set row+col) and $2B (newline, +8 rows).
R $7D68 HL string address (terminated by $5E)
C $7D8C,3 Shadow screen address
C $7D94
C $7D9F
C $7DB1,3 Print engine
b $7DB7
B $7DBF
c $7DC7 Print engine: plot one character glyph into the shadow-screen font buffer, then blit it
N $7DC7 Looks up the character (searched in a small table at $7DBF) as an index into a font/glyph table at $A7DC (8 bytes/char), unpacks it into a working buffer at $7DB7 (nibble-swapped if the destination column is odd -- BIT 0,C), then merges it into the shadow screen at ($7D63): if the column-parity flag $7D65 is 0, ORs the low nibble in (right half of a byte pair); if 1, uses RLD to swap in the high nibble instead (left half) -- this is how two 4px-wide half-character columns share one screen byte. Advances $7D63 by one column/row afterward. Underlies the digit/score printing (#R$854F/#R$8523) and the general text print engine (#R$7CEC).
C $7DC7,12 search the character table $7DBF, get its index
C $7DD3,8 normalize to a glyph value (subtract $30, adjust for the letter range)
C $7DDB,9 C = value, halve it for the row-pair index
C $7DE4,10 HL = font base $A7DC + index*8
C $7DEE,9 *loop: read a glyph byte, test the destination column parity (bit 0 of C)
C $7DF7,6 mask the nibble, write it to the work buffer $7DB7, advance
C $7DFD,2 loop 8 times (one glyph row per iteration)
C $7DFF,8 branch on the column-parity flag $7D65
C $7E07,9 B = 8, DE = screen row pointer $7D63, HL = work buffer
C $7E10,13 *loop: OR the low nibble into the screen byte (right half-character)
C $7E1D,3 loop 8 times
C $7E20,7 mark the parity flag done, restore HL, return
C $7E27,9 alternate path (parity flag set): B = 8, DE, HL setup
C $7E30,13 *loop: RLD the high nibble into the screen byte (left half-character)
C $7E3D,6 clear the parity flag, advance $7D63 by one row
C $7E43,9 HL = ($7D63)+1, store it, restore HL, return
b $7E4C Variables to use in routine 7E4F
W $7E4C,2
B $7E4E,1
c $7E4F Flip sprite horizontally
N $7E4F Looks up the #R$A5DC record for sprite L (L*4 -- see #R$A5DC), takes its data address (record[0..1]) and masked height (record[2]&$7F, in 8px rows) and width (record[3]&$7F, in 8px columns, toggling record[3] bit 7 in place each call so alternating calls flip between drawing the normal and mirrored image). For each of height*8 pixel rows, copies ceil(width/2) bytes from the front of the row to the back (and vice versa via HL/DE working inward from both ends), bit-reversing each byte with the RLA/RR chain at #R$7E83 -- the standard trick for mirroring a monochrome bitmap left-to-right. Used to derive a sprite's mirror-image facing from a single stored copy.
R $7E4F L Sprite number
C $7E53,3 Table of sprites address
C $7E5B,3 record[2]: height (mask off bit 7)
C $7E60,7 record[3]: width -- toggle bit 7 in place (flip-flop flag, self-modifying), then mask it off
C $7E6C,4 halve the width, rounding up
C $7E73,2 outer loop: once per 8px-row group (height)
C $7E75,1 inner loop: 8 pixel rows per group
C $7E80,1 innermost loop: ceil(width/2) byte pairs per row
C $7E83,25 Flip the byte
c $7EA9 Scan all 6 keyboard half-rows into the row-snapshot buffer at $6184 down to $617F, used by #R$7EBE's input reader
N $7EA9 Reads 6 keyboard half-row ports in sequence, starting $7FFE, port high byte advanced by E each iteration, storing each row's byte into the buffer starting at $6184 and decrementing down through $617F. E starts at $80 and is rotated right each iteration, both selecting the next port's high-byte increment and terminating the scan, Z, once it has rotated out.
C $7EA9,8 HL = the row buffer $6184, E = $80, the rotation seed, BC = the first port $7FFE
C $7EB1,6 Read the row, store it, test/rotate E
C $7EB7,1 All rows done: return
C $7EB8,6 Otherwise advance HL, add E into B, the next port's high byte, loop
c $7EBE Read input: normalize the active control method into the 5-bit mask at #R$6186
N $7EBE Dispatches on the device selector $617B: keyboard (scans 6 half-rows into $6186's bits, some duplicated -- e.g. both $617D and $6184 set bit 4/fire), Kempston (port $001F, used as the mask directly), Sinclair (port $EFFE, bit-rotated into the mask), or Cursor keys (ports $EFFE/$F7FE). Result is masked against the previous frame's value at $6188 and stored to $6186; also accumulates a held-key counter at $617C. See #R$6186 for the bit layout.
C $7EBE,7 check the device selector $617B, branch away if not keyboard
C $7EC5,6 check $6185, branch to the Sinclair/Cursor path if set
C $7ECB,5 Scan all 6 keyboard half-rows into the row-snapshot buffer at $6184 down to $617F, used by #R$7EBE's input reader
C $7ED0,11 test keyboard row $6182, set bit 3 (Up) if pressed
C $7EDB,11 test keyboard row $617E, set bit 2 (Down) if pressed
C $7EE6,11 test keyboard row $6183, set bit 0 (Right) if pressed
C $7EF1,11 test keyboard row $617F, set bit 1 (Left) if pressed
C $7EFC,11 test keyboard row $617D, set bit 4 (Fire) if pressed
C $7F07,11 test keyboard row $6184, set bit 4 (Fire) if pressed
C $7F12,2 *shared exit: B = the resolved mask
C $7F14,4 mask against the previous frame's value ($6188)
C $7F1B,5 update $6188 to the raw new mask
C $7F20,8 accumulate the held-key counter $617C
C $7F28,11 Kempston (device 1): read port $001F directly as the mask
C $7F33,17 Sinclair (device 2): read port $EFFE, complement, test bit 0, set bit 4 (Fire) if pressed
C $7F44,10 test bit 1, set bit 3 (Up) if pressed
C $7F4E,10 test bits 2/3/4, set bits 2/0/1 (Down/Right/Left) if pressed
C $7F5A,11 Cursor keys: read ports $EFFE and $F7FE, complement
C $7F65,6 test the fire key, set bit 1 of A if pressed
C $7F6B,7 B = 0, test bit 0, set bit 4 (Fire) if pressed
C $7F72,5 test bit 1, set bit 1 (Left) if pressed
C $7F77,5 test bit 2, set bit 0 (Right) if pressed
C $7F7C,5 test bit 3, set bit 3 (Up) if pressed
C $7F81,9 test bit 4, set bit 2 (Down) if pressed
C $7F8A,4 device 0 fallback: store A directly as the mask, return
C $7F18,3 set Resolved input mask
C $7F8A,3 set Resolved input mask
c $7F8E Reset the redraw bounding-box trackers ($6194-$6197) to empty
N $7F8E Sets the min tracker ($6194/$6195) to $0000 and the max tracker ($6196/$6197) to $FFB9, sentinel values that any real screen rectangle will widen via #R$7F9B.
c $7F9B Fold a screen rectangle (DE = top/left, HL = bottom/right pair) into the running redraw bounding box $6194-$6197
N $7F9B Two near-identical passes: the first only lowers the min tracker at $6194/$6195, the second only raises the max tracker at $6196/$6197 -- consumed by #R$9C35's end-of-frame screen flip. Called by #R$7FCD (per-sprite) and #R$8315 (per wall/decoration piece).
C $7F9B,3 HL = $6194 (min tracker)
C $7F9E,3 BC = $024C
C $7FA1,6 *loop: compare DE-C against (HL), skip the store if not smaller
C $7FA7,6 advance DE/HL, reset C, loop (high byte then low byte)
C $7FAD,3 BC = $024C (second pass, HL continues into $6196, the max tracker)
C $7FB0,6 *loop: compare DE-C against (HL), skip the store if not greater
C $7FB6,6 advance DE/HL, reset C, loop
C $7FBC,1 return
b $7FBD
c $7FC0 Reset the sprite-draw clip window ($610A-$610D) to the full play-field
N $7FC0 Sets the clip window wide open: top/left to $4C/$00 and bottom/right to $FF/$FF, effectively disabling clipping until #R$8315 narrows it for the next piece.
C $7FC0,6 top/left = $004C/$00 (word write: $610A=$4C, $610B=$00)
C $7FC6,6 bottom/right = $FFFF (word write: $610C/$610D wide open)
c $7FCD Compute the current sprite's own screen bounding box, clamped to the play-field, and fold it into the redraw tracker
N $7FCD Gated on bit 0 of the flag byte $7FBD (skipped for sprites that shouldn't mark the screen dirty, e.g. HUD icons). Derives top/bottom from $7FBF/height and left/right from $7FBE/width (rounded to a 16px boundary), clamping every edge to the $4C play-field limit, then calls #R$7F9B to merge the box into $6194-$6197.
C $7FCD,6 test the redraw-tracking flag (bit 0 of $7FBD), return if clear
C $7FD3,9 A = sprite top ($7FBF), clamp to at least $4C (the play-field top)
C $7FDC,3 store the clamped top into $610A
C $7FDF,10 A = sprite bottom = top + height, clamp to 0 on overflow
C $7FE9,7 decrement, clamp to at least $4C
C $7FF0,3 store the clamped bottom into $610C
C $7FF3,5 HL = sprite width field, B = width * 4
C $7FF8,9 A = sprite left ($7FBE) - B, round down to a 16px boundary
C $8001,10 A = sprite left + B - 1, round up to a 16px boundary, store as the right edge
C $800B,3 DE = $610A
C $800E,3 => Fold a screen rectangle (DE = top/left, HL = bottom/right pair) into the running redraw bounding box $6194-$6197
c $8011 Sprite draw: clip the current sprite against the screen window ($610A-$610D), adjusting its data pointer and dimensions
N $8011 Compares the sprite's screen position/size (via $7FBE/$7FBF, #R$618F/#R$6190) against the clip rectangle $610A(top)/$610B(left)/$610C(bottom)/$610D(right): shrinks the effective height/width and advances the sprite data pointers (#R$618D, #R$A5D8) when the top/left edges are off-window, and just shrinks the count when the bottom/right edges are off-window. Returns with Carry set if the sprite is fully off-window (nothing to draw), NC and A=0 otherwise. Called by #R$8128 before blitting.
C $8011,10 compare sprite top ($7FBF) against clip top ($610A), skip ahead if not clipped
C $801B,14 top-clipped: shrink height by the clipped amount (fully off-window if it underflows)
C $8029,3 store the shrunk height
C $802C,8 DE = sprite width * rows-clipped (row byte count to skip)
C $8034,3 *loop: HL += DE, DJNZ (multiply row-count by width)
C $8037,15 advance the sprite data pointer and mask pointer past the clipped top rows
C $8046,26 compare sprite bottom against clip bottom ($610C), shrink height if it overhangs
C $8060,16 compare sprite left against clip left ($610B, via $7FBE), skip ahead if not clipped
C $8070,13 compute the left-clip pixel shift into $8124
C $807D,12 compare sprite right against clip right ($610D), branch away if not clipped
C $8089,11 compute the right-clip pixel shift into $8125
C $8094,2 fully visible: return NC
C $8096,4 top/left clip underflowed: return Carry (fully off-window)
C $809A,3 bottom/right clip underflowed: return Carry (fully off-window)
c $809D Sprite draw: build the per-row blit queue for the shadow screen, from the clipped sprite
N $809D Only proceeds for kind $01 (masked via $7FBD AND $7F -- the other kind uses a different path in #R$8128). Computes the shadow-screen row addresses (via a *8 multiply into a $DA10-based table, i.e. the standard row-address lookup) and column byte offset, then walks two loops (left part / right part of the queue, split at the sprite's row boundary) writing (dest_row_address, count) queue entries into the HUD/shadow blit-queue area at $5E24, one entry every 32 bytes -- consumed by #R$8107.
C $809D,8 only proceed for kind $01 (masked blit)
C $80A5,15 compute this row's shadow-screen address via *8 into the $DA10 row-address table
C $80B4,8 add the left-clip column offset
C $80BC,11 A = visible width in bytes (clip right - clip left + 1)
C $80C7,13 write the first blit-queue entry (dest address, count) at $5E24
C $80D4,12 *loop: advance dest by one screen row (32 bytes), count times
C $80E0,18 compute the second queue entry's row count from the clip-bottom/top range
C $80F2,9 write the second blit-queue entry
C $80FB,11 *loop: advance dest by one screen row, count times
c $8107 Sprite draw: execute the blit queue built by #R$809D, copying 2 planes (pixels+attributes?) per queued row
N $8107 Reads (address,count) entries from the queue at $5E24 (32 bytes apart), and for each does `count` LDI pairs from the current source into that row's destination -- the actual pixel-data copy into the shadow screen for the row-clipped sprite draw path.
C $8107,3 HL = pointer into the blit queue built by #R$809D
C $810A,2 B = 2, the loop count matching the two planes named in the title
C $810C,1 Save BC, the outer loop counter
C $810D,6 Read the destination address (E,D) and row count (A) from the queue entry, advancing HL past the 3-byte header
C $8113,3 BC = $0020, the 32-byte screen row stride
C $8116,4 Copy 2 bytes from (HL) to (DE), advancing both pointers
C $811A,3 Swap HL/DE, add the stride to advance the source pointer, swap back
C $811D,1 Decrement the row counter
C $811E,2 Loop back to $8113 while rows remain
C $8120,1 Restore BC
C $8121,2 Loop back to $810C for the second plane
b $8124
B $8126,1 Current sprite number (set by #R$8128)
B $8127,1 Current mask sprite number (set by #R$8128)
c $8128 Draw sprite C with its mask at screen position DE (mask sprite number from the table at #R$6C06; A bit 7 = mirror flag)
N $8128 Draws a sprite together with its paired mask sprite at a given screen position, optionally flipping either horizontally (via #R$7E4F) when the caller's flag byte disagrees with the sprite's own stored flip bit. Selects one of several blit paths depending on the caller's path selector (A bits, tested against $05/$03/$02/$01): a direct clipped draw via #R$8011/#R$809D, or one of the row-queue builders (#R$82F0 and friends) feeding the free-slot pool at $9D3C, later flushed by #R$8107.
R $8128 A ??
R $8128 C ??
C $8128,4 Save IX, HL, DE, BC
C $812D,3 Save the flags/kind byte A into $7FBD
C $8130,4 Save the draw position DE into $7FBE
C $8134,5 HL = the mask-sprite lookup table $6C06, BC = sprite number
C $8139,6 Look up the mask sprite number for sprite C, save both to $8126/$8127
C $813F,1 L = mask sprite number
C $8140,3 Load a sprite's #R$A5DC record into the "current sprite" scratch variables at #R$618D, ready for #R$8128 to draw it
C $8143,4 A = saved flags, test against the mask record's own flip bit
C $8147,3 If sign matches (P), skip flipping
C $814A,3 HL = mask sprite data address
C $814D,3 Flip sprite horizontally
C $8150,6 Save the mask sprite's data address into $A5D8, then load the main sprite's number
C $8156,3 HL = main sprite number
C $8159,3 Load a sprite's #R$A5DC record into the "current sprite" scratch variables at #R$618D, ready for #R$8128 to draw it
C $815C,4 A = saved flags, test against the main sprite record's own flip bit
C $8160,3 If sign matches (P), skip flipping
C $8163,3 HL = main sprite data address
C $8166,3 Flip sprite horizontally
C $8169,5 Clear the saved-flags mirror bit
C $816E,5 HL = the sprite width byte, clear its top bit too
C $8173,7 Multiply the width by 8, three left shifts, via the byte before it
C $817A,5 A = saved flags, branch on which draw path
C $817F,2 If path 2, skip straight to the offset calculation
C $8181,3 Compute the current sprite's own screen bounding box, clamped to the play-field, and fold it into the redraw tracker
C $8184,3 Sprite draw
C $8187,3 If the draw reported off-screen (Carry), abort
C $818A,3 Sprite draw
C $818D,5 HL = the record's data offset, widened to a word
C $8192,5 Multiply by 32, five left shifts, the byte offset within the sprite data
C $8197,6 A = the sprite's width in pixels, doubled twice to get its byte width, save it
C $819D,7 Subtract the byte width from the saved draw position's X, re-save it, keep a copy in B
C $81A4,6 Isolate the row bits of the adjusted X, rotate them into a row index
C $81AA,4 DE = the row index, add it to the byte-offset HL from before
C $81AE,4 Add a fixed base address $DA10, the sprite data area's start
C $81B2,5 A = saved flags again, dispatch on path to the matching blit-queue builder
C $81B7,3 Path 5 goes to $8246
C $81BA,5 Path 3 goes to $82F0
C $81BF,5 Path 2 also goes to $82F0
C $81C4,4 Path 1 continues below, anything else goes to $8246
C $81C8,1 Save the sprite data pointer HL
C $81C9,5 C = sprite height in rows, A = the byte-width remainder test value
C $81CE,4 If the byte-width remainder is zero skip the extra row, else fall through
C $81D2,1 C += 1, a partial row needs one more row of queue entries
C $81D3,4 IX = the free-slot scan pointer into table $9D3C
C $81D7,6 Test whether this slot is free, its word field is zero
C $81DD,2 If free, use this slot
C $81DF,8 Otherwise skip past this slot's row entries to the next slot header
C $81E7,2 Advance IX by the row stride, once per row
C $81E9,2 Loop for each row
C $81EB,5 Skip the 4-byte slot header, then re-test the next slot
C $81F0,2 Loop back to re-scan
C $81F2,9 Found a free slot: write the sprite data pointer and row-byte-count into its header
C $81FB,6 Write the sprite's height, row count, into the header's 4th byte
C $8201,5 Advance IX past the header to the row-entry area
C $8206,4 DE = the row-entry area's address, save HL, the sprite data pointer
C $820A,3 B = 0, clear carry for a 16-bit subtraction
C $820D,5 HL = $0020, one screen row's stride, minus the byte width
C $8212,3 Store the per-row stride into the blit-queue template at $823B
C $8215,2 C = byte width doubled, mask+sprite pair take 2 bytes per LDI
C $8217,5 HL = $823A minus the doubled width, another per-row stride variant
C $821C,3 Store into the queue template at $8224
C $821F,3 Store the same value into the queue template at $8240
C $8222,1 Restore HL, the sprite data pointer
C $8223,3 Jump into the blit-queue-building code at $8232
b $8226
c $8230 Sprite draw: masked blit (AND mask, OR sprite data) into the shadow screen -- full-width and partial-width paths
N $8230 $8230/$8232: unmasked/opaque row copy, 5 LDI's per iteration, advancing by the $1C (28) byte screen-row stride -- used when the sprite is a plain full-byte-width blit. $8246 onward: masked blit -- if the sprite's screen X is byte-aligned ($7FBE AND $07 == 0), does a straightforward per-byte `(dest AND NOT mask) OR sprite` merge loop at $8260. Otherwise ($8278-$82B7) handles a non-byte-aligned (shifted) mask/sprite pair: computes a jump offset from the sprite width into a self-modified entry point at $829C (a classic unrolled-loop/"duff's device" trick, jump target poked at $829D/$82CE) so the leftover partial column is merged with the right number of LDI's, then #R$82A6 does the AND/OR merge for the remaining full columns.
C $8230,10 unrolled 5-LDI copy of one row (opaque blit)
C $823A,8 advance by the row stride ($1C), loop A times
C $8242,4 terminate the row with two zero bytes, restore HL
C $8246,8 test the sprite's screen-X alignment (bits 0-2 of $7FBE), branch
C $824E,18 byte-aligned masked path: BC/DE/IX setup, compute the loop trip counts
C $8260,1 *outer row loop: push BC
C $8261,13 *inner loop: AND the mask, OR the sprite byte, store, advance, DJNZ
C $826E,7 advance HL by the row stride, loop the outer count (C) times
C $8275,3 jump to the shared exit $830E
C $8278,29 non-aligned path: compute a self-modified jump offset from the sprite width (duff's-device setup)
C $8295,7 *shared entry (also used by #R$82A6): push AF, B = height, C = $FF
b $829E
c $82A6 Non-aligned sprite blit: copy the nibble-merged buffer (built by #R$82DB) to the destination, row by row
N $82A6 Copies the nibble-merged row buffer, built by #R$82DB via a 4-LDI unrolled copy, to the destination, terminating each row with a zero byte, looping row-width (C) times per row and row-count (A, from height) times overall, advancing the mask-data pointer $A5D8 between rows. On the last row, falls into the setup for the next sprite's nibble-merge pass at #R$82DB.
C $82A6,8 unrolled 4-LDI copy from the merge buffer to the destination
C $82AE,3 terminate the row (write a zero byte), advance DE
C $82B1,3 loop C times (row width), then restore AF, decrement the row count
C $82B4,3 test for the last row
C $82B7,9 advance the mask-data pointer $A5D8 by DE, loop back to #R$8295
C $82C0,7 last row done: advance the sprite width field, HL = sprite data pointer
C $82C7,6 B = height*2, A = 0 (setup for the nibble-merge pass at #R$82DB)
C $82CD,2 self-modified jump target (part of the duff's-device trick)
b $82CF
c $82DB Sprite draw: RRD nibble-shift tail for 5 planes, non-byte-aligned blit variant
N $82DB Continuation of the nibble-merge pass, falls in from #R$82CD's self-modified jump: RRD-shifts 5 consecutive bytes to merge sprite/mask nibbles into the row buffer, one INC HL between each, then loops via #R$82CD for the next row before popping HL and returning to the shared dispatch at #R$824E.
C $82DB,15 RRD-shift 5 bytes to merge sprite/mask nibbles, advancing HL between each
C $82EA,2 Loop for the next row
C $82EC,4 Restore HL, return to the shared dispatch
c $82F0 Sprite draw: full-width unmasked row copy (no mask needed, direct LDIR per row)
N $82F0 Copies BC rows, from $618F's height/width, of C bytes via LDIR from the sprite data ($618D) to the shadow screen, advancing the destination by the fixed $20 row stride between rows. Shares its exit path with #R$8230's masked blit.
C $82F0,8 BC = sprite height/width, DE = sprite data address
C $82F8,4 A = row count, swap B/C, B = 0
C $82FC,2 *loop: save BC/HL
C $82FE,4 swap HL/DE (source vs dest), copy the row via LDIR, swap back
C $8302,5 restore HL, advance by the row stride ($20), restore BC
C $8307,4 loop A times
C $830B,3 jump to the shared exit
C $830E,1 shared exit: A = 0
C $830F,5 restore all registers, return
c $8315 Draw a wall/decoration piece
N $8315 Sets up the sprite-draw clip window ($610A-$610D) for the piece, then draws it and updates the redraw bounding box.
N $8315 Reads a (index,height/width) record from (HL), converts the index to a screen row/column via a *8 lookup into $1C70 to get the clip window's top/left ($610A/$610B), derives bottom/right ($610D/$610C) from the record's height/width fields, then draws the piece with a self-modified LDIR row-copy and finishes by calling #R$7F9B to fold the drawn area into a running screen-bounding-box (min/max) used for redraw invalidation.
C $8315,4 DE = record word from (HL), advance HL past it, save HL
C $8319,8 HL = $1C70 + DE, *8 (screen row-address lookup)
C $8321,12 store the computed top/left ($610A/$610B), keep copies in B/C
C $832D,10 restore HL, compute the clip bottom ($610D) from the height field
C $8337,10 compute the self-modified LDIR row width, save the source byte and count
C $8341,7 compute the clip right ($610C) from the width field
C $8348,4 B = 0, read the source count/pointer
C $834C,9 *loop: LDIR one row (self-modified count), advance dest by the row stride
C $8355,3 loop A times
C $8358,3 DE = $610A, fold the drawn area into the redraw bounding box via #R$7F9B
C $835B,3 => Fold a screen rectangle (DE = top/left, HL = bottom/right pair) into the running redraw bounding box $6194-$6197
c $835E Flush the queued redraw requests at $9D3C: draw each piece via #R$8315, then clear the queue
N $835E Resets the bounding-box trackers $6194/$6196 (see #R$7F8E/#R$7F9B), then walks the request list at $9D3C: each entry is a (marker-word, count, stride) triple; a zero marker word ends the list. For each entry, advances a pointer by the stride, count times (computing where the next entry starts), and counts entries in C. Once the list is exhausted, replays each counted piece by walking back through it and calling #R$8315 to draw it, then clears the queue head.
C $835E,6 reset the bounding-box min tracker $6194
C $8364,6 reset the bounding-box max tracker $6196
C $836A,5 HL = redraw-request list $9D3C, C = 0 (entry count)
C $836F,5 *loop: test the node's marker word, exit if zero (list end)
C $8374,8 save the node pointer, read its count (B) and stride (E)
C $837C,3 *inner loop: advance HL by the stride, B times
C $837F,3 count this entry, loop to the next node
C $8382,4 A = entry count, test for zero
C $8386,3 restore the node pointer (adjusted back by one), save the count
C $8389,3 draw this piece via #R$8315
C $838C,4 loop count times
C $8390,7 clear the queue head, return
C $8389,3 Draw a wall/decoration piece
b $8397
c $8445 Per-frame sound-effect player: step the currently-playing effect's tone commands
N $8445 Reads the current effect ID from $61A3 (1-based; 0 = none playing), indexes a pointer table at $842F, then walks a list of command words via IX, extracting a 2-bit pitch/octave selector from each and calling the ROM tone routine at $03B6. On reaching a zero terminator word, clears $61A3 and immediately checks for a newly-queued effect (loops back to re-test).
C $8445,5 check the sound-enable flag $61A0, return if off
C $844A,5 check the currently-playing effect ID $61A3, return if none
C $844F,12 index the sound-effect pointer table $842F by (id-1)*2
C $845B,4 IX = the effect's command-word data
C $845F,10 *loop: read the next command word, done if zero (table end)
C $8469,11 bit-shuffle the word into a 2-bit octave/pitch selector
C $8474,4 mask to 0-3, add 1, E = result
C $8478,7 call the ROM tone routine ($03B6) with the pitch/duration
C $847F,8 advance IX to the next command word, loop back
C $8487,7 table exhausted: clear the current-effect ID, check for a newly-queued effect
c $848E Request sound effect A (queued at $61A2, gated by the $61A0/$61A1 flags)
N $848E $61A0 nonzero forces an immediate switch (overwrites $61A3 directly, interrupting whatever's playing); otherwise, if $61A1 is set, the effect is queued at $61A2/$61A3=$FF (consumer not in this routine); if $61A1 is clear, the request is dropped. Exact meaning of $61A0/$61A1 not confirmed.
C $848E,3 save BC/HL, B = requested effect ID
C $8491,6 test $61A0, branch away (force-switch) if busy
C $8497,6 test $61A1 (queue-enable), return without queuing if clear
C $849D,7 write the effect ID to $61A2 and a pending marker ($FF) to $61A3
C $84A4,3 restore HL/BC, return
C $84A7,4 force-switch path: write the effect ID directly to $61A3
c $84AE Dynamic object allocator
C $84AE,6 test $618C, branch to the success path if allocation is enabled
C $84B4,4 early-exit: pop the return address, skip the 2 embedded bytes, resume there
C $84B8,6 pop the next free record off the free list
C $84BE,4 update the free-list head
C $84C2,9 copy 2 bytes from the caller's template pointer (IX) into the freed slot, to keep the free list intact
C $84CB,6 switch IX to the new record's address
C $84D1,3 HL = the new record's address
C $84D4,3 DE = HL + 2 (destination for the room-number field)
C $84D7,5 store the current room number at record offset +2
C $84DC,5 pop the return address, LDI the 2 embedded handler-address bytes into the record
C $84E1,1 push the advanced return address back
C $84E2,8 copy the fixed 19-byte default state block from $5C92
C $84EA,2 set the flag bit, return
N $84AE Allocates one entry from a free-list of object records (creatures, bubble sources, snakes, whirlpools, plugs -- anything not baked into the static room grid; see #R$612C). Every caller has 2 embedded bytes immediately after its CALL instruction, holding the little-endian address of that call site's per-object behaviour handler (marked with a W-line at each site, e.g. #R$666C). On the early-exit path ($618C is 0): pops the return address and skips exactly those 2 bytes (INC HL twice, then JP (HL)) -- no object is allocated, and the handler address is discarded unread. On the success path: pops the SAME return address into HL, then LDIs those same 2 bytes as literal data into the new record's offset $03/$04 (the handler-pointer field), pushes the now-advanced HL (pointing just past the 2 bytes) back onto the stack, copies a fixed 19-byte block from $5C92 (ZX system-variable area, reused as a default object state template) into the rest of the record, then RETs -- popping that pushed address, so execution resumes 2 bytes past the CALL either way. The 2 bytes are never executed as code on either path. Allocation + list insertion: pops the next free record off the free-list head at $618B (each free record's first 2 bytes point to the next free record; the free list can extend outside the #R$A900 pool, e.g. into scratch at $5B00). Then head-inserts the new record into the active object list at the insertion point given by IX: copies the old head word from (IX+0/1) into the new record's +0/+1 link field, then writes the new record's address back to (IX+0/1). IX is usually #R$610E (the global list head), but can be any record's own link field (e.g. $8DEF for creatures -- see #R$6663), which splices the object into the middle of the list instead. Switches IX to the new record's address, stores the current room number ($6126) at record offset $02. Sets a flag bit (A=1) and returns with IX = the new record's address. Object pool starts at #R$A900.
C $84D7,3 get room number
c $84ED Load a sprite's #R$A5DC record into the "current sprite" scratch variables at #R$618D, ready for #R$8128 to draw it
N $84ED Looks up the #R$A5DC record for sprite L (L*4), then copies all 4 raw bytes (data address, height, and width -- the width byte copied unmasked, flip-flop bit 7 and all) into #R$618D/#R$618F/#R$6190. Called by #R$8128 before it draws a sprite by number.
R $84ED L Sprite number
C $84F1,3 sprite table base (#R$A5DC)
C $84F5,3 destination: current-sprite scratch variables (#R$618D)
C $84F8,6 copy data address (2 bytes) and height (1 byte)
C $84FE,3 copy width byte as-is (unmasked, includes the flip-flop flag bit)
c $8501 Print string at HL until terminator byte $5E or $2B
N $8501 Loops over bytes at HL, printing each one via #R$7CEC (the print engine, which also interprets embedded control codes like $14/$16 seen at #R$8623/#R$861A), until it reads a terminator byte ($5E or $2B) -- returns with HL pointing just past the terminator. Called directly with HL already pointing at a string (e.g. from #R$8513), and via #R$850E for inline strings embedded right after a CALL.
R $8501 HL Address of the string to print (bytes are printed one at a time via #R$7CEC; the string ends at the first $5E or $2B byte, which is consumed but not printed)
C $8503,2 terminator check: $5E
C $8506,2 terminator check: $2B
C $8509,3 Print engine entry point
c $850E Print an inline string embedded right after the caller's CALL instruction
N $850E Pops the return address off the stack into HL -- since the caller used CALL $850E, this is the address of the string bytes immediately following that CALL. Calls #R$8501 to print the string (advancing HL past it), then JP (HL) to resume execution right after the embedded string, i.e. normal code flow continues past the inline text.
C $850F,3 Print string at HL until terminator byte $5E or $2B
C $8512,1 resume execution after the inline string
c $8513 Print a message-window string
N $8513 Fixed prefix from $65CF, then an inline colour/control byte stored to $618A, then the caller's own inline string.
C $8516,3 Print string routine
C $851F,3 Print string routine
c $8523 Print a BCD number
N $8523 B bytes from (HL), two digits per byte, leading zeros as spaces; DE = per-digit print routine (self-modifies #R$854C's JP).
C $8523,4 Set the per-digit print routine, self-modify #R$854C's JP target
C $8527,2 C = $20, the "space" blank-digit code
C $8529,5 A = 0, E = the next BCD byte, RLD-rotate its high nibble into A
C $852E,4 If the high nibble is 0, keep the space code, else C = $30, the digit code base
C $8532,1 A = the printable digit code
C $8533,3 Print one digit
C $8536,2 Write the rotated byte back, decrement the digit-pair counter B
C $8538,4 If not the last pair, force C back to the digit code base $30
C $853C,4 A = the low nibble, test it
C $8540,4 If nonzero, force C to the digit code base $30
C $8544,1 A = the printable digit code
C $8545,3 Print one digit
C $8548,3 Advance HL, loop for the next byte pair
c $854C Print one digit (JP target self-modified by #R$8523)
C $854C,3 => Print engine entry point
c $854F Print BCD byte A as two digits, high digit blanked to a space if zero
N $854F Rotates A's high nibble down, prints it via #R$7CEC as a digit, or a space ($F0 sentinel) if it's zero, then prints the low nibble as a digit unconditionally.
C $855C,3 Print engine entry point
C $8564,3 => Print engine entry point
b $8567 Entry-point room number table (menu keys A/B/C/D)
N $8567 4 bytes, one per starting location, in order A/B/C/D: $52 (level 3, row 1, col 4), $C0 (level 6, row 2, col 0), $1A (level 1, row 4, col 2), $84 (level 4, row 4, col 0). See x-docs/Room-Format.md for the full cube-position table and cross-check against an external game map.
B $8567,4
t $856B Controls sub-menu text
N $856B "1 KEYBOARD 2 KEMPSTON 3 SINCLAIR 4 CURSOR", printed by #R$8617 via the #R$7CEC print engine.
c $8596 System/interrupt setup before the main menu
N $8596 Sets IY from $61A4, a fixed system variables area, enables IM 1 interrupts, and clears a flag byte at $FBAA before falling into #R$85A1's main menu loop.
c $85A1 Main menu screen: title, entry list A-D, controls menu; loops until a selection starts the game
N $85A1 Prints the title, the CONTROLS heading, and the 4 level entries (A-D, Elvis song titles). Each frame, redraws the Controls sub-list with the currently-selected control method (from $6185) shown inverse, and the music/SFX toggle labels reflecting $61A0/$61A1. Waits, via #R$FB90, for a key selecting a level or toggling an option, looping until a level is chosen.
C $85A1,3 Print an inline string embedded right after the caller's CALL instruction
T $85A4,15 main menu title
T $85B3,12 sub-heading
T $85BF,21 key A entry name
T $85D4,20 key B entry name
T $85E8,17 key C entry name
T $85F9,22 key D entry name (Elvis song titles)
C $8617,3 load pointer to Controls menu text at #R$856B
C $861A,5 control code $16: set print cursor row (selects the menu row to print into)
C $8620,3 Print engine entry point
C $8623,5 control code $14 + flag: set/clear inverse video for the currently selected control method
C $862F,3 Print engine entry point
C $8634,3 Print engine entry point
C $8637,3 Print string at HL until terminator byte $5E or $2B
C $863A,6 control code $14 + $01: restore inverse video flag to normal
C $8640,3 Print engine entry point
C $864E,3 Print an inline string embedded right after the caller's CALL instruction
T $8651,6 stray "5" (control-code list index? unclear)
C $865D,3 Print an inline string embedded right after the caller's CALL instruction
T $8660,14 "MUSIC" label, shown selected/inverse
C $8670,3 Print an inline string embedded right after the caller's CALL instruction
T $8673,14 "SFX" label, shown selected/inverse
C $8681,3 End-of-frame screen flip
C $868D,3 Menu tune + key-wait driver
C $86A7,3 => Main menu screen
C $86B1,3 => Main menu screen
C $86C1,3 load pointer to entry-point room number table (#R$8567) -- used to look up the starting room for the pressed menu key A/B/C/D
C $86C6,3 set entry-point room number
c $86CC Draw the end-game stats screen
N $86CC Prints the "DEATHBOWL DIVINED" title and the stat labels (Score Scraped, Plugs Pulled, Goodies Gathered, Gnomes Gnabbed), then the elapsed play-time from $6121/$6120 as BCD minutes:seconds (leading zero blanked) via #R$7CEC, followed by the score and the other end-game counters (#R$6122-#R$6124).
C $86CC,3 Print an inline string embedded right after the caller's CALL instruction
N $86CF End-game stats overlay labels (see #R$676D: called only when room==1)
T $86CF,22 title
T $86E5,16 stat label
T $86F5,15 stat label
T $8704,19 stat label
T $8717,17 stat label
T $8728,4 cursor position only, no visible text
C $873D,3 Print engine entry point
C $8748,3 Print engine entry point
C $8755,3 Print engine entry point
C $875A,3 Print engine entry point
C $8762,3 Print engine entry point
C $8767,3 Print engine entry point
C $876A,3 Print an inline string embedded right after the caller's CALL instruction
T $876D,4 cursor position only, no visible text (positions for a stat value printed separately)
C $8779,3 Print a BCD number
C $877C,3 Print an inline string embedded right after the caller's CALL instruction
T $877F,4 cursor position only, no visible text
C $8783,3 get "Plugs Pulled" end-game stat counter
C $8786,3 Print BCD byte A as two digits, high digit blanked to a space if zero
C $8789,3 Print an inline string embedded right after the caller's CALL instruction
T $878C,4 cursor position only, no visible text
C $8790,3 get "Goodies Gathered" end-game stat counter
C $8793,3 Print BCD byte A as two digits, high digit blanked to a space if zero
C $8796,3 Print an inline string embedded right after the caller's CALL instruction
T $8799,4 cursor position only, no visible text
C $879D,3 get "Gnomes Gnabbed" end-game stat counter
C $87A0,3 Print BCD byte A as two digits, high digit blanked to a space if zero
C $87A9,3 get "Plugs Pulled" end-game stat counter
C $87B0,3 Print an inline string embedded right after the caller's CALL instruction
N $87B3 End-game message, shown on an early/partial completion outcome
T $87B3,30 line 1
T $87D1,21 line 2
T $87E6,22 line 3
C $87FD,3 Print an inline string embedded right after the caller's CALL instruction
N $8800 End-game message, shown on full completion (all 4 plugs pulled)
T $8800,25 line 1
T $8819,24 line 2
T $8831,20 line 3
T $8845,20 line 4
c $885A Redraw the score display on HUD (last 4 BCD digits of #R$611B via #R$8523)
N $885A Sets the print cursor and inverse-video controls, then prints 4 bytes (8 BCD digits) from $611C via #R$8523, using #R$7CEC as the per-digit print routine, skipping the top digit at $611B.
C $885C,3 Print engine entry point
C $8861,3 Print engine entry point
C $8866,3 Print engine entry point
C $8871,3 => Print a BCD number
s $8874
c $8879 Add a 5-digit BCD value at #R$8874 to the score (#R$611B)
N $8879 Saves the bonus value (HL) to scratch $8874, then adds it byte-by-byte, 5 bytes BCD via DAA, to the score at $611B-$611F, working from the low byte (DE=$611F) upward while HL walks the bonus bytes forward.
C $8879,3 Save the bonus value to scratch $8874
C $887C,8 HL = the bonus bytes, DE = the score's low byte, B = 5
C $8885,8 Add corresponding bytes in BCD, carry propagates, loop
c $888E Add a bonus (HL, 5-digit BCD) to the score, then redraw the score display
C $888E,3 Add a 5-digit BCD value at #R$8874 to the score
C $8891,3 => Redraw the score display on HUD
c $8894 Subtract a BCD value from the score
N $8894 Subtracts a 5-digit BCD value at #R$8874 from the score (#R$611B); if the score can't cover it, resets $611B-$611F from a fixed 5-byte block at $5C92 instead.
N $8894 Whether the $5C92 fallback is a genuine "reset score" or coincidentally reuses the same default-state bytes seen elsewhere (see #R$A900) is unconfirmed.
C $88A8,3 => Redraw the score display on HUD
C $88B6,3 => Redraw the score display on HUD
c $88B9 Read the next value from a small circular queue, head pointer at IY+0/1, wrap pointer at IY+2/3, advancing the head
N $88B9 HL = the head pointer stored at IY+0/1; if the value there is null (0), wraps to the alternate start pointer at IY+2/3 instead. Advances and stores the new head pointer (HL+2) back to IY+0/1, then returns the read value in DE.
C $88B9,6 HL = the head pointer (IY+0/1)
C $88BF,4 Read the entry there (E,D), advancing HL past it
C $88C3,4 If the value is nonzero, use it
C $88C7,6 Otherwise wrap: HL = the alternate start pointer (IY+2/3)
C $88CD,2 Retry the read from there
C $88CF,6 Store the advanced HL back as the new head pointer (IY+0/1)
C $88D5,2 DE = the value read, return
c $88D7 Add a bonus to the score, value from a circular queue via #R$88B9
C $88D7,3 Read the next value from a small circular queue, head pointer at IY+0/1, wrap pointer at IY+2/3, advancing the head
C $88DA,3 => Add a bonus (HL, 5-digit BCD) to the score, then redraw the score display
C $88D7,3 Read the next value from a small circular queue, head pointer at IY+0/1, wrap pointer at IY+2/3, advancing the head
C $88DA,3 => Add a bonus (HL, 5-digit BCD) to the score, then redraw the score display
c $88DD Subtract a BCD value from the score, value from a circular queue via #R$88B9
C $88DD,3 Read the next value from a small circular queue, head pointer at IY+0/1, wrap pointer at IY+2/3, advancing the head
C $88E0,3 => Subtract a BCD value from the score
C $88DD,3 Read the next value from a small circular queue, head pointer at IY+0/1, wrap pointer at IY+2/3, advancing the head
C $88E0,3 => Subtract a BCD value from the score
c $88E3 Search the buffer at $7C83 for byte A (CPIR, length from $7C88)
N $88E3 Searches the weapon lookup table at $7C83, length from $7C88, for byte A via CPIR; Z indicates found. Used by #R$8B2B's pickup logic to recognize weapon items.
b $88EF
B $88EF,1
N $88F0 Input-mask -> direction-code priority table, scanned by #R$8968: (mask,direction) byte pairs, tried in order, first whose mask bits overlap ($6186's mask OR $80) wins. $08,$01 (Up bit -> direction $01); $04,$02 (Down bit -> $02); $02,$06 (Left bit -> $06); $01,$04 (Right bit -> $04); $80,$00 (default/no-input catch-all -- mask bit 7 always matches since #R$8968 ORs $80 into the scan key -- resolves to direction $00, i.e. no movement).
B $88F0,10,2
c $8968 PLAYER per-frame behaviour handler
N $8968 This is the handler address held in the player object record's +3/+4 field ($8DB9 -- see #R$8DB6), called every frame from #R$983C's dispatcher like any other object handler. Explains its many special cases: room $01 check (ending room), the vertical room transitions (#R$8A87), etc. The player's handler pointer is swappable for state changes: #R$955A tests ($8DB9)==$8968 ("normal state?"), #R$9564 swaps in #R$8D11.
N $8968 MOVEMENT: reads the input mask at #R$6186 (OR $80, a wildcard sentinel), then scans the (mask,direction) pair table at #R$88F0 for the first entry whose mask overlaps -- this resolves the raw multi-button input into a single prioritized direction code (0/1=Up, 2/3=Down, 4/5=Right, 6/7=Left; the low bit distinguishes sub-states, masked off by #R$8ABB's AND $0E). If the resolved direction equals the player's current facing ((IX+$0B)), calls #R$8AD9 immediately to take a step; if it differs and is nonzero, just updates the pending-direction latch at $8DC1 (turning takes one frame before the first step); if it resolves to 0 (no input), no movement happens this frame.
C $8977,3 Read input
C $8987,3 get room number
C $898E,3 get Entry-point room number choosen selecting A/B/C/D in menu
C $899B,3 Player dive-depth step
C $899E,3 Fire/pick-up button handler
C $89A1,3 get Resolved input mask
C $89A4,2 set bit 7 as a wildcard sentinel, for the #R$88F0 priority-table scan (matches its default/no-input entry)
C $89C6,3 Take one walk step
C $89D3,3 => Dynamic object finalizer
C $89EB,3 Request sound effect A
C $89F2,3 Subtract a BCD value from the score, value from a circular queue via #R$88B9
C $89F5,3 Print a message-window string
B $89F8,1 attribute/control byte for #R$8513's inline string
T $89F9,14 message text, terminated by $5E
C $8A0B,3 Save continuation
C $8A11,3 Sprite-animation stepper
C $8A28,3 Save continuation
C $8A2E,3 Sprite-animation stepper
C $8A36,3 Save continuation
C $8A3C,3 Sprite-animation stepper
C $8A3F,3 Read input
C $8A42,3 get Resolved input mask
C $8A45,2 test for ANY key pressed (bits 0-4)
C $8A51,3 set player behaviour-handler pointer
C $8A6B,3 Snap the object's position (IX+5/+6) to its grid-cell centre, then finalize via #R$9A60
C $8A76,3 get room number
c $8A87 Attempt to move to an adjacent room (vertical, via whirlpool/bubble)
N $8A87 Computes the room number one level down ($6126 - $24, i.e. -36 -- a whirlpool) or one level up ($6126 + $24, i.e. +36 -- a bubble), the 6x6x6 cube level-stride (see x-docs/Room-Format.md). Has special-case handling when the current room number is exactly 1 (down) or 2 (up) -- overrides the computed value instead of using the generic +-36 arithmetic; not yet understood why. The upward case also bounds-checks the result against $D9 before allowing it (JP C,#R$97FC), falling back to a different path (through $8C83) if out of range. #R$97FC is called with the new room number to actually perform the transition, same as the horizontal case (#R$67F1).
C $8A7D,2 change room number: -36 (one level DOWN, via whirlpool)
C $8A7F,3 => Change current room to A = new room number
C $8A82,2 room==1 special case: force A=2 instead
C $8A84,3 => Change current room to A = new room number
C $8A97,3 get room number
C $8A9E,2 change room number: +36 (one level UP, via bubble)
C $8AA0,2 bounds check: is the new room number in range?
C $8AA2,3 => Change current room to A = new room number
C $8AA5,8 out of range: fall back instead of changing room
C $8AAD,3 room==2 special case: use $6125 instead
C $8AB0,3 => Change current room to A = new room number
b $8AB3 Direction -> screen position delta table, indexed by (facing_code AND $0E): 4 (dx,dy) pairs -- Up=(-2,0), Down=(+2,0), Right=(0,+2), Left=(0,-2). Read by #R$8ABB.
c $8ABB Apply the object's facing direction to its position (IX+5/+6), returning the OLD position in BC
N $8ABB Looks up (IX+$0B) AND $0E in the delta table at #R$8AB3 and adds it to the object's position (+5/+6) in place. Screen deltas are +-2px along one axis per direction (Up/Down move dx, Right/Left move dy) -- the isometric-diamond room layout means each cardinal game direction is a diagonal-looking step on screen along a single axis. Used by #R$8AD9 (player movement) and #R$9923.
C $8ABB,3 HL = the facing-delta table $8AB3 (entry #R$8ABE skips this, letting the caller supply a different table)
C $8ABE,3 A = the object's facing (IX+$0B)
C $8AC1,5 Index = facing AND $0E, widened to a word in DE
C $8AC6,1 HL = this direction's delta-table entry
C $8AC7,5 A = the object's X (IX+5), save it in B, add the delta's dx
C $8ACC,4 Store the updated X back (IX+5), advance to the delta's dy byte
C $8AD0,5 A = the object's Y (IX+6), save it in C, add the delta's dy
C $8AD5,4 Store the updated Y back (IX+6) and return
c $8AD9 Take one walk step
N $8AD9 Applies the facing delta, then checks for a room-edge/door transition and a collision, reverting the position if blocked.
N $8AD9 CALLs #R$8ABB to move (IX+5/+6) by the facing delta (old position saved in BC), then #R$67F1 (door/room-transition check) and #R$9BF0 (grid + object collision check). If #R$9BF0 reports no collision (NC), the new position is kept as-is. If it reports a collision (C): if also Z, pokes $FF into offset +9 of the colliding object's record (DE, from #R$9BF0/#R$9ABC) -- disables it; either way, the position is then reverted to the saved BC (blocked), and the animation countdown (+0x0E) is reset.
C $8AD9,3 Apply the object's facing direction to its position (IX+5/+6), returning the OLD position in BC
C $8ADD,3 Attempt to move to an adjacent room (horizontal, via a door) in the direction given by
C $8AE0,3 Collision test
c $8AFB Fire/pick-up button handler: attack with the held weapon, or pick up/drop an item
N $8AFB Gated on the fire/pick-up key (bit 4 of #R$6186); if a weapon is currently held ($619E), jumps to #R$8D8D (attack) instead. Otherwise plays a "reach out" animation, then continues at $8B2B: if the held-item pointer #R$6110 currently equals the fixed "empty hands" sentinel record at $788A (i.e. nothing held), attempts to PICK UP something nearby; otherwise DROPS the currently-held item.
N $8AFB PICK UP ($8B2B, nothing currently held): walks nearby objects via #R$9B5D (proximity/collision helper, same one used by movement collision), skipping any whose kind byte (offset +8 from the found record) is $44 (the shared "vulnerable creature" pose -- not pickupable). For the first valid candidate: if its kind is $6E, calls #R$6622 (unidentified -- likely a special pickup, e.g. a key or weapon-specific item); if its kind is $36, treats it as a GNOME -- calls #R$888E, increments the "Gnomes Gnabbed" counter at $6122 (BCD), then plays sound effect $04 and finalizes via #R$9A60 (the gnome object is consumed). For any other kind, searches a weapon lookup buffer at $7C83 (via #R$88E3) -- if found, sets the Weapon-held flag $619E (and possibly a variant at $619F depending on a $3C check) instead of picking the object straight up; either way, the found record's pointer is stored into #R$6110 (now "held") and #R$6895 is called (equip/HUD update?), then sound effect $04 plays.
N $8AFB DROP ($8BC4, something currently held): writes the CURRENT ROOM into the held item's table record (byte0), restoring it to the world -- the same field that item-table entries have their room zeroed on pickup (see Room-Format.md). Re-derives the item's stored Y/X (record bytes 1/2) from the player's own position ($8DBB/$8DBC, grid-aligned) -- i.e. the item is dropped at the player's feet. Exact bit-packing of the combined Y/X byte not fully resolved.
C $8B01,3 get Weapon-held flag
C $8B05,3 => Attack
C $8B0C,3 Save continuation
C $8B25,3 set player behaviour-handler pointer
C $8B3F,3 Dynamic object finalizer
C $8B61,3 Add a bonus to the score, value from a circular queue via #R$88B9
C $8B7F,3 Use an oil can
C $8B8B,3 Add a bonus (HL, 5-digit BCD) to the score, then redraw the score display
C $8B8E,3 get "Gnomes Gnabbed" end-game stat counter
C $8B94,3 set "Gnomes Gnabbed" end-game stat counter
C $8B9A,3 Search the buffer at $7C83 for byte A
C $8BAA,3 set Weapon-held flag
C $8BB1,3 Draw the currently-held item's icon, and its ammo count if it's a weapon, on HUD
C $8BB6,3 Request sound effect A
C $8BC1,3 => Dynamic object finalizer
C $8BC7,3 get room number
C $8BE9,3 Spawn the room's creature
C $8BEC,3 Collision test
C $8BF1,3 get room number
C $8BF4,3 Count item-table entries whose room byte matches A
C $8C02,3 Draw the currently-held item's icon, and its ammo count if it's a weapon, on HUD
C $8C07,3 Request sound effect A
C $8C0C,3 => Dynamic object finalizer
C $8C0F,3 Weapon hit-response text
C $8C15,3 Print a message-window string
B $8C18,1 attribute/control byte for #R$8513's inline string
T $8C19,14 message text, terminated by $5E
C $8C32,3 => Dynamic object finalizer
c $8C35 Weapon hit-response text: print "BLOCKED" via #R$8513, then return
N $8C35 Prints a fixed "BLOCKED" message via #R$8513, then returns. $8513 never falls through to the next instruction, it jumps past its own inline string data via a computed address, so the bytes immediately following this CALL are the message's attribute/text/terminator, not code (previously misread as a Z/NZ dispatch into $8C3A/$8C3C/$8C45; those were artifacts of disassembling string bytes as instructions).
C $8C35,3 Print a message-window string
B $8C38,1 attribute/control byte for #R$8513's inline string
T $8C39,14 message text "BLOCKED", terminated by $5E
b $8C48
t $8CD9
b $8CDC
c $8CDF Player dive-depth step
N $8CDF Decrements the global depth counter $8DBD, capped at $28, testing collision each step, clearing the ledge/climb flags (IX+0x0D bits 0/1) on success.
C $8CDF,5 HL = the global depth counter $8DBD, A = $28, the cap
C $8CE4,2 If already at or past the cap, return
C $8CE6,1 Decrement the depth counter
C $8CE7,3 Collision test
C $8CEA,1 If successful, no collision, return with the new depth
C $8CEB,8 Blocked: clear the ledge/climb flags (IX+0x0D bits 0/1)
C $8CF3,4 HL = the depth counter, increment it back, undoing the failed step
b $8CF8
c $8D11 Alternate PLAYER behaviour handler (swapped into $8DB9 by #R$9564; see #R$8968 and #R$8DB6)
N $8D11 Auto-walks the player object toward a fixed target position ($952B,$952C) over multiple frames, continuations via #R$923E, moving X then Y by up to 5px per call or snapping directly if already within 5px. Once both axes match, runs a settle animation via #R$8CF8/#R$99D5 and waits for the player's depth ($8DBD) to reach $18 before restoring the normal per-frame handler #R$8968 and calling #R$8A87 to complete the room transition. Used for the scripted walk-in after entering a room via a door/lift.
C $8D15,3 Save continuation
C $8D43,3 Save continuation
C $8D75,3 Save continuation
C $8D7B,3 Sprite-animation stepper
C $8D87,3 set player behaviour-handler pointer
C $8D8A,3 => Attempt to move to an adjacent room
c $8D8D Attack: fire the held weapon (reached from #R$8AFB when a weapon is held)
N $8D8D Calls #R$9923 (spawns the weapon projectile); if it returns Carry (meaning not fully confirmed -- possibly "could not spawn"), jumps to #R$8C35 (hit-response/reward text) directly. Otherwise calls #R$68C1 (consume ammo, auto-drop if empty), plays a firing animation via the $8956 table, then restores the normal player handler #R$8968. The actual hit detection happens later, asynchronously, in the projectile's own per-frame handler (#R$9963).
C $8D92,3 Spawn the weapon projectile object (thrown from the player's position, facing $8DC1), handler #R$9963
C $8D97,3 => Weapon hit-response text
C $8D9A,3 Consume one shot of ammo
C $8DA1,3 Save continuation
C $8DB2,3 set player behaviour-handler pointer
b $8DB6 PLAYER object record + 2 more fixed object records
N $8DB6 The player is an object record with the same layout as the dynamic pool records (see #R$A900), statically allocated here. Fields: +0/+1 = $8DCF (link to the next record in the active object list); +2 = current room number (mirrors $6126); +3/+4 = $8968 -- the player's per-frame behaviour handler (#R$8968), SWAPPABLE: #R$955A tests it against $8968 ("is the player in the normal state?") and #R$9564 swaps it to #R$8D11 (an alternate player state); +5/+6 = player Y/X position -- these are the $8DBB/$8DBC bytes referenced by proximity checks all over the code; +16..+19 = previous/target position pair (unconfirmed). The active object list runs: ($610E head) -> newest spawned objects ... -> $8DB6 (player) -> $8DCF -> $8DEF -> $0000 end.
W $8DB6,2 link to next object record ($8DCF)
B $8DB8,1 current room number
W $8DB9,2 player behaviour-handler pointer (normally #R$8968; swapped for state changes, e.g. #R$8D11)
B $8DBB,2 player Y/X position
B $8DBD,18
N $8DCF Second fixed object record (purpose not yet identified). Link points to $8DEF. Its state block (+2 onward, at $8DD1) is re-initialized with 22 bytes from $5C92 by #R$8F82 during room setup.
W $8DCF,2 link to next object record ($8DEF)
B $8DD1,22
N $8DEF Third fixed object record -- also the CREATURE insertion point: #R$6663 passes IX=$8DEF into #R$84AE, so the room's creature gets spliced into the list right after this record. Link field is $0000 (list end) when the room has no creature. State block (+2 onward, at $8DF1) re-initialized from $5C92 by #R$8F82.
W $8DEF,2 link to next object record ($0000 = list end, or the room's creature)
B $8DF1,22
t $8E37
b $8E3B
c $8E3F Special grid-value spawn routine (value $68) -- rearing snake
N $8E3F Same allocator mechanism as #R$8EA7; its handler is #R$9684 (see there for the full state machine).
C $8E3F,2 Advance HL past the grid-value byte, decrement the outer loop count
C $8E41,4 Save AF, BC, HL, DE
C $8E45,4 A = the next template byte, the spawn kind, store it into the new record's kind field
C $8E49,4 IX = the active-object list head $610E, the insertion point
C $8E4D,3 Dynamic object allocator
W $8E50,2 Dynamic object handler address (#R$9684)
C $8E52,2 Restore the template pointer (DE->A), A = the grid index low byte
C $8E54,3 Set object position (IX+5/+6) from grid index A
C $8E57,2 Restore and re-save the grid-cell pointer
C $8E59,4 C = $18, a fixed row-height parameter, A = this cell's terrain code
C $8E5D,2 If the code is 0, no terrain shape, skip to the finalize path
C $8E5F,3 HL = the terrain code, widened to a word
C $8E62,4 Double it, DE = the shape-table base $7556
C $8E66,3 HL = this code's shape-table entry, A = its first byte, advance
C $8E69,5 Read the shape record's address (H,L) and row count (B), rejoin the shared finalize path
c $8E6E Creature spawn: compute initial height
N $8E6E Computes (+0x07) from the room's terrain shape table ($74CE/$750B, summed over B grid rows), then finalizes the object.
C $8E6E,2 Save BC, HL, the shape-record pointer and row count
C $8E70,1 A = the terrain code at this row's cell
C $8E71,3 Search the (key,data) pair table at $74CE for key A
C $8E74,4 A = the matched data byte, compute A*3, an index into the size table
C $8E78,5 BC = the index, HL = table $750B
C $8E7D,2 HL = this entry's byte, A = the height contribution
C $8E7F,4 Restore HL, BC, accumulate the height sum in C
C $8E83,3 Advance to the next row, loop
C $8E86,11 Store the summed height (+0x07), set kind (+0x0A=$04) and flags (+0x0D=$88)
C $8E91,3 Dynamic object finalizer
C $8E94,8 Clear +0x16, restore HL/BC, advance to the next template field, decrement the outer row-count B
C $8E9C,4 Read the linked-record index byte, store it to +0x0E
C $8EA0,5 Restore AF, set the sprite number (+0x08=$23)
C $8EA5,2 Clear A, return
c $8EA7 Special grid-value spawn routine (values $66/$6A) -- bubble source ($6A full-strength, $66 weak; see #R$9602)
N $8EA7 Called from #R$62C8 with A=the special value ($66 or $6A) and HL pointing just past it in the template/extras stream. Self-modifies its own #R$8EC3 operand with A (so the spawned object's initial "kind" byte matches whichever of $66/$6A triggered it). Clears the grid cell to 0 (so the special value never appears in the finished grid -- see #R$612C). Reads 2 more bytes from the template beyond the normal (index,value) pair -- these are NOT accounted for by the outer #R$62C8 loop's own HL advancement; instead the routine forces two extra DEC B's (at $8EE8/$8EE9), ending that loop one iteration early to compensate (see #R$6CCF). Sets up IX=$610E (the active-object list head) as the insertion point, then CALLs #R$84AE to allocate an object record -- its handler address (#R$8EB9) is #R$957C. Populates further record fields (offset $07=$18, $0A=$06, $09=triggering value, $0B and $0E=first extra byte, $14=second extra byte), then CALLs #R$9A60 to finalize. The two extra bytes' exact meaning (screen position? direction?) is not yet confirmed. Offset $09 (the triggering value) reads back as $00 afterward, suggesting it's consumed during finalization.
C $8EA7,3 Self-modify #R$8EC3's operand with the triggering value ($66 or $6A)
C $8EAA,4 Clear the new record's own +0x00 field (defensive init)
C $8EAE,4 Save HL, BC; back up one byte to clear the grid cell
C $8EB2,4 IX = the active-object list head $610E, the insertion point
C $8EB6,3 Dynamic object allocator
W $8EB9,2 Dynamic object handler address (#R$957C)
C $8EBB,12 Set height (+0x07=$18), kind (+0x0A=$06), and the triggering value (+0x09)
C $8EC7,2 Restore HL, A = the grid index
C $8EC9,3 Set object position (IX+5/+6) from grid index A
C $8ECC,3 Advance past the index and value bytes to the first extra byte
C $8ECF,6 Read it and store into both the linked-record index (+0x0E) and facing (+0x0B)
C $8ED5,1 Advance to the second extra byte
C $8ED6,4 Read it and store into +0x14
C $8EDA,3 Dynamic object finalizer
C $8EDD,3 Restore BC, HL; advance HL past the two extra bytes
C $8EE0,5 A = the triggering value stored in the record, compare against $6A
C $8EE5,2 If it's the full-strength variant ($6A), take the branch below
C $8EE7,5 Weak variant: force two extra DEC B's to compensate #R$62C8's loop count, then clear A and return
C $8EEC,4 Full-strength: set +0x14=$E0 instead
C $8EF0,2 Then join the same DEC-B compensation above
c $8EF2 Special grid-value spawn routine (value $67) -- plant/coral
N $8EF2 Same allocator mechanism as #R$8EA7; its handler is #R$94EE.
N $8EF2 $67 is rare: only 2 occurrences in the whole room table (rooms $9C and $A3).
C $8EFE,3 Dynamic object allocator
W $8F01,2 Dynamic object handler address (#R$94EE)
C $8F11,3 Set object position (IX+5/+6) from grid index A
C $8F17,3 Dynamic object finalizer
c $8F1E Special grid-value spawn routine (value $69) -- whirlpool
N $8F1E Every Plug Room's extras end with $25,$6B,$25,$69 -- a Plug and a $69 object co-located at the same grid cell -- and $69 also appears 23x across the room table (not plug-exclusive, unlike $6B). Same allocator mechanism as #R$8EA7; its handler is #R$952D.
C $8F2A,3 Dynamic object allocator
W $8F2D,2 Dynamic object handler address (#R$952D)
C $8F39,3 Set object position (IX+5/+6) from grid index A
C $8F3C,3 Test whether the current room is this level's Plug Room
c $8F4C Special grid-value spawn routine (value $6B) -- plug
N $8F4C $6B appears in exactly 4 rooms' extras in the whole room table, and they are precisely the 4 Plug Rooms (#R$73B3) -- never in any of the 11 shared room-type templates, only introduced per-room. Same allocator mechanism as #R$8EA7; its handler is #R$94F4.
C $8F52,3 Test whether the current room is this level's Plug Room
C $8F61,3 Dynamic object allocator
W $8F64,2 Dynamic object handler address (#R$94F4)
C $8F77,3 Search the (key,data) pair table at $74CE for key A
s $8F81
c $8F82 Spawn room-membership-gated decoration pairs
N $8F82 Re-initializes the two fixed object records, then spawns pairs from the #R$75B5 spawner table.
N $8F82 After resetting the $8DCF/$8DEF state blocks, walks the spawner table at $75B6 looking for a record whose embedded room-list contains the current room. On a match, spawns a PAIR of objects (handler #R$9021), chained to each other via +0x18/+0x19, sharing fields copied from the record (position/type) plus a couple of pseudo-randomized flag bytes derived from the Z80 R register. Table format matches #R$75B5's (len, marker, handler_word, Y, X, type, flags, room-list...) records.
C $8F82,11 copy the 19-byte default state block into $8DD1 (second fixed record)
C $8F8D,11 copy the same block into $8DF1 (third fixed record)
C $8F98,5 set the spawn-pair counter $8F81 = 2
C $8F9D,4 IX = the creature insertion point $8DCF, HL = spawner table $75B6
C $8FA1,7 *loop: read the record's room-list length, done if it underflows (table end)
C $8FA8,3 C = room-list length, B = 0
C $8FAB,7 DE = record pointer, skip ahead if this record has no room-list
C $8FB2,4 HL = the room-list start (record + 8)
C $8FB9,4 search the room-list for the current room, branch to spawn if found
C $8FBD,7 not found: advance to the next record via its length, loop back
C $8FC4,7 found: store this object's own pointer into +0x18/+0x19 (pair self-link)
C $8FCB,2 advance HL, write A back to this position
C $8FCD,5 DE = IX + 2 (destination for the field copy)
C $8FD2,5 BC = 5, copy 5 bytes from the record (position/type fields)
C $8FD7,4 store the record's next byte into +0x0A (kind)
C $8FDB,5 store the following byte into +0x1A
C $8FE0,6 derive a pseudo-random flag byte from the R register, store to +0x1C
C $8FE6,8 derive a second flag byte, store to +0x1B
C $8FEE,4 height (+0x07) = $28 (fixed)
C $8FF2,4 facing (+0x0B) = 1
C $8FF6,4 phase (+0x0F) = 1
C $8FFA,4 set bit 7 of +0x0D
C $8FFE,3 HL = handler address $9021
C $9001,6 store the handler into +0x03/+0x04
C $9007,3 finalize via #R$9A60
C $900A,5 decrement the spawn-pair counter, done if it reaches zero
C $900F,12 load the paired object's own pointer (+0x18/+0x19), switch IX to it
C $901E,3 loop back to spawn the second paired object
C $8FB6,3 get room number
C $9007,3 Dynamic object finalizer
c $9021 Per-frame animation-table stepper
N $9021 Searches the table pointed by (IX+$18/$19) for a matching entry ($619A), then applies position/facing changes over several frames via #R$923E continuations.
C $904F,3 Apply the object's facing direction to its position (IX+5/+6), returning the OLD position in BC
C $9052,3 Dynamic object finalizer
C $9055,3 Save continuation
C $9060,3 Collision/overlap scan
t $9077
b $907B
t $907C
b $9080
c $9085 Object type stub: dispatch into #R$90A8's creature AI setup
C $9085,2 A = $72, the initial width/param
C $9087,3 HL = the object's animation-table pointer $9081
C $908A,3 => Jump into #R$90A8's shared creature AI setup
t $908D
b $9091
c $90A8 Creature idle/wander AI
N $90A8 Sets the walk-animation table (IX+$1D/$1E/$1F), times a walk-then-pause cycle via #R$91A6, occasionally spawns a bubble/particle child object, and eventually hands off to #R$925C waypoint movement.
C $90B6,3 Creature pause/transform step
C $90E4,3 Apply the object's facing direction to its position (IX+5/+6), returning the OLD position in BC
C $90E8,3 Collision test
C $9103,3 Direction-indexed sprite-animation stepper
C $9106,3 => Dynamic object finalizer
C $9115,3 Request sound effect A
C $9118,3 Save continuation
C $911B,3 Creature pause/transform step
C $9132,3 => Creature waypoint movement
C $914C,3 Dynamic object allocator
W $914F,2 Dynamic object handler address
C $917C,3 Dynamic object finalizer
C $9183,3 Save continuation
C $9186,3 Creature pause/transform step
C $9189,3 Direction-indexed sprite-animation stepper
b $919A
c $91A6 Creature pause/transform step
N $91A6 On the wander timer expiring, clears its list-cell state, rebuilds the door bitfield (#R$6329), plays a sound, and runs a transform animation via #R$99D5/$919A.
C $91C4,3 Build the door/exit bitfield at $612B from the room description's byte1
C $91C9,3 Request sound effect A
C $91D0,3 Add a bonus to the score, value from a circular queue via #R$88B9
C $91D3,3 Save continuation
C $91D9,3 Sprite-animation stepper
b $91E2
c $9208 Object type stub: dispatch into #R$9232's shared setup
C $9208,2 A = $3E, the initial width/param
C $920A,3 HL = the object's animation-table pointer $9204
C $920D,3 => Jump into #R$9232's shared setup
b $9210
c $9232 Object type stub: dispatch into #R$90A8's creature AI setup
N $9232 Loads a fixed animation-table pointer ($922E) and initial width/param A=$74, clears the pause-timer field (IX+0x1C), then jumps into #R$90AD, the shared creature-AI setup body inside #R$90A8, a per-kind trampoline supplying its own table/param constants.
c $923E Save continuation
N $923E Sets the object's handler (+3/+4) to the address just after the caller's CALL, then jumps there, the object resumes at that point next frame.
C $923E,1 Pop the return address off the stack, the caller's CALL site + 3
C $923F,3 Store its low byte into the object's handler pointer (+0x03)
C $9242,3 Store its high byte into the object's handler pointer (+0x04)
C $9245,1 Jump to that address now
b $9246
c $925C Creature waypoint movement
N $925C Steps toward the next patrol point in the linked list at $8DEF, one facing-direction move per call.
N $925C Walks the waypoint list at $8DEF (linked via each entry's own +8 offset) looking for the entry matching this object's target-waypoint tag (IX+$1A), copying its target position into scratch $9246. Picks a movement-delta table entry (at $924C, indexed by facing IX+$0B) into scratch $9248, then a 3-iteration threshold scan decides whether the object should approach the near or far side of the target cell (swapping the scratch delta accordingly). Moves up to 4 steps via #R$8ABB/#R$9BF0, aborting to #R$99A1 without finalizing on collision. On reaching the target (both position axes match), plays sound effect $05 and adjusts the rust/oil timer $6501 before finalizing via #R$9A60.
C $925C,3 HL = the object's own position (IX+5/+6 mirror), save it as the initial target scratch
C $925F,3 Save it to scratch $9246
C $9262,3 HL = the waypoint-list head at $8DEF
C $9265,2 Read this entry's link pointer (E,D)
C $9268,4 If the link is null, no more waypoints, stop searching
C $926C,4 HL = the entry's own tag field offset (+8)
C $9270,4 Compare the object's target-waypoint tag (IX+$1A) against this entry's tag
C $9276,3 Not a match: follow the link to the next entry and retry
C $9279,3 Found it: HL = the entry's position field offset (+5)
C $927C,1 ADD HL,DE
C $927D,3 DE = scratch $9246, the target-position slot
C $9280,4 Copy the 2-byte target position into scratch
C $9284,3 A = the object's current facing (IX+$0B)
C $9287,4 Isolate the direction bits and double them, an index into the delta table
C $928B,2 DE = the direction index, widened to a word
C $928D,3 HL = the movement-delta table at $924C
C $9290,1 HL = this direction's delta-table entry
C $9291,3 DE = scratch $9248
C $9294,5 Copy the 4-byte delta entry into scratch
C $9299,3 DE = scratch $9248 again
C $929C,2 B = 3, iterate the entry's 3 threshold fields
C $929E,3 HL = the target position saved earlier
C $92A1,3 Threshold field = 1: compare the target's low byte against the object's left edge (IX+5)
C $92A6,4 If below, take the near-side branch, else fall through
C $92AE,4 Threshold field = 4: compare the target's high byte against the object's top edge (IX+6)
C $92B2,4 If below, take the near-side branch, else fall through
C $92BA,4 Threshold field = 2: compare the target's low byte against the object's left edge (IX+5)
C $92C1,3 If below, take the near-side branch
C $92C6,4 Otherwise compare the target's high byte against the object's top edge (IX+6)
C $92CC,3 Advance to the next threshold field and loop
C $92CF,2 No threshold matched: keep the scratch delta as-is
C $92D1,6 Threshold matched: swap the scratch delta's byte with the current threshold field, the near-side adjustment
C $92D9,3 HL = scratch $9248, the (possibly swapped) delta
C $92DC,2 B = 4, up to 4 movement steps
C $92DE,2 Save BC, save HL (the delta pointer)
C $92E0,4 Set the object's facing (IX+$0B) from the next delta byte
C $92E4,3 Apply the object's facing direction to its position (IX+5/+6), returning the OLD position in BC
C $92E7,1 Save the old position
C $92E8,3 Collision test
C $92EB,1 Restore the old position into BC
C $92EC,2 On collision, abandon the walk without finalizing
C $92EE,6 Revert the position to the old value (IX+5/+6 = B/C)
C $92F4,2 If the collision wasn't a full stop (NZ), skip the arrival check
C $92F6,3 HL = the level's designated arrival marker $8DB6
C $92F9,3 Compare it against the saved target position DE
C $92FC,2 Not the arrival marker: skip the arrival handling
C $92FE,4 IY = a fixed table $7CBC (arrival handler parameters)
C $9302,3 Subtract a BCD value from the score, value from a circular queue via #R$88B9
C $9305,2 A = sound effect $05
C $9307,3 Request sound effect A
C $930A,3 Print a message-window string
B $930D,1 attribute/control byte for #R$8513's inline string
T $930E,14 message text, terminated by $5E
C $931C,2 B = 1, default adjustment
C $931E,4 A = a per-object flag (IX+0x1F), test it
C $9322,2 If clear, keep the default adjustment
C $9324,2 Otherwise B = 2, a larger adjustment
C $9326,3 A = the rust/oil timer $6501
C $9329,1 Add the arrival-handler's adjustment (B)
C $932A,3 Store the updated timer back to $6501
C $932D,2 Restore HL, BC
C $932F,1 Advance the delta pointer past this step's byte
C $9330,2 Loop for the next movement step
C $9332,3 Dynamic object finalizer
C $9335,3 => Direction-indexed sprite-animation stepper
C $9338,2 Collision case: just restore HL, BC
C $933A,3 => Direction-indexed sprite-animation stepper
s $933D
c $9341 Room-creature per-frame behaviour handler
N $9341 Installed by the creature spawn at #R$6663 -- dual purpose: item-delivery detector in Plug Rooms, settle/float physics + hit detection elsewhere.
N $9341 PLUG ROOM BRANCH (taken when #R$62F9 confirms the current room is this level's Plug Room): compares this object's own sprite number (+0x08) against each of the 4 required item sprites in the level's #R$7287 table (bytes 2-5), gated by the corresponding undelivered bit in the level's state nibble (byte1, CPL'd so unset/undelivered bits read as 1). On a match: sets that delivery bit in the state byte, repositions itself at the matching corner-cube grid cell (#R$6254), increments the "Goodies Gathered" counter at $6123 (BCD), plays sound effect $01, runs a short animation via the #R$919A table, then re-pokes the grid cell to the "delivered" marker $13 and self-destructs ((IX+$02)=$FF). This strongly implies the object's sprite (+0x08) is set elsewhere to track whichever item the player is currently carrying/delivering -- that link is not yet found. If the state nibble is already fully clear (all delivered), falls through to the normal branch below.
N $9341 NORMAL-ROOM BRANCH (#R$93C1): settle/float physics -- the height/Z field (+0x07) decays by 4 each frame toward a rest value $18 (clamped), tested each step via #R$9BF0 (collision); if blocked, the height is bounced back up by 4 instead. Also checks bit 2 of (IX+$0D) (a "just hit by a weapon" flag set elsewhere, not yet traced) and calls #R$9401 if set.
C $9341,3 Test whether the current room is this level's Plug Room
C $9381,3 Set object position (IX+5/+6) from grid index A
C $938C,3 get "Goodies Gathered" end-game stat counter
C $9392,3 set "Goodies Gathered" end-game stat counter
C $9397,3 Request sound effect A
C $939A,3 Save continuation
C $93A0,3 Sprite-animation stepper
C $93A4,3 Reset the sprite-draw clip window ($610A-$610D) to the full play-field
C $93A7,3 Reset the redraw bounding-box trackers ($6194-$6197) to empty
C $93B9,3 Redraw one terrain grid cell (index in BC), used to restore terrain hidden behind an object's sprite
C $93C1,3 Save continuation
C $93C8,3 Creature hit/defeat sequence, called from #R$9341 when the "just hit" flag (bit 2 of +0x0D) is set
C $93DC,3 Collision test
c $9401 Creature hit/defeat sequence, called from #R$9341 when the "just hit" flag (bit 2 of +0x0D) is set
N $9401 CONFIRMED structure (trigger not yet traced): clears the hit flag, then only proceeds if the creature's current sprite (+0x08) is $44 (a shared "vulnerable" pose -- creatures presumably must be in this pose to register a hit). Searches a (room, position, reward-sprite) triple table at $7C89 (count from $7C97) for an entry matching the current room and this object's position field (+0x09); on a match, swaps the reward sprite into +0x09 and into offset +3 of a linked record (via +0x0E/+0x0F), plays sound effect $01 (the same "success" sound as item delivery), steps through the #R$919A animation table to transform the sprite, then finalizes (+0x08 = reward sprite, #R$9AAB kind lookup into +0x0A, #R$9A60) and resumes normal behaviour at #R$93C1. Likely how a creature is "defeated" and turns into a collectible (a Gnome?).
C $9401,4 Clear the "just hit" flag (IX+0x0D bit 2)
C $9405,6 A = the creature's current sprite, only proceed if it's $44, the vulnerable pose
C $940B,10 A = the object's position field, HL = the hit table $7C89, BC = its entry count/stride from $7C97
C $9415,4 Compare against this entry's room byte, advance HL, stop if matched
C $9419,4 Otherwise skip the rest of this entry, loop for the next
C $941E,5 A = the object's own position field, compare against this entry's position, only proceed on match
C $9423,9 Discard the return address, HL = the reward-sprite byte, swap it into the object's own position field (+0x09)
C $942C,8 DE = a linked record pointer (+0x0E/+0x0F), write the same reward sprite into its offset +3
C $9434,2 A = sound effect $01
C $9436,3 Request sound effect A
C $943F,3 Save continuation
C $9439,6 HL = the transform animation table $919A, save it as the animation-stepper's own resume pointer
C $943F,3 Save continuation
C $9442,8 Read the next animation sprite from the saved pointer, store it as the object's sprite (+0x08)
C $944A,6 Save the advanced pointer, stop, mid-animation, unless the table's end marker $FF was reached
C $9450,6 Animation done: A = the reward sprite, set it as the final sprite (+0x08)
C $9456,3 Search the (key,data) pair table at $74CE for key A
C $9459,4 A = the kind byte from the lookup, store it (+0x0A)
C $945D,3 Dynamic object finalizer
C $9460,3 Resume normal creature behaviour
b $9463
c $9471 Behaviour handler of the fixed object record at $8E0F (object identity not yet known)
N $9471 Copies the player's grid position ($8DBB/$8DBC) into its own fields $8E14/$8E15, copies the player's facing ($8DC1) into its own facing (IX+0x0B), then runs the sprite-animation table $946D via #R$99A7. Tracks the player's position/facing every frame rather than moving independently -- possibly a HUD marker or an attached "ghost" object, identity unconfirmed.
b $9489
t $9495
b $9499
c $949E Behaviour handler of the fixed object record at $8E27 (object identity not yet known)
N $949E Sets height (+0x07) to $8DBD+$18, relative to the player's current depth, and position (+5/+6) to the player's grid position ($8DBB/$8DBC) offset by a per-facing-direction delta from table $9489, indexed by $8DC1 AND $06, then finalizes via #R$9A60 and starts the sprite-animation table $9495. Likely spawns/positions a bubble or trail effect relative to the player, though the fixed object's own identity ($8E27) isn't confirmed.
C $949E,8 A = the global depth counter $8DBD + $18, set the height field (+0x07)
C $94A6,5 A = the player's facing $8DC1, isolate the direction bits
C $94AB,7 HL = the delta table $9489 plus the direction index
C $94B2,7 A = the player's X ($8DBB), add the delta, store as this object's X (+0x05)
C $94B9,8 Advance to the delta's dy byte, A = the player's Y ($8DBC), add it, store as Y (+0x06)
C $94C1,3 Dynamic object finalizer
C $94C7,3 => Sprite-animation stepper
c $94CA Object lifetime tick
N $94CA Decrements lifetime countdown (IX+0x0B), on expiry self-destructs, else advances the sprite (IX+0x08) via an 8-entry per-frame table at $9495.
C $94CA,3 Decrement lifetime countdown (IX+0x0B)
C $94CD,2 If still counting, jump to the frame-advance below
C $94CF,4 Expired: mark for self-destruction (+0x02=$FF)
C $94D4,4 Advance frame index (IX+0x0F), wrapping at 8
C $94DD,3 Widen it to a word offset
C $94E0,4 HL = the table $9495 plus that offset
C $94E4,4 Read the sprite number and store it to (IX+0x08)
b $94E9 #R$99D5 sprite-animation table for the plant/coral object (#R$94EE)
N $94E9 Sprites $4E,$4E,$50,$50 (see #R$A714/#R$A71C, both labeled "Plant/coral"), terminated by $FF -- a simple 2-frame swaying decoration.
c $94EE Per-frame behaviour handler for value-$67 objects -- plant/coral
N $94EE Its #R$99D5 animation table (#R$94E9) is sprites $4E,$4E,$50,$50, both "Plant/coral" sprites -- a simple 2-frame swaying decoration.
C $94F1,3 => Sprite-animation stepper
c $94F4 Plug Room win-condition trigger
N $94F4 Per-frame behaviour handler for value-$6B objects, the plug. Polls every frame for full item delivery, then pops and increments the "Plugs Pulled" counter.
N $94F4 CONFIRMED: re-checks (every frame, via #R$62F9 + AND $0F/CP $0F) whether this level's Plug Room state nibble has reached $0F (all 4 items delivered -- see #R$9341). Once it has: increments the "Plugs Pulled" counter at $6124 (BCD), plays sound effect $09, and animates the plug popping out (+0x07 += 8 per frame, gated by bit 4 of +0x0D so this only fires once), then self-destructs on the following frame (bit 6 of +0x0D check). This is the actual win-condition trigger for a single Plug Room.
C $94F4,3 Test whether the current room is this level's Plug Room
C $94FD,3 get "Plugs Pulled" end-game stat counter
C $9503,3 set "Plugs Pulled" end-game stat counter
C $9508,3 Request sound effect A
C $950B,3 Save continuation
b $9526 #R$99D5 sprite-animation table for the whirlpool object (#R$952D)
c $952D Per-frame behaviour handler for value-$69 objects -- whirlpool
N $952D Its #R$99D5 animation table (#R$9526) is sprites $4C,$4C,$4D,$4D, both "Whirlpool, animation phase" sprites.
C $9530,3 Sprite-animation stepper
C $9533,3 Test whether the current room is this level's Plug Room
C $955A,3 get player behaviour-handler pointer
C $9567,3 set player behaviour-handler pointer
b $9577 #R$99D5 sprite-animation table for the bubble source object (#R$957C)
N $9577 Sprites $68,$68,$69,$69 (see #R$C38E/#R$C39E, both relabeled "Bubble"), terminated by $FF.
c $957C Per-frame behaviour handler for value-$66/$6A objects -- bubble source
N $957C Its #R$99D5 animation table (#R$9577) is sprites $68,$68,$69,$69, the 16x8 bubble sprites at #R$C38E/#R$C39E.
C $957F,3 Sprite-animation stepper
C $9594,3 Dynamic object allocator
W $9597,2 Dynamic object handler address (#R$9602)
C $95B9,3 Dynamic object finalizer
b $95C1
B $95FB
c $9602 Per-frame behaviour handler for the individual rising-bubble particle spawned by #R$957C
N $9602 At $9622-$962D, branches on the inherited trigger value at (IX+$0B) -- only if it's $6A does it SET bit 4 of (IX+$0D) and switch to movement table $95E2 (steps +0x07 by $04/frame) instead of the default #R$95C9 (steps by $02/frame): the $6A bubble rises at double the rate. That bit 4 flag is later tested at #R$97E6 (in the sprite-draw wrapper, right after #R$8128 draws it); only if set does it SET bit 6 of (IX+$0D). Back here at $961B, bit 6 being set causes immediate self-destruct ((IX+$02)=$FF). So only $6A-triggered bubbles can ever reach that clean completion state -- $66 bubbles never do: a full-strength bubble stream that completes its rise ($6A) vs. a weak one that never does ($66), matching gameplay where some bubble sources cannot lift the player all the way. Whether bit 6 specifically means "reached the surface" is unconfirmed.
C $9604,3 Request sound effect A
C $9607,3 Save continuation
C $960D,3 Sprite-animation stepper
C $9615,3 Save continuation
C $9630,3 Sprite-animation stepper
C $967B,3 Sprite-animation stepper
c $9684 Per-frame behaviour handler for value-$68 objects -- rearing snake
C $9684,6 test countdown (+0x0E), skip ahead if already zero
C $968A,4 decrement countdown and return
C $968E,6 test phase counter, fall through to the rise seed if nonzero
C $9694,8 phase 0: init position to 0, advance to phase 1, return
C $969C,15 phase 1: seed rise start position ($FE/$FC), advance phase
C $96AB,53 shared step: jump position +8, run collision/draw (also the phase-2 loop-back target)
C $96E0,23 phase 2: increment sprite until fully reared ($26), then set a long pause and advance phase
C $96F7,27 phase 3+ (default): retract -- decrement sprite and position by 8 each call until back to $23
C $9712,17 fully retracted: reset position, restart the cycle at phase 1
N $9684 Handler for #R$8E3F's objects (its handler-address bytes at #R$8E50 -- see #R$84AE), called from #R$983C's dispatcher.
N $9684 Sprite starts at $23 (set by #R$8EA1 on spawn) and cycles through $23,$24,$25,$26 -- the "Snake, rearing phase" sprites at #R$B56E/#R$B57E/#R$B59E/#R$B5CE, with increasing sprite height (16x8 -> 16x16 -> 16x24 -> 16x32) as it rises, i.e. more of the snake's body becomes visible each frame. Full cycle: phase 0 = idle countdown at (IX+$0E) (decrements while nonzero); phase 1 = seed position (IX+$16)/(IX+$17) at $FC/$FE then jump +8; phase 2 = each call, INC sprite number (IX+$08) and jump position +8 again, repeating until sprite reaches $26 (fully reared), then sets a long countdown ($24) and advances to phase 3+; phase 3+ (default case) = each call, if sprite isn't back down to $23 yet, DEC sprite and retract position by -8; once back at $23, reset position to 0, set bit 7 of (IX+$0D) (purpose not traced), set another countdown, and restart the cycle at phase 1. A full rise-pause-retract-pause loop.
b $9723
c $9745 Mark and redraw the static terrain cells behind an object's sprite, so moving objects don't leave trails
N $9745 Called by #R$97BA before drawing an object's sprite. Uses the #R$9723 table (row-band -> grid-row-start/count) to flag every grid cell (bit 7) within the sprite's vertical extent, skipping empty ($00) and solid-wall ($7F) cells; then does a second pass over the whole 64-cell grid, redrawing (via #R$6470) any flagged cell that also falls within the sprite's horizontal extent.
C $9745,4 save the object's Z/height (+0x07)
C $9749,9 compute the row-band index from the clip-window top ($610B >> 3)
C $9752,4 HL = #R$9723 + row-band index
C $9756,11 compute how many row-bands the clip-window height spans, +1
C $9761,8 loop head: read this band's (grid-row-start, count) pair from #R$9723
C $9769,4 HL = grid base #R$612C + row-start
C $976D,3 DE = 9 (row stride)
C $9770,10 mark this cell (bit 7) unless it's empty ($00) or solid wall ($7F)
C $977A,3 advance to next cell, loop count times
C $977D,5 advance to the next row-band, loop bands times
C $9782,19 compute the sprite's left/right grid-column range from its bounding box (+0x10/+0x11)
C $9795,3 HL = grid base #R$612C
C $9798,1 A = cell index (0)
C $9799,12 scan the grid: skip cells not marked, or outside the column range
C $97A5,10 in range: redraw this cell's terrain piece via #R$6470
C $97AF,2 advance to next cell
C $97B1,4 loop until all 64 cells checked
C $97B5,5 restore Z/height, return
C $9795,3 Room grid address
c $97BA Draw an object's sprite
N $97BA Converts record position (+5/+6) to screen coordinates and draws sprite (+8) with its mask via #R$8128.
R $97BA IX ??
C $97BA,6 HL = the object's position (+5/+6)
C $97C0,11 A = $98 minus the position's row/height offsets, plus L+H, D = the screen row
C $97CB,7 A = $80 minus twice the column, plus twice the row, E = the screen column
C $97D2,7 A = the sprite number, isolate the mirror-flag bit, force bit 0
C $97D9,3 Save that flag byte for #R$8128's own flip test at $97E2
C $97DC,5 C = the sprite number with the mirror flag masked off
C $97E1,2 A = 1, the colour parameter
C $97E3,3 Draw sprite C with its mask at screen position DE
C $97E6,8 Test and clear the "just entered water" flag (IX+0x0D bit 4)
C $97EE,2 If clear, skip straight to the redraw-behind step
C $97F0,1 Otherwise, if the sprite draw was off-screen (Z), just return
C $97F1,5 Set the "splash" flag (IX+0x0D bit 6) and return
C $97F6,3 Mark and redraw the static terrain cells behind an object's sprite, so moving objects don't leave trails
C $97F9,3 => Sprite draw
c $97FC Change current room to A = new room number
N $97FC Draws the new current room via #R$676D, then restores SP from $60E9, saved by #R$9808, and falls into #R$9808 to resume the per-frame main loop.
R $97FC A new room number
C $97FC,3 Draw current room
C $9803,3 => Per-frame main loop entry
w $9806
c $9808 Per-frame main loop entry
N $9808 Saves SP to $60E9 (restored by #R$97FC on room change); restores the message-window title when the $618A timer expires.
C $9824,3 Reset the sprite-draw clip window ($610A-$610D) to the full play-field
C $982F,3 Per-frame dynamic object dispatcher
C $9836,3 Per-frame dynamic object dispatcher
C $9839,3 => Draw all queued objects
c $983C Per-frame dynamic object dispatcher (walks the active object list from the head at #R$610E)
N $983C For each object record (IX) in the list (record +0/+1 links to the next; the list includes the pool records at #R$A900, the PLAYER record at #R$8DB6, and the room's creature): if offset +2 reads $FF, the record was marked dead mid-frame -- unlinks it back onto the free list ($618B) instead of dispatching it. Otherwise, if its room matches the current room, calls its handler (offset +3/+4) via #R$61A7, then re-checks the room (the handler may have moved/removed it). If still valid and bit 7 of +0x0D is clear, computes a draw-order sort key ($5E + left edge +0x10 + top edge +0x11) into +0x0C, then inserts the record into the draw queue #R$60EC: scanning for the first entry whose bounding box (+0x10..+0x13) doesn't overlap this one, or -- if boxes do overlap -- whose sort key/+0x0C value is smaller, shifting later entries down to make room. This is the painter's-algorithm draw-order queue consumed by #R$9900/#R$97BA.
C $983C,6 HL = the list head pointer
C $9842,3 test for list end, return if so
C $9845,3 save HL, IX = this record
C $9848,6 check for a "deleted" marker (offset +2 == $FF)
C $984E,6 deleted: HL = this record's link, DE = the free-list head
C $9854,10 unlink this record, splice it onto the free list
C $985E,6 update the free-list head, restore IX
C $9864,8 store the saved link back into the list, loop to the next record
C $986C,9 compare the record's room to the current room, skip ahead if different
C $9875,6 HL = the object's handler pointer (+3/+4)
C $987E,8 call the handler, then re-check the room (the handler may have moved/removed the object)
C $9886,6 skip the sort-key update if bit 7 of +0x0D is set
C $988C,11 compute the draw sort-key = $5E + left edge (+0x10) + top edge (+0x11), store to +0x0C
C $9897,9 HL = draw queue $60EC, A = queue count, done (append) if empty
C $98A0,4 B = queue count, A = this object's sort key
C $98A4,4 *loop: DE = this queue entry's record pointer
C $98A8,10 compare this object's right edge (+0x12) against the queued entry's left, insert-before if less
C $98B2,7 compare bottom (+0x13) against the queued entry's top, insert-before if less
C $98B9,7 compare left (+0x10) against the queued entry's right, insert-before if less
C $98C0,7 compare top (+0x11) against the queued entry's bottom, insert-before if less
C $98C7,5 boxes overlap on both axes: HL = the queued entry's sort key (+0x07)
C $98CC,6 restore HL, compare sort keys, decide insert position
C $98D2,2 fall through to keep scanning
C $98D4,8 boxes don't overlap: HL = the queued entry's alternate sort key (+0x0C), compare against this object's
C $98DC,3 restore HL, insert-before if less
C $98DF,3 keep scanning: advance HL, loop
C $98E2,2 queue exhausted without a match: append instead
C $98E4,7 found the insert point: compute the shift distance
C $98EB,6 DE = HL+1, copy the shifted block backward via LDDR
C $98F1,1 advance HL back to the insert slot
C $98F2,6 DE = this object's own record address (IX)
C $98F8,4 increment the queue count
C $98FC,1 restore the list-traversal pointer
R $983C IX ???
C $981B,3 Print string routine
C $9821,3 Print string routine
C $986C,3 get room number
C $987B,3 JP (HL) trampoline
C $987E,3 get room number
C $98FD,3 => Per-frame dynamic object dispatcher
c $9900 Draw all queued objects: walk the record-pointer list at $60EC (count at $60EB), drawing each via #R$97BA
N $9900 Reads the queued-object count from $60EB, returning immediately if zero. Otherwise walks the record-pointer list at $60EC, loading each pointer into IX and calling #R$97BA to draw it, until the count is exhausted -- the final draw pass consuming the painter's-algorithm queue built by #R$983C.
C $9900,3 B = queued-object count from $60EB
C $9903,2 If zero, nothing to draw, return
C $9905,4 B = count, HL = the draw-queue's record-pointer list at $60EC
C $9909,1 Save BC, the outer loop counter
C $990A,4 Read the next queued record pointer (E,D) from the list, advancing HL
C $990E,4 Save HL, load the record pointer into IX
C $9912,3 Draw an object's sprite
C $9915,4 Restore HL, restore BC, loop back to $9909 for the next queued object
b $991A
c $9923 Spawn the weapon projectile object (thrown from the player's position, facing $8DC1), handler #R$9963
N $9923 Plays sound effect $08, allocates an object at the active list head, sets its sprite to the weapon's own sprite (A), position from the player, kind $0D, and facing from $8DC1, then calls #R$9A60 to finalize.
C $9926,3 Request sound effect A
C $992D,3 Dynamic object allocator
W $9930,2 Dynamic object handler address
C $9955,3 Dynamic object finalizer
b $995E
c $9963 Weapon projectile per-frame handler: move (double step) and detect a hit on collision
N $9963 Applies the facing delta twice via #R$8ABE (see #R$8ABB), testing collision (#R$9BF0) after each step -- a fast-moving shot. On collision with terrain (no target object, DE unset): just stops. On collision with another object (DE = that object's record): SETS bit 2 of its (+0x0D) -- the "just hit" flag consumed by #R$9341/#R$9401 -- and writes the projectile's own sprite (masked to 7 bits) into that object's offset +9, presumably so #R$9401's reward lookup can identify which weapon scored the hit. Animates briefly via the #R$995E table, then self-destructs.
C $9963,3 Apply the object's facing direction to its position (IX+5/+6), returning the OLD position in BC
C $9967,3 Collision test
C $996D,3 Apply the object's facing direction to its position (IX+5/+6), returning the OLD position in BC
C $9971,3 Collision test
C $9992,3 Save continuation
C $9998,3 Sprite-animation stepper
c $99A1 Direction-indexed sprite-animation stepper
N $99A1 Picks one of 4 per-direction tables via (IX+$0B), then runs #R$99D5's stepper on it.
N $99A1 HL = (IX+$1D)/(IX+$1E), a pointer to a table of 4 sub-table addresses. Selects one by facing direction ((IX+$0B), mapped 1->0/2->1/... via a small comparison chain, then AND $03), loads that sub-table's address, and falls into #R$99D5's shared byte-code interpreter ($FD/$FC/$FE/$FB position-delta markers, otherwise a sprite number) -- this is how the player's (and other directional objects') walk-cycle animation is driven per-facing.
C $99A7,2 "RET" instruction code
C $99A9,3 set instruction
C $99B3,1 "NOP" instruction code
C $99B4,3 set instruction
C $99BD,1 "NOP" instruction code
C $99BE,3 set instruction
c $99D1 NEG / not NEG
c $99D5 Sprite-animation stepper: read next entry from a per-object sprite-number table, advancing a phase counter
N $99D5 Called with HL = a small table of raw sprite numbers (see #R$9526/#R$9577/#R$94E9 for examples). Indexes the table by (IX+$0F) (a per-object phase counter), reads the byte there into A, then INCs (IX+$0F) for next time. $FF in the table means "wrap to start" (resets (IX+$0F) to 0 and re-reads from the table's first byte); $FD is a second special marker (purpose not yet traced past #R$9A01). Otherwise A is the next sprite number to display for this object -- this is how #R$957C/#R$952D/#R$94EE (and others) drive their objects' animation frames.
C $99D5 "RET" instruction code
C $99D7,3 set instruction
C $99DA,6 Clear the wrap-flag scratch $991A; save the table base (HL) into BC
C $99E0,6 HL = the table base plus the phase counter (IX+0x0F)
C $99E6,7 A = the next table byte, advance the pointer and the phase counter, test for the wrap marker $FF
C $99ED,2 If not the wrap marker, use this byte as-is
C $99EF,13 Wrap marker: reset the phase counter to 0, restart from the table base, set the wrap-flag, loop back for the real first byte
C $99FC,4 Test for the "adjust X" marker $FD
C $9A00,1 A = the delta operand byte
C $9A01,3 NEG / not NEG
C $9A04,6 Add it, possibly negated, to X (+0x05), store back
C $9A0A,6 Advance past the operand, advance the phase counter, loop for the next byte
C $9A10,4 Test for the "adjust Y" marker $FC
C $9A14,1 A = the delta operand byte
C $9A15,3 NEG / not NEG
C $9A18,8 Add it, possibly negated, to Y (+0x06), store back, loop back to advance
C $9A20,4 Test for the "adjust height" marker $FE
C $9A24,9 Add the table byte to the height field (+0x07), store back, loop back to advance
C $9A2D,4 Test for the "set facing" marker $FB
C $9A31,6 A = the table byte, store it as the object's facing (+0x0B), loop back to advance
C $9A37,3 Otherwise: A is a plain sprite number, store it as the object's sprite (+0x08)
C $9A3A,3 get instruction code
C $9A3D,7 If the last instruction code was RET, no wrap happened, set the mirror flag on the sprite (+0x08 bit 7)
C $9A44,5 A = the wrap-flag, 0 or $FF, doubled to a signed byte, return
c $9A49 Snap the object's position (IX+5/+6) to its grid-cell centre, then finalize via #R$9A60
N $9A49 Masks each of X (IX+5) and Y (IX+6) to its 8px-aligned cell (AND $F8) then adds 4 to centre it in the cell, before falling into #R$9A60 to recompute the bounding box.
C $9A5D,3 => Dynamic object finalizer
c $9A60 Dynamic object finalizer
N $9A60 Computes the object's bounding box (+0x10..+0x13) from its position and a per-kind size template.
N $9A60 CONFIRMED: copies a 3-byte size template from table $750A (indexed by the object's kind, +0x0A, *3) into its own +0x15/+0x16/+0x17 fields, then uses the template's first byte as a half-extent to derive the bounding box: left/right (+0x10/+0x12) from the X position (+5), top/bottom (+0x11/+0x13) from the Y position (+6). Returns with Carry set (and skips writing the far edge) if either edge underflows or the box would extend past screen column/row 63 -- this is presumably how objects too close to the screen edge get flagged. This is the source of the +0x10..+0x13 fields every collision routine (#R$9BF0/#R$9B5A/#R$9ABC) reads.
C $9A60,8 HL = IX + 0x15 (the size-template destination), DE = HL
C $9A68,11 C = object kind (+0x0A), HL = $750A + C*3 (size-template source)
C $9A73,5 BC = 3, copy the size template into +0x15/+0x16/+0x17 via LDIR
C $9A78,7 E = half-extent (template byte 0), A = X position, compute the left edge
C $9A7F,3 store the left edge (+0x10)
C $9A82,4 bail out if the left edge underflowed
C $9A86,3 compute the right edge = left + 2*half-extent - 1
C $9A89,3 store the right edge (+0x12)
C $9A8C,4 bail out if the right edge is off the 63-column screen
C $9A90,4 A = Y position, compute the top edge
C $9A94,3 store the top edge (+0x11)
C $9A97,4 bail out if the top edge underflowed
C $9A9B,3 compute the bottom edge
C $9A9E,3 store the bottom edge (+0x13)
C $9AA1,4 bail out if the bottom edge is off the 63-row screen
C $9AA5,2 success: clear Carry, return
C $9AA7,3 failure: set Carry, return
c $9AAB Search the (key,data) pair table at $74CE for key A; returns Z with HL pointing at the matched pair's data byte
N $9AAB Walks B entries, count = low byte of $7509, starting at $74CE, comparing each entry's key byte against A; on a match (Z) returns with HL pointing at that entry's paired data byte, otherwise returns NZ after scanning the whole table. Used by #R$8E6E, creature height lookup, and others resolving a code into a data value via this shared 2-byte-record table.
C $9AAB,3 HL = the key/data pair table $74CE
C $9AAE,4 BC = table entry count, low byte of $7509
C $9AB2,1 B = the entry count
C $9AB3,1 Compare A against this entry's key
C $9AB4,2 Advance past the key byte, stop (Z) if matched, HL now points at the paired data byte
C $9AB6,1 Otherwise skip the data byte too
C $9AB7,2 Loop for the next entry
C $9AB9,1 Not found, return NZ
b $9ABA
c $9ABC Terrain collision test for one screen point (B,C): convert to a grid cell and check its content
N $9ABC Converts screen coordinates (B=X,C=Y) to a room-grid cell: (Y AND $F8)>>3 * 8 + (X AND $F8)>>3 -- confirms the #R$612C grid's row*8+col indexing operates on 8px-aligned screen tiles. Reads the grid cell; $00 = passable (no collision). $7F = solid wall, hard block (see #R$9B56). Any other nonzero code is looked up in a per-terrain-code shape/behaviour table at $7556 (the same table #R$8E6E reads) -- individual terrain codes may have different collision shapes rather than being uniformly solid.
R $9ABC BC ??
C $9ABC,4 compute the grid row byte from screen Y (B AND $F8)
C $9AC0,7 compute the grid column from screen X (C AND $F8, /8), combine into the cell index
C $9AC7,5 dedupe check: skip re-marking the same cell twice in a row (cache at $9ABB)
C $9ACC,3 update the cache, handling the increment-overflow edge case
C $9ACF,4 store the cache, L = cell index, H = 0
C $9AD3,3 Room grid address
C $9AD6,5 HL = grid cell address, read it, done (NC) if empty
C $9ADB,8 cache the value, branch away (blocked) if solid wall ($7F)
C $9AE3,8 HL = #R$7556 + value*2 (shape-pointer lookup)
C $9AEB,4 DE = the shape record pointer
C $9AEF,4 D = the object's height field (+0x07)
C $9AF3,5 E = D + the object's +0x16 field, minus 1 (in-cell position)
C $9AF8,3 C = $18 (loop threshold), B = shape record byte count
C $9AFB,2 jump into #R$9AFD's shape-walk loop
c $9AFD Terrain sub-cell shape resolver
N $9AFD Walks a #R$7556 shape record, deciding a partial collision against the object's position within the cell.
N $9AFD Called from #R$9ABC's grid collision test for non-wall, non-empty terrain codes. Walks the shape record's bytes as (key,threshold) style entries: each key is looked up in #R$74CE then #R$750B to get a threshold delta, accumulated and compared against the object's in-cell position (D). Depending on where the accumulated threshold lands relative to D, and whether the resulting shape value is found in a small buffer at $75AE, either returns "no block" (NC) or "blocked" (Carry set), and may SET bit 0 or bit 1 of the object's (IX+$0D) along the way -- exact in-game meaning of those bits (ledge? climbable edge?) not confirmed.
C $9AFD,4 test loop position against threshold C, skip ahead if before it
C $9B01,3 save HL/BC, A = this shape-record byte
C $9B0A,9 index the #R$750B table (3 bytes/entry), read its first byte
C $9B13,5 accumulate the running threshold (A += C), compare against D
C $9B18,8 branch on the comparison, storing the shape value on an exact match, then advance
C $9B20,4 test for a nonzero shape value, branch further away if set
C $9B24,3 *loop-advance: INC HL, DJNZ back to the top
C $9B27,6 loop exhausted: test the accumulated shape value, return unblocked if zero
C $9B2D,13 search the $75AE buffer for this shape value (count from $75B5)
C $9B3A,6 found: SET bit 1 of (IX+$0D), return unblocked
C $9B40,2 *shared exit: clear Carry, return (not blocked)
C $9B42,10 threshold-exceeded path: store the shape value, search the $75AE buffer
C $9B4C,10 CPIR search, SET bit 0 of (IX+$0D) if found
C $9B56,3 *shared exit: return with Carry set (blocked)
C $9B04,3 Search the (key,data) pair table at $74CE for key A
c $9B5A Collision/overlap scan
N $9B5A Walks the active object list looking for another same-room object whose bounding box (+$10..+$13) overlaps IX's; DE = the object found.
N $9B5A Per candidate (DE): skips self (DE==IX), skips a different room (+2 mismatch), skips a candidate with bit 7 of +0x0D set (an "inactive/ignore" flag), then does an AABB test between the candidate's and caller's +0x10..+0x13 boxes, then a depth/height check via +0x07 and +0x16. On a depth TIE specifically, hands off to #R$9BD4 instead of finishing here. On success: if the found object is not the player (#R$8DB6) and its bit 3 of +0x0D is set, SETs bit 0 of the CALLER's +0x0D (#R$9BD4's variant sets bit 1 instead) -- these look like "touching an interactive/solid object" markers, exact consumer not traced. Returns with DE = the found object, Carry set; NC if the list is exhausted with no match.
C $9B5A,3 HL = active object list head #R$610E
C $9B5D,3 *loop: DE = next record's link
C $9B60,3 return if list end (DE=0)
C $9B63,6 skip if candidate == caller (self)
C $9B69,7 HL = candidate + 2 (room field)
C $9B70,3 A = caller's room
C $9B73,4 compare against candidate's room, skip if different
C $9B77,9 skip if candidate's bit 7 of +0x0D is set (inactive)
C $9B80,18 AABB test: candidate's box vs caller's +0x10/+0x11
C $9B92,13 AABB test: candidate's box vs caller's +0x12/+0x13
C $9B9F,10 compute candidate depth (+0x16 + terrain byte at the +0x07 offset)
C $9BA9,7 compare against caller's depth (+0x07), hand off to #R$9BD4 on an exact tie
C $9BB0,11 depth check continued: skip if candidate is at or below the caller's height
C $9BBB,20 if candidate's bit 3 of +0x0D is set and it isn't the player, SET bit 0 of the caller's +0x0D
C $9BCF,3 match found: return with Carry set
b $9BD2
c $9BD4 Depth-tie resolver
N $9BD4 On an exact depth tie with a candidate object (DE), tests its blocking-tag flag and updates the mover's own flags before continuing the overlap scan at #R$9B5D.
C $9BD4,4 Set the mover's "touched something" flag (+0x14) = 1
C $9BD8,4 HL = the candidate object's flags field (+0x0D), addressed via DE
C $9BDC,2 Test bit 3, a blocking-tag flag
C $9BDE,2 If clear, skip the marker check and the flag-set below
C $9BE0,6 Compare the candidate object's address against the fixed marker $8DB6
C $9BE6,2 If it matches, skip the flag-set below
C $9BE8,4 Otherwise set bit 1 of the mover's own flags (+0x0D)
C $9BEC,4 Restore DE/HL and continue the object-overlap scan at $9B5D
c $9BF0 Collision test
N $9BF0 Checks the object's 4 bounding-box corners against the room grid, then checks for overlap with other objects.
N $9BF0 Tests all 4 corners of the object's bounding box (screen-coordinate pairs at +0x10/+0x11, +0x10/+0x13, +0x12/+0x13, +0x12/+0x11 -- i.e. (left,top)/(left,bottom)/(right,bottom)/(right,top)) via #R$9ABC, returning early (C) if any corner hits solid terrain. If all 4 corners are clear, finishes with #R$9B5A (object-vs-object overlap scan). Also calls #R$9A60 first and returns early if it reports collision (purpose of that specific pre-check not fully traced).
R $9BF0 IX ??
C $9BFC,3 Dynamic object finalizer
C $9C06,3 Terrain collision test for one screen point
C $9C10,3 Terrain collision test for one screen point
C $9C1A,3 Terrain collision test for one screen point
C $9C24,3 Terrain collision test for one screen point
C $9C2C,3 Collision/overlap scan
b $9C32
c $9C35 End-of-frame screen flip
N $9C35 Copies the shadow screen to the real ZX screen over the dirty bounding box ($6194-$6196), then redraws the room background.
N $9C35 Only copies the rectangle actually touched this frame (tracked by #R$7F9B/#R$835E's min/max bounds), using an unrolled 32-LDI row copy. Finishes with a one-shot sound cue and jumps to #R$69AC to redraw the room background.
C $9C35,21 restore a saved 3-byte clip value if flagged ($61A6), BC = bounding-box min tracker $6194
C $9C4A,25 compute the shadow-screen row/attribute address from the bounding-box top row, aligned to a cell boundary
C $9C63,4 HL = shadow screen base $4000 + the computed row offset
C $9C67,12 read the bounding-box min column, compute the byte-column offset, add it to HL, save the destination address at $9CBB
C $9C73,14 DE = the column byte-width, compute the shadow-screen row offset (*32)
C $9C85,15 compute the copy height from the bounding-box row range (max-min, rounded), abort if empty
C $9C94,3 divide the height by 8, save the row-group count at $9CC1
C $9C97,32 compute the copy width and per-row stride adjustments from the bounding-box column range, saving self-modified constants at $9D14/$9D0A
C $9CBA,3 DE = real screen base $4000
C $9CC0,8 A = row-group count, save it, jump into the unrolled copy with a self-modified byte count
C $9CC8,64 unrolled 32-LDI row copy (self-modified entry point handles partial widths)
C $9D08,7 advance the destination by the row stride
C $9D0F,7 BC = 32 (reset the LDI count), loop the row group
C $9D16,12 advance the shadow-screen source to the next row-group (screen-third wraparound)
C $9D22,5 loop the outer row-group count
C $9D27,12 one-shot: skip the sound/flag if $6193 is already set, else flag it and request sound effect $04
C $9D36,3 A = room colour
C $9C81,3 Shadow screen address
N $9CBA Copy shadow screen to ZX screen
C $9CBD,3 Shadow screen address
C $9D33,3 Request sound effect A
C $9D39,3 => Draw the room's background
b $9D3C
b $A400 Font 59 characters, 8 bytes each, 472 bytes
w $A5D8 Current mask sprite data address (set by #R$8128 before drawing)
b $A5DC Table of Sprites, 201 records, 4 bytes each
N $A5DC Record format (read by #R$84ED/#R$7E4F with the sprite number in L): record[0..1] = sprite data address (LE word); record[2] = height in 8px rows, top bit masked off before use ($7F) -- meaning of that bit not yet confirmed, may just be unused/reserved; record[3] = width in 8px columns, but bit 7 here is a live flip-flop flag: #R$7E4F XORs it in place (self-modifying table entry) on every call, toggling it between the two calls needed to draw a sprite's normal and mirrored/second-buffer image, then masks it off ($7F) to get the actual width.
W $A5DC,2 Sprite $00
B $A5DE,2
W $A5E0,2 Sprite $01
B $A5E2,2
W $A5E4,2 Sprite $02
B $A5E6,2
W $A5E8,2 Sprite $03
B $A5EA,2
W $A5EC,2 Sprite $04
B $A5EE,2
W $A5F0,2 Sprite $05
B $A5F2,2
W $A5F4,2 Sprite $06
B $A5F6,2
W $A5F8,2 Sprite $07
B $A5FA,2
W $A5FC,2 Sprite $08
B $A5FE,2
W $A600,2 Sprite $09
B $A602,2
W $A604,2 Sprite $0A
B $A606,2
W $A608,2 Sprite $0B
B $A60A,2
W $A60C,2 Sprite $0C
B $A60E,2
W $A610,2 Sprite $0D
B $A612,2
W $A614,2 Sprite $0E
B $A616,2
W $A618,2 Sprite $0F
B $A61A,2
W $A61C,2 Sprite $10
B $A61E,2
W $A620,2 Sprite $11
B $A622,2
W $A624,2 Sprite $12
B $A626,2
W $A628,2 Sprite $13
B $A62A,2
W $A62C,2 Sprite $14
B $A62E,2
W $A630,2 Sprite $15
B $A632,2
W $A634,2 Sprite $16
B $A636,2
W $A638,2 Sprite $17
B $A63A,2
W $A63C,2 Sprite $18
B $A63E,2
W $A640,2 Sprite $19
B $A642,2
W $A644,2 Sprite $1A
B $A646,2
W $A648,2 Sprite $1B
B $A64A,2
W $A64C,2 Sprite $1C
B $A64E,2
W $A650,2 Sprite $1D
B $A652,2
W $A654,2 Sprite $1E
B $A656,2
W $A658,2 Sprite $1F
B $A65A,2
W $A65C,2 Sprite $20
B $A65E,2
W $A660,2 Sprite $21
B $A662,2
W $A664,2 Sprite $22
B $A666,2
W $A668,2 Sprite $23
B $A66A,2
W $A66C,2 Sprite $24
B $A66E,2
W $A670,2 Sprite $25
B $A672,2
W $A674,2 Sprite $26
B $A676,2
W $A678,2 Sprite $27
B $A67A,2
W $A67C,2 Sprite $28
B $A67E,2
W $A680,2 Sprite $29
B $A682,2
W $A684,2 Sprite $2A
B $A686,2
W $A688,2 Sprite $2B
B $A68A,2
W $A68C,2 Sprite $2C
B $A68E,2
W $A690,2 Sprite $2D
B $A692,2
W $A694,2 Sprite $2E
B $A696,2
W $A698,2 Sprite $2F
B $A69A,2
W $A69C,2 Sprite $30
B $A69E,2
W $A6A0,2 Sprite $31
B $A6A2,2
W $A6A4,2 Sprite $32
B $A6A6,2
W $A6A8,2 Sprite $33
B $A6AA,2
W $A6AC,2 Sprite $34
B $A6AE,2
W $A6B0,2 Sprite $35
B $A6B2,2
W $A6B4,2 Sprite $36
B $A6B6,2
W $A6B8,2 Sprite $37
B $A6BA,2
W $A6BC,2 Sprite $38
B $A6BE,2
W $A6C0,2 Sprite $39
B $A6C2,2
W $A6C4,2 Sprite $3A
B $A6C6,2
W $A6C8,2 Sprite $3B
B $A6CA,2
W $A6CC,2 Sprite $3C
B $A6CE,2
W $A6D0,2 Sprite $3D
B $A6D2,2
W $A6D4,2 Sprite $3E
B $A6D6,2
W $A6D8,2 Sprite $3F
B $A6DA,2
W $A6DC,2 Sprite $40
B $A6DE,2
W $A6E0,2 Sprite $41
B $A6E2,2
W $A6E4,2 Sprite $42
B $A6E6,2
W $A6E8,2 Sprite $43
B $A6EA,2
W $A6EC,2 Sprite $44
B $A6EE,2
W $A6F0,2 Sprite $45
B $A6F2,2
W $A6F4,2 Sprite $46
B $A6F6,2
W $A6F8,2 Sprite $47
B $A6FA,2
W $A6FC,2 Sprite $48
B $A6FE,2
W $A700,2 Sprite $49
B $A702,2
W $A704,2 Sprite $4A
B $A706,2
W $A708,2 Sprite $4B
B $A70A,2
W $A70C,2 Sprite $4C
B $A70E,2
W $A710,2 Sprite $4D
B $A712,2
W $A714,2 Sprite $4E
B $A716,2
W $A718,2 Sprite $4F
B $A71A,2
W $A71C,2 Sprite $50
B $A71E,2
W $A720,2 Sprite $51
B $A722,2
W $A724,2 Sprite $52
B $A726,2
W $A728,2 Sprite $53
B $A72A,2
W $A72C,2 Sprite $54
B $A72E,2
W $A730,2 Sprite $55
B $A732,2
W $A734,2 Sprite $56
B $A736,2
W $A738,2 Sprite $57
B $A73A,2
W $A73C,2 Sprite $58
B $A73E,2
W $A740,2 Sprite $59
B $A742,2
W $A744,2 Sprite $5A
B $A746,2
W $A748,2 Sprite $5B
B $A74A,2
W $A74C,2 Sprite $5C
B $A74E,2
W $A750,2 Sprite $5D
B $A752,2
W $A754,2 Sprite $5E
B $A756,2
W $A758,2 Sprite $5F
B $A75A,2
W $A75C,2 Sprite $60
B $A75E,2
W $A760,2 Sprite $61
B $A762,2
W $A764,2 Sprite $62
B $A766,2
W $A768,2 Sprite $63
B $A76A,2
W $A76C,2 Sprite $64
B $A76E,2
W $A770,2 Sprite $65
B $A772,2
W $A774,2 Sprite $66
B $A776,2
W $A778,2 Sprite $67
B $A77A,2
W $A77C,2 Sprite $68
B $A77E,2
W $A780,2 Sprite $69
B $A782,2
W $A784,2 Sprite $6A
B $A786,2
W $A788,2 Sprite $6B
B $A78A,2
W $A78C,2 Sprite $6C
B $A78E,2
W $A790,2 Sprite $6D
B $A792,2
W $A794,2 Sprite $6E
B $A796,2
W $A798,2 Sprite $6F
B $A79A,2
W $A79C,2 Sprite $70
B $A79E,2
W $A7A0,2 Sprite $71
B $A7A2,2
W $A7A4,2 Sprite $72
B $A7A6,2
W $A7A8,2 Sprite $73
B $A7AA,2
W $A7AC,2 Sprite $74
B $A7AE,2
W $A7B0,2 Sprite $75
B $A7B2,2
W $A7B4,2 Sprite $76
B $A7B6,2
W $A7B8,2 Sprite $77
B $A7BA,2
W $A7BC,2 Sprite $78
B $A7BE,2
W $A7C0,2 Sprite $79
B $A7C2,2
W $A7C4,2 Sprite $7A
B $A7C6,2
W $A7C8,2 Sprite $7B
B $A7CA,2
W $A7CC,2 Sprite $7C
B $A7CE,2
W $A7D0,2 Sprite $7D
B $A7D2,2
W $A7D4,2 Sprite $7E
B $A7D6,2
W $A7D8,2 Sprite $7F
B $A7DA,2
W $A7DC,2 Sprite $80
B $A7DE,2
W $A7E0,2 Sprite $81
B $A7E2,2
W $A7E4,2 Sprite $82
B $A7E6,2
W $A7E8,2 Sprite $83
B $A7EA,2
W $A7EC,2 Sprite $84
B $A7EE,2
W $A7F0,2 Sprite $85
B $A7F2,2
W $A7F4,2 Sprite $86
B $A7F6,2
W $A7F8,2 Sprite $87
B $A7FA,2
W $A7FC,2 Sprite $88
B $A7FE,2
W $A800,2 Sprite $89
B $A802,2
W $A804,2 Sprite $8A
B $A806,2
W $A808,2 Sprite $8B
B $A80A,2
W $A80C,2 Sprite $8C
B $A80E,2
W $A810,2 Sprite $8D
B $A812,2
W $A814,2 Sprite $8E
B $A816,2
W $A818,2 Sprite $8F
B $A81A,2
W $A81C,2 Sprite $90
B $A81E,2
W $A820,2 Sprite $91
B $A822,2
W $A824,2 Sprite $92
B $A826,2
W $A828,2 Sprite $93
B $A82A,2
W $A82C,2 Sprite $94
B $A82E,2
W $A830,2 Sprite $95
B $A832,2
W $A834,2 Sprite $96
B $A836,2
W $A838,2 Sprite $97
B $A83A,2
W $A83C,2 Sprite $98
B $A83E,2
W $A840,2 Sprite $99
B $A842,2
W $A844,2 Sprite $9A
B $A846,2
W $A848,2 Sprite $9B
B $A84A,2
W $A84C,2 Sprite $9C
B $A84E,2
W $A850,2 Sprite $9D
B $A852,2
W $A854,2 Sprite $9E
B $A856,2
W $A858,2 Sprite $9F
B $A85A,2
W $A85C,2 Sprite $A0
B $A85E,2
W $A860,2 Sprite $A1
B $A862,2
W $A864,2 Sprite $A2
B $A866,2
W $A868,2 Sprite $A3
B $A86A,2
W $A86C,2 Sprite $A4
B $A86E,2
W $A870,2 Sprite $A5
B $A872,2
W $A874,2 Sprite $A6
B $A876,2
W $A878,2 Sprite $A7
B $A87A,2
W $A87C,2 Sprite $A8
B $A87E,2
W $A880,2 Sprite $A9
B $A882,2
W $A884,2 Sprite $AA
B $A886,2
W $A888,2 Sprite $AB
B $A88A,2
W $A88C,2 Sprite $AC
B $A88E,2
W $A890,2 Sprite $AD
B $A892,2
W $A894,2 Sprite $AE
B $A896,2
W $A898,2 Sprite $AF
B $A89A,2
W $A89C,2 Sprite $B0
B $A89E,2
W $A8A0,2 Sprite $B1
B $A8A2,2
W $A8A4,2 Sprite $B2
B $A8A6,2
W $A8A8,2 Sprite $B3
B $A8AA,2
W $A8AC,2 Sprite $B4
B $A8AE,2
W $A8B0,2 Sprite $B5
B $A8B2,2
W $A8B4,2 Sprite $B6
B $A8B6,2
W $A8B8,2 Sprite $B7
B $A8BA,2
W $A8BC,2 Sprite $B8
B $A8BE,2
W $A8C0,2 Sprite $B9
B $A8C2,2
W $A8C4,2 Sprite $BA
B $A8C6,2
W $A8C8,2 Sprite $BB
B $A8CA,2
W $A8CC,2 Sprite $BC
B $A8CE,2
W $A8D0,2 Sprite $BD
B $A8D2,2
W $A8D4,2 Sprite $BE
B $A8D6,2
W $A8D8,2 Sprite $BF
B $A8DA,2
W $A8DC,2 Sprite $C0
B $A8DE,2
W $A8E0,2 Sprite $C1
B $A8E2,2
W $A8E4,2 Sprite $C2
B $A8E6,2
W $A8E8,2 Sprite $C3
B $A8EA,2
W $A8EC,2 Sprite $C4
B $A8EE,2
W $A8F0,2 Sprite $C5
B $A8F2,2
W $A8F4,2 Sprite $C6
B $A8F6,2
W $A8F8,2 Sprite $C7
B $A8FA,2
W $A8FC,2 Sprite $C8
B $A8FE,2
b $A900 Dynamic object pool (creatures, bubble sources, snakes, whirlpools, plugs -- anything not baked into the static room grid; see #R$612C)
N $A900 Records allocated/freed via a linked list managed by #R$84AE (free-list head at $618B; the free list can extend outside this pool, e.g. into scratch at $5B00). Record layout (24 bytes, offsets from record start): +0/+1 = link to the next object record in the active object list (head at #R$610E; the list ends via the fixed records at #R$8DB6 -- the player record uses this same layout); +2 = room number the object belongs to; +3/+4 = per-object behaviour-handler function pointer, copied by #R$84AE from the 2 bytes embedded after the spawner's CALL; +5/+6 = Y/X position; +8 = current sprite number; +5..+23 initially a fixed 19-byte default state block copied from $5C92; +7=$18 and +0xA=$06 (constants set by #R$8EA7-style spawn routines); +9 = triggering grid value (e.g. $66), cleared to 0 by #R$9A60; +0xB and +0xE = a duplicated "extra" byte from the template; +0xF = animation phase counter (used by #R$99D5); +0x14 = a second "extra" byte. The exact meaning of the two "extra" bytes (position? direction?) is not yet confirmed.
b $A92C
W $A92C,,16
b $A9DE Sprite, 24x32 pixels. Player sitting
B $A9DE,96,8 #HTML[#UDGARRAY3,,,3,,($A9DE-$AA3D-1-24)(sprite-a9de)]
b $AA3E Sprite, 32x24 pixels. Player
B $AA3E,96,8 #HTML[#UDGARRAY4,,,4,,($AA3E-$AA9D-1-32)(sprite-aa3e)]
b $AA9E Sprite, 32x24 pixels. Player
B $AA9E,96,8 #HTML[#UDGARRAY4,,,4,,($AA9E-$AAFD-1-32)(sprite-aa9e)]
b $AAFE Sprite, 32x24 pixels. Player
B $AAFE,96,8 #HTML[#UDGARRAY4,,,4,,($AAFE-$AB5D-1-32)(sprite-aafe)]
b $AB5E Sprite, 32x24 pixels. Player
B $AB5E,96,8 #HTML[#UDGARRAY4,,,4,,($AB5E-$ABBD-1-32)(sprite-ab5e)]
b $ABBE Sprite, 32x24 pixels. Player laying on back, hands up
B $ABBE,96,8 #HTML[#UDGARRAY4,,,4,,($ABBE-$AC1D-1-32)(sprite-abbe)]
b $AC1E Sprite, 32x24 pixels. Player laying on back, dead
B $AC1E,96,8 #HTML[#UDGARRAY4,,,4,,($AC1E-$AC7D-1-32)(sprite-ac1e)]
b $AC7E Sprite, 32x24 pixels. Player
B $AC7E,96,8 #HTML[#UDGARRAY4,,,4,,($AC7E-$ACDD-1-32)(sprite-ac7e)]
b $ACDE Sprite, 32x16 pixels. Player shadow
B $ACDE,64,8 #HTML[#UDGARRAY4,,,4,,($ACDE-$AD1D-1-32)(sprite-acde)]
b $AD1E Sprite, 32x16 pixels. Player shadow
B $AD1E,64,8 #HTML[#UDGARRAY4,,,4,,($AD1E-$AD5D-1-32)(sprite-ad1e)]
b $AD5E Sprite, 32x16 pixels. Player shadow
B $AD5E,64,8 #HTML[#UDGARRAY4,,,4,,($AD5E-$AD9D-1-32)(sprite-ad5e)]
b $AD9E Sprite, 32x16 pixels. Player shadow
B $AD9E,64,8 #HTML[#UDGARRAY4,,,4,,($AD9E-$ADDD-1-32)(sprite-ad9e)]
b $ADDE Sprite, 24x24 pixels. Fish cloud
B $ADDE,72,8 #HTML[#UDGARRAY3,,,3,,($ADDE-$AE25-1-24)(sprite-adde)]
b $AE26 Sprite, 24x24 pixels. Fish cloud
B $AE26,72,8 #HTML[#UDGARRAY3,,,3,,($AE26-$AE6D-1-24)(sprite-ae26)]
b $AE6E Sprite, 24x32 pixels. Jellyfish
B $AE6E,96,8 #HTML[#UDGARRAY3,,,3,,($AE6E-$AECD-1-24)(sprite-ae6e)]
b $AECE Sprite, 24x32 pixels. Jellyfish
B $AECE,96,8 #HTML[#UDGARRAY3,,,3,,($AECE-$AF2D-1-24)(sprite-aece)]
b $AF2E Sprite, 24x32 pixels. Jellyfish
B $AF2E,96,8 #HTML[#UDGARRAY3,,,3,,($AF2E-$AF8D-1-24)(sprite-af2e)]
b $AF8E Sprite, 24x24 pixels. Fish cloud
B $AF8E,72,8 #HTML[#UDGARRAY3,,,3,,($AF8E-$AFD5-1-24)(sprite-af8e)]
b $AFD6 Sprite, 24x32 pixels. Jellyfish
B $AFD6,96,8 #HTML[#UDGARRAY3,,,3,,($AFD6-$B035-1-24)(sprite-afd6)]
b $B036 Sprite, 32x24 pixels. Player
B $B036,96,8 #HTML[#UDGARRAY4,,,4,,($B036-$B095-1-32)(sprite-b036)]
b $B096 Sprite, 32x24 pixels. Player
B $B096,96,8 #HTML[#UDGARRAY4,,,4,,($B096-$B0F5-1-32)(sprite-b096)]
b $B0F6 Sprite, 32x24 pixels. Player
B $B0F6,96,8 #HTML[#UDGARRAY4,,,4,,($B0F6-$B155-1-32)(sprite-b0f6)]
b $B156 Sprite, 32x24 pixels. Player
B $B156,96,8 #HTML[#UDGARRAY4,,,4,,($B156-$B1B5-1-32)(sprite-b156)]
b $B1B6 Sprite, 32x32 pixels. Explosion
B $B1B6,128,8 #HTML[#UDGARRAY4,,,4,,($B1B6-$B235-1-32)(sprite-b1b6)]
b $B236 Sprite, 32x24 pixels. Explosion
B $B236,96,8 #HTML[#UDGARRAY4,,,4,,($B236-$B295-1-32)(sprite-b236)]
b $B296 Sprite, 16x24 pixels. Explosion small
B $B296,48,8 #HTML[#UDGARRAY2,,,2,,($B296-$B2C5-1-16)(sprite-b296)]
b $B2C6 Sprite, 24x24 pixels. Fish cloud
B $B2C6,72,8 #HTML[#UDGARRAY3,,,3,,($B2C6-$B30D-1-24)(sprite-b2c6)]
b $B30E Sprite, 32x24 pixels. Player
B $B30E,96,8 #HTML[#UDGARRAY4,,,4,,($B30E-$B36D-1-32)(sprite-b30e)]
b $B36E Sprite, 32x32 pixels. Fish
B $B36E,128,8 #HTML[#UDGARRAY4,,,4,,($B36E-$B3ED-1-32)(sprite-b36e)]
b $B3EE Sprite, 32x32 pixels. Fish
B $B3EE,128,8 #HTML[#UDGARRAY4,,,4,,($B3EE-$B46D-1-32)(sprite-b3ee)]
b $B46E Sprite, 32x32 pixels. Fish
B $B46E,128,8 #HTML[#UDGARRAY4,,,4,,($B46E-$B4ED-1-32)(sprite-b46e)]
b $B4EE Sprite, 32x32 pixels. Fish
B $B4EE,128,8 #HTML[#UDGARRAY4,,,4,,($B4EE-$B56D-1-32)(sprite-b4ee)]
b $B56E Sprite, 16x8 pixels. Snake, rearing phase
B $B56E,16,8 #HTML[#UDGARRAY2,,,2,,($B56E-$B57D-1-16)(sprite-b56e)]
b $B57E Sprite, 16x16 pixels. Snake, rearing phase
B $B57E,32,8 #HTML[#UDGARRAY2,,,2,,($B57E-$B59D-1-16)(sprite-b57e)]
b $B59E Sprite, 16x24 pixels. Snake, rearing phase
B $B59E,48,8 #HTML[#UDGARRAY2,,,2,,($B59E-$B5CD-1-16)(sprite-b59e)]
b $B5CE Sprite, 16x32 pixels. Snake, rearing phase
B $B5CE,64,8 #HTML[#UDGARRAY2,,,2,,($B5CE-$B60D-1-16)(sprite-b5ce)]
b $B60E Sprite, 16x32 pixels. Sea Horse
B $B60E,64,8 #HTML[#UDGARRAY2,,,2,,($B60E-$B64D-1-16)(sprite-b60e)]
b $B64E Sprite, 16x32 pixels. Sea Horse
B $B64E,64,8 #HTML[#UDGARRAY2,,,2,,($B64E-$B68D-1-16)(sprite-b64e)]
b $B68E Sprite, 32x32 pixels. Baby whale
B $B68E,128,8 #HTML[#UDGARRAY4,,,4,,($B68E-$B70D-1-32)(sprite-b68e)]
b $B70E Sprite, 32x32 pixels. Baby whale
B $B70E,128,8 #HTML[#UDGARRAY4,,,4,,($B70E-$B78D-1-32)(sprite-b70e)]
b $B78E Sprite, 32x32 pixels. Baby whale
B $B78E,128,8 #HTML[#UDGARRAY4,,,4,,($B78E-$B80D-1-32)(sprite-b78e)]
b $B80E Sprite, 32x32 pixels. Baby whale
B $B80E,128,8 #HTML[#UDGARRAY4,,,4,,($B80E-$B88D-1-32)(sprite-b80e)]
b $B88E Sprite, 16x24 pixels. Gnome item
B $B88E,48,8 #HTML[#UDGARRAY2,,,2,,($B88E-$B8BD-1-16)(sprite-b88e)]
b $B8BE Mask, 16x24 pixels. Gnome item
B $B8BE,48,8 #HTML[#UDGARRAY2,,,2,,($B8BE-$B8ED-1-16)(sprite-b8be)]
b $B8EE Sprite, 16x24 pixels. Bucket item
B $B8EE,48,8 #HTML[#UDGARRAY2,,,2,,($B8EE-$B91D-1-16)(sprite-b8ee)]
b $B91E Mask, 16x24 pixels. Bucket item
B $B91E,48,8 #HTML[#UDGARRAY2,,,2,,($B91E-$B94D-1-16)(sprite-b91e)]
b $B94E Sprite, 16x24 pixels. Tin item
B $B94E,48,8 #HTML[#UDGARRAY2,,,2,,($B94E-$B97D-1-16)(sprite-b94e)]
b $B97E Mask, 16x24 pixels. Tin item
B $B97E,48,8 #HTML[#UDGARRAY2,,,2,,($B97E-$B9AD-1-16)(sprite-b97e)]
b $B9AE Sprite, 16x24 pixels. Key item
B $B9AE,48,8 #HTML[#UDGARRAY2,,,2,,($B9AE-$B9DD-1-16)(sprite-b9ae)]
b $B9DE Mask, 16x24 pixels. Key item
B $B9DE,48,8 #HTML[#UDGARRAY2,,,2,,($B9DE-$BA0D-1-16)(sprite-b9de)]
b $BA0E Sprite, 16x24 pixels. Horseshoe item (weapon; kills Sea Horses)
B $BA0E,48,8 #HTML[#UDGARRAY2,,,2,,($BA0E-$BA3D-1-16)(sprite-ba0e)]
b $BA3E Mask, 16x24 pixels. Horseshoe item
B $BA3E,48,8 #HTML[#UDGARRAY2,,,2,,($BA3E-$BA6D-1-16)(sprite-ba3e)]
b $BA6E Sprite, 16x24 pixels. Bone item (lures fish shoals away)
B $BA6E,48,8 #HTML[#UDGARRAY2,,,2,,($BA6E-$BA9D-1-16)(sprite-ba6e)]
b $BA9E Mask, 16x24 pixels. Bone item
B $BA9E,48,8 #HTML[#UDGARRAY2,,,2,,($BA9E-$BACD-1-16)(sprite-ba9e)]
b $BACE Sprite, 16x24 pixels. Boot item
B $BACE,48,8 #HTML[#UDGARRAY2,,,2,,($BACE-$BAFD-1-16)(sprite-bace)]
b $BAFE Mask, 16x24 pixels. Boot item
B $BAFE,48,8 #HTML[#UDGARRAY2,,,2,,($BAFE-$BB2D-1-16)(sprite-bafe)]
b $BB2E Sprite, 32x32 pixels. Treasure chest
B $BB2E,128,8 #HTML[#UDGARRAY4,,,4,,($BB2E-$BBAD-1-32)(sprite-bb2e)]
b $BBAE Mask, 32x32 pixels. Treasure chest
B $BBAE,128,8 #HTML[#UDGARRAY4,,,4,,($BBAE-$BC2D-1-32)(sprite-bbae)]
b $BC2E Sprite, 16x32 pixels. Rock
B $BC2E,64,8 #HTML[#UDGARRAY2,,,2,,($BC2E-$BC6D-1-16)(sprite-bc2e)]
b $BC6E Mask, 16x32 pixels. Rock
B $BC6E,64,8 #HTML[#UDGARRAY2,,,2,,($BC6E-$BCAD-1-16)(sprite-bc6e)]
b $BCAE Sprite, 32x24 pixels. Plug
B $BCAE,96,8 #HTML[#UDGARRAY4,,,4,,($BCAE-$BD0D-1-32)(sprite-bcae)]
b $BD0E Mask, 32x24 pixels. Plug
B $BD0E,96,8 #HTML[#UDGARRAY4,,,4,,($BD0E-$BD6D-1-32)(sprite-bd0e)]
b $BD6E Sprite, 16x16 pixels. Seaweed sprig
B $BD6E,32,8 #HTML[#UDGARRAY2,,,2,,($BD6E-$BD8D-1-16)(sprite-bd6e)]
b $BD8E Mask, 16x16 pixels. Seaweed sprig
B $BD8E,32,8 #HTML[#UDGARRAY2,,,2,,($BD8E-$BDAD-1-16)(sprite-bd8e)]
b $BDAE Sprite, 32x16 pixels. Whirlpool, animation phase 1
B $BDAE,64,8 #HTML[#UDGARRAY4,,,4,,($BDAE-$BDED-1-32)(sprite-bdae)]
b $BDEE Sprite, 32x16 pixels. Whirlpool, animation phase 2
B $BDEE,64,8 #HTML[#UDGARRAY4,,,4,,($BDEE-$BE2D-1-32)(sprite-bdee)]
b $BE2E Sprite, 24x32 pixels. Plant/coral
B $BE2E,96,8 #HTML[#UDGARRAY3,,,3,,($BE2E-$BE8D-1-24)(sprite-be2e)]
b $BE8E Mask, 24x32 pixels. Plant/coral
B $BE8E,96,8 #HTML[#UDGARRAY3,,,3,,($BE8E-$BEED-1-24)(sprite-be8e)]
b $BEEE Sprite, 24x32 pixels. Plant/coral
B $BEEE,96,8 #HTML[#UDGARRAY3,,,3,,($BEEE-$BF4D-1-24)(sprite-beee)]
b $BF4E Mask, 24x32 pixels. Plant/coral
B $BF4E,96,8 #HTML[#UDGARRAY3,,,3,,($BF4E-$BFAD-1-24)(sprite-bf4e)]
b $BFAE Sprite, 32x16 pixels. Closed clam shell
B $BFAE,64,8 #HTML[#UDGARRAY4,,,4,,($BFAE-$BFED-1-32)(sprite-bfae)]
b $BFEE Mask, 32x16 pixels. Closed clam shell
B $BFEE,64,8 #HTML[#UDGARRAY4,,,4,,($BFEE-$C02D-1-32)(sprite-bfee)]
b $C02E Sprite, 32x32 pixels. Open clam shell
B $C02E,128,8 #HTML[#UDGARRAY4,,,4,,($C02E-$C0AD-1-32)(sprite-c02e)]
b $C0AE Mask, 32x32 pixels. Open clam shell
B $C0AE,128,8 #HTML[#UDGARRAY4,,,4,,($C0AE-$C12D-1-32)(sprite-c0ae)]
b $C12E Sprite, 16x40 pixels. Seaweed
B $C12E,80,8 #HTML[#UDGARRAY2,,,2,,($C12E-$C17D-1-16)(sprite-c12e)]
b $C17E Mask, 16x40 pixels. Seaweed
B $C17E,80,8 #HTML[#UDGARRAY2,,,2,,($C17E-$C1CD-1-16)(sprite-c17e)]
b $C1CE Sprite, 16x16 pixels. Small rock
B $C1CE,32,8 #HTML[#UDGARRAY2,,,2,,($C1CE-$C1ED-1-16)(sprite-c1ce)]
b $C1EE Mask, 16x16 pixels. Small rock
B $C1EE,32,8 #HTML[#UDGARRAY2,,,2,,($C1EE-$C20D-1-16)(sprite-c1ee)]
b $C20E Sprite, 8x24 pixels. Small debris/particle
B $C20E,24,8 #HTML[#UDGARRAY1,,,1,,($C20E-$C225-1-8)(sprite-c20e)]
b $C226 Sprite, 8x24 pixels. Small debris/particle
B $C226,24,8 #HTML[#UDGARRAY1,,,1,,($C226-$C23D-1-8)(sprite-c226)]
b $C23E Sprite, 8x24 pixels. Small debris/particle
B $C23E,24,8 #HTML[#UDGARRAY1,,,1,,($C23E-$C255-1-8)(sprite-c23e)]
b $C256 Sprite, 8x24 pixels. Small debris/particle
B $C256,24,8 #HTML[#UDGARRAY1,,,1,,($C256-$C26D-1-8)(sprite-c256)]
b $C26E Sprite, 16x16 pixels. Disc/wheel
B $C26E,32,8 #HTML[#UDGARRAY2,,,2,,($C26E-$C28D-1-16)(sprite-c26e)]
b $C28E Sprite, 16x16 pixels. Disc/wheel
B $C28E,32,8 #HTML[#UDGARRAY2,,,2,,($C28E-$C2AD-1-16)(sprite-c28e)]
b $C2AE Sprite, 16x16 pixels. Disc/wheel
B $C2AE,32,8 #HTML[#UDGARRAY2,,,2,,($C2AE-$C2CD-1-16)(sprite-c2ae)]
b $C2CE Sprite, 16x16 pixels. Disc/wheel
B $C2CE,32,8 #HTML[#UDGARRAY2,,,2,,($C2CE-$C2ED-1-16)(sprite-c2ce)]
b $C2EE Sprite, 16x16 pixels. Disc/wheel
B $C2EE,32,8 #HTML[#UDGARRAY2,,,2,,($C2EE-$C30D-1-16)(sprite-c2ee)]
b $C30E Sprite, 16x16 pixels. Disc/wheel
B $C30E,32,8 #HTML[#UDGARRAY2,,,2,,($C30E-$C32D-1-16)(sprite-c30e)]
b $C32E Sprite, 16x16 pixels. Small stars
B $C32E,32,8 #HTML[#UDGARRAY2,,,2,,($C32E-$C34D-1-16)(sprite-c32e)]
b $C34E Sprite, 16x16 pixels. Small stars
B $C34E,32,8 #HTML[#UDGARRAY2,,,2,,($C34E-$C36D-1-16)(sprite-c34e)]
b $C36E Sprite, 16x16 pixels. Small stars disappearing
B $C36E,32,8 #HTML[#UDGARRAY2,,,2,,($C36E-$C38D-1-16)(sprite-c36e)]
b $C38E Sprite $68, 16x8 pixels. Bubble source object #R$957C, animation frame 1
B $C38E,16,8 #HTML[#UDGARRAY2,,,2,,($C38E-$C39D-1-16)(sprite-c38e)]
b $C39E Sprite $69, 16x8 pixels. Bubble source object #R$957C, animation frame 2
B $C39E,16,8 #HTML[#UDGARRAY2,,,2,,($C39E-$C3AD-1-16)(sprite-c39e)]
b $C3AE Sprite, 32x32 pixels. Urn/well with seaweed
B $C3AE,128,8 #HTML[#UDGARRAY4,,,4,,($C3AE-$C42D-1-32)(sprite-c3ae)]
b $C42E Mask, 32x32 pixels. Urn/well with seaweed
B $C42E,128,8 #HTML[#UDGARRAY4,,,4,,($C42E-$C4AD-1-32)(sprite-c42e)]
b $C4AE Sprite, 32x32 pixels. Clam shell with pearl
B $C4AE,128,8 #HTML[#UDGARRAY4,,,4,,($C4AE-$C52D-1-32)(sprite-c4ae)]
b $C52E Sprite, 16x24 pixels. Empty/unused frame
B $C52E,48,8 #HTML[#UDGARRAY2,,,2,,($C52E-$C55D-1-16)(sprite-c52e)]
b $C55E Sprite, 16x24 pixels. Oil can (anti-rust oil, refills Sweevo's suit)
B $C55E,48,8 #HTML[#UDGARRAY2,,,2,,($C55E-$C58D-1-16)(sprite-c55e)]
b $C58E Mask, 16x24 pixels. Oil can
B $C58E,48,8 #HTML[#UDGARRAY2,,,2,,($C58E-$C5BD-1-16)(sprite-c58e)]
b $C5BE Sprite, 16x24 pixels. Shell item
B $C5BE,48,8 #HTML[#UDGARRAY2,,,2,,($C5BE-$C5ED-1-16)(sprite-c5be)]
b $C5EE Mask, 16x24 pixels. Shell item
B $C5EE,48,8 #HTML[#UDGARRAY2,,,2,,($C5EE-$C61D-1-16)(sprite-c5ee)]
b $C61E Sprite, 16x24 pixels. Harpoon item
B $C61E,48,8 #HTML[#UDGARRAY2,,,2,,($C61E-$C64D-1-16)(sprite-c61e)]
b $C64E Mask, 16x24 pixels. Harpoon item
B $C64E,48,8 #HTML[#UDGARRAY2,,,2,,($C64E-$C67D-1-16)(sprite-c64e)]
b $C67E Sprite, 16x24 pixels. Spoon item (weapon; kills Jellyfish)
B $C67E,48,8 #HTML[#UDGARRAY2,,,2,,($C67E-$C6AD-1-16)(sprite-c67e)]
b $C6AE Mask, 16x24 pixels. Spoon item
B $C6AE,48,8 #HTML[#UDGARRAY2,,,2,,($C6AE-$C6DD-1-16)(sprite-c6ae)]
b $C6DE Sprite, 16x24 pixels. Ball or pearl
B $C6DE,48,8 #HTML[#UDGARRAY2,,,2,,($C6DE-$C70D-1-16)(sprite-c6de)]
b $C70E Mask, 16x24 pixels. Ball or pearl
B $C70E,48,8 #HTML[#UDGARRAY2,,,2,,($C70E-$C73D-1-16)(sprite-c70e)]
b $C73E Sprite, 16x24 pixels. Item icon, unidentified
B $C73E,48,8 #HTML[#UDGARRAY2,,,2,,($C73E-$C76D-1-16)(sprite-c73e)]
b $C76E Mask, 16x24 pixels. Item icon, unidentified
B $C76E,48,8 #HTML[#UDGARRAY2,,,2,,($C76E-$C79D-1-16)(sprite-c76e)]
b $C79E Sprite, 16x24 pixels. Item icon, unidentified
B $C79E,48,8 #HTML[#UDGARRAY2,,,2,,($C79E-$C7CD-1-16)(sprite-c79e)]
b $C7CE Mask, 16x24 pixels. Item icon, unidentified
B $C7CE,48,8 #HTML[#UDGARRAY2,,,2,,($C7CE-$C7FD-1-16)(sprite-c7ce)]
b $C7FE Sprite, 40x24 pixels. Wall
B $C7FE,120,8 #HTML[#UDGARRAY5,,,5,,($C7FE-$C875-1-40)(sprite-c7fe)]
b $C876 Sprite, 40x96 pixels. Wall
B $C876,480,8 #HTML[#UDGARRAY5,,,5,,($C876-$CA55-1-40)(sprite-c876)]
b $CA56 Sprite, 48x96 pixels. Wall
B $CA56,576,8 #HTML[#UDGARRAY6,,,6,,($CA56-$CC95-1-48)(sprite-ca56)]
b $CC96 Sprite, 40x80 pixels. Wall
B $CC96,400,8 #HTML[#UDGARRAY5,,,5,,($CC96-$CE25-1-40)(sprite-cc96)]
b $CE26 Sprite, 8x160 pixels. Font: alphanumeric character set, used for HUD/score text (not a game sprite)
B $CE26,160,8 #HTML[#UDGARRAY1,,,1,,($CE26-$CEC5-1-8)(sprite-ce26)]
b $CEC6 Mask, 24x32 pixels. Diver silhouette
B $CEC6,96,8 #HTML[#UDGARRAY3,,,3,,($CEC6-$CF25-1-24)(sprite-cec6)]
b $CF26 Mask, 32x24 pixels.
B $CF26,96,8 #HTML[#UDGARRAY4,,,4,,($CF26-$CF85-1-32)(sprite-cf26)]
b $CF86 Mask, 32x24 pixels.
B $CF86,96,8 #HTML[#UDGARRAY4,,,4,,($CF86-$CFE5-1-32)(sprite-cf86)]
b $CFE6 Mask, 32x24 pixels.
B $CFE6,96,8 #HTML[#UDGARRAY4,,,4,,($CFE6-$D045-1-32)(sprite-cfe6)]
b $D046 Mask, 32x24 pixels.
B $D046,96,8 #HTML[#UDGARRAY4,,,4,,($D046-$D0A5-1-32)(sprite-d046)]
b $D0A6 Mask, 32x24 pixels.
B $D0A6,96,8 #HTML[#UDGARRAY4,,,4,,($D0A6-$D105-1-32)(sprite-d0a6)]
b $D106 Mask, 32x24 pixels.
B $D106,96,8 #HTML[#UDGARRAY4,,,4,,($D106-$D165-1-32)(sprite-d106)]
b $D166 Mask, 32x24 pixels.
B $D166,96,8 #HTML[#UDGARRAY4,,,4,,($D166-$D1C5-1-32)(sprite-d166)]
b $D1C6 Mask, 24x24 pixels. Fish cloud
B $D1C6,72,8 #HTML[#UDGARRAY3,,,3,,($D1C6-$D20D-1-24)(sprite-d1c6)]
b $D20E Mask, 24x24 pixels. Fish cloud
B $D20E,72,8 #HTML[#UDGARRAY3,,,3,,($D20E-$D255-1-24)(sprite-d20e)]
b $D256 Mask, 24x32 pixels. Jellyfish
B $D256,96,8 #HTML[#UDGARRAY3,,,3,,($D256-$D2B5-1-24)(sprite-d256)]
b $D2B6 Mask, 24x32 pixels. Jellyfish
B $D2B6,96,8 #HTML[#UDGARRAY3,,,3,,($D2B6-$D315-1-24)(sprite-d2b6)]
b $D316 Mask, 24x32 pixels. Jellyfish
B $D316,96,8 #HTML[#UDGARRAY3,,,3,,($D316-$D375-1-24)(sprite-d316)]
b $D376 Mask, 24x24 pixels. Fish cloud
B $D376,72,8 #HTML[#UDGARRAY3,,,3,,($D376-$D3BD-1-24)(sprite-d376)]
b $D3BE Mask, 24x32 pixels. Jellyfish
B $D3BE,96,8 #HTML[#UDGARRAY3,,,3,,($D3BE-$D41D-1-24)(sprite-d3be)]
b $D41E Mask, 32x24 pixels.
B $D41E,96,8 #HTML[#UDGARRAY4,,,4,,($D41E-$D47D-1-32)(sprite-d41e)]
b $D47E Mask, 32x24 pixels.
B $D47E,96,8 #HTML[#UDGARRAY4,,,4,,($D47E-$D4DD-1-32)(sprite-d47e)]
b $D4DE Mask, 32x24 pixels.
B $D4DE,96,8 #HTML[#UDGARRAY4,,,4,,($D4DE-$D53D-1-32)(sprite-d4de)]
b $D53E Mask, 32x24 pixels.
B $D53E,96,8 #HTML[#UDGARRAY4,,,4,,($D53E-$D59D-1-32)(sprite-d53e)]
b $D59E Mask, 32x32 pixels. Round
B $D59E,128,8 #HTML[#UDGARRAY4,,,4,,($D59E-$D61D-1-32)(sprite-d59e)]
b $D61E Mask, 32x24 pixels.
B $D61E,96,8 #HTML[#UDGARRAY4,,,4,,($D61E-$D67D-1-32)(sprite-d61e)]
b $D67E Mask, 16x24 pixels.
B $D67E,48,8 #HTML[#UDGARRAY2,,,2,,($D67E-$D6AD-1-16)(sprite-d67e)]
b $D6AE Mask, 24x24 pixels. Fish cloud
B $D6AE,72,8 #HTML[#UDGARRAY3,,,3,,($D6AE-$D6F5-1-24)(sprite-d6ae)]
b $D6F6 Mask, 32x24 pixels.
B $D6F6,96,8 #HTML[#UDGARRAY4,,,4,,($D6F6-$D755-1-32)(sprite-d6f6)]
b $D756 Mask, 32x32 pixels. Round
B $D756,128,8 #HTML[#UDGARRAY4,,,4,,($D756-$D7D5-1-32)(sprite-d756)]
b $D7D6 Mask, 32x32 pixels. Round
B $D7D6,128,8 #HTML[#UDGARRAY4,,,4,,($D7D6-$D855-1-32)(sprite-d7d6)]
b $D856 Mask, 32x32 pixels. Round
B $D856,128,8 #HTML[#UDGARRAY4,,,4,,($D856-$D8D5-1-32)(sprite-d856)]
b $D8D6 Mask, 32x32 pixels. Round
B $D8D6,128,8 #HTML[#UDGARRAY4,,,4,,($D8D6-$D955-1-32)(sprite-d8d6)]
b $D956 Mask, 16x8 pixels. Snake, rearing phase
B $D956,16,8 #HTML[#UDGARRAY2,,,2,,($D956-$D965-1-16)(sprite-d956)]
b $D966 Mask, 16x16 pixels. Snake, rearing phase
B $D966,32,8 #HTML[#UDGARRAY2,,,2,,($D966-$D985-1-16)(sprite-d966)]
b $D986 Mask, 16x24 pixels. Snake, rearing phase
B $D986,48,8 #HTML[#UDGARRAY2,,,2,,($D986-$D9B5-1-16)(sprite-d986)]
b $D9B6 Mask, 16x32 pixels. Snake, rearing phase
B $D9B6,64,8 #HTML[#UDGARRAY2,,,2,,($D9B6-$D9F5-1-16)(sprite-d9b6)]
b $D9F6 Mask, 16x32 pixels. Sea Horse
B $D9F6,64,8 #HTML[#UDGARRAY2,,,2,,($D9F6-$DA35-1-16)(sprite-d9f6)]
b $DA36 Mask, 16x32 pixels. Sea Horse
B $DA36,64,8 #HTML[#UDGARRAY2,,,2,,($DA36-$DA75-1-16)(sprite-da36)]
b $DA76 Mask, 32x32 pixels. Baby whale
B $DA76,128,8 #HTML[#UDGARRAY4,,,4,,($DA76-$DAF5-1-32)(sprite-da76)]
b $DAF6 Mask, 32x32 pixels. Baby whale
B $DAF6,128,8 #HTML[#UDGARRAY4,,,4,,($DAF6-$DB75-1-32)(sprite-daf6)]
b $DB76 Mask, 32x32 pixels. Baby whale
B $DB76,128,8 #HTML[#UDGARRAY4,,,4,,($DB76-$DBF5-1-32)(sprite-db76)]
b $DBF6 Mask, 32x32 pixels. Baby whale
B $DBF6,128,8 #HTML[#UDGARRAY4,,,4,,($DBF6-$DC75-1-32)(sprite-dbf6)]
b $DC76 Sprite, 8x24 pixels. Spark/debris
B $DC76,24,8 #HTML[#UDGARRAY1,,,1,,($DC76-$DC8D-1-8)(sprite-dc76)]
b $DC8E Sprite, 8x24 pixels. Spark/debris
B $DC8E,24,8 #HTML[#UDGARRAY1,,,1,,($DC8E-$DCA5-1-8)(sprite-dc8e)]
b $DCA6 Sprite, 8x24 pixels. Spark/debris
B $DCA6,24,8 #HTML[#UDGARRAY1,,,1,,($DCA6-$DCBD-1-8)(sprite-dca6)]
b $DCBE Sprite, 8x24 pixels. Spark/debris
B $DCBE,24,8 #HTML[#UDGARRAY1,,,1,,($DCBE-$DCD5-1-8)(sprite-dcbe)]
b $DCD6 Sprite, 8x8 pixels. Gem/diamond icon
B $DCD6,8,8 #HTML[#UDGARRAY1,,,1,,($DCD6-$DCDD-1-8)(sprite-dcd6)]
b $DCDE Sprite, 8x8 pixels. Gem/diamond icon
B $DCDE,8,8 #HTML[#UDGARRAY1,,,1,,($DCDE-$DCE5-1-8)(sprite-dcde)]
b $DCE6 Sprite, 8x8 pixels. Gem/diamond icon
B $DCE6,8,8 #HTML[#UDGARRAY1,,,1,,($DCE6-$DCED-1-8)(sprite-dce6)]
b $DCEE Sprite, 8x8 pixels. Gem/diamond icon
B $DCEE,8,8 #HTML[#UDGARRAY1,,,1,,($DCEE-$DCF5-1-8)(sprite-dcee)]
b $DCF6 Sprite, 8x8 pixels. Gem/diamond icon
B $DCF6,8,8 #HTML[#UDGARRAY1,,,1,,($DCF6-$DCFD-1-8)(sprite-dcf6)]
b $DCFE Sprite, 32x32 pixels. Cube/pedestal
B $DCFE,128,8 #HTML[#UDGARRAY4,,,4,,($DCFE-$DD7D-1-32)(sprite-dcfe)]
b $DD7E Sprite, 32x32 pixels. Passage, closed/blocked
B $DD7E,128,8 #HTML[#UDGARRAY4,,,4,,($DD7E-$DDFD-1-32)(sprite-dd7e)]
b $DDFE Sprite, 16x16 pixels. Passage, part
B $DDFE,32,8 #HTML[#UDGARRAY2,,,2,,($DDFE-$DE1D-1-16)(sprite-ddfe)]
b $DE1E Sprite, 16x16 pixels. Passage, part
B $DE1E,32,8 #HTML[#UDGARRAY2,,,2,,($DE1E-$DE3D-1-16)(sprite-de1e)]
b $DE3E Sprite, 16x16 pixels. Passage, part
B $DE3E,32,8 #HTML[#UDGARRAY2,,,2,,($DE3E-$DE5D-1-16)(sprite-de3e)]
b $DE5E Sprite, 16x16 pixels. Passage, part
B $DE5E,32,8 #HTML[#UDGARRAY2,,,2,,($DE5E-$DE7D-1-16)(sprite-de5e)]
b $DE7E Sprite, 16x16 pixels. Passage, part
B $DE7E,32,8 #HTML[#UDGARRAY2,,,2,,($DE7E-$DE9D-1-16)(sprite-de7e)]
b $DE9E Sprite, 16x16 pixels. Passage, part
B $DE9E,32,8 #HTML[#UDGARRAY2,,,2,,($DE9E-$DEBD-1-16)(sprite-de9e)]
b $DEBE Mask, 16x24 pixels.
B $DEBE,48,8 #HTML[#UDGARRAY2,,,2,,($DEBE-$DEED-1-16)(sprite-debe)]
b $DEEE Mask, 16x16 pixels.
B $DEEE,32,8 #HTML[#UDGARRAY2,,,2,,($DEEE-$DF0D-1-16)(sprite-deee)]
b $DF0E Mask, 16x16 pixels.
B $DF0E,32,8 #HTML[#UDGARRAY2,,,2,,($DF0E-$DF2D-1-16)(sprite-df0e)]
b $DF2E Sprite, 88x16 pixels. RUSTOMETER gauge graphic
B $DF2E,176,8 #HTML[#UDGARRAY11,,,11,,($DF2E-$DFDD-1-88)(sprite-df2e)]
b $DFDE Sprite, 32x32 pixels. Passage, open
B $DFDE,128,8 #HTML[#UDGARRAY4,,,4,,($DFDE-$E05D-1-32)(sprite-dfde)]
b $E05E Sprite, 88x32 pixels. Sign: "PIRANHA / DO NOT TAP GLASS"
B $E05E,352,8 #HTML[#UDGARRAY11,,,11,,($E05E-$E1BD-1-88)(sprite-e05e)]
b $E1BE
b $E390 Shadow screen 256x192, 32*192=6144 bytes
N $E390 #HTML[#UDGARRAY32,,,32,,($E390-$FB8F-1-256)(screen-e390)]
B $E390,6144,32
c $FB90 Menu tune + key-wait driver
N $FB90 Sets up the melody-table pointers ($FBAB=$FC99, $FBAF=$FE33), then loops: disable interrupts, play one note via #R$FBD7 (which reads/advances through the melody-index table and produces the tone), scan the keyboard via the ROM KEY-SCAN routine at $028E, and repeat until a key is pressed; then re-enable interrupts and return.
C $FB90,6 point $FBAB at the start of the melody-index table (#R$FC9A, aliased as code for a rare branch -- see its note)
C $FB96,6 point $FBAF at $FE33 (a second/loop-restart table pointer, not yet explored)
C $FB9C,1 disable interrupts while bit-banging the tone (precise timing)
C $FB9D,3 Play one note / check key selection
C $FBA0,3 ROM KEY-SCAN: scans the keyboard, returns no-key-found as E=$FF
C $FBA3,3 if no key was found (E wraps to 0), loop back and play the next note
C $FBA6,2 re-enable interrupts and return (a key was pressed)
b $FBA8
W $FBAB,8,2
c $FBB4 Melody-index table reader/advancer, used by #R$FBD7
N $FBB4 Reads the next byte of the melody-index table (via the pointer at (HL)), advances the pointer, and returns it in A. If the byte is $40 (end-of-tune marker), jumps to #R$FBCF to reload the pointer from a loop-restart address instead.
C $FBB4,4 DE = the melody-index pointer read from (HL), advanced past the current index
C $FBB8,5 Read the next index, branch to #R$FBCF on the $40 terminator
C $FBBD,3 Store the advanced pointer back to (HL) and return
c $FBC1 Melody-index to period lookup, used by #R$FBD7
N $FBC1 Converts a melody-index byte (from #R$FBB4, at (HL)) into an actual tone period by adding $0C and indexing into the period table at #R$FC64; returns the period in H, with L fixed at $01. E.g. index $29 (+$0C=$35) -> #R$FC64+$35 = $FC99 = $01.
C $FBC1,3 A = the melody index at (HL), add $0C
C $FBC4,3 DE = that value, widened
C $FBC7,4 HL = the period table $FC64 plus the index
C $FBCB,3 H = the looked-up period byte, L = $01 fixed, return
c $FBCF Continuation of #R$FBB4
c $FBD7 Play one note / check key selection
N $FBD7 Calls #R$FBB4 twice (storing results at $FBA8/$FBA9), then #R$FBC1 twice to check them; if neither matches, falls into the tone-generator loop at $FC04, continuing through $FC15/$FC17/$FC25 into #R$FC34, which toggles the speaker/border via OUT ($FE),A (bit 4 = speaker) in a tight DJNZ-timed square-wave loop -- this is the music heard while the menu waits for input. If both checks match, jumps to the plain delay loop at #R$FC46 instead.
C $FBDA,3 Melody-index table reader/advancer, used by #R$FBD7
C $FBE3,3 Melody-index table reader/advancer, used by #R$FBD7
C $FBEC,3 Melody-index to period lookup, used by #R$FBD7
C $FBF8,3 Melody-index to period lookup, used by #R$FBD7
C $FC04,17 setup: C=note duration count (from $FBB3), B=0, load key-state twice into both AF register banks, D=$10 (initial half-period)
C $FC19,2 toggle speaker/border bit 4 -- produces the audible tone
C $FC25,2 toggle speaker/border bit 4 -- produces the audible tone
C $FC34,2 Self-modified: JR Z to itself, replaced with NOPs when idle
C $FC36,2 Swap in the shadow AF, decrement L, the pitch/period counter
C $FC38,3 If it reaches zero, jump back to reload the next note
C $FC3B,2 toggle speaker/border bit 4 -- produces the audible tone
C $FC3D,4 Padding NOPs for timing, then loop B times
C $FC41,4 Increment C, the outer note-duration counter, loop while nonzero
t $FC30 NOTE: not a real string
N $FC30 Literal ASCII "adam" embedded as data/padding between code paths; possibly a programmer's signature.
c $FC34 Tone generator loop (continued)
N $FC34 Toggles the speaker bit via OUT ($FE),A, timed by DJNZ.
c $FC46 Plain delay loop (no sound)
N $FC46 Decrements a counter via $FBB3, with no OUT ($FE) calls.
C $FC46,3 A = delay parameter from $FBB3
C $FC49,1 Complement it, the delay length is inversely encoded
C $FC4A,3 C = complemented value, save BC and AF
C $FC4D,2 B = 0, 256 inner iterations per outer pass
C $FC4F,1 Save HL, inner loop entry point
C $FC50,3 HL = self-modified dummy pointer, target patched elsewhere, unused here as data
C $FC53,6 shift a (self-modified) pointer's byte right 3 times (divide by 8) -- pure delay, no sound
C $FC59,1 NOP, padding to equalize timing
C $FC5A,3 Restore HL, loop back to $FC4F for the next inner iteration
C $FC5D,1 Decrement outer counter C
C $FC5E,3 Loop back to $FC4F while C is nonzero, outer pass
C $FC61,3 Restore AF, BC and return
b $FC64 Note/period table for the #R$FC04 tone generator
N $FC64 54 bytes: 53 descending values (= ascending pitch), indexed by #R$FBC1 as (melody-index byte + $0C), plus a trailing byte at $FC99 that is never actually read as a melody index (see #R$FC9A).
B $FC64,54,18
b $FC9A Melody-index table (start)
N $FC9A Each byte, +$0C then indexed into #R$FC64, gives the tone period for one note. Terminated by $40. #R$FBB4 stores the pointer as $FC99 but always increments before reading, so the first byte actually consumed is here at $FC9A ($29); +$0C=$35, and #R$FC64+$35=$FC99=$01. This table also happens to be reachable as code via #R$FBF1 (JP C,$FC9A -- 12x ADD HL,HL, a rarely/never-taken branch that reuses these bytes as opcodes; not its primary purpose).
b $FE34
b $FFCE

