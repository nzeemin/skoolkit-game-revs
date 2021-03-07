b $60C2
W $60E9,2 Saved SP
B $60EB,1
W $60EC,10,8
W $610A,2
W $610C,2
W $610E,2 ?? Object?
W $6110,2
B $6122,1
B $6124,1
B $6125,1
B $6126,1 Room number
W $6127,2 Room description address
B $6129,1 Bit 6 from byte 3 of Room description, shifted to bit 0
B $612A,1 Bits 4-7 from byte 2 of Room description, shifted to bits 0-3
B $612B,1 Byte 1 from Room description
B $612C,64,8 Room grid 8x8 ??
B $6174,1
B $6175,1 Room color 0..15
B $6179,1
B $617A,1
B $617B,1
B $6186,1
B $618A,1
W $618B,2
W $618D,2
B $618F,1
B $6190
B $6193,1
W $6194,2
W $6196,2
B $6198,1
B $6199,1
B $619A,1 Room number copy
W $619B,2
B $619D,1
B $619C,1
B $619E,1
B $619F,1
B $61A0,1
B $61A1,1
B $61A2,1
B $61A3,1
B $61A6,1
c $61A7
c $61A8
c $61C1
c $61E3
C $6224,3 Room descriptions start address
c $6254
c $6269
C $6269,3 set room number
C $626D,3 Room descriptions start address
C $6275,1 get offset to the next room description
C $6279,3 Store room description address
C $6295,13 Clear room grid - 64 bytes at 612C
c $62F9
C $62F9,3 get room number
c $630D
c $6329
c $6344
c $6377
c $63D0 Clear shadow screen
C $63D0,3 Shadow screen address
b $63DE
c $642F
c $6470
C $6478,3 Room grid address
c $64BB
c $64F3
b $64FF
B $6500 Oil level??
B $6501 Oil level??
B $6502 Oil level??
c $6503 Routine ?? Oil
C $6507,1 POKE 201 (RET) here for infinite Oil
C $6508,3 get room number
b $653F
c $6543
c $655E
c $6580
c $6593
b $65CF
B $65D3
W $65D7
W $65D9
c $65DB
C $65F6,3 "  DEATHBOWL  "
c $6622
c $663B
c $6653 Prepare room with color 0
C $6654,3 Prepare the Room with color A
c $6657 Get room color from room description and store to 6175
C $6657,3 get room description address
C $665C,1 get Byte 3: Room colour and Room Size
C $665D,2 color only
C $665F,3 Store room color
c $6663
c $6692
c $66CE
c $6728
C $6733,3 get room number
c $6743
C $67A8,3 Clear shadow screen
c $676D
C $6776,3 get room number
C $67CE,3 Prepare room with color 0
C $67D1,3 Get room color from room description and store to 6175
C $67EB,3 Prepare room with color 0
C $67EE,3 Get room color from room description and store to 6175
c $67F1
C $6819,3 get room number
c $6880
c $6895
c $68C1
b $68DE
t $6997
c $69AC Prepare the Room ??
R $69AC A Room color
C $6A32,3 Screen attribute area start address
c $6AAA
c $6AE7
c $6AF1
c $6AF8
c $6AFB
c $6AFC
c $6B05
c $6B71
b $6C06
t $6C38
b $6C45
t $6C46
s $6C51
t $6C52
b $6C5F
t $6C67
b $6C71
t $6C74
b $6C80
b $6CCF Room descriptions.
N $6CCF Room description format:
N $6CCF byte 0: length - offset to the next description;
N $6CCF byte 1: ??;
N $6CCF byte 2: room size/color.
B $6CCF,7 Room $00 description
B $6CD6,6 Room $01 description
B $6CDC,4 Room $02 description
B $6CE0,4 Room $03 description
B $6CE4,10 Room $04 description
B $6CEE,8 Room $05 description
B $6CF6,8 Room $06 description
B $6CFE,6 Room $07 description
B $6D04,4 Room $08 description
B $6D08,4 Room $09 description
B $6D0C,4 Room $0A description
B $6D10,6 Room $0B description
B $6D16,4 Room $0C description
B $6D1A,4 Room $0D description
B $6D1E,14 Room $0E description
B $6D2C,4 Room $0F description
B $6D30,10 Room $10 description
B $6D3A,10 Room $11 description
B $6D44,12 Room $12 description
B $6D50,6 Room $13 description
B $6D56,4 Room $14 description
B $6D5A,6 Room $15 description
B $6D60,8 Room $16 description
B $6D68,4 Room $17 description
B $6D6C,4 Room $18 description
B $6D70,4 Room $19 description
B $6D74,4 Room $1A description
B $6D78,6 Room $1B description
B $6D7E,6 Room $1C description
B $6D84,6 Room $1D description
B $6D8A,10 Room $1E description
B $6D94,6 Room $1F description
B $6D9A,4 Room $20 description
B $6D9E,10 Room $21 description
B $6DA8,8 Room $22 description
B $6DB0,4 Room $23 description
B $6DB4,4 Room $24 description
B $6DB8,4 Room $25 description
B $6DBC,4 Room $26 description
B $6DC0,4 Room $27 description
B $6DC4,10 Room $28 description
B $6DCE,8 Room $29 description
B $6DD6,9 Room $2A description
B $6DDF,4 Room $2B description
B $6DE3,6 Room $2C description
B $6DE9,4 Room $2D description
B $6DED,4 Room $2E description
B $6DF1,6 Room $2F description
B $6DF7,4 Room $30 description
B $6DFB,16 Room $31 description
B $6E0B,10 Room $32 description
B $6E15,6 Room $33 description
B $6E1B,10 Room $34 description
B $6E25,6 Room $35 description
B $6E2B,4 Room $36 description
B $6E2F,6 Room $37 description
B $6E35,4 Room $38 description
B $6E39,4 Room $39 description
B $6E3D,4 Room $3A description
B $6E41,4 Room $3B description
B $6E45,4 Room $3C description
B $6E49,10 Room $3D description
B $6E53,4 Room $3E description
B $6E57,4 Room $3F description
B $6E5B,10 Room $40 description
B $6E65,6 Room $41 description
B $6E6B,8 Room $42 description
B $6E73,4 Room $43 description
B $6E77,8 Room $44 description
B $6E7F,4 Room $45 description
B $6E83,6 Room $46 description
B $6E89,18 Room $47 description
B $6E9B,6 Room $48 description
B $6EA1,14 Room $49 description
B $6EAF,4 Room $4A description
B $6EB3,8 Room $4B description
B $6EBB,4 Room $4C description
B $6EBF,4 Room $4D description
B $6EC3,4 Room $4E description
B $6EC7,4 Room $4F description
B $6ECB,4 Room $50 description
B $6ECF,7 Room $51 description
B $6ED6,4 Room $52 description
B $6EDA,10 Room $53 description
B $6EE4,4 Room $54 description
B $6EE8,4 Room $55 description
B $6EEC,4 Room $56 description
B $6EF0,4 Room $57 description
B $6EF4,8 Room $58 description
B $6EFC,8 Room $59 description
B $6F04,12 Room $5A description
B $6F10,4 Room $5B description
B $6F14,8 Room $5C description
B $6F1C,8 Room $5D description
B $6F24,8 Room $5E description
B $6F2C,13 Room $5F description
B $6F39,4 Room $60 description
B $6F3D,10 Room $61 description
B $6F47,4 Room $62 description
B $6F4B,4 Room $63 description
B $6F4F,16 Room $64 description
B $6F5F,6 Room $65 description
B $6F65,4 Room $66 description
B $6F69,4 Room $67 description
B $6F6D,4 Room $68 description
B $6F71,8 Room $69 description
B $6F79,6 Room $6A description
B $6F7F,4 Room $6B description
B $6F83,4 Room $6C description
B $6F87,4 Room $6D description
B $6F8B,13 Room $6E description
B $6F98,4 Room $6F description
B $6F9C,4 Room $70 description
B $6FA0,6 Room $71 description
B $6FA6,4 Room $72 description
B $6FAA,6 Room $73 description
B $6FB0,4 Room $74 description
B $6FB4,14 Room $75 description
B $6FC2,7 Room $76 description
B $6FC9,4 Room $77 description
B $6FCD,4 Room $78 description
B $6FD1,4 Room $79 description
B $6FD5,4 Room $7A description
B $6FD9,20 Room $7B description
B $6FED,8 Room $7C description
B $6FF5,4 Room $7D description
B $6FF9,22 Room $7E description
B $700F,7 Room $7F description
B $7016,4 Room $80 description
B $701A,6 Room $81 description
B $7020,4 Room $82 description
B $7024,4 Room $83 description
B $7028,4 Room $84 description
B $702C,4 Room $85 description
B $7030,4 Room $86 description
B $7034,6 Room $87 description
B $703A,4 Room $88 description
B $703E,4 Room $89 description
B $7042,6 Room $8A description
B $7048,4 Room $8B description
B $704C,8 Room $8C description
B $7054,8 Room $8D description
B $705C,9 Room $8E description
B $7065,6 Room $8F description
B $706B,14 Room $90 description
B $7079,6 Room $91 description
B $707F,12 Room $92 description
B $708B,4 Room $93 description
B $708F,6 Room $94 description
B $7095,4 Room $95 description
B $7099,4 Room $96 description
B $709D,4 Room $97 description
B $70A1,12 Room $98 description
B $70AD,11 Room $99 description
B $70B8,16 Room $9A description
B $70C8,6 Room $9B description
B $70CE,10 Room $9C description
B $70D8,8 Room $9D description
B $70E0,11 Room $9E description
B $70EB,14 Room $9F description
B $70F9,10 Room $A0 description
B $7103,10 Room $A1 description
B $710D,6 Room $A2 description
B $7113,24 Room $A3 description
B $712B,6 Room $A4 description
B $7131,10 Room $A5 description
B $713B,4 Room $A6 description
B $713F,8 Room $A7 description
B $7147,4 Room $A8 description
B $714B,4 Room $A9 description
B $714F,4 Room $AA description
B $7153,4 Room $AB description
B $7157,18 Room $AC description
B $7169,7 Room $AD description
B $7170,4 Room $AE description
B $7174,4 Room $AF description
B $7178,4 Room $B0 description
B $717C,4 Room $B1 description
B $7180,6 Room $B2 description
B $7186,6 Room $B3 description
B $718C,16 Room $B4 description
B $719C,12 Room $B5 description
B $71A8,10 Room $B6 description
B $71B2,7 Room $B7 description
B $71B9,4 Room $B8 description
B $71BD,4 Room $B9 description
B $71C1,4 Room $BA description
B $71C5,4 Room $BB description
B $71C9,4 Room $BC description
B $71CD,4 Room $BD description
B $71D1,4 Room $BE description
B $71D5,18 Room $BF description
B $71E7,13 Room $C0 description
B $71F4,4 Room $C1 description
B $71F8,8 Room $C2 description
B $7200,4 Room $C3 description
B $7204,8 Room $C4 description
B $720C,14 Room $C5 description
B $721A,4 Room $C6 description
B $721E,6 Room $C7 description
B $7224,4 Room $C8 description
B $7228,4 Room $C9 description
B $722C,7 Room $CA description
B $7233,7 Room $CB description
B $723A,13 Room $CC description
B $7247,4 Room $CD description
B $724B,8 Room $CE description
B $7253,4 Room $CF description
B $7257,4 Room $D0 description
B $725B,4 Room $D1 description
B $725F,4 Room $D2 description
B $7263,4 Room $D3 description
B $7267,4 Room $D4 description
B $726B,4 Room $D5 description
B $726F,7 Room $D6 description
B $7276,16 Room $D7 description
b $7286
b $72AB
b $72B1 Room types??
W $72B1,32,8
b $72D1 Room types ??
B $72D1 Room type $0
B $72E4 Room type $1
B $72F3 Room type $2
B $731A Room type $3
B $7329 Room type $4
B $733E Room type $5
B $734F Room type $6
B $7362 Room type $7
B $7389 Room type $8
B $73A0 Room type $9..$E
B $73B3 Room type $F
t $73B5
T $73C3
T $73D1
T $73DF
T $73ED
T $73FB
T $7409
T $7417
T $7425
T $7433
t $7441
T $7455
T $7469
T $747D
T $7491
T $74A5
T $74B9
b $74CE
B $750B
t $75AE
b $75B5
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
W $7CE8,2 Print char routine address
W $7CEA,2 ??
c $7CEC
C $7CF5,3 get Print char routine address
c $7CF9 Print char routine
C $7D03,3 Font base address
C $7D15,1 next line
c $7D32
c $7D3F
c $7D48
C $7D4B,3 Shadow screen address
c $7D57
b $7D63
W $7D63,2
B $7D65,1
B $7D66,2
c $7D68
R $7D68 HL ??
C $7D8C,3 Shadow screen address
C $7D94
C $7D9F
b $7DB7
B $7DBF
c $7DC7
b $7E4C Variables to use in routine 7E4F
W $7E4C,2
B $7E4E,1
c $7E4F
R $7E4F L Sprite number
C $7E53,3 Table of sprites address
C $7E83,25 Flip the byte
c $7EA9
c $7EBE
c $7F8E
c $7F9B
b $7FBD
c $7FC0
c $7FCD
c $8011
c $809D
c $8107
b $8124
B $8126 Sprite number??
B $8127 Sprite number??
c $8128
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
c $848E
c $84AE
c $84ED
R $84ED L Sprite number
c $8501
c $850E
c $8513
c $8523
c $854C
c $854F
b $8567
t $856B
b $8595
c $85A1
c $86CC
c $885A
s $8874
c $8879
c $888E
c $8894
c $88B9
c $88D7
c $88DD
c $88E3
b $88EF
c $8968
c $8A87
b $8AB3
c $8ABB
c $8AD9
c $8AFB
c $8C35
b $8C48
t $8CD9
b $8CDC
c $8CDF
b $8CF8
c $8D11
c $8D8D
b $8DB6
B $8DD1,22
B $8DF1,22
t $8E37
b $8E3B
c $8E3F
c $8E6E
c $8EA7
c $8EF2
c $8F1E
c $8F4C
s $8F81
c $8F82
c $9021
t $9077
b $907B
t $907C
b $9080
c $9085
t $908D
b $9091
c $90A8
b $919A
c $91A6
b $91E2
c $9208
b $9210
c $9232
c $923E
b $9246
c $925C
s $933D
c $9341
c $9401
b $9463
c $9471
b $9489
t $9495
b $9499
c $949E
c $94CA
t $94E9
b $94ED
c $94EE
b $94F4
t $94FD
b $9500
t $9502
b $9507
t $9526
b $952A
c $952D
t $9577
b $957B
c $957C
b $95C1
B $95FB
c $9602
c $9684
b $9723
c $9745
C $9795,3 Room grid address
c $97BA
R $97BA IX ??
c $97FC
w $9806
c $9808
c $983C
R $983C IX ???
C $987B,3 JP (HL)
c $9900
b $991A
c $9923
b $995E
c $9963
c $99A1
C $99A7,2 "RET" instruction code
C $99A9,3 set instruction
C $99B3,1 "NOP" instruction code
C $99B4,3 set instruction
C $99BD,1 "NOP" instruction code
C $99BE,3 set instruction
c $99D1 NEG / not NEG
c $99D5
C $99D5 "RET" instruction code
C $99D7,3 set instruction
C $9A01,3 NEG / not NEG
C $9A15,3 NEG / not NEG
C $9A3A,3 get instruction code
c $9A49
c $9A60
c $9AAB
b $9ABA
c $9ABC
R $9ABC BC ??
C $9AD3,3 Room grid address
c $9AFD
c $9B5A
b $9BD2
c $9BD4
c $9BF0
R $9BF0 IX ??
b $9C32
c $9C35
C $9C81,3 Shadow screen address
N $9CBA Copy shadow screen to ZX screen
C $9CBD,3 Shadow screen address
C $9D39,3 Prepare the Room with color A
b $9D3C
b $A400 Font 59 characters, 8 bytes each, 472 bytes
w $A5D8
w $A5DC Table of Sprites, 201 records, 4 bytes each
N $A5DC record[0..1] = sprite data address;
N $A5DC record[2] = height in 8px rows, bit 7 = ??;
N $A5DC record[3] = width in 8px columns.
W $A5DC,804,16
b $A900
b $A92C
W $A92C,,16
b $A9DE
b $AA17
b $AA1B
b $AA3E Sprites: 7 sprites of Player 32x24, 96 bytes each
b $AA9E Sprite
b $AAFE Sprite
b $AB5E Sprite
b $ABBE Sprite
b $AC1E Sprite
b $AC7E Sprite
b $ACDE Sprites: 4 sprites of Player shadow 32x16, 64 bytes each
b $AD1E Sprite
b $AD5E Sprite
b $AD9E Sprite
b $ADDE Sprite
b $AE26 Sprite
b $AE6E Sprite
b $AECE Sprite
b $AF2E Sprite
b $AF8E Sprite
b $AFD6 Sprite
b $B036 Sprites: 4 sprites of Player 32x24, 96 bytes each
b $B096 Sprite
b $B0F6 Sprite
b $B156 Sprite
b $B1B6 Sprites: explosion??
b $B236 Sprite
b $B296 Sprite
b $B2C6 Sprite
b $B30E Sprite: player 32x24, 96 bytes
b $B36E Sprites: 4 Fish sprites 32x32, 128 bytes each
b $B3EE Sprite
b $B46E Sprite
b $B4EE Sprite
b $B56E Sprites: Snake phases; Sea Horse sprites
b $B57E Sprite
b $B59E Sprite
b $B5CE Sprite
b $B60E Sprite
b $B64E Sprite
b $B68E Sprites: 4 Fish sprites 32x32, 128 bytes each
b $B70E Sprite
b $B78E Sprite
b $B80E Sprite
b $B88E Sprite
b $B8BE Sprite
b $B8EE Sprite
b $B91E Sprite
b $B94E Sprite
b $B97E Sprite
b $B9AE Sprite
b $B9DE Sprite
b $BA0E Sprite
b $BA3E Sprite
b $BA6E Sprite
b $BA9E Sprite
b $BACE Sprite
b $BAFE Sprite
b $BB2E Sprites
b $BBAE Sprite
b $BC2E Sprite
b $BC6E Sprite
b $BCAE Sprite
b $BD0E Sprite
b $BD6E Sprite
b $BD8E Sprite
b $BDAE Sprite
b $BDEE Sprite
b $BE2E Sprite
b $BE8E Sprite
b $BEEE Sprite
b $BF4E Sprite
b $BFAE Sprite
b $BFEE Sprite
b $C02E Sprite
b $C0AE Sprite
b $C12E Sprite
b $C17E Sprite
b $C1CE Sprite
b $C1EE Sprite
b $C20E Sprite
b $C226 Sprite
b $C23E Sprite
b $C256 Sprite
b $C26E Sprite
b $C28E Sprite
b $C2AE Sprite
b $B796 Sprite
b $C2EE Sprite
b $C30E Sprite
b $C32E Sprite
b $C34E Sprite
b $C36E Sprite
b $C38E Sprite
b $C39E Sprite
b $C3AE Sprite
b $C42E Sprite
b $C4AE Sprite
b $C52E Sprite
b $C55E Sprite
b $C58E Sprite
b $C5BE Sprite
b $C5EE Sprite
b $C61E Sprite
b $C64E Sprite
b $C67E Sprite
b $C6AE Sprite
b $C6DE Sprite
b $C70E Sprite
b $C73E Sprite
b $C76E Sprite
b $C79E Sprite
b $C7CE Sprite
b $C7FE Sprite
b $C876 Sprite
b $CA56 Sprite
b $CC96 Sprite
b $CE26 Sprite
b $BE9E Sprite
b $CF26 Sprite masks: 7 masks 32x24, 92 bytes each
b $CF86 Sprite
b $CFE6 Sprite
b $D046 Sprite
b $CBB6 Sprite
b $D106 Sprite
b $C4F6 Sprite
b $D1C6 Sprite
b $D20E Sprite
b $D256 Sprite
b $D2B6 Sprite
b $D316 Sprite
b $D376 Sprite
b $D3BE Sprite
b $D41E Sprite masks: 4 masks 32x24, 92 bytes each
b $D47E Sprite
b $D4DE Sprite
b $D53E Sprite
b $D59E Sprite masks for explosion
b $D61E Sprite
b $D67E Sprite
b $D6AE Sprite
b $D6F6 Sprite
b $D756 Sprite
b $D7D6 Sprite
b $D856 Sprite
b $D8D6 Sprite
b $D956 Sprite
b $D966 Sprite
b $D986 Sprite
b $D9B6 Sprite
b $D9F6 Sprite
b $DA36 Sprite
b $DA76 Sprite
b $DAF6 Sprite
b $DB76 Sprite
b $DBF6 Sprite
b $DCB6 Sprite
b $DC8E Sprite
b $DCA6 Sprite
b $DCBE Sprite
b $DCD6 Sprite
b $DCDE Sprite
b $DCE6 Sprite
b $DCEE Sprite
b $DCF6 Sprite
b $DCFE Sprite
b $DD7E Sprite
b $DDFE Sprite
b $DE1E Sprite
b $DE3E Sprite
b $DE5E Sprite
b $DE7E Sprite
b $DE9E Sprite
b $DEBE Sprite
b $DEEE Sprite
b $DF0E Sprite
b $DF2E Sprite
b $DFDE Sprite
b $E14F
b $E16B
b $E170
t $E200
b $E301
b $E390 Shadow screen 256x192, 32*192=6144 bytes
B $E390,6144,32
b $FB90
b $FBA8
c $FBB4 Menu??
c $FBC1 Menu??
c $FBCF Menu??
c $FBD7 Menu??
t $FC30
c $FC34 Menu??
c $FC46 Menu??
b $FC64
b $FC71
b $FC75
b $FC76
b $FC7C
b $FC7D
b $FC89
b $FC9A
b $FCA6
b $FD5D
b $FD60
b $FD61
b $FD66
b $FDBB
b $FDC0
b $FDC1
b $FDC6
b $FE1F
b $FE22
b $FE2D
b $FE32
b $FFC7
b $FFCC
