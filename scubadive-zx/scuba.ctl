@ $5B00 org
b $5B00 Variables
B $5B00,1 ???
W $5B01,2 ???
W $5B03,2 ???
W $5B05,2 Current number in pseudo-random sequence, see routine #R$9D84
W $5B07,2 ???
B $5B09,1 ???
B $5B0A,1 ???
W $5B0B,2 ???
B $5B0D,1 Delay value: 7 / 5 / 3 / 1 depending on Game level 1..4
B $5B0E,1 Delay value: 10 / 8 / 6 / 4 depending on Game level 1..4
B $5B0F,1 ???
B $5B10,1 Game level selected: 1..4
W $5B11,2 ???
B $5B13,1 ???
B $5B14,1 ???
B $5B15,1 ???
B $5B16,1 ???
B $5B17,1 ???
B $5B18,1 ???
B $5B19,1 ???
B $5B1A,1 ???
B $5B1B,1 ???
B $5B1C,1 ???
B $5B1D,1 ???
B $5B1E,1 ???
W $5B1F,2 ???
W $5B21,2 ???
W $5B23,2 ???
W $5B25,2 ???
W $5B35,2 ???
B $5B37,1 Number of lives
W $5B38,2 Port for Clockwise key
B $5B3A,1 Bit mask for Clockwise key
W $5B3B,2 Port for Anticlockwise key
B $5B3D,1 Bit mask for Anticlockwise key
W $5B3E,2 Port for Accelerate key
B $5B40,1 Bit mask for Accelerate key
W $5B41,2 Port for Decelerate key
B $5B43,1 Bit mask for Decelerate key
W $5B44,2 ???
W $5B46,2 ??? $0000 at game start
W $5B48,2 ??? $0000 at game start
B $5B4A,1 Screen attribute, see routine #R$DA39
W $5B4B,2 ???
b $5B4D
t $5CD0
b $5CD5
t $5D34
b $5D39
t $5D41
b $5D4C
t $5D4D
b $5D52
t $5D58
b $5D5C
t $5D71
b $5D7C
b $6023
b $61B0
N $61B0 Small squid vertical sprites; width 1 height 3 chars, 24 bytes each
B $61B2,24,8 #HTML[#UDGARRAY1,,,1,,;$61B2-$61C9-1-8(smsquidv0)]
B $61CA,24,8 #HTML[#UDGARRAY1,,,1,,;$61CA-$61E1-1-8(smsquidv1)]
B $61E2,24,8 #HTML[#UDGARRAY1,,,1,,;$61E2-$61F9-1-8(smsquidv2)]
B $61FA,24,8 #HTML[#UDGARRAY1,,,1,,;$61FA-$6211-1-8(smsquidv3)]
B $6212,1,1
B $6213,24,8 #HTML[#UDGARRAY1,,,1,,;$6213-$622A-1-8(smsquidv4)]
B $622B,24,8 #HTML[#UDGARRAY1,,,1,,;$622B-$6242-1-8(smsquidv5)]
B $6243,24,8 #HTML[#UDGARRAY1,,,1,,;$6243-$625A-1-8(smsquidv6)]
B $625B,24,8 #HTML[#UDGARRAY1,,,1,,;$625B-$6272-1-8(smsquidv7)]
B $6273,24,8 #HTML[#UDGARRAY1,,,1,,;$6273-$628A-1-8(smsquidv8)]
B $628B,24,8 #HTML[#UDGARRAY1,,,1,,;$628B-$62A2-1-8(smsquidv9)]
B $62A3,24,8 #HTML[#UDGARRAY1,,,1,,;$62A3-$62BA-1-8(smsquidvA)]
B $62BB,24,8 #HTML[#UDGARRAY1,,,1,,;$62BB-$62D2-1-8(smsquidvB)]
B $62D3,24,8 #HTML[#UDGARRAY1,,,1,,;$62D3-$62EA-1-8(smsquidvC)]
B $62EB,1,1
B $62EC,24,8 #HTML[#UDGARRAY1,,,1,,;$62EC-$6303-1-8(smsquidvD)]
B $6304,24,8 #HTML[#UDGARRAY1,,,1,,;$6304-$631B-1-8(smsquidvE)]
B $631C,24,8 #HTML[#UDGARRAY1,,,1,,;$631C-$6333-1-8(smsquidvF)]
B $6334,24,8 #HTML[#UDGARRAY1,,,1,,;$6334-$634B-1-8(smsquidvG)]
B $634C,24,8 #HTML[#UDGARRAY1,,,1,,;$634C-$6363-1-8(smsquidvH)]
N $6364 Fish sprites; width 6 height 3 chars, 96 bytes each
B $6364,96,24 #HTML[#UDGARRAY6,,,6,,;$6364-$63C3-1-48(fish0)]
B $63C4,96,24 #HTML[#UDGARRAY6,,,6,,;$63C4-$6423-1-48(fish1)]
B $6424,96,24 #HTML[#UDGARRAY6,,,6,,;$6424-$6483-1-48(fish2)]
B $6484,96,24 #HTML[#UDGARRAY6,,,6,,;$6484-$64E3-1-48(fish3)]
B $64E4,1,1
B $64E5,96,24 #HTML[#UDGARRAY6,,,6,,;$64E5-$6544-1-48(fish4)]
B $6545,96,24 #HTML[#UDGARRAY6,,,6,,;$6545-$65A4-1-48(fish5)]
B $65A5,96,24 #HTML[#UDGARRAY6,,,6,,;$65A5-$6604-1-48(fish6)]
B $6605,96,24 #HTML[#UDGARRAY6,,,6,,;$6605-$6664-1-48(fish7)]
B $6665,1,1
B $6666,96,24 #HTML[#UDGARRAY6,,,6,,;$6666-$66C5-1-48(fish8)]
B $66C6,96,24 #HTML[#UDGARRAY6,,,6,,;$66C6-$6725-1-48(fish9)]
B $6726,96,24 #HTML[#UDGARRAY6,,,6,,;$6726-$6785-1-48(fishA)]
B $6786,96,24 #HTML[#UDGARRAY6,,,6,,;$6786-$67E5-1-48(fishB)]
B $67E6,96,24 #HTML[#UDGARRAY6,,,6,,;$67E6-$6845-1-48(fishC)]
B $6846,96,24 #HTML[#UDGARRAY6,,,6,,;$6846-$68A5-1-48(fishD)]
B $68A6,96,24 #HTML[#UDGARRAY6,,,6,,;$68A6-$6905-1-48(fishE)]
B $6906,96,24 #HTML[#UDGARRAY6,,,6,,;$6906-$6965-1-48(fishF)]
B $6966,96,24 #HTML[#UDGARRAY6,,,6,,;$6966-$69C5-1-48(fishG)]
B $69C6,96,24 #HTML[#UDGARRAY6,,,6,,;$69C6-$6A25-1-48(fishH)]
N $6A26 Shark sprites; width 7 height 3 chars, 168 bytes each
B $6A26,168,21 #HTML[#UDGARRAY7,,,7,,;$6A26-$6ACD-1-56(shark0)]
B $6ACE,168,21 #HTML[#UDGARRAY7,,,7,,;$6ACE-$6B75-1-56(shark1)]
B $6B76,168,21 #HTML[#UDGARRAY7,,,7,,;$6B76-$6C1D-1-56(shark2)]
B $6C1E,168,21 #HTML[#UDGARRAY7,,,7,,;$6C1E-$6CC5-1-56(shark3)]
B $6CC6,1,1
B $6CC7,168,21 #HTML[#UDGARRAY7,,,7,,;$6CC7-$6D6E-1-56(shark4)]
B $6D6F,168,21 #HTML[#UDGARRAY7,,,7,,;$6D6F-$6E16-1-56(shark5)]
B $6E17,168,21 #HTML[#UDGARRAY7,,,7,,;$6E17-$6EBE-1-56(shark6)]
B $6EBF,168,21 #HTML[#UDGARRAY7,,,7,,;$6EBF-$6F66-1-56(shark7)]
B $6F67,168,21 #HTML[#UDGARRAY7,,,7,,;$6F67-$700E-1-56(shark8)]
B $700F,168,21 #HTML[#UDGARRAY7,,,7,,;$700F-$70B6-1-56(shark9)]
B $70B7,168,21 #HTML[#UDGARRAY7,,,7,,;$70B7-$715E-1-56(sharkA)]
B $715F,168,21 #HTML[#UDGARRAY7,,,7,,;$715F-$7206-1-56(sharkB)]
B $7207,168,21 #HTML[#UDGARRAY7,,,7,,;$7207-$72AE-1-56(sharkC)]
B $72AF,168,21 #HTML[#UDGARRAY7,,,7,,;$72AF-$7356-1-56(sharkD)]
B $7357,1,1
B $7358,168,21 #HTML[#UDGARRAY7,,,7,,;$7358-$73FF-1-56(sharkE)]
B $7400,168,21 #HTML[#UDGARRAY7,,,7,,;$7400-$74A7-1-56(sharkF)]
B $74A8,168,21 #HTML[#UDGARRAY7,,,7,,;$74A8-$754F-1-56(sharkG)]
B $7550,168,21 #HTML[#UDGARRAY7,,,7,,;$7550-$75F7-1-56(sharkH)]
B $75F8,168,21 #HTML[#UDGARRAY7,,,7,,;$75F8-$769F-1-56(sharkI)]
B $76A0,168,21 #HTML[#UDGARRAY7,,,7,,;$76A0-$7747-1-56(sharkJ)]
N $7748 Small fish cloud sprites
t $7AB2
b $7AB8
b $7AD8
b $7AEA
b $7B07
b $7B14
b $7B34
b $7B44
b $7B4A
b $7B96
b $7B9C
b $7E05
b $7E65
b $8016
b $801B
b $8036
b $803A
b $8059
b $807B
b $8097
b $809B
b $80B9
b $80DC
b $8106
b $812E
b $814E
b $8154
b $816E
b $8173
b $8190
b $81B3
b $81CF
b $81D4
b $81F4
b $8212
b $8227
b $823D
b $8325
b $8332
b $8351
b $835F
N $83D8 Squid sprites; width 7 height 2 chars; 112 bytes each
B $83D8,112,21 #HTML[#UDGARRAY7,,,7,,;$83D8-$8447-1-56(squid0)]
B $8448,112,21 #HTML[#UDGARRAY7,,,7,,;$8448-$84B7-1-56(squid1)]
B $84B8,112,21 #HTML[#UDGARRAY7,,,7,,;$84B8-$8527-1-56(squid2)]
B $8528,112,21 #HTML[#UDGARRAY7,,,7,,;$8528-$8597-1-56(squid3)]
B $8598,1,1
B $8599,112,21 #HTML[#UDGARRAY7,,,7,,;$8599-$8608-1-56(squid4)]
B $8609,112,21 #HTML[#UDGARRAY7,,,7,,;$8609-$8678-1-56(squid5)]
B $8679,112,21 #HTML[#UDGARRAY7,,,7,,;$8679-$86E8-1-56(squid6)]
B $86E9,112,21 #HTML[#UDGARRAY7,,,7,,;$86E9-$8758-1-56(squid7)]
B $8759,112,21 #HTML[#UDGARRAY7,,,7,,;$8759-$87C8-1-56(squid8)]
B $87C9,112,21 #HTML[#UDGARRAY7,,,7,,;$87C9-$8838-1-56(squid9)]
B $8839,112,21 #HTML[#UDGARRAY7,,,7,,;$8839-$88A8-1-56(squidA)]
B $88A9,112,21 #HTML[#UDGARRAY7,,,7,,;$88A9-$8918-1-56(squidB)]
B $8919,112,21 #HTML[#UDGARRAY7,,,7,,;$8919-$8988-1-56(squidC)]
B $8989,112,21 #HTML[#UDGARRAY7,,,7,,;$8989-$89F8-1-56(squidD)]
B $89F9,1,1
B $89FA,112,21 #HTML[#UDGARRAY7,,,7,,;$89FA-$8A69-1-56(squidE)]
B $8A6A,112,21 #HTML[#UDGARRAY7,,,7,,;$8A6A-$8AD9-1-56(squidF)]
B $8ADA,112,21 #HTML[#UDGARRAY7,,,7,,;$8ADA-$8B49-1-56(squidG)]
B $8B4A,112,21 #HTML[#UDGARRAY7,,,7,,;$8B4A-$8BB9-1-56(squidH)]
B $8BBA,112,21 #HTML[#UDGARRAY7,,,7,,;$8BBA-$8C29-1-56(squidI)]
B $8C2A,112,21 #HTML[#UDGARRAY7,,,7,,;$8C2A-$8C99-1-56(squidJ)]
N $8C9A Boat sprite; width 7 height 3 chars, 168 bytes
B $8C9A,168,21 #HTML[#UDGARRAY7,,,7,,;$8C9A-$8D41-1-56(boat)]
N $8D42 Meduza sprites; width 1
B $8D42,1,1
B $8D43,16,8 #HTML[#UDGARRAY1,,,1,,;$8D43-$8D52-1-8(meduza0)]
B $8D53,16,8 #HTML[#UDGARRAY1,,,1,,;$8D53-$8D62-1-8(meduza1)]
B $8D63,16,8 #HTML[#UDGARRAY1,,,1,,;$8D63-$8D72-1-8(meduza2)]
B $8D73,1,1
N $8D74 Tiles 8x8 pixels
B $8D74,64,8 #HTML[#UDGARRAY1,,,1,,;$8D74-$8DB3-1-8(tiles0)]
B $8DB4,64,8 #HTML[#UDGARRAY1,,,1,,;$8DB4-$8DF3-1-8(tiles1)]
B $8DF4,64,8 #HTML[#UDGARRAY1,,,1,,;$8DF4-$8E33-1-8(tiles2)]
B $8E34

N $9134 Relief blocks 8x8 pixels

N $92CC Scuba diver sprites; width 2 height 2 chars
B $92CC,32,16 #HTML[#UDGARRAY2,,,2,,;$92CC-$92EB-1-16(diver0)]
B $92EC,32,16 #HTML[#UDGARRAY2,,,2,,;$92EC-$930B-1-16(diver1)]
B $930C,32,16 #HTML[#UDGARRAY2,,,2,,;$930C-$932B-1-16(diver2)]
B $932C,32,16 #HTML[#UDGARRAY2,,,2,,;$932C-$934B-1-16(diver3)]
B $934C,32,16 #HTML[#UDGARRAY2,,,2,,;$934C-$936B-1-16(diver4)]
B $936C,32,16 #HTML[#UDGARRAY2,,,2,,;$936C-$938B-1-16(diver5)]
B $938C,32,16 #HTML[#UDGARRAY2,,,2,,;$938C-$93AB-1-16(diver6)]
B $93AC,32,16 #HTML[#UDGARRAY2,,,2,,;$93AC-$93CB-1-16(diver7)]
B $93CC,32,16 #HTML[#UDGARRAY2,,,2,,;$93CC-$93EB-1-16(diver8)]
B $93EC,32,16 #HTML[#UDGARRAY2,,,2,,;$93EC-$940B-1-16(diver9)]
B $940C,32,16 #HTML[#UDGARRAY2,,,2,,;$940C-$942B-1-16(diverA)]
B $942C,32,16 #HTML[#UDGARRAY2,,,2,,;$942C-$944B-1-16(diverB)]
B $944C,32,16 #HTML[#UDGARRAY2,,,2,,;$944C-$946B-1-16(diverC)]
B $946C,32,16 #HTML[#UDGARRAY2,,,2,,;$946C-$948B-1-16(diverD)]
B $948C,32,16 #HTML[#UDGARRAY2,,,2,,;$948C-$94AB-1-16(diverE)]
B $94AC,32,16 #HTML[#UDGARRAY2,,,2,,;$94AC-$94CB-1-16(diverF)]
B $94CC,32,16 #HTML[#UDGARRAY2,,,2,,;$94CC-$94EB-1-16(diverG)]
B $94EC,32,16 #HTML[#UDGARRAY2,,,2,,;$94EC-$950B-1-16(diverH)]
B $950C,32,16 #HTML[#UDGARRAY2,,,2,,;$950C-$952B-1-16(diverI)]
B $952C,32,16 #HTML[#UDGARRAY2,,,2,,;$952C-$954B-1-16(diverJ)]
B $954A

N $9ACC Scuba diver drowned, 4 sprites
B $9ACC,32,16 #HTML[#UDGARRAY2,,,2,,;$9ACC-$9AEB-1-16(drowned0)]
B $9AEC,32,16 #HTML[#UDGARRAY2,,,2,,;$9AEC-$9B0B-1-16(drowned1)]
B $9B0C,32,16 #HTML[#UDGARRAY2,,,2,,;$9B0C-$9B2B-1-16(drowned2)]
B $9B2C,32,16 #HTML[#UDGARRAY2,,,2,,;$9B2C-$9B4B-1-16(drowned3)]

c $9C56
C $9CB7,1 *8
C $9CB8,3 base address for relief blocks 8x8
c $9D40 Calculate address ???
R $9D40 I:HL H = row, L = column 0..31
C $9D4D,2 HL shifted right 3 bits
C $9D50,1 HL := H * 32 + L
C $9D54,1 HL := $AC5D + H * 32 + L
c $9D56 Calculate address and Get ???
R $9D56 I:HL H = row, L = column 0..31
R $9D56 O:A Value
c $9D5F
c $9D79 Calculate address and Set ???
R $9D79 I:HL H = row, L = column 0..31
R $9D79 I:A Value to set
c $9D84 Random
N $9D84 Calculate next number in pseudo-random sequence
C $9D89,1 x2
C $9D8A,1 x4
C $9D8B,1 x8
C $9D8C,1 x16
C $9D8E,1 x32
C $9D91,2 HL = x15
C $9D93,1 BC = x32
C $9D94,1 x47
C $9D95,1 x94
C $9D96,1 x188
C $9D97,1 x376
C $9D98,1 x377
C $9D99,1 x754
C $9D9A,1 x1508
C $9D9B,1 x1509
C $9DA0,3 ($5B05) := ($5B05) * 1509 + 41
b $9DA4
c $9DA5 Fill block at HL with A
R $9DA5 I:HL Block address
R $9DA5 I:A Value
R $9DA5 I:B Length of the block to fill
c $9DAA
C $9DB1,3 Fill block at HL with A
C $9DBB,3 Fill block at HL with A
C $9DC3,3 Fill block at HL with A
C $9DD6,3 Fill block at HL with A
C $9DDF,3 Fill block at HL with A, 256 bytes
C $9DE2,3 Fill block at HL with A, 256 bytes
C $9DE5,3 Fill block at HL with A, 256 bytes
C $9DE8,3 Random
C $9E0F,3 $ACBD = $AC5D + 3 * 32
C $9E2C,3 Random
C $9E3D,3 Random
C $9E6C,3 Game level 1..4
C $9E6F,1 *2
C $9E70,1 *4
C $9E71,2 *4 + 16
C $9E7F,3 Random
C $9E9B,3 Random
C $9F1C,3 Random
c $9F81
C $9F86,3 Random
c $A03B
C $A040,3 Random
c $A0F5 Calculate address ???
c $A129 Calculate address and Get ???
b $A132
c $A14C
c $A164 Convert char coords HL to ZX screen address
R $A164 I:HL Char coords H = 0..23, L = 0..31
R $A164 O:HL Address on the ZX screen
c $A176 Draw tile 16x8 at the screen
C $A176 Convert char coords HL to ZX screen address
R $A176 I:HL Char coords H = 0..23, L = 0..31
R $A176 I:DE Tile address; 16 bytes
c $A187 Draw tile 8x8 at the screen
C $A187,3 Convert char coords HL to ZX screen address
R $A187 I:HL Char coords H = 0..23, L = 0..31
R $A187 I:DE Tile address; 8 bytes
c $A193
C $A227,3 Random
C $A26E,3 get current Random
b $A27E
t $A414
b $A417
b $A4DD ???
b $AC5D ???
b $AD63
b $AD67
b $AD6B
b $B016
c $B0A9
C $B140,3 Draw tile 16x8 at the screen
C $B144,1 One char line upper
C $B145,3 Draw tile 16x8 at the screen
C $B15B,3 Draw tile 16x8 at the screen
C $B167,3 Draw tile 8x8 at the screen
b $B16C
t $B192
b $B195
t $B1AF
b $B1B2
c $B1D4
C $B1E2,3 Random
b $B210
c $B213
C $B21C,3 Random
C $B289,3 Random
C $B2AB,3 Draw tile 8x8 with XOR
C $B2B5,3 Draw tile 16x8 with XOR
C $B2BA,3 Draw tile 16x8 with XOR
c $B2C0
C $B2C5,3 get delay value
B $B2CD,1
c $B2CE Draw tile 8x8 with XOR
R $B2CE I:HL Char coords H = 0..23, L = 0..31
R $B2CE I:DE Tile address
C $B2CE,3 Convert char coords HL to ZX screen address
c $B2DB Draw tile 16x8 with XOR
R $B2DB I:HL Char coords H = 0..23, L = 0..31
R $B2DB I:DE Tile address
C $B2DB,3 Convert char coords HL to ZX screen address
b $B2EE
c $B317
C $B349,3 Base tile address
c $B35D
s $B392
t $B39A
b $B39D
c $B3A0
c $B470
C $B4F6,3 Convert char coords HL to ZX screen address
c $B572
c $B57E
c $B598
c $B5A4
c $B5E0
s $B676
c $B686
c $B70F
c $B737
c $B7B8
s $B7B9
c $B7BB
c $B836
c $B837
c $B885
c $B972
c $BA64
c $BD83
C $BD95,3 Random
b $BDA9
c $BDBA
s $BDE9
c $BDEA
c $BE40
c $BE58
c $BE6D
c $BE85
c $BE9A
c $BEB2
c $BEC7
c $BEDB
C $BF00,3 Random
C $BF15,3 get current Random
C $BF2A,3 Random
b $BFA0
c $BFB0
C $BFBA,3 Random
C $BFDE,3 get current Random
C $BFFA,3 Random
s $C007
c $C009
C $C03C,3 Random
b $C092
c $C431
c $C45C
c $C481
c $C4D5
b $C4E7
b $C4F0
s $C500
c $D990 Game
C $D99E,2 Number of lives
C $D9A0,3 set the initial value
C $D9DB,3 get Number of lives
C $D9C9,4 Diver object record address
C $D9E4,3 set Number of lives
C $D9E7,3 Game level 1..4
C $D9EF,3 Save game level 1..4
C $DA11,3 get Number of lives
C $DA16,2 No more lives? => no lives, jump
C $DA19,3 set Number of lives
C $DA1E,3 get Number of lives
C $DA25,1 One live less
C $DA26,3 set Number of lives
C $DA33,2 Ending the Game routine, the game is over
c $DA39 Clear screen, fill attributes with A
c $DA59
N $DA63 Entry point
C $DA6D,3 Convert char coords HL to ZX screen address
C $DA79,1 *8
C $DA7E,3 ROM font address, for chars $20..$7F
C $DA83,3 Tiles 8x8 address, for chars $80..$AE
c $DA98
C $DAA2,3 !!! mutable argument
c $DAAD
C $DAAF,3 Clear screen with attribute A
C $DAB6,3 Indicator top border
C $DAC2,3 Indicator bottom border
C $DACB,3 "HIGH"
C $DAD4,3 "SCORE"
C $DADD,3 "HELD"
C $DAE6,3 Indicator left/right border
C $DAF2,3 Indicator left/right border
C $DAFB,3 "OXYGEN"
C $DB04,3 "DEPTH"
C $DB0D,3 "SKILL LIVES"
C $DB1B,3 Vertical gauge
C $DB24,3 Vertical gauge
C $DB32,3 "1 2 3 4"
C $DB3B,3 "1 2 3 4"
C $DB53,3 Game level 1..4
C $DB62,3 get Number of lives
C $DB74,4 Diver object record address
C $DB81,3 Game level 1..4
C $DB98,3 Game level 1..4
C $DBAF,3 Game level 1..4
C $DBB9,3 = 10 - [Game level] * 2 + 2 => 10 / 8 / 6 / 4
C $DBBE,3 = 10 - [Game level] * 2 + 2 - 3 => 7 / 5 / 3 / 1
c $DBC2
C $DBC2,3 Game level 1..4
C $DBDF,3 Game level 1..4
C $DBF7,3 Game level 1..4
b $DC09
B $DC09,9,9 Indicator top border
B $DC12,9,9 Indicator bottom border
B $DC1B,5 "HIGH"
B $DC20,7 "000000"
B $DC27,6 "SCORE"
B $DC2D,5 "HELD"
B $DC32,23 Indicator left/right border
B $DC49,7 "OXYGEN"
B $DC50,6 "DEPTH"
B $DC56,15 "SKILL    LIVES"
B $DC65,17 Vertical gauge
B $DC76,8 "1 2 3 4"
b $DC7E
W $DC7E,2 ???
b $DC80 Tiles 8x8
B $DC80,64,8 #HTML[#UDGARRAY1,,,1,,;$DC80-$DCBF-1-8(tiles80)]
B $DCC0,64,8 #HTML[#UDGARRAY1,,,1,,;$DCC0-$DCFF-1-8(tiles81)]
B $DD00,64,8 #HTML[#UDGARRAY1,,,1,,;$DD00-$DD3F-1-8(tiles82)]
B $DD40,64,8 #HTML[#UDGARRAY1,,,1,,;$DD40-$DD7F-1-8(tiles83)]
B $DD80,64,8 #HTML[#UDGARRAY1,,,1,,;$DD80-$DDBF-1-8(tiles84)]
B $DDC0,48,8 #HTML[#UDGARRAY1,,,1,,;$DDC0-$DDEF-1-8(tiles85)]
b $DDF0 Buffer??
B $DDF0,,14
c $DE2E
c $DE3E
b $DE55
c $DE5D
c $DE85
R $DE85 I:B ??? $00 $02
R $DE85 I:HL ???
R $DE85 I:DE ??? $4059 $4099 $40DA
c $DED9
c $DEE5
c $DEF1
b $DEFD
c $DFD5
R $DFD5 I:IX Object address = $E33B
C $E1E4,3 Diver sprites base address
C $E1FA,3 set Row
C $E220,3 set Column
C $E224,3 get Row
C $E227,3 Convert char coords HL to ZX screen address
C $E250,3 one Column right
C $E25C,3 get Row
C $E261,3 get Column
C $E279,3 one Row down
c $E2A8
C $E2A8,4 Diver object record address
C $E2D4,3 Read keyboard input
c $E2DB Read keyboard input
R $E2DB I:IX Object address = $E33B
C $E2E0,3 get Angle
C $E2E7,3 get bit mask for Clockwise key
C $E2F5,3 get bit mask for Anticlockwise key
C $E302,3 set Angle 0..15
C $E309,3 get bit mask for Accelerate key
C $E323,3 get bit mask for Decelerate key
b $E33B Object record
B $E33B,1 (IX+$00) Column 0..31
B $E33C,1 (IX+$01) Row
B $E33F,1 (IX+$04) ??? $00 $FE
B $E340,1 (IX+$05) ??? $00
B $E341,1 (IX+$06) Angle 0..15, initially 4
W $E344,2 (IX+$09) Sprite address
W $E346,2 (IX+$0B) Sprite address
B $E348,1 (IX+$0D) ??? bits 0/1/2/3/4/5/6/7
B $E349,1 (IX+$0E) ???
B $E34A,1 (IX+$0F) ??? $03
B $E34B,1 (IX+$10) ??? bits 0/1/2/3/4/5/6/7
B $E353,1 (IX+$18) Column 0..31
B $E354,1 (IX+$19) Row
B $E35A,1 (IX+$1F) Row??
B $E35B,1 (IX+$20) ??? $03
B $E35C,1 (IX+$21) ???
B $E35D,1 (IX+$22) ??? $F5
W $E35F,2 (IX+$24) ???
B $E361,1 (IX+$26) ??? bits 0/1/2/3/4/5/6
B $E362,1 (IX+$27) ???
B $E363,1 (IX+$28) ???
c $E364
R $E364 I:IX Object address = $E33B
C $E373,3 Game level 1..4
C $E38F,3 Explosion
C $E3CD,3 Explosion
C $E3E5,3 get Angle 0..15
C $E3E9,2 0 / 4 / 8 / 12
C $E3EB,1 0 / 8 / 16 / 24
C $E3EC,1 0 / 16 / 32 / 48
C $E3ED,1 0 / 32 / 64 / 96
C $E3F1,3 Base address for 4 sprites of drowned diver
C $E415,3 Sound
c $E41B
R $E41B I:IX Object record address
C $E41F,3 get Angle
C $E422,2 rotate 180 degree
C $E424,2 0..15
C $E426,3 set Angle
c $E43A Diver explosion ??
R $E43A I:IX Object address = $E33B
C $E44B,3 get Angle 0..15
C $E44F,3 Explosion sprite address
C $E469,3 Sound
c $E476
R $E476 I:IX Object address = $E33B
C $E522,3 Make sound
C $E54D,3 Make sound
C $E598,3 Make sound
c $E5D2
b $E5E0
c $E5EC Sound??
C $E5FB,3 ROM Beeper subroutine
C $E602,2 goto Sound
b $E604
c $E615 Make sound??
C $E618,3 Sound
b $E61C
c $E682
c $E6AB
C $E6AB,4 Diver object record address
C $E6B5,3 get Number of lives
C $E730,3 get Number of lives
c $E767
C $E790,3 get bit mask for Accelerate key
C $E79B,3 Sound
C $E824,3 Game level 1..4
C $E877,3 Game level 1..4
C $E894,3 Sound
C $E8F1,3 Sound
C $E8F7,3 Sound
c $E915
c $E9B0
C $E9C4,3 get Number of lives
s $E9D1
t $E9DA
b $E9E0
t $E9EA
b $E9F0
t $E9FA
b $EA00
t $EA0A
b $EA10
t $EA1A
b $EA20
t $EA2A
b $EA30
t $EA3A
b $EA40
t $EA4A
b $EA50
t $EA5A
b $EA60
t $EA6A
b $EA70
c $EA7A
c $EADE
C $EADE,4 Diver object record address
C $EAF1,3 ROM call CHAN-OPEN
C $EAF6,3 ROM call inside BORDER subroutine
C $EAFB,3 ROM call CHAN-OPEN
C $EAFE,3 ROM CLS subroutine
C $EB03,3 ROM call CHAN-OPEN
C $EB06,3 Table of records text
C $EB0C,3 ROM call PR-STRING
C $EB3C,3 ROM call PR-STRING
C $EB40,4 Diver object record address
C $EB50,3 Convert char coords HL to ZX screen address
C $EB74,3 ROM call PR-STRING
C $EB77,3 "ENTER SKILL (1TO4),K,L OR S."
C $EB7D,3 ROM call PR-STRING
c $EB82
C $EB8C,3 ROM call PR-STRING
C $EBCC,3 ROM call PR-STRING
c $EBDB
C $EBE9,3 ROM OUT-NUM-1 subroutine
t $EBEE
T $EBEE,7
T $EBF5,14
T $EC03,7
T $EC2A,$1F
T $EC4B,3
T $EC59,7
c $EC7C Redefine keys ??
C $EC7E,3 ROM call CHAN-OPEN
C $EC83,3 ROM call inside BORDER subroutine
C $EC88,3 ROM call CHAN-OPEN
C $EC90,3 ROM CLS subroutine
C $EC9B,3 ROM call CHAN-OPEN
C $EC9E,3 ROM call KEYBOARD
C $ECAD,3 ROM call PR-STRING
C $ECB7,3 Save key for Clockwise
C $ECBD,3 ROM call PR-STRING
C $ECC7,3 Save key for Anticlockwise
C $ECCD,3 ROM call PR-STRING
C $ECD7,3 Save key for Accelerate
C $ECDD,3 ROM call PR-STRING
C $ECE7,3 Save key for Decelerate
c $ECEB Sound??
C $ED10,3 ROM BEEPER subroutine
b $ED23
b $ED43
T $ED4A
b $ED60
t $ED63
b $ED79
t $ED7C
b $ED92
t $ED97
b $EDA1
t $EDA5
b $EDB3
t $EDB7
b $EDC4
t $EDC9
b $EDD4
t $EDF3
b $EDF7
c $EE1C
C $EE39,2 'K' ?
C $EE3D,3 Redefine keys
C $EE45,2 'L' ?
C $EE49,3 ROM CLS subroutine
C $EE4E,3 ROM call CHAN-OPEN
C $EE51,3 "LOAD ? (Y/N)"
C $EE57,3 ROM call PR-STRING
C $EE69,2 'N' ?
C $EE6D,2 'Y' ?
C $EE7D,2 -'1'
C $EE86,3 Save game level 1..4
C $EE8C,3 Sound
c $EEAD
C $EEB6,3 Game level 1..4
C $EEBB,3 Clear screen with attribute A
C $EEDD,3 "PRESS ANY KEY"
C $EEE3,3 ROM call PR-STRING
C $EF25,3 ROM call KEYBOARD
b $EF3A
t $EF7F
T $EF86
b $EF93
t $EF9A
s $EFA6
s $F000 Buffer??
