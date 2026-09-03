@ $5B00 start
@ $5B00 org
b $5B00 Player and game variables
B $5B04,2 Player X (IX+0) / Y (IX+1) sub-position within the room
N $5B06 Purpose unconfirmed. Reset to 0 at init (#R$8F47); set to $7F in the game-over sequence (#R$9372); saved/restored across respawn by #R$9090.
B $5B06,2 Purpose unconfirmed (see note)
N $5B24 Previous frame's copy of the draw cache at $5B44, taken by the LDIR at the end of #R$9B22. #R$9BEB erases from it by being called with IX=$5AE4, which is not a real object array - it is just $5B24-$40, chosen so the routine's (IX+$40)/(IX+$41) reads land here. Nothing ever writes the $5AE4-$5AF7 bytes those offsets nominally belong to.
B $5B24,32 previous frame's draw cache (copy of $5B44)
N $5B44 Current frame's draw cache for the 5 $5B04 object slots, 4 bytes per slot at slot_base+$40: screen address (+$40/+$41) and plot-routine pointer (+$42/+$43), written by #R$9B22 from #R$9CEE and read back by #R$9BEB and #R$9D3C. Copied down to $5B24 at the end of each frame.
B $5B44,32 current frame's draw cache (screen address + plotter, 4 bytes per slot)
B $5B72,2 Screen/buffer base pointer, set to $F000 by #R$8F47
N $5B7C Inventory: sequential item-pickup log, one byte per collected item (index into the $8400 sprite table, i.e. (addr-$8400)/72). $FF = slot not yet used. The last non-$FF entry is the item currently carried. Cleared to $FF by #R$8F47.
B $5B7C,27 item pickup order (index into $8400 sprite table), $FF=empty
B $5B97,1 Lives counter (see the Infinite Lives POKE at #R$A9EE)
B $5B9B,1 Flag: $FF at init, $FE set on respawn (#R$9090)
N $5B9E "Last room #R$AF81 ran for" - compared against the live room ($5C01) each frame; when they differ, the room-entry trigger fires once. Also restored by the respawn handler (#R$9090).
B $5B9E,2 Room #R$AF81 last ran for (see note)
B $5BA0,1 Frame-active flag, set to 1 each iteration of the main loop (#R$9018)
b $5BFB Game state variables (countdown, room, frame counter, flags)
N $5BFB Asteroid-collision countdown timer shown on the telescope screen: 3 bytes, plain binary (not BCD).
B $5BFB,3 Days, Hours, Minutes to collision
B $5BFF,1 Game-over flag, checked each frame by #R$9018
B $5C01,1 Current room number: level*12 + col (#R$AEEF/#R$AEFD)
B $5C02,1 Frame counter, incremented each iteration of the main loop (#R$9018)
B $5C05,1 Zeroed on respawn (#R$9090); purpose unconfirmed
N $5C06 Hero status/trigger code - not the hazard timer (that's $5C07). Every change funnels through #R$AE84/#R$AE85, which also zeroes $5C07 as it stores the new code; 0 is the idle/reset value, and the ~18 other codes each mark one specific event or scripted zone the hero is in (#R$A6CC dispatches per-frame handling on it). Restored on respawn from $5C2B (#R$9090). See Actors.md for the full code table with its setting call sites - the meanings there are inferred from call-site context, not confirmed against on-screen animation.
B $5C06,1 Hero status/trigger code (see note) - NOT the hazard timer
B $5C07,1 Per-room hazard counter, incremented by #R$A9EE; restored on respawn from $5C2C
B $5C2A,10 Respawn staging: pending flag ($5C2A), then saved $5C06/$5C07/$5C01/$5B04/$5B06/$5B9E, restored by #R$9090
t $5DBE
b $5DD6
t $5E13
b $5E1C
c $5F5F Tail jump to #R$9491
C $5F5F,3 => Interrupt handler
b $5F62
c $5FE6 Unreferenced: OUT (C),A; RET (no known caller)
c $5FE9 Unreferenced: port write pair, self-modifies ($5FE5) (no known caller)
N $5FE9 Dead code with no caller anywhere in the disassembly - self-modifies a port value and writes it twice. Probably a leftover from the loader.
b $5FFB
b $8400 Sprites for items/objects
N $8400 Sprite 24x24 Unicycle
B $8400,72,8 #HTML[#UDGARRAY3($8400-$8447-24-8){0,0,48,48}(sprite-8400)]
N $8448 Sprite 24x24 Flashgun
B $8448,72,8 #HTML[#UDGARRAY3($8448-$848F-24-8){0,0,48,48}(sprite-8448)]
N $8490 Sprite 24x24 Cricket Ball
B $8490,72,8 #HTML[#UDGARRAY3($8490-$84D7-24-8){0,0,48,48}(sprite-8490)]
N $84D8 Sprite 24x24 Spurs
B $84D8,72,8 #HTML[#UDGARRAY3($84D8-$851F-24-8){0,0,48,48}(sprite-84D8)]
N $8520 Sprite 24x24 Beer Barrel
B $8520,72,8 #HTML[#UDGARRAY3($8520-$8567-24-8){0,0,48,48}(sprite-8520)]
N $8568 Sprite 24x24 Umbrella
B $8568,72,8 #HTML[#UDGARRAY3($8568-$85AF-24-8){0,0,48,48}(sprite-8568)]
N $85B0 Sprite 24x24 Bellows
B $85B0,72,8 #HTML[#UDGARRAY3($85B0-$85F7-24-8){0,0,48,48}(sprite-85B0)]
N $85F8 Sprite 24x24 Party Manifesto
B $85F8,72,8 #HTML[#UDGARRAY3($85F8-$863F-24-8){0,0,48,48}(sprite-85F8)]
N $8640 Sprite 24x24 Cannon
B $8640,72,8 #HTML[#UDGARRAY3($8640-$8687-24-8){0,0,48,48}(sprite-8640)]
N $8688 Sprite 24x24 Barrel Medium
B $8688,72,8 #HTML[#UDGARRAY3($8688-$86CF-24-8){0,0,48,48}(sprite-8688)]
N $86D0 Sprite 24x24 Vacuum Cleaner
B $86D0,72,8 #HTML[#UDGARRAY3($86D0-$8717-24-8){0,0,48,48}(sprite-86D0)]
N $8718 Sprite 24x24 ACME Expanding Bridge
B $8718,72,8 #HTML[#UDGARRAY3($8718-$875F-24-8){0,0,48,48}(sprite-8718)]
N $8760 Sprite 24x24 Flute
B $8760,72,8 #HTML[#UDGARRAY3($8760-$87A7-24-8){0,0,48,48}(sprite-8760)]
N $87A8 Sprite 24x24 Silver Lining
B $87A8,72,8 #HTML[#UDGARRAY3($87A8-$87EF-24-8){0,0,48,48}(sprite-87A8)]
N $87F0 Sprite 24x24 Spring
B $87F0,72,8 #HTML[#UDGARRAY3($87F0-$8837-24-8){0,0,48,48}(sprite-87F0)]
N $8838 Sprite 24x24 Formula
B $8838,72,8 #HTML[#UDGARRAY3($8838-$887F-24-8){0,0,48,48}(sprite-8838)]
N $8880 Sprite 24x24 Switch
B $8880,72,8 #HTML[#UDGARRAY3($8880-$88C7-24-8){0,0,48,48}(sprite-8880)]
N $88C8 Sprite 24x24 Button
B $88C8,72,8 #HTML[#UDGARRAY3($88C8-$890F-24-8){0,0,48,48}(sprite-88C8)]
N $8910 Sprite 24x24 Battery
B $8910,72,8 #HTML[#UDGARRAY3($8910-$8957-24-8){0,0,48,48}(sprite-8910)]
N $8958 Sprite 24x24 Coat Hanger
B $8958,72,8 #HTML[#UDGARRAY3($8958-$899F-24-8){0,0,48,48}(sprite-8958)]
N $89A0 Sprite 24x24 Trampoline
B $89A0,72,8 #HTML[#UDGARRAY3($89A0-$89E7-24-8){0,0,48,48}(sprite-89A0)]
N $89E8 Sprite 24x24 Atomic Pile
B $89E8,72,8 #HTML[#UDGARRAY3($89E8-$8A2F-24-8){0,0,48,48}(sprite-89E8)]
N $8A30 Sprite 24x24 Anti Radiation Pills
B $8A30,72,8 #HTML[#UDGARRAY3($8A30-$8A77-24-8){0,0,48,48}(sprite-8A30)]
N $8A78 Sprite 24x24 Cup of tea
B $8A78,72,8 #HTML[#UDGARRAY3($8A78-$8ABF-24-8){0,0,48,48}(sprite-8A78)]
N $8AC0 Sprite 24x24 Energy Crystal
B $8AC0,72,8 #HTML[#UDGARRAY3($8AC0-$8B07-24-8){0,0,48,48}(sprite-8AC0)]
N $8B08 Sprite 24x24 Busket
B $8B08,72,8 #HTML[#UDGARRAY3($8B08-$8B4F-24-8){0,0,48,48}(sprite-8B08)]
N $8B50 Sprite 24x24 Balloon
B $8B50,72,8 #HTML[#UDGARRAY3($8B50-$8B97-24-8){0,0,48,48}(sprite-8B50)]
N $8B98 Sprite 24x24 Barrel Big
B $8B98,72,8 #HTML[#UDGARRAY3($8B98-$8BDF-24-8){0,0,48,48}(sprite-8B98)]
N $8BE0 Sprite 24x24 Barrel Small
B $8BE0,72,8 #HTML[#UDGARRAY3($8BE0-$8C27-24-8){0,0,48,48}(sprite-8BE0)]
N $8C28 Sprite 24x24 Silver Cross
B $8C28,72,8 #HTML[#UDGARRAY3($8C28-$8C6F-24-8){0,0,48,48}(sprite-8C28)]
N $8C70 Sprite 24x24 Busket
B $8C70,72,8 #HTML[#UDGARRAY3($8C70-$8CB7-24-8){0,0,48,48}(sprite-8C70)]
N $8CB8 Sprite 24x24 Lift
B $8CB8,72,8 #HTML[#UDGARRAY3($8CB8-$8CFF-24-8){0,0,48,48}(sprite-8CB8)]
c $8F47 Show main menu, then initialize game state
N $8F47 After #R$93AF returns (device chosen, "0" pressed): pages in a helper 128K bank to run a setup routine at $C000 if needed, clears game variable tables, resets item/collision flags, blits the background graphic ($E000 -> $5000, one screen third + extra strip), sets up pointers/counters, clears the object-state table at $5BFA, sets the level data pointer ($5C25=$6070, $5C27=$0F, purpose unconfirmed - not total room count, game has 66+ rooms), then redraws the screen before falling through into the main game loop at $9018 (per-frame updates, respawn-in-room handling via $9090 after a life is lost, and game-over exit back to this same routine via $906D/$908D).
C $8F47,3 Main menu
C $8F4A,3 A=128K paging flag ($5FFE)
C $8F4D,3 not 128K? skip
C $8F50,5 BC=$7FFD, A=bank $11
C $8F56,5 record and page it in
C $8F5E,3 init music player
C $8F62,5 restore bank $10
C $8F67,2 page back
C $8F69,3 HL=$5B04
C $8F72,2 clear $5B04-$5B66 (99 bytes)
C $8F76,3 HL=$5B7C
C $8F7F,2 fill inventory with $FF (26 bytes)
C $8F83,3 Clear active flag (bit7) across all $B99D creature-table entries
C $8F86,5 re-arm the boss entry ($B9D9)
C $8F8B,6 HL=$E000, DE=$5000
C $8F94,2 restore one screen third
C $8F96,6 DE=$5A00, BC=$100
C $8F9C,2 restore its attributes
C $8F9E,6 buffer base pointer ($5B72)=$F000
C $8FA4,2 A=$FF
C $8FA6,3 reset $5C3C
C $8FA9,6 reset $A6FD/$A700
C $8FAF,6 reset $5B98/$5B9B
C $8FB5,5 $A6F5=7 (per-room tuning, room $10 uses 6)
C $8FBA,4 reset counter $5B06
C $8FBE,6 HL=$5BFA, DE=$5BFB
C $8FC7,3 clear object-state table (147 bytes)
C $8FCC,3 Save all registers
C $8FCF,6 level data pointer ($5C25) = $6070
C $8FD5,5 $5C27=$0F (scripted-room gate)
C $8FE0,5 attr=$14
C $8FE5,3 Set up the current room
C $8FE8,3 Init $5BD6 object slots from $5C23
C $8FED,3 set Lives counter
C $8FF0,3 Draw lives-count icons ($5B97) into $5BD6 slots
C $9012,3 Snapshot current room/position into respawn staging
C $9015,3 Populate the $5BD6 object-slot table
C $9018,5 main game loop entry: mark frame active ($5BA0=1)
C $901D,4 IX=player state ($5B04)
C $9021,6 room ($5C01) vs last ($5B9E)
C $9028,3 changed? room-entry trigger #R$AF81
C $902B,3 Main per-frame player update
C $902E,4 life lost ($5C2A)?
C $9032,2 yes: respawn via #R$9090
C $9034,3 Per-frame item dispatcher
C $9037,3 Draw sparkle/flicker effect list at $9AD5
C $903A,3 Countdown timer
C $903D,3 Dispatch per-creature-type init (jump table $BECA) for the 3 hazard slots
C $9040,3 Per-frame update for 5 party slots
C $9043,4 game-over flag ($5BFF) set?
C $9047,2 yes: exit to #R$906D
C $9049,4 frame counter ($5C02)++
C $9050,4 read key row $FBFE
C $9054,5 held? loop
C $9059,5 read key row $FEFE
C $905E,4 pressed? exit
C $9062,4 read key row $FDFE
C $9066,4 wait for release
C $906D,3 New high-score check
C $9070,6 HL=$5000, DE=$E000
C $9079,2 save screen third
C $907B,6 HL=$5A00, DE=$E800
C $9084,2 save its attributes
C $9086,4 alternate tileset loaded?
C $908A,3 yes: restore the base tileset
N $9090 Respawn handler, entered from #R$9018 when the hazard timer (#R$A9EE) has just cost a life. Restores the player/room state saved in $5C2B-$5C32 (captured on room entry, likely by #R$AF81) back into the live variables, so the player restarts in the same room rather than switching rooms. Only writer of $5C2A other than #R$A9EE is this routine, clearing it as the first step.
C $9090,4 respawn after life lost: clear pending flag ($5C2A)
C $9094,3 clear $5C05
C $9097,6 restore status ($5C06)
C $909D,6 restore hazard counter ($5C07)
C $90A3,6 restore player position ($5B04)
C $90AF,6 restore room ($5C01)
C $90B5,6 restore last-room ($5B9E)
C $90BB,3 Set up the current room
C $90BE,5 $5B9B=$FE (respawn marker)
C $90C3,3 => main game loop
C $908D,3 => Show main menu, then initialize game state
c $90C6 Draw character bitmap
N $90C6 Font table at $3C00, 8 bytes/char. DE is used as scratch and restored, unaffected.
R $90C6 A char code
R $90C6 HL screen address
R $90C6 O:HL HL+1 (next column)
C $90CA,1 HL = char code
C $90CD,1 * 8 (three ADD HL,HL)
C $90D0,4 add the font base $3C00
C $90D6,2 copy one row
C $90D8,2 advance both
C $90DA,2 loop 8 rows
C $90DF,1 advance to next column
b $90E1
c $9140 Classify object type ((IX+2)) into a size/category flag (C)
N $9140 Checks whether two objects (the hero and a creature/item, typically) are close enough to interact - the shared proximity test behind pickups, hits, and hazard triggers throughout the game.
R $9140 IX first object (position at +0/+1, type at +2)
R $9140 IY second object (position at +0/+1)
R $9140 O:Cf set if both X and Y are within threshold
C $9141,3 A = object type ((IX+2))
C $9144,2 C=$10 (default threshold)
C $9146,4 type below $5C?
C $914A,4 or $60 and up?
C $914E,2 else threshold = $08
C $9150,6 X delta between the two objects
C $9158,2 make it positive
C $915A,3 X within threshold? else skip Y check
C $915D,6 Y delta between the two objects
C $9165,2 make it positive
C $9167,1 within threshold? (result in carry)
b $916A
c $917C Init $5B0A/$5B0E/$5B12/$5B16 to $007F
b $918C Alternate-tileset flag
N $918C Selects which of the two tile sets is currently swapped into place: 0 = base set, $FF = alternate. Toggled only by #R$918D, which is called from #R$9880 on every room entry to match the room against the list at $9AC6 (and from #R$8F47/#R$9090 to force it back to 0). Read at 16 sites to pick the matching variant of the solid/special tile lists, the sparkle effect lists and the draw routines - the most-referenced flag in the disassembly. It is not a music flag; the music player is the separate paged-bank routine reached via #R$9491.
B $918C,1 0=base tileset, $FF=alternate tileset
c $918D Swap the alternate tileset in/out, toggling ($918C)
N $918D Exchanges the upper half of the tile bitmap table ($F400, 1K = 128 tiles of 8 bytes) with the spare copy held at $FA00, and the matching 128 per-tile attribute bytes at $C580 with those at $DF80, then flips the ($918C) flag. Swapping rather than copying means the set that was in use is preserved for the next call, so rooms can move back and forth between the two sets at no cost.
C $918D,4 save the current flag
C $9191,6 HL/DE = region 1 ($FA00/$F400)
C $9197,3 BC=$400 bytes
C $919B,2 read both bytes
C $919D,1 write the first back
C $91A1,1 count one byte off
C $91A2,2 advance both pointers
C $91A4,2 count reached zero?
C $91A8,3 HL=$C580
C $91AB,2 B=$80 bytes
C $91AD,3 DE=$DF80
C $91BA,5 flip and store the tileset flag
c $91C0 Draw sparkle/flicker effect list at $9AD5 (base-tileset variant)
N $91C0 Draws the animated background sparkle (water drips, glints) used with the base tileset - #R$92BD is the alternate-tileset twin, working from a different list with a different draw primitive. Walks a 2-entry list of variable-length command lists at $9AD5, each command naming a screen position; for each it picks one of 4 pre-baked 8-byte tile patterns by frame counter, draws it, then XORs a byte at that spot with noise taken from the R register so the sparkle flickers.
C $91C0,2 B=2 outer slots
C $91C2,3 HL=$9AD5 (pointer list)
C $91C8,4 alternate tileset? use #R$9208 variant
C $91CD,1 DE = next list entry
C $91D2,2 entry zero? end of list
C $91D6,1 EXX
C $91DA,2 frame AND 3
C $91E2,3 HL = $933D + index*8
C $91E6,6 DE=$F5A8, BC=8
C $91EC,2 copy 8-byte pattern
C $91F1,2 A=$B5 (draw byte)
C $91F7,4 advance to secondary buffer (+$6000)
C $91FB,2 A = R (pseudo-random)
C $9201,2 XOR into screen byte
C $9205,3 loop 2 slots
C $9208,4 IY=frame counter ($5C02)
C $920C,1 DE = coord pair
C $9210,2 coords zero? end
C $9215,1 BC = second coord pair
C $9219,2 second pair zero?
C $921F,3 D = attribute row from coord
C $9222,1 <<3 (three RLCA)
C $9225,4 OR $06/$40 (attribute base)
C $922A,3 same for B
C $9236,1 restore HL (coord Y)
C $923A,2 BC = saved coord
C $9240,4 player X ($5B04) vs coord
C $9246,3 X+12 past right edge?
C $924B,5 player Y +6
C $9255,4 Y delta < $0C?
C $9259,5 status < 4?
C $9266,3 A = R rotated
C $9269,4 XOR frame counter, write attribute
C $926D,1 next attribute row
C $9276,2 advance DE
C $9279,3 DE reached BC?
C $927E,4 loop or next list entry
C $9285,3 frame AND 3
C $9288,4 bit2 set? else invert
C $928E,3 HL = index
C $9291,1 *= 16 (four ADD HL,HL)
C $9295,4 HL = $92FD + index*16
C $9299,3 DE=$F460 (dest)
C $929C,3 BC=$10 (count)
C $929F,2 LDIR (copy 16 bytes)
C $92A1,3 DE=$9AE5 (coords list, alternate-tileset variant)
C $92A4,1 HL = next coord pair
C $92AA,2 zero? RET
C $92AE,2 A=$8C (draw byte)
C $92B3,2 HL++ (next cell)
C $92B5,2 A=$8D (draw byte)
C $92BB,2 loop to next coord
C $91D7,3 get Frame counter
C $91F3,3 Write A to (HL)+$6000 (secondary buffer), then #R$9A62 dual-write loop
C $9237,3 Convert HL to attribute address
C $923D,3 Convert HL to attribute address
C $9282,3 get Frame counter
C $92B0,3 Write A to (HL), DE=HL, fall into #R$9A62 dual-write loop
C $92B7,3 Write A to (HL), DE=HL, fall into #R$9A62 dual-write loop
c $92BD Draw sparkle/effect list at $9AE5, alternate-tileset variant, via #R$92D6
N $92BD Draws the sparkle/glint effect list used while the alternate tileset is loaded - the twin of #R$91C0, which handles the base-tileset case with a different list and draw routine.
C $92CD,3 Convert HL to screen bitmap address
C $92D1,3 Convert HL to screen bitmap address
c $92D6 Convert HL to screen bitmap address
N $92D6 Copies one 8-pixel-tall strip of the menu border graphic into place - part of the frame-drawing sequence run when the main menu screen is built.
R $92D6 HL source address (in $E0xx buffer)
R $92D6 O:HL/DE restored (preserved via stack)
C $92D6,2 save DE/HL
C $92D8,3 H AND $03
C $92DB,1 <<3 (three RLCA)
C $92DE,3 OR $40 (destination third)
C $92E1,3 H = same value OR $E0 (source, $E0xx buffer)
C $92E4,3 E=L, B=8 rows
C $92E7,2 copy one byte
C $92E9,2 both to the next pixel row
C $92EB,2 loop 8 rows
C $92ED,2 restore DE/HL
c $92F0 Convert HL to attribute address (variant)
N $92F0 Turns a screen pixel address into the matching color-attribute address - a different bit-twiddling method from #R$A293, used by the sparkle-effect drawing code.
R $92F0 HL screen address
R $92F0 O:HL attribute address (same third)
C $92F0,3 H AND $03
C $92F4,1 <<3 (three ADD HL,HL)
C $92F7,1 A = H
C $92F8,1 <<3 (three ADD A,A)
C $92FB,1 back into H
b $92FD Sparkle/effect tile patterns (used by #R$91C0)
c $935D Countdown timer ($5BFD/$5BFC/$5BFB); expiry warps to room $28, triggers hazard
N $935D Ticks down the asteroid-collision countdown shown on the telescope screen; once it hits zero, forces the hero into room $28 and starts the game-over sequence.
C $935D,4 HL=$5BFD, minutes--
C $9361,3 underflowed?
C $9364,2 minutes=$3B
C $9366,2 step to hours, hours--
C $9368,3 underflowed?
C $936B,2 hours=$17
C $936D,2 step to days, days--
C $936F,3 underflowed?
C $9372,5 $5B06=$7F (game-over flag)
C $9377,2 A=$28 (end room)
C $9379,3 set Current room number
C $937C,3 Set up the current room
C $937F,5 respawn room = $28
C $9384,4 clear $5C2C
C $9388,5 respawn status = $1D
C $938D,3 Set hero status ($5C06), clear hazard timer ($5C07)
c $9390 Pseudo-random byte: R register mixed with $93AD/$8F47 stride table
N $9390 Produces a pseudo-random byte by mixing the CPU refresh register with a rolling pointer, so creature timers and effects do not all fall into step.
C $9390,2 save HL/DE
C $9392,3 HL = rolling pointer ($93AD)
C $9395,3 DE = low byte shifted up
C $9398,1 mix them
C $9399,4 advance by $29
C $939D,3 store the new pointer
C $93A0,2 keep only the low byte
C $93A2,4 index into the stride table ($8F47)
C $93A6,2 A = refresh register
C $93A8,2 fold in H and L
b $93AD Pseudo-random generator state (#R$9390)
c $93AF Main menu: draw title screen, print input-device options, read selection
N $93AF #HTML[<img src="images/scr/Menu.png" />]
N $93AF Clears screen+attrs, blits the green border-frame graphic: top/bottom pieces from $E000/$E0E0 (#R$94B0), then left/right pieces (#R$94C2), draws a colored frame (per-cell attr $46 write), then prints the device options ("1 : KEYBOARD" via #R$94EF, "2 : KEMPSTON" via #R$94F9). Main loop draws a highlight bar over the option matching ($94AF) and polls keys 1/2/3 (port $F7FE) to change it.
C $93D0,3 Fill C bytes with A
C $93DB,3 Fill C bytes with A
C $93DE,6 HL=$E000, DE=$4000
C $93E4,3 Blit 32x8 byte block (menu border-frame graphic)
C $93E7,6 HL=$E0E0, DE=$50E0 (bottom piece)
C $93ED,3 Blit 32x8 byte block (menu border-frame graphic)
C $93F3,2 blit border frame, left/right pieces x11
C $93F8,3 Draw left/right piece at HL/DE, then advance to next screen third
C $93FE,3 Draw left/right piece at HL/DE, then advance to next screen third
C $941B,3 Convert screen address to attribute address
C $942D,3 Draw main-menu UI icons/highlight bar into $5BD6 slots
C $9430,3 Print string "1
C $943D,3 Print string from DE at screen HL, attr in AF'
C $9444,3 BC = 5 rows x $0E cols
C $9447,4 HL=$5908 (box origin)
C $944B,2 A=$43 (frame attribute)
C $944D,3 Fill C bytes with A (used for the menu box frame)
C $9450,3 A = selected option ($94AF)
C $9454,3 HL = option index
C $9457,1 index *= 64 (six ADD HL,HL)
C $945D,1 HL = row of the selected option
C $945E,2 DE = HL
C $9460,1 point at the next byte
C $9461,3 BC=$0D (bar width)
C $9464,2 A=$47 (highlight attribute)
C $9466,2 paint the bar
C $9468,1 wait for next frame
C $9469,5 read key row $F7FE
C $9470,4 nothing pressed? skip
C $9474,2 E=0
C $9476,4 key 1?
C $947B,4 key 2? (E=1)
C $9480,4 key 3? (E=2)
C $9484,4 store selected device
C $9488,4 read key row $EFFE
C $948C,2 mask key 0
C $948E,1 key 0? start the game
C $948F,2 else keep polling
c $9491 Interrupt handler: page in 128K bank $16, call music player #R$C000, restore, EI
N $9491 The interrupt handler. Pages in the 128K RAM bank holding the music player, calls it, then restores the previous paging and re-enables interrupts.
C $9492,4 A = 128K flag ($5FFE)
C $9496,2 not 128K? skip paging
C $9499,5 BC=$7FFD, A=bank $16
C $949E,2 page it in
C $94A0,3 CALL music player #R$C000
C $94A3,6 A = saved bank ($5FE5)
C $94A9,2 page it back
C $94AB,2 restore BC/AF
C $94AD,1 re-enable interrupts
b $94AF Input device selector
B $94AF,1 Input device: 0=keyboard, 1=Kempston, 2=Sinclair 2
c $94B0 Blit 32x8 byte block (menu border-frame graphic)
C $94B0,2 B=8 rows
C $94B2,1 save BC/HL/DE
C $94B5,3 BC=$20 bytes
C $94B8,2 copy one row
C $94BA,2 restore DE/HL
C $94BC,2 both to the next pixel row
C $94BE,1 restore BC
C $94BF,2 loop 8 rows
N $94B0 Copies 32 bytes per row for 8 rows, advancing both HL and DE down one pixel row each time (plain INC H/INC D, no char-row wrap fixup - source and dest must stay within one screen third).
R $94B0 HL source address
R $94B0 DE destination address
c $94C2 Draw left/right piece at HL/DE, then advance to next screen third
N $94C2 Draws one row of the menu's left and right border pieces and steps both positions down to the next row - called repeatedly to build the whole frame.
R $94C2 HL left-piece screen address
R $94C2 DE right-piece screen address
R $94C2 O:HL/DE advanced to next screen third
C $94C4,3 Blit 1x8 byte column (menu border piece)
C $94C9,3 L to the row-end column
C $94CD,3 same for E
C $94D3,3 Blit 1x8 byte column (menu border piece)
C $94D8,3 E to the next third column
C $94DB,3 carry set if it wrapped
C $94DF,3 wrapped: D += 8 (next third row)
c $94E4 Blit 1x8 byte column (menu border piece)
N $94E4 Copies one 8-pixel-tall column of graphic data - the smallest building block of the menu border-drawing code.
R $94E4 HL source address
R $94E4 DE destination address
R $94E4 O:HL/DE +8 (next third down)
c $94EF Print string "1 : KEYBOARD"
C $94EF,3 string: "1 : KEYBOARD" (#R$9540)
C $94F2,3 position: row 1, col 8
c $94F9 Print string from DE at screen HL, attr in AF'
N $94F9 A generic text printer: draws a null-terminated string at a screen position in a given color, character by character.
R $94F9 DE string address (null-terminated, $0D=newline)
R $94F9 HL screen address
R $94F9 AF' attribute byte
C $94FC,1 read a character
C $94FE,2 zero terminator? done
C $9500,4 $0D: newline
C $9506,3 Draw character bitmap
C $950B,3 Convert screen address to attribute address
C $950E,2 write attribute
C $9516,3 newline: reload HL
C $951A,3 next char row
C $951D,2 => Print string from DE at screen HL, attr in AF'
C $9523,2 => Print string from DE at screen HL, attr in AF'
b $9525
c $9526 Fill C bytes with A (used for the menu box frame)
N $9526 A generic rectangle-fill helper: paints a solid block of one byte value, used to draw the menu's box frame.
R $9526 A fill byte
R $9526 HL start address
R $9526 B row count
R $9526 C bytes per row
C $9526,2 save BC/HL
C $9528,2 write A, advance
C $952A,3 loop C bytes
C $952D,1 restore the row start
C $952E,4 advance a row ($20 bytes)
C $9532,1 restore BC
C $9533,2 loop B rows
c $9536 Convert screen address to attribute address
N $9536 Standard ZX idiom: H's top bits (Y7Y6, the screen third) rotated into place and ORed with $58 to get the attribute row; L is already the right column so it's left as-is.
R $9536 HL screen address
R $9536 O:HL attribute address
t $9540 Main menu strings
B $954C,2,2
T $954E
B $955A,2,2
T $955C
B $9568,2,2
T $956A
B $9578,1,1
T $9579
B $9595,2,2
T $9597
B $95B2,1,1
T $95B3
B $95CF,1,1
T $95D0
B $95E6,1,1
T $95E7
b $95FC
c $9855 Set up the current room (called right after every room-number change)
N $9855 Room-entry entry point, reached after every write of a new room number. Applies two per-room special cases (one forced state value, one table-driven call), then falls through into #R$9880 to do the actual room setup.
R $9855 A room number
C $9856,3 Decode room's creatures/hazards from the room data table
C $9874,3 Snapshot current room/position into respawn staging
C $987A,3 Per-room setup
c $9880 Per-room setup (tileset select, hazard tuning, lift init)
R $9880 A room number
C $9881,3 HL=alternate-tileset room list ($9AC6)
C $9890,3 not listed: make sure the base tileset is loaded
C $9899,3 listed: make sure the alternate tileset is loaded
C $98A4,3 Build room background from its back-tile map
C $98BC,2 C=$DD for the alternate tileset
C $98C2,3 Find all tile-map ($F800) positions matching A, store coords list at DE
C $98D0,3 Find all tile-map ($F800) positions matching A, store coords list at DE
C $98E7,5 room $10: $A6F5=6
C $98FC,3 lift table entries point to $9998
C $9901,3 lift table stride = 31 bytes
C $9907,4 clear $5C24
N $9880 Per-room setup run on every room entry: looks the room up in the list at $9AC6 and swaps the tile set (#R$918D) so the flag matches, builds the tile background (#R$9914), initializes the sparkle/animation command list for whichever tile set is now loaded, and resets the per-room counters. A couple of rooms get extra treatment - one adjusts a tuning value, another populates a 12-entry table that looks like moving-lift setup.
C $990B,3 Init $5B0A/$5B0E/$5B12/$5B16 to $007F
C $990E,3 Blit the room's tile-index map ($F800) onto the real screen
C $9911,3 => Reset object slots ($5C0E), scan $B99D table for current room
c $9914 Build room background from its back-tile map
R $9914 A room number
C $9914,3 HL=A (room number, zero-extended)
N $9914 Builds the room's tile-index map: reads the room's 32-byte list of back-tile indices at $D600, expands each back-tile through its 4x4 definition at $C600, and writes the resulting 32x16 map of 8x8 tile indices to $F800. Back-tile index $10 is special-cased. The bitmaps those indices resolve to live at ($5B72)=$F000, 8 bytes per tile, with the upper half swappable between two tile sets by #R$918D.
C $9917,1 room *= 32 (five ADD HL,HL)
C $991C,4 HL = back-tile index list ($D600 + room*32)
C $9920,6 B=4 rows, IX=room tile-index map ($F800)
C $9926,1 save row counter
C $9927,2 save row base (IX)
C $9929,2 B=8 columns
C $992C,2 C = back-tile index
C $992F,3 HL = back-tile index
C $9932,1 index *= 16 (four ADD HL,HL)
C $9936,4 HL = back-tile definition ($C600 + back_tile_index*16)
C $993A,3 back-tile $10?
C $993D,3 yes: special case #R$99F0
C $9940,4 copy first sub-tile index
C $9945,1 15 more, unrolled into IX offsets $01-$63
C $998F,2 restore def pointer, advance
C $9991,5 IX += 4 (next column)
C $9996,3 loop 8 columns
C $9999,2 restore row base
C $999B,5 IX += $80 (next row)
C $99A0,3 loop 4 rows
C $99A3,1 RET
c $99A4 Blit the room's tile-index map ($F800) onto the real screen
C $99A4,3 HL=0 (tile counter 0-511)
C $99A7,3 DE=$F800 (tile map)
C $99AA,2 save HL/DE (for attr calc + tile index)
N $99A4 HL counts 0-511 (32x16 tile positions, matching the $F800 map size - loop exit checks BIT 1,H, i.e. stops once H=2). For each tile: reads the tile index from ($F800+HL), looks it up in a 256-byte table at $DF00 to get an attribute byte, writes that to the attribute file ($5800 + ...); then looks up an 8-byte bitmap at ($5B72)+tile_index*8 and copies it to the real screen bitmap address, one byte per pixel row (INC D each line - standard screen-third stride).
C $99AD,3 HL = attribute address ($5800 + ...)
C $99B0,1 A = tile index
C $99B3,3 HL = index
C $99B6,4 HL = $DF00 + index
C $99BA,1 A = attribute byte
C $99BC,1 store attribute byte
C $99BD,3 H AND $03
C $99C0,1 <<3 (three RLCA)
C $99C3,3 OR $40 (screen base)
C $99C6,1 restore A (tile index)
C $99C8,3 HL = index
C $99CB,1 index *= 8 (three ADD HL,HL)
C $99CE,4 DE = bitmap base ($5B72)
C $99D2,2 HL += DE (bitmap source)
C $99D4,2 C = screen low byte
C $99D6,3 B = screen high OR $E0 (secondary buffer)
C $99DA,2 A=8 (rows)
C $99DD,1 read the bitmap byte
C $99DE,2 write to both buffers
C $99E0,2 advance both to next pixel row
C $99E4,3 loop 8 rows
C $99E7,2 next tile-map byte
C $99E9,2 next screen cell
C $99EB,4 all 512 done? (H=2)
c $99F0 Set redraw pointers ($5BA2=IX+$6020, $5BA4=HL+4) for #R$9A2F
N $99F0 Works out the two screen pointers the dual-buffer redraw needs, one for each buffer, from the object and screen addresses handed in.
R $99F0 HL screen address for the second pointer
R $99F0 IX object address for the first pointer
C $99F0,1 save HL/IX/DE
C $99F4,3 DE=$6020
C $99F7,6 IX += DE, store to $5BA2
C $99FD,3 DE=4
C $9A00,4 HL += DE, store to $5BA4
C $9A04,1 restore DE/IX/HL
c $9A09 Gated call to #R$9A2F, room/hazard-timer dependent
N $9A09 Redraws a room's dual-buffered animation only when the room and hazard timer are in the right state - avoids redrawing it every frame unnecessarily.
C $9A09,4 Proximity check
C $9A0D,3 A = status ($5C06)
C $9A10,4 status 2? use that path
C $9A14,3 else room ($5C06) must be 3
C $9A17,3 A = hazard timer ($5C07)
C $9A1A,3 below 8? RET
C $9A1D,2 else draw
C $9A1F,3 A = hazard timer ($5C07)
C $9A22,3 8 or more? RET
C $9A25,1 save BC/HL/DE
C $9A28,3 Dual-buffer redraw: 2x4 grid, each cell via #R$9A62
c $9A2F Dual-buffer redraw: 2x4 grid, each cell via #R$9A62
N $9A2F Redraws a 2x4 block of cells into both screen buffers, used to refresh a small animated area without redrawing the whole room.
C $9A2F,3 HL = pointer ($5BA2)
C $9A32,2 null pointer?
C $9A35,4 DE = pointer ($5BA4)
C $9A39,2 B=2 outer rows
C $9A3B,2 save BC/HL
C $9A3D,2 B=4 inner cells
C $9A3F,5 inner loop x4 via #R$9A62
C $9A44,1 restore address
C $9A45,4 advance a row ($20 bytes)
C $9A49,3 loop 2 rows
c $9A4D Write A to (HL), DE=HL, fall into #R$9A62 dual-write loop
N $9A4D A small draw primitive: writes one byte to the screen and mirrors it through the shared dual-buffer/attribute write path.
R $9A4D A byte to write (attribute or pixel value)
R $9A4D HL screen/attribute address
c $9A52 Write A to (HL)+$6000 (secondary buffer), then #R$9A62 dual-write loop
N $9A52 A small draw primitive: writes one byte to both the visible screen and its off-screen secondary copy, used wherever the game needs to place a single tile/icon on screen and keep the two buffers in sync.
R $9A52 A byte to write
R $9A52 HL screen address (primary buffer; +$6000 = secondary)
C $9A52,2 DE = HL
C $9A54,1 write A to the primary buffer
C $9A56,4 HL += $6000 (secondary buffer)
C $9A5B,2 C=$40 (screen page)
C $9A60,2 step both pointers back one
C $9A64,2 save HL/BC
C $9A6F,1 push HL (save attribute address)
C $9A77,5 DE = bitmap base ($5B72)
C $9A7C,2 swap, restore screen address
C $9A7E,2 B=8 rows
C $9A80,2 copy one bitmap row
C $9A82,2 advance both
C $9A84,2 loop 8 rows
C $9A86,2 restore DE, advance
C $9A88,2 restore BC/HL
C $9A8A,1 advance to next cell
C $9A62,2 C=$E0 (alt attribute page)
C $9A67,3 H AND $03
C $9A6A,1 <<3 (three RLCA)
C $9A6D,2 OR C (page base)
C $9A70,2 A = tile index
C $9A72,2 zero-extend into HL
C $9A74,1 index *= 8 (three ADD HL,HL)
c $9A8C Find all tile-map ($F800) positions matching A, store coords list at DE
N $9A8C Scans the whole room for every tile of a given type and builds a list of where they are - used to find all copies of a specific animated tile so they can be redrawn together.
R $9A8C A tile index to search for
R $9A8C DE destination coords-list address
R $9A8C O:DE past the last coord pair written
C $9A8C,6 BC=$1FF bytes, HL=$F800
C $9A92,3 search for a matching tile
C $9A96,2 back up to the match
C $9A98,1 store the column
C $9A99,2 store the row
C $9A9C,1 advance the output
C $9A9D,2 step past the match
C $9A9F,2 keep searching
c $9AA1 Snapshot current room/position into respawn staging ($5C2B-$5C32)
N $9AA1 Records where the hero currently is - room, status, position - so that if they die shortly after, #R$9090 can respawn them back in the same spot rather than restarting the room.
C $9AA1,6 room ($5C01) -> $5C2D
C $9AA7,6 save status ($5C06)
C $9AAD,3 A = hazard counter ($5C07)
C $9AB3,6 player X/Y ($5B04) -> $5C2E
C $9AB9,6 ($5B06) -> $5C30
C $9ABF,6 ($5B9E) -> $5C32
C $9AC5,1 RET
b $9AC6 Rooms that use the alternate tileset (15 entries, read by #R$9880)
b $9AD5 Per-room command/animation list (31 bytes)
c $9B22 Per-frame update for 5 party slots ($5B04): plot pixel, screen addr, sprite frame init, redraw
N $9B22 Main per-frame draw/update pump, called by #R$9018's loop. Walks the 5 world-object slots ($5B04 - hero plus up to 4 creatures/hazards, see Actors.md) twice: once to cache each slot's screen address and plot routine, once to run the slot's animation-frame init chain. Then erases last frame's sprites from saved background, redraws the sprites, and adds the sparkle and party-slot overlays.
C $9B2F,3 Compute screen address (BC) + pick plot routine (IY) for pixel HL
C $9B89,3 Reset alt BC, run init chain
C $9B8F,3 Reset alt BC, run init chain
C $9B94,3 Reset alt BC, run init chain
C $9BA5,3 Reset alt BC, run init chain
C $9BAB,3 Reset alt BC, run init chain
C $9BB0,3 Reset alt BC, run init chain
C $9BB7,3 Gated call to #R$9A2F, room/hazard-timer dependent
C $9BC4,3 Draw active object sprites
C $9BCB,3 Restore saved background under object (5 slots), via #R$9DBF for row wrap
C $9BD2,3 Restore saved background under object (5 slots), via #R$9DBF for row wrap
C $9BC7,4 IX=$5AE4: erase at last frame's cached addresses ($5B24)
C $9BCE,4 IX=$5B04: erase at this frame's ($5B44)
C $9BD5,6 copy this frame's draw cache down to $5B24
C $9BDB,5 32 bytes (5 slots x 4, plus slack)
C $9BE4,3 Draw sparkle/effect list at $9AE5, alternate-tileset variant, via #R$92D6
C $9BE7,3 Draw a tile-based graphic for each of 5 party-slots at $5B04
c $9BEB Restore saved background under object (5 slots), via #R$9DBF for row wrap
N $9BEB Erases 5 objects by copying background tiles back over the screen address cached at +$40/+41 of each slot. The copy alternates LDI- and LDD-based directions down the object's height so a sprite straddling a screen-third boundary is restored without an explicit branch. #R$9B22 calls it twice per frame, with IX=$5AE4 to clear the previous frame's positions ($5B24) and IX=$5B04 for this frame's ($5B44); +$40/+41 are the only fields it touches. The $9BF3 entry skips the slot loop for erasing a single object.
R $9BEB IX first object-slot base (stride 4, 5 slots); only (IX+$40)/(IX+$41) are read
C $9BEB,2 B=5 slots
C $9BED,6 HL = cached screen address ((IX+$40)/(IX+$41))
C $9BF3,3 mask H to a screen address
C $9BF6,2 D/E = that address
C $9BF9,2 B=4 sub-rows
C $9BFC,3 BC=$07F0 (row-wrap test constant)
C $9BFF,2 copy background bytes (LDI chain)
C $9C05,2 copy the fourth
C $9C07,2 both pointers to the next pixel row
C $9C09,2 crossed a char row?
C $9C0B,3 DOWN HL, char-row fixup
C $9C1A,3 DOWN HL, char-row fixup
C $9C29,3 DOWN HL, char-row fixup
C $9C38,3 DOWN HL, char-row fixup
C $9C47,3 DOWN HL, char-row fixup
C $9C56,3 DOWN HL, char-row fixup
C $9C59,1 restore BC
C $9C5A,2 loop 4 sub-rows
C $9C5C,2 IX += 4 (next slot)
C $9C64,1 restore BC
C $9C65,4 loop 5 slots
C $9C69,1 RET
c $9C6A Reset alt BC, run init chain (#R$9C72/$9C75/$9C78/$9C7E)
N $9C6A Reads a packed command from a data stream and jumps to the matching drawing handler - a small interpreter used to play back the sparkle/effect animation lists elsewhere in the code.
R $9C6A DE packed data pointer
R $9C6A IY dispatch address (JP (IY) tail-call)
R $9C6A O:DE advanced by 2
C $9C6B,3 clear the alt BC
C $9C7E,3 H'=$FF (mask init, alt regs)
C $9C81,1 read the first data byte
C $9C84,2 advance, keep it in B
C $9C86,1 read the second
C $9C89,2 fold both into A
C $9C8B,1 keep the first in C
C $9C8D,2 D = byte from the alt table
C $9C90,2 A = the other byte
C $9C92,1 L = A
C $9C93,2 A = H, step H on
C $9C95,2 jump to the handler
b $9C97 Plot-routine jump table (indexed by screen third)
c $9C9B Build sub-pixel blend mask, plot into (BC); DOWN BC char-row fixup
N $9C9B Plots a sprite column whose X position isn't a multiple of 8. Rotates the sprite byte through a mask 7 times to split it across the two character cells it straddles, then blends the two halves onto the screen with AND/OR so existing pixels survive, wrapping at char-row and screen-third boundaries as it walks down. Whole-byte-aligned sprites take the faster path in #R$9DE3.
C $9C9B,3 rotate one bit into D/HL (sub-pixel shift)
C $9C9F,1 six more shift-rotates (builds the 8-bit mask)
C $9CB7,2 E = mask, read screen byte
C $9CB9,2 blend with the mask
C $9CBC,2 next screen byte
C $9CBE,2 blend with the mask
C $9CC1,1 step back
C $9CC2,2 next pixel row
C $9CC4,3 crossed a char row?
C $9CC7,2 back up one row
C $9CC9,3 at the right-hand edge?
C $9CCF,3 column += $20
C $9CD3,3 mask row bits
C $9CD8,2 wrap column to $00-$1F
C $9CDC,4 row += 8 (next screen third)
C $9CE1,3 past the bottom?
C $9CE4,2 clamp to $E0
c $9CE7 Write A to (BC), fall into #R$9CC2 char-row fixup
c $9CEE Compute screen address (BC) + pick plot routine (IY) for pixel HL
N $9CEE Works out where a given pixel lands on screen and which of the sub-pixel-aligned plot routines to use to draw it - the shared setup step before any sprite/mask drawing.
R $9CEE HL pixel position (X in L, Y in H)
R $9CEE O:BC screen byte address for that pixel
R $9CEE O:IY plot-routine address for the pixel's sub-column
C $9CEE,2 save the X coordinate
C $9CF0,1 X >>= 3 (three RRCA)
C $9CF3,3 keep 5 bits
C $9CF6,3 H AND $7F
C $9CF9,2 <<2
C $9CFB,2 keep the row bits
C $9CFD,2 merge with the column
C $9CFF,3 B = screen third
C $9D02,1 keep it
C $9D03,3 pull bit6 down
C $9D06,1 >>3 (three RRCA)
C $9D09,3 merge and set the page bits
C $9D0C,1 back into B
C $9D0D,3 recover the sub-column (X AND 7)
C $9D10,4 IY = plain-write plotter
C $9D14,1 aligned? done
C $9D15,2 index *= 4
C $9D17,3 DE = that offset
C $9D1A,4 IY = $9C97 + offset
c $9D21 Deactivate object (IX+2)=$FF, restore background via #R$9BF3
N $9D21 Marks an object as gone and wipes it off the screen by restoring the background that was saved underneath it.
C $9D21,4 mark the object inactive
C $9D25,6 HL = its position
C $9D2E,2 HL = screen address
C $9D31,2 B=1 (one frame)
C $9D33,3 Draw a tile-based graphic for each of 5 party-slots at $5B04
C $9D36,3 restore HL, B=1
C $9D39,3 erase via #R$9BF3
C $9D2B,3 Compute screen address (BC) + pick plot routine (IY) for pixel HL
c $9D3C Draw a tile-based graphic for each of 5 party-slots at $5B04
N $9D3C Repaints the room background over each of the 5 object slots, working from the screen address the slot cached at +$40/+41. Rounds that address to a tile boundary, covers 3 or 4 tile rows and columns depending on whether the object sits exactly on a boundary, looks each covered cell up in the room's tile-index map at $F800, and blits its bitmap row by row. Complements #R$9BEB, which restores the same area with the faster straight-copy path.
C $9D3C,4 IX=$5B04 (party slot base), B=5 slots
C $9D42,6 HL = cached screen address ((IX+$40)/(IX+$41))
C $9D49,3 align H to tile row
C $9D4D,2 B=3 rows
C $9D4F,5 position mid-tile? one more row
C $9D59,5 same for columns
C $9D64,1 H >>= 3
C $9D68,3 mask to 2 bits
C $9D6B,4 HL = $F800 + offset
C $9D6F,3 HL = tile index
C $9D72,1 index *= 8 (three ADD HL,HL)
C $9D75,4 DE = bitmap base ($5B72)
C $9D79,2 HL += DE (bitmap source)
C $9D7B,2 restore screen address
C $9D7D,2 copy first bitmap row
C $9D83,1 six more rows, unrolled
C $9D9C,1 next column
C $9D9D,2 loop rows
C $9DA1,2 column += 32
C $9DA4,2 no carry? skip
C $9DA6,3 else row += 8
C $9DAB,2 loop columns
C $9DAE,2 IX += 4 (next slot)
C $9DB6,2 loop 5 slots
c $9DB9 DOWN DE, char-row fixup
N $9DB9 Wraps #R$9DBF: takes address in DE (swapped into HL), fixes it, result ends in HL
R $9DB9 DE screen address
R $9DB9 O:HL fixed address
C $9DBA,3 DOWN HL, char-row fixup
c $9DBF DOWN HL, char-row fixup
N $9DBF Fixes screen address HL after crossing a character-row boundary in a downward scan (all real callers do INC H per line, then call this every 8th line)
C $9DBF,1 DEC H (net down one line)
C $9DC0,2 A = L inverted
C $9DC2,2 at the row edge?
C $9DC4,2 yes: wrap to the next third
C $9DC6,3 L += $20 (next row)
C $9DC9,1 store it
C $9DCA,3 mask H to the third
C $9DCD,1 store it
C $9DCE,3 mask H to a screen address
C $9DD1,2 D/E = result
C $9DD5,2 wrap L to $00-$1F
C $9DD8,3 mask H to the third
C $9DDB,2 += 8 (next third)
C $9DDE,3 mask to a screen address
C $9DE1,1 E = L
R $9DBF HL screen address
R $9DBF O:DE fixed address
c $9DE3 Draw active object sprites (slots $5C0E,$5C13,$5B99)
N $9DE3 Draws the pixel sprite for the two creature/hazard slots ($5C0E, $5C13) plus a third fixed slot ($5B99), skipping inactive ones. Each sprite's 72-byte record at $8400 (same format as the item sprites in Items-Format.md) is masked onto the screen a byte at a time, with the same masked write repeated into the attribute file so each sprite carries its own per-cell colour. This is the pixel-sprite counterpart of the tile-based draw in #R$9D3C.
C $9E00,3 => Deactivate object (IX+2)=$FF, restore background via #R$9BF3
C $9E0C,3 Compute screen address (BC) + pick plot routine (IY) for pixel HL
C $9E1F,6 sprite table base + index*72
C $9E26,2 3 columns
C $9E2A,2 24 bytes/column
C $9E2C,5 H=$FF, mask page pointer
C $9E31,6 combine the two mask bytes
C $9E37,1 OR in the sprite bits
C $9E3D,2 A = current screen byte
C $9E3F,2 punch the mask through
C $9E41,1 write it back
C $9E42,4 point DE at the attribute file
C $9E46,1 write the same byte
C $9E47,3 advance to the next screen third
C $9E50,3 DOWN DE, char-row fixup
c $9E5D Populate the $5BD6 object-slot table (via #R$9FBA/#R$9F86)
N $9E5D Redraws the fixed UI status-bar icons in the $5BD6 slot table: a sound icon, a blank row, the currently-held item's icon (or blank if none held), and another blank row - the on-screen inventory bar, refreshed whenever the held item changes.
C $9E64,3 Store HL into an IY-indexed table entry, advance IY/HL by stride
C $9E80,3 Compute HL = A*24-ish, entry point for #R$9FBA
C $9E87,3 Store HL into an IY-indexed table entry, advance IY/HL by stride
c $9E96 Draw lives-count icons ($5B97) into $5BD6 slots
N $9E96 Draws the row of life icons in the status bar, one per remaining life.
C $9EA9,3 Compute HL = A*24-ish, entry point for #R$9FBA
C $9EB3,3 Store HL into an IY-indexed table entry, advance IY/HL by stride
C $9EBA,3 => Redraw $5BD6 slot at $5081
c $9EBD Init $5BD6 object slots from $5C23 (calls #R$9EE3)
N $9EBD Refreshes the inventory-bar icons in the $5BD6 slot table starting from a given position in the pickup log ($5C23) - used whenever the held/available items on screen need updating, e.g. after a pickup or when cycling items.
C $9EBD,3 Fill $5BD6 slots with item icons from inventory log
C $9ED0,3 Compute HL = A*24-ish, entry point for #R$9FBA
C $9ED3,3 Store HL into an IY-indexed table entry, advance IY/HL by stride
C $9EE0,3 => Redraw $5BD6 slot at $5096
c $9EE3 Fill $5BD6 slots with item icons from inventory log ($5B7C)
N $9EE3 Draws the row of collected-item icons in the status bar, reading straight from the inventory pickup log.
C $9EE3,2 B=4 slots
C $9EE5,3 A = start index ($5C23)
C $9EE8,4 IY=$5BD6 (slot table)
C $9EEC,2 keep index in L and C
C $9EEE,5 DE=$5B7C (inventory log)
C $9EF3,1 HL = log + index
C $9EF4,3 into IX
C $9EF7,5 log entry empty ($FF)?
C $9EFC,2 no: look up its icon
C $9EFE,3 HL=$5C46 (blank icon)
C $9F03,3 DE=$8400 (item sprite table)
C $9F0C,3 IX++, index++
C $9F0F,1 A = index
C $9F10,4 reached $1B?
C $9F14,2 wrap index to 0
C $9F16,4 restart the log pointer
C $9F1A,2 loop 4 slots
C $9F06,3 Compute HL = A*24-ish, entry point for #R$9FBA
C $9F09,3 Store HL into an IY-indexed table entry, advance IY/HL by stride
C $9F1C,2 => Redraw background column for up to 9 object slots
c $9F1E Redraw $5BD6 slot at $5081 (tail of #R$9E96)
c $9F27 Draw main-menu UI icons/highlight bar into $5BD6 slots
N $9F27 Draws the main menu's option icons and the highlight bar over the currently-selected input device.
C $9F33,3 Compute HL = A*24-ish, entry point for #R$9FBA
C $9F36,3 Store HL into an IY-indexed table entry, advance IY/HL by stride
C $9F5A,3 Compute HL = A*24-ish, entry point for #R$9FBA
C $9F5D,3 Store HL into an IY-indexed table entry, advance IY/HL by stride
c $9F6B Redraw $5BD6 slot at $5096 (tail of #R$9EBD)
c $9F70 Redraw background column for up to 9 object slots ($5BD6)
N $9F70 Draws the graphics for up to 9 status-bar slots, each as a 24-row-tall column, skipping the first few according to the inventory scroll offset ($5C22) so the bar can slide as the player cycles items.
C $9F73,4 IY = slot table ($5BD6)
C $9F77,4 A = scroll offset ($5C22)
C $9F7B,2 none? start at slot 0
C $9F7D,4 IY += 2 (skip a slot)
C $9F81,3 count down
C $9F84,2 B=9 slots
C $9F86,2 save HL/BC
C $9F88,6 DE = the slot graphic
C $9F8E,2 B=24 rows
R $9F86 HL screen destination
R $9F86 IY slot table entry (word pointer at +0/+1)
R $9F86 B slot count
C $9FA0,2 restore BC/HL
C $9FA2,1 next column
C $9FA3,4 IY += 2 (next slot)
C $9FA7,2 loop slots
C $9F9A,3 DOWN HL, char-row fixup
c $9FAA Compute HL = A*24-ish, entry point for #R$9FBA
N $9FAA Turns a small index into the address of the matching sprite/icon graphic - a shared lookup used whenever the game needs to find where an item or icon's picture data lives.
R $9FAA A index value
R $9FAA O:HL A*72 + caller's DE
R $9FAA DE table base the computed offset is added to
C $9FAA,1 save caller DE
C $9FAB,3 HL = A (zero-extended)
C $9FAE,1 HL *= 8 (three ADD HL,HL)
C $9FB1,1 save A*8
C $9FB2,1 HL *= 8 again (A*64)
C $9FB5,2 HL += A*8 (A*72)
C $9FB7,2 add the caller table base
c $9FBA Store HL into an IY-indexed table entry, advance IY/HL by stride
N $9FBA Fills 3 consecutive $5BD6 status-bar slots with the same graphic address, spaced by the slot table's row stride - used to draw a repeated icon (e.g. a row of blank tiles) in one call.
R $9FBA HL value to store
R $9FBA IY table entry address
R $9FBA O:IY advanced past 3 entries
R $9FBA O:HL value + 3*stride
C $9FBA,6 store the address in entry 0
C $9FC0,4 IY += 2
C $9FC4,4 advance the address by one row ($18)
C $9FC8,6 store it in entry 1
C $9FCE,1 advance a row again
C $9FCF,4 advance IY by 2
C $9FD3,6 store it in entry 2
C $9FD9,4 IY += 2
b $9FDE Status-bar icon index table (used by #R$9EBD)
c $A102 Clear a 4-byte record at $A0FE
N $A102 Per-frame ground/hazard-tile sensor for the hero, called every frame from #R$A3E1. Samples nearby tiles for a ledge-edge trigger, checks the tile under the hero for a sticky-hazard timeout, and refreshes a solid-ground flag for next frame - all gated off while a status is already active or the alternate tileset is loaded.
R $A102 DE preserved (pushed/popped, not used)
C $A108,3 clear 4-byte record ($A0FE)
C $A117,3 skip if status active or alternate tileset
C $A120,3 Sample two nearby tiles (below/right of object) for collision
C $A124,4 tile==$A5 (either sample)? trigger $1A
C $A132,3 Check object position against screen bounds, sample tile ahead
C $A146,4 tile under feet == $BC? branch
C $A156,4 hazard counter >=50 frames? sets status $11
C $A165,3 Scan tile column below feet against solid-tile list ($A24B/$A271), flag (IY+0)
C $A168,3 Scan tile column right of object (X+23) via #R$A2B2
C $A174,1 restore DE
C $A174,2 restore DE
c $A176 Sample two nearby tiles (below/right of object) for collision
N $A176 Reads the tile-index map at two points near the object: one below its feet, one to its right - the two spots #R$A102 checks for a "walked off a ledge" style hazard.
R $A176 IX object (position at +0/+1)
R $A176 O:C tile index below feet
R $A176 O:B tile index right of object
C $A17D,3 Y+=$17 (sample point below feet)
C $A185,3 Convert pixel position (HL) to character-cell coordinates
C $A188,1 C=tile below
C $A18B,3 X+=$10 (sample point right of object)
C $A18E,3 Convert pixel position (HL) to character-cell coordinates
C $A191,1 B=tile right
c $A193 Check tile below-left of feet (X+12,Y+23) against special-tile lists
N $A193 Checks the tile just below-left of the object's feet against one of two special-tile lists, chosen by whether the current room is $0C; falls back to a second pair of lists when the alternate tileset is loaded. Used as a ground/edge sensor, similar to #R$A1F4 but sampling one tile position over.
R $A193 IX object (position at +0/+1)
R $A193 O:Zf set if tile matches
C $A196,4 X+12 off-screen? -> blocked
C $A1A4,3 alternate tileset? use alt list
C $A1A7,3 get Current room number
C $A1AA,3 room==$0C? (stash for after tile lookup)
C $A1AD,3 Convert pixel position (HL) to character-cell coordinates
C $A1B2,2 room==$0C? check $92/$95 too
C $A1C0,2 off-screen: A=1 (blocked)
C $A1C3,3 Convert pixel position (HL) to character-cell coordinates
c $A1D3 Blocked-check wrapper (Y-1) via #R$A208, save/restore (IY+3)
N $A1D3 Checks whether the tile one row above the object's current position is blocked, without disturbing the object's own blocked-flag record - used by the movement code to test a move before committing to it.
R $A1D3 IX object (position at +0/+1)
R $A1D3 IY object's tile-flag record (shared with #R$A102/#R$A1F4)
R $A1D3 O:Zf set if blocked
C $A1D8,4 clear (IY+3)=0 (result init)
C $A1E6,3 BC = (X+12, Y+24)
C $A1E9,3 C=(IY+3) result
c $A1F4 Check object position against screen bounds, sample tile ahead
N $A1F4 Scans upward from the tile just ahead of the object (X+12, Y+24) against a special-tile list ($A234, or $A264 for the alternate tileset), counting rows climbed in (IY+3) until a match is found or the scan runs off the top of the screen.
R $A1F4 IX object (position at +0/+1)
R $A1F4 IY object's tile-flag record (shared with #R$A102/#R$A1D3)
R $A1F4 O:(IY+3) rows climbed before match/off-screen (5 = off-screen)
R $A1F4 O:Zf set on tile match
C $A1FF,4 Y+24 off-screen ($7F)?
C $A203,4 off-screen: (IY+3)=5
C $A208,1 H = Y
C $A209,2 BC = the position
C $A20B,3 Convert pixel position (HL) to character-cell coordinates
C $A215,3 alternate tileset? use alt list ($A264)
C $A21C,2 tile matches? RET
C $A21F,3 row empty (list end)? stop scanning
C $A22B,4 reached bottom? off-screen
C $A22F,3 else: next row up
b $A234 Special-tile list, base tileset (used by #R$A1F4)
b $A24B Solid-tile list, base tileset (25 bytes, $00-terminated; used by #R$A2AC)
b $A264 Special-tile list, alternate tileset (used by #R$A1F4)
b $A271 Solid-tile list, alternate tileset (34 bytes; shares only the first 15 entries with #R$A24B, then diverges - the alternate set treats far more tiles as solid)
c $A293 Convert pixel position (HL) to character-cell coordinates
N $A293 Converts a pixel position (HL) into the address of that pixel's entry in the 32x16 tile-index map at $F800 - the shared coordinate-to-tile-map lookup used throughout the tile-scanning and collision routines.
R $A293 HL pixel position (X in L, Y in H)
R $A293 O:HL tile-index map address ($F800+offset)
R $A293 DE preserved
C $A294,2 X>>=3 (pixel -> char column)
C $A29B,2 H<<=2 (row bits into position)
C $A2A6,4 HL += $F800 (tile-index map base)
c $A2AC Scan tile column below feet against solid-tile list ($A24B/$A271), flag (IY+0)
N $A2AC Checks the ground under an object across several tile rows and flags whether it's standing on solid/special ground - the shared "is this object on the ground" test used by both the hero and creatures.
R $A2AC IX object (position at +0/+1)
R $A2AC IY flag record (result byte at +0)
R $A2AC O:(IY+0) 0 or 1 (solid-tile match)
C $A2AC,6 HL = object position
C $A2B2,4 clear the result flag
C $A2B6,2 B=3 rows
C $A2B8,3 position mid-tile?
C $A2BD,1 yes: scan a 4th row
C $A2BE,2 save BC/HL
C $A2C3,3 DE=$A24B (solid-tile list)
C $A2C6,4 alternate tileset?
C $A2CC,3 yes: use list $A271
C $A2D2,4 room>=$18?
C $A2D6,3 DE=$A242 (alt list)
C $A2D9,4 alternate tileset?
C $A2DF,3 alternate tileset -> DE=$A268 instead
C $A2E2,2 tile matches list entry?
C $A2E6,2 next entry
C $A2E8,3 end of list ($00)?
C $A2EB,2 no match: leave flag clear
C $A2ED,4 match: flag = 1
C $A2F1,2 restore address
C $A2F3,3 row += 8
C $A2F6,1 restore counter
C $A2F7,2 loop rows
C $A2C0,3 Convert pixel position (HL) to character-cell coordinates
C $A2CF,3 get Current room number
c $A2FA Scan tile column right of object (X+23) via #R$A2B2
N $A2FA Checks the tiles just to the right of an object for solid ground - the sideways counterpart to #R$A2AC's below-feet check.
R $A2FA IX object (position at +0/+1)
R $A2FA IY flag record (result byte at +1, not +0 - IY is bumped before the call)
C $A2FD,2 X+$17 (right of object)
C $A303,2 IY++ so result lands at (IY+1)
C $A305,3 Scan tile column below feet against solid-tile list ($A24B/$A271), flag (IY+0)
c $A30B Scan tile below-right of feet (X+12,Y+24) via #R$A328
N $A30B Checks the tile just below and right of an object, writing the result into the second slot of the caller's flag record.
R $A30B IX object (position at +0/+1)
R $A30B IY flag record (result byte at +1 - IY is bumped before the call)
C $A314,2 Y+$18 (below feet)
C $A317,2 IY++ so result lands at (IY+1)
C $A319,3 Scan tile at (X+12) against special-tile list ($A242/$A268), flag (IY+0)
c $A31F Scan tile at (X+12) against special-tile list ($A242/$A268), flag (IY+0)
N $A31F Checks the tile just ahead of an object against a list of special tiles (ladders, water, etc.) rather than plain solid ground - feeds the movement code's "is this tile special" checks.
R $A31F IY flag record (result byte at +0)
C $A31F,5 X + $0C
C $A324,4 HL = that position
C $A328,4 clear flag (IY+0)=0
C $A32F,3 DE=$A242 (tile list)
C $A332,4 alternate tileset?
C $A336,2 no: use this list
C $A338,3 DE=$A268 (alternate-tileset list)
C $A33B,2 tile matches list entry?
C $A33F,2 next entry
C $A341,3 end of list?
C $A344,2 no match: leave the flag clear
C $A346,4 match: flag = 1
C $A34A,1 RET
C $A32C,3 Convert pixel position (HL) to character-cell coordinates
c $A34B Apply joystick input to object position, trigger room edge at $A640
N $A34B Moves the hero for one frame based on the current joystick/keyboard input: turns the input into a direction and speed, checks the tile ahead isn't blocked before committing to it, and updates the hero's position and facing direction accordingly. Also hands off to the room-edge handler once the hero walks far enough to leave the room. Called every frame by #R$A3E1, which is the outer driver.
R $A34B IX=$5B04 (hero, implicit - always the same object)
C $A34C,3 Set hero status ($5C06), clear hazard timer ($5C07)
C $A34F,4 frame=$1A
C $A353,3 Clear a 4-byte record at $A0FE
C $A356,3 Resolve conflicting L/R, U/D input via #R$B894
C $A359,1 E=input bitmask
C $A35A,4 BC=velocity ($5C34)
C $A35E,4 right? X-velocity++
C $A364,4 clamp at +4
C $A369,4 left? X-velocity--
C $A374,4 down? Y-velocity++
C $A37F,4 up? Y-velocity--
C $A38A,4 X-velocity sign picks which blocked flag to test
C $A395,2 blocked: reverse X-velocity
C $A3A4,4 Y-velocity sign picks which blocked test
C $A3AF,2 blocked: reverse Y-velocity
C $A3B4,3 Blocked-check wrapper (Y-1) via #R$A208, save/restore (IY+3)
C $A3BD,4 store velocity ($5C34)
C $A3C5,4 direction flag from X-velocity sign
C $A3CE,3 Y += Y-velocity
C $A3D5,3 X += X-velocity
C $A3DB,3 X wrapped below 4? cross to next room
C $A3DE,3 => Move left
c $A3E1 Main per-frame player update: input, movement, room-state/hazard dispatch
N $A3E1 The hero's main per-frame update, called once every frame. Moves the hero (#R$A34B), checks for scripted room events and status changes, and reacts to a long list of specific room/position combinations that trigger scripted moments (cutscenes, hazards, sound effects). This is the busiest routine in the disassembly, and the natural place to look first for any hero-behavior question not already answered elsewhere - see Actors.md's status-code table for what's known about the values it sets.
R $A3E1 IX=$5B04 (hero, implicit - always the same object)
C $A3E1,3 Per-room init dispatch
C $A3F1,3 => Scripted-zone list step
C $A3F4,3 Resolve conflicting L/R, U/D input via #R$B894
C $A3FC,3 Scripted zone trigger
C $A40C,3 Room-state dispatch
C $A40F,3 Scripted zone trigger by room+position table
C $A416,3 Check ENTER key (port $FBFE), trigger state $0A via #R$AE85
C $A41C,4 room-category ($5B98)==$0A?
C $A420,3 get Current room number
C $A423,4 room==$14 or $08?
C $A42B,5 status=4
C $A430,5 frame=$1D
C $A438,2 Y-8, underflow? keep Y
C $A447,4 bit4 of E set?
C $A457,3 get Current room number
C $A45A,4 room==$1A?
C $A474,5 status=2
C $A47E,4 store direction bits ($5C08)
C $A487,4 right pressed?
C $A495,5 X>=$E8? cross room right
C $A49D,4 left pressed?
C $A4AE,2 X<4? cross room left
C $A4B3,4 down pressed?
C $A4C7,5 Y>=$67? move down a level
C $A4D1,4 up pressed?
C $A4DD,4 Y-2 off-screen (top)?
C $A4F4,2 room==$18?
C $A500,4 Y=$60 (top row)
C $A504,4 clear direction ($5C08)
C $A508,5 status=3 via #R$AE85
C $A513,4 right pressed?
C $A51A,4 left pressed?
C $A521,3 either direction pressed?
C $A52B,2 mask to down/up bits
C $A534,4 already triggered? (IY+3)
C $A53A,4 hazard timer <5?
C $A53E,5 room-category ($5B98)==5?
C $A552,4 counter <3? (masked)
C $A559,3 counter reached 3?
C $A55E,4 store direction ($5C08)
C $A562,5 status=1
C $A588,4 room>=$35?
C $A58C,6 flag bit7 set? (IX+0)
C $A592,4 room==$10?
C $A596,4 room==$1C?
C $A59A,5 room-category ($5B98)==5?
C $A5A1,4 bump respawn-skip counter ($5C05)
C $A5AF,5 Y>=$68? move down a level
C $A5CE,4 tile flag ($5C28) set?
C $A5D6,4 tile==$BC? pick offset
C $A5EA,3 any direction pressed (masked)?
C $A5F4,4 frame odd? advance animation
C $A601,4 sound-effect flag set?
C $A611,5 room-category ($5B98)==$0C?
C $A623,4 any movement this frame?
C $A628,5 room-category ($5B98)==5?
C $A484,3 => Sound-effect dispatcher wrapper
C $A49A,3 => Move right
C $A4B0,3 => Move left
C $A4BA,3 Check tile below-left of feet (X+12,Y+23) against special-tile lists
C $A4CC,3 => Move down a level
C $A4D5,3 Check tile below-left of feet (X+12,Y+23) against special-tile lists
C $A4F1,3 get Current room number
C $A4F6,3 => Move up a level
C $A4FB,3 Move up a level
C $A50E,3 Clear a 4-byte record at $A0FE
C $A52E,3 Check tile below-left of feet (X+12,Y+23) against special-tile lists
C $A56A,3 => Store scripted-zone list pointer ($AEED) from HL
C $A576,3 Clear a 4-byte record at $A0FE
C $A585,3 get Current room number
C $A5B4,3 => Move down a level
C $A5F1,3 get Frame counter
c $A640 Move left: next room = same row, col-1 (wraps), or reverse portal lookup if leaving room $29
N $A640 Handles the hero walking off the left edge of a room: works out the room to the west (with a special-case for the portal rooms) and switches into it.
C $A640,3 get Current room number
C $A643,2 A = portal index ($5B70)
C $A64A,3 HL = that index
C $A64D,4 HL = $A66C + index
C $A651,1 A = the destination room
C $A652,3 set Current room number
C $A657,3 Decode room number ($5C01) to row/col
C $A662,3 Encode row/col to room number
C $A669,3 => Set up the current room
b $A66C Portal source rooms
N $A66C Table of 5 "portal" source room numbers; any room matching one of these forces a jump to fixed room $29 on exit-right, instead of normal row/col+1 grid math. Referenced by #R$A671 and #R$A64D.
B $A66C,5 portal source rooms: $2D,$2E,$2F,$46,$47
c $A671 Move right: next room = same row, col+1 (wraps 12->0); portal check via #R$A66C
N $A671 Decodes current room ($5C01) to (row,col) via #R$AEEF, increments col (wraps at 12), re-encodes via #R$AEFD, places player near the left edge of the new room ((IX+0)=$02), then redraws (#R$9855). If the current room is listed in #R$A66C, jumps straight to room $29 instead.
C $A676,3 get Current room number
C $A67F,3 Decode room number ($5C01) to row/col
C $A68A,3 Encode row/col to room number
C $A691,3 => Set up the current room
C $A696,3 set Current room number
c $A69B Move up a level: row-1, blocked at row<0
N $A69B Decodes room to (row,col) via #R$AEEF, decrements row (B); if it underflows (already on the topmost level), leaves the room unchanged. Otherwise re-encodes via #R$AEFD, places player near the bottom edge of the new room ((IX+1)=$66), then redraws (#R$9855).
C $A69B,3 Decode room number ($5C01) to row/col
C $A6A4,3 Encode row/col to room number
C $A6AB,3 => Set up the current room
c $A6AE Move down a level: row+1, blocked at row=6 (only 6 levels)
N $A6AE Decodes room to (row,col) via #R$AEEF, increments row (B); if it reaches 6 (only 6 vertical levels exist), leaves the room unchanged. Otherwise re-encodes via #R$AEFD, places player near the top edge of the new room ((IX+1)=$02), then redraws (#R$9855).
C $A6AE,3 Decode room number ($5C01) to row/col
C $A6B8,3 Encode row/col to room number
C $A6BF,3 => Set up the current room
c $A6CC Room-state dispatch: jump via table at $A72E, indexed by ($5C06)
N $A6CC Jumps to whichever handler matches the hero's current status, via a jump table - this is how a status code set by #R$AE85 actually turns into behaviour each frame.
C $A6CC,3 A = status ($5C06)
C $A6CF,2 zero? nothing to dispatch
C $A6D3,2 (status-1) * 2
C $A6D5,3 HL = that index
C $A6D9,4 HL = $A72E + index
C $A6DD,2 DE = handler address
C $A6E0,2 into HL, restore DE
C $A6E2,2 no handler?
C $A6E5,1 jump to it
b $A6E6
c $A828 Trap-entry: hazard-timer table lookup via #R$ABDE, on $FF room-state++
C $A82C,3 Increment hazard counter ($5C07), index a table by half its value
C $A831,3 => Store trigger code into creature state
b $A83B Hazard-timer step table for the #R$A828 trap
c $A851 Trap-entry: hazard-timer table lookup, on $FF award score $4B and reset via #R$AE84
N $A851 A scripted trap that counts down on the hazard timer and, when it expires, awards score and clears the hero back to normal status.
C $A855,3 Increment hazard counter ($5C07), index a table by half its value
C $A85A,3 => Store trigger code into creature state
C $A862,3 Populate the $5BD6 object-slot table
C $A868,3 Save all registers
C $A86B,3 => Set hero status ($5C06), clear hazard timer ($5C07)
t $A86E Hazard-timer step table for the #R$A851 trap
b $A887
c $A888 Set table $A8BF, C=0, falls into #R$A8AB
C $A88D,2 => Hazard-timer table lookup via #R$ABDE, on $FF fire event via #R$C4B2
b $A88F
c $A8AB Hazard-timer table lookup via #R$ABDE, on $FF fire event via #R$C4B2
N $A8AB A scripted trap driven by the hazard timer: each tick looks up a step value and, when the sequence ends, fires a sound effect and resets.
C $A8AB,3 Increment hazard counter ($5C07), index a table by half its value
C $A8B1,3 => Store trigger code into creature state
C $A8B7,3 Sound-effect dispatcher wrapper
C $A8BC,3 => Set room state=$12, reset hazard counter
b $A8BF Hazard-timer step table for the #R$A888 trap
c $A8EA Room-dependent creature init: hazard-timer/room checks, sets $5B9E/$5B9F, room-transition via table $B073
N $A8EA A scripted trap tied to specific rooms rather than a roaming creature: on first activation it seeds a couple of staging variables, then depending on the room either forces a fixed hero status or advances a shared hazard counter until it fires, which teleports the hero to a destination room looked up from a small per-room table ($B073).
R $A8EA IX creature/trap object (position written at the end)
C $A8EA,4 hazard timer ($5C07) already running?
C $A8F0,5 $5B9E=$1F
C $A8F5,5 $5B9F=$50
C $A8FA,3 get Current room number
C $A8FD,2 C=$BD
C $A8FF,4 room==$30?
C $A903,2 C=$A0
C $A905,4 room==$3D?
C $A909,5 status=$17
C $A90E,2 discard return, RET
C $A910,4 flag ($5C44) set?
C $A915,4 latch C into $A959
C $A91A,3 DE=$A955 (step table)
C $A91D,3 Increment hazard counter ($5C07), index a table by half its value
C $A920,4 result bit7 set?
C $A924,2 $FF (end of table)?
C $A926,3 => Set hero status ($5C06), clear hazard timer ($5C07)
C $A929,4 hazard counter ($5C07)++
C $A92D,2 mask to 7 bits
C $A92F,3 set Current room number
C $A932,1 save A
C $A933,5 HL=$B073, B=3 entries
C $A938,3 room matches entry?
C $A93B,1 next entry (stride 3)
C $A941,4 Y from table
C $A946,4 X from table
C $A94A,3 remember X in $B072
C $A94E,3 => Set up the current room
C $A951,3 store trigger code (IX+2)
C $A954,1 RET
b $A955 Hazard-timer step table for the #R$A8EA trap
b $A959 Latched creature code (written by #R$A8EA)
c $A95F Init creature position from $5B14, state=$2D
b $A96B
c $A99A Latch current room into $5B9E
c $A9A1 Set creature Y (+8 to $5B9F); check room against table $A9E6, trigger #R$AE84
N $A9A1 Sets a creature's Y and a lookahead point 8 pixels below it, then triggers a status reset if the current room is one of a fixed four and the lookahead has reached that room's target row. The $A9A9 entry skips the Y-set step.
R $A9A1 IX creature object (Y stored at +1)
R $A9A1 A new Y position
C $A9A4,5 lookahead = Y+8 ($5B9F)
C $A9AE,3 get Current room number
C $A9B1,3 room matches table entry?
C $A9B8,2 no match: A=1
C $A9BC,4 lookahead matches entry's target row?
C $A9C1,3 => Set hero status ($5C06), clear hazard timer ($5C07)
c $A9C4 Creature Y-advance dispatcher: room $43 special case, else #R$A9A1 or #R$A6AE
N $A9C4 Decides how a creature moves down: one room gets special handling, otherwise it either steps down within the room or drops to the level below.
C $A9C5,3 get Current room number
C $A9D7,2 => Set creature Y
C $A9D9,3 Move down a level
C $A9E4,2 => Latch current room into $5B9E
b $A9E6 Room/target-row pairs checked by #R$A9A1
c $A9EE Hazard timer expiry: lose a life
N $A9EE Ticks the per-room hazard counter and, once it runs out, costs the hero a life and queues a respawn (or ends the game if that was the last life). This is where the "Infinite Lives" POKE (43517,182) patches out the life loss.
C $A9EF,4 hazard counter ($5C07)++
C $A9F4,3 reached 50? else RET
C $A9F7,3 hazard threshold hit: mark room-switch pending
C $A9FA,4 lives--
C $A9FE,3 none left? game over
C $AA01,3 => Draw lives-count icons ($5B97) into $5BD6 slots
b $AA04
c $AA3C Creature update: gate on direction bit, then hazard-timer room trigger
N $AA3C A scripted trap: bails out early if the creature is moving one particular direction, otherwise counts frames until a threshold is hit, then fires one of three trigger codes chosen by which room the creature is in.
R $AA3C IX creature/trap object
R $AA3C E direction bitmask
C $AA3D,4 frame=$17
C $AA45,2 direction bit0 set? reset and exit
C $AA47,3 => Set hero status ($5C06), clear hazard timer ($5C07)
C $AA4E,4 counter reached 5?
C $AA52,1 else counter++
C $AA57,2 C=$0E, bumped per room check ($09/$1C/$1B)
C $AA67,3 Set hero status ($5C06), clear hazard timer ($5C07)
C $AA6C,3 => Sound-effect dispatcher wrapper
c $AA6F Creature Y-movement by hazard-counter lookup table ($AAFA)
N $AA6F Moves a creature upward frame by frame along a pre-authored curve (a lookup table indexed by the hazard counter) and advances its animation frame, until the hazard counter reaches its limit and the trap resets.
R $AA6F IX creature object
C $AA70,3 DE=Y-step curve ($AAFA)
C $AA77,5 counter reached $54 (end of curve)?
C $AA7E,3 HL=curve entry for this counter
C $AA84,1 Y -= curve step
C $AA88,6 X += 2
C $AA95,4 frame at max ($19)?
C $AA9F,3 counter past $28? force frame $1A
b $AAA7
c $AAF0 Set room state=$12, reset hazard counter ($5C07)
b $AAFA Y-movement curve, indexed by hazard counter (#R$AA6F)
c $ABC3 Store trigger code into creature state (IX+2)
b $ABC7
c $ABDE Increment hazard counter ($5C07), index a table by half its value
N $ABDE Ticks the hazard timer and looks up a per-trap value keyed to it - the shared "advance the clock and check what happens now" step used by the scripted trap routines.
R $ABDE DE lookup table base
R $ABDE O:A table[($5C07)/2] (pre-increment value)
C $ABE2,1 counter++ (A keeps the pre-increment value)
C $ABE3,2 index = counter/2 (each entry lasts 2 frames)
C $ABE8,1 HL = table + index
b $ABEB
c $AC35 Creature trap-entry: clamp position per direction bits (E), dispatch by room state ($5B98)
N $AC35 A scripted trap: keeps a creature moving along its track and bouncing off the screen edges, and in a couple of specific rooms pushes it into a level change instead - generic "obstacle on a track" logic shared by several similar trap routines.
R $AC35 IX creature/trap object
R $AC35 E direction bitmask
C $AC35,1 discard return
C $AC36,3 get Current room number
C $AC39,3 store scripted room ($5C27)
C $AC3C,5 frame=$7F
C $AC42,3 Clear a 4-byte record at $A0FE
C $AC46,4 (IY+3) set?
C $AC4A,3 no: skip to room dispatch
C $AC4D,3 A=status ($5C06)
C $AC50,2 status==7?
C $AC52,3 A=X
C $AC57,4 direction bit0 (right)?
C $AC5B,4 blocked flag set? skip
C $AC61,2 X+=2
C $AC63,4 X past $E4?
C $AC67,2 undo the +2
C $AC69,4 direction bit1 (left)?
C $AC6D,4 blocked flag set? skip
C $AC73,2 X-=2
C $AC75,4 X below 8?
C $AC79,2 undo the -2
C $AC7B,6 store clamped X ($5C25, IX+0)
C $AC81,3 A=room category ($5B98)
C $AC84,4 category 6?
C $AC88,4 category 7?
C $AC8E,5 status=8
C $AC95,5 status=7
C $AC9A,4 Y-1
C $AC9E,4 Y still >= $18? skip level change
C $ACA3,3 get Current room number
C $ACA6,2 room 3?
C $ACAB,3 Move up a level
C $ACAE,3 reload Y
C $ACB1,6 store Y and $5C26
C $ACB8,5 status already 8? RET
C $ACBE,5 else status=9
C $ACC4,4 (IY+3) set?
C $ACCA,5 Y+=2
C $ACCF,6 store, reload Y
C $ACD5,4 if <$66, skip level-down
C $ACD9,2 push IX
C $ACDB,3 Move down a level
C $ACE0,5 Y+=$18 (wrap below)
C $ACE8,3 A=Y
C $ACEB,3 store $5C26
C $ACEF,6 store Y ($5C26) alt path
C $ACF5,3 direction bits, none set? RET
C $ACF9,4 bit1 set? branch $AD0B
C $ACFD,5 X+=2
C $AD02,3 past $E7? RET
C $AD08,3 => Set hero status ($5C06), clear hazard timer ($5C07)
C $AD0B,5 X-=2
C $AD10,1 below 0? RET
C $AD14,3 trigger event via #R$AE85 (tail)
C $AD14,3 => Set hero status ($5C06), clear hazard timer ($5C07)
c $AD17 Creature Y-=4; move up a level via #R$A69B if off-screen, else trigger event 2
N $AD17 Moves a creature up four pixels, changing level if that takes it off the top of the screen, and otherwise fires a status trigger.
C $AD1B,1 Y -= 4 (four DEC A)
C $AD1F,3 => Move up a level
C $AD22,3 store new Y
C $AD25,3 Clear a 4-byte record at $A0FE
C $AD28,4 already triggered? ((IY+3))
C $AD2D,2 status=2
c $AD32 Creature trap-entry: room $5B98 check, move X by direction bits (E)
N $AD32 Fixed-track obstacle from the same family as #R$AC35, but gated by room category rather than by the hazard timer: outside category $0A it just flags the object and resets it to status 0. Inside it, the object walks 2px per frame in its current direction and flips direction at the screen edges instead of crossing into the next room.
C $AD33,5 room category ($5B98)==$0A?
C $AD3A,5 no: store $5C03=2
C $AD3F,3 => Set hero status ($5C06), clear hazard timer ($5C07)
C $AD42,5 (IX+2)=$1D
C $AD47,4 direction bit0 (right)?
C $AD4B,5 X+=2
C $AD50,4 past $E7? skip
C $AD54,4 set direction flag
C $AD58,3 store X
C $AD5B,4 direction bit1 (left)?
C $AD5F,5 X-=2
C $AD64,4 below 4? skip
C $AD68,4 clear direction flag
C $AD6C,3 store X
C $AD6F,4 direction bit3 (down)?
C $AD73,4 Y-=2
C $AD77,3 off-screen? branch $AD82
C $AD7A,1 Y-=2 again
C $AD7E,3 store Y
C $AD82,3 get Current room number
C $AD85,3 room==8? RET Z
C $AD88,3 => Move up a level
C $AD8B,3 direction bit2 (up)? RET Z
C $AD8E,5 Y+=2
C $AD94,3 get Current room number
C $AD97,2 room==$14?
C $AD9C,3 Y<$57? else RET NC
C $AD9F,3 store Y
C $ADA3,2 Y>=$67?
C $ADA8,3 store Y
C $ADA5,3 => Move down a level
c $ADAC Creature update: Y-state via #R$AE76, hazard-timer++, room-cross via #R$A671/#R$A640
N $ADAC A patrolling creature that walks off one side of the room and reappears in the next, stepping left or right each frame according to a direction flag. Its Y position follows a pre-authored curve, and the whole thing resets once the hazard counter runs out.
C $ADAD,3 DE=Y-position table ($AE8D)
C $ADB0,3 Look up a table by hazard counter ($5C07), store into
C $ADB7,1 hazard counter++
C $ADB8,4 counter==$11 (sequence end)?
C $ADBC,5 snap Y down to tile boundary
C $ADC4,3 => Set hero status ($5C06), clear hazard timer ($5C07)
C $ADC7,3 Creature Y-bound check via #R$AF09/table $AE9E, move up via #R$A69B or clamp
C $ADCE,3 no direction set? RET
C $ADD1,4 bit0 set? move right
C $ADDA,4 X past right edge ($E7)?
C $ADE2,3 Move right
C $ADF6,3 Clear a 4-byte record at $A0FE
C $ADFD,2 flag set? keep new position
C $AE09,3 X at left edge?
C $AE13,3 Move left
C $AE27,3 Clear a 4-byte record at $A0FE
c $AE37 Creature Y-bound check via #R$AF09/table $AE9E, move up via #R$A69B or clamp
N $AE37 Keeps a creature within its allowed vertical range, either nudging it up a level or clamping it at a per-room boundary.
C $AE37,3 Type-$10 gate
C $AE4C,3 Move up a level
C $AE5B,3 Clear a 4-byte record at $A0FE
C $AE67,2 => Set hero status ($5C06), clear hazard timer ($5C07)
b $AE69
c $AE76 Look up a table by hazard counter ($5C07), store into (IX+2)
N $AE76 Picks this frame's animation frame for a creature from a per-trap table, indexed by how far the hazard timer has advanced.
R $AE76 DE lookup table base
R $AE76 IX creature object (frame stored at +2)
C $AE7A,3 HL = table + counter
C $AE7E,1 A = table entry
C $AE7F,3 store as creature frame
c $AE84 Set hero status ($5C06), clear hazard timer ($5C07) ($AE84: status=0; $AE85: status=A)
N $AE84 The single choke point for changing the hero's status: every scripted trigger, hazard, and reset in the game passes through here to set the new status and restart the hazard clock.
R $AE85 A new room-state code ($5C06)
b $AE8D Y-position table, indexed by hazard counter (#R$AE76)
c $AEAF Store scripted-zone list pointer ($AEED) from HL
b $AEB3
c $AEB9 Scripted-zone list step: $FF ends list, else store trigger code, advance $AEED
N $AEB9 Reads the next entry of a scripted-zone list and applies it to the creature, stopping and clearing the list pointer when it hits the end marker.
C $AEBA,4 $FF end-of-list marker?
C $AEC5,3 store step as creature frame
C $AEC8,4 advance list pointer
b $AECD Scripted-zone step list (loaded by #R$AEAF)
c $AEEF Decode room number ($5C01) to row/col
N $AEEF Divmod by 12: B=row (quotient), C=col (remainder). Rooms are numbered row*12+col, i.e. 12 rooms per horizontal row (matches the player-drawn map's row width).
R $AEEF O:B row
R $AEEF O:C col
c $AEFD Encode row/col to room number
N $AEFD room = B*12 + C. Stores result to ($5C01).
R $AEFD B row
R $AEFD C col
C $AF05,3 set Current room number
c $AF09 Type-$10 gate: proximity check via #R$AF22, move down a level if room-state 2
N $AF09 For one particular creature type, drops the hero to the level below if they are close enough and the game is in the right state.
C $AF0D,3 Proximity check
C $AF1D,3 => Move down a level
c $AF22 Proximity check: player X vs pointer ($5BA2) column
N $AF22 Checks whether the hero is horizontally close to a specific tracked position - a lighter-weight proximity test than #R$9140, used for a single X-only check.
C $AF22,3 HL = tracked pointer ($5BA2)
C $AF25,2 null?
C $AF27,2 yes: carry set, RET
C $AF29,3 keep the column bits
C $AF2C,1 column *= 8 (three ADD A,A)
C $AF2F,1 back into L
C $AF30,3 A = player X ($5B04)
C $AF33,1 distance from the target
C $AF34,1 behind it? RET
C $AF35,3 within 8 pixels? (result in carry)
b $AF39 Saved stack pointer (trap-entry mechanism)
c $AF3B Scripted zone trigger: set special-encounter flag ($5C06)
N $AF3B Checks whether the hero has just entered a room with a scripted encounter and, if so, kicks off the associated status trigger.
C $AF3B,4 HL=$5C01, A=current room
C $AF3F,4 room $1D? use alt check
C $AF43,3 A = scripted room ($5C27)
C $AF46,2 matches current? else RET
C $AF48,6 target Y ($5C26) minus player Y
C $AF4E,2 centre the window
C $AF50,3 within 4 pixels?
C $AF53,6 same test for X ($5C25)
C $AF5B,3 within 4 pixels?
C $AF5E,5 status=7
C $AF64,3 alt: skip unless left pressed
C $AF67,5 player Y == $48?
C $AF6D,5 player X >= $1C?
C $AF73,3 and below $20?
C $AF76,5 snap player X to $1E
C $AF7B,5 status=$0D
c $AF81 Room-entry trigger: check position/input for a special zone
N $AF81 Watches for the hero standing in one particular spot in one particular room and pressing up or down, firing a scripted event when they do - one of several small "stand here and press a key" puzzle triggers.
R $AF81 IX hero object (position at +0/+1)
C $AF81,5 frame $24 -> $5B14
C $AF86,6 $5B9F -> $5B15
C $AF8C,2 A -= 8
C $AF8E,5 matches player Y?
C $AF93,5 player X >= $12?
C $AF9A,4 and below $38?
C $AF9F,4 clear $5BA0
C $AFA4,4 player Y >= $1A?
C $AFA8,4 and below $30?
C $AFAC,4 status ($5C06) zero?
C $AFB2,4 or $13?
C $AFB6,4 or $14? else skip
C $AFBA,3 Resolve conflicting L/R, U/D input via #R$B894
C $AFBD,4 down pressed?
C $AFC1,2 status=$14
C $AFC3,3 Set hero status ($5C06), clear hazard timer ($5C07)
C $AFC8,4 up pressed? else skip
C $AFCC,5 trigger $13 via #R$AE85
C $AFD1,5 $5B16=$9F
c $AFD7 Init a room-specific decorative object ($5B10-$5B17) by room category
N $AFD7 Sets up a decorative object whose look depends on which room the hero is in - only runs for the one room it's scripted for.
C $AFD7,6 scripted room ($5C27) vs current
C $AFDD,2 no match? RET
C $AFDF,5 status $12?
C $AFE5,3 or $1A? RET
C $AFE8,3 A = base X ($5C25)
C $AFEB,6 store to $5B14 and $5B10
C $AFF1,6 A = base Y ($5C26), store $5B15
C $AFF7,5 Y-16 -> $5B11
C $AFFC,3 A = status
C $AFFF,2 C=$99 (default sprite)
C $B001,4 category 7?
C $B005,4 category 8?
C $B009,4 category 9?
C $B00D,2 else default
C $B010,2 C=$24
C $B012,3 A = frame ($5B07)
C $B015,6 store to $5B17 and $5B13
C $B01C,4 category 9? use $B02A
C $B020,5 sprite id $9A -> $5B12
C $B025,4 C -> $5B16
C $B02A,4 category 9: A=$7F, JR back to store
c $B02E Check ENTER key (port $FBFE), trigger state $0A via #R$AE85
c $B03B Scripted zone trigger by room+position table ($B073)
N $B03B Checks the hero's position against a small table of room+position hotspots and fires a one-shot scripted event when they step into one.
C $B03B,2 B=3 entries
C $B03D,3 HL=$B073 (hotspot table)
C $B043,3 room matches entry?
C $B046,1 next entry (stride 3)
C $B049,2 loop
C $B04B,4 no match: clear one-shot flag ($B072)
C $B051,4 player Y matches entry?
C $B058,4 C = entry X threshold
C $B05C,3 player X below it? skip
C $B060,3 C = threshold + 8
C $B063,1 keep it
C $B065,3 player X past it? skip
C $B068,4 already triggered ($B072)?
C $B06D,2 status=$16
C $B06F,3 Set hero status ($5C06), clear hazard timer ($5C07)
C $B040,3 get Current room number
b $B072 Per-room scripted-event flag
t $B07C
b $B098
t $B099
s $B0B5
c $B0B6 Multi-stage animation sequence, dispatched by stage counter ($5C41)
N $B0B6 A scripted, one-shot fanfare animation for a fixed object, played out over several stages as fields of it step toward target values, with a sound effect at each stage change. Most likely the room-$28 warp fanfare set up by #R$B6EE, not everyday gameplay logic.
C $B0B6,4 IY=object ($5B08)
C $B0BA,3 HL=stage counter ($5C41)
C $B0BE,3 stage counter==0?
C $B0C1,1 counter++ (advance to stage 1)
C $B0EE,4 completion flag ($5BFE) set? else RET
C $B104,3 stage 1 check
C $B112,3 target $54 reached?
C $B116,4 completion flag set? pick branch
C $B122,3 => Sound-effect dispatcher wrapper
C $B12E,3 stage 2 check
C $B131,5 field reached target $77?
C $B140,3 => Sound-effect dispatcher wrapper
C $B143,3 stage 3 check
C $B151,3 target <4 reached?
C $B15D,1 advance the sub-stage
C $B15E,1 not finished? RET
C $B161,3 set Game-over flag
c $B165 Read/test flag ($5C00)
b $B16A
c $B370 Scripted event: trigger room $1C lift sequence at a fixed spot
N $B370 Stage-0 checks the flag byte at $5C40 (via #R$B165) then initializes an object at $5B10 from a template; once room $5B98=2 and the hero stands at the fixed spot (X=$DC, Y=$48), advances the stage and fires status $1C via #R$AE85 (the room $1C lift trigger seen elsewhere in the room-format notes). Stages 1+ (dispatched at $B3AB) drive whatever animation follows - not detailed here, but the pattern matches the other staged-object routines ($B0B6, $B4E2). Reads as one of several similar "walk to this exact spot in this exact room to trigger a scripted lift/sequence" set-pieces.
C $B370,3 Read/test flag
C $B37C,3 stage 0?
C $B37F,4 init object position/frame
C $B392,3 room-category == 2?
C $B398,3 player X == $DC?
C $B39E,3 player Y == $48?
C $B3A6,2 status=$1C
C $B3A8,3 Set hero status ($5C06), clear hazard timer ($5C07)
C $B3AB,2 A = stage
C $B3AD,2 stage 1?
C $B3B2,3 hero frame == $3E (lift ready)?
C $B3D0,5 lift X -= 4
C $B3D8,3 reached Y=$52?
C $B3F2,3 reached Y=$48?
C $B3F5,5 set flag $5C00 (lift done)
C $B403,3 Populate the $5BD6 object-slot table
C $B406,3 => Set hero status ($5C06), clear hazard timer ($5C07)
c $B409 Staged animation: init object ($5B14), branch on player side
N $B409 Room hazard that bounces an object vertically between floor and ceiling, starting on whichever side of the screen the hero stands on. Stage 0 picks that side and places the object; stage 1 hands off to the ceiling-bound or floor-bound mover depending on the object's type, each stepping 1px per frame and bouncing off both the opposite bound and the side walls; stage 2 resets the state.
C $B411,3 stage 0?
C $B41A,2 player left of $C8?
C $B41C,4 start at bottom (Y=$D8), else top (Y=$08)
C $B428,3 store side flag ($5C40)
C $B436,4 stage 1 dispatch
C $B43E,2 side flag picks the up or down mover
C $B440,3 Move object up toward ceiling, bounce via #R$B4D5
C $B444,3 Move object down toward floor, bounce via #R$B4A3
C $B44A,3 Classify object type ((IX+2)) into a size/category flag
C $B453,5 flip side flag for next time
C $B458,5 status=$15
C $B45E,3 stage 2 dispatch
C $B474,5 Y -= 8
C $B47B,3 => Set hero status ($5C06), clear hazard timer ($5C07)
c $B47E Move object down toward floor, bounce via #R$B4A3
N $B47E Walks an object downward one pixel per frame until it reaches the floor, drifting sideways as it goes and bouncing off the left and right walls.
C $B47E,3 A = gate flag ($5C42)
C $B481,2 set? nothing to do
C $B483,2 E=0 (not moved)
C $B485,5 already at the floor ($D8)?
C $B48B,4 E=1, B = current X
C $B48F,4 Y += 1
C $B493,4 past $38? bounce via #R$B4A3
C $B498,3 X -= 2
C $B49B,3 below 8? RET
C $B49E,3 store X
b $B4A2
c $B4A3 Right-bounce clamp for #R$B47E: X>=$C8 -> RET, else X+=2
c $B4B0 Move object up toward ceiling, bounce via #R$B4D5
N $B4B0 Walks an object upward one pixel per frame until it reaches the ceiling, the mirror of #R$B47E.
C $B4B0,3 A = gate flag ($5C42)
C $B4B3,2 clear? nothing to do
C $B4B5,2 E=0 (not moved)
C $B4B7,5 already at the ceiling (9)?
C $B4BD,4 E=1, B = current X
C $B4C1,4 Y -= 1
C $B4C5,4 past $1C? bounce via #R$B4D5
C $B4CA,3 X += 2
C $B4CD,3 past $30? RET
C $B4D0,3 store X
b $B4D4
c $B4D5 Left-bounce clamp for #R$B4B0: X>=$7B -> RET, else X-=2
c $B4E2 Staged animation: init object ($5B10), scripted trigger via #R$AE85
N $B4E2 Drives a small scripted sequence for a set-piece object: sets it up, waits for the hero to approach, then plays out an animation and fires a status trigger.
C $B4EA,3 stage 0?
C $B4FA,3 HL=$5C45 (sub-stage)
C $B4FE,4 sub-stage $FF (finished)?
C $B508,3 player Y >= $48?
C $B50E,3 player X >= $62?
C $B518,4 arm object flag
C $B523,3 status already >= 4? RET
C $B52B,2 sub-stage=1 (running)
C $B534,4 reached X limit ($E6)?
C $B53B,3 Save all registers
C $B540,6 X += 2
C $B548,3 get Frame counter
C $B554,2 sub-stage=$FF (done)
c $B55A Init 2 objects ($5B0C) variant, falls into #R$B57C
c $B562 Init 3 objects ($5B0C) from template; animate frame, room-specific variant
N $B562 Sets up and animates a group of 3 decorative objects from a shared template, with the exact appearance varying by room - the multi-object sibling of #R$B4E2's single-object staged animation.
C $B562,4 IY=object ($5B0C)
C $B566,3 HL=stage counter ($5C41)
C $B56A,3 stage==0? else skip init
C $B577,2 copy template (12 bytes)
C $B57A,2 B=3 objects
C $B57C,5 frame==$7F (inactive)? skip
C $B583,4 frame==$55 (trigger)? branch
C $B587,3 get Frame counter
C $B591,4 wrapped? reset to $51
C $B598,3 get Current room number
C $B5A9,4 room-category==$0C?
C $B5B0,5 object aligned with player (masked)?
C $B5CC,5 trigger $19 via #R$AE85
b $B5D1 12-byte object template copied by #R$B562
c $B5DD Boss/miniboss state machine: proximity check, phase transitions ($5C3C-$5C3E), animation
N $B5DD A fixed encounter tied to one room: once the hero gets close enough, it plays through a sequence of phases and eventually warps the hero to room $28 with a fanfare, rather than acting like a roaming creature. Between phases it also runs a small scripted patrol, pacing back and forth and reacting when the hero reaches either edge.
C $B5E4,2 not eligible? skip
C $B5E9,4 room == locked boss room ($5C3C)?
C $B5F3,2 mark room handled
C $B5F5,3 save type ($5C3E)
C $B60B,1 phase++
C $B60C,3 phase==6?
C $B616,3 flag set? skip init
C $B626,5 store room $30
C $B62C,2 mask flag
C $B62E,4 flag==1? branch to patrol
C $B63E,4 step==$FF (list end)?
C $B649,2 already armed?
C $B64D,4 step==$4D? re-arm
C $B657,3 step==$4D?
C $B65E,4 phase -> table index
C $B668,4 store hazard code ($5C3C)
C $B67F,4 edge flag set? reverse direction
C $B693,3 column = (pos-4)>>2
C $B6A1,4 column>=$C0? right edge
C $B6A8,3 column<$22? left edge
C $B6AE,3 A = frame counter
C $B6B1,4 halve, keep 2 bits
C $B6B5,5 frame = base $49 + that
C $B5E1,3 Classify object type ((IX+2)) into a size/category flag
C $B5F8,3 Reset object slots ($5C0E), scan $B99D table for current room
C $B5FB,3 Populate the $5BD6 object-slot table
C $B601,3 Save all registers
C $B60F,3 => Force room $28, set $5BFE flag, trigger event via #R$AE85
C $B6AE,3 get Frame counter
b $B6BB Per-phase hazard codes for the #R$B5DD encounter
t $B6C1 Scripted step sequence for the #R$B5DD encounter
b $B6EC
c $B6EE Force room $28, set $5BFE flag, trigger event via #R$AE85
C $B6F0,3 set Current room number
C $B6F3,3 Set up the current room
c $B704 Position+room gate: room $5B98=$0D, status $5C06=0 -> trigger $1B via #R$AE85
N $B704 Fires a one-shot scripted trigger when the hero is standing on an exact spot in one particular room with nothing else already happening.
C $B704,3 A = object Y
C $B707,3 Y == $20?
C $B70A,3 A = object X
C $B70D,3 X past $84? RET
C $B713,3 A = room category
C $B716,3 category $0D?
C $B719,3 A = status ($5C06)
C $B71C,2 not idle? RET
C $B71E,5 trigger $1B via #R$AE85
c $B723 Init object Y=8, falls into #R$B735
c $B72D Init object Y=$DC (variant); animation frame + type-gated deactivate
N $B72D Sets up an object at the bottom of the screen and drives its animation, retiring it once its type indicates it's no longer needed.
C $B72D,4 IY=$5B14
C $B731,4 Y=$DC (variant start)
C $B735,4 frame=$12
C $B739,2 C=$56
C $B73B,4 flag $5C43 set?
C $B741,1 C++ (alternate frame)
C $B742,3 store frame
C $B745,2 flag was set? skip ahead
C $B747,5 room category $10?
C $B750,1 wrong type? RET
C $B751,5 mark handled ($5B98=$FF)
C $B756,3 and $5C43
C $B75C,3 A=flag ($5C42)
C $B75F,3 arm or disarm via #R$B779
C $B762,3 HL=$5C40
C $B768,2 wrong type? skip
C $B76A,2 clear flag ($5C40)
C $B76D,2 flag already set? RET
C $B770,2 set it
C $B772,3 HL=$5C42
C $B776,2 flip flag ($5C42)
C $B77A,4 arm (IY+3) bit7
C $B77F,4 flag clear? disarm instead
C $B74D,3 Classify object type ((IX+2)) into a size/category flag
C $B759,3 => Populate the $5BD6 object-slot table
C $B765,3 Classify object type ((IX+2)) into a size/category flag
c $B784 Stage counter advance ($5C41); at stage $14 check $5C3F, trigger $17 via #R$AE85
N $B784 Advances a scripted sequence one step per frame, and at one particular step checks a flag before firing the trigger that ends it.
C $B784,3 HL = stage counter ($5C41)
C $B787,3 stage $14?
C $B78A,2 yes: check the flag
C $B78C,3 stage $15? nothing to do
C $B78F,1 else advance the stage
C $B790,1 RET
C $B791,3 A = flag ($5C3F)
C $B794,2 set? not yet
C $B796,3 advance the stage, status=$17
C $B799,3 Set hero status ($5C06), clear hazard timer ($5C07)
c $B79C Fill-pattern variant A (B=$15, base $F940), falls into #R$B7A8
c $B7A3 Fill-pattern variant B (B=$0B, base $F954): init position, draw pattern via #R$9A4D
N $B7A3 Stashes the object's position into the $5B14 slot fields, then paints a short column of cells in alternating colours (parity of the row and the frame counter) - reads as a beam or trail drawn from the object rather than a whole-screen effect.
C $B7A3,2 B=$0B rows
C $B7A5,3 HL=$F954 (base)
C $B7A9,3 clear $5B09
C $B7AC,6 clear $5B0D and $5B11
C $B7B2,6 X ((IX+0)) -> $5B14
C $B7B8,5 object Y + 8
C $B7BD,4 past $5A? leave $5B15 alone
C $B7C1,3 store Y -> $5B15
C $B7C7,4 frame parity into C
C $B7CC,3 row parity
C $B7CF,3 pick the colour ($BC or $BD)
C $B7D2,2 save BC/HL
C $B7D7,2 restore address, advance
C $B7DA,2 loop rows
C $B7C4,3 get Frame counter
C $B7D4,3 Write A to (HL), DE=HL, fall into #R$9A62 dual-write loop
c $B7DD Per-room init dispatch: table $B7EC indexed by room, jump via #R$A6DD
b $B7EC Per-room init handler table (2 bytes/room, #R$B7DD)
B $B87C,1 Input bits: 000FUDLR
c $B87D Resolve conflicting L/R, U/D input via #R$B894 (cancel to 0)
N $B87D Reads the current input and cancels out impossible presses (both left and right, or both up and down at once) before the movement code sees it.
C $B87D,3 Read joystick/keyboard, normalize to Kempston-style bitmask
C $B880,1 keep a copy in E
C $B881,4 left and right both pressed?
C $B887,2 yes: cancel to 0
C $B889,3 up and down both pressed?
C $B890,2 yes: cancel to 0
C $B892,2 return E (no conflict)
C $B87D,3 Read joystick/keyboard, normalize to Kempston-style bitmask
c $B894 Read joystick/keyboard, normalize to Kempston-style bitmask
N $B894 Device selected by ($94AF): 0=keyboard (redefined keys, table at $B8D4), 1=Kempston (port $1F), 2=Sinclair 2 (keys 6-0, port $EFFE). Result stored at $B87C: bit0=right, bit1=left, bit2=down, bit3=up, bit4=fire.
C $B899,4 A = device ($94AF)
C $B89D,3 zero? keyboard
C $B8A0,3 device=1: Kempston
C $B8A3,5 device=2: Sinclair, read port $EFFE
C $B8C4,3 => Return normalized input bitmask
C $B8C9,3 => Return normalized input bitmask
C $B8CC,4 read the Kempston port $1F
C $B8D0,1 store the result
C $B8D1,3 => Return normalized input bitmask
b $B8D4
c $B930 Return normalized input bitmask ($B87C)
c $B932 Clear active flag (bit7) across all $B99D creature-table entries
c $B93F Reset object slots ($5C0E), scan $B99D table for current room
N $B93F Clears the two dynamic encounter slots and repopulates them from the room-tagged encounter table for whatever room the hero is now in - run on every room entry (see Actors.md for the $B99D table itself).
C $B94E,3 get Current room number
C $B956,3 Spawn a creature/hazard into slot $5C0E/$5C13 from a room-data entry
c $B95F Spawn a creature/hazard into slot $5C0E/$5C13 from a room-data entry (HL)
N $B95F Spawns one creature/hazard from a $B99D table entry. A running spawn counter (C, carried over from #R$B93F's scan) picks which of the two dynamic slots it goes into and skips the entry entirely once both slots are already filled; the entry's own data then supplies the type and X/Y position.
R $B95F HL room-data entry ($B99D format)
R $B95F C running spawn counter (persisted across #R$B93F's scan, incremented here)
R $B95F O:IX chosen slot ($5C0E or $5C13)
C $B95F,3 skip if both slots already filled (bit1 of counter)
C $B966,4 counter bit0 picks slot ($5C0E/$5C13)
C $B96E,1 counter++ (mark this slot used)
C $B972,6 store own address (IX+3/4)
C $B978,2 HL -> type byte
C $B97A,2 step to the position byte
C $B97D,5 type = entry byte1 AND $1F
C $B983,3 X = entry byte2 high bits
C $B989,3 rotate X bits into place
C $B992,3 Y from entry byte2
b $B99D Room-tagged creature/encounter table
N $B99D Room-tagged creature/encounter table, separate from the per-room $C152 table (see Actors.md). 31 entries, 3 bytes each: byte0=room number this entry belongs to (bit7 double-purposed as a flag - toggled in bulk at init by #R$B932 and individually by #R$B9FA's boss-entry check at $B9D9, entry 20; exact armed-vs-consumed sense of the bit not confirmed), byte1=type ID (low 5 bits, top 3 bits unconfirmed), byte2=X/Y sub-position, decoded by #R$B95F. Scanned linearly by #R$B93F on room entry, which also carries a running counter across the scan (not part of the table) that #R$B95F uses to pick which of the two dynamic object slots ($5C0E/$5C13) a match goes into, and to skip any further matches once both are filled. Entry 20 ($B9D9, room $30) is the one #R$B9FA treats as "the boss" - it's the only entry individually addressed by room-specific code rather than only via the linear scan.
B $B99D,93,3 room-tagged encounter entries (see note)
c $B9FA Per-frame item dispatcher: room $30 boss-defeat check, else swap held item (SPACE)
N $B9FA In room $30 specifically, checks whether the hero is standing in a fixed doorway-sized box and clears bit7 of the $B99D table's room-$30 entry ($B9D9, see note there), forces a permanent "boss defeated" state ($5B98/$5C44=$FF), rescans the $B99D table for the room, and awards score via #R$BCF2. In every other room, falls through to #R$BB5D's pickup/hint check, then #R$BC1F which handles cycling the held item via the number-row keys (port $F7FE) with an animated scroll. The room-$30 special-case strongly suggests this is the specific boss-defeat trigger room, separate from the more generic #R$B5DD boss state machine.
C $BA27,3 Reset object slots ($5C0E), scan $B99D table for current room
C $BA2D,3 Save all registers
C $BA30,3 => Populate the $5BD6 object-slot table
C $BA33,3 Item pickup/hint check for both creature slots
C $BA3A,3 Cycle inventory selection via keys (port $F7FE), animate scroll
C $BA6E,3 Init $5BD6 object slots from $5C23
C $BA71,3 Populate the $5BD6 object-slot table
C $BA7F,3 get Current room number
C $BA85,3 Gate + room-specific visual effect
C $BA8C,3 Gate + room-specific visual effect
C $BA92,3 Room $5B98=$0C seesaw trigger
b $BA96 Gate flag for the #R$BA97 room effect
c $BA97 Gate + room-specific visual effect (room $3A special-cased)
N $BA97 Drives a room-specific animated visual effect, gated by a per-frame flag: an effect index selects a frame from the table at $F968 and is advanced on a fraction of frames so it animates slower than the frame rate, with two speed/phase branches depending on how far the index has run. Room $3A additionally clamps the hero's X against fixed bounds.
R $BA97 A packed state byte (effect index + flags)
C $BA97,1 save state byte in C
C $BA9C,3 effect already running? alt path
C $BA9F,3 Always-true stub (CP A), used by #R$BA97
C $BAA4,4 room $3A?
C $BAB9,3 else room-category must be $0B
C $BABF,3 player X below $2C? RET
C $BAC2,3 player X above $B8? RET
C $BAC5,4 X in dead zone [$36,$B2)? RET
C $BACD,4 clear timer flag ($5C0D)
C $BAD4,3 effect index < $7A? done
C $BAD9,5 set timer flag
C $BAE0,2 mask to effect index (7 bits)
C $BAE2,3 HL = effect table base ($F968)
C $BAE9,3 get Frame counter
C $BAEC,3 only every 4th frame
C $BAF0,4 bit7 of state picks variant
C $BAFB,3 DE = byte table ($BB51)
C $BAFE,3 get Current room number
C $BB01,4 room $3A? use alt table
C $BB0F,3 get Current room number
C $BB19,3 Write A to (HL)+$6000 (secondary buffer), then #R$9A62 dual-write loop
C $BB1F,4 timer flag set? alt update
C $BB28,3 state past $10?
C $BB34,3 player X past $BA? latch $81
C $BB4B,3 player X below $30? latch $90
C $BB19,3 Write A to (HL)+$6000 (secondary buffer), then #R$9A62 dual-write loop
b $BB51 Effect byte table for #R$BA97 (room $3A uses $BB55)
c $BB59 Always-true stub (CP A), used by #R$BA97
c $BB5D Item pickup/hint check for both creature slots ($5C0E, $5C13)
N $BB5D Per-frame pickup check for the two creature slots ($5C0E, $5C13): if the slot holds a collectible item rather than a hazard, and the hero is close enough, and the 27-slot inventory log at $5B7C has a free entry, the item is collected. A few item types have extra conditions (one latches the current room as a bookmark, others only allow pickup mid-animation of another event); a successful pickup snaps the hero to the item, starts the pickup animation (status 5) and deactivates the item. See Items-Format.md for the log format.
C $BB5D,4 IX=$5B04 (player)
C $BB61,4 IY=first creature slot ($5C0E)
C $BB70,3 Classify object type ((IX+2)) into a size/category flag
C $BB73,3 not a trackable type? skip
C $BB7E,3 HL=inventory log ($5B7C)
C $BB82,2 B=27 slots
C $BB84,3 slot free ($FF)?
C $BB8F,5 item type $16?
C $BB96,3 yes: latch room into $5C3F
C $BBA5,5 status ($5C06)==2?
C $BBAC,5 hazard timer ($5C07)>=10?
C $BBB3,6 player X minus item X
C $BBBB,2 make positive
C $BBBD,2 in range (<6)?
C $BBC1,6 snap player X to item
C $BBC7,5 player Y = item Y - $17
C $BBCF,4 state=$0F
C $BBDA,2 D=1 (refresh flag)
C $BBDD,5 room ($5B98) already latched?
C $BBE4,1 no: latch it
C $BBE9,3 DE=$32 (score award)
C $BBF2,3 Sound-effect dispatcher wrapper
C $BBFA,4 retire the item (type=$FE)
C $BBFE,6 HL = its display object
C $BC08,2 refresh flag set?
C $BC11,2 C zero?
C $BC15,3 C one?
C $BC18,1 else index 2
C $BB70,3 Classify object type ((IX+2)) into a size/category flag
C $BBEC,3 Save all registers
C $BC0A,3 Populate the $5BD6 object-slot table
C $BC1C,3 => Init $5BD6 object slots from $5C23
c $BC1F Cycle inventory selection via keys (port $F7FE), animate scroll ($5C21/$5C22)
C $BC1F,2 no key pressed? skip to scroll dispatch
C $BC26,4 keys 1/2 both pressed? RET
C $BC2B,4 key 1 pressed?
C $BC2F,5 arm scroll: dir=1, speed=4
C $BC3C,1 selection index--
C $BC3D,3 wrapped below 0? snap to $1A
C $BC43,4 key 2: clear scroll state
C $BC4A,4 scrolling? skip re-init
C $BC57,3 scroll-speed counter==4?
C $BC61,3 selection index reached $1B (wrap)?
N $BC1F Handles the player cycling through carried items with the number keys, driving the little scroll animation as the selection changes and updating which item is actually held.
C $BC50,3 Init $5BD6 object slots from $5C23
C $BC64,3 => Init $5BD6 object slots from $5C23
C $BC69,3 => Init $5BD6 object slots from $5C23
C $BC70,3 => Init $5BD6 object slots from $5C23
c $BC73 Room $5B98=$0C seesaw trigger: position gate, toggle Y $46/$48, room-state trigger
N $BC73 A rocking-platform puzzle piece: once the hero stands at the right spot in the right room, it rocks them between two Y positions for a few frames, then plays an escalating sound cue and resolves.
R $BC73 IX=$5B04 (hero, implicit - always the same object)
C $BC76,3 flag==$0D? skip
C $BC7A,5 room==$0C?
C $BC83,4 Y==$48?
C $BC8E,3 X<$34? else RET
C $BC9B,4 frame bit0: toggle Y=$46/$48
C $BCAF,3 frame&3!=0? RET
C $BCB4,3 store room-state=6
C $BCB9,2 counter==$0C?
C $BCBB,3 => Set hero status ($5C06), clear hazard timer ($5C07)
C $BCBE,2 counter-6
C $BCCD,3 DE=$F928 (sound-effect table)
C $BCD4,3 Write A to (HL)+$6000 (secondary buffer), then #R$9A62 dual-write loop
C $BCD7,2 restore HL, advance
C $BCD9,2 A=$99 (second byte)
C $BCDB,3 => Write A to (HL)+$6000 (secondary buffer), then #R$9A62 dual-write loop
c $BCDE Negate 4-byte value ($5C18) via CPL chain, falls into #R$BD15 (add DE:BC=1)
N $BCDE Negates the 32-bit score value in place, so the shared add routine can be reused to subtract.
C $BCDE,1 negate 3 bytes (CPL each, unrolled, HL-- between)
C $BCEA,2 negate the last byte
C $BCED,3 DE=1 (so the add becomes a two-s complement)
c $BCF2 Save all registers (context-save wrapper)
N $BCF2 Awards a score/timer delta and redraws its display, preserving every register around the call so it can be dropped into any piece of game logic without disturbing what that code was doing.
R $BCF2 DE score delta to add (passed through to #R$BD11)
C $BCF2,2 push the main registers (IX,IY,HL,BC,AF)
C $BCFA,1 push the alternate registers (HL,BC,DE)
C $BCFE,6 Add 32-bit value ($5C18) by DE:BC
C $BD05,1 pop the alternate registers
C $BD09,1 pop the main registers
c $BD11 Add 32-bit value ($5C18) by DE:BC (BC sign-extended from D)
N $BD11 Adds a signed 16-bit amount to the 32-bit score, sign-extending so the same routine handles both awards and deductions.
C $BD11,4 IX=$5C18 (target)
C $BD15,3 assume a negative amount (BC=-1)
C $BD18,4 D positive? use 0 instead
C $BD1F,6 HL=(IX+0/1) low word
C $BD25,1 add the low word
C $BD26,6 store it back
C $BD2C,6 HL=(IX+2/3) high word
C $BD32,2 add the high word with carry
C $BD34,6 store it back
c $BD3B Print hi-score ($5B78) at screen $5049 via #R$BD78
C $BD3B,4 save the printer's current source pointer ($BD89)
C $BD3F,6 repoint it at the hi-score ($5B78)
C $BD45,3 HL=screen position $5049
C $BD48,3 Print current score at screen $5029, falls into #R$BD78
C $BD4B,4 restore the original source pointer
c $BD50 New high-score check: compare $5C1B vs stored $5B7B, save if beaten
N $BD50 Compares the score just made against the stored high score digit by digit and, if it is bigger, copies it over and redraws the display.
C $BD50,3 HL = candidate score ($5C1B)
C $BD53,3 already flagged? skip
C $BD56,3 DE = stored high score ($5B7B)
C $BD59,2 B=4 digits
C $BD5B,2 compare one digit
C $BD5D,2 candidate bigger? take it
C $BD5F,3 equal? try the next digit
C $BD62,2 step both pointers back
C $BD64,2 loop 4 digits
C $BD67,6 HL=$5C18, DE=$5B78
C $BD70,2 copy the 4-byte score
C $BD72,3 Print hi-score ($5B78) at screen $5049 via #R$BD78
c $BD75 Print current score at screen $5029, falls into #R$BD78
N $BD75 Draws the current score as digits on screen, blanking leading zeros - the shared digit-printer also reused by the high-score display.
C $BD75,3 HL=$5029 (screen position)
C $BD79,2 B=4 digit cells
C $BD7B,2 A=$20 (space)
C $BD80,2 loop 4 spaces
C $BD84,4 clear leading-zero flag ($5C20)
C $BD88,3 HL=$5C18 (score)
C $BD8B,6 DE=$5C1C, BC=4
C $BD91,2 copy score to work buffer
C $BD95,4 IX=$5C1C (work buffer)
C $BD99,4 sign bit set?
C $BDA2,4 IY=$BE18 (place-value table)
C $BDA6,2 B=4 digits
C $BDA9,2 C=0 (digit counter)
C $BDAB,6 DE = place value from table
C $BDB1,3 B = its high byte
C $BDB4,2 IY += 3 (next entry)
C $BDBD,4 leading-zero flag set?
C $BDC1,3 A=digit, non-zero? print it
C $BDC4,3 digit zero and still leading? skip
C $BDC7,3 else clear the flag
C $BDCA,2 convert digit to ASCII
C $BDCC,1 EXX
C $BDD1,1 restore BC
C $BDD2,2 loop 4 digits
C $BDD6,3 last digit (B==1)?
C $BDD9,2 no: skip
C $BDDD,2 force printing a single zero
C $BD7D,3 Draw character bitmap
C $BD9D,3 Negate 4-byte value ($5C18) via CPL chain, falls into #R$BD15
C $BDBA,3 Repeated-subtraction division
C $BDCD,3 Draw character bitmap
c $BDDF Repeated-subtraction division: subtract DE from 32-bit (IX+0..3), C=count
N $BDDF Divides a 32-bit value by repeatedly subtracting a divisor and counting how many times it fit - used by the score/digit-printing code to peel off one decimal digit at a time.
R $BDDF IX 32-bit value to divide
R $BDDF DE low word of the divisor
R $BDDF B high byte of the divisor
R $BDDF O:C quotient (number of successful subtractions)
C $BDDF,6 HL = low word of the value
C $BDE5,1 save it
C $BDE6,3 low word -= DE
C $BDE9,6 store it back
C $BDEF,4 A = byte 2
C $BDF3,4 subtract divisor high byte with borrow
C $BDF7,4 A = byte 3
C $BDFB,5 propagate the borrow
C $BE00,2 went negative?
C $BE02,1 discard the saved copies
C $BE05,3 count one more subtraction
C $BE08,4 restore byte 3
C $BE0C,4 restore byte 2
C $BE10,1 restore the low word
C $BE11,6 store it back
b $BE18 Decimal place-value table (1000/100/10/1) for the score printer
c $BE42 Decode room's creatures/hazards from the room data table ($C152)
C $BE42,1 save A (room number)
C $BE4C,4 clear 29-byte scratch buffer
C $BE50,3 HL = room number
C $BE59,4 HL = room data table + A*12
C $BE60,2 B=3 slots
C $BE65,2 byte0 low nibble = creature type ID
C $BE67,2 type written twice
C $BE6C,2 byte0 bit7 = flag
C $BE71,1 byte0 >>= 4 (four RRCA)
C $BE75,2 byte0 bits4-6
C $BE83,2 byte3 low 7 bits
C $BE88,2 byte3 bit7
C $BE8E,4 advance output pointer +10, next slot
C $BE96,2 restore A
N $BE42 Decodes the current room's 12-byte record in the $C152 table into the 29-byte scratch buffer at $BE24, unpacking it as 3 creature/hazard sub-records of 4 bytes each (packed type ID, flag bits and raw fields - see Actors.md). An all-zero sub-record means an empty slot. Returns A unchanged.
R $BE42 A room number
c $BE98 Dispatch per-creature-type init (jump table $BECA) for the 3 hazard slots
N $BE98 Spawns the room's creatures/hazards: for each of the 3 slots decoded from the room data table, jumps to the matching type's own setup routine.
C $BE98,2 B=3 slots
C $BE9A,3 DE = decoded record ($BE24)
C $BE9F,4 IX = first object slot ($5B08)
C $BEA5,1 A = creature type
C $BEA6,3 zero-extend into HL
C $BEA9,1 type *= 2
C $BEAA,4 HL = jump table entry ($BECA + type*2)
C $BEAE,2 A = handler low byte
C $BEB0,2 HL = handler address
C $BEB2,3 IY = record pointer
C $BEB5,3 Jump to handler in HL (dispatch tail of #R$BE98)
C $BEB8,5 IX += 4 (next object slot)
C $BEBE,4 DE += 10 (next record)
C $BEC3,3 loop 3 slots
c $BEC9 Jump to handler in HL (dispatch tail of #R$BE98)
b $BECA Creature-type handler jump table (used by #R$BE98)
c $BEDC No-op stub (RET)
c $BEDD Move object along X by 2px, bounce off walls/edges
N $BEDD Slides an object sideways a couple of pixels each frame and turns it round when it meets a wall or the edge of the room - the horizontal half of the simple creature movement pair.
C $BEDD,4 template already applied?
C $BEE3,3 no: stamp it via #R$C135
C $BEE6,4 direction flag set?
C $BEEA,3 A = X position
C $BEEF,4 move -2, check underflow
C $BEF3,3 store the new X
C $BEF6,3 Wrapper: scan tile below feet via #R$A2AC, flag at $C12D
C $BEF9,4 blocked ($C12D)?
C $BEFF,3 => Advance animation frame
C $BF08,3 A = direction flag
C $BF0B,5 flip it
C $BF10,3 => Advance animation frame
C $BF16,3 Wrapper
C $BF1F,3 => Advance animation frame
c $BF22 Move object along Y by 2px, bounce off walls/edges
N $BF22 Slides an object up or down a couple of pixels each frame and turns it round when it meets floor or ceiling - the vertical twin of #R$BEDD.
C $BF22,4 template already applied?
C $BF28,3 no: stamp it via #R$C135
C $BF2B,4 direction flag set?
C $BF2F,3 A = Y position
C $BF34,4 move -2, check underflow
C $BF38,3 store the new Y
C $BF3B,3 Wrapper: scan tile via #R$A31F, flag at $C131
C $BF3E,4 blocked ($C131)?
C $BF44,3 => Advance animation frame
C $BF4D,3 A = direction flag
C $BF50,5 flip it
C $BF55,3 => Advance animation frame
C $BF5B,3 Wrapper
C $BF64,3 => Advance animation frame
c $BF67 Move object -X by 2px (timed via #R$BFA0), bounce via #R$C0FD
N $BF67 Moves an object left on a timer, reversing when it runs into something - the mirror of #R$BFBB.
C $BF69,3 Countdown timer
C $BF8E,3 Wrapper
C $BF97,3 => Advance animation frame
C $BF9D,3 => Advance animation frame
c $BFA0 Countdown timer (IY+8): init via #R$9390 if zero, else decrement
N $BFA0 A shared per-object countdown, reseeded with a random-ish value each time it runs out - used to stagger creature behavior changes so objects don't all act in lockstep.
R $BFA0 C low bit merged into new random timer value
R $BFA0 IY object (timer at +8)
R $BFA0 O:Zf set when timer reaches 0
C $BFA0,3 A = timer ((IY+8))
C $BFA3,3 still running? just decrement
C $BFA6,3 gate/init via #R$C135
C $BFAC,3 mask the random value, fold in C
C $BFAF,6 store it, then reload
C $BFB5,2 count down, zero? RET
C $BFB7,3 store the new value
C $BFA9,3 Pseudo-random byte
c $BFBB Move object +X by 2px (timed via #R$BFA0), bounce via #R$C109
N $BFBB Moves an object right on a timer, reversing when it runs into something - one of the four timed single-direction movers the creature code picks between.
C $BFBD,3 Countdown timer
C $BFE4,3 Wrapper
C $BFED,3 => Advance animation frame
C $BFF3,3 => Advance animation frame
c $BFF6 Move object down 2px per tick, animating; continues at $C000
N $BFF6 Moves an object down the screen a couple of pixels each time its countdown fires, cycling its animation frame as it goes, and plays a sound once it reaches the bottom or hits something. Careful with the $C000 entry point: that address is only this routine's continuation in the main bank - #R$8F47 and #R$9491 page in bank $16 first and so reach a completely different $C000 (the music player), which this disassembly never shows.
C $BFF8,3 Countdown timer
C $BFFB,4 frame=$7F (idle)
C $C003,2 Y += 2
C $C005,4 past bottom ($67)?
C $C00D,4 clear timer
C $C012,3 store new Y
C $C015,3 Wrapper: scan tile below-right via #R$A30B, flag at $C131
C $C018,4 blocked below? reverse branch
C $C025,3 cycle of 4 frames
C $C031,3 frame = base + cycle
C $C03A,3 blocked: back up 1px
C $C04F,2 sound effect 5
C $C051,3 => Sound-effect dispatcher wrapper
c $C054 Idle-frame check ($55/$7F), else #R$C0AC advance animation
C $C054,4 template already applied? (IY+8) bit0
C $C05A,3 gate/init via #R$C135
C $C060,3 frame $55 (settled)? RET
C $C063,3 frame $7F (idle)? RET
C $C066,3 => Advance animation frame
c $C069 Advance animation frame counter (IY+7), compute sprite frame (IX+2)
N $C069 Steps a creature to its next animation frame, cycling back to the start when it runs off the end, and turns that into the sprite frame the drawing code reads.
C $C069,2 C=$11 (timer reseed bits)
C $C06B,3 Countdown timer
C $C06F,3 frame counter++
C $C072,4 cycle finished (bit4)?
C $C078,5 keep only the direction bit
C $C07D,3 store it back
C $C080,4 clear the timer
C $C085,3 A = frame counter
C $C088,3 keep bits 1-3, halve
C $C08B,4 second half of the cycle?
C $C08F,3 yes: run it backwards
C $C092,1 C = frame index
C $C093,6 frame = base ((IY+4)) + index
c $C0AC Advance animation frame; check player collision, trigger effect via #R$AE85
N $C0AC The shared "tick a creature" finisher: advances its animation to the next frame and, on the right frame, checks whether the hero is close enough to be hit, firing a status trigger if so.
C $C0AC,4 A = frame counter
C $C0B0,5 wrap to 7 bits, store
C $C0B5,3 index from the counter bits
C $C0B8,6 frame = base ((IY+4)) + index
C $C0C4,5 skip unless (IY+2) high bit set
C $C0C9,3 A = (IY+3)
C $C0CC,4 4 or more? go straight to the hit check
C $C0DA,6 IY=player
C $C0E6,2 C=$18 (default trigger)
C $C0E8,5 status ($5C06) past $0F? RET
C $C0EE,3 status non-zero? use the default
C $C0F1,4 flag $A101 set? use the default
C $C0F7,2 else trigger $1A
C $C0F9,4 trigger via #R$AE85
C $C0E0,3 Classify object type ((IX+2)) into a size/category flag
c $C0FD Wrapper: scan tile below feet via #R$A2AC, flag at $C12D
C $C103,3 Scan tile column below feet against solid-tile list ($A24B/$A271), flag
c $C109 Wrapper: scan tile right via #R$A2FA, flag at $C12D
C $C10F,3 Scan tile column right of object (X+23) via #R$A2B2
c $C115 Wrapper: scan tile via #R$A31F, flag at $C131
C $C11B,3 Scan tile at (X+12) against special-tile list ($A242/$A268), flag
c $C121 Wrapper: scan tile below-right via #R$A30B, flag at $C131
C $C127,3 Scan tile below-right of feet (X+12,Y+24) via #R$A328
b $C12D Tile-scan result flags (used by #R$C0FD/#R$C109)
c $C12E Unused/scratch flag bytes (NOP-initialized, $C12E-$C132)
N $C12E Mostly padding, but the $C135 entry point here is real: it stamps an object with its starting position and frame from a template, and is called whenever a creature needs (re)initialising.
C $C12E,1 unused scratch bytes (7 NOPs)
C $C135,4 set gate flag (IY+8)=1
R $C135 IX object to init
R $C135 IY template (position at +4/+5/+6, direction at +7)
C $C139,6 copy X from the template
C $C13F,6 copy Y
C $C145,6 copy the frame
C $C14B,6 copy the direction flag
b $C152 Room data table (12 bytes per room)
N $C152 Room data table. 12 bytes per room, indexed directly by room number (level*12+col, see #R$AEFD), decoded by #R$BE42. Each room has 3 x 4-byte sub-records, one per creature/hazard slot; an all-zero sub-record means the slot is empty. Byte0's low nibble is the creature type ID: $05=Water Drop, $01/$03=Flying Lizard, $07=Tentacles in concrete block. Confirmed live: room $08 has 2 Water Drops, room $12 has 0 creatures, room $14 (start) has a Tentacle-block + a Flying Lizard - matching what's actually seen in-game.
B $C152,12,4 room $00 data
B $C15E,12,4 room $01 data
B $C16A,12,4 room $02 data
B $C176,12,4 room $03 data
B $C182,12,4 room $04 data
B $C18E,12,4 room $05 data
B $C19A,12,4 room $06 data
B $C1A6,12,4 room $07 data
B $C1B2,12,4 room $08 data
B $C1BE,12,4 room $09 data
B $C1CA,12,4 room $0A data
B $C1D6,12,4 room $0B data
B $C1E2,12,4 room $0C data
B $C1EE,12,4 room $0D data
B $C1FA,12,4 room $0E data
B $C206,12,4 room $0F data
B $C212,12,4 room $10 data
B $C21E,12,4 room $11 data
B $C22A,12,4 room $12 data
B $C236,12,4 room $13 data
B $C242,12,4 room $14 data
B $C24E,12,4 room $15 data
B $C25A,12,4 room $16 data
B $C266,12,4 room $17 data
B $C272,12,4 room $18 data
B $C27E,12,4 room $19 data
B $C28A,12,4 room $1A data
B $C296,12,4 room $1B data
B $C2A2,12,4 room $1C data
B $C2AE,12,4 room $1D data
B $C2BA,12,4 room $1E data
B $C2C6,12,4 room $1F data
B $C2D2,12,4 room $20 data
B $C2DE,12,4 room $21 data
B $C2EA,12,4 room $22 data
B $C2F6,12,4 room $23 data
B $C302,12,4 room $24 data
B $C30E,12,4 room $25 data
B $C31A,12,4 room $26 data
B $C326,12,4 room $27 data
B $C332,12,4 room $28 data
B $C33E,12,4 room $29 data
B $C34A,12,4 room $2A data
B $C356,12,4 room $2B data
B $C362,12,4 room $2C data
B $C36E,12,4 room $2D data - portal room, see #R$A66C
B $C37A,12,4 room $2E data - portal room, see #R$A66C
B $C386,12,4 room $2F data - portal room, see #R$A66C
B $C392,12,4 room $30 data
B $C39E,12,4 room $31 data
B $C3AA,12,4 room $32 data
B $C3B6,12,4 room $33 data
B $C3C2,12,4 room $34 data
B $C3CE,12,4 room $35 data
B $C3DA,12,4 room $36 data
B $C3E6,12,4 room $37 data
B $C3F2,12,4 room $38 data
B $C3FE,12,4 room $39 data
B $C40A,12,4 room $3A data
B $C416,12,4 room $3B data
B $C422,12,4 room $3C data
B $C42E,12,4 room $3D data
B $C43A,12,4 room $3E data
B $C446,12,4 room $3F data
B $C452,12,4 room $40 data
B $C45E,12,4 room $41 data
B $C46A,12,4 room $42 data
B $C476,12,4 room $43 data
B $C482,12,4 room $44 data
B $C48E,12,4 room $45 data
c $C4B2 Sound-effect dispatcher wrapper: save regs, call #R$C4BC
N $C4B2 Plays a sound effect by number without disturbing any registers - the generic "make this sound" entry point called from all over the game.
R $C4B2 A sound-effect index (0-6)
C $C4B5,3 Sound-effect table lookup
c $C4BC Sound-effect table lookup ($C55B): push handler address, E=$10, tail-call
N $C4BC Turns a sound-effect number into the address of its player routine and tail-jumps there, so the effect runs as if it had been called directly.
C $C4BC,3 index past 6? RET
C $C4BF,1 index *= 2
C $C4C0,3 HL = index
C $C4C3,4 HL = $C55B + index
C $C4C7,2 DE = handler address
C $C4CA,1 push it as the return address
C $C4CB,2 E=$10 (speaker bit mask)
c $C4CE Beeper tone-sweep effect (raw OUT $FE)
N $C4CE Sweeps the beeper through a falling pitch by halving its delay each pass - a short "whoop" cue rather than a fixed tone.
C $C4CE,2 H=$7F (sweep count)
C $C4D1,2 B=$0A (bit count)
C $C4D4,1 B = H (duty)
C $C4D5,2 toggle beeper
C $C4D7,2 delay
C $C4D9,2 loop duty
C $C4DB,2 flip the speaker bit
C $C4DE,2 loop bits
C $C4E0,4 H >>= 2 (raise the pitch)
C $C4E4,2 H reached 0?
c $C4E9 Play sound effect (raw OUT $FE beeper timing loop)
N $C4E9 A beeper sound-effect player: plays back a sample, then a tone sweep, entirely through timed port writes rather than an interrupt-driven player.
C $C4E9,3 HL=0 (sample pointer)
C $C4EC,3 BC=$2328 (sample count)
C $C4EF,3 delay = $23 - B
C $C4F2,2 zero? no delay
C $C4F5,1 B = delay
C $C4F6,2 busy-wait
C $C4F9,2 read sample byte
C $C4FB,3 mask and send to speaker
C $C4FE,1 BC -= 4 (four DEC BC)
C $C502,2 count exhausted?
C $C506,2 H=3 (sweep count)
C $C509,2 B=$0A (bit count)
C $C50C,1 B = H (duty)
C $C50D,2 toggle speaker
C $C50F,2 delay
C $C511,2 loop duty
C $C513,2 flip the speaker bit
C $C516,2 loop bits
C $C518,3 shift a 1 into H
C $C51B,3 H all ones?
c $C521 Play noise-type sound effect (R-register based)
N $C521 Makes a noise burst by toggling the speaker with bits taken from low ROM ($0000-$003F) at an offset driven by the refresh register - a cheap random source, so the result is hiss rather than a tone.
C $C523,2 A = R (refresh counter, pseudo-random)
C $C525,3 index 0-$3F into low ROM
C $C52A,3 read ROM byte, keep only the speaker bit
c $C532 Beeper tone effect variant A (HL=$03C8), falls into #R$C53A
c $C537 Beeper tone effect variant B (HL=$0564)
N $C537 Plays a fixed-pitch beep by toggling the speaker on a timed loop - the longer-period twin of #R$C532.
C $C537,3 HL=$0564 (tone period)
C $C53A,2 A=0, B = period
C $C53C,2 speaker low
C $C53E,2 busy-wait
C $C540,3 speaker high
C $C543,1 B = period again
C $C544,3 busy-wait delay
C $C547,2 loop until H runs out
b $C54A
c $C54B Beeper noise/sample effect (raw OUT $FE)
N $C54B Plays a short noise burst by streaming bytes straight to the speaker port, used for impact-type effects.
C $C54B,2 timing pad (two NOPs)
C $C54D,1 B = outer count
C $C54E,2 C=5 (inner count)
C $C550,2 read a sample byte, mask it
C $C552,2 send it to the speaker
C $C554,2 advance, count down
C $C556,2 loop 5 bytes
C $C558,2 loop the outer count
b $C55B Sound-effect handler address table (7 entries, used by #R$C4BC)
W $C55B,14,2
b $C600 Back-tile definition table (16 bytes per back-tile)
B $C600,16 Back tile $00 tiles
B $C610,16 Back tile $01 tiles
B $C620,16 Back tile $02 tiles
B $C630,16 Back tile $03 tiles
B $C640,16 Back tile $04 tiles
B $C650,16 Back tile $05 tiles
B $C660,16 Back tile $06 tiles
B $C670,16 Back tile $07 tiles
B $C680,16 Back tile $08 tiles
B $C690,16 Back tile $09 tiles
B $C6A0,16 Back tile $0A tiles
B $C6B0,16 Back tile $0B tiles
B $C6C0,16 Back tile $0C tiles
B $C6D0,16 Back tile $0D tiles
B $C6E0,16 Back tile $0E tiles
B $C6F0,16 Back tile $0F tiles
B $C700,16 Back tile $10 tiles
B $C710,16 Back tile $11 tiles
B $C720,16 Back tile $12 tiles
B $C730,16 Back tile $13 tiles
B $C740,16 Back tile $14 tiles
B $C750,16 Back tile $15 tiles
B $C760,16 Back tile $16 tiles
B $C770,16 Back tile $17 tiles
B $C780,16 Back tile $18 tiles
B $C790,16 Back tile $19 tiles
B $C7A0,16 Back tile $1A tiles
B $C7B0,16 Back tile $1B tiles
B $C7C0,16 Back tile $1C tiles
B $C7D0,16 Back tile $1D tiles
B $C7E0,16 Back tile $1E tiles
B $C7F0,16 Back tile $1F tiles
B $C800,16 Back tile $20 tiles
B $C810,16 Back tile $21 tiles
B $C820,16 Back tile $22 tiles
B $C830,16 Back tile $23 tiles
B $C840,16 Back tile $24 tiles
B $C850,16 Back tile $25 tiles
B $C860,16 Back tile $26 tiles
B $C870,16 Back tile $27 tiles
B $C880,16 Back tile $28 tiles
B $C890,16 Back tile $29 tiles
B $C8A0,16 Back tile $2A tiles
B $C8B0,16 Back tile $2B tiles
B $C8C0,16 Back tile $2C tiles
B $C8D0,16 Back tile $2D tiles
B $C8E0,16 Back tile $2E tiles
B $C8F0,16 Back tile $2F tiles
B $C900,16 Back tile $30 tiles
B $C910,16 Back tile $31 tiles
B $C920,16 Back tile $32 tiles
B $C930,16 Back tile $33 tiles
B $C940,16 Back tile $34 tiles
B $C950,16 Back tile $35 tiles
B $C960,16 Back tile $36 tiles
B $C970,16 Back tile $37 tiles
B $C980,16 Back tile $38 tiles
B $C990,16 Back tile $39 tiles
B $C9A0,16 Back tile $3A tiles
B $C9B0,16 Back tile $3B tiles
B $C9C0,16 Back tile $3C tiles
B $C9D0,16 Back tile $3D tiles
B $C9E0,16 Back tile $3E tiles
B $C9F0,16 Back tile $3F tiles
B $CA00,16 Back tile $40 tiles
B $CA10,16 Back tile $41 tiles
B $CA20,16 Back tile $42 tiles
B $CA30,16 Back tile $43 tiles
B $CA40,16 Back tile $44 tiles
B $CA50,16 Back tile $45 tiles
B $CA60,16 Back tile $46 tiles
B $CA70,16 Back tile $47 tiles
B $CA80,16 Back tile $48 tiles
B $CA90,16 Back tile $49 tiles
B $CAA0,16 Back tile $4A tiles
B $CAB0,16 Back tile $4B tiles
B $CAC0,16 Back tile $4C tiles
B $CAD0,16 Back tile $4D tiles
B $CAE0,16 Back tile $4E tiles
B $CAF0,16 Back tile $4F tiles
B $CB00,16 Back tile $50 tiles
B $CB10,16 Back tile $51 tiles
B $CB20,16 Back tile $52 tiles
B $CB30,16 Back tile $53 tiles
B $CB40,16 Back tile $54 tiles
B $CB50,16 Back tile $55 tiles
B $CB60,16 Back tile $56 tiles
B $CB70,16 Back tile $57 tiles
B $CB80,16 Back tile $58 tiles
B $CB90,16 Back tile $59 tiles
B $CBA0,16 Back tile $5A tiles
B $CBB0,16 Back tile $5B tiles
B $CBC0,16 Back tile $5C tiles
B $CBD0,16 Back tile $5D tiles
B $CBE0,16 Back tile $5E tiles
B $CBF0,16 Back tile $5F tiles
B $CC00,16 Back tile $60 tiles
B $CC10,16 Back tile $61 tiles
B $CC20,16 Back tile $62 tiles
B $CC30,16 Back tile $63 tiles
B $CC40,16 Back tile $64 tiles
B $CC50,16 Back tile $65 tiles
B $CC60,16 Back tile $66 tiles
B $CC70,16 Back tile $67 tiles
B $CC80,16 Back tile $68 tiles
B $CC90,16 Back tile $69 tiles
B $CCA0,16 Back tile $6A tiles
B $CCB0,16 Back tile $6B tiles
B $CCC0,16 Back tile $6C tiles
B $CCD0,16 Back tile $6D tiles
B $CCE0,16 Back tile $6E tiles
B $CCF0,16 Back tile $6F tiles
B $CD00,16 Back tile $70 tiles
B $CD10,16 Back tile $71 tiles
B $CD20,16 Back tile $72 tiles
B $CD30,16 Back tile $73 tiles
B $CD40,16 Back tile $74 tiles
B $CD50,16 Back tile $75 tiles
B $CD60,16 Back tile $76 tiles
B $CD70,16 Back tile $77 tiles
B $CD80,16 Back tile $78 tiles
B $CD90,16 Back tile $79 tiles
B $CDA0,16 Back tile $7A tiles
B $CDB0,16 Back tile $7B tiles
B $CDC0,16 Back tile $7C tiles
B $CDD0,16 Back tile $7D tiles
B $CDE0,16 Back tile $7E tiles
B $CDF0,16 Back tile $7F tiles
B $CE00,16 Back tile $80 tiles
B $CE10,16 Back tile $81 tiles
B $CE20,16 Back tile $82 tiles
B $CE30,16 Back tile $83 tiles
B $CE40,16 Back tile $84 tiles
B $CE50,16 Back tile $85 tiles
B $CE60,16 Back tile $86 tiles
B $CE70,16 Back tile $87 tiles
B $CE80,16 Back tile $88 tiles
B $CE90,16 Back tile $89 tiles
B $CEA0,16 Back tile $8A tiles
B $CEB0,16 Back tile $8B tiles
B $CEC0,16 Back tile $8C tiles
B $CED0,16 Back tile $8D tiles
B $CEE0,16 Back tile $8E tiles
B $CEF0,16 Back tile $8F tiles
B $CF00,16 Back tile $90 tiles
B $CF10,16 Back tile $91 tiles
B $CF20,16 Back tile $92 tiles
B $CF30,16 Back tile $93 tiles
B $CF40,16 Back tile $94 tiles
B $CF50,16 Back tile $95 tiles
B $CF60,16 Back tile $96 tiles
B $CF70,16 Back tile $97 tiles
B $CF80,16 Back tile $98 tiles
B $CF90,16 Back tile $99 tiles
B $CFA0,16 Back tile $9A tiles
B $CFB0,16 Back tile $9B tiles
B $CFC0,16 Back tile $9C tiles
B $CFD0,16 Back tile $9D tiles
B $CFE0,16 Back tile $9E tiles
B $CFF0,16 Back tile $9F tiles
B $D000,16 Back tile $A0 tiles
B $D010,16 Back tile $A1 tiles
B $D020,16 Back tile $A2 tiles
B $D030,16 Back tile $A3 tiles
B $D040,16 Back tile $A4 tiles
B $D050,16 Back tile $A5 tiles
B $D060,16 Back tile $A6 tiles
B $D070,16 Back tile $A7 tiles
B $D080,16 Back tile $A8 tiles
B $D090,16 Back tile $A9 tiles
B $D0A0,16 Back tile $AA tiles
B $D0B0,16 Back tile $AB tiles
B $D0C0,16 Back tile $AC tiles
B $D0D0,16 Back tile $AD tiles
B $D0E0,16 Back tile $AE tiles
B $D0F0,16 Back tile $AF tiles
B $D100,16 Back tile $B0 tiles
B $D110,16 Back tile $B1 tiles
B $D120,16 Back tile $B2 tiles
B $D130,16 Back tile $B3 tiles
B $D140,16 Back tile $B4 tiles
B $D150,16 Back tile $B5 tiles
B $D160,16 Back tile $B6 tiles
B $D170,16 Back tile $B7 tiles
B $D180,16 Back tile $B8 tiles
B $D190,16 Back tile $B9 tiles
B $D1A0,16 Back tile $BA tiles
B $D1B0,16 Back tile $BB tiles
B $D1C0,16 Back tile $BC tiles
B $D1D0,16 Back tile $BD tiles
B $D1E0,16 Back tile $BE tiles
B $D1F0,16 Back tile $BF tiles
B $D200,16 Back tile $C0 tiles
B $D210,16 Back tile $C1 tiles
B $D220,16 Back tile $C2 tiles
B $D230,16 Back tile $C3 tiles
B $D240,16 Back tile $C4 tiles
B $D250,16 Back tile $C5 tiles
B $D260,16 Back tile $C6 tiles
B $D270,16 Back tile $C7 tiles
B $D280,16 Back tile $C8 tiles
B $D290,16 Back tile $C9 tiles
B $D2A0,16 Back tile $CA tiles
B $D2B0,16 Back tile $CB tiles
B $D2C0,16 Back tile $CC tiles
B $D2D0,16 Back tile $CD tiles
B $D2E0,16 Back tile $CE tiles
B $D2F0,16 Back tile $CF tiles
B $D300,16 Back tile $D0 tiles
B $D310,16 Back tile $D1 tiles
B $D320,16 Back tile $D2 tiles
B $D330,16 Back tile $D3 tiles
B $D340,16 Back tile $D4 tiles
B $D350,16 Back tile $D5 tiles
B $D360,16 Back tile $D6 tiles
B $D370,16 Back tile $D7 tiles
B $D380,16 Back tile $D8 tiles
B $D390,16 Back tile $D9 tiles
B $D3A0,16 Back tile $DA tiles
B $D3B0,16 Back tile $DB tiles
B $D3C0,16 Back tile $DC tiles
B $D3D0,16 Back tile $DD tiles
B $D3E0,16 Back tile $DE tiles
B $D3F0,16 Back tile $DF tiles
B $D400,16 Back tile $E0 tiles
B $D410,16 Back tile $E1 tiles
B $D420,16 Back tile $E2 tiles
B $D430,16 Back tile $E3 tiles
B $D440,16 Back tile $E4 tiles
B $D450,16 Back tile $E5 tiles
B $D460,16 Back tile $E6 tiles
B $D470,16 Back tile $E7 tiles
B $D480,16 Back tile $E8 tiles
B $D490,16 Back tile $E9 tiles
B $D4A0,16 Back tile $EA tiles
B $D4B0,16 Back tile $EB tiles
B $D4C0,16 Back tile $EC tiles
B $D4D0,16 Back tile $ED tiles
B $D4E0,16 Back tile $EE tiles
B $D4F0,16 Back tile $EF tiles
B $D500,16 Back tile $F0 tiles
B $D510,16 Back tile $F1 tiles
B $D520,16 Back tile $F2 tiles
B $D530,16 Back tile $F3 tiles
B $D540,16 Back tile $F4 tiles
B $D550,16 Back tile $F5 tiles
B $D560,16 Back tile $F6 tiles
B $D570,16 Back tile $F7 tiles
B $D580,16 Back tile $F8 tiles
B $D590,16 Back tile $F9 tiles
B $D5A0,16 Back tile $FA tiles
B $D5B0,16 Back tile $FB tiles
B $D5C0,16 Back tile $FC tiles
B $D5D0,16 Back tile $FD tiles
B $D5E0,16 Back tile $FE tiles
B $D5F0,16 Back tile $FF tiles
N $C600 Back-tile definition table. 16 bytes per back-tile, indexed by back-tile index (see #R$D600): a 4x4 arrangement of 8x8 "tile" indices, expanded by #R$9914 into the room's tile-index map at $F800.
b $D600 Room back tiles
N $D600 Per-room back-tile index table. 32 bytes per room (8x4 back-tiles, each 32x32px), indexed directly by room number, decoded by #R$9914 into the room's expanded tile-index map at $F800 (32x16 8x8 tiles), each back-tile index looked up in the definition table at $C600.
B $D600,32 #HTML[<img src="images/rooms/room-00.png" />] room $00
B $D620,32 #HTML[<img src="images/rooms/room-01.png" />] room $01
B $D640,32 #HTML[<img src="images/rooms/room-02.png" />] room $02
B $D660,32 #HTML[<img src="images/rooms/room-03.png" />] room $03
B $D680,32 #HTML[<img src="images/rooms/room-04.png" />] room $04
B $D6A0,32 #HTML[<img src="images/rooms/room-05.png" />] room $05
B $D6C0,32 #HTML[<img src="images/rooms/room-06.png" />] room $06
B $D6E0,32 #HTML[<img src="images/rooms/room-07.png" />] room $07
B $D700,32 #HTML[<img src="images/rooms/room-08.png" />] room $08
B $D720,32 #HTML[<img src="images/rooms/room-09.png" />] room $09
B $D740,32 #HTML[<img src="images/rooms/room-0A.png" />] room $0A
B $D760,32 #HTML[<img src="images/rooms/room-0B.png" />] room $0B
B $D780,32 #HTML[<img src="images/rooms/room-0C.png" />] room $0C
B $D7A0,32 #HTML[<img src="images/rooms/room-0D.png" />] room $0D
B $D7C0,32 #HTML[<img src="images/rooms/room-0E.png" />] room $0E
B $D7E0,32 #HTML[<img src="images/rooms/room-0F.png" />] room $0F
B $D800,32 #HTML[<img src="images/rooms/room-10.png" />] room $10
B $D820,32 #HTML[<img src="images/rooms/room-11.png" />] room $11
B $D840,32 #HTML[<img src="images/rooms/room-12.png" />] room $12
B $D860,32 #HTML[<img src="images/rooms/room-13.png" />] room $13
B $D880,32 #HTML[<img src="images/rooms/room-14.png" />] room $14
B $D8A0,32 #HTML[<img src="images/rooms/room-15.png" />] room $15
B $D8C0,32 #HTML[<img src="images/rooms/room-16.png" />] room $16
B $D8E0,32 #HTML[<img src="images/rooms/room-17.png" />] room $17
B $D900,32 #HTML[<img src="images/rooms/room-18.png" />] room $18
B $D920,32 #HTML[<img src="images/rooms/room-19.png" />] room $19
B $D940,32 #HTML[<img src="images/rooms/room-1A.png" />] room $1A
B $D960,32 #HTML[<img src="images/rooms/room-1B.png" />] room $1B
B $D980,32 #HTML[<img src="images/rooms/room-1C.png" />] room $1C
B $D9A0,32 #HTML[<img src="images/rooms/room-1D.png" />] room $1D
B $D9C0,32 #HTML[<img src="images/rooms/room-1E.png" />] room $1E
B $D9E0,32 #HTML[<img src="images/rooms/room-1F.png" />] room $1F
B $DA00,32 #HTML[<img src="images/rooms/room-20.png" />] room $20
B $DA20,32 #HTML[<img src="images/rooms/room-21.png" />] room $21
B $DA40,32 #HTML[<img src="images/rooms/room-22.png" />] room $22
B $DA60,32 #HTML[<img src="images/rooms/room-23.png" />] room $23
B $DA80,32 #HTML[<img src="images/rooms/room-24.png" />] room $24
B $DAA0,32 #HTML[<img src="images/rooms/room-25.png" />] room $25
B $DAC0,32 #HTML[<img src="images/rooms/room-26.png" />] room $26
B $DAE0,32 #HTML[<img src="images/rooms/room-27.png" />] room $27
B $DB00,32 #HTML[<img src="images/rooms/room-28.png" />] room $28
B $DB20,32 #HTML[<img src="images/rooms/room-29.png" />] room $29
B $DB40,32 #HTML[<img src="images/rooms/room-2A.png" />] room $2A
B $DB60,32 #HTML[<img src="images/rooms/room-2B.png" />] room $2B
B $DB80,32 #HTML[<img src="images/rooms/room-2C.png" />] room $2C
B $DBA0,32 #HTML[<img src="images/rooms/room-2D.png" />] room $2D
B $DBC0,32 #HTML[<img src="images/rooms/room-2E.png" />] room $2E
B $DBE0,32 #HTML[<img src="images/rooms/room-2F.png" />] room $2F
B $DC00,32 #HTML[<img src="images/rooms/room-30.png" />] room $30
B $DC20,32 #HTML[<img src="images/rooms/room-31.png" />] room $31
B $DC40,32 #HTML[<img src="images/rooms/room-32.png" />] room $32
B $DC60,32 #HTML[<img src="images/rooms/room-33.png" />] room $33
B $DC80,32 #HTML[<img src="images/rooms/room-34.png" />] room $34
B $DCA0,32 #HTML[<img src="images/rooms/room-35.png" />] room $35
B $DCC0,32 #HTML[<img src="images/rooms/room-36.png" />] room $36
B $DCE0,32 #HTML[<img src="images/rooms/room-37.png" />] room $37
B $DD00,32 #HTML[<img src="images/rooms/room-38.png" />] room $38
B $DD20,32 #HTML[<img src="images/rooms/room-39.png" />] room $39
B $DD40,32 #HTML[<img src="images/rooms/room-3A.png" />] room $3A
B $DD60,32 #HTML[<img src="images/rooms/room-3B.png" />] room $3B
B $DD80,32 #HTML[<img src="images/rooms/room-3C.png" />] room $3C
B $DDA0,32 #HTML[<img src="images/rooms/room-3D.png" />] room $3D
B $DDC0,32 #HTML[<img src="images/rooms/room-3E.png" />] room $3E
B $DDE0,32 #HTML[<img src="images/rooms/room-3F.png" />] room $3F
B $DE00,32 #HTML[<img src="images/rooms/room-40.png" />] room $40
B $DE20,32 #HTML[<img src="images/rooms/room-41.png" />] room $41
B $DE40,32 #HTML[<img src="images/rooms/room-42.png" />] room $42
B $DE60,32 #HTML[<img src="images/rooms/room-43.png" />] room $43
B $DE80,32 #HTML[<img src="images/rooms/room-44.png" />] room $44
B $DEA0,32 #HTML[<img src="images/rooms/room-45.png" />] room $45
b $DF00 Tile index -> attribute byte table
N $DF00 256 bytes, one per possible tile index (0-255). Looked up directly by tile index (A + $DF00, no multiply) by #R$99A4 to get the color attribute written to the attribute file when blitting a room's tile map ($F800) to the screen.
N $E000 Border-frame graphic (top/bottom pieces), blitted by #R$93AF via #R$94B0
b $E000 Menu border-frame graphic
b $E800 Saved menu background attributes (256 bytes)
b $E82D
b $E8F2 Additional 24x24 sprites
N $E930 Sprite 24x24 ??
B $E930,72,8 #HTML[#UDGARRAY3($E930-$E977-24-8){0,0,48,48}(sprite-E930)]
N $E978 Sprite 24x24
B $E978,72,8 #HTML[#UDGARRAY3($E978-$E9BF-24-8){0,0,48,48}(sprite-E978)]
N $E9C0 Sprite 24x24
B $E9C0,72,8 #HTML[#UDGARRAY3($E9C0-$EA07-24-8){0,0,48,48}(sprite-E9C0)]
N $EA08 Sprite 24x24
B $EA08,72,8 #HTML[#UDGARRAY3($EA08-$EA4F-24-8){0,0,48,48}(sprite-EA08)]
N $EA50 Sprite 24x24
B $EA50,72,8 #HTML[#UDGARRAY3($EA50-$EA97-24-8){0,0,48,48}(sprite-EA50)]
N $EA98 Sprite 24x24 Captured by Snake phase 1
B $EA98,72,8 #HTML[#UDGARRAY3($EA98-$EADF-24-8){0,0,48,48}(sprite-EA98)]
N $EAE0 Sprite 24x24 Captured by Snake phase 2
B $EAE0,72,8 #HTML[#UDGARRAY3($EAE0-$EB27-24-8){0,0,48,48}(sprite-EAE0)]
N $EB28 Sprite 24x24 Captured by Snake phase 3
B $EB28,72,8 #HTML[#UDGARRAY3($EB28-$EB6F-24-8){0,0,48,48}(sprite-EB28)]
N $EB70 Sprite 24x24
B $EB70,72,8 #HTML[#UDGARRAY3($EB70-$EBB7-24-8){0,0,48,48}(sprite-EB70)]
N $EBB8 Sprite 24x24
B $EBB8,72,8 #HTML[#UDGARRAY3($EBB8-$EBFF-24-8){0,0,48,48}(sprite-EBB8)]
N $EC00 Sprite 24x24
B $EC00,72,8 #HTML[#UDGARRAY3($EC00-$EC47-24-8){0,0,48,48}(sprite-EC00)]
N $EC48 Sprite 24x24
B $EC48,72,8 #HTML[#UDGARRAY3($EC48-$EC8F-24-8){0,0,48,48}(sprite-EC48)]
b $F000 Tile pixel bitmap table
N $F000 8 bytes per tile index, at ($5B72)+tile_index*8 (5B72=$F000, set by #R$8F47). Copied to the real screen by #R$99A4 when blitting a room's tile map ($F800) - this is the actual pixel data for the 8x8 "tiles" that make up a room's back-tiles.
b $F800 Room tile-index map (32x16, rebuilt per room by #R$9914)
t $F8AD
b $F8B2
t $F8BB
b $F8C0
t $F8CD
b $F8E0
t $F975
b $F97A
t $F9DC
b $F9E0
t $FAC9
b $FAD0
t $FB23
b $FB28
t $FB55
b $FB59
t $FB80
b $FB85
t $FC1A
b $FC1F
t $FC4B
b $FC50
t $FC98
b $FC9D
t $FCDA
b $FCE0
t $FCF0
b $FCF8
t $FD08
b $FD10
t $FD64
b $FD68 Sprite blend mask table region (see $FF00)
N $FF00 Sprite blend mask table, used by #R$9DE3
