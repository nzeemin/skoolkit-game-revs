b $4000 Screen
D $4000 #UDGTABLE { #SCR(loading) } TABLE#
B $4000,6144,32 Pixels
B $5800,768,32 Attributes
@ $5B00 org
b $5B00 Variables
B $5B00,1,1 ???
W $5B01,2,2 ???
W $5B03,2,2 Screen position on mini-map (H = row, L = column)
W $5B05,2,2 Current number in pseudo-random sequence, see routine #R$9D84
@ $5B05 label=RANDOM
W $5B07,2,2 ???
B $5B09,1,1 ???
B $5B0A,1,1 ???
W $5B0B,2,2 ???
B $5B0D,1,1 Delay value: 7 / 5 / 3 / 1, depending on Game level 1..4
B $5B0E,1,1 Delay value for Octopus: 10 / 8 / 6 / 4, depending on Game level 1..4
B $5B0F,1,1 ???
B $5B10,1,1 Game level selected: 1..4
@ $5B10 label=LEVEL
W $5B11,2,2 ???
B $5B13,1,1 Value 13 / 17 / 21 / 25, depending on Game level 1..4
B $5B14,1,1 Value 13 / 17 / 21 / 25, depending on Game level 1..4
B $5B15,1,1 Value 27 / 35 / 43 / 51, depending on Game level 1..4
B $5B16,1,1 Value 18 / 22 / 26 / 31, depending on Game level 1..4
B $5B17,1,1 Value 26 / 34 / 42 / 50, depending on Game level 1..4
B $5B18,1,1 Value 5 / 10 / 15 / 20, depending on Game level 1..4
B $5B19,1,1 Value 12 / 27 / 42 / 57, depending on Game level 1..4
B $5B1A,1,1 ???
B $5B1B,1,1 ???
B $5B1C,1,1 ???
B $5B1D,1,1 ???
B $5B1E,1,1 ???
W $5B1F,2,2 ???
W $5B21,2,2 ???
W $5B23,2,2 ???
W $5B25,2,2 Value 150 / 100 / 50 / 1, depending on Game level 1..4
W $5B27,14,8 14 bytes copied from #R$DDF0 + ([Game level] - 1) * 16
W $5B35,2,2 ???
B $5B37,1,1 Number of lives
@ $5B37 label=LIVES
W $5B38,2,2 Port for Clockwise key
B $5B3A,1,1 Bit mask for Clockwise key
W $5B3B,2,2 Port for Anticlockwise key
B $5B3D,1,1 Bit mask for Anticlockwise key
W $5B3E,2,2 Port for Accelerate key
B $5B40,1,1 Bit mask for Accelerate key
W $5B41,2,2 Port for Decelerate key
B $5B43,1,1 Bit mask for Decelerate key
W $5B44,2,2 Score value
@ $5B44 label=SCORE
W $5B46,2,2 ??? $0000 at game start
W $5B48,2,2 ??? $0000 at game start
B $5B4A,1,1 Screen attribute, see routine #R$DA39
W $5B4B,2,2 High score value
@ $5B4B label=HSCORE
b $5B4D
B $5B4D,,16
B $5C05
B $5C08,1,1 LAST-K - Last key pressed
B $5C09,,16
B $5C7B,,16
B $5C8D,,16
b $6000 Sprites
N $6000 Small squid horizontal sprites; width 3 height 1 chars, 24 bytes each
B $6000,24,12 #HTML[#UDGARRAY3,,,3,,;$6000-$6017-1-24(smsquidh0)]
B $6018,24,12 #HTML[#UDGARRAY3,,,3,,;$6018-$602F-1-24(smsquidh1)]
B $6030,24,12 #HTML[#UDGARRAY3,,,3,,;$6030-$6037-1-24(smsquidh2)]
B $6048,24,12 #HTML[#UDGARRAY3,,,3,,;$6048-$605F-1-24(smsquidh3)]
B $6060,1,1
B $6061,24,12 #HTML[#UDGARRAY3,,,3,,;$6061-$6078-1-24(smsquidh4)]
B $6079,24,12 #HTML[#UDGARRAY3,,,3,,;$6079-$6090-1-24(smsquidh5)]
B $6091,24,12 #HTML[#UDGARRAY3,,,3,,;$6091-$60A8-1-24(smsquidh6)]
B $60A9,24,12 #HTML[#UDGARRAY3,,,3,,;$60A9-$60C0-1-24(smsquidh7)]
B $60C1,24,12 #HTML[#UDGARRAY3,,,3,,;$60C1-$60D8-1-24(smsquidh8)]
B $60D9,24,12 #HTML[#UDGARRAY3,,,3,,;$60D9-$60F0-1-24(smsquidh9)]
B $60F1,24,12 #HTML[#UDGARRAY3,,,3,,;$60F1-$6108-1-24(smsquidhA)]
B $6109,24,12 #HTML[#UDGARRAY3,,,3,,;$6109-$6110-1-24(smsquidhB)]
B $6121,24,12 #HTML[#UDGARRAY3,,,3,,;$6121-$6138-1-24(smsquidhC)]
B $6139,1,1
B $613A,24,12 #HTML[#UDGARRAY3,,,3,,;$613A-$6151-1-24(smsquidhD)]
B $6152,24,12 #HTML[#UDGARRAY3,,,3,,;$6152-$6169-1-24(smsquidhE)]
B $616A,24,12 #HTML[#UDGARRAY3,,,3,,;$616A-$6171-1-24(smsquidhF)]
B $6182,24,12 #HTML[#UDGARRAY3,,,3,,;$6182-$6199-1-24(smsquidhG)]
B $619A,24,12 #HTML[#UDGARRAY3,,,3,,;$619A-$61B1-1-24(smsquidhH)]
N $61B2 Small squid vertical sprites; width 1 height 3 chars, 24 bytes each
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
B $7748,,16
N $7BCE Long fish sprites
B $7BCE,32,16 #HTML[#UDGARRAY4,,,4,,;$7BCE-$7BED-1-32(longfish0)]
B $7BEE,32,16 #HTML[#UDGARRAY4,,,4,,;$7BEE-$7C0D-1-32(longfish1)]
B $7C0E,32,16 #HTML[#UDGARRAY4,,,4,,;$7C0E-$7C2D-1-32(longfish2)]
B $7C2E,32,16 #HTML[#UDGARRAY4,,,4,,;$7C2E-$7C4D-1-32(longfish3)]
B $7C4E,1,1
B $7C4F,32,16 #HTML[#UDGARRAY4,,,4,,;$7C4F-$7C6E-1-32(longfish4)]
B $7C6F,32,16 #HTML[#UDGARRAY4,,,4,,;$7C6F-$7C8E-1-32(longfish5)]
B $7C8F,32,16 #HTML[#UDGARRAY4,,,4,,;$7C8F-$7CAE-1-32(longfish6)]
B $7CAF,32,16 #HTML[#UDGARRAY4,,,4,,;$7CAF-$7CCE-1-32(longfish7)]
B $7CCF,1,1
B $7CD0,32,16 #HTML[#UDGARRAY4,,,4,,;$7CD0-$7CEF-1-32(longfish8)]
B $7CF0,32,16 #HTML[#UDGARRAY4,,,4,,;$7CF0-$7D0F-1-32(longfish9)]
B $7D10,32,16 #HTML[#UDGARRAY4,,,4,,;$7D10-$7D2F-1-32(longfishA)]
B $7D30,32,16 #HTML[#UDGARRAY4,,,4,,;$7D30-$7D4F-1-32(longfishB)]
B $7D50,32,16 #HTML[#UDGARRAY4,,,4,,;$7D50-$7D6F-1-32(longfishC)]
B $7D70,32,16 #HTML[#UDGARRAY4,,,4,,;$7D70-$7D8F-1-32(longfishD)]
B $7D90,32,16 #HTML[#UDGARRAY4,,,4,,;$7D90-$7DAF-1-32(longfishE)]
B $7DB0,32,16 #HTML[#UDGARRAY4,,,4,,;$7DB0-$7DCF-1-32(longfishF)]
N $7DD0 Snake fish horizontal sprites
B $7DD0,32,16 #HTML[#UDGARRAY4,,,4,,;$7DD0-$7DEF-1-32(snakef0)]
B $7DF0,32,16 #HTML[#UDGARRAY4,,,4,,;$7DF0-$7E0F-1-32(snakef1)]
B $7E10,32,16 #HTML[#UDGARRAY4,,,4,,;$7E10-$7E2F-1-32(snakef2)]
B $7E30,32,16 #HTML[#UDGARRAY4,,,4,,;$7E30-$7E4F-1-32(snakef3)]
B $7E50,1,1
B $7E51,32,16 #HTML[#UDGARRAY4,,,4,,;$7E51-$7E70-1-32(snakef4)]
B $7E71,32,16 #HTML[#UDGARRAY4,,,4,,;$7E71-$7E90-1-32(snakef5)]
B $7E91,32,16 #HTML[#UDGARRAY4,,,4,,;$7E91-$7EB0-1-32(snakef6)]
B $7EB1,32,16 #HTML[#UDGARRAY4,,,4,,;$7EB1-$7ED0-1-32(snakef7)]
B $7ED1,32,16 #HTML[#UDGARRAY4,,,4,,;$7ED1-$7EF0-1-32(snakef8)]
B $7EF1,32,16 #HTML[#UDGARRAY4,,,4,,;$7EF1-$7F10-1-32(snakef9)]
B $7F11,32,16 #HTML[#UDGARRAY4,,,4,,;$7F11-$7F30-1-32(snakefA)]
B $7F31,32,16 #HTML[#UDGARRAY4,,,4,,;$7F31-$7F50-1-32(snakefB)]
B $7F51,32,16 #HTML[#UDGARRAY4,,,4,,;$7F51-$7F70-1-32(snakefC)]
B $7F71,1,1
B $7F72,32,16 #HTML[#UDGARRAY4,,,4,,;$7F72-$7F91-1-32(snakefD)]
B $7F92,32,16 #HTML[#UDGARRAY4,,,4,,;$7F92-$7FB1-1-32(snakefE)]
B $7FB2,32,16 #HTML[#UDGARRAY4,,,4,,;$7FB2-$7FD1-1-32(snakefF)]
B $7FD2,32,16 #HTML[#UDGARRAY4,,,4,,;$7FD2-$7FF1-1-32(snakefG)]
B $7FF2,32,16 #HTML[#UDGARRAY4,,,4,,;$7FF2-$8011-1-32(snakefH)]
N $8012 Snake fish vertical sprites
B $8012,32,8 #HTML[#UDGARRAY1,,,1,,;$8012-$8031-1-8(snakefv0)]
B $8032,32,8 #HTML[#UDGARRAY1,,,1,,;$8032-$8051-1-8(snakefv1)]
B $8052,32,8 #HTML[#UDGARRAY1,,,1,,;$8052-$8071-1-8(snakefv2)]
B $8072,32,8 #HTML[#UDGARRAY1,,,1,,;$8072-$8091-1-8(snakefv3)]
B $8092,1,1
B $8093,32,8 #HTML[#UDGARRAY1,,,1,,;$8093-$80B2-1-8(snakefv5)]
B $80B3,32,8 #HTML[#UDGARRAY1,,,1,,;$80B3-$80D2-1-8(snakefv6)]
B $80D3,32,8 #HTML[#UDGARRAY1,,,1,,;$80D3-$80F2-1-8(snakefv7)]
B $80F3,32,8 #HTML[#UDGARRAY1,,,1,,;$80F3-$8112-1-8(snakefv8)]
B $8113,32,8 #HTML[#UDGARRAY1,,,1,,;$8113-$8132-1-8(snakefv9)]
B $8133,32,8 #HTML[#UDGARRAY1,,,1,,;$8133-$8152-1-8(snakefvA)]
B $8153,32,8 #HTML[#UDGARRAY1,,,1,,;$8153-$8172-1-8(snakefvB)]
B $8173,32,8 #HTML[#UDGARRAY1,,,1,,;$8173-$8192-1-8(snakefvC)]
B $8193,32,8 #HTML[#UDGARRAY1,,,1,,;$8193-$81B2-1-8(snakefvD)]
B $81B3,1,1
B $81B4,32,8 #HTML[#UDGARRAY1,,,1,,;$81B4-$81D3-1-8(snakefvE)]
B $81D4,32,8 #HTML[#UDGARRAY1,,,1,,;$81D4-$81F3-1-8(snakefvF)]
B $81F4,32,8 #HTML[#UDGARRAY1,,,1,,;$81F4-$8213-1-8(snakefvG)]
B $8214,32,8 #HTML[#UDGARRAY1,,,1,,;$8214-$8233-1-8(snakefvH)]
B $8234,32,8 #HTML[#UDGARRAY1,,,1,,;$8234-$8253-1-8(snakefvI)]
N $8254 Round fish sprites
B $8254,16,8 #HTML[#UDGARRAY2,,,2,,;$8254-$8263-1-16(roundf0)]
B $8264,16,8 #HTML[#UDGARRAY2,,,2,,;$8264-$8273-1-16(roundf1)]
B $8274,16,8 #HTML[#UDGARRAY2,,,2,,;$8274-$8283-1-16(roundf2)]
B $8284,1,1
B $8285,16,8 #HTML[#UDGARRAY2,,,2,,;$8285-$8294-1-16(roundf3)]
B $8295,16,8 #HTML[#UDGARRAY2,,,2,,;$8295-$82A4-1-16(roundf4)]
B $82A5,16,8 #HTML[#UDGARRAY2,,,2,,;$82A5-$82B4-1-16(roundf5)]
B $82B5,1,1
B $82B6,16,8 #HTML[#UDGARRAY2,,,2,,;$82B6-$82C5-1-16(roundf6)]
B $82C6,16,8 #HTML[#UDGARRAY2,,,2,,;$82C6-$82D5-1-16(roundf7)]
B $82D6,16,8 #HTML[#UDGARRAY2,,,2,,;$82D6-$82E5-1-16(roundf8)]
B $82E6,16,8 #HTML[#UDGARRAY2,,,2,,;$82E6-$82F5-1-16(roundf9)]
B $82F6,16,8 #HTML[#UDGARRAY2,,,2,,;$82F6-$8305-1-16(roundfA)]
B $8306,16,8 #HTML[#UDGARRAY2,,,2,,;$8306-$8315-1-16(roundfB)]
N $8316 Round fish vertical sprites
B $8316,16,8 #HTML[#UDGARRAY1,,,1,,;$8316-$8325-1-8(roundv0)]
B $8326,16,8 #HTML[#UDGARRAY1,,,1,,;$8326-$8335-1-8(roundv1)]
B $8336,16,8 #HTML[#UDGARRAY1,,,1,,;$8336-$8345-1-8(roundv2)]
B $8346,1,1
B $8347,16,8 #HTML[#UDGARRAY1,,,1,,;$8347-$8356-1-8(roundv3)]
B $8357,16,8 #HTML[#UDGARRAY1,,,1,,;$8357-$8366-1-8(roundv4)]
B $8367,16,8 #HTML[#UDGARRAY1,,,1,,;$8367-$8376-1-8(roundv5)]
B $8377,1,1
B $8378,16,8 #HTML[#UDGARRAY1,,,1,,;$8378-$8387-1-8(roundv6)]
B $8388,16,8 #HTML[#UDGARRAY1,,,1,,;$8388-$8397-1-8(roundv7)]
B $8398,16,8 #HTML[#UDGARRAY1,,,1,,;$8398-$83A7-1-8(roundv8)]
B $83A8,16,8 #HTML[#UDGARRAY1,,,1,,;$83A8-$83B7-1-8(roundv9)]
B $83B8,16,8 #HTML[#UDGARRAY1,,,1,,;$83B8-$83C7-1-8(roundvA)]
B $83C8,16,8 #HTML[#UDGARRAY1,,,1,,;$83C8-$83D7-1-8(roundvB)]
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
N $8D74 Octopus phases 0..4, each phase 4*6*8 = 192 bytes
B $8D74,192,16 #HTML[#UDGARRAY6,,,1,,;$8D74-$8E33-8(octopus0)] 0
B $8E34,192,16 #HTML[#UDGARRAY6,,,1,,;$8E34-$8EF3-8(octopus1)] 1
B $8EF4,192,16 #HTML[#UDGARRAY6,,,1,,;$8EF4-$8FB3-8(octopus2)] 2
B $8FB4,192,16 #HTML[#UDGARRAY6,,,1,,;$8FB4-$9073-8(octopus3)] 3
B $9074,192,16 #HTML[#UDGARRAY6,,,1,,;$9074-$9133-8(octopus4)] 4
N $9134 Relief tiles 8x8 pixels
B $9134,8,8 #HTML[#UDGARRAY1,,,1,,;$9134-$913B-1-8(tile00)] $00
B $913C,8,8 #HTML[#UDGARRAY1,,,1,,;$913C-$9143-1-8(tile01)] $01
B $9144,8,8 #HTML[#UDGARRAY1,,,1,,;$9144-$914B-1-8(tile02)] $02
B $914C,8,8 #HTML[#UDGARRAY1,,,1,,;$914C-$9153-1-8(tile03)] $03
B $9154,8,8 #HTML[#UDGARRAY1,,,1,,;$9154-$915B-1-8(tile04)] $04
B $915C,8,8 #HTML[#UDGARRAY1,,,1,,;$915C-$9163-1-8(tile05)] $05
B $9164,8,8 #HTML[#UDGARRAY1,,,1,,;$9164-$916B-1-8(tile06)] $06
B $916C,8,8 #HTML[#UDGARRAY1,,,1,,;$916C-$9173-1-8(tile07)] $07
B $9174,8,8 #HTML[#UDGARRAY1,,,1,,;$9174-$917B-1-8(tile08)] $08
B $917C,8,8 #HTML[#UDGARRAY1,,,1,,;$917C-$9183-1-8(tile09)] $09
B $9184,8,8 #HTML[#UDGARRAY1,,,1,,;$9184-$918B-1-8(tile0A)] $0A
B $918C,8,8 #HTML[#UDGARRAY1,,,1,,;$918C-$9193-1-8(tile0B)] $0B
B $9194,8,8 #HTML[#UDGARRAY1,,,1,,;$9194-$919B-1-8(tile0C)] $0C
B $919C,8,8 #HTML[#UDGARRAY1,,,1,,;$919C-$91A3-1-8(tile0D)] $0D
B $91A4,8,8 #HTML[#UDGARRAY1,,,1,,;$91A4-$91AB-1-8(tile0E)] $0E
B $91AC,8,8 #HTML[#UDGARRAY1,,,1,,;$91AC-$91B3-1-8(tile0F)] $0F
B $91B4,8,8 #HTML[#UDGARRAY1,,,1,,;$91B4-$91BB-1-8(tile10)] $10
B $91BC,8,8 #HTML[#UDGARRAY1,,,1,,;$91BC-$91C3-1-8(tile11)] $11
B $91C4,8,8 #HTML[#UDGARRAY1,,,1,,;$91C4-$91CB-1-8(tile12)] $12
B $91CC,8,8 #HTML[#UDGARRAY1,,,1,,;$91CC-$91D3-1-8(tile13)] $13
B $91D4,8,8 #HTML[#UDGARRAY1,,,1,,;$91D4-$91DB-1-8(tile14)] $14
B $91DC,8,8 #HTML[#UDGARRAY1,,,1,,;$91DC-$91E3-1-8(tile15)] $15
B $91E4,8,8 #HTML[#UDGARRAY1,,,1,,;$91E4-$91EB-1-8(tile16)] $16
B $91EC,8,8 #HTML[#UDGARRAY1,,,1,,;$91EC-$91F3-1-8(tile17)] $17
B $91F4,8,8 #HTML[#UDGARRAY1,,,1,,;$91F4-$91FB-1-8(tile18)] $18
B $91FC,8,8 #HTML[#UDGARRAY1,,,1,,;$91FC-$9203-1-8(tile19)] $19
B $9204,8,8 #HTML[#UDGARRAY1,,,1,,;$9204-$920B-1-8(tile1A)] $1A
B $920C,8,8 #HTML[#UDGARRAY1,,,1,,;$920C-$9213-1-8(tile1B)] $1B
B $9214,8,8 #HTML[#UDGARRAY1,,,1,,;$9214-$921B-1-8(tile1C)] $1C
B $921C,8,8 #HTML[#UDGARRAY1,,,1,,;$921C-$9223-1-8(tile1D)] $1D
B $9224,8,8 #HTML[#UDGARRAY1,,,1,,;$9224-$922B-1-8(tile1E)] $1E
B $922C,8,8 #HTML[#UDGARRAY1,,,1,,;$922C-$9233-1-8(tile1F)] $1F
B $9234,8,8 #HTML[#UDGARRAY1,,,1,,;$9234-$923B-1-8(tile20)] $20
B $923C,8,8 #HTML[#UDGARRAY1,,,1,,;$923C-$9243-1-8(tile21)] $21
B $9244,8,8 #HTML[#UDGARRAY1,,,1,,;$9244-$924B-1-8(tile22)] $22
B $924C,8,8 #HTML[#UDGARRAY1,,,1,,;$924C-$9253-1-8(tile23)] $23
B $9254,8,8 #HTML[#UDGARRAY1,,,1,,;$9254-$925B-1-8(tile24)] $24
B $925C,8,8 #HTML[#UDGARRAY1,,,1,,;$925C-$9263-1-8(tile25)] $25
B $9264,8,8 #HTML[#UDGARRAY1,,,1,,;$9264-$926B-1-8(tile26)] $26
B $926C,8,8 #HTML[#UDGARRAY1,,,1,,;$926C-$9273-1-8(tile27)] $27
B $9274,8,8 #HTML[#UDGARRAY1,,,1,,;$9274-$927B-1-8(tile28)] $28
B $927C,8,8 #HTML[#UDGARRAY1,,,1,,;$927C-$9283-1-8(tile29)] $29
B $9284,8,8 #HTML[#UDGARRAY1,,,1,,;$9284-$928B-1-8(tile2A)] $2A
B $928C,8,8 #HTML[#UDGARRAY1,,,1,,;$928C-$9293-1-8(tile2B)] $2B
B $9294,8,8 #HTML[#UDGARRAY1,,,1,,;$9294-$929B-1-8(tile2C)] $2C
B $929C,8,8 #HTML[#UDGARRAY1,,,1,,;$929C-$92A3-1-8(tile2D)] $2D
B $92A4,8,8 #HTML[#UDGARRAY1,,,1,,;$92A4-$92AB-1-8(tile2E)] $2E
B $92AC,8,8 #HTML[#UDGARRAY1,,,1,,;$92AC-$92B3-1-8(tile2F)] $2F
B $92B4,8,8 #HTML[#UDGARRAY1,,,1,,;$92B4-$92BB-1-8(tile30)] $30
B $92BC,8,8 #HTML[#UDGARRAY1,,,1,,;$92BC-$92C3-1-8(tile31)] $31

N $92CC Scuba diver sprites; width 2 height 2 chars
B $92CC,32,16 #HTML[#UDGARRAY2,,,2,,;$92CC-$92EB-1-16(diver0a)]
B $92EC,32,16 #HTML[#UDGARRAY2,,,2,,;$92EC-$930B-1-16(diver0b)]
B $930C,32,16 #HTML[#UDGARRAY2,,,2,,;$930C-$932B-1-16(diver0c)]
B $932C,32,16 #HTML[#UDGARRAY2,,,2,,;$932C-$934B-1-16(diver0d)]
B $934C,32,16 #HTML[#UDGARRAY2,,,2,,;$934C-$936B-1-16(diver1a)]
B $936C,32,16 #HTML[#UDGARRAY2,,,2,,;$936C-$938B-1-16(diver1b)]
B $938C,32,16 #HTML[#UDGARRAY2,,,2,,;$938C-$93AB-1-16(diver1c)]
B $93AC,32,16 #HTML[#UDGARRAY2,,,2,,;$93AC-$93CB-1-16(diver1d)]
B $93CC,32,16 #HTML[#UDGARRAY2,,,2,,;$93CC-$93EB-1-16(diver2a)]
B $93EC,32,16 #HTML[#UDGARRAY2,,,2,,;$93EC-$940B-1-16(diver2b)]
B $940C,32,16 #HTML[#UDGARRAY2,,,2,,;$940C-$942B-1-16(diver2c)]
B $942C,32,16 #HTML[#UDGARRAY2,,,2,,;$942C-$944B-1-16(diver2d)]
B $944C,32,16 #HTML[#UDGARRAY2,,,2,,;$944C-$946B-1-16(diver3a)]
B $946C,32,16 #HTML[#UDGARRAY2,,,2,,;$946C-$948B-1-16(diver3b)]
B $948C,32,16 #HTML[#UDGARRAY2,,,2,,;$948C-$94AB-1-16(diver3c)]
B $94AC,32,16 #HTML[#UDGARRAY2,,,2,,;$94AC-$94CB-1-16(diver3d)]
B $94CC,32,16 #HTML[#UDGARRAY2,,,2,,;$94CC-$94EB-1-16(diver4a)]
B $94EC,32,16 #HTML[#UDGARRAY2,,,2,,;$94EC-$950B-1-16(diver4b)]
B $950C,32,16 #HTML[#UDGARRAY2,,,2,,;$950C-$952B-1-16(diver4c)]
B $952C,32,16 #HTML[#UDGARRAY2,,,2,,;$952C-$954B-1-16(diver4d)]
B $954C,32,16 #HTML[#UDGARRAY2,,,2,,;$954C-$956B-1-16(diver5a)]
B $956C,32,16 #HTML[#UDGARRAY2,,,2,,;$956C-$958B-1-16(diver5b)]
B $958C,32,16 #HTML[#UDGARRAY2,,,2,,;$958C-$95AB-1-16(diver5c)]
B $95AC,32,16 #HTML[#UDGARRAY2,,,2,,;$95AC-$95CB-1-16(diver5d)]
B $95CC,32,16 #HTML[#UDGARRAY2,,,2,,;$95CC-$95EB-1-16(diver6a)]
B $95EC,32,16 #HTML[#UDGARRAY2,,,2,,;$95EC-$960B-1-16(diver6b)]
B $960C,32,16 #HTML[#UDGARRAY2,,,2,,;$960C-$962B-1-16(diver6c)]
B $962C,32,16 #HTML[#UDGARRAY2,,,2,,;$962C-$964B-1-16(diver6d)]
B $964C,32,16 #HTML[#UDGARRAY2,,,2,,;$964C-$966B-1-16(diver7a)]
B $966C,32,16 #HTML[#UDGARRAY2,,,2,,;$966C-$968B-1-16(diver7b)]
B $968C,32,16 #HTML[#UDGARRAY2,,,2,,;$968C-$96AB-1-16(diver7c)]
B $96AC,32,16 #HTML[#UDGARRAY2,,,2,,;$96AC-$96CB-1-16(diver7d)]
B $96CC,32,16 #HTML[#UDGARRAY2,,,2,,;$96CC-$96EB-1-16(diver8a)]
B $96EC,32,16 #HTML[#UDGARRAY2,,,2,,;$96EC-$970B-1-16(diver8b)]
B $970C,32,16 #HTML[#UDGARRAY2,,,2,,;$970C-$972B-1-16(diver8c)]
B $972C,32,16 #HTML[#UDGARRAY2,,,2,,;$972C-$974B-1-16(diver8d)]
B $974C,32,16 #HTML[#UDGARRAY2,,,2,,;$974C-$976B-1-16(diver9a)]
B $976C,32,16 #HTML[#UDGARRAY2,,,2,,;$976C-$978B-1-16(diver9b)]
B $978C,32,16 #HTML[#UDGARRAY2,,,2,,;$978C-$97AB-1-16(diver9c)]
B $97AC,32,16 #HTML[#UDGARRAY2,,,2,,;$97AC-$97CB-1-16(diver9d)]
B $97CC,32,16 #HTML[#UDGARRAY2,,,2,,;$97CC-$97EB-1-16(diverAa)]
B $97EC,32,16 #HTML[#UDGARRAY2,,,2,,;$97EC-$980B-1-16(diverAb)]
B $980C,32,16 #HTML[#UDGARRAY2,,,2,,;$980C-$982B-1-16(diverAc)]
B $982C,32,16 #HTML[#UDGARRAY2,,,2,,;$982C-$984B-1-16(diverAd)]
B $984C,32,16 #HTML[#UDGARRAY2,,,2,,;$984C-$986B-1-16(diverBa)]
B $986C,32,16 #HTML[#UDGARRAY2,,,2,,;$986C-$988B-1-16(diverBb)]
B $988C,32,16 #HTML[#UDGARRAY2,,,2,,;$988C-$98AB-1-16(diverBc)]
B $98AC,32,16 #HTML[#UDGARRAY2,,,2,,;$98AC-$98CB-1-16(diverBd)]
B $98CC,32,16 #HTML[#UDGARRAY2,,,2,,;$98CC-$98EB-1-16(diverCa)]
B $98EC,32,16 #HTML[#UDGARRAY2,,,2,,;$98EC-$990B-1-16(diverCb)]
B $990C,32,16 #HTML[#UDGARRAY2,,,2,,;$990C-$992B-1-16(diverCc)]
B $992C,32,16 #HTML[#UDGARRAY2,,,2,,;$992C-$994B-1-16(diverCd)]
B $994C,32,16 #HTML[#UDGARRAY2,,,2,,;$994C-$996B-1-16(diverDa)]
B $996C,32,16 #HTML[#UDGARRAY2,,,2,,;$996C-$998B-1-16(diverDb)]
B $998C,32,16 #HTML[#UDGARRAY2,,,2,,;$998C-$99AB-1-16(diverDc)]
B $99AC,32,16 #HTML[#UDGARRAY2,,,2,,;$99AC-$99CB-1-16(diverDd)]
B $99CC,32,16 #HTML[#UDGARRAY2,,,2,,;$99CC-$99EB-1-16(diverEa)]
B $99EC,32,16 #HTML[#UDGARRAY2,,,2,,;$99EC-$9A0B-1-16(diverEb)]
B $9A0C,32,16 #HTML[#UDGARRAY2,,,2,,;$9A0C-$9A2B-1-16(diverEc)]
B $9A2C,32,16 #HTML[#UDGARRAY2,,,2,,;$9A2C-$9A4B-1-16(diverEd)]
B $9A4C,32,16 #HTML[#UDGARRAY2,,,2,,;$9A4C-$9A6B-1-16(diverFa)]
B $9A6C,32,16 #HTML[#UDGARRAY2,,,2,,;$9A6C-$9A8B-1-16(diverFb)]
B $9A8C,32,16 #HTML[#UDGARRAY2,,,2,,;$9A8C-$9AAB-1-16(diverFc)]
B $9AAC,32,16 #HTML[#UDGARRAY2,,,2,,;$9AAC-$9ACB-1-16(diverFd)]
N $9ACC Scuba diver drowned, 4 sprites
B $9ACC,32,16 #HTML[#UDGARRAY2,,,2,,;$9ACC-$9AEB-1-16(drowned0)]
B $9AEC,32,16 #HTML[#UDGARRAY2,,,2,,;$9AEC-$9B0B-1-16(drowned1)]
B $9B0C,32,16 #HTML[#UDGARRAY2,,,2,,;$9B0C-$9B2B-1-16(drowned2)]
B $9B2C,32,16 #HTML[#UDGARRAY2,,,2,,;$9B2C-$9B4B-1-16(drowned3)]
N $9B4C Explosion sprites
B $9B4C,32,16 #HTML[#UDGARRAY2,,,2,,;$9B4C-$9B6B-1-16(explosion0)]
B $9B6C,32,16 #HTML[#UDGARRAY2,,,2,,;$9B6C-$9B8B-1-16(explosion1)]
N $9B8C Scuba diver various sprites
B $9B8C,32,16 #HTML[#UDGARRAY2,,,2,,;$9B8C-$9BAB-1-16(divervar0)]
B $9BAC,32,16 #HTML[#UDGARRAY2,,,2,,;$9BAC-$9BCB-1-16(divervar1)]
B $9BCC,32,16 #HTML[#UDGARRAY2,,,2,,;$9BCC-$9BEB-1-16(divervar2)]
B $9BEC,32,16 #HTML[#UDGARRAY2,,,2,,;$9BEC-$9C0B-1-16(divervar3)]
B $9C0C,32,16 #HTML[#UDGARRAY2,,,2,,;$9C0C-$9C2B-1-16(divervar4)]
B $9C2C,32,16 #HTML[#UDGARRAY2,,,2,,;$9C2C-$9C4B-1-16(divervar5)]
B $9C4C
b $9C50
B $9C50,1,1 $00 = no Octopus, $01 = we have Octopus on the game screen
W $9C51,2,2 Octopus row/column
W $9C53,2,2 ???
B $9C55,1,1 Octopus phase
c $9C56 Draw game screen
@ $9C56 label=DrawGameScr
R $9C56 HL Screen position on mini-map
C $9C66,2 Game screen 3 blocks high = 24 tiles
C $9C6A,2 Game screen 3 blocks wide = 24 tiles
C $9C70,3 Calc address in #R$AC5D and Get block number
C $9C75,2 place for Octopus?
C $9C79,3 save the Octopus row/column
C $9C9D,3 base address for relief blocks, 8x8 tiles each block
C $9CA5,2 height for block of tiles = 8
C $9CAB,3 get tile number
C $9CB7,1 *8
C $9CB8,3 base address for relief tiles, 8x8 pixels each tile
C $9D35,3 Draw Octopus
c $9D40 Calculate address in the mini-map (#R$AC5D table)
R $9D40 I:HL H = row, L = column 0..31
C $9D4D,2 HL shifted right 3 bits
C $9D50,1 HL := H * 32 + L
C $9D54,1 HL := $AC5D + H * 32 + L
c $9D56 Calculate address in the mini-map (#R$AC5D table) and Get
R $9D56 I:HL H = row, L = column 0..31
R $9D56 O:A Value
C $9D58,3 Calculate address in #R$AC5D table
c $9D5F Check value in the mini-map (#R$AC5D table), if row and column in range 0..31
R $9D5F I:HL H = row, L = column
N $9D5F If column or row is out of range 0..31 - returns flag Z=0;
. else, gets value from #R$AC5D table; if this value is $01, returns flag Z=1, in other case flag Z=0
C $9D62,2 Column value out of range 0..31 ?
C $9D67,2 Row value out of range 0..31 ?
C $9D6B,3 Calc address in #R$AC5D and Get
c $9D79 Calculate address in the mini-map (#R$AC5D table) and Set
R $9D79 I:HL H = row, L = column 0..31
R $9D79 I:A Value to set
C $9D7C,3 Calculate address in the mini-map (#R$AC5D table)
c $9D84 Random
@ $9D84 label=NextRandom
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
B $9DA4,1,1
c $9DA5 Fill block at HL with A
@ $9DA5 label=FillBlock
R $9DA5 I:HL Block address
R $9DA5 I:A Value
R $9DA5 I:B Length of the block to fill
c $9DAA Prepare the mini-map (#R$AC5D table)
@ $9DAA label=PrepareMiniMap
C $9DAA,3 $ACBF = $AC5D + 3 * 32 + 2: row 3 column 2
C $9DB1,3 Fill block at $ACBF with $16
C $9DB4,2 ($ACDB) <- $06
C $9DB6,1 HL = $ACDC
C $9DBB,3 Fill block at $ACDC with $01
C $9DBE,1 HL = $ACFF
C $9DC3,3 Fill block at $ACFF with $1A
C $9DCD,2 ($AD3C) <- $06
C $9DD1,1 HL = $AD3F
C $9DD6,3 Fill block at $AD3F with $16
C $9DDA,1 HL = $AD5D; $AD5D = $AC5D + $100: row 8 column 0
C $9DDF,3 Fill block at $AD5D with $01, 256 bytes: fill rows 8..15
C $9DE2,3 Fill block at $AE5D with $01, 256 bytes: fill rows 16..23
C $9DE5,3 Fill block at $AF5D with $01, 256 bytes: fill rows 24..31
C $9DE8,3 Random
C $9DEE,2 A = (Random:H) & 15 + 7 => 7..22
C $9DF0,1 column
C $9DF1,2 row = 3
C $9DF4,3 Calc address in #R$AC5D and Set value = 0
C $9DF7,1 next column; column = 4
C $9DF8,3 Calc address in #R$AC5D and Set value = 0
C $9DFB,2 row = 5
C $9DFD,3 Calc address in #R$AC5D and set value = 0
C $9E00,1 previous column; column = 3
C $9E01,3 Calc address in #R$AC5D and Set value = 0
C $9E04,1 previous row; row = 4
C $9E05,2 $1C = place for Octopus, left block
C $9E07,3 Calc address in #R$AC5D and Set value = $1C
C $9E0A,1 = $1D = place for Octopus, right block
C $9E0B,1 next column; column = 4
C $9E0C,3 Calc address in #R$AC5D and Set value = $1D
C $9E0F,3 $ACBD = $AC5D + 3 * 32: row 3 column 0
C $9E2C,3 Random
C $9E3D,3 Random
C $9E49,3 Calc address in #R$AC5D and Set value = 0
C $9E4D,3 Calc address in #R$AC5D and Set value = 0
C $9E51,2 $1D = place for Octopus, right block
C $9E53,3 Calc address in #R$AC5D and Set value = $1D
C $9E56,1 = $1C = place for Octopus, left block
C $9E58,3 Calc address in #R$AC5D and Set value = $1C
C $9E6C,3 Game level 1..4
C $9E6F,1 *2
C $9E70,1 *4
C $9E71,2 *4 + 16
C $9E7F,3 Random
C $9E8D,3 Calc address in #R$AC5D and Set
C $9E9B,3 Random
C $9EAD,3 Calc address in #R$AC5D and Set
C $9EC6,3 Calc address in #R$AC5D and Set
C $9EF6,3 Calc address in #R$AC5D and Set
C $9EFC,3 Check value in #R$AC5D table
C $9F06,3 Calc address in #R$AC5D and Set
C $9F14,3 Calc address in #R$AC5D and Set
C $9F1C,3 Random
C $9F2E,3 Calc address in #R$AC5D and Set
C $9F49,3 Calc address in #R$AC5D and Set
C $9F5A,3 Calc address in #R$AC5D and Set
C $9F68,3 Check value in #R$AC5D table
C $9F72,3 Calc address in #R$AC5D and Set
c $9F81
C $9F86,3 Random
C $9F91,3 Check value in #R$AC5D table
C $9F9D,3 Calc address in #R$AC5D and Get
C $9FA6,3 Calc address in #R$AC5D and Set
C $9FAD,3 Calc address in #R$AC5D and Set
C $9FB9,3 Calc address in #R$AC5D and Set
C $9FC6,3 Calc address in #R$AC5D and Get
C $9FD4,3 Calc address in #R$AC5D and Get
C $9FD9,3 Calc address in #R$AC5D and Get
C $9FE5,3 Calc address in #R$AC5D and Get
C $9FF0,3 Check value in #R$AC5D table
C $9FF9,3 Check value in #R$AC5D table
C $A005,3 Calc address in #R$AC5D and Get
C $A00A,3 Calc address in #R$AC5D and Get
C $A018,3 Check value in #R$AC5D table
C $A022,3 Check value in #R$AC5D table
C $A02F,3 Calc address in #R$AC5D and Get
C $A034,3 Calc address in #R$AC5D and Get
c $A03B
C $A040,3 Random
C $A04B,3 Check value in #R$AC5D table
C $A056,3 Calc address in #R$AC5D and Get
C $A05F,3 Calc address in #R$AC5D and Get
C $A066,3 Calc address in #R$AC5D and Get
C $A072,3 Calc address in #R$AC5D and Get
C $A07F,3 Calc address in #R$AC5D and Get
C $A08D,3 Calc address in #R$AC5D and Get
C $A093,3 Calc address in #R$AC5D and Get
C $A09F,3 Calc address in #R$AC5D and Get
C $A0AA,3 Check value in #R$AC5D table
C $A0B3,3 Check value in #R$AC5D table
C $A0BF,3 Calc address in #R$AC5D and Get
C $A0C4,3 Calc address in #R$AC5D and Get
C $A0D2,3 Check value in #R$AC5D table
C $A0DC,3 Check value in #R$AC5D table
C $A0E9,3 Calc address in #R$AC5D and Get
C $A0EE,3 Calc address in #R$AC5D and Get
c $A0F5 Calculate address ???
R $A0F5 I:HL Char coords H = row, L = column 0..31
C $A0F5,19
. HL[15:11] -> HL[9:5]; HL[7:3] -> HL[4:0];
. as a result, we have HL[9:0] filled with significant bits;
. 10 bits means 1024 addressed bytes
c $A129 Calculate address and Get ???
R $A129 I:HL Char coords H = row, L = column 0..31
b $A132
c $A14C Get screen attribute address
@ $A14C label=GetScrAttrAddr
R $A14C I:HL Char coords H = row, L = column 0..31
c $A164 Convert char coords HL to ZX screen address
R $A164 I:HL Char coords H = row 0..23, L = column 0..31
R $A164 O:HL Address on the ZX screen
c $A176 Draw tile 16x8 at the screen
R $A176 I:HL Char coords H = row 0..23, L = column 0..31
R $A176 I:DE Tile address; 16 bytes
C $A176,3 Convert char coords HL to ZX screen address
c $A187 Draw tile 8x8 at the screen
R $A187 I:HL Char coords H = row 0..23, L = column 0..31
R $A187 I:DE Tile address; 8 bytes
C $A187,3 Convert char coords HL to ZX screen address
c $A193
C $A1B0,3 Calc address in #R$AC5D and Get
C $A227,3 Random
C $A26E,3 get current Random
b $A27E Table of objects on the map; each record is 4 bytes wide
N $A27E 1st byte = flags; 2nd byte = column 0..255, 3rd byte = row 0..255
B $A27E,,16
B $A40C,,16
b $A41B
B $A41B,,16
b $A4DD Relief construction blocks, 8x8 tiles = 64x64 pixels
N $A4DD Each block has 8*8 = 64 tiles, tiles defined at #R$9134
B $A4DD,64,8 #HTML[<img src="images/blocks/block00.png" />] $00
B $A51D,64,8 #HTML[<img src="images/blocks/block01.png" />] $01
B $A55D,64,8 #HTML[<img src="images/blocks/block02.png" />] $02
B $A59D,64,8 #HTML[<img src="images/blocks/block03.png" />] $03
B $A5DD,64,8 #HTML[<img src="images/blocks/block04.png" />] $04
B $A61D,64,8 #HTML[<img src="images/blocks/block05.png" />] $05
B $A65D,64,8 #HTML[<img src="images/blocks/block06.png" />] $06
B $A69D,64,8 #HTML[<img src="images/blocks/block07.png" />] $07
B $A6DD,64,8 #HTML[<img src="images/blocks/block08.png" />] $08
B $A71D,64,8 #HTML[<img src="images/blocks/block09.png" />] $09
B $A75D,64,8 #HTML[<img src="images/blocks/block0A.png" />] $0A
B $A79D,64,8 #HTML[<img src="images/blocks/block0B.png" />] $0B
B $A7DD,64,8 #HTML[<img src="images/blocks/block0C.png" />] $0C
B $A81D,64,8 #HTML[<img src="images/blocks/block0D.png" />] $0D
B $A85D,64,8 #HTML[<img src="images/blocks/block0E.png" />] $0E
B $A89D,64,8 #HTML[<img src="images/blocks/block0F.png" />] $0F
B $A8DD,64,8 #HTML[<img src="images/blocks/block10.png" />] $10
B $A91D,64,8 #HTML[<img src="images/blocks/block11.png" />] $11
B $A95D,64,8 #HTML[<img src="images/blocks/block12.png" />] $12
B $A99D,64,8 #HTML[<img src="images/blocks/block13.png" />] $13
B $A9DD,64,8 #HTML[<img src="images/blocks/block14.png" />] $14
B $AA1D,64,8 #HTML[<img src="images/blocks/block15.png" />] $15
B $AA5D,64,8 #HTML[<img src="images/blocks/block16.png" />] $16
B $AA9D,64,8 #HTML[<img src="images/blocks/block17.png" />] $17
B $AADD,64,8 #HTML[<img src="images/blocks/block18.png" />] $18
B $AB1D,64,8 #HTML[<img src="images/blocks/block19.png" />] $19
B $AB5D,64,8 #HTML[<img src="images/blocks/block1A.png" />] $1A
B $AB9D,64,8 #HTML[<img src="images/blocks/block1B.png" />] $1B
B $ABDD,64,8 #HTML[<img src="images/blocks/block1C.png" />] $1C place for Octupus, left block
B $AC1D,64,8 #HTML[<img src="images/blocks/block1D.png" />] $1D place for Octupus, right block
b $AC5D Relief mini-map 32x32 = 256 bytes
N $AC5D Each byte is relief block number (see #R$A4DD), each relief block is 8x8 tiles, and tiles are 8x8 pixels.
. So this mini-map defines the world of 256x256 tiles, or 2048 x 2048 pixels.
B $AC5D,,32
b $B05D
b $B07D Table of objects on the screen
B $B07D,,4
c $B0A9 Draw static objects on the screen; prepare LB07D table
C $B0A9,4 get Screen position on mini-map
C $B0FD,2 screen attribute for chest
C $B0FF,3 Sprite 16x8 Chest
C $B102,2 check "chest" bit
C $B106,2 screen attribute for oxygen
C $B108,3 Sprite 8x8 Oxygen
C $B10B,2 check "oxygen" bit
C $B10F,2 screen attribute for shells
C $B111,2 check "big/small" bit
C $B115,3 Sprite 8x8 Small shell opened
C $B118,2 check "closed/opened" bit
C $B11C,3 Sprite 8x8 Small shell closed
C $B121,3 Sprite 16x16 Big shell opened
C $B124,2 check "closed/opened" bit
C $B128,3 Sprite 16x16 Big shell closed
C $B12C,1 save (row, column)
C $B12D,3 Get screen attribute address
C $B130,1 set screen attribute
C $B132,1 set screen attribute
C $B138,2 one char line upper
C $B13B,1 set screen attribute
C $B13D,1 set screen attribute
C $B13E,1 restore (row, column)
C $B140,3 Draw tile 16x8 at the screen
C $B143,1 restore (row, column)
C $B144,1 One char line upper
C $B145,3 Draw tile 16x8 at the screen
C $B154,3 Get screen attribute address
C $B157,1 set screen attribute
C $B159,1 set screen attribute
C $B15B,3 Draw tile 16x8 at the screen
C $B162,3 Get screen attribute address
C $B165,1 set screen attribute
C $B167,3 Draw tile 8x8 at the screen
b $B16C Sprites for objects
N $B16C Sprite 16x16 Big shell opened; first lower part then upper
B $B16C,16,8 #HTML[#UDGARRAY2,,,2,,;$B16C-$B17B-1-16(sprB16C)]
B $B17C,16,8 #HTML[#UDGARRAY2,,,2,,;$B17C-$B18B-1-16(sprB17C)]
N $B18C Sprite 16x16 Big shell closed; first lower part then upper
B $B18C,16,8 #HTML[#UDGARRAY2,,,2,,;$B18C-$B19B-1-16(sprB18C)]
B $B19C,16,8 #HTML[#UDGARRAY2,,,2,,;$B19C-$B1AB-1-16(sprB19C)]
N $B1AC Sprite 8x8 Oxygen
B $B1AC,8,8 #HTML[#UDGARRAY1,,,1,,;$B1AC-$B1B3-1-8(sprB1AC)]
N $B1B4 Sprite 16x8 Chest
B $B1B4,16,8 #HTML[#UDGARRAY2,,,2,,;$B1B4-$B1C3-1-16(sprB1B4)]
N $B1C4 Sprite 8x8 Small shell closed
B $B1C4,8,8 #HTML[#UDGARRAY1,,,1,,;$B1C4-$B1CB-1-8(sprB1C4)]
N $B1CC Sprite 8x8 Small shell opened
B $B1CC,8,8 #HTML[#UDGARRAY1,,,1,,;$B1CC-$B1D3-1-8(sprB1CC)]
c $B1D4
C $B1E2,3 Random
b $B210
B $B210,1,1 ???
B $B211,1,1 ???
B $B212,1,1 ???
c $B213
C $B213,3 Octopus delay and process
C $B21C,3 get value 7 / 5 / 3 / 1, depending on Game level 1..4
C $B269,3 Get screen attribute address
C $B289,3 Random
C $B2A8,3 sprite 8x8 address, 8 bytes
C $B2AB,3 Draw tile 8x8 with XOR
C $B2B1,3 sprite 16x16 address, 32 bytes
C $B2B5,3 Draw tile 16x8 with XOR
C $B2B9,1 one line upper
C $B2BA,3 Draw tile 16x8 with XOR
c $B2C0 Octopus delay and process
C $B2C5,3 get value 10 / 8 / 6 / 4, depending on Game level 1..4
C $B2C9,3 Process Octopus, draw if needed
B $B2CD,1,1
c $B2CE Draw tile 8x8 with XOR
R $B2CE I:HL Char coords H = 0..23, L = 0..31
R $B2CE I:DE Tile address
C $B2CE,3 Convert char coords HL to ZX screen address
C $B2D1,2 tile height 8 pixels
c $B2DB Draw tile 16x8 with XOR
R $B2DB I:HL Char coords H = 0..23, L = 0..31
R $B2DB I:DE Tile address
C $B2DB,3 Convert char coords HL to ZX screen address
C $B2DE,2 tile height 8 pixels
b $B2EE Sprite 8x8 address, 8 bytes
B $B2EE,8,8 #HTML[#UDGARRAY1,,,1,,;$B2EE-$B2F5-1-8(sprB2EE)]
b $B2F6 Sprite 16x16, 32 bytes; first lower part then upper
B $B2F6,16,8 #HTML[#UDGARRAY2,,,2,,;$B2F6-$B305-1-16(sprB2F6)]
B $B306,16,8 #HTML[#UDGARRAY2,,,2,,;$B306-$B315-1-16(sprB306)]
b $B316
B $B316,1,1
c $B317 Process Octopus, draw if needed
C $B349,3 Base address for Octopus phases
C $B359,3 Draw Octopus sprite
c $B35D Draw Octopus sprite
R $B35D DE Octopus sprite address, 6x4 tiles 8x8 pixels, 192 bytes
C $B368,3 get Octopus row/column
b $B392 Unused?
c $B3A0
R $B3A0 I:IX Object address = $E33B
c $B470
R $B470 I:IX ???
C $B4F6,3 Convert char coords HL to ZX screen address
C $B55F,3 Copy records forward
c $B572 Copy records forward
R $B572 I:HL source address
R $B572 I:DE destination address
R $B572 I:IY ??? (IY+$0A) is record size
R $B572 I:B number of records to copy
c $B57E
R $B57E I:IY ???
C $B57E,3 get record size
C $B590,3 Copy records backward
c $B598 Copy records backward
R $B598 I:HL source address
R $B598 I:DE destination address
R $B598 I:IY ??? (IY+$0A) is record size
R $B598 I:B number of records to copy
c $B5A4
R $B5A4 I:IX ???
R $B5A4 I:IY ???
C $B5B5,3 Copy records forward
C $B5D4,3 Copy records backward
c $B5E0
R $B5E0 I:IX ???
R $B5E0 I:IY ???
s $B676
c $B686
R $B686 I:IX ???
R $B686 I:IY ???
C $B6C9,3 Get screen attribute address
c $B70F
R $B70F I:IX ???
R $B70F I:IY ???
C $B726,3 Get screen attribute address
c $B737
R $B737 I:IX ??? $C4F0
C $B7AD,4 address of the return point - put on the stack
N $B7B8 Point of return
s $B7B9
c $B7BB
R $B7BB I:IX ???
c $B836
c $B837
c $B885
C $B885,4 check "moving" bit
C $B8CF,3 Get screen attribute address
C $B932,4 set "moving" bit
C $B95D,6 set sprite address
C $B963,6 set sprite address
C $B969,4 clear "moving" bit
c $B972
C $B972,4 check "moving" bit
C $B9BF,3 Get screen attribute address
C $BA24,4 set "moving" bit
C $BA5B,4 clear "moving" bit
c $BA64
C $BA64,4 check "moving" bit
C $BA90,3 Get screen attribute address
C $BAE4,4 set "moving" bit
C $BBFC,4 set "moving" bit
C $BCE4,3 set X value
C $BCE7,3 set Y value
C $BD62,4 clear "moving" bit
c $BD83
R $BD83 I:A ???
C $BD95,3 Random
C $BDA4,3 set DX value
b $BDA9
c $BDBA
C $BDBD,3 get screen position (row) on mini-map
s $BDE9
B $BDAA,8
c $BDEA
c $BE40
c $BE58
c $BE6D
c $BE85
c $BE9A
c $BEB2
c $BEC7
c $BEDB
C $BEE4,11 Copy 21 byte from $C20A to $C4F0
C $BF00,3 Random
C $BF15,3 get current Random
C $BF2A,3 Random
b $BFA0
c $BFB0
R $BFB0 I:HL ???
R $BFB0 I:IY ???
R $BFB0 I:A ???
C $BFBA,3 Random
C $BFC3,3 !!! mutable argument
C $BFDE,3 get current Random
C $BFFA,3 Random
b $C007
W $C007,2,2 ???
c $C009
C $C03C,3 Random
b $C092
W $C092,,8
B $C20A,,21
B $C2EB
B $C331
c $C431
c $C45C
c $C481
c $C4D5 Delay ??
C $C4D7,4 get value 150 / 100 / 50 / 1, depending on Game level
b $C4E7
b $C4F0
s $C500
c $D990 Game
C $D998,3 reset Score value
C $D99B,3 reset HELD value
C $D99E,2 Number of lives
C $D9A0,3 set the initial value
C $D9A3,3 Prepare the world mini-map (#R$AC5D table)
C $D9A6,3 Initialize variables depending of Game level
C $D9B1,3 Prepare game screen and some variables
C $D9B7,3 get Screen position on mini-map
C $D9BA,3 Draw game screen
C $D9C9,4 Diver object record address
C $D9DB,3 get Number of lives
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
c $DA59 Print char and shift current position right
N $DA63 Print char and shift current position down
N $DA6B Print char
C $DA6D,3 Convert char coords HL to ZX screen address
C $DA79,1 *8
C $DA7E,3 ROM font address, for chars $20..$7F
C $DA83,3 Tiles 8x8 address, for chars $80..$AE
C $DA90,3 Get screen attribute address
c $DA98 Print string
R $DA98 I:HL String address
R $DA98 I:BC Row and column
R $DA98 I:DE Print char procedure address
C $DAA2,3 Print char and shift !!! mutable argument #R$DA59 / #R$DA63
c $DAAD Prepare game screen and some variables
C $DAAF,3 Clear screen with attribute A
C $DAB6,3 Indicator top border
C $DABC,3 Procedure Print char and shift right
C $DABF,3 Print string
C $DAC2,3 Indicator bottom border
C $DAC8,3 Print string
C $DACB,3 "HIGH"
C $DAD1,3 Print string
C $DAD4,3 "SCORE"
C $DADA,3 Print string
C $DADD,3 "HELD"
C $DAE3,3 Print string
C $DAE6,3 Indicator left/right border
C $DAEC,3 Procedure Print char and shift down
C $DAEF,3 Print string
C $DAF2,3 Indicator left/right border
C $DAF8,3 Print string
C $DAFB,3 "OXYGEN"
C $DB01,3 Print string
C $DB04,3 "DEPTH"
C $DB0A,3 Print string
C $DB0D,3 "SKILL LIVES"
C $DB13,3 Print string
C $DB1B,3 Vertical gauge
C $DB24,3 Vertical gauge
C $DB2A,3 Print string
C $DB32,3 "1 2 3 4"
C $DB38,3 Print string
C $DB3B,3 "1 2 3 4"
C $DB41,3 Print string
C $DB53,3 Game level 1..4
C $DB62,3 get Number of lives
C $DB74,4 Diver object record address
C $DB78,3 Print high score number
C $DB7B,3 Print score number
C $DB7E,3 Print HELD number
C $DB81,3 Game level 1..4
C $DB88,1 A = ([Game level] - 1) * 16 => 0 / 16 / 32 / 48
C $DB8F,1 HL = $DDF0 + ([Game level] - 1) * 16
C $DB98,3 Game level 1..4
C $DB9F,3 = 5 - [Game level] = 4 / 3 / 2 / 1
C $DBA2,3 = 5 - [Game level] = 4 / 3 / 2 / 1
C $DBAF,3 Game level 1..4
C $DBB9,3 = 10 - [Game level] * 2 + 2 => 10 / 8 / 6 / 4
C $DBBE,3 = 10 - [Game level] * 2 + 2 - 3 => 7 / 5 / 3 / 1
c $DBC2 Initialize variables depending of Game level
@ $DBC2 label=InitLevelVars
C $DBC2,3 Game level 1..4
C $DBC6,1 *4
C $DBC7,2 A = [Game level] * 4 + 9 => 13 / 17 / 21 / 25
C $DBCF,2 A = [Game level] * 4 + 9 + 5 => 18 / 22 / 26 / 31
C $DBD7,1 A = ([Game level] * 4 + 9) * 2 + 1 => 27 / 35 / 43 / 51
C $DBDB,1 A = ([Game level] * 4 + 9) * 2 => 26 / 34 / 42 / 50
C $DBDF,3 Game level 1..4
C $DBF7,3 Game level 1..4
C $DBE5,1 A = [Game level] * 5 => 5 / 10 / 15 / 20
C $DBEC,2 A = [Game level] * 5 * 3 - 3 => 12 / 27 / 42 / 57
C $DBFC,2 3 / 2 / 1 / 0
b $DC09 Texts for indicator panel
B $DC09,9,9 Indicator top border
B $DC12,9,9 Indicator bottom border
B $DC1B,5,5 "HIGH"
B $DC20,7,7 "000000"
B $DC27,6,6 "SCORE"
B $DC2D,5,5 "HELD"
B $DC32,23 Indicator left/right border
B $DC49,7,7 "OXYGEN"
B $DC50,6,6 "DEPTH"
B $DC56,15 "SKILL    LIVES"
B $DC65,17 Vertical gauge
B $DC76,8,8 "1 2 3 4"
W $DC7E,2,2 Char coords for printing on the screen, see #R$DA59
b $DC80 Tiles 8x8
B $DC80,64,8 #HTML[#UDGARRAY1,,,1,,;$DC80-$DCBF-1-8(tiles80)]
B $DCC0,64,8 #HTML[#UDGARRAY1,,,1,,;$DCC0-$DCFF-1-8(tiles81)]
B $DD00,64,8 #HTML[#UDGARRAY1,,,1,,;$DD00-$DD3F-1-8(tiles82)]
B $DD40,64,8 #HTML[#UDGARRAY1,,,1,,;$DD40-$DD7F-1-8(tiles83)]
B $DD80,64,8 #HTML[#UDGARRAY1,,,1,,;$DD80-$DDBF-1-8(tiles84)]
B $DDC0,48,8 #HTML[#UDGARRAY1,,,1,,;$DDC0-$DDEF-1-8(tiles85)]
b $DDF0 Blocks of 14 bytes to copy to #R$5B27, blocks aligned to 16 bytes
W $DDF0,16,16 Level 1
W $DE00,16,16 Level 2
W $DE10,16,16 Level 3
W $DE20,16,14 Level 4
c $DE2E Update gauge indicator on the screen
@ $DE2E label=UpdateGauge
c $DE3E Update Depth indicator
@ $DE3E label=UpdateDepth
b $DE55
W $DE55,2,2 ???
W $DE57,2,2 ???
W $DE59,2,2 ???
W $DE5B,2,2 ???
c $DE5D Update Oxygen indicator
@ $DE5D label=UpdateOxygen
R $DE5D I:HL New value for Oxygen
C $DE79,3 Play melody $E629
c $DE85 Print decimal number
@ $DE85 label=PrintDec
R $DE85 I:B ??? $00 $02
R $DE85 I:HL Number to print
R $DE85 I:DE Address on the screen: $4059 $4099 $40DA
C $DE89,4 address for list of dividers: 10000, 1000, 100, 10, 1
C $DE8F,6 get divider in DE
C $DEC0,3 ZX Charset (3D00) + $80 = address of char '0'
c $DED9 Print high score number
@ $DED9 label=PrintHighScore
C $DEE1,3 Print decimal number
c $DEE5 Print score number
@ $DEE5 label=PrintScore
C $DEE7,3 get Score value
C $DEED,3 Print decimal number
c $DEF1 Print HELD number
@ $DEF1 label=PrintHeld
C $DEF3,3 get HELD value
C $DEF9,3 Print decimal number
b $DEFD
W $DEFF,2,2 HELD value
@ $DEFF label=HELD
B $DF0F,2,2
b $DF25 Table: Angle 0..15 -> (DX, DY)
B $DF25,,16
b $DF45
c $DFD5
R $DFD5 I:IX Object address = $E33B
C $DFFF,3 get Angle 0..15
C $E006,3 Table base address
C $E00A,1 get DX value for the Angle
C $E00B,3 set DX value
C $E00F,1 get DY value for the Angle
C $E010,3 set DY value
C $E013,4 check "moving" bit
C $E019,4 clear DX value
C $E01D,4 clear DY value
C $E021,3 get X value
C $E024,3 get Screen position on mini-map
C $E027,3 add DX
C $E02A,3 set X value
C $E041,4 set DX value
C $E08D,3 get Y value
C $E090,3 add DY
C $E093,3 set Y value
C $E0AC,4 check DY value - moving up?
C $E0C7,3 set Y value
C $E0EA,4 check DY value - moving up?
C $E13F,3 set Screen position on mini-map
C $E142,3 Draw game screen
C $E1D5,3 get Angle 0..15
C $E1E4,3 Diver sprites base address
C $E1E7,1 now HL = diver sprite address
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
C $E2B1,3 get speed factor
C $E2D4,3 Read keyboard input
c $E2DB Read keyboard input
@ $E2DB label=ReadKeyboard
R $E2DB I:IX Object address = $E33B
C $E2E0,3 get Angle
C $E2E3,4 get port for Clockwise key
C $E2E7,3 get bit mask for Clockwise key
C $E2EB,2 read the port for Clockwise key
C $E2EE,2 not pressed => skip rotate
N $E2F0 Clockwise key pressed
C $E2F0,1 rotate clockwise
C $E2F1,4 get port for Anticlockwise key
C $E2F5,3 get bit mask for Anticlockwise key
C $E2F9,2 read the port for Anticlockwise key
C $E2FC,2 not pressed => skip rotate
N $E2FE Anticlockwise key pressed
C $E2FE,1 rotate anticlockwise
C $E302,3 set Angle 0..15
C $E305,4 get port for Accelerate key
C $E309,3 get bit mask for Accelerate key
C $E310,2 not pressed => skip
N $E312 Accelerate key pressed
C $E312,3 get speed factor
C $E30D,2 read the port for Accelerate key
C $E315,4 set "moving" bit
C $E31C,3 decrement speed factor
C $E31F,4 get port for Decelerate key
C $E323,3 get bit mask for Decelerate key
C $E327,2 read the port for Decelerate key
C $E32A,1 not pressed => return
N $E32B Decelerate key pressed
C $E32B,3 get speed factor
C $E32E,2 = 20 ?
C $E332,4 clear "moving" bit - diver stopped
b $E33B Diver object record
B $E33B,1,1 (IX+$00) Column 0..31
@ $E33B label=DiverObj
B $E33C,1,1 (IX+$01) Row
B $E33D,1,1 (IX+$02) ???
B $E33E,1,1
B $E33F,1,1 (IX+$04) DX value for the Angle, -2..2, see table #R$DF25
B $E340,1,1 (IX+$05) DY value for the Angle, -2..2, see table #R$DF25
B $E341,1,1 (IX+$06) Angle 0..15, initially 4
B $E342,1,1
B $E343,1,1 (IX+$08) ???
W $E344,2,2 (IX+$09) Sprite address
W $E346,2,2 (IX+$0B) Sprite address
B $E348,1,1 (IX+$0D) ??? bits 0/1/2/3/4/5/6/7
B $E349,1,1 (IX+$0E) speed factor: 12 20 40 100; $08 max speed, $14 min speed
B $E34A,1,1 (IX+$0F) speed counter
B $E34B,1,1 (IX+$10) ??? bits 0/1/2/3/4/5/6/7;
. bit0: 1 = diver moving, 0 = diver stopped
B $E34C,1,1 (IX+$11) ??? $00 $FF
B $E34D,1,1 (IX+$12) ??? $00
B $E34E,1,1 (IX+$13) X value
B $E34F,1,1 (IX+$14) Y value
B $E350,1,1 (IX+$15) X shift 0..7
B $E351,1,1 (IX+$16) Y shift 0..7
B $E352,1,1 (IX+$17) ???
B $E353,1,1 (IX+$18) Column 0..31
B $E354,1,1 (IX+$19) Row
B $E355,2,2
B $E357,1,1 (IX+$1C) ???
B $E358,2,2
B $E35A,1,1 (IX+$1F) Row??
B $E35B,1,1 (IX+$20) ??? $03
B $E35C,1,1 (IX+$21) ???
B $E35D,1,1 (IX+$22) ??? $F5
B $E35E,1,1
W $E35F,2,2 (IX+$24) Sprite address
B $E361,1,1 (IX+$26) ??? bits 0/1/2/3/4/5/6
B $E362,1,1 (IX+$27) ???
B $E363,1,1 (IX+$28) ???
c $E364
R $E364 I:IX Object address = $E33B
C $E373,3 Game level 1..4
C $E38F,3 Explosion
C $E3B6,3 Get screen attribute address
C $E3CD,3 Explosion
C $E3DD,4 clear "moving" bit
C $E3E5,3 get Angle 0..15
C $E3E9,2 0 / 4 / 8 / 12
C $E3EB,1 0 / 8 / 16 / 24
C $E3EC,1 0 / 16 / 32 / 48
C $E3ED,1 0 / 32 / 64 / 96
C $E3F1,3 Base address for 4 sprites of drowned diver
C $E405,6 reset HELD value
C $E40B,3 Print HELD number
C $E412,3 Melody address
C $E415,3 Play melody
c $E41B
R $E41B I:IX Object record address
C $E41F,3 get Angle
C $E422,2 rotate 180 degree
C $E424,2 0..15
C $E426,3 set Angle
c $E43A Diver explosion ??
R $E43A I:IX Object address = $E33B
C $E447,4 clear "moving" bit
C $E44B,3 get Angle 0..15
C $E44F,3 Explosion sprite address
C $E469,3 Play melody
C $E46C,6 reset HELD value
C $E472,3 Print HELD number
c $E476 Process objects on the screen - like take Oxygen or pick up pearls
R $E476 I:IX Object address = $E33B
C $E4DE,3 get value 75 / 50 / 150 / 100, depending on Game level
C $E4FF,4 set HELD value
C $E4FB,4 get value depending of game level
C $E509,3 get HELD value
C $E50D,3 set HELD value
C $E512,3 Get screen attribute address
C $E51F,3 Print HELD number
C $E522,3 Play melody $E60B
C $E53E,3 get value depending of game level
C $E541,3 set HELD value
C $E54A,3 Print HELD number
C $E54D,3 Play melody $E60B
C $E575,3 get value 2 / 4 / 6 / 8, depending on Game level
C $E595,3 Print HELD number
C $E598,3 Play melody $E60B
C $E5CD,3 get value 5 / 10 / 15 / 20, depending on Game level
c $E5D2 DE = (L5B33) - HELD
C $E5D2,4 get HELD value
C $E5D6,4 get value depending of game level
C $E5DE,1 DE = (L5B33) - HELD
b $E5E0 Dividers used to print decimal number, see #R$DE85
W $E5E0,10,10 10000, 1000, 100, 10, 1
W $E5EA,2,2
c $E5EC Play melody
@ $E5EC label=PlayMelody
R $E5EC I:HL Melody address
C $E5FB,3 ROM Beeper subroutine
C $E602,2 continue
b $E604 Melodies
B $E60B
c $E615 Play melody $E60B
C $E618,3 Play melody
b $E61C Melodies
B $E629
B $E630
B $E632
B $E634
B $E638
c $E645 Play melody $E629
C $E64B,3 Play melody
b $E652
c $E682
c $E6AB
C $E6AB,4 Diver object record address
C $E6B5,3 get Number of lives
C $E6CC,3 set Screen position on mini-map
C $E6E3,4 set Y value = 12
C $E6F1,4 clear DX value
C $E6F5,4 clear DY value
C $E705,4 speed factor = min speed
C $E71A,3 set Column value
C $E727,3 one Column right
C $E72D,3 set X value
C $E730,3 get Number of lives
C $E73F,3 get X value
C $E747,3 one Column right
C $E74E,3 set X value
C $E759,3 Sprite diver sitting on the boat
C $E75C,6 set sprite address
C $E762,4 set "moving" bit
c $E767
C $E775,4 clear DX value
C $E779,4 clear DY value
C $E788,4 set DX value = -2
C $E78C,4 get port for Accelerate key
C $E790,3 get bit mask for Accelerate key
C $E794,2 Read from port for the key
C $E797,1 Return if not pressed
C $E79B,3 Play melody
C $E7A8,3 Sprite diver sitting on the boat
C $E7AB,6 set sprite address
C $E7B5,4 set DX value = -1
C $E7B9,4 set DY value = +2
C $E7C2,3 Sprite diver directing up-right
C $E7C5,4 speed factor = min speed
C $E7C9,6 set sprite address
C $E7D3,4 set DX value = +2
C $E7D7,4 set DY value = +2
C $E7FF,6 set sprite address
C $E805,3 address right after last diver sprite
C $E810,4 clear DX value
C $E814,4 clear DY value
C $E820,4 clear "moving" bit
C $E824,3 Game level 1..4
C $E856,6 set sprite address
C $E863,4 clear DX value
C $E867,4 clear DY value
C $E873,4 clear "moving" bit
C $E877,3 Game level 1..4
C $E894,3 Play melody
C $E8A5,3 get HELD value
C $E8A8,4 get Score value
C $E8AD,3 set Score value
C $E8B0,6 reset HELD value
C $E8DC,3 get value depending of game level
C $E8DF,4 get Score value
C $E8E7,3 Print score number
C $E8F1,3 Play melody
C $E8F7,3 Play melody
C $E8B6,3 Print HELD number
C $E8B9,3 Print score number
c $E915
C $E947,4 clear DX value
C $E94B,3 get Screen position on mini-map
C $E969,4 clear DX value
C $E96D,4 set DY = -1
C $E972,3 get Screen position (column) on mini-map
C $E97C,3 set Column value
C $E98A,3 Sprite diver climbing on the boat
C $E98D,6 set sprite address
c $E9B0
R $E9B0 I:IX Object address = $E33B
C $E9C4,3 get Number of lives
b $E9D1
B $E9D8,2,2
b $E9DA Score table, 160 bytes
B $E9DA,,16
B $EA74,,16
c $EA7A
C $EA8D,4 Score table address
C $EAAB,3 Score table address
c $EADE
C $EADE,4 Diver object record address
C $EAEC,3 set ATTR-P - Permanent current colours
C $EAF1,3 ROM call CHAN-OPEN
C $EAF6,3 ROM call inside BORDER subroutine
C $EAFB,3 ROM call CHAN-OPEN
C $EAFE,3 ROM CLS subroutine
C $EB03,3 ROM call CHAN-OPEN
C $EB06,3 Table of records text
C $EB0C,3 ROM call PR-STRING
C $EB13,3 address of last line of the score table
C $EB3C,3 ROM call PR-STRING
C $EB40,4 Diver object record address
C $EB50,3 Convert char coords HL to ZX screen address
C $EB59,3 Print decimal number
C $EB74,3 ROM call PR-STRING
C $EB77,3 "ENTER SKILL (1TO4),K,L OR S."
C $EB7D,3 ROM call PR-STRING
c $EB82
C $EB8C,3 ROM call PR-STRING
C $EB9C,3 get LAST-K - Last key pressed
C $EBCC,3 ROM call PR-STRING
c $EBDB
C $EBE9,3 ROM OUT-NUM-1 subroutine
t $EBEE Texts used for indicator panel
T $EBEE,7
T $EBF5,14
T $EC03,7
T $EC2A,$1F
T $EC4B,3
T $EC53,6
T $EC59,7
c $EC7C Redefine keys
@ $EC7C label=RedefineKeys
C $EC7E,3 ROM call CHAN-OPEN
C $EC83,3 ROM call inside BORDER subroutine
C $EC88,3 ROM call CHAN-OPEN
C $EC8D,3 set ATTR-P - Permanent current colours
C $EC90,3 ROM CLS subroutine
C $EC93,3 UDG symbols used for Redefine keys
C $EC96,3 set UDG - Address of first user defined graphic
C $EC9B,3 ROM call CHAN-OPEN
C $EC9E,3 ROM call KEYBOARD
C $ECA7,3 text for keys redefining
C $ECAD,3 ROM call PR-STRING
C $ECB0,3 Sound
C $ECB3,4 set port for Clockwise key
C $ECB7,3 Save key for Clockwise
C $ECBD,3 ROM call PR-STRING
C $ECC0,3 Sound
C $ECC3,4 set port for Anticlockwise key
C $ECC7,3 Save key for Anticlockwise
C $ECCD,3 ROM call PR-STRING
C $ECD0,3 Sound
C $ECD3,4 set port for Accelerate key
C $ECD7,3 Save key for Accelerate
C $ECDD,3 ROM call PR-STRING
C $ECE0,3 Sound
C $ECE3,4 set port for Decelerate
C $ECE7,3 Save key for Decelerate
c $ECEB Sound??
C $ED10,3 ROM BEEPER subroutine
b $ED23 UDG symbols $90..$93 used for Redefine keys
B $ED23,8,8 #HTML[#UDG$ED23(udg0)] $90
B $ED2B,8,8 #HTML[#UDG$ED2B(udg1)] $91
B $ED33,8,8 #HTML[#UDG$ED33(udg2)] $92
B $ED3B,8,8 #HTML[#UDG$ED3B(udg3)] $93
b $ED43 Text for Redefine keys
T $ED4A
B $ED60
T $ED63
B $ED79
T $ED7C
B $ED92
T $ED97
B $EDA1
T $EDA5
B $EDB3
T $EDB7
B $EDC4
T $EDC9
B $EDD4
b $EDD5 Melody
c $EDDF Starting point
@ $EDDF label=Start
C $EDE6,3 ROM call CHAN-OPEN
C $EDEB,3 set ATTR-P - Permanent current colours
C $EDFC,2 set bit to mark we already started the program
C $EE04,3 ROM call PR-STRING
C $EE07,3 "ENTER SKILL (1TO4),K,L OR S."
C $EE0D,3 ROM call PR-STRING
C $EE16,3 Play melody
c $EE1C
C $EE36,3 get LAST-K - Last key pressed
C $EE39,2 'K' ?
C $EE3D,3 Redefine keys
C $EE45,2 'L' ?
C $EE49,3 ROM CLS subroutine
C $EE4E,3 ROM call CHAN-OPEN
C $EE51,3 "LOAD ? (Y/N)"
C $EE57,3 ROM call PR-STRING
C $EE66,3 get LAST-K - Last key pressed
C $EE69,2 'N' ?
C $EE6D,2 'Y' ?
C $EE74,1 Returning to BASIC, loading score table
C $EE75,2 'S' ?
C $EE7C,1 Returning to BASIC, saving score table
C $EE7D,2 -'1'
C $EE85,1 1..4
C $EE86,3 Save game level 1..4
N $EE89 Game level selected, starting the game
C $EE8C,3 Play melody
C $EE98,3 get High Score value from the score table
C $EE9B,3 set High Score value for indicator
C $EE9E,3 Game
c $EEAD
C $EEB6,3 Game level 1..4
C $EEBB,3 Clear screen with attribute A
C $EECA,3 Initialize variables depending of Game level
C $EED3,3 set Screen position on mini-map
C $EED6,3 Draw game screen
C $EEDD,3 "PRESS ANY KEY"
C $EEE3,3 ROM call PR-STRING
C $EEED,3 Procedure Print char and shift down
C $EEF3,3 Print string
C $EEFA,3 Print string
C $EF01,3 Print string
C $EF08,3 Print string
C $EF25,3 ROM call KEYBOARD
b $EF3A
B $EF3A,15
B $EF49,15
t $EF7F
T $EF86
b $EF93
t $EF9A
s $EFA6
s $F000 Buffer??
