@ $5B00 start
@ $5B00 org
b $5B00
T $5CEB
b $5CF0
@ $5D00 label=scr_row_addr_tbl
b $5D00 Table of screen row addresses
W $5D00,,16
b $5E80
b $6000
@ $6000 label=temp_sp
W $6000,2,2 Temporary place for SP
@ $6002 label=random_seed
W $6002,2,2 16-bit LCG seed, advanced by next_random
W $600A,2,2 Column buffer address
W $6015,2,2 Unknown word
@ $6017 label=game_mode
B $6017,1,1 Game mode (4=in play), gates read_input
@ $601C label=input_x
B $601C,1,1 Signed input, X axis (-1/0/+1)
@ $601D label=input_y
B $601D,1,1 Signed input, Y axis (-1/0/+1)
@ $601E label=input_fire
B $601E,1,1 Signed input, fire button (-1/0/+1)
@ $6020 label=input_latch
B $6020,1,1 Debounce latch: input_x was active last frame
@ $6030 label=scroll_pos
W $6030,2,2 Vertical scroll position
@ $6032 label=disp_height
B $6032,1,1 Display height (36 - tower_height)
B $6033,1,1 Previous tower_height, saved by rotate_tower
W $6034,2,2 Previous scroll_pos, saved by step_scroll
B $6036,1,1 Camera row, derived from $6059
B $6037,1,1 Unknown byte
B $6038,1,1 Flag?? $00 $FE $FF
B $6039,1,1 Level number 0..7
@ $603F label=running_flag
B $603F,1,1 Running flag, gates restore_col_state re-init path
@ $6040 label=lives_p1
B $6040,1,1 Lives, player 1; also doubles as active-player index
@ $6041 label=lives_p2
B $6041,1,1 Lives, player 2
@ $6053 label=play_timer
W $6053,2,2 Level countdown timer (BCD)
B $6055,1,1 Level timer prescaler (0..4), ticks play_timer every 5th frame
@ $605B label=object_table
W $605B,2,2 Pointer to object_table
@ $605F label=actor_obj
W $605F,2,2 Pointer to the actor being updated (update_actor_pos)
@ $60A4 label=player_col
B $60A4,1,1 Player's current column
@ $60B9 label=tower_height
B $60B9,1,1 Tower rotation position
W $60BA,2,2 Player's position
@ $60BF label=pstate_phase
B $60BF,1,1 Player state-machine phase/height window
@ $60C0 label=player_state
B $60C0,1,1 Player state-machine state
@ $60C3 label=death_flag
B $60C3,1,1 Player died this frame
@ $60C6 label=print_cursor
W $60C6,2,2 Text print cursor (row/column)
@ $60C8 label=cur_color
B $60C8,1,1 Current text colour/attribute
@ $60CB label=col_flags
B $60CB,8,1 Per-column visited/present flags (8 columns)
@ $60D7 label=ctrl_flag
B $60D7,1,1 Control-key toggle flag
@ $60D8 label=demo_pause
B $60D8,1,1 Demo/pause mode flag ($FF=active)
@ $60D9 label=game_state
B $60D9,1,1 Game state (3=transition, 4=finished, else normal play)
b $6200
T $629F
b $62D6
@ $6380 label=col_y_table
B $6380,128,16
b $6A00 Mask data for level/tower 0
b $6C00 Mask data for level/tower 1
b $6E00 Mask data for level/tower 2
b $7000 Mask data for level/tower 3
b $7200 Mask data for level/tower 4
b $7400 Mask data for level/tower 5
b $7600 Mask data for level/tower 6
b $7800 Mask data for level/tower 7
b $7A00
b $7A18 Data for level/tower 0
@ $8000 label=game_entry
c $8000 Game entry
N $8000 Cold-start, reached from the resident loader.
N $8000 The loader JP's here once the tape image is fully in RAM.
N $8000 In:  nothing meaningful (IFF1=0, IM 1, SP still loader's).
N $8000 Out: never returns -- falls through into the init chain and then the main game loop.
N $8000 Side effects: installs private stack, blacks the border, runs three init subroutines, seeds game-state RAM.
C $8000,3 alignment trampoline -- skip 3 pad bytes (8003-8005)
@ $8004 label=freeze_ctr
@ $8005 label=pad_var_8005
@ $8006 label=entry_setup
C $8006,3 install game's private stack just under screen RAM
C $8009,1 A = 0
C $800A,2 ULA port FE: border=black(0), MIC/beeper off
C $800C,3 Setup IM2
C $800F,3 init #2 = clear screen + game RAM (jp_clear_screen trampoline)
C $8012,3 init #3 = paint playfield attributes (jp_setup_attrs trampoline)
C $8015,2 A = 1
C $8017,3 first persistent-state write: running_flag = 1
@ $801A label=new_game
c $801A New game
N $801A Set up a fresh game/level and run it.
N $801A Falls in from game_entry's init chain.
N $801A Seeds state vars, builds the level, draws the screen, then enters main_loop.
N $801A On death/level-end it loops back to level_retry or game-over handling.
C $801A,2 A=$80 -> $6056 (start flag/counter)
C $8020,3 set Control-key toggle flag
C $8026,2 4 attempts/lives -> #R$6017
C $8028,3 set Game mode
@ $802B label=level_retry
c $802B Level entry
C $802C,3 set Demo/pause mode flag
C $802F,3 Title menu
C $8032,3 Init col state
C $8035,3 proc_table slot: build tower / level layout
C $803A,3 set Lives
C $803D,3 Restore col state
C $8045,2 carry clear -> rebuild (retry)
C $8050,3 Show level intro
C $8054,3 set Player died this frame
C $8058,3 set Level timer prescaler
C $805E,3 Setup level
C $8061,3 Stop sound
@ $8064 label=main_loop
c $8064 Main loop
N $8064 The in-play frame loop.
N $8064 Each pass runs main_tick (one frame) then checks end conditions: death_flag (#R$60C3) set      -> life-loss handler ($8084) game_state (#R$60D9) == 2     -> level-complete ($80B2) play_timer (#R$6053) == 0     -> time-up ($8081) Otherwise CALL #R$8115 (status update) and loop.
C $8064,3 run one frame of the game
C $8067,3 player died this frame?
C $806B,2 yes -> life-loss handler
C $806D,3 level-complete state?
C $8072,2 yes -> level-complete handler
C $8074,3 play_timer reached 0?
C $8079,2 yes -> time-up
C $807B,3 Poll controls
C $807E,3 loop
C $8081,3 Draw timeup screen
@ $8084 label=on_death
C $8086,3 set Level timer prescaler
C $8089,3 get Control-key toggle flag
C $8092,3 get Lives
C $80A3,3 Pack col state
C $80A9,3 Clear col mask
C $80AC,3 Draw info screen a
@ $80B2 label=on_level_done
C $80B4,3 set Level timer prescaler
C $80B7,3 get Tower rotation position
C $80BF,3 get Vertical scroll position
C $80C3,3 Screen time bonus
C $80CB,3 set Game state
C $80CE,3 Setup level
C $80D2,3 set Vertical scroll position
C $80DA,3 set Tower rotation position
C $80DF,3 set Player state-machine state
C $80E4,3 set Player state-machine phase/height window
C $80EB,3 Main tick
C $80EE,3 Poll controls
C $80F1,3 get Game state
C $80F9,3 set Game state
C $80FC,3 Advance col counter
C $8103,3 Clear col mask
C $8106,3 Draw info screen b
C $810C,3 Pack col state
@ $8115 label=poll_controls
c $8115 Poll controls
N $8115 Per-frame keyboard handling (called from main_loop).
N $8115 Skipped while input is frozen (freeze_ctr).
N $8115 - restart key (via $A70F): NC -> jump to level_retry
N $8115 - several control keys toggle ctrl_flag (#R$60D7) / pad_var_8005
N $8115 - PAUSE/DEMO: key $21 enters demo_pause any joystick X exits
N $8115 - menu select: tests a column of 8 keys the index of the one pressed (0..7) -> pad_var_8005, then restarts setup at $8032.
N $8115 Uses test_key ($A706) for t
C $8115,3 A = freeze_ctr
C $8119,1 frozen -> do nothing this frame
C $811D,3 restart condition -> rebuild level
C $8137,3 set ctrl_flag (#R$60D7) = 1
C $8142,3 set Control-key toggle flag
C $8148,3 A = demo_pause
C $814E,3 get Level timer prescaler
C $815B,2 enter demo/pause mode (demo_pause = $FF)
C $815D,3 set Demo/pause mode flag
C $8160,3 set Level timer prescaler
C $8165,3 Proc table
C $8168,3 get Signed input
C $816C,2 no X movement -> stay in demo
C $816F,3 movement -> exit demo
C $8172,3 get Control-key toggle flag
C $817B,3 set Level timer prescaler
C $817E,3 get Control-key toggle flag
C $8189,2 --- menu key-column scan: B = option index ---
C $8195,3 test each option key
C $81CA,1 none pressed -> return
C $81CB,1 a key matched: B = selected option
C $81CC,3 store selection -> pad_var_8005
C $81D1,3 set Demo/pause mode flag
C $81D4,3 restart game setup with the new selection
@ $81D7 label=setup_level
c $81D7 Setup level
N $81D7 (Re)build the current level's working state.
N $81D7 Zeroes the work_buffers block (#R$F000.., $0FFF bytes via LDIR), loads the level's column data (load_level_col), resets the tower position (init_tower_pos), re-inits flags (init_b5cf) and the renderers (#R$8FB7, #R$96D4).
N $81D7 Clobbers: most.
C $81D7,3 Clear work_buffers (#R$F000) for tower map
C $81E4,3 Load level column data into #R$F000
C $81E7,3 Init tower pos
C $81ED,3 Clear actor states
C $81F3,2 Initialise 4 object slots to empty
C $81F8,2 Fill slots with $FF (empty)
C $81FD,3 Check if game_state == 3 (level transition)
C $8202,2 Skip attribute painting if transitioning
C $8204,3 Paint tower colour attributes
C $8209,3 Set $60C9 = 1 (enable column visibility update)
C $820C,2 Compute disp_height = 36 - tower_height
C $8214,3 set Display height
C $8217,3 Mark visible tower columns for rendering
C $821A,3 Init attract actors
C $8222,3 Set game_state = 0 (normal play)
C $822A,2 Set player starting column = 1
C $822C,3 set Player's current column
C $822F,3 get Control-key toggle flag
C $8235,2 Set #R$6055 = $FF during level transition
C $8237,3 Store $FF or $00 into timer prescaler #R$6055
C $823A,2 Freeze input for 2 frames
@ $8240 label=main_tick
c $8240 Main tick
N $8240 One frame of the game.
N $8240 Called from main_loop.
N $8240 Order: read input (unless frozen) -> run game-state machine (player move, tower rotation, enemies) -> redraw widgets -> HALT to sync to the 50Hz frame interrupt.
N $8240 State: game_state (#R$60D9): 3=level transition, 4=finished,
N $8240 else = normal play.
N $8240 demo_pause (#R$60D8) skips logic.
N $8240 freeze_ctr ($8004) freezes input for N frames.
N $8240 Clobbers: most regs.
N $8240 Returns once per frame.
C $8240,3 HL -> freeze_ctr (in code padding at $8004)
C $8243,1 A = freeze counter
C $8245,2 0 = not frozen -> read input normally
C $8247,1 frozen: count down one frame
C $8249,3 zero the three input vars while frozen
C $824C,3 set Signed input
C $824F,3 set Signed input
C $8254,3 Proc table
C $8257,3 A = demo_pause flag
C $825B,2 set -> skip all game logic (attract/demo), just redraw
C $825D,3 A = game_state
C $8260,2 state 3 = level transition?
C $8264,3 Player tick
C $8267,3 get Game state
C $826C,1 state 4 = finished -> done this frame
C $8270,3 --- normal play: update one frame ---
C $8273,3 Update actor pos
C $8276,3 Player tick
C $8279,3 A = player column before move
C $827D,3 move player (proc_table slot)
C $8282,3 compare new vs old player column
C $8288,3 Play sound
C $828B,3 Update enemies
C $828E,3 Check collision
C $8291,2 --- redraw HUD: A = $24 (36 rows) ---
C $8296,1 subtract tower_height (#R$60B9)
C $8299,3 store display height (#R$6032)
C $829C,3 draw widgets (proc_table slots)
C $82A9,3 Draw player
C $82AC,1 HALT: wait for the 50Hz frame IRQ (Z80
C $82AD,3 Sound tick
C $82B6,3 Draw actors sorted
C $82C9,3 get Game state
C $82D0,3 Tally score to
@ $82DA label=tally_score_to
c $82DA Tally score to
N $82DA Count $60BC up toward #R$60BA, awarding $10 (BCD) points per step via add_bcd_score, until the two 16-bit values meet.
N $82DA Used to animate an end-of-section bonus tally.
N $82DA Clobbers: A,DE,HL.
@ $8301 label=col_state_words
s $8301
@ $8305 label=init_col_state
c $8305 Init col state
N $8305 Seed BOTH players' saved column-mask words.
N $8305 HL = (pad_var_8005) [low=0 at level start], then H forced to $FF (all 8 columns present) the same $FF00|sel is written to the P1 (#R$8301) and P2 ($8303) slots.
N $8305 Called once per level build.
N $8305 In: pad_var_8005.
N $8305 Out: (#R$8301),($8303).
N $8305 Clobbers: A,HL.
@ $8311 label=restore_col_state
c $8311 Restore col state
N $8311 Expand a player's saved column bitmask into the 8-byte col_flags[] array (#R$60CB) and mirror its counter into #R$6039.
N $8311 lives_p1 (#R$6040) selects the slot (0=P1 word #R$8301, else P2 word $8303) -- here #R$6040 doubles as an ACTIVE-PLAYER INDEX, not a life count.
N $8311 running_flag gates an alternate (re)init path.
N $8311 Unpacks via RR through col_flags[] returns CY=1 on success.
N $8311 Out: col_flags[0..7], #R$6039, CY.
N $8311 Clobbers: A,B,C,H
C $832C,3 get Running flag
C $8348,3 set Level number 0
@ $8360 label=pack_col_state
c $8360 Pack col state
N $8360 Inverse of restore_col_state.
N $8360 Writes the live counter (#R$6039) into the selected player's low byte, then packs the 8 col_flags[] LSBs (#R$60CB..$60D2) back into the high mask byte.
N $8360 lives_p1 selects the P1/P2 slot.
N $8360 Clobbers: A,B,C,HL.
C $8363,3 get Lives
C $836B,3 get Level number 0
@ $8382 label=clear_col_mask
c $8382 Clear col mask
N $8382 Zero the selected player's column mask byte (high byte of #R$8301/$8303).
N $8382 lives_p1 selects the slot.
C $8385,3 get Lives
@ $8390 label=advance_col_counter
c $8390 Advance col counter
N $8390 Mark current column done: clear col_flags[#R$6039], then bump the selected player's saved counter (low byte) and mirror it back to #R$6039.
C $839F,3 get Lives
C $83A9,3 set Level number 0
@ $83AD label=setup_im2
c $83AD Setup IM2
N $83AD Install the Z80 mode-2 interrupt vector.
N $83AD Builds a 257-byte page of identical bytes at $BB00..#R$BC00 so that, whatever the data-bus byte is at IRQ time, the Z80 reads the 16-bit vector #R$BABA from table[$FF]/table[$100].
N $83AD At #R$BABA it plants 'JP #R$83CA' -- the actual interrupt service routine.
N $83AD In:  nothing.
N $83AD Out: IM 2 active, IFF1=1 (interrupts enabled).
N $83AD Clobbers: A, B, HL, I.
N $83AD The porter must emulate this
C $83AD,1 no IRQs while we build the vector table
C $83AE,3 HL -> vector-table page base $BB00
C $83B1,1 A = $BB = high byte of the table page
C $83B2,2 I = $BB: IM2 reads vectors from page I (Z80-only)
C $83B4,1 A = $BA = the byte we flood the table with
C $83B5,2 B = 0 -> DJNZ loops 256 times (Z80 DJNZ: dec B, jump nz)
C $83B7,1 table[i] = $BA
C $83B8,1 next table slot
C $83B9,2 fill all 256 bytes of $BB00..$BBFF
C $83BB,1 +1 byte at #R$BC00 = $BA: covers the table[$100] off-by-one
C $83BC,1 H = $BA
C $83BD,1 L = $BA  -> HL = #R$BABA (the vector the IRQ will fetch)
C $83BE,2 plant C3 = JP opcode at #R$BABA
C $83C1,2 low byte of JP target -> $CA
C $83C4,2 high byte -> $83, so vector = 'JP #R$83CA' = irq_handler
C $83C6,2 switch CPU to interrupt mode 2 (Z80-only)
C $83C8,1 interrupts on
@ $83C9 label=im2_noop_ret
c $83C9 IM2 noop return
C $83C9,1 return to game_entry
@ $83CA label=irq_handler
c $83CA IRQ handler
N $83CA IM 2 interrupt service routine (50 Hz vblank).
N $83CA Reached via the planted vector at #R$BABA -> JP here.
N $83CA It is a deliberate NEAR-NO-OP: 'CALL #R$83C9' targets the bare RET at the end of setup_im2, so the call does nothing.
N $83CA The point is to REPLACE the 48K ROM's own interrupt routine (which scans the keyboard and bumps the FRAMES sysvar) with a handler that has no side effects, while still letting interrupts fire.
N $83CA Verified: no code anywhere
C $83CA,3 CALL #R$83C9 = the RET in setup_im2: a no-op (neutralized ISR)
C $83CD,1 re-enable interrupts
C $83CE,2 RETI: return from maskable interrupt (Z80-only
@ $83D0 label=init_tower_pos
c $83D0 Init tower pos
N $83D0 Reset the tower/scroll position for a new level: tower_height=$04, #R$60BA/$60BC (current & target column)=8,
N $83D0 scroll_pos = 8-$28, and clear the high bytes $60BB/$60BD.
N $83D0 Clobbers: A.
C $83D2,3 set Tower rotation position
C $83DF,3 set Vertical scroll position
C $83F2,3 set Unknown byte
C $83F5,3 set Player state-machine phase/height window
C $83F8,3 set Player died this frame
C $83FB,3 set Debounce latch
C $8403,3 set Player state-machine state
@ $8411 label=rotate_tower
c $8411 Rotate tower
N $8411 Rotate the tower by signed B: tower_height = (tower_height + B) AND $7F (128-column wrap), saving the old value in #R$6033.
N $8411 Tests the new position for a wall/collision (#R$9330) on collision (NC) it reverts tower_height.
N $8411 In: B=delta.
N $8411 Out: CY=moved.
N $8411 Clobbers: A,B,HL.
C $8412,3 get Tower rotation position
C $8415,3 set Previous tower_height
C $841B,3 set Tower rotation position
C $8421,3 Check rotate collision
C $8426,3 get Previous tower_height
C $8429,3 set Tower rotation position
@ $8430 label=step_scroll
c $8430 Step scroll
N $8430 Advance the column/scroll position #R$60BA by signed A (sign-extended via B), folding H into the 4-quadrant range (AND $03) saves the previous position in #R$6034.
N $8430 Clobbers: A,B,HL.
C $8433,3 set Previous scroll_pos
C $844A,3 get Tower rotation position
C $844D,3 Check rotate collision
C $8452,3 get Previous scroll_pos
@ $8460 label=rotate_if_idle
c $8460 Rotate if idle
N $8460 If #R$957A returns a pending step (CY) and there is no vertical input (input_y==0), rotate the tower by it (tail-calls rotate_tower).
N $8460 Clobbers: A,B.
C $8465,3 get Signed input
@ $846E label=player_state_table
b $846E
@ $8482 label=player_tick
c $8482 Player tick
N $8482 Per-frame player state machine, run every frame from main_tick (both in normal play AND on the game_state==3 level-transition path TASK.md called this 'the level-transition path' -- it is really the general player update, the transition is just one caller).
N $8482 Preamble debounces directional input: input_latch (#R$6020) records whether input_x is active so a press fires once a held input is consumed (input_x cleared).
N $8482 Tail reads player_state and dispatches through a 2-byte JP-address table at #R$846E (index = state*2) to the pstate_N handler below.
C $8489,3 get Signed input
C $8492,3 get Signed input
C $849C,3 set Signed input (debounce: force input_x=0 this frame)
C $849F,3 get Player state-machine state
C $84A2,7 index player_state*2 into jump table #R$846E and dispatch (JP (HL))
@ $84AF label=pstate_reset
c $84AF Pstate reset
N $84AF Common "return to normal/play" exit: player_state=0, pstate_phase=0.
N $84AF Reached by tail-jump from most other pstate_N handlers when their animation/action completes.
C $84B1,3 set Player state-machine state
C $84B5,3 set Player state-machine phase/height window
@ $84B9 label=pstate_play
c $84B9 Pstate play
N $84B9 State 0: standing/walking, the default state.
N $84B9 Reads the cell under the player (READ_PLAYER_CELL) and dispatches on its type (0=normal falls through, 1->#R$8590, 2->#R$85A1, else->#R$85B0).
N $84B9 Normal cell: ROTATE_IF_IDLE, then vertical input picks a climb direction (tests $60BE facing sign) and enters pstate_3 (climb) at $8559.
N $84B9 No vertical input: horizontal input nonzero -> JP #R$8656 (enter pstate_1, climb a column) else ROTATE_TOWER with vertical input, carry (blocked) -> JP #R$8673 (alt pstate_1 entry).
N $84B9 No input at all: CHECK_CONVEYOR / TEST_CELL_SPECIAL under fire button -> may set game_state=1 and JP #R$8724 (enter pstate_4, jump/fall) else just advances the idle-walk animation phase (0..7, sound 2 every 4th step).
C $84BC,3 Read player cell
C $84CF,3 Rotate if idle
C $84D2,3 get Signed input
C $84EB,3 get Signed input
C $84F2,3 get Signed input
C $84F5,3 Rotate tower
C $84FB,3 get Player state-machine phase/height window
C $8501,3 set Player state-machine phase/height window
C $850D,3 get Player state-machine phase/height window
C $8518,3 get Signed input
C $851F,3 get Signed input
C $8525,3 Check conveyor
C $8533,3 get Signed input
C $8539,3 get Signed input
C $8540,3 Test cell special
C $854A,3 set Game state
C $855B,3 set Player state-machine state
C $855F,3 set Player state-machine phase/height window
@ $8563 label=pstate_3
c $8563 Pstate 3
N $8563 State 3: vertical climb animation (entered from pstate_play at $8559).
N $8563 Picks a sprite frame from table #R$86F2 indexed by phase (mirrored via +7 when $60BE facing is negative), increments phase each call.
N $8563 At phase==7 the climb cycle ends: flips the facing bit ($60BE ^= $80) and returns to pstate_reset (state 0).
C $8567,3 get Player state-machine phase/height window
s $858D
@ $8590 label=pstate_play_cell1
c $8590 Pstate play cell1
N $8590 pstate_play continuation for cell type 1 (also re-entered from code_8a71's wall-bump bounce-back path).
@ $8596 label=pstate_play_cell1b
c $8596
@ $85A1 label=pstate_play_cell2
c $85A1 Pstate play cell2
N $85A1 pstate_play continuation for cell type 2.
@ $85B0 label=pstate_play_cell_other
c $85B0 Pstate play cell other
N $85B0 pstate_play continuation for any other cell type (not 0/1/2).
C $85CF,3 set Player state-machine state
C $85D3,3 set Player state-machine phase/height window
@ $85DB label=pstate_2
c $85DB Pstate 2
N $85DB State 2: top-of-climb slide-in, entered from pstate_1 when a column climb finishes normally (phase reaches its $8642 limit).
N $85DB Nudges tower rotation (ROTATE_TOWER) and scroll position (STEP_SCROLL), plays a sound, then hands off (see C-lines) back to normal play.
C $85E8,3 Rotate tower
C $85F6,3 Step scroll
C $862B,3 Play sound
@ $863F label=tbl_863f
b $863F
N $863F 23-byte signed-offset data table read by pstate_1 for scroll-delta/frame lookups.
N $863F Byte #R$863F itself doubles as a SELF-MODIFIED scratch cell: code_8656/#R$8673 store the climb's vertical-input direction there for pstate_1 to feed into ROTATE_TOWER.
@ $8656 label=code_8656
c $8656 Enter column climb (via horizontal input)
N $8656 Climb-column entry #1 (from pstate_play when horizontal input is pressed on a normal cell).
N $8656 Sets player_state=1 (pstate_1), stashes vertical input into tbl_863f[0] (self-mod, read back by pstate_1), resets phase=0, sets self-mod climb params $8641=0/$8642=$0C, plays sound 4 (climb start).
C $8658,3 set Player state-machine state
C $865B,3 get Signed input
C $8662,3 set Player state-machine phase/height window
C $866F,3 Play sound
@ $8673 label=code_8673
c $8673 Enter column climb (via blocked rotate)
N $8673 Climb-column entry #2: alternate entry into pstate_1, taken from pstate_play when ROTATE_TOWER reports a collision (carry) while vertical input is held.
N $8673 Same shape as code_8656 but with different climb params ($8641=$80, $8642=$07) and no sound call.
C $8675,3 set Player state-machine state
C $8678,3 get Signed input
C $867F,3 set Player state-machine phase/height window
@ $868D label=pstate_1
c $868D Pstate 1
N $868D State 1: climbing a tower column (entered via code_8656/#R$8673).
N $868D Sets a sprite frame from phase&7 combined with facing, ROTATE_TOWERs using the direction stashed in tbl_863f, then looks up a scroll delta (table $8643, mirrored $864F when climbing the other way) and applies it via STEP_SCROLL.
N $868D On a special zero-crossing case it aborts the climb (sound 2, back to pstate_reset). Otherwise advances phase; once phase reaches the $8642 limit it does a final STEP_SCROLL($FF) -- no-carry falls into the pstate_5 setup path (#R$8596), carry sets phase=1 and player_state=2 (pstate_2, slide-in).
C $869E,3 Rotate tower
C $86A1,3 get Player state-machine phase/height window
C $86B9,3 Step scroll
C $86CF,3 Play sound
C $86E1,3 Step scroll
C $86E9,3 set Player state-machine phase/height window
C $86EE,3 set Player state-machine state
b $86F2
N $86F2 Sprite-frame table for pstate_3 (climb animation), indexed by phase.
@ $8724 label=pstate4_entry
c $8724 Enter pstate 4 (jump/fall)
N $8724 Entry into pstate_4 (jump/fall), taken from pstate_play when fire is pressed over a conveyor/special cell.
N $8724 Sets player_state=4, phase=0, clears self-mod flag $8723 (used later inside pstate_4's landing logic), plays sound 3 (jump start).
C $8726,3 set Player state-machine state
C $872A,3 set Player state-machine phase/height window
C $8732,3 Play sound
@ $8736 label=pstate_4
c $8736 Pstate 4
N $8736 State 4: jump/fall arc (entered from #R$8724 or from pstate_play's ROTATE_TOWER-blocked path).
N $8736 Early phase (0..6): plays a landing sound at gated points, picks a sprite frame from tables $8700/$8704 (mirrored by facing), nudges tower rotation toward the center column (#R$60B9&7 vs 4) via ROTATE_TOWER, advances phase.
N $8736 Phase 7..$0C: picks frame from table $8709, advances phase. Falls through to #R$879B for the rest of the arc.
C $8736,3 A = pstate_phase (landing-sound gate)
C $8739,8 phase in [7,$22]? sound-gate window test
C $8747,3 Play sound
C $874A,3 get Player state-machine phase/height window
C $874D,4 phase>=4? skip walk-frame select
C $8751,16 select sprite frame table $8700/$8704 (mirrored by facing)
C $8766,3 get Tower rotation position
C $8769,12 rotate tower toward center column (compare &7 vs 4)
C $8775,3 Rotate tower
C $877D,6 phase<7: force phase=7 (skip window)
C $8783,3 set Player state-machine phase/height window
C $8786,2 phase>=$0D? end of this section
C $878A,11 phase 7..$0C: frame from table $8709, phase++
s $879A
c $879B Pstate 4 land
N $879B Continuation of pstate_4 for phase>=$0D (descent/landing).
N $879B At phase==$1D: clears $60C2, and if game_state!=0 sets game_state=2 (signals landing to main_tick). Also rotates tower position by +-2 per facing, toggling a self-mod alternator so this only fires every other call.
N $879B Phase $1D..$22: frame from table $86F9. Phase>=$23: if game_state==3, JP #R$A113 (external -- special level-transition landing, not covered here). Else STEP_SCROLL($FC) and, at phase<$24, latches a landing facing direction into $60BE from vertical input.
N $879B Phase $24..$27: frame from table $86E4/$86E8 (mirrored). Phase>=$28: jump sequence complete, JP pstate_reset.
C $879B,2 phase < $1D? skip landing-signal block
C $879F,4 clear $60C2
C $87A3,3 get Game state
C $87AB,3 set Game state
C $87AF,11 rotate +-2 per facing (self-mod alternator gated)
C $87C0,3 set Tower rotation position
C $87C3,7 alternator toggled -> fire every other call
C $87CA,5 not yet: phase++, done
C $87CF,2 phase < $23? use table $86F9 frame
C $87D3,16 frame from $86F9[phase], phase++
C $87E8,1 phase >= $23: check game_state==3
C $87E9,3 get Game state
C $87F8,3 Step scroll
C $87FE,3 get Signed input
C $8812,2 phase < $28? frame table $86E4/E8
@ $8831 label=pstate_4_land_tail
c $8831 Pstate 4 land tail
N $8831 Tail of pstate_4's landing phase-$24..$27 frame-select branch: sets player_state=2 or similar hand-off, phase, plays a sound.
C $883F,3 set Player state-machine state
C $8843,3 set Player state-machine phase/height window
C $8850,3 Play sound
@ $8854 label=pstate_5
c $8854 Pstate 5
N $8854 State 5: ledge-grab / climb-onto (entered from pstate_1 at #R$8596 when a column climb ends without reaching the top-of-climb case).
N $8854 Calls ROTATE_IF_IDLE each frame. At phase==3 the grab completes -> JP pstate_reset. Otherwise picks a sprite frame from table $871C indexed by phase OR'd with facing bits ($60BE), and at phase==1 calls update_player_obj to sync the actor's screen position. Increments phase each call.
C $8857,3 get Player state-machine phase/height window
C $8873,3 Update player obj
@ $887B label=update_player_obj
c $887B Update player obj
N $887B Copy the live tower position (#R$60BA) into the player object (actor_obj) column fields (+6/+12), biased by tower_height and facing ($60BE bit7).
N $887B Clobbers: A,HL,IX.
C $8888,3 get Tower rotation position
s $88AA
@ $88AB label=pstate5_exit
c $88AB Exit pstate 5 (ledge grab)
N $88AB Exit path from pstate_5's ledge-grab completion: checks CHECK_CONVEYOR under the player and either hands off into pstate_6 (state=6, on a conveyor) or resets phase/state back to normal play.
C $88AF,3 set Player state-machine phase/height window
C $88B4,3 set Player state-machine state
C $88B7,3 Check conveyor
@ $88BD label=pstate_6
c $88BD Pstate 6
N $88BD State 6: riding a conveyor / column-transition (entered from #R$88AB).
N $88BD Phase==0: nudges tower rotation (#R$60B9) toward the center column (compare &7 vs 4), same trick as pstate_4.
N $88BD Phase==1: sets flag #R$6038=$FE, calls CHECK_CONVEYOR and combines its result with a self-mod "descending" byte at #R$88AA to build a movement mask, then applies a signed 16-bit step to the actor's column position (#R$60BA). Every 4th sub-step plays sound $0A and re-checks the conveyor.
N $88BD Examines the cell flags to either block movement (early RET) or complete it: on completion ORs $81 into the cell flags, calls $A766 (object/effect hook, not analysed here), sets #R$6038=$FF, returns to pstate_reset.
C $88BD,6 phase!=0? skip center-rotate step
C $88C3,3 get Tower rotation position
C $88DA,6 phase==0 tail: phase++, flag_6038=$FE
C $88E0,3 set Flag?? $00 $FE $FF
C $88E3,3 Check conveyor
C $88E6,11 combine conveyor result with self-mod #R$88AA descending flag
C $88F6,9 A = descending flag; B = sign extend
C $8900,17 apply signed step to actor column (16-bit)
C $8913,3 Play sound
C $8916,3 Check conveyor
C $8919,4 re-check conveyor result sign
C $8920,12 facing-negative branch: test cell flags, block or pass
C $892C,3 get Signed input
C $8936,12 facing-positive branch: mirrored test
C $8942,3 get Signed input
C $894D,8 complete: mark cell done, notify, reset flag, return
C $8955,3 set Flag?? $00 $FE $FF
@ $895B label=collision_test
c $895B Collision test
N $895B Player-vs-world collision probe, called from check_collision.
N $895B Builds a synthetic object record for the player at $6060 (angular pos=tower_height, column=#R$60BA+1/$60BB carry AND 3) so the shared actor-vs-actor code in check_collisions can be reused, then calls it.
N $895B If check_collisions reports a hit (CY), converts its returned IY pointer into IX and returns CY=1 (hit an enemy/moving actor).
N $895B If no actor hit, falls back to a static "wall marker" scan: walks the 4 object_table entries, considering only those with state (+48)==7 (used here as a static-obstacle marker, distinct from player_state's own state 7), and tests whether the player's row (16-bit, from #R$60BA/$60BB) falls within roughly [entry_row-9, entry_row+16] of the entry's position (IX+6/IX+12). First match sets CY=1 with IX pointing at that entry else NC.
N $895B Out: CY=hit, IX=colliding object (actor or wall-marker entry).
N $895B Clobbers: A,BC,DE,HL,IX.
C $895B,4 IX -> synthetic player record ($6060)
C $895F,3 get Tower rotation position
C $8962,21 store angular pos + column (16-bit) into it
C $897A,2 actor hit -> convert IY to IX (below)
C $897C,6 fallback: B=4, walk object_table for wall markers
C $8977,3 Check collisions
C $8982,9 only consider state==7 (wall marker) entries
C $898F,9 row window test vs entry's position: too far?
C $899A,12 row+7 <= entry's position? (upper bound)
C $89AF,15 entry's position+9 >= row? (lower bound)
C $89C0,5 convert actor hit: HL(from check_collisions)->IX, set CY
@ $89C5 label=check_collision
c $89C5 Check collision
N $89C5 Test the player against the tower/hazards and apply the result.
N $89C5 Dispatches on player_state (#R$60C0):
N $89C5 7 = invulnerable/idle -> no test (RET)
N $89C5 4 = check a height window (#R$60BF in $0A..$1E)
N $89C5 8 = RET else test flag $60C5.
N $89C5 Calls #R$895B (carry = hit).
N $89C5 On a hit it patches the value at #R$8A49 (SELF-MODIFYING: $14/$0F/$20 select the bump/death response used downstream) and branches into the hit handler.
C $89C5,3 A = player_state (#R$60C0)
C $89CA,1 state 7: no collision this frame
C $89CF,3 A = #R$60BF (height-in-column)
C $89E4,3 Collision test
C $89E7,2 hit -> hit handler
C $89E9,3 get Player state-machine state
C $89EF,3 get Tower rotation position
C $89F5,3 Check rotate collision
C $89FB,3 patch response code at #R$8A49 = $14 (SELF-MOD)
C $8A01,3 A = colliding object state (+48)
C $8A0D,3 patch response code ($0F enemy / $14 wall)
C $8A10,3 get Player state-machine state
C $8A26,3 get Player state-machine state
C $8A33,3 Check conveyor
C $8A3F,3 set Flag?? $00 $FE $FF
@ $8A49 label=hit_response
s $8A49
N $8A49 SELF-MODIFIED scratch byte, not code: check_collision writes a response code here ($14 wall / $0F enemy) on a hit, and code_a871 reads it at $8A74 to pick the bump-vs-death branch.
@ $8A4A label=coll_apply
c $8A4A Apply a hit (player invulnerable, sound)
N $8A4A Common "player got hit" handler, reached from check_collision's hit path.
N $8A4A Sets player_state=7 (invulnerable/frozen, matches check_collision's "state 7 = no test" case), phase=0, game_state=0, calls $A72D with A=2 (life/damage counter update), plays sound 5 (hit sound).
C $8A4C,3 set Player state-machine state
C $8A50,3 set Player state-machine phase/height window
C $8A53,3 set Game state
C $8A5D,3 Play sound
@ $8A61 label=tbl_8a61
b $8A61
N $8A61 16-byte signed-offset table used by code_8a71 to size the knockback step, indexed by (response_code>>1)&3.
@ $8A71 label=code_8a71
c $8A71 Bump/knockback handler
N $8A71 Bump/knockback handler, dispatched from check_collision's hit path via the response code at hit_response (#R$8A49).
N $8A71 If the current animation phase equals the stored response code: "wall bump" branch ($8AB5) -- sets a sprite frame, subtracts 4 from the actor's column position (#R$60BA), and if that didn't go negative, re-checks via CHECK_ROTATE_COLLISION; no collision bounces back into pstate_play_cell1 (#R$8590), otherwise (or on negative position) falls into the death handler at $8AD7.
N $8A71 If phase differs from the response code: "step" branch -- picks a sprite frame from table $871F (mirrored by facing), clamps the response code to $0F, looks up a signed delta from tbl_8a61 and applies it to the actor's column position; going negative also falls into $8AD7 (death), otherwise the position is masked/stored and phase increments.
C $8A71,7 A=phase; compare vs stored response code (hit_response)
C $8A7A,15 step branch: index sprite frame table $871F by (code>>1)&3
C $8A8D,9 clamp response code to $0F for delta lookup
C $8A96,8 B=0; lookup signed delta from tbl_8a61
C $8AA2,8 apply delta to actor column (16-bit)
C $8AAA,3 went negative -> death_handler
C $8AB5,8 bump branch: sprite frame from facing
C $8ABD,12 subtract 4 from actor column (wall bump)
C $8AC9,4 negative -> death_handler
C $8ACD,3 get Tower rotation position
C $8AD0,3 Check rotate collision
@ $8AD7 label=death_handler
N $8AD7 Death processing: sets player_state=8 (pstate_8), phase=0, clears actor position (#R$60BA/$60BB), resets each of the 4 object_table actors' state field (+48: 7->0, else->4) and clears their +42 field, plays sound 6, falls straight into pstate_8.
C $8AD7,2 death: state=8
C $8AD9,3 set Player state-machine state
C $8ADD,3 set Player state-machine phase/height window
C $8AE0,6 clear actor position (#R$60BA/$60BB)
C $8AE6,4 IX -> object_table, B=4
C $8AEC,25 reset each actor's state (7->0, else->4), clear phase
C $8B05,4 next actor, loop
C $8B0B,3 Play sound
@ $8B0E label=pstate_8
c $8B0E Pstate 8
N $8B0E State 8: death fall-off animation, entered from death_handler ($8AD7).
N $8B0E While phase<$18, sets sprite frame ($60C1) from phase>>2 and increments phase each call. Once phase>=$18, clears $60C2 and keeps counting.
N $8B0E At phase==$38 sets death_flag (#R$60C3)=1 -- this is the signal main_loop polls to trigger the life-loss handler.
C $8B0E,4 A = pstate_phase
C $8B12,8 phase<$18: frame=phase>>2, phase++
C $8B1F,9 phase>=$18: clear $60C2, check phase==$38
C $8B2C,3 set Player died this frame
s $8B30
@ $8B50 label=sprite_setup
c $8B50 Sprite setup
N $8B50 Compute on-screen positions for the 4 actor sprites (objects 0..3) ahead of drawing.
N $8B50 Derives a buffer base from tower_height into #R$600A, fills two coordinate tables at #R$8B30/$8B40 (X and Y per sprite, via #R$8BEC/#R$8BFF), then per object copies sprite id (IX+18 -> IX+24) and stores the screen column (IX+30) from the angular position (IX+0).
N $8B50 Self-mod: #R$8B30/$8B40 are coordinate scratch buffers IN code.
C $8B50,3 HL -> tower_height
C $8B55,1 4 - height, low 3 bits -> sub-row
C $8B5F,3 DE = $6600 sprite work buffer base
C $8B63,3 store buffer ptr -> #R$600A
C $8B66,3 fill X-coord table #R$8B30 (4 sprites, step 8)
C $8B6C,3 Col screen y
C $8B7A,3 fill Y-coord table $8B40 (4 sprites)
C $8B80,3 Col screen x
C $8B8C,4 IX -> object_table
C $8B93,3 back up sprite id (IX+18 -> IX+24)
C $8B9C,2 state 0 (inactive) -> skip
C $8BA2,2 state 7 -> fixed screen col $40
C $8BA9,3 Col screen x
C $8BAC,3 store sprite screen column (IX+30)
C $8BD0,3 Calc sprite shift
@ $8BEC label=col_screen_y
c $8BEC Col screen y
N $8BEC Map an actor's angular column to its screen Y / vertical-projection value.
N $8BEC In: A = angular position (0..127).
N $8BEC Offsets by the tower rotation: rel = (A + $20 - tower_height) & $7F, then returns col_y_table[#R$6380 + rel].
N $8BEC Out: A = projected value.
N $8BEC Preserves HL (PUSH/POP).
C $8BED,2 bias by +$20 (quarter turn)
C $8BF2,1 subtract current tower rotation
C $8BF3,2 wrap to 0..127 (around the tower)
C $8BF8,3 HL -> col_y_table (#R$6380)
C $8BFC,1 A = table[rel] = projected Y/value
@ $8BFF label=col_screen_x
c $8BFF Col screen x
N $8BFF Map an actor's angular column to a screen X column, folding the cylinder so only the front face shows.
N $8BFF In: A = angular position (0..127).
N $8BFF rel = (A + $20 - tower_height) & $7F, then fold: rel < $20        -> rel + $20      (left quadrant) $20..$5F         -> $60 - rel      (front, mirrored) rel >= $60       -> rel - $60      (right quadrant) Out: A = screen column.
N $8BFF Preserves HL.
C $8C00,2 bias +$20
C $8C05,1 subtract tower rotation
C $8C06,2 wrap to 0..127
C $8C08,2 left quadrant?
C $8C0C,2 -> rel + $20
C $8C10,2 back face?
C $8C14,2 -> rel - $60 (right quadrant)
C $8C1B,1 front: mirror $60 - rel
@ $8C1E label=sprite_shift_masks
b $8C1E Sprite shift masks
N $8C1E 1bpp AND/shift mask data for drawing the tower-column sprites at sub-byte X offsets (patterns 3F/0F/03/00 FF...).
N $8C1E Base referenced from $8D35/$8F5E.
N $8C1E Interleaved with a few SELF-MODIFIED 1-byte slots ($8C76/$8C77/$8C78/$8C81/$8C82/$8C83/ $8C85) that calc_sprite_shift patches with computed shift counts.
N $8C1E Spans #R$8C1E..$8CC1 code resumes at calc_sprite_shift.
@ $8CC2 label=calc_sprite_shift
c $8CC2 Calc sprite shift
N $8CC2 For the actor at IX, compute its screen row (via col_screen_y) and the horizontal sub-byte shift, and patch the shift counts into the self-mod slots above ($8C76/77/ 81).
N $8CC2 Reads the column buffer (#R$600A) to skip empty/edge columns ($0F/$0E sentinels).
N $8CC2 Called from sprite_setup ($8BD0).
C $8CC2,3 A = actor angular pos (IX+0)
C $8CC5,3 Col screen y
C $8CCE,3 patch self-mod slot $8C81 (row)
C $8CD1,3 HL -> column buffer (#R$600A)
C $8CD6,2 $0F = empty column -> skip (RET)
C $8CDE,3 A = tower_height (rotation)
C $8CE5,2 /8 -> byte-column shift
C $8CEF,3 patch shift count slot $8C77
C $8CFE,3 patch shift count slot $8C76
C $8D1A,3 Col screen y
C $8D7B,3 Calc sprite col
C $8DF3,3 Expand sprite a
C $8E0C,3 Expand sprite a
@ $8E25 label=expand_sprite_a
c $8E25 Expand sprite a
N $8E25 Unrolled copy of a sprite/mask definition from (HL) to (DE), terminated by $FF.
N $8E25 The alternating OR $00 / AND $00 immediates are SELF-MODIFIED (by calc_sprite_shift) to apply the per-column shift mask.
N $8E25 Clobbers: A,DE,HL.
C $8E25,1 A = source byte (HL)
C $8E26,2 self-mod OR mask (set by calc_sprite_shift)
C $8E28,1 store merged byte, advance dest
C $8E2B,1 A = next source byte
C $8E2C,2 self-mod AND mask (set by calc_sprite_shift)
C $8E3D,2 A = $FF (terminator byte)
C $8E3F,1 store terminator, advance dest
C $8E41,1 A += 1 (second terminator byte)
C $8E44,2 loop 4 columns
@ $8E48 label=patch_expand_masks
N $8E48 Entry point used by calc_sprite_shift, not by expand_sprite_a's own DJNZ loop.
N $8E48 Reads the self-mod shift-count slot ($8C82) to index a 2-byte pair from table $8C79 (shift*2), storing it into the loop-count operands of the first/third strip's "LD B,nn" at $8E81/$8EC7 (operand bytes $8E82/$8EC8) -- CORRECTION: these are NOT routine pointers or mask operands, they are the row counts for the two edge strips. Confirmed by emulation: for every shift value 0-3, (first-strip-count + third-strip-count) == 8, and combined with the always-8-row middle strip, TOTAL decoded height is a shift-INVARIANT 16 rows. When the shift-count slot is 0, the first strip is skipped entirely (JR Z,$8E86) and its row count (0) is moot.
N $8E48 Then, per 8-pixel strip, copies 3 source mask bytes ($600C/$600D/$600E or $600F/$6010/$6011 or $6012/$6013/$6014, selected by the same shift-count test) straight into expand_sprite_b's real OR-immediate operands ($8ECB/$8ED7/$8EE3), and their bitwise complement (CPL) into the paired AND-immediate operands ($8ED1/$8EDD/$8EE9) -- so expand_sprite_b ORs in the new sprite bits and ANDs out the old ones at the right sub-byte shift, then calls expand_sprite_b.
N $8E48 See gfx_c1f6 (#R$C1F6) for the full sprite-bitmap decode writeup (this self-modifying pipeline is why the bitmap can't be rendered as a raw UDG array image).
N $8E48 Clobbers: A,BC.
C $8E48,3 A = shift-count slot ($8C82)
C $8E4B,4 index a 2-byte routine-pointer pair
C $8E54,1 fetch first pointer byte
C $8E55,3 self-mod store: expand_sprite_b OR operand
C $8E59,1 fetch second pointer byte
C $8E5A,3 self-mod store: expand_sprite_b AND operand
C $8E5D,3 re-test shift-count slot
C $8E61,2 zero? -> skip first mask triple
C $8E63,3 A = mask byte 1 ($600C)
C $8E66,3 self-mod store: OR operand
C $8E69,1 complement for AND operand
C $8E6A,3 self-mod store: AND operand
C $8E81,2 B = 0 (loop count for this strip)
C $8E83,3 Expand sprite b
C $8EA4,2 B = $08 (loop count for this strip)
C $8EA6,3 Expand sprite b
C $8EC7,2 B = 0 (loop count for final strip)
@ $8EC9 label=expand_sprite_b
c $8EC9 Expand sprite b
N $8EC9 Same unrolled-copy shape as expand_sprite_a, but its OR/AND immediate operands are self-modified by patch_expand_masks ($8E48) rather than calc_sprite_shift directly -- used for the shift-boundary case where 3 source mask bytes (not 2) are needed per strip.
N $8EC9 Clobbers: A,DE,HL.
C $8EC9,1 A = source byte (HL)
C $8ECA,2 self-mod OR mask (set by patch_expand_masks)
C $8ECC,1 store merged byte, advance dest
C $8EED,2 loop 3 mask bytes
C $8EEF,2 restore flags, RET
@ $8EF1 label=calc_sprite_col
c $8EF1 Calc sprite col
N $8EF1 Resolve a sprite column: index table #R$8B30 by A, compare the result against the actor's clip field (IX+30), and patch the shift slot $8C81.
N $8EF1 RET early when within bounds.
N $8EF1 Clobbers: A,DE,HL.
C $8F1B,3 Draw tower cell
C $8F24,3 Draw tower cell
@ $8F31 label=draw_tower_cell
c $8F31 Draw tower cell
N $8F31 Decode one tower map cell byte at (HL) -- full bitfield format documented in docs/Level-Format.md (bit7=occupied, bits0-1=type, bits4-5=subtype).
N $8F31 Bit7 clear (unoccupied) or type==3 (invalid combo here) -> RET, nothing drawn. Otherwise type bit0 selects one of three offset tables (bit0==0 -> tbl_cell_offsets_c $8FA1 bit0==1 and bits2-3==0 -> tbl_cell_offsets_a #R$8F75 bit0==1 and bits2-3!=0 -> tbl_cell_offsets_b $8F8B).
N $8F31 The chosen table is indexed by DE (caller-supplied sub-position, not part of the cell byte) negative entries ($FF) mean nothing to draw at that sub-position.
N $8F31 A non-negative entry is *3 and indexes sprite_shift_masks (#R$8C1E) for 3 AND-mask bytes, ANDed into 3 destination screen bytes at (BC) to punch out the feature's silhouette. Bumps a self-mod counter at $8C78 on every successful draw.
N $8F31 Clobbers: A,HL,...
C $8F32,5 A = cell byte; bit7 clear (unoccupied) -> RET
C $8F37,3 H = cell byte; isolate type bits0-1
C $8F3A,4 type==3 (invalid/no-render)? -> RET
C $8F3E,4 test type bit0
C $8F42,3 reload cell byte, isolate bits2-3
C $8F45,2 bits2-3==0 -> table_a
C $8F47,5 else -> table_b ($8F8B)
C $8F4C,5 table_a (#R$8F75)
C $8F51,3 bit0==0 -> table_c ($8FA1)
C $8F54,1 HL += DE (sub-position index)
C $8F55,5 A = table[DE]; negative -> RET (nothing here)
C $8F5A,4 index = A*3 into sprite_shift_masks
C $8F5E,4 HL -> sprite_shift_masks[index]
C $8F62,13 AND-mask 3 destination bytes at (BC)
C $8F6F,4 bump feature-drawn counter ($8C78)
@ $8F75 label=tbl_cell_offsets_a
b $8F75
N $8F75 First of three sibling offset tables (#R$8F75/$8F8B/$8FA1), selected by draw_tower_cell on the cell descriptor's bits 2-3, then indexed by DE (low descriptor bits) to get an offset into sprite_shift_masks (#R$8C1E).
@ $8FB7 label=clear_actor_states
c $8FB7 Clear actor states
N $8FB7 Zero the state byte (+48) of all four object_table actors, deactivating every enemy.
N $8FB7 Clobbers: A,B,IX.
@ $8FC7 label=draw_player
c $8FC7 Draw player
N $8FC7 Compute the player sprite's on-screen address from the vertical scroll (#R$6030) and draw it.
N $8FC7 Handles the tower wrap: the playfield scrolls vertically mod the tower height, so the screen row is (#R$6030 +/- offset) kept in range.
N $8FC7 Stores the two derived screen pointers ($6057, $6059) then calls the blit helpers (#R$8B50, #R$9035).
N $8FC7 In: #R$6030 = scroll position.
N $8FC7 Out: player drawn.
N $8FC7 Clobbers A,HL.
C $8FC7,3 HL = scroll position (#R$6030)
C $8FCB,2 - 8 (sprite top offset)
C $8FD1,2 keep within the 3 screen-thirds (mod via AND 3)
C $8FD4,2 past the wrap point ($3D0)?
C $8FDD,3 -> clamp to top (0)
C $8FE0,3 store upper screen pointer ($6057)
C $8FE3,3 get Vertical scroll position
C $8FE7,2 + $4D (sprite body offset)
C $8FF0,3 store lower screen pointer ($6059)
C $8FF3,3 Sprite setup
C $8FF6,3 Sprite depth sort
@ $8FFA label=draw_actors_sorted
c $8FFA Draw actors sorted
N $8FFA Draw the 4 actors back-to-front: for depth key C=3..0, find the object whose field (+36) matches and draw it via draw_actor.
N $8FFA Clobbers: A,BC,IX.
C $8FFA,2 C = 3 (starting depth key, back-most)
C $8FFC,7 IX -> object_table, B = 4 slots
C $9003,7 match this slot's draw-order field (+36)? draw it
C $900C,6 next depth key; done all 4? -> player tail
C $9019,9 player actor: skip if inactive (phase==$FF)
@ $9035 label=sprite_depth_sort
c $9035 Sprite depth sort
N $9035 Decide the back-to-front draw order of the 4 actor sprites so nearer ones overdraw farther ones around the tower.
N $9035 Does all 6 pairwise comparisons of the sprites' screen columns (IX+30..IX+33), packing the results into 6 bits of B, XORs $3F, and uses that as an index into data_908e -- a precomputed table mapping each comparison outcome to a draw permutation.
N $9035 The 4 order indices are unpacked (2 bits each) into IX+36..IX+39.
N $9035 TRI
C $9035,4 IX -> object_table
C $903B,3 compare sprite0 col vs sprite1..3
C $9041,2 shift compare result into key (RL B)
C $9062,1 A = packed 6-bit comparison key
C $9063,2 invert (XOR $3F) to index orientation
C $9068,3 HL -> data_908e[key]
C $906C,1 B = packed draw order (4 x 2-bit indices)
C $9070,3 unpack order[0] -> IX+39
C $9079,3 unpack order[1] -> IX+38
C $9082,3 unpack order[2] -> IX+37
C $908A,3 unpack order[3] -> IX+36
C $908D,1 return: draw order in IX+36..+39
@ $908E label=data_908e
b $908E DATA_908E
N $908E 64-entry packed draw-order permutation table for sprite_depth_sort.
N $908E Index = 6-bit pairwise-comparison key of the 4 sprites' columns (XOR $3F).
N $908E Each byte packs 4 two-bit object
N $908E indices = the back-to-front draw order.
N $908E Bounded by update_enemies.
@ $90DA label=update_enemies
c $90DA Update enemies
N $90DA Step the 4 enemy actors (objects 0..3 of object_table).
N $90DA For each: dispatch on its state (+48):
N $90DA 0 = inactive (skip), 7 = patrol/home toward player_col,
N $90DA 4/6 = -> #R$9158 (full movement state machine), 5 = phase countdown (+42) -- expires (bit7 of +42 set) into state 2.
N $90DA else (any other state, e.g. 3/8/9) falls straight into #R$9158 too, since only 0/7/5 are filtered out here.
N $90DA State 7 homing: moves angular pos (+0) by speed (+54), then compares against player_col and the tower quadrant marks $3C/$78 to pick a chase direction (+2 / -2), or deactivates.
N $90DA In: nothing.
N $90DA Loops B=4 objects.
N $90DA Clobbers most regs + IX.
C $90DA,4 IX -> object_table (enemy 0)
C $90DE,2 B = 4 enemies
C $90E1,3 A = this enemy's state (+48)
C $90E6,3 0 = inactive -> next enemy
C $90EB,2 state 7 = active/homing?
C $90ED,4 set sprite id (+18) = $4E
C $90F4,3 angular pos (+0) += speed (+54)
C $90FA,3 HL -> player_col
C $90FD,2 bit7 = which side of the tower the player is on
C $9101,2 at quadrant mark $3C?
C $910B,4 chase: speed = +2 (toward player)
C $911A,4 chase: speed = -2 ($FE)
C $9120,4 off-screen/limit -> deactivate (state 0)
C $9124,2 flag $60A3 = $7D (respawn/notify)
C $912C,2 state 4?
C $9136,2 state 5 = phase countdown
C $913B,3 decrement phase (+42)
C $913E,4 phase underflowed (bit7 set) -> state=2
C $914B,3 Check actor collision
C $9150,4 blocked -> force state=4, phase=0
@ $9158 label=enemy_move_dispatch
c $9158 Enemy state dispatch
N $9158 Entry into the enemy's full movement/behaviour state machine, reached from update_enemies for states 4, 6, and the default case.
N $9158 state==4 -> #R$9183 (idle/animate-in-place check). state==6 -> tests phase (+42): phase==6 means a pending transform is queued, jumps to enemy_transform (#R$9170) else falls into the shared idle-animation tail (enemy_idle_anim, #R$9191) with a mirrored phase.
N $9158 Any other state falls through to #R$91A4 (enemy_move_dispatch2).
C $9158,3 A = state (+48)
C $915D,2 state 4 -> #R$9183
C $915F,2 state 6?
C $9163,3 A = phase (+42)
C $9166,2 phase==6 -> pending transform
@ $9170 label=enemy_transform
c $9170 Enemy transforms into queued next state
N $9170 Applies a queued state transform: copies the enemy's own +42/+3C fields into its live state (+48) and phase (+42), sets sprite id=$52.
N $9170 This is how an enemy morphs into a different behaviour after a countdown (fields +42/+3C are pre-loaded elsewhere as the "next state/phase" to become).
@ $9183 label=enemy_idle_check
c $9183 Enemy idle: deactivate after full cycle
N $9183 state==4 path: if phase (+42) has reached 6, deactivates the enemy (state=0) else falls into enemy_idle_anim to keep cycling its idle sprite.
@ $9191 label=enemy_idle_anim
c $9191 Enemy idle animation cycle
N $9191 Shared idle-animation tail for state 4 and the non-transform branch of state 6: clamps phase to 0..2 (wraps at 3), computes sprite id = phase*4+$5A, increments phase (+42), done.
C $9191,2 clamp phase to 0..2
C $9197,7 sprite id = phase*4 + $5A
C $919E,3 phase++
@ $91A4 label=enemy_move_dispatch2
c $91A4 Enemy movement: pick vertical/horizontal/attack path
N $91A4 Second dispatch tier, reached for any state other than 0/4/5/6/7.
N $91A4 state==3 -> #R$921D (enemy_post_move, shared attack/death dispatch). state==8 -> #R$91AD (enemy_move_vertical). else -> #R$91F8 (enemy_move_horizontal, the default case covering states like 1/2/9 during normal movement).
C $91A4,2 state==3?
C $91A6,3 -> enemy_post_move
C $91A9,2 state==8?
@ $91AD label=enemy_move_vertical
c $91AD Enemy moves vertically
N $91AD state 8: moves the enemy's 16-bit vertical position (+6/+12) by its signed speed (+54), backing up the old position in #R$6034 first.
N $91AD Tests the new position via CHECK_ACTOR_COLLISION_A (#R$934C) and, if clear, CHECK_COLLISIONS against the player/other actors on-screen wraps checked via bit7 of the high byte (JP NZ,#R$9311 = out-of-bounds reset).
N $91AD On a block, restores the previous position and reverses the speed sign (bounce).
N $91AD Always ends by setting sprite id from the level number (#R$6039&3)*4+$66 (level-tinted variant), then next enemy -- does not fall into enemy_post_move.
C $91AD,6 backup old position, add speed (16-bit)
C $91C0,6 wrap-check: out of range -> #R$9311 (bounds reset)
C $91CF,3 Check actor collision
C $91D4,3 Check collisions
C $91D9,9 blocked: restore old position
C $91E2,7 reverse speed sign
@ $91F8 label=enemy_move_horizontal
c $91F8 Enemy moves horizontally (around tower)
N $91F8 Default movement case (any state not 3/4/5/6/7/8): moves the enemy's angular position (+0) by its signed speed (+54), mod 128, backing up the old value in #R$6033 first.
N $91F8 Same collision test/bounce pattern as enemy_move_vertical (CHECK_ACTOR_COLLISION_A then CHECK_COLLISIONS on clear on a block, restores old position and reverses speed).
N $91F8 Falls through into enemy_post_move (#R$921D), unlike enemy_move_vertical.
C $91F8,6 backup old angular pos
C $91FE,8 add speed, wrap mod 128
C $9206,3 Check actor collision
C $920B,3 Check collisions
C $9210,10 blocked: restore old position, reverse speed
@ $921D label=enemy_post_move
c $921D Enemy post-move: hazard/attack dispatch
N $921D Shared post-movement dispatch: state==2 -> #R$92EC (enemy_hazard_react). state==9 -> $91E9 (just refresh the level-tinted sprite, no movement -- an inert/spawned variant).
N $921D Otherwise this is the attack-pattern driver: indexes a per-enemy step table at $90CE by phase (+42). A zero entry means no attack step due yet -> enemy_attack_cooldown (#R$92DC, phase++ up to $0A). A nonzero entry is a signed step consumed by enemy_attack_step (#R$9238) to chain a dash/charge move.
C $921D,3 A = state (+48)
C $9220,5 state==2 -> enemy_hazard_react
C $9225,5 state==9 -> refresh level-tinted sprite only
C $922A,9 phase -> index into attack-step table $90CE
C $9235,3 entry==0 -> no attack step due, cooldown
@ $9238 label=enemy_attack_step
c $9238 Enemy attack dash step
N $9238 One step of an attack dash/charge sequence, driven by the $90CE table entry for the current phase.
N $9238 Applies the (sign-extended) step as a 16-bit delta to the enemy's vertical position (+6/+12), backing up the old value in #R$6034. Wrap past the tower bounds (bit7 of H) resets the enemy via #R$9311.
N $9238 Tests the new position (CHECK_ACTOR_COLLISION_A then CHECK_COLLISIONS); on a block, restores the old position and falls to enemy_hazard_react (#R$92DC) instead of continuing the dash.
N $9238 On success, re-examines the just-consumed table entry: $FF or $01 (a mid-dash unit step) loops back to consume the next table entry (re-enters at #R$9238) any other value (the dash's terminating marker) branches to either finish the attack (state==3 -> set state=2, phase=0) or fall to #R$928D to decide whether to trigger a fresh attack.
C $9245,3 backup old position (16-bit)
C $924B,3 wrap -> #R$9311 (bounds reset)
C $9257,3 Check actor collision
C $925C,3 Check collisions
C $9262,6 blocked: restore old position
C $9278,3 terminating step: A==1?
C $927E,8 state==3 -> finish attack (state=2, phase=0)
@ $928D label=enemy_attack_trigger
c $928D Enemy checks whether to launch an attack
N $928D End of a completed (or not-yet-started) attack cycle: only fires when the enemy is currently stationary (speed +54 == 0).
N $928D Requires $60C2 nonzero, player_state==0 (normal play), and the player's tower position to exactly match this enemy's (+6/+12) -- i.e. same column.
N $928D If so, computes the angular direction D (+1/-1) from tower_height to the enemy and, if the angular distance is under $20 (close enough), stores D into speed (+54) -- launching the attack dash that enemy_attack_step will then drive frame by frame.
N $928D Always resets phase (+42)=0 and plays sound 1 (attack cue) before falling to the next enemy.
C $928D,3 A = speed (+54)
C $9293,6 require $60C2 and player_state==0
C $92A0,8 require player column matches (first axis)
C $92A8,8 require player column matches (second axis)
C $92B2,13 compute chase direction from tower_height delta
C $92C9,4 too far (>=$20) -> skip trigger
@ $92D0 label=enemy_attack_reset
c $92D0 Enemy attack: reset phase, play cue
N $92D0 Common tail for enemy_attack_trigger: phase=0, play sound 1 (attack cue), next enemy.
C $92D6,3 Play sound
@ $92DC label=enemy_attack_cooldown
c $92DC Enemy attack cooldown countdown
N $92DC No attack step due this frame: increments phase (+42), clamped to a max of $0A, then next enemy.
@ $92EC label=enemy_hazard_react
c $92EC Enemy reacts to hazard cell
N $92EC state 2 (also reached when enemy_attack_step is blocked): sets sprite id=$56, reads the tower-map cell under the enemy via read_actor_cell.
N $92EC Cell type 0 -> nothing, next enemy. Type 1 -> enters state 3 with phase=$0A (a timed sub-state, presumably "stuck/retreating"). Any other type -> reverses speed (+54) sign and continues.
C $92EC,5 sprite id = $56
C $92F1,3 Read actor cell
C $92F5,3 cell type 0 -> nothing, next enemy
C $92F8,2 cell type == 1?
C $92FA,2 -> type-1 handler ($9306)
C $92FC,7 else: reverse speed sign
C $9306,8 type 1: state=3, phase=$0A
@ $9311 label=enemy_bounds_reset
c $9311 Enemy out-of-bounds reset
N $9311 Safety reset when a position update wraps past the tower's valid range (bit7 of the computed high byte): zeroes the enemy's position (+6/+12) and phase (+42), forces state=4 (idle/animate).
@ $931F label=enemy_next
c $931F Next enemy
N $931F Common per-enemy loop tail: advance IX to the next object_table slot, DJNZ back to update_enemies' outer loop, RET when all 4 are done.
s $9327
@ $9330 label=check_rotate_collision
c $9330 Check rotate collision
N $9330 Player-move collision probe.
N $9330 Loads the self-mod probe params (column $9329=A, direction step $932A=$FD, span $932B/$932C, plus $9432/$9437) then runs the shared cell probe at $9395.
N $9330 In: A=column.
N $9330 Out: CY/flags from the probe.
@ $934C label=check_actor_collision_a
c $934C Check actor collision
@ $9372 label=check_actor_collision_b
c $9372 Check actor collision b
N $9372 Loads the shared cell-probe params from actor IX (column, position) with a fixed direction/span (step=-1, span 0..2, extra 5), then falls into run_cell_probe ($9395) -- the actor-position variant of check_rotate_collision's player-move probe.
C $9372,3 A = actor's angular column (IX+0)
C $937E,2 direction step = -1
C $9388,8 span/extra probe params (fixed)
@ $9395 label=run_cell_probe
C $93E0,3 set Camera row
C $93F5,3 set Camera row
C $93FE,3 get Camera row
C $946A,3 Play sound
@ $9493 label=pos_to_col
c $9493 Position to column
N $9493 Convert a 16-bit fixed-point position (e.g. #R$60BA, the actor's column position -- 4 sub-units per tower column) into a coarse column index: A = HL >> 2, computed as a proper 16-bit shift (H's low bits feed into A) so the result isn't just the high byte.
N $9493 In: HL = fixed-point position.
N $9493 Out: A = column index (HL >> 2), HL preserved.
N $9493 Clobbers: A.
C $9493,1 save HL (preserve caller's position)
C $9494,1 A = L (low byte of position)
C $9495,2 H >>= 1, carry = H's old bit0
C $9497,1 A = (A>>1) with carry in from H -- 16-bit shift, pass 1
C $9498,2 H >>= 1 again, carry = bit0
C $949A,1 A = (A>>1) with carry in -- 16-bit shift, pass 2 (A = HL>>2)
C $949B,1 restore HL
@ $949D label=read_player_cell
c $949D Read player cell
N $949D Compute and read the tower-map cell at the player's position (from #R$60BA via pos_to_col and tower_height), returning the cell contents for the pstate_play logic.
N $949D Clobbers: A,C,HL.
C $94A0,3 Position to column
C $94A5,3 get Tower rotation position
C $94D8,3 get Tower rotation position
b $94F6
@ $9516 label=player_cell_addr
c $9516 Player cell addr
N $9516 Return HL = address in the #R$F000 tower map of the player's current cell (column from #R$60BA, row from tower_height>>3, page $F0+).
N $9516 Clobbers: A,HL.
C $9519,3 Position to column
C $951D,3 get Tower rotation position
@ $952A label=test_cell_special
c $952A Test cell special
N $952A Read the cell under the player return CY=1 with A=its $40 flag when it is a 'special' cell (type bits == 3), else NC.
N $952A Full tower-map cell bitfield format: docs/Level-Format.md.
N $952A Clobbers: A,B,HL.
@ $9540 label=check_conveyor
c $9540 Check conveyor
N $9540 Read the cell left of the player if it is a conveyor/lift tile ($85 -> +1, $89 -> -1, $8D -> 0) return that direction in A with CY set, else NC.
N $9540 Clobbers: A,HL.
@ $955B label=consume_cell
c $955B Consume cell
N $955B If the cell left of the player is a collectable (type bits==1, subtype $10) remove it from the map (LD (HL),$00).
N $955B Clobbers: A,B,HL.
C $9576,3 Play sound
@ $957A label=check_step_cell
c $957A Check step cell
N $957A Probe the cell left of the player for a step/ ledge (type bits==1, subtype $20/$30) and return its movement code (used by rotate_if_idle to auto-step).
N $957A Clobbers: A,B,HL.
C $957A,4 fetch the cell left of the player
C $957E,5 unoccupied -> NC, RET
C $9583,7 type != 1 (interactive)? -> NC, RET
C $958A,3 A = subtype bits (4-5)
C $958D,4 subtype $20? branch
C $9591,4 subtype $30? else -> NC, RET
C $9599,4 return the other step direction
b $959F
T $95B2
b $95B9
@ $95BD label=check_collisions
c $95BD Check collisions
N $95BD Test actor IX against the four object_table entries (IY walks #R$605B..) for an overlap, runs with interrupts off.
N $95BD Per entry, skips to the next one ($9648: INC IY, next loop pass) when: IY==IX (self), or state (+48) is 0/4/6/7 (inactive/certain non-collidable states).
N $95BD Otherwise does a 2-stage proximity test: angular distance |IX+0 - IY+0| (mod 128) must be small (<4, or >$7C i.e. wrapped small-negative) -- else skip; then vertical distance from the 16-bit position (IX+6/+12 vs IY+6/+12) must be within a small window (same page and delta<8, or one-page-back wrap with delta>=$F9) -- else skip.
N $95BD On proximity, resolves a per-shape collision bitmask: if the target is object index 5 (the synthetic player record, see collision_test) it's an unconditional hit (SCF); if index 4, tests a bit in table $95AE; otherwise table #R$959F -- indexed by the angular delta, bit tested via RRA loop.
N $95BD On a hit, exits via $9650 with CY=1 and HL=IY (colliding object's base pointer, since PUSH IY/POP HL runs before the final POP IY restores the caller's IY). No hit after all 4 entries: CY=0.
N $95BD Skips comparing the actor with itself.
N $95BD Clobbers: A,DE,HL,IY (IX preserved).
C $95BD,5 DI; IY -> object_table[0]; B=4 outer loop
C $95C6,16 skip if IY==IX (self)
C $95D6,3 A = target's state (+48)
C $95D9,20 skip if state is 0/4/6/7 (non-collidable)
C $95ED,10 angular distance |IX+0 - IY+0| within window?
C $9603,7 vertical delta low byte (+6)
C $960A,8 vertical delta high byte (+12) &3
C $9612,7 same page: within 8 rows?
C $961B,9 one-page-back wrap: within -7 rows?
C $9624,5 build delta+3 &7 -> table index E
C $9629,4 object index = IX low - $5B
C $962D,4 index==5 (synthetic player)? unconditional hit
C $9633,7 else pick shape table #R$959F/$95AE by index==4
C $963D,6 test bit E in shape table byte
C $9648,7 next object: INC IY, loop B
C $9650,6 exit: HL=IY (colliding object), EI, RET
@ $9657 label=read_actor_cell
c $9657 Read actor cell
N $9657 Compute the tower-map cell address for actor IX (column IX+0>>3, position IX+6/IX+12) and read the cell there the actor counterpart of player_cell_addr.
N $9657 Beyond the address/read, also classifies the result: tests the cell's type bits, then re-reads the cell one row above or below (direction chosen by the facing/movement bit at IX+54) to detect an edge. Returns A=0 (blocked/special), 1 (open) or 2 (edge in the movement direction) -- consumed by enemy_hazard_react's 0/1/else dispatch.
N $9657 Clobbers: A,HL.
C $9657,3 A = actor's angular column (IX+0)
C $965D,2 isolate row nibble
C $965F,2 bias to $F0.. row page
C $9662,3 L = actor's vertical pos low (IX+6)
C $966E,1 L -= 1 (row above)
C $966F,1 A = cell at (HL)
C $9671,3 sign bit set? -> skip to $9685
C $9674,2 mask cell type bits
C $9676,2 type == 1?
C $967B,2 test sub-bits $0C
C $9685,3 A = actor's angular column again
C $9688,2 mask to row-in-column (0..7)
C $968A,2 row < 2? -> $9694 (near top)
C $968E,2 row < 7? -> $96CC (open, no edge)
C $9694,1 A = row-page byte (H)
C $9697,1 row -= 1 (check row above)
C $969D,1 A = cell above
C $96A8,4 test facing/direction bit (IX+54)
C $96B0,1 A = row-page byte (H)
C $96B3,1 row += 1 (check row below)
C $96B9,1 A = cell below
C $96C4,4 test facing/direction bit (IX+54)
C $96CC,2 return 1 (open/no obstruction)
C $96CF,2 return 2 (edge in movement direction)
C $96D2,1 return 0 (blocked/special)
@ $96D4 label=reset_actor_phase
c $96D4
@ $96DD label=move_curve
b $96DD
@ $96E9 label=update_actor_pos
c $96E9 Update actor pos
N $96E9 Advance one actor's position around/along the tower for this frame.
N $96E9 IX = actor_obj (#R$605F).
N $96E9 Fields used: (IX+0)  angular column around the tower (accumulated mod 128) (IX+6)  vertical position, low  (sub-pixel) (IX+12) vertical position, high (0..3) (IX+18) per-frame scratch, cleared on entry (IX+42) animation/move phase 0..$0C ($FF = inactive/done) (IX+48) actor state (2,4,5,8,9 -- see transitions below) (IX+54)
C $96E9,4 IX -> actor struct base (#R$605F)
C $96ED,4 clear per-frame scratch field (+18)
C $96F1,3 A = phase (+42)
C $96F4,2 $FF = inactive -> nothing to do
C $96F7,2 phase $0C = end of move -> mark done ($FF)
C $9700,1 E = phase (table index)
C $9701,3 advance phase
C $9704,3 A = speed(+54) * 2
C $9708,3 + angular pos (+0)
C $970B,2 wrap to 0..127 (around the tower)
C $970D,3 store new angular column (+0)
C $9712,3 HL -> move_curve[phase]
C $9716,3 add curve delta to vertical-low (+6)
C $971D,3 carry into vertical-high (+12), keep 0..3
C $9727,3 Check actor collision b
C $972A,2 blocked -> mark move done
C $972C,3 Check collisions
C $9735,3 branch on actor state (+48)
C $9748,4 state 2: arm phase=$4B, state=5
C $9752,4 default: state=4, phase=0
C $9767,3 Play sound
b $976F TEXT_STRINGS
N $976F Menu / level-name / status text, #R$976F..$9952.
N $976F Each entry is [colour-control byte <$10] + ASCII + 00.
N $976F Rendered by print_string / print_centered.
T $976F
T $977F
T $978B
T $9797
T $97A6
T $97B5
T $97C6
T $97D6
T $97E6
T $97F3
T $9805
T $9810
T $981E
T $982F
T $983E
T $9850
T $985E
T $9870
T $9882
T $9894
T $98A5
T $98AF
T $98BA
T $98C8
T $98D4
T $98E2
T $98F0
T $98FA
T $9904
T $990E
T $9918
T $9927
T $9935
T $9943
b $9953
@ $9953 label=tbl_level_name
W $9953,,8
@ $9963 label=show_level_intro
c $9963 Show level intro
C $9963,3 Play title animation
C $9966,2 Start music ID 1
C $9968,3 Start music
C $996B,2 Print ">> GAME ON <<" at row $07
C $9970,3 Print string at
C $9973,2 Set print row $09
C $9975,3 Set print row
C $9978,3 Print PLAYER label
C $997B,2 Print "ENTERING THE" at row $0C
C $9980,3 Print string at
C $9983,3 Get current level number (0-7)
C $9986,1 Double for word index into level name table
C $998A,3 Point to level name pointer table (#R$9953)
C $998D,1 Add level number index
C $998E,1 Fetch low byte of level name address
C $9990,1 Fetch high byte
C $9991,1 Swap to HL
C $9992,2 Print level name at row $0E
C $9994,3 Print string at
C $9997,3 Music tick
C $999C,2 Jump to wait_frames (#R$9CF0) with A=$19
@ $99A1 label=draw_info_screen_a
c $99A1 Draw info screen a
N $99A1 Render an animated info/message screen: tick the title animation, (re)start jingle 2, and print the screen's text lines (strings at #R$981E..) via print_string_at, running the music sequencer.
N $99A1 Clobbers: most.
C $99A6,3 Start music
C $99AE,3 Print string at
C $99B3,3 Set print row
C $99B6,3 Print PLAYER label
C $99BE,3 Print string at
C $99C1,3 Music tick
C $99C8,3 Wait frames
@ $99CE label=draw_timeup_screen
c $99CE Draw timeup screen
N $99CE The time-up message display (reached from main_loop when play_timer expires): animated title bg + jingle 2 + the time-up text (string #R$9918), pumping music_tick.
C $99D3,3 Start music
C $99D8,3 Set print row
C $99DB,3 Print PLAYER label
C $99E3,3 Print string at
C $99E6,3 Music tick
@ $99F0 label=draw_info_screen_b
c $99F0 Draw info screen b
N $99F0 Another animated info screen variant (text strings #R$9894/#R$98A5), same structure as draw_info_screen_a.
C $99F8,3 Print string at
C $99FD,3 Set print row
C $9A00,3 Print PLAYER label
C $9A08,3 Print string at
C $9A10,3 Print string at
C $9A18,3 Print string at
C $9A1D,3 Wait frames
@ $9A23 label=screen_time_bonus
c $9A23 Screen time bonus
N $9A23 End-of-level bonus screen: animate the remaining play_timer counting down (update_timer_digits + blips) with wait_frames pacing, converting leftover time into score.
C $9A2B,3 Wait frames
C $9A2E,3 get Level countdown timer
C $9A33,3 set Level countdown timer
C $9A36,3 get Level countdown timer
C $9A3D,3 get Level countdown timer
C $9A43,3 set Level countdown timer
C $9A61,3 get Lives
C $9A98,3 get Lives
@ $9AD7 label=update_timer_digits
c $9AD7
C $9AF4,3 get Level countdown timer
C $9B04,3 get Lives
C $9B63,3 Print string at
C $9B6B,3 Print string at
C $9B73,3 Print string at
C $9B7B,3 Print string at
C $9B83,3 Print string at
@ $9B87 label=menu_page
b $9B87
@ $9B88 label=attract_timer
@ $9B89 label=menu_active
@ $9B8A label=title_menu
c $9B8A Title menu
N $9B8A Title screen, option menu and attract/demo loop.
N $9B8A (TASK.md guessed 'init level data' here -- WRONG verified to be the front-end.) Blits the 24-row NEBULUS logo bitmap from rt_be00 ($BE00) into the screen, paints attribute rows, and prints the option lines (1/2 PLAYER etc.) via draw_menu_text.
N $9B8A Runs proc_table as an attract demo until input, then polls the keyboard ($FE) and Kempston ($1F) for select/start.
N $9B8A Entry: ticks the background animation once, starts music 0, resets the page/timeout/active flags (#R$9B87=0 main menu page, $9B88=$C0 attract timeout, $9B89=0 not-yet-active), falls into #R$9BA5.
N $9B8A menu_page
C $9B8A,3 tick background animation once
C $9B8D,2 A = tune 0
C $9B8F,3 Start music
C $9B92,4 clear menu_page (#R$9B87=0, main menu)
C $9B96,5 attract_timer = $C0
C $9B9B,4 menu_active = 0
@ $9BA2 label=title_menu_redraw_anim
c $9BA2 Title menu redraw anim
N $9BA2 Re-ticks the background animation (falls straight into #R$9BA5) -- the re-entry point used when the attract timer flips between the menu page and the hiscore page.
@ $9BA5 label=title_menu_draw
c $9BA5 Title menu draw
N $9BA5 Draws the current page: if menu_page (#R$9B87)!=0, shows the hiscore table (draw_hiscore_screen + draw_menu_text for the CONTROLS/SOUND lines) and skips straight to the input poll ($9C23).
N $9BA5 Otherwise draws the main menu: blits the 24-row NEBULUS logo from $BE00 in 3 vertical thirds (A=0/8/16), each blitting 16 columns x 7 source bytes/column via jp_get_screen_addr paints 3 header attribute rows ($58C8/$58E8/$5908, colours $47/$46/$45) via fill_attr_row prints the 3 option lines ("1 PLAYER" etc, strings at #R$98C8/#R$98D4/#R$98E2) at rows $0C/$0E/$10 then draw_menu_text for the CONTROLS/SOUND state lines.
C $9BAB,3 Draw hiscore screen
C $9BAE,3 Draw menu text
C $9BB4,3 DE -> logo source ($BE00)
C $9BB7,2 A = 0 (vertical third counter)
C $9BBA,2 row/page base = $30+A
C $9BBF,3 jp_get_screen_addr
C $9BC2,2 B = 16 (columns this third)
C $9BE6,2 loop 16 columns
C $9BE9,2 A += 8 (next vertical third)
C $9BEB,2 done all 3 thirds?
C $9BF3,2 paint header attr row 1 ($47)
C $9BF5,3 Fill attr row
C $9BFB,2 paint header attr row 2 ($46)
C $9BFD,3 Fill attr row
C $9C03,2 paint header attr row 3 ($45)
C $9C05,3 Fill attr row
C $9C0A,3 HL -> "1 PLAYER"-ish option string
C $9C0D,3 Print string at
C $9C15,3 Print string at
C $9C1D,3 Print string at
C $9C20,3 Draw menu text
C $9C23,3 menu_active flag
C $9C29,3 Proc table
C $9C2C,3 get Signed input
C $9C32,5 menu_active = 1
C $9C37,3 Music tick
C $9C3B,5 A = keyboard row $FE, inverted, masked
C $9C42,2 nothing on keyboard -> check Kempston
C $9C44,6 Kempston: any direction or fire?
C $9C4E,2 A = 0 (idle option index)
C $9C50,3 set Game mode
C $9C53,3 Proc table
C $9C56,3 get Signed input
C $9C59,4 horizontal input? -> release-wait ($9D07)
C $9C5D,3 get Game mode
C $9C60,3 advance/wrap option index 0..4
C $9C65,2 A = key $24 ('1')
C $9C67,3 test_key
C $9C6A,2 pressed? -> 1-player start
C $9C6C,2 A = 1 (running_flag: 1 player)
C $9C6E,3 set Running flag
C $9C71,3 restart into game (#R$9BA5 draw path with running_flag set)
C $9C74,2 A = key $1C ('2')
C $9C76,3 test_key
C $9C79,2 pressed? -> 2-player start
C $9C7B,2 A = 2 (running_flag: 2 player)
C $9C7D,3 set Running flag
C $9C83,2 A = key $14 (controls toggle)
C $9C85,3 test_key
C $9C8A,3 HL -> $6056 (sound-enable/control flag)
C $9C8D,2 test bit 7
C $9C91,2 set bit 7 (toggle on)
C $9C96,2 A = key $0C (controls toggle off)
C $9C98,3 test_key
C $9C9D,3 HL -> $6056
C $9CA0,2 test bit 7
C $9CA4,2 clear bit 7 (toggle off)
C $9CA9,3 HL -> attract_timer
C $9CAC,1 decrement
C $9CAD,2 not yet expired -> keep polling
C $9CAF,2 A = 1
C $9CB4,1 flip menu_page (1-current)
C $9CB6,2 reload attract_timer = $C0
C $9CBB,3 redraw the other page
@ $9CBE label=fill_attr_row
c $9CBE Fill attr row
N $9CBE Flood-fill 16 bytes starting at HL with the byte already stored at (HL) (DE=HL+1, LDIR propagates it forward) -- paints one attribute row a single flat colour.
N $9CBE In: HL=start address (byte already set), fills 16 bytes total.
C $9CBE,3 DE = HL+1
C $9CC1,3 BC = 15 (remaining bytes)
C $9CC4,2 LDIR: propagate the seed byte forward
@ $9CC7 label=draw_menu_text
c $9CC7 Draw menu text
N $9CC7 Prints the two state-dependent menu lines: CONTROLS (row $15, text depends on running_flag==1 vs other -- 1P vs 2P control scheme) and SOUND (row $17, text depends on $6056 bit7 -- on/off).
C $9CC7,3 A = running_flag
C $9CCA,2 ==1 (single player)?
C $9CD6,3 Print string at
C $9CD9,3 A = sound-enable flag ($6056)
C $9CDF,3 HL -> "on" text
C $9CE4,3 HL -> "off" text (if flag clear)
C $9CE7,3 Print string at
@ $9CEB label=title_anim_tick
c $9CEB Title anim tick
N $9CEB One-instruction wrapper around jp_anim_bg ($A778) -- ticks the title background animation.
s $9CEF
@ $9CF0 label=wait_frames
c $9CF0 Wait frames
N $9CF0 Pause for A frames (HALT-synced), running the attract animation (proc_table) meanwhile returns early if input (input_x) arrives.
N $9CF0 #R$9CEF = frame counter.
N $9CF0 Clobbers: A,HL.
C $9CFE,3 Proc table
C $9D01,3 get Signed input
@ $9D07 label=menu_wait_release
C $9D07,3 Proc table
C $9D0A,3 get Signed input
@ $9D11 label=print_player_label
c $9D11 Print PLAYER label
N $9D11 Prints "PLAYER 1" or "PLAYER 2" (strings at #R$977F/#R$978B) depending on lives_p1 (#R$6040).
C $9D11,3 A = lives_p1 (active player index)
C $9D17,3 ==0? player 1
C $9D1A,3 else HL -> "PLAYER 2" string
C $9D1D,3 jp_print_centered
@ $9D21 label=print_string_at
c $9D21 Print string at
N $9D21 Set the print row (A) then print the string at HL, centered. Thin wrapper combining set_print_row + jp_print_centered.
C $9D21,3 set_print_row
C $9D24,3 jp_print_centered (tail call)
@ $9D27 label=set_print_row
c $9D27 Set print row
N $9D27 Set print_cursor's row to A and column to 0.
C $9D27,3 store row into print_cursor high byte
C $9D2A,1 A = 0
C $9D2B,3 store column = 0
@ $9D2F label=hiscore_entry_1
b $9D2F
N $9D2F Default hiscore table, 4 entries x 7 bytes (4 BCD score bytes + 3-char ASCII name). All 4 ship with the same "JMP" initials (programmer's easter egg) and descending round scores (#R$9D2F highest). Live-updated in place by check_hiscore (#R$9E6D) as real scores qualify -- not reloaded from tape, so scores reset each time the game is loaded.
T $9D33
@ $9D36 label=hiscore_entry_2
b $9D36
T $9D3A
@ $9D3D label=hiscore_entry_3
b $9D3D
T $9D41
@ $9D44 label=hiscore_entry_4
b $9D44
T $9D48
s $9D4B
@ $9D4C label=draw_hiscore_screen
c $9D4C Draw hiscore screen
N $9D4C Render the high-score table (the alternate title page): header string #R$9927 plus each score entry printed via print_score_entry.
N $9D4C Clobbers: most.
C $9D4C,2 A = row $06 (header)
C $9D4E,3 HL -> header string (#R$9927)
C $9D51,3 Print string at
C $9D54,3 HL -> hiscore_entry_1
C $9D57,2 C = colour $47
C $9D59,2 A = row $0A
C $9D5B,3 Print score entry
C $9D5E,3 HL -> hiscore_entry_2
C $9D61,2 C = colour $46
C $9D63,2 A = row $0C
C $9D65,3 Print score entry
C $9D68,3 HL -> hiscore_entry_3
C $9D6B,2 C = colour $45
C $9D6D,2 A = row $0E
C $9D6F,3 Print score entry
C $9D72,3 HL -> hiscore_entry_4
C $9D75,2 C = colour $44
C $9D77,2 A = row $10
C $9D79,3 Print score entry
s $9D7D
@ $9D80 label=enter_hiscore_name
c $9D80 Enter HiScore name
N $9D80 "Type your initials" screen, entered from the time-up/bonus screens (#R$99A1/#R$99F0) after a level. Checks check_hiscore first RET NC immediately if the active player's score didn't qualify.
N $9D80 On a qualifying score: seeds the new table row's 3-char name with "A  " (IX+4/5/6), stashes the row pointer at $9D7E and the letter-position counter (4/5/6, one per char) at #R$9D7D=4, then redraws the hiscore screen with prompt text and enters an input loop.
N $9D80 Per letter: waits for horizontal input release, then a fire/movement poll. Vertical/horizontal movement (input_x, added to the current letter) cycles the letter A-Z (wrapping $40/$5B boundaries) fire or continued input confirms the letter and advances the position counter, defaulting the next letter to the same value as the one just confirmed. After all 3 letters (counter reaches 7), pauses ~25 frames and returns.
N $9D80 Clobbers: most.
C $9D80,3 check_hiscore
C $9D83,1 not a qualifying score -> RET
C $9D84,4 default letter 1 = 'A'
C $9D88,4 default letter 2 = ' '
C $9D8C,4 default letter 3 = ' '
C $9D90,4 stash row pointer ($9D7E)
C $9D94,2 A = 4 (first letter-position value)
C $9D96,3 stash letter-position counter (#R$9D7D)
C $9D99,3 Title anim tick
C $9D9C,3 Draw hiscore screen
C $9D9F,2 A = row $15 (prompt line 1)
C $9DA1,3 HL -> prompt string
C $9DA4,3 Print string at
C $9DA7,2 A = row $17 (prompt line 2)
C $9DA9,3 HL -> prompt string
C $9DAC,3 Print string at
C $9DAF,1 HALT (sync)
C $9DB0,3 Proc table
C $9DB3,3 get Signed input
C $9DB7,2 horizontal input still held -> wait for release
C $9DB9,2 B = 6 (debounce frames)
C $9DBC,2 loop 6 HALTs
C $9DBE,3 Proc table
C $9DC1,3 get Signed input
C $9DC7,3 fire or horizontal input? else keep waiting
C $9DCA,3 get Signed input
C $9DCE,2 no vertical input -> confirm letter ($9DEB)
C $9DD0,4 IX -> current letter slot
C $9DD4,3 A = input_y + current letter
C $9DD7,2 wrapped below 'A'? -> wrap to 'Z'
C $9DDB,2 A = 'Z'
C $9DDF,2 wrapped past 'Z'? -> wrap to 'A'
C $9DE3,2 A = 'A'
C $9DE5,3 store adjusted letter
C $9DE8,3 loop (redraw with new letter)
C $9DEB,4 IX -> current letter slot
C $9DEF,2 IX += 1 (advance to next letter)
C $9DF1,4 store advanced pointer
C $9DF5,3 A = letter-position counter
C $9DF9,3 store advanced counter
C $9DFC,2 all 3 letters entered (counter==7)?
C $9E00,3 else: A = previous letter's final value
C $9E03,3 seed next letter with the same value
C $9E06,3 loop (redraw for next letter)
C $9E09,2 B = $19 (pause frames)
C $9E0B,1 HALT
C $9E0C,2 loop pause frames
@ $9E0F label=print_score_entry
c $9E0F Print score entry
N $9E0F Print one high-score row: cursor row A, colour C, entry record at HL (IX) formats the BCD score bytes via print_score_byte.
N $9E0F Clobbers: A,IX,...
C $9E13,3 set Current text colour/attribute
@ $9E58 label=print_score_byte
c $9E58
@ $9E65 label=print_score_nibble
s $9E6C
@ $9E6D label=check_hiscore
c $9E6D Check hiscore
N $9E6D Compare the active player's 4-byte BCD score ($6043 / $6047 by lives_p1) against the high-score table and insert it in rank order if it qualifies.
N $9E6D Runs with IRQs off.
N $9E6D Clobbers: A,IX,IY,...
C $9E6D,1 DI
C $9E70,3 get Lives
C $9E77,1 player index==0? select score buffer
C $9E7A,4 else IX -> P2 score ($6047)
C $9E7E,4 IY -> hiscore table (#R$9D2F)
C $9E82,2 B = 4 (BCD score bytes)
C $9E84,3 A = table entry byte
C $9E87,3 subtract score byte (with carry chain)
C $9E9C,2 table entry >= score? -> next entry
C $9EA1,2 IY += 7 (next table row)
C $9EA3,2 loop 4 bytes; no qualifying row -> fall through
C $9EA5,2 restore IY
C $9EA7,1 EI
C $9EA9,1 RET (no new high score)
C $9EAA,2 save insertion point (IY) into DE
C $9EAD,4 IY -> end of hiscore table (#R$9D44)
C $9EB4,1 A = low byte of IY
C $9EB6,2 not yet at insertion point? keep shifting
C $9EBA,2 reached insertion point -> store new score
C $9EBC,2 B = 7 (bytes per table row)
C $9EBE,2 shift row down: IY -= 1
C $9EC0,3 A = byte to shift
C $9EC5,3 store into next row (+6)
C $9ECA,2 loop 7 bytes; then next row down
C $9ECF,3 A = new score byte (IX)
C $9ED2,3 store into table row (IY)
C $9EE7,2 IY -> IX (restore active player's score ptr)
C $9EEB,2 restore IY
C $9EED,1 EI
C $9EEE,1 SCF (new high score inserted)
s $9EF0
T $9EF1
b $9EF9
T $9F04
s $9F0E
@ $9F11 label=init_attract_actors
c $9F11 Init attract actors
N $9F11 Set up the attract/demo actor records at #R$9EF0 (copy 5-byte template $9EFF->$9EFA, plant markers #R$9EF0=$FF, #R$9F0E=1).
N $9F11 Clobbers: A,BC,DE,HL.
C $9F26,3 Render play frame
C $9F2F,3 Attract step
@ $9F33 label=attract_step
c $9F33 Attract step
N $9F33 Advance the attract/demo one frame: silence SFX, render_play_frame, then fire scripted sounds keyed off the demo phase #R$9F0E.
N $9F33 Phase 0: sweeps a tone counter down by 2/frame until $68, then advances to phase 1 (also plays sound 3). Phase 1: cycles the 4 actor Y-offsets down by 2/frame at $9EFB, resetting a sub-counter every 9th frame, plays sound 3 every wrap, advances to phase 2 at the end. Phase 2/4: replay scripted actor-position frames from tables #R$9F04/$9F09 indexed by a frame counter ($9F0F). Phase 3: sweeps $9EFA up/down by 2/frame between bounds, plays sound 3 at each end, toggling direction via $9F10. Phase else (5+): sweeps the same tone counter back up by 2/frame until $90, then RET (attract sequence done).
N $9F33 Clobbers: most.
C $9F33,3 stash tune id / phase-0 marker ($9F10)
C $9F36,3 Stop sound
C $9F39,3 Render play frame
C $9F3C,3 A = demo phase (#R$9F0E)
C $9F3F,4 phase == 1? -> $9F6A
C $9F43,2 A = sound id 11 (phase-0 tone)
C $9F45,3 Play sound
C $9F48,3 HL -> actor Y-offsets ($9EFB)
C $9F4B,2 B = 4 (offset count)
C $9F4D,5 subtract 2 from this offset, next
C $9F52,2 loop 4 offsets
C $9F54,2 reached lower bound ($68)?
C $9F59,3 HL -> demo phase
C $9F5C,1 advance to phase 1
C $9F5F,3 reset frame sub-counter ($9F0F)=0
C $9F64,3 Play sound
C $9F6A,4 phase == 2? -> $9F97
C $9F6E,3 A = frame sub-counter
C $9F71,2 /2 -> table index
C $9F76,3 HL -> position table #R$9F04
C $9F7A,4 fetch scripted X, store ($9EF6)
C $9F7E,3 HL -> position table $9F09
C $9F82,4 fetch scripted Y, store (#R$9EF1)
C $9F86,3 HL -> frame sub-counter
C $9F89,2 advance sub-counter
C $9F8B,5 reached frame $09? -> advance to phase 2
C $9F97,4 phase == 3? -> $9FE7
C $9F9B,3 A = sweep direction flag ($9F10)
C $9F9E,3 nonzero? -> sweep up branch $9FC4
C $9FA1,5 zero flag: clear demo-actor marker (#R$9EF0)
C $9FA6,3 A = sweep value ($9EFA)
C $9FA9,5 subtract 2 (sweep down)
C $9FAE,2 reached lower bound ($54)?
C $9FB7,5 A = 8, seed frame sub-counter
C $9FBE,3 Play sound
C $9FC4,3 A = sweep value ($9EFA)
C $9FC7,5 add 2 (sweep up)
C $9FCC,2 reached upper bound ($68)?
C $9FD5,5 A = $FF, mark demo-actor active
C $9FE7,4 phase == 4? -> $A013
C $9FEB,3 A = frame sub-counter
C $A003,3 HL -> frame sub-counter
C $A006,1 decrement sub-counter
C $A007,2 underflowed (bit7 set)?
C $A00C,3 HL -> demo phase
C $A00F,1 advance to next phase
C $A013,2 A = sound id 11 (final sweep tone)
C $A015,3 Play sound
C $A018,3 HL -> actor Y-offsets ($9EFB)
C $A01B,2 B = 4 (offset count)
C $A01D,5 add 2 to this offset, next
C $A022,2 loop 4 offsets
C $A024,2 reached upper bound ($90)? done
C $9FE1,3 Play sound
C $A015,3 Play sound
@ $A02A label=render_play_frame
c $A02A Render play frame
N $A02A One frame of the in-play tower screen: setup_tower_scroll, code_ad00, wait vsync (HALT), tick the sound engine (sound_tick), draw the tower body + column strip, refresh the strip params and the scroll-wrap edge, then process the 5 actor records at #R$9EF0.
N $A02A Clobbers: most.
C $A02A,6 setup_tower_scroll / code_ad00 trampolines
C $A032,3 Sound tick
C $A035,3 draw tower body (jp_draw_tower)
C $A038,3 draw column strip (jp_draw_strip)
C $A03C,3 refresh strip params (jp_setup_strip)
C $A03F,3 scroll-wrap edge (jp_blit_scroll_wrap)
C $A042,6 IX -> demo actor records (#R$9EF0), B=5
C $A048,3 save IX/BC for this actor
C $A04B,5 marker==$FF? inactive, skip
C $A053,13 compute screen row from actor Y and row table
C $A064,6 compute screen column
C $A06B,8 off-screen (Y>=$7C)? skip
C $A073,11 clamp cell count near the bottom edge
C $A07E,1 DI
C $A07F,4 set Temporary place for SP
C $A085,11 C selects row-width variant: 1/2/3-cell
C $A090,13 --- 1-cell-wide: copy+merge 2 mask/data pairs ---
C $A09D,16 wrap to next screen row (char-cell step)
C $A0AD,5 loop B rows; done -> restore SP
C $A0B2,19 --- 2-cell-wide: copy+merge 3 mask/data pairs ---
C $A0C5,17 wrap to next screen row
C $A0D6,5 loop B rows; done -> restore SP
C $A0DB,20 --- 3-cell-wide: copy+merge 3 mask/data pairs ---
C $A0EF,3 restore L, advance H
C $A0F2,16 wrap to next screen row
C $A102,2 loop B rows
C $A104,4 get Temporary place for SP
C $A109,10 next actor, loop B=5, RET
@ $A113 label=level_shift_entry
c $A113 Level shift entry
N $A113 Entry into pstate_9, taken from pstate_4's landing code ($87E9) when game_state==3 (level transition).
N $A113 Sets pstate_phase=$FF (negative, selects pstate_9's shift-in-progress branch) and player_state=9, falls into pstate_9.
C $A115,3 set Player state-machine phase/height window
C $A11A,3 set Player state-machine state
@ $A11D label=pstate_9
c $A11D Pstate 9
N $A11D State 9: level-transition tower-column shift (slides the next section of the tower map into place after landing).
N $A11D While pstate_phase is negative: if the level-column property byte ($603A) has counted down to 6, jumps to $A15B to wait for scroll_pos to reach the wrap point (#R$6030==$03E0), then INCs pstate_phase (0, still non-negative) to end the shift on the next call.
N $A11D Otherwise: steps actor_obj column position back by 4, shifts 6 columns of the #R$F000 tower map left by one row (byte-copy loop), decrements $603A, stops the current sound and plays sound $0C -- repeats every call until the column property hits 6.
N $A11D Once pstate_phase is non-negative, falls through (next call) to #R$A170 to finish the transition.
C $A11D,3 get Player state-machine phase/height window
C $A152,3 Stop sound
C $A157,3 Play sound
C $A15B,3 get Vertical scroll position
b $A16B
N $A16B 5-byte attract-actor template, copied into the demo actor slot ($9EFA) by #R$A170.
@ $A170 label=level_shift_done
c $A170 Level shift done
N $A170 Finishes the level-transition shift (reached once pstate_9's pstate_phase goes non-negative).
N $A170 Resets the attract/demo actor state at #R$9EF0 (copies the #R$A16B template, clears the marker, sets phase 1), calls ATTRACT_STEP once, then sets game_state=4 (finished) -- the signal main_tick polls to end the transition and hand control back to main_loop's level-complete handling.
C $A187,3 Attract step
C $A18C,3 set Game state
b $A190
N $A190 Music sequencer's live state, not fixed data: stream pointer (#R$A190/91), current-note pointer ($A192/93), note-groups-remaining counter ($A194), note timer ($A195), active tune id ($A196). The DEFB values shown are just the reset state baked into the snapshot.
@ $A197 label=start_music
c $A197 Start music
N $A197 Begin music/jingle A: stash the id ($A196) then fall into init_music_seq to choose the data stream and arm the sequencer.
N $A197 In: A=tune id.
@ $A19A label=init_music_seq
c $A19A Init music sequence
N $A19A Picks one of 3 preset note-stream start addresses by tune id: 0 -> $A257 (9 note-groups), 1 -> $A269 (1 group), else -> $A26B (fallback/short stinger). Arms the stream pointer, group counter and note timer (=1, fires immediately).
C $A19D,5 id==0 -> stream $A257, 9 groups
C $A1A5,5 id==1 -> stream $A269, 1 group
C $A1AD,3 else -> stream $A26B (same group count)
C $A1B0,9 arm stream pointer, group counter, note timer
@ $A1BD label=music_tick
c $A1BD Music tick
N $A1BD Per-frame music sequencer step (DI around it).
N $A1BD When the note timer ($A195) elapses, fetch the next event from the stream (#R$A190), update the current note ($A192), and play it.
N $A1BD A $FF note byte ends the current group: decrements the group counter ($A194) and loops to the next group if any remain, otherwise either holds the last note (tune id==0) or restarts via init_music_seq (id!=0, one-shot jingles loop back to their own start).
N $A1BD Otherwise the note byte indexes two parallel tables at #R$A238 (or $A23A, selected by the Specialist-beeper flag $6056) for a period value and #R$A249 (an 11-char string used as a duration/shape lookup) for a tone-loop shape, then bit-bangs OUT ($FE) via an inlined tone loop (same shape as sfx_tone).
N $A1BD The Specialist has a 1-bit beeper too -- retarget the port and retune the delay loops.
C $A1C8,3 HL -> stream pointer, fetch next 16-bit event
C $A1D6,4 A = current note byte
C $A1DA,2 $FF = end of note-group
C $A1E1,3 decrement group counter
C $A1E4,7 last group done: id==0 -> hold, else -> restart tune
C $A1EB,3 Init music sequence
C $A1F4,10 index period table $A237+note, select beeper variant via $6056
C $A21B,29 inlined tone-loop bit-bang (OUT $FE), shaped by duration string byte
b $A238
N $A238 Two parallel 8-entry period/duration tables (ZX at #R$A238, alternate "Specialist" beeper variant at $A240), indexed by note code and selected via $6056.
T $A249
N $A249 11-char duration/shape string, one char per note code: each character's ASCII value supplies the H/L sub-loop counts for music_tick's inlined tone loop.
b $A254
N $A254 A second, shorter period/shape table pair (1 byte + 3 chars) -- sparse coverage, likely only used by a short jingle's reduced note set.
T $A255
b $A258
N $A258 Real note-stream data starts one byte earlier, at $A257 (see init_music_seq): $A257 (9-group stream), $A269 (1-group stream) and $A26B (fallback stream) are literal entry addresses into this block, not a lookup table.
N $A258 Byte values are note codes (indices into the #R$A238/#R$A249 tables) $FF marks the end of a note-group. Runs through $A367 the final 5 bytes ($A368-$A36C) are SFX-engine state (active effect id/pointer/priority), not music data.
@ $A36D label=stop_sound
c $A36D Stop sound
N $A36D Silences the current SFX effect by marking $A368=$FF (sound_tick's "active marker" gate).
@ $A373 label=snd_ptr_table
b $A373
N $A373 13 pointer words (ids 0..$0C, matching play_sound's "id<$0D" range), one per sound effect, resolved by lookup_sound.
@ $A38D label=snd_effect_data
b $A38D
N $A38D The 13 effects' byte streams, back-to-back, addressed via snd_ptr_table. Each stream starts with 2 header bytes (priority, then a repeat/duration count copied into $A36C) followed by command/data bytes consumed by sound_tick: values <$80 are raw tone/length data for sfx_tone values $80/$81/$C8/$C9/$CA are specific ops (noise burst, random tone, etc., handled at #R$A48A/#R$A470/#R$A4BF/#R$A52E/#R$A4F2) values $82..$C7 go through the generic handler at #R$A493 anything else ends the effect.
@ $A3DE label=play_sound
c $A3DE Play sound
N $A3DE Trigger sound effect A (id < $0D).
N $A3DE Saves all regs, looks up the effect via lookup_sound, and (subject to a priority check against the currently playing effect at $A368/$A369) latches its data pointer at $A36A for sound_tick to play out.
N $A3DE In: A=effect id.
N $A3DE Preserves all registers.
N $A3DE Most-called audio API.
@ $A40B label=lookup_sound
c $A40B
@ $A41C label=sound_tick
c $A41C Sound tick
N $A41C Per-frame SFX engine step.
N $A41C Gated by the sound-enable flag ($6056) and the active marker ($A368).
N $A41C Reads the next byte of the current effect (pointer $A36A), interpreting commands (>=$80) vs tone/length data, and emits to the speaker.
N $A41C The Specialist has a 1-bit beeper too -- retarget the port and retune the delay loops.
C $A41C,3 sound-enable flag; off -> RET
C $A423,5 no active effect -> RET
C $A42B,8 fetch next command/data byte from the effect stream
C $A433,2 raw data (<$80)? -> SFX tone
C $A445,3 SFX_ROM_NOISE
C $A458,5 else dispatch on command byte ($82-$C7 -> generic handler)
C $A462,3 SFX tone
c $A470
c $A48A
C $A48E,3 SFX noise
c $A493
@ $A4AD label=sfx_noise
c $A4AD SFX noise
N $A4AD White-noise burst: XORs the refresh register R into the speaker bit and toggles OUT ($FE) for DE iterations.
N $A4AD The Specialist has a 1-bit beeper too -- retarget the port and retune the delay loops.
@ $A4BF label=sfx_rom_noise
c $A4BF SFX_ROM_NOISE
N $A4BF Noise burst sourced from ROM bytes at $8000+ (game code, used as pseudo-random data) rather than the R register: steps through with a random increment each read, OUTs bit 4 of each byte to the speaker, for BC=$7A iterations.
C $A4BF,4 save AF; A = random step (jp_random)
C $A4C4,6 HL -> $8000, BC = $7A (iteration count)
C $A4CA,5 speaker bit = byte's bit 4
C $A4CF,3 HL += random step
C $A4EA,6 loop BC iterations
c $A4F2
C $A509,3 SFX tone
c $A50E
s $A518
@ $A519 label=sfx_random_tone
c $A519
C $A529,3 SFX tone
c $A52E
C $A534,3 SFX tone
@ $A539 label=sfx_tone
c $A539 SFX tone
N $A539 Emit a square-wave tone: pitch index A selects a half-period from table #R$A560 toggles the speaker for a fixed duration ($0148 outer).
N $A539 In: A=pitch.
N $A539 Clobbers: A,BC,DE,HL,AF'.
N $A539 The Specialist has a 1-bit beeper too -- retarget the port and retune the delay loops.
T $A560
b $A568
T $A569
b $A575
@ $A584 label=buffer_a584
@ $A700 label=proc_table
c $A700 Proc table
N $A700 Jump/trampoline dispatch table, 53 entries, each 'JP nnnn', 3 bytes.
N $A700 The game CALLs these fixed slots instead of the moving routine bodies a CALL <slot> costs one extra JP.
@ $A703 label=jp_scan_keys
C $A703,3
@ $A706 label=jp_test_key
C $A706,3
C $A706,3 -> test_key: A=key id, returns Z if pressed
@ $A709 label=jp_poll_any_key
C $A709,3
@ $A70C label=jp_wait_no_key
@ $A70F label=jp_test_break
C $A70F,3
@ $A712 label=jp_delay
C $A712,3
@ $A715 label=jp_random
C $A715,3
@ $A718 label=jp_save_regs
C $A718,3
@ $A71B label=jp_restore_regs
@ $A71E label=jp_setup_attrs
C $A71E,3 -> setup_attrs: paint playfield attributes + PLAYER labels
@ $A721 label=jp_reset_score
C $A721,3
@ $A724 label=jp_draw_hud
C $A724,3
@ $A727 label=jp_add_score
C $A727,3
@ $A72A label=jp_init_bonus
C $A72A,3
@ $A72D label=jp_bonus_sub
C $A72D,3
@ $A730 label=jp_field_604f_add
C $A730,3
@ $A733 label=jp_set_level_timer
C $A733,3
@ $A736 label=jp_tick_timer
C $A736,3
@ $A739 label=jp_draw_timer
C $A739,3
@ $A73C label=jp_print_char_at
C $A73C,3
@ $A73F label=jp_print_char
C $A73F,3
@ $A742 label=jp_print_str_loop
C $A742,3
@ $A745 label=jp_print_centered
C $A745,3
@ $A748 label=jp_set_print_pos
C $A748,3
@ $A74B label=jp_clear_obj_table
@ $A74E label=jp_calc_col_addr
@ $A751 label=jp_col_visible
C $A751,3
@ $A754 label=jp_blit_scroll_wrap
C $A754,3
@ $A757 label=jp_code_ad00
C $A757,3
@ $A75A label=jp_anim_bg
C $A75A,3
@ $A75D label=jp_setup_scroll
C $A75D,3
@ $A760 label=jp_draw_tower
C $A760,3
@ $A763 label=jp_load_level_col
C $A763,3
@ $A766 label=jp_alloc_slot
C $A766,3
@ $A769 label=jp_update_objects
C $A769,3
@ $A76C label=jp_free_object
C $A76C,3
@ $A76F label=jp_update_actors
C $A76F,3
@ $A772 label=jp_clear_screen
C $A772,3 -> clear_screen: wipe display + game RAM, build LUT
@ $A775 label=jp_build_hi_lut
@ $A778 label=jp_clear_playfield
C $A778,3
@ $A77B label=jp_hook_noop
C $A77B,3
@ $A77E label=jp_init_b5cf
C $A77E,3
@ $A781 label=jp_get_screen_addr
C $A781,3
@ $A784 label=jp_get_sprite_def
C $A784,3
@ $A787 label=jp_select_sprite
C $A787,3
@ $A78A label=jp_draw_actor
C $A78A,3
@ $A78D label=jp_actor_screen_y
C $A78D,3
@ $A790 label=jp_draw_pending
C $A790,3
@ $A793 label=jp_setup_strip
C $A793,3
@ $A796 label=jp_draw_strip
C $A796,3
@ $A799 label=jp_paint_attrs
C $A799,3
@ $A79C label=jp_scroll_attrs
C $A79C,3
@ $A79F label=read_input
c $A79F Read input
N $A79F Proc_table[0]: sample controls into the signed input_x/input_y/input_fire vars.
N $A79F Only active when game_mode (#R$6017) == 4 (in play) otherwise returns.
N $A79F Reads the Kempston joystick and converts each axis to -1/0/+1 via bit tests + SBC/NEG.
N $A79F The Specialist has no Kempston port -- replace read_joystick with the target's keyboard/joystick scan, keeping the -1/0/+1 result.
C $A79F,3 A = game_mode (#R$6017)
C $A7A4,2 only read controls while in play (mode 4)
C $A7A6,3 A = raw joystick bits
C $A7B2,3 input_y = -1/0/+1
C $A7C0,3 input_fire = -1/0/+1 (negated)
C $A7C4,3 input_x = -1/0/+1
@ $A7C8 label=read_joystick
c $A7C8
C $A7C8,2 read Kempston joystick port $1F (Z80 IN
C $A7CC,2 all 5 bits = nothing pressed
b $A7D1
@ $A7ED label=scan_control_keys
c $A7ED Scan control keys
N $A7ED Read one 5-key control set into the flag array at $6018.
N $A7ED A selects the set: index a word-pointer table at $A7E5 (A*2) to a 5-byte key-id list, then test_key each one, storing 0/1 into $6018..#R$601C.
N $A7ED Used to read the redefinable keys.
N $A7ED In: A=set index.
N $A7ED Out: $6018[0..4] flags.
N $A7ED Clobbers: A,B,DE,HL.
C $A7FE,3 Test key
C $A813,3 set Signed input
C $A81B,3 set Signed input
@ $A81F label=test_key
c $A81F Test key
N $A81F Is a specific key down?
N $A81F (proc_table slot $A706.) In:  A = key id, encoded (row<<3 | column) into the ZX keyboard matrix.
N $A81F Out: Z set (A=0) if the key is pressed.
N $A81F Builds the half-row select on the address bus (A=$FE rotated <row> times so one of A8..A15 is low) and reads ULA port $FE rotates out <column> bits and tests the active-low key bit.
C $A820,1 C = key id
C $A821,2 low 3 bits = column -> bit count
C $A825,2 C >>= 3 -> row index
C $A82D,1 5 - row -> number of rotates for the row select
C $A82F,2 A = $FE: one address line low selects a keyboard half-row
C $A831,1 rotate the low bit into the row position (DJNZ)
C $A834,2 read ULA keyboard port $FE (Z80 IN
C $A836,1 shift out columns
C $A83B,2 carry set = not pressed -> A=1
@ $A840 label=poll_any_key
c $A840 Poll any key
N $A840 Return NZ if ANY input is active: scans the five keyboard half-rows via IN ($FE) (CPL+AND $1F), and if none, tests the Kempston fire bit ($10).
N $A840 Out: A/flags NZ = pressed.
@ $A84D label=wait_no_key
C $A84D,3 Poll any key
@ $A853 label=test_break_key
c $A853 Test break key
N $A853 Test the BREAK combination (CAPS SHIFT + SPACE) via two IN ($FE) row reads.
N $A853 Returns with CARRY CLEAR only when both are held (used to abort).
N $A853 Clobbers: A.
@ $A85F label=delay_loop
c $A85F Delay loop
N $A85F Busy-wait: B outer iterations of a ~$0086 inner countdown.
N $A85F In: B=outer count.
N $A85F Clobbers: A,B,HL (HL preserved).
@ $A86C label=next_random
c $A86C Next random
N $A86C Pseudo-random generator.
N $A86C Reads the 16-bit seed (#R$6002), applies a multiply/shift + add $0029 LCG step, writes the new seed back, and returns A = high byte.
N $A86C Out: A=random byte, (#R$6002) advanced.
N $A86C Clobbers: A,DE,HL.
C $A86E,4 get 16-bit LCG seed
C $A882,3 set 16-bit LCG seed
@ $A889 label=save_regs_frame
c $A889 Save regs frame
N $A889 Paired full CPU-context save and restore.
N $A889 save_regs_frame pushes main+alternate register sets, IX, IY (EX AF,AF'/EXX to reach the shadow bank), then reads a 16-bit value out of the saved frame ($SP+$17) into HL before returning.
c $A8A5 Restore regs frame
N $A8A5 Pops all registers back.
@ $A8A5 label=restore_regs_frame
N $A8B7 Initial values for #R$6053
@ $A8B7 label=tbl_play_timer_init
W $A8B7,,8
@ $A8C7 label=str_player1
T $A8C7
B $A8CF,1,1
@ $A8D0 label=str_player2
T $A8D0
B $A8D8,1,1
@ $A8D9 label=attr_rle
b $A8D9
@ $A8EB label=setup_attrs
c $A8EB Setup attrs
N $A8EB Paint the static playfield attribute layout and the two PLAYER score labels.
N $A8EB Run once at start (via jp_setup_attrs).
N $A8EB Reads attr_rle (9 run-length [count,attr] pairs) and floods the attribute area $5800+ with attr|$40 (BRIGHT set on every cell).
N $A8EB Then prints the PLAYER 1 / PLAYER 2 strings and seeds two score/counter widgets via helper calls.
N $A8EB In: nothing.
N $A8EB Clobbers: A,BC,DE,HL.
C $A8EB,2 A = $FF
C $A8ED,3 store $FF to a flag at #R$60C8
C $A8F0,3 HL -> attr_rle (run-length attribute table)
C $A8F3,3 DE -> $5800 = attribute area base
C $A8F6,2 C = 9 outer groups
C $A8F8,1 B = run length for this group
C $A8FA,1 A = attribute byte for this group
C $A8FB,2 force BRIGHT bit ($40) on
C $A8FE,1 write attr to cell
C $A903,2 next group until C groups done
C $A905,3 HL -> 'PLAYER 1' string
C $A908,3 BC = 0x0000 = attr/screen position arg
C $A90B,3 Print string
C $A90E,3 BC = 0x1800 = position for 'PLAYER 2'
C $A911,3 Print string
C $A927,3 Draw HUD bar
C $A92D,3 Draw HUD bar
C $A930,3 Reset score state
C $A933,3 tail-jump into the next setup step
@ $A936 label=draw_hud_bar
c $A936 Draw HUD bar
N $A936 At the print position in BC, print 8 copies of glyph $81 (a solid block) -- the score-panel divider bar.
N $A936 In: BC=print pos.
N $A936 Clobbers: A,B.
C $A93D,3 Print char
@ $A943 label=reset_score_state
c $A943 Reset score state
N $A943 Init the score/lives HUD state for a new game: lives_p2 (#R$6041)=3, $6042=3, $60C2=0, and zero the 8-byte block $6043..$604A (the two 4-byte BCD score buffers).
N $A943 Reached from proc_table slot $A721 (JP) and from $A930 (CALL, then falls through to draw_hud_counters).
C $A945,3 set Lives
@ $A959 label=draw_hud_counters
c $A959 Draw HUD counters
N $A959 Paint the score/lives panel.
N $A959 Sets the '1UP'/'2UP' marker attribute cells (toggled by lives_p1), then prints lives_p2/$6042 as 2-digit decimals and the two BCD score buffers via set_print_pos + print_bcd_byte.
N $A959 Clobbers: A,BC,DE,HL.
C $A95B,3 set Current text colour/attribute
C $A961,3 get Lives
C $A975,3 get Lives
C $A98A,3 Print score field
@ $A993 label=print_score_field
c $A993 Print score field
N $A993 Position the cursor (BC) then print a 2-byte (4-digit) BCD value at HL via print_bcd_word.
N $A993 In: BC=pos, HL=MSB.
@ $A999 label=print_bcd_word
@ $A99C label=print_bcd_byte
@ $A9A6 label=print_nibble
@ $A9AD label=draw_gauge8
c $A9AD
@ $A9BD label=add_bcd_score
c $A9BD Add BCD score
N $A9BD Add HL (16-bit BCD delta) to the active player's 4-byte BCD score (lives_p1 selects $6043 or $6047), with DAA carry propagation across all 4 bytes.
N $A9BD In: HL=BCD delta, lives_p1=index.
N $A9BD Clobbers: A,B,C,DE.
C $A9C0,3 get Lives
C $A9F9,3 get Lives
@ $AA08 label=init_bonus
c $AA08 Init bonus
N $AA08 Seed the active player's (lives_p1 index) bonus/ accumulator block at $604B: bonus = BCD 0100, $604F-side cleared.
N $AA08 Clobbers: A,HL.
C $AA0B,3 get Lives
@ $AA21 label=bonus_sub
c $AA21 Bonus sub
N $AA21 BCD-subtract B from the active player's bonus value ($604B, 2 bytes), clamping at 0 on underflow (RET NC else zero it).
N $AA21 In: A/B=BCD amount.
N $AA21 Clobbers: A,B,HL.
C $AA25,3 get Lives
@ $AA3D label=field_604f_add
c $AA3D Add to bonus field 604F
N $AA3D BCD-add B to the active player's 2-byte field at $604F, saturating: high byte hitting 6 resets to 05/low=00.
N $AA3D In: A/B=BCD amount.
N $AA3D Clobbers: A,B,HL.
C $AA41,3 get Lives
@ $AA5B label=set_level_timer
c $AA5B Set level timer
N $AA5B Load play_timer from the word table at #R$A8B7 indexed by (#R$6039)*2 (per-level start time), then fall into #R$AA96 to show it.
N $AA5B Clobbers: A,DE,HL.
C $AA69,4 set Level countdown timer
@ $AA70 label=tick_timer
c $AA70 Tick timer
N $AA70 Prescaled level-timer countdown.
N $AA70 #R$6055 counts 0..4 only every 5th call does it BCD-decrement play_timer (2 bytes, clamped at 0) and redraw via draw_timer.
N $AA70 RET M while prescaler is negative (timer disabled).
N $AA70 Clobbers: A,HL.
C $AA93,3 set Level timer prescaler
@ $AA96 label=draw_timer
c $AA96 Draw timer
N $AA96 Print the 2-byte BCD play_timer ($6054) as decimal digits at print row $0E (white).
N $AA96 Uses print_2digits/print_digit.
N $AA96 Clobbers: A,BC,HL.
C $AA98,3 set Current text colour/attribute
C $AA9E,3 Set print pos
@ $AAA8 label=print_2digits
@ $AAB1 label=print_digit
@ $AAB8 label=punct_map
b $AAB8
T $AABA
b $AABE
@ $AAC2 label=print_char_at
@ $AAC5 label=print_char
c $AAC5 Print char
N $AAC5 Render one character at the current text cursor.
N $AAC5 In:  A = character code.
N $AAC5 >=$80 : direct glyph index (graphics char), A&$7F.
N $AAC5 'A'..'Z' : glyph = (A-'A')+2.
N $AAC5 '0'..'9' : glyph = (A-'0')+$1C.
N $AAC5 <$10     : colour/attribute control code -> cur_color.
N $AAC5 else     : looked up in punct_map.
N $AAC5 cursor in print_cursor (#R$60C6 lo=col) cur_color (#R$60C8).
N $AAC5 Out: glyph blitted to screen column cursor ($60C7) advanced.
C $AAC5,1 save all regs (caller-transparent)
C $AAC9,2 bit7 set? -> direct graphics glyph index
C $AACD,2 strip bit7, use as glyph index
C $AAD1,2 'A'($41)..'Z'($5A)?
C $AAD9,2 glyph = (A-'A') + 2  (letters start at glyph 2)
C $AADF,2 '0'($30)..'9'($39)?
C $AAE7,2 glyph = (A-'0') + $1C  (digits start at glyph $1C)
C $AAED,2 code <$10? -> colour control code
C $AAF2,2 ink = A & 7
C $AAF4,2 bit3 of code = BRIGHT -> OR $40
C $AAFA,3 store into cur_color (#R$60C8)
C $AAFF,3 HL -> punct_map (5 entries)
C $AB04,1 compare code against each map char
C $AB0E,1 matched: A = glyph index from map
@ $AB0F label=glyph_addr
C $AB0F,1 L = glyph index
C $AB10,1 A = index*6 via index + index*2, then *2 (6 bytes/glyph)
C $AB13,1 HL = index*6
C $AB16,3 DE = #R$C000 = font base
C $AB19,1 HL -> glyph bitmap (6 bytes)
C $AB1B,4 BC = print_cursor (C=column 0..31)
@ $AB1F label=glyph_blit
C $AB1F,1 A = column
C $AB20,2 H = (col & $18) | $40 : screen-addr high byte (third+page)
C $AB28,2 OR $58 -> D = matching attribute-area high byte ($58xx)
C $AB34,3 A = cur_color
C $AB37,2 $FF = 'transparent' -> skip attribute write
C $AB3B,1 write colour to attribute cell
C $AB3D,2 blank top scanline of the cell
C $AB3F,1 INC H = step down one pixel row (Z80 ZX adjacency)
C $AB40,2 B = 6 font rows
C $AB42,1 copy one font row to screen
C $AB48,2 blank bottom scanline
C $AB4D,1 advance column cursor ($60C7)
@ $AB53 label=print_string
c $AB53 Print string
N $AB53 Print an ASCIIZ string at position BC.
N $AB53 In: HL=string (00-terminated), BC=cursor pos.
N $AB53 Out: HL past terminator.
C $AB53,3 set cursor = BC
@ $AB56 label=print_string_loop
C $AB56,1 A = next char
C $AB58,1 00 terminator?
C $AB59,1 done (ASCIIZ) -- RET on Z
C $AB5A,3 Print char
C $AB5D,2 next char
@ $AB5F label=print_centered
c $AB5F Print centered
C $AB60,2 C = visible-char count
C $AB66,2 ignore codes <$10 (colour controls) in the count
C $AB6E,2 A = 32 - count
C $AB71,1 RRA = /2 = left margin
C $AB72,3 store as start column ($60C7)
@ $AB7A label=set_print_pos
c $AB7A Set print pos
@ $AB7F label=clear_obj_table
c $AB7F Clear obj table
@ $AB97 label=calc_tower_col_addr
c $AB97 Calc tower col addr
N $AB97 Compute a byte address inside the $6400 tower/column buffer from disp_height (&7, *24) and scroll_pos, returning the slot pointer(s) for column rendering.
N $AB97 Clobbers: A,BC,DE,HL.
C $AB97,10 row offset = (disp_height&7)*24 into $6400
C $ABA9,8 column offset, wrapped mod $60 (96)
C $ABB2,4 HL -> $6400+offset (primary column pointer)
C $ABB6,3 get Vertical scroll position
C $ABB9,5 scroll_pos bit2 selects HL/DE swap
C $ABBE,56 copy 2x12-byte snapshot from HL/DE into $6463/$6475 scratch
C $ABF6,8 HL/DE -> $6463/$6487, A=$12 repeat count
C $ABFE,36 duplicate the 24-byte snapshot forward (stride 12) to extend the strip buffer
@ $AC22 label=col_visible_offset
c $AC22 Col visible offset
N $AC22 Compute the on-screen column offset of the object at #R$60BA relative to scroll_pos, folded into the 4-quadrant (mod $03) tower wrap.
N $AC22 Returns A=offset (RET Z if off-screen).
N $AC22 Clobbers: A,B,DE,HL.
C $AC22,13 HL = object position ($60BA), biased and wrapped mod 4
C $AC31,4 get Vertical scroll position
C $AC35,7 delta = position - scroll_pos
C $AC44,2 zero delta -> RET (off-screen)
C $AC46,4 fold delta to an on-screen column offset
C $AC52,11 apply the offset back into scroll_pos, wrapped mod 4
@ $AC5E label=blit_scroll_wrap
c $AC5E Blit scroll wrap
N $AC5E When scroll_pos has wrapped past the top (H==$03 && L>=$D8), fast-fill the newly exposed strip using the LD SP,screen / stack-write trick (saves real SP to #R$6000, DI, reads mask_acb0).
N $AC5E RET early when no wrap is pending.
C $AC74,3 Get screen addr
C $AC78,4 set Temporary place for SP
C $ACAA,4 get Temporary place for SP
@ $ACB0 label=mask_acb0
b $ACB0
@ $AD00 label=code_ad00
c $AD00 Clear object list near scroll seam
N $AD00 Called every frame from render_play_frame, before setup_tower_scroll.
N $AD00 Reads scroll_pos and checks whether it is near the tower's top or bottom wrap seam (two symmetric branches on the high byte, biased by +$15/+$13 and compared against the $603A level-column threshold). If near an edge, computes an overshoot count C and zero-fills C*9 bytes at $6460+ -- clearing stale object/sprite-list entries that would otherwise linger once the visible column range shrinks near the seam. If not near an edge (C==0), returns immediately.
N $AD00 Clobbers: A,BC,DE,HL.
C $AD00,2 C = 0 (default: no overshoot)
C $AD02,3 get Vertical scroll position
C $AD05,5 near the top seam (H==3)?
C $AD0A,5 low byte far from the wrap point ($D8)? skip
C $AD0F,7 fold scroll_pos to a coarse row (>>2)
C $AD16,2 bias by $15 (top-seam offset)
C $AD1B,1 compare vs level-column threshold ($603A)
C $AD1E,5 overshoot = row-1 - threshold
C $AD23,13 bottom-seam mirror: fold, bias by $13, compare
C $AD35,3 A = overshoot count; none -> RET
C $AD39,6 count*9 -> BC (9 bytes per overshoot unit)
C $AD48,2 seed first byte = 0
C $AD4A,2 LDIR: zero-fill BC bytes at $6460 (stale slot cleanup)
@ $AD4E label=anim_bg_phase
c $AD4E Anim bg phase
N $AD4E Advance the background animation phase counter ($603D) on the wrap point reload $603C with $08 (animation restart).
N $AD4E Clobbers: A,HL.
b $AD60
N $AD60 Self-modified scratch, not pure data: #R$AD60/$AD61 are 1-byte accumulators seeded by setup_tower_scroll ($ADA1/$ADAF) with a row-start bias and a fine row offset, then incremented every pass of setup_tower_scroll's row loop ($AE6E-$AE81) by table bytes stored at $AD62..$AD80 (16 rows x 2-byte deltas) -- i.e. a per-row coarse/fine screen-row stepping table, not just static data.
@ $AD82 label=setup_tower_scroll
c $AD82 Setup tower scroll
N $AD82 Per-frame scroll/render setup.
N $AD82 Clears the object table, derives the coarse column ($ADC6) and sub-column fraction ($6021) from scroll_pos, and the row base ($AD61) from disp_height.
N $AD82 SELF-MODIFIES the render code ($ADC6/$AD61) and latches $6021 for draw_tower_cols.
N $AD82 Runs a 16-row loop ($ADB8..$AE85): for each row it reads two per-column-cell nibbles from map data at #R$6200+DE / $6280+DE, classifies the cell (bit-pattern tests at $AE21-$AE67) and jumps to one of the masked-blit handlers below (#R$AEBB/#R$AF2A/#R$AF86/#R$AFD0/#R$B03F) or straight to the row-accumulator advance at $AE6D. Each handler returns to the common continuation $AE18 (advance HL by -$12, DJNZ loop) before the next row.
N $AD82 Clobbers: A,C,HL.
C $AD82,3 clear object table (calc_tower_col_addr's prep)
C $AD85,3 get Vertical scroll position
C $AD89,2 shift scroll_pos right by 3 (coarse column)
C $AD8F,3 self-mod store: coarse column ($ADC6)
C $AD93,2 isolate sub-column fraction bits
C $AD96,3 latch sub-column phase ($6021)
C $AD99,3 get Display height
C $AD9D,2 isolate row-in-cell bits (disp_height&7)
C $AD9F,2 bias by $58 (attribute-row base)
C $ADA1,3 self-mod store: row base ($AD61)
C $ADA4,2 C = disp_height >> 3 (coarse row)
C $ADAA,2 A = $0B - coarse row
C $ADAD,2 mask to 4 bits
C $ADAF,3 self-mod store: row accumulator (#R$AD60)
C $ADB3,2 B = 0 (row counter)
C $ADB5,3 HL -> per-row delta table ($AD62)
C $ADB8,1 A = row counter
C $ADB9,5 row==8? recompute column addr mid-loop
C $ADC0,3 Calc tower col addr
C $ADC5,2 E = 0 (cell index low)
C $ADC7,5 D = row accumulator + $F0 (map page)
C $ADCE,4 E = column fraction (map offset low)
C $ADD4,4 HL -> #R$6200 + column (cell type table 1)
C $ADD9,4 negative? -> $AE6D (empty cell, skip)
C $ADDD,4 shift cell nibble right 2
C $ADE1,6 self-mod: patch two render-handler operands
C $ADE7,3 A = cell byte again, mask low 2 bits
C $ADEA,6 self-mod: patch two more render-handler operands
C $ADF0,4 HL -> $6280 + column (cell type table 2)
C $ADF6,3 negative? skip the shift
C $ADF9,2 shift cell nibble right 2
C $ADFD,6 self-mod: patch two render-handler operands
C $AE03,3 A = 2nd cell byte, mask low 2 bits
C $AE06,6 self-mod: patch two more render-handler operands
C $AE0C,2 B = $14 (20 sub-cells to classify)
C $AE0E,3 HL -> classification bitmap ($65B6)
C $AE11,4 fetch next classification bit
C $AE15,1 shift bit into carry
C $AE18,3 DE = -$12 (back up dest ptr)
C $AE1C,2 loop 20 sub-cells
C $AE21,1 shift in the next bit
C $AE22,1 C = classification byte so far
C $AE23,2 test bits $0C (cell sub-type)
C $AE27,2 test bit 0 of C
C $AE2C,2 mask to bits 0-1
C $AE2E,2 shift right (test bit 0)
C $AE30,2 nonzero -> $AE55 (anim-texture case)
C $AE32,2 no carry -> $AE3F (cap-b case)
C $AE34,3 self-mod operand for the handler call
C $AE37,2 test bit 7 of E
C $AE39,3 dispatch -> render_col_cap_a
C $AE55,2 carry set -> $AE62 (partial-column case)
C $AE62,3 A = row base
C $AE65,2 compare vs $40 (screen-half boundary)
C $AE67,3 dispatch -> render_col_partial
C $AE6D,1 EXX back to main register set
C $AE6E,3 A = row accumulator
C $AE71,3 add per-row delta, wrap to 4 bits
C $AE74,3 store updated row accumulator
C $AE78,3 A = fine row offset
C $AE7B,3 add per-row delta, wrap to 7 bits
C $AE7E,3 store updated fine row offset
C $AE82,1 B++ (row counter)
C $AE83,2 done all 16 rows?
@ $AE89 label=col_blit_masks
b $AE89
N $AE89 24-entry (2 bytes each) AND/OR mask-pair table: "AND clear old bits, OR in new bits" merge masks for column pixel bytes that don't align to a whole screen byte (edge-clipped column tops/bottoms). Read by the handler at #R$AEBB.
@ $AEBB label=render_col_partial
c $AEBB Render col partial
N $AEBB One of setup_tower_scroll's five per-cell render handlers -- the "partial/short column" case.
N $AEBB Looks up a length adjustment (table $6300) and an edge-type value (table $6340) indexed by the column (DE), computes and self-mod-stores a destination pointer ($AEB9), then masked-merges the destination byte(s) using mask pairs picked from col_blit_masks (#R$AE89, 16-entry branch for tall/negative case) or from a second 4-entry table at $AEA9 (short/positive case), plus a run of up to 3 plain-store bytes and a final 2-entry table ($AEB1) merge.
N $AEBB Ends by jumping back to setup_tower_scroll's row loop continuation ($AE18).
N $AEBB Clobbers: A,DE,HL.
C $AEBB,9 DE=A; HL -> length table $6300+DE
C $AEC4,9 length+3 -> destination byte offset
C $AECD,3 self-mod store: destination pointer ($AEB9)
C $AED0,6 HL -> edge-type table $6340+DE
C $AED6,3 sign bit set? -> short/positive branch
C $AED9,12 tall branch: index col_blit_masks (#R$AE89) by (type&$0F)*2
C $AEE5,10 AND/OR merge one byte, restore regs, return
C $AEEF,13 short branch: index 2nd mask table $AEA9 by (type&3)*2
C $AEFC,6 AND/OR merge first byte, advance DE
C $AF02,3 C = type; test bits $30 (extra-byte count)
C $AF07,14 write 0/1/2 plain bytes depending on $30 bits
C $AF15,10 C = (type>>1)&$06 -> index final 2-entry table $AEB1
C $AF20,7 AND/OR merge last byte, restore regs, return
c $AF2A Render col cap a
N $AF2A Another per-cell render handler, selected for a specific column-edge sub-case (DE==0 test in setup_tower_scroll's classification).
N $AF2A 4-way branch on a self-mod test byte ($AF2C/$AF2E, patched by setup_tower_scroll at $ADEA/$ADED). Each branch writes 3 destination bytes with mostly-fixed bit patterns (pre-rendered tower-cap/edge tile graphics) merged via AND/OR masks at the first/last byte to blend with the adjacent column.
N $AF2A Ends `POP HL / JP $AE18` in all 4 branches.
C $AF2A,1 save dest ptr
C $AF2B,1 HL += DE (apply column offset)
C $AF2C,2 A = self-mod test byte
C $AF2E,2 shift test byte -> Z/C flags
C $AF30,3 nonzero -> branch 3/4 ($AF57)
C $AF33,3 carry set -> branch 2 ($AF42)
C $AF36,2 branch 1: fixed byte 1 ($1B)
C $AF39,2 fixed byte 2 ($FB)
C $AF3C,2 fixed byte 3 ($A4)
C $AF3E,1 restore dest ptr
C $AF3F,3 done -> setup_tower_scroll continuation
C $AF42,1 branch 2: A = dest byte 1
C $AF43,2 keep high 2 bits (blend mask)
C $AF45,2 OR in fixed low bits
C $AF49,2 fixed byte 2 ($FE)
C $AF4C,2 fixed byte 3 ($E9)
C $AF4F,1 A = dest byte 3
C $AF50,2 keep low 6 bits (blend mask)
C $AF57,3 branch 3/4: carry set -> branch 4 ($AF71)
C $AF5A,1 branch 3: A = dest byte 1
C $AF5B,2 keep high nibble (blend mask)
C $AF5D,2 OR in fixed low bit
C $AF61,2 fixed byte 2 ($BF)
C $AF64,2 fixed byte 3 ($BA)
C $AF67,1 A = dest byte 3
C $AF68,2 keep low nibble (blend mask)
C $AF6A,2 OR in fixed high bits
C $AF71,1 branch 4: A = dest byte 1
C $AF72,2 keep high 6 bits (blend mask)
C $AF76,2 fixed byte 2 ($6F)
C $AF79,2 fixed byte 3 ($EE)
C $AF7C,1 A = dest byte 3
C $AF7D,2 keep low 2 bits (blend mask)
C $AF7F,2 OR in fixed high bits
@ $AF86 label=render_col_cap_b
c $AF86 Render col cap b
N $AF86 Structurally identical 4-way dispatch to render_col_cap_a (self-mod test byte at $AF89, patched by $AE06/$AE09), but writes only 2 destination bytes per branch instead of 3 -- a narrower cap/edge graphic for a different column class.
N $AF86 Ends `POP HL / JP $AE18` in all branches.
C $AF86,2 save dest ptr, apply column offset
C $AF88,4 self-mod test byte -> Z/C flags
C $AF8C,3 nonzero -> branch 3/4
C $AF8F,3 carry set -> branch 2
C $AF92,2 branch 1: fixed byte 1 ($2F)
@ $AFD0 label=render_col_fill
c $AFD0 Render col fill
N $AFD0 Third 4-way dispatch variant (test byte self-mod at $AFD3, sharing the $ADEA/$ADED patch point with render_col_partial's mask selection), writing up to 3 bytes with mostly solid-$FF fill patterns -- a plain/bright tower-segment fill rather than a textured cap. One branch ($B000) has a nested sub-branch (JP C,$B016), making 5 cases total.
N $AFD0 Ends `POP HL / JP $AE18` in all branches.
C $AFD0,1 save dest ptr
C $AFD1,1 HL += DE (apply column offset)
C $AFD2,2 A = self-mod test byte
C $AFD4,2 shift test byte -> Z/C flags
C $AFD6,3 nonzero -> branch 3/4 ($B000)
C $AFD9,3 carry set -> branch 2 ($AFF0)
C $AFDC,1 branch 1: A = dest byte 1
C $AFDD,2 keep high 2 bits (blend mask)
C $AFDF,2 OR in fixed low bits
C $AFE3,2 solid fill byte 2 ($FF)
C $AFE6,1 A = dest byte 3
C $AFE7,2 keep low 2 bits (blend mask)
C $AFF0,1 branch 2: A = dest byte 1
C $AFF1,2 keep high nibble (blend mask)
C $AFF7,2 solid fill byte 2 ($FF)
C $AFFA,2 solid fill byte 3 ($FC)
C $B000,3 branch 3/4: carry set -> branch 4 ($B016)
C $B003,1 branch 3: A = dest byte 1
C $B004,2 keep high 6 bits (blend mask)
C $B008,2 solid fill byte 2 ($FF)
C $B00B,2 solid fill byte 3 ($FF)
C $B00E,1 A = dest byte 3
C $B00F,2 keep low 6 bits (blend mask)
C $B016,1 branch 4: skip byte 1 (no write)
C $B017,2 solid fill byte 2 ($3F)
C $B01A,2 solid fill byte 3 ($FF)
C $B01D,1 A = dest byte 3
C $B01E,2 keep low nibble (blend mask)
C $B020,2 OR in fixed high bits
@ $B027 label=anim_texture_masks
b $B027
N $B027 3 groups of 8 bytes (mask/value pairs), indexed by the $603C animation phase counter (anim_bg_phase) via render_anim_texture (#R$B03F) -- an animated dithered/striped tower texture that cycles as $603C advances.
@ $B03F label=render_anim_texture
c $B03F Render anim texture
N $B03F Final per-cell render handler, and the only one whose graphic depends on animation phase rather than static column geometry: reads $603C into BC as an index into anim_texture_masks (#R$B027), giving an animated tower stripe/shade effect.
N $B03F Same self-mod 4-way branch-and-mask-merge shape as the other handlers (test byte at $B045), each branch copying/merging bytes from a different #R$B027 offset ($B029/$B02B/$B02D).
N $B03F Ends `POP BC / POP HL / JP $AE18` in all branches.
C $B03F,1 save HL (destination byte ptr)
C $B040,1 DE += HL (advance to next cell)
C $B041,1 swap: HL=dest ptr, DE=advance amount
C $B042,1 save BC
C $B043,2 A = self-mod test byte (patched by setup_tower_scroll)
C $B045,2 shift test byte -> Z/C flags
C $B047,3 A = anim_bg_phase ($603C)
C $B04A,1 C = phase (BC = table index)
C $B04D,3 test byte nonzero -> $B078
C $B050,3 test byte carry set -> $B063
C $B053,3 HL -> anim_texture_masks + phase
C $B057,2 copy one animated byte via LDI
C $B059,1 A = current dest byte
C $B05A,2 mask low nibble
C $B05C,1 OR in the animated bits
C $B063,3 HL -> $B029 + phase (2nd branch base)
C $B067,1 A = current dest byte
C $B068,2 mask high 2 bits ($C0)
C $B06E,1 A = second dest byte
C $B06F,2 mask low 2 bits ($03)
C $B078,3 test byte carry set -> $B08D
C $B07B,3 HL -> $B02B + phase (3rd branch base)
C $B07F,1 A = current dest byte
C $B080,2 mask high nibble ($F0)
C $B08D,3 HL -> $B02D + phase (4th branch base)
C $B091,1 A = current dest byte
C $B092,2 mask high 6 bits ($FC)
C $B096,2 copy one animated byte via LDI
C $B098,1 A = second dest byte
C $B099,2 mask low 6 bits ($3F)
s $B0A1
N $B0A1 Self-mod scratch byte, not unused: draw_tower_cols patches this as the immediate operand of its column-count loop (see draw_tower_cols's own note) -- the live loop-count constant, reduced near the scroll wrap edge.
@ $B0A2 label=draw_tower_cols
c $B0A2 Draw tower cols
N $B0A2 Render the visible tower column strip.
N $B0A2 Patches the column count at #R$B0A1 ($14, reduced near the wrap edge from scroll_pos) and dispatches on the $6021 sub-column phase.
N $B0A2 SELF-MOD: #R$B0A1 loop count.
N $B0A2 Clobbers: A,B,HL (+ render regs).
C $B0A2,5 self-mod default column count = $14
C $B0A7,3 get Vertical scroll position
C $B0AA,3 near the scroll wrap? reduce column count
C $B0BE,3 A = sub-column phase ($6021)
C $B0C2,2 phase 0 -> straight into the strip blit below
C $B0C4,5 phase 2 -> variant at $B126
C $B0C9,5 phase 4 -> variant at $B17E
C $B0CE,3 else -> variant at $B1D6
C $B0D1,1 DI (fast blit: redirect SP as a data pointer)
C $B0D2,4 set Temporary place for SP
C $B0D6,3 SP -> pre-baked strip-params table ($B22E)
C $B0D9,4 IX -> column-mask source ($6460)
C $B0DD,2 B = $5B (91 columns)
C $B120,4 get Temporary place for SP
C $B127,4 set Temporary place for SP
C $B178,4 get Temporary place for SP
C $B17F,4 set Temporary place for SP
C $B1D0,4 get Temporary place for SP
C $B1D7,4 set Temporary place for SP
C $B228,4 get Temporary place for SP
b $B22E
@ $B346 label=load_level_col
c $B346 Load level col
N $B346 Fetch column descriptor #R$6039 from the column-major table at #R$7A00 (stride 8): low byte (+0) and high byte (+8) form a pointer (offset by #R$6A00 into level data), and the property byte (+16) is stashed in $603A.
N $B346 Cell byte format for the map this fills: docs/Level-Format.md.
N $B346 Returns IX=pointer.
N $B346 Clobbers: A,BC,DE,HL,IX.
C $B36F,3 Blit masked column
C $B372,3 Blit masked column
C $B37E,3 set Unknown word
@ $B382 label=blit_masked_column
c $B382 Blit masked column
N $B382 Draw an 8-pixel-tall column at HL: for each set bit of the mask byte at (DE), store the next source byte (IX++) and step down one pixel row (INC H) skip rows whose mask bit is 0.
N $B382 In: DE=mask ptr, IX=pixels, HL=screen.
N $B382 Clobbers: A,B,HL,IX.
@ $B395 label=alloc_object_slot
c $B395 Alloc object slot
N $B395 Find a free entry (marker $FF at +0) in the 4-slot active-object table at $60A9.
N $B395 On success store its type ($7D), source pointer (HL) and a copied data byte, set CY, RET.
N $B395 In: HL=source.
N $B395 Out: CY=allocated.
N $B395 Clobbers: A,B,IX.
@ $B3BF label=update_object_slots
c $B3BF Update object slots
N $B3BF Tick the 4-entry active-object table at $60A9 (counterpart to alloc_object_slot).
N $B3BF For each slot: $FF=free (skip), >1 = decrement its countdown, and on expiry write the stored byte back through its screen pointer (erase the object).
N $B3BF Clobbers: A,B,HL,IX.
C $B3BF,6 IX -> active-object table ($60A9), B=4 slots
C $B3C5,4 A = this slot's countdown
C $B3C9,2 zero -> expired, handle it
C $B3CB,4 $FF -> free slot, skip
C $B3CF,5 else: decrement countdown, next slot
C $B3D4,9 expired: HL -> stored screen pointer
C $B3F9,4 next slot, loop 4
@ $B3FE label=free_object_slot
c $B3FE Free object slot
N $B3FE Mark the $60A9 slot whose stored pointer equals HL as free (set +0 = $FF).
N $B3FE In: HL=pointer.
N $B3FE Clobbers: A,B,IX.
@ $B421 label=update_actors
c $B421 Update actors
N $B421 Per-frame actor pass (proc_table slot A76F).
N $B421 Skips when player_state is 8/9 (level-end).
N $B421 Derives the camera row #R$6036 from $6059, then walks the 4 object_table actors, acting on each live one (state field IX+48 != 0).
N $B421 Clobbers: A,B,HL,IX.
C $B421,9 skip if player_state 8 or 9 (level-end)
C $B42A,10 camera row = ($6059)>>2 (RR chain)
C $B434,3 set Camera row
C $B437,18 find first active actor (state!=0) in object_table
C $B449,3 get Unknown word
C $B44C,4 already aligned to camera row? -> spawn dispatch ($B512)
C $B453,3 get Camera row
C $B45D,9 test cell flags at HL: special/type check
C $B466,14 step #R$6015 high nibble toward $F0..$FF ring, wrap
C $B474,3 set Unknown word
C $B478,3 set Unknown word
C $B48C,3 set Unknown word
C $B491,6 classify flag bits ($70 mask)
C $B497,4 bit pattern $60? branch
C $B49B,4 bit pattern $40? branch
C $B49F,9 bit $20 exact? set speed=1 else 0
C $B4A8,11 speed/phase/pattern = 0/1/0 (idle-ish spawn)
C $B4B6,10 speed=1or2, phase=8, pattern=0 (variant B)
C $B4CB,10 speed=1or2, phase=9, pattern=0 (variant C)
C $B4E0,9 speed=1, phase=2, pattern=0 (variant D)
C $B4ED,10 compute angular pos from row (H-$F0)*8+4
C $B4FA,9 compute position (IX+6/+12) via rotate-left pack
C $B509,4 activate: state=6, phase=0
C $B512,7 $60A3 flag: pending single-shot spawn?
C $B51F,8 activate as state 7 (wall marker), reset phase
C $B527,3 get Player's current column
C $B52C,3 set Player's current column
C $B532,7 derive angular pos 0/$78 from sign
C $B539,13 store position (IX+0/+6/+12) from player position
@ $B546 label=clear_screen
c $B546 Clear screen
N $B546 Cold wipe before the title/play screen draws.
N $B546 1) zero game RAM #R$6000..$61FF (512 bytes, 2 pages).
N $B546 2) zero the entire display $4000..$5AFF (pixels+attrs) via LDIR.
N $B546 3) CALL #R$B567 (build a lookup table in the reclaimed printer buffer #R$5B00) and #R$B5EA.
N $B546 Clobbers: A,BC,DE,HL.
C $B546,3 HL -> game RAM base #R$6000
C $B549,2 B = 2 pages to clear
C $B54B,2 store 0
C $B54E,2 loop 256 bytes of this page
C $B550,1 next page
C $B553,3 HL -> screen base $4000
C $B556,3 DE -> $4001 (LDIR src=HL, dst=DE, overlap fill)
C $B559,3 BC = $1AFF = 6911 bytes = whole display minus 1
C $B55C,2 seed first byte = 0
C $B55E,2 LDIR: propagate 0 across $4000..$5AFF
C $B560,3 Build screen hi LUT
C $B563,3 Build row addr table
@ $B567 label=build_screen_hi_lut
c $B567 Build screen hi LUT
N $B567 Fill a 256-byte table at #R$5B00 mapping a byte value to its bit-reordered form used in ZX screen-address math.
N $B567 Processes the index in 2-bit groups groups 00 and 11 pass through, 01/10 get +$40 -- the Y2<->Y0 swap that makes the ZX pixel rows non-linear.
N $B567 Result accumulates in H.
N $B567 The porter can DELETE this and the #R$5B00 lookups, replac
C $B567,3 DE -> #R$5B00 LUT base (reclaimed printer buffer)
C $B56A,1 C = current index (low byte of DE)
C $B56B,2 B = 4 groups of 2 bits
C $B56E,2 isolate the top 2-bit group
C $B570,2 00 -> pass through
C $B574,2 11 -> pass through
C $B576,2 01/10 -> +$40 (the scan-order bit swap)
C $B579,1 HL <<= 2 (accumulate this group)
C $B57B,2 shift C left 2 to expose next group (Z80 SLA)
C $B582,1 store H as LUT[index]
C $B584,2 loop all 256 entries (E wraps to 0)
@ $B587 label=clear_playfield
c $B587
C $B589,1 compute screen-addr high byte from row index
C $B59F,2 zero 32 pixel bytes of this row
C $B5A6,2 stop at row $B8
C $B5B5,2 LDIR: clear an attribute strip
@ $B5C8 label=hook_noop
c $B5C8
@ $B5CB label=flag_b5cb
B $B5CB,1,1
B $B5CC,2,2
B $B5CE,1,1
@ $B5CF label=init_b5cf
c $B5CF
C $B5D1,3 set Flag?? $00 $FE $FF
C $B5D5,3 zero flag_b5cb at #R$B5CB (write into code padding)
@ $B5D9 label=get_screen_addr
c $B5D9 Get screen addr
N $B5D9 Pixel address for (row=H, col-in-row=L).
N $B5D9 Indexes scr_row_addr_tbl (#R$5D00, 2 bytes/row) at 2*H to fetch the row base, then adds L to get the final byte address in HL.
N $B5D9 In: H=row 0..191, L=byte offset within row.
N $B5D9 Out: HL=screen addr.
N $B5D9 Clobbers A preserves DE.
C $B5DC,1 L = 2*H = table index
C $B5DE,2 H = $5D + carry -> HL -> scr_row_addr_tbl[H]
C $B5E4,1 A = row base low + col offset
C $B5E6,1 H = row base high
@ $B5EA label=build_row_addr_table
c $B5EA Build row addr table
N $B5EA Precompute 192 screen-row addresses into scr_row_addr_tbl (#R$5D00, little-endian words).
N $B5EA For each row y in 0..191 it builds the ZX pixel address:
N $B5EA high = $40 | (y&7) | ((y>>3)&$18)
N $B5EA low  = (y&$38)<<2 i.e.
N $B5EA the famous ZX scan-order layout (Y bits split across the address).
N $B5EA get_screen_addr then just indexes this table.
C $B5EA,3 DE -> #R$5D00 table base
C $B5ED,3 HL: H = row counter y, builds address in HL
C $B5F2,1 (y>>3)&$18  -> D (the y bits 3..5 region)
C $B5FC,1 + (y&7) + $40 -> high byte
C $B601,2 (y<<2)&$E0 -> low byte (E)
C $B60A,1 HL = full row-0 screen address
C $B60D,1 store LE word into table[y]
C $B615,2 stop after row $BF (192 rows)
@ $B61B label=get_sprite_def
c $B61B Get sprite def
N $B61B Look up sprite/graphic descriptor A in the #R$C100 table (A*2): unpack the frame count (top 2 bits, 0->4) into C and the bitmap pointer (low 6 bits + $C1xx base) into HL.
N $B61B In: A=sprite id.
N $B61B Out: HL=bitmap, C=frames.
N $B61B Clobbers: A,HL.
C $B61B,1 Sprite ID to word index
C $B61F,3 Point to sprite offsets table (#R$C100)
C $B623,1 Descriptor: top 2 bits = frame count, low 6 bits = offset
C $B626,2 Extract frame count into C (0-3)
C $B62B,2 Default to 4 frames if count is zero
C $B62E,2 Keep low 6 bits
C $B630,2 Compute bitmap address high byte: $C1 + offset
C $B633,1 Low byte from preceding word entry
@ $B636 label=select_player_sprite
c $B636 Select player sprite
N $B636 Pick the player's current sprite frame from $60C1 plus facing ($60BE bit7) and player_state, applying frame-base offsets ($1F walking-left / $44 walking-right).
N $B636 RET early if $60C2==0 (nothing to draw).
N $B636 Clobbers: A,H,L.
C $B63B,3 get Player state-machine state
C $B661,3 Get sprite def
C $B678,3 Get screen addr
C $B67E,4 set Temporary place for SP
C $B6FB,4 get Temporary place for SP
C $B700,3 get Flag?? $00 $FE $FF
C $B70D,3 Get screen addr
C $B715,3 Plot masked row
C $B719,3 Plot masked row
C $B71C,3 Plot row wrapped
C $B71F,3 Plot masked row
C $B722,3 Plot row wrapped
C $B725,3 Plot masked row
C $B728,3 Plot row wrapped
C $B72B,3 Plot masked row
@ $B72F label=plot_row_wrapped
c $B72F Plot row wrapped
N $B72F Advance the screen address HL down one pixel row (ZX scan-order arithmetic: char-cell wrap via +$20 / -$08) then fall into plot_masked_row.
N $B72F Clobbers: A,HL (+ plot regs).
@ $B73E label=plot_masked_row
c $B73E Plot masked row
N $B73E Plot a 3-cell sprite slice at HL: AND the left edge cell with mask D, write the two middle cells = B, AND the right edge with mask E restores L and bumps H.
N $B73E In: HL,B,D,E.
N $B73E Clobbers: A,C,HL.
@ $B74D label=draw_actor_sprite
c $B74D Draw actor sprite
N $B74D Render one object_table actor (IX = entry).
N $B74D Skips if the sprite id (IX+24)==$FF (inactive).
N $B74D Computes screen-Y via actor_screen_y (also leaves an X-related byte in $60A6). State 7 (IX+48, the "static wall marker" convention used by collision_test) doubles $60A6 into a fresh angular-position copy rather than drawing normally.
N $B74D Bounds-checks the screen row ($60A8) to [$18,$B0) (RET if off-screen), derives a sub-column fraction from $60A6, and for state-7 entries queues a one-shot deferred sprite via flag_b5cb/#R$B5CC/#R$B5CE (consumed later by draw_pending_sprite) instead of blitting immediately.
N $B74D Otherwise computes the screen address (GET_SCREEN_ADDR), then picks the bitmap: sprite id >=$7C indexes the runtime table at $BC80 directly (fixed 3-cell-wide, 8-row blit) sprite id <$7C goes through GET_SPRITE_DEF (adds a facing offset derived from $60A6) to fetch the normal #R$C100 sprite definition. Falls through into blit_sprite_fast to draw.
N $B74D Clobbers: A,HL,IX,...
C $B750,3 sprite id == $FF -> RET (inactive)
C $B753,3 Actor screen y
C $B756,7 state 7 (wall marker)?
C $B75D,7 double angular pos -> $60A6
C $B764,3 A = screen row ($60A8)
C $B767,6 bounds check row to [$18,$B0), else RET
C $B76E,9 sub-column fraction: ($60A6)>>3 &$1F -> L
C $B777,7 state 7 again -> defer draw
C $B77E,3 queue deferred sprite: pos -> #R$B5CC
C $B781,10 facing quadrant -> #R$B5CE
C $B78B,5 flag_b5cb = 1 (pending)
C $B790,3 Get screen addr
C $B794,7 sprite id >= $7C? (fixed runtime-table graphic)
C $B79B,16 offset*24 into $BC80 table
C $B7AB,4 HL -> $BC80 + offset
C $B7AF,6 C=3,B=8: fixed 3-cell/8-row blit
C $B7B5,1 else: C = raw sprite id
C $B7B6,8 facing quadrant + sprite id
C $B7BE,1 stash variant byte for blit_sprite_fast
C $B7BF,3 Get sprite def
@ $B7C2 label=blit_sprite_fast
c $B7C2 Blit sprite fast
N $B7C2 Fast masked sprite blit using the LD SP,screen / PUSH stack-write trick (saves the real SP to #R$6000, DI, treats the screen as a "stack" so each POP+merge writes one masked byte pair).
N $B7C2 Entered by fallthrough from draw_actor_sprite's GET_SPRITE_DEF/RET (POP AF recovers the sprite-variant byte pushed before that call): height B is 8 rows normally, or 4 rows when that byte is >=$4E (used for the fixed $BC80 runtime-table sprites, which pre-set C=3/B=8 explicitly and skip this test).
N $B7C2 C selects the row width variant: 1-cell-wide ($B7DD, 2 mask/data pairs per row), 2-cell-wide ($B7FD, 4 pairs), or 3-cell-wide ($B82B, 6 pairs) each variant does the same AND/OR merge-and-advance idiom (INC H each row, wrapping L by +$20/-8 on the char-cell boundary every 8 rows -- the standard ZX scan-order step), looping B times via DJNZ.
N $B7C2 Data is consumed via POP off the (redirected) stack: each row pops a mask/value pair per cell, ANDs the mask into the destination screen byte, ORs in the value.
N $B7C2 Restores the real SP from #R$6000 and EI before returning.
N $B7C2 Clobbers: A,BC,DE,HL.
C $B7C2,1 recover sprite-variant byte pushed before GET_SPRITE_DEF
C $B7C3,8 height = 4 rows if variant >= $4E, else 8
C $B7CB,1 DE = mask/value source pointer
C $B7CC,4 set Temporary place for SP
C $B7D1,2 SP=HL (write-via-POP trick); HL=mask/value ptr
C $B7D3,10 C selects row-width variant: 1/2/3-cell
C $B7DD,1 --- 1-cell-wide variant ---
C $B7E9,15 wrap to next screen row (char-cell boundary step)
C $B7F8,2 loop B rows
C $B7FA,3 done -> restore SP
C $B7FD,1 --- 2-cell-wide variant ---
C $B817,15 wrap to next screen row
C $B826,2 loop B rows
C $B82B,1 --- 3-cell-wide variant ---
C $B852,15 wrap to next screen row
C $B861,2 loop B rows
C $B863,4 get Temporary place for SP
C $B867,2 EI; RET
@ $B869 label=actor_screen_y
c $B869 Actor screen y
N $B869 Object-table counterpart of col_screen_y: map an actor's angular column (IX+0)+$20, minus tower_height rotation, wrapped (AND $7F), through col_y_table to a screen row also derives the object index ((IX low)-$5B).
N $B869 Clobbers: A,DE,HL.
C $B869,11 angular column + $20, minus tower rotation, wrapped
C $B877,4 HL -> col_y_table[rel]
C $B87B,7 object index = (IX low) - $5B
C $B889,6 scale/bias -> store projected value ($60A6)
@ $B8A8 label=draw_pending_sprite
c $B8A8 Draw pending sprite
N $B8A8 If flag_b5cb is set, consume it and draw the one-shot sprite queued at #R$B5CC (pos) / #R$B5CE (id), with on-screen bounds checks.
N $B8A8 RET immediately when nothing queued.
N $B8A8 Clobbers: A,BC,HL.
C $B8A8,5 flag_b5cb set? consume it, else RET
C $B8B1,7 HL = queued pos, B = queued sprite id
C $B8B8,8 bounds check: column edge cases (row 7..$17 skip)
C $B8C0,3 bounds check: row < $1E
C $B8C3,6 C=2 (default cell count); row<5 -> $B8DE
C $B8C9,14 row==6 or edge cases -> adjust C (1 or 3 cells)
C $B8D7,7 adjust cell count near right/bottom edge
C $B8DE,5 sprite id (B)!=0? bump C for extra cell
C $B8E3,3 Get screen addr
C $B8E6,4 B=8 rows, D=0 (erase byte)
C $B8EA,9 C selects erase width: 1/2/3-cell
C $B8F3,22 --- 1-cell erase: write+wrap to next row ---
C $B909,26 --- 2-cell erase: write+wrap to next row ---
C $B923,30 --- 3-cell erase: write+wrap to next row ---
@ $B941 label=strip_params
b $B941
T $B94A
b $B94D
T $B95A
b $B95D
@ $B965 label=setup_strip_draw
c $B965 Setup strip draw
N $B965 Patch the tower column-strip blitter's params (#R$B941/$B9A1 row, $B942 column base) from disp_height and scroll_pos (bit2 selects the $24/$2C column phase).
N $B965 SELF-MOD.
N $B965 Clobbers: A,B,C.
C $B966,3 get Display height
C $B971,3 get Vertical scroll position
C $B983,3 get Vertical scroll position
C $B9BA,3 Get screen addr
@ $B9D6 label=draw_tower_strip
c $B9D6 Draw tower strip
N $B9D6 Blit one vertical column strip of up to 10 tower elements using the params patched by setup_strip_draw resolves each cell's screen address via get_screen_addr.
N $B9D6 Clobbers: A,B,DE,HL.
C $B9F2,3 Get screen addr
T $BA0E
@ $BA16 label=lookup_col_attr
c $BA16
C $BA18,3 get Level number 0
@ $BA26 label=paint_tower_attrs
c $BA26 Paint tower attrs
N $BA26 Repaint the tower's attribute (colour) band in the $58xx attribute file from $5860, using lookup_col_attr (#R$BA16) for per-column colours and fill_run ($BA61) to lay rows.
N $BA26 SELF-MOD: #R$BA66 row count.
N $BA26 Clobbers: A,BC,D,HL.
C $BA26,5 self-mod row count = $0E
C $BA2B,3 HL -> attribute band base ($5860)
C $BA30,2 D = 0 (edge/border colour)
C $BA32,3 fill_run: paint the left edge
C $BA35,2 C = $0B (column count)
C $BA3D,3 lookup_col_attr: colour for this column
C $BA40,3 fill_run: paint this column's rows
C $BA47,3 loop C columns
@ $BA61 label=fill_run
s $BA66
@ $BA67 label=scroll_tower_attrs
c $BA67 Scroll tower attrs
N $BA67 Adjust the painted attribute band as scroll_pos advances (compares against the #R$BA66 latch set by paint_tower_attrs) so colours track the scrolling tower.
N $BA67 Clobbers: A,B,HL.
C $BA67,3 HL = scroll_pos
C $BA6A,3 top-of-tower page (H==3)?
C $BA6D,2 A = $16 (default row index)
C $BA71,1 A = scroll_pos low byte
C $BA72,2 negate (count down from top)
C $BA74,4 /4, mask to row range
C $BA78,2 bias by -$16
C $BA7A,2 negate back
C $BA7C,1 B = target row index
C $BA7D,3 A = previous row index (#R$BA66 latch)
C $BA80,1 delta = new - previous
C $BA81,2 unchanged? -> just update latch, RET
C $BA83,2 delta == -1 (scrolled up one row)?
C $BA87,2 delta == +1 (scrolled down one row)?
C $BA8B,4 store new row index in latch
C $BA8F,1 B++ (paint the row below)
C $BA90,2 C = $41 (default attribute)
C $BA99,4 store new row index in latch
C $BA9D,3 recompute the attribute for this column via lookup_col_attr
C $BAA1,8 HL = B * 32 (attribute row address)
C $BAA9,3 DE = $5802 (attribute area base + offset)
C $BAAD,2 B = $1C (28 columns)
C $BAAF,4 fill one attribute row with C, loop
s $BAB4
@ $BABA label=im2_dispatch
c $BABA
b $BABD
@ $BB00 label=im2_vector_table
@ $BC00 label=runtime_tables
b $BC00 Runtime tables
N $BC00 #R$BC00..$BFFF, zero in the snapshot.
N $BC00 Game-state tables populated after init (enemy slots, column state, score work).
N $BC00 Referenced bases below are filled/read at runtime.
@ $BC80 label=rt_bc80
@ $BD60 label=rt_bd60
@ $BE00 label=rt_be00
T $BE0F
b $BE12
@ $BE21 label=rt_be21
T $BE58
b $BE5E
@ $BE60 label=rt_be60
T $BE88
b $BE90
T $BED8
b $BEE0
T $BF0A
b $BF10
@ $BF32 label=rt_bf32
@ $C000 label=font_base
b $C000 Font 8x6
N $C000 #HTML[#UDGARRAY28($C000-$C0A7-6){0,0,448,12}(font0.png)]
B $C000
N $C0A8
N $C0A8 #HTML[#UDGARRAY13($C0A8-$C0F5-6){0,0,208,12}(font1.png)]
@ $C100 label=gfx_c100
b $C100
B $C100,2,2 #R$C1F6, 4 frames
B $C102,2,2 #R$C26E, 4 frames
B $C104,2,2 #R$C2E6, 4 frames
B $C106,2,2 #R$C35E, 4 frames
B $C108,2,2 #R$C3D6, 4 frames
B $C10A,2,2 #R$C44E, 4 frames
B $C10C,2,2 #R$C4C6, 4 frames
B $C10E,2,2 #R$C53E, 4 frames
B $C110,2,2 #R$C5B6, 4 frames
B $C112,2,2 #R$C62E, 2 frames
B $C114,2,2 #R$C67E, 2 frames
B $C116,2,2 #R$C6CE, 2 frames
B $C118,2,2 #R$C71E, 4 frames
B $C11A,2,2 #R$C796, 4 frames
B $C11C,2,2 #R$C80E, 4 frames
B $C11E,2,2 #R$C886, 4 frames
B $C120,2,2 #R$C8FE, 4 frames
B $C122,2,2 #R$C976, 2 frames
B $C124,2,2 #R$C9C6, 2 frames
B $C126,2,2 #R$CA16, 2 frames
B $C128,2,2 #R$CA66, 2 frames
B $C12A,2,2 #R$CAB6, 2 frames
B $C12C,2,2 #R$CB06, 2 frames
B $C12E,2,2 #R$CB56, 2 frames
B $C130,2,2 #R$CBA6, 2 frames
B $C132,2,2 #R$CBF6, 2 frames
B $C134,2,2 #R$CC46, 4 frames
B $C136,2,2 #R$CCBE, 4 frames
B $C138,2,2 #R$CD36, 4 frames
B $C13A,2,2 #R$CDAE, 4 frames
B $C13C,2,2 #R$CE26, 4 frames
B $C13E,2,2 #R$CE9E, 4 frames
B $C140,2,2 #R$CF16, 4 frames
B $C142,2,2 #R$CF8E, 2 frames
B $C144,2,2 #R$CFDE, 2 frames
B $C146,2,2 #R$D02E, 2 frames
B $C148,2,2 #R$D07E, 2 frames
B $C14A,2,2 #R$D0CE, 4 frames
B $C14C,2,2 #R$D146, 4 frames
B $C14E,2,2 #R$D1BE, 4 frames
B $C150,2,2 #R$D236, 4 frames
B $C152,2,2 #R$D2AE, 4 frames
B $C154,2,2 #R$D326, 4 frames
B $C156,2,2 #R$D39E, 4 frames
B $C158,2,2 #R$D416, 4 frames
B $C15A,2,2 #R$D48E, 4 frames
B $C15C,2,2 #R$D506, 2 frames
B $C15E,2,2 #R$D556, 2 frames
B $C160,2,2 #R$D5A6, 2 frames
B $C162,2,2 #R$D5F6, 4 frames
B $C164,2,2 #R$D66E, 4 frames
B $C166,2,2 #R$D6E6, 4 frames
B $C168,2,2 #R$D75E, 4 frames
B $C16A,2,2 #R$D7D6, 4 frames
B $C16C,2,2 #R$D84E, 2 frames
B $C16E,2,2 #R$D89E, 2 frames
B $C170,2,2 #R$D8EE, 2 frames
B $C172,2,2 #R$D93E, 2 frames
B $C174,2,2 #R$D98E, 2 frames
B $C176,2,2 #R$D9DE, 2 frames
B $C178,2,2 #R$DA2E, 2 frames
B $C17A,2,2 #R$DA7E, 2 frames
B $C17C,2,2 #R$DACE, 2 frames
B $C17E,2,2 #R$DB1E, 4 frames
B $C180,2,2 #R$DB96, 4 frames
B $C182,2,2 #R$DC0E, 4 frames
B $C184,2,2 #R$DC86, 4 frames
B $C186,2,2 #R$DCFE, 4 frames
B $C188,2,2 #R$DD76, 4 frames
B $C18A,2,2 #R$DDEE, 4 frames
B $C18C,2,2 #R$DE66, 2 frames
B $C18E,2,2 #R$DEB6, 2 frames
B $C190,2,2 #R$DF06, 2 frames
B $C192,2,2 #R$DF56, 2 frames
B $C194,2,2 #R$DFA6, 2 frames
B $C196,2,2 #R$DFC6, 2 frames
B $C198,2,2 #R$DFE6, 2 frames
B $C19A,2,2 #R$E006, 2 frames
B $C19C,2,2 #R$E026, 2 frames
B $C19E,2,2 #R$E066, 3 frames
B $C1A0,2,2 #R$E0C6, 3 frames
B $C1A2,2,2 #R$E126, 3 frames
B $C1A4,2,2 #R$E186, 2 frames
B $C1A6,2,2 #R$E1C6, 3 frames
B $C1A8,2,2 #R$E226, 3 frames
B $C1AA,2,2 #R$E286, 3 frames
B $C1AC,2,2 #R$E2E6, 2 frames
B $C1AE,2,2 #R$E326, 3 frames
B $C1B0,2,2 #R$E386, 3 frames
B $C1B2,2,2 #R$E3E6, 3 frames
B $C1B4,2,2 #R$E446, 2 frames
B $C1B6,2,2 #R$E486, 2 frames
B $C1B8,2,2 #R$E4C6, 2 frames
B $C1BA,2,2 #R$E506, 3 frames
B $C1BC,2,2 #R$E566, 2 frames
B $C1BE,2,2 #R$E5A6, 2 frames
B $C1C0,2,2 #R$E5E6, 3 frames
B $C1C2,2,2 #R$E646, 3 frames
B $C1C4,2,2 #R$E6A6, 2 frames
B $C1C6,2,2 #R$E6E6, 3 frames
B $C1C8,2,2 #R$E746, 3 frames
B $C1CA,2,2 #R$E7A6, 3 frames
B $C1CC,2,2 #R$E806, 2 frames
B $C1CE,2,2 #R$E846, 3 frames
B $C1D0,2,2 #R$E8A6, 3 frames
B $C1D2,2,2 #R$E906, 3 frames
B $C1D4,2,2 #R$E966, 2 frames
B $C1D6,2,2 #R$E9A6, 3 frames
B $C1D8,2,2 #R$EA06, 3 frames
B $C1DA,2,2 #R$EA66, 3 frames
B $C1DC,2,2 #R$EAC6, 2 frames
B $C1DE,2,2 #R$EB06, 3 frames
B $C1E0,2,2 #R$EB66, 3 frames
B $C1E2,2,2 #R$EBC6, 3 frames
B $C1E4,2,2 #R$EC26, 2 frames
B $C1E6,2,2 #R$EC66, 3 frames
B $C1E8,2,2 #R$ECC6, 3 frames
B $C1EA,2,2 #R$ED26, 3 frames
B $C1EC,2,2 #R$ED86, 2 frames
B $C1EE,2,2 #R$EDD6, 2 frames
B $C1F0,2,2 #R$EE26, 2 frames
B $C1F2,2,2 #R$EE76, 2 frames
B $C1F4,2,2 #R$EEC6, 3 frames
@ $C1F6 label=gfx_c1f6
B $C1F6,120,8 #HTML[<img src="images/gfx/gfx-c1f6.png">]
N $C1F6 Graphics, animation frame 1 of 4 -- masks for Pogo (frames 2-4 are gfx_c26e/gfx_c2e6/gfx_c35e, each an independent block).
N $C1F6 NOT a raw 1bpp raster -- these bytes only become real pixels after calc_sprite_shift/expand_sprite_b's self-modifying decode (see patch_expand_masks, $8E48). Reading this block directly as a bitmap produces garbage; a UDG array macro cannot render it.
N $C1F6 Verified by emulation (decode_sprite.py, real Z80 core, self-mod masks forced to identity OR $00/AND $FF): decodes to a fixed 16 rows x 3 cells (24x16px), 96 source bytes consumed, invariant across all 4 shift values.
@ $C26E label=gfx_c26e
B $C26E,120,8 #HTML[<img src="images/gfx/gfx-c26e.png">]
N $C26E Graphics, animation frame 2 of 4 -- masks for Pogo.
@ $C2E6 label=gfx_c2e6
B $C2E6,120,8 #HTML[<img src="images/gfx/gfx-c2e6.png">]
N $C2E6 Graphics, animation frame 3 of 4 -- masks for Pogo.
@ $C35E label=gfx_c35e
B $C35E,120,8 #HTML[<img src="images/gfx/gfx-c35e.png">]
N $C35E Graphics, animation frame 4 of 4 -- masks for Pogo.
@ $C3D6 label=gfx_c3d6
B $C3D6,120,8 #HTML[<img src="images/gfx/gfx-c3d6.png">]
N $C3D6 Graphics, 4 frames -- masks for Pogo.
@ $C44E label=gfx_c44e
B $C44E,120,8 #HTML[<img src="images/gfx/gfx-c44e.png">]
N $C44E Graphics, 4 frames -- masks for Pogo.
@ $C4C6 label=gfx_c4c6
B $C4C6,120,8 #HTML[<img src="images/gfx/gfx-c4c6.png">]
N $C4C6 Graphics, 4 frames -- masks for Pogo.
@ $C53E label=gfx_c53e
B $C53E,120,8 #HTML[<img src="images/gfx/gfx-c53e.png">]
N $C53E Graphics, 4 frames -- masks for Pogo.
@ $C5B6 label=gfx_c5b6
B $C5B6,120,8 #HTML[<img src="images/gfx/gfx-c5b6.png">]
N $C5B6 Graphics, 4 frames -- masks for Pogo.
@ $C62E label=gfx_c62e
B $C62E,80,8 #HTML[<img src="images/gfx/gfx-c62e.png">]
N $C62E Graphics, 2 frames -- Pogo rotating.
@ $C67E label=gfx_c67e
B $C67E,80,8 #HTML[<img src="images/gfx/gfx-c67e.png">]
N $C67E Graphics, 2 frames -- Pogo rotating.
@ $C6CE label=gfx_c6ce
B $C6CE,80,8 #HTML[<img src="images/gfx/gfx-c6ce.png">]
N $C6CE Graphics, 2 frames -- Pogo front.
@ $C71E label=gfx_c71e
B $C71E,120,8 #HTML[<img src="images/gfx/gfx-c71e.png">]
N $C71E Graphics, 4 frames -- masks for Pogo.
@ $C796 label=gfx_c796
B $C796,120,8 #HTML[<img src="images/gfx/gfx-c796.png">]
N $C796 Graphics, 4 frames -- masks for Pogo.
@ $C80E label=gfx_c80e
B $C80E,120,8 #HTML[<img src="images/gfx/gfx-c80e.png">]
N $C80E Graphics, 4 frames -- masks for Pogo.
@ $C886 label=gfx_c886
B $C886,120,8 #HTML[<img src="images/gfx/gfx-c886.png">]
N $C886 Graphics, 4 frames -- masks for Pogo.
@ $C8FE label=gfx_c8fe
B $C8FE,120,8 #HTML[<img src="images/gfx/gfx-c8fe.png">]
N $C8FE Graphics, 4 frames -- masks for Pogo.
@ $C976 label=gfx_c976
B $C976,80,8 #HTML[<img src="images/gfx/gfx-c976.png">]
N $C976 Graphics, 2 frames -- Pogo rotating.
@ $C9C6 label=gfx_c9c6
B $C9C6,80,8 #HTML[<img src="images/gfx/gfx-c9c6.png">]
N $C9C6 Graphics, 2 frames -- Pogo rotating.
@ $CA16 label=gfx_ca16
B $CA16,80,8 #HTML[<img src="images/gfx/gfx-ca16.png">]
N $CA16 Graphics, 2 frames -- Pogo back.
@ $CA66 label=gfx_ca66
B $CA66,80,8 #HTML[<img src="images/gfx/gfx-ca66.png">]
N $CA66 Graphics, 2 frames.
@ $CAB6 label=gfx_cab6
B $CAB6,80,8 #HTML[<img src="images/gfx/gfx-cab6.png">]
N $CAB6 Graphics, 2 frames -- Pogo back going from camera.
@ $CB06 label=gfx_cb06
B $CB06,80,8 #HTML[<img src="images/gfx/gfx-cb06.png">]
N $CB06 Graphics, 2 frames -- Pogo back going from camera.
@ $CB56 label=gfx_cb56
B $CB56,80,8 #HTML[<img src="images/gfx/gfx-cb56.png">]
N $CB56 Graphics, 2 frames -- Pogo front going to camera.
@ $CBA6 label=gfx_cba6
B $CBA6,80,8 #HTML[<img src="images/gfx/gfx-cba6.png">]
N $CBA6 Graphics, 2 frames -- Pogo front going to camera.
@ $CBF6 label=gfx_cbf6
B $CBF6,80,8 #HTML[<img src="images/gfx/gfx-cbf6.png">]
N $CBF6 Graphics, 2 frames -- Pogo front going to camera.
@ $CC46 label=gfx_cc46
B $CC46,120,8 #HTML[<img src="images/gfx/gfx-cc46.png">]
N $CC46 Graphics, 4 frames -- Pogo masks.
@ $CCBE label=gfx_ccbe
B $CCBE,120,8 #HTML[<img src="images/gfx/gfx-ccbe.png">]
N $CCBE Graphics, 4 frames -- Pogo masks.
@ $CD36 label=gfx_cd36
B $CD36,120,8 #HTML[<img src="images/gfx/gfx-cd36.png">]
N $CD36 Graphics, 4 frames -- Pogo masks.
@ $CDAE label=gfx_cdae
B $CDAE,120,8 #HTML[<img src="images/gfx/gfx-cdae.png">]
N $CDAE Graphics, 4 frames -- Pogo masks.
@ $CE26 label=gfx_ce26
B $CE26,120,8 #HTML[<img src="images/gfx/gfx-ce26.png">]
N $CE26 Graphics, 4 frames -- Pogo masks.
@ $CE9E label=gfx_ce9e
B $CE9E,120,8 #HTML[<img src="images/gfx/gfx-ce9e.png">]
N $CE9E Graphics, 4 frames -- Pogo masks.
@ $CF16 label=gfx_cf16
B $CF16,120,8 #HTML[<img src="images/gfx/gfx-cf16.png">]
N $CF16 Graphics, 4 frames -- Pogo masks.
@ $CF8E label=gfx_cf8e
B $CF8E,80,8 #HTML[<img src="images/gfx/gfx-cf8e.png">]
N $CF8E Graphics, 2 frames -- bubbles animation phases.
@ $CFDE label=gfx_cfde
B $CFDE,80,8 #HTML[<img src="images/gfx/gfx-cfde.png">]
N $CFDE Graphics, 2 frames -- bubbles animation phases.
@ $D02E label=gfx_d02e
B $D02E,80,8 #HTML[<img src="images/gfx/gfx-d02e.png">]
N $D02E Graphics, 2 frames -- bubbles animation phases.
@ $D07E label=gfx_d07e
B $D07E,80,8 #HTML[<img src="images/gfx/gfx-d07e.png">]
N $D07E Graphics, 2 frames -- bubbles animation phases.
@ $D0CE label=gfx_d0ce
B $D0CE,120,8 #HTML[<img src="images/gfx/gfx-d0ce.png">]
N $D0CE Graphics, 4 frames -- Pogo masks.
@ $D146 label=gfx_d146
B $D146,120,8 #HTML[<img src="images/gfx/gfx-d146.png">]
N $D146 Graphics, 4 frames -- Pogo masks.
@ $D1BE label=gfx_d1be
B $D1BE,120,8 #HTML[<img src="images/gfx/gfx-d1be.png">]
N $D1BE Graphics, 4 frames -- Pogo masks.
@ $D236 label=gfx_d236
B $D236,120,8 #HTML[<img src="images/gfx/gfx-d236.png">]
N $D236 Graphics, 4 frames -- Pogo masks.
@ $D2AE label=gfx_d2ae
B $D2AE,120,8 #HTML[<img src="images/gfx/gfx-d2ae.png">]
N $D2AE Graphics, 4 frames -- Pogo masks.
@ $D326 label=gfx_d326
B $D326,120,8 #HTML[<img src="images/gfx/gfx-d326.png">]
N $D326 Graphics, 4 frames -- Pogo masks.
@ $D39E label=gfx_d39e
B $D39E,120,8 #HTML[<img src="images/gfx/gfx-d39e.png">]
N $D39E Graphics, 4 frames -- Pogo masks.
@ $D416 label=gfx_d416
B $D416,120,8 #HTML[<img src="images/gfx/gfx-d416.png">]
N $D416 Graphics, 4 frames -- Pogo masks.
@ $D48E label=gfx_d48e
B $D48E,120,8 #HTML[<img src="images/gfx/gfx-d48e.png">]
N $D48E Graphics, 4 frames -- Pogo masks.
@ $D506 label=gfx_d506
B $D506,80,8 #HTML[<img src="images/gfx/gfx-d506.png">]
N $D506 Graphics, 2 frames -- Pogo rotating.
@ $D556 label=gfx_d556
B $D556,80,8 #HTML[<img src="images/gfx/gfx-d556.png">]
N $D556 Graphics, 2 frames -- Pogo rotating.
@ $D5A6 label=gfx_d5a6
B $D5A6,80,8 #HTML[<img src="images/gfx/gfx-d5a6.png">]
N $D5A6 Graphics, 2 frames -- Pogo rotating.
@ $D5F6 label=gfx_d5f6
B $D5F6,120,8 #HTML[<img src="images/gfx/gfx-d5f6.png">]
N $D5F6 Graphics, 4 frames -- Pogo masks.
@ $D66E label=gfx_d66e
B $D66E,120,8 #HTML[<img src="images/gfx/gfx-d66e.png">]
N $D66E Graphics, 4 frames -- Pogo masks.
@ $D6E6 label=gfx_d6e6
B $D6E6,120,8 #HTML[<img src="images/gfx/gfx-d6e6.png">]
N $D6E6 Graphics, 4 frames -- Pogo masks.
@ $D75E label=gfx_d75e
B $D75E,120,8 #HTML[<img src="images/gfx/gfx-d75e.png">]
N $D75E Graphics, 4 frames -- Pogo masks.
@ $D7D6 label=gfx_d7d6
B $D7D6,120,8 #HTML[<img src="images/gfx/gfx-d7d6.png">]
N $D7D6 Graphics, 4 frames -- Pogo masks.
@ $D84E label=gfx_d84e
B $D84E,80,8 #HTML[<img src="images/gfx/gfx-d84e.png">]
N $D84E Graphics, 2 frames.
@ $D89E label=gfx_d89e
B $D89E,80,8 #HTML[<img src="images/gfx/gfx-d89e.png">]
N $D89E Graphics, 2 frames.
@ $D8EE label=gfx_d8ee
B $D8EE,80,8 #HTML[<img src="images/gfx/gfx-d8ee.png">]
N $D8EE Graphics, 2 frames.
@ $D93E label=gfx_d93e
B $D93E,80,8 #HTML[<img src="images/gfx/gfx-d93e.png">]
N $D93E Graphics, 2 frames.
@ $D98E label=gfx_d98e
B $D98E,80,8 #HTML[<img src="images/gfx/gfx-d98e.png">]
N $D98E Graphics, 2 frames.
@ $D9DE label=gfx_d9de
B $D9DE,80,8 #HTML[<img src="images/gfx/gfx-d9de.png">]
N $D9DE Graphics, 2 frames.
@ $DA2E label=gfx_da2e
B $DA2E,80,8 #HTML[<img src="images/gfx/gfx-da2e.png">]
N $DA2E Graphics, 2 frames.
@ $DA7E label=gfx_da7e
B $DA7E,80,8 #HTML[<img src="images/gfx/gfx-da7e.png">]
N $DA7E Graphics, 2 frames.
@ $DACE label=gfx_dace
B $DACE,80,8 #HTML[<img src="images/gfx/gfx-dace.png">]
N $DACE Graphics, 2 frames.
@ $DB1E label=gfx_db1e
B $DB1E,120,8 #HTML[<img src="images/gfx/gfx-db1e.png">]
N $DB1E Graphics, 4 frames.
@ $DB96 label=gfx_db96
B $DB96,120,8 #HTML[<img src="images/gfx/gfx-db96.png">]
N $DB96 Graphics, 4 frames.
@ $DC0E label=gfx_dc0e
B $DC0E,120,8 #HTML[<img src="images/gfx/gfx-dc0e.png">]
N $DC0E Graphics, 4 frames.
@ $DC86 label=gfx_dc86
B $DC86,120,8 #HTML[<img src="images/gfx/gfx-dc86.png">]
N $DC86 Graphics, 4 frames.
@ $DCFE label=gfx_dcfe
B $DCFE,120,8 #HTML[<img src="images/gfx/gfx-dcfe.png">]
N $DCFE Graphics, 4 frames.
@ $DD76 label=gfx_dd76
B $DD76,120,8 #HTML[<img src="images/gfx/gfx-dd76.png">]
N $DD76 Graphics, 4 frames.
@ $DDEE label=gfx_ddee
B $DDEE,120,8 #HTML[<img src="images/gfx/gfx-ddee.png">]
N $DDEE Graphics, 4 frames.
@ $DE66 label=gfx_de66
B $DE66,80,8 #HTML[<img src="images/gfx/gfx-de66.png">]
N $DE66 Graphics, 2 frames.
@ $DEB6 label=gfx_deb6
B $DEB6,80,8 #HTML[<img src="images/gfx/gfx-deb6.png">]
N $DEB6 Graphics, 2 frames.
@ $DF06 label=gfx_df06
B $DF06,80,8 #HTML[<img src="images/gfx/gfx-df06.png">]
N $DF06 Graphics, 2 frames.
@ $DF56 label=gfx_df56
B $DF56,80,8 #HTML[<img src="images/gfx/gfx-df56.png">]
N $DF56 Graphics, 2 frames.
@ $DFA6 label=gfx_dfa6
B $DFA6,32,8 #HTML[<img src="images/gfx/gfx-dfa6.png">]
N $DFA6 Graphics, 2 frames.
@ $DFC6 label=gfx_dfc6
B $DFC6,32,8 #HTML[<img src="images/gfx/gfx-dfc6.png">]
N $DFC6 Graphics, 2 frames.
@ $DFE6 label=gfx_dfe6
B $DFE6,32,8 #HTML[<img src="images/gfx/gfx-dfe6.png">]
N $DFE6 Graphics, 2 frames.
@ $E006 label=gfx_e006
B $E006,32,8 #HTML[<img src="images/gfx/gfx-e006.png">]
N $E006 Graphics, 2 frames.
@ $E026 label=gfx_e026
B $E026,64,8 #HTML[<img src="images/gfx/gfx-e026.png">]
N $E026 Graphics, 2 frames.
@ $E066 label=gfx_e066
B $E066,96,8 #HTML[<img src="images/gfx/gfx-e066.png">]
N $E066 Graphics, 3 frames.
@ $E0C6 label=gfx_e0c6
B $E0C6,96,8 #HTML[<img src="images/gfx/gfx-e0c6.png">]
N $E0C6 Graphics, 3 frames.
@ $E126 label=gfx_e126
B $E126,96,8 #HTML[<img src="images/gfx/gfx-e126.png">]
N $E126 Graphics, 3 frames.
@ $E186 label=gfx_e186
B $E186,64,8 #HTML[<img src="images/gfx/gfx-e186.png">]
N $E186 Graphics, 2 frames.
@ $E1C6 label=gfx_e1c6
B $E1C6,96,8 #HTML[<img src="images/gfx/gfx-e1c6.png">]
N $E1C6 Graphics, 3 frames.
@ $E226 label=gfx_e226
B $E226,96,8 #HTML[<img src="images/gfx/gfx-e226.png">]
N $E226 Graphics, 3 frames.
@ $E286 label=gfx_e286
B $E286,96,8 #HTML[<img src="images/gfx/gfx-e286.png">]
N $E286 Graphics, 3 frames.
@ $E2E6 label=gfx_e2e6
B $E2E6,64,8 #HTML[<img src="images/gfx/gfx-e2e6.png">]
N $E2E6 Graphics, 2 frames.
@ $E326 label=gfx_e326
B $E326,96,8 #HTML[<img src="images/gfx/gfx-e326.png">]
N $E326 Graphics, 3 frames.
@ $E386 label=gfx_e386
B $E386,96,8 #HTML[<img src="images/gfx/gfx-e386.png">]
N $E386 Graphics, 3 frames.
@ $E3E6 label=gfx_e3e6
B $E3E6,96,8 #HTML[<img src="images/gfx/gfx-e3e6.png">]
N $E3E6 Graphics, 3 frames.
@ $E446 label=gfx_e446
B $E446,64,8 #HTML[<img src="images/gfx/gfx-e446.png">]
N $E446 Graphics, 2 frames.
@ $E486 label=gfx_e486
B $E486,64,8 #HTML[<img src="images/gfx/gfx-e486.png">]
N $E486 Graphics, 2 frames.
@ $E4C6 label=gfx_e4c6
B $E4C6,64,8 #HTML[<img src="images/gfx/gfx-e4c6.png">]
N $E4C6 Graphics, 2 frames.
@ $E506 label=gfx_e506
B $E506,96,8 #HTML[<img src="images/gfx/gfx-e506.png">]
N $E506 Graphics, 3 frames.
@ $E566 label=gfx_e566
B $E566,64,8 #HTML[<img src="images/gfx/gfx-e566.png">]
N $E566 Graphics, 2 frames.
@ $E5A6 label=gfx_e5a6
B $E5A6,64,8 #HTML[<img src="images/gfx/gfx-e5a6.png">]
N $E5A6 Graphics, 2 frames.
@ $E5E6 label=gfx_e5e6
B $E5E6,96,8 #HTML[<img src="images/gfx/gfx-e5e6.png">]
N $E5E6 Graphics, 3 frames.
@ $E646 label=gfx_e646
B $E646,96,8 #HTML[<img src="images/gfx/gfx-e646.png">]
N $E646 Graphics, 3 frames.
@ $E6A6 label=gfx_e6a6
B $E6A6,64,8 #HTML[<img src="images/gfx/gfx-e6a6.png">]
N $E6A6 Graphics, 2 frames.
@ $E6E6 label=gfx_e6e6
B $E6E6,96,8 #HTML[<img src="images/gfx/gfx-e6e6.png">]
N $E6E6 Graphics, 3 frames.
@ $E746 label=gfx_e746
B $E746,96,8 #HTML[<img src="images/gfx/gfx-e746.png">]
N $E746 Graphics, 3 frames.
@ $E7A6 label=gfx_e7a6
B $E7A6,96,8 #HTML[<img src="images/gfx/gfx-e7a6.png">]
N $E7A6 Graphics, 3 frames.
@ $E806 label=gfx_e806
B $E806,64,8 #HTML[<img src="images/gfx/gfx-e806.png">]
N $E806 Graphics, 2 frames.
@ $E846 label=gfx_e846
B $E846,96,8 #HTML[<img src="images/gfx/gfx-e846.png">]
N $E846 Graphics, 3 frames.
@ $E8A6 label=gfx_e8a6
B $E8A6,96,8 #HTML[<img src="images/gfx/gfx-e8a6.png">]
N $E8A6 Graphics, 3 frames.
@ $E906 label=gfx_e906
B $E906,96,8 #HTML[<img src="images/gfx/gfx-e906.png">]
N $E906 Graphics, 3 frames.
@ $E966 label=gfx_e966
B $E966,64,8 #HTML[<img src="images/gfx/gfx-e966.png">]
N $E966 Graphics, 2 frames.
@ $E9A6 label=gfx_e9a6
B $E9A6,96,8 #HTML[<img src="images/gfx/gfx-e9a6.png">]
N $E9A6 Graphics, 3 frames.
@ $EA06 label=gfx_ea06
B $EA06,96,8 #HTML[<img src="images/gfx/gfx-ea06.png">]
N $EA06 Graphics, 3 frames.
@ $EA66 label=gfx_ea66
B $EA66,96,8 #HTML[<img src="images/gfx/gfx-ea66.png">]
N $EA66 Graphics, 3 frames.
@ $EAC6 label=gfx_eac6
B $EAC6,64,8 #HTML[<img src="images/gfx/gfx-eac6.png">]
N $EAC6 Graphics, 2 frames.
@ $EB06 label=gfx_eb06
B $EB06,96,8 #HTML[<img src="images/gfx/gfx-eb06.png">]
N $EB06 Graphics, 3 frames.
@ $EB66 label=gfx_eb66
B $EB66,96,8 #HTML[<img src="images/gfx/gfx-eb66.png">]
N $EB66 Graphics, 3 frames.
@ $EBC6 label=gfx_ebc6
B $EBC6,96,8 #HTML[<img src="images/gfx/gfx-ebc6.png">]
N $EBC6 Graphics, 3 frames.
@ $EC26 label=gfx_ec26
B $EC26,64,8 #HTML[<img src="images/gfx/gfx-ec26.png">]
N $EC26 Graphics, 2 frames.
@ $EC66 label=gfx_ec66
B $EC66,96,8 #HTML[<img src="images/gfx/gfx-ec66.png">]
N $EC66 Graphics, 3 frames.
@ $ECC6 label=gfx_ecc6
B $ECC6,96,8 #HTML[<img src="images/gfx/gfx-ecc6.png">]
N $ECC6 Graphics, 3 frames.
@ $ED26 label=gfx_ed26
B $ED26,96,8 #HTML[<img src="images/gfx/gfx-ed26.png">]
N $ED26 Graphics, 3 frames.
@ $ED86 label=gfx_ed86
B $ED86,80,8 #HTML[<img src="images/gfx/gfx-ed86.png">]
N $ED86 Graphics, 2 frames.
@ $EDD6 label=gfx_edd6
B $EDD6,80,8 #HTML[<img src="images/gfx/gfx-edd6.png">]
N $EDD6 Graphics, 2 frames.
@ $EE26 label=gfx_ee26
B $EE26,80,8 #HTML[<img src="images/gfx/gfx-ee26.png">]
N $EE26 Graphics, 2 frames.
@ $EE76 label=gfx_ee76
B $EE76,80,8 #HTML[<img src="images/gfx/gfx-ee76.png">]
N $EE76 Graphics, 2 frames.
@ $EEC6 label=gfx_eec6
B $EEC6,120,8 #HTML[<img src="images/gfx/gfx-eec6.png">]
N $EEC6 Graphics, 3 frames.
b $EF3E
b $F000
@ $F000 label=work_buffers
@ $FC00 label=loader_entry
T $FC21
b $FC2C
@ $FC8A label=tape_read_byte
c $FC8A Tape read byte
N $FC8A Read one byte from tape with the custom turbo edge-timing loop (ULA EAR bit via IN ($FE), border feedback via OUT ($FE)).
N $FC8A Accumulates 8 bits CY=success, NC=load error/abort.
C $FCA0,3 Tape get edge
C $FCC5,3 Tape get edge
C $FCCF,3 Tape get edge
@ $FD1C label=tape_edge_pair
C $FD1C,3 Tape get edge
@ $FD20 label=tape_get_edge
c $FD20 Tape get edge
N $FD20 Measure one tape signal edge on the EAR line (IN A,($FE) with row $7F), toggling the reference in C times out via B.
N $FD20 Out: CY=edge seen.
N $FD20 Clobbers: A,B,C.
T $FD30
b $FD34
T $FD49
b $FD4C
T $FD4E
b $FD53
T $FD8D
b $FD90
T $FDC3
b $FDC6
@ $FE0F label=loader_progress
T $FE2D
b $FE31
@ $FE5C label=tape_load_header
c $FE5C Tape load header
N $FE5C Load the 17-byte ($0011) block header into the buffer at #R$FC21 (via tape_read_byte) and validate the $2A signature byte retries on mismatch.
N $FE5C Clobbers: A,DE,IX.
C $FE69,3 Tape read byte
C $FE88,3 Tape read byte
T $FECB
b $FED0
@ $FF00 label=tail_unused
s $FFA7
