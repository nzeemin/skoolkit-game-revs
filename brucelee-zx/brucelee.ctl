b $4000 Screen
B $4000,6144,32
B $5800,768,32
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
c $9300
N $9306 Play die sound as Bruce is defeated
@ $9306 label=play_bruce_die_sound
N $930C Play sound after taking a key by Bruce
@ $930C label=play_key_collecting
b $9312
c $95e2
c $960A
b $9649
b $9800 Background tiles 8*8, tile attributes at #R$6300
@ $9800 label=bktiles
c $C000
b $A000
@ $A000 label=right_direction_images
@ $A800 label=left_direction_images
@ $B000 label=right_direction_masks
@ $B800 label=left_direction_masks
@ $C000 label=begin
c $C003
c $C02D
c $C085
c $C0D7
b $C0E5
c $C121
b $C16D
c $C16E Prepare level and draw it to playscreen
@ $C16E label=prepare_level
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
c $C29C Updates Video-RAM from offline drawing buffer
@ $C29C label=update_screen
c $C2B2 Fill BC bytes at HL address by zeros
@ $C2B2 label=bzero_at_hl
c $C2B8
c $C2C0 Draws an 8*8 pixels element of scene
@ $C2C0 label=draw_scene_element
c $C2EC Updates area of personage from offscreen to screen
@ $C2EC label=show_personage_area
c $C366 Redraw background of personage area to offscreen
@ $C366 label=update_personage_background
c $C3CB Draws personage to offscreen
@ $C3CB label=draw_personage
C $C3D0,1 (IX+2) Personage image index and "alive status"
C $C3D1,1 Is personage alive?
C $C3D2,1 Return, if not yet.
C $C3D3,1 Store personage image index to C
C $C3D5,1 (IX+3) Direction of the personage
C $C3D7,2 right direction
C $C3D9,2 offset for images with left direction
N $C3DB Right direction images address if a000h
N $C3DB Left direction images address is a800h
@ $C3DB label=right_direction
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
@ $C420 label=personage_draw_loop
C $C436,1 go to next row of 8*8 pixels block to draw following 8 lines of image
c $C44D
@ $C44D label=draw_personage_part
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
c $C530
c $C6C3
c $C6D2
c $C6E4
c $C6EC
c $C6FB
c $C706
@ $C706 label=fill_smth
c $C714 looks like new game after pressing ENTER in main game menu
@ $C714 label=start_game
N $C71F Reset score of both players
@ $C71F label=reset_score
@ $C790 label=next_player
@ $C7A4 label=play_loop
@ $C7BD label=screen_updated
@ $C7D2 label=no_personages_update
c $C8C6
@ $C8C6 label=clear_offline_screen
c $C8E1
@ $C8E1 label=init_1
c $C908
c $C924 Draw message
@ $C924 label=draw_message
R $C924 DE screen coordinates
R $C924 HL message address
R $C924 B message length
c $C933 Draws a message and set screen dirty flag
@ $C933 label=draw_message_and_invalidate
c $C93C Fills offline color attributes of playscreen header
@ $C93C label=fill_offscreen_header_color
c $C960 Draws message at header of game screen
@ $C960 label=draw_playscreen_header_message
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
R $C99B HL address of value to add to score
N $C99B Also, updates hiscore, if current score is greater.
@ $C9AA label=add_score_for_first_player
@ $C9BE label=add_score_loop
@ $C9CD label=add_score_no_carry
@ $C9D8 label=check_hiscore_loop
N $C9E4 Copy current score value to the high score
@ $C9E4 label=new_hiscore
@ $C9EA label=not_hiscore
N $CA14 Score value is good enough to increase lifes number
@ $CA14 label=great_score
@ $CA17 label=no_lifes_increase
c $CA1A Increase player lifes
@ $CA1A label=increase_player_lifes
c $CA37 Handle object impact
R $CA37 DE Object address in playroom
R $CA37 HL object handlers table
@ $CA37 label=handle_object_impact
c $CA46
c $CAB6
c $CAC0
c $CACE
c $CAE2
c $CAF7
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
W $CB32,4,4 0
W $CB36,4,4 1
W $CB3A,4,4 2
W $CB3E,4,4 3
W $CB42,4,4 4
W $CB46,4,4 5
W $CB4A,4,4 6
W $CB4E,4,4 7
W $CB52,4,4 8
W $CB56,4,4 9
W $CB5A,4,4 10
W $CB5E,4,4 11
W $CB62,4,4 12
W $CB66,4,4 13
W $CB6A,4,4 14
W $CB6E,4,4 15
W $CB72,4,4 16
W $CB76,4,4 17
W $CB7A,4,4 18
W $CB7E,4,4 19
W $CB82,4,4 20
W $CB86,4,4 21
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
W $CBD4,4,4 0
W $CBD8,4,4 1
W $CBDC,4,4 2
W $CBE0,4,4 3
W $CBE4,4,4 4
W $CBE8,4,4 5
W $CBEC,4,4 6
W $CBF0,4,4 7
W $CBF4,4,4 8
W $CBF8,4,4 9
W $CBFC,4,4 10
W $CC00,4,4 11
W $CC04,4,4 12
W $CC08,4,4 13
W $CC0C,4,4 14
W $CC10,4,4 15 Empty action
W $CC14,4,4 16
W $CC18,4,4 17
W $CC1C,4,4 18
W $CC20,4,4 19
W $CC24,4,4 20
W $CC28,4,4 21
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
W $CCBB,4,4 0
W $CCBF,4,4 1
W $CCC3,4,4 2
W $CCC7,4,4 3
W $CCCB,4,4 4
W $CCCF,4,4 5
W $CCD3,4,4 6
W $CCD7,4,4 7
W $CCDB,4,4 8
W $CCDF,4,4 9
W $CCE3,4,4 10
W $CCE7,4,4 11
W $CCEB,4,4 12
W $CCEF,4,4 13
W $CCF3,4,4 14
W $CCF7,4,4 15 Empty action
W $CCFB,4,4 16
W $CCFF,4,4 17
W $CD03,4,4 18
W $CD07,4,4 19
W $CD0B,4,4 20
W $CD0F,4,4 21
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
c $CD9B Personage action handler 0
c $CE48 Personage action handler 1
c $CF04 Personage action handler 2
c $CF18 Personage action handler 3
c $CF2D Personage action handler 4
c $CF59 Personage action handler 5
c $CFB3 Personage action handler 6
c $CFBD Personage action handler 7
c $CFCE Personage action handler 8
c $CFF8 Personage action handler 9
c $D007
b $D018
c $D023 Personage action handler 10
c $D032 Personage action handler 11
c $D03F Personage action handler 12
c $D063 Personage action handler 13
c $D10D Personage action handler 14
c $D112 Personage action handler 16
c $D15D Personage action handler 17
c $D16F Personage action handler 18
c $D198 Personage action handler 19
c $D1A2 Personage action handler 20
c $D1D2 Personage action handler 21
c $D1EB
c $D24E Single gameplay step of personage
@ $D24E label=personage_play_step
C $D254,1 Personage defeated and dying
C $D25C,1 Personage started to dying
N $D264 Personage already dying for a while
@ $D264 label=already_dying
N $D26A When personage defeated he is flashing for a while
@ $D26A label=visible_flash_stage
@ $D26D label=invisible_flash_stage
@ $D271 label=defeate_sound_not_muted
C $D279,4 When sound is not muted, flash only from 4bh to 64h steps (shorter flashing interval).
N $D285 Step for healthy and alive personage
@ $D285 label=normal_play_step
C $D288,1 Personage is delayed and does nothing
C $D289,3 Reload delay cycle for personage next step
C $D299,3 Store personage action to personage description
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
C $D2BF,3 Store image index back
C $D2C2,1 Restore original personage coordinates
C $D2C3,3 Get new X coordinate of personage
C $D2C6,1 Compare it with original coordinate
C $D2C9,1 Need to check that personage is not out off screen in bottom direction
N $D2CA Personage moved to up direction
@ $D2CA label=personage_moved_up
C $D2CE,2 Return personage back to bottom of the screen
@ $D2D0 label=not_out_to_bottom
c $D2EA
c $D2EB Return personage from the dead
@ $D2EB label=revive_personage
@ $D306 label=do_revive
c $D332
c $D353
c $D371
c $D375
c $D405
c $D43B
c $D447
c $D456
c $D4A3 Return in HL address of personage's cell in playroom
@ $D4A3 label=get_personage_room_addr
R $D4A3 IX address of personage description
N $D4A3 Address is Y * 20h + X + current_room_playing_data
c $D4BE Store size of personage image to image_size variable
@ $D4BE label=get_personage_image_size
C $D4C0,3 Get personage image index
C $D4C3,1 Exclude "not alive" zero value
C $D4C5,1 4 bytes per image reference
C $D4C6,2 Add offset of images references relative to personage description
C $D4CE,1 HL contains image reference
C $D4D1,1 DE contains image description address
C $D4D6,1 Get image width
C $D4D8,1 Get image height
c $D4E0 Compares IX and HL for equality
@ $D4E0 label=compare_IX_HL
c $D4EC Look up objects at personage location
@ $D4EC label=review_personage_location
C $D4F6,1 Walk over width and height of the image
N $D4F8 Review personage location in playroom
N $D4F8 for various objects presence
@ $D4F8 label=personage_location_review_loop
C $D4FD,2 Object with 18h - ffh code
C $D503,2 Object with 10h - 16h code
@ $D505 label=safe_object
C $D515,1 HL contains address of next row of room data behind personage
@ $D51A label=personage_on_17_object
N $D524 Dangerous object detected at personage location
@ $D524 label=danger_object
N $D539 Key, lamp, etc.
N $D539 This object should be taken by Bruce
@ $D539 label=collectable_object
@ $D57F label=skip_object
b $D586
B $D586,1,1
c $D587 check collision between personage and an playroom object
@ $D587 label=check_collision
C $D588,1 Get playroom object code
C $D58C,1 Multiply it on 8
C $D594,3 Get personage Y offset
c $D5BB
c $D60E
c $D626
c $D675 Returns desired action for given personage
R $D675 IX address of personage description
@ $D675 label=get_personage_action_will
b $D7AC
N $D7FC Table of handlers of object with 17h
N $D7FC code for each room number
@ $D7FC label=table_of_17_object_handlers
c $D824
@ $D824 label=empty_17_object_handler
c $D825 Draw
@ $D825 label=draw
c $D845
c $D856
c $D888
c $D898
c $D8D4
c $D902
c $D928
c $D938
c $D948
c $D958
c $D97D
c $D98D
c $D9CD
c $D9D7
c $D9E7
c $DA46
b $DA51
t $DA5D
b $DA61
c $DA63 Tricky handler of object with 17h code for some rooms
@ $DA63 label=handler_of_17_object
c $DA94
c $DAAD
c $DAB2
c $DAC4
c $DACC
c $DADE
b $DAF9
c $DAFF
c $DB23
b $DBA4
c $DBB0
c $DBEC
c $DBF2
c $DC1D
c $DC27
c $DC78
b $DCBE
c $DCEE
b $DD07
c $DD0D
c $DD67
c $DDA8
c $DDFF
c $DE38
c $DE41
c $DE47
c $DECD
c $DEDD
c $DF11
c $DF7A
c $DF9D
b $DFF8
b $E000 Buffer for offline drawing
N $E000 The offline screen buffer mirrors the ZX Spectrum video memory layout starting at $E000 (pixels $E000-F7FF, attributes $F800-FAFF).
N $E000 The top 2 rows are the status bar (score, lives). The scene tiles fill the remaining 22 rows.
@ $E000 label=offline_screen
B $E000,6144,32
B $F800,768,32
