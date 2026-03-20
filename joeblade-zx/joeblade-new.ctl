b $4000
@ $4000 label=ScreenPixels
@ $5800 label=ScreenAttributes
B $4000,8664,6144,32*24,1
w $61D8
W $61D8,38,2
b $61FE
@ $6400 label=sprite_6400
@ $6480 label=sprite_6480
@ $6500 label=sprite_6500
@ $6580 label=sprite_6580
@ $6600 label=mask_6600
@ $6680 label=mask_6680
@ $6700 label=mask_6700
@ $6780 label=mask_6780
@ $6800 label=sprite_6800
@ $6880 label=sprite_6880
@ $6900 label=sprite_6900
@ $6980 label=sprite_6980
@ $6A00 label=mask_6A00
@ $6A80 label=mask_6A80
@ $6B00 label=mask_6B00
@ $6B80 label=mask_6B80
@ $7000 label=sprite_7000
@ $7080 label=sprite_7080
@ $7100 label=sprite_7100
@ $7180 label=sprite_7180
@ $7200 label=sprite_7200
@ $7280 label=sprite_7280
@ $7300 label=sprite_7300
@ $7380 label=sprite_7380
@ $7400 label=mask_7400
@ $7480 label=mask_7480
@ $7500 label=mask_7500
@ $7580 label=mask_7580
@ $7600 label=mask_7600
@ $7680 label=mask_7680
@ $7700 label=mask_7700
@ $7780 label=mask_7780
B $61FE,5791,1*514,4*512,1*1024,4*512,1
c $789D
b $78A2
B $78A2,579,1
c $7AE5
b $7AF2
B $7AF2,44,1
c $7B1E
b $7B29
B $7B29,25,1
c $7B42
b $7B46
B $7B46,62,1
c $7B84
b $7B89
B $7B89,375,1
c $7D00
b $7D64
B $7D64,50,1
c $7D96
b $7DA3
B $7DA3,2,1
c $7DA5
b $7DAA
B $7DAA,2,1
c $7DAC
b $7DBA
B $7DBA,2,1
c $7DBC
b $7DC1
B $7DC1,2,1
c $7DC3
c $7DCC
b $7DDF
B $7DDF,83,1
c $7E32
b $7E5C
B $7E5C,34,1
c $7E7E
b $7E8F
B $7E8F,27,1
c $7EAA
b $7EB4
B $7EB4,34,1
c $7ED6
b $7EE7
B $7EE7,27,1
c $7F02
b $7F0F
B $7F0F,8,1
c $7F17
b $7F1B
B $7F1B,8,1
c $7F23
b $7F27
B $7F27,8,1
c $7F2F
b $7F44
B $7F44,238,1
c $8032
b $8040
B $8040,11,1
c $804B
b $8055
B $8055,23,1
c $806C
b $808B
B $808B,2,1
c $808D
b $8097
B $8097,2,1
c $8099
b $809E
B $809E,2,1
c $80A0
@ $80CD label=operand_80CD
b $80D7
B $80D7,2,1
c $80D9
b $80E4
B $80E4,4,1
c $80E8
b $80F7
B $80F7,2,1
c $80F9
b $810D
B $810D,7,1
c $8114
b $815A
B $815A,80,1
c $81AA
b $81E6
B $81E6,59,1
w $8221
W $8221,2,2 current Joe screen address
W $8223,2,2 current Joe sprite mask address
b $8225
B $8225,43,1
c $8250
b $8280
B $8280,12,1
c $828C
b $8296
B $8296,13,1
c $82A3
b $82A9
B $82A9,279,1
c $83C0
b $83D9
B $83D9,136,1
B $8461,1,1 'SCORES '
B $8462,172,1
c $850E
b $8513
B $8513,51,1
c $8546
b $855B
B $855B,129,1
c $85DC
B $85DC,1,1
b $85DD
B $85DD,163,1
c $8680
@ $8695 label=operand_8695
@ $86A4 label=operand_86A4
b $86B3
B $86B3,848,1
c $8A03
c $8A06
b $8A09
B $8A09,51,1
c $8A3C
b $8A49
B $8A49,185,1
c $8B02
@ $8B02 label=ShowBigSign4040
c $8B05
@ $8B05 label=ShowBigSign
b $8B33
B $8B33,7,1
c $8B3A
b $8B61
B $8B61,159,1
c $8C00
b $8C58
B $8C58,2,1
c $8C5A
c $8C78
b $8CDF
B $8CDF,17,1
c $8CF0
c $8D3C
b $8D47
B $8D47,25,1
c $8D60
b $8D64
B $8D64,10,1
c $8D6E
C $8D71,1 get mask byte
C $8D72,1 apply mask
C $8D74,1 get pixels byte
C $8D75,1 apply pixels
b $8DB4
B $8DB4,90,1
B $8E0E,1,1 'SCORES'
B $8E0F,68,1
c $8E53
b $8E73
B $8E73,35,1
c $8E96
b $8EB3
B $8EB3,77,1
c $8F00
C $8F4C,2 read keyboard
C $8F4E,2 check for '0' key
b $8F59
B $8F59,1,1
c $8F5A
b $8F62
B $8F62,22,1
c $8F78
b $8F82
B $8F82,10,1
c $8F8C
@ $8F92 label=operand_8F92
b $8FB1
B $8FB1,3,1
c $8FB4
b $8FC1
B $8FC1,153,1
c $905A
C $909B,3 screen address
C $90A0,1 read character pixels
C $90A2,1 write character pixels
b $90A7
B $90A7,3,1
c $90AA
B $90AA,1,1
b $90AB
B $90AB,54,1
B $90E1,1,1 'HOSTAGES '
B $90E2,8,1
B $90EA,1,1 '0'
B $90EB,1,1
B $90EC,1,1 'KEYS '
B $90ED,4,1
B $90F1,1,1 '0'
B $90F2,1,1
B $90F3,1,1 'BOMBS '
B $90F4,5,1
B $90F9,1,1 '0'
B $90FA,1,1
B $90FB,1,1 'SCORE'
B $90FC,48,1
c $912C
b $913A
B $913A,6,1
c $9140
b $9152
B $9152,6,1
c $9158
b $916D
B $916D,6,1
c $9173
b $9185
B $9185,6,1
c $918B
b $9191
B $9191,5,1
c $9196
C $91B6,1 read character pixels
C $91B7,1 write character pixels
b $91C1
B $91C1,173,1,4*21,1
c $926E
b $9279
B $9279,25,1
c $9292
b $9296
B $9296,10,1
c $92A0
b $92AB
B $92AB,25,1
c $92C4
b $92C8
B $92C8,56,1
c $9300
b $930B
B $930B,25,1
c $9324
c $9328
b $9333
B $9333,25,1
c $934C
b $9350
B $9350,70,1
c $9396
b $939E
B $939E,62,1
c $93DC
b $9439
B $9439,4,1
c $943D
b $9442
B $9442,4,1
c $9446
b $944C
B $944C,76,1
c $9498
b $9500
B $9500,230,1
c $95E6
B $95E6,1,1
b $95E7
B $95E7,27,1
c $9602
b $964C
B $964C,4,1
c $9650
b $9657
B $9657,117,1
c $96CC
c $96CE
b $96FE
B $96FE,27,1
c $9719
b $9774
@ $9900 label=sprite_9900_bomb
@ $9980 label=mask_9980
@ $9A00 label=sprite_9A00_key
@ $9A80 label=mask_9A80
@ $9B00 label=sprite_9B00_food
@ $9B80 label=mask_9B80
@ $9C00 label=sprite_9C00
@ $9C80 label=mask_9C80_hostage
@ $A000 label=BigSignJoeBlade
B $9774,2760,1*396,4*256,1*768,32*16,1
c $A23C
b $A28B
B $A28B,1,1
c $A28C
b $A2BD
B $A2BD,1,1
c $A2BE
b $A2F1
B $A2F1,5,1
c $A2F6
b $A304
B $A304,6,1
c $A30A
b $A31B
B $A31B,6,1
c $A321
b $A325
B $A325,3,1
c $A328
b $A333
B $A333,25,1
c $A34C
b $A350
B $A350,106,1
c $A3BA
b $A3CA
B $A3CA,1,1
c $A3CB
b $A3CE
@ $A400 label=sprite_A400_uniform
@ $A480 label=mask_A480
@ $A500 label=sprite_A500_ammo
@ $A580 label=mask_A580
B $A3CE,898,1*50,4*128,1
c $A750
b $A755
B $A755,39,1
c $A77C
B $A77C,1,1
b $A77D
B $A77D,27,1
c $A798
b $A79E
@ $A800 label=sprite_A800
@ $A880 label=sprite_A880
@ $A900 label=sprite_A900
@ $A980 label=sprite_A980
@ $AA00 label=sprite_AA00
@ $AA80 label=sprite_AA80
@ $AB00 label=sprite_AB00
@ $AB80 label=sprite_AB80
@ $AC00 label=mask_AC00
@ $AC80 label=mask_AC80
@ $AD00 label=mask_AD00
@ $AD80 label=mask_AD80
@ $AE00 label=mask_AE00
@ $AE80 label=mask_AE80
@ $AF00 label=mask_AF00
@ $AF80 label=mask_AF80
@ $B000 label=sprite_B000
@ $B080 label=sprite_B080
@ $B100 label=sprite_B100
@ $B180 label=sprite_B180
@ $B200 label=sprite_B200
@ $B280 label=sprite_B280
@ $B300 label=sprite_B300
@ $B380 label=sprite_B380
@ $B400 label=mask_B400
@ $B480 label=mask_B480
@ $B500 label=mask_B500
@ $B580 label=mask_B580
@ $B600 label=mask_B600
@ $B680 label=mask_B680
@ $B700 label=mask_B700
@ $B780 label=mask_B780
@ $C800 label=sprite_C800
@ $C880 label=sprite_C880
@ $C900 label=sprite_C900
@ $C980 label=sprite_C980
@ $CA00 label=sprite_CA00
@ $CA80 label=sprite_CA80
@ $CB00 label=sprite_CB00
@ $CB80 label=sprite_CB80
@ $CC00 label=mask_CC00
@ $CC80 label=mask_CC80
@ $CD00 label=mask_CD00
@ $CD80 label=mask_CD80
@ $CE00 label=mask_CE00
@ $CE80 label=mask_CE80
@ $CF00 label=mask_CF00
@ $CF80 label=mask_CF80
@ $D000 label=sprite_D000
@ $D080 label=sprite_D080
@ $D100 label=sprite_D100
@ $D180 label=sprite_D180
@ $D200 label=sprite_D200
@ $D280 label=sprite_D280
@ $D300 label=sprite_D300
@ $D380 label=sprite_D380
@ $D400 label=mask_D400
@ $D480 label=mask_D480
@ $D500 label=mask_D500
@ $D580 label=mask_D580
@ $D600 label=mask_D600
@ $D680 label=mask_D680
@ $D700 label=mask_D700
@ $D780 label=mask_D780
@ $D800 label=sprite_D800
@ $D880 label=sprite_D880
@ $D900 label=sprite_D900
@ $D980 label=sprite_D980
@ $DA00 label=sprite_DA00
@ $DA80 label=sprite_DA80
@ $DB00 label=sprite_DB00
@ $DB80 label=sprite_DB80
@ $DC00 label=mask_DC00
@ $DC80 label=mask_DC80
@ $DD00 label=mask_DD00
@ $DD80 label=mask_DD80
@ $DE00 label=mask_DE00
@ $DE80 label=mask_DE80
@ $DF00 label=mask_DF00
@ $DF80 label=mask_DF80
@ $E000 label=back_E000
@ $E080 label=back_E080
@ $E100 label=back_E100
@ $E180 label=back_E180
@ $E200 label=back_E200
@ $E280 label=back_E280
@ $E300 label=back_E300
@ $E380 label=back_E380
@ $E400 label=back_E400
@ $E480 label=back_E480
@ $E500 label=back_E500
@ $E580 label=back_E580
@ $E600 label=back_E600
@ $E680 label=back_E680
@ $E700 label=back_E700
@ $E780 label=back_E780
@ $E800 label=back_E800
@ $E880 label=back_E880
@ $E900 label=back_E900
@ $E980 label=back_E980
@ $EA00 label=back_EA00
@ $EA80 label=back_EA80
@ $EB00 label=back_EB00
@ $EB80 label=back_EB80
@ $EC00 label=back_EC00
@ $EC80 label=back_EC80
@ $ED00 label=back_ED00
@ $ED80 label=back_ED80
@ $EE00 label=back_EE00
@ $EE80 label=back_EE80
@ $EF00 label=back_EF00
@ $EF80 label=back_EF80
@ $F000 label=back_F000
@ $F080 label=back_F080
@ $F100 label=back_F100
@ $F180 label=back_F180
@ $F200 label=back_F200
@ $F280 label=back_F280
@ $F300 label=back_F300
@ $F380 label=back_F380
@ $F400 label=back_F400
@ $F480 label=back_F480
@ $F500 label=back_F500
@ $F580 label=back_F580
@ $F600 label=back_F600
@ $F680 label=back_F680
@ $F700 label=back_F700
@ $F780 label=back_F780
@ $F800 label=back_F800
@ $F880 label=back_F880
@ $F900 label=back_F900
@ $F980 label=back_F980
@ $FA00 label=back_FA00
@ $FA80 label=back_FA80
@ $FB00 label=back_FB00
@ $FB80 label=back_FB80
@ $FC00 label=back_FC00
@ $FC80 label=back_FC80
@ $FD00 label=back_FD00
B $A79E,22034,1*98,4*1056,1*3968,4*3424,1
c $FDB0
b $FDBD
B $FDBD,247,1
c $FEB4
b $FF0F
B $FF0F,5,1
c $FF14
b $FF20
B $FF20,30,1
c $FF3E
b $FF43
B $FF43,83,1
c $FF96
b $FF99
B $FF99,20,1
c $FFAD
c $FFB5
b $FFE4
B $FFE4,4,1
c $FFE8
b $FFF9
B $FFF9,7,1
