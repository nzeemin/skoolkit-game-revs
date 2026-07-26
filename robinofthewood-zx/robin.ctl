@ $5B00 start
@ $5B00 org
w $5B00 Table for block addresses
W $5B00,,8
b $5BA8 Block $00
N $5BA8 Block header byte, decoded by #R$C0D1: bit 7 = natural-mirror flag (XORed with the placing token's own mirror bit and the room's world-map bit 7 to decide whether to mirror at draw time); bit 6 = flat-attribute flag (1 = a single attribute byte fills the whole block instead of one row); bits 0-4 = pixel row count / 8 (i.e. pixel rows = (header AND $1F) x 8, each row 4 bytes/32 pixels wide); bits 0-2 (reused) = attribute row count (0-7, each row 4 bytes wide, appended immediately after the pixel data - or a single byte if the flat-attribute flag is set). Bit 5 is unused. Verified against block $00 ($04: 32 pixel rows = 128 bytes, 4 attribute rows = 16 bytes, matching the gap before block $01 exactly) and blocks $01/$02/$0A.
B $5BA8,1,1
B $5BA9,128,8 #HTML[<img src="images/blocks/block00.png" />]
b $5C39 Block $01
B $5C39,1,1
B $5C3A,64,8 #HTML[<img src="images/blocks/block01.png" />]
b $5C82 Block $02
B $5C82,1,1
B $5C83,32,8 #HTML[<img src="images/blocks/block02.png" />]
b $5CA4 Block $03
B $5CA4,1,1
B $5CA5,32,8 #HTML[<img src="images/blocks/block03.png" />]
b $5CC9 Block $04
B $5CC9,1,1
B $5CCA,64,8 #HTML[<img src="images/blocks/block04.png" />]
b $5D12 Block $05
B $5D12,1,1
B $5D13,96,8 #HTML[<img src="images/blocks/block05.png" />]
b $5D7F Block $06
B $5D7F,1,1
B $5D80,128,8 #HTML[<img src="images/blocks/block06.png" />]
b $5E10 Block $07
B $5E10,1,1
B $5E11,96,8 #HTML[<img src="images/blocks/block07.png" />]
b $5E7D Block $08
B $5E7D,1,1
B $5E7E,128,8 #HTML[<img src="images/blocks/block08.png" />]
b $5F0E Block $09
B $5F0E,1,1
B $5F0F,64,8 #HTML[<img src="images/blocks/block09.png" />]
b $5F57 Block $0A
B $5F57,1,1
B $5F58,32,8 #HTML[<img src="images/blocks/block0A.png" />]
b $5F79 Block $0B
B $5F79,1,1
B $5F7A,32,8 #HTML[<img src="images/blocks/block0B.png" />]
b $5F9B Block $0C
B $5F9B,1,1
B $5F9C,64,8 #HTML[<img src="images/blocks/block0C.png" />]
b $5FE4 Block $0D
B $5FE4,1,1
B $5FE5,96,8 #HTML[<img src="images/blocks/block0D.png" />]
b $6051 Block $0E
B $6051,1,1
B $6052,128,8 #HTML[<img src="images/blocks/block0E.png" />]
b $60E2 Block $0F
B $60E2,1,1
B $60E3,96,8 #HTML[<img src="images/blocks/block0F.png" />]
b $614F Block $10
B $614F,1,1
B $6150,96,8 #HTML[<img src="images/blocks/block10.png" />]
b $61B1 Block $11
B $61B1,1,1
B $61B2,64,8 #HTML[<img src="images/blocks/block11.png" />]
b $61F3 Block $12
B $61F3,1,1
B $61F4,32,8 #HTML[<img src="images/blocks/block12.png" />]
b $6215 Block $13
B $6215,1,1
B $6216,32,8 #HTML[<img src="images/blocks/block13.png" />]
b $6237 Block $14
B $6237,1,1
B $6238,128,8 #HTML[<img src="images/blocks/block14.png" />]
b $62C8 Block $15
B $62C8,1,1
B $62C9,96,8 #HTML[<img src="images/blocks/block15.png" />]
b $6339 Block $16
B $6339,1,1
B $633A,64,8 #HTML[<img src="images/blocks/block16.png" />]
b $637B Block $17
B $637B,1,1
B $637C,128,8 #HTML[<img src="images/blocks/block17.png" />]
b $63FD Block $18
B $63FD,1,1
B $63FE,128,8 #HTML[<img src="images/blocks/block18.png" />]
b $647F Block $19
B $647F,1,1
B $6480,96,8 #HTML[<img src="images/blocks/block19.png" />]
b $64EC Block $1A
B $64EC,1,1
B $64ED,96,8 #HTML[<img src="images/blocks/block1A.png" />]
b $6559 Block $1B
B $6559,1,1
B $655A,64,8 #HTML[<img src="images/blocks/block1B.png" />]
b $659B Block $1C
B $659B,1,1
B $659C,128,8 #HTML[<img src="images/blocks/block1C.png" />]
b $662C Block $1D
B $662C,1,1
B $662D,128,8 #HTML[<img src="images/blocks/block1D.png" />]
b $66BD Block $1E
B $66BD,1,1
B $66BE,128,8 #HTML[<img src="images/blocks/block1E.png" />]
b $673F Block $1F
B $673F,1,1
B $6740,128,8 #HTML[<img src="images/blocks/block1F.png" />]
b $67C1 Block $20
B $67C1,1,1
B $67C2,128,8 #HTML[<img src="images/blocks/block20.png" />]
b $6852 Block $21
B $6852,1,1
B $6853,128,8 #HTML[<img src="images/blocks/block21.png" />]
b $68D4 Block $22
B $68D4,1,1
B $68D5,128,8 #HTML[<img src="images/blocks/block22.png" />]
b $6956 Block $23
B $6956,1,1
B $6957,128,8 #HTML[<img src="images/blocks/block23.png" />]
b $69D8 Block $24
B $69D8,1,1
B $69D9,128,8 #HTML[<img src="images/blocks/block24.png" />]
b $6A5A Block $25
B $6A5A,1,1
B $6A5B,128,8 #HTML[<img src="images/blocks/block25.png" />]
b $6ADC Block $26
B $6ADC,1,1
B $6ADD,128,8 #HTML[<img src="images/blocks/block26.png" />]
b $6B6D Block $27
B $6B6D,1,1
B $6B6E,128,8 #HTML[<img src="images/blocks/block27.png" />]
b $6BFE Block $28
B $6BFE,1,1
B $6BFF,32,8 #HTML[<img src="images/blocks/block28.png" />]
b $6C20 Block $29
B $6C20,1,1
B $6C21,32,8 #HTML[<img src="images/blocks/block29.png" />]
b $6C42 Block $2A
B $6C42,1,1
B $6C43,128,8 #HTML[<img src="images/blocks/block2A.png" />]
b $6CC4 Block $2B
B $6CC4,1,1
B $6CC5,96,8 #HTML[<img src="images/blocks/block2B.png" />]
b $6D26 Block $2C
B $6D26,1,1
B $6D27,64,8 #HTML[<img src="images/blocks/block2C.png" />]
b $6D68 Block $2D
B $6D68,1,1
B $6D69,64,8 #HTML[<img src="images/blocks/block2D.png" />]
b $6DAA Block $2E
B $6DAA,1,1
B $6DAB,32,8 #HTML[<img src="images/blocks/block2E.png" />]
b $6DCC Block $2F
B $6DCC,1,1
B $6DCD,32,8 #HTML[<img src="images/blocks/block2F.png" />]
b $6DEE Block $30
B $6DEE,1,1
B $6DEF,64,8 #HTML[<img src="images/blocks/block30.png" />]
b $6E37 Block $31
B $6E37,1,1
B $6E38,64,8 #HTML[<img src="images/blocks/block31.png" />]
b $6E80 Block $32
B $6E80,1,1
B $6E81,32,8 #HTML[<img src="images/blocks/block32.png" />]
b $6EA5 Block $33
B $6EA5,1,1
B $6EA6,32,8 #HTML[<img src="images/blocks/block33.png" />]
b $6ECA Block $34
B $6ECA,1,1
B $6ECB,64,8 #HTML[<img src="images/blocks/block34.png" />]
b $6F13 Block $35
B $6F13,1,1
B $6F14,64,8 #HTML[<img src="images/blocks/block35.png" />]
b $6F5C Block $36
B $6F5C,1,1
B $6F5D,64,8 #HTML[<img src="images/blocks/block36.png" />]
b $6FA5 Block $37
B $6FA5,1,1
B $6FA6,32,8 #HTML[<img src="images/blocks/block37.png" />]
b $6FCA Block $38
B $6FCA,1,1
B $6FCB,64,8 #HTML[<img src="images/blocks/block38.png" />]
b $7013 Block $39
B $7013,1,1
B $7014,128,8 #HTML[<img src="images/blocks/block39.png" />]
b $70A4 Block $3A
B $70A4,1,1
B $70A5,96,8 #HTML[<img src="images/blocks/block3A.png" />]
b $7106 Block $3B
B $7106,1,1
B $7107,96,8 #HTML[<img src="images/blocks/block3B.png" />]
b $7173 Block $3C
B $7173,1,1
B $7174,128,8 #HTML[<img src="images/blocks/block3C.png" />]
b $7204 Block $3D
B $7204,1,1
B $7205,64,8 #HTML[<img src="images/blocks/block3D.png" />]
b $724D Block $3E
B $724D,1,1
B $724E,32,8 #HTML[<img src="images/blocks/block3E.png" />]
b $726F Block $3F
B $726F,1,1
B $7270,64,8 #HTML[<img src="images/blocks/block3F.png" />]
b $72B1 Block $40
B $72B1,1,1
B $72B2,64,8 #HTML[<img src="images/blocks/block40.png" />]
b $72F3 Block $41
B $72F3,1,1
B $72F4,64,8 #HTML[<img src="images/blocks/block41.png" />]
b $733C Block $42
B $733C,1,1
B $733D,64,8 #HTML[<img src="images/blocks/block42.png" />]
b $7385 Block $43
B $7385,1,1
B $7386,96,8 #HTML[<img src="images/blocks/block43.png" />]
b $73F2 Block $44
B $73F2,1,1
B $73F3,64,8 #HTML[<img src="images/blocks/block44.png" />]
b $743B Block $45
B $743B,1,1
B $743C,64,8 #HTML[<img src="images/blocks/block45.png" />]
b $7484 Block $46
B $7484,1,1
B $7485,64,8 #HTML[<img src="images/blocks/block46.png" />]
b $74CD Block $47
B $74CD,1,1
B $74CE,64,8 #HTML[<img src="images/blocks/block47.png" />]
b $7516 Block $48
B $7516,1,1
B $7517,96,8 #HTML[<img src="images/blocks/block48.png" />]
b $759B Block $49
B $759B,1,1
B $759C,96,8 #HTML[<img src="images/blocks/block49.png" />]
b $7620 Block $4A
B $7620,1,1
B $7621,128,8 #HTML[<img src="images/blocks/block4A.png" />]
b $76D1 Block $4B
B $76D1,1,1
B $76D2,128,8 #HTML[<img src="images/blocks/block4B.png" />]
b $7782 Block $4C
B $7782,1,1
B $7783,128,8 #HTML[<img src="images/blocks/block4C.png" />]
b $7813 Block $4D
B $7813,1,1
B $7814,64,8 #HTML[<img src="images/blocks/block4D.png" />]
b $7855 Block $4E
B $7855,1,1
B $7856,32,8 #HTML[<img src="images/blocks/block4E.png" />]
b $7877 Block $4F
B $7877,1,1
B $7878,128,8 #HTML[<img src="images/blocks/block4F.png" />]
b $78F9 Block $50
B $78F9,1,1
B $78FA,64,8 #HTML[<img src="images/blocks/block50.png" />]
b $7942 Block $51
B $7942,1,1
B $7943,64,8 #HTML[<img src="images/blocks/block51.png" />]
b $798B Block $52
B $798B,1,1
B $798C,32,8 #HTML[<img src="images/blocks/block52.png" />]
b $79B0 Block $53
B $79B0,1,1
B $79B1,64,8 #HTML[<img src="images/blocks/block53.png" />]
b $79F9 World map
N $79F9 Every byte here is a room, describing a room type.
B $79F9,,16
b $7B39 Room type descriptors
N $7B39 Room type $00
B $7B39,1,1
B $7B3A,48,8 #HTML[<img src="images/roomtypes/roomt00.png" />]
N $7B6A Room type $01
B $7B6A,1,1
B $7B6B,54,8 #HTML[<img src="images/roomtypes/roomt01.png" />]
N $7BA1 Room type $02
B $7BA1,1,1
B $7BA2,68,8 #HTML[<img src="images/roomtypes/roomt02.png" />]
N $7BE6 Room type $03
B $7BE6,1,1
B $7BE7,54,8 #HTML[<img src="images/roomtypes/roomt03.png" />]
N $7C1D Room type $04
B $7C1D,1,1
B $7C1E,50,8 #HTML[<img src="images/roomtypes/roomt04.png" />]
N $7C50 Room type $05
B $7C50,1,1
B $7C51,58,8 #HTML[<img src="images/roomtypes/roomt05.png" />]
N $7C8B Room type $06
B $7C8B,1,1
B $7C8C,46,8 #HTML[<img src="images/roomtypes/roomt06.png" />]
N $7CBA Room type $07
B $7CBA,1,1
B $7CBB,44,8 #HTML[<img src="images/roomtypes/roomt07.png" />]
N $7CE7 Room type $08
B $7CE7,1,1
B $7CE8,52,8 #HTML[<img src="images/roomtypes/roomt08.png" />]
N $7D1C Room type $09
B $7D1C,1,1
B $7D1D,54,8 #HTML[<img src="images/roomtypes/roomt09.png" />]
N $7D53 Room type $0A
B $7D53,1,1
B $7D54,46,8 #HTML[<img src="images/roomtypes/roomt0A.png" />]
N $7D82 Room type $0B
B $7D82,1,1
B $7D83,60,8 #HTML[<img src="images/roomtypes/roomt0B.png" />]
N $7DBF Room type $0C
B $7DBF,1,1
B $7DC0,60,8 #HTML[<img src="images/roomtypes/roomt0C.png" />]
N $7DFC Room type $0D
B $7DFC,1,1
B $7DFD,58,8 #HTML[<img src="images/roomtypes/roomt0D.png" />]
N $7E37 Room type $0E
B $7E37,1,1
B $7E38,56,8 #HTML[<img src="images/roomtypes/roomt0E.png" />]
N $7E70 Room type $0F
B $7E70,1,1
B $7E71,54,8 #HTML[<img src="images/roomtypes/roomt0F.png" />]
N $7EA7 Room type $10
B $7EA7,1,1
B $7EA8,64,8 #HTML[<img src="images/roomtypes/roomt10.png" />]
N $7EE8 Room type $11
B $7EE8,1,1
B $7EE9,40,8 #HTML[<img src="images/roomtypes/roomt11.png" />]
N $7F11 Room type $12
B $7F11,1,1
B $7F12,36,8 #HTML[<img src="images/roomtypes/roomt12.png" />]
N $7F36 Room type $13
B $7F36,1,1
B $7F37,46,8 #HTML[<img src="images/roomtypes/roomt13.png" />]
N $7F65 Room type $14
B $7F65,1,1
B $7F66,34,8 #HTML[<img src="images/roomtypes/roomt14.png" />]
N $7F88 Room type $15
B $7F88,1,1
B $7F89,50,8 #HTML[<img src="images/roomtypes/roomt15.png" />]
N $7FBB Room type $16
B $7FBB,1,1
B $7FBC,52,8 #HTML[<img src="images/roomtypes/roomt16.png" />]
N $7FF0 Room type $17
B $7FF0,1,1
B $7FF1,48,8 #HTML[<img src="images/roomtypes/roomt17.png" />]
N $8021 Room type $18
B $8021,1,1
B $8022,42,8 #HTML[<img src="images/roomtypes/roomt18.png" />]
N $804C Room type $19
B $804C,1,1
B $804D,100,8 #HTML[<img src="images/roomtypes/roomt19.png" />]
N $80B1 Room type $1A
B $80B1,1,1
B $80B2,94,8 #HTML[<img src="images/roomtypes/roomt1A.png" />]
N $8110 Room type $1B
B $8110,1,1
B $8111,86,8 #HTML[<img src="images/roomtypes/roomt1B.png" />]
N $8167 Room type $1C
B $8167,1,1
B $8168,78,8 #HTML[<img src="images/roomtypes/roomt1C.png" />]
N $81B6 Room type $1D
B $81B6,1,1
B $81B7,80,8 #HTML[<img src="images/roomtypes/roomt1D.png" />]
N $8207 Room type $1E
B $8207,1,1 Nothing
N $8208 Room type $1F
B $8208,1,1
B $8209,92,8 #HTML[<img src="images/roomtypes/roomt1F.png" />]
N $8265 Room type $20
B $8265,1,1
B $8266,68,8 #HTML[<img src="images/roomtypes/roomt20.png" />]
N $82AA Room type $21
B $82AA,1,1
B $82AB,62,8 #HTML[<img src="images/roomtypes/roomt21.png" />]
N $82E9 Room type $22
B $82E9,1,1
B $82EA,82,8 #HTML[<img src="images/roomtypes/roomt22.png" />]
N $833C Room type $23
B $833C,1,1
B $833D,68,8 #HTML[<img src="images/roomtypes/roomt23.png" />]
N $8381 Room type $24
B $8381,1,1
B $8382,58,8 #HTML[<img src="images/roomtypes/roomt24.png" />]
N $83BC Room type $25
B $83BC,1,1
B $83BD,56,8 #HTML[<img src="images/roomtypes/roomt25.png" />]
N $83F5 Room type $26
B $83F5,1,1
B $83F6,60,8 #HTML[<img src="images/roomtypes/roomt26.png" />]
s $8432 Unused padding (223 zero bytes) between the room-type and additional-element tables
b $8511 Additional room elements, by room number
N $8511 Indexed by room number, not by room type: one entry per room $00..$FF, in order. Entry format matches the room type descriptors at #R$7B39 - a token count byte, followed by that many 2-byte tokens (coordinate byte + block number). A count of $00 means the room has no additional elements.
N $8511 Only rooms $0000..$00FF have entries here. #R$C072 loads the room number and returns early when its high byte is non-zero, so rooms $0100..$013D (256..317) get room type graphics only.
N $8511 Room $00
B $8511,1,1 Nothing
N $8512 Room $01
B $8512,1,1 Nothing
N $8513 Room $02
B $8513,1,1 Nothing
N $8514 Room $03
B $8514,1,1 Nothing
N $8515 Room $04
B $8515,1,1
B $8516,2,2 #HTML[<img src="images/roomadds/roomadd04.png" />]
N $8518 Room $05
B $8518,1,1 Nothing
N $8519 Room $06
B $8519,1,1
B $851A,2,2 #HTML[<img src="images/roomadds/roomadd06.png" />]
N $851C Room $07
B $851C,1,1 Nothing
N $851D Room $08
B $851D,1,1 Nothing
N $851E Room $09
B $851E,1,1 Nothing
N $851F Room $0A
B $851F,1,1 Nothing
N $8520 Room $0B
B $8520,1,1 Nothing
N $8521 Room $0C
B $8521,1,1 Nothing
N $8522 Room $0D
B $8522,1,1
B $8523,2,2 #HTML[<img src="images/roomadds/roomadd0D.png" />]
N $8525 Room $0E
B $8525,1,1
B $8526,6,6 #HTML[<img src="images/roomadds/roomadd0E.png" />]
N $852C Room $0F
B $852C,1,1 Nothing
N $852D Room $10
B $852D,1,1 Nothing
N $852E Room $11
B $852E,1,1 Nothing
N $852F Room $12
B $852F,1,1 Nothing
N $8530 Room $13
B $8530,1,1 Nothing
N $8531 Room $14
B $8531,1,1
B $8532,4,4 #HTML[<img src="images/roomadds/roomadd14.png" />]
N $8536 Room $15
B $8536,1,1 Nothing
N $8537 Room $16
B $8537,1,1 Nothing
N $8538 Room $17
B $8538,1,1 Nothing
N $8539 Room $18
B $8539,1,1 Nothing
N $853A Room $19
B $853A,1,1 Nothing
N $853B Room $1A
B $853B,1,1 Nothing
N $853C Room $1B
B $853C,1,1
B $853D,4,4 #HTML[<img src="images/roomadds/roomadd1B.png" />]
N $8541 Room $1C
B $8541,1,1
B $8542,4,4 #HTML[<img src="images/roomadds/roomadd1C.png" />]
N $8546 Room $1D
B $8546,1,1 Nothing
N $8547 Room $1E
B $8547,1,1 Nothing
N $8548 Room $1F
B $8548,1,1 Nothing
N $8549 Room $20
B $8549,1,1 Nothing
N $854A Room $21
B $854A,1,1
B $854B,2,2 #HTML[<img src="images/roomadds/roomadd21.png" />]
N $854D Room $22
B $854D,1,1 Nothing
N $854E Room $23
B $854E,1,1
B $854F,4,4 #HTML[<img src="images/roomadds/roomadd23.png" />]
N $8553 Room $24
B $8553,1,1 Nothing
N $8554 Room $25
B $8554,1,1
B $8555,4,4 #HTML[<img src="images/roomadds/roomadd25.png" />]
N $8559 Room $26
B $8559,1,1 Nothing
N $855A Room $27
B $855A,1,1 Nothing
N $855B Room $28
B $855B,1,1
B $855C,6,6 #HTML[<img src="images/roomadds/roomadd28.png" />]
N $8562 Room $29
B $8562,1,1
B $8563,4,4 #HTML[<img src="images/roomadds/roomadd29.png" />]
N $8567 Room $2A
B $8567,1,1 Nothing
N $8568 Room $2B
B $8568,1,1 Nothing
N $8569 Room $2C
B $8569,1,1 Nothing
N $856A Room $2D
B $856A,1,1 Nothing
N $856B Room $2E
B $856B,1,1
B $856C,2,2 #HTML[<img src="images/roomadds/roomadd2E.png" />]
N $856E Room $2F
B $856E,1,1 Nothing
N $856F Room $30
B $856F,1,1 Nothing
N $8570 Room $31
B $8570,1,1 Nothing
N $8571 Room $32
B $8571,1,1 Nothing
N $8572 Room $33
B $8572,1,1 Nothing
N $8573 Room $34
B $8573,1,1 Nothing
N $8574 Room $35
B $8574,1,1
B $8575,4,4 #HTML[<img src="images/roomadds/roomadd35.png" />]
N $8579 Room $36
B $8579,1,1
B $857A,10,8 #HTML[<img src="images/roomadds/roomadd36.png" />]
N $8584 Room $37
B $8584,1,1
B $8585,4,4 #HTML[<img src="images/roomadds/roomadd37.png" />]
N $8589 Room $38
B $8589,1,1
B $858A,10,8 #HTML[<img src="images/roomadds/roomadd38.png" />]
N $8594 Room $39
B $8594,1,1
B $8595,4,4 #HTML[<img src="images/roomadds/roomadd39.png" />]
N $8599 Room $3A
B $8599,1,1 Nothing
N $859A Room $3B
B $859A,1,1
B $859B,6,6 #HTML[<img src="images/roomadds/roomadd3B.png" />]
N $85A1 Room $3C
B $85A1,1,1
B $85A2,18,8 #HTML[<img src="images/roomadds/roomadd3C.png" />]
N $85B4 Room $3D
B $85B4,1,1
B $85B5,34,8 #HTML[<img src="images/roomadds/roomadd3D.png" />]
N $85D7 Room $3E
B $85D7,1,1
B $85D8,6,6 #HTML[<img src="images/roomadds/roomadd3E.png" />]
N $85DE Room $3F
B $85DE,1,1
B $85DF,2,2 #HTML[<img src="images/roomadds/roomadd3F.png" />]
N $85E1 Room $40
B $85E1,1,1 Nothing
N $85E2 Room $41
B $85E2,1,1 Nothing
N $85E3 Room $42
B $85E3,1,1 Nothing
N $85E4 Room $43
B $85E4,1,1 Nothing
N $85E5 Room $44
B $85E5,1,1 Nothing
N $85E6 Room $45
B $85E6,1,1
B $85E7,4,4 #HTML[<img src="images/roomadds/roomadd45.png" />]
N $85EB Room $46
B $85EB,1,1
B $85EC,8,8 #HTML[<img src="images/roomadds/roomadd46.png" />]
N $85F4 Room $47
B $85F4,1,1
B $85F5,8,8 #HTML[<img src="images/roomadds/roomadd47.png" />]
N $85FD Room $48
B $85FD,1,1
B $85FE,6,6 #HTML[<img src="images/roomadds/roomadd48.png" />]
N $8604 Room $49
B $8604,1,1
B $8605,8,8 #HTML[<img src="images/roomadds/roomadd49.png" />]
N $860D Room $4A
B $860D,1,1
B $860E,20,8 #HTML[<img src="images/roomadds/roomadd4A.png" />]
N $8622 Room $4B
B $8622,1,1
B $8623,12,8 #HTML[<img src="images/roomadds/roomadd4B.png" />]
N $862F Room $4C
B $862F,1,1
B $8630,20,8 #HTML[<img src="images/roomadds/roomadd4C.png" />]
N $8644 Room $4D
B $8644,1,1
B $8645,30,8 #HTML[<img src="images/roomadds/roomadd4D.png" />]
N $8663 Room $4E
B $8663,1,1
B $8664,4,4 #HTML[<img src="images/roomadds/roomadd4E.png" />]
N $8668 Room $4F
B $8668,1,1 Nothing
N $8669 Room $50
B $8669,1,1 Nothing
N $866A Room $51
B $866A,1,1
B $866B,4,4 #HTML[<img src="images/roomadds/roomadd51.png" />]
N $866F Room $52
B $866F,1,1 Nothing
N $8670 Room $53
B $8670,1,1 Nothing
N $8671 Room $54
B $8671,1,1 Nothing
N $8672 Room $55
B $8672,1,1
B $8673,6,6 #HTML[<img src="images/roomadds/roomadd55.png" />]
N $8679 Room $56
B $8679,1,1
B $867A,16,8 #HTML[<img src="images/roomadds/roomadd56.png" />]
N $868A Room $57
B $868A,1,1
B $868B,6,6 #HTML[<img src="images/roomadds/roomadd57.png" />]
N $8691 Room $58
B $8691,1,1
B $8692,8,8 #HTML[<img src="images/roomadds/roomadd58.png" />]
N $869A Room $59
B $869A,1,1 Nothing
N $869B Room $5A
B $869B,1,1
B $869C,20,8 #HTML[<img src="images/roomadds/roomadd5A.png" />]
N $86B0 Room $5B
B $86B0,1,1
B $86B1,14,8 #HTML[<img src="images/roomadds/roomadd5B.png" />]
N $86BF Room $5C
B $86BF,1,1
B $86C0,26,8 #HTML[<img src="images/roomadds/roomadd5C.png" />]
N $86DA Room $5D
B $86DA,1,1
B $86DB,16,8 #HTML[<img src="images/roomadds/roomadd5D.png" />]
N $86EB Room $5E
B $86EB,1,1
B $86EC,4,4 #HTML[<img src="images/roomadds/roomadd5E.png" />]
N $86F0 Room $5F
B $86F0,1,1
B $86F1,2,2 #HTML[<img src="images/roomadds/roomadd5F.png" />]
N $86F3 Room $60
B $86F3,1,1
B $86F4,6,6 #HTML[<img src="images/roomadds/roomadd60.png" />]
N $86FA Room $61
B $86FA,1,1 Nothing
N $86FB Room $62
B $86FB,1,1 Nothing
N $86FC Room $63
B $86FC,1,1 Nothing
N $86FD Room $64
B $86FD,1,1
B $86FE,2,2 #HTML[<img src="images/roomadds/roomadd64.png" />]
N $8700 Room $65
B $8700,1,1
B $8701,14,8 #HTML[<img src="images/roomadds/roomadd65.png" />]
N $870F Room $66
B $870F,1,1
B $8710,4,4 #HTML[<img src="images/roomadds/roomadd66.png" />]
N $8714 Room $67
B $8714,1,1
B $8715,8,8 #HTML[<img src="images/roomadds/roomadd67.png" />]
N $871D Room $68
B $871D,1,1
B $871E,12,8 #HTML[<img src="images/roomadds/roomadd68.png" />]
N $872A Room $69
B $872A,1,1 Nothing
N $872B Room $6A
B $872B,1,1
B $872C,6,6 #HTML[<img src="images/roomadds/roomadd6A.png" />]
N $8732 Room $6B
B $8732,1,1
B $8733,14,8 #HTML[<img src="images/roomadds/roomadd6B.png" />]
N $8741 Room $6C
B $8741,1,1
B $8742,14,8 #HTML[<img src="images/roomadds/roomadd6C.png" />]
N $8750 Room $6D
B $8750,1,1
B $8751,8,8 #HTML[<img src="images/roomadds/roomadd6D.png" />]
N $8759 Room $6E
B $8759,1,1
B $875A,8,8 #HTML[<img src="images/roomadds/roomadd6E.png" />]
N $8762 Room $6F
B $8762,1,1
B $8763,8,8 #HTML[<img src="images/roomadds/roomadd6F.png" />]
N $876B Room $70
B $876B,1,1 Nothing
N $876C Room $71
B $876C,1,1 Nothing
N $876D Room $72
B $876D,1,1 Nothing
N $876E Room $73
B $876E,1,1
B $876F,8,8 #HTML[<img src="images/roomadds/roomadd73.png" />]
N $8777 Room $74
B $8777,1,1 Nothing
N $8778 Room $75
B $8778,1,1
B $8779,4,4 #HTML[<img src="images/roomadds/roomadd75.png" />]
N $877D Room $76
B $877D,1,1
B $877E,16,8 #HTML[<img src="images/roomadds/roomadd76.png" />]
N $878E Room $77
B $878E,1,1
B $878F,6,6 #HTML[<img src="images/roomadds/roomadd77.png" />]
N $8795 Room $78
B $8795,1,1 Nothing
N $8796 Room $79
B $8796,1,1
B $8797,2,2 #HTML[<img src="images/roomadds/roomadd79.png" />]
N $8799 Room $7A
B $8799,1,1
B $879A,18,8 #HTML[<img src="images/roomadds/roomadd7A.png" />]
N $87AC Room $7B
B $87AC,1,1
B $87AD,22,8 #HTML[<img src="images/roomadds/roomadd7B.png" />]
N $87C3 Room $7C
B $87C3,1,1
B $87C4,10,8 #HTML[<img src="images/roomadds/roomadd7C.png" />]
N $87CE Room $7D
B $87CE,1,1
B $87CF,10,8 #HTML[<img src="images/roomadds/roomadd7D.png" />]
N $87D9 Room $7E
B $87D9,1,1
B $87DA,6,6 #HTML[<img src="images/roomadds/roomadd7E.png" />]
N $87E0 Room $7F
B $87E0,1,1
B $87E1,2,2 #HTML[<img src="images/roomadds/roomadd7F.png" />]
N $87E3 Room $80
B $87E3,1,1
B $87E4,4,4 #HTML[<img src="images/roomadds/roomadd80.png" />]
N $87E8 Room $81
B $87E8,1,1 Nothing
N $87E9 Room $82
B $87E9,1,1 Nothing
N $87EA Room $83
B $87EA,1,1 Nothing
N $87EB Room $84
B $87EB,1,1 Nothing
N $87EC Room $85
B $87EC,1,1
B $87ED,4,4 #HTML[<img src="images/roomadds/roomadd85.png" />]
N $87F1 Room $86
B $87F1,1,1
B $87F2,8,8 #HTML[<img src="images/roomadds/roomadd86.png" />]
N $87FA Room $87
B $87FA,1,1
B $87FB,4,4 #HTML[<img src="images/roomadds/roomadd87.png" />]
N $87FF Room $88
B $87FF,1,1
B $8800,6,6 #HTML[<img src="images/roomadds/roomadd88.png" />]
N $8806 Room $89
B $8806,1,1
B $8807,6,6 #HTML[<img src="images/roomadds/roomadd89.png" />]
N $880D Room $8A
B $880D,1,1
B $880E,28,8 #HTML[<img src="images/roomadds/roomadd8A.png" />]
N $882A Room $8B
B $882A,1,1
B $882B,4,4 #HTML[<img src="images/roomadds/roomadd8B.png" />]
N $882F Room $8C
B $882F,1,1
B $8830,26,8 #HTML[<img src="images/roomadds/roomadd8C.png" />]
N $884A Room $8D
B $884A,1,1
B $884B,22,8 #HTML[<img src="images/roomadds/roomadd8D.png" />]
N $8861 Room $8E
B $8861,1,1
B $8862,4,4 #HTML[<img src="images/roomadds/roomadd8E.png" />]
N $8866 Room $8F
B $8866,1,1 Nothing
N $8867 Room $90
B $8867,1,1 Nothing
N $8868 Room $91
B $8868,1,1
B $8869,4,4 #HTML[<img src="images/roomadds/roomadd91.png" />]
N $886D Room $92
B $886D,1,1
B $886E,6,6 #HTML[<img src="images/roomadds/roomadd92.png" />]
N $8874 Room $93
B $8874,1,1 Nothing
N $8875 Room $94
B $8875,1,1 Nothing
N $8876 Room $95
B $8876,1,1
B $8877,4,4 #HTML[<img src="images/roomadds/roomadd95.png" />]
N $887B Room $96
B $887B,1,1
B $887C,8,8 #HTML[<img src="images/roomadds/roomadd96.png" />]
N $8884 Room $97
B $8884,1,1 Nothing
N $8885 Room $98
B $8885,1,1
B $8886,4,4 #HTML[<img src="images/roomadds/roomadd98.png" />]
N $888A Room $99
B $888A,1,1
B $888B,4,4 #HTML[<img src="images/roomadds/roomadd99.png" />]
N $888F Room $9A
B $888F,1,1 Nothing
N $8890 Room $9B
B $8890,1,1
B $8891,4,4 #HTML[<img src="images/roomadds/roomadd9B.png" />]
N $8895 Room $9C
B $8895,1,1
B $8896,14,8 #HTML[<img src="images/roomadds/roomadd9C.png" />]
N $88A4 Room $9D
B $88A4,1,1
B $88A5,34,8 #HTML[<img src="images/roomadds/roomadd9D.png" />]
N $88C7 Room $9E
B $88C7,1,1
B $88C8,4,4 #HTML[<img src="images/roomadds/roomadd9E.png" />]
N $88CC Room $9F
B $88CC,1,1
B $88CD,6,6 #HTML[<img src="images/roomadds/roomadd9F.png" />]
N $88D3 Room $A0
B $88D3,1,1 Nothing
N $88D4 Room $A1
B $88D4,1,1 Nothing
N $88D5 Room $A2
B $88D5,1,1 Nothing
N $88D6 Room $A3
B $88D6,1,1
B $88D7,2,2 #HTML[<img src="images/roomadds/roomaddA3.png" />]
N $88D9 Room $A4
B $88D9,1,1 Nothing
N $88DA Room $A5
B $88DA,1,1
B $88DB,8,8 #HTML[<img src="images/roomadds/roomaddA5.png" />]
N $88E3 Room $A6
B $88E3,1,1
B $88E4,12,8 #HTML[<img src="images/roomadds/roomaddA6.png" />]
N $88F0 Room $A7
B $88F0,1,1
B $88F1,6,6 #HTML[<img src="images/roomadds/roomaddA7.png" />]
N $88F7 Room $A8
B $88F7,1,1
B $88F8,12,8 #HTML[<img src="images/roomadds/roomaddA8.png" />]
N $8904 Room $A9
B $8904,1,1
B $8905,4,4 #HTML[<img src="images/roomadds/roomaddA9.png" />]
N $8909 Room $AA
B $8909,1,1 Nothing
N $890A Room $AB
B $890A,1,1
B $890B,6,6 #HTML[<img src="images/roomadds/roomaddAB.png" />]
N $8911 Room $AC
B $8911,1,1
B $8912,22,8 #HTML[<img src="images/roomadds/roomaddAC.png" />]
N $8928 Room $AD
B $8928,1,1
B $8929,12,8 #HTML[<img src="images/roomadds/roomaddAD.png" />]
N $8935 Room $AE
B $8935,1,1
B $8936,4,4 #HTML[<img src="images/roomadds/roomaddAE.png" />]
N $893A Room $AF
B $893A,1,1 Nothing
N $893B Room $B0
B $893B,1,1
B $893C,6,6 #HTML[<img src="images/roomadds/roomaddB0.png" />]
N $8942 Room $B1
B $8942,1,1
B $8943,4,4 #HTML[<img src="images/roomadds/roomaddB1.png" />]
N $8947 Room $B2
B $8947,1,1 Nothing
N $8948 Room $B3
B $8948,1,1 Nothing
N $8949 Room $B4
B $8949,1,1 Nothing
N $894A Room $B5
B $894A,1,1 Nothing
N $894B Room $B6
B $894B,1,1
B $894C,2,2 #HTML[<img src="images/roomadds/roomaddB6.png" />]
N $894E Room $B7
B $894E,1,1 Nothing
N $894F Room $B8
B $894F,1,1 Nothing
N $8950 Room $B9
B $8950,1,1
B $8951,12,8 #HTML[<img src="images/roomadds/roomaddB9.png" />]
N $895D Room $BA
B $895D,1,1
B $895E,4,4 #HTML[<img src="images/roomadds/roomaddBA.png" />]
N $8962 Room $BB
B $8962,1,1
B $8963,14,8 #HTML[<img src="images/roomadds/roomaddBB.png" />]
N $8971 Room $BC
B $8971,1,1 Nothing
N $8972 Room $BD
B $8972,1,1 Nothing
N $8973 Room $BE
B $8973,1,1
B $8974,8,8 #HTML[<img src="images/roomadds/roomaddBE.png" />]
N $897C Room $BF
B $897C,1,1
B $897D,4,4 #HTML[<img src="images/roomadds/roomaddBF.png" />]
N $8981 Room $C0
B $8981,1,1 Nothing
N $8982 Room $C1
B $8982,1,1 Nothing
N $8983 Room $C2
B $8983,1,1
B $8984,4,4 #HTML[<img src="images/roomadds/roomaddC2.png" />]
N $8988 Room $C3
B $8988,1,1
B $8989,6,6 #HTML[<img src="images/roomadds/roomaddC3.png" />]
N $898F Room $C4
B $898F,1,1 Nothing
N $8990 Room $C5
B $8990,1,1 Nothing
N $8991 Room $C6
B $8991,1,1 Nothing
N $8992 Room $C7
B $8992,1,1
B $8993,8,8 #HTML[<img src="images/roomadds/roomaddC7.png" />]
N $899B Room $C8
B $899B,1,1
B $899C,2,2 #HTML[<img src="images/roomadds/roomaddC8.png" />]
N $899E Room $C9
B $899E,1,1
B $899F,4,4 #HTML[<img src="images/roomadds/roomaddC9.png" />]
N $89A3 Room $CA
B $89A3,1,1
B $89A4,4,4 #HTML[<img src="images/roomadds/roomaddCA.png" />]
N $89A8 Room $CB
B $89A8,1,1 Nothing
N $89A9 Room $CC
B $89A9,1,1 Nothing
N $89AA Room $CD
B $89AA,1,1 Nothing
N $89AB Room $CE
B $89AB,1,1
B $89AC,4,4 #HTML[<img src="images/roomadds/roomaddCE.png" />]
N $89B0 Room $CF
B $89B0,1,1 Nothing
N $89B1 Room $D0
B $89B1,1,1 Nothing
N $89B2 Room $D1
B $89B2,1,1
B $89B3,6,6 #HTML[<img src="images/roomadds/roomaddD1.png" />]
N $89B9 Room $D2
B $89B9,1,1
B $89BA,6,6 #HTML[<img src="images/roomadds/roomaddD2.png" />]
N $89C0 Room $D3
B $89C0,1,1 Nothing
N $89C1 Room $D4
B $89C1,1,1 Nothing
N $89C2 Room $D5
B $89C2,1,1 Nothing
N $89C3 Room $D6
B $89C3,1,1 Nothing
N $89C4 Room $D7
B $89C4,1,1 Nothing
N $89C5 Room $D8
B $89C5,1,1 Nothing
N $89C6 Room $D9
B $89C6,1,1 Nothing
N $89C7 Room $DA
B $89C7,1,1
B $89C8,2,2 #HTML[<img src="images/roomadds/roomaddDA.png" />]
N $89CA Room $DB
B $89CA,1,1
B $89CB,2,2 #HTML[<img src="images/roomadds/roomaddDB.png" />]
N $89CD Room $DC
B $89CD,1,1 Nothing
N $89CE Room $DD
B $89CE,1,1
B $89CF,4,4 #HTML[<img src="images/roomadds/roomaddDD.png" />]
N $89D3 Room $DE
B $89D3,1,1
B $89D4,4,4 #HTML[<img src="images/roomadds/roomaddDE.png" />]
N $89D8 Room $DF
B $89D8,1,1
B $89D9,4,4 #HTML[<img src="images/roomadds/roomaddDF.png" />]
N $89DD Room $E0
B $89DD,1,1 Nothing
N $89DE Room $E1
B $89DE,1,1 Nothing
N $89DF Room $E2
B $89DF,1,1
B $89E0,6,6 #HTML[<img src="images/roomadds/roomaddE2.png" />]
N $89E6 Room $E3
B $89E6,1,1
B $89E7,4,4 #HTML[<img src="images/roomadds/roomaddE3.png" />]
N $89EB Room $E4
B $89EB,1,1
B $89EC,14,8 #HTML[<img src="images/roomadds/roomaddE4.png" />]
N $89FA Room $E5
B $89FA,1,1
B $89FB,4,4 #HTML[<img src="images/roomadds/roomaddE5.png" />]
N $89FF Room $E6
B $89FF,1,1 Nothing
N $8A00 Room $E7
B $8A00,1,1 Nothing
N $8A01 Room $E8
B $8A01,1,1 Nothing
N $8A02 Room $E9
B $8A02,1,1
B $8A03,2,2 #HTML[<img src="images/roomadds/roomaddE9.png" />]
N $8A05 Room $EA
B $8A05,1,1 Nothing
N $8A06 Room $EB
B $8A06,1,1
B $8A07,2,2 #HTML[<img src="images/roomadds/roomaddEB.png" />]
N $8A09 Room $EC
B $8A09,1,1 Nothing
N $8A0A Room $ED
B $8A0A,1,1 Nothing
N $8A0B Room $EE
B $8A0B,1,1 Nothing
N $8A0C Room $EF
B $8A0C,1,1 Nothing
N $8A0D Room $F0
B $8A0D,1,1 Nothing
N $8A0E Room $F1
B $8A0E,1,1 Nothing
N $8A0F Room $F2
B $8A0F,1,1
B $8A10,2,2 #HTML[<img src="images/roomadds/roomaddF2.png" />]
N $8A12 Room $F3
B $8A12,1,1 Nothing
N $8A13 Room $F4
B $8A13,1,1 Nothing
N $8A14 Room $F5
B $8A14,1,1
B $8A15,4,4 #HTML[<img src="images/roomadds/roomaddF5.png" />]
N $8A19 Room $F6
B $8A19,1,1
B $8A1A,2,2 #HTML[<img src="images/roomadds/roomaddF6.png" />]
N $8A1C Room $F7
B $8A1C,1,1
B $8A1D,4,4 #HTML[<img src="images/roomadds/roomaddF7.png" />]
N $8A21 Room $F8
B $8A21,1,1
B $8A22,4,4 #HTML[<img src="images/roomadds/roomaddF8.png" />]
N $8A26 Room $F9
B $8A26,1,1 Nothing
N $8A27 Room $FA
B $8A27,1,1 Nothing
N $8A28 Room $FB
B $8A28,1,1 Nothing
N $8A29 Room $FC
B $8A29,1,1
B $8A2A,4,4 #HTML[<img src="images/roomadds/roomaddFC.png" />]
N $8A2E Room $FD
B $8A2E,1,1 Nothing
N $8A2F Room $FE
B $8A2F,1,1
B $8A30,6,6 #HTML[<img src="images/roomadds/roomaddFE.png" />]
N $8A36 Room $FF
B $8A36,1,1 Nothing
b $8A37
c $8A79 Play the main menu melody ($8B82), called from #R$CD6C
c $8A7E Play the victory-screen melody ($8C3E), called from #R$C055
c $8A83 Play the death/edge-of-map melody ($8C74), called from #R$BF80
c $8A86 Wait for the player to select a menu item from the list at (HL)
N $8A86 Each list entry is a header byte B (bit 5 = flash the border-colour attribute at $8AD9; bits 6-7 = a colour index saved to $8B36; bits 0-3 = a key-wait count) followed by a 2-byte jump-list pointer, consumed by #R$8AAF. A $00 header byte ends the list. Loops to the next entry until #R$8AAF reports a match (Z flag).
C $8A86,2 Disable interrupts; B = this entry's header byte, or 0 = end of list
C $8A8B,7 Bit 5 set: also flash the border-colour attribute byte at $8AD9
C $8A95,8 Bits 6-7 of the header -> colour index, saved to $8B36
C $8A9D,5 Bits 0-3 of the header -> B (key-wait count for #R$8AAF)
C $8AA7,3 Wait for a keyboard row read, decode it via the table at #R$8B57
c $8AAF Wait for a keyboard row read, decode it via the table at #R$8B57
N $8AAF (HL) on entry points at a length-prefixed playlist (see #R$8B82); HL is advanced past it. Loops B times (repeat count from the entry's header, from #R$8B4F/#R$8AB7): reads keyboard port $00FE to check for a keypress between phrases (#R$8AD6, no visible border flash despite the port-$FE writes), then decodes two phrase bytes through the pitch table at #R$8B57/#R$8B60. Each phrase byte's bits 0-4 select a note (0-31, #R$8B60); bits 6-7 of the second byte in the pair (extracted at #R$8B17 via RLCA/RLCA/AND $03) select a duration class (1-4) that sets the note's playback countdown length (#R$8B1E). Bit 5 is not used anywhere in this decode. Confirmed live: this whole routine (and its #R$8B27-#R$8B48 tail) is what's re-invoked continuously while the menu idles, and its tail sets bit 4 of port $FE (the real beeper/EAR output, #R$8B27) on one specific countdown condition - this is the actual playback of the phrase data, the source of the continuous "menu music".
C $8AAF,8 DE = jump target address read from the list at (HL)
C $8ABA,10 Read keyboard port $00FE; low 5 bits (inverted) = pressed keys
C $8AD6,8 Flash border while waiting for a key
C $8ADE,7 A = the first phrase byte, masked to a note index (bits 0-4, 0-31)
C $8AE5,3 Look up the note's pitch/period in #R$8B60
C $8AE8,9 C = first note's pitch period; A = the second (raw) phrase byte
C $8AF1,3 Look up the second note's pitch/period in #R$8B60
C $8AF4,9 Compare the two decoded pitch periods; adjust A
C $8AFD,13 Save the two decoded pitch periods; flag if either note index was 0 (rest)
C $8B0A,13 Save more rest-flags for the notes just decoded
C $8B17,7 A -> B = 1-4, from bits 6-7 of the saved flag byte
C $8B1E,9 Compute H = a table row base from B (0x0E per step)
C $8B27,26 Decrement C then D toward 0, each wrapping via its own self-modified reload operand and toggling a bit of A on underflow (C -> bit 0, D -> bit 1). Only bit 1 (D's toggle) is ever tested (AND $02) to decide the OUT value below; C's toggle (bit 0) is computed but never read - so only the second decoded note (D's period, see #R$8AF1) actually drives the audible tone, not the first
C $8B41,7 Output the resulting value ($10 = tone on, from D's underflow toggle, or $00 = silent) to port $FE; E = its value
C $8B48,7 Loop while HL is non-zero (a distance-proportional delay)
C $8B4F,8 Loop back for the next list entry (B times)
c $8B57 Look up A in the byte table at #R$8B60
R $8B57 A $00.$1F
b $8B60 32-note chromatic pitch/period table for the beeper music engine
N $8B60 32 bytes, indexed 0-31 by #R$8B57. Consecutive values' ratios all cluster tightly around 1.059 = 2^(1/12), the equal-temperament semitone ratio, confirming this is a period table for a 1-bit tone generator spanning roughly 2.5 octaves (higher index = shorter period = higher pitch). Entry 0 ($00) fits the same geometric progression only when read as $100 (256), not literal zero - i.e. the lowest note's period wraps through a byte-sized counter.
N $8B60 Absolute frequencies computed by simulating the exact fixed T-state cost of #R$8B27's loop body (both branch paths) at 3.5MHz, since only entry 31's/entry 0's role as D's reload value (see #R$8B27) actually gates the tone. Entry 0 ($100) = ~71Hz (near C#2/D2); entry 31 ($2D) = ~401Hz (near G4) - a ~2.5-octave chromatic run from the low D-ish range up to G4.
B $8B60,32,8
b $8B82 Main menu melody (see #R$8A86)
N $8B82 Each entry is 3 bytes: a header byte followed by a 2-byte address, ending with a $00 header. This is a music playlist, not a key list: by ear, the header's low nibble is a repeat count and the high nibble ($80/$A0/$C0/$E0) selects an effect (plain/echo/drums/...) applied to the phrase at the given address; several entries reuse the same phrase address with a different effect/repeat. #R$8A86 still treats the header generically (as a wait-count and two bits fed to $8AD9/$8B36) since the effect selection itself hasn't been isolated in the code yet.
B $8B82,1
W $8B83,2
B $8B85,1
W $8B86,2
B $8B88,1
W $8B89,2
B $8B8B,1
W $8B8C,2
B $8B8E,1
W $8B8F,2
B $8B91,1
W $8B92,2
B $8B94,1
W $8B95,2
B $8B97,1
W $8B98,2
B $8B9A,1
W $8B9B,2
B $8B9D,1
W $8B9E,2
B $8BA0,1
W $8BA1,2
B $8BA3,1
W $8BA4,2
B $8BA6,1
b $8BA7
B $8BB3
B $8BC4
B $8BD9
B $8C1C
b $8C3E Victory-screen melody (see #R$8A86)
N $8C3E Same 3-byte playlist format as #R$8B82. All three entries here point at the same phrase, just with different effect/repeat headers.
B $8C3E,1
W $8C3F,2
B $8C41,1
W $8C42,2
B $8C44,1
W $8C45,2
B $8C47,1
b $8C48
b $8C74 Death/edge-of-map melody (see #R$8A86)
N $8C74 Same 3-byte playlist format as #R$8B82, but only a single entry - this screen has just one music phrase. Its address ($8C78) is the first byte right after the list's own terminator; the 21 bytes from there to #R$8C8D are presumably the phrase data itself (not further list entries).
B $8C74,1
W $8C75,2
B $8C77,1
b $8C78
c $8C8D Sound of evil laughter
C $8C96,3 Play a sound effect encoded as a bit-per-border-flip stream
c $8CAA Play a sound effect encoded as a bit-per-border-flip stream
N $8CAA Called from #R$CD6C ("Sound of evil laughter" is one such effect). (HL) -> a 2-byte bit-count (DE), followed by the bitstream itself. Each bit is rotated out of the data byte via RLC (HL) and drives the border colour (bit set -> colour 0, clear -> low 3 bits of a counting value), with a small busy-wait between bits; continues until DE bits have been played.
C $8CAA,4 DE = total bit count, from the 2 bytes at (HL)
C $8CAE,7 B = 8 bits per data byte; C = a short per-bit delay
C $8CB5,4 A = $18 (border white); RLC (HL) shifts out the next bit
b $8CD4 Data for Sound of evil laughter
N $8CD4 The "ha-ha-ha-ha" bitstream played by #R$8CAA (heard on the intro and on the #R$B867 capture/ambush - confirmed by ear, not on ordinary combat). 172 bytes total ($8CD4-$8D7F): a 2-byte bit-count ($00AC = 172 bits) followed by 170 bytes of bitstream.
B $8CD4,2 Bit count ($00AC = 172 bits)
B $8CD6,,12
w $8D80
W $8D80,,8
w $8E12
b $8E1C
b $8E24 Robin sprites
B $8E27,96,8 #HTML[#UDGARRAY3,4,3,3,,($8E27-$8E86-1-24)(robin0)] Robin 0
B $8E87,3
B $8E8A,96,8 #HTML[#UDGARRAY3,4,3,3,,($8E8A-$8EE9-1-24)(robin1)] Robin 1
B $8EEA,3
B $8EED,96,8 #HTML[#UDGARRAY3,4,3,3,,($8EED-$8F4C-1-24)(robin2)] Robin 2
B $8F4D,3
B $8F50,96,8 #HTML[#UDGARRAY3,4,3,3,,($8F50-$8FAF-1-24)(robin3)] Robin 3
B $8FB0,3
B $8FB3,96,8 #HTML[#UDGARRAY3,4,3,3,,($8FB3-$9012-1-24)(robin4)] Robin 4
B $9013,3
B $9016,96,8 #HTML[#UDGARRAY3,4,3,3,,($9016-$9075-1-24)(robin5)] Robin 5
B $9076,3
B $9079,96,8 #HTML[#UDGARRAY3,4,3,3,,($9079-$90D8-1-24)(robin6)] Robin 6
B $90D9,3
B $90DC,96,8 #HTML[#UDGARRAY3,4,3,3,,($90DC-$913B-1-24)(robin7)] Robin 7
B $913C,3
B $913F,96,8 #HTML[#UDGARRAY3,4,3,3,,($913F-$919E-1-24)(robin8)] Robin 8
B $919F,3
B $91A2,96,8 #HTML[#UDGARRAY3,4,3,3,,($91A2-$9201-1-24)(robin9)] Robin 9
B $9202,3
B $9205,96,8 #HTML[#UDGARRAY3,4,3,3,,($9205-$9264-1-24)(robinA)] Robin A
B $9265,3
B $9268,96,8 #HTML[#UDGARRAY3,4,3,3,,($9268-$92C7-1-24)(robinB)] Robin B
B $92C8,3
B $92CB,96,8 #HTML[#UDGARRAY3,4,3,3,,($92CB-$932A-1-24)(robinC)] Robin C
B $932B,3
B $932E,96,8 #HTML[#UDGARRAY3,4,3,3,,($932E-$938D-1-24)(robinD)] Robin D
B $938E,3
B $9391,96,8 #HTML[#UDGARRAY3,4,3,3,,($9391-$93F0-1-24)(robinE)] Robin E
B $93F1,3
B $93F4,96,8 #HTML[#UDGARRAY3,4,3,3,,($93F4-$9453-1-24)(robinF)] Robin F
b $9454 Guard sprites
B $9454,3
B $9457,96,8 #HTML[#UDGARRAY3,,3,3,,($9457-$94B6-1-24)(guard0)] Guard 0
B $94B7,3
B $94BA,96,8 #HTML[#UDGARRAY3,,3,3,,($94BA-$9519-1-24)(guard1)] Guard 1
B $951A,3
B $951D,96,8 #HTML[#UDGARRAY3,,3,3,,($951D-$957C-1-24)(guard2)] Guard 2
B $957D,3
B $9580,96,8 #HTML[#UDGARRAY3,,3,3,,($9580-$95DF-1-24)(guard3)] Guard 3
B $95E0,3
B $95E3,96,8 #HTML[#UDGARRAY3,,3,3,,($95E3-$9642-1-24)(guard4)] Guard 4
B $9643,3
B $9646,96,8 #HTML[#UDGARRAY3,,3,3,,($9646-$96A5-1-24)(guard5)] Guard 5
B $96A6,3
B $96A9,96,8 #HTML[#UDGARRAY3,,3,3,,($96A9-$9708-1-24)(guard6)] Guard 6
B $9709,3
B $970C,96,8 #HTML[#UDGARRAY3,,3,3,,($970C-$976B-1-24)(guard7)] Guard 7
B $976C,3
B $976F,96,8 #HTML[#UDGARRAY3,,3,3,,($976F-$97CE-1-24)(guard7)] Guard 7
B $97CF,3
B $97D2,96,8 #HTML[#UDGARRAY3,,3,3,,($97D2-$9831-1-24)(guard8)] Guard 8
B $9832,3
B $9835,96,8 #HTML[#UDGARRAY3,,3,3,,($9835-$9894-1-24)(guard9)] Guard 9
B $9895,3
B $9898,96,8 #HTML[#UDGARRAY3,,3,3,,($9898-$98F7-1-24)(guardA)] Guard A
B $98F8,3
B $98FB,96,8 #HTML[#UDGARRAY3,,3,3,,($98FB-$995A-1-24)(guardB)] Guard B
B $995B,3
B $995E,96,8 #HTML[#UDGARRAY3,,3,3,,($995E-$99BD-1-24)(guardC)] Guard C
B $99BE,3
B $99C1,96,8 #HTML[#UDGARRAY3,,3,3,,($99C1-$9A20-1-24)(guardD)] Guard D
B $9A21
b $9A36
B $9A56
B $9A76
B $9A96
b $9AB2
b $9AD2
b $9AE2
b $9B46
b $9B5C
b $9BFB
b $9D53
b $9DAE
b $9DB2
b $9DDA
b $9DE3
b $9ED9
b $9EF1
b $9F11
b $9F61
b $9F8B
b $9FA6
b $A053
b $A073
b $A093
b $A0B3
b $A0D3
b $A0F3
b $A113
b $A133
b $A153
b $A190
b $A1B0
b $A1D0
b $A1F0
b $A210
b $A230
b $A26D
b $A2AA
b $A2E7 Witch sprites
B $A2E7,120,8 #HTML[#UDGARRAY3,,3,3,,($A2E7-$A35E-1-24)(witch0)] Witch 0
B $A35F,120,8 #HTML[#UDGARRAY3,,3,3,,($A35F-$A3D6-1-24)(witch1)] Witch 1
B $A3D7,120,8 #HTML[#UDGARRAY3,,3,3,,($A3D7-$A44E-1-24)(witch2)] Witch 2
b $A44F
b $A45E Druid sprites
B $A461,96,8 #HTML[#UDGARRAY3,7,3,3,,($A461-$A4C0-1-24)(druid0)] Druid 0
B $A4C1,3,3
B $A4C4,96,8 #HTML[#UDGARRAY3,7,3,3,,($A4C4-$A523-1-24)(druid1)] Druid 1
B $A524,3,3
B $A527,96,8 #HTML[#UDGARRAY3,7,3,3,,($A527-$A586-1-24)(druid2)] Druid 2
B $A587,3,3
B $A58A,96,8 #HTML[#UDGARRAY3,7,3,3,,($A58A-$A5E9-1-24)(druid3)] Druid 3
B $A5EA,3,3
B $A5ED,96,8 #HTML[#UDGARRAY3,7,3,3,,($A5ED-$A64C-1-24)(druid4)] Druid 4
B $A64D,3,3
B $A650,96,8 #HTML[#UDGARRAY3,7,3,3,,($A650-$A6AF-1-24)(druid5)] Druid 5
B $A6B0,3,3
B $A6B3,96,8 #HTML[#UDGARRAY3,7,3,3,,($A6B3-$A712-1-24)(druid6)] Druid 6
B $A713,3,3
B $A716,96,8 #HTML[#UDGARRAY3,7,3,3,,($A716-$A775-1-24)(druid7)] Druid 7
B $A776,3,3
B $A779,96,8 #HTML[#UDGARRAY3,7,3,3,,($A779-$A7D8-1-24)(druid8)] Druid 8
B $A7D9,3,3
B $A7DC,96,8 #HTML[#UDGARRAY3,7,3,3,,($A7DC-$A83B-1-24)(druid8)] Druid 8
b $A83C Bishop sprites
B $A83F,96,8 #HTML[#UDGARRAY3,3,3,3,,($A83F-$A89E-1-24)(bishop0)] Bishop 0
B $A89F,3,3
B $A8A2,96,8 #HTML[#UDGARRAY3,3,3,3,,($A8A2-$A901-1-24)(bishop1)] Bishop 1
B $A902,3,3
B $A905,96,8 #HTML[#UDGARRAY3,3,3,3,,($A905-$A964-1-24)(bishop2)] Bishop 2
b $A965 Wild boar
B $A965,3,3
B $A968,48,8 #HTML[#UDGARRAY3,2,3,3,,($A968-$A997-1-24)(boar0)] Boar 0
B $A998,3,3
B $A99B,48,8 #HTML[#UDGARRAY3,2,3,3,,($A99B-$A9CA-1-24)(boar1)] Boar 1
B $A9CB,3,3
B $A9CE,48,8 #HTML[#UDGARRAY3,2,3,3,,($A9CE-$A9FD-1-24)(boar2)] Boar 2
B $A9FE,3,3
B $AA01,48,8 #HTML[#UDGARRAY3,2,3,3,,($AA01-$AA30-1-24)(boar3)] Boar 3
c $AA31 Update a patrolling enemy's direction/animation state
N $AA31 IX -> object record (same layout as #R$C8F7). Runs its main logic once every 4 calls (divider counter at $AA32). Picks a new animation-frame-list pointer for (IX+2/3) from one of the direction tables at $AC67/$AC6B/$AC6F/$AC75/$AC7B based on the object's position relative to the current room ($C548) and a state byte, then sets flags in (IX+4) and calls #R$C8F7 to advance the frame. Also indexes a per-entry table at #R$AC13 (11 bytes/entry) and a step table at $DEAB - their exact per-guard meaning is unconfirmed.
C $AA31,11 Divide call rate by 4 using the counter at $AA32
C $AA3E,15 IX = entry (IX+2/3) x $0003 into the object table at ($C54C)
C $AA53,27 (IX+2) bit 4 clear: compare the guard's room row to Robin's ($C548)
C $AA6E,33 Guard is close: look up a direction table entry at $DEAB
C $AA8F,8 Skip forward past any zero bytes in the step table
C $AA97,20 EXX; toggle a mirror-flag bit or fall through, depending on a flag
C $AAAB,23 EXX back; compare Robin's column to the reference table at $DEC7
C $AAC2,23 ~1 call in 16 (R register): occasionally flip a direction bit
C $AAD9,33 Step the guard's target index by one, wrapping at the $70 boundary
C $AAFA,18 IX -> the guard's entry in the table at $AC13 (indexed by $AA32)
C $AB0C,15 Compare the guard's home room nibble ($C548) to the table entry
C $AB1E,11 Not an exact match: check if it's an adjacent room instead
C $AB29,8 Room mismatch (out of range): branch away below
C $AB31,9 (IX+9) = the resolved position; check the block's flags
C $AB3A,22 Bit 5/7 of the flags select which direction-table pair to use
C $AB50,26 Otherwise pick a direction-table pair from bits 6-7 of the flags
C $AB6A,37 Compare the guard's position to Robin's ($CC85); check proximity/timing
C $ABAB,12 EXX back; HL = Robin's row (from $CC85, halved twice)
C $ABE3,8 Set redraw flags and hand off to #R$C8F7
C $ABF0,5 Same, but with bit 2 cleared instead of set (different frame)
C $ABFD,15 If not blocked (bit 5), pick a frame-pointer table from bit 7
C $ABEB,3 Advance an object's animation, unlink it from the list if done
C $ABF5,3 Advance an object's animation, unlink it from the list if done
b $AC13
c $AC83 Draw the main menu items
N $AC83 Called from #R$CD6C. Clears the screen, computes a highlight position from the last-chosen control scheme ($AD32, set by #R$D0CB), then prints 6 menu message strings ($40..$4C) at fixed positions, finishing with the side-wipe transition (#R$CE81).
C $AC83,2 A = $47 (screen number?)
C $AC88,16 Compute the highlighted item's position from $AD32
C $AC85,3 Clear the shadow screen
C $AC98,3 Print message number A, positioned from the $D7CE table
C $ACA0,3 Print message number A, positioned from the $D7CE table
C $ACA8,3 Print message number A, positioned from the $D7CE table
C $ACB0,3 Print message number A, positioned from the $D7CE table
C $ACB8,3 Print message number A, positioned from the $D7CE table
C $ACC0,3 Print message number A, positioned from the $D7CE table
C $ACC3,3 => Side-wipe transition between the game screen and the Odin sign
t $ACC6 Menu messages
T $ACC6
B $ACCD,1
T $ACCE
B $ACD5,1
T $ACD6
B $ACE0,1
T $ACE1
B $ACEB,1
T $ACEC
B $ACF6,1
T $ACF7
B $AD01,1
T $AD02
B $AD10,1
T $AD11
B $AD1F,1
T $AD20
B $AD28,1
T $AD29
b $AD31 Font
N $AD53 #HTML[#UDGARRAY16($AD53-$ADB2-8)(font0.png)]
B $AD53,8 "Enter" symbol
B $AD5B,8 '%'
B $AD63,8 '@'
N $ADB3 #HTML[#UDGARRAY16($ADB3-$AE32-8)(font1.png)]
B $ADB3,8 $30 '0'
B $ADBB,8 $31 '1'
B $ADC3,8 $32 '2'
B $ADCB,8 $33 '3'
B $ADD3,8 $34 '4'
B $ADDB,8 $35 '5'
B $ADE3,8 $36 '6'
B $ADEB,8 $37 '7'
B $ADF3,8 $38 '8'
B $ADFB,8 $39 '9'
N $AE33 #HTML[#UDGARRAY16($AE33-$AEB2-8)(font2.png)]
B $AE33,8,8 $40
B $AE3B,8,8 $41 'A'
B $AE43,8,8 $42 'B'
B $AE4B,8,8 $43 'C'
B $AE53,8,8 $44 'D'
B $AE5B,8,8 $45 'E'
B $AE63,8,8 $46 'F'
B $AE6B,8,8 $47 'G'
B $AE73,8,8 $48 'H'
B $AE7B,8,8 $49 'I'
B $AE83,8,8 $4A 'J'
B $AE8B,8,8 $4B 'K'
B $AE93,8,8 $4C 'L'
B $AE9B,8,8 $4D 'M'
B $AEA3,8,8 $4E 'N'
B $AEAB,8,8 $4F 'O'
N $AEB3 #HTML[#UDGARRAY11($AEB3-$AF0A-8)(font3.png)]
B $AEB3,8,8 $50 'P'
B $AEBB,8,8 $51 'Q'
B $AEC3,8,8 $52 'R'
B $AECB,8,8 $53 'S'
B $AED3,8,8 $54 'T'
B $AEDB,8,8 $55 'U'
B $AEE3,8,8 $56 'V'
B $AEEB,8,8 $57 'W'
B $AEF3,8,8 $58 'X'
B $AEFB,8,8 $59 'Y'
B $AF03,8,8 $5A 'Z'
N $AF0B #HTML[#UDGARRAY15($AF0B-$AF82-8)(font4.png)]
N $AF0B Energy-bar antlers, upper half (15 glyphs, see #R$BF37 - a fixed shape recoloured to show the energy level, not a growth sequence)
B $AF0B,8,8 $5B upper antler 0
B $AF13,8,8 $5C upper antler 1
B $AF1B,8,8 $5D upper antler 2
B $AF23,8,8 $5E upper antler 3
B $AF2B,8,8 $5F upper antler 4
B $AF33,8,8 $60 upper antler 5
B $AF3B,8,8 $61 upper antler 6
B $AF43,8,8 $62 upper antler 7
B $AF4B,8,8 $63 upper antler 8
B $AF53,8,8 $64 upper antler 9
B $AF5B,8,8 $65 upper antler 10
B $AF63,8,8 $66 upper antler 11
B $AF6B,8,8 $67 upper antler 12
B $AF73,8,8 $68 upper antler 13
B $AF7B,8,8 $69 upper antler 14
N $AF83 #HTML[#UDGARRAY15($AF83-$AFFA-8)(font5.png)]
N $AF83 Energy-bar antlers, lower half (15 glyphs, see #R$BF37 - a fixed shape recoloured to show the energy level, not a growth sequence)
B $AF83,8,8 $6A lower antler 0
B $AF8B,8,8 $6B lower antler 1
B $AF93,8,8 $6C lower antler 2
B $AF9B,8,8 $6D lower antler 3
B $AFA3,8,8 $6E lower antler 4
B $AFAB,8,8 $6F lower antler 5
B $AFB3,8,8 $70 lower antler 6
B $AFBB,8,8 $71 lower antler 7
B $AFC3,8,8 $72 lower antler 8
B $AFCB,8,8 $73 lower antler 9
B $AFD3,8,8 $74 lower antler 10
B $AFDB,8,8 $75 lower antler 11
B $AFE3,8,8 $76 lower antler 12
B $AFEB,8,8 $77 lower antler 13
B $AFF3,8,8 $78 lower antler 14
N $B11B #HTML[#UDGARRAY3($B11B-$B132-8)(font9D.png)]
N $B11B "+1 life" wreath symbol, upper half (3 glyphs)
B $B11B,8,8 $9D wreath upper 0
B $B123,8,8 $9E wreath upper 1
B $B12B,8,8 $9F wreath upper 2
N $B133 #HTML[#UDGARRAY3($B133-$B14A-8)(fontA0.png)]
N $B133 "+1 life" wreath symbol, lower half (3 glyphs)
B $B133,8,8 $A0 wreath lower 0
B $B13B,8,8 $A1 wreath lower 1
B $B143,8,8 $A2 wreath lower 2
B $B14B,8,8 $A3
N $B1F3 #HTML[#UDGARRAY3($B1F3-$B20A-8)(fontB8.png)]
N $B1F3 Sword symbol used as the main-menu selection pointer (3 glyphs)
B $B1F3,8,8 $B8 sword 0
B $B1FB,8,8 $B9 sword 1
B $B203,8,8 $BA sword 2
s $B26A
t $B26B
b $B273
t $B333
b $B336
t $B353
b $B358
t $B374
b $B377
t $B37C
b $B37F
t $B3A3
b $B3A7
t $B41D
b $B422
b $B434
b $B470
b $B47C
t $B489
b $B494
t $B4AA
b $B4AE
t $B4B2
b $B4B8 Sword in Menu
B $B4B8,1,1
B $B4B9,3,3
B $B4BC,1,1
T $B4BD,3,3
b $B4C0
b $B4DF
b $B4E4
b $B4ED
b $B536
t $B582
b $B586
b $B587 Ornament at the left side of the game screen
B $B589
b $B5C0 Ornament at the right side of the game screen
t $B5FB
b $B5FE
t $B5FF
b $B603
t $B604
b $B608
t $B609
b $B60D
t $B60E
s $B612
t $B613
b $B617
t $B618
b $B61C
t $B61D
b $B621
t $B622
b $B626
t $B627
b $B62B
t $B62C
b $B630
t $B663
b $B66B
t $B66C
b $B672
t $B673
b $B679
t $B67A
b $B680
t $B681
b $B687
t $B690
b $B694
t $B69E
b $B6A2
t $B6AD
b $B6C3
t $B6C6
b $B6DF
t $B6E1
b $B6F4
t $B6F6
b $B70D
t $B710
b $B729
t $B72B
b $B745
t $B747
b $B763
t $B765
s $B77B
t $B77C
b $B793
t $B796
b $B7AF
t $B7B1
b $B7CA
t $B7CC
b $B7E5
t $B848
s $B866
c $B867 Trigger the scripted ambush when Robin reaches the target room's centre
N $B867 Only acts in the room picked by #R$CFB3 ($D3B8). Advances the object at $B8FB (same as #R$C276 sets up) every 4th call. While Robin's X position ($CC85) is in the centre band ($24..$5B) and the ambush hasn't already fired (bit 7 of the object's flags), arms it: plays "evil laughter" (#R$8C8D), and once the object reaches a specific animation frame ($02), warps Robin to room $9C and redraws the screen.
C $B867,11 Only run in the target room ($D3B8); once every 4 calls
C $B87A,18 IX -> the special object at $B8FB; advance its animation
C $B88F,11 Only act while Robin's X ($CC85) is in the centre band
C $B8C3,8 Once the object reaches frame $02, check whether to warp Robin
C $B88C,3 Advance an object's animation, unlink it from the list if done
C $B8D4,3 Sound of evil laughter
C $B8E3,3 Clear the shadow screen
C $B8E6,3 Draw current room on the shadow screen
C $B8E9,3 Look up current room number in the $C550 table
C $B8EE,3 Handle room entry
C $B8F1,3 Side-wipe transition between the game screen and the Odin sign
C $B8F4,3 Pick a random entry from the pointer table at $D3A2, save to $D3B8
b $B8FB
c $B919 Update a special enemy: pick a target room, then patrol toward it
N $B919 Tracks its own state in $BB9x/$AC4x variables rather than a shared object-record table. Every 4th call ($BBA0 counter) it may pick a new target room from the table at $BBA1 (keyed by a random R-register roll) and reset movement/timer state; it also decides between two direction-table pairs ($AC67/$AC6B vs $AC7B) and calls #R$BA85 to take one step. The condition/trigger logic (bits of $BB9F) is not fully confirmed.
C $B926,15 R register -> pick a target room from the table at $BBA1
C $B935,14 If the picked room equals the last one, reroll (JR Z back to $B926)
C $B943,12 Save the target room to several tracking variables
C $B953,11 Save the target's second coordinate the same way
C $B95E,12 Set the default direction-table and timer pointers
C $B96A,17 Zero several per-guard counters, set a retry counter to 1
C $B97B,18 Set movement flags to $03 and two timer bytes ($30, $18)
C $B98D,10 Run the state machine below only once every 4 calls
C $B997,8 $BB9F bit 1 clear -> skip straight to the movement step below
C $B9D0,6 (IX+4) bit 5 clear -> take the "already at column" branch
C $B9D6,5 Set movement flag bit 2, save it to $BB9F
C $B9DB,20 Point $D9B3/$D9B8/$D9BD/$D9C9 at $BB9D/$BB96 (purpose unconfirmed)
C $B9EF,10 Log the current room/position via #R$D997, advance the arrow-hit stage
C $BA11,20 Room reached: set up variables, force a step via #R$BA85
C $BA25,28 Set flags/timer, pick a direction-table pair, force a step below
C $BA41,3 Step the special enemy's map position one cell toward its target
C $BA44,12 Reset the entry point to $BA93 for the next call; bit 0 clear -> return
C $BA50,8 IX -> the fixed object at $BB8D; bit 2 clear -> skip the range check
C $BA58,12 Compare the tracked room to the current one; skip if not a match
C $BA64,11 (IX+9) within range $14..$63 is treated as a proximity trigger
C $BA6F,9 Clear movement flag bits 1/3, return without moving
C $BA78,9 Otherwise use the alternate direction-table pair
C $BA81,3 Step the special enemy's map position one cell toward its target
c $BA85 Step the special enemy's map position one cell toward its target
N $BA85 IX -> its object record. (IX+10/11) holds the enemy's current world-map position, packed as two nibbles (X in bits 0-3, Y in bits 4-7 of the low byte plus the high byte). Depending on a facing bit at (IX+11) and comparisons against target coordinates at (IX+0C..0F), the low or high nibble of the position is incremented or decremented by one, moving it one map cell toward the target; #R$C8F7 is then called to advance/redraw the frame.
C $BA85,14 Stash HL/DE/BC for the entry point at #R$BA93
C $BA93,3 (IX+0B) bit 0 selects the vertical- or horizontal-move branch below
C $BA96,18 Compare the current X nibble to the target; wrap the position at $70
C $BAA8,10 Reached the target X: check if Y also matches
C $BAB2,21 Step the X nibble of the position down by one
C $BAC7,15 Other direction: check if Y matches the other target coordinate
C $BAD6,22 Step the X nibble of the position up by one, wrapping at $6F
C $BAEC,8 Arrived at the target row/column: flip facing, pick a frame pointer
C $BAF4,9 HL = one of two frame-pointer tables, by the flipped facing bit
C $BAFD,8 Save the frame pointer to (IX+2/3)
C $BB05,15 Check whether the Y position also matches the current room
C $BB62,14 Set redraw flags and hand off to #R$C8F7
C $BB70,3 Advance an object's animation, unlink it from the list if done
b $BB7F
c $BBC1 Update the object at $BC59: step its room-distance counter, animate
N $BBC1 Every 4th call (counter at $BBC2/$BB92 by way of #R$BF80). Every 4th pass of an inner phase counter ($BC66) it also alternates a direction-table pair ($BC69/$BC75, toggled at $BBF4) into the frame pointer. Steps a position byte (IX+9, IX = fixed object at $BC59) by one toward/away from Robin's room ($C548) - tracked via the counter at $BC64 - wrapping at $70 as in #R$BA85, then redraws via #R$C8F7.
C $BBC1,9 Divide the call rate by 4 using the counter at $BBC2
C $BC18,10 Compare the tracked room distance ($BC64) to Robin's room ($C548)
C $BC36,15 IX -> the object at $BC59; set the position and redraw flags
C $BC45,3 Advance an object's animation, unlink it from the list if done
C $BC51,3 Advance an object's animation, unlink it from the list if done
b $BC59
c $BCC2 Step the arrow one pixel along its diagonal flight, drawing it
N $BCC2 (HL) = the arrow object's direction byte at $BF68: bit 7/6 select which of two constants get patched into the self-modified operands at $BCF2/$BD03 (arrow moving right/left, up/down). Reads the arrow's screen position from the byte below ($BF67, bit 7 = "arrow gone" flag), plots it via #R$BD2A, then steps the column (C) and row (L) by +-1 based on whether the draw collided (bit 7 of the plotted byte), tracing the arrow's diagonal path one segment per call.
C $BCC2,5 HL -> arrow direction byte at $BF68; B = 4 (unused loop count)
C $BCC9,9 Direction bit 7 selects a patch value written to $BCF2
C $BCD5,9 Direction bit 6 selects a patch value written to $BD03
C $BCE1,11 (HL) -> arrow position byte; bail out if the arrow is gone ($00)
C $BCF3,3 Mark the arrow's screen cell dirty in the $E500 buffer
c $BD04 Clear the arrow's cell without a mid-flight collision check, then continue
N $BD04 A reduced entry into #R$BD23's shared tail: clears (HL) directly rather than testing a screen-edge column, then loops back to #R$BCC7.
c $BD09 Clear the arrow at screen edges, else mark a mid-flight collision bit
N $BD09 Marks the arrow's cell dirty via #R$BD2A, then checks its column (L, now in A after the draw): columns 0-1 or 30-37 clear the collision byte (arrow off-screen); otherwise rotates a bit from A into (HL), marking a mid-flight collision cell. Loops back to #R$BCC7 for the next arrow step.
C $BD09,9 Column < 2: arrow off the left edge, clear its collision byte
C $BD16,8 Column >= $1E: arrow off the right edge, clear its collision byte
C $BD1E,5 Otherwise: rotate a bit from A into the collision byte at (HL)
C $BD23,7 Restore state and loop back to #R$BCC7 for the next arrow step
C $BD09,3 Mark the arrow's screen cell dirty in the $E500 buffer
c $BD2A Mark the arrow's screen cell dirty in the $E500 buffer (glyph $46)
N $BD2A Called from #R$BCC2's arrow-step loop and #R$BD09. Toggles (HL) - the arrow's collision byte - by XORing $FF into it, then packs B/C (row/column) into an offset into the $E500 change-buffer (the same buffer #R$C85C later flushes to the real screen) and writes glyph code $46 there, so the arrow appears/disappears at its new position.
C $BD2A,8 Toggle the arrow's collision byte at (HL)
C $BD32,18 Pack B/C into an $E500 buffer offset, write glyph $46
c $BD49 Check an arrow hit against nearby guards, then a border-flash sound
N $BD49 (HL) is the arrow object at $BF67; does nothing if it's inactive, or if its animation frame ($BF68 low 7 bits) isn't one of the "in flight" frames $0A..$0D. Otherwise scans 5 guard entries at #R$AC13 (skipping inactive/already-hit ones) for one whose position (IX+9) is close to the arrow's column, and on a match sets a "hit" flag on the guard and calls #R$BF1A. #R$BD84 (also entered from #R$BE43's sword check) then plays a longer border-flash effect ($14 outer x C inner loops, C counting 1..$27) as the hit/scream sound.
C $BD49,4 (HL) -> arrow object at $BF67; bail out if inactive
C $BD5A,6 IX -> guard table at $AC13; B = 5 guards to check
C $BD60,23 Skip inactive/already-hit guards; check the guard's column vs arrow
C $BD77,13 In range: mark the guard hit, call #R$BF1A
C $BD84,2 Shared hit-sound entry: C = $14 outer passes
c $BDA3 Check Robin against up to 3 room hotspots at $BF69 (e.g. ladders)
N $BDA3 Only runs while Robin is idle ($CC7B=0). Scans 3 two-byte entries at $BF69 (row byte, then a second byte read at +1); a non-$FF row byte is scaled (x4, then compared within an 8-pixel band against $CC85; x8 compared within a 24-pixel band against $CC86) to test whether Robin's position falls within the hotspot. On a hit, sets bit 6 of the entry and calls #R$BE25 then #R$BF54 (B=0) - likely starting a climb/interact state. Exact meaning of the entry's second byte and the two helper calls is not fully confirmed.
C $BDA3,14 Only run while Robin is idle ($CC7B = 0); B = 3 entries, DE = Robin's position
C $BDB1,5 (HL) = $FF marks an unused entry; skip it
C $BDD3,3 Damage Robin
C $BDD8,3 Border-flash sound with rising pitch
c $BDE0 Check Robin against the door-guard table ($DD05) for a bump
N $BDE0 Only runs for multi-column rooms ($C549 != 0), while Robin is idle ($CC7B=0), and about 1 call in 8 (R register). Scans the 4 door-guard entries at $DD05 (built by #R$C276), skipping inactive ones (bit 0 of (IX+4)), and tests Robin's position ($CC85) against the guard's (IX+9/0A) via #R$BEE3; on overlap calls #R$BE25 then a border-flash via #R$BF54 (B=$60).
C $BDE0,15 Only run for multi-column rooms, while idle, ~1 call in 8
C $BDEF,6 B = 4 door-guard entries; IX -> table at $DD05
C $BE0D,3 Bounding-box overlap test
C $BE12,3 Damage Robin
C $BE17,3 Border-flash sound with rising pitch
c $BE25 Damage Robin: decrement energy, or trigger death if critical
N $BE25 Called from #R$BDA3/#R$BDE0 on a hazard/door-guard hit. Only acts while idle ($CC7B=0). If the energy byte at $BF6F is already $02 (critical), instead sets Robin's animation to code $6E and clears a flag at $BC67; otherwise just decrements the energy byte. Either way redraws the energy bar via #R$BF37. Despite the name this isn't necessarily permanent death: #R$C9E7 dispatches code $6E to #R$CB9D, which plays a short border-flash (not the "evil laughter" heard on capture/game-over), penalises the kill counter, and lets Robin recover after a timer - a "critical hit/stagger" reaction, not a game-over. The actual death/game-over sequence has not been located; it may simply be the scripted ambush/capture at #R$B867 (the only other place "evil laughter" plays).
C $BE25,5 Only act while Robin is idle ($CC7B = 0)
C $BE35,10 Critical: switch to the death animation, clear a flag at $BC67
C $BE2A,3 Energy level address
C $BE32,1 Decrease energy
C $BE3F,3 Draw the energy bar
c $BE43 Check a sword swing against nearby guards
N $BE43 Only acts if Robin's current animation frame ($CC7E) is one of the sword-swing frames ($1A/$1F/$1C). Builds a hit-rectangle (BC) offset from Robin's position ($CC85/$CC86), flipped by facing ($CC87 bit 0), then scans up to 5 guard entries in the table at #R$AC13 (skipping inactive or already-hit ones) for overlap via #R$BEE3; the first hit calls #R$BF1A and jumps to #R$BD84 to apply the effect.
C $BE43,10 A = Robin's current animation frame; only sword frames continue
C $BE6C,10 BC = hit-rectangle position (Robin's position + facing offset)
C $BE76,7 HL = 5 guards to check; IX -> guard table at $AC13
C $BE98,3 Bounding-box overlap test
C $BEA0,3 Mark a hit guard as defeated
c $BEB1 Defeat the special enemy: on contact, refill energy and celebrate
N $BEB1 Only acts if bit 0 of $BC5D is set and bit 7 of $BC67 is clear (the special object at #R$BBC1 is active and not already defeated), and Robin overlaps it (#R$BEE3, using its position at $BC62). On contact: flashes the whole screen (#R$BEF7), refills Robin's energy to max and redraws the bar, prints a kill-count message (#R$D91A), and sets bit 6 of $BC67 to mark it defeated.
C $BEB1,5 Bail out unless bit 0 of $BC5D is set
C $BEB6,5 Bail out if bit 7 of $BC67 (already defeated) is set
C $BEBC,15 BC/DE = the enemy's position and hit-box size; EXX for Robin's own
C $BED2,5 Refill the energy byte at $BF6F to max
C $BEDD,5 Mark the enemy defeated (set bit 6 of $BC67)
C $BECB,3 Bounding-box overlap test
C $BECF,3 Cycle every screen attribute's ink colour, 16 times
C $BED2,3 Energy level address
C $BED7,3 Draw the energy bar
C $BEDA,3 Print a kill-count message, increment the counter and its displayed digit
c $BEE3 Bounding-box overlap test: |B-B'| < D and |C-C'| < E
N $BEE3 Compares one (B,C) position against another (B',C', in the shadow register pair via EXX) for closeness on both axes. Returns with carry set (RET NC not taken) only if both |B-B'| < D and |C-C'| < E, i.e. the two positions overlap within a D x E box. Used by #R$BDE0/#R$BE43/#R$BEB1 for guard/sword/door-guard collision checks.
C $BEE3,8 A = |B - B'| (X distance); compare against D, fail if too far
C $BEED,8 A = |C - C'| (Y distance); compare against E
c $BEF7 Cycle every screen attribute's ink colour, 16 times (screen-wide flash)
N $BEF7 Cancels any border-flash sound via #R$E00D, then repeats 16 times (E): scan all $0240 bytes of the real screen's attribute area at $5800, incrementing each byte's ink colour (low 3 bits) by one, wrapping via XOR with the paper/bright/flash bits.
C $BEF7,2 A = $04 (unused colour param)
C $BEFC,5 E = 16 passes; HL = attribute area at $5800
C $BF01,4 BC = $0240 bytes (the whole attribute area); save E
C $BF05,10 Increment this attribute byte's ink colour (low 3 bits), wrapping
C $BF0F,6 Advance to the next attribute byte, loop while BC is non-zero
C $BF15,4 Restore E, loop for the next pass until 16 are done
C $BEF9,3 Set the border-flash colour/count operands without flashing
c $BF1A Mark a hit guard as defeated
N $BF1A Called from #R$BD49/#R$BE43 with A = the hit guard's slot number (1-5, from their B loop counter) and IX -> its record. Unless A is 1 (the special enemy at #R$BBC1?), also sets bit 5 on a byte in the guard object table at ($C54C), indexed from A. Always sets bit 5 of (IX+4), the same "hit" flag tested elsewhere as bit 5 of the flags byte.
C $BF1A,4 A = 1 (special case): skip the guard-table update below
C $BF1E,17 Compute an index into the guard table at ($C54C) from A
c $BF37 Draw the energy bar
N $BF37 The energy display itself is a fixed pair of branching antlers drawn from the font glyphs at #R$AF0B/#R$AF83 (15 static glyphs each, forming the upper/lower halves); this routine doesn't draw them, it recolours a 63-byte attribute row at $5A40 from the energy value at $BF6F ($00-$0F, split into an ink/paper-ish bit pattern), so the antler artwork itself never changes shape - only its colour reflects the current energy level.
C $BF37,16 A = a colour byte packed from the energy value's low 3 bits and bit 3
C $BF37,3 Energy value -> bar length (bits 0-2) and low/high half flag (bit 6)
C $BF47,9 Fill $3F bytes of bar attributes at $5A40
C $BF37,3 get Energy level
C $BF3E,3 get Energy level
c $BF54 Border-flash sound with rising pitch (B = starting/growing delay)
N $BF54 Same border-toggle technique as #R$D9E9/#R$BD84, but the inner busy-wait length is B itself, which increments every outer pass (until bit 7 sets, i.e. B reaches 128) - giving a rising-pitch effect rather than a fixed tone.
C $BF54,3 A = 0; save AF/BC
C $BF57,4 Inner busy-wait of length B
C $BF5B,4 Toggle the border colour
C $BF5F,5 B grows every pass; stop once bit 7 is set
b $BF67
B $BF6F,1 Energy level
c $BF70 START point after game loading
C $BF71,3 set initial stack pointer
C $BF74,3 Menu procedure, return on game start
C $BF77,2 Geme started =>
c $BF79 Reset the stack and re-enter the menu procedure at $CD89
C $BF79,1 Disable interrupts
c $BF80 Main per-frame game loop
N $BF80 Called once per frame from the game's top level. Enables interrupts, then in turn: checks for a menu key via #R$C53B (falling back to #R$BF79 if pressed), moves Robin via #R$C6A2, steps the arrow (#R$BCC2) and every guard/enemy (#R$AA31/#R$DBF8/#R$BBC1/#R$B919), runs all the collision/hit checks (#R$BD49/#R$BDA3/#R$BDE0/#R$BE43), flushes the changed screen cells (#R$C85C), scans event triggers (#R$D7F3/#R$DF03), draws HUD elements (#R$C055/#R$C4D2), then checks whether Robin's screen position has reached a room edge and, if so, scrolls to the adjacent room via #R$C22F.
C $BF81,3 Check the Space and Caps-Shift keyboard rows, return the state in carry
C $BF84,3 => Reset the stack and re-enter the menu procedure at $CD89
C $BF87,3 Update Robin
C $BF8A,3 Step the arrow one pixel along its diagonal flight, drawing it
C $BF8D,3 Update a patrolling enemy's direction/animation state
C $BF90,3 Cycle through and step one door/exit guard object per call
C $BF93,3 Check an arrow hit against nearby guards, then a border-flash sound
C $BF96,3 Check Robin against up to 3 room hotspots at $BF69
C $BF99,3 Check Robin against the door-guard table ($DD05) for a bump
C $BF9C,3 Check a sword swing against nearby guards
C $BF9F,3 Trigger the scripted ambush when Robin reaches the target room's centre
C $BFA2,3 Update the object at $BC59
C $BFA5,3 Update a special enemy
C $BFA8,3 Defeat the special enemy
C $BFAB,3 Flush changed character cells from the $E500 buffer to the real screen
C $BFAE,3 Scan the message/sound trigger table at $D57A for Robin's position
C $BFB1,3 Show the victory message and return to the menu
C $BFB4,3 Redraw the room when a special-event extra frame is armed
C $BFB7,3 Special-scenario check
C $BFEF,3 Move to an adjacent room on the 16x20 world map, by direction bits in E
C $BFFE,3 Print an edge-of-map message and side-wipe back
C $C014,3 Menu select
C $C021,3 => Reset the stack and re-enter the menu procedure at $CD89
C $C02A,3 Clear the shadow screen
C $C02D,3 Draw current room on the shadow screen
C $C030,3 Draw a scenario-specific token in one of the 3 random opening rooms
C $C033,3 In room $BB, recolour any non-black attribute cell to $04
C $C036,3 Look up current room number in the $C550 table
C $C039,3 Print a hint message for certain single-column rooms
C $C03D,3 Handle room entry
C $C040,3 Room entry
C $C043,3 Copy all shadow attributes to the real screen
C $C046,3 Expand the $FE00 row-pointer table into shadow-screen rows
C $C04F,3 Check for a special-event room, set up its trigger if entered
c $C055 Show the victory message and return to the menu
N $C055 Only acts once bit 7 of the kill-count byte at $D5A4 is set (a "game complete" flag), and only on the specific animation frame $3C. Prints a fixed victory message, calls #R$8A7E, then resets to the menu via #R$BF79.
C $C055,6 Bail out unless the "game complete" flag (bit 7 of $D5A4) is set
C $C05B,6 Bail out unless Robin's current frame is $3C
C $C069,3 Print the string at the address pointed to by
C $C06C,3 Menu select
C $C06F,3 => Reset the stack and re-enter the menu procedure at $CD89
c $C072 Draw current room on the shadow screen
C $C075,3 Set room types block base address
C $C07B,3 World map address
C $C07F,1 get room byte
C $C096,3 Draw given room type on the shadow screen
C $C0AA,3 Draw given room type on the shadow screen
c $C0AF Draw given room type on the shadow screen
C $C0AF,3 Skip forward to the ($C547)-th descriptor in the table at
C $C0B2,1 get length
C $C0B4,2 zero => end, return
C $C0C8,3 Draw one block token onto the shadow screen, with mirroring
c $C0D1 Draw one block token onto the shadow screen, with mirroring
N $C0D1 A = block number (bit 7 = horizontal-mirror flag), C = packed screen coordinate byte (see #R$79F9 token format). Looks up the block's data address (see #R$5BA8 for its header-byte format) in the table at #R$5B00, draws (header AND $1F) x 8 pixel rows (4 bytes/row) into #R$EB00, then (header AND $7) attribute rows (4 bytes/row, or a single byte reused if the header's flat-attribute flag is set) into $E800, adjusting X for mirrored blocks along the way.
C $C0D1,22 DE = block data address from #R$5B00; detect the mirror flag via XOR
C $C0EE,3 Horizontally mirror a block's rows using the bit-reverse table at $FD00
C $C0E9,5 Mirror flag set: call #R$C1D6 to flip the block's pixel/attribute data
C $C0F1,1 Restore DE after the mirror call
C $C0F3,7 Header byte AND $07 = attribute row count, patched into #R$C14D's operand
C $C0FA,13 HL = pixel address in #R$EB00 from the coordinate byte in C
C $C107,6 DE = row stride ($0020); HL/DE = pixel dest/source (via EXX+stack)
C $C10D,8 Header AND $1F, x8 (via RLCA x3/AND $F8) = pixel row count in C
C $C115,16 Copy 4 bytes per pixel row, C rows total
C $C125,9 Header bit 6 set -> flat-attribute flag (A=$00), else A=$13
C $C12E,3 Patch the attribute loop's INC DE with A (enables/disables advance)
C $C131,22 Compute the shadow attribute address from the pixel address
C $C147,3 BC = shadow attribute area base ($E800)
C $C14A,20 Copy the block's attribute rows into the shadow attribute area
C $C0E7,2 !!MUT-ARG!! current room byte
c $C15E Draw a scenario-specific token in one of the 3 random opening rooms
N $C15E Compares the current room ($C548) against the three room numbers picked at random game start by #R$CF71 ($D3B2/$D3B4/$D3B6). If it matches one, draws a token from the corresponding fixed table ($C56A/$C573/$C57C) via #R$C0B2 (the token-drawing core shared with #R$C0AF).
C $C15E,7 HL = current room; compare to the first scenario room ($D3B2)
C $C16B,9 Compare to the second scenario room ($D3B4)
C $C175,7 Compare to the third scenario room ($D3B6); no match -> return
c $C18E Copy all shadow attributes to the real screen (18 rows x 28 bytes)
N $C18E Unconditionally blits the shadow attribute area at $E802 to the real screen attributes at $5802 (18 rows, 28 bytes each, skipping the leftmost/rightmost margins), clearing bit 7 of each byte as it copies.
C $C18E,11 HL/DE = shadow/real attribute bases; C = row stride ($04); IXl = 18 rows
C $C199,10 B = 28 bytes per row; copy, clearing bit 7 (flash)
C $C1A3,8 Skip the margin bytes on both source and destination
b $C1AC
c $C1C1 Skip forward to the ($C547)-th descriptor in the table at ($C54A)
N $C1C1 Called from #R$C0AF. Room-type and additional-element descriptors (#R$7B39/#R$8511) are variable length (a token-count byte + 2 bytes per token), so reaching descriptor index $C547 means walking past that many earlier ones: each is skipped by 2*count+1 bytes, computed from its own count byte.
C $C1C1,12 HL -> the descriptor table; bail out if the index ($C547) is 0; B = index
C $C1CD,6 Skip this descriptor: DE = 2 x its token count + 1
c $C1D6 Horizontally mirror a block's rows using the bit-reverse table at $FD00
N $C1D6 Called by #R$C0D1 when a block's mirror flag is set. Bit-reverses each pixel byte via a table lookup at $FD00 (self-modifying the low address byte of "LD A,($FD00)" with the source byte first), swapping bytes from the left and right ends of each row inward. The first pass (up to $C20A) does this for the pixel rows (row count from the block length in A); if bit 6 of the saved flag byte is clear, a second pass (from #R$C213) mirrors the attribute row the same way.
C $C1D6,5 Flip the block's own mirror-flag bit in its header byte
C $C1EC,22 Bit-reverse and swap one pair of pixel bytes (left <-> right)
C $C20B,8 Bit 6 of the saved flag clear: also mirror the attribute row below
C $C215,14 Swap one pair of attribute bytes (left <-> right), no bit-reverse
b $C228
c $C22F Move to an adjacent room on the 16x20 world map, by direction bits in E
N $C22F E bit 0/1 = step right/left (column, wrapping within 0-15 via the AND $0F on the nibble), bit 2/3 = step down/up (row H, clamped/wrapped within 0-19 to match the #R$79F9 map size). Packs the new row/column back into the 16-bit room number at $C548 (high nibble = column, rest = row - see #R$79F9).
C $C22F,6 HL = current room x16 (room number's column nibble x $10)
C $C255,10 Row -1 with wraparound to the last row ($13)
C $C25F,22 Repack row/column into the 16-bit room number, save to $C548
c $C276 Handle room entry: init guards on a room change, else blink a digit
N $C276 Compares the current room ($C548) to the last-drawn room ($D3B8/#R$C54C-relative). If unchanged, just blinks one room-indicator digit cell on the shadow screen. If the room changed: sets up Robin's object record at $B8FB (position/frame via #R$C8F7), clears and re-initialises the 4-guard table at #R$AC13 from the room's block flags (bits 4/7 of the map block select which movement-table pair each guard starts with, mirroring #R$AA31's own logic), calls #R$AA31 once per guard, and rebuilds a second 4-entry table at $DD05 from door/exit data at $DD3F. Also resets several per-room state bytes ($BF67.., $BC5D, $BBC2, $BBA0, $BB91, $AC43) and a second special object at $CC7C.
C $C27D,3 Compute an address in the 12-byte-stride table at $8A39
C $C294,3 Compute an address in the 12-byte-stride table at $8A39
C $C2FA,7 Look up the special-room flag (bit 7) for the current room in $79F9
C $C312,3 Advance an object's animation, unlink it from the list if done
C $C323,3 Reset the guard-state working copy
C $C32C,3 Reset the guard-state working copy
C $C331,3 Reset the guard-state working copy
C $C334,3 Update each guard's route-availability flags for the current room
C $C337,6 IX -> guard table at $AC13; HL -> room block's flag bytes
C $C342,4 Clear this guard's redraw flags before picking a starting state
C $C346,13 Bit 4 of the block set: guard starts "away", direction table $AC7F
C $C353,14 Otherwise bit 7 of the block picks between two direction tables
C $C374,3 Update a patrolling enemy's direction/animation state
C $C3F6,3 Advance an object's animation, unlink it from the list if done
c $C3FA Compute an address in the 12-byte-stride table at $8A39
N $C3FA Extracts bits 4-5 of A (0-3) and returns HL = that index x 12 + $8A39. Called from #R$C276 while setting up the score/room-indicator digit blink.
C $C3FA,6 A bits 4-5 -> HL (0-3)
C $C403,9 HL = index x 12
c $C40E Look up current room number in the $C550 table
N $C40E Returns immediately if the room number's high byte is non-zero (rooms $0100+ never match). Otherwise scans the 26 bytes at #R$C550 for the room's low byte; on a match, recolours the shadow attribute area $E800..$E9FF.
C $C414,5 Search table at $C550 for current room number
C $C421,3 HL = attribute area, BC = $0200 bytes to scan
c $C444 In room $BB, recolour any non-black attribute cell to $04
N $C444 Only acts in room $BB. Scans the whole shadow attribute area ($E800, $0240 bytes) and forces any cell with a non-zero paper colour (bits 3-5) to attribute $04, flattening the room's background colour.
C $C444,10 Only run in room $BB
C $C44E,6 HL/BC = the shadow attribute area
C $C454,7 If this cell's paper colour is non-zero, force it to $04
c $C462 Print a hint message for certain single-column rooms
N $C462 Only runs for single-column rooms ($C549=0). If the flag at $D59F is clear and the stage counter $D5A1 hasn't reached 3, checks whether the room is $65 or $6E and prints message $4E with a room-specific attribute (DE). Otherwise (or once those conditions no longer hold) checks rooms $79/$BB (also gated by $D5A1) and prints message $4D the same way; if the room is $6E, instead calls #R$C4B6.
C $C462,5 Only run for single-column rooms ($C549 = 0)
C $C467,6 Skip ahead if the flag at $D59F is set
C $C46D,7 Skip ahead if the "stage 3" counter $D5A1 has been reached
C $C474,7 B = message $4E; check for room $65
C $C47B,11 DE = the attribute for room $65, or $6E otherwise
C $C486,4 Save the attribute; print the message next
C $C48E,7 B = message $4D; check the stage counter again
C $C495,5 Check for room $79 (only relevant at stage 3)
C $C49A,5 DE = the attribute for room $79
C $C49F,2 Room $79 confirmed: print the message
C $C4A1,7 Otherwise: default attribute; check for room $BB
C $C48A,3 Print message number A, positioned from the $D7CE table
C $C4AC,3 Print message number A, positioned from the $D7CE table
C $C4B2,3 Clear the $D59F trigger flag, reset the room-position log, print a message
c $C4B6 Clear the $D59F trigger flag, reset the room-position log, print a message
N $C4B6 Called from #R$C462/#R$C517. If the flag at $D59F is set, clears it, re-seeds the room-position log at $D543 via #R$D454, and prints a fixed message ($B52D).
C $C4B6,9 HL -> the trigger flag at $D59F; skip if it's already clear
C $C4BF,5 Clear the flag
C $C4C4,3 Hard-code the first two entries of the room-position log at $D543
C $C4CC,3 Print the string at the address pointed to by
c $C4D2 Redraw the room when a special-event extra frame is armed
N $C4D2 Calls the extra-frame callback at ($C4D3) (a no-op by default, from #R$DB17, or armed by #R$DA0F for special-event rooms). If it reports one of two extra-frame states, patches a different starting room offset into $C548 and fully redraws the room ($D03F/$C072/$C15E/$C40E/$C517/$D5A7/$C18E/$C806), redraws the score digit (#R$C276), and clears the $E500 buffer.
C $C4D2,3 No-op default for the extra room-draw callback at
C $C4ED,3 Clear the shadow screen
C $C4F0,3 Draw current room on the shadow screen
C $C4F3,3 Draw a scenario-specific token in one of the 3 random opening rooms
C $C4F6,3 Look up current room number in the $C550 table
C $C4F9,3 Column-by-column full-screen wipe/reveal transition
C $C4FC,3 Room entry
C $C4FF,3 Copy all shadow attributes to the real screen
C $C502,3 Expand the $FE00 row-pointer table into shadow-screen rows
C $C50C,3 Handle room entry
C $C510,3 Clear E500 area
c $C517 Column-by-column full-screen wipe/reveal transition
N $C517 For each screen column A ($00..$3E), marks it dirty (SET 0,(HL), HL stepping by $001F through the $E500-based flag area, up to 18 rows) and flushes it to the real screen via #R$C85C, giving a left-to-right wipe effect; finishes by calling #R$C4B6. The exact flag-area row stride ($1F here vs $1C used elsewhere) is not fully reconciled.
C $C517,4 DE = row stride ($1F); A = starting column (0)
C $C51B,7 B = row count, capped at 18 (else use A's own value)
C $C522,9 HL -> the flag byte for this column/row; mark it dirty per row
C $C52B,2 Save AF/DE around the flush
C $C532,5 Advance to the next column; loop until column $3E is done
C $C52D,3 Flush changed character cells from the $E500 buffer to the real screen
C $C537,3 Clear the $D59F trigger flag, reset the room-position log, print a message
c $C53B Check the Space and Caps-Shift keyboard rows, return the state in carry
N $C53B Called from #R$BF80 once per frame; #R$BF80 resets to the menu (#R$BF79) when this returns with carry clear. Reads row $7FFE (Space/M/N/B/Sym) first, returning immediately (carry set) if its bit 0 (Space) is pressed; otherwise reads row $FEFE (Caps Shift/Z/X/C/V) and returns its bit 0 in carry. Which specific key combination triggers the menu reset is not fully confirmed.
C $C53B,6 Read the Space row ($7FFE); return early if Space is pressed
C $C541,5 Read the Caps-Shift row ($FEFE); return its bit 0 in carry
b $C547
B $C547,1 Descriptor index: room type $00..$26 when $C54A points at #R$7B39, room number $00..$FF when it points at #R$8511
W $C548,2 Current room number, $0000..$013D (index into the world map at #R$79F9)
W $C54A,2 Descriptor table base address: #R$7B39 (room types) or #R$8511 (additional elements)
t $C550
b $C558
t $C559
b $C55F
t $C577
b $C57C
t $C580
b $C584
c $C585 Set up a glyph draw: pick branch targets, compute screen row/column
N $C585 Called from #R$C6D6 while drawing a sprite frame's glyph/mask. (HL) gives a width-class nibble (compared against $04) that selects which pair of constants get patched into three self-modified branch sites ($C603/$C5E3/$C647, consumed by #R$C5E4); bit 7 of (HL) sets/clears another patch byte at $C651. B/C on entry give a row/column, converted to a shadow-screen address at #R$EB00, before falling into the pixel-plot loop at #R$C5E4/#R$C5D8.
C $C585,7 E = saved parameter; check the glyph's width class in (HL)
C $C58D,15 Width class < 4: patch $00 (skip) into the three branch sites
C $C59C,15 Width class >= 4: patch $06/$07/$08 into the three branch sites
C $C5AB,10 Bit 7 of (HL) selects the patch value written to $C651
C $C5B5,35 HL -> next glyph data byte; compute the shadow-screen row/column address
c $C5E4 Glyph pixel-row draw loop (continues the routine at #R$C585)
N $C5E4 Split from #R$C585 by the disassembler even though it's one routine: #R$C585 sets up self-modified branch targets (patched bytes at $C603/$C5E3/$C647, chosen from the glyph width nibble at (HL)) and jumps here; this block does the actual row lookup and XOR-plot of glyph pixels into $E500-relative screen data using the bit-reverse table at $FD00 (as in #R$C1D6/#R$C6D6), then loops back into #R$C585's counters via #R$C5D8/#R$C5DB. The exact meaning of each self-modified branch is not fully confirmed.
C $C5E4,4 HL -> character code entry in a lookup table at $C682
C $C5EB,5 HL -> glyph data pointer, from the base saved at $C6A0
C $C5FA,7 HL = font data address for this glyph (table at $9AB3)
C $C607,8 XOR-plot one bit-reversed pixel byte, advance L by $20 per row
c $C648 Merge one glyph attribute cell onto the screen, advance to the next
N $C648 Continues the glyph-draw routine at #R$C585/#R$C5E4 (loops back into it via #R$C640). Only copies the source attribute byte from the table at $C682 over the destination at (DE) when the destination is currently blank, so glyphs blend into existing scenery rather than overwriting it; then advances DE to the next character cell, wrapping to the next row every 32 columns.
C $C648,7 HL -> this character's attribute byte in the table at $C682
C $C656,9 Copy the source attribute over (DE) only if it's currently blank
C $C65F,12 DE = next screen cell; wrap to the next attribute row every 32 columns
b $C682
c $C6A2 Update Robin: move, pick action, advance animation
N $C6A2 Called once per frame from #R$BF80. Runs every other frame (toggle at $C6A3), unless Robin is mid-animation ($CC7A/$CC7B non-zero, forcing every frame). Calls #R$C95A to move him, #R$C9E7 to pick his sword/arrow/walk action, then sets his object record's redraw flags (IX = $CC7C) and calls #R$C8F7 to advance/redraw his frame.
C $C6A2,6 Toggle a run-every-other-frame flag at $C6A3
C $C6AA,12 Unless mid-animation, force this frame's run regardless of the toggle
C $C6C0,12 IX -> Robin's own object record; set its redraw flags
C $C6BA,3 Filter the movement direction bits against collisions, move the player
C $C6BD,3 Robin's action dispatcher
C $C6D2,3 Advance an object's animation, unlink it from the list if done
c $C6D6 Draw a sprite frame onto the shadow screen, XORed
N $C6D6 A = frame number, doubled to index a pointer table (base patched into the LD HL,$0000 at $C6D7 by the caller). Frame data holds a pointer to font glyph data (drawn via #R$C585/#R$C790/#R$C8B7), a height in IYl, and per-row (position, length, source) tuples applied at #R$C723 by XORing bytes into the shadow screen at #R$EB00.
C $C6D6,4 A -> pointer table entry -> frame data address in HL
C $C6E4,6 Set up a glyph draw
C $C6EA,3 Horizontally mirror a sprite frame's row data
C $C6ED,9 IYl = frame height (row count); stash the two saved data pointers
C $C6F6,14 Compute column bits, patch an early-exit RET into a copy at $C74F
C $C723,7 EDCB = one row's (position,length,source) tuple; call the shift helper
C $C72A,3 Shift the 32-bit value E:D:C:B right by 8 bits
C $C72E,15 XOR the row's source bytes onto the shadow screen at (HL)
c $C74D Shift the 32-bit value E:D:C:B right by 8 bits
N $C74D Called once per row from #R$C6D6's plot loop with EDCB = the row's (position,length,source) tuple. Always shifts by a fixed 8 bits (32 RR passes through the carry chain E->D->C->B), rather than by a variable column-bit count; exact purpose within the plot loop is not fully confirmed.
c $C790 Save the background under a sprite frame to the buffer at $E500
N $C790 Called from #R$C6D6 while setting up a sprite frame. (HL) supplies width/height nibbles and a flag byte (bit 7/6 select self-modified skip logic at $C7F0/$C7FB for mirrored frames); a pointer table at $8E12 (indexed by the flag byte) gives the screen block to copy row by row into the save-buffer at $E500, so the original background can later be restored when the sprite moves or is erased.
C $C794,10 C = column, clamped to a minimum of $10 then reduced by 8
C $C79E,9 E = 4 (rows); HL -> the frame's width/height byte
C $C7A7,9 Bail out if width class is 0; else D = width, +1 if column is off-grid
C $C7B0,10 HL -> the frame's flag byte; L = its low 7 bits (flag/skip index)
C $C7BA,13 Bit 7 of the flag -> a skip value patched into $C7F0
C $C7C7,37 HL = source screen address from the table at $8E12
C $C7EC,21 Copy one row (E bytes) from (BC) to the buffer, D rows total
c $C806 Expand the $FE00 row-pointer table into shadow-screen rows
N $C806 IX walks the row-pointer table at $FE00 (also used by #R$CE81/#R$C85C), HL walks the shadow area from $EAFE. For each of 18 rows, copies 32 bytes from the address stored at (IX+0/1)+2 to (HL), advancing both by one row's stride. The overall purpose (what these rows represent - likely per-row attribute or pixel data assembled during room drawing) is not fully confirmed.
C $C806,10 HL/IX = destination/source-pointer-table bases; BC = row/byte counter
C $C814,12 DE = row source address (from the pointer table, +2); copy 32 bytes
C $C810,4 Advance HL to the next destination row (skip a 4-byte gap)
C $C820,60 32 LDI copies (one row); loop via BC's parity until all rows are done
c $C85C Flush changed character cells from the $E500 buffer to the real screen
N $C85C Scans the $0300-byte flag area at $E502 (28 flag bytes per row x 18 rows, IXl counts rows) for a non-zero "changed" marker. For each one found, computes the real Spectrum screen pixel address ($4000-region) from the cell's row/column and copies its 8-byte glyph from the shadow buffer at $EB00+$8D00 onto the screen, then clears the flag and continues scanning.
C $C85C,6 HL -> flag area at $E502; IXl = 18 rows to scan
C $C876,13 Clear the flag; HL,DE step toward the real-screen address ($5800 attrs)
C $C88B,25 Standard ZX pixel-address formula: row/column (HL) -> screen byte
C $C8A4,11 BC = 8 rows, $20 stride; copy the glyph row by row to the screen
c $C8B7 Horizontally mirror a sprite frame's row data (companion to #R$C1D6)
N $C8B7 Called from #R$C6D6 after the width/height header is read. If the frame's mirror-flag bit (bit 7 of the header byte) differs from the last-drawn state, flips the stored flag and bit-reverses each row's 3 data bytes via the table at $FD00 (same technique as #R$C1D6), swapping the two ends of each row's tuple so the frame draws flipped.
C $C8B7,16 Bail out unless the mirror flag changed; flip it and note the height
C $C8C7,9 DE -> the tuple's second half; B = 0 (loop count placeholder)
C $C8D0,27 Bit-reverse and swap one row's (position,length,source) tuple
C $C8EB,12 Advance to the next row's tuple; loop while IYl (height) remains
c $C8F7 Advance an object's animation, unlink it from the list if done
N $C8F7 IX -> object record. Does nothing unless (IX+4) bit 0 is set. Then a countdown byte at IX is decremented; on reaching -1, the record is spliced out of its linked list (the next record's link is copied over this one, with a $FF marker handled as end-of-list). A status byte's bit 1, if set, redraws the current frame via #R$C6D6 to erase it; bit 2, if set, advances to the next frame and redraws it the same way.
C $C8F7,7 Nothing to do unless (IX+4) bit 0 (animated) is set
C $C900,11 Decrement the countdown byte at IX; if not -1, skip the unlink below
C $C90B,31 Splice this record out of the list ($FF next-link = end-of-list)
C $C92A,14 Status byte bit 1: erase the current frame
C $C93C,26 Status byte bit 2: advance to the next frame, ready to redraw
C $C938,3 Draw a sprite frame onto the shadow screen, XORed
C $C956,3 Draw a sprite frame onto the shadow screen, XORed
c $C95A Filter the movement direction bits against collisions, move the player
N $C95A Called from #R$C6A2. Reads the requested direction bitmask into E (bit 0 = right, bit 1 = left, bit 2 = down, bit 3 = up, matched to the DEC/INC pairs below) and combines it with the previous frame's bits at $CC8B, cancelling opposite-direction bit pairs. For each surviving bit it calls the matching collision check (#R$DD80/#R$DD6F/#R$DD9F/#R$DD93 - each tests attributes via #R$DDD6) and only then updates the player's pixel position at $CC85.
C $C95A,3 Dispatch to the active control scheme's input handler
C $C95D,10 C = requested direction bits; combine right/left with $CC8B's bits
C $C977,11 Combine down/up direction bits the same way
C $C98D,29 Combine the "action" bit the same way, then run collision checks
C $C9AA,5 E = final filtered direction bitmask, saved to $CC8B
C $C9AF,7 Skip movement entirely if $CC87 (state/mode) is $06 or more
C $C9BD,3 Collision check
C $C9C7,3 Collision check
C $C9D1,3 Collision check
C $C9DC,3 Collision check
c $C9E7 Robin's action dispatcher: pick sword/arrow frames, then jump by facing
N $C9E7 If Robin's animation code ($CC7B) is non-zero, waits for it to finish (or, for code $6E, calls #R$CB9D). Otherwise, if idle ($CC7A=0) and standing still and centred in a cell, picks between a sword attack (#R$CA44) or an arrow shot (#R$CA4C) based on the movement bits at $CC8B. Finally looks up a per-facing handler in the table at $CD42 (indexed by $CC87) and jumps to it with E = the movement bitmask ($CC8B).
C $C9E7,3 BC = default return address (pushed for the handler to RET to)
C $C9F3,3 Robin's critical-hit stagger
C $C9F9,3 Skip action selection unless idle ($CC7A = 0)
C $CA28,3 Sword-attack entry into #R$CA4C's frame-table picker
C $CA2D,3 Pick Robin's sprite frame table for his current action and facing
c $CA44 Sword-attack entry into #R$CA4C's frame-table picker
N $CA44 Called from #R$C9E7/#R$CB21 for a sword swing (as opposed to #R$CA4C's own entry, used for an arrow shot). Sets up the return address and E=1, then jumps into #R$CA4C at its #R$CA52 entry point to pick the actual frame table.
C $CA44,4 Push a return address; E = 1 (sword variant)
c $CA4C Pick Robin's sprite frame table for his current action and facing
N $CA4C D = facing bit (0/1, from the carry bit passed in via #R$CA44). If an arrow is in flight ($D59E/$D5A0 both non-zero), scans the guard object table at #R$AC13 (11 bytes/entry, same layout used by #R$AA31) for one within 50 pixels of Robin ($CC85) that isn't already flagged hit, and returns the "arrow" frame table; a hit guard's counter at $D5A0 is decremented and a message printed via #R$D619 when it reaches zero. Otherwise checks the sword flag at $D59D, then the movement bits at $CC8B, to choose between sword/attack, walk, or idle frame tables (at $CC9D/$CCA8, $CCB3/$CCBE, $CCDF/$CCEA, $CCC9/$CCD4).
C $CA4C,8 Set up the default return frame; D = facing bit
C $CA69,7 IX = guard object table at $AC13; BC = Robin's position
C $CA76,12 Skip inactive or already-hit guards (flag bits 0/5)
C $CA82,12 Distance from Robin's column; too far ($32+) means no block
C $CA8E,6 Advance IX to the next guard, loop 4 times
C $CA94,15 If found: decrement the "guards remaining" counter, maybe print a hint
C $CAA3,3 Print the string at the address pointed to by
c $CAEF Store Robin's frame pointer (HL, adjusted by facing) and facing byte (A)
N $CAEF Not reached by any direct CALL/JP - only via the small generated call/RET stubs at #R$CB11 and similar tables, which is why static analysis finds no caller. If facing bit 0 (E) is clear, HL is decremented first (selecting the mirrored half of a frame pair) before being stored to $CC7E, alongside the facing byte A at $CC87.
b $CAFB
c $CB11 Facing-direction table entry: call #R$CB21's handler
C $CB11,3 Per-direction handler
c $CB15 Facing-direction table entry: call #R$CB21's handler (another facing)
C $CB15,3 Per-direction handler
b $CB19
c $CB21 Per-direction handler: wait out the animation timer, then pick a frame
N $CB21 Reached (from #R$CB11/#R$CB15, part of the facing-direction table built in #R$C9E7) with the caller's stack already set up for a tail-call. While the animation timer at $CC7A hasn't reached 0, just unwinds and returns. Once it has: if the "action" bit (4) of the movement byte is set, dispatches to the sword/arrow pickers #R$CA44/#R$CA4C as in #R$C9E7; otherwise picks between a walking frame table ($CD13/$CCFE) or calls one of #R$CC13/#R$CC34 depending on the low movement bits and facing.
C $CB21,6 Decrement the animation timer; keep waiting until it reaches 0
C $CB3D,3 Sword-attack entry into #R$CA4C's frame-table picker
C $CB68,3 Timer still running: discard the caller's return address, return
C $CB41,3 Pick Robin's sprite frame table for his current action and facing
c $CB6B Pick a walking-frame table by movement bit (low nibble of A)
N $CB6B Part of the facing-direction dispatch chain from #R$C9E7/#R$CB21. Tests bits 0-3 of A (right/left/down/up) in turn and returns A = a small type code (2-5) with HL -> the matching frame table ($CCFC/$CD11/$CD26/$CD2D); returns with the stack popped and no result if no bit is set.
c $CB9D Robin's critical-hit stagger: penalise the counter, recover after a timer
N $CB9D Called from #R$C9E7's action code $6E - set by #R$BE25 when a hazard/guard hits Robin while his energy is already critical. Clears the animation timer and plays a short border-flash (not "evil laughter" - confirmed live/by ear that the laugh is reserved for the capture/ambush sequence at #R$B867, not this), penalises the kill counter at $D5A4 (2 decrements, offsetting #R$D91A's own increment to a net -1), arms a $001E recovery timer, and picks a facing-dependent recovery frame table/energy-cost pair ($CD34/$0F or $CD3B/$0E) before falling into #R$CBF7 to store it. Robin keeps playing afterwards - this is a stagger/penalty, not a game-over.
C $CBA2,3 Set the border-flash colour/count operands without flashing
C $CBAA,3 Print a kill-count message, increment the counter and its displayed digit
C $CBC4,3 => Store Robin's facing (A) and frame-table pointer
c $CBC7 Countdown to a pickup completion: refill energy when it reaches 0
N $CBC7 Decrements the animation timer at $CC7B; while non-zero, just returns (popping the caller). At 0, picks frame table $CD22 and falls into #R$CBE3 to refill Robin's energy.
b $CBD6
c $CBE3 Refill Robin's energy to maximum and redraw the bar
N $CBE3 Clears the $D1F1 timer, then (using the shadow AF'/register set) refills the energy byte at $BF6F to $0F and calls #R$BF37 to redraw the bar.
C $CBEC,3 Energy level address
C $CBF1,3 Draw the energy bar
c $CBF7 Store Robin's facing (A) and frame-table pointer (HL)
c $CBFE Direction dispatcher: pick a frame table or hand off, by low nibble of A
N $CBFE Another member of the facing-direction dispatch family (#R$CB6B/#R$CC1F/#R$CC52). Low nibble 0 falls to #R$CC13; else low 2 bits select frame table $CCF4 (A=3), a bare return, or fall to #R$CC3B.
c $CC1F Direction dispatcher: pick a walking frame or hand off by movement bits
N $CC1F Part of the facing-direction chain from #R$C9E7/#R$CB21. Low nibble of A: 0 falls to #R$CC34 (frame table $CD20); else low 2 bits select a fixed frame table $CCF8 (A=2), a bare return (A=2, popping the caller), or fall to #R$CC3B which re-tests E's bits 2/3 to hand off to #R$CB97/#R$CB91.
C $CC1F,5 Low nibble 0: fall to #R$CC34
C $CC24,4 Low 2 bits == 0: fall to #R$CC3B
C $CC28,4 Low 2 bits == 2: return to the caller's caller (pop and RET)
C $CC2C,5 Otherwise: type 2, frame table $CCF8
C $CC3B,5 Bit 2 of E set: hand off to #R$CB97
C $CC40,5 Bit 3 of E set: hand off to #R$CB91; else return to the caller's caller
c $CC47 Direction dispatcher: pick a diagonal frame table or hand off
N $CC47 Another member of the facing-direction dispatch family. Low nibble 0 falls to #R$CC73; else bit 2 of E hands off to #R$CB97, otherwise falls to #R$CC5B.
c $CC52 Direction dispatcher: pick a diagonal frame table or hand off
N $CC52 Part of the facing-direction chain from #R$C9E7 (reached via #R$CC47). Low nibble of A = 0 falls to #R$CC73 (a cached frame at $CC88/$CC89); else bit 3 of E hands off to #R$CB91. Otherwise tests E's bits 0/1 to pick between frame tables $CCFE (A=2) and $CD13 (A=3), or returns with no result if neither is set.
C $CC52,4 Low nibble 0: fall to #R$CC73
C $CC56,5 Bit 3 of E set: hand off to #R$CB91
C $CC5B,5 Bit 0 of E set: hand off to #R$CC67
C $CC60,5 Bit 1 of E set: hand off to #R$CC6D; else return to the caller's caller
C $CC67,5 Type 2, frame table $CCFE
C $CC6D,5 Type 3, frame table $CD13
C $CC73,6 Return the cached frame from $CC88/$CC89
b $CC7A
c $CD6C Menu procedure, return on game start
N $CD6C First plays the digitized "Will you help Robin..." speech via #R$8CAA, reading a bitstream at $E500 (confirmed live: genuine non-zero data during playback, 2-byte bit-count $1644 = 5700 bits followed by ~712 bytes of bitstream, $E500-$E7CE) - before the screen is cleared and the title/menu is drawn. The looping click heard continuously while the menu waits for a key is not a separate tune; it comes from #R$8AAF's key-decode loop, re-invoked every pass of the idle wait.
C $CD6C,2 Delay for sound procedure
C $CD7A,3 Play a sound effect encoded as a bit-per-border-flip stream
C $CD7D,3 Clear screen pixels
C $CD82,3 Clear screen attributes
C $CD86,3 Clear E500 area
C $CD89,3 Build the $FD00 bit-reverse lookup table
C $CD8C,3 Build the $FE00 table of the 192 real-screen pixel-row addresses
C $CD8F,3 Set up interrupt mode 2, pointing the ISR at #R$DFE7
C $CD92,3 Clear 32 screen rows using the row-pointer table at $FF40
C $CD95,3 Branched antlers, left part
C $CD98,3 Print string
C $CD9B,3 Branched antlers, right part
C $CD9E,3 Print string
C $CDA1,3 Ornament at the left side of the game screen
C $CDA4,3 Print string
C $CDA7,3 Ornament at the right side of the game screen
C $CDAA,3 Print string
C $CDAD,3 "(C) 1985  ODIN COMPUTER GRAPHICS"
C $CDB0,3 Print string
C $CDBC,3 Set the border-flash colour/count operands without flashing
C $CDC0,3 Draw the main menu items
C $CDC3,3 Menu select
C $CDE7,3 Read keys 1-4 to pick a menu option
C $CDEC,3 Clear 32 screen rows using the row-pointer table at $FF40
C $CE13,3 Stir the pseudorandom seed at $D38D using the R register
C $CE1B,3 Stir the pseudorandom seed at $D38D using the R register
C $CE21,3 Stir the pseudorandom seed at $D38D using the R register
C $CE2F,3 Randomly pick the game's starting room and opening state
C $CE32,3 Pick a random entry from the pointer table at $D3A2, save to $D3B8
C $CE35,3 Init the object at $BBC1/$BC59's state at game start
C $CE39,3 Clear the shadow screen
C $CE44,3 Print message number A, positioned from the $D7CE table
C $CE47,3 Side-wipe transition between the game screen and the Odin sign
C $CE4B,3 Clear the shadow screen
C $CE4E,3 Draw current room on the shadow screen
C $CE51,3 Draw a scenario-specific token in one of the 3 random opening rooms
C $CE54,3 Look up current room number in the $C550 table
C $CE57,3 New-game state init
C $CE5A,3 Room entry
C $CE5F,3 Handle room entry
C $CE62,3 Sound of evil laughter
C $CE65,3 Side-wipe transition between the game screen and the Odin sign
C $CE69,3 Clear E500 area
c $CE6D Stir the pseudorandom seed at $D38D using the R register
c $CE81 Side-wipe transition between the game screen and the Odin sign
N $CE81 Used by #R$CE47 to slide the screen open, revealing the Odin sign underneath. Copies columns from the two shadow screens a strip at a time, moving the boundary each pass, with border-colour stripes drawn via OUT ($FE),A while the copy runs.
C $CE81,15 Snapshot non-zero attributes to $E500, enable the LDIR/LDDR copies in #R$CE81
C $CE93,6 IY = row-pointer table base; A = outer pass count ($12)
C $CE99,7 IXh = inner row count ($08); border stripe colour from (IY+1)
C $CEAE,10 DE -> right-hand source; self-modified LDIR copies it into HL
C $CEF5,11 DE -> left-hand source; self-modified LDDR copies it into HL
C $CF06,4 Merge a screen byte in from beyond the current strip boundary
C $CF2E,6 Advance to the next table entry; loop while rows remain
C $CF44,3 Disable the LDIR/LDDR copies inside #R$CE81
c $CF4A Disable the LDIR/LDDR copies inside #R$CE81
c $CF4D Snapshot non-zero attributes to $E500, enable the LDIR/LDDR copies in #R$CE81
N $CF4D Copies the $E800..$EA3F attribute area into $E500, skipping zero bytes so old data shows through, then patches the opcode byte ($ED) at the four self-modified LDIR/LDDR sites inside #R$CE81 (called back once via #R$CF64, shared with #R$CF4A which patches $00 instead to disable them).
c $CF71 Randomly pick the game's starting room and opening state
N $CF71 Called from #R$CD6C when starting a new game. Uses the R register to roll one of 4 entries from each of three tables ($D38E bytes, $D392 pointer pairs, $D39A room-number pointers), storing them at $D3B2..$D3B6 and setting the starting room at $C548 - with a special-case swap when the rolled room's low byte is $9C.
C $CF71,11 Roll 0-3 from R; pick a byte from the table at $D38E
C $CF84,12 Roll one of 4 entries (step 2) from the pointer table at $D392
C $CF94,12 Roll one of 4 entries (step 2) from the room table at $D39A
c $CFB3 Pick a random entry from the pointer table at $D3A2, save to $D3B8
N $CFB3 Rolls a random even index 0-14 and reads the matching 2-byte pointer from the table at $D3A2 into $D3B8 (later compared against the current room, e.g. by #R$C276).
C $CFB6,2 Mask to an even value 0-14
C $CFB3,3 Stir the pseudorandom seed at $D38D using the R register
c $CFC7 Init the object at $BBC1/$BC59's state at game start
N $CFC7 Called from #R$CD6C. Sets the tracked target room to $D3B4 (the second scenario room picked by #R$CF71) and resets the object's timer/phase bytes ($BC68/$BC66/$BC67) and a flag at $BBF4.
C $CFC7,6 HL = target room ($D3B4); save to $BC64
C $CFCD,10 Reset the timer bytes at $BC68/$BC66
C $CFD7,4 Clear the "defeated" flag at $BC67
c $CFE1 Print string
R $CFE1 I:HL ??
C $CFE8,3 Print the string at the address pointed to by
c $CFEE Build the $FD00 bit-reverse lookup table
N $CFEE Called once from #R$CD6C at startup. For each byte C (0-255), bit-reverses it (8x RR E/RL D) and stores the result at $FD00+C - the table used throughout for horizontal mirroring (#R$C1D6, #R$C607, #R$C8D0).
C $CFEE,5 C = 0; HL -> the table at $FD00
C $CFF3,5 B = 8 bits; D:E accumulates the reversed byte
c $D004 Build the $FE00 table of the 192 real-screen pixel-row addresses
N $D004 Fills 192 entries (2 bytes each) at $FE00 with successive ZX Spectrum screen pixel-line addresses starting at $4000, using the standard non-linear third/row/scanline stepping (DE, incrementing through the low third then jumping between thirds every 8 lines). This table is what #R$C806/#R$CE81 index via IY/IX to reach real screen rows without recomputing the address each time.
C $D004,8 B = 192 rows; DE = $4000 (screen start); HL -> table at $FE00
C $D00C,4 Store this row's address, advance HL to the next table entry
C $D010,7 Step to the next scanline within the current third (add $0100)
c $D024 Clear screen pixels
c $D032 Clear screen attributes
R $D032 A Attribute value to fill in the screen
c $D03F Clear the shadow screen
R $D03F A Attribute value to fill in the shadow screen
N $D04B Clear shadow screen pixels
c $D059 Clear E500 area
c $D067 Clear 32 screen rows using the row-pointer table at $FF40
N $D067 Reads 32 successive 2-byte row addresses from the table at $FF40 (IY-indexed), and for each one clears $1F bytes starting one byte past the row start (LDIR from a zeroed first byte).
C $D067,6 IY -> the row-pointer table at $FF40; A = 32 rows
C $D06D,10 HL = this row's address; DE = HL+1
c $D085 Print an edge-of-map message and side-wipe back
N $D085 Called from #R$BF80 when Robin reaches the far edge of the world map. Prints a fixed message ($50) then plays the side-wipe transition (#R$CE81).
C $D085,1 A = 0
C $D086,3 Clear the shadow screen
C $D08E,3 Print message number A, positioned from the $D7CE table
C $D091,3 Side-wipe transition between the game screen and the Odin sign
c $D095 Set up interrupt mode 2, pointing the ISR at #R$DFE7
N $D095 Called once from #R$CD6C at startup. Sets IM 2 with I=$39 (a table of $FF bytes, standard IM2 trick), then writes a JP instruction ($C3) into the interrupt vector page at $FFF4, targeting #R$DFE7 (the interrupt-safe border-flash wrapper).
C $D095,5 DI; IM 2; A = $39
C $D09C,10 Patch $FFFF/$FFF4 with the JP opcode for the interrupt vector
C $D0A6,6 Point the interrupt vector's target at #R$DFE7
b $D0AD
c $D0CB Read keys 1-4 to pick a menu option (control scheme?)
N $D0CB Called from #R$CD6C. Reads keyboard row $F7FE (keys 1-5) and, via successive RRA/JR C tests, picks which of keys 1-4 is held (returning with no change if none is), setting A to the option index (0-3) and HL to a corresponding text address, then calls #R$D0FF and saves both to $AD32/$D275.
C $D0CB,5 BC = keyboard row $F7FE (keys 1-5); read it into A
C $D0D3,8 Redefine keyboard keys
C $D0DD,8 Key 2: option 1, text at $D1A2
C $D0E7,8 Key 3: option 2, text at $D1AB
C $D0F1,7 Key 4: option 3, text at $D1C4; else no key pressed, return
c $D0FF Redefine keyboard keys: prompt for and store 5 key choices
N $D0FF Draws the key-redefinition screen, then for each of 5 actions: prints a prompt, waits for a single keypress (#R$D140), stores the key code into the table at $D277 (used by the "user-defined keys" control scheme), looks up its display name via the table at $D27C, and prints it.
C $D0FF,2 A = $45 (screen number?)
C $D107,6 Print the instructions text at $D20B
C $D10D,8 DE -> the key-code table at $D277; HL -> the prompt list at $D22F
C $D115,3 Save loop state before printing this action's prompt
C $D101,3 Clear the shadow screen
C $D104,3 Side-wipe transition between the game screen and the Odin sign
C $D107,3 Data and messages to redefine keyboard keys
C $D10A,3 Print string
C $D118,3 Print string
C $D11B,3 Wait for all keys to be released
C $D11E,3 Wait until exactly one key is pressed, return its code in A
C $D135,3 Print string
c $D140 Wait until exactly one key is pressed, return its code in A
N $D140 Retries #R$D156 until it reports exactly one key down (not zero, not more than one), then returns that key's code in A.
C $D140,3 Scan the whole keyboard for exactly one key pressed, decode it
c $D14B Wait for all keys to be released
C $D14B,5 Read the "any key" port ($00FE); loop while any bit is set
c $D156 Scan the whole keyboard for exactly one key pressed, decode it
N $D156 Reads all 8 keyboard half-rows in turn (BC rotated via RLC B starting at $FEFE), counting pressed keys into D; if more than one key is down, fails (RET NZ). For the single row with a key down, bit-scans the column (via repeated SUB $08/SRL) to get a key index, combined with the row count in E into a single code returned in D. No key down at all also returns via the Z flag.
C $D156,6 DE = row countdown seed; BC = first keyboard row ($FEFE)
C $D15C,7 Read this row; low 5 bits (inverted) = pressed keys in it
C $D163,2 More than one row has a key down: fail
C $D165,2 H = this row's key bits; A = the row index (E)
C $D167,6 Bit-scan H for the pressed key's column, accumulating into A
c $D176 Test whether the key encoded in A is currently pressed
N $D176 A is a key code in the same row/column scheme decoded by #R$D156 (as stored by #R$D0FF into $D277 for the user-defined-keys control scheme). Rotates the keyboard row selector to the right half-row, reads that port, then rotates the result to bring the target key's bit into carry.
C $D176,11 Split A into a row-rotate count (B) and column position (C)
C $D181,6 C = 5 - column position; A = $FE (row selector)
C $D187,5 Rotate the row selector B times; read that keyboard row
C $D18C,2 Rotate the result C times to bring the key's bit into carry
c $D191 User-defined-keys control scheme: build the movement bitmask
N $D191 Reached via #R$D1E9's dispatch when the "user-defined keys" scheme is active. Tests each of the 8 key codes stored at $D277 (by #R$D0FF) via #R$D176, building an 8-bit direction/action mask E one bit at a time via the carry.
C $D191,5 HL -> the 8 stored key codes at $D277; E = 8 bits to build
C $D196,8 Test this key; shift its state into E
b $D1A2
c $D1E9 Dispatch to the active control scheme's input handler
N $D1E9 Called first from #R$C95A each frame. Pushes $D1F1 as the return address and jumps to the handler pointer at $D275 (set by #R$D0CB's control-scheme menu), which reads the player's chosen input device/keys and returns with a direction bitmask.
C $D1E9,7 Push a return address; jump to the handler at ($D275)
c $D1F1 Cancel opposite movement bit pairs in E, return the result in A
N $D1F1 The return address pushed by #R$D1E9: every control-scheme handler returns here. If both left+right (bits 0-1) are set, clears them both; same for both up+down (bits 2-3). Leaves the cleaned bitmask in A/E.
C $D1F1,9 If both left and right bits are set, clear them both
C $D1FE,7 Same for up and down (bits 2/3)
b $D20B Messages to redefine keyboard keys
B $D20B,2
T $D20D
B $D21D,1
T $D21E
B $D22E,1
T $D22F
B $D23B,1
T $D23F
B $D249,1
T $D24B
B $D257,1
T $D25B
B $D265,1
T $D267
B $D273,1
b $D274
t $D277
b $D27A
t $D27C
b $D294
t $D295
b $D2A4
b $D2C3 Branched antlers, left part
B $D2D4
B $D2D5
B $D2E4
B $D2E5
B $D2F4
B $D2F5
B $D304
b $D305 Branched antlers, right part
B $D318
B $D327
B $D329
B $D338
B $D339
B $D348
b $D349
T $D34B
s $D36B
t $D36C
s $D38C
t $D38E
b $D391
c $D3BB New-game state init: clear tables, spawn the initial extra guards
N $D3BB Called from #R$CD6C when starting a new game. Zeroes the 30-entry guard-spawn table at $D4B1 (5-byte stride), the 10 sword/arrow flag bytes at $D59D, and $BB9F; fills the 55-byte room-position log at $D543 with $FF (empty); zeroes the 8-byte event-status array at $D595; then runs the guard spawners at #R$D3F3/#R$D40A/#R$D42F and jumps to #R$D454 to seed the log's first two entries.
C $D3BB,9 A=0; B=30 entries, DE=5 (stride); zero the guard-spawn table at $D4B1
C $D3C8,5 B=10; zero the sword/arrow flag bytes at $D59D
C $D3D1,9 Zero $BB9F; A=$FF, B=$37; fill the room-position log at $D543
C $D3DE,5 B=8; zero the event-status array at $D595
C $D3E7,3 Spawn the initial guards at game start
C $D3F0,3 => Hard-code the first two entries of the room-position log at $D543
c $D3F3 Spawn the initial guards at game start (1 type-1 + 5 type-2)
N $D3F3 Called from #R$D3BB. Forces the very first slot of the table at $D4B1 to event type 1, then spawns 5 more guards of type 2 into free slots found by #R$D47D.
C $D3F3,5 Force slot 0 in the table at $D4B1 to type 1
C $D3F8,2 B = 5 more guards to spawn
C $D3FA,7 Find a free slot; write event type 2 there
C $D3FA,3 Find a free (zero) slot in the 30-entry, 5-byte-stride table at $D4B1
c $D402 Spawn a random number of extra guards (event types 5 and 7)
N $D402 Two near-identical halves, entered separately from #R$D3BB or in sequence from the top. Each rolls a random target count (R register, 6-9 or 8-11) into B, then while the running counter at $D5A2 (type 5) / $D5A3 (type 7) is below it, finds a free object slot via #R$D47D, writes the event type byte, and increments the counter. $D5A6 selects which half runs when entered from the top ($05 selects the first).
C $D402,6 Skip both halves if $D5A6 is $00; run the first half only if it's $05
C $D40A,10 Roll a random target count (6-9) into B
C $D41E,7 Loop: find a slot, write event type $05, bump the counter, repeat
C $D42F,10 Second half: roll a random target count (8-11) into B
C $D445,3 Find a free (zero) slot in the 30-entry, 5-byte-stride table at $D4B1
c $D454 Hard-code the first two entries of the room-position log at $D543
N $D454 Writes two fixed 5-byte entries (matching the format scanned by #R$D997/#R$D7F3) into the table at $D543: {$3D,$00,$30,$60,$06} and {$BB,$00,$58,$58,$06} - likely two permanent "always logged" room/position markers seeded before the table's normal terminator-search logic takes over.
c $D47D Find a free (zero) slot in the 30-entry, 5-byte-stride table at $D4B1
N $D47D Used by #R$D402/#R$D3F3 to find a spawn slot for an extra guard. Rolls a random start index 0-29 (R register, clamped below 30) into C, and scans forward from the matching entry in the table at $D4B1 for a zero byte, wrapping the index back to 0 after entry 29. Returns with DE pointing at the free slot (or with the zero flag set if it hit a genuinely empty entry immediately).
C $D47D,11 Roll a start index 0-29 from the R register
C $D488,11 DE -> the entry at that index in the table at $D4B1
b $D4AD
c $D5A7 Room entry: spawn guards, reset triggers, print room-specific messages
N $D5A7 Called on entering a room (from #R$BF80/#R$C4D2/#R$CD6C). Spawns extra guards via #R$D402, fills the 9-entry (3 bytes each) trigger table at $D57A with $FF, clears $DFE6, then scans the 30-entry table at $D4AD for the current room, printing an associated message via #R$D631 if found; finally scans the 11-entry room-position log at $D543 the same way, printing via #R$D631 if a match's message pointer/value is set.
C $D5AA,7 B = 27 bytes ($1B); A = $FF; fill the trigger table at $D57A
C $D5B9,11 B = 30 entries; HL -> the per-room message table at $D4AD
C $D5C4,6 Compare the current room to this entry's room number
C $D5D2,10 Room matches: check if the entry's message pointer is non-zero
C $D5DC,4 DE = the message number/pointer from the entry
C $D5E8,11 B = 11 entries; HL -> the room-position log at $D543
C $D5F3,6 Compare the current room to this entry's room number
C $D601,9 Room matches: load the entry's message data
C $D5A7,3 Spawn a random number of extra guards
C $D5E0,3 Print message number A, positioned from the $D7CE table
C $D60A,3 Print message number A, positioned from the $D7CE table
s $D617
c $D619 Print the string at the address pointed to by (HL)
C $D619,3 A = attribute/mode param
C $D61C,3 DE = string pointer taken from (HL)
C $D61F,13 Reset text-print state, then fall into the print core at #R$D661
c $D631 Print message number A, positioned from the $D7CE table
C $D631,10 A = message number; HL -> its entry in the table at $D7CE
C $D63B,9 BC = string address, from the table entry
C $D644,18 Reset print-state defaults; reload the saved attribute param
C $D656,11 Message $0E is a special case: also clears the flash-state flag
C $D661,12 HL = base screen row address (from A doubled); check the mirror flag
C $D66D,10 Mirrored: look up the row address in the table at $FE00 instead
C $D677,8 Non-mirrored: HL = $EB02 + row x16
C $D67F,12 Finish computing the column offset; reset loop state
C $D68B,2 C = 0 (loop counter)
C $D68F,28 Control codes $01/$02/$03 select alternate colour/attribute states
C $D6AF,3 Save registers before drawing a printable character
C $D6EE,7 Loop to the next character; DJNZ handles the 8-row glyph loop
C $D711,4 Wrap the row within the current third
C $D719,28 Bit 6/7 of the mode byte: set an "arrow" marker or skip ahead
C $D73F,47 Save the free-slot position found by #R$D735; compute its screen address
C $D771,9 Bit 5/7 of the mode byte select a sound-trigger record or #R$DE5D
C $D77D,81 Merge a sound-trigger record into the queue at $E500, advance columns
N $D631 A selects a message: bits 0-4 index the position/pointer table at #R$D7CE, giving the string address and screen column/row; the string itself is then printed by the shared core at #R$D661 (also entered from #R$D619).
R $D631 A Message number; bits 0-4 index the table at #R$D7CE
C $D68D,2 DE -> next character; $00 ends the string
C $D6AB,4 Only draw printable characters ($20 and up)
C $D6B2,3 Font start address
C $D6B5,11 HL -> this character's glyph data (8 bytes, char x 8 + base)
C $D6C0,17 Fetch the glyph byte (or a fixed pattern if $D7F0 is set)
C $D6D1,13 Merge the byte onto the screen cell, XORing an existing background
C $D6DE,16 Advance to the next screen column, wrapping to the next row
C $D6F5,28 String printed right-to-left; compute the message's pixel width
C $D715,4 String finished; clear the "in message" flag
C $D735,10 Find a free slot in the pending-sound table at $D57A
C $D76E,3 Second pass: DE -> next character to place on screen
C $D77A,3 => Copy the $001C-byte block at $E982 to $DECB
w $D7CE
W $D7CE,2 $00 - sword in Menu
W $D7DE,2 $08 - "0 START"
W $D7E0,2 $09 - "1 KEYBOARD"
W $D7E2,2 $0A - "2 KEMPSTON"
W $D7E4,2 $0B - "3 INTERFACE II"
W $D7E6,2 $0C - "4 CURSOR"
b $D7F0
c $D7F3 Scan the message/sound trigger table at $D57A for Robin's position
N $D7F3 Walks the (up to 9) 3-byte entries written by #R$D735 - filled in by the text printer when it meets a control character in a string. For the first non-$FF entry whose stored X/Y reference bytes bracket Robin's position ($CC85/$CC86, +$00..$10), reads a chained pointer back through the entry to print an associated message via #R$D619/#R$D631 and, for certain entry types, starts an arrow-hit countdown or a sound (#R$D9E9). Not every field of the entry format is confirmed.
C $D7F3,5 B = 9 entries to scan; HL = table at $D57A
C $D807,19 Check Robin's X position against the entry's X reference byte
C $D81A,14 Check Robin's Y position against the entry's Y reference byte
C $D828,11 Save the entry address; read its type byte and chained message pointer
C $D833,21 Entry type $07: start an arrow-hit countdown once, only the first time
C $D848,32 Pick a fixed message for entry types 0/3/6/7, else use the chained one
C $D86D,3 Print the string at the address pointed to by
C $D87A,3 Print message number A, positioned from the $D7CE table
c $D91A Print a kill-count message, increment the counter and its displayed digit
N $D91A Called from #R$BEB1/#R$CB9D on a guard kill. Unless the counter at $D5A4 is already at 9, prints a fixed message, increments the counter, converts it to an ASCII digit written into the text at $DA0B, and prints a second message containing it.
C $D91A,10 Bail out once the counter at $D5A4 reaches 9
C $D924,8 Set up the first message and its attribute
C $D92F,10 Increment the counter; convert it to an ASCII digit at $DA0B
C $D92C,3 Print the string at the address pointed to by
C $D941,3 => Print the string at the address pointed to by
c $D944 Play a sound and increment the trigger entry's counter
N $D944 Called from #R$D7F3 for a matched trigger. Plays the short border-flash sound (#R$D9E9, B = $64) then increments the byte at (HL) - the trigger entry's own count/type byte.
C $D944,5 B = $64 (sound length)
c $D94B Shift the recent-event byte queue at $D59B, print any matching hints
N $D94B Plays a short sound (#R$D9E9), then shifts 7 bytes down from $D59B..$D59C (a small history/queue) inserting the value at $D9F6 at the front. Scans the 8 two-byte pointer table at $D9F9 for one not equal to $FF; when found reads a message-address pair from the shifted queue and prints it via #R$D61F. Afterwards, if the value saved before the shift was $02, falls into #R$D997 to log the current room/position into the table at $D543.
C $D94B,5 B = $64 (sound length); play the short border-flash sound
C $D950,10 Save the byte at $D59C before the shift below
C $D95A,6 Shift 7 bytes down from $D59B into $D59C
C $D960,5 Insert the new value at $D9F6 at the front of the queue
C $D965,6 EXX; HL -> the 8-entry pointer table at $D9F9
C $D96B,7 EXX back; DE walks the shifted queue looking for a non-$FF value
C $D972,16 Found: EXX back; DE = the queue's stored message-address pair
C $D982,16 Print the message, using an alternate text if the type was $05
C $D997,8 Search 11 entries (5 bytes each) at $D543 for an $FF,$FF terminator pair
C $D9AF,13 Log the current room and Robin's clamped position into the found slot
C $D9E9,11 Short border-flash sound: B outer loops x C inner busy-wait
C $D9E4,3 Print message number A, positioned from the $D7CE table
b $D9F5
c $DA0F Check for a special-event room, set up its trigger if entered
N $DA0F Scans the 9-entry room-address table at $DBCD for the current room ($C548/$C549); does nothing if not found or if $D595 is already $FF. On a match, copies a 15-byte pattern from $A44F into the attribute area near $588D (mirrored for the room's flip flag) and points the "extra frame" callback at $C4D3 (called from #R$C4D2) at $DA9E, arming a one-off special-room animation/effect. Exact meaning of the copied pattern and several flag bytes ($DBE7/$DBE8/$DBEA/$DBED) is not fully confirmed.
C $DA0F,11 Clear $DBEA; bail out if the "special events done" flag at $D595 is $FF
C $DA1A,5 B = 9 entries to scan in the table at $DBCD
C $DA1F,7 DE = this entry's room number; save it and compare to the current room
C $DA36,27 Room found: DE -> pattern data, flipped by the room's mirror flag
C $DA51,23 Copy a 15-byte pattern from $A44F into the attribute area at DE
C $DA68,51 Arm the extra-frame callback at $C4D3, set up flash/text parameters
C $DA9B,3 Set the border-flash colour/count operands without flashing
C $DAC6,3 Stir the pseudorandom seed at $D38D using the R register
c $DB17 No-op default for the extra room-draw callback at ($C4D3)
c $DB18 Resolve completed special-room events (arrow hits, energy refill)
N $DB18 Resets the ($C4D3) callback to the no-op at #R$DB17, then scans the 8-byte event-status array at $D595 (indices matching the table at $DA0F/$DBCD) for specific values: three occurrences of $05 or, failing that, a single $05/$02/other trigger one of a full-energy refill (#R$BF37), an arrow-hit decrement ($D5A5, paired with a scan for value $02), or setting $DBEA to select which extra frame #R$C4D2 draws. Finishes by calling #R$DB98 and choosing between $D1F1's two halves based on $DBEA/$DBED.
C $DB18,9 Reset the extra-frame callback at ($C4D3) to the no-op stub
C $DB2A,3 Remove the current event slot, shifting the remaining ones down
C $DB46,5 Event type $0F: refill energy to max
C $DB4B,3 Draw the energy bar
C $DB5A,3 Remove the current event slot, shifting the remaining ones down
C $DB6B,3 Print a status message for each of the 8 special-event slots
c $DB82 Remove the current event slot, shifting the remaining ones down
N $DB82 Called with HL -> an event byte within $D595 and B = bytes remaining after it. Shifts those bytes one position back (into DE, HL's copy), then writes an $FF terminator after the last one - removing the current slot from the array.
C $DB82,7 DE = the slot being removed; HL/B = the bytes after it
C $DB8B,6 Shift each remaining byte back by one position
C $DB91,7 Terminate the shifted array with $FF
c $DB98 Print a status message for each of the 8 special-event slots
N $DB98 For each of the 8 status bytes at $D595 (walked via DE from $D594), reads the matching message pointer from the table at $D9F9 (also used by #R$D94B) and picks between it and one of two fixed messages ($B548 for status $05, $B512 for status $02) before printing via #R$D61F.
C $DB98,7 DE = event-status array at $D594 (0-indexed via pre-increment)
C $DBA1,9 A = this slot's status byte; HL = its message pointer from $D9F9
b $DBCD
c $DBF8 Cycle through and step one door/exit guard object per call
N $DBF8 Every 4th call (counter at $DBF9), picks one of the room's guard-door entries from the table at $C54E (built by #R$C276 from $DD3F) and, if Robin ($CC85/$CC86) is within range, indexes IX into the matching entry of the object table at $DD05 (11 bytes/entry, built by #R$C276 too). From there the logic mirrors #R$BA85: (IX+9) is stepped by one toward the target position, wrapping past $70, and (IX+2/3)/(IX+4) are updated to pick a frame-pointer table (from $DD31/$DD38) and redraw via #R$C8F7.
C $DBF8,10 Every 4th call, pick one entry from the guard-door table at $C54E
C $DC02,8 Decrement the phase counter, resetting it to 4 when it hits 0
C $DC0A,15 IX -> matching entry in the object table at $DD05
C $DC19,2 Undo the earlier subtraction to restore HL
C $DC1F,13 Compare the guard's target column nibble to Robin's; bail if far
C $DC2C,53 Look up the guard's row/column reference in a table, indexed by room
C $DC61,35 Step the guard's position by one, wrapping at the $70 boundary
C $DC84,18 IX -> matching entry in the object table at $DD05 (by room row)
C $DC96,75 In range: compute the resolved position and pick a frame table
C $DCE1,3 Advance an object's animation, unlink it from the list if done
C $DCE4,7 Out of range: skip the position/frame update
C $DCEB,3 Advance an object's animation, unlink it from the list if done
C $DCEE,22 Pick a frame table for the "out of range" case, based on facing
b $DD05
c $DD6F Collision check: can Robin move left?
N $DD6F Only checks at cell boundaries (L bits 0-1 clear); converts HL to an attribute address via #R$DDD6, steps to the row above-left, and tests via #R$DDB1.
C $DD76,3 Convert HL pixel coordinates to a shadow attribute address
c $DD80 Collision check: can Robin move right?
N $DD80 Same as #R$DD6F but steps to the row above-right instead, testing via #R$DDB1.
C $DD87,3 Convert HL pixel coordinates to a shadow attribute address
c $DD93 Collision check: can Robin move up?
N $DD93 Only checks at cell boundaries (H bits 0-2 clear); converts HL to an attribute address via #R$DDD6 and tests the row above via #R$DDC5.
C $DD9A,3 Convert HL pixel coordinates to a shadow attribute address
c $DD9F Collision check: can Robin move down?
N $DD9F Same as #R$DD93 but steps down 3 rows first, testing via #R$DDC5.
C $DDA6,3 Convert HL pixel coordinates to a shadow attribute address
c $DDB1 Check 2 vertically-stepped attribute cells for a blocking tile
N $DDB1 (HL) -> a shadow attribute address (from #R$DDD6). Checks 2 cells, one screen row apart ($0020 stride), each testing bit 7 (solid) or a non-zero attribute (occupied); returns with A=0 (Z set) if both are clear, non-zero otherwise. Used by the vertical movement checks #R$DD6F/#R$DD80.
c $DDC5 Check 3 horizontally-stepped attribute cells for a blocking tile
N $DDC5 Same test as #R$DDB1 but for 3 adjacent cells in the same row (HL incrementing). Used by the horizontal movement checks #R$DD93/#R$DD9F.
c $DDD6 Convert HL pixel coordinates to a shadow attribute address
N $DDD6 Combines bits from H and L into an offset added to the shadow attribute area base at $E800.
c $DDF0 Update each guard's route-availability flags for the current room
N $DDF0 IX -> the 4-entry guard table at ($C54C) (set up by #R$C276). For each guard, finds the entry in the 28-byte-stride table at $DEAB matching the guard's home room nibble (IX+0), tests one of its 3 flag bytes via #R$DE51 (picked by IX+1 bits 0-1) and, if clear, scans up to 25 further bytes to find where the guard's route re-opens, packing the result back into (IX+1). Exact meaning of the per-route flag bytes is not confirmed.
C $DDF0,6 IX -> guard table at ($C54C); B = 4 guards
C $DDF7,6 HL = table base $DEAB; DE = $001C stride between entries
C $DE29,3 Test whether any of 3 consecutive bytes at (HL) is non-zero
C $DE31,3 Test whether any of 3 consecutive bytes at (HL) is non-zero
c $DE51 Test whether any of 3 consecutive bytes at (HL) is non-zero
c $DE5D Copy the $001C-byte block at $E982 to $DECB
c $DE69 Copy the $DEE7 template into $DECB (see #R$DE6E)
c $DE6E Copy a 28-byte template ($DEAF or, via #R$DE69, $DEE7) into $DECB
N $DE6E Both entries just pick a source template before falling into the same LDIR; DECB is the same buffer filled directly by #R$DE5D.
c $DE7A Blank the template at $DEAF (see #R$DE7F)
c $DE7F Blank a 27-byte template ($DEE7, or via #R$DE7A, $DEAF), keep byte 0
N $DE7F Both entries pick a template address before zeroing 27 bytes starting one byte in (byte 0 - a type/flag byte - is left untouched).
c $DE8D Reset the guard-state working copy: both templates blanked
C $DE8D,3 Blank the template at $DEAF
C $DE90,3 Blank a 27-byte template ($DEE7, or via #R$DE7A, $DEAF), keep byte 0
C $DE93,3 Copy the $001C-byte block at $E982 to $DECB
c $DE97 Reset the guard-state working copy: $DEE7 template, $DEAF blanked
C $DE97,3 Copy the $DEE7 template into $DECB
C $DE9A,3 Blank the template at $DEAF
C $DE9D,3 Copy the $001C-byte block at $E982 to $DECB
c $DEA1 Reset the guard-state working copy: $DEAF template, $DEE7 blanked
N $DEA1 #R$DE8D/#R$DE97/#R$DEA1 (called from #R$C276 based on the room's block flags) each pick a different combination of the two 28-byte templates at $DEAF/$DEE7 to write and blank, before refreshing the working copy at $DECB from $E982 via #R$DE5D.
C $DEA1,3 Copy a 28-byte template ($DEAF or, via #R$DE69, $DEE7) into $DECB
C $DEA4,3 Blank a 27-byte template ($DEE7, or via #R$DE7A, $DEAF), keep byte 0
C $DEA7,3 Copy the $001C-byte block at $E982 to $DECB
b $DEAB
c $DF03 Special-scenario check: count completed events, play the next stage
N $DF03 Only continues if Robin is in the designated scenario room (compared against $D3B2, set by #R$CF71) and the stage counter $D5A1 hasn't reached 3, and only fires once per frame (guarded by an R-register roll and a re-entry flag at $DFE6). Counts how many of the 8 event-status bytes at $D595 equal $02; once 3 or more are set, plays a border-flash cue and calls #R$DB98/decrements $D5A5, then prints one of several status messages depending on $D59D/$D59E (sword/arrow-related flags) and $D5A1, advances $D5A1, marks an attribute cell near the room's door ($588D/$5894), and (once per game) runs a long busy-wait delay. Exact narrative meaning of the stages is not confirmed.
C $DF03,10 Bail out unless Robin is in the designated scenario room
C $DF1E,13 Count how many of the 8 status bytes at $D595 equal $02
C $DF42,3 Remove the current event slot, shifting the remaining ones down
C $DF4D,3 Print a status message for each of the 8 special-event slots
C $DFAF,20 Mark the attribute cell by the room's door, flipped by the map flag
C $DF33,3 Set the border-flash colour/count operands without flashing
C $DF81,3 Print the string at the address pointed to by
C $DFAC,3 Print the string at the address pointed to by
s $DFE6
c $DFE7 Interrupt-safe wrapper around the border flash routine at #R$DFF4
C $DFEB,3 Flash the border colour
c $DFF4 Flash the border colour (self-modified colour/count)
C $DFF4,2 Colour operand patched in by the caller before CALL
C $DFF9,2 Delay-count operand patched in by the caller before CALL
C $E002,10 Busy-wait, then toggle border colour via OUT ($FE); repeat 10 times
c $E00D Set the border-flash colour/count operands without flashing
b $E016
b $E500
B $E500,576
b $E740
b $E800
B $E800,,32
b $EB00 Shadow screen, pixels, 144 lines by 32 bytes
B $EB00,,32
b $FD00
t $FEBD
b $FEC0
t $FEF5
b $FEF8
t $FF46
s $FF61
t $FF62
b $FF6E
t $FF8C
b $FF8F
t $FF94
b $FF97
t $FFA4
s $FFA7
t $FFA9
b $FFAF
b $FFF4
