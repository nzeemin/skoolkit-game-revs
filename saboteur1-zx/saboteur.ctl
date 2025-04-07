@ $6270 org
b $6270
c $6289 Show title picture (two ninjas)
C $6289,3 Encoded picture data address
C $628C,3 Tile screens address, used as a buffer
C $628F,1 Load next byte of picture data
C $6290,2 check for control byte $02 - end of sequence
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
C $62B2,2 Number of rows = 24
C $62BD,2 Repeat 8 times
C $62CB,1 Move HL to next tile row
C $62D3,2 Continue loop for rows
C $62D8,2 Continue loop for columns
b $62DB Title picture (two ninjas), RLE encoded
B $62DB,,8 #HTML[<img src="images/title.png" />]
B $658F,1,1
b $6590 Tile screen 0 30x17 tiles, 510 bytes - background
B $6590,,30
T $65E7
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
b $71C3 Current Guard data
W $71C3,2,2 Current Guard position in tilemap
B $71C5,1,1 Current Guard X position
B $71C6,1,1 Current Guard X position
b $71C7
b $71CB Current Dog data, 9 bytes
B $71CD,1,1 Dog direction
B $71CE,1,1 Dog X position
B $71D3,1,1 Dog Y position
b $71D4
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
B $733A,1,1
b $733B
W $733B,8,2
b $7343
B $7343,1,1 ?? counter
B $7344,1,1
B $7345,1,1
B $7346,1,1
B $7347,1,1 Guard direction
c $734A Proceed to the next room token (redirect to #R$B702)
c $734D Room token #14: Put one tile at the given address; params: 3 bytes (tile, address)
C $734D,1 Restore token sequence address
C $734E,1 Skip token byte
C $734F,1 get tile byte
C $7351,1 get address low byte
C $7354,1 get address high byte
C $7356,1 put tile into tilemap
C $7357,2 => #R$B702 Proceed to the next room token
c $7359 Room token #13: Set border color; params: 1 byte
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
c $7381 Room token #1: Fill to down; params: 4 bytes (count, filler, address)
C $7381,3 30
C $7384,1 Restore token sequence address
C $7385,1 Skip token byte
C $7386,1 get count byte
C $7388,1 get tile byte
C $738A,1 get address low byte
C $738D,1 get address high byte
C $7393,2 => #R$B702 Proceed to the next room token
c $7395 Room token #10: Fill to down-right; params: 4 bytes (count, filler, address)
C $7395,3 30 + 1
c $739A Room token #11: Fill to down-left; params: 4 bytes (count, filler, address)
C $739A,3 30 - 1
c $739F Room token #2: Fill to right; params: 4 bytes (count, filler, address)
c $73A4 Room token #6:
C $73A4,2 A = "INC HL" command
C $73A6,3 set the command
C $73A9,1 Restore token sequence address
C $73AA,1 Skip token byte
C $73BB,1 !!MUT-CMD!!
C $73C3,2 => #R$B702 Proceed to the next room token
c $73C5 Room token #7:
C $73C5,2 A = "INC HL" command
C $73C7,3 set the command
C $73CA,1 Restore token sequence address
C $73CB,1 Skip token byte
C $73DE,1 !!MUT-CMD!!
C $73E8,3 => #R$B702 Proceed to the next room token
c $73EB Room token #8:
c $73EF Room token #9:
c $73F3 Room token #4: Fill whole Tile screen 0 with one tile; params: 1 byte (filler)
C $73F3,1 Restore token sequence address
C $73F4,1 Skip token byte
C $73F5,1 get tile byte
C $73F7,3 Tile screen 0 start address
C $73FA,3 Tile screen 0 start address + 1
C $73FE,3 510 - 1
C $7403,3 => #R$B702 Proceed to the next room token
c $7406 Room token #5: Draw block of tiles; params: 6 bytes (width, height, srcaddr, address)
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
c $742B Room token #12: Draw block of tiles; params: 6 bytes (srcaddr, width, height, address)
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
c $7452 Room token #3: Fill rectangle; params: 5 bytes (filler, width, height, address)
C $7452,1 Restore token sequence address
C $7453,1 Skip token byte
C $746F,3 => #R$B702 Proceed to the next room token
c $7472
b $749C
B $749D
c $749E Decreasing Energy
C $74C6,1 Decrease Energy
c $74CD Draw NEAR/HELD item
C $74CD,2 !!MUT-ARG!! item number
b $750B
w $751B
W $751B,,8
b $755B
c $7918 Room procedure (for 19 rooms with a guard)
c $791B Rooms 7C9C/92EF initialization
b $791E Room 791E (room with pier)
W $791E,2,2 Room procedure
W $7920,2,2 Initialization
W $7922,2,2
W $7924,2,2 Room to Right
W $7926,4,2
B $792A #HTML[<img src="images/rooms/791E.png" />]
b $7984
b $79C6 Room 79C6 (next to room with pier)
W $79C6,2,2 Room procedure
W $79C8,2,2 Initialization
W $79CA,2,2 Room to Left
W $79CC,2,2 Room to Right
W $79CE,4,2
B $79D2 #HTML[<img src="images/rooms/79C6.png" />]
b $7A17 Room 7A17
W $7A17,2,2 Room procedure
W $7A19,2,2 Initialization
W $7A1B,2,2 Room to Left
W $7A1D,2,2 Room to Right
W $7A1F,2,2 Room Up
W $7A21,2,2
B $7A23 #HTML[<img src="images/rooms/7A17.png" />]
b $7A75 Room 7A75
W $7A75,2,2 Room procedure
W $7A77,2,2 Initialization
W $7A79,4,2
W $7A7D,2,2 Room Up
W $7A7F,2,2 Room Down
B $7A81 #HTML[<img src="images/rooms/7A75.png" />]
b $7A9E Room 7A9E
W $7A9E,2,2 Room procedure
W $7AA0,2,2 Initialization
B $7AA2,2,2
W $7AA4,2,2 Room to Right
W $7AA6,2,2 Room Up
W $7AA8,2,2
B $7AAA #HTML[<img src="images/rooms/7A9E.png" />]
b $7ACD Room 7ACD
W $7ACD,2,2 Room procedure
W $7ACF,2,2 Initialization
W $7AD1,2,2 Room to Left
W $7AD3,2,2 Room to Right
W $7AD5,2,2 Room Up
W $7AD7,2,2
B $7AD9 #HTML[<img src="images/rooms/7ACD.png" />]
b $7AF8 Room 7AF8
W $7AF8,2,2 Room procedure
W $7AFA,2,2 Initialization
W $7AFC,2,2 Room to Left
W $7AFE,2,2
W $7B00,2,2 Room Up
W $7B02,2,2
B $7B04 #HTML[<img src="images/rooms/7AF8.png" />]
b $7B56 Room 7B56
W $7B56,2,2 Room procedure
W $7B58,2,2 Initialization
W $7B5A,4,2
W $7B5E,2,2 Room Up
W $7B60,2,2 Room Down
B $7B62 #HTML[<img src="images/rooms/7B56.png" />]
b $7B90 Room 7B90
W $7B90,2,2 Room procedure
W $7B92,2,2 Initialization
W $7B94,2,2 Room to Left
W $7B96,2,2 Room to Right
W $7B98,4,2
B $7B9C #HTML[<img src="images/rooms/7B90.png" />]
b $7BD2 Room 7BD2
W $7BD2,2,2 Room procedure
W $7BD4,2,2 Initialization
W $7BD6,2,2 Room to Left
W $7BD8,2,2 Room to Right
W $7BDA,2,2 Room Up
W $7BDC,2,2 Room Down
B $7BDE #HTML[<img src="images/rooms/7BD2.png" />]
b $7C21 Data 3x3 tiles for Room token #0
B $7C21,9,3
b $7C2A
B $7C2A,4,4
b $7C2E Room 7C2E
W $7C2E,2,2 Room procedure
W $7C30,2,2 Initialization
W $7C32,2,2 Room to Left
W $7C34,2,2
W $7C36,2,2 Room Up
W $7C38,2,2 Room Down
B $7C3A #HTML[<img src="images/rooms/7C2E.png" />]
b $7C6D Room 7C6D
W $7C6D,2,2 Room procedure
W $7C6F,2,2 Initialization
W $7C71,2,2
W $7C73,2,2 Room to Right
W $7C75,2,2 Room Up
W $7C77,2,2 Room Down
B $7C79 #HTML[<img src="images/rooms/7C6D.png" />]
b $7C9C Room 7C9C
W $7C9C,2,2 Room procedure
W $7C9E,2,2 Initialization
W $7CA0,2,2 Room to Left
W $7CA2,2,2 Room to Right
W $7CA4,4,2
B $7CA8 #HTML[<img src="images/rooms/7C9C.png" />]
b $7D5A Room 7D5A
W $7D5A,2,2 Room procedure
W $7D5C,2,2 Initialization
W $7D5E,2,2 Room to Left
W $7D60,2,2 Room to Right
W $7D62,2,2
W $7D64,2,2 Room Down
B $7D66 #HTML[<img src="images/rooms/7D5A.png" />]
b $7DA9 Room 7DA9
W $7DA9,2,2 Room procedure
W $7DAB,2,2 Initialization
W $7DAD,2,2
W $7DAF,2,2 Room to Right
W $7DB1,2,2 Room Up
W $7DB3,2,2 Room Down
B $7DB5 #HTML[<img src="images/rooms/7DA9.png" />]
b $7E05 Room 7E05
W $7E05,2,2 Room procedure
W $7E07,2,2 Initialization
W $7E09,2,2
W $7E0B,2,2 Room to Right
W $7E0D,2,2 Room Up
W $7E0F,2,2 Room Down
B $7E11 #HTML[<img src="images/rooms/7E05.png" />]
b $7E8C Room 7E8C
W $7E8C,2,2 Room procedure
W $7E8E,2,2 Initialization
W $7E90,2,2 Room to Left
W $7E92,2,2 Room to Right
W $7E94,2,2
W $7E96,2,2 Room Down
B $7E98 #HTML[<img src="images/rooms/7E8C.png" />]
b $7EF2 Room 7EF2
W $7EF2,2,2 Room procedure
W $7EF4,2,2 Initialization
W $7EF6,2,2 Room to Left
W $7EF8,6,2
B $7EFE #HTML[<img src="images/rooms/7EF2.png" />]
b $7F48 Room 7F48
W $7F48,2,2 Room procedure
W $7F4A,2,2 Initialization
W $7F4C,2,2
W $7F4E,2,2 Room to Right
W $7F50,2,2 Room Up
W $7F52,2,2 Room Down
B $7F54 #HTML[<img src="images/rooms/7F48.png" />]
b $7F9C Room 7F9C
W $7F9C,2,2 Room procedure
W $7F9E,2,2 Initialization
W $7FA0,2,2 Room to Left
W $7FA2,4,2
W $7FA6,2,2 Room Down
B $7FA8 #HTML[<img src="images/rooms/7F9C.png" />]
b $7FC4 Room 7FC4
W $7FC4,2,2 Room procedure
W $7FC6,2,2 Initialization
W $7FC8,2,2 Room to Left
W $7FCA,2,2 Room to Right
W $7FCC,2,2 Room Up
W $7FCE,2,2
B $7FD0 #HTML[<img src="images/rooms/7FC4.png" />]
b $8008 Room 8008
W $8008,2,2 Room procedure
W $800A,2,2 Initialization
W $800C,2,2 Room to Left
W $800E,2,2
W $8010,2,2 Room Up
W $8012,2,2 Room Down
B $8014 #HTML[<img src="images/rooms/8008.png" />]
b $8076 Room 8076
W $8076,2,2 Room procedure
W $8078,2,2 Initialization
W $807A,2,2
B $807C,2,2
W $807E,2,2 Room Up
W $8080,2,2 Room Down
B $8082 #HTML[<img src="images/rooms/8076.png" />]
b $80A7 Room 80A7
W $80A7,2,2 Room procedure
W $80A9,2,2 Initialization
W $80AB,2,2 Room to Left
W $80AD,2,2 Room to Right
W $80AF,4,2
B $80B3 #HTML[<img src="images/rooms/80A7.png" />]
b $80F6 Room 80F6
W $80F6,2,2 Room procedure
W $80F8,2,2 Initialization
W $80FA,2,2 Room to Left
W $80FC,6,2
B $8102 #HTML[<img src="images/rooms/80F6.png" />]
b $8162 Room 8162
W $8162,2,2 Room procedure
W $8164,2,2 Initialization
W $8166,2,2 Room to Left
W $8168,2,2
W $816A,2,2 Room Up
W $816C,2,2 Room Down
B $816E #HTML[<img src="images/rooms/8162.png" />]
b $81E5 Room 81E5
W $81E5,2,2 Room procedure
W $81E7,2,2 Initialization
W $81E9,2,2 Room to Left
W $81EB,2,2 Room to Right
W $81ED,4,2
B $81F1 #HTML[<img src="images/rooms/81E5.png" />]
b $8238 Room 8238
W $8238,2,2 Room procedure
W $823A,2,2 Initialization
W $823C,2,2
W $823E,2,2 Room to Right
W $8240,2,2 Room Up
W $8242,2,2 Room Down
B $8244 #HTML[<img src="images/rooms/8238.png" />]
b $8279 Room 8279
W $8279,2,2 Room procedure
W $827B,2,2 Initialization
W $827D,2,2
W $827F,2,2 Room to Right
W $8281,2,2
W $8283,2,2 Room Down
B $8285 #HTML[<img src="images/rooms/8279.png" />]
b $82DD Room 82DD
W $82DD,2,2 Room procedure
W $82DF,2,2 Initialization
W $82E1,2,2 Room to Left
W $82E3,2,2 Room to Right
W $82E5,2,2
W $82E7,2,2 Room Down
B $82E9 #HTML[<img src="images/rooms/82DD.png" />]
b $8321 Room 8321
W $8321,2,2 Room procedure
W $8323,2,2 Initialization
W $8325,2,2 Room to Left
W $8327,2,2
W $8329,2,2 Room Up
W $832B,2,2 Room Down
B $832D #HTML[<img src="images/rooms/8321.png" />]
b $8384 Room 8384
W $8384,2,2 Room procedure
W $8386,2,2 Initialization
W $8388,4,2
W $838C,2,2 Room Up
W $838E,2,2 Room Down
B $8390 #HTML[<img src="images/rooms/8384.png" />]
b $83ED Room 83ED
W $83ED,2,2 Room procedure
W $83EF,2,2 Initialization
W $83F1,2,2
W $83F3,2,2 Room to Right
W $83F5,2,2 Room Up
W $83F7,2,2 Room Down
B $83F9 #HTML[<img src="images/rooms/83ED.png" />]
b $844E Room 844E
W $844E,2,2 Room procedure
W $8450,2,2 Initialization
W $8452,2,2 Room to Left
W $8454,4,2
W $8458,2,2 Room Down
B $845A #HTML[<img src="images/rooms/844E.png" />]
b $84A8 Room 84A8
W $84A8,2,2 Room procedure
W $84AA,2,2 Initialization
W $84AC,2,2 Room to Left
W $84AE,2,2 Room to Right
W $84B0,2,2
W $84B2,2,2 Room Down
B $84B4 #HTML[<img src="images/rooms/84A8.png" />]
b $84EE Room 84EE
W $84EE,2,2 Room procedure
W $84F0,2,2 Initialization
W $84F2,2,2
W $84F4,2,2 Room to Right
W $84F6,2,2 Room Up
W $84F8,2,2
B $84FA #HTML[<img src="images/rooms/84EE.png" />]
b $8526 Room 8526
W $8526,2,2 Room procedure
W $8528,2,2 Initialization
W $852A,2,2
W $852C,2,2 Room to Right
W $852E,2,2 Room Up
W $8530,2,2 Room Down
B $8532 #HTML[<img src="images/rooms/8526.png" />]
b $858F Room 858F
W $858F,2,2 Room procedure
W $8591,2,2 Initialization
W $8593,2,2 Room to Left
W $8595,2,2 Room to Right
W $8597,4,2
B $859B #HTML[<img src="images/rooms/858F.png" />]
b $85BD Room 85BD
W $85BD,2,2 Room procedure
W $85BF,2,2 Initialization
W $85C1,2,2 Room to Left
W $85C3,2,2
W $85C5,2,2 Room Up
W $85C7,2,2
B $85C9 #HTML[<img src="images/rooms/85BD.png" />]
b $8608 Room 8608
W $8608,2,2 Room procedure
W $860A,2,2 Initialization
W $860C,2,2
W $860E,2,2 Room to Right
W $8610,2,2
W $8612,2,2 Room Down
B $8614 #HTML[<img src="images/rooms/8606.png" />]
b $8689 Room 8689
W $8689,2,2 Room procedure
W $868B,2,2 Initialization
W $868D,2,2 Room to Left
W $868F,4,2
W $8693,2,2 Room Down
B $8695 #HTML[<img src="images/rooms/8689.png" />]
b $86FD Room 86FD
W $86FD,2,2 Room procedure
W $86FF,2,2 Initialization
W $8701,2,2 Room to Left
W $8703,2,2 Room to Right
W $8705,2,2 Room Up
W $8707,2,2
B $8709 #HTML[<img src="images/rooms/86FD.png" />]
b $8739 Room 8739
W $8739,2,2 Room procedure
W $873B,2,2 Initialization
W $873D,2,2 Room to Left
W $873F,2,2 Room to Right
W $8741,2,2
W $8743,2,2 Room Down
B $8745 #HTML[<img src="images/rooms/8739.png" />]
b $8799 Room 8799
W $8799,2,2 Room procedure
W $879B,2,2 Initialization
W $879D,2,2
W $879F,2,2 Room to Right
W $87A1,4,2
B $87A5 #HTML[<img src="images/rooms/8799.png" />]
b $8802 Room 8802
W $8802,2,2 Room procedure
W $8804,2,2 Initialization
W $8806,2,2 Room to Left
W $8808,2,2
W $880A,2,2 Room Up
W $880C,2,2
B $880E #HTML[<img src="images/rooms/8802.png" />]
b $8834 Room 8834
W $8834,2,2 Room procedure
W $8836,2,2 Initialization
W $8838,2,2 Room to Left
W $883A,2,2 Room to Right
W $883C,2,2 Room Up
W $883E,2,2 Room Down
B $8840 #HTML[<img src="images/rooms/8834.png" />]
b $889F Room 889F
W $889F,2,2 Room procedure
W $88A1,2,2 Initialization
W $88A3,2,2 Room to Left
W $88A5,2,2 Room to Right
W $88A7,2,2 Room Up
W $88A9,2,2 Room Down
B $88AB #HTML[<img src="images/rooms/889F.png" />]
b $890E Room 890E
W $890E,2,2 Room procedure
W $8910,2,2 Initialization
W $8912,2,2 Room to Left
W $8914,2,2 Room to Right
W $8916,4,2
B $891A #HTML[<img src="images/rooms/890E.png" />]
b $8953 Room 8953
W $8953,2,2 Room procedure
W $8955,2,2 Initialization
W $8957,2,2
W $8959,2,2 Room to Right
W $895B,2,2 Room Up
W $895D,2,2 Room Down
B $895F #HTML[<img src="images/rooms/8953.png" />]
b $89B9 Room 89B9
W $89B9,2,2 Room procedure
W $89BB,2,2 Initialization
W $89BD,2,2
W $89BF,2,2 Room to Right
W $89C1,2,2
W $89C3,2,2 Room Down
B $89C5 #HTML[<img src="images/rooms/89B9.png" />]
b $8A2D Room 8A2D
W $8A2D,2,2 Room procedure
W $8A2F,2,2 Initialization
W $8A31,2,2 Room to Left
W $8A33,2,2 Room to Right
W $8A35,2,2 Room Up
W $8A37,2,2 Room Down
B $8A39 #HTML[<img src="images/rooms/8A2D.png" />]
b $8A81 Room 8A81
W $8A81,2,2 Room procedure
W $8A83,2,2 Initialization
W $8A85,2,2 Room to Left
W $8A87,2,2 Room to Right
W $8A89,2,2
W $8A8B,2,2 Room Down
B $8A8D #HTML[<img src="images/rooms/8A81.png" />]
b $8AF4 Room 8AF4
W $8AF4,2,2 Room procedure
W $8AF6,2,2 Initialization
W $8AF8,2,2 Room to Left
W $8AFA,2,2 Room to Right
W $8AFC,2,2 Room Up
W $8AFE,2,2 Room Down
B $8B00 #HTML[<img src="images/rooms/8AF4.png" />]
b $8B25 Room 8B25
W $8B25,2,2 Room procedure
W $8B27,2,2 Initialization
W $8B29,2,2
W $8B2B,2,2 Room to Right
W $8B2D,2,2
W $8B2F,2,2 Room Down
B $8B31 #HTML[<img src="images/rooms/8B25.png" />]
b $8B71 Room 8B71
W $8B71,2,2 Room procedure
W $8B73,2,2 Initialization
W $8B75,2,2 Room to Left
W $8B77,2,2 Room to Right
W $8B79,4,2
B $8B7D #HTML[<img src="images/rooms/8B71.png" />]
b $8BAB Room 8BAB
W $8BAB,2,2 Room procedure
W $8BAD,2,2 Initialization
W $8BAF,2,2 Room to Left
W $8BB1,4,2
W $8BB5,2,2 Room Down
B $8BB7 #HTML[<img src="images/rooms/8BAB.png" />]
b $8BF0 Room 8BF0
W $8BF0,2,2 Room procedure
W $8BF2,2,2 Initialization
W $8BF4,2,2 Room to Left
W $8BF6,2,2 Room to Right
W $8BF8,2,2
W $8BFA,2,2 Room Down
B $8BFC #HTML[<img src="images/rooms/8BF0.png" />]
b $8C5A Room 8C5A
W $8C5A,2,2 Room procedure
W $8C5C,2,2 Initialization
W $8C5E,2,2 Room to Left
W $8C60,2,2 Room to Right
W $8C62,2,2
W $8C64,2,2 Room Down
B $8C66 #HTML[<img src="images/rooms/8C5A.png" />]
b $8CC8 Room 8CC8
W $8CC8,2,2 Room procedure
W $8CCA,2,2 Initialization
W $8CCC,2,2 Room to Left
W $8CCE,2,2 Room to Right
W $8CD0,4,2
B $8CD4 #HTML[<img src="images/rooms/8CC8.png" />]
b $8D18 Room 8D18
W $8D18,2,2 Room procedure
W $8D1A,2,2 Initialization
W $8D1C,2,2 Room to Left
W $8D1E,2,2 Room to Right
W $8D20,2,2 Room Up
W $8D22,2,2 Room Down
B $8D24 #HTML[<img src="images/rooms/8D18.png" />]
b $8D5C Room 8D5C
W $8D5C,2,2 Room procedure
W $8D5E,2,2 Initialization
W $8D60,2,2 Room to Left
W $8D62,4,2
W $8D66,2,2 Room Down
B $8D68 #HTML[<img src="images/rooms/8D5C.png" />]
b $8DCA Room 8DCA (helicopter)
W $8DCA,2,2 Room procedure
W $8DCC,2,2 Initialization
W $8DCE,2,2
W $8DD0,2,2 Room to Right
W $8DD2,4,2
B $8DD6 #HTML[<img src="images/rooms/8DCA.png" />]
b $8E4C
b $8E5A
b $8E5E
b $8E62
b $8E89
b $8E9C Room 8E9C
W $8E9C,2,2 Room procedure
W $8E9E,2,2 Initialization
W $8EA0,2,2 Room to Left
W $8EA2,2,2
W $8EA4,2,2 Room Up
W $8EA6,2,2 Room Down
B $8EA8 #HTML[<img src="images/rooms/8E9C.png" />]
b $8EE1 Room 8EE1
W $8EE1,2,2 Room procedure
W $8EE3,2,2 Initialization
W $8EE5,2,2 Room to Left
W $8EE7,4,2
W $8EEB,2,2 Room Down
B $8EED #HTML[<img src="images/rooms/8EE1.png" />]
b $8F20 Room 8F20
W $8F20,2,2 Room procedure
W $8F22,2,2 Initialization
W $8F24,2,2 Room to Left
W $8F26,2,2
W $8F28,2,2 Room Up
W $8F2A,2,2 Room Down
B $8F2C #HTML[<img src="images/rooms/8F20.png" />]
b $8F84 Room 8F84
W $8F84,2,2 Room procedure
W $8F86,2,2 Initialization
W $8F88,2,2 Room to Left
W $8F8A,2,2
W $8F8C,2,2 Room Up
W $8F8E,2,2 Room Down
B $8F90 #HTML[<img src="images/rooms/8F84.png" />]
b $8FBD Room 8FBD
W $8FBD,2,2 Room procedure
W $8FBF,2,2 Initialization
W $8FC1,2,2 Room to Left
W $8FC3,2,2 Room to Right
W $8FC5,2,2
W $8FC7,2,2 Room Down
B $8FC9 #HTML[<img src="images/rooms/8FBD.png" />]
b $9005 Room 9005
W $9005,2,2 Room procedure
W $9007,2,2 Initialization
W $9009,2,2 Room to Left
W $900B,2,2 Room to Right
W $900D,2,2 Room Up
W $900F,2,2
B $9011 #HTML[<img src="images/rooms/9005.png" />]
b $9053 Room 9053
W $9053,2,2 Room procedure
W $9055,2,2 Initialization
W $9057,2,2 Room to Left
W $9059,2,2 Room to Right
W $905B,2,2 Room Up
W $905D,2,2 Room Down
B $905F #HTML[<img src="images/rooms/9053.png" />]
b $909F Room 909F
W $909F,2,2 Room procedure
W $90A1,2,2 Initialization
W $90A3,2,2 Room to Left
W $90A5,2,2 Room to Right
W $90A7,4,2
B $90AB #HTML[<img src="images/rooms/909F.png" />]
b $90DB Room 90DB
W $90DB,2,2 Room procedure
W $90DD,2,2 Initialization
W $90DF,2,2 Room to Left
W $90E1,2,2 Room to Right
W $90E3,2,2 Room Up
W $90E5,2,2
B $90E7 #HTML[<img src="images/rooms/90DB.png" />]
b $913F Room 913F
W $913F,2,2 Room procedure
W $9141,2,2 Initialization
W $9143,2,2
W $9145,2,2 Room to Right
W $9147,2,2
W $9149,2,2 Room Down
B $914B #HTML[<img src="images/rooms/913F.png" />]
b $91BA Room 91BA
W $91BA,2,2 Room procedure
W $91BC,2,2 Initialization
W $91BE,2,2 Room to Left
W $91C0,2,2
W $91C2,2,2 Room Up
W $91C4,2,2 Room Down
B $91C6 #HTML[<img src="images/rooms/91BA.png" />]
b $920A Room 920A
W $920A,2,2 Room procedure
W $920C,2,2 Initialization
W $920E,2,2 Room to Left
W $9210,2,2 Room to Right
W $9212,4,2
B $9216 #HTML[<img src="images/rooms/920A.png" />]
b $924E Room 924E
W $924E,2,2 Room procedure
W $9250,2,2 Initialization
W $9252,2,2 Room to Left
W $9254,2,2
W $9256,2,2 Room Up
W $9258,2,2
B $925A #HTML[<img src="images/rooms/924E.png" />]
b $92A7 Room 92A7
W $92A7,2,2 Room procedure
W $92A9,2,2 Initialization
W $92AB,2,2
W $92AD,2,2 Room to Right
W $92AF,4,2
B $92B3 #HTML[<img src="images/rooms/92A7.png" />]
b $92EF Room 92EF
W $92EF,2,2 Room procedure
W $92F1,2,2 Initialization
W $92F3,2,2
W $92F5,2,2 Room to Right
W $92F7,4,2
B $92FB #HTML[<img src="images/rooms/92EF.png" />]
b $9376 Room 9376
W $9376,2,2 Room procedure
W $9378,2,2 Initialization
W $937A,2,2 Room to Left
W $937C,2,2
W $937E,2,2 Room Up
B $9380,2,2
B $9382 #HTML[<img src="images/rooms/9376.png" />]
b $93DF Room 93DF
W $93DF,2,2 Room procedure
W $93E1,2,2 Initialization
W $93E3,2,2 Room to Left
W $93E5,2,2 Room to Right
W $93E7,2,2 Room Up
W $93E9,2,2
B $93EB #HTML[<img src="images/rooms/93DF.png" />]
b $9431 Room 9431
W $9431,2,2 Room procedure
W $9433,2,2 Initialization
W $9435,4,2
W $9439,2,2 Room Up
W $943B,2,2 Room Down
B $943D #HTML[<img src="images/rooms/9431.png" />]
b $9451 Room 9451
W $9451,2,2 Room procedure
W $9453,2,2 Initialization
W $9455,6,2
W $945B,2,2 Room Down
B $945D #HTML[<img src="images/rooms/9451.png" />]
b $947C Room 947C
W $947C,2,2 Room procedure
W $947E,2,2 Initialization
W $9480,2,2 Room to Left
W $9482,2,2 Room to Right
W $9484,4,2
B $9488 #HTML[<img src="images/rooms/947C.png" />]
b $94AB Room 94AB
W $94AB,2,2 Room procedure
W $94AD,2,2 Initialization
W $94AF,2,2 Room to Left
W $94B1,2,2 Room to Right
W $94B3,4,2
B $94B7 #HTML[<img src="images/rooms/94AB.png" />]
b $94CF Room 94CF
W $94CF,2,2 Room procedure
W $94D1,2,2 Initialization
W $94D3,2,2 Room to Left
W $94D5,2,2 Room to Right
W $94D7,4,2
B $94DB #HTML[<img src="images/rooms/94CF.png" />]
b $9552 Room 9552
W $9552,2,2 Room procedure
W $9554,2,2 Initialization
W $9556,2,2 Room to Left
W $9558,2,2 Room to Right
W $955A,4,2
B $955E #HTML[<img src="images/rooms/9552.png" />]
b $95D6 Room 95D6
W $95D6,2,2 Room procedure
W $95D8,2,2 Initialization
W $95DA,2,2 Room to Left
W $95DC,2,2 Room to Right
W $95DE,4,2
B $95E2 #HTML[<img src="images/rooms/95D6.png" />]
b $95F8 Room 95F8
W $95F8,2,2 Room procedure
W $95FA,2,2 Initialization
W $95FC,2,2
W $95FE,2,2 Room to Right
W $9600,2,2
W $9602,2,2 Room Down
B $9604 #HTML[<img src="images/rooms/95F8.png" />]
b $9634 Room 9634
W $9634,2,2 Room procedure
W $9636,2,2 Initialization
W $9638,2,2
W $963A,2,2 Room to Right
W $963C,2,2 Room Up
W $963E,2,2 Room Down
B $9640 #HTML[<img src="images/rooms/9634.png" />]
b $968A Room 968A
W $968A,2,2 Room procedure
W $968C,2,2 Initialization
W $968E,2,2 Room to Left
W $9690,2,2 Room to Right
W $9692,2,2
W $9694,2,2 Room Down
B $9696 #HTML[<img src="images/rooms/968A.png" />]
b $96CC Room 96CC
W $96CC,2,2 Room procedure
W $96CE,2,2 Initialization
W $96D0,2,2 Room to Left
W $96D2,4,2
W $96D6,2,2 Room Down
B $96D8 #HTML[<img src="images/rooms/96CC.png" />]
b $96F3 Room 96F3
W $96F3,2,2 Room procedure
W $96F5,2,2 Initialization
W $96F7,2,2 Room to Left
W $96F9,4,2
W $96FD,2,2 Room Down
B $96FF #HTML[<img src="images/rooms/96F3.png" />]
b $9715 Room 9715
W $9715,2,2 Room procedure
W $9717,2,2 Initialization
W $9719,2,2
W $971B,2,2 Room to Right
W $971D,2,2 Room Up
W $971F,2,2 Room Down
B $9721 #HTML[<img src="images/rooms/9715.png" />]
b $9739 Room 9739
W $9739,2,2 Room procedure
W $973B,2,2 Initialization
W $973D,2,2 Room to Left
W $973F,2,2 Room to Right
W $9741,2,2 Room Up
W $9743,2,2 Room Down
B $9745 #HTML[<img src="images/rooms/9739.png" />]
b $976E Room 976E
W $976E,2,2 Room procedure
W $9770,2,2 Initialization
W $9772,2,2 Room to Left
W $9774,6,2
B $977A #HTML[<img src="images/rooms/976E.png" />]
b $97A6 Room 97A6
W $97A6,2,2 Room procedure
W $97A8,2,2 Initialization
W $97AA,2,2 Room to Left
W $97AC,2,2 Room to Right
W $97AE,2,2 Room Up
W $97B0,2,2
B $97B2 #HTML[<img src="images/rooms/97A6.png" />]
b $97F8 Room 97F8
W $97F8,2,2 Room procedure
W $97FA,2,2 Initialization
W $97FC,2,2 Room to Left
W $97FE,4,2
W $9802,2,2 Room Down
B $9804 #HTML[<img src="images/rooms/97F8.png" />]
b $982B Room 982B
W $982B,2,2 Room procedure
W $982D,2,2 Initialization
W $982F,2,2 Room to Left
W $9831,2,2
W $9833,2,2 Room Up
W $9835,2,2
B $9837 #HTML[<img src="images/rooms/982B.png" />]
b $9876 Room 9876
W $9876,2,2 Room procedure
W $9878,2,2 Initialization
W $987A,2,2 Room to Left
W $987C,2,2 Room to Right
W $987E,4,2
B $9882 #HTML[<img src="images/rooms/9876.png" />]
b $98C0 Room 98C0 (think door)
W $98C0,2,2 Room procedure
W $98C2,2,2 Initialization
W $98C4,2,2 Room to Left
W $98C6,2,2 Room to Right
W $98C8,4,2
B $98CC #HTML[<img src="images/rooms/98C0.png" />]
b $990D Room 990D
W $990D,2,2 Room procedure
W $990F,2,2 Initialization
W $9911,4,2
W $9915,2,2 Room Up
W $9917,2,2
B $9919 #HTML[<img src="images/rooms/990D.png" />]
b $99A6 Room 99A6
W $99A6,2,2 Room procedure
W $99A8,2,2 Initialization
W $99AA,2,2
W $99AC,2,2 Room to Right
W $99AE,4,2
B $99B2 #HTML[<img src="images/rooms/99A6.png" />]
b $9A1E Room 9A1E
W $9A1E,2,2 Room procedure
W $9A20,2,2 Initialization
W $9A22,2,2
W $9A24,2,2 Room to Right
W $9A26,2,2 Room Up
W $9A28,2,2
B $9A2A #HTML[<img src="images/rooms/9A1E.png" />]
b $9A5A Room 9A5A
W $9A5A,2,2 Room procedure
W $9A5C,2,2 Initialization
W $9A5E,2,2
W $9A60,2,2 Room to Right
W $9A62,2,2 Room Up
W $9A64,2,2 Room Down
B $9A66 #HTML[<img src="images/rooms/9A5A.png" />]
b $9A9A Room 9A9A
W $9A9A,2,2 Room procedure
W $9A9C,2,2 Initialization
W $9A9E,2,2 Room to Left
W $9AA0,2,2 Room to Right
W $9AA2,2,2 Room Up
W $9AA4,2,2
B $9AA6 #HTML[<img src="images/rooms/9A9A.png" />]
b $9ADC Room 9ADC
W $9ADC,2,2 Room procedure
W $9ADE,2,2 Initialization
W $9AE0,4,2
W $9AE4,2,2 Room Up
W $9AE6,2,2 Room Down
B $9AE8 #HTML[<img src="images/rooms/9ADC.png" />]
b $9B19 Room 9B19
W $9B19,2,2 Room procedure
W $9B1B,2,2 Initialization
W $9B1D,4,2
W $9B21,2,2 Room Up
W $9B23,2,2 Room Down
B $9B25 #HTML[<img src="images/rooms/9B19.png" />]
b $9B51 Room 9B51
W $9B51,2,2 Room procedure
W $9B53,2,2 Initialization
W $9B55,4,2
W $9B59,2,2 Room Up
W $9B5B,2,2 Room Down
B $9B5D #HTML[<img src="images/rooms/9B51.png" />]
b $9B9D Room 9B9D
W $9B9D,2,2 Room procedure
W $9B9F,2,2 Initialization
W $9BA1,4,2
W $9BA5,2,2 Room Up
W $9BA7,2,2 Room Down
B $9BA9 #HTML[<img src="images/rooms/9B9D.png" />]
b $9BE7 Room 9BE7
W $9BE7,2,2 Room procedure
W $9BE9,2,2 Initialization
W $9BEB,2,2
W $9BED,2,2 Room to Right
W $9BEF,2,2 Room Up
W $9BF1,2,2 Room Down
B $9BF3 #HTML[<img src="images/rooms/9BE7.png" />]
b $9C39
B $9C39,7,7
B $9C40,1,1 Ninja Y within the room, 0 at the top
B $9C41,1,1 Ninja X within the room
W $9C42,2,2 Ninja position in tilemap: Y * 30 + X
c $9C44 Process a dog
C $9C44,3 dog Y position address
C $9C47,3 get Ninja Y
C $9C5E,3 get Dog direction
C $9C65,3 get Ninja X
C $9C69,3 Dog X position address
C $9C71,3 get Ninja X
C $9C75,3 Dog X position address
C $9C80,3 get Dog direction
C $9C8C,3 Set update flags for Dog
C $9C96,3 Sprite Dog dead
b $9C9C Sprite Dog dead
B $9C9C,12,4 #HTML[<img src="images/sprite-9c9c.png" />]
c $9CA8 ?? Part of Dog processing
C $9CB3,3 get Dog direction
C $9CC2,3 => Decrease Energy by B
C $9CC5,3 get Dog direction
C $9CD3,3 Dog X position address
C $9CF8,3 Dog X position address
C $9D20,3 Sprite Dog 1
C $9D27,3 Sprite Dog 2
C $9D2E,3 Sprite Dog 3
C $9D37,3 Tile screen 3 start address
C $9D3B,3 !!MUT-ARG!! current Dog sprite address
C $9D40,3 get Dog direction
C $9D58,3 Set update flags for Dog, 4x3 tiles
c $9D5C Set update flags for Dog
C $9D61,3 Tile screen 1 start address
c $9D75 ?? something about Dog
C $9D89,2 => Set update flags for Dog, and RET
c $9D8B ?? something about Dog
C $9D8B,3 Sprite Dog 4
C $9D98,3 get Dog direction
C $9DB3,3 get Dog direction
c $9DCD Initialize a dog; HL = dog data address
C $9DCD,3 current dog data address
C $9DD0,3 save current Dog data address
c $9DD9 Decrease Energy by B
C $9DD9 !!MUT-CMD!! $C5 PUSH BC or $C9 RET
C $9DDA,3 Decrease Energy
C $9DEC,3 Energy is out => Saboteur dead
C $9DEF,2 !!UNUSED!!
b $9DF5 Room 9DF5
W $9DF5,2,2 Room procedure
W $9DF7,2,2 Initialization
W $9DF9,2,2 Room to Left
W $9DFB,2,2
W $9DFD,2,2 Room Up
W $9DFF,2,2
B $9E01 #HTML[<img src="images/rooms/9DF5.png" />]
b $9E22 Room 9E22
W $9E22,2,2 Room procedure
W $9E24,2,2 Initialization
W $9E26,6,2
W $9E2C,2,2 Room Down
B $9E2E #HTML[<img src="images/rooms/9E22.png" />]
b $9E73 Room 9E73
W $9E73,2,2 Room procedure
W $9E75,2,2 Initialization
W $9E77,2,2 Room to Left
W $9E79,4,2
W $9E7D,2,2 Room Down
B $9E7F #HTML[<img src="images/rooms/9E73.png" />]
b $9EB8 Room 9EB8
W $9EB8,2,2 Room procedure
W $9EBA,2,2 Initialization
W $9EBC,2,2 Room to Left
W $9EBE,2,2 Room to Right
W $9EC0,4,2
B $9EC4 #HTML[<img src="images/rooms/9EB8.png" />]
b $9ED9 Room 9ED9
W $9ED9,2,2 Room procedure
W $9EDB,2,2 Initialization
W $9EDD,2,2 Room to Left
W $9EDF,2,2 Room to Right
W $9EE1,4,2
B $9EE5 #HTML[<img src="images/rooms/9ED9.png" />]
b $9EFA Room 9EFA
W $9EFA,2,2 Room procedure
W $9EFC,2,2 Initialization
W $9EFE,2,2
W $9F00,2,2 Room to Right
B $9F02,2,2
W $9F04,2,2 Room Down
B $9F06 #HTML[<img src="images/rooms/9EFA.png" />]
b $9F3A Room 9F3A
W $9F3A,2,2 Room procedure
W $9F3C,2,2 Initialization
W $9F3E,2,2
W $9F40,2,2 Room to Right
W $9F42,2,2 Room Up
W $9F44,2,2 Room Down
B $9F46 #HTML[<img src="images/rooms/9F3A.png" />]
b $9F7E Room 9F7E
W $9F7E,2,2 Room procedure
W $9F80,2,2 Initialization
W $9F82,2,2 Room to Left
W $9F84,2,2 Room to Right
W $9F86,4,2
B $9F8A #HTML[<img src="images/rooms/9F7E.png" />]
b $A022 Room A022
W $A022,2,2 Room procedure
W $A024,2,2 Initialization
W $A026,2,2 Room to Left
W $A028,6,2
B $A02E #HTML[<img src="images/rooms/A022.png" />]
b $A0B5 Sprite Ninja dead, 6x7 tiles
B $A0B5,42,6 #HTML[<img src="images/sprite-a0b5.png" />]
c $A0DF Room #R$94AB initialization
C $A0DF,3,3 Guard data address
C $A0E2,3,3 Initialize a guard
c $A0E8 Room #R$7DA9 initialization
C $A0E8,3 Guard data address
c $A0ED Room #R$7E8C initialization
C $A0ED,3 Guard data address
c $A0F2 Room #R$920A initialization
C $A0F2,3 Guard data address
c $A0F7 Room #R$8F84 initialization
C $A0F7,3 Guard data address
c $A0FC Room #R$8B71 initialization
C $A0FC,3 Guard data address
c $A101 Room #R$8739 initialization
C $A101,3 Guard data address
c $A106 Room #R$858F initialization
C $A106,3 Guard data address
c $A10B Room #R$84EE initialization
C $A10B,3 Guard data address
c $A110 Room #R$99A6 initialization
C $A110,3 Guard data address
c $A115 Room #R$97F8 initialization
C $A115,3 Guard data address
c $A11A Room #R$94CF initialization
C $A11A,3 Guard data address
c $A11F Room #R$9B51 initialization
C $A11F,3 Guard data address
c $A124 Room #R$9F3A initialization
C $A124,3 Guard data address
c $A129 Room #R$9F7E initialization
C $A129,3 Guard data address
c $A12E Room #R$9EB8 initialization
C $A12E,3 Guard data address
c $A133 Room #R$9B19 initialization
C $A133,3 Guard data address
c $A138 Room #R$9DF5 initialization
C $A138,3 Guard data address
c $A13D ?? UNUSED??
C $A13D,3 Guard data address
c $A142 Room #R$7A17 initialization
C $A142,3 Turret data address
C $A145,3 Initialize a turret
c $A14A Room #R$7D5A initialization
C $A14A,3 Turret data address
c $A14F Room #R$7F48 initialization
C $A14F,3 Turret data address
c $A154 Room #R$7EF2 initialization
C $A154,3 Dog data address
C $A15A,3 Turret data address
c $A15F Room #R$909F initialization
C $A15F,3 Dog data address
C $A165,3 Turret data address
c $A16A Room #R$8FBD initialization
C $A16A,3 Turret data address
c $A16F Room #R$92A7 initialization
C $A16F,3 Turret data address
c $A174 Room #R$8B25 initialization
C $A174,3 Turret data address
c $A179 Room #R$8526 initialization
C $A179,3 Turret data address
c $A17E ?? UNUSED??
C $A17E,3 Turret data address
c $A183 Room #R$95D6 initialization
C $A183,3 Turret data address
c $A188 Room #R$968A initialization
C $A188,3 Turret data address
c $A18D
C $A18D,3 Turret data address
c $A192 Room #R$9A9A initialization
C $A192,3 Turret data address
c $A197 Room #R$9552 initialization
C $A197,3 Turret data address
c $A19C Room #R$9BE7 initialization
C $A19C,3 Turret data address
c $A1A1 Room #R$8D5C initialization
C $A1A1,3 Turret data address
c $A1A6 Room #R$7C2E initialization
C $A1A6,3 Dog data address
C $A1AC,3 Guard data address
c $A1AF
C $A1AF,3 Initialize a guard
c $A1B5 Room #R$7F9C initialization
C $A1B5,3 Dog data address
C $A1BB,3 Guard data address
c $A1C0 Room #R$8162 initialization
C $A1C0,3 Dog data address
C $A1C6,3 Guard data address
c $A1CB Room #R$80A7 initialization
C $A1CB,3 Dog data address
C $A1D1,3 Guard data address
c $A1D6 Room #R$9B9D initialization
C $A1D6,3 Dog data address
C $A1DC,3 Guard data address
b $A1E1 Guards data, ?? records, 6 bytes each
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
B $A253,6,6
B $A259,6,6
B $A25F,6,6
B $A265,6,6
B $A26B,6,6
b $A271 Dogs data, 19 records, 10 bytes each
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
C $A353,3 Dog data address
C $A356,3 Initialize a dog
c $A35C Room #R$7E05 initialization
C $A35C,3 Dog data address
c $A361 Room #R$83ED initialization
C $A361,3 Dog data address
c $A366 Room #R$924E initialization
C $A366,3 Dog data address
c $A36B Room #R$91BA initialization
C $A36B,3 Dog data address
c $A370 Room #R$90DB initialization
C $A370,3 Dog data address
c $A375 Room #R$8802 initialization
C $A375,3 Dog data address
c $A37A Room #R$8608 initialization
C $A37A,3 Dog data address
c $A37F Room #R$844E initialization
C $A37F,3 Dog data address
c $A384 Room #R$9739 initialization
C $A384,3 Dog data address
c $A389 Room #R$9A5A initialization
C $A389,3 Dog data address
c $A38E Room #R$80F6 initialization
C $A38E,3 Dog data address
b $A393
c $A3B5
C $A3B5,3 get Ninja Y
C $A3CE,3 => Draw Guard on tilemap
c $A3D1
C $A3D1,3 get Ninja Y
C $A3EB,3 => Draw Guard on tilemap
c $A3EE
C $A3EE,3 get Ninja Y
C $A3F6,3 get Current Guard position in tilemap
C $A40F,3 Sprite Ninja/Guard jumping 1
C $A415,3 => Draw Guard on tilemap
c $A418
C $A418,3 get Ninja Y
C $A431,3 => Draw Guard on tilemap
c $A434
C $A434,3 Set update flags for Guard, 6x7 tiles
C $A447,3 => Draw Guard on tilemap
C $A472,3 get Current Guard position in tilemap
C $A483,3 get Guard direction
C $A4A3,3 Tile screen 0 start address
C $A4AC,3 Tile screen 5 start address
C $A4B4,3 Tile screen 1 start address
C $A4C0,3 Tile screen 2 start address
C $A4CA,3 Decrease Energy by B
C $A4FD,3 get Guard direction
C $A539,3 Ninja Y address
C $A54B,3 get Guard direction
C $A552,3 Ninja X address
C $A571,3 Sprite Ninja dead
C $A58F,3 get Guard direction
C $A5BE,3 Sprite Ninja/Guard jumping 2
C $A5DB,3 Sprite Ninja/Guard jumping 1
C $A5E7,3 get Guard direction
C $A614,3 Ninja X address
C $A638,3 get Guard direction
C $A655,3 set Guard direction
C $A684,3 set Guard direction
C $A68D,3 get Guard direction
C $A6AA,3 set Guard direction
C $A6D8,3 set Guard direction
N $A6FF Draw Guard on tilemap
C $A703,3 get Guard direction
C $A70E,3 !!MUT-ARG!! current Ninja/Guard sprite address
C $A716,3 Translate Ninja tile A into Guard tile
C $A728,3 Tile screen 4 start address
C $A735,3 Translate Ninja tile A into Guard tile
b $A747
t $A752
b $A759
c $A75B Set update flags for Guard, 6x7 tiles
C $A75B,4 get Current Guard position in tilemap
C $A75F,3 Tile screen 1 start address
c $A775 Translate Ninja tile A into Guard tile, using $A787 table
b $A787
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
b $ABE5
c $AC44
w $AC72
W $AC72,48,8
w $ACA2
W $ACA2,40,8
c $ACCA Draw game screen frames and indicator text
C $ACCF,3 Screen start address
C $ACD2,3 Game screen frames/indicators RLE encoded sequence
C $ACEE,3 * 8
C $ACF1,1 * 9
C $ACF2,3 Indicator tales address
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
B $AD65,,8 #HTML[<img src="images/indicators.png" />]
b $AE02 Tiles for game screen frames/indicators, 9 bytes each
B $AE02,,9 #HTML[<img src="images/indtiles.png" />]
c $AED1 Print string with standard font
C $AED6,3 * 8
c $AEF0
C $AF13,3 Pay value text address
C $AF41,3 Print string "EXCELLENT WORK."
C $AF49,3 Print string "YOU ARE ONE OF"
C $AF51,3 Print string " OUR TEN BEST"
C $AF59,3 Print string "NINJA SABOTEURS."
C $AF61,3 Print string "ENTER YOUR NAME..."
C $AF6E,3 Print string
C $AF85,3 clear LASTK
C $AF89,3 get LASTK
c $AF9C
C $AFAD,3 Print string
C $AFED,3 Pay value text address
c $B005 Print table of records
C $B014,3 Print string
C $B01A,3 Print string
C $B023,3 Print string
C $B029,3 Print string
c $B040
C $B04D,3 Print string
t $B061
t $B066 Table of records
t $B0E8
t $B0F2
T $B101
T $B10F
T $B11C
T $B12C
b $B13E
B $B13E,9,9
b $B147
c $B148 Draw tile map on the screen
C $B148,3 Screen attributes address
C $B14B,2 17 tile lines
C $B150,3 Tile screen 5 start address
C $B156,3 Tile screen 4 start address
C $B15C,3 Tile screen 1 start address
C $B15F,3 Game screen start address
C $B163,3 Tile screen 0 start address
C $B166,3 Tile screen 2 start address
C $B169,3 Tile screen 3 start address
N $B16D Loop start
C $B16D,2 30 column
C $B170,1 Check "need update" flag in Tile screen 1
C $B171,3 zero => Skip this tile rendering
N $B177 Process Tile screen 0 - background tile
C $B178,1 get byte from Tile screen 0 tile
C $B17F,2 byte <> $FF =>
C $B18F,1 * 9
C $B190,3 Tiles start address
C $B193,1 now HL = tile address
C $B194,3 Tile buffer address
C $B1A0,3 !!MUT-ARG!! $B1A3 or $B1F9
N $B1A3 Process Tile screen 2 tile - Ninja
C $B1A4,1 get tile from Tile Screen 2 tile
C $B1DA,1 * 16
C $B1E8,3 Mirror byte if needed
C $B1EF,3 Mirror byte if needed
N $B1FC Process Tile screen 3 tile - Dog
C $B200,1 get tile from Tile screen 3
C $B20E,1 * 16
C $B21C,3 Mirror byte if needed
C $B223,3 Mirror byte if needed
N $B230 Process Tile screen 4 tile - Guard
C $B230,3 Get address in Tile screen 4
C $B23E,1 * 16
C $B24F,3 Mirror byte if needed
C $B256,3 Mirror byte if needed
N $B263 Process Tile screen 5 tile - front
C $B263,3 Get address in Tile screen 5
C $B278,1 * 16
N $B293 Draw prepared tile on the screen
C $B2A2,3 Get address in screen attributes
N $B2A9 Next column
C $B2A9,1 Next address in screen
C $B2AA,1 Next address in Tile screen 1
C $B2AD,1 Next address in Tile screen 0
C $B2B4,1 Next address in screen attributes
C $B2BB,1 Next address in Tile screen 5
C $B2C2,1 Next address in Tile screen 4
C $B2C7,1 Decrease column counter
C $B2C8,3 Continue loop by columns
N $B2CB Next tile row
C $B2DA,8 Increase address in screen attributes by 2 - next row
C $B2E3,1 Decrease line counter
C $B2E4,3 Continue loop by lines
c $B2E8 Mirror byte if needed
C $B2EA,3 Get mirror flag
C $B2F1,1 No need to mirror => return
C $B2F2,4 Mirror table half address
b $B2FD
c $B2FE Exchange $7239 (Ninja direction) and $71CD (dog direction)
c $B30F Exchange $7239 (Ninja direction) and $7347 (Guard direction)
c $B320 ?? Object procedure
c $B32A ?? Object procedure
c $B334 ?? Object procedure
c $B33E ?? Object procedure
c $B348 ?? Object procedure
c $B368 Room #R$97A6 initialization
c $B371
c $B38F Room token #0: ?? 3x3 tiles #R$7C21; params: 2 bytes (address)
C $B396,3 Tile block address
C $B3AC,3 => #R$B702 Proceed to the next room token
s $B3AF
c $B3B0
C $B3B6,3 current dog data address
C $B3F8,3 set REPDEL = 1
C $B3FB,3 set REPPER = 1
s $B401
c $B40A Initialize a guard; HL = guard data address
C $B40A,3 address to store guard data
C $B40D,3 Save Guard data address
C $B41B,3 set Guard direction
c $B41F Standard room procedure (for 63 rooms)
c $B422 Standard room initialization (for 60 rooms)
C $B422,3 => Finish room initialization
c $B425 Rooms 7C9C/92EF initialization (redirect from #R$791B)
C $B425,3,3 Guard data address
C $B428,3,3 Initialize a guard
C $B42B,3 => Finish room initialization
c $B42E Room #R$79C6 initialization
C $B42E,3,3 Dog data address
C $B431,3,3 Initialize a dog
C $B434,3 => Finish room initialization
b $B437
c $B446 Room B513 procedure (initial Room)
C $B446,3 Processing in the initial room
c $B44C Room procedure (for 19 rooms with a guard) (redirect from #R$7918)
C $B44C,3 Process a guard
c $B452 Room procedure (for 18 rooms with a dog)
C $B452,3 Process a dog
c $B458 Room procedure (for 5 rooms with a guard and a dog)
C $B458,3 Process a dog
C $B45B,3 Process a guard
c $B461 Turret initialization; HL = turret data address
C $B465,3 Tile screen 1 start address
c $B47A Room procedure (for 2 rooms with a turret and a dog)
C $B47A,3 Process a dog
C $B47D,3 Process turret
c $B483 Room procedure (for 14 rooms with a turret)
C $B483,3 Process turret
c $B489 Process turret
C $B58A,3 Movement handler address
C $B4D0,3 get Ninja X
b $B4DD
c $B4DE
R $B4DE B ??
C $B4EF,3 Pay value text address
C $B4F4,3 Screen address
C $B4F7,3 => Print string
c $B4FA Processing in initial room - the boat moving
b $B513 Room B513: Initial Room
W $B513,2,2 Room procedure
W $B515,2,2 Initialization
W $B517,2,2
W $B519,2,2 Room to Right
W $B51B,4,2
B $B51F #HTML[<img src="images/rooms/B513.png" />]
c $B532 Movement handler for initial room (B8CE handler)
C $B535,1 increase Ninja position in tilemap
C $B539,3 Ninja X address
C $B577,3 Ninja X address
C $B57A,1 Moving right one tile
C $B57E,1 increase Ninja position in tilemap
C $B58A,3 Movement handler address
s $B595
c $B596
b $B59B
c $B59E
b $B5A7
b $B5A8
w $B5B0 Table of addresses for NEAR/HELD items
b $B5C4
c $B5C7
C $B5DA,2 command = $C5 PUSH BC
C $B5DC,3 set command = PUSH BC = enable Energy decrease
C $B5F0,3 Pay value text address
C $B5F9,3 Draw game screen frames and indicator text
C $B5FD,3 set BORDCR = 0
C $B612,3 set NEAR item
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
C $B673,3,3 !!MUT-ARG!! current Dog data address
C $B6A2,3 get Guard direction
C $B6A9,3 set current Dog data address = no dog
C $B6AC,3 set current Guard data address = no guard
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
C $B700,1 now HL = room token procedure address
C $B701,1 => run token procedure
c $B702 Proceed to the next room token
C $B702,1 Restore address in the room sequence
C $B704,2 => continue room sequence processing
w $B706 Table of Room tokens
W $B706,2,2 #0: ?? 3x3 tiles $7C21; params: 2 bytes (address)
W $B708,2,2 #1: Fill to down; params: 4 bytes (count, filler, address)
W $B70A,2,2 #2: Fill to right; params: 4 bytes (count, filler, address)
W $B70C,2,2 #3: Fill rectangle; params: 5 bytes (filler, width, height, address)
W $B70E,2,2 #4: Fill whole Tile screen 0 with one tile; params: 1 byte (filler)
W $B710,2,2 #5: Draw block of tiles; params: 6 bytes (width, height, srcaddr, address)
W $B712,2,2 #6
W $B714,2,2 #7
W $B716,2,2 #8
W $B718,2,2 #9
W $B71A,2,2 #10: Fill to down-right; params: 4 bytes (count, filler, address)
W $B71C,2,2 #11: Fill to down-left; params: 4 bytes (count, filler, address)
W $B71E,2,2 #12: Draw block of tiles; params: 6 bytes (srcaddr, width, height, address)
W $B720,2,2 #13: Set border color; params: 1 byte
W $B722,2,2 #14: Put one tile at the given address; params: 3 bytes (tile, address)
c $B724 Room initialization
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
C $B751,2 35 objects
C $B754,3 get Current Room address, low byte
C $B75B,3 get Current Room address, high byte
C $B76C,1 next object
C $B76D,2 continue loop by objects
C $B77C,3 clear LASTK
C $B781,3 get LASTK
C $B796,1 Decrease Time lower digit
C $B79F,1 Decrease Time higher digit
C $B7A1,3 time is out =>
C $B7A7,3 Indicator Time value address
C $B7AA,2 Two digits
C $B7AC,3 Print string
C $B7C7,3 Print string "BOMB"
C $B7CA,3 !!MUT-ARG!! "99"
C $B7CD,3 set Indicator Time value
C $B7ED,3 Tile screen 1 start address
C $B7F2,3 510 - 1
C $B7F5,3 Tile screen 1 start address + 1
C $B7FA,3 Set update flags for Ninja, 6x7 tiles
C $B7FD,3 Tile screen 2 start address
C $B802,3 510 - 1
C $B805,3 Tile screen 2 start address + 1
C $B808,2 Fill the Tile screen 2
C $B80F,2 35 = number of records
C $B811,3 Table address
C $B81F,1 add Ninja position in tilemap
c $B83C
C $B848,1 increase Energy
b $B84A
W $B84A,2,2 ??
B $B84C,1,1 ??
W $B84D,2,2 ??
B $B84F,1,1 NEAR item
B $B850,1,1 ?? HELD item tile ??
c $B851
c $B86C
c $B889
C $B891,3 NEAR item address
C $B8A4,3 Draw NEAR/HELD item
C $B8C5,3 Draw NEAR/HELD item
C $B8CD,3 !!MUT-ARG!! => run handler
c $B8D0 ?? Object procedure
C $B8D0,3 Set update flags for Ninja, 6x7 tiles
C $B8D3,3 Tile screen 4 start address
C $B8D8,3 510 - 1
C $B8E0,3 get Ninja position in tilemap
C $B8EE,4 get Ninja sprite address
C $B907,3 Tile screen 2 start address
C $B90B,4 get Ninja sprite address
C $B922,3 Tile screen 3 start address
C $B927,3 Tile screen 3 start address + 1
C $B92A,3 510 - 1
C $B92F,3 get Current Room address
c $B937
C $B9B5,3 Tile screen 0 start address
C $B9C1,3 Tile screen 3 start address
C $B9DB,3 Tile screen 4 start address
C $BA03,3 Tile screen 2 start address
C $BA0E,3 Decrease Energy by B
C $BA41,3 Draw tile map on the screen
b $BAB2
t $BAC4
b $BAC7
c $BAD5
c $BBAE
C $BBB4,3 Tile screen 1 start address
c $BBBB Set update flags for Ninja, 6x7 tiles
C $BBBB,3 get Ninja position in tilemap
C $BBBE,3 Tile screen 1 start address
c $BBD4 ?? Movement handler
C $BBD4,3 Read Input
C $BBD7,2 check FIRE bit
c $BBDF Read Input
C $BBE4,1 Input method = Keyboard/Protek?
C $BBE7,2 read joystick port
C $BBE9,3 store input bits
c $BC0D
N $BC0D Prepare screen background for title picture
C $BC0D,3 !!MUT-ARG!!
N $BC38 Show title picture
C $BC38,3,3 Show title picture (two ninjas)
c $BC55 ?? Movement handler
C $BC70,3 Decrease Energy by B
C $BCAD,3 "SEPUKU" / "MISSION ABORTED"
C $BCB9,3 => Ninja falling
C $BCC4,3 Read Input
C $BCC7,2 check FIRE bit
N $BCCC FIRE pressed
C $BCDE,3 get Ninja position in tilemap
t $BD2F
c $BD33
c $BD37
C $BD52,3 get Ninja position in tilemap
C $BD59,3 get Ninja X
C $BD71,3 get Ninja Y
C $BD91,3 get Input bits
C $BD94,2 check UP bit
C $BD9B,2 check DOWN bit
c $BDAF
c $BDB2
C $BDB2,3 get Ninja position in tilemap
C $BCB6,3 Check for falling
C $BDD4,3 Movement handler address
c $BDDD
C $BDE5,4 get Ninja position in tilemap
c $BE0D ?? Movement handler
C $BE43,3 set Ninja position in tilemap
c $BE5A
C $BE5D,3 Sprite Ninja sitting
c $BE63 ?? Movement handler (B8CE handler)
C $BE63,2 command = $C9 RET
C $BE65,3 set command = RET = disable Energy decrease
C $BE6B,3 Sprite Ninja dead
c $BE71 Time is out
C $BE78,3 "TIME OUT" / "MISSION TERMINATED"
N $BEAA Saboteur is dead
C $BEAB,3 "SABOTEUR DEAD" / "MISSION FAILURE"
c $BEB3
C $BEB3,3 !!MUT-ARG!! two-line message address
C $BEBB,3 Print string 1st line
C $BEC3,3 Print string 2nd line
C $BEDA,3 Pause, then wait for any key pressed
C $BEDF,1 !!MUT-CMD!!
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
C $BF94,3 get Input bits
C $BF99,2 check RIGHT bit
C $BFA0,2 check LEFT bit
C $BFAD,3 Sprite Ninja/Guard jumping 1
c $BFB0 Set movement handler = HL, set Ninja sprite = DE
C $BFB3,4 set Ninja sprite address = DE
c $BFBA
C $BFBF,3 get Ninja position in tilemap
C $BFCC,3 Movement handler address
C $BFCF,3 Sprite Ninja sitting
c $BFD5
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
C $C03D,3 Skill level address
C $C042,3 Print skill level digit
C $C056,3 "ESCAPE" / "MISSION SUCCESSFUL"
t $C062
T $C062,14
T $C070,5
T $C075,13
T $C082,5
T $C087,13
c $C094
b $C0E6
c $C12E
C $C12E,3 Movement handler for Ninja on ladder
C $C134,3 Sprite Ninja on ladder
C $C137,3 set Ninja sprite address
C $C13A,3 => Move down one tile
c $C13D
C $C14B,3 Movement handler address
C $C16B,3 set Ninja sprite address
b $C171
c $C1B6 ?? (B8CE handler)
C $C1B6,3 get Ninja X
C $C1BB,3 => Going to room at Right
C $C1BE,3 get Ninja position in tilemap
C $C1CA,3 Ninja Y address
C $C1CE,3 get Ninja position in tilemap
C $C1D1,3 -30
C $C1D5,3 set Ninja position in tilemap
C $C1E3,3 Read Input
C $C1E6,2 check RIGHT bit
C $C1F9,3 get Ninja position in tilemap
C $C200,3 set Ninja position in tilemap
C $C203,3 Ninja Y address
C $C20A,3 => Going to room Down from current
C $C20D,3 Ninja X address
C $C211,3 get Ninja position in tilemap
C $C214,1 move one tile to right
C $C215,3 set Ninja position in tilemap
C $C218,3 Check for falling
C $C21B,3 => Ninja falling
c $C22F ?? Movement handler (B8CE handler)
C $C22F,3 Read Input
C $C232,2 check DOWN bit
C $C239,3 get Ninja position in tilemap
C $C245,3 => Decrease Energy by B
c $C24B ?? Movement handler (B8CE handler)
C $C24B,3 get Ninja X
C $C250,3 => Going to room at Left
C $C253,3 get Ninja position in tilemap
C $C25F,3 Ninja Y address
C $C262,1 moving one row up
C $C263,3 get Ninja position in tilemap
C $C26A,3 set Ninja position in tilemap
C $C278,3 Read Input
C $C27B,2 check LEFT bit
C $C283,3 +61
C $C28E,3 get Ninja position in tilemap
C $C291,3 +30
C $C295,3 set Ninja position in tilemap
C $C298,3 Ninja Y address
C $C29B,1 moving one tile right
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
C $C2EE,3 address for Ninja sprite address
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
c $C339 ?? (B8CE handler)
C $C343,3 get Ninja position in tilemap
C $C370,3 get Ninja position in tilemap
c $C392
c $C3BB Move LEFT one tile
C $C3BB,3 Ninja X address
C $C3BE,1 one tile to left
C $C3BF,3 get Ninja position in tilemap
C $C3C2,1 move one tile left
C $C3C3,3 set Ninja position in tilemap
C $C3C6,3 Movement handler for Ninja on ladder
C $C3C9,3 Sprite Ninja on ladder
c $C3CF Move RIGHT one tile
C $C3CF,3 Ninja X address
C $C3D2,1 one tile to right
C $C3D3,3 get Ninja position in tilemap
C $C3D6,1 move one tile right
c $C3D9 Movement handler (B8CE handler): Ninja on ladder
C $C3D9,3 get Ninja position in tilemap
N $C3EC Read and process Input
C $C3EC,3 Read Input
C $C3EF,2 check RIGHT bit
N $C3F3 Pressed RIGHT
C $C3F3,3 get Ninja position in tilemap
C $C40E,2 check LEFT bit
N $C412 Pressed LEFT
C $C412,3 get Ninja position in tilemap
N $C42C Check if UP pressed
C $C42C,3 get Input bits
C $C42F,2 check UP bit
N $C433 Pressed UP
C $C433,3 get Ninja position in tilemap
C $C447,3 get Ninja Y
C $C45D,3 Ninja Y address
C $C461,3 get Ninja position in tilemap
C $C468,3 set Ninja position in tilemap
N $C477 Check if DOWN pressed
N $C47B Pressed DOWN
C $C47B,3 get Ninja Y
C $C480,3 => Going to room Down from current
C $C483,3 get Ninja position in tilemap
C $C48D,2 => Move down one tile
C $C493,2 => Move down one tile
c $C498 Move DOWN one tile
C $C498,3 Ninja Y address
C $C49B,1 one tile down
C $C49C,3 get Ninja position in tilemap
c $C4A4
c $C4A7 ?? Movement handler
C $C4AE,3 get Ninja position in tilemap
C $C4D0,3 Movement handler address
C $C4D3,3 Sprite Ninja/Guard jumping 1
c $C4DE ?? Movement handler
c $C4E8
C $C4ED,3 Movement handler address
c $C4F6 Movement handler (used in initial room)
C $C4FE,3 Decrease Energy by B
C $C504,3 Movement handler address
c $C50D
C $C512,3 Ninja X address
C $C51A,3 => Going to room at Left
C $C51E,3 get Ninja position in tilemap
C $C522,3 set Ninja position in tilemap
C $C535,3 Decrease Energy by B
C $C53D,3 get Ninja position in tilemap
C $C546,3 Ninja Y address
C $C54A,3 get Ninja position in tilemap
C $C553,3 set Ninja position in tilemap
C $C563,3 Movement handler address
C $C56E,3 => Going to room at Right
C $C572,3 get Ninja position in tilemap
C $C576,3 set Ninja position in tilemap
c $C57B
C $C585,4 get Ninja position in tilemap
C $C58A,3 Tile screen 0 start address
c $C5A0
c $C5A3 Check for falling
C $C5A3,3 get Ninja position in tilemap
C $C5AA,3 Tile screen 0 start address
c $C5C6 Movement handler, Ninja falling
C $C5C6,3 get Ninja position in tilemap
C $C5C9,3 +30
C $C5CD,3 set Ninja position in tilemap
C $C5D4,3 Ninja Y address
C $C5DB,2 => Going to room Down from current
C $C5DD,3 get Ninja position in tilemap
C $C5F9,3 Decrease Energy by B
c $C604 Going to room Down from current
C $C605,3 set Ninja Y = 0
C $C608,3 get Ninja position in tilemap
C $C60B,3 -300
C $C60E,1 10 tile lines higher
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
C $C62E,1 10 tile lines lower
C $C62F,3 set Ninja position in tilemap
C $C632,3 get Current Room address
C $C635,3 offset in room description
C $C638,1 now HL = room address + 8
C $C639,1 get Room Up address low byte
C $C63B,1 get Room Up address high byte
C $C63D,3 set Current Room address
C $C640,3 => Current Room changed
c $C643 Ninja falling
C $C646,3 Sprite Ninja falling
c $C649
c $C64C Room #R$791E (room with pier) initialization
C $C657,3 => Finish room initialization
b $C65A
b $C66B
c $C671 Room #R$93DF/#R$947C (room right from vagon) initialization
c $C681 Room #R$982B initialization
c $C6A5 Room 7C9C procedure (tunnel vagon)
C $C6A5,3 get Ninja X
C $C6B2,4 get Ninja position in tilemap
C $C6B6,3 get Ninja X
C $C6CE,3 set Ninja X
C $C6D1,4 set Ninja position in tilemap
C $C6D8,4 set Ninja sprite
c $C6E2 ?? (B8CE handler)
c $C70C
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
b $C921
T $C921
B $C92A
T $C92D
B $C93A
T $C93D
B $C94A
T $C94D
B $C95A
T $C95D
B $C96A
T $C96D
B $C97A
T $C97D
B $C98A
T $C98D
B $C99A
T $C99D
B $C9AA
T $C9AD
B $C9BA
T $C9BD
B $C9CA
T $C9CD
B $C9DA
T $C9DD
B $C9EA
T $C9ED
B $C9FA
T $C9FD
B $CA0A
T $CA0D
B $CA1A
T $CA1D
B $CA2A
T $CA2D
B $CA3A
T $CA3D
B $CA4A
T $CA4D
B $CA5A
T $CA5D
B $CA6A
T $CA6D
B $CA7A
T $CA7D
B $CA8A
T $CA8D
B $CA9A
T $CA9D
B $CAAA
T $CAAD
B $CABA
T $CABD
B $CACA
T $CACD
B $CADA
T $CADD
B $CAEA
T $CAED
B $CAFA
T $CAFD
B $CB0A
T $CB0D
B $CB1A
T $CB1D
B $CB2A
T $CB2D
B $CB3A
T $CB3D
B $CB4A
T $CB4D
B $CB5A
T $CB5D
B $CB6A
T $CB6D
B $CB7A
T $CB7D
B $CB8A
T $CB8D
B $CB9A
T $CB9D
B $CBAA
T $CBAD
B $CBBA
T $CBBD
B $CBCA
T $CBCD
B $CBDA
T $CBDD
B $CBEA
T $CBED
B $CBFA
T $CBFD
B $CC0A
T $CC0D
B $CC1A
T $CC1D
B $CC2A
T $CC2D
B $CC3A
T $CC3D
B $CC4A
T $CC4D
B $CC5A
T $CC5D
B $CC6A
T $CC6D
B $CC7A
T $CC7D
B $CC8A
T $CC8D
B $CC9A
T $CC9D
B $CCAA
T $CCAD
B $CCBA
T $CCBD
B $CCCA
T $CCCD
B $CCDA
T $CCDD
B $CCEA
T $CCED
B $CCFA
T $CCFD
B $CD0A
T $CD0D
B $CD1A
T $CD1D
B $CD2A
T $CD2D
B $CD3A
T $CD3D
B $CD4A
T $CD4D
B $CD5A
T $CD5D
B $CD6A
T $CD6D
B $CD7A
T $CD7D
B $CD8A
T $CD8D
B $CD9A
T $CD9D
B $CDAA
T $CDAD
B $CDBA
T $CDBD
B $CDCA
T $CDCD
B $CDDA
T $CDDD
B $CDEA
T $CDED
B $CDFA
T $CDFD
B $CE0A
T $CE0D
B $CE1A
T $CE1D
B $CE2A
T $CE2D
B $CE3A
T $CE3D
B $CE4A
T $CE4D
B $CE5A
T $CE5D
B $CE6A
T $CE6D
B $CE7A
T $CE7D
B $CE8A
T $CE8D
B $CE9A
T $CE9D
B $CEAA
T $CEAD
B $CEBA
T $CEBD
B $CECA
T $CECD
B $CEDA
T $CEDD
B $CEEA
T $CEED
B $CEFA
T $CEFD
B $CF0A
T $CF0D
B $CF1A
T $CF1D
B $CF2A
T $CF2D
B $CF3A
T $CF3D
B $CF4A
T $CF4D
B $CF5A
T $CF5D
B $CF6A
T $CF6D
B $CF7A
T $CF7D
B $CF8A
T $CF8D
B $CF9A
T $CF9D
B $CFAA
T $CFAD
B $CFBA
T $CFBD
B $CFCA
T $CFCD
B $CFDA
T $CFDD
B $CFEA
T $CFED
B $CFFA
T $CFFD
B $D00A
T $D00D
B $D01A
T $D01D
B $D02A
T $D02D
B $D03A
T $D03D
B $D04A
T $D04D
B $D05A
T $D05D
B $D06A
T $D06D
B $D07A
T $D07D
B $D08A
T $D08D
B $D09A
T $D09D
B $D0AA
T $D0AD
B $D0BA
T $D0BD
B $D0CA
T $D0CD
B $D0DA
T $D0DD
B $D0EA
T $D0ED
B $D0FA
T $D0FD
B $D10A
T $D10D
B $D11A
T $D11D
B $D12A
T $D12D
B $D13A
T $D13D
B $D14A
T $D14D
B $D15A
T $D15D
B $D16A
T $D16D
B $D17A
T $D17D
B $D18A
T $D18D
B $D19A
T $D19D
B $D1AA
T $D1AD
B $D1BA
T $D1BD
B $D1CE
T $D1D1
B $D1DE
T $D1E1
B $D1EE
T $D1F1
B $D1FE
T $D201
B $D20E
b $D210
b $D256 Table ?? objects, 35 records, 7-byte records
W $D256,2,2 Object ?? 00
B $D258,3,3
W $D25B,2,2
W $D25D,2,2 Object ?? 01
B $D25F,3,3
W $D262,2,2
W $D264,2,2 Object ?? 02
B $D266,3,3
W $D269,2,2
W $D26B,2,2 Object ?? 03
B $D26D,3,3
W $D270,2,2
W $D272,2,2 Object ?? 04
B $D274,3,3
W $D277,2,2
W $D279,2,2 Object ?? 05
B $D27B,3,3
W $D27E,2,2
W $D280,2,2 Object ?? 06
B $D282,3,3
W $D285,2,2
W $D287,2,2 Object ?? 07
B $D289,3,3
W $D28C,2,2
W $D28E,2,2 Object ?? 08
B $D290,3,3
W $D293,2,2
W $D295,2,2 Object ?? 09
B $D297,3,3
W $D29A,2,2
W $D29C,2,2 Object ?? 10
B $D29E,3,3
W $D2A1,2,2
W $D2A3,2,2 Object ?? 11
B $D2A5,3,3
W $D2A8,2,2
W $D2AA,2,2 Object ?? 12
B $D2AC,3,3
W $D2AF,2,2
W $D2B1,2,2 Object ?? 13
B $D2B3,3,3
W $D2B6,2,2
W $D2B8,2,2 Object ?? 14
B $D2BA,3,3
W $D2BD,2,2
W $D2BF,2,2 Object ?? 15
B $D2C1,3,3
W $D2C4,2,2
W $D2C6,2,2 Object ?? 16
B $D2C8,3,3
W $D2CB,2,2
W $D2CD,2,2 Object ?? 17
B $D2CF,3,3
W $D2D2,2,2
W $D2D4,2,2 Object ?? 18
B $D2D6,3,3
W $D2D9,2,2
W $D2DB,2,2 Object ?? 19
B $D2DD,3,3
W $D2E0,2,2
W $D2E2,2,2 Object ?? 20
B $D2E4,3,3
W $D2E7,2,2
W $D2E9,2,2 Object ?? 21
B $D2EB,3,3
W $D2EE,2,2
W $D2F0,2,2 Object ?? 22
B $D2F2,3,3
W $D2F5,2,2
W $D2F7,2,2 Object ?? 23
B $D2F9,3,3
W $D2FC,2,2
W $D2FE,2,2 Object ?? 24
B $D300,3,3
W $D303,2,2
W $D305,2,2 Object ?? 25
B $D307,3,3
W $D30A,2,2
W $D30C,2,2 Object ?? 26
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
W $D328,2,2 Object ?? 30
B $D32A,3,3
W $D32D,2,2
W $D32F,2,2 Object ?? 31
B $D331,3,3
W $D334,2,2
W $D336,2,2 Object ?? 32
B $D338,3,3
W $D33B,2,2
W $D33D,2,2 Object ?? 33
B $D33F,3,3
W $D342,2,2
W $D344,2,2 Object ?? 34
B $D346,3,3
B $D349,2,2
b $D34B
W $D34B,2,2
b $D34D Table of objects, 35 records, 5 bytes each
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
W $D3C5,4,4
B $D3C9,1,1
W $D3CA,4,4
B $D3CE,1,1
W $D3CF,4,4
B $D3D3,1,1
W $D3D4,4,4
B $D3D8,1,1
W $D3D9,4,4 #29
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
N $D4B0 Sprite Ninja/Guard jumping 1
B $D4B0,42,6 #HTML[<img src="images/sprite-d4b0.png" />]
N $D4DA Sprite Ninja/Guard jumping 2
B $D4DA,42,6 #HTML[<img src="images/sprite-d4da.png" />]
N $D504 Sprite Ninja/Guard standing hit
B $D504,42,6 #HTML[<img src="images/sprite-d504.png" />]
N $D52E Sprite Ninja on ladder
B $D52E,42,6 #HTML[<img src="images/sprite-d52E.png" />]
N $D558 Sprite Ninja sitting
B $D558,42,6 #HTML[<img src="images/sprite-d558.png" />]
N $D582 Sprite Ninja falling
B $D582,42,6 #HTML[<img src="images/sprite-d582.png" />]
N $D5AC Sprite Ninja jumping 3
B $D5AC,42,6 #HTML[<img src="images/sprite-d5ac.png" />]
N $D5D6 Sprite Ninja jumping 4
B $D5D6,42,6 #HTML[<img src="images/sprite-d5d6.png" />]
b $D600
B $D600
c $DE68
C $DE6D,3 get Current Room address
b $DE84
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
C $DF3B,3 set REPDEL = 1
C $DF3E,3 set REPPER = 1
C $DF43,3 set BORDCR = $08
C $DF54,3 get LASTK
C $DF59,2 key pressed => Main menu
c $DF60 Main menu
C $DF60,3 Clear strings on the screen
C $DF63,3 Menu messages address
C $DF6B,3 Print string
C $DF73,3 Print string
C $DF7B,3 Print string
C $DF83,3 Print string
C $DF8B,3 Print string
C $DF91,3 Highlight Menu item
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
b $E039
B $E039,10,10 Protek ports/bits
B $E043,10,10 Keyboard input ports/bits
c $E04D
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
C $E10A,3 get LASTK
C $E145,3 Print string
b $E17C
T $E17C,1,1
t $E1EC
T $E1EC,1
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
C $E2B5,3 Print string "ENTER SKILL LEVEL"
C $E2BD,3 Print string "1 TO 9"
C $E2D3,3 get LASTK
C $E2DE,3 Skill level address
C $E2E7,3 Print string
C $E302,3 Print string "YOUR MISSION"
C $E30A,3 Print string "WILL BE"
C $E30D,3 get Skill level
C $E318,1 * 16
C $E319,3 Levels data base address
C $E322,3 Print string - level description
C $E33B,4 set Indicator Time value
C $E343,4 set initial Time value
C $E36F,2 Copy last 4 bytes: BOMB placement
C $E37C,3 get LASTK
b $E388
T $E388,4
b $E38C Levels data
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
c $E440
b $E494
b $E700 Tiles with mask, 256 tiles, 16 bytes each
N $E700 Used for Ninja on Tile Screen 2, and for Guard on Tile Screen 4
N $E700 #HTML[<img src="images/tiles-e700.png" />]
B $E700,,16
b $F700 Background tiles, 69 tiles, 9 bytes each
N $F700 #HTML[<img src="images/backtiles.png" />]
B $F700,621,9
c $F973 Room #R$84A8 initialization
c $F9A1
b $F98F
B $F98F,18,3
c $F9B9 Pause, then wait for any key pressed
C $F9C5,3 Read Input
C $F9CD,3 get Input bits
C $F9D8,3 clear LASTK
C $F9DC,3 get LASTK
b $F9E4
c $FA31
b $FA3A
