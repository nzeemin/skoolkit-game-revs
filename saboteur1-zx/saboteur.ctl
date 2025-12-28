@ $6270 org
b $6270
c $6289 Show title picture (two ninjas)
C $6289,3 Encoded picture data address
C $628C,3 Tile screens address, used as a buffer
C $628F,1 Load next byte of picture data
C $6290,2 check for control byte $02 - end of sequence
C $6292,2 => Copy the buffer to screen
C $6294,1 move to next source byte
C $6295,2 check for repeater marker
C $6297,2 => repeat byte N times
C $6299,2 check for block marker
C $629B,2 => repeat byte N times
C $629D,1 Store regular byte into tile screen
C $629E,1 next buffer address
C $629F,2 Loop back to process next byte
C $62A1,1 get repeat count
C $62A2,1 store repeated byte in buffer
C $62A3,1 next buffer address
C $62A4,2 repeat B times
C $62A6,1 move to next source byte
C $62A7,2 continue processing
N $62A9 Buffer is ready, copy to screen
C $62A9,3 Start of screen
C $62AC,3 Tile screens address
C $62AF,2 Number of columns = 12
C $62B1,1 save screen address
C $62B2,2 Number of rows = 24
C $62B4,1 save screen address
C $62B5,1 save counters
C $62B6,2 8 lines
C $62B8,1 get picture byte
C $62B9,1 bitwise OR with screen pixels
C $62BA,1 put to the screen
C $62BB,1 next address in the buffer
C $62BC,1 next line
C $62BD,2 Repeat 8 times
C $62BF,1 restore counters
C $62C0,1 save screen address
C $62C7,1 save address in picture buffer
C $62C8,3 32
C $62CB,1 move HL to next tile row
C $62CC,1 restore address in picture buffer
C $62D3,2 continue loop for rows
C $62D5,1 restore screen address
C $62D6,1 next column
C $62D7,1 decrement column counter
C $62D8,2 continue loop for columns
b $62DB Title picture (two ninjas), RLE encoded
B $62DB,,8 #HTML[<img src="images/title.png" />]
B $658F,1,1
c $6590 Tile screen 0 30x17 tiles, 510 bytes - background
N $6590 Code to show anti-piracy message just once at the very beginning
C $6590,3 Start of screen attribute area
C $6593,3 Start of screen attribute area + 1
C $6596,3 32
C $6599,2 set the attribute
C $659B,2 copy to the rest of the row
C $659D,3 704 = 22 attribute rows
C $65A0,2 set the attribute
C $65BF,3 Start of anti-piracy message
C $65C2,3 Screen address
C $65C7,3 Print string
C $65CA,3 Screen address
C $65CF,3 Print string
C $65D2,3 Screen address
C $65D7,3 Print string
N $65DA Wait for any key and RET
C $65DB,3 clear LASTK
C $65DF,3 check LASTK
C $65E2,2 any key?
C $65E4,2 no => wait
t $65E7 Start of anti-piracy message
T $65E7,,32
T $65F2
b $678E Tile screen 1 30x17 tiles, 510 bytes - update flags
T $678E
T $6867
T $6868
B $68E7
B $68F6,,30
b $698C Tile screen 2 30x17 tiles, 510 bytes - Ninja screen
B $698C,510,30
b $6B8A Tile screen 3 30x17 tiles, 510 bytes - Dog screen
B $6B8A,510,30
b $6D88 Tile screen 4 30x17 tiles, 510 bytes - Guard screen
B $6D88,510,30
b $6F86 Tile screen 5 30x17 tiles, 510 bytes - front
B $6F86,510,30
b $7184
W $7184,2,2 Current Room address
W $7186,2,2 Ninja sprite address
b $7188 Blocks for rooms
B $7188,12,6 #HTML[<img src="images/blocks/7188.png" />] Front block 6x2 - pile of garbage
B $7194,12,4 #HTML[<img src="images/blocks/7194.png" />] Back block 4x3 - pier fencing
B $71A0,9,3 #HTML[<img src="images/blocks/71a0.png" />] Front block 3x3 - box
B $71A9,16,4 #HTML[<img src="images/blocks/71a9.png" />] Front block 4x4 - computer part
B $71B9,2,2 #HTML[<img src="images/blocks/71b9.png" />] Back block 2x1 - ladder black on blue
B $71BB,8,2 #HTML[<img src="images/blocks/71bb.png" />] Front block 2x4 - console
b $71C3 Current Guard data
W $71C3,2,2 Current Guard position in tilemap
B $71C5,1,1 Current Guard X position
B $71C6,1,1 Current Guard Y position
b $71C7
b $71CB Current Dog data, 9 bytes
W $71CB,2,2 Dog position in tilemap
B $71CD,1,1 Dog direction
B $71CE,1,1 Dog X position
B $71CF,1,1 Dog ??
B $71D0,1,1 Dog's left limit
B $71D1,1,1 Dog's right limit
B $71D2,1,1 Dog ??
B $71D3,1,1 Dog Y position
b $71D4
B $71D4,1,1 ??
B $71D5,1,1 ??
B $71D6,9,9 Room 79C6 dog data
b $71F2 Sprite Dog 1
B $71F2,12,4 #HTML[<img src="images/sprite-71f2.png" />]
b $71FE Sprite Dog 2
B $71FE,12,4 #HTML[<img src="images/sprite-71fe.png" />]
b $720A Sprite Dog 3
B $720A,12,4 #HTML[<img src="images/sprite-720a.png" />]
b $7216 Sprite Dog 4
B $7216,12,4 #HTML[<img src="images/sprite-7216.png" />]
b $7222
B $7222,1,1 Input method: 1 = Joystick, 0 = Keyboard or Protek
B $7223,15,3 Ports and bits for the current input method
B $7232,1,1 Input bits: 000FUDLR
W $7233,2,2 Screen attributes address stored during tile map drawing
W $7235,2,2 Tile screen 5 address stored during tile map drawing
W $7237,2,2 Tile screen 4 address stored during tile map drawing
B $7239,1,1 Byte mirror flag
b $723A Mirror table
B $723A,128,16 Mirror table 1st part
B $72BA,128,16 Mirror table 2nd part
b $733A
B $733A,1,1 Ninja walking phase
b $733B Table of four addresses of Ninja/Guard walking sprites
W $733B,2,2 Sprite Ninja/Guard walking 1
W $733D,2,2 Sprite Ninja/Guard walking 2
W $733F,2,2 Sprite Ninja/Guard walking 3
W $7341,2,2 Sprite Ninja/Guard walking 4
b $7343
B $7343,1,1 Counter used in movement handlers
B $7344,1,1 Dog's flag: 1 = ignore left/right limit
B $7345,1,1 Dog ??
B $7346,1,1 Guard walking phase $00..$03 or other state: $09 = dead; $0A = standing; ...
B $7347,1,1 Guard direction
c $7348 Blocks for rooms
B $7348,2,2 Block 2x1
c $734A Proceed to the next room token (redirect to #R$B702)
c $734D Room token #0E: Put one tile at the given address; params: 3 bytes (tile, address)
C $734D,1 Restore token sequence address
C $734E,1 Skip token byte
C $734F,1 get tile byte
C $7351,1 get address low byte
C $7354,1 get address high byte
C $7356,1 put tile into tilemap
C $7357,2 => #R$B702 Proceed to the next room token
c $7359 Room token #0D: Set border color; params: 1 byte
C $7359,1 Restore token sequence address
C $735A,1 Skip token byte
C $735B,1 get byte
C $735F,2 => #R$B702 Proceed to the next room token
c $7361 Room token #?? - Draw frame with one tile; params: 1 byte - UNUSED
C $7361,1 Restore token sequence address
C $7362,1 Skip token byte
C $7363,1 get tile byte
C $7365,3 Tile screen 0 start address
C $7368,2 30
C $737F,2 => #R$B702 Proceed to the next room token
c $7381 Room token #01: Fill to down; params: 4 bytes (count, filler, address)
C $7381,3 30
C $7384,1 Restore token sequence address
C $7385,1 Skip token byte
C $7386,1 get count byte
C $7388,1 get tile byte
C $738A,1 get address low byte
C $738D,1 get address high byte
C $7393,2 => #R$B702 Proceed to the next room token
c $7395 Room token #0A: Fill to down-right; params: 4 bytes (count, filler, address)
C $7395,3 30 + 1
c $739A Room token #0B: Fill to down-left; params: 4 bytes (count, filler, address)
C $739A,3 30 - 1
c $739F Room token #02: Fill to right; params: 4 bytes (count, filler, address)
c $73A4 Room token #06: Fill triangle from wide top
C $73A4,2 A = "INC HL" command
C $73A6,3 set the command
C $73A9,1 Restore token sequence address
C $73AA,1 Skip token byte
C $73AB,1 get filler tile
C $73AD,1 get count
C $73AF,1 get address low byte
C $73B2,1 get address high byte
C $73B5,3 30
C $73BB,1 !!MUT-CMD!! "INC HL" or "DEC HL"
C $73C0,1 next row
C $73C3,2 => #R$B702 Proceed to the next room token
c $73C5 Room token #07: Fill triangle from wide bottom; params: 4 bytes (filler, count, address)
C $73C5,2 A = "INC HL" command
C $73C7,3 set the command
C $73CA,1 Restore token sequence address
C $73CB,1 Skip token byte
C $73CC,1 get filler tile
C $73CE,1 get count
C $73D0,1 get address low byte
C $73D3,1 get address high byte
C $73D6,3 30
C $73DE,1 !!MUT-CMD!! "INC HL" or "DEC HL"
C $73E5,1 next row
C $73E8,3 => #R$B702 Proceed to the next room token
c $73EB Room token #08: Fill triangle from wide bottom; params: 4 bytes (filler, count, address)
C $73EB,2 A = "DEC HL" command
c $73EF Room token #09: Fill triangle from wide top
C $73EF,2 A = "DEC HL" command
c $73F3 Room token #04: Fill whole Tile screen 0 with one tile; params: 1 byte (filler)
C $73F3,1 Restore token sequence address
C $73F4,1 Skip token byte
C $73F5,1 get tile byte
C $73F7,3 Tile screen 0 start address
C $73FA,3 Tile screen 0 start address + 1
C $73FE,3 510 - 1
C $7403,3 => #R$B702 Proceed to the next room token
c $7406 Room token #05: Copy block of tiles; params: 6 bytes (width, height, srcaddr, address)
C $7406,1 Restore token sequence address
C $7407,1 Skip token byte
C $7408,1 get width byte
C $740A,1 get height byte
C $740C,1 get source address low byte
C $740E,1 get source address high byte
C $7410,1 get address low byte
C $7413,1 get address high byte
C $741B,2 continue loop by columns
C $741F,3 30
C $7426,2 continue loop by rows
C $7428,3 => #R$B702 Proceed to the next room token
c $742B Room token #0C: Copy block of tiles N times; params: 6 bytes (srcaddr, width, count, address)
C $742B,1 Restore token sequence address
C $742C,1 Skip token byte
C $742D,1 get source address low byte
C $742F,1 get source address high byte
C $7431,1 get width byte
C $7433,1 get height byte
C $7435,1 get address low byte
C $7438,1 get address high byte
C $7442,2 continue loop by columns
C $7448,3 30
C $744D,2 continue loop by rows
C $744F,3 => #R$B702 Proceed to the next room token
c $7452 Room token #03: Fill rectangle; params: 5 bytes (filler, width, height, address)
C $7452,1 Restore token sequence address
C $7453,1 Skip token byte
C $7460,3 30
C $746F,3 => #R$B702 Proceed to the next room token
c $7472
C $7492,3 set Energy = MAX
b $749C
B $749C,1,1 Energy $04..$13
B $749D,1,1 Energy lower, running bit
c $749E Decreasing Energy
C $74A6,3 get Energy
C $74C3,3 Energy address
C $74C6,1 Decrease Energy
c $74CD Draw NEAR/HELD item
C $74CD,2 !!MUT-ARG!! item number
C $74D3,3 !!MUT-ARG!! address for Table of items
C $7501,3 28
b $750B
w $751B
W $751B,,8
b $755B
B $755B,1,1 Ninja falling count, to decrease Energy on hit
b $755C
c $7918 Room procedure (for 19 rooms with a guard)
c $791B Rooms #R$7C9C/#R$92EF initialization
b $791E Room 791E (room with pier)
N $791E #HTML[<img src="images/rooms/791E.png" />]
W $791E,2,2 Room procedure
W $7920,2,2 Initialization
W $7922,2,2
W $7924,2,2 Room to Right
W $7926,2,2
W $7928,2,2
B $792A,2 Fill entire screen with $0D
B $792C,6 Rectangle 7x10 tiles with $FF at $6679
B $7932,5 Fill horz 23 tiles with $F5 at $6770
B $7937,5 Fill horz 23 tiles with $0B at $70EE
B $793C,6 Rectangle 23x3 tiles with $0C at $710C
B $7942,5 Fill horz 19 tiles with $F6 at $666A
B $7947,5 Fill vert 8 tiles with $0C at $6689
B $794C,5 Fill vert 8 tiles with $0C at $668E
B $7951,5 Fill vert 8 tiles with $0C at $6693
B $7956,5 Fill vert 12 tiles with $F2 at $65EB
B $795B,7 Block 4x3 tiles from #R$7194 to $6611
B $7962,7 Block 4x3 tiles from #R$7194 to $6615
B $7969,7 Block 4x3 tiles from #R$7194 to $6619
B $7970,7 Block 4x3 tiles from #R$7194 to $661D
B $7977,7 Block 4x3 tiles from #R$7194 to $6621
B $797E,5 Fill vert 3 tiles with $12 at $6625
B $7983,1 End of sequence
b $7984 Blocks for rooms
B $7984,10,2 #HTML[<img src="images/blocks/7984.png" />] Back block 2x5 - ladder black on blue
B $798E,28,4 #HTML[<img src="images/blocks/798e.png" />] Front block 4x7 - ladder fencing
B $79AA,28,4 #HTML[<img src="images/blocks/79aa.png" />] Front block 4x7 - ladder fencing
b $79C6 Room 79C6 (next to room with pier)
N $79C6 #HTML[<img src="images/rooms/79C6.png" />]
W $79C6,2,2 Room procedure
W $79C8,2,2 Initialization
W $79CA,2,2 Room to Left
W $79CC,2,2 Room to Right
W $79CE,2,2
W $79D0,2,2
B $79D2,2 Fill entire screen with $0D
B $79D4,6 Rectangle 30x10 tiles with $FF at $6662
B $79DA,6 Rectangle 21x6 tiles with $02 at $66C5
B $79E0,5 Fill horz 21 tiles with $03 at $66A7
B $79E5,7 Block 2 tiles from #R$71B9 to $666C copy 9 times
B $79EC,6 Rectangle 8x6 tiles with $00 at $65C4
B $79F2,5 Fill horz 10 tiles with $FF at $65A4
B $79F7,7 Block 2x4 tiles from #R$71BB to $6FF8
B $79FE,4 Put tile $2A at $6FB9
B $7A02,5 Fill vert 5 tiles with $2B at $6FD7
B $7A07,7 Block 6x2 tiles from #R$7188 to $713D
B $7A0E,4 Put tile $F1 at $666C
B $7A12,4 Put tile $F0 at $666D
B $7A16,1 End of sequence
b $7A17 Room 7A17
N $7A17 #HTML[<img src="images/rooms/7A17.png" />]
W $7A17,2,2 Room procedure
W $7A19,2,2 Initialization
W $7A1B,2,2 Room to Left
W $7A1D,2,2 Room to Right
W $7A1F,2,2 Room Up
W $7A21,2,2
B $7A23,2 Fill entire screen with $02
B $7A25,5 Triangle with $FF, count=6 at $66CD
B $7A2A,5 Fill horz 18 tiles with $FF at $6770
B $7A2F,6 Rectangle 12x8 tiles with $FF at $66B0
B $7A35,6 Rectangle 4x6 tiles with $00 at $65AE
B $7A3B,5 Fill horz 11 tiles with $FF at $6680
B $7A40,5 Fill horz 5 tiles with $FF at $6662
B $7A45,5 Fill vert 5 tiles with $2B at $6FC6
B $7A4A,4 Put tile $2A at $6FA8
B $7A4E,5 Fill horz 5 tiles with $FF at $6590
B $7A53,5 Fill horz 12 tiles with $FF at $659A
B $7A58,7 Block 2 tiles from #R$71B9 to $6598 copy 8 times
B $7A5F,7 Block 4x7 tiles from #R$798E to $709F
B $7A66,7 Block 4x7 tiles from #R$798E to $7048
B $7A6D,7 Block 4x7 tiles from #R$798E to $702B
B $7A74,1 End of sequence
b $7A75 Room 7A75
N $7A75 #HTML[<img src="images/rooms/7A75.png" />]
W $7A75,2,2 Room procedure
W $7A77,2,2 Initialization
W $7A79,2,2
W $7A7B,2,2
W $7A7D,2,2 Room Up
W $7A7F,2,2 Room Down
B $7A81,2 Fill entire screen with $FF
B $7A83,5 Fill horz 18 tiles with $03 at $660F
B $7A88,6 Rectangle 18x5 tiles with $02 at $662D
B $7A8E,7 Block 2 tiles from #R$71B9 to $6598 copy 17 times
B $7A95,4 Put tile $F1 at $66C4
B $7A99,4 Put tile $F0 at $66C5
B $7A9D,1 End of sequence
b $7A9E Room 7A9E
N $7A9E #HTML[<img src="images/rooms/7A9E.png" />]
W $7A9E,2,2 Room procedure
W $7AA0,2,2 Initialization
W $7AA2,2,2
W $7AA4,2,2 Room to Right
W $7AA6,2,2 Room Up
W $7AA8,2,2
B $7AAA,2 Fill entire screen with $FF
B $7AAC,5 Fill horz 28 tiles with $03 at $6682
B $7AB1,6 Rectangle 28x6 tiles with $02 at $66A0
B $7AB7,7 Block 2 tiles from #R$71B9 to $6598 copy 15 times
B $7ABE,7 Block 6x2 tiles from #R$7188 to $7115
B $7AC5,7 Block 6x2 tiles from #R$7188 to $7120
B $7ACC,1 End of sequence
b $7ACD Room 7ACD
N $7ACD #HTML[<img src="images/rooms/7ACD.png" />]
W $7ACD,2,2 Room procedure
W $7ACF,2,2 Initialization
W $7AD1,2,2 Room to Left
W $7AD3,2,2 Room to Right
W $7AD5,2,2 Room Up
W $7AD7,2,2
B $7AD9,2 Fill entire screen with $FF
B $7ADB,6 Rectangle 30x6 tiles with $02 at $6680
B $7AE1,5 Fill horz 26 tiles with $03 at $6666
B $7AE6,5 Fill horz 4 tiles with $03 at $6680
B $7AEB,5 Fill horz 10 tiles with $02 at $6734
B $7AF0,7 Block 2 tiles from #R$71B9 to $65A2 copy 14 times
B $7AF7,1 End of sequence
b $7AF8 Room 7AF8
N $7AF8 #HTML[<img src="images/rooms/7AF8.png" />]
W $7AF8,2,2 Room procedure
W $7AFA,2,2 Initialization
W $7AFC,2,2 Room to Left
W $7AFE,2,2
W $7B00,2,2 Room Up
W $7B02,2,2
B $7B04,2 Fill entire screen with $FF
B $7B06,6 Rectangle 28x8 tiles with $02 at $6680
B $7B0C,5 Fill horz 13 tiles with $03 at $6686
B $7B11,7 Block 2 tiles from #R$71B9 to $6598 copy 15 times
B $7B18,5 Fill horz 6 tiles with $03 at $6662
B $7B1D,5 Fill horz 9 tiles with $FF at $6693
B $7B22,5 Fill horz 9 tiles with $03 at $66B1
B $7B27,7 Block 6x2 tiles from #R$7188 to $713C
B $7B2E,5 Fill horz 2 tiles with $FF at $6734
B $7B33,5 Fill horz 14 tiles with $FF at $6752
B $7B38,4 Put tile $FE at $6783
B $7B3C,4 Put tile $FE at $678A
B $7B40,7 Block 1x2 tiles from #R$7B4F to $6756
B $7B47,7 Block 1x2 tiles from #R$7B4F to $675E
B $7B4E,1 End of sequence
b $7B4F Blocks for rooms
B $7B4F,2,1 #HTML[<img src="images/blocks/7b4f.png" />] Back block 1x2 - vertical pipe
B $7B51,1,1 #HTML[<img src="images/blocks/7b51.png" />] Back block 1x1 - vertical pipe
B $7B52,4,1 #HTML[<img src="images/blocks/7b52.png" />] Back block 1x4 - vertical pipe
b $7B56 Room 7B56
N $7B56 #HTML[<img src="images/rooms/7B56.png" />]
W $7B56,2,2 Room procedure
W $7B58,2,2 Initialization
W $7B5A,2,2
W $7B5C,2,2
W $7B5E,2,2 Room Up
W $7B60,2,2 Room Down
B $7B62,2 Fill entire screen with $FF
B $7B64,6 Rectangle 8x6 tiles with $02 at $6628
B $7B6A,6 Rectangle 10x5 tiles with $02 at $6633
B $7B70,5 Fill horz 8 tiles with $03 at $660A
B $7B75,5 Fill horz 10 tiles with $03 at $6615
B $7B7A,7 Block 2 tiles from #R$71B9 to $6594 copy 11 times
B $7B81,7 Block 2 tiles from #R$71B9 to $65A2 copy 17 times
B $7B88,7 Block 2 tiles from #R$7984 to $66CE copy 1 times
B $7B8F,1 End of sequence
b $7B90 Room 7B90
N $7B90 #HTML[<img src="images/rooms/7B90.png" />]
W $7B90,2,2 Room procedure
W $7B92,2,2 Initialization
W $7B94,2,2 Room to Left
W $7B96,2,2 Room to Right
W $7B98,2,2
W $7B9A,2,2
B $7B9C,2 Fill entire screen with $01
B $7B9E,6 Rectangle 5x9 tiles with $02 at $6590
B $7BA4,5 Fill horz 6 tiles with $FF at $6592
B $7BA9,4 Put tile $2A at $6FA9
B $7BAD,5 Fill vert 7 tiles with $2B at $6FC7
B $7BB2,6 Rectangle 15x8 tiles with $FF at $669E
B $7BB8,6 Rectangle 15x3 tiles with $FF at $6743
B $7BBE,5 Triangle with $FF, count=4 at $66CB
B $7BC3,7 Block 4x7 tiles from #R$79AA to $7068
B $7BCA,7 Block 4x7 tiles from #R$79AA to $702A
B $7BD1,1 End of sequence
b $7BD2 Room 7BD2
N $7BD2 #HTML[<img src="images/rooms/7BD2.png" />]
W $7BD2,2,2 Room procedure
W $7BD4,2,2 Initialization
W $7BD6,2,2 Room to Left
W $7BD8,2,2 Room to Right
W $7BDA,2,2 Room Up
W $7BDC,2,2 Room Down
B $7BDE,2 Fill entire screen with $01
B $7BE0,6 Rectangle 20x3 tiles with $FF at $6734
B $7BE6,5 Fill horz 10 tiles with $FF at $6784
B $7BEB,4 Put tile $FF at $6766
B $7BEF,7 Block 3x4 tiles from #R$7C0C to $70B5
B $7BF6,7 Block 3x3 tiles from #R$7C18 to $7124
B $7BFD,7 Block 2 tiles from #R$7C2A to $659E copy 14 times
B $7C04,7 Block 2x3 tiles from #R$7984 to $673C
B $7C0B,1 End of sequence
b $7C0C Blocks for rooms
B $7C0C,12,3 #HTML[<img src="images/blocks/7c0c.png" />] Front block 3x4
B $7C18,9,3 #HTML[<img src="images/blocks/7c18.png" />] Front block 3x3
B $7C21,9,3 #HTML[<img src="images/blocks/7c21.png" />] Front block 3x3 - barrel - to drow using token #00
B $7C2A,2,2 #HTML[<img src="images/blocks/7c2a.png" />] Back block 2x1 - ladder black on green
B $7C2C,2,2 #HTML[<img src="images/blocks/7c2c.png" />] Back block 2x1 - ladder black on green
b $7C2E Room 7C2E
N $7C2E #HTML[<img src="images/rooms/7C2E.png" />]
W $7C2E,2,2 Room procedure
W $7C30,2,2 Initialization
W $7C32,2,2 Room to Left
W $7C34,2,2
W $7C36,2,2 Room Up
W $7C38,2,2 Room Down
B $7C3A,2 Fill entire screen with $01
B $7C3C,6 Rectangle 30x4 tiles with $FF at $6716
B $7C42,6 Rectangle 5x6 tiles with $FF at $6590
B $7C48,6 Rectangle 3x13 tiles with $FF at $65AB
B $7C4E,4 Put tile $2A at $703B
B $7C52,5 Fill vert 6 tiles with $2B at $7059
B $7C57,7 Block 2 tiles from #R$7C2A to $6595 copy 13 times
B $7C5E,7 Block 2x4 tiles from #R$7984 to $671E
B $7C65,7 Block 2x4 tiles from #R$7984 to $672A
B $7C6C,1 End of sequence
b $7C6D Room 7C6D
N $7C6D #HTML[<img src="images/rooms/7C6D.png" />]
W $7C6D,2,2 Room procedure
W $7C6F,2,2 Initialization
W $7C71,2,2
W $7C73,2,2 Room to Right
W $7C75,2,2 Room Up
W $7C77,2,2 Room Down
B $7C79,2 Fill entire screen with $FF
B $7C7B,7 Block 2 tiles from #R$71B9 to $6598 copy 17 times
B $7C82,6 Rectangle 14x6 tiles with $02 at $6690
B $7C88,5 Fill horz 9 tiles with $03 at $6672
B $7C8D,5 Fill horz 5 tiles with $03 at $6699
B $7C92,7 Block 2 tiles from #R$71B9 to $65A4 copy 14 times
B $7C99,1 End of sequence
b $7C9A Blocks for rooms
B $7C9A,2,2 #HTML[<img src="images/blocks/7c9a.png" />] Back block 2x1 - ladder black on green
b $7C9C Room 7C9C
N $7C9C #HTML[<img src="images/rooms/7C9C.png" />]
W $7C9C,2,2 Room procedure
W $7C9E,2,2 Initialization
W $7CA0,2,2 Room to Left
W $7CA2,2,2 Room to Right
W $7CA4,2,2
W $7CA6,2,2
B $7CA8,2 Fill entire screen with $FF
B $7CAA,5 Fill horz 30 tiles with $03 at $6662
B $7CAF,6 Rectangle 30x7 tiles with $02 at $6680
B $7CB5,6 Rectangle 4x2 tiles with $22 at $66AB
B $7CBB,6 Rectangle 30x2 tiles with $21 at $6716
B $7CC1,7 Block 6x7 tiles from #R$7D0D to $7082
B $7CC8,7 Block 5x1 tiles from #R$7D08 to $6753
B $7CCF,7 Block 5x1 tiles from #R$7D08 to $6762
B $7CD6,7 Block 5x7 tiles from #R$7CE5 to $6687
B $7CDD,7 Block 5x7 tiles from #R$7D37 to $6692
B $7CE4,1 End of sequence
b $7CE5 Blocks for rooms
B $7CE5,35,5 #HTML[<img src="images/blocks/7ce5.png" />] Back block 5x7 - Train part
B $7D08,5,5 #HTML[<img src="images/blocks/7d08.png" />] Back block 5x1 - Train part
B $7D0D,42,6 #HTML[<img src="images/blocks/7d0d.png" />] Front block 6x7 - Train central part
B $7D37,35,5 #HTML[<img src="images/blocks/7d37.png" />] Back block 5x7 - Train part
b $7D5A Room 7D5A
N $7D5A #HTML[<img src="images/rooms/7D5A.png" />]
W $7D5A,2,2 Room procedure
W $7D5C,2,2 Initialization
W $7D5E,2,2 Room to Left
W $7D60,2,2 Room to Right
W $7D62,2,2
W $7D64,2,2 Room Down
B $7D66,2 Fill entire screen with $01
B $7D68,6 Rectangle 30x6 tiles with $FF at $6590
B $7D6E,7 Block 2 tiles from #R$7C2A to $659B copy 16 times
B $7D75,5 Fill horz 2 tiles with $EA at $6631
B $7D7A,5 Fill horz 30 tiles with $FF at $6770
B $7D7F,6 Rectangle 6x3 tiles with $FF at $672E
B $7D85,5 Triangle with $FF, count=2 at $674B
B $7D8A,7 Block 2 tiles from #R$7984 to $6774 copy 1 times
B $7D91,7 Block 2 tiles from #R$7984 to $6782 copy 1 times
B $7D98,4 Put tile $2A at $7056
B $7D9C,5 Fill vert 6 tiles with $2B at $7074
B $7DA1,7 Block 4x7 tiles from #R$798E to $70A9
B $7DA8,1 End of sequence
b $7DA9 Room 7DA9
N $7DA9 #HTML[<img src="images/rooms/7DA9.png" />]
W $7DA9,2,2 Room procedure
W $7DAB,2,2 Initialization
W $7DAD,2,2
W $7DAF,2,2 Room to Right
W $7DB1,2,2 Room Up
W $7DB3,2,2 Room Down
B $7DB5,2 Fill entire screen with $01
B $7DB7,5 Fill horz 30 tiles with $FF at $6770
B $7DBC,5 Fill horz 30 tiles with $FF at $6590
B $7DC1,6 Rectangle 3x3 tiles with $FF at $65AE
B $7DC7,5 Fill vert 12 tiles with $EB at $6609
B $7DCC,7 Block 3x4 tiles from #R$7C0C to $70F0
B $7DD3,7 Block 2 tiles from #R$7C2C to $6775 copy 1 times
B $7DDA,7 Block 2 tiles from #R$7C9A to $6599 copy 16 times
B $7DE1,7 Block 2 tiles from #R$7C9A to $659C copy 16 times
B $7DE8,7 Block 2 tiles from #R$7C9A to $659F copy 16 times
B $7DEF,7 Block 3x3 tiles from #R$7C18 to $7122
B $7DF6,7 Block 3x4 tiles from #R$7C0C to $7101
B $7DFD,7 Block 3x4 tiles from #R$7C0C to $7106
B $7E04,1 End of sequence
b $7E05 Room 7E05
N $7E05 #HTML[<img src="images/rooms/7E05.png" />]
W $7E05,2,2 Room procedure
W $7E07,2,2 Initialization
W $7E09,2,2
W $7E0B,2,2 Room to Right
W $7E0D,2,2 Room Up
W $7E0F,2,2 Room Down
B $7E11,5 Fill horz 30 tiles with $FF at $6770
B $7E16,7 Block 2 tiles from #R$7C2C to $6779 copy 1 times
B $7E1D,7 Block 2 tiles from #R$7C2C to $677C copy 1 times
B $7E24,7 Block 2 tiles from #R$7C2C to $677F copy 1 times
B $7E2B,7 Block 2 tiles from #R$7348 to $6599 copy 16 times
B $7E32,5 Fill vert 12 tiles with $EB at $6609
B $7E37,7 Block 3x3 tiles from #R$7C21 to $70B5
B $7E3E,7 Block 3x3 tiles from #R$7C21 to $710E
B $7E45,7 Block 3x3 tiles from #R$7C21 to $7111
B $7E4C,7 Block 3x4 tiles from #R$7C0C to $7103
B $7E53,7 Block 4x3 tiles from #R$7E7B to $711F
B $7E5A,7 Block 3x1 tiles from #R$7E87 to $7144
B $7E61,7 Block 2x1 tiles from #R$7E8A to $7161
B $7E68,7 Block 2x1 tiles from #R$7E8A to $7164
B $7E6F,5 Fill horz 5 tiles with $FF at $6590
B $7E74,6 Rectangle 3x3 tiles with $FF at $65AE
B $7E7A,1 End of sequence
b $7E7B Blocks for rooms
B $7E7B,12,4 #HTML[<img src="images/blocks/7e7b.png" />] Front block 4x3 wooden box
B $7E87,3,3 #HTML[<img src="images/blocks/7e87.png" />] Block 3x1
B $7E8A,2,2 #HTML[<img src="images/blocks/7e8a.png" />] Block 2x1
b $7E8C Room 7E8C
N $7E8C #HTML[<img src="images/rooms/7E8C.png" />]
W $7E8C,2,2 Room procedure
W $7E8E,2,2 Initialization
W $7E90,2,2 Room to Left
W $7E92,2,2 Room to Right
W $7E94,2,2
W $7E96,2,2 Room Down
B $7E98,2 Fill entire screen with $01
B $7E9A,5 Fill horz 30 tiles with $FF at $6590
B $7E9F,5 Fill horz 30 tiles with $FF at $6770
B $7EA4,7 Block 2 tiles from #R$7C2C to $6772 copy 1 times
B $7EAB,7 Block 2 tiles from #R$7C2C to $6784 copy 1 times
B $7EB2,7 Block 3x3 tiles from #R$7C18 to $710C
B $7EB9,7 Block 3x4 tiles from #R$7C0C to $70F2
B $7EC0,7 Block 4x3 tiles from #R$7E7B to $7111
B $7EC7,7 Block 4x3 tiles from #R$7E7B to $7115
B $7ECE,7 Block 4x3 tiles from #R$7E7B to $70BE
B $7ED5,7 Block 3x3 tiles from #R$71A0 to $70BA
B $7EDC,7 Block 3x3 tiles from #R$71A0 to $711B
B $7EE3,7 Block 3x3 tiles from #R$7C18 to $7122
B $7EEA,7 Block 3x4 tiles from #R$7C0C to $7106
B $7EF1,1 End of sequence
b $7EF2 Room 7EF2
N $7EF2 #HTML[<img src="images/rooms/7EF2.png" />]
W $7EF2,2,2 Room procedure
W $7EF4,2,2 Initialization
W $7EF6,2,2 Room to Left
W $7EF8,2,2
W $7EFA,2,2
W $7EFC,2,2
B $7EFE,2 Fill entire screen with $01
B $7F00,5 Fill horz 30 tiles with $FF at $6590
B $7F05,5 Fill horz 30 tiles with $FF at $6770
B $7F0A,5 Fill vert 15 tiles with $EB at $65CA
B $7F0F,7 Block 4x3 tiles from #R$7E7B to $7063
B $7F16,7 Block 4x3 tiles from #R$7E7B to $70BA
B $7F1D,7 Block 4x3 tiles from #R$7E7B to $7117
B $7F24,7 Block 3x3 tiles from #R$71A0 to $70C0
B $7F2B,7 Block 3x3 tiles from #R$71A0 to $710E
B $7F32,7 Block 3x3 tiles from #R$71A0 to $7112
B $7F39,7 Block 3x3 tiles from #R$71A0 to $711C
B $7F40,7 Block 3x3 tiles from #R$71A0 to $7123
B $7F47,1 End of sequence
b $7F48 Room 7F48
N $7F48 #HTML[<img src="images/rooms/7F48.png" />]
W $7F48,2,2 Room procedure
W $7F4A,2,2 Initialization
W $7F4C,2,2
W $7F4E,2,2 Room to Right
W $7F50,2,2 Room Up
W $7F52,2,2 Room Down
B $7F54,2 Fill entire screen with $FF
B $7F56,6 Rectangle 8x12 tiles with $01 at $65B2
B $7F5C,6 Rectangle 18x7 tiles with $01 at $666E
B $7F62,5 Fill horz 4 tiles with $01 at $671E
B $7F67,5 Triangle with $01, count=5 at $65D8
B $7F6C,7 Block 2 tiles from #R$7C9A to $6592 copy 13 times
B $7F73,7 Block 2 tiles from #R$7C9A to $65A4 copy 14 times
B $7F7A,5 Fill vert 1 tiles with $E4 at $665E
B $7F7F,7 Block 3x3 tiles from #R$7C18 to $70DF
B $7F86,7 Block 1x3 tiles from #R$7B4F to $6742
B $7F8D,7 Block 1x3 tiles from #R$7B4F to $674B
B $7F94,7 Block 2x3 tiles from #R$7984 to $673E
B $7F9B,1 End of sequence
b $7F9C Room 7F9C
N $7F9C #HTML[<img src="images/rooms/7F9C.png" />]
W $7F9C,2,2 Room procedure
W $7F9E,2,2 Initialization
W $7FA0,2,2 Room to Left
W $7FA2,2,2
W $7FA4,2,2
W $7FA6,2,2 Room Down
B $7FA8,2 Fill entire screen with $FF
B $7FAA,6 Rectangle 27x7 tiles with $01 at $6662
B $7FB0,5 Fill vert 1 tiles with $E4 at $6646
B $7FB5,7 Block 2x3 tiles from #R$7984 to $6738
B $7FBC,7 Block 2x3 tiles from #R$7984 to $6748
B $7FC3,1 End of sequence
b $7FC4 Room 7FC4
N $7FC4 #HTML[<img src="images/rooms/7FC4.png" />]
W $7FC4,2,2 Room procedure
W $7FC6,2,2 Initialization
W $7FC8,2,2 Room to Left
W $7FCA,2,2 Room to Right
W $7FCC,2,2 Room Up
W $7FCE,2,2
B $7FD0,2 Fill entire screen with $FF
B $7FD2,6 Rectangle 13x6 tiles with $02 at $6680
B $7FD8,5 Fill horz 4 tiles with $03 at $6680
B $7FDD,5 Fill horz 9 tiles with $03 at $6666
B $7FE2,7 Block 2 tiles from #R$71B9 to $659A copy 14 times
B $7FE9,5 Fill vert 17 tiles with $FD at $659E
B $7FEE,5 Fill horz 14 tiles with $03 at $6636
B $7FF3,6 Rectangle 14x5 tiles with $02 at $6654
B $7FF9,7 Block 1x6 tiles from #R$7B4F to $66F1
B $8000,7 Block 1x5 tiles from #R$7B51 to $65A7
B $8007,1 End of sequence
b $8008 Room 8008
N $8008 #HTML[<img src="images/rooms/8008.png" />]
W $8008,2,2 Room procedure
W $800A,2,2 Initialization
W $800C,2,2 Room to Left
W $800E,2,2
W $8010,2,2 Room Up
W $8012,2,2 Room Down
B $8014,2 Fill entire screen with $FF
B $8016,5 Fill horz 13 tiles with $03 at $6626
B $801B,5 Fill horz 11 tiles with $03 at $6636
B $8020,6 Rectangle 13x5 tiles with $02 at $6644
B $8026,6 Rectangle 11x6 tiles with $02 at $6654
B $802C,5 Fill horz 10 tiles with $02 at $66DD
B $8031,7 Block 2 tiles from #R$71B9 to $6594 copy 12 times
B $8038,7 Block 2 tiles from #R$71B9 to $65A4 copy 12 times
B $803F,7 Block 2x5 tiles from #R$7984 to $66FF
B $8046,7 Block 2x5 tiles from #R$7984 to $670C
B $804D,7 Block 1x5 tiles from #R$7B4F to $6702
B $8054,7 Block 1x5 tiles from #R$7B4F to $670A
B $805B,7 Block 1x5 tiles from #R$7B4F to $6711
B $8062,7 Block 1x5 tiles from #R$7B51 to $65A2
B $8069,7 Block 1x5 tiles from #R$7B51 to $65A9
B $8070,5 Fill vert 17 tiles with $FD at $659E
B $8075,1 End of sequence
b $8076 Room 8076
N $8076 #HTML[<img src="images/rooms/8076.png" />]
W $8076,2,2 Room procedure
W $8078,2,2 Initialization
W $807A,2,2
W $807C,2,2
W $807E,2,2 Room Up
W $8080,2,2 Room Down
B $8082,2 Fill entire screen with $FF
B $8084,5 Fill vert 17 tiles with $FD at $659A
B $8089,5 Fill vert 17 tiles with $FD at $659E
B $808E,5 Fill vert 17 tiles with $FD at $65A2
B $8093,5 Fill vert 17 tiles with $FD at $65A9
B $8098,7 Block 2 tiles from #R$71B9 to $6597 copy 17 times
B $809F,7 Block 2 tiles from #R$71B9 to $65A4 copy 17 times
B $80A6,1 End of sequence
b $80A7 Room 80A7
N $80A7 #HTML[<img src="images/rooms/80A7.png" />]
W $80A7,2,2 Room procedure
W $80A9,2,2 Initialization
W $80AB,2,2 Room to Left
W $80AD,2,2 Room to Right
W $80AF,2,2
W $80B1,2,2
B $80B3,5 Fill horz 30 tiles with $FF at $6590
B $80B8,5 Fill horz 30 tiles with $FF at $6770
B $80BD,7 Block 3x4 tiles from #R$7C0C to $70F0
B $80C4,7 Block 3x3 tiles from #R$7C21 to $7113
B $80CB,7 Block 3x3 tiles from #R$71A0 to $7117
B $80D2,7 Block 4x3 tiles from #R$7E7B to $711C
B $80D9,7 Block 3x3 tiles from #R$7C21 to $70C3
B $80E0,7 Block 3x3 tiles from #R$7C21 to $70C9
B $80E7,7 Block 3x3 tiles from #R$7C21 to $7122
B $80EE,7 Block 3x3 tiles from #R$7C21 to $7125
B $80F5,1 End of sequence
b $80F6 Room 80F6
N $80F6 #HTML[<img src="images/rooms/80F6.png" />]
W $80F6,2,2 Room procedure
W $80F8,2,2 Initialization
W $80FA,2,2 Room to Left
W $80FC,2,2
W $80FE,2,2
W $8100,2,2
B $8102,5 Fill horz 30 tiles with $FF at $6770
B $8107,6 Rectangle 2x16 tiles with $FF at $65AC
B $810D,7 Block 2x4 tiles from #R$71BB to $70F1
B $8114,7 Block 3x3 tiles from #R$7C21 to $70BA
B $811B,7 Block 3x3 tiles from #R$7C21 to $7112
B $8122,7 Block 3x3 tiles from #R$7C21 to $7115
B $8129,7 Block 3x3 tiles from #R$7C21 to $706F
B $8130,7 Block 3x3 tiles from #R$7C21 to $70C7
B $8137,7 Block 3x3 tiles from #R$7C21 to $70CB
B $813E,7 Block 3x3 tiles from #R$7C21 to $711F
B $8145,7 Block 3x3 tiles from #R$7C21 to $7122
B $814C,7 Block 3x3 tiles from #R$7C21 to $7125
B $8153,7 Block 4x3 tiles from #R$7E7B to $711A
B $815A,7 Block 2x1 tiles from #R$7E8A to $7155
B $8161,1 End of sequence
b $8162 Room 8162
N $8162 #HTML[<img src="images/rooms/8162.png" />]
W $8162,2,2 Room procedure
W $8164,2,2 Initialization
W $8166,2,2 Room to Left
W $8168,2,2
W $816A,2,2 Room Up
W $816C,2,2 Room Down
B $816E,6 Rectangle 28x8 tiles with $01 at $6680
B $8174,5 Fill horz 28 tiles with $FF at $6662
B $8179,5 Fill horz 30 tiles with $FF at $6770
B $817E,5 Fill horz 13 tiles with $FF at $6590
B $8183,5 Fill horz 7 tiles with $FF at $65A7
B $8188,7 Block 2 tiles from #R$81E3 to $65CA copy 15 times
B $818F,7 Block 2 tiles from #R$7348 to $65A0 copy 7 times
B $8196,7 Block 2x4 tiles from #R$71BB to $6FE7
B $819D,7 Block 3x4 tiles from #R$7C0C to $70EF
B $81A4,7 Block 3x3 tiles from #R$7C18 to $7110
B $81AB,7 Block 3x3 tiles from #R$7C18 to $711D
B $81B2,7 Block 3x4 tiles from #R$7C0C to $7104
B $81B9,7 Block 3x3 tiles from #R$7C18 to $7125
B $81C0,4 Put tile $2A at $6FA8
B $81C4,5 Fill vert 5 tiles with $2B at $6FC6
B $81C9,4 Put tile $2A at $6FAF
B $81CD,5 Fill vert 5 tiles with $2B at $6FCD
B $81D2,4 Put tile $2A at $6FBC
B $81D6,5 Fill vert 5 tiles with $2B at $6FDA
B $81DB,7 Block 2 tiles from #R$7C2C to $677E copy 1 times
B $81E2,1 End of sequence
b $81E3 Blocks for rooms
B $81E3,2,2 Block 2x1
b $81E5 Room 81E5
N $81E5 #HTML[<img src="images/rooms/81E5.png" />]
W $81E5,2,2 Room procedure
W $81E7,2,2 Initialization
W $81E9,2,2 Room to Left
W $81EB,2,2 Room to Right
W $81ED,2,2
W $81EF,2,2
B $81F1,6 Rectangle 30x9 tiles with $FF at $6680
B $81F7,6 Rectangle 28x7 tiles with $01 at $66A0
B $81FD,5 Fill horz 5 tiles with $00 at $6680
B $8202,5 Fill horz 6 tiles with $FF at $669E
B $8207,5 Fill horz 12 tiles with $FF at $6590
B $820C,5 Fill horz 11 tiles with $FF at $65A3
B $8211,5 Triangle with $FF, count=2 at $65AE
B $8216,4 Put tile $2A at $6FAC
B $821A,4 Put tile $2A at $6FB8
B $821E,5 Fill vert 6 tiles with $2B at $6FCA
B $8223,5 Fill vert 5 tiles with $2B at $6FD6
B $8228,5 Fill horz 10 tiles with $01 at $6694
B $822D,5 Fill horz 24 tiles with $01 at $66A4
B $8232,5 Fill horz 11 tiles with $FF at $6675
B $8237,1 End of sequence
b $8238 Room 8238
N $8238 #HTML[<img src="images/rooms/8238.png" />]
W $8238,2,2 Room procedure
W $823A,2,2 Initialization
W $823C,2,2
W $823E,2,2 Room to Right
W $8240,2,2 Room Up
W $8242,2,2 Room Down
B $8244,2 Fill entire screen with $FF
B $8246,6 Rectangle 28x6 tiles with $00 at $65EC
B $824C,5 Fill horz 14 tiles with $00 at $66A0
B $8251,7 Block 2 tiles from #R$71B9 to $6598 copy 17 times
B $8258,7 Block 2 tiles from #R$7348 to $65F2 copy 7 times
B $825F,7 Block 2x1 tiles from #R$7984 to $66C4
B $8266,4 Put tile $2A at $6FE4
B $826A,4 Put tile $2A at $6FF8
B $826E,5 Fill vert 6 tiles with $2B at $7002
B $8273,5 Fill vert 5 tiles with $2B at $7016
B $8278,1 End of sequence
b $8279 Room 8279
N $8279 #HTML[<img src="images/rooms/8279.png" />]
W $8279,2,2 Room procedure
W $827B,2,2 Initialization
W $827D,2,2
W $827F,2,2 Room to Right
W $8281,2,2
W $8283,2,2 Room Down
B $8285,7 Block 2 tiles from #R$81E3 to $6590 copy 17 times
B $828C,5 Triangle with $FF, count=4 at $66BE
B $8291,5 Fill horz 15 tiles with $FF at $6734
B $8296,5 Fill horz 21 tiles with $FF at $6752
B $829B,5 Fill horz 30 tiles with $FF at $6770
B $82A0,7 Block 3x3 tiles from #R$7C21 to $70A5
B $82A7,7 Block 3x3 tiles from #R$7C21 to $70C7
B $82AE,7 Block 3x3 tiles from #R$7C21 to $70DB
B $82B5,7 Block 3x3 tiles from #R$7C21 to $70FD
B $82BC,7 Block 3x3 tiles from #R$7C21 to $7100
B $82C3,7 Block 3x3 tiles from #R$7C21 to $7121
B $82CA,7 Block 3x3 tiles from #R$7C21 to $7124
B $82D1,7 Block 2x3 tiles from #R$7984 to $673C
B $82D8,4 Put tile $00 at $66BE
B $82DC,1 End of sequence
b $82DD Room 82DD
N $82DD #HTML[<img src="images/rooms/82DD.png" />]
W $82DD,2,2 Room procedure
W $82DF,2,2 Initialization
W $82E1,2,2 Room to Left
W $82E3,2,2 Room to Right
W $82E5,2,2
W $82E7,2,2 Room Down
B $82E9,5 Fill horz 13 tiles with $FF at $6770
B $82EE,5 Fill horz 7 tiles with $FF at $6758
B $82F3,5 Fill horz 6 tiles with $FF at $6764
B $82F8,5 Fill horz 12 tiles with $FF at $6782
B $82FD,7 Block 3x3 tiles from #R$7C21 to $710C
B $8304,7 Block 3x3 tiles from #R$7C21 to $710F
B $830B,7 Block 3x3 tiles from #R$7C21 to $70F5
B $8312,7 Block 3x3 tiles from #R$71A0 to $7102
B $8319,7 Block 4x3 tiles from #R$7E7B to $7125
B $8320,1 End of sequence
b $8321 Room 8321
N $8321 #HTML[<img src="images/rooms/8321.png" />]
W $8321,2,2 Room procedure
W $8323,2,2 Initialization
W $8325,2,2 Room to Left
W $8327,2,2
W $8329,2,2 Room Up
W $832B,2,2 Room Down
B $832D,5 Fill horz 30 tiles with $FF at $6770
B $8332,7 Block 2x1 tiles from #R$7984 to $6780
B $8339,6 Rectangle 3x4 tiles with $FF at $65AB
B $833F,5 Fill vert 12 tiles with $EB at $6624
B $8344,7 Block 4x3 tiles from #R$7E7B to $710E
B $834B,7 Block 4x3 tiles from #R$7E7B to $70B6
B $8352,7 Block 3x3 tiles from #R$71A0 to $7113
B $8359,7 Block 3x3 tiles from #R$7C21 to $7118
B $8360,7 Block 3x3 tiles from #R$71A0 to $711F
B $8367,7 Block 3x3 tiles from #R$71A0 to $7124
B $836E,7 Block 2x1 tiles from #R$7E8A to $715F
B $8375,7 Block 4x3 tiles from #R$7E7B to $70C7
B $837C,7 Block 2 tiles from #R$7348 to $65A0 copy 16 times
B $8383,1 End of sequence
b $8384 Room 8384
N $8384 #HTML[<img src="images/rooms/8384.png" />]
W $8384,2,2 Room procedure
W $8386,2,2 Initialization
W $8388,2,2
W $838A,2,2
W $838C,2,2 Room Up
W $838E,2,2 Room Down
B $8390,2 Fill entire screen with $FF
B $8392,6 Rectangle 15x7 tiles with $02 at $6628
B $8398,5 Fill horz 15 tiles with $03 at $660A
B $839D,6 Rectangle 6x7 tiles with $02 at $663C
B $83A3,5 Fill horz 6 tiles with $03 at $661E
B $83A8,7 Block 2 tiles from #R$71B9 to $6597 copy 12 times
B $83AF,7 Block 2 tiles from #R$71B9 to $65A4 copy 17 times
B $83B6,7 Block 2x5 tiles from #R$7984 to $66FC
B $83BD,7 Block 2x1 tiles from #R$7984 to $670C
B $83C4,5 Fill vert 17 tiles with $FD at $65A2
B $83C9,7 Block 1x4 tiles from #R$7B52 to $659A
B $83D0,7 Block 1x4 tiles from #R$7B52 to $659E
B $83D7,7 Block 1x4 tiles from #R$7B52 to $65A9
B $83DE,7 Block 1x5 tiles from #R$7B4F to $6702
B $83E5,7 Block 1x5 tiles from #R$7B4F to $6711
B $83EC,1 End of sequence
b $83ED Room 83ED
N $83ED #HTML[<img src="images/rooms/83ED.png" />]
W $83ED,2,2 Room procedure
W $83EF,2,2 Initialization
W $83F1,2,2
W $83F3,2,2 Room to Right
W $83F5,2,2 Room Up
W $83F7,2,2 Room Down
B $83F9,5 Fill horz 30 tiles with $FF at $6770
B $83FE,7 Block 2 tiles from #R$7348 to $6599 copy 16 times
B $8405,7 Block 2x1 tiles from #R$7984 to $6779
B $840C,6 Rectangle 3x4 tiles with $FF at $6590
B $8412,5 Fill horz 2 tiles with $FF at $6593
B $8417,5 Fill vert 12 tiles with $EB at $6609
B $841C,7 Block 3x4 tiles from #R$7C0C to $70F2
B $8423,7 Block 3x3 tiles from #R$71A0 to $710E
B $842A,7 Block 2x1 tiles from #R$7E8A to $714E
B $8431,7 Block 4x3 tiles from #R$7E7B to $70C4
B $8438,7 Block 4x3 tiles from #R$7E7B to $711B
B $843F,7 Block 3x4 tiles from #R$7C0C to $7106
B $8446,7 Block 4x3 tiles from #R$7E7B to $7121
B $844D,1 End of sequence
b $844E Room 844E
N $844E #HTML[<img src="images/rooms/844E.png" />]
W $844E,2,2 Room procedure
W $8450,2,2 Initialization
W $8452,2,2 Room to Left
W $8454,2,2
W $8456,2,2
W $8458,2,2 Room Down
B $845A,5 Fill horz 30 tiles with $FF at $6770
B $845F,5 Fill horz 6 tiles with $FF at $6752
B $8464,6 Rectangle 3x4 tiles with $FF at $65AB
B $846A,5 Fill vert 12 tiles with $EB at $6624
B $846F,7 Block 2x1 tiles from #R$7984 to $6780
B $8476,7 Block 3x3 tiles from #R$71A0 to $70F0
B $847D,7 Block 3x3 tiles from #R$71A0 to $7112
B $8484,3 Barrel 3x3 tiles at $70BE
B $8487,3 Barrel 3x3 tiles at $7116
B $848A,3 Barrel 3x3 tiles at $7119
B $848D,7 Block 4x3 tiles from #R$7E7B to $711F
B $8494,7 Block 3x4 tiles from #R$849C to $7107
B $849B,1 End of sequence
b $849C Blocks for rooms
B $849C,12,3 #HTML[<img src="images/blocks/849c.png" />] Front block 3x4
b $84A8 Room 84A8
N $84A8 #HTML[<img src="images/rooms/84A8.png" />]
W $84A8,2,2 Room procedure
W $84AA,2,2 Initialization
W $84AC,2,2 Room to Left
W $84AE,2,2 Room to Right
W $84B0,2,2
W $84B2,2,2 Room Down
B $84B4,6 Rectangle 13x2 tiles with $FF at $6752
B $84BA,6 Rectangle 12x2 tiles with $FF at $6764
B $84C0,5 Fill horz 3 tiles with $FF at $65BC
B $84C5,5 Fill horz 13 tiles with $FF at $659A
B $84CA,3 Barrel 3x3 tiles at $70F0
B $84CD,3 Barrel 3x3 tiles at $7097
B $84D0,7 Block 4x3 tiles from #R$7E7B to $7104
B $84D7,7 Block 5x3 tiles from #R$84DF to $70F2
B $84DE,1 End of sequence
b $84DF Blocks for rooms
B $84DF,15,5 #HTML[<img src="images/blocks/84df.png" />] Front block 5x3 - box
b $84EE Room 84EE
N $84EE #HTML[<img src="images/rooms/84EE.png" />]
W $84EE,2,2 Room procedure
W $84F0,2,2 Initialization
W $84F2,2,2
W $84F4,2,2 Room to Right
W $84F6,2,2 Room Up
W $84F8,2,2
B $84FA,6 Rectangle 2x15 tiles with $FF at $6590
B $8500,6 Rectangle 30x2 tiles with $FF at $6752
B $8506,7 Block 2 tiles from #R$7348 to $6598 copy 15 times
B $850D,3 Barrel 3x3 tiles at $70F0
B $8510,3 Barrel 3x3 tiles at $70F3
B $8513,3 Barrel 3x3 tiles at $704D
B $8516,3 Barrel 3x3 tiles at $70A6
B $8519,3 Barrel 3x3 tiles at $70A9
B $851C,3 Barrel 3x3 tiles at $70FE
B $851F,3 Barrel 3x3 tiles at $7101
B $8522,3 Barrel 3x3 tiles at $7104
B $8525,1 End of sequence
b $8526 Room 8526
N $8526 #HTML[<img src="images/rooms/8526.png" />]
W $8526,2,2 Room procedure
W $8528,2,2 Initialization
W $852A,2,2
W $852C,2,2 Room to Right
W $852E,2,2 Room Up
W $8530,2,2 Room Down
B $8532,7 Block 2 tiles from #R$81E3 to $6590 copy 16 times
B $8539,7 Block 2 tiles from #R$7348 to $6598 copy 16 times
B $8540,5 Fill horz 30 tiles with $FF at $6770
B $8545,7 Block 2x1 tiles from #R$7984 to $6778
B $854C,3 Barrel 3x3 tiles at $70B4
B $854F,3 Barrel 3x3 tiles at $710F
B $8552,3 Barrel 3x3 tiles at $7126
B $8555,7 Block 2x2 tiles from #R$8577 to $7138
B $855C,7 Block 3x4 tiles from #R$849C to $7100
B $8563,7 Block 2x2 tiles from #R$8577 to $713E
B $856A,7 Block 2x2 tiles from #R$8577 to $7141
B $8571,5 Fill horz 6 tiles with $FF at $659F
B $8576,1 End of sequence
b $8577 Blocks for rooms
B $8577,4,2 #HTML[<img src="images/blocks/8577.png" />] Front block 2x2 - box
B $857B,20,5 #HTML[<img src="images/blocks/857b.png" />] Front block 5x4 - box
b $858F Room 858F
N $858F #HTML[<img src="images/rooms/858F.png" />]
W $858F,2,2 Room procedure
W $8591,2,2 Initialization
W $8593,2,2 Room to Left
W $8595,2,2 Room to Right
W $8597,2,2
W $8599,2,2
B $859B,5 Fill horz 30 tiles with $FF at $6770
B $85A0,7 Block 5x4 tiles from #R$857B to $70F2
B $85A7,7 Block 5x4 tiles from #R$857B to $70F9
B $85AE,7 Block 2x1 tiles from #R$7E8A to $714E
B $85B5,7 Block 3x3 tiles from #R$71A0 to $711E
B $85BC,1 End of sequence
b $85BD Room 85BD
N $85BD #HTML[<img src="images/rooms/85BD.png" />]
W $85BD,2,2 Room procedure
W $85BF,2,2 Initialization
W $85C1,2,2 Room to Left
W $85C3,2,2
W $85C5,2,2 Room Up
W $85C7,2,2
B $85C9,5 Fill horz 30 tiles with $FF at $6770
B $85CE,6 Rectangle 3x4 tiles with $FF at $65AB
B $85D4,5 Fill vert 12 tiles with $EB at $6624
B $85D9,7 Block 2 tiles from #R$7348 to $659D copy 16 times
B $85E0,3 Barrel 3x3 tiles at $7004
B $85E3,3 Barrel 3x3 tiles at $705D
B $85E6,3 Barrel 3x3 tiles at $7060
B $85E9,3 Barrel 3x3 tiles at $70B5
B $85EC,3 Barrel 3x3 tiles at $70B8
B $85EF,3 Barrel 3x3 tiles at $70BB
B $85F2,3 Barrel 3x3 tiles at $710E
B $85F5,3 Barrel 3x3 tiles at $7111
B $85F8,3 Barrel 3x3 tiles at $7114
B $85FB,3 Barrel 3x3 tiles at $711D
B $85FE,3 Barrel 3x3 tiles at $7121
B $8601,3 Barrel 3x3 tiles at $7124
B $8604,3 Barrel 3x3 tiles at $7117
B $8607,1 End of sequence
b $8608 Room 8608
N $8608 #HTML[<img src="images/rooms/8608.png" />]
W $8608,2,2 Room procedure
W $860A,2,2 Initialization
W $860C,2,2
W $860E,2,2 Room to Right
W $8610,2,2
W $8612,2,2 Room Down
B $8614,5 Fill horz 30 tiles with $FF at $6770
B $8619,5 Fill horz 28 tiles with $FF at $6682
B $861E,5 Fill horz 12 tiles with $FF at $6674
B $8623,7 Block 2 tiles from #R$81E3 to $6590 copy 16 times
B $862A,5 Fill horz 14 tiles with $FF at $6592
B $862F,7 Block 2 tiles from #R$81E3 to $66BA copy 7 times
B $8636,7 Block 2x1 tiles from #R$7984 to $6778
B $863D,7 Block 3x3 tiles from #R$71A0 to $6FC4
B $8644,7 Block 4x3 tiles from #R$7E7B to $701E
B $864B,7 Block 3x3 tiles from #R$71A0 to $7024
B $8652,3 Barrel 3x3 tiles at $7028
B $8655,7 Block 3x3 tiles from #R$7C18 to $7011
B $865C,7 Block 3x4 tiles from #R$7C0C to $6FF7
B $8663,7 Block 3x3 tiles from #R$7C18 to $7118
B $866A,3 Barrel 3x3 tiles at $70B5
B $866D,3 Barrel 3x3 tiles at $710E
B $8670,3 Barrel 3x3 tiles at $7111
B $8673,3 Barrel 3x3 tiles at $70C4
B $8676,3 Barrel 3x3 tiles at $70C8
B $8679,3 Barrel 3x3 tiles at $70CB
B $867C,3 Barrel 3x3 tiles at $711C
B $867F,3 Barrel 3x3 tiles at $711F
B $8682,3 Barrel 3x3 tiles at $7122
B $8685,3 Barrel 3x3 tiles at $7125
B $8688,1 End of sequence
b $8689 Room 8689
N $8689 #HTML[<img src="images/rooms/8689.png" />]
W $8689,2,2 Room procedure
W $868B,2,2 Initialization
W $868D,2,2 Room to Left
W $868F,2,2
W $8691,2,2
W $8693,2,2 Room Down
B $8695,5 Fill horz 57 tiles with $FF at $66BC
B $869A,6 Rectangle 3x17 tiles with $FF at $65AB
B $86A0,7 Block 2x2 tiles from #R$7984 to $66C9
B $86A7,7 Block 2 tiles from #R$7348 to $6705 copy 5 times
B $86AE,7 Block 3x3 tiles from #R$7C18 to $7067
B $86B5,7 Block 4x2 tiles from #R$86F5 to $7021
B $86BC,7 Block 4x3 tiles from #R$7E7B to $705B
B $86C3,7 Block 3x3 tiles from #R$71A0 to $7060
B $86CA,7 Block 3x1 tiles from #R$7E87 to $7096
B $86D1,7 Block 5x3 tiles from #R$84DF to $6FB9
B $86D8,7 Block 3x3 tiles from #R$71A0 to $7012
B $86DF,7 Block 4x3 tiles from #R$7E7B to $7015
B $86E6,7 Block 4x3 tiles from #R$7E7B to $706B
B $86ED,7 Block 4x3 tiles from #R$7E7B to $706F
B $86F4,1 End of sequence
b $86F5 Blocks for rooms
B $86F5,8,4 #HTML[<img src="images/blocks/86f5.png" />] Front block 4x2 - box
b $86FD Room 86FD
N $86FD #HTML[<img src="images/rooms/86FD.png" />]
W $86FD,2,2 Room procedure
W $86FF,2,2 Initialization
W $8701,2,2 Room to Left
W $8703,2,2 Room to Right
W $8705,2,2 Room Up
W $8707,2,2
B $8709,5 Triangle with $FF, count=4 at $6716
B $870E,5 Fill horz 65 tiles with $FF at $66BC
B $8713,5 Triangle with $FF, count=2 at $6687
B $8718,6 Rectangle 7x3 tiles with $FF at $6662
B $871E,7 Block 2 tiles from #R$7348 to $6593 copy 7 times
B $8725,7 Block 4x7 tiles from #R$79AA to $6FE6
B $872C,3 Barrel 3x3 tiles at $700E
B $872F,3 Barrel 3x3 tiles at $7066
B $8732,3 Barrel 3x3 tiles at $7069
B $8735,3 Barrel 3x3 tiles at $706F
B $8738,1 End of sequence
b $8739 Room 8739
N $8739 #HTML[<img src="images/rooms/8739.png" />]
W $8739,2,2 Room procedure
W $873B,2,2 Initialization
W $873D,2,2 Room to Left
W $873F,2,2 Room to Right
W $8741,2,2
W $8743,2,2 Room Down
B $8745,5 Fill vert 9 tiles with $3A at $6594
B $874A,5 Fill vert 9 tiles with $3A at $659E
B $874F,5 Fill vert 9 tiles with $3A at $65A1
B $8754,5 Fill vert 5 tiles with $3A at $65A8
B $8759,5 Fill horz 120 tiles with $FF at $669E
B $875E,7 Block 2x4 tiles from #R$7984 to $66A1
B $8765,7 Block 2 tiles from #R$7348 to $6719 copy 4 times
B $876C,7 Block 2x4 tiles from #R$71BB to $702E
B $8773,7 Block 3x3 tiles from #R$7C18 to $7044
B $877A,7 Block 3x4 tiles from #R$7C0C to $7023
B $8781,7 Block 3x4 tiles from #R$7C0C to $7033
B $8788,1 End of sequence
b $8789 Blocks for rooms
B $8789,16,4 #HTML[<img src="images/blocks/8789.png" />] Front block 4x4
b $8799 Room 8799
N $8799 #HTML[<img src="images/rooms/8799.png" />]
W $8799,2,2 Room procedure
W $879B,2,2 Initialization
W $879D,2,2
W $879F,2,2 Room to Right
W $87A1,2,2
W $87A3,2,2
B $87A5,5 Fill vert 15 tiles with $3A at $6598
B $87AA,5 Fill vert 11 tiles with $3A at $659D
B $87AF,5 Fill vert 9 tiles with $3A at $65A1
B $87B4,5 Fill vert 9 tiles with $3A at $65A4
B $87B9,5 Fill vert 9 tiles with $3A at $65A7
B $87BE,5 Fill vert 9 tiles with $3A at $65AB
B $87C3,7 Block 2 tiles from #R$81E3 to $6590 copy 15 times
B $87CA,6 Rectangle 16x2 tiles with $FF at $6752
B $87D0,6 Rectangle 14x4 tiles with $FF at $66AE
B $87D6,5 Triangle with $FF, count=6 at $66AD
B $87DB,5 Triangle with $FF, count=4 at $6726
B $87E0,5 Fill horz 8 tiles with $FA at $65CE
B $87E5,7 Block 3x3 tiles from #R$71A0 to $7078
B $87EC,7 Block 4x4 tiles from #R$8789 to $70D2
B $87F3,7 Block 4x7 tiles from #R$798E to $707F
B $87FA,7 Block 4x7 tiles from #R$798E to $7028
B $8801,1 End of sequence
b $8802 Room 8802
N $8802 #HTML[<img src="images/rooms/8802.png" />]
W $8802,2,2 Room procedure
W $8804,2,2 Initialization
W $8806,2,2 Room to Left
W $8808,2,2
W $880A,2,2 Room Up
W $880C,2,2
B $880E,5 Fill vert 9 tiles with $3A at $659D
B $8813,5 Fill vert 8 tiles with $3A at $65A2
B $8818,6 Rectangle 3x17 tiles with $FF at $65AB
B $881E,5 Fill horz 132 tiles with $FF at $6692
B $8823,3 Barrel 3x3 tiles at $7042
B $8826,3 Barrel 3x3 tiles at $7046
B $8829,3 Barrel 3x3 tiles at $702F
B $882C,7 Block 2 tiles from #R$7348 to $65A7 copy 8 times
B $8833,1 End of sequence
b $8834 Room 8834
N $8834 #HTML[<img src="images/rooms/8834.png" />]
W $8834,2,2 Room procedure
W $8836,2,2 Initialization
W $8838,2,2 Room to Left
W $883A,2,2 Room to Right
W $883C,2,2 Room Up
W $883E,2,2 Room Down
B $8840,5 Fill vert 11 tiles with $3A at $65EC
B $8845,5 Fill vert 14 tiles with $3A at $6597
B $884A,5 Fill vert 16 tiles with $3A at $659D
B $884F,5 Fill vert 17 tiles with $3A at $65A2
B $8854,5 Fill horz 10 tiles with $FF at $6784
B $8859,7 Block 2 tiles from #R$7348 to $65A7 copy 16 times
B $8860,4 Put tile $3A at $675C
B $8864,7 Block 2x1 tiles from #R$889D to $66D3
B $886B,7 Block 2x1 tiles from #R$7984 to $6787
B $8872,5 Fill horz 7 tiles with $FA at $677A
B $8877,7 Block 1x2 tiles from #R$8898 to $675E
B $887E,5 Fill horz 12 tiles with $FA at $6734
B $8883,5 Fill horz 4 tiles with $FA at $6680
B $8888,5 Fill horz 4 tiles with $FA at $66E0
B $888D,5 Fill horz 6 tiles with $FA at $66CD
B $8892,5 Fill vert 3 tiles with $28 at $6F88
B $8897,1 End of sequence
b $8898 Blocks for rooms
B $8898,1,1 #HTML[<img src="images/blocks/8898.png" />] Back block 1x1
B $8899,4,1 #HTML[<img src="images/blocks/8899.png" />] Back block 1x4
B $889D,2,2 #HTML[<img src="images/blocks/889d.png" />] Back block 2x1 - ladder on yellow
b $889F Room 889F
N $889F #HTML[<img src="images/rooms/889F.png" />]
W $889F,2,2 Room procedure
W $88A1,2,2 Initialization
W $88A3,2,2 Room to Left
W $88A5,2,2 Room to Right
W $88A7,2,2 Room Up
W $88A9,2,2 Room Down
B $88AB,5 Fill vert 17 tiles with $3A at $6594
B $88B0,5 Fill vert 17 tiles with $3A at $65A8
B $88B5,5 Fill vert 12 tiles with $3A at $659C
B $88BA,5 Fill vert 6 tiles with $3A at $659F
B $88BF,5 Fill vert 6 tiles with $3A at $65A3
B $88C4,5 Fill vert 4 tiles with $3A at $6724
B $88C9,5 Fill vert 6 tiles with $3A at $66EB
B $88CE,5 Fill horz 7 tiles with $63 at $6653
B $88D3,5 Fill vert 7 tiles with $3A at $6619
B $88D8,4 Put tile $63 at $6655
B $88DC,5 Fill horz 4 tiles with $FA at $66A2
B $88E1,5 Fill horz 10 tiles with $FA at $66DA
B $88E6,5 Fill horz 3 tiles with $FA at $6704
B $88EB,5 Fill horz 11 tiles with $FA at $675F
B $88F0,5 Fill horz 6 tiles with $FA at $6698
B $88F5,5 Fill horz 3 tiles with $FA at $674F
B $88FA,5 Fill horz 6 tiles with $FA at $676A
B $88FF,7 Block 1x1 tiles from #R$8899 to $66A4
B $8906,7 Block 1x4 tiles from #R$8898 to $66C2
B $890D,1 End of sequence
b $890E Room 890E
N $890E #HTML[<img src="images/rooms/890E.png" />]
W $890E,2,2 Room procedure
W $8910,2,2 Initialization
W $8912,2,2 Room to Left
W $8914,2,2 Room to Right
W $8916,2,2
W $8918,2,2
B $891A,5 Fill vert 16 tiles with $3A at $6599
B $891F,5 Fill vert 16 tiles with $3A at $65A1
B $8924,5 Fill vert 7 tiles with $3A at $66B6
B $8929,5 Fill horz 30 tiles with $FF at $6770
B $892E,7 Block 3x3 tiles from #R$7C18 to $7112
B $8935,5 Fill horz 5 tiles with $63 at $6619
B $893A,5 Fill horz 3 tiles with $FA at $66AE
B $893F,5 Fill horz 7 tiles with $FA at $6697
B $8944,5 Fill horz 9 tiles with $FA at $6684
B $8949,5 Fill vert 7 tiles with $F9 at $65F3
B $894E,4 Put tile $F8 at $6689
B $8952,1 End of sequence
b $8953 Room 8953
N $8953 #HTML[<img src="images/rooms/8953.png" />]
W $8953,2,2 Room procedure
W $8955,2,2 Initialization
W $8957,2,2
W $8959,2,2 Room to Right
W $895B,2,2 Room Up
W $895D,2,2 Room Down
B $895F,5 Fill vert 17 tiles with $3A at $6598
B $8964,5 Fill vert 16 tiles with $3A at $659D
B $8969,5 Fill vert 5 tiles with $3A at $65A0
B $896E,5 Fill vert 9 tiles with $3A at $65A3
B $8973,5 Fill vert 17 tiles with $3A at $65AB
B $8978,5 Fill vert 7 tiles with $3A at $66CD
B $897D,5 Fill vert 7 tiles with $3A at $66D0
B $8982,5 Fill vert 2 tiles with $3A at $6769
B $8987,7 Block 2 tiles from #R$81E3 to $6590 copy 17 times
B $898E,7 Block 2 tiles from #R$7348 to $6595 copy 9 times
B $8995,5 Fill horz 5 tiles with $63 at $6633
B $899A,5 Fill horz 7 tiles with $FA at $66A0
B $899F,5 Fill horz 8 tiles with $FA at $6754
B $89A4,5 Fill horz 3 tiles with $FA at $677C
B $89A9,5 Fill horz 5 tiles with $FA at $66AE
B $89AE,5 Fill horz 6 tiles with $FA at $6747
B $89B3,5 Fill horz 23 tiles with $FA at $66E1
B $89B8,1 End of sequence
b $89B9 Room 89B9
N $89B9 #HTML[<img src="images/rooms/89B9.png" />]
W $89B9,2,2 Room procedure
W $89BB,2,2 Initialization
W $89BD,2,2
W $89BF,2,2 Room to Right
W $89C1,2,2
W $89C3,2,2 Room Down
B $89C5,4 Put tile $3A at $66B6
B $89C9,4 Put tile $3A at $672A
B $89CD,5 Fill vert 8 tiles with $3A at $66AB
B $89D2,5 Fill vert 8 tiles with $3A at $66B9
B $89D7,5 Fill vert 2 tiles with $3A at $6762
B $89DC,5 Fill vert 2 tiles with $3A at $6765
B $89E1,5 Triangle with $FF, count=11 at $6590
B $89E6,5 Fill horz 19 tiles with $FF at $659B
B $89EB,7 Block 2 tiles from #R$81E3 to $669E copy 8 times
B $89F2,7 Block 2 tiles from #R$7348 to $662B copy 11 times
B $89F9,7 Block 2x1 tiles from #R$889D to $6775
B $8A00,5 Fill horz 11 tiles with $FA at $6777
B $8A05,5 Fill horz 4 tiles with $FA at $668B
B $8A0A,5 Fill horz 5 tiles with $FA at $6744
B $8A0F,5 Fill horz 8 tiles with $FA at $6696
B $8A14,7 Block 1x4 tiles from #R$8898 to $66F0
B $8A1B,7 Block 1x3 tiles from #R$8898 to $66D4
B $8A22,5 Fill horz 2 tiles with $FA at $66F0
B $8A27,5 Fill horz 3 tiles with $FA at $670B
B $8A2C,1 End of sequence
b $8A2D Room 8A2D
N $8A2D #HTML[<img src="images/rooms/8A2D.png" />]
W $8A2D,2,2 Room procedure
W $8A2F,2,2 Initialization
W $8A31,2,2 Room to Left
W $8A33,2,2 Room to Right
W $8A35,2,2 Room Up
W $8A37,2,2 Room Down
B $8A39,5 Fill vert 8 tiles with $3A at $66A2
B $8A3E,5 Fill vert 8 tiles with $3A at $66AD
B $8A43,5 Fill vert 8 tiles with $3A at $66B1
B $8A48,5 Fill vert 5 tiles with $3A at $6704
B $8A4D,5 Fill horz 3 tiles with $FF at $6590
B $8A52,5 Fill horz 15 tiles with $FA at $6680
B $8A57,5 Fill horz 5 tiles with $FA at $668F
B $8A5C,7 Block 2 tiles from #R$7348 to $65A1 copy 8 times
B $8A63,5 Fill horz 8 tiles with $FA at $6755
B $8A68,5 Fill horz 5 tiles with $FA at $66E2
B $8A6D,5 Fill horz 4 tiles with $FA at $6786
B $8A72,7 Block 1x3 tiles from #R$8899 to $66E3
B $8A79,7 Block 1x3 tiles from #R$8898 to $673D
B $8A80,1 End of sequence
b $8A81 Room 8A81
N $8A81 #HTML[<img src="images/rooms/8A81.png" />]
W $8A81,2,2 Room procedure
W $8A83,2,2 Initialization
W $8A85,2,2 Room to Left
W $8A87,2,2 Room to Right
W $8A89,2,2
W $8A8B,2,2 Room Down
B $8A8D,5 Fill vert 6 tiles with $3A at $66E1
B $8A92,5 Fill vert 12 tiles with $3A at $6633
B $8A97,5 Fill vert 5 tiles with $3A at $670A
B $8A9C,5 Triangle with $FF, count=4 at $65A7
B $8AA1,5 Triangle with $FF, count=4 at $65A8
B $8AA6,7 Block 2 tiles from #R$7348 to $6601 copy 14 times
B $8AAD,7 Block 2x1 tiles from #R$889D to $66F1
B $8AB4,7 Block 2x1 tiles from #R$889D to $674B
B $8ABB,5 Fill horz 5 tiles with $FA at $674D
B $8AC0,5 Fill horz 6 tiles with $FA at $66EB
B $8AC5,5 Fill horz 3 tiles with $FA at $66C1
B $8ACA,5 Fill vert 4 tiles with $28 at $710E
B $8ACF,5 Fill horz 11 tiles with $FA at $65B8
B $8AD4,7 Block 1x5 tiles from #R$8898 to $659D
B $8ADB,5 Fill horz 3 tiles with $FA at $66FF
B $8AE0,5 Fill horz 6 tiles with $FA at $671F
B $8AE5,7 Block 1x4 tiles from #R$8899 to $671E
B $8AEC,7 Block 1x2 tiles from #R$8898 to $66E2
B $8AF3,1 End of sequence
b $8AF4 Room 8AF4
N $8AF4 #HTML[<img src="images/rooms/8AF4.png" />]
W $8AF4,2,2 Room procedure
W $8AF6,2,2 Initialization
W $8AF8,2,2 Room to Left
W $8AFA,2,2 Room to Right
W $8AFC,2,2 Room Up
W $8AFE,2,2 Room Down
B $8B00,5 Fill vert 8 tiles with $3A at $66A7
B $8B05,5 Fill vert 8 tiles with $3A at $66AF
B $8B0A,5 Fill horz 11 tiles with $FA at $6734
B $8B0F,5 Fill horz 19 tiles with $FA at $6688
B $8B14,7 Block 2 tiles from #R$7348 to $65A4 copy 8 times
B $8B1B,5 Fill vert 6 tiles with $F9 at $668E
B $8B20,4 Put tile $F8 at $668E
B $8B24,1 End of sequence
b $8B25 Room 8B25
N $8B25 #HTML[<img src="images/rooms/8B25.png" />]
W $8B25,2,2 Room procedure
W $8B27,2,2 Initialization
W $8B29,2,2
W $8B2B,2,2 Room to Right
W $8B2D,2,2
W $8B2F,2,2 Room Down
B $8B31,5 Fill horz 30 tiles with $FF at $6770
B $8B36,5 Fill horz 72 tiles with $FF at $6590
B $8B3B,7 Block 2 tiles from #R$7348 to $65DD copy 14 times
B $8B42,7 Block 2x1 tiles from #R$7984 to $6781
B $8B49,7 Block 4x4 tiles from #R$71A9 to $70F7
B $8B50,7 Block 4x4 tiles from #R$71A9 to $70F5
B $8B57,7 Block 4x4 tiles from #R$71A9 to $70F0
B $8B5E,7 Block 4x4 tiles from #R$71A9 to $7107
B $8B65,5 Triangle with $FF, count=11 at $65EA
B $8B6A,6 Rectangle 3x4 tiles with $FF at $66F8
B $8B70,1 End of sequence
b $8B71 Room 8B71
N $8B71 #HTML[<img src="images/rooms/8B71.png" />]
W $8B71,2,2 Room procedure
W $8B73,2,2 Initialization
W $8B75,2,2 Room to Left
W $8B77,2,2 Room to Right
W $8B79,2,2
W $8B7B,2,2
B $8B7D,5 Fill horz 30 tiles with $FF at $6770
B $8B82,5 Fill horz 60 tiles with $FF at $6590
B $8B87,7 Block 4x4 tiles from #R$71A9 to $70EF
B $8B8E,7 Block 4x4 tiles from #R$71A9 to $70F5
B $8B95,7 Block 4x4 tiles from #R$71A9 to $70FB
B $8B9C,7 Block 4x4 tiles from #R$71A9 to $7100
B $8BA3,7 Block 4x4 tiles from #R$71A9 to $7107
B $8BAA,1 End of sequence
b $8BAB Room 8BAB
N $8BAB #HTML[<img src="images/rooms/8BAB.png" />]
W $8BAB,2,2 Room procedure
W $8BAD,2,2 Initialization
W $8BAF,2,2 Room to Left
W $8BB1,2,2
W $8BB3,2,2
W $8BB5,2,2 Room Down
B $8BB7,5 Fill horz 60 tiles with $FF at $6590
B $8BBC,6 Rectangle 2x14 tiles with $FF at $65E8
B $8BC2,5 Fill horz 9 tiles with $FF at $6770
B $8BC7,5 Fill horz 16 tiles with $FF at $677E
B $8BCC,7 Block 2 tiles from #R$7348 to $65E0 copy 14 times
B $8BD3,7 Block 2x1 tiles from #R$889D to $6784
B $8BDA,7 Block 3x3 tiles from #R$71A0 to $711B
B $8BE1,7 Block 4x4 tiles from #R$71A9 to $70F2
B $8BE8,7 Block 4x4 tiles from #R$71A9 to $7106
B $8BEF,1 End of sequence
b $8BF0 Room 8BF0
N $8BF0 #HTML[<img src="images/rooms/8BF0.png" />]
W $8BF0,2,2 Room procedure
W $8BF2,2,2 Initialization
W $8BF4,2,2 Room to Left
W $8BF6,2,2 Room to Right
W $8BF8,2,2
W $8BFA,2,2 Room Down
B $8BFC,5 Fill vert 16 tiles with $3A at $6593
B $8C01,5 Fill vert 8 tiles with $3A at $6598
B $8C06,5 Fill vert 8 tiles with $3A at $659C
B $8C0B,5 Fill vert 8 tiles with $3A at $65A0
B $8C10,5 Fill vert 8 tiles with $3A at $65A3
B $8C15,5 Fill vert 8 tiles with $3A at $65A7
B $8C1A,5 Fill vert 8 tiles with $3A at $65AB
B $8C1F,5 Fill horz 30 tiles with $FF at $6770
B $8C24,6 Rectangle 4x7 tiles with $FF at $66B8
B $8C2A,5 Fill horz 23 tiles with $FF at $6687
B $8C2F,7 Block 2 tiles from #R$7348 to $66B0 copy 7 times
B $8C36,7 Block 2x1 tiles from #R$7984 to $6782
B $8C3D,5 Fill horz 4 tiles with $FA at $6680
B $8C42,4 Put tile $F9 at $6595
B $8C46,5 Fill horz 6 tiles with $63 at $6631
B $8C4B,4 Put tile $2A at $709D
B $8C4F,5 Fill vert 6 tiles with $2B at $70BB
B $8C54,5 Fill vert 1 tiles with $FF at $6689
B $8C59,1 End of sequence
b $8C5A Room 8C5A
N $8C5A #HTML[<img src="images/rooms/8C5A.png" />]
W $8C5A,2,2 Room procedure
W $8C5C,2,2 Initialization
W $8C5E,2,2 Room to Left
W $8C60,2,2 Room to Right
W $8C62,2,2
W $8C64,2,2 Room Down
B $8C66,5 Fill vert 5 tiles with $3A at $66DD
B $8C6B,5 Fill vert 13 tiles with $3A at $65F2
B $8C70,5 Fill vert 15 tiles with $3A at $65D8
B $8C75,5 Fill vert 7 tiles with $3A at $66CC
B $8C7A,5 Fill vert 7 tiles with $3A at $66CF
B $8C7F,5 Fill vert 13 tiles with $3A at $661F
B $8C84,5 Fill vert 13 tiles with $3A at $6623
B $8C89,5 Triangle with $FF, count=3 at $65A6
B $8C8E,6 Rectangle 7x4 tiles with $FF at $65A7
B $8C94,5 Fill horz 10 tiles with $FA at $65B3
B $8C99,7 Block 1x3 tiles from #R$8898 to $6598
B $8CA0,5 Fill vert 3 tiles with $F9 at $671B
B $8CA5,5 Fill horz 7 tiles with $FA at $6773
B $8CAA,4 Put tile $F8 at $6775
B $8CAE,5 Fill horz 10 tiles with $FA at $66BD
B $8CB3,5 Fill horz 4 tiles with $FA at $66E5
B $8CB8,5 Fill horz 4 tiles with $FA at $66AE
B $8CBD,5 Fill horz 3 tiles with $FA at $66EF
B $8CC2,5 Fill horz 5 tiles with $FA at $672F
B $8CC7,1 End of sequence
b $8CC8 Room 8CC8
N $8CC8 #HTML[<img src="images/rooms/8CC8.png" />]
W $8CC8,2,2 Room procedure
W $8CCA,2,2 Initialization
W $8CCC,2,2 Room to Left
W $8CCE,2,2 Room to Right
W $8CD0,2,2
W $8CD2,2,2
B $8CD4,5 Fill vert 12 tiles with $3A at $6596
B $8CD9,5 Fill vert 16 tiles with $3A at $659E
B $8CDE,5 Fill vert 16 tiles with $3A at $65A3
B $8CE3,5 Fill vert 16 tiles with $3A at $65AA
B $8CE8,5 Triangle with $FF, count=7 at $66A1
B $8CED,5 Fill horz 30 tiles with $FF at $6770
B $8CF2,6 Rectangle 3x8 tiles with $FF at $6680
B $8CF8,5 Fill horz 6 tiles with $63 at $65F5
B $8CFD,5 Fill horz 10 tiles with $FA at $6692
B $8D02,7 Block 4x7 tiles from #R$79AA to $709B
B $8D09,7 Block 4x7 tiles from #R$79AA to $703E
B $8D10,7 Block 4x7 tiles from #R$79AA to $7000
B $8D17,1 End of sequence
b $8D18 Room 8D18
N $8D18 #HTML[<img src="images/rooms/8D18.png" />]
W $8D18,2,2 Room procedure
W $8D1A,2,2 Initialization
W $8D1C,2,2 Room to Left
W $8D1E,2,2 Room to Right
W $8D20,2,2 Room Up
W $8D22,2,2 Room Down
B $8D24,5 Fill vert 3 tiles with $3A at $673A
B $8D29,5 Fill vert 3 tiles with $3A at $6742
B $8D2E,5 Fill vert 3 tiles with $3A at $674E
B $8D33,5 Fill vert 17 tiles with $3A at $65A3
B $8D38,6 Rectangle 10x4 tiles with $FF at $6590
B $8D3E,7 Block 2 tiles from #R$7348 to $659A copy 13 times
B $8D45,5 Fill horz 18 tiles with $FA at $6716
B $8D4A,5 Fill horz 6 tiles with $FA at $672E
B $8D4F,5 Fill horz 5 tiles with $63 at $6674
B $8D54,7 Block 2x4 tiles from #R$71BB to $70A1
B $8D5B,1 End of sequence
b $8D5C Room 8D5C
N $8D5C #HTML[<img src="images/rooms/8D5C.png" />]
W $8D5C,2,2 Room procedure
W $8D5E,2,2 Initialization
W $8D60,2,2 Room to Left
W $8D62,2,2
W $8D64,2,2
W $8D66,2,2 Room Down
B $8D68,2 Fill entire screen with $01
B $8D6A,5 Fill horz 62 tiles with $FF at $6590
B $8D6F,6 Rectangle 2x4 tiles with $FF at $65EA
B $8D75,5 Fill horz 4 tiles with $FF at $6662
B $8D7A,5 Triangle with $FF, count=7 at $65E4
B $8D7F,6 Rectangle 5x12 tiles with $FF at $65E5
B $8D85,5 Fill horz 65 tiles with $FF at $674D
B $8D8A,7 Block 2x2 tiles from #R$7984 to $675C
B $8D91,7 Block 3x3 tiles from #R$71A0 to $70F2
B $8D98,7 Block 3x3 tiles from #R$71A0 to $70A3
B $8D9F,7 Block 3x3 tiles from #R$71A0 to $70A7
B $8DA6,7 Block 3x3 tiles from #R$71A0 to $70FC
B $8DAD,7 Block 3x3 tiles from #R$71A0 to $70FF
B $8DB4,7 Block 3x3 tiles from #R$71A0 to $7103
B $8DBB,5 Fill vert 1 tiles with $FF at $6664
B $8DC0,4 Put tile $2A at $7078
B $8DC4,5 Fill vert 6 tiles with $2B at $7096
B $8DC9,1 End of sequence
b $8DCA Room 8DCA (helicopter)
N $8DCA #HTML[<img src="images/rooms/8DCA.png" />]
W $8DCA,2,2 Room procedure
W $8DCC,2,2 Initialization
W $8DCE,2,2
W $8DD0,2,2 Room to Right
W $8DD2,2,2
W $8DD4,2,2
B $8DD6,2 Fill entire screen with $01
B $8DD8,5 Fill horz 63 tiles with $FF at $6590
B $8DDD,6 Rectangle 2x13 tiles with $FF at $65EA
B $8DE3,5 Fill horz 37 tiles with $FF at $6769
B $8DE8,5 Fill horz 10 tiles with $91 at $675A
B $8DED,5 Fill horz 23 tiles with $01 at $6593
B $8DF2,5 Fill horz 27 tiles with $E2 at $65AF
B $8DF7,4 Put tile $FF at $65E6
B $8DFB,6 Rectangle 3x6 tiles with $FF at $65E7
B $8E01,4 Put tile $2A at $7091
B $8E05,5 Fill vert 6 tiles with $2B at $70AF
B $8E0A,7 Block 4x7 tiles from #R$8E47 to $7063
B $8E11,7 Block 2x6 tiles from #R$8E6C to $6689
B $8E18,7 Block 5x1 tiles from #R$8E67 to $673E
B $8E1F,7 Block 1x2 tiles from #R$8E63 to $6706
B $8E26,7 Block 3x8 tiles from #R$8E78 to $6671
B $8E2D,5 Fill horz 17 tiles with $D4 at $662C
B $8E32,7 Block 1x2 tiles from #R$8E65 to $6634
B $8E39,7 Block 3x4 tiles from #R$8E90 to $6656
B $8E40,6 Rectangle 4x4 tiles with $1B at $668B
B $8E46,1 End of sequence
b $8E47 Blocks for rooms
B $8E47,28,4 #HTML[<img src="images/blocks/8e47.png" />] Front block 4x7
B $8E63,2,1 Block 1x2
B $8E65,2,1 Block 1x2
B $8E67,5,5 #HTML[<img src="images/blocks/8e67.png" />] Back block 5x1
B $8E6C,12,2 #HTML[<img src="images/blocks/8e6c.png" />] Back block 2x6
B $8E78,24,3 #HTML[<img src="images/blocks/8e78.png" />] Back block 3x8
B $8E90,12,3 #HTML[<img src="images/blocks/8e90.png" />] Back block 3x4
b $8E9C Room 8E9C
N $8E9C #HTML[<img src="images/rooms/8E9C.png" />]
W $8E9C,2,2 Room procedure
W $8E9E,2,2 Initialization
W $8EA0,2,2 Room to Left
W $8EA2,2,2
W $8EA4,2,2 Room Up
W $8EA6,2,2 Room Down
B $8EA8,5 Fill vert 16 tiles with $3A at $6591
B $8EAD,5 Fill vert 16 tiles with $3A at $6599
B $8EB2,5 Fill vert 16 tiles with $3A at $659C
B $8EB7,5 Fill vert 6 tiles with $3A at $66C1
B $8EBC,5 Fill vert 7 tiles with $3A at $66CF
B $8EC1,5 Fill vert 7 tiles with $3A at $66D3
B $8EC6,5 Fill horz 14 tiles with $FF at $6770
B $8ECB,5 Fill horz 8 tiles with $FA at $66A1
B $8ED0,5 Fill horz 6 tiles with $FA at $66B1
B $8ED5,5 Fill horz 4 tiles with $FA at $6745
B $8EDA,6 Rectangle 2x17 tiles with $FF at $65AC
B $8EE0,1 End of sequence
b $8EE1 Room 8EE1
N $8EE1 #HTML[<img src="images/rooms/8EE1.png" />]
W $8EE1,2,2 Room procedure
W $8EE3,2,2 Initialization
W $8EE5,2,2 Room to Left
W $8EE7,2,2
W $8EE9,2,2
W $8EEB,2,2 Room Down
B $8EED,5 Fill vert 3 tiles with $3A at $6735
B $8EF2,5 Fill vert 15 tiles with $3A at $65D5
B $8EF7,4 Put tile $3A at $677C
B $8EFB,4 Put tile $FF at $6593
B $8EFF,6 Rectangle 26x2 tiles with $FF at $6594
B $8F05,6 Rectangle 2x15 tiles with $FF at $65E8
B $8F0B,5 Triangle with $FF, count=7 at $65E7
B $8F10,5 Fill horz 4 tiles with $FA at $6716
B $8F15,5 Fill horz 7 tiles with $FA at $675B
B $8F1A,5 Fill horz 4 tiles with $63 at $66E0
B $8F1F,1 End of sequence
b $8F20 Room 8F20
N $8F20 #HTML[<img src="images/rooms/8F20.png" />]
W $8F20,2,2 Room procedure
W $8F22,2,2 Initialization
W $8F24,2,2 Room to Left
W $8F26,2,2
W $8F28,2,2 Room Up
W $8F2A,2,2 Room Down
B $8F2C,5 Fill horz 14 tiles with $FF at $6590
B $8F31,5 Fill vert 1 tiles with $FF at $6596
B $8F36,4 Put tile $2A at $6FAA
B $8F3A,4 Put tile $2A at $6FAF
B $8F3E,5 Fill vert 7 tiles with $2B at $6FC8
B $8F43,5 Fill vert 7 tiles with $2B at $6FCD
B $8F48,6 Rectangle 2x9 tiles with $FF at $65AC
B $8F4E,6 Rectangle 30x8 tiles with $FF at $669E
B $8F54,7 Block 2x2 tiles from #R$7984 to $676A
B $8F5B,6 Rectangle 8x6 tiles with $00 at $66B2
B $8F61,5 Triangle with $00, count=5 at $66B1
B $8F66,7 Block 4x7 tiles from #R$79AA to $7087
B $8F6D,7 Block 4x7 tiles from #R$79AA to $702A
B $8F74,5 Fill vert 14 tiles with $3A at $65A3
B $8F79,5 Fill vert 15 tiles with $3A at $65A7
B $8F7E,5 Fill horz 5 tiles with $FA at $6697
B $8F83,1 End of sequence
b $8F84 Room 8F84
N $8F84 #HTML[<img src="images/rooms/8F84.png" />]
W $8F84,2,2 Room procedure
W $8F86,2,2 Initialization
W $8F88,2,2 Room to Left
W $8F8A,2,2
W $8F8C,2,2 Room Up
W $8F8E,2,2 Room Down
B $8F90,2 Fill entire screen with $FF
B $8F92,6 Rectangle 28x8 tiles with $00 at $6626
B $8F98,5 Triangle with $00, count=4 at $65C5
B $8F9D,6 Rectangle 2x3 tiles with $00 at $65E6
B $8FA3,4 Put tile $00 at $65C8
B $8FA7,7 Block 2x4 tiles from #R$71BB to $70A2
B $8FAE,7 Block 2 tiles from #R$7348 to $65A8 copy 13 times
B $8FB5,7 Block 2x4 tiles from #R$7984 to $672A
B $8FBC,1 End of sequence
b $8FBD Room 8FBD
N $8FBD #HTML[<img src="images/rooms/8FBD.png" />]
W $8FBD,2,2 Room procedure
W $8FBF,2,2 Initialization
W $8FC1,2,2 Room to Left
W $8FC3,2,2 Room to Right
W $8FC5,2,2
W $8FC7,2,2 Room Down
B $8FC9,6 Rectangle 30x8 tiles with $FF at $669E
B $8FCF,6 Rectangle 7x7 tiles with $39 at $66C5
B $8FD5,5 Fill horz 5 tiles with $38 at $66A8
B $8FDA,5 Fill horz 6 tiles with $FF at $6590
B $8FDF,5 Fill horz 4 tiles with $FF at $65AA
B $8FE4,4 Put tile $2A at $6FA5
B $8FE8,4 Put tile $2A at $6FBF
B $8FEC,5 Fill vert 7 tiles with $2B at $6FC3
B $8FF1,5 Fill vert 7 tiles with $2B at $6FDD
B $8FF6,7 Block 2x4 tiles from #R$71BB to $701F
B $8FFD,7 Block 2x4 tiles from #R$71BB to $7031
B $9004,1 End of sequence
b $9005 Room 9005
N $9005 #HTML[<img src="images/rooms/9005.png" />]
W $9005,2,2 Room procedure
W $9007,2,2 Initialization
W $9009,2,2 Room to Left
W $900B,2,2 Room to Right
W $900D,2,2 Room Up
W $900F,2,2
B $9011,5 Fill horz 30 tiles with $FF at $6590
B $9016,7 Block 2x4 tiles from #R$71BB to $7033
B $901D,7 Block 2 tiles from #R$7348 to $65C0 copy 8 times
B $9024,7 Block 2x1 tiles from #R$7984 to $65A2
B $902B,4 Put tile $2A at $6FB1
B $902F,5 Fill vert 7 tiles with $2B at $6FCF
B $9034,6 Rectangle 19x5 tiles with $FF at $66A9
B $903A,5 Fill horz 79 tiles with $FF at $673F
B $903F,5 Triangle with $FF, count=5 at $66C6
B $9044,7 Block 4x7 tiles from #R$798E to $707B
B $904B,7 Block 4x7 tiles from #R$798E to $7024
B $9052,1 End of sequence
b $9053 Room 9053
N $9053 #HTML[<img src="images/rooms/9053.png" />]
W $9053,2,2 Room procedure
W $9055,2,2 Initialization
W $9057,2,2 Room to Left
W $9059,2,2 Room to Right
W $905B,2,2 Room Up
W $905D,2,2 Room Down
B $905F,6 Rectangle 30x9 tiles with $FF at $6590
B $9065,6 Rectangle 10x4 tiles with $00 at $663A
B $906B,5 Fill horz 39 tiles with $FF at $6767
B $9070,5 Fill horz 4 tiles with $FF at $6730
B $9075,5 Fill horz 6 tiles with $FF at $674C
B $907A,7 Block 2x4 tiles from #R$71BB to $70F1
B $9081,7 Block 2x4 tiles from #R$71BB to $70E5
B $9088,6 Rectangle 7x8 tiles with $39 at $6599
B $908E,6 Rectangle 4x7 tiles with $39 at $66A7
B $9094,5 Fill horz 4 tiles with $38 at $6779
B $9099,5 Fill horz 4 tiles with $38 at $6689
B $909E,1 End of sequence
b $909F Room 909F
N $909F #HTML[<img src="images/rooms/909F.png" />]
W $909F,2,2 Room procedure
W $90A1,2,2 Initialization
W $90A3,2,2 Room to Left
W $90A5,2,2 Room to Right
W $90A7,2,2
W $90A9,2,2
B $90AB,5 Fill horz 30 tiles with $FF at $6590
B $90B0,5 Triangle with $FF, count=8 at $65CB
B $90B5,6 Rectangle 5x9 tiles with $FF at $6662
B $90BB,5 Fill horz 30 tiles with $FF at $6770
B $90C0,5 Triangle with $FF, count=8 at $6685
B $90C5,7 Block 4x7 tiles from #R$79AA to $709E
B $90CC,7 Block 4x7 tiles from #R$79AA to $7041
B $90D3,7 Block 4x7 tiles from #R$79AA to $6FE4
B $90DA,1 End of sequence
b $90DB Room 90DB
N $90DB #HTML[<img src="images/rooms/90DB.png" />]
W $90DB,2,2 Room procedure
W $90DD,2,2 Initialization
W $90DF,2,2 Room to Left
W $90E1,2,2 Room to Right
W $90E3,2,2 Room Up
W $90E5,2,2
B $90E7,2 Fill entire screen with $FF
B $90E9,6 Rectangle 22x6 tiles with $00 at $65D4
B $90EF,5 Fill horz 12 tiles with $00 at $65C0
B $90F4,5 Triangle with $00, count=7 at $6692
B $90F9,6 Rectangle 18x6 tiles with $00 at $669E
B $90FF,5 Fill horz 4 tiles with $39 at $6599
B $9104,5 Fill horz 4 tiles with $38 at $65B7
B $9109,7 Block 3x3 tiles from #R$7C18 to $70F5
B $9110,7 Block 3x3 tiles from #R$7C18 to $70F9
B $9117,4 Put tile $2A at $7095
B $911B,5 Fill vert 5 tiles with $2B at $70B3
B $9120,4 Put tile $2A at $70A4
B $9124,5 Fill vert 5 tiles with $2B at $70C2
B $9129,7 Block 4x7 tiles from #R$798E to $7088
B $9130,7 Block 4x7 tiles from #R$798E to $7031
B $9137,7 Block 4x7 tiles from #R$798E to $7014
B $913E,1 End of sequence
b $913F Room 913F
N $913F #HTML[<img src="images/rooms/913F.png" />]
W $913F,2,2 Room procedure
W $9141,2,2 Initialization
W $9143,2,2
W $9145,2,2 Room to Right
W $9147,2,2
W $9149,2,2 Room Down
B $914B,5 Triangle with $FF, count=9 at $65AD
B $9150,5 Fill horz 39 tiles with $FF at $6767
B $9155,5 Fill horz 5 tiles with $FF at $6590
B $915A,6 Rectangle 3x3 tiles with $FF at $65AE
B $9160,5 Fill vert 12 tiles with $EB at $6609
B $9165,7 Block 2x1 tiles from #R$7984 to $6779
B $916C,7 Block 3x3 tiles from #R$71A0 to $710E
B $9173,7 Block 3x3 tiles from #R$7C18 to $7111
B $917A,7 Block 2x1 tiles from #R$7E8A to $714E
B $9181,7 Block 3x4 tiles from #R$7C0C to $70FE
B $9188,7 Block 3x1 tiles from #R$7E87 to $713A
B $918F,7 Block 3x1 tiles from #R$7E87 to $7156
B $9196,7 Block 2x1 tiles from #R$7E8A to $7137
B $919D,7 Block 2x1 tiles from #R$7E8A to $7154
B $91A4,7 Block 2x1 tiles from #R$7E8A to $715A
B $91AB,7 Block 2x1 tiles from #R$7E8A to $7140
B $91B2,7 Block 2x1 tiles from #R$7E8A to $7143
B $91B9,1 End of sequence
b $91BA Room 91BA
N $91BA #HTML[<img src="images/rooms/91BA.png" />]
W $91BA,2,2 Room procedure
W $91BC,2,2 Initialization
W $91BE,2,2 Room to Left
W $91C0,2,2
W $91C2,2,2 Room Up
W $91C4,2,2 Room Down
B $91C6,5 Fill horz 4 tiles with $FF at $6590
B $91CB,4 Put tile $2A at $6FA5
B $91CF,5 Fill vert 7 tiles with $2B at $6FC3
B $91D4,6 Rectangle 4x3 tiles with $FF at $669E
B $91DA,5 Fill horz 152 tiles with $FF at $66F6
B $91DF,7 Block 2 tiles from #R$81E3 to $65AC copy 11 times
B $91E6,5 Triangle with $FF, count=2 at $66C0
B $91EB,7 Block 2 tiles from #R$7348 to $65A4 copy 12 times
B $91F2,7 Block 2x5 tiles from #R$7984 to $670C
B $91F9,7 Block 3x3 tiles from #R$7C18 to $709B
B $9200,3 Barrel 3x3 tiles at $709F
B $9203,3 Barrel 3x3 tiles at $70A2
B $9206,3 Barrel 3x3 tiles at $70AD
B $9209,1 End of sequence
b $920A Room 920A
N $920A #HTML[<img src="images/rooms/920A.png" />]
W $920A,2,2 Room procedure
W $920C,2,2 Initialization
W $920E,2,2 Room to Left
W $9210,2,2 Room to Right
W $9212,2,2
W $9214,2,2
B $9216,5 Fill horz 30 tiles with $FF at $6770
B $921B,7 Block 3x4 tiles from #R$7C0C to $70F1
B $9222,7 Block 3x3 tiles from #R$71A0 to $7113
B $9229,3 Barrel 3x3 tiles at $7117
B $922C,3 Barrel 3x3 tiles at $711A
B $922F,3 Barrel 3x3 tiles at $70BE
B $9232,3 Barrel 3x3 tiles at $70C1
B $9235,3 Barrel 3x3 tiles at $7126
B $9238,7 Block 4x3 tiles from #R$7E7B to $70C4
B $923F,7 Block 4x3 tiles from #R$7E7B to $711B
B $9246,7 Block 4x3 tiles from #R$7E7B to $7120
B $924D,1 End of sequence
b $924E Room 924E
N $924E #HTML[<img src="images/rooms/924E.png" />]
W $924E,2,2 Room procedure
W $9250,2,2 Initialization
W $9252,2,2 Room to Left
W $9254,2,2
W $9256,2,2 Room Up
W $9258,2,2
B $925A,5 Fill horz 16 tiles with $FF at $659E
B $925F,7 Block 2 tiles from #R$81E3 to $65CA copy 14 times
B $9266,5 Fill horz 32 tiles with $FF at $676E
B $926B,7 Block 2 tiles from #R$7348 to $65C2 copy 15 times
B $9272,7 Block 2x1 tiles from #R$71B9 to $65A4
B $9279,7 Block 3x3 tiles from #R$71A0 to $711C
B $9280,7 Block 3x3 tiles from #R$71A0 to $70CB
B $9287,7 Block 4x3 tiles from #R$7E7B to $7124
B $928E,3 Barrel 3x3 tiles at $705D
B $9291,3 Barrel 3x3 tiles at $70B5
B $9294,3 Barrel 3x3 tiles at $70B9
B $9297,3 Barrel 3x3 tiles at $70BC
B $929A,3 Barrel 3x3 tiles at $710E
B $929D,3 Barrel 3x3 tiles at $7111
B $92A0,3 Barrel 3x3 tiles at $7114
B $92A3,3 Barrel 3x3 tiles at $7118
B $92A6,1 End of sequence
b $92A7 Room 92A7
N $92A7 #HTML[<img src="images/rooms/92A7.png" />]
N $92A7 3rd console: flips trigger "A": set/remove wall in room #R$7F48.
W $92A7,2,2 Room procedure
W $92A9,2,2 Initialization
W $92AB,2,2
W $92AD,2,2 Room to Right
W $92AF,2,2
W $92B1,2,2
B $92B3,5 Fill horz 32 tiles with $FF at $6590
B $92B8,7 Block 2 tiles from #R$81E3 to $65CC copy 13 times
B $92BF,5 Fill horz 60 tiles with $FF at $6752
B $92C4,7 Block 4x4 tiles from #R$71A9 to $70D1
B $92CB,7 Block 4x4 tiles from #R$71A9 to $70E1
B $92D2,7 Block 2x4 tiles from #R$71BB to $70D6
B $92D9,7 Block 2x4 tiles from #R$71BB to $70D8
B $92E0,7 Block 2x4 tiles from #R$71BB to $70DB
B $92E7,7 Block 2x4 tiles from #R$71BB to $70DE
B $92EE,1 End of sequence
b $92EF Room 92EF
N $92EF #HTML[<img src="images/rooms/92EF.png" />]
N $92EF 1st conosole: flips trigger "C": set/remove wall in room #R$8D5C.
W $92EF,2,2 Room procedure
W $92F1,2,2 Initialization
W $92F3,2,2
W $92F5,2,2 Room to Right
W $92F7,2,2
W $92F9,2,2
B $92FB,2 Fill entire screen with $FF
B $92FD,6 Rectangle 26x6 tiles with $00 at $65B2
B $9303,6 Rectangle 22x6 tiles with $02 at $66DE
B $9309,6 Rectangle 6x4 tiles with $CC at $671C
B $930F,5 Fill horz 7 tiles with $D1 at $6738
B $9314,4 Put tile $D0 at $673D
B $9318,5 Fill horz 12 tiles with $CD at $6722
B $931D,7 Block 1x4 tiles from #R$9372 to $6724
B $9324,7 Block 1x4 tiles from #R$9372 to $6726
B $932B,7 Block 1x4 tiles from #R$9372 to $6728
B $9332,7 Block 1x4 tiles from #R$9372 to $672A
B $9339,7 Block 1x4 tiles from #R$9372 to $672C
B $9340,7 Block 1x4 tiles from #R$9372 to $672E
B $9347,7 Block 4x4 tiles from #R$71A9 to $6FE1
B $934E,7 Block 2x4 tiles from #R$71BB to $6FE6
B $9355,7 Block 2x4 tiles from #R$71BB to $6FE9
B $935C,7 Block 2x4 tiles from #R$71BB to $6FEC
B $9363,7 Block 2x4 tiles from #R$71BB to $6FEF
B $936A,7 Block 2x4 tiles from #R$71BB to $6FF2
B $9371,1 End of sequence
b $9372 Blocks for rooms
B $9372,4,1 #HTML[<img src="images/blocks/9372.png" />] Back block 1x4
b $9376 Room 9376
N $9376 #HTML[<img src="images/rooms/9376.png" />]
W $9376,2,2 Room procedure
W $9378,2,2 Initialization
W $937A,2,2 Room to Left
W $937C,2,2
W $937E,2,2 Room Up
W $9380,2,2
B $9382,2 Fill entire screen with $FF
B $9384,6 Rectangle 12x6 tiles with $02 at $6680
B $938A,6 Rectangle 11x6 tiles with $02 at $6690
B $9390,5 Fill horz 12 tiles with $03 at $6662
B $9395,5 Fill horz 11 tiles with $03 at $6672
B $939A,6 Rectangle 11x2 tiles with $0C at $70FE
B $93A0,5 Fill horz 11 tiles with $0B at $70E0
B $93A5,7 Block 2 tiles from #R$71B9 to $6594 copy 14 times
B $93AC,7 Block 2 tiles from #R$71B9 to $65A4 copy 14 times
B $93B3,7 Block 6x2 tiles from #R$7188 to $70F3
B $93BA,5 Fill vert 7 tiles with $FD at $659A
B $93BF,5 Fill vert 7 tiles with $FD at $65A2
B $93C4,5 Fill vert 7 tiles with $FD at $65A9
B $93C9,7 Block 1x3 tiles from #R$7B4F to $6736
B $93D0,7 Block 1x3 tiles from #R$7B4F to $673A
B $93D7,7 Block 1x3 tiles from #R$7B4F to $673E
B $93DE,1 End of sequence
b $93DF Room 93DF
N $93DF #HTML[<img src="images/rooms/93DF.png" />]
W $93DF,2,2 Room procedure
W $93E1,2,2 Initialization
W $93E3,2,2 Room to Left
W $93E5,2,2 Room to Right
W $93E7,2,2 Room Up
W $93E9,2,2
B $93EB,2 Fill entire screen with $02
B $93ED,6 Rectangle 5x2 tiles with $21 at $6716
B $93F3,5 Fill horz 4 tiles with $03 at $667C
B $93F8,5 Fill horz 153 tiles with $FF at $6590
B $93FD,5 Fill horz 16 tiles with $FF at $6636
B $9402,5 Fill horz 4 tiles with $FF at $665E
B $9407,5 Fill horz 17 tiles with $FF at $671B
B $940C,5 Fill horz 86 tiles with $FF at $6738
B $9411,7 Block 2 tiles from #R$71B9 to $6596 copy 13 times
B $9418,5 Fill vert 5 tiles with $FD at $659E
B $941D,5 Fill vert 6 tiles with $FD at $65A7
B $9422,7 Block 1x4 tiles from #R$7B4F to $6724
B $9429,7 Block 1x3 tiles from #R$7B4F to $674B
B $9430,1 End of sequence
b $9431 Room 9431
N $9431 #HTML[<img src="images/rooms/9431.png" />]
W $9431,2,2 Room procedure
W $9433,2,2 Initialization
W $9435,2,2
W $9437,2,2
W $9439,2,2 Room Up
W $943B,2,2 Room Down
B $943D,2 Fill entire screen with $FF
B $943F,7 Block 2 tiles from #R$71B9 to $6596 copy 17 times
B $9446,5 Fill vert 17 tiles with $FD at $659E
B $944B,5 Fill vert 17 tiles with $FD at $65A7
B $9450,1 End of sequence
b $9451 Room 9451
N $9451 #HTML[<img src="images/rooms/9451.png" />]
W $9451,2,2 Room procedure
W $9453,2,2 Initialization
W $9455,2,2
W $9457,2,2
W $9459,2,2
W $945B,2,2 Room Down
B $945D,2 Fill entire screen with $FF
B $945F,7 Block 2x4 tiles from #R$7984 to $671C
B $9466,5 Fill vert 17 tiles with $FD at $659E
B $946B,5 Fill vert 17 tiles with $FD at $65A7
B $9470,6 Rectangle 24x6 tiles with $02 at $6665
B $9476,5 Fill horz 24 tiles with $03 at $6647
B $947B,1 End of sequence
b $947C Room 947C
N $947C #HTML[<img src="images/rooms/947C.png" />]
W $947C,2,2 Room procedure
W $947E,2,2 Initialization
W $9480,2,2 Room to Left
W $9482,2,2 Room to Right
W $9484,2,2
W $9486,2,2
B $9488,2 Fill entire screen with $FF
B $948A,6 Rectangle 21x7 tiles with $02 at $6626
B $9490,6 Rectangle 7x6 tiles with $02 at $6679
B $9496,5 Fill vert 8 tiles with $02 at $663B
B $949B,5 Fill vert 7 tiles with $02 at $665A
B $94A0,5 Fill horz 8 tiles with $21 at $672C
B $94A5,5 Fill horz 7 tiles with $21 at $674B
B $94AA,1 End of sequence
b $94AB Room 94AB
N $94AB #HTML[<img src="images/rooms/94AB.png" />]
W $94AB,2,2 Room procedure
W $94AD,2,2 Initialization
W $94AF,2,2 Room to Left
W $94B1,2,2 Room to Right
W $94B3,2,2
W $94B5,2,2
B $94B7,2 Fill entire screen with $FF
B $94B9,6 Rectangle 30x7 tiles with $00 at $6626
B $94BF,6 Rectangle 2x7 tiles with $02 at $6642
B $94C5,4 Put tile $2A at $7037
B $94C9,5 Fill vert 6 tiles with $2B at $7055
B $94CE,1 End of sequence
b $94CF Room 94CF
N $94CF #HTML[<img src="images/rooms/94CF.png" />]
W $94CF,2,2 Room procedure
W $94D1,2,2 Initialization
W $94D3,2,2 Room to Left
W $94D5,2,2 Room to Right
W $94D7,2,2
W $94D9,2,2
B $94DB,5 Fill horz 60 tiles with $FF at $6752
B $94E0,6 Rectangle 18x7 tiles with $0D at $6680
B $94E6,6 Rectangle 27x2 tiles with $A3 at $6590
B $94EC,4 Put tile $9C at $65AB
B $94F0,4 Put tile $9B at $65C9
B $94F4,6 Rectangle 18x6 tiles with $BF at $65CC
B $94FA,7 Block 2x4 tiles from #R$71BB to $70E8
B $9501,5 Fill horz 18 tiles with $BA at $65CC
B $9506,5 Fill horz 18 tiles with $B3 at $6662
B $950B,7 Block 1x6 tiles from #R$9528 to $65CD
B $9512,7 Block 1x6 tiles from #R$952E to $65D4
B $9519,7 Block 2x6 tiles from #R$9534 to $65DA
B $9520,7 Block 3x6 tiles from #R$9540 to $65DE
B $9527,1 End of sequence
b $9528 Blocks for rooms
B $9528,6,1 #HTML[<img src="images/blocks/9528.png" />] Back block 1x6
B $952E,6,1 #HTML[<img src="images/blocks/952e.png" />] Back block 1x6
B $9534,12,2 #HTML[<img src="images/blocks/9534.png" />] Back block 2x6
B $9540,18,3 #HTML[<img src="images/blocks/9540.png" />] Back block 3x6
b $9552 Room 9552
N $9552 #HTML[<img src="images/rooms/9552.png" />]
W $9552,2,2 Room procedure
W $9554,2,2 Initialization
W $9556,2,2 Room to Left
W $9558,2,2 Room to Right
W $955A,2,2
W $955C,2,2
B $955E,5 Fill horz 60 tiles with $FF at $6752
B $9563,6 Rectangle 18x7 tiles with $0D at $668C
B $9569,6 Rectangle 27x2 tiles with $A3 at $6593
B $956F,4 Put tile $9E at $6592
B $9573,4 Put tile $9D at $65B0
B $9577,6 Rectangle 18x6 tiles with $BF at $65D8
B $957D,7 Block 2x4 tiles from #R$71BB to $70DD
B $9584,7 Block 2x4 tiles from #R$71BB to $70E3
B $958B,5 Fill horz 18 tiles with $BA at $65D8
B $9590,5 Fill horz 18 tiles with $B3 at $666E
B $9595,7 Block 1x6 tiles from #R$9528 to $65E8
B $959C,7 Block 1x6 tiles from #R$95B2 to $65E1
B $95A3,7 Block 2x6 tiles from #R$95B8 to $65DA
B $95AA,7 Block 3x6 tiles from #R$95C4 to $65D5
B $95B1,1 End of sequence
b $95B2 Blocks for rooms
B $95B2,6,1 #HTML[<img src="images/blocks/95b2.png" />] Back block 1x6
B $95B8,12,2 #HTML[<img src="images/blocks/95b8.png" />] Back block 2x6
B $95C4,18,3 #HTML[<img src="images/blocks/95c4.png" />] Back block 3x6
b $95D6 Room 95D6
N $95D6 #HTML[<img src="images/rooms/95D6.png" />]
W $95D6,2,2 Room procedure
W $95D8,2,2 Initialization
W $95DA,2,2 Room to Left
W $95DC,2,2 Room to Right
W $95DE,2,2
W $95E0,2,2
B $95E2,5 Fill horz 150 tiles with $FF at $6590
B $95E7,6 Rectangle 16x5 tiles with $FF at $6706
B $95ED,5 Fill horz 7 tiles with $00 at $6706
B $95F2,5 Fill horz 16 tiles with $FA at $6716
B $95F7,1 End of sequence
b $95F8 Room 95F8
N $95F8 #HTML[<img src="images/rooms/95F8.png" />]
W $95F8,2,2 Room procedure
W $95FA,2,2 Initialization
W $95FC,2,2
W $95FE,2,2 Room to Right
W $9600,2,2
W $9602,2,2 Room Down
B $9604,2 Fill entire screen with $FF
B $9606,6 Rectangle 23x8 tiles with $00 at $662D
B $960C,5 Triangle with $FF, count=3 at $662D
B $9611,5 Fill horz 12 tiles with $FA at $6728
B $9616,5 Fill horz 10 tiles with $00 at $6748
B $961B,5 Fill horz 22 tiles with $00 at $675A
B $9620,5 Fill horz 24 tiles with $00 at $6776
B $9625,7 Block 2 tiles from #R$7348 to $6634 copy 12 times
B $962C,7 Block 2x1 tiles from #R$889D to $6724
B $9633,1 End of sequence
b $9634 Room 9634
N $9634 #HTML[<img src="images/rooms/9634.png" />]
W $9634,2,2 Room procedure
W $9636,2,2 Initialization
W $9638,2,2
W $963A,2,2 Room to Right
W $963C,2,2 Room Up
W $963E,2,2 Room Down
B $9640,6 Rectangle 4x13 tiles with $FF at $6590
B $9646,6 Rectangle 24x4 tiles with $FF at $671C
B $964C,5 Triangle with $FF, count=5 at $6684
B $9651,4 Put tile $00 at $6684
B $9655,5 Triangle with $FF, count=3 at $671B
B $965A,7 Block 2x2 tiles from #R$9686 to $6752
B $9661,7 Block 2 tiles from #R$7348 to $659E copy 13 times
B $9668,5 Fill horz 12 tiles with $00 at $6728
B $966D,5 Fill horz 12 tiles with $00 at $6762
B $9672,5 Fill horz 16 tiles with $00 at $677C
B $9677,7 Block 2 tiles from #R$7348 to $676B copy 2 times
B $967E,7 Block 2x1 tiles from #R$889D to $674D
B $9685,1 End of sequence
b $9686 Blocks for rooms
B $9686,4,2 #HTML[<img src="images/blocks/9686.png" />] Back block 2x2
b $968A Room 968A
N $968A #HTML[<img src="images/rooms/968A.png" />]
W $968A,2,2 Room procedure
W $968C,2,2 Initialization
W $968E,2,2 Room to Left
W $9690,2,2 Room to Right
W $9692,2,2
W $9694,2,2 Room Down
B $9696,6 Rectangle 16x5 tiles with $FF at $659E
B $969C,5 Fill vert 12 tiles with $3A at $6640
B $96A1,6 Rectangle 11x2 tiles with $FF at $6752
B $96A7,5 Fill horz 16 tiles with $FF at $6734
B $96AC,5 Fill horz 9 tiles with $FA at $6744
B $96B1,5 Fill horz 6 tiles with $FA at $676A
B $96B6,7 Block 2x4 tiles from #R$71BB to $70B6
B $96BD,7 Block 2 tiles from #R$7348 to $675E copy 2 times
B $96C4,7 Block 2x1 tiles from #R$889D to $6740
B $96CB,1 End of sequence
b $96CC Room 96CC
N $96CC #HTML[<img src="images/rooms/96CC.png" />]
W $96CC,2,2 Room procedure
W $96CE,2,2 Initialization
W $96D0,2,2 Room to Left
W $96D2,2,2
W $96D4,2,2
W $96D6,2,2 Room Down
B $96D8,5 Fill horz 150 tiles with $FF at $6590
B $96DD,6 Rectangle 15x12 tiles with $FF at $6635
B $96E3,5 Triangle with $FF, count=9 at $6634
B $96E8,5 Fill vert 12 tiles with $3A at $6627
B $96ED,5 Fill horz 4 tiles with $FA at $6752
B $96F2,1 End of sequence
b $96F3 Room 96F3
N $96F3 #HTML[<img src="images/rooms/96F3.png" />]
W $96F3,2,2 Room procedure
W $96F5,2,2 Initialization
W $96F7,2,2 Room to Left
W $96F9,2,2
W $96FB,2,2
W $96FD,2,2 Room Down
B $96FF,6 Rectangle 15x17 tiles with $FF at $659F
B $9705,5 Fill vert 17 tiles with $3A at $6591
B $970A,5 Fill vert 10 tiles with $3A at $6668
B $970F,5 Fill horz 9 tiles with $FA at $6680
B $9714,1 End of sequence
b $9715 Room 9715
N $9715 #HTML[<img src="images/rooms/9715.png" />]
W $9715,2,2 Room procedure
W $9717,2,2 Initialization
W $9719,2,2
W $971B,2,2 Room to Right
W $971D,2,2 Room Up
W $971F,2,2 Room Down
B $9721,6 Rectangle 11x17 tiles with $FF at $6590
B $9727,7 Block 2 tiles from #R$7348 to $659C copy 17 times
B $972E,5 Fill vert 17 tiles with $3A at $65AA
B $9733,5 Fill horz 8 tiles with $FA at $6696
B $9738,1 End of sequence
b $9739 Room 9739
N $9739 #HTML[<img src="images/rooms/9739.png" />]
W $9739,2,2 Room procedure
W $973B,2,2 Initialization
W $973D,2,2 Room to Left
W $973F,2,2 Room to Right
W $9741,2,2 Room Up
W $9743,2,2 Room Down
B $9745,6 Rectangle 11x10 tiles with $FF at $6590
B $974B,5 Triangle with $00, count=6 at $6612
B $9750,5 Fill horz 34 tiles with $FF at $676C
B $9755,5 Fill vert 1 tiles with $E4 at $66A0
B $975A,5 Fill vert 15 tiles with $3A at $65AA
B $975F,7 Block 2x1 tiles from #R$889D to $6776
B $9766,7 Block 2 tiles from #R$7348 to $659C copy 16 times
B $976D,1 End of sequence
b $976E Room 976E
N $976E #HTML[<img src="images/rooms/976E.png" />]
W $976E,2,2 Room procedure
W $9770,2,2 Initialization
W $9772,2,2 Room to Left
W $9774,2,2
W $9776,2,2
W $9778,2,2
B $977A,2 Fill entire screen with $FF
B $977C,6 Rectangle 15x8 tiles with $00 at $6590
B $9782,6 Rectangle 7x7 tiles with $00 at $6680
B $9788,5 Fill horz 6 tiles with $00 at $6687
B $978D,5 Fill horz 4 tiles with $00 at $66A5
B $9792,5 Fill horz 2 tiles with $00 at $66C3
B $9797,5 Fill vert 15 tiles with $3A at $6591
B $979C,5 Fill vert 15 tiles with $3A at $6596
B $97A1,4 Put tile $FA at $66E0
B $97A5,1 End of sequence
b $97A6 Room 97A6
N $97A6 #HTML[<img src="images/rooms/97A6.png" />]
W $97A6,2,2 Room procedure
W $97A8,2,2 Initialization
W $97AA,2,2 Room to Left
W $97AC,2,2 Room to Right
W $97AE,2,2 Room Up
W $97B0,2,2
B $97B2,6 Rectangle 9x7 tiles with $FF at $6680
B $97B8,5 Fill horz 60 tiles with $FF at $6752
B $97BD,5 Triangle with $FF, count=6 at $66A7
B $97C2,7 Block 2 tiles from #R$7348 to $6596 copy 8 times
B $97C9,6 Rectangle 4x8 tiles with $FF at $65AA
B $97CF,4 Put tile $00 at $6731
B $97D3,4 Put tile $2A at $7091
B $97D7,5 Fill vert 6 tiles with $2B at $70AF
B $97DC,7 Block 4x7 tiles from #R$79AA to $7082
B $97E3,7 Block 4x7 tiles from #R$79AA to $7025
B $97EA,7 Block 4x7 tiles from #R$79AA to $7006
B $97F1,6 Rectangle 2x7 tiles with $02 at $669C
B $97F7,1 End of sequence
b $97F8 Room 97F8
N $97F8 #HTML[<img src="images/rooms/97F8.png" />]
W $97F8,2,2 Room procedure
W $97FA,2,2 Initialization
W $97FC,2,2 Room to Left
W $97FE,2,2
W $9800,2,2
W $9802,2,2 Room Down
B $9804,2 Fill entire screen with $FF
B $9806,6 Rectangle 28x7 tiles with $02 at $6680
B $980C,6 Rectangle 16x4 tiles with $02 at $660E
B $9812,5 Triangle with $02, count=3 at $662B
B $9817,5 Triangle with $02, count=3 at $663C
B $981C,7 Block 2 tiles from #R$71B9 to $6699 copy 9 times
B $9823,7 Block 2x1 tiles from #R$7984 to $676B
B $982A,1 End of sequence
b $982B Room 982B
N $982B #HTML[<img src="images/rooms/982B.png" />]
W $982B,2,2 Room procedure
W $982D,2,2 Initialization
W $982F,2,2 Room to Left
W $9831,2,2
W $9833,2,2 Room Up
W $9835,2,2
B $9837,2 Fill entire screen with $FF
B $9839,6 Rectangle 19x6 tiles with $02 at $65B7
B $983F,6 Rectangle 19x6 tiles with $02 at $6662
B $9845,5 Triangle with $02, count=5 at $65D4
B $984A,5 Triangle with $02, count=5 at $6675
B $984F,5 Fill horz 18 tiles with $21 at $6716
B $9854,5 Fill horz 17 tiles with $21 at $6734
B $9859,7 Block 2 tiles from #R$71B9 to $65A9 copy 7 times
B $9860,7 Block 4x7 tiles from #R$798E to $7086
B $9867,7 Block 4x7 tiles from #R$798E to $702F
B $986E,7 Block 4x7 tiles from #R$798E to $6FF5
B $9875,1 End of sequence
b $9876 Room 9876
N $9876 #HTML[<img src="images/rooms/9876.png" />]
W $9876,2,2 Room procedure
W $9878,2,2 Initialization
W $987A,2,2 Room to Left
W $987C,2,2 Room to Right
W $987E,2,2
W $9880,2,2
B $9882,2 Fill entire screen with $FF
B $9884,6 Rectangle 10x7 tiles with $00 at $6680
B $988A,6 Rectangle 14x7 tiles with $00 at $662E
B $9890,6 Rectangle 10x7 tiles with $00 at $65C2
B $9896,5 Triangle with $00, count=2 at $664B
B $989B,5 Triangle with $00, count=3 at $65DF
B $98A0,5 Triangle with $00, count=2 at $6702
B $98A5,5 Triangle with $00, count=3 at $6696
B $98AA,7 Block 4x7 tiles from #R$798E to $707F
B $98B1,7 Block 4x7 tiles from #R$798E to $7031
B $98B8,7 Block 4x7 tiles from #R$798E to $7014
B $98BF,1 End of sequence
b $98C0 Room 98C0 (think door)
N $98C0 #HTML[<img src="images/rooms/98C0.png" />]
W $98C0,2,2 Room procedure
W $98C2,2,2 Initialization
W $98C4,2,2 Room to Left
W $98C6,2,2 Room to Right
W $98C8,2,2
W $98CA,2,2
B $98CC,5 Fill horz 240 tiles with $FF at $6590
B $98D1,5 Fill horz 60 tiles with $FF at $6752
B $98D6,7 Block 4x3 tiles from #R$7E7B to $70EF
B $98DD,7 Block 3x3 tiles from #R$71A0 to $7098
B $98E4,7 Block 3x3 tiles from #R$71A0 to $70F4
B $98EB,7 Block 1x5 tiles from #R$9903 to $66AB
B $98F2,7 Block 1x5 tiles from #R$9908 to $66AE
B $98F9,7 Block 2 tiles from #R$9901 to $668E copy 7 times
B $9900,1 End of sequence
b $9901 Blocks for rooms
B $9901,2,2 #HTML[<img src="images/blocks/9901.png" />] Back block 2x1
B $9903,5,1 #HTML[<img src="images/blocks/9903.png" />] Back block 1x5
B $9908,5,1 #HTML[<img src="images/blocks/9908.png" />] Back block 1x5
b $990D Room 990D
N $990D #HTML[<img src="images/rooms/990D.png" />]
W $990D,2,2 Room procedure
W $990F,2,2 Initialization
W $9911,2,2
W $9913,2,2
W $9915,2,2 Room Up
W $9917,2,2
B $9919,6 Rectangle 20x17 tiles with $FF at $659A
B $991F,6 Rectangle 17x12 tiles with $00 at $659B
B $9925,6 Rectangle 8x4 tiles with $00 at $670C
B $992B,5 Triangle with $00, count=3 at $670B
B $9930,7 Block 2 tiles from #R$7348 to $65A9 copy 16 times
B $9937,7 Block 4x7 tiles from #R$79AA to $70A5
B $993E,7 Block 4x7 tiles from #R$79AA to $7086
B $9945,6 Rectangle 2x17 tiles with $0D at $6594
B $994B,5 Fill vert 7 tiles with $2B at $7026
B $9950,7 Block 3x1 tiles from #R$9997 to $65B2
B $9957,7 Block 3x1 tiles from #R$9997 to $662A
B $995E,7 Block 3x1 tiles from #R$9997 to $66C0
B $9965,7 Block 3x1 tiles from #R$9997 to $6738
B $996C,7 Block 4x3 tiles from #R$999A to $65CC
B $9973,7 Block 4x3 tiles from #R$999A to $6626
B $997A,7 Block 4x3 tiles from #R$999A to $6680
B $9981,7 Block 4x3 tiles from #R$999A to $66DA
B $9988,7 Block 4x3 tiles from #R$999A to $6734
B $998F,7 Block 4x2 tiles from #R$999E to $6590
B $9996,1 End of sequence
b $9997 Blocks for rooms
B $9997,3,3 #HTML[<img src="images/blocks/9997.png" />] Back block 3x1
B $999A,4,4 #HTML[<img src="images/blocks/999a.png" />] Back block 4x1
B $999E,8,4 #HTML[<img src="images/blocks/999e.png" />] Back block 4x2
b $99A6 Room 99A6
N $99A6 #HTML[<img src="images/rooms/99A6.png" />]
N $99A6 Console: flips trigger "E": set/remove wall in room #R$97A6.
W $99A6,2,2 Room procedure
W $99A8,2,2 Initialization
W $99AA,2,2
W $99AC,2,2 Room to Right
W $99AE,2,2
W $99B0,2,2
B $99B2,5 Fill horz 30 tiles with $FF at $6770
B $99B7,5 Fill vert 14 tiles with $FF at $65D6
B $99BC,5 Fill vert 7 tiles with $2B at $709E
B $99C1,6 Rectangle 20x2 tiles with $FF at $659A
B $99C7,6 Rectangle 3x8 tiles with $FF at $65E7
B $99CD,4 Put tile $00 at $66B9
B $99D1,7 Block 2x4 tiles from #R$71BB to $7101
B $99D8,6 Rectangle 2x16 tiles with $0D at $6594
B $99DE,7 Block 4x3 tiles from #R$999A to $65CC
B $99E5,7 Block 4x3 tiles from #R$999A to $6626
B $99EC,7 Block 4x3 tiles from #R$999A to $6680
B $99F3,7 Block 4x3 tiles from #R$999A to $66DA
B $99FA,7 Block 4x2 tiles from #R$999A to $6734
B $9A01,7 Block 3x1 tiles from #R$9997 to $65EE
B $9A08,7 Block 3x1 tiles from #R$9997 to $6648
B $9A0F,7 Block 3x1 tiles from #R$9997 to $66C0
B $9A16,7 Block 4x2 tiles from #R$999E to $6590
B $9A1D,1 End of sequence
b $9A1E Room 9A1E
N $9A1E #HTML[<img src="images/rooms/9A1E.png" />]
W $9A1E,2,2 Room procedure
W $9A20,2,2 Initialization
W $9A22,2,2
W $9A24,2,2 Room to Right
W $9A26,2,2 Room Up
W $9A28,2,2
B $9A2A,2 Fill entire screen with $FF
B $9A2C,6 Rectangle 6x8 tiles with $02 at $6592
B $9A32,6 Rectangle 8x6 tiles with $02 at $65D4
B $9A38,5 Triangle with $02, count=6 at $668F
B $9A3D,6 Rectangle 14x6 tiles with $02 at $6672
B $9A43,5 Triangle with $02, count=4 at $65FA
B $9A48,7 Block 2 tiles from #R$71B9 to $6594 copy 8 times
B $9A4F,5 Fill horz 15 tiles with $21 at $6725
B $9A54,5 Fill horz 14 tiles with $21 at $6744
B $9A59,1 End of sequence
b $9A5A Room 9A5A
N $9A5A #HTML[<img src="images/rooms/9A5A.png" />]
W $9A5A,2,2 Room procedure
W $9A5C,2,2 Initialization
W $9A5E,2,2
W $9A60,2,2 Room to Right
W $9A62,2,2 Room Up
W $9A64,2,2 Room Down
B $9A66,2 Fill entire screen with $FF
B $9A68,6 Rectangle 28x11 tiles with $00 at $6592
B $9A6E,6 Rectangle 7x4 tiles with $00 at $66F1
B $9A74,5 Triangle with $00, count=3 at $66F0
B $9A79,6 Rectangle 6x2 tiles with $02 at $6754
B $9A7F,5 Fill horz 4 tiles with $02 at $6737
B $9A84,7 Block 2 tiles from #R$71B9 to $66FC copy 5 times
B $9A8B,7 Block 2x1 tiles from #R$7984 to $66DE
B $9A92,7 Block 2 tiles from #R$7348 to $6599 copy 11 times
B $9A99,1 End of sequence
b $9A9A Room 9A9A
N $9A9A #HTML[<img src="images/rooms/9A9A.png" />]
W $9A9A,2,2 Room procedure
W $9A9C,2,2 Initialization
W $9A9E,2,2 Room to Left
W $9AA0,2,2 Room to Right
W $9AA2,2,2 Room Up
W $9AA4,2,2
B $9AA6,5 Fill horz 10 tiles with $FF at $6591
B $9AAB,5 Fill horz 60 tiles with $FF at $6752
B $9AB0,6 Rectangle 4x8 tiles with $FF at $65AA
B $9AB6,4 Put tile $2A at $7090
B $9ABA,5 Fill vert 6 tiles with $2B at $70AE
B $9ABF,7 Block 2 tiles from #R$7348 to $65A5 copy 15 times
B $9AC6,7 Block 4x4 tiles from #R$71A9 to $70D4
B $9ACD,7 Block 4x4 tiles from #R$71A9 to $70DB
B $9AD4,7 Block 4x4 tiles from #R$71A9 to $70E0
B $9ADB,1 End of sequence
b $9ADC Room 9ADC
N $9ADC #HTML[<img src="images/rooms/9ADC.png" />]
W $9ADC,2,2 Room procedure
W $9ADE,2,2 Initialization
W $9AE0,2,2
W $9AE2,2,2
W $9AE4,2,2 Room Up
W $9AE6,2,2 Room Down
B $9AE8,2 Fill entire screen with $FF
B $9AEA,6 Rectangle 24x8 tiles with $00 at $6592
B $9AF0,6 Rectangle 15x7 tiles with $00 at $668B
B $9AF6,5 Triangle with $00, count=6 at $668A
B $9AFB,7 Block 2 tiles from #R$7348 to $65A5 copy 17 times
B $9B02,5 Fill vert 15 tiles with $3A at $65A0
B $9B07,5 Fill horz 13 tiles with $FF at $6670
B $9B0C,5 Fill horz 13 tiles with $27 at $7066
B $9B11,7 Block 2x1 tiles from #R$889D to $6767
B $9B18,1 End of sequence
b $9B19 Room 9B19
N $9B19 #HTML[<img src="images/rooms/9B19.png" />]
W $9B19,2,2 Room procedure
W $9B1B,2,2 Initialization
W $9B1D,2,2
W $9B1F,2,2
W $9B21,2,2 Room Up
W $9B23,2,2 Room Down
B $9B25,6 Rectangle 2x17 tiles with $FF at $6590
B $9B2B,6 Rectangle 4x17 tiles with $FF at $65AA
B $9B31,7 Block 2 tiles from #R$7348 to $65A5 copy 17 times
B $9B38,5 Fill vert 17 tiles with $3A at $65A0
B $9B3D,5 Fill horz 26 tiles with $FA at $66F9
B $9B42,7 Block 3x3 tiles from #R$71A0 to $7096
B $9B49,7 Block 2x1 tiles from #R$889D to $670D
B $9B50,1 End of sequence
b $9B51 Room 9B51
N $9B51 #HTML[<img src="images/rooms/9B51.png" />]
W $9B51,2,2 Room procedure
W $9B53,2,2 Initialization
W $9B55,2,2
W $9B57,2,2
W $9B59,2,2 Room Up
W $9B5B,2,2 Room Down
B $9B5D,2 Fill entire screen with $FF
B $9B5F,6 Rectangle 26x14 tiles with $00 at $6592
B $9B65,5 Fill vert 7 tiles with $00 at $667F
B $9B6A,5 Fill vert 7 tiles with $2B at $7074
B $9B6F,7 Block 2 tiles from #R$7348 to $675B copy 2 times
B $9B76,7 Block 2 tiles from #R$7348 to $65A5 copy 14 times
B $9B7D,7 Block 2x1 tiles from #R$889D to $673D
B $9B84,3 Barrel 3x3 tiles at $70D5
B $9B87,7 Block 4x4 tiles from #R$8789 to $70B4
B $9B8E,7 Block 4x4 tiles from #R$8789 to $70C0
B $9B95,7 Block 3x3 tiles from #R$71A0 to $70E9
B $9B9C,1 End of sequence
b $9B9D Room 9B9D
N $9B9D #HTML[<img src="images/rooms/9B9D.png" />]
W $9B9D,2,2 Room procedure
W $9B9F,2,2 Initialization
W $9BA1,2,2
W $9BA3,2,2
W $9BA5,2,2 Room Up
W $9BA7,2,2 Room Down
B $9BA9,2 Fill entire screen with $FF
B $9BAB,6 Rectangle 26x7 tiles with $00 at $66A0
B $9BB1,6 Rectangle 24x8 tiles with $00 at $6594
B $9BB7,7 Block 2x1 tiles from #R$889D to $6785
B $9BBE,7 Block 2x1 tiles from #R$889D to $668A
B $9BC5,7 Block 2 tiles from #R$7348 to $66A8 copy 7 times
B $9BCC,7 Block 2 tiles from #R$7348 to $65A6 copy 8 times
B $9BD3,7 Block 3x3 tiles from #R$71A0 to $7124
B $9BDA,3 Barrel 3x3 tiles at $70B5
B $9BDD,3 Barrel 3x3 tiles at $710F
B $9BE0,3 Barrel 3x3 tiles at $7112
B $9BE3,3 Barrel 3x3 tiles at $7119
B $9BE6,1 End of sequence
b $9BE7 Room 9BE7
N $9BE7 #HTML[<img src="images/rooms/9BE7.png" />]
W $9BE7,2,2 Room procedure
W $9BE9,2,2 Initialization
W $9BEB,2,2
W $9BED,2,2 Room to Right
W $9BEF,2,2 Room Up
W $9BF1,2,2 Room Down
B $9BF3,6 Rectangle 2x12 tiles with $FF at $6626
B $9BF9,6 Rectangle 9x5 tiles with $FF at $6596
B $9BFF,5 Triangle with $FF, count=5 at $6595
B $9C04,5 Triangle with $FF, count=9 at $6628
B $9C09,5 Fill horz 4 tiles with $FF at $65AA
B $9C0E,6 Rectangle 4x4 tiles with $FF at $6730
B $9C14,5 Fill vert 17 tiles with $3A at $65A0
B $9C19,7 Block 2 tiles from #R$7348 to $65A2 copy 13 times
B $9C20,7 Block 2 tiles from #R$7348 to $6749 copy 3 times
B $9C27,5 Fill horz 26 tiles with $FA at $6717
B $9C2C,7 Block 2x1 tiles from #R$889D to $672B
B $9C33,5 Fill vert 4 tiles with $F9 at $66A5
B $9C38,1 End of sequence
b $9C39
B $9C39,7,7
B $9C40,1,1 Ninja Y within the room, 0 at the top
B $9C41,1,1 Ninja X within the room
W $9C42,2,2 Ninja position in tilemap: Y * 30 + X
c $9C44 Process a dog
C $9C44,3 Dog Y position address
C $9C47,3 get Ninja Y
C $9C56,2 !!MUT-ARG!! ??
C $9C5E,3 get Dog direction
C $9C61,2 left?
C $9C63,2 right =>
C $9C65,3 get Ninja X
C $9C69,3 Dog X position address
C $9C71,3 get Ninja X
C $9C75,3 Dog X position address
C $9C7D,3 set "Dog ignore left/right limit" flag
C $9C80,3 !!MUT-ARG!! get Dog direction
C $9C8C,3 Set update flags for Dog
C $9C96,3 Sprite Dog dead
C $9C99,3 => Set Dog sprite = HL, Draw Dog in tilemap
b $9C9C Sprite Dog dead
B $9C9C,12,4 #HTML[<img src="images/sprite-9c9c.png" />]
c $9CA8 Part of Dog processing
C $9CAD,3 get Dog position in tilemap
C $9CB0,3 $69AD = $698C (Tile screen 2) + 33: for right direction
C $9CB3,3 get Dog direction
C $9CB6,2 right?
C $9CB8,2 right =>
C $9CBA,3 $69AA = $698C (Tile screen 2) + 30: for left direction
C $9CBD,1 now HL = Dog position in Ninja tile screen
C $9CBE,1 get tile from Ninja tile screen
C $9CBF,1 $FF?
C $9CC2,3 not $FF => Dog bites, decrease Energy by 5
C $9CC5,3 get Dog direction
C $9CC8,2 left?
C $9CCA,2 left =>
N $9CCC Dog runs right
C $9CCC,3 get Dog position in tilemap
C $9CCF,1 one tile right
C $9CD0,3 update Dog position in tilemap
C $9CD3,3 Dog X position address
C $9CD6,1 one tile right
C $9CDE,3 get Dog's right limit
C $9CEC,3 ?? = 1
N $9CF1 Dog runs left
C $9CF1,3 get Dog position in tilemap
C $9CF4,1 one tile left
C $9CF5,3 update Dog position in tilemap
C $9CF8,3 Dog X position address
C $9CFB,1 one tile left
C $9D03,3 get Dog's left limit
C $9D11,3 ?? = 1
C $9D20,3 Sprite Dog 1
C $9D25,2 => Set Dog sprite = HL, Draw Dog in tilemap
C $9D27,3 Sprite Dog 2
C $9D2C,2 => Set Dog sprite = HL, Draw Dog in tilemap
C $9D2E,3 Sprite Dog 3
N $9D31 Set Dog sprite = HL, Draw Dog in tilemap
C $9D31 set Dog sprite = HL
N $9D34 Draw Dog in tilemap
C $9D37,3 Tile screen 3 start address
C $9D3B,3 !!MUT-ARG!! current Dog sprite address
C $9D3E,2 3 rows
C $9D40,3 get Dog direction
C $9D43,2 left?
C $9D45,2 left => draw Dog facing left
N $9D47 Draw Dog facing right in tilemap
C $9D47,2 4 columns
C $9D51,3 26
C $9D54,1 next row
C $9D58,3 Set update flags for Dog, 4x3 tiles
c $9D5C Set update flags for Dog, 4x3 tiles
C $9D5C,2 3 rows
C $9D61,3 Tile screen 1 start address
C $9D65,2 "need to update" flag
C $9D67,3 26
C $9D6A,2 4 columns
C $9D6C,1 set the flag
C $9D6D,1 next column
C $9D70,1 next row
C $9D72,2 continue loop by rows
c $9D75 Draw Dog facing left in tilemap
C $9D78,2 4 columns
C $9D82,3 34
C $9D89,2 => Set update flags for Dog, and RET
c $9D8B ?? something about Dog
C $9D8B,3 Sprite Dog 4
C $9D98,3 get Dog direction
C $9D9B,2 left?
C $9D9D,2 left =>
C $9DB3,3 get Dog direction
C $9DB6,2 left?
C $9DB8,2 left =>
c $9DCD Initialize a dog
R $9DCD HL dog data address
C $9DCD,3 current dog data address
C $9DD0,3 save current Dog data address
C $9DD3,3 9 = size of Dog data
C $9DD6,2 Copy Dog data
c $9DD9 Decrease Energy by B
C $9DD9 !!MUT-CMD!! $C5 PUSH BC or $C9 RET
C $9DDA,3 Decrease Energy
C $9DDE,3 get Energy
C $9DE1,2 Energy = MIN ?
C $9DE5,3 get Energy lower
C $9DEC,3 Energy is out => Saboteur dead
C $9DEF,2 !!UNUSED!!
C $9DF1,2 continue loop by B
b $9DF5 Room 9DF5
N $9DF5 #HTML[<img src="images/rooms/9DF5.png" />]
W $9DF5,2,2 Room procedure
W $9DF7,2,2 Initialization
W $9DF9,2,2 Room to Left
W $9DFB,2,2
W $9DFD,2,2 Room Up
W $9DFF,2,2
B $9E01,5 Fill horz 7 tiles with $FF at $6590
B $9E06,6 Rectangle 2x12 tiles with $FF at $65AC
B $9E0C,5 Fill horz 122 tiles with $FF at $6714
B $9E11,7 Block 2 tiles from #R$7348 to $65A4 copy 13 times
B $9E18,4 Put tile $2A at $6FA7
B $9E1C,5 Fill vert 11 tiles with $2B at $6FC5
B $9E21,1 End of sequence
b $9E22 Room 9E22
N $9E22 #HTML[<img src="images/rooms/9E22.png" />]
W $9E22,2,2 Room procedure
W $9E24,2,2 Initialization
W $9E26,2,2
W $9E28,2,2
W $9E2A,2,2
W $9E2C,2,2 Room Down
B $9E2E,2 Fill entire screen with $FF
B $9E30,6 Rectangle 20x2 tiles with $00 at $675A
B $9E36,6 Rectangle 26x12 tiles with $02 at $65B0
B $9E3C,5 Triangle with $FF, count=5 at $65C9
B $9E41,7 Block 2 tiles from #R$7348 to $6748 copy 3 times
B $9E48,7 Block 2x1 tiles from #R$889D to $672A
B $9E4F,7 Block 2x4 tiles from #R$71BB to $70A5
B $9E56,7 Block 3x3 tiles from #R$71A0 to $70B7
B $9E5D,7 Block 3x3 tiles from #R$71A0 to $70BD
B $9E64,7 Block 3x3 tiles from #R$71A0 to $70CA
B $9E6B,7 Block 3x4 tiles from #R$849C to $7096
B $9E72,1 End of sequence
b $9E73 Room 9E73
N $9E73 #HTML[<img src="images/rooms/9E73.png" />]
W $9E73,2,2 Room procedure
W $9E75,2,2 Initialization
W $9E77,2,2 Room to Left
W $9E79,2,2
W $9E7B,2,2
W $9E7D,2,2 Room Down
B $9E7F,5 Fill horz 120 tiles with $FF at $6590
B $9E84,6 Rectangle 6x13 tiles with $FF at $6620
B $9E8A,6 Rectangle 6x6 tiles with $FF at $66E4
B $9E90,5 Triangle with $FF, count=4 at $671F
B $9E95,5 Fill horz 12 tiles with $FA at $66DA
B $9E9A,5 Fill vert 13 tiles with $3A at $6618
B $9E9F,5 Fill vert 7 tiles with $3A at $660C
B $9EA4,5 Fill horz 10 tiles with $FA at $66E9
B $9EA9,7 Block 2 tiles from #R$7348 to $661A copy 13 times
B $9EB0,7 Block 2x1 tiles from #R$889D to $66EC
B $9EB7,1 End of sequence
b $9EB8 Room 9EB8
N $9EB8 #HTML[<img src="images/rooms/9EB8.png" />]
W $9EB8,2,2 Room procedure
W $9EBA,2,2 Initialization
W $9EBC,2,2 Room to Left
W $9EBE,2,2 Room to Right
W $9EC0,2,2
W $9EC2,2,2
B $9EC4,5 Fill horz 120 tiles with $FF at $6590
B $9EC9,5 Fill horz 30 tiles with $FA at $66DA
B $9ECE,5 Fill vert 7 tiles with $28 at $7003
B $9ED3,5 Fill vert 7 tiles with $28 at $7013
B $9ED8,1 End of sequence
b $9ED9 Room 9ED9
N $9ED9 #HTML[<img src="images/rooms/9ED9.png" />]
W $9ED9,2,2 Room procedure
W $9EDB,2,2 Initialization
W $9EDD,2,2 Room to Left
W $9EDF,2,2 Room to Right
W $9EE1,2,2
W $9EE3,2,2
B $9EE5,5 Fill horz 120 tiles with $FF at $6590
B $9EEA,5 Fill horz 30 tiles with $FA at $66DA
B $9EEF,5 Fill vert 7 tiles with $28 at $7005
B $9EF4,5 Fill vert 7 tiles with $28 at $7011
B $9EF9,1 End of sequence
b $9EFA Room 9EFA
N $9EFA #HTML[<img src="images/rooms/9EFA.png" />]
W $9EFA,2,2 Room procedure
W $9EFC,2,2 Initialization
W $9EFE,2,2
W $9F00,2,2 Room to Right
W $9F02,2,2
W $9F04,2,2 Room Down
B $9F06,5 Fill horz 125 tiles with $FF at $6590
B $9F0B,6 Rectangle 5x12 tiles with $FF at $6626
B $9F11,6 Rectangle 20x5 tiles with $FF at $6701
B $9F17,5 Fill horz 19 tiles with $FF at $66DF
B $9F1C,5 Fill horz 6 tiles with $FA at $66F2
B $9F21,5 Fill vert 7 tiles with $3A at $6616
B $9F26,5 Fill vert 7 tiles with $28 at $7017
B $9F2B,7 Block 2 tiles from #R$7348 to $660E copy 13 times
B $9F32,7 Block 2x1 tiles from #R$889D to $66E0
B $9F39,1 End of sequence
b $9F3A Room 9F3A
N $9F3A #HTML[<img src="images/rooms/9F3A.png" />]
W $9F3A,2,2 Room procedure
W $9F3C,2,2 Initialization
W $9F3E,2,2
W $9F40,2,2 Room to Right
W $9F42,2,2 Room Up
W $9F44,2,2 Room Down
B $9F46,6 Rectangle 5x15 tiles with $FF at $6590
B $9F4C,5 Fill horz 60 tiles with $FF at $6752
B $9F51,6 Rectangle 20x2 tiles with $FF at $6599
B $9F57,7 Block 2 tiles from #R$7348 to $6596 copy 15 times
B $9F5E,7 Block 2x4 tiles from #R$71BB to $70E3
B $9F65,5 Fill vert 13 tiles with $3A at $65DA
B $9F6A,5 Fill vert 13 tiles with $3A at $65E5
B $9F6F,7 Block 2x1 tiles from #R$889D to $6768
B $9F76,7 Block 2x1 tiles from #R$7348 to $6786
B $9F7D,1 End of sequence
b $9F7E Room 9F7E
N $9F7E #HTML[<img src="images/rooms/9F7E.png" />]
W $9F7E,2,2 Room procedure
W $9F80,2,2 Initialization
W $9F82,2,2 Room to Left
W $9F84,2,2 Room to Right
W $9F86,2,2
W $9F88,2,2
B $9F8A,6 Rectangle 2x2 tiles with $FF at $6752
B $9F90,6 Rectangle 27x2 tiles with $A3 at $6755
B $9F96,7 Block 1x2 tiles from #R$A008 to $6754
B $9F9D,6 Rectangle 26x10 tiles with $F5 at $7020
B $9FA3,6 Rectangle 2x2 tiles with $FF at $7020
B $9FA9,7 Block 2x2 tiles from #R$A004 to $662A
B $9FB0,7 Block 4x4 tiles from #R$A00A to $707C
B $9FB7,7 Block 4x4 tiles from #R$A00A to $7080
B $9FBE,7 Block 4x4 tiles from #R$A00A to $7084
B $9FC5,7 Block 4x4 tiles from #R$A00A to $7088
B $9FCC,7 Block 4x4 tiles from #R$A00A to $708C
B $9FD3,7 Block 4x4 tiles from #R$A00A to $7090
B $9FDA,6 Rectangle 24x4 tiles with $1B at $6686
B $9FE0,6 Rectangle 24x2 tiles with $A3 at $65F0
B $9FE6,7 Block 1x2 tiles from #R$A008 to $65EF
B $9FED,4 Put tile $98 at $65D3
B $9FF1,5 Fill horz 22 tiles with $0D at $65D4
B $9FF6,7 Block 4x2 tiles from #R$A01A to $65A6
B $9FFD,6 Rectangle 4x2 tiles with $0D at $65AA
B $A003,1 End of sequence
b $A004 Blocks for rooms
B $A004,4,2 #HTML[<img src="images/blocks/a004.png" />] Back block 2x2
B $A008,2,1 #HTML[<img src="images/blocks/a008.png" />] Back block 1x2
B $A00A,16,4 #HTML[<img src="images/blocks/a00a.png" />] Front block 4x4
B $A01A,8,4 #HTML[<img src="images/blocks/a01a.png" />] Back block 4x2
b $A022 Room A022
N $A022 #HTML[<img src="images/rooms/A022.png" />]
W $A022,2,2 Room procedure
W $A024,2,2 Initialization
W $A026,2,2 Room to Left
W $A028,2,2
W $A02A,2,2
W $A02C,2,2
B $A02E,6 Rectangle 27x2 tiles with $A3 at $6752
B $A034,6 Rectangle 26x10 tiles with $F5 at $701C
B $A03A,6 Rectangle 2x2 tiles with $FF at $7034
B $A040,7 Block 2x2 tiles from #R$A0A7 to $663E
B $A047,7 Block 4x4 tiles from #R$A00A to $7076
B $A04E,7 Block 4x4 tiles from #R$A00A to $707A
B $A055,7 Block 4x4 tiles from #R$A00A to $707E
B $A05C,7 Block 4x4 tiles from #R$A00A to $7082
B $A063,7 Block 4x4 tiles from #R$A00A to $7086
B $A06A,7 Block 4x4 tiles from #R$A00A to $708A
B $A071,6 Rectangle 24x4 tiles with $1B at $6680
B $A077,6 Rectangle 24x2 tiles with $A3 at $65EA
B $A07D,7 Block 1x2 tiles from #R$A0AB to $6602
B $A084,4 Put tile $94 at $65E2
B $A088,5 Fill horz 22 tiles with $0D at $65CC
B $A08D,7 Block 4x2 tiles from #R$A0AD to $6594
B $A094,6 Rectangle 4x2 tiles with $0D at $6590
B $A09A,5 Fill vert 8 tiles with $FF at $667B
B $A09F,7 Block 1x2 tiles from #R$A0AB to $676D
B $A0A6,1 End of sequence
b $A0A7 Blocks for rooms
B $A0A7,4,2 #HTML[<img src="images/blocks/a0a7.png" />] Back block 2x2
B $A0AB,2,1 #HTML[<img src="images/blocks/a0ab.png" />] Back block 1x2
B $A0AD,8,4 #HTML[<img src="images/blocks/a0ad.png" />] Back block 4x2
b $A0B5 Sprite Ninja/Guard dead, 6x7 tiles
B $A0B5,42,6 #HTML[<img src="images/sprite-a0b5.png" />]
c $A0DF Room #R$94AB initialization
C $A0DF,3 Guard data address
N $A0E2 Initialize a guard, then Standard room initialization
C $A0E2,3 Initialize a guard
C $A0E5,3 Standard room initialization
c $A0E8 Room #R$7DA9 initialization
C $A0E8,3 Guard data address
C $A0EB,2 Initialize a guard, then Standard room initialization
c $A0ED Room #R$7E8C initialization
C $A0ED,3 Guard data address
C $A0F0,2 Initialize a guard, then Standard room initialization
c $A0F2 Room #R$920A initialization
C $A0F2,3 Guard data address
C $A0F5,2 Initialize a guard, then Standard room initialization
c $A0F7 Room #R$8F84 initialization
C $A0F7,3 Guard data address
C $A0FA,2 Initialize a guard, then Standard room initialization
c $A0FC Room #R$8B71 initialization
C $A0FC,3 Guard data address
C $A0FF,2 Initialize a guard, then Standard room initialization
c $A101 Room #R$8739 initialization
C $A101,3 Guard data address
C $A104,2 Initialize a guard, then Standard room initialization
c $A106 Room #R$858F initialization
C $A106,3 Guard data address
C $A109,2 Initialize a guard, then Standard room initialization
c $A10B Room #R$84EE initialization
C $A10B,3 Guard data address
C $A10E,2 Initialize a guard, then Standard room initialization
c $A110 Room #R$99A6 initialization
C $A110,3 Guard data address
C $A113,2 Initialize a guard, then Standard room initialization
c $A115 Room #R$97F8 initialization
C $A115,3 Guard data address
C $A118,2 Initialize a guard, then Standard room initialization
c $A11A Room #R$94CF initialization
C $A11A,3 Guard data address
C $A11D,2 Initialize a guard, then Standard room initialization
c $A11F Room #R$9B51 initialization
C $A11F,3 Guard data address
C $A122,2 Initialize a guard, then Standard room initialization
c $A124 Room #R$9F3A initialization
C $A124,3 Guard data address
C $A127,2 Initialize a guard, then Standard room initialization
c $A129 Room #R$9F7E initialization
C $A129,3 Guard data address
C $A12C,2 Initialize a guard, then Standard room initialization
c $A12E Room #R$9EB8 initialization
C $A12E,3 Guard data address
C $A131,2 Initialize a guard, then Standard room initialization
c $A133 Room #R$9B19 initialization
C $A133,3 Guard data address
C $A136,2 Initialize a guard, then Standard room initialization
c $A138 Room #R$9DF5 initialization
C $A138,3 Guard data address
C $A13B,2 Initialize a guard, then Standard room initialization
c $A13D ?? UNUSED??
C $A13D,3 Guard data address
C $A140,2 Initialize a guard, then Standard room initialization
c $A142 Room #R$7A17 initialization
C $A142,3 Turret data address
N $A145 Initialize a turret, then Standard room initialization
C $A145,3 Initialize a turret
C $A148,2 Standard room initialization
c $A14A Room #R$7D5A initialization
C $A14A,3 Turret data address
C $A14D,2 Initialize a turret, then Standard room initialization
c $A14F Room #R$7F48 initialization
C $A14F,3 Turret data address
C $A152,2 Initialize a turret, then Standard room initialization
c $A154 Room #R$7EF2 initialization
C $A154,3 Dog data address
C $A157,3 Initialize a dog
C $A15A,3 Turret data address
C $A15D,2 Initialize a turret, then Standard room initialization
c $A15F Room #R$909F initialization
C $A15F,3 Dog data address
C $A162,3 Initialize a dog
C $A165,3 Turret data address
C $A168,2 Initialize a turret, then Standard room initialization
c $A16A Room #R$8FBD initialization
C $A16A,3 Turret data address
C $A16D,2 Initialize a turret, then Standard room initialization
c $A16F Room #R$92A7 initialization
C $A16F,3 Turret data address
C $A172,2 Initialize a turret, then Standard room initialization
c $A174 Room #R$8B25 initialization
C $A174,3 Turret data address
C $A177,2 Initialize a turret, then Standard room initialization
c $A179 Room #R$8526 initialization
C $A179,3 Turret data address
C $A17C,2 Initialize a turret, then Standard room initialization
c $A17E ?? UNUSED??
C $A17E,3 Turret data address
C $A181,2 Initialize a turret, then Standard room initialization
c $A183 Room #R$95D6 initialization
C $A183,3 Turret data address
C $A186,2 Initialize a turret, then Standard room initialization
c $A188 Room #R$968A initialization
C $A188,3 Turret data address
C $A18B,2 Initialize a turret, then Standard room initialization
c $A18D Finish Room #R$97A6 initialization
C $A18D,3 Turret data address
C $A190,2 Initialize a turret, then Standard room initialization
c $A192 Room #R$9A9A initialization
C $A192,3 Turret data address
C $A195,2 Initialize a turret, then Standard room initialization
c $A197 Room #R$9552 initialization
C $A197,3 Turret data address
C $A19A,2 Initialize a turret, then Standard room initialization
c $A19C Room #R$9BE7 initialization
C $A19C,3 Turret data address
C $A19F,2 Initialize a turret, then Standard room initialization
c $A1A1 Room #R$8D5C initialization
C $A1A1,3 Turret data address
C $A1A4,2 Initialize a turret, then Standard room initialization
c $A1A6 Room #R$7C2E initialization
C $A1A6,3 Dog data address
C $A1A9,3 Initialize a dog
C $A1AC,3 Guard data address
c $A1AF Finish room initialization
C $A1AF,3 Initialize a guard
C $A1B2,3 Standard room initialization
c $A1B5 Room #R$7F9C initialization
C $A1B5,3 Dog data address
C $A1B8,3 Initialize a dog
C $A1BB,3 Guard data address
C $A1BE,2 Initialize a guard, then Standard room initialization
c $A1C0 Room #R$8162 initialization
C $A1C0,3 Dog data address
C $A1C3,3 Initialize a dog
C $A1C6,3 Guard data address
C $A1C9,2 Initialize a guard, then Standard room initialization
c $A1CB Room #R$80A7 initialization
C $A1CB,3 Dog data address
C $A1CE,3 Initialize a dog
C $A1D1,3 Guard data address
C $A1D4,2 Initialize a guard, then Standard room initialization
c $A1D6 Room #R$9B9D initialization
C $A1D6,3 Dog data address
C $A1D9,3 Initialize a dog
C $A1DC,3 Guard data address
C $A1DF,2 Initialize a guard, then Standard room initialization
b $A1E1 Guards data, 24 records, 6 bytes each
N $A1E1 +$04: Guard state, initially $0A
N $A1E1 +$05: Guard direction
B $A1E1,6,6 Room 94AB guard
B $A1E7,6,6 Room 7DA9 guard
B $A1ED,6,6 Room 7E8C guard
B $A1F3,6,6 Room 920A guard
B $A1F9,6,6 Room 8F84 guard
B $A1FF,6,6 Room 8B71 guard
B $A205,6,6 Room 8739 guard
B $A20B,6,6 Room 858F guard
B $A211,6,6 Room 84EE guard
B $A217,6,6 UNUSED, see #R$A13D
B $A21D,6,6 Room 99A6 guard
B $A223,6,6 Room 97F8 guard
B $A229,6,6 Room 94CF guard
B $A22F,6,6 Room 9B51 guard
B $A235,6,6 Room 9F3A guard
B $A23B,6,6 Room 9F7E guard
B $A241,6,6 Room 9EB8 guard
B $A247,6,6 Room 9B19 guard
B $A24D,6,6 Room 9DF5 guard
B $A253,6,6 Room 7C2E guard
B $A259,6,6 Room 7F9C guard
B $A25F,6,6 Room 8162 guard
B $A265,6,6 Room 80A7 guard
B $A26B,6,6 Room 9B9D guard
b $A271 Dogs data, 19 records, 10 bytes each
N $A271 +$00/$01: Dog position in tilemap
N $A271 +$02: Dog direction
N $A271 +$03: Dog X position
N $A271 +$05: Dog left limit
N $A271 +$06: Dog right limit
N $A271 +$08: Dog Y position
B $A271,10,10 Room 7C2E dog
B $A27B,10,10 Room 7F9C dog
B $A285,10,10 Room 81E5 dog
B $A28F,10,10 Room 8162 dog
B $A299,10,10 Room 7EF2 dog
B $A2A3,10,10 Room 7E05 dog
B $A2AD,10,10 Room 80A7 dog
B $A2B7,10,10 Room 83ED dog
B $A2C1,10,10 Room 80F6 dog
B $A2CB,10,10 Room 924E dog
B $A2D5,10,10 Room 91BA dog
B $A2DF,10,10 Room 90DB dog
B $A2E9,10,10 Room 909F dog
B $A2F3,10,10 Room 8802 dog
B $A2FD,10,10 Room 8608 dog
B $A307,10,10 Room 844E dog
B $A311,10,10 Room 9739 dog
B $A31B,10,10 Room 9A5A dog
B $A325,10,10 Room 9B9D dog
b $A32F Turrets data, 12 records, 3 bytes each
B $A32F,3,3 Room 7A17 turret
B $A332,3,3 Room 7F48/9A9A turret
B $A335,3,3 Room 8FBD turret
B $A338,3,3 Room 7EF2/909F/92A7 turret
B $A33B,3,3 Room 8B25/8D5C turret
B $A33E,3,3 Room 7A17/8526 turret
B $A341,3,3 UNUSED, see #R$A17E
B $A344,3,3 Room 95D6 turret
B $A347,3,3 Room 968A turret
B $A34A,3,3 Room 97A6 turret
B $A34D,3,3 Room 9552 turret
B $A350,3,3 Room 9BE7 turret
c $A353 Room #R$81E5 initialization
N $A356 Initialize a dog, then Standard room initialization
C $A353,3 Dog data address
C $A356,3 Initialize a dog
C $A359,3 Standard room initialization
c $A35C Room #R$7E05 initialization
C $A35C,3 Dog data address
C $A35F,2 Initialize a dog, then Standard room initialization
c $A361 Room #R$83ED initialization
C $A361,3 Dog data address
C $A364,2 Initialize a dog, then Standard room initialization
c $A366 Room #R$924E initialization
C $A366,3 Dog data address
C $A369,2 Initialize a dog, then Standard room initialization
c $A36B Room #R$91BA initialization
C $A36B,3 Dog data address
C $A36E,2 Initialize a dog, then Standard room initialization
c $A370 Room #R$90DB initialization
C $A370,3 Dog data address
C $A373,2 Initialize a dog, then Standard room initialization
c $A375 Room #R$8802 initialization
C $A375,3 Dog data address
C $A378,2 Initialize a dog, then Standard room initialization
c $A37A Room #R$8608 initialization
C $A37A,3 Dog data address
C $A37D,2 Initialize a dog, then Standard room initialization
c $A37F Room #R$844E initialization
C $A37F,3 Dog data address
C $A382,2 Initialize a dog, then Standard room initialization
c $A384 Room #R$9739 initialization
C $A384,3 Dog data address
C $A387,2 Initialize a dog, then Standard room initialization
c $A389 Room #R$9A5A initialization
C $A389,3 Dog data address
C $A38C,2 Initialize a dog, then Standard room initialization
c $A38E Room #R$80F6 initialization
C $A38E,3 Dog data address
C $A391,2 Initialize a dog, then Standard room initialization
b $A393
b $A39F Three objects, 7 bytes each
N $A39F 1st object - object thrown by Ninja
N $A3A6 2nd object - knife thrown by Guard
N $A3AD 3rd object - Turett
b $A3B4
B $A3B4,1,1 ?? Guard counter
c $A3B5 Ninja and Guard in 12 tiles by X
C $A3B5,3 get Ninja Y
C $A3B8,3 Guard Y position address
C $A3BB,1 compare Ninja Y to Guard Y
C $A3BE,2 !!MUT-ARG!! ??
C $A3C5,3 set Guard state = $0B
C $A3C8,3 Sprite Ninja/Guard punching
C $A3CB,3 set Guard sprite
C $A3CE,3 => Draw Guard on tilemap
c $A3D1 Ninja and Guard in 9 tiles by X
C $A3D1,3 get Ninja Y
C $A3D4,3 Guard Y position address
C $A3D7,1 compare Ninja Y to Guard Y
C $A3E2,3 set Guard state = $14
C $A3E5,3 Sprite Ninja/Guard punching
C $A3E8,3 set Guard sprite
C $A3EB,3 => Draw Guard on tilemap
c $A3EE Ninja and Guard in 3 tiles by X
C $A3EE,3 get Ninja Y
C $A3F1,3 Guard Y position address
C $A3F4,1 compare Ninja Y to Guard Y
C $A3F6,3 get Guard position in tilemap
C $A3F9,3 $6592 = $6590 (Tile screen 0) + 2
C $A3FC,1 now HL in Back tile screen
C $A407,3 set Guard state = $05
C $A40C,3 set Guard counter
C $A40F,3 Sprite Ninja/Guard jumping
C $A412,3 set Guard sprite
C $A415,3 => Draw Guard on tilemap
c $A418 Ninja and Guard are very close by X
C $A418,3 get Ninja Y
C $A41B,3 Guard Y position address
C $A41E,1 compare Ninja Y to Guard Y
C $A423,3 set Guard state = $08
C $A428,3 set Guard counter
C $A42B,3 Sprite Ninja/Guard punching
C $A42E,3 set Guard sprite
C $A431,3 => Draw Guard on tilemap
c $A434 Process a Guard
C $A434,3 Set update flags for Guard, 6x7 tiles
C $A437,3 Guard state address
C $A43A,1 get Guard state
N $A43B Guard state = $0B ?
C $A440,3 Guard counter address
C $A443,1 decrease Guard counter
C $A444,1 get Guard counter
C $A447,3 => Draw Guard on tilemap
C $A44E,3 get Guard Y
C $A451,1 Guard Y * 2
C $A455,1 Guard Y * 2 + 1
C $A463,3 get Guard X
C $A46D,3 get Guard X
C $A472,3 get Current Guard position in tilemap
C $A479,2 "DEC HL" instruction
C $A47B,3 set the instruction
C $A47E,2 "DEC DE" instruction
C $A480,3 set the instruction
C $A483,3 get Guard direction
C $A486,2 left?
C $A488,2 yes =>
C $A48A,2 26
C $A492,1 +5
C $A497,1 +5
C $A498,2 "INC HL" instruction
C $A49A,3 set the instruction
C $A49D,2 "INC DE" instruction
C $A49F,3 set the instruction
C $A4A3,3 Tile screen 0 start address
C $A4AC,3 Tile screen 5 start address
C $A4B4,3 Tile screen 1 start address
C $A4C0,3 Tile screen 2 start address
C $A4CA,3 Decrease Energy by B
C $A4D0,1 !!MUT-CMD!! "DEC HL" or "INC HL" instruction
C $A4D1,1 !!MUT-CMD!! "DEC DE" or "INC DE" instruction
C $A4D7,3 get Guard counter
C $A4DC,3 => Draw Guard on tilemap
C $A4E1,3 set Guard state = $04
C $A4E4,3 => Draw Guard on tilemap
N $A4E7 Guard state = $14 ?
C $A4EB,2 set Guard state = $04
C $A4ED,3 Sprite Ninja/Guard standing
C $A4F0,3 set Guard sprite
C $A4F3,3 get Guard position in tilemap
C $A4F6,3 60
C $A4FD,3 get Guard direction
C $A500,2 left?
C $A502,2 left =>
C $A508,3 65
C $A50F,3 get Guard X
C $A524,3 get Guard Y
C $A527,2 Guard Y + 2
C $A52C,3 => Draw Guard on tilemap
N $A52F Guard state = $0A ?
C $A533,3 Sprite Ninja/Guard standing
C $A536,3 set Guard sprite
C $A539,3 Ninja Y address
C $A53C,3 get Guard Y
C $A53F,2 Guard Y + 3
C $A541,1 compare with Ninja Y
C $A542,3 Guard above Ninja => Draw Guard on tilemap
C $A54B,3 get Guard direction: 0 / 1
C $A54E,1 $FF left / 0 right
C $A54F,3 get Guard X
C $A552,3 Ninja X address
C $A555,2 right =>
C $A557,2 for left, Guard X + 2
C $A559,1 compare with Ninja X
C $A55A,3 Guard still behind Ninja => Draw Guard on tilemap
C $A55F,2 for right, Guard X - 3
C $A561,1 compare with Ninja X
C $A562,3 Guard not reached Ninja => Draw Guard on tilemap
C $A565,2 state $04
C $A567,3 set Guard state = $04
C $A56A,3 => Draw Guard on tilemap
N $A56D Guard state = $09 ? - Guard is dead
C $A571,3 Sprite Ninja dead
C $A574,3 set Guard sprite
C $A577,3 => Draw Guard on tilemap
N $A57A Guard state = $08 ?
C $A57F,3 Guard counter address
C $A582,1 decrease Guard counter
C $A584,3 => Draw Guard on tilemap
C $A587,2 set Guard state = walking state 3
C $A58C,3 $69CC = $698C (Tile screen 2) + 64
C $A58F,3 get Guard direction
C $A592,2 right?
C $A594,2 yes =>
C $A596,3 $69C9 = $698C (Tile screen 2) + 61
C $A59E,3 => Decrease Energy by B + Sound
C $A5A1,3 Sprite Ninja/Guard standing
C $A5A4,3 set Guard sprite
C $A5A7,3 => Draw Guard on tilemap
N $A5AA Guard state = $05 ? - Preparing for jump-kick
C $A5AF,3 Guard counter address
C $A5B2,1 decrease Guard counter
C $A5B4,3 => Draw Guard on tilemap
C $A5B9,3 set Guard counter value
C $A5BC,2 set Guard state = $06: jump-kick
C $A5BE,3 Sprite Ninja/Guard jump-kick
C $A5C1,3 set Guard sprite
C $A5C4,3 => Draw Guard on tilemap
N $A5C7 Guard state = $06 ?
C $A5CC,3 Guard counter address
C $A5CF,1 decrease Guard counter
C $A5D1,3 => Draw Guard on tilemap
C $A5D6,3 set Guard counter value
C $A5D9,2 set Guard state = $07: back to standing
C $A5DB,3 Sprite Ninja/Guard jumping
C $A5DE,3 set Guard sprite
C $A5E1,3 get Guard position in tilemap
C $A5E4,3 $69CD = $698C (Tile screen 2) + 65
C $A5E7,3 get Guard direction
C $A5EA,2 right?
C $A5EC,2 right =>
C $A5EE,3 $69C8 = $698C (Tile screen 2) + 60
C $A5F1,1 now HL = address in Ninja tile screen
C $A5F2,1 get tile from Ninja screen
C $A5F3,1 $FF ?
C $A5F4,2 10 damage
C $A5F6,3 not $FF => Decrease Energy by 10 + Sound
C $A5F9,3 => Draw Guard on tilemap
N $A5FC Guard state = $07 ? - back to standing
C $A601,3 Guard counter address
C $A604,1 decrease Guard counter
C $A606,3 counter not zero => Draw Guard on tilemap
C $A609,2 set Guard state = walking phase 3
C $A60B,3 Sprite Ninja/Guard standing
C $A60E,3 set Guard sprite
C $A611,3 => Draw Guard on tilemap
N $A614 Guard state is none of the above
C $A614,3 Ninja X address
C $A617,3 get Guard X
C $A61A,1 compare to Ninja X
C $A61B,2 not equal =>
C $A620,3 Guard state address
C $A625,1 Guard state = $0A ?
C $A626,3 Guard state is $0A => Draw Guard on tilemap
C $A62B,1 set Guard state = $04
C $A62C,3 Sprite Ninja/Guard standing
C $A62F,3 set Guard sprite
C $A632,3 => Draw Guard on tilemap
N $A635 Guard X != Ninja X
C $A635,2 Guard X < Ninja X =>
N $A637 Ninja X < Guard X
C $A637,1 save value "Guard X - Ninja X"
C $A638,3 get Guard direction
C $A63B,2 left?
C $A63D,2 left =>
C $A63F,3 get Guard state
C $A642,2 Guard state = $04 ?
C $A648,3 set Guard state = $04
C $A64B,3 Sprite Ninja/Guard standing
C $A64E,3 set Guard sprite
C $A651,3 => Draw Guard on tilemap
C $A655,3 set Guard direction = left
C $A658,3 => Draw Guard on tilemap
C $A65B,1 restore value "Guard X - Ninja X"
C $A65C,2 3
C $A661,2 1
C $A666,2 9
C $A66B,2 12
C $A670,3 get Guard state
C $A673,2 Guard state = $04 ?
C $A675,2 no =>
C $A677,2 walking phase 3
C $A679,3 set Guard state
C $A67C,3 => Draw Guard on tilemap
C $A67F,3 Guard X address
C $A682,1 decrease Guard X - move one tile left
C $A684,3 set Guard direction = left
N $A68C Guard X < Ninja X
C $A68D,3 get Guard direction
C $A690,2 right?
C $A692,2 right =>
C $A694,3 get Guard state
C $A697,2 Guard state = $04 ?
C $A69D,3 set Guard state = $04
C $A6A0,3 Sprite Ninja/Guard standing
C $A6A3,3 set Guard sprite
C $A6A6,2 => Draw Guard on tilemap
C $A6AA,3 set Guard direction = right
C $A6AD,2 => Draw Guard on tilemap
C $A6B0,2 -3
C $A6B5,2 -1
C $A6BA,2 -9
C $A6BF,2 -12
C $A6C4,3 get Guard state
C $A6C7,2 Guard state = $04 ?
C $A6CD,3 set Guard state = walking phase 3
C $A6D0,2 => Draw Guard on tilemap
C $A6D2,3 Guard X address
C $A6D5,1 increase Guard X - move one tile right
C $A6D8,3 set Guard direction = right
C $A6DE,3 get Guard position in tilemap
C $A6E2,3 update Guard position in tilemap
C $A6E5,3 get Guard state
C $A6E8,1 next walking phase
C $A6E9,2 0..3
C $A6EB,3 set Guard state
C $A6EE,1 * 2
C $A6F2,3 Table of four Ninja/Guard walking sprites
C $A6F6,3 Guard sprite address
N $A6FF Draw Guard on tilemap
C $A6FF,4 get Guard position in tilemap
C $A703,3 get Guard direction
C $A706,2 left?
C $A708,2 right =>
C $A70A,3 Tile screen 4 start address + 5
C $A70E,3 !!MUT-ARG!! current Ninja/Guard sprite address
C $A711,2 7 rows
C $A713,2 6 rows
C $A716,3 Translate Ninja tile A into Guard tile
C $A720,3 36
C $A723,1 next row
C $A725,2 continue loop by rows
C $A728,3 Tile screen 4 start address
C $A72C,4 get Guard sprite address
C $A730,2 7 rows
C $A732,2 6 rows
C $A734,1 get tile
C $A735,3 Translate Ninja tile A into Guard tile
C $A73F,3 24
C $A742,1 next row
C $A744,2 continue loop by rows
b $A747
c $A75B Set update flags for Guard, 6x7 tiles
C $A75B,4 get Current Guard position in tilemap
C $A75F,3 Tile screen 1 start address
C $A762,1 now HL in update flags tilemap
C $A763,3 24
C $A766,2 "need to update" flag
C $A768,2 7 rows
C $A76A,2 6 columns
C $A76C,1 set the flag
C $A76D,1 next column
C $A76F,2 continue loop by columns
C $A771,1 next row
C $A772,2 continue loop by rows
c $A775 Translate Ninja tile A into Guard tile, using #R$A787 table
C $A776,3 Translate table address
C $A779,2 19 records
C $A77B,1 found the tile?
C $A77F,1 get the new tile
C $A783,2 continue the loop
b $A787 Table used to translate Ninja tiles to Guard tiles, 19 records
B $A787,38,8
b $A7AD Pictures of NEAR/HELD items, 32x24px each
B $A7AD,96,8 #HTML[#UDGARRAY4,,,4,,;$A7AD-$A80C-1-32(itemnoth)] Nothing
B $A80D,12,8 attributes
B $A819,96,8 #HTML[#UDGARRAY4,,,4,,;$A819-$A878-1-32(itemshur)] Shuriken
B $A879,12,8 attributes
B $A885,96,8 #HTML[#UDGARRAY4,,,4,,;$A885-$A8E4-1-32(itemnife)] Knife
B $A8E5,12,8 attributes
B $A8F1,96,8 #HTML[#UDGARRAY4,,,4,,;$A8F1-$A950-1-32(itemthre)] ??
B $A951,12,8 attributes
B $A95D,96,8 #HTML[#UDGARRAY4,,,4,,;$A95D-$A9BC-1-32(itembrik)] Brick
B $A9BD,12,8 attributes
B $A9C9,96,8 #HTML[#UDGARRAY4,,,4,,;$A9C9-$AA28-1-32(itempipe)] Pipe
B $AA29,12,8 attributes
B $AA35,96,8 #HTML[#UDGARRAY4,,,4,,;$AA35-$AA94-1-32(itemgran)] Granade
B $AA95,12,8 attributes
B $AAA1,96,8 #HTML[#UDGARRAY4,,,4,,;$AAA1-$AB00-1-32(itemdisk)] Disk
B $AB01,12,8 attributes
B $AB0D,96,8 #HTML[#UDGARRAY4,,,4,,;$AB0D-$AB6C-1-32(itembomb)] Bomb
B $AB6D,12,8 attributes
B $AB79,96,8 #HTML[#UDGARRAY4,,,4,,;$AB79-$ABD8-1-32(itemcons)] Console
B $ABD9,12,8 attributes
b $ABE5 Explosion image, 3x3 tiles
B $ABE5,72,8 #HTML[#UDGARRAY3,$42,,1,,;$ABE5-$AC2C-8-24(ade5)]
b $AC2D
c $AC44 Reset Guard data and Dog data
C $AC44,3 address for Table of Guard data addresses
C $AC47,2 24
C $AC4B,1 now DE = Guard data address
C $AC52,2 set initial Guard energy = 10
C $AC57,3 address for Table of Dog data addresses
C $AC5A,2 20
w $AC72 Table of Guard data addresses, 24 records
W $AC72,48,8
w $ACA2 Table of Dog data addresses, 20 records
W $ACA2,40,8
c $ACCA Draw game screen frames and indicator text
C $ACCF,3 Screen start address
C $ACD2,3 Game screen frames/indicators RLE encoded sequence
C $ACF0,1 * 8
C $ACF1,1 * 9
C $ACF2,3 Indicator tiles address
C $AD21,3 Indicator messages address
C $AD26,3 Print string "PAY : $ XXXXX"
C $AD2E,3 Print string "99"
C $AD36,3 Print string "HELD"
C $AD3E,3 Print string "TIME"
C $AD46,3 Print string "NEAR"
t $AD4A Indicator messages
T $AD4A,8,8
T $AD52,5,5 Pay value text
T $AD57,2,2 Indicator time value
T $AD59,12,12
b $AD65 Game screen frames/indicators RLE encoded sequence
B $AD65,157,8 #HTML[<img src="images/indicators.png" />]
b $AE02 Tiles for game screen frames/indicators, 9 bytes each
B $AE02,,9 #HTML[<img src="images/indtiles.png" />]
c $AED1 Print string with standard font
R $AED1 C Length
R $AED1 (HL) string address
R $AED1 (DE) screen address
C $AED8,1 * 8
c $AEF0
C $AEF0,3 attributes screen address
C $AF13,3 Pay value text address
C $AF35,3 => Print table of records
C $AF41,3 Print string "EXCELLENT WORK."
C $AF49,3 Print string "YOU ARE ONE OF"
C $AF51,3 Print string " OUR TEN BEST"
C $AF59,3 Print string "NINJA SABOTEURS."
C $AF61,3 Print string "ENTER YOUR NAME..."
C $AF68,3 screen address
C $AF6B,3 address of string 10 spaces
C $AF6E,3 Print string
C $AF7B,3 address of string 10 spaces
C $AF85,3 clear LASTK
C $AF89,3 get LASTK
c $AF9C
C $AFAD,3 Print string
C $AFC0,3 KEY-SCAN
C $AFED,3 Pay value text address
C $AFF9,3 address of string 10 spaces
c $B005 Print table of records
C $B014,3 Print string
C $B01A,3 Print string
C $B023,3 Print string
C $B029,3 Print string
C $B02E,3 +14
c $B040
C $B04D,3 Print string
t $B061
t $B066 Table of records
T $B066,130,13
t $B0E8 String 10 spaces
t $B0F2
T $B101
T $B10F
T $B11C
T $B12C
b $B13E Tile buffer
B $B13E,8,8 Pixel bytes
B $B146,1,1 Attribute byte
B $B147,1,1 Background attribute byte
c $B148 Draw tile map on the screen
C $B148,3 Screen attributes address
C $B14B,2 17 rows
C $B150,3 Tile screen 5 start address
C $B156,3 Tile screen 4 start address
C $B15C,3 Tile screen 1 start address
C $B15F,3 screen address where game screen starts
C $B163,3 Tile screen 0 start address
C $B166,3 Tile screen 2 start address
C $B169,3 Tile screen 3 start address
N $B16D Loop start
C $B16D,2 30 column
C $B170,1 Check "need update" flag in Tile screen 1
C $B171,3 zero => Skip this tile rendering
N $B177 Process Tile screen 0 - background tile
C $B178,1 get byte from Tile screen 0 tile
C $B17A,3 for non-$FF, don't skip Ninja tile processing
C $B17D,2 $FF - "earth" background?
C $B17F,2 byte <> $FF =>
C $B181,3 for $FF, skip Ninja tile processing
C $B184,3 save the chosen jump address ($B1A3 or $B1F9)
C $B18F,1 * 9
C $B190,3 Background tiles start address
C $B193,1 now HL = tile data address
C $B194,3 Tile buffer address
C $B197,2 8 pixel bytes + attribute byte
C $B199,1 get byte from tile data
C $B19A,1 store the byte to tile buffer
C $B19B,1 move to next byte in tile data
C $B19C,1 move to next byte in tile buffer
C $B19D,2 loop for 9 bytes
C $B19F,1 save attribute byte once more
C $B1A0,3 !!MUT-ARG!! $B1A3 or $B1F9
N $B1A3 Process Tile screen 2 tile - Ninja
C $B1A4,1 get tile from Tile Screen 2 tile
C $B1A6,2 $FF - transparent?
C $B1A8,2 $FF => skip Ninja tile drawing
C $B1C1,3 get attribute byte from the tile buffer
C $B1CC,3 get attribute byte from the tile buffer
C $B1D2,3 set attribute byte
C $B1DA,1 * 16
C $B1DB,3 Ninja tiles base address
C $B1DE,1 now HL = tile data address
C $B1DF,2 8 bytes
C $B1E1,3 Tile buffer address
C $B1E5,1 get byte from tile buffer
C $B1E7,1 get byte from tile data (mask)
C $B1E8,3 Mirror byte if needed
C $B1EB,1 AND with byte from the buffer - apply the mask
C $B1EE,1 get byte from tile data (pixels)
C $B1EF,3 Mirror byte if needed
C $B1F2,1 OR with the byte from buffer - apply pixels
C $B1F7,2 loop for all 8 bytes
N $B1FC Process Tile screen 3 tile - Dog
C $B200,1 get tile from Tile screen 3
C $B201,2 $FF - transparent?
C $B203,2 $FF => skip Dog tile drawing
C $B205,3 Exchange $7239 (Ninja direction) and $71CD (Dog direction)
C $B20E,1 * 16
C $B20F,3 Dog tiles base address
C $B212,1 now HL = tile data address
C $B215,3 Tile buffer address
C $B219,1 get byte from tile buffer
C $B21C,3 Mirror byte if needed
C $B223,3 Mirror byte if needed
C $B22D,3 Exchange $7239 (Ninja direction) and $71CD (Dog direction)
N $B230 Process Tile screen 4 tile - Guard
C $B230,3 get address in Tile screen 4
C $B233,1 get tile from the tilemap
C $B234,2 $FF - transparent?
C $B236,2 $FF => skip Guard tile drawing
C $B23E,1 * 16
C $B23F,3 tiles base address
C $B242,1 now HL = tile data address
C $B245,3 Tile buffer address
C $B248,3 Exchange $7239 (Ninja direction) and $7347 (Guard direction)
C $B24C,1 get byte from tile buffer
C $B24E,1 get byte from tile data (mask)
C $B24F,3 Mirror byte if needed
C $B252,1 AND with byte from buffer - masking
C $B255,1 get byte from tile data (pixels)
C $B256,3 Mirror byte if needed
C $B259,1 OR with byte from buffer
C $B25C,1 save result byte to tile buffer
C $B25E,2 loop for all 8 bytes
C $B260,3 Exchange $7239 (Ninja direction) and $7347 (Guard direction)
N $B263 Process Tile screen 5 tile - front
C $B263,3 get address in Tile screen 5
C $B266,1 get tile from the tilemap
C $B267,2 $FF - transparent?
C $B269,2 $FF => skip front tile drawing
C $B26E,3 get Background tile attribute
C $B271,3 set it as current tile attribute
C $B278,1 * 16
C $B27A,1 * 17
C $B27B,3 Front tiles base address
C $B27E,1 now HL = address of tile data
C $B281,3 Tile buffer address
C $B284,1 get byte from buffer
C $B285,1 AND with mask byte
C $B286,1 move to next byte in tile data
C $B287,1 OR with pixel byte
C $B288,1 store result back to tile buffer
C $B289,1 move to next byte in tile data
C $B28A,1 move to next buffer byte
C $B28B,2 loop for all 8 bytes
C $B28D,1 get attribute byte from the tile data
C $B28E,2 $FF?
C $B290,2 $FF => skip
C $B292,1 set as current attribute
N $B293 Draw prepared tile on the screen
C $B296,3 Tile buffer address
C $B299,2 8 bytes
C $B29B,1 get byte from the buffer
C $B29C,1 put byte on the screen
C $B29F,2 loop for all 8 bytes
C $B2A1,1 get attribute byte from the buffer
C $B2A2,3 get address in screen attributes
C $B2A5,1 put the attribute
N $B2A6 Next column
C $B2A9,1 Next address in screen
C $B2AA,1 Next address in Tile screen 1
C $B2AD,1 Next address in Tile screen 0
C $B2B4,1 Next address in screen attributes
C $B2BB,1 Next address in Tile screen 5
C $B2C2,1 Next address in Tile screen 4
C $B2C7,1 Decrease column counter
C $B2C8,3 Continue loop by columns
N $B2CB Next tile row
C $B2DA,3 get screen attributes address
C $B2DE,1 increase address by 2 - next row
C $B2DF,3 set screen attributes address
C $B2E3,1 Decrease line counter
C $B2E4,3 Continue loop by lines
c $B2E8 Mirror byte if needed
C $B2EA,3 get Ninja direction
C $B2ED,2 left?
C $B2F1,1 right - no need to mirror => return
C $B2F2,4 Mirror table half address
b $B2FD
B $B2FD,1,1 Counter for Ninja/Guard head tile change
c $B2FE Exchange $7239 (Ninja direction) and $71CD (dog direction)
C $B2FF,3 get Ninja direction
C $B303,3 get Dog direction
c $B30F Exchange $7239 (Ninja direction) and $7347 (Guard direction)
C $B310,3 get Ninja direction
C $B314,3 get Guard direction
c $B320 Object procedure: flip trigger "D": set/remove wall in room #R$9739
C $B328,2 => Change Console color in NEAR
c $B32A Object procedure: flip trigger "E": set/remove wall in room #R$97A6
C $B332,2 => Change Console color in NEAR
c $B334 Object procedure: flip trigger "C": set/remove wall in room #R$8D5C
C $B33C,2 => Change Console color in NEAR
c $B33E Object procedure: flip trigger "B": set/remove wall in room #R$8F20
C $B346,2 => Change Console color in NEAR
c $B348 Object procedure: flip trigger "A": set/remove wall in room #R$7F48
N $B350 Change Console color in NEAR, so we see that console action worked
C $B350,3 address in screen attributes
C $B353,3 28
C $B356,2 3 rows
C $B358,2 4 columns
C $B361,1 next row
C $B365,3 => Update Ninja on tilemap
c $B368 Room #R$97A6 initialization
C $B368,3 get trigger "E" value
C $B36E,3 => Finish Room 97A6 initialization
c $B371 Play melody ??; HL = melody address
c $B38F Room token #00: Barrel, 3x3 tiles #R$7C21; params: 2 bytes (address)
C $B396,3 Tile block address
C $B3AC,3 => #R$B702 Proceed to the next room token
s $B3AF
c $B3B0
C $B3B6,3 current dog data address
C $B3E1,3 Mirror table address
C $B3EE,1 store reversed byte
C $B3F8,3 set REPDEL = 1
C $B3FB,3 set REPPER = 1
s $B401
c $B40A Initialize a guard
R $B40A HL Guard data address, see #R$A1E1
C $B40A,3 address to store guard data
C $B40D,3 Save Guard data address
C $B416,3 set Guard state
C $B41A,1 get Guard direction from Guard data
C $B41B,3 set Guard direction
c $B41F Standard room procedure (for 63 rooms)
c $B422 Standard room initialization (for 60 rooms)
C $B422,3 => Finish room initialization
c $B425 Rooms #R$7C9C/#R$92EF initialization (redirect from #R$791B)
C $B425,3,3 Guard data address
C $B428,3,3 Initialize a guard
C $B42B,3 => Finish room initialization
c $B42E Room #R$79C6 initialization
C $B42E,3,3 Dog data address
C $B431,3,3 Initialize a dog
C $B434,3 => Finish room initialization
c $B437 UNUSED: Room XXXX initialization
C $B43A,3,3 Initialize a dog
C $B440,3,3 Initialize a guard
C $B443 => Finish room initialization
c $B446 Room #R$B513 procedure (initial Room)
C $B446,3 Processing in the initial room
C $B449,3 Standard room procedure
c $B44C Room procedure (for 19 rooms with a guard) (redirect from #R$7918)
C $B44C,3 Process a guard
C $B44F,3 Standard room procedure
c $B452 Room procedure (for 18 rooms with a dog)
C $B452,3 Process a dog
C $B455,3 Standard room procedure
c $B458 Room procedure (for 5 rooms with a guard and a dog)
C $B458,3 Process a dog
C $B45B,3 Process a guard
C $B45E,3 Standard room procedure
c $B461 Turret initialization
R $B461 HL turret data address
C $B461,1 get Turret offset low byte
C $B463,1 get Turret offset high byte
C $B464,1 save offset
C $B465,3 Tile screen 1 start address
C $B469,3 set Turret address on Tile Screen 1
C $B470,3 set Turret address on Tile Screen 5
C $B473,1 restore offset
c $B47A Room procedure (for 2 rooms with a turret and a dog)
C $B47A,3 Process a dog
C $B47D,3 Process turret
C $B480,3 Standard room procedure
c $B483 Room procedure (for 14 rooms with a turret)
C $B483,3 Process turret
C $B486,3 Standard room procedure
c $B489 Process turret
C $B489,3 get Turret counter
C $B48C,1 decrease counter
C $B48D,3 !!MUT-ARG!! Turret address on Tile Screen 5
C $B4AB,3 -30
C $B4C3,2 !!MUT-ARG!! ??
C $B4C6,3 update Turret counter
C $B4CB,3 !!MUT-ARG!! set "need update" mark for Turret on Tile Screen 1
C $B4D0,3 get Ninja X
C $B4D3,2 !!MUT-ARG!! Turret counter value
b $B4DD
B $B4DD,1,1 Turret counter 50..0
c $B4DE Increase PAY value by B * 100
C $B4DE,3 PAY value 3rd digit address
C $B4E1,2 ':' = '9' + 1
C $B4E8,2 '0'
C $B4EA,1 previous digit
C $B4EF,3 Pay value text address
C $B4F2,2 five digits
C $B4F4,3 Screen address
C $B4F7,3 => Print string, and RET
c $B4FA Processing in initial room - the boat moving
b $B513 Room B513: Initial Room
N $B513 #HTML[<img src="images/rooms/B513.png" />]
W $B513,2,2 Room procedure
W $B515,2,2 Initialization
W $B517,2,2
W $B519,2,2 Room to Right
W $B51B,2,2
W $B51D,2,2
B $B51F,2 Fill entire screen with $0D
B $B521,5 Fill horz 30 tiles with $F5 at $6770
B $B526,5 Fill horz 30 tiles with $0B at $70EE
B $B52B,6 Rectangle 30x3 tiles with $0C at $710C
B $B531,1 End of sequence
c $B532 Movement handler for initial room (B8CE handler)
C $B535,1 increase Ninja position in tilemap
C $B539,3 Ninja X address
C $B540,3 Boat sprite address
C $B546,2 copy Boat sprite
C $B56B,2 delay
C $B570,3 counter address
C $B573,1 decrease counter
C $B574,3 => Update Ninja on tilemap
C $B577,3 Ninja X address
C $B57A,1 Moving right one tile
C $B57E,1 increase Ninja position in tilemap
C $B587,3 Sprite Ninja jumping 3
C $B58A,3 Movement handler address
C $B592,3 Set movement handler = HL, Ninja sprite = DE
C $B58F,3 set counter = 4
b $B595
c $B596
b $B59B
c $B59E
b $B5A7 Boat sprite for initial room
B $B5A7
B $B5A8,8,8 #HTML[<img src="images/blocks/b5a8.png" />]
w $B5B0 Table of items: addresses for NEAR/HELD items
W $B5B0,2,2 #0 Nothing
W $B5B2,2,2 #1 Shuriken
W $B5B4,2,2 #2 Knife
W $B5B6,2,2 #3 ??
W $B5B8,2,2 #4 Brick
W $B5BA,2,2 #5 Pipe
W $B5BC,2,2 #6 Granade
W $B5BE,2,2 #7 Disk
W $B5C0,2,2 #8 Bomb
W $B5C2,2,2 #9 Console
b $B5C4
B $B5C4,1,1 Time fast counter 50..0
B $B5C5,1,1 Ninja standing counter
B $B5C6,1,1 Time mode: $00 = time ticking; $01 = Time stopped; $02 = BOMB ticking mode
c $B5C7
C $B5C7,3 Reset Guard data and Dog data
C $B5DA,2 command = $C5 PUSH BC
C $B5DC,3 set command = PUSH BC = enable Energy decrease
C $B5E5,3 Object procedure address for "Update Ninja on tilemap"
C $B5E8,3 set Object procedure for object #6 in Table of objects #R$D256
C $B5F0,3 Pay value text address
C $B5F9,3 Draw game screen frames and indicator text
C $B5FD,3 set BORDCR = 0
C $B600,3 set Time mode = time ticking
C $B603,3 clear HELD tile
C $B606,3 set tile in Ninja sprite
C $B609,2 set border black, sound off
C $B60C,3 set head tile for Ninja/Guard standing sprite
C $B60F,3 set Ninja direction = 1 = right
C $B612,3 set NEAR item = 1
C $B61B,3 address for Table of items
C $B621,3 Set initial data in Table of Objects
C $B627,3 set current Dog data address = no dog
C $B62A,3 set current Guard data address = no guard
C $B643,3 Initial room address
C $B646,3 set Current Room address
C $B649,3 movement handler for initial room
C $B64C,3 set movement handler address
C $B64F,3 Sprite Ninja sitting
C $B652,3 set Ninja sprite address
C $B657,3 set Ninja X = 1
C $B65C,3 set Ninja Y = 5
C $B662,3 set Ninja position in tilemap: Y * 30 + X
C $B667,3 set counter = 19
c $B66A Current Room changed, entering the new Room
C $B66D,3 !!MUT-ARG!! address for current Dog flag
C $B673,3 !!MUT-ARG!! current Dog data address
C $B67B,3 For first drawing entering the room, skip Dog and Guard tiles drawing
C $B681,3 Find record for the current room in #R$DE84 table
C $B686,2 found =>
C $B68B,1 get flag
C $B695,3 !!MUT-ARG!! current Guard data address
C $B69D,3 get Guard state
C $B6A2,3 get Guard direction
C $B6A9,3 set current Dog data address = no dog
C $B6AC,3 set current Guard data address = no guard
C $B6B0,3 clear Explosion counter
C $B6BF,3 Tile screen 0 start address
C $B6C2,1 fill with $00
C $B6C7,3 510 - 1
C $B6CA,3 Tile screen 0 start address + 1
C $B6CD,2 Fill Tile screen 0
C $B6CF,3 Tile screen 4 start address
C $B6D2,2 fill with transparent tile
C $B6D4,3 510 + 510 - 1
C $B6D7,3 Tile screen 4 start address
C $B6DA,2 Fill Tile screen 4 and Tile screen 5
C $B6DC,3 get Current Room address
C $B6E1,1 get Room init address low byte
C $B6E4,1 get Room init address high byte
C $B6E6,3 set Room init address
C $B6ED,1 now HL = room sequence start address
C $B6EE,1 get next token
C $B6EF,2 End of sequence?
C $B6F1,3 !!MUT-ARG!! yes => run Room initialization code
C $B6F4,1 Save address in the room sequence
C $B6F8,1 * 2
C $B6F9,3 Table of Room tokens
C $B6FC,1 now HL = address in the table
C $B6FD,1 get address low byte
C $B6FF,1 get address high byte
C $B700,1 now HL = room token procedure address
C $B701,1 => run token procedure
c $B702 Proceed to the next room token
C $B702,1 Restore address in the room sequence
C $B703,1 to next token
C $B704,2 => continue room sequence processing
w $B706 Table of Room tokens
W $B706,2,2 #00: Put 3x3 tiles $7C21; params: 2 bytes (address)
W $B708,2,2 #01: Fill to down; params: 4 bytes (count, filler, address)
W $B70A,2,2 #02: Fill to right; params: 4 bytes (count, filler, address)
W $B70C,2,2 #03: Fill rectangle; params: 5 bytes (filler, width, height, address)
W $B70E,2,2 #04: Fill whole Tile screen 0 with one tile; params: 1 byte (filler)
W $B710,2,2 #05: Copy block of tiles; params: 6 bytes (width, height, srcaddr, address)
W $B712,2,2 #06: Fill triangle from wide top; params: 4 bytes (filler, count, address)
W $B714,2,2 #07: Fill triangle from wide bottom; params: 4 bytes (filler, count, address)
W $B716,2,2 #08: Fill triangle from wide bottom; params: 4 bytes (filler, count, address)
W $B718,2,2 #09: Fill triangle from wide top; params: 4 bytes (filler, count, address)
W $B71A,2,2 #0A: Fill to down-right; params: 4 bytes (count, filler, address)
W $B71C,2,2 #0B: Fill to down-left; params: 4 bytes (count, filler, address)
W $B71E,2,2 #0C: Copy block of tiles N times; params: 6 bytes (srcaddr, width, count, address)
W $B720,2,2 #0D: Set border color; params: 1 byte
W $B722,2,2 #0E: Put one tile at the given address; params: 3 bytes (tile, address)
c $B724 Finish room initialization
N $B724 Called to finish room initialization from room initialization procedure
C $B724,3 Tile screen 1 start address
C $B727,2 Filler = $01 = "need update" mark
C $B729,3 510 - 1
C $B72C,3 Tile screen 1 start address + 1
C $B731,3 Tile screen 2 start address
C $B734,2 Filler = transparent tile
C $B736,3 510 - 1
C $B739,3 Tile screen 2 start address + 1
C $B73E,3 Tile screen 3 start address
C $B741,2 Filler = transparent tile
C $B743,3 510 - 1
C $B746,3 Tile screen 3 start address + 1
C $B74B,3 Draw tile map on the screen
C $B74E,3 Table of objects address
C $B751,2 35 objects - BUG: actually, 29 objects
C $B753,1 save address in Table of objects
C $B754,3 get Current Room address, low byte
C $B75B,3 get Current Room address, high byte
C $B762,1 get address in Tile screen 0, low byte
C $B764,1 get address in Tile screen 0, high byte
C $B766,1 get tile byte
C $B767,1 set tile byte in Tile screen 0
C $B768,1 restore address in Table of objects
C $B76C,1 next object
C $B76D,2 continue loop by objects
C $B76F,3 get Guard state
C $B778,3 set Guard state = $0A
c $B77B Game loop start
C $B77C,3 clear LASTK
C $B781,3 get LASTK
C $B784,3 get Time mode
C $B787,2 time stopped?
C $B789,2 yes =>
N $B78B Decrease Time, check if Time is out
C $B78B,3 address for Time fast counter
C $B78E,1 decrease the counter
C $B78F,2 not zero => skip Time decrease
C $B791,2 reset fast counter to 50
C $B793,3 address for Time lower digit
C $B796,1 Decrease Time lower digit
C $B79C,2 '9'
C $B79E,1 go to higher digit
C $B79F,1 decrease Time higher digit
C $B7A1,3 time is out =>
C $B7A4,3 screen address for timer value
C $B7A7,3 Indicator Time value address
C $B7AA,2 Two digits
C $B7AC,3 Print string
N $B7AF Check for BOMB
C $B7AF,3 check Object #7 in Table of objects #R$D256
C $B7B2,2 BOMB tile in the place of Diskette?
C $B7B4,2 no => skip
N $B7B6 BOMB ticking mode
C $B7B6,3 Time mode address
C $B7BB,1 already in BOMB ticking mode?
C $B7BE,1 set Time mode = BOMB ticking mode
C $B7BF,3 "BOMB"
C $B7C2,3 screen address under timer value
C $B7C7,3 Print string "BOMB"
C $B7CA,3 !!MUT-ARG!! "99" bomb timer initial value
C $B7CD,3 set Indicator Time value
C $B7D8,3 28
C $B7EA,3 Increase PAY value by 5000
C $B7ED,3 Tile screen 1 start address
C $B7F0,2 "no need to update" value
C $B7F2,3 510 - 1
C $B7F5,3 Tile screen 1 start address + 1
C $B7FA,3 Set update flags for Ninja, 6x7 tiles
C $B7FD,3 Tile screen 2 start address
C $B802,3 510 - 1
C $B805,3 Tile screen 2 start address + 1
C $B808,2 Fill the Tile screen 2
C $B80B,3 clear Object tile
C $B80F,2 35 = number of records in #R$D256
C $B811,3 Table address
N $B814 Loop through the table
C $B814,1 get byte +$00
C $B817,1 get byte +$01
C $B81A,1 save address in the table
C $B81F,1 add Ninja position in tilemap
C $B820,1 restore address in the table
C $B821,1 get byte +$02
C $B827,1 get byte +$03
C $B82B,3 address to store Object tile and Object procedure address
C $B82F,4 store Object address + 4
C $B833,1 get byte +$04/$05/$06
c $B83C Increase Energy a bit
C $B83C,3 get Energy lower
C $B841,3 set Energy lower
C $B845,3 Energy address
C $B848,1 increase Energy
b $B84A
W $B84A,2,2 Object address + 4, in table #R$D256
B $B84C,1,1 Object tile
W $B84D,2,2 Object procedure address
B $B84F,1,1 NEAR item
B $B850,1,1 HELD tile
c $B851 Set initial data in Table of Objects
C $B851,2 35 objects
C $B853,3 7 = size of record in Table of Objects
C $B856,4 = #R$D256 (address for Table of Objects) + 3
C $B85A,3 address for table with initial data
C $B85E,3 set byte +$03 in the record
C $B863,3 set byte +$04 in the record
C $B867,2 next record
C $B869,2 continue the loop
c $B86C ?? Adjust table #R$751B by DE
R $B86C DE ??
R $B86C A ??
c $B889
C $B88E,3 continue the loop through the table
C $B891,3 NEAR item address
C $B8A4,3 Draw NEAR/HELD item
C $B8A8,3 -26
C $B8B0,3 HELD tile address
C $B8C5,3 Draw NEAR/HELD item
C $B8CD,3 !!MUT-ARG!! => run handler
c $B8D0 Update Ninja on tilemap
C $B8D0,3 Set update flags for Ninja, 6x7 tiles
C $B8D3,3 Tile screen 4 start address
C $B8D8,3 510 - 1
N $B8E0 Draw Ninja on tilemap
C $B8E0,3 get Ninja position in tilemap
C $B8E3,3 get Ninja direction
C $B8E6,2 left?
C $B8EE,4 get Ninja sprite address
C $B907,3 Tile screen 2 start address
C $B90B,4 get Ninja sprite address
C $B922,3 Tile screen 3 start address
C $B927,3 Tile screen 3 start address + 1
C $B92A,3 510 - 1
C $B92F,3 get Current Room address
c $B937 Standard room procedure (redirect from #R$B41F)
C $B94F,3 !!MUT-ARG!!
C $B959,3 -30
C $B963,3 +30
C $B9A7,3 get object X
C $B9B5,3 Tile screen 0 start address
C $B9C1,3 Tile screen 3 start address
C $B9DB,3 Tile screen 4 start address
C $B9E4,3 get Guard state
C $B9EE,3 set Guard state = $09
C $B9F3,3 Increase PAY value by 100 - Guard killed by weapon
C $BA03,3 Tile screen 2 start address
C $BA0E,3 Decrease Energy by B = 20
C $BA2A,3 !!MUT-ARG!!
C $BA3A,3 +30
C $BA41,3 Draw tile map on the screen
C $BA44,3 Restore drawing of Dog and Guard tiles
C $BA4A,3 Explosion counter address
C $BA4F,3 => Game loop start
N $BA52 Draw Explosion image on the screen and make some noise
C $BA57,3 !!MUT-ARG!! address on the screen
C $BA5A,3 !!MUT-ARG!! Explosion image address
C $BA5D,2 !!MUT-ARG!!
C $BA5F,2 !!MUT-ARG!!
C $BA8E,3 !!MUT-ARG!! address in screen attributes
C $BA96,2 !!MUT-ARG!!
C $BAA9,3 !!MUT-ARG!!
C $BAAF,3 => Game loop start
b $BAB2
B $BAB2,1,1 Explosion counter address
W $BAB3,34,8 Screen addresses for every 17 rows; used to draw Explosion
c $BAD5
C $BAD8,2 current room address low byte = $CA ?
C $BADF,2 current room address high byte = $8D ?
C $BAE1,3 room #R$8DCA (room with helicopter) =>
C $BAE7,2 Granade?
C $BAF0,3 Explosion counter address
C $BB09,3 get object Y
C $BB0C,1 * 2
C $BB14,1 * 32
C $BB15,1 now HL = address in screen attributes
C $BB18,3 get object X
C $BB1C,3 set screen attributes address for Draw Explosion procedure
C $BB1F,3 set offset in BAB3 table
C $BB23,3 set offset in BAB3 table
C $BB28,4 Address for table of screen addresses for 17 rows
C $BB2C,3 !!MUT-ARG!!
C $BB2F,3 !!MUT-ARG!! now HL = screen address
C $BB34,1 + object X
C $BB35,3 set screen address for Draw Explosion procedure
C $BB3B,3 +33
C $BB47,3 Explosion image address
C $BB51,3 get object Y
C $BB54,2 16 ?
C $BB58,1 decrease height
C $BB5D,1 decrease height
C $BB5E,3 +30
C $BB66,3 Explosion image address + 24
C $BB6A,3 get object X
C $BB6D,2 29 ?
C $BB71,1 decrease width
C $BB76,1 decrease width
C $BB7A,1 Explosion image address + 1
C $BBA2,4 set Explosion image address
C $BBA8,3 delete the object
c $BBAE Set "need update" mark for object IX
C $BBB4,3 Tile screen 1 start address
C $BBB8,2 set "need update" mark
c $BBBB Set update flags for Ninja, 6x7 tiles
C $BBBB,3 get Ninja position in tilemap
C $BBBE,3 Tile screen 1 start address
C $BBC2,3 24
C $BBC5,2 "need to update" mark
C $BBC7,2 7 rows
C $BBC9,2 6 columns
C $BBCB,1 set the flag
C $BBCE,2 continue by columns
C $BBD0,1 next row
C $BBD1,2 continue by rows
c $BBD4 Movement handler: Ninja punching
C $BBD4,3 Read Input
C $BBD7,2 check FIRE bit
C $BBD9,3 => Update Ninja on tilemap
C $BBDC,3 => Ninja standing
c $BBDF Read Input
C $BBFF,1 * 8
C $BBE4,1 Input method = Keyboard/Protek?
C $BBE7,2 read joystick port
C $BBE9,3 store input bits
C $BC0B,2 => store input bits and RET
c $BC0D
N $BC0D Prepare screen background for title picture
C $BC0D,3 !!MUT-ARG!!
C $BC13,3 Melody start address
C $BC16,3 set melody current address
C $BC24,2 clear screen
N $BC38 Show the title picture
C $BC38,3,3 Show title picture (two ninjas)
C $BC48,3 address of string 10 spaces
N $BC9D Check for suicide key combination
c $BC55 Movement handler: Ninja standing
N $BC55 Increase Energy if needed
C $BC55,3 Ninja standing counter address
C $BC58,1 decrease counter
C $BC5B,2 reload the counter
C $BC5D,3 get Energy
C $BC60,2 energy at MAX?
C $BC64,3 get Energy lower
C $BC6B,3 Increase Energy a bit
C $BC70,3 Decrease Energy by B
C $BC73,3 Increase Energy a bit
N $BC76 Move the head (idle animation)
C $BC76,3 address for head movement counter
C $BC79,1 increase counter
C $BC7A,2 not zero => skip head animation
C $BC7C,2 reset counter (how often head moves)
C $BC81,2 toggle tile
C $BC83,3 set head tile
C $BC89,2 toggle between $01 and $F5 tiles
C $BC8B,3 set head tile for Ninja/Guard standing sprite
C $BC91,2 toggle tile
C $BC93,3 update the tile
C $BCA1,2 check for CAPS SHIFT key
C $BCA3,2 not pressed => skip suicide
C $BCA9,2 check for "1" key
C $BCAB,2 not pressed => skip suicide
C $BCAD,3 "SEPUKU" / "MISSION ABORTED"
C $BCB0,3 set two-line Game Over message
C $BCB3,3 => Ninja sit, and then fall and DIE
C $BCB6,3 Check for falling
C $BCB9,3 => Ninja falling
C $BCC4,3 Read Input
C $BCC7,2 check FIRE bit
N $BCCC FIRE pressed, ninja standing
C $BCCC,3 action cooldown counter
C $BCD0,1 check if counter is 0
C $BCD1,3 not zero =>
C $BCD4,2 reset cooldown (5 ticks until next action)
C $BCD6,3 get Object tile
C $BCDB,2 => execute the object procedure
C $BCDE,3 get Ninja position in tilemap
C $BCE1,3 $6669 = $6590 (Tile screen 0) + 217
C $BCEA,3 get Time mode
C $BCED,2 BOMB ticking mode?
C $BCEF,2 yes =>
C $BCF4,1 Object tile = nothing?
C $BCF5,2 nothing =>
C $BCF7,3 get HELD tile
C $BCFA,4 get Object address + 4
C $BCFE,1 set Object tile
C $BD00,2 held nothing?
C $BD02,2 nothing =>
C $BD0B,3 set ?? in Object #7 in Table of objects #R$D256
C $BD14,3 => Update Ninja on tilemap
C $BD17,3 Time mode address
C $BD1A,1 0 = time ticking
C $BD1C,3 => Update Ninja on tilemap
C $BD1F,2 set Time mode = time stopped
C $BD24,3 Play melody
C $BD27,2 50
C $BD29,3 Increase PAY value by 5000
C $BD2C,3 => Update Ninja on tilemap
t $BD2F "BOMB" message
c $BD33
C $BD33,3 get object procedure address
C $BD36,1 execute the object procedure
c $BD37 Fire pressed, Ninja standing, no object nearby
C $BD3F,3 get HELD tile
C $BD42,2 nothing?
C $BD4C,2 BOMB?
C $BD52,3 get Ninja position in tilemap
C $BD55,3 61
C $BD59,3 get Ninja X
C $BD5E,3 get Ninja direction
C $BD71,3 get Ninja Y
C $BD79,2 !!MUT-ARG!!
C $BD84,3 get Ninja direction
C $BD87,2 left?
C $BD89,2 left =>
C $BD91,3 get Input bits
C $BD94,2 check UP bit
C $BD9B,2 check DOWN bit
C $BDA9,3 Sprite Ninja/Guard punching
C $BDAC,3 Set movement handler = HL, Ninja sprite = DE
c $BDAF Ninja standing (redirect)
C $BDAF,3 => Ninja standing
c $BDB2
C $BDB2,3 get Ninja position in tilemap
C $BDB5,3 $6DAA = $6D88 (Tile screen 4) + 34 for right
C $BDB8,3 get Ninja direction
C $BDBB,2 right?
C $BDBD,2 right =>
C $BDBF,3 $6DA7 = $6D88 (Tile screen 4) + 31 for left
C $BDC2,1 now HL = address in Guard tilemap
C $BDC3,1 get tile
C $BDC4,1 empty tile?
C $BDC5,2 empty =>
C $BDC9,3 set Guard state = $09 dead
C $BDCF,2 5 hundreds
C $BDD1,3 Increase PAY value by 500 - Guard killed by punch/kick
C $BDD4,3 Movement handler address
C $BDD7,3 Sprite Ninja/Guard punching
C $BDDA,3 Set movement handler = HL, Ninja sprite = DE
c $BDDD
C $BDE5,4 get Ninja position in tilemap
C $BDF2,3 set counter = 11
C $BE04,3 Movement handler
C $BE07,3 Sprite Ninja/Guard standing
C $BE0A,3 Set movement handler = HL, Ninja sprite = DE
c $BE0D Movement handler: opening the roof in the helicopter room
C $BE10,2 tile / "need to update" flag
C $BE0D,3 !!MUT-ARG!! Tile screen 0 + 33
C $BE17,3 511
C $BE1C,3 !!MUT-ARG!!
C $BE24,3 509
C $BE29,3 counter address
C $BE2C,1 decrease counter
C $BE2D,3 => Update Ninja on tilemap
C $BE30,2 reset the counter
C $BE38,2 10
C $BE43,3 set Ninja position in tilemap
C $BE4C,3 210 - 1 = 7 rows
C $BE51,3 Movement handler: helicopter moving up
C $BE54,3 Empty sprite
C $BE57,3 Set movement handler = HL, Ninja sprite = DE
c $BE5A Ninja sit, and then fall and DIE
C $BE5A,3 Movement handler: Ninja dead
C $BE5D,3 Sprite Ninja sitting
C $BE60,3 Set movement handler = HL, Ninja sprite = DE
c $BE63 Movement handler (B8CE handler): Ninja dead
C $BE63,2 command = $C9 RET
C $BE65,3 set command = RET = disable Energy decrease
C $BE68,3 Movement handler: Game Over
C $BE6B,3 Sprite Ninja dead
C $BE6E,3 Set movement handler = HL, Ninja sprite = DE
c $BE71 Time is out
C $BE71,3 get Time mode
C $BE74,2 BOMB ticking mode?
C $BE76,2 yes =>
C $BE78,3 "TIME OUT" / "MISSION TERMINATED"
C $BE7B,3 set two-line Game Over message
C $BE7E,2 => Ninja dead
N $BE80 BOMB time is out, BOMB explodes
C $BE93,2 17
C $BE95,2 30
N $BEAA Saboteur is dead
C $BEAB,3 "SABOTEUR DEAD" / "MISSION FAILURE"
C $BEAE,3 set two-line Game Over message
C $BEB1,2 => Ninja dead
c $BEB3 Movement handler: Game Over
C $BEB3,3 !!MUT-ARG!! two-line message address
C $BEBB,3 Print string 1st line
C $BEC3,3 Print string 2nd line
C $BEDA,3 Pause, then wait for any key pressed
C $BEDF,1 !!MUT-CMD!!
C $BEE7,2 "LD A,(BC)" instruction code
C $BEEC,3 => Title picture and music, then go to Main menu
t $BEEF Game over two-line messages
T $BEEF,15
T $BEFE,20
T $BF12,15
T $BF21,20
T $BF35,15
T $BF44,20
T $BF58,15
T $BF67,20
c $BF7B
C $BF7B,3 $6592 = $6590 (Tile screen 0) + 2
C $BF82,3 => Object procedure
C $BF87,3 => Update Ninja on tilemap
C $BF8C,3 set counter = 3
C $BF8F,3 get Ninja direction
C $BF92,2 left?
C $BF94,3 get Input bits
C $BF99,2 check RIGHT bit
C $BFA0,2 check LEFT bit
C $BFA5,3 Movement handler: Ninja jumping
C $BFAA,3 set counter = 2
C $BFAD,3 Sprite Ninja/Guard jumping
c $BFB0 Set movement handler = HL, set Ninja sprite = DE
C $BFB3,4 set Ninja sprite address = DE
C $BFB7,3 => Update Ninja on tilemap
c $BFBA
C $BFBF,3 get Ninja position in tilemap
C $BFC9,3 => Ninja on ladder
C $BFCC,3 Movement handler: Ninja sitting
C $BFCF,3 Sprite Ninja sitting
C $BFD2,3 Set movement handler = HL, Ninja sprite = DE
c $BFD5 Escaped; clear screen, show final messages, then Game Over
C $BFD7,3 Increase PAY value by 1000 - Escape by Helicopter
C $BFE3,3 Increase PAY value by 5000
C $BFE6,3 Screen start address
C $BFF1,2 Clear whole screen
C $BFF8,2 Clear all attributes
C $BFFA,3 Messages address
C $BFFD,3 Screen address
C $C002,3 Print string "DISK RETRIEVED"
C $C00A,3 Print string "DISK BONUS: $05000"
C $C012,3 Print string "LEVEL"
C $C01A,3 Print string "TOTAL PAY : $"
C $C020,3 Messages address
C $C025,3 Print string "BONUS: $05000"
C $C030,3 Print string
C $C037,3 Increase PAY value by B * 100
C $C03D,3 Skill level address
C $C042,3 Print skill level digit
C $C045,2 "INC D" instruction code
C $C04A,3 get Time mode
C $C04D,2 BOMB ticking mode?
C $C04F,2 no =>
C $C051,2 100
C $C053,3 Increase PAY value by 10000 - Escape with Disk and Bomb
C $C056,3 "ESCAPE" / "MISSION SUCCESSFUL"
C $C059,3 set two-line Game Over message
C $C05F,3 => Game Over
t $C062
T $C062,14
T $C070,5
T $C075,13
T $C082,5
T $C087,13
c $C094 Movement handler: helicopter moving up
C $C094,3 counter address
C $C097,1 decrease counter
C $C098,3 zero => Escaped; final messages, then Game Over
C $C0E3,3 => Update Ninja on tilemap
b $C0E6 Empty sprite
c $C12E Ninja on ladder
C $C12E,3 Movement handler for Ninja on ladder
C $C134,3 Sprite Ninja on ladder
C $C137,3 set Ninja sprite address
C $C13A,3 => Move down one tile
c $C13D
C $C141,3 Ninja direction address
C $C145,1 left?
C $C149,2 => Update Ninja on tilemap
C $C14B,3 Movement handler address
C $C14E,3 Sprite Ninja/Guard walking 1
C $C151,3 Set movement handler = HL, Ninja sprite = DE
C $C158,3 Ninja direction address
C $C15C,1 left?
C $C160,2 => Update Ninja on tilemap
C $C162,3 Movement handler address
C $C168,3 Sprite Ninja/Guard walking 1
C $C16B,3 set Ninja sprite address
C $C16E,3 => Update Ninja on tilemap
b $C171
c $C1B6 Movement handler ?? (B8CE handler)
C $C1B6,3 get Ninja X
C $C1B9,2 24 ?
C $C1BB,3 => Going to room at Right
C $C1BE,3 get Ninja position in tilemap
C $C1CA,3 Ninja Y address
C $C1CD,1 one row up
C $C1CE,3 get Ninja position in tilemap
C $C1D1,3 -30
C $C1D5,3 set Ninja position in tilemap
C $C1DA,3 -29
C $C1E3,3 Read Input
C $C1E6,2 check RIGHT bit
C $C1E8,3 => Ninja standing
C $C1EB,3 => Update Ninja on tilemap
C $C1EE,3 +59
C $C1F9,3 get Ninja position in tilemap
C $C1FC,3 +30
C $C200,3 set Ninja position in tilemap
C $C203,3 Ninja Y address
C $C206,1 one row down
C $C208,2 at the room bottom?
C $C20A,3 yes => Going to room Down from current
C $C20D,3 Ninja X address
C $C211,3 get Ninja position in tilemap
C $C214,1 move one tile to right
C $C215,3 set Ninja position in tilemap
C $C218,3 Check for falling
C $C21B,3 => Ninja falling
C $C21E,3 Read Input
C $C221,2 check RIGHT bit
c $C226 Ninja standing
C $C226,3 Movement handler: Ninja standing
C $C229,3 Sprite Ninja/Guard standing
C $C22C,3 Set movement handler = HL, Ninja sprite = DE
c $C22F Movement handler (B8CE handler): Ninja sitting
C $C22F,3 Read Input
C $C232,2 check DOWN bit
C $C234,2 still pressed =>
C $C236,3 DOWN key released => stand up
C $C239,3 get Ninja position in tilemap
C $C245,3 => Decrease Energy by B
C $C248,3 => Object procedure
c $C24B Movement handler (B8CE handler): Ninja walking
C $C24B,3 get Ninja X
C $C24E,2 at very left?
C $C250,3 => Going to room at Left
C $C253,3 get Ninja position in tilemap
C $C256,3 = $6590 (Tile screen 0) + 181
C $C25F,3 Ninja Y address
C $C262,1 moving one row up
C $C263,3 get Ninja position in tilemap
C $C266,3 -30
C $C269,1 one row up
C $C26A,3 set Ninja position in tilemap
C $C26F,3 -31
C $C278,3 Read Input
C $C27B,2 check LEFT bit
C $C27D,3 => Ninja standing
C $C280,3 => Update Ninja on tilemap
C $C283,3 +61
C $C28E,3 get Ninja position in tilemap
C $C291,3 +30
C $C295,3 set Ninja position in tilemap
C $C298,3 Ninja Y address
C $C29B,1 moving one row down
C $C29D,2 at room bottom?
C $C29F,3 => Going to room Down from current
C $C2A2,3 Ninja X address
C $C2A5,1 moving one tile left
C $C2A6,3 get Ninja position in tilemap
C $C2A9,1 moving one tile left
C $C2AA,3 set Ninja position in tilemap
C $C2AD,3 Check for falling
C $C2B0,3 => Ninja falling
C $C2B3,3 Read Input
C $C2B6,2 check LEFT bit
C $C2B8,3 => Ninja standing
N $C2BB LEFT or RIGHT key pressed
C $C2BB,2 check for UP bit
C $C2BF,3 set counter = 7
C $C2C8,1 next walking phase
C $C2C9,2 0..3
C $C2CE,1 * 2
C $C2EA,3 Table of four Ninja/Guard walking sprites
C $C2EE,3 address for Ninja sprite address
C $C2F7,3 => Object procedure
c $C2FA Going to room at Right
C $C2FB,3 set Ninja X = 0
C $C2FE,3 -24
C $C304,1 update Ninja position in tilemap
C $C308,3 get Current Room address
C $C30B,3 offset in Room description
C $C30F,1 get Room Right address low byte
C $C311,1 get Room Right address high byte
C $C313,3 set Current Room address
C $C316,3 => Current Room changed
c $C319 Going to room at Left
C $C31B,3 set Ninja X = 24
C $C31E,3 +24
C $C324,1 update Ninja position in tilemap
C $C328,3 get Current Room address
C $C32B,3 offset in Room description
C $C32F,1 get Room Left address low byte
C $C331,1 get Room Left address high byte
C $C333,3 set Current Room address
C $C336,3 => Current Room changed
c $C339 Movement handler (B8CE handler): Ninja jumping
C $C339,3 counter address
C $C33C,1 decrease counter
C $C33D,3 => Update Ninja on tilemap
C $C340,3 get Ninja direction
C $C343,3 get Ninja position in tilemap
C $C346,3 $6592 = $6590 (Tile screen 0) + 2
C $C34A,2 direction = left ?
C $C34C,2 no =>
C $C36B,2 => Ninja on ladder
C $C370,3 get Ninja position in tilemap
C $C373,3 get Ninja direction
C $C376,2 left ?
C $C384,3 Movement handler
C $C387,3 Sprite Ninja/Guard jump-kick
C $C38C,3 set counter = 3
C $C38F,3 Set movement handler = HL, Ninja sprite = DE
c $C392 Check if tile is a ladder
c $C3BB Move LEFT one tile
C $C3BB,3 Ninja X address
C $C3BE,1 one tile to left
C $C3BF,3 get Ninja position in tilemap
C $C3C2,1 move one tile left
C $C3C3,3 set Ninja position in tilemap
N $C3C6 Ninja on ladder now
C $C3C6,3 Movement handler for Ninja on ladder
C $C3C9,3 Sprite Ninja on ladder
C $C3CC,3 Set movement handler = HL, Ninja sprite = DE
c $C3CF Move RIGHT one tile
C $C3CF,3 Ninja X address
C $C3D2,1 one tile to right
C $C3D3,3 get Ninja position in tilemap
C $C3D6,1 move one tile right
C $C3D7,2 => Set Ninja position in tilemap; Ninja on ladder
c $C3D9 Movement handler (B8CE handler): Ninja on ladder
C $C3D9,3 get Ninja position in tilemap
C $C3DC,3 = $6590 (Tile screen 0) + 183
C $C3E2,1 ladder?
C $C3E3,2 yes => Read and process Input
C $C3E9,3 not ladder => Ninja standing
N $C3EC Read and process Input
C $C3EC,3 Read Input
C $C3EF,2 check RIGHT bit
N $C3F3 Pressed RIGHT
C $C3F3,3 get Ninja position in tilemap
C $C3F6,3 = $6590 (Tile screen 0) + 184
C $C3FF,3 +30
C $C408,3 set Ninja direction = 1 = right
N $C40E Check if LEFT pressed
C $C40E,2 check LEFT bit
N $C412 Pressed LEFT
C $C412,3 get Ninja position in tilemap
C $C415,3 = $6590 (Tile screen 0) + 181
C $C41E,3 +30
C $C426,3 set Ninja direction = 0 = left
N $C42C Check if UP pressed
C $C42C,3 get Input bits
C $C42F,2 check UP bit
N $C433 Pressed UP
C $C433,3 get Ninja position in tilemap
C $C445,2 => Update Ninja on tilemap
C $C447,3 get Ninja Y
C $C44A,2 top row?
C $C44C,3 yes => Going to room Up from current
C $C44F,3 -210 = 7 rows higher
C $C456,2 => Update Ninja on tilemap
C $C45B,2 => Update Ninja on tilemap
C $C45D,3 Ninja Y address
C $C460,1 one row up
C $C461,3 get Ninja position in tilemap
C $C468,3 set Ninja position in tilemap
C $C46B,3 get Ninja direction
C $C46E,1 invert direction
C $C464,3 -30
C $C471,3 set Ninja direction
C $C474,3 => Update Ninja on tilemap
N $C477 Check if DOWN pressed
C $C477,2 check DOWN bit
C $C479,2 => Update Ninja on tilemap
N $C47B Pressed DOWN
C $C47B,3 get Ninja Y
C $C480,3 => Going to room Down from current
C $C483,3 get Ninja position in tilemap
C $C48D,2 => Move down one tile
C $C493,2 => Move down one tile
C $C495,3 => Update Ninja on tilemap
c $C498 Move DOWN one tile
C $C498,3 Ninja Y address
C $C49B,1 one tile down
C $C49C,3 get Ninja position in tilemap
C $C49F,3 +30
C $C4A2 => set Ninja position = HL, invert direction, Object procedure
c $C4A4
C $C4A4,3 get Ninja direction
c $C4A7 ?? Movement handler
C $C4A7,3 counter address
C $C4AA,1 decrease counter
C $C4AB,3 => Update Ninja on tilemap
C $C4AE,3 get Ninja position in tilemap
C $C4B1,3 value for right dir = $6D88 (Tile screen 4) + 65
C $C4B4,3 get Ninja direction
C $C4B7,2 direction = right?
C $C4BB,3 value for left dir = $6D88 (Tile screen 4) + 60
C $C4C0,1 = $FF ?
C $C4C5,3 set Guard state = $09 dead
C $C4D0,3 Movement handler address
C $C4D3,3 Sprite Ninja/Guard jumping
C $C4D8,3 set counter = 1
C $C4CD,3 Increase PAY value by 500 - Guard killed by punch/kick
C $C4DB,3 Set movement handler = HL, Ninja sprite = DE
c $C4DE ?? Movement handler
C $C4DE,3 counter address
C $C4E1,1 decrease counter
C $C4E2,3 => Update Ninja on tilemap
C $C4E5,3 => Ninja standing
c $C4E8
C $C4E8,3 Check for ??
C $C4ED,3 Movement handler address
C $C4F0,3 Sprite Ninja jumping 3
C $C4F3,3 Set movement handler = HL, Ninja sprite = DE
c $C4F6 Movement handler (used in initial room)
C $C4F6,3 Check for ??
C $C4FE,3 Decrease Energy by B
C $C501,3 => Ninja standing
C $C504,3 Movement handler address
C $C507,3 Sprite Ninja jumping 4
C $C50A,3 Set movement handler = HL, Ninja sprite = DE
c $C50D Movement handler ??
C $C50D,3 get Ninja direction
C $C510,2 left?
C $C512,3 Ninja X address
C $C51A,3 => Going to room at Left
C $C51E,3 get Ninja position in tilemap
C $C522,3 set Ninja position in tilemap
C $C525,3 Check for ??
C $C52A,3 counter address
C $C52D,1 decrease counter
C $C535,3 Decrease Energy by B
C $C53D,3 get Ninja position in tilemap
C $C546,3 Ninja Y address
C $C54A,3 get Ninja position in tilemap
C $C54E,3 -30
C $C553,3 set Ninja position in tilemap
C $C55C,3 +30
C $C563,3 Movement handler: switch Ninja to standing
C $C566,3 Sprite Ninja jumping 3
C $C569,3 Set movement handler = HL, Ninja sprite = DE
C $C56E,3 => Going to room at Right
C $C572,3 get Ninja position in tilemap
C $C576,3 set Ninja position in tilemap
c $C57B
C $C57B,3 get Ninja direction
C $C581,1 * 5
C $C585,4 get Ninja position in tilemap
C $C58A,3 Tile screen 0 start address
C $C591,3 +30
C $C59E,1 now Z=0: falling, Z=1: not falling
c $C5A0 Switch Ninja to standing (redirect)
C $C5A0,3 => Ninja standing
c $C5A3 Check for falling
C $C5A3,3 get Ninja position in tilemap
C $C5AA,3 Tile screen 0 start address
C $C5AE,3 get Ninja direction
C $C5B1,2 left?
c $C5C6 Movement handler: Ninja falling down
C $C5C6,3 get Ninja position in tilemap
C $C5C9,3 +30
C $C5CC,1 one row lower
C $C5CD,3 set Ninja position in tilemap
C $C5D0,3 falling counter address
C $C5D3,1 increase falling counter
C $C5D4,3 Ninja Y address
C $C5D7,1 increase Ninja Y
C $C5D8,1 get Ninja Y
C $C5D9,2 at room bottom?
C $C5DB,2 => Going to room Down from current
C $C5DD,3 get Ninja position in tilemap
C $C5EB,3 => Update Ninja on tilemap
N $C5EE Ninja hit somehting after falling
C $C5F3,3 falling counter address
C $C5F6,1 get counter value
C $C5F7,2 clear falling counter
C $C5F9,3 Decrease Energy by B
C $C601,3 => Ninja sitting now
c $C604 Going to room Down from current
C $C605,3 set Ninja Y = 0
C $C608,3 get Ninja position in tilemap
C $C60B,3 -300
C $C60E,1 10 rows higher
C $C60F,3 set Ninja position in tilemap
C $C612,3 get Current Room address
C $C615,3 offset in room description
C $C618,1 now HL = room address + 10
C $C619,1 get Room Down address low byte
C $C61B,1 get Room Down address high byte
C $C61D,3 set Current Room address
C $C620,3 => Current Room changed
c $C623 Going to room Up from current
C $C625,3 set Ninja Y = 10
C $C628,3 get Ninja position in tilemap
C $C62B,3 +300
C $C62E,1 10 rows lower
C $C62F,3 set Ninja position in tilemap
C $C632,3 get Current Room address
C $C635,3 offset in room description
C $C638,1 now HL = room address + 8
C $C639,1 get Room Up address low byte
C $C63B,1 get Room Up address high byte
C $C63D,3 set Current Room address
C $C640,3 => Current Room changed
c $C643 Ninja falling
C $C643,3 Movement handler address: Ninja falling
C $C646,3 Sprite Ninja falling
C $C649,3 Set movement handler = HL, Ninja sprite = DE
c $C64C Room #R$791E (room with pier) initialization
C $C64F,3 = $6590 (Tile screen 0) + 220
C $C652,3 17
C $C655,2 copy bytes to Background
C $C657,3 => Finish room initialization
b $C65A Data for room with pier
b $C66B Guard data for rooms #R$7C9C/#R$92EF
c $C671 Room #R$93DF/#R$947C (room right from Train) initialization
C $C671,3 room #R$947C at left of Train 1
C $C674,3 set "room to left" for room #R$7C9C
C $C677,3 room #R$93DF at right of Train 1
C $C67A,3 set "room to right" for room #R$7C9C
C $C67D,2 tile for "1" sign
c $C681 Room #R$982B initialization
C $C681,3 room #R$9A1E at left of Train 2
C $C684,3 set "room to left" for room #R$7C9C
C $C687,3 room #R$982B at right of Train 2
C $C68A,3 set "room to right" for room #R$7C9C
C $C68D,2 tile for "2" sign
N $C68F Fill 3x3 block with tile for "1"/"2" sign
c $C6A5 Room 7C9C procedure (tunnel Train)
C $C6A2,3 => Finish room initialization
C $C6A5,3 get Ninja X
C $C6AA,3 => Standard room procedure
C $C6AF,3 set counter = 75
C $C6B2,4 get Ninja position in tilemap
C $C6B6,3 get Ninja X
C $C6BC,3 Movement handler: Train moving right
C $C6BF,3 get Ninja direction
C $C6C2,2 left?
C $C6C4,2 right =>
C $C6C6,3 Movement handler: Train moving left
C $C6CE,3 set Ninja X
C $C6D1,4 set Ninja position in tilemap
C $C6D5,3 Sprite Ninja/Guard standing
C $C6D8,4 set Ninja sprite
C $C6DC,3 set Movement handler
C $C6DF,3 => Standard room procedure
c $C6E2 Movement handler (B8CE handler): Train moving left
C $C702,3 counter address
C $C705,1 decrease counter
C $C706,3 => Ninja standing
C $C709,3 => Update Ninja on tilemap
c $C70C Movement handler (B8CE handler): Train moving right
b $C721 Font
N $C721 #HTML[<img src="images/font.png" />]
B $C721,8,8 ' '
B $C729,8,8 '!'
B $C731,8,8 '"'
B $C739,8,8 '#'
B $C741,8,8 '$'
B $C749,8,8 '%'
B $C751,8,8 '&'
B $C759,8,8 '''
B $C761,8,8 '('
B $C769,8,8 ')'
B $C771,8,8 '*'
B $C779,8,8 '+'
B $C781,8,8 ','
B $C789,8,8 '-'
B $C791,8,8 '.'
B $C799,8,8 '/'
B $C7A1,8,8 '0'
B $C7A9,8,8 '1'
B $C7B1,8,8 '2'
B $C7B9,8,8 '3'
B $C7C1,8,8 '4'
B $C7C9,8,8 '5'
B $C7D1,8,8 '6'
B $C7D9,8,8 '7'
B $C7E1,8,8 '8'
B $C7E9,8,8 '9'
B $C7F1,8,8 ':'
B $C7F9,8,8 ';'
B $C801,8,8 '<'
B $C809,8,8 '='
B $C811,8,8 '>'
B $C819,8,8 '?'
B $C821,8,8 '@'
B $C829,8,8 'A'
B $C831,8,8 'B'
B $C839,8,8 'C'
B $C841,8,8 'D'
B $C849,8,8 'E'
B $C851,8,8 'F'
B $C859,8,8 'G'
B $C861,8,8 'H'
B $C869,8,8 'I'
B $C871,8,8 'J'
B $C879,8,8 'K'
B $C881,8,8 'L'
B $C889,8,8 'M'
B $C891,8,8 'N'
B $C899,8,8 'O'
B $C8A1,8,8 'P'
B $C8A9,8,8 'Q'
B $C8B1,8,8 'R'
B $C8B9,8,8 'S'
B $C8C1,8,8 'T'
B $C8C9,8,8 'U'
B $C8D1,8,8 'V'
B $C8D9,8,8 'W'
B $C8E1,8,8 'X'
B $C8E9,8,8 'Y'
B $C8F1,8,8 'Z'
b $C8F9
T $C8F9,1
B $C8FA,3
T $C8FD
B $C90A,3
T $C90D
B $C91A,3
T $C91D
B $C92A,3
T $C92D
B $C93A,3
T $C93D
B $C94A,3
T $C94D
B $C95A,3
T $C95D
B $C96A,3
T $C96D
B $C97A,3
T $C97D
B $C98A,3
T $C98D
B $C99A,3
T $C99D
B $C9AA,3
T $C9AD
B $C9BA,3
T $C9BD
B $C9CA,3
T $C9CD
B $C9DA,3
T $C9DD
B $C9EA,3
T $C9ED
B $C9FA,3
T $C9FD
B $CA0A,3
T $CA0D
B $CA1A,3
T $CA1D
B $CA2A,3
T $CA2D
B $CA3A,3
T $CA3D
B $CA4A,3
T $CA4D
B $CA5A,3
T $CA5D
B $CA6A,3
T $CA6D
B $CA7A,3
T $CA7D
B $CA8A,3
T $CA8D
B $CA9A,3
T $CA9D
B $CAAA,3
T $CAAD
B $CABA,3
T $CABD
B $CACA,3
T $CACD
B $CADA,3
T $CADD
B $CAEA,3
T $CAED
B $CAFA,3
T $CAFD
B $CB0A,3
T $CB0D
B $CB1A,3
T $CB1D
B $CB2A,3
T $CB2D
B $CB3A,3
T $CB3D
B $CB4A,3
T $CB4D
B $CB5A,3
T $CB5D
B $CB6A,3
T $CB6D
B $CB7A,3
T $CB7D
B $CB8A,3
T $CB8D
B $CB9A,3
T $CB9D
B $CBAA,3
T $CBAD
B $CBBA,3
T $CBBD
B $CBCA,3
T $CBCD
B $CBDA,3
T $CBDD
B $CBEA,3
T $CBED
B $CBFA,3
T $CBFD
B $CC0A,3
T $CC0D
B $CC1A,3
T $CC1D
B $CC2A,3
T $CC2D
B $CC3A,3
T $CC3D
B $CC4A,3
T $CC4D
B $CC5A,3
T $CC5D
B $CC6A,3
T $CC6D
B $CC7A,3
T $CC7D
B $CC8A,3
T $CC8D
B $CC9A,3
T $CC9D
B $CCAA,3
T $CCAD
B $CCBA,3
T $CCBD
B $CCCA,3
T $CCCD
B $CCDA,3
T $CCDD
B $CCEA,3
T $CCED
B $CCFA,3
T $CCFD
B $CD0A,3
T $CD0D
B $CD1A,3
T $CD1D
B $CD2A,3
T $CD2D
B $CD3A,3
T $CD3D
B $CD4A,3
T $CD4D
B $CD5A,3
T $CD5D
B $CD6A,3
T $CD6D
B $CD7A,3
T $CD7D
B $CD8A,3
T $CD8D
B $CD9A,3
T $CD9D
B $CDAA,3
T $CDAD
B $CDBA,3
T $CDBD
B $CDCA,3
T $CDCD
B $CDDA,3
T $CDDD
B $CDEA,3
T $CDED
B $CDFA,3
T $CDFD
B $CE0A,3
T $CE0D
B $CE1A,3
T $CE1D
B $CE2A,3
T $CE2D
B $CE3A,3
T $CE3D
B $CE4A,3
T $CE4D
B $CE5A,3
T $CE5D
B $CE6A,3
T $CE6D
B $CE7A,3
T $CE7D
B $CE8A,3
T $CE8D
B $CE9A,3
T $CE9D
B $CEAA,3
T $CEAD
B $CEBA,3
T $CEBD
B $CECA,3
T $CECD
B $CEDA,3
T $CEDD
B $CEEA,3
T $CEED
B $CEFA,3
T $CEFD
B $CF0A,3
T $CF0D
B $CF1A,3
T $CF1D
B $CF2A,3
T $CF2D
B $CF3A,3
T $CF3D
B $CF4A,3
T $CF4D
B $CF5A,3
T $CF5D
B $CF6A,3
T $CF6D
B $CF7A,3
T $CF7D
B $CF8A,3
T $CF8D
B $CF9A,3
T $CF9D
B $CFAA,3
T $CFAD
B $CFBA,3
T $CFBD
B $CFCA,3
T $CFCD
B $CFDA,3
T $CFDD
B $CFEA,3
T $CFED
B $CFFA,3
T $CFFD
B $D00A,3
T $D00D
B $D01A,3
T $D01D
B $D02A,3
T $D02D
B $D03A,3
T $D03D
B $D04A,3
T $D04D
B $D05A,3
T $D05D
B $D06A,3
T $D06D
B $D07A,3
T $D07D
B $D08A,3
T $D08D
B $D09A,3
T $D09D
B $D0AA,3
T $D0AD
B $D0BA,3
T $D0BD
B $D0CA,3
T $D0CD
B $D0DA,3
T $D0DD
B $D0EA,3
T $D0ED
B $D0FA,3
T $D0FD
B $D10A,3
T $D10D
B $D11A,3
T $D11D
B $D12A,3
T $D12D
B $D13A,3
T $D13D
B $D14A,3
T $D14D
B $D15A,3
T $D15D
B $D16A,3
T $D16D
B $D17A,3
T $D17D
B $D18A,3
T $D18D
B $D19A,3
T $D19D
B $D1AA,3
T $D1AD
B $D1BA,3
T $D1BD
B $D1CE,3
T $D1D1
B $D1DE,3
T $D1E1
B $D1EE,3
T $D1F1
B $D1FE,3
T $D201
B $D20E
b $D210 Table of 35 records, 2 bytes each, see #R$B851
B $D210,70,10
b $D256 Table of objects, 35 records, 7 bytes each
N $D256 +$02: Object tile unique, to identify the object
N $D256 +$03: Object item, for NEAR indicator
N $D256 +$04: Object tile as object type
N $D256 +$05/$06: Object procedure, or $0000
W $D256,2,2 Object 00: Brick
B $D258,3,3
W $D25B,2,2
W $D25D,2,2 Object: Console in room #R$80F6
B $D25F,3,3
W $D262,2,2 Object procedure: flip trigger "D": set/remove wall in room #R$9739
W $D264,2,2 Object: Console in room #R$99A6
B $D266,3,3
W $D269,2,2 Object procedure: flip trigger "E": set/remove wall in room #R$97A6
W $D26B,2,2 Object: Console in room #R$92A7
B $D26D,3,3
W $D270,2,2 Object procedure: flip trigger "A": set/remove wall in room #R$7F48
W $D272,2,2 Object: Console in room #R$92EF
B $D274,3,3
W $D277,2,2 Object procedure: flip trigger "C": set/remove wall in room #R$8D5C
W $D279,2,2 Object: Console in room #R$9005
B $D27B,3,3
W $D27E,2,2 Object procedure: flip trigger "B": set/remove wall in room #R$8F20
W $D280,2,2 Object ?? 06
B $D282,3,3
W $D285,2,2 Object procedure "Update Ninja on tilemap"
W $D287,2,2 Object 07: Diskette
B $D289,3,3
W $D28C,2,2
W $D28E,2,2 Object 08: Pipe
B $D290,3,3
W $D293,2,2
W $D295,2,2 Object 09: Pipe
B $D297,3,3
W $D29A,2,2
W $D29C,2,2 Object 10: Pipe
B $D29E,3,3
W $D2A1,2,2
W $D2A3,2,2 Object 11: Granade
B $D2A5,3,3
W $D2A8,2,2
W $D2AA,2,2 Object 12: BOMB
B $D2AC,3,3
W $D2AF,2,2
W $D2B1,2,2 Object 13: Knife
B $D2B3,3,3
W $D2B6,2,2
W $D2B8,2,2 Object ?? 14
B $D2BA,3,3
W $D2BD,2,2
W $D2BF,2,2 Object 15: Pipe
B $D2C1,3,3
W $D2C4,2,2
W $D2C6,2,2 Object 16: Pipe
B $D2C8,3,3
W $D2CB,2,2
W $D2CD,2,2 Object 17: Pipe
B $D2CF,3,3
W $D2D2,2,2
W $D2D4,2,2 Object ?? 18
B $D2D6,3,3
W $D2D9,2,2
W $D2DB,2,2 Object 19: Knife
B $D2DD,3,3
W $D2E0,2,2
W $D2E2,2,2 Object 20: Knife
B $D2E4,3,3
W $D2E7,2,2
W $D2E9,2,2 Object ?? 21
B $D2EB,3,3
W $D2EE,2,2
W $D2F0,2,2 Object 22: Knife
B $D2F2,3,3
W $D2F5,2,2
W $D2F7,2,2 Object 23: Granade
B $D2F9,3,3
W $D2FC,2,2
W $D2FE,2,2 Object 24: Knife
B $D300,3,3
W $D303,2,2
W $D305,2,2 Object 25: Granade
B $D307,3,3
W $D30A,2,2
W $D30C,2,2 Object 26: Knife
B $D30E,3,3
W $D311,2,2
W $D313,2,2 Object ?? 27
B $D315,3,3
W $D318,2,2
W $D31A,2,2 Object ?? 28
B $D31C,3,3
W $D31F,2,2
W $D321,2,2 Object ?? 29
B $D323,3,3
W $D326,2,2
W $D328,2,2 Object 30: Brick
B $D32A,3,3
W $D32D,2,2
W $D32F,2,2 Object 31: Brick
B $D331,3,3
W $D334,2,2
W $D336,2,2 Object 32: Brick
B $D338,3,3
W $D33B,2,2
W $D33D,2,2 Object 33: Brick
B $D33F,3,3
W $D342,2,2
W $D344,2,2 Object 34: Brick
B $D346,3,3
B $D349,2,2
b $D34B
W $D34B,2,2
b $D34D Table of objects, 29 records, 5 bytes each
N $D34D +$00/$01: room address
N $D34D +$02/$03: address in Tile screen 0
N $D34D +$04: tile byte
W $D34D,4,4
B $D351,1,1
W $D352,4,4
B $D356,1,1
W $D357,4,4 BOMB, placement depends on Level
B $D35B,1,1
W $D35C,4,4
B $D360,1,1
W $D361,4,4
B $D365,1,1
W $D366,4,4
B $D36A,1,1
W $D36B,4,4
B $D36F,1,1
W $D370,4,4
B $D374,1,1
W $D375,4,4
B $D379,1,1
W $D37A,4,4 #10
B $D37E,1,1
W $D37F,4,4
B $D383,1,1
W $D384,4,4
B $D388,1,1
W $D389,4,4
B $D38D,1,1
W $D38E,4,4
B $D392,1,1
W $D393,4,4
B $D397,1,1
W $D398,4,4
B $D39C,1,1
W $D39D,4,4
B $D3A1,1,1
W $D3A2,4,4
B $D3A6,1,1
W $D3A7,4,4
B $D3AB,1,1
W $D3AC,4,4 #20
B $D3B0,1,1
W $D3B1,4,4
B $D3B5,1,1
W $D3B6,4,4
B $D3BA,1,1
W $D3BB,4,4
B $D3BF,1,1
W $D3C0,4,4
B $D3C4,1,1
W $D3C5,4,4 Console in room #R$80F6
B $D3C9,1,1
W $D3CA,4,4 Console in room #R$99A6
B $D3CE,1,1
W $D3CF,4,4 Console in room #R$92A7, see #R$D26B
B $D3D3,1,1
W $D3D4,4,4 Console in room #R$92EF
B $D3D8,1,1
W $D3D9,4,4 Console in room #R$9005
B $D3DD,1,1
b $D3DE Ninja/Guard sprites
N $D3DE Most of Ninja sprites are also Guard sprites, #R$A775 procedure and #R$A787 table used to translate Ninja tiles into Guard tiles.
N $D3DE Sprite Ninja/Guard walking 1
B $D3DE,42,6 #HTML[<img src="images/sprite-d3de.png" />]
N $D408 Sprite Ninja/Guard walking 2
B $D408,42,6 #HTML[<img src="images/sprite-d408.png" />]
N $D432 Sprite Ninja/Guard walking 3
B $D432,42,6 #HTML[<img src="images/sprite-d432.png" />]
N $D45C Sprite Ninja/Guard walking 4
B $D45C,42,6 #HTML[<img src="images/sprite-d45c.png" />]
N $D486 Sprite Ninja/Guard standing
B $D486,42,6 #HTML[<img src="images/sprite-d486.png" />]
N $D4B0 Sprite Ninja/Guard jumping
B $D4B0,42,6 #HTML[<img src="images/sprite-d4b0.png" />]
N $D4DA Sprite Ninja/Guard jump-kick
B $D4DA,42,6 #HTML[<img src="images/sprite-d4da.png" />]
N $D504 Sprite Ninja/Guard punching
B $D504,42,6 #HTML[<img src="images/sprite-d504.png" />]
N $D52E Sprite Ninja on ladder
B $D52E,42,6 #HTML[<img src="images/sprite-d52e.png" />]
N $D558 Sprite Ninja sitting
B $D558,42,6 #HTML[<img src="images/sprite-d558.png" />]
N $D582 Sprite Ninja falling
B $D582,42,6 #HTML[<img src="images/sprite-d582.png" />]
N $D5AC Sprite Ninja jumping 3
B $D5AC,42,6 #HTML[<img src="images/sprite-d5ac.png" />]
N $D5D6 Sprite Ninja jumping 4
B $D5D6,42,6 #HTML[<img src="images/sprite-d5d6.png" />]
b $D600 Front tiles, 126 tiles, 17 bytes each
N $D600 #HTML[<img src="images/tiles-d600.png" />]
B $D600,,17
c $DE68 Find record for the current room in #R$DE84 table
C $DE68,2 20 records
C $DE6D,3 get Current Room address low byte
C $DE74,3 get Current Room address high byte
b $DE84 ?? Dog rooms/flags ?? 20 records, 3 bytes each
W $DE84,60,3
b $DEC0
c $DEC1 Clear strings on the screen
N $DEC1 Clears 10 strings, 18 characters each; used to clear table of scores, menu etc.
C $DECA,3 String 18 spaces
C $DECD,3 Print string
t $DEE6 String 18 spaces
t $DEF8 Menu messages
T $DEF8
T $DF03
T $DF0E
T $DF17
T $DF27
c $DF37
C $DF37,2 blue
C $DF39,2 set border color, sound off
C $DF3B,3 set REPDEL = 1
C $DF3E,3 set REPPER = 1
C $DF43,3 set BORDCR = $08
C $DF46,3 Clear key buffer playing melody
C $DF4D,3 Play next note in melody
C $DF50,3 Clear LASTK and do RST $38 once
C $DF54,3 get LASTK
C $DF59,2 key pressed => Main menu
c $DF60 Main menu
C $DF60,3 Clear strings on the screen
C $DF63,3 Menu messages address
C $DF6B,3 Print string "J  KEMPSTON"
C $DF73,3 Print string "K  KEYBOARD"
C $DF7B,3 Print string "P  PROTEK"
C $DF83,3 Print string "R  REDEFINE KEYS"
C $DF8B,3 Print string "S  START MISSION"
C $DF8E,3 Clear key buffer playing melody
C $DF91,3 Highlight Menu item
C $DF98,3 Play next note in melody
C $DF9B,3 Clear LASTK and do RST $38 once
C $DF9F,3 get LASTK
C $DFA8,2 'S' ?
C $DFAA,3 => Start Mission
C $DFAD,2 'J' ?
C $DFAF,2 => Joystick selected
C $DFB1,2 'K' ?
C $DFB3,2 => Keyboard selected
C $DFB5,2 'P' ?
C $DFB7,2 => Protek selected
C $DFB9,2 'R' ?
C $DFBB,3 => Redefine Keys
C $DFBE,3 get Input method
C $DFC1,2 Joystick?
C $DFC5,2 read joystick port
C $DFC9,3 => Start Mission
c $DFD4 Clear LASTK and do RST $38 once
C $DFD5,3 clear LASTK
c $DFDB Highlight Menu item
c $DFE6 Unhighlight Menu item
c $DFF1 Joystick selected in Main menu
C $DFF1,3 Unhighlight Menu item
C $DFFA,3 Highlight Menu item
c $E004 Keyboard selected in Main menu
C $E004,3 Unhighlight Menu item
C $E00D,3 Highlight Menu item
c $E015 Protek selected in Main menu
C $E015,3 Unhighlight Menu item
C $E01E,3 Highlight Menu item
b $E039 Ports/bits for Protek and Keyboard
B $E039,10,10 Protek ports/bits
B $E043,10,10 Keyboard input ports/bits
c $E04D Clear key buffer playing melody
C $E04D,3 Play next note in melody
C $E050,3 Clear LASTK and do RST $38 once
C $E053,3 get LASTK
t $E05B Redefine keys messages
T $E068
T $E076
T $E084
T $E088
T $E08A
T $E08E
T $E092
c $E097 Redefine Keys
C $E09A,3 Clear strings on the screen
C $E097,3 Unhighlight Menu item
C $E09D,3 Redefine keys messages
C $E0A5,3 Print string "REDEFINE KEYS"
C $E0AD,3 Print string "PRESS THE KEYS"
C $E0B5,3 Print string "OF YOUR CHOICE"
C $E0BD,3 Print string "FIRE"
C $E0C5,3 Print string "UP"
C $E0CD,3 Print string "DOWN"
C $E0D5,3 Print string "LEFT"
C $E0DD,3 Print string "RIGHT"
C $E0E0,3 Clear key buffer playing melody
C $E102,3 Clear LASTK and do RST $38 once
C $E105,3 Play next note in melody
C $E10A,3 get LASTK
C $E10D,2 '['
C $E145,3 Print string
C $E14A,3 Clear key buffer playing melody
C $E15C,3 32
C $E163,3 32
C $E179,3 => Main menu
b $E17C
b $E17D
T $E17C,1,1
B $E17D,111,3
t $E1EC
T $E1EC,1 Current Level digit
T $E1ED,17
T $E1FE,6
T $E204,12
T $E210,7
b $E217 Level descriptions and data addresses
T $E217,14
W $E225,2,2
T $E227,14
W $E235,2,2
T $E237,14
W $E245,2,2
T $E247,14
W $E255,2,2
T $E257,14
W $E265,2,2
T $E267,14
W $E275,2,2
T $E277,14
W $E285,2,2
T $E287,14
W $E295,2,2
T $E297,14
W $E2A5,2,2
c $E2A7 Start Mission
C $E2A7,3 Unhighlight Menu item
C $E2AA,3 Clear strings on the screen
C $E2AD,3 "ENTER SKILL LEVEL"
C $E2B5,3 Print string "ENTER SKILL LEVEL"
C $E2BD,3 Print string "1 TO 9"
C $E2C0,3 Clear key buffer playing melody
C $E2CD,3 Play next note in melody
C $E2D0,3 Clear LASTK and do RST $38 once
C $E2D3,3 get LASTK
C $E2DE,3 Skill level address
C $E2E7,3 Print string
C $E2EA,3 Clear key buffer playing melody
C $E2FA,3 "YOUR MISSION"
C $E2F7,3 Clear strings on the screen
C $E302,3 Print string "YOUR MISSION"
C $E30A,3 Print string "WILL BE"
C $E30D,3 get Skill level
C $E318,1 * 16
C $E319,3 Levels data base address
C $E322,3 Print string - level description
C $E32A,3 set Guard counter value
C $E32F,3 set Dog counter value
C $E334,3 set Turret counter value
C $E33B,4 set Indicator Time value
C $E343,4 set Time value for BOMB
C $E349,3 set flag for wall in room #R$97A6
C $E34E,3 set count for wall in room #R$9739
C $E35D,3 set count for wall in room #R$8F20
C $E353,3 set count for wall in room #R$7F48
C $E358,3 set count for wall in room #R$8D5C
C $E36C,3 address for BOMB in Table of objects #R$D34D
C $E36F,2 Copy last 4 bytes: BOMB placement
C $E375,3 Clear LASTK and do RST $38 once
C $E378,3 Play next note in melody
C $E37C,3 get LASTK
b $E388
T $E388,4
b $E38C Levels data
N $E38C +$00: Guard counter value
N $E38C +$01: Dog counter value
N $E38C +$02: Turret counter value
N $E38C +$03/$04: two digits for TIME value
N $E38C +$05/$06: two digits for BOMB timer
N $E38C +$07: flag for wall in room #R$97A6
N $E38C +$08: count for wall in room #R$9739: $01 = no wall, $07 = put wall
N $E38C +$09: count for wall in room #R$7F48
N $E38C +$0A: count for wall in room #R$8D5C
N $E38C +$0B: count for wall in room #R$8F20: $01 = no wall, $09 = put wall
N $E38C +$10/$11: room for BOMB placement
N $E38C +$12/$13: address in Tile screen 0 for BOMB placement
N $E38C Level 1 "EXTREMELY EASY"
B $E38C,3,3
T $E38F,4
B $E393,5,5
T $E398,3
W $E39C,4,2
N $E3A0 Level 2 "VERY EASY"
B $E3A0,3,3
T $E3A3,4
B $E3A7,5,5
T $E3AC,3
W $E3B0,4,2
N $E3B4 Level 3 "EASY"
B $E3B4,3,3
T $E3B7,4
B $E3BB,5,5
T $E3C0,3
W $E3C4,4,2
N $E3C8 Level 4 "SLIGHTLY EASY"
B $E3C8,3,3
T $E3CB,4
B $E3CF,5,5
T $E3D4,3
W $E3D8,4,2
N $E3DC Level 5 "MODERATE"
B $E3DC,3,3
T $E3DF,4
B $E3E3
T $E3E8,3
B $E3EB
W $E3EC,4,2
N $E3F0 Level 6 "SLIGHTLY  HARD"
B $E3F0,3,3
T $E3F3,4
B $E3F7
T $E3FC,3
B $E3FF
W $E400,4,2
N $E404 Level 7 "HARD"
B $E404,3,3
T $E407,4
B $E40B
T $E410,3
B $E413
W $E414,4,2
N $E418 Level 8 "VERY HARD"
B $E418,3,3
T $E41B,4
B $E41F
T $E424,3
B $E427
W $E428,4,2
N $E42C Level 9 "EXTREMELY HARD"
B $E42C,3,3
T $E42F,4
B $E433
T $E438,3
B $E43B
W $E43C,4,2
c $E440 Play next note in melody
C $E45F,3 BEEPER
w $E494 Table for melodies
W $E494,,2
b $E4AE Melodies
B $E4AE,,4 Melody
B $E508,,4 Melody
B $E53A,,4 Melody
B $E56C,,4 Melody
B $E5CA,,4 Melody
B $E5DC,2,2 Melody end/restart
b $E5DE
b $E645 Front tiles (base address #R$D600) with codes $F5..$FF, 17 bytes each
B $E645,,17
b $E700 Ninja/Guard tiles, tiles with mask, 159 tiles, 16 bytes each
N $E700 Used to draw Ninja tiles on Tile Screen 2 (see #R$B1A3), and Guard tiles on Tile Screen 4 (see #R$B230).
N $E700 #HTML[<img src="images/tiles-e700.png" />]
B $E700,,16
b $F0F0 Dog tiles, tiles with mask, 61 tiles, 16 bytes each
N $F0F0 Used to draw tiles from Tile screen 3, see #R$B1FC.
B $F0F0,,16
b $F700 Background tiles, 59 tiles, 9 bytes each
N $F700 Used to draw background level, see #R$B177.
N $F700 #HTML[<img src="images/backtiles.png" />]
B $F700,531,9
c $F913
c $F973 Room #R$84A8 initialization
C $F973,3 tile screen address
C $F976,3 block address
C $F979,2 6 rows
C $F97B,2 3 columns
c $F9A1 Sound ??
b $F98F Block 3x6 tiles for room 84A8
B $F98F,18,3 #HTML[<img src="images/blocks/f98f.png" />] Back block 3x6 - crane
c $F9B9 Pause, then wait for any key pressed
C $F9C5,3 Read Input
C $F9CD,3 get Input bits
C $F9D8,3 clear LASTK
C $F9DC,3 get LASTK
c $F9E4
C $F9E4,3 Prepare screen, show anti-piracy message, and wait for any key
c $F9E7 Start point after loading
c $F9F9
c $FA11
c $FA28
C $FA2D,3 get current room address low byte
c $FA31 Decrease Energy by B + Sound
C $FA31,3 Decrease Energy by B
C $FA36,3 Sound
b $FA3A
b $FFF7 Background tile $FF
B $FFF7,9,9
