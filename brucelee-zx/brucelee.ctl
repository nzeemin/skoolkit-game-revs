@ $5B00 org
b $5B00
B $5B00,1280,8
b $6000
@ $6000 label=current_room_playing_data
N $6000 Room header (64 bytes)
B $6000,64,16
N $6040 Room tile map (704 bytes), 22 rows * 32 columns
B $6040,704,16
b $6300 Background tile colors
N $6300 See #R$9800 for background tiles pixel data.
@ $6300 label=bktile_colors
B $6300,256,8
w $6400 list of rooms addresses
@ $6400 label=rooms_table
W $6400,40,2
b $6428
B $6428,1,1
b $6429 Rooms data
N $6429 Room 04 data
N $6429 #HTML[<img src="images/rooms/room04.png" />]
@ $6429 label=room04_desc
W $6429,2,2 address of scene graphical primitives
B $642B,1,1
B $642C,1,1 Color palette
B $642D,2,2
W $642F,2,2 Address of room's extra data
B $6431,4,4 Respawn point: X,Y,direction,0
B $6435,2,2 Players visit flags
B $6437,4,4 X/Y thresholds
B $643B,27,9 Exit table for 9 zones
B $6456,19,8 Additional room configuration
B $6469,480,9 RLE sequence of room data
B $6649 Room 04 extra data (key placement list)
N $66D3 Room 00 data
N $66D3 #HTML[<img src="images/rooms/room00.png" />]
@ $66D3 label=room00_desc
W $66D3,2,2 address of scene graphical primitives
B $66D5,1,1
B $66D6,1,1 Color palette
B $66D7,2,2
W $66D9,2,2 Address of room's extra data
B $66DB,4,4 Respawn point: X,Y,direction,0
B $66DF,2,2 Players visit flags
B $66E1,4,4 X/Y thresholds
B $66E5,27,9 Exit table for 9 zones
B $6700,19,8 Additional room configuration
B $6713,372,9 RLE sequence of room data
B $6887 Room 00 extra data (key placement list)
N $68AB Room 01 data
N $68AB #HTML[<img src="images/rooms/room01.png" />]
@ $68AB label=room01_desc
W $68AB,2,2 address of scene graphical primitives
B $68AD,1,1
B $68AE,1,1 Color palette
B $68AF,2,2
W $68B1,2,2 Address of room's extra data
B $68B3,4,4 Respawn point: X,Y,direction,0
B $68B7,2,2 Players visit flags
B $68B9,4,4 X/Y thresholds
B $68BD,27,9 Exit table for 9 zones
B $68D8,19,8 Additional room configuration
B $68EB,299,9 RLE sequence of room data
B $6A16 Room 01 extra data (key placement list)
N $6A48 Room 02 data
N $6A48 #HTML[<img src="images/rooms/room02.png" />]
@ $6A48 label=room02_desc
W $6A48,2,2 address of scene graphical primitives
B $6A4A,1,1
B $6A4B,1,1 Color palette
B $6A4C,2,2
W $6A4E,2,2 Address of room's extra data
B $6A50,4,4 Respawn point: X,Y,direction,0
B $6A54,2,2 Players visit flags
B $6A56,4,4 X/Y thresholds
B $6A5A,27,9 Exit table for 9 zones
B $6A75,19,8 Additional room configuration
B $6A88,473,9 RLE sequence of room data
B $6C61 Room 02 extra data (key placement list)
N $6CBB Room 03 data
N $6CBB #HTML[<img src="images/rooms/room03.png" />]
@ $6CBB label=room03_desc
W $6CBB,2,2 address of scene graphical primitives
B $6CBD,1,1
B $6CBE,1,1 Color palette
B $6CBF,2,2
W $6CC1,2,2 Address of room's extra data
B $6CC3,4,4 Respawn point: X,Y,direction,0
B $6CC7,2,2 Players visit flags
B $6CC9,4,4 X/Y thresholds
B $6CCD,27,9 Exit table for 9 zones
B $6CE8,19,8 Additional room configuration
B $6CFB,524,9 RLE sequence of room data
B $6F07 Room 03 extra data (key placement list)
N $6F2E Room 06 data
N $6F2E #HTML[<img src="images/rooms/room06.png" />]
@ $6F2E label=room06_desc
W $6F2E,2,2 address of scene graphical primitives
B $6F30,1,1
B $6F31,1,1 Color palette
B $6F32,2,2
W $6F34,2,2 Address of room's extra data
B $6F36,4,4 Respawn point: X,Y,direction,0
B $6F3A,2,2 Players visit flags
B $6F3C,4,4 X/Y thresholds
B $6F40,27,9 Exit table for 9 zones
B $6F5B,19,8 Additional room configuration
B $6F6E,327,9 RLE sequence of room data
B $70B5 Room 06 extra data (key placement list)
N $7137 Room 07 data
N $7137 #HTML[<img src="images/rooms/room07.png" />]
@ $7137 label=room07_desc
W $7137,2,2 address of scene graphical primitives
B $7139,1,1
B $713A,1,1 Color palette
B $713B,2,2
W $713D,2,2 Address of room's extra data
B $713F,4,4 Respawn point: X,Y,direction,0
B $7143,2,2 Players visit flags
B $7145,4,4 X/Y thresholds
B $7149,27,9 Exit table for 9 zones
B $7164,19,8 Additional room configuration
B $7177,499,9 RLE sequence of room data
B $736A Room 07 extra data (key placement list)
N $73E8 Room 09 data
N $73E8 #HTML[<img src="images/rooms/room09.png" />]
@ $73E8 label=room09_desc
W $73E8,2,2 address of scene graphical primitives
B $73EA,1,1
B $73EB,1,1 Color palette
B $73EC,2,2
W $73EE,2,2 Address of room's extra data
B $73F0,4,4 Respawn point: X,Y,direction,0
B $73F4,2,2 Players visit flags
B $73F6,4,4 X/Y thresholds
B $73FA,27,9 Exit table for 9 zones
B $7415,19,8 Additional room configuration
B $7428,545,9 RLE sequence of room data
B $7649 Room 09 extra data (key placement list)
N $765F Room 0B data
N $765F #HTML[<img src="images/rooms/room0B.png" />]
@ $765F label=room0B_desc
W $765F,2,2 address of scene graphical primitives
B $7661,1,1
B $7662,1,1 Color palette
B $7663,2,2
W $7665,2,2 Address of room's extra data
B $7667,4,4 Respawn point: X,Y,direction,0
B $766B,2,2 Players visit flags
B $766D,4,4 X/Y thresholds
B $7671,27,9 Exit table for 9 zones
B $768C,19,8 Additional room configuration
B $769F,518,9 RLE sequence of room data
B $78A5 Room 0B extra data (key placement list)
N $78BB Room 0C data
N $78BB #HTML[<img src="images/rooms/room0C.png" />]
@ $78BB label=room0C_desc
W $78BB,2,2 address of scene graphical primitives
B $78BD,1,1
B $78BE,1,1 Color palette
B $78BF,2,2
W $78C1,2,2 Address of room's extra data
B $78C3,4,4 Respawn point: X,Y,direction,0
B $78C7,2,2 Players visit flags
B $78C9,4,4 X/Y thresholds
B $78CD,27,9 Exit table for 9 zones
B $78E8,19,8 Additional room configuration
B $78FB,708,9 RLE sequence of room data
B $7BBF Room 0C extra data (key placement list)
N $7BF4 Room 0D data
N $7BF4 #HTML[<img src="images/rooms/room0D.png" />]
@ $7BF4 label=room0D_desc
W $7BF4,2,2 address of scene graphical primitives
B $7BF6,1,1
B $7BF7,1,1 Color palette
B $7BF8,2,2
W $7BFA,2,2 Address of room's extra data
B $7BFC,4,4 Respawn point: X,Y,direction,0
B $7C00,2,2 Players visit flags
B $7C02,4,4 X/Y thresholds
B $7C06,27,9 Exit table for 9 zones
B $7C21,19,8 Additional room configuration
B $7C34,635,9 RLE sequence of room data
B $7EAF Room 0D extra data (key placement list)
N $7EEC Room 0E data
N $7EEC #HTML[<img src="images/rooms/room0E.png" />]
@ $7EEC label=room0E_desc
W $7EEC,2,2 address of scene graphical primitives
B $7EEE,1,1
B $7EEF,1,1 Color palette
B $7EF0,2,2
W $7EF2,2,2 Address of room's extra data
B $7EF4,4,4 Respawn point: X,Y,direction,0
B $7EF8,2,2 Players visit flags
B $7EFA,4,4 X/Y thresholds
B $7EFE,27,9 Exit table for 9 zones
B $7F19,19,8 Additional room configuration
B $7F2C,581,9 RLE sequence of room data
B $8171 Room 0E extra data (key placement list)
N $81AF Room 0A data
N $81AF #HTML[<img src="images/rooms/room0A.png" />]
@ $81AF label=room0A_desc
W $81AF,2,2 address of scene graphical primitives
B $81B1,1,1
B $81B2,1,1 Color palette
B $81B3,2,2
W $81B5,2,2 Address of room's extra data
B $81B7,4,4 Respawn point: X,Y,direction,0
B $81BB,2,2 Players visit flags
B $81BD,4,4 X/Y thresholds
B $81C1,27,9 Exit table for 9 zones
B $81DC,19,8 Additional room configuration
B $81EF,596,9 RLE sequence of room data
B $8443 Room 0A extra data (key placement list)
N $8469 Room 10 data
N $8469 #HTML[<img src="images/rooms/room10.png" />]
@ $8469 label=room10_desc
W $8469,2,2 address of scene graphical primitives
B $846B,1,1
B $846C,1,1 Color palette
B $846D,2,2
W $846F,2,2 Address of room's extra data
B $8471,4,4 Respawn point: X,Y,direction,0
B $8475,2,2 Players visit flags
B $8477,4,4 X/Y thresholds
B $847B,27,9 Exit table for 9 zones
B $8496,19,8 Additional room configuration
B $84A9,189,9 RLE sequence of room data
B $8566 Room 10 extra data (key placement list)
N $85B5 Room 11 data
N $85B5 #HTML[<img src="images/rooms/room11.png" />]
@ $85B5 label=room11_desc
W $85B5,2,2 address of scene graphical primitives
B $85B7,1,1
B $85B8,1,1 Color palette
B $85B9,2,2
W $85BB,2,2 Address of room's extra data
B $85BD,4,4 Respawn point: X,Y,direction,0
B $85C1,2,2 Players visit flags
B $85C3,4,4 X/Y thresholds
B $85C7,27,9 Exit table for 9 zones
B $85E2,19,8 Additional room configuration
B $85F5,351,9 RLE sequence of room data
B $8754 Room 11 extra data (key placement list)
N $8781 Room 0F data
N $8781 #HTML[<img src="images/rooms/room0F.png" />]
@ $8781 label=room0F_desc
W $8781,2,2 address of scene graphical primitives
B $8783,1,1
B $8784,1,1 Color palette
B $8785,2,2
W $8787,2,2 Address of room's extra data
B $8789,4,4 Respawn point: X,Y,direction,0
B $878D,2,2 Players visit flags
B $878F,4,4 X/Y thresholds
B $8793,27,9 Exit table for 9 zones
B $87AE,19,8 Additional room configuration
B $87C1,200,9 RLE sequence of room data
B $8889 Room 0F extra data (key placement list)
N $888A Room 12 data
N $888A #HTML[<img src="images/rooms/room12.png" />]
@ $888A label=room12_desc
W $888A,2,2 address of scene graphical primitives
B $888C,1,1
B $888D,1,1 Color palette
B $888E,2,2
W $8890,2,2 Address of room's extra data
B $8892,4,4 Respawn point: X,Y,direction,0
B $8896,2,2 Players visit flags
B $8898,4,4 X/Y thresholds
B $889C,27,9 Exit table for 9 zones
B $88B7,19,8 Additional room configuration
B $88CA,484,9 RLE sequence of room data
B $8AAE Room 12 extra data (key placement list)
N $8AB3 Room 05 data
N $8AB3 #HTML[<img src="images/rooms/room05.png" />]
@ $8AB3 label=room05_desc
W $8AB3,2,2 address of scene graphical primitives
B $8AB5,1,1
B $8AB6,1,1 Color palette
B $8AB7,2,2
W $8AB9,2,2 Address of room's extra data
B $8ABB,4,4 Respawn point: X,Y,direction,0
B $8ABF,2,2 Players visit flags
B $8AC1,4,4 X/Y thresholds
B $8AC5,27,9 Exit table for 9 zones
B $8AE0,19,8 Additional room configuration
B $8AF3,301,9 RLE sequence of room data
B $8C20 Room 05 extra data (key placement list)
N $8C78 Room 08 data
N $8C78 #HTML[<img src="images/rooms/room08.png" />]
@ $8C78 label=room08_desc
W $8C78,2,2 address of scene graphical primitives
B $8C7A,1,1
B $8C7B,1,1 Color palette
B $8C7C,2,2
W $8C7E,2,2 Address of room's extra data
B $8C80,4,4 Respawn point: X,Y,direction,0
B $8C84,2,2 Players visit flags
B $8C86,4,4 X/Y thresholds
B $8C8A,27,9 Exit table for 9 zones
B $8CA5,19,8 Additional room configuration
B $8CB8,433,9 RLE sequence of room data
B $8E69 Room 08 extra data (key placement list)
N $8EA5 Room 13 data
N $8EA5 #HTML[<img src="images/rooms/room13.png" />]
@ $8EA5 label=room13_desc
W $8EA5,2,2 address of scene graphical primitives
B $8EA7,1,1
B $8EA8,1,1 Color palette
B $8EA9,2,2
W $8EAB,2,2 Address of room's extra data
B $8EAD,4,4 Respawn point: X,Y,direction,0
B $8EB1,2,2 Players visit flags
B $8EB3,4,4 X/Y thresholds
B $8EB7,27,9 Exit table for 9 zones
B $8ED2,19,8 Additional room configuration
B $8EE5,698,9 RLE sequence of room data
B $919F Room 13 extra data (key placement list)
c $9300 Play win/level-complete jingle
N $9306 Play die sound as Bruce is defeated
@ $9306 label=play_bruce_die_sound
N $930C Play sound after taking a key by Bruce
@ $930C label=play_key_collecting
b $9312
c $95e2 Play music/sound-effect sequence (list of tone groups)
R $95e2 HL address of the tone-group sequence to play
N $95e2 Plays a complete tune or sound effect by working through a list of note groups, handing each one to #R$960A to sound on the speaker, and stops when it reaches the end-of-list marker. Interrupts are turned off while it plays so the timing of the notes stays accurate.
C $95FF,3 Play tone sequence via speaker
c $960A Play tone sequence via speaker (used for sound effects)
R $960A HL address of the tone table to play
N $960A Sounds one note group by clicking the speaker on and off for the durations listed in its table, which sets the pitch, repeating the whole group a set number of times to give it length. It also watches the keyboard so the player can cut the sound short by pressing a key.
C $960A,2 E = table low byte, advance
C $960C,2 D = table high byte, advance
C $960E,2 C = repeat count low, advance
C $9610,2 B = repeat count high, advance
C $9612,2 Save caller HL, HL = table pointer
C $9614,4 Loop while repeats remain
C $9618,2 Decrement count, save table pointer
C $961A,2 E = duration low
C $961C,2 D = duration high
C $961E,4 Skip toggle if duration zero
C $9622,3 A = speaker state
C $9625,5 Toggle and store speaker state
C $962A,2 Output to speaker port
C $962C,3 Delay loop: decrement duration
C $962F,2 Loop until duration elapsed
C $9631,2 Next half-cycle
C $9633,3 Restore table pointer, loop repeats
C $9636,1 Restore caller HL
C $9637,5 Read keyboard port FE
C $963C,3 Mask key bits
C $963F,1 Return if any key pressed
C $9640,2 E = wait duration low
C $9642,2 D = wait duration high
C $9644,4 Check duration, loop delay
C $9648,1 Return
b $9649
b $9800 Background tiles 8*8, tile attributes at #R$6300
@ $9800 label=bktiles
c $C000 Entry point, jump to start
b $A000
@ $A000 label=right_direction_images
@ $A800 label=left_direction_images
@ $B000 label=right_direction_masks
@ $B800 label=left_direction_masks
@ $C000 label=begin
C $C000,3 => Start point
c $C003 Interrupt handler: decode input, tick frame counters
N $C003 Runs once every screen frame (50 times a second): it reads the player's controls and advances the various timing counters the game uses to pace movement and animation. This keeps input and timing ticking along steadily in the background, independent of the main game code.
C $C003,2 Save registers
C $C005,2 Save registers
C $C007,3 Decode and store player input direction
C $C00A,6 Set frame-ready flag
C $C010,7 Advance frame counter
C $C017,4 Advance water-color counter
C $C01B,4 Advance object-1 counter
C $C01F,4 Advance object-2 counter
C $C023,4 Advance object-3 counter
C $C027,2 Restore registers
C $C029,2 Restore registers
C $C02B,2 Return
c $C02D Decode and store player input direction
N $C02D Reads the current player's controls (via #R$C085) and saves the resulting direction as the pending move, noting when it differs from last time; in a two-player game the second player's input is read the same way. Runs off the interrupt so the latest input is always ready when the game acts on it.
C $C02D,5 Clear direction-changed flag
C $C032,6 A = raw joystick/key input, decode direction
C $C038,4 Compare decoded input to previous
C $C03C,3 Store input, skip if changed
C $C03F,3 Store as pending direction
C $C042,6 Skip player-2 handling if absent
C $C048,5 Set direction-changed flag
C $C04D,7 Skip if player 2 uses same input mode
C $C054,6 Decode player-2 input
C $C05A,2 Compare to previous player-2 input
C $C05C,5 Store as pending direction if changed
C $C061,5 Check two-player mode
C $C066,2 Skip if single-player
C $C068,6 Skip if player 2 not active
C $C06E,6 Skip if not player 2's turn
C $C074,3 HL = pending direction
C $C077,3 Swap byte order
C $C07A,3 Store as final direction result
C $C07D,1 Return
C $C07E,6 Use pending direction unchanged
C $C084,1 Return
c $C085 Decode raw key/joystick input to direction code
R $C085 A raw input-source code (0-2) selecting keyboard/joystick decode
N $C085 Reads whichever control device the player chose - one of the keyboard layouts or a joystick - and boils it down to a single code saying which direction is being held and whether the fire button is pressed, ready for the movement code to act on.
C $C085,6 Dispatch by input source code (0/1/2)
C $C08B,4 Check for third source
C $C08F,6 BC=keyboard port, HL=key table
C $C095,5 Check direction-changed flag
C $C09A,4 A=0 (no key), skip if flag set
C $C09E,5 Use alt key table if needed
C $C0A3,2 Advance to next key row
C $C0A5,2 Skip alt read
C $C0A7,5 Read key row, advance
C $C0AC,5 Read key row, store result
C $C0B1,4 Read joystick port
C $C0B5,4 A=0, HL=alt key table
C $C0B9,3 BC=keyboard port
C $C0BC,5 Read key row, advance
C $C0C1,5 Read key row, store
C $C0C6,3 HL=numeric key table
C $C0C9,3 BC=keyboard port
C $C0CC,5 Read key row, advance
C $C0D1,2 Loop while no key found
C $C0D3,4 Store decoded key, return
c $C0D7 Scan keyboard row, OR-accumulate matched key code
R $C0D7 BC keyboard port to read
R $C0D7 HL address of the key-code table
C $C0D7,4 D = key row bits, E = bit counter 5
C $C0DB,4 Skip table byte if key not pressed
C $C0DF,1 OR in table byte for pressed key
C $C0E0,2 Advance table pointer
C $C0E2,2 Loop for 5 bits
b $C0E5
c $C121 Check pause/reset keys, handle pause screen
N $C121 Checks the special control keys during play: the reset combination abandons the game and restarts, the pause key shows a "pause" message and waits until it's dismissed before resuming, and the sound key toggles sound on or off.
C $C121,4 Read keyboard row (SPACE)
C $C125,3 Check SPACE pressed
C $C128,4 Read keyboard row (Q)
C $C12C,3 Check Q pressed
C $C12F,6 Play click, restart game
C $C135,5 Read keyboard row (CAPS SHIFT)
C $C13A,4 Check CAPS SHIFT pressed
C $C13E,5 PAUSE message text + row
C $C143,3 Draw message and fill screen background color
C $C146,5 Wait for key, check ENTER
C $C14B,2 Loop until pressed
C $C14D,5 Resume message text + row
C $C152,3 Draw message and fill screen background color
C $C155,3 Play click, return
C $C158,5 Read keyboard row (SYM SHIFT/M)
C $C15D,3 Check key pressed, else return
C $C160,5 Toggle difficulty flag
C $C165,5 Mask and store
C $C16A,3 Play click, return
b $C16D
c $C16E Prepare level and draw it to playscreen
@ $C16E label=prepare_level
N $C16E Sets up the current room from scratch, ready to be played. It looks up the room by number, copies its header into the working area and marks that the current player has now visited it, then unpacks the room's compressed tile layout (a simple run-length format) into the live tile map. Next it places the room's keys at their positions - keys already collected are skipped unless they're the respawning kind - and finally draws the whole scene into the offline buffer and clears the per-character state ready for play.
C $C174,2 HL contains pointer to address of room
C $C178,1 DE contains address of room
C $C183,1 DE contains address of room
C $C185,3 offset in current room for first player
C $C18F,1 change offset for second player
@ $C190 label=mark_current_player_visit
C $C191,2 mark visit of current player to this room
C $C193,1 HL points to room address + 40h
N $C194 Decode RLE sequence: byte A = 0: end of data, 1..127: repeat next byte A times, 128..255: copy A-128 bytes
@ $C197 label=room_extract_loop
C $C19B,3 sequence of bytes
C $C19E,1 repeating byte
C $C19F,1 B contains number of repetitions
C $C1A0,1 A contains value for filling
@ $C1A1 label=room_fill_loop
C $C1A6,2 walk to next chunk of level data
N $C1A8 copy block of bytes
@ $C1A8 label=room_copy_block
N $C1B2 Room extracted
@ $C1B2 label=room_extracted
C $C1BD,3 Get address of list of keys to be collected in the room
N $C1C0 Place room keys to their locations
@ $C1C0 label=place_keys_loop
C $C1C2,2 Such keys will reappear even it was collected
@ $C1D0 label=respawning_key
C $C1D2,1 Check for end of keys list
N $C1F8 Now draw scene to offline screen
@ $C1F8 label=end_of_keys
@ $C204 label=draw_room_scene_loop
C $C20C,3 Draws an 8*8 pixels element of scene
C $C24D,3 Fill BC bytes at HL address by zeros
C $C255,3 Fill BC bytes at HL address by zeros
C $C274,3 Add points to current player score
C $C28D,3 Store $4810 as active color-table pointer
c $C29C Updates Video-RAM from offline drawing buffer
@ $C29C label=update_screen
c $C2B2 Fill BC bytes at HL address by zeros
@ $C2B2 label=bzero_at_hl
c $C2B8 Record scene element in companion tile map, then draw it
R $C2B8 A scene element index to draw
N $C2B8 An extended entry to the scene-element drawing routine #R$C2C0: before drawing, it also writes the element index into a second, parallel tile map (offset $6800 from the main destination), so the change to that cell is remembered and not lost. It then falls straight through into #R$C2C0 to actually draw the 8x8 element. Used by the water-animation code to permanently swap a tile as the water bubbles.
c $C2C0 Draws an 8*8 pixels element of scene
R $C2C0 A scene element index to draw
N $C2C0 Draws one plain 8x8 scenery tile straight into the offline screen buffer at a fixed destination held in a scratch variable, working out which graphic to use from the given element index and copying its pixel rows across (unlike #R$D626, it doesn't touch the room's tile map or the screen colours).
C $C2C0,5 DE = element index into scene data table
C $C2C5,4 HL = destination tile address
C $C2C9,2 Store element index to tile map
C $C2CB,4 Advance and save tile pointer
C $C2CF,5 HL = personage image data pointer
C $C2D4,4 Multiply index by 8
C $C2D8,2 Add offset, restore tile coord
C $C2DA,3 Mask row bits
C $C2DD,3 Shift row into high bits
C $C2E0,3 D = screen attribute high byte
C $C2E3,2 Row counter = 8
C $C2E5,2 Copy pixel byte to screen
C $C2E7,2 Advance source, next screen row
C $C2E9,2 Loop 8 rows
@ $C2C0 label=draw_scene_element
c $C2EC Updates area of personage from offscreen to screen
@ $C2EC label=show_pers_area
N $C2EC Copies the finished picture of a character from the offline buffer onto the real screen, so all the drawing work done off-screen becomes visible in one go. It first checks the character is actually on screen and alive, then works out where in video memory its patch belongs and copies the block of pixel rows across, followed by the matching colour attributes. Only the small rectangle the character occupies is copied, which keeps the update fast and flicker-free.
C $C2EC,6 Skip ahead if area already shown (IX+0A)
C $C2F2,5 Return if personage isn't alive (IX+2)
C $C2F7,7 Load offscreen source coords (IX+8/9) into HL
C $C2FE,3 Rotate row byte to get bitmap-third index
C $C301,7 Fold coord bits into screen column (standard ZX address fold)
C $C308,1 Save folded screen column
C $C309,5 Build screen high byte (bits 5-3 of row) in D
C $C30E,4 Set up wraparound screen row byte in H
C $C312,4 Row-block counter C=5, inner counter B=4
C $C316,4 Copy pixel byte HL(offscreen)->DE(screen), advance column
C $C31A,4 Copy pixel byte, advance column
C $C31E,4 Copy pixel byte, advance to next third
C $C322,4 Copy pixel byte, advance to next third
C $C326,4 Copy pixel byte, then step back a row
C $C32A,4 Copy pixel byte, step back a row
C $C32E,4 Copy pixel byte, step back a row
C $C332,4 Copy pixel byte, advance to next pixel line
C $C336,2 Loop for 4 pixel rows (DJNZ)
C $C338,6 Advance HL to next screen third, handle wrap
C $C33E,4 Conditional wrap subtract
C $C342,4 Mask to valid screen range, rebuild D
C $C346,3 Loop for 5 thirds (row blocks)
C $C349,3 Restore saved screen column into HL/A
C $C34C,5 Build attribute-area high byte in D
C $C351,3 Build attribute-area address in H
C $C354,2 Attribute row counter A=5
C $C356,3 Load 4-byte attribute row length
C $C359,2 Copy attribute row HL(offscreen)->DE(screen)
C $C35B,7 Advance HL and DE to next attribute row
C $C362,3 Loop for 5 attribute rows
c $C366 Redraw background of personage area to offscreen
@ $C366 label=update_pers_backgr
N $C366 Wipes the character out of the offline buffer by repainting the room background over the patch of screen it was occupying, ready for the next frame to be drawn cleanly. Using the character's state record in IX it works out how many tile rows and columns that patch covers (clamped so it never runs past the bottom of the play area), then finds the matching block of tiles in the room's scene map. It walks that rectangle tile by tile, redrawing each background scene element back onto the buffer. The character's own image is left to be re-drawn separately by #R$C3CB.
C $C366,5 Return if personage isn't alive (IX+2)
C $C36B,5 Compute image-slot offset from personage index
C $C370,3 DE = offset into scene-elements table
C $C373,3 HL = IX (personage struct base)
C $C376,5 Load scene-elements list pointer via offset
C $C37B,3 B = element count, C = row counter 5
C $C37E,7 A = 24 - (IX+7) row, clamp to max 5 rows
C $C385,3 Use clamped row count if fewer than 5 remain
C $C388,4 Save row/element counters
C $C38C,6 HL = personage tile coords (IX+6/7)
C $C392,6 Rotate row bits into low nibble of H
C $C398,5 Fold coord bits into tile column (standard ZX fold)
C $C39D,4 Combine into scene tile row/col in H
C $C3A1,3 Mask to valid scene-map range
C $C3A4,3 Save scene-map tile address
C $C3A7,1 Save row/element counters
C $C3A8,6 HL = scene-map tile address, add scene data base
C $C3AE,2 A = tile element index
C $C3B0,3 Draws an 8*8 pixels element of scene
C $C3B3,3 Restore counters, loop for each element in row (DJNZ)
C $C3B6,4 HL = saved element counter, A = row width
C $C3BA,5 Compute step to next scene-map row
C $C3BF,1 DE = step to next row
C $C3C0,7 Advance saved tile address by row step
C $C3C7,3 Loop for remaining rows (5 max)
c $C3CB Draws personage to offscreen
@ $C3CB label=draw_pers
N $C3CB Draws a whole character (Bruce or a foe) into the offline screen buffer, given its state record in IX, doing nothing if the character isn't currently alive. It picks the graphics for the way the character is facing (separate image banks for left and right), reads which pose to show plus its pixel-precise Y offset and colour, and looks up an image descriptor giving the sprite's width, height and on-screen position. It then walks the sprite cell by cell - across each row, then dropping to the next - handing each 8x8 fragment to #R$C44D to blend onto the background. Running screen-position and image pointers are passed through scratch variables that #R$C44D reads on each call.
C $C3D0,1 (IX+2) Personage image index and "alive status"
C $C3D1,1 Is personage alive?
C $C3D2,1 Return, if not yet.
C $C3D3,1 Store personage image index to C
C $C3D5,1 (IX+3) Direction of the personage
C $C3D7,2 right direction
C $C3D9,2 offset for images with left direction
N $C3DB Right direction images address if a000h
N $C3DB Left direction images address is a800h
@ $C3DB label=draw_pers_rt
C $C3DE,2 DE now points to images set for current direction
C $C3E5,1 (IX+4) Y offset for pixel-precision drawing. From 0 to 7 inclusive.
C $C3EA,1 (IX+5) Color attributes of personage
@ $C3EE label=dp_image_desc
C $C3EF,1 Personage image index
C $C3F8,1 (Personage image index * 4) + 16h + IX
C $C3FB,1 BC is personage image description address
C $C3FE,1 (IX+6) Y coordinate
C $C400,1 (IX+7) X coordinate
C $C412,1 DE is address of offscreen color data for personage image
C $C418,1 HL is personage image description address
C $C419,1 Get personage image width in 8-pixel units
C $C41B,1 Get personage image height in 8-pixel units
@ $C420 label=draw_pers_loop
C $C423,3 Draw masked image fragment to offscreen buffer
C $C436,1 go to next row of 8*8 pixels block to draw following 8 lines of image
c $C44D Draw masked image fragment to offscreen buffer (pixel-aligned)
N $C44D Draws one small image fragment onto the offline screen buffer so it blends over the existing background rather than overwriting it: for each row it punches a hole in the background using the fragment's mask (found 1000h bytes past the pixel data), then drops the fragment's pixels into that hole so surrounding background survives. Because the fragment can sit at any horizontal pixel offset, a column of it may straddle two neighbouring 8-pixel character cells; when that happens the routine finishes the first cell then steps across to the cell on the right to draw the leftover part. It also updates the colour attribute of the affected cell.
@ $C44D label=draw_pers_part
C $C469,1 get image part index
C $C474,1 HL is address of image part
C $C477,2 Image part address + 1000h is address of image part mask
@ $C47A label=first_block_half_loop
C $C47B,1 Get data from offline screen
C $C47C,1 Apply mask cleaning necessary area
C $C47E,1 Apply image part byte to cleaned data
C $C47F,1 Store data back to offline screen
C $C480,1 Go to next line of offline screen
C $C481,1 Go to next byte of image part data
C $C482,1 Go to next byte of image part mask
C $C489,2 Check if image is aligned to 8 pixels
C $C48C,1 Image is not aligned, need to continue drawing in second 8*8 block
@ $C499 label=second_block_loop
c $C4B8 Start point
@ $C4B8 label=start
N $C4B8 The game's actual boot sequence: sets up the border and speaker, paints the title/copyright screen (credits text plus the publisher logo graphic), plays the opening jingle, and then falls straight into #R$C530 to show the main menu.
C $C4C4,3 Init title screen
C $C4CF,3 Draw message
C $C4DA,3 Draw message
C $C4E5,3 Draw message
C $C4F0,3 Draw message
C $C4FB,3 Draw message
C $C506,3 Draw message
C $C51C,3 Draw
C $C51F,3 Updates Video-RAM from offline drawing buffer
C $C52D,3 Play win/level-complete jingle
c $C530 Draws title screen and handles menu selection
N $C530 Paints the title/menu screen - game name, the option lines and credits - and highlights the option boxes. It then sits in a loop reading the keyboard, letting the player toggle the menu choices (one or two players, keyboard or joystick, and so on) and redrawing the highlight as they change. Pressing ENTER breaks out of the loop and starts the game via #R$C714.
C $C530,3 Init title screen
C $C53B,3 Draw message
C $C546,3 Draw message
C $C551,3 Draw message
C $C55C,3 Draw message
C $C567,3 Draw message
C $C572,3 Draw message
C $C57D,3 Draw message
C $C5A7,3 Updates Video-RAM from offline drawing buffer
C $C5AD,3 Highlight menu-box attribute rows
C $C5B3,3 Highlight menu-box attribute rows
C $C5B9,3 Highlight menu-box attribute rows
C $C5C1,3 Fill BC bytes at HL address by zeros
C $C5CC,3 Wait for key release, then wait for key press
C $C5DF,3 Highlight menu-box attribute rows
C $C5E6,3 Highlight menu-box attribute rows
C $C62C,3 Highlight menu-box attribute rows
C $C64D,3 Fill attribute column
C $C651,3 Highlight menu-box attribute rows
C $C65A,3 Highlight menu-box attribute rows
C $C67D,3 Fill attribute column
C $C684,3 Highlight menu-box attribute rows
C $C6BD,3 Wait until debounced key-scan returns FFh
C $C6C0,3 => Start new game (ENTER pressed in main menu)
c $C6C3 Wait for key release, then wait for key press
R $C6C3 O:A key code pressed
C $C6C3,3 Debounced key-scan
C $C6CA,3 Debounced key-scan
c $C6D2 Debounced key-scan (2-frame check via ROM KEY_SCAN)
R $C6D2 A key code to debounce against
R $C6D2 O:A key code pressed (FFh if none)
B $C6D7,3 KEY_SCAN
c $C6E4 Wait until debounced key-scan returns FFh (no key)
C $C6E4,3 Debounced key-scan
c $C6EC Highlight menu-box attribute rows (8 rows, color 28h)
R $C6EC HL screen-third base address
C $C6EC,3 Fill attribute column
c $C6FB Highlight menu-box attribute rows (11 rows, color 28h)
R $C6FB HL screen-third base address
C $C6FB,3 Fill attribute column
c $C706 Fill attribute column (23 rows, color 38h)
R $C706 HL screen-third base address
@ $C706 label=fill_smth
c $C714 Start new game: reset scores, lives and players, prepare first level
N $C714 This block is really three things chained together, entered fresh only when a game starts but ending in a loop that runs for the rest of the game. It first resets scores, lives and the room-exit table for a brand new game; #R$C790 (also reached directly when a life or level ends) then loads whichever room the current player is in and draws it; and #R$C7A4 is the actual frame-by-frame game loop - it waits for the next screen update, redraws the characters, steps everyone's movement and AI, checks for deaths (losing a life when Bruce is killed), and finally checks whether a character has walked off the edge of the room, loading the next one and looping back if so.
@ $C714 label=start_game
N $C71F Reset score of both players
@ $C71F label=reset_score
C $C752,3 Fill BC bytes at HL address by zeros
@ $C790 label=next_player
C $C790,3 Fills offline color attributes of playscreen header
C $C7A1,3 Prepare level and draw it to playscreen
@ $C7A4 label=play_loop
C $C7A4,3 Check pause/reset keys, handle pause screen
C $C7B8,3 Updates Video-RAM from offline drawing buffer
@ $C7BD label=screen_updated
C $C7C1,3 Updates area of personage from offscreen to screen
C $C7C8,3 Updates area of personage from offscreen to screen
C $C7CF,3 Updates area of personage from offscreen to screen
@ $C7D2 label=no_perses_update
C $C7D6,3 Redraw background of personage area to offscreen
C $C7DD,3 Redraw background of personage area to offscreen
C $C7E4,3 Redraw background of personage area to offscreen
C $C7EA,3 Handle object impact
C $C7FA,3 Single gameplay step of personage
C $C801,3 Single gameplay step of personage
C $C808,3 Single gameplay step of personage
C $C810,3 => Bruce died: lose a life, game over or switch player
C $C817,3 Kill personage that fell off bottom of screen
C $C81A,3 Respawn personage after death timer expires
C $C821,3 Kill personage that fell off bottom of screen
C $C824,3 Respawn personage after death timer expires
C $C831,3 Store size of personage image to image_size variable
C $C861,3 Draws personage to offscreen
C $C868,3 Draws personage to offscreen
C $C86F,3 Draws personage to offscreen
C $C8B5,3 => Bruce died: lose a life, game over or switch player
c $C8C6 Clear offline screen buffer (attributes then pixels)
@ $C8C6 label=clear_offline_screen
c $C8E1 Init title screen: clear buffer, draw logo, draw header message
@ $C8E1 label=init_1
C $C8E1,3 Clear offline screen buffer
C $C8ED,3 Draw
C $C905,3 => Draw message
c $C908 Draw single character to screen (8x8 font)
R $C908 A character code to draw
N $C908 Draws one text character straight onto the real screen at the given position, working out its font shape from the character code and copying its 8 pixel rows in - the low-level building block #R$C924 calls once per letter to print a message.
R $C908 DE screen coordinates
C $C908,3 HL = char index
C $C90B,3 Multiply by 8
C $C90E,4 Add font data base
C $C912,3 Mask row bits
C $C915,3 Shift row into high bits
C $C918,3 D = screen high byte
C $C91B,2 Row counter=8
C $C91D,2 Copy char row to screen
C $C91F,2 Advance source, next screen row
C $C921,2 Loop 8 rows
c $C924 Draw message
@ $C924 label=draw_message
R $C924 DE screen coordinates
R $C924 HL message address
R $C924 B message length
N $C924 Prints a text string by stepping through its bytes one at a time and drawing each character to the screen with #R$C908, advancing to the next screen position after each.
C $C928,3 Draw single character to screen
c $C933 Draws a message and set screen dirty flag
R $C933 DE screen coordinates
R $C933 HL message address
R $C933 B message length
@ $C933 label=draw_message_and_invalidate
C $C933,3 Draw message
c $C93C Fills offline color attributes of playscreen header
N $C93C Prepares the score/status header line: it paints the header's colour attributes a uniform colour, writes the active player's number into the message, and copies that player's six score digits into the header buffer ready to be drawn.
C $C93C,6 HL = header attr address, BC = fill color/count
C $C942,4 Fill header attribute row
C $C946,3 HL = player-1 score digits
C $C949,5 A = player number as ASCII digit
C $C94E,3 Store player digit into message
C $C951,4 Check if player 1
C $C955,3 Else use player-2 score digits
C $C958,3 DE = message buffer
C $C95B,3 6 bytes
C $C95E,2 Copy score digits into message
@ $C93C label=fill_offscreen_header_color
c $C960 Draws message at header of game screen
@ $C960 label=draw_playscreen_header_message
C $C968,3 => Draws a message and set screen dirty flag
t $C96B Score constants as text
@ $C96B label=score_50
T $C96B,6,6 Value of 50
@ $C971 label=score_for_a_hit
T $C971,6,6 Value of 75 to add to player's score for hitting enemy
@ $C977 label=score_100
T $C977,6,6 Value of 100
@ $C97D label=score_for_a_key
T $C97D,6,6 Value of 125 to add to player's score if a key is collected
@ $C983 label=score_for_a_kill
T $C983,6,6 Value of 200 to add to player's score when defeating an enemy
@ $C989 label=score_450
T $C989,6,6 Value of 450
@ $C98F label=score_for_new_room
T $C98F,6,6 Value of 2000 to add to player's score if a new room is visited
@ $C995 label=score_3000
T $C995,6,6 Value of 3000
c $C99B Add points to current player score
@ $C99B label=increase_score
C $C99B,2 Save registers
C $C99D,3 DE = player-1 score address
C $C9A0,7 Check active player, else use player 2
C $C9A7,3 DE = player-2 score address
C $C9AA,5 Save score low byte for hiscore compare
C $C9AF,5 Save score high byte
C $C9B4,3 Advance DE past unused digits
C $C9B7,4 HL = points value, aligned
C $C9BB,3 B=6 digits, C=carry=0
C $C9BE,2 Add points digit to score digit
C $C9C0,3 Remove ASCII bias, add carry
C $C9C3,2 Clear carry
C $C9C5,4 Check digit overflow (BCD)
C $C9C9,4 Adjust digit, set carry
C $C9CD,3 Store digit, step to next
C $C9D0,2 Loop for 6 digits
C $C9D2,3 B=6, DE=score start
C $C9D5,3 HL=hiscore digits
C $C9D8,2 Compare score digit to hiscore digit
C $C9DA,4 Stop if score is lower or higher
C $C9DE,2 Advance both pointers
C $C9E0,2 Loop while digits equal
C $C9E2,2 Equal: no new hiscore
C $C9E4,3 Copy score digit into hiscore
C $C9E7,3 Loop for remaining digits
C $C9EA,3 Redraw score header
C $C9ED,4 DE = life-bonus threshold
C $C9F1,3 HL = new score value
C $C9F4,3 Compare score to threshold
C $C9F7,2 Skip bonus if equal
C $C9F9,3 Check high digit
C $C9FC,2 Skip if threshold crossed exactly
C $C9FE,2 Combine digits
C $CA00,2 Mask to digit
C $CA02,4 Check digit range
C $CA06,2 Adjust digit
C $CA08,4 Bonus at digit 3
C $CA0C,4 Bonus at digit 6
C $CA10,4 Bonus at digit 9, else skip
C $CA14,3 Award bonus life
C $CA17,2 Restore registers
R $C99B HL address of value to add to score
N $C99B Also, updates hiscore, if current score is greater.
@ $C9AA label=add_score_for_first_player
@ $C9BE label=add_score_loop
@ $C9CD label=add_score_no_carry
@ $C9D8 label=check_hiscore_loop
N $C9E4 Copy current score value to the high score
@ $C9E4 label=new_hiscore
@ $C9EA label=not_hiscore
C $C9EA,3 Fills offline color attributes of playscreen header
N $CA14 Score value is good enough to increase lifes number
@ $CA14 label=great_score
C $CA14,3 Increase player lifes
@ $CA17 label=no_lifes_increase
c $CA1A Increase player lifes
@ $CA1A label=increase_player_lifes
N $CA1A Awards a bonus life: bumps the two-digit lives count up by one (carrying between digits and capping at 99) and redraws the header so the new total shows.
C $CA1B,3 HL = current lives (2-digit BCD)
C $CA1E,2 Bump low digit
C $CA24,4 Roll over: carry to high digit, reset low
C $CA2D,3 Clamp at 99
C $CA30,3 Store new lives count
C $CA34,3 => Draws message at header of game screen
c $CA37 Handle object impact
R $CA37 DE Object address in playroom
R $CA37 HL object handlers table
@ $CA37 label=handle_object_impact
c $CA46 Bruce died: lose a life, game over or restart room and switch player
N $CA46 Runs when Bruce has finished his death animation: it takes one life off the count and redraws the header, and if no lives remain the game is over. Otherwise it reloads the room's colours, and in a two-player game hands the turn to the other player by swapping the two players' saved state.
C $CA46,7 DE = lives count, compare to 00
C $CA4D,6 No lives left: game over
C $CA53,9 Decrement lives, borrow across BCD digits
C $CA5C,4 Store new lives count
C $CA60,3 Draws message at header of game screen
C $CA63,5 Short death pause (50 frames)
C $CA68,6 Pick room colour table
C $CA6E,4 Use alt table for later rooms
C $CA72,3 Alt colour table
C $CA75,10 Load border/paper color bytes
C $CA7F,6 Load flash bit
C $CA85,4 Clear bright flag
C $CA89,7 Skip player-switch if single-player
C $CA90,8 Compute next player number (wrap 1<->2)
C $CA98,2 Wrap to player 1
C $CA9A,3 Store active player
C $CA9D,8 Swap personage 1/2 structs
C $CAA5,3 Swap personage bytes
C $CAA8,8 Swap remaining player-1/2 state block
C $CAB0,3 Swap bytes
C $CAB3,3 Continue to next turn
c $CAB6 Swap two memory blocks byte by byte
R $CAB6 HL address of first block
R $CAB6 DE address of second block
R $CAB6 B number of bytes to swap
c $CAC0 Game over: show time-up message, restart
C $CAC5,3 Draw message and fill screen background color
C $CAC8,3 Wait for key release, then wait for key press
C $CACB,3 => Start point
c $CACE Draw message and fill screen background color
R $CACE HL message address
R $CACE C attribute (color) byte to fill screen with
C $CAD3,3 Draw message
C $CADF,3 => Updates Video-RAM from offline drawing buffer
c $CAE2 Respawn personage after death timer expires
R $CAE2 IX address of personage description
c $CAF7 Kill personage that fell off bottom of screen
N $CAF7 Checks whether a character has fallen far enough past the bottom of the play area to count as gone, and if it has (and it wasn't already dying) it starts its death - remembering its last pose and setting the dying timer running.
C $CAF7,3 Return in HL address of personage's cell in playroom
C $CAFA,3 Store size of personage image to image_size variable
C $CAFD,6 Bottom edge + image height past floor line?
C $CB05,1 Not off screen yet: return
C $CB06,5 Also require animation frame past 4
C $CB0C,5 Return if already dying
C $CB11,6 Remember last pose, start dying timer
b $CB1C Data on Ninja personage
@ $CB1C label=ninja_description
B $CB1C,2,2
@ $CB1E label=ninja_image_index
B $CB1E,1,1 (+02h) Current Ninja image index
@ $CB1F label=ninja_direction
B $CB1F,1,1 (+03h) 0 - right direction, 1 - left direction
@ $CB20 label=ninja_y_offset
B $CB20,1,1 (+04h) pixel-precision Y offset from 0 to 7 inclusive
@ $CB21 label=ninja_color_attribute
B $CB21,1,1 (+05h)
@ $CB22 label=ninja_x_coordinate
B $CB22,1,1 (+06h) X coordinate in 8-pixels units (upper left corner)
@ $CB23 label=ninja_y_coordinate
B $CB23,1,1 (+07h) Y coordinate in 8-pixels units (upper left corner)
@ $CB24 label=ninja_prev_x
B $CB24,1,1 (+08h) Previous X coordinate (for updating from offline screen)
@ $CB25 label=ninja_prev_y
B $CB25,1,1 (+09h) Previous Y coordinate (for updating from offline screen)
@ $CB26 label=ninja_flashing_counter
B $CB26,1,1 (+0ah) Zero value means healthy ninja
@ $CB27 label=ninja_action
B $CB27,3,3 (+0bh) Current ninja action
@ $CB2B label=ninja_defeated_pose
B $CB2A,1,1
B $CB2B,1,1 Index of a image to draw defeated Ninja
B $CB2C,1,1
B $CB2D,1,1
W $CB2E,4,4
@ $CB32 label=ninja_images_refs
w $CB32 Ninja state descriptions
W $CB32,4,4 0 idle
W $CB36,4,4 1 walking
W $CB3A,4,4 2 jump rising
W $CB3E,4,4 3 jump obstacle check
W $CB42,4,4 4 walking bump
W $CB46,4,4 5 kick/attack
W $CB4A,4,4 6 jump apex
W $CB4E,4,4 7 jump rising (fast)
W $CB52,4,4 8 jump diagonal
W $CB56,4,4 9 jump diagonal (advance)
W $CB5A,4,4 10 jump landing
W $CB5E,4,4 11 jump landing check
W $CB62,4,4 12 falling
W $CB66,4,4 13 climbing
W $CB6A,4,4 14 climbing dismount
W $CB6E,4,4 15 Empty action
W $CB72,4,4 16 kick/attack recovery
W $CB76,4,4 17 enter climbing
W $CB7A,4,4 18 being hit, recoil
W $CB7E,4,4 19 hit reaction
W $CB82,4,4 20 recoil
W $CB86,4,4 21 attack, melee hit
c $CB8A Empty action handler
N $CB8A Used for Bruce/Yamo state 15.
b $CB8B Ninja sprite descriptions
@ $CB8D label=ninja_images_descriptions
B $CB8D
B $CB95
B $CB9D
B $CBA5
B $CBAB
b $CBBE Data on Green Yamo personage
@ $CBBE label=sumoist_description
B $CBBE,2,2
@ $CBC0 label=sumoist_image_index
B $CBC0,1,1 (+02h) Current Yamo image index. 0 = not alive yet.
@ $CBC1 label=sumoist_direction
B $CBC1,1,1 (+03h) 0 - right direction, 1 - left direction
@ $CBC2 label=sumoist_y_offset
B $CBC2,1,1 (+04h) pixel-precision Y offset from 0 to 7 inclusive
@ $CBC3 label=sumoist_color_attribute
B $CBC3,1,1 (+05h)
@ $CBC4 label=sumoust_x_coordinate
B $CBC4,1,1 (+06h) X coordinate in 8-pixels units (upper left corner)
@ $CBC5 label=sumoist_y_coordinate
B $CBC5,1,1 (+07h) Y coordinate in 8-pixels units (upper left corner)
@ $CBC6 label=sumoist_prev_x
B $CBC6,1,1 (+08h) Previous X coordinate (for updating from offline screen)
@ $CBC7 label=sumoist_prev_y
B $CBC7,1,1 (+09h) Previous Y coordinate (for updating from offline screen)
@ $CBC8 label=sumoist_flashing_counter
B $CBC8,1,1 (+0ah) Zero value means healthy Yamo
@ $CBC9 label=sumoist_action
B $CBC9,3,3 (+0bh) Current Yamo action
B $CBCC,2,2
B $CBCE,1,1
B $CBCF,1,1
W $CBD0,4,4
w $CBD4 Green Yamo state descriptions
@ $CBD4 label=sumoist_images_refs
W $CBD4,4,4 0 idle
W $CBD8,4,4 1 walking
W $CBDC,4,4 2 jump rising
W $CBE0,4,4 3 jump obstacle check
W $CBE4,4,4 4 walking bump
W $CBE8,4,4 5 kick/attack
W $CBEC,4,4 6 jump apex
W $CBF0,4,4 7 jump rising (fast)
W $CBF4,4,4 8 jump diagonal
W $CBF8,4,4 9 jump diagonal (advance)
W $CBFC,4,4 10 jump landing
W $CC00,4,4 11 jump landing check
W $CC04,4,4 12 falling
W $CC08,4,4 13 climbing
W $CC0C,4,4 14 climbing dismount
W $CC10,4,4 15 Empty action
W $CC14,4,4 16 kick/attack recovery
W $CC18,4,4 17 enter climbing
W $CC1C,4,4 18 being hit, recoil
W $CC20,4,4 19 hit reaction
W $CC24,4,4 20 recoil
W $CC28,4,4 21 attack, melee hit
b $CC2C Green Yamo sprite descriptions
B $CC2C
B $CC34
B $CC3C
B $CC44
B $CC4C
B $CC54
B $CC5C
B $CC64
B $CC6C
B $CC77
B $CC82
B $CC8A
B $CC92
B $CC9A
b $CCA5 Data on Brucee Lee personage
@ $CCA5 label=bruce_description
@ $CCA7 label=bruce_image_index
B $CCA7,1,1 (+02h) Current Bruce image index. 0 = Bruce is not alive yet.
@ $CCA8 label=bruce_direction
B $CCA8,1,1 (+03h) 0 - right direction, 1 - left direction
@ $CCA9 label=bruce_y_offset
B $CCA9,1,1 (+04h) pixel-precision Y offset from 0 to 7 inclusive.
@ $CCAA label=bruce_color_attribute
B $CCAA,1,1 (+05h) Bruce color attribute
@ $CCAB label=bruce_x_coordinate
B $CCAB,1,1 (+06h) X coordinate in 8-pixels units (upper left corner)
@ $CCAC label=bruce_y_coordinate
B $CCAC,1,1 (+07h) Y coordinate in 8-pixels units (upper left corner)
@ $CCAD label=bruce_prev_x
B $CCAD,1,1 (+08h) Previous X coordinate (for updating from offline screen)
@ $CCAE label=bruce_prev_y
B $CCAE,1,1 (+09h) Previous Y coordinate (for updating from offline screen)
@ $CCAF label=bruce_flashing_counter
B $CCAF,1,1 (+0ah) Zero value means healthy bruce
@ $CCB0 label=bruce_action
B $CCB0,3,3 (+0bh) Current Bruce action
B $CCB3,3,3
B $CCB6,1,1
W $CCB7,4,4
w $CCBB Bruce Lee state descriptions
@ $CCBB label=bruce_image_refs
W $CCBB,4,4 0 idle
W $CCBF,4,4 1 walking
W $CCC3,4,4 2 jump rising
W $CCC7,4,4 3 jump obstacle check
W $CCCB,4,4 4 walking bump
W $CCCF,4,4 5 kick/attack
W $CCD3,4,4 6 jump apex
W $CCD7,4,4 7 jump rising (fast)
W $CCDB,4,4 8 jump diagonal
W $CCDF,4,4 9 jump diagonal (advance)
W $CCE3,4,4 10 jump landing
W $CCE7,4,4 11 jump landing check
W $CCEB,4,4 12 falling
W $CCEF,4,4 13 climbing
W $CCF3,4,4 14 climbing dismount
W $CCF7,4,4 15 Empty action
W $CCFB,4,4 16 kick/attack recovery
W $CCFF,4,4 17 enter climbing
W $CD03,4,4 18 being hit, recoil
W $CD07,4,4 19 hit reaction
W $CD0B,4,4 20 recoil
W $CD0F,4,4 21 attack, melee hit
b $CD13 Bruce Lee sprite descriptions
@ $CD13 label=bruce_image_descriptions
B $CD13,8,8 2x3 + 6 bytes
B $CD1B,8,8 2x3 + 6 bytes
B $CD23,8,8 2x3 + 6 bytes
B $CD2B,8,8 3x2 + 6 bytes
B $CD33,8,8 3x2 + 6 bytes
B $CD50
B $CD58
B $CD63
B $CD6E
B $CD76
B $CD91
c $CD9B Personage action handler 0: idle, decode input and dispatch new state
N $CD9B Runs whenever a character is standing still and reads its current input to decide what to do next: duck (Bruce only), start falling if there's no floor, or otherwise switch to walking, punching, climbing or jumping based on the direction held - checking for a blocking obstacle first where that matters (like punching into a wall, or jumping into a ceiling).
C $CD9B,8 Clear jump counters
C $CDA6,3 Compares IX and HL for equality
C $CDAE,4 Duck input (Bruce only)?
C $CDBB,4 Duck input, other side?
C $CDC8,3 Check for floor tile beneath personage
C $CDCB,2 No floor: check rope/fall
C $CDCD,3 Check for rope/ladder under personage
C $CDD0,3 Return state 14 (falling) if no rope
C $CDD6,3 Compares IX and HL for equality
C $CDDF,3 Return state 17 (on rope)
C $CDE7,2 Punch input?
C $CDE9,3 Check for obstacle ahead of personage
C $CDEC,3 Return idle if obstacle blocks
C $CDF8,3 Return state 22 (punch)
C $CDFD,2 Left input?
C $CE10,2 Right input?
C $CE1F,4 Down input?
C $CE23,3 Return state 12 (climb-down)
C $CE28,2 Up input?
C $CE2D,3 Compares IX and HL for equality
C $CE32,5 Obstacle above? (Bruce only)
c $CE48 Personage action handler 1: walking, continue movement and re-decode input
N $CE48 Keeps a walk going frame by frame: falls off if the floor disappears, otherwise checks for an obstacle in the direction faced and reads the current input to decide what happens next - keep walking, turn to face the other way, start climbing at a ladder, or (if the walk has run long enough and the punch key is still held) throw a kick instead. The same logic is duplicated for facing left and facing right.
C $CE48,4 Reset walk-cycle counter
C $CE4C,3 Check for floor tile beneath personage
C $CE4F,3 No floor: re-decode input
C $CE52,6 Branch by facing
C $CE5B,2 Blocked ahead: idle
C $CE60,4 Input still same direction? continue
C $CE6E,3 Compares IX and HL for equality
C $CE71,2 Bruce: idle instead of kick
C $CE76,4 Punch held?
C $CE7D,4 Early in cycle: keep walking
C $CE86,2 Return state 4 (kick)
C $CE8B,2 Diagonal-down input?
C $CE8D,3 Check for ceiling/obstacle above personage
C $CE90,2 Blocked above: keep walking
C $CE95,4 Set climb frame
C $CE99,2 Return state 10 (climb)
C $CE9F,3 Mirror of above for left-facing
C $CEB5,3 Compares IX and HL for equality
C $CED7,3 Check for ceiling/obstacle above personage
C $CEED,3 Compares IX and HL for equality
c $CF04 Personage action handler 2: jump, rising, check for floor landing
C $CF04,3 Check for floor tile beneath personage
C $CF09,3 Check for rope/ladder under personage
c $CF18 Personage action handler 3: jump, obstacle collision check for all personages
C $CF1B,3 Entry to melee-hit detection, D=8
C $CF21,3 Entry to melee-hit detection, D=8
C $CF27,3 Entry to melee-hit detection, D=8
c $CF2D Personage action handler 4: walking, advance one column, bump off obstacle
N $CF2D The middle of a walk step: for the first few frames of the cycle it slides the character one column in the direction faced, stopping short if an obstacle blocks the way, then hands back to the main walking handler to re-read input for the next step.
C $CF2D,6 Advance walk-cycle counter, reload
C $CF33,4 Check cycle < 4
C $CF37,6 Check facing direction
C $CF3D,5 Check obstacle right, stop if blocked
C $CF42,5 Step right one column
C $CF47,5 Check obstacle left, stop if blocked
C $CF4C,3 Step left one column
C $CF4F,3 Return state 4 (continue walking)
C $CF52,6 Clear counter, return state 2
c $CF59 Personage action handler 5: kick/attack, execute swing, resolve hit
N $CF59 Plays out a kick: steps the character forward a little as the swing goes out (bumping off any obstacle in the way), and partway through checks whether the attacker itself has taken enough hits to go down instead of finishing the move. Once the swing completes it settles back into walking.
C $CF5D,3 Check for floor tile beneath personage
C $CF70,3 Check hit threshold, kill personage and award points
C $CF7B,3 Compares IX and HL for equality
C $CF97,3 Check obstacle to the left, or left room edge
C $CFA1,3 Check obstacle to the right, or right room edge
c $CFB3 Personage action handler 6: jump, apex reached, prepare landing
c $CFBD Personage action handler 7: jump, rising motion (2 rows per tick)
c $CFCE Personage action handler 8: jump, diagonal motion via frame table, bump off obstacle
N $CFCE Carries a diagonal jump along one step: it advances the jump arc (getting the next height offset from the arc table) and moves the character one column in the direction faced, unless a wall blocks that side. When the arc reaches its end - or an obstacle stops it - the character lands, drops a row and returns to walking.
C $CFCE,4 Look up frame offset, test zero
C $CFD2,2 Cycle done: land
C $CFD4,6 Check facing direction
C $CFDA,5 Check obstacle right, land if blocked
C $CFDF,2 Skip left-obstacle check
C $CFE1,5 Check obstacle left, land if blocked
C $CFE6,3 Step left one column
C $CFE9,3 Return state 10 (continue jump)
C $CFEC,7 Land: step down one row, clear frame
C $CFF3,5 Return state 2 (walking), dispatch
c $CFF8 Personage action handler 9: jump, diagonal motion, advance column
C $CFF8,3 Advance jump-cycle counter, look up next frame offset
c $D007 Advance jump-cycle counter, look up next frame offset
R $D007 IX address of personage description
b $D018
c $D023 Personage action handler 10: jump, landing, step forward one column
c $D032 Personage action handler 11: jump, landing, check floor and resume walking
C $D036,3 Check for ceiling/obstacle above personage
c $D03F Personage action handler 12: falling, descend via frame table, check rope catch
N $D03F Runs a fall: it drops the character down following the arc frame table, and part way through each drop checks whether they've caught a rope or ladder - grabbing it and switching to climbing if so. When the fall bottoms out it lands and returns to walking.
C $D03F,3 Advance jump-cycle counter, look up next frame offset
C $D04A,3 Check for rope/ladder under personage
c $D063 Personage action handler 13: climbing, handle up/down/left/right input on rope/ladder
N $D063 Runs a character's climb one frame at a time: while up or down is held it steps them along the rope/ladder and cycles the climbing animation frame, and if left or right is pressed instead it steps them off sideways (checking for an obstacle first) and drops them out of the climb. With no direction held it just switches to the standing-on-a-rope handler.
C $D063,4 Save input/state byte (IX+2)
C $D067,5 Branch if not on rope/ladder (D405 check)
C $D06C,5 Check input code == 8 (down)
C $D071,2 Else go handle other input
C $D073,5 Check animation frame >= 4
C $D078,2 Skip climb-step call if so
C $D07A,5 Check climb blocked, clear A
C $D07F,2 Skip frame reload if blocked
C $D081,3 Reload animation frame
C $D084,4 Wrap frame past 4
C $D088,3 Step up one row
C $D08B,2 Mask frame to climb-cycle range
C $D08D,3 Store new animation frame
C $D090,7 Toggle facing/parity bit
C $D097,3 Store toggled parity
C $D09A,4 Switch to action handler 8
C $D09E,4 Restore state, dispatch next handler
C $D0A2,4 Check input code == 4 (up)
C $D0A6,3 Store size of personage image to image_size variable
C $D0A9,4 Row + image size sum
C $D0AD,4 Stop climbing at top row
C $D0B1,5 Advance climb frame
C $D0B6,5 Mask and store frame
C $D0BB,2 Continue if mid-cycle
C $D0BD,3 Step up one row
C $D0C0,2 Continue dispatch
C $D0C2,4 Restore state, load frame
C $D0C6,4 Clear animation frame
C $D0CA,3 Skip row step if frame was zero
C $D0CD,3 Step up one row
C $D0D0,3 Return with handler-11 result
C $D0D3,5 Check input code == 1 (left)
C $D0D8,2 Else check other input
C $D0DA,3 Restore state, compare to 0Fh
C $D0DD,2 Skip obstacle check if already 0Fh
C $D0DF,5 Check obstacle to left
C $D0E4,4 Blocked: set state 0Fh
C $D0E8,3 Step left one column
C $D0EB,3 Set state 0Eh, save
C $D0EE,3 Continue dispatch
C $D0F1,5 Check input code == 2 (right)
C $D0F6,3 Restore state, compare to 0Fh
C $D0F9,2 Skip obstacle check if already 0Fh
C $D0FB,5 Check obstacle to right
C $D100,5 Blocked: set state 0Fh, step right
C $D105,2 Continue
C $D107,6 No input: switch to handler 8, return
c $D10D Personage action handler 14: climbing, dismount entry (falls into handler 13)
c $D112 Personage action handler 16: kick/attack, recovery animation, award points on hit
N $D112 Plays out the recovery pose after a punch/kick, cycling its own timer down; once the recovery is done and there's still floor underfoot, it checks whether Bruce landed the hit right on top of an enemy's column and, if so, awards a bonus, before switching back to walking.
C $D112,4 Recovery timer running?
C $D118,4 Advance timer, wrap
C $D11E,3 Step down one row
C $D124,7 Set state 2, return recovery frame
C $D12B,3 Check for floor tile beneath personage
C $D12E,4 No floor: stay recovering
C $D135,3 Compares IX and HL for equality
C $D138,2 Not Bruce: skip bonus
C $D13A,4 BC = Bruce's hit column
C $D141,3 Compare to Ninja's column
C $D149,3 Compare to Yamo's column
C $D151,3 Add points to current player score
C $D154,9 Set state 6, dispatch
c $D15D Personage action handler 17: enter climbing, snap to ladder tile
c $D16F Personage action handler 18: being hit, recoil away, escalate to knockback at high hit count
N $D16F The hurt reaction: while the character's damage total is still modest it just staggers one step backwards away from the blow (checking that side is clear first), but once the damage passes a threshold it escalates to the heavier knockback handler instead.
C $D16F,5 Check hit counter >= 10
C $D174,3 => Personage action handler 20
C $D177,4 Switch to handler 10 (hurt state)
C $D17B,6 Check facing direction
C $D181,5 Check obstacle right
C $D186,1 Return if blocked
C $D187,5 Step left, continue
C $D18C,5 Check obstacle left
C $D191,1 Return if blocked
C $D192,3 Step right
C $D195,3 Return state 20
c $D198 Personage action handler 19: hit reaction, apply damage and knockback flag
C $D198,3 Check hit threshold, kill personage and award points
c $D1A2 Personage action handler 20: recoil, step back after being blocked, resume walking
N $D1A2 Handles the stagger after a character walks into an obstacle: it steps them one column back the way they came (checking that side is clear too), drops them to the floor if there's nothing underneath, and settles them back into the walking state.
C $D1A2,4 Clear jump counter
C $D1A6,4 Switch to handler 3 (walking)
C $D1AA,6 Check facing direction
C $D1B0,5 Check obstacle right, hit-react if blocked
C $D1B5,3 Step left one column
C $D1B8,4 IX+02=6 (recoil frame)
C $D1BC,3 Check for floor tile beneath personage
C $D1BF,2 Skip fall if floor present
C $D1C1,3 Step down one row
C $D1C4,4 Clear animation frame
C $D1C8,3 Return state 6 (walking)
C $D1CB,5 Check obstacle left, hit-react if blocked
C $D1D0,2 Continue
c $D1D2 Personage action handler 21: attack, detect melee hit on all personages, trigger hurt state
C $D1D5,3 Detect melee hit on adjacent personage and apply damage
C $D1DB,3 Detect melee hit on adjacent personage and apply damage
C $D1E1,3 Detect melee hit on adjacent personage and apply damage
c $D1EB Check hit threshold, kill personage and award points
N $D1EB Decides if a character has taken enough punishment to go down: once its accumulated damage passes a limit (the Ninja gives out sooner than the others) it's flagged as dying and its damage tally is cleared. If the one that just died is an enemy, the player is awarded points for the kill; Bruce dying scores nothing.
C $D1F5,3 Compares IX and HL for equality
C $D20C,3 Compares IX and HL for equality
C $D219,3 Compares IX and HL for equality
C $D224,3 Add points to current player score
C $D230,3 Compares IX and HL for equality
C $D245,3 Add points to current player score
c $D24E Single gameplay step of personage
R $D24E IX address of personage description
@ $D24E label=pers_play_step
N $D24E Called once per frame for each of the 3 personage structs ($CB1C, $CBBE, $CCA5 - Bruce and two enemies), same as the Atari port's shared UpdateState looping actors 0-2. (IX+0) holds the current action-handler number (1 of 22, see #R$CD9B), dispatched via the table at #R$CCBB - same role as ActState. (IX+4) is the per-state animation/delay counter (ActStateTime), (IX+3) is the facing bit (ActFace), (IX+0B) is the decoded input direction (Joystick1,X).
C $D254,1 Personage defeated and dying
C $D25C,1 Personage started to dying
N $D264 Personage already dying for a while
@ $D264 label=already_dying
N $D26A When personage defeated he is flashing for a while
@ $D26A label=visible_flash_stage
@ $D26D label=invisible_flash_stage
@ $D271 label=defeate_sound_not_muted
C $D274,3 Compares IX and HL for equality
C $D279,4 When sound is not muted, flash only from 4bh to 64h steps (shorter flashing interval).
N $D285 Step for healthy and alive personage
@ $D285 label=normal_play_step
C $D288,1 Personage is delayed and does nothing
C $D289,3 Reload delay cycle for personage next step
C $D293,3 => Return personage from the dead
C $D296,3 Returns desired action for given personage
C $D299,3 Store personage action to personage description
C $D29C,3 Look up objects at personage location
C $D29F,3 Get personage image index
C $D2A2,1 Exclude "not alive" zero value
C $D2A4,1 4 bytes per image reference
C $D2A5,2 Add offset of images references relative to personage description
C $D2AA,2 IX contains address of personage description
C $D2AD,1 Address of image reference is ready
C $D2AE,1 Get address of image description from image reference
C $D2B1,1 Store address of image description to HL
C $D2B2,3 Get X coordinate of personage
C $D2B5,3 Get Y coordinate of personage
C $D2B9,3 Get current image index of personage
C $D2BC,3 Dispatch to personage action handler
C $D2BF,3 Store image index back
C $D2C2,1 Restore original personage coordinates
C $D2C3,3 Get new X coordinate of personage
C $D2C6,1 Compare it with original coordinate
C $D2C9,1 Need to check that personage is not out off screen in bottom direction
N $D2CA Personage moved to up direction
@ $D2CA label=pers_moved_up
C $D2CE,2 Return personage back to bottom of the screen
@ $D2D0 label=not_out_to_bottom
c $D2EA Dispatch to personage action handler (jump via HL)
R $D2EA HL address of the action handler to jump to
c $D2EB Return personage from the dead
@ $D2EB label=revive_pers
N $D2EB Brings a defeated enemy back to life once its respawn countdown runs out, dropping it back in at the room's spawn point with fresh state; the player (Bruce) is never revived this way and is skipped immediately.
C $D2EE,3 Compares IX and HL for equality
C $D2F1,1 Bruce: never revived, return
C $D2F2,6 HL = spawn record for this room (early rooms use alt table)
C $D2FC,3 Alt spawn table
C $D2FF,3 Spawn slot empty/disabled: return
C $D302,4 Count down respawn timer, return until zero
C $D306,6 Restore facing from spawn record
C $D30C,7 Restore X/Y position from spawn record
C $D316,16 Reset to alive, standing, frame 0
C $D326,3 Compares IX and HL for equality
C $D32D,4 Yamo gets a special entrance action
@ $D306 label=do_revive
C $D329,3 Compares IX and HL for equality
c $D332 Check for floor tile beneath personage
@ $D332 label=check_floor_below
N $D332 Looks at the room tiles just below the character's feet, across its full width, and reports whether there's solid floor there (so the movement code knows whether it's standing or should fall).
C $D332,3 Return in HL address of personage's cell in playroom
C $D335,3 Store size of personage image to image_size variable
c $D353 Check for ceiling/obstacle above personage
@ $D353 label=check_ceiling_above
N $D353 Looks at the room tiles just above the character's head, across its full width, and reports whether a solid tile is blocking upward movement (so the movement code knows if a jump or climb-up is possible).
C $D35A,3 Return in HL address of personage's cell in playroom
C $D35D,3 Store size of personage image to image_size variable
c $D371 Entry to melee-hit detection, D=8 (kick damage)
R $D371 HL address of target personage description
c $D375 Detect melee hit on adjacent personage and apply damage
R $D375 HL address of target personage description
N $D375 Decides whether an attacker's blow lands on a given target: it checks the target is alive and standing right next to the attacker on the side it's facing, and if so adds to the target's damage total, knocks it into its hurt reaction, and plays the hit sound. Most targets take doubled damage (one particular enemy is exempted), and a solid kick also flags the attacker so its own follow-through can be handled.
C $D375,2 D = damage amount
C $D377,3 Compares IX and HL for equality
C $D37A,1 Return if same personage
C $D37B,5 IY = target personage struct
C $D380,4 Check target not dying
C $D384,3 Skip if already dying
C $D387,4 Check target alive
C $D38B,3 Skip if dead
C $D38E,6 Compare attacker row to target row
C $D394,2 Same row: check facing
C $D396,4 Check row below
C $D39A,2 Not adjacent row: no hit
C $D39C,6 Check attacker facing
C $D3A2,4 Attacker column+1
C $D3A6,5 Compare to target column
C $D3AB,4 Check column+2
C $D3AF,2 Not adjacent: no hit
C $D3B1,4 Face target left
C $D3B5,2 Apply damage
C $D3B7,6 Compare attacker column to target
C $D3BD,2 Same column: apply
C $D3BF,4 Check column-1
C $D3C3,2 Not adjacent: no hit
C $D3C5,4 Face target right
C $D3C9,4 Add damage to hit counter
C $D3CD,3 Store hit counter
C $D3D0,3 Check if target is the Ninja
C $D3D3,3 Compares IX and HL for equality
C $D3D6,2 Skip extra damage if Ninja
C $D3D8,7 Double damage for non-Ninja target
C $D3DF,8 Set target to hurt state
C $D3E7,4 Check sound-enabled flag
C $D3EB,3 Play hit sound
C $D3EE,3 Check if target is Bruce
C $D3F1,3 Compares IX and HL for equality
C $D3F4,2 Skip if not Bruce
C $D3F6,3 Store kick damage on Bruce (IX+11)
C $D3F9,3 Check for kick damage amount
C $D3FC,2 Skip if not kick
C $D3FE,4 Set attacker's kick-hit counter
C $D402,3 Restore, return
c $D405 Check for rope/ladder under personage
@ $D405 label=check_rope_below
N $D405 Works out whether the character is standing over something climbable: it scans the room tiles across the character's footprint counting rope/ladder tiles, and reports back whether enough were found to count as being on a rope. This is what lets the movement code decide if up/down should start a climb.
C $D405,3 Return in HL address of personage's cell in playroom
C $D408,3 Store size of personage image to image_size variable
C $D40B,2 D = row count - 1
C $D40D,4 Check animation frame
C $D411,3 Extend scan if mid-frame
C $D414,2 E = rope-tile counter
C $D416,3 Load tile, check upper bound
C $D419,2 Skip if not rope range
C $D41B,4 Check lower bound
C $D41F,4 Count rope tiles, check 2 found
C $D423,1 Return if enough rope
C $D424,2 Advance to next column
C $D426,2 Loop columns
C $D428,2 Compare rope count to threshold
C $D42A,1 Return if matched
C $D42B,4 C = row width
C $D42F,3 Compute row step
C $D432,2 Advance to next row
C $D434,2 Skip carry
C $D436,1 Carry into row
C $D437,2 Loop remaining rows
C $D439,2 Restore counter, return
c $D43B Check obstacle to the left, or left room edge
R $D43B IX address of personage description
c $D447 Check obstacle to the right, or right room edge
R $D447 IX address of personage description
c $D456 Check for obstacle ahead of personage (facing-direction aware)
N $D456 Scans the room tiles immediately beside the character, on whichever side it's currently facing, and reports whether something solid is blocking the way there; right at the edge of the room, Bruce is stopped but the Ninja and Yamo are allowed through.
C $D456,6 Branch by facing direction
C $D45C,6 At column 0? else scan left
C $D465,5 Ninja allowed past edge
C $D46B,6 Yamo allowed past edge, else blocked
C $D472,3 Return in HL address of personage's cell in playroom
C $D475,3 Store size of personage image to image_size variable
C $D479,3 DE = one room row step
C $D47C,4 Extend scan if mid-frame
C $D483,5 Solid tile found?
C $D48D,2 Clear: no obstacle
C $D48F,3 Return in HL address of personage's cell in playroom
C $D492,3 Store size of personage image to image_size variable
C $D495,6 At right edge?
C $D49D,4 Skip past own width
c $D4A3 Return in HL address of personage's cell in playroom
C $D4A3,6 HL = personage tile coords
C $D4A9,6 Rotate row bits into low nibble
C $D4AF,4 Fold coord bits into column
C $D4B3,2 Combine and store column
C $D4B5,4 Mask row, store
C $D4B9,4 Add room data base address
C $D4BD,1 Return
@ $D4A3 label=get_pers_room_addr
R $D4A3 IX address of personage description
N $D4A3 Address is Y * 20h + X + current_room_playing_data
c $D4BE Store size of personage image to image_size variable
R $D4BE IX address of personage description
@ $D4BE label=get_pers_image_size
N $D4BE Looks up how big the character's current pose is: from its state record it finds the matching image descriptor and reads out the sprite's width and height (in 8-pixel cells), leaving them in a scratch variable for other routines to use.
C $D4C0,3 Get personage image index
C $D4C3,1 Exclude "not alive" zero value
C $D4C5,1 4 bytes per image reference
C $D4C6,2 Add offset of images references relative to personage description
C $D4CE,1 HL contains image reference
C $D4D1,1 DE contains image description address
C $D4D6,1 Get image width
C $D4D8,1 Get image height
c $D4E0 Compares IX and HL for equality
R $D4E0 IX first struct address to compare
R $D4E0 HL second struct address to compare
N $D4E0 A tiny helper that checks whether IX and HL point to the same address (returning with the zero flag set if they match), used all over the code to ask "is this the player?" or "is this that particular character?".
@ $D4E0 label=compare_IX_HL
c $D4EC Look up objects at personage location
@ $D4EC label=review_pers_location
N $D4EC Scans every room tile under the character's footprint each frame to see what it's standing on: harmless scenery is skipped, a "tricky" object dispatches to its own room-specific handler, a dangerous object hurts the character if their pixels actually touch, and a collectable (key, lamp, etc.) is picked up by Bruce - awarding points, playing a sound, and permanently marking it taken - once pixels confirm the touch too.
C $D4EC,3 Return in HL address of personage's cell in playroom
C $D4EF,3 Store size of personage image to image_size variable
C $D4F6,1 Walk over width and height of the image
N $D4F8 Review personage location in playroom
N $D4F8 for various objects presence
@ $D4F8 label=pers_location_review_loop
C $D4FD,2 Object with 18h - ffh code
C $D503,2 Object with 10h - 16h code
@ $D505 label=safe_object
C $D515,1 HL contains address of next row of room data behind personage
@ $D51A label=pers_on_17_object
N $D524 Dangerous object detected at personage location
@ $D524 label=danger_object
C $D528,3 check collision between personage and an playroom object
N $D539 Key, lamp, etc.
N $D539 This object should be taken by Bruce
@ $D539 label=collectable_object
C $D540,3 Compares IX and HL for equality
C $D547,3 check collision between personage and an playroom object
C $D54F,3 Add points to current player score
C $D575,3 Draw personage's action-target tiles from will table
C $D57C,3 Handle object impact
@ $D57F label=skip_object
b $D586
B $D586,1,1
c $D587 check collision between personage and an playroom object
@ $D587 label=check_collision
N $D587 Does a pixel-perfect touch test between the character's sprite and an object's graphic, overlapping their pixel data row by row and reporting a hit as soon as any of the on pixels line up.
C $D588,1 Get playroom object code
C $D58C,1 Multiply it on 8
C $D58F,4 DE = room tile data base
C $D594,3 Get personage Y offset
C $D59A,2 BC = sprite pixel address
C $D5A4,3 DE = right-facing sprite bank
C $D5A7,6 Check facing direction
C $D5AD,2 Left-facing bank
C $D5B0,3 Test pixel overlap
C $D5B6,4 Loop 8 rows
c $D5BB Draw personage's action-target tiles from will table
R $D5BB A personage index
R $D5BB HL target tile coordinates
N $D5BB Looks up a character's "will" table to find the entry matching the given position, then permanently redraws every tile listed for that entry - this is how scenery changes for good once a character reaches the right spot (e.g. an object appearing or a door opening).
C $D5BB,6 Save personage index and coords
C $D5C1,4 L = index*2, H = table page
C $D5C5,3 DE = will-table entry pointer
C $D5C8,4 HL = pointer + 6 (action-list offset)
C $D5CC,4 DE = action-list address
C $D5D0,4 DE = saved coords, HL = action-list pointer
C $D5D4,3 A = list terminator/entry byte
C $D5D7,1 Return if end of list
C $D5D8,4 Check if entry is default (no coord match)
C $D5DC,5 Save default entry, load match X
C $D5E1,4 Compare entry X to target
C $D5E5,2 Compare entry Y to target
C $D5E7,4 Advance to next list entry, loop
C $D5EB,3 HL = matched (or default) entry
C $D5EE,5 Mask entry's action-mask bits
C $D5F3,1 Store masked action mask
C $D5F4,4 B = current game state/level
C $D5F8,4 Compare saved personage index to state
C $D5FC,1 Return if mismatch
C $D5FD,4 DE = target coord pointer
C $D601,3 Save list pointer, HL = target coord
C $D604,4 Draw target tile, restore list pointer
C $D608,5 Advance, loop while more targets
c $D60E Draw personage tile to screen and offscreen buffer (variant of D626)
R $D60E A tile/element index to draw
R $D60E HL tile coordinates (H=row, L=column)
N $D60E Same tile-drawing job as #R$D626, but for callers that already know which graphic to use rather than looking it up from the room map.
C $D60E,3 Save tile index, rotate row bits
C $D611,4 Rotate row bits into low nibble
C $D615,4 Fold coord bits into scene column
C $D619,2 Combine and store column
C $D61B,4 Mask row, store
C $D61F,2 Restore tile index, save coord
C $D621,5 DE = personage image data pointer, join draw
c $D626 Draw single scene tile to screen and offscreen buffer
R $D626 HL tile coordinates (H=row, L=column)
N $D626 Redraws one scene tile at the given room coordinate: it looks up which graphic belongs there, paints it into the offline pixel buffer, and updates the matching screen colour too, so the tile and its colour stay in sync.
C $D626,6 Rotate row bits into low nibble of H
C $D62C,5 Fold coord bits into scene column
C $D631,4 Combine row/col, mask row
C $D635,2 Save scene tile coord
C $D637,4 HL = scene-map tile address
C $D63B,1 A = tile element index
C $D63C,4 HL = scene overlay-map tile address
C $D640,2 Store tile index to overlay map
C $D642,5 Look up drawn-element index
C $D647,5 HL = screen attribute address
C $D64C,1 Store element index
C $D64D,4 Shift to shadow/buffer attribute area
C $D651,3 Store to shadow attribute area
C $D654,4 HL = personage image data pointer
C $D658,3 Multiply pointer by 8
C $D65B,2 Add offset, A = row
C $D65D,3 Rotate row into high bits
C $D660,3 B = screen third selector
C $D663,3 D = screen high byte
C $D666,3 E = screen low byte, row counter A=8
C $D669,4 Copy pixel byte to screen + shadow
C $D66D,3 Advance to next screen third row
C $D670,2 Restore row counter
C $D672,2 Loop for 8 pixel rows
c $D675 Returns desired action for given personage
R $D675 IX address of personage description
N $D675 The AI brain for a computer-controlled character: it works out a fake joystick direction for this frame, the same kind of code the movement code reads from a real controller, so it can steer the character without a human touching it. Depending on what the character is doing it climbs ladders, avoids ledges and obstacles, and heads towards or attacks the nearest target, occasionally throwing in a random direction change so movement doesn't look too robotic. Bruce normally skips all this and uses the real input instead - this logic only drives him during the brief "computer takes over" moments, and always drives the enemies.
@ $D675 label=get_pers_action_will
C $D678,3 Compares IX and HL for equality
C $D67B,3 Bruce: return his real input, done
C $D67F,6 Skip Yamo timing if no player 2
C $D688,3 Compares IX and HL for equality
C $D68D,6 Read/clamp Yamo aggression timer to max 6
C $D699,5 Else clear timer if flagged
C $D6A1,3 Dispatch by current action: idle, walking, climbing or none
C $D6B0,2 Mid-action: no AI input this frame
C $D6B2,3 Check for ceiling/obstacle above personage
C $D6C7,6 On rope: compare row to Bruce's
C $D6D4,6 Same row as target?
C $D6DD,8 Adjacent left: punch/kick (state 10/11)
C $D6EE,9 Adjacent right: punch/kick (state 10/11)
C $D706,7 Two columns right: bokken/attack (state 12)
C $D710,6 Not aligned: face toward target
C $D726,3 Check for obstacle ahead of personage
C $D72C,7 Return walk direction (1=left, 2=right)
C $D734,8 Blocked: turn around, pause (state 32h)
C $D742,7 Target above and adjacent row?
C $D74E,3 Compares IX and HL for equality
C $D753,3 Step up toward target
C $D756,3 Check for rope/ladder under personage
C $D768,4 Occasionally (1 in 4) jump toward target's home spot
C $D771,3 Compares IX and HL for equality
C $D774,5 Pick Ninja or Yamo home coordinate
C $D77C,6 At home row and 2 left of it?
C $D78A,7 Face and start jump (state 10)
C $D791,5 4 right of home? face and jump
C $D79D,3 Check for obstacle ahead of personage
C $D7A3,9 Return walk direction, else turn
b $D7AC
W $D7AC
N $D7FC Table of handlers of object with 17h code for each room number
W $D7FC
@ $D7FC label=table_of_17_object_handlers
c $D824 No-op object handler (17h object, no room-specific trigger)
@ $D824 label=empty_17_object_handler
c $D825 Draw
R $D825 HL source graphics data address
R $D825 DE destination address in offline screen buffer
R $D825 B number of 8-byte blocks per column
R $D825 C number of columns
N $D825 A general-purpose block-image copier: it copies a rectangular picture, one 8-pixel-wide column at a time, straight from raw graphics data into the offline screen buffer - used for the title-screen logo and other fixed images rather than the sprite/tile machinery elsewhere.
C $D825,3 Save block counter, row counter=8
C $D828,3 Copy tile byte, advance source
C $D82B,3 Advance dest row, loop 8
C $D82E,4 Wrap dest row back
C $D832,2 Advance dest column, decrement block count
C $D834,2 Loop remaining blocks
C $D836,1 Restore block counter
C $D837,2 Compute column wrap
C $D839,3 Advance to next screen third
C $D83C,2 Skip wrap if no carry
C $D83E,4 Wrap to next screen row
C $D842,2 Loop remaining columns
C $D844,1 Return
@ $D825 label=draw
c $D845 Object handler: timed trigger of will-target 1
C $D853,3 => Draw personage's action-target tiles from will table
c $D856 Object handler: room-specific trap trigger
N $D856 Watches Bruce's position in this room and, once he crosses a coordinate boundary, either switches the water-colour mode or triggers one of a couple of one-off scripted events.
C $D856,3 Check Y coord threshold
C $D859,2 Else use alt path
C $D85B,3 Check X coord threshold
C $D85E,1 Return if too early
C $D85F,5 Set water-color mode 1
C $D864,6 Select target 1
C $D86A,2 Trigger target
C $D86C,4 Advance room counter
C $D870,3 Check counter == 4
C $D873,2 Continue if not
C $D875,6 Select target 2
C $D87B,2 Trigger target
C $D87D,3 Check counter == 2, else return
C $D880,6 Select target 3
C $D886,2 Trigger target
c $D888 Object handler: room-specific trap trigger
c $D898 Object handler: room-specific trap trigger
N $D898 Watches Bruce's position in this room and, once he crosses a coordinate boundary on either side, triggers one of a few one-off scripted events, each armed by lingering there for a set number of frames.
C $D898,3 Check Y coord threshold
C $D89B,2 Else use alt path
C $D89D,4 Advance room counter
C $D8A1,3 Check counter == 5
C $D8A4,2 Continue if not
C $D8A6,6 Select target 1 (will target coord)
C $D8AC,2 Trigger target
C $D8AE,3 Check counter == 10, else return
C $D8B1,6 Select target 2
C $D8B7,2 Trigger target
C $D8B9,4 Advance alt room counter
C $D8BD,3 Check counter < 2
C $D8C0,1 Return if too early
C $D8C1,3 HL = data table entry
C $D8C4,3 Store first byte
C $D8C7,3 Store second byte
C $D8CA,2 Store third byte
C $D8CC,6 Select target 3
C $D8D2,2 Trigger target
c $D8D4 Object handler: room-specific trap trigger
N $D8D4 Watches Bruce's position in this room and, once he strays past a coordinate boundary, triggers a one-off scripted event there.
C $D8D4,3 Check X coord threshold
C $D8D7,2 Else use alt path
C $D8D9,3 HL = data table entry
C $D8DC,3 Store first byte
C $D8DF,3 Store second byte
C $D8E2,2 Store third byte
C $D8E4,6 Select target 1
C $D8EA,2 Trigger target
C $D8EC,3 Check X threshold, else return
C $D8EF,4 Advance room counter
C $D8F3,3 Check counter < 2
C $D8F6,1 Return if too early
C $D8F7,3 Set water color mode
C $D8FA,6 Select target 2
C $D900,2 Trigger target
c $D902 Object handler: room-specific trap trigger
N $D902 Watches Bruce's position in this room and, once he strays past a coordinate boundary, either switches the water-colour mode or triggers a one-off scripted event.
C $D902,3 Check Y coord threshold
C $D905,3 Below: set water color mode 1
C $D908,3 Check upper bound, else return
C $D90B,3 Check X coord threshold
C $D90E,3 Beyond: set water color mode 2
C $D911,4 Advance room counter
C $D915,3 Check counter == 2
C $D918,1 Return unless matched
C $D919,6 Copy pattern byte to target slot
C $D91F,6 Select target
C $D925,3 => Draw personage's action-target tiles from will table
c $D928 Object handler: room-specific trap trigger
c $D938 Object handler: room-specific trap trigger
c $D948 Object handler: room-specific trap trigger
c $D958 Object handler: room-specific trap trigger
N $D958 Watches Bruce's position in this room and, once he lingers past a coordinate threshold on either side, triggers a one-off scripted event there.
C $D958,3 Check Y coord threshold
C $D95B,2 Else use alt path
C $D95D,4 Advance room counter
C $D961,3 Check counter == 2
C $D964,1 Return unless matched
C $D965,6 Select target 1
C $D96B,2 Trigger target
C $D96D,4 Advance alt room counter
C $D971,3 Check counter == 2
C $D974,1 Return unless matched
C $D975,6 Select target 2
C $D97B,2 Trigger target
c $D97D Object handler: room-specific trap trigger
c $D98D Award points for picking up weapon, then flash animation
N $D98D Awards the player points for grabbing the weapon, redraws it as carried by Bruce, and plays a brief screen flash before signalling that the pickup is complete.
C $D990,3 Add points to current player score
C $D993,3 Updates area of personage from offscreen to screen
C $D9A0,3 Draws personage to offscreen
C $D9A5,3 Updates Video-RAM from offline drawing buffer
C $D9BB,3 XOR 10 attribute bytes with 07h
c $D9CD XOR 10 attribute bytes with 07h (flash effect)
R $D9CD HL address of first attribute byte
c $D9D7 Update all wall-crack counters and spread cracks
C $D9DE,3 Handle wall-crack hit counter and spread cracks
c $D9E7 Handle wall-crack hit counter and spread cracks
R $D9E7 HL address of a wall-crack record (counter byte + coord word)
N $D9E7 Ages one crack: bumps its hit counter and, once it crosses set thresholds, redraws it a stage worse (a bigger crack, then final collapse which clears the record). At a few in-between thresholds it also spreads copies of the crack out to the 6 neighbouring cells around it, so a crack grows into a spidering pattern over time rather than just deepening in place.
C $D9E7,4 Increment hit counter, compare to threshold 20
C $D9EB,1 Return if below threshold
C $D9EC,2 Save counter pointer and coords
C $D9EE,5 DE = coords, HL = target list pointer
C $D9F3,4 Check counter == 20
C $D9F7,2 A = tile index for stage 1 crack
C $D9F9,3 Draw crack tile
C $D9FC,3 Restore and return
C $D9FF,4 Check counter == 50
C $DA03,4 A = tile index for stage 2 crack, draw
C $DA07,4 Check counter == 55
C $DA0B,3 Draw final collapse tile
C $DA0E,3 Clear target cell
C $DA11,2 Restore and return
C $DA13,3 DE = spread pattern A
C $DA16,4 Check counter == 25
C $DA1A,4 Check counter == 40
C $DA1E,3 DE = spread pattern B
C $DA21,4 Check counter == 30
C $DA25,3 DE = spread pattern C
C $DA28,4 Check counter == 45, else return
C $DA2C,3 Save coords, move to top-left neighbour
C $DA2F,9 Spread crack to top row (3 cells)
C $DA38,2 Restore coords, move to left neighbour
C $DA3A,9 Spread crack to middle/bottom row (3 cells)
C $DA43,3 Return via shared exit
c $DA46 Draw one crack-spread tile, advance list and coord pointers
C $DA49,3 Draw personage tile to screen and offscreen buffer
b $DA51
t $DA5D
b $DA61
c $DA63 Tricky handler of object with 17h code for some rooms
R $DA63 HL address of the object's cell in the playroom
N $DA63 Starts a new wall crack at the given room cell: it finds a free slot in the 6-slot crack-record table used by #R$D9E7/#R$D9D7, claims it with this tile's coordinates, and draws the first crack tile there.
C $DA63,5 HL = coord, DE = base address
C $DA68,2 HL = offset from base
C $DA6A,4 Fold coord bits into tile row
C $DA6E,4 Combine and rotate to scene column
C $DA72,3 Mask row, store
C $DA75,4 Mask column
C $DA79,4 DE = tile coord, HL = crack-slot table
C $DA7D,2 6 slots
C $DA7F,2 Check if slot free
C $DA81,2 Use free slot
C $DA83,3 Advance to next slot
C $DA86,2 Loop 6 slots
C $DA88,1 No free slot: return
C $DA89,5 Mark slot used, store coord
C $DA8E,3 A = crack tile index
C $DA91,3 Draw crack tile
@ $DA63 label=handler_of_17_object
c $DA94 Animate flickering tile (room-specific)
C $DA94,3 DE = tile coord for animated object 1
C $DA97,4 HL = counter, A = counter value
C $DA9B,2 Return if counter zero
C $DA9D,3 Advance, force odd
C $DAA0,3 Store, test bounce bit
C $DAA3,4 A = tile 1
C $DAA7,2 Else tile 2
C $DAA9,4 Draw animated tile
c $DAAD Animate flickering tile (room-specific)
c $DAB2 Redraw wall-crack tile (room-specific), then animate water
C $DAB2,3 Advance water/crack animation phase
C $DAB5,3 => Animate water ripple tiles
C $DABE,3 Ripple water colour area and push characters clear
C $DAC1,3 => Animate water ripple tiles
c $DAC4 Randomly jump to $0000 based on R register (reset trap)
c $DACC Redraw wall-crack tile (room-specific), then animate water
C $DACC,3 Advance water/crack animation phase
C $DACF,3 => Animate water ripple tiles
C $DAD8,3 Ripple water colour area and push characters clear
C $DADB,3 => Animate water ripple tiles
c $DADE Redraw moving object (room-specific), update cracks, animate water
C $DAEE,3 Animate moving object between two columns
C $DAF3,3 Update all wall-crack counters and spread cracks
C $DAF6,3 => Animate water ripple tiles
b $DAF9
c $DAFF Redraw 3 wall-crack tiles (room-specific), then animate water
C $DAFF,3 Advance water/crack animation phase
C $DB02,3 => Animate water ripple tiles
C $DB0B,3 Ripple water colour area and push characters clear
C $DB14,3 Ripple water colour area and push characters clear
C $DB1D,3 Ripple water colour area and push characters clear
C $DB20,3 => Animate water ripple tiles
c $DB23 Ripple all wall-crack water patches after level reset
N $DB23 On the first call after a level reset it re-ripples every wall-crack water patch in the room in turn, then goes on to advance a small decorative moving pattern (or falls back to the ordinary water-ripple animation once enough frames have passed without needing the full redraw).
C $DB23,5 Skip crack redraw if already flagged
C $DB28,9 Redraw crack tile (repeated below for other tiles)
C $DB37,3 Ripple water colour area and push characters clear
C $DB40,3 Ripple water colour area and push characters clear
C $DB49,3 Ripple water colour area and push characters clear
C $DB52,3 Ripple water colour area and push characters clear
C $DB5B,3 Ripple water colour area and push characters clear
C $DB64,3 Ripple water colour area and push characters clear
C $DB6D,3 Ripple water colour area and push characters clear
C $DB76,3 Ripple water colour area and push characters clear
C $DB7F,3 Ripple water colour area and push characters clear
C $DB82,3 HL = redraw-counter flag
C $DB85,6 Skip further redraw below threshold
C $DB8B,2 Clear redraw counter
C $DB8D,6 IX = default pattern table
C $DB93,7 Check level, else use default pattern
C $DB9A,4 IX = alt pattern table
C $DB9E,6 Draw pattern, restore, return
b $DBA4
c $DBB0 Animate water color cycle (bubbling effect)
N $DBB0 Ticks a counter and, at two points in its cycle, repaints two rows of the water's attribute colours with a different colour pair, giving the water a bubbling/flashing look; it also flags the screen as needing a redraw.
C $DBB0,4 Advance water color-cycle counter
C $DBB4,4 A = counter, DE = color pair 1
C $DBB8,4 Check for first phase
C $DBBC,3 DE = color pair 2
C $DBBF,3 Check for second phase, else return
C $DBC2,3 HL = screen attribute address
C $DBC5,3 Save target address
C $DBC8,2 6 blocks
C $DBCA,3 A = color byte 1, save regs
C $DBCD,3 Record scene element in companion tile map, then draw it
C $DBD0,2 Restore regs
C $DBD2,2 Loop 6 blocks
C $DBD4,3 HL = second screen row
C $DBD7,3 Save target address
C $DBDA,2 6 blocks
C $DBDC,3 A = color byte 2, save regs
C $DBDF,3 Record scene element in companion tile map, then draw it
C $DBE2,2 Restore regs
C $DBE4,2 Loop 6 blocks
C $DBE6,5 Flag redraw needed
C $DBEB,1 Return
c $DBEC Update wall cracks and animate water
C $DBEC,3 Update all wall-crack counters and spread cracks
C $DBEF,3 => Animate water ripple tiles
c $DBF2 Redraw wall-crack tile, update crack counters, check bonus condition
N $DBF2 Redraws this room's crack tile if it's time to animate, then ticks all the wall-crack counters and checks whether the current score qualifies for the wall-collapse bonus.
C $DBF2,3 Advance water/crack animation phase
C $DBFD,3 Ripple water colour area and push characters clear
C $DC00,3 Update all wall-crack counters and spread cracks
c $DC1D Force wall collapse and update cracks
C $DC24,3 => Update all wall-crack counters and spread cracks
c $DC27 Handle wall collapse and bonus-life award
N $DC27 Watches the wall's hit counter: once it's been battered enough it collapses (the crack tables are wiped and a collapse image shown), and if the collapse happens to land on a particular score value the player is given a bonus life for each remaining hit "charge" on the counter.
C $DC27,4 HL = wall-hit counter
C $DC2B,3 Skip if not hit yet
C $DC2E,4 Check for max-hit marker
C $DC32,2 Clear counter
C $DC34,3 HL = 0 (reset value)
C $DC37,3 Clear wall-crack table (repeated below for other walls)
C $DC46,5 Flag redraw needed
C $DC4B,3 Continue
C $DC4E,4 Clear busy flag, test top bit
C $DC52,2 Return if clear
C $DC54,5 Test collapse bit, HL = collapse image
C $DC59,2 Reset walls if collapsing
C $DC5B,5 Check score digit against threshold
C $DC60,2 Skip if below
C $DC62,5 Check other score digit
C $DC67,2 Skip if mismatch
C $DC69,4 HL = wall-hit counter
C $DC6D,4 Skip if counter exhausted
C $DC71,2 Decrement counter
C $DC73,3 Increase player lifes
C $DC76,2 Loop: reset walls again
c $DC78 Animate 8 moving objects (bubbles), gate by counter
N $DC78 Once enough frames have passed, steps all 8 bubble objects in this room forward one frame each, one after another, each using its own little descriptor from the table that follows.
C $DC87,3 Animate moving object between two columns
C $DC8E,3 Animate moving object between two columns
C $DC95,3 Animate moving object between two columns
C $DC9C,3 Animate moving object between two columns
C $DCA3,3 Animate moving object between two columns
C $DCAA,3 Animate moving object between two columns
C $DCB1,3 Animate moving object between two columns
C $DCB8,3 Animate moving object between two columns
b $DCBE
c $DCEE Animate moving object, else animate water ripples
C $DCF4,3 => Animate water ripple tiles
C $DCFF,3 Animate moving object between two columns
C $DD04,3 => Animate water ripple tiles
b $DD07
c $DD0D Animate wall-crumble tile
N $DD0D While a crumbling-wall timer is running, steps the crumble animation down the wall one tile row at a time; once the timer runs out it resets everything to start crumbling from the top again.
C $DD0D,6 Skip if no active crumble timer
C $DD13,4 Advance timer
C $DD17,3 Return before timer expires
C $DD1A,4 HL = crumble tile coord
C $DD1E,4 Draw current crumble frame
C $DD22,3 Check row against limit
C $DD25,4 Stop animating past limit
C $DD29,4 Advance row, load column step
C $DD2D,2 Advance column by step
C $DD2F,3 Store new crumble coord
C $DD32,5 Save current image pointer
C $DD37,3 DE = crumble frame image data
C $DD3A,5 Point to crumble frame, A=tile 0
C $DD3F,4 Draw crumble tile, restore pointer
C $DD43,4 Restore image pointer
C $DD47,1 Return
C $DD48,6 Reset crumble coord to start
C $DD4E,5 A = time value, B = -1
C $DD53,4 Check first threshold
C $DD57,3 Advance step, check second threshold
C $DD5A,3 Advance step if past threshold
C $DD5D,4 Store column step
C $DD61,5 Restart crumble timer
C $DD66,1 Return
c $DD67 Level-complete sequence: show win message, play sound, restart level
N $DD67 Runs the little celebration when the level is finished: shows the win message right away, then after a short wait plays the win jingle, resets the players ready for the next level, and loops the game back to start it.
C $DD67,4 A = win-sequence timer
C $DD6B,4 Advance timer, branch if not first tick
C $DD6F,5 Message text + row
C $DD74,3 Draw message and fill screen background color
C $DD77,1 A=0
C $DD78,6 Clear direction flags
C $DD7E,4 Clear flash flag, A=1
C $DD82,3 Set player-1 active
C $DD85,5 Set bright attribute
C $DD8A,1 Return
C $DD8B,4 Check timer == 3, else redraw message
C $DD8F,3 BC = tone params
C $DD92,4 Check difficulty flag
C $DD96,2 Skip if set
C $DD98,2 Alt tone param
C $DD9A,3 Play win jingle
C $DD9D,5 Flag level restart
C $DDA2,3 Reset stack
C $DDA5,3 Restart level
c $DDA8 Animate moving object between two columns (bounce pattern)
R $DDA8 IX address of the moving-object descriptor
N $DDA8 Moves a small scene object one step back and forth between a left and a right column, given its descriptor in IX (which holds the object's row, current column, the two end columns, and which way it's currently heading). Each call it redraws the object at its current spot, then advances one column in the travel direction - or flips direction when it reaches an end - so repeated calls make it patrol between the two edges.
C $DDA8,7 Check direction bit, A = current column
C $DDAF,4 Branch by direction, check right bound
C $DDB3,4 Bounce at right edge
C $DDB7,6 HL = tile coord
C $DDBD,3 Draw single scene tile to screen and offscreen buffer
C $DDC0,6 Compare column to left bound
C $DDC6,4 Continue right, else wrap
C $DDCA,3 Advance column right
C $DDCD,3 Store new direction
C $DDD0,6 HL = new tile coord
C $DDD6,3 Draw tile
C $DDD9,6 Reset column to right bound
C $DDDF,2 Store direction, draw
C $DDE1,4 Check for right-direction, A = left dir
C $DDE5,2 Bounce at left edge
C $DDE7,6 HL = tile coord
C $DDED,3 Draw single scene tile to screen and offscreen buffer
C $DDF0,6 Compare column to right bound
C $DDF6,4 Continue left, else wrap
C $DDFA,5 Advance column left, store
c $DDFF Advance water/crack animation phase (bounce counter)
N $DDFF A timing gate for the water animation. It counts down a delay each call and does nothing until the delay runs out; when it does, it steps a phase value that gently sweeps up and down between limits (reversing at each end), which is what drives the water's back-and-forth motion. Returns a flag telling the caller whether this frame is one where the water should actually be redrawn.
C $DDFF,4 A = difficulty/animation speed
C $DE03,1 Return if not slowest speed
C $DE04,3 HL = animation tick counter
C $DE07,2 Tick counter, return unless expired
C $DE09,4 A/B = animation phase byte
C $DE0D,3 C = phase counter (masked)
C $DE10,4 A = phase/4
C $DE14,3 Compute next tick delay, store
C $DE17,4 Check direction bit
C $DE1B,3 Decrement phase, continue unless zero
C $DE1E,4 Flip direction bit
C $DE22,3 Increment phase, test overflow bit
C $DE25,2 Continue if not overflowed
C $DE27,5 Flip direction bit, keep phase
C $DE2C,2 Store and return
C $DE2E,2 Combine phase and direction bits
C $DE30,3 Mask and restore direction bit
C $DE33,3 Store updated phase byte
C $DE36,2 Return (Z set = OK to animate)
c $DE38 Store $C810 as active color-table pointer
C $DE38,1 Save caller HL
C $DE39,3 HL = color-table address (C810h)
C $DE3C,3 Store as active pointer
c $DE41 Store $4810 as active color-table pointer
C $DE41,1 Save caller HL
C $DE42,3 HL = color-table address (4810h)
c $DE47 Ripple water colour area and push characters clear
R $DE47 HL offscreen attribute area address
R $DE47 BC area size (B=rows, C=columns)
N $DE47 Animates a rectangular patch of the colour (attribute) area - the water surface - by cyclically rotating the colour bytes within it, which makes the water appear to ripple or flow. A saved animation-state bit decides the direction, and when it's set the routine hands off to the pixel-based sibling #R$DF11 instead. After shuffling the colours it checks each of the three characters/objects against this patch, and any that are standing in it get nudged out of the way (the water pushes them). Called by the various room water-animation handlers.
C $DE47,2 A=1 (draw-mode flag)
C $DE49,4 Clear bright/flash bits of H
C $DE4D,3 Store draw-mode flag
C $DE50,3 Load saved attribute state
C $DE53,2 Test top bit
C $DE55,3 Skip alt path if clear
C $DE58,3 Else use mirrored routine
C $DE5B,2 Save row/element counters
C $DE5D,2 Save inner counters (loop entry)
C $DE5F,3 Load bytes D,E from two rows
C $DE62,3 H = attribute row low bound
C $DE65,3 Load byte A, store E
C $DE68,6 Rotate bytes down two rows
C $DE6E,6 Rotate bytes down two more rows
C $DE74,6 Rotate bytes down two more rows
C $DE7A,4 Store last byte, advance column, loop 8 columns
C $DE7E,3 Restore counters, decrement row-block count
C $DE81,2 Done after 5 blocks
C $DE83,4 Advance to next attribute third
C $DE87,2 Continue if no wrap
C $DE89,4 Wrap to next attribute row
C $DE8D,2 Continue
C $DE8F,2 Restore saved coords
C $DE91,3 Fold coords into scene-map tile address
C $DE94,4 IX = Ninja struct
C $DE98,3 Check/push Ninja out of area
C $DE9B,4 IX = Yamo struct
C $DE9F,3 Check/push Yamo out of area
C $DEA2,4 IX = Bruce struct, fall into check below
C $DEA6,4 Skip if object not in area
C $DEAA,4 Skip if fall blocked
C $DEAE,7 Advance object's fall frame
C $DEB5,3 Store new fall frame
C $DEB8,3 Return if mid fall-cycle
C $DEBB,3 Step object down one row
C $DEBE,5 Check row against floor line
C $DEC3,1 Return if not yet at floor
C $DEC4,8 Clamp row to floor, clear fall frame
c $DECD Fold coords into scene-map attribute address
R $DECD HL tile coordinates (H=row, L=column)
C $DECD,2 A = column, rotate
C $DECF,2 Continue rotate (x3 total)
C $DED1,3 Fold into attribute row bits
C $DED4,3 Combine and mask
C $DED7,1 Store attribute row
C $DED8,3 Mask column bits
C $DEDB,2 Store column, return
c $DEDD Check if personage/object overlaps given screen area
N $DEDD Tests whether a character's rectangle overlaps a given patch of screen, by comparing their edges, and reports back yes or no. The water-animation code uses this to find which characters are standing in the water so it can push them out.
C $DEDD,5 Return early if object not active
C $DEE2,6 Skip if object not alive
C $DEE8,3 Store size of personage image to image_size variable
C $DEEB,5 Compute object right edge (X+width-1)
C $DEF0,3 No overlap if left of area
C $DEF3,3 Compute area right edge
C $DEF6,5 No overlap if right of object
C $DEFB,3 Compute area bottom edge
C $DEFE,5 No overlap if below object
C $DF03,5 Compute object bottom edge
C $DF08,3 No overlap if above area
C $DF0B,2 Overlap found: return Z
C $DF0D,3 No overlap: clear Z
C $DF10,1 Return
c $DF11 Ripple water pixel area and push characters clear
R $DF11 HL offscreen pixel area address
R $DF11 BC area size (B=rows, C=columns)
N $DF11 The pixel-based twin of #R$DE47: it animates a rectangular patch of water by cyclically rotating the pixel bytes within it (rather than the colour bytes), producing the rippling motion in the opposite direction. As with its sibling, after shuffling the pixels it checks each of the three characters against the patch and nudges any standing in it out of the way. #R$DE47 hands off here when the animation-state bit calls for this direction.
C $DF11,2 Save row/element counters
C $DF13,2 Save inner counters (loop entry)
C $DF15,3 H = attribute row low bound
C $DF18,3 Load bottom byte E
C $DF1B,4 Load byte D, mask to top row
C $DF1F,2 Load top byte A
C $DF21,6 Rotate bytes down two rows
C $DF27,6 Rotate bytes down two more rows
C $DF2D,6 Rotate bytes down two more rows
C $DF33,3 Store last byte, advance column
C $DF36,2 Loop for 8 attribute columns
C $DF38,3 Restore counters, decrement row-block count
C $DF3B,2 Done after 5 blocks
C $DF3D,4 Advance to next attribute third
C $DF41,2 Continue if no wrap
C $DF43,4 Wrap to next attribute row
C $DF47,2 Continue
C $DF49,2 Restore saved coords
C $DF4B,3 Fold coords into scene-map tile address
C $DF4E,4 IX = Ninja struct
C $DF52,3 Check/push Ninja out of area
C $DF55,4 IX = Yamo struct
C $DF59,3 Check/push Yamo out of area
C $DF5C,4 IX = Bruce struct, fall into check below
C $DF60,4 Skip if object not in area
C $DF64,6 Check row + height against floor
C $DF6A,1 Return if below floor line
C $DF6B,7 Advance object's fall frame
C $DF72,3 Store new fall frame
C $DF75,1 Return if mid fall-cycle
C $DF76,4 Step object down one row
c $DF7A Animate water ripple tiles (3 frames)
C $DF83,3 Handle single obstacle/collision step for personage or object
C $DF8D,3 Handle single obstacle/collision step for personage or object
C $DF97,3 Handle single obstacle/collision step for personage or object
c $DF9D Advance one scripted scenery animation by a step
R $DF9D HL address of the obstacle/animation map byte
R $DF9D IX address of the object animation state block
N $DF9D Drives one animated scenery element (like a patch of rippling water) one step forward, using a little script in memory and a state block that remembers where it's up to. Each call it waits out a short delay, then draws the element's next frame from the script and steps its position on; when it reaches the end of the run it either loops or moves to the next scripted state. #R$DF7A calls it once for each of the three water strips.
C $DF9D,3 Return if no obstacle byte
C $DFA0,6 Skip if state busy
C $DFA6,4 Countdown state timer, return
C $DFAA,5 Check sub-state < 4
C $DFAF,1 Return if not yet
C $DFB0,4 Clear sub-state
C $DFB4,6 Check direction flag
C $DFBA,5 Load next map byte into (IX+3)
C $DFBF,5 A = state 4, continue
C $DFC4,6 Compare, else A = state 5
C $DFCA,2 Save coord, D = map byte
C $DFCC,4 E = stored byte, swap to HL
C $DFD0,3 Draw tile
C $DFD3,4 Restore coord, advance stored index
C $DFD7,3 HL = length byte
C $DFDA,5 Compare to stored index
C $DFDF,2 Load next state byte
C $DFE1,3 Store new state
C $DFE4,4 Clear direction flag
C $DFE8,1 Return
C $DFE9,4 Rewind, A = state 4
C $DFED,3 Store state
C $DFF0,4 DE = map/stored bytes
C $DFF4,4 Draw tile, return
b $DFF8
b $E000 Buffer for offline drawing
N $E000 The offline screen buffer mirrors the ZX Spectrum video memory layout starting at $E000 (pixels $E000-F7FF, attributes $F800-FAFF).
N $E000 The top 2 rows are the status bar (score, lives). The scene tiles fill the remaining 22 rows.
@ $E000 label=offline_screen
B $E000,6144,32
B $F800,768,32
b $FE00 Game working variables (RAM)
N $FE00 Scratch and state variables used throughout the game. Widths (byte vs word) are inferred from how the code loads/stores each address.
B $FE00,2
@ $FE02 label=frame_ready_flag
B $FE02,1 Frame-ready flag: set by the interrupt, cleared once the frame is processed
@ $FE03 label=current_room
B $FE03,1 Current room number being played
@ $FE04 label=active_player
B $FE04,1 Active player number (1 or 2)
@ $FE05 label=frame_counter
W $FE05,2 Free-running frame counter (high byte $FE06 reused as an AI aggression timer)
B $FE07,1 Two-player game flag
@ $FE08 label=player2_active
B $FE08,1 Player 2 present/active flag
@ $FE09 label=player1_input_raw
B $FE09,1 Player 1 raw input reading
@ $FE0A label=player2_input_raw
B $FE0A,1 Player 2 raw input reading
@ $FE0B label=redraw_flag
B $FE0B,1 Screen-redraw-needed flag
@ $FE0C label=pickup_done_flag
B $FE0C,1 Weapon-pickup-complete flag
@ $FE0D label=restart_flag
B $FE0D,1 Level-restart flag
@ $FE0E label=room_per_player
B $FE0E,2 Current room number, one byte per player
@ $FE10 label=decoded_input
B $FE10,1 Decoded input direction/key code
@ $FE11 label=player_will
W $FE11,2 Player pending action ("will"), read by the AI
B $FE13,1 Previous decoded input, player 1
B $FE14,1 Previous decoded input, player 2
@ $FE15 label=input_changed_flags
B $FE15,1 Input-changed flags
B $FE16,1
@ $FE17 label=crumble_coord
W $FE17,2 Wall-crumble current tile coordinate
@ $FE19 label=crumble_step
B $FE19,1 Wall-crumble column step
@ $FE1A label=water_draw_mode
B $FE1A,1 Water-animation draw-mode flag
@ $FE1B label=player_direction
B $FE1B,2 Final player move direction, one byte per player
B $FE1D,3
@ $FE20 label=player_room_state
B $FE20,32 Active player's room animation/trap state (per-object trigger counters, water-cycle and crumble timers); swapped with $FE40 on player change, zeroed at level start
@ $FE40 label=player2_room_state
B $FE40,32 Other player's saved copy of the room animation/trap state
@ $FE60 label=wall_crack_records
B $FE60,18 Wall-crack records: 6 slots of 3 bytes (hit counter + tile coordinate)
B $FE72,15 Water-ripple animation state: 3 strips of 5 bytes (see #R$DF7A/#R$DF9D)
B $FE81,18 Saved copy of the active personage's description block
B $FE93,2
@ $FE95 label=wall_hit_counter
B $FE95,1 Wall-hit counter (drives cracking and collapse)
@ $FE96 label=draw_y_offset
B $FE96,1 Pixel-precise Y offset for the sprite being drawn
@ $FE97 label=draw_colour
B $FE97,1 Colour attribute for the sprite being drawn
@ $FE98 label=will_pers_index
B $FE98,1 Personage index passed to the will-table drawing routine
@ $FE99 label=anim_gate_counter
B $FE99,1 Animation-gate frame counter (paces bubble/object animation)
@ $FE9A label=sound_enabled
B $FE9A,1 Sound-enabled flag
@ $FE9B label=water_anim_tick
B $FE9B,1 Water-animation delay countdown
@ $FE9C label=water_anim_phase
B $FE9C,1 Water-animation phase byte (value + direction bit)
B $FE9D,3
@ $FEA0 label=sprite_dest_ptr
W $FEA0,2 Destination pointer into the offline buffer for the current sprite
@ $FEA2 label=sprite_data_ptr
W $FEA2,2 Pointer to the current sprite's image data
@ $FEA4 label=image_size
W $FEA4,2 Current image size: width in $FEA4, height in $FEA5 (8-pixel cells)
@ $FEA6 label=scene_src_ptr
W $FEA6,2 Source pointer while drawing the room scene
@ $FEA8 label=tile_dest_ptr
W $FEA8,2 Destination tile pointer for scene/tile drawing
@ $FEAA label=score_compare
W $FEAA,2 Score value saved for the high-score comparison
@ $FEAC label=image_desc_ptr
W $FEAC,2 Pointer to the current image descriptor
@ $FEAE label=will_coord_temp
W $FEAE,2 Saved coordinate while scanning the will table
@ $FEB0 label=will_default_entry
W $FEB0,2 Saved "default" will-table entry pointer
B $FEB2,4 Header line: player number and label
@ $FEB6 label=score_display
B $FEB6,12 Score shown in the header line (first bytes reread as the life-bonus check value)
@ $FEC2 label=hiscore_digits
B $FEC2,14 High-score digits shown in the header
@ $FED0 label=player_lives
W $FED0,2 Player lives count, 2-digit BCD, shown in the header (decremented on death by #R$CA46, topped up by #R$CA1A)
B $FED2,32 Header line tail / message text area
@ $FEF2 label=player1_score
B $FEF2,6 Player 1 score digits
@ $FEF8 label=player2_score
B $FEF8,6 Player 2 score digits
B $FEFE,2
b $FF00
