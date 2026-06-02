b $4000 Screen
D $4000 #UDGTABLE { #SCR(loading) } TABLE#
B $4000,6144,32 Pixels
B $5800,768,32 Attributes
@ $5B00 start
@ $5B00 org
b $5B00
T $5B14
b $5B40
T $5C5A
b $5C5D
T $5C5E
b $5C68
T $5CEB
b $5CF0
T $5D12
b $5D20
T $5D8F
b $5DA0
T $5E0F
b $5E20
T $6222
b $6254
T $629F
b $62D6
T $6400
b $6408
T $640B
b $640E
T $6411
b $642D
T $642E
b $6431
T $6432
b $6437
T $6438
b $6441
T $6442
b $6447
T $6448
b $644B
T $644C
b $6453
T $6454
b $6460
T $6612
b $6618
T $661B
b $6620
T $6621
b $6626
T $6629
b $662F
T $6631
b $6650
T $6693
b $6699
T $669C
b $669F
T $66A2
b $66A8
T $66AA
b $66B1
T $66B2
b $66D0
T $6714
b $671A
T $6723
b $6729
T $672B
b $6732
T $6733
b $6750
T $6795
b $679B
T $67A4
b $67AA
T $67AC
b $67D0
T $6816
b $681C
T $6825
b $682B
T $682D
b $6850
T $6897
b $689D
T $68A6
b $68AC
T $68AE
b $68D0
T $6918
b $691E
T $6927
b $692D
T $692F
b $6950
T $6999
b $699F
T $69A2
b $69A5
T $69A8
b $69AE
T $69B0
b $69D0
T $6C11
b $6C18
T $701A
b $7022
T $702C
b $7030
T $7292
b $7296
T $781F
b $7824
T $782B
b $782E
T $7A10
b $7A14
@ $8000 label=game_entry
c $8000 GAME ENTRY -- cold-start, reached from the resident loader.
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
C $800A,2 ULA port FE: border=black(0), MIC/beeper off (i8080: OUT to ULA-equiv)
C $800C,3 init #1 -- install IM 2 interrupt vector (see setup_im2)
C $800F,3 init #2 = clear screen + game RAM (jp_clear_screen trampoline)
C $8012,3 init #3 = paint playfield attributes (jp_setup_attrs trampoline)
C $8015,2 A = 1
C $8017,3 first persistent-state write: running_flag = 1
@ $801A label=new_game
c $801A NEW_GAME -- set up a fresh game/level and run it.
N $801A Falls in from game_entry's init chain.
N $801A Seeds state vars, builds the level, draws the screen, then enters main_loop.
N $801A On death/level-end it loops back to level_retry or game-over handling.
C $801A,2 A=$80 -> $6056 (start flag/counter)
C $8026,2 4 attempts/lives -> $6017
@ $802B label=level_retry
c $802B
C $802F,3 show title screen / menu (waits for start)
C $8032,3 seed per-player column-state words
C $8035,3 proc_table slot: build tower / level layout
C $803D,3 restore_col_state (CY = success)
C $8045,2 carry clear -> rebuild (retry)
C $8050,3 draw the heading/menu text
@ $8064 label=main_loop
c $8064 MAIN_LOOP -- the in-play frame loop.
N $8064 Each pass runs main_tick (one frame) then checks end conditions: death_flag ($60C3) set      -> life-loss handler ($8084) game_state ($60D9) == 2     -> level-complete ($80B2) play_timer ($6053) == 0     -> time-up ($8081) Otherwise CALL $8115 (status update) and loop.
C $8064,3 run one frame of the game
C $8067,3 player died this frame?
C $806B,2 yes -> life-loss handler
C $806D,3 level-complete state?
C $8072,2 yes -> level-complete handler
C $8074,3 play_timer reached 0?
C $8079,2 yes -> time-up
C $807B,3 per-frame status/HUD update
C $807E,3 loop
C $8081,3 time-up handler
@ $8084 label=on_death
@ $80B2 label=on_level_done
@ $8115 label=poll_controls
c $8115 POLL_CONTROLS -- per-frame keyboard handling (called from main_loop).
N $8115 Skipped while input is frozen (freeze_ctr).
N $8115 - restart key (via $A70F): NC -> jump to level_retry
N $8115 - several control keys toggle ctrl_flag ($60D7) / pad_var_8005
N $8115 - PAUSE/DEMO: key $21 enters demo_pause any joystick X exits
N $8115 - menu select: tests a column of 8 keys the index of the one pressed (0..7) -> pad_var_8005, then restarts setup at $8032.
N $8115 Uses test_key ($A706) for t
C $8115,3 A = freeze_ctr
C $8119,1 frozen -> do nothing this frame
C $811D,3 restart condition -> rebuild level
C $8137,3 set ctrl_flag ($60D7) = 1
C $8148,3 A = demo_pause
C $815B,2 enter demo/pause mode (demo_pause = $FF)
C $8165,3 demo active: read joystick
C $816C,2 no X movement -> stay in demo
C $816F,3 movement -> exit demo
C $8189,2 --- menu key-column scan: B = option index ---
C $8195,3 test each option key
C $81CA,1 none pressed -> return
C $81CB,1 a key matched: B = selected option
C $81CC,3 store selection -> pad_var_8005
C $81D4,3 restart game setup with the new selection
@ $81D7 label=setup_level
c $81D7 SETUP_LEVEL -- (re)build the current level's working state.
N $81D7 Zeroes the work_buffers block ($F000.., $0FFF bytes via LDIR), loads the level's column data (load_level_col), resets the tower position (init_tower_pos), re-inits flags (init_b5cf) and the renderers ($8FB7, $96D4).
N $81D7 Clobbers: most.
@ $8240 label=main_tick
c $8240 MAIN_TICK -- one frame of the game.
N $8240 Called from main_loop.
N $8240 Order: read input (unless frozen) -> run game-state machine (player move, tower rotation, enemies) -> redraw widgets -> HALT to sync to the 50Hz frame interrupt.
N $8240 State: game_state ($60D9): 3=level transition, 4=finished,
N $8240 else = normal play.
N $8240 demo_pause ($60D8) skips logic.
N $8240 freeze_ctr ($8004) freezes input for N frames.
N $8240 Clobbers: most regs.
N $8240 Returns once per frame.
N $8240 i8080 PORT:
C $8240,3 HL -> freeze_ctr (in code padding at $8004)
C $8243,1 A = freeze counter
C $8245,2 0 = not frozen -> read input normally
C $8247,1 frozen: count down one frame
C $8249,3 zero the three input vars while frozen
C $8254,3 proc_table[0] -> read keyboard/joystick
C $8257,3 A = demo_pause flag
C $825B,2 set -> skip all game logic (attract/demo), just redraw
C $825D,3 A = game_state
C $8260,2 state 3 = level transition?
C $8264,3 run transition step
C $826C,1 state 4 = finished -> done this frame
C $8270,3 --- normal play: update one frame ---
C $8273,3 update actor position around/along the tower (update_actor_pos)
C $8276,3 advance level logic
C $8279,3 A = player column before move
C $827D,3 move player (proc_table slot)
C $8282,3 compare new vs old player column
C $8288,3 column changed -> CALL $A3DE (redraw player cell)
C $828B,3 update enemies/hazards
C $828E,3 collision + scoring
C $8291,2 --- redraw HUD: A = $24 (36 rows) ---
C $8296,1 subtract tower_height ($60B9)
C $8299,3 store display height ($6032)
C $829C,3 draw widgets (proc_table slots)
C $82A9,3 draw the player sprite
C $82AC,1 HALT: wait for the 50Hz frame IRQ (Z80
C $82AD,3 post-frame: flip buffers / housekeeping
@ $82DA label=tally_score_to
c $82DA TALLY_SCORE_TO -- count $60BC up toward $60BA, awarding $10 (BCD) points per step via add_bcd_score, until the two 16-bit values meet.
N $82DA Used to animate an end-of-section bonus tally.
N $82DA Clobbers: A,DE,HL.
@ $8301 label=col_state_words
s $8301
@ $8305 label=init_col_state
c $8305 INIT_COL_STATE -- seed BOTH players' saved column-mask words.
N $8305 HL = (pad_var_8005) [low=0 at level start], then H forced to $FF (all 8 columns present) the same $FF00|sel is written to the P1 ($8301) and P2 ($8303) slots.
N $8305 Called once per level build.
N $8305 In: pad_var_8005.
N $8305 Out: ($8301),($8303).
N $8305 Clobbers: A,HL.
@ $8311 label=restore_col_state
c $8311 RESTORE_COL_STATE -- expand a player's saved column bitmask into the 8-byte col_flags[] array ($60CB) and mirror its counter into $6039.
N $8311 lives_p1 ($6040) selects the slot (0=P1 word $8301, else P2 word $8303) -- here $6040 doubles as an ACTIVE-PLAYER INDEX, not a life count.
N $8311 running_flag gates an alternate (re)init path.
N $8311 Unpacks via RR through col_flags[] returns CY=1 on success.
N $8311 Out: col_flags[0..7], $6039, CY.
N $8311 Clobbers: A,B,C,H
@ $8360 label=pack_col_state
c $8360 PACK_COL_STATE -- inverse of restore_col_state.
N $8360 Writes the live counter ($6039) into the selected player's low byte, then packs the 8 col_flags[] LSBs ($60CB..$60D2) back into the high mask byte.
N $8360 lives_p1 selects the P1/P2 slot.
N $8360 Clobbers: A,B,C,HL.
@ $8382 label=clear_col_mask
c $8382 CLEAR_COL_MASK -- zero the selected player's column mask byte (high byte of $8301/$8303).
N $8382 lives_p1 selects the slot.
@ $8390 label=advance_col_counter
c $8390 ADVANCE_COL_COUNTER -- mark current column done: clear col_flags[$6039], then bump the selected player's saved counter (low byte) and mirror it back to $6039.
@ $83AD label=setup_im2
c $83AD SETUP_IM2 -- install the Z80 mode-2 interrupt vector.
N $83AD Builds a 257-byte page of identical bytes at $BB00..$BC00 so that, whatever the data-bus byte is at IRQ time, the Z80 reads the 16-bit vector $BABA from table[$FF]/table[$100].
N $83AD At $BABA it plants 'JP $83CA' -- the actual interrupt service routine.
N $83AD In:  nothing.
N $83AD Out: IM 2 active, IFF1=1 (interrupts enabled).
N $83AD Clobbers: A, B, HL, I.
N $83AD i8080 PORT: the 8080 has no IM 2.
N $83AD The porter must emulate this
C $83AD,1 no IRQs while we build the vector table (i8080: DI)
C $83AE,3 HL -> vector-table page base $BB00
C $83B1,1 A = $BB = high byte of the table page
C $83B2,2 I = $BB: IM2 reads vectors from page I (Z80-only)
C $83B4,1 A = $BA = the byte we flood the table with
C $83B5,2 B = 0 -> DJNZ loops 256 times (Z80 DJNZ: dec B, jump nz)
C $83B7,1 table[i] = $BA
C $83B8,1 next table slot
C $83B9,2 fill all 256 bytes of $BB00..$BBFF (i8080: DCR B/JNZ loop)
C $83BB,1 +1 byte at $BC00 = $BA: covers the table[$100] off-by-one
C $83BC,1 H = $BA
C $83BD,1 L = $BA  -> HL = $BABA (the vector the IRQ will fetch)
C $83BE,2 plant C3 = JP opcode at $BABA
C $83C1,2 low byte of JP target -> $CA
C $83C4,2 high byte -> $83, so vector = 'JP $83CA' = irq_handler
C $83C6,2 switch CPU to interrupt mode 2 (Z80-only)
C $83C8,1 interrupts on
@ $83C9 label=im2_noop_ret
c $83C9
C $83C9,1 return to game_entry
@ $83CA label=irq_handler
c $83CA IRQ_HANDLER -- IM 2 interrupt service routine (50 Hz vblank).
N $83CA Reached via the planted vector at $BABA -> JP here.
N $83CA It is a deliberate NEAR-NO-OP: 'CALL $83C9' targets the bare RET at the end of setup_im2, so the call does nothing.
N $83CA The point is to REPLACE the 48K ROM's own interrupt routine (which scans the keyboard and bumps the FRAMES sysvar) with a handler that has no side effects, while still letting interrupts fire.
N $83CA Verified: no code anywhere
C $83CA,3 CALL $83C9 = the RET in setup_im2: a no-op (neutralized ISR)
C $83CD,1 re-enable interrupts
C $83CE,2 RETI: return from maskable interrupt (Z80-only
@ $83D0 label=init_tower_pos
c $83D0 INIT_TOWER_POS -- reset the tower/scroll position for a new level: tower_height=$04, $60BA/$60BC (current & target column)=8,
N $83D0 scroll_pos = 8-$28, and clear the high bytes $60BB/$60BD.
N $83D0 Clobbers: A.
@ $8411 label=rotate_tower
c $8411 ROTATE_TOWER -- rotate the tower by signed B: tower_height = (tower_height + B) AND $7F (128-column wrap), saving the old value in $6033.
N $8411 Tests the new position for a wall/collision ($9330) on collision (NC) it reverts tower_height.
N $8411 In: B=delta.
N $8411 Out: CY=moved.
N $8411 Clobbers: A,B,HL.
@ $8430 label=step_scroll
c $8430 STEP_SCROLL -- advance the column/scroll position $60BA by signed A (sign-extended via B), folding H into the 4-quadrant range (AND $03) saves the previous position in $6034.
N $8430 Clobbers: A,B,HL.
@ $8460 label=rotate_if_idle
c $8460 ROTATE_IF_IDLE -- if $957A returns a pending step (CY) and there is no vertical input (input_y==0), rotate the tower by it (tail-calls rotate_tower).
N $8460 Clobbers: A,B.
@ $846E label=player_state_table
b $846E
@ $8482 label=player_tick
c $8482 PLAYER_TICK -- per-frame player state machine, run every frame from main_tick (both in normal play AND on the game_state==3 level-transition path TASK.md called this 'the level-transition path' -- it is really the general player update, the transition is just one caller).
N $8482 Preamble debounces directional input: input_latch ($6020) records whether input_x is active so a press fires once a held input is consumed (input_x cleared).
@ $84AF label=pstate_reset
c $84AF
@ $84B9 label=pstate_play
c $84B9
@ $8563 label=pstate_3
c $8563
s $858D
c $8590
c $8596
c $85A1
c $85B0
@ $85DB label=pstate_2
c $85DB
@ $863F label=tbl_863f
b $863F
@ $8656 label=code_8656
c $8656
c $8673
@ $868D label=pstate_1
c $868D
b $86F2
c $8724
@ $8736 label=pstate_4
c $8736
s $879A
c $879B
c $8831
@ $8854 label=pstate_5
c $8854
@ $887B label=update_player_obj
c $887B UPDATE_PLAYER_OBJ -- copy the live tower position ($60BA) into the player object (actor_obj) column fields (+6/+12), biased by tower_height and facing ($60BE bit7).
N $887B Clobbers: A,HL,IX.
s $88AA
c $88AB
@ $88BD label=pstate_6
c $88BD
@ $895B label=collision_test
c $895B
@ $89C5 label=check_collision
c $89C5 CHECK_COLLISION -- test the player against the tower/hazards and apply the result.
N $89C5 Dispatches on player_state ($60C0):
N $89C5 7 = invulnerable/idle -> no test (RET)
N $89C5 4 = check a height window ($60BF in $0A..$1E)
N $89C5 8 = RET else test flag $60C5.
N $89C5 Calls $895B (carry = hit).
N $89C5 On a hit it patches the value at $8A49 (SELF-MODIFYING: $14/$0F/$20 select the bump/death response used downstream) and branches into the hit handler.
N $89C5 i8080 PORT: the LD ($8A49),A se
C $89C5,3 A = player_state ($60C0)
C $89CA,1 state 7: no collision this frame
C $89CF,3 A = $60BF (height-in-column)
C $89E4,3 test player vs world (carry = hit)
C $89E7,2 hit -> hit handler
C $89FB,3 patch response code at $8A49 = $14 (SELF-MOD)
C $8A01,3 A = colliding object state (+48)
C $8A0D,3 patch response code ($0F enemy / $14 wall)
@ $8A49 label=hit_response
s $8A49
@ $8A4A label=coll_apply
c $8A4A
@ $8A61 label=tbl_8a61
b $8A61
@ $8A71 label=code_8a71
c $8A71
@ $8B0E label=pstate_8
s $8B30
@ $8B50 label=sprite_setup
c $8B50 SPRITE_SETUP -- compute on-screen positions for the 4 actor sprites (objects 0..3) ahead of drawing.
N $8B50 Derives a buffer base from tower_height into $600A, fills two coordinate tables at $8B30/$8B40 (X and Y per sprite, via $8BEC/$8BFF), then per object copies sprite id (IX+18 -> IX+24) and stores the screen column (IX+30) from the angular position (IX+0).
N $8B50 Self-mod: $8B30/$8B40 are coordinate scratch buffers IN code.
N $8B50 i8080 PORT: IX object walk -> HL
C $8B50,3 HL -> tower_height
C $8B55,1 4 - height, low 3 bits -> sub-row
C $8B5F,3 DE = $6600 sprite work buffer base
C $8B63,3 store buffer ptr -> $600A
C $8B66,3 fill X-coord table $8B30 (4 sprites, step 8)
C $8B7A,3 fill Y-coord table $8B40 (4 sprites)
C $8B8C,4 IX -> object_table
C $8B93,3 back up sprite id (IX+18 -> IX+24)
C $8B9C,2 state 0 (inactive) -> skip
C $8BA2,2 state 7 -> fixed screen col $40
C $8BA9,3 else screen col from angular pos (IX+0)
C $8BAC,3 store sprite screen column (IX+30)
@ $8BEC label=col_screen_y
c $8BEC COL_SCREEN_Y -- map an actor's angular column to its screen Y / vertical-projection value.
N $8BEC In: A = angular position (0..127).
N $8BEC Offsets by the tower rotation: rel = (A + $20 - tower_height) & $7F, then returns col_y_table[$6380 + rel].
N $8BEC Out: A = projected value.
N $8BEC Preserves HL (PUSH/POP).
N $8BEC i8080 PORT: the AND $7F is the around-the-tower wrap (128 cols) $6380 is a precomputed projection table -- port it verbatim and index with HL + rel.
C $8BED,2 bias by +$20 (quarter turn)
C $8BF2,1 subtract current tower rotation
C $8BF3,2 wrap to 0..127 (around the tower)
C $8BF8,3 HL -> col_y_table ($6380)
C $8BFC,1 A = table[rel] = projected Y/value
@ $8BFF label=col_screen_x
c $8BFF COL_SCREEN_X -- map an actor's angular column to a screen X column, folding the cylinder so only the front face shows.
N $8BFF In: A = angular position (0..127).
N $8BFF rel = (A + $20 - tower_height) & $7F, then fold: rel < $20        -> rel + $20      (left quadrant) $20..$5F         -> $60 - rel      (front, mirrored) rel >= $60       -> rel - $60      (right quadrant) Out: A = screen column.
N $8BFF Preserves HL.
N $8BFF i8080 PORT: pure arithmetic fold of a 7-bit ang
C $8C00,2 bias +$20
C $8C05,1 subtract tower rotation
C $8C06,2 wrap to 0..127
C $8C08,2 left quadrant?
C $8C0C,2 -> rel + $20
C $8C10,2 back face?
C $8C14,2 -> rel - $60 (right quadrant)
C $8C1B,1 front: mirror $60 - rel
@ $8C1E label=sprite_shift_masks
b $8C1E SPRITE_SHIFT_MASKS -- 1bpp AND/shift mask data for drawing the tower-column sprites at sub-byte X offsets (patterns 3F/0F/03/00 FF...).
N $8C1E Base referenced from $8D35/$8F5E.
N $8C1E Interleaved with a few SELF-MODIFIED 1-byte slots ($8C76/$8C77/$8C78/$8C81/$8C82/$8C83/ $8C85) that calc_sprite_shift patches with computed shift counts.
N $8C1E Spans $8C1E..$8CC1 code resumes at calc_sprite_shift.
N $8C1E i8080 PORT: keep as a RAM mask table the self-mod slots become normal
@ $8CC2 label=calc_sprite_shift
c $8CC2 CALC_SPRITE_SHIFT -- for the actor at IX, compute its screen row (via col_screen_y) and the horizontal sub-byte shift, and patch the shift counts into the self-mod slots above ($8C76/77/ 81).
N $8CC2 Reads the column buffer ($600A) to skip empty/edge columns ($0F/$0E sentinels).
N $8CC2 Called from sprite_setup ($8BD0).
N $8CC2 i8080 PORT: replace self-mod patching with RAM shift vars the AND $7F / SRL x3 is the around-tower wrap + /8 byte-column calc.
C $8CC2,3 A = actor angular pos (IX+0)
C $8CC5,3 -> screen row / projected Y
C $8CCE,3 patch self-mod slot $8C81 (row)
C $8CD1,3 HL -> column buffer ($600A)
C $8CD6,2 $0F = empty column -> skip (RET)
C $8CDE,3 A = tower_height (rotation)
C $8CE5,2 /8 -> byte-column shift
C $8CEF,3 patch shift count slot $8C77
C $8CFE,3 patch shift count slot $8C76
@ $8E25 label=expand_sprite_a
c $8E25 EXPAND_SPRITE_A -- unrolled copy of a sprite/mask definition from (HL) to (DE), terminated by $FF.
N $8E25 The alternating OR $00 / AND $00 immediates are SELF-MODIFIED (by calc_sprite_shift) to apply the per-column shift mask.
N $8E25 Clobbers: A,DE,HL.
N $8E25 i8080: self-modifying immediates -- a port may instead pass the mask in a register and AND/OR it.
@ $8EC9 label=expand_sprite_b
@ $8EF1 label=calc_sprite_col
c $8EF1 CALC_SPRITE_COL -- resolve a sprite column: index table $8B30 by A, compare the result against the actor's clip field (IX+30), and patch the shift slot $8C81.
N $8EF1 RET early when within bounds.
N $8EF1 Clobbers: A,DE,HL.
@ $8F31 label=draw_tower_cell
c $8F31 DRAW_TOWER_CELL -- decode one tower cell descriptor byte at (HL): the sign bit and low 2/4 bits select which feature renderer (door / block / gap, pointers $8F8B etc.) to run.
N $8F31 Clobbers: A,HL,...
b $8F75
@ $8FB7 label=clear_actor_states
c $8FB7 CLEAR_ACTOR_STATES -- zero the state byte (+48) of all four object_table actors, deactivating every enemy.
N $8FB7 Clobbers: A,B,IX.
@ $8FC7 label=draw_player
c $8FC7 DRAW_PLAYER -- compute the player sprite's on-screen address from the vertical scroll ($6030) and draw it.
N $8FC7 Handles the tower wrap: the playfield scrolls vertically mod the tower height, so the screen row is ($6030 +/- offset) kept in range.
N $8FC7 Stores the two derived screen pointers ($6057, $6059) then calls the blit helpers ($8B50, $9035).
N $8FC7 In: $6030 = scroll position.
N $8FC7 Out: player drawn.
N $8FC7 Clobbers A,HL.
N $8FC7 i8080 PORT: the SBC/AND $03 wrap math maps the s
C $8FC7,3 HL = scroll position ($6030)
C $8FCB,2 - 8 (sprite top offset)
C $8FD1,2 keep within the 3 screen-thirds (mod via AND 3)
C $8FD4,2 past the wrap point ($3D0)?
C $8FDD,3 -> clamp to top (0)
C $8FE0,3 store upper screen pointer ($6057)
C $8FE7,2 + $4D (sprite body offset)
C $8FF0,3 store lower screen pointer ($6059)
C $8FF3,3 blit sprite (mask + data)
C $8FF6,3 draw attached widgets
@ $8FFA label=draw_actors_sorted
c $8FFA DRAW_ACTORS_SORTED -- draw the 4 actors back-to-front: for depth key C=3..0, find the object whose field (+36) matches and draw it via draw_actor.
N $8FFA Clobbers: A,BC,IX.
@ $9035 label=sprite_depth_sort
c $9035 SPRITE_DEPTH_SORT -- decide the back-to-front draw order of the 4 actor sprites so nearer ones overdraw farther ones around the tower.
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
b $908E DATA_908E -- 64-entry packed draw-order permutation table for sprite_depth_sort.
N $908E Index = 6-bit pairwise-comparison key of the 4 sprites' columns (XOR $3F).
N $908E Each byte packs 4 two-bit object
N $908E indices = the back-to-front draw order.
N $908E Bounded by update_enemies.
@ $90DA label=update_enemies
c $90DA UPDATE_ENEMIES -- step the 4 enemy actors (objects 0..3 of object_table).
N $90DA For each: dispatch on its state (+48):
N $90DA 0 = inactive (skip), 7 = patrol/home toward player_col,
N $90DA 4/6 = -> $9158, 5 = phase countdown (+42).
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
s $9327
@ $9330 label=check_rotate_collision
c $9330 CHECK_ROTATE_COLLISION -- player-move collision probe.
N $9330 Loads the self-mod probe params (column $9329=A, direction step $932A=$FD, span $932B/$932C, plus $9432/$9437) then runs the shared cell probe at $9395.
N $9330 In: A=column.
N $9330 Out: CY/flags from the probe.
@ $934C label=check_actor_collision_a
c $934C
@ $9372 label=check_actor_collision_b
c $9372
@ $9395 label=run_cell_probe
@ $9493 label=pos_to_col
c $9493
@ $949D label=read_player_cell
c $949D READ_PLAYER_CELL -- compute and read the tower-map cell at the player's position (from $60BA via pos_to_col and tower_height), returning the cell contents for the pstate_play logic.
N $949D Clobbers: A,C,HL.
b $94F6
@ $9516 label=player_cell_addr
c $9516 PLAYER_CELL_ADDR -- return HL = address in the $F000 tower map of the player's current cell (column from $60BA, row from tower_height>>3, page $F0+).
N $9516 Clobbers: A,HL.
@ $952A label=test_cell_special
c $952A TEST_CELL_SPECIAL -- read the cell under the player return CY=1 with A=its $40 flag when it is a 'special' cell (type bits == 3), else NC.
N $952A Clobbers: A,B,HL.
@ $9540 label=check_conveyor
c $9540 CHECK_CONVEYOR -- read the cell left of the player if it is a conveyor/lift tile ($85 -> +1, $89 -> -1, $8D -> 0) return that direction in A with CY set, else NC.
N $9540 Clobbers: A,HL.
@ $955B label=consume_cell
c $955B CONSUME_CELL -- if the cell left of the player is a collectable (type bits==1, subtype $10) remove it from the map (LD (HL),$00).
N $955B Clobbers: A,B,HL.
@ $957A label=check_step_cell
c $957A CHECK_STEP_CELL -- probe the cell left of the player for a step/ ledge (type bits==1, subtype $20/$30) and return its movement code (used by rotate_if_idle to auto-step).
N $957A Clobbers: A,B,HL.
b $959F
T $95B2
b $95B9
@ $95BD label=check_collisions
c $95BD CHECK_COLLISIONS -- test actor IX against the four object_table entries for an overlap (runs with interrupts off).
N $95BD On a hit it jumps to the hit handler at $9648.
N $95BD Skips comparing the actor with itself.
N $95BD Clobbers: A,DE,HL,IY (IX preserved).
@ $9657 label=read_actor_cell
c $9657 READ_ACTOR_CELL -- compute the tower-map cell address for actor IX (column IX+0>>3, position IX+6/IX+12) and read the cell there the actor counterpart of player_cell_addr.
N $9657 Clobbers: A,HL.
@ $96D4 label=reset_actor_phase
c $96D4
@ $96DD label=move_curve
b $96DD
@ $96E9 label=update_actor_pos
c $96E9 UPDATE_ACTOR_POS -- advance one actor's position around/along the tower for this frame.
N $96E9 IX = actor_obj ($605F).
N $96E9 Fields used: (IX+0)  angular column around the tower (accumulated mod 128) (IX+6)  vertical position, low  (sub-pixel) (IX+12) vertical position, high (0..3) (IX+18) per-frame scratch, cleared on entry (IX+42) animation/move phase 0..$0C ($FF = inactive/done) (IX+48) actor state (2,4,5,8,9 -- see transitions below) (IX+54)
C $96E9,4 IX -> actor struct base ($605F)
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
C $9727,3 collision test (carry set = blocked)
C $972A,2 blocked -> mark move done
C $972C,3 landing/edge test (NC = no event)
C $9735,3 branch on actor state (+48)
C $9748,4 state 2: arm phase=$4B, state=5
C $9752,4 default: state=4, phase=0
@ $976F label=text_strings
b $976F TEXT_STRINGS -- menu / level-name / status text, $976F..$9952.
N $976F Each entry is [colour-control byte <$10] + ASCII + 00.
N $976F Rendered by print_string / print_centered.
N $976F text_ptr_table ($9953) and direct LD HL,addr sites index into this block.
T $9770
b $977E
T $9780
b $978A
T $978C
b $9796
T $9798
b $97A5
T $97A7
b $97B4
T $97B6
b $97C5
T $97C7
b $97D5
T $97D7
b $97E5
T $97E7
b $97F2
T $97F4
b $9804
T $9806
b $980F
T $9811
b $981D
T $981F
b $982E
T $9830
b $983D
T $983F
b $984F
T $9851
b $985D
T $985F
b $986F
T $9871
b $9881
T $9883
b $9893
T $9895
b $98A4
T $98A6
b $98AE
T $98B0
b $98B9
T $98BB
b $98C7
T $98C9
b $98D3
T $98D5
b $98E1
T $98E4
b $98EF
T $98F1
b $98F9
T $98FB
b $9903
T $9905
b $990D
T $990F
b $9917
T $9919
b $9926
T $9928
b $9934
T $9936
b $9942
T $9944
b $9952
@ $9953 label=text_ptr_table
@ $9963 label=code_9963
c $9963
@ $99A1 label=draw_info_screen_a
c $99A1 DRAW_INFO_SCREEN_A -- render an animated info/message screen: tick the title animation, (re)start jingle 2, and print the screen's text lines (strings at $981E..) via print_string_at, running the music sequencer.
N $99A1 Clobbers: most.
@ $99CE label=draw_timeup_screen
c $99CE DRAW_TIMEUP_SCREEN -- the time-up message display (reached from main_loop when play_timer expires): animated title bg + jingle 2 + the time-up text (string $9918), pumping music_tick.
@ $99F0 label=draw_info_screen_b
c $99F0 DRAW_INFO_SCREEN_B -- another animated info screen variant (text strings $9894/$98A5), same structure as draw_info_screen_a.
@ $9A23 label=screen_time_bonus
c $9A23 SCREEN_TIME_BONUS -- end-of-level bonus screen: animate the remaining play_timer counting down (update_timer_digits + blips) with wait_frames pacing, converting leftover time into score.
@ $9AD7 label=update_timer_digits
c $9AD7
@ $9B87 label=menu_page
b $9B87
@ $9B88 label=attract_timer
@ $9B89 label=menu_active
@ $9B8A label=title_menu
c $9B8A TITLE_MENU -- title screen, option menu and attract/demo loop.
N $9B8A (TASK.md guessed 'init level data' here -- WRONG verified to be the front-end.) Blits the 24-row NEBULUS logo bitmap from rt_be00 ($BE00) into the screen, paints attribute rows, and prints the option lines (1/2 PLAYER etc.) via draw_menu_text.
N $9B8A Runs proc_table as an attract demo until input, then polls the keyboard ($FE) and Kempston ($1F) for select/start.
N $9B8A menu_page
c $9BA2
c $9BA5
@ $9CBE label=fill_attr_row
c $9CBE
@ $9CC7 label=draw_menu_text
c $9CC7
@ $9CEB label=title_anim_tick
c $9CEB
s $9CEF
@ $9CF0 label=wait_frames
c $9CF0 WAIT_FRAMES -- pause for A frames (HALT-synced), running the attract animation (proc_table) meanwhile returns early if input (input_x) arrives.
N $9CF0 $9CEF = frame counter.
N $9CF0 Clobbers: A,HL.
@ $9D07 label=menu_wait_release
@ $9D11 label=print_player_label
c $9D11
@ $9D21 label=print_string_at
c $9D21
@ $9D27 label=set_print_row
c $9D27
b $9D2F
T $9D33
b $9D36
T $9D3A
b $9D3D
T $9D41
b $9D44
T $9D48
s $9D4B
@ $9D4C label=draw_hiscore_screen
c $9D4C DRAW_HISCORE_SCREEN -- render the high-score table (the alternate title page): header string $9927 plus each score entry printed via print_score_entry.
N $9D4C Clobbers: most.
s $9D7D
c $9D80
@ $9E0F label=print_score_entry
c $9E0F PRINT_SCORE_ENTRY -- print one high-score row: cursor row A, colour C, entry record at HL (IX) formats the BCD score bytes via print_score_byte.
N $9E0F Clobbers: A,IX,...
@ $9E58 label=print_score_byte
c $9E58
@ $9E65 label=print_score_nibble
s $9E6C
@ $9E6D label=check_hiscore
c $9E6D CHECK_HISCORE -- compare the active player's 4-byte BCD score ($6043 / $6047 by lives_p1) against the high-score table and insert it in rank order if it qualifies.
N $9E6D Runs with IRQs off.
N $9E6D Clobbers: A,IX,IY,...
s $9EF0
T $9EF1
b $9EF9
T $9F04
s $9F0E
@ $9F11 label=init_attract_actors
c $9F11 INIT_ATTRACT_ACTORS -- set up the attract/demo actor records at $9EF0 (copy 5-byte template $9EFF->$9EFA, plant markers $9EF0=$FF, $9F0E=1).
N $9F11 Clobbers: A,BC,DE,HL.
@ $9F33 label=attract_step
c $9F33 ATTRACT_STEP -- advance the attract/demo one frame: silence SFX, render_play_frame, then fire scripted sounds keyed off the demo phase $9F0E.
N $9F33 Clobbers: most.
@ $A02A label=render_play_frame
c $A02A RENDER_PLAY_FRAME -- one frame of the in-play tower screen: setup_tower_scroll, code_ad00, wait vsync (HALT), tick the sound engine (sound_tick), draw the tower body + column strip, refresh the strip params and the scroll-wrap edge, then process the 5 actor records at $9EF0.
N $A02A Clobbers: most.
c $A113
@ $A11D label=pstate_9
b $A16B
c $A170
b $A190
@ $A197 label=start_music
c $A197 START_MUSIC -- begin music/jingle A: stash the id ($A196) then fall into init_music_seq to choose the data stream and arm the sequencer.
N $A197 In: A=tune id.
@ $A19A label=init_music_seq
@ $A1BD label=music_tick
c $A1BD MUSIC_TICK -- per-frame music sequencer step (DI around it).
N $A1BD When the note timer ($A195) elapses, fetch the next event from the stream ($A190), update the current note ($A192), and play it.
N $A1BD i8080: speaker via OUT ($FE) bit4 (ULA).
N $A1BD The Specialist has a 1-bit beeper too -- retarget the port and retune the delay loops.
b $A238
T $A249
b $A254
T $A255
b $A258
@ $A36D label=stop_sound
c $A36D
@ $A373 label=snd_ptr_table
b $A373
@ $A38D label=snd_effect_data
@ $A3DE label=play_sound
c $A3DE PLAY_SOUND -- trigger sound effect A (id < $0D).
N $A3DE Saves all regs, looks up the effect via lookup_sound, and (subject to a priority check against the currently playing effect at $A368/$A369) latches its data pointer at $A36A for sound_tick to play out.
N $A3DE In: A=effect id.
N $A3DE Preserves all registers.
N $A3DE Most-called audio API.
@ $A40B label=lookup_sound
c $A40B
@ $A41C label=sound_tick
c $A41C SOUND_TICK -- per-frame SFX engine step.
N $A41C Gated by the sound-enable flag ($6056) and the active marker ($A368).
N $A41C Reads the next byte of the current effect (pointer $A36A), interpreting commands (>=$80) vs tone/length data, and emits to the speaker.
N $A41C i8080: speaker via OUT ($FE) bit4 (ULA).
N $A41C The Specialist has a 1-bit beeper too -- retarget the port and retune the delay loops.
c $A470
c $A48A
c $A493
@ $A4AD label=sfx_noise
c $A4AD SFX_NOISE -- white-noise burst: XORs the refresh register R into the speaker bit and toggles OUT ($FE) for DE iterations.
N $A4AD i8080: speaker via OUT ($FE) bit4 (ULA).
N $A4AD The Specialist has a 1-bit beeper too -- retarget the port and retune the delay loops.
c $A4BF
c $A4F2
c $A50E
s $A518
@ $A519 label=sfx_random_tone
c $A519
c $A52E
@ $A539 label=sfx_tone
c $A539 SFX_TONE -- emit a square-wave tone: pitch index A selects a half-period from table $A560 toggles the speaker for a fixed duration ($0148 outer).
N $A539 In: A=pitch.
N $A539 Clobbers: A,BC,DE,HL,AF'.
N $A539 i8080: speaker via OUT ($FE) bit4 (ULA).
N $A539 The Specialist has a 1-bit beeper too -- retarget the port and retune the delay loops.
T $A560
b $A568
T $A569
b $A575
@ $A584 label=buffer_a584
@ $A700 label=proc_table
c $A700 PROC_TABLE -- jump/trampoline dispatch table, $A700..$A79E (53 entries, each 'JP nnnn', 3 bytes).
N $A700 The game CALLs these fixed slots instead of the moving routine bodies a CALL <slot> costs one extra JP.
N $A700 Targets land in $A79F..$BA67.
N $A700 i8080 PORT: just a vector table -- keep verbatim (8080 has JMP) or inline each trampoline away.
@ $A703 label=jp_scan_keys
b $A703
@ $A706 label=jp_test_key
c $A706
C $A706,3 -> test_key: A=key id, returns Z if pressed
@ $A709 label=jp_poll_any_key
b $A709
@ $A70C label=jp_wait_no_key
@ $A70F label=jp_test_break
c $A70F
@ $A712 label=jp_delay
b $A712
@ $A715 label=jp_random
c $A715
@ $A718 label=jp_save_regs
b $A718
@ $A71B label=jp_restore_regs
@ $A71E label=jp_setup_attrs
C $A71E,3 -> setup_attrs: paint playfield attributes + PLAYER labels
@ $A721 label=jp_reset_score
c $A721
@ $A724 label=jp_draw_hud
c $A724
@ $A727 label=jp_add_score
c $A727
@ $A72A label=jp_init_bonus
c $A72A
@ $A72D label=jp_bonus_sub
c $A72D
@ $A730 label=jp_field_604f_add
c $A730
@ $A733 label=jp_set_level_timer
c $A733
@ $A736 label=jp_tick_timer
c $A736
@ $A739 label=jp_draw_timer
c $A739
@ $A73C label=jp_print_char_at
b $A73C
@ $A73F label=jp_print_char
c $A73F
@ $A742 label=jp_print_str_loop
b $A742
@ $A745 label=jp_print_centered
c $A745
@ $A748 label=jp_set_print_pos
b $A748
@ $A74B label=jp_clear_obj_table
@ $A74E label=jp_calc_col_addr
@ $A751 label=jp_col_visible
c $A751
@ $A754 label=jp_blit_scroll_wrap
c $A754
@ $A757 label=jp_code_ad00
c $A757
@ $A75A label=jp_anim_bg
c $A75A
@ $A75D label=jp_setup_scroll
c $A75D
@ $A760 label=jp_draw_tower
c $A760
@ $A763 label=jp_load_level_col
c $A763
@ $A766 label=jp_alloc_slot
c $A766
@ $A769 label=jp_update_objects
c $A769
@ $A76C label=jp_free_object
c $A76C
@ $A76F label=jp_update_actors
c $A76F
@ $A772 label=jp_clear_screen
c $A772
C $A772,3 -> clear_screen: wipe display + game RAM, build LUT
@ $A775 label=jp_build_hi_lut
@ $A778 label=jp_clear_playfield
c $A778
@ $A77B label=jp_hook_noop
b $A77B
@ $A77E label=jp_init_b5cf
c $A77E
@ $A781 label=jp_get_screen_addr
c $A781
@ $A784 label=jp_get_sprite_def
c $A784
@ $A787 label=jp_select_sprite
c $A787
@ $A78A label=jp_draw_actor
c $A78A
@ $A78D label=jp_actor_screen_y
b $A78D
@ $A790 label=jp_draw_pending
c $A790
@ $A793 label=jp_setup_strip
c $A793
@ $A796 label=jp_draw_strip
c $A796
@ $A799 label=jp_paint_attrs
c $A799
@ $A79C label=jp_scroll_attrs
c $A79C
@ $A79F label=read_input
c $A79F READ_INPUT -- proc_table[0]: sample controls into the signed input_x/input_y/input_fire vars.
N $A79F Only active when game_mode ($6017) == 4 (in play) otherwise returns.
N $A79F Reads the Kempston joystick and converts each axis to -1/0/+1 via bit tests + SBC/NEG.
N $A79F i8080 PORT: input comes from IN A,($1F) (Kempston).
N $A79F The Specialist has no Kempston port -- replace read_joystick with the target's keyboard/joystick scan, keeping the -1/0/+1 result.
C $A79F,3 A = game_mode ($6017)
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
c $A7ED SCAN_CONTROL_KEYS -- read one 5-key control set into the flag array at $6018.
N $A7ED A selects the set: index a word-pointer table at $A7E5 (A*2) to a 5-byte key-id list, then test_key each one, storing 0/1 into $6018..$601C.
N $A7ED Used to read the redefinable keys.
N $A7ED In: A=set index.
N $A7ED Out: $6018[0..4] flags.
N $A7ED Clobbers: A,B,DE,HL.
@ $A81F label=test_key
c $A81F TEST_KEY -- is a specific key down?
N $A81F (proc_table slot $A706.) In:  A = key id, encoded (row<<3 | column) into the ZX keyboard matrix.
N $A81F Out: Z set (A=0) if the key is pressed.
N $A81F Builds the half-row select on the address bus (A=$FE rotated <row> times so one of A8..A15 is low) and reads ULA port $FE rotates out <column> bits and tests the active-low key bit.
N $A81F i8080 PORT: this is the ZX keyboard hardware scan (IN $FE with address-line row select).
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
b $A840 POLL_ANY_KEY -- return NZ if ANY input is active: scans the five keyboard half-rows via IN ($FE) (CPL+AND $1F), and if none, tests the Kempston fire bit ($10).
N $A840 Out: A/flags NZ = pressed.
N $A840 i8080: replace IN ($FE)/Kempston with the target's key/fire scan.
@ $A84D label=wait_no_key
@ $A853 label=test_break_key
c $A853 TEST_BREAK_KEY -- test the BREAK combination (CAPS SHIFT + SPACE) via two IN ($FE) row reads.
N $A853 Returns with CARRY CLEAR only when both are held (used to abort).
N $A853 Clobbers: A.
@ $A85F label=delay_loop
b $A85F DELAY_LOOP -- busy-wait: B outer iterations of a ~$0086 inner countdown.
N $A85F In: B=outer count.
N $A85F Clobbers: A,B,HL (HL preserved).
N $A85F i8080: a pure timing loop -- retune the constant for 2MHz 8080.
@ $A86C label=next_random
c $A86C NEXT_RANDOM -- pseudo-random generator.
N $A86C Reads the 16-bit seed ($6002), applies a multiply/shift + add $0029 LCG step, writes the new seed back, and returns A = high byte.
N $A86C Out: A=random byte, ($6002) advanced.
N $A86C Clobbers: A,DE,HL.
@ $A889 label=save_regs_frame
b $A889 SAVE_REGS_FRAME / RESTORE_REGS_FRAME -- paired full CPU-context save and restore.
N $A889 save_regs_frame pushes main+alternate register sets, IX, IY (EX AF,AF'/EXX to reach the shadow bank), then reads a 16-bit value out of the saved frame ($SP+$17) into HL before returning.
N $A889 restore_regs_frame ($A8A5) pops them all back.
N $A889 i8080: no shadow regs/IX/IY on 8080 -- a port saves only the real register set drop the EXX/EX AF,AF' halves.
T $A8A0
b $A8A3
@ $A8A5 label=restore_regs_frame
@ $A8C7 label=str_player1
T $A8C7
s $A8CF
@ $A8D0 label=str_player2
T $A8D0
b $A8D8
@ $A8D9 label=attr_rle
@ $A8EB label=setup_attrs
c $A8EB SETUP_ATTRS -- paint the static playfield attribute layout and the two PLAYER score labels.
N $A8EB Run once at start (via jp_setup_attrs).
N $A8EB Reads attr_rle (9 run-length [count,attr] pairs) and floods the attribute area $5800+ with attr|$40 (BRIGHT set on every cell).
N $A8EB Then prints the PLAYER 1 / PLAYER 2 strings and seeds two score/counter widgets via helper calls.
N $A8EB In: nothing.
N $A8EB Out: attribute area painted.
N $A8EB Clobbers: A,BC,DE,HL.
C $A8EB,2 A = $FF
C $A8ED,3 store $FF to a flag at $60C8
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
C $A90B,3 print string at position (helper $AB53)
C $A90E,3 BC = 0x1800 = position for 'PLAYER 2'
C $A930,3 draw remaining score widgets
C $A933,3 tail-jump into the next setup step
@ $A936 label=draw_hud_bar
c $A936 DRAW_HUD_BAR -- at the print position in BC, print 8 copies of glyph $81 (a solid block) -- the score-panel divider bar.
N $A936 In: BC=print pos.
N $A936 Clobbers: A,B.
@ $A943 label=reset_score_state
c $A943 RESET_SCORE_STATE -- init the score/lives HUD state for a new game: lives_p2 ($6041)=3, $6042=3, $60C2=0, and zero the 8-byte block $6043..$604A (the two 4-byte BCD score buffers).
N $A943 Reached from proc_table slot $A721 (JP) and from $A930 (CALL, then falls through to draw_hud_counters).
@ $A959 label=draw_hud_counters
c $A959 DRAW_HUD_COUNTERS -- paint the score/lives panel.
N $A959 Sets the '1UP'/'2UP' marker attribute cells (toggled by lives_p1), then prints lives_p2/$6042 as 2-digit decimals and the two BCD score buffers via set_print_pos + print_bcd_byte.
N $A959 Clobbers: A,BC,DE,HL.
@ $A993 label=print_score_field
c $A993 PRINT_SCORE_FIELD -- position the cursor (BC) then print a 2-byte (4-digit) BCD value at HL via print_bcd_word.
N $A993 In: BC=pos, HL=MSB.
@ $A999 label=print_bcd_word
@ $A99C label=print_bcd_byte
@ $A9A6 label=print_nibble
@ $A9AD label=draw_gauge8
c $A9AD
@ $A9BD label=add_bcd_score
c $A9BD ADD_BCD_SCORE -- add HL (16-bit BCD delta) to the active player's 4-byte BCD score (lives_p1 selects $6043 or $6047), with DAA carry propagation across all 4 bytes.
N $A9BD In: HL=BCD delta, lives_p1=index.
N $A9BD Clobbers: A,B,C,DE.
N $A9BD i8080: DAA exists but only valid after ADD/ADC (as used here).
@ $AA08 label=init_bonus
c $AA08 INIT_BONUS -- seed the active player's (lives_p1 index) bonus/ accumulator block at $604B: bonus = BCD 0100, $604F-side cleared.
N $AA08 Clobbers: A,HL.
@ $AA21 label=bonus_sub
c $AA21 BONUS_SUB -- BCD-subtract B from the active player's bonus value ($604B, 2 bytes), clamping at 0 on underflow (RET NC else zero it).
N $AA21 In: A/B=BCD amount.
N $AA21 Clobbers: A,B,HL.
N $AA21 i8080: DAA after SUB/SBC.
@ $AA3D label=field_604f_add
c $AA3D FIELD_604F_ADD -- BCD-add B to the active player's 2-byte field at $604F, saturating: high byte hitting 6 resets to 05/low=00.
N $AA3D In: A/B=BCD amount.
N $AA3D Clobbers: A,B,HL.
@ $AA5B label=set_level_timer
c $AA5B SET_LEVEL_TIMER -- load play_timer from the word table at $A8B7 indexed by $6039*2 (per-level start time), then fall into draw_timer to show it.
N $AA5B Clobbers: A,DE,HL.
@ $AA70 label=tick_timer
c $AA70 TICK_TIMER -- prescaled level-timer countdown.
N $AA70 $6055 counts 0..4 only every 5th call does it BCD-decrement play_timer (2 bytes, clamped at 0) and redraw via draw_timer.
N $AA70 RET M while prescaler is negative (timer disabled).
N $AA70 Clobbers: A,HL.
@ $AA96 label=draw_timer
c $AA96 DRAW_TIMER -- print the 2-byte BCD play_timer ($6054) as decimal digits at print row $0E (white).
N $AA96 Uses print_2digits/print_digit.
N $AA96 Clobbers: A,BC,HL.
@ $AAA8 label=print_2digits
@ $AAB1 label=print_digit
@ $AAB8 label=punct_map
b $AAB8
T $AABA
b $AABE
@ $AAC2 label=print_char_at
@ $AAC5 label=print_char
c $AAC5 PRINT_CHAR -- render one character at the current text cursor.
N $AAC5 In:  A = character code.
N $AAC5 >=$80 : direct glyph index (graphics char), A&$7F.
N $AAC5 'A'..'Z' : glyph = (A-'A')+2.
N $AAC5 '0'..'9' : glyph = (A-'0')+$1C.
N $AAC5 <$10     : colour/attribute control code -> cur_color.
N $AAC5 else     : looked up in punct_map.
N $AAC5 cursor in print_cursor ($60C6 lo=col) cur_color ($60C8).
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
C $AAFA,3 store into cur_color ($60C8)
C $AAFF,3 HL -> punct_map (5 entries)
C $AB04,1 compare code against each map char
C $AB0E,1 matched: A = glyph index from map
@ $AB0F label=glyph_addr
C $AB0F,1 L = glyph index
C $AB10,1 A = index*6 via index + index*2, then *2 (6 bytes/glyph)
C $AB13,1 HL = index*6
C $AB16,3 DE = $C000 = font base
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
c $AB53 PRINT_STRING -- print an ASCIIZ string at position BC.
N $AB53 In: HL=string (00-terminated), BC=cursor pos.
N $AB53 Out: HL past terminator.
N $AB53 Uses print_char per byte.
C $AB53,3 set cursor = BC
@ $AB56 label=print_string_loop
c $AB56
C $AB56,1 A = next char
C $AB58,1 00 terminator?
C $AB59,1 done (ASCIIZ) -- RET on Z
C $AB5A,3 print it
C $AB5D,2 next char
@ $AB5F label=print_centered
c $AB5F
C $AB60,2 C = visible-char count
C $AB66,2 ignore codes <$10 (colour controls) in the count
C $AB6E,2 A = 32 - count
C $AB71,1 RRA = /2 = left margin
C $AB72,3 store as start column ($60C7)
@ $AB7A label=set_print_pos
c $AB7A
@ $AB7F label=clear_obj_table
c $AB7F
@ $AB97 label=calc_tower_col_addr
c $AB97 CALC_TOWER_COL_ADDR -- compute a byte address inside the $6400 tower/column buffer from disp_height (&7, *24) and scroll_pos, returning the slot pointer(s) for column rendering.
N $AB97 Clobbers: A,BC,DE,HL.
@ $AC22 label=col_visible_offset
c $AC22 COL_VISIBLE_OFFSET -- compute the on-screen column offset of the object at $60BA relative to scroll_pos, folded into the 4-quadrant (mod $03) tower wrap.
N $AC22 Returns A=offset (RET Z if off-screen).
N $AC22 Clobbers: A,B,DE,HL.
@ $AC5E label=blit_scroll_wrap
c $AC5E BLIT_SCROLL_WRAP -- when scroll_pos has wrapped past the top (H==$03 && L>=$D8), fast-fill the newly exposed strip using the LD SP,screen / stack-write trick (saves real SP to $6000, DI, reads mask_acb0).
N $AC5E RET early when no wrap is pending.
N $AC5E i8080: 8080 has no shadow regs and SP push-blit is far slower a port should draw this strip with ordinary stores.
@ $ACB0 label=mask_acb0
b $ACB0
@ $AD00 label=code_ad00
c $AD00
@ $AD4E label=anim_bg_phase
c $AD4E ANIM_BG_PHASE -- advance the background animation phase counter ($603D) on the wrap point reload $603C with $08 (animation restart).
N $AD4E Clobbers: A,HL.
b $AD60
@ $AD82 label=setup_tower_scroll
c $AD82 SETUP_TOWER_SCROLL -- per-frame scroll/render setup.
N $AD82 Clears the object table, derives the coarse column ($ADC6) and sub-column fraction ($6021) from scroll_pos, and the row base ($AD61) from disp_height.
N $AD82 SELF-MODIFIES the render code ($ADC6/$AD61) and latches $6021 for draw_tower_cols.
N $AD82 Clobbers: A,C,HL.
b $AE89
c $AEBB
c $AF2A
c $AF86
c $AFD0
b $B027
c $B03F
s $B0A1
@ $B0A2 label=draw_tower_cols
c $B0A2 DRAW_TOWER_COLS -- render the visible tower column strip.
N $B0A2 Patches the column count at $B0A1 ($14, reduced near the wrap edge from scroll_pos) and dispatches on the $6021 sub-column phase.
N $B0A2 SELF-MOD: $B0A1 loop count.
N $B0A2 Clobbers: A,B,HL (+ render regs).
b $B22E
T $B239
b $B240
T $B249
b $B250
T $B255
b $B258
T $B26B
b $B278
T $B28B
b $B298
T $B2A5
b $B2A8
T $B2BB
b $B2C8
T $B2DB
b $B2E8
T $B2F5
b $B2F8
T $B30B
b $B318
T $B32B
b $B338
@ $B346 label=load_level_col
c $B346 LOAD_LEVEL_COL -- fetch column descriptor #$6039 from the column-major table at $7A00 (stride 8): low byte (+0) and high byte (+8) form a pointer (offset by $6A00 into level data), and the property byte (+16) is stashed in $603A.
N $B346 Returns IX=pointer.
N $B346 Clobbers: A,BC,DE,HL,IX.
@ $B382 label=blit_masked_column
c $B382 BLIT_MASKED_COLUMN -- draw an 8-pixel-tall column at HL: for each set bit of the mask byte at (DE), store the next source byte (IX++) and step down one pixel row (INC H) skip rows whose mask bit is 0.
N $B382 In: DE=mask ptr, IX=pixels, HL=screen.
N $B382 Clobbers: A,B,HL,IX.
@ $B395 label=alloc_object_slot
c $B395 ALLOC_OBJECT_SLOT -- find a free entry (marker $FF at +0) in the 4-slot active-object table at $60A9.
N $B395 On success store its type ($7D), source pointer (HL) and a copied data byte, set CY, RET.
N $B395 In: HL=source.
N $B395 Out: CY=allocated.
N $B395 Clobbers: A,B,IX.
@ $B3BF label=update_object_slots
c $B3BF UPDATE_OBJECT_SLOTS -- tick the 4-entry active-object table at $60A9 (counterpart to alloc_object_slot).
N $B3BF For each slot: $FF=free (skip), >1 = decrement its countdown, and on expiry write the stored byte back through its screen pointer (erase the object).
N $B3BF Clobbers: A,B,HL,IX.
@ $B3FE label=free_object_slot
c $B3FE FREE_OBJECT_SLOT -- mark the $60A9 slot whose stored pointer equals HL as free (set +0 = $FF).
N $B3FE In: HL=pointer.
N $B3FE Clobbers: A,B,IX.
@ $B421 label=update_actors
c $B421 UPDATE_ACTORS -- per-frame actor pass (proc_table slot A76F).
N $B421 Skips when player_state is 8/9 (level-end).
N $B421 Derives the camera row $6036 from $6059, then walks the 4 object_table actors, acting on each live one (state field IX+48 != 0).
N $B421 Clobbers: A,B,HL,IX.
@ $B546 label=clear_screen
c $B546 CLEAR_SCREEN -- cold wipe before the title/play screen draws.
N $B546 1) zero game RAM $6000..$61FF (512 bytes, 2 pages).
N $B546 2) zero the entire display $4000..$5AFF (pixels+attrs) via LDIR.
N $B546 3) CALL $B567 (build a lookup table in the reclaimed printer buffer $5B00) and $B5EA.
N $B546 In: nothing.
N $B546 Out: screen+vars cleared.
N $B546 Clobbers: A,BC,DE,HL.
N $B546 i8080 PORT: LDIR is a Z80 block fill -- expand to an explicit DCR/JNZ store loop.
N $B546 The $6000 clear uses INC L / INC H pagi
C $B546,3 HL -> game RAM base $6000
C $B549,2 B = 2 pages to clear
C $B54B,2 store 0
C $B54E,2 loop 256 bytes of this page
C $B550,1 next page
C $B553,3 HL -> screen base $4000
C $B556,3 DE -> $4001 (LDIR src=HL, dst=DE, overlap fill)
C $B559,3 BC = $1AFF = 6911 bytes = whole display minus 1
C $B55C,2 seed first byte = 0
C $B55E,2 LDIR: propagate 0 across $4000..$5AFF (Z80 block op)
C $B560,3 build pixel/attr lookup table in $5B00
@ $B567 label=build_screen_hi_lut
c $B567 BUILD_SCREEN_HI_LUT -- fill a 256-byte table at $5B00 mapping a byte value to its bit-reordered form used in ZX screen-address math.
N $B567 Processes the index in 2-bit groups groups 00 and 11 pass through, 01/10 get +$40 -- the Y2<->Y0 swap that makes the ZX pixel rows non-linear.
N $B567 Result accumulates in H.
N $B567 i8080 PORT: the Specialist framebuffer is LINEAR -- this whole table collapses to identity.
N $B567 The porter can DELETE this and the $5B00 lookups, replac
C $B567,3 DE -> $5B00 LUT base (reclaimed printer buffer)
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
C $B5B5,2 LDIR: clear an attribute strip (Z80 block op)
@ $B5C8 label=hook_noop
b $B5C8
@ $B5CB label=flag_b5cb
@ $B5CF label=init_b5cf
c $B5CF
C $B5D5,3 zero flag_b5cb at $B5CB (write into code padding)
@ $B5D9 label=get_screen_addr
c $B5D9 GET_SCREEN_ADDR -- pixel address for (row=H, col-in-row=L).
N $B5D9 Indexes scr_row_addr_tbl ($5D00, 2 bytes/row) at 2*H to fetch the row base, then adds L to get the final byte address in HL.
N $B5D9 In: H=row 0..191, L=byte offset within row.
N $B5D9 Out: HL=screen addr.
N $B5D9 Clobbers A preserves DE.
N $B5D9 i8080 PORT: replace table lookup with row*32 + col on a linear framebuffer (no scan-order table needed).
C $B5DC,1 L = 2*H = table index
C $B5DE,2 H = $5D + carry -> HL -> scr_row_addr_tbl[H]
C $B5E4,1 A = row base low + col offset
C $B5E6,1 H = row base high
@ $B5EA label=build_row_addr_table
c $B5EA BUILD_ROW_ADDR_TABLE -- precompute 192 screen-row addresses into scr_row_addr_tbl ($5D00, little-endian words).
N $B5EA For each row y in 0..191 it builds the ZX pixel address:
N $B5EA high = $40 | (y&7) | ((y>>3)&$18)
N $B5EA low  = (y&$38)<<2 i.e.
N $B5EA the famous ZX scan-order layout (Y bits split across the address).
N $B5EA get_screen_addr then just indexes this table.
N $B5EA i8080 PORT: on a linear framebuffer this table is row*width -- trivial this builder can be dropped.
C $B5EA,3 DE -> $5D00 table base
C $B5ED,3 HL: H = row counter y, builds address in HL
C $B5F2,1 (y>>3)&$18  -> D (the y bits 3..5 region)
C $B5FC,1 + (y&7) + $40 -> high byte
C $B601,2 (y<<2)&$E0 -> low byte (E)
C $B60A,1 HL = full row-0 screen address
C $B60D,1 store LE word into table[y]
C $B615,2 stop after row $BF (192 rows)
@ $B61B label=get_sprite_def
c $B61B GET_SPRITE_DEF -- look up sprite/graphic descriptor A in the gfx_c101 table (A*2): unpack the frame count (top 2 bits, 0->4) into C and the bitmap pointer (low 6 bits + $C1xx base) into HL.
N $B61B In: A=sprite id.
N $B61B Out: HL=bitmap, C=frames.
N $B61B Clobbers: A,HL.
@ $B636 label=select_player_sprite
c $B636 SELECT_PLAYER_SPRITE -- pick the player's current sprite frame from $60C1 plus facing ($60BE bit7) and player_state, applying frame-base offsets ($1F walking-left / $44 walking-right).
N $B636 RET early if $60C2==0 (nothing to draw).
N $B636 Clobbers: A,H,L.
@ $B72F label=plot_row_wrapped
c $B72F PLOT_ROW_WRAPPED -- advance the screen address HL down one pixel row (ZX scan-order arithmetic: char-cell wrap via +$20 / -$08) then fall into plot_masked_row.
N $B72F Clobbers: A,HL (+ plot regs).
@ $B73E label=plot_masked_row
c $B73E PLOT_MASKED_ROW -- plot a 3-cell sprite slice at HL: AND the left edge cell with mask D, write the two middle cells = B, AND the right edge with mask E restores L and bumps H.
N $B73E In: HL,B,D,E.
N $B73E Clobbers: A,C,HL.
@ $B74D label=draw_actor_sprite
c $B74D DRAW_ACTOR_SPRITE -- render one object_table actor (IX = entry).
N $B74D Skips if (IX+24)==$FF (inactive).
N $B74D Computes screen-Y via actor_screen_y, special-cases state 7 (IX+48) to latch $60A6, bounds-checks Y to [$18,$B0), then draws.
N $B74D Clobbers: A,HL,IX,...
@ $B7C2 label=blit_sprite_fast
c $B7C2 BLIT_SPRITE_FAST -- fast sprite blit using the LD SP,screen / PUSH stack-write trick (saves the real SP to $6000, DI).
N $B7C2 Height B is 8 or 4 (chosen by the $4E threshold) C selects a sub-variant.
N $B7C2 i8080: the LD SP,screen / PUSH blit trick has no 8080 speed advantage and conflicts with interrupts -- port as normal stores.
@ $B869 label=actor_screen_y
c $B869 ACTOR_SCREEN_Y -- object-table counterpart of col_screen_y: map an actor's angular column (IX+0)+$20, minus tower_height rotation, wrapped (AND $7F), through col_y_table to a screen row also derives the object index ((IX low)-$5B).
N $B869 Clobbers: A,DE,HL.
@ $B8A8 label=draw_pending_sprite
c $B8A8 DRAW_PENDING_SPRITE -- if flag_b5cb is set, consume it and draw the one-shot sprite queued at $B5CC (pos) / $B5CE (id), with on-screen bounds checks.
N $B8A8 RET immediately when nothing queued.
N $B8A8 Clobbers: A,BC,HL.
@ $B941 label=strip_params
b $B941
T $B94A
b $B94D
T $B95A
b $B95D
@ $B965 label=setup_strip_draw
c $B965 SETUP_STRIP_DRAW -- patch the tower column-strip blitter's params ($B941/$B9A1 row, $B942 column base) from disp_height and scroll_pos (bit2 selects the $24/$2C column phase).
N $B965 SELF-MOD.
N $B965 Clobbers: A,B,C.
@ $B9D6 label=draw_tower_strip
c $B9D6 DRAW_TOWER_STRIP -- blit one vertical column strip of up to 10 tower elements using the params patched by setup_strip_draw resolves each cell's screen address via get_screen_addr.
N $B9D6 Clobbers: A,B,DE,HL.
T $BA0E
@ $BA16 label=lookup_col_attr
c $BA16
@ $BA26 label=paint_tower_attrs
c $BA26 PAINT_TOWER_ATTRS -- repaint the tower's attribute (colour) band in the $58xx attribute file from $5860, using lookup_col_attr ($BA16) for per-column colours and fill_run ($BA61) to lay rows.
N $BA26 SELF-MOD: $BA66 row count.
N $BA26 Clobbers: A,BC,D,HL.
@ $BA61 label=fill_run
s $BA66
@ $BA67 label=scroll_tower_attrs
c $BA67 SCROLL_TOWER_ATTRS -- adjust the painted attribute band as scroll_pos advances (compares against the $BA66 latch set by paint_tower_attrs) so colours track the scrolling tower.
N $BA67 Clobbers: A,B,HL.
s $BAB4
@ $BABA label=im2_dispatch
c $BABA
b $BABD
@ $BB00 label=im2_vector_table
@ $BC00 label=runtime_tables
b $BC00 RUNTIME_TABLES -- $BC00..$BFFF, zero in the snapshot.
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
N $C1F6 Graphics, 4 frames
@ $C26E label=gfx_c26e
N $C26E Graphics, 4 frames
@ $C2E6 label=gfx_c2e6
N $C2E6 Graphics, 4 frames
@ $C35E label=gfx_c35e
N $C35E Graphics, 4 frames
@ $C3D6 label=gfx_c3d6
N $C3D6 Graphics, 4 frames
@ $C44E label=gfx_c44e
N $C44E Graphics, 4 frames
@ $C4C6 label=gfx_c4c6
N $C4C6 Graphics, 4 frames
@ $C53E label=gfx_c53e
N $C53E Graphics, 4 frames
@ $C5B6 label=gfx_c5b6
N $C5B6 Graphics, 4 frames
@ $C62E label=gfx_c62e
N $C62E Graphics, 2 frames
@ $C67E label=gfx_c67e
N $C67E Graphics, 2 frames
@ $C6CE label=gfx_c6ce
N $C6CE Graphics, 2 frames
@ $C71E label=gfx_c71e
N $C71E Graphics, 4 frames
@ $C796 label=gfx_c796
N $C796 Graphics, 4 frames
@ $C80E label=gfx_c80e
N $C80E Graphics, 4 frames
@ $C886 label=gfx_c886
N $C886 Graphics, 4 frames
@ $C8FE label=gfx_c8fe
N $C8FE Graphics, 4 frames
@ $C976 label=gfx_c976
N $C976 Graphics, 2 frames
@ $C9C6 label=gfx_c9c6
N $C9C6 Graphics, 2 frames
@ $CA16 label=gfx_ca16
N $CA16 Graphics, 2 frames
@ $CA66 label=gfx_ca66
N $CA66 Graphics, 2 frames
@ $CAB6 label=gfx_cab6
N $CAB6 Graphics, 2 frames
@ $CB06 label=gfx_cb06
N $CB06 Graphics, 2 frames
@ $CB56 label=gfx_cb56
N $CB56 Graphics, 2 frames
@ $CBA6 label=gfx_cba6
N $CBA6 Graphics, 2 frames
@ $CBF6 label=gfx_cbf6
N $CBF6 Graphics, 2 frames
@ $CC46 label=gfx_cc46
N $CC46 Graphics, 4 frames
@ $CCBE label=gfx_ccbe
N $CCBE Graphics, 4 frames
@ $CD36 label=gfx_cd36
N $CD36 Graphics, 4 frames
@ $CDAE label=gfx_cdae
N $CDAE Graphics, 4 frames
@ $CE26 label=gfx_ce26
N $CE26 Graphics, 4 frames
@ $CE9E label=gfx_ce9e
N $CE9E Graphics, 4 frames
@ $CF16 label=gfx_cf16
N $CF16 Graphics, 4 frames
@ $CF8E label=gfx_cf8e
N $CF8E Graphics, 2 frames
@ $CFDE label=gfx_cfde
N $CFDE Graphics, 2 frames
@ $D02E label=gfx_d02e
N $D02E Graphics, 2 frames
@ $D07E label=gfx_d07e
N $D07E Graphics, 2 frames
@ $D0CE label=gfx_d0ce
N $D0CE Graphics, 4 frames
@ $D146 label=gfx_d146
N $D146 Graphics, 4 frames
@ $D1BE label=gfx_d1be
N $D1BE Graphics, 4 frames
@ $D236 label=gfx_d236
N $D236 Graphics, 4 frames
@ $D2AE label=gfx_d2ae
N $D2AE Graphics, 4 frames
@ $D326 label=gfx_d326
N $D326 Graphics, 4 frames
@ $D39E label=gfx_d39e
N $D39E Graphics, 4 frames
@ $D416 label=gfx_d416
N $D416 Graphics, 4 frames
@ $D48E label=gfx_d48e
N $D48E Graphics, 4 frames
@ $D506 label=gfx_d506
N $D506 Graphics, 2 frames
@ $D556 label=gfx_d556
N $D556 Graphics, 2 frames
@ $D5A6 label=gfx_d5a6
N $D5A6 Graphics, 2 frames
@ $D5F6 label=gfx_d5f6
N $D5F6 Graphics, 4 frames
@ $D66E label=gfx_d66e
N $D66E Graphics, 4 frames
@ $D6E6 label=gfx_d6e6
N $D6E6 Graphics, 4 frames
@ $D75E label=gfx_d75e
N $D75E Graphics, 4 frames
@ $D7D6 label=gfx_d7d6
N $D7D6 Graphics, 4 frames
@ $D84E label=gfx_d84e
N $D84E Graphics, 2 frames
@ $D89E label=gfx_d89e
N $D89E Graphics, 2 frames
@ $D8EE label=gfx_d8ee
N $D8EE Graphics, 2 frames
@ $D93E label=gfx_d93e
N $D93E Graphics, 2 frames
@ $D98E label=gfx_d98e
N $D98E Graphics, 2 frames
@ $D9DE label=gfx_d9de
N $D9DE Graphics, 2 frames
@ $DA2E label=gfx_da2e
N $DA2E Graphics, 2 frames
@ $DA7E label=gfx_da7e
N $DA7E Graphics, 2 frames
@ $DACE label=gfx_dace
N $DACE Graphics, 2 frames
@ $DB1E label=gfx_db1e
N $DB1E Graphics, 4 frames
@ $DB96 label=gfx_db96
N $DB96 Graphics, 4 frames
@ $DC0E label=gfx_dc0e
N $DC0E Graphics, 4 frames
@ $DC86 label=gfx_dc86
N $DC86 Graphics, 4 frames
@ $DCFE label=gfx_dcfe
N $DCFE Graphics, 4 frames
@ $DD76 label=gfx_dd76
N $DD76 Graphics, 4 frames
@ $DDEE label=gfx_ddee
N $DDEE Graphics, 4 frames
@ $DE66 label=gfx_de66
N $DE66 Graphics, 2 frames
@ $DEB6 label=gfx_deb6
N $DEB6 Graphics, 2 frames
@ $DF06 label=gfx_df06
N $DF06 Graphics, 2 frames
@ $DF56 label=gfx_df56
N $DF56 Graphics, 2 frames
@ $DFA6 label=gfx_dfa6
N $DFA6 Graphics, 2 frames
@ $DFC6 label=gfx_dfc6
N $DFC6 Graphics, 2 frames
@ $DFE6 label=gfx_dfe6
N $DFE6 Graphics, 2 frames
@ $E006 label=gfx_e006
N $E006 Graphics, 2 frames
@ $E026 label=gfx_e026
N $E026 Graphics, 2 frames
@ $E066 label=gfx_e066
N $E066 Graphics, 3 frames
@ $E0C6 label=gfx_e0c6
N $E0C6 Graphics, 3 frames
@ $E126 label=gfx_e126
N $E126 Graphics, 3 frames
@ $E186 label=gfx_e186
N $E186 Graphics, 2 frames
@ $E1C6 label=gfx_e1c6
N $E1C6 Graphics, 3 frames
@ $E226 label=gfx_e226
N $E226 Graphics, 3 frames
@ $E286 label=gfx_e286
N $E286 Graphics, 3 frames
@ $E2E6 label=gfx_e2e6
N $E2E6 Graphics, 2 frames
@ $E326 label=gfx_e326
N $E326 Graphics, 3 frames
@ $E386 label=gfx_e386
N $E386 Graphics, 3 frames
@ $E3E6 label=gfx_e3e6
N $E3E6 Graphics, 3 frames
@ $E446 label=gfx_e446
N $E446 Graphics, 2 frames
@ $E486 label=gfx_e486
N $E486 Graphics, 2 frames
@ $E4C6 label=gfx_e4c6
N $E4C6 Graphics, 2 frames
@ $E506 label=gfx_e506
N $E506 Graphics, 3 frames
@ $E566 label=gfx_e566
N $E566 Graphics, 2 frames
@ $E5A6 label=gfx_e5a6
N $E5A6 Graphics, 2 frames
@ $E5E6 label=gfx_e5e6
N $E5E6 Graphics, 3 frames
@ $E646 label=gfx_e646
N $E646 Graphics, 3 frames
@ $E6A6 label=gfx_e6a6
N $E6A6 Graphics, 2 frames
@ $E6E6 label=gfx_e6e6
N $E6E6 Graphics, 3 frames
@ $E746 label=gfx_e746
N $E746 Graphics, 3 frames
@ $E7A6 label=gfx_e7a6
N $E7A6 Graphics, 3 frames
@ $E806 label=gfx_e806
N $E806 Graphics, 2 frames
@ $E846 label=gfx_e846
N $E846 Graphics, 3 frames
@ $E8A6 label=gfx_e8a6
N $E8A6 Graphics, 3 frames
@ $E906 label=gfx_e906
N $E906 Graphics, 3 frames
@ $E966 label=gfx_e966
N $E966 Graphics, 2 frames
@ $E9A6 label=gfx_e9a6
N $E9A6 Graphics, 3 frames
@ $EA06 label=gfx_ea06
N $EA06 Graphics, 3 frames
@ $EA66 label=gfx_ea66
N $EA66 Graphics, 3 frames
@ $EAC6 label=gfx_eac6
N $EAC6 Graphics, 2 frames
@ $EB06 label=gfx_eb06
N $EB06 Graphics, 3 frames
@ $EB66 label=gfx_eb66
N $EB66 Graphics, 3 frames
@ $EBC6 label=gfx_ebc6
N $EBC6 Graphics, 3 frames
@ $EC26 label=gfx_ec26
N $EC26 Graphics, 2 frames
@ $EC66 label=gfx_ec66
N $EC66 Graphics, 3 frames
@ $ECC6 label=gfx_ecc6
N $ECC6 Graphics, 3 frames
@ $ED26 label=gfx_ed26
N $ED26 Graphics, 3 frames
@ $ED86 label=gfx_ed86
N $ED86 Graphics, 2 frames
@ $EDD6 label=gfx_edd6
N $EDD6 Graphics, 2 frames
@ $EE26 label=gfx_ee26
N $EE26 Graphics, 2 frames
@ $EE76 label=gfx_ee76
N $EE76 Graphics, 2 frames
@ $EEC6 label=gfx_eec6
N $EEC6 Graphics, 3 frames
b $EF3E
@ $F000 label=work_buffers
@ $FC00 label=loader_entry
T $FC21
b $FC2C
@ $FC8A label=tape_read_byte
c $FC8A TAPE_READ_BYTE -- read one byte from tape with the custom turbo edge-timing loop (ULA EAR bit via IN ($FE), border feedback via OUT ($FE)).
N $FC8A Accumulates 8 bits CY=success, NC=load error/abort.
N $FC8A i8080: ZX-tape/ROM specific -- replaced wholesale by the Specialist's own program-load path not ported.
@ $FD1C label=tape_edge_pair
@ $FD20 label=tape_get_edge
c $FD20 TAPE_GET_EDGE -- measure one tape signal edge on the EAR line (IN A,($FE) with row $7F), toggling the reference in C times out via B.
N $FD20 Out: CY=edge seen.
N $FD20 Clobbers: A,B,C.
N $FD20 i8080: ZX-tape/ROM specific -- replaced wholesale by the Specialist's own program-load path not ported.
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
c $FE5C TAPE_LOAD_HEADER -- load the 17-byte ($0011) block header into the buffer at $FC21 (via tape_read_byte) and validate the $2A signature byte retries on mismatch.
N $FE5C Clobbers: A,DE,IX.
N $FE5C i8080: ZX-tape/ROM specific -- replaced wholesale by the Specialist's own program-load path not ported.
T $FECB
b $FED0
@ $FF00 label=tail_unused
T $FF59
b $FF5C
T $FF71
b $FF77
T $FF8C
b $FF8F
T $FF94
b $FF97
T $FFA4
s $FFA7
T $FFA9
b $FFAF
T $FFB9
s $FFBF
T $FFC1
s $FFC7
T $FFC9
b $FFCF
T $FFD9
b $FFDF
T $FFF9
s $FFFF
