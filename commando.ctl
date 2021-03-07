@ $5B00 org
b $5B00
b $5B11 Object records, 20 bytes wide
B $5B11,,10
b $5BD9
B $5BD9,1 ?? = $90
N $5BDA Player's object record
B $5BDA,1 Starting column = $10
B $5BDB,1 Pixels down screen start point = $40
B $5BDC,1 ?? = $02
B $5BDE,1 ??
B $5BDF,1 ??
B $5BE4,1 ?? = $0A
B $5BE5,1 ?? = $30
B $5BE6,1 ??
B $5BEB,1 ??
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
c $6400 -> $7A10
C $6403,3 Delay by BC
c $6415 -> $6825 - Update Score
b $6418
c $6424 -> $7511 - XOR AF and AF' with every byte in $F900-F9FF
c $6427 -> $6593
c $642A -> $6600
c $642D -> $6456
c $6430 -> $6C7A - We've got A more grenades
b $6433
B $6433,7
W $6448,14
c $6456
C $6458,2 Clear 7 bytes at $6433
c $6469 Clear 7 bytes at $6433
c $6474
c $6495
t $64AB
b $64B0
t $64BF
b $64C2
t $64C3
b $64C6
c $64C7
c $64E9
c $64F9
c $6505
t $650F
b $6513
c $6533
b $6550
c $6575
c $6593
c $65A5
C $65EF,3 -> $806B
c $65F6
c $6600
c $6626 Prepare records and variables at $6648
C $663A,13 Prepare records at $6648
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
c $676B
c $679D
t $67CE
B $681A
b $681B
W $681B,2 Address of current char in scrolling string
c $6825 Update Score
R $6825 I:BC ??
C $6825,3 Get Score 2nd char
C $6854,2 Font 2nd char address, lo byte
C $6857,2 Font address, hi byte
C $6877,3 Address of variable - Lives player have
C $687A,1 plus one live
C $687B,1 Get Lives player have
C $6880,3 Print immediate string
B $6883,12
C $6890,2 number 0..9 -> char '0'..'9'
C $6892,3 Print char
c $6896
c $68A6
R $68A6 I:HL ??
c $68CA
C $68DB,3 Address on the screen
c $6950
c $6975
c $699A
c $69B4
b $69D2
c $69F3 Top Score and Main Menu??
C $69F3,3 Print Score Table
C $69F9,3 Clear 7 bytes at $6433
C $69FF,3 Set up scrolling string
C $6A05,3 Check menu keys
C $6A0A,3 Check menu keys
C $6A14,2 'S' - Start game
C $6A19,2 'J' - Joystick
C $6A1B,3 => Select joystick type
c $6A1E Redefine Keys
C $6A1E,3 Print immediate string
B $6A21,13
T $6A2E,13
B $6A3B,10
C $6A45,3 Where to store redefined keys
C $6A4F,2 6 keys to redefine
C $6A51,3 Start address for messages to use in Redefine Keys
C $6A55,3 Print string HL
C $6A59,3 (HL) -> HL
C $6A5D,3 Wait key unpress, wait key press
C $6A72,3 Print key entered on Redefine Keys
C $6A75,3 Print immediate string
B $6A78,4
C $6A82,4 Set joystick type ($FD84) = Keyboard
C $6A86,3 Set up scrolling string
c $6A8C
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
c $6AE1
c $6B14 Wait key unpress, wait key press
C $6B14,3 Get last key read from keyboard
C $6B1A,3 Get last key read from keyboard
c $6B21
c $6B4C
t $6B67 Letters to select from entering Top Score
T $6B67,,8
c $6B87
R $6B87 I:A ??
c $6BAC
C $6BAF,3 -> $9193
c $6BBB Start Game
C $6BBB,3 Prepare new game
C $6BBE,3 Prepare at new Area
C $6BC7,3 -> $91AA
C $6BCB,3 Clear 7 bytes at $6433
C $6BCE,3 -> $DCDF - Initialization and go to game main loop
C $6BD1,3 Clear 7 bytes at $6433
C $6BDA,3 Get last joystick/keyboard bits
C $6BE0,4 Is Player alive??
C $6BE4,2 => Successful end of the Area
N $6BE6 Player is dead
C $6BE9,1 Get player's grenades number
C $6BEE,2 Set player's grenades number to max allowed
C $6BF0,3 Update grenades number on the screen
C $6BF3,3 Print immediate string
B $6BF6,4
C $6BFA,3 Get lives player have
C $6C04,3 Minus one live
C $6C01,3 => Print Char
C $6C07,3 => Game Over
N $6C1D Black screen at the end of an Area
C $6C22,3 Print immediate string
B $6C25,7
T $6C2C,13
B $6C38,1
C $6C39,3 Print Area number
C $6C3C,3 increase Area number
C $6C3F,3 Print immediate string
B $6C42,3
T $6C45,19
B $6C57,1
C $6C58,3 Print Area number
C $6C5B,3 +2000
C $6C5E,3 Update Score
C $6C64,3 Delay by BC
C $6C67,3 Print immediate string
B $6C6A,4
C $6C6E,3 Print Area number
C $6C71,3 Print immediate string
B $6C74,3
c $6C7A We've got A more grenades
C $6C7D,3 Update player's grenades number
c $6C80 Update grenades number on the screen
C $6C80,3 Print immediate string
B $6C83,14
C $6C91,3 Get player's grenades number
C $6C94,2 Print 2-digit number
c $6C96 Print Area number
C $6C96,3 Get Area number
c $6C99 Print 2-digit number A
C $6C9D,2 minus 10
N $6CB5 Enter name for the new Top Score record
C $6CA3,3 Print char
C $6CA9,3 Print char
c $6CAE Game Over
C $6CAE,3 Find a place in Top Score table
C $6CB2,3 => Top Score and Main Menu
C $6CC6,3 Print immediate string
B $6CC9,6
C $6CCF,3 Letters to select from entering Top Score
C $6CD2,2 4 rows
C $6CD4,2 8 columns
C $6CD8,3 Print char
C $6CDD,3 Print char
C $6CE2,3 Print immediate string
B $6CE5,4
C $6CEC,3 Print immediate string
B $6CEF,9
T $6CF8,15
B $6D07,7
C $6D3E,3 Copy 64 bytes $66D1 to $6711
C $6D4D,3 Get last key read from keyboard
C $6D53,3 Get last joystick/keyboard bits
C $6D5A,3 Print immediate string
B $6D5D,9
C $6D71,4 Check bit 4 (Fire) of Last joystick/keyboard bits ($FD85)
C $6D9E,3 Get last joystick/keyboard bits
C $6DCC,3 Get last joystick/keyboard bits
b $6E08
c $6E11
c $6E34
C $6E38,3 Print char
C $6E48,3 Print char
C $6E55,3 Print char
C $6E6E,3 Print char
C $6E72,3 Print char
C $6E76,3 Print char
c $6E7B
C $6EB4,3 Letters to select from entering Top Score
C $6EB7,3 HL = HL + A
c $6ECD
C $6ECE,3 Print immediate string
B $6ED1,4
C $6EDD,3 Print char
C $6EE6,3 Print char
C $6F07,3 Score table address
C $6F0E,3 HL = HL + A
C $6F1A,3 => Print Char
c $6F1D
c $6F46 Prepare records at $6FE5
c $6F52
c $6F79
c $6FC7 Prepare records at $6FD9
b $6FD9
B $6FD9,12,3
b $6FE5
c $6FF5
C $701A,3 HL = HL + A
C $7032,3 => Copy 64 bytes $66D1 to $6711
c $706E
b $709A
c $70BD
c $70EC Copy 64 bytes $66D1 to $6711
c $70F8 Find a place in Top Score table
C $70F8,3 Score address
C $7123,3 Top score #10 last char address
C $7126,3 Top score #11 last char address
C $7129,3 Top score line width = 15
c $7143 Select joystick type
C $7143,3 Print immediate string
B $7146,13
T $7153,6
B $7159,7
T $7160,10
B $716A,3
T $716D,14
B $717B,3
T $717E,8
B $7186,3
T $7189,8
B $7191,1
C $7192,3 Wait key unpress, wait key press
C $7195,2 < '1' ?
C $7199,2 >= '5' ?
C $719D,2 char '1'..'4' -> number 1..4
C $71A2,3 Set up scrolling string
c $71A8 Print string HL
C $71AD,3 Print char
b $71B2 Screen attributes, 4 bytes
c $71B6
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
C $725E,3 Check menu keys
C $726A,3 Print char
c $7274 Print Score Table
C $7277,3 Print immediate string
B $727A,6
C $728D,3 Print immediate string
B $7290,8
C $7298,3 Score table address
C $729B,2 11 = score table lines count
C $72A0,3 Print char
C $72A8,3 Print char
C $72AB,3 Print char
t $72B2 Score table
T $72B2,,15
c $7357
C $7374,3 Read input: joystick or keyboard
C $7377,3 Save the input
C $7391,3 !!! Modifying argument: $6975 / $68CA
C $73A1,3 -> $7A5D - Delay by BC-1 HALTs
C $73A4,3 Read Keyboard
C $73A7,3 Save last key read from keyboard
c $73B7 Read Keyboard
N $73DD Keyboard map
T $73DD,40,5
c $7405
C $74FA,2 see $FA00
C $7506,3 XOR AF and AF' with every byte in $F900-F9FF
c $7511 XOR AF and AF' with every byte in $F900-F9FF
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
C $754D,3 => Read keysboard
C $7554,3 -> $98EA - HL = HL + A
C $7557,3 -> $98F0 - (HL) -> HL
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
c $75BE
R $75BE I:HL ??
R $75BE I:BC ??
c $75D2 Print key entered on Redefine Keys
R $75D2 I:A Key entered - character or special code
C $75DE,3 => Print Char
C $75E1,3 Print immediate string
B $75E4,3
T $75E7,6
B $75ED,1
C $75EF,3 Print immediate string
B $75F2,3
T $75F5,4
B $75F9,1
C $75FB,3 Print immediate string
B $75FE,3
T $7601,5
B $7606,1
C $7608,3 Print immediate string
B $760B,3
T $760E,5
B $7613,1
c $7615 Print immediate string
C $761C,3 Print char
c $7621
c $7637 Print Char
R $7637 I:A Character to print
C $7657,2 $00..$1F ?
C $7659,3 no => jump
N $765C Process a special char $00..$1F
C $7662,3 HL = HL + A
C $7665,1 A = $00..$02
C $767C,3 HL = HL + A
C $767F,3 (HL) -> HL
C $76B2,3 Delay by BC
N $7687 Print usual char >= $20
C $76BC,4 Get Font address
C $7754,3 HL = HL + A
C $7757,3 (HL) -> HL
b $775F
W $775F,8
c $7767
c $777A
C $777C,3 Get attribute byte
C $7782,3 Fill all screen attributes with D
C $76BB,1 HL = HL * 8
C $778B,3 Clear all the screen bits
C $778F,3 Fill all screen attributes with D
c $7795 Fill all screen attributes with D
c $77A4
c $77AC
c $77B8
c $77C2
c $77CB
c $77D5
c $77EB
c $77FD
c $7811
c $7828
c $783E
C $7842,3 Print char
c $784A
c $7852
c $7866
c $786E
B $7878,4
c $787F
c $7887
c $7896
C $78B0,3 Font address
C $78B3,3 Set Font address
c $78BF -> $7A10
b $78C2
c $78C4
c $78C7
b $78CC Table to map special char $00..$1F to types $00..$02
w $78EC Address map to print chars $00..$1F - 32 addresses
c $792C Prepare at new Area
C $7953,4 Clear Player's dead flag
C $792D,3 Clear last joystick/keyboard bits
C $7930,3 Clear Land space size
C $7933,3 Clear Offset in $FF00 buffer
C $795E,3 Prepare records and variables at $6648
c $796A Prepare New Game
C $7978,10 Score = "000000"
C $7975,3 Area number = $01
C $7982,5 Player's lives = $05
C $7988,3 Set grenades number = $06
C $798F,3 Print immediate string
B $7992,16
T $79A2,32
B $79C2,1
c $79CA
C $79D2,3 Prepare $FE00 table - addresses for every even screen line
C $79D5,3 Calculate checksums??
C $79D8,4 Clear byte ($FD87)
C $79DC,4 Set byte ($FDC2) = $02
c $79E1
c $79FB Calculate checksums??
c $7A10
c $7A1E
c $7A42 -> $7357
c $7A45 Prepare $FE00 table - addresses for every even screen line
C $7A52,3 -> $9904 - DOWN HL
C $7A55,3 -> $9904 - DOWN HL
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
D $7EA0 #HTML[#UDGARRAY16;$7EA0-$7F1F-8(font0.png)]
. #HTML[#UDGARRAY28;$7F20-$7FFF-8(font1.png)]
b $8000
c $8003 -> $9193
c $8006 -> $91AA
b $8009
c $800C -> $8E92
c $800F -> $806B
b $8012
c $806B
c $80E4
c $80EA
c $80FB
c $8101
c $8122
b $8158
t $8160
b $8163
t $81B7
b $81BA
t $81E7
b $81EA
t $820A
b $820D
c $822B
b $82B4 Data 13 bytes to copy at $FDCF
c $82C1
c $82E1
b $8301
c $834B Draw sprite HL
R $834B I:A
R $834B I:B Sprite height??
R $834B I:HL Sprite address
b $83A4
c $83B8 ?? Smth about Jeep
C $842B,3 Get sprite addr Jeep; width 4
c $8458
c $8471 ?? Smth about Motorbike
C $847D,3 ?? Smth with Motorbike sprite
c $8497
c $8500 ?? Smth with Motorbike sprite
C $8511,3 Get sprite addr Motorbike
c $854A
b $8594
c $85AB ?? Smth about Truck
C $85C4,3 Get Truck sprite to $6300 buffer and shift it if needed
c $8618
c $867C
C $86B0,2 $FE00 - table of even screen lines addresses
c $86B8 Get Truck sprite to $6300 buffer and shift it if needed
C $86BC,3 Get sprite addr Truck; width 8
N $86C7 Shift 8*32 bytes at $6300 one bit left
C $86CB,3 Buffer address
C $86D1,2 Loop counter = 32
c $86F5
c $872F
C $8743,3 Get attributes address for screen line D
c $876E Draw walls??
C $8797,4 Get Sprite addr Wall; width 4
C $87A2,2 $FE00 - table of even screen lines addresses
C $87A9,2 Height = 25
C $87AB,3 Get Sprite addr Wall; width 4
c $87F1
C $8805,3 Get attributes address for screen line D
C $8808,2 Attribute byte
C $8811,16 Fill attribute line
C $8823,3 Get attributes address for screen line D
C $8826,2 Attribute byte
C $882F,16 Fill attribute line
C $8844,2 Attribute byte
C $8847,16 Fill attribute line
C $8881,3 HL = HL + A; now HL = address in table $88E5
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
c $8914
c $896D Get attributes address for the screen line
R $896D I:D Screen line number, divided by 2
R $896D O:HL Address in the screen attribute area for the given line
C $896F,2 $FE00 - table of even screen lines addresses
C $8973,5 Get screen line address to HL
C $8978,3 Rotate H right on 3 bits
C $897D,1 Now HL = address in the screen attribute area for the given line
b $897F
c $899E
c $89F3
c $8A03
c $8A14
c $8A7B
c $8AC3
b $8B4B
t $8B9F
b $8BA2
t $8BD7
b $8BDA
t $8C42
b $8C45
t $8CB9
b $8CBC
c $8CC9
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
c $8E92
R $8E92 I:H ??
R $8E92 I:E ??
c $8EB5
b $8ECC
c $8EE3
C $8EFC,3 -> $6C7A - We've got A more grenades
C $8F0A,3 +1000
C $8F0D,3 -> $6825 - Update Score
C $8F12,3 -> $6456
c $8F17
c $8F26
c $8F35
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
c $9014
c $903E
c $904D
C $9054,3 Get sprite addr Cliff edge left
C $9058,3 Get sprite addr ???
C $9070,3 Get sprite addr Cliff edge right
c $90A1
R $90A1 I:B ??
R $90A1 I:C ??
R $90A1 I:A ??
R $90A1 I:DE ??
c $90AC
C $90B8,3 Get sprite addr Cliff top right; width 6
C $90BC,3 Get sprite addr Cliff bottom right; width 6
C $90C1,3 Get sprite addr Cliff top left; width 6
C $90C5,3 Get sprite addr Cliff bottom left; width 6
C $90C8,2 Sprite height = 20
C $90CD,3 Draw sprite HL
C $90D2,2 Sprite height = 12
C $90DD,3 Draw sprite HL
C $90F7,3 HL = HL + A
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
C $9162,3 -> $7A10
C $9165,2 Spawn Point/Level End ?
C $9167,2 no => jump
C $9169,1 Level End ?
C $916A,2 no => jump
C $9171,3 Process codes $01-28, not $22
C $9174,2 => process next record in the sequence
b $9176
c $917C
C $917C,3 Get Offset in $FF00 buffer
C $918C,3 Get Offset in $FF00 buffer
c $9193
C $91AD,3 ?? Smth about Truck
C $91B0,3 ?? Smth about Motorbike
C $91B3,3 ?? Smth about Jeep
C $91B6,3 Get Offset in $FF00 buffer
C $919C,3 Decrement Land space or process next record in the sequence
C $91E0,3 -> $7A10
c $91E3
C $91E6,3 Get Offset in $FF00 buffer
C $91F8,3 Update Offset in $FF00 buffer
C $91FD,3 Get Offset in $FF00 buffer
c $9204 Process record codes $01-28, not $22
C $9207,3 Get Offset in $FF00 buffer
C $920D,3 Update Offset in $FF00 buffer
c $921F
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
c $98D0 -> $9922
c $98D3 -> $98EA - HL = HL + A
c $98D6 -> $98F0 - (HL) -> HL
c $98D9 -> $98F5
c $98DC -> $9904 - DOWN HL
c $98DF
b $98E2 Offsets in $A000 sprites block, lo byte
c $98EA HL = HL + A
c $98F0 (HL) -> HL
c $98F5
C $98FD,2 $FE00 - table of even screen lines addresses
c $9904 DOWN HL - move HL to the next screen line
b $9913
c $9922
C $9962,2 lo byte of $98E2
C $99C0,2 $FE00 - table of even screen lines addresses
c $9A46
c $9A6E
c $9AE6
c $9B05
c $9B61
c $9B97
c $9BCB
c $9BF5
c $9C23
C $9C2D,2 $FE00 - table of even screen lines addresses
C $9C5F,2 $FE00 - table of even screen lines addresses
c $9C6B
c $9CB1
c $9CED
c $9D1F
c $9D5B
c $9D8D
c $9DCC
c $9E03
c $9E32
c $9E69
c $9E98
c $9EDF
c $9F1D
C $9F40,2 $FE00 - table of even screen lines addresses
C $9FA3,2 $FE00 - table of even screen lines addresses
c $9FDE
c $9FF5
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
B $BC00,64,16 #HTML[<img src="images/spriteBC00.png" />]
B $BC40,64,16 #HTML[<img src="images/spriteBC40.png" />]
B $BC80,64,16 #HTML[<img src="images/spriteBC80.png" />]
B $BCC0,64,16 #HTML[<img src="images/spriteBCC0.png" />]
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
B $C0F0,,12 #HTML[#UDGARRAY6,,,6;$C0F0-$C1DF-1-48(cliffbotlt)]
b $C1E0 Sprite Cliff top left; width 6
B $C1E0,,12 #HTML[#UDGARRAY6,,,6;$C1E0-$C26F-1-48(clifftoplt)]
b $C270 Sprite ???; width 2
b $C2C4 Sprite ???; width 2
b $C318 Sprite Cliff edge left; width 2
B $C318,,8 #HTML[#UDGARRAY2,,,2;$C318-$C34F-1-16(clifflt)]
b $C350 Sprite Cliff edge right; width 2
B $C350,,8 #HTML[#UDGARRAY2,,,2;$C350-$C387-1-16(cliffrt)]
b $C388 Sprite Cliff bottom right; width 6
B $C388,,12 #HTML[#UDGARRAY6,,,6;$C388-$C477-1-48(cliffbotrt)]
b $C478 Sprite Cliff top right; width 6
B $C478,,12 #HTML[#UDGARRAY6,,,6;$C478-$C507-1-48(clifftoprt)]
b $C508 Sprite Cave, exit to the right; width 6
B $C508,,12 #HTML[#UDGARRAY6,,,6;$C508-$C5F7-1-48(cavert)]
b $C5F8 Sprite Cave, exit to the left; width 6
B $C5F8,,12 #HTML[#UDGARRAY6,,,6;$C5F8-$C6E7-1-48(cavelt)]
b $C6E8 Sprite Cave top edge; width 6
B $C6E8,,12 #HTML[#UDGARRAY6,,,6;$C6E8-$C717-1-48(cavetop)]
b $C718 Sprite Cave bottom edge; width 6
B $C718,,12 #HTML[#UDGARRAY6,,,6;$C718-$C747-1-48(cavebot)]
b $C748 Sprite Truck; width 8
b $C848 Sprite ???; width 2?
b $C890 Sprite Hut; width 6
B $C890,,12 #HTML[#UDGARRAY6,,,6;$C890-$C97F-1-48(hut)]
b $C980 Sprite Jeep; width 4
B $C980,,8 #HTML[#UDGARRAY4,,,4;$C980-$C9FF-1-32(jeep)]
b $CA00 Sprite Motorbike; width 6
B $CA00,,12 #HTML[#UDGARRAY6,,,6;$CA00-$CA8F-1-48(motorbike)]
b $CA90 Sprite ???; width ?
b $CAC0 Sprite ???; width ?
b $CB20 Sprite ???; width ?
b $CB50 Sprite Wall; width 4
B $CB50,,8 #HTML[#UDGARRAY4,,,4;$CB50-$CC17-1-32(wall)]
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
c $DC83 -> $DF16 - Get random byte??
c $DC86 -> $DF37
c $DC89 -> $DCDF - Initialization and go to game main loop
c $DC8C -> $E01B
c $DC8F -> $DDBE
c $DC92 -> $DF33
c $DC95
C $DC95,3 -> $9193
c $DCAF
C $DCCF,3 -> $E1AC
C $DCD6,3 -> $E44D
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
C $DD15,16 Initialize values for random byte calculation
C $DD38,4 $01 - Enemy delay (Time until first enemy appears)
b $DD3F
c $DD71 Process object records at $5B11
C $DD79,3 => Process object record IX
C $DD7F,2 Next record
C $DD84,2 End marker?
c $DD89 Process Player's object record
C $DD89,4 Player's object record address
c $DD8D Process object IX??
R $DD8D I:IX Address of the 20-byte object record
C $DE8E,3 -> $806B
c $DE91 Game's main loop, Part 1
C $DE91,4 Is Player alive??
C $DEA9,3 -> $6456
C $DECB,3 -> $91AA
C $DECE,3 Process object records at $5B11
C $DED5,4 Check bit 6 (??) of Last joystick/keyboard bits ($FD85)
b $DEDD
c $DEEF Game's main loop, Part 2
C $DEEF,3 -> $ED52
C $DEF2,3 -> $E4FC
C $DEF5,3 -> $ECC1
C $DEF8,3 -> $E6FE
C $DEFB,3 -> $F26E
C $DEFE,3 -> $F36D
C $DF01,3 -> $F381
C $DF04,3 Process Player's object record
C $DF07,3 -> $F707
C $DF0A,3 -> $E2EA
C $DF0D,3 -> $6593
c $DF16 Get random byte??
c $DF33
c $DF37
c $DF67
c $DF6D
c $DF71
C $DF71 Player is dead??
c $DF7B
c $E01B
C $E0A2,4 Check bit 3 (Up) of Last joystick/keyboard bits ($FD85)
b $E0BF
c $E100 -> $E4FC
c $E103 -> $ECC1
c $E106 -> $E6FE
c $E109 -> $ED52
c $E10C -> $E2EA
c $E10F -> $E44D
c $E112 -> $E1AC
b $E115
c $E1AC
C $E1AC,3 -> $DF16
c $E1B5
c $E1D1
C $E1EA,3 +750??
C $E1ED,3 -> $6825 - Update Score
c $E224
C $E24A,3 Get Area number
C $E268,3 -> $F4F6
C $E28A,3 +1500?? for destroying a Jeep??
C $E28D,3 -> $6825 - Update Score
C $E2AE,4 Player is dead??
C $E2D8,4 Player is dead??
c $E2DD
c $E2EA
C $E2FF,3 Get Area number
C $E323,3 Get Area number
C $E326,2 $03 - Fortress byte
C $E360,3 -> $DF16 - Get random byte??
C $E39B,3 -> $DF16 - Get random byte??
C $E3A4,3 -> $DF16 - Get random byte??
b $E4F2
c $E4FC
C $E4FC,4 Player's object record address
C $E546,3 Get last joystick/keyboard bits
C $E54C,3 Update last joystick/keyboard bits
C $E57C,4 Player is dead??
C $E586,3 Get last joystick/keyboard bits
c $E5B8
c $E5DB
C $E607,3 -> $F34F
c $E628
c $E648
C $E65B,4 Check bit 0 (Right) of Last joystick/keyboard bits ($FD85)
c $E679
C $E68C,4 Check bit 1 (Left) of Last joystick/keyboard bits ($FD85)
c $E6A8
C $E6BC,4 Check bit 3 (Up) of Last joystick/keyboard bits ($FD85)
c $E6DB
c $E6FE
N $E753 Killed the object
C $E75B,3 +200 for the kill
C $E765,1 change to +2000
C $E766,3 -> $6825 - Update Score
C $E76B,3 -> $6456
c $E77C
R $E77C I:HL ??
R $E77C I:D ??
R $E77C I:B ??
C $E77F,2 Inactive record marker??
c $E794
C $E7B9,4 Player is dead??
c $E86B
c $E881
c $E8A0
c $E90A
c $E972
b $E9C7
t $E9E1
b $E9E4
t $EAC4
b $EAC7
c $EB13
C $EB15,3 Get Area number
C $EB44,3 Get Area number
c $EB68
c $EB7B
c $EB96
c $EBE1
c $EC1B
C $EC3F,3 Get Area number
C $EC52,3 -> $F4F6
c $EC58
b $EC81
c $ECC1
C $ECC7,4 Check bit 4 (Fire) of Last joystick/keyboard bits ($FD85)
C $ECCF,2 Fire => jump
N $ECE3 Fire button pressed
C $ECFA,3 Get grenades number
C $ECFF,3 Get player's column
C $ED11,3 -> $F4E3
C $ED15,2 -1 more grenades
C $ED17,3 -> $6C7A - We've got A more grenades
C $ED1F,3 Player's object record address
C $ED2E,3 -> $6456
c $ED31
c $ED52
C $EDAE,3 -> $7511 - XOR AF and AF' with every byte in $F900-F9FF
c $EDC8
c $EDD6
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
c $EF37
c $EF7C
b $EFA3
t $EFBB
b $EFBE
t $EFC1
b $EFC5
t $EFD2
b $EFD7
c $EFDD
C $F003,3 Get Area number
b $F052
t $F05D
b $F060
t $F064
b $F068
t $F072
b $F075
c $F076
C $F093,3 +3000
C $F096,3 -> $6825 - Update Score
b $F09E
t $F0ED
b $F0F0
t $F0F4
b $F0F9
t $F100
b $F105
c $F114
c $F126
c $F14C
c $F180
c $F1BB
b $F1DD
t $F1DE
b $F1E1
c $F200 -> $F4F6
c $F203 -> $F381
c $F206 -> $F707
c $F209 -> $F26E
c $F20C -> $F24A
c $F20F -> $F4E9
c $F212 -> $F36D
b $F215
c $F21B -> $F4E3
c $F21E -> $F34F
c $F221
c $F237
c $F23B
c $F24A
c $F26E
C $F323,3 -> $6456
C $F326,3 +1000
C $F329,3 -> $6825 - Update Score
c $F34F
c $F36D
c $F37B
c $F381
C $F46C,4 Player is dead??
C $F4CF,3 -> $6456
c $F4E3
c $F4E9
c $F4F6
c $F582
c $F5A0
c $F5BF
c $F5C6
c $F5CD
c $F5DD
c $F68A
c $F6C2
c $F707
C $F716,3 Record width = 20
C $F737,3 -> $DDBE
b $F73C
B $F73C,,14 Record width 14
B $F7C8,1 End marker
b $F7C9
B $F7C9,,14 Record width 14
B $F81D,1 End marker
b $F81E
B $F81E,,14 Record width 14
B $F82C,1 End marker
b $F82D
B $F82D,,5 Record width 5
B $F855,1 End marker
b $F856
B $F856,,10 Record width 20
B $F8EA,3
B $F8ED,,8
B $F8CE End marker
b $F8CF
b $F900 Buffer
b $FA00 Checksums??
b $FB00
b $FC06 Buffer for at least 144 bytes
c $FCFC -> $7357
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
c $FD91 -> $7A5D - Delay by BC-1 HALTs
b $FD94 (IY+xx) variables continued
B $FD95,1 (IY+$15) - ??
B $FD96,1 (IY+$16) - ?? = $88,$AA
B $FD97,1 (IY+$17) - ?? = $90,$FF
B $FD98,1 Last key read from keyboard
W $FD99,2 ??
B $FD9B,4 (IY+$1B),(IY+$1C),(IY+$1D),(IY+$1E) - Stored values for random byte calculation
B $FD9F,1 ?? = $00
B $FDA0,1 ?? = $07
W $FDA1,2 ?? = $5800; hi byte accessed as (IY+$22)
W $FDA3,2 Font address = $7EA0
W $FDA5,2 ??? = $0000
B $FDA7,1 ?? = $00; inc/dec (smth on char printing)
B $FDA8,1 Saved special char in $7637
W $FDA9,2 ?? = $FDAB
B $FDAB,1 Screen attribute??
B $FDAC,1 ??
B $FDAF,1 ?? = $00
B $FDB0,1 ?? = $00
B $FDB1,1 ?? = $01
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
B $FDFA,1 (IY+$7A) - ?? = $00,$04
B $FDFB,1 ?? = $00
B $FDFC,1 (IY+$7C) - ?? = $00
B $FDFD,1 (IY+$7D) - ??
B $FDFE,1 ??
w $FE00 Table addresses for every even screen line
W $FE00,,16
b $FF00 Buffer
B $FF00,,16
