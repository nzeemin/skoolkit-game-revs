b $4000 Screen
D $4000 #UDGTABLE { #SCR(menuscr) } TABLE#
B $4000,6144,32 Pixels
B $5800,768,32 Attributes
@ $5B00 start
@ $5B00 org
t $5CEB
b $5CF0
t $5CFC
b $5D69
t $5D6F
b $5DEA
t $5E1D
b $5E22
t $5E2B
b $5E30
t $5E3F
b $5E43
t $5E62
b $5E68
t $5E6F
b $5E79
b $6400 Sprites and masks
N $6400 Sprite 32x32
N $6480 Sprite 32x32
N $6500 Sprite 32x32
N $6580 Sprite 32x32
N $6600 Mask 32x32
N $6680 Mask 32x32
N $6700 Mask 32x32
N $6780 Mask 32x32
N $6800 Sprite 32x32
N $6880 Sprite 32x32
N $6900 Sprite 32x32
N $6980 Sprite 32x32
N $6A00 Mask 32x32
N $6A80 Mask 32x32
N $6B00 Mask 32x32
N $6B80 Mask 32x32
t $6C01
b $6C0F
t $6C11
b $6C27
t $6C29
b $6C37
t $6C39
b $6C3F
t $6C59
b $6C67
t $6C69
b $6C6F
t $6C71
b $6C7F
t $6C99
b $6C9F
t $6CA1
b $6CA7
t $6CA9
b $6CB7
t $6CB9
b $6CBF
t $6CC4
b $6CD5
t $6CDE
b $6CFF
t $6D09
b $6D17
t $6D19
b $6D1F
t $6D21
b $6D3F
t $6D40
b $6D47
t $6D49
b $6D67
t $6D79
b $6D8D
t $6D99
b $6D9F
t $6DA1
b $6DA7
t $6DB4
b $6DC0
t $6DC4
b $6DCE
t $6DDA
b $6DEC
t $6E03
b $6E0D
t $6E1B
b $6E2B
t $6E39
b $6E3F
t $6E41
b $6E47
t $6E49
b $6E4F
t $6E51
b $6E5F
t $6E61
b $6E67
t $6E69
b $6E6F
t $6E71
b $6E77
t $6E79
b $6E7F
t $6E81
b $6E8F
t $6E91
b $6E97
t $6E99
b $6EA7
t $6EA9
b $6EBF
t $6EC0
b $6ECF
t $6ED1
b $6EEF
t $6EF1
b $6EF7
t $6EF9
b $6F00
t $6F01
b $6F1F
t $6F21
b $6F2F
t $6F31
b $6F3F
t $6F41
b $6F4F
t $6F51
b $6F6F
t $6F71
b $6F77
t $6F79
b $6F7F
t $6F80
b $6F87
t $6F89
b $6F97
t $6F99
b $6FA7
t $6FA9
b $6FC0
t $6FC1
b $6FCF
t $6FD4
b $6FDD
t $6FE1
b $6FE7
t $6FE9
b $6FFF
b $7000 Sprites and masks
N $7000 Sprite 32x32
N $7080 Sprite 32x32
N $7100 Sprite 32x32
N $7180 Sprite 32x32
N $7200 Sprite 32x32
N $7280 Sprite 32x32
N $7300 Sprite 32x32
N $7380 Sprite 32x32
N $7400 Mask 32x32
N $7480 Mask 32x32
N $7500 Mask 32x32
N $7580 Mask 32x32
N $7600 Mask 32x32
N $7680 Mask 32x32
N $7700 Mask 32x32
N $7780 Mask 32x32
c $7800
c $7869
c $789D
c $78E7
b $78F6
c $7A28
c $7A78
b $7AB6
c $7AE5
C $7AE8,3 Copy shadow screen to real screen
C $7AEB,3 Draw Joe sprite
b $7AF2
c $7B1E
b $7B73
c $7B84
b $7BA8
c $7BC4
c $7BE8
c $7C3F
c $7C65
s $7CA0
c $7CA4
c $7CD4
c $7CDA
c $7CE1
c $7CF7
b $7CFF
c $7D00
C $7D0C,3 Address on the screen
C $7D0F,3 Show "JOE BLADE" big sign; HL = screen address
C $7D19,3 Draw string IX
C $7D1F,3 Draw string IX
C $7D25,3 Draw string IX
C $7D2B,3 Draw string IX
C $7D31,3 Draw string IX
C $7D37,3 Draw string IX
C $7D3D,3 Draw string IX
c $7D64
b $7D79
c $7D82
s $7D8B
c $7D8C
s $7D95
c $7D96
c $7DCC
b $7DFB
c $7E32
s $7F44
c $7F64
b $7F67
c $7F6E
b $7F9E
c $7FA0
b $7FCD
c $7FD2
b $7FD8
c $7FDC
b $7FE2
t $7FE3
c $7FE6
b $7FFD
c $8032
b $809E
c $80A0 Draw Joe sprite
N $80CC HL = destination addr
C $80CD,3 Joe sprites base address
N $8101 BC = sprite addr
C $8101,2 DE = BC
C $8103,4 DE = DE + $0400
N $8107 BC = sprite addr, DE = mask addr, HL = destination
C $810A,3 => Draw sprite 32x32 with mask
s $810D
c $8114
b $815A
c $8164
b $8193
t $819D
b $81A1
c $81AA
c $81E6
b $81F8
W $8221,2 current Joe screen address
W $8223,2 current Joe sprite mask address
c $8250
b $8280
c $828C
b $82B7
t $8309
b $830D
t $8347
b $834A
t $834C
b $834F
t $8352
b $8356
t $8359
b $835E
t $8373
b $8378
c $83C0
b $83D9
c $83E1
b $83F3
B $8461,7,7 'SCORES '
t $8502
b $8509
c $850E
s $8544
c $8546
C $8558,3 => Draw string IX
c $855B
s $8567
c $856E
b $8594
c $8596 Draw string IX and play sound
C $8596,3 Draw string IX
C $8599,3 Play sound
b $859C
c $85DC
b $85F7
t $861F
b $8622
t $863F
b $8642
t $865F
b $8662
c $8680
s $86B3
c $86C0
C $86D2,3 Draw string IX
C $86D8,3 Draw string IX
b $86E1
c $86E4
s $86FA
t $8700
b $8733
t $8749
b $875A
t $8775
b $877C
t $877F
b $8783
t $8796
b $8799
t $8901
b $8909
t $8911
b $8919
t $8922
b $8929
t $8932
b $8939
t $8942
b $8949
t $8952
b $8959
c $8964
b $897D
c $8982
b $89AE
c $89B4
c $8A00
c $8A03
c $8A06
c $8A09
c $8A0C
c $8A0F
c $8A12
c $8A3C
c $8A44
c $8A5E
c $8A7A
c $8A94
c $8AAE
c $8AD0
b $8AEC
c $8B02 Show "JOE BLADE" big sign on the screen
C $8B02,3 Address on the screen
N $8B05 Show "JOE BLADE" big sign; HL = screen address
C $8B28,3 Address in screen attributes
b $8B33
c $8B37
b $8B61
c $8B64
s $8BB3
c $8BB4
b $8BEA
c $8C00
s $8C58
c $8C5A
c $8C78 Copy shadow screen to real screen
b $8CDF
c $8CF0
c $8D3C
b $8D64
B $8D64,10,1
c $8D6E Draw sprite 32x32 with mask
N $8D6E BC = sprite addr, DE = mask addr, HL = destination
C $8D71,1 get mask byte
C $8D72,1 apply mask
C $8D74,1 get pixels byte
C $8D75,1 apply pixels
c $8DB4
b $8DB7
c $8DBE
b $8E07
B $8E0D,7,7 ' SCORES'
t $8E2D
b $8E30
t $8E33
b $8E36
t $8E45
b $8E48
c $8E53
c $8E64
b $8E73
t $8E99
b $8E9C
t $8EA9
b $8EAE
c $8EB4
s $8EE7
c $8F00 Game loop ??
C $8F2B,3 Running line of symbols
C $8F37,3 Running line of symbols
C $8F3A,3 Copy shadow screen to real screen
C $8F3E,3 Draw Joe sprite
C $8F4C,2 read keyboard
C $8F4E,2 check for '0' key
b $8F59
c $8F5A
b $8F62
c $8F78
b $8F82
c $8F8C
b $8FB1
c $8FB4
b $8FC1
c $900A
s $9051
c $905A Running line of symbols
C $90A0,1 read character pixels
C $90A2,1 write character pixels
s $90A7
c $90AA
s $90C5
c $90C8
b $90E0
B $90E1,9,9 'HOSTAGES '
B $90EA,1,1 '0' = number of hostages collected
B $90EC,5,5 'KEYS '
B $90F1,1,1 '0' = number of keys collected
B $90F3,6,6 'BOMBS '
B $90F9,1,1 '0' = number of bombs collected
B $90FB,5,5 'SCORE'
t $9101
b $9106
c $9118
s $912B
c $912C
s $9191
c $9196 Draw string IX
C $91B6,1 read character pixels
C $91B7,1 write character pixels
s $91C1
c $91C8
c $91FA
s $922E
c $923C
c $925C
c $926E
c $9296
b $9299
c $92A0
c $92DE
b $92FA
c $9300
c $9328
c $935E
C $9362,4 '  YOU ARE DEAD'
C $9369,3 Draw string IX
b $9377
B $9382,14 '  YOU ARE DEAD'
B $9390,1,1
c $9396
N $9396 DE = mask addr, HL = destination addr
s $939E
c $93A0
b $93C2
c $93DC
s $9442
c $9446
b $944C
c $9456
s $945F
c $9464
b $9493
c $9498
b $9500
c $9580
s $95E1
c $95E6
s $9601
c $9602
s $964C
c $9650
b $96C0
c $96CC
b $96FE
c $9880
s $98D9
c $98DA
b $98E5
b $9900 Sprites and masks for objects
N $9900 Sprite 32x32 bomb
N $9980 Mask 32x32
N $9A00 Sprite 32x32 key
N $9A80 Mask 32x32
N $9B00 Sprite 32x32 food
N $9B80 Mask 32x32
N $9C00 Sprite 32x32 hostage
N $9C80 Mask 32x32
t $9D06
b $9D09
t $9D0B
b $9D0F
t $9D11
b $9D14
t $9D15
b $9D19
t $9D1A
b $9D1E
t $9D1F
b $9D23
t $9D24
b $9D28
t $9D2E
b $9D32
t $9D38
b $9D3B
t $9D3D
b $9D41
t $9D43
b $9D46
t $9D47
b $9D4B
t $9D4C
b $9D50
t $9D51
b $9D55
t $9D56
b $9D5A
t $9D60
b $9D7B
t $9D86
b $9D89
t $9D8B
b $9D8F
t $9D91
b $9D94
t $9D95
b $9D99
t $9D9A
b $9D9E
t $9D9F
b $9DA3
t $9DA4
b $9DA8
t $9DAE
b $9DB2
t $9DB8
b $9DBB
t $9DBD
b $9DC1
t $9DC3
b $9DC6
t $9DC7
b $9DCB
t $9DCC
b $9DD0
t $9DD1
b $9DD5
t $9DD6
b $9DDA
t $9DE0
b $9DFB
b $9E00 Text for running line of symbols
B $9E00,8,8 ' MISSION '
B $9E09,12,12 'BRIEFING....'
B $9E15,3,3 ' 'x3
B $9E18,11,11 'TERRORISTS '
B $9E23,12,12 'LED BY CRAX '
B $9E2F,12,12 'BLOODFINGER '
B $9E3B,5,5 'HAVE '
B $9E40,10,10 'KIDNAPPED '
B $9E4A,10,10 'SIX WORLD '
B $9E54,11,11 'LEADERS....'
B $9E5F,4,4 ' 'x4
B $9E63,8,8 'YOU ARE '
B $9E6B,11,11 'THEIR ONLY '
B $9E76,8,8 'HOPE....'
B $9E7E,4,4 ' 'x4
B $9E82,11,11 'INFILTRATE '
B $9E8D,13,13 'THE RANKS OF '
B $9E9A,13,13 'BLOODFINGERS '
B $9EA7,8,8 'ARMY....'
B $9EAF,4,4 ' 'x4
B $9EB3,9,9 'LIBERATE '
B $9EBC,4,4 'THE '
B $9EC0,9,9 'HOSTAGES,'
B $9EC9,6,6 'PRIME '
B $9ECF,4,4 'THE '
B $9ED3,11,11 'EXPLOSIVES '
B $9EDE,4,4 'AND '
B $9EE2,5,5 'MAKE '
B $9EE7,5,5 'YOUR '
B $9EEC,10,10 'ESCAPE....'
B $9EF6,10,10 ' 'x10
b $9F00
b $A000 "JOE BLADE" sign
b $A200
c $A23C
s $A28B
c $A28C
s $A2BD
c $A2BE
b $A2F1
c $A2F6
b $A325
c $A328
b $A370
t $A390
b $A393
c $A3AA
c $A3BA
b $A3CA
c $A3CB
b $A3CE
b $A400 Sprites and masks for objects
N $A400 Sprite 32x32 uniform
N $A480 Mask 32x32
N $A500 Sprite 32x32 ammo
N $A580 Mask 32x32
b $A600 Font
N $A600 #HTML[#UDGARRAY16;$A600-$A67F-8(font0.png)]
B $A600,8,8 'A' = $00
B $A608,8,8 'B' = $01
B $A610,8,8 'C' = $02
B $A618,8,8 'D' = $03
B $A620,8,8 'E' = $04
B $A628,8,8 'F' = $05
B $A630,8,8 'G' = $06
B $A638,8,8 'H' = $07
B $A640,8,8 'I' = $08
B $A648,8,8 'J' = $09
B $A650,8,8 'K' = $0A
B $A658,8,8 'L' = $0B
B $A670,8,8 'O' = $0E
B $A678,8,8 'P' = $0F
N $A680 #HTML[#UDGARRAY16;$A680-$A6FF-8(font1.png)]
B $A680,8,8 'Q' = $10
B $A688,8,8 'R' = $11
B $A690,8,8 'S' = $12
B $A698,8,8 'T' = $13
B $A6A0,8,8 'U' = $14
B $A6A8,8,8 'V' = $15
B $A6B0,8,8 'W' = $16
B $A6B8,8,8 'X' = $17
B $A6C0,8,8 'Y' = $18
B $A6C8,8,8 'Z' = $19
B $A6D0,8,8 space
B $A6D8,8,8 apostrophe
B $A6E0,8,8 '-'
B $A6E8,8,8 '.'
B $A6F0,8,8 ','
B $A6F8,8,8 space
N $A700 #HTML[#UDGARRAY10;$A700-$A74F-8(font2.png)]
B $A700,8,8 '0' = $20
B $A748,8,8 '9'
c $A750
b $A775
c $A77C
c $A78A
s $A797
c $A798
s $A7DB
c $A7DC
b $A7EC
b $A800 Sprites and masks
N $A800 Sprite 32x32
N $A880 Sprite 32x32
N $A900 Sprite 32x32
N $A980 Sprite 32x32
N $AA00 Sprite 32x32
N $AA80 Sprite 32x32
N $AB00 Sprite 32x32
N $AB80 Sprite 32x32
N $AC00 Mask 32x32
N $AC80 Mask 32x32
N $AD00 Mask 32x32
N $AD80 Mask 32x32
N $AE00 Mask 32x32
N $AE80 Mask 32x32
N $AF00 Mask 32x32
N $AF80 Mask 32x32
N $B000 Sprite 32x32
N $B080 Sprite 32x32
N $B100 Sprite 32x32
N $B180 Sprite 32x32
N $B200 Sprite 32x32
N $B380 Sprite 32x32
N $B400 Mask 32x32
N $B480 Mask 32x32
N $B500 Mask 32x32
N $B580 Mask 32x32
N $B600 Mask 32x32
N $B680 Mask 32x32
N $B700 Mask 32x32
N $B780 Mask 32x32
b $B800 Shadow screen, 64 lines
B $B800,32,32*64
c $C000
c $C38E
b $C390
c $C391
b $C39A
c $C39B
c $C39D
b $C39F
c $C3A0
c $C3AB
c $C3AD
c $C3AF
c $C3B1
b $C3BB
c $C3BD
c $C3BF
t $C3C1
b $C3C8
c $C3CA
c $C3CC
b $C3CE
c $C3CF
b $C3D1
c $C3D2
c $C3DB
b $C3DD
c $C3DE
c $C3E0
b $C3EA
c $C3EB
b $C3ED
c $C3EE
b $C3F0
c $C3F2
b $C3FB
c $C3FC
b $C800 Sprites and masks
N $C800 Sprite 32x32
N $C880 Sprite 32x32
N $C900 Sprite 32x32
N $C980 Sprite 32x32
N $CA00 Sprite 32x32
N $CA80 Sprite 32x32
N $CB00 Sprite 32x32
N $CB80 Sprite 32x32
N $CC00 Mask 32x32
N $CC80 Mask 32x32
N $CD00 Mask 32x32
N $CD80 Mask 32x32
N $CE00 Mask 32x32
N $CE80 Mask 32x32
N $CF00 Mask 32x32
N $CF80 Mask 32x32
N $D000 Sprite 32x32
N $D080 Sprite 32x32
N $D100 Sprite 32x32
N $D180 Sprite 32x32
N $D200 Sprite 32x32
N $D280 Sprite 32x32
N $D300 Sprite 32x32
N $D380 Sprite 32x32
N $D400 Mask 32x32
N $D480 Mask 32x32
N $D500 Mask 32x32
N $D580 Mask 32x32
N $D600 Mask 32x32
N $D680 Mask 32x32
N $D700 Mask 32x32
N $D780 Mask 32x32
N $D800 Sprite 32x32
N $D880 Sprite 32x32
N $D900 Sprite 32x32
N $D980 Sprite 32x32
N $DA00 Sprite 32x32
N $DA80 Sprite 32x32
N $DB00 Sprite 32x32
N $DB80 Sprite 32x32
N $DC00 Mask 32x32
N $DC80 Mask 32x32
N $DD00 Mask 32x32
N $DD80 Mask 32x32
N $DE00 Mask 32x32
N $DE80 Mask 32x32
N $DF00 Mask 32x32
N $DF80 Mask 32x32
b $E000 Background sprites
N $E000 Back 32x32 wall
N $E080 Back 32x32 wall and floor
N $E180 Back 32x32 cabinet lower part
N $E200 Back 32x32 cabinet upper part
N $E280 Back 32x32 window with bars
N $E300 Back 32x32 window with broken bars
N $E380 Back 32x32 wall and boxes
N $E400 Back 32x32 wall and boxes
N $E480 Back 32x32 door upper part
N $E500 Back 32x32 door lower part
N $E580 Back 32x32 toilet upper part
N $E600 Back 32x32 toilet lower part
N $E680 Back 32x32 wall
N $E700 Back 32x32 wall and floor
N $E780 Back 32x32 sink
N $E800 Back 32x32 mirror over sink
N $E880 Back 32x32 wall and window
N $E900 Back 32x32 wall and table
N $E980 Back 32x32 wall and chair
N $EA00 Back 32x32 wall and picture
N $EA80 Back 32x32 window with bars
N $EB00 Back 32x32 brick wall
N $EB80 Back 32x32 wall with hole
N $EC00 Back 32x32 garden fence
N $EC80 Back 32x32 cell door upper part
N $ED00 Back 32x32 cell door lower part
N $ED80 Back 32x32 wall corner
N $EE00 Back 32x32 wall corner
N $EE80 Back 32x32 wall corner
N $EF00 Back 32x32 wall right corner and floor
N $EF80 Back 32x32 wall left cornet and floor
N $F000 Back 32x32 tree
N $F080 Back 32x32 tree
N $F100 Back 32x32 inmate behind bars upper part
N $F180 Back 32x32 inmate behind bars lower part
N $F200 Back 32x32 wall right corner
N $F280 Back 32x32 wall right corner and floor
N $F300 Back 32x32 wall left corner
N $F380 Back 32x32 wall left corner and floor
N $F400 Back 32x32 wall upper part
N $F480 Back 32x32 wall lower part
N $F500 Back 32x32 wall upper part
N $F580 Back 32x32 wall lower part
N $F600 Back 32x32 empty
N $F680 Back 32x32 tree upper part
N $F700 Back 32x32 tree lower part
N $F780 Back 32x32
N $F800 Back 32x32 garden fence lower part
N $F880 Back 32x32 tree
N $F900 Back 32x32 trash bin
N $F980 Back 32x32 skull
N $FA00 Back 32x32 box
N $FA80 Back 32x32 EXIT sign over door
N $FB00 Back 32x32 tree upper part
N $FB80 Back 32x32 tree lower part
N $FC00 Back 32x32 window with broken bars
N $FC80 Back 32x32 garden fence
N $FD00 Back 32x32
c $FDB0
s $FDBD
t $FDC0
b $FDC7
c $FDCE
b $FDDB
t $FE8E
b $FE94
c $FEB4
C $FEC1,3 Show "JOE BLADE" big sign on the screen
s $FF0F
c $FF14
c $FF3E
c $FF96
b $FF99
c $FFA0
c $FFAD
c $FFB5
c $FFD5
b $FFDE
c $FFE8
c $FFF0
b $FFF9
