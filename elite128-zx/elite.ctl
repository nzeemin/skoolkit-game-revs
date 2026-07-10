@ $5B00 start
@ $5B00 org
@ $5D70 label=FontInRAM
@ $6048 label=objCoriolis
b $6048
B $6048,1 length 27h
B $6049,1
B $604A,5
B $604F,1
B $6050,1
B $6051,1
B $6052,4
B $6056,4
B $605A,4
B $605E,4
B $6062,3
B $6065,4
B $6069,1 2,=1 Coriolis is hostile
B $606A,4
B $606E,1 7,=1 mission 3 completed
@ $606F label=DataOfAround
B $606F,195 +$00,$01,$02 coordinate +$02 7,= sign??? +$03,$04,$05 coordinate +$06,$07,$08 coordinate +$22 =$00 free??? +$23..$24 descriptor address???
B $6132,39
@ $6159 label=objMissile
B $6159,9 slot for the missile +00
B $6162,25
B $617B,5 missile descriptor +$22
@ $6180 label=AdrDataShips
B $6180,76
@ $61CC label=d_ASP
B $61CC,1 cargo hold
B $61CD,1 collision distance along X/Y/Z (0000.xx)
B $61CE,1 laser hit chance for Elite rank (halved if not Elite)
B $61CF,1 vertex count
B $61D0,1 edge count
B $61D1,1 normal count
B $61D2,1 max speed
B $61D3,1 max energy
W $61D4,2 kill bounty
B $61D6,1 what it can launch
B $61D7,1 geometric size (distance beyond which shown as a dot)
W $61D8,2 offset to vertex data
W $61DA,2 offset to edge data
W $61DC,2 offset to normal data
B $61DE,1 flags
B $61DF,1
B $61E0,1
W $61E1,2 rating points
B $61E3,114 vertices (19 * 6 bytes: X,Y,Z coords)
B $6255,112 edges (28 * 4 bytes)
B $62C5,48 normals (12 * 4 bytes)
@ $62F5 label=d_Asteroid1
B $62F5,1 cargo hold
B $62F6,1 collision distance along X/Y/Z (0000.xx)
B $62F7,1 laser hit chance for Elite rank (halved if not Elite)
B $62F8,1 vertex count
B $62F9,1 edge count
B $62FA,1 normal count
B $62FB,1 max speed
B $62FC,1 max energy
W $62FD,2 kill bounty
B $62FF,1 what it can launch
B $6300,1 geometric size (distance beyond which shown as a dot)
W $6301,2 offset to vertex data (points into another ship's model, reused)
W $6303,2 offset to edge data (points into another ship's model, reused)
W $6305,2 offset to normal data (points into another ship's model, reused)
B $6307,1 flags
B $6308,1
B $6309,1
W $630A,2 rating points
@ $630C label=d_Asteroid2
B $630C,1 cargo hold
B $630D,1 collision distance along X/Y/Z (0000.xx)
B $630E,1 laser hit chance for Elite rank (halved if not Elite)
B $630F,1 vertex count
B $6310,1 edge count
B $6311,1 normal count
B $6312,1 max speed
B $6313,1 max energy
W $6314,2 kill bounty
B $6316,1 what it can launch
B $6317,1 geometric size (distance beyond which shown as a dot)
W $6318,2 offset to vertex data
W $631A,2 offset to edge data
W $631C,2 offset to normal data
B $631E,1 flags
B $631F,1
B $6320,1
W $6321,2 rating points
B $6323,54 vertices (9 * 6 bytes: X,Y,Z coords)
B $6359,84 edges (21 * 4 bytes)
B $63AD,56 normals (14 * 4 bytes)
@ $63E5 label=d_Cargo
B $63E5,1 cargo hold
B $63E6,1 collision distance along X/Y/Z (0000.xx)
B $63E7,1 laser hit chance for Elite rank (halved if not Elite)
B $63E8,1 vertex count
B $63E9,1 edge count
B $63EA,1 normal count
B $63EB,1 max speed
B $63EC,1 max energy
W $63ED,2 kill bounty
B $63EF,1 what it can launch
B $63F0,1 geometric size (distance beyond which shown as a dot)
W $63F1,2 offset to vertex data
W $63F3,2 offset to edge data
W $63F5,2 offset to normal data
B $63F7,1 flags
B $63F8,1
B $63F9,1
W $63FA,2 rating points
B $63FC,60 vertices (10 * 6 bytes: X,Y,Z coords)
B $6438,60 edges (15 * 4 bytes)
B $6474,28 normals (7 * 4 bytes)
@ $6490 label=d_Cobra1
B $6490,1 cargo hold
B $6491,1 collision distance along X/Y/Z (0000.xx)
B $6492,1 laser hit chance for Elite rank (halved if not Elite)
B $6493,1 vertex count
B $6494,1 edge count
B $6495,1 normal count
B $6496,1 max speed
B $6497,1 max energy
W $6498,2 kill bounty
B $649A,1 what it can launch
B $649B,1 geometric size (distance beyond which shown as a dot)
W $649C,2 offset to vertex data (points into another ship's model, reused)
W $649E,2 offset to edge data (points into another ship's model, reused)
W $64A0,2 offset to normal data (points into another ship's model, reused)
B $64A2,1 flags
B $64A3,1
B $64A4,1
W $64A5,2 rating points
@ $64A7 label=d_Cobra2
B $64A7,1 cargo hold
B $64A8,1 collision distance along X/Y/Z (0000.xx)
B $64A9,1 laser hit chance for Elite rank (halved if not Elite)
B $64AA,1 vertex count
B $64AB,1 edge count
B $64AC,1 normal count
B $64AD,1 max speed
B $64AE,1 max energy
W $64AF,2 kill bounty
B $64B1,1 what it can launch
B $64B2,1 geometric size (distance beyond which shown as a dot)
W $64B3,2 offset to vertex data
W $64B5,2 offset to edge data
W $64B7,2 offset to normal data
B $64B9,1 flags
B $64BA,1
B $64BB,1
W $64BC,2 rating points
B $64BE,168 vertices (28 * 6 bytes: X,Y,Z coords)
B $6566,152 edges (38 * 4 bytes)
B $65FE,52 normals (13 * 4 bytes)
@ $6632 label=d_EscapePod
B $6632,1 cargo hold
B $6633,1 collision distance along X/Y/Z (0000.xx)
B $6634,1 laser hit chance for Elite rank (halved if not Elite)
B $6635,1 vertex count
B $6636,1 edge count
B $6637,1 normal count
B $6638,1 max speed
B $6639,1 max energy
W $663A,2 kill bounty
B $663C,1 what it can launch
B $663D,1 geometric size (distance beyond which shown as a dot)
W $663E,2 offset to vertex data
W $6640,2 offset to edge data
W $6642,2 offset to normal data
B $6644,1 flags
B $6645,1
B $6646,1
W $6647,2 rating points
B $6649,24 vertices (4 * 6 bytes: X,Y,Z coords)
B $6661,24 edges (6 * 4 bytes)
B $6679,16 normals (4 * 4 bytes)
@ $6689 label=d_FerDeLance
B $6689,1 cargo hold
B $668A,1 collision distance along X/Y/Z (0000.xx)
B $668B,1 laser hit chance for Elite rank (halved if not Elite)
B $668C,1 vertex count
B $668D,1 edge count
B $668E,1 normal count
B $668F,1 max speed
B $6690,1 max energy
W $6691,2 kill bounty
B $6693,1 what it can launch
B $6694,1 geometric size (distance beyond which shown as a dot)
W $6695,2 offset to vertex data
W $6697,2 offset to edge data
W $6699,2 offset to normal data
B $669B,1 flags
B $669C,1
B $669D,1
W $669E,2 rating points
B $66A0,114 vertices (19 * 6 bytes: X,Y,Z coords)
B $6712,108 edges (27 * 4 bytes)
B $677E,40 normals (10 * 4 bytes)
@ $67A6 label=d_Missile
B $67A6,1 cargo hold
B $67A7,1 collision distance along X/Y/Z (0000.xx)
B $67A8,1 laser hit chance for Elite rank (halved if not Elite)
B $67A9,1 vertex count
B $67AA,1 edge count
B $67AB,1 normal count
B $67AC,1 max speed
B $67AD,1 max energy
W $67AE,2 kill bounty
B $67B0,1 what it can launch
B $67B1,1 geometric size (distance beyond which shown as a dot)
W $67B2,2 offset to vertex data
W $67B4,2 offset to edge data
W $67B6,2 offset to normal data
B $67B8,1 flags
B $67B9,1
B $67BA,1
W $67BB,2 rating points
B $67BD,102 vertices (17 * 6 bytes: X,Y,Z coords)
B $6823,96 edges (24 * 4 bytes)
B $6883,36 normals (9 * 4 bytes)
@ $68A7 label=d_Alloys
B $68A7,1 cargo hold
B $68A8,1 collision distance along X/Y/Z (0000.xx)
B $68A9,1 laser hit chance for Elite rank (halved if not Elite)
B $68AA,1 vertex count
B $68AB,1 edge count
B $68AC,1 normal count
B $68AD,1 max speed
B $68AE,1 max energy
W $68AF,2 kill bounty
B $68B1,1 what it can launch
B $68B2,1 geometric size (distance beyond which shown as a dot)
W $68B3,2 offset to vertex data
W $68B5,2 offset to edge data
W $68B7,2 offset to normal data
B $68B9,1 flags
B $68BA,1
B $68BB,1
W $68BC,2 rating points
B $68BE,24 vertices (4 * 6 bytes: X,Y,Z coords)
B $68D6,16 edges (4 * 4 bytes)
@ $68E6 label=d_Python1
B $68E6,1 cargo hold
B $68E7,1 collision distance along X/Y/Z (0000.xx)
B $68E8,1 laser hit chance for Elite rank (halved if not Elite)
B $68E9,1 vertex count
B $68EA,1 edge count
B $68EB,1 normal count
B $68EC,1 max speed
B $68ED,1 max energy
W $68EE,2 kill bounty
B $68F0,1 what it can launch
B $68F1,1 geometric size (distance beyond which shown as a dot)
W $68F2,2 offset to vertex data (points into another ship's model, reused)
W $68F4,2 offset to edge data (points into another ship's model, reused)
W $68F6,2 offset to normal data (points into another ship's model, reused)
B $68F8,1 flags
B $68F9,1
B $68FA,1
W $68FB,2 rating points
@ $68FD label=d_Python2
B $68FD,1 cargo hold
B $68FE,1 collision distance along X/Y/Z (0000.xx)
B $68FF,1 laser hit chance for Elite rank (halved if not Elite)
B $6900,1 vertex count
B $6901,1 edge count
B $6902,1 normal count
B $6903,1 max speed
B $6904,1 max energy
W $6905,2 kill bounty
B $6907,1 what it can launch
B $6908,1 geometric size (distance beyond which shown as a dot)
W $6909,2 offset to vertex data
W $690B,2 offset to edge data
W $690D,2 offset to normal data
B $690F,1 flags
B $6910,1
B $6911,1
W $6912,2 rating points
B $6914,66 vertices (11 * 6 bytes: X,Y,Z coords)
B $6956,104 edges (26 * 4 bytes)
B $69BE,52 normals (13 * 4 bytes)
@ $69F2 label=d_Sidewinder
B $69F2,1 cargo hold
B $69F3,1 collision distance along X/Y/Z (0000.xx)
B $69F4,1 laser hit chance for Elite rank (halved if not Elite)
B $69F5,1 vertex count
B $69F6,1 edge count
B $69F7,1 normal count
B $69F8,1 max speed
B $69F9,1 max energy
W $69FA,2 kill bounty
B $69FC,1 what it can launch
B $69FD,1 geometric size (distance beyond which shown as a dot)
W $69FE,2 offset to vertex data
W $6A00,2 offset to edge data
W $6A02,2 offset to normal data
B $6A04,1 flags
B $6A05,1
B $6A06,1
W $6A07,2 rating points
B $6A09,60 vertices (10 * 6 bytes: X,Y,Z coords)
B $6A45,60 edges (15 * 4 bytes)
B $6A81,28 normals (7 * 4 bytes)
@ $6A9D label=d_Coriolis
B $6A9D,1 cargo hold
B $6A9E,1 collision distance along X/Y/Z (0000.xx)
B $6A9F,1 laser hit chance for Elite rank (halved if not Elite)
B $6AA0,1 vertex count
B $6AA1,1 edge count
B $6AA2,1 normal count
B $6AA3,1 max speed
B $6AA4,1 max energy
W $6AA5,2 kill bounty
B $6AA7,1 what it can launch
B $6AA8,1 geometric size (distance beyond which shown as a dot)
W $6AA9,2 offset to vertex data
W $6AAB,2 offset to edge data
W $6AAD,2 offset to normal data
B $6AAF,1 flags
B $6AB0,1
B $6AB1,1
W $6AB2,2 rating points
B $6AB4,96 vertices (16 * 6 bytes: X,Y,Z coords)
B $6B14,112 edges (28 * 4 bytes)
B $6B84,56 normals (14 * 4 bytes)
@ $6BBC label=d_Minerals
B $6BBC,1 cargo hold
B $6BBD,1 collision distance along X/Y/Z (0000.xx)
B $6BBE,1 laser hit chance for Elite rank (halved if not Elite)
B $6BBF,1 vertex count
B $6BC0,1 edge count
B $6BC1,1 normal count
B $6BC2,1 max speed
B $6BC3,1 max energy
W $6BC4,2 kill bounty
B $6BC6,1 what it can launch
B $6BC7,1 geometric size (distance beyond which shown as a dot)
W $6BC8,2 offset to vertex data
W $6BCA,2 offset to edge data
W $6BCC,2 offset to normal data
B $6BCE,1 flags
B $6BCF,1
B $6BD0,1
W $6BD1,2 rating points
B $6BD3,24 vertices (4 * 6 bytes: X,Y,Z coords)
B $6BEB,24 edges (6 * 4 bytes)
B $6C03,16 normals (4 * 4 bytes)
@ $6C13 label=d_Thargon
B $6C13,1 cargo hold
B $6C14,1 collision distance along X/Y/Z (0000.xx)
B $6C15,1 laser hit chance for Elite rank (halved if not Elite)
B $6C16,1 vertex count
B $6C17,1 edge count
B $6C18,1 normal count
B $6C19,1 max speed
B $6C1A,1 max energy
W $6C1B,2 kill bounty
B $6C1D,1 what it can launch
B $6C1E,1 geometric size (distance beyond which shown as a dot)
W $6C1F,2 offset to vertex data
W $6C21,2 offset to edge data
W $6C23,2 offset to normal data
B $6C25,1 flags
B $6C26,1
B $6C27,1
W $6C28,2 rating points
B $6C2A,120 vertices (20 * 6 bytes: X,Y,Z coords)
B $6CA2,104 edges (26 * 4 bytes)
B $6D0A,40 normals (10 * 4 bytes)
@ $6D32 label=d_Krait
B $6D32,1 cargo hold
B $6D33,1 collision distance along X/Y/Z (0000.xx)
B $6D34,1 laser hit chance for Elite rank (halved if not Elite)
B $6D35,1 vertex count
B $6D36,1 edge count
B $6D37,1 normal count
B $6D38,1 max speed
B $6D39,1 max energy
W $6D3A,2 kill bounty
B $6D3C,1 what it can launch
B $6D3D,1 geometric size (distance beyond which shown as a dot)
W $6D3E,2 offset to vertex data
W $6D40,2 offset to edge data
W $6D42,2 offset to normal data
B $6D44,1 flags
B $6D45,1
B $6D46,1
W $6D47,2 rating points
B $6D49,102 vertices (17 * 6 bytes: X,Y,Z coords)
B $6DAF,84 edges (21 * 4 bytes)
B $6E03,24 normals (6 * 4 bytes)
@ $6E1B label=d_Viper
B $6E1B,1 cargo hold
B $6E1C,1 collision distance along X/Y/Z (0000.xx)
B $6E1D,1 laser hit chance for Elite rank (halved if not Elite)
B $6E1E,1 vertex count
B $6E1F,1 edge count
B $6E20,1 normal count
B $6E21,1 max speed
B $6E22,1 max energy
W $6E23,2 kill bounty
B $6E25,1 what it can launch
B $6E26,1 geometric size (distance beyond which shown as a dot)
W $6E27,2 offset to vertex data
W $6E29,2 offset to edge data
W $6E2B,2 offset to normal data
B $6E2D,1 flags
B $6E2E,1
B $6E2F,1
W $6E30,2 rating points
B $6E32,90 vertices (15 * 6 bytes: X,Y,Z coords)
B $6E8C,80 edges (20 * 4 bytes)
B $6EDC,28 normals (7 * 4 bytes)
@ $6EF8 label=d_Tharglet
B $6EF8,1 cargo hold
B $6EF9,1 collision distance along X/Y/Z (0000.xx)
B $6EFA,1 laser hit chance for Elite rank (halved if not Elite)
B $6EFB,1 vertex count
B $6EFC,1 edge count
B $6EFD,1 normal count
B $6EFE,1 max speed
B $6EFF,1 max energy
W $6F00,2 kill bounty
B $6F02,1 what it can launch
B $6F03,1 geometric size (distance beyond which shown as a dot)
W $6F04,2 offset to vertex data
W $6F06,2 offset to edge data
W $6F08,2 offset to normal data
B $6F0A,1 flags
B $6F0B,1
B $6F0C,1
W $6F0D,2 rating points
B $6F0F,60 vertices (10 * 6 bytes: X,Y,Z coords)
B $6F4B,60 edges (15 * 4 bytes)
B $6F87,28 normals (7 * 4 bytes)
@ $6FA3 label=AdrProcMessage1
W $6FA3,28 00h ret
@ $6FBF label=AdrProcMessage2
B $6FBF,65 00h ret
c $7000 Start
N $7000 Entry point after loading
@ $7003 label=msgDescrLine1
b $7003
B $7003,31
@ $7022 label=msgDescrLine2
B $7022,31
@ $7041 label=WhatOnScreen
B $7041,1 What is shown on screen =0..3 in flight, view-screen number (front, rear, left, right) =$04 buy-goods menu =$05 sell-goods menu =$06 buy-equipment menu =$07 global map =$08 local map =$09 planet info not yet shown =$0A planet prices =$0B pilot info =$0C Inventory =$20 planet info
@ $7042 label=HighAngleLR
B $7042,1 high byte of the rotation angle 7,n sign (left/right) $00..$0F
@ $7043 label=HighAngleDU
B $7043,1 high byte of the rotation angle 7,n sign (up/down) $00..$0F
@ $7044 label=HighDeltaSpeed
B $7044,2 high byte of speed $00..$1F
@ $7046 label=ShieldFront
B $7046,2 front shield +0 - current value -1 - value shown on screen
@ $7048 label=ShieldRear
B $7048,2 rear shield +0 - current value -1 - value shown on screen
@ $704A label=Fuel
B $704A,2 fuel +0 - current value -1 - value shown on screen
@ $704C label=Temperature
B $704C,2 +0 - current value -1 - value shown on screen
@ $704E label=TempLaser
B $704E,2 laser temperature +0 - current value -1 - value shown on screen >$90 we don't fire
@ $7050 label=Altitude
B $7050,2 +0 - current value -1 - value shown on screen
@ $7052 label=Speed
B $7052,2 +0 - current value -1 - value shown on screen
@ $7054 label=ShieldUnit1
B $7054,2 +0 - current value -1 - value shown on screen
@ $7056 label=ShieldUnit2
B $7056,2 +0 - current value -1 - value shown on screen
@ $7058 label=ShieldUnit3
B $7058,2 energy level +0 - current value -1 - value shown on screen
@ $705A label=ShieldUnit4
B $705A,2 +0 - current value -1 - value shown on screen
@ $705C label=RotateLR
B $705C,2 +0 - current value -1 - value shown on screen
@ $705E label=RotateDU
B $705E,2 +0 - current value -1 - value shown on screen
@ $7060 label=Missile
B $7060,1
@ $7061 label=InFreeSpace
B $7061,1 <>0 between systems (F interception)
@ $7062 label=IndDanger
B $7062,1 <>0 in flight (also the danger indicator color) =0 docked =$04=%00 000 100 leaving the station, in flight (green) =$63=%01 100 011 4th energy unit not full (flashing red)) =$02=%00 000 010 one of the front/rear shields empty (red) =$06=%00 000 110 something nearby (yellow)
@ $7063 label=RndWord
W $7063,2 random number
@ $7065 label=SunCrd
B $7065,1 data for printing the sun, 9 bytes long, crd low x planet
@ $7066 label=SunCrdX_med
B $7066,1
@ $7067 label=SunCrdX_hi
B $7067,1 crd high X sun
@ $7068 label=SunCrdY_low
B $7068,1
@ $7069 label=SunCrdY_med
B $7069,1
@ $706A label=SunCrdY_hi
B $706A,1 crd high Y sun
@ $706B label=SunCrdZ_low
B $706B,1
@ $706C label=SunCrdZ_med
B $706C,1
@ $706D label=SunCrdZ_hi
B $706D,1 crd high Z sun
@ $706E label=PlanetCrd
B $706E,1 Planet coordinates in space
@ $706F label=PlanetCrdX_med
B $706F,1
@ $7070 label=PlanetCrdX_hi
B $7070,1 crd high x planet
@ $7071 label=PlanetCrdY_low
B $7071,1
@ $7072 label=PlanetCrdY_med
B $7072,1
@ $7073 label=PlanetCrdY_hi
B $7073,1 crd high y planet
@ $7074 label=PlanetCrdZ_low
B $7074,1
@ $7075 label=PlanetCrdZ_med
B $7075,1 crd med z planet
@ $7076 label=PlanetCrdZ_hi
B $7076,1 crd high z planet
@ $7077 label=CoriolisNear
B $7077,1 <>0 near the station, docking is possible
@ $7078 label=J_Drive_Coriolis
B $7078,1 =0 J-drive unavailable
@ $7079 label=FuelScoopsOn
B $7079,1 <>0 near the sun, fuel scoops working
@ $707A label=PlayerGameOver
B $707A,1 <>0 energy units empty, player destroyed
@ $707B label=TypeOfPrint
B $707B,1 adjust the print routine depending on distance to the sun =$00 or c <>$00 xor c
@ $707C label=BlockControl
B $707C,1 =0 after leaving the station =1 when docking
@ $707D label=nBeepFX
B $707D,1 which sound to play =$00 no sound (silent) 0,=1 energy bomb exploded 1,=1 missile launched 2,=1 colliding with an object/object destroyed 3,=1 laser fired 4,=1 laser fired 5,=1 ECM working 6,=1 hit by laser on the player/docking damage 7,=1
@ $707E label=AutoDocking
B $707E,1 <>0(=$01) docking enabled
c $707F CalcAngSpeed4Prn
N $707F Update rotation angles and speed for on-screen display
C $707F,3 rotation angle 7,n sign (left/right) $0000..$0FFF
C $7083,3 set HighAngleLR
C $7094,3 set RotateLR
C $709A,3 set HighAngleDU
C $70AB,3 set RotateDU
C $70B1,3 set HighDeltaSpeed
C $70BA,3 set Speed
c $70BE GoDocking
C $70BE,3 =$01 G or H pressed (jump)
C $70C3,3 get ManualDocking
C $70C7,2 handle the docking computer
C $70CA,3 set ManualDocking
C $70CF,3 handle the docking computer
C $70D8,3 set ControlKey3
C $70DC,3 get CoriolisNear
C $70E1,3 57 docking computer
C $70E6,3 get IndDanger
C $70EB,3 get JumpDocking
C $70F0,3 2,=1 Coriolis is hostile
C $70F8,3 set AutoDocking
C $70FC,3 set WhatOnScreen
C $70FF,3 Print the frame and panel if needed
C $7102,3 Set new sun coordinates after auto-docking
C $7105,3 Docking/Takeoff
c $7108 NewJumpDockingCrdObj
N $7108 Set new sun coordinates after auto-docking
C $7108,4 data for printing the sun, 9 bytes long, crd low x planet
C $710C,4 length 27h
c $7116
c $712C
C $7138,3 compute the distance along one axis
c $713B ControlKeyIfMapOn
N $713B Handle controls while the map is displayed
C $713B,3 get WhatOnScreen
C $7144,3 get JumpDocking
C $7149,3 get ControlKeyMove
C $714F,3 get ControlKeyInMap
C $7152,2 'p'
C $715E,3 call a function by number from any page, returning to this page
C $7162,3 set ControlKeyInMap
C $7165,3 set ControlKeyMove
c $7169 NotUsed_1
c $716B BeginGame
C $716B,3 font, moved to $5D70 after loading, length 728($2D8) bytes
C $716E,3 font
C $7176,3 cockpit attributes
C $7179,3 cockpit panel attributes
C $7189,3 initialize ship movement parameters
C $718C,3 display the cockpit panel on screen
C $718F,2 'y' ; NewGame
C $719C,3 fill 256 bytes with the value 7
C $719F,3 fill 256 bytes with the value 7
C $71A2,3 ship rotation on the title screen with a prompt to load a save
C $71A5,3 print texts into the buffer
C $71A8,3 render the ship into the buffer for the title screen
C $71AB,3 Copy buffer to screen
C $71AE,3 get PressKeyPrnSymbol
C $71B2,2 ship rotation on the title screen with a prompt to load a save
C $71B4,2 'Z' ; Y pressed?
C $71B6,2 wait for key release
C $71B8,3 Save the cockpit
C $71BB,3 save/load menu
C $71BF,3 set WhatOnScreen
C $71C2,3 clear the screen with attribute $07, draw a border around the whole screen, set the initial text-print coordinates
C $71C5,3 Print the frame and panel if needed
C $71C8,3 wait for key release
C $71CC,2 wait for key release
C $71CE,3 ship number on the title screen
C $71E5,3 Fast clear of the screen buffer
C $71EB,3 rotate and print an object into the buffer for the title screen
C $71EE,3 Copy buffer to screen
C $71F4,3 something related to cursor and Sinclair joystick, unused in this version
C $7202,2 a = 1 kempston
C $7208,2 a = 1 kempston
C $720D,2 a = 1 kempston
C $720F,3 get PressKeyPrnSymbol
C $7212,2 ' '
C $7219,3 a = 1 kempston
C $721F,3 0-1,=00 SXNMA controls (LLFC0F)<>0 reset CS,F,c =01 Kempston controls =10 cursor controls 76850 =11 Sinclair right controls 2,=1 realistic control approximation (reaction) 3,=1 turn inertia on 4,=1 controls inverted 5,=1 up/down inverted 6,=1 Thargon interception on 7,=1 sound on
C $722B,3 set InFreeSpace
C $722E,3 set IndDanger
C $7231,3 set PilotMission1_1
C $7234,3 set FuelScoopsOn
C $7237,3 set CloakingDeviceOn
C $723A,3 set SunRadiusNova
C $723D,3 Save the cockpit
C $7240,3 Print info for key 'L'
C $7243,3 initialize ship movement parameters
C $7246,2 jump here after docking / starting a new game
c $7248 PrnTitTxtY
C $7248,3 Print the message "---- E L I T E ----"
C $724B,3 X=1 Y=0Eh
C $724E,2 print 'Load new commander (y/n)?'
c $7252 PrnTitTxtSpace
C $7252,3 Print the message "---- E L I T E ----"
C $7255,3 X=4 Y=0Eh
C $725A,3 set CrdXPrnSymbol
C $725D,3 set printing to the buffer
C $7262,3 print a message from group 2 in the buffer/on screen
C $7265,2 set printing to the screen
c $7267 Print_ELITE
N $7267 Print the message "---- E L I T E ----"
N $7267 on the title screen
C $726A,3 X=5 Y=1
C $726D,2 "---- E L I T E ----"
C $726F,3 print into the buffer
C $7274,3 print a message from group 1 in the buffer/on screen
C $7277,3 set printing to the screen
c $727D FillAtr256b
N $727D Fill 256 bytes with the value 7
N $727D In: HL - start address to fill
N $727D Out: hl=hl+0100h
N $727D b = 0
N $727D a = 7
@ $7286 label=nShipOnPreview
b $7286
B $7286,1 ship number on the title screen
c $7287 GameMain
N $7287 Jump here after docking / starting a new game
N $7287 main game loop
C $7287,3 get BlockControl
C $728D,3 Update rotation angles and speed for on-screen display
C $7290,3 check for keypress (and branch accordingly) for keys 1, 2, 3, 4, I, O, P, K, L, enter
C $7293,3 check for pause keypress and poll the keyboard, changing game modes
C $7298,1 end the game
C $7299,3 set WhatOnScreen
C $729C,3 Print the frame and panel if needed
C $729F,3 NewGame
C $72A2,3 Handle hyperjump keys G, H
C $72A5,3 get IndDanger
C $72AB,3 Handle controls while the map is displayed
C $72AE,3 get ControlKeyMove
C $72B3,2 jump here after docking / starting a new game, main game loop
C $72B5,3 Tape menu
C $72BB,3 Print info for key 'L'
C $72BE,2 jump here after docking / starting a new game, main game loop
C $72C0,3 get InFreeSpace
C $72C9,3 Movement on the J-drive
C $72CC,3 Update sun/planet coordinates as the player moves
C $72CF,3 Handle Coriolis station movement
C $72D2,3 get WhatOnScreen
C $72D7,2 in-flight loop with the view screen on
C $72D9,3 in-flight loop, menu displayed
C $72DC,3 handle the player's laser and the ECM system
C $72DF,3 get IndDanger
C $72E5,3 set indicator color when near a station
C $72E8,3 deal damage to the player's ship
C $72EB,3 Correct data if mission 1 has been given
C $72F4,3 Handle controls while the map is displayed
C $72FD,3 in-flight loop with the view screen on
C $7300,3 Fast clear of the screen buffer
C $7303,3 get InFreeSpace
C $7307,3 Print the sun and planet
C $730A,3 process and print stars accounting for player movement, including on the J-drive
C $730D,3 print the view-screen name
C $7310,3 process all objects in space
C $7313,3 print the crosshair, update ECM
C $7316,3 jump completion??
C $7319,3 Visual effect, ship explosion from an energy bomb?
C $731C,3 Copy buffer to screen
C $731F,3 print objects on the scanner
C $7322,3 Update on-screen indicators if needed
C $7325,3 Use of the Cloaking Device
C $7328,3 Control missiles, bombs, escape capsule
C $732B,3 calculate print parameters and draw the compass with pointer on screen
C $732E,3 get PlayerGameOver
C $7332,3 jump here after docking / starting a new game, main game loop
C $7335,1 player destruction, and game start
C $7336,3 set HighDeltaSpeed
C $7339,3 set TypeOfPrint
C $733D,3 set BlockControl
C $7342,3 print view-screen attributes
C $7345,3 Restore the scanner from the buffer
C $7348,3 Spawn two pieces of debris and a canister when the player is destroyed
C $734B,3 player-destroyed sound
C $734E,3 continuation of the ship-destruction sound
C $7351,3 Print the frame and panel if needed
C $7357,3 Fast clear of the screen buffer
C $735A,3 process and print stars accounting for player movement, including on the J-drive
C $735D,3 process all objects in space
C $7360,3 handle the player's laser and the ECM system
C $7363,3 print Game Over into the buffer
C $736C,3 set CrdXPrnSymbol
C $7371,3 print a message from group 2 in the buffer/on screen
C $7377,3 Copy buffer to screen
C $737D,3 Fast clear of the screen buffer
C $7380,3 Copy buffer to screen
C $7383,3 zero out the list of nearby objects
C $7386,2 '2'
C $738C,3 set BlockControl
C $738F,3 set PlayerGameOver
C $7392,3 =$01 G or H pressed (jump)
C $7395,3 NewGame
c $7398 CopyBuf2Screen
N $7398 Copy buffer to screen
N $7398 Copies only the two screen thirds that make up the 3D viewport, deliberately leaving the third third (where the cockpit panel lives) untouched between frames.
C $739E,3 fast interlaced transfer of the screen buffer to 1/3 of the screen
C $73A7,3 fast interlaced transfer of the screen buffer to 1/3 of the screen
C $73B0,3 fast interlaced transfer of the screen buffer to 1/3 of the screen
C $73B9,3 fast interlaced transfer of the screen buffer to 1/3 of the screen
c $73BD CopyPartBuf2Scr
N $73BD Fast interlaced transfer of the screen buffer to 1/3 of the screen
N $73BD In: hl - address in buffer
N $73BD de - address on screen
C $7412,2 ' '
c $741C PrnCockpit_Ifn
N $741C Print the frame and panel if needed
C $7422,3 Clear the keyboard buffer
c $7425 PrnCockpit
N $7425 Print the frame and ship cockpit on screen
C $7425,3 clear the screen with attribute $07, draw a border around the whole screen, set the initial text-print coordinates
C $7428,3 set attributes in the outer columns =00
C $743B,3 copy the cockpit image to screen
C $743E,3 cockpit image
C $7449,3 cockpit panel attributes
C $7451,3 get PilotMission1
C $7459,3 print view-screen attributes
C $745C,3 restore (if needed) and save the scanner to the buffer
c $745F ClearScrBuffer
N $745F Fast clear of the screen buffer
N $745F This is not a plain clear: the repeating byte pattern it writes already contains the 3D viewport border (a full horizontal line at the top and bottom, and a single vertical pixel down each edge column for every row in between), so the border is regenerated as a side effect of "clearing" every single frame, with no separate border-preserving or redrawing code needed.
C $7483,2 '~'
@ $74B0 label=SaveSP5
b $74B0
W $74B0,2
@ $74B2 label=SaveSP2
W $74B2,2
@ $74B4 label=CircleCrdXlow
B $74B4,1 distance to the sun/planet along the X axis, high byte 7,=1 negative value
@ $74B5 label=CircleCrdXmed
B $74B5,1
@ $74B6 label=CircleCrdXhigh
B $74B6,1
@ $74B7 label=CircleCrdYlow
B $74B7,1 distance to the sun/planet along the Y axis, high byte 7,=1 negative value
@ $74B8 label=CircleCrdYmed
B $74B8,1
@ $74B9 label=CircleCrdYhigh
B $74B9,1
@ $74BA label=CircleCrdZlow
B $74BA,1 distance to the sun/planet along the Z axis, high byte 7,=1 negative value
@ $74BB label=CircleCrdZmed
B $74BB,1
@ $74BC label=CircleCrdZhigh
B $74BC,1
@ $74BD label=SunRadiusNova
B $74BD,1 sun radius during the supernova explosion (mission 1)
c $74BE PrnSunPlanet
N $74BE Print the sun and planet
C $74BF,3 set TypeOfPrint
C $74C2,3 data for printing the sun, 9 bytes long, crd low x planet
C $74C5,3 distance to the sun/planet along the X axis, high byte 7,=1 negative value
C $74CD,3 calculate on-screen coordinates of the sun/planet projection
C $74D1,3 Correct data if mission 1 has been given
C $74D8,3 print a circle on screen/in the buffer
C $74DB,3 get CircleRadius
C $74DE,2 '('
C $74E4,3 set TypeOfPrint
C $74E7,3 planet coordinates in space
C $74EA,3 distance to the sun/planet along the X axis, high byte 7,=1 negative value
C $74F2,3 calculate on-screen coordinates of the sun/planet projection
c $74FA CorrData4Nova
N $74FA Correct data if mission 1 has been given
C $74FA,3 get PilotMission1_1
C $74FF,3 get SunRadiusNova
C $7505,3 get CircleRadius
C $7508,3 +0 - current value -1 - value shown on screen
C $7514,3 set PlayerGameOver
C $7518,3 set CircleRadius
C $751B,3 set SunRadiusNova
c $751F CalcPrnCrdSun
N $751F Calculate on-screen coordinates of the sun/planet projection
N $751F In: (CircleCrdXlow) 9-byte planet/sun descriptor
N $751F Out: a =0 cannot be printed
N $751F a =1 can be printed, variables set
C $7520,3 b'=0 c'=%00000011
C $7524,3 get WhatOnScreen
C $7528,3 not front
C $752B,3 front view
C $753F,3 get CircleCrdZlow
C $7543,3 get CircleCrdXlow
C $754D,2 center in the right half
C $7557,3 set CircleCrdX
C $7561,3 get CircleCrdZlow
C $7565,3 get CircleCrdYlow
C $756F,2 circle center in the lower half of the screen
C $7579,3 set CircleCrdY
C $757F,3 set CircleFlg
C $758B,4 get CircleCrdZlow
C $75D4,2 not Rear
C $75D6,3 Rear view
C $75EA,3 get CircleCrdZlow
C $75EE,3 get CircleCrdXlow
C $7602,3 not Left
C $7605,3 Left view
C $7619,3 get CircleCrdXlow
C $761D,3 get CircleCrdZlow
C $7631,3 set CircleCrdX
C $763B,3 get CircleCrdXlow
C $763F,3 get CircleCrdYlow
C $7653,3 set CircleCrdY
C $7659,3 set CircleFlg
C $7665,4 get CircleCrdXlow
C $76AD,3 Right view
C $76BC,3 get CircleCrdXlow
C $76C0,3 get CircleCrdZlow
C $76D0,3 set CircleRadius
c $76D6
N $76D6 Calculate one on-screen coordinate of the planet/sun projection
N $76D6 In: c' =3 for X/Z coordinates
N $76D6 =2 for Y/Z coordinates
N $76D6 hl.c - X/Y coordinate (for front/rear)
N $76D6 de.b - Z coordinate (for front/rear)
N $76D6 Out: 2,b' =1 coordinate crdX =< crdZ
N $76D6 3,b' =1 coordinate crdY =< crdZ
N $76D6 d - on-screen coordinate of the planet/sun projection
C $76D6,1 Out: d - delta
C $76EC,2 calculate one on-screen coordinate of the planet/sun projection
c $778F CalcCrdSunPlanet
N $778F Update sun/planet coordinates as the player moves
C $778F,4 data for printing the sun, 9 bytes long, crd low x planet
C $7793,3 update object coordinates from player movement
C $7796,4 planet coordinates in space
C $779A,3 update object coordinates from player movement
c $779D CalcCrdCoriolis
N $779D Handle Coriolis station movement
C $779D,3 get J_Drive_Coriolis
C $77A1,4 length 27h
C $77A5,2 update Coriolis coordinates from player movement
C $77AD,3 =$FF J-drive usable
C $77B0,3 update Coriolis coordinates from player movement
C $77CA,1 station is close, disable the J-drive
C $77CB,3 set J_Drive_Coriolis
b $77D4
B $77D4,1
c $77D5 Use_Y_Cloacking
N $77D5 Use of the Cloaking Device
C $77D9,3 7,=1 - Y -- Cloaking Device 6,=1 - 0 -- ??? 5,=1 - I -- Global Map 4,=1 - O -- Local Map 3,=1 - P -- Planet Info 2,=1 - K -- Planet Price 1,=1 - L -- Commander Info 0,=1 - Enter -- Inventory
C $77E7,1 if the key is still pressed, continue
C $77E8,3 +93 extra equipment present 7,=1 - ECM Jammer 6,=1 - Cloaking device 5,=1 - cannot buy goods (refugees in the hold) 4 3 =1 mission 3 was completed 2 =1 - mission 3 completed 1 =1 - mission 2 completed 0 =1 - mission 1 completed
C $77EE,3 =1 Cloaking Device on =1 energy drain while in use
C $77F2,2 paper 0, ink 7
C $77F4,3 check energy
C $77F7,2 '('
C $77FA,2 energy is low
C $77FD,3 2,=1 Coriolis is hostile
C $7803,3 set PlayerPirate
C $7806,2 paper 1, ink 7
C $780A,2 paper 0, ink 7
C $780C,3 print view-screen attributes
C $780F,3 get PilotMission1
C $7813,2 paper 0, ink 2 of the view screen
C $7818,3 get CloakingDeviceOn
C $781C,2 paper 1, ink 7
c $781F SetViewScrAtr
N $781F Set view-screen attributes accounting for mission 1 being given and turning on
N $781F Cloaking Device
C $781F,3 get PilotMission1
C $7826,3 set PilotMission1_1
C $7829,2 paper 0, ink 2 of the view screen
c $782B GoMission3
N $782B Give/complete mission 3, if available
C $782B,3 get PilotMission3
C $7832,3 offer of mission 3
C $7837,3 successful completion of mission 3
c $7840 GoPirates
N $7840 Ship capture by pirates, if needed
C $7848,3 Print the message "ship captured by pirates"
C $784C,3 set WhatOnScreen
C $784F,3 Print the frame and panel if needed
C $7856,3 NewGame
c $7859 UpdateAllIndicators
N $7859 Update on-screen indicators if needed
C $7859,3 table of indicator addresses on screen
C $7860,3 front shield +0 - current value -1 - value shown on screen
C $786F,3 print one indicator on screen
C $7880,3 set TypeIndicator
C $788F,3 print one indicator on screen
C $789F,3 set TypeIndicator
@ $78A3 label=TypeIndicator
b $78A3
B $78A3,1 indicator type =0 standard =1 rotate
@ $78A4 label=AdrScrIndicators
W $78A4,28 table of indicator addresses on screen
c $78C0 PrnInd_Type2
N $78C0 Print one indicator on screen
N $78C0 In: de - pointer into the indicator address table
N $78C0 a - indicator value (0..)
c $78CF PrnInd_Type1
N $78CF Print one indicator on screen
N $78CF In: de - pointer into the indicator address table
N $78CF a - indicator value (0..)
C $78E6,3 draw an empty cockpit indicator
C $78F2,3 get TypeIndicator
C $7912,2 draw 1/5 of the initial part of the cockpit indicator
c $794C PrnInd_Begin
N $794C Draw 1/5 of the initial part of the cockpit indicator
N $794C In: hl - indicator address on screen
N $794C c - value of the indicator segment
c $7961 PrnInd_Null
N $7961 Draw an empty cockpit indicator
N $7961 In: hl - indicator address on screen
c $7975 PrnInd_Type1_2
c $7986 PrnInd_Type1_3
C $7987,3 get TypeIndicator
c $7999 PrnDockingTonnel
N $7999 Visualize docking/takeoff (2x1 / 2x0.75 rectangle)
N $7999 In: (JumpDocking) =1
N $7999 (FlgJumpDocking) = $01 takeoff/docking
N $7999 Out: hl,de,bc,a - undefined
C $799C,3 get JumpDocking
c $79A3
N $79A3 Jump completion??
C $79A3,3 get FlgJumpDocking
C $79A8,3 initialize ship movement parameters
C $79AB,3 zero out the list of nearby objects
C $79AE,3 get InFreeSpace
C $79B4,4 length 27h
C $79BD,3 place 3-4 Thargons
C $79C0,3 Fast clear of the screen buffer
C $79C3,3 Copy buffer to screen
C $79C6,2 'B'
C $79CB,3 hyperjump sound
C $79D6,3 set NumOfCircle
C $79E0,3 jr c,7A4E for jump jr c,7A71 for docking jr c,7A6b for takeoff
C $79E3,3 get FlgJumpDocking
C $79F7,3 set CircleFlg
C $79FD,3 set CircleCrdY
C $7A00,3 get NumOfCircle
C $7A10,3 Division c=a.0/0.b
C $7A18,3 set CircleRadius
C $7A2B,3 Copy buffer to screen
C $7A32,2 '0'
C $7A37,2 jr c,7A4E for jump jr c,7A71 for docking jr c,7A6b for takeoff
C $7A39,3 get NumOfCircle
C $7A3F,3 Fast clear of the screen buffer
C $7A4F,3 set FlgJumpDocking
C $7A52,3 set JumpDocking
C $7A62,3 Fast clear of the screen buffer
C $7A65,3 Copy buffer to screen
C $7A6C,3 set FlgJumpDocking
C $7A6F,2 generate star coordinates for the tunnel (hyperspace effect)
C $7A72,3 set FlgJumpDocking
C $7A77,3 set JumpDocking
c $7A88 CalcStarsForTonnel
N $7A88 Generate star coordinates for the tunnel (hyperspace effect)
N $7A88 In: ---
N $7A88 Out: hl,de,bc,hl',de',bc.a - undefined
C $7A97,3 set HighDeltaSpeed
C $7A9A,3 get RndWord
C $7A9D,3 data for 16 stars
C $7AA3,3 rework the call parameters
c $7AB9 Stars_Div_C_A0_B
N $7AB9 Division c=a.0/0.b
c $7ACD
C $7ACD,3 get PilotMission1
C $7AD1,2 paper 0, ink 7
C $7AD3,3 print view-screen attributes
C $7AD7,3 set SunRadiusNova
C $7ADA,3 sound
@ $7ADD label=NumOfCircle
b $7ADD
B $7ADD,1 number of concentric circles
@ $7ADE label=CounterCircle
B $7ADE,1
B $7ADF,1
B $7AE0,16
B $7AF0,8
c $7AF8 LaunchDocking
N $7AF8 Docking/Takeoff
C $7AF8,3 get InFreeSpace
C $7B05,3 set NumOfCircle
C $7B08,2 '0'
C $7B0D,2 '@'
C $7B15,3 set JumpDocking
C $7B18,3 get IndDanger
C $7B1C,2 leaving the planet
C $7B1E,2 '8'
C $7B20,3 jr c,7A4E for jump jr c,7A71 for docking jr c,7A6b for takeoff
C $7B25,3 set HighDeltaSpeed
C $7B29,3 set HighAngleDU
C $7B2C,3 set HighAngleLR
C $7B2F,3 set TimeWorkECM
C $7B33,3 set BlockControl
C $7B36,3 ECM System 7,=1 system on
C $7B3B,3 Fast clear of the screen buffer
C $7B3E,3 visualize docking/takeoff (2x1 / 2x0.75 rectangle)
C $7B41,2 '/'
C $7B44,3 Fast clear of the screen buffer
C $7B47,3 visualize docking/takeoff (2x1 / 2x0.75 rectangle)
C $7B4A,3 Copy buffer to screen
C $7B50,3 sound
C $7B54,3 set IndDanger
C $7B57,3 Save the cockpit
C $7B5A,3 initialize ship movement parameters
C $7B5D,3 Give/complete mission 3, if available
C $7B60,3 Ship capture by pirates, if needed
C $7B63,2 L - pilot Info
C $7B65,3 call a function by number from any page, returning to this page
C $7B68,2 leaving the planet
C $7B6A,3 set IndDanger
C $7B6D,3 sound
C $7B71,3 set ManualDocking
C $7B74,3 set WhatOnScreen
C $7B77,3 =0 when leaving the planet
C $7B7A,3 set CloakingDeviceOn
C $7B7D,2 '2' ; jr 7a6b
C $7B7F,3 jr c,7A4E for jump jr c,7A71 for docking jr c,7A6b for takeoff
C $7B82,3 Print the frame and panel if needed
C $7B85,3 Print missiles, init variables, print cockpit attributes accounting for
C $7B88,3 set view-screen attributes accounting for mission 1 being given and the Cloaking Device being on
C $7B8B,3 set planet coordinates crd x =0 crd y =0 crd z = 0180.00
C $7B90,3 Zero out a memory area
C $7B98,3 get SunCrdZ_hi
C $7B9D,3 set SunCrdZ_hi
C $7BA0,3 length 27h
C $7BA5,3 Zero out a memory area
C $7BA8,4 set the station's coordinates and rotation angles
C $7BC5,3 zero out the list of nearby objects
C $7BC8,3 Update on-screen indicators if needed
C $7BCB,3 Fast clear of the screen buffer
C $7BCE,3 visualize docking/takeoff (2x1 / 2x0.75 rectangle)
C $7BD1,2 '$'
C $7BD4,3 Fast clear of the screen buffer
C $7BD7,3 process and print stars accounting for player movement, including on the J-drive
C $7BDA,3 visualize docking/takeoff (2x1 / 2x0.75 rectangle)
C $7BDD,3 Copy buffer to screen
C $7BE6,3 Fast clear of the screen buffer
C $7BE9,3 Update sun/planet coordinates as the player moves
C $7BEC,3 process and print stars accounting for player movement, including on the J-drive
C $7BEF,3 visualize docking/takeoff (2x1 / 2x0.75 rectangle)
C $7BF2,3 Print the sun and planet
C $7BF5,3 Copy buffer to screen
C $7BFC,3 =0 after leaving the station
c $7BFF InitSpeedAngle
N $7BFF Initialize ship movement parameters
N $7BFF In: ----
N $7BFF Out: b=$00
N $7BFF a=$00
N $7BFF hl - ????
C $7C01,3 zero out the rotation angles
C $7C04,3 Zero out a memory area
C $7C07,2 set speed
c $7C09 ClearKeyBuffer
N $7C09 Clear the keyboard buffer
C $7C0B,3 7,=1 - Y -- Cloaking Device
c $7C0E ClearMemory
N $7C0E Zero out a memory area
N $7C0E hl - address
N $7C0E b - length
c $7C14 ClearAroundObj
N $7C14 Zero out the list of nearby objects
N $7C14 In: ---
N $7C14 Out: b =$00
N $7C14 a =$00
N $7C14 de =$LenSlotObj
N $7C14 ix - undefined
C $7C14,4 length 27h
C $7C18,4 station is no longer hostile
C $7C1D,3 set PlayerPirate
C $7C20,3 '''
c $7C2D RestorePilotFromMemory
N $7C2D Restore pilot data from memory
N $7C2D In: ---
N $7C2D Out: bc =$0000
N $7C2D hl,de - undefined
C $7C2D,3 for keeping the last loaded game in memory
C $7C30,3 1..11 pilot name
C $7C33,3 'f' ; 102 bytes
b $7C39
B $7C39,1 =$01 G or H pressed (jump)
@ $7C3A label=CircleCrdY
B $7C3A,1 distance from the circle center to the screen center along Y
@ $7C3B label=CircleCrdX
B $7C3B,1 distance from the circle center to the screen center along X
@ $7C3C label=CircleFlg
N $7C3C Circle drawing flags:
N $7C3C bit 0: 0 = X offset negative, 1 = X offset positive
N $7C3C bit 1: 0 = Y offset negative, 1 = Y offset positive
N $7C3C bit 2: whether the X extent needs clipping against the viewport edge
N $7C3C bit 3: whether the Y extent needs clipping against the viewport edge
B $7C3C,1 circle flags
@ $7C3D label=CircleRadius
B $7C3D,1 circle radius
@ $7C3E label=CircleCrdY_temp
B $7C3E,1 temporary: distance to the screen center along Y
@ $7C3F label=CircleCrdX_temp
B $7C3F,1 temporary: distance to the screen center along X
@ $7C40 label=CircleCrdY_prn
B $7C40,1 print Y coordinate of the circle center
@ $7C41 label=CircleCrdX_prn
B $7C41,1 print X coordinate of the circle center
@ $7C42 label=CircleDeltaY
B $7C42,1 point where the circle intersects the left/right screen edge, relative to the coordinate center
@ $7C43 label=SaveSPcircle
W $7C43,2
@ $7C45 label=SaveHL3
W $7C45,2
@ $7C47 label=SaveA7
B $7C47,1 byte to print
@ $7C48 label=DirPrnCircle
B $7C48,1 =0 print upward =1 print downward
@ $7C49 label=FillCircle
B $7C49,1 =1 draw an unfilled circle =0 filled
B $7C4A,1 number of bytes to modify in the circle-printing routine
c $7C4B half_rClip_Down
N $7C4B Print a half-circle by OR (circle extends past the right X boundary).
N $7C4B The midpoint/Bresenham error term and step deltas are kept in the alternate register set (hl', bc', e', reached via exx), freeing the primary registers for screen addressing.
N $7C4B In: b - left byte to print
N $7C4B c - right byte to print
N $7C4B hl - address to print the right byte
N $7C4B hl - address to print the left byte
N $7C4B e' =0
N $7C4B c' =0 minus radius
N $7C4B Out: hl,de,bc,hl',de',bc' - ????
C $7C56,3 set DirPrnCircle
C $7C59,3 get FillCircle
C $7C5D,3 print an unfilled half-circle by OR (circle extends past the right X boundary)
C $7C60,3 print a filled half-circle by OR (circle extends past the right X boundary)
c $7C63 half_rClip_Up
N $7C63 Print a half-circle by OR (circle extends past the right X boundary).
N $7C63 The midpoint/Bresenham error term and step deltas are kept in the alternate register set (hl', bc', e', reached via exx), freeing the primary registers for screen addressing.
N $7C63 In: b - left byte to print
N $7C63 c - right byte to print
N $7C63 hl - address to print the right byte
N $7C63 hl - address to print the left byte
N $7C63 e' =0
N $7C63 c' =0 minus radius
N $7C63 Out: hl,de,bc,hl',de',bc' - ????
C $7C6D,3 set DirPrnCircle
C $7C70,3 get FillCircle
C $7C74,3 print an unfilled half-circle by OR (circle extends past the right X boundary)
C $7C77,3 print a filled half-circle by OR (circle extends past the right X boundary)
c $7C7A half_lClip_Down
N $7C7A Print a half-circle by OR (circle extends past the left X boundary).
N $7C7A The midpoint/Bresenham error term and step deltas are kept in the alternate register set (hl', bc', e', reached via exx), freeing the primary registers for screen addressing.
N $7C7A In: b - left byte to print
N $7C7A c - right byte to print
N $7C7A hl - address to print the right byte
N $7C7A hl - address to print the left byte
N $7C7A e' =0
N $7C7A c' =0 minus radius
N $7C7A Out: hl,de,bc,hl',de',bc' - ????
C $7C85,3 set DirPrnCircle
C $7C88,3 get FillCircle
C $7C8C,3 print an unfilled half-circle by OR (circle extends past the left X boundary)
C $7C8F,3 print a filled half-circle by OR (circle extends past the left X boundary)
c $7C92 half_lClip_Up
N $7C92 Print a half-circle by OR (circle extends past the left X boundary).
N $7C92 The midpoint/Bresenham error term and step deltas are kept in the alternate register set (hl', bc', e', reached via exx), freeing the primary registers for screen addressing.
N $7C92 In: b - left byte to print
N $7C92 c - right byte to print
N $7C92 hl - address to print the right byte
N $7C92 hl - address to print the left byte
N $7C92 e' =0
N $7C92 c' =0 minus radius
N $7C92 Out: hl,de,bc,hl',de',bc' - ????
C $7C9C,3 set DirPrnCircle
C $7C9F,3 get FillCircle
C $7CA3,3 print an unfilled half-circle by OR (circle extends past the left X boundary)
C $7CA6,3 print a filled half-circle by OR (circle extends past the left X boundary)
c $7CA9 half_NoClip_Down
N $7CA9 Print a half-circle by OR (circle stays within X boundaries).
N $7CA9 The midpoint/Bresenham error term and step deltas are kept in the alternate register set (hl', bc', e', reached via exx), freeing the primary registers for screen addressing.
N $7CA9 In: b - left byte to print
N $7CA9 c - right byte to print
N $7CA9 hl - address to print the right byte
N $7CA9 hl - address to print the left byte
N $7CA9 e' =0
N $7CA9 c' =0 minus radius
N $7CA9 Out: hl,de,bc,hl',de',bc' - ????
C $7CB4,3 set DirPrnCircle
C $7CB7,3 get FillCircle
C $7CBB,3 print an unfilled half-circle by OR (circle stays within X boundaries)
C $7CBE,3 print a filled half-circle by OR (circle stays within X boundaries)
c $7CC1 half_NoClip_Up
N $7CC1 Print a half-circle by OR (circle stays within X boundaries).
N $7CC1 The midpoint/Bresenham error term and step deltas are kept in the alternate register set (hl', bc', e', reached via exx), freeing the primary registers for screen addressing.
N $7CC1 In: b - left byte to print
N $7CC1 c - right byte to print
N $7CC1 hl - address to print the right byte
N $7CC1 hl - address to print the left byte
N $7CC1 e' =0
N $7CC1 c' =0 minus radius
N $7CC1 Out: hl,de,bc,hl',de',bc' - ????
C $7CCB,3 set DirPrnCircle
C $7CCE,3 get FillCircle
C $7CD2,3 print an unfilled half-circle by OR (circle stays within X boundaries)
C $7CD5,3 print a filled half-circle by OR (circle stays within X boundaries)
c $7CD8 Fill_Up
N $7CD8 Fill/dry-run the view screen upward from a given Y coordinate
N $7CD8 In: b - window height in pixels
N $7CD8 a - Y coordinate in pixels
N $7CD8 Out: hl - address of the window's top border
C $7CD9,3 get FillCircle
C $7CDE,3 dry-run fill of the view screen upward from a given Y coordinate
C $7CE1,3 fill the view screen upward from a given Y coordinate with byte $FF
c $7CE4 Fill_Down
N $7CE4 Fill/dry-run the view screen downward from a given Y coordinate
N $7CE4 In: b - window height in pixels
N $7CE4 a - Y coordinate in pixels
N $7CE4 Out: hl - address of the window's top border
C $7CE5,3 get FillCircle
C $7CEA,3 dry-run fill of the view screen downward from a given Y coordinate
C $7CED,3 fill the view screen downward from a given Y coordinate with byte $FF
c $7CF0 PrnCircle_Fill
N $7CF0 Print a circle on screen/in the buffer
N $7CF0 In: (CircleFlg) - flags
N $7CF0 (CircleRadius) - radius
N $7CF0 (CircleCrdY) - center coordinates
N $7CF0 (FillCircle) =0 draw a filled circle
N $7CF0 =1 draw an unfilled circle
N $7CF0 Out: circle printed
N $7CF0 Circles smaller than radius 9 are rejected outright (presumably drawn elsewhere as a fixed dot sprite).
N $7CF0 Every circle is plotted with a plain OR into screen memory; there is no XOR/blend-mode switch.
C $7CF0,3 get CircleRadius
C $7CF8,3 set FillCircle
@ $7CFE label=PrnCircle_NoFill
C $7CFE,3 get CircleRadius
@ $7D04 label=PrnCircle_NoFill_NoRadius
C $7D06,3 set FillCircle
C $7D09,3 print a circle on screen/in the buffer
c $7D0E PrnCircle_Clip
N $7D0E Print a circle on screen/in the buffer
N $7D0E In: (CircleFlg) - flags
N $7D0E (CircleRadius) - radius
N $7D0E (CircleCrdY) - center coordinates
N $7D0E (FillCircle) =0 draw a filled circle
N $7D0E =1 draw an unfilled circle
N $7D0E Out: circle printed
C $7D0E,4 get CircleCrdY
C $7D12,4 set CircleCrdY_temp
C $7D16,4 get CircleFlg
C $7D1A,2 '@'
C $7D23,3 set CircleCrdY_prn
C $7D2F,3 set CircleCrdX_prn
C $7D33,2 '@'
C $7D39,2 'x'
C $7D5A,2 'x'
C $7D5C,3 circle stays within X boundaries, inlined into subroutine 7CF0
C $7D63,2 'x'
C $7D68,3 the circle's boundaries extend past both X edges
C $7D6C,2 'x'
C $7D6F,3 set CircleCrdX_temp
C $7D7F,2 '@'
C $7D82,3 set CircleCrdY_temp
C $7D89,3 Squaring
C $7D8F,3 Squaring
C $7D94,2 'x'
C $7D97,3 Squaring
C $7D9C,3 b - dX c - dY
C $7DA0,2 'x'
C $7DA3,3 Squaring
C $7DA8,3 center goes outside the Y boundaries
C $7DAF,2 'x'
C $7DB3,2 '@'
C $7DB6,4 set CircleCrdY_temp
C $7DBB,3 Squaring
C $7DC1,3 Squaring
C $7DC8,3 Squaring
C $7DD4,3 Squaring
c $7DDF Sqr_DE_A
N $7DDF Squaring
N $7DDF In: A - number
N $7DDF Out: DE=A^2
c $7DE8
N $7DE8 Circle stays within X boundaries
N $7DE8 inlined into subroutine 7CF0
C $7DE8,3 determine the edge byte data and print addresses
C $7DEB,3 print a half-circle by OR (circle stays within X boundaries)
C $7DEE,3 determine the edge byte data and print addresses
C $7DF1,3 print a half-circle by OR (circle stays within X boundaries)
c $7DF4 CalcAddr_noClip
N $7DF4 Determine the edge byte data and print addresses
N $7DF4 In: ---
N $7DF4 Out: b - left byte to print
N $7DF4 c - right byte to print
N $7DF4 hl - address to print the right byte
N $7DF4 hl - address to print the left byte
N $7DF4 c' - 0 minus radius
N $7DF4 e' - =0
C $7DF4,4 get CircleCrdY_prn
C $7DF8,4 get CircleFlg
C $7DFD,2 d - radius
C $7E00,1 c' - 0 minus radius
C $7E01,2 e' =0
C $7E05,1 a = crdX - radius
C $7E06,3 determine left byte data and print address
C $7E09,3 get CircleCrdY_prn
C $7E0D,3 get CircleCrdX_prn
C $7E11,3 determine right byte data and print address
c $7E14
C $7E15,2 'x'
C $7E18,3 set CircleCrdX_temp
C $7E1E,2 the circle's boundaries extend past both X edges
C $7E23,2 'x'
C $7E26,3 calculate a leg using the Pythagorean theorem
C $7E29,3 set CircleDeltaY
C $7E2D,3 get CircleCrdY_prn
C $7E30,3 fill/dry-run the view screen upward from a given Y coordinate
C $7E39,3 get CircleFlg
C $7E3E,3 print a half-circle by OR (circle extends past the left X boundary)
C $7E41,3 print a half-circle by OR (circle extends past the right X boundary)
C $7E44,3 get CircleDeltaY
C $7E48,3 get CircleCrdY_prn
C $7E4B,3 fill/dry-run the view screen downward from a given Y coordinate
C $7E54,3 get CircleFlg
C $7E59,3 print a half-circle by OR (circle extends past the left X boundary)
C $7E5C,3 print a half-circle by OR (circle extends past the right X boundary)
c $7E60
C $7E61,2 'x'
C $7E64,3 set CircleCrdX_temp
C $7E6A,1 center goes outside the Y boundaries
C $7E6B,2 'w'
C $7E6E,4 get CircleFlg
C $7E72,2 'x'
C $7E75,3 calculate a leg using the Pythagorean theorem
C $7E78,3 set CircleDeltaY
C $7E82,3 fill/dry-run the view screen downward from a given Y coordinate
C $7E8B,3 get CircleFlg
C $7E90,3 print a half-circle by OR (circle extends past the left X boundary)
C $7E93,3 print a half-circle by OR (circle extends past the right X boundary)
C $7E99,3 fill/dry-run the view screen upward from a given Y coordinate
C $7EA2,3 get CircleFlg
C $7EA7,3 print a half-circle by OR (circle extends past the left X boundary)
C $7EAA,3 print a half-circle by OR (circle extends past the right X boundary)
c $7EAE
C $7EAF,2 'x'
C $7EB1,3 set CircleCrdX_temp
C $7EB9,2 'w'
C $7EC0,3 determine the edge byte data and print addresses
C $7EC3,3 print a half-circle by OR (circle extends past the right X boundary)
C $7EC6,3 determine the edge byte data and print addresses
C $7EC9,3 print a half-circle by OR (circle extends past the right X boundary)
C $7ECC,3 determine the edge byte data and print addresses
C $7ECF,3 print a half-circle by OR (circle extends past the left X boundary)
C $7ED2,3 determine the edge byte data and print addresses
C $7ED5,3 print a half-circle by OR (circle extends past the left X boundary)
c $7ED8
C $7ED9,2 'x'
C $7EDB,3 set CircleCrdX_temp
C $7EE3,2 'w'
C $7EE6,4 get CircleFlg
C $7EEB,3 calculate a leg using the Pythagorean theorem
C $7EEE,3 set CircleDeltaY
C $7EF4,3 get CircleDeltaY
C $7EFF,3 get CircleDeltaY
C $7F0E,3 determine left byte data and print address
C $7F11,3 get FillCircle
C $7F24,3 get CircleFlg
C $7F29,3 print a half-circle by OR (circle extends past the right X boundary)
C $7F2C,3 print a half-circle by OR (circle extends past the right X boundary)
C $7F30,3 get CircleDeltaY
C $7F41,3 determine right byte data and print address
C $7F4A,3 get FillCircle
C $7F53,3 get CircleFlg
C $7F58,3 print a half-circle by OR (circle extends past the left X boundary)
C $7F5B,3 print a half-circle by OR (circle extends past the left X boundary)
c $7F5F
N $7F5F B - dX
N $7F5F c - dY
C $7F5F,4 get CircleFlg
C $7F64,3 calculate a leg using the Pythagorean theorem
C $7F67,3 set CircleDeltaY
C $7F6D,3 get CircleDeltaY
C $7F7B,3 set CircleCrdY_prn
C $7F7F,3 get CircleDeltaY
C $7F83,3 get CircleCrdX_prn
C $7F87,3 determine left byte data and print address
C $7F8A,3 get CircleCrdY_prn
C $7F8E,3 get CircleDeltaY
C $7F92,3 get CircleCrdX_prn
C $7F96,3 determine right byte data and print address
C $7F99,3 get CircleFlg
C $7F9E,3 print a half-circle by OR (circle stays within X boundaries)
C $7FA1,3 print a half-circle by OR (circle stays within X boundaries)
c $7FA5 CalcAddr_rClip
N $7FA5 Determine the edge byte data and print addresses
N $7FA5 In: ---
N $7FA5 Out: b - left byte to print
N $7FA5 c - right byte to print
N $7FA5 hl - address to print the right byte
N $7FA5 hl - address to print the left byte
N $7FA5 c' - 0 minus radius
N $7FA5 e' - =0
C $7FA5,3 set up registers for printing a circle
C $7FA8,3 get CircleCrdY_prn
C $7FB0,3 determine left byte data and print address
C $7FB3,3 get FillCircle
C $7FB7,3 continuation of subroutine CalcAddr_rClip
c $7FC1 CalcAddr_lClip
N $7FC1 Determine the edge byte data and print addresses
N $7FC1 In: ---
N $7FC1 Out: b - left byte to print
N $7FC1 c - right byte to print
N $7FC1 hl - address to print the right byte
N $7FC1 hl - address to print the left byte
N $7FC1 c' - 0 minus radius
N $7FC1 e' - =0
C $7FC1,3 set up registers for printing a circle
C $7FC4,3 get CircleCrdY_prn
C $7FCC,3 determine right byte data and print address
C $7FD6,3 get FillCircle
c $7FE3 SetVars4Circle
N $7FE3 Set up registers for printing a circle
N $7FE3 In: ----
N $7FE3 Out: d - radius
N $7FE3 e - print flags
N $7FE3 c - distance along Y from screen center
N $7FE3 b - distance along X from screen center
N $7FE3 c' =0 minus radius
N $7FE3 e' =0
C $7FE3,4 get CircleCrdY_temp
C $7FE7,4 get CircleFlg
c $7FF4 CalcLeftAddrCircle
N $7FF4 Determine left byte data and print address
N $7FF4 In: c - crdY (circle center coordinate)
N $7FF4 a - crdX-radius (left boundary coordinate of the circle)
N $7FF4 Out: b - left byte to print
N $7FF4 hl - print address
N $7FF4 e - low byte of the left-byte print address
C $7FF7,3 hl - address
C $7FFA,2 print into the buffer
C $7FFC,1 b - bit within the byte
C $7FFD,3 get FillCircle
C $8002,3 continuation of CalcLeftAddrCircle
c $800F CalcRightAddrCircle
N $800F Determine right byte data and print address
N $800F In: c - crdY (circle center coordinate)
N $800F a - crdX+radius (right boundary coordinate of the circle)
N $800F b - left byte to print
N $800F e - low byte of the left-byte print address
N $800F Out: b - left byte to print
N $800F c - right byte to print
N $800F hl - address to print the right byte
N $800F hl - address to print the left byte
C $8011,3 set SaveA7
C $8022,3 get FillCircle
C $8027,3 continuation of CalcRightAddrCircle
C $8031,3 get SaveA7
c $8036 CalcAddr_lrClip1
C $8036,4 get CircleCrdY_temp
C $803A,2 136
C $803F,3 get CircleDeltaY
c $8045 CalcAddr_lrClip2
C $8045,3 get FillCircle
c $8057 FillBuffUp
N $8057 Fill the view screen upward from a given Y coordinate with byte $FF
N $8057 In: b - window height in pixels
N $8057 a - Y coordinate in pixels
N $8057 Out: hl - address of the window's top border
C $8090,2 ' '
c $80A2 FillBuffDown
N $80A2 Fill the view screen downward from a given Y coordinate with byte $FF
N $80A2 In: b - window height in pixels
N $80A2 a - Y coordinate in pixels
N $80A2 Out: hl - address of the window's bottom border
C $80DB,2 ' '
c $80ED CalcCatet
N $80ED Calculate a leg using the Pythagorean theorem
N $80ED In: d - hypotenuse length
N $80ED a - leg length
N $80ED Out: a - length of the other leg
C $80F2,3 Squaring
C $80F8,3 Squaring
C $8107,3 Squaring
c $8117 half_NoClip_Fill
N $8117 Print a filled half-circle by OR (circle stays within X boundaries)
N $8117 In: b - left byte to print
N $8117 c - right byte to print
N $8117 hl - address to print the right byte
N $8117 hl - address to print the left byte
N $8117 hl' =0
N $8117 de' =0
N $8117 b' =FF
N $8117 c' =0 minus radius
N $8117 (DirectionPrnCircle) =0 print upward / =1 print downward
N $8117 Out: hl,de,bc,hl',de',bc',a - ????
C $811B,3 get DirPrnCircle
C $8133,1 fill the line with $FF
C $814C,3 fill texture
N $8151 Self-modifying PUSH AF cascade: the byte count for this scanline's span is turned into an offset and patched into the operand of a JR instruction just above, so it jumps into the middle of a run of 16 back-to-back PUSH AF instructions; SP is temporarily repointed at the destination screen address so each PUSH AF writes 2 bytes straight into screen memory instead of a real stack.
C $8163,3 get DirPrnCircle
C $8171,3 calculate the previous address in the buffer/screen and exit the drawing routine when the boundary is reached
C $817A,3 calculate the next address in the buffer/screen and exit the drawing routine when the boundary is reached
C $8195,3 fill the line with $FF
C $81F5,3 fill texture
N $81FA Self-modifying PUSH AF cascade: the byte count for this scanline's span is turned into an offset and patched into the operand of a JR instruction just above, so it jumps into the middle of a run of 16 back-to-back PUSH AF instructions; SP is temporarily repointed at the destination screen address so each PUSH AF writes 2 bytes straight into screen memory instead of a real stack.
C $820C,3 get DirPrnCircle
C $821A,3 calculate the previous address in the buffer/screen and exit the drawing routine when the boundary is reached
C $8223,3 calculate the next address in the buffer/screen and exit the drawing routine when the boundary is reached
c $8228 half_lClip_Fill
N $8228 Print a filled half-circle by OR (circle extends past the left X boundary)
N $8228 In: b - left byte to print
N $8228 c - right byte to print
N $8228 hl - address to print the right byte
N $8228 hl - address to print the left byte
N $8228 hl' =0
N $8228 de' =0
N $8228 b' =FF
N $8228 c' =0 minus radius
N $8228 (DirectionPrnCircle) =0 print upward / =1 print downward
N $8228 Out: hl,de,bc,hl',de',bc',a - ????
C $8228,3 get DirPrnCircle
C $8254,3 fill texture
N $8259 Self-modifying PUSH AF cascade: the byte count for this scanline's span is turned into an offset and patched into the operand of a JR instruction just above, so it jumps into the middle of a run of 16 back-to-back PUSH AF instructions; SP is temporarily repointed at the destination screen address so each PUSH AF writes 2 bytes straight into screen memory instead of a real stack.
C $826B,3 get DirPrnCircle
C $8279,3 calculate the previous address in the buffer/screen and exit the drawing routine when the boundary is reached
C $8282,3 calculate the next address in the buffer/screen and exit the drawing routine when the boundary is reached
C $82FE,3 fill texture
N $8303 Self-modifying PUSH AF cascade: the byte count for this scanline's span is turned into an offset and patched into the operand of a JR instruction just above, so it jumps into the middle of a run of 16 back-to-back PUSH AF instructions; SP is temporarily repointed at the destination screen address so each PUSH AF writes 2 bytes straight into screen memory instead of a real stack.
C $8315,3 get DirPrnCircle
C $8323,3 calculate the previous address in the buffer/screen and exit the drawing routine when the boundary is reached
C $832C,3 calculate the next address in the buffer/screen and exit the drawing routine when the boundary is reached
c $8331 half_rClip_Fill
N $8331 Print a filled half-circle by OR (circle extends past the right X boundary)
N $8331 In: b - left byte to print
N $8331 c - right byte to print
N $8331 hl - address to print the right byte
N $8331 hl - address to print the left byte
N $8331 hl' =0
N $8331 de' =0
N $8331 b' =FF
N $8331 c' =0 minus radius
N $8331 (DirectionPrnCircle) =0 print upward / =1 print downward
N $8331 Out: hl,de,bc,hl',de',bc',a - ????
C $8331,3 get DirPrnCircle
C $835F,3 fill texture
N $8364 Self-modifying PUSH AF cascade: the byte count for this scanline's span is turned into an offset and patched into the operand of a JR instruction just above, so it jumps into the middle of a run of 16 back-to-back PUSH AF instructions; SP is temporarily repointed at the destination screen address so each PUSH AF writes 2 bytes straight into screen memory instead of a real stack.
C $8376,3 get DirPrnCircle
C $8384,3 calculate the previous address in the buffer/screen and exit the drawing routine when the boundary is reached
C $838D,3 calculate the next address in the buffer/screen and exit the drawing routine when the boundary is reached
C $83FD,3 fill texture
N $8402 Self-modifying PUSH AF cascade: the byte count for this scanline's span is turned into an offset and patched into the operand of a JR instruction just above, so it jumps into the middle of a run of 16 back-to-back PUSH AF instructions; SP is temporarily repointed at the destination screen address so each PUSH AF writes 2 bytes straight into screen memory instead of a real stack.
C $8414,3 get DirPrnCircle
C $8422,3 calculate the previous address in the buffer/screen and exit the drawing routine when the boundary is reached
C $842B,3 calculate the next address in the buffer/screen and exit the drawing routine when the boundary is reached
c $8430 UpAdrBuf_hlde
N $8430 Calculate the previous address in the buffer/screen and exit the drawing routine when the boundary is reached
N $8430 In: de,hl - addresses on screen/in buffer
C $8431,2 ' '
C $8435,2 ' '
C $8445,1 calculate the next address in the buffer/screen and exit the drawing routine when the boundary is reached
C $8446,2 ' '
C $844A,2 ' '
c $8461 PrintCircleMap
N $8461 Draw on the galaxy map a circle of the flight radius reachable with available fuel
N $8461 In: (PrnCrdXCursor) - circle center coordinates
N $8461 (RadiusCircleMap) - circle radius
N $8461 Out: a =$00
N $8461 hl,de,bc - undefined
N $8461 After drawing the map marker, it immediately re-runs the same 32-byte patch loop using Data4CircleEngine instead of Data4CircleMap, repointing the shared circle engine at the 3D flight-view viewport constants before returning, so the very next PrnCircle_Fill call (for the sun/planet disc) draws correctly sized/positioned for that screen.
C $8463,3 get PrnCrdXCursor
C $8472,3 set CircleCrdX
C $8475,3 get PrnCrdYCursor
C $8479,2 '`'
C $847F,2 '`'
C $8482,3 set CircleCrdY
C $8486,3 set CircleFlg
C $848C,3 set CircleRadius
C $8494,3 number of bytes to modify in the circle-printing routine
C $8497,3 modify the routine
C $849A,3 addresses in the circle-printing routine to modify
C $84B0,3 number of bytes to modify in the circle-printing routine
C $84B3,3 revert the routine modification
C $84B6,3 addresses in the circle-printing routine to modify
@ $84C5 label=Data4CircleMap
N $84C5 Viewport clipping-boundary/dimension constants for the Short Range Chart map circle; patched into 32 immediate operands scattered through the shared circle-drawing engine by PrintCircleMap.
b $84C5
B $84C5,32
@ $84E5 label=Data4CircleEngine
N $84E5 Viewport clipping-boundary/dimension constants for the 3D flight-view engine screen; patched into the same 32 operand locations as Data4CircleMap, but for the sun/planet circle instead of the map marker.
B $84E5,32
@ $8505 label=AdrProcCircle
W $8505,64 addresses in the circle-printing routine to modify
c $8545 PrnExplodeObj
N $8545 Visual effect, ship explosion from an energy bomb?
N $8545 direct print to screen
C $8545,3 get FlgObjNear
C $854A,2 '@'
C $854F,2 'O'
C $8554,2 '?'
C $855C,2 'P'
C $8561,4 length 27h
C $856C,2 '0'
C $856E,2 '0'
C $8572,2 00 001 010
C $8574,3 print view-screen attributes
C $857D,3 set CircleCrdY
C $8586,3 set CircleFlg
C $858E,3 print a circle on screen/in the buffer
C $8594,3 get CircleRadius
C $8599,3 set CircleRadius
C $859F,2 00 001 111
C $85A1,3 print view-screen attributes
C $85A8,3 '''
C $85C4,3 print into the buffer
C $85D6,2 'O'
C $85E1,2 '?'
b $85F0
B $85F0,2
@ $85F2 label=DataFillCircle
W $85F2,2 fill texture
c $85F4 PrnCircle_Clip_2
C $85FC,3 get CircleFlg
C $8601,3 print a half-circle by OR (circle extends past the right X boundary)
C $8604,3 print a half-circle by OR (circle extends past the right X boundary)
c $8608 PrnCircle_Clip_3
C $860A,3 get CircleFlg
C $860F,3 print a half-circle by OR (circle extends past the left X boundary)
C $8612,3 print a half-circle by OR (circle extends past the left X boundary)
c $8616 CalcAddr_rClip_2
N $8616 Continuation of subroutine CalcAddr_rClip
c $861F CalcLeftAddrCircle_2
N $861F Continuation of CalcLeftAddrCircle
c $8629 CalcRightAddrCircle_2
N $8629 Continuation of CalcRightAddrCircle
C $8630,3 get SaveA7
c $8635 CalcAddr_lrClip3
c $8640 NoFillBuffUp
N $8640 Dry-run fill of the view screen upward from a given Y coordinate
N $8640 In: b - window height in pixels
N $8640 a - Y coordinate in pixels
N $8640 Out: hl - address of the window's top border
C $865C,2 ' '
c $866E NoFillBuffDown
N $866E Dry-run fill of the view screen downward from a given Y coordinate
N $866E In: b - window height in pixels
N $866E a - Y coordinate in pixels
N $866E Out: hl - address of the window's bottom border
C $868A,2 ' '
c $869C half_rClip_NoFill
N $869C Print an unfilled half-circle by OR (circle extends past the right X boundary)
N $869C In: b - left byte to print
N $869C c - right byte to print
N $869C hl - address to print the right byte
N $869C hl - address to print the left byte
N $869C hl' =0
N $869C de' =0
N $869C b' =FF
N $869C c' =0 minus radius
N $869C (DirectionPrnCircle) =0 print upward / =1 print downward
N $869C Out: hl,de,bc,hl',de',bc',a - ????
C $869C,3 get DirPrnCircle
C $86BA,3 get DirPrnCircle
C $86C4,3 calculate the previous address in the buffer/screen and exit the drawing routine when the boundary is reached
C $86CD,3 calculate the next address in the buffer/screen and exit the drawing routine when the boundary is reached
C $8728,3 get DirPrnCircle
C $8732,3 calculate the previous address in the buffer/screen and exit the drawing routine when the boundary is reached
C $873B,3 calculate the next address in the buffer/screen and exit the drawing routine when the boundary is reached
c $8740 half_NoClip_NoFill
N $8740 Print an unfilled half-circle by OR (circle stays within X boundaries)
N $8740 In: b - left byte to print
N $8740 c - right byte to print
N $8740 hl - address to print the right byte
N $8740 hl - address to print the left byte
N $8740 hl' =0
N $8740 de' =0
N $8740 b' =FF
N $8740 c' =0 minus radius
N $8740 (DirectionPrnCircle) =0 print upward / =1 print downward
N $8740 Out: hl,de,bc,hl',de',bc',a - ????
C $8744,3 get DirPrnCircle
C $8765,3 get DirPrnCircle
C $876F,3 calculate the previous address in the buffer/screen and exit the drawing routine when the boundary is reached
C $8778,3 calculate the next address in the buffer/screen and exit the drawing routine when the boundary is reached
C $87DC,3 get DirPrnCircle
C $87E6,3 calculate the previous address in the buffer/screen and exit the drawing routine when the boundary is reached
C $87EF,3 calculate the next address in the buffer/screen and exit the drawing routine when the boundary is reached
c $883C half_lClip_NoFill
N $883C Print an unfilled half-circle by OR (circle extends past the left X boundary)
N $883C In: b - left byte to print
N $883C c - right byte to print
N $883C hl - address to print the right byte
N $883C hl - address to print the left byte
N $883C hl' =0
N $883C de' =0
N $883C b' =FF
N $883C c' =0 minus radius
N $883C (DirectionPrnCircle) =0 print upward / =1 print downward
N $883C Out: hl,de,bc,hl',de',bc',a - ????
C $883C,3 get DirPrnCircle
C $8857,3 get DirPrnCircle
C $8861,3 calculate the previous address in the buffer/screen and exit the drawing routine when the boundary is reached
C $886A,3 calculate the next address in the buffer/screen and exit the drawing routine when the boundary is reached
C $88C4,3 get DirPrnCircle
C $88CE,3 calculate the previous address in the buffer/screen and exit the drawing routine when the boundary is reached
C $88D7,3 calculate the next address in the buffer/screen and exit the drawing routine when the boundary is reached
@ $88DC label=J_Drive_Ready2
s $88DC
S $88DC,1
@ $88DD label=J_Drive_Ready3
S $88DD,1
@ $88DE label=CompasPointerCrdX
S $88DE,1
@ $88DF label=CompasPointerCrdY
S $88DF,1
@ $88E0 label=CompasPointerType
S $88E0,1
c $88E1 PrintCompass
N $88E1 Calculate print parameters and draw the compass with pointer on screen
N $88E1 In: ---
N $88E1 Out: b=$00
N $88E1 hl,de,c,a - undefined
C $88E2,3 =1 J-drive unavailable (sun nearby)
C $88E5,4 data for printing the sun, 9 bytes long, crd low x planet
C $88FE,3 calculate distance to an object from its coordinates (vector length)
C $8907,3 =1 J-drive unavailable (sun nearby)
C $8924,3 set FuelScoopsOn
C $8928,3 calculate temperature/altitude from proximity to the sun/planet and set the danger-indicator color
C $892C,3 set Temperature
C $8930,3 =1 J-drive unavailable (planet nearby)
C $8933,4 planet coordinates in space
C $8958,3 =1 J-drive unavailable (planet nearby)
C $895D,3 calculate distance to an object from its coordinates (vector length)
C $8975,3 calculate temperature/altitude from proximity to the sun/planet and set the danger-indicator color
C $897B,3 set Altitude
C $8980,3 set CoriolisNear
C $8983,3 get J_Drive_Coriolis
C $8987,4 length 27h
C $898D,3 calculate distance to an object from its coordinates (vector length)
C $8997,3 calculate the X coordinate for drawing the station icon on the compass
C $899A,3 88DE 7,=1 left 7,=0 right 0-6 =X coordinate increment
C $89A4,3 calculate the X coordinate for drawing the station icon on the compass
c $89A9 CompasCrdNnear
N $89A9 Calculate the X coordinate for drawing the station icon on the compass
N $89A9 In: de - distance to station (vector length)
N $89A9 Out: 7,a - sign
N $89A9 0-6,a - X coordinate increment
N $89A9 hl,de,bc - undefined
c $89B2 PrintCompass2
C $89B3,3 set CoriolisNear
C $89B8,3 calculate distance (vector length) to an object from its coordinates, for far distances
C $89C4,3 calculate the X coordinate for drawing the planet icon on the compass
C $89C7,3 88DE 7,=1 left 7,=0 right 0-6 =X coordinate increment
C $89D1,3 calculate the X coordinate for drawing the planet icon on the compass
C $89D4,3 88DF 7,=1 DownScrAdr 7,=0 UpScrAdr 0-6 =Y coordinate increment
C $89E2,3 =0 print the compass filled
C $89E5,3 draw the compass with pointer on screen
c $89E8 CompasCrdNfar
N $89E8 Calculate the X coordinate for drawing the planet icon on the compass
N $89E8 In: de - distance to station (vector length)
N $89E8 Out: 7,a - sign
N $89E8 0-6,a - X coordinate increment
N $89E8 hl,de,bc - undefined
C $89F3,3 fixed-point division hl.a/de
c $8A09 GameOver
C $8A0B,3 set PlayerGameOver
c $8A0F CalcTempAltitude
N $8A0F Calculate temperature/altitude from proximity to the sun/planet and set the color
N $8A0F of the danger indicator
N $8A0F In: hl = 0 - distance (vector length)
N $8A0F Out: hl = hl*2.5
N $8A0F de,b,a - undefined
C $8A16,1 hl=hl*2.5
C $8A17,3 get IndDanger
C $8A1C,2 'P'
C $8A20,2 'x'
C $8A25,2 'c'
C $8A2C,2 'c'
C $8A36,3 set IndDanger
c $8A3A GetCrdObject
N $8A3A Read object coordinates
N $8A3A In: ix - start address of the object slot
N $8A3A Out: de - crd X (med/low)
N $8A3A bc - crd Y (med/low)
N $8A3A hl - crd Z (med/low)
c $8A4D CalcLenVectorCrdH
N $8A4D Calculate distance (vector length) to an object from its coordinates, for far
N $8A4D distances
N $8A4D In: ix - start address of the object slot +1
N $8A4D Out: hl - distance to the object
N $8A4D =$0000 means more than $FFFF
N $8A4D de,bc,a - undefined
C $8A4D,3 read object coordinates
c $8A5A CalcLenVectorCrd
N $8A5A Calculate distance to an object from its coordinates (vector length)
N $8A5A In: ix - start address of the object slot
N $8A5A Out: hl - distance to the object
N $8A5A =$0000 means more than $FFFF
N $8A5A de,bc,a - undefined
C $8A5A,3 read object coordinates
C $8A83,3 Squaring
C $8A8A,3 Squaring
C $8A92,3 Squaring
C $8AAF,3 extract the square root h=sqr(hl)
C $8ABD,3 extract the square root h=sqr(hl)
c $8AC7 RenewCompass
N $8AC7 Draw the compass with pointer on screen
N $8AC7 In: ---
N $8AC7 Out: b=$00
N $8AC7 hl,de,c,a - undefined
C $8AC7,3 get WhatOnScreen
C $8ACC,1 exit if not in flight
C $8ACD,3 the compass pointer, filled
C $8AD0,3 =0 print the compass filled
C $8AD6,3 the compass pointer, empty
C $8AD9,3 buffer for preparing to print the pointer
C $8AE4,3 88DF 7,=1 DownScrAdr 7,=0 UpScrAdr 0-6 =Y coordinate increment
C $8AE8,2 %01111111
C $8AF5,3 continue calculating the display-file address one pixel above
C $8B02,3 continue calculating the display-file address one pixel below
C $8B07,3 set TempAdrPrnScr
C $8B0A,3 draw an empty compass on screen
C $8B0D,3 88DE 7,=1 left 7,=0 right 0-6 =X coordinate increment
C $8B1C,3 buffer for preparing to print the pointer
C $8B21,2 shift the compass indicator right
C $8B28,2 shift the compass indicator right
C $8B2C,4 get TempAdrPrnScr
C $8B30,3 buffer for preparing to print the pointer
C $8B36,1 print the indicator
C $8B43,3 continue calculating the display-file address one pixel below
C $8B49,2 print the indicator
C $8B4C,3 buffer for preparing to print the pointer
C $8B51,2 shift the compass indicator left
C $8B58,2 shift the compass indicator left
C $8B5C,4 get TempAdrPrnScr
C $8B60,3 buffer for preparing to print the pointer
C $8B66,1 print the indicator
C $8B73,3 continue calculating the display-file address one pixel below
C $8B79,2 print the indicator
c $8B7C compDownScrAdr_HL
N $8B7C Continue calculating the display-file address one pixel below
N $8B7C In: hl - address in the display file
N $8B7C Out: hl - new address
N $8B7C a - undefined
C $8B7D,2 ' '
c $8B86 compUpScrAdr_HL
N $8B86 Continue calculating the display-file address one pixel above
N $8B86 In: hl - address in the display file
N $8B86 Out: hl - new address
N $8B86 a - undefined
C $8B87,2 ' '
c $8B90 PrnCompass
N $8B90 Draw an empty compass on screen
N $8B90 In: ---
N $8B90 Out: b =$00
N $8B90 hl,de,c,a - undefined
C $8B93,3 empty compass image
C $8BA7,3 continue calculating the display-file address one pixel below
@ $8BAE label=TempAdrPrnScr
b $8BAE
W $8BAE,2 for temporarily storing the compass indicator's print address
@ $8BB0 label=TempCompassInd
B $8BB0,8
@ $8BB8 label=CompassIndEmpty
B $8BB8,8
@ $8BC0 label=CompassIndFill
B $8BC0,8
@ $8BC8 label=DataCompass
B $8BC8,72
@ $8C10 label=ScanerCrdXobj
B $8C10,1
@ $8C11 label=ScanerCrdYobj
B $8C11,1
@ $8C12 label=ScanerCrdZobj
B $8C12,1
@ $8C13 label=ScanerNumObj
B $8C13,1
@ $8C14 label=FlgSaveScaner
B $8C14,1 flag to restore the scanner from the buffer =1 restore the scanner from the buffer
c $8C15 DivBC_16
N $8C15 Bc=bc/16
C $8C17,2 bc=bc/2
c $8C19 DivBC_8
N $8C19 Bc=bc/8
C $8C1B,2 bc=bc/2
c $8C1D DivBC_4
N $8C1D Bc=bc/4
C $8C1F,2 bc=bc/2
c $8C21 DivBC_2
N $8C21 Bc=bc/2
C $8C23,2 bc=bc/2
c $8C26
N $8C26 Attributes: thunk
c $8C29 PrintObjScaner
N $8C29 Print objects on the scanner
N $8C29 In: ---
N $8C29 Out: ix,hl,de,bc,a - undefined
C $8C29,3 Restore the scanner from the buffer
C $8C2C,3 get FlgObjNear
C $8C31,3 set indicator color when near a station
C $8C39,4 length 27h
C $8C41,2 no object
C $8C46,2 '@'
C $8C48,2 object is far away
C $8C4D,2 '@'
C $8C4F,2 object is far away
C $8C54,2 '@'
C $8C56,2 object is far away
C $8C5B,3 Squaring
C $8C62,3 Squaring
C $8C65,1 sum of squares
C $8C66,2 object is far away
C $8C6E,2 object is far away
C $8C72,3 set FlgSaveScaner
C $8C7F,3 fixed-point division hl.a/de
C $8C82,3 Bc=bc/8
C $8C87,3 Bc=bc/2
C $8C8A,1 hl=bc/8+bc/16 = bc*3/16
C $8C9F,3 fixed-point division hl.a/de
C $8CA2,3 Bc=bc/16
C $8CA7,3 Bc=bc/4
C $8CBF,3 fixed-point division hl.a/de
C $8CC2,3 Bc=bc/16
C $8CC7,3 Bc=bc/4
C $8D39,3 continue calculating the display-file address one pixel above
C $8D44,3 continue calculating the display-file address one pixel below
C $8D84,3 next object
C $8D87,3 '''
C $8DBB,2 ' '
C $8DC0,2 'X'
C $8DD5,2 ' '
c $8DDE SetIndStation
N $8DDE Set indicator color when near a station
N $8DDE In: ---
N $8DDE Out: hl,de,bc,a - undefined
C $8DDE,3 get FlgCoriolisNear
C $8DE3,3 get IndDanger
C $8DE6,2 'c'
C $8DEE,3 set IndDanger
c $8DF2 CopyScaner2Buf
N $8DF2 Restore (if needed) and save the scanner to the buffer
N $8DF2 used in one place
C $8DF2,3 Restore the scanner from the buffer
C $8DF8,2 ex de,hl
C $8DFE,2 push hl
C $8E06,2 pop hl
C $8E0D,2 '$' ; inc h
C $8E10,1 nop
C $8E15,2 ex de,hl
c $8E1D CopyScaner2Scr
N $8E1D Restore the scanner from the buffer
C $8E1D,3 get FlgSaveScaner
C $8E22,3 set FlgSaveScaner
C $8E25,1 clear the area above the scanner
C $8E3A,1 nop
C $8E3F,2 push de
C $8E47,2 pop de
C $8E4E,2 inc d
C $8E51,2 ex de,hl
C $8E57,1 nop
C $8E8C,3 ' '
c $8E95
N $8E95 Check for keypress (and branch accordingly) for keys 1, 2, 3, 4, I, O, P, K, L, enter
C $8E95,3 get FlgJumpDocking
C $8E9A,3 get ControlKey2
C $8E9F,2 if 1/2/3/4 are not pressed
C $8EA5,2 leaving the planet / front view
C $8EAA,2 buy goods / rear view
C $8EAF,2 sell goods / left view
C $8EB2,3 get IndDanger
C $8EB5,1 buy equipment / right view
C $8EB6,2 jump to switch the view screen
C $8EB8,2 Equip ship menu
C $8EBC,3 switch the view screen
C $8EBF,2 call some menu
C $8EC1,3 call a function by number from any page, returning to this page
C $8EC6,3 switch the view screen
C $8ECB,3 get IndDanger
C $8ED1,3 Docking/Takeoff
C $8ED6,3 switch the view screen
C $8EDB,3 get ControlKey1
C $8EDE,2 '?'
C $8EEC,3 switch the view screen
C $8EF3,2 call the menu
C $8EF5,3 call a function by number from any page, returning to this page
C $8EF9,3 set ControlKey2
C $8EFC,3 set ControlKey1
@ $8F00 label=SaveSP6
b $8F00
W $8F00,2
c $8F02 Call_Function
N $8F02 Call a function by number from any page, returning to this page
N $8F02 In: a - function number in the kernel
N $8F02 Out: depends on the function
C $8F1E,3 clear the keyboard buffer
c $8F21
N $8F21 Switch the view screen
C $8F21,3 get WhatOnScreen
C $8F30,3 get JumpDocking
C $8F37,3 set WhatOnScreen
c $8F42 SaveCockpitInBuffer
N $8F42 Save the cockpit
C $8F43,3 Restore the scanner from the buffer
C $8F47,3 save the cockpit
c $8F5E
C $8F63,3 set WhatOnScreen
s $8F67
c $8F68 ScanKeyInPause
N $8F68 Check for pause keypress and poll the keyboard, changing game modes
N $8F68 In: ----
N $8F68 Out: cy=1 - end of game
C $8F68,3 get ControlKey2
C $8F6E,3 0-1,=00 SXNMA controls (LLFC0F)<>0 reset CS,F,c =01 Kempston controls =10 cursor controls 76850 =11 Sinclair right controls 2,=1 realistic control approximation (reaction) 3,=1 turn inertia on 4,=1 controls inverted 5,=1 up/down inverted 6,=1 Thargon interception on 7,=1 sound on
C $8F72,3 get PressKeyPrnSymbol
C $8F79,3 get PressKeyPrnSymbol
C $8F80,2 'B'
C $8F82,3 Invert controls
C $8F85,2 'D'
C $8F87,3 Turn inertia (toggle)
C $8F8A,2 'F'
C $8F8C,3 Intercept the Thargons
C $8F8F,2 'K'
C $8F91,3 switch controls
C $8F94,2 'Q'
C $8F96,3 Turn off sound
C $8F99,2 'R'
C $8F9B,3 Control-realism approximation system (Reaction)
C $8F9E,2 'S'
C $8FA0,3 Turn on sound
C $8FA3,2 'Y'
C $8FA5,3 Invert up/down
C $8FA8,2 '1'
C $8FAA,2 end the game
C $8FAC,2 ' '
C $8FAE,2 reset the pressed-keys table
C $8FB1,3 sound beep
c $8FB6 PauseOff
N $8FB6 Reset the pressed-keys table
C $8FB6,3 7,=1 - Y -- Cloaking Device 6,=1 - 0 -- ??? 5,=1 - I -- Global Map 4,=1 - O -- Local Map 3,=1 - P -- Planet Info 2,=1 - K -- Planet Price 1,=1 - L -- Commander Info 0,=1 - Enter -- Inventory
c $8FC4 NewGame
N $8FC4 End the game
C $8FC4,3 Reset the pressed-keys table
c $8FC9 InvertControl
N $8FC9 Invert controls
c $8FCF InertionOnOff
N $8FCF Turn inertia (toggle)
c $8FD5 TagroidOnOff
N $8FD5 Intercept the Thargons
c $8FDB SFX_OFF
N $8FDB Turn off sound
c $8FE1 ReactionOnOff
N $8FE1 Control-realism approximation system (Reaction)
c $8FE7 SFX_ON
N $8FE7 Turn on sound
C $8FEC,3 set nBeepFX
c $8FF0 InvertUpDown
N $8FF0 Invert up/down
c $8FF6
N $8FF6 Switch controls
c $9009
N $9009 Sound beep
N $9009 In: ----
N $9009 Out: ----
C $9017,2 '0'
b $902B
B $902B,1
W $902C,2
W $902E,2
c $9030 FX_Launch
N $9030 Takeoff/docking sound
C $9030,3 get FlagsSetUp
C $9035,1 exit if sound is off
c $903B
N $903B Sound
C $903B,3 get FlagsSetUp
c $9046
N $9046 Hyperjump sound
C $9046,3 get FlagsSetUp
C $904C,3 play the sound
c $9051
N $9051 Player-destroyed sound
C $9051,3 get FlagsSetUp
C $9065,3 set nBeepFX
C $906A,3 sound routine
C $906D,3 sound
C $9070,3 sound
C $9076,3 sound
C $907C,3 sound
C $907F,3 sound
c $9082
N $9082 Sound output
C $9082,3 get FlagsSetUp
C $908E,3 get nBeepFX
C $909F,3 sound routine
C $90A9,3 sound
C $90AD,2 sound
c $90AF
C $90B6,2 '@'
c $90D8
c $90F0
N $90F0 Sound
C $90F7,2 'd'
C $9101,2 '0'
C $9127,3 which sound to play =$00 no sound (silent) 0,=1 energy bomb exploded 1,=1 missile launched 2,=1 colliding with an object/object destroyed 3,=1 laser fired 4,=1 laser fired 5,=1 ECM working 6,=1 hit by laser on the player/docking damage 7,=1
c $912D
N $912D Sound
C $9138,2 '0'
c $914A
N $914A Sound
c $9160
N $9160 Sound
c $917D
N $917D Sound
C $9188,2 '@'
c $919B
N $919B Sound
c $91A4
c $91B2
c $91C0
N $91C0 Play the sound
s $91C8
S $91C8,10
@ $91D2 label=DataOfStars
S $91D2,32
@ $91F2 label=TableBasePrice
S $91F2,68
@ $9236 label=BasePriceEquip
S $9236,1
S $9237,41
c $9260 UseEnergyBomb
N $9260 Energy bomb explosion
C $9260,3 get ControlKey3
C $9266,3 Energy bomb
C $926F,3 set EnergyBombUsed
C $9272,3 which sound to play =$00 no sound (silent) 0,=1 energy bomb exploded 1,=1 missile launched 2,=1 colliding with an object/object destroyed 3,=1 laser fired 4,=1 laser fired 5,=1 ECM working 6,=1 hit by laser on the player/docking damage 7,=1
C $9277,2 view-screen flicker
C $9279,3 paper 5, ink 0
C $9280,2 paper 5, ink 0
C $9282,3 Fast attribute set on the view screen
C $9285,2 paper 7, ink 1
c $9287 SetAtrViewScr
N $9287 Print view-screen attributes
N $9287 In: l - attribute
N $9287 Out: b=$00
N $9287 a=$00
N $9287 hl - ????
C $9287,3 get CloakingDeviceOn
C $928B,2 fast attribute set on the view screen l - attribute
C $928E,2 Paper 0 Ink unchanged
c $9291 FastSetAtrInViewScr
N $9291 Fast attribute set on the view screen
N $9291 l - attribute
C $9291,3 get PilotMission1
C $9297,1 mission 1 given, paper unchanged, ink 2/0
@ $92B5 label=SaveSP4
s $92B5
S $92B5,2
@ $92B7 label=TextMessages2
S $92B7,1710
@ $9965 label=StarsFastScroll
S $9965,1
c $9966 Use_J_Drive
N $9966 Movement on the J-drive
C $9966,3 get ControlKey2
C $996E,3 set ControlKey2
C $9973,3 =1 J-drive unavailable (sun nearby)
C $9978,3 =1 J-drive unavailable (planet nearby)
C $997D,3 get J_Drive_Ready4
C $9982,3 get J_Drive_Coriolis
C $9988,3 set PilotMission2
C $998B,4 extraneous
C $998F,3 zero out the list of nearby objects
C $9992,3 get StarsRndCrd
C $9996,3 set StarsRndCrd
C $999D,3 set FrameCounter
C $99A0,3 for stars only =1 J-drive running, stars move fast
C $99A3,4 data for printing the sun, 9 bytes long, crd low x planet
C $99A7,3 fast move away from/toward the sun/planet/station, only crd z changes
C $99AA,4 planet coordinates in space
C $99AE,3 fast move away from/toward the sun/planet/station, only crd z changes
C $99B1,4 length 27h
c $99B5
N $99B5 Fast move away from/toward the sun/planet/station
N $99B5 only crd z changes
C $99B5,3 ' '
C $99B8,3 crd z
@ $99F7 label=StarsAngleLR
b $99F7
B $99F7,1 star rotation (player's rotation angles) $00..$0F
@ $99F8 label=StarsAngleDU
B $99F8,1 $00..$0F
B $99F9,1 for intermediate storage in the star routine
B $99FA,1 for stars =0 front/rear =1 left/right
@ $99FB label=AdrDataStar
W $99FB,2 address of the current star's data
@ $99FD label=StarsSpeed
B $99FD,1 star speed $01..$10 (player's speed /2 +1)
@ $99FE label=wrkStarCrdXl
B $99FE,1 +3 DataStars
@ $99FF label=wrkStarCrdXh
B $99FF,1 +0 DataStars
@ $9A00 label=wrkStarCrdYl
B $9A00,1 +4 DataStars
@ $9A01 label=wrkStarCrdYh
B $9A01,1 +1 DataStars
@ $9A02 label=wrkSpeedStar
B $9A02,1 +2 DataStars
@ $9A03 label=StarsPrevViewScr
B $9A03,1 view-screen number the stars are calculated for (inlined into the routine)
@ $9A04 label=StarsMax
B $9A04,1 maximum number of stars displayed
@ $9A05 label=AdrInStarsBuf
W $9A05,2 address in the buffer of print addresses for the current star
@ $9A07 label=StarsFlg
B $9A07,1 current star's flags 7,=1 CrdX negative 6,=1 CrdY negative 5,=1 =0/1 front/rear 4,=1 rotation negative =0 rotation positive 3,=1 moving down =0 moving up
@ $9A08 label=StarsNumPrn
B $9A08,1 number of stars generated for printing
@ $9A09 label=StarsRndCrd
B $9A09,1 byte to vary the generation of a new star's coordinates
@ $9A0A label=StarsAdrPrnData
B $9A0A,60
c $9A46 InitVarLaunch
N $9A46 Print missiles, init variables, print cockpit attributes accounting for
N $9A46 the presence of an Escape Capsule
C $9A46,3 print missiles on the cockpit
C $9A49,3 clear all messages during flight
C $9A4D,3 set Missile1
C $9A50,3 set TempLaser
C $9A53,3 set Temperature
C $9A56,3 set AutoDocking
C $9A5B,3 set ShieldFront
C $9A5E,3 set ShieldRear
C $9A61,3 set Altitude
C $9A64,3 +0 - current value -1 - value shown on screen
c $9A6E SetAtrCockpitDevice
N $9A6E Set cockpit attributes on screen/in buffer
N $9A6E depending on whether an Escape Capsule is present
C $9A71,3 get WhatOnScreen
C $9A7B,3 get PilotEscapePod
C $9A87,3 set cockpit indicator attributes C - Attribute HL - address in the attribute area DE =1Bh
C $9A8F,2 set cockpit indicator attributes C - Attribute HL - address in the attribute area DE =1Bh
@ $9A9D label=TxtMessages1
b $9A9D
B $9A9D,983
c $9E74 PrintStars
N $9E74 Process and print stars accounting for player movement, including on the J-drive
N $9E74 In: ---
N $9E74 Out: hl,de,bc,hl',de',bc,a - undefined
C $9E74,3 for stars only =1 J-drive running, stars move fast
C $9E78,2 process and print stars accounting for player movement
C $9E7A,3 for stars only =1 J-drive running, stars move fast
C $9E7F,3 set HighDeltaSpeed
C $9E82,3 process and print stars accounting for player movement
C $9E87,3 set HighDeltaSpeed
c $9E8D CalcAndPrnStars
N $9E8D Process and print stars accounting for player movement
N $9E8D In: ---
N $9E8D Out: hl,de,bc,hl',de',bc,a - undefined
C $9E8E,3 set StarsNumPrn
C $9E91,3 for stars =0 front/rear =1 left/right
C $9E94,3 get HighDeltaSpeed
C $9E9A,3 set StarsSpeed
C $9E9D,3 get HighAngleLR
C $9EA0,3 set StarsAngleLR
C $9EA5,3 set StarsMax
C $9EA8,3 get InFreeSpace
C $9EB0,3 set StarsMax
C $9EB3,3 get StarsPrevViewScr
C $9EB7,3 get WhatOnScreen
C $9EBB,3 set StarsPrevViewScr
C $9EBE,3 swap the coordinates of each star
C $9EC1,3 print buffer for stars (16 stars max): +0/1 output address in the buffer +2 byte to output
C $9EC4,3 set AdrInStarsBuf
C $9EC9,3 data for 16 stars
C $9ECC,4 set AdrDataStar
C $9ED9,3 set wrkStarCrdXh
C $9EE6,3 set wrkStarCrdYh
C $9EEB,3 set wrkSpeedStar
C $9EF0,3 set wrkStarCrdXl
C $9EF5,3 set wrkStarCrdYl
C $9EF8,3 get StarsAngleLR
C $9F03,3 set StarsAngleLR
C $9F06,3 get StarsAngleDU
C $9F11,3 set StarsAngleDU
C $9F15,3 set StarsFlg
C $9F18,3 get WhatOnScreen
C $9F1C,3 not front view
C $9F1F,3 get StarsSpeed
C $9F23,3 get wrkStarCrdXh
C $9F28,3 b=0
C $9F2C,3 get StarsSpeed
C $9F30,3 get wrkStarCrdXl
C $9F39,3 get wrkStarCrdXl
C $9F3D,3 set wrkStarCrdXl
C $9F49,3 get wrkSpeedStar
C $9F5E,3 old speed =344/376 +8
C $9F63,3 get StarsFlg
C $9F66,2 ' '
C $9F68,3 get wrkStarCrdXl
C $9F6F,2 'x'
C $9F7C,3 set wrkStarCrdXl
C $9F7F,3 get StarsSpeed
C $9F83,3 get wrkStarCrdYh
C $9F8C,3 get StarsSpeed
C $9F90,3 get wrkStarCrdYl
C $9F99,3 get wrkStarCrdYl
C $9F9D,3 set wrkStarCrdYl
C $9FA7,3 get wrkSpeedStar
C $9FBC,3 old speed =344/376 +8
C $9FC1,3 get StarsFlg
C $9FC4,2 ' '
C $9FC6,3 get wrkStarCrdYl
C $9FCD,2 'x'
C $9FD3,3 generate coordinates for a new star, accounting for ship movement
C $9FDB,3 set wrkStarCrdYl
C $9FDE,3 get StarsSpeed
C $9FE2,3 get StarsFlg
C $9FE5,2 ' '
C $9FE9,3 get wrkSpeedStar
C $9FEF,3 get wrkSpeedStar
C $9FF7,3 set wrkSpeedStar
C $9FFA,3 get StarsAngleLR
C $A002,3 get wrkStarCrdYh
C $A007,3 A=hi(a*c*2)
C $A00D,3 get StarsFlg
C $A034,3 get wrkStarCrdXh
C $A038,2 'x'
C $A03E,3 get wrkStarCrdXh
C $A045,3 set wrkStarCrdXh
C $A048,3 get StarsAngleLR
C $A04C,3 get wrkStarCrdXh
C $A051,3 A=hi(a*c*2)
C $A057,3 get StarsFlg
C $A07C,3 get wrkStarCrdYh
c $A085 Mult_A_hiA_C_2
N $A085 A=hi(a*c*2)
c $A090
C $A090,3 get wrkStarCrdYh
C $A094,2 'x'
C $A096,3 generate coordinates for a new star, accounting for ship movement
C $A099,3 set wrkStarCrdYh
C $A09C,3 get StarsAngleDU
C $A0A4,3 get wrkStarCrdYh
C $A0B1,3 get StarsFlg
C $A0CA,3 for intermediate storage in the star routine
C $A0CD,3 get wrkSpeedStar
C $A0DF,3 set wrkSpeedStar
C $A0E2,3 for intermediate storage in the star routine
C $A0E6,3 get wrkStarCrdXh
C $A0F6,3 set wrkStarCrdXh
C $A0F9,3 get StarsAngleDU
C $A0FD,3 get wrkStarCrdYh
C $A101,3 get StarsFlg
C $A119,3 generate coordinates for a new star, accounting for ship movement
C $A121,3 for intermediate storage in the star routine
C $A12D,3 get StarsFlg
C $A130,2 '@'
C $A132,3 set StarsFlg
C $A136,2 '@'
C $A13A,3 set wrkStarCrdYh
C $A13D,3 get StarsAngleLR
C $A141,3 get wrkStarCrdYh
C $A146,2 '?'
C $A14A,2 '?'
C $A14E,3 convert star coordinates to a print address in the buffer
C $A151,3 get AdrInStarsBuf
C $A15A,3 set AdrInStarsBuf
C $A15D,3 get StarsNumPrn
C $A161,3 set StarsNumPrn
C $A164,3 get AdrDataStar
C $A167,3 get StarsFlg
C $A16B,3 get wrkStarCrdXh
C $A176,3 get wrkStarCrdYh
C $A181,3 get wrkSpeedStar
C $A186,3 get wrkStarCrdXl
C $A18B,3 get wrkStarCrdYl
C $A190,3 set AdrDataStar
C $A193,3 get StarsMax
C $A197,3 print the generated stars
C $A19A,3 set StarsMax
C $A19D,3 get StarsFlg
C $A1A0,2 ';'
C $A1A3,4 get AdrDataStar
C $A1B0,3 set wrkStarCrdXh
C $A1BD,3 set wrkStarCrdYh
C $A1C2,3 set wrkSpeedStar
C $A1C7,3 set wrkStarCrdXl
C $A1CC,3 set wrkStarCrdYl
C $A1D0,3 set StarsFlg
C $A1D3,3 for stars =0 front/rear =1 left/right
C $A1DD,2 for left/right view
C $A1DF,3 for rear view
C $A1E2,2 '8'
C $A1E4,3 set StarsFlg
C $A1EA,1 for left/right view
C $A1ED,3 for stars =0 front/rear =1 left/right
C $A1F1,2 for right view
C $A1F3,3 for left view
C $A208,3 set StarsFlg
C $A20D,3 for right view
C $A222,2 ' '
C $A224,3 set StarsFlg
C $A227,3 get StarsAngleLR
C $A22B,3 get StarsAngleDU
C $A22E,3 set StarsAngleLR
C $A232,3 set StarsAngleDU
C $A235,3 get wrkSpeedStar
C $A239,3 get StarsSpeed
C $A23D,3 generate coordinates for a new star, accounting for ship movement
C $A246,3 get StarsFlg
C $A25B,3 get wrkStarCrdXh
C $A264,3 get wrkStarCrdXh
C $A268,2 'w'
C $A26C,3 set wrkStarCrdXh
c $A272 PrnStarsInBuff
N $A272 Print the generated stars
N $A272 In: ---
N $A272 Out: b =$00
N $A272 hl,de,c,a - undefined
C $A272,3 print buffer for stars (16 stars max): +0/1 output address in the buffer +2 byte to output
C $A275,3 get StarsNumPrn
c $A287 InvertCrdY
C $A28A,3 get StarsFlg
C $A28D,2 '@'
C $A28F,3 set StarsFlg
c $A294 InvertCrdX
C $A297,3 get StarsFlg
C $A29C,3 set StarsFlg
c $A2A1 Mult_HL_A_C
c $A2B5 Stars_Div_hl0_B
N $A2B5 Old (leftover/unused code)
N $A2B5 speed =344/376 +8
N $A2B5 In: al - dividend (at most $1FFF)
N $A2B5 b - divisor
N $A2B5 Out: cd=al.0/b
N $A2B5 a - remainder
N $A2B5 division cd = hl.0/b
N $A2B5 speed =
N $A2B5 In: hl - dividend (at most $1FFF)
N $A2B5 b - divisor
N $A2B5 Out: cd=hl.0/b
N $A2B5 a - remainder
C $A2DA,1 ca=al.0/b
c $A2DB Stars_Div_A0_B
c $A2EF StarCrd2AdrPrn
N $A2EF Convert star coordinates to a print address in the buffer
N $A2EF In: ---
N $A2EF Out: de - address in the screen buffer
N $A2EF b =$00
N $A2EF c - data byte (dot)
N $A2EF hl - print coordinates
C $A2F1,3 get StarsFlg
C $A2F5,3 get wrkStarCrdXh
C $A2F9,3 get wrkStarCrdYh
C $A308,2 '?'
C $A31A,2 '8'
c $A334 CalcNewStar
N $A334 Generate coordinates for a new star, accounting for ship movement
C $A334,3 get RndWord
C $A337,4 get AdrDataStar
C $A33B,3 get WhatOnScreen
C $A33F,2 not front view
C $A341,3 get StarsAngleDU
C $A355,3 A=b=l = CY + hin*2
C $A35C,3 A=b=l = CY + hin*2
C $A365,3 A=b=l = CY + hin*2
C $A36E,2 '?'
C $A378,3 get StarsFlg
C $A38F,3 not rear
C $A392,3 get StarsAngleDU
C $A39D,3 get StarsFlg
C $A3A8,2 '?'
C $A3BB,2 '?'
C $A3C4,3 get StarsRndCrd
C $A3C8,3 set StarsRndCrd
C $A3CD,3 A=b=l = CY + hin*2
C $A3D6,3 A=b=l = CY + hin*2
C $A3DD,3 A=b=l = CY + hin*2
C $A3E6,4 set AdrDataStar
C $A3EA,3 set RndWord
C $A3F0,3 A=b=l = CY + hin*2
C $A3F7,3 A=b=l = CY + hin*2
C $A3FC,2 '?'
C $A402,3 get StarsAngleDU
C $A40D,2 not left
C $A40F,2 'x'
C $A414,2 right view
C $A418,3 A=b=l = CY + hin*2
C $A41F,3 A=b=l = CY + hin*2
C $A42D,3 get StarsRndCrd
C $A431,3 set StarsRndCrd
C $A436,3 A=b=l = CY + hin*2
C $A43D,3 get StarsFlg
C $A444,2 '?'
c $A44C Exchange_CrdX_Y
N $A44C Swap the coordinates of each star
N $A44C In: ---
N $A44C Out: de =$0005
N $A44C b =$00
N $A44C hl,c,a - undefined
C $A44C,3 get StarsMax
C $A450,3 data for 16 stars
c $A465 InRnd_A_HL
N $A465 A=b=l = CY + hin*2
N $A465 h = CY + hin*2 + lin
@ $A46C label=DataStars
s $A46C
S $A46C,80
S $A4BC,1
c $A4BD PrintIndDanger
N $A4BD Print the danger indicator and the missile indicator
N $A4BD In: (IndDanger) - indicator state
N $A4BD Out: b =$00
N $A4BD hl,de,c,a - undefined
C $A4BD,3 <>0 in flight (also the danger indicator color) =0 docked =$04=%00 000 100 leaving the station, in flight (green) =$63=%01 100 011 4th energy unit not full (flashing red)) =$02=%00 000 010 one of the front/rear shields empty (red) =$06=%00 000 110 something nearby (yellow)
C $A4C3,3 get ShieldFront
C $A4C9,3 get ShieldRear
C $A4D0,2 'c'
C $A4D7,2 'c'
C $A4DB,3 counter for the danger indicator's blinking
C $A4E9,3 get WhatOnScreen
C $A4EE,2 menu displayed
C $A4F0,3 view screen on, danger-indicator color
C $A4FF,3 get Missile1
C $A506,2 =1 -> paper 4
C $A511,3 menu displayed
C $A519,3 set CrdXPrnSymbol
C $A528,2 '!'
C $A52A,3 print a message from group 1 in the buffer/on screen
C $A52D,2 '"'
C $A52F,3 print a message from group 1 in the buffer/on screen
C $A53D,2 '$'
C $A53F,3 print a message from group 1 in the buffer/on screen
C $A542,2 '$'
C $A544,3 print a message from group 1 in the buffer/on screen
C $A555,3 set IndDanger
c $A559 Process_MissBombEPod
N $A559 Control missiles, bombs, escape capsule
C $A559,3 get WhatOnScreen
C $A55F,3 Print indicators: danger, station, ECM on the cockpit
C $A562,3 Use of a missile
C $A565,3 Use of the escape capsule
C $A568,3 Energy bomb explosion
C $A56B,3 7,=1 - C -- Docking Computer 6,=1 - Q -- Escape Capsule 5,=1 - W -- Energy Bomb 4,=1 - E -- ECM System 3,=1 - U -- UnTarget 2,=1 - F -- Fire Missile 1,=1 - T -- Target Missile 0,=1 - A -- Fire Laser
c $A572 Damage2Pilot
N $A572 Deal damage to the player's ship
N $A572 In: ---
N $A572 Out: hl,de,bc,a - undefined
C $A572,3 <>0 in flight (also the danger indicator color) =0 docked =$04=%00 000 100 leaving the station, in flight (green) =$63=%01 100 011 4th energy unit not full (flashing red)) =$02=%00 000 010 one of the front/rear shields empty (red) =$06=%00 000 110 something nearby (yellow)
C $A578,3 get ShieldUnit4
C $A57F,2 'c'
C $A581,3 set IndDanger
C $A584,3 restore ship energy
C $A587,3 front shield +0 - current value -1 - value shown on screen
C $A58A,3 get DamageFrontShield
C $A58D,3 decrease front/rear shield and energy-unit power
C $A590,3 rear shield +0 - current value -1 - value shown on screen
C $A593,3 get DamageRearShield
C $A596,3 decrease front/rear shield and energy-unit power
C $A599,3 get CloakingDeviceOn
C $A59D,3 get DamageEnergyUnit
c $A5A6 DecEnergyPlayer
N $A5A6 Decrease ship energy
N $A5A6 energy=energy-(b*c)
N $A5A6 In: c - amount by which the player's energy will decrease
N $A5A6 b - energy-reduction coefficient
N $A5A6 Out: hl,d,b,a - undefined
C $A5A6,3 +0 - current value -1 - value shown on screen
C $A5B8,3 set PlayerGameOver
c $A5C0 DecEnergyShieldFR
N $A5C0 Decrease front/rear shield and energy-unit power
N $A5C0 In: hl - shield address
N $A5C0 a - damage to the shield
N $A5C0 Out: hl,b,a - undefined
C $A5C4,3 damage intensity; if the damage empties the front/rear shield, +5; if that makes it >=$0D, chance of destroying cargo/equipment
C $A5CE,2 'F'
C $A5D0,3 heavy damage. destruction of something (fuel/cargo, etc.)
C $A5E3,3 decrease ship energy energy=energy-(b*c)
C $A5E6,3 damage intensity; if the damage empties the front/rear shield, +5; if that makes it >=$0D, chance of destroying cargo/equipment
C $A5F0,3 heavy damage. destruction of something (fuel/cargo, etc.)
C $A5F6,3 get RndWord
C $A5FB,2 '?'
C $A5FD,3 zero out fuel
C $A608,3 ECM System 7,=1 system on
C $A618,2 'l'
C $A61A,3 message number for what got damaged in combat
C $A61D,3 Set cockpit attributes on screen/in buffer
C $A620,3 7,=1 some equipment/cargo destroyed -> message number goes into nMsgDamage
C $A626,3 19-20 pilot's money (whole thousands) CASH 0..65535 - 0000..65535000
C $A630,3 remaining ship cargo capacity
@ $A639 label=IntensityDamage
s $A639
c $A63A EnergyRecovery
N $A63A Restore ship energy
N $A63A In: ---
N $A63A Out: hl,b,a - undefined
C $A63A,3 get PilotEnergyUnit
C $A641,3 -1 - value shown on screen
C $A651,3 front shield +0 - current value -1 - value shown on screen
C $A657,3 rear shield +0 - current value -1 - value shown on screen
c $A660 PrnDangerEcmDock
N $A660 Print indicators: danger, station, ECM on the cockpit
C $A663,2 nop
C $A665,3 upper-right quarter
C $A668,3 set CrdXPrnSymbol
C $A66B,2 '&'
C $A66D,3 print a message from group 1 in the buffer/on screen
C $A670,3 lower-right quarter
C $A673,3 set CrdXPrnSymbol
C $A676,2 '$'
C $A678,3 print a message from group 1 in the buffer/on screen
C $A67E,3 get TimeWorkECM
C $A684,3 ECM on (4 bytes)
C $A689,3 ECM off (4 bytes)
C $A68C,3 print the ECM system state, station icon, etc. depending on the message and coordinates HL - print coordinates DE - message address
C $A692,3 get CoriolisNear
C $A698,3 icon character for being near a station (4 bytes)
C $A69D,3 icon character for not being near a station (4 bytes)
C $A6A0,3 print the ECM system state, station icon, etc. depending on the message and coordinates HL - print coordinates DE - message address
C $A6A6,2 xor c
C $A6A9,3 print the ECM system state, station icon, etc. depending on the message and coordinates HL - print coordinates DE - message address
C $A6BB,3 print a message from group 1 in the buffer/on screen
b $A6C1
B $A6C1,2
@ $A6C3 label=dataECMon
B $A6C3,4 ECM on (4 bytes)
@ $A6C7 label=dataECMoff
B $A6C7,4 ECM off (4 bytes)
@ $A6CB label=dataDocking
B $A6CB,4 icon character for being near a station (4 bytes)
@ $A6CF label=dataNoDocking
B $A6CF,4 icon character for not being near a station (4 bytes)
c $A6D3 PrintMissiles
N $A6D3 Print missiles on the cockpit
N $A6D3 In: ---
N $A6D3 Out: b= $00
N $A6D3 hl,de,c,a - undefined
C $A6D6,3 display the number of missiles on the cockpit
C $A6DC,2 nop
C $A6DE,3 get PilotMissiles
C $A6E6,2 '%'
C $A6E8,3 display the missile icon
C $A6EE,3 get PilotMissiles
C $A6F6,1 print blank space instead of a missile
C $A6F8,2 '@'
C $A6FA,3 print a message from group 1 in the buffer/on screen
C $A703,2 xor c
c $A706 UseMissile
N $A706 Use of a missile
C $A706,3 get PilotMissiles
C $A70B,3 get Missile1
C $A712,3 =0 missile targeting was on <>0 reverse index of the object the missile is targeting (8 - slot 0)
C $A719,3 get ObjInTarget
C $A720,3 =0 missile not targeted =1 missile ready to lock target =2 missile targeted on something
C $A725,3 'p' ; target-lock sound
C $A728,3 '`'
C $A72E,3 7,=1 - C -- Docking Computer 6,=1 - Q -- Escape Capsule 5,=1 - W -- Energy Bomb 4,=1 - E -- ECM System 3,=1 - U -- UnTarget 2,=1 - F -- Fire Missile 1,=1 - T -- Target Missile 0,=1 - A -- Fire Laser
C $A732,3 =0 missile not targeted =1 missile ready to lock target =2 missile targeted on something
C $A739,2 attempt to target the missile (T key)
C $A73D,2 attempt to launch the missile (F key)
C $A741,2 untarget the missile (U key)
C $A744,1 attempt to target the missile (T key)
C $A74B,3 set nObjMissile
C $A74F,2 untarget the missile (U key)
C $A752,1 attempt to launch the missile (F key)
C $A756,3 get nObjMissile
C $A75D,2 a=xxxx0010=$x2
C $A764,2 if successful
C $A766,3 7,=1 missile launch failed 6-0,= Y print coordinate of the message
C $A76E,3 which sound to play =$00 no sound (silent) 0,=1 energy bomb exploded 1,=1 missile launched 2,=1 colliding with an object/object destroyed 3,=1 laser fired 4,=1 laser fired 5,=1 ECM working 6,=1 hit by laser on the player/docking damage 7,=1
C $A773,3 number of missiles
C $A777,3 print missiles on the cockpit
b $A77A
B $A77A,1
c $A77B UseEscapePod
N $A77B Use of the escape capsule
C $A780,2 launch Escape Capsule
C $A788,3 launch Escape Capsule
C $A78E,3 get PilotEscapePod
C $A793,3 get InFreeSpace
C $A7A0,3 speed $0000..$1FFF
C $A7A4,3 pilot's legal status 0 - clean 1..31h offender 32h..FFh fugitive
C $A7A7,3 set PilotEscapePod
C $A7AA,3 commander data offset +23 (PilotRnd)
C $A7B3,3 +93 extra equipment present 7,=1 - ECM Jammer 6,=1 - Cloaking device 5,=1 - cannot buy goods (refugees in the hold) 4 3 =1 mission 3 was completed 2 =1 - mission 3 completed 1 =1 - mission 2 completed 0 =1 - mission 1 completed
C $A7BA,3 remaining ship cargo capacity
C $A7BD,3 get PilotLargeCargo
C $A7C5,2 '$'
C $A7CD,3 get Pilot_CrdXSystem
C $A7D0,3 set Pilot_CrdXTarget
C $A7D3,3 get Pilot_CrdYSystem
C $A7D6,3 set Pilot_CrdYTarget
C $A7DA,3 goods purchase menu
C $A7DD,3 goods sale menu
C $A7E0,3 equipment purchase menu
C $A7E3,3 print the galaxy map menu
C $A7E6,3 print the local galaxy map
C $A7E9,3 print planet info
C $A7EC,3 print the list of goods on the planet
C $A7EF,3 print info for key 'L'
C $A7F2,3 print the cargo hold contents
C $A7F5,3 decrease the X coordinate and print the small cursor
C $A7F8,3 increase the X coordinate and print the small cursor
C $A7FB,3 increase the Y coordinate and print the small cursor
C $A7FE,3 decrease the Y coordinate and print the small cursor
C $A801,3 position the small cursor at the large cursor's coordinates
C $A804,3 position the cursor on the nearest planet and print its name and distance to it
C $A807,3 search for a planet by its name
@ $A80A label=JumpDocking
b $A80A
B $A80A,1 =1 interplanetary jump/docking =2 intergalactic jump
@ $A80B label=FlgJumpDocking
B $A80B,1 =1 keypress handling disabled, enabled during: docking, the concentric-circles drawing routine is running
@ $A80C label=CloakingDeviceOn
B $A80C,1 =1 Cloaking Device on =1 energy drain while in use
@ $A80D label=CrdXPrnSymbol
B $A80D,1 character print coordinates
@ $A80E label=CrdYPrnSymbol
B $A80E,1
@ $A80F label=Missile1
B $A80F,4 =0 missile not targeted =1 missile ready to lock target =2 missile targeted on something
@ $A813 label=PrnCrdXCursor
B $A813,1 on-screen X coordinate of the small cursor
@ $A814 label=PrnCrdYCursor
B $A814,1 on-screen Y coordinate of the small cursor
@ $A815 label=RadiusCircleMap
B $A815,1
@ $A816 label=PilotName
B $A816,11 1..11 pilot name
@ $A821 label=PilotLegalStatus
B $A821,1 pilot's legal status - clean 1..31h offender 32h..FFh fugitive
@ $A822 label=PilotRating0
B $A822,1 pilot's combat rating 0,0,0...255,8,0 Harmless 0,9,0...255,8,0 M.Harmless 0,17,0...255,16,0 Poor 0,33,0...255,32,0 Average 0,65,0...255,64,0 Above Average 0,129,0...255,128,0 Competent 0,0,3...255,255,2 Dangerous 0,0,11...255,255,10 Deadly 0,0,26...255,255,25 Elite
@ $A823 label=PilotRating1
B $A823,1
@ $A824 label=PilotRating2
B $A824,1
@ $A825 label=JumpCounter
W $A825,2 16-17 jump counter, including intergalactic byte_A872 bit 0-2,=??0 and low =20h..FFh - give mission 1 byte_A872 bit 0-2,=?01 and low =80h..FFh - give mission 2 byte_A872 bit 0-2,=011 and low =FEh..FFh - give mission 3
@ $A827 label=PilotNumGalaxy
B $A827,1 galaxy number
@ $A828 label=PilotCash2
W $A828,2 19-20 pilot's money (whole thousands) CASH 0..65535 - 0000..65535000
@ $A82A label=PilotCash1
W $A82A,2 pilot's money (from 0 to 1000) CASH 0..65535 - 0.0..6553.5
@ $A82C label=PilotRnd
B $A82C,1 ????
@ $A82D label=PilotCargo
B $A82D,3 cargo present in the ship (17 bytes) +00 Food
@ $A830 label=cargoSlaves
B $A830,3 +03 Slaves
@ $A833 label=cargoNarc
B $A833,4 +06 narcotics
@ $A837 label=cargoFirearms
B $A837,5 +0A Firearms
@ $A83C label=cargoGemStones
B $A83C,2 +0F Gem-Stones
@ $A83E label=PilotFreeCargo
B $A83E,1 remaining ship cargo capacity
@ $A83F label=PilotFrontLaser
B $A83F,4
@ $A843 label=PilotMission1
B $A843,1 mission-1 byte =0 mission not given <>0 mission 1 given
@ $A844 label=Pilot_Fuel
B $A844,1 Fuel
@ $A845 label=PilotMissiles
B $A845,1 number of missiles
@ $A846 label=PilotLargeCargo
B $A846,1 +49 large cargo bay =$59 if mission 1 was taken
@ $A847 label=PilotECMSystem
B $A847,3 ECM System 7,=1 system on
@ $A84A label=PilotFuelScoops
B $A84A,1 FuelScoops
@ $A84B label=PilotEscapePod
B $A84B,1 Escape capsule
@ $A84C label=PilotEnergyBomb
B $A84C,1 Energy bomb
@ $A84D label=PilotEnergyUnit
B $A84D,1 Energy Unit
@ $A84E label=PilotDocComputer
B $A84E,1 docking computer
@ $A84F label=PilotGyperdrive
B $A84F,3 hyperdrive
@ $A852 label=PilotGalaxyData0
W $A852,2 galaxy data
@ $A854 label=PilotGalaxyData2
W $A854,2
@ $A856 label=PilotGalaxyData4
W $A856,2
@ $A858 label=PilotPlanetData
B $A858,1 ?????
@ $A859 label=Pilot_CrdYSystem
B $A859,2 Y coordinate of the current system
@ $A85B label=Pilot_CrdXSystem
B $A85B,3 X coordinate of the current system
@ $A85E label=PilotPlanetTechLvl
B $A85E,1 ???
@ $A85F label=PilotPlanetGov
B $A85F,1 ???
@ $A860 label=PilotPlanetProduct
B $A860,16 goods at the station +75
@ $A870 label=PilotPlProdAlienIt
N $A870 Alien Items are never actually for sale: at the end of every GenerateProductPrice run, the freshly generated quantity for this last slot is overwritten with zero. The player can only acquire them by scooping them in combat, and can only sell them here, never buy them.
B $A870,1 +91 =0 the station was destroyed as part of the mission
@ $A871 label=PilotMission3
B $A871,1 +92 >0 - mission 3 given =1 mission 3 will be given on docking ( =1 time to give the mission, will become =2 after the jump) =2 mission 3 will be given on docking =3 mission 3 given (the station can be destroyed with a missile) (Thargons launch from the station) =4 mission 3 given, the ship is in the target system (the station can be destroyed with a missile) (Thargons launch from the station) =5 mission 3 completed, there will be congratulations on docking
@ $A872 label=PilotExtWeapon
B $A872,1 +93 extra equipment present 7,=1 - ECM Jammer 6,=1 - Cloaking device 5,=1 - cannot buy goods (refugees in the hold) =1 mission 3 was completed =1 - mission 3 completed =1 - mission 2 completed =1 - mission 1 completed
@ $A873 label=PilotDataOfSun
B $A873,9 sun data, 9 bytes, copied here when saving
@ $A87C label=PilotMission1_1
B $A87C,1 =1 - mission 1 given (taken)
@ $A87D label=Pilot_CrdXTarget
B $A87D,1 X coordinate of the small cursor on the large map
@ $A87E label=Pilot_CrdYTarget
B $A87E,1 +103 (last byte to save) Y coordinate of the small cursor on the large map
@ $A87F label=MissileJammed
B $A87F,2 7,=1 missile launch failed 6-0,= Y print coordinate of the message
@ $A881 label=ShipLaunchMisile
B $A881,2 7,=1 the enemy fired a missile
@ $A883 label=UntargetMissile
B $A883,2 7,=1 missile untargeted (not by the player)
@ $A885 label=DestDeviceCargo
B $A885,2 7,=1 some equipment/cargo destroyed -> message number goes into nMsgDamage
@ $A887 label=CashBonus
B $A887,2 7,=1 an object was destroyed =1 a cash bonus was received (bonus amount in LastBonusCash)
@ $A889 label=CargoFound
B $A889,2 7,1 =1 cargo picked up in space
@ $A88B label=RatingRightOn
B $A88B,2 7,=1 combat rating increased, show the message "right on commander"
@ $A88D label=FlgPrnNumber
B $A88D,1 =$00 print the number with leading zeros (otherwise with spaces)
@ $A88E label=DigitsInNumber
B $A88E,1 number of digits to print for the number (padded on the left with spaces or zeros)
@ $A88F label=NoFuel
B $A88F,2 7,=1 - fuel was zeroed out
@ $A891 label=FlgPrnSym1
B $A891,1 print flag =1 - print in uppercase
@ $A892 label=FlgPrnSym2
B $A892,1 print flag =1 there was a line feed
@ $A893 label=FlgPrnSym3
B $A893,1 print flag =1 - capitalize first letter
@ $A894 label=FlgPrnDescr
B $A894,3 =1 generate the planet description line
c $A897
C $A897,3 zero out fuel
@ $A89A label=nObjMissile
b $A89A
B $A89A,1 =0 missile targeting was on <>0 reverse index of the object the missile is targeting (8 - slot 0)
c $A89B
C $A89B,3 add a found canister to the cargo
C $A89E,3 increase the money amount
C $A8A1,3 increase combat rating
b $A8A4
B $A8A4,3
c $A8A7
C $A8A7,3 heavy damage. destruction of something (fuel/cargo, etc.)
c $A8AA
N $A8AA Put on the Cloaking Device
C $A8AA,3 +93 extra equipment present 7,=1 - ECM Jammer 6,=1 - Cloaking device 5,=1 - cannot buy goods (refugees in the hold) 4 3 =1 mission 3 was completed 2 =1 - mission 3 completed 1 =1 - mission 2 completed 0 =1 - mission 1 completed
C $A8B3,2 '}' ; message number
c $A8B7 AddFoundCargo
N $A8B7 Add a found canister to the cargo
N $A8B7 In: a - cargo type in the canister
N $A8B7 =$FF cloaking device
N $A8B7 =0..16 cargo
N $A8B7 Out: hl,de,b,a - undefined
C $A8BA,2 put on the Cloaking Device
C $A8BC,3 remaining ship cargo capacity
C $A8C3,3 24 cargo present in the ship (17 bytes) +00 Food
C $A8C8,2 message number
C $A8CA,3 7,1 =1 cargo picked up in space
C $A8D1,1 update legal status if needed
@ $A8D4 label=SetLegalStatCargo
C $A8E3,3 pilot's legal status 0 - clean 1..31h offender 32h..FFh fugitive
c $A8EE IncBattleRating
N $A8EE Increase combat rating
N $A8EE In: de - rating increment
N $A8EE Out: hl,de - undefined
C $A8EE,3 13 pilot's combat rating 0,0,0...255,8,0 Harmless 0,9,0...255,8,0 M.Harmless 0,17,0...255,16,0 Poor 0,33,0...255,32,0 Average 0,65,0...255,64,0 Above Average 0,129,0...255,128,0 Competent 0,0,3...255,255,2 Dangerous 0,0,11...255,255,10 Deadly 0,0,26...255,255,25 Elite
C $A8FB,3 7,=1 combat rating increased, show the message "right on commander"
c $A900 AddCashObj
N $A900 Increase the money amount
N $A900 In: de - amount of money (from 0.1 to 6553.5)
N $A900 Out: hl,de - undefined
C $A903,4 cash reward for a combat kill
C $A907,3 add money
C $A90A,3 7,=1 an object was destroyed =1 a cash bonus was received (bonus amount in LastBonusCash)
@ $A910 label=PilotDataSaved
t $A910
T $A910,93
T $A96D,9
c $A976 InitGame
C $A976,3 clear all messages during flight
C $A979,3 restore pilot data from memory
C $A97C,3 get Pilot_CrdXSystem
C $A97F,3 set Pilot_CrdXTarget
C $A982,3 get Pilot_CrdYSystem
C $A985,3 set Pilot_CrdYTarget
C $A988,3 Find the planet nearest the cursor, build its data
C $A991,3 generate prices without quantities at the station
C $A995,2 'w'
C $A997,3 name of the planet the ship is set to
C $A99A,3 name of the active planet
C $A9A2,3 sun coordinates when leaving the station
C $A9A5,3 data for printing the sun, 9 bytes long, crd low x planet
C $A9AE,3 set JumpCountdown
@ $A9B2 label=BufferCrdY
b $A9B2
B $A9B2,24
c $A9CA Cmd_O_LocalMap
N $A9CA Print the local galaxy map
C $A9CD,3 for printing planet names on the local map
C $A9D4,3 clear the screen with attribute $07, draw a border around the whole screen, set the initial text-print coordinates
C $A9D9,3 Print the galaxy map header
C $A9DC,3 Fill attribute row 3 from the bottom (row 21) with attribute =5
C $A9DF,3 get Pilot_CrdXSystem
C $A9E4,3 Set A=0
C $A9EA,3 get Pilot_CrdXSystem
C $A9EF,3 Set A=0FFh
C $A9F5,3 get Pilot_CrdYSystem
C $A9F8,2 '"'
C $A9FA,3 Set A=0
C $AA00,3 get Pilot_CrdYSystem
C $AA03,2 '"'
C $AA05,3 Set A=0FFh
C $AA12,3 coordinate of the map's bottom edge (only affects cursor display on the map)
C $AA17,3 cursor width
C $AA1A,2 'a'
C $AA1C,3 set PrnCrdXCursor
C $AA1F,2 '`'
C $AA21,3 set PrnCrdYCursor
C $AA24,3 print the cursor on the galaxy map screen
C $AA27,3 print one star on the local map
C $AA2A,3 print stars/star names on the local map
C $AA2D,3 print the name of one star on the local map
C $AA30,3 print stars/star names on the local map
C $AA33,3 get Pilot_Fuel
C $AA39,3 draw on the galaxy map a circle of the flight radius reachable with available fuel
C $AA3E,3 cursor width
C $AA41,3 print the small cursor on the global/local map
c $AA44 PrnStarsNameOnMap
N $AA44 Print stars/star names on the local map
N $AA44 In: hl - address of the print routine
C $AA47,3 copy galaxy data into the working area
C $AA58,3 data for generating a planet
C $AA68,3 modify data for planet generation
c $AA6F CalcCrdAdrPrnStar
N $AA6F Calculate the star's print coordinates and the display-file address
N $AA6F In: ---
N $AA6F Out: c - X print coordinate of the star
N $AA6F b - Y print coordinate of the star
N $AA6F hl - address in the display file
N $AA6F a - bit number within the byte
C $AA6F,2 'a'
C $AA71,3 get Pilot_CrdXSystem
C $AA7F,2 '`'
C $AA81,3 get Pilot_CrdYSystem
C $AA85,3 data for generating a planet
c $AA96 PrintStarOnLocalMap
N $AA96 Print one star on the local map
N $AA96 In: (DataOfPlanet) - planet data
N $AA96 Out: (DataOfPlanet) - data for the next planet
N $AA96 hl,de,bc,a - ????
C $AA96,3 calculate the star's print coordinates and the display-file address
C $AA9C,3 sprites for stars on the local map
C $AAD0,2 ' '
C $AAE1,3 modify data for planet generation
s $AAE4
S $AAE4,2
S $AAE6,1
c $AAE7 PrintNameOnLocalMap
N $AAE7 Print the name of one star on the local map
N $AAE7 In: (DataOfPlanet) - planet data
N $AAE7 Out: (DataOfPlanet) - data for the next planet
N $AAE7 hl,de,bc,a - ????
C $AAE7,3 calculate the star's print coordinates and the display-file address
C $AAEB,3 generate the planet name and prepare data for generating the next name
C $AAF1,3 for generating the planet name
C $AB06,3 set CrdXPrnSymbol
C $AB37,3 for printing planet names on the local map
C $AB45,3 set FlgPrnSym2
C $AB48,3 for generating the planet name
C $AB4B,3 print a message
c $AB4E Cmd_I_GlobalMap
N $AB4E Print the galaxy map menu
C $AB4E,3 clear the screen with attribute $07, draw a border around the whole screen, set the initial text-print coordinates
C $AB58,3 coordinate of the map's bottom edge (only affects cursor display on the map)
C $AB5D,3 cursor width
C $AB60,3 get Pilot_CrdXSystem
C $AB63,3 set PrnCrdXCursor
C $AB66,3 get Pilot_CrdYSystem
C $AB6D,3 set PrnCrdYCursor
C $AB70,3 print the cursor on the galaxy map screen
C $AB73,3 get Pilot_Fuel
C $AB7D,3 draw on the galaxy map a circle of the flight radius reachable with available fuel
C $AB85,3 fast clear of several character rows within a screen segment
C $AB8D,3 fast clear of several character rows within a screen segment
C $AB95,3 cursor width
C $AB98,3 print the small cursor on the global/local map
C $AB9D,3 Print the galaxy map header
C $ABAD,3 print a horizontal line
C $ABB0,3 copy galaxy data into the working area
C $ABB6,3 calculate coordinates and print one star (dot) on the galaxy map
C $ABB9,3 modify data for planet generation
c $ABC0 ClearZnkLines
N $ABC0 Fast clear of several character rows within a screen segment
N $ABC0 In: hl - end address of the screen area +2
N $ABC0 a - number of rows
@ $ABE3 label=SaveA1
s $ABE3
S $ABE3,1
@ $ABE4 label=SaveSP9
S $ABE4,2
c $ABE6 PrnStarOnGalaxyMap
N $ABE6 Calculate coordinates and print one star (dot) on the galaxy map
N $ABE6 In: (DataOfPlanet) - planet data
C $ABE6,3 data for generating a planet
C $ABF4,3 calculate the screen address In: B - crdY, C - crdX Out: hl - address A - offset of this point from the byte's left edge
C $AC01,1 adjust the instruction used to set the point
c $AC0A Set_A_zero
N $AC0A Set A=0
c $AC0C set_A_FFh
N $AC0C Set A=0FFh
@ $AC0F label=PlanetData0
s $AC0F
S $AC0F,2
@ $AC11 label=PlanetData1
S $AC11,2
@ $AC13 label=PlanetData2
S $AC13,2
@ $AC15 label=DataOfPlanet
S $AC15,2
@ $AC17 label=DataOfPlanet1
S $AC17,2
@ $AC19 label=DataOfPlanet2
S $AC19,2
@ $AC1B label=DataOfPlanetSv
S $AC1B,6
@ $AC21 label=DescrPlanetData
S $AC21,4
@ $AC25 label=InputText
S $AC25,9
@ $AC2E label=TempName
S $AC2E,9
@ $AC37 label=PlanetPresent
S $AC37,9
@ $AC40 label=plNameDest
S $AC40,9
@ $AC49 label=FuelToPlanet
S $AC49,2
@ $AC4B label=PlanetEconomy
S $AC4B,1
@ $AC4C label=PlanetGovernment
S $AC4C,1
@ $AC4D label=PlanetTechLevel
S $AC4D,1
@ $AC4E label=PlanetPopulation
S $AC4E,1
@ $AC4F label=PlanetGrossProduct
S $AC4F,4
@ $AC53 label=SaveA5
S $AC53,1
@ $AC54 label=SaveHL_2
S $AC54,2
c $AC56 NextGalaxy
N $AC56 Switch to the next galaxy
N $AC56 In: ----
N $AC56 Out: a - galaxy number
N $AC56 hl,de - ????
C $AC56,3 galaxy number
C $AC5E,3 galaxy data
c $AC6D
c $AC77 FindPlanetByName
N $AC77 Search for a planet in the galaxy by name
N $AC77 In: InputText - planet name
N $AC77 Out: DataOfPlanet - planet data, plus its info has been generated
N $AC77 cy =1 planet not found
N $AC77 =0 found
C $AC77,3 copy galaxy data into the working area
C $AC7E,3 save the working area with galaxy data
C $AC81,3 generate the planet name and prepare data for generating the next name
C $AC84,3 entered text (pilot name when saving/loading, planet name when searching)
C $AC87,3 for generating the planet name
C $AC9F,3 restore the working area with galaxy data
C $ACA2,3 print the small cursor on the global/local map
C $ACA5,3 Build planet data (economy, government, tech level,
C $ACA8,3 print the small cursor on the global/local map
C $ACAB,3 Copy the planet name into the working area
C $ACAE,3 calculate fuel consumption for the jump to the planet
@ $ACB1 label=SaveHL_1
s $ACB1
c $ACB3 SearchNearPlanet
N $ACB3 Find the planet nearest the cursor, build its data, set it as
N $ACB3 the current target and draw the cursor if the map is displayed
C $ACB3,3 get WhatOnScreen
C $ACB8,2 find the planet nearest the cursor, build its data and set it as the current target
C $ACBC,2 find the planet nearest the cursor, build its data and set it as the current target
C $ACBE,3 print the small cursor on the global/local map
C $ACC1,3 Find the planet nearest the cursor, build its data
C $ACC4,3 print the small cursor on the global/local map
c $ACC7 SearchPlanetNearCursor
N $ACC7 Find the planet nearest the cursor, build its data
N $ACC7 and set it as the current target
C $ACC7,3 copy galaxy data into the working area
C $ACCD,3 intermediate variable for calculating the distance from the cursor to the nearest planet
C $ACD7,3 data for generating a planet
C $ACDA,3 squared distance between the cursor and the planet
C $ACE0,3 intermediate variable for calculating the distance from the cursor to the nearest planet
C $ACE8,4 intermediate variable for calculating the distance from the cursor to the nearest planet
C $ACEC,3 save the working area with galaxy data
C $ACEF,3 modify data for planet generation
C $ACF5,3 intermediate variable for calculating the distance from the cursor to the nearest planet
C $ACF9,3 calculate fuel to reach the planet
C $ACFC,3 restore the working area with galaxy data
C $ACFF,3 Build planet data (economy, government, tech level,
C $AD02,3 generate the planet name and prepare data for generating the next name
C $AD05,3 Copy the planet name into the working area
C $AD08,3 calculate fuel consumption for the jump to the planet
C $AD0C,3 get Pilot_CrdYSystem
C $AD0F,3 squared distance between the cursor and the planet
C $AD12,3 calculate fuel to reach the planet
c $AD17 NextPlanetData
N $AD17 Modify data for planet generation
N $AD17 In: ----
N $AD17 Out: hl,de,b,a - ????
C $AD1A,3 modify data for planet generation
c $AD21 CalcDistanceToCursor
N $AD21 Squared distance between the cursor and the planet
N $AD21 In: b - planet's Y coordinate
N $AD21 a - planet's X coordinate
N $AD21 Out: hl - result
N $AD21 cy=1 - sum greater than $FFFF
N $AD21 de,bc,a - ????
C $AD22,3 get Pilot_CrdXTarget
C $AD29,3 multiplication hl=d*a
C $AD2E,3 get Pilot_CrdYTarget
C $AD37,3 multiplication hl=d*a
c $AD45 CalcFuelForDistance
N $AD45 Calculate fuel to reach the planet
N $AD45 In: hl - squared distance from the planet to the cursor
N $AD45 cy=1 - hl > $FFFF
N $AD45 Out: hl,(FuelToPlanet) - fuel needed for the jump
C $AD50,3 extract the square root h=sqr(hl)
C $AD58,3 fuel required to travel to the planet =distance*4
c $AD5C Mult_HL_D_A
N $AD5C Multiplication hl=d*a
N $AD5C In: d,a - factors
N $AD5C Out: hl - result
c $AD6F GeneratePlanetName
N $AD6F Generate the planet name and prepare data for generating the next name
N $AD6F In: (DataOfPlanet) - planet data
N $AD6F Out: (TempName) - planet name
N $AD6F (DataOfPlanet) - data for the next planet
N $AD6F hl,de,bc,a - ????
C $AD6F,3 for generating the planet name
C $AD72,3 for storing a variable in the GeneratePlanetName routine
C $AD7C,3 data for generating a planet
C $AD80,2 '@'
C $AD8E,2 modify data for planet generation
C $AD97,2 modify data for planet generation
C $AD99,3 character pairs for generating the planet name
C $ADA4,3 for storing a variable in the GeneratePlanetName routine
C $ADAD,2 '?'
C $ADB3,3 for storing a variable in the GeneratePlanetName routine
C $ADB6,3 modify data for planet generation
C $ADC2,3 data for generating a planet
c $ADD3 CopyPlanetName
N $ADD3 Copy the planet name into the working area
N $ADD3 (TempName)->(PlanetName)
C $ADD6,3 for generating the planet name
C $ADD9,3 name of the planet the ship is set to
c $ADDF GenerateInfoPlanet
N $ADDF Build planet data (economy, government, tech level,
N $ADDF population, gross income) and set the small-cursor coordinates
C $ADDF,3 data for generating a planet
C $ADE2,3 6 bytes for generating planet data
C $ADE6,3 set Pilot_CrdYTarget
C $ADEB,3 Economy
C $ADF5,3 set Pilot_CrdXTarget
C $AE01,3 government (government type)
C $AE08,3 Economy
C $AE0D,3 Economy
C $AE10,3 Economy
C $AE1C,3 government (government type)
C $AE22,3 Tech/Level (tech level)
C $AE28,3 government (government type)
C $AE2C,3 Economy
C $AE33,3 population n/10 of the form x.x
C $AE36,3 Economy
C $AE3E,3 government (government type)
C $AE43,3 multiplication hl=d*a
C $AE46,3 population n/10 of the form x.x
C $AE4A,3 multiplication hl=d*a
C $AE50,3 Gross productivity (gross income)
c $AE5A PrintFuelToPlanet
N $AE5A Print the distance to the planet on the map
C $AE5A,3 fuel required to travel to the planet =distance*4
C $AE63,3 print a message with a trailing colon
C $AE68,3 ; number of digits to print for the number (padded on the left with spaces or zeros)
C $AE6B,3 fuel required to travel to the planet =distance*4
C $AE6F,3 print a number
C $AE72,3 print one character (print a message by number
b $AE75
B $AE75,1
c $AE76
C $AE76,3 set the print-register flag, reset X coordinate, increment Y coordinate
c $AE79 CopyGalaxyToPlanet
N $AE79 Copy galaxy data into the working area
N $AE79 In: ----
N $AE79 Out: bc=$0000
C $AE79,3 galaxy data
C $AE7C,3 data for generating a planet
c $AE81 SavePlanetData
N $AE81 Save the working area with galaxy data
N $AE81 In: ----
N $AE81 Out: bc=$0000
C $AE81,3 data for generating a planet
C $AE84,3 copy of the planet-generation data, selected planet
c $AE89 RestorePlanetData
N $AE89 Restore the working area with galaxy data
N $AE89 In: ----
N $AE89 Out: bc=$0000
C $AE89,3 copy of the planet-generation data, selected planet
C $AE8C,3 data for generating a planet
@ $AE95 label=SaveA6
b $AE95
B $AE95,1
c $AE96 GenerateProductPrice
N $AE96 Generate quantities and prices of goods at the station
N $AE96 In: ----
N $AE96 Called on arrival after every hyperspace jump, so the market re-rolls once per jump and then stays fixed while docked. Per good, with economy = PlanetEconomy (0-7) and rnd = PilotRnd: gradient = (economyFactor & $1F) * economy; quantity = (baseQty + (rnd & mask)) +/- gradient (sign from bit 7 of the economy factor byte), clamped to 0 and masked to 0-63; price = (basePrice + (rnd & mask)) +/- gradient with the OPPOSITE sign convention from quantity, then multiplied by 4 and stored in 0.1 Cr units (so an internal price of $13 displays as 19*4/10 = 7.6 Cr). The same single random byte seasons every good on the station -- goods differ only via their own mask/base values/economy gradient.
N $AE96 GenerateAnotherPrice is an alternate entry point that skips drawing a fresh random byte and reuses the saved PilotRnd instead, used by InitGame so a loaded commander rebuilds the exact same market it had when saved.
C $AE96,3 get RndWord
C $AE99,3 commander data offset +23 (PilotRnd)
@ $AE9C label=GenerateAnotherPrice
C $AE9C,3 the same but without setting a new rnd
C $AE9F,3 goods prices at the station, in 0.1 Cr units
C $AEA3,3 table for generating goods quantities and prices at the station: 17 x 4-byte templates in TableBasePrice (byte 0 = base price, byte 1 = economy factor: bits 0-4 gradient multiplier, bit 7 gradient sign, byte 2 = base quantity, byte 3 = random mask)
C $AEB2,3 Economy
C $AEC2,3 commander data offset +23 (PilotRnd)
C $AED8,2 '?'
C $AEDB,3 commander data offset +23 (PilotRnd)
C $AF07,3 +91 =0 the station was destroyed as part of the mission
b $AF0C
B $AF0C,2
@ $AF0E label=ProductPrice
B $AF0E,34
@ $AF30 label=CurrentGoodIndex
B $AF30,1 good number
@ $AF31 label=AdrPlayerHold
W $AF31,2 address in the player's hold table (PilotCargo); starts one entry before the table and is pre-incremented by 1 per row
@ $AF33 label=AdrStationPrice
W $AF33,2 address in the station price table (ProductPrice); starts one entry before the table and is pre-incremented by 2 per row
@ $AF35 label=AdrStationStock
W $AF35,2 address in the station stock table (PilotPlanetProduct); starts one entry before the table and is pre-incremented by 1 per row
@ $AF37 label=TempCrdPrn
W $AF37,2 print coordinates
c $AF39 FX_Beep
N $AF39 Sound beep
N $AF39 In: ----
N $AF39 Out: ----
C $AF39,3 get FlagsSetUp
C $AF42,3 '`'
c $AF48 WaitPressKey
N $AF48 Wait for a keypress
N $AF48 In: ----
N $AF48 Out: ----
C $AF48,3 Pause of the 14h interrupt
C $AF4B,3 clear the pressed-key bits
C $AF4E,3 get PressKeyPrnSymbol
c $AF56 ResetPressedKeys
N $AF56 Clear the pressed-key bits
N $AF56 In: ----
N $AF56 Out: b=$00
N $AF56 hl - ????
C $AF57,3 7,=1 - Y -- Cloaking Device 6,=1 - 0 -- ??? 5,=1 - I -- Global Map 4,=1 - O -- Local Map 3,=1 - P -- Planet Info 2,=1 - K -- Planet Price 1,=1 - L -- Commander Info 0,=1 - Enter -- Inventory
c $AF63 PrnOneProduct
N $AF63 One Market Prices / Buy row: name, unit, price (4-digit nnn.n field), then stock as nn+unit, or a literal - when the stock byte is 0 (returns carry set = not traded here). The good's name is printed via message code $D0+index. The 17 goods, in index order: $00 Food(t) $01 Textiles(t) $02 Radioactives(t) $03 Slaves(t) $04 Liquor & Wines(t) $05 Luxuries(t) $06 Narcotics(t) $07 Computers(t) $08 Machinery(t) $09 Alloys(t) $0A Firearms(t) $0B Furs(t) $0C Minerals(t) $0D Gold(kg) $0E Platinum(kg) $0F Gem-Stones(g) $10 Alien Items(t).
N $AF63 Print the name, price and quantity of a good
N $AF63 In: (LLAF30) - good number
N $AF63 (LLAF33) - address in the goods price table
N $AF63 (LLAF35) - address in the goods quantity table
N $AF63 Out: cy=1 - no such good
N $AF63 hl,de,bc,a - ????
C $AF63,3 good number
C $AF68,3 print a message from group 1 in the buffer/on screen
C $AF6B,3 set the X print coordinate
b $AF6E
B $AF6E,1
c $AF6F
C $AF6F,3 print in lowercase t/kg/g/km
C $AF72,3 set the X print coordinate
b $AF75
B $AF75,1
c $AF76
C $AF76,3 address in the goods price table
C $AF7B,3 address in the goods price table
C $AF85,3 ; number of digits to print for the number (padded on the left with spaces or zeros)
C $AF88,3 print a number
C $AF8B,3 set the X print coordinate
b $AF8E
B $AF8E,1
c $AF8F
C $AF8F,3 address in the goods quantity table
C $AF94,3 address in the goods quantity table
C $AF9A,3 print one character (print a message by number
b $AF9D
B $AF9D,1
c $AF9E
C $AF9E,2 '-'
C $AFA0,3 print a message, with LF/CR at the end
C $AFA7,3 ; number of digits to print for the number (padded on the left with spaces or zeros)
C $AFAA,3 address in the goods quantity table
C $AFAE,3 Print a number
C $AFB1,3 print in lowercase t/kg/g/km
C $AFB4,3 set the print-register flag, reset X coordinate, increment Y coordinate
c $AFB9 PrnInventoryRow
N $AFB9 One Inventory/Sell row: prints the good's name and held quantity; prints nothing and returns carry if the player holds none of it.
N $AFB9 Print the name and quantity of a good
N $AFB9 In: (LLAF30) - good number
N $AFB9 (LLAF31) - address in the goods quantity table
N $AFB9 Out: cy=1 - no such good
N $AFB9 hl,de,bc,a - ????
C $AFB9,3 address in the goods quantity table
C $AFBD,3 address in the goods quantity table
C $AFC4,3 good number
C $AFC9,3 print the good's name
C $AFCC,3 set the X print coordinate
b $AFCF
B $AFCF,1
c $AFD0
C $AFD2,3 ; number of digits to print for the number (padded on the left with spaces or zeros)
C $AFD5,3 address in the goods quantity table
C $AFD9,3 Print a number
C $AFDC,3 print in lowercase t/kg/g/km
c $AFE3 PrintMessage2_A_Colon
N $AFE3 Print a message with a trailing colon
N $AFE3 In: a - message number
N $AFE3 Out: hl,de,bc,a - ????
C $AFE3,3 print a message from group 2 in the buffer/on screen
c $AFE8 PrintMessage1_A_Colon
N $AFE8 Print a message with a trailing colon
N $AFE8 In: a - message number
N $AFE8 Out: hl,de,bc,a - ????
C $AFE8,3 print a message from group 1 in the buffer/on screen
C $AFEB,2 ':'
c $AFEF PrintMessage1_A_Space
N $AFEF Print a message with a trailing space
N $AFEF In: a - message number
N $AFEF Out: hl,de,bc,a - ????
C $AFEF,3 print a message from group 1 in the buffer/on screen
C $AFF2,2 ' '
C $AFF4,3 print a message from group 1 in the buffer/on screen
c $AFF7 PrnMsg_A_CRLF
N $AFF7 Print a message, with LF/CR at the end
N $AFF7 In: a - message number
N $AFF7 Out: hl,de,bc,a - ????
C $AFF7,3 print a message from group 1 in the buffer/on screen
c $AFFA PrnCrd_CRLF
N $AFFA Set the print-register flag, reset X coordinate, increment Y coordinate
N $AFFA In: ----
N $AFFA Out: ----
C $AFFC,3 set FlgPrnSym2
C $AFFF,3 Reset X coordinate
c $B002 IncPrnCrdY
N $B002 Increment Y coordinate
C $B006,2 set the Y coordinate, checking for going off-screen
c $B008 SetZeroPrnCrdX
N $B008 Reset X coordinate
C $B009,3 set CrdXPrnSymbol
c $B00D SetCrdX_SP
N $B00D Set the X print coordinate
N $B00D In: byte after the call - X coordinate
N $B00D Out: ----
C $B011,3 set the X print coordinate
C $B014,2 ' '
C $B017,2 set the print-register flag, reset X coordinate, increment Y coordinate
c $B019 SetPrnCrdY
N $B019 Set the Y coordinate, checking for going off-screen
N $B019 In: a - Y coordinate
N $B019 Out: ----
C $B024,2 reset X coordinate
c $B026
C $B031,3 get CrdXPrnSymbol
C $B037,3 set CrdXPrnSymbol
c $B049 PrintMessage_A_UpperCase
N $B049 New equ PrintMessage1_A
N $B049 print a message in uppercase
N $B049 A - message number
C $B04A,3 set flags: print everything in uppercase
b $B04D
B $B04D,1
c $B04E
C $B04F,3 print a message
C $B054,3 set flags: capitalize the first letter of each word
c $B057 PrnMess_A_Inidcator
N $B057 Print a message, the danger indicator (if in space), and 3 CrLf
N $B057 A - message number
C $B057,3 new equ PrintMessage1_A
C $B05A,3 print the danger indicator and the missile indicator
C $B05D,2 'w'
C $B05F,3 three CRLFs
c $B062 PrintMessage_HL
N $B062 Print a message
N $B062 In: hl - message start address
N $B062 Out: cy=1
N $B062 a=$00
N $B062 hl - message end address
N $B062 hl,de,bc - ????
C $B069,3 print a message from group 1 in the buffer/on screen
C $B06D,2 print a message
c $B06F GetProductUnitSuffix
N $B06F Chooses the unit suffix for a good purely from its index: $00-$0C and $10 print t, $0D-$0E print kg, $0F prints g.
N $B06F Print in lowercase t/kg/g/km
N $B06F In: (LLAF30) - message number
N $B06F $00-$0C,$10 - t
N $B06F $0D,$0E - kg
N $B06F $0F - g
N $B06F $11-$FF - km
N $B06F Out: hl,de,bc,a
C $B071,3 set FlgPrnSym2
C $B074,3 good number
C $B087,2 'T'
C $B08B,2 'K'
C $B08D,3 print a message from group 1 in the buffer/on screen
C $B090,2 'G'
C $B094,3 print one character (print a message by number
b $B097
B $B097,1
c $B098
C $B098,2 'M'
C $B09A,3 print a message from group 1 in the buffer/on screen
c $B09D IsCargoBayGood
N $B09D Checks whether a good occupies cargo-bay space (only tonne-unit goods do; Gold/Platinum/Gem-Stones are kg/g and don't count against PilotFreeCargo).
C $B09D,3 good number
c $B0AB Pause_14Int
N $B0AB Pause of the 14h interrupt
c $B0AF Pause_24Int
N $B0AF Pause of the 24h interrupt
C $B0AF,2 '$'
c $B0B5 SaveCrdPrn
N $B0B5 Save print coordinates
N $B0B5 In: ----
N $B0B5 Out: hl - coordinates
C $B0B5,3 get CrdXPrnSymbol
C $B0B8,3 set TempCrdPrn
c $B0BC Clear2ZnkLine
N $B0BC Clear two character-cell lines
N $B0BC In: ----
N $B0BC Out: b=$00
C $B0BE,3 set the Y coordinate, checking for going off-screen
C $B0C1,3 Reset X coordinate
C $B0C8,3 clear a line of 8x8 character cells, 30 long
c $B0CB
c $B0CE ClearZnkLine
N $B0CE Clear a line of 8x8 character cells, 30 long
N $B0CE In: hl - address in the screen area
c $B0DE
N $B0DE Restore print coordinates
N $B0DE In: ----
N $B0DE Out: hl - coordinates
C $B0DE,3 get TempCrdPrn
C $B0E1,3 set CrdXPrnSymbol
@ $B0E5 label=SaveA3
b $B0E5
B $B0E5,1 length of the entered planet name when searching
@ $B0E6 label=SaveHL2
W $B0E6,2
@ $B0E8 label=SaveA4
B $B0E8,1
c $B0E9 Cmd_R_FindPlanetName
N $B0E9 Search for a planet by its name
C $B0ED,3 entered text (pilot name when saving/loading, planet name when searching)
C $B0F0,3 input a text string
C $B0F3,3 get SaveA3
C $B0F7,3 clear two character-cell lines
C $B0FA,3 search for a planet in the galaxy by name
C $B0FF,3 entered text (pilot name when saving/loading, planet name when searching)
C $B102,3 print the message "planet not found"
C $B105,3 print one character (print a message by number
b $B108
B $B108,1
c $B109
C $B109,3 print one character (print a message by number
b $B10C
B $B10C,1
c $B10D
C $B10D,3 sound beep
C $B110,3 clear the pressed-key bits
C $B113,3 print one character (print a message by number
b $B116
B $B116,1
c $B117
C $B117,3 print the planet name and the distance to it
@ $B11A label=SaveA2
b $B11A
B $B11A,1
@ $B11B label=SaveHL1
W $B11B,2
c $B11D InputTextString
N $B11D Input a text string
N $B11D In: a - ???
N $B11D b - max length of the input string
N $B11D hl - address of the input string
N $B11D (CrxXPrnSymbol),(CrxYPrnSymbol) - print coordinates
C $B12E,3 set SaveA3
C $B131,3 clear two character-cell lines
C $B134,3 print one character (print a message by number
b $B137
B $B137,1 print everything in uppercase
c $B138
C $B13B,3 print a message from group 2 in the buffer/on screen
C $B13E,3 wait for a keypress
C $B14F,2 '0'
C $B153,2 '['
C $B157,2 ':'
C $B15B,2 '@'
C $B160,3 get SaveA3
C $B168,3 set SaveA3
C $B174,3 print a message from group 1 in the buffer/on screen
C $B179,3 get SaveA3
C $B180,3 set SaveA3
C $B192,3 clear the pressed-key bits
C $B19C,3 set the print-register flag, reset X coordinate, increment Y coordinate
C $B19F,3 Pause of the 14h interrupt
C $B1A2,3 get PressKeyPrnSymbol
C $B1A9,3 clear the pressed-key bits
c $B1AC Cmd_D_Curs2NearPlanet
N $B1AC Position the cursor on the nearest planet and print its name and distance to it
C $B1AC,3 find the planet nearest the cursor, build its data, set it as the current target, and draw the cursor if the map is displayed
C $B1AF,3 clear two character-cell lines
C $B1B4,3 new equ PrintMessage1_A
C $B1B7,3 set the print-register flag, reset X coordinate, increment Y coordinate
C $B1BA,3 Print the distance to the planet on the map
C $B1BD,3 sound beep
c $B1C0 PrintSmallCursOnMap
N $B1C0 Print the small cursor on the global/local map
N $B1C0 In: (CursorWidth) - cursor width
N $B1C0 (Pilot_CrdXTarget),(Pilot_CrdYTarget) - cursor coordinates on the map
N $B1C0 Out: hl,de,bc,a - undefined
C $B1C0,3 cursor width
C $B1C7,3 get Pilot_CrdXSystem
C $B1CB,3 get Pilot_CrdXTarget
C $B1D6,2 'a'
C $B1E3,2 'a'
C $B1E7,3 set PrnCrdXCursor
C $B1EA,3 get Pilot_CrdYSystem
C $B1EE,3 get Pilot_CrdYTarget
C $B1F7,2 '`'
C $B202,2 '`'
C $B20C,3 set PrnCrdYCursor
C $B211,3 get Pilot_CrdXTarget
C $B214,3 set PrnCrdXCursor
C $B217,3 get Pilot_CrdYTarget
C $B21E,3 set PrnCrdYCursor
C $B221,3 print the cursor on the galaxy map screen
c $B224 MoveCursorUp
N $B224 Decrease the Y coordinate and print the small cursor
N $B224 In: ----
N $B224 Out: (LLA813),(LLA814) - on-screen coordinates of the small cursor
C $B224,3 print the small cursor on the global/local map
C $B227,3 get Pilot_CrdYTarget
C $B231,3 set Pilot_CrdYTarget
c $B236 MoveCursorDown
N $B236 Increase the Y coordinate and print the small cursor
N $B236 In: ----
N $B236 Out: (LLA813),(LLA814) - on-screen coordinates of the small cursor
C $B236,3 print the small cursor on the global/local map
C $B239,3 get Pilot_CrdYTarget
C $B244,3 set Pilot_CrdYTarget
c $B249 MoveCursorLeft
N $B249 Decrease the X coordinate and print the small cursor
N $B249 In: ----
N $B249 Out: (LLA813),(LLA814) - on-screen coordinates of the small cursor
C $B249,3 print the small cursor on the global/local map
C $B24C,3 get Pilot_CrdXTarget
C $B253,3 set Pilot_CrdXTarget
C $B256,3 print the small cursor on the global/local map
c $B259 MoveCursorRight
N $B259 Increase the X coordinate and print the small cursor
N $B259 In: ----
N $B259 Out: (LLA813),(LLA814) - on-screen coordinates of the small cursor
C $B259,3 print the small cursor on the global/local map
C $B25C,3 get Pilot_CrdXTarget
C $B265,3 set Pilot_CrdXTarget
c $B26A Cmd_B_Cursor2Start
N $B26A Position the small cursor at the large cursor's coordinates
N $B26A In: ----
N $B26A Out: (LLA813),(LLA814) - on-screen coordinates of the small cursor
C $B26A,3 print the small cursor on the global/local map
C $B26D,3 get Pilot_CrdXSystem
C $B270,3 set Pilot_CrdXTarget
C $B273,3 get Pilot_CrdYSystem
C $B276,3 set Pilot_CrdYTarget
c $B27B Cmd_2_BuyCargo
N $B27B While mission 1 is active, this screen is replaced by a special mission pitch (deliver contraband): accepting it (Y) wipes the hold, grants the Large Cargo Bay, and sets a "mission cargo aboard" flag in PilotExtWeapon bit 5, which subsequently locks the player out of the normal Buy screen until the mission resolves.
N $B27B Goods purchase menu
C $B27B,3 +93 extra equipment present 7,=1 - ECM Jammer 6,=1 - Cloaking device 5,=1 - cannot buy goods (refugees in the hold) 4 3 =1 mission 3 was completed 2 =1 - mission 3 completed 1 =1 - mission 2 completed 0 =1 - mission 1 completed
C $B282,3 get PilotMission1
C $B288,3 if mission 1 has been given, offer to rescue the refugees
C $B28E,3 Special message (refugees, pirates, mission 3, etc.)
C $B293,3 set PrnCrdXCursor
C $B296,2 'v'
C $B298,3 set PrnCrdYCursor
C $B29B,2 '='
C $B2A0,3 print a circle
C $B2A3,3 wait for a keypress
C $B2A6,2 'Y'
C $B2AA,3 set PilotLargeCargo
C $B2AE,3 set PilotFreeCargo
C $B2B1,3 24 cargo present in the ship (17 bytes) +00 Food
C $B2BA,3 +93 extra equipment present 7,=1 - ECM Jammer 6,=1 - Cloaking device 5,=1 - cannot buy goods (refugees in the hold) 4 3 =1 mission 3 was completed 2 =1 - mission 3 completed 1 =1 - mission 2 completed 0 =1 - mission 1 completed
C $B2BF,3 Pause of the 24h interrupt
C $B2C2,3 print the cargo hold contents
@ $B2C5 label=data_B2C5
b $B2C5
B $B2C5,2
c $B2C7
C $B2C7,3 clear the screen with attribute $07, draw a border around the whole screen, set the initial text-print coordinates
C $B2CA,3 set the X print coordinate
b $B2CD
B $B2CD,1
c $B2CE
C $B2D0,3 print a message, with LF/CR at the end
C $B2D6,3 Set screen attributes
C $B2D9,3 Fill attribute row 3 from the bottom (row 21) with attribute =5
C $B2DF,3 74 ???
C $B2E2,3 address in the goods quantity table
C $B2E5,3 address in the goods quantity table
C $B2E9,3 address in the goods quantity table
C $B2EC,3 print the name, price and quantity of a good
C $B2F1,3 save print coordinates
C $B30C,3 restore print coordinates
C $B30F,3 good number
C $B318,3 print the cargo hold contents
c $B31B
c $B324
c $B333 EnterQuantity
N $B333 The shared quantity-entry engine behind every "how many?" prompt in the game (Buy Cargo, Sell Cargo, Equip Ship). In: hl = a validation/transaction callback address (stored in word_B472). Out: carry clear and byte_B471 = the entered 1-2 digit number, or carry set = aborted (a=2 means Enter was pressed with nothing typed).
N $B333 Flow: waits for a first digit, stores it, echoes it, then calls the callback immediately -- in this game the callback performs the actual transaction (cash deduction, stock/hold update), so typing 1 executes a purchase of 1 on the spot. Waits for a second key: Enter accepts the 1-digit value; another digit computes byte_B471 = old*10+digit, calls RollbackTradeState to undo the first-digit transaction, then calls the callback again with the 2-digit total; backspace ($FE) also rolls back and restarts entry from the first digit.
C $B33A,3 wait for a keypress
C $B341,2 '1'
C $B349,2 ':'
C $B34E,2 '0'
C $B354,3 print a message from group 1 in the buffer/on screen
C $B35F,3 wait for a keypress
C $B365,2 '0'
C $B36D,2 ':'
C $B372,2 '0'
C $B381,3 print a message from group 1 in the buffer/on screen
c $B395
C $B395,3 set the X print coordinate
b $B398
B $B398,1
c $B399
C $B399,3 print one character (print a message by number
b $B39C
B $B39C,1
c $B39D
C $B39D,3 sound beep and a pause of $24
c $B3A0 Call_HL
c $B3A1 BuyGoodCallback
N $B3A1 Transaction callback for the Buy screen, called by EnterQuantity after every digit. Snapshots state, then: stock -= qty (fail $B0 = quantity unavailable), pays qty x price via DecCASH in a loop (fail $C5 = insufficient cash), checks cargo-bay space via IsCargoBayGood and debits PilotFreeCargo if needed (fail $CE = no room), then PilotCargo[good] += qty (8-bit overflow also fails $CE), and finally calls SetLegalStatCargo. Any failure jumps to loc_B3E8 which prints the message and rolls the whole attempt back.
C $B3A8,3 address in the goods quantity table
C $B3B0,3 address in the goods price table
C $B3B6,3 decrease money (from 0 to 999.9)
C $B3C6,3 remaining ship cargo capacity
C $B3CE,3 address in the goods quantity table
C $B3D6,3 good number
C $B3D9,3 duplicate this routine
c $B3E2
N $B3E8 Shared fail handler for both buy and sell: prints the message code left in A at print-column 3 followed by '?', then calls RollbackTradeState to undo the attempted transaction.
C $B3E9,3 set the X print coordinate
C $B3EE,3 print a message from group 1 in the buffer/on screen
C $B3F1,3 print one character (print a message by number
b $B3F4
B $B3F4,1
c $B3F5
c $B3F8 BeepPause24
N $B3F8 Sound beep and a pause of $24
N $B3F8 In: ----
N $B3F8 Out: cy=1
N $B3F8 a=$01
C $B3F8,3 sound beep
C $B3FB,3 Pause of the 24h interrupt
c $B402 SnapshotTradeState
N $B402 Saves PilotCash1, PilotCash2, the current good's stock byte, its hold byte, and PilotFreeCargo into word_B46A/word_B46C/byte_B46E/byte_B46F/byte_B470. Called first by every buy/sell transaction callback, so a later digit (or an abort) can cleanly undo a transaction already committed by a previous digit.
C $B402,3 get PilotCash2
C $B408,3 get PilotCash1
C $B40E,3 address in the goods quantity table
C $B415,3 address in the goods quantity table
C $B41C,3 get PilotFreeCargo
c $B423 RollbackTradeState
N $B423 Restores the five fields saved by SnapshotTradeState. Called by EnterQuantity between digits and on backspace, and by every transaction failure path.
C $B426,3 set PilotCash2
C $B42C,3 set PilotCash1
C $B42F,3 address in the goods quantity table
C $B436,3 address in the goods quantity table
C $B440,3 set PilotFreeCargo
c $B444 PrnQuantityPrompt
N $B444 Prints the "QUANTITY OF <good>/<unit>?" prompt on the bottom two rows, shared by both the Buy and Sell screens.
C $B444,3 clear two character-cell lines
C $B449,3 set FlgPrnSym2
C $B44C,3 print one character (print a message by number
b $B44F
B $B44F,1
c $B450
C $B453,3 good number
C $B457,3 print a message from group 1 in the buffer/on screen
C $B45A,3 print one character (print a message by number
b $B45D
B $B45D,1
c $B45E
C $B45E,3 print in lowercase t/kg/g/km
C $B461,3 print one character (print a message by number
b $B464
B $B464,1
c $B465
C $B465,2 '?'
C $B467,3 print a message, with LF/CR at the end
b $B46A
W $B46A,2
W $B46C,2
B $B46E,1
B $B46F,1
B $B470,1
B $B471,1
W $B472,2
c $B474 Cmd_3_SellCargo
N $B474 Goods sale menu
C $B474,3 get PilotMission1
C $B47A,3 +93 extra equipment present 7,=1 - ECM Jammer 6,=1 - Cloaking device 5,=1 - cannot buy goods (refugees in the hold) 4 3 =1 mission 3 was completed 2 =1 - mission 3 completed 1 =1 - mission 2 completed 0 =1 - mission 1 completed
C $B488,2 'd'
C $B48A,3 set cargoGemStones
C $B48D,2 '$'
C $B48F,3 set PilotFreeCargo
C $B49B,3 print the cargo hold contents
b $B49E
B $B49E,1
c $B49F PrintMenuFrame
C $B49F,3 Print the menu frame
C $B4A5,3 Set screen attributes
C $B4A8,3 fill attribute row 3 from the bottom (row 21) with attribute =5
c $B4AB PrintFrameMenu
N $B4AB Print the menu frame
C $B4AD,3 print a message from group 2 in the buffer/on screen
c $B4B0 SellGoodLoop
N $B4B0 Drives the Sell screen: loops over all 17 goods via PrnInventoryRow (which silently skips goods the player doesn't hold); for each held good, saves the print cursor, shows the quantity prompt, and runs EnterQuantity with SellGoodCallback. After the loop: two pauses, then tail-jumps to the Inventory screen.
C $B4B3,3 print one character (print a message by number
b $B4B6
B $B4B6,1
c $B4B7
C $B4B9,3 Print a message, the danger indicator (if in space), and 3 CrLf
C $B4BC,3 Fill attribute row 3 from the bottom (row 21) with attribute =5
C $B4C2,3 address in the goods price table
C $B4C7,3 address in the goods price table
C $B4CA,3 print the name and quantity of a good
C $B4CF,3 save print coordinates
C $B4E0,3 restore print coordinates
C $B4E3,3 set the print-register flag, reset X coordinate, increment Y coordinate
C $B4E6,3 good number
C $B4F0,3 Pause of the 14h interrupt
C $B4F3,3 Pause of the 14h interrupt
C $B4FE,3 print the cargo hold contents
c $B501 SellGoodCallback
N $B501 Transaction callback for the Sell screen. Snapshots state, then: PilotCargo[good] -= qty (fail $B0 = not enough held), frees cargo-bay space via IsCargoBayGood if this is a tonne-unit good, and pays out qty x station price via IncCASH in a loop. Unlike buying: does NOT add the sold quantity back to the station's stock (PilotPlanetProduct is untouched, so the station won't resell what you dumped on it), and has no legal -status consequence -- only acquiring contraband is a crime, not offloading it.
C $B508,3 address in the goods quantity table
C $B518,3 get PilotFreeCargo
C $B51C,3 set PilotFreeCargo
C $B520,3 address in the goods price table
C $B526,3 add money
c $B52E ResetTradeWalkPointers
N $B52E Resets the four walking pointers shared by all trade screens (byte_AF30 = 0, and word_AF31/AF33/AF35 each set one entry before their respective table so the same "advance, then use" loop body serves every row including the first).
C $B52E,3 commander data offset +23 (PilotRnd)
C $B531,3 address in the goods quantity table
C $B537,3 address in the goods price table
C $B53B,3 good number
c $B53F Cmd_4_BuyEquip
N $B53F Equipment purchase menu
C $B542,3 print one character (print a message by number
b $B545
B $B545,1 print everything in uppercase
c $B546
C $B548,3 'EQUIP'
C $B54B,3 print one character (print a message by number
b $B54E
B $B54E,1 SHIP
c $B54F
C $B54F,3 print one character (print a message by number
b $B552
B $B552,1 set flags for printing in lowercase
c $B553
C $B556,3 base prices for ship equipment
C $B55C,3 73 ???
C $B567,3 number of items in the Equip menu
C $B56B,3 current good's number
C $B571,3 get PilotMission1
C $B575,2 next good
C $B579,3 ; number of digits to print for the number (padded on the left with spaces or zeros)
C $B57C,3 current good's number
C $B580,3 Print a number
C $B583,3 set the X print coordinate
b $B586
B $B586,1
c $B587
C $B587,2 'i'
C $B589,3 current good's number
C $B58D,3 print the equipment name
C $B590,3 set the X print coordinate
b $B593
B $B593,1
c $B594
C $B5A3,3 Print a number
C $B5A6,3 set the print-register flag, reset X coordinate, increment Y coordinate
C $B5A9,3 next good
C $B5AD,3 current good's number
C $B5B4,3 clear two character-cell lines
C $B5B7,3 print one character (print a message by number
b $B5BA
B $B5BA,1
c $B5BB
C $B5BB,2 '?'
C $B5BD,3 Item?
C $B5CB,3 set the print-register flag, reset X coordinate, increment Y coordinate
C $B5D2,3 print info for key 'L'
C $B5D6,3 number of items in the Equip menu
C $B5DA,3 print info for key 'L'
C $B5EA,3 decrease money (whole thousands)
C $B5F4,3 decrease money (from 0 to 999.9)
C $B601,3 get PilotMission1
C $B608,3 current galaxy number? fractional part of the fuel price
C $B60E,2 'F'
C $B610,3 set fuel
C $B613,3 equipment purchase menu
c $B616
C $B61A,3 number of missiles
C $B62B,3 get PilotLargeCargo
C $B670,3 clear the screen with attribute $07, draw a border around the whole screen, set the initial text-print coordinates
C $B673,3 Fill attribute row 3 from the bottom (row 21) with attribute =5
C $B67A,3 set the X print coordinate
C $B67F,3 set the Y coordinate, checking for going off-screen
C $B685,2 'h'
C $B688,3 print a message from group 1 in the buffer/on screen
C $B68D,3 set the Y coordinate, checking for going off-screen
C $B691,3 current good's number
C $B694,3 set the X print coordinate
C $B698,3 current good's number
C $B69B,2 '0'
C $B69D,3 print a message with a trailing space
C $B6A0,3 current good's number
C $B6A3,2 '`'
C $B6A5,3 print a message, with LF/CR at the end
C $B6A8,3 current good's number
C $B6B0,3 clear two character-cell lines
C $B6B3,3 print one character (print a message by number
b $B6B6
B $B6B6,1
c $B6B7
C $B6B7,3 print one character (print a message by number
b $B6BA
B $B6BA,1
c $B6BB
C $B6BB,3 wait for a keypress
C $B6BE,2 '0'
C $B6C3,2 '4'
C $B6C9,3 print a message, with LF/CR at the end
C $B6CD,2 '0'
C $B6CF,3 42 FrontLaser
C $B6F4,3 add money
C $B6FA,3 equipment purchase menu
c $B702
b $B708
W $B708,2
c $B70A
c $B713
C $B713,3 mission-1 byte =0 mission not given <>0 mission 1 given
c $B719 Calc_HLaddA
N $B719 Out: d =0
N $B719 e=a
c $B71E
C $B71E,2 '|'
C $B722,2 'h'
C $B729,3 print a message with a trailing space
C $B72C,3 print one character (print a message by number
C $B736,3 print info for key 'L'
s $B739
S $B739,1
S $B73A,1
S $B73B,2
S $B73D,1
c $B73E PrintHeaderMap
N $B73E Print the galaxy map header
N $B73E A - message number
C $B73F,3 set the X print coordinate
b $B742
B $B742,1
c $B743
C $B744,3 Print a message, the danger indicator (if in space), and 3 CrLf
c $B749 FillAttr_3line
N $B749 Fill the top three attribute rows with an attribute
N $B749 and draw a line at the bottom of the third character row
N $B749 In: A - attribute
C $B74C,2 '`'
C $B754,3 print a horizontal line
@ $B757 label=SavePrintNumber
s $B757
c $B759 PrintPrice_A
N $B759 Print a number in the form (12345=>1234.5)
N $B759 In: a - number to print
N $B759 Out: (DigitsInNumber)=$00
N $B759 (FlgPrnNumber)=$01
N $B759 a=$01
N $B759 hl,de,bc - ????
C $B75A,2 print a number
c $B75C PrintNumber_A
N $B75C Print a number
C $B75D,2 print a number
C $B760,1 print a number
C $B762,3 print leading zeros or spaces before the number
C $B768,3 set FlgPrnNumber
C $B76B,3 for storing the number to print
C $B771,3 print the most-significant digit of a number
C $B777,3 print the most-significant digit of a number
C $B77D,3 print the most-significant digit of a number
C $B783,3 print the most-significant digit of a number
C $B789,3 get FlgPrnNumber
C $B791,3 print one digit a - digit
C $B794,3 print one character (print a message by number
b $B797
B $B797,1
c $B798
C $B798,3 for storing the number to print
C $B79C,3 print one digit a - digit
C $B7A0,3 ; number of digits to print for the number (padded on the left with spaces or zeros)
C $B7A4,3 set FlgPrnNumber
c $B7A8 PrintCashPilot
N $B7A8 Print the amount of money
N $B7A8 In: ----
N $B7A8 Out: hl,de,bc,a - ????
C $B7A8,3 get PilotCash2
C $B7AB,4 pilot's money (from 0 to 1000)
c $B7AF PrintNumber_HLDE
N $B7AF Print a number
N $B7AF HL - number
N $B7AF DE - number
C $B7B6,3 ; number of digits to print for the number (padded on the left with spaces or zeros)
C $B7BA,3 print a number
C $B7BE,3 set FlgPrnNumber
C $B7C3,3 ; number of digits to print for the number (padded on the left with spaces or zeros)
C $B7CA,3 ; number of digits to print for the number (padded on the left with spaces or zeros)
C $B7CF,3 print a number
c $B7D2 PrintDigitNumber
N $B7D2 Print the most-significant digit of a number
N $B7D2 In: de - which digit to print
N $B7D2 (LLB757) - number to print
N $B7D2 Out: (LLB757) - remainder of the number to print
N $B7D2 hl,de,bc,a - ????
C $B7D2,3 for storing the number to print
C $B7DF,3 for storing the number to print
C $B7E7,3 set FlgPrnNumber
C $B7EB,2 '0' ; print one digit a - digit
C $B7ED,3 print a message from group 1 in the buffer/on screen
C $B7F0,3 get FlgPrnNumber
C $B7F4,2 print one digit a - digit
c $B7F7 PrintPrefixNumber
N $B7F7 Print leading zeros or spaces before the number
N $B7F7 In: hl - number
N $B7F7 (LLA88D)=$00 print zeros
N $B7F7 (LLA88E) - maximum number of digits in the number
N $B7F7 cy=1 - the number must be printed as at least two digits
N $B7F7 Out: b=$00
N $B7F7 hl,de,c,a - ????
C $B809,3 check cy=0 if hl>=de
C $B80E,3 'd'
C $B811,3 check cy=0 if hl>=de
C $B819,3 check cy=0 if hl>=de
C $B821,3 check cy=0 if hl>=de
C $B82A,3 ; number of digits to print for the number (padded on the left with spaces or zeros)
C $B833,3 get FlgPrnNumber
C $B83A,2 ' '
C $B83F,2 '0'
C $B841,3 print a message from group 1 in the buffer/on screen
c $B848 Compare_HL_DE
N $B848 Check cy=0 if hl>=de
N $B848 In: ----
N $B848 Out: cy=1 - hl<de
N $B848 cy=0 - hl>=de
c $B84D IncCASH
N $B84D Trading code never computes price x quantity as a single multiplication -- it calls this once per unit inside a djnz loop instead, sidestepping 16-bit overflow entirely (the priciest good at maximum quantity would overflow a 16-bit product) at the cost of a few hundred cycles nobody notices.
N $B84D Add money
N $B84D In: de - amount of money (from 0.1 to 6553.5)
N $B84D Out: hl,de - undefined
C $B84D,3 get PilotCash1
C $B851,3 set PilotCash1
C $B85B,3 set PilotCash1
@ $B861 label=IncCASH_1K
N $B861 Trading code never computes price x quantity as a single multiplication -- it calls this once per unit inside a djnz loop instead, sidestepping 16-bit overflow entirely (the priciest good at maximum quantity would overflow a 16-bit product) at the cost of a few hundred cycles nobody notices.
C $B861,3 get PilotCash2
C $B865,3 set PilotCash2
c $B869 DecCASH_1000
N $B869 Trading code never computes price x quantity as a single multiplication -- it calls this once per unit inside a djnz loop instead, sidestepping 16-bit overflow entirely (the priciest good at maximum quantity would overflow a 16-bit product) at the cost of a few hundred cycles nobody notices.
N $B869 Decrease money (whole thousands)
N $B869 In: de - amount of money (from 1000 to 65535000)
N $B869 Out: cy=1 - not enough money
N $B869 hl,de - ????
C $B869,3 get PilotCash2
C $B870,3 set PilotCash2
c $B877 DecCASH
N $B877 Trading code never computes price x quantity as a single multiplication -- it calls this once per unit inside a djnz loop instead, sidestepping 16-bit overflow entirely (the priciest good at maximum quantity would overflow a 16-bit product) at the cost of a few hundred cycles nobody notices.
N $B877 Decrease money (from 0 to 999.9)
N $B877 In: de - amount of money (from 0.1 to 6553.5)
N $B877 Out: cy=1 - not enough money
N $B877 hl,de,a - ????
C $B877,3 get PilotCash1
C $B87F,3 get PilotCash2
C $B887,3 set PilotCash2
C $B890,4 get PilotCash1
C $B895,3 set PilotCash1
c $B89A PrnSpecialMessage2
N $B89A Call a routine by number
N $B89A A - number
C $B89A,3 00h ret
C $B89F,3 00h ret
c $B8AC
C $B8AE,3 print a message from group 2 in the buffer/on screen
C $B8B1,3 pause of the 24h interrupt
c $B8B4 PrnCASHxxxx
N $B8B4 Print the message CASH: ?????????.? CR
C $B8B6,3 print a message with a trailing colon
C $B8B9,3 print the amount of money
c $B8C0 PrnPilotName
N $B8C0 Print the pilot's name
C $B8C0,3 1..11 pilot name
c $B8C5 SetFlgPrn_0xx
N $B8C5 Capitalize the first letter of each word
c $B8C9 PrintXXLightYears
N $B8C9 Print the message (FUEL: ?.? LIGHT YEARS)
C $B8C9,2 'i'
C $B8CB,3 print a message with a trailing colon
C $B8CE,3 print one character (print a message by number
C $B8D1,2 X coordinate =$04, set the print-register flag
C $B8D5,3 print a number in the form (12345=>1234.5)
C $B8DA,3 print a message, with LF/CR at the end
c $B8DD PrintGalaxyNum
N $B8DD Print the galaxy number
C $B8DF,3 ; number of digits to print for the number (padded on the left with spaces or zeros)
C $B8E2,3 get PilotNumGalaxy
C $B8E6,3 print a number
c $B8E9 PrnPlanetOccup
N $B8E9 Print the name of the captured planet (the first generated name)
C $B8E9,3 galaxy data
C $B8EC,3 data for generating a planet
C $B8F4,3 generate the planet name and prepare data for generating the next name
C $B8F7,3 for generating the planet name
c $B8FC PrintPlanetPresent
N $B8FC Print the name of the active planet
C $B8FC,3 Set the print-register flag (capitalize first letter)
C $B8FF,3 name of the active planet
c $B904 PrnPlanetDest
N $B904 Print the name of the planet the ship is set to
C $B904,3 Set the print-register flag (capitalize first letter)
C $B907,3 name of the planet the ship is set to
C $B90A,3 print a message
c $B90D SetCrdX_04
N $B90D X coordinate =$04, set the print-register flag
C $B90D,3 set the X print coordinate
b $B910
B $B910,1
c $B911 SetFlgPrn_xx1
N $B911 Set the print-register flag (capitalize first letter)
C $B913,3 set FlgPrnSym3
c $B917 PrnRndPairChr
N $B917 Print a pseudo-random word (2-8 characters)
N $B917 In: ---
N $B917 Out: hl,de,bc,a - undefined
C $B917,3 Set the print-register flag (capitalize first letter)
C $B91A,3 convert variables for building the description
C $B920,3 convert variables for building the description
C $B923,2 '>'
c $B93B SetFlgPrn_2xx
N $B93B Capitalize the first letter of the message
c $B93F nullsub_1
c $B940 SetFlgPrn_1xx
N $B940 Print everything in uppercase
C $B942,3 set FlgPrnSym1
c $B946 PrnPlDestNewCase
N $B946 Print the planet name in a different (grammatical) case
N $B946 In: ---
N $B946 Out: hl,de,bc,a - undefined
C $B946,3 Set the print-register flag (capitalize first letter)
C $B949,3 name of the planet the ship is set to
C $B94C,3 print a message
b $B96E
B $B96E,4
B $B972,5
c $B977
N $B977 Set the print routine to LLBAE7
N $B977 In: ----
N $B977 Out: a,(LLBA98)=$01
c $B97B
N $B97B Set the print routine to LLBA9D
N $B97B In: ----
N $B97B Out: a,(LLBA98)=$00
C $B97D,3 set FlagBlockMessage
c $B981
N $B981 Crd Y=$06
c $B985
N $B985 Crd Y=$0A
C $B987,3 set the Y coordinate, checking for going off-screen
c $B98A
C $B98B,2 '?'
C $B98E,3 print a message from group 1 in the buffer/on screen
c $B991 Cmd_P_InfoPlanet
N $B991 Print planet info
C $B991,3 find the planet nearest the cursor, build its data, set it as the current target, and draw the cursor if the map is displayed
C $B994,3 Print the menu frame
C $B997,3 22 attributes +2 line feeds
C $B99A,3 Set screen attributes
C $B99F,3 planet info: DATA OF planetname
C $B9A4,3 set the Y coordinate, checking for going off-screen
C $B9A7,3 Print the distance to the planet on the map
C $B9AA,3 set the print-register flag, reset X coordinate, increment Y coordinate
C $B9AD,3 planet info: Economy ...
C $B9B2,3 planet info: Government ...
C $B9B8,3 government (government type)
C $B9C1,3 planet info: Tech. level
C $B9C6,3 ; number of digits to print for the number (padded on the left with spaces or zeros)
C $B9C9,3 Tech/Level (tech level)
C $B9CD,3 planet info: Tech. level ....
C $B9D3,2 planet info: population
C $B9D5,3 print a message with a trailing colon
C $B9D8,3 population n/10 of the form x.x
C $B9DB,3 planet info: population ...
C $B9E0,3 planet info: population ... billion
C $B9E3,3 planet info: (
b $B9E6
B $B9E6,1
c $B9E7
C $B9E7,3 planet info: ................
C $B9EA,3 print the letter 'S'
b $B9ED
B $B9ED,1
c $B9EE
C $B9EE,2 ')'
C $B9F0,3 planet info: )
C $B9F3,2 'o'
C $B9F5,3 planet info: Gross productivity
C $B9F8,3 Gross productivity (gross income)
C $B9FD,3 ; number of digits to print for the number (padded on the left with spaces or zeros)
C $BA01,3 planet info: Gross productivity nnnnn
C $BA04,3 print a space
b $BA07
B $BA07,1
c $BA08
C $BA08,3 print the letter 'M'
b $BA0B
B $BA0B,1
c $BA0C
C $BA0E,3 print: CR
C $BA16,3 print: Average radius
C $BA19,3 print: radius
C $BA1C,3 print a space
b $BA1F
B $BA1F,1
c $BA20
C $BA22,3 good number
C $BA25,3 print: km
C $BA28,3 CrLf twice
C $BA2B,3 get PilotMission3
C $BA2F,2 print the planet description
C $BA31,3 if the planet is first in the generation list
C $BA34,3 compare galaxy data with HL
C $BA37,2 print the planet description
C $BA39,2 attribute
C $BA3B,3 address of the attribute row
C $BA46,3 print the message about the planet being captured by the Thargons
C $BA49,3 print the planet description
C $BA55,2 generate and print a short planet summary (at the very bottom) (excluded)
C $BA57,3 print a message from group 2 in the buffer/on screen
c $BA5A
C $BA5A,3 print a message, with LF/CR at the end
C $BA5F,3 set the print-register flag, reset X coordinate, increment Y coordinate
C $BA62,3 set the print-register flag, reset X coordinate, increment Y coordinate
c $BA65 PrintEconomyPlanet
N $BA65 Print the economy type with two CRLFs
C $BA65,2 'p'
C $BA67,3 Economy:
C $BA6A,3 Economy
C $BA6F,2 message: MAINLY
C $BA71,2 Message: RICH
C $BA75,3 Message: RICH
b $BA78
B $BA78,1
c $BA79
C $BA79,3 Economy
C $BA80,2 Message, one of: INDUSTRIAL AGRICULTURAL
C $BA84,3 message: MAINLY
b $BA87
B $BA87,1
c $BA88
c $BA8A PrintTypePopulation
N $BA8A Print the planet's population type
C $BA90,3 used only in Cmd_P_PlanetInfo
C $BA93,2 message: HUMAN COLONIAL
@ $BA98 label=FlagBlockMessage
b $BA98
B $BA98,1 message-block flag =0 TextMessages1 <>0 TextMessages2
c $BA99 PrintSymbol_SP
N $BA99 Print one character
N $BA99 (print message by number
N $BA99 In: message number after the call
N $BA99 Out: hl,de,bc,a - ????
N $BA99 )
c $BA9D PrintMessage1_A
N $BA9D Print a message from group 1 in the buffer/on screen
N $BA9D In: A - message number
C $BA9F,3 0..0Dh
C $BAA2,2 ' '
C $BAA7,2 '`'
C $BAA9,3 print a character honoring the case flags
C $BAAE,2 search for the message start in memory
C $BAB7,2 search for the message start in memory
C $BAB9,2 'r'
C $BABB,3 search for the message start in memory
C $BAC1,3 HL - message start address
C $BACC,1 HL - message start address
C $BAD0,3 print a message from group 1 in the buffer/on screen
C $BAD5,2 HL - message start address
c $BAD7 PrintMessage2
N $BAD7 Print a message from group 2 in the buffer/on screen
N $BAD7 In: a - message number [$01..$00]
N $BAD7 Out: (LLBA98)=$00 - use print routine LLBA9D
C $BAD7,3 $00 " AC?SS ME? 1 2"
C $BADC,2 hl=9314 print the planet description
c $BAE7
C $BAE8,3 get FlagBlockMessage
C $BAEE,2 print a message from group 1 in the buffer/on screen
C $BAF0,2 ' '
C $BAF2,3 call a routine by number A - number
C $BAF5,2 '['
C $BAF7,2 print a character honoring the case flags
C $BAFB,3 for printing messages $5B..$80
C $BB00,2 print a message from group 2 in the buffer/on screen
C $BB02,3 print a two-character syllable
c $BB05
N $BB05 Hl=9314 print the planet description
C $BB0E,2 hl=9314 print the planet description
c $BB10 PrintSymbol_A
N $BB10 Print a character honoring the case flags
N $BB10 In: a - character code
N $BB10 (LLA80D),(LLA80E) - print coordinates
N $BB10 Out: hl,de,bc,a - ????
C $BB10,2 'A'
C $BB14,2 '['
C $BB19,3 get FlgPrnSym1
C $BB20,3 get FlgPrnSym3
C $BB27,3 set FlgPrnSym3
C $BB2A,3 set FlgPrnSym2
C $BB2F,3 get FlgPrnSym2
C $BB37,3 set FlgPrnSym2
C $BB3A,3 get FlgPrnSym1
C $BB44,2 ' '
C $BB4C,3 set FlgPrnSym2
C $BB4F,3 get FlgPrnDescr
C $BB54,3 print the planet description into a line
c $BB58 PrintSymbol_8x8
N $BB58 Print one character
N $BB58 In: a - character's print code
N $BB58 Out: hl,de,bc,a - undefined
C $BB59,3 character print coordinates
C $BB5C,1 coordinate X=X+1
C $BB5D,1 check the X coordinate and line-feed if needed
C $BB5E,2 ' '
C $BB60,2 A - character's print code
C $BB65,3 Increment Y coordinate
C $BB68,1 A - character's print code
C $BB69,3 font
C $BB6C,2 ' '
C $BB90,3 calculate the on-screen print address
C $BB9A,3 calculate the on-screen print address
C $BBA4,2 calculate the on-screen print address
C $BBA6,2 bc=a*16
C $BBB5,3 get CrdXPrnSymbol
C $BBB9,1 HL - print address
C $BBBA,1 DE - address in the font
c $BBC6 FillAttr_21line
N $BBC6 Fill attribute row 3 from the bottom (row 21) with attribute =5
C $BBD2,1 hl = hl + 20h
c $BBD3 PrnHorLineY13
N $BBD3 Draw a horizontal line on screen
c $BBD6 PrintHorLine
N $BBD6 Print a horizontal line
N $BBD6 In: HL - address on screen
C $BBD8,2 ' '
c $BBDA Fill_HL_A_Len_B
c $BBDF SetAttrFrom_DE
N $BBDF Set screen attributes
N $BBDF de - address of the row with the setup mechanics
N $BBDF bit 7-3 - number of character cells horizontally, attribute =5
N $BBDF bit 2-1 - number of line feeds without setting attributes
N $BBDF =0 print two attributes =7 at 5822 and 5823, then exit
C $BBF8,2 ' '
c $BC0C
N $BC0C Print a two-character syllable
N $BC0C In: a - syllable code
N $BC0C (LLA80D),(LLA80E) - print coordinates
N $BC0C Out: hl,de,bc,a - ????
C $BC15,3 character pairs for generating the planet name
C $BC1F,3 print a character honoring the case flags
C $BC25,2 '?'
C $BC28,3 print a character honoring the case flags
c $BC2B PrnMsgDescrPlanet
N $BC2B For printing messages $5B..$80
C $BC2D,2 '['
C $BC30,3 0..7
C $BC36,3 convert variables for building the description
C $BC3B,2 '3'
C $BC40,2 'f'
C $BC55,3 print a message from group 2 in the buffer/on screen
c $BC58 NextDescrPlanet
N $BC58 Convert variables for building the description
N $BC58 In: ---
N $BC58 Out: a - pseudo-random number
N $BC58 hl,de - undefined
c $BC6C Mult_Ax2_sign
N $BC6C Multiply by 2, preserving the sign
N $BC6C In: a - number
N $BC6C Out: c=a*2, 7,c=7,a
b $BC76
B $BC76,38
@ $BC9C label=SaveSP3
W $BC9C,2
c $BC9E ClsAndPrintFrame
N $BC9E Clear the screen with attribute $07,
N $BC9E draw a border around the whole screen,
N $BC9E set the initial text-print coordinates
N $BC9E In: ---
N $BC9E Out: (LLA80D) - print coordinates
N $BC9E hl,de,bc,a - ????
C $BCC9,3 ' '
C $BCE5,3 print a horizontal line
C $BCEB,3 print a horizontal line
C $BCF2,3 set CrdXPrnSymbol
@ $BCF6 label=AdrInMsgDescr2
s $BCF6
S $BCF6,2
@ $BCF8 label=LenMsgDescr1
S $BCF8,1
@ $BCF9 label=LenMsgDescr2
S $BCF9,1
@ $BCFA label=AdrInMsgDescr1
S $BCFA,2
c $BCFC PrnSym2MsgDesc
N $BCFC Print the planet description into a line
N $BCFC In: a - character code
N $BCFC (CrdXPrnSymbol),(CrdYPrnSymbol) - print coordinates
N $BCFC Out: bc =$0020
N $BCFC hl,de,a - undefined
C $BD05,2 '.'
C $BD07,3 print the built string
C $BD15,2 ' '
C $BD18,3 print the built string
C $BD1B,3 find the first space from the end of the line
C $BD43,3 print the built string
C $BD53,3 find the first space from the end of the line
C $BD56,3 search for a zero starting from address (#R$BCF6)
c $BD5D PrintMsgDescr
N $BD5D Print the built string
N $BD5D In: ---
N $BD5D Out: bc =$0020
N $BD5D hl,de,a - undefined
C $BD65,3 print one character
C $BD6D,3 set the print-register flag, reset X coordinate, increment Y coordinate
C $BD72,3 set FlgPrnSym2
C $BD8D,2 ' '
c $BD9D ClearDescrMsg
N $BD9D Clear the description lines and set variables
N $BD9D In: ---
N $BD9D Out: bc =$0020
N $BD9D hl,de,a - undefined
C $BD9F,3 set FlgPrnDescr
C $BDA4,2 ' '
c $BDB9 CloseDescrMsg
N $BDB9 Finish printing the planet description
N $BDB9 In: ---
N $BDB9 Out: hl,de,bc,a - undefined
C $BDBB,3 set FlgPrnDescr
C $BDC2,3 print the built string
c $BDC6 FindLastSpace
N $BDC6 Find the first space from the end of the line
N $BDC6 In: (AdrInMsgDescr2) - address of the last character in the line
N $BDC6 Out: b - number of characters from the end of the line to the space, including the space
N $BDC6 (AdrInMsgDescr2) - address of the last space in the line
C $BDCE,2 ' '
C $BDE2,2 find the first space from the end of the line
c $BDE4 ECM_On
N $BDE4 Turn on the ECM system, if available
C $BDEC,3 set PilotECMSystem
C $BDF1,3 set TimeWorkECM
s $BDF5
S $BDF5,11
@ $BE00 label=TablSqr
S $BE00,512
@ $C000 label=FontAfterLoad
S $C000,728
@ $C2D8 label=ScrBuffer2
S $C2D8,1064
@ $C700 label=AtrCockpitLoad
S $C700,256
@ $C800 label=BufCockpit
S $C800,2048
c $D000
N $D000 Search for a zero starting from address (#R$BCF6)
C $D000,2 ' '
c $D00F PrintTypePopulation2
N $D00F Used only in Cmd_P_PlanetInfo
C $D01D,3 Message: LARGE
C $D02D,3 Message: GREEN
C $D030,3 6 bytes for generating planet data
C $D043,3 Message: SLIMY
C $D051,2 one of: RODENT FROG LIZARD LOBSTER BIRD HUMANOID FELINE INSECT
C $D053,3 print a message from group 1 in the buffer/on screen
c $D056 PrintRadiusPlanet
N $D056 Print the planet's radius
C $D065,3 ; number of digits to print for the number (padded on the left with spaces or zeros)
C $D069,3 print a number
c $D06C CompareGalaxyData
N $D06C Compare galaxy data with HL
N $D06C In: hl - address of the data to compare
N $D06C Out: cy =1 not equal
N $D06C cy =0 identical
C $D06C,3 galaxy data
c $D07D Cmd_K_MarketPrice
N $D07D Print the list of goods on the planet
C $D07D,3 Print the menu frame
C $D082,3 print the menu title
C $D088,3 set CrdXPrnSymbol
C $D08D,3 print a message, with LF/CR at the end
C $D090,3 27 attributes +2 line feeds
C $D093,3 Set screen attributes
C $D096,3 get InFreeSpace
C $D09C,3 good number
C $D0A2,3 address in the goods price table
C $D0A5,3 74 ???
C $D0A8,3 address in the goods quantity table
C $D0AB,3 print the name, price and quantity of a good
C $D0AE,3 good number
b $D0B8
B $D0B8,1
c $D0B9 Cmd_L_PilotInfo
N $D0B9 Print info for key 'L'
C $D0BB,3 set WhatOnScreen
C $D0C0,3 print a message from group 2 in the buffer/on screen
C $D0C3,3 print the danger indicator and the missile indicator
C $D0C9,3 Set screen attributes
C $D0CC,3 set the X print coordinate
b $D0CF
B $D0CF,1
c $D0D0
C $D0D0,3 print one character (print a message by number
b $D0D3
B $D0D3,1
c $D0D4
C $D0D6,3 set the Y coordinate, checking for going off-screen
C $D0D9,2 print the current planet's name
C $D0DB,3 Print the message ':message'
C $D0DE,2 print the destination planet's name
C $D0E0,3 Print the message ':message'
C $D0E5,3 set the Y coordinate, checking for going off-screen
C $D0E8,3 print the remaining fuel
b $D0EB
B $D0EB,1
c $D0EC
C $D0EC,3 print the remaining money
b $D0EF
B $D0EF,1
c $D0F0
C $D0F0,2 'q'
C $D0F2,3 print 'Legal Status'
C $D0F5,3 print one character (print a message by number
b $D0F8
B $D0F8,1
c $D0F9
C $D0FB,3 pilot's legal status 0 - clean 1..31h offender 32h..FFh fugitive
C $D101,2 '2'
C $D108,3 print the legal status
C $D10B,2 'r'
C $D10D,3 print 'Rating'
C $D110,3 print one character (print a message by number
b $D113
B $D113,1
c $D114
C $D131,3 print the rating
b $D137
B $D137,1
c $D138
C $D13B,3 get PilotLargeCargo
C $D13E,3 print one character (print a message by number
b $D141
B $D141,1
c $D142
C $D142,3 get PilotFuelScoops
C $D145,3 print one character (print a message by number
b $D148
B $D148,1
c $D149
C $D149,3 +93 extra equipment present 7,=1 - ECM Jammer 6,=1 - Cloaking device 5,=1 - cannot buy goods (refugees in the hold) 4 3 =1 mission 3 was completed 2 =1 - mission 3 completed 1 =1 - mission 2 completed 0 =1 - mission 1 completed
C $D150,2 ECM Jammer
C $D152,3 print a message from group 2 in the buffer/on screen
C $D15A,3 get PilotECMSystem
C $D15D,3 print one character (print a message by number
b $D160
B $D160,1
c $D161
C $D161,3 get PilotEnergyBomb
C $D164,3 print one character (print a message by number
b $D167
B $D167,1
c $D168
C $D168,3 get PilotEnergyUnit
C $D16B,3 print one character (print a message by number
b $D16E
B $D16E,1
c $D16F
C $D16F,3 57 docking computer
C $D172,3 print one character (print a message by number
b $D175
B $D175,1
c $D176
C $D176,3 58 hyperdrive
C $D179,3 print one character (print a message by number
b $D17C
B $D17C,1
c $D17D
C $D182,3 42 FrontLaser
C $D188,3 Print the laser name
C $D18E,3 +93 extra equipment present 7,=1 - ECM Jammer 6,=1 - Cloaking device 5,=1 - cannot buy goods (refugees in the hold) 4 3 =1 mission 3 was completed 2 =1 - mission 3 completed 1 =1 - mission 2 completed 0 =1 - mission 1 completed
C $D195,3 Cloaking device
b $D198
B $D198,1
c $D199
c $D19C PrintMessage_SP_ifAnotZero
N $D19C Print one character
N $D19C (print message by number
N $D19C In: message number after the call
N $D19C A =0 do not print
N $D19C Out: hl,de,bc,a - ????
N $D19C )
C $D1A3,3 print a message from group 1 in the buffer/on screen
c $D1A6
C $D1A6,3 set the print-register flag, reset X coordinate, increment Y coordinate
C $D1AB,3 set the X print coordinate
c $D1AE PrintLaserName
N $D1AE Print the laser name
C $D1BE,2 '`'
C $D1C0,3 print a message with a trailing space
C $D1C8,2 'r'
C $D1CC,2 'f'
C $D1CF,3 print a message from group 1 in the buffer/on screen
c $D1D5 PrintMessage_A
N $D1D5 Print the message ':message'
N $D1D5 A - message number
C $D1D6,3 set the X print coordinate
b $D1D9
B $D1D9,1
c $D1DA
C $D1DA,3 print one character (print a message by number
b $D1DD
B $D1DD,1
c $D1DE
C $D1DF,3 print a message, with LF/CR at the end
b $D1E2
B $D1E2,6
B $D1E8,4
c $D1EC PrnShipBoarded
N $D1EC Print the message "ship captured by pirates"
C $D1F3,3 Special message (refugees, pirates, mission 3, etc.)
C $D1F7,3 print a message from group 2 in the buffer/on screen
C $D1FA,2 ']'
C $D1FC,3 print a message from group 2 in the buffer/on screen
C $D202,3 set CrdXPrnSymbol
C $D207,3 print a message from group 2 in the buffer/on screen
C $D20A,3 sound beep
C $D20D,3 wait for a keypress
C $D210,3 clear the screen with attribute $07, draw a border around the whole screen, set the initial text-print coordinates
C $D213,3 Pause of the 24h interrupt
C $D216,3 initialize ship movement parameters
c $D219 GiveMission3
N $D219 Offer of mission 3
C $D21F,3 Special message (refugees, pirates, mission 3, etc.)
C $D222,3 wait for a keypress
C $D225,2 'Y'
C $D229,1 Refusal
C $D22A,3 set PilotMission3
C $D22E,3 +93 extra equipment present 7,=1 - ECM Jammer 6,=1 - Cloaking device 5,=1 - cannot buy goods (refugees in the hold) 4 3 =1 mission 3 was completed 2 =1 - mission 3 completed 1 =1 - mission 2 completed 0 =1 - mission 1 completed
C $D235,3 set PilotMission3
C $D23E,3 Special message (refugees, pirates, mission 3, etc.)
c $D243 EndMission3
N $D243 Successful completion of mission 3
C $D248,3 set PilotMission3
C $D24B,3 +93 extra equipment present 7,=1 - ECM Jammer 6,=1 - Cloaking device 5,=1 - cannot buy goods (refugees in the hold) 4 3 =1 mission 3 was completed 2 =1 - mission 3 completed 1 =1 - mission 2 completed 0 =1 - mission 1 completed
c $D258 PrintSpecialMessage
N $D258 Special message (refugees, pirates, mission 3, etc.)
C $D25A,3 clear the screen with attribute $07, draw a border around the whole screen, set the initial text-print coordinates
C $D25D,2 '\'
C $D25F,3 print a message from group 2 in the buffer/on screen
C $D264,3 set CrdXPrnSymbol
C $D276,3 print a message from group 2 in the buffer/on screen
c $D279 Cmd_Ent_Inventory
N $D279 Print the cargo hold contents
C $D27B,3 set WhatOnScreen
C $D280,3 print a message from group 2 in the buffer/on screen
C $D285,3 Print a message, the danger indicator (if in space), and 3 CrLf
C $D28B,3 Set screen attributes
C $D290,3 set the Y coordinate, checking for going off-screen
C $D293,3 print one character (print a message by number
b $D296
B $D296,1
c $D297
C $D299,3 print a message, with LF/CR at the end
C $D29C,3 get PilotLargeCargo
C $D2AA,3 print one character (print a message by number
b $D2AD
B $D2AD,1
c $D2AE
C $D2AE,3 set the print-register flag, reset X coordinate, increment Y coordinate
C $D2B1,3 +93 extra equipment present 7,=1 - ECM Jammer 6,=1 - Cloaking device 5,=1 - cannot buy goods (refugees in the hold) 4 3 =1 mission 3 was completed 2 =1 - mission 3 completed 1 =1 - mission 2 completed 0 =1 - mission 1 completed
C $D2BA,3 print a message from group 2 in the buffer/on screen
C $D2BD,3 set the print-register flag, reset X coordinate, increment Y coordinate
C $D2C1,3 good number
C $D2C4,3 commander data offset +23 (PilotRnd)
C $D2C7,3 address in the goods quantity table
C $D2CA,3 print the name and quantity of a good
C $D2CD,3 set the print-register flag, reset X coordinate, increment Y coordinate
C $D2D0,3 good number
b $D2DA
B $D2DA,2
@ $D2DC label=Dat_D2DC
B $D2DC,4 attributes for the tape menu, attribute + 4 line feeds
B $D2E0,1 attributes + 2 attributes at 5822, 5823
B $D2E1,1 =1 the save has been loaded
@ $D2E2 label=SaveSP7
B $D2E2,2
c $D2E4 MenuSaveLoad
N $D2E4 Tape menu
N $D2E4 A =0 game not loaded
N $D2E4 nZ - saved game loaded
N $D2E4 Z - not loaded
C $D2E4,3 clear the screen with attribute $07, draw a border around the whole screen, set the initial text-print coordinates
C $D2E7,3 attributes for the tape menu, 1 attribute + 4 line feeds
C $D2EA,3 Set screen attributes
C $D2ED,3 Fill attribute row 3 from the bottom (row 21) with attribute =5
C $D2F2,3 fill the top three attribute rows with an attribute and draw a line at the bottom of the third character row
C $D2F6,3 =1 the save has been loaded
C $D2FA,3 print a message from group 2 in the buffer/on screen
C $D305,3 wait for a keypress
C $D308,2 '1'
C $D313,3 exit the menu
C $D316,3 clear the pressed-key bits
C $D319,3 =1 the save has been loaded
C $D320,3 entered text (pilot name when saving/loading, planet name when searching)
C $D32E,3 load the postponed game
C $D337,3 =1 the save has been loaded
C $D33C,3 we print something
C $D33F,3 entered text (pilot name when saving/loading, planet name when searching)
C $D342,3 1..11 pilot name
C $D35A,3 1..11 pilot name
C $D360,3 data for printing the sun, 9 bytes long, crd low x planet
C $D363,3 sun data, 9 bytes, copied here when saving
C $D36D,3 we print something
C $D370,3 wait for a keypress
C $D37E,3 if there is an error
C $D383,3 we print something
C $D389,3 set CrdXPrnSymbol
C $D38C,2 the message "Security number"
C $D38E,3 print a message from group 2 in the buffer/on screen
C $D391,3 generate the code
C $D399,3 get PilotNumGalaxy
C $D39C,3 +93 extra equipment present 7,=1 - ECM Jammer 6,=1 - Cloaking device 5,=1 - cannot buy goods (refugees in the hold) 4 3 =1 mission 3 was completed 2 =1 - mission 3 completed 1 =1 - mission 2 completed 0 =1 - mission 1 completed
C $D3AB,3 get PilotCash2
C $D3C0,2 '='
C $D3C4,2 'f'
C $D3D1,3 print a number
C $D3D6,3 ; number of digits to print for the number (padded on the left with spaces or zeros)
C $D3DA,3 set FlgPrnNumber
C $D3DF,3 print a number
C $D3E2,3 1..11 pilot name
C $D3E5,3 for keeping the last loaded game in memory
c $D3F0
c $D3FF
C $D400,3 get PressKeyPrnSymbol
C $D403,2 ' '
C $D407,3 clear two character-cell lines
C $D416,3 restore pilot data from memory
c $D41B
C $D41B,4 1..11 pilot name
C $D41F,3 'h'
c $D425
C $D429,3 input a text string
c $D42C
C $D42E,3 set FlgPrnSym1
C $D434,3 set CrdXPrnSymbol
C $D43B,3 print a message from group 2 in the buffer/on screen
C $D43E,3 set the print-register flag, reset X coordinate, increment Y coordinate
C $D441,3 sound beep
@ $D444 label=msgTimePause
s $D444
S $D444,1
@ $D445 label=msgTimeLife
S $D445,1
@ $D446 label=msgBlink
S $D446,1
@ $D447 label=msgCrdX
S $D447,1
@ $D448 label=msgNumber
S $D448,1
@ $D449 label=LastBonusCash
S $D449,2
@ $D44B label=nMsgDamage
S $D44B,1
c $D44C PrnMsgOnViewScr
C $D44D,3 set FlgPrnSym1
C $D450,3 get WhatOnScreen
C $D455,2 print "Front view" into the buffer
C $D45A,2 nop, printing via ld
C $D45C,3 Print a message on the view screen
C $D45F,3 xor c, printing via xor
C $D465,3 print "Front view" into the buffer
C $D46D,3 set CrdXPrnSymbol
C $D470,3 get WhatOnScreen
C $D473,2 '`'
C $D475,3 print a message from group 1 in the buffer/on screen
C $D47A,3 print a message, with LF/CR at the end
C $D47D,3 Print a message on the view screen
c $D486 SetPrnMsgOnVS
N $D486 Print a message on the view screen
C $D486,3 Print the countdown before the jump
C $D489,3 print the danger indicator and the missile indicator
C $D48C,3 lifetime (number of print frames) of an in-flight message =$00 nothing needs to be printed
C $D491,2 print an in-flight message
C $D493,3 blinking loop for a combat message
C $D499,2 set secondary messages
C $D49D,3 7,=1 missile launch failed 6-0,= Y print coordinate of the message
C $D4AF,3 sound beep
C $D4B5,3 lifetime (number of print frames) of an in-flight message =$00 nothing needs to be printed
C $D4B9,3 Y print coordinate of the message (in combat: bonus/destroyed)
C $D4BD,3 =FD something has already been destroyed (message number) (some cargo)
C $D4C1,1 print an in-flight message
C $D4C5,3 get WhatOnScreen
C $D4CB,3 Y print coordinate of the message (in combat: bonus/destroyed)
C $D4D1,3 set CrdXPrnSymbol
C $D4D4,3 =FD something has already been destroyed (message number) (some cargo)
C $D4DF,3 =FD something has already been destroyed (message number) (some cargo)
C $D4E2,3 print a message, with LF/CR at the end
C $D4E5,3 message number for what got damaged in combat
C $D4E8,2 's'
C $D4F2,3 print a message from group 1 in the buffer/on screen
C $D4F7,3 cash reward for a combat kill
C $D4FB,3 print a number
c $D500 SetSecondaryMsg
N $D500 Set secondary messages
C $D500,3 get ShieldUnit4
C $D507,3 get FuelScoopsOn
C $D50D,3 get AutoDocking
C $D511,2 b - message number DOCKING COMPUTER ON
C $D513,3 pause between mission messages (1st and 3rd)
C $D51A,2 'F'
C $D51D,3 get PilotMission3
C $D521,2 b - message number MAYDAY! xxxx Invaded!
C $D523,3 get PilotMission1
C $D528,3 get PilotMission1_1
C $D52D,3 b - message number MAYDAY! Coriolis In Danger!
C $D534,3 b - message number MAYDAY! xxxx Invaded!
C $D539,3 b - message number DOCKING COMPUTER ON
C $D53E,3 get PilotFuelScoops
C $D543,3 get Pilot_Fuel
C $D547,3 set fuel
C $D54A,3 b - message number FUEL SCOOPS ON c - Y print coordinate
C $D551,3 set CloakingDeviceOn
C $D556,3 get WhatOnScreen
C $D55B,3 print view-screen attributes
c $D563 ResetBattleMessages
N $D563 Clear all messages during flight
N $D563 In: ---
N $D563 Out: a =$00
N $D563 b =$00
N $D563 hl,MissileJammed+9
C $D565,3 7,=1 missile launch failed 6-0,= Y print coordinate of the message
C $D56F,3 =FD something has already been destroyed (message number) (some cargo)
@ $D573 label=JumpCountdown
b $D573
B $D573,1 countdown to the jump =$00 no countdown yet
c $D574 GoJump
N $D574 Handle hyperjump keys G, H
C $D574,3 7,=1 - CapsS -- Pause 6,=1 - J -- Jump Drive 5,=1 - G -- Galactic Hyper Drive 4,=1 - H -- Hyper Drive 3,=1 - 4 -- Right View/Equip Ship 2,=1 - 3 -- Left View/Sell Cargo 1,=1 - 2 -- Rear View/Buy Cargo 0,=1 - 1 -- Front View/Launch
C $D582,3 =$01 G or H pressed (jump)
C $D585,3 get JumpCountdown
C $D58A,3 get IndDanger
C $D58E,2 docked, jump not possible
C $D592,2 hyperjump
C $D597,3 58 hyperdrive
C $D59B,1 no hyperdrive
C $D59E,3 set JumpDocking
C $D5A6,3 hyperjump
C $D5A9,3 fuel required to travel to the planet =distance*4
C $D5AE,2 not enough fuel for the jump
C $D5B4,3 get Pilot_Fuel
C $D5B8,2 not enough fuel for the jump
C $D5BC,3 set JumpDocking
C $D5BF,3 coordinates to print the countdown digits
C $D5C4,3 set JumpCountdown
C $D5C7,3 lifetime (number of print frames) of an in-flight message =$00 nothing needs to be printed
C $D5CD,3 sound beep
C $D5D0,3 not enough fuel for the jump
C $D5D6,3 docked, jump not possible
C $D5DC,3 set CrdXPrnSymbol
C $D5E1,3 set FlgPrnSym1
C $D5E6,3 print a message from group 2 in the buffer/on screen
C $D5E9,3 sound beep
C $D5EC,3 Pause of the 24h interrupt
C $D5EF,3 clear the pressed-key bits
C $D5F2,3 print info for key 'L'
c $D5F5 PrnCountdownJump
N $D5F5 Print the countdown before the jump
C $D5F5,3 countdown to the jump =$00 no countdown yet
C $D5FC,2 the jump itself
C $D601,3 ; number of digits to print for the number (padded on the left with spaces or zeros)
C $D607,3 set CrdXPrnSymbol
C $D60D,3 print a number
C $D610,3 the jump itself
C $D613,3 get JumpDocking
C $D618,2 jump to another planet
C $D61A,1 intergalactic jump
C $D61B,3 set PilotMission3
C $D61E,3 get PilotMission1
C $D625,3 set PilotMission1
C $D628,3 set PilotMission1_1
C $D62B,3 58 hyperdrive
C $D62E,3 get PilotNumGalaxy
C $D632,3 current galaxy number? fractional part of the fuel price
C $D637,3 set PilotNumGalaxy
C $D63A,3 galaxy data
C $D63D,3 update bytes for the next galaxy
C $D640,3 update bytes for the next galaxy
C $D643,3 update bytes for the next galaxy
C $D647,3 pilot's legal status 0 - clean 1..31h offender 32h..FFh fugitive
C $D64A,3 find the planet nearest the cursor, build its data, set it as the current target, and draw the cursor if the map is displayed
C $D64D,2 Hyperjump
c $D64F NextGalaxyData
N $D64F Update bytes for the next galaxy
N $D64F In: ---
N $D64F Out: b =$00
N $D64F a - galaxy number
N $D64F hl - undefined
c $D65A
N $D65A Jump to another planet
C $D65A,3 get PilotMission1
C $D65E,2 intergalactic jump
C $D660,3 fuel required to travel to the planet =distance*4
C $D664,3 get Pilot_Fuel
C $D669,3 set fuel
C $D66C,2 'F'
C $D670,3 Economy
C $D675,3 current galaxy number? fractional part of the fuel price
C $D678,3 pilot's legal status 0 - clean 1..31h offender 32h..FFh fugitive
C $D67D,3 get FlagsSetUp
C $D684,3 get RndWord
C $D689,2 Hyperjump
C $D68C,3 set InFreeSpace
C $D68F,3 X coordinate of the current system
C $D692,3 X coordinate of the small cursor on the large map
C $D69A,3 Y coordinate of the current system
C $D69D,3 +103 (last byte to save) Y coordinate of the small cursor on the large map
C $D6A7,3 set CoriolisNear
C $D6AA,3 name of the active planet
C $D6AD,3 name of the planet the ship is set to
c $D6B3
N $D6B3 Hyperjump
C $D6B4,3 set InFreeSpace
C $D6B7,3 6 bytes for generating planet data
C $D6BA,3 ?????
C $D6C2,3 name of the planet the ship is set to
C $D6C5,3 name of the active planet
C $D6CD,3 Tech/Level (tech level)
C $D6D0,3 73 ???
C $D6D3,3 government (government type)
C $D6D6,3 74 ???
C $D6D9,3 generate quantities and prices of goods at the station
C $D6DF,3 data for printing the sun, 9 bytes long, crd low x planet
C $D6E8,3 set J_Drive_Coriolis
C $D6EB,3 6 bytes for generating planet data
C $D6FB,3 set SunCrdX_hi
C $D703,3 set SunCrdY_hi
C $D70E,3 set SunCrdZ_hi
C $D716,3 set PlanetCrdX_hi
C $D71E,3 set PlanetCrdY_hi
C $D727,3 set PlanetCrdZ_hi
C $D72E,3 planet coordinates in space
C $D731,3 length 27h
C $D737,3 get PlanetCrdZ_hi
C $D741,3 get PlanetCrdX_hi
C $D772,3 crd med z planet
C $D788,3 crd high x planet
C $D79F,3 crd high z planet
C $D7B4,3 get Pilot_CrdXTarget
C $D7B7,3 set Pilot_CrdXSystem
C $D7BA,3 get Pilot_CrdYTarget
C $D7BD,3 set Pilot_CrdYSystem
C $D7C0,3 get PilotNumGalaxy
C $D7C6,3 7,=1 mission 3 completed
C $D7CF,3 +92 >0 - mission 3 given =1 mission 3 will be given on docking ( =1 time to give the mission, will become =2 after the jump) =2 mission 3 will be given on docking =3 mission 3 given (the station can be destroyed with a missile) (Thargons launch from the station) =4 mission 3 given, the ship is in the target system (the station can be destroyed with a missile) (Thargons launch from the station) =5 mission 3 completed, there will be congratulations on docking
C $D7E1,3 ?????
C $D7E4,3 compare galaxy data with HL
C $D7EB,3 set PilotMission3
C $D7EE,3 get JumpCounter
C $D7F2,3 set JumpCounter
C $D7F5,3 +93 extra equipment present 7,=1 - ECM Jammer 6,=1 - Cloaking device 5,=1 - cannot buy goods (refugees in the hold) 4 3 =1 mission 3 was completed 2 =1 - mission 3 completed 1 =1 - mission 2 completed 0 =1 - mission 1 completed
C $D7F9,1 bit 0
C $D7FA,2 give mission 1
C $D7FC,1 bit 1
C $D7FD,2 give mission 2
C $D7FF,1 bit 2
C $D800,2 give mission 3
C $D802,3 random number
C $D805,3 74 ???
C $D80F,3 coriolis+$1D =0 the station isn't rotating, meaning it's been captured by pirates
C $D816,3 set FlgJumpDocking
C $D81A,3 set WhatOnScreen
C $D81D,3 set Temperature
C $D820,3 set FuelScoopsOn
C $D823,3 set Missile1
C $D826,3 set PilotMission2
C $D829,3 =$01 G or H pressed (jump)
C $D82E,3 set Altitude
C $D833,2 ' '
C $D83A,2 giving mission 1
C $D83C,3 set PilotMission1
C $D83F,2 ;paper 0, ink 2
C $D841,3 print view-screen attributes
C $D844,3 zero out fuel
C $D849,1 giving mission 2
C $D853,1 giving mission 3
C $D85D,3 set PilotMission3
c $D862 SetFuelZero
N $D862 Zero out fuel
N $D862 In: ---
N $D862 Out: b,a - undefined
C $D862,3 get Pilot_Fuel
C $D867,3 7,=1 - fuel was zeroed out
c $D86D SetPilotFuel
N $D86D Set fuel
N $D86D In: a - new Fuel value
N $D86D Out: b - undefined
C $D86D,2 'G'
C $D871,2 'F'
C $D873,3 set Pilot_Fuel
C $D87F,3 set Fuel
@ $D883 label=CursorWidth
s $D883
S $D883,1
@ $D884 label=CrdYUpGalaxyMap
S $D884,1
@ $D885 label=CrdYDownGalaxyMap
S $D885,1
c $D886 PrintCursorOnScr
N $D886 Print the cursor on the galaxy map screen
N $D886 In: (PrnCrdXCursor) - X print coordinate [1..$FE]
N $D886 (PrnCrdYCursor) - Y print coordinate
N $D886 (CursorWidth) - cursor width
N $D886 Out: hl,de,bc,a - undefined
C $D886,3 cursor width
C $D88C,3 get PrnCrdXCursor
C $D890,2 cursor extends past the left boundary
C $D892,2 cursor extends past the left boundary
C $D894,1 cursor is entirely on screen
C $D895,3 get PrnCrdYCursor
C $D89A,3 calculate the screen address
C $D89D,3 get PrnCrdXCursor
C $D8A1,2 cursor extends past the right boundary
C $D8AA,3 cursor width
C $D8C8,3 cursor extends past the left boundary
C $D8CD,3 calculate the screen address
C $D8D0,3 get PrnCrdXCursor
C $D8EE,3 cursor extends past the right boundary
C $D90F,3 calculate the right part of the cursor
C $D912,3 calculate the left part of the cursor
C $D91B,3 calculate the right part of the cursor
C $D922,3 calculate the left part of the cursor
C $D927,3 print the left mask
C $D92B,3 calculate the right part of the cursor
C $D92E,3 calculate the left part of the cursor
C $D93C,3 print the right mask
C $D940,3 calculate the right part of the cursor
C $D955,3 calculate the left part of the cursor
C $D96D,1 calculate the right part of the cursor
C $D975,1 calculate the left part of the cursor
C $D97D,2 calculate the screen address
C $D985,2 '8'
C $D98E,2 '@'
C $D99D,1 print the right mask
C $D9A2,1 print the left mask
C $D9A5,3 cursor width
C $D9AB,3 not used, always =00, coordinate of the map's top edge (only affects cursor display on the map)
C $D9AF,3 get PrnCrdYCursor
C $D9B9,3 get PrnCrdXCursor
C $D9BC,3 calculate the screen address
C $D9BF,3 coordinate of the map's bottom edge (only affects cursor display on the map)
C $D9C3,3 get PrnCrdYCursor
C $D9C9,3 cursor width
C $D9D6,3 cursor width
C $D9DB,3 get PrnCrdXCursor
C $D9DE,3 calculate the screen address
C $D9E1,3 get PrnCrdXCursor
C $DA02,2 ' '
@ $DA0B label=RadiusBlast
b $DA0B
B $DA0B,1 circle radius when printing an explosion
@ $DA0C label=PilotMission2
B $DA0C,2 =3 the Asp from mission 2 is destroyed / there is a canister with the cloak in space =2 the Asp's invisibility is off =1 mission 2 given =0 while moving on the J-drive
@ $DA0E label=FrameCounter
B $DA0E,1 ship-appearance counter???? frame counter
@ $DA0F label=J_Drive_Ready4
B $DA0F,1 =1 an object nearby is blocking the J-drive <>0 J-drive unavailable
@ $DA10 label=EnergyBombUsed
B $DA10,1 <>0, =1, =$FF energy bomb exploded
@ $DA11 label=FlgObjNear
B $DA11,1 <>0 there is some object nearby
@ $DA12 label=ObjInTarget
B $DA12,2 <>0 there is something in the crosshair (object number???)
@ $DA14 label=PlayerPirate
B $DA14,1 =1 the player attacked a peaceful trader/station/police. enable aggression
@ $DA15 label=ManualDocking
B $DA15,1 =0 when leaving the planet <>0 manual docking started????
@ $DA16 label=TimeWorkECM
B $DA16,1 remaining system runtime =0 ECM off
@ $DA17 label=DamageEnergyUnit
B $DA17,1 damage to the energy units
@ $DA18 label=DamageFrontShield
B $DA18,1 damage to the front shields
@ $DA19 label=DamageRearShield
B $DA19,1 damage to the rear shields
@ $DA1A label=FlgCoriolisNear
B $DA1A,1 <>0 there is a station nearby
@ $DA1B label=nMissileObj
B $DA1B,1 number of missiles in space >=4, random ships don't appear
@ $DA1C label=InverseNumSlotIX
B $DA1C,1 reverse slot number of the object whose slot address is in IX (possibly targeted)
c $DA1D MoveAllObjects
N $DA1D Process all objects in space
N $DA1D In: ---
N $DA1D Out: ix,iy,hl,de,bc,a - undefined
C $DA1D,3 get PilotMission3
C $DA24,3 2,=1 Coriolis is hostile
C $DA29,3 get TypeOfPrint
C $DA2D,2 or c
C $DA2F,2 adjust the line-printing routine
C $DA31,2 xor c
C $DA33,3 adjust the line-printing routine
C $DA3F,3 get FrameCounter
C $DA43,3 set FrameCounter
C $DA47,3 get CoriolisNear
C $DA4D,3 get InFreeSpace
C $DA53,3 get nMissileObj
C $DA5C,3 set rnd ship
C $DA60,3 set DamageEnergyUnit
C $DA63,3 set DamageRearShield
C $DA66,3 set DamageFrontShield
C $DA69,3 set ObjInTarget
C $DA6C,3 set FlgCoriolisNear
C $DA6F,3 set FlgObjNear
C $DA72,3 set J_Drive_Ready4
C $DA75,1 c=0
C $DA76,4 length 27h
C $DA7A,3 '''
C $DA7D,2 c=0
C $DA85,2 next
C $DA8B,2 next (not a missile)
C $DA90,1 a,c number of missiles
C $DA91,3 set nMissileObj
C $DA94,4 length 27h
C $DA9C,3 set InverseNumSlotIX
C $DAA3,3 next object
C $DAA6,3 set FlgObjNear
C $DAAF,3 set FlgCoriolisNear
C $DAB2,3 get FrameCounter
C $DABE,3 set J_Drive_Ready4
C $DAC1,3 get EnergyBombUsed
C $DACD,3 iy - start address of the ship descriptor, the previous one???
C $DAD0,2 '''
C $DADC,2 object is not aggressive
C $DAE1,2 '`'
C $DAE7,3 set PlayerPirate
C $DAEA,3 missile descriptor +$22
C $DAEE,2 if there is at least one missile, enable aggression
C $DAF0,3 get PlayerPirate
C $DAF3,1 if the invisibility cloak is on, enable aggression
C $DB01,2 iy address of the object data
C $DB06,2 '0'
C $DB08,2 ????
C $DB0A,2 ' '
C $DB0C,3 ????
C $DB13,3 =0
C $DB1F,2 branch if it's a missile
C $DB21,3 which sound to play =$00 no sound (silent) 0,=1 energy bomb exploded 1,=1 missile launched 2,=1 colliding with an object/object destroyed 3,=1 laser fired 4,=1 laser fired 5,=1 ECM working 6,=1 hit by laser on the player/docking damage 7,=1
C $DB26,3 get PilotMission2
C $DB2A,2 destroy the object
C $DB2E,2 the Asp from mission 2 was destroyed
C $DB34,2 destroy the object
C $DB38,3 the Asp from mission 2 was destroyed
C $DB3D,2 destroy the object
C $DB40,3 set PilotMission2
C $DB43,1 destroy the object
C $DB47,3 object has disappeared from space (destroyed/flown off). Untarget the missile and destroy any missiles fired at this object
C $DB50,3 increase the money amount
C $DB5D,3 increase combat rating
C $DB63,2 '`'
C $DB65,2 next object
C $DB67,3 pilot's legal status 0 - clean 1..31h offender 32h..FFh fugitive
C $DB6A,2 '@'
C $DB6C,3 pilot's legal status 0 - clean 1..31h offender 32h..FFh fugitive
C $DB6F,2 next object
C $DB71,1 b - reverse slot number of the object whose slot address is in IX c - ship-appearance counter????
C $DB79,2 object is not controlled
C $DB7F,2 not a missile
C $DB81,3 this is a missile
C $DB88,3 object's reaction to the player. Launching missiles, ships, escape capsule, etc.
C $DB8B,3 recalculate object coordinates
C $DB8E,3 align the Y axis to be orthogonal to the X axis
C $DB98,3 x=x*l y=y*l z=z*l, ix=ix+6
C $DB9B,3 x=x*l y=y*l z=z*l, ix=ix+6
C $DB9E,3 x=x*l y=y*l z=z*l, ix=ix+6
C $DBA3,3 check for collision of the object with the player, and handle it
C $DBA6,3 compute visibility and print the object
C $DBB0,2 '0'
C $DBB4,2 next object
C $DBBE,1 next object
C $DBBF,3 '''
C $DBC9,3 set EnergyBombUsed
C $DBCC,3 get J_Drive_Ready4
C $DBD1,3 set PlayerPirate
c $DBD5 CalcLenVector
N $DBD5 Compute vector length and normalize the vector
N $DBD5 In: ix - address of the vector's per-axis lengths
N $DBD5 Out: de=sqrt(dX^2+dY^2+dZ^2) vector length
N $DBD5 (ix) - normalized vector coordinates
N $DBD5 a =$00
C $DBD7,3 squaring
C $DBDB,3 squaring
C $DBDF,3 squaring
C $DBE6,2 hl=dX^2+dY^2+dZ^2
C $DBE8,3 extract the square root h=sqr(hl)
C $DBEB,1 de=sqrt(dX^2+dY^2+dZ^2)
C $DBEE,3 dX = dX / sqrt(dX^2+dY^2+dZ^2) / 2
C $DBF1,3 dY = dY / sqrt(dX^2+dY^2+dZ^2) / 2
C $DBF4,3 dZ = dZ / sqrt(dX^2+dY^2+dZ^2) / 2
c $DBFA Sqr_HL_wordAdrIX
N $DBFA Squaring
N $DBFA In: HL = high(word(ix+0/1)^2)
C $DC08,3 Approximate table-based multiplication HL=B*C
c $DC31 CaclNormalVector
N $DC31 Normalize the vector
N $DC31 In: ix - address of the dX/dY/dZ variable
N $DC31 de - vector length (divisor)
N $DC31 a =$00
N $DC31 Out: (ix) - normalized vector coordinate
N $DC31 ix=ix+2
N $DC31 bc - undefined
N $DC31 a =$00
C $DC3A,3 fixed-point division hl.a/de
C $DC3F,2 b.c = hl.a/de/2
c $DC53 Sqrt_H_HL
N $DC53 Extract the square root h=sqr(hl)
N $DC53 In: hl - number
N $DC53 Out: h - result
N $DC53 l - remainder
N $DC53 a=0
N $DC53 de,bc - undefined
C $DC98,3 fixed-point division hl.a/de
c $DCA3 CorrAxisVector
N $DCA3 Normalize the vector (correcting small computation errors)
N $DCA3 In: ix - vector start address
N $DCA3 Out: ix=ix+6
N $DCA3 hl,de,bc,a - undefined
C $DCA5,3 hl address of the squares table (high bytes)
C $DCB9,2 hi(dx)^2+hi(dy)^2+hi(dz)^2
c $DCC6
C $DCCB,3 Approximate table-based multiplication HL=B*C
@ $DCDE label=AngleLR4Calc
s $DCDE
S $DCDE,1
@ $DCDF label=AngleDU4Calc
S $DCDF,1
c $DCE0 ReCalcCrdObj
N $DCE0 Recalculate object coordinates
N $DCE0 In: ix - start address of the object slot
N $DCE0 (InverseNumSlotIX) - its reverse index in the slot list
N $DCE0 Out: hl,de,bc,a - undefined
C $DCE0,3 update object coordinates from player movement
C $DCE7,2 check the object's distance along Z
C $DCE9,1 check the object's distance along Z
C $DCEA,2 '`'
C $DCEC,2 the object has moved far away, remove it from space
C $DCEE,1 check the object's distance along Z
C $DCF1,2 check the object's distance along X
C $DCF3,1 the object has moved far away, remove it from space
C $DCF7,3 object has disappeared from space (destroyed/flown off). Untarget the missile and destroy any missiles fired at this object
C $DCFA,3 check the object's distance along X
C $DCFF,2 the object has moved far away, remove it from space
C $DD01,3 check the object's distance along Y
C $DD06,2 the object has moved far away, remove it from space
C $DD08,3 get HighAngleLR
C $DD0B,3 ship rotation angle 7,n sign $00.$0F
C $DD13,2 ix start address of the rotation angles
C $DD15,3 rotate the OCS axis vector by the given angles
C $DD18,3 rotate the OCS axis vector by the given angles
C $DD1B,3 rotate the OCS axis vector by the given angles
C $DD3D,3 ship rotation angle 7,n sign $00.$0F
C $DD5D,3 up/down rotation angle 7,n sign $00.$0F
C $DD62,3 rotate the like-named coordinates of the OCS axis vectors by the given angles
C $DD65,3 rotate the like-named coordinates of the OCS axis vectors by the given angles
C $DD68,3 rotate the like-named coordinates of the OCS axis vectors by the given angles
C $DD9D,3 update the object's global coordinates from its speed
C $DDA0,3 update the object's global coordinates from its speed
C $DDA3,3 update the object's global coordinates from its speed
c $DDAB CalcNewCrdObjSpeed
N $DDAB Update the object's global coordinates from its speed
N $DDAB In: ix=iy address of the object descriptor
N $DDAB c - object speed (ix+oSpeed)
N $DDAB Out: hl,de,a - undefined
C $DDB2,3 compute the increment for the object's global coordinate high((d.e * speed*4)/$100+$FF) =34b =389/425t
C $DDBE,3 coordinate increment bh.l = ah.l + d.e
c $DDD6 CaclDeltaCrdObj
N $DDD6 Compute the increment for the object's global coordinate
N $DDD6 high((d.e * speed*4)/$100+$FF)
N $DDD6 =34b
N $DDD6 =389/425t
N $DDD6 In: de - coordinate n of the OCS X axis
N $DDD6 c - object speed (ix+oSpeed)
N $DDD6 Out: d.e - increment of the object's global coordinate
c $DDF8 CrdNAddDeltaCrd
N $DDF8 Coordinate increment bh.l = ah.l + d.e
N $DDF8 In: ah.l - coordinate (7,a = sign)
N $DDF8 d.e - coordinate increment (7,d = sign)
N $DDF8 Out: bh.l - new coordinate (7,b - new sign)
c $DE0B RotateAxisSCO
N $DE0B Rotate the OCS axis vector by the given angles
N $DE0B In: ix - address of the OCS axis vector
N $DE0B Out: ix=ix+6
N $DE0B de=$0006
N $DE0B bc,a - undefined
C $DE0B,3 up/down rotation angle 7,n sign $00.$0F
C $DE1B,3 compute the new coordinate of the object's coordinate-system axis
C $DE21,3 ship rotation angle 7,n sign $00.$0F
C $DE2D,3 compute the new coordinate of the object's coordinate-system axis
C $DE33,3 ship rotation angle 7,n sign $00.$0F
C $DE3D,3 compute the new coordinate of the object's coordinate-system axis
C $DE43,3 up/down rotation angle 7,n sign $00.$0F
C $DE51,3 compute the new coordinate of the object's coordinate-system axis
c $DE5D CalcNewCrdNAxis
N $DE5D Compute the new coordinate of the object's coordinate-system axis
N $DE5D In: a,c - rotation angle
N $DE5D b - Y coordinate of the OCS axis
N $DE5D d - Z coordinate of the OCS axis
N $DE5D Out: a = crd(d) + crd(b) * angle(c)*2 (signs accounted for)
N $DE5D 7,a - sign
N $DE5D de,bc - undefined
C $DE64,3 A=((b+c)/2)^2-((b-c)/2)^2
c $DE88 RotateCrdNSCO
N $DE88 Rotate the like-named coordinates of the OCS axis vectors by the given angles
N $DE88 In: ix - address of the first OCS axis vector's coordinate
N $DE88 Out: ix=ix+2
N $DE88 de,bc,a - undefined
C $DE88,3 up/down rotation angle 7,n sign $00.$0F
C $DE94,3 compute the new coordinate of the object's coordinate-system axis
C $DE9A,3 ship rotation angle 7,n sign $00.$0F
C $DEA6,3 compute the new coordinate of the object's coordinate-system axis
C $DEAC,3 ship rotation angle 7,n sign $00.$0F
C $DEB6,3 compute the new coordinate of the object's coordinate-system axis
C $DEBC,3 up/down rotation angle 7,n sign $00.$0F
C $DEC6,3 compute the new coordinate of the object's coordinate-system axis
c $DED1 CalcNewCrdObj_Pl
N $DED1 Update object coordinates from player movement
N $DED1 In: ix - start address of the object slot
N $DED1 Out: hl.a - crd Z
C $DED1,3 get HighAngleDU
C $DEDD,3 crdZ=crdY*-angleDU/$100+crdZ
C $DEE0,3 get HighAngleLR
C $DEE5,3 multiply by 2, preserving the sign
C $DEED,3 crdX=crdY*-angleLR*2/$100+crdX
C $DEF0,3 get HighAngleLR
C $DEF3,3 multiply by 2, preserving the sign
C $DEFB,3 crdY=crdX*angleLR*2/$100+crdY
C $DEFE,3 get HighAngleDU
C $DF08,3 crdY=crdZ*angleDU/$100+crdY
C $DF0B,3 get HighDeltaSpeed
C $DF0E,1 adjust the Z coordinate from speed
c $DF46 CalcNewCrdNobj
N $DF46 Compute the object's new coordinate from an element of the player's movement vector
N $DF46 In: ix - start address of the object's coordinates
N $DF46 hl =0/3/6 coordinate X/Y/Z
N $DF46 de =0/3/6 coordinate X/Y/Z
N $DF46 c - rotation angle
N $DF46 Out: crd(hl) = crd(de) * c/$100 + crd(hl) (signs accounted for)
N $DF46 hi(crd(de))*c + med(crd(de))*c/$100 + low(crd(de))*c/$10000 + crd(hl)
C $DF64,3 Approximate table-based multiplication HL=B*C
C $DF6B,3 Approximate table-based multiplication HL=B*C
C $DF78,3 A=((b+c)/2)^2-((b-c)/2)^2
c $DFDD RotateIntroObj
N $DFDD Rotate and print an object into the buffer for the intro/title screen
N $DFDD In: ---
N $DFDD Out: iy,ix,hl,de,bc,a - undefined
C $DFDD,4 slot for the missile +00
C $DFE8,2 iy address of the object data
C $DFEC,3 ship rotation angle 7,n sign $00.$0F
C $DFF4,3 align the Y axis to be orthogonal to the X axis
C $DFFB,3 normalize the vector (correcting small computation errors)
C $DFFE,3 normalize the vector (correcting small computation errors)
C $E001,4 slot for the missile +00
c $E008 PrnObjIfVisible
N $E008 Compute visibility and print the object
N $E008 In: ix - address of the object slot
N $E008 iy - address of the object data
N $E008 (sp) - reverse index of the object
N $E008 Out: hl,de,bc,a - undefined
C $E008,3 get WhatOnScreen
C $E00E,1 exit if not the view screen
C $E014,2 left/right
C $E016,3 front/rear
C $E01E,1 cde - distance to the object
C $E027,4 set DistanceToObj
C $E02D,3 distance to collision
C $E034,2 de - distance to the object along the view-screen axis (sp) - distance to collision
C $E036,1 too close.
C $E038,1 de - distance to the object along the view-screen axis (sp) - distance to collision
C $E03C,2 left/right
C $E046,1 cde - crdX hl - distance to the object along the view-screen axis
C $E047,3 division: 0.c=cde/ahl (if dec>hla -> c=$FF)
C $E04B,3 set CrdXProjection
C $E057,3 division: 0.c=cde/ahl (if dec>hla -> c=$FF)
C $E05B,3 set CrdYProjection
C $E06C,3 division: 0.c=cde/ahl (if dec>hla -> c=$FF)
C $E070,3 set CrdXProjection
C $E07C,3 division: 0.c=cde/ahl (if dec>hla -> c=$FF)
C $E080,3 set CrdYProjection
C $E08D,3 set CrdXYsign
C $E094,3 division: 0.c=cde/ahl (if dec>hla -> c=$FF)
C $E099,3 set RadiusBlast
C $E09D,3 get CrdYProjection
C $E0A4,2 '@'
C $E0A6,3 print the enemy laser beam
C $E0A9,3 get CrdXProjection
C $E0B2,3 print the enemy laser beam
C $E0C0,2 ','
C $E0C8,3 set ObjInTarget
C $E0D7,3 get WhatOnScreen
C $E0ED,2 '@'
C $E0F2,2 ' '
C $E0FE,3 set values for printing the object's explosion
C $E101,3 get PilotMission2
C $E10B,3 print the enemy laser beam
C $E10E,3 get DistanceToObj
C $E115,2 print the object and an enemy laser shot
C $E117,3 get CrdXProjection
C $E11C,3 print the enemy laser beam
C $E120,3 get CrdYProjection
C $E123,2 '?'
C $E125,3 print the enemy laser beam
C $E129,3 get WhatOnScreen
C $E12E,3 get CrdXYsign
C $E149,2 '?'
C $E14E,2 '?'
C $E152,3 print a single dot
C $E156,3 print a single dot
C $E15A,3 print a single dot
C $E15E,3 print a single dot
C $E161,3 print the enemy laser beam
c $E164 objPrnPixel
N $E164 Print a single dot
N $E164 In: bc - coordinates
c $E175 objPrnObj
N $E175 Print the object and an enemy laser shot
C $E177,3 build the OCS rotation matrix
C $E17C,3 get DistanceToObj
C $E18F,3 set DistanceToObj
C $E194,3 set PointTablCrdPrn
C $E197,3 build the face-visibility table from the normals
C $E19A,3 build the table of print coordinates for the object's visible vertices
C $E19D,3 print the object
C $E1A8,3 get a vertex's print coordinates from the table by index
C $E1AC,3 print the enemy laser beam
C $E1C8,3 Print a line in the buffer???
c $E1D4 objDestroyed
N $E1D4 Set values for printing the object's explosion
N $E1D4 In: ---
N $E1D4 Out: hl,de,bc,a - undefined
C $E1D4,3 get CrdXProjection
C $E1DA,3 get CrdYProjection
C $E1E0,3 get RadiusBlast
C $E1E6,3 get WhatOnScreen
C $E1EB,3 get CrdXYsign
c $E206 objPrintLaser
N $E206 Print the enemy laser beam
N $E206 In: ---
N $E206 Out: hl,de,bc,a - undefined
C $E20B,3 get CrdXProjection
C $E20F,3 get CrdYProjection
C $E213,3 get WhatOnScreen
C $E218,3 get CrdXYsign
C $E220,2 print the enemy laser beam
@ $E222 label=TablCrdPrnVertex
b $E222
B $E222,138
@ $E2AC label=VergesVisible
B $E2AC,16
@ $E2BC label=MatrixRotate
B $E2BC,18
@ $E2CE label=data_E2CE
B $E2CE,18
@ $E2E0 label=DistanceToObj
W $E2E0,2 distance to the object along the view-screen axis
@ $E2E2 label=PointTablCrdPrn
B $E2E2,1 pointer to the current entry in the vertex print-coordinate table
@ $E2E3 label=VertexCrdX
W $E2E3,2 vertex coordinates after OCS rotation
@ $E2E5 label=VertexCrdY
W $E2E5,2
@ $E2E7 label=VertexCrdZ
W $E2E7,2
@ $E2E9 label=CrdXProjection
B $E2E9,1 X coordinate of the object's projection
@ $E2EA label=CrdYProjection
B $E2EA,1 Y coordinate of the object's projection
@ $E2EB label=CrdXYsign
B $E2EB,1 signs of the object's projection coordinates
@ $E2EC label=VertexSignCrdX
B $E2EC,1 signs of the vertex coordinates after OCS rotation
@ $E2ED label=VertexSignCrdY
B $E2ED,1
@ $E2EE label=VertexSignCrdZ
B $E2EE,1
@ $E2EF label=VertexIncFactor
B $E2EF,1 maximum possible vertex coordinate scaling factor
@ $E2F0 label=VisiblePrevVertex
B $E2F0,1 visibility of the previous vertex <>0 the previous vertex is not visible
c $E2F1 MakeTablPrnCrdVertex
N $E2F1 Build the table of print coordinates for the object's visible vertices
N $E2F1 In: ix - address of the object slot
N $E2F1 iy - address of the object data
N $E2F1 Out: bc=$0006
N $E2F1 a=$00
N $E2F1 hl,de - undefined
C $E2F5,3 a number of vertices
C $E300,2 ix start address of the vertices
C $E307,3 get PointTablCrdPrn
C $E30C,3 set PointTablCrdPrn
C $E319,3 get DistanceToObj
C $E322,3 check face visibility
C $E32A,3 check face visibility
C $E32D,3 calculate the vertex's print coordinates
C $E331,3 set VisiblePrevVertex
c $E338 TestVergesVisible
N $E338 Check face visibility
N $E338 In: a =$nm - two face numbers
N $E338 Out: a=1/0 face visible/invisible
N $E338 z=1 - face invisible
N $E338 hl,de,b - undefined
C $E339,2 b=b/16
C $E343,3 a=(E2AC+a)
C $E348,3 a=(E2AC+a)
c $E353 RotateCrdN_Vertex
N $E353 Rotate one vertex coordinate
N $E353 In: ix - start address of the vertex coordinates
N $E353 iy =MatrixRotate+n address of a row in the rotation matrix
N $E353 Out: (MatrixRotate+$12) - matrix of products of the vertex coordinate and an element
N $E353 of the rotation matrix
N $E353 hl - new vertex coordinate (coordinate multiplied by a row of the
N $E353 rotation matrix)
N $E353 iy=iy+6
N $E353 b=$00
N $E353 de,c,a - undefined
C $E353,3 get VisiblePrevVertex
C $E395,3 signed addition
C $E3A8,3 signed addition
C $E3B7,3 multiply the coordinate by a matrix element, accounting for the vertex coordinate scaling factor
C $E3D1,3 multiply the coordinate by a matrix element, accounting for the vertex coordinate scaling factor
C $E3E4,3 signed addition
C $E3F0,3 multiply the coordinate by a matrix element, accounting for the vertex coordinate scaling factor
C $E404,3 signed addition
C $E40C,3 get VertexIncFactor
c $E424 AddSign_L_E
N $E424 Signed addition
N $E424 In: hl - first addend $00..$FF (7,h sign)
N $E424 de - second addend $00..$FF (7,d sign)
N $E424 Out: a - sum
N $E424 7,h - sign
N $E424 cy =1 sum overflow
c $E434 Mult_A_hiB_C
N $E434 A=((b+c)/2)^2-((b-c)/2)^2
c $E447 MultCrdNMatrixEl
N $E447 Multiply the coordinate by a matrix element, accounting for the scaling factor
N $E447 of vertex coordinates
N $E447 In: b - abs(crd N) of the vertex
N $E447 iy =MatrixRotate+n address of an element in the rotation matrix
N $E447 (VertexIncFactor) - vertex coordinate scaling factor
N $E447 Out: hl = 0.b*2^(VertexIncFactor) * 0.MatrixElement
N $E447 bc,a - undefined
C $E447,3 get VertexIncFactor
C $E455,3 A=((b+c)/2)^2-((b-c)/2)^2
c $E45D Mult_HL_B_C
N $E45D Approximate table-based multiplication HL=B*C
N $E45D computes: ((b+c)/2)^2 - ((b-c)/2)^2
N $E45D should be: ((b+c)^2 - (b-c)^2)/4
c $E478 AddCrdNobj_CrdNvertex
N $E478 Add the object coordinate and the vertex coordinate
N $E478 In: (sp) - X coordinate of the rotated vertex (low byte*2)
N $E478 cy - X coordinate of the rotated vertex (bit 7)
N $E478 bh.l - object's crdX
N $E478 de - X coordinate of the rotated vertex
N $E478 Out: ah.l = CrdNobject + CrdNvertex * 2
c $E49C RotateCrdVertex
N $E49C Distance greater than 4
C $E49C,3 get VisiblePrevVertex
C $E4B7,3 set VertexCrdX
C $E4CA,3 rotate one vector coordinate
C $E4CD,3 set VertexCrdX
C $E4D0,3 rotate one vector coordinate
C $E4D6,3 rotate one vector coordinate
C $E4DD,3 set VertexCrdXlow
c $E4E9 RotateCrdN_equ_Prev
C $E50D,3 signed addition
C $E520,3 signed addition
c $E52A RotateCrdN
N $E52A Rotate one vector coordinate
N $E52A In: ix - start address of the vector (normal) coordinates
N $E52A iy =MatrixRotate+n address of a row in the rotation matrix
N $E52A Out: (MatrixRotate+$12) - matrix of products of the vector coordinate and an element
N $E52A of the rotation matrix
N $E52A hl - new vector coordinate (vector multiplied by a row of the rotation matrix)
N $E52A iy=iy+6
N $E52A de = $0006
N $E52A bc,a - undefined
C $E532,3 A=((b+c)/2)^2-((b-c)/2)^2
C $E54F,3 A=((b+c)/2)^2-((b-c)/2)^2
C $E564,3 signed addition
C $E572,3 A=((b+c)/2)^2-((b-c)/2)^2
C $E588,3 signed addition
c $E592 Div_C_DEc_HLa
N $E592 Division: 0.c=cde/ahl (if cde>ahl -> c=$FF)
N $E592 In: de.c - dividend
N $E592 hl.a - divisor
N $E592 Out: 0.c=dec/hla
N $E592 cde>ahl -> c=$FF
N $E592 hl,de,b,a - undefined
c $E5B4 CalcDeltaCrdLine2
N $E5B4 Calculate the coordinate step coefficient when printing a line
N $E5B4 In: a - smaller coordinate difference
N $E5B4 b - larger coordinate difference
N $E5B4 c=$FE
N $E5B4 e=$00
N $E5B4 Out: c - increment coefficient along the shorter axis
C $E5BF,2 calculate the coordinate step coefficient when printing a line
C $E5C6,2 calculate the coordinate step coefficient when printing a line
@ $E5C8 label=VertexCrdXlow
b $E5C8
B $E5C8,1 vertex coordinates after OCS rotation (low byte)
@ $E5C9 label=VertexCrdYlow
B $E5C9,1
@ $E5CA label=VertexCrdZlow
B $E5CA,1
c $E5CB CalcPrnCrdVertex
N $E5CB Calculate the vertex's print coordinates
N $E5CB In: ix - vertex address
N $E5CB (sp-2) - object slot address
C $E5CD,3 get DistanceToObj
C $E5D2,3 distance greater than 4
C $E5E5,3 set VertexIncFactor
C $E5E9,3 distance greater than 4
C $E5EC,3 rotate one vertex coordinate
C $E5EF,3 set VertexCrdXlow
C $E5F2,3 set VertexCrdX
C $E5F5,3 rotate one vertex coordinate
C $E5FE,3 rotate one vertex coordinate
C $E608,3 set VisiblePrevVertex
C $E61A,4 get VertexCrdX
C $E61E,3 get VertexCrdXlow
C $E623,3 add the object coordinate and the vertex coordinate
C $E626,3 set VertexCrdX
C $E629,3 set VertexSignCrdX
C $E62D,3 set VertexCrdXlow
C $E642,3 add the object coordinate and the vertex coordinate
C $E661,3 add the object coordinate and the vertex coordinate
C $E66E,3 get WhatOnScreen
C $E675,4 get VertexCrdX
C $E679,3 get VertexCrdXlow
C $E680,3 division: 0.c=cde/ahl (if dec>hla -> c=$FF)
C $E684,3 set CrdXProjection
C $E695,3 division: 0.c=cde/ahl (if dec>hla -> c=$FF)
C $E699,3 set CrdYProjection
C $E69C,3 get VertexSignCrdX
C $E6AB,3 get VertexCrdX
C $E6B2,3 get VertexCrdXlow
C $E6B5,3 division: 0.c=cde/ahl (if dec>hla -> c=$FF)
C $E6B9,3 set CrdXProjection
C $E6C0,3 get VertexCrdX
C $E6C7,3 get VertexCrdXlow
C $E6CA,3 division: 0.c=cde/ahl (if dec>hla -> c=$FF)
C $E6CE,3 set CrdYProjection
C $E6D1,3 get VertexSignCrdX
C $E6E3,3 get WhatOnScreen
C $E6EF,3 set CrdXYsign
C $E6F2,3 get PointTablCrdPrn
C $E6F5,3 +0,1 coordinates +2 direction
C $E6FD,3 get CrdXProjection
C $E702,3 get CrdYProjection
C $E707,3 get WhatOnScreen
C $E70F,3 get CrdXYsign
c $E729 PrintObject
N $E729 Print the object
N $E729 In: ix - address of the object slot
N $E729 iy - address of the object descriptor
N $E729 Out: de=$0004
N $E729 b=$00
N $E729 iy,hl,c,a - undefined
C $E72C,3 de - offset to the edges
C $E72F,3 b number of edges
C $E736,2 start address of the edges
C $E741,3 get DistanceToObj
C $E745,2 next edge
C $E74A,3 check face visibility
C $E74D,2 next edge
C $E752,3 get a vertex's print coordinates from the table by index
C $E755,2 next edge
C $E75C,3 get a vertex's print coordinates from the table by index
C $E761,2 next edge
C $E76A,3 Print a line in the buffer???
C $E76D,1 next edge
c $E778 GetPrnCrdVertex
N $E778 Get a vertex's print coordinates from the table by index
N $E778 In: a - vertex number
N $E778 Out: de - vertex print coordinates
N $E778 a - coordinate signs
N $E778 z =1 the vertex is printed
N $E778 hl - undefined
C $E77A,3 +0,1 coordinates +2 direction
c $E791 CorrAxirY_SKO
N $E791 Align the Y axis to be orthogonal to the X axis
N $E791 In: ix - address of the object slot
N $E791 Out: ix=ix+2
N $E791 iy=iy+2
N $E791 Out: hl,de,bc,a - undefined
C $E7A0,3 dot product of two vectors with one vector's direction flipped
C $E7A4,3 align coordinate n of the Y axis to be orthogonal to the X axis
C $E7A7,3 align coordinate n of the Y axis to be orthogonal to the X axis
C $E7AA,3 align coordinate n of the Y axis to be orthogonal to the X axis
c $E7B2 CorrCrdN_AxisY
N $E7B2 Align coordinate n of the Y axis to be orthogonal to the X axis
N $E7B2 In: ix - coordinate n of the object's X-axis vector
N $E7B2 iy - coordinate n of the object's Y-axis vector
N $E7B2 e - dot product of the object's X-axis and Y-axis vectors
N $E7B2 Out: ix=ix+2
N $E7B2 iy=iy+2
C $E7BA,3 A=((b+c)/2)^2-((b-c)/2)^2
c $E7F3 CalcMatrixRotate
N $E7F3 Build the OCS rotation matrix
N $E7F3 In: ix - address of the object descriptor slot
N $E7F3 Out: iy=MatrixRotate
N $E7F3 hl,de,bc,a - undefined
C $E862,3 Approximate table-based multiplication HL=B*C
C $E867,3 Approximate table-based multiplication HL=B*C
c $E88B
C $E899,3 Approximate table-based multiplication HL=B*C
C $E89C,1 de=e*c
C $E8A2,3 Approximate table-based multiplication HL=B*C
C $E8B3,3 Approximate table-based multiplication HL=B*C
C $E8C7,3 Approximate table-based multiplication HL=B*C
c $E8CF Div_BC_HLAdivDE
N $E8CF Fixed-point division hl.a/de
N $E8CF In: hla - dividend
N $E8CF de - divisor
N $E8CF Out: b.c - =hl.a/de
c $E8F0 CalcDeltaCrd
N $E8F0 Compute the distance along one axis
N $E8F0 In: hl - X/Y/Z coordinate of the first object (7,h sign)
N $E8F0 de - X/Y/Z coordinate of the second object (7,d sign)
N $E8F0 Out: 7,h =1 the first object's coordinate is smaller (to the left)
N $E8F0 hl - distance along the given axis /2
N $E8F0 de,bc,a - undefined
c $E8F4 AddSign_HL_DE
N $E8F4 Signed addition
N $E8F4 In: hl - first addend (7,h sign)
N $E8F4 de - second addend (7,d sign)
N $E8F4 Out: hl - sum/2 (7,h sign)
N $E8F4 de,bc,a - undefined
@ $E917 label=AdrSlotObj
b $E917
W $E917,2 address of the object descriptor in space
@ $E919 label=IY_dFactor
B $E919,1 (iy+$13)
@ $E91A label=AddNormalCrdX
W $E91A,2 sum of the normal vector and the object's vector (coordinates)
@ $E91C label=AddNormalCrdY
W $E91C,2
@ $E91E label=AddNormalCrdZ
W $E91E,2
@ $E920 label=NormalCrdX
B $E920,1 normal vector after OCS rotation
@ $E921 label=NormalCrdY
B $E921,1
@ $E922 label=NormalCrdZ
B $E922,1
c $E923 CalcVisibleVerges
N $E923 Build the face-visibility table from the normals
N $E923 In: ix - address of the object descriptor slot
N $E923 iy - address of the object data
N $E923 (MatrixRotate) - OCS rotation matrix
N $E923 Out: (MatrixRotate+$12) - matrix of products of the vector coordinate and an element
N $E923 of the rotation matrix
N $E923 (VergesVisible) - face-visibility table from normals
N $E923 hl,de,bc,a - undefined
C $E929,2 ix=iy
C $E92B,1 hl=ix
C $E92C,3 set AdrSlotObj
C $E932,3 de offset to the normals
C $E935,2 ix=start address of the normals
C $E937,3 face visibility =0 not visible (normal points away from the player)
C $E93D,3 set IY_dFactor
C $E948,2 a - number of normals de =#R$E2AC ix start address of the normals iy =#R$E2BC
C $E94C,2 exit
C $E94E,1 a - number of normals de =#R$E2AC ix start address of the normals iy =#R$E2BC
C $E95A,3 get DistanceToObj
C $E962,2 next face
C $E966,3 get AdrSlotObj
C $E96D,3 set NormalCrdX
C $E970,3 set AddNormalCrdX
C $E988,4 sum of the normal vector and the object's vector (coordinates)
C $E98C,4 normal vector after OCS rotation
C $E990,3 dot product of vectors
C $E99B,2 next face
C $E99E,1 next face
C $E9A7,2 a - number of normals de =#R$E2AC ix start address of the normals iy =#R$E2BC
C $E9A9,2 exit
c $E9AE ScalarMultVectors16_8
N $E9AE Dot product of vectors
N $E9AE In: iy - start address of the first vector (OCS origin vector + normal vector)
N $E9AE ix - start address of the second vector (normal vector in the OCS)
N $E9AE Out: h.l = crdZ1*crdZ2 + crdY1*crdY2 + crdX1*crdX2
N $E9AE de,bc,a - undefined
C $E9B7,3 Multiplication: h.l = e.c * 0.a * 2 (7,h - sign)
C $E9C4,3 Multiplication: h.l = e.c * 0.a * 2 (7,h - sign)
C $E9D1,3 Multiplication: h.l = e.c * 0.a * 2 (7,h - sign)
C $E9D5,3 signed addition
C $E9E1,3 signed addition
c $E9E4 Mult_HL_EC_A
N $E9E4 Multiplication: h.l = e.c * 0.a * 2 (7,h - sign)
C $E9EB,3 A=((b+c)/2)^2-((b-c)/2)^2
C $E9F4,3 Approximate table-based multiplication HL=B*C
c $EA03 RotateCrdN_Normal
N $EA03 In: ix - start address of the normal's coordinates
N $EA03 iy =MatrixRotate+n address of a row in the rotation matrix
N $EA03 (sp) - address of the object coordinate
N $EA03 Out: (MatrixRotate+$12) - matrix of products of the vector coordinate and an element
N $EA03 of the rotation matrix
N $EA03 hl - sum of the object vector and normal coordinates
N $EA03 a - rotated coordinate n of the normal (7,a=sign)
N $EA03 (sp)=(sp)+3
N $EA03 iy=iy+6
N $EA03 b=$00
N $EA03 de,c - undefined
C $EA03,3 rotate one vector coordinate
C $EA09,3 ade coordinate n
C $EA1C,3 get IY_dFactor
@ $EA4F label=Temp4PrnLaser
s $EA4F
S $EA4F,1
S $EA50,1
c $EA51 CollisionWithObj
N $EA51 Check for collision of the object with the player, and handle it
N $EA51 In: ix - address of the object slot
N $EA51 iy - address of the object data
N $EA51 Out: hl,de,bc,a - undefined
C $EA51,3 get PlayerGameOver
C $EA67,2 d=1, this is a missile and it was fired at the player
C $EA79,1 along the X axis, far from collision
C $EA83,1 along the Y axis, far from collision
C $EA8D,1 along the Z axis, far from collision
C $EA98,2 collision with the object???
C $EA9A,4 object is above the Y axis
C $EA9E,3 destroy the object (we collide)
C $EAA1,3 object is below the Y axis, we pick up cargo
C $EAA5,3 destroy the object (we collide)
C $EAA8,1 we pick up the canister
C $EAAC,3 object has disappeared from space (destroyed/flown off). Untarget the missile and destroy any missiles fired at this object
C $EAAF,3 get PilotFreeCargo
C $EAB3,2 destroy the object (we collide)
C $EAC3,3 get PilotMission2
C $EACA,3 set PilotMission2
C $EACD,1 A=$FF picked up the Cloaking device
C $EAD0,3 Random number
C $EAD5,3 add a found canister to the cargo
C $EAD8,4 collision with the object???
C $EADC,2 destroy the object (we collide)
C $EAE2,2 player destroyed
C $EAE8,2 player destroyed
C $EAEE,2 player destroyed
C $EAF6,2 player destroyed
C $EAFF,2 player destroyed
C $EB01,2 '<'
C $EB03,2 shield damage on collision, depending on speed
C $EB06,2 '<'
C $EB08,2 shield damage on collision, depending on speed
C $EB0C,3 set ManualDocking
C $EB10,3 shield damage on collision, depending on speed
C $EB15,3 high byte of speed $00..$1F
C $EB18,3 get DamageFrontShield
C $EB1F,3 set DamageFrontShield
C $EB23,3 destroy the object (we collide)
C $EB30,1 if it's a missile, the impact energy, otherwise =0
C $EB31,2 'P'
C $EB3A,3 get PilotMission2
C $EB3D,1 pointless check, could just be zeroed
C $EB41,3 set PilotMission2
C $EB44,3 which sound to play =$00 no sound (silent) 0,=1 energy bomb exploded 1,=1 missile launched 2,=1 colliding with an object/object destroyed 3,=1 laser fired 4,=1 laser fired 5,=1 ECM working 6,=1 hit by laser on the player/docking damage 7,=1
C $EB4F,3 get DamageRearShield
C $EB53,3 set DamageRearShield
C $EB56,2 object has disappeared from space (destroyed/flown off). Untarget the missile and destroy any missiles fired at this object
C $EB58,2 player destroyed
C $EB5A,3 set PlayerGameOver
C $EB5E,3 get DamageFrontShield
C $EB62,3 set DamageFrontShield
c $EB65 OffTargetMissiles
N $EB65 Object has disappeared from space (destroyed/flown off). Untarget the missile and
N $EB65 destroy any missiles fired at this object
N $EB65 In: ix - slot address of the destroyed object
N $EB65 (InverseNumSlotIX) - its reverse index in the slot list
N $EB65 Out: de = LenSlotObj
N $EB65 b =$00
N $EB65 hl,a - undefined
C $EB65,3 get InverseNumSlotIX
C $EB6B,4 length 27h
C $EB6F,3 '''
C $EB7C,3 if a missile is targeting a destroyed missile, destroy that missile too
C $EB82,4 probably a bug, should be bit 0,(iy+26h)
C $EB88,4 if the destroyed object is a missile
C $EB90,3 get Missile1
C $EB96,3 get nObjMissile
C $EB9B,3 set Missile1
C $EB9E,3 7,=1 missile untargeted (not by the player)
c $EBA4 SetShipwreck
N $EBA4 Spawn two pieces of debris and a canister when the player is destroyed
C $EBA4,3 which sound to play =$00 no sound (silent) 0,=1 energy bomb exploded 1,=1 missile launched 2,=1 colliding with an object/object destroyed 3,=1 laser fired 4,=1 laser fired 5,=1 ECM working 6,=1 hit by laser on the player/docking damage 7,=1
C $EBAA,3 set WhatOnScreen
C $EBB1,3 '''
C $EBB6,2 zero out all objects
C $EBBB,2 zero out all objects
C $EBBF,3 place Cargo
C $EBC4,3 place two Alloys
c $EBC7 FireLaser
N $EBC7 Player fires the laser
N $EBC7 In: ---
N $EBC7 Out: ix,hl,de,bc,a - undefined
C $EBC7,3 =1 flag: laser was fired in the previous cycle
C $EBCC,3 =1 flag: laser was fired in the previous cycle
C $EBCF,3 laser cooling down
C $EBDA,3 set TempLaser
C $EBDD,3 7,=1 - C -- Docking Computer 6,=1 - Q -- Escape Capsule 5,=1 - W -- Energy Bomb 4,=1 - E -- ECM System 3,=1 - U -- UnTarget 2,=1 - F -- Fire Missile 1,=1 - T -- Target Missile 0,=1 - A -- Fire Laser
C $EBE7,1 laser overheating
C $EBE8,1 laser temperature
C $EBE9,3 get WhatOnScreen
C $EBEC,3 42 FrontLaser
C $EBFB,2 temperature increment
C $EBFF,2 d - laser temperature increment
C $EC03,1 d - laser temperature increment
C $EC07,3 =1 flag: laser was fired in the previous cycle
C $EC0C,3 get FrameCounter
C $EC11,3 get DamageEnergyUnit
C $EC15,3 set DamageEnergyUnit
C $EC18,3 which sound to play =$00 no sound (silent) 0,=1 energy bomb exploded 1,=1 missile launched 2,=1 colliding with an object/object destroyed 3,=1 laser fired 4,=1 laser fired 5,=1 ECM working 6,=1 hit by laser on the player/docking damage 7,=1
C $EC22,2 laser damage strength
C $EC2A,1 laser damage strength
C $EC39,3 set TempLaser
C $EC3C,3 get ObjInTarget
C $EC40,3 print laser beams
C $EC47,4 length 27h
C $EC4B,3 '''
C $EC4F,2 laser hit on the object
C $EC55,4 laser hit on the object
C $EC59,3 which sound to play =$00 no sound (silent) 0,=1 energy bomb exploded 1,=1 missile launched 2,=1 colliding with an object/object destroyed 3,=1 laser fired 4,=1 laser fired 5,=1 ECM working 6,=1 hit by laser on the player/docking damage 7,=1
C $EC5E,4 cannot be destroyed by laser. a station flag?
C $EC62,2 print laser beams
C $EC64,4 cannot be destroyed by laser
C $EC68,2 print laser beams
C $EC7D,3 already destroyed
C $EC82,2 print laser beams
C $EC88,2 object destroyed
C $EC8A,2 print laser beams
C $EC8C,1 object destroyed
C $EC9B,3 get PilotMission2
C $ECA7,3 set PilotMission2
C $ECBF,2 'U'
C $ECC3,2 if max energy >=$55 set alloys
C $ECC5,1 if max energy <>$3C
C $ECC6,2 '<'
C $ECC8,2 print laser beams
C $ECCA,1 if max energy =$3C and damage dealt =$32 set 2 minerals
C $ECCB,2 '2'
C $ECCD,2 print laser beams
C $ECD4,3 print laser beams
C $ECFB,3 Print a line in the buffer???
C $ED07,3 Print a line in the buffer???
C $ED16,3 Print a line in the buffer???
C $ED21,3 print a line in the buffer???
c $ED24 IntRnd_A2
N $ED24 Random number
N $ED24 A - result
b $ED35
W $ED35,2
c $ED37 Process_LaserECM2
C $ED38,3 set HighAngleDU
C $ED3B,3 set HighDeltaSpeed
c $ED3F Process_LaserECM
N $ED3F Handle the player's laser and the ECM system
N $ED3F In: ---
N $ED3F Out: ix,hl,de,bc,a - undefined
C $ED3F,3 get PlayerGameOver
C $ED45,3 get WhatOnScreen
C $ED4B,3 42 FrontLaser
C $ED5E,3 Print a line in the buffer???
C $ED68,3 Print a line in the buffer???
C $ED72,3 Print a line in the buffer???
C $ED7D,3 Print a line in the buffer???
C $ED80,3 player fires the laser
C $ED83,3 +93 extra equipment present 7,=1 - ECM Jammer 6,=1 - Cloaking device 5,=1 - cannot buy goods (refugees in the hold) 4 3 =1 mission 3 was completed 2 =1 - mission 3 completed 1 =1 - mission 2 completed 0 =1 - mission 1 completed
C $ED8A,3 get PilotMission3
C $ED90,3 7,=1 - C -- Docking Computer 6,=1 - Q -- Escape Capsule 5,=1 - W -- Energy Bomb 4,=1 - E -- ECM System 3,=1 - U -- UnTarget 2,=1 - F -- Fire Missile 1,=1 - T -- Target Missile 0,=1 - A -- Fire Laser
C $ED96,3 get PilotECMSystem
C $ED9A,3 get TimeWorkECM
C $ED9E,3 turn on the ECM system, if available
C $EDA2,3 set TimeWorkECM
C $EDA9,3 which sound to play =$00 no sound (silent) 0,=1 energy bomb exploded 1,=1 missile launched 2,=1 colliding with an object/object destroyed 3,=1 laser fired 4,=1 laser fired 5,=1 ECM working 6,=1 hit by laser on the player/docking damage 7,=1
C $EDB1,3 set PilotECMSystem
C $EDB4,3 get DamageEnergyUnit
C $EDB8,3 set DamageEnergyUnit
@ $EDBC label=TablQuadrant
b $EDBC
B $EDBC,80
N $EDBC A 4-row lookup (rows: 0,4,2,3 / 0,4,6,5 / 0,8,2,1 / 0,8,6,7) mapping a point's raw 2-bit sign-quadrant code onto a clip-region code (0 = on-screen; 1/2/4/8 and combinations = off-screen in a specific direction). A second 16-row region of this same table (following the first 4 rows) is used to combine both points' codes (as b*8+c) to decide whether an off-screen/off-screen line can possibly still cross the screen.
@ $EE0C label=VarForClipLine2
W $EE0C,2
@ $EE0E label=VarForClipLine1
W $EE0E,2
c $EE10 PrnLineInBuf_clip
N $EE10 Entry point for every line drawn in the game (ship edges, compass needle, orbit circles, etc). After two cheap trivial-reject checks (endpoints equal to $FF mean "don't print this vertex"), builds a quadrant code per point via TablQuadrant and dispatches to one of three cases: both points on-screen (draw directly), one point off-screen (PrnLine_OneCrdClip clips against a single edge), or both off-screen (the two quadrant codes are combined and looked up a second time to see if the line can possibly cross the screen at all; if not, it's discarded with no pixels drawn, otherwise PrnLine_TwoCrdClip clips against two edges).
N $EE10 0-1,c quadrant for printing the first point
N $EE10 2-3,c quadrant for printing the second point
N $EE10 hl - coordinates of the first point (x1y1)
N $EE10 de - coordinates of the second point (x2y2)
C $EE13,1 x1=y2=$FF
C $EE17,1 x2=y1=$FF
C $EE1E,1 2-3,b - signs for x2y2
C $EE24,2 0,b =1 x2>=$80
C $EE27,2 '@'
C $EE2B,2 1,b =1 y2>=$40
C $EE32,1 2-3,c - signs for x1y1
C $EE38,2 0,c =1 x1>=$80
C $EE3B,2 '@'
C $EE3F,2 1,c =1 y1>=$40
C $EE41,3 table for determining a point's quadrant from its print coordinates
C $EE47,2 x2y2 within the screen
C $EE4C,2 b - quadrant of point x2y2
C $EE4F,1 b - quadrant of point x2y2
C $EE50,3 table for determining a point's quadrant from its print coordinates
C $EE56,2 swap the coordinates of the points, x1y1 within the screen, x2y2 outside it
C $EE5B,2 c - position of point x1y1
C $EE5E,1 c - position of point x1y1
C $EE64,3 table for determining a point's quadrant from its print coordinates
C $EE70,3 both points are outside the boundaries, but the line may still cross the screen
C $EE73,1 the whole line is outside the boundaries
C $EE77,1 swap the coordinates of the points, x1y1 within the screen, x2y2 outside it
C $EE7A,1 0,c - sign of y1 1,c - sign of x1 2,c - sign of y2 3,c - sign of x2
C $EE84,1 2-3,c quadrant for printing the first point 0-1,c quadrant for printing the second point
C $EE85,2 x2y2 within the screen, x1y1 outside it
C $EE87,1 x2y2 within the screen
C $EE8A,2 x1y1 within the screen
C $EE8F,1 x2y2 within the screen, x1y1 outside it
C $EE90,3 determine the coordinate difference and print direction
C $EE93,3 compute the print address and data for setting the first point
C $EE96,3 print a line, clipped at the screen edge
C $EE9D,3 determine the coordinate difference and print direction
C $EEA0,3 compute the print address and data for setting the first point
C $EEA9,2 modify the print routine and print the line
C $EEAC,1 modify the print routine and print the line
C $EECD,3 shift the data bit
C $EED0,2 '-'
C $EEDC,2 '-'
C $EEE9,3 shift the data bit
C $EEEC,2 ',' ; 2C = inc l 2D = dec l
C $EEF7,3 hl - address in the buffer c - data byte d - height e - X increment b - height of the first character cell
C $EF04,3 print a line top-to-bottom, dY<dX
C $EF07,2 '-'
C $EF13,2 '-'
C $EF15,3 print a line bottom-to-top, dY<dX
C $EF21,3 print a line top-to-bottom, dY<dX
C $EF24,2 ','
C $EF37,2 ','
C $EF4A,2 ','
C $EF4C,3 print a line bottom-to-top, dY<dX
C $EF58,1 both points are outside the boundaries, but the line may still cross the screen
@ $EF58 label=PrnLine_TwoCrdClip
C $EF6D,3 determine the coordinate difference and print direction
C $EF77,3 determine the coordinate difference and print direction
C $EF99,3 determine the coordinate difference and print direction
C $EF9D,2 '@'
C $F008,3 determine the coordinate difference and print direction
C $F012,3 determine the coordinate difference and print direction
C $F045,2 '@'
C $F04D,3 Multiplication c=high(a*c+$80)
C $F053,3 calculate the coordinate step coefficient when printing a line
C $F06B,2 '?'
C $F074,3 compute the print address and data for setting the first point
C $F077,3 print a line, clipped at the screen edge
C $F08B,3 Multiplication c=high(a*c+$80)
C $F091,3 calculate the coordinate step coefficient when printing a line
C $F0AC,2 '@'
C $F0B0,2 '?'
C $F0B2,3 compute the print address and data for setting the first point
C $F0B5,3 print a line, clipped at the screen edge
c $F0BE Mult_C_hiAmulCadd80
N $F0BE Multiplication c=high(a*c+$80)
C $F0C1,3 computes: ((b+c)/2)^2 - ((b-c)/2)^2 should be: ((b+c)^2 - (b-c)^2)/4
c $F0CC CalcDeltaCrdLine
N $F0CC Calculate the coordinate step coefficient when printing a line
N $F0CC In: a - smaller coordinate difference
N $F0CC b - larger coordinate difference
N $F0CC Out: c - increment coefficient along the shorter axis
C $F0D1,3 calculate the coordinate step coefficient when printing a line
c $F0D6 CalcFirstAdr4Line
N $F0D6 Compute the print address and data for setting the first point
N $F0D6 In: de - coordinates of the second point (x2y2)
N $F0D6 7,b =1 line length along X > $FF
N $F0D6 =0 line length along X =< $FF
N $F0D6 6,b =1 line length along Y > $FF
N $F0D6 =0 line length along Y =< $FF
N $F0D6 4,b =1 dX >= dY
N $F0D6 4,b =0 dX < dY
N $F0D6 3,b =1 coordinate X2 is left of coordinate X1
N $F0D6 =0 coordinate X2 is right of coordinate X1
N $F0D6 2,b =1 coordinate Y2 is below coordinate Y1
N $F0D6 =0 coordinate Y2 is above coordinate Y1
N $F0D6 c - coordinate increment coefficient along the shorter axis
N $F0D6 Out: d' - byte for setting a point
N $F0D6 e' - coordinate increment coefficient along the shorter axis
N $F0D6 hl' - print address on screen/in buffer
N $F0D6 b' - number of points in the first character cell along Y
N $F0D6 a,c' - undefined
N $F0D6 other registers are unchanged
N $F0D6 The whole routine runs in the alternate register set (push, exx in, compute, exx back), so the caller's own bc/de are left completely undisturbed; the real results only become visible to the caller after it also does an exx. It recovers actual X/Y from the sign-coded deltas via X = $7F +/- dX and Y = $3F +/- dY (add if the sign bit is clear, subtract if set), i.e. reconstructing bitmap coordinates from a 127/63-centred reference point rather than from 0.
C $F0ED,2 '?'
C $F0F2,2 '?'
N $F115 Self-modified operand: patched elsewhere to $40 or $C0 depending on whether the destination address being computed is the real screen or the off-screen buffer (bit 7 of the buffer's high byte selects the buffer, matching the third/row/column layout of the real screen but relocated into high memory).
C $F119,2 '8'
c $F130 PrnLine_OneCrdClip
N $F130 Print a line, clipped at the screen edge
N $F130 In: de - coordinates of the second point (x2y2)
N $F130 the on-screen point where printing starts
N $F130 4,b =1 dX >= dY
N $F130 4,b =0 dX < dY
N $F130 3,b =1 coordinate X2 is left of coordinate X1
N $F130 =0 coordinate X2 is right of coordinate X1
N $F130 2,b =1 coordinate Y2 is below coordinate Y1
N $F130 =0 coordinate Y2 is above coordinate Y1
N $F130 1,b - sign of x2
N $F130 0,b - sign of y2
N $F130 c - coordinate increment coefficient along the shorter axis
N $F130 hl' - print address on screen/in buffer
N $F130 b' - number of points in the first character cell along Y
N $F130 c' - byte for setting a point
N $F130 e' - coordinate increment coefficient along the shorter axis
N $F130 Out: line printed
C $F143,3 determine the coordinate difference and print direction
C $F156,3 modify the print routine and print the line
C $F159,3 modify the print routine and print the line
C $F162,3 modify the print routine and print the line
C $F165,3 modify the print routine and print the line
C $F16E,3 calculate the coordinate step coefficient when printing a line
C $F172,3 modify the print routine and print the line
c $F175 CalcVars4Line
N $F175 Determine the coordinate difference and print direction
N $F175 In: hl - coordinates of the first point (x1y1)
N $F175 de - coordinates of the second point (x2y2)
N $F175 0,b - sign of y1
N $F175 1,b - sign of x1
N $F175 2,b - sign of y2
N $F175 3,b - sign of x2
N $F175 Out: 7,b =1 line length along X > $FF
N $F175 =0 line length along X =< $FF
N $F175 6,b =1 line length along Y > $FF
N $F175 =0 line length along Y =< $FF
N $F175 4,b =1 dX >= dY
N $F175 4,b =0 dX < dY
N $F175 3,b =1 coordinate X2 is left of coordinate X1
N $F175 =0 coordinate X2 is right of coordinate X1
N $F175 2,b =1 coordinate Y2 is below coordinate Y1
N $F175 =0 coordinate Y2 is above coordinate Y1
N $F175 1,b - sign of x2
N $F175 0,b - sign of y2
N $F175 c - coordinate increment coefficient along the shorter axis
N $F175 h - coordinate difference along X
N $F175 l - coordinate difference along Y
C $F185,2 ' '
C $F1FA,3 calculate the coordinate step coefficient when printing a line
c $F201
N $F211 "boundary crossing" (every 8th row): because of the third-interleaved screen layout, advancing one pixel row is not a uniform +1/-1 to a linear address. Most of the time (within a character cell) it's just L +/- $20, but every 8th row this reloads b=8 and adjusts the high byte by +/-7 and the low byte by -/+$20 instead, with a further carry-driven -b correction to the high byte if that 8-row group also crosses a third boundary.
@ $F202 label=PrnLineDown2Up_vert
C $F215,1 DownScrAdr_HL
C $F21A,2 ' '
N $F224 self-modified operand: PrnLineInBuf_clip pokes the literal byte $2C (inc l) or $2D (dec l) into this exact spot before jumping in, choosing the stepping direction once, before the loop starts, rather than branching on every pixel of the hot per-pixel loop.
c $F228
N $F228 Print a line bottom-to-top, dY<dX
N $F228 In: hl - address in buffer/on screen
N $F228 d - line length
N $F228 e - coordinate increment coefficient along the shorter axis
N $F228 b - number of points in the first character cell along Y
N $F228 c - byte for setting the first point
N $F228 Out: d =$00
N $F228 hl,e,bc,a - undefined
N $F228 self-modified operand: PrnLineInBuf_clip pokes the literal byte $2C (inc l) or $2D (dec l) into this exact spot before jumping in, choosing the stepping direction once, before the loop starts, rather than branching on every pixel of the hot per-pixel loop.
C $F22E,2 print a line bottom-to-top, dY<dX
N $F236 "boundary crossing" (every 8th row): because of the third-interleaved screen layout, advancing one pixel row is not a uniform +1/-1 to a linear address. Most of the time (within a character cell) it's just L +/- $20, but every 8th row this reloads b=8 and adjusts the high byte by +/-7 and the low byte by -/+$20 instead, with a further carry-driven -b correction to the high byte if that 8-row group also crosses a third boundary.
@ $F230 label=PrnLineDown2Up_hor
C $F244,2 ' '
c $F250
C $F251,1 hl - address in the buffer c - data byte d - height e - X increment b - height of the first character cell
@ $F251 label=PrnLineUp2Down_vert
C $F25C,2 shift the data bit
N $F260 "boundary crossing" (every 8th row): because of the third-interleaved screen layout, advancing one pixel row is not a uniform +1/-1 to a linear address. Most of the time (within a character cell) it's just L +/- $20, but every 8th row this reloads b=8 and adjusts the high byte by +/-7 and the low byte by -/+$20 instead, with a further carry-driven -b correction to the high byte if that 8-row group also crosses a third boundary.
C $F264,1 DownScrAdr_HL
C $F269,2 ' '
C $F26C,3 hl - address in the buffer c - data byte d - height e - X increment b - height of the first character cell
C $F272,3 hl - address in the buffer c - data byte d - height e - X increment b - height of the first character cell
N $F275 self-modified operand: PrnLineInBuf_clip pokes the literal byte $2C (inc l) or $2D (dec l) into this exact spot before jumping in, choosing the stepping direction once, before the loop starts, rather than branching on every pixel of the hot per-pixel loop.
c $F279
N $F279 Print a line top-to-bottom, dY<dX
N $F279 In: hl - address in buffer/on screen
N $F279 d - line length
N $F279 e - coordinate increment coefficient along the shorter axis
N $F279 b - number of points in the first character cell along Y
N $F279 c - byte for setting the first point
N $F279 Out: d =$00
N $F279 hl,e,bc,a - undefined
N $F283 "boundary crossing" (every 8th row): because of the third-interleaved screen layout, advancing one pixel row is not a uniform +1/-1 to a linear address. Most of the time (within a character cell) it's just L +/- $20, but every 8th row this reloads b=8 and adjusts the high byte by +/-7 and the low byte by -/+$20 instead, with a further carry-driven -b correction to the high byte if that 8-row group also crosses a third boundary.
@ $F27D label=PrnLineUp2Down_hor
C $F286,2 print a line top-to-bottom, dY<dX
C $F289,2 print a line top-to-bottom, dY<dX
C $F291,2 ' '
C $F294,3 print a line top-to-bottom, dY<dX
C $F29A,3 print a line top-to-bottom, dY<dX
N $F29D self-modified operand: PrnLineInBuf_clip pokes the literal byte $2C (inc l) or $2D (dec l) into this exact spot before jumping in, choosing the stepping direction once, before the loop starts, rather than branching on every pixel of the hot per-pixel loop.
@ $F2A1 label=PatternObject
b $F2A1
B $F2A1,31 +0 template of an object's slot in space
@ $F2C0 label=SKO4Intro
B $F2C0,9
B $F2C9,1 alternation
c $F2CA CallFunctionObj
N $F2CA In: A - bits 3-0 handler function number?
N $F2CA =0 SetRndShip
N $F2CA =1 Set3_4Thargons
N $F2CA =2 SetObjMissile
N $F2CA =3 *not used
N $F2CA =4 ShipSetShip
N $F2CA =5 Set2Alloys
N $F2CA =6 SetCargo
N $F2CA =7 SetShipEscapePod
N $F2CA =8 Set2Minerals
N $F2CA =9 SetShip4Intro
N $F2CA bits 7-4 number =0 - slave
N $F2CA =1 - alloys
N $F2CA =2 - canister
N $F2CA =3 - alien items
N $F2CA =4 - asteroid
N $F2CA =5 - asteroid
N $F2CA =6 - policeman
N $F2CA =7 - cobra
N $F2CA =8 - python
N $F2CA =9 - python
N $F2CA =A - cobra
N $F2CA =B - asp
N $F2CA =C - fer-de-lance
N $F2CA =D - thargon
N $F2CA =E - sidewinder
N $F2CA =F - krait
C $F2D5,3 a = $x0
C $F2D9,3 3-0 =1
C $F2DD,3 launch a missile a = $x2 x =0 launched by an enemy <>0 by the player
C $F2E1,1 3-0 =3
C $F2E3,3 a = $x4 x - ship number
C $F2E7,3 3-0 =5
C $F2EB,3 3-0 =6
C $F2EF,3 3-0 =7
C $F2F3,3 3-0 =8
C $F2F7,3 3-0 =9
C $F2FA,1 3-0 =A..F
c $F2FB SetObjInSlot
N $F2FB Place an object into a slot
N $F2FB In: a - object number
N $F2FB ix address of the object slot
N $F2FB Out: a=$00
C $F2FF,2 '?'
C $F30D,2 iy address of the object data
C $F31B,3 +0 template of an object's slot in space
C $F32A,2 'o'
C $F343,2 '~'
C $F356,3 Random number
C $F35E,3 Random number
C $F366,3 Random number
C $F36C,3 Random number
C $F372,3 Random number
c $F381 ShipSetObject
N $F381 Place an object into a slot at another object's coordinates (a ship
N $F381 launching an enemy object, which inherits coordinates, OCS and speed from the parent)
N $F381 In: a - object number
N $F381 ix address of the object slot
N $F381 Out: Z=1 success, -> ix - slot address of the placed object
N $F381 bc =$0000
C $F384,3 find a free slot to place an object
C $F38B,3 place an object into a slot
c $F399 FindSlot4Obj
N $F399 Find a free slot to place an object
N $F399 In: ---
N $F399 Out: z=1 free slot found -> ix - its address
N $F399 de =LenSlotObj
N $F399 b,a - undefined
C $F399,4 length 27h
C $F39D,3 '''
c $F3AD SetPlayerObj
N $F3AD Place an object in space at the player's coordinates, into a free slot
N $F3AD In: a - object number
N $F3AD Out: z=1 free slot found -> ix - address
C $F3AE,3 find a free slot to place an object
c $F3B3 SetPlayerObjSlot
N $F3B3 Place an object into a slot at the player's coordinates
N $F3B3 In: a - object number
N $F3B3 ix address of the object slot
N $F3B3 Out: a=$00
C $F3B3,3 place an object into a slot
c $F3CE Set3_4Thargons
N $F3CE Place 3-4 Thargons
N $F3CE In: ---
N $F3CE Out: z=1 success
N $F3CE hl,de,bc,a - undefined
C $F3CE,3 Random number
C $F3D3,2 3/4 thargon
C $F3D6,3 find a free slot to place an object
C $F3DA,2 thargon
C $F3DD,3 place an object into a slot
C $F3E4,3 Random number
C $F3FA,3 generate a random movement direction for the object
c $F402 SetObjMissile
N $F402 Launch a missile
N $F402 In: c - missile target
N $F402 =0 player (launched by an enemy)
N $F402 <>0 number of the object the player fired the missile at
N $F402 Out: Z=1 success
C $F404,2 =1 missile
C $F406,4 length 27h
C $F40A,3 =$27*7
C $F40D,2 ix=#R$6159
C $F413,2 =1 - missile
C $F415,3 find a free slot to place an object
C $F419,2 =1 - missile
C $F41C,3 place an object into a slot at the player's coordinates
C $F420,2 'j'
C $F425,2 ')'
C $F432,2 =1 missile
C $F434,3 place an object into a slot at another object's coordinates (a ship launching an enemy object, which inherits coordinates, OCS and speed from the parent)
C $F438,3 get HighDeltaSpeed
c $F44A ShipSetShip
N $F44A Launch a ship from an object
N $F44A In: c - number of the ship being placed
N $F44A =1 Viper
N $F44A =2 Cobra/Python
N $F44A =3 Tharglet
N $F44A =4 Thargon
N $F44A =5 Sidewinder/Krait
N $F44A >5 place nothing
N $F44A ix - slot address of the parent object
N $F44A Out: z=1 success
N $F44A ix - slot address of the placed ship
N $F44A iy - address of the parent slot
N $F44A hl,de,bc,a - undefined
C $F44C,1 A=8, viper
C $F44D,2 Set Viper
C $F44F,3 Random number
C $F454,2 a=9/10, cobra/python
C $F457,2 Set Cobra/Python
C $F459,2 a=18, tharglet
C $F45C,2 Set Tharglet
C $F45E,2 a=15, thargon
C $F461,2 Set Thargon
C $F464,1 >5, ships
C $F465,3 Random number
C $F46A,2 a=16, sidewinder
C $F46C,2 a - object number
C $F46E,2 a=17, krait
C $F470,2 a - object number
C $F472,3 place an object into a slot at another object's coordinates (a ship launching an enemy object, which inherits coordinates, OCS and speed from the parent)
C $F47C,3 rotate the object's OCS
C $F47F,4 inherit aggression
c $F48A RotateSKOobj
N $F48A Rotate the object's OCS
N $F48A In: ix - address of the object slot
N $F48A Out: b=$00
N $F48A c,a - undefined
C $F48A,3 alternation
C $F48F,3 alternation
c $F4E6 RndDirectionObj
N $F4E6 Generate a random movement direction for the object
N $F4E6 In: ix - address of the object slot
N $F4E6 Out: a - undefined
C $F4E6,3 Random number
C $F4EE,3 Random number
c $F4F7 Set2Alloys
N $F4F7 Place two Alloys objects
N $F4F7 In: c =$01 at the player's coordinates
N $F4F7 $00 at the object's coordinates
N $F4F7 Out: ix,hl,de,bc,a - undefined
C $F4F9,2 place an Alloys object in space at the object's coordinates
C $F4FB,3 place an Alloys object in space at the player's coordinates into a free slot; place a Cargo object in space at the player's coordinates into a free slot
c $F4FF SetPlayerAlloys
N $F4FF Place an Alloys object in space at the player's coordinates into a free slot
N $F4FF place a Cargo object in space at the player's coordinates into a free slot
N $F4FF In: ---
N $F4FF Out: ix,hl,de,bc,a - undefined
C $F501,3 place a Cargo object in space at the player's coordinates into a free slot
C $F505,3 generate a random movement direction for the object
C $F50C,3 Random number
C $F50F,2 '?'
C $F520,3 Random number
C $F523,2 '?'
C $F539,3 Random number
C $F53F,3 Random number
c $F54B ShipSet2Alloys
N $F54B Place an Alloys object in space at the object's coordinates
N $F54B In: ---
N $F54B Out: ix,hl,de,bc,a - undefined
C $F54D,3 place Minerals/Alloys into a slot at another object's coordinates (debris of an asteroid/ship inherits coordinates, OCS and speed from the parent)
C $F553,2 place Minerals/Alloys into a slot at another object's coordinates (debris
c $F555 SetCargo
N $F555 Place Cargo
N $F555 In: c =$01 place cargo at the player's coordinates
N $F555 $00 place cargo at the object's coordinates
N $F555 Out: ix,hl,de,bc,a - undefined
C $F557,2 =4, cargo
C $F559,2 place EscapePod/Cargo into a slot at another object's coordinates (an enemy ship launching EscapePod/Cargo, which inherits coordinates, OCS and speed from the parent)
C $F55B,2 place a Cargo object in space at the player's coordinates into a free slot
c $F55D SetCobra_EscPod
N $F55D Launch the escape capsule
N $F55D In: c =$01 place a Cobra at the player's coordinates
N $F55D $00 place an escape capsule at the object's coordinates
N $F55D Out: ix,hl,de,bc,a - undefined
C $F561,2 place EscapePod/Cargo into a slot at another object's coordinates (an enemy ship launching EscapePod/Cargo, which inherits coordinates, OCS and speed from the parent)
C $F569,3 place an object into a slot at the player's coordinates
C $F56C,3 generate a random movement direction for the object
C $F57D,2 'L'
C $F587,3 get HighDeltaSpeed
c $F592 SetShipEPodCargo
N $F592 Place EscapePod/Cargo into a slot at another object's coordinates (an enemy
N $F592 ship launching EscapePod/Cargo, which inherits coordinates, OCS and speed from
N $F592 the parent)
N $F592 In: a - object number
N $F592 ix address of the object slot
N $F592 Out: z=1 success
N $F592 hl,de,bc,a - undefined
C $F592,2 place an EscapePod at the enemy's coordinates
C $F594,3 place an object into a slot at another object's coordinates (a ship launching an enemy object, which inherits coordinates, OCS and speed from the parent)
c $F5B0 Set2Minerals
N $F5B0 Place two Minerals objects into a slot at another object's coordinates
N $F5B0 In: ---
N $F5B0 ix address of the parent object's slot
N $F5B0 Out: z=1 success
N $F5B0 hl,de,bc,a - undefined
C $F5B2,3 place Minerals/Alloys into a slot at another object's coordinates (debris of an asteroid/ship inherits coordinates, OCS and speed from the parent)
c $F5B8 SetShipMinAlloys
N $F5B8 Place Minerals/Alloys into a slot at another object's coordinates (debris
N $F5B8 of an asteroid/ship inherits coordinates, OCS and speed from the parent)
N $F5B8 In: a - number of the object being placed
N $F5B8 ix address of the parent object's slot
N $F5B8 Out: z=1 success
N $F5B8 hl,de,bc,a - undefined
C $F5BA,3 place an object into a slot at another object's coordinates (a ship launching an enemy object, which inherits coordinates, OCS and speed from the parent)
C $F5C4,3 rotate the object's OCS
c $F5D8 SetShip4Intro
N $F5D8 Place an object into the missile slot for the intro screen
N $F5D8 In: c - object number
N $F5D8 Out: ix,hl,de,bc,a - undefined
C $F5D8,4 slot for the missile +00
C $F5DF,3 place an object into a slot
C $F5EE,3 crd X =0
C $F5F4,3 crd y =0
C $F5FA,3 crd z = 003200
C $F606,3 crd z = 000200
C $F613,3 object's OCS for the intro
c $F61D SetRndShip
N $F61D Place a random ship/group of ships
N $F61D In: ---
N $F61D Out: hl,de,bc,a - undefined
C $F61D,3 get cargoSlaves
C $F620,1 number of slaves
C $F621,3 get cargoNarc
C $F626,1 c = (number of slaves + amount of narcotics) * 2
C $F627,3 +0A Firearms
C $F62B,1 c = (number of slaves + amount of narcotics) * 2 + amount of weapons
C $F62C,3 get PilotMission2
C $F630,2 c = (number of slaves + amount of narcotics) * 2 + amount of weapons
C $F632,3 Random number
C $F637,2 c = (number of slaves + amount of narcotics) * 2 + amount of weapons
C $F639,3 +93 extra equipment present 7,=1 - ECM Jammer 6,=1 - Cloaking device 5,=1 - cannot buy goods (refugees in the hold) 4 3 =1 mission 3 was completed 2 =1 - mission 3 completed 1 =1 - mission 2 completed 0 =1 - mission 1 completed
C $F640,2 c = (number of slaves + amount of narcotics) * 2 + amount of weapons
C $F643,3 set PilotMission2
C $F64D,3 find a free slot to place an object
C $F651,2 asp
C $F653,2 set asp
C $F65D,3 place 2-4 Sidewinder/Krait
C $F660,3 c = (number of slaves + amount of narcotics) * 2 + amount of weapons
C $F664,2 rnd < banned cargo
C $F666,2 'Z'
C $F668,1 rnd >= banned cargo rnd >=$5A
C $F669,2 'P'
C $F66B,2 rnd >= banned cargo rnd < $50
C $F66D,3 rnd >= banned cargo rnd >= $50 rnd < $5A rnd=$50..$59
C $F671,2 set asteroid
C $F673,3 place an object into a slot
C $F688,3 get PilotMission3
C $F690,2 set thargon, if the ship is captured by pirates
C $F697,2 set python, if it's time to give mission 3
C $F699,3 74 ???
C $F69E,2 if anarchy
C $F6A2,1 exit if rnd >= the planet's government
C $F6A9,3 place a random ship
C $F6AD,3 Random number
C $F6B0,2 '?'
C $F6B2,2 thargon
C $F6B6,1 fer-de-lance
C $F6BB,1 asp
C $F6C0,1 cobra
C $F6C5,1 python
C $F6C8,3 place an object into a slot
C $F6D0,3 probability of aggression?
C $F6D3,2 '3'
C $F6DB,3 find a free slot to place an object
C $F6E2,3 Random number
C $F6E9,2 place 2-4 Sidewinder/Krait
C $F6F2,3 find a free slot to place an object
C $F702,2 cobra/python
C $F70A,2 asteroid/viper
C $F70E,3 place 2-4 Sidewinder/Krait
C $F717,3 find a free slot to place an object
C $F71C,3 Random number
C $F721,2 Sidewinder/Krait
C $F723,3 place an object into a slot
@ $F72B label=deltaCrdX
b $F72B
W $F72B,2 distance along X / 4 7,=x sign
@ $F72D label=deltaCrdY
W $F72D,2 distance along Y / 4 7,=x sign
@ $F72F label=deltaCrdZ
W $F72F,2 distance along Z / 4 7,=z sign
@ $F731 label=LenVector
W $F731,2 vector length
c $F733 ReactionObject
N $F733 Object's reaction to the player. Launching missiles, ships, escape capsule, etc.
N $F733 In: ix - address of the object slot
N $F733 iy - address of the object data
N $F733 Out: hl,de,bc,a - undefined
C $F733,3 max energy of the object
C $F736,3 current energy
C $F73C,2 max energy >=$F0 current energy +4 max energy <$F0 current energy +1
C $F742,2 current energy > max energy
C $F744,1 a=c(current energy) if current <= max energy
C $F745,1 b - the object's changed energy
C $F746,3 get CloakingDeviceOn
C $F74B,3 =3 the Asp from mission 2 is destroyed / there is a canister with the cloak in space =2 the Asp's invisibility is off =1 mission 2 given =0 while moving on the J-drive
C $F74F,2 'P'
C $F752,2 energy <$50
C $F75E,2 '4'
C $F760,2 energy >=$34
C $F76B,3 new energy
C $F772,2 energy is high
C $F775,2 energy is more than half
C $F77E,2 critically low energy
C $F785,2 no missiles and no ships
C $F787,3 determine the launch probability
C $F78E,3 get TimeWorkECM
C $F792,2 while ECM is running, the enemy cannot launch anything
C $F7A1,3 the enemy launches a missile or a ship
C $F7AB,2 =2 launched a missile
C $F7AF,3 7,=1 the enemy fired a missile
C $F7B6,3 critically low energy
C $F7B9,3 probability of dropping cargo/pod
C $F7BC,2 not aggressive by default???
C $F7C2,2 drop the cargo hold
C $F7C4,2 set the object's escape capsule
C $F7C6,3 Call a function
C $F7C9,2 if the escape capsule isn't set
C $F7D4,3 drop the cargo hold
C $F7DA,2 set cargo
C $F7DC,3 Call a function
C $F7E4,2 not aggressive by default???
C $F7E6,2 (iy+$12)=4
C $F7E8,4 length 27h
C $F7EC,3 '''
C $F805,3 ????
C $F810,4 decrease speed
C $F815,4 not aggressive by default???
C $F81B,3 get PilotMission3
C $F822,3 +93 extra equipment present 7,=1 - ECM Jammer 6,=1 - Cloaking device 5,=1 - cannot buy goods (refugees in the hold) 4 3 =1 mission 3 was completed 2 =1 - mission 3 completed 1 =1 - mission 2 completed 0 =1 - mission 1 completed
C $F829,3 get TimeWorkECM
C $F82F,3 missile descriptor +$22
C $F83C,3 Random number
C $F843,3 set TimeWorkECM
C $F84A,2 set the object's flight direction away from/toward the player ix - address of the object slot
C $F84C,3 get nMissileObj
C $F852,3 Random number
C $F859,2 object is not aggressive
C $F85B,2 '$'
C $F85E,3 get PilotMission3
C $F863,2 set ship viper
C $F865,2 call a function a - function number
C $F867,3 Random number
C $F86D,2 'D' ; set ship thargon
C $F86F,2 call a function a - function number
C $F874,2 '$' ; set ship cobra/python
c $F876 CallFunction_Obj
N $F876 Call a function
N $F876 a - function number
c $F882 TestObjInRadius
N $F882 Check whether the object is within a given radius of the player
N $F882 In: de - radius
N $F882 Out: cy =1 within radius
N $F882 =0 outside
c $F8A2 DirectObject
N $F8A2 Set the object's flight direction away from/toward the player
N $F8A2 ix - address of the object slot
C $F8A2,4 aggression from legal status
C $F8A8,3 pilot's legal status 0 - clean 1..31h offender 32h..FFh fugitive
C $F8AB,2 '('
C $F8B6,3 check whether the object is within a given radius of the player
C $F8B9,2 within the reaction radius
C $F8C3,3 check whether the object is within a given radius of the player
C $F8C6,2 within the reaction radius
C $F8CC,1 far from the player and not aggressive
C $F8CD,3 get PilotMission3
C $F8DE,2 handle the missile hitting the player
C $F8E0,2 within the reaction radius
C $F8E9,2 handle the missile hitting the player
C $F8EF,2 within the reaction radius
C $F8F1,3 convert a coordinate without changing its sign
C $F8F4,3 set deltaCrdX
C $F8F7,3 convert a coordinate without changing its sign
C $F8FA,3 set deltaCrdY
C $F8FD,3 convert a coordinate without changing its sign
C $F900,3 set deltaCrdZ
C $F90B,2 handle the missile hitting the player
C $F90D,3 convert a coordinate, flipping its sign
C $F910,3 set deltaCrdX
C $F913,3 convert a coordinate, flipping its sign
C $F916,3 set deltaCrdY
C $F919,3 convert a coordinate, flipping its sign
C $F91C,3 set deltaCrdZ
C $F925,3 object movement. Set rotation angles, acceleration, speed, and fire the
c $F928 MoveMissile
N $F928 Process a missile: movement, hit detection
N $F928 In: ix - address of the missile slot
N $F928 In: ix - address of the object slot
N $F928 iy - address of the object data
N $F928 Out: hl,de,bc,a - undefined
C $F928,3 get TimeWorkECM
C $F92C,2 destroy the target with the missile
C $F92E,4 if ECM is running, destroy the missile
C $F937,3 destroy the target with the missile
C $F93B,2 handle the missile hitting the player
C $F93F,4 length 27h
C $F943,3 '''
C $F949,1 convert the reverse index
C $F950,2 ix address of the missile slot iy address of the missile's target slot
C $F952,3 distance along X
C $F955,3 set deltaCrdX
C $F958,3 distance along Y
C $F95B,3 set deltaCrdY
C $F95E,3 distance along Z
C $F961,3 set deltaCrdZ
C $F968,3 check distance hl < 003F
C $F96B,2 far
C $F96D,3 get deltaCrdY
C $F970,3 check distance hl < 003F
C $F973,2 far
C $F975,3 get deltaCrdX
C $F978,3 check distance hl < 003F
C $F97B,2 far
C $F981,2 is destroyed by the missile
C $F983,3 +92 >0 - mission 3 given =1 mission 3 will be given on docking ( =1 time to give the mission, will become =2 after the jump) =2 mission 3 will be given on docking =3 mission 3 given (the station can be destroyed with a missile) (Thargons launch from the station) =4 mission 3 given, the ship is in the target system (the station can be destroyed with a missile) (Thargons launch from the station) =5 mission 3 completed, there will be congratulations on docking
C $F989,2 destroy the missile
C $F993,3 increase combat rating
C $F99A,4 destroy the missile's target
C $F99E,2 destroy the missile
C $F9AA,1 check distance hl < 003F
C $F9D0,3 compute the distance along one axis
c $F9DB HL_CrdNdiv4_InvSign
N $F9DB Convert a coordinate, flipping its sign
N $F9DB In: ix - address of the coordinate
N $F9DB Out: hl = -1 * CrdN / 4
N $F9DB ix=ix+3
c $F9E2 HL_CrdNdiv4
N $F9E2 Convert a coordinate without changing its sign
N $F9E2 In: ix - address of the coordinate
N $F9E2 Out: hl = CrdN / 4
N $F9E2 ix=ix+3
c $F9FA MoveObject
N $F9FA Object movement. Set rotation angles, acceleration, speed, and fire the
N $F9FA laser
N $F9FA In: ix - address of the object slot
N $F9FA iy - address of the object data
N $F9FA (deltaCrdX) - the vector relative to which we compute
N $F9FA Out: hl,de,bc,a - undefined
C $F9FC,4 distance along X / 4 7,=x sign
C $FA02,4 distance along X / 4 7,=x sign
C $FA06,3 compute vector length and normalize the vector
C $FA0B,4 set LenVector
C $FA14,2 ix+$09
C $FA16,3 dot product of two vectors with one vector's direction flipped
C $FA1C,2 ix+$0F
C $FA20,3 dot product of two vectors with one vector's direction flipped
C $FA29,2 ix+$15
C $FA2B,3 dot product of two vectors with one vector's direction flipped
C $FA54,2 '?'
C $FA61,2 'P'
C $FA66,2 'h'
C $FA6A,2 '@'
C $FA6E,2 '?'
C $FA85,4 get LenVector
C $FAB6,3 if there has not been a single RoC yet, halve the chance
C $FABE,3 Random number
C $FADC,3 which sound to play =$00 no sound (silent) 0,=1 energy bomb exploded 1,=1 missile launched 2,=1 colliding with an object/object destroyed 3,=1 laser fired 4,=1 laser fired 5,=1 ECM working 6,=1 hit by laser on the player/docking damage 7,=1
C $FAE7,3 get DamageRearShield
C $FAEC,3 set DamageRearShield
C $FAF0,3 get DamageFrontShield
C $FAF5,3 set DamageFrontShield
c $FB10 Mult_HL_A2_B2
N $FB10 Multiplication hl = -1 * high((a*2) * (b*2))
N $FB10 In: b - first factor, 7,b - sign
N $FB10 a - second factor, 7,a - sign
N $FB10 Out: l,a = high((a*2) * (b*2))
N $FB10 l,a = high((a*2) * (b*2))
N $FB10 7,h - sign
C $FB19,3 A=((b+c)/2)^2-((b-c)/2)^2
c $FB1F ScalarMultVectors
N $FB1F Dot product of two vectors with one vector's direction flipped
N $FB1F In: ix - start address of the OCS axis vector
N $FB1F iy - start address of the second vector's coordinates (normalized vector)
N $FB1F Out: a - result
N $FB1F 7,a - new sign
C $FB25,3 (crdXv/2) * (cos(a)/2)
C $FB2F,3 multiplication hl = -1 * high((a*2) * (b*2))
C $FB39,3 multiplication hl = -1 * high((a*2) * (b*2))
C $FB3D,3 signed addition
C $FB46,3 signed addition
@ $FB51 label=ScanKeysSymbols
b $FB51
B $FB51,40
c $FB79 ScanKeys
N $FB79 Poll the keyboard
C $FB7A,3 something related to cursor and Sinclair joystick, unused in this version
C $FB7E,3 set PressKeyPrnSymbol
C $FB91,3 set the pressed key from the table
C $FB97,3 update the pressed-keys table
b $FB9A
B $FB9A,4
@ $FB9E label=data_FB9E
B $FB9E,11
B $FBA9,2
@ $FBAB label=TxtChr4Descr
B $FBAB,24
@ $FBC3 label=TxtPairOfChr
B $FBC3,64
B $FC03,8 attribute +2 line feeds
B $FC0B,3 attribute +2 line feeds
@ $FC0E label=ControlKey1
B $FC0E,1 7,=1 - Y -- Cloaking Device 6,=1 - 0 -- ??? 5,=1 - I -- Global Map 4,=1 - O -- Local Map 3,=1 - P -- Planet Info 2,=1 - K -- Planet Price 1,=1 - L -- Commander Info 0,=1 - Enter -- Inventory
@ $FC0F label=ControlKeyMove
B $FC0F,1 7,=1 - -- unused 6,=1 - -- unused 5,=1 - SymbolS -- Decrease Speed 4,=1 - Space -- Increase Speed 3,=1 - S -- Up 2,=1 - X -- Down 1,=1 - M -- Right 0,=1 - N -- Left
@ $FC10 label=ControlKey2
B $FC10,1 7,=1 - CapsS -- Pause 6,=1 - J -- Jump Drive 5,=1 - G -- Galactic Hyper Drive 4,=1 - H -- Hyper Drive 3,=1 - 4 -- Right View/Equip Ship 2,=1 - 3 -- Left View/Sell Cargo 1,=1 - 2 -- Rear View/Buy Cargo 0,=1 - 1 -- Front View/Launch
@ $FC11 label=ControlKey3
B $FC11,1 7,=1 - C -- Docking Computer 6,=1 - Q -- Escape Capsule 5,=1 - W -- Energy Bomb 4,=1 - E -- ECM System 3,=1 - U -- UnTarget 2,=1 - F -- Fire Missile 1,=1 - T -- Target Missile 0,=1 - A -- Fire Laser
@ $FC12 label=ControlKeyInMap
B $FC12,1 7, -- unused 6,=1 - R -- Find Planet 5,=1 - D -- Cursor to Near Planet 4,=1 - B -- Cursor to Present System 3-0, -- unused
@ $FC13 label=PressKeyPrnSymbol
B $FC13,1 printable character of the pressed key =$FE - BackSpace =$FF - nothing pressed
@ $FC14 label=FlagsSetUp
B $FC14,1 0-1,=00 SXNMA controls (LLFC0F)<>0 reset CS,F,c =01 Kempston controls =10 cursor controls 76850 =11 Sinclair right controls 2,=1 realistic control approximation (reaction) 3,=1 turn inertia on 4,=1 controls inverted 5,=1 up/down inverted 6,=1 Thargon interception on 7,=1 sound on
B $FC15,1 something related to cursor and Sinclair joystick, unused in this version
c $FC16 ScanKeysContinue
N $FC16 Update the pressed-keys table
N $FC16 In: ----
N $FC16 Out: (LLFC0E...) - pressed keys
N $FC16 (LLFC13) - code of the pressed key
C $FC1A,3 get ControlKeyMove
C $FC20,3 get FlagsSetUp
C $FC34,3 7,=1 - C -- Docking Computer 6,=1 - Q -- Escape Capsule 5,=1 - W -- Energy Bomb 4,=1 - E -- ECM System 3,=1 - U -- UnTarget 2,=1 - F -- Fire Missile 1,=1 - T -- Target Missile 0,=1 - A -- Fire Laser
C $FC3D,2 '0'
C $FC44,3 something related to cursor and Sinclair joystick, unused in this version
C $FC5D,3 7,=1 - Y -- Cloaking Device 6,=1 - 0 -- ??? 5,=1 - I -- Global Map 4,=1 - O -- Local Map 3,=1 - P -- Planet Info 2,=1 - K -- Planet Price 1,=1 - L -- Commander Info 0,=1 - Enter -- Inventory
C $FC64,3 7,=1 - C -- Docking Computer 6,=1 - Q -- Escape Capsule 5,=1 - W -- Energy Bomb 4,=1 - E -- ECM System 3,=1 - U -- UnTarget 2,=1 - F -- Fire Missile 1,=1 - T -- Target Missile 0,=1 - A -- Fire Laser
C $FC8F,3 7,=1 - -- unused 6,=1 - -- unused 5,=1 - SymbolS -- Decrease Speed 4,=1 - Space -- Increase Speed 3,=1 - S -- Up 2,=1 - X -- Down 1,=1 - M -- Right 0,=1 - N -- Left
C $FC92,3 get FlagsSetUp
C $FCAC,3 7,=1 - Y -- Cloaking Device 6,=1 - 0 -- ??? 5,=1 - I -- Global Map 4,=1 - O -- Local Map 3,=1 - P -- Planet Info 2,=1 - K -- Planet Price 1,=1 - L -- Commander Info 0,=1 - Enter -- Inventory
C $FCB4,3 get ControlKey2
C $FCBC,3 set PressKeyPrnSymbol
c $FCC0 SetBitControlKey
N $FCC0 Set the pressed key from the table
N $FCC0 In: d - half-row number
N $FCC0 e - reverse key index within the half-row
N $FCC0 Out: (PressKeyPrnSymbol) - character of the pressed key
N $FCC0 (ControlKeys) - the corresponding bit is set
C $FCCD,3 key character table
C $FCD6,3 set PressKeyPrnSymbol
C $FCD9,3 table mapping key codes to bits +0 byte number in the control-key list +1 bit of the pressed key
C $FCE2,3 7,=1 - Y -- Cloaking Device 6,=1 - 0 -- ??? 5,=1 - I -- Global Map 4,=1 - O -- Local Map 3,=1 - P -- Planet Info 2,=1 - K -- Planet Price 1,=1 - L -- Commander Info 0,=1 - Enter -- Inventory
b $FCED
B $FCED,276
c $FE01 KeyCtrl_Move
N $FE01 Handle control key presses: turning and speed
N $FE01 In: ----
N $FE01 Out: (AngleLeftRight), (AngleUpDown) new rotation angles
N $FE01 (DeltaSpeed) new speed
C $FE01,3 get WhatOnScreen
C $FE07,3 get ControlKeyMove
C $FE0B,3 get FlagsSetUp
C $FE0F,3 rotation angle 7,n sign (left/right) $0000..$0FFF
C $FE1E,3 '<'
C $FE7A,3 rotation angle 7,n sign (left/right) $0000..$0FFF
C $FE7D,3 up/down rotation angle
C $FE8C,3 '$'
C $FEA2,3 'f'
C $FEC3,3 'f'
C $FEDB,3 'f'
C $FEE8,3 rotation angle 7,n sign (left/right) $0000..$0FFF
C $FEEB,3 speed change
C $FEFE,2 interrupt handling
@ $FF08 label=AngleLeftRight
s $FF08
S $FF08,2
@ $FF0A label=AngleUpDown
S $FF0A,2
@ $FF0C label=DeltaSpeed
S $FF0C,2
c $FF0E KeyCtrl_Move_2
C $FF1D,3 speed $0000..$1FFF
C $FF21,3 set ControlKeyMove
c $FF25 Interrupts
C $FF35,3 Poll the keyboard
C $FF38,3 handle control key presses: turning and speed
C $FF3B,3 sound output
c $FF4C Interrupts_ON
c $FF53 IM1_ON
@ $FF56 label=SaveSP1
b $FF56
W $FF56,2
@ $FF58 label=TablBitPressKey
B $FF58,81
