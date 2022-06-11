b $4000 Screen
D $4000 #UDGTABLE { #SCR(loading) } TABLE#
  $4000,6144,32 Pixels
  $5800,768,32 Attributes
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
N $8D74 Tiles 8x8 pixels
B $8D74,64,8 #HTML[#UDGARRAY1,,,1,,;$8D74-$8DB3-1-8(tiles0)]
B $8DB4,64,8 #HTML[#UDGARRAY1,,,1,,;$8DB4-$8DF3-1-8(tiles1)]
B $8DF4,64,8 #HTML[#UDGARRAY1,,,1,,;$8DF4-$8E33-1-8(tiles2)]
B $8E34

N $9134 Relief blocks 8x8 pixels

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
c $A14C Get screen attribute address
R $A14C I:HL Char coords H = row, L = column 0..31
c $A164 Convert char coords HL to ZX screen address
R $A164 I:HL Char coords H = row 0..23, L = column 0..31
R $A164 O:HL Address on the ZX screen
c $A176 Draw tile 16x8 at the screen
C $A176 Convert char coords HL to ZX screen address
R $A176 I:HL Char coords H = row 0..23, L = column 0..31
R $A176 I:DE Tile address; 16 bytes
c $A187 Draw tile 8x8 at the screen
C $A187,3 Convert char coords HL to ZX screen address
R $A187 I:HL Char coords H = row 0..23, L = column 0..31
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
b $B07D ???
c $B0A9
C $B0FF,3 Sprite 16x8 Chest
C $B108,3 Sprite 8x8 Oxygen
C $B115,3 Sprite 8x8 Small shell opened
C $B121,3 Sprite 16x16 Big shell opened
C $B128,3 Sprite 16x16 Big shell closed
C $B11C,3 Sprite 8x8 Small shell closed
C $B12D,3 Get screen attribute address
C $B138,2 one char line upper
C $B140,3 Draw tile 16x8 at the screen
C $B144,1 One char line upper
C $B145,3 Draw tile 16x8 at the screen
C $B154,3 Get screen attribute address
C $B15B,3 Draw tile 16x8 at the screen
C $B162,3 Get screen attribute address
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
c $B213
C $B21C,3 Random
C $B269,3 Get screen attribute address
C $B289,3 Random
C $B2A8,3 sprite 8x8 address, 8 bytes
C $B2AB,3 Draw tile 8x8 with XOR
C $B2B1,3 sprite 16x16 address, 32 bytes
C $B2B5,3 Draw tile 16x8 with XOR
C $B2B9,1 one line upper
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
b $B2EE Sprite 8x8 address, 8 bytes
B $B2EE,8,8 #HTML[#UDGARRAY1,,,1,,;$B2EE-$B2F5-1-8(sprB2EE)]
b $B2F6 Sprite 16x16, 32 bytes; first lower part then upper
B $B2F6,16,8 #HTML[#UDGARRAY2,,,2,,;$B2F6-$B305-1-16(sprB2F6)]
B $B306,16,8 #HTML[#UDGARRAY2,,,2,,;$B306-$B315-1-16(sprB306)]
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
C $B6C9,3 Get screen attribute address
c $B70F
C $B726,3 Get screen attribute address
c $B737
c $B7B8
s $B7B9
c $B7BB
c $B836
c $B837
c $B885
C $B8CF,3 Get screen attribute address
c $B972
C $B9BF,3 Get screen attribute address
c $BA64
C $BA90,3 Get screen attribute address
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
W $C092,,8
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
C $DA90,3 Get screen attribute address
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
C $E3B6,3 Get screen attribute address
C $E3CD,3 Explosion
C $E3E5,3 get Angle 0..15
C $E3E9,2 0 / 4 / 8 / 12
C $E3EB,1 0 / 8 / 16 / 24
C $E3EC,1 0 / 16 / 32 / 48
C $E3ED,1 0 / 32 / 64 / 96
C $E3F1,3 Base address for 4 sprites of drowned diver
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
C $E44B,3 get Angle 0..15
C $E44F,3 Explosion sprite address
C $E469,3 Play melody
c $E476
R $E476 I:IX Object address = $E33B
C $E512,3 Get screen attribute address
C $E522,3 Make sound
C $E54D,3 Make sound
C $E598,3 Make sound
c $E5D2
b $E5E0
c $E5EC Play melody
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
B $E634
B $E638
c $E645 Play melody $E629
C $E64B,3 Play melody
b $E652
c $E682
c $E6AB
C $E6AB,4 Diver object record address
C $E6B5,3 get Number of lives
C $E730,3 get Number of lives
c $E767
C $E790,3 get bit mask for Accelerate key
C $E79B,3 Play melody
C $E824,3 Game level 1..4
C $E877,3 Game level 1..4
C $E894,3 Play melody
C $E8F1,3 Play melody
C $E8F7,3 Play melody
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
B $EDD4
b $EDD5 Melody
b $EDDF
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
C $EE8C,3 Play melody
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
