@ $6270 org
b $6270
c $6289
C $628C,3 Tile screen 0 start address
C $62AC,3 Tile screen 0 start address
b $62DB
t $6464
b $6467
b $6590 Tile screen 0 30x17 tiles, 510 bytes
B $6590,,30
T $65E7
T $65F2
b $678E Tile screen 1 30x17 tiles, 510 bytes
T $678E
T $6867
T $6868
B $68E7
B $68F6,,30
b $698C Tile screen 2 30x17 tiles, 510 bytes
B $698C,510,30
b $6B8A Tile screen 3 30x17 tiles, 510 bytes
B $6B8A,510,30
b $6D88 Tile screen 4 30x17 tiles, 510 bytes
B $6D88,510,30
b $6F86 Tile screen 5 30x17 tiles, 510 bytes
B $6F86,510,30
b $7184
W $7184,2,2 Current Room address
W $7186,2,2 ??
t $71BC
b $71BF
t $71C0
b $71C3
b $7222
B $7222,10,10 Ports and bits for the current input method
W $7233,2,2 Screen attributes address stored during tile map drawing
W $7235,2,2 Tile screen 5 address stored during tile map drawing
W $7237,2,2 Tile screen 4 address stored during tile map drawing
B $7239,1 Byte mirror flag
b $723A Mirror table
B $723A,128,16 Mirror table 1st part
B $72BA,128,16 Mirror table 2nd part
b $733A
c $734A
c $734D Room token #14: Put one tile at the given address
C $7357,2 => #R$B702 Proceed to the next room token
c $7359 Room token #13: Set border color; params: 1 byte
C $735F,2 => #R$B702 Proceed to the next room token
c $7361
C $7365,3 Tile screen 0 start address
C $737F,2 => #R$B702 Proceed to the next room token
c $7381 Room token #1: Fill to down; params: 4 bytes (count, filler, address)
C $7393,2 => #R$B702 Proceed to the next room token
c $7395 Room token #10: Fill to down-right; params: 4 bytes (count, filler, address)
c $739A Room token #11: Fill to down-left; params: 4 bytes (count, filler, address)
c $739F Room token #2: Fill to right; params: 4 bytes (count, filler, address)
c $73A4 Room token #6:
C $73BB,1 !!MUT-CMD!!
C $73C3,2 => #R$B702 Proceed to the next room token
c $73C5 Room token #7:
C $73DE,1 !!MUT-CMD!!
C $73E8,3 => #R$B702 Proceed to the next room token
c $73EB Room token #8:
c $73EF Room token #9:
c $73F3 Room token #4: Fill whole Tile screen 0 with one tile; params: 1 byte (filler)
C $73F7,3 Tile screen 0 start address
C $73FA,3 Tile screen 0 start address + 1
C $73FE,3 510 - 1
C $7403,3 => #R$B702 Proceed to the next room token
c $7406 Room token #5: Draw block of tiles; params: 6 bytes (width, height, srcaddr, address)
C $7428,3 => #R$B702 Proceed to the next room token
c $742B Room token #12: Draw block of tiles; params: 6 bytes (srcaddr, width, height, address)
C $744F,3 => #R$B702 Proceed to the next room token
c $7452 Room token #3: Fill rectangle; params: 5 bytes (filler, width, height, address)
C $746F,3 => #R$B702 Proceed to the next room token
c $7472
b $749C
B $749D
c $749E
C $74C6,1 Decrease Energy
c $74CD Draw NEAR/HELD item
b $750B
b $751B
b $752B
c $7918
c $791B
b $791E Room 791E (room with pier)
W $791E,12,2
W $7924,2,2 Room to Right
W $7926,4,2
B $792A #HTML[<img src="images/rooms/791E.png" />]
b $7984
b $79A1
b $79B1
b $79BA
b $79BE
b $79C6 Room 79C6 (next to room with pier)
W $79C6,12,2
W $79CA,2,2 Room to Left
W $79CC,2,2 Room to Right
W $79CE,4,2
B $79D2 #HTML[<img src="images/rooms/79C6.png" />]
b $7A17 Room 7A17
W $7A17,12,2
W $7A1B,2,2 Room to Left
W $7A1D,2,2 Room to Right
W $7A1F,2,2 Room Up
W $7A21,2,2
B $7A23 #HTML[<img src="images/rooms/7A17.png" />]
b $7A75 Room 7A75
W $7A75,12,2
W $7A7D,2,2 Room Up
W $7A7F,2,2 Room Down
B $7A81 #HTML[<img src="images/rooms/7A75.png" />]
b $7A9E Room 7A9E
W $7A9E,12,2
W $7AA4,2,2 Room to Right
W $7AA6,2,2 Room Up
W $7AA8,2,2
B $7AAA #HTML[<img src="images/rooms/7A9E.png" />]
b $7ACD Room 7ACD
W $7ACD,12,2
W $7AD1,2,2 Room to Left
W $7AD3,2,2 Room to Right
W $7AD5,2,2 Room Up
W $7AD7,2,2
B $7AD9 #HTML[<img src="images/rooms/7ACD.png" />]
b $7AF8 Room 7AF8
W $7AF8,12,2
W $7AFC,2,2 Room to Left
W $7B00,2,2 Room Up
W $7B02,2,2
B $7B04 #HTML[<img src="images/rooms/7AF8.png" />]
b $7B56 Room 7B56
W $7B56,12,2
W $7B5E,2,2 Room Up
W $7B60,2,2 Room Down
B $7B62 #HTML[<img src="images/rooms/7B56.png" />]
b $7B90 Room 7B90
W $7B90,12,2
W $7B94,2,2 Room to Left
W $7B96,2,2 Room to Right
W $7B98,4,2
B $7B9C #HTML[<img src="images/rooms/7B90.png" />]
b $7C21
b $7BD2 Room 7BD2
W $7BD2,12,2
W $7BD6,2,2 Room to Left
W $7BD8,2,2 Room to Right
W $7BDA,2,2 Room Up
W $7BDC,2,2 Room Down
B $7BDE #HTML[<img src="images/rooms/7BD2.png" />]
b $7C2E Room 7C2E
W $7C2E,12,2
W $7C32,2,2 Room to Left
W $7C34,2,2
W $7C36,2,2 Room Up
W $7C38,2,2 Room Down
B $7C3A #HTML[<img src="images/rooms/7C2E.png" />]
b $7C6D Room 7C6D
W $7C6D,12,2
W $7C73,2,2 Room to Right
W $7C75,2,2 Room Up
W $7C77,2,2 Room Down
B $7C79 #HTML[<img src="images/rooms/7C6D.png" />]
b $7C9C Room 7C9C
W $7C9C,12,2
W $7CA0,2,2 Room to Left
W $7CA2,2,2 Room to Right
W $7CA4,4,2
B $7CA8 #HTML[<img src="images/rooms/7C9C.png" />]
b $7D5A Room 7D5A
W $7D5A,12,2
W $7D5E,2,2 Room to Left
W $7D60,2,2 Room to Right
W $7D62,2,2
W $7D64,2,2 Room Down
B $7D66 #HTML[<img src="images/rooms/7D5A.png" />]
b $7DA9 Room 7DA9
W $7DA9,12,2
W $7DAF,2,2 Room to Right
W $7DB1,2,2 Room Up
W $7DB3,2,2 Room Down
B $7DB5 #HTML[<img src="images/rooms/7DA9.png" />]
b $7E05 Room 7E05
W $7E05,12,2
W $7E0B,2,2 Room to Right
W $7E0D,2,2 Room Up
W $7E0F,2,2 Room Down
B $7E11 #HTML[<img src="images/rooms/7E05.png" />]
b $7E8C Room 7E8C
W $7E8C,12,2
W $7E90,2,2 Room to Left
W $7E92,2,2 Room to Right
W $7E94,2,2
W $7E96,2,2 Room Down
B $7E98 #HTML[<img src="images/rooms/7E8C.png" />]
b $7EF2 Room 7EF2
W $7EF2,12,2
W $7EF6,2,2 Room to Left
W $7EF8,6,2
B $7EFE #HTML[<img src="images/rooms/7EF2.png" />]
b $7F48 Room 7F48
W $7F48,12,2
W $7F4E,2,2 Room to Right
W $7F50,2,2 Room Up
W $7F52,2,2 Room Down
B $7F54 #HTML[<img src="images/rooms/7F48.png" />]
b $7F9C Room 7F9C
W $7F9C,12,2
W $7FA0,2,2 Room to Left
W $7FA2,4,2
W $7FA6,2,2 Room Down
B $7FA8 #HTML[<img src="images/rooms/7F9C.png" />]
b $7FC4 Room 7FC4
W $7FC4,12,2
W $7FC8,2,2 Room to Left
W $7FCA,2,2 Room to Right
W $7FCC,2,2 Room Up
W $7FCE,2,2
B $7FD0 #HTML[<img src="images/rooms/7FC4.png" />]
b $8008 Room 8008
W $8008,12,2
W $800C,2,2 Room to Left
W $800E,2,2
W $8010,2,2 Room Up
W $8012,2,2 Room Down
B $8014 #HTML[<img src="images/rooms/8008.png" />]
b $8076 Room 8076
W $8076,12,2
W $807E,2,2 Room Up
W $8080,2,2 Room Down
B $8082 #HTML[<img src="images/rooms/8076.png" />]
b $80A7 Room 80A7
W $80A7,12,2
W $80AB,2,2 Room to Left
W $80AD,2,2 Room to Right
W $80AF,4,2
B $80B3 #HTML[<img src="images/rooms/80A7.png" />]
b $80F6 Room 80F6
W $80F6,12,2
W $80FA,2,2 Room to Left
W $80FC,6,2
B $8102 #HTML[<img src="images/rooms/80F6.png" />]
b $8162 Room 8162
W $8162,12,2
W $8166,2,2 Room to Left
W $8168,2,2
W $816A,2,2 Room Up
W $816C,2,2 Room Down
B $816E #HTML[<img src="images/rooms/8162.png" />]
b $81E5 Room 81E5
W $81E5,12,2
W $81E9,2,2 Room to Left
W $81EB,2,2 Room to Right
W $81ED,4,2
B $81F1 #HTML[<img src="images/rooms/81E5.png" />]
b $8238 Room 8238
W $8238,12,2
W $823E,2,2 Room to Right
W $8240,2,2 Room Up
W $8242,2,2 Room Down
B $8244 #HTML[<img src="images/rooms/8238.png" />]
b $8279 Room 8279
W $8279,12,2
W $827F,2,2 Room to Right
W $8281,2,2
W $8283,2,2 Room Down
B $8285 #HTML[<img src="images/rooms/8279.png" />]
b $82DD Room 82DD
W $82DD,12,2
W $82E1,2,2 Room to Left
W $82E3,2,2 Room to Right
W $82E5,2,2
W $82E7,2,2 Room Down
B $82E9 #HTML[<img src="images/rooms/82DD.png" />]
b $8321 Room 8321
W $8321,12,2
W $8325,2,2 Room to Left
W $8327,2,2
W $8329,2,2 Room Up
W $832B,2,2 Room Down
B $832D #HTML[<img src="images/rooms/8321.png" />]
b $8384 Room 8384
W $8384,12,2
W $838C,2,2 Room Up
W $838E,2,2 Room Down
B $8390 #HTML[<img src="images/rooms/8384.png" />]
b $83ED Room 83ED
W $83ED,12,2
W $83F3,2,2 Room to Right
W $83F5,2,2 Room Up
W $83F7,2,2 Room Down
B $83F9 #HTML[<img src="images/rooms/83ED.png" />]
b $844E Room 844E
W $844E,12,2
W $8452,2,2 Room to Left
W $8454,4,2
W $8458,2,2 Room Down
B $845A #HTML[<img src="images/rooms/844E.png" />]
b $84A8 Room 84A8
W $84A8,12,2
W $84AC,2,2 Room to Left
W $84AE,2,2 Room to Right
W $84B0,2,2
W $84B2,2,2 Room Down
B $84B4 #HTML[<img src="images/rooms/84A8.png" />]
b $84EE Room 84EE
W $84EE,12,2
W $84F4,2,2 Room to Right
W $84F6,2,2 Room Up
W $84F8,2,2
B $84FA #HTML[<img src="images/rooms/84EE.png" />]
b $8526 Room 8526
W $8526,12,2
W $852C,2,2 Room to Right
W $852E,2,2 Room Up
W $8530,2,2 Room Down
B $8532 #HTML[<img src="images/rooms/8526.png" />]
b $858F Room 858F
W $858F,12,2
W $8593,2,2 Room to Left
W $8595,2,2 Room to Right
W $8597,4,2
B $859B #HTML[<img src="images/rooms/858F.png" />]
b $85BD Room 85BD
W $85BD,12,2
W $85C1,2,2 Room to Left
W $85C3,2,2
W $85C5,2,2 Room Up
W $85C7,2,2
B $85C9 #HTML[<img src="images/rooms/85BD.png" />]
b $8606 Room 8606
W $8606,12,2
W $860A,2,2 Room to Left
W $860C,2,2
W $860E,2,2 Room Up
W $8610,2,2
B $8612 #HTML[<img src="images/rooms/8606.png" />]
b $8689 Room 8689
W $8689,12,2
W $868D,2,2 Room to Left
W $868F,4,2
W $8693,2,2 Room Down
B $8695 #HTML[<img src="images/rooms/8689.png" />]
b $86FD Room 86FD
W $86FD,12,2
W $8701,2,2 Room to Left
W $8703,2,2 Room to Right
W $8705,2,2 Room Up
W $8707,2,2
B $8709 #HTML[<img src="images/rooms/86FD.png" />]
b $8739 Room 8739
W $8739,12,2
W $873D,2,2 Room to Left
W $873F,2,2 Room to Right
W $8741,2,2
W $8743,2,2 Room Down
B $8745 #HTML[<img src="images/rooms/8739.png" />]
b $8799 Room 8799
W $8799,12,2
W $879F,2,2 Room to Right
W $87A1,4,2
B $87A5 #HTML[<img src="images/rooms/8799.png" />]
b $8802 Room 8802
W $8802,12,2
W $8806,2,2 Room to Left
W $8808,2,2
W $880A,2,2 Room Up
W $880C,2,2
B $880E #HTML[<img src="images/rooms/8802.png" />]
b $8834 Room 8834
W $8834,12,2
W $8838,2,2 Room to Left
W $883A,2,2 Room to Right
W $883C,2,2 Room Up
W $883E,2,2 Room Down
B $8840 #HTML[<img src="images/rooms/8834.png" />]
b $889F Room 889F
W $889F,12,2
W $88A3,2,2 Room to Left
W $88A5,2,2 Room to Right
W $88A7,2,2 Room Up
W $88A9,2,2 Room Down
B $88AB #HTML[<img src="images/rooms/889F.png" />]
b $890E Room 890E
W $890E,12,2
W $8912,2,2 Room to Left
W $8914,2,2 Room to Right
W $8916,4,2
B $891A #HTML[<img src="images/rooms/890E.png" />]
b $8953 Room 8953
W $8953,12,2
W $8959,2,2 Room to Right
W $895B,2,2 Room Up
W $895D,2,2 Room Down
B $895F #HTML[<img src="images/rooms/8953.png" />]
b $89B9 Room 89B9
W $89B9,12,2
W $89BF,2,2 Room to Right
W $89C1,2,2
W $89C3,2,2 Room Down
B $89C5 #HTML[<img src="images/rooms/89B9.png" />]
b $8A2D Room 8A2D
W $8A2D,12,2
W $8A31,2,2 Room to Left
W $8A33,2,2 Room to Right
W $8A35,2,2 Room Up
W $8A37,2,2 Room Down
B $8A39 #HTML[<img src="images/rooms/8A2D.png" />]
b $8A81 Room 8A81
W $8A81,12,2
W $8A85,2,2 Room to Left
W $8A87,2,2 Room to Right
W $8A89,2,2
W $8A8B,2,2 Room Down
B $8A8D #HTML[<img src="images/rooms/8A81.png" />]
b $8AF4 Room 8AF4
W $8AF4,12,2
W $8AF8,2,2 Room to Left
W $8AFA,2,2 Room to Right
W $8AFC,2,2 Room Up
W $8AFE,2,2 Room Down
B $8B00 #HTML[<img src="images/rooms/8AF4.png" />]
b $8B25 Room 8B25
W $8B25,12,2
W $8B2B,2,2 Room to Right
W $8B2D,2,2
W $8B2F,2,2 Room Down
B $8B31 #HTML[<img src="images/rooms/8B25.png" />]
b $8B71 Room 8B71
W $8B71,12,2
W $8B75,2,2 Room to Left
W $8B77,2,2 Room to Right
W $8B79,4,2
B $8B7D #HTML[<img src="images/rooms/8B71.png" />]
b $8BAB Room 8BAB
W $8BAB,12,2
W $8BAF,2,2 Room to Left
W $8BB1,4,2
W $8BB5,2,2 Room Down
B $8BB7 #HTML[<img src="images/rooms/8BAB.png" />]
b $8BF0 Room 8BF0
W $8BF0,12,2
W $8BF4,2,2 Room to Left
W $8BF6,2,2 Room to Right
W $8BF8,2,2
W $8BFA,2,2 Room Down
B $8BFC #HTML[<img src="images/rooms/8BF0.png" />]
b $8C5A Room 8C5A
W $8C5A,12,2
W $8C5E,2,2 Room to Left
W $8C60,2,2 Room to Right
W $8C62,2,2
W $8C64,2,2 Room Down
B $8C66 #HTML[<img src="images/rooms/8C5A.png" />]
b $8CC8 Room 8CC8
W $8CC8,12,2
W $8CCC,2,2 Room to Left
W $8CCE,2,2 Room to Right
W $8CD0,4,2
B $8CD4 #HTML[<img src="images/rooms/8CC8.png" />]
b $8D18 Room 8D18
W $8D18,12,2
W $8D1C,2,2 Room to Left
W $8D1E,2,2 Room to Right
W $8D20,2,2 Room Up
W $8D22,2,2 Room Down
B $8D24 #HTML[<img src="images/rooms/8D18.png" />]
b $8D5C Room 8D5C
W $8D5C,12,2
W $8D60,2,2 Room to Left
W $8D62,4,2
W $8D66,2,2 Room Down
B $8D68 #HTML[<img src="images/rooms/8D5C.png" />]
b $8DCA Room 8DCA (helicopter)
W $8DCA,12,2
W $8DD0,2,2 Room to Right
W $8DD2,4,2
B $8DD6 #HTML[<img src="images/rooms/8DCA.png" />]
b $8E4C
b $8E5A
b $8E5E
b $8E62
b $8E89
b $8E9C Room 8E9C
W $8E9C,12,2
W $8EA0,2,2 Room to Left
W $8EA2,2,2
W $8EA4,2,2 Room Up
W $8EA6,2,2 Room Down
B $8EA8 #HTML[<img src="images/rooms/8E9C.png" />]
b $8EE1 Room 8EE1
W $8EE1,12,2
W $8EE5,2,2 Room to Left
W $8EE7,4,2
W $8EEB,2,2 Room Down
B $8EED #HTML[<img src="images/rooms/8EE1.png" />]
b $8F20 Room 8F20
W $8F20,12,2
W $8F24,2,2 Room to Left
W $8F26,2,2
W $8F28,2,2 Room Up
W $8F2A,2,2 Room Down
B $8F2C #HTML[<img src="images/rooms/8F20.png" />]
b $8F84 Room 8F84
W $8F84,12,2
W $8F88,2,2 Room to Left
W $8F8A,2,2
W $8F8C,2,2 Room Up
W $8F8E,2,2 Room Down
B $8F90 #HTML[<img src="images/rooms/8F84.png" />]
b $8FBD Room 8FBD
W $8FBD,12,2
W $8FC1,2,2 Room to Left
W $8FC3,2,2 Room to Right
W $8FC5,2,2
W $8FC7,2,2 Room Down
B $8FC9 #HTML[<img src="images/rooms/8FBD.png" />]
b $9005 Room 9005
W $9005,12,2
W $9009,2,2 Room to Left
W $900B,2,2 Room to Right
W $900D,2,2 Room Up
W $900F,2,2
B $9011 #HTML[<img src="images/rooms/9005.png" />]
b $9053 Room 9053
W $9053,12,2
W $9057,2,2 Room to Left
W $9059,2,2 Room to Right
W $905B,2,2 Room Up
W $905D,2,2 Room Down
B $905F #HTML[<img src="images/rooms/9053.png" />]
b $909F Room 909F
W $909F,12,2
W $90A3,2,2 Room to Left
W $90A5,2,2 Room to Right
W $90A7,4,2
B $90AB #HTML[<img src="images/rooms/909F.png" />]
b $90DB Room 90DB
W $90DB,12,2
W $90DF,2,2 Room to Left
W $90E1,2,2 Room to Right
W $90E3,2,2 Room Up
W $90E5,2,2
B $90E7 #HTML[<img src="images/rooms/90DB.png" />]
b $913F Room 913F
W $913F,12,2
W $9145,2,2 Room to Right
W $9147,2,2
W $9149,2,2 Room Down
B $914B #HTML[<img src="images/rooms/913F.png" />]
b $91BA Room 91BA
W $91BA,12,2
W $91BE,2,2 Room to Left
W $91C0,2,2
W $91C2,2,2 Room Up
W $91C4,2,2 Room Down
B $91C6 #HTML[<img src="images/rooms/91BA.png" />]
b $920A Room 920A
W $920A,12,2
W $920E,2,2 Room to Left
W $9210,2,2 Room to Right
W $9212,4,2
B $9216 #HTML[<img src="images/rooms/920A.png" />]
b $924E Room 924E
W $924E,12,2
W $9252,2,2 Room to Left
W $9254,2,2
W $9256,2,2 Room Up
W $9258,2,2
B $925A #HTML[<img src="images/rooms/924E.png" />]
b $92A7 Room 92A7
W $92A7,12,2
W $92AD,2,2 Room to Right
W $92AF,4,2
B $92B3 #HTML[<img src="images/rooms/92A7.png" />]
b $92EF Room 92EF
W $92EF,12,2
W $92F5,2,2 Room to Right
W $92F7,4,2
B $92FB #HTML[<img src="images/rooms/92EF.png" />]
b $9376 Room 9376
W $9376,12,2
W $937A,2,2 Room to Left
W $937C,2,2
W $937E,2,2 Room Up
B $9382 #HTML[<img src="images/rooms/9376.png" />]
b $93DF Room 93DF
W $93DF,12,2
W $93E3,2,2 Room to Left
W $93E5,2,2 Room to Right
W $93E7,2,2 Room Up
W $93E9,2,2
B $93EB #HTML[<img src="images/rooms/93DF.png" />]
b $9431 Room 9431
W $9431,12,2
W $9439,2,2 Room Up
W $943B,2,2 Room Down
B $943D #HTML[<img src="images/rooms/9431.png" />]
b $9451 Room 9451
W $9451,12,2
W $945B,2,2 Room Down
B $945D #HTML[<img src="images/rooms/9451.png" />]
b $947C Room 947C
W $947C,12,2
W $9480,2,2 Room to Left
W $9482,2,2 Room to Right
W $9484,4,2
B $9488 #HTML[<img src="images/rooms/947C.png" />]
b $94AB Room 94AB
W $94AB,12,2
W $94AF,2,2 Room to Left
W $94B1,2,2 Room to Right
W $94B3,4,2
B $94B7 #HTML[<img src="images/rooms/94AB.png" />]
b $94CF Room 94CF
W $94CF,12,2
W $94D3,2,2 Room to Left
W $94D5,2,2 Room to Right
W $94D7,4,2
B $94DB #HTML[<img src="images/rooms/94CF.png" />]
b $9552 Room 9552
W $9552,12,2
W $9556,2,2 Room to Left
W $9558,2,2 Room to Right
W $955A,4,2
B $955E #HTML[<img src="images/rooms/9552.png" />]
b $95D6 Room 95D6
W $95D6,12,2
W $95DA,2,2 Room to Left
W $95DC,2,2 Room to Right
W $95DE,4,2
B $95E2 #HTML[<img src="images/rooms/95D6.png" />]
b $95F8 Room 95F8
W $95F8,12,2
W $95FE,2,2 Room to Right
W $9600,2,2
W $9602,2,2 Room Down
B $9604 #HTML[<img src="images/rooms/95F8.png" />]
b $9634 Room 9634
W $9634,12,2
W $963A,2,2 Room to Right
W $963C,2,2 Room Up
W $963E,2,2 Room Down
B $9640 #HTML[<img src="images/rooms/9634.png" />]
b $968A Room 968A
W $968A,12,2
W $968E,2,2 Room to Left
W $9690,2,2 Room to Right
W $9692,2,2
W $9694,2,2 Room Down
B $9696 #HTML[<img src="images/rooms/968A.png" />]
b $96CC Room 96CC
W $96CC,12,2
W $96D0,2,2 Room to Left
W $96D2,4,2
W $96D6,2,2 Room Down
B $96D8 #HTML[<img src="images/rooms/96CC.png" />]
b $96F3 Room 96F3
W $96F3,12,2
W $96F7,2,2 Room to Left
W $96F9,4,2
W $96FD,2,2 Room Down
B $96FF #HTML[<img src="images/rooms/96F3.png" />]
b $9715 Room 9715
W $9715,12,2
W $971B,2,2 Room to Right
W $971D,2,2 Room Up
W $971F,2,2 Room Down
B $9721 #HTML[<img src="images/rooms/9715.png" />]
b $9739 Room 9739
W $9739,12,2
W $973D,2,2 Room to Left
W $973F,2,2 Room to Right
W $9741,2,2 Room Up
W $9743,2,2 Room Down
B $9745 #HTML[<img src="images/rooms/9739.png" />]
b $976E Room 976E
W $976E,12,2
W $9772,2,2 Room to Left
W $9774,6,2
B $977A #HTML[<img src="images/rooms/976E.png" />]
b $97A6 Room 97A6
W $97A6,12,2
W $97AA,2,2 Room to Left
W $97AC,2,2 Room to Right
W $97AE,2,2 Room Up
W $97B0,2,2
B $97B2 #HTML[<img src="images/rooms/97A6.png" />]
b $97F8 Room 97F8
W $97F8,12,2
W $97FC,2,2 Room to Left
W $97FE,4,2
W $9802,2,2 Room Down
B $9804 #HTML[<img src="images/rooms/97F8.png" />]
b $982B Room 982B
W $982B,12,2
W $982F,2,2 Room to Left
W $9831,2,2
W $9833,2,2 Room Up
W $9835,2,2
B $9837 #HTML[<img src="images/rooms/982B.png" />]
b $9876 Room 9876
W $9876,12,2
W $987A,2,2 Room to Left
W $987C,2,2 Room to Right
W $987E,4,2
B $9882 #HTML[<img src="images/rooms/9876.png" />]
b $98C0 Room 98C0 (think door)
W $98C0,12,2
W $98C4,2,2 Room to Left
W $98C6,2,2 Room to Right
W $98C8,4,2
B $98CC #HTML[<img src="images/rooms/98C0.png" />]
b $990D Room 990D
W $990D,12,2
W $9915,2,2 Room Up
W $9917,2,2
B $9919 #HTML[<img src="images/rooms/990D.png" />]
b $99A6 Room 99A6
W $99A6,12,2
W $99AC,2,2 Room to Right
W $99AE,4,2
B $99B2 #HTML[<img src="images/rooms/99A6.png" />]
b $9A1E Room 9A1E
W $9A1E,12,2
W $9A24,2,2 Room to Right
W $9A26,2,2 Room Up
W $9A28,2,2
B $9A2A #HTML[<img src="images/rooms/9A1E.png" />]
b $9A5A Room 9A5A
W $9A5A,12,2
W $9A60,2,2 Room to Right
W $9A62,2,2 Room Up
W $9A64,2,2 Room Down
B $9A66 #HTML[<img src="images/rooms/9A5A.png" />]
b $9A9A Room 9A9A
W $9A9A,12,2
W $9A9E,2,2 Room to Left
W $9AA0,2,2 Room to Right
W $9AA2,2,2 Room Up
W $9AA4,2,2
B $9AA6 #HTML[<img src="images/rooms/9A9A.png" />]
b $9ADC Room 9ADC
W $9ADC,12,2
W $9AE4,2,2 Room Up
W $9AE6,2,2 Room Down
B $9AE8 #HTML[<img src="images/rooms/9ADC.png" />]
b $9B19 Room 9B19
W $9B19,12,2
W $9B21,2,2 Room Up
W $9B23,2,2 Room Down
B $9B25 #HTML[<img src="images/rooms/9B19.png" />]
b $9B51 Room 9B51
W $9B51,12,2
W $9B59,2,2 Room Up
W $9B5B,2,2 Room Down
B $9B5D #HTML[<img src="images/rooms/9B51.png" />]
b $9B9D Room 9B9D
W $9B9D,12,2
W $9BA5,2,2 Room Up
W $9BA7,2,2 Room Down
B $9BA9 #HTML[<img src="images/rooms/9B9D.png" />]
b $9BE7 Room 9BE7
W $9BE7,12,2
W $9BED,2,2 Room to Right
W $9BEF,2,2 Room Up
W $9BF1,2,2 Room Down
B $9BF3 #HTML[<img src="images/rooms/9BE7.png" />]
b $9C40
B $9C40 Ninja Y within the room, 0 at the top
B $9C41 Ninja X within the room
W $9C42 ??
c $9C44
C $9C47,3 get Ninja Y
C $9C65,3 get Ninja X
C $9C71,3 get Ninja X
b $9C9C
c $9CA8
C $9D37,3 Tile screen 3 start address
c $9D5C
C $9D61,3 Tile screen 1 start address
c $9D75
c $9D8B
c $9DCD
c $9DD9
c $9DDA
b $9DEF
c $9DF1
b $9DF5 Room 9DF5
W $9DF5,12,2
W $9DF9,2,2 Room to Left
W $9DFB,2,2
W $9DFD,2,2 Room Up
W $9DFF,2,2
B $9E01 #HTML[<img src="images/rooms/9DF5.png" />]
b $9E22 Room 9E22
W $9E22,12,2
W $9E2C,2,2 Room Down
B $9E2E #HTML[<img src="images/rooms/9E22.png" />]
b $9E73 Room 9E73
W $9E73,12,2
W $9E77,2,2 Room to Left
W $9E79,4,2
W $9E7D,2,2 Room Down
B $9E7F #HTML[<img src="images/rooms/9E73.png" />]
b $9EB8 Room 9EB8
W $9EB8,12,2
W $9EBC,2,2 Room to Left
W $9EBE,2,2 Room to Right
W $9EC0,4,2
B $9EC4 #HTML[<img src="images/rooms/9EB8.png" />]
b $9ED9 Room 9ED9
W $9ED9,12,2
W $9EDD,2,2 Room to Left
W $9EDF,2,2 Room to Right
W $9EE1,4,2
B $9EE5 #HTML[<img src="images/rooms/9ED9.png" />]
b $9EFA Room 9EFA
W $9EFA,12,2
W $9F00,2,2 Room to Right
W $9F04,2,2 Room Down
B $9F06 #HTML[<img src="images/rooms/9EFA.png" />]
b $9F3A Room 9F3A
W $9F3A,12,2
W $9F40,2,2 Room to Right
W $9F42,2,2 Room Up
W $9F44,2,2 Room Down
B $9F46 #HTML[<img src="images/rooms/9F3A.png" />]
b $9F7E Room 9F7E
W $9F7E,12,2
W $9F82,2,2 Room to Left
W $9F84,2,2 Room to Right
W $9F86,4,2
B $9F8A #HTML[<img src="images/rooms/9F7E.png" />]
b $A022 Room A022
W $A022,12,2
W $A026,2,2 Room to Left
W $A028,6,2
B $A02E #HTML[<img src="images/rooms/A022.png" />]
c $A0DF
c $A0E8
c $A0ED
b $A0F2
c $A0F7
c $A0FC
c $A101
c $A106
c $A10B
c $A110
c $A115
c $A11A
c $A11F
c $A124
c $A129
c $A12E
c $A133
c $A138
b $A13D
c $A142
b $A14A
c $A14F
b $A154
c $A15F
c $A16A
c $A16F
c $A174
c $A179
b $A17E
c $A183
c $A188
c $A18D
c $A192
c $A197
c $A19C
c $A1A1
b $A1A6
c $A1AF
c $A1B5
c $A1C0
c $A1CB
c $A1D6
b $A1E1
B $A1E1,6,6
B $A1E7,6,6
B $A1ED,6,6
B $A1F3,6,6
B $A1F9,6,6
B $A1FF,6,6
B $A205,6,6
B $A20B,6,6
B $A211,6,6
B $A217,6,6
B $A21D,6,6
B $A223,6,6
B $A229,6,6
B $A22F,6,6
B $A235,6,6
B $A23B,6,6
B $A241,6,6
B $A247,6,6
B $A24D,6,6
B $A253,6,6
B $A259,6,6
B $A25F,6,6
B $A265,6,6
B $A26B,6,6
b $A271
B $A271,10,10
B $A27B,10,10
B $A285,10,10
B $A28F,10,10
B $A299,10,10
B $A2A3,10,10
B $A2AD,10,10
B $A2B7,10,10
B $A2C1,10,10
B $A2CB,10,10
B $A2D5,10,10
B $A2DF,10,10
B $A2E9,10,10
B $A2F3,10,10
B $A2FD,10,10
B $A307,10,10
B $A311,10,10
B $A31B,10,10
B $A325,10,10
c $A353
c $A35C
c $A361
b $A366
c $A36B
c $A370
c $A375
b $A37A
c $A37F
c $A384
c $A389
c $A38E
b $A393
c $A3B5
C $A3B5,3 get Ninja Y
c $A3D1
C $A3D1,3 get Ninja Y
c $A3EE
C $A3EE,3 get Ninja Y
c $A418
C $A418,3 get Ninja Y
C $A539,3 Ninja Y address
C $A552,3 Ninja X address
C $A614,3 Ninja X address
C $A728,3 Tile screen 4 start address
c $A434
C $A4A3,3 Tile screen 0 start address
C $A4AC,3 Tile screen 5 start address
C $A4B4,3 Tile screen 1 start address
C $A4C0,3 Tile screen 2 start address
b $A747
t $A752
b $A759
c $A75B
C $A75F,3 Tile screen 1 start address
c $A775
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
T $AD52,5 Pay value text
T $AD57,2 Indicator time value
b $AD65 Game screen frames/indicators RLE encoded sequence
B $AD65,,16
b $AE02 Tiles for game screen frames/indicators, 9 bytes each
B $AE02,,9
c $AED1 Print string with standard font
C $AED6,3 * 8
c $AEF0
C $AF41,3 Print string
C $AF49,3 Print string
C $AF51,3 Print string
C $AF59,3 Print string
C $AF61,3 Print string
C $AF6E,3 Print string
c $AF9C
C $AFAD,3 Print string
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
C $B16D,2 30 column
C $B170,1 Check byte in Title screen 5
C $B171,3 zero => Skip this tile rendering
C $B178,1 get byte from Tile screen 0
C $B17F,2 byte <> $FF =>
C $B18F,1 * 9
C $B190,3 Tiles start address
C $B193,1 now HL = tile address
C $B194,3 Tile buffer address
C $B1DA,1 * 8
C $B1E8,3 Mirror byte if needed
C $B1EF,3 Mirror byte if needed
C $B20E,1 * 8
C $B21C,3 Mirror byte if needed
C $B223,3 Mirror byte if needed
C $B230,3 Get address in Tile screen 4
C $B23E,1 * 8
C $B24F,3 Mirror byte if needed
C $B256,3 Mirror byte if needed
C $B263,3 Get address in Tile screen 5
C $B278,1 * 8
C $B2A2,3 Get address in screen attributes
C $B2B4,1 Increase address in screen attributes
C $B2B8,7 Increase address in Tile screen 5
C $B2BF,4 Increase address in Tile screen 4
C $B2C7,1 Decrease column counter
C $B2C8,3 Continue loop by columns
C $B2DA,8 Increase address in screen attributes by 2 - next line
C $B2E3,1 Decrease line counter
C $B2E4,3 Continue loop by lines
c $B2E8 Mirror byte if needed
C $B2EA,3 Get mirror flag
C $B2F1,1 No need to mirror => return
C $B2F2,4 Mirror table half address
b $B2FD
c $B2FE
c $B30F
c $B320
c $B32A
c $B334
c $B33E
c $B348
c $B368
c $B371
c $B38F Room token #0: ?? 3x3 tiles #R$7C21; params: 2 bytes (address)
C $B3AC,3 => #R$B702 Proceed to the next room token
s $B3AF
c $B3B0
s $B401
c $B40A
c $B41F
c $B422
c $B425
c $B42E
b $B437
c $B446
c $B44C
c $B452
c $B458
c $B461
C $B465,3 Tile screen 1 start address
c $B47A
c $B483
c $B489
C $B4D0,3 get Ninja X
b $B4DD
c $B4DE
R $B4DE B ??
C $B4EF,3 Pay value text address
C $B4F4,3 Screen address
C $B4F7,3 => Print string
c $B4FA
b $B513 Room B513: Initial Room
W $B513,12,2
W $B519,2,2 Room to Right
W $B51B,4,2
B $B51F #HTML[<img src="images/rooms/B513.png" />]
c $B532
C $B539,3 Ninja X address
C $B577,3 Ninja X address
s $B595
c $B596
b $B59B
c $B59E
b $B5A7
b $B5A8
w $B5B0 Table of addresses for NEAR/HELD items
b $B5C4
c $B5C7
C $B5F9,3 Draw game screen frames and indicator text
C $B643,3 Initial room address
C $B646,3 set Current Room address
C $B657,3 set Ninja X
C $B65C,3 set Ninja Y
c $B66A Current Room changed, entering the new Room
C $B6BF,3 Tile screen 0 start address
C $B6C7,3 510 - 1
C $B6CA,3 Tile screen 0 start address + 1
C $B6CF,3 Tile screen 4 start address
C $B6DC,3 get Current Room address
C $B6ED,1 now HL = room sequence start address
C $B6EE,1 get next token
C $B6EF,2 End of sequence?
C $B6F1,3 !!MUT-ARG!! yes =>
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
c $B724
C $B724,3 Tile screen 1 start address
C $B727,2 Filler
C $B729,3 510 - 1
C $B72C,3 Tile screen 1 start address + 1
C $B731,3 Tile screen 2 start address
C $B734,2 Filler
C $B736,3 510 - 1
C $B739,3 Tile screen 2 start address + 1
C $B73E,3 Tile screen 3 start address
C $B741,2 Filler
C $B743,3 510 - 1
C $B746,3 Tile screen 3 start address + 1
C $B74B,3 Draw tile map on the screen
C $B754,3 get Current Room address, low byte
C $B75B,3 get Current Room address, high byte
C $B796,1 Decrease Time lower digit
C $B79F,1 Decrease Time higher digit
C $B7A1,3 time is out =>
C $B7A7,3 Indicator Time value address
C $B7AC,3 Print string
C $B7C7,3 Print string
C $B7CA,3 "99"
C $B7ED,3 Tile screen 1 start address
C $B7F2,3 510 - 1
C $B7F5,3 Tile screen 1 start address + 1
C $B7FD,3 Tile screen 2 start address
C $B802,3 510 - 1
C $B805,3 Tile screen 2 start address + 1
C $B808,2 Fill the Tile screen 2
c $B83C
b $B84A
c $B851
c $B86C
c $B889
C $B8A4,3 Draw NEAR/HELD item
C $B8C5,3 Draw NEAR/HELD item
C $B8CD,3 !!MUT-ARG!!
c $B8D0
C $B8D3,3 Tile screen 4 start address
C $B8D8,3 510 - 1
C $B907,3 Tile screen 2 start address
C $B922,3 Tile screen 3 start address
C $B927,3 Tile screen 3 start address + 1
C $B92A,3 510 - 1
C $B92F,3 get Current Room address
c $B937
C $B9B5,3 Tile screen 0 start address
C $B9C1,3 Tile screen 3 start address
C $B9DB,3 Tile screen 4 start address
C $BA03,3 Tile screen 2 start address
C $BA41,3 Draw tile map on the screen
b $BAB2
t $BAC4
b $BAC7
C $BCAD,3 "SEPUKU" / "MISSION ABORTED"
c $BAD5
c $BBAE
C $BBB4,3 Tile screen 1 start address
c $BBBB
C $BBBE,3 Tile screen 1 start address
c $BBD4
c $BBDF
c $BC0D
c $BC55
t $BD2F
c $BD33
c $BD37
C $BD59,3 get Ninja X
C $BD71,3 get Ninja Y
c $BDAF
c $BDB2
c $BDDD
c $BE0D
c $BE5A
c $BE63
c $BE71 Time is out
C $BE78,3 "TIME OUT" / "MISSION TERMINATED"
C $BEAB,3 "SABOTEUR DEAD" / "MISSION FAILURE"
c $BEB3
C $BEB3,3 !!MUT-ARG!! two-line message address
C $BEBB,3 Print string
C $BEC3,3 Print string
t $BEEF
T $BEEF,15
T $BEFE,20
T $BF12,15
T $BF21,20
T $BF35,15
T $BF44,20
T $BF58,15
T $BF67,20
c $BF7B
c $BFBA
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
C $C042,3 Print string
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
c $C13D
b $C171
c $C1B6
C $C1B6,3 get Ninja X
C $C1BB,3 => Going to room at Right
C $C1CA,3 Ninja Y address
C $C203,3 Ninja Y address
C $C20A,3 => Going to room Down from current
C $C20D,3 Ninja X address
c $C22F
c $C24B
C $C24B,3 get Ninja X
C $C25F,3 Ninja Y address
C $C298,3 Ninja Y address
C $C29F,3 => Going to room Down from current
C $C2A2,3 Ninja X address
c $C2FA Going to room at Right
C $C2FB,3 set Ninja X = 0
C $C308,3 get Current Room address
C $C313,3 set Current Room address
C $C316,3 => Current Room changed
c $C319 Going to room at Left
C $C31B,3 set Ninja X = 24
C $C328,3 get Current Room address
C $C333,3 set Current Room address
C $C336,3 => Current Room changed
c $C339
c $C392
c $C3BB
C $C3BB,3 Ninja X address
c $C3CF
C $C3CF,3 Ninja X address
c $C3D9
C $C447,3 get Ninja Y
C $C45D,3 Ninja Y address
C $C47B,3 get Ninja Y
C $C480,3 => Going to room Down from current
C $C498,3 Ninja Y address
t $C4A4
c $C4A7
c $C4DE
c $C4E8
c $C4F6
c $C50D
C $C512,3 Ninja X address
C $C51A,3 => Going to room at Left
C $C546,3 Ninja Y address
c $C57B
C $C58A,3 Tile screen 0 start address
c $C5A0
c $C5A3
C $C5AA,3 Tile screen 0 start address
c $C5C6
C $C5D4,3 Ninja Y address
C $C5DB,2 => Going to room Down from current
c $C604 Going to room Down from current
C $C605,3 set Ninja Y = 0
C $C60B,3 -300
C $C612,3 get Current Room address
C $C618,1 now HL = room address + 10
C $C61D,3 set Current Room address
C $C620,3 => Current Room changed
c $C623 Going to room Up from current
C $C625,3 set Ninja Y = 10
C $C62B,3 +300
C $C632,3 get Current Room address
C $C638,1 now HL = room address + 8
C $C63D,3 get Current Room address
C $C640,3 => Current Room changed
c $C643
c $C64C
b $C65A
b $C66B
c $C671
c $C681
c $C6A5
C $C6A5,3 get Ninja X
C $C6B6,3 get Ninja X
C $C6CE,3 set Ninja X
c $C6E2
c $C70C
b $C721 Font
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
B $C8F9,8,8 '['
B $C901,8,8 '\'
B $C909,8,8 ']'
B $C911,8,8 '^'
B $C919,8,8 '_'
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
b $D256
t $D295
B $D298
T $D29C
B $D29F
T $D2A3
B $D2A6
T $D2AA
B $D2AD
T $D2B1
B $D2B4
T $D2B8
B $D2BB
T $D2BF
B $D2C2
T $D2C6
B $D2C9
T $D2CD
B $D2D0
T $D2D4
B $D2D7
T $D2DB
B $D2DE
T $D2E2
B $D2E5
T $D2E9
B $D2EC
T $D2F0
B $D2F3
T $D2F7
B $D2FA
T $D2FE
B $D301
T $D305
B $D308
T $D30C
B $D30F
T $D313
B $D316
t $D31A
b $D31D
t $D321
b $D324
t $D328
b $D32B
t $D32F
b $D332
t $D336
b $D339
t $D33D
b $D340
b $D34D Objects ??, 35 records, 5 bytes each
W $D34D,4,4
B $D351,1,1
W $D352,4,4
B $D356,1,1
W $D357,4,4
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
W $D3D9,4,4
B $D3DD,1,1
W $D3DE,4,4 #30
B $D3E2,1,1
W $D3E3,4,4
B $D3E7,1,1
W $D3E8,4,4
B $D3EC,1,1
W $D3ED,4,4
B $D3F1,1,1
W $D3F2,4,4
B $D3F6,1,1
W $D3F7,4,4 #35
B $D3FB,1,1
b $D3FC
t $D41C
b $D41F
t $D440
b $D443
t $D446
b $D449
t $D44C
b $D44F
t $D452
b $D455
t $D457
b $D45A
t $D46A
b $D46D
t $D470
b $D473
t $D476
b $D479
t $D47B
b $D47F
t $D4E6
b $D4EC
t $D4ED
b $D4F1
t $D512
b $D515
t $D518
b $D51B
t $D572
b $D575
t $D578
b $D57B
t $D57E
b $D581
c $DE68
C $DE6D,3 get Current Room address
b $DE84
c $DEC1
C $DECD,3 Print string
t $DEE6
t $DEF8 Menu messages
T $DEF8
T $DF03
T $DF0E
T $DF17
T $DF27
c $DF37
c $DF60 Main menu
C $DF63,3 Menu messages address
C $DF6B,3 Print string
C $DF73,3 Print string
C $DF7B,3 Print string
C $DF83,3 Print string
C $DF8B,3 Print string
C $DF91,3 Highlight Menu item
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
C $DFC9,3 => Start Mission
c $DFD4
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
t $E05B Redefine keys messages
T $E068
T $E076
T $E084
T $E088
T $E08A
T $E08E
T $E092
c $E097 Redefine Keys
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
C $E145,3 Print string
b $E17C
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
C $E2B5,3 Print string "ENTER SKILL LEVEL"
C $E2BD,3 Print string "1 TO 9"
C $E2E7,3 Print string
C $E302,3 Print string "YOUR MISSION"
C $E30A,3 Print string "WILL BE"
C $E315,4 * 16
C $E319,3 Levels data base address
C $E322,3 Print string - level description
C $E343,4 set initial Time value
b $E388
T $E388,4
b $E38C Level 1 "EXTREMELY EASY"
B $E38C
T $E38F
B $E393
T $E398,3
B $E39B
b $E3A0 Level 2 "VERY EASY"
B $E3A0
T $E3A3
B $E3A7
T $E3AC,3
B $E3AF
b $E3B4 Level 3 "EASY"
B $E3B4
T $E3B7
B $E3BB
T $E3C0,3
B $E3C3
b $E3C8 Level 4 "SLIGHTLY EASY"
T $E3CB
B $E3CF
T $E3D4,3
B $E3D7
b $E3DC Level 5 "MODERATE"
T $E3DF
B $E3E3
T $E3E8,3
B $E3EB
b $E3F0 Level 6 "SLIGHTLY  HARD"
T $E3F3
B $E3F7
T $E3FC,3
B $E3FF
b $E404 Level 7 "HARD"
T $E407
B $E40B
T $E410,3
B $E413
b $E418 Level 8 "VERY HARD"
T $E41B
B $E41F
T $E424,3
B $E427
b $E42C Level 9 "EXTREMELY HARD"
T $E42F
B $E433
T $E438,3
B $E43B
c $E440
b $E494
b $E700 Tiles with mask, 16 bytes each
b $F700 Tiles, 9 bytes each
B $F700,,9
