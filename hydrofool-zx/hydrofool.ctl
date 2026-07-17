b $60C2
W $60E9,2 Saved SP
B $60EB,1 Draw-queue length (number of object-record pointers at $60EC; see #R$9900)
W $60EC,10,8 Draw queue: object-record pointers, drawn by #R$9900
W $610A,2
W $610C,2
W $610E,2 Active object list HEAD pointer: points at the most recently spawned object record; each record's +0/+1 links to the next, ending in the fixed records #R$8DB6 (player) -> $8DCF -> $8DEF -> $0000. Passed as IX into #R$84AE, which head-inserts the new object here. Other insertion points exist (e.g. $8DEF for creatures -- see #R$6663), placing objects later in the list.
W $6110,2 Currently-held item: pointer to its 4-byte item-table record (room,Y,X,sprite). Equals the fixed "empty hands" sentinel record at $788A when nothing is held. Set by #R$8AFB on pickup; the pointed-to record's room byte is zeroed on pickup and restored (to the current room, at the player's position) on drop.
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
B $6198,1
B $6199,1
B $619A,1 Room number copy
W $619B,2
B $619D,1
B $619E,1 Weapon-held flag, tested by #R$8AFB on fire/pick-up to decide attack vs. pick-up/drop
B $619F,1
B $61A0,1
B $61A1,1
B $61A2,1
B $61A3,1
B $61A6,1
c $61A7 JP (HL) trampoline
N $61A7 Used by #R$983C to call a dynamic object's per-frame behaviour handler
c $61A8 Initialize the object free list: chain B 24-byte records starting at DE (each record's first word points to the next)
c $61C1
C $61D0,3 set Active object list HEAD pointer
C $61D8,3 Initialize the object free list
c $61E3
C $6224,3 Room descriptions start address
c $6254 Set object position (IX+5/+6) from grid index A (cell centre: row*8+4, col*8+4)
c $6269 Set current room to A: locate its description record and build the room
C $6269,3 set room number
C $626D,3 Room descriptions start address
C $6275,1 get offset to the next room description
C $6279,3 Store room description address
C $6295,13 Clear room grid - 64 bytes at 612C
C $62A2,25 place the room-type template ($612A indexes the #R$72B1 pointer table) into the grid via #R$62C8
C $62BB,13 place this room's own extra (index,value) pairs (if its description is longer than 4 bytes) into the grid via #R$62C8
C $62C8,48 Grid-entry writer. E=(HL)=index, IX=$612B+E=target address, A=(HL+1)=value; stores A at (IX+0), then checks A against $66/$67/$68/$69/$6A/$6B to also trigger a dedicated object-spawn routine. Loops B times (DJNZ), consuming 2 bytes/iteration; a special-value spawn routine can decrement B as a side effect, ending the loop earlier than the byte count alone would suggest (see #R$8EA7).
c $62F9 Test whether the current room is this level's Plug Room (via the per-level table at $7287); returns Z if so, with HL pointing at the entry's state byte
C $62F9,3 get room number
c $630D
c $6329 Build the door/exit bitfield at $612B from the room description's byte1
N $6329 Re-reads room description byte1 (at room_base+1), merges bit4 into bit0 and bit7 into bit3 (via AND $90, RRCA x4, OR), writes the result back into the room description itself AND into $612B. Bits 0-3 of the result are then tested by #R$6344/#R$6377 to conditionally draw door graphics at fixed screen positions -- one bit per exit direction: bit0=North, bit1=East, bit2=South, bit3=West (see #R$67F1).
C $633D,3 Draw door graphics for $612B bits 0 and 3
c $6344 Draw single-piece doors, for $612B bits 0 and 3
N $6344 Tests bit 0 of $612B (North), drawing one door-graphic piece via #R$8128 at a fixed screen position if set; then bit 3 (West), drawing a different fixed-position piece if set.
C $635B,3 Draw sprite C with its mask at screen position DE
c $6377 Draw three-piece doors, for $612B bits 1 and 2
N $6377 Tests bit 1 of $612B (East), drawing three door-graphic pieces via #R$8128 (three fixed screen positions) if set; then bit 2 (South), drawing three different fixed-position pieces if set. Calls #R$6344 first.
C $638A,3 Draw sprite C with its mask at screen position DE
C $6396,3 Draw sprite C with its mask at screen position DE
C $63A2,3 Draw sprite C with its mask at screen position DE
C $63B4,3 Draw sprite C with its mask at screen position DE
C $63C0,3 Draw sprite C with its mask at screen position DE
C $63CC,3 Draw sprite C with its mask at screen position DE
c $63D0 Clear shadow screen
C $63D0,3 Shadow screen address
b $63DE
c $642F Draw the fixed wall/decoration layout selected by $6129
N $642F Uses $6129 (0 or 1) to index a 2-entry pointer table at $63DE, selecting one of two fixed layout lists. Each list has two parts: a sequence of 4-byte records (count, screen Y, screen X -- drawn via #R$8128) terminated by $FF, immediately followed by a sequence of single bytes (grid indices) terminated by $FF, each poked into the room grid ($612B+index, i.e. grid_offset=index-1) as solid wall ($7F). This is the source of the 3x3 solid-wall corner block seen in every room grid -- it is not part of the room-type template; it is this fixed, $6129-selected layout.
C $6453,3 Draw sprite C with its mask at screen position DE
c $6470
C $6478,3 Room grid address
c $64BB
C $64BE,3 Search the (key,data) pair table at $74CE for key A
C $64DC,3 Draw sprite C with its mask at screen position DE
c $64F3
b $64FF
B $6500 Oil level??
B $6501 Oil level??
B $6502 Oil level??
c $6503 Routine ?? Oil
C $6507,1 POKE 201 (RET) here for infinite Oil
C $6508,3 get room number
C $6536,3 set player behaviour-handler pointer
b $653F
c $6543
c $655E
C $6566,3 Draw sprite C with its mask at screen position DE
c $6580
c $6593
C $659B,3 Draw sprite C with its mask at screen position DE
C $65A8,3 Draw sprite C with its mask at screen position DE
C $65C0,3 Draw sprite C with its mask at screen position DE
b $65CF
B $65D3
W $65D7
W $65D9
c $65DB Draw message window: room/creature title line + rotating clue/joke message line
C $65DE,3 Print string: position cursor for message window line 1 (row $A4)
C $65F6,3 "  DEATHBOWL  "
C $65FD,3 Print string: room/creature title, indexed by room type (#R$73B5 table)
C $6603,3 Print string: position cursor for message window line 2 (row $B4)
C $6614,3 Print string: current clue/joke message, rotating through the #R$7441 table
c $6622
c $663B
C $6643,3 Draw sprite C with its mask at screen position DE
C $6646,3 print inline string, then resume after it
T $6649,4 cursor position only, no visible text
c $6653 Prepare room with color 0
C $6654,3 Prepare the Room with color A
c $6657 Get room color from room description and store to 6175
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
c $6692
c $66CE
C $66E9,3 Spawn the room's creature
C $66F8,3 Collision test
C $6705,3 Collision test
c $6728
C $6733,3 get room number
c $6743
c $676D Draw current room
N $676D Draw the full room (walls, doors, message window, creatures/objects) -- or the reduced special-room variant for rooms $01/$02
N $676D Rooms $01 and $02 are the only two type $E rooms, and are special "no walls" rooms (see #R$6CCF -- room $01 is the ending/winning room). At #R$67AB, this routine checks if the current room ($6126) is 1 or 2 and, if so, skips straight to #R$67E0, bypassing: the wall/layout draw (#R$642F), door-graphic draw (#R$6377), the message window (#R$65DB), and several creature/object placement calls (#R$6593/$655E/$663B/$6743/$8F82/$6895/$885A). The room's grid contents (rocks/seaweed etc, from its type $E template) still get drawn via a separate, non-skipped path -- consistent with the "just floating rocks and seaweed, no walls" appearance of room $01. Room $01 additionally gets one extra call, #R$86CC (CALL Z at #R$67E8, gated on room==1 specifically, not room==2) -- draws the "DEATHBOWL DIVINED" end-game stats overlay (see #R$86CC).
C $6776,3 get room number
C $679C,3 Set current room to A
C $67A8,3 Clear shadow screen
C $67AB,3 get Room number
C $67AE,8 if room $6126 is 1 or 2, skip to #R$67E0 (special "no walls" room -- see #R$676D)
C $67B6,3 Draw the fixed wall/decoration layout selected by $6129
C $67BF,3 Draw three-piece doors, for $612B bits 1 and 2
C $67C5,3 Draw message window
C $67CE,3 Prepare room with color 0
C $67D1,3 Get room color from room description and store to 6175
C $67D4,3 Re-initialize the state blocks of the two fixed object records at $8DCF and $8DEF
N $67E0 Special-room path for rooms $01/$02: skips walls/doors/message-window/most creature calls; room $01 additionally calls #R$86CC (likely the end-game stats overlay)
C $67E3,3 get Room number
C $67E8,3 Draw the end-game stats screen
C $67EB,3 Prepare room with color 0
C $67EE,3 Get room color from room description and store to 6175
c $67F1 Attempt to move to an adjacent room (horizontal, via a door) in the direction given by ($8DC1)
N $67F1 Reads a direction code from ($8DC1) -- 1, 2, 4, or else (fallback case) -- and for each, tests one bit of the door bitfield at #R$612B via HL (set to $612B just before this dispatch) before allowing the move: bit 0 (direction code 1) gates "room number - 6" (row-1, NORTH); bit 1 (direction code 4) gates "room number + 1" (col+1, EAST); bit 2 (direction code 2) gates "room number + 6" (row+1, SOUTH); bit 3 (the fallback case) gates "room number - 1" (col-1, WEST). Also does on-screen player-position bounds checks (against D/E, likely screen row/col) before allowing the move, presumably to require the player to be near the room edge on that side. #R$97FC is called with the new room number to actually perform the transition.
C $6819,3 get room number
C $6824,3 Change current room to A
C $681C,2 change room number: -6 (row-1, move NORTH)
C $683D,3 get room number
C $6840,1 change room number: +1 (col+1, move EAST)
C $685B,3 get room number
C $685E,2 change room number: +6 (row+1, move SOUTH)
C $6876,3 get room number
C $6879,1 change room number: -1 (col-1, move WEST)
c $6880
c $6895
C $68A4,3 Draw sprite C with its mask at screen position DE
C $68A8,3 Search the buffer at $7C83 for byte A
C $68B1,3 print inline string, then resume after it
T $68B4,4 cursor position only, no visible text
C $68B8,3 get Weapon-held flag
C $68BB,3 Print BCD byte A as two digits, high digit blanked to a space if zero
c $68C1
C $68CC,3 print inline string, then resume after it
T $68CF,6 two spaces at cursor position
b $68DE
t $6997
c $69AC Prepare the Room ??
C $69CF,3 get room number
R $69AC A Room color
C $6A32,3 Screen attribute area start address
c $6AAA
c $6AE7
c $6AF1
c $6AF8
c $6AFB
c $6AFC
c $6B05
C $6B0B,3 set player behaviour-handler pointer
C $6B1F,3 Set object position (IX+5/+6) from grid index A
C $6B27,3 set Weapon-held flag
C $6B39,3 set Entry-point room number choosen selecting A/B/C/D in menu
C $6B68,3 Draw current room
C $6B6B,3 Per-frame main loop entry
c $6B71
C $6B8F,3 Routine ?? Oil
C $6B95,3 get room number
C $6BA8,3 Per-frame main loop entry
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
C $7CF9,2 control codes (<$20) are handled separately; printable chars fall through
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
b $7DB7
B $7DBF
c $7DC7
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
c $7EA9
c $7EBE Read input: normalize the active control method into the 5-bit mask at #R$6186
N $7EBE Dispatches on the device selector $617B: keyboard (scans 6 half-rows into $6186's bits, some duplicated -- e.g. both $617D and $6184 set bit 4/fire), Kempston (port $001F, used as the mask directly), Sinclair (port $EFFE, bit-rotated into the mask), or Cursor keys (ports $EFFE/$F7FE). Result is masked against the previous frame's value at $6188 and stored to $6186; also accumulates a held-key counter at $617C. See #R$6186 for the bit layout.
C $7F18,3 set Resolved input mask
C $7F8A,3 set Resolved input mask
c $7F8E
c $7F9B
b $7FBD
c $7FC0
c $7FCD
c $8011
c $809D
c $8107
b $8124
B $8126,1 Current sprite number (set by #R$8128)
B $8127,1 Current mask sprite number (set by #R$8128)
c $8128 Draw sprite C with its mask at screen position DE (mask sprite number from the table at #R$6C06; A bit 7 = mirror flag)
R $8128 A ??
R $8128 C ??
C $8140,3 Load a sprite's #R$A5DC record into the "current sprite" scratch variables at #R$618D, ready for #R$8128 to draw it
C $814D,3 Flip sprite horizontally
C $8159,3 Load a sprite's #R$A5DC record into the "current sprite" scratch variables at #R$618D, ready for #R$8128 to draw it
C $8166,3 Flip sprite horizontally
b $8226
c $8230
b $829E
c $82A6
b $82CF
c $82DB
c $82F0
c $8315
c $835E
b $8397
c $8445
c $848E Request sound effect A (queued at $61A2, gated by the $61A0/$61A1 flags)
c $84AE Dynamic object allocator
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
C $8509,3 print current character (and interpret control codes)
c $850E Print an inline string embedded right after the caller's CALL instruction
N $850E Pops the return address off the stack into HL -- since the caller used CALL $850E, this is the address of the string bytes immediately following that CALL. Calls #R$8501 to print the string (advancing HL past it), then JP (HL) to resume execution right after the embedded string, i.e. normal code flow continues past the inline text.
C $850F,3 print string: see #R$8501
C $8512,1 resume execution after the inline string
c $8513
C $8516,3 Print string: position cursor for message window line 1 (row $A4)
C $851F,3 Print string: inline message text embedded after the call to #R$8513
c $8523 Print a BCD number: B bytes from (HL), two digits per byte, leading zeros as spaces; DE = per-digit print routine (self-modifies #R$854C's JP)
C $8533,3 Print one digit
C $8545,3 Print one digit
c $854C Print one digit (JP target self-modified by #R$8523)
c $854F Print BCD byte A as two digits, high digit blanked to a space if zero
C $855C,3 Print engine entry point
b $8567 Entry-point room number table (menu keys A/B/C/D)
N $8567 4 bytes, one per starting location, in order A/B/C/D: $52 (level 3, row 1, col 4), $C0 (level 6, row 2, col 0), $1A (level 1, row 4, col 2), $84 (level 4, row 4, col 0). See x-docs/Room-Format.md for the full cube-position table and cross-check against an external game map.
B $8567,4
t $856B Controls sub-menu text
N $856B "1 KEYBOARD 2 KEMPSTON 3 SINCLAIR 4 CURSOR", printed by #R$8617 via the #R$7CEC print engine.
c $8596
c $85A1 Main menu screen: title, entry list A-D, controls menu; loops until a selection starts the game
C $85A1,3 print inline string, then resume after it
T $85A4,15 main menu title
T $85B3,12 sub-heading
T $85BF,21 key A entry name
T $85D4,20 key B entry name
T $85E8,17 key C entry name
T $85F9,22 key D entry name (Elvis song titles)
C $8617,3 load pointer to Controls menu text at #R$856B
C $861A,5 control code $16: set print cursor row (selects the menu row to print into)
C $8620,3 print the Controls menu text (via #R$7CEC print engine loop)
C $8623,5 control code $14 + flag: set/clear inverse video for the currently selected control method
C $862F,3 Print engine entry point
C $8634,3 Print engine entry point
C $8637,3 #R$8501 (likely reads the current control method / input routine)
C $863A,6 control code $14 + $01: restore inverse video flag to normal
C $8640,3 Print engine entry point
C $864E,3 print inline string, then resume after it
T $8651,6 stray "5" (control-code list index? unclear)
C $865D,3 print inline string, then resume after it
T $8660,14 "MUSIC" label, shown selected/inverse
C $8670,3 print inline string, then resume after it
T $8673,14 "SFX" label, shown selected/inverse
C $868D,3 Menu tune + key-wait driver
C $86C1,3 load pointer to entry-point room number table (#R$8567) -- used to look up the starting room for the pressed menu key A/B/C/D
C $86C6,3 set entry-point room number
c $86CC Draw the end-game stats screen
C $86CC,3 print inline string, then resume after it
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
C $876A,3 print inline string, then resume after it
T $876D,4 cursor position only, no visible text (positions for a stat value printed separately)
C $8779,3 Print a BCD number
C $877C,3 print inline string, then resume after it
T $877F,4 cursor position only, no visible text
C $8783,3 get "Plugs Pulled" end-game stat counter
C $8786,3 Print BCD byte A as two digits, high digit blanked to a space if zero
C $8789,3 print inline string, then resume after it
T $878C,4 cursor position only, no visible text
C $8790,3 get "Goodies Gathered" end-game stat counter
C $8793,3 Print BCD byte A as two digits, high digit blanked to a space if zero
C $8796,3 print inline string, then resume after it
T $8799,4 cursor position only, no visible text
C $879D,3 get "Gnomes Gnabbed" end-game stat counter
C $87A0,3 Print BCD byte A as two digits, high digit blanked to a space if zero
C $87A9,3 get "Plugs Pulled" end-game stat counter
C $87B0,3 print inline string, then resume after it
N $87B3 End-game message, shown on an early/partial completion outcome
T $87B3,30 line 1
T $87D1,21 line 2
T $87E6,22 line 3
C $87FD,3 print inline string, then resume after it
N $8800 End-game message, shown on full completion (all 4 plugs pulled)
T $8800,25 line 1
T $8819,24 line 2
T $8831,20 line 3
T $8845,20 line 4
c $885A
C $885C,3 Print engine entry point
C $8861,3 Print engine entry point
C $8866,3 Print engine entry point
s $8874
c $8879
c $888E
c $8894
c $88B9
c $88D7
c $88DD
c $88E3 Search the buffer at $7C83 for byte A (CPIR, length from $7C88)
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
C $899E,3 Fire/pick-up button handler
C $89A1,3 get Resolved input mask
C $89A4,2 set bit 7 as a wildcard sentinel, for the #R$88F0 priority-table scan (matches its default/no-input entry)
C $89C6,3 Take one walk step
C $89EB,3 Request sound effect A
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
C $8A76,3 get room number
c $8A87 Attempt to move to an adjacent room (vertical, via whirlpool/bubble)
N $8A87 Computes the room number one level down ($6126 - $24, i.e. -36 -- a whirlpool) or one level up ($6126 + $24, i.e. +36 -- a bubble), the 6x6x6 cube level-stride (see x-docs/Room-Format.md). Has special-case handling when the current room number is exactly 1 (down) or 2 (up) -- overrides the computed value instead of using the generic +-36 arithmetic; not yet understood why. The upward case also bounds-checks the result against $D9 before allowing it (JP C,#R$97FC), falling back to a different path (through $8C83) if out of range. #R$97FC is called with the new room number to actually perform the transition, same as the horizontal case (#R$67F1).
C $8A7D,2 change room number: -36 (one level DOWN, via whirlpool)
C $8A7F,3 Change current room to A
C $8A82,2 room==1 special case: force A=2 instead
C $8A84,3 Change current room to A
C $8A97,3 get room number
C $8A9E,2 change room number: +36 (one level UP, via bubble)
C $8AA0,2 bounds check: is the new room number in range?
C $8AA2,3 Change current room to A (if in range)
C $8AA5,8 out of range: fall back instead of changing room
C $8AAD,3 room==2 special case: use $6125 instead
C $8AB0,3 Change current room to A
b $8AB3 Direction -> screen position delta table, indexed by (facing_code AND $0E): 4 (dx,dy) pairs -- Up=(-2,0), Down=(+2,0), Right=(0,+2), Left=(0,-2). Read by #R$8ABB.
c $8ABB Apply the object's facing direction to its position (IX+5/+6), returning the OLD position in BC
N $8ABB Looks up (IX+$0B) AND $0E in the delta table at #R$8AB3 and adds it to the object's position (+5/+6) in place. Screen deltas are +-2px along one axis per direction (Up/Down move dx, Right/Left move dy) -- the isometric-diamond room layout means each cardinal game direction is a diagonal-looking step on screen along a single axis. Used by #R$8AD9 (player movement) and #R$9923.
c $8AD9 Take one walk step: apply the facing delta, then check for a room-edge/door transition and a collision, reverting the position if blocked
N $8AD9 CALLs #R$8ABB to move (IX+5/+6) by the facing delta (old position saved in BC), then #R$67F1 (door/room-transition check) and #R$9BF0 (grid + object collision check). If #R$9BF0 reports no collision (NC), the new position is kept as-is. If it reports a collision (C): if also Z, pokes $FF into offset +9 of the colliding object's record (DE, from #R$9BF0/#R$9ABC) -- disables it; either way, the position is then reverted to the saved BC (blocked), and the animation countdown (+0x0E) is reset.
C $8ADD,3 Attempt to move to an adjacent room (horizontal, via a door) in the direction given by
C $8AE0,3 Collision test
c $8AFB Fire/pick-up button handler: attack with the held weapon, or pick up/drop an item
N $8AFB Gated on the fire/pick-up key (bit 4 of #R$6186); if a weapon is currently held ($619E), jumps to #R$8D8D (attack) instead. Otherwise plays a "reach out" animation, then continues at $8B2B: if the held-item pointer #R$6110 currently equals the fixed "empty hands" sentinel record at $788A (i.e. nothing held), attempts to PICK UP something nearby; otherwise DROPS the currently-held item.
N $8AFB PICK UP ($8B2B, nothing currently held): walks nearby objects via #R$9B5D (proximity/collision helper, same one used by movement collision), skipping any whose kind byte (offset +8 from the found record) is $44 (the shared "vulnerable creature" pose -- not pickupable). For the first valid candidate: if its kind is $6E, calls #R$6622 (unidentified -- likely a special pickup, e.g. a key or weapon-specific item); if its kind is $36, treats it as a GNOME -- calls #R$888E, increments the "Gnomes Gnabbed" counter at $6122 (BCD), then plays sound effect $04 and finalizes via #R$9A60 (the gnome object is consumed). For any other kind, searches a weapon lookup buffer at $7C83 (via #R$88E3) -- if found, sets the Weapon-held flag $619E (and possibly a variant at $619F depending on a $3C check) instead of picking the object straight up; either way, the found record's pointer is stored into #R$6110 (now "held") and #R$6895 is called (equip/HUD update?), then sound effect $04 plays.
N $8AFB DROP ($8BC4, something currently held): writes the CURRENT ROOM into the held item's table record (byte0), restoring it to the world -- the same field that item-table entries have their room zeroed on pickup (see Room-Format.md). Re-derives the item's stored Y/X (record bytes 1/2) from the player's own position ($8DBB/$8DBC, grid-aligned) -- i.e. the item is dropped at the player's feet. Exact bit-packing of the combined Y/X byte not fully resolved.
C $8B01,3 get Weapon-held flag
C $8B0C,3 Save continuation
C $8B25,3 set player behaviour-handler pointer
C $8B3F,3 Dynamic object finalizer
C $8B8E,3 get "Gnomes Gnabbed" end-game stat counter
C $8B94,3 set "Gnomes Gnabbed" end-game stat counter
C $8B9A,3 Search the buffer at $7C83 for byte A
C $8BAA,3 set Weapon-held flag
C $8BB6,3 Request sound effect A
C $8BC7,3 get room number
C $8BE9,3 Spawn the room's creature
C $8BEC,3 Collision test
C $8BF1,3 get room number
C $8C07,3 Request sound effect A
c $8C35
b $8C48
t $8CD9
b $8CDC
c $8CDF
C $8CE7,3 Collision test
b $8CF8
c $8D11 Alternate PLAYER behaviour handler (swapped into $8DB9 by #R$9564; see #R$8968 and #R$8DB6)
C $8D15,3 Save continuation
C $8D43,3 Save continuation
C $8D75,3 Save continuation
C $8D7B,3 Sprite-animation stepper
C $8D87,3 set player behaviour-handler pointer
c $8D8D
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
C $8E4D,3 Dynamic object allocator
W $8E50,2 Dynamic object handler address (#R$9684)
C $8E54,3 Set object position (IX+5/+6) from grid index A
c $8E6E
C $8E71,3 Search the (key,data) pair table at $74CE for key A
C $8E91,3 Dynamic object finalizer
c $8EA7 Special grid-value spawn routine (values $66/$6A) -- bubble source ($6A full-strength, $66 weak; see #R$9602)
N $8EA7 Called from #R$62C8 with A=the special value ($66 or $6A) and HL pointing just past it in the template/extras stream. Self-modifies its own #R$8EC3 operand with A (so the spawned object's initial "kind" byte matches whichever of $66/$6A triggered it). Clears the grid cell to 0 (so the special value never appears in the finished grid -- see #R$612C). Reads 2 more bytes from the template beyond the normal (index,value) pair -- these are NOT accounted for by the outer #R$62C8 loop's own HL advancement; instead the routine forces two extra DEC B's (at $8EE8/$8EE9), ending that loop one iteration early to compensate (see #R$6CCF). Sets up IX=$610E (the active-object list head) as the insertion point, then CALLs #R$84AE to allocate an object record -- its handler address (#R$8EB9) is #R$957C. Populates further record fields (offset $07=$18, $0A=$06, $09=triggering value, $0B and $0E=first extra byte, $14=second extra byte), then CALLs #R$9A60 to finalize. The two extra bytes' exact meaning (screen position? direction?) is not yet confirmed. Offset $09 (the triggering value) reads back as $00 afterward, suggesting it's consumed during finalization.
C $8EB6,3 Dynamic object allocator
W $8EB9,2 Dynamic object handler address (#R$957C)
C $8EC9,3 Set object position (IX+5/+6) from grid index A
C $8EDA,3 Dynamic object finalizer
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
c $8F82 Re-initialize the state blocks of the two fixed object records at $8DCF and $8DEF (22 bytes each from $5C92 to $8DD1/$8DF1 -- see #R$8DB6)
C $8FB6,3 get room number
C $9007,3 Dynamic object finalizer
c $9021
C $904F,3 Apply the object's facing direction to its position (IX+5/+6), returning the OLD position in BC
C $9052,3 Dynamic object finalizer
C $9055,3 Save continuation
C $9060,3 Collision/overlap scan
t $9077
b $907B
t $907C
b $9080
c $9085
t $908D
b $9091
c $90A8
C $90E4,3 Apply the object's facing direction to its position (IX+5/+6), returning the OLD position in BC
C $90E8,3 Collision test
C $9103,3 Direction-indexed sprite-animation stepper
C $9115,3 Request sound effect A
C $9118,3 Save continuation
C $914C,3 Dynamic object allocator
W $914F,2 Dynamic object handler address
C $917C,3 Dynamic object finalizer
C $9183,3 Save continuation
C $9189,3 Direction-indexed sprite-animation stepper
b $919A
c $91A6
C $91C4,3 Build the door/exit bitfield at $612B from the room description's byte1
C $91C9,3 Request sound effect A
C $91D3,3 Save continuation
C $91D9,3 Sprite-animation stepper
b $91E2
c $9208
b $9210
c $9232
c $923E Save continuation: set the object's handler (+3/+4) to the address just after the caller's CALL, then jump there (the object resumes at that point next frame)
b $9246
c $925C
C $92E4,3 Apply the object's facing direction to its position (IX+5/+6), returning the OLD position in BC
C $92E8,3 Collision test
C $9307,3 Request sound effect A
C $9332,3 Dynamic object finalizer
s $933D
c $9341 Room-creature per-frame behaviour handler (installed by the creature spawn at #R$6663) -- dual purpose: item-delivery detector in Plug Rooms, settle/float physics + hit detection elsewhere
N $9341 PLUG ROOM BRANCH (taken when #R$62F9 confirms the current room is this level's Plug Room): compares this object's own sprite number (+0x08) against each of the 4 required item sprites in the level's #R$7287 table (bytes 2-5), gated by the corresponding undelivered bit in the level's state nibble (byte1, CPL'd so unset/undelivered bits read as 1). On a match: sets that delivery bit in the state byte, repositions itself at the matching corner-cube grid cell (#R$6254), increments the "Goodies Gathered" counter at $6123 (BCD), plays sound effect $01, runs a short animation via the #R$919A table, then re-pokes the grid cell to the "delivered" marker $13 and self-destructs ((IX+$02)=$FF). This strongly implies the object's sprite (+0x08) is set elsewhere to track whichever item the player is currently carrying/delivering -- that link is not yet found. If the state nibble is already fully clear (all delivered), falls through to the normal branch below.
N $9341 NORMAL-ROOM BRANCH (#R$93C1): settle/float physics -- the height/Z field (+0x07) decays by 4 each frame toward a rest value $18 (clamped), tested each step via #R$9BF0 (collision); if blocked, the height is bounced back up by 4 instead. Also checks bit 2 of (IX+$0D) (a "just hit by a weapon" flag set elsewhere, not yet traced) and calls #R$9401 if set.
C $9381,3 Set object position (IX+5/+6) from grid index A
C $938C,3 get "Goodies Gathered" end-game stat counter
C $9392,3 set "Goodies Gathered" end-game stat counter
C $9397,3 Request sound effect A
C $939A,3 Save continuation
C $93A0,3 Sprite-animation stepper
C $93C1,3 Save continuation
C $93DC,3 Collision test
c $9401 Creature hit/defeat sequence, called from #R$9341 when the "just hit" flag (bit 2 of +0x0D) is set
N $9401 CONFIRMED structure (trigger not yet traced): clears the hit flag, then only proceeds if the creature's current sprite (+0x08) is $44 (a shared "vulnerable" pose -- creatures presumably must be in this pose to register a hit). Searches a (room, position, reward-sprite) triple table at $7C89 (count from $7C97) for an entry matching the current room and this object's position field (+0x09); on a match, swaps the reward sprite into +0x09 and into offset +3 of a linked record (via +0x0E/+0x0F), plays sound effect $01 (the same "success" sound as item delivery), steps through the #R$919A animation table to transform the sprite, then finalizes (+0x08 = reward sprite, #R$9AAB kind lookup into +0x0A, #R$9A60) and resumes normal behaviour at #R$93C1. Likely how a creature is "defeated" and turns into a collectible (a Gnome?).
C $9436,3 Request sound effect A
C $943F,3 Save continuation
C $9456,3 Search the (key,data) pair table at $74CE for key A
C $945D,3 Dynamic object finalizer
b $9463
c $9471 Behaviour handler of the fixed object record at $8E0F (object identity not yet known)
b $9489
t $9495
b $9499
c $949E Behaviour handler of the fixed object record at $8E27 (object identity not yet known)
C $94C1,3 Dynamic object finalizer
c $94CA
b $94E9 #R$99D5 sprite-animation table for the plant/coral object (#R$94EE)
N $94E9 Sprites $4E,$4E,$50,$50 (see #R$A714/#R$A71C, both labeled "Plant/coral"), terminated by $FF -- a simple 2-frame swaying decoration.
c $94EE Per-frame behaviour handler for value-$67 objects -- plant/coral
N $94EE Its #R$99D5 animation table (#R$94E9) is sprites $4E,$4E,$50,$50, both "Plant/coral" sprites -- a simple 2-frame swaying decoration.
c $94F4 Per-frame behaviour handler for value-$6B objects -- plug. WIN-CONDITION TRIGGER: polls every frame for full item delivery, then pops and increments the "Plugs Pulled" counter.
N $94F4 CONFIRMED: re-checks (every frame, via #R$62F9 + AND $0F/CP $0F) whether this level's Plug Room state nibble has reached $0F (all 4 items delivered -- see #R$9341). Once it has: increments the "Plugs Pulled" counter at $6124 (BCD), plays sound effect $09, and animates the plug popping out (+0x07 += 8 per frame, gated by bit 4 of +0x0D so this only fires once), then self-destructs on the following frame (bit 6 of +0x0D check). This is the actual win-condition trigger for a single Plug Room.
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
N $9684 Handler for #R$8E3F's objects (its handler-address bytes at #R$8E50 -- see #R$84AE), called from #R$983C's dispatcher.
N $9684 Sprite starts at $23 (set by #R$8EA1 on spawn) and cycles through $23,$24,$25,$26 -- the "Snake, rearing phase" sprites at #R$B56E/#R$B57E/#R$B59E/#R$B5CE, with increasing sprite height (16x8 -> 16x16 -> 16x24 -> 16x32) as it rises, i.e. more of the snake's body becomes visible each frame. Full cycle: phase 0 = idle countdown at (IX+$0E) (decrements while nonzero); phase 1 = seed position (IX+$16)/(IX+$17) at $FC/$FE then jump +8; phase 2 = each call, INC sprite number (IX+$08) and jump position +8 again, repeating until sprite reaches $26 (fully reared), then sets a long countdown ($24) and advances to phase 3+; phase 3+ (default case) = each call, if sprite isn't back down to $23 yet, DEC sprite and retract position by -8; once back at $23, reset position to 0, set bit 7 of (IX+$0D) (purpose not traced), set another countdown, and restart the cycle at phase 1. A full rise-pause-retract-pause loop.
b $9723
c $9745
C $9795,3 Room grid address
c $97BA Draw an object's sprite: convert record position (+5/+6) to screen coordinates and draw sprite (+8) with its mask via #R$8128
R $97BA IX ??
C $97E3,3 Draw sprite C with its mask at screen position DE
c $97FC Change current room to A = new room number
R $97FC A new room number
w $9806
c $9808 Per-frame main loop entry: saves SP to $60E9 (restored by #R$97FC on room change); restores the message-window title when the $618A timer expires
C $982F,3 Per-frame dynamic object dispatcher
C $9836,3 Per-frame dynamic object dispatcher
c $983C Per-frame dynamic object dispatcher (walks the active object list from the head at #R$610E)
N $983C For each object record (IX) in the list (record +0/+1 links to the next; the list includes the pool records at #R$A900, the PLAYER record at #R$8DB6, and the room's creature), checks if its room number (offset $02) matches the current room ($6126); if so, loads a function pointer from offset $03/$04 and CALLs #R$61A7 (a JP (HL) trampoline) to invoke the object's own per-frame behaviour handler (e.g. #R$9684 for a snake, #R$8968 for the player). Also checks bit 7 of offset $0D and computes into offset $0C from offsets $10/$11 -- purpose not yet confirmed.
R $983C IX ???
C $981B,3 Print string: position cursor for message window line 1 (row $A4)
C $9821,3 Print string: restore room/creature title (saved at #R$65D9 by #R$65DB)
C $986C,3 get room number
C $987B,3 JP (HL)
C $987E,3 get room number
c $9900 Draw all queued objects: walk the record-pointer list at $60EC (count at $60EB), drawing each via #R$97BA
C $9912,3 Draw an object's sprite
b $991A
c $9923
C $9926,3 Request sound effect A
C $992D,3 Dynamic object allocator
W $9930,2 Dynamic object handler address
C $9955,3 Dynamic object finalizer
b $995E
c $9963
C $9967,3 Collision test
C $996D,3 Apply the object's facing direction to its position (IX+5/+6), returning the OLD position in BC
C $9971,3 Collision test
C $9992,3 Save continuation
C $9998,3 Sprite-animation stepper
c $99A1 Direction-indexed sprite-animation stepper: pick one of 4 per-direction tables via (IX+$0B), then run #R$99D5's stepper on it
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
C $9A01,3 NEG / not NEG
C $9A15,3 NEG / not NEG
C $9A3A,3 get instruction code
c $9A49
c $9A60 Dynamic object finalizer (called at the end of every spawn routine's object setup)
N $9A60 Role still open: the handler-address write into record +3/+4 and the list insertion both happen inside #R$84AE, so neither is this routine's job. Observed effect: record offset $09 (the triggering grid value) reads back as $00 after this call. Internals not yet traced.
c $9AAB Search the (key,data) pair table at $74CE for key A; returns Z with HL pointing at the matched pair's data byte
b $9ABA
c $9ABC Terrain collision test for one screen point (B,C): convert to a grid cell and check its content
N $9ABC Converts screen coordinates (B=X,C=Y) to a room-grid cell: (Y AND $F8)>>3 * 8 + (X AND $F8)>>3 -- confirms the #R$612C grid's row*8+col indexing operates on 8px-aligned screen tiles. Reads the grid cell; $00 = passable (no collision). $7F = solid wall, hard block (see #R$9B56). Any other nonzero code is looked up in a per-terrain-code shape/behaviour table at $7556 (the same table #R$8E6E reads) -- individual terrain codes may have different collision shapes rather than being uniformly solid.
R $9ABC BC ??
C $9AD3,3 Room grid address
c $9AFD
C $9B04,3 Search the (key,data) pair table at $74CE for key A
c $9B5A Collision/overlap scan: walk the active object list looking for another same-room object whose bounding box (+$10..+$13) overlaps IX's; DE = the object found
b $9BD2
c $9BD4
c $9BF0 Collision test: check the object's 4 bounding-box corners against the room grid, then check for overlap with other objects
N $9BF0 Tests all 4 corners of the object's bounding box (screen-coordinate pairs at +0x10/+0x11, +0x10/+0x13, +0x12/+0x13, +0x12/+0x11 -- i.e. (left,top)/(left,bottom)/(right,bottom)/(right,top)) via #R$9ABC, returning early (C) if any corner hits solid terrain. If all 4 corners are clear, finishes with #R$9B5A (object-vs-object overlap scan). Also calls #R$9A60 first and returns early if it reports collision (purpose of that specific pre-check not fully traced).
R $9BF0 IX ??
C $9BFC,3 Dynamic object finalizer
C $9C06,3 Terrain collision test for one screen point
C $9C10,3 Terrain collision test for one screen point
C $9C1A,3 Terrain collision test for one screen point
C $9C24,3 Terrain collision test for one screen point
C $9C2C,3 Collision/overlap scan
b $9C32
c $9C35
C $9C81,3 Shadow screen address
N $9CBA Copy shadow screen to ZX screen
C $9CBD,3 Shadow screen address
C $9D33,3 Request sound effect A
C $9D39,3 Prepare the Room with color A
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
C $FB9D,3 play one note (advances the melody-index pointer internally via #R$FBB4/#R$FBC1)
C $FBA0,3 ROM KEY-SCAN: scans the keyboard, returns no-key-found as E=$FF
C $FBA3,3 if no key was found (E wraps to 0), loop back and play the next note
C $FBA6,2 re-enable interrupts and return (a key was pressed)
b $FBA8
W $FBAB,8,2
c $FBB4 Melody-index table reader/advancer, used by #R$FBD7
N $FBB4 Reads the next byte of the melody-index table (via the pointer at (HL)), advances the pointer, and returns it in A. If the byte is $40 (end-of-tune marker), jumps to #R$FBCF to reload the pointer from a loop-restart address instead.
c $FBC1 Melody-index to period lookup, used by #R$FBD7
N $FBC1 Converts a melody-index byte (from #R$FBB4, at (HL)) into an actual tone period by adding $0C and indexing into the period table at #R$FC64; returns the period in H, with L fixed at $01. E.g. index $29 (+$0C=$35) -> #R$FC64+$35 = $FC99 = $01.
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
C $FC3B,2 toggle speaker/border bit 4 -- produces the audible tone
t $FC30 NOTE: not a real string
N $FC30 Literal ASCII "adam" embedded as data/padding between code paths; possibly a programmer's signature.
c $FC34 Tone generator loop (continued)
N $FC34 Toggles the speaker bit via OUT ($FE),A, timed by DJNZ.
c $FC46 Plain delay loop (no sound)
N $FC46 Decrements a counter via $FBB3, with no OUT ($FE) calls.
C $FC53,6 shift a (self-modified) pointer's byte right 3 times (divide by 8) -- pure delay, no sound
b $FC64 Note/period table for the #R$FC04 tone generator
N $FC64 54 bytes: 53 descending values (= ascending pitch), indexed by #R$FBC1 as (melody-index byte + $0C), plus a trailing byte at $FC99 that is never actually read as a melody index (see #R$FC9A).
B $FC64,54,18
b $FC9A Melody-index table (start)
N $FC9A Each byte, +$0C then indexed into #R$FC64, gives the tone period for one note. Terminated by $40. #R$FBB4 stores the pointer as $FC99 but always increments before reading, so the first byte actually consumed is here at $FC9A ($29); +$0C=$35, and #R$FC64+$35=$FC99=$01. This table also happens to be reachable as code via #R$FBF1 (JP C,$FC9A -- 12x ADD HL,HL, a rarely/never-taken branch that reuses these bytes as opcodes; not its primary purpose).
b $FE34
b $FFCE

