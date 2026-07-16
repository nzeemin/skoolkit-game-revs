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
b $B296 Sprite, 16x24 pixels. Gnome, unidentified (small humanoid figure; collectible object per instructions text)
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
b $B68E Sprite, 32x32 pixels. Fish
B $B68E,128,8 #HTML[#UDGARRAY4,,,4,,($B68E-$B70D-1-32)(sprite-b68e)]
b $B70E Sprite, 32x32 pixels. Fish
B $B70E,128,8 #HTML[#UDGARRAY4,,,4,,($B70E-$B78D-1-32)(sprite-b70e)]
b $B78E Sprite, 32x32 pixels. Fish
B $B78E,128,8 #HTML[#UDGARRAY4,,,4,,($B78E-$B80D-1-32)(sprite-b78e)]
b $B80E Sprite, 32x32 pixels. Fish
B $B80E,128,8 #HTML[#UDGARRAY4,,,4,,($B80E-$B88D-1-32)(sprite-b80e)]
b $B88E Sprite, 16x24 pixels. Idol, unidentified
B $B88E,48,8 #HTML[#UDGARRAY2,,,2,,($B88E-$B8BD-1-16)(sprite-b88e)]
b $B8BE Mask, 16x24 pixels. Idol
B $B8BE,48,8 #HTML[#UDGARRAY2,,,2,,($B8BE-$B8ED-1-16)(sprite-b8be)]
b $B8EE Sprite, 16x24 pixels. Can
B $B8EE,48,8 #HTML[#UDGARRAY2,,,2,,($B8EE-$B91D-1-16)(sprite-b8ee)]
b $B91E Mask, 16x24 pixels. Can
B $B91E,48,8 #HTML[#UDGARRAY2,,,2,,($B91E-$B94D-1-16)(sprite-b91e)]
b $B94E Sprite, 16x24 pixels. Tin can
B $B94E,48,8 #HTML[#UDGARRAY2,,,2,,($B94E-$B97D-1-16)(sprite-b94e)]
b $B97E Mask, 16x24 pixels. Tin can
B $B97E,48,8 #HTML[#UDGARRAY2,,,2,,($B97E-$B9AD-1-16)(sprite-b97e)]
b $B9AE Sprite, 16x24 pixels. Item icon: key
B $B9AE,48,8 #HTML[#UDGARRAY2,,,2,,($B9AE-$B9DD-1-16)(sprite-b9ae)]
b $B9DE Mask, 16x24 pixels. Key
B $B9DE,48,8 #HTML[#UDGARRAY2,,,2,,($B9DE-$BA0D-1-16)(sprite-b9de)]
b $BA0E Sprite, 16x24 pixels. Item icon: Horseshoe (weapon; kills Sea Horses)
B $BA0E,48,8 #HTML[#UDGARRAY2,,,2,,($BA0E-$BA3D-1-16)(sprite-ba0e)]
b $BA3E Mask, 16x24 pixels. Horseshoe
B $BA3E,48,8 #HTML[#UDGARRAY2,,,2,,($BA3E-$BA6D-1-16)(sprite-ba3e)]
b $BA6E Sprite, 16x24 pixels. Item icon: Bone (lures fish shoals away)
B $BA6E,48,8 #HTML[#UDGARRAY2,,,2,,($BA6E-$BA9D-1-16)(sprite-ba6e)]
b $BA9E Mask, 16x24 pixels. Bone
B $BA9E,48,8 #HTML[#UDGARRAY2,,,2,,($BA9E-$BACD-1-16)(sprite-ba9e)]
b $BACE Sprite, 16x24 pixels. Boot
B $BACE,48,8 #HTML[#UDGARRAY2,,,2,,($BACE-$BAFD-1-16)(sprite-bace)]
b $BAFE Mask, 16x24 pixels. Boot
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
b $BDAE Sprite, 32x16 pixels. Whirlpool, animation phase
B $BDAE,64,8 #HTML[#UDGARRAY4,,,4,,($BDAE-$BDED-1-32)(sprite-bdae)]
b $BDEE Sprite, 32x16 pixels. Whirlpool, animation phase
B $BDEE,64,8 #HTML[#UDGARRAY4,,,4,,($BDEE-$BE2D-1-32)(sprite-bdee)]
b $BE2E Sprite, 24x32 pixels. Plant/coral
B $BE2E,96,8 #HTML[#UDGARRAY3,,,3,,($BE2E-$BE8D-1-24)(sprite-be2e)]
b $BE8E Mask, 24x32 pixels. Plant/coral
B $BE8E,96,8 #HTML[#UDGARRAY3,,,3,,($BE8E-$BEED-1-24)(sprite-be8e)]
b $BEEE Sprite, 24x32 pixels. Plant/coral
B $BEEE,96,8 #HTML[#UDGARRAY3,,,3,,($BEEE-$BF4D-1-24)(sprite-beee)]
b $BF4E Mask, 24x32 pixels. Plant/coral
B $BF4E,96,8 #HTML[#UDGARRAY3,,,3,,($BF4E-$BFAD-1-24)(sprite-bf4e)]
b $BFAE Sprite, 32x16 pixels. Rock
B $BFAE,64,8 #HTML[#UDGARRAY4,,,4,,($BFAE-$BFED-1-32)(sprite-bfae)]
b $BFEE Mask, 32x16 pixels. Rock
B $BFEE,64,8 #HTML[#UDGARRAY4,,,4,,($BFEE-$C02D-1-32)(sprite-bfee)]
b $C02E Sprite, 32x32 pixels. Open shell
B $C02E,128,8 #HTML[#UDGARRAY4,,,4,,($C02E-$C0AD-1-32)(sprite-c02e)]
b $C0AE Mask, 32x32 pixels. Open shell
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
b $C32E Sprite, 16x16 pixels. Disc/wheel
B $C32E,32,8 #HTML[#UDGARRAY2,,,2,,($C32E-$C34D-1-16)(sprite-c32e)]
b $C34E Sprite, 16x16 pixels. Disc/wheel
B $C34E,32,8 #HTML[#UDGARRAY2,,,2,,($C34E-$C36D-1-16)(sprite-c34e)]
b $C36E Sprite, 16x16 pixels. Disc/wheel
B $C36E,32,8 #HTML[#UDGARRAY2,,,2,,($C36E-$C38D-1-16)(sprite-c36e)]
b $C38E Sprite, 16x8 pixels. Spark/debris
B $C38E,16,8 #HTML[#UDGARRAY2,,,2,,($C38E-$C39D-1-16)(sprite-c38e)]
b $C39E Sprite, 16x8 pixels. Spark/debris
B $C39E,16,8 #HTML[#UDGARRAY2,,,2,,($C39E-$C3AD-1-16)(sprite-c39e)]
b $C3AE Sprite, 32x32 pixels. Urn/well with seaweed
B $C3AE,128,8 #HTML[#UDGARRAY4,,,4,,($C3AE-$C42D-1-32)(sprite-c3ae)]
b $C42E Mask, 32x32 pixels. Urn/well with seaweed
B $C42E,128,8 #HTML[#UDGARRAY4,,,4,,($C42E-$C4AD-1-32)(sprite-c42e)]
b $C4AE Sprite, 32x32 pixels. Urn/well with seaweed
B $C4AE,128,8 #HTML[#UDGARRAY4,,,4,,($C4AE-$C52D-1-32)(sprite-c4ae)]
b $C52E Sprite, 16x24 pixels. Empty/unused frame
B $C52E,48,8 #HTML[#UDGARRAY2,,,2,,($C52E-$C55D-1-16)(sprite-c52e)]
b $C55E Sprite, 16x24 pixels. Oil can (anti-rust oil, refills Sweevo's suit)
B $C55E,48,8 #HTML[#UDGARRAY2,,,2,,($C55E-$C58D-1-16)(sprite-c55e)]
b $C58E Mask, 16x24 pixels. Oil can
B $C58E,48,8 #HTML[#UDGARRAY2,,,2,,($C58E-$C5BD-1-16)(sprite-c58e)]
b $C5BE Sprite, 16x24 pixels. Item icon, unidentified
B $C5BE,48,8 #HTML[#UDGARRAY2,,,2,,($C5BE-$C5ED-1-16)(sprite-c5be)]
b $C5EE Mask, 16x24 pixels. Item icon, unidentified
B $C5EE,48,8 #HTML[#UDGARRAY2,,,2,,($C5EE-$C61D-1-16)(sprite-c5ee)]
b $C61E Sprite, 16x24 pixels. Item icon, unidentified
B $C61E,48,8 #HTML[#UDGARRAY2,,,2,,($C61E-$C64D-1-16)(sprite-c61e)]
b $C64E Mask, 16x24 pixels. Item icon, unidentified
B $C64E,48,8 #HTML[#UDGARRAY2,,,2,,($C64E-$C67D-1-16)(sprite-c64e)]
b $C67E Sprite, 16x24 pixels. Spoon (weapon; kills Jellyfish)
B $C67E,48,8 #HTML[#UDGARRAY2,,,2,,($C67E-$C6AD-1-16)(sprite-c67e)]
b $C6AE Mask, 16x24 pixels. Spoon
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
b $DA76 Mask, 32x32 pixels. Big round fish
B $DA76,128,8 #HTML[#UDGARRAY4,,,4,,($DA76-$DAF5-1-32)(sprite-da76)]
b $DAF6 Mask, 32x32 pixels. Big round fish
B $DAF6,128,8 #HTML[#UDGARRAY4,,,4,,($DAF6-$DB75-1-32)(sprite-daf6)]
b $DB76 Mask, 32x32 pixels. Big round fish
B $DB76,128,8 #HTML[#UDGARRAY4,,,4,,($DB76-$DBF5-1-32)(sprite-db76)]
b $DBF6 Mask, 32x32 pixels. Big round fish
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
b $DCFE Sprite, 32x32 pixels. Cube/crate icon
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




