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
b $659B Block $1C - Ent (top-left quarter)
B $659B,1,1
B $659C,128,8 #HTML[<img src="images/blocks/block1C.png" />]
b $662C Block $1D - Ent (top-right quarter)
B $662C,1,1
B $662D,128,8 #HTML[<img src="images/blocks/block1D.png" />]
b $66BD Block $1E - Ent (bottom-left quarter)
B $66BD,1,1
B $66BE,128,8 #HTML[<img src="images/blocks/block1E.png" />]
b $673F Block $1F - Ent (bottom-right quarter)
B $673F,1,1
B $6740,128,8 #HTML[<img src="images/blocks/block1F.png" />]
b $67C1 Block $20 - Split tree (top-left quarter)
B $67C1,1,1
B $67C2,128,8 #HTML[<img src="images/blocks/block20.png" />]
b $6852 Block $21 - Split tree (top-right quarter)
B $6852,1,1
B $6853,128,8 #HTML[<img src="images/blocks/block21.png" />]
b $68D4 Block $22 - Split tree (bottom-left quarter)
B $68D4,1,1
B $68D5,128,8 #HTML[<img src="images/blocks/block22.png" />]
b $6956 Block $23 - Split tree (bottom-right quarter)
B $6956,1,1
B $6957,128,8 #HTML[<img src="images/blocks/block23.png" />]
b $69D8 Block $24 - Hermit's hut (top-left quarter)
B $69D8,1,1
B $69D9,128,8 #HTML[<img src="images/blocks/block24.png" />]
b $6A5A Block $25 - Hermit's hut (top-right quarter)
B $6A5A,1,1
B $6A5B,128,8 #HTML[<img src="images/blocks/block25.png" />]
b $6ADC Block $26 - Hermit's hut (bottom-left quarter)
B $6ADC,1,1
B $6ADD,128,8 #HTML[<img src="images/blocks/block26.png" />]
b $6B6D Block $27 - Hermit's hut (bottom-right quarter)
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
N $79F9 One byte per room, indexed by the packed room number at $C548 (#R$C22F's row/column wrapping gives a 16x20 grid, matching the #R$C1C1-scanned descriptor tables). Bits 0-6 are a descriptor index: #R$C072 uses it into the room-type table #R$7B39 for every room, and additionally into the additional-elements table #R$8511 for rooms $00-$FF (see #R$8511's note - rooms $0100+ get base type only). Bit 7 is read twice for two different purposes: #R$C072 stashes it at $C0E8 (use not yet documented), and #R$C2FA reads the same bit directly as a "special room" flag.
B $79F9,,16 #HTML[<img src="images/minimap.png" />]
b $7B39 Room type descriptors
N $7B39 Room type $00 is the dedicated ambush-scene backdrop: all 7 distinct room numbers in #R$D3A2's table (rolled by #R$CFB3 for the Sheriff of Nottingham's scripted ambush) are type $00 - confirmed against the rendered room-type image (roomt00.png) matching a player screenshot of the ambush clearing. #R$B867 itself never checks room type, only the specific room number in $D3B8; type $00 is simply reused at every candidate location so the scenery looks right regardless of which one gets picked.
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
c $8A79 Play the main menu melody ($8B82), called from #R$CD6C
C $8A7C,2 => Wait for the player to select a menu item from the list at
c $8A7E Play the game-over melody ($8C3E), called from #R$C055
C $8A81,2 => Wait for the player to select a menu item from the list at
c $8A83 Play the victory melody ($8C74), called from $C014 right after #R$D085 prints the victory message
c $8A86 Wait for the player to select a menu item from the list at (HL)
N $8A86 Each list entry is a header byte B (bit 5 = flash the border-colour attribute at $8AD9; bits 6-7 = a colour index saved to $8B36; bits 0-3 = a key-wait count) followed by a 2-byte jump-list pointer, consumed by #R$8AAF. A $00 header byte ends the list. Loops to the next entry until #R$8AAF reports a match (Z flag).
R $8A86 HL Pointer to the menu entry list ($00 header byte ends it)
C $8A86,2 Disable interrupts; B = this entry's header byte, or 0 = end of list
C $8A8B,7 Bit 5 set: also flash the border-colour attribute byte at $8AD9
C $8A95,8 Bits 6-7 of the header -> colour index, saved to $8B36
C $8A9D,5 Bits 0-3 of the header -> B (key-wait count for #R$8AAF)
C $8AA7,3 Wait for a keyboard row read, decode it via the table at #R$8B57
c $8AAF Wait for a keyboard row read, decode it via the table at #R$8B57
N $8AAF HL on entry points at a length-prefixed playlist entry (see #R$8B82), whose first byte is a relative offset to that entry's phrase data. Loops B times over the phrase bytes, checking the keyboard between each and returning as soon as any key is pressed, and decodes every pair of bytes into two pitch periods through the table at #R$8B57/#R$8B60. Playback is a software tone loop: the two periods count down against each other and toggle bits that drive the speaker bit of port $FE, held for a duration taken from bits 6-7 of the pair's second byte. Confirmed live: this is the source of the continuous menu music, and #R$8B27-#R$8B48 is the tail that actually generates the sound.
R $8AAF HL -> a length-prefixed playlist
C $8AB0,1 Entry's first byte = relative offset to its phrase data
C $8AB4,2 DE -> the phrase data; HL stays on the list entry
C $8ABD,3 Read keyboard port $00FE; the CPL makes a set bit mean "pressed"
C $8AC2,2 A key is down: unwind and return
C $8ACA,5 $FF ends this entry - on to the next playlist entry
C $8ACF,4 Bit 5 set: skip a phrase byte
C $8AD4,2 B = 0, so the delay below runs a full 256 passes
C $8AD6,2 R register supplies the border bits
C $8AD8,2 !!MUT-ARG!! border-colour mask for the menu tune
C $8AE0,2 B keeps the raw first phrase byte for its rest flag below
C $8AE2,2 Bits 0-4 = note index (0-31)
C $8AE5,3 Look up A in the byte table at #R$8B60
C $8AE9,4 First note's period -> C, and into #R$8B27's self-modified reload
C $8AF1,3 Look up A in the byte table at #R$8B60
C $8AF7,3 Periods differ: nudge the second one by one
C $8AFE,4 Second note's period -> D, and into $8B2E's own reload
C $8B04,4 Note index 0 means a rest
C $8B18,2 Bits 6-7 of the flag byte = the duration class
C $8B1F,4 H advances $0E per duration step, making HL the note's countdown
C $8B27,3 C counts down the first note's period
C $8B2A,2 !!MUT-ARG!! first note's toggle bit
C $8B2C,2 !!MUT-ARG!! first note's reload period (pitch)
C $8B2E,3 D counts down the second note's period
C $8B31,2 !!MUT-ARG!! second note's toggle bit
C $8B33,2 !!MUT-ARG!! second note's reload period (pitch)
C $8B35,2 !!MUT-ARG!! Only bit 1 (D's toggle) reaches the speaker - C's is computed and dropped
C $8B41,2 Drive the beeper (bit 4 of port $FE)
C $8B48,2 Loop until the note's duration expires
C $8B52,4 Repeat the whole entry B times
c $8B57 Look up A in the byte table at #R$8B60
N $8B57 Trivial index: DE=A, HL=$8B60+DE, return (HL). Used to fetch the pitch/period byte for a note's low-5-bit value from #R$8B60's chromatic table.
R $8B57 A $00.$1F
R $8B57 O:A The table byte at $8B60+A
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
N $8C8D Replays the laugh bitstream at $8CD4 (via #R$8CAA) around 11 times ($02..$0D), patching a rising pitch/rate byte into $8CB1 before each play and burning time between plays with a zero-length LDIR (BC=$40) - giving the rising "ha-ha-ha-ha" cadence.
C $8C8D,3 A = 2 (starting pitch/rate value)
C $8C90,6 Patch the pitch/rate byte at $8CB1; HL -> laugh data
C $8C99,8 Burn time via a zero-length LDIR delay (BC=$40)
C $8CA3,7 Next pitch; loop until A=$0D (~11 replays)
C $8C96,3 Play a sound effect encoded as a bit-per-border-flip stream
c $8CAA Play a sound effect encoded as a bit-per-border-flip stream
N $8CAA Called from #R$CD6C ("Sound of evil laughter" is one such effect). (HL) -> a 2-byte bit-count (DE), followed by the bitstream itself. Each bit is rotated out of the data byte via RLC (HL) and drives the border colour (bit set -> colour 0, clear -> low 3 bits of a counting value), with a small busy-wait between bits; continues until DE bits have been played.
R $8CAA HL -> a 2-byte bit count, followed by the bitstream itself
C $8CAA,4 DE = total bit count, from the 2 bytes at (HL)
C $8CAE,2 B = 8 bits per data byte; C = a short per-bit delay
C $8CB0,2 !!MUT-ARG!! bitstream player's per-bit delay
C $8CB5,4 A = $18 (border white); RLC (HL) shifts out the next bit
C $8CB9,8 Bit set: A stays $18, C = 0
C $8CC1,5 Bit clear: A = the low 3 bits of the delay counter
C $8CC6,4 Output the border colour; loop for the next bit
C $8CCA,5 Advance HL/DE (IX is stepped but otherwise unused here)
C $8CCF,4 Loop until DE (the bit count) reaches 0
b $8CD4 Data for Sound of evil laughter
N $8CD4 The "ha-ha-ha-ha" bitstream played by #R$8CAA (heard on the intro and on the #R$B867 capture/ambush - confirmed by ear, not on ordinary combat). 172 bytes total ($8CD4-$8D7F): a 2-byte bit-count ($00AC = 172 bits) followed by 170 bytes of bitstream.
B $8CD4,2 Bit count ($00AC = 172 bits)
B $8CD6,,12
w $8D80 Robin's sprite-frame pointer table, indexed by frame number via #R$C6D6
N $8D80 Set as the frame base at $C6D8 by #R$C6A2/#R$D3BB (i.e. for Robin's own object record at $CC7C); each word is a frame data address, selected by doubling the animation frame number ($CC7E).
W $8D80,,8
w $8E12 Source-run pointers for the sprite background save, indexed by #R$C790
N $8E12 5 entries, indexed by the frame's flag byte (doubled, bit 7 masked, at $C7C7). All point into the single byte run at #R$8E1C at successively later offsets, so one shared run supplies five different-length sources (8, 7, 3, 2 and 1 bytes).
B $8E1C
b $8E24 Robin sprites
B $8E27,96,8 #HTML[#UDGARRAY3,4,3,3,,($8E27-$8E86-1-24)(robin0)] Robin run 0
B $8E87,3
B $8E8A,96,8 #HTML[#UDGARRAY3,4,3,3,,($8E8A-$8EE9-1-24)(robin1)] Robin run 1
B $8EEA,3
B $8EED,96,8 #HTML[#UDGARRAY3,4,3,3,,($8EED-$8F4C-1-24)(robin2)] Robin run 2
B $8F4D,3
B $8F50,96,8 #HTML[#UDGARRAY3,4,3,3,,($8F50-$8FAF-1-24)(robin3)] Robin run 3
B $8FB0,3
B $8FB3,96,8 #HTML[#UDGARRAY3,4,3,3,,($8FB3-$9012-1-24)(robin4)] Robin run 4
B $9013,3
B $9016,96,8 #HTML[#UDGARRAY3,4,3,3,,($9016-$9075-1-24)(robin5)] Robin run 5
B $9076,3
B $9079,96,8 #HTML[#UDGARRAY3,4,3,3,,($9079-$90D8-1-24)(robin6)] Robin run 6
B $90D9,3
B $90DC,96,8 #HTML[#UDGARRAY3,4,3,3,,($90DC-$913B-1-24)(robin7)] Robin run 7
B $913C,3
B $913F,96,8 #HTML[#UDGARRAY3,4,3,3,,($913F-$919E-1-24)(robin8)] Robin run 8
B $919F,3
B $91A2,96,8 #HTML[#UDGARRAY3,4,3,3,,($91A2-$9201-1-24)(robin9)] Robin run 9
B $9202,3
B $9205,96,8 #HTML[#UDGARRAY3,4,3,3,,($9205-$9264-1-24)(robinA)] Robin run A
B $9265,3
B $9268,96,8 #HTML[#UDGARRAY3,4,3,3,,($9268-$92C7-1-24)(robinB)] Robin sit
B $92C8,3
B $92CB,96,8 #HTML[#UDGARRAY3,4,3,3,,($92CB-$932A-1-24)(robinC)] Robin front 0
B $932B,3
B $932E,96,8 #HTML[#UDGARRAY3,4,3,3,,($932E-$938D-1-24)(robinD)] Robin front 1
B $938E,3
B $9391,96,8 #HTML[#UDGARRAY3,4,3,3,,($9391-$93F0-1-24)(robinE)] Robin back 0
B $93F1,3
B $93F4,96,8 #HTML[#UDGARRAY3,4,3,3,,($93F4-$9453-1-24)(robinF)] Robin back 1
b $9454 Guard sprites
B $9454,3
B $9457,96,8 #HTML[#UDGARRAY3,,3,3,,($9457-$94B6-1-24)(guard0)] Guard right 0
B $94B7,3
B $94BA,96,8 #HTML[#UDGARRAY3,,3,3,,($94BA-$9519-1-24)(guard1)] Guard right 1
B $951A,3
B $951D,96,8 #HTML[#UDGARRAY3,,3,3,,($951D-$957C-1-24)(guard2)] Guard right 2
B $957D,3
B $9580,96,8 #HTML[#UDGARRAY3,,3,3,,($9580-$95DF-1-24)(guard3)] Guard right 3
B $95E0,3
B $95E3,96,8 #HTML[#UDGARRAY3,,3,3,,($95E3-$9642-1-24)(guard4)] Guard right 4
B $9643,3
B $9646,96,8 #HTML[#UDGARRAY3,,3,3,,($9646-$96A5-1-24)(guard5)] Guard right 5
B $96A6,3
B $96A9,96,8 #HTML[#UDGARRAY3,,3,3,,($96A9-$9708-1-24)(guard6)] Guard right 6
B $9709,3
B $970C,96,8 #HTML[#UDGARRAY3,,3,3,,($970C-$976B-1-24)(guard7)] Guard right 7
B $976C,3
B $976F,96,8 #HTML[#UDGARRAY3,,3,3,,($976F-$97CE-1-24)(guard8)] Guard left 0
B $97CF,3
B $97D2,96,8 #HTML[#UDGARRAY3,,3,3,,($97D2-$9831-1-24)(guard9)] Guard left 1
B $9832,3
B $9835,96,8 #HTML[#UDGARRAY3,,3,3,,($9835-$9894-1-24)(guardA)] Guard left 2
B $9895,3
B $9898,96,8 #HTML[#UDGARRAY3,,3,3,,($9898-$98F7-1-24)(guardB)] Guard left 3
B $98F8,3
B $98FB,96,8 #HTML[#UDGARRAY3,,3,3,,($98FB-$995A-1-24)(guardC)] Guard front
B $995B,3
B $995E,96,8 #HTML[#UDGARRAY3,,3,3,,($995E-$99BD-1-24)(guardD)] Guard right fire
B $99BE,3
B $99C1,96,8 #HTML[#UDGARRAY3,,3,3,,($99C1-$9A20-1-24)(guardE)] Guard left fire
B $9A21
b $9A36
B $9A56
B $9A76
B $9A96
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
b $A44F Attribute pattern for the special-room effect, 5 rows of 3 cells
N $A44F Copied into the attribute area at $588D by #R$DA0F when Robin enters a special-event room (shifted 3 cells right if the room is mirrored). The values $46/$44 set the colours the #R$DA9E callback then flickers over.
B $A44F,15,3
b $A45E Hermit sprites
B $A461,96,8 #HTML[#UDGARRAY3,7,3,3,,($A461-$A4C0-1-24)(hermit0)] Hermit 0
B $A4C1,3,3
B $A4C4,96,8 #HTML[#UDGARRAY3,7,3,3,,($A4C4-$A523-1-24)(hermit1)] Hermit 1
B $A524,3,3
B $A527,96,8 #HTML[#UDGARRAY3,7,3,3,,($A527-$A586-1-24)(hermit2)] Hermit 2
B $A587,3,3
B $A58A,96,8 #HTML[#UDGARRAY3,7,3,3,,($A58A-$A5E9-1-24)(hermit3)] Hermit 3
B $A5EA,3,3
B $A5ED,96,8 #HTML[#UDGARRAY3,7,3,3,,($A5ED-$A64C-1-24)(hermit4)] Hermit 4
B $A64D,3,3
B $A650,96,8 #HTML[#UDGARRAY3,7,3,3,,($A650-$A6AF-1-24)(hermit5)] Hermit 5
B $A6B0,3,3
B $A6B3,96,8 #HTML[#UDGARRAY3,7,3,3,,($A6B3-$A712-1-24)(hermit6)] Hermit 6
B $A713,3,3
B $A716,96,8 #HTML[#UDGARRAY3,7,3,3,,($A716-$A775-1-24)(hermit7)] Hermit 7
B $A776,3,3
B $A779,96,8 #HTML[#UDGARRAY3,7,3,3,,($A779-$A7D8-1-24)(hermit8)] Hermit 8
B $A7D9,3,3
B $A7DC,96,8 #HTML[#UDGARRAY3,7,3,3,,($A7DC-$A83B-1-24)(hermit8)] Hermit 8
b $A83C Bishop sprites
N $A83C 3 frames, drawn by #R$B919/#R$BA85 (frame $03 in #R$BB7F, via the shared frame base $8DEA) - visually confirmed as Bishop, and statically confirmed by the frame-number match (the Hermit at #R$BC59 never uses frame $03).
B $A83F,96,8 #HTML[#UDGARRAY3,3,3,3,,($A83F-$A89E-1-24)(bishop0)] Bishop 0
B $A89F,3,3
B $A8A2,96,8 #HTML[#UDGARRAY3,3,3,3,,($A8A2-$A901-1-24)(bishop1)] Bishop 1
B $A902,3,3
B $A905,96,8 #HTML[#UDGARRAY3,3,3,3,,($A905-$A964-1-24)(bishop2)] Bishop 2
b $A965 Wild boar
N $A965 Drawn via the "boar" object table at #R$DD05 (frame numbers $10-$13/$90-$93 from #R$DD31/#R$DD38, resolved through the shared frame base $8DEA) - confirmed live via Emu80: entry 1's active flags/frame matched a boar visible on screen.
B $A965,3,3
B $A968,48,8 #HTML[#UDGARRAY3,2,3,3,,($A968-$A997-1-24)(boar0)] Boar 0
B $A998,3,3
B $A99B,48,8 #HTML[#UDGARRAY3,2,3,3,,($A99B-$A9CA-1-24)(boar1)] Boar 1
B $A9CB,3,3
B $A9CE,48,8 #HTML[#UDGARRAY3,2,3,3,,($A9CE-$A9FD-1-24)(boar2)] Boar 2
B $A9FE,3,3
B $AA01,48,8 #HTML[#UDGARRAY3,2,3,3,,($AA01-$AA30-1-24)(boar3)] Boar 3
c $AA31 Update a patrolling enemy's direction/animation state
N $AA31 Steps one guard per call, and only runs its main logic on every 4th call (divider counter at $AA32); IX is derived from that same counter into the object table at ($C54C) rather than being passed in. Picks a new animation-frame-list pointer for (IX+2/3) from one of the frame lists at #R$AC4A based on the object's position relative to the current room ($C548) and a state byte - a room block's bit 5 in particular selects #R$AC7B - then sets flags in (IX+4) and calls #R$C8F7 to advance the frame. Also indexes a per-entry table at #R$AC13 (11 bytes/entry) and a step table at $DEAB - their exact per-guard meaning is unconfirmed. This is also where the "soldiers shoot Robin" mechanic lives ($AB6B onward, confirmed live via Emu80): once a guard is within $30 cells and correctly facing Robin (gated by the arrow flag #R$D59E or a coin-flip otherwise), it claims a free slot in the 3-entry room-hotspot table at #R$BF69 with its own position and switches to a kneel/aim frame (#R$AC6F/#R$AC75) - there is no separate flying-bullet object; #R$BDA3 is what actually damages Robin if he walks into the claimed cell, using the same code path as an authored room hazard.
C $AA33,4 Only every 4th call
C $AA3E,3 Guards share the frame base at $8DC4
C $AA44,6 HL -> ($C54C)'s table (see its W-line - reused for more than one stride here); add 3 bytes per guard
C $AA4A,3 3 bytes per entry
C $AA4D,6 Double-push trick: IX = HL
C $AA53,4 (IX+2) bit 4 already set: straight to the $AC13 lookup
C $AA5D,3 Guard's row against Robin's, mod 16
C $AA65,2 Within 3 rows?
C $AA6F,6 $1C per entry in the $DEAB route table
C $AA77,3 Index it by the row distance
C $AA7E,1 The entry's direction byte
C $AA81,2 Its low 2 bits give a 3- or 4-step budget
C $AA88,4 The rest is a step offset into the table
C $AA90,2 Skip any zero step bytes
C $AA9D,4 Toggle the step byte's mirror bits (6-7)
C $AAA5,3 Merge them back in
C $AAAD,3 Robin's column
C $AAB7,4 Compare against the reference table at $DEC7
C $AABD,2 A = $80 or 0 by which side he is on
C $AAC4,4 ~1 call in 16 flips the direction
C $AACC,3 Rotate a direction bit through the step byte
C $AAD3,2 Bit 7 of the old byte decides bit 6
C $AAD9,2 Bit 7 picks the decrement or increment path
C $AADE,1 Step down
C $AAE3,3 Underflow wraps up past $70
C $AAEA,1 Step up
C $AAEC,2 Overflow wraps down past $70
C $AAF5,3 Carry the step into the column nibble
C $AAFA,3 The $AC13 guard table, $0B per entry
C $AB04,3 Index by the guard number
C $AB07,5 Another double-push trick: IX = the found $AC13 entry
C $AB0C,8 C = current room's low nibble
C $AB15,3 Exact match on the entry's room nibble?
C $AB1F,2 Otherwise try the next room along
C $AB2A,2 Position under $10 means out of range
C $AB31,3 Resolved position into (IX+9)
C $AB35,2 Block bit 4: nothing more to do
C $AB3A,2 Bit 5 set: advance the state
C $AB3E,4 Clear bit 5, set bit 4
C $AB45,2 Either way, table $AC7B
C $AB51,2 Both of bits 6-7 set: skip to the proximity check
C $AB59,2 Bit 7 picks $AC67 or $AC6B
C $AB64,6 Chosen table into (IX+2/3)
C $AB6B,6 Robin's X minus the guard's
C $AB75,2 Absolute distance
C $AB77,2 Within $30 cells?
C $AB7B,2 Facing must match the side he is on
C $AB89,3 Arrow flag set: no random gate
C $AB8F,4 Else only ~1 call in 2 gets through
C $AB98,2 Guard counter picks a hotspot slot
C $ABA0,3 The 3 room hotspots at $BF69, where the guard will claim its shot
C $ABA9,2 Slot already occupied: give up on shooting this frame
C $ABB0,3 Guard's row, /8 and biased by 2
C $ABBB,3 Guard's column
C $ABC2,3 Claim the hotspot at the guard's own position - the "shot"
C $ABC5,2 Bit 7 marks it live
C $ABCC,3 Roll the facing bit out of the step byte
C $ABD5,3 Facing picks $AC75 or $AC6F
C $ABE3,8 Arm the redraw flags
C $ABEB,3 Advance an object's animation, unlink it from the list if done
C $ABF1,4 Same, but bit 2 cleared for a different frame
C $ABF5,3 Advance an object's animation, unlink it from the list if done
C $ABFE,2 Not blocked: pick a frame table by bit 7
C $AC02,16 $AC51 (backward) or $AC5C (forward) - the plain walk cycles, into (IX+2/3)
b $AC13 Guard object table, 5 entries of 11 bytes
B $AC13,55,11
b $AC4A Guard frame-list fragments, direction tables for #R$AA31/#R$B919
B $AC4A,1,1
W $AC4B,2,2
W $AC4D,2,2
W $AC4F,2,2
N $AC4A Six short frame lists follow the padding above (count byte(s), $FF, then a 2-byte loop pointer), several looping into each other's tails the same way Robin's own tables do (see #R$CC9D): #R$AC5C/#R$AC51 are the two full 8-frame walk cycles (forward/backward); $AC67/$AC6B/$AC6F/$AC75 are short lead-ins (a turn frame or two) that join one of those cycles; #R$AC7B is picked when a room block's bit 5 is set (see #R$C346) and, after two lead-in frames, plays local frames $10-$12 - absolute $32-$34 on the shared guard base $8DC4 (see #R$AA3E) - before looping into its own tail. Those three frames' stored bytes at $9A36/$9A56/$9A76 don't look like the raster+header shape the other sprite blocks use (small sparse values in a narrow range, not pixel rows), so what they actually draw - or whether this path is ever reached live - is unconfirmed.
B $AC51,11 Backward walk cycle ($0B down to $08, twice), loops to itself
B $AC5C,11 Forward walk cycle ($00-$07), loops to itself
B $AC67,4 One turn frame ($0C), then joins the forward cycle at #R$AC5C
B $AC6B,4 One turn frame ($0C), then joins the backward cycle at #R$AC51
B $AC6F,6 Three frames ($0D), then joins the forward cycle at #R$AC5C
B $AC75,6 Three frames ($0E), then joins the backward cycle at #R$AC51
B $AC7B,8 Two frames ($0C), then $10-$12 (absolute $32-$34, see the N-line), loops into its own $12
N $AC13 Rebuilt on every room change by #R$C276 from the room's block flags, then stepped each frame by #R$AA31. Scanned for hits by #R$BD49 (arrows) and #R$BE43 (sword); (IX+4) bit 0 marks an entry active, bit 5 marks it already hit, and (IX+9)/(IX+0A) hold its position.
c $AC83 Draw the main menu items
N $AC83 Called from #R$CD6C. Clears the screen, computes a highlight position from the last-chosen control scheme ($AD32, set by #R$D0CB), then prints 6 menu message strings ($40..$4C) at fixed positions, finishing with the side-wipe transition (#R$CE81).
C $AC83,2 A = $47 (screen number?)
C $AC88,14 Compute the highlighted item's position from $AD32
C $AC85,3 Clear the shadow screen
C $AC96,2 A = $40 - #R$D7CE index $00, the sword icon
C $AC98,3 Print message number A, positioned from the $D7CE table
C $AC9B,5 A = $48 - #R$D7CE index $08, "0 START"
C $ACA0,3 Print message number A, positioned from the $D7CE table
C $ACA3,5 A = $49 - #R$D7CE index $09, "1 KEYBOARD"
C $ACA8,3 Print message number A, positioned from the $D7CE table
C $ACAB,5 A = $4A - #R$D7CE index $0A, "2 KEMPSTON"
C $ACB0,3 Print message number A, positioned from the $D7CE table
C $ACB3,5 A = $4B - #R$D7CE index $0B, "3 INTERFACE II"
C $ACB8,3 Print message number A, positioned from the $D7CE table
C $ACBB,5 A = $4C - #R$D7CE index $0C, "4 CURSOR"
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
N $AD31 8x8 glyphs, 8 bytes each, for codes $20-$FF (224 glyphs - the printer's own #R$D6AB skips any code below $20 as a control code, never a glyph, so the table has no cells for $00-$1F). Runs to $B432, the last byte of glyph $FF (confirmed part of #R$B630's gate icon); $B433 is a single leftover pad byte before #R$B434's Odin logo. Codes $20-$5F double as literal ASCII (confirmed: #R$B6AC decodes directly as "CONGRATULATIONS"); higher codes are the custom icon/decoration glyphs used throughout #R$D7CE and the direct-address HUD icons (#R$B495, #R$B4C1, etc).
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
b $B434 Odin logo (custom font glyphs), message index $0F in #R$D7CE
N $B434 #HTML[<img src="images/b434_odin.png" />]
N $B434 Printed by #R$CE44 during the game-start intro, right before #R$CE47's side-wipe reveals the Odin logo (see #R$CD6C's N-line) - the message itself IS that logo, spelled out via 3 rows of glyphs ($C9-$D0, $D1-$D9, $DA-$E6...) with a leading $40/$20 that isn't part of the logo art, confirmed by rendering the font bytes as pixels.
b $B495 Sword icon (custom font glyphs), for #R$D7F3's type-$00 trigger and the Ent's sword sale (#R$DF03)
N $B495 2 rows of 7 glyphs ($79-$7D, $7E-$82), each with its own attribute byte (not one colour per row) - confirmed by rendering the font bytes as pixels as the sword shown in the HUD. Printed by #R$D7F3 when Robin steps into a type-$00 trigger zone, and by #R$DF03 as the Ent's "sword bought" message.
N $B495 #HTML[<img src="images/b495_sword.png" />]
b $B4B8 Sword icon (custom font glyphs), message index $00 in #R$D7CE
N $B4B8 #HTML[<img src="images/b4b8_sword.png" />]
N $B4B8 Printed in the main menu (#R$AC83).
B $B4B8,1,1
B $B4B9,3,3
B $B4BC,1,1
B $B4BD,3,3 Attribute bytes
b $B4C1 Bow icon (custom font glyphs), for #R$D7F3's type-$03 trigger and the Ent's bow sale (#R$DF03)
N $B4C1 #HTML[<img src="images/b4c1_bow.png" />]
N $B4C1 3 rows of 9 glyphs - the bow shown in the HUD. Printed by #R$D7F3 when Robin steps into a type-$03 trigger zone, and by #R$DF03 (after #R$B567) as the Ent's "bow bought" message.
b $B504 Unknown icon (bow?), message index $03 in #R$D7CE
N $B504 #HTML[<img src="images/b504.png" />]
N $B504 Looks like a bow, but not seen in the game and no confirmed call site prints message index $03 - possibly unused.
b $B512 Bag-of-money icon (custom font glyphs), for event status $02
N $B512 #HTML[<img src="images/b512_gold.png" />]
N $B512 4 glyphs, 2x2 grid ($8F/$90 top, $91/$92 bottom). Printed by #R$DB98, #R$D997's Bishop-proximity hint, and #R$D94B's default fallback. Shown under the energy antlers as the carried gold-bag count.
b $B51F Archer icon (extra life)
N $B51F #HTML[<img src="images/b51f.png" />]
N $B51F 2x2 grid ($93/$94 top, $95/$96 bottom, bright green/black) - the extra-life archer figure. $B51F/$B520 is a packed position word consumed by #R$D619's dereference (see #R$B52D's N-line), not glyph data. Printed by #R$D91A alongside the ASCII digit it writes to $DA0B - together they show the extra-life count under the energy antlers.
B $B51F,2 Position header, not glyph data
b $B52D Key icon as #R$D7F3's type-$06 trigger message (see #R$C4B6)
N $B52D #HTML[<img src="images/b52d_key.png" />]
N $B52D $B52D/$B52E is a packed position word consumed by #R$D619's dereference when reached via #R$C4C7/#R$D85A's direct dispatch - the real glyphs are $97,$98 at $B52F (confirmed by the matching 2-byte attribute run). The same bytes are also reachable as table-driven message index $06 in #R$D7CE, whose entry points straight at $B52E and reads all 4 bytes ($A0,$97,$98,$00) as one string - two callers reusing the same data two different ways.
B $B52D,1 Position header (with $B52E below), not glyph data
B $B52E,4 Key icon (custom font glyphs), message index $06 in #R$D7CE (also room-$BB hotspot message #6 in #R$D543, seeded by #R$D454) - codes $97/$98 confirmed as a key
b $B536 Wreath icon (custom font glyphs), message index $01 in #R$D7CE
N $B536 #HTML[<img src="images/b536_wreath.png" />]
N $B536 6 glyphs, 3x2 grid ($9D/$9E/$9F top, $A0/$A1/$A2 bottom, confirmed by the matching 3-per-row attribute run) - wreath icon, message index $01 in #R$D7CE.
b $B548 Flower icon (custom font glyphs), for event status $05
N $B548 #HTML[<img src="images/b548_flower.png" />]
N $B548 4 glyphs, 2x2 grid ($A3/$A4 top, $A5/$A6 bottom). Printed by #R$DB98 and #R$D94B as the flower-count icon, shown under the energy antlers.
B $B556,17 Arrow icon (custom font glyphs), message index $04 in #R$D7CE - codes $C6/$C7/$C7/$C8 stacked one glyph per row
b $B567 Quiver icon, upright/HUD (custom font glyphs), for the Ent's bow sale (#R$DF03)
N $B567 #HTML[<img src="images/b567_quiver.png" />]
N $B567 6 glyphs, 3 rows of 2 - quiver icon. Printed by #R$DF03 right before #R$B4C1 (the bow).
b $B57C Quiver icon, laying (custom font glyphs), message index $07 in #R$D7CE - the gameplay pickup, as opposed to #R$B567's upright HUD quiver
N $B57C #HTML[<img src="images/b57c_quiver.png" />]
N $B57C 4 glyphs ($AB-$AE), attrs $44,$44,$44,$46 - a quiver of arrows laying flat, the gameplay pickup shown in the room itself (as opposed to #R$B567's upright quiver used in the HUD).
b $B587 Ornament at the left side of the game screen
N $B587 #HTML[<img src="images/b587_vine.png" />]
B $B589
b $B5C0 Ornament at the right side of the game screen
N $B5C0 #HTML[<img src="images/b5c0_vine.png" />]
b $B5F9 Open/missing door-gate icon (custom font glyphs), message index $0D in #R$D7CE
N $B5F9 #HTML[<img src="images/b5f9.png" />]
N $B5F9 Printed by #R$C4AC for the $79/$BB gate/key landmark pair. A single glyph ($EF) followed mostly by blank rows - identified as the gate shown open/missing, contrasting #R$B630's closed-gate icon.
B $B613
b $B630 Door/gate icon (custom font glyphs), message index $0E in #R$D7CE
N $B630 #HTML[<img src="images/b630_gate.png" />]
N $B630 Printed by #R$C48A for the $65/$6E forest-door landmark pair. 20 glyphs in 5 rows of 4 ($A7-$AA, $F0-$F3, $F4-$F7, $F8-$FB, $FC-$FF) - a door/gate shape, confirmed by rendering the font bytes as pixels.
b $B663 GAME OVER message
N $B663 Printed by #R$C055 via #R$D619, whose 2-byte position-header dereference (see #R$D619's N-line) means the real text starts at $B665, not $B663. Terminates at $B687 - a separate, shorter string from the victory text at #R$B6AC, despite sharing this data block.
B $B663,2 Position header, not glyph data
T $B66C
b $B6AC Victory message
B $B672
T $B67A
B $B680
T $B6AD
B $B6C3
T $B6C6
B $B6DF
T $B6E1
B $B6F4
T $B6F6
B $B70D
T $B710
B $B729
T $B72B
B $B745
T $B747
B $B763
T $B765
B $B77B
N $B77C Victory message attributes
@ $B867 label=trigger_ambush
c $B867 Trigger the Sheriff of Nottingham's scripted ambush when Robin reaches the target room's centre
N $B867 Only acts in the room picked by #R$CFB3 ($D3B8). Advances the Sheriff's object at $B8FB (same as #R$C276 sets up) every 4th call. While Robin's X position ($CC85) is in the centre band ($24..$5B) and the ambush hasn't already fired (bit 7 of the object's flags), arms it: plays "evil laughter" (#R$8C8D), and once the object reaches a specific animation frame ($02), warps Robin to room $9C and redraws the screen.
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
b $B8FB Sheriff of Nottingham: object record and animation frame lists
N $B8FB Same 11-byte entry layout as #R$AC13. Set up on every room change by #R$C276 and advanced by #R$B867 as the Sheriff's scripted capture/ambush plays out. Each frame list is a run of frame numbers ended by $FF, followed by a 2-byte pointer back to its own loop point; #R$B867 picks between $B906 and $B90B via (IX+2/3).
B $B8FB,11 Object record (see #R$AC13); (IX+9)/(IX+0A) = position $40/$50
B $B906,5 Frame list: 01, 02, loop
B $B90B,5 Frame list: 81, 82, loop (mirrored pair of #R$B906)
B $B910,4 Frame list: 80, loop
B $B914,4 Frame list: 00, loop
B $B918,1 Terminator/flag read by #R$B867
c $B919 Update Bishop: pick a target room, then patrol toward it
N $B919 Tracks Bishop's own state in $BB9x/$AC4x variables rather than a shared object-record table. Every 4th call ($BBA0 counter) it may pick a new patrol route from the 8-entry (start room, end room) table at $BBA1 (keyed by a random R-register roll, rerolling on a repeat) and reset movement/timer state. On the bit-2 branch of $BB9F it also independently checks whether Bishop's escort guard is still alive: IX = $AC3F (the $AC13 room-guard table's 5th/last slot); if bit 5 of (IX+4) is set (the escort has been hit/killed - a player-sourced walkthrough's "scaring Bishop by killing his guard"), it falls into the "drops money" branch below instead of the plain $AC67/$AC6B walk step at $BA38. This is a poll of the escort's own hit-flag done every cycle, not a push notification from the kill itself - #R$BF1A (the code that actually marks a guard hit) never touches $BB9F. The "Bishop drops money" branch: at $B9DB/$BA01 it points $D9B3/$D9BD at $BB9D (Bishop's tracked target room) and calls #R$D997 twice (positions 8 pixels apart) to log Robin's current room/position with type $02; #R$D997's tail then prints #R$B512 (the bag-of-money icon) immediately if Bishop's tracked room equals the room Robin is currently standing in - up to 2 prints per visit to this branch, matching the walkthrough's "pays off with two bags of gold" exactly. On arrival at the target room ($BA11) the tracked-room pointer is switched to live room/position variables ($C548/$CC85) instead, so once Bishop actually reaches Robin's room the icon is shown via that live comparison instead of the stashed $BB9D snapshot. Whether this same event also forces an early route reroll (the walkthrough's "changes location") isn't confirmed - $BB9F bit 2 is set here but bits 0-1 (which gate rerolling) are left unchanged.
C $B91C,2 Only while $BB9F's low bits are clear
C $B928,6 Roll 0-7, x4 for the 4-byte stride
C $B931,3 Bishop's 8 patrol routes at #R$BBA1
C $B935,3 The route's start room
C $B93D,3 Reroll if it repeats the last one
C $B943,4 Start room copied to four tracking variables
C $B953,3 The route's end room
C $B95E,3 Default direction table
C $B96B,3 Zero the per-guard counters
C $B97B,2 Movement flags $03
C $B990,1 Only every 4th call runs the state machine
C $B991,2 !!MUT-ARG!! Bishop's state mask
C $B99A,2 $BB9F bit 1 gates it
C $B99F,4 IX = $AC3F, the $AC13 table's 5th/last slot - Bishop's escort guard
C $B9A3,2 Bit 2 picks which half
C $B9AD,3 Tracked position's row nibble
C $B9B4,4 Against the current room's
C $B9BE,6 Both tables $AC7F when the rows match
C $B9D0,4 Escort guard's hit flag (IX+4 bit 5) clear: still alive, just step normally
C $B9D6,2 Flag bit 2 marks the move as started
C $B9DB,3 Point $D9B3/$D9B8/$D9BD/$D9C9 at $BB96/$BB9D, Bishop's tracked target room/position
C $B9EF,3 Shift the recent-event byte queue at $D59B, print any matching hints
C $B9F5,4 Advance the arrow-hit stage
C $BA05,5 Log a second position $08 further on
C $BA11,3 Arrival: retarget the log at the live room/position
C $BA2A,6 Frame handler now $BAEC
C $BA30,3 Both tables $AC7B
C $BA41,3 Step Bishop's map position one cell toward its target
C $BA44,3 Next call re-enters at $BA93
C $BA4D,2 Bit 0 clear: nothing more to do
C $BA54,2 Bit 2 gates the range check
C $BA5F,3 Tracked room against the current one
C $BA67,2 Position $14..$63 counts as close
C $BA72,2 Clear flag bits 0 and 3, stay put
C $BA78,6 Otherwise the $BB7F/$BB86 pair
C $BA81,3 Step Bishop's map position one cell toward its target

C $BA90,3 !!MUT-ARG!! entry point used on the next call
b $BBA1 Bishop's 8 patrol routes, rolled by #R$B919
N $BBA1 8 entries of 2 room numbers each (start, end) - live-decoded from the raw snapshot bytes, since skool2asm can't show them as data while they sit inside #R$B919's own code block. Every entry's two rooms share the same row (room = row*16+column, see #R$79F9), so each route is a straight horizontal line across part of one row - confirmed against a player-made map that independently plots these same 8 spans (e.g. row 6 columns 0-7, row 19 columns 6-9). #R$B919 rolls one of the 8 with the R register and patrols Bishop back and forth along it via #R$BA85.
W $BBA1,4 $001D..$0012 (row 1, columns 13-2)
W $BBA5,4 $0031..$0033 (row 3, columns 1-3)
W $BBA9,4 $0060..$0067 (row 6, columns 0-7)
W $BBAD,4 $007F..$0071 (row 7, columns 15-1)
W $BBB1,4 $00CF..$00C1 (row 12, columns 15-1)
W $BBB5,4 $00ED..$00E0 (row 14, columns 13-0)
W $BBB9,4 $00FF..$00F0 (row 15, columns 15-0)
W $BBBD,4 $0136..$0139 (row 19, columns 6-9)
c $BA85 Step Bishop's map position one cell toward its target
N $BA85 IX -> its object record. (IX+10/11) holds the enemy's current world-map position, packed as two nibbles (X in bits 0-3, Y in bits 4-7 of the low byte plus the high byte). Depending on a facing bit at (IX+11) and comparisons against target coordinates at (IX+0C..0F), the low or high nibble of the position is incremented or decremented by one, moving it one map cell toward the target; #R$C8F7 is then called to advance/redraw the frame.
C $BA85,3 Stashed for the #R$BA93 entry point, which re-reads them as operands
C $BA93,3 (IX+0B) bit 0 picks the horizontal or vertical branch
C $BA97,3 Current X nibble
C $BA9A,6 Target position from (IX+10/11)
C $BAA2,3 One step on, wrapping at $70
C $BAA8,6 Reached the target X: does Y match too?
C $BAB3,3 Clear the step, keep the position
C $BAB9,4 Split the nibbles
C $BABE,3 X nibble +1
C $BAC7,1 Other direction: one step back
C $BACB,6 Against the other target coordinate
C $BAD6,5 Reset X to $6F and step the nibble down
C $BADE,3 Split the nibbles
C $BAE3,3 X nibble -1
C $BAEC,5 Arrived: flip the facing bit
C $BAF4,3 !!MUT-ARG!! HL stashed by #R$BA85; $BB7F is only the default
C $BAFA,3 !!MUT-ARG!! DE stashed by #R$BA85; $BB86 is only the default
C $BAFD,6 Into (IX+2/3)
C $BB05,6 Does the Y position match the current room?
C $BB1E,4 Retry with the X nibble one lower
C $BB25,3 Still no match: nothing to draw
C $BB28,5 Clear redraw bit 2
C $BB2F,3 Store the stepped X position
C $BB32,6 Second pass over the same test
C $BB4C,3 X nibble -1 again
C $BB55,3 Wrap X at $70
C $BB5D,2 $10 loops back, anything lower gets +$70
C $BB62,5 Arm the redraw flags
C $BB6A,3 !!MUT-ARG!! BC stashed by #R$BA85; $8DEA is only the default
C $BB70,3 Advance an object's animation, unlink it from the list if done
C $BB76,2 Finally fold the position back under $70
R $BA85 IX Object record
R $BA85 HL Stashed to $BAF5 for the #R$BA93 entry point
R $BA85 DE Stashed to $BAFB for the #R$BA93 entry point
R $BA85 BC Stashed to $BB6B for the #R$BA93 entry point
b $BB7F Bishop's direction/frame tables ($BB7F/$BB86), against the shared frame base $8DEA
N $BB7F Frame numbers here index $8DEA (Bishop's frame base, set at #R$BA3E/#R$BA78). Frame $03 resolves to #R$A83C, Bishop's 3-sprite block - confirms #R$B919/#R$BA85 draw Bishop, not the Hermit at #R$BC59 (whose own tables $BC69/$BC75 never use frame $03).
c $BBC1 Update the Hermit: step its room-distance counter, animate
N $BBC1 Every 4th call (counter at $BBC2/$BB92 by way of #R$BF80). Every 4th pass of an inner phase counter ($BC66) it also alternates a direction-table pair ($BC69/$BC75, toggled at $BBF4) into the frame pointer. Steps a position byte (IX+9, IX = fixed object at $BC59) by one toward/away from Robin's room ($C548) - tracked via the counter at $BC64 - wrapping at $70 as in #R$BA85, then redraws via #R$C8F7. This is the Hermit's "travels back and forth left and right of his hut" pacing, confirmed against a player-sourced walkthrough.
C $BBC1,2 !!MUT-ARG!! Hermit's rate-divider reload
C $BBD0,4 (HL) = $BC66 phase counter; decrement it
C $BBD6,10 Toggle the direction-table selector
C $BBE0,9 DE = direction table ($BC69 or $BC75), picked by the toggle bit
C $BBE9,9 Save the frame pointer; mark the object's redraw flag
C $BBF4,1 !!MUT-CMD!! dual-use: direction toggle variable, also executed here
C $BC18,10 Compare the tracked room distance ($BC64) to Robin's room ($C548)
C $BC36,15 IX -> the object at $BC59; set the position and redraw flags
C $BC45,3 Advance an object's animation, unlink it from the list if done
C $BC51,3 Advance an object's animation, unlink it from the list if done
b $BC59 The Hermit's record and step tables
N $BC59 Standard object-record layout (see #R$AC13). #R$BBC1 steps (IX+9) toward or away from Robin's room, alternating between the two direction/frame tables that follow.
c $BC81 Launch Robin's arrow when he shoots, if none is already in flight
N $BC81 Called from the arrow-shot facing/state handlers (#R$CB03/#R$CB0A). Only fires when the animation timer $CC7A is exactly 7 and the arrow object at $BF67 is inactive. Plays the launch sound (#R$BF54, B=$40), derives the arrow's start cell from Robin's position ($CC85/$CC86, halved to character cells) and facing ($CC87), range-checks the column ($02..$1D), then writes the column/row into the arrow object and sets its active/direction flags so #R$BCC2 can step it each frame.
C $BC84,2 Only at timer value 7
C $BC8A,2 An arrow already in flight blocks a new one
C $BC8F,3 Border-flash sound with rising pitch
C $BC96,6 Robin's row /8, plus 1
C $BCA9,2 Facing left shifts the column back 2
C $BCAB,2 Column must fall in $02..$1D
C $BCB5,3 Column and row into the arrow object
C $BCBB,6 Pack the facing into the direction bits
c $BCC2 Step the arrow one pixel along its diagonal flight, drawing it
N $BCC2 (HL) = the arrow object's direction byte at $BF68: bit 7/6 select which of two constants get patched into the self-modified operands at $BCF2/$BD03 (arrow moving right/left, up/down). Reads the arrow's screen position from the byte below ($BF67, bit 7 = "arrow gone" flag), plots it via #R$BD2A, then steps the column (C) and row (L) by +-1 based on whether the draw collided (bit 7 of the plotted byte), tracing the arrow's diagonal path one segment per call.
C $BCC2,5 HL -> arrow direction byte at $BF68; B = 4 (unused loop count)
C $BCC9,9 Direction bit 7 selects a patch value written to $BCF2
C $BCD5,9 Direction bit 6 selects a patch value written to $BD03
C $BCE1,11 (HL) -> arrow position byte; bail out if the arrow is gone ($00)
C $BCF1,2 !!MUT-ARG!! arrow's horizontal step direction
C $BCF3,3 Mark the arrow's screen cell dirty in the $E500 buffer
C $BD02,2 => Clear the arrow at screen edges, else mark a mid-flight collision bit
c $BD04 Clear the arrow's cell without a mid-flight collision check, then continue
N $BD04 A reduced entry into #R$BD23's shared tail: clears (HL) directly rather than testing a screen-edge column, then loops back to #R$BCC7.
R $BD04 DE Pointer to the cell byte to clear
c $BD09 Clear the arrow at screen edges, else mark a mid-flight collision bit
N $BD09 Marks the arrow's cell dirty via #R$BD2A, then checks its column (L, now in A after the draw): columns 0-1 or 30-37 clear the collision byte (arrow off-screen); otherwise rotates a bit from A into (HL), marking a mid-flight collision cell. Loops back to #R$BCC7 for the next arrow step.
R $BD09 HL L = the arrow's column (tested against the screen edges)
R $BD09 DE Pointer to the arrow's collision byte
C $BD09,9 Column < 2: arrow off the left edge, clear its collision byte
C $BD16,8 Column >= $1E: arrow off the right edge, clear its collision byte
C $BD1E,5 Otherwise: rotate a bit from A into the collision byte at (HL)
C $BD23,7 Restore state and loop back to #R$BCC7 for the next arrow step
C $BD09,3 Mark the arrow's screen cell dirty in the $E500 buffer
c $BD2A Mark the arrow's screen cell dirty in the $E500 buffer (glyph $46)
N $BD2A Called from #R$BCC2's arrow-step loop and #R$BD09. Toggles (HL) - the arrow's collision byte - by XORing $FF into it, then packs B/C (row/column) into an offset into the $E500 change-buffer (the same buffer #R$C85C later flushes to the real screen) and writes glyph code $46 there, so the arrow appears/disappears at its new position.
R $BD2A HL Pointer to the arrow's collision byte (toggled via XOR $FF)
R $BD2A B Row (its low 3 bits fold into the $E500 offset)
R $BD2A C Column
C $BD2A,4 Save AF/BC/DE/HL
C $BD2E,4 Toggle (HL) via XOR $FF
C $BD32,4 A = 0; fold row bit 0 from B
C $BD36,3 Fold row bit 1
C $BD39,3 Fold row bit 2
C $BD3C,2 Merge the folded bits into C
C $BD3E,3 HL = the $E500 base
C $BD41,3 HL += the offset; write glyph $46
c $BD49 Check an arrow hit against nearby guards, then a border-flash sound
N $BD49 (HL) is the arrow object at $BF67; does nothing if it's inactive, or if its animation frame ($BF68 low 7 bits) isn't one of the "in flight" frames $0A..$0D. Otherwise scans 5 guard entries at #R$AC13 (skipping inactive/already-hit ones) for one whose position (IX+9) is close to the arrow's column, and on a match sets a "hit" flag on the guard and calls #R$BF1A. #R$BD84 (also entered from #R$BE43's sword check) then plays a longer border-flash effect ($14 outer x C inner loops, C counting 1..$27) as the hit/scream sound.
C $BD4C,2 Arrow inactive: nothing to hit
C $BD50,3 Frames $0A..$0D mean it is in flight
C $BD5C,4 The 5 guards at $AC13
C $BD60,4 Bit 0 clear: not active
C $BD6F,4 Arrow column, plus 2, x4
C $BD74,3 Less the guard's own column
C $BD79,2 Within 8 counts as a hit
C $BD7E,2 Flag the hit on the arrow object
C $BD81,3 Mark a hit guard as defeated
C $BD84,2 Shared hit-sound entry: $14 outer passes
C $BD88,4 R register drives the border toggle
C $BD94,2 Raise the pitch each pass, up to $28
c $BDA3 Check Robin against up to 3 room hotspots at $BF69
N $BDA3 Only runs while Robin is idle ($CC7B=0). Scans 3 two-byte entries at $BF69 (row byte, then a second byte read at +1); a non-$FF row byte is scaled (x4, then compared within an 8-pixel band against $CC85; x8 compared within a 24-pixel band against $CC86) to test whether Robin's position falls within the hotspot. On a hit, sets bit 6 of the entry and calls #R$BE25 then #R$BF54 (B=0) - likely starting a climb/interact state. This is the delivery side of the "guards shoot Robin" mechanic (see #R$AA31): a guard in range claims one of these same 3 slots at its own position instead of an authored room hazard using it, so the same contact/damage code fires whether the slot holds a real hazard or a guard's aim - there is no separate flying-bullet object. Exact meaning of the entry's second byte and the two helper calls is not fully confirmed.
C $BDA3,5 Only run while Robin is idle ($CC7B = 0)
C $BDA8,9 B = 3 entries; HL -> table $BF69; DE = Robin's position ($CC85/$CC86)
C $BDB1,5 (HL) = $FF marks an unused entry; skip it
C $BDB6,7 A = (entry+2) x4; skip if that's greater than Robin's X
C $BDBF,4 Skip unless X is within the 8-pixel band
C $BDC3,7 A = entry's second byte x8; skip if greater than Robin's Y
C $BDCD,4 Skip unless Y is within the 24-pixel band
C $BDD1,2 Hit: mark this entry (bit 6)
C $BDD3,3 Damage Robin
C $BDD6,2 B = 0 (sound length)
C $BDD8,3 Border-flash sound with rising pitch
C $BDDC,3 Next entry, loop
c $BDE0 Check Robin against the boar table ($DD05) for a bump
N $BDE0 Only runs for multi-column rooms ($C549 != 0), while Robin is idle ($CC7B=0), and about 1 call in 8 (R register). Scans the 4 boar entries at $DD05 (built by #R$C276), skipping inactive ones (bit 0 of (IX+4)), and tests Robin's position ($CC85) against the boar's (IX+9/0A) via #R$BEE3; on overlap calls #R$BE25 then a border-flash via #R$BF54 (B=$60). This table's frame lists (#R$DD31/#R$DD38) draw #R$A965's wild-boar sprite, confirmed live - the mechanism is the CRASH review's "boars run loose in the forest, and contact... leads to injuries."
C $BDE5,5 Only while Robin is idle ($CC7B = 0)
C $BDEA,5 ~1 call in 8 (R register)
C $BDEF,6 B = 4 boar entries; IX -> table at $DD05
C $BE0D,3 Bounding-box overlap test
C $BE12,3 Damage Robin
C $BE17,3 Border-flash sound with rising pitch
@ $BE25 label=damage_robin
c $BE25 Damage Robin: decrement energy, or trigger death if critical
N $BE25 Called from #R$BDA3/#R$BDE0 on a hazard/boar hit. Only acts while idle ($CC7B=0). If the energy byte at $BF6F is already $02 (critical), instead sets Robin's animation to code $6E and clears a flag at $BC67; otherwise just decrements the energy byte. Either way redraws the energy bar via #R$BF37. Despite the name this isn't necessarily permanent death: #R$C9E7 dispatches code $6E to #R$CB9D, which plays a short border-flash (not the "evil laughter" heard on capture/game-over), penalises the extra-life counter, and lets Robin recover after a timer - a "critical hit/stagger" reaction, not a game-over. The actual death/game-over sequence has not been located; it may simply be the scripted ambush/capture at #R$B867 (the only other place "evil laughter" plays).
C $BE25,5 Only act while Robin is idle ($CC7B = 0)
C $BE35,10 Critical: switch to the death animation, clear the Hermit's reward-given flag ($BC67 bit 6) so he pays out again next encounter
C $BE2A,3 Energy level address
C $BE32,1 Decrease energy
C $BE3F,3 Draw the energy bar
c $BE43 Check a sword swing against nearby guards
N $BE43 Only acts if Robin's current animation frame ($CC7E) is one of the sword-swing frames ($1A/$1F/$1C). Builds a hit-rectangle (BC) offset from Robin's position ($CC85/$CC86), flipped by facing ($CC87 bit 0), then scans up to 5 guard entries in the table at #R$AC13 (skipping inactive or already-hit ones) for overlap via #R$BEE3; the first hit calls #R$BF1A and jumps to #R$BD84 to apply the effect.
C $BE46,3 Robin's current animation frame, mirror bit stripped
C $BE49,2 Only the two swing frames and the thrust reach a guard
C $BE54,3 Thrust ($1C): a wide hit-box
C $BE57,3 Facing bit 0 mirrors its X offset
C $BE61,3 Swings ($1A/$1F): a narrower one
C $BE6C,3 Robin's X plus that offset
C $BE71,3 And his Y
C $BE76,3 5 guards to test
C $BE79,4 The guard table at $AC13
C $BE7F,4 Bit 0 clear: this guard is not active
C $BE85,4 Bit 5 set: already hit
C $BE8B,3 Robin's hit-box half-widths
C $BE8F,6 The guard's position
C $BE95,3 And its own hit-box
C $BE98,3 Bounding-box overlap test
C $BE9F,1 L still holds the guard slot number
C $BEA0,3 Mark a hit guard as defeated
C $BEA6,3 $0B to the next guard entry
C $BEAD,3 Loop the remaining guards
c $BEB1 The Hermit heals Robin: on contact, refill energy and grant an extra life
N $BEB1 Only acts if bit 0 of $BC5D is set and bit 6 of $BC67 is clear (the Hermit at #R$BBC1 is active and hasn't already given his reward since the last critical hit - #R$BE25/#R$BE35 clears this same bit whenever Robin's energy hits critical), and Robin overlaps him (#R$BEE3, using his position at $BC62). On contact: flashes the whole screen (#R$BEF7), refills Robin's energy to max and redraws the bar, prints an extra-life-count message (#R$D91A, which increments the displayed extra-life counter $D5A4 - the same counter a wreath pickup increments), and sets bit 6 of $BC67 to mark the reward used up. Confirmed in full against a player-sourced walkthrough: "first meeting restores your energy and adds one extra life; later meetings are equally rewarding only if you've died at least once since the last meeting - otherwise nothing" - exactly this bit's set/clear cycle.
C $BEB1,5 Bail out unless bit 0 of $BC5D is set
C $BEB6,5 Bail out if bit 6 of $BC67 (reward already given) is set
C $BEBC,15 BC/DE = the enemy's position and hit-box size; EXX for Robin's own
C $BED2,5 Refill the energy byte at $BF6F to max
C $BEDD,5 Mark the enemy defeated (set bit 6 of $BC67)
C $BECB,3 Bounding-box overlap test
C $BECF,3 Cycle every screen attribute's ink colour, 16 times
C $BED2,3 Energy level address
C $BED7,3 Draw the energy bar
C $BEDA,3 Print an extra-life-count message, increment the counter and its displayed digit
@ $BEE3 label=bounding_box_overlap
c $BEE3 Bounding-box overlap test: |B-B'| < D and |C-C'| < E
N $BEE3 Compares one (B,C) position against another (B',C', in the shadow register pair via EXX) for closeness on both axes. Returns with carry set (RET NC not taken) only if both |B-B'| < D and |C-C'| < E, i.e. the two positions overlap within a D x E box. Used by #R$BDE0/#R$BE43/#R$BEB1 for guard/sword/boar collision checks.
R $BEE3 B First position's row
R $BEE3 C First position's column
R $BEE3 B' Second position's row (shadow register set)
R $BEE3 C' Second position's column (shadow register set)
R $BEE3 D Row overlap tolerance
R $BEE3 E Column overlap tolerance
R $BEE3 O:C Set if the boxes overlap on both axes, clear otherwise
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
N $BF1A Called from #R$BD49/#R$BE43 with A = the hit guard's slot number (1-5, from their B loop counter) and IX -> its record. Unless A is 1 (the Hermit at #R$BBC1?), also sets bit 5 on a byte in the guard object table at ($C54C), indexed from A. Always sets bit 5 of (IX+4), the same "hit" flag tested elsewhere as bit 5 of the flags byte.
R $BF1A A Hit guard's slot number (1-5); $01 skips the guard-table update
R $BF1A IX Pointer to that guard's object record
C $BF1A,4 A = 1 (special case): skip the guard-table update below
C $BF1E,4 A = 5 - the hit guard's slot number
C $BF22,3 HL = that value
C $BF25,2 HL x2
C $BF27,2 HL = index x3
C $BF29,2 +2 (byte offset within the entry)
C $BF2B,4 DE = the guard-table base
C $BF2F,3 HL -> the entry; set bit 5 (hit)
C $BF32,4 Also set bit 5 on this record's own flags
@ $BF37 label=draw_energy_bar
c $BF37 Draw the energy bar
N $BF37 The energy display itself is a fixed pair of branching antlers drawn from the font glyphs at #R$AF0B/#R$AF83 (15 static glyphs each, forming the upper/lower halves); this routine doesn't draw them, it recolours a 63-byte attribute row at $5A40 from the energy value at $BF6F ($00-$0F, split into an ink/paper-ish bit pattern), so the antler artwork itself never changes shape - only its colour reflects the current energy level.
C $BF37,16 A = a colour byte packed from the energy value's low 3 bits and bit 3
C $BF37,3 Energy value -> bar length (bits 0-2) and low/high half flag (bit 6)
C $BF47,9 Fill $3F bytes of bar attributes at $5A40
C $BF37,3 get Energy level
C $BF3E,3 get Energy level
c $BF54 Border-flash sound with rising pitch (B = starting/growing delay)
N $BF54 Same border-toggle technique as #R$D9E9/#R$BD84, but the inner busy-wait length is B itself, which increments every outer pass (until bit 7 sets, i.e. B reaches 128) - giving a rising-pitch effect rather than a fixed tone.
R $BF54 B Starting inner-loop delay length (grows every outer pass)
C $BF54,3 A = 0; save AF/BC
C $BF57,4 Inner busy-wait of length B
C $BF5B,4 Toggle the border colour
C $BF5F,5 B grows every pass; stop once bit 7 is set
b $BF67 Arrow object, room hotspots and Robin's energy level
N $BF67 Cleared on every room change by #R$C276. The arrow is launched by #R$BC81, stepped each frame by #R$BCC2 and tested against guards by #R$BD49.
B $BF67,1 Arrow screen position (bit 7 = "arrow gone" flag)
B $BF68,1 Arrow direction (bits 6-7) and animation frame (bits 0-6); $0A-$0D = in flight
B $BF69,6 3 room hotspots, 2 bytes each: row byte ($FF = unused, bit 6 = triggered), then a second byte (see #R$BDA3) - also claimed by #R$AA31 for a guard's ranged threat, confirmed live via Emu80
B $BF6F,1 Energy level
c $BF70 START point after game loading
N $BF70 Where control lands once the game has finished loading. Sets up the stack, then runs the menu (#R$CD6C) and falls into the main game loop (#R$BF80) once a game starts.
C $BF71,3 set initial stack pointer
C $BF74,3 Menu procedure, return on game start
C $BF77,2 => Main per-frame game loop
c $BF79 Reset the stack and re-enter the menu procedure at $CD89
N $BF79 Called from #R$BF80 when the menu key is pressed mid-game. Disables interrupts, resets SP to $FFF4 (the same fixed stack top used at boot), and falls into #R$CD89 - the shared init tail that rebuilds the lookup tables, sets up interrupts, clears the screen and reopens the main menu. Effectively a soft-reset back to the title screen.
C $BF79,1 Disable interrupts
@ $BF80 label=main_loop
c $BF80 Main per-frame game loop
N $BF80 Called once per frame from the game's top level. Enables interrupts, then in turn: checks for a menu key via #R$C53B (falling back to #R$BF79 if pressed), moves Robin via #R$C6A2, steps the arrow (#R$BCC2) and every guard/boar/enemy (#R$AA31/#R$DBF8/#R$BBC1/#R$B919), runs all the collision/hit checks (#R$BD49/#R$BDA3/#R$BDE0/#R$BE43), flushes the changed screen cells (#R$C85C), scans event triggers (#R$D7F3/#R$DF03), draws HUD elements (#R$C055/#R$C4D2), then checks whether Robin's screen position has reached a room edge and, if so, scrolls to the adjacent room via #R$C22F.
C $BF81,3 Check the Space and Caps-Shift keyboard rows, return the state in carry
C $BF84,3 => Reset the stack and re-enter the menu procedure at $CD89
C $BF87,3 Update Robin
C $BF8A,3 Step the arrow one pixel along its diagonal flight, drawing it
C $BF8D,3 Update a patrolling enemy's direction/animation state
C $BF90,3 Cycle through and step one boar object per call
C $BF93,3 Check an arrow hit against nearby guards, then a border-flash sound
C $BF96,3 Check Robin against up to 3 room hotspots at $BF69
C $BF99,3 Check Robin against the boar table ($DD05) for a bump
C $BF9C,3 Check a sword swing against nearby guards
C $BF9F,3 Trigger the Sheriff of Nottingham's scripted ambush when Robin reaches the target room's centre
C $BFA2,3 Update the Hermit
C $BFA5,3 Update Bishop
C $BFA8,3 The Hermit heals Robin
C $BFAB,3 Flush changed character cells from the $E500 buffer to the real screen
C $BFAE,3 Scan the message/sound trigger table at $D57A for Robin's position
C $BFB1,3 Show the GAME OVER message and return to the menu
C $BFB4,3 Redraw the room when a special-event extra frame is armed
C $BFB7,3 Special-scenario check
C $BFBA,8 A = Robin's X ($CC85); off the left edge?
C $BFC2,5 Left edge: wrap X to the right, E = 2 (move right)
C $BFC9,4 Off the right edge?
C $BFCD,5 Right edge: wrap X to the left, E = 1 (move left)
C $BFD4,6 A = Robin's Y ($CC86); off the top edge?
C $BFDA,4 Top edge: wrap Y to the bottom, E = 8 (move down)
C $BFE0,4 Off the bottom edge?
C $BFE4,4 Bottom edge: wrap Y to the top, E = 4 (move up)
C $BFEA,3 Not at any edge: back to the top of the loop
C $BFF5,6 Room $69: the second win condition, see #R$D085
C $BFED,2 E = the room-change direction bits
C $BFEF,3 Move to an adjacent room on the 16x20 world map, by direction bits in E
C $BFFE,3 Print the victory message (reached via room $69), side-wipe back
C $C014,3 Play the death/edge-of-map melody ($8C74), called from #R$BF80
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
c $C055 Show the GAME OVER message and return to the menu
N $C055 Only acts once bit 7 of the extra-life-count byte at $D5A4 is set (the "game over" flag), and only on the specific animation frame $3C. Prints the fixed GAME OVER message at #R$B663 (real text starts at $B665, after $D619's 2-byte position header - not the "CONGRATULATIONS..." text at #R$B6AC, which is a separate string reached only via #R$D085), calls #R$8A7E, then resets to the menu via #R$BF79. This bit is set by #R$CBA5's unguarded double-decrement underflowing the counter to $FE/$FF (both have bit 7 set) whenever a critical-hit stagger happens at 0 or 1 extra lives left - i.e. this is the actual lives-based death/game-over path, not an accidental way to reach the ending.
C $C055,6 Bail out unless the "game over" flag (bit 7 of $D5A4) is set
C $C05B,6 Bail out unless Robin's current frame is $3C
C $C069,3 Print the GAME OVER message at #R$B663
C $C06C,3 Play the game-over melody ($8C3E), called from #R$C055
C $C06F,3 => Reset the stack and re-enter the menu procedure at $CD89
@ $C072 label=draw_current_room
c $C072 Draw current room on the shadow screen
N $C072 Draws the current room's base type via #R$C0AF, then its additional elements the same way, on top.
C $C075,3 HL -> the room-type descriptor table at $7B39
C $C07B,3 HL -> the world-map byte for the current room ($79F9)
C $C07F,11 A = the map byte; bit 7 -> $C0E8, the rest -> the room-type index at $C547
C $C08A,12 Low nibble of the room byte picks a patch value ($1C or $00), used later while drawing
C $C096,3 Draw the room's base type
C $C099,7 Room number < 256: also draw its additional elements
C $C0A1,9 Repoint $C54A/$C547 at the additional-elements table ($8511)
C $C0AA,3 Draw the additional elements on top
C $C096,3 Draw given room type on the shadow screen
C $C0AA,3 Draw given room type on the shadow screen
@ $C0AF label=draw_room_type
c $C0AF Draw given room type on the shadow screen
N $C0AF Walks a token list - a count byte followed by that many (coordinate, block number) pairs - and draws each block via #R$C0D1. #R$C072 calls this once for the room's base type and, separately, once for its additional elements, reusing the same code for both passes.
C $C0AF,3 Skip forward to the ($C547)-th descriptor in the table at
C $C0B2,1 get length
C $C0B4,2 zero => end, return
C $C0B6,2 D = token count; HL -> the first token's coordinate byte
C $C0B8,11 Unpack the coordinate: B = row (bits 3-7), C = column group (bits 0-2)
C $C0C4,2 A = the block number
C $C0C8,3 Draw one block token onto the shadow screen, with mirroring
@ $C0D1 label=draw_block_token
c $C0D1 Draw one block token onto the shadow screen, with mirroring
N $C0D1 Looks up the block's data address (see #R$5BA8 for its header-byte format) in the table at #R$5B00, draws (header AND $1F) x 8 pixel rows (4 bytes/row) into #R$EB00, then (header AND $7) attribute rows (4 bytes/row, or a single byte reused if the header's flat-attribute flag is set) into $E800, adjusting X for mirrored blocks along the way.
C $C0D3,3 Block number without its mirror flag
C $C0D9,4 Two bytes per entry in the $5B00 block table
C $C0DE,3 DE = the block's data address
C $C0E5,2 Header's mirror bit, XORed against the coordinate byte
C $C0E7,2 !!MUT-ARG!! current room byte
C $C0E9,2 The result decides whether the block gets flipped
C $C0EE,3 Horizontally mirror a block's rows using the bit-reverse table at $FD00
C $C0F6,3 Attribute row count, patched into #R$C14D's loop
C $C0FD,5 Column x4
C $C102,2 !!MUT-ARG!! The mirror-adjust patch flips the column
C $C10D,2 Header byte again, DE now on the pixel data
C $C10F,5 Row count x8
C $C117,4 Copy one pixel row, 4 bytes
C $C122,3 Loop the remaining rows
C $C128,2 Header bit 6 = one attribute for the whole block
C $C12E,3 Patches the attribute-row advance to INC DE or NOP
C $C132,4 Column bits x4
C $C137,12 Shift the row/column bits right 3 places
C $C143,1 Same mirror-adjust applied to the attribute address
C $C144,2 !!MUT-ARG!! attribute-column mirror-adjust ($1C or $00)
C $C14B,2 !!MUT-ARG!! attribute row count
C $C151,1 !!MUT-CMD!! INC DE ($13) or NOP ($00), set by $C12E
C $C157,2 $1C on to the next attribute row
R $C0D1 A Block number (bit 7 = horizontal-mirror flag)
R $C0D1 C Packed screen coordinate byte (see #R$79F9 token format)
c $C15E Draw a scenario-specific token in one of the 3 random opening rooms
N $C15E Compares the current room ($C548) against the three room numbers picked at random game start by #R$CF71 ($D3B2/$D3B4/$D3B6). If it matches one, draws a token from the corresponding fixed table ($C56A/$C573/$C57C) via #R$C0B2 (the token-drawing core shared with #R$C0AF).
C $C15E,7 HL = current room; compare to the first scenario room ($D3B2)
C $C16B,9 Compare to the second scenario room ($D3B4)
C $C175,7 Compare to the third scenario room ($D3B6); no match -> return
C $C17D,5 Room 3 matched: token table $C57C
C $C182,5 Room 2 matched: token table $C573
C $C187,3 Room 1 matched: token table $C56A
C $C18A,3 Draw the scenario token via #R$C0B2
@ $C18E label=copy_shadow_to_screen
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
C $C1D7,3 Flip the header's own mirror bit
C $C1DC,2 Row count from bits 0-2
C $C1DE,3 x8
C $C1E2,5 DE -> the row's right-hand end
C $C1ED,3 feeds the left byte to the $FD00 bit-reverse table
C $C1F0,3 !!MUT-ARG!! byte fed to the $FD00 bit-reverse table
C $C1F5,3 same for the right byte
C $C1F8,3 !!MUT-ARG!! byte fed to the $FD00 bit-reverse table
C $C1FC,2 Swap the two ends
C $C202,3 $07 on to the next pixel row
C $C20C,2 Header bit 6 set: the attribute row stays put
C $C20F,4 Otherwise IXl counts the attribute rows
C $C215,2 Read both ends
C $C218,2 Write them back swapped, no bit-reversal
R $C1D6 DE -> the block's data (header byte first)
b $C228
c $C22F Move to an adjacent room on the 16x20 world map, by direction bits in E
N $C22F E bit 0/1 = step right/left (column, wrapping within 0-15 via the AND $0F on the nibble), bit 2/3 = step down/up (row H, clamped/wrapped within 0-19 to match the #R$79F9 map size). Packs the new row/column back into the 16-bit room number at $C548 (high nibble = column, rest = row - see #R$79F9).
R $C22F A Direction bits (bit 0/1 right/left, bit 2/3 down/up), copied to E on entry
C $C22F,6 HL = current room x16 (room number's column nibble x $10)
C $C23B,10 Column +1 (E bit 0) or -1 (E bit 1), wrapped to 0-15
C $C249,12 Row +1, clamped to stay under 20 rows
C $C255,10 Row -1 with wraparound to the last row ($13)
C $C25F,9 Shift H's low bits into A (column nibble), 2 of 4
C $C268,8 Shift H's low bits into A (column nibble), 4 of 4
C $C270,5 Merge the row (L), save the room number to $C548
@ $C276 label=handle_room_entry
c $C276 Handle room entry: init guards on a room change, else blink a digit
N $C276 Compares the current room ($C548) to the last-drawn room ($D3B8/#R$C54C-relative). If unchanged, just blinks one room-indicator digit cell on the shadow screen. If the room changed: sets up Robin's object record at $B8FB (position/frame via #R$C8F7), clears and re-initialises the 4-guard table at #R$AC13 from the room's block flags (bits 4/7 of the map block select which movement-table pair each guard starts with, mirroring #R$AA31's own logic), calls #R$AA31 once per guard, and rebuilds a second 4-entry table at $DD05 from door/exit data at $DD3F. Also resets several per-room state bytes ($BF67.., $BC5D, $BBC2, $BBA0, $BB91, $AC43) and a second special object at $CC7C.
C $C278,5 Room number, biased to the $8A39 table
C $C27D,3 Compute an address in the 12-byte-stride table at $8A39
C $C282,3 R register salts the entry's low nibble
C $C294,3 Compute an address in the 12-byte-stride table at $8A39
C $C297,3 Remember the table base for this room
C $C29A,7 Clear the direction latch at $D1F1
C $C2A4,4 The Sheriff's ambush target room
C $C2A9,3 Same room as last time?
C $C2AF,4 Room number into the blink object's digits
C $C2CC,6 Digit frames come from $8DEA
C $C2E8,4 The Sheriff's object at $B8FB
C $C2FA,3 Special-room flag (bit 7) for this room
C $C312,3 Advance an object's animation, unlink it from the list if done
C $C31B,2 Bits 2-3 of the flags pick the guard-state reset
C $C323,3 Reset the guard-state working copy
C $C32C,3 Reset the guard-state working copy
C $C331,3 Reset the guard-state working copy
C $C334,3 Update each guard's route-availability flags for the current room
C $C337,4 The 4 room guards at $AC13
C $C342,4 Clear this guard's redraw flags
C $C346,2 Block bit 4: the guard starts "away"
C $C34A,3 Direction table $AC7F
C $C353,2 Otherwise block bit 7 chooses
C $C361,6 Chosen table into (IX+2/3)
C $C374,3 Update a patrolling enemy's direction/animation state
C $C37D,2 Single-column rooms have no boars
C $C381,4 The boar table at $DD05
C $C38B,3 Door data at $DD3F
C $C38F,2 Step until the room's high byte is passed
C $C393,3 Back up one, that's the match
C $C39F,2 Door bit 7 picks the frame table
C $C3AD,6 Into (IX+2/3)
C $C3BF,6 Clear the 7-byte arrow object at $BF67
C $C3C9,5 Reset the per-room state bytes
C $C3E0,6 Robin's own frame base $8D80
C $C3E6,4 Robin's object record
C $C3F6,3 Advance an object's animation, unlink it from the list if done
R $C276 A Room-entry flags: bits 1-3 pick which guard-state reset (#R$DE8D/#R$DE97/#R$DEA1) runs
c $C3FA Compute an address in the 12-byte-stride table at $8A39
N $C3FA Extracts bits 4-5 of A (0-3) and returns HL = that index x 12 + $8A39. Called from #R$C276 while setting up the score/room-indicator digit blink.
R $C3FA A Index in bits 4-5
R $C3FA O:HL -> the matching 12-byte entry in the table at $8A39
C $C3FA,4 Shift bits 4-5 down
C $C3FE,2 Mask to 0-3
C $C400,3 HL = the index
C $C403,3 Save it; HL x2
C $C406,1 HL = index x3
C $C407,2 HL = index x12
C $C409,4 Add the table base $8A39
c $C40E Look up current room number in the $C550 table
N $C40E Returns immediately if the room number's high byte is non-zero (rooms $0100+ never match). Otherwise scans the 26 bytes at #R$C550 for the room's low byte; on a match, recolours the shadow attribute area $E800..$E9FF.
C $C414,5 Search table at $C550 for current room number
C $C421,3 HL = attribute area, BC = $0200 bytes to scan
C $C427,4 Zero cell: skip
C $C42B,8 Non-black paper (bits 3-5): force attribute $07
C $C433,9 Black paper, ink != $07: force attribute $45
C $C43C,7 Next cell, loop $0200 times
c $C444 In room $BB, recolour any non-black attribute cell to $04
N $C444 Only acts in room $BB. Scans the whole shadow attribute area ($E800, $0240 bytes) and forces any cell with a non-zero paper colour (bits 3-5) to attribute $04, flattening the room's background colour.
C $C444,10 Only run in room $BB
C $C44E,6 HL/BC = the shadow attribute area
C $C454,7 If this cell's paper colour is non-zero, force it to $04
c $C462 Print a hint message for certain single-column rooms
N $C462 Only runs for single-column rooms ($C549=0). If the flag at $D59F is clear and the stage counter $D5A1 hasn't reached 3, checks whether the room is $65 or $6E and prints message $4E with a room-specific attribute (DE). Otherwise (or once those conditions no longer hold) checks rooms $79/$BB (also gated by $D5A1) and prints message $4D the same way; if the room is $6E, instead calls #R$C4B6.
C $C462,4 Single-column rooms only
C $C467,4 The $D59F flag diverts to the second message group
C $C46D,5 So does stage 3 of the $D5A1 counter
C $C474,2 Message group $4E
C $C476,5 Room $65 gets its own attribute
C $C480,3 Room $6E gets another
C $C483,4 Any other room prints nothing
C $C487,3 Attribute for the print below
C $C48A,3 A = $4E - #R$D7CE index $0E, the door/gate icon (#R$B630) for the $65/$6E forest-door pair
C $C48E,2 Message group $4D
C $C490,5 Room $79 only matters once stage 3 is reached
C $C49A,5 Room $79 and its attribute
C $C4A1,5 Otherwise room $BB
C $C4AC,3 A = $4D - #R$D7CE index $0D, the open/missing-gate icon (#R$B5F9) for the $79/$BB gate/key pair
C $C4B0,2 Room $6E instead retires the whole trigger
C $C4B2,3 Clear the $D59F trigger flag, reset the room-position log, print a message
c $C4B6 Clear the $D59F trigger flag, reset the room-position log, print a message
N $C4B6 Called from #R$C462/#R$C517. If the flag at $D59F is set, clears it, re-seeds the room-position log at $D543 via #R$D454, and prints a fixed message ($B52D).
C $C4B6,9 HL -> the trigger flag at $D59F; skip if it's already clear
C $C4BF,5 Clear the flag
C $C4C4,3 Hard-code the first two entries of the room-position log at $D543
C $C4CC,3 Print the string at the address pointed to by
c $C4D2 Redraw the room when a special-event extra frame is armed
N $C4D2 Calls the extra-frame callback at ($C4D3) (a no-op by default, from #R$DB17, or armed by #R$DA0F for special-event rooms). If $DBEA is non-zero, teleports Robin: state $01 warps to room $9C (the dungeon-gate room after the Sheriff of Nottingham's ambush, see #R$B867), any other non-zero state warps to room $CC instead - then fully redraws the room ($D03F/$C072/$C15E/$C40E/$C517/$D5A7/$C18E/$C806), redraws the score digit (#R$C276), and clears the $E500 buffer.
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
N $C53B Called from #R$BF80 once per frame; carry clear sends it back to the menu (#R$BF79). Returns early with carry set if Space is down, otherwise reports Caps Shift's state instead. Which combination is actually meant to trigger the reset is not confirmed.
C $C53B,6 Read the Space row ($7FFE); return early if Space is pressed
C $C541,5 Read the Caps-Shift row ($FEFE); return its bit 0 in carry
b $C547 Current room number and the drawing/guard-table pointers derived from it
B $C547,1 Descriptor index: room type $00..$26 when $C54A points at #R$7B39, room number $00..$FF when it points at #R$8511
W $C548,2 Current room number, $0000..$013D (index into the world map at #R$79F9)
W $C54A,2 Descriptor table base address: #R$7B39 (room types) or #R$8511 (additional elements)
W $C54C,2 Reused scratch pointer: the room's guard table (#R$AC13/#R$DDF0/#R$BF1A) in most contexts, but repointed elsewhere within #R$C276/#R$AA31 for other 3/12-byte-stride lookups - not a single fixed target
W $C54E,2 -> the room's boar table at #R$DD05 (set by #R$C276)
b $C550 Rooms that get the special attribute recolour (26 entries, scanned by #R$C40E)
N $C550 Flat list of room low bytes, linearly scanned - a membership set, not indexed. The values are contiguous column pairs walking down rows $3-$A, i.e. a rectangular region of the map.
B $C550,26,8
b $C56A Scenario token lists for the 3 random opening rooms, drawn by #R$C15E
N $C56A Tokens for the first scenario room (#R$D3B2), in #R$C0B2's format: a count byte followed by that many 2-byte tokens (see #R$7B39). Places blocks #R$659B/#R$662C/#R$66BD/#R$673F (block numbers $1C-$1F) as a 2x2 arrangement - the Ent's fixed room decoration, confirmed by a player screenshot showing the large red tree-face figure.
B $C56A,1,1
B $C56B,8,2
N $C573 Tokens for the second scenario room (#R$D3B4). Places blocks #R$69D8/#R$6A5A/#R$6ADC/#R$6B6D (block numbers $24-$27) as a 2x2 arrangement, same layout as #R$C56A's Ent - the Hermit's hut, confirmed by a player screenshot.
B $C573,1,1
B $C574,8,2
N $C57C Tokens for #R$D3B6 - wherever Robin starts the game, not an independently-chosen room (see #R$CF71). Places blocks #R$67C1/#R$6852/#R$68D4/#R$6956 (block numbers $20-$23) as a 2x2 arrangement, same layout as #R$C56A's Ent - a "split tree", confirmed by a player screenshot and by a player-sourced walkthrough as a deliberate landmark unique to the starting room (these 4 blocks are placed nowhere else on the map, matching the walkthrough's claim exactly).
B $C57C,1,1
B $C57D,8,2
c $C585 Set up a glyph draw: pick branch targets, compute screen row/column
N $C585 Called from #R$C6D6 while drawing a sprite frame's glyph/mask. (HL) gives a width-class nibble (compared against $04) that selects which pair of constants get patched into three self-modified branch sites ($C603/$C5E3/$C647, consumed by #R$C5E4); bit 7 of (HL) sets/clears another patch byte at $C651. B/C on entry give a row/column, converted to a shadow-screen address at #R$EB00, before falling into the pixel-plot loop at #R$C5E4/#R$C5D8.
C $C586,3 Width class from the glyph's first byte
C $C58D,1 Bit 7 of the parameter picks which patch set goes in
C $C591,9 $00 disables the three wide-glyph branches
C $C59C,5 $06 into $C603
C $C5A1,5 $07 into $C5E3, the JR displacement at $C5E2
C $C5A6,5 $08 into $C647
C $C5B2,3 $AF (XOR A) or $00 into $C651
C $C5B6,3 Glyph data pointer saved for #R$C5E4
C $C5B9,7 Row = B/8
C $C5C0,5 Column = C/4, less 3
C $C5C7,2 Mirrored glyphs shift one column left
C $C5D1,4 Onto the $EB00 shadow screen
R $C585 HL Width/height nibble byte and mirror flag (bit 7)
R $C585 B Row
R $C585 C Column
R $C585 A Glyph parameter byte, copied to E on entry
C $C5E2,2 !!MUT-ARG!! wide-glyph branch displacement, set by #R$C585
c $C5E4 Glyph pixel-row draw loop (continues the routine at #R$C585)
N $C5E4 Split from #R$C585 by the disassembler even though it's one routine: #R$C585 sets up self-modified branch targets (patched bytes at $C603/$C5E3/$C647, chosen from the glyph width nibble at (HL)) and jumps here; this block does the actual row lookup and XOR-plot of glyph pixels into $E500-relative screen data using the bit-reverse table at $FD00 (as in #R$C1D6/#R$C6D6), then loops back into #R$C585's counters via #R$C5D8/#R$C5DB. The exact meaning of each self-modified branch is not fully confirmed.
C $C5E4,4 Character code indexes the table at $C682
C $C5EB,5 Glyph pointer from the base saved at $C6A0
C $C5F0,3 Zero means a blank glyph
C $C5F7,3 x8
C $C5FA,4 Onto the font data at $9AB3
C $C602,2 !!MUT-ARG!! JR displacement patched by #R$C585 ($C603)
C $C604,3 feeds the byte to the $FD00 bit-reverse table
C $C607,3 !!MUT-ARG!! byte fed to the $FD00 bit-reverse table
C $C60A,2 XOR-plot it onto the screen
C $C615,4 Wrap the column to 0-31
C $C61F,5 Next row
C $C626,10 Pack 3 row-presence bits from B into C
C $C631,4 Onto the $E500 change buffer
C $C636,6 $1E past the glyph base
C $C646,2 !!MUT-ARG!! JR displacement patched by #R$C585 ($C647)
R $C5E4 HL Character code, used as an offset into the table at $C682
c $C648 Merge one glyph attribute cell onto the screen, advance to the next
N $C648 Continues the glyph-draw routine at #R$C585/#R$C5E4 (loops back into it via #R$C640). Only copies the source attribute byte from the table at $C682 over the destination at (DE) when the destination is currently blank, so glyphs blend into existing scenery rather than overwriting it; then advances DE to the next character cell, wrapping to the next row every 32 columns.
R $C648 A Attribute cell value, copied to C on entry
C $C648,3 BC = A (attribute index)
C $C64B,4 HL -> source attribute at $C682+BC
C $C651,1 !!MUT-CMD!! XOR A ($AF) or NOP ($00), set by #R$C585
C $C656,4 Skip if the destination cell is already occupied
C $C65A,5 Copy the source attribute to (DE) unless it's blank
C $C65F,5 A = E's row bits; HL -= BC
C $C664,3 C = E's column bits
C $C667,4 E = (column+1) mod 32, merged with the row bits
C $C66B,6 Pop registers, loop the column count
C $C671,5 Advance E by 32 columns, carry into D
b $C682 Horizontal-mirror index remap for 6-cell glyph rows
N $C682 Indexed directly (base + A by #R$C5E4, base + BC by #R$C648, no multiplier). Five groups of 6, each reversed in place, so index i in row r maps to 6r + (5 - i mod 6) - the mirrored cell in the same row.
B $C682,6,6 Row 0: indices 0-5, reversed
B $C688,6,6 Row 1: indices 6-11, reversed
B $C68E,6,6 Row 2: indices 12-17, reversed
B $C694,6,6 Row 3: indices 18-23, reversed
B $C69A,6,6 Row 4: indices 24-29, reversed
B $C6A0,2,2 Padding
@ $C6A2 label=update_robin
c $C6A2 Update Robin: move, pick action, advance animation
N $C6A2 Called once per frame from #R$BF80. Runs every other frame (toggle at $C6A3), unless Robin is mid-animation ($CC7A/$CC7B non-zero, forcing every frame). Calls #R$C95A to move him, #R$C9E7 to pick his sword/arrow/walk action, then sets his object record's redraw flags (IX = $CC7C) and calls #R$C8F7 to advance/redraw his frame.
C $C6A2,6 !!MUT-ARG!! Toggle a run-every-other-frame flag at $C6A3
C $C6AA,12 Unless mid-animation, force this frame's run regardless of the toggle
C $C6C0,12 IX -> Robin's own object record; set its redraw flags
C $C6BA,3 Filter the movement direction bits against collisions, move the player
C $C6BD,3 Robin's action dispatcher
C $C6D2,3 Advance an object's animation, unlink it from the list if done
@ $C6D6 label=draw_sprite_frame
c $C6D6 Draw a sprite frame onto the shadow screen, XORed
N $C6D6 A = frame number, doubled to index a pointer table (base patched into the LD HL,$0000 at $C6D7 by the caller). Frame data holds a pointer to font glyph data (drawn via #R$C585/#R$C790/#R$C8B7), a height in IYl, and per-row (position, length, source) tuples applied at #R$C723 by XORing bytes into the shadow screen at #R$EB00.
C $C6D7,3 !!MUT-ARG!! frame base, written by callers as LD ($C6D8),HL
C $C6DA,3 Frame number x2
C $C6E0,3 DE = the frame's data address
C $C6E4,3 Set up a glyph draw
C $C6E7,3 Save the background under a sprite frame to the buffer at $E500
C $C6EA,3 Horizontally mirror a sprite frame's row data
C $C6EF,3 IYl = the frame's row count
C $C6F6,3 Column's low 2 bits
C $C6F9,4 x16 gives the shift-table offset
C $C700,4 The shift-copy chain at $C74F
C $C704,2 Patch a RET in to stop after the right number of shifts
C $C708,3 Column - 8
C $C70E,4 /8, capped to 5 bits
C $C714,10 Fold 3 row bits from B into the offset
C $C71F,4 Onto the $EB00 shadow screen
C $C724,6 E:D:C = this row's position/length/source tuple
C $C72A,3 Shift the 32-bit value E:D:C:B right by 8 bits
C $C72E,3 XOR the shifted bytes onto the cells, one at a time
C $C73D,4 $1D on to the next row
C $C741,5 Loop the frame's rows
C $C748,2 Put the patched byte back
R $C6D6 A Frame number (pointer table base is a self-modified operand, patched by the caller)
c $C74D Shift the 32-bit value E:D:C:B right by 8 bits
N $C74D Called once per row from #R$C6D6's plot loop with EDCB = the row's (position,length,source) tuple. Always shifts by a fixed 8 bits (32 RR passes through the carry chain E->D->C->B), rather than by a variable column-bit count; exact purpose within the plot loop is not fully confirmed.
R $C74D E:D:C:B 32-bit value to shift (E highest byte, B lowest)
R $C74D O:E:D:C:B The value shifted right by 8 bits
C $C74F,8 Bit 1 of 8: RR E/D/C/B
C $C757,8 Bit 2 of 8: RR E/D/C/B
C $C75F,8 Bit 3 of 8: RR E/D/C/B
C $C767,8 Bit 4 of 8: RR E/D/C/B
C $C76F,8 Bit 5 of 8: RR E/D/C/B
C $C777,8 Bit 6 of 8: RR E/D/C/B
C $C77F,8 Bit 7 of 8: RR E/D/C/B
C $C787,8 Bit 8 of 8: RR E/D/C/B
c $C790 Save the background under a sprite frame to the buffer at $E500
N $C790 Called from #R$C6D6 while setting up a sprite frame. (HL) supplies width/height nibbles and a flag byte (bit 7/6 select self-modified skip logic at $C7F0/$C7FB for mirrored frames); a pointer table at $8E12 (indexed by the flag byte) gives the screen block to copy row by row into the save-buffer at $E500, so the original background can later be restored when the sprite moves or is erased.
C $C794,5 Column, floored at $10
C $C79B,3 Back off by 8
C $C79E,2 4 rows to copy
C $C7A1,6 Width class from bits 4-6 of the width/height byte
C $C7A7,2 Class 0 has nothing to save
C $C7AA,3 A row off the cell grid needs one row more
C $C7B1,2 L = the frame's flag byte
C $C7B4,2 Bit 7 is the mirror flag
C $C7BA,3 Patches the pixel-row skip at $C7F0 to INC BC or NOP
C $C7BE,2 Bit 6 does the same for the attribute rows
C $C7C4,3 Patches the attribute-row skip at $C7FB
C $C7C8,4 Flag byte x2, mirror bit masked off
C $C7CE,4 Indexes the screen-block table at $8E12
C $C7D2,4 HL = the block pointer
C $C7D6,1 Park it on the stack
C $C7D9,5 Row snapped to the cell grid
C $C7DE,2 x4
C $C7E0,4 Column /4
C $C7E4,3 Combine into the buffer offset
C $C7E7,4 Onto the $E500 save buffer
C $C7EE,2 Copy one byte of the row
C $C7F0,1 !!MUT-CMD!! INC BC ($03) or NOP ($00), set by $C7BA
C $C7F2,4 E bytes to a row
C $C7F7,4 $20 down to the next buffer row
C $C7FB,1 !!MUT-CMD!! INC BC ($03) or NOP ($00), set by $C7C4
C $C7FD,4 D rows in all
R $C790 HL Frame data pointer (width/height nibbles + flag byte)
R $C790 B Row
R $C790 C Column
c $C806 Expand the $FE00 row-pointer table into shadow-screen rows
N $C806 IX walks the row-pointer table at $FE00 (also used by #R$CE81/#R$C85C), HL walks the shadow area from $EAFE. For each of 18 rows, copies 32 bytes from the address stored at (IX+0/1)+2 to (HL), advancing both by one row's stride. The overall purpose (what these rows represent - likely per-row attribute or pixel data assembled during room drawing) is not fully confirmed.
C $C806,3 HL = destination base $EAFE
C $C809,4 IX = source pointer-table base $FE00
C $C80D,3 BC = row/byte counter ($0FC0)
C $C810,4 Advance HL to the next destination row (skip a 4-byte gap)
C $C814,6 DE = the row's source address, from the pointer table
C $C81A,2 DE += 2 (skip the table entry's own header)
C $C81C,4 Advance IX to the next pointer-table entry
C $C820,56 Copy one row: 28 unrolled LDI (32 bytes)
C $C858,3 Loop via BC's parity until all rows are done
@ $C85C label=flush_e500_buffer
c $C85C Flush changed character cells from the $E500 buffer to the real screen
N $C85C Scans the flag area at #R$E500 (28 flag bytes per row x 18 rows, IXl counts rows) for a non-zero "changed" marker. For each one found, computes the real Spectrum screen pixel address ($4000-region) from the cell's row/column and copies its 8-byte glyph from the shadow buffer at $EB00+$8D00 onto the screen, then clears the flag and continues scanning.
C $C85C,3 The change-flag area at $E502
C $C85F,3 18 rows to scan
C $C864,2 28 columns to a row
C $C866,3 A non-zero flag marks a changed cell
C $C869,3 Next column
C $C86C,4 Step past the row padding
C $C870,5 Loop all 18 rows
C $C876,1 Consume the flag
C $C878,4 $0300 on reaches the real attribute byte
C $C87F,2 A black attribute swaps in the alternate accumulator
C $C885,3 Store it back with bit 7 cleared
C $C88B,7 Screen third and coarse row bits out of H
C $C892,4 D = the $40 screen page
C $C896,4 Column masked to 0-31
C $C89A,7 Fold the row-within-third bits back in
C $C8A1,3 H onto the $EB shadow page
C $C8A4,3 8 rows, $20 apart
C $C8A7,2 Copy one byte to the real screen
C $C8A9,1 Next screen row
C $C8AA,3 Next shadow row
C $C8B1,4 Back to the flag area for the next cell
c $C8B7 Horizontally mirror a sprite frame's row data (companion to #R$C1D6)
N $C8B7 Called from #R$C6D6 after the width/height header is read. If the frame's mirror-flag bit (bit 7 of the header byte) differs from the last-drawn state, flips the stored flag and bit-reverses each row's 3 data bytes via the table at $FD00 (same technique as #R$C1D6), swapping the two ends of each row's tuple so the frame draws flipped.
C $C8BA,3 Caller's flag against the stored one; only a changed bit 7 matters
C $C8BF,4 Flip the stored mirror flag
C $C8C4,3 IYl = the frame's row count
C $C8C9,3 DE = the tuple's far end
C $C8D1,3 feeds the byte to the $FD00 bit-reverse table
C $C8D4,3 !!MUT-ARG!! byte fed to the $FD00 bit-reverse table
C $C8D8,1 Length byte gets the same treatment
C $C8DC,3 !!MUT-ARG!! byte fed to the $FD00 bit-reverse table
C $C8DF,3 Swap the two ends
C $C8E3,4 Source byte reversed in place
C $C8E7,3 !!MUT-ARG!! byte fed to the $FD00 bit-reverse table
C $C8EC,3 4 bytes per row tuple
C $C8EF,4 Loop the frame's rows
R $C8B7 A Mirror-flag byte to compare against the frame header
R $C8B7 HL Pointer to the frame's header byte
@ $C8F7 label=advance_object_animation
c $C8F7 Advance an object's animation, unlink it from the list if done
N $C8F7 IX -> object record. Does nothing unless (IX+4) bit 0 is set. Then a countdown byte at IX is decremented; on reaching -1, the record is spliced out of its linked list (the next record's link is copied over this one, with a $FF marker handled as end-of-list). A status byte's bit 1, if set, redraws the current frame via #R$C6D6 to erase it; bit 2, if set, advances to the next frame and redraws it the same way.
C $C8F7,4 (IX+4) bit 0 clear: this record is not animated
C $C901,1 Tick the countdown byte down
C $C902,3 Only -1 unlinks the record
C $C905,4 Otherwise skip straight to the status byte at +4
C $C90B,2 DE = this record
C $C90E,2 Copy the next record's first byte over it
C $C911,3 D:E = the next record
C $C917,2 $FF marks a record that is itself gone
C $C91B,6 Chase past it to the one after
C $C923,3 Write the resolved link back
C $C927,3 Marker byte into (IX+8)
C $C92B,2 Status bit 1 asks for an erase
C $C92F,2 Consume it
C $C933,5 The current frame's params
C $C938,3 Draw a sprite frame onto the shadow screen, XORed
C $C93C,2 Status bit 2 asks for a step
C $C940,4 Consume it, and arm the erase for next time
C $C944,5 DE = the frame slot
C $C94A,5 The next frame's params
C $C950,5 Shift the frame 3 bytes down
C $C956,3 Draw a sprite frame onto the shadow screen, XORed
R $C8F7 IX Object record
c $C95A Filter the movement direction bits against collisions, move the player
N $C95A Called from #R$C6A2. Reads the requested direction bitmask into E (bit 0 = right, bit 1 = left, bit 2 = down, bit 3 = up, matched to the DEC/INC pairs below) via #R$D1E9. Each axis pair (right/left, down/up) and the fire bit is only allowed to change from the previous frame's bits at $CC8B once Robin is aligned to a cell boundary on the relevant axis - a changed bit requested off-boundary is simply dropped for this frame, so mid-cell direction changes have no effect until he reaches the next cell. The filtered result is saved back to $CC8B; for each of its surviving direction bits it then calls the matching collision check (#R$DD80/#R$DD6F/#R$DD9F/#R$DD93 - each tests attributes via #R$DDD6) and only then updates the player's pixel position at $CC85.
C $C95A,3 Dispatch to the active control scheme's input handler
C $C95D,4 BC = the previous frame's bits from $CC8B
C $C962,3 Right/left changed since last frame?
C $C967,5 Wait for a cell boundary before turning
C $C96E,9 Copy E's right/left bits into C
C $C977,4 Same test, down/up bits
C $C97D,5 Same cell-boundary gate
C $C984,9 Copy E's down/up bits into C
C $C98D,4 Fire bit changed?
C $C993,12 Centred in the cell on both axes?
C $C9A1,9 Copy E's fire bit into C
C $C9AA,5 E = final filtered direction bitmask, saved to $CC8B
C $C9AF,7 Skip movement entirely if $CC87 (state/mode) is $06 or more
C $C9BD,3 Collision check
C $C9C7,3 Collision check
C $C9D1,3 Collision check
C $C9DC,3 Collision check
@ $C9E7 label=robin_action_dispatch
c $C9E7 Robin's action dispatcher: pick sword/arrow frames, then jump by facing
N $C9E7 If Robin's animation code ($CC7B) is non-zero, waits for it to finish (or, for code $6E, calls #R$CB9D). Otherwise, if idle ($CC7A=0), fire pressed (bit 4 of $CC8B) and standing still and centred in a cell, picks between a sword attack (#R$CA44) or an arrow shot (#R$CA4C) based on the movement bits at $CC8B. Finally looks up a per-facing handler in the table at $CD42 (indexed by $CC87) and jumps to it with E = the FUDLR bitmask from $CC8B (the same layout #R$D1E9's handlers return: bit 0 right, 1 left, 2 down, 3 up, 4 fire).
C $C9E7,3 BC = default return address (pushed for the handler to RET to)
C $C9F3,3 Robin's critical-hit stagger
C $C9EB,4 Animation code ($CC7B) active: wait it out / handle $6E
C $C9F9,3 Skip action selection unless idle ($CC7A = 0)
C $C9FF,5 Skip action selection unless the FIRE bit (bit 4) of $CC8B is set
C $CA06,14 Only act when standing on a cell boundary ($CC85/$CC86 aligned)
C $CA14,5 And no down/up movement pending
C $CA19,5 Left/right bits pending: arrow shot ($CA2D)
C $CA1E,10 Else A = sword frame code (1 or 2) by facing
C $CA28,3 Sword-attack entry into #R$CA4C's frame-table picker
C $CA2D,3 Pick Robin's sprite frame table for his current action and facing
C $CA30,11 HL = per-facing handler from the table at $CD42
C $CA3B,9 Load the handler pointer; jump with E = the movement bits
c $CA44 Sword-attack entry into #R$CA4C's frame-table picker
N $CA44 Called from #R$C9E7/#R$CB21 for a sword swing (as opposed to #R$CA4C's own entry, used for an arrow shot). Sets up the return address and E=1, then jumps into #R$CA4C at its #R$CA52 entry point to pick the actual frame table.
C $CA44,4 Push a return address; E = 1 (sword variant)
@ $CA4C label=pick_robin_frame_table
c $CA4C Pick Robin's sprite frame table for his current action and facing
N $CA4C D = facing bit (0/1, from the carry bit passed in via #R$CA44). If an arrow is in flight ($D59E/$D5A0 both non-zero), scans the guard object table at #R$AC13 (11 bytes/entry, same layout used by #R$AA31) for one within 50 pixels of Robin ($CC85) that isn't already flagged hit, and returns the "arrow" frame table; a hit guard's counter at $D5A0 is decremented and a message printed via #R$D619 when it reaches zero. Otherwise checks the sword flag at $D59D, then the movement bits at $CC8B, to choose between sword/attack, walk, or idle frame tables (at $CC9D/$CCA8, $CCB3/$CCBE, $CCDF/$CCEA, $CCC9/$CCD4).
R $CA4C C Carry: facing bit (0/1); only via the #R$CA52 entry, entered from #R$CA44
R $CA4C O:A Small type code (2-5) for the picked frame table
R $CA4C O:HL The picked frame table address
C $CA4C,6 Push the default return frame; E = 0 (arrow variant)
C $CA52,6 D = facing bit (1 or 0) from the carry
C $CA5A,3 set Sword/arrow/pickup action timer
C $CA69,7 IX = guard object table at $AC13; BC = Robin's position
C $CA76,12 Skip inactive or already-hit guards (flag bits 0/5)
C $CA82,12 Distance from Robin's column; too far ($32+) means no block
C $CA8E,6 Advance IX to the next guard, loop 4 times
C $CA94,15 If found: decrement the "guards remaining" counter, maybe print a hint
C $CAA3,3 Print the string at the address pointed to by
C $CAAA,3 Frame table $CCC9, mirror $CCD4 (facing bit 0 of D)
C $CAB5,4 $D59D (sword flag) clear: use the walk tables ($CAE1)
C $CABE,3 Frame table $CCB3, mirror $CCBE
C $CAC9,5 Movement bit 2 set: use the moving-attack tables
C $CAD6,3 Frame table $CC9D, mirror $CCA8
C $CAE4,3 Frame table $CCDF, mirror $CCEA
c $CAEF Store Robin's frame pointer (HL, adjusted by facing) and facing byte (A)
N $CAEF Not reached by any direct CALL/JP - only via the small generated call/RET stubs at #R$CB11 and similar tables, which is why static analysis finds no caller. If facing bit 0 (E) is clear, HL is decremented first (selecting the mirrored half of a frame pair) before being stored to $CC7E, alongside the facing byte A at $CC87.
R $CAEF A Robin's facing byte, stored to $CC87
R $CAEF HL Frame pointer, decremented first when facing bit 0 is clear
R $CAEF E Facing bits; bit 0 selects the mirrored half of the frame pair
c $CAFB Facing/state $06 handler: run the per-direction handler #R$CB21
C $CAFB,3 Per-direction handler
c $CAFF Facing/state $07 handler: run the per-direction handler #R$CB21
C $CAFF,3 Per-direction handler
c $CB03 Facing/state $08 handler: launch an arrow (#R$BC81), then #R$CB21
C $CB03,3 Launch Robin's arrow when he shoots, if none is already in flight
C $CB06,3 Per-direction handler
c $CB0A Facing/state $09 handler: launch an arrow (#R$BC81), then #R$CB21
C $CB0A,3 Launch Robin's arrow when he shoots, if none is already in flight
C $CB0D,3 Per-direction handler
c $CB11 Facing/state $0A handler: run the per-direction handler #R$CB21
C $CB11,3 Per-direction handler
c $CB15 Facing/state $0B handler: run the per-direction handler #R$CB21
C $CB15,3 Per-direction handler
c $CB19 Facing/state $0C handler: run the per-direction handler #R$CB21
C $CB19,3 Per-direction handler
c $CB1D Facing/state $0D handler: run the per-direction handler #R$CB21
C $CB1D,3 Per-direction handler
c $CB21 Per-direction handler: wait out the animation timer, then pick a frame
N $CB21 Reached (from #R$CB11/#R$CB15, part of the facing-direction table built in #R$C9E7) with the caller's stack already set up for a tail-call. While the animation timer at $CC7A hasn't reached 0, just unwinds and returns. Once it has: if the "action" bit (4) of the movement byte is set, dispatches to the sword/arrow pickers #R$CA44/#R$CA4C as in #R$C9E7; otherwise picks between a walking frame table ($CD13/$CCFE) or calls one of #R$CC13/#R$CC34 depending on the low movement bits and facing.
C $CB21,6 Decrement the animation timer; keep waiting until it reaches 0
C $CB27,7 Action bit (4) set: take the sword/arrow branch
C $CB2E,6 Drop the tail-call returns; left/right pending -> arrow ($CB41)
C $CB34,9 Else A = sword frame code (1 or 2) by facing
C $CB3D,3 Sword-attack entry into #R$CA4C's frame-table picker
C $CB41,3 Pick Robin's sprite frame table for his current action and facing
C $CB45,4 No action, no movement bits -> call handler ($CB59)
C $CB49,10 Moving: frame table $CD13 (A=3) or $CCFE (A=2) by facing
C $CB59,7 Standing still: call #R$CC13 or #R$CC34 by facing
C $CB68,3 Timer still running: discard the caller's return address, return
c $CB6B Pick a walking-frame table by movement bit (low nibble of A)
N $CB6B Part of the facing-direction dispatch chain from #R$C9E7/#R$CB21. Tests bits 0-3 of A (right/left/down/up) in turn and returns A = a small type code (2-5) with HL -> the matching frame table ($CCFC/$CD11/$CD26/$CD2D); returns with the stack popped and no result if no bit is set.
R $CB6B A FUDLR bitmask (bit 0 right, 1 left, 2 down, 3 up, 4 fire)
R $CB6B O:A Small type code (2-5), if a frame table is picked
R $CB6B O:HL The picked frame table address, if a frame table is picked
C $CB6B,2 A = movement bits (fire bit masked off)
C $CB6D,2 None set: return with the stack popped, no result
C $CB6F,5 RIGHT?
C $CB74,5 LEFT?
C $CB79,5 DOWN?
C $CB7E,5 UP?
C $CB85,5 Bit 0 (right): A=2, HL=$CCFC
C $CB8B,5 Bit 1 (left): A=3, HL=$CD11
C $CB91,5 Bit 2 (down): A=4, HL=$CD26
C $CB97,5 Bit 3 (up): A=5, HL=$CD2D
@ $CB9D label=robin_stagger
c $CB9D Robin's critical-hit stagger: penalise the counter, recover after a timer
N $CB9D Called from #R$C9E7's action code $6E, set by #R$BE25 when a hazard/guard hits Robin while his energy is already critical. Plays a short border-flash (not "evil laughter" - that's reserved for #R$B867), penalises the extra-life counter, and sets Robin's state ($CC87) to $0E or $0F depending on facing - the stagger/lay-down state handled by #R$CBD6/#R$CBC7, which recovers his energy once its timer runs out. A stagger/penalty, not a game-over - Robin keeps playing.
C $CB9D,1 A = 0
C $CB9E,3 Clear the action timer $CC7A
C $CBA1,1 A = $FF
C $CBA2,3 Set the border-flash colour/count operands without flashing
C $CBA5,5 Penalise the extra-life counter at $D5A4 by 2 (offsets #R$D91A's own +1) - unguarded, so at counter 0 or 1 this underflows to $FE/$FF, setting bit 7 (the "game over" flag #R$C055 checks) and ending the game
C $CBAA,3 Print an extra-life-count message, increment the counter and its displayed digit
C $CBAD,7 Arm a $001E recovery timer at $D1F1
C $CBB4,3 A = Robin's facing ($CC87)
C $CBB7,6 Facing bit 0 (via RRA): frame table $CD34, new state $0F
C $CBBD,2 Bit set: skip the other branch
C $CBBF,5 Otherwise: frame table $CD3B, new state $0E
C $CBC4,3 => Store Robin's facing (A) and frame-table pointer
c $CBC7 Stagger recovery, facing $01: lay down, then refill energy
N $CBC7 State $0F, entered only from #R$CB9D's critical-hit stagger. Decrements the animation timer at $CC7B; while non-zero, just returns (popping the caller) - Robin lies staggered. At 0, picks frame table $CD22 and falls into #R$CBE3 to refill Robin's energy, ending the stagger.
C $CBC7,4 Decrement the animation timer at $CC7B
C $CBCB,2 Reached 0: fall through to finish the pickup
C $CBCD,2 Still counting: pop the caller and return
C $CBCF,5 A = state SIT LEFT; HL = frame table $CD22
C $CBD4,2 => Refill Robin's energy to maximum and redraw the bar
c $CBD6 Stagger recovery, facing $00: lay down, then refill energy
N $CBD6 State $0E, same as #R$CBC7 but for the opposite facing - picks frame table $CD0D, then falls straight into #R$CBE3. Both are reached only from #R$CB9D via the #R$CD42 handler table (entries E and F).
C $CBD6,4 Decrement the animation timer at $CC7B
C $CBDA,2 Reached 0: fall through to finish the pickup
C $CBDC,2 Still counting: pop the caller and return
C $CBDE,5 A = state SIT RIGHT; HL = frame table $CD0D
@ $CBE3 label=refill_energy
c $CBE3 Refill Robin's energy to maximum and redraw the bar
N $CBE3 Clears the $D1F1 timer, then (using the shadow AF'/register set) refills the energy byte at $BF6F to $0F and calls #R$BF37 to redraw the bar.
C $CBEC,3 Energy level address
C $CBF1,3 Draw the energy bar
c $CBF7 Store Robin's facing (A) and frame-table pointer (HL)
N $CBF7 Trivial: LD ($CC87),A; LD ($CC7E),HL; RET. Common tail several of the facing/state handlers (#R$CAFB etc.) jump to after picking a direction-specific frame table, committing both the new state byte and frame pointer in one place.
R $CBF7 A Robin's new facing/state byte, stored to $CC87
R $CBF7 HL Robin's new frame-table pointer, stored to $CC7E
c $CBFE Direction dispatcher: pick a frame table or hand off, by low nibble of A
N $CBFE Another member of the facing-direction dispatch family (#R$CB6B/#R$CC1F/#R$CC52). Low nibble 0 falls to #R$CC13; else low 2 bits select frame table $CCF4 (A=3), a bare return, or fall to #R$CC3B.
R $CBFE A FUDLR bitmask (same value as E, see #R$CA3F)
R $CBFE E FUDLR bitmask (used by the #R$CC3B tail it falls into)
R $CBFE O:A Small type code, if a frame table is picked
R $CBFE O:HL The picked frame table address, if a frame table is picked
C $CBFE,2 A = low nibble of the facing/state byte
C $CC00,3 Zero: jump to #R$CC13
C $CC03,4 No movement (low 2 bits 0): fall to #R$CC3B
C $CC07,4 Left/right only: pop and return, else fall through
C $CC0B,5 A=3, HL=$CCF4
C $CC13,5 A=0, HL=$CD0B
C $CC18,6 Cache the result (A, HL) at $CC88/$CC89
c $CC1F Direction dispatcher: pick a walking frame or hand off by movement bits
N $CC1F Part of the facing-direction chain from #R$C9E7/#R$CB21. Low nibble of A: 0 falls to #R$CC34 (frame table $CD20); else low 2 bits select a fixed frame table $CCF8 (A=2), a bare return (A=2, popping the caller), or fall to #R$CC3B which re-tests E's bits 2/3 to hand off to #R$CB97/#R$CB91.
R $CC1F A FUDLR bitmask (same value as E, see #R$CA3F)
R $CC1F E FUDLR bitmask
R $CC1F O:A Small type code, if a frame table is picked
R $CC1F O:HL The picked frame table address, if a frame table is picked
C $CC1F,5 Low nibble 0: fall to #R$CC34
C $CC24,4 Low 2 bits == 0: fall to #R$CC3B
C $CC28,4 Low 2 bits == 2: return to the caller's caller (pop and RET)
C $CC2C,5 Otherwise: type 2, frame table $CCF8
C $CC3B,5 Bit 2 of E set: hand off to #R$CB97
C $CC40,5 Bit 3 of E set: hand off to #R$CB91; else return to the caller's caller
c $CC47 Direction dispatcher: pick a diagonal frame table or hand off
N $CC47 Another member of the facing-direction dispatch family. Low nibble 0 falls to #R$CC73; else bit 2 of E hands off to #R$CB97, otherwise falls to #R$CC5B.
R $CC47 A FUDLR bitmask (same value as E, see #R$CA3F)
R $CC47 E FUDLR bitmask
c $CC52 Direction dispatcher: pick a diagonal frame table or hand off
N $CC52 Part of the facing-direction chain from #R$C9E7 (reached via #R$CC47). Low nibble of A = 0 falls to #R$CC73 (a cached frame at $CC88/$CC89); else bit 3 of E hands off to #R$CB91. Otherwise tests E's bits 0/1 to pick between frame tables $CCFE (A=2) and $CD13 (A=3), or returns with no result if neither is set.
R $CC52 A FUDLR bitmask (same value as E, see #R$CA3F)
R $CC52 E FUDLR bitmask
R $CC52 O:A Small type code, if a frame table is picked
R $CC52 O:HL The picked frame table address, if a frame table is picked
C $CC52,4 Low nibble 0: fall to #R$CC73
C $CC56,5 Bit 3 of E set: hand off to #R$CB91
C $CC5B,5 Bit 0 of E set: hand off to #R$CC67
C $CC60,5 Bit 1 of E set: hand off to #R$CC6D; else return to the caller's caller
C $CC67,5 Type 2, frame table $CCFE
C $CC6D,5 Type 3, frame table $CD13
C $CC73,6 Return the cached frame from $CC88/$CC89
b $CC7A Robin's animation timers, object record and facing byte
N $CC7A $CC7A/$CC7B are the animation timers tested by #R$CB21 and #R$C9E7. $CC7C is Robin's own object record (standard layout, see #R$AC13). $CC87 right after it is the facing/state byte indexing #R$CD42; $CC88/$CC89 cache a frame pointer read back by #R$CC73.
B $CC7A,1,1 Sword/arrow/pickup action timer (see #R$CB21/#R$BC81)
B $CC7B,1,1 Idle flag (0 = idle; gates #R$BDA3/#R$BDE0/#R$C9E7)
B $CC7C Robin's object record (standard layout, see #R$AC13)
B $CC87 Facing/state byte, indexes #R$CD42
B $CC88,1,1 Cached frame type, read back by #R$CC73
W $CC89,2,2 Cached frame table pointer, read back by #R$CC73
B $CC8B,1,1 Filtered movement/action bitmask (see #R$C95A)
b $CC9D Frame tables for Robin's sword/arrow/walk animations (see #R$CA4C)
N $CC9D Frame table for SWORD ATTACK (MOVING) RIGHT, used by #R$CA4C when the sword flag is set and a movement bit is held.
B $CC9D,8
W $CCA5,2 then loop back to $CCA3
B $CCA7,1
N $CCA8 Frame table for SWORD ATTACK (MOVING) LEFT, mirror of #R$CC9D.
B $CCA8,8
W $CCB0,2 then loop back to $CCAE
B $CCB2,1
N $CCB3 Frame table for SWORD ATTACK (STANDING) RIGHT, used by #R$CA4C when the sword flag is set and no movement bit is held.
B $CCB3,8
W $CCBB,2 then loop back to $CCB9
B $CCBD,1
N $CCBE Frame table for SWORD ATTACK (STANDING) LEFT, mirror of #R$CCB3.
B $CCBE,8
W $CCC6,2 then loop back to $CCC4
B $CCC8,1
N $CCC9 Frame table for ARROW SHOT RIGHT, used by #R$CA4C while an arrow is in flight.
B $CCC9,8
W $CCD1,2 then loop back to $CCCF
B $CCD3,1
N $CCD4 Frame table for ARROW SHOT LEFT, mirror of #R$CCC9.
B $CCD4,8
W $CCDC,2 then loop back to $CCDA
B $CCDE,1
N $CCDF Frame table for WALK RIGHT, used by #R$CA4C when the sword flag is clear.
B $CCDF,8
W $CCE7,2 then loop back to $CCE5
B $CCE9,1
N $CCEA Frame table for WALK LEFT, mirror of #R$CCDF.
B $CCEA,8
W $CCF2,2 then loop back to $CCF0
N $CCF4 Frame table for #R$CBFE's A=3 case. Loops into #R$CD11's own "RUN LEFT" list mid-way (at $CD13), reusing its tail rather than holding separate frames.
B $CCF4,2
W $CCF6,2 -> $CD13 (see #R$CD11)
N $CCF8 Frame table for #R$CC1F's A=2 case. Loops into #R$CCFC's "RUN RIGHT" list mid-way (at $CCFE), reusing its tail.
B $CCF8,2
W $CCFA,2 -> $CCFE (see #R$CCFC)
N $CCFC Frame table for RUN RIGHT state (#R$CB6B's A=2 case). #R$CC52/#R$CC47/#R$CC1F's own targets ($CCFE) enter this same list mid-way, skipping the $0C/$0B lead-in frames, rather than holding a separate table.
B $CCFC,13
W $CD09,2 then loop back to $CCFE
N $CD0B Frame table for #R$CBFE's A=0 case. Just a 2-frame lead-in ($0B,$0C); shares #R$CD0D's own $FF terminator and loop pointer as its tail, rather than holding separate ones.
B $CD0B,2
N $CD0D Frame table for DEAD RIGHT state
B $CD0D,2,2
W $CD0F,2,2 then loop back to $CD0D
N $CD11 Frame table for RUN LEFT state
B $CD11,2,2
B $CD13
W $CD1E,2,2 then loop back to $CD13
N $CD20 Frame table for SIT LEFT state
B $CD20
N $CD22 Frame table for DEAD LEFT state
B $CD22,2,2
W $CD24,2,2 then loop back to $CD22
N $CD26 Frame table for RUN UP state
B $CD26,5,5
W $CD2B,2,2
N $CD2D Frame table for RUN DOWN state
B $CD2D,5,5
W $CD32,2,2
N $CD34 Frame table for stagger-recovery state $0F (facing bit 0 set), used by #R$CB9D.
B $CD34,5
W $CD39,2 then loop back to $CD37
N $CD3B Frame table for stagger-recovery state $0E (facing bit 0 clear), used by #R$CB9D.
B $CD3B,5
W $CD40,2 then loop back to $CD3E
b $CD42 Per-facing/state handler jump table, indexed by #R$C9E7 via $CC87
N $CD42 16 word entries, indexed by Robin's facing/state byte ($CC87, doubled) - Robin's animation state machine. #R$C9E7 jumps to the selected handler with A = E = the FUDLR bitmask (bit 0 right, 1 left, 2 down, 3 up, 4 fire) - the same layout every #R$D1E9 input handler returns. States: $00/$01 sit right/left, $02/$03 run right/left, $04 run up, $05 run down, $06/$07 sword swing right/left (probable), $08/$09 arrow right/left, $0A-$0D per-direction handlers (see #R$CB21), $0E/$0F stagger recovery (lay down, then refill energy - entered only from #R$CB9D).
W $CD42,2 $00 - SIT RIGHT - Pick a walking-frame table by movement bit (low nibble of A)
W $CD44,2 $01 - SIT LEFT - Pick a walking-frame table by movement bit (low nibble of A)
W $CD46,2 $02 - RUN RIGHT - Direction dispatcher: pick a frame table or hand off, by low nibble of A
W $CD48,2 $03 - RUN LEFT - Direction dispatcher: pick a walking frame or hand off by movement bits
W $CD4A,2 $04 - RUN UP - Direction dispatcher: pick a diagonal frame table or hand off
W $CD4C,2 $05 - RUN DOWN - Direction dispatcher: pick a diagonal frame table or hand off
W $CD4E,2 $06 - SWORD RIGHT (probable, not fully confirmed): run the per-direction handler #R$CB21
W $CD50,2 $07 - SWORD LEFT (probable, not fully confirmed): run the per-direction handler #R$CB21
W $CD52,2 $08 - ARROW RIGHT: launch an arrow (#R$BC81), then #R$CB21
W $CD54,2 $09 - ARROW LEFT: launch an arrow (#R$BC81), then #R$CB21
W $CD56,2 $0A - Facing/state $0A handler: run the per-direction handler #R$CB21
W $CD58,2 $0B - Facing/state $0B handler: run the per-direction handler #R$CB21
W $CD5A,2 $0C - Facing/state $0C handler: run the per-direction handler #R$CB21
W $CD5C,2 $0D - Facing/state $0D handler: run the per-direction handler #R$CB21
W $CD5E,2 $0E - Stagger recovery, facing $00: lay down, then refill energy
W $CD60,2 $0F - Stagger recovery, facing $01: lay down, then refill energy
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
C $CDB6,3 set Idle flag
C $CDB9,3 set Sword/arrow/pickup action timer
C $CDBC,3 Set the border-flash colour/count operands without flashing
C $CDC0,3 Draw the main menu items
C $CDC3,3 Play the main menu melody ($8B82), called from #R$CD6C
C $CDC6,5 HL:E = a long idle-timeout counter
C $CDCB,3 Row $EFFE
C $CDD1,2 Any key on it starts the game
C $CDD3,3 Row $F7FE
C $CDD9,2 Bits 0-3: a 1-4 key opens the control-scheme menu
C $CDDD,3 Neither pressed: count the timeout down
C $CDE2,1 Outer counter empty too
C $CDE5,2 Timeout expired: redraw the menu and restart its music
C $CDE7,3 Read keys 1-4 to pick a control scheme
C $CDEC,3 Clear 32 screen rows using the row-pointer table at $FF40
C $CE13,3 Stir the pseudorandom seed at $D38D using the R register
C $CE1B,3 Stir the pseudorandom seed at $D38D using the R register
C $CE21,3 Stir the pseudorandom seed at $D38D using the R register
C $CE2F,3 Randomly pick the game's starting room and opening state
C $CE32,3 Pick a random entry from the pointer table at $D3A2, save to $D3B8
C $CE35,3 Init the Hermit's state at game start
C $CE39,3 Clear the shadow screen
C $CE3C,8 Print position for the logo (row/column in DE)
C $CE44,3 A = $4F - #R$D7CE index $0F, the Odin logo (#R$B434)
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
N $CE6D H=L=R, so (HL) samples memory at an R-dependent address; that byte XORed with R, then XORed into $D38D, is the new seed - a cheap way to fold in both R's own value and whatever byte happens to sit at that address.
C $CE72,2 H=L=R: HL -> an R-dependent memory address
C $CE77,7 XOR that byte, then the old seed, back into $D38D
@ $CE81 label=side_wipe_transition
c $CE81 Side-wipe transition between the game screen and the Odin sign
N $CE81 Used by #R$CE47 to slide the screen open, revealing the Odin sign underneath. Copies columns from the two shadow screens a strip at a time, moving the boundary each pass, with border-colour stripes drawn via OUT ($FE),A while the copy runs.
C $CE81,3 Snapshot non-zero attributes to $E500, enable the LDIR/LDDR copies in #R$CE81
C $CE8D,3 IXl = the strip's current width
C $CE93,4 Row-pointer table at $FE00
C $CE97,2 $12 passes
C $CE9A,3 8 rows per pass
C $CE9D,3 Attribute stripe address from the row-pointer entry
C $CEA0,7 /8, into the $58 attribute page
C $CEA8,4 R register flashes the border
C $CEAE,3 Right-hand source from the row table
C $CEB6,4 IXl bytes wide
C $CEBA,2 !!MUT-CMD!! $ED enables this copy, $00 (NOP) disables it - see #R$CF4A/#R$CF4D
C $CEBF,5 The attribute half sits $7300 below
C $CEC5,3 Carry the cell across with bit 7 cleared
C $CEC9,3 Same again for the second half
C $CEDD,4 $1C to the row's right-hand end
C $CEE6,2 !!MUT-CMD!! $ED enables this copy, $00 (NOP) disables it - see #R$CF4A/#R$CF4D
C $CEF5,6 Left-hand source
C $CF04,2 !!MUT-CMD!! $ED enables this copy, $00 (NOP) disables it - see #R$CF4A/#R$CF4D
C $CF07,3 Pull a byte from beyond the strip boundary
C $CF16,3 $1C along for the left half
C $CF1E,2 !!MUT-CMD!! $ED enables this copy, $00 (NOP) disables it - see #R$CF4A/#R$CF4D
C $CF21,2 Same boundary merge on the left
C $CF2E,4 Two bytes per row-table entry
C $CF32,2 Next of the 8 rows
C $CF38,1 Next of the $12 passes
C $CF3F,2 Widen the gap by one column each side
C $CF41,3 Exit once the strip is used up
C $CF44,3 Disable the LDIR/LDDR copies inside #R$CE81
c $CF4A Disable the LDIR/LDDR copies inside #R$CE81
N $CF4A Trivial: A=0, falls into the shared tail at $CF64, which patches that value ($00 = NOP, disabling; $ED from #R$CF4D = re-enabling) into the four self-modified LDIR/LDDR opcodes inside #R$CE81's wipe transition.
c $CF4D Snapshot non-zero attributes to $E500, enable the LDIR/LDDR copies in #R$CE81
N $CF4D Copies the $E800..$EA3F attribute area into $E500, skipping zero bytes so old data shows through, then patches the opcode byte ($ED) at the four self-modified LDIR/LDDR sites inside #R$CE81 (called back once via #R$CF64, shared with #R$CF4A which patches $00 instead to disable them).
C $CF4D,9 BC = $0240 bytes; HL/DE = attribute source/dest ($E800/$E500)
C $CF56,4 Skip zero attribute bytes (leave old $E500 data in place)
C $CF5B,7 Step both pointers, loop for all $0240 bytes
C $CF62,2 A = $ED (the LDIR/LDDR opcode byte)
C $CF64,12 Patch $ED into the four LDIR/LDDR opcodes in #R$CE81
c $CF71 Randomly pick the game's starting room and opening state
N $CF71 Called from #R$CD6C when starting a new game. Uses the R register to roll one of 4 entries each from $D38E (Ent's room, byte table) and $D392 (Hermit's room, pointer-pair table), storing them at $D3B2/$D3B4. The third room ($D3B6) isn't independently rolled: it's set from the *same* roll (from $D39A, also 4 entries) that picks Robin's actual starting room at $C548 - i.e. $D3B6's plain tree (#R$C57C) is decoration dropped into wherever the game happens to start Robin, except when that room is $9C (the #R$B867 dungeon-gate landmark), in which case the stored copy's low byte is swapped to $D2 so the tree doesn't clash with $9C's own content.
C $CF71,11 Roll 0-3 from R; pick a byte from the table at $D38E
C $CF84,12 Roll one of 4 entries (step 2) from the pointer table at $D392
C $CF94,12 Roll one of 4 entries (step 2) from the room table at $D39A
C $CFA0,7 Read the rolled room number into DE, set the starting room $C548
C $CFA7,7 Room $9C: swap the stored copy's low byte to $D2
c $CFB3 Pick a random entry from the pointer table at $D3A2, save to $D3B8
N $CFB3 Rolls a random even index 0-14 and reads the matching 2-byte pointer from the table at $D3A2 into $D3B8 (later compared against the current room, e.g. by #R$C276).
C $CFB6,2 Mask to an even value 0-14
C $CFB3,3 Stir the pseudorandom seed at $D38D using the R register
c $CFC7 Init the Hermit's state at game start
N $CFC7 Called from #R$CD6C. Sets the tracked target room to $D3B4 (the second scenario room picked by #R$CF71) and resets the object's timer/phase bytes ($BC68/$BC66/$BC67) and a flag at $BBF4.
C $CFC7,6 HL = target room ($D3B4); save to $BC64
C $CFCD,10 Reset the timer bytes at $BC68/$BC66
C $CFD7,4 Clear the "defeated" flag at $BC67
c $CFE1 Print string
N $CFE1 A small wrapper around #R$D619 with the attribute param fixed to $60, preserving HL/DE across the call for callers that still need them afterwards.
R $CFE1 HL -> the string to print
C $CFE8,3 Print the string at the address pointed to by
@ $CFEE label=build_bit_reverse_table
c $CFEE Build the $FD00 bit-reverse lookup table
N $CFEE Called once from #R$CD6C at startup. For each byte C (0-255), bit-reverses it (8x RR E/RL D) and stores the result at $FD00+C - the table used throughout for horizontal mirroring (#R$C1D6, #R$C607, #R$C8D0).
C $CFEE,5 C = 0; HL -> the table at $FD00
C $CFF3,5 B = 8 bits; D:E accumulates the reversed byte
@ $D004 label=build_screen_row_table
c $D004 Build the $FE00 table of the 192 real-screen pixel-row addresses
N $D004 Fills 192 entries (2 bytes each) at $FE00 with successive ZX Spectrum screen pixel-line addresses starting at $4000, using the standard non-linear third/row/scanline stepping (DE, incrementing through the low third then jumping between thirds every 8 lines). This table is what #R$C806/#R$CE81 index via IY/IX to reach real screen rows without recomputing the address each time.
C $D004,8 B = 192 rows; DE = $4000 (screen start); HL -> table at $FE00
C $D00C,4 Store this row's address, advance HL to the next table entry
C $D010,7 Step to the next scanline within the current third (add $0100)
@ $D024 label=clear_screen_pixels
c $D024 Clear screen pixels
N $D024 One LDIR fill of the real screen's pixel area ($4000-$57FF) with $00.
@ $D032 label=clear_screen_attrs
c $D032 Clear screen attributes
N $D032 One LDIR fill of the real screen's attribute area ($5800-$5AFF) with A.
R $D032 A Attribute value to fill in the screen
@ $D03F label=clear_shadow_screen
c $D03F Clear the shadow screen
N $D03F Two back-to-back LDIR fills, same pattern as the real-screen clears at #R$D024/#R$D032: fills the shadow attribute area $E800-$EAFF with A, then the shadow pixel area $EB00-$FCFF with $00.
R $D03F A Attribute value to fill in the shadow screen
C $D03F,9 Fill the shadow attribute area $E800-$EAFF with A
C $D04B,13 Fill the shadow pixel area $EB00-$FCFF with $00
N $D04B Clear shadow screen pixels
c $D059 Clear E500 area
N $D059 One LDIR fill of the $E500-$E73F dirty-cell/flag area with $00.
c $D067 Clear 32 screen rows using the row-pointer table at $FF40
N $D067 Reads 32 successive 2-byte row addresses from the table at $FF40 (IY-indexed), and for each one clears $1F bytes starting one byte past the row start (LDIR from a zeroed first byte).
C $D067,6 IY -> the row-pointer table at $FF40; A = 32 rows
C $D06D,10 HL = this row's address; DE = HL+1
c $D085 Print the victory message (reached via room $69), side-wipe back
N $D085 Called from #R$BF80 only when moving off the world-map edge lands Robin in room $69 - the game's only win condition. Prints message $50 via #R$D631, whose table lookup ($50 AND $1F = $10, table entry $B6AC) lands on the "CONGRATULATIONS.../ROBIN OF THE WOOD/...ARCHERY CONTEST..." victory text - a separate string from the GAME OVER message #R$C055 prints from $B663, despite the two sharing the same data block. Then plays the side-wipe transition (#R$CE81).
C $D085,1 A = 0
C $D086,3 Clear the shadow screen
C $D08E,3 A = $50 - #R$D7CE index $10 ($B6AC), the "CONGRATULATIONS.../ROBIN OF THE WOOD/...ARCHERY CONTEST..." victory text
C $D091,3 Side-wipe transition between the game screen and the Odin sign
c $D095 Set up interrupt mode 2, pointing the ISR at #R$DFE7
N $D095 Called once from #R$CD6C at startup. Sets IM 2 with I=$39 (a table of $FF bytes, standard IM2 trick), then writes a JP instruction ($C3) into the interrupt vector page at $FFF4, targeting #R$DFE7 (the interrupt-safe border-flash wrapper).
C $D095,5 DI; IM 2; A = $39
C $D09C,10 Patch $FFFF/$FFF4 with the JP opcode for the interrupt vector
C $D0A6,6 Point the interrupt vector's target at #R$DFE7
b $D0AD
c $D0CB Read keys 1-4 to pick a control scheme
N $D0CB Called from #R$CD6C. Reads keyboard row $F7FE (keys 1-5) and, via successive RRA/JR C tests, picks which of keys 1-4 is held (returning with no change if none is), setting A to the option index (0-3) and HL to the matching input handler's address, then saves both to $AD32/$D275 (key 1 also calls #R$D0FF first, to let the player redefine the keys #R$D191 will test).
C $D0CB,5 BC = keyboard row $F7FE (keys 1-5); read it into A
C $D0D3,8 Redefine keyboard keys
C $D0DD,8 Key 2: option 1, handler #R$D1A2
C $D0E7,8 Key 3: option 2, handler #R$D1AB
C $D0F1,7 Key 4: option 3, handler #R$D1C4; else no key pressed, return
@ $D0FF label=redefine_keys
c $D0FF Redefine keyboard keys: prompt for and store 5 key choices
N $D0FF Draws the key-redefinition screen, then for each of 5 actions: prints a prompt (11 bytes into a 14-byte-stride record at $D22F, with a placeholder byte at offset+11), waits for a single keypress (#R$D140), stores the key code into the table at $D277 (used by the "user-defined keys" control scheme), looks up the key's display glyph via the 256-entry table at $D27C (indexed directly by the raw key code), patches it into the prompt record's placeholder byte, and reprints the record to show the chosen key.
C $D0FF,2 A = $45 (screen number?)
C $D101,3 Clear the shadow screen
C $D104,3 Side-wipe transition between the game screen and the Odin sign
C $D107,3 Data and messages to redefine keyboard keys
C $D10A,3 Print string
C $D10D,8 DE -> the key-code table at $D277; HL -> the prompt list at $D22F
C $D115,3 Save loop state before printing this action's prompt
C $D118,3 Print string
C $D11B,3 Wait for all keys to be released
C $D11E,3 Wait until exactly one key is pressed, return its code in A
C $D121,2 Restore this prompt's text pointer and key-table slot
C $D123,2 Store the pressed key code
C $D125,3 BC = the key-name table at $D27C
C $D128,5 Index it by the raw key code (8-bit add, carry into B)
C $D12D,1 A = the key's display glyph
C $D12E,5 HL -> a placeholder byte 11 further into the prompt record
C $D133,2 Undo the offset, ready for the next entry
C $D135,3 Print string
c $D140 Wait until exactly one key is pressed, return its code in A
N $D140 Retries #R$D156 until it reports exactly one key down (not zero, not more than one), then returns that key's code in A.
C $D140,3 Scan the whole keyboard for exactly one key pressed, decode it
C $D143,2 => Wait until exactly one key is pressed, return its code in A
C $D146,2 => Wait until exactly one key is pressed, return its code in A
@ $D14B label=wait_keys_released
c $D14B Wait for all keys to be released
N $D14B Polls port $00FE with B=$00 (selects every keyboard half-row at once, giving an "any key pressed anywhere" reading) and loops while any of the low 5 bits is set after CPL (a pressed key reads as a set bit). Used before a fresh key-prompt so a key still held down from the previous prompt isn't immediately re-read.
C $D14B,5 Read the "any key" port ($00FE); loop while any bit is set
C $D153,2 => Wait for all keys to be released
@ $D156 label=scan_keyboard
c $D156 Scan the whole keyboard for exactly one key pressed, decode it
N $D156 Reads all 8 keyboard half-rows in turn (BC rotated via RLC B starting at $FEFE), counting pressed keys into D; if more than one key is down, fails (RET NZ). For the single row with a key down, bit-scans the column (via repeated SUB $08/SRL) to get a key index, combined with the row count in E into a single code returned in D. No key down at all also returns via the Z flag.
R $D156 O:D Key code, if exactly one key is down (see the C-lines below for the flag conditions on failure)
C $D156,6 DE = row countdown seed; BC = first keyboard row ($FEFE)
C $D15C,7 Read this row; low 5 bits (inverted) = pressed keys in it
C $D163,2 More than one row has a key down: fail
C $D165,2 H = this row's key bits; A = the row index (E)
C $D167,6 Bit-scan H for the pressed key's column, accumulating into A
@ $D176 label=is_key_pressed
c $D176 Test whether the key encoded in A is currently pressed
N $D176 A is a key code in the same row/column scheme decoded by #R$D156 (as stored by #R$D0FF into $D277 for the user-defined-keys control scheme). Rotates the keyboard row selector to the right half-row, reads that port, then rotates the result to bring the target key's bit into carry.
R $D176 A Key code (#R$D156's row/column scheme)
R $D176 O:C The key's pressed/released state, in carry
C $D176,11 Split A into a row-rotate count (B) and column position (C)
C $D181,6 C = 5 - column position; A = $FE (row selector)
C $D187,5 Rotate the row selector B times; read that keyboard row
C $D18C,2 Rotate the result C times to bring the key's bit into carry
c $D191 User-defined-keys control scheme: build the movement bitmask
N $D191 Reached via #R$D1E9's dispatch when the "user-defined keys" scheme is active. Tests each of the 5 key codes stored at $D277 (by #R$D0FF, in fire/up/down/left/right order) via #R$D176, building the bitmask in E one bit at a time via the carry (E=$08 as the shift-marker exits after exactly 5 rotations, not 8 - confirmed by simulation). The rotate-left construction lands the first-tested key (fire) in the highest bit and the last (right) in bit 0, producing the same FUDLR layout as #R$D1A2.
R $D191 O:E FUDLR bitmask, active high (bit 0 right, 1 left, 2 down, 3 up, 4 fire) - matches #R$D1A2's Kempston layout
C $D191,5 HL -> the 5 stored key codes at $D277; E = $08 (shift-marker for a 5-pass loop)
C $D196,2 A = this key's code; advance HL
C $D198,6 Test whether the key encoded in A is currently pressed
@ $D1A2 label=read_kempston_joystick
c $D1A2 Kempston joystick handler
N $D1A2 Reads the standard Kempston joystick port ($1F) and masks to its 5 bits. Was mislabeled as a text/data block in earlier notes - the bytes are code, not a message: #R$D0CB stores this address into $D275 as the input handler for control-scheme option 1, in the same slot #R$D1E9 later jumps through.
R $D1A2 O:E FUDLR bitmask, active high (bit 0 right, 1 left, 2 down, 3 up, 4 fire) - the standard Kempston layout
C $D1A2,3 BC = Kempston port $1F
C $D1A5,2 Read it
C $D1A7,3 Mask to bits 0-4; E = the result

@ $D1AB label=read_sinclair_joystick
c $D1AB Sinclair joystick handler: keyboard row $EFFE (keys 6-0)
N $D1AB Reads keyboard half-row $EFFE - the standard Sinclair joystick keys (6/7/8/9/0) - and reorders its bits via CPL/RRA/RL E into E. Control-scheme option 2 from #R$D0CB. Simulated exactly (one key at a time): key 6 -> E bit 4, 7 -> bit 3, 8 -> bit 2, 9 -> bit 0 (its bit is dropped by the second of two back-to-back RRAs, then re-emerges after wrapping through bits 5-7 and being picked up by the trailing RLA), 0 (fire) -> bit 1. This does not match the canonical FUDLR layout (bit 0 right, 1 left, 2 down, 3 up, 4 fire) that #R$D1A2/#R$D191 produce - only bit 2 (down) coincides - so pressing 9 (up) sets bit 0, which every other handler and #R$C9E7/#R$CD42 treat as "right". Likely a real bug in this control scheme rather than an intentional remap.
R $D1AB O:E Direction/fire bitmask - does not match the canonical FUDLR layout, see N-line
C $D1AB,5 BC = keyboard row $EFFE; read and invert it (active keys -> set bits)
C $D1B0,1 CPL: pressed keys become set bits
C $D1B1,5 Key 6 -> E bit 4
C $D1B6,3 Key 7 -> E bit 3
C $D1B9,3 Key 8 -> E bit 2
C $D1BC,2 Key 9's bit, about to be dropped by the second RRA
C $D1BE,2 Key 0 (fire) -> E bit 1
C $D1C0,3 Key 9 re-emerges via RLA, having wrapped through bits 5-7 -> E bit 0

@ $D1C4 label=read_joystick
c $D1C4 Joystick handler: keyboard rows $EFFE and $F7FE combined (keys 1-0)
N $D1C4 Reads keyboard half-row $EFFE (keys 6-0) into part of E, then also reads $F7FE (keys 1-5) and folds those bits in via D. Control-scheme option 3 from #R$D0CB. Exact key-to-direction mapping not traced live.
R $D1C4 O:E Kempston-format direction/fire bitmask
C $D1C4,5 BC = keyboard row $EFFE; read and invert it
C $D1C9,15 Reorder bits from the first row into E
C $D1D8,3 D = the row's result; B = second row port $F7
C $D1DB,2 Read it
C $D1DD,12 Fold bits from the second row into E, combined with D

@ $D1E9 label=dispatch_input_handler
c $D1E9 Dispatch to the active control scheme's input handler
N $D1E9 Called first from #R$C95A each frame. Pushes $D1F1 as the return address and jumps to the handler pointer at $D275 (set by #R$D0CB's control-scheme menu), which reads the player's chosen input device/keys and returns with a direction bitmask.
R $D1E9 O:E Cleaned direction/fire bitmask (opposite pairs cancelled by #R$D1F1)
C $D1E9,4 HL = the return address $D1F1; push it
C $D1ED,3 Jump to the handler pointer at ($D275)
c $D1F1 Cancel opposite movement bit pairs in E, return the result in A
N $D1F1 The return address pushed by #R$D1E9: every control-scheme handler returns here. If both left+right (bits 0-1) are set, clears them both; same for both up+down (bits 2-3). Leaves the cleaned bitmask in A/E.
R $D1F1 E Direction/fire bitmask to clean
R $D1F1 O:A The cleaned bitmask (E is updated to match)
C $D1F1,1 !!MUT-CMD!! dual-use: 2-byte variable slot, also executed as padding
C $D1F2,1 !!MUT-CMD!! dual-use: 2-byte variable slot, also executed as padding
C $D1F3,3 A = E masked to the left+right bits
C $D1F6,4 Both set: fall through to clear them
C $D1FA,4 Clear the left+right bits in E
C $D1FE,3 A = E masked to the up+down bits
C $D201,4 Both set: fall through to clear them
C $D205,4 Clear the up+down bits in E
C $D209,2 A = the cleaned bitmask; return
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
b $D274 Padding byte and the active control-scheme's input-handler pointer
B $D274,1 Unused - no code reads this byte
W $D275,2 -> the current input handler (#R$D1A2/#R$D1AB/#R$D1C4/#R$D191), set by #R$D0CB and called by #R$D1E9
W $D275,2,2
b $D277 User-defined key codes, one byte per remappable action (set by #R$D0FF)
N $D277 Raw keyboard scan codes in #R$D156's row/column scheme, decoded per-bit by #R$D176. 5 bytes, confirmed by simulating #R$D191's shift-loop - not 8, as older notes here claimed.
B $D277,5
t $D27C Key-code to display-character lookup table (40 keys)
N $D27C Indexed directly by a raw key code from #R$D156 (BC = $D27C + A, no multiplier): #R$D0FF adds A to reach the matching byte, the single ASCII character shown as that key's label on the redefinition screen. 40 entries - one per key on the ZX keyboard.
c $D2A4 Unused?
N $D2A4 Not called from anywhere in the disassembly. If it were reached, it would wait for all keys to be released, then flash the border with a random colour (from the R register) on every pass until a key is pressed.
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
b $D38D Pseudorandom seed byte, stirred by #R$CE6D
B $D38D,1,1
b $D38E Random starting-scenario room tables, rolled by #R$CF71
N $D38E One of 4 possible low bytes for the Ent's room, rolled once at game start. Matches a player-sourced walkthrough: "there are 4 places on the map where the magic tree can stand."
N $D392 The Hermit's room, rolled once at game start - 4 slots but entries 3 and 4 duplicate ($0132), so only 3 distinct rooms. Matches a player-sourced walkthrough: "there are 3 possible dwelling places for the hermit."
B $D38E,4,4
B $D392,8,2
N $D39A One of 4 possible room numbers for the game's third random starting room.
B $D39A,8,2
b $D3A2 Sheriff of Nottingham: ambush/capture room table, rolled by #R$CFB3
N $D3A2 One of 8 possible rooms for the Sheriff's scripted ambush/capture scene, rolled by #R$CFB3 (7 distinct rooms - the first, $000B, appears twice, giving it double weight). All 7 are room type #R$7B39 $00, the dedicated ambush-clearing layout.
B $D3A2,16,2
b $D3B2 The 3 random scenario rooms and the ambush target room, set at game start
W $D3B2,2 First random scenario room - the Ent's room (set by #R$CF71 from #R$D38E)
W $D3B4,2 Second random scenario room - the Hermit's room (set by #R$CF71 from #R$D392, one of 3 distinct rooms - entries 3 and 4 duplicate); also the Hermit's own initial target, set by #R$CFC7
W $D3B6,2 Wherever Robin starts the game - a copy of $C548's own roll (set by #R$CF71 from #R$D39A), decorated with a plain tree via #R$C57C ($9C swapped to $D2)
W $D3B8,2 Sheriff's ambush/capture target room (set by #R$CFB3 from #R$D3A2)
B $D3BA,1 #R$B867's frame divider (decremented every call, acts every 4th) then reused as an "ambush armed" flag/countdown
c $D3BB New-game state init: clear tables, randomly place the wreath/flower/quiver pickups
N $D3BB Called from #R$CD6C when starting a new game. Zeroes the message-number byte of every #R$D4AD entry (30 entries, 5-byte stride, base $D4B1 = $D4AD+4), the 10 sword/arrow flag bytes at $D59D, and $BB9F; fills the 55-byte room-position log at $D543 with $FF (empty); zeroes the 8-byte event-status array at $D595; then runs #R$D3F3/#R$D40A/#R$D42F to randomly assign the wreath/flower/quiver pickup messages to $D4AD slots, and jumps to #R$D454 to seed the log's first two entries.
C $D3BB,9 A=0; B=30 entries, DE=5 (stride); zero the message-number bytes of #R$D4AD (base $D4B1)
C $D3C8,5 B=10; zero the sword/arrow flag bytes at $D59D
C $D3D1,9 Zero $BB9F; A=$FF, B=$37; fill the room-position log at $D543
C $D3DE,5 B=8; zero the event-status array at $D595
C $D3E7,3 Spawn the initial guards at game start
C $D3F0,3 => Hard-code the first two entries of the room-position log at $D543
c $D3F3 Spawn the initial guards at game start (1 type-1 + 5 type-2)
N $D3F3 Called from #R$D3BB. Forces #R$D4AD slot 0's message number to $01 (#R$B536, the wreath/extra-life icon - a guaranteed pickup), then places the same message $01 into 5 more free slots found by #R$D47D (whose "found a free slot" return leaves A=0, so the following INC A always yields $01 here) - 6 wreath pickups placed in total. Confirmed against a player-sourced walkthrough describing random flower/extra-life/quiver placement across map locations - whether an item appears at all, and which one, is decided randomly at game start exactly here.
C $D3F3,5 Force #R$D4AD slot 0 to message $01, the wreath icon (guaranteed)
C $D3F8,2 B = 5 more guards to spawn
C $D3FA,7 Find a free slot; write event type 2 there
C $D3FA,3 Find a free (zero) #R$D4AD slot
c $D402 Randomly place a random number of flower ($05) and quiver ($07) pickups
N $D402 Two near-identical halves, entered separately from #R$D3BB or in sequence from the top. Each rolls a random target count (R register, 6-9 or 8-11) into B, then while the running counter at $D5A2 (message $05, the flower icon) / $D5A3 (message $07, #R$B57C - inferred to be the quiver icon, matching a player-sourced walkthrough's "flower, extra life or quiver" set) is below it, finds a free #R$D4AD slot via #R$D47D, writes the message number, and increments the counter. $D5A6 selects which half runs when entered from the top ($05 selects the first).
C $D402,6 Skip both halves if $D5A6 is $00; run the first half only if it's $05
C $D40A,10 Roll a random target count (6-9) into B
C $D41E,7 Loop: find a slot, write event type $05, bump the counter, repeat
C $D42F,10 Second half: roll a random target count (8-11) into B
C $D443,2 Loop: find a slot, write event type $07, bump the counter, repeat
C $D445,3 Find a free (zero) #R$D4AD slot
c $D454 Hard-code the first two entries of the room-position log at $D543
N $D454 Writes two fixed 5-byte entries (matching the format scanned by #R$D997/#R$D7F3) into the table at $D543: {$3D,$00,$30,$60,$06} and {$BB,$00,$58,$58,$06} - likely two permanent "always logged" room/position markers seeded before the table's normal terminator-search logic takes over.
C $D454,3 DE -> the table at $D543
C $D457,3 Entry 1 byte 1: $3D
C $D45B,3 Entry 1 byte 2: $00
C $D45E,3 Entry 1 byte 3: $30
C $D462,3 Entry 1 byte 4: $60
C $D466,3 Entry 1 byte 5: $06
C $D46A,3 Entry 2 byte 1: $BB
C $D46E,3 Entry 2 byte 2: $00
C $D471,3 Entry 2 byte 3: $58
C $D475,3 Entry 2 byte 4: $58
C $D479,3 Entry 2 byte 5: $06
c $D47D Find a free (zero) #R$D4AD slot for a new pickup
N $D47D Used by #R$D402/#R$D3F3 to find an empty (message number $00) slot in the 30-entry, 5-byte-stride pickup-placement table at #R$D4AD (base $D4B1 = $D4AD+4, i.e. each entry's message-number byte) to place a new wreath/flower/quiver message into. Rolls a random start index 0-29 (R register, clamped below 30) into C, and scans forward from the matching entry for a zero byte, wrapping the index back to 0 after entry 29. Returns with DE pointing at the free slot (or with the zero flag set if it hit a genuinely empty entry immediately).
C $D47D,2 A = R register
C $D47F,2 Mask to 0-31
C $D481,4 Clamp: >= 30 wraps toward 0
C $D485,3 Decrement and retry
C $D488,3 DE = the message-number column base $D4B1 (= #R$D4AD+4)
C $D48B,3 C = the index; A = index x4
C $D48E,2 A += C, += E (index x5 + table low byte)
C $D490,3 E = the result; carry -> bump D
C $D493,1 D += 1 on carry
C $D494,3 Found a free (zero) slot: return
C $D497,15 Advance to the next entry, wrapping to 0 at 30; loop
b $D4AD Wreath/flower/quiver pickup-placement table, 30 entries of 5 bytes
N $D4AD Scanned by #R$D5A7 on entering a room: on a room match with a non-zero message number, the entry's screen position goes into DE and #R$D631 prints it. Same 5-byte layout as the room-position log at $D543 (room lo, room hi, position D, position E, message number), which #R$D5A7 scans straight afterwards. The message-number byte of each entry (column base $D4B1 = $D4AD+4, used directly by #R$D3F3/#R$D402/#R$D47D) is randomly assigned at game start to $00 (empty), $01 (wreath/extra-life), $05 (flower) or $07 (quiver, inferred) - confirmed against a player-sourced walkthrough: "these locations may or may not hold one of the named items, and which item, both decided randomly by the game."
B $D4AD,150,5
b $D543 Room-position log, 11 entries of 5 bytes
N $D543 Same layout as #R$D4AD (room lo, room hi, position D, position E, message number), but filled at runtime rather than fixed: #R$D997 logs Robin's room and position into the first free slot, #R$D5A7 scans it for the current room. Emptied to $FF by #R$D3BB, then re-seeded with two permanent entries by #R$D454.
B $D543,55,5
b $D57A Message/sound trigger table, 9 entries of 3 bytes
N $D57A Filled by the text printer (#R$D735) when a string contains a control character: it takes the first slot whose first byte is $FF and stores the mode byte plus the glyph's screen address. #R$D7F3 then scans it every frame, treating those two address bytes as X/Y references that bracket Robin's position. Emptied to $FF on every room change by #R$D5A7.
B $D57A,27,3
b $D595 Carried-items queue (gold bags/flowers/quivers) and the quest progress variables
N $D595 The 8 status bytes are indexed in step with the special-event room table at #R$DBCD. #R$DB18 and #R$DF03 scan them for particular values to decide which stage of the quest has completed, and #R$DB82 removes a slot by shifting the rest down. All of it is zeroed at game start by #R$D3BB. This is also Robin's carried-items queue (gold bags/flowers/quivers picked up via #R$D94B) - its fixed 8-byte size matches a player-sourced walkthrough's "maximum of 8 carried items", and #R$D94B's blind FIFO push (oldest falls off $D59C when a new pickup enters at $D595) matches its warning that a carelessly-picked-up flower can bump out a gold bag once full.
B $D595,8,8 Carried-items queue, one slot per pickup (also doubles as the event-status array, indexed in step with #R$DBCD)
B $D59D,1 Sword flag - set by #R$DF03 once Robin pays the Ent 3 bags of gold for it
B $D59E,1 Bow flag - set by #R$DF03 once Robin pays the Ent 3 bags of gold for it (the 3 magic arrows follow as 3 more separate payments, tracked by #R$D5A1)
B $D59F,1 Re-seed flag for the room-position log (see #R$C4B6)
B $D5A0,1 Arrow-hit countdown
B $D5A1,1 Quest stage counter (stops at 3) - advanced by #R$DF03 once the sword and bow are both bought from the Ent, once per magic arrow purchased thereafter (3 total); also read by #R$C462's forest-door hints
B $D5A2,1 Running count of spawned type-5 guards
B $D5A3,1 Running count of spawned type-7 guards
B $D5A4,1 Extra-life count (arrow/special-enemy kills and wreath pickups, see #R$D91A); underflows to bit 7 set on death at 0/1 lives, triggering the GAME OVER screen (see #R$C055)
B $D5A5,1 Arrow-hit stage counter
B $D5A6,1 Which half of #R$D402 runs ($05 = the first)
c $D5A7 Room entry: spawn guards, reset triggers, print room-specific messages
N $D5A7 Called on entering a room (from #R$BF80/#R$C4D2/#R$CD6C). Continues the wreath/flower/quiver random placement via #R$D402, fills the 9-entry (3 bytes each) trigger table at $D57A with $FF, clears $DFE6, then scans the 30-entry table at $D4AD for the current room, printing the assigned pickup's icon via #R$D631 if one was placed there; finally scans the 11-entry room-position log at $D543 the same way, printing via #R$D631 if a match's message pointer/value is set.
C $D5A7,3 Continue the wreath/flower/quiver random placement
C $D5AA,4 $1B bytes of trigger table to blank
C $D5AE,3 The trigger table at $D57A
C $D5B1,2 Fill it with $FF
C $D5B5,4 Clear the re-entry guard
C $D5B9,5 30 entries in the pickup-placement table at $D4AD
C $D5C4,4 Current room against this entry's
C $D5D2,6 Room matches: is the message pointer set?
C $D5DC,4 DE = the entry message
C $D5E0,3 Message number read from the matched #R$D4AD entry (varies by room), positioned from the $D7CE table
C $D5E5,1 5 bytes to the next entry
C $D5E8,5 11 entries in the room-position log at $D543
C $D5F3,4 Same room comparison over that table
C $D601,6 Room matches: pull the entry's message data
C $D60A,3 Message number read from the matched #R$D543 room-position-log entry (varies by room), positioned from the $D7CE table
C $D60F,2 Keep scanning; this table can match more than once
s $D617
c $D619 Print the string at the address pointed to by (HL)
N $D619 Companion to #R$D631's print-by-message-number entry, used where the caller already has a direct pointer to the string instead of a message index. Resets the print state and falls into the same core at #R$D661. The pointer HL is not the string itself: #R$D61C dereferences it, so the 2 bytes at HL/HL+1 are a packed position word, not glyph data - the real string starts 2 bytes past HL (confirmed at #R$B52D and #R$B51F).
R $D619 A Attribute/mode byte, stored to $D7F1 before printing
R $D619 HL Pointer to the 2-byte address of the string to print
C $D619,3 A = attribute/mode param
C $D61C,3 DE = string pointer taken from (HL)
C $D61F,2 Save HL; A = 0
C $D621,6 Reset $D74C and $D78A to 0
C $D627,5 Reset $D75A to $58
@ $D631 label=print_message
c $D631 Print message number A, positioned from the $D7CE table
N $D631 A selects a message: bits 0-4 index the position/pointer table at #R$D7CE, giving the string address and screen column/row; the string itself is then printed by the shared core at #R$D661 (also entered from #R$D619). That core makes two passes over the string - the first (#R$D68D) draws each glyph into the shadow screen, row by row, honouring the mode byte's mirror/overwrite flags and the $01 (2x2-icon row-stack), $02/$03 (per-glyph horizontal mirror via the $FD00 bit-reverse table, see #R$D746) in-string control codes; the second (#R$D76E) walks the data immediately following the string's $00 terminator - one attribute byte per glyph, $FF between rows - writing attribute cells and queueing each changed cell into the $E500 buffer for #R$C85C to flush.
R $D631 A Message number; bits 0-4 index the table at #R$D7CE
C $D631,3 Message number doubles as the mode byte at $D7F1
C $D636,5 Index the message table at $D7CE
C $D641,3 BC = this message's string address
C $D644,5 Print default: $D74C = 2
C $D649,5 $D78A = $80 (flash state)
C $D64E,5 $D75A = $E8
C $D658,2 Message $0E alone clears the flash state
C $D662,3 C keeps the column while H becomes the row
C $D669,2 Bit 5 of the mode byte selects mirrored text
C $D66D,4 Mirrored: row addresses come from the table at $FE00
C $D671,3 Fetch the row address
C $D677,4 Normal: row x16
C $D67B,4 Onto the $EB02 shadow-screen base
C $D681,4 Column /4
C $D68D,2 Next character of the string
C $D68F,4 $00 ends it
C $D693,2 $01: back up and start a second row of glyphs (see #R$D6F5) - a 2x2-glyph icon trick, not right-to-left text
C $D698,2 $02 sets the mirror flag ($D7F0) - subsequent glyphs draw bit-reversed
C $D6A1,2 $03 clears the mirror flag
C $D6AB,2 Below $20 is a control code, not a glyph
C $D6B2,3 Font base
C $D6B8,3 Char x8 into the font
C $D6C0,4 $D7F0 picks the glyph byte as-is or bit-reversed (mirrored) via $FD00
C $D6CA,3 Bit-reverse the pattern through $FD00
C $D6CD,3 !!MUT-ARG!! byte fed to the $FD00 bit-reverse table
C $D6D1,4 $D7F2 set: overwrite instead of XOR
C $D6DB,2 XOR onto the background
C $D6DE,5 Mirror mode skips the column step
C $D6E5,3 Next pixel row is $20 further on
C $D6EC,2 Next of the glyph's 8 rows
C $D6F5,2 Back up by the width printed so far
C $D6FC,5 Mirror mode wraps differently
C $D70B,2 Mirrored wrap: H += 8
C $D715,4 String done: clear the "in message" flag
C $D71F,2 Bit 6 suppresses the marker
C $D723,1 Bit 7 asks for an arrow marker
C $D726,5 Write $FF at ($D617)
C $D732,3 Pending-sound table
C $D735,3 First $FF is the free slot
C $D73F,1 Slot takes the mode byte
C $D741,3 Then the message pointer
N $D746 Start of the second pass (see #R$D631's N-line): re-derives the attribute address from H/L rather than reusing anything from the first pass, then #R$D76E walks the data right after the string's own $00 terminator as one attribute byte per glyph, writing it to the shadow/real attribute area. Confirmed by rendering several icons with their real trailing bytes (#R$B4B8, #R$B434, #R$B4C1). Not to be confused with the first pass's $02/$03 codes (#R$D698), which mirror glyph *pixels* via bit-reversal - a completely separate mechanism that happens to share the same string.
C $D747,4 Attribute row = H/4 (H/L are the same row/column the first pass used, not a value it left behind)
C $D74B,2 !!MUT-ARG!! attribute row bias
C $D751,2 Snap the column to 8
C $D756,3 Remember the row address for the second pass
C $D759,2 !!MUT-ARG!! row address base ($E8 shadow attributes via #R$D631, $58 real screen via #R$D619)
C $D76A,3 B carries the mode byte through the second pass
C $D76E,2 DE is still where the first pass left it, right at the string's $00 terminator, so the loop's first INC DE below lands one byte past it - the attribute stream starts at terminator+1, one byte per glyph
C $D771,2 Second pass: $00 ends it
C $D775,3 Bit 5 of the mode byte: stop here
C $D778,2 Bit 7 hands off instead
C $D77A,3 => Copy the $001C-byte block at $E982 to $DECB
C $D77E,2 Bit 7 chars take the width adjust ($FF row-separator bytes included - same reposition path advances to the next row)
C $D782,2 Bit 7 of the mode picks $00 or $80
C $D789,2 !!MUT-ARG!! attribute value written per cell
C $D78B,1 Store the attribute
C $D78E,2 Bit 6 skips the queue write
C $D792,3 The $E500 change queue
C $D79A,2 Queue the character
C $D79C,5 Bump the queue offset
C $D7A3,2 Next column
C $D7A8,1 Shift back by the width printed
C $D7AE,3 Then on by $20
C $D7B6,3 Same shift applied to the $D617 pointer
w $D7CE Message address table, indexed by message number via #R$D631
N $D7CE 16 entries, indexed by bits 0-4 of the message number in A. #R$D631 doubles the index to reach the string address, then prints it via #R$D661.
W $D7CE,2 $00 - sword in Menu
W $D7D0,2 $01 - wreath icon
W $D7D2,2 $02 - bag-of-money icon
W $D7D6,2 $04 - arrow icon
W $D7D8,2 $05 - flower icon
W $D7DA,2 $06 - key icon
W $D7DC,2 $07 - #R$B57C, the laying quiver icon (gameplay pickup)
W $D7DE,2 $08 - "0 START"
W $D7E0,2 $09 - "1 KEYBOARD"
W $D7E2,2 $0A - "2 KEMPSTON"
W $D7E4,2 $0B - "3 INTERFACE II"
W $D7E6,2 $0C - "4 CURSOR"
W $D7E8,2 $0D - #R$B5F9, the open/missing-gate icon
W $D7EA,2 $0E - door/gate
W $D7EC,2 $0F - the Odin logo
W $D7EE,2 $10 - victory message "CONGRATULATIONS" / "YOU HAVE "...
b $D7F0 Text-printer state bytes
B $D7F0,1 Fixed-pattern flag (set by control code $01/$02, cleared by $03; see #R$D6AB)
B $D7F1,1 Attribute/mode param (set by #R$D619/#R$D631)
B $D7F2,1 "In message" flag (see #R$D715)
c $D7F3 Scan the message/sound trigger table at $D57A for Robin's position
N $D7F3 Walks the (up to 9) 3-byte entries written by #R$D735 - filled in by the text printer when it meets a control character in a string. For the first non-$FF entry whose stored X/Y reference bytes bracket Robin's position ($CC85/$CC86, +$00..$10), reads a chained pointer back through the entry to print an associated message via #R$D619/#R$D631 and, for certain entry types, starts an arrow-hit countdown or a sound (#R$D9E9). It then retires the trigger: the matching room+entry slot in the 11-entry log at $D543 is wiped to $FF, the room's entry in the 30-entry table at #R$D4AD has its flag byte cleared, and types $05/$07 decrement their running spawn counters at $D5A2/$D5A3, before the type is dispatched to a follow-up at #R$D944/#R$D94B. Not every field of the entry format is confirmed.
C $D7F8,3 $FF marks an empty slot
C $D803,3 Remember the active entry for the printer
C $D80A,4 Robin's X, floored at $18
C $D812,3 Below the entry's X reference: skip
C $D81B,5 Robin's Y, biased by $0C
C $D820,3 Same $10-wide band test on Y
C $D828,3 Remember the matched entry
C $D82F,4 Its type byte, kept at $D9F6
C $D833,2 Type $07 gets a one-shot sound
C $D837,4 Only while the $D5A0 countdown is idle
C $D83E,3 Short border-flash sound
C $D841,5 Arm a $0A countdown
C $D84D,3 Type 0 - #R$B495, the sword icon
C $D853,3 Type 3 - #R$B4C1, the bow icon
C $D85A,3 Type 6
C $D861,3 Type 7
C $D866,2 Anything else uses the chained pointer
C $D86A,3 Overwrite mode for the text
C $D86D,3 Print the string at the address pointed to by
C $D878,2 Bit 7 marks it as a follow-up message
C $D87A,3 Message number read from the matched #R$D57A trigger zone (varies), positioned from the $D7CE table
C $D87D,5 Now find this room+entry in the 11-slot log at $D543
C $D894,4 Compare the entry's own reference bytes
C $D8A4,4 And its type
C $D8AA,4 Match: wipe all 5 bytes to $FF
C $D8BD,5 Then the same room search over the 30-slot table at #R$D4AD
C $D8DA,2 Clear its flag byte
C $D8DF,2 Type $05 counter at $D5A2
C $D8E9,4 One fewer outstanding
C $D8EF,2 Type $07 counter at $D5A3
C $D8F9,4 One fewer
C $D8FE,3 $D59D holds the per-type follow-up flags
C $D905,2 => Play a sound and increment the trigger entry's counter
C $D90A,2 => Play a sound and increment the trigger entry's counter
C $D90F,2 => Play a sound and increment the trigger entry's counter
C $D911,2 Type 1 gets only a border cue
C $D913,2 => Shift the recent-event byte queue at $D59B, print any matching hints
c $D91A Print an extra-life-count message, increment the counter and its displayed digit
N $D91A Only 2 static call sites, neither a guard kill: #R$BEB1 (the Hermit's heal-and-reward) and #R$CB9D (Robin's own critical-hit stagger, which nets a -1 penalty by decrementing $D5A4 twice first). Also live-confirmed to run on a wreath pickup, though no wreath-side CALL to this address is visible in the static disassembly (reached indirectly, e.g. via a jump table) - matching a player-sourced walkthrough describing this as the displayed extra-life counter (incremented by wreaths and the Hermit's first-time reward). No call site rewards an ordinary guard kill; what (if anything) does is still an open question, see General.md. Unless the counter at $D5A4 is already at 9, prints a fixed message, increments the counter, converts it to an ASCII digit written into the text at $DA0B, and prints a second message containing it.
C $D91A,10 Bail out once the counter at $D5A4 reaches 9
C $D924,8 Set up the first message and its attribute
C $D92F,10 Increment the counter; convert it to an ASCII digit at $DA0B
C $D92C,3 Print the string at the address pointed to by
C $D941,3 => Print the string at the address pointed to by
c $D944 Play a sound and increment the trigger entry's counter
N $D944 Called from #R$D7F3 for a matched trigger. Plays the short border-flash sound (#R$D9E9, B = $64) then increments the byte at (HL) - the trigger entry's own count/type byte.
R $D944 HL Pointer to the trigger entry's counter byte, incremented on return
C $D944,5 B = $64 (sound length)
c $D94B Shift the recent-event byte queue at $D59B, print any matching hints
N $D94B Plays a short sound (#R$D9E9), then shifts the 8-byte queue $D595-$D59C down by one (HL=$D59B, DE=$D59C, B=7, so the 7 bytes $D595-$D59B move to $D596-$D59C) and writes the incoming value at $D9F6 into the vacated front slot, $D595 - this is the actual (and only) writer of #R$D595, the "event-status array" #R$DB18/#R$DF03 consume; the byte that falls off the $D59C end is what #R$D997's tail conditionally acts on. Scans the 8 two-byte pointer table at $D9F9 for one not equal to $FF; when found reads a message-address pair from the shifted queue and prints it via #R$D61F, defaulting to #R$B548 (flower) for queue value $05 and #R$B512 (bag of money) for anything else. Afterwards, if the value saved before the shift was $02, falls into #R$D997 to log the current room/position into the table at $D543. Reached only via fallthrough from #R$D7F3's trigger-zone scan for values other than $00/$01/$03/$06 - i.e. a room's authored hint-trigger zone (armed by the text printer, #R$D57A) drops a gold ($02) or flower ($05) token into this queue when Robin walks over the corresponding pickup.
C $D94D,3 Short border-flash sound
C $D950,6 HL/DE straddle the queue's two ends
C $D956,2 The byte falling off the end gates the #R$D997 tail below
C $D95A,2 Shift the queue one slot toward $D59C
C $D960,4 The new event value at $D9F6 goes in at the front
C $D966,3 Shadow HL walks the 8-entry message pointer table at $D9F9
C $D96D,3 Walk the shifted queue for a non-$FF entry
C $D973,3 DE = this entry's message address
C $D978,3 Default message
C $D97B,2 Queue value $05 keeps the default
C $D97F,3 Anything else: #R$B512, the bag-of-money icon
C $D984,6 Both text params = $60
C $D98B,3 Print the message
C $D990,2 Next of the 8 table entries
C $D993,3 Only a $02 falling off the queue runs the position log below
C $D99F,3 A slot is free when both its leading bytes are $FF
C $D9AB,1 Next slot (5-byte stride)
C $D9B2,4 !!MUT-ARG!! Log the current room
C $D9B7,3 !!MUT-ARG!! retargetable source address (room high byte by default)
C $D9BC,3 !!MUT-ARG!! retargetable source address (Robin's X by default)
C $D9BF,4 Robin's X, floored at $10
C $D9C8,3 !!MUT-ARG!! retargetable source address (Robin's Y by default)
C $D9CB,4 Robin's Y, snapped to 8 and biased by $10
C $D9D2,3 Entry type $02 marks a position record
C $D9D5,3 $D9B3 points at the tracked target room
C $D9DF,3 Only speak up when that room is the current one
C $D9E4,3 Print #R$B512, the bag-of-money icon, positioned from the $D7CE table
C $D9EA,2 Inner busy-wait sets the pitch
C $D9EE,4 Flip the border and speaker bits
b $D9F5
c $DA0F Check for a special-event room, set up its trigger if entered
N $DA0F Scans the 9-entry room-address table at $DBCD for the current room ($C548/$C549); does nothing if not found or if $D595 is already $FF. On a match, copies a 15-byte pattern from $A44F into the attribute area near $588D (mirrored for the room's flip flag) and points the "extra frame" callback at $C4D3 (called from #R$C4D2) at $DA9E, arming a one-off special-room animation/effect. $DBEA (set non-zero somewhere in this animation's own logic, not by #R$DA0F itself) is #R$C4D2's teleport-state trigger: $01 warps to room $9C, any other non-zero value warps to room $CC. Exact meaning of the copied pattern and the remaining flag bytes ($DBE7/$DBE8/$DBED) is not fully confirmed.
C $DA10,3 Clear the teleport trigger
C $DA16,3 $FF at $D595 means every special event is done
C $DA1C,3 The 9 special-event rooms
C $DA22,4 This entry's room number, kept at $DBEB
C $DA29,3 Match the current room, low byte then high
C $DA36,3 The room's world-map byte
C $DA42,3 Attribute destination $588D
C $DA45,4 Stash the map byte for the callback
C $DA49,3 Bit 7 (mirrored room) shifts the overlay 3 cells right
C $DA51,5 5 rows of pattern from $A44F
C $DA58,2 Copy one row of 3
C $DA5E,3 $1D on to the next attribute row
C $DA68,6 Arm the extra-frame callback at $DA9E
C $DA6E,5 Flash colour operands, patched into the callback below
C $DA78,5 $28 frames to run
C $DA7D,5 Drop Robin to Y $50
C $DA85,2 Facing bits pick the frame index
C $DA8E,2 0 and 3 both become 1
C $DA9B,3 Set the border-flash colour/count operands without flashing
C $DA9E,3 Callback body: attribute destination $408D
C $DAA4,3 Mirrored rooms shift 3 cells here too
C $DAAB,5 40 cells against the mask at $A35F
C $DAB3,2 Only masked cells get noise
C $DAB7,2 !!MUT-ARG!! ED 5F (LD A,R) or ED 4F (LD R,A), flipped each frame
C $DABF,2 Re-roll unless the flash operand is already $4F
C $DAC6,3 Stir the pseudorandom seed at $D38D using the R register
C $DAC9,1 Mask the noise
C $DACB,2 !!MUT-CMD!! $AE (XOR (HL)) or $B6 (OR (HL)), ping-ponged each frame
C $DAD5,4 Every 8th row wraps on to the next cell row
C $DAE9,4 Count the frame down
C $DAF1,2 Ping-pong the flash colour
C $DAFF,2 The second operand alternates the same way
C $DB01,2 => Resolve completed special-room events
C $DB10,3 Otherwise restart the $1E-frame cycle
c $DB17 No-op default for the extra room-draw callback at ($C4D3)
N $DB17 A single RET. #R$C4D2 always calls through ($C4D3); this is what it points at when no special-room effect is armed, so the callback costs nothing in the common case.
c $DB18 Resolve completed special-room events (arrow hits, energy refill)
N $DB18 This is the Witch's encounter resolution, confirmed against a player-sourced walkthrough (matches exactly). Reached only via the special-event room's flash-animation callback (#R$DA0F/#R$C4D2, entered by `JR NZ,$DB18` deep inside that animation, not a plain call) - i.e. it runs once per visit to one of the 9 marked rooms in #R$DBCD, and only once its door-flash cycle completes. Resets the ($C4D3) callback to the no-op at #R$DB17, then scans the 8-slot queue at $D595 (see #R$D94B, its writer) removing every $05 (flower) token found, up to 3: exactly 1 removed just prints a message (the Witch takes one flower and gives nothing); exactly 2 refills Robin's energy to full (#R$BF37 - "restores your life force"); 3 (the scan stops there even if more are queued, leaving any excess flower tokens untouched) sets $DBEA=2, warping Robin to room $CC via #R$C4D2 (the "garden in front of the castle"). Only when zero $05 tokens are found does it fall through to $D595's $02 (gold) tokens instead - removing one, decrementing $D5A5, and giving nothing in return - confirming flowers are always processed ahead of gold bags. Finishes by calling #R$DB98 and choosing between $D1F1's two halves based on $DBEA/$DBED. This routine still runs with the $D595 queue empty (nothing to remove, $DBEA defaults to $01); whether the Witch's own sprite is suppressed in that case is a separate, still-unlocated draw-condition - not confirmed here.
C $DB18,9 Reset the extra-frame callback at ($C4D3) to the no-op stub
C $DB21,3 HL -> the event-status array $D595
C $DB24,5 This entry != $05: skip the removal
C $DB29,4 Count this entry; remove the slot
C $DB2D,5 3 occurrences found: stop the scan
C $DB32,3 Next entry, loop
C $DB35,4 None found: try the "single trigger" scan
C $DB39,3 1 found: type $05 (print the count message)
C $DB3C,3 2 found: type $0F (refill energy)
C $DB3F,7 Otherwise: set $DBEA=2 (generic trigger frame)
C $DB46,5 Event type $0F: refill energy to max
C $DB4B,3 Draw the energy bar
C $DB50,5 BC = 8 entries again; HL -> $D595
C $DB55,5 This entry != $02: skip the removal
C $DB5D,4 Decrement the arrow-hit counter $D5A5
C $DB63,3 Next entry, loop
C $DB66,5 None found: set $DBEA=1
C $DB6E,7 A = the $DBEA flag; HL = 0 by default
C $DB77,7 Otherwise: HL = $DBED, mirrored (XOR bit 0 of H)
C $DB5A,3 Remove the current event slot, shifting the remaining ones down
C $DB6B,3 Print a status message for each of the 8 special-event slots
c $DB82 Remove the current event slot, shifting the remaining ones down
N $DB82 Called with HL -> an event byte within $D595 and B = the slot itself plus the bytes remaining after it. Shifts those trailing bytes one position back to close the gap (no-op if B was 1, i.e. nothing follows), writes an $FF terminator after the last one, then returns HL one byte before the removed slot - so a caller scanning the array with its own INC HL naturally re-visits this same index next, now holding what used to be the following entry.
R $DB82 HL Pointer to the event slot being removed
R $DB82 B Number of bytes following it, to shift down
C $DB82,3 Duplicate HL into DE (via EX DE,HL / POP HL)
C $DB85,2 Save the slot address and byte count for later restore
C $DB87,2 Step past the slot itself; B = bytes left to shift
C $DB8B,6 Shift each remaining byte back by one position
C $DB91,3 Write the new $FF terminator
C $DB94,2 Restore B and the saved slot address
C $DB96,1 Back up one, so the caller re-scans this same index next
c $DB98 Print a status message for each of the 8 special-event slots
N $DB98 For each of the 8 status bytes at $D595 (walked via DE from $D594), reads the matching message pointer from the table at $D9F9 (also used by #R$D94B) and picks between it and one of two fixed messages ($B548 for status $05, $B512 for status $02) before printing via #R$D61F.
C $DB98,7 DE = event-status array at $D594 (0-indexed via pre-increment)
C $DBA1,9 A = this slot's status byte; HL = its message pointer from $D9F9
C $DBAA,14 Status $05/$02: override with fixed message $B548/$B512
C $DBC4,3 Print the chosen message
C $DBC8,3 Restore HL; loop over the 8 slots
b $DBCD Special-event room table and the effect's state variables
N $DBCD #R$DA0F scans the room list for the current room and, on a match, arms the extra-frame callback whose state lives in the bytes below. The list holds 13 room numbers but only the first 9 are ever scanned (B=$09 at $DA1A) - the last 4 are unreachable.
B $DBCD,18,2 Special-event rooms, scanned by #R$DA0F
B $DBDF,8,2 4 further room numbers, never scanned
B $DBE7,1 Effect-frame counter (armed by #R$DA0F, counted down in the callback)
B $DBE8,1 World-map byte for the matched room (bit 7 = mirror)
B $DBE9,1 Random value gated through the mask pattern
B $DBEA,1 #R$C4D2's teleport trigger (0 = none, $01 = warp to $9C, other = warp to $CC)
W $DBEB,2 Room number of the matched entry
W $DBED,2 Frame/duration pair, also copied to $D1F1
c $DBF8 Cycle through and step one boar object per call
N $DBF8 Every 4th call (counter at $DBF9), picks one of the room's door/position entries from the table at $C54E (built by #R$C276 from $DD3F) and, if Robin ($CC85/$CC86) is within range, indexes IX into the matching entry of the object table at $DD05 (11 bytes/entry, built by #R$C276 too). From there the logic mirrors #R$BA85: (IX+9) is stepped by one toward the target position, wrapping past $70, and (IX+2/3)/(IX+4) are updated to pick a frame-pointer table (from $DD31/$DD38, drawing #R$A965's boar sprite - confirmed live) and redraw via #R$C8F7.
C $DBFA,4 Single-column rooms have no boars
C $DBFF,4 Only every 4th call
C $DC0A,3 Boars share the frame base at $8DEA
C $DC10,3 The guard-door table built by #R$C276
C $DC16,3 3 bytes per entry
C $DC22,3 Distance to the guard's target column
C $DC2A,2 Within 3?
C $DC32,4 $1C per row-table entry
C $DC3C,3 Robin's column
C $DC3F,4 /4
C $DC46,2 A = $80 or 0 by which side he is on
C $DC4C,4 Only re-aim ~1 call in 32
C $DC54,3 Rotate the new direction bit in
C $DC5B,2 Old bit 7 decides bit 6
C $DC61,2 Bit 7 picks the decrement or increment path
C $DC66,2 Step down two
C $DC6C,3 Underflow wraps up past $70
C $DC73,2 Step up two
C $DC76,2 Overflow wraps down past $70
C $DC7F,3 Carry the step into the column nibble
C $DC84,6 The $DD05 object table, $0B per entry
C $DC8A,3 Index by the same phase counter
C $DC9F,3 Guard's room nibble against Robin's
C $DCA9,2 Otherwise try the next column along
C $DCB4,2 Position past $10: out of range
C $DCBB,3 Resolved position into (IX+9)
C $DCC0,2 Facing bits 6-7
C $DCC8,2 Bit 7 picks $DD31 or $DD38
C $DCD3,6 Chosen table into (IX+2/3)
C $DCD9,8 Arm the redraw flags
C $DCE1,3 Advance an object's animation, unlink it from the list if done
C $DCE7,4 Out of range: bit 2 cleared for a different frame
C $DCEB,3 Advance an object's animation, unlink it from the list if done
C $DCF7,2 Facing picks the frame table here too
b $DD05 Boar object table, 4 entries of 11 bytes
N $DD05 Same entry layout as #R$AC13, rebuilt on every room change by #R$C276 from the door data at $DD3F. Stepped one entry per call by #R$DBF8 and tested against Robin's position by #R$BDE0. Its frame lists (#R$DD31/#R$DD38) draw #R$A965's wild-boar sprite (confirmed live), not a human guard - the "door" naming reflects the position/gating data at $DD3F, not what's drawn. The fixed 4-entry cap matches a player-sourced walkthrough describing "4 looped boar trails on the map, used as landmarks" - each boar patrols within its own room only ($70-wrap on (IX+9), same as room guards), so the "trail" is the visible pattern of which connected rooms $DD3F assigns a boar to, not a single boar travelling cross-room.
B $DD05,44,11
b $DD31 Boar frame lists ($10-$13 normal, $90-$93 mirrored) and door data
N $DD31 $DD31 (frames $10,$11,$12,$13) and $DD38 (frames $90-$93, bit 7 set = mirrored) are the two boar walk-cycle frame lists #R$DBF8 picks between (standard $FF-terminated format, see Actors.md) - confirmed live: these frame numbers resolve, via the shared base $8DEA, to #R$A965's wild-boar sprite. $DD3F is the per-room door/position data #R$C276 scans to build the boar table at #R$DD05.
B $DD31,7
B $DD38,7
@ $DD6F label=can_move_left
c $DD6F Collision check: can Robin move left?
N $DD6F Only checks at cell boundaries (L bits 0-1 clear); converts HL to an attribute address via #R$DDD6, steps to the row above-left, and tests via #R$DDB1.
R $DD6F HL Pixel position to test
R $DD6F O:Z Set if the move is clear, clear if blocked
C $DD6F,5 Only test at cell boundaries (L bits 0-1 clear)
C $DD76,3 Convert HL pixel coordinates to a shadow attribute address
C $DD79,5 Step to the row above-left, test via #R$DDB1
C $DD7E,2 => Check 2 vertically-stepped attribute cells for a blocking tile
@ $DD80 label=can_move_right
c $DD80 Collision check: can Robin move right?
N $DD80 Same as #R$DD6F but steps to the row above-right instead, testing via #R$DDB1.
R $DD80 HL Pixel position to test
R $DD80 O:Z Set if the move is clear, clear if blocked
C $DD80,5 Only test at cell boundaries (L bits 0-1 clear)
C $DD87,3 Convert HL pixel coordinates to a shadow attribute address
C $DD8A,7 Step to the row above-right, test via #R$DDB1
C $DD91,2 => Check 2 vertically-stepped attribute cells for a blocking tile
@ $DD93 label=can_move_up
c $DD93 Collision check: can Robin move up?
N $DD93 Only checks at cell boundaries (H bits 0-2 clear); converts HL to an attribute address via #R$DDD6 and tests the row above via #R$DDC5.
R $DD93 HL Pixel position to test
R $DD93 O:Z Set if the move is clear, clear if blocked
C $DD93,5 Only test at cell boundaries (H bits 0-2 clear)
C $DD9A,3 Convert HL pixel coordinates to a shadow attribute address
C $DD9D,2 => Check 3 horizontally-stepped attribute cells for a blocking tile
@ $DD9F label=can_move_down
c $DD9F Collision check: can Robin move down?
N $DD9F Same as #R$DD93 but steps down 3 rows first, testing via #R$DDC5.
R $DD9F HL Pixel position to test
R $DD9F O:Z Set if the move is clear, clear if blocked
C $DD9F,5 Only test at cell boundaries (H bits 0-2 clear)
C $DDA6,3 Convert HL pixel coordinates to a shadow attribute address
C $DDA9,4 Step down 3 rows ($0060) before testing
C $DDAD,2 => Check 3 horizontally-stepped attribute cells for a blocking tile
c $DDB1 Check 2 vertically-stepped attribute cells for a blocking tile
N $DDB1 (HL) -> a shadow attribute address (from #R$DDD6). Checks 2 cells, one screen row apart ($0020 stride), each testing bit 7 (solid) or a non-zero attribute (occupied); returns with A=0 (Z set) if both are clear, non-zero otherwise. Used by the vertical movement checks #R$DD6F/#R$DD80.
R $DDB1 HL -> a shadow attribute address (from #R$DDD6)
R $DDB1 O:Z Set if both cells are clear, clear otherwise
C $DDB1,5 B = 2 cells; DE = one-row stride ($0020)
C $DDB7,5 Blocked if bit 7 (solid) or any non-zero attribute (occupied)
C $DDBE,4 Step down one row, loop; A=0 (clear) if none blocked
c $DDC5 Check 3 horizontally-stepped attribute cells for a blocking tile
N $DDC5 Same test as #R$DDB1 but for 3 adjacent cells in the same row (HL incrementing). Used by the horizontal movement checks #R$DD93/#R$DD9F.
R $DDC5 HL Pointer to the first of the 3 attribute cells to test
C $DDC5,2 B = 3 cells
C $DDC8,5 Blocked if bit 7 (solid) or any non-zero attribute (occupied)
C $DDCF,3 Step to the next column, loop
c $DDD6 Convert HL pixel coordinates to a shadow attribute address
N $DDD6 Combines bits from H and L into an offset added to the shadow attribute area base at $E800.
R $DDD6 HL Pixel coordinates
R $DDD6 O:HL -> the matching shadow attribute address
C $DDD6,5 Column component: L >>= 2, stashed in A'
C $DDDC,7 Row component: (H AND $F8) x4 into HL
C $DDE4,7 Combine column (biased -2) into HL
C $DDEB,4 Add the shadow attribute base $E800
c $DDF0 Update each guard's route-availability flags for the current room
N $DDF0 IX -> the 4-entry guard table at ($C54C) (set up by #R$C276). For each guard, finds the entry in the 28-byte-stride table at $DEAB matching the guard's home room nibble (IX+0), tests one of its 3 flag bytes via #R$DE51 (picked by IX+1 bits 0-1) and, if clear, scans up to 25 further bytes to find where the guard's route re-opens, packing the result back into (IX+1). Exact meaning of the per-route flag bytes is not confirmed.
R $DDF0 IX -> the 4-entry guard table at ($C54C)
C $DDF0,6 IX -> guard table at ($C54C); B = 4 guards
C $DDF7,6 HL = table base $DEAB; DE = $001C stride between entries
C $DDFD,12 Scan for the entry matching the guard's home room nibble (IX+0)
C $DE1B,14 HL -> the flag byte picked by IX+1 bits 0-1
C $DE29,3 Test whether any of 3 consecutive bytes at (HL) is non-zero
C $DE2F,2 C = 25 bytes to scan for the route re-opening
C $DE31,3 Test whether any of 3 consecutive bytes at (HL) is non-zero
C $DE3A,12 Pack the found offset (x4) back into (IX+1)
C $DE46,10 Advance IX to the next guard, loop
C $DE31,3 Test whether any of 3 consecutive bytes at (HL) is non-zero
c $DE51 Test whether any of 3 consecutive bytes at (HL) is non-zero
N $DE51 Called from #R$DDF0 twice: once directly on the picked flag byte, once in a loop advancing HL to scan further bytes for where the route re-opens. Returns with Z set if all 3 bytes at (HL) are zero.
R $DE51 HL -> the first of 3 bytes to test
R $DE51 O:Z Set if all 3 bytes are zero, clear if any is non-zero
C $DE51,3 B = 3 bytes to check
C $DE54,4 Non-zero byte found: stop (Z clear)
C $DE58,3 Next byte, loop
c $DE5D Copy the $001C-byte block at $E982 to $DECB
N $DE5D Refreshes the guard-route working copy at $DECB from a live source at $E982, after #R$DE8D/#R$DE97/#R$DEA1 have set up which of the two templates that source should reflect.
c $DE69 Copy the $DEE7 template into $DECB (see #R$DE6E)
N $DE69 Trivial: picks $DEE7 as the source, falls into #R$DE6E's shared 28-byte LDIR into $DECB. Part of the still-unresolved $DEAB/$DECB template system (see Actors.md's open question) - #R$DE97 uses this entry, #R$DEA1 uses #R$DE6E directly for the other template.
c $DE6E Copy a 28-byte template ($DEAF or, via #R$DE69, $DEE7) into $DECB
N $DE6E Both entries just pick a source template before falling into the same LDIR; DECB is the same buffer filled directly by #R$DE5D.
c $DE7A Blank the template at $DEAF (see #R$DE7F)
N $DE7A Trivial: picks $DEAF as the target, falls into #R$DE7F's shared 27-byte zero-fill (byte 0 left untouched). Part of the still-unresolved $DEAB/$DECB template system (see Actors.md's open question) - #R$DE8D uses this entry, #R$DEA1 uses #R$DE7F directly for the other template.
c $DE7F Blank a 27-byte template ($DEE7, or via #R$DE7A, $DEAF), keep byte 0
N $DE7F Both entries pick a template address before zeroing 27 bytes starting one byte in (byte 0 - a type/flag byte - is left untouched).
c $DE8D Reset the guard-state working copy: both templates blanked
N $DE8D Blanks both 28-byte templates (#R$DE7A for $DEAF, #R$DE7F directly for $DEE7 - byte 0 of each left untouched), then refreshes the working copy at $DECB from $E982 via #R$DE5D. One of the three room-block-flag-selected variants called from #R$C276; see Actors.md's `$DEAB` open question for how this template system relates to the (separately-addressed) 28-byte-stride table `$DDF0` scans.
C $DE8D,3 Blank the template at $DEAF
C $DE90,3 Blank a 27-byte template ($DEE7, or via #R$DE7A, $DEAF), keep byte 0
C $DE93,3 Copy the $001C-byte block at $E982 to $DECB
c $DE97 Reset the guard-state working copy: $DEE7 template, $DEAF blanked
N $DE97 Copies the $DEE7 template into $DECB (#R$DE69), blanks $DEAF (#R$DE7A), then refreshes $DECB from $E982 via #R$DE5D. One of the three room-block-flag-selected variants called from #R$C276; see #R$DE8D and Actors.md's `$DEAB` open question.
C $DE97,3 Copy the $DEE7 template into $DECB
C $DE9A,3 Blank the template at $DEAF
C $DE9D,3 Copy the $001C-byte block at $E982 to $DECB
c $DEA1 Reset the guard-state working copy: $DEAF template, $DEE7 blanked
N $DEA1 #R$DE8D/#R$DE97/#R$DEA1 (called from #R$C276 based on the room's block flags) each pick a different combination of the two 28-byte templates at $DEAF/$DEE7 to write and blank, before refreshing the working copy at $DECB from $E982 via #R$DE5D.
C $DEA1,3 Copy a 28-byte template ($DEAF or, via #R$DE69, $DEE7) into $DECB
C $DEA4,3 Blank a 27-byte template ($DEE7, or via #R$DE7A, $DEAF), keep byte 0
C $DEA7,3 Copy the $001C-byte block at $E982 to $DECB
b $DEAB Guard route/state region, 28-byte stride
N $DEAB Scanned by #R$DDF0 as 28-byte entries keyed by a guard's home room nibble, and used by #R$DE8D/#R$DE97/#R$DEA1 as two templates ($DEAF/$DEE7) copied around a working copy at $DECB. Those two readings overlap, so the exact entry boundaries are unconfirmed; #R$AA31 also reads a column reference at $DEC7.
c $DF03 Special-scenario check: count completed events, play the next stage
N $DF03 The Ent's weapon-purchase transaction: called every frame from #R$BF80, but only acts while Robin stands in the Ent's room (#R$D3B2). $D5A1 (a shared quest-stage counter, also read by #R$C462's forest-door hints) caps this at 3 total advances. $DFE6 is cleared on every room entry (#R$D5A7/#R$D5B6) and set here once a transaction completes, so at most one payment is processed per visit - Robin must leave and come back to pay again. While unset, a 1-in-256 R-register roll throttles the check to roughly once a second. Each check counts how many of the 8 event-status bytes at $D595 read $02 (money bags robbed from the Bishop of Peterborough via #R$B919); fewer than 3 and nothing happens (silently retried next tick). With 3 or more: flashes the border, removes 3 of those $02 slots from $D595 (#R$DB82), prints per-slot status messages (#R$DB98), knocks 3 off the arrow-hit counter #R$D5A5, then resolves the purchase itself. If the sword flag #R$D59D is clear, this payment buys the sword: sets it and prints message $B495. Otherwise, if the arrow flag #R$D59E is clear, this payment buys the bow: sets it, prints messages $B567 then $B4C1, and extends the $D5A0 countdown by 10. Otherwise (sword and bow already owned), it prints one of 3 messages selected by the current $D5A1 (offsets into $B556 by $0C for stage 1, $10 for stage 2) and then advances $D5A1 - confirmed against a player-sourced walkthrough: these are the 3 magic arrows, one per payment, sword and bow having already used the first two of the 4 possible transactions. The one transaction a visit allows also marks an attribute cell (#R$79F9's mirror bit picks $588D vs $5894) with a patched colour (#R$DFCA): first with $12, then - since $DFE6 is still clear the first (and only) time this runs per visit - after a long busy-wait delay (~8M iterations) it re-marks the same cell with $04 and sets $DFE6. This code is shared with other special-event rooms (where $588D/$5894 sit near the door), but in the Ent's own room $588D lands on attribute row 4, column 13 - inside block #R$662C's own cells (the Ent's top-right quarter) - so what plays out as a generic "mark near the door" flash elsewhere is, here, the Ent's eye: $12 (red ink/red paper) turns the cell solid red, then after the delay $04 (green ink/black paper) restores it to the eye's normal look - one character cell blinking red and back, confirmed by a player screenshot of the effect mid-transaction.
C $DF0A,3 Only in the designated scenario room
C $DF0E,5 Stage counter caps at 3
C $DF14,4 $DFE6 (cleared on room entry) allows at most one payment per visit
C $DF19,4 Fires ~1 call in 256
C $DF21,3 The 8 status bytes at $D595
C $DF2D,3 Need 3 of them before the stage advances
C $DF33,3 Set the border-flash colour/count operands without flashing
C $DF3D,2 Re-scan, this time removing them
C $DF42,3 Remove the current event slot, shifting the remaining ones down
C $DF4D,3 Print a status message for each of the 8 special-event slots
C $DF53,5 Arrow-hit counter down by 3
C $DF5B,4 Sword flag $D59D clear: this payment buys the sword
C $DF6A,3 Otherwise, bow flag $D59E clear: this payment buys the bow
C $DF74,5 And extends the $D5A0 countdown
C $DF81,3 Print the string at the address pointed to by
C $DF89,6 Sword and bow already owned: buying a magic arrow, offset chosen by stage counter $D5A1
C $DFA4,4 Advance the stage
C $DFAC,3 Print the string at the address pointed to by
C $DFAF,5 $12 into $DFCB, the value stored by $DFCA
C $DFB4,3 The room's world-map byte
C $DFC4,3 Bit 7 (mirrored) picks the other attribute cell
C $DFCA,2 !!MUT-ARG!! door-marker attribute value (the Ent's eye colour, in the Ent's room)
C $DFCD,4 Once only, guarded by $DFE6
C $DFDF,5 $04 into $DFCB, so the second pass marks differently
s $DFE6
c $DFE7 Interrupt-safe wrapper around the border flash routine at #R$DFF4
N $DFE7 The actual interrupt handler, pointed at by the IM 2 vector table #R$D095 sets up. Saves every register the game code might be using, plays one border-flash step via #R$DFF4, then restores everything before returning - so any routine's flash sound keeps ticking every 1/50s frame without the interrupt disturbing whatever it interrupted.
C $DFEB,3 Flash the border colour
@ $DFF4 label=flash_border
c $DFF4 Flash the border colour (self-modified colour/count)
N $DFF4 The generic border-flash "beep" used throughout the game. Callers don't pass arguments in registers - they patch this routine's own colour and delay-count operands directly before calling it, so each caller effectively gets its own pitch and length. Does nothing if the patched colour is 0.
C $DFF4,2 !!MUT-ARG!! Colour operand patched in by the caller before CALL
C $DFF9,2 !!MUT-ARG!! Delay-count operand patched in by the caller before CALL
C $E002,10 Busy-wait, then toggle border colour via OUT ($FE); repeat 10 times
c $E00D Set the border-flash colour/count operands without flashing
N $E00D Disables interrupts, patches A into the two self-modified operands at $DFF5/$DFFA (the colour and delay-count #R$DFF4 reads on its next call), then re-enables interrupts. Lets a caller arm/change the flash colour without waiting through an actual flash cycle.
R $E00D A Border-flash colour/count value, patched into $DFF5 and $DFFA
c $E016 Tape-save stub: wait for a key, then dump all of RAM to tape
N $E016 Waits for any key on a full-keyboard scan, drops SP to $0000 and calls the ROM's SA_BYTES ($04C5) with IX=$4000, DE=$C000 and A=$FF to save the whole 48K - a developer/cracker leftover with no caller in the game (the $E016 in #R$FE00's row-address table is unrelated junk, not a pointer to it).
C $E016,3 Read the whole keyboard at once
C $E01B,3 CPL and mask make a pressed key non-zero
C $E01E,2 => Tape-save stub
C $E026,3 DE = $C000, the full 48K length
C $E029,4 IX = $4000, the start of RAM
C $E02D,2 $FF marks it as a data block
s $E032 Unused zero fill up to the #R$E500 buffer
b $E500 Changed-cell flag area, 18 rows of 32
N $E500 One byte per character cell (28 used per row, 4 skipped). Drawing routines set a byte to mark that cell dirty; #R$C85C scans from $E502 and copies each marked cell to the real screen. The same 576 bytes are reused as scratch elsewhere - #R$C790 saves sprite backgrounds here, and #R$CD6C plays the startup speech bitstream from $E500 before the game proper begins.
B $E500,576,32
b $E800 Shadow screen attributes area
B $E800,,32
b $EB00 Shadow screen, pixels, 144 lines by 32 bytes
B $EB00,,32
b $FD00 Bit-reverse lookup table, 256 bytes
N $FD00 Built at startup by #R$CFEE: entry N holds N with its bits reversed. Every horizontal mirror goes through it (#R$C1D6, #R$C5E4, #R$C8B7), each time by self-modifying the low byte of a "LD A,($FD00)" operand with the value to reverse.
b $FE00 Screen row-address table, 192 entries of 2 bytes
N $FE00 Built at startup by #R$D004: entry N is the pixel address of screen line N, so the ZX screen's non-linear third/row/scanline layout only has to be worked out once. #R$C806, #R$C85C and #R$CE81 index it (via IX or IY) instead of recomputing an address per row. The bytes in the snapshot are tape-loader leftovers from before #R$D004 ran, not table data - hence the stray text visible in them.
W $FE00,384,8
b $FFF4 IM 2 interrupt vector landing point
N $FFF4 #R$D095 patches a JP #R$DFE7 in here at startup, so this is where every interrupt lands once IM 2 is set with I=$39. It also writes $18 to $FFFF. The bytes in the snapshot are whatever was here before that patch ran - the stack grows down from $FFF4, so they are not meaningful data.
B $FFF4,3 JP #R$DFE7, written by #R$D095
B $FFF7,8
B $FFFF,1 $18, written by #R$D095
