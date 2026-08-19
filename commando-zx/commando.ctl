@ $5B00 org
b $5B00
b $5B11 Object records, 20 bytes wide
N $5B11 Enemy/object slots. +$00/$01 X/Y (current), +$02/$03 sprite frame/page (current), +$04/$05 X/Y (target), +$06/$07 sprite frame/page (next), +$08/$09/$0A clip bounds, +$0B flags (bit 2 flip, bit 4 wall-solid, bit 5 draw-active), +$11 AI delay timer, +$12 AI state. See #R$5BDA for the player's own instance and docs/Object-Record.md for the full field writeup.
B $5B11,,10
b $5BD9
B $5BD9,1 ?? = $90
N $5BDA Player's object record
B $5BDA,1 Starting column = $10
B $5BDB,1 Pixels down screen start point = $40
B $5BDC,1 Sprite frame index (+$02) = $02
B $5BDE,1 Target/new column (+$04)
B $5BDF,1 Target/new row (+$05)
B $5BE4,1 Y-axis clip bound (+$0A) = $0A
B $5BE5,1 Flags (+$0B): bit 2 sprite flip, bit 5 draw-active, see #R$9922 = $30
B $5BE6,1 Sub-state/type byte (+$0C), context-dependent, see #R$806B and #R$82C1
B $5BEB,1 Action delay timer (+$11), see #R$EB13
B $5BEE,1 ?? = $90
t $5CCD
b $5CD2
t $5CE9
b $5CEE
t $5CF4
b $5CF7
t $5D09
b $5D0E
t $5D29
b $5D32
b $6196
b $61F8
b $6308
b $6318
c $6400 Block of redirects
C $6400,3 => Abort
C $6403,3 => Delay by BC HALTs
C $6406,3 => System init
C $640C,3 => Print HL as 4-digit hex/BCD
C $6412,3 => Fill screen rectangle with byte
C $6415,3 => Update Score
C $6418,3 => Prepare New Game
C $641B,3 => Prepare at new Area
C $641E,3 => Set up attract/menu mode, then fall into the main menu
C $6421,3 => Game main loop / frame handler
C $6424,3 => XOR AF and AF' with every byte in $F900-F9FF
C $6427,3 => Scan $6648 table, call $65A5 for active entries
C $642A,3 => Find free slot in $6648 table
C $642D,3 => Trigger sound effect A into free slot at $6433
C $6430,3 => We've got A more grenades
b $6433
B $6433,7
W $6448,14
c $6456 Trigger sound effect A into free slot at $6433 (unconfirmed)
N $6456 Copies the byte at $643A+A into the active slot $6433+A to start sound A, or clears all seven slots when A=7.
R $6456 I:A Sound effect number (0-6, or 7 to silence all)
C $6458,2 Clear 7 bytes at $6433
C $645B,4 Destination = $6433 + A
C $6461,3 Source = $643A + A
C $6466,2 Copy byte into active slot
c $6469 Clear 7 bytes at $6433
c $6469 Clear 7 bytes at $6433
c $6474 Sound-effect dispatcher, 7 channels (unconfirmed)
N $6474 Scans the seven sound slots at $6433 for an active channel and dispatches to its handler through the address table at $6446, with the decay routine #R$6495 queued as the return.
C $6474,5 Scan $6433 slots for active sound
C $647B,3 Active slot? dispatch it
C $6482,6 Compute jump table entry, dispatch
C $648C,4 Load handler address from table
C $6490,3 Queue $6495 decay as return
c $6495 Decay sound-effect counters at $6433 (unconfirmed)
C $6495,3 Point at the 7 counters and rates
C $649E,3 Skip channels already silent
C $64A1,3 Subtract this channel's decay
C $64A4,2 Clamp to zero
c $64AB Play a two-stage sound stepped by counter $6434
N $64AB Plays a two-stage sound stepped by the counter at $6434: a higher pitch while it is under $0A and a lower one above, reloading the counter to $14 when it expires.
C $64AE,3 Expired? reload and stop
C $64B2,2 Pitch varies by counter phase
C $64BC,2 Play for $0C cycles
C $64BE,3 => Sound a square-wave beep
C $64C1,5 Reload counter to $14
c $64C7 Play beep tone (pitch $6437, duration loop) (unconfirmed)
C $64DA,3 get Border color
C $64DE,2 Set border color, toggle speaker bit
c $64E9 Sound param calc -> $6575 (uses $6438) (unconfirmed)
C $64F6,3 => Sound a square-wave beep
c $64F9 Sound param calc -> $6575 (uses $6439) (unconfirmed)
C $6502,3 => Sound a square-wave beep
c $6505 Sound param calc -> $6575 (uses $6436) (unconfirmed)
C $650C,3 => Sound a square-wave beep
c $650F Play a banded sound stepped by counter $6435
N $650F Plays a sound whose pitch band steps with the counter at $6435 (raw below $0A, then based at $12 or $1C for higher values) for a fixed 10-cycle duration via #R$6575.
C $6513,2 Pitch band by counter value
C $651C,3 Mid band: base $12 + low bits
C $6525,3 High band: base $1C + low bits
C $652E,2 Play for $0A cycles
C $6530,3 => Sound a square-wave beep
c $6533 Play a sound-effect tone (pitch from $6433)
N $6533 Turns the active sound parameter at $6433 into a pitch (base $88, or higher parameters mapped to a shorter period) and plays an 8-cycle beep via #R$6575.
C $6533,3 Read the sound parameter ($6433)
C $6538,2 Below $14? use the base pitch
C $653A,3 Higher: derive a pitch from it
C $6544,2 Play for 8 cycles
C $6546,3 => Sound a square-wave beep
C $654D,3 => Sound a square-wave beep
b $6550
c $6575 Sound a square-wave beep
N $6575 Sounds a square-wave beep by toggling the speaker for L half-cycle pairs, each half delayed by the pitch value in A so a smaller value gives a higher tone.
R $6575 I:A Pitch (inner delay per half-cycle)
R $6575 I:L Duration (number of cycles)
C $6576,7 Toggle speaker bit (tone half-cycle)
C $657E,3 Pitch delay loop
C $6581,9 Toggle speaker bit, set border color
C $658E,1 Count down the duration
c $6593 Scan $6648 table, call $65A5 for active entries
C $659E,3 Decrement counter, init menu record via IX=$6661 on zero
c $65A5 Tick an object's timer; when it runs out, rebuild its work record (unconfirmed)
N $65A5 Each call decrements a per-object countdown. Most calls just do that and return. When the timer hits zero it reloads to 3 and rebuilds the object's work record at $6661 -- copying its coordinates, picking sprite frames (with a small random wobble), and stamping the object onto the map -- so the object only redraws every few frames.
C $65A8,1 Tick the countdown
C $65AD,2 Expired: reload timer to 3
C $65B3,4 Point IX at the work record
C $65B8,3 Copy X coordinate into record
C $65C0,3 Copy Y coordinate into record
C $65C3,2 Read refresh reg for a random wobble
C $65D1,3 Derive first sprite frame/direction
C $65DE,3 Derive second sprite frame/direction
C $65EB,2 Flag record slot as spare
C $65EF,3 Stamp object onto the map
C $65DE,3 Menu key check, set carry/B=$12
C $65EF,3 Mark map cells for object IX, direction-aware
c $65F6 Menu key check, set carry/B=$12 (unconfirmed)
c $6600 Find free slot in $6648 table
N $6600 Walks the five fixed-size slots looking for one marked free, and if it finds one fills in the caller's address and a starting attribute so the slot becomes active.
R $6600 I:HL Address to store in the slot
R $6600 I:A Attribute seed (stored as A/2 + $13)
C $6600,5 Scan for slot marked $80 (free)
C $6614,7 Fill slot: address, active flag
C $661C,5 Store derived attribute value
c $6626 Prepare records and variables at $6648
N $6626 Initialises the object work-record at $6661 with its clip bounds and marks all five slots in the $6648 table as free ($80).
C $662A,4 Set record clip bounds
C $663A,8 Point at the 5 slots
C $6642,2 Mark each slot free ($80)
b $6648
B $6648,25,5 ??
b $668E
b $6692
b $66BA
b $66BE
b $66D1
B $66D1,64 ??
B $6711,64 ?? 4 * 16 bytes
c $6751 Set up scrolling string
C $6754,3 Set addr of scrolling string
C $6766,4 Set bit 3 of byte ($FD87)
c $676B Scroll the message banner one pixel left (unconfirmed)
N $676B Shifts the whole banner left by rotating each screen byte and pulling in the next pixel column from a small font-row buffer. A timer paces it so a fresh character is fed in only every few frames.
C $676B,4 Count down the scroll timer
C $6772,3 At zero, pull in the next character
C $6775,2 Two-pass pixel scroll
C $6777,3 Set up column/row counts
C $677E,3 Point at the font-row buffer
C $6786,2 Feed one font bit into the scroll
C $678A,2 Rotate it along the screen row
C $678F,4 Drop to the next screen line
C $6795,4 Step to the next screen third
c $679D Advance scroll-message pointer, copy next char's font row to $681E
N $679D Feeds the next character of the scrolling title message into the display buffer $681E: reads it via the pointer at $681B, wrapping at the $1F end marker, and copies its 7-row font glyph from $7D28.
C $679D,5 Reset scroll counter, load message pointer
C $67A5,5 Read char, check for end-of-message marker
C $67AE,2 Map space to glyph $2F
C $67B4,6 Look up font row for char, offset $7D28
C $67C4,2 Copy 7 font rows to buffer
C $67C7,6 End of message: rewind to start
t $67CE
B $681A
b $681B
W $681B,2 Address of current char in scrolling string
c $6825 Update Score
N $6825 Adds an amount to the BCD score at $FDE8 and redraws it. It ripples the increment through the score digits with decimal carry, then renders each digit from the $7EA8 font into the score display. If the high digit advanced past its stored value (IY+$69) it awards an extra life with a sound.
R $6825 I:B Value to add into the selected score digit
R $6825 I:C Digit position, counted from the right (0 = units)
C $6825,3 Get Score 2nd char
C $6837,2 Add increment to digit
C $6839,2 Decimal carry: subtract 10
C $6842,1 Store adjusted digit
C $685E,6 Copy font rows to score display
C $686E,3 Extra life if score digit advanced
C $6854,2 Font 2nd char address, lo byte
C $6857,2 Font address, hi byte
C $6874,3 Trigger sound effect A into free slot at $6433
C $6877,3 Address of variable - Lives player have
C $687A,1 plus one live
C $687B,1 Get Lives player have
C $6880,3 Print immediate string
B $6883,3 char $16: set position (col=$00, row=$15)
B $6886,2 char $19: set flag bit 0 ($FDAF) = $00
B $6888,2 char $18: set width counter ($FDB0) = $00
B $688A,2 char $10: set $FDA0 bits 0-2 = $07
B $688C,2 char $11: set $FDA0 bits 3-5 = $02
B $688E,1 char $1F: end of string
C $6890,2 number 0..9 -> char '0'..'9'
C $6892,3 Print Char
c $6896 Convert (H,L) screen coords to screen address
N $6896 Converts a packed row/column in HL to a screen address, halving the row to a character line via #R$98D9 and nudging down one pixel line when the row's low bit is set.
R $6896 I:H Row
R $6896 I:L Column
R $6896 O:HL Screen address
C $6898,2 Row / 2 to character line
C $689A,4 Column * 4
C $689E,3 Convert row number to screen line address
C $68A2,3 Odd row: nudge down a pixel line
c $68A6 Zero screen rows using SP as pointer (B rows)
N $68A6 Clears B screen pixel-rows starting at HL by pushing zero words through SP, advancing one pixel line (with third-boundary wrap) each iteration and restoring the real SP on exit.
R $68A6 I:HL Screen address
R $68A6 I:B Row count
C $68A6,4 Switch SP to HL, clear DE=0
C $68AE,1 Blank the row with pushed zero words
C $68B3,4 Check third boundary, wrap if needed
C $68C3,2 Loop next row
C $68C5,4 Restore SP
R $68A6 I:HL Start screen address
c $68CA Screen wipe/reveal transition, paced by $FDBC (unconfirmed)
N $68CA Runs one frame of the screen-wipe transition, stepped by the counter in $FDBC. It clears a band of screen rows around a boundary that moves with the counter (via #R$68A6), then repaints the attribute rows in a direction chosen by bits 5-6 of the counter. When the counter reaches $A1 the wipe is complete and it clears the busy flag (IY+$07 bit 2).
C $68CA,3 Read the wipe counter ($FDBC)
C $68CD,2 Finished at $A1?
C $68D6,2 Pick the wipe phase
C $68DB,3 Address on the screen
C $68DE,4 Rows to clear from the low bits
C $68E4,3 Zero screen rows using SP as pointer
C $68F2,3 DOWN HL
C $6902,3 Zero screen rows using SP as pointer
C $6907,3 Advance the wipe counter
C $690C,2 Fill attributes by direction
C $6923,3 Fill one attribute row
C $6928,3 Compute row attribute address, call $69B4
C $6948,3 Compute row attribute address, call $69B4
c $6950 Compute row attribute address, call $69B4 (unconfirmed)
N $6950 Draws the control-type indicator tile: derives the graphic page from the joystick type in $FDBC (bit 5 selecting a mirrored index) and paints it via #R$69B4 with count $0A.
C $6950,8 Save regs, check joystick type bit 5
C $695B,3 Read control type ($FDBC)
C $695F,2 Bit 5 selects mirrored variant
C $6963,2 Mirror the index
C $6967,2 Graphic page = index + $91
C $696D,3 Compute attribute address for tile
c $6975 Fill status-bar columns down, calling $699A per column (unconfirmed)
C $6975,6 Check idle flag ($FDBB), clear on match
C $6982,8 Set up fill byte/column loop
C $698D,8 Subtract row height, call $699A per column
c $699A Compute attribute address for fixed tile row (unconfirmed)
C $699A,8 Set up bank/pointer, L=5
C $69A5,4 Load row ($FDBB), set size BC=$0016
C $69AC,3 Compute attribute address for tile
c $69B4 Compute attribute address for tile (D,E)
R $69B4 I:D Row
R $69B4 I:E Column
C $69BD,3 Convert (H,L) screen coords to attribute address
C $69C6,3 Multiply HL by 10, add DE
c $69D2 Set up attract/menu mode, then fall into the main menu
C $69D2,4 Save the registers
C $69D7,4 Remember the stack pointer
C $69DB,3 System init
C $69DE,4 Set the menu-mode flag
C $69E2,3 Reset the print pointer
C $69EC,3 Clear the last key
C $69EF,3 Clear the joystick type
c $69F3 Top Score and Main Menu??
C $69F3,3 Print Score Table
C $69F6,3 Prepare status bar screen
C $69F9,3 Clear 7 bytes at $6433
C $69FC,3 Clear playfield and status screen/attribute areas
C $69FF,3 Set up scrolling string
C $6A02,3 Print credits screen, scroll text into $5923 area
C $6A05,3 Check menu keys
C $6A0A,3 Check menu keys
C $6A10,3 Clear playfield and status screen/attribute areas
C $6A14,2 'S' - Start game
C $6A16,3 => Start Game
C $6A19,2 'J' - Joystick
C $6A1B,3 => Select joystick type
c $6A1E Redefine Keys
C $6A1E,3 Print immediate string
B $6A21,2 char $15: set/clear flag bit 1 ($FDAF) = $00
B $6A23,2 char $11: set $FDA0 bits 3-5 = $02
B $6A25,2 char $10: set $FDA0 bits 0-2 = $07
B $6A27,2 char $18: set width counter ($FDB0) = $02
B $6A29,3 char $16: set position (col=$0C, row=$00)
B $6A2C,2 char $19: set flag bit 0 ($FDAF) = $01
T $6A2E,13
B $6A3B,3 char $16: set position (col=$16, row=$00)
B $6A3E,2 char $19: set flag bit 0 ($FDAF) = $00
B $6A40,2 char $18: set width counter ($FDB0) = $00
B $6A42,2 char $11: set $FDA0 bits 3-5 = $00
B $6A44,1 char $1F: end of string
C $6A45,3 Where to store redefined keys
C $6A4F,2 6 keys to redefine
C $6A51,3 Start address for messages to use in Redefine Keys
C $6A55,3 Print string HL
C $6A59,3 (HL) -> HL
C $6A5D,3 Wait key unpress, wait key press
C $6A62,3 Check if a key code is already assigned
C $6A72,3 Print key entered on Redefine Keys
C $6A75,3 Print immediate string
B $6A78,3 char $03: repeat character $04, $0D times
B $6A7B,1 char $1F: end of string
C $6A82,4 Set joystick type ($FD84) = Keyboard
C $6A86,3 Set up scrolling string
c $6A8C Check if a key code is already assigned (Redefine Keys)
R $6A8C O:Cy Set if the code is already in use
C $6A8C,3 Point at the six assigned keys
C $6A91,4 Match the first code byte
C $6A98,4 Second byte too? already used
C $6A9C,2 Flag the clash
b $6AA3 Messages to use in Redefine Keys
T $6AA3,2
B $6AA9
T $6AAB,4
B $6AAF,4
B $6AB3,2
T $6AB5,4
B $6AB9,4
B $6ABD,2
T $6ABF,5
B $6AC4,4
B $6AC8,2
T $6ACA,4
B $6ACE,4
B $6AD2,2
T $6AD4,7
B $6ADB,4
c $6AE1 Prepare status bar screen: fill, set scroll handler
C $6AEA,3 Fill screen rectangle with byte
C $6AEE,3 Reset the scroll counter
C $6AF4,3 Set the scroll handler
C $6AFB,3 Set up the graphic copy (5 rows)
C $6B06,4 Copy a row's 20 bytes
C $6B0D,3 DOWN HL
c $6B14 Wait key unpress, wait key press
C $6B14,3 Get last key read from keyboard
C $6B1A,3 Get last key read from keyboard
c $6B21 Clear playfield and status screen/attribute areas
C $6B2C,3 Fill screen rectangle with byte
C $6B35,3 Zero rectangle at HL
C $6B3F,3 Fill screen rectangle with byte
C $6B48,3 Zero rectangle at HL
c $6B4C Zero rectangle at HL (C rows x B bytes)
R $6B4C I:HL Start screen address
R $6B4C I:B Row count per column
R $6B4C I:C Column count
C $6B54,3 Convert row number to screen line address
C $6B60,3 DOWN HL
t $6B67 Letters to select from entering Top Score
T $6B67,,8
c $6B87 Draw menu box border/frame (unconfirmed)
R $6B87 I:A Attribute byte for the box border/frame
C $6B88,3 Isolate the PAPER bits
C $6B8B,4 Copy PAPER into INK too
C $6B95,3 Fill screen rectangle with byte
C $6B98,3 Clear the box interior
C $6B9E,3 Zero rectangle at HL
C $6BA8,3 Fill screen rectangle with byte
c $6BAC
C $6BAF,3 Advance level scroll
c $6BBB Start Game
C $6BBB,3 Prepare New Game
C $6BBE,3 Prepare at new Area
C $6BC7,3 Reset R register (random seed), inside $9193
C $6BCB,3 Clear 7 bytes at $6433
C $6BCE,3 Initialization and go to game main loop
C $6BD1,3 Clear 7 bytes at $6433
C $6BDA,3 Get last joystick/keyboard bits
C $6BE0,4 Is Player alive??
C $6BE4,2 => Successful end of the Area
N $6BE6 Player is dead
C $6BE9,1 Get player's grenades number
C $6BEE,2 Set player's grenades number to max allowed
C $6BF0,3 Update grenades number on the screen
C $6BF3,3 Print immediate string
B $6BF6,3 char $16: set position (col=$00, row=$15)
B $6BF9,1 char $1F: end of string
C $6BFA,3 Get lives player have
C $6C04,3 Minus one live
C $6C01,3 Print Char
C $6C07,3 => Game Over
N $6C1D Black screen at the end of an Area
C $6C1F,3 Draw menu box border/frame
C $6C22,3 Print immediate string
B $6C25,2 char $15: set/clear flag bit 1 ($FDAF) = $01
B $6C27,2 char $19: set flag bit 0 ($FDAF) = $01
B $6C29,3 char $16: set position (col=$14, row=$09)
T $6C2C,12
B $6C38,1 char $1F: end of string
C $6C39,3 Print Area number
C $6C3C,3 increase Area number
C $6C3F,3 Print immediate string
B $6C42,3 char $16: set position (col=$19, row=$06)
T $6C45,18
B $6C57,1 char $1F: end of string
C $6C58,3 Print Area number
C $6C5B,3 +2000
C $6C5E,3 Update Score
C $6C64,3 Delay by BC HALTs
C $6C67,3 Print immediate string
B $6C6A,3 char $16: set position (col=$00, row=$0D)
B $6C6D,1 char $1F: end of string
C $6C6E,3 Print Area number
C $6C71,3 Print immediate string
B $6C74,2 char $19: set flag bit 0 ($FDAF) = $00
B $6C76,1 char $1F: end of string
c $6C7A We've got A more grenades
C $6C7D,3 Update player's grenades number
c $6C80 Update grenades number on the screen
C $6C80,3 Print immediate string
B $6C83,2 char $10: set $FDA0 bits 0-2 = $07
B $6C85,2 char $11: set $FDA0 bits 3-5 = $02
B $6C87,2 char $19: set flag bit 0 ($FDAF) = $00
B $6C89,2 char $18: set width counter ($FDB0) = $00
B $6C8B,3 char $16: set position (col=$00, row=$1E)
B $6C8E,2 char $15: set/clear flag bit 1 ($FDAF) = $00
B $6C90,1 char $1F: end of string
C $6C91,3 Get player's grenades number
C $6C94,2 Print 2-digit number
c $6C96 Print Area number
C $6C96,3 Get Area number
c $6C99 Print 2-digit number A
R $6C99 I:A Number to print (0-99)
C $6C9D,2 minus 10
N $6CB5 Enter name for the new Top Score record
C $6CA3,3 Print Char
C $6CA9,3 Print Char
c $6CAE Game Over
C $6CAE,3 Find a place in Top Score table
C $6CB2,3 => Top Score and Main Menu??
C $6CC0,3 Print Score Table
C $6CC3,3 Prepare status bar screen
C $6CC6,3 Print immediate string
B $6CC9,3 char $16: set position (col=$0C, row=$01)
B $6CCC,2 char $13: set fill char ($FD9F) = $01
B $6CCE,1 char $1F: end of string
C $6CCF,3 Letters to select from entering Top Score
C $6CD2,2 4 rows
C $6CD4,2 8 columns
C $6CD8,3 Print Char
C $6CDD,3 Print Char
C $6CE2,3 Print immediate string
B $6CE5,3 char $03: repeat character $04, $0D times
B $6CE8,1 char $1F: end of string
C $6CEC,3 Print immediate string
B $6CEF,3 char $16: set position (col=$20, row=$01)
B $6CF2,2 char $18: set width counter ($FDB0) = $02
B $6CF4,2 char $19: set flag bit 0 ($FDAF) = $01
B $6CF6,2 char $11: set $FDA0 bits 3-5 = $01
T $6CF8,15
B $6D07,2 char $19: set flag bit 0 ($FDAF) = $00
B $6D09,2 char $11: set $FDA0 bits 3-5 = $00
B $6D0B,2 char $13: set fill char ($FD9F) = $00
B $6D0D,1 char $1F: end of string
C $6D30,3 Update object IX position, clip to screen, dispatch sprite draw
C $6D3B,3 Update object IX position, clip to screen, dispatch sprite draw
C $6D3E,3 Copy 64 bytes $66D1 to $6711
C $6D4A,3 XOR attribute pattern onto screen, explosion effect
C $6D4D,3 Get last key read from keyboard
C $6D53,3 Get last joystick/keyboard bits
C $6D5A,3 Print immediate string
B $6D5D,3 char $16: set position (col=$20, row=$01)
B $6D60,3 char $03: repeat character $20, $0F times
B $6D63,2 char $18: set width counter ($FDB0) = $03
B $6D65,1 char $1F: end of string
C $6D66,3 Prepare records at $6FD9
C $6D69,3 Prepare records at $6FE5
C $6D71,4 Check bit 4 (Fire) of Last joystick/keyboard bits ($FD85)
C $6D81,3 Find free record in table at $6FD9
C $6D84,3 Update the Top Score name-entry selectors
C $6D90,3 Print table row using $6E34
C $6D98,3 Update object IX position, clip to screen, dispatch sprite draw
C $6D9B,3 XOR attribute pattern onto screen, explosion effect
C $6D9E,3 Get last joystick/keyboard bits
C $6DCC,3 Get last joystick/keyboard bits
C $6DE0,3 Look up record entry for door/scroll trigger
C $6E02,3 XOR attribute pattern onto screen, explosion effect
b $6E08
c $6E11 Print table row using $6E34 (unconfirmed)
C $6E11,3 Point at the 8 records
C $6E1A,3 Skip inactive entries ($FF)
C $6E1E,3 Print char with derived attribute
C $6E23,3 Print char with derived attribute
C $6E27,4 Finished at $20? mark it done
c $6E34 Print char with derived attribute (unconfirmed)
R $6E34 I:A Row/position value
R $6E34 I:C Character code to print
C $6E34,4 Set the print position (opcode $16)
C $6E38,3 Print Char
C $6E3B,3 Column from the letter
C $6E42,4 Scale to a screen column
C $6E4B,3 Row from the letter
C $6E48,3 Print Char
C $6E55,3 Print Char
C $6E6E,3 Print Char
C $6E72,3 Print Char
C $6E76,3 Print Char
c $6E7B Update the Top Score name-entry selectors (unconfirmed)
C $6E7B,4 Walk the 4 selectors
C $6E81,4 Skip inactive selectors
C $6E8A,3 Count down its timer; select on zero
C $6E8F,3 Move the selector
C $6EAC,3 Convert the cursor to a grid cell
C $6EB4,3 Letters to select from entering Top Score
C $6EB7,3 HL = HL + A
C $6EBB,4 End marker? finish the name
C $6EC1,3 Draw/move the Top Score name-entry cursor
C $6EC7,3 Look up record in $6FE5 table, mask low bits
c $6ECD Draw/move the Top Score name-entry cursor (unconfirmed)
R $6ECD I:C Selected key/letter code
C $6ECE,3 Print immediate string
B $6ED1,2 char $18: set width counter ($FDB0) = $00
B $6ED3,1 char $16: opens (2 args) but string ends here -- dangling, never dispatched
B $6ED4,1 char $1F: end of string
C $6ED5,3 Cursor row into a print char
C $6ED9,2 Scale to the cursor glyph
C $6EDD,3 Print Char
C $6EE0,3 Cursor column into a print char
C $6EE6,3 Print Char
C $6EED,2 Special key ($3E)?
C $6EF9,3 Wrap the column at 9
C $6F07,3 Score table address
C $6F0E,3 HL = HL + A
C $6F1A,3 => Print Char
c $6F1D Name-entry outro: draw selectors, animate, clear (unconfirmed)
C $6F1D,4 Walk the 4 selectors
C $6F26,4 Draw each active one
C $6F31,2 Animate for 20 frames
C $6F36,3 Wait 4 frames
C $6F39,3 Print table row using $6E34
C $6F40,3 Clear playfield and status screen/attribute areas
c $6F46 Prepare records at $6FE5
c $6F52 Look up record in $6FE5 table, mask low bits (unconfirmed)
R $6F52 I:A Value to search for in the table
R $6F52 O:HL Matched or newly-claimed entry
C $6F52,4 Scan table for matching value C
C $6F60,3 Scan for a free ($FF) slot
C $6F65,2 Free slot?
C $6F6E,4 Mask found entry to 2 bits
C $6F74,4 Claim it with the value
c $6F79 Find free record in table at $6FD9
C $6F87,3 Check record slot free (byte = $FF)
C $6F92,3 Mark record active, set flag byte
C $6FA0,7 Compute animation frame index into (IX+$02)
C $6FBA,3 Convert row number to screen line address
c $6FC7 Prepare records at $6FD9
b $6FD9
B $6FD9,12,3
b $6FE5
c $6FF5 Look up record entry for door/scroll trigger (unconfirmed)
C $6FF5,3 Row index * 4 into A
C $6FFF,2 Stop at the strip end
C $7005,2 Sub-column position
C $700A,3 Extract high bits of B into new row
C $7012,3 Advance the column pointer
C $7017,3 Look up entry offset in $709A table
C $701A,3 HL = HL + A
C $701E,4 Nothing here? skip
C $7022,3 Record the feature
C $7029,3 Which way to scroll?
C $7032,3 => Copy 64 bytes $66D1 to $6711
C $703D,3 Scroll the tile buffer left
C $7045,3 Rotate one column's bits left
C $7057,3 Scroll the tile buffer right
c $706E Unpack $66D1 record, scale coordinate x4 (unconfirmed)
C $706E,3 Source records ($66D1)
C $7071,3 Destination buffer ($6711)
C $7078,3 Read the 3 packed bytes
C $707F,4 Scale the value left x4
C $708C,3 Write the 4-byte record
b $709A
c $70BD XOR attribute pattern onto screen, explosion effect (unconfirmed)
C $70BD,4 Column * 4
C $70C3,3 Row from ($FDB2)
C $70C9,3 Convert row number to screen line address
C $70CE,3 Pattern source ($6711)
C $70D1,4 XOR 4 pattern bytes onto the row
C $70E6,3 DOWN HL
c $70EC Copy 64 bytes $66D1 to $6711
c $70F8 Find a place in Top Score table
R $70F8 O:A Rank found, 0 if the score does not place
C $70F8,3 Score address
C $70FB,3 Point at the table entries
C $7102,3 Skip to the next entry start
C $710C,4 Beat this entry?
C $711A,2 No place: return zero
C $711D,3 Remember the rank
C $712C,2 Shift lower entries down
C $7132,3 Blank the freed slot
C $713F,2 Copy the score in
C $7123,3 Top score #10 last char address
C $7126,3 Top score #11 last char address
C $7129,3 Top score line width = 15
c $7143 Select joystick type
C $7143,3 Print immediate string
B $7146,2 char $11: set $FDA0 bits 3-5 = $02
B $7148,2 char $10: set $FDA0 bits 0-2 = $07
B $714A,2 char $18: set width counter ($FDB0) = $02
B $714C,3 char $16: set position (col=$0C, row=$00)
B $714F,2 char $15: set/clear flag bit 1 ($FDAF) = $00
B $7151,2 char $19: set flag bit 0 ($FDAF) = $01
T $7153,6
B $7159,3 char $16: set position (col=$13, row=$00)
B $715C,2 char $19: set flag bit 0 ($FDAF) = $00
B $715E,2 char $11: set $FDA0 bits 3-5 = $00
T $7160,10
B $716A,3 char $03: repeat character $07, $0D times
T $716D,14
B $717B,3 char $03: repeat character $07, $0D times
T $717E,8
B $7186,3 char $03: repeat character $07, $0D times
T $7189,8
B $7191,1 char $1F: end of string
C $7192,3 Wait key unpress, wait key press
C $7195,2 < '1' ?
C $7199,2 >= '5' ?
C $719D,2 char '1'..'4' -> number 1..4
C $71A2,3 Set up scrolling string
c $71A8 Print string HL
C $71AD,3 Print Char
b $71B2 Screen attributes, 4 bytes
c $71B6 Print credits screen, scroll text into $5923 area (unconfirmed)
C $71D1,3 Source text ($71B2)
C $71D4,3 Screen destination ($5923)
C $71D9,4 Copy 10 chars per line into screen
C $71E1,2 Gap to the next line
C $71EB,3 Arm the screen-wipe counter
C $71EE,3 Set the wipe handler
C $71B6,3 Print immediate string checking menu keys
B $71B9,11
T $71C4,12
B $71D0,1
C $71F8,3 Print immediate string checking menu keys
B $71FB,5
T $7200,30,15
T $721E,20,20
T $7232,17,17
T $7243,12,12
B $724F,1
c $7251 Check menu keys
C $7251,3 Get last key read from keyboard
C $7254,2 'S' - Start game
C $7257,2 'J' - Joystick
C $725A,2 'K' - Redefine keys
c $725D Print immediate string checking menu keys
C $725D,1 Wait a frame
C $725E,3 Check menu keys
C $7261,3 Key pressed? stop
C $7264,3 Fetch the next char
C $7267,2 End of string?
C $726A,3 Print Char
c $7274 Print Score Table
C $7275,2 Set border black
C $7277,3 Print immediate string
B $727A,1 char $01: reset print format state
B $727B,2 char $00: clear screen, attribute = $07
B $727D,2 char $15: set/clear flag bit 1 ($FDAF) = $01
B $727F,1 char $1F: end of string
C $728A,3 Fill screen rectangle with byte
C $728D,3 Print immediate string
B $7290,2 char $13: set fill char ($FD9F) = $11
B $7292,3 char $16: set position (col=$0C, row=$11)
B $7295,2 char $19: set flag bit 0 ($FDAF) = $00
B $7297,1 char $1F: end of string
C $7298,3 Score table address
C $729B,2 11 = score table lines count
C $72A0,3 Print Char
C $72A8,3 Print Char
C $72AB,3 Print Char
t $72B2 Score table
T $72B2,,15
c $7357 Game main loop / frame handler
C $7371,3 Compute code checksum
C $7374,3 Read input
C $7377,3 Save the input
C $738A,3 Sound-effect dispatcher, 7 channels
C $7391,3 !!! Modifying argument: $6975 / $68CA
C $73A1,3 => Delay by BC-1 HALTs
C $73A4,3 Read Keyboard
C $73A7,3 Save last key read from keyboard
C $73B2,3 Shift scroll pattern into left border column
c $73B7 Read Keyboard
C $73C0,9 Scan half-row, invert bits, loop to next row if no key down
C $73D1,4 Key found: set carry marker, clear column counter
C $73D5,6 Rotate to find pressed column, advance HL to its map entry
C $73DB,1 Look up char for (row,column) from keyboard map
N $73DD Keyboard map
T $73DD,40,5
c $7405 Compute code checksum
C $7405,13 Skip check if pointer outside $8000-$EFFF
C $7412,4 Fold in the adjacent byte too, then advance
C $7416,4 Aim at page $80, clear the accumulator
C $741A,2 XOR page $80
C $742A,1 XOR page $88
C $743A,1 XOR page $90
C $744A,1 XOR page $98
C $745A,1 XOR page $A0
C $746A,1 XOR page $A8
C $747A,1 XOR page $B0
C $748A,1 XOR page $B8
C $749A,1 XOR page $C0
C $74AA,1 XOR page $C8
C $74BA,1 XOR page $D0
C $74CA,1 XOR page $D8
C $74DA,1 XOR page $E0
C $74EA,1 XOR page $E8
C $74F8,1 XOR page $EF, last of the sweep
C $74FA,2 Then skip to page $FA
C $74FC,1 XOR page $FA into the sum
C $74FF,7 Fold in checksum from $7511, store to ($FD8D)
C $7509,8 Store both checksum halves to ($FD8D) and ($FD8E)
C $7506,3 XOR AF and AF' with every byte in $F900-F9FF
c $7511 XOR AF and AF' with every byte in $F900-F9FF
C $7511,3 Set up loop pointer to $F900
C $7514,1 #0
C $7517,1 #1
C $751A,1 #2
C $751D,1 #3
C $7520,1 #4
C $7523,1 #5
C $7526,1 #6
C $7529,1 #7
C $752C,1 #8
C $752F,1 #9
C $7532,1 #10
C $7535,1 #11
C $7538,1 #12
C $753B,1 #13
C $753E,1 #14
C $7541,1 #15
c $7547 Read input: joystick or keyboard
C $7549,3 Get joystick type 0..4
C $754D,3 => Read keyboard in game mode
C $7554,3 HL = HL + A
C $7557,3 (HL) -> HL
C $755A,1 Go to joystick read procedure
W $755B,8,8 Joystick read procedure addresses
N $7563 Read Kempston
N $7569 Read Interface II
B $7570,10 Keyboard ports + bit masks for cursor keys
N $757A Read Fuller
N $7587 Read Cursor
B $758E,10 Keyboard ports + bit masks for cursor keys
b $7598 Keyboard ports and bit masks - keys to read in game mode
c $75A8 Read keyboard in game mode
C $75A8,5 Set up bit mask, port table pointer
C $75AD,5 Read port, test key bit
c $75BE Fill screen rectangle with byte
C $75BE,4 Fill row bytes, count in B
C $75C5,4 Advance column, wrap to next third
R $75BE I:HL Start screen address
R $75BE I:B Row count per column
R $75BE I:C Column count
R $75BE I:A Fill byte
c $75D2 Print key entered on Redefine Keys
R $75D2 I:A Key entered - character or special code
C $75DE,3 => Print Char
C $75E1,3 Print immediate string
B $75E4,3 char $03: repeat character $08, 5 times (erase old label)
T $75E7,6
B $75ED,1 char $1F: end of string
C $75EF,3 Print immediate string
B $75F2,3 char $03: repeat character $08, 3 times (erase old label)
T $75F5,4
B $75F9,1 char $1F: end of string
C $75FB,3 Print immediate string
B $75FE,3 char $03: repeat character $08, 4 times (erase old label)
T $7601,5
B $7606,1 char $1F: end of string
C $7608,3 Print immediate string
B $760B,3 char $03: repeat character $08, 4 times (erase old label)
T $760E,5
B $7613,1 char $1F: end of string
c $7615 Print immediate string
C $761C,3 Print Char
c $7621 Print HL as 4-digit hex/BCD (unconfirmed)
C $7621,4 Print high byte via $7626
C $7626,5 Save value, shift high nibble
c $7637 Print Char
R $7637 I:A Character to print
N $7637 Chars $20 and up print directly. Chars $00-$1F are special-char opcodes: the opcode is looked up in the $78CC arg-count table (0, 1 or 2 extra bytes) and stored to ($FDA8); ($FDA7) is set to that count and acts as a state counter for the following calls to this routine. While ($FDA7) > 0, each call stores the char as an argument byte at ($FDA9) instead of printing it, advances ($FDA9), and decrements ($FDA7). Once the argument count reaches zero (with 0 args, immediately; otherwise after the last argument byte), execution jumps to $7675, which looks up ($FDA8) in the $78EC word table (32 handler addresses, one per opcode $00-$1F) and calls the matching handler with HL pointing at the collected argument bytes ($FDAB onward).
C $7639,3 get Special-char argument counter
C $7641,3 get Special-char argument write pointer
C $7646,3 set Special-char argument write pointer
C $7649,3 get Special-char argument counter
C $764D,3 set Special-char argument counter
C $7657,2 $00..$1F ?
C $7659,3 no => jump
N $765C Process a special char $00..$1F
C $7662,3 HL = HL + A
C $7665,1 A = $00..$02
C $7666,3 set Special-char argument counter
C $766F,3 set Special-char argument write pointer
C $767C,3 HL = HL + A
C $767F,3 (HL) -> HL
C $76AC,3 Trigger sound effect A into free slot at $6433
C $76B2,3 Delay by BC HALTs
N $7687 Print usual char >= $20
C $76BC,4 Get Font address
C $76C8,3 Convert row number to screen line address
C $76DF,3 DOWN HL
C $7703,3 DOWN HL
C $770F,3 DOWN HL
C $7719,3 DOWN HL
C $7734,3 get Print attribute
C $7754,3 HL = HL + A
C $7757,3 (HL) -> HL
b $775F
W $775F,8
c $7767 Char $02: set spacing/mode ($FDB1) from arg, range 0-3
C $776C,3 => -> $7A10
C $7771,3 => -> $7A10
c $777A Char $00: clear screen (attributes + bitmap)
C $777C,3 Get attribute byte
C $7782,3 Fill all screen attributes with D
C $76BB,1 HL = HL * 8
C $778B,3 Clear all the screen bits
C $778F,3 Fill all screen attributes with D
c $7795 Fill all screen attributes with D
c $77A4 Char $04: advance format counter by 2, store fill char (unconfirmed)
C $77A8,3 get Fill char for special-char codes $0C/$13/$0D/$09 = $00
c $77AC Char $0A: increment format counter, abort if it reaches $31
C $77B2,3 => -> $7A10
c $77B8 Char $0B: decrement format counter, abort on underflow
C $77BC,3 => -> $7A10
c $77C2 Char $08: decrement format counter, abort if negative
C $77C5,3 => -> $7A10
c $77CB Char $09: increment format counter, store fill char once $20 reached
c $77D5 Char $12: set/clear bit 6 of $FDA0 from arg (0/1)
C $77D8,3 Clear the old bit 6
C $77DF,2 Reject args >= 2
C $77E1,3 => -> $7A10
C $77E4,3 Arg to bit 6, merge in
c $77EB Char $19: set/clear flag bit 0 ($FDAF) from arg
C $77F3,3 => -> $7A10
c $77FD Char $10: set field bits 0-2 of $FDA0 from arg
C $7809,3 => -> $7A10
c $7811 Char $11: set field bits 3-5 of $FDA0 from arg
C $7814,3 Clear the old PAPER bits
C $781B,2 Reject values >= 8
C $781D,3 => -> $7A10
C $7820,3 Shift the arg into bits 3-5
c $7828 Char $16: set print position, 2 bounds-checked args
C $782D,3 => -> $7A10
C $7837,3 => -> $7A10
c $783E Char $03: repeat character H, L times
C $7842,3 Print Char
c $784A Char $13: set fill char ($FD9F) from arg
C $784D,3 set Fill char for special-char codes $0C/$13/$0D/$09 = $00
c $7852 Char $14: set tab stop, advance format counter
C $7857,3 => -> $7A10
c $7866 Char $1A: set Font address ($FDA3) from arg word
C $7869,3 set Font address = $7EA0
c $786E Char $0C: print padded field using $FDB0 width
C $7875,3 Print immediate string
B $7878,1 char $08: decrement format counter, abort if negative
B $7879,1 literal space char
B $787A,1 char $08: decrement format counter, abort if negative
B $787B,1 char $1F: end of string
c $787F Char $18: set width/column counter ($FDB0) from arg
c $7887 Char $15: set/clear flag bit 1 ($FDAF) from arg
c $7896 Char $01: reset print format state
C $7898,3 set Print attribute
C $78A1,3 set Fill char for special-char codes $0C/$13/$0D/$09 = $00
C $78B0,3 Font address
C $78B3,3 Set Font address
c $78BF -> $7A10
C $78BF,3 => Abort
b $78C2
c $78C4
c $78C7
b $78CC Table to map special char $00..$1F to types $00..$02
w $78EC Address map to print chars $00..$1F - 32 addresses
W $78EC,2 char $00, 1 arg: clear screen (attributes + bitmap)
W $78EE,2 char $01, 0 args: reset print format state
W $78F0,2 char $02, 1 arg: set spacing/mode ($FDB1), range 0-3
W $78F2,2 char $03, 2 args: repeat character H, L times
W $78F4,2 char $04, 0 args: advance format counter by 2, store fill char (unconfirmed)
W $78F6,2 char $05, unused (no-op)
W $78F8,2 char $06, unused (no-op)
W $78FA,2 char $07, unused (no-op)
W $78FC,2 char $08, 0 args: decrement format counter, abort if negative
W $78FE,2 char $09, 0 args: increment format counter, store fill char once $20 reached
W $7900,2 char $0A, 0 args: increment format counter, abort if it reaches $31
W $7902,2 char $0B, 0 args: decrement format counter, abort on underflow
W $7904,2 char $0C, 0 args: print padded field using $FDB0 width
W $7906,2 char $0D, 0 args: store fill char at HL
W $7908,2 char $0E, unused (no-op)
W $790A,2 char $0F, unused (no-op)
W $790C,2 char $10, 1 arg: set field bits 0-2 of $FDA0
W $790E,2 char $11, 1 arg: set field bits 3-5 of $FDA0
W $7910,2 char $12, 1 arg: set/clear bit 6 of $FDA0
W $7912,2 char $13, 1 arg: set fill char ($FD9F)
W $7914,2 char $14, 1 arg: set tab stop, advance format counter
W $7916,2 char $15, 1 arg: set/clear flag bit 1 ($FDAF)
W $7918,2 char $16, 2 args: set print position, bounds-checked
W $791A,2 char $17, unused (no-op)
W $791C,2 char $18, 1 arg: set width/column counter ($FDB0)
W $791E,2 char $19, 1 arg: set/clear flag bit 0 ($FDAF)
W $7920,2 char $1A, 2 args: set Font address ($FDA3)
W $7922,2 char $1B, unused (no-op)
W $7924,2 char $1C, unused (no-op)
W $7926,2 char $1D, unused (no-op)
W $7928,2 char $1E, unused (no-op)
W $792A,2 char $1F, unused (no-op)
c $792C Prepare at new Area
C $7953,4 Clear Player's dead flag
C $792D,3 Clear last joystick/keyboard bits
C $7930,3 Clear Land space size
C $7933,3 Clear Offset in $FF00 buffer
C $795B,3 Init $FF00 buffer entries
C $795E,3 Prepare records and variables at $6648
C $7963,3 Draw menu box border/frame
c $796A Prepare New Game
C $7971,3 set Special-char argument counter
C $7978,10 Score = "000000"
C $7975,3 Area number = $01
C $798B,4 Set border black
C $7982,5 Player's lives = $05
C $7988,3 Set grenades number = $06
C $798F,3 Print immediate string
B $7992,1 char $01: reset print format state
B $7993,2 char $00: clear screen, attribute = $30
B $7995,2 char $15: set/clear flag bit 1 ($FDAF) = $00
B $7997,3 char $16: set position (col=$00, row=$00)
B $799A,2 char $18: set width counter ($FDB0) = $00
B $799C,2 char $19: set flag bit 0 ($FDAF) = $00
B $799E,2 char $11: set $FDA0 bits 3-5 = $02
B $79A0,2 char $10: set $FDA0 bits 0-2 = $07
T $79A2,32
B $79C2,1 char $1F: end of string
c $79CA System init: interrupt table, screen-line table, checksums
N $79CA One-time setup: builds the interrupt vector table ($FB00), the $FE00 even-screen-line table and the checksum reference, then initialises the IY-based system variables.
C $79CF,3 Set up interrupt vector table at $FB00
C $79D2,3 Prepare $FE00 table - addresses for every even screen line
C $79D5,3 Calculate checksums
C $79D8,4 Clear byte ($FD87)
C $79DC,4 Set byte ($FDC2) = $02
c $79E1 Init $FF00 buffer entries (32 slots, unconfirmed)
C $79E1,3 Buffer pointer, 32 entries
C $79E8,4 Fill first two bytes of entry
C $79F2,3 Zero the rest of the entry
C $79F7,3 Next entry
c $79FB Build the $FA00 column-checksum table
C $79FB,3 Source page $8000
C $79FE,3 Checksum buffer $FA00
C $7A01,3 112 rows, clear the total
C $7A04,2 XOR the next row
C $7A08,2 Store the column checksum
C $7A0A,3 Move to the next column
c $7A10 Abort: restore stack and interrupts, return to frame loop
N $7A10 Abort path: restores the saved stack ($FD80) and the IY/HL context off it, switches back to IM 1 and re-enables interrupts before returning to the frame loop.
C $7A11,4 Restore saved stack pointer
C $7A16,2 Restore IY/HL context
C $7A1A,2 Back to IM 1
c $7A1E Set up interrupt vector table at $FB00 (unconfirmed)
C $7A1E,6 Copy IM2 vector byte, fill $FB00 table
C $7A2E,5 Terminate table, copy 3 more bytes
c $7A42 Game main loop / frame handler (redirect)
C $7A42,3 => Game main loop / frame handler
c $7A45 Prepare $FE00 table - addresses for every even screen line
C $7A45,2 128 even lines
C $7A47,3 Screen start $4000
C $7A4A,3 Table at $FE00
C $7A4D,4 Store the line address
C $7A52,3 DOWN HL
C $7A55,3 DOWN HL
c $7A5C Delay by BC HALTs
b $7A63
t $7A6A
b $7A6D
b $7A88
b $7B0A
b $7B15
b $7B3D
b $7B47
b $7BB6
b $7BCA
b $7DC4
b $7EA0 Font
D $7EA0 #HTML[#UDGARRAY16($7EA0-$7F1F-8)(font0.png)]
. #HTML[#UDGARRAY28($7F20-$7FFF-8)(font1.png)]
b $8000
c $8003 Advance level scroll: walk $FF00 buffer, process sequence record (redirect)
C $8003,3 => Advance level scroll
c $8006 Reset R register (random seed), inside $9193 (redirect)
b $8009
c $800C Multiply HL by 10, add DE (redirect)
C $800C,3 => Multiply HL by 10, add DE
c $800F Mark map cells for object IX, direction-aware (redirect)
C $800F,3 => Mark map cells for object IX, direction-aware
b $8012
c $806B Mark map cells for object IX, direction-aware
R $806B I:IX Address of the 20-byte object record
C $8086,3 Mark cells in $1600 map, B=1
C $808D,3 Mark cells in $1600 map, B=1
C $8092,3 Mark cells in $1600 map, B=C
C $8096,3 Mark cells in $1600 map, B=C
C $809A,3 Mark cells in $1600 map, B=C
C $80AC,3 Mark 3 cells in $1600 map, B=1
C $80B1,3 Mark 3 cells in $1600 map, B=C
C $80C7,3 Mark 3 cells in $1600 map, B=C
C $80D0,3 Mark 3 cells in $1600 map, B=1
C $80D3,3 => Update object IX position, clip to screen, dispatch sprite draw
C $80D6,3 Mark cells in $1600 map, B=1
C $80DA,3 Mark cells in $1600 map, B=1
C $80DE,3 Mark cells in $1600 map, B=1
C $80E1,3 => Update object IX position, clip to screen, dispatch sprite draw
c $80E4 Mark 3 cells in $1600 map, B=1 (entry to $80ED)
c $80EA Mark 3 cells in $1600 map, B=C (entry to $80ED)
C $80EE,3 Set/test flag in $1600 map at tile
C $80F2,3 Set/test flag in $1600 map at tile
C $80F6,3 Set/test flag in $1600 map at tile
c $80FB Mark cells in $1600 map, B=1 (entry to $8104)
c $8101 Mark cells in $1600 map, B=C (entry to $8104)
C $8105,3 Set/test flag in $1600 map at tile
C $810C,3 Set/test flag in $1600 map at tile
C $8113,3 Set/test flag in $1600 map at tile
C $811D,3 Set/test flag in $1600 map at tile
c $8122 Set/test flag in $1600 map at tile (D,E)
R $8122 I:D Row
R $8122 I:E Column
R $8122 I:B $01 = test only, else set
C $8123,3 Reject if column (E) out of range
C $8126,4 Reject if row (D) out of range
C $812F,2 Column * 4 into A
C $8131,7 Compute $1600 map row base into H
C $813C,3 B=1: test flag only
C $8147,4 Merge flag bits, write back
b $8158
t $8160
b $8163
t $81B7
b $81BA
t $81E7
b $81EA
t $820A
b $820D
c $822B Update vehicle position/state, drift toward player (unconfirmed)
C $822B,8 Load object at $FDCF, check flag bit 7
C $8244,6 Check flags, clear ($FDDB) if all clear
C $824F,9 Decrement scroll counters, adjust position
C $8275,3 Advance/rotate object buffer pointer
C $827E,3 Advance/rotate object buffer pointer
C $8287,3 Set object state flags, call $806B
b $82B4 Data 13 bytes to copy at $FDCF
c $82C1 Set object state flags, call $806B (unconfirmed)
R $82C1 I:IX Address of the 20-byte object record
R $82C1 I:E New direction/type value
C $82C1,3 Store the facing into the record
C $82C8,3 Special sprite if the flag is set
C $82D1,3 Mark map cells for object IX, direction-aware
C $82D5,4 Keep the flags if bit 5 is set
C $82DA,3 Merge in the new flag bits
c $82E1 Advance/rotate object buffer pointer (unconfirmed)
C $82E1,6 Save/restore pointer around $82C1 call
C $82F4,5 Bump ($FDD3) and ($FDCF) counters by 3
C $82E9,3 Set object state flags, call $806B
b $8301
c $834B Draw sprite HL
N $834B Draws a pre-shifted sprite by pointing the stack at its data buffer and popping bytes straight into screen memory, row by row, after clipping.
R $834B I:A Attribute/color byte for the sprite
R $834B I:B Sprite height??
R $834B I:D Row
R $834B I:E Column
R $834B I:HL Sprite address
C $834B,5 Save/restore alt HL across bank switch
C $8352,3 Clip sprite rectangle against screen edge
C $8356,4 Save alt HL for later position calc
C $835B,1 Add the clip offset to the address
C $8361,2 Check attribute bit 6, choose draw variant
C $836C,1 Remember the row's start
C $836E,4 Copy sprite bytes into the screen row
C $837B,2 Down to the next pixel line
C $838D,3 Cross into the next screen third
C $839C,2 Loop the rows
C $8363,3 Compute screen draw address for sprite, save state to buffer
b $83A4
c $83B8 Update and draw the Jeep sprite (unconfirmed)
C $83B8,5 Read Jeep flag ($FDCB), check active
C $83BF,5 Decrement position, get absolute value
C $83C9,7 Clamp to bound $32, then $1E
C $83D4,2 Deactivate Jeep when position under $04
C $83DC,2 Off-screen edge: clear flag bit, redraw
C $83E4,3 Sprite draw dispatch
C $83EE,3 => Find free slot in $6648 table
C $83F5,2 Test sprite direction bit
C $83F9,3 Clip sprite rectangle against screen edge
C $8401,3 Compute screen draw address for sprite, save state to buffer
C $8422,3 Compute screen draw address for sprite, save state to buffer
C $842B,3 Get sprite addr Jeep; width 4
c $8458 Update Motorbike/Jeep type state (unconfirmed)
C $8458,7 Save state ($FDCE), read Motorbike flag ($FDC7)
C $8460,6 Check flag: -1 sentinel or mask to 2 bits
c $8471 ?? Smth about Motorbike
C $847D,3 ?? Smth with Motorbike sprite
C $8484,3 Get pseudo-random value / update counter at (HL)
C $848F,3 Get pseudo-random value / update counter at (HL)
c $8497 Animate and draw the object at $FC06 (Motorbike?) (unconfirmed)
N $8497 Animates and draws an object held in the $FC06 sprite buffer. A per-frame timer in $FDCE steps the animation frame, slowing at the higher frames, with a small random wobble. The chosen frame is then drawn -- one special frame paints a solid block, otherwise the sprite is clipped and blitted from the buffer.
R $8497 I:HL Address of the frame counter byte
C $8497,3 Read the frame counter, hold if idle
C $849C,3 Count down the frame timer
C $84A2,3 Reload and step the frame
C $84A6,4 Slow the animation at high frames
C $84AE,2 Store the new frame
C $84B0,2 Random-bump (HL) using R register
C $84BA,3 Halve the frame into a sprite index
C $84BF,2 Special frame?
C $84C1,3 => Sprite draw dispatch
C $84C4,2 Set the sprite width
C $84C6,3 Clip sprite rectangle against screen edge
C $84CD,4 Point at the sprite buffer
C $84DA,4 Copy sprite bytes into the row
c $8500 ?? Smth with Motorbike sprite
C $8500,5 Check Motorbike state counter ($FDCE)
C $8511,12 Copy full Motorbike sprite from ($C02E) to $FC06
C $851D,2 Set up the 24-row shift loop
C $851F,3 Point at the sprite buffer
C $8522,1 Remember this row's start
C $8523,2 1st shift: row byte 1
C $8526,2 ...byte 2
C $8529,2 ...byte 3
C $852C,2 ...byte 4
C $852F,2 ...byte 5
C $8532,2 ...byte 6
C $8534,1 Restart at the row's start
C $8535,2 2nd shift: row byte 1
C $8538,2 ...byte 2
C $853B,2 ...byte 3
C $853E,2 ...byte 4
C $8541,2 ...byte 5
C $8544,2 ...byte 6
C $8547,2 Next row
C $8511,3 Get sprite addr Motorbike
c $854A Sprite draw dispatch: clip and compute screen address
N $854A Clips a rectangle and works out its screen address, then fills it with zero bytes a row at a time (two halves per row) using the stack -- painting a solid block where the sprite goes.
C $854A,5 Compute index HL = C*2-1
C $8553,3 Clip sprite rectangle against screen edge
C $8557,4 Set width C=$01 for draw address calc
C $8562,2 Add the clip offset to the address
C $856C,4 Point the stack at this screen row
C $8570,3 Blank the left half of the row
C $8577,3 Blank the right half
C $857B,3 Cross into the next screen third
C $858B,3 Loop the rows
C $855B,3 Compute screen draw address for sprite, save state to buffer
b $8594
c $85AB Update and draw the Truck(s)
N $85AB Manages the truck objects: bails out if none are active, otherwise readies the truck sprite buffer and ticks each truck's timer -- drawing it while it counts down, and spawning a replacement plus a final sprite when it expires.
C $85AE,2 First truck slot active?
C $85B4,3 Bail if the second is idle too
C $85B8,2 Randomly jitter the truck timers
C $85C4,3 Get Truck sprite to $6300 buffer and shift it if needed
C $85D0,4 Truck record inactive? stop
C $85D4,3 Count the timer down; spawn on zero
C $85DA,3 Not ready to draw yet
C $85DE,3 Draw two-part sprite from record at HL
C $85E7,4 Spawn: decode the record address
C $85F9,3 Find free slot in $6648 table
C $8601,3 Find free slot in $6648 table
C $8605,3 Reclaim the slot
C $8612,3 Draw the final truck sprite
C $8615,3 => Sprite draw dispatch
c $8618 Draw two-part sprite from record at HL (unconfirmed)
R $8618 I:HL Address of the 2-byte sprite record
C $8618,8 Read frame byte, extract type into E
C $8621,4 Read attribute (D), set size $1010
C $862A,4 Draw first part, C=$04
C $8625,3 Clip sprite rectangle against screen edge
C $862E,3 Compute screen draw address for sprite, save state to buffer
C $8639,3 Compute screen draw address for sprite, save state to buffer
C $8632,2 Offset second part 8 columns right
C $8641,2 Double row count for both halves
C $8649,4 Save SP, repurpose as sprite-data pointer
C $864F,1 Blit row: pop pixel words, store to screen
C $8664,1 Advance to next pixel line, handle char/third wrap
C $8676,4 Restore SP
c $867C Clip sprite rectangle against screen edge (vertical)
N $867C Clips a sprite against the top and bottom screen edges, trimming its height and start row. Returns the screen address of its first visible line, with carry set if it falls entirely off-screen.
R $867C I:D Row
R $867C I:B Sprite height
C $867C,3 Check the row against the bottom
C $8681,2 Distance from the top edge
C $8683,2 Fully on-screen? skip the clip
C $8688,4 Otherwise clip rows off the top
C $8693,3 Multiply HL by 10, add DE
C $869B,4 Off bottom: reduce the visible height
C $86A0,3 Clamp to the screen edge
C $86A4,4 Final visible height into D
C $86B0,2 $FE00 - table of even screen lines addresses
C $86B2,3 Fold in the column offset
c $86B8 Get Truck sprite to $6300 buffer and shift it if needed
C $86B8,4 Reload only on the 8-pixel boundary
C $86BC,3 Get sprite addr Truck; width 8
N $86C7 Shift 8*32 bytes at $6300 one bit left
C $86CB,3 Buffer address
C $86D1,2 Loop counter = 32
C $86D3,2 Step to the next row
C $86D8,3 Shift the low word left
C $86DD,3 Carry into the next word
C $86EE,2 Loop the 32 rows
c $86F5 Draw the truck/vehicle sprite (unconfirmed)
C $86F5,3 Reject if the row is off-screen
C $86FC,2 Pick the draw path (bit 7)
C $8702,3 Choose the sprite by column
C $8711,3 Solid-block path: draw it
C $8716,3 Sprite draw dispatch
C $871A,4 Move up for the effect slots
C $8721,3 Find free slot in $6648 table
C $872A,3 Find free slot in $6648 table
c $872F Fill attribute cells below sprite via SP push (unconfirmed)
N $872F Paints a short block of dark attribute cells beneath a sprite -- its shadow/ground strip -- one row at a time, using the stack to blast 16 cells per row.
R $872F I:D Row
C $872F,4 Skip if the row is off the bottom
C $8734,2 Only act on every fourth row
C $8737,2 Default to four rows
C $8739,3 Fewer rows near the top
C $8743,3 Get attributes address for the screen line
C $8746,2 Fill colour = $38
C $8749,4 Save SP
C $874D,18 PUSH DE 16 times to fill attribute row via SP
C $875F,3 Step up one attribute row
C $8768,4 Restore SP
c $876E Draw walls??
C $876E,4 Reject if the row is off-screen
C $8773,2 Full wall height = 25 rows
C $8775,4 Row within the wall band
C $877E,4 Compute second band value, save B
C $878D,4 Skip the hidden top rows
C $8794,3 Scale to the sprite row stride
C $8797,4 Get Sprite addr Wall; width 4
C $879E,3 Screen address from the row
C $87A2,2 $FE00 - table of even screen lines addresses
C $87A9,2 Height = 25
C $87AB,3 Get Sprite addr Wall; width 4
C $87AE,3 Sprite column stride
C $87B5,4 Draw one row's bytes via the stack
C $87D2,3 Cross into the next screen third
C $87D7,4 Advance to the next screen row
c $87F1 Colour a two-tone structure's attributes, then draw it
N $87F1 Colours the attribute cells for a two-tone structure (bytes $31 and $30) at every fourth row, using stacked PUSH DE writes to fill 16 cells per line through SP. After the colour pass it restores the row and, if it is on-screen, falls through to draw the structure's sprite (graphic $88E5).
R $87F1 I:D Row
R $87F1 I:E Column
C $87F3,2 Align row to the 4-row grid
C $87F6,2 Act only on every fourth row
C $8805,3 Get attributes address for the screen line
C $8808,2 Attribute byte
C $8811,16 Fill attribute line
C $8823,3 Get attributes address for the screen line
C $8826,2 Attribute byte
C $882F,16 Fill attribute line
C $8844,2 Attribute byte
C $8847,16 Fill attribute line
C $885C,3 Reject if row off bottom edge
C $8860,3 Reject if above the band
C $886D,3 Load structure graphic $88E5
C $8881,3 HL = HL + A
C $888B,2 $FE00 - table of even screen lines addresses
C $888D,4 Get screen line address from table $FE00
C $8895,1 Now SP = address on the screen
C $8898,4 Get 1st word from table $88E5
C $889C,16 Fill screen line with DE
C $88AD,1 Next screen line
C $88B1 Get 2nd word from table $88E5
C $88B5,16 Fill screen line with DE
b $88E5
B $88E5,,4
c $8914 Draw sprite at ($C006), then fill $1600 map tiles it covers
C $8914,4 Reject if the row is off-screen
C $8919,2 Sprite height = 25 rows
C $891D,3 Load the sprite address ($C006)
C $8921,3 Clip sprite, then AND/OR-mask blit rows via SP into screen
C $8925,4 Skip the map fill if too low
C $8929,4 Compute $1600 map row base
C $8935,4 Combine row/column into map address
C $8941,3 Switch SP to HL for map fill
C $8952,5 Check width: 15 or 30 columns
c $896D Get attributes address for the screen line
R $896D I:D Screen line number, divided by 2
R $896D O:HL Address in the screen attribute area for the given line
C $896F,2 $FE00 - table of even screen lines addresses
C $8973,5 Get screen line address to HL
C $8978,3 Rotate H right on 3 bits
C $897D,1 Now HL = address in the screen attribute area for the given line
b $897F
c $899E Compute screen draw address for sprite, save state to buffer
R $899E I:A Column (X)
R $899E I:D Row (Y)
R $899E I:C Attribute (colour) byte
C $89A2,2 Pack the column into HL
C $89A9,4 Screen third from the row
C $89AF,4 Column offset within the third
C $89B7,3 Fold the row into the $58xx attribute page
C $89C1,4 At a third boundary, paint the attributes
C $89C7,3 Set attribute color for B cells at HL
C $89CC,2 Randomly pick the wrap direction
C $89D3,4 Step down one screen row
C $89DB,4 Otherwise cross into the next third
C $89DF,3 Set attribute INK=1 for B cells at HL
C $89E5,4 Advance a row; repaint attributes at a boundary
C $89E9,3 Set attribute color for B cells at HL
c $89F3 Set attribute color for B cells at HL
C $89F8,4 Keep PAPER bits, set INK from C
C $89FD,3 Next cell, loop
C $8A00,2 Step to the next row
c $8A03 Set attribute INK=1 for B cells at HL (variant of $89F3)
C $8A09,4 Keep PAPER bits, force INK to 1
C $8A0E,3 Next cell, loop
c $8A14 Sprite draw dispatch variant, C=4 (unconfirmed)
N $8A14 Draws a 4-row masked sprite: clips it, computes the screen address, then blits each row either through its mask or straight in, picked at random.
C $8A16,2 Set the height to 4 rows
C $8A19,3 Clip sprite rectangle against screen edge
C $8A1E,4 Off-screen: return with carry set
C $8A28,2 On-screen: set draw flag
C $8A33,5 Random-pick blit entry point
C $8A38,4 Masked blit: AND the mask, OR the sprite
C $8A44,3 Cross into the next screen third
C $8A53,2 Loop the remaining rows
C $8A5C,2 Opaque path: OR the sprite straight in
C $8A2A,3 Compute screen draw address for sprite, save state to buffer
c $8A7B Sprite draw dispatch: clip and compute screen address, C=$08
C $8A7B,4 Save color, set width C=$08
C $8A80,3 Clip sprite rectangle against screen edge
C $8A8B,3 Compute screen draw address for sprite, save state to buffer
C $8A86,3 Restore color, double for table index
C $8A94,4 Masked byte: mask then OR the sprite
C $8AAC,3 Cross into the next screen third
C $8AB1,4 Advance to the next screen row
C $8ABB,2 Loop the rows
c $8AC3 Sprite draw dispatch: clip and compute screen address, C=$0C
C $8AC3,4 Save colour, set width to $0C
C $8AC8,3 Clip sprite rectangle against screen edge
C $8AD0,2 Set drop type A=3 for draw address calc
C $8AD2,3 Compute screen draw address, save state
C $8ADB,2 Randomly pick masked or opaque
C $8AE0,4 Masked blit: mask then OR the sprite byte
C $8B04,3 Cross into the next screen third
C $8B09,4 Advance to the next screen row
C $8B13,2 Loop the rows
C $8B1C,3 Opaque path: OR the sprite straight in
b $8B4B
t $8B9F
b $8BA2
t $8BD7
b $8BDA
t $8C42
b $8C45
t $8CB9
b $8CBC
c $8CC9 Clip sprite, then AND/OR-mask blit rows via SP into screen
C $8CC9,4 Save color, set width C=$20
C $8CCE,3 Clip sprite rectangle against screen edge
C $8CD1,3 Swap position for return address
C $8CD6,2 Set drop type A=8 for draw address calc
C $8CD8,3 Compute screen draw address for sprite, save state to buffer
C $8CE1,1 Draw byte 1 (top row, left to right)
C $8CE7,1 Draw byte 2
C $8CED,1 Draw byte 3
C $8CF3,1 Draw byte 4
C $8CF9,1 Draw byte 5
C $8CFF,1 Draw byte 6
C $8D05,1 Draw byte 7
C $8D0B,1 Draw byte 8
C $8D11,1 Draw byte 9 (next row, right to left)
C $8D17,1 Draw byte 10
C $8D1D,1 Draw byte 11
C $8D23,1 Draw byte 12
C $8D29,1 Draw byte 13
C $8D2F,1 Draw byte 14
C $8D35,1 Draw byte 15
C $8D3B,1 Draw byte 16
C $8D41,5 Every 8 rows, step down to the next screen third
C $8D50,2 Loop back for the next column pair
b $8D58
t $8D6D
b $8D71
t $8DA4
b $8DA7
t $8DB7
b $8DBA
t $8DDB
b $8DE0
t $8E05
b $8E08
t $8E0C
b $8E0F
t $8E25
b $8E28
t $8E45
b $8E48
t $8E5E
b $8E6D
c $8E83
C $8E8F,3 => Sprite draw dispatch
c $8E92 Shift-add multiply: 8 bits of H, adding DE per set bit (unconfirmed)
R $8E92 I:H Multiplier (bits shifted out MSB first)
R $8E92 I:DE Value added for each set bit
R $8E92 O:HL Product
C $8E92,3 Clear the running total
C $8E95,3 Shift a bit out; add DE if it was set
C $8EB1,2 Last bit, then return
R $8E92 I:E ??
c $8EB5 Collectable crate: draw sprite $C008, collect on claim
N $8EB5 Draws a collectable crate (sprite $C008) when its row is on-screen and, if the claimed flag (E bit 7) is set, falls into the shared collect handler at $8EFA that awards the item, score and a pickup sound.
R $8EB5 I:D Row
R $8EB5 I:E Column and flags (bit 7 = claimed)
C $8EB6,3 Reject if row off bottom edge
C $8EC0,2 Claimed? jump to collect
C $8EC6,3 Load sprite $C008
C $8EC9,3 => Sprite draw dispatch
b $8ECC
c $8EE3 Grenade-crate pickup: draw, on collect award grenades/score/sound
C $8EE3,5 Reject if row (D) off bottom edge
C $8EE8,10 Unclaimed variant: wider box, draw sprite ($C00C)
C $8EFA,2 Claimed: clear flag bit
C $8F0A,8 Award +1000 score, play pickup sound
C $8EF7,3 => Sprite draw dispatch
C $8EFC,3 We've got A more grenades
C $8F07,3 Sprite draw dispatch
C $8F0A,3 +1000
C $8F0D,3 Update Score
C $8F12,3 Trigger sound effect A into free slot at $6433
c $8F17 Draw scenery sprite ($C016) if row on-screen (unconfirmed)
C $8F23,3 => Sprite draw dispatch
c $8F26 Draw scenery sprite ($C018) if row on-screen (unconfirmed)
C $8F32,3 => Sprite draw dispatch
c $8F35 Draw scenery sprite ($C01A) if row on-screen (unconfirmed)
C $8F3F,3 => Sprite draw dispatch
b $8F42
b $8F60
b $8F64
b $8F68
b $8F6C
b $8F73
b $8F76
b $8F87
b $8F8B
b $8FB7
b $8FC6
b $8FCF
c $9014 Draw a two-part scenery object (top $C01E, bottom $C01C) (unconfirmed)
C $9014,3 Top part off-screen? skip it
C $9019,3 Load the top sprite ($C01E)
C $9021,3 Sprite draw dispatch variant, C=4
C $9026,3 Move to the bottom part row
C $9030,3 Bottom part on screen?
C $9034,3 Load the bottom sprite ($C01C)
C $903B,3 => Sprite draw dispatch
c $903E
C $904A,3 => Sprite draw dispatch
c $904D Draw a cliff-edge scenery block, record edge flags
N $904D Draws a cliff-edge scenery block (left or right by E bit 7), recording the edge column and side flags in IY+$5E/$5F/$71 from E bits 5-6, then draws its upper ($15 rows) and lower ($0F rows) halves via #R$90A1.
R $904D I:D Row
R $904D I:E Column and flags (bit 7 side, bits 5-6 edge markers)
C $9050,2 E bit 7 picks left/right edge
C $9054,3 Get sprite addr Cliff edge left
C $9058,3 Get sprite addr ???
C $905F,3 Record left edge column (IY+$5F)
C $9070,3 Get sprite addr Cliff edge right
C $907B,3 Record right edge column (IY+$5E)
C $908B,2 Top part height = $15
C $9091,3 Adjust and clip sprite draw, calls $8A14
C $9096,2 Bottom part height = $0F
C $909C,3 Adjust and clip sprite draw, calls $8A14
c $90A1 Adjust and clip sprite draw, calls $8A14 (unconfirmed)
R $90A1 I:A Row offset added to D
R $90A1 I:B Sprite height
R $90A1 I:C Attribute/colour byte
R $90A1 I:DE Screen position (D row, E column)
R $90A1 I:HL Sprite address
C $90A7,3 Sprite draw dispatch variant, C=4
c $90AC Draw a cliff scenery block and colour its attributes
N $90AC Draws a cliff scenery block: picks the left or right sprite pair (from $C040/$C046) by E bit 7, draws the top ($14 rows) and bottom ($0C rows) halves via #R$834B, then colours its attribute cells from the $9124 palette table.
R $90AC I:D Row
R $90AC I:E Column and variant flag (bit 7 = left/right)
C $90AD,2 Reject if row off-screen
C $90B1,2 E bit 7 picks left/right variant
C $90B8,3 Get sprite addr Cliff top right; width 6
C $90BC,3 Get sprite addr Cliff bottom right; width 6
C $90C1,3 Get sprite addr Cliff top left; width 6
C $90C5,3 Get sprite addr Cliff bottom left; width 6
C $90C8,2 Sprite height = 20
C $90CD,3 Draw sprite HL
C $90D2,2 Sprite height = 12
C $90DD,3 Draw sprite HL
C $90E8,3 Clip sprite rectangle against screen edge
C $90F4,3 Colour palette table $9124
C $90F7,3 HL = HL + A
C $9102,2 Attribute area base ($58xx)
C $9110,1 Fill attribute row from palette
b $9124
c $9132 Decrement Land space or process next record in the sequence
C $9132,3 Get Land space size
C $9135,1 zero?
C $9136,2 yes => process next record in the sequence
C $9139,3 Update Land space size
C $913D,3 Get current level sequence address
C $9140,1 Get record code
C $9143,2 End of levels marker?
C $9147,3 Level 1 start address
C $914A,1 Get record code
C $914E,1 Get record parameter
C $9150,3 Save current level sequence address
C $9153,1 $00 - Land space?
C $9154,2 no => jump
C $9157,3 Save Land space size
C $9162,3 => Abort
C $9165,2 Spawn Point/Level End ?
C $9167,2 no => jump
C $9169,1 Level End ?
C $916A,2 no => jump
C $9171,3 Process record codes $01-28, not $22
C $9174,2 => process next record in the sequence
b $9176
c $917C Walk $FF00 buffer chain (offset $FD88), increment field at +4
C $917C,3 Get Offset in $FF00 buffer
C $918C,3 Get Offset in $FF00 buffer
c $9193 Advance level scroll: walk $FF00 buffer, process sequence record
C $9199,3 Walk $FF00 buffer chain (offset $FD88), increment field at +4
C $91AD,3 ?? Smth about Truck
C $91B0,3 ?? Smth about Motorbike
C $91B3,3 ?? Smth about Jeep
C $91B6,3 Get Offset in $FF00 buffer
C $919C,3 Decrement Land space or process next record in the sequence
C $91E0,3 => Abort
c $91E3 Link record entry into the $FF00 buffer chain, continue
N $91E3 Return point after a level-record handler: on one flag path it links the entry into the sorted $FF00 buffer chain via #R$921F and processes the next record, otherwise it just advances the buffer offset ($FD88).
R $91E3 I:F Carry selects the exit path
R $91E3 I:L Buffer entry offset
C $91E3,2 Carry path: check buffer offset only
C $91E6,3 Get Offset in $FF00 buffer
C $91EA,2 Already at head? update offset
C $91F0,3 Insert entry into $FF00 buffer chain
C $91F8,3 Update Offset in $FF00 buffer
C $91FD,3 Get Offset in $FF00 buffer
c $9204 Process record codes $01-28, not $22
C $9207,3 Get Offset in $FF00 buffer
C $920D,3 Update Offset in $FF00 buffer
c $921F Insert entry into $FF00 buffer chain (unconfirmed)
C $921F,8 Swap chain link with new entry
C $9228,6 Read buffer offset ($FD88), insert into chain
C $9228,3 Get Offset in $FF00 buffer
b $9236 Level 1
B $9236,2 Spawn Point
B $9238,2 Land Space
B $923A,2 A tree in column 12
B $923C,2 Land Space
B $923E,2 A tree in column 10
B $9240,2 A tree in column 14
B $9242,2 Land Space
B $9244,2 A tree in column 28
B $9246,2 A tree in column 2
B $9248,2 Land Space
B $924A,2 A mirrored cliff in column 26
B $924C,2 A cliff edge in column 25 with jumping soldiers
B $924E,2 Land Space
B $9250,2 A boulder in column 20
B $9252,2 Land Space
B $9254,2 A tree in column 8
B $9256,2 Land Space
B $9258,2 A tree in column 18
B $925A,2 A tree in column 22
B $925C,2 Land Space
B $925E,2 A tree in column 20
B $9260,2 Land Space
B $9262,2 A tree in column 9
B $9264,2 Land Space
B $9266,2 A mirrored cliff in column 26
B $9268,2 A cliff edge in column 25 with jumping soldiers
B $926A,2 Land Space
B $926C,2 A tree in column 1
B $926E,2 A tree in column 23
B $9270,2 A tree in column 5
B $9272,2 Land Space
B $9274,2 A tree in column 3
B $9276,2 Land Space
B $9278,2 Sandbags LHS in column 17
B $927A,2 Sandbags MIDDLE in column 19
B $927C,2 Sandbags MIDDLE in column 22
B $927E,2 Sandbags RHS in column 25
B $9280,2 Land Space
B $9282,2 A tree in column 13
B $9284,2 A single grenade in column 17
B $9286,2 Land Space
B $9288,2 A tree in column 24
B $928A,2 A cliff in column 0
B $928C,2 A mirrored cliff edge in column 6 with jumping soldiers
B $928E,2 Land Space
B $9290,2 A tree in column 25
B $9292,2 Land Space
B $9294,2 A mirrored cliff in column 10
B $9296,2 A cliff in column 16
B $9298,2 A cliff edge in column 9
B $929A,2 A mirrored cliff edge in column 22
B $929C,2 Land Space
B $929E,2 A boulder in column 20
B $92A0,2 Land Space
B $92A2,2 Prisoner of war
B $92A4,2 Land Space
B $92A6,2 Spawn Point
B $92A8,2 Land Space
B $92AA,2 A tree in column 2
B $92AC,2 Land Space
B $92AE,2 A tree in column 19
B $92B0,2 Land Space
B $92B2,2 Sandbags MIDDLE in column 29
B $92B4,2 Sandbags MIDDLE in column 26
B $92B6,2 Sandbags LHS in column 24
B $92B8,2 Land Space
B $92BA,2 A right mortar in column 25
B $92BC,2 Land Space
B $92BE,2 A quintuple grenade in column 22
B $92C0,2 Land Space
B $92C2,2 A wall in column 11
B $92C4,2 A wall in column 31
B $92C6,2 A tunnel in column 12
B $92C8,2 Land Space
B $92CA,2 Draw Road on bridge
B $92CC,2 Land Space
B $92CE,2 Motorbike
B $92D0,2 Land Space
B $92D2,2 A bridge section
B $92D4,2 Land Space
B $92D6,2 A boulder in column 15
B $92D8,2 Land Space
B $92DA,2 Spawn Point
B $92DC,2 Land Space
B $92DE,2 A boulder in column 1
B $92E0,2 Land Space
B $92E2,2 A boulder in column 9
B $92E4,2 Land Space
B $92E6,2 A boulder in column 18
B $92E8,2 Land Space
B $92EA,2 A boulder in column 1
B $92EC,2 A boulder in column 14
B $92EE,2 A boulder in column 27
B $92F0,2 Land Space
B $92F2,2 Sandbags LHS in column 2
B $92F4,2 Sandbags MIDDLE in column 4
B $92F6,2 Sandbags MIDDLE in column 7
B $92F8,2 Sandbags RHS in column 10
B $92FA,2 Land Space
B $92FC,2 A quintuple grenade in column 3
B $92FE,2 Land Space
B $9300,2 Sandbags LHS in column 19
B $9302,2 Sandbags MIDDLE in column 21
B $9304,2 Sandbags MIDDLE in column 24
B $9306,2 Sandbags RHS in column 27
B $9308,2 Land Space
B $930A,2 Sandbags LHS in column 4
B $930C,2 Sandbags MIDDLE in column 6
B $930E,2 Sandbags RHS in column 9
B $9310,2 Land Space
B $9312,2 A triple grenade in column 5
B $9314,2 Land Space
B $9316,2 Spawn Point
B $9318,2 Land Space
B $931A,2 Sandbags LHS in column 13
B $931C,2 Sandbags MIDDLE in column 15
B $931E,2 Sandbags RHS in column 18
B $9320,2 Land Space
B $9322,2 Sandbags LHS in column 0
B $9324,2 Sandbags MIDDLE in column 2
B $9326,2 Sandbags RHS in column 5
B $9328,2 Land Space
B $932A,2 Sandbags MIDDLE in column 29
B $932C,2 Sandbags MIDDLE in column 26
B $932E,2 Sandbags LHS in column 24
B $9330,2 Land Space
B $9332,2 A single grenade in column 24
B $9334,2 Land Space
B $9336,2 A wall in column 11
B $9338,2 A wall in column 31
B $933A,2 Fortress gates
B $933C,2 Land Space
B $933E,2 Spawn Point
b $9340 Level 2
B $9340,2 Land Space
B $9342,2 Jeep
B $9344,2 Truck
B $9346,2 Land Space
B $9348,2 Motorbike
B $934A,2 Land Space
B $934C,2 A single grenade in column 7
B $934E,2 Land Space
B $9350,2 A trench MIDDLE in column 0
B $9352,2 A trench MIDDLE in column 4
B $9354,2 A trench RIGHT in column 8
B $9356,2 Land Space
B $9358,2 A trench LHS in column 20
B $935A,2 A trench MIDDLE in column 22
B $935C,2 A trench RIGHT in column 26
B $935E,2 Land Space
B $9360,2 A trench LHS in column 2
B $9362,2 A trench MIDDLE in column 4
B $9364,2 A trench RIGHT in column 8
B $9366,2 Land Space
B $9368,2 A trench LHS in column 22
B $936A,2 A trench MIDDLE in column 24
B $936C,2 A trench RIGHT in column 28
B $936E,2 Land Space
B $9370,2 A trench LHS in column 10
B $9372,2 A trench MIDDLE in column 12
B $9374,2 A trench MIDDLE in column 16
B $9376,2 A trench RIGHT in column 20
B $9378,2 Land Space
B $937A,2 A triple grenade in column 27
B $937C,2 Land Space
B $937E,2 Spawn Point
B $9380,2 Land Space
B $9382,2 A trench LHS in column 18
B $9384,2 A trench MIDDLE in column 20
B $9386,2 A trench MIDDLE in column 24
B $9388,2 A trench MIDDLE in column 28
B $938A,2 Land Space
B $938C,2 A trench LHS in column 1
B $938E,2 A trench MIDDLE in column 3
B $9390,2 A trench RIGHT in column 7
B $9392,2 Land Space
B $9394,2 A trench LHS in column 12
B $9396,2 A trench MIDDLE in column 14
B $9398,2 A trench MIDDLE in column 18
B $939A,2 A trench MIDDLE in column 22
B $939C,2 A trench RIGHT in column 26
B $939E,2 Land Space
B $93A0,2 A trench LHS in column 2
B $93A2,2 A trench MIDDLE in column 4
B $93A4,2 A trench RIGHT in column 8
B $93A6,2 Land Space
B $93A8,2 A triple grenade in column 20
B $93AA,2 Land Space
B $93AC,2 A wall in column 11
B $93AE,2 A wall in column 31
B $93B0,2 A tunnel in column 12
B $93B2,2 Land Space
B $93B4,2 Draw Road on bridge
B $93B6,2 Land Space
B $93B8,2 A bridge section
B $93BA,2 Land Space
B $93BC,2 Spawn Point
B $93BE,2 Land Space
B $93C0,2 A barracks in column 0
B $93C2,2 Land Space
B $93C4,2 A triple grenade in column 3
B $93C6,2 Land Space
B $93C8,2 Start of NME with rocket launchers. Ferocity:25
B $93CA,2 Land Space
B $93CC,2 A log crossing in column 16
B $93CE,2 Land Space
B $93D0,2 Water
B $93D2,2 Land Space
B $93D4,2 Water Strip 1
B $93D6,2 Land Space
B $93D8,2 Water Strip 2
B $93DA,2 Land Space
B $93DC,2 A bunker in column 0
B $93DE,2 Land Space
B $93E0,2 End of NME with rocket launchers
B $93E2,2 Land Space
B $93E4,2 A bunker in column 26
B $93E6,2 Land Space
B $93E8,2 Spawn Point
B $93EA,2 Land Space
B $93EC,2 A bunker in column 0
B $93EE,2 Land Space
B $93F0,2 A cave bottom edge in column 26
B $93F2,2 Land Space
B $93F4,2 A cave main in column 26
B $93F6,2 Land Space
B $93F8,2 A cave bottom edge in column 0
B $93FA,2 Land Space
B $93FC,2 A cave main in column 0
B $93FE,2 A cave main in column 26
B $9400,2 Land Space
B $9402,2 A cave main in column 0
B $9404,2 A cave main in column 26
B $9406,2 Land Space
B $9408,2 A cave top edge in column 0
B $940A,2 A cave top edge in column 26
B $940C,2 Land Space
B $940E,2 A wall in column 11
B $9410,2 A wall in column 31
B $9412,2 Fortress gates
B $9414,2 Land Space
B $9416,2 Spawn Point
b $9418 Level 3
B $9418,2 Land Space
B $941A,2 A large hut in column 6
B $941C,2 Land Space
B $941E,2 A large hut in column 20
B $9420,2 Land Space
B $9422,2 A large hut in column 1
B $9424,2 Land Space
B $9426,2 A triple grenade in column 22
B $9428,2 Land Space
B $942A,2 A large hut in column 11
B $942C,2 Land Space
B $942E,2 A large hut in column 20
B $9430,2 Land Space
B $9432,2 A large hut in column 4
B $9434,2 Land Space
B $9436,2 A large hut in column 13
B $9438,2 Land Space
B $943A,2 A large hut in column 6
B $943C,2 Land Space
B $943E,2 A large hut in column 25
B $9440,2 Land Space
B $9442,2 A trench LHS in column 18
B $9444,2 A trench MIDDLE in column 20
B $9446,2 A trench RIGHT in column 24
B $9448,2 Land Space
B $944A,2 A triple grenade in column 20
B $944C,2 A large hut in column 1
B $944E,2 Land Space
B $9450,2 A large hut in column 12
B $9452,2 Land Space
B $9454,2 A large hut in column 6
B $9456,2 Land Space
B $9458,2 Spawn Point
B $945A,2 Land Space
B $945C,2 A large hut in column 19
B $945E,2 Land Space
B $9460,2 A trench MIDDLE in column 0
B $9462,2 A trench MIDDLE in column 4
B $9464,2 A trench RIGHT in column 8
B $9466,2 Land Space
B $9468,2 A large hut in column 8
B $946A,2 Land Space
B $946C,2 A trench LHS in column 20
B $946E,2 A trench MIDDLE in column 22
B $9470,2 A trench RIGHT in column 26
B $9472,2 Land Space
B $9474,2 A large hut in column 18
B $9476,2 Land Space
B $9478,2 A trench LHS in column 0
B $947A,2 A trench MIDDLE in column 2
B $947C,2 A trench MIDDLE in column 6
B $947E,2 A trench RIGHT in column 10
B $9480,2 Land Space
B $9482,2 A quintuple grenade in column 4
B $9484,2 Land Space
B $9486,2 A wall in column 11
B $9488,2 A wall in column 31
B $948A,2 A tunnel in column 12
B $948C,2 Land Space
B $948E,2 Draw Road on bridge
B $9490,2 Land Space
B $9492,2 A bridge section
B $9494,2 Land Space
B $9496,2 Truck
B $9498,2 Land Space
B $949A,2 Motorbike
B $949C,2 Land Space
B $949E,2 Spawn Point
B $94A0,2 Land Space
B $94A2,2 Truck
B $94A4,2 Land Space
B $94A6,2 Motorbike
B $94A8,2 Land Space
B $94AA,2 Jeep
B $94AC,2 Land Space
B $94AE,2 Truck
B $94B0,2 Land Space
B $94B2,2 Start of NME with rocket launchers. Ferocity:30
B $94B4,2 Land Space
B $94B6,2 Jeep
B $94B8,2 End of NME with rocket launchers
B $94BA,2 Land Space
B $94BC,2 Spawn Point
B $94BE,2 Land Space
B $94C0,2 A single grenade in column 4
B $94C2,2 Land Space
B $94C4,2 Sandbags LHS in column 2
B $94C6,2 Sandbags MIDDLE in column 4
B $94C8,2 Sandbags RHS in column 7
B $94CA,2 Sandbags LHS in column 23
B $94CC,2 Sandbags MIDDLE in column 25
B $94CE,2 Sandbags RHS in column 28
B $94D0,2 Land Space
B $94D2,2 A triple grenade in column 10
B $94D4,2 A triple grenade in column 19
B $94D6,2 Land Space
B $94D8,2 A right mortar in column 27
B $94DA,2 A left mortar in column 3
B $94DC,2 Land Space
B $94DE,2 A wall in column 11
B $94E0,2 A wall in column 31
B $94E2,2 Fortress gates
B $94E4,2 Land Space
B $94E6,2 Spawn Point
b $94E8 Level 4
B $94E8,2 Land Space
B $94EA,2 Start of NME with rocket launchers. Ferocity:70
B $94EC,2 Land Space
B $94EE,2 A log crossing in column 16
B $94F0,2 Land Space
B $94F2,2 Water
B $94F4,2 Land Space
B $94F6,2 Water Strip 1
B $94F8,2 Land Space
B $94FA,2 Water Strip 2
B $94FC,2 Land Space
B $94FE,2 A triple grenade in column 25
B $9500,2 Land Space
B $9502,2 A log crossing in column 8
B $9504,2 Land Space
B $9506,2 Water
B $9508,2 Land Space
B $950A,2 Water Strip 1
B $950C,2 Land Space
B $950E,2 Water Strip 2
B $9510,2 Land Space
B $9512,2 A log crossing in column 16
B $9514,2 Land Space
B $9516,2 Water
B $9518,2 Land Space
B $951A,2 Water Strip 1
B $951C,2 Land Space
B $951E,2 Water Strip 2
B $9520,2 Land Space
B $9522,2 Spawn Point
B $9524,2 Land Space
B $9526,2 Start of NME with rocket launchers. Ferocity:70
B $9528,2 A tree in column 2
B $952A,2 Land Space
B $952C,2 A tree in column 20
B $952E,2 Land Space
B $9530,2 A road bottom edging in column 16
B $9532,2 Land Space
B $9534,2 Turn the alarm ON
B $9536,2 Sandbags LHS in column 1
B $9538,2 Sandbags MIDDLE in column 3
B $953A,2 Sandbags MIDDLE in column 6
B $953C,2 Sandbags RHS in column 9
B $953E,2 Land Space
B $9540,2 A road marking in column 27
B $9542,2 Start of NME with rocket launchers. Ferocity:20
B $9544,2 Land Space
B $9546,2 A road bottom edging in column 0
B $9548,2 Land Space
B $954A,2 A road marking in column 21
B $954C,2 A quintuple grenade in column 4
B $954E,2 Land Space
B $9550,2 A road top edging in column 16
B $9552,2 Land Space
B $9554,2 A road marking in column 15
B $9556,2 Land Space
B $9558,2 A road marking in column 9
B $955A,2 Land Space
B $955C,2 A road top edging in column 0
B $955E,2 Land Space
B $9560,2 A road marking in column 3
B $9562,2 A tree in column 20
B $9564,2 Land Space
B $9566,2 A tree in column 27
B $9568,2 Land Space
B $956A,2 A bunker in column 26
B $956C,2 Land Space
B $956E,2 End of NME with rocket launchers
B $9570,2 Land Space
B $9572,2 A boulder in column 4
B $9574,2 Land Space
B $9576,2 Spawn Point
B $9578,2 Land Space
B $957A,2 Turn the alarm ON
B $957C,2 A quintuple grenade in column 25
B $957E,2 Land Space
B $9580,2 Sandbags LHS in column 20
B $9582,2 Sandbags MIDDLE in column 22
B $9584,2 Sandbags RHS in column 25
B $9586,2 Land Space
B $9588,2 Turn the alarm OFF
B $958A,2 A triple grenade in column 4
B $958C,2 Land Space
B $958E,2 A wall in column 11
B $9590,2 A wall in column 31
B $9592,2 Fortress gates
B $9594,2 Land Space
B $9596,2 Spawn Point
b $9598 Level 5
B $9598,2 Land Space
B $959A,2 A tree in column 5
B $959C,2 Land Space
B $959E,2 A tree in column 11
B $95A0,2 Land Space
B $95A2,2 A mirrored cliff in column 0
B $95A4,2 A double cliff mirrored cliff edge in column 12 with jumping soldiers
B $95A6,2 A cliff in column 6
B $95A8,2 Land Space
B $95AA,2 A mirrored cliff in column 26
B $95AC,2 A cliff edge in column 25 with jumping soldiers
B $95AE,2 Land Space
B $95B0,2 A tree in column 3
B $95B2,2 Land Space
B $95B4,2 A tree in column 7
B $95B6,2 Land Space
B $95B8,2 A cliff edge in column 31
B $95BA,2 A mirrored cliff in column 0
B $95BC,2 A cliff in column 6
B $95BE,2 A double cliff mirrored cliff edge in column 12 with jumping soldiers
B $95C0,2 Land Space
B $95C2,2 A single grenade in column 9
B $95C4,2 A tree in column 12
B $95C6,2 Land Space
B $95C8,2 A tree in column 10
B $95CA,2 Land Space
B $95CC,2 A mirrored cliff in column 10
B $95CE,2 A cliff in column 16
B $95D0,2 A cliff edge in column 9
B $95D2,2 A mirrored cliff edge in column 22
B $95D4,2 Land Space
B $95D6,2 A cliff in column 26
B $95D8,2 A mirrored cliff in column 20
B $95DA,2 A double cliff cliff edge in column 19 with jumping soldiers
B $95DC,2 Land Space
B $95DE,2 A cliff in column 0
B $95E0,2 A mirrored cliff edge in column 6 with jumping soldiers
B $95E2,2 Land Space
B $95E4,2 Spawn Point
B $95E6,2 Land Space
B $95E8,2 A tree in column 10
B $95EA,2 A tree in column 14
B $95EC,2 Land Space
B $95EE,2 A tree in column 12
B $95F0,2 Land Space
B $95F2,2 A tree in column 20
B $95F4,2 Land Space
B $95F6,2 A tree in column 24
B $95F8,2 Land Space
B $95FA,2 A tree in column 27
B $95FC,2 Land Space
B $95FE,2 A mirrored cliff in column 0
B $9600,2 A cliff in column 6
B $9602,2 A double cliff mirrored cliff edge in column 12 with jumping soldiers
B $9604,2 Land Space
B $9606,2 A cliff in column 26
B $9608,2 A mirrored cliff in column 20
B $960A,2 A double cliff cliff edge in column 19 with jumping soldiers
B $960C,2 Land Space
B $960E,2 A quintuple grenade in column 9
B $9610,2 Land Space
B $9612,2 A wall in column 11
B $9614,2 A wall in column 31
B $9616,2 A tunnel in column 12
B $9618,2 Land Space
B $961A,2 Draw Road on bridge
B $961C,2 Land Space
B $961E,2 Motorbike
B $9620,2 Land Space
B $9622,2 A bridge section
B $9624,2 Land Space
B $9626,2 A boulder in column 14
B $9628,2 Land Space
B $962A,2 A boulder in column 4
B $962C,2 Land Space
B $962E,2 Spawn Point
B $9630,2 Land Space
B $9632,2 Sandbags LHS in column 24
B $9634,2 Sandbags MIDDLE in column 26
B $9636,2 Sandbags MIDDLE in column 29
B $9638,2 Land Space
B $963A,2 A boulder in column 6
B $963C,2 Land Space
B $963E,2 A boulder in column 25
B $9640,2 Land Space
B $9642,2 A boulder in column 16
B $9644,2 Land Space
B $9646,2 A boulder in column 22
B $9648,2 Sandbags MIDDLE in column 0
B $964A,2 Sandbags RHS in column 3
B $964C,2 Land Space
B $964E,2 A boulder in column 2
B $9650,2 Land Space
B $9652,2 A boulder in column 11
B $9654,2 Land Space
B $9656,2 A boulder in column 18
B $9658,2 Land Space
B $965A,2 A mirrored cliff in column 0
B $965C,2 A cliff in column 6
B $965E,2 A double cliff mirrored cliff edge in column 12 with jumping soldiers
B $9660,2 Land Space
B $9662,2 A boulder in column 25
B $9664,2 Land Space
B $9666,2 Sandbags LHS in column 15
B $9668,2 Sandbags MIDDLE in column 17
B $966A,2 Sandbags RHS in column 20
B $966C,2 Land Space
B $966E,2 Start of NME with rocket launchers. Ferocity:30
B $9670,2 A trench LHS in column 10
B $9672,2 A trench MIDDLE in column 12
B $9674,2 A trench MIDDLE in column 16
B $9676,2 A trench RIGHT in column 20
B $9678,2 Land Space
B $967A,2 A trench RIGHT in column 10
B $967C,2 A trench MIDDLE in column 6
B $967E,2 A trench LHS in column 4
B $9680,2 A trench LHS in column 20
B $9682,2 A trench MIDDLE in column 22
B $9684,2 A trench RIGHT in column 26
B $9686,2 Land Space
B $9688,2 End of NME with rocket launchers
B $968A,2 A wall in column 11
B $968C,2 A wall in column 31
B $968E,2 Fortress gates
B $9690,2 Land Space
B $9692,2 Spawn Point
b $9694 Level 6
B $9694,2 Land Space
B $9696,2 A bunker in column 0
B $9698,2 Land Space
B $969A,2 A bunker in column 26
B $969C,2 Land Space
B $969E,2 A bunker in column 0
B $96A0,2 Land Space
B $96A2,2 A bunker in column 26
B $96A4,2 Land Space
B $96A6,2 A cave bottom edge in column 26
B $96A8,2 A cave bottom edge in column 0
B $96AA,2 Land Space
B $96AC,2 A cave main in column 26
B $96AE,2 A cave main in column 0
B $96B0,2 Land Space
B $96B2,2 A quintuple grenade in column 7
B $96B4,2 A cave main in column 26
B $96B6,2 A cave main in column 0
B $96B8,2 Land Space
B $96BA,2 A cave main in column 26
B $96BC,2 A cave main in column 0
B $96BE,2 Land Space
B $96C0,2 A triple grenade in column 22
B $96C2,2 A cave main in column 26
B $96C4,2 A cave main in column 0
B $96C6,2 Land Space
B $96C8,2 A cave main in column 26
B $96CA,2 A cave main in column 0
B $96CC,2 Land Space
B $96CE,2 A cave main in column 26
B $96D0,2 A cave main in column 0
B $96D2,2 Land Space
B $96D4,2 A cave top edge in column 0
B $96D6,2 A cave top edge in column 26
B $96D8,2 Land Space
B $96DA,2 A wall in column 11
B $96DC,2 A wall in column 31
B $96DE,2 A tunnel in column 12
B $96E0,2 Land Space
B $96E2,2 Draw Road on bridge
B $96E4,2 Land Space
B $96E6,2 A bridge section
B $96E8,2 Land Space
B $96EA,2 A trench RIGHT in column 0
B $96EC,2 Land Space
B $96EE,2 Spawn Point
B $96F0,2 Land Space
B $96F2,2 A trench MIDDLE in column 28
B $96F4,2 A trench LHS in column 26
B $96F6,2 Land Space
B $96F8,2 A trench MIDDLE in column 0
B $96FA,2 A trench MIDDLE in column 4
B $96FC,2 A trench RIGHT in column 8
B $96FE,2 Land Space
B $9700,2 A trench LHS in column 16
B $9702,2 A trench MIDDLE in column 18
B $9704,2 A trench MIDDLE in column 22
B $9706,2 Start of NME with rocket launchers. Ferocity:20
B $9708,2 A trench MIDDLE in column 26
B $970A,2 A trench RIGHT in column 30
B $970C,2 Land Space
B $970E,2 A quintuple grenade in column 4
B $9710,2 Land Space
B $9712,2 A log crossing in column 16
B $9714,2 Land Space
B $9716,2 Water
B $9718,2 Land Space
B $971A,2 Water Strip 1
B $971C,2 Land Space
B $971E,2 Water Strip 2
B $9720,2 Land Space
B $9722,2 End of NME with rocket launchers
B $9724,2 A trench LHS in column 10
B $9726,2 A trench MIDDLE in column 12
B $9728,2 A trench MIDDLE in column 16
B $972A,2 A trench MIDDLE in column 20
B $972C,2 A trench RIGHT in column 24
B $972E,2 Land Space
B $9730,2 A trench MIDDLE in column 0
B $9732,2 A trench MIDDLE in column 4
B $9734,2 A trench MIDDLE in column 8
B $9736,2 A trench RIGHT in column 12
B $9738,2 Land Space
B $973A,2 A trench LHS in column 18
B $973C,2 A trench MIDDLE in column 20
B $973E,2 A trench RIGHT in column 24
B $9740,2 Land Space
B $9742,2 Spawn Point
B $9744,2 Land Space
B $9746,2 A trench LHS in column 20
B $9748,2 A trench MIDDLE in column 22
B $974A,2 A trench RIGHT in column 26
B $974C,2 Land Space
B $974E,2 A triple grenade in column 22
B $9750,2 Start of NME with rocket launchers. Ferocity:25
B $9752,2 Land Space
B $9754,2 A log crossing in column 8
B $9756,2 Land Space
B $9758,2 Water
B $975A,2 Land Space
B $975C,2 Water Strip 1
B $975E,2 Land Space
B $9760,2 Water Strip 2
B $9762,2 Land Space
B $9764,2 A trench LHS in column 6
B $9766,2 A trench MIDDLE in column 8
B $9768,2 A trench MIDDLE in column 12
B $976A,2 A trench RIGHT in column 16
B $976C,2 Land Space
B $976E,2 A trench LHS in column 16
B $9770,2 A trench MIDDLE in column 18
B $9772,2 End of NME with rocket launchers
B $9774,2 A trench MIDDLE in column 22
B $9776,2 A trench RIGHT in column 26
B $9778,2 Land Space
B $977A,2 A trench MIDDLE in column 0
B $977C,2 A trench MIDDLE in column 4
B $977E,2 A trench MIDDLE in column 8
B $9780,2 A trench RIGHT in column 12
B $9782,2 Land Space
B $9784,2 A wall in column 11
B $9786,2 A wall in column 31
B $9788,2 Fortress gates
B $978A,2 Land Space
B $978C,2 Spawn Point
b $978E Level 7
B $978E,2 Land Space
B $9790,2 A small hut in column 0
B $9792,2 A small hut in column 20
B $9794,2 A small hut in column 26
B $9796,2 Land Space
B $9798,2 A small hut in column 0
B $979A,2 A small hut in column 6
B $979C,2 A small hut in column 12
B $979E,2 Land Space
B $97A0,2 A small hut in column 0
B $97A2,2 A small hut in column 20
B $97A4,2 A small hut in column 26
B $97A6,2 Land Space
B $97A8,2 A small hut in column 0
B $97AA,2 A small hut in column 6
B $97AC,2 A small hut in column 12
B $97AE,2 Land Space
B $97B0,2 A small hut in column 0
B $97B2,2 A small hut in column 6
B $97B4,2 A small hut in column 18
B $97B6,2 Land Space
B $97B8,2 A small hut in column 10
B $97BA,2 A small hut in column 16
B $97BC,2 Land Space
B $97BE,2 Spawn Point
B $97C0,2 Land Space
B $97C2,2 A small hut in column 0
B $97C4,2 A small hut in column 26
B $97C6,2 Land Space
B $97C8,2 A small hut in column 13
B $97CA,2 Land Space
B $97CC,2 A left mortar in column 3
B $97CE,2 Land Space
B $97D0,2 A quintuple grenade in column 26
B $97D2,2 Land Space
B $97D4,2 A wall in column 11
B $97D6,2 A wall in column 31
B $97D8,2 A tunnel in column 12
B $97DA,2 Land Space
B $97DC,2 Draw Road on bridge
B $97DE,2 Land Space
B $97E0,2 A bridge section
B $97E2,2 Land Space
B $97E4,2 Truck
B $97E6,2 Land Space
B $97E8,2 Spawn Point
B $97EA,2 Land Space
B $97EC,2 Start of NME with rocket launchers. Ferocity:40
B $97EE,2 A quintuple grenade in column 4
B $97F0,2 Land Space
B $97F2,2 Jeep
B $97F4,2 Land Space
B $97F6,2 Start of NME with rocket launchers. Ferocity:12
B $97F8,2 Land Space
B $97FA,2 A quintuple grenade in column 3
B $97FC,2 Land Space
B $97FE,2 A single grenade in column 25
B $9800,2 Land Space
B $9802,2 Spawn Point
B $9804,2 Land Space
B $9806,2 Start of NME with rocket launchers. Ferocity:12
B $9808,2 Land Space
B $980A,2 End of NME with rocket launchers
B $980C,2 Land Space
B $980E,2 A wall in column 11
B $9810,2 A wall in column 31
B $9812,2 Fortress gates
B $9814,2 Land Space
B $9816,2 Spawn Point
b $9818 Level 8
B $9818,2 Land Space
B $981A,2 Sandbags LHS in column 7
B $981C,2 Sandbags MIDDLE in column 9
B $981E,2 Sandbags MIDDLE in column 12
B $9820,2 Sandbags RHS in column 15
B $9822,2 Land Space
B $9824,2 A log crossing in column 8
B $9826,2 Land Space
B $9828,2 Water
B $982A,2 Land Space
B $982C,2 Water Strip 1
B $982E,2 Land Space
B $9830,2 Water Strip 2
B $9832,2 Land Space
B $9834,2 A log crossing in column 16
B $9836,2 Land Space
B $9838,2 Water
B $983A,2 Land Space
B $983C,2 Water Strip 1
B $983E,2 Land Space
B $9840,2 Water Strip 2
B $9842,2 Land Space
B $9844,2 Sandbags MIDDLE in column 0
B $9846,2 Sandbags MIDDLE in column 3
B $9848,2 Sandbags RHS in column 6
B $984A,2 Sandbags MIDDLE in column 29
B $984C,2 Sandbags LHS in column 27
B $984E,2 Land Space
B $9850,2 A barracks in column 0
B $9852,2 Land Space
B $9854,2 Motorbike
B $9856,2 Land Space
B $9858,2 A triple grenade in column 20
B $985A,2 Land Space
B $985C,2 Motorbike
B $985E,2 Land Space
B $9860,2 Spawn Point
B $9862,2 Land Space
B $9864,2 A quintuple grenade in column 21
B $9866,2 Land Space
B $9868,2 A tree in column 2
B $986A,2 Land Space
B $986C,2 A tree in column 20
B $986E,2 Land Space
B $9870,2 A road bottom edging in column 16
B $9872,2 Land Space
B $9874,2 Turn the alarm ON
B $9876,2 Sandbags MIDDLE in column 0
B $9878,2 Sandbags MIDDLE in column 3
B $987A,2 Sandbags RHS in column 6
B $987C,2 Land Space
B $987E,2 A left mortar in column 2
B $9880,2 Land Space
B $9882,2 A road marking in column 27
B $9884,2 Start of NME with rocket launchers. Ferocity:20
B $9886,2 Land Space
B $9888,2 A road bottom edging in column 0
B $988A,2 Land Space
B $988C,2 A road marking in column 21
B $988E,2 Land Space
B $9890,2 A road top edging in column 16
B $9892,2 Land Space
B $9894,2 A road marking in column 15
B $9896,2 Land Space
B $9898,2 A road marking in column 9
B $989A,2 Land Space
B $989C,2 A road top edging in column 0
B $989E,2 Land Space
B $98A0,2 A road marking in column 3
B $98A2,2 A quintuple grenade in column 25
B $98A4,2 Land Space
B $98A6,2 A triple grenade in column 6
B $98A8,2 Land Space
B $98AA,2 A barracks in column 0
B $98AC,2 Land Space
B $98AE,2 A single grenade in column 10
B $98B0,2 Land Space
B $98B2,2 Spawn Point
B $98B4,2 Land Space
B $98B6,2 Turn the alarm ON
B $98B8,2 Start of NME with rocket launchers. Ferocity:20
B $98BA,2 Land Space
B $98BC,2 A triple grenade in column 4
B $98BE,2 End of NME with rocket launchers
B $98C0,2 Turn the alarm OFF
B $98C2,2 Land Space
B $98C4,2 A wall in column 11
B $98C6,2 A wall in column 31
B $98C8,2 Fortress gates
B $98CA,2 Land Space
B $98CC,2 Spawn Point
B $98CE,1 End of levels marker
c $98D0 Update object IX position, clip to screen, dispatch sprite draw (redirect)
C $98D0,3 => Update object IX position, clip to screen, dispatch sprite draw
c $98D3 HL = HL + A (redirect)
C $98D3,3 => HL = HL + A
c $98D6 (HL) -> HL (redirect)
C $98D6,3 => (HL) -> HL
c $98D9 Convert row number to screen line address (redirect)
C $98D9,3 => Convert row number to screen line address
c $98DC DOWN HL (redirect)
C $98DC,3 => DOWN HL - move HL to the next screen line
c $98DF UP HL (redirect)
C $98DF,3 => UP HL
b $98E2 Offsets in $A000 sprites block, lo byte
N $98E2 Indexed as frame*2 (+1 if the flip bit, IX+$0B bit 2, is set) -- 8 entries cover 4 animation frames, each with a normal and flipped variant.
B $98E2,1 frame 0, normal
B $98E3,1 frame 0, flipped
B $98E4,1 frame 1, normal
B $98E5,1 frame 1, flipped
B $98E6,1 frame 2, normal
B $98E7,1 frame 2, flipped
B $98E8,1 frame 3, normal
B $98E9,1 frame 3, flipped
B $98E3,1,1 1
B $98E4,1,1 2
c $98EA HL = HL + A
c $98F0 (HL) -> HL
c $98F5 Convert row number to screen line address (via $FE00 table)
C $98FD,2 $FE00 - table of even screen lines addresses
c $9904 DOWN HL - move HL to the next screen line
N $9904 Advances screen address HL down one pixel line, crossing character-cell and screen-third boundaries as needed.
R $9904 I:HL Screen address
R $9904 O:HL Screen address one line down
C $9906,3 Same character cell? return
C $990A,2 Step down a character row
C $990F,2 Cross into next third
c $9913 UP HL
N $9913 Moves screen address HL up one pixel line, crossing character-cell and screen-third boundaries as needed.
R $9913 I:HL Screen address
R $9913 O:HL Screen address one line up
C $9915,3 Same character cell? return
C $9919,2 Step up a character row
C $991E,2 Cross into previous third
c $9922 Update object IX position, clip to screen, dispatch sprite draw
N $9922 Prepares and draws an object's sprite. Marks the record draw-active (+$0B bit 5), copies the pending position, and rejects it when either coordinate or its clip window (+$08/+$09) falls outside the visible area. Resolves the current sprite address from frame/page (+$02/+$03) and promotes the queued next frame (+$06/+$07) into place via the $98E2 line-address table and the flip flag (+$0B bit 2), then branches to the on-screen or off-screen (#R$9F1D) blit.
R $9922 I:IX Address of the 20-byte object record
C $9922,4 Mark record draw-active (+$0B bit 5)
C $9930,4 Reject object past right/bottom edge
C $993B,3 => Finish sprite off-screen
C $993E,20 Check object bounds against clip window (IX+8/9 vs B/C)
C $995A,3 => Finish sprite off-screen
C $995D,5 Frame index (IX+$02) * 2 into A
C $9962,2 lo byte of $98E2
C $9964,11 Add 1 if flipped, look up sprite lo byte ($98E2)
C $996F,6 Sprite page = (IX+$03) + $A0
C $9976,6 Copy new frame (IX+$06) into (IX+$02) for next draw
C $997C,3 New frame index * 2 into A
C $997F,11 Add 1 if flipped, look up sprite lo byte ($98E2)
C $998A,6 Store new sub-frame, sprite page = (IX+$07) + $A0
C $9994,2 Off-screen blit if past column $1E
C $9996,3 => Set up sprite erase, dispatch to erase-blit variant
C $999C,3 => Set up sprite erase, dispatch to erase-blit variant
C $99A4,3 Off-screen draw when clip window exceeded
C $99A4,3 => Off-screen sprite draw
C $99A8,3 => Off-screen sprite draw
C $99C0,2 $FE00 - table of even screen lines addresses
C $99CF,10 Compute screen draw address, dispatch to blit routine
C $99D9,3 => Clip wide sprite edge, dispatch to masked blit
C $99DC,3 => Clip sprite edge, dispatch to masked blit
C $99E9,3 => Unmasked-OR blit, draws opaque sprite row across screen thirds
C $99F0,3 => Masked-OR blit variant, draws sprite row across screen thirds
C $99F3,4 Row loop: height = (IX+$0A) - C
C $99FB,1 Blit masked row (AND mask, OR graphic) across thirds
C $9A2F,3 Advance to next pixel line, handle third wrap
C $9A40,3 => Blit finish
c $9A46 Blit continuation: draw remaining sprite width
N $9A46 Advances the screen line, then draws the remaining sprite-width segment (IX+$05 - IX+$01) through the unmasked or masked blit before committing the width and restoring SP.
R $9A46 I:IX Address of the 20-byte object record
C $9A48,4 Carry vertical offset into E
C $9A4D,7 Remaining width = (IX+$05) - (IX+$01)
C $9A5A,3 => Unmasked-OR blit, draws opaque sprite row across screen thirds
C $9A60,3 => Masked-OR blit variant, draws sprite row across screen thirds
C $9A63,6 Commit drawn width (IX+$01 = IX+$05)
C $9A69,4 Restore SP
c $9A6E Clip sprite edge, dispatch to masked blit
N $9A6E Handles horizontal clipping at a screen-third boundary before the masked blit. Compares the sprite's remaining width against the clip limit (IX+$05): an on-screen segment goes straight to the unmasked blit, while a portion overhanging off-left is negated and drawn through the masked path with the clip flag set. Both paths derive the row byte count from IX+$0A and run the masked-OR blit that copies each row across the screen thirds.
R $9A6E I:IX Address of the 20-byte object record
R $9A6E I:A Remaining sprite width
R $9A6E I:DE Screen address
C $9A6E,5 Compare sprite width to clip limit
C $9A73,5 On-screen: save entry point, split width
C $9A78,3 => Unmasked-OR blit, draws opaque sprite row across screen thirds
C $9A7E,3 Off-left: take the masked path
C $9A81,3 Negate the overhang width
C $9A85,2 Mark clip type, dispatch to masked blit
C $9A87,3 => Masked-OR blit variant, draws sprite row across screen thirds
C $9A8D,4 Row byte count from the sprite width
C $9A95,5 Masked byte: clear under the mask, OR the sprite
C $9ACF,3 Cross into the next screen third
C $9AD4,4 Advance to the next screen row
C $9AE0,3 => Blit finish
c $9AE6 Clip wide sprite edge, dispatch to masked blit
N $9AE6 Handles horizontal clipping for the wide masked blit: compares the remaining sprite width against the clip limit (IX+$05) and dispatches an on-screen segment to the unmasked blit or an off-left overhang to the masked path (#R$9E98), continuing into #R$9B05.
R $9AE6 I:IX Address of the 20-byte object record
R $9AE6 I:A Remaining sprite width
R $9AE6 I:DE Screen address
C $9AE6,3 Compare width to clip limit
C $9AF3,3 => Unmasked-OR blit, draws opaque sprite row across screen thirds
C $9AF6,2 Negate off-left overhang
C $9AFF,3 Off-left: masked path
C $9B02,3 => Masked-OR blit variant, draws sprite row across screen thirds
c $9B05 Masked-OR blit variant, draws sprite row across screen thirds
N $9B05 Masked-OR blit for a wide sprite row: AND-masks then ORs each popped word into the screen bytes across the three screen thirds. The row byte count comes from IX+$0A minus the left-clip offset C, and the loop advances the screen line for each of B rows before returning through the continuation address in HL.
R $9B05 I:IX Address of the 20-byte object record
R $9B05 I:DE Screen address
R $9B05 I:C Left-clip offset
C $9B05,3 Adjust column, dispatch entry
C $9B08,3 Row byte count from the sprite width
C $9B10,4 AND-mask then OR sprite byte, first third
C $9B17,5 AND-mask then OR sprite byte, second third
C $9B27,4 AND-mask then OR sprite byte, third third
C $9B49,4 Advance column, check wrap point
C $9B4F,3 Wrap to next screen third if needed
C $9B5B,3 => Blit finish
C $9B5E,2 Loop the rows
c $9B61 Set up sprite erase, dispatch to erase-blit variant
N $9B61 Sets up erasing a sprite: clips the row range against the object's bounds (IX+$08-$0A), computes the screen address via #R$9C23, then dispatches to the erase-blit variant matching how many screen thirds the sprite spans, with #R$9B97 queued as the continuation.
R $9B61 I:IX Address of the 20-byte object record
R $9B61 I:A Row coordinate
C $9B64,3 Positive coordinate: take $9BCB path
C $9B6E,3 Clip against upper bound (IX+$09)
C $9B75,3 Clip against lower bound (IX+$08)
C $9B7F,3 Compute screen address for sprite row via IX object
C $9B83,2 Pick erase variant by third span
C $9B88,3 => Erase sprite
C $9B8D,3 => Erase sprite variant
C $9B94,3 => Erase sprite
c $9B97 Second pass: redraw sprite via unmasked-OR blit
N $9B97 Runs after the erase pass: re-clips the row range against the object's bounds (IX+$08-$0A), recomputes the screen address via #R$9C23, and dispatches to the unmasked-OR draw-blit variant matching the sprite's third span, with #R$9FEE queued as the final continuation.
R $9B97 I:IX Address of the 20-byte object record
R $9B97 I:C Row coordinate
C $9BA1,3 Clip against upper bound (IX+$09)
C $9BA8,3 Clip against lower bound (IX+$08)
C $9BB2,3 Compute screen address for sprite row via IX object
C $9BB7,2 Pick draw variant by third span
C $9BBC,3 => Unmasked-OR blit variant
C $9BC1,3 => Unmasked-OR blit variant
C $9BC8,3 => Unmasked-OR blit variant, draws opaque sprite row across screen thirds
c $9BCB Set up sprite erase (positive path), dispatch to erase-blit
N $9BCB Erase-setup for the positive-coordinate branch of #R$9B61: clips the row range against the object's bounds (IX+$08-$0A), computes the screen address via #R$9C23, then dispatches to the erase-blit variant matching the sprite's third span, with #R$9BF5 queued as the continuation.
R $9BCB I:IX Address of the 20-byte object record
R $9BCB I:C Row coordinate
C $9BD2,3 Clip against upper bound (IX+$09)
C $9BD9,3 Clip against lower bound (IX+$08)
C $9BE2,3 Compute screen address for sprite row via IX object
C $9BE6,2 Pick erase variant by third span
C $9BEB,3 => Erase sprite variant
C $9BEF,3 => Erase sprite
C $9BF2,3 => Erase sprite
c $9BF5 Second pass (positive path): redraw via unmasked-OR blit
N $9BF5 Runs after the erase pass on the positive path: re-clips the row range against the object's bounds (IX+$08-$0A), recomputes the screen address via #R$9C23, and dispatches to the unmasked-OR draw-blit variant matching the sprite's third span, with #R$9FEE queued as the final continuation.
R $9BF5 I:IX Address of the 20-byte object record
R $9BF5 I:C Row coordinate
C $9C00,3 Clip against upper bound (IX+$09)
C $9C07,3 Clip against lower bound (IX+$08)
C $9C10,3 Compute screen address for sprite row via IX object
C $9C14,2 Pick draw variant by third span
C $9C19,3 => Unmasked-OR blit variant
C $9C1D,3 => Unmasked-OR blit variant
C $9C20,3 => Unmasked-OR blit variant, draws opaque sprite row across screen thirds
c $9C23 Compute screen address for sprite row via IX object (unconfirmed)
N $9C23 Computes the screen draw address for a sprite whose top row (in A) may be clipped. For a fully-visible top it looks the line up in the $FE00 even-line table and sets the height in B, trimming it if the sprite runs past the lower bound (IX+$09). If the top is off-screen it instead skips the hidden rows, advances the sprite-data pointer past them, and starts drawing at the clip-edge line (IX+$08).
R $9C23 I:IX Address of the 20-byte object record
R $9C23 I:A Top row of the sprite
R $9C23 I:B Column byte offset
R $9C23 O:DE Screen draw address
R $9C23 O:B Visible sprite height
C $9C23,3 Row above the clip bound?
C $9C2D,2 $FE00 - table of even screen lines addresses
C $9C2F,4 Look up screen line via $FE00 table
C $9C38,3 Sprite height into B
C $9C40,4 Trim if it runs past the bound
C $9C47,3 Off the top: rows hidden
C $9C54,4 Offset into the sprite data
C $9C5A,3 Screen line at the clip edge
C $9C5F,2 $FE00 - table of even screen lines addresses
c $9C6B Erase sprite: AND-mask bytes off screen, SP walks data as pointer
N $9C6B Erases a six-byte-wide sprite by repointing SP at the mask data and ANDing the inverse of each popped mask word into the screen bytes row by row across the three screen thirds, restoring the real SP (saved in $FD82) on exit.
R $9C6B I:HL Mask-data pointer
R $9C6B I:DE Screen address
R $9C6B I:B Row count
C $9C6B,4 Save SP, aim it at the mask data
C $9C72,4 Clear one column byte
C $9C79,4 Clear the paired byte
C $9C83,4 Clear a third byte
C $9C88,4 Clear the fourth byte, next line
C $9C8E,4 Clear the fifth and sixth bytes
C $9C93,3 Check screen third boundary
C $9C9C,3 Wrap to next screen third if needed
C $9CA2,2 Loop the columns
c $9CB1 Erase sprite: AND-mask bytes off screen, SP walks data as pointer
N $9CB1 Erases a three-byte-wide sprite by repointing SP at the mask data and ANDing the inverse of each popped mask word into the screen bytes row by row across the three screen thirds, restoring the real SP (saved in $FD82) on exit.
R $9CB1 I:HL Mask-data pointer
R $9CB1 I:DE Screen address
R $9CB1 I:B Row count
C $9CB1,4 Save SP, repurpose as mask-data pointer
C $9CB8,4 Clear one column byte
C $9CBF,4 Clear the paired byte
C $9CC9,4 Clear a third byte
C $9CCF,3 Check screen third boundary
C $9CD8,3 Wrap to next screen third if needed
C $9CDE,2 Loop next row
C $9CE1,4 Restore SP
c $9CED Erase sprite variant: AND-mask 2 bytes per column via SP
N $9CED Erases a sprite by repointing SP at the mask data and ANDing the inverse of each popped mask word into the screen bytes row by row across the three screen thirds, restoring the real SP (saved in $FD82) on exit.
R $9CED I:HL Mask-data pointer
R $9CED I:DE Screen address
R $9CED I:B Row count
C $9CED,4 Save SP, repurpose as mask-data pointer
C $9CF6,4 Clear one column byte
C $9CFB,3 Clear the paired byte
C $9D01,3 Check screen third boundary
C $9D10,2 Loop next row
C $9D13,4 Restore SP
c $9D1F Erase sprite: AND-mask bytes off screen, SP walks data as pointer
N $9D1F Erases a three-byte-wide sprite by repointing SP at the mask data and ANDing the inverse of each popped mask word into the screen bytes row by row across the three screen thirds, restoring the real SP (saved in $FD82) on exit.
R $9D1F I:HL Mask-data pointer
R $9D1F I:DE Screen address
R $9D1F I:B Row count
C $9D1F,4 Save SP, repurpose as mask-data pointer
C $9D26,4 Clear one column byte
C $9D2D,4 Clear the paired byte
C $9D37,4 Clear a third byte
C $9D3D,3 Check screen third boundary
C $9D46,3 Wrap to next screen third if needed
C $9D4C,2 Loop next row
C $9D4F,4 Restore SP
c $9D5B Erase sprite variant: AND-mask row bytes via SP
N $9D5B Erases a sprite from the screen: repoints SP at the mask data, then ANDs the inverse of each popped mask word into the screen bytes row by row across the three screen thirds. Real SP is saved in $FD82 and restored on exit.
R $9D5B I:HL Mask-data pointer
R $9D5B I:DE Screen address
R $9D5B I:B Row count
C $9D5B,4 Save SP, repurpose as mask-data pointer
C $9D63,4 Clear one screen byte
C $9D6A,4 Clear the paired byte
C $9D6F,3 Check screen third boundary
C $9D7E,2 Loop next row
C $9D81,4 Restore SP
c $9D8D Unmasked-OR blit variant, draws opaque sprite row across screen thirds
N $9D8D Draws an opaque sprite by repointing SP at the sprite data and ORing each popped word straight into the screen bytes row by row across the three screen thirds. No mask is applied, so the sprite overwrites whatever is under it; the real SP is saved in $FD82 and restored on exit.
R $9D8D I:HL Sprite-data pointer
R $9D8D I:DE Screen address
R $9D8D I:B Row count
C $9D8D,4 Save SP, repurpose as sprite-data pointer
C $9D93,4 OR sprite byte, first third
C $9D9C,4 OR sprite byte, second third
C $9DA6,4 OR sprite byte, third third
C $9DAE,3 Check screen third boundary
C $9DB7,3 Wrap to next screen third if needed
C $9DBD,2 Loop next row
C $9DC0,4 Restore SP
c $9DCC Unmasked-OR blit variant: 2 bytes per column via SP
C $9DD2,4 OR sprite byte into one column byte
C $9DD8,3 OR sprite byte into paired byte
C $9DE5,3 Check screen third boundary
C $9DEA,4 Advance to the next screen row
C $9DF4,2 Loop the rows
c $9E03 Unmasked-OR blit variant: 2 bytes per column via SP
C $9E0B,4 OR sprite byte into one column byte
C $9E0F,3 OR sprite byte into paired byte
C $9E14,3 Check screen third boundary
c $9E32 Unmasked-OR blit variant: 2 bytes per column via SP
C $9E38,4 OR sprite byte into one column byte
C $9E43,3 OR sprite byte into paired byte
C $9E4B,3 Check screen third boundary
C $9E50,4 Advance to the next screen row
C $9E5A,2 Loop the rows
c $9E69 Unmasked-OR blit variant: alternating columns via SP
C $9E70,3 OR sprite byte into first column
C $9E76,3 OR sprite byte into second column
C $9E7A,3 Check screen third boundary
c $9E98 Masked-OR blit variant, draws sprite row across screen thirds
R $9E98 I:DE Screen address of first byte
R $9E98 I:B Sprite row count
R $9E98 I:HL Continuation address (jumped to via JP (HL) when done)
C $9E99,4 AND-mask then OR sprite byte, first third
C $9EA5,5 AND-mask then OR sprite byte, second third
C $9EB4,4 AND-mask then OR sprite byte, third third
C $9EC0,3 Advance column, check wrap point
C $9EC5,7 Wrap to next screen third if needed
C $9ED1,3 End blit when all columns drawn
C $9ED4,2 Loop next sprite row
C $9ED6,1 Return via continuation address in HL
c $9EDF Unmasked-OR blit, draws opaque sprite row across screen thirds
C $9EDF,4 OR sprite byte, first third
C $9EE5,4 OR sprite byte, second third
C $9EEF,4 OR sprite byte, third third
C $9EFE,3 Advance row, check wrap point
C $9F03,7 Wrap to next screen third if needed
C $9F0F,3 => Blit finish
c $9F1D Off-screen sprite draw: clip, compute address, dispatch blit
N $9F1D Draws a sprite running off the left or right edge: clips its width, skips the hidden columns in the sprite data, computes the screen address of the visible part, then hands it to the row blitter.
C $9F1D,7 Check width against clip limit
C $9F24,4 Sign check: fully off left/right edge
C $9F28,6 Skip the hidden columns in the sprite data
C $9F34,6 Clip column against (IX+$08)
C $9F40,2 $FE00 - table of even screen lines addresses
C $9F43,4 Look up the screen line address
C $9F49,3 Width remaining after the clip
C $9F60,4 Trim against the vertical bound
C $9F74,3 Other edge: recompute the width
C $9F71,3 => Masked-OR blit variant, draws sprite row across screen thirds
C $9FA3,2 $FE00 - table of even screen lines addresses
C $9FD5,3 => Unmasked-OR blit, draws opaque sprite row across screen thirds
c $9FDE Finish sprite off-screen: commit pending fields
N $9FDE Finishes an off-screen or clipped sprite without drawing: clears the draw-active flag (+$0B bit 5) and commits the pending frame/page and Y fields (+$06/+$07/+$05) into the current ones (+$02/+$01).
R $9FDE I:IX Address of the 20-byte object record
C $9FDE,4 Clear draw-active flag
C $9FE2,6 Promote next frame into current
C $9FEE,6 Promote next Y into current
c $9FF5 Blit finish: commit Y position, restore SP
N $9FF5 Blit finish: commits the pending Y position (+$05 into +$01) and restores the real SP saved in $FD82.
R $9FF5 I:IX Address of the 20-byte object record
C $9FF5,6 Commit pending Y position
C $9FFB,4 Restore SP
b $A000 Sprites of Player and troopers; width 3 height 21
D $A000 The sprites have no mask; even row bytes go left to right, odd row bytes right to left.
B $A000,64,16 #HTML[<img src="images/spriteA000.png" />]
B $A040,64,16 #HTML[<img src="images/spriteA040.png" />]
B $A080,64,16 #HTML[<img src="images/spriteA080.png" />]
B $A0C0,64,16 #HTML[<img src="images/spriteA0C0.png" />]
B $A100,64,16 #HTML[<img src="images/spriteA100.png" />]
B $A140,64,16 #HTML[<img src="images/spriteA140.png" />]
B $A180,64,16 #HTML[<img src="images/spriteA180.png" />]
B $A1C0,64,16 #HTML[<img src="images/spriteA1C0.png" />]
B $A200,64,16 #HTML[<img src="images/spriteA200.png" />]
B $A240,64,16 #HTML[<img src="images/spriteA240.png" />]
B $A280,64,16 #HTML[<img src="images/spriteA280.png" />]
B $A2C0,64,16 #HTML[<img src="images/spriteA2C0.png" />]
B $A300,64,16 #HTML[<img src="images/spriteA300.png" />]
B $A340,64,16 #HTML[<img src="images/spriteA340.png" />]
B $A380,64,16 #HTML[<img src="images/spriteA380.png" />]
B $A3C0,64,16 #HTML[<img src="images/spriteA3C0.png" />]
B $A400,64,16 #HTML[<img src="images/spriteA400.png" />]
B $A440,64,16 #HTML[<img src="images/spriteA440.png" />]
B $A480,64,16 #HTML[<img src="images/spriteA480.png" />]
B $A4C0,64,16 #HTML[<img src="images/spriteA4C0.png" />]
B $A500,64,16 #HTML[<img src="images/spriteA500.png" />]
B $A540,64,16 #HTML[<img src="images/spriteA540.png" />]
B $A580,64,16 #HTML[<img src="images/spriteA580.png" />]
B $A5C0,64,16 #HTML[<img src="images/spriteA5C0.png" />]
B $A600,64,16 #HTML[<img src="images/spriteA600.png" />]
B $A640,64,16 #HTML[<img src="images/spriteA640.png" />]
B $A680,64,16 #HTML[<img src="images/spriteA680.png" />]
B $A6C0,64,16 #HTML[<img src="images/spriteA6C0.png" />]
B $A700,64,16 #HTML[<img src="images/spriteA700.png" />]
B $A740,64,16 #HTML[<img src="images/spriteA740.png" />]
B $A780,64,16 #HTML[<img src="images/spriteA780.png" />]
B $A7C0,64,16 #HTML[<img src="images/spriteA7C0.png" />]
B $A800,64,16 #HTML[<img src="images/spriteA800.png" />]
B $A840,64,16 #HTML[<img src="images/spriteA840.png" />]
B $A880,64,16 #HTML[<img src="images/spriteA880.png" />]
B $A8C0,64,16 #HTML[<img src="images/spriteA8C0.png" />]
B $A900,64,16 #HTML[<img src="images/spriteA900.png" />]
B $A940,64,16 #HTML[<img src="images/spriteA940.png" />]
B $A980,64,16 #HTML[<img src="images/spriteA980.png" />]
B $A9C0,64,16 #HTML[<img src="images/spriteA9C0.png" />]
B $AA00,64,16 #HTML[<img src="images/spriteAA00.png" />]
B $AA40,64,16 #HTML[<img src="images/spriteAA40.png" />]
B $AA80,64,16 #HTML[<img src="images/spriteAA80.png" />]
B $AAC0,64,16 #HTML[<img src="images/spriteAAC0.png" />]
B $AB00,64,16 #HTML[<img src="images/spriteAB00.png" />]
B $AB40,64,16 #HTML[<img src="images/spriteAB40.png" />]
B $AB80,64,16 #HTML[<img src="images/spriteAB80.png" />]
B $ABC0,64,16 #HTML[<img src="images/spriteABC0.png" />]
B $AC00,64,16 #HTML[<img src="images/spriteAC00.png" />]
B $AC40,64,16 #HTML[<img src="images/spriteAC40.png" />]
B $AC80,64,16 #HTML[<img src="images/spriteAC80.png" />]
B $ACC0,64,16 #HTML[<img src="images/spriteACC0.png" />]
B $AD00,64,16 #HTML[<img src="images/spriteAD00.png" />]
B $AD40,64,16 #HTML[<img src="images/spriteAD40.png" />]
B $AD80,64,16 #HTML[<img src="images/spriteAD80.png" />]
B $ADC0,64,16 #HTML[<img src="images/spriteADC0.png" />]
B $AE00,64,16 #HTML[<img src="images/spriteAE00.png" />]
B $AE40,64,16 #HTML[<img src="images/spriteAE40.png" />]
B $AE80,64,16 #HTML[<img src="images/spriteAE80.png" />]
B $AEC0,64,16 #HTML[<img src="images/spriteAEC0.png" />]
B $AF00,64,16 #HTML[<img src="images/spriteAF00.png" />]
B $AF40,64,16 #HTML[<img src="images/spriteAF40.png" />]
B $AF80,64,16 #HTML[<img src="images/spriteAF80.png" />]
B $AFC0,64,16 #HTML[<img src="images/spriteAFC0.png" />]
B $B000,64,16 #HTML[<img src="images/spriteB000.png" />]
B $B040,64,16 #HTML[<img src="images/spriteB040.png" />]
B $B080,64,16 #HTML[<img src="images/spriteB080.png" />]
B $B0C0,64,16 #HTML[<img src="images/spriteB0C0.png" />]
B $B100,64,16 #HTML[<img src="images/spriteB100.png" />]
B $B140,64,16 #HTML[<img src="images/spriteB140.png" />]
B $B180,64,16 #HTML[<img src="images/spriteB180.png" />]
B $B1C0,64,16 #HTML[<img src="images/spriteB1C0.png" />]
B $B200,64,16 #HTML[<img src="images/spriteB200.png" />]
B $B240,64,16 #HTML[<img src="images/spriteB240.png" />]
B $B280,64,16 #HTML[<img src="images/spriteB280.png" />]
B $B2C0,64,16 #HTML[<img src="images/spriteB2C0.png" />]
B $B300,64,16 #HTML[<img src="images/spriteB300.png" />]
B $B340,64,16 #HTML[<img src="images/spriteB340.png" />]
B $B380,64,16 #HTML[<img src="images/spriteB380.png" />]
B $B3C0,64,16 #HTML[<img src="images/spriteB3C0.png" />]
B $B400,64,16 #HTML[<img src="images/spriteB400.png" />]
B $B440,64,16 #HTML[<img src="images/spriteB440.png" />]
B $B480,64,16 #HTML[<img src="images/spriteB480.png" />]
B $B4C0,64,16 #HTML[<img src="images/spriteB4C0.png" />]
B $B500,64,16 #HTML[<img src="images/spriteB500.png" />]
B $B540,64,16 #HTML[<img src="images/spriteB540.png" />]
B $B580,64,16 #HTML[<img src="images/spriteB580.png" />]
B $B5C0,64,16 #HTML[<img src="images/spriteB5C0.png" />]
B $B600,64,16 #HTML[<img src="images/spriteB600.png" />]
B $B640,64,16 #HTML[<img src="images/spriteB640.png" />]
B $B680,64,16 #HTML[<img src="images/spriteB680.png" />]
B $B6C0,64,16 #HTML[<img src="images/spriteB6C0.png" />]
B $B700,64,16 #HTML[<img src="images/spriteB700.png" />]
B $B740,64,16 #HTML[<img src="images/spriteB740.png" />]
B $B780,64,16 #HTML[<img src="images/spriteB780.png" />]
B $B7C0,64,16 #HTML[<img src="images/spriteB7C0.png" />]
B $B800,64,16 #HTML[<img src="images/spriteB800.png" />]
B $B840,64,16 #HTML[<img src="images/spriteB840.png" />]
B $B880,64,16 #HTML[<img src="images/spriteB880.png" />]
B $B8C0,64,16 #HTML[<img src="images/spriteB8C0.png" />]
B $B900,64,16 #HTML[<img src="images/spriteB900.png" />]
B $B940,64,16 #HTML[<img src="images/spriteB940.png" />]
B $B980,64,16 #HTML[<img src="images/spriteB980.png" />]
B $B9C0,64,16 #HTML[<img src="images/spriteB9C0.png" />]
B $BA00,64,16 #HTML[<img src="images/spriteBA00.png" />]
B $BA40,64,16 #HTML[<img src="images/spriteBA40.png" />]
B $BA80,64,16 #HTML[<img src="images/spriteBA80.png" />]
B $BAC0,64,16 #HTML[<img src="images/spriteBAC0.png" />]
B $BB00,64,16 #HTML[<img src="images/spriteBB00.png" />]
B $BB40,64,16 #HTML[<img src="images/spriteBB40.png" />]
B $BB80,64,16 #HTML[<img src="images/spriteBB80.png" />]
B $BBC0,64,16 #HTML[<img src="images/spriteBBC0.png" />]
B $BC00,64,16 #HTML[<img src="images/spriteBC00.png" />] Rocket Launcher
B $BC40,64,16 #HTML[<img src="images/spriteBC40.png" />] Rocket Launcher
B $BC80,64,16 #HTML[<img src="images/spriteBC80.png" />] Rocket Launcher
B $BCC0,64,16 #HTML[<img src="images/spriteBCC0.png" />] Rocket Launcher
B $BD00,64,16 #HTML[<img src="images/spriteBD00.png" />]
B $BD40,64,16 #HTML[<img src="images/spriteBD40.png" />]
B $BD80,64,16 #HTML[<img src="images/spriteBD80.png" />]
B $BDC0,64,16 #HTML[<img src="images/spriteBDC0.png" />]
B $BE00,64,16 #HTML[<img src="images/spriteBE00.png" />]
B $BE40,64,16 #HTML[<img src="images/spriteBE40.png" />]
B $BE80,64,16 #HTML[<img src="images/spriteBE80.png" />]
B $BEC0,64,16 #HTML[<img src="images/spriteBEC0.png" />]
B $BF00,64,16 #HTML[<img src="images/spriteBF00.png" />]
B $BF40,64,16 #HTML[<img src="images/spriteBF40.png" />]
B $BF80,64,16 #HTML[<img src="images/spriteBF80.png" />]
B $BFC0,64,16 #HTML[<img src="images/spriteBFC0.png" />]
w $C000 Sprite addresses
W $C000 Sprite addr Cliff edge right; width 2
W $C002 Sprite addr Cliff edge left; width 2
W $C004 Sprite addr Wall; width 4
W $C006 Sprite addr ???
W $C008 Sprite addr ???
W $C00A Sprite addr 
W $C00C Sprite addr 
W $C00E Sprite addr 
W $C010 Sprite addr 
W $C012 Sprite addr 
W $C014 Sprite addr 
W $C016 Sprite addr 
W $C018 Sprite addr 
W $C01A Sprite addr 
W $C01C Sprite addr 
W $C01E Sprite addr 
W $C020 Sprite addr 
W $C022 ??
W $C024 Sprite addr 
W $C026 Sprite addr 
W $C028 Sprite addr ???; width ?
W $C02A Sprite addr ???; width ?
W $C02C Sprite addr ???; width ?
W $C02E Sprite addr Motorbike; width 6
W $C030 Sprite addr Hut; width 6
W $C032 Sprite addr Jeep; width 4
W $C034 Sprite addr Cave, exit to the right; width 6
W $C036 Sprite addr Cave, exit to the left; width 6
W $C038 Sprite addr Cave top edge; width 6
W $C03A Sprite addr Cave bottom edge; width 6
W $C03C Sprite addr Truck; width 8
W $C03E Sprite addr ???; width 2?
W $C040 Sprite addr Cliff top right; width 6
W $C042 Sprite addr ???; width 2
W $C044 Sprite addr Cliff bottom right; width 6
W $C046 Sprite addr Cliff top left; width 6
W $C048 Sprite addr ???; width 2
W $C04A Sprite addr Cliff bottom left; width 6
W $C04C Sprite addr ???; width 2
W $C04E Sprite addr ???; width 2
b $C050 Sprite ???; width 2
b $C0A0 Sprite ???; width 2
b $C0F0 Sprite Cliff bottom left; width 6
B $C0F0,,12 #HTML[#UDGARRAY6,,,6($C0F0-$C1DF-1-48)(cliffbotlt)]
b $C1E0 Sprite Cliff top left; width 6
B $C1E0,,12 #HTML[#UDGARRAY6,,,6($C1E0-$C26F-1-48)(clifftoplt)]
b $C270 Sprite ???; width 2
b $C2C4 Sprite ???; width 2
b $C318 Sprite Cliff edge left; width 2
B $C318,,8 #HTML[#UDGARRAY2,,,2($C318-$C34F-1-16)(clifflt)]
b $C350 Sprite Cliff edge right; width 2
B $C350,,8 #HTML[#UDGARRAY2,,,2($C350-$C387-1-16)(cliffrt)]
b $C388 Sprite Cliff bottom right; width 6
B $C388,,12 #HTML[#UDGARRAY6,,,6($C388-$C477-1-48)(cliffbotrt)]
b $C478 Sprite Cliff top right; width 6
B $C478,,12 #HTML[#UDGARRAY6,,,6($C478-$C507-1-48)(clifftoprt)]
b $C508 Sprite Cave, exit to the right; width 6
B $C508,,12 #HTML[#UDGARRAY6,,,6($C508-$C5F7-1-48)(cavert)]
b $C5F8 Sprite Cave, exit to the left; width 6
B $C5F8,,12 #HTML[#UDGARRAY6,,,6($C5F8-$C6E7-1-48)(cavelt)]
b $C6E8 Sprite Cave top edge; width 6
B $C6E8,,12 #HTML[#UDGARRAY6,,,6($C6E8-$C717-1-48)(cavetop)]
b $C718 Sprite Cave bottom edge; width 6
B $C718,,12 #HTML[#UDGARRAY6,,,6($C718-$C747-1-48)(cavebot)]
b $C748 Sprite Truck; width 8
B $C748,,16
b $C848 Sprite ???; width 2?
b $C890 Sprite Hut; width 6
B $C890,,12 #HTML[#UDGARRAY6,,,6($C890-$C97F-1-48)(hut)]
b $C980 Sprite Jeep; width 4
B $C980,,8 #HTML[#UDGARRAY4,,,4($C980-$C9FF-1-32)(jeep)]
b $CA00 Sprite Motorbike; width 6
B $CA00,,12 #HTML[#UDGARRAY6,,,6($CA00-$CA8F-1-48)(motorbike)]
b $CA90 Sprite ???; width ?
b $CAC0 Sprite ???; width ?
b $CB20 Sprite ???; width ?
b $CB50 Sprite Wall; width 4
B $CB50,,8 #HTML[#UDGARRAY4,,,4($CB50-$CC17-1-32)(wall)]
b $CC18 ???
b $CD1D
b $CD88
b $CE5F
b $CF38 Sprite ???
b $CFAE
b $CFB2
t $CFBD
b $CFC0
t $D041
b $D047
t $D092
b $D095
t $D0AF
b $D0B6
t $D0F4
b $D0F7
t $D1E8
b $D1EC
t $D309
b $D30C
t $D3BB
b $D3BE
t $D6AA
b $D6AD
t $D6B3
b $D6B6
t $D6FD
b $D700
t $D74E
b $D751
t $D75F
b $D762
c $DC83 Get random byte?? (redirect)
C $DC83,3 => Get random byte??
c $DC86 Entry E=0, dispatch bullet/collision handler via $DF39 (redirect)
C $DC86,3 => Entry E=0, dispatch bullet/collision handler via $DF39
c $DC89 Initialization and go to game main loop (redirect)
C $DC89,3 => Initialization and go to game main loop
c $DC8C Check IX flag and column bound, dispatch (redirect)
C $DC8C,3 => Check IX flag and column bound, dispatch
c $DC8F Check screen brightness threshold, inside $DD8D (redirect)
c $DC92 Entry E=2, dispatch bullet/collision handler via $DF39 (redirect)
C $DC92,3 => Entry E=2, dispatch bullet/collision handler via $DF39
c $DC95 Scroll level and shift all objects down
N $DC95 Advances the level scroll one step, then shifts every object in the $5B11 table down by one row (+$05) until the $90 end marker.
C $DC95,3 Advance level scroll
C $DC9C,3 Scroll object down one row
C $DCA4,5 Stop at $90 end marker
c $DCAF Periodically spawn a new enemy from the edge
N $DCAF Periodically spawns a new enemy: on a countdown (IY+$7D) it draws a random value to pick a spawn edge and column, then claims a free slot in the $5B11 enemy table (#R$E10F) and initialises the enemy there.
C $DCAF,3 Spawning enabled ($FDFB)?
C $DCB4,3 Count down the spawn timer
C $DCBB,3 Get random byte
C $DCC2,2 Random bit picks spawn edge
C $DCCF,3 Common enemy-object init helper
C $DCD6,3 Find free enemy slot in $5B11 table, inside $E01B
C $DCDA,4 Mark new enemy (flag bit 6)
c $DCDF Initialization and go to game main loop
C $DCF3,3 Player's object record address
C $DCF6,2 ($5BDA) = $10 - Initial starting column
C $DCF9,2 ($5BDB) = $40 - Initial pixels down screen start point
C $DCFC,2 ($5BDC) = $02 - ??
C $DCFF,1 HL = $5BDE
C $DD01,3 Player's object record address
C $DD07,2 Copying 4 bytes from $5BDA to $5BDE
C $DD0B,1 HL = $5BE4
C $DD0E,1 HL = $5BE5
C $DD11,1 HL = $5BE6
C $DD12,3 Clear the projectile/vehicle/explosion tables at $F73C
C $DD15,16 Initialize values for random byte calculation
C $DD38,4 $01 - Enemy delay (Time until first enemy appears)
C $DD3C,3 => Game's main loop, Part 1
b $DD3F
c $DD71 Process object records at $5B11
C $DD79,3 Process object IX??
C $DD7F,2 Next record
C $DD84,2 End marker?
c $DD89 Process Player's object record
C $DD89,4 Player's object record address
c $DD8D Process object IX??
C $DD90,4 Check wall-solid flag, adjust bit 0
C $DDA2,2 Frame index * 2 into E
C $DDA4,8 Add direction offset, index frame table $DD3F
C $DDB6,5 Skip further checks if state (IX+$12) = $09
C $DDC1,5 Check screen brightness upper bound
C $DDCB,2 Row above the band? skip
C $DDD1,4 Row below the object? skip
C $DDD8,2 Within reach of the object?
C $DDDF,3 Clamp the row to the visible range
C $DDE6,3 Same column as last frame?
C $DDF3,2 Set up the shadow row
C $DDF5,3 Convert row number to screen line address
C $DDFB,2 Fill the shadow bytes
C $DE04,2 ...and the row below
C $DE0B,4 Off screen: clear the draw flag
C $DE10,3 Clamp against the left edge
C $DE2A,3 Store the computed clip bounds
C $DE30,4 Object visible vertically?
C $DE3D,3 Draw the object
C $DE4D,4 Flag it as drawn
C $DE52,3 Special mid-screen row band
C $DE5D,4 Switch to a specific object state
C $DE65,4 Default clip bounds
C $DE6D,4 Solid object? branch
C $DE73,4 Otherwise update its position and draw
R $DD8D I:IX Address of the 20-byte object record
C $DE77,3 => Update object IX position, clip to screen, dispatch sprite draw
C $DE8E,3 => Mark map cells for object IX, direction-aware
c $DE91 Game's main loop, Part 1
C $DE91,4 Is Player alive??
C $DEA9,3 Trigger sound effect A into free slot at $6433
C $DEC6,3 Scroll level and shift all objects down
C $DECB,3 Reset R register (random seed), inside $9193
C $DECE,3 Process object records at $5B11
C $DED5,4 Check bit 6 (??) of Last joystick/keyboard bits ($FD85)
b $DEDD
c $DEEF Game's main loop, Part 2
C $DEEF,3 Rebuild active-object list at $F900 from $FF00 buffer
C $DEF2,3 Set up player object pointers (IX=$5BDA)
C $DEF5,3 Check fire button and joystick input
C $DEF8,3 Update boss/enemy state via IX=$5B11
C $DEFB,3 Scan player-bullet table at $F82D, init $F8ED marker
C $DEFE,3 Set up grenade table $F81E, dispatch
C $DF01,3 Set up primary projectile/vehicle table $F73C, process motion
C $DF04,3 Process Player's object record
C $DF07,3 Scan explosion-effect table $F856, entry stride $14
C $DF0A,3 Decrement Enemy delay ($FDDD), spawn enemy by Area ($FDE5) when due
C $DF0D,3 Scan $6648 table, call $65A5 for active entries
C $DF10,3 Periodically spawn a new enemy from the edge
C $DF13,3 => Game's main loop, Part 1
c $DF16 Advance 32-bit shift register at IY+$1B..$1E (unconfirmed)
N $DF16 Feeds a bit derived from the flags in $FD9B into the 32-bit shift register held across IY+$1B..$1E, rotating it one place; returns $FD9B in A.
C $DF19,2 Mask control bits
C $DF1F,4 Rotate the bit through IY+$1B..$1E
c $DF33 Entry E=2, dispatch bullet/collision handler via $DF39
c $DF37 Entry E=0, dispatch bullet/collision handler via $DF39
C $DF39,7 Switch to $F900 stack for object scan
C $DF40,6 Pop bullet type, check high bit
C $DF48,7 Compare bullet Y against object bounds
C $DF54,6 Compare bullet X against object bounds
c $DF67
c $DF6D
c $DF71
C $DF71 Player is dead??
c $DF7B Bullet collision check, carry set on hit
N $DF7B Reached when the scanned record is a wall or obstacle (type byte bit 7 set) rather than an enemy. It decides how the bullet interacts with the tile -- passing over special tiles, and for real walls testing whether the bullet overlaps and whether the wall is breakable. A breakable tile that is hit gets its top bit set to mark the damage, while solid walls just stop the bullet.
C $DF7B,4 Type $80: pass straight through
C $DF7F,4 Split by wall type (bit 1)
C $DF89,4 Only certain directions damage it
C $DF91,3 Mask the tile column, retest bounds
C $DF96,4 Solid wall? jump to the edge test
C $DF9E,4 Only breakable if the tile is flagged
C $DFA4,4 Compare row against wall bound
C $DFAD,2 Compare column against wall bound
C $DFB5,3 Register the hit
C $DFB8,4 Set the tile's damage bit
C $DFBE,4 Save the position for the edge tests
C $DFCA,3 Check second edge crossing
C $DFCD,2 Distance to the near vertical edge
C $DFD4,3 Does the bullet span overlap the tile?
C $DFDD,4 Inside the tile: report a hit
C $DFE4,3 Try the far edge of this half
C $DFF3,2 Check the other vertical half
C $E005,3 ...its far edge too
C $E014,4 Miss: restore and scan on
c $E01B Check IX flag and column bound, dispatch (unconfirmed)
N $E01B Tests whether the enemy at IX may move to the target cell (column L, coordinate E): skips when flag bit 1 is set or the column exceeds $20, otherwise reads the map cell via #R$DF33. A clear cell commits the new position at +$04/+$06 ($E084); a blocked cell either reverses the object (turn state $16 at +$0C) or, selected by the AI state at +$12, recomputes a new heading through #R$E112.
R $E01B I:IX Object record pointer
R $E01B I:L Target column
R $E01B I:E Target coordinate
C $E01B,6 Check flag bit 1 and column limit
C $E022,2 Reject column past $20
C $E026,7 Compute map address from row/column offset
C $E038,2 No collision: commit move
C $E03A,4 Check wall-solid flag (IX+$0B)
C $E033,3 Entry E=2, dispatch bullet/collision handler via $DF39
C $E049,4 Blocked: set turn-around state $16
C $E04E,3 Branch by AI state (IX+$12)
C $E061,3 Common enemy-object init helper
C $E075,3 Common enemy-object init helper
C $E084,6 Store new position into record
C $E0A2,4 Check bit 3 (Up) of Last joystick/keyboard bits ($FD85)
b $E0BF
c $E100 Set up player object pointers (IX=$5BDA) (redirect)
C $E100,3 => Set up player object pointers
c $E103 Check fire button and joystick input (redirect)
C $E103,3 => Check fire button and joystick input
c $E106 Update boss/enemy state via IX=$5B11 (redirect)
C $E106,3 => Update boss/enemy state via IX=$5B11
c $E109 Rebuild active-object list at $F900 from $FF00 buffer (redirect)
C $E109,3 => Rebuild active-object list at $F900 from $FF00 buffer
c $E10C Decrement Enemy delay ($FDDD), spawn enemy by Area ($FDE5) when due (redirect)
C $E10C,3 => Decrement Enemy delay ($FDDD), spawn enemy by Area ($FDE5) when due
c $E10F Find free enemy slot in $5B11 table, inside $E01B (redirect)
c $E112 Common enemy-object init helper (redirect)
C $E112,3 => Common enemy-object init helper
b $E115
c $E1AC Common enemy-object init helper (unconfirmed)
C $E1AC,3 Get random byte??
c $E1B5 Service the two bomb/explosion slots
N $E1B5 Services the two active bomb/explosion slots ($FDC3 and $FDC5), calling #R$E1D1 on each to check for enemy hits and advance the effect.
C $E1BB,2 First slot active?
C $E1BF,3 Check pickup/collision near object, award score
C $E1C8,2 Second slot active?
C $E1CC,3 Check pickup/collision near object, award score
c $E1D1 Check pickup/collision near object, award score
N $E1D1 Checks whether an active bomb/explosion overlaps any enemy in the $F8EA list; a hit marks the enemy and scores 750. With no hit it counts down the explosion's own timer and, when that lapses, spawns a fresh object at a computed position.
C $E1D4,3 Turn the position into a scan key
C $E1DB,3 Scan the enemy list for one in range
C $E1E5,2 No hit: fall through to the timer
C $E1E8,2 Mark hit
C $E1EA,3 +750??
C $E1ED,3 => Update Score
C $E1F0,3 Count down the respawn timer
C $E1F3,2 Reload the timer
C $E1F5,3 Compute the spawn column
C $E202,3 Compute the spawn row
C $E208,3 Grab a free enemy slot
C $E210,3 Fill in the new record
C $E221,2 Flag the new object
c $E224 Jeep hit check, kill/score, spawn next enemy (unconfirmed)
N $E224 Runs the Jeep enemy each frame. Once it has driven far enough it fires shells at the player on a cadence that quickens in later Areas, and enough shell hits destroy it for 1500 points. It also kills the player if caught in the Jeep's body or run over.
C $E224,3 Read the Jeep flag
C $E227,4 None active? nothing to do
C $E22B,5 Turn the flag into a table offset
C $E231,3 Load the Jeep's row
C $E235,2 Only fires past row $50
C $E242,2 Set the fire cadence
C $E24A,3 Get Area number
C $E253,3 Due to fire this frame?
C $E25A,3 Aim at the player
C $E268,3 Scan object table (IX,$0E stride), compute and store motion vector
C $E26C,3 Check the shell against the targets
C $E280,2 Count the hits on the Jeep
C $E282,4 Destroyed after enough hits
C $E286,4 Mark it dead
C $E28A,3 +1500?? for destroying a Jeep??
C $E28D,3 Update Score
C $E290,3 Player caught under the Jeep?
C $E2AE,4 Player is dead??
C $E2B2,4 Update the two gun positions
C $E2BF,3 Compare against the player column
C $E2D8,4 Player is dead??
c $E2DD Init enemy object (BC=$0806, type $07) (unconfirmed)
c $E2EA Decrement Enemy delay ($FDDD), spawn enemy by Area ($FDE5) when due
C $E2EA,6 Decrement timer, check spawn-eligible flag
C $E2F0,2 Timer up? go set up the next spawn
C $E2F7,5 Force level-end once the counter passes $14
C $E2FF,3 Get Area number
C $E308,2 Reload the delay -- shorter in later Areas
C $E316,4 Take the alternate path if the level flag is set
C $E323,3 Get Area number
C $E326,2 $03 - Fortress byte
C $E32A,1 Fortress Area: spawn a fixed squad
C $E33A,4 Mark one squad member special
C $E32D,3 Init enemy object (BC=$0806, type $07)
C $E332,3 Init enemy object (BC=$0806, type $07)
C $E337,3 Init enemy object (BC=$0806, type $07)
C $E340,3 Init enemy object (BC=$0806, type $07)
C $E34C,3 Level cleared: raise the done flag in $5BE5
C $E35A,4 Normal spawn: short delay, random placement
C $E360,3 Get random byte??
C $E36D,3 Common enemy-object init helper
C $E39B,3 Get random byte??
C $E3A0,3 => Check enemy position on-screen, trigger action
C $E3A4,3 Get random byte??
C $E3AB,2 Spawn from the right edge
C $E3B5,2 Spawn from the left edge
C $E3BD,4 Skip unless within the visible column band
C $E3C5,2 Convert column to a row index
C $E3D7,3 Stagger the spawn timer
C $E3E4,3 Grab a free enemy slot
C $E3E8,3 Store its action timer
C $E3EC,7 Off band: retry against the vertical range
C $E425,3 Get random byte??
C $E42C,3 Get random byte??
C $E438,3 Get random byte??
C $E440,3 Common enemy-object init helper
C $E44E,3 Point at the object table
C $E451,3 Stop at the end marker -- no slot free
C $E459,2 Skip records whose active flag is set
C $E462,2 Found a free record; rewind to its start
C $E469,3 Some enemy types get a special flag
C $E484,4 Convert the spawn spot to a map address
C $E48D,3 Entry E=2, dispatch bullet/collision handler via $DF39
C $E494,3 Reject the spawn if it clashes with the player
C $E4A2,4 Give up: reset the spawn timer
C $E4A7,1 Commit the new object into the record
C $E4AC,3 Write its start position
b $E4F2
c $E4FC Set up player object pointers (IX=$5BDA)
N $E4FC Reads the player's position and drives their movement each frame. Under scripted control (entering an area) it injects a synthetic direction to walk the player to a target column, and when captured or dying it runs a death countdown. Otherwise it reads the joystick, maps it through the $E4F1 direction table, and steps the player toward the input.
C $E4FC,4 Player's object record address
C $E508,3 Store the player's X ($FDE3)
C $E50C,3 Store the player's Y ($FDE4)
C $E513,4 In an auto-move state?
C $E528,4 Reached the target column?
C $E530,4 Arrived: clear the auto-move
C $E546,3 Get last joystick/keyboard bits
C $E54C,3 Update last joystick/keyboard bits
C $E552,3 Captured or dying? run the death sequence
C $E559,3 Count down the death timer
C $E57C,4 Player is dead??
C $E582,3 Otherwise inch the body down
C $E586,3 Get last joystick/keyboard bits
C $E592,2 Clamp input to 8 directions
C $E598,3 Look up the target direction
C $E5A1,4 Already facing that way?
C $E5AB,3 Convert direction code (masked 0-15) to E delta
C $E5B1,3 Store the new facing
C $E5B5,3 => Move enemy toward target, clamp to bounds
c $E5B8 Convert direction code (masked 0-15) to E delta (unconfirmed)
N $E5B8 Adjusts coordinate E by a signed step chosen from the low nibble of the direction in A (+1 for 0-4, +3 for 5-7, -4 for 9-11, -1 for 12-15, and +3/-4 for 8 by the sign bit of the full direction in B), giving the X component of a 16-way heading.
R $E5B8 I:A Direction code (low nibble selects the step)
R $E5B8 I:E Coordinate to adjust
R $E5B8 I:B Full direction (bit 7 breaks the tie at A=8)
R $E5B8 O:E Adjusted coordinate
C $E5B8,5 Mask direction to 0-15, check low range
C $E5C3,4 Check mid range, branch
C $E5C9,1 Step -1 (directions 12-15)
C $E5CB,4 Step -4 (directions 9-11)
C $E5D0,3 Step +3 (directions 5-8)
C $E5D3,1 Step +1 (directions 0-4)
C $E5D5,2 Direction 8: pick sign from bit 7
c $E5DB Move enemy toward target, clamp to bounds (unconfirmed)
R $E5DB I:IX Address of the 20-byte object record
C $E5DB,3 Load object position/velocity into HL/E
C $E5E7,3 Pick $E679 or $E648 handler by direction (D)
C $E5F0,3 Move left
C $E5F5,3 Move right
C $E5FE,3 Load target coordinates for bound check
C $E607,3 Clamp/check coordinate H
c $E628 Dispatch by direction, clear draw-active if off-screen (unconfirmed)
C $E628,5 Check column bound, clear active flag
C $E636,3 Check row band, dispatch by direction
C $E643,3 => Move up/down
c $E648 Move right: check keys/state, advance E and wrap
C $E648,6 Check special states $01/$07, test heading bit
C $E660,5 Advance direction counter E, wrap mod 4
C $E65B,4 Check bit 0 (Right) of Last joystick/keyboard bits ($FD85)
c $E679 Move left: check keys/state, advance E and wrap
C $E679,6 Check special states $09/$0F, test heading bit
C $E693,5 Advance direction counter E, wrap mod 4
C $E68C,4 Check bit 1 (Left) of Last joystick/keyboard bits ($FD85)
c $E6A8 Move enemy up one row if states/flags allow
N $E6A8 Moves an enemy up one row when its state and collision flags allow it, then bounds-checks the new row and either clears the draw-active flag or falls through to the movement dispatcher at #R$DC8C.
R $E6A8 I:IX Address of the 20-byte object record
R $E6A8 I:A Enemy state
R $E6A8 I:H Enemy row
C $E6A8,2 States $03/$0D take the gated path
C $E6B6,4 Blocked by wall-solid flag?
C $E6BC,4 Check bit 3 (Up) of Last joystick/keyboard bits ($FD85)
C $E6C2,1 Move up one row
C $E6C4,2 Reject row above top
C $E6C8,2 Reject row below bottom
C $E6D3,4 Clear draw-active flag
C $E6D8,3 => Check IX flag and column bound, dispatch
c $E6DB Move up/down: check states, adjust row (unconfirmed)
C $E6DB,4 Check special states $05/$0B, test heading bit
C $E6E9,4 Advance row, check limit $55
c $E6FE Update boss/enemy state via IX=$5B11 (unconfirmed)
N $E6FE Runs one object from the $5B11 table each frame, checking whether the player's shots have hit it. It works out the object's position, then scans the bullet lists at $F8ED and $F8EA for an overlap. A hit starts the object's death animation and scores 200 points (2000 for a special target), with a sound effect.
C $E6FE,3 Copy a state byte forward
C $E708,4 Point at the object table
C $E70C,4 Skip inactive objects
C $E713,3 Object column into the position
C $E71F,3 Read the object's state
C $E72B,2 On screen?
C $E732,3 Scan the bullet list
C $E739,3 Only certain frames can be hit
C $E74E,3 Look for a collision
N $E753 Killed the object
C $E753,4 Hit: start the death animation
C $E75B,3 +200 for the kill
C $E75E,3 Bigger score for a special target
C $E765,1 change to +2000
C $E766,3 Update Score
C $E770,3 Otherwise scan the second list
C $E778,2 Hit there too? handle the kill
C $E76B,3 Trigger sound effect A into free slot at $6433
c $E77C Scan object table for entry near position (unconfirmed)
N $E77C Walks a list of row/column record pairs and returns the first one within a B-sized box of the target position (D,E), stopping at the $90 end marker; the zero flag is set only when nothing matched.
R $E77C I:HL Record-list pointer (row, column pairs)
R $E77C I:D Target row
R $E77C I:E Target column
R $E77C I:B Search half-size (row/column tolerance)
R $E77C O:HL Pointer into the matched record
R $E77C O:F Zero set if no record matched (end marker)
C $E77D,2 Read record
C $E77F,2 Inactive record marker ($90)
C $E782,3 Check row within range B
C $E788,2 Check column within range B
C $E791,2 Match found: set flags (B nonzero)
c $E794 Enemy melee/contact check vs player, kill if close (unconfirmed)
N $E794 Runs one frame of an enemy soldier. First it tests whether the player has walked into the enemy's small kill-box (unless the enemy is in a non-lethal sub-state or AI state $09) and, if so, flags the player dead (IY+$62 bit 0). It then branches on the enemy's state byte (IX+$0C) to the matching handler -- the movement dispatcher at #R$E972 for active states, or specific routines for the turning, dying and firing states.
R $E794 I:IX Address of the 20-byte object record
R $E794 I:D Enemy row
R $E794 I:E Enemy column
C $E794,6 Check sub-state flag and AI state $09
C $E7A1,6 Compare player row/column against enemy
C $E7B5,2 Player within 6 columns?
C $E7B9,4 Flag player dead
C $E7C1,2 Dispatch by enemy state
C $E7C3,3 => Dispatch enemy AI by state
C $E7CA,3 => Dispatch enemy AI by state
C $E7E4,3 Count down the state timer
C $E7EE,3 Compute direction bits toward player position
C $E83B,3 Check position bounds, set flags
C $E852,3 => Enemy patrol AI
C $E859,3 Compute direction bits toward player position
c $E86B Enemy AI pause: reload short action timer
N $E86B Enemy AI pause state: reloads the action timer (+$11) to $02, or to $04 with sub-state $11 when the object has no queued sprite frame (+$06 = 0), then continues at #R$E9B9.
R $E86B I:IX Address of the 20-byte object record
C $E86D,3 Read queued sprite frame (+$06)
C $E876,4 No frame: force sub-state $11
C $E87B,3 Store pause timer
c $E881 Enemy AI: re-aim at player, random fire
N $E881 Enemy AI state that re-aims toward the player, then on a random chance fires (#R$EC1B) unless in state $09, before reloading the action timer and returning to the mover at #R$E992.
R $E881 I:IX Address of the 20-byte object record
C $E881,3 Compute direction bits toward player position
C $E884,3 Aim heading at player
C $E887,3 Get random byte
C $E896,3 Check enemy position on-screen, trigger action
C $E899,4 Reload action timer $0E
c $E8A0 Enemy wandering AI: timed re-aim, random fire and step
N $E8A0 Runs the enemy's wandering AI on a countdown: while the timer at +$11 ticks it just returns, and when it expires it cycles a phase counter (+$13) that re-aims toward the player, sometimes fires (#R$EC1B), then picks a new random step and reloads the move timer.
R $E8A0 I:IX Address of the 20-byte object record
C $E8A0,3 Count down the move timer
C $E8A6,3 Read phase counter (+$13)
C $E8B4,3 Compute direction bits toward player position
C $E8BE,3 Compute direction bits toward player position
C $E8C4,3 Get random byte
C $E8C7,2 Random chance to fire
C $E8CB,3 Check enemy position on-screen, trigger action
C $E8D7,2 Advance phase counter 0..3
C $E8E0,3 Get random byte
C $E8E3,2 Random step size
C $E904,3 Reload move timer
c $E90A Enemy AI: check row range, transition to attack state (unconfirmed)
N $E90A Enemy approach AI: exits if the row is off-screen, switches to the attack state once the enemy closes within a row band, and otherwise steers toward the player's row ($5BDE) while periodically firing (#R$EC1B).
R $E90A I:IX Address of the 20-byte object record
C $E90A,7 Load target row, check upper bound
C $E911,2 Row off-screen? exit
C $E915,2 Close enough to attack?
C $E919,4 Enter attack state
C $E91D,3 Common enemy-object init helper
C $E93C,1 Compare against player row
C $E954,3 Set heading toward player
C $E957,3 Count down fire timer
C $E95C,4 Reload fire timer
C $E960,3 Get random byte
C $E96C,3 Check enemy position on-screen, trigger action
c $E972 Dispatch enemy AI by state (IX+$12)
N $E972 Dispatches an enemy to its AI state handler: states $06 and $0A go to their own routines, and the rest index a jump table at $E188 by the state byte (+$12) once the action timer (+$11) expires, otherwise just moving the enemy toward its target.
R $E972 I:IX Address of the 20-byte object record
C $E972,7 Special-case states $06 and $0A
C $E97B,3 => Enemy wandering AI
C $E97E,3 Count down the action timer
C $E984,9 Look up state handler, jump to it
C $E992,8 Check for a small set of special states
C $E9AE,3 Use alternate delay field (IX+$13)
C $E9B3,3 Use heading field (IX+$0C)
C $E9B6,3 Move enemy toward target, clamp to bounds
b $E9C7
t $E9E1
b $E9E4
t $EAC4
b $EAC7
c $EB13 Set enemy AI delay/direction by Area number ($FDE5)
N $EB13 Enemy AI state that reloads the action timer by area, then on a coin-flip either re-aims toward the player and maybe fires (with an area-scaled chance via #R$EC1B) or keeps its stored heading, before returning to the mover at #R$E992.
R $EB13 I:IX Address of the 20-byte object record
C $EB15,3 Get Area number
C $EB21,3 Get random byte
C $EB24,2 Coin-flip: re-aim or hold heading
C $EB28,3 Compute direction bits toward player position
C $EB41,3 Set heading
C $EB44,3 Get Area number
C $EB48,2 Fire probability scales with area
C $EB55,3 Get random byte
C $EB58,1 Random chance to fire
C $EB59,3 Check enemy position on-screen, trigger action
C $EB5F,3 Hold stored heading (IX+$13)
c $EB68 Enter enemy AI state $01 with heading $08
N $EB68 Puts an enemy into AI state $01 with heading $08 (current and next) and a $20-tick action timer, then moves via #R$E9B6.
R $EB68 I:IX Address of the 20-byte object record
C $EB68,4 Enter AI state $01
C $EB6E,3 Set heading $08 (current and next)
C $EB74,4 Set action timer $20
c $EB7B Enemy patrol AI: walk N steps then reverse
N $EB7B Enemy patrol AI: advances a step counter (+$0D) and keeps walking until it reaches 5, then reverses the heading (XOR $08), reloads the timer and moves via #R$E9B6.
R $EB7B I:IX Address of the 20-byte object record
C $EB7B,3 Advance step counter
C $EB81,2 Still walking?
C $EB83,3 => Enemy AI pause
C $EB89,2 Reverse heading 180 degrees
C $EB8E,4 Reload timer $40
c $EB96 Enemy AI: wander or chase player by aggressive flag
N $EB96 Enemy AI state that either wanders on a random heading and timer or, when the aggressive flag (+$0B bit 7) is set, homes toward the player and fires (#R$EC1B), counting up (+$0F) until it drops the aggressive flag.
R $EB96 I:IX Address of the 20-byte object record
C $EB96,4 Aggressive flag set? chase
C $EB9C,3 Get random byte
C $EB9F,2 Random heading 0-15
C $EBA2,2 Random timer reload
C $EBB4,3 Compute direction bits toward player position
C $EBB7,3 Aim heading at player
C $EBC0,3 Get random byte
C $EBC9,4 Reload timer
C $EBD7,4 Drop aggressive flag
C $EBDB,3 Check enemy position on-screen, trigger action
c $EBE1 Compute direction bits toward player position (unconfirmed)
N $EBE1 Builds a heading toward the player: compares the player's Y ($5BDF) and X ($5BDE) against the object's position within a small dead-zone, sets the up/down/left/right bits in C, and looks the combined bits up in the $E4F1 table to return a direction code.
R $EBE1 I:IX Address of the 20-byte object record
R $EBE1 O:C Direction bit flags
R $EBE1 O:B Direction code
C $EBE1,6 Player Y and zeroed flag accumulator
C $EBE7,3 Y distance to player
C $EBEC,2 Below dead-zone: set down bit
C $EBF4,2 Above dead-zone: set up bit
C $EBFA,6 Compare X coordinate to object (IX+$04)
C $EC08,2 Player to the right: set bit
C $EC10,2 Player to the left: set bit
C $EC12,5 Look up direction code in $E4F1 table
c $EC1B Check enemy position on-screen, trigger action (unconfirmed)
N $EC1B Fires an enemy shot: looks up the firing position from the table at $EC81 and, if it lands on-screen, spawns a projectile aimed near the player via #R$F200, choosing the projectile sprite base by the current area number ($FDE5).
R $EC1B I:IX Address of the 20-byte object record
C $EC20,3 Look up entry in table at $EC81
C $EC24,2 Reject if off bottom edge
C $EC2D,2 Reject if off right edge
C $EC3F,3 Get Area number
C $EC46,1 Base sprite by area band
C $EC52,3 Scan object table (IX,$0E stride), compute and store motion vector
c $EC58 Set enemy sub-state (IX+$0C) by threshold, reset delay/target
N $EC58 Flips the enemy sub-state (+$0C) between $10 and $17 depending on whether its current value is under $08, then resets its timers and target fields and continues at #R$E9B9.
R $EC58 I:IX Address of the 20-byte object record
C $EC58,5 Compare (IX+$0C) against $08, pick $17/$10
C $EC65,11 Store new sub-state, reset timers to defaults
C $EC70,8 Clear position counters (+$0F/+$0E)
C $EC78,3 Snapshot target row into +$0D
b $EC81
c $ECC1 Check fire button and joystick input
N $ECC1 Handles the player firing: reads the fire button and a charge counter ($FD95) to decide between lobbing a grenade (when held and grenades remain) or firing a bullet, spawning the projectile and playing the shot sound.
C $ECC4,2 Skip while player busy
C $ECC7,4 Check bit 4 (Fire) of Last joystick/keyboard bits ($FD85)
C $ECCF,2 Fire => jump
N $ECE3 Fire button pressed
C $ECFA,3 Get grenades number
C $ECFF,3 Get player's column
C $ED11,3 Select grenade table $F81E
C $ED15,2 -1 more grenades
C $ED17,3 => We've got A more grenades
C $ED1F,3 Player's object record address
C $ED26,3 Look up entry in table at $EC81
C $ED29,3 Scan player-bullet table at $F82D, entry stride 5
C $ED2C,2 Play shot sound $06
C $ED2E,3 => Trigger sound effect A into free slot at $6433
c $ED31 Look up entry in table at $EC81 (unconfirmed)
N $ED31 Computes a projectile's spawn position and size from the player's coordinates (HL) plus a per-direction offset looked up in the $EC81 table (indexed by B), returning the position in HL and the size in BC.
R $ED31 I:HL Player object record
R $ED31 I:B Direction index
R $ED31 O:HL Spawn position
R $ED31 O:BC Projectile size
C $ED31,4 Row index * 4 into E
C $ED3E,4 Column index * 4 into C
C $ED44,3 Add row+column to get table entry offset
C $ED4D,3 Read projectile size (C, B)
c $ED52 Rebuild active-object list at $F900 from $FF00 buffer
N $ED52 Rebuilds the sprite display list at $F900 each frame by walking the $FF00 linked buffer of live objects. For each object it looks up an attribute-table entry by type and writes a scaled position plus draw data into the list. The active Jeep is appended at the end, then the whole list is checksummed.
C $ED5C,4 Align the link pointer to its page
C $ED60,3 Reached the end of the list?
C $ED65,3 Follow the buffer link
C $ED68,3 Read the record type
C $ED6F,3 Turn the type into a table index
C $ED76,3 Scale the Y into the entry
C $ED7C,3 Visible object?
C $ED81,3 Copy the fields into the list
C $ED8E,3 At the end: append the Jeep if active
C $ED99,3 Fill in the Jeep entry
C $EDA8,3 Terminate the list
C $EDAE,3 XOR AF and AF' with every byte in $F900-F9FF
C $EDB9,3 Hidden object: jump to its handler
c $EDC8 Populate object record fields from A/B and a source byte
N $EDC8 Writes into the destination record at DE: frame A at +$01, the source byte from HL+1 at +$02, count B at +$03, and $80 (active flag) at +$04, then restores DE.
R $EDC8 I:DE Destination record pointer
R $EDC8 I:HL Source record pointer
R $EDC8 I:A Value stored at +$01
R $EDC8 I:B Value stored at +$03
C $EDCA,1 Store A at record +$01
C $EDCD,2 Copy source byte into +$02
C $EDD0,1 Store B at +$03
C $EDD2,2 Set +$04 = $80 (active flag)
c $EDD6 Init object timer field via $EDC8 (unconfirmed)
N $EDD6 Seeds the record via #R$EDC8, then counts down a timer field and, when it expires, reloads it with a random $14-$23 and fires a type-dependent spawn action (#R$E3AB / #R$E3B5) before continuing object processing at #R$ED5C.
R $EDD6 I:HL Object record pointer
R $EDD6 I:IY Object base pointer
C $EDD6,5 Read record, set up type $1C, count $2D
C $EDDB,3 Populate object record fields from A/B and a source byte
C $EDDF,6 Check range, branch by type value
C $EDE7,2 Reset timer to $08
C $EDEB,1 Count down timer field
C $EDEE,3 Get random byte
C $EDF1,4 Reload timer with random $14-$23
C $EDF8,4 Raise effect flag (IY+$16)=$AA
C $EE04,3 Fire type-specific spawn action
c $EE11
c $EE15
b $EE24
t $EE35
b $EE38
t $EE64
b $EE67
t $EEBF
b $EEC3
t $EF05
b $EF08
c $EF37 Init object record via $EDC8, entry size $0E
N $EF37 Handles a spawn record while the display list is rebuilt: it initializes the object's fields, walks a slot counter to pace how many appear, then finds a free slot in the $5B11 table and places an enemy at the record's position.
C $EF37,3 Fetch the spawn parameters
C $EF3D,4 Init the record via $EDC8
C $EF41,3 Populate object record fields from A/B and a source byte
C $EF44,4 Any slots left this frame?
C $EF48,3 Exhausted: reset the counter
C $EF4E,2 Step to the next slot
C $EF51,2 Find an unused slot
C $EF5C,3 Bump the spawn counter ($FDE1)
C $EF68,2 Take the spawn position
C $EF6D,3 Find a free enemy slot
C $EF72,4 Spawned OK: tag the record
c $EF7C Init two-part record via $EDC8, check record type (unconfirmed)
N $EF7C Initialises a type-$0B two-part object: seeds both sprite halves via #R$EDC8 (attribute $38, source bytes $00 and $4A) and sets up its movement parameters before drawing.
R $EF7C I:HL Record type pointer
R $EF7C I:DE Destination record
C $EF7C,3 Check record type against $0B
C $EF81,6 Init first part via $EDC8 ($38, byte $00)
C $EF87,3 Populate object record fields from A/B and a source byte
C $EF8B,5 Init second part via $EDC8 ($38, byte $4A)
C $EF90,3 Populate object record fields from A/B and a source byte
b $EFA3
t $EFBB
b $EFBE
t $EFC1
b $EFC5
t $EFD2
b $EFD7
c $EFDD Check active count vs limit, reset counter/state (unconfirmed)
N $EFDD Another spawn handler run during the list rebuild: it counts down a timer and, when it fires, spawns an enemy at a random column with a rate that quickens in later Areas. The new enemy enters from a chosen screen edge and gets a randomized action delay.
C $EFDD,3 Bump the counter, cap at $4B
C $EFE3,4 Below $15? still counting
C $EFE7,3 Initialize the counter fields
C $EFEF,4 Count down; not due yet
C $EFF3,2 Reload the countdown
C $EFF5,3 Randomize the spawn column
C $F003,3 Get Area number
C $F006,3 Scale the rate by Area
C $F00B,4 Not due yet? bail
C $F018,4 Choose the entry edge
C $F041,3 Find a slot and spawn
C $F045,3 Randomize its action timer
C $F045,3 Get random byte??
b $F052
t $F05D
b $F060
t $F064
b $F068
t $F072
b $F075
c $F076 Explosion hit check against the enemy list, +3000 (unconfirmed)
N $F076 Checks whether an explosion overlaps any enemy in the $F8EA list and, on a hit, marks the enemy and scores 3000.
C $F079,3 Centre the blast on the tile
C $F07D,3 Offset the column
C $F081,3 Scan the enemy list for a hit
C $F08A,3 No hit: back to the list
C $F08F,2 Mark the enemy as hit
C $F093,3 +3000
C $F096,3 Update Score
b $F09E
t $F0ED
b $F0F0
t $F0F4
b $F0F9
t $F100
b $F105
c $F114 Shift object table entry, mark boundary $81 (unconfirmed)
C $F114,4 Save old value, mark slot boundary $81
C $F11A,4 Copy entry byte across
c $F126 Shift object table entry, mark boundary bytes $81 (unconfirmed)
C $F126,4 Save old value, mark slot boundary $81
C $F12E,5 Copy entry byte across
C $F135,7 Write second boundary marker, adjust value
c $F14C Spawn enemy from record, check readiness timer (unconfirmed)
C $F14C,4 Read record byte, compare against $06
C $F15A,4 Check slot free, mark used ($FF)
C $F160,8 Load slot address, set spawn marker $80
c $F180 Update enemy state timer, check row threshold (unconfirmed)
C $F180,7 Set delay timer, load column *4 into E
C $F18A,8 Compare row to $34, set state flag $12 if past
C $F1B3,3 Check position bounds, set flags
c $F1BB Check position bounds, set flags (unconfirmed)
C $F1BB,3 Reject if E out of range
C $F1C9,6 Compute spawn params from player position ($5BDF/$FDE3)
C $F1D8,3 => Select secondary projectile/vehicle table $F7C9
b $F1DD
t $F1DE
b $F1E1
c $F200 Scan object table (IX,$0E stride), compute and store motion vector (redirect)
C $F200,3 => Scan object table (IX,$0E stride), compute and store motion vector
c $F203 Set up primary projectile/vehicle table $F73C, process motion (redirect)
C $F203,3 => Set up primary projectile/vehicle table $F73C, process motion
c $F206 Scan explosion-effect table $F856, entry stride $14 (redirect)
C $F206,3 => Scan explosion-effect table $F856, entry stride $14
c $F209 Scan player-bullet table at $F82D, init $F8ED marker (redirect)
C $F209,3 => Scan player-bullet table at $F82D, init $F8ED marker
c $F20C Scan player-bullet table at $F82D, entry stride 5 (redirect)
C $F20C,3 => Scan player-bullet table at $F82D, entry stride 5
c $F20F Select secondary projectile/vehicle table $F7C9 (spawn entry, redirect)
C $F20F,3 => Select secondary projectile/vehicle table $F7C9
c $F212 Set up grenade table $F81E, dispatch (redirect)
C $F212,3 => Set up grenade table $F81E, dispatch
b $F215
c $F21B Select grenade table $F81E (spawn entry, redirect)
C $F21B,3 => Select grenade table $F81E
c $F21E Clamp/check coordinate H (redirect)
C $F21E,3 => Clamp/check coordinate H
c $F221 Clear the projectile/vehicle/explosion tables at $F73C
N $F221 Clears and re-initialises the projectile, vehicle and explosion tables starting at $F73C, one table per call to the record-clearing helpers.
C $F224,3 Point at table $F73C
C $F227,3 Clear/init table records
C $F22A,3 Clear/init table records
C $F22D,3 Clear/init table records
C $F230,3 Clear table records up to an $FF terminator
C $F233,2 Explosion records are $14 bytes
c $F237 Clear/init table records (entry size $0E)
c $F23B Clear table records up to an $FF terminator
N $F23B Clears table records in blocks of B bytes (B=5 at the main entry), repeating for each record until it reaches an $FF terminator byte.
R $F23B I:HL Table start
R $F23B I:B Bytes per record
C $F23E,2 Zero one record byte
C $F244,4 Stop at $FF terminator
c $F24A Scan player-bullet table at $F82D, entry stride 5
N $F24A Finds a free slot (byte +$00 = $00) in the player-bullet table at $F82D and stores the new bullet's position (L,H) and size (C,B), marking it active ($0E).
R $F24A I:L X position
R $F24A I:H Y position
R $F24A I:B Height
R $F24A I:C Width
C $F24A,7 Set up table pointer, stride 5
C $F251,5 Check slot empty ($FF)/active ($00)
C $F259,2 Advance to next slot
C $F25D,9 Store position (L,H), size (C,B), mark active
C $F269,4 Mark slot active ($0E)
c $F26E Scan player-bullet table at $F82D, init $F8ED marker
N $F26E Advances every player bullet in the $F82D table each frame, moving each by its velocity and rebuilding the $F8ED marker list. A bullet that leaves the screen, hits a wall or times out is removed and turned into an explosion. A bullet that strikes a target registers the hit, scoring 1000 with a sound.
C $F26E,4 Point at the bullet table
C $F272,3 Reset the marker list
C $F27A,3 End of the table? done
C $F27F,3 Skip inactive slots
C $F282,3 Advance to the next slot
C $F289,3 Load the bullet position
C $F292,4 Advance X by the speed
C $F29A,4 Off the side? explode
C $F29E,4 Advance Y
C $F2AD,2 Past the top edge?
C $F2B7,3 Count down the bullet's life
C $F2C1,3 Append to the marker list
C $F2CA,4 Test against the target box
C $F314,3 Find free enemy slot in $5B11 table, inside $E01B
C $F323,3 Trigger sound effect A into free slot at $6433
C $F326,3 +1000
C $F32F,2 Redraw the bullet
C $F33D,4 Off screen: kill the bullet
C $F349,3 Make an explosion
C $F329,3 Update Score
C $F331,3 Entry E=0, dispatch bullet/collision handler via $DF39
C $F349,3 Scan explosion-effect table $F856, find/init free entry
c $F34F Clamp/check coordinate H (unconfirmed)
R $F34F I:H Coordinate to clamp
R $F34F I:DE Value to add after clamping
R $F34F O:H Clamped coordinate
R $F34F O:Cy Set if coordinate was out of range
C $F34F,5 Add $02, check sign, set carry if negative
C $F35E,8 Rotate H:L right 3 bits, add DE
c $F36D Set up grenade table $F81E, dispatch
C $F36D,3 Set up secondary projectile/vehicle table $F7C9, dispatch
c $F37B Set up secondary projectile/vehicle table $F7C9, dispatch (unconfirmed)
c $F381 Set up primary projectile/vehicle table $F73C, process motion (unconfirmed)
C $F385,4 Check slot empty/free, exit if end marker
C $F38A,4 Stop this slot once its type byte hits zero
C $F38E,3 Read the current position
C $F399,4 Erase the old sprite
C $F3DD,3 Clear the step accumulator
C $F3E9,2 Advance along the major axis
C $F3F6,3 Store the stepped position
C $F404,5 Apply direction and base row
C $F40D,4 Off the bottom of the screen?
C $F411,3 Out of bounds: retire the projectile
C $F43E,4 Redraw at the new spot
C $F39F,3 Decompose position into sub-pixel fields ($F8CF-$F8D1)
C $F3A4,3 Generate rotated bit-mask pattern A, variant
C $F3BB,3 Clamp/check coordinate H
C $F446,3 Set explosion/effect buffer values from object IX
C $F453,3 Generate rotated bit-mask pattern A
C $F46C,4 Player is dead??
C $F4BC,3 Set explosion/effect buffer values from object IX
C $F4CA,3 Find free slot in $6648 table
C $F4CF,3 Trigger sound effect A into free slot at $6433
C $F4D4,3 Scan explosion-effect table $F856, find/init free entry
c $F4E3 Select grenade table $F81E (spawn entry)
c $F4E9 Select secondary projectile/vehicle table $F7C9 (spawn entry)
c $F4F6 Scan object table (IX,$0E stride), compute and store motion vector
C $F4FA,4 Scale the target coordinates
C $F502,4 Check slot empty (byte = $FF)
C $F507,5 Advance to next slot, retry
C $F50E,4 Start building the direction flag byte
C $F516,1 Horizontal distance to target
C $F525,1 Vertical distance to target
C $F52F,1 Pick the larger axis as the step base
C $F536,3 Store direction flags to (IX+$00)
C $F539,6 Store speed to (IX+$01)
C $F53F,9 Store target coordinates (IX+$02..$05)
c $F582 Generate rotated bit-mask pattern A (unconfirmed)
N $F582 Draws a small 2-bit mark: builds a $C0 mask rotated by the column's low 2 bits and ORs it into two vertically adjacent screen bytes at the DE row/column.
R $F582 I:DE Row/column position
C $F582,3 Check row/column bounds
C $F589,3 Convert row number to screen line address
C $F58D,3 Rotate count = column low 2 bits
C $F594,4 Rotate $C0 mask into position
C $F599,2 OR mask into this screen byte
C $F59C,3 OR mask into next char row
c $F5A0 Generate rotated bit-mask pattern A, variant (unconfirmed)
N $F5A0 Punches a small hole in the display: builds a $3F mask rotated by the column's low 2 bits and ANDs it into two vertically adjacent screen bytes at the DE row/column.
R $F5A0 I:DE Row/column position
C $F5A0,3 Check row/column bounds
C $F5A7,3 Convert row number to screen line address
C $F5AB,3 Rotate count = column low 2 bits
C $F5B3,4 Rotate $3F mask into position
C $F5B8,2 AND mask into this screen byte
C $F5BC,2 AND mask into next char row
c $F5BF
C $F5C1,3 Generate rotated bit-mask pattern A, variant
c $F5C6
C $F5C8,3 Generate rotated bit-mask pattern A
c $F5CD Check row/column bounds (used by $F582/$F5A0)
N $F5CD Bounds-checks the effect's row (D) against the visible vertical window derived from the scroll offset $FD97, returning carry set when the position should be drawn.
R $F5CD I:D Row
R $F5CD O:F Carry set if within the window (draw)
C $F5D0,2 Above top of window? reject
C $F5D3,1 Past the row? reject
C $F5D5,2 Within window height?
c $F5DD Set explosion/effect buffer values from object IX (unconfirmed)
C $F5DE,3 Row plus the object's height
C $F5E8,4 Flag whether it's a big explosion
C $F5F3,3 Sub-column bits
C $F5FE,3 Byte-column index
C $F603,3 Pick the effect's base frame
C $F608,4 Direction selects the animation set
C $F624,3 Save the chosen effect frame
C $F627,4 Point at the effect work-record
C $F62B,4 Set the sprite dimensions
C $F637,4 Distance out from the centre
C $F640,4 Step outward and draw a ring frame
C $F64D,3 Update object IX position, clip to screen, dispatch sprite draw
C $F66E,3 Update object IX position, clip to screen, dispatch sprite draw
C $F684,3 Update object IX position, clip to screen, dispatch sprite draw
c $F68A Decompose position into sub-pixel fields ($F8CF-$F8D1) (unconfirmed)
C $F68A,6 Compute column byte ($F8D0)
C $F693,6 Compute sub-column bits ($F8D1)
C $F699,8 Compute row/8 index ($F8CF)
c $F6C2 Scan explosion-effect table $F856, find/init free entry (unconfirmed)
N $F6C2 Finds a free slot (delay field +$11 = 0) in explosion table $F856 and seeds a new record from the DE spawn position before falling into the mask-pattern generator at #R$F5A0.
R $F6C2 I:DE Spawn position (E pixel X, D Y)
C $F6C2,4 Load table pointer, check end marker
C $F6C9,8 Check delay field (+$11) for a free (zero) slot
C $F6D7,10 Free slot found: rewind to record start
C $F6E7,2 Derive char X from pixel position
C $F6EA,1 Write current sprite fields (X, Y, quadrant, frame $17)
C $F6F6,1 Duplicate into next-frame fields
C $F701,2 Seed +$0B field = $0A
C $F704,3 => Generate rotated bit-mask pattern A, variant
c $F707 Scan explosion-effect table $F856, entry stride $14 (unconfirmed)
N $F707 Ticks each active explosion in table $F856: decrements its timer at +$11 and writes the matching animation-frame number to +$07, dropping to the next record once the timer expires and stopping at the $FF end marker.
C $F70E,2 Stop at end-of-table marker
C $F713,3 Skip record with expired timer
C $F71D,4 Decrement animation timer, store back
C $F723,2 Final frame when timer expires
C $F72E,4 Select frame by animation phase
C $F734,3 Store frame into record +$07
C $F716,3 Record width = 20
C $F737,3 Check screen brightness threshold, inside $DD8D
b $F73C Primary projectile/vehicle table (unconfirmed)
B $F73C,,14 Record width 14
B $F7C8,1 End marker
b $F7C9 Secondary projectile/vehicle table (unconfirmed)
B $F7C9,,14 Record width 14
B $F81D,1 End marker
b $F81E Grenade table
B $F81E,,14 Record width 14
B $F82C,1 End marker
b $F82D Player-bullet table
B $F82D,,5 Record width 5
B $F855,1 End marker
b $F856 Explosion-effect table (unconfirmed)
B $F856,,10 Record width 20
B $F8EA,3
B $F8ED,,8
B $F8CE End marker
b $F8CF
b $F900 Buffer
b $FA00 Checksums??
b $FB00
b $FC06 Buffer for at least 144 bytes
c $FCFC Game main loop / frame handler (redirect)
C $FCFC,3 => Game main loop / frame handler
b $FCFF Stack, grows to lower addresses from $FD80
W $FD00,,8
b $FD80 (IY+xx) variables; IY=$FD80
W $FD80,2 ?? see $7A11
W $FD82,2 Saved SP
B $FD84,1 (IY+$04) - Joystick type: 1=KEMPSTON 2=INTERFACE II 3=FULLER 4=CURSOR
B $FD85,1 (IY+$05) - Last bits from input (joystick/keyboard) in game mode = $00;
.         bit0=Right, bit1=Left, bit2=Down, bit3=Up, bit4=Fire, bit5=??, bit6=??, bit7=??
B $FD86,1 Land space size remaining = $00
B $FD87,1 (IY+$07) - ?? = $00
B $FD88,1 (IY+$08) -  Offset in $FF00 buffer = $00
W $FD8A,2 Current address in level sequence, starts from $9236
W $FD8D,2 Saved SP
W $FD8F,2
c $FD91 Delay by BC-1 HALTs (redirect)
b $FD94 (IY+xx) variables continued
B $FD95,1 (IY+$15) - ??
B $FD96,1 (IY+$16) - ?? = $88,$AA
B $FD97,1 (IY+$17) - ?? = $90,$FF
B $FD98,1 Last key read from keyboard
W $FD99,2 ??
B $FD9B,4 (IY+$1B),(IY+$1C),(IY+$1D),(IY+$1E) - Stored values for random byte calculation
B $FD9F,1 Fill char for special-char codes $0C/$13/$0D/$09
B $FDA0,1 Print attribute: bits 0-2 INK (set by char $10), bits 3-5 PAPER (char $11), bit 6 (char $12) = $07
W $FDA1,2 ?? = $5800; hi byte accessed as (IY+$22)
W $FDA3,2 Font address = $7EA0
W $FDA5,2 ??? = $0000
B $FDA7,1 Special-char argument counter (0 = idle, N = N arg bytes still expected), see #R$7637 = $00
B $FDA8,1 Saved special char in $7637
W $FDA9,2 Special-char argument write pointer, see #R$7637 = $FDAB
B $FDAB,1 Screen attribute??
B $FDAC,1 ??
B $FDAF,1 Print flag byte: bit 0 (char $19), bit 1 (char $15) = $00
B $FDB0,1 Width/column counter, set by char $18 = $00
B $FDB1,1 Print spacing/mode, set by char $02, range 0-3 = $01
B $FDB2,1 (IY+$32) - ??
W $FDB3,2 ??
B $FDB6,1 (IY+$36) - ?? = $00,$FF
B $FDB7,1 (IY+$37) - ?? = $00,$FF
B $FDB8,1 (IY+$38) - ?? = $01,$02
B $FDB9,1 ??
B $FDBA,1 ??
B $FDBC,1 ?? = $40
B $FDC2,1 (IY+$42) - ?? = $02
B $FDC3,1 ?? = $FF
B $FDC4,1 (IY+$44) - ??
B $FDC5,1 ?? = $FF
B $FDC6,1 (IY+$46) - ??
B $FDC7,1 Motorbike?? = $FF
B $FDC9,1 ?? = $FF
B $FDCB,1 (IY+$4B) - Jeep?? = $FF
B $FDCF,1 ??
B $FDD3,1 ??
B $FDD4,1 (IY+$54) - ??
B $FDD5,1 (IY+$55) - ??
B $FDDA,1 (IY+$5A) - ?? = $00; bit1, bit4
B $FDDB,1 (IY+$5B) - ?? = $03; bit0; dec
B $FDDD,1 (IY+$5D) - Enemy delay = $01,$08,$0A,$28; dec/srl
B $FDDE,1 (IY+$5E) - ??, = $90
B $FDDF,1 (IY+$5F) - ??, = $90
B $FDE0,1 ?? = $00
B $FDE1,1 (IY+$61) - ??; bit0; inc
B $FDE2,1 (IY+$62) - bit0=1 - Player is dead
B $FDE3,1 (IY+$63) - ??
B $FDE4,1 (IY+$64) - ??
B $FDE5,1 (IY+$65) - Area number = $01; inc
B $FDE6,1 (IY+$66) - Lives player have
B $FDE7,1 (IY+$67) - Grenades player have
B $FDE8,1 Score, 1st char = '0'
B $FDE9,1 (IY+$69) - Score, 2nd char = '0'
B $FDEE,1 (IY+$6E) - ??
B $FDF0,1 (IY+$70) - ?? = $88
B $FDF1,1 (IY+$71) - ??
B $FDF7,1 Border color
B $FDFA,1 (IY+$7A) - ?? = $00,$04
B $FDFB,1 ?? = $00
B $FDFC,1 (IY+$7C) - ?? = $00
B $FDFD,1 (IY+$7D) - ??
B $FDFE,1 ??
w $FE00 Table addresses for every even screen line
W $FE00,,16
b $FF00 Buffer
B $FF00,,16
