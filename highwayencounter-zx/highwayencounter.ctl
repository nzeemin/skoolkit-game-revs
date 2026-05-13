
s $4000 Screen
S $4000,6144 Screen pixel data
S $5800,768 Screen attributes
b $5B00 Font
i $5BD7
b $7100 Sprites
  $7100,2048,8
b $7900 Data block
w $7A00 Table with sprite addresses
W $7A00,,16
b $7B00 Global objects table, 16 bytes per record, max 240 records
B $7B00,,16
B $7B10,16,16 Fire?  Zone 28
B $7B20,16,16 Block? Zone 28
B $7B30,16,16 Block? Zone 28
B $7B40,16,16 Fire   Zone 28
B $7B50,16,16 Barrel Zone 29
B $7B60,16,16 Barrel Zone 29
B $7B70,16,16 Barrel Zone 29
B $7B80,16,16 Barrel Zone 29
B $7B90,16,16 Barrel Zone 29
B $7BA0,16,16 Barrel Zone 29
B $7BB0,16,16 BlockB Zone 26
B $7BC0,16,16 BlockB Zone 26
B $7BD0,16,16 Barrel Zone 26
B $7BE0,16,16 Glass? Zone 27
B $7BF0,16,16 Glass? Zone 27
B $7C00,16,16 Star
B $7C10,16,16 Star
B $7C20,16,16 Glass?
B $7C30,16,16 Fire?
B $7C40,16,16 Fire?
B $7C50,16,16 Glass?
B $7C60,16,16 Pawn?
B $7C70,16,16 Pawn?
B $7C80,16,16 Pawn?
B $7C90,16,16 Pawn?
B $7CA0,16,16 Grammy? Zone 25
B $7CB0,16,16 Grammy? Zone 25
B $7CC0,16,16 Barrel  Zone 25
B $7CD0,16,16 Block?  Zone 25
B $7CE0,16,16 Block?  Zone 25
B $7CF0,16,16 Block?  Zone 25
B $7D00,16,16 Block?  Zone 25
B $7D10,16,16 Flat blocker
B $7D20,16,16 Flat blocker
B $7D30,16,16 Flat blocker
B $7D40,16,16 Flat blocker
B $7D50,16,16 Flat blocker
B $7D60,16,16 Flat blocker
B $7D70,16,16 Flat blocker
B $7D80,16,16 Flat blocker
B $7D90,16,16 Flat blocker
B $7DA0,16,16 Flat blocker
B $7DB0,16,16 Fire?
B $7DC0,16,16 Fire?
B $7DD0,16,16 Fire?
B $7DE0,16,16 Fire?
B $7DF0,16,16 Fire?
B $7E00,16,16 Frog?
B $7E10,16,16 Frog?
B $7E20,16,16 Frog?
B $7E30,16,16 Frog?
B $7E40,16,16 Star?
B $7E50,16,16 Flat blocker
B $7E60,16,16 Flat blocker
B $7E70,16,16 Pawn?
B $7E80,16,16 Pawn?
B $7E90,16,16 Block?
B $7EA0,16,16 Block?
B $7EB0,16,16 Barrel
B $7EC0,16,16 Star?
B $7ED0,16,16 Frog?
B $7EE0,16,16 Frog?
B $7EF0,16,16
B $7F00,16,16 Fire?
B $7F10,16,16 Flat blocker
B $7F20,16,16 Flat blocker
B $7F30,16,16 Flat blocker
B $7F40,16,16 Flat blocker
B $7F50,16,16 Flat blocker
B $7F60,16,16 Flat blocker
B $7F70,16,16 Flat blocker
B $7F80,16,16 Flat blocker
B $7F90,16,16 Barrel
B $7FA0,16,16 Barrel
B $7FB0,16,16 Barrel
B $7FC0,16,16 Barrel
B $7FD0,16,16 Frog?
B $7FE0,16,16 Frog?
B $7FF0,16,16 Frog?
B $8000,16,16 BlockB
B $8010,16,16 BlockB
B $8020,16,16 BlockB
B $8030,16,16 Barrel Zone 18
B $8040,16,16 Barrel Zone 18
B $8050,16,16 Star?  Zone 18
B $8060,16,16 Star?  Zone 18
B $8070,16,16 Block?
B $8080,16,16 Block?
B $8090,16,16 Block?
B $80A0,16,16 Star?  Zone 17
B $80B0,16,16 Star?  Zone 17
B $80C0,16,16 Star?  Zone 17
B $80D0,16,16 Block? Zone 16
B $80E0,16,16 Block? Zone 16
B $80F0,16,16 Block? Zone 16
B $8100,16,16 Block? Zone 16
B $8110,16,16 Ufo?
B $8120,16,16 Pawn?
B $8130,16,16
B $8140,16,16 Flat blocker Zone 15
B $8150,16,16 Flat blocker Zone 15
B $8160,16,16 Flat blocker Zone 15
B $8170,16,16 Flat blocker Zone 15
B $8180,16,16 Ufo?   Zone 14
B $8190,16,16 Ufo?   Zone 14
B $81A0,16,16 Ufo?   Zone 14
B $81B0,16,16 Ufo?   Zone 14
B $81C0,16,16 Ufo?   Zone 14
B $81D0,16,16 Ufo?   Zone 14
B $81E0,16,16 Glass?
B $81F0,16,16 Glass?
B $8200,16,16 Glass?
B $8210,16,16 Glass?
B $8220,16,16 BlockB
B $8230,16,16 BlockB
B $8240,16,16 Block?
B $8250,16,16 Block?
B $8260,16,16 Block?
B $8270,16,16 Block?
B $8280,16,16 Block?
B $8290,16,16 Block?
B $82A0,16,16 Barrel
B $82B0,16,16 Barrel
B $82C0,16,16 Barrel
B $82D0,16,16 Barrel
B $82E0,16,16 Star?
B $82F0,16,16 Star?
B $8300,16,16 Star?
B $8310,16,16 Star?
B $8320,16,16 Barrel Zone 9?
B $8330,16,16 Barrel Zone 9?
B $8340,16,16 Barrel Zone 9?
B $8350,16,16 Star?
B $8360,16,16 Star?
B $8370,16,16 Star?
B $8380,16,16 Frog?
B $8390,16,16 Frog?
B $83A0,16,16 Pawn?
B $83B0,16,16 Pawn?
B $83C0,16,16
B $83D0,16,16
B $83E0,16,16 Block?
B $83F0,16,16
B $8400,16,16 Block?
B $8410,16,16 Block?
B $8420,16,16
B $8430,16,16 Block?
B $8440,16,16 Pawn? Zone 7?
B $8450,16,16 Pawn? Zone 7?
B $8460,16,16 Ufo?
B $8470,16,16 Ufo?
B $8480,16,16 Ufo?
B $8490,16,16 Ufo?
B $84A0,16,16 Ufo?
B $84B0,16,16 Star?
B $84C0,16,16 Fire?
B $84D0,16,16 Fire?
B $84E0,16,16 Fire?
B $84F0,16,16 Pawn?
B $8500,16,16 Flat blocker
B $8510,16,16 Flat blocker
B $8520,16,16 Flat blocker
B $8530,16,16
B $8540,16,16 Flat blocker
B $8550,16,16 Flat blocker
B $8560,16,16 Flat blocker
B $8570,16,16 Flat blocker
B $8580,16,16 Flat blocker
B $8590,16,16 Flat blocker
B $85A0,16,16 Flat blocker
B $85B0,16,16 Flat blocker
B $85C0,16,16 Flat blocker Zone 5?
B $85D0,16,16 Glass? Zone 5?
B $85E0,16,16 Glass? Zone 5?
B $85F0,16,16 Star   Zone 5?
B $8600,16,16 Fire?
B $8610,16,16 Pawn?
B $8620,16,16 Frog?
B $8630,16,16 Frog?
B $8640,16,16 Barrel
B $8650,16,16 Barrel
B $8660,16,16 Barrel
B $8670,16,16 Barrel?
B $8680,16,16
B $8690,16,16
B $86A0,16,16
B $86B0,16,16
B $86C0,16,16
B $86D0,16,16
B $86E0,16,16
B $86F0,16,16
B $8700,16,16
B $8710,16,16
B $8720,16,16
B $8730,16,16 Barrel
B $8740,16,16 Fire?
B $8750,16,16 Fire?
B $8760,16,16
B $8770,16,16 Pawn?
B $8780,16,16
B $8790,16,16
B $87A0,16,16 Star?
B $87B0,16,16 Fire?
B $87C0,16,16 Fire?
B $87D0,16,16 Fire?
B $87E0,16,16 Fire?
B $87F0,16,16 Fire?
B $8800,16,16 Fire?
B $8810,16,16 Fire?
B $8820,16,16
B $8830,16,16
B $8840,16,16
B $8850,16,16
B $8860,16,16 Flat blocker
B $8870,16,16 Flat blocker
B $8880,16,16 Flat blocker
B $8890,16,16 Flat blocker
B $88A0,16,16 Flat blocker
B $88B0,16,16 Flat blocker
B $88C0,16,16 Flat blocker
B $88D0,16,16 Flat blocker
B $88E0,16,16 Pawn?
B $88F0,16,16 Star?
B $8900,16,16 Fire?
B $8910,16,16
B $8920,16,16 Pawn?
B $8930,16,16 Pawn? Zone 0?
B $8940,16,16 Fire? Zone 0?
B $8950,16,16 Fire? Zone 0?
B $8960,16,16 Fire? Zone 0?
B $8970,16,16 Fire? Zone 0?
B $8980,16,16 Fire? Zone 0?
B $8990,16,16 Pawn? Zone 0?
B $89A0,16,16
B $89B0,16,16
B $89C0,16,16
B $89D0,16,16
B $89E0,16,16
B $89F0,16,16
b $8A00 Objects table, 9 fixed records, 16 bytes each record
B $8A00,16,16
B $8A10,16,16 1st Auto-Vorton
B $8A20,16,16 2nd
B $8A30,16,16 3rd
B $8A40,16,16 4th
B $8A50,16,16 Lasertron
B $8A60,16,16
B $8A70,16,16
B $8A80,16,16
b $8A90 Objects table, 44 dynamic records, 16 bytes each
B $8A90,,16
w $8D52 List of objects to draw, order from far to nearest by Z-coord
W $8D52,,16
b $8E00 Table used in object movement procedure, 8 bytes each record
B $8E00,,8
b $8F00 Variables
B $8F00,1,1 Zone number
W $8F01,2,2 Object table address, 16 bytes per record; first record is currently active Vorton
W $8F03,2,2 Current zone offset, used to draw sprites
W $8F05,2,2 Current zone low pos = base pos - 128.
W $8F07,2,2 Current zone high pos
W $8F09,2,2 Current zone base pos = high pos - 48.
N $8F0B Referenced from #R$9861, #R$9AD8, #R$98A5, #R$98B0, #R$98C3
B $8F0D +015 Default sprite phase
B $8F0E +016 Main Vorton sprite phase
B $8F0F +017 Star sprite phase
B $8F10 +020, +021, +022 -- sprite phases
B $8F13 +023 Ufo sprite phase
B $8F14,1,1 Current action in animation mode (see A34D routine)
N $8F15 Referenced from #R$9B6E, #R$9AEF
B $8F15,1,1
B $8F16,1,1 Counter for Lasertron movement indicator
B $8F17,1,1 Current vorton indicator offset
B $8F18,1,1 Current Power indicator offset
B $8F19,1,1 Mission Time high counter
N $8F1A Referenced from #R$918C, #R$91C3
B $8F1A,1
N $8F1C Referenced from #R$9765, #R$934B, #R$A6B4, #R$A8D6
B $8F1C,1,1
N $8F23 Referenced from #R$B195, #R$9118
B $8F23,1,1
N $8F25 Initial values for the Variables block
B $8F4A
c $8F79 Redirects
D $8F79 Used by the routine at #R$B0DE.
N $8F7C This entry point is used by the routines at #R$B41B and #R$B4D0.
  $8F7C,3 Draw sprite with shift by 4px
N $8F7F This entry point is used by the routine at #R$B41B.
  $8F7F,3 Draw sprite with shift by 2px
N $8F82 This entry point is used by the routines at #R$B41B and #R$B4D0.
  $8F82,3 Draw sprite with no shift
N $8F85 This entry point is used by the routines at #R$B41B and #R$B4D0.
  $8F85,3 Draw sprite with shift by -2px
c $8F89 Routine ?? work on table $7B00
B $8F89
D $8F8A Used by the routine at #R$90F2.
C $8F8A,4 global objects table
C $8F97,3 get movement pattern
C $8FA0,3 alter movement
C $8FA6,2 next record
C $8FAE,2 repeat
b $8FB0 Text
B $8FB0 Text to print by #R$B890 routine
w $9000 Continuation points, see 9E6C
W $9000,240,16
W $90F0
c $90F2 Routine: GAME MODE
D $90F2 Used by the routine at #R$B0DE.
C $90F2,3 check score
C $90F5,3 Score
C $90F8,2 counter = 6
C $90FA,2 clear score digit
C $90FD,2 repeat
C $9101,3 print score
C $9104,3 init spd lvl
N $9107 This entry point is used by the routine at #R$A694.
C $9107,3 Intro
C $910E,2 Check for abort key
C $9113,3 "MISSION ABORTED"
C $911B,3 print text
C $911E,1 Exit GAME MODE
C $9127,3 "PAUSE MODE"
C $912A,3 print text
C $9163,3 Remove objects from the shadow screen
C $9166,3 Objects logic
C $9169,3 Process object movement
C $916C,3 Prepare table 8D52 (sort out objects by depth), and draw the objects
C $916F,3 redraw changes
C $9172,3 get zone number
C $9175,2 zone 30.?
C $9177,3 less => jump
N $917A Zone >= 30
C $917A,3 Lasertron object + $01
C $9185,2 ???
C $9189,3 => Animation in Zone 30
C $918C,3 get Mission Time low counter
C $918F,1 time's ticking
C $9192,1 time's out?
C $9193,2 no => jump
N $9195 Show Mission Time change
C $9195,3 get high counter
C $91A6,2 7 lines
C $91A9,1 next line
N $91B2 Mission Time is out
C $91B2,3 "TOO LATE MISSION TERMINATED"
C $91B5,3 Print text and Exit
C $91C0,3 reset Mission Time low counter
C $91C3,3 save the counter
C $91CA,3 get object table address
C $91D1,2 delay
C $91D4,2 dead Vorton?
C $91D6,3 no => continue main loop
C $91DC,1 next record
C $91DE,1 next Vorton indicator
C $91E0,2 Are we out of Vortons?
N $91E5 Sorry, all Vortons are dead, game over
C $91E5,3 "GAME OVER ALL VORTONS DESTROYED"
C $91E8,3 Print text and Exit
C $91EC,2 skip?
C $91EE,3 yes => jump
C $91F1,3 set object table address to next Vorton
C $91F7,1 to movement flags
C $91F8,2 explosion?
C $91FA,3 yes => jump
N $91FD HL points to (+$08) of Auto-Vorton to convert into Main Vorton
C $921B,1 HL points to (+$08)
C $921D,1 HL points to (+$06)
C $9220,1 HL points to (+$05)
C $9221,2 set base sprite number = Main Vorton
C $9226,1 HL points to (+$0A)
C $9227,2 set sprite number offset
N $9229 Reset the scene to continue with the new Main Vorton
C $922C,3 Show the screen
C $922F,3 continue main loop
b $9232 Text
B $9232 "MISSION ABORTED" - Text to print by #R$B890 routine
B $9247 "TOO LATE - MISSION TERMINATED"
B $926F "GAME OVER - ALL VORTONS - DESTROYED"
B $92A0 "PAUSE MODE" - text to print by #R$B890 routine
c $92CE Prepare objects for the current Zone
D $92CE Used by the routines at #R$90F2, #R$9C7B, #R$A291 and #R$A367.
C $92D1,2 clear the table (00 = table end marker)
C $92D3,4 current zone objects
C $92DA,2 end of table marker?
C $92DC,2 yes => jump
C $92E1,3 HL = address of the source record
C $92E9,3 14. bytes
C $92EC,2 copy
C $92F1,2 next record
C $92F3,2 repeat
N $92F5 This entry point is used by the routine at #R$A291.
C $92FA,1 HL points to (+$02)
C $92FB,1 DE = object position
C $9301,2 DE < 176. ?
C $9303,2 no => jump
C $9305,1 HL points to (+$01)
C $930A,2 initial Zone number
C $930C,3 initial position
C $930F,4 initial offset
C $9313,1 save A (Zone number)
C $9328,3 87.*32. = offset from one zone to another
C $932D,1 restore A (Zone number)
C $932E,1 next Zone
C $932F,2 repeat
C $9332,3 current zone high pos
C $9335,3 -48.
C $9339,3 current zone base pos
C $933C,3 -128.
C $9340,3 current zone low pos
C $9343,4 current zone offset
C $934A,1 restore A
C $934B,3 set Zone number
C $934E,2 zone 32. ?
C $9350,2 less => jump
C $9352,2 32.
C $935B,2 31.
C $935F,1 user-friendly zone number
C $9360,1 10. ?
C $9361,2 no => jump
C $9363,1 space
C $9364,1 lower digit
C $9369,1 accumulate upper decimal digit in B
C $936A,1 -10.
C $936B,1 10. ?
C $936C,2 no => jump
C $936E,1 lower digit
C $936F,1 working with upper digit
C $9370,1 = X*2
C $9371,1 = X*2+X
C $9372,1 = (X*2+X)*2 = X*6
C $9373,3 address of sprite index list for large digits
C $9379,1 get lower digit
C $937A,1 = X*2
C $937B,1 = X*2+X
C $937C,1 = (X*2+X)*2 = X*6
C $937F,4 address of screen position array for ZONE digits
C $9383,3 show first ZONE digit
C $9386,3 address of sprite index list for large digits
C $938E,3 show second ZONE digit
c $9394 Draw digit with size of 16x24 pixels into the ZONE indicator
D $9394 Used by the routine at #R$92CE.
C $9396,1 get sprite number
C $93A0,1 * 8.
C $93A1,1 got 8x8 sprite address
C $93A2,3 address on the screen
C $93A7,2 counter = 8.
C $93A9,1 get 8 pixels of sprite
C $93AB,1 write into screen
C $93AC,1 next line
C $93AD,2 repeat
C $93B4,2 repeat
c $93B7 Routine
D $93B7 Used by the routine at #R$92CE.
N $93B7 First, we select objects from $7B00 table to $8A90 table
C $93BB,3 current zone objects
C $93BE,2 max number of objects to select
C $93C4,2 marked to skip?
C $93C6,2 yes => skip
C $93CB,3 get object position
C $93CE,4 current zone low pos
C $93D6,2 512. ?
C $93D8,2 no => skip the record
C $93DA,3 14. bytes
C $93DE,2 copy from: current IX record
C $93E3,2 copy to the DE record
C $93E7,1 save the IX address
C $93E8,1 in the last two bytes
C $93EE,1 reached max records?
C $93F0,2 yes => jump
C $93F5,2 next IX record
C $93F9,2 end of table ?
C $93FB,2 not yet => continue
C $93FD,2 mark end of table
N $9400 Mark as empty all records with (IX+$05) between 128 and 224
C $9404,3 record size
C $940A,2 < 128. ?
C $940E,2 >= 224. ?
C $9412,4 mark to skip
C $9416,4 alter movement
C $941A,2 next record
C $941E,2 end of table?
C $9420,2 no => repeat again
c $9423 Initializing objects tables
D $9423 Called before starting animation. Used by the routine at #R$A291.
C $9427,4 sprite index -- first record is Vorton
C $942B,4 movement pattern -- normal
C $942F,3 record width = 16.
C $9432,2 loop counter
C $9436,4 sprite index
C $943A,4 movement pattern
C $943E,2 continue the loop
C $9440,3 table address
C $9443,2 clear the table
C $9445,4 global objects table
C $9449,2 loop counter = 249.
C $944B,1 +1, save the counter
C $944F,3 movement pattern
C $945A,3 set movement pattern
C $9460,3 get movement pattern
C $946E,3 sprite phase ??
C $9473,3 write the routine number
C $947F,1 HL = IX+13.
C $9480,3 initialize
C $9483,2 (+$00),(+$01),(+$02)
C $948A,3 set direction
C $9494,3 get movement pattern
C $94A0,4 stop
C $94B2,3 HL = object position
C $94B5,1 +2  save obj position
C $94B6,1 +3
C $94C0,1 * 32.
C $94C8,1 +2
C $94C9,1 HL = object position
C $94D9,1 +1
C $94DE,3 save object ??
C $94EB,3 save horz offset
C $94EE,3 next IX record
C $94F3,1 0, restore counter
C $94F5,3 repeat the loop
b $9536
b $95E3
c $95EF Prepare shadow screen, show the screen
D $95EF Used by the routines at #R$90F2, #R$9C7B, #R$A291 and #R$A367.
C $95F7,3 576.
C $95FA,2 loop unroll x2
C $961F,3 4352.
C $9627,3 Draw zone border
C $962D,3 Draw zone border
C $9630,3 go to Draw zone land
c $9633 Draw zone border line
D $9633 Used by the routine at #R$95EF.
N $9658 Referenced from #R$965F, #R$9692, #R$96E0, #R$96E4, #R$96EC, #R$970D
c $9658 Draw zone land
B $9658,1,1 Pattern column height, in char-lines
N $9659 Referenced from #R$967E, #R$96D6, #R$96F9, #R$974B
W $9659,2,2
N $965B Referenced from #R$969F, #R$96AA, #R$96C9, #R$9714, #R$971F, #R$973E
W $965B,2,2
D $965D Used by the routine at #R$95EF.
C $965D,2 initial column height
C $965F,3 initial column height
C $9662,3 get zone number
C $966B,1 x16
C $966E,1 x32
C $966F,1 x48
C $9678,3 draw markers area address
C $967D,1 Start of upper background columns drawing loop
C $9689,1 HL = A * 4
C $968D,1 HL = A * 12.
C $968E,3 pattern sequence block
C $9695,1 height count
C $96B3,1 HL = A * 8.
C $96B4,3 pattern block address
C $96B7,1 got tile address in R3
C $96B8,2 line counter = 8.
C $96BA,3 line length 32.
C $96BE,1 get 8 pixels
C $96BF,3 write 8 pixels
C $96C3,2 to next line
C $96C7,2 repeat the loop by lines
C $96CD,2 repeat
C $96D3,1 to next column
C $96D4,2 to next column
C $96DC,2 even column?
C $96DE,2 yes => repeat the loop
C $96E0,3 decrease column height
C $96E8,2 repeat
C $96EA,2 initial column height
C $9704,1 HL = A * 4
C $9708,1 HL = A * 12.
C $9728,1 HL = A * 8.
C $9729,3 pattern block address
C $973C,2 repeat the loop by lines
C $9748,1 to next column
C $9749,2 to next column
C $9765,3 get zone number
C $9768,2 zone >= 31?
C $976A,3 yes => draw zone specials
C $9778,2 Make top line
C $9783,2 Make bottom line
C $978B,2 lines
C $978E,2 Left border
C $9793,2 Right border
  $97A9,3 Screen address
C $97E8,2 Copy main part, 4096. bytes, 128. lines
C $97EA,2 15.
C $97EC,2 2x8 lines remaining to copy
C $981A,3 576.
C $981F,3 Draw flat blockers
c $9822 Routine
D $9822 Used by the routines at #R$90F2, #R$A34D and #R$A8C5.
C $9826,1 is the table empty?
C $9827,3 yes => return
C $982A,1 NOTE: first byte replaced with word
C $982B,1 NOTE: word aligned
C $982D,1 DE = object record address
C $982F,1 save address in table 8D52
C $9833,1 HL points to (+$03)
C $9835,1 HL points to (+$04)
C $9836,1 DE = object offset
C $9837,3 current zone offset
C $983D,3 -4091.
C $9840,1 minus distance between the screens
C $9841,2 24. = sprite height
C $9846,2 copy 3 bytes = 24. pixels
C $9848,3 -35. = -32. - 3
C $984C,1 one line up
C $984E,1 one line up
C $9850,3 repeat
C $9853,1 restored address in table 8D52
C $9855,1 end of table?
C $9856,3 no => continue the loop
c $985A Sort Objects
D $985A Used by the routines at #R$90F2, #R$A34D and #R$A8C5.
C $985E,3 start of table 8D52
C $9861,3 save address in table 8D52
C $9864,2 clear the table
C $9869,2 empty record?
C $986B,3 yes => skip
C $986E,3 end of table => proceed to drawing
C $9872,3 movement pattern
C $9877,3 => proceed to next record
C $987C,3 => proceed to next record
C $987F,4 current zone base pos
C $9886,3 HL = object position
C $988E,3 => proceed to next record
C $9898,3 table start address
C $989E,1 NOTE: first byte of record replaced with word
C $98A4,1 save A
C $98A5,4 restore address in table 8D52
C $98AA,1 are we at end of table?
C $98AB,2 no => need to shift table block
C $98AD,1 NOTE: first byte of record replaced with word
C $98B0,4 Save the address
C $98B4,1 clear first
C $98BE,1 prepared the counter
C $98C0,1 NOTE: first byte of record replaced with word
C $98C3,4 save address in table 8D52
C $98C7,2 shift the block
C $98CA,1 restore A
C $98CC,1 NOTE: first byte of record replaced with word
C $98D1,1 NOTE: word aligned
C $98D7,2 next record by IX
C $98DC,3 table start address
N $98E2 This entry point is used by the routine at #R$9980.
C $98E3,1 NOTE: word aligned
C $98EB,1 save address in table 8D52
C $98EE,3 get sprite phase
C $98F1,1 WARN: accessing $8F00 area by offset
C $98F2,3 add base sprite number
C $98F6,2 sprite address table 7A00
C $98FA,1 DE = sprite address
C $98FB,3 get horz offset (bits 2-3 only)
C $98FE,1 bits 3-4
C $9902,3 jump base address
C $9909,3 BC = object offset
C $990C,1 save HL
C $990D,3 current zone offset
C $9912,1 BC = address where to draw the sprite
C $9913,1 restore HL and set value on stack
C $9914,1 Draw the sprite
C $9915,3 Draw sprite with shift by 4px
C $991D,3 Draw sprite with shift by 2px
C $9925,3 Draw sprite with no shift
C $992D,3 Draw sprite with shift by -2px
c $9933 Draw sprite with shift by -2px
D $9933 Used by the routines at #R$8F79, #R$985A, #R$A546 and #R$A8D6.
R $9933 BC ??
R $9933 DE Mask and Sprite address
C $9935,2 Sprite height = 24.
c $9980 Routine
D $9980 Used by the routine at #R$985A.
C $9982,2 drawn to the second shadow screen?
C $9984,3 no => skip
C $9988,2 calculate offset from the screen start
C $998C,1 bits 3-7
C $9991,1 bits 5-9
C $9993,2 offset within a single line -- 0..31.
C $9996,2 add offset within the line
C $9998,1 draw flags area start address
C $9999,3 -34.
C $999C,2 draw marker
C $999E,2 sprite occupies 3 or 4 char-lines
C $99A0,1 mark 3 char-cells for redraw
C $99A5,1 to previous line
C $99A6,2 repeat
C $99A8,1 restore address in table 8D52
C $99AA,1 end of table?
C $99AB,3 no => continue the main loop
C $99B4,2 draw marker
C $99B7,2 loop counter = 7
C $99B9,3 line length minus 1
C $99C7,1 to next line
C $99C9,1 to next line
C $99CD,3 repeat loop by lines
c $99D1 Draw sprite with shift by 4px
D $99D1 Used by the routines at #R$8F79, #R$985A, #R$A546 and #R$A8D6.
R $99D1 BC ??
R $99D1 DE Mask and Sprite address
C $99D3,2 Sprite height = 24
C $99D5,1 store counter A
C $99D7,1 Get mask byte 0
C $99D9,1 Get mask byte 1
C $99DB,1 Get mask byte 2
C $99DE,5 Shift by 1
C $99E3,5 Shift by 2
C $99E8,5 Shift by 3
C $99ED,5 Shift by 4
C $9A01,5 Shift by 1
C $9A06,5 Shift by 2
C $9A0B,5 Shift by 3
C $9A10,5 Shift by 4
C $9A20,1 restore counter A
C $9A22,3 loop by sprite height
c $9A26 Draw sprite with shift by 2px
D $9A26 Used by the routines at #R$8F79, #R$985A, #R$A546 and #R$A8D6.
R $9A26 BC ??
R $9A26 DE Mask and Sprite address
C $9A28,2 loop counter = 24.
C $9A6B,1 repeat the loop
c $9A70 Draw sprite with no shift
D $9A70 Used by the routines at #R$8F79, #R$985A, #R$A546 and #R$A8D6.
R $9A70 BC ??
R $9A70 DE Mask and Sprite address
C $9A72,2 loop counter = 24.
C $9A98,2 repeat the loop
c $9A9B Redraw changes
D $9A9B Used by the routines at #R$90F2, #R$A34D and #R$A8C5.
C $9A9E,1 number of blocks in the line
C $9A9F,1 NOTE: byte replaced with word
C $9AA2,1 DE = address in the shadow screen
C $9AA7,1 DE = address on the real screen
C $9AAB,1 BC points to draw markers, end of the line
C $9AAD,1 now HL = address in the shadow screen
C $9AAE,2 loop counter for the line
C $9AB1,1 is marker empty?
C $9AB2,3 yes => skip the block
C $9AB6,1 update marker value
C $9AB7,2 save B
C $9AB9,2 Loop by char-cell lines, 8. lines
C $9ABB,1 |  #0..6
C $9ABC,1 write to screen
C $9ABD,1 to previous screen line
C $9AC0,1 to previous shadow screen line
C $9AC2,2 continue the loop by lines
C $9AC5,2 8. screen lines down
C $9AC8,2 restore B
C $9ACB,1 to previous position in the line
C $9ACC,1 to previous element of markers array
C $9ACF,3 continue the loop by line
C $9AD2,1 restore address in table L9BFC
C $9AD3,1 NOTE: byte replaced with word
C $9AD4,1 end of table?
C $9AD5,3 no => repeat
C $9AD8,3 address in table 8D52
C $9ADB,2 8D6A ? less than 8 objects
C $9ADD,3 no => jump
C $9AE4,1 got the delay value
C $9AEA,2 delay
C $9AFE,3 Sound
C $9B10,3 Sound
C $9B1F,3 Sound
N $9B2C Sound. This entry point is used by the routine at #R$A694.
  $9B30,1 Border 0
  $9B31,2 Inverse EAR and MIC bits
  $9B34,2 Output EAR/MIC
  $9B36,2 wait
  $9B3A,2 loop
  $9B4A,2 repeat
N $9B5B Sound. This entry point is used by the routine at #R$A694.
  $9B5B,1 Border 0
  $9B5D,2 Inverse EAR and MIC bits
  $9B60,2 Output EAR/MIC
  $9B62,2 wait
  $9B65,2 loop
C $9B72,3 Lasertron object + 8.
C $9B75,1 get movement flags
C $9B76,1 stopped?
C $9B77,3 yes => jump
C $9B7A,3 Lasertron object + 2
C $9B81,3 -16.
C $9BB0,3 greater => movement
C $9BB3,3 object table address
C $9BB9,3 greater => stop
C $9BBE,3 less => stop
C $9BD2,3 greater => movement
C $9BD6,3 set Lasertron movement = stop
C $9BE2,3 get the counter
C $9BE5,1 increment
C $9BE6,2 0..7
C $9BE8,3 save the counter
C $9BEC,2 zeroed? => clear movement indication
C $9BF5,3 increment score
C $9BFA,2 show movement indication
b $9BFC Redraw table: 18 records used to draw the shadow screen
B $9BFC,,7
c $9C7B Routine
D $9C7B Used by the routines at #R$90F2, #R$A34D and #R$A8C5.
C $9C82,2 skip?
C $9C84,3 yes => next record by IX
C $9C87,3 movement flags
C $9C8F,4 set direction = forward/default
C $9C99,3 HL = object position
C $9CA8,4 current zone high pos
C $9CB9,3 Prepare objects for the current Zone
C $9CBC,3 Show the screen
C $9CBF,4 object table address
C $9CC3,3 get movement flags
C $9CC6,1 stopped?
C $9CC7,3 no => jump
C $9CCA,3 next record by IX
C $9CCD,3 get movement flags
C $9CD3,3 => next record by IX
C $9CDB,3 base sprite number
C $9CE0,2 334 ?
C $9CE2,2 less => jump
C $9CE4,4 mark the record as empty
C $9CE8,4 alter movement flags
C $9CEC,3 next record by IX
C $9CEF,3 set base sprite number
C $9CF5,3 get movement pattern
C $9CFA,1 is it Vorton?
C $9CFB,2 Vorton died => jump
C $9D03,3 next record by IX
C $9D08,3 next record by IX
C $9D0D,3 attributes
C $9D16,2 divide by 8.
C $9D23,1 next line
C $9D26,3 next record by IX
C $9D2B,1 bits 6-7
C $9D2D,3 movement direction 0..7
C $9D30,1 (IX+$07)*2
C $9D31,1 (IX+$07)*4
C $9D32,1 (IX+$07)*8 -- bits 3-5
C $9D33,1 (IX+$07)*8+L -- bits 3-5 and 6-7
C $9D35,2 8E00 table address
C $9D37,1 get value from the table 8E00
C $9D3B,1 HL points to (+$01)
C $9D3D,1 HL points to (+$02)
C $9D3E,1 DE = object position change
C $9D3F,3 save HL, points to (+$02) in 8E00 table
C $9D45,3 HL = IX object position
C $9D48,1 HL = IX obj pos + pos change
C $9D49,2 73. ?
C $9D50,3 jump to collision processing
C $9D53,2 -7
C $9D55,2 save A
C $9D57,4 current zone low pos
C $9D66,3 jump to collision processing
C $9D69,1 restore HL value
C $9D6A,3 -7
C $9D70,3 object table address
C $9D74,2 empty record?
C $9D76,3 no => jump
C $9D79,2 end of table by HL => jump
C $9D7E,1 next record by HL
C $9D7F,3 continue by HL
C $9D82,2 restore A
C $9D90,3 save new object position
C $9D93,3 restore HL, points to (+$02) in 8E00 table
C $9D96,1 HL points to (+$03)
C $9D97,1 horz offset change
C $9D98,1 HL points to (+$04)
C $9D99,3 add horz offset (bits 2-3 only)
C $9D9C,2 13. ?
C $9DA0,2 128. ?
C $9DA4,2 +16.
C $9DA9,2 -16.
C $9DAB,1 HL points to (+$05)
C $9DAC,1 HL points to (+$06)
C $9DAD,3 save horz offset
C $9DB1,1 HL points to (+$07)
C $9DB2,1 DE = offset change
C $9DB6,3 HL = object offset
C $9DBA,3 save object offset
C $9DC0,3 get IX movement pattern
C $9DC8,3 get next random number
C $9DCB,3 0..7
C $9DD7,1 TODO: Need to verify/clarify this operation
C $9DDA,3 set new direction
C $9DDD,3 next record by IX
C $9DE7,3 get next random number
C $9DEB,2 x < 245. ?
C $9DED,3 yes => jump
C $9DF0,3 get current direction
C $9DF3,1 rotate left
C $9DF4,2 0..7
C $9DF6,3 set the direction
C $9DF9,3 next record by IX
C $9DFC,2 x >= 10. ?
C $9DFE,3 yes => jump
C $9E01,3 get current direction
C $9E04,1 rotate right
C $9E05,2 0..7
C $9E07,3 set the direction
C $9E0A,3 next record by IX
C $9E0D,2 = 10. ?
C $9E0F,3 no => next record by IX
C $9E16,4 alter movement
C $9E1D,2 next record by IX
C $9E24,3 (IX+$00) < $FE ? => jump
C $9E27,3 (IX+$00) == $FE ? => next record by IX
C $9E2A,1 (IX+$00) == $FF => end of table, return
C $9E2B,2 use stored A
C $9E2F,3 => next record by HL
C $9E34,1 HL points to (+$02)
C $9E35,1 DE = HL object position
C $9E3A,1 HL points to (+$02)
C $9E48,1 HL points to next record
C $9E49,3 continue by HL
C $9E50,1 IX and HL points to the same record?
C $9E56,2 yes => next record by HL
C $9E5B,1 DE points to (+$02)
C $9E5D,1 HL points to (+$06)
C $9E5E,1 get HL movement pattern
C $9E62,3 add IX base continuation point number
C $9E65,1 now L should be 0..240.
C $9E66,2 start of continuation points table = $9000
C $9E68,1 get the continuation point address
C $9E6C,1 jump to continuation point
C $9E6F,1 HL points to (+$02)
C $9E71,1 HL points to (+$06)
C $9E72,2 check movement pattern
C $9E74,3 alter IX movement and next by IX
C $9E77,1 HL points to (+$07)
C $9E78,3 get direction
C $9E7C,1 rotate left 90 degree
C $9E82,2 set direction = forward
C $9E84,1 HL points to (+$08)
C $9E85,2 set movement = move
C $9E87,4 set movement = move
C $9E8B,3 next record by IX
C $9E90,1 HL points to (+$02)
C $9E92,1 HL points to (+$06)
C $9E93,3 get movement
C $9E9D,3 => next record by IX
C $9EA0,3 alter IX movement and next by IX
C $9EA5,3 set movement
C $9EA8,2 check movement pattern
C $9EAF,1 HL points to (+$08)
C $9EB2,1 set movement
C $9EB3,1 HL points to (+$07)
C $9EB4,3 get direction
C $9EB7,1 copy direction
C $9EB8,3 next record by IX
C $9EBB,4 mark IX record as empty
C $9EC1,1 HL points to (+$02)
C $9EC3,1 HL points to (+$07)
C $9EC4,3 get direction
C $9EC7,1 copy direction
C $9EC8,3 get movement
C $9ECB,1 HL points to (+$06)
C $9ECC,2 check movement pattern
C $9ED3,1 HL points to (+$08)
C $9ED6,1 set movement
C $9EDA,3 movement pattern
C $9EDE,2 0 => jump
C $9EE0,2 1 ?
C $9EE2,3 no => next record by IX
C $9EE7,3 next record by IX
C $9EF3,4 alter movement
C $9EFF,3 next record by IX
C $9F02,1 HL points to (+$02)
C $9F03,3 next record by HL
C $9F06,1 HL points to (+$02)
C $9F08,1 HL points to (+$00)
C $9F09,2 mark HL record as empty
C $9F0B,4 explosion
C $9F18,2 plus 25. points
C $9F1A,3 Increment score
C $9F1D,3 next record by IX
C $9F20,1 HL points to (+$02)
C $9F24,1 HL points to (+$08)
C $9F25,1 get movement flags
C $9F27,1 HL points to (+$06)
C $9F28,1 get movement pattern
C $9F2C,1 HL points to (+$00)
C $9F2D,2 check movement
C $9F2F,3 not equal => next record by HL
C $9F32,1 movement pattern
C $9F42,2 mark HL record as empty
C $9F44,4 explosion
C $9F51,3 next record by IX
C $9F54,1 HL points to (+$02)
C $9F57,1 HL points to (+$08)
C $9F59,2 check movement flags
C $9F5E,4 mark IX record as empty
C $9F62,2 alter movement flags
C $9F66,1 HL points to (+$05)
C $9F6E,2 plus 25. points
C $9F70,3 Increment score
C $9F73,3 next record by IX
C $9F79,1 HL points to next record
C $9F7A,3 continue
C $9F7D,1 HL points to (+$02)
C $9F80,1 HL points to (+$08)
C $9F82,2 check movement flags
C $9F87,4 mark IX record as empty
C $9F8C,1 HL points to (+$06)
C $9F8F,2 alter movement pattern
C $9F95,1 HL points to (+$05)
C $9FA3,3 next record by IX
C $9FAA,1 HL points to (+$08)
C $9FAB,2 set movement flags
C $9FB2,3 next record by IX
C $9FB5,3 get movement pattern
C $9FBD,4 mark IX record as empty
C $9FC1,1 HL points to (+$02)
C $9FC4,1 HL points to (+$05)
C $9FC5,1 get base sprite number
C $9FC6,2 200 ? Exlposion starts from 200
C $9FC8,2 less => jump
C $9FCC,1 HL points to (+$02)
C $9FCD,3 next record by HL
C $9FD0,2 base sprite = Explosion
C $9FD4,1 HL points to (+$08)
C $9FD5,2 set movement flags bit 7
C $9FDC,3 next record by IX
C $9FDF,1 HL points to (+$02)
C $9FE0,3 get sprite index
C $9FE3,2 IX is Main Vorton?
C $9FE5,3 yes => next record by HL
C $9FE9,1 HL points to (+$00)
C $9FEA,2 mark HL record as empty
C $9FEC,3 next record by HL
C $9FEF,1 HL points to (+$02)
C $9FF3,1 HL points to (+$0A)
C $9FF4,1 get sprite index
C $9FF5,2 is it Vorton?
C $9FF7,3 no => jump
C $9FFD,1 HL points to next record
C $9FFE,3 continue
C $A001,4 mark IX record as empty
C $A005,3 next record by IX
C $A008,3 Get next random number
C $A00B,1 rotate to random direction
C $A00C,2 one of four directions
C $A00E,3 set direction
C $A014,3 Get next random number
C $A017,1 rotate to random direction
C $A018,2 value 0..7
C $A01A,3 set direction
C $A01D,3 next record by IX
C $A020,3 Get next random number
C $A024,2 value 0..7
C $A029,3 Random movement with limitations
C $A02C,3 get direction
C $A02F,2 180 degree rotation
C $A033,3 set direction
C $A036,3 next record by IX
C $A039,1 Temporary storage for HL
c $A03B Routine
D $A03B Used by the routine at #R$90F2.
C $A051,2 keyboard 7FFE B - Space
C $A059,2 fire
C $A05D,2 keyboard F7FE 1 - 5
C $A060,2 not "1" -> jump
C $A062,2 "1"
C $A066,2 keyboard FBFE Q - T
C $A069,2 not "Q" -> jump
C $A06B,2 "Q"
C $A06F,2 keyboard DFFE Y - P
C $A072,2 not "P" -> jump
C $A074,2 "P", right
C $A077,2 not "O" -> jump
C $A079,2 "O", left
C $A07C,3 set current action byte
c $A10B Routine
D $A10B Used by the routine at #R$A11B.
C $A111,1 increase power
C $A119,1 restore AF
c $A11B Routine
D $A11B Used by the routines at #R$A03B and #R$A34D.
C $A11F,2 to movement flags
C $A122,1 DE points to (+$08)
C $A123,1 get movement flags
C $A124,2 explosion?
C $A126,3 no action required
C $A129,3 get current action flags
C $A12E,3 HL = $8F1D
C $A136,2 break/stop?
C $A138,2 no => jump
C $A13A,1 get movement flags
C $A140,1 set movement flags
C $A144,2 accelerate?
C $A146,2 no => jump
C $A148,1 get movement flags
C $A14E,1 set movement flags
C $A155,1 HL = $8F1E
C $A156,1 DE points to (+$07)
C $A15E,2 rotation right?
C $A160,2 no => jump
C $A162,1 get current direction
C $A163,1 rotate right
C $A166,1 save new direction
C $A167,2 rotation left?
C $A169,2 no => jump
C $A16B,1 get current direction
C $A16C,1 rotate left
C $A16D,2 0..7
C $A16F,1 save new direction
C $A170,1 DE = $8F1E
C $A171,3 1st bullet object record addr
C $A174,1 DE = $8F1F
C $A178,3 restore power
C $A17E,2 mark the record to skip
C $A183,1 DE = $8F20
C $A187,1 HL = 2nd bullet record
C $A18B,3 restore power
C $A191,2 mark the record to skip
C $A196,1 DE = $8F21
C $A19A,1 HL = 3rd bullet record
C $A19E,3 restore power
C $A1A4,2 mark the record to skip
C $A1A9,1 HL = $8F21
C $A1AA,1 HL = $8F22
C $A1B0,3 get current action
C $A1B3,2 fire?
C $A1B5,3 no => jump
C $A1B8,1 HL = $8F21
C $A1B9,1 DE = $8F21
C $A1BE,1 DE = $8F20
C $A1BF,3 -16.
C $A1C8,1 DE = $8F1F
C $A1CD,1 DE = record address
C $A1CE,2 set sprite = fireball
C $A1D5,3 get addr of Main Vorton
C $A1D8,3 5 bytes
C $A1DB,2 copy pos/offset to bullet object
C $A1DE,1 HL points to (+$07)
C $A1E0,1 DE  points to (+$07)
C $A1E1,2 copy direction byte
C $A1E3,1 HL points to (+$08)
C $A1E4,1 DE points to (+$08)
C $A1E6,1 copy movement flags byte
N $A1F8 This entry point is used by the routine at #R$A8C5.
C $A1FB,4 object table address
C $A1FF,3 get direction 0..7
C $A202,1 sprite phase copying direction
C $A203,1 save Main Vorton sprite phase
C $A211,3 addr of Star sprite number
C $A218,1 get Star sprite number
C $A21A,2 7 ?
C $A21C,2 yes => jump
C $A229,1 HL = $8F11 addr of Pawn sprite number
C $A22A,1 get Pawn sprite number
C $A232,1 set Pawn sprite number
C $A241,3 L8F00+020
C $A248,1 get Fire A phase
C $A257,1 set Fire A phase
C $A25A,1 get Fire B phase
C $A262,1 set Fire B phase
C $A263,3 addr of Ufo sprite phase
C $A268,1 next sprite
C $A26E,1 set Ufo sprite phase
c $A270 Routine
D $A270 Used by the routines at #R$9A9B, #R$9C7B and #R$A8D6.
C $A289,3 ; Write RND SEED variable
B $A28D,1,1
B $A28E,1,1
B $A28F,1,1
B $A290,1,1
c $A291 Intro
D $A291 Used by the routines at #R$90F2 and #R$A367.
C $A294,3 to variables block
C $A29A,2 copy
C $A29C,3 Prepare screen and indicators
C $A29F,3 Preparing objects tables
C $A2A2,3 Prepare objects for the current Zone
C $A2A5,3 Show the screen
C $A2A8,2 table ending marker
C $A2AD,2 Main Vorton movement
C $A2B3,2 loop counter
C $A2B5,3 do the action
C $A2B8,2 action = rotate right
C $A2BA,2 loop counter
C $A2BC,3 Main Vorton rotates
C $A2BF,2 proper direction?
C $A2C1,2 no => repeat
C $A2C3,2 Main Vorton movement flags = move
C $A2C8,1 action = none
C $A2C9,2 loop counter = 14.
C $A2CB,3 do the action
C $A2CE,2 action = ??
C $A2D0,2 loop counter = 1
C $A2D2,3 do the action
C $A2D8,2 action = rotate right
C $A2DA,2 loop counter = 1
C $A2DC,3 do the action
C $A2DF,2 rotated to the proper direction?
C $A2E1,2 no => repeat
C $A2E3,3 Auto-Vorton movement
C $A2E9,2 counter = 4 Auto Vortons
C $A2EB,2 set movement flags = move
C $A2ED,1 to the next record
C $A2EE,2 repeat
C $A2F0,1 action = none
C $A2F1,2 loop counter
C $A2F3,3 do the action
C $A2F6,3 Auto-Vorton direction
C $A2F9,2 diagonally
C $A2FF,2 diagonally
C $A302,2 diagonally
C $A305,2 diagonally
C $A307,1 action = none
C $A308,2 loop counter
C $A30A,3 do the action
C $A30D,3 Auto-Vorton direction
C $A313,2 counter = 4 extra Vortons
C $A316,1 direction
C $A318,1 movement flags = stop
C $A319,1 to the next record
C $A31A,2 repeat
C $A31C,2 action = rotate left
C $A31E,2 loop counter
C $A320,3 do the action
C $A323,2 rotated to the proper position?
C $A325,2 no => repeat
C $A327,2 set Main Vorton movement
C $A32C,1 no action
C $A32D,2 loop counter = 32.
C $A32F,3 do the action
C $A332,2 action = rotate left
C $A334,2 loop counter = 1
C $A336,3 do the action
C $A339,1 Main Vorton looking forward?
C $A33A,2 no => repeat
C $A33C,3 Extra Vorton movement
C $A342,2 counter = 4 extra Vortons
C $A344,2 start moving
C $A346,1 to the next record
C $A347,2 repeat
c $A34D Routine (the most used one)
D $A34D Used by the routines at #R$A291, #R$A617 and #R$A694.
R $A34D A ??
R $A34D BC Counter
C $A351,3 Remove objects from the shadow screen
C $A354,3 Objects logic, perform the action
C $A357,3 Process object movement
C $A35A,3 Prepare table 8D52 (sort out objects by depth), and draw the objects
C $A35D,3 Draw the shadow screen on the real screen, using draw markers
C $A363,3 Main Vorton direction 0..7
c $A367 Routine
D $A367 Used by the routine at #R$8F79.
C $A36A,2 jump into the loop
C $A36C,3 Prepare objects for the current Zone
C $A36F,3 Show the screen
C $A372,3 "DEMO MODE"
  $A375,3 Print Text
C $A378,2 number of iterations in one zone
C $A37B,3 show one screen in DEMO
C $A380,2 Check keyboard
C $A382,1 key pressed?
C $A383,2 yes => exit DEMO
C $A386,2 repeat
C $A388,3 Zone number
C $A38B,2 31. ?
C $A38D,2 no => end of DEMO
C $A38F,3 Object record #4 movement
C $A392,2 stop
C $A394,3 object table address
C $A397,2 mark record to skip
C $A399,1 HL points to (+$01)
C $A39B,1 HL points to (+$02)
C $A39C,1 DE = object position
C $A3A2,1 DE = obj pos + 176.
C $A3A3,1 save object position
C $A3A6,2 repeat in the loop by zones
C $A3B7,3 "THERE IS ONLY ONE WAY TO ENCOUNTER..."
  $A3BA,3 Print Text
c $A3D3 Routine
D $A3D3 Used by the routine at #R$A291.
C $A403,3 Screen attribute area address
C $A409,2 Fill attributes
C $A40B,3 Show score
C $A40E,3 Show score
c $A414 Routine
D $A414 Used by the routines at #R$9A9B, #R$9C7B and #R$A617.
N $A42B This entry point is used by the routines at #R$90F2 and #R$A3D3.
C $A42E,3 Score
N $A431 This entry point is used by the routine at #R$A450.
C $A439,1 * 5
C $A442,2 5 lines
C $A446,1 next line
C $A44B,1 previous position
c $A450 Check Score
D $A450 Used by the routine at #R$90F2.
C $A456,2 counter
C $A47B,3 score
C $A549,2 clear flag
C $A54B,4 objects table
C $A55A,3 get movement pattern
C $A55D,2 flat blocker?
C $A55F,3 no => skip
C $A562,4 current zone base pos
C $A569,3 object position
C $A574,3 get horz offset (bits 2-3 only)
C $A582,3 BC = object offset
C $A586,3 current zone offset
C $A58B,1 BC = address where to draw the sprite
C $A58E,3 Sprite #5 flat blocker
C $A5C0,2 offset within a single line -- 0..31.
C $A5C5,1 draw flags area start address
C $A5C6,3 -34.
C $A5C9,2 draw marker
C $A5CB,2 sprite occupies 3 or 4 char-lines
C $A5CD,1 mark 3 char-cells for redraw
C $A5D2,1 to previous line
C $A5D3,2 repeat
C $A5D8,2 mark that we drawn a blocker
C $A5E5,1 did we draw a blocker?
C $A5E6,1 no => return
C $A5E7,3 from the second shadow screen
C $A5EA,3 to the first one
C $A5ED,3 4096. bytes
C $A5F0,2 copy
C $A619,4 object table beginning
C $A620,2 skip?
C $A622,2 yes => jump
C $A624,4 explosion
C $A632,2 bonus for saved Vorton
C $A634,3 Increase score
C $A63B,2 next record
C $A63D,2 repeat
C $A643,2 loop counter = 24.
C $A645,1 action = none
C $A646,3 do the action
C $A649,3 Lasertron
C $A64C,3 set object table address
C $A64F,2 loop counter = 15.
C $A651,1 action = none
C $A652,3 do the action
C $A6B1,3 show one screen in DEMO
C $A6B7,2 Zone 36. ?
C $A6B9,2 not yet => repeat
C $A6DB,3 show one screen in DEMO
C $A6E5,1 next sprite
C $A6EC,3 show one screen in DEMO
C $A701,3 replace fireball with laserbeam
C $A706,2 action = fire!
C $A713,3 restore fireball sprite
C $A818,3 "PREPARE YOURSELF FOR THE NEXT"
C $A8C8,3 DEMO mode objects logic
C $A8CB,3 Process object movement
C $A8CE,3 Prepare table 8D52 (sort out objects by depth), and draw the objects
C $A8D1,3 Draw the shadow screen on the real screen, using draw markers
  $AA61,3 Spacecraft sprite data
N $A478 This entry point is used by the routine at #R$A3D3.
b $A480 Data block
B $A4C7 Text to print by #R$B890 routine
B $A4D6 Text to print by #R$B890 routine
c $A546 Draw Rough
D $A546 Used by the routine at #R$965D.
  $A592,3 Draw sprite with shift by 4px
  $A59A,3 Draw sprite with shift by 2px
  $A5A2,3 Draw sprite with no shift
  $A5AA,3 Draw sprite with shift by -2px
c $A617 Routine
D $A617 Used by the routine at #R$90F2.
c $A677 Routine
D $A677 Used by the routine at #R$A617.
c $A694 Routine
D $A694 Used by the routine at #R$A617.
  $A6A9,3 Sound
  $A79B,3 Sound
  $A81B,3 Print Text
c $A8C5 Routine
D $A8C5 Used by the routines at #R$A367 and #R$A694.
c $A8D6 Draw zone specials
C $A8D6,3 get zone number
D $A8D6 Used by the routine at #R$965D.
C $A8EB,3 Draw zone special 0
C $A8EF,3 Draw zone special 1
C $A8F3,3 Draw zone special 2
C $A8F7,3 Draw zone special 3
C $A8FB,3 Draw zone special 4
C $A8FF,3 Draw zone special 5
N $A902 Draw zone special 0
N $A91D Draw zone special 1
N $A922 Draw zone special 2
N $A962 Draw zone special 3
N $A99E Draw zone special 4
N $AA61 Draw zone special 5
C $AA71,2 8. lines
C $AA80,1 next line
B $AA90
B $AAFF
  $AAC9,3 Draw sprite with shift by -2px
  $AAD1,3 Draw sprite with no shift
  $AAD9,3 Draw sprite with shift by 2px
  $AAE1,3 Draw sprite with shift by 4px
b $AAFF Spacecraft sprite data
N $AAFF Number of tiles = 12 + 13 + 17 + 18 + 21 + 21 + 21 + 21 + 19 + 17 + 8 = 188 tiles = 1504 bytes
c $B0DE Start point
N $B0E1 Point of return from block #R$B4D0.
  $B0E4,3 Sound
  $B0EF,3 Prepare shadow screen
  $B0F6,3 Prepare screen with attributes
  $B0FE,3 Prepare screen with attributes
  $B101,3 "HIGHWAY ENCOUNTER" big sign
  $B107,3 Print Text
  $B179,3 Sound
  $B17C,3 JP #R$A367
C $B17F,3 back to start point
  $B189,3 Sound
C $B18C,3 GAME MODE
  $B192,3 Sound
C $B1AA,3 back to start point
  $B1B9,3 Sound
  $B1BC,3 Show Info Screen
  $B1F5,3 Sound
c $B203 Routine: Sound
D $B203 Used by the routine at #R$B0DE.
R $B203 HL ??
  $B204,1 Border 0
  $B209,2 Set/reset EAR and MIC bits
  $B20F,2 Inverse EAR and MIC bits
  $B216,2 Inverse EAR and MIC bits
  $B218,2 repeat
  $B21B,2 repeat
b $B21E Text
N $B21E Referenced from #R$B104
N $B21E Text to print by #R$B890 routine
B $B21E,25,16
B $B237,12,12
B $B243,14,14
B $B251,17,17
B $B262,14,14
B $B270,16,16
B $B280,17,17
B $B291,19,16
B $B2A4,16,16
B $B2B4,36,16
c $B2DA Routine: Prepare shadow screen
D $B2DA Used by the routines at #R$B0DE and #R$B4D0.
C $B2E2,3 7000.
C $B30A,3 4416.
c $B33C Routine
D $B33C Used by the routine at #R$B0DE.
  $B33C,3 "HIGHWAY ENCOUNTER" pixels address
  $B33F,3 title sign buffer
  $B342,3 50 bytes
  $B345,2 copy
  $B347,3 address on shadow screen
  $B34C,3 title sign buffer
c $B39A Routine: Prepare screen
D $B39A Used by the routines at #R$B0DE and #R$B4D0.
N $B3A9 This entry point is used by the routine at #R$B41B.
  $B3AC,3 Screen address
  $B3AF,2 24 char-lines
  $B3B2,2 8 lines
  $B3B4,1 store screen address
  $B3B5,1 store screen address
  $B3B6,3 32 bytes
  $B3B9,2 copy
  $B3BB,1 restore screen address
  $B3BC,1 screen address += 256
  $B3BE,2 loop by lines
  $B3C0,1 restore screen address
  $B3D4,1 char-line counter decrement
  $B3D5,2 loop by char-lines
c $B3D8 Routine
D $B3D8 Used by the routine at #R$B33C.
R $B3D8 BC ??
R $B3D8 HL ??
  $B3D8,3 Mask and sprite = #R$BFB0
  $B3DB,4 -- Pyramid block appears, phase 1
  $B3E2,3 Mask and sprite = #R$B980
  $B3E5,4 -- Pyramid block appears, phase 2
  $B3EC,3 Mask and sprite = #R$BA10
  $B3EF,4 -- Pyramid block appears, phase 3
  $B3F6,3 Mask and sprite = #R$B8F0
  $B3F9,4 -- Pyramid block used on the title screen
c $B41B Routine
D $B41B Used by the routine at #R$B3D8.
D $B41B (#R$B4CD)=sprite address
C $B41D,2 Check keyboard
N $B427 This entry point is used by the routine at #R$B3D8.
  $B42A,3 save HL
  $B431,2 Loop counter = 36
  $B433,1 save loop counter
  $B441,4 Get mask and sprite address
C $B445,1 Draw the sprite
  $B446,3 JP #R$9933 Draw sprite with shift by -2px
  $B44E,3 JP #R$9A70 Draw sprite with no shift
  $B456,3 JP #R$9A26 Draw sprite with shift by 2px
  $B45E,3 JP #R$99D1 Draw sprite with shift by 4px
  $B472,3 restore HL
  $B483,1 restore loop counter
  $B485,2 loop
  $B487,3 Prepare screen
N $B499 Title screen sign "HIGHWAY ENCOUNTER", used by #R$B33C routine
B $B499,50,5 width:40px (5 bytes), height:10px
N $B4CB Variables
W $B4CB,2,2 Temporary place for HL
W $B4CD,2,2 Mask and Sprite address
B $B4CF,1,1 Attribute?
c $B4D0 Show Info Screen
D $B4D0 Used by the routine at #R$B0DE.
  $B4D5,3 Prepare shadow screen
  $B4DB,3 Sprite: Vorton looking forward
  $B4DE,3 JP #R$9A70 Draw sprite with no shift
  $B4E4,3 Sprite: Vorton looking forward
  $B4E7,3 JP #R$9A70 Draw sprite with no shift
  $B4ED,3 Sprite: Vorton looking forward
  $B4F0,3 JP #R$9A70 Draw sprite with no shift
  $B4F6,3 Sprite: Vorton looking forward
  $B4F9,3 JP #R$9A70 Draw sprite with no shift
  $B4FF,3 Sprite: Lasertron
  $B502,3 JP #R$9933 Draw sprite with shift by -2px
  $B508,3 Sprite: Main Vorton looking at player
  $B50B,3 JP #R$99D1 Draw sprite with shift by 4px
  $B50E,3 Prepare screen with attributes
  $B511,3 Print Small Font Signs
  $B517,3 Print Text
  $B520,2 wait for key unpress
  $B528,2 wait for key press
  $B52A,3 Return to menu
c $B52D Print Small Font Signs on the Info Screen
D $B52D Used by the routine at #R$B4D0.
  $B52D,3 Info Screen Small Font Signs
C $B550,1 * 5
C $B551,3 Small Font address
C $B555,3 temp storage
C $B55B,2 copy
C $B560,2 odd or even?
C $B562,2 odd => jump
C $B566,2 Keep lower 4 bits
C $B57F,3 temp storage
C $B58A,1 next line
C $B58D,1 next line
C $B597,2 * 16.
C $B59C,1 next line
C $B5A7,1 next line
C $B5A9,1 next line
C $B5AF,1 next line
b $B5D7 Small Font
B $B5D7,80
B $B627,5 Buffer
t $B62C Info Screen Small Font Signs
B $B62C,3
T $B62F,34
B $B651,3
T $B654,40
B $B67C,3
T $B67F,28
B $B69B,3
T $B69E,29
B $B6BB,3
T $B6BE,27
B $B6D9,3
T $B6DC,32
B $B6FC,3
T $B6FF,27
B $B71A,3
T $B71D,28
B $B739,3
T $B73C,30
B $B75A,3
T $B75D,7
B $B764,3
T $B767,7
B $B76E,3
T $B771,7
B $B778,3
T $B77B,8
B $B783,3
T $B786,17
B $B797,3
T $B79A,7
B $B7A1,3
T $B7A4,17
b $B7B5 Info Screen Text
B $B7B5 Text to print by #R$B890 routine
c $B890 Routine: Print Text
D $B890 Used by the routines at #R$90F2, #R$A367, #R$A694, #R$B0DE and #R$B4D0.
R $B890 HL ??
C $B8D3,1 HL <- HL * 5
C $B8DA,1 write to the screen
C $B8DD,1 next line
C $B8DE,1 write to the screen
C $B8DF,1 next line
C $B8E0,2 counter = 5
C $B8E3,1 write to the screen
C $B8E4,1 next line
C $B8E6,2 repeat
C $B8EA,1 write to the screen
C $B8EC,1 next position on the screen
b $B8F0 Masks and Sprites
B $B8F0,144,18 #HTML[#UDGARRAY6,,,6,,2($B8F0-$B97F-1-48)(sprite0)]
B $B980,144,18 #HTML[#UDGARRAY6,,,6,,2($B980-$BA0F-1-48)(sprite1)]
B $BA10,144,18 #HTML[#UDGARRAY6,,,6,,2($BA10-$BA9F-1-48)(sprite2)]
B $BAA0,144,18 #HTML[#UDGARRAY6,,,6,,2($BAA0-$BB2F-1-48)(sprite3)]
B $BB30,144,18 #HTML[#UDGARRAY6,,,6,,2($BB30-$BBBF-1-48)(sprite4)]
B $BBC0,144,18 #HTML[#UDGARRAY6,,,6,,2($BBC0-$BC4F-1-48)(sprite5)]
B $BC50,144,18 #HTML[#UDGARRAY6,,,6,,2($BC50-$BCDF-1-48)(sprite6)]
B $BCE0,144,18 #HTML[#UDGARRAY6,,,6,,2($BCE0-$BD6F-1-48)(sprite7)]
B $BD70,144,18 #HTML[#UDGARRAY6,,,6,,2($BD70-$BDFF-1-48)(sprite8)]
B $BE00,144,18 #HTML[#UDGARRAY6,,,6,,2($BE00-$BE8F-1-48)(sprite9)]
B $BE90,144,18 #HTML[#UDGARRAY6,,,6,,2($BE90-$BF1F-1-48)(sprite10)]
B $BF20,144,18 #HTML[#UDGARRAY6,,,6,,2($BF20-$BFAF-1-48)(sprite11)]
B $BFB0,144,18 #HTML[#UDGARRAY6,,,6,,2($BFB0-$C03F-1-48)(sprite12)]
B $C040,144,18 #HTML[#UDGARRAY6,,,6,,2($C040-$C0CF-1-48)(sprite13)]
B $C0D0,144,18 #HTML[#UDGARRAY6,,,6,,2($C0D0-$C15F-1-48)(sprite14)]
B $C160,144,18 #HTML[#UDGARRAY6,,,6,,2($C160-$C1EF-1-48)(sprite15)]
B $C1F0,144,18 #HTML[#UDGARRAY6,,,6,,2($C1F0-$C27F-1-48)(sprite16)]
B $C280,144,18 #HTML[#UDGARRAY6,,,6,,2($C280-$C30F-1-48)(sprite17)]
B $C310,144,18 #HTML[#UDGARRAY6,,,6,,2($C310-$C39F-1-48)(sprite18)]
B $C3A0,144,18 #HTML[#UDGARRAY6,,,6,,2($C3A0-$C42F-1-48)(sprite19)]
B $C430,144,18 #HTML[#UDGARRAY6,,,6,,2($C430-$C4BF-1-48)(sprite20)]
B $C4C0,144,18 #HTML[#UDGARRAY6,,,6,,2($C4C0-$C54F-1-48)(sprite21)]
B $C550,144,18 #HTML[#UDGARRAY6,,,6,,2($C550-$C5DF-1-48)(sprite22)]
B $C5E0,144,18 #HTML[#UDGARRAY6,,,6,,2($C5E0-$C66F-1-48)(sprite23)]
B $C670,144,18 #HTML[#UDGARRAY6,,,6,,2($C670-$C6FF-1-48)(sprite24)]
B $C700,144,18 #HTML[#UDGARRAY6,,,6,,2($C700-$C78F-1-48)(sprite25)]
B $C790,144,18 #HTML[#UDGARRAY6,,,6,,2($C790-$C81F-1-48)(sprite26)]
B $C820,144,18 #HTML[#UDGARRAY6,,,6,,2($C820-$C8AF-1-48)(sprite27)]
B $C8B0,144,18 #HTML[#UDGARRAY6,,,6,,2($C8B0-$C93F-1-48)(sprite28)]
B $C940,144,18 #HTML[#UDGARRAY6,,,6,,2($C940-$C9CF-1-48)(sprite29)]
B $C9D0,144,18 #HTML[#UDGARRAY6,,,6,,2($C9D0-$CA5F-1-48)(sprite30)]
B $CA60,144,18 #HTML[#UDGARRAY6,,,6,,2($CA60-$CAEF-1-48)(sprite31)]
B $CAF0,144,18 #HTML[#UDGARRAY6,,,6,,2($CAF0-$CB7F-1-48)(sprite32)]
B $CB80,144,18 #HTML[#UDGARRAY6,,,6,,2($CB80-$CC0F-1-48)(sprite33)]
B $CC10,144,18 #HTML[#UDGARRAY6,,,6,,2($CC10-$CC9F-1-48)(sprite34)]
B $CCA0,144,18 #HTML[#UDGARRAY6,,,6,,2($CCA0-$CD2F-1-48)(sprite35)]
B $CD30,144,18 #HTML[#UDGARRAY6,,,6,,2($CD30-$CDBF-1-48)(sprite36)]
B $CDC0,144,18 #HTML[#UDGARRAY6,,,6,,2($CDC0-$CE4F-1-48)(sprite37)]
B $CE50,144,18 #HTML[#UDGARRAY6,,,6,,2($CE50-$CEDF-1-48)(sprite38)]
B $CEE0,144,18 #HTML[#UDGARRAY6,,,6,,2($CEE0-$CF6F-1-48)(sprite39)]
B $CF70,144,18 #HTML[#UDGARRAY6,,,6,,2($CF70-$CFFF-1-48)(sprite40)]
B $D000,144,18 #HTML[#UDGARRAY6,,,6,,2($D000-$D08F-1-48)(sprite41)]
B $D090,144,18 #HTML[#UDGARRAY6,,,6,,2($D090-$D11F-1-48)(sprite42)]
B $D120,144,18 #HTML[#UDGARRAY6,,,6,,2($D120-$D1AF-1-48)(sprite43)]
B $D1B0,144,18 #HTML[#UDGARRAY6,,,6,,2($D1B0-$D23F-1-48)(sprite44)]
B $D240,144,18 #HTML[#UDGARRAY6,,,6,,2($D240-$D2CF-1-48)(sprite45)]
B $D2D0,144,18 #HTML[#UDGARRAY6,,,6,,2($D2D0-$D35F-1-48)(sprite46)]
B $D360,144,18 #HTML[#UDGARRAY6,,,6,,2($D360-$D3EF-1-48)(sprite47)]
B $D3F0,144,18 #HTML[#UDGARRAY6,,,6,,2($D3F0-$D47F-1-48)(sprite48)]
B $D480,144,18 #HTML[#UDGARRAY6,,,6,,2($D480-$D50F-1-48)(sprite49)]
B $D510,144,18 #HTML[#UDGARRAY6,,,6,,2($D510-$D59F-1-48)(sprite50)]
B $D5A0,144,18 #HTML[#UDGARRAY6,,,6,,2($D5A0-$D62F-1-48)(sprite51)]
B $D630,144,18 #HTML[#UDGARRAY6,,,6,,2($D630-$D6BF-1-48)(sprite52)]
B $D6C0,144,18 #HTML[#UDGARRAY6,,,6,,2($D6C0-$D74F-1-48)(sprite53)]
B $D750,144,18 #HTML[#UDGARRAY6,,,6,,2($D750-$D7DF-1-48)(sprite54)]
B $D7E0,144,18 #HTML[#UDGARRAY6,,,6,,2($D7E0-$D86F-1-48)(sprite55)]
B $D870,144,18 #HTML[#UDGARRAY6,,,6,,2($D870-$D8FF-1-48)(sprite56)]
b $D900 Shadow screen
S $D900,6144 #HTML[#UDGARRAY32,,,32($D900-$F0FF-1-256)(shadowscr)]
S $F100,768 Shadow screen attributes
i $F400