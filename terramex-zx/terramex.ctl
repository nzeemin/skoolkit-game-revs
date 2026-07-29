@ $5B00 start
@ $5B00 org
b $5B00
B $5B04,2 Player X (IX+0) / Y (IX+1) sub-position within the room
N $5B06 Purpose unconfirmed. Reset to 0 at init (#R$8F47); set to $7F in the game-over sequence (#R$9372); saved/restored across respawn by #R$9090.
B $5B06,2 Purpose unconfirmed (see note)
B $5B72,2 Screen/buffer base pointer, set to $F000 by #R$8F47
N $5B7C Inventory: sequential item-pickup log, one byte per collected item (index into the $8400 sprite table, i.e. (addr-$8400)/72). $FF = slot not yet used. The last non-$FF entry is the item currently carried. Cleared to $FF by #R$8F47.
B $5B7C,26 item pickup order (index into $8400 sprite table), $FF=empty
B $5B97,1 Lives counter (see the Infinite Lives POKE at #R$A9EE)
B $5B9B,1 Flag: $FF at init, $FE set on respawn (#R$9090)
N $5B9E "Last room #R$AF81 ran for" - compared against the live room ($5C01) each frame; when they differ, the room-entry trigger fires once. Also restored by the respawn handler (#R$9090).
B $5B9E,2 Room #R$AF81 last ran for (see note)
B $5BA0,1 Frame-active flag, set to 1 each iteration of the main loop (#R$9018)
b $5BFB
N $5BFB Asteroid-collision countdown timer shown on the telescope screen: 3 bytes, plain binary (not BCD).
B $5BFB,3 Days, Hours, Minutes to collision
B $5BFF,1 Game-over flag, checked each frame by #R$9018
B $5C01,1 Current room number: level*12 + col (#R$AEEF/#R$AEFD)
B $5C02,1 Frame counter, incremented each iteration of the main loop (#R$9018)
B $5C05,1 Zeroed on respawn (#R$9090); purpose unconfirmed
N $5C06 Hero status/trigger code - NOT the hazard timer (that's $5C07). Single choke point is #R$AE84/#R$AE85 (LD A,code; JP here), which also zeroes $5C07 every time a new status is entered. Known values, all inferred from call-site context - none confirmed against the on-screen animation/sprite yet: 0=normal/idle (the common reset value); 1 (#R$A564); 2 (#R$A476, gates #R$9A09 and the #R$BB5D item-pickup snap); 4 (#R$A42D); 5=item-pickup snap-to-object (#R$BBC1); 6=seesaw active (#R$BC73/#R$BCB4); 7 (#R$AF60, #R$AC97, room-dependent alt of 8); 8/9 (#R$AC90/#R$ACC0, mutually exclusive by room); $0D=special zone, player snapped to X=$1E (#R$AF7D, gates #R$B704's trigger); $11=stood on hazard tile ($BC/$BD) too long (#R$A15C); $12=creature-trap trigger (#R$AAF0); $13/$14=special-zone up/down input (#R$AFC1/#R$AFCC); $15 (#R$B45A); $17=generic cutscene/event trigger, reused by 3 unrelated sites (#R$A90B, #R$B526, #R$B796); $18 (#R$9255); $1A (#R$A12D, also the port-$FBFE ENTER-key path via #R$B02E which actually stores $0A not $1A - two different trigger codes on similar-looking key checks); $1B (#R$B704/#R$B71E); $1C (#R$B3A1). Restored on respawn from $5C2B (#R$9090).
B $5C06,1 Hero status/trigger code (see note) - NOT the hazard timer
B $5C07,1 Per-room hazard counter, incremented by #R$A9EE; restored on respawn from $5C2C
B $5C2A,10 Respawn staging: pending flag ($5C2A), then saved $5C06/$5C07/$5C01/$5B04/$5B06/$5B9E, restored by #R$9090
t $5CC4
b $5CCA
t $5CDC
b $5CE2
t $5CE8
b $5CED
t $5CF5
b $5CFB
t $5D01
b $5D04
t $5DBE
b $5DD6
t $5E13
b $5E1C
c $5F5F Tail jump to #R$9491
C $5F5F,3 => Interrupt handler
b $5F62
t $5FDC
b $5FDF
c $5FE6 Unreferenced: OUT (C),A; RET (no known caller)
c $5FE9 Unreferenced: port write pair, self-modifies ($5FE5) (no known caller)
b $5FFB
t $611F
b $6123
t $6127
b $612B
t $612F
b $6133
t $6137
b $613B
t $613F
b $6143
t $6147
b $614B
t $621A
b $621D
t $623F
b $6242
t $626B
b $626E
t $6335
b $6338
t $6352
b $6355
t $63F1
b $63F5
t $640B
b $640E
t $6577
b $657B
t $65BA
b $65BD
t $6860
b $6865
t $6874
b $6878
t $6879
b $6889
t $6A4B
b $6A52
t $6A7C
b $6A83
t $6AA0
b $6AA7
t $6AC3
b $6AC8
t $6ACD
b $6AD0
t $6AD3
b $6AD6
t $6ADB
b $6AE0
t $6AE3
b $6AE6
t $6AE9
b $6AEC
t $6C32
b $6C35
t $6C38
b $6C3B
t $6C3E
b $6C41
t $6C4A
b $6C4D
t $6CE2
b $6CE5
t $6CE8
b $6CEB
t $6CEE
b $6CF1
t $6CFA
b $6CFD
t $71CE
b $71D1
t $7219
b $721C
t $7262
b $726A
t $72AA
b $72B2
t $72F2
b $72FA
t $7303
b $7306
t $733A
b $7342
t $73B8
b $73BC
t $73BE
b $73C1
t $7436
b $743A
t $75AF
b $75B3
t $798D
b $7990
t $7A46
b $7A4A
t $7B01
b $7B06
t $7B99
b $7B9C
t $7BC9
b $7BCC
t $7C3C
b $7C41
t $7C54
b $7C57
t $7C86
b $7C8B
t $7C9E
b $7CA1
t $7CCE
b $7CD3
t $7CE6
b $7CE9
t $7D14
b $7D19
t $7D2C
b $7D2F
t $7D63
b $7D66
t $7D92
b $7D9B
t $7DDB
b $7DE3
t $7F48
b $7F4C
t $7F8F
b $7F95
t $8034
b $8037
t $8054
b $8058
t $80A2
b $80A5
t $8174
b $8178
t $81A2
b $81A5
t $81BC
b $81C0
t $82B7
b $82BB
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
b $8D00
b $8F39
c $8F47 Show main menu, then initialize game state
N $8F47 After #R$93AF returns (device chosen, "0" pressed): pages in a helper 128K bank to run a setup routine at $C000 if needed, clears game variable tables, resets item/collision flags, blits the background graphic ($E000 -> $5000, one screen third + extra strip), sets up pointers/counters, clears the object-state table at $5BFA, sets the level data pointer ($5C25=$6070, $5C27=$0F, purpose unconfirmed - not total room count, game has 66+ rooms), then redraws the screen before falling through into the main game loop at $9018 (per-frame updates, respawn-in-room handling via $9090 after a life is lost, and game-over exit back to this same routine via $906D/$908D).
C $8F47,3 Main menu
C $8F4A,6 128K: check paging flag $5FFE
C $8F50,25 128K: page in bank, call $C000, restore paging
C $8F69,11 clear $5B04-$5B66 (99 bytes)
C $8F76,11 clear inventory ($5B7C-$5B95, 26 bytes) to $FF
C $8F83,8 Clear active flag (bit7) across all $B99D creature-table entries
C $8F8B,11 copy background $E000 -> $5000 (one screen third)
C $8F96,8 copy extra strip to $5A00
C $8F9E,6 buffer base pointer ($5B72)=$F000
C $8FA4,22 reset sentinels/counters to $FF; $A6F5=7 (per-room tuning value, overridden to 6 for room $10 by #R$9880; not lives - lives is $5B97 per the Infinite Lives POKE)
C $8FBA,4 reset counter $5B06
C $8FBE,12 clear object-state table at $5BFA (147 bytes)
C $8FCC,3 Save all registers
C $8FCF,11 level data ptr=$6070, $5C27=$0F (not room count, game has 66+ rooms per player map - unconfirmed)
C $8FE0,5 attr=$14
C $8FE5,3 Set up the current room
C $8FE8,3 Init $5BD6 object slots from $5C23
C $8FED,3 set Lives counter
C $8FF0,3 Draw lives-count icons ($5B97) into $5BD6 slots
C $9012,3 Snapshot current room/position into respawn staging
C $9015,3 Populate the $5BD6 object-slot table
C $9018,5 main game loop entry: mark frame active ($5BA0=1)
C $901D,14 IX=player state ($5B04); room-entry trigger if $5C01 != $5B9E (#R$AF81)
C $902B,3 Main per-frame player update
C $902E,6 life lost ($5C2A)? -> respawn in same room (#R$9090)
C $9034,15 Per-frame item dispatcher
C $9043,6 game-over flag ($5BFF) set? -> exit to #R$906D
C $9049,16 increment frame counter ($5C02); check key (row $FBFE), loop if held
C $9059,20 check key combo (possible pause), else loop back to #R$9018
C $906D,3 New high-score check
C $9070,22 restore menu background buffers ($5000 -> $E000, $5A00 -> $E800)
C $9086,7 optional cleanup call (#R$918D)
N $9090 Respawn handler, entered from #R$9018 when the hazard timer (#R$A9EE) has just cost a life. Restores the player/room state saved in $5C2B-$5C32 (captured on room entry, likely by #R$AF81) back into the live variables, so the player restarts in the same room rather than switching rooms. Only writer of $5C2A other than #R$A9EE is this routine, clearing it as the first step.
C $9090,4 respawn after life lost: clear pending flag ($5C2A)
C $9094,39 restore saved player/room state from staging fields ($5C2B-$5C32) into live vars ($5C05-07, $5B04, $5B06, $5C01, $5B9E)
C $90BB,3 Set up the current room
C $90BE,5 $5B9B=$FE (respawn marker)
C $90C3,3 => main game loop
C $908D,3 => Show main menu, then initialize game state
c $90C6 Draw character bitmap
N $90C6 Font table at $3C00, 8 bytes/char. DE is used as scratch and restored, unaffected.
R $90C6 A char code
R $90C6 HL screen address
R $90C6 O:HL HL+1 (next column)
C $90CA,10 HL = font base + char*8
C $90D6,6 copy 8 bytes to screen, one row down each
C $90DF,1 advance to next column
b $90E1
b $90E7
b $910C
c $9140 Classify object type ((IX+2)) into a size/category flag (C)
R $9140 IX first object (position at +0/+1, type at +2)
R $9140 IY second object (position at +0/+1)
R $9140 O:Cf set if both X and Y are within threshold
C $9140,6 default threshold C=$10
C $9146,10 type $5C-$5F: use threshold $08 instead
C $9150,10 |X delta| = (IX+0)-(IY+0)
C $915A,3 X within threshold? else skip Y check
C $915D,10 |Y delta| = (IX+1)-(IY+1)
C $9167,3 Y within threshold -> result in carry
b $916A
c $917C Init $5B0A/$5B0E/$5B12/$5B16 to $007F
s $918C
c $918D Swap music data buffers, toggling the music flag ($918C)
C $918D,13 save flag; HL/DE = swap region 1 ($FA00/$F400, 1024 bytes)
C $919A,14 swap loop (byte-by-byte)
C $91A8,8 HL/DE = swap region 2 ($C580/$DF80, 128 bytes)
C $91B9,7 flip and store the music flag
c $91C0 Draw sparkle/flicker effect list at $9AD5 (music-off variant)
N $91C0 Iterates a 2-entry outer list at $9AD5 (per-slot pointer to a variable-length command list, terminated by a zero word); each command is a (attribute-coords, tile-coords) pair. For each command: picks one of 4 pre-baked 8-byte tile patterns from $933D (indexed by the frame counter AND 3) and copies it into the pixel buffer at $F5A8, draws it at the attribute-derived screen position via #R$9A52, then XORs a byte at the drawn location with data from R-register noise (AND 1, doubled via RRCA) - the flicker/sparkle effect. This is the variant used when music is off; #R$92BD is the music-on twin (different source list at $9AE5, different draw primitive #R$92D6/#R$9A4D). Likely drives the animated background sparkle seen in some rooms (water drips, glinting objects) rather than anything creature- or hero-related.
C $91C0,12 B=2 outer slots; HL=$9AD5 (pointer list); music-on -> #R$9208 variant
C $91CC,10 save BC; DE=(HL) pointer, HL+=2 (save next); skip if DE=0
C $91D6,1 EXX
C $91DA,21 pick anim-frame source ($933D+frame*8), copy 8 bytes to $F5A8
C $91EF,4 EX DE,HL; save HL; A=$B5 (draw byte)
C $91F6,5 restore HL; advance by $6000 (secondary buffer)
C $91FB,8 R-register XOR flicker of screen byte at HL
C $9203,5 restore regs; loop 2 outer slots; RET
C $9208,20 music-on entry: fetch DE/BC coord-pair from list, RET Z if null
C $921C,26 compute attribute-row bytes D/B from coords via bit tricks
C $9236,1 restore HL (coord Y)
C $923A,3 BC=HL (save); restore HL (coord X)
C $9240,21 bounds-check position against player, room/hazard-timer trigger prep
C $9255,16 further bound check; room/hazard-timer check; trigger $18 via #R$AE85
C $9265,17 EXX; R-register flicker write to two attribute rows
C $9276,12 advance DE; compare against BC; loop or restart list
C $9282,12 pick tile index from frame counter (XOR $03 sometimes)
C $928E,11 compute tile source addr ($92FD+index*16)
C $9299,6 DE=$F460 (dest); BC=$10 (count)
C $929F,2 LDIR (copy 16 bytes)
C $92A1,3 DE=$9AE5 (coords list, music-on variant)
C $92A4,8 load coords (L,H) from DE; RET Z if null
C $92AC,4 save DE/HL; A=$8C (draw byte)
C $92B3,4 restore HL, HL++; A=$8D (draw byte)
C $92BA,3 restore DE; loop
C $91D7,3 get Frame counter
C $91F3,3 Write A to (HL)+$6000 (secondary buffer), then #R$9A62 dual-write loop
C $9237,3 Convert HL to attribute address
C $923D,3 Convert HL to attribute address
C $9282,3 get Frame counter
C $92B0,3 Write A to (HL), DE=HL, fall into #R$9A62 dual-write loop
C $92B7,3 Write A to (HL), DE=HL, fall into #R$9A62 dual-write loop
c $92BD Draw sparkle/effect list at $9AE5, music-on variant, via #R$92D6
C $92CD,3 Convert HL to screen bitmap address
C $92D1,3 Convert HL to screen bitmap address
c $92D6 Convert HL to screen bitmap address
R $92D6 HL source address (in $E0xx buffer)
R $92D6 O:HL/DE restored (preserved via stack)
C $92D6,2 save DE/HL
C $92D8,9 D = (H AND 3)<<3 OR $40 (dest third)
C $92E1,3 H = same value OR $E0 (source, $E0xx buffer)
C $92E4,3 E=L; B=8 (rows)
C $92E7,6 copy byte HL->DE, both +=$100 (next line); loop
C $92ED,3 restore DE/HL; RET
c $92F0 Convert HL to attribute address (variant)
R $92F0 HL screen address
R $92F0 O:HL attribute address (same third)
C $92F0,7 H=(H AND 3)<<3 (row bits)
C $92F7,6 H=(H<<3) (finish row shift); RET
b $92FD
c $935D Countdown timer ($5BFD/$5BFC/$5BFB); expiry warps to room $28, triggers hazard
C $935D,7 HL=$5BFD; DEC minutes; expired?
C $9364,7 reset minutes=$3B; DEC hours; expired?
C $936B,7 reset hours=$17; DEC days; expired?
C $9372,7 set $5B06=$7F (game-over flag); room=$28
C $9379,3 set Current room number
C $937C,3 Set up the current room
C $937F,9 respawn stage=$28; clear $5C2C; A=$1D
C $9388,8 store $5C2B; trigger via #R$AE85
c $9390 Pseudo-random byte: R register mixed with $93AD/$8F47 stride table
C $9390,2 save HL/DE
C $9392,6 HL=pointer ($93AD); DE=(L<<8)
C $9398,5 HL+=DE (hash mix); DE=$0029; HL+=DE again
C $939D,5 store new pointer ($93AD); H=0
C $93A2,4 DE=$8F47; HL+=DE (stride table base)
C $93A6,7 A = R XOR H, +L (mix in R register); restore DE/HL; RET
b $93AD
c $93AF Main menu: draw title screen, print input-device options, read selection
N $93AF #HTML[<img src="images/scr/Menu.png" />]
N $93AF Clears screen+attrs, blits the green border-frame graphic: top/bottom pieces from $E000/$E0E0 (#R$94B0), then left/right pieces (#R$94C2), draws a colored frame (per-cell attr $46 write), then prints the device options ("1 : KEYBOARD" via #R$94EF, "2 : KEMPSTON" via #R$94F9). Main loop draws a highlight bar over the option matching ($94AF) and polls keys 1/2/3 (port $F7FE) to change it.
C $93D0,3 Fill C bytes with A
C $93DB,3 Fill C bytes with A
C $93DE,9 blit border frame, top piece
C $93E7,9 blit border frame, bottom piece
C $93F3,2 blit border frame, left/right pieces x11
C $93F8,3 Draw left/right piece at HL/DE, then advance to next screen third
C $93FE,3 Draw left/right piece at HL/DE, then advance to next screen third
C $941B,3 Convert screen address to attribute address
C $942D,3 Draw main-menu UI icons/highlight bar into $5BD6 slots
C $9430,3 Print string "1
C $943D,3 Print string from DE at screen HL, attr in AF'
C $9440,16 draw menu box frame (attr $43)
C $9450,24 compute + draw highlight bar for selected option (attr $47)
C $9468,1 wait for next frame
C $9469,11 read keys 1/2/3 (port $F7FE)
C $9474,16 keys 1/2/3 set E=0/1/2
C $9484,4 store selected device
C $9488,9 key '0' (port $EFFE): start game, else loop
c $9491 Interrupt handler: page in 128K bank $16, call music player #R$C000, restore, EI
C $9491,7 save AF; if ($5FFE)=0 skip paging
C $9498,8 page in RAM bank $16 (port $7FFD)
C $94A0,3 CALL music player #R$C000
C $94A3,8 restore bank from ($5FE5) (port $7FFD)
C $94AB,4 restore BC/AF; EI; RET
b $94AF
B $94AF,1 Input device: 0=keyboard, 1=Kempston, 2=Sinclair 2
c $94B0 Blit 32x8 byte block (menu border-frame graphic)
C $94B0,5 B=8 rows; save BC/HL/DE
C $94B5,5 BC=$20; LDIR (copy 32 bytes)
C $94BA,4 restore DE/HL; advance to next row (D++, H++)
C $94BE,4 restore BC; loop 8 rows; RET
N $94B0 Copies 32 bytes per row for 8 rows, advancing both HL and DE down one pixel row each time (plain INC H/INC D, no char-row wrap fixup - source and dest must stay within one screen third).
R $94B0 HL source address
R $94B0 DE destination address
c $94C2 Draw left/right piece at HL/DE, then advance to next screen third
R $94C2 HL left-piece screen address
R $94C2 DE right-piece screen address
R $94C2 O:HL/DE advanced to next screen third
C $94C2,5 draw at HL via #R$94E4
C $94C9,7 L=(L OR $1F) row-end column
C $94D1,6 draw again at row-end via #R$94E4
C $94D8,6 E=(E AND $E0)+$20 (next-third column, carry if wrapped)
C $94DF,4 no wrap: RET; else D+=8 (next third row)
c $94E4 Blit 1x8 byte column (menu border piece)
R $94E4 HL source address
R $94E4 DE destination address
R $94E4 O:HL/DE +8 (next third down)
c $94EF Print string "1 : KEYBOARD"
C $94EF,3 string: "1 : KEYBOARD" (#R$9540)
C $94F2,3 position: row 1, col 8
c $94F9 Print string from DE at screen HL, attr in AF'
R $94F9 DE string address (null-terminated, $0D=newline)
R $94F9 HL screen address
R $94F9 AF' attribute byte
C $94FC,4 read char, stop at 0
C $9500,4 $0D: newline
C $9506,3 Draw character bitmap
C $950B,3 Convert screen address to attribute address
C $950E,2 write attribute
C $9516,3 newline: reload HL
C $951A,3 next char row
b $9525
c $9526 Fill C bytes with A (used for the menu box frame)
R $9526 A fill byte
R $9526 HL start address
R $9526 B row count
R $9526 C bytes per row
C $9526,2 save BC/HL
C $9528,5 fill loop: write A, HL++, loop C bytes
C $952D,6 restore HL; HL+=$20 (next row); restore BC
C $9533,3 loop B rows; RET
c $9536 Convert screen address to attribute address
N $9536 Standard ZX idiom: H's top bits (Y7Y6, the screen third) rotated into place and ORed with $58 to get the attribute row; L is already the right column so it's left as-is.
R $9536 HL screen address
R $9536 O:HL attribute address
t $9540
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
t $96CD
s $96D5
b $96E5
b $96FD
b $9715
t $9725
b $972D
t $973D
b $9745
t $975D
b $9765
t $9795
b $979B
t $97A5
b $97AD
t $97BD
b $97C3
t $97D5
b $97DB
t $97ED
b $97F3
t $9800
b $9804
t $9805
b $980B
t $9825
b $982D
t $9841
b $9846
c $9855 Set up the current room (called right after every room-number change)
N $9855 A = current room number (from #R$BE42, still live from $5C01). If it's $2C, forces ($5C34)=$FF02. Then checks the room number against a bit7-terminated list at $9AF5; if matched and $5C05=0, calls #R$9AA1. Falls through into #R$9880 to run the per-room setup (music, hazard-count tuning, moving-lift init, etc). Called after every #R$AEFD room-number write we've found: #R$A671/#R$A69B/#R$A6AE (edge transitions), #R$9090 (respawn), and #R$8F47 (init) - the actual "build new room" entry point.
C $9856,3 Decode room's creatures/hazards from the room data table
C $9874,3 Snapshot current room/position into respawn staging
C $987A,3 Per-room setup
c $9880 Per-room setup (music, hazard tuning, lift init)
C $9881,3 HL=music-track table ($9AC6)
C $9890,3 Swap music data buffers, toggling the music flag
C $9899,3 Swap music data buffers, toggling the music flag
C $98A4,3 Build room background from its back-tile map
C $98BC,2 C=$DD if music playing
C $98C2,3 Find all tile-map ($F800) positions matching A, store coords list at DE
C $98D0,3 Find all tile-map ($F800) positions matching A, store coords list at DE
C $98E7,5 room $10: $A6F5=6
C $98FC,3 lift table entries point to $9998
C $9901,3 lift table stride = 31 bytes
C $9907,4 clear $5C24
N $9880 Checks the room number (from #R$9855) against a 15-entry table at $9AC6 to decide the music track (toggled via #R$918D). Clears $5BA2 and calls #R$9914 (builds the room's tile background), then initializes a 31-byte command/animation list at $9AD5 via #R$9A8C. Resets several per-room counters ($5C0C, $5C41, $5BA1) and sets $B072=1. Room $10 sets $A6F5=6 (a per-room tuning value - default is 7, set at #R$8F47). Room $1C, if $5C24 is set, fills a 12-entry table at $F808 with pointers to $9998 spaced 31 bytes apart - looks like moving-lift/platform setup (matches sprite #31 "Lift"). Finishes by clearing $5C24 and calling #R$917C.
C $990B,3 Init $5B0A/$5B0E/$5B12/$5B16 to $007F
C $990E,3 Blit the room's tile-index map ($F800) onto the real screen
C $9911,3 => Reset object slots ($5C0E), scan $B99D table for current room
c $9914 Build room background from its back-tile map
C $9914,3 HL=A (room number, zero-extended)
N $9914 A = room number (from #R$9880). HL = $D600 + room*32: a 32-byte back-tile index list per room (8x4 back-tiles, each 32x32px). For each of 4 rows x 8 back-tile indices, looks up the back-tile's definition at $C600 + index*16 - a 4x4 arrangement of 8x8 "tile" indices - and copies it into the room's expanded tile-index map at $F800 (32x16 tiles, matching the 32x16-char screen). Back-tile index $10 is special-cased via #R$99F0. The table that turns these 8x8 tile indices into actual pixel bitmaps hasn't been found yet.
C $9917,5 HL = room*32
C $991C,4 HL = back-tile index list ($D600 + room*32)
C $9920,6 B=4 rows, IX=room tile-index map ($F800)
C $9926,3 save BC; save IX (column loop)
C $9929,3 B=8 columns; save BC
C $992C,2 C = back-tile index
C $992F,7 HL = back_tile_index*16
C $9936,4 HL = back-tile definition ($C600 + back_tile_index*16)
C $993A,6 tile $10: special case (#R$99F0)
C $9940,79 copy 16 sub-tile indices from back-tile def to IX offsets $00-$63
C $998F,10 restore HL, HL++; IX+=4 (next column); restore BC; loop 8 columns
C $9999,10 restore IX; IX+=$80 (next row); restore BC; loop 4 rows
C $99A3,1 RET
c $99A4 Blit the room's tile-index map ($F800) onto the real screen
C $99A4,6 HL=0 (tile counter 0-511); DE=$F800 (tile map)
C $99AA,2 save HL/DE (for attr calc + tile index)
N $99A4 HL counts 0-511 (32x16 tile positions, matching the $F800 map size - loop exit checks BIT 1,H, i.e. stops once H=2). For each tile: reads the tile index from ($F800+HL), looks it up in a 256-byte table at $DF00 to get an attribute byte, writes that to the attribute file ($5800 + ...); then looks up an 8-byte bitmap at ($5B72)+tile_index*8 and copies it to the real screen bitmap address, one byte per pixel row (INC D each line - standard screen-third stride).
C $99AC,4 HL = attribute address ($5800 + ...)
C $99B0,11 A = tile index; look up attribute byte via $DF00 table
C $99BB,2 restore HL; store attribute byte
C $99BD,9 HL = screen bitmap address
C $99C6,2 restore A (tile index); save HL (screen address)
C $99C8,10 HL = ($5B72) + tile_index*8 (bitmap source)
C $99D2,7 HL+=DE; BC/DE = screen+secondary-buffer addrs; B OR= $E0
C $99D9,3 save row counter; A=8 (rows)
C $99DC,11 copy byte to screen + secondary buffer; advance D/B/HL; loop 8 rows
C $99E7,9 advance DE/HL (next tile); loop until H=2 (512 tiles done); RET
c $99F0 Set redraw pointers ($5BA2=IX+$6020, $5BA4=HL+4) for #R$9A2F
C $99F0,7 save HL/IX/DE; DE=$6020
C $99F7,9 IX+=DE; store $5BA2; DE=4
C $9A00,4 HL+=DE; store $5BA4
C $9A04,5 restore DE/IX/HL, RET
c $9A09 Gated call to #R$9A2F, room/hazard-timer dependent
C $9A09,4 Proximity check
C $9A0D,7 room ($5C06)=2?
C $9A14,3 else room ($5C06) must be 3
C $9A17,8 hazard timer ($5C07)>=8 required (room 3 path)
C $9A1F,6 hazard timer ($5C07)>=8 required (room 2 path)
C $9A25,6 save BC/HL/DE, call #R$9A2F
c $9A2F Dual-buffer redraw: 2x4 grid, each cell via #R$9A62
C $9A2F,6 HL=pointer ($5BA2); RET Z if null
C $9A35,6 DE=pointer ($5BA4); B=2 (outer rows)
C $9A3B,4 save BC/HL; B=4 (inner cols)
C $9A3F,5 inner loop x4 via #R$9A62
C $9A44,8 restore HL, +=$20 (next row); restore BC; outer loop x2
c $9A4D Write A to (HL), DE=HL, fall into #R$9A62 dual-write loop
R $9A4D A byte to write (attribute or pixel value)
R $9A4D HL screen/attribute address
c $9A52 Write A to (HL)+$6000 (secondary buffer), then #R$9A62 dual-write loop
R $9A52 A byte to write
R $9A52 HL screen address (primary buffer; +$6000 = secondary)
C $9A52,14 DE=HL; write A to (HL); HL+=$6000 (secondary buffer); C=$40 (page); CALL #R$9A64
C $9A60,2 L--; DE-- (undo pre-increment for fallthrough)
C $9A64,3 save HL/BC/DE
C $9A6F,1 push HL (save attribute address)
C $9A77,9 DE=pixel buffer base ($5B72); HL=tile bitmap addr; swap; restore HL; B=8 rows
C $9A80,6 copy byte (DE)->(HL); H++ (next line); loop 8
C $9A86,6 restore DE(++), BC, HL(++); RET
C $9A62,2 C=$E0 (alt attribute page)
C $9A67,8 H = attribute-style address (AND $03, rotate, OR C)
C $9A70,7 HL = tile index * 8 (bitmap offset)
c $9A8C Find all tile-map ($F800) positions matching A, store coords list at DE
R $9A8C A tile index to search for
R $9A8C DE destination coords-list address
R $9A8C O:DE past the last coord pair written
C $9A8C,9 BC=$01FF (search count); HL=$F800; CPIR (find match); RET PO if none
C $9A95,8 save A; store coords (L,H) at DE, advance DE twice
C $9A9D,4 HL++; restore A; loop CPIR
c $9AA1 Snapshot current room/position into respawn staging ($5C2B-$5C32)
C $9AA1,6 room ($5C01) -> $5C2D
C $9AA7,9 status/hazard-counter pair ($5C06/$5C07) -> $5C2B/$5C2C
C $9AB3,6 player X/Y ($5B04) -> $5C2E
C $9AB9,6 ($5B06) -> $5C30
C $9ABF,6 ($5B9E) -> $5C32
C $9AC5,1 RET
b $9AC6
t $9AC9
b $9AD5
t $9B0B
b $9B1E
c $9B22 Per-frame update for 5 party slots ($5B04): plot pixel, screen addr, sprite frame init, redraw
N $9B22 Runs once per frame for all 5 world-object slots ($5B04 array - hero plus up to 4 creatures/hazards, see Actors.md). First pass: for each slot, computes and caches the screen plot address and plot-routine pointer for the slot's current pixel position (#R$9CEE) into the slot's +$40-$43 scratch fields. Second pass: for each slot, converts its animation-frame byte into a screen sub-position and runs the frame's init chain (#R$9C6A), then - only for slot 4 (the last one, checked via `B==5`) - runs the gated hazard-timer check (#R$9A09). Finally draws all active object sprites (#R$9DE3), restores the saved backgrounds behind both this frame's and last frame's positions (#R$9BEB, called for two different base arrays - $5AE4 and $5B04, purpose of the first not confirmed), copies a 32-byte scratch region, and draws the sparkle effect list (#R$92BD) plus the party-slot tile graphic (#R$9D3C). This is the main per-frame draw/update pump that #R$9018's main loop calls every frame.
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
C $9BE4,3 Draw sparkle/effect list at $9AE5, music-on variant, via #R$92D6
C $9BE7,3 Draw a tile-based graphic for each of 5 party-slots at $5B04
c $9BEB Restore saved background under object (5 slots), via #R$9DBF for row wrap
N $9BEB For each of 5 object slots (base IX, stride 4), reads the background tile saved when the object was last drawn (from +$40/+41) and copies it back over the object's old position - the standard "erase sprite by restoring saved background" technique, done in two interleaved directions (LDI-based and LDD-based copies alternate down the object's height) to write both halves of a straddled screen-third boundary without an explicit branch, falling through to #R$9DBF whenever a copy crosses a character-row boundary. Called twice per frame by #R$9B22, once for each of the two base arrays ($5AE4 and $5B04) it's shared between. Also reachable directly at the $9BF3 entry point (skipping the slot-loop setup) when a single object is being deactivated (#R$9D21).
R $9BEB IX first object-slot base (stride 4, 5 slots)
C $9BEB,2 B=5 slots
C $9BED,6 HL=tile reference ((IX+$40)/(IX+$41))
C $9BF3,5 D/E = fixed-up screen address (H AND $5F, L)
C $9BF8,3 save BC; B=4 (sub-rows)
C $9BFB,4 save BC; BC=$07F0 (row-wrap test constant)
C $9BFF,12 copy 3 bytes forward (LDI x3), copy pixel byte, H++/D++, test row
C $9C0B,3 DOWN HL, char-row fixup
C $9C1A,3 DOWN HL, char-row fixup
C $9C29,3 DOWN HL, char-row fixup
C $9C38,3 DOWN HL, char-row fixup
C $9C47,3 DOWN HL, char-row fixup
C $9C56,3 DOWN HL, char-row fixup
C $9C59,1 restore BC
C $9C5A,2 loop 4 sub-rows
C $9C5C,8 IX += 4 (advance to next slot's fields)
C $9C64,1 restore BC
C $9C65,4 loop 5 slots
C $9C69,1 RET
c $9C6A Reset alt BC, run init chain (#R$9C72/$9C75/$9C78/$9C7E)
R $9C6A DE packed data pointer
R $9C6A IY dispatch address (JP (IY) tail-call)
R $9C6A O:DE advanced by 2
C $9C6A,5 EXX; BC'=0 (alt registers)
C $9C7E,3 H'=$FF (mask init, alt regs)
C $9C81,11 read 2 bytes via DE, combine into B/C (self-modifying call-chain trick above)
C $9C8C,11 EXX; build D/L from alt B/A; JP (IY) dispatch
b $9C97
c $9C9B Build sub-pixel blend mask, plot into (BC); DOWN BC char-row fixup
N $9C9B Plots a sprite pixel-column that isn't aligned to a character boundary: builds an 8-bit blend mask by rotating HL (the sprite's raw byte, pre-shifted into a carry chain) through D one bit at a time, 7 times, producing a mask that splits one sprite byte across two adjacent screen bytes at the sub-pixel offset. Blends the mask into (BC) and (BC)+1 using AND/OR (so it merges with, rather than overwrites, whatever's already on screen - needed since a sub-pixel-shifted sprite always straddles two character cells), then advances the column and wraps at char-row/screen-third boundaries like the other DOWN-HL/DOWN-DE fixups. This is the "position not divisible by 8" sibling of the fast whole-byte sprite blit in #R$9DE3.
C $9C9B,4 rotate a bit into D/HL (sub-pixel shift)
C $9C9F,24 repeat shift-rotate 6 more times (build 8-bit mask)
C $9CB7,5 E=mask; blend into (BC)
C $9CBC,6 blend into (BC)+1
C $9CC2,5 DOWN BC: advance column, char-row wrap
C $9CC7,16 column wraps at char boundary? adjust C+=$20, mask B
C $9CD7,4 char-row wrap (alt branch)
C $9CDB,12 next screen-third row; clamp at bottom (B=$E0)
c $9CE7 Write A to (BC), fall into #R$9CC2 char-row fixup
c $9CEE Compute screen address (BC) + pick plot routine (IY) for pixel HL
R $9CEE HL pixel position (X in L, Y in H)
R $9CEE O:BC screen byte address for that pixel
R $9CEE O:IY plot-routine address for the pixel's sub-column
C $9CEE,8 C = pixel row bits (sub-char)
C $9CF6,9 merge into C (attribute-style address)
C $9CFF,14 B = screen-third/page bits
C $9D0D,8 room-third 0: IY=#R$9CE7 (plain write)
C $9D15,11 else: IY = table[$9C97 + third*4]
c $9D21 Deactivate object (IX+2)=$FF, restore background via #R$9BF3
C $9D21,10 mark inactive; HL=(X,Y)
C $9D2E,14 BC->HL; B=1; draw one frame via #R$9D48; restore HL; tail-jump erase via #R$9BF3
C $9D2B,3 Compute screen address (BC) + pick plot routine (IY) for pixel HL
c $9D3C Draw a tile-based graphic for each of 5 party-slots at $5B04
N $9D3C For each of the 5 object slots, reads a tile reference from the slot's +$40/+41 fields and draws it as a small tile-based graphic (as opposed to the pixel-sprite draw path in #R$9DE3): works out how many 8x8-tile rows/columns are covered from the position's alignment (3 or 4, depending whether the position sits exactly on a tile boundary), looks up each covered tile's index in the $F800 room tile-index map, fetches its 8-byte bitmap from ($5B72)+tile*8, and blits it row by row (unrolled, with #R$9DBF handling the char-row-boundary wrap every 8th line). Whether this draws world-embedded tile graphics (e.g. a lift or door built from room tiles) or UI icons is not confirmed - see Actors.md's open question about slot offset $40/$41 being reused for two different purposes.
C $9D3C,4 IX=$5B04 (party slot base), B=5 slots
C $9D42,6 HL = tile reference ((IX+$40)/(IX+$41))
C $9D48,27 count sub-tile rows/cols (3 or 4) from position alignment
C $9D63,8 HL = tile-index map offset ($F800 + ...)
C $9D6B,14 HL = tile bitmap source ($5B72 + tile*8)
C $9D79,4 restore/save screen address (HL)
C $9D7D,6 copy 8-byte tile bitmap, one row per INC H
C $9D83,24 6 more row copies (unrolled, INC H each line)
C $9D9B,5 restore/advance HL; loop 3 rows; restore HL
C $9DA0,4 advance column by 32, carry into row+8
C $9DA4,10 apply row carry; restore BC; loop 3 cols; restore BC
C $9DAE,6 IX+=4, next slot
C $9DB4,5 loop 5 slots; RET
c $9DB9 DOWN DE, char-row fixup
N $9DB9 Wraps #R$9DBF: takes address in DE (swapped into HL), fixes it, result ends in HL
R $9DB9 DE screen address
R $9DB9 O:HL fixed address
C $9DBA,3 DOWN HL, char-row fixup
c $9DBF DOWN HL, char-row fixup
N $9DBF Fixes screen address HL after crossing a character-row boundary in a downward scan (all real callers do INC H per line, then call this every 8th line)
C $9DBF,1 DEC H (net down one line)
C $9DC0,6 check L's top bits, branch
C $9DC6,8 L+=$20, H&=$F8 (next row, same third)
C $9DCE,6 D/E = fixed-up screen address
C $9DD4,4 alt: L AND $1F
C $9DD8,11 H = (H AND $F8)+8 (next third); D/E = result
R $9DBF HL screen address
R $9DBF O:DE fixed address
c $9DE3 Draw active object sprites (slots $5C0E,$5C13,$5B99)
N $9DE3 Draws the pixel sprite for each of the two creature/hazard slots ($5C0E, $5C13) plus a third fixed slot ($5B99), skipping any whose type byte is $FF (inactive). For each: computes the screen plot address (#R$9CEE), looks up the sprite's 72-byte record ($8400 + index*72, 3 columns x 24 bytes, same layout as the item sprites in Items-Format.md) and masks it onto the screen a byte at a time using an AND-mask/OR-data pair, duplicating the same masked write to the attribute file at $9E42 (so each sprite carries its own per-cell color), advancing across screen thirds and wrapping char-rows via #R$9E50/#R$9DB9. This is the pixel-sprite counterpart to #R$9D3C's tile-based draw - creatures/hazards and collectible items share this one draw routine and the $8400 sprite format.
C $9E00,3 => Deactivate object (IX+2)=$FF, restore background via #R$9BF3
C $9E0C,3 Compute screen address (BC) + pick plot routine (IY) for pixel HL
C $9E1F,6 sprite table base + index*72
C $9E26,2 3 columns
C $9E2A,2 24 bytes/column
C $9E2C,5 H=$FF, mask page pointer
C $9E31,7 blend sprite byte with mask
C $9E3D,5 AND-mask then OR onto screen byte
C $9E42,5 duplicate write to attribute byte
C $9E47,4 advance to next screen third
C $9E50,3 DOWN DE, char-row fixup
c $9E5D Populate the $5BD6 object-slot table (via #R$9FBA/#R$9F86)
C $9E64,3 Store HL into an IY-indexed table entry, advance IY/HL by stride
C $9E80,3 Compute HL = A*24-ish, entry point for #R$9FBA
C $9E87,3 Store HL into an IY-indexed table entry, advance IY/HL by stride
c $9E96 Draw lives-count icons ($5B97) into $5BD6 slots
C $9EA9,3 Compute HL = A*24-ish, entry point for #R$9FBA
C $9EB3,3 Store HL into an IY-indexed table entry, advance IY/HL by stride
C $9EBA,3 => Redraw $5BD6 slot at $5081
c $9EBD Init $5BD6 object slots from $5C23 (calls #R$9EE3)
C $9EBD,3 Fill $5BD6 slots with item icons from inventory log
C $9ED0,3 Compute HL = A*24-ish, entry point for #R$9FBA
C $9ED3,3 Store HL into an IY-indexed table entry, advance IY/HL by stride
C $9EE0,3 => Redraw $5BD6 slot at $5096
c $9EE3 Fill $5BD6 slots with item icons from inventory log ($5B7C)
C $9EE3,11 B=4 slots; A=index ($5C23); IY=$5BD6; L=C=A
C $9EEE,9 IX = inventory log ($5B7C) + index
C $9EF7,7 log entry==$FF (empty)? skip lookup
C $9EFE,5 empty: HL=$5C46 (blank icon); skip ahead
C $9F03,3 DE=$8400 (item sprite table)
C $9F0C,8 IX+=2; C++; wrap C at $1B
C $9F14,6 wrap: C=0; IX=$5B7C (restart log)
C $9F1A,4 loop 4 slots; tail jump to #R$9F70
C $9F06,3 Compute HL = A*24-ish, entry point for #R$9FBA
C $9F09,3 Store HL into an IY-indexed table entry, advance IY/HL by stride
c $9F1E Redraw $5BD6 slot at $5081 (tail of #R$9E96)
c $9F27 Draw main-menu UI icons/highlight bar into $5BD6 slots
C $9F33,3 Compute HL = A*24-ish, entry point for #R$9FBA
C $9F36,3 Store HL into an IY-indexed table entry, advance IY/HL by stride
C $9F5A,3 Compute HL = A*24-ish, entry point for #R$9FBA
C $9F5D,3 Store HL into an IY-indexed table entry, advance IY/HL by stride
c $9F6B Redraw $5BD6 slot at $5096 (tail of #R$9EBD)
c $9F70 Redraw background column for up to 9 object slots ($5BD6)
C $9F73,10 IY=slot table; A=skip count ($5C22)
C $9F7D,7 advance IY past skipped slots
C $9F84,2 B=9 slots
C $9F86,10 DE=slot pointer; B=24 rows
R $9F86 HL screen destination
R $9F86 IY slot table entry (word pointer at +0/+1)
R $9F86 B slot count
C $9FA0,9 next slot
C $9F9A,3 DOWN HL, char-row fixup
c $9FAA Compute HL = A*24-ish, entry point for #R$9FBA
R $9FAA A index value
R $9FAA O:HL A*72 + caller's DE
C $9FAA,4 save caller's DE; HL=A (zero-extended)
C $9FAE,3 HL*=8
C $9FB1,6 save A*8; HL*=8 (A*64)
C $9FB7,3 HL += A*8 (=A*72); restore caller's DE, HL+=DE; RET
c $9FBA Store HL into an IY-indexed table entry, advance IY/HL by stride
R $9FBA HL value to store
R $9FBA IY table entry address
R $9FBA O:IY advanced past 3 entries
R $9FBA O:HL value + 3*stride
C $9FBA,10 store entry 0; advance IY by 2
C $9FC4,4 DE=$18 (stride); HL+=DE
C $9FC8,7 store entry 1; HL+=DE
C $9FCF,4 advance IY by 2
C $9FD3,10 store entry 2; advance IY by 2; RET
b $9FDE
t $9FE7
b $9FEA
t $A0BD
b $A0C2
c $A102 Clear a 4-byte record at $A0FE
N $A102 Clears a 4-byte scratch record at $A0FE, then - unless the hero is already flagged (bit7 of that record) or music is playing - samples the two tiles just below and to the right of the hero's feet (#R$A176) for a "walked off a ledge" style collision; a match on tile $A5 in either sample triggers status $1A. Separately checks the tile position ahead of the hero's movement direction (#R$A1F4) and, unless the flag/music-on gate is set, the tile directly under the hero: standing on a "sticky" hazard tile ($BC/$BD) for 50 frames (a per-tile counter at $5C29) forces status $11. Finally re-checks the tile column below the feet against the solid-tile lists (#R$A2AC/#R$A2FA) to (re)compute the record's flag byte for next frame. This is the hero's main per-frame ground/hazard-tile sensor, called every frame from #R$A3E1.
R $A102 DE preserved (pushed/popped, not used)
C $A102,18 IY=$A0FE; save DE; clear 4-byte record
C $A114,6 skip check if $5C06 set or music playing
C $A11A,6 music-on flag check, skip if set
C $A120,13 Sample two nearby tiles (below/right of object) for collision
C $A12D,5 trigger $1A via #R$AE85
C $A132,3 Check object position against screen bounds, sample tile ahead
C $A135,4 clear tile flag ($5C28)
C $A139,12 skip if flag/music set; else check tile under object
C $A145,9 tile under object is $BC/$BD?
C $A14E,19 store tile flag; hazard counter ($5C29)++; >=$32 -> room-state=$11; else check
C $A161,4 else: clear hazard counter ($5C29)
C $A165,15 Scan tile column below feet against solid-tile list ($A24B/$A271), flag
C $A174,2 restore DE; RET
c $A176 Sample two nearby tiles (below/right of object) for collision
C $A185,3 Convert pixel position (HL) to character-cell coordinates
C $A18E,3 Convert pixel position (HL) to character-cell coordinates
c $A193 Check tile below-left of feet (X+12,Y+23) against special-tile lists
R $A193 IX object (position at +0/+1)
R $A193 O:Zf set if tile matches ($98 or $99)
C $A193,13 L=X+12 (check off-screen overflow); H=Y+23
C $A1A0,7 H=Y; music-on flag check
C $A1A7,3 get Current room number
C $A1AA,3 room==$0C?
C $A1AD,3 Convert pixel position (HL) to character-cell coordinates
C $A1B0,15 restore AF; check tile against list ($92/$95/$98/$99)
C $A1BF,1 RET
C $A1C0,3 off-screen: A=1 (blocked); RET
C $A1C3,3 Convert pixel position (HL) to character-cell coordinates
C $A1C6,13 check tile against list ($C6/$C7/$CE/$CF); RET
c $A1D3 Blocked-check wrapper (Y-1) via #R$A208, save/restore (IY+3)
C $A1D3,5 save BC; save (IY+3)
C $A1D8,4 clear (IY+3)=0
C $A1DC,6 L=X+12
C $A1E2,7 A=Y-1; CALL #R$A208
C $A1E9,3 C=(IY+3) result
C $A1EC,8 restore (IY+3), A; A=C; restore BC; OR A; RET
c $A1F4 Check object position against screen bounds, sample tile ahead
C $A1F4,6 L = X+12
C $A1FA,9 Y+24, check for off-screen wrap
C $A203,5 off-screen: set (IY+3)=5
C $A208,3 BC = (X+12, Y+24)
C $A20F,9 HL = special-tile list ($A234, or $A264 if music on)
C $A21B,10 scan list for a match
C $A20B,3 Convert pixel position (HL) to character-cell coordinates
b $A234
t $A244
b $A24B
t $A26A
b $A271
c $A293 Convert pixel position (HL) to character-cell coordinates
R $A293 HL pixel position (X in L, Y in H)
R $A293 O:HL tile-index map address ($F800+offset)
R $A293 DE preserved
C $A293,7 save DE; L>>=3 (pixel column -> char column)
C $A29A,8 H=(H<<2 AND $E0) OR L (row bits + column)
C $A2A2,4 H=(H AND 1) (row bit8)
C $A2A6,6 HL += $F800 (tile-index map base); restore DE, RET
c $A2AC Scan tile column below feet against solid-tile list ($A24B/$A271), flag (IY+0)
R $A2AC IX object (position at +0/+1)
R $A2AC IY flag record (result byte at +0)
R $A2AC O:(IY+0) 0 or 1 (solid-tile match)
C $A2AC,10 HL=(X,Y); clear flag; B=3 rows
C $A2B6,8 row-aligned check ((H AND 7)==0)? B=4 rows instead
C $A2BE,2 save BC/HL
C $A2C3,3 DE=$A24B (solid-tile list)
C $A2C6,9 music-on -> DE=$A271 instead
C $A2D2,4 room>=$18?
C $A2D6,9 DE=$A242 (alt list); music-on check
C $A2DF,3 music-on -> DE=$A268 instead
C $A2E2,9 scan list for match ($FF-terminated)
C $A2EB,6 no match: skip; match: set flag (IY+0)=1
C $A2F1,6 restore HL; H+=8 (next row); restore BC
C $A2F7,3 loop 3/4 rows; RET
C $A2C0,3 Convert pixel position (HL) to character-cell coordinates
C $A2CF,3 get Current room number
c $A2FA Scan tile column right of object (X+23) via #R$A2B2
R $A2FA IX object (position at +0/+1)
R $A2FA IY flag record (result byte at +0)
c $A30B Scan tile below-right of feet (X+12,Y+24) via #R$A328
c $A31F Scan tile at (X+12) against special-tile list ($A242/$A268), flag (IY+0)
C $A31F,9 HL = (X+12, Y)
C $A328,4 clear flag (IY+0)=0
C $A32F,9 DE=$A242 (list); music-on -> $A268 instead
C $A338,3 DE=$A268 (music-on list)
C $A33B,9 scan list for match ($FF-terminated)
C $A344,6 no match: skip; match: set flag (IY+0)=1
C $A34A,1 RET
C $A32C,3 Convert pixel position (HL) to character-cell coordinates
c $A34B Apply joystick input to object position, trigger room edge at $A640
N $A34B Resets status/hazard state ($5C06/$5C07 via #R$AE84), reads the resolved input bitmask (#R$B894/#R$B87D) into a direction bitmask (E) and a velocity pair (BC, persisted at $5C34 between frames rather than recomputed from scratch each time). Before committing a Y move, checks #R$A1D3 to see whether the destination tile is blocked and flips the velocity's sign if so (a bounce/reject rather than a hard stop). Updates the hero's direction flag ((IX+3) bit7) from the resulting velocity's sign, applies the X/Y deltas to the position, and - only when X crosses 4 - hands off to the room-edge handler at #R$A640. This is the routine that actually moves the hero object; #R$A3E1 is the outer per-frame driver that calls it.
C $A356,3 Resolve conflicting L/R, U/D input via #R$B894
C $A359,5 E=direction bitmask, BC=velocity ($5C34)
C $A3A8,21 resolve Y-velocity sign (blocked check via #R$A1D3)
C $A3BD,4 store velocity ($5C34)
C $A3C1,12 update direction flag (IX+3) from velocity sign
C $A3CD,14 Y+=B (IX+1), X+=C (IX+0)
C $A3DB,6 if X>=4, jump to room-edge handler #R$A640
C $A353,3 Clear a 4-byte record at $A0FE
c $A3E1 Main per-frame player update: input, movement, room-state/hazard dispatch
N $A3E1 Called once per frame for the hero object (IX=$5B04). Runs, in order: per-room init dispatch (once per room load), a scripted-zone list step (triggers tied to fixed room+position combinations, e.g. $B073's table), the resolved-input read (#R$B894/#R$B87D) feeding into #R$A34B for movement and room-edge crossing (right/left/up/down handlers), a room-state dispatch indexed by $5C06 (#R$A6CC), the ENTER-key confirm check (port $FBFE, sets $5C06=$0A), and the sound-effect dispatcher. The large tail (roughly $A457-$A640) is a long chain of hardcoded room+tile+position checks that force specific $5C06 values - see Actors.md's status-code table for what's known about each. This is the busiest routine in the disassembly (264 instructions) and the natural place to look first for any hero-behavior question not already answered elsewhere.
C $A3E1,3 Per-room init dispatch
C $A3F1,3 => Scripted-zone list step
C $A3F4,3 Resolve conflicting L/R, U/D input via #R$B894
C $A3FC,3 Scripted zone trigger
C $A40C,3 Room-state dispatch
C $A40F,3 Scripted zone trigger by room+position table
C $A416,3 Check ENTER key (port $FBFE), trigger state $0A via #R$AE85
C $A420,3 get Current room number
C $A457,3 get Current room number
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
C $A640,3 get Current room number
C $A643,15 room=$29: room = portal table[($5B70)] (reverse lookup)
C $A652,3 set Current room number
C $A657,3 Decode room number ($5C01) to row/col
C $A662,3 Encode row/col to room number
C $A669,3 => Set up the current room
b $A66C
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
C $A6CC,5 room state ($5C06)=0 -> RET
C $A6D1,7 index = (state-1)*2
C $A6D8,5 HL = table ($A72E) + index
C $A6DD,5 HL = table[index] (handler address); restore DE
C $A6E2,4 handler=0 -> RET; else JP (HL)
b $A6E6
t $A7C3
b $A7C6
c $A828 Trap-entry: hazard-timer table lookup via #R$ABDE, on $FF room-state++
C $A82C,3 Increment hazard counter ($5C07), index a table by half its value
C $A831,3 => Store trigger code into creature state
b $A83B
t $A84A
b $A850
c $A851 Trap-entry: hazard-timer table lookup, on $FF award score $4B and reset via #R$AE84
C $A855,3 Increment hazard counter ($5C07), index a table by half its value
C $A85A,3 => Store trigger code into creature state
C $A862,3 Populate the $5BD6 object-slot table
C $A868,3 Save all registers
C $A86B,3 => Reset room state=0 and hazard counter ($5C07)
t $A86E
b $A887
c $A888 Set table $A8BF, C=0, falls into #R$A8AB
b $A88F
c $A8AB Hazard-timer table lookup via #R$ABDE, on $FF fire event via #R$C4B2
C $A8AB,3 Increment hazard counter ($5C07), index a table by half its value
C $A8B1,3 => Store trigger code into creature state
C $A8B7,3 Sound-effect dispatcher wrapper
C $A8BC,3 => Set room state=$12, reset hazard counter
b $A8BF
t $A8D3
b $A8DF
t $A8E0
b $A8E4
c $A8EA Room-dependent creature init: hazard-timer/room checks, sets $5B9E/$5B9F, room-transition via table $B073
C $A8EA,16 hazard-timer($5C07)!=0? skip; set $5B9E=$1F, $5B9F=$50
C $A8FA,3 get Current room number
C $A8FD,6 C=$BD; room==$30? branch $A910
C $A903,6 C=$A0; room==$3D? branch $A910
C $A909,7 else: set room-state=$17; RET
C $A910,9 flag ($5C44) set? else RET Z; latch C into $A959
C $A919,4 restore HL; DE=$A955 (message table)
C $A91D,3 Increment hazard counter ($5C07), index a table by half its value
C $A920,6 result>=0 (bit7)? else skip trigger
C $A926,3 => Reset room state=0 and hazard counter ($5C07)
C $A929,6 hazard counter ($5C07)++; mask to 7 bits
C $A92F,3 set Current room number
C $A932,1 save A
C $A933,13 scan table $B073 for room match (3 entries)
C $A940,13 copy 2-byte destination from table; save to $B072
C $A94E,3 => Set up the current room
C $A951,3 store trigger code (IX+2)
C $A954,1 RET
t $A955
s $A959
t $A95A
b $A95E
c $A95F Init creature position from $5B14, state=$2D
b $A96B
c $A99A Latch current room into $5B9E
c $A9A1 Set creature Y (+8 to $5B9F); check room against table $A9E6, trigger #R$AE84
C $A9AE,3 get Current room number
C $A9C1,3 => Reset room state=0 and hazard counter ($5C07)
c $A9C4 Creature Y-advance dispatcher: room $43 special case, else #R$A9A1 or #R$A6AE
C $A9C5,3 get Current room number
C $A9D9,3 Move down a level
b $A9E6
t $A9E7
c $A9EE Hazard timer expiry: lose a life
N $A9EE Increments a per-room hazard counter ($5C07); once it reaches 50 ($32), sets the respawn-pending flag ($5C2A, handled by #R$9090) and decrements lives ($5B97). Zero lives -> game-over sequence (#R$9372). Otherwise continues via #R$9E96. The infamous "Infinite Lives" POKE (43517,182) overwrites the DEC (HL) at $A9FD with a no-op-equivalent OR (HL), skipping the life loss.
C $A9EF,8 counter++ ($5C07), stop if < 50
C $A9F7,3 hazard threshold hit: mark room-switch pending
C $A9FA,7 lives--; 0 -> game over
C $AA01,3 => Draw lives-count icons ($5B97) into $5BD6 slots
b $AA04
c $AA3C Creature update: gate on direction bit, then hazard-timer room trigger
C $AA3C,9 discard return; (IX+2)=$17, clear direction flag
C $AA45,5 direction bit set: go to #R$AE84
C $AA4A,10 else: hazard counter ($5C07) reaches 5?
C $AA54,17 room match ($5B98): pick trigger code, fire via #R$AE85
C $AA6C,3 => Sound-effect dispatcher wrapper
c $AA6F Creature Y-movement by hazard-counter lookup table ($AAFA)
C $AA6F,4 discard return; DE=table ($AAFA)
C $AA73,9 hazard counter ($5C07) reaches $54? JP Z #R$AE84
C $AA7C,18 Y -= table[counter]
b $AAA7
c $AAF0 Set room state=$12, reset hazard counter ($5C07)
b $AAFA
c $ABC3 Store trigger code into creature state (IX+2)
b $ABC7
c $ABDE Increment hazard counter ($5C07), index a table by half its value
R $ABDE DE lookup table base
R $ABDE O:A table[($5C07)/2] (pre-increment value)
b $ABEB
c $AC35 Creature trap-entry: clamp position per direction bits (E), dispatch by room state ($5B98)
N $AC35 A "trap" entry point (discards its own return address, POP HL at start - called via a tail-jump pattern rather than a normal CALL/RET, matching the other $AAxx/$ACxx/$ADxx trap-entry routines in this area). Latches the current room into a per-trap staging byte ($5C27) and forces the object's frame ($7F). If a room-state flag ((IY+3)) is set, clamps the object's X position against fixed bounds per direction bit (E bit0=right, bit1=left), stopping it at screen edges rather than letting it wrap. Then dispatches by the room-category variable ($5B98): rooms $06/$07 push the object toward a level change (up via #R$A69B or down via #R$A6AE, depending on Y), anything else just clamps Y and stores it. Reads as generic "obstacle stays on its track, but a set-piece exit takes it to the next level" logic shared by several similarly-shaped trap routines rather than one specific creature.
C $AC35,1 discard return
C $AC36,3 get Current room number
C $AC39,9 store scripted room ($5C27); (IX+2)=$7F; save DE
C $AC42,3 Clear a 4-byte record at $A0FE
C $AC45,11 restore DE; (IY+3)!=0? else jump $AC81; else room==7?
C $AC50,7 A=X; room==7 -> skip clamp
C $AC57,12 direction bit0 (right)? adjust X clamp checks
C $AC63,6 X>=$E4? wrap clamp
C $AC69,12 direction bit1 (left)? adjust
C $AC75,6 X<8 check, +2 adjust
C $AC7B,6 store clamped X ($5C25, IX+0)
C $AC81,13 room ($5B98) dispatch: ==6/==7/else
C $AC8E,12 set hazard state 8 or 7 depending on room
C $AC9A,9 Y-1; if >=$18 skip level-change
C $ACA3,3 get Current room number
C $ACA6,5 room==3? branch $ACB8
C $ACAB,3 Move up a level
C $ACAE,10 restore Y; store ($5C26); RET
C $ACB8,12 hazard state==8? RET; else set 9
C $ACC4,6 (IY+3)!=0? else branch $ACEF
C $ACCA,11 Y+=2; check <$66
C $ACD5,4 if <$66, skip level-down
C $ACD9,2 push IX
C $ACDB,3 Move down a level
C $ACDE,10 pop IX; Y+=$18 (wrap below); store frame
C $ACE8,6 store Y ($5C26); RET
C $ACEF,6 store Y ($5C26) alt path
C $ACF5,4 direction bits E AND 3; RET Z
C $ACF9,4 bit1 set? branch $AD0B
C $ACFD,11 X+=2, clamp <$E7
C $AD08,3 => Reset room state=0 and hazard counter ($5C07)
C $AD0B,9 alt: X-=2, clamp>=0
C $AD14,3 trigger event via #R$AE85 (tail)
C $AD14,3 => Reset room state=0 and hazard counter ($5C07)
c $AD17 Creature Y-=4; move up a level via #R$A69B if off-screen, else trigger event 2
C $AD1F,3 => Move up a level
C $AD25,3 Clear a 4-byte record at $A0FE
c $AD32 Creature trap-entry: room $5B98 check, move X by direction bits (E)
N $AD32 Another discard-return trap entry (see #R$AC35). If the room category ($5B98) isn't $0A, just sets a per-object flag ($5C03) and resets to status 0 via #R$AE84 - i.e. this trap only does anything meaningful in room-category $0A. Otherwise sets the object's frame to $1D and, per direction bit (E bit0=right, bit1=left), nudges X by 2px and flips the direction flag when it does, clamping at the screen edges rather than crossing them (unlike #R$ADAC's room-crossing variant). Same family as #R$AC35: fixed-track obstacle movement, gated by room category rather than by the hazard-timer tables the $AA/$A8-prefixed traps use.
C $AD32,13 room ($5B98)==$0A? else store $5C03=2
C $AD3F,3 => Reset room state=0 and hazard counter ($5C07)
C $AD42,5 (IX+2)=$1D
C $AD47,4 direction bit0 (right)?
C $AD4B,9 X+=2, clamp <$E7
C $AD54,7 set direction flag; store X
C $AD5B,4 direction bit1 (left)?
C $AD5F,9 X-=2, clamp >=4
C $AD68,7 clear direction flag; store X
C $AD6F,4 direction bit3 (down)?
C $AD73,4 Y-=2
C $AD77,3 off-screen? branch $AD82
C $AD7A,4 Y-=2 again; off-screen? branch $AD82
C $AD7E,4 store Y; RET
C $AD82,3 get Current room number
C $AD85,3 room==8? RET Z
C $AD88,3 => Move up a level
C $AD8B,3 direction bit2 (up)? RET Z
C $AD8E,6 Y+=2; C=Y
C $AD94,3 get Current room number
C $AD97,5 room==$14?
C $AD9C,3 Y<$57? else RET NC
C $AD9F,4 store Y; RET
C $ADA3,2 Y>=$67?
C $ADA8,4 store Y; RET
C $ADA5,3 => Move down a level
c $ADAC Creature update: Y-state via #R$AE76, hazard-timer++, room-cross via #R$A671/#R$A640
N $ADAC Another trap-entry point (discards its return like #R$AC35 and neighbors). Looks up the object's Y-position from a table ($AE8D) indexed by the hazard counter ($5C07, incremented as a side effect via #R$AE76), and once that counter reaches $11, snaps the object's Y down to a tile boundary and resets to status 0 via #R$AE84. Otherwise calls #R$AE37 for a Y-bound check that can move the object up a level, then reads a second per-room byte ($5C08) as a 2-bit direction field: bit0 pushes the object right past the screen edge into the next room via #R$A671, bit1 (in the alternate branch, not shown in the excerpt but present at $AE06) pushes it left via #R$A640. Each room-crossing branch restores the object's local position afterward via #R$A102 unless a flag byte ((IY+1)/(IY+0)) says otherwise. Reads as the "creature that patrols back and forth across a room boundary" behavior, distinct from the fixed-track traps in #R$AC35/#R$AD32.
C $ADB0,3 Look up a table by hazard counter ($5C07), store into
C $ADC4,3 => Reset room state=0 and hazard counter ($5C07)
C $ADC7,3 Creature Y-bound check via #R$AF09/table $AE9E, move up via #R$A69B or clamp
C $ADE2,3 Move right
C $ADF6,3 Clear a 4-byte record at $A0FE
C $AE13,3 Move left
C $AE27,3 Clear a 4-byte record at $A0FE
c $AE37 Creature Y-bound check via #R$AF09/table $AE9E, move up via #R$A69B or clamp
C $AE37,3 Type-$10 gate
C $AE4C,3 Move up a level
C $AE5B,3 Clear a 4-byte record at $A0FE
b $AE69
c $AE76 Look up a table by hazard counter ($5C07), store into (IX+2)
c $AE84 Reset room state=0 and hazard counter ($5C07) ($AE85 entry: state=A)
R $AE85 A new room-state code ($5C06)
b $AE8D
c $AEAF Store scripted-zone list pointer ($AEED) from HL
b $AEB3
c $AEB9 Scripted-zone list step: $FF ends list, else store trigger code, advance $AEED
b $AECD
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
C $AF0D,3 Proximity check
C $AF1D,3 => Move down a level
c $AF22 Proximity check: player X vs pointer ($5BA2) column
C $AF22,7 HL=pointer ($5BA2); SCF; RET Z if null (carry = no target)
C $AF29,7 L=(L AND $1F)*8 (column*8)
C $AF30,4 A=player X ($5B04); A-=L; RET C if beyond
C $AF34,5 within 8 columns? CCF; RET
s $AF39
c $AF3B Scripted zone trigger: set special-encounter flag ($5C06)
C $AF3B,8 room $1D: jump to alt check
C $AF43,5 check room ($5C27) matches current
C $AF48,22 check player near a fixed spot
C $AF5E,6 set $5C06=7
C $AF64,3 alt: skip unless left pressed
C $AF67,15 check player at Y=$48, X in $1C-$20
C $AF76,11 snap X=$1E, set $5C06=$0D
c $AF81 Room-entry trigger: check position/input for a special zone
C $AF81,11 A=$24 (frame); store $5B14; A=($5B9F); store $5B15
C $AF8C,7 check player X within a fixed range
C $AF93,11 player X in [$12,$38)? else skip
C $AF9E,6 save/restore A; clear $5BA0
C $AFA4,8 player Y in [$1A,$30)? else skip
C $AFAC,14 skip unless room ($5C06) is 0/$13/$14
C $AFBA,7 Resolve conflicting L/R, U/D input via #R$B894
C $AFC1,7 down pressed: trigger $14 via #R$AE85
C $AFC8,4 up pressed? else skip
C $AFCC,5 trigger $13 via #R$AE85
C $AFD1,6 A=$9F; store $5B16; RET
c $AFD7 Init a room-specific decorative object ($5B10-$5B17) by room category
C $AFD7,8 gate: only for scripted room ($5C27==current $5C01)
C $AFDF,9 skip for rooms $12/$1A
C $AFE8,20 copy decorative base X/Y ($5C25/$5C26-16) to $5B10/$5B11/$5B14/$5B15
C $AFFC,9 branch by room category (7/8/9 vs default)
C $B005,10 else category 8 or 9? else default ($B020)
C $B00F,12 category 7/8/9: copy sprite frame ($5B07) to $5B13/$5B17; C=$24
C $B01B,5 restore A; category==9? branch $B02A
C $B020,10 default: A=$9A (sprite id); store $5B12; C -> $5B16; RET
C $B02A,4 category 9: A=$7F, JR back to store
c $B02E Check ENTER key (port $FBFE), trigger state $0A via #R$AE85
c $B03B Scripted zone trigger by room+position table ($B073)
C $B03B,5 B=3 entries; HL=table
C $B043,8 scan for room match
C $B04B,5 no match: clear one-shot flag ($B072), return
C $B050,7 check player Y against entry
C $B057,8 check player X below entry's X-threshold
C $B05F,9 check player X within threshold+8
C $B068,10 not yet triggered: fire via #R$AE85
C $B040,3 get Current room number
b $B072
t $B07C
b $B098
t $B099
s $B0B5
c $B0B6 Multi-stage animation sequence, dispatched by stage counter ($5C41)
N $B0B6 A scripted, one-shot multi-part sequence dispatched by a shared stage counter ($5C41, same counter used by #R$B4E2/#R$B562's staged-init pattern elsewhere) for an object record at $5B08. Stage 0 initializes several fields of that record and, only if a completion flag ($5BFE) is set, arms a fourth sub-part. Stages 1-3 each animate one field by a fixed step per frame until it reaches a target value, then advance to the next stage and fire a sound effect via #R$C4B2. Reads as a scripted "reward/fanfare" animation (likely the room-$28 warp fanfare set up by #R$B6EE, which sets $5BFE before this runs) rather than gameplay logic - the object being animated is separate from the 5-slot world-object array at $5B04.
C $B0BA,7 read stage counter, branch by stage
C $B104,3 stage 1 check
C $B122,3 => Sound-effect dispatcher wrapper
C $B12E,3 stage 2 check
C $B140,3 => Sound-effect dispatcher wrapper
C $B143,3 stage 3 check
C $B161,3 set Game-over flag
c $B165 Read/test flag ($5C00)
b $B16A
t $B1A9
b $B1AD
t $B1CC
b $B1CF
t $B1D3
b $B1D6
t $B1EB
b $B1EE
t $B246
b $B249
t $B266
b $B269
t $B2D7
b $B2EA
t $B327
b $B32A
t $B32F
b $B333
t $B355
b $B359
c $B370 Scripted event: trigger room $1C lift sequence at a fixed spot
N $B370 Stage-0 checks the flag byte at $5C40 (via #R$B165) then initializes an object at $5B10 from a template; once room $5B98=2 and the hero stands at the fixed spot (X=$DC, Y=$48), advances the stage and fires status $1C via #R$AE85 (the room $1C lift trigger seen elsewhere in the room-format notes). Stages 1+ (dispatched at $B3AB) drive whatever animation follows - not detailed here, but the pattern matches the other staged-object routines ($B0B6, $B4E2). Reads as one of several similar "walk to this exact spot in this exact room to trigger a scripted lift/sequence" set-pieces.
C $B370,3 Read/test flag
C $B37F,16 stage 0: init object ($5B10)
C $B38F,6 check level == 2 ($5B98)
C $B395,12 check player at (X=$DC, Y=$48)
C $B3A1,10 trigger: room $1C via #R$AE85
C $B3AB,4 stage >=1 dispatch
C $B403,3 Populate the $5BD6 object-slot table
C $B406,3 => Reset room state=0 and hazard counter ($5C07)
c $B409 Staged animation: init object ($5B14), branch on player side
N $B409 Stage 0: picks a side based on which half of the screen the hero is standing in (X vs $C8) and stores it as a flag ($5C40), then initializes the object at $5B14 to that side's starting position. Stage 1 dispatches to either #R$B4B0 (bounce toward ceiling) or #R$B47E (bounce toward floor) depending on the object's classified type/category (#R$9140), each of which moves the object 1px per frame and bounces it off the opposite bound plus off the left/right walls. Stage 2 resets state. This is the "object bounces vertically between floor and ceiling, side chosen by where the player is standing" pattern - likely a specific room hazard (a bouncing rock/creature that starts on whichever side the player approaches from).
C $B415,7 check player X vs $C8, pick side (C)
C $B427,15 store side flag ($5C40); init object position
C $B436,4 stage 1 dispatch
C $B440,3 Move object up toward ceiling, bounce via #R$B4D5
C $B444,3 Move object down toward floor, bounce via #R$B4A3
C $B45E,3 stage 2 dispatch
C $B44A,3 Classify object type ((IX+2)) into a size/category flag
C $B47B,3 => Reset room state=0 and hazard counter ($5C07)
c $B47E Move object down toward floor, bounce via #R$B4A3
C $B47E,5 gate flag ($5C42)!=0 -> RET
C $B483,8 E=0; Y>=$D8 (floor) -> RET
C $B48B,12 E=1; Y+=1; Y>=$38 -> #R$B4A3
C $B497,7 X-=2; if <8 RET
C $B49E,4 store X; RET
b $B4A2
c $B4A3 Right-bounce clamp for #R$B47E: X>=$C8 -> RET, else X+=2
c $B4B0 Move object up toward ceiling, bounce via #R$B4D5
C $B4B0,5 gate flag ($5C42)=0 -> RET
C $B4B5,8 E=0; Y<9 (ceiling) -> RET
C $B4BD,12 E=1; Y-=1; Y>=$1C -> #R$B4D5
C $B4C9,7 X+=2; if >=$30 RET
C $B4D0,4 store X; RET
b $B4D4
c $B4D5 Left-bounce clamp for #R$B4B0: X>=$7B -> RET, else X-=2
c $B4E2 Staged animation: init object ($5B10), scripted trigger via #R$AE85
C $B4E2,7 IY=object; HL=stage counter ($5C41)
C $B4FA,3 HL=$5C45 (sub-stage)
C $B505,5 check player Y >= $48
C $B518,8 arm flag; set frame; check room hazard ($5C06)
C $B526,5 trigger code $17 via #R$AE85
C $B53B,3 Save all registers
C $B548,3 get Frame counter
c $B55A Init 2 objects ($5B0C) variant, falls into #R$B57C
c $B562 Init 3 objects ($5B0C) from template; animate frame, room-specific variant
C $B562,7 IY=object; HL=stage counter ($5C41)
C $B56D,10 stage 0: copy 12-byte template from $B5D1
C $B57A,2 B=3 objects
C $B587,17 advance frame ((IY+2)), wrap at $55
C $B587,3 get Frame counter
C $B598,3 get Current room number
b $B5D1
c $B5DD Boss/miniboss state machine: proximity check, phase transitions ($5C3C-$5C3E), animation
N $B5DD Gated on #R$9140's proximity check between the object (IY=$5B14) and the hero, and on the room matching a locked value ($5C3C). On first trigger in a room, scans the shared creature table ($B99D) for that room via #R$B93F, populates display slots, and awards a fixed event/score (#R$BCF2, event id $96), then advances a phase counter ($5C3D); reaching phase 6 forces a warp to room $28 with a fanfare (#R$B6EE) - reads as a fixed encounter that always ends by moving the player to a specific room, i.e. a boss or set-piece rather than a roaming creature. Outside the initial-trigger path, drives a scripted step sequence (index at $B6ED, data at $B6C1) that looks up a per-step hazard code from a small table ($B6BB) and a bounded left-right patrol with edge-column wrapping ($B676 onward). Not confirmed against a specific named boss/room live - likely the "Prof" encounter mentioned in the room-format world-map notes, but that hasn't been checked.
C $B5DD,4 IY=object
C $B5E4,11 RET NC if not eligible; room ($5B98) == boss room ($5C3C)? else skip
C $B5EF,9 save IX/IY; mark room handled ((HL)=$FF); save $5C3E
C $B5FE,3 DE=$96 (event id)
C $B604,4 restore IX/IY
C $B608,7 phase counter ($5C3D)++; ==6 -> #R$B6EE
C $B612,12 first-time flag ($5BA1): if unset, init sequence
C $B61E,14 set start position/frame; store $30 to $5B11; RET
C $B62C,12 mask flag; ==1? branch $B676; else step lookup ($B6ED/$B6C1) via #R$ABE1
C $B638,17 flag ($5BA1); step==$FF? decrement flag, frame=$7F, RET
C $B649,14 already-armed? step==$4D? branch; else store frame (IY+2)
C $B657,7 step==$4D and prev==$4D? RET
C $B65E,10 phase ($5C3D) -> lookup table $B6BB (hazard code)
C $B668,14 store code $5C3C; +=$80 -> frame $5B12; clear $5B13; RET
C $B676,19 direction/edge flag handling; C=+/-2 step
C $B689,18 advance position ($5B10); compute column check (AND $1F)
C $B69B,13 reset script step; column bounds check ($C0/$22)
C $B6A8,6 bound RET; clear flag
C $B6AE,13 frame-cycle animation via frame counter
C $B5E1,3 Classify object type ((IX+2)) into a size/category flag
C $B5F8,3 Reset object slots ($5C0E), scan $B99D table for current room
C $B5FB,3 Populate the $5BD6 object-slot table
C $B601,3 Save all registers
C $B60F,3 => Force room $28, set $5BFE flag, trigger event via #R$AE85
C $B6AE,3 get Frame counter
b $B6BB
t $B6C1
b $B6EC
c $B6EE Force room $28, set $5BFE flag, trigger event via #R$AE85
C $B6F0,3 set Current room number
C $B6F3,3 Set up the current room
c $B704 Position+room gate: room $5B98=$0D, status $5C06=0 -> trigger $1B via #R$AE85
C $B704,6 Y==$20?
C $B70A,6 X in [$76,$84)?
C $B713,6 room ($5B98)==$0D?
C $B719,5 status ($5C06)==0 (idle/normal)?
C $B71E,5 trigger $1B via #R$AE85
c $B723 Init object Y=8, falls into #R$B735
c $B72D Init object Y=$DC (variant); animation frame + type-gated deactivate
C $B72D,8 IY=$5B14; (IY+0)=$DC (variant Y init)
C $B735,12 frame=$12; C=$56 (+1 if flag $5C43 set)
C $B741,12 store frame; if C!=0 skip to $B75C; else room==$10?
C $B750,9 type gate fail? else deactivate object ($5B98=$FF, set $5C43)
C $B75C,9 A=flag ($5C42); CALL #R$B779 (arm/disarm); HL=$5C40
C $B768,5 type gate fail: clear flag ($5C40)=0; RET
C $B76D,8 flag ($5C40) already set? RET; else set=1; HL=$5C42
C $B775,4 flip flag ($5C42)
C $B779,11 arm/disarm (IY+3) bit7 by flag; RET
C $B74D,3 Classify object type ((IX+2)) into a size/category flag
C $B759,3 => Populate the $5BD6 object-slot table
C $B765,3 Classify object type ((IX+2)) into a size/category flag
c $B784 Stage counter advance ($5C41); at stage $14 check $5C3F, trigger $17 via #R$AE85
C $B784,6 HL=$5C41; A=(HL); stage==$14?
C $B78A,6 else stage==$15? RET Z; default: increment stage
C $B790,1 RET
C $B791,5 stage $14: check $5C3F flag, RET NZ
C $B796,6 increment stage; trigger $17 via #R$AE85
c $B79C Fill-pattern variant A (B=$15, base $F940), falls into #R$B7A8
c $B7A3 Fill-pattern variant B (B=$0B, base $F954): init position, draw pattern via #R$9A4D
C $B7A3,6 B=$0B rows; HL=$F954 (base); A=0
C $B7A9,9 clear position fields ($5B09/$5B0D/$5B11)
C $B7B2,6 X ((IX+0)) -> $5B14
C $B7B8,9 Y+8, clamp <$5A -> store, else skip
C $B7C1,3 store Y -> $5B15
C $B7C7,11 checkerboard color pick (row/column parity) + $BC
C $B7D2,2 save BC/HL
C $B7D7,6 restore HL, HL++; restore BC; loop; RET
C $B7C4,3 get Frame counter
C $B7D4,3 Write A to (HL), DE=HL, fall into #R$9A62 dual-write loop
c $B7DD Per-room init dispatch: table $B7EC indexed by room, jump via #R$A6DD
b $B7EC
B $B87C,1 Input bits: 000FUDLR
c $B87D Resolve conflicting L/R, U/D input via #R$B894 (cancel to 0)
C $B87D,4 read input via #R$B894; E=result
C $B881,8 L+R both pressed? cancel to 0
C $B889,9 U+D both pressed? cancel to 0
C $B892,2 return E (no conflict)
C $B87D,3 Read joystick/keyboard, normalize to Kempston-style bitmask
c $B894 Read joystick/keyboard, normalize to Kempston-style bitmask
N $B894 Device selected by ($94AF): 0=keyboard (redefined keys, table at $B8D4), 1=Kempston (port $1F), 2=Sinclair 2 (keys 6-0, port $EFFE). Result stored at $B87C: bit0=right, bit1=left, bit2=down, bit3=up, bit4=fire.
C $B899,7 device=0: keyboard
C $B8A0,3 device=1: Kempston
C $B8A3,5 device=2: Sinclair, read port $EFFE
C $B8C4,3 => Return normalized input bitmask
C $B8C9,3 => Return normalized input bitmask
C $B8CC,5 device=1: read Kempston port $1F
C $B8D1,3 => Return normalized input bitmask
b $B8D4
c $B930 Return normalized input bitmask ($B87C)
c $B932 Clear active flag (bit7) across all $B99D creature-table entries
c $B93F Reset object slots ($5C0E), scan $B99D table for current room
C $B94E,3 get Current room number
C $B956,3 Spawn a creature/hazard into slot $5C0E/$5C13 from a room-data entry
c $B95F Spawn a creature/hazard into slot $5C0E/$5C13 from a room-data entry (HL)
C $B95F,3 skip if bit1 of C set
C $B962,12 pick slot: bit0 of C chooses $5C0E or $5C13
C $B972,6 store room-data record pointer (IX+3/4)
C $B97D,5 type = record byte0 AND $1F
C $B986,12 decode X sub-position from C
C $B992,7 decode Y sub-position from C
N $B99D Room-tagged creature/encounter table, separate from the per-room $C152 table (see Actors.md). 31 entries, 3 bytes each: byte0=room number this entry belongs to (bit7 double-purposed as a flag - toggled in bulk at init by #R$B932 and individually by #R$B9FA's boss-entry check at $B9D9, entry 20; exact armed-vs-consumed sense of the bit not confirmed), byte1=type ID (low 5 bits, top 3 bits unconfirmed), byte2=packed slot-choice/skip-flag/X-Y-sub-position, decoded by #R$B95F. Scanned linearly by #R$B93F on room entry; matches spawn into object slots $5C0E/$5C13 (only 2 at a time, unlike $C152's fixed 3 slots). Entry 20 ($B9D9, room $30) is the one #R$B9FA treats as "the boss" - it's the only entry individually addressed by room-specific code rather than only via the linear scan.
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
s $BA96
c $BA97 Gate + room-specific visual effect (room $3A special-cased)
N $BA97 Gated by a per-frame flag ($5C0C/$5C0D); room $3A gets special-cased clamping of the player's X against fixed bounds. Drives a room-specific animated visual effect: an effect index (masked to 7 bits from a stored byte) selects into a table at $F968, throttled by the frame counter so it advances slower than every frame, then drawn via #R$9A52. The (HL)=1 vs (HL)=$10 branch on the effect index ($BAD1/$BAD7) picks between two effect speeds/phases depending on whether the index is past $7A. Likely the room $3A steam/water effect seen on the player-made map notes, but not confirmed live.
C $BA97,8 C=A; if ($5C0C) set, go to alt path
C $BA9F,4 Always-true stub (CP A), used by #R$BA97
C $BAA3,3 room match check ($3A)
C $BABC,6 clamp player X, low bound
C $BAC2,10 clamp player X, high bound
C $BACC,5 arm timer flag ($5C0D)=0
C $BAD1,5 (HL)=1 if effect index < $7A
C $BAD7,8 else (HL)=$10, flag=1
C $BADF,3 E=A; A&=$7F (effect index)
C $BAE2,3 HL = effect table base ($F968)
C $BAE9,6 throttle by frame counter ($5C02)
C $BB19,3 draw effect byte via #R$9A52
C $BAE9,3 get Frame counter
C $BAFE,3 get Current room number
C $BB0F,3 get Current room number
C $BB19,3 Write A to (HL)+$6000 (secondary buffer), then #R$9A62 dual-write loop
b $BB51
c $BB59 Always-true stub (CP A), used by #R$BA97
c $BB5D Item pickup/hint check for both creature slots ($5C0E, $5C13)
N $BB5D Runs once per frame for each of the two creature object slots ($5C0E, $5C13), checking whether that object represents a *collectible item* rather than a hazard (via #R$9140's type classification) and, if so, whether the hero is close enough and an inventory slot is free (scans the 27-slot log at $5B7C for a free entry). Special-cases item type $16 (latches the current room into $5C3F - likely a "last item room" bookmark for a specific quest item). For a subset of item types ($08/$0E/$14), additionally requires the hero to be in room-state 2 with the hazard timer past 10 before allowing pickup - i.e. some items can only be collected mid-animation of some other event. On a successful pickup: snaps the hero's position to the item, sets status $5C06=5 (the pickup animation, see Actors.md), deactivates the item object, and refreshes the display slots. See Items-Format.md for the inventory log format itself.
C $BB5D,8 IX=$5B04 (player); run for slot $5C0E then $5C13
C $BB70,6 classify object type ((IX+2)); skip if not a trackable type
C $BB7E,9 scan 27-slot inventory log ($5B7C) for a free ($FF) slot; C=count found
C $BB8F,10 special item $16: latch room into $5C3F
C $BBA5,12 only when ($5C06)=2 and hazard timer ($5C07)>=10
C $BBB3,12 |Y delta| vs (IY+0) must be <6 (in range)
C $BBC1,18 snap IX position to (IY+0/1)-23; state=15; ($5C06)=5
C $BBDA,18 else: latch room ($5B98) into HL slot, save regs, fire event 2 via #R$C4B2
C $BBF2,3 Sound-effect dispatcher wrapper
C $BBFA,10 clear IY object (type=$FE), hide its display object (SET 7)
C $BC07,3 D!=0: #R$9E5D refresh $5BD6 slots
C $BC11,8 pick index from C (0/1/2+), store $5C23, #R$9EBD init slots
C $BB70,3 Classify object type ((IX+2)) into a size/category flag
C $BBEC,3 Save all registers
C $BC0A,3 Populate the $5BD6 object-slot table
C $BC1C,3 => Init $5BD6 object slots from $5C23
c $BC1F Cycle inventory selection via keys (port $F7FE), animate scroll ($5C21/$5C22)
C $BC50,3 Init $5BD6 object slots from $5C23
C $BC64,3 => Init $5BD6 object slots from $5C23
C $BC69,3 => Init $5BD6 object slots from $5C23
C $BC70,3 => Init $5BD6 object slots from $5C23
c $BC73 Room $5B98=$0C seesaw trigger: position gate, toggle Y $46/$48, room-state trigger
N $BC73 Gated on room-category $5B98=$0C and the hero standing at Y=$46 or $48, X in a fixed range. Every other frame (frame counter bit0), flips the hero's Y between $46 and $48 - a two-frame teeter/seesaw motion - and arms the hero's direction flag. Once fully settled at X in [$28,$34), on a 4-frame cadence sets room-state to 6 (#R$BCB4) and increments a counter at (HL); reaching $0C fires #R$AE84 (reset). Between $06 and $0C it instead computes an index into a sound-effect table ($F928) and plays it via #R$9A52's write-and-dual-buffer path. Reads as a seesaw/rocking-platform puzzle piece: stand at the sweet spot, it rocks you for a few frames, plays an escalating sound cue, then resolves.
C $BC73,7 gate: flag ($5C24)!=$0D
C $BC7A,6 room ($5B98)==$0C?
C $BC80,10 player Y==$48 or $46?
C $BC8A,10 player X in [$28,$34)?
C $BC94,4 arm flag (IX+3) bit7
C $BC98,3 get Frame counter
C $BC9B,4 frame bit0: toggle Y=$46/$48
C $BC9F,4 store Y=$46
C $BCA3,9 restore Y=$48 unless already there
C $BCAC,3 get Frame counter
C $BCAF,5 frame&3!=0? RET; else A=6
C $BCB4,5 store room-state=6; read/inc counter (HL)
C $BCB9,2 counter==$0C?
C $BCBB,3 => Reset room state=0 and hazard counter ($5C07)
C $BCBE,8 counter-6; RET C if negative; C=A; compute 6-C
C $BCC6,7 HL=(6-C)*32 (table row offset)
C $BCCD,7 HL += $F928 (sound-effect table); save HL; A=$98
C $BCD4,3 Write A to (HL)+$6000 (secondary buffer), then #R$9A62 dual-write loop
C $BCD7,4 restore HL, HL++; A=$99
C $BCDB,3 => Write A to (HL)+$6000 (secondary buffer), then #R$9A62 dual-write loop
c $BCDE Negate 4-byte value ($5C18) via CPL chain, falls into #R$BD15 (add DE:BC=1)
C $BCDE,12 negate 3 bytes (CPL each), HL-- between (unrolled)
C $BCEA,3 negate last byte (CPL), no HL--
C $BCED,5 DE=1; JR into #R$BD15 (add path)
c $BCF2 Save all registers (context-save wrapper)
R $BCF2 DE score delta to add (passed through to #R$BD11)
C $BCF2,7 push main regs (IX,IY,HL,BC,AF)
C $BCF9,5 EXX; push alt regs (HL',BC',DE')
C $BCFE,6 Add 32-bit value ($5C18) by DE:BC
C $BD04,12 EXX; pop alt regs; EXX; pop main regs
c $BD11 Add 32-bit value ($5C18) by DE:BC (BC sign-extended from D)
C $BD11,4 IX=$5C18 (target)
C $BD15,7 BC = -1 if D negative, else 0 (sign-extend)
C $BD1F,6 HL=(IX+0/1) low word
C $BD25,7 HL+=DE; store low word
C $BD2C,6 HL=(IX+2/3) high word
C $BD32,8 HL+=BC with carry; store high word; RET
c $BD3B Print hi-score ($5B78) at screen $5049 via #R$BD78
c $BD50 New high-score check: compare $5C1B vs stored $5B7B, save if beaten
C $BD50,6 HL=candidate ($5C1B); already flagged (bit7) -> skip
C $BD56,5 DE=stored record ($5B7B); B=4 digits
C $BD5B,7 compare digit-by-digit (candidate vs stored), high digit first
C $BD62,5 next digit (both pointers-- ); loop
C $BD67,14 new record: copy 4 bytes $5C18 to $5B78, #R$BD3B
c $BD75 Print current score at screen $5029, falls into #R$BD78
C $BD75,4 HL=$5029; save HL
C $BD79,4 B=4 (digit count); A=$20 (space, clear digits)
C $BD80,3 loop 4 spaces; restore HL
C $BD83,8 clear leading-zero flag ($5C20); HL=$5C18
C $BD8B,8 DE=$5C1C; BC=4; copy score to work buffer
C $BD93,6 swap; DEC HL; IX=$5C1C
C $BD99,4 sign bit set?
C $BDA0,6 skip negate; IY=$BE18 (digit-weight table)
C $BDA6,3 B=4 digits; save BC
C $BDA9,17 C=0 (digit counter); DE:B=divisor from table; IY+=3 (next entry)
C $BDBD,7 leading-zero flag; digit!=0? skip
C $BDC4,6 else re-check leading-zero flag; set if digit=0
C $BDCA,2 convert digit to ASCII
C $BDCC,1 EXX
C $BDD0,2 EXX; restore BC
C $BDD2,3 loop 4 digits; RET
C $BDD5,7 restore BC; last digit (B==1)? force display
C $BDDC,3 push BC; back to convert (force minimum one digit)
C $BD7D,3 Draw character bitmap
C $BD9D,3 Negate 4-byte value ($5C18) via CPL chain, falls into #R$BD15
C $BDBA,3 Repeated-subtraction division
C $BDCD,3 Draw character bitmap
c $BDDF Repeated-subtraction division: subtract DE from 32-bit (IX+0..3), C=count
C $BDDF,7 HL = (IX+0)/(IX+1) (low word)
C $BDE6,9 subtract DE from HL, store back
C $BDEF,8 subtract borrow from (IX+2)
C $BDF7,11 subtract borrow from (IX+3); stop if underflow
C $BE02,6 no underflow: pop, C++, loop
C $BE08,16 underflow: restore previous values, return
b $BE18
c $BE42 Decode room's creatures/hazards from the room data table ($C152)
C $BE42,1 save A (room number)
C $BE4C,4 clear 29-byte scratch buffer
C $BE59,4 HL = room data table + A*12
C $BE65,2 byte0 low nibble = creature type ID
C $BE6C,2 byte0 bit7 = flag
C $BE75,2 byte0 bits4-6
C $BE8E,4 advance output pointer +10, next slot
C $BE96,2 restore A, return
N $BE42 A = current room number (from $5C01, still live in A when #R$9855 falls through into this). HL = $C152 + A*12 - the room data table, one 12-byte record per room (0-based, matching the level*12+col numbering). Clears a 29-byte scratch buffer at $BE24, then decodes the record as 3 sub-records of 4 raw bytes each: byte0 low nibble (creature type ID, written twice - see #R$C152), byte0 bit7 (flag), byte0 bits4-6 (3-bit field), byte1 and byte2 (raw copy), byte3 low 7 bits and byte3 bit7 (separately). 3 creature/hazard slots per room; all-zero sub-record = empty slot. Meaning of byte1-3 within a filled slot (position? behavior?) not yet confirmed. Returns A unchanged (original value restored via the outer PUSH/POP AF).
R $BE42 A room number
c $BE98 Dispatch per-creature-type init (jump table $BECA) for the 3 hazard slots
C $BE98,11 B=3 slots; DE=decoded record ($BE24); IX=$5B08 object base
C $BEA5,5 HL = creature type * 2
C $BEAA,4 HL = jump table entry ($BECA + type*2)
C $BEAE,4 HL = jump target address
C $BEB2,6 IY=record pointer; CALL #R$BEC9 (trampoline to type handler)
C $BEB8,5 IX += 4 (next object slot)
C $BEBD,9 advance DE by 10, next record
c $BEC9 Jump to handler in HL (dispatch tail of #R$BE98)
b $BECA
c $BEDC No-op stub (RET)
c $BEDD Move object along X by 2px, bounce off walls/edges
C $BEDD,9 gate check; CALL #R$C135 if needed
C $BEE6,9 check direction flag; A=X position
C $BEEF,4 move -2, check underflow
C $BEF3,12 store position; check collision via #R$C0FD
C $BEFF,3 => Advance animation frame
C $BF08,11 blocked/edge: flip direction flag
C $BF16,3 Wrapper
C $BF1F,3 => Advance animation frame
c $BF22 Move object along Y by 2px, bounce off walls/edges
C $BF22,9 gate check; CALL #R$C135 if needed
C $BF2B,9 check direction flag; A=Y position
C $BF34,4 move -2, check underflow
C $BF38,12 store position; check collision via #R$C115
C $BF44,3 => Advance animation frame
C $BF4D,11 blocked/edge: flip direction flag
C $BF5B,3 Wrapper
C $BF64,3 => Advance animation frame
c $BF67 Move object -X by 2px (timed via #R$BFA0), bounce via #R$C0FD
C $BF69,3 Countdown timer
C $BF8E,3 Wrapper
C $BF97,3 => Advance animation frame
C $BF9D,3 => Advance animation frame
c $BFA0 Countdown timer (IY+8): init via #R$9390 if zero, else decrement
R $BFA0 C low bit merged into new random timer value
R $BFA0 IY object (timer at +8)
R $BFA0 O:Zf set when timer reaches 0
C $BFA0,6 flag!=0? skip init
C $BFA6,3 CALL #R$C135 (gate/init helper)
C $BFAC,9 mask random to 7-bit, OR type flag C; store; reload
C $BFB5,6 decrement; RET Z; store; RET
C $BFA9,3 Pseudo-random byte
c $BFBB Move object +X by 2px (timed via #R$BFA0), bounce via #R$C109
C $BFBD,3 Countdown timer
C $BFE4,3 Wrapper
C $BFED,3 => Advance animation frame
C $BFF3,3 => Advance animation frame
c $BFF6 Animate object Y-position; falls into #R$C000 (paged-bank helper, called by #R$8F47/#R$9491)
C $BFF8,3 Countdown timer
C $C012,12 store new Y; check paged flag ($C132)
C $C01E,14 advance animation frame counter ((IY+7))
C $C03A,14 reverse-direction animation branch
C $C051,3 => Sound-effect dispatcher wrapper
c $C054 Idle-frame check ($55/$7F), else #R$C0AC advance animation
C $C066,3 => Advance animation frame
c $C069 Advance animation frame counter (IY+7), compute sprite frame (IX+2)
C $C069,6 CALL #R$BFA0 gate check
C $C06F,9 increment frame counter; check bit4 (cycle end)
C $C078,13 cycle end: reset counter and (IY+8)
C $C085,13 else: decode frame index from counter bits
C $C092,7 frame = decoded index + (IY+4), store to (IX+2)
c $C0AC Advance animation frame; check player collision, trigger effect via #R$AE85
C $C0AC,9 advance frame counter (IY+7)
C $C0B5,9 compute frame index -> (IX+2)
C $C0C4,5 skip unless (IY+2) high bit set
C $C0C9,7 if (IY+3)>=4, go to collision check
C $C0DA,6 IY=player
C $C0E6,8 default trigger code=$18; skip special check unless room 0
C $C0EE,11 room 0: check $A101 flag, alt code=$1A
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
s $C12D
c $C12E Unused/scratch flag bytes (NOP-initialized, $C12E-$C132)
C $C12E,7 unused scratch bytes (7 NOPs)
C $C135,4 set gate flag (IY+8)=1
R $C135 IX object to init
R $C135 IY template (position at +4/+5/+6, direction at +7)
C $C139,25 copy template position/frame: IY(+5,+6,+4,+7) -> IX(+0,+1,+2,+3); RET
b $C152
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
R $C4B2 A sound-effect index (0-6)
C $C4B5,3 Sound-effect table lookup
c $C4BC Sound-effect table lookup ($C55B): push handler address, E=$10, tail-call
C $C4BC,4 A>=7? RET NC (invalid index)
C $C4C0,7 HL=table ($C55B) + A*2 (index)
C $C4C7,4 DE=(HL) (handler address); push DE
C $C4CB,3 E=$10; RET (tail-call via stack)
c $C4CE Beeper tone-sweep effect (raw OUT $FE)
C $C4CE,5 H=$7F (sweep count); A=0; B=$0A (bit count)
C $C4D3,2 save BC; B=H (duty count)
C $C4D5,6 toggle beeper port, delay; loop duty; then bits
C $C4DB,5 flip bit value; restore BC; loop bits
C $C4E0,9 H>>=2; repeat sweep until H=0
c $C4E9 Play sound effect (raw OUT $FE beeper timing loop)
C $C4E9,6 HL=0 (sample pointer); BC=$2328 (sample count)
C $C4EF,7 per-sample delay calc (A=$23-B)
C $C4F6,3 busy-wait delay; restore BC
C $C4F9,5 read+mask sample, output to speaker; HL++
C $C4FE,8 BC-=4; loop until 0
C $C506,5 H=3 (sweep count); A=0; B=$0A (bit count)
C $C50B,2 save BC; B=H (duty)
C $C50D,6 toggle port, delay; loop duty
C $C513,5 flip bit; restore BC; loop bits
C $C518,9 sweep H via RL/carry; loop until H=$FF; RET
c $C521 Play noise-type sound effect (R-register based)
c $C532 Beeper tone effect variant A (HL=$03C8), falls into #R$C53A
c $C537 Beeper tone effect variant B (HL=$0564)
C $C537,3 HL=$0564 (tone period)
C $C53A,6 A=0; B=L; toggle port; busy-wait delay
C $C540,4 A=E (mask); toggle port; B=L
C $C544,3 busy-wait delay
C $C547,3 DEC H; loop until H=0; RET
b $C54A
c $C54B Beeper noise/sample effect (raw OUT $FE)
C $C54B,3 NOPs (timing pad); B=L (outer count)
C $C54E,2 C=5 (inner count)
C $C550,8 read sample byte, mask, output to port; HL++; loop 5
C $C558,3 loop outer; RET
b $C55B
b $C600
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
b $DEC0
b $DF00 Tile index -> attribute byte table
N $DF00 256 bytes, one per possible tile index (0-255). Looked up directly by tile index (A + $DF00, no multiply) by #R$99A4 to get the color attribute written to the attribute file when blitting a room's tile map ($F800) to the screen.
N $E000 Border-frame graphic (top/bottom pieces), blitted by #R$93AF via #R$94B0
b $E000
t $E120
b $E124
t $E129
b $E12E
t $E141
b $E146
t $E149
b $E14E
t $E14F
b $E152
t $E222
b $E225
t $E229
b $E22D
t $E244
b $E247
t $E249
b $E24D
t $E28D
b $E290
t $E329
b $E32D
t $E349
b $E34F
t $E429
b $E42D
t $E449
b $E44E
t $E521
b $E525
t $E529
b $E52D
t $E543
b $E547
t $E549
b $E54F
t $E621
b $E625
t $E629
b $E62F
t $E640
b $E647
t $E649
b $E64E
t $E64F
b $E652
t $E74F
b $E752
t $E800
b $E82D
t $E831
b $E835
t $E836
b $E83F
t $E840
b $E84D
t $E851
b $E855
t $E856
b $E85F
t $E871
b $E875
t $E876
b $E87F
t $E880
b $E88A
t $E891
b $E895
t $E896
b $E89F
t $E8A0
b $E8AA
t $E8B1
b $E8B5
t $E8B6
b $E8BF
t $E8C0
b $E8CA
t $E8D1
b $E8D5
t $E8D6
b $E8DF
t $E8EB
b $E8F2
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
b $EC90
b $F000 Tile pixel bitmap table
N $F000 8 bytes per tile index, at ($5B72)+tile_index*8 (5B72=$F000, set by #R$8F47). Copied to the real screen by #R$99A4 when blitting a room's tile map ($F800) - this is the actual pixel data for the 8x8 "tiles" that make up a room's back-tiles.
b $F800
t $F82D
b $F830
t $F8AD
b $F8B2
t $F8B3
b $F8B8
t $F8BB
b $F8C0
t $F8CD
b $F8E0
t $F8F5
b $F8F8
t $F934
b $F93B
t $F955
b $F95B
t $F975
b $F97A
t $F9B4
b $F9B9
t $F9D5
b $F9D8
t $F9DC
b $F9E0
t $FAC0
s $FAC8
t $FAC9
b $FAD0
t $FAE8
b $FAEE
t $FAF0
b $FAF9
t $FB1B
b $FB20
t $FB23
b $FB28
t $FB49
b $FB4F
t $FB50
b $FB53
t $FB55
b $FB59
t $FB80
b $FB85
t $FBE3
b $FBE6
t $FC1A
b $FC1F
t $FC2B
b $FC2E
t $FC4B
b $FC50
t $FC52
b $FC59
t $FC80
b $FC90
t $FC98
b $FC9D
t $FCA9
b $FCAC
t $FCB0
b $FCB6
t $FCC2
b $FCC9
t $FCDA
b $FCE0
t $FCF0
b $FCF8
t $FD03
b $FD07
t $FD08
b $FD10
t $FD17
b $FD1D
t $FD4A
b $FD4D
t $FD64
b $FD68
N $FF00 Sprite blend mask table, used by #R$9DE3
t $FF80
b $FF88
t $FF89
b $FF90
