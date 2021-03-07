  ORG $9DBE

; Start point
L9DBE:
  DI
  JP LBC8B_21
; This entry point is used by the routine at LBC8B.
L9DBE_0:
  LD HL,($DBD4)
  LD DE,$D431
  OR A
  SBC HL,DE
  JP Z,L9E34              ; DataFile 'DESDATA' Not Found
  CALL L9FCF              ; Clear screen 9340/9872
  CALL LA001              ; Initialization
  CALL LA19E              ; Select interrupt frequency
  CALL L9FCF              ; Clear screen 9340/9872
  JP LBA07

; Game main loop
;
; Used by the routines at LB177, LB33F and LBB7E.
L9DDD:
  LD A,($DB7A)            ; Get Health
  OR A
  JP Z,LB9A2              ; Player is dead
  CALL LADE5              ; Decode current room
  CALL LA88F              ; Display 96 tiles on the screen
  CALL LB96B              ; Display Health
  CALL LB8EA              ; Show look/shoot selection indicator
  CALL LB76B
  CALL LB551
  CALL LA0F1              ; Scan keyboard
  CP $0F                  ; CLEAR
  JP Z,LBA3D
  CP $04                  ; Up
  JP Z,LA966_1
  CP $01                  ; Down
  JP Z,LA966
  CP $02                  ; Left
  JP Z,LA966_5
  CP $03                  ; Right
  JP Z,LA966_7
  XOR A                   ; Not a valid key
  LD ($DB7C),A
  JP LA88F_2
; This entry point is used by the routines at LA88F and LB9A2.
L9DDD_0:
  CALL LB653
  CALL LA0F1              ; Scan keyboard
  CP $36                  ; Yellow "2nd" key
  JP Z,LAAAF              ; Look / Shoot
  CP $28                  ; "XT0n" key
  JP Z,LB930              ; Look / Shoot Mode
  CP $30                  ; "ALPHA" key
  JP Z,LB0A2              ; Open the Inventory
; This entry point is used by the routines at LAAAF, LAD4F, LAE09, LB00E,
; LB758, LB930 and LBC8B.
L9DDD_1:
  CALL L9FEA              ; Copy screen 9340/9872 to A28F/A58F
  JP L9DDD

; DataFile 'DESDATA' Not Found
;
; Used by the routines at L9DBE and LBC8B.
L9E34:
  LD HL,$0000
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$DBD6             ; "DataFile 'DESDATA' Not Found!"
  RST $28                 ; rBR_CALL
  DEFW $4561              ; _VPutS - Displays a zero (0) terminated string
  CALL L9FEA              ; Copy screen 9340/9872 to A28F/A58F
  LD A,$64
  LD ($DC59),A
  CALL LB2D0              ; Delay
L9E34_0:
  CALL LA0F1
  OR A
  JR Z,L9E34_0

; Quit menu item selected
;
; Used by the routine at LBA93.
L9E51:
  CALL L9FCF              ; Clear screen 9340/9872
  CALL L9FEA              ; Copy screen 9340/9872 to A28F/A58F
  CALL LB2D0              ; Delay
  CALL LA02E
  RET
  DEFB $06                ; Frequency selected: 1/2/4/6

; Draw tile with offset
;
; Used by the routines at LAE09, LB0A2, LB177, LB8EA and LBA88.
;
; L Row
; A X coord
; IX Tile address
L9E5F:
  PUSH AF
  PUSH BC
  PUSH HL
  LD HL,$9340
  LD ($9E8A),HL
  POP HL
  PUSH HL
  CALL L9E5F_0
  LD HL,$9872
  LD ($9E8A),HL
  POP HL
  POP BC
  POP AF
L9E5F_0:
  LD E,L                  ; HL <- L * 12
  LD H,$00                ;
  LD D,H                  ;
  ADD HL,DE               ;
  ADD HL,DE               ;
  ADD HL,HL               ;
  ADD HL,HL               ;
  LD E,A
  AND $07
  LD C,A
  SRL E
  SRL E
  SRL E
  ADD HL,DE               ; now HL = offset on the screen
  LD DE,$9872             ; (Argument is changing here)
  ADD HL,DE               ; Add screen address
L9E5F_1:
  LD D,(IX+$00)
  LD E,$00
  LD A,C
  OR A
  JR Z,L9E5F_3
L9E5F_2:
  SRL D
  RR E
  DEC A
  JR NZ,L9E5F_2
L9E5F_3:
  LD A,(HL)
  XOR D
  LD (HL),A
  INC HL
  LD A,(HL)
  XOR E
  LD (HL),A
  LD DE,$000B
  ADD HL,DE
  INC IX
  DJNZ L9E5F_1
  RET

; Put tile on the screen
;
; Used by the routine at LA88F.
;
; L Row
; E Column
; IX Tile address
L9EAD:
  LD H,$00                ; HL <- L * 12
  LD D,H                  ;
  LD E,L                  ;
  ADD HL,DE               ;
  ADD HL,DE               ;
  ADD HL,HL               ;
  ADD HL,HL               ;
  LD E,A
  ADD HL,DE               ; now HL = offset on the screen
  PUSH HL
  LD DE,$9340             ; Screen plane 1
  ADD HL,DE
  LD DE,$000C             ; offset between lines
  LD B,$08                ; Counter = 8
L9EAD_0:
  LD A,(IX+$00)
  LD (HL),A               ; Put on the screen
  ADD HL,DE               ; next line
  INC IX                  ;
  DJNZ L9EAD_0
  POP HL
  LD DE,$9872             ; Screen plane 2
  ADD HL,DE
  LD DE,$000C             ; offset between lines
  LD B,$08                ; Counter = 8
L9EAD_1:
  LD A,(IX+$00)
  LD (HL),A               ; Put on the screen
  ADD HL,DE               ; next line
  INC IX                  ;
  DJNZ L9EAD_1
  RET

; Draw tile DE at column H row L
;
; Used by the routines at LA88F, LAE09, LB177, LB551, LB653 and LB76B.
;
; DE Tile address
; A ??
; H Column
; L Row
L9EDE:
  PUSH HL
  PUSH AF
  AND $3F
  LD H,$00
  LD L,A
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,DE
  LD DE,$9FAF
  LD BC,$0010
  LDIR
  POP AF
  BIT 6,A
  CALL NZ,L9EDE_1
  BIT 7,A
  CALL NZ,L9EDE_4
  LD IX,$9FAF
  POP HL
  LD A,H
  LD H,$00
  LD B,H
  LD C,L
  ADD HL,BC
  ADD HL,BC
  ADD HL,HL
  ADD HL,HL
  LD C,A
  ADD HL,BC
  LD B,H
  LD C,L
  LD HL,$9872
  ADD HL,BC
  EX DE,HL
  LD HL,$9340
  ADD HL,BC
  LD B,$08
L9EDE_0:
  PUSH BC
  PUSH IX
  LD A,(IX+$00)
  LD BC,$0008
  ADD IX,BC
  LD C,A
  LD A,(IX+$00)
  PUSH AF
  CPL
  AND C
  LD B,A
  CPL
  AND C
  LD C,A
  LD A,B
  AND (HL)
  OR C
  LD (HL),A
  LD A,B
  CPL
  LD B,A
  POP AF
  AND B
  LD C,A
  LD A,B
  CPL
  EX DE,HL
  AND (HL)
  OR C
  LD (HL),A
  LD BC,$000C
  ADD HL,BC
  EX DE,HL
  ADD HL,BC
  POP IX
  INC IX
  POP BC
  DJNZ L9EDE_0
  RET
L9EDE_1:
  PUSH AF
  PUSH HL
  LD DE,$9FB6
  LD HL,$9FBF
  LD B,$08
L9EDE_2:
  LD A,(DE)
  LD (HL),A
  DEC DE
  INC HL
  DJNZ L9EDE_2
  LD BC,$0010
  EX DE,HL
  ADD HL,BC
  EX DE,HL
  LD B,$08
L9EDE_3:
  LD A,(DE)
  LD (HL),A
  DEC DE
  INC HL
  DJNZ L9EDE_3
  CALL L9EDE_6
  POP HL
  POP AF
  RET
L9EDE_4:
  PUSH AF
  PUSH HL
  LD HL,$9FAF
  LD DE,$9FBF
  LD B,$10
L9EDE_5:
  LD A,(HL)
  LD C,$00
  RLCA
  RR C
  RLCA
  RR C
  RLCA
  RR C
  RLCA
  RR C
  RLCA
  RR C
  RLCA
  RR C
  RLCA
  RR C
  RLCA
  RR C
  LD A,C
  LD (DE),A
  INC HL
  INC DE
  DJNZ L9EDE_5
  CALL L9EDE_6
  POP HL
  POP AF
  RET
L9EDE_6:
  LD HL,$9FBF
  LD DE,$9FAF
  LD BC,$0010
  LDIR
  RET
  DEFB $FF,$FF,$FD,$DE,$FF,$00,$C7,$EF ; data
  DEFB $00,$00,$03,$3F,$FF,$00,$C7,$EF ;
  DEFB $00,$00,$00,$00,$00,$00,$00,$00 ; data
  DEFB $00,$00,$00,$00,$00,$00,$00,$00 ;

; Clear screen 9340/9872
;
; Used by the routines at L9DBE, L9E51, LB9A2, LBADE, LBC7D, LBC8B, LBF64 and
; LBF6F.
L9FCF:
  LD HL,$9340             ; Clear $9340-963F, 768 bytes
  LD DE,$9341             ;
  LD BC,$02FF             ;
  LD (HL),$00             ;
  LDIR                    ;
  OR B
  LD HL,$9872             ; Clear $9872-9B71, 768 bytes
  LD DE,$9873             ;
  LD BC,$02FF             ;
  LD (HL),$00             ;
  LDIR                    ;
  OR B
  RET

; Copy screen 9340/9872 to A28F/A58F
;
; Used by the routines at L9DDD, L9E34, L9E51, LA19E, LACE3, LAD4F, LAE09,
; LB177, LB33F, LB513, LB97D, LB9A2, LBA3D, LBA93, LBB7E, LBC7D, LBC8B, LBEDE
; and LBF64.
L9FEA:
  LD HL,$9340
  LD DE,LA28F
  LD BC,$0300
  LDIR
  LD HL,$9872
  LD DE,LA58F
  LD BC,$0300
  LDIR
  RET

; Initialization??
;
; Used by the routines at L9DBE and LA19E.
LA001:
  LD HL,$8700
  LD DE,$8701
  LD BC,$0100
  LD (HL),$86
  LDIR
  LD HL,$A037
  LD DE,$8686
  LD BC,$0003
  LDIR
  LD A,$87
  LD I,A
  IM 2
  LD A,($9E5E)
  OUT ($04),A
  LD A,$08
  OUT ($03),A
  LD A,$0A
  OUT ($03),A
  EI
  RET

; Routine??
;
; Used by the routine at L9E51.
LA02E:
  DI
  IM 1
  LD A,$06
  OUT ($04),A
  EI
  RET
  JP LA02E_0
LA02E_0:
  PUSH AF
  PUSH BC
  PUSH DE
  PUSH HL
  LD A,$80
  OUT ($10),A
  EXX
  LD HL,$A882
  EXX
  LD HL,$A582
  LD A,$20
  LD C,A
LA02E_1:
  LD B,$15
  INC C
  LD DE,$FD01
  OUT ($10),A
  ADD HL,DE
  LD DE,$000C
  EXX
  LD DE,$FD01
  ADD HL,DE
  LD DE,$000C
  EXX
LA02E_2:
  PUSH BC
  EXX
  ADD HL,DE
  LD A,(HL)
  AND $24
  EXX
  ADD HL,DE
  LD B,A
  LD A,(HL)
  AND $DB
  OR B
  OUT ($11),A
  EXX
  ADD HL,DE
  LD A,(HL)
  AND $92
  EXX
  ADD HL,DE
  LD B,A
  LD A,(HL)
  AND $6D
  OR B
  OUT ($11),A
  EXX
  ADD HL,DE
  LD A,(HL)
  AND $49
  EXX
  ADD HL,DE
  LD B,A
  LD A,(HL)
  AND $B6
  OR B
  OUT ($11),A
  POP BC
  DJNZ LA02E_2
  PUSH BC
  EXX
  ADD HL,DE
  LD A,(HL)
  AND $24
  EXX
  ADD HL,DE
  LD B,A
  LD A,(HL)
  AND $DB
  OR B
  OUT ($11),A
  POP BC
  LD A,C
  CP $2C
  JR NZ,LA02E_1
  LD A,($A0EB)
  INC A
  CP $03
  JR NZ,LA02E_3
  XOR A
LA02E_3:
  LD ($A0EB),A
  LD HL,$A0EC
  LD B,$00
  LD C,A
  ADD HL,BC
  LD A,(HL)
  LD ($A067),A
  LD ($A095),A
  CPL
  LD ($A06D),A
  LD ($A09B),A
  INC HL
  LD A,(HL)
  LD ($A075),A
  CPL
  LD ($A07B),A
  INC HL
  LD A,(HL)
  LD ($A083),A
  CPL
  LD ($A089),A
  LD A,($9E5E)
  OUT ($04),A
  LD A,$08
  OUT ($03),A
  LD A,$0A
  OUT ($03),A
  POP HL
  POP DE
  POP BC
  POP AF
  EI
  RET
  DEFB $02,$92,$49,$24,$92,$49

; Scan keyboard; returns key in A
;
; Used by the routines at L9DDD, L9E34, LA19E, LAD4F, LAD99, LADA1, LAE09,
; LB177, LB33F, LB9A2, LBA3D, LBA93, LBC8B and LBF6F.
LA0F1:
  PUSH BC
  PUSH DE
  PUSH HL
  LD B,$07
LA0F1_0:
  LD A,$07
  SUB B
  LD HL,$A15E
  LD D,$00
  LD E,A
  ADD HL,DE
  LD A,(HL)
  LD C,A
  LD A,$FF
  OUT ($01),A
  LD A,C
  OUT ($01),A
  IN A,($01)
  LD DE,$0000
  CP $FE
  JR Z,LA0F1_8
  CP $FD
  JR Z,LA0F1_7
  CP $FB
  JR Z,LA0F1_6
  CP $F7
  JR Z,LA0F1_5
  CP $EF
  JR Z,LA0F1_4
  CP $DF
  JR Z,LA0F1_3
  CP $BF
  JR Z,LA0F1_2
  CP $7F
  JR Z,LA0F1_1
  DJNZ LA0F1_0
  XOR A
  LD ($A19D),A
  JR LA0F1_9
LA0F1_1:
  INC E
LA0F1_2:
  INC E
LA0F1_3:
  INC E
LA0F1_4:
  INC E
LA0F1_5:
  INC E
LA0F1_6:
  INC E
LA0F1_7:
  INC E
LA0F1_8:
  PUSH DE
  LD A,$07
  SUB B
  ADD A,A
  ADD A,A
  ADD A,A
  LD D,$00
  LD E,A
  LD HL,$A165
  ADD HL,DE
  POP DE
  ADD HL,DE
  LD A,(HL)
  LD D,A
  LD A,($A19D)
  CP D
  JR Z,LA0F1_9
  LD A,D
  LD ($A19D),A
LA0F1_9:
  POP HL
  POP DE
  POP BC
  EI
  RET
  DEFB $FE,$FD,$FB,$F7,$EF,$DF,$BF
  DEFB $01,$02,$03,$04,$00,$00,$00,$00 ; Key scan codes: Down=$01, Left=$02,
  DEFB $09,$0A,$0B,$0C,$0D,$00,$0F,$00 ; Right=$03, Up=$04, Enter=$09,
  DEFB $8C,$12,$13,$14,$15,$16,$17,$00 ; Alpha=$36, Mode=$37
  DEFB $8D,$1A,$1B,$1C,$1D,$1E,$1F,$20 ;
  DEFB $21,$22,$23,$24,$25,$26,$27,$28 ;
  DEFB $00,$2A,$2B,$2C,$2D,$2E,$2F,$30 ;
  DEFB $31,$32,$33,$34,$35,$36,$37,$38 ;
  DEFB $00                ; Last key pressed

; Select interrupt frequency
;
; Used by the routine at L9DBE.
LA19E:
  LD HL,$9574
  LD DE,$9AA6
  LD A,$FF
  LD B,$0C
LA19E_0:
  LD (HL),A
  INC HL
  LD (DE),A
  INC DE
  DJNZ LA19E_0
  LD HL,$9580
  LD DE,$9581
  LD (HL),$00
  LD BC,$00BF
  LDIR
  LD HL,$9AB2
  LD DE,$9AB3
  LD (HL),$00
  LD BC,$00BF
  LDIR
  SET 7,(IY+$14)
  LD HL,$310A
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$A262             ; "Set interrupt frequency:" string
  RST $28                 ; rBR_CALL
  DEFW $4561              ; _VPutS - Displays a zero (0) terminated string
  LD HL,$3912
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$A27B
  RST $28                 ; rBR_CALL
  DEFW $4561              ; _VPutS - Displays a zero (0) terminated string
  LD HL,$3922
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$A27D             ; "2"
  RST $28                 ; rBR_CALL
  DEFW $4561              ; _VPutS - Displays a zero (0) terminated string
  LD HL,$3932
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$A27F
  RST $28                 ; rBR_CALL
  DEFW $4561              ; _VPutS - Displays a zero (0) terminated string
  LD HL,$3942
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$A281             ; "6"
  RST $28                 ; rBR_CALL
  DEFW $4561              ; _VPutS - Displays a zero (0) terminated string
  CALL LA001
  LD HL,$95EC
  LD B,$00
  LD A,($9E5E)
  ADD A,$02
  LD C,A
  ADD HL,BC
  LD B,$07
  LD A,$FF
  LD DE,$000C
LA19E_1:
  LD A,(HL)
  CPL
  LD (HL),A
  ADD HL,DE
  DJNZ LA19E_1
  CALL L9FEA              ; Copy screen 9340/9872 to A28F/A58F
LA19E_2:
  CALL LA0F1              ; Scan keyboard
  OR A
  JR Z,LA19E_2
  CP $09
  RET Z
  CP $21
  JR Z,LA19E_3
  CP $1A
  JR Z,LA19E_4
  CP $23
  JR Z,LA19E_5
  CP $13
  JR Z,LA19E_6
  JP LA19E
LA19E_3:
  XOR A
  LD ($9E5E),A
  JP LA19E
LA19E_4:
  LD A,$02
  LD ($9E5E),A
  JP LA19E
LA19E_5:
  LD A,$04
  LD ($9E5E),A
  JP LA19E
LA19E_6:
  LD A,$06
  LD ($9E5E),A
  JP LA19E
  DEFM "set interrupt frequency:",$00 ; "Set interrupt frequency:"
  DEFM "0",$00
  DEFM "2",$00
  DEFM "4",$00
  DEFM "6",$00

; Copy screen 1st color onto Screen 2nd color
LA283:
  LD HL,$9340
  LD DE,$9872
  LD BC,$0300
  LDIR
  RET

; Screen 1st color, 12*8*8 = 768 bytes
LA28F:


; Screen 2nd color, 12*8*8 = 768 bytes
LA58F:


; Display 96 tiles on the screen
;
; Used by the routines at L9DDD and LBA3D.
;
; HL Address where the 96 tiles are placed
LA88F:
  LD DE,$0000
LA88F_0:
  PUSH HL
  PUSH DE
  LD L,(HL)
  LD A,L
  OR A
  JR Z,LA88F_1
  CP $47
  CALL Z,LBB7E_8
  LD H,$00
  ADD HL,HL               ; HL <- HL * 16
  ADD HL,HL               ;
  ADD HL,HL               ;
  ADD HL,HL               ;
  LD BC,$E147             ; Tileset 1
  ADD HL,BC
  PUSH HL
  POP IX
  LD A,E
  LD L,D
  CALL L9EAD              ; Put tile on the screen
LA88F_1:
  POP DE
  POP HL
  INC HL
  INC E
  LD A,E
  CP $0C
  JP NZ,LA88F_0
  LD E,$00
  LD A,$08
  ADD A,D
  LD D,A
  CP $40
  JP NZ,LA88F_0
  RET
; This entry point is used by the routines at L9DDD and LA966.
LA88F_2:
  XOR A
  LD ($DD54),A
  JP LA88F_3
; This entry point is used by the routines at LA966 and LB00E.
LA88F_3:
  LD C,$00
  LD A,($DD55)
  OR A
  JR Z,LA88F_4
  LD HL,$DE87
  LD A,($DB75)
  ADD A,A
  ADD A,A
  JR LA88F_5
LA88F_4:
  LD HL,$DE47
  LD A,($DB75)
  ADD A,A
  ADD A,A
  ADD A,A
  ADD A,A
LA88F_5:
  LD E,A
  LD D,$00
  ADD HL,DE
  LD A,($DD54)
  ADD A,A
  ADD A,A
  LD E,A
  LD D,$00
  ADD HL,DE
  LD B,$04
LA88F_6:
  PUSH HL
  LD L,(HL)
  LD H,$00
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  LD DE,$E8E7
  ADD HL,DE
  EX DE,HL
  CALL LA88F_8
  PUSH BC
  CALL LA88F_12
  LD A,C
  CALL L9EDE
  POP BC
  POP HL
  INC HL
  DJNZ LA88F_6
  LD A,($DD54)
  CP $03
  JR Z,LA88F_7
  INC A
  LD ($DD54),A
  XOR A
  LD ($DD55),A
  JP L9DDD_0
LA88F_7:
  XOR A
  LD ($DD54),A
  JP L9DDD_0
LA88F_8:
  INC C
  LD A,($DB76)            ; Get X coord in tiles
  LD H,A
  LD A,($DB77)
  SUB $08
  LD L,A
  LD A,C
  CP $01
  RET Z
  CP $02
  JR NZ,LA88F_11
LA88F_9:
  LD A,($DB75)
  CP $02
  JR Z,LA88F_10
  INC H
  RET
LA88F_10:
  DEC H
  RET
LA88F_11:
  LD A,$08
  ADD A,L
  LD L,A
  LD A,C
  CP $04
  JR Z,LA88F_9
  RET
LA88F_12:
  LD C,$00
  LD A,($DB75)
  OR A
  RET Z
  CP $01
  RET Z
  CP $03
  RET Z
  LD C,$80
  RET

; Movement
;
; Used by the routine at L9DDD.
;
; Move Down
LA966:
  LD A,($DB75)
  OR A
  JP Z,LA966_0
  LD A,($DB7D)            ; Get look/shoot switch value
  CP $01
  JP NZ,LA966_0
  XOR A
  LD ($DB75),A
  JP LA88F_2
LA966_0:
  XOR A
  LD ($DB75),A
  CALL LAA60
  CP $01
  JP NZ,LA88F_3
  LD A,($DB77)
  PUSH AF
  ADD A,$08
  LD ($DB77),A
  LD A,($DB78)
  PUSH AF
  INC A
  LD ($DB78),A
  JR LA966_3
; Move Up
LA966_1:
  LD A,($DB75)
  CP $01
  JP Z,LA966_2
  LD A,($DB7D)            ; Get look/shoot switch value
  CP $01
  JP NZ,LA966_2
  LD A,$01
  LD ($DB75),A
  JP LA88F_2
LA966_2:
  LD A,$01
  LD ($DB75),A
  CALL LAA60
  CP $01
  JP NZ,LA88F_3
  LD A,($DB77)
  PUSH AF
  ADD A,$F8
  LD ($DB77),A
  LD A,($DB78)
  PUSH AF
  DEC A
  LD ($DB78),A
LA966_3:
  LD A,($DB84)
  OR A
  JP Z,LA966_4
  CALL LB653_17
  OR A
  JP Z,LA966_4
  CALL LB653_19
  OR A
  JP Z,LB00E_6            ; Decrease Health by 4, restore Y coord
LA966_4:
  POP AF
  POP AF
  JP LA88F_3
; Move Left
LA966_5:
  LD A,($DB75)
  CP $02
  JP Z,LA966_6
  LD A,($DB7D)            ; Get look/shoot switch value
  CP $01
  JP NZ,LA966_6
  LD A,$02
  LD ($DB75),A
  JP LA88F_2
LA966_6:
  LD A,$02
  LD ($DB75),A
  CALL LAA60
  CP $01
  JP NZ,LA88F_3
  LD A,($DB76)            ; Get X coord in tiles
  PUSH AF
  DEC A                   ; X = X - 1
  LD ($DB76),A
  JR LA966_9
; Move Right
LA966_7:
  LD A,($DB75)
  CP $03
  JP Z,LA966_8
  LD A,($DB7D)            ; Get look/shoot switch value
  CP $01
  JP NZ,LA966_8
  LD A,$03
  LD ($DB75),A
  JP LA88F_2
LA966_8:
  LD A,$03
  LD ($DB75),A
  CALL LAA60
  CP $01
  JP NZ,LA88F_3
  LD A,($DB76)            ; Get X coord in tiles
  PUSH AF
  INC A                   ; X = X + 1
  LD ($DB76),A
LA966_9:
  LD A,($DB84)
  OR A
  JP Z,LA966_10
  CALL LB653_17
  OR A
  JP Z,LA966_10
  CALL LB653_19
  OR A
  JP Z,LB00E_8            ; Decrease Health by 4, restore X coord
LA966_10:
  POP AF
  JP LA88F_3

; Routine??
;
; Used by the routine at LA966.
LAA60:
  CALL LADE5              ; Decode current room
  LD A,($DB76)            ; Get X coord in tiles
  LD E,A
  CALL LAA7D
  LD D,$00
  ADD HL,DE
  LD A,($DB74)
  LD E,A
  LD A,($DB78)
  LD B,A
  CALL LAA8D

; Routine??
;
; Used by the routine at LB653.
LAA78:
  ADD HL,DE
  DJNZ LAA78
  LD A,(HL)
  RET

; Routine??
;
; Used by the routine at LAA60.
LAA7D:
  LD A,($DB75)
  OR A
  RET Z
  CP $01
  RET Z
  CP $02
  JR NZ,LAA7D_0
  DEC E
  RET
LAA7D_0:
  INC E
  RET

; Routine??
;
; Used by the routine at LAA60.
LAA8D:
  LD A,($DB75)
  CP $02
  RET Z
  CP $03
  RET Z
  OR A
  JR NZ,LAA8D_0
  INC B
  RET
LAA8D_0:
  DEC B
  RET
; This entry point is used by the routines at LAAAF, LB513 and LB653.
LAA8D_1:
  LD A,($DB74)
  LD E,A
  LD A,($DB78)
  LD B,A
  LD A,($DB76)            ; Get X coord in tiles
LAA8D_2:
  ADD A,E
  DJNZ LAA8D_2
  LD ($DC56),A
  RET

; Look / Shoot
;
; Used by the routine at L9DDD.
LAAAF:
  LD A,($DB7D)            ; Get look/shoot switch value
  CP $01
  JP Z,LB758
  XOR A
  LD ($DC88),A
  CALL LAA8D_1
  CALL LAE09
LAAAF_0:
  LD A,(HL)
  LD C,A
  LD A,($DC56)
  SUB C
  JP Z,LAAAF_2
  LD A,($DC88)
  CP $31
  JP Z,LAAAF_1
  INC A
  LD ($DC88),A
  INC HL
  JP LAAAF_0
; This entry point is used by the routines at LAB28, LAC54, LACE3, LAD4F, LADA9
; and LBC8B.
LAAAF_1:
  JP L9DDD_1
LAAAF_2:
  LD A,($DC88)
  OR A
  JP Z,LAB28_0
  CP $01
  JP Z,LAB28_0
  CP $03
  JP Z,LAB28_4
  CP $04
  JP Z,LAB28_4
  CP $19
  JP Z,LAB28_5
  CP $1A
  JP Z,LAB28_5
  CP $21
  JP Z,LAB28_7
  CP $22
  JP Z,LAB28_7
  CP $06
  JP Z,LAC54
  CP $07
  JP Z,LAC54
  CP $0B
  JP Z,LACE3
  CP $0C
  JP Z,LACE3
  CP $0F
  JP Z,LBC8B
  CP $10
  JP Z,LBC8B
  JP L9DDD_1

; Show small message popup
;
; Used by the routines at LAC54, LACE3, LAD4F, LADA9, LB930, LB9A2, LBA93 and
; LBC8B.
LAB28:
  PUSH BC
  PUSH DE
  LD BC,$0060
  LD HL,$EB27             ; Decode from: Small message popup
  LD DE,$DBF5             ; Decode to
  CALL LB9F1              ; Decode the room
  LD HL,$DBF5
  CALL LB177              ; Display screen from tiles with Tileset #2
  POP DE
  POP BC
  RET
; This entry point is used by the routine at LAAAF.
LAB28_0:
  CALL LAE09
  LD DE,$0002
  CALL LAB28_9
  JP NZ,LAAAF_1
  LD A,($DB79)            ; Get room number
  CP $1B
  JP NZ,LAB28_2
  LD A,($DCF7)            ; Weapon slot
  OR A
  JP NZ,LAB28_2
  LD A,$0B
  LD ($DCF3),A
  LD A,$07
  LD ($DCF4),A
  CALL LAB28              ; Show small message popup
  CALL LAB28_1            ; Set penRow/penCol for small message popup
  LD HL,$E0D5             ; -> "It is not wise to proceed| without a weapon."
  CALL LBEDE              ; Load archived string and show message char-by-char
  JP LAD4F_1
; Set penRow/penCol for small message popup
LAB28_1:
  LD HL,$2C09
  LD ($86D7),HL           ; Set penRow/penCol
  RET
LAB28_2:
  LD A,$01
  LD ($DC8A),A
  CALL LAE09
  LD DE,$001C
LAB28_3:
  ADD HL,DE
  LD A,(HL)
  LD ($DC8C),A            ; Set Access code level
  LD DE,$0007
  ADD HL,DE
  LD A,(HL)
  LD ($DC86),A
  LD DE,$0004
  ADD HL,DE
  LD A,(HL)
  LD ($DC8B),A
  LD A,($DC8C)            ; Get Access code level
  OR A
  JP Z,LB00E
  JP LAE09_1
; This entry point is used by the routine at LAAAF.
LAB28_4:
  CALL LAE09
  LD DE,$0005
  CALL LAB28_9
  JP NZ,LAAAF_1
  LD A,$02
  LD ($DC8A),A
  CALL LAE09
  LD DE,$001D
  JP LAB28_3
; This entry point is used by the routine at LAAAF.
LAB28_5:
  CALL LAE09
  LD DE,$001B
  CALL LAB28_9
  JP NZ,LAAAF_1
  LD A,($DB79)
  CP $21
  JP NZ,LAB28_6
  LD DE,$0004
  CALL LB513_2
  JP NZ,LAB28_6
  LD A,$08
  LD ($DCF3),A
  LD A,$07
  LD ($DCF4),A
  CALL LAB28              ; Show small message popup
  LD HL,$2C06
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E0D7             ; -> "You cant enter that sector| Life-Support is
                          ; offline."
  CALL LBEDE              ; Load archived string and show message char-by-char
  JP LAD4F_1
LAB28_6:
  LD A,$03
  LD ($DC8A),A
  CALL LAE09
  LD DE,$001E
  JP LAB28_3
; This entry point is used by the routine at LAAAF.
LAB28_7:
  CALL LAE09
  LD DE,$0022
  CALL LAB28_9
  JP NZ,LAAAF_1
  LD A,($DB79)
  CP $45
  JP NZ,LAB28_8
  LD DE,$0005
  CALL LB513_2
  JP NZ,LAB28_8
  LD A,$06
  LD ($DCF3),A
  LD A,$07
  LD ($DCF4),A
  CALL LAB28              ; Show small message popup
  LD HL,$2C0A
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E0D9             ; -> "You cant enter until the|AirLock is
                          ; re-pressurised"
  CALL LBEDE              ; Load archived string and show message char-by-char
  JP LAD4F_1
LAB28_8:
  LD A,$04
  LD ($DC8A),A
  CALL LAE09
  LD DE,$001F
  JP LAB28_3
LAB28_9:
  ADD HL,DE
  LD A,(HL)
  LD C,A
  LD A,($DB75)
  SUB C
  RET

; Routine??
;
; Used by the routine at LAAAF.
LAC54:
  CALL LAE09
  LD DE,$0008
  ADD HL,DE
  LD A,(HL)
  LD C,A
  LD A,($DB75)
  SUB C
  JP NZ,LAAAF_1
  CALL LAE09
  LD DE,$000A
  ADD HL,DE
  LD A,(HL)
  LD ($DC89),A
  CALL LAE09
  LD DE,$0009
  ADD HL,DE
  LD A,(HL)
  CP $01
  JP Z,LAC54_0
  CALL LAB28              ; Show small message popup
  CALL LAB28_1            ; Set penRow/penCol for small message popup
  LD HL,$E0C3             ; " Another Dead Person"
  CALL LBEDE              ; Load archived string and show message char-by-char
  LD HL,$3309
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E0C5             ; " Search Reveals Nothing"
  CALL LBEDE              ; Load archived string and show message char-by-char
  JP LAD4F_1
LAC54_0:
  CALL LAD4F
  CP $01
  JP Z,LAAAF_1
  LD A,($DB79)
  OR A
  JP Z,LAC54_2
  CALL LAB28              ; Show small message popup
  CALL LAB28_1            ; Set penRow/penCol for small message popup
  LD HL,$E0C7             ; " This Person is Dead . . ."
  CALL LBEDE              ; Load archived string and show message char-by-char
  CALL LAC54_1
  JP LAD00
; This entry point is used by the routines at LAD00 and LADA9.
LAC54_1:
  LD HL,$3358
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E0B9             ; String with arrow down sign
  CALL LBEDE              ; Load archived string and show message char-by-char
  RET
LAC54_2:
  CALL LAB28              ; Show small message popup
  CALL LAB28_1            ; Set penRow/penCol for small message popup
  LD HL,$E0BF             ; "OMG! This Person Is DEAD!"
  CALL LBEDE              ; Load archived string and show message char-by-char
  LD HL,$3309
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E0C1             ; "What Happened Here!?!"
  CALL LBEDE              ; Load archived string and show message char-by-char
  CALL LAC54_1
  JP LAD00

; Routine??
;
; Used by the routine at LAAAF.
LACE3:
  CALL LAE09
  LD DE,$000D
  ADD HL,DE
  LD A,(HL)
  LD C,A
  LD A,($DB75)
  SUB C
  JP NZ,LAAAF_1
  JP LAD4F_0
; This entry point is used by the routines at LAD00 and LADA9.
LACE3_0:
  CALL L9FEA              ; Copy screen 9340/9872 to A28F/A58F
  CALL LAD99              ; Wait for Down key
  CALL LAB28              ; Show small message popup
  RET

; Routine??
;
; Used by the routine at LAC54.
LAD00:
  CALL LACE3_0
  LD HL,$2C0B
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E0C9             ; "They Seem To Be Holding"
  CALL LBEDE              ; Load archived string and show message char-by-char
  LD HL,$331F
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E0CB             ; "Something"
  CALL LBEDE              ; Load archived string and show message char-by-char
  LD A,($DBC7)
  INC A
  LD ($DBC7),A
; This entry point is used by the routine at LAD4F.
LAD00_0:
  CALL LAC54_1
  CALL LACE3_0
  LD HL,$2C18
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E0CF             ; "You Picked Up A"
  CALL LBEDE              ; Load archived string and show message char-by-char
  LD HL,$3309
  LD ($86D7),HL           ; Set penRow/penCol
  CALL LAE09_0
  CALL LBEDE              ; Load archived string and show message char-by-char
  LD A,($DC89)
  LD H,$00
  LD L,A
  LD DE,$DB9C
  ADD HL,DE
  LD (HL),$01
  JP LAD4F_1

; Routine??
;
; Used by the routine at LAC54.
LAD4F:
  LD A,($DC89)
  LD H,$00
  LD L,A
  LD DE,$DB9C
  ADD HL,DE
  LD A,(HL)
  RET
; This entry point is used by the routine at LACE3.
LAD4F_0:
  CALL LAE09
  LD DE,$000E
  ADD HL,DE
  LD A,(HL)
  LD ($DC89),A
  CP $23
  JP Z,LADA9
  CALL LAD4F
  CP $01
  JP Z,LAAAF_1
  CALL LAB28              ; Show small message popup
  LD HL,$2C0B
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E0CD             ; " Hey Whats This . . . ?"
  CALL LBEDE              ; Load archived string and show message char-by-char
  LD A,($DBC7)
  INC A
  LD ($DBC7),A
  JP LAD00_0
; This entry point is used by the routines at LAB28, LAC54, LAD00, LADA9 and
; LB930.
LAD4F_1:
  CALL L9FEA              ; Copy screen 9340/9872 to A28F/A58F
LAD4F_2:
  CALL LA0F1              ; Scan keyboard
  CP $37                  ; Mode key?
  JR NZ,LAD4F_2
  JP L9DDD_1

; Wait for Down key
;
; Used by the routines at LACE3 and LBADE.
LAD99:
  CALL LA0F1              ; Scan keyboard
  CP $01                  ; Down key?
  JR NZ,LAD99
  RET

; Wait for MODE key
;
; Used by the routines at LBADE, LBB7E and LBC8B.
LADA1:
  CALL LA0F1              ; Scan keyboard
  CP $37
  JR NZ,LADA1
  RET

; We've got weapon
;
; Used by the routine at LAD4F.
LADA9:
  LD A,($DCF7)            ; Weapon slot
  OR A
  JP NZ,LAAAF_1
  CALL LAB28              ; Show small message popup
  LD A,$01
  LD ($DCF7),A            ; We've got the weapon
  LD HL,$2C0E
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E0CD             ; -> "     Hey Whats This  .  .  . ?"
  CALL LBEDE              ; Load archived string and show message char-by-char
  CALL LAC54_1
  CALL LACE3_0
  LD HL,$2C18
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E0CF             ; "You Picked Up A"
  CALL LBEDE              ; Load archived string and show message char-by-char
  LD HL,$3316
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E0B7             ; " Ion Phaser"
  CALL LBEDE              ; Load archived string and show message char-by-char
  JP LAD4F_1

; Decode current room
;
; Used by the routines at L9DDD, LAA60, LB653 and LB76B.
LADE5:
  LD A,($DB79)            ; Get the room number
  LD HL,$DE97             ; List of encoded room addresses
  CALL LADFF              ; now HL = encoded room
  LD BC,$0060
  CALL LADF5              ; Decode the room to DBF5
  RET

; Decode the room to DBF5
;
; Used by the routines at LADE5, LAE09, LB0A2 and LB33F.
;
; HL Decode from
; BC Tile count to decode
LADF5:
  LD DE,$DBF5             ; Decode to
  CALL LB9F1              ; Decode the room
  LD HL,$DBF5
  RET

; Get address from table
;
; Used by the routines at LADE5, LAE09, LB3AF and LBF6F.
;
; A Element number
; HL Table address
LADFF:
  ADD A,A
  LD E,A
  LD D,$00
  ADD HL,DE
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  RET

; Routine??
;
; Used by the routines at LAAAF, LAB28, LAC54, LACE3, LAD4F, LB3AF, LB513,
; LB653 and LBC8B.
LAE09:
  LD A,($DB79)            ; Get room number
  LD HL,$DF27             ; Table of adresses for room descriptions
  CALL LADFF
  LD BC,$0031
  CALL LADF5
  RET
; This entry point is used by the routines at LAD00 and LB177.
LAE09_0:
  LD A,($DC89)
  LD HL,$DFB7
  CALL LADFF
  RET
; This entry point is used by the routine at LAB28.
LAE09_1:
  LD A,$28
  LD ($DC59),A
  LD A,($DC8B)
  LD D,$00
  LD E,A
  LD HL,$DCA2
  ADD HL,DE
  LD A,(HL)
  CP $01
  JP Z,LB00E
  LD B,$04
  LD HL,$DC8D
LAE09_2:
  LD (HL),$00
  INC HL
  DJNZ LAE09_2
  LD BC,$0060
  LD HL,$F468             ; Encoded screen: Door access panel popup
  CALL LADF5              ; Decode the room to DBF5
  CALL LB177              ; Display screen from tiles with Tileset #2
  LD A,$05
  LD ($DCF3),A
  INC A
  LD ($DCF4),A
  CALL LB00E_10
  LD HL,$E0DD             ; ": Door Locked :"
  CALL LBEDE              ; Load archived string and show message char-by-char
  LD HL,$2205
  LD ($86D7),HL           ; Set penRow/penCol
  CALL LAE09_21           ; Get "Access code level N required" string by access
                          ; level in DC8C
  CALL LBEDE              ; Load archived string and show message char-by-char
  LD A,$25
  LD ($DC82),A
  LD A,$50
  LD ($DC83),A
  LD A,$30
  LD ($DC84),A
  LD A,$06
  LD ($DC57),A
LAE09_3:
  LD HL,$0020
  LD DE,$EB39             ; Tileset 2
  ADD HL,DE
  PUSH HL
  POP IX
  LD B,$08
  LD A,($DC84)
  LD L,A
  LD A,($DC83)
  CALL L9E5F
  CALL L9FEA              ; Copy screen 9340/9872 to A28F/A58F
LAE09_4:
  LD B,$0C
LAE09_5:
  CALL LB2D0              ; Delay
  DJNZ LAE09_5
  CALL LA0F1              ; Scan keyboard
  CP $36
  JP Z,LAE09_6
  CP $02
  JP Z,LAE09_15
  CP $03
  JP Z,LAE09_16
  CP $37
  JP NZ,LAE09_4
  JP L9DDD_1
LAE09_6:
  LD A,($DC82)
  CP $25
  JP Z,LAE09_9
  LD A,($DC57)
  DEC A
  CP $01
  JP Z,LAE09_4
  LD ($DC57),A
  LD B,$03
  LD HL,$DC8D
  INC HL
LAE09_7:
  PUSH HL
  LD A,(HL)
  DEC HL
  LD (HL),A
  POP HL
  INC HL
  DJNZ LAE09_7
  LD DE,$0003
  LD HL,$DC8D
  ADD HL,DE
  LD A,($DC82)
  LD (HL),A
  LD HL,$DC8D
  LD A,$02
  LD C,A
  LD B,$00
LAE09_8:
  PUSH HL
  LD L,(HL)
  LD H,$00
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  LD DE,$EB39             ; Tileset 2
  ADD HL,DE
  PUSH BC
  EX DE,HL
  LD H,C
  LD L,$08
  XOR A
  CALL L9EDE
  POP BC
  POP HL
  INC HL
  INC C
  LD A,C
  CP $06
  JP NZ,LAE09_8
  CALL L9FEA              ; Copy screen 9340/9872 to A28F/A58F
  JP LAE09_4
LAE09_9:
  LD A,($DC57)
  DEC A
  CP $01
  JP Z,LAE09_11
LAE09_10:
  CALL LB00E_10
  LD HL,$E0DF             ; " INVALID CODE"
  CALL LBEDE              ; Load archived string and show message char-by-char
  CALL L9FEA              ; Copy screen 9340/9872 to A28F/A58F
  JP LAE09_4
LAE09_11:
  LD B,$04
  LD DE,$DC8D
  CALL LAE09_20
LAE09_12:
  LD A,(DE)
  LD C,A
  LD A,(HL)
  SUB C
  JP NZ,LAE09_10
  INC DE
  INC HL
  DJNZ LAE09_12
  CALL LB00E_10
  LD HL,$E0E1             ; " Accepted! "
  CALL LBEDE              ; Load archived string and show message char-by-char
  CALL L9FEA
  LD A,($DC8B)
  LD D,$00
  LD E,A
  LD HL,$DCA2
  ADD HL,DE
  LD (HL),$01
  JP LB00E
LAE09_13:
  CALL LAE09_19
  LD A,($DC82)
  INC A
  LD ($DC82),A
  RET
LAE09_14:
  CALL LAE09_19
  LD A,($DC82)
  DEC A
  LD ($DC82),A
  RET
LAE09_15:
  LD A,($DC83)
  CP $40
  JP Z,LAE09_17
  CALL LAE09_14
  LD A,($DC83)
  ADD A,$F8
  LD ($DC83),A
  JP LAE09_3
LAE09_16:
  LD A,($DC83)
  CP $50
  JP Z,LAE09_18
  CALL LAE09_13
  LD A,($DC83)
  ADD A,$08
  LD ($DC83),A
  JP LAE09_3
LAE09_17:
  LD A,($DC84)
  CP $18
  JP Z,LAE09_4
  CALL LAE09_14
  LD A,$50
  LD ($DC83),A
  LD A,($DC84)
  ADD A,$F8
  LD ($DC84),A
  JP LAE09_3
LAE09_18:
  LD A,($DC84)
  CP $30
  JP Z,LAE09_4
  CALL LAE09_13
  LD A,$40
  LD ($DC83),A
  LD A,($DC84)
  ADD A,$08
  LD ($DC84),A
  JP LAE09_3
LAE09_19:
  LD HL,$0020
  LD DE,$EB39             ; Tileset 2
  ADD HL,DE
  PUSH HL
  POP IX
  LD B,$08
  LD A,($DC84)
  LD L,A
  LD A,($DC83)
  CALL L9E5F
  CALL L9FEA              ; Copy screen 9340/9872 to A28F/A58F
  RET
LAE09_20:
  PUSH DE
  LD A,($DC8C)            ; Get Access code level
  ADD A,A
  LD E,A
  LD D,$00
  LD HL,$E015
  ADD HL,DE
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  POP DE
  RET
LAE09_21:
  LD A,($DC8C)            ; Get Access code level
  ADD A,A
  LD E,A
  LD D,$00
  LD HL,$E01F             ; Access code messages table
  ADD HL,DE
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  RET

; Routine??
;
; Used by the routines at LAB28 and LAE09.
LB00E:
  XOR A
  LD ($DB82),A
  LD A,$40
  LD ($DC59),A
  LD A,($DC8A)
  CP $01
  JP Z,LB00E_2
  CP $02
  JP Z,LB00E_3
  CP $03
  JP Z,LB00E_4
  CP $04
  JP Z,LB00E_5
LB00E_0:
  LD B,$08
LB00E_1:
  CALL LB2D0              ; Delay
  DJNZ LB00E_1
  LD A,($DC86)
  LD ($DB79),A
  JP L9DDD_1
LB00E_2:
  LD A,$18
  LD ($DB77),A
  XOR A
  LD ($DB75),A
  LD A,$03
  LD ($DB78),A
  JP LB00E_0
LB00E_3:
  LD A,$30
  LD ($DB77),A
  LD A,$01
  LD ($DB75),A
  LD A,$06
  LD ($DB78),A
  JP LB00E_0
LB00E_4:
  LD A,$0A
  LD ($DB76),A            ; Set X coord = 10
  LD A,$02
  LD ($DB75),A
  JP LB00E_0
LB00E_5:
  LD A,$01
  LD ($DB76),A            ; Set X coord = 1
  LD A,$03
  LD ($DB75),A
  JP LB00E_0
; Decrease Health by 4, restore Y coord
LB00E_6:
  LD B,$02
LB00E_7:
  CALL LB994              ; Decrease Health
  DJNZ LB00E_7
  POP AF
  LD ($DB78),A
  POP AF
  LD ($DB77),A
  JP LA88F_3
; Decrease Health by 4, restore X coord
LB00E_8:
  LD B,$02
LB00E_9:
  CALL LB994              ; Decrease Health
  DJNZ LB00E_9
  POP AF                  ; Restore old X coord
  LD ($DB76),A            ; Set X coord
  JP LA88F_3
; This entry point is used by the routine at LAE09.
LB00E_10:
  LD HL,$1705
  LD ($86D7),HL           ; Set penRow/penCol
  RET

; Open Inventory
;
; Used by the routine at L9DDD.
LB0A2:
  LD BC,$0060             ; Titles count to decode
  LD HL,$F329             ; Encoded screen for Inventory popup
  CALL LADF5              ; Decode the room to DBF5
  CALL LB177              ; Display screen from tiles with Tileset #2
  LD A,$0B
  LD ($DCF3),A
  LD A,$06
  LD ($DCF4),A
  XOR A
  LD ($DCF5),A            ; Data cartridge reader slot
  LD ($DC59),A
  LD ($DC5A),A
  LD ($DCF8),A
  LD A,$08
  LD ($DC83),A
  LD A,$12
  LD ($DC84),A
  LD HL,$0B18
  LD ($86D7),HL
  LD HL,$E0BB             ; " - INVENTORY - "
  CALL LBEDE              ; Load archived string and show message char-by-char
  LD HL,$DB9C
  LD B,$1D
LB0A2_0:
  PUSH HL
  LD A,(HL)
  CP $01
  CALL Z,LB0A2_4
  POP HL
  INC HL
  DJNZ LB0A2_0
  LD A,($DC5A)
  LD C,A
  LD A,$1D
  SUB C
  LD C,A
LB0A2_1:
  PUSH BC
  LD IX,$F319
  CALL LB0A2_5
  POP BC
  LD A,C
  OR A
  JP Z,LB0A2_2
  DEC C
  LD HL,$DC5B
  LD A,($DC5A)
  LD E,A
  LD D,$00
  ADD HL,DE
  LD A,$63
  LD (HL),A
  LD A,($DC5A)
  INC A
  LD ($DC5A),A
  JP LB0A2_1
LB0A2_2:
  JP LB177_2
LB0A2_3:
  LD A,$08
  LD ($DC83),A
  LD A,($DC84)
  ADD A,$0A
  LD ($DC84),A
  RET
LB0A2_4:
  PUSH BC
  LD C,B
  LD A,$1D
  SUB C
  PUSH AF
  CALL LB513_1
  LD L,A
  LD H,$00
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  LD DE,$F36F
  ADD HL,DE
  PUSH HL
  POP IX
  CALL LB0A2_5
  LD HL,$DC5B
  LD A,($DC5A)
  LD E,A
  LD D,$00
  ADD HL,DE
  POP AF
  LD (HL),A
  OR A
  CALL Z,LB2DE_2
  LD A,($DC5A)
  INC A
  LD ($DC5A),A
  POP BC
  RET
LB0A2_5:
  LD A,($DC84)
  LD L,A
  LD A,($DC83)
  LD B,$08
  CALL L9E5F
  LD A,($DC83)
  ADD A,$08
  LD ($DC83),A
  CP $58
  CALL Z,LB0A2_3
  RET

; Display screen from tiles with Tileset #2
;
; Used by the routines at LAB28, LAE09, LB0A2, LB33F, LBA3D and LBB7E.
;
; HL Screen in tiles, usually $DBF5
LB177:
  LD BC,$0000
LB177_0:
  PUSH HL
  PUSH BC
  LD L,(HL)
  LD A,L
  CP $01
  JR Z,LB177_1
  LD H,$00
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  ADD HL,HL
  LD DE,$EB39             ; Tileset 2
  ADD HL,DE
  PUSH HL
  POP DE
  LD H,C
  LD L,B
  XOR A
  CALL L9EDE
LB177_1:
  POP BC
  POP HL
  INC HL
  INC C
  LD A,C
  CP $0C
  JP NZ,LB177_0
  LD C,$00
  LD A,$08
  ADD A,B
  LD B,A
  CP $40
  JP NZ,LB177_0
  RET
; This entry point is used by the routine at LB0A2.
LB177_2:
  XOR A
  LD ($DC82),A
  LD A,$08
  LD ($DC83),A
  LD A,$12
  LD ($DC84),A
  CALL LB177_15
LB177_3:
  CALL LBEDE              ; Load archived string and show message char-by-char
  CALL LB177_14
; This entry point is used by the routines at LB2DE, LB3AF, LB3F4, LB44A,
; LB487, LB4C4 and LB501.
LB177_4:
  CALL LA0F1              ; Scan keyboard
  CP $37
  JP Z,L9DDD
  CP $36
  JP Z,LB2DE_3
  CP $02
  JP Z,LB177_8
  CP $03
  JP Z,LB177_9
  JP LB177_4
LB177_5:
  CALL LB2DE
  CALL LB177_15
  RET
LB177_6:
  CALL LB177_14
  LD A,($DC82)
  DEC A
  LD ($DC82),A
  CALL LB177_5
  RET
LB177_7:
  CALL LB177_14
  LD A,($DC82)
  INC A
  LD ($DC82),A
  CALL LB177_5
  RET
LB177_8:
  LD A,($DC83)
  CP $08
  JP Z,LB177_12
  CALL LB177_6
  LD A,($DC83)
  ADD A,$F8
  LD ($DC83),A
  JP LB177_3
LB177_9:
  LD A,($DC83)
  CP $50
  JP Z,LB177_10
  CALL LB177_7
  LD A,($DC83)
  ADD A,$08
  LD ($DC83),A
  JP LB177_3
LB177_10:
  LD A,($DC84)
  CP $26
  JP Z,LB177_11
  CALL LB177_7
  LD A,($DC84)
  ADD A,$0A
  LD ($DC84),A
  LD A,$08
  LD ($DC83),A
  JP LB177_3
LB177_11:
  CALL LB177_14
  LD A,$08
  LD ($DC83),A
  LD A,$12
  LD ($DC84),A
  XOR A
  LD ($DC82),A
  CALL LB2DE
  CALL LB177_15
  JP LB177_3
LB177_12:
  LD A,($DC84)
  CP $12
  JP Z,LB177_13
  CALL LB177_6
  LD A,($DC84)
  ADD A,$F6
  LD ($DC84),A
  LD A,$50
  LD ($DC83),A
  JP LB177_3
LB177_13:
  CALL LB177_14
  LD A,$50
  LD ($DC83),A
  LD A,$26
  LD ($DC84),A
  LD A,$1D
  LD ($DC82),A
  CALL LB2DE
  CALL LB177_15
  JP LB177_3
LB177_14:
  LD DE,$0020
  LD HL,$EB39             ; Tileset 2
  ADD HL,DE
  PUSH HL
  POP IX
  LD B,$08
  LD A,($DC84)
  LD L,A
  LD A,($DC83)
  CALL L9E5F
  CALL L9FEA              ; Copy screen 9340/9872 to A28F/A58F
  RET
LB177_15:
  LD HL,$3409
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$DC5B
  LD A,($DC82)
  LD D,$00
  LD E,A
  ADD HL,DE
  LD A,(HL)
  CP $63
  JP Z,LB177_16
  LD ($DC89),A
  CALL LAE09_0
  RET
LB177_16:
  LD HL,$E0DB
  RET

; Delay by DC59
;
; Used by the routines at L9E34, L9E51, LAE09, LB00E, LB930, LBB7E, LBEDE and
; LBF6F.
LB2D0:
  LD A,($DC59)
  LD C,A
LB2D0_0:
  LD D,A
LB2D0_1:
  DEC D
  JP NZ,LB2D0_1
  DEC C
  JP NZ,LB2D0_0
  RET

; Routine??
;
; Used by the routines at LB177, LB3AF, LB3F4, LB501 and LB513.
LB2DE:
  LD A,($DCF2)
  CP $01
  JP NZ,LB2DE_0
  LD HL,$2E05
  CALL LB2DE_1
LB2DE_0:
  LD HL,$3405
  CALL LB2DE_1
  XOR A
  LD ($DCF2),A
  RET
LB2DE_1:
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$DCF9
  RST $28                 ; rBR_CALL
  DEFW $4561              ; _VPutS - Displays a zero (0) terminated string
  RET
; We've got Data cartridge reader
LB2DE_2:
  LD A,$01
  LD ($DCF5),A            ; Data cartridge reader slot
  RET
; This entry point is used by the routine at LB177.
LB2DE_3:
  LD HL,$DC5B
  LD A,($DC82)
  LD D,$00
  LD E,A
  ADD HL,DE
  LD A,(HL)
  CP $63
  JP Z,LB177_4
  LD ($DC89),A
  OR A                    ; $00 - Data cartridge reader
  JP Z,LB33F
  CP $13                  ; Power Drill?
  JP Z,LB3F4
  CP $14                  ; Life Support Data Disk?
  JP Z,LB44A
  CP $15                  ; Air-Lock Tool?
  JP Z,LB487
  CP $16                  ; Box of Power Cells
  JP Z,LB4C4
  CP $19                  ; Rubik's Cube
  JP Z,LB501
  SUB $11                 ; Data cartridge?
  JP C,LB3AF
  JP LB3AF_2

; Data cartridge reader selected in the Inventory
;
; Used by the routines at LB2DE and LB3AF.
LB33F:
  LD A,$44
  LD ($DC59),A
  LD ($DC85),A
  LD BC,$0060
  LD HL,$F42F             ; Data cartridge reader screen
  CALL LADF5
  CALL LB177              ; Display screen from tiles with Tileset #2
  LD A,($DCF8)
  CP $01
  JP Z,LB33F_0
  LD A,$21
  LD ($DCF3),A
  LD HL,$160B
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E09B             ; "         No Data Cartridge| Selected"
  JP LB33F_1
LB33F_0:
  LD HL,$0A0B
  LD ($86D7),HL           ; Set penRow/penCol
  POP HL
LB33F_1:
  CALL LBEDE              ; Load archived string and show message char-by-char
  LD A,($DC89)
  CP $02
  CALL Z,LB33F_3
  CP $03
  CALL Z,LB33F_4
  CP $04
  CALL Z,LB33F_5
  CALL L9FEA              ; Copy screen 9340/9872 to A28F/A58F
LB33F_2:
  CALL LA0F1              ; Scan keyboard
  CP $37
  JP NZ,LB33F_2
  XOR A
  LD ($DC85),A
  JP L9DDD
LB33F_3:
  LD HL,$DC96
  CALL LBC3C
  RET
LB33F_4:
  LD HL,$DC9A
  CALL LBC3C
  RET
LB33F_5:
  LD HL,$DC9E
  CALL LBC3C
  RET

; Data cartridge selected in the Inventory
;
; Used by the routine at LB2DE.
LB3AF:
  LD A,($DCF5)            ; Data cartridge reader
  OR A
  JP Z,LB3AF_0
  LD A,($DC89)
  LD HL,$DFF3
  CALL LADFF              ; Get address from table
  PUSH HL
  LD A,$01
  LD ($DCF8),A
  JP LB33F
LB3AF_0:
  CALL LB2DE
  LD HL,$2E0C
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E0E3             ; " You Need A|Data Cartridge Reader"
  CALL LB513              ; Show message
  JP LB177_4
; This entry point is used by the routines at LB3F4, LB44A, LB487 and LB4C4.
LB3AF_1:
  CALL LAE09
  LD DE,$0011
  ADD HL,DE
  LD A,(HL)
  LD C,A
  LD A,($DB75)
  SUB C
  RET
; This entry point is used by the routines at LB2DE, LB3F4, LB44A, LB487 and
; LB4C4.
LB3AF_2:
  CALL LB513_0
  LD HL,$E129             ; "You dont seem to be able| to use this item here"
  CALL LB513              ; Show message
  JP LB177_4

; Power drill selected in the Inventory
;
; Used by the routine at LB2DE.
LB3F4:
  CALL LB3AF_1
  JP NZ,LB3AF_2
  CALL LB513_3
  CP $01
  JP NZ,LB3AF_2
  LD HL,$DB90
  INC HL
  LD A,(HL)
  OR A
  JP NZ,LB3F4_1
  CALL LB513_4
  SUB C
  JP Z,LB3F4_0
  INC HL
  LD A,(HL)
  LD C,A
  LD A,($DC56)
  SUB C
  JP NZ,LB3AF_2
LB3F4_0:
  CALL LB513_0
  LD HL,$E137             ; " You use the Power Drill|to Repair the Generator"
  CALL LB513              ; Show message
  LD HL,$DB90
  INC HL
  LD (HL),$01
  JP LB177_4
; This entry point is used by the routines at LB44A, LB487 and LB4C4.
LB3F4_1:
  LD A,$05
  LD ($DCF3),A
  LD A,$06
  LD ($DCF4),A
  CALL LB2DE
  LD HL,$2E05
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E12D             ; " It doesnt look like you| can do anything else
                          ; here"
  CALL LB513              ; Show message
  JP LB177_4

; Life Support Data Disk selected in the Inventory
;
; Used by the routine at LB2DE.
LB44A:
  CALL LB3AF_1
  JP NZ,LB3AF_2
  CALL LB513_3
  CP $04
  JP NZ,LB3AF_2
  LD DE,$0004
  CALL LB513_2
  JP NZ,LB3F4_1
  CALL LB513_4
  SUB C
  JP Z,LB44A_0
  INC HL
  LD A,(HL)
  LD C,A
  LD A,($DC56)
  SUB C
  JP NZ,LB3AF_2
LB44A_0:
  CALL LB513_0
  LD HL,$E139             ; " Life-Support System|has been fully restored"
  CALL LB513              ; Show message
  LD DE,$0004
  LD HL,$DB90
  ADD HL,DE
  LD (HL),$01
  JP LB177_4

; Air-Lock Tool selected in the Inventory
;
; Used by the routine at LB2DE.
LB487:
  CALL LB3AF_1
  JP NZ,LB3AF_2
  CALL LB513_3
  CP $05
  JP NZ,LB3AF_2
  LD DE,$0005
  CALL LB513_2
  JP NZ,LB3F4_1
  CALL LB513_4
  SUB C
  JP Z,LB487_0
  INC HL
  LD A,(HL)
  LD C,A
  LD A,($DC56)
  SUB C
  JP NZ,LB3AF_2
LB487_0:
  CALL LB513_0
  LD HL,$E13B             ; "The Evacuation Deck has| been re-pressurised"
  CALL LB513              ; Show message
  LD DE,$0005
  LD HL,$DB90
  ADD HL,DE
  LD (HL),$01
  JP LB177_4

; Box of Power Cells selected in the Inventory
;
; Used by the routine at LB2DE.
LB4C4:
  CALL LB3AF_1
  JP NZ,LB3AF_2
  CALL LB513_3
  CP $06
  JP NZ,LB3AF_2
  LD DE,$0006
  CALL LB513_2
  JP NZ,LB3F4_1
  CALL LB513_4
  SUB C
  JP Z,LB4C4_0
  INC HL
  LD A,(HL)
  LD C,A
  LD A,($DC56)
  SUB C
  JP NZ,LB3AF_2
LB4C4_0:
  CALL LB513_0
  LD HL,$E13D             ; "You Insert a Power Cell.|Guidance System Online"
  CALL LB513              ; Show message
  LD DE,$0006
  LD HL,$DB90
  ADD HL,DE
  LD (HL),$01
  JP LB177_4

; Rubik's Cube selected in the Inventory
;
; Used by the routine at LB2DE.
LB501:
  CALL LB2DE
  LD HL,$2E0C
  LD ($86D7),HL
  LD HL,$E12B             ; "You dont have any time| to play with this now"
  CALL LB513              ; Show message
  JP LB177_4

; Show message HL
;
; Used by the routines at LB3AF, LB3F4, LB44A, LB487, LB4C4 and LB501.
LB513:
  CALL LBEDE              ; Load archived string and show message char-by-char
  CALL L9FEA              ; Copy screen 9340/9872 to A28F/A58F
  LD A,$01
  LD ($DCF2),A
  RET
; This entry point is used by the routines at LB3AF, LB3F4, LB44A, LB487 and
; LB4C4.
LB513_0:
  CALL LB2DE
  LD HL,$2E09
  LD ($86D7),HL
  RET
; This entry point is used by the routine at LB0A2.
LB513_1:
  OR A
  RET Z
  SUB $11
  RET NC
  LD A,$01
  RET
; This entry point is used by the routines at LAB28, LB44A, LB487 and LB4C4.
LB513_2:
  LD HL,$DB90
  ADD HL,DE
  LD A,(HL)
  OR A
  RET
; This entry point is used by the routines at LB3F4, LB44A, LB487 and LB4C4.
LB513_3:
  CALL LAE09
  LD DE,$0013
  ADD HL,DE
  LD A,(HL)
  RET
; This entry point is used by the routines at LB3F4, LB44A, LB487 and LB4C4.
LB513_4:
  CALL LAA8D_1
  CALL LAE09
  LD DE,$000F
  ADD HL,DE
  LD A,(HL)
  LD C,A
  LD A,($DC56)
  RET

; Routine??
;
; Used by the routine at L9DDD.
LB551:
  CALL LB653_17
  OR A
  RET Z
  LD A,($DB82)
  OR A
  JP NZ,LB551_0
  DEC HL
  LD A,(HL)
  LD ($DB81),A
  DEC HL
  LD A,(HL)
  LD ($DB80),A
  DEC HL
  LD A,(HL)
  LD ($DB7F),A
  DEC HL
  LD A,(HL)
  LD ($DB7E),A
  LD A,$03
  LD ($DB85),A
  LD A,$01
  LD ($DB84),A
LB551_0:
  LD A,($DB84)
  OR A
  JP Z,LB551_5
  LD B,$08
  CALL $4086
  OR A
  JP Z,LB551_1
  CP $02
  JP Z,LB551_2
  CP $04
  JP Z,LB551_3
  CP $06
  JP Z,LB551_4
  JP LB551_5
LB551_1:
  LD A,$00
  LD ($DB86),A
  CALL LB653_15
  OR A
  JP Z,LB653_18
  CALL LB653_6
  CP $01
  JP NZ,LB551_5
  LD A,($DB7F)
  ADD A,$08
  LD ($DB7F),A
  LD A,($DB80)
  INC A
  LD ($DB80),A
  JP LB551_5
LB551_2:
  LD A,$01
  LD ($DB86),A
  CALL LB653_15
  OR A
  JP Z,LB653_18
  CALL LB653_6
  CP $01
  JP NZ,LB551_5
  LD A,($DB7F)
  ADD A,$F8
  LD ($DB7F),A
  LD A,($DB80)
  DEC A
  LD ($DB80),A
  JP LB551_5
LB551_3:
  LD A,$02
  LD ($DB86),A
  CALL LB653_15
  OR A
  JP Z,LB653_18
  CALL LB653_6
  CP $01
  JP NZ,LB551_5
  LD A,($DB7E)
  DEC A
  LD ($DB7E),A
  JP LB551_5
LB551_4:
  LD A,$03
  LD ($DB86),A
  CALL LB653_15
  OR A
  JP Z,LB653_18
  CALL LB653_6
  CP $01
  JP NZ,LB551_5
  LD A,($DB7E)
  INC A
  LD ($DB7E),A
; This entry point is used by the routine at LB653.
LB551_5:
  LD A,($DB7E)
  LD H,A
  LD A,($DB7F)
  LD L,A
  LD A,$00
  CALL LB653_1
  CALL L9EDE
  LD A,$01
  LD ($DB82),A
  LD A,($DB83)
  INC A
  CP $01
  CALL NZ,LB653_0
  LD ($DB83),A
  LD A,($DB81)
  CP $02
  JP Z,LB76B_7
; This entry point is used by the routine at LB76B.
LB551_6:
  CALL LB76B_22
  OR A
  CALL Z,LB653_16
  RET

; Routine??
;
; Used by the routine at L9DDD.
LB653:
  LD A,($DB84)
  OR A
  RET Z
  CALL LB653_17
  OR A
  RET Z
  LD A,($DB81)
  CP $02
  RET NZ
  LD A,($DB7E)
  LD H,A
  LD A,($DB7F)
  ADD A,$F8
  LD L,A
  LD A,$00
  CALL LB653_4
  CALL L9EDE
  RET
; This entry point is used by the routine at LB551.
LB653_0:
  XOR A
  LD ($DB83),A
  RET
; This entry point is used by the routine at LB551.
LB653_1:
  LD A,($DB84)
  JP NZ,LB653_2
  LD DE,$EA67
  RET
LB653_2:
  LD A,($DB81)
  CP $02
  JP Z,LB653_3
  LD DE,$EA57
  LD A,($DB83)
  OR A
  RET Z
  LD A,$40
  RET
LB653_3:
  LD DE,$EA87
  JR LB653_5
LB653_4:
  LD DE,$EA77
LB653_5:
  LD A,($DB83)
  OR A
  RET Z
  PUSH HL
  LD HL,$0020
  ADD HL,DE
  PUSH HL
  POP DE
  LD A,$00
  POP HL
  RET
; This entry point is used by the routine at LB551.
LB653_6:
  CALL LADE5              ; Decode current room
  LD A,($DB7E)
  LD E,A
  CALL LB653_7
  LD D,$00
  ADD HL,DE
  LD A,($DB74)
  LD E,A
  LD D,$00
  LD A,($DB80)
  LD B,A
  CALL LB653_9
  JP LAA78
LB653_7:
  LD A,($DB86)
  OR A
  RET Z
  CP $01
  RET Z
  CP $02
  JR NZ,LB653_8
  DEC E
  RET
LB653_8:
  INC E
  RET
LB653_9:
  LD A,($DB86)
  CP $02
  RET Z
  CP $03
  RET Z
  OR A
  JR NZ,LB653_10
  INC B
  RET
LB653_10:
  DEC B
  RET
; This entry point is used by the routine at LB76B.
LB653_11:
  CALL LB653_13
  LD A,($DB7E)
LB653_12:
  ADD A,C
  DJNZ LB653_12
  LD ($DB87),A
  RET
LB653_13:
  LD A,($DB74)
  LD C,A
  LD A,($DB80)
  LD B,A
  RET
LB653_14:
  CALL LB653_13
  CALL LB653_9
  LD A,($DB7E)
  LD E,A
  CALL LB653_7
  LD A,E
  JR LB653_12
; This entry point is used by the routine at LB551.
LB653_15:
  CALL LAA8D_1
  CALL LB653_14
  LD C,A
  LD A,($DC56)
  SUB C
  RET
; This entry point is used by the routines at LB551 and LB76B.
LB653_16:
  XOR A
  LD ($DB84),A
  CALL LB76B_24
  LD HL,($DBC5)
  INC HL
  LD ($DBC5),HL
  RET
; This entry point is used by the routines at LA966 and LB551.
LB653_17:
  CALL LAE09
  LD DE,$002F
  ADD HL,DE
  LD A,(HL)
  RET
; This entry point is used by the routine at LB551.
LB653_18:
  XOR A
  LD ($DB8D),A
  CALL LB994              ; Decrease Health
  LD A,($DB81)
  CP $02
  JP NZ,LB551_5
  CALL LB994              ; Decrease Health
  JP LB551_5
; This entry point is used by the routine at LA966.
LB653_19:
  CALL LAA8D_1
  CALL LB653_11
  LD C,A
  LD A,($DC56)
  SUB C
  RET

; Shoot with the Weapon
;
; Used by the routine at LAAAF.
LB758:
  LD A,($DB8C)
  CP $01
  JP Z,LB758_0
  LD A,$01
  LD ($DB8D),A
  LD ($DD55),A
LB758_0:
  JP L9DDD_1

; Routine??
;
; Used by the routine at L9DDD.
LB76B:
  LD A,($DB8D)
  OR A
  JP Z,LB76B_8
  LD A,($DB8C)
  CP $01
  JP Z,LB76B_0
  LD A,$01
  LD ($DB8D),A
  LD A,($DB75)
  LD ($DB8B),A
  LD A,($DB76)
  LD ($DB88),A
  LD A,($DB77)
  LD ($DB89),A
  LD A,($DB78)
  LD ($DB8A),A
LB76B_0:
  LD A,($DB8B)
  OR A
  JP Z,LB76B_1
  CP $01
  JP Z,LB76B_2
  CP $02
  JP Z,LB76B_3
  CP $03
  JP Z,LB76B_4
LB76B_1:
  CALL LB76B_14
  CP $01
  JP NZ,LB76B_23
  LD A,($DB89)
  ADD A,$08
  LD ($DB89),A
  LD A,($DB8A)
  INC A
  LD ($DB8A),A
  JP LB76B_5
LB76B_2:
  CALL LB76B_14
  CP $01
  JP NZ,LB76B_23
  LD A,($DB89)
  ADD A,$F8
  LD ($DB89),A
  LD A,($DB8A)
  DEC A
  LD ($DB8A),A
  JP LB76B_5
LB76B_3:
  CALL LB76B_14
  CP $01
  JP NZ,LB76B_23
  LD A,($DB88)
  DEC A
  LD ($DB88),A
  JP LB76B_5
LB76B_4:
  CALL LB76B_14
  CP $01
  JP NZ,LB76B_23
  LD A,($DB88)
  INC A
  LD ($DB88),A
  JP LB76B_5
LB76B_5:
  LD A,($DB8D)
  OR A
  JP Z,LB76B_8
  LD A,($DB88)
  LD H,A
  LD A,($DB89)
  LD L,A
  CALL LB76B_9
  CALL L9EDE
  LD A,$01
  LD ($DB8C),A
  LD A,($DB81)
  CP $02
  JP Z,LB76B_7
  CALL LB551_6
LB76B_6:
  RET
; This entry point is used by the routine at LB551.
LB76B_7:
  CALL LB76B_22
  OR A
  JP NZ,LB76B_6
  XOR A
  LD ($DB8D),A
  LD ($DB88),A
  LD ($DB89),A
  LD A,($DB85)
  DEC A
  LD ($DB85),A
  OR A
  CALL Z,LB653_16
  JP LB76B_6
LB76B_8:
  XOR A
  LD ($DB8C),A
  RET
LB76B_9:
  LD A,($DB8B)
  OR A
  JP Z,LB76B_10
  CP $01
  JP Z,LB76B_11
  CP $02
  JP Z,LB76B_12
  CP $03
  JP Z,LB76B_13
LB76B_10:
  LD DE,$EAC7
  XOR A
  RET
LB76B_11:
  LD DE,$EAC7
  LD A,$40
  RET
LB76B_12:
  LD DE,$EAB7
  LD A,$80
  RET
LB76B_13:
  LD DE,$EAB7
  LD A,$40
  RET
LB76B_14:
  CALL LADE5              ; Decode current room
  LD A,($DB88)
  LD E,A
  CALL LB76B_16
  LD D,$00
  ADD HL,DE
  LD A,($DB74)
  LD E,A
  LD D,$00
  LD A,($DB8A)
  LD B,A
  CALL LB76B_18
LB76B_15:
  ADD HL,DE
  DJNZ LB76B_15
  LD A,(HL)
  RET
LB76B_16:
  LD A,($DB8B)
  OR A
  RET Z
  CP $01
  RET Z
  CP $02
  JR NZ,LB76B_17
  DEC E
  RET
LB76B_17:
  INC E
  RET
LB76B_18:
  LD A,($DB8B)
  CP $02
  RET Z
  CP $03
  RET Z
  OR A
  JR NZ,LB76B_19
  INC B
  RET
LB76B_19:
  DEC B
  RET
LB76B_20:
  LD A,($DB74)
  LD C,A
  LD A,($DB8A)
  LD B,A
  LD A,($DB88)
LB76B_21:
  ADD A,C
  DJNZ LB76B_21
  RET
; This entry point is used by the routine at LB551.
LB76B_22:
  CALL LB653_11
  CALL LB76B_20
  LD C,A
  LD A,($DB87)
  SUB C
  RET
LB76B_23:
  CALL LB76B_24
  JP LB76B_5
; This entry point is used by the routine at LB653.
LB76B_24:
  XOR A
  LD ($DB8D),A
  LD ($DB88),A
  LD ($DB89),A
  LD ($DB8A),A
  RET

; Show look/shoot selection indicator
;
; Used by the routine at L9DDD.
LB8EA:
  LD A,($DB7D)            ; Get look/shoot switch value
  OR A
  JP Z,LB8EA_0
  CALL LB8EA_1
  LD A,$41
  CALL L9E5F
  CALL LB8EA_2
  LD A,$51
  CALL L9E5F
  RET
LB8EA_0:
  CALL LB8EA_1
  LD A,$37
  CALL L9E5F
  CALL LB8EA_2
  LD A,$46
  CALL L9E5F
  RET
LB8EA_1:
  LD IX,$EAF7
  LD B,$08
  LD L,$00
  RET
LB8EA_2:
  LD IX,$EB07
  LD B,$08
  LD L,$00
  RET

; Routine??
;
; Used by the routines at LB930 and LBA93.
LB925:
  LD A,$0B
  LD ($DCF3),A
  LD A,$07
  LD ($DCF4),A
  RET

; Switch Look / Shoot mode
;
; Used by the routine at L9DDD.
LB930:
  LD A,($DCF7)            ; Weapon slot
  OR A
  JP NZ,LB930_0
  CALL LB925
  CALL LAB28              ; Show small message popup
  LD HL,$2C16
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E0D3             ; "You dont have a| Weapon to equip!"
  CALL LBEDE              ; Load archived string and show message char-by-char
  JP LAD4F_1
LB930_0:
  LD A,($DB7D)            ; Get look/shoot switch value
  CP $01
  JP Z,LB930_1
  LD A,$01
  LD ($DB7D),A
  JP LB930_2
LB930_1:
  XOR A
  LD ($DB7D),A
LB930_2:
  LD A,$96
  LD ($DC59),A
  CALL LB2D0              ; Delay
  JP L9DDD_1

; Display Health
;
; Used by the routine at L9DDD.
LB96B:
  LD HL,$0016
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,($DB7A)           ; Get Health
  CALL LB97D_0
  LD A,$03
  RST $28                 ; rBR_CALL
  DEFW $4BF7              ; _DispOP1A - Rounds a floating-point number to the
                          ; current fix setting and display it at the current
                          ; pen location
  RET

; Routine??
;
; Used by the routine at LBC8B.
LB97D:
  LD ($86D7),DE           ; Set penRow/penCol
  ADD A,(HL)
  CALL LB97D_0
  LD A,$04
  RST $28                 ; rBR_CALL
  DEFW $4BF7              ; _DispOP1A - Rounds a floating-point number to the
                          ; current fix setting and display it at the current
                          ; pen location
  CALL L9FEA              ; Copy screen 9340/9872 to A28F/A58F
  RET
; This entry point is used by the routine at LB96B.
LB97D_0:
  RST $28                 ; rBR_CALL
  DEFW $4792              ; _SetXXXXOP2 - Load a floating-point value into an
                          ; OP register
  RST $28                 ; rBR_CALL
  DEFW $4156              ; _OP2ToOP1 - Transfer one OP register to another
  RET

; Decrease Health
;
; Used by the routines at LB00E and LB653.
LB994:
  LD A,($DB7A)
  SUB $02                 ; Health = Health minus 2
  CALL C,LB994_0
  LD ($DB7A),A
  RET
LB994_0:
  XOR A
  RET

; Player is dead, Health 0
;
; Used by the routine at L9DDD.
LB9A2:
  CALL L9FCF              ; Clear screen 9340/9872
  LD A,$19
  LD ($DCF3),A
  LD A,$07
  LD ($DCF4),A
  CALL LAB28              ; Show small message popup
  LD HL,$2C07
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E0BD             ; "The Desolate has claimed|your life too . . ."
  CALL LBEDE              ; Load archived string and show message char-by-char
  XOR A
  CALL LB9A2_1
  LD HL,($DBC3)
  INC HL
  LD ($DBC3),HL
LB9A2_0:
  CALL L9FEA              ; Copy screen 9340/9872 to A28F/A58F
  CALL LA0F1              ; Scan keyboard
  CP $37                  ; "MODE" key
  JP Z,L9DDD_0
  JR LB9A2_0
; This entry point is used by the routine at LBADE.
LB9A2_1:
  LD ($DB79),A
  LD ($DB75),A
  LD A,$06
  LD ($DB76),A            ; Set X coord = 6
  LD A,$18
  LD ($DB77),A
  LD A,$03
  LD ($DB78),A
  LD A,$64                ; Health = 100
  LD ($DB7A),A
  RET

; Decode the room
;
; Used by the routines at LAB28, LADF5 and LBB7E.
;
; HL Decode from
; BC Decode to
LB9F1:
  LD A,(HL)
  CP $FF
  JR Z,LB9F1_1
  LDI
LB9F1_0:
  RET PO
  JR LB9F1
LB9F1_1:
  INC HL
  LD A,(HL)
  INC HL
  INC HL
LB9F1_2:
  DEC HL
  DEC A
  LDI
  JR NZ,LB9F1_2
  JR LB9F1_0

; Show titles and show Menu
;
; Used by the routine at L9DBE.
LBA07:
  LD A,$44
  LD ($DC59),A
  LD ($DC85),A
  LD HL,$1D0F
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E09D             ; "MaxCoderz Presents"
  CALL LBEDE              ; Load archived string and show message char-by-char
  CALL LBA81
  CALL LBC7D              ; Clear screen 9340/9872 and copy to A28F/A58F
  CALL LBB7E_10
  LD HL,$1D17
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E09F             ; "a tr1p1ea game"
  CALL LBEDE              ; Load archived string and show message char-by-char
  CALL LBA81
  CALL LBC7D              ; Clear screen 9340/9872 and copy to A28F/A58F
  CALL LBB7E_10
  XOR A
  LD ($DC85),A

; Return to Menu
;
; Used by the routines at L9DDD, LBA93, LBB7E and LBF6F.
LBA3D:
  LD A,($DC55)
  INC A
  CP $08
  CALL Z,LBB7E_9
  LD ($DC55),A
  DI
  LD HL,$F515
  CALL LA88F              ; Display 96 tiles on the screen
  LD HL,$F4B5             ; Main menu screen
  EI
  CALL LB177              ; Display screen from tiles with Tileset #2
  LD C,$03
  LD IX,$F34F             ; Tile arrow right
  DI
  CALL LBA88
  LD C,$25
  LD IX,$F35F             ; Tile arrow left
  DI
  CALL LBA88
  CALL L9FEA              ; Copy screen 9340/9872 to A28F/A58F
  CALL LA0F1              ; Scan keyboard
  CP $36
  JP Z,LBA93
  CP $04                  ; Up key
  JP Z,LBB7E_5
  CP $01                  ; Down key
  JP Z,LBB7E_6
  JP LBA3D

; Routine??
;
; Used by the routines at LBA07 and LBADE.
LBA81:
  CALL LBB7E_10
  CALL LBB7E_10
  RET

; Draw menu item selection triangles
;
; Used by the routine at LBA3D.
LBA88:
  LD A,($DB8F)
  LD L,A
  LD A,C
  LD B,$08
  CALL L9E5F
  RET

; Menu item selected
;
; Used by the routine at LBA3D.
LBA93:
  LD A,($DB8F)
  CP $1D
  JP Z,LBA93_0            ; New menu item
  CP $23
  JP Z,LBB7E_0            ; Continue menu item
  CP $29
  JP Z,LBB7E_7            ; Info menu item
  CP $2F
  JP Z,LBF64              ; Credits menu item
  CP $35
  JP Z,L9E51              ; Quit menu item
  JP LBA3D
; New menu item selected
LBA93_0:
  LD A,($DB73)
  OR A
  JP Z,LBADE
  CALL LB925
  CALL LAB28              ; Show small message popup
  LD HL,$2C07
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E0A3             ; "OverWrite Current Game?|Alpha = Yes :: Clear = No"
  CALL LBEDE              ; Load archived string and show message char-by-char
  CALL L9FEA              ; Copy screen 9340/9872 to A28F/A58F
LBA93_1:
  CALL LA0F1              ; Scan keyboard
  CP $0F
  JP Z,LBA3D
  CP $30
  JP Z,LBADE
  JP LBA93_1

; New Game
;
; Used by the routine at LBA93.
LBADE:
  XOR A
  LD ($DCF7),A            ; Weapon slot
  LD ($DB7D),A            ; Set look/shoot switch value = look
  LD ($DBC7),A
  CALL LB9A2_1
  LD HL,$0000
  LD ($DBC3),HL
  LD ($DBC5),HL
  LD HL,$DB9C
  LD B,$22
LBADE_0:
  LD (HL),$00
  INC HL
  DJNZ LBADE_0
  LD HL,$DC5B
  LD B,$22
LBADE_1:
  LD (HL),$00
  INC HL
  DJNZ LBADE_1
  LD HL,$DB90
  LD B,$09
LBADE_2:
  LD (HL),$00
  INC HL
  DJNZ LBADE_2
  LD HL,$DCA2
  LD B,$48
LBADE_3:
  LD (HL),$00
  INC HL
  DJNZ LBADE_3
  LD HL,$DC96
  CALL LBC6B
  LD HL,$DC9A
  CALL LBC6B
  LD HL,$DC9E
  CALL LBC6B
  CALL LBC7D              ; Clear screen 9340/9872 and copy to A28F/A58F
  LD A,$44
  LD ($DC59),A
  LD ($DC85),A
  LD A,$07
  LD ($DCF4),A
  XOR A
  LD ($DCF3),A
  LD HL,$1D0A
  LD ($86D7),HL
  LD HL,$E115             ; "In the Distant Future . . ."
  CALL LBEDE              ; Load archived string and show message char-by-char
  CALL LBA81
  CALL LBC7D              ; Clear screen 9340/9872 and copy to A28F/A58F
  CALL LBA81
  CALL LBC84              ; Set zero penRow/penCol
  LD HL,$E117             ; "'The Desolate' Space Cruiser|leaves orbit. ..."
  CALL LBEDE              ; Load archived string and show message char-by-char
  LD HL,$395B
  LD ($86D7),HL
  LD HL,$E0B9             ; String with arrow down sign
  CALL LBEDE              ; Load archived string and show message char-by-char
  CALL LAD99              ; Wait for Down key
  CALL L9FCF              ; Clear screen 9340/9872
  CALL LBC84              ; Set zero penRow/penCol
  LD HL,$E119             ; "The ship sustains heavy|damage. ..."
  CALL LBEDE              ; Load archived string and show message char-by-char
  CALL LADA1              ; Wait for MODE key

; Game start
LBB7E:
  XOR A
  LD ($DC85),A
; Continue menu item selected
LBB7E_0:
  LD A,$01
  LD ($DB73),A
  LD A,$FF
  LD ($DC59),A
  CALL LB2D0              ; Delay
  JP L9DDD
LBB7E_1:
  LD A,($DB73)
  OR A
  JP NZ,LBB7E_2
  LD A,($DB8F)
  ADD A,$F4
  LD ($DB8F),A
  JP LBA3D
; Menu up step
LBB7E_2:
  LD A,($DB8F)
  ADD A,$FA
  LD ($DB8F),A
  JP LBA3D
LBB7E_3:
  LD A,($DB73)
  OR A
  JP NZ,LBB7E_4
  LD A,($DB8F)
  ADD A,$0C
  LD ($DB8F),A
  JP LBA3D
; Menu down step
LBB7E_4:
  LD A,($DB8F)
  ADD A,$06
  LD ($DB8F),A
  JP LBA3D
; Menu up key pressed
LBB7E_5:
  LD A,($DB8F)
  CP $1D
  JP Z,LBA3D
  CP $29
  JP Z,LBB7E_1
  JP LBB7E_2
; Menu down key pressed
LBB7E_6:
  LD A,($DB8F)
  CP $35
  JP Z,LBA3D
  CP $1D
  JP Z,LBB7E_3
  JP LBB7E_4
; Info menu item, show Controls
LBB7E_7:
  LD BC,$0060             ; Counter = 96 bytes or tiles
  LD HL,$F329             ; Decode from - Encoded screen for Inventory popup
  LD DE,$DBF5             ; Where to decode
  CALL LB9F1              ; Decode the room
  LD HL,$DBF5
  CALL LB177              ; Display screen from tiles with Tileset #2
  LD A,$05
  LD ($DCF3),A
  LD A,$07
  LD ($DCF4),A
  LD HL,$0C1E
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E0A5             ; "- Controls -"
  CALL LBEDE              ; Load archived string and show message char-by-char
  LD HL,$1505
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E0A7             ; "2nd = Look / Shoot|Alpha = Inventory ..."
  CALL LBEDE              ; Load archived string and show message char-by-char
  CALL L9FEA              ; Copy screen 9340/9872 to A28F/A58F
  CALL LADA1              ; Wait for MODE key
  JP LBA3D                ; Return to Menu
; This entry point is used by the routine at LA88F.
LBB7E_8:
  LD A,($DC55)
  ADD A,L
  LD L,A
  RET
; This entry point is used by the routine at LBA3D.
LBB7E_9:
  XOR A
  LD ($DC55),A
  RET
; This entry point is used by the routines at LBA07, LBA81 and LBC8B.
LBB7E_10:
  LD B,$14
LBB7E_11:
  CALL LB2D0              ; Delay
  DJNZ LBB7E_11
  RET

; Routine??
;
; Used by the routine at LB33F.
;
; HL ??
LBC3C:
  LD DE,$281C
  LD ($86D7),DE
  LD B,$04
LBC3C_0:
  PUSH BC
  PUSH HL
  LD A,(HL)
  CP $24
  JR Z,LBC3C_2
  SUB $1A
  RST $28                 ; rBR_CALL
  DEFW $478C
  LD A,$01
  RST $28                 ; rBR_CALL
  DEFW $4BF7              ; _DispOP1A - Rounds a floating-point number to the
                          ; current fix setting and display it at the current
                          ; pen location
  LD A,($86D7)
  DEC A
  DEC A
  LD ($86D7),A
LBC3C_1:
  POP HL
  INC HL
  POP BC
  DJNZ LBC3C_0
  RET
LBC3C_2:
  LD A,$2D
  RST $28                 ; rBR_CALL
  DEFW $455E              ; _VPutMap - Displays either a small variable width
                          ; or large 5x7 character at the current pen location
                          ; and updates penCol.
  JR LBC3C_1

; Routine??
;
; Used by the routine at LBADE.
LBC6B:
  LD B,$04
LBC6B_0:
  PUSH BC
  PUSH HL
  LD B,$0B
  CALL $4086
  ADD A,$1A
  POP HL
  LD (HL),A
  INC HL
  POP BC
  DJNZ LBC6B_0
  RET

; Clear screen 9340/9872 and copy to A28F/A58F
;
; Used by the routines at LBA07 and LBADE.
LBC7D:
  CALL L9FCF              ; Clear screen 9340/9872
  CALL L9FEA              ; Copy screen 9340/9872 to A28F/A58F
  RET

; Set zero penRow/penCol
;
; Used by the routine at LBADE.
LBC84:
  LD HL,$0000
  LD ($86D7),HL           ; Set penRow/penCol
  RET

; ??
;
; Used by the routine at LAAAF.
LBC8B:
  CALL LAE09
  LD DE,$0011
  ADD HL,DE
  LD A,(HL)
  LD C,A
  LD A,($DB75)
  SUB C
  JP NZ,LAAAF_1
  CALL LAB28              ; Show small message popup
  LD A,$05
  LD ($DCF3),A
  LD A,$07
  LD ($DCF4),A
  CALL LAE09
  LD DE,$0013
  ADD HL,DE
  LD A,(HL)
  LD ($DC87),A
  LD E,A
  LD D,$00
  LD HL,$DB90
  ADD HL,DE
  LD A,(HL)
  OR A
  JP Z,LBC8B_2
  CALL LBC8B_10
  LD HL,$E12D             ; " It doesnt look like you| can do anything else
                          ; here"
LBC8B_0:
  CALL LBEDE              ; Load archived string and show message char-by-char
  CALL L9FEA              ; Copy screen 9340/9872 to A28F/A58F
LBC8B_1:
  CALL LA0F1              ; Scan keyboard
  CP $37
  JR NZ,LBC8B_1
  JP L9DDD_1
LBC8B_2:
  LD A,($DC87)
  CP $01
  JP Z,LBC8B_3
  CP $02
  JP Z,LBC8B_4
  CP $04
  JP Z,LBC8B_7
  CP $05
  JP Z,LBC8B_8
  CP $06
  JP Z,LBC8B_9
  CP $07
  JP Z,LBC8B_11
LBC8B_3:
  CALL LBC8B_10
  LD HL,$E12F
  JP LBC8B_0
LBC8B_4:
  LD HL,$DB90
  INC HL
  LD A,(HL)
  OR A
  JP NZ,LBC8B_5
  CALL LBC8B_10
  LD HL,$E131
  JP LBC8B_0
LBC8B_5:
  CALL LAE09
  LD DE,$0030
  ADD HL,DE
  LD A,(HL)
  LD ($DC89),A
  CALL LBC8B_10
  LD HL,$E133
  CALL LBEDE              ; Load archived string and show message char-by-char
  CALL L9FEA              ; Copy screen 9340/9872 to A28F/A58F
  CALL LAB28              ; Show small message popup
LBC8B_6:
  CALL LA0F1              ; Scan keyboard
  CP $01
  JR NZ,LBC8B_6
  LD HL,$DB90
  INC HL
  INC HL
  LD (HL),$01
  LD A,($DC89)
  LD H,$00
  LD L,A
  LD DE,$DB9C
  ADD HL,DE
  LD (HL),$01
  CALL LBC8B_10
  LD HL,$E135
  JP LBC8B_0
LBC8B_7:
  CALL LBC8B_10
  LD HL,$E13F
  JP LBC8B_0
LBC8B_8:
  CALL LBC8B_10
  LD HL,$E141
  JP LBC8B_0
LBC8B_9:
  CALL LBC8B_10
  LD HL,$E143
  JP LBC8B_0
LBC8B_10:
  LD HL,$2C05
  LD ($86D7),HL           ; Set penRow/penCol
  RET
LBC8B_11:
  LD DE,$0006
  LD HL,$DB90
  ADD HL,DE
  LD A,(HL)
  OR A
  JP NZ,LBC8B_12
  CALL LBC8B_10
  LD HL,$E145
  JP LBC8B_0
LBC8B_12:
  LD A,$44
  LD ($DC59),A
  LD ($DC85),A
  XOR A
  LD ($DCF3),A
  LD ($DBF4),A
  LD A,$07
  LD ($DCF4),A
  CALL L9FCF              ; Clear screen 9340/9872
  LD HL,$0000
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E11B
  CALL LBEDE              ; Load archived string and show message char-by-char
  CALL LADA1
  LD A,$06
  LD ($DCF3),A
  CALL L9FCF              ; Clear screen 9340/9872
  LD HL,$0606
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E0A1
  CALL LBEDE              ; Load archived string and show message char-by-char
  CALL LBB7E_10
  LD DE,$0646
  LD A,($DBC7)
  LD L,A
  LD H,$00
  CALL LB97D
  CALL LBB7E_10
  LD DE,$0D46
  LD HL,($DBC5)
  CALL LB97D
  CALL LBB7E_10
  LD DE,$1446
  LD HL,($DBC3)
  CALL LB97D
  CALL LBB7E_10
  LD A,($DBC7)
  SUB $14
  JP C,LBC8B_13
  LD HL,$2906
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E0AD
  CALL LBEDE              ; Load archived string and show message char-by-char
  LD A,($DBF4)
  INC A
  LD ($DBF4),A
  JR LBC8B_14
LBC8B_13:
  LD HL,$2906
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E0AB
  CALL LBEDE              ; Load archived string and show message char-by-char
LBC8B_14:
  LD DE,$0032
  LD HL,($DBC5)
  RST $28                 ; rBR_CALL
  DEFW $400C
  JR C,LBC8B_15
  LD HL,$3006
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E0B1
  CALL LBEDE              ; Load archived string and show message char-by-char
  LD A,($DBF4)
  INC A
  LD ($DBF4),A
  JR LBC8B_16
LBC8B_15:
  LD HL,$3006
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E0AF
  CALL LBEDE              ; Load archived string and show message char-by-char
LBC8B_16:
  LD DE,$0000
  LD HL,($DBC3)
  RST $28                 ; rBR_CALL
  DEFW $400C
  JR NZ,LBC8B_17
  LD HL,$3706
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E0B5
  CALL LBEDE              ; Load archived string and show message char-by-char
  LD A,($DBF4)
  INC A
  LD ($DBF4),A
  JR LBC8B_18
LBC8B_17:
  LD HL,$3706
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E0B3             ; "Over & Over Again" (achievement)
  CALL LBEDE              ; Load archived string and show message char-by-char
LBC8B_18:
  CALL LADA1
  CALL L9FCF              ; Clear screen 9340/9872
  LD A,($DBF4)
  CP $03
  JR NZ,LBC8B_19
  XOR A
  LD ($DCF3),A
  LD HL,$0000
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E11D             ; "System Alert triggered: ..."
  CALL LBEDE              ; Load archived string and show message char-by-char
  JP LBC8B_20
LBC8B_19:
  LD A,$0F
  LD ($DCF3),A
  LD HL,$1A0C
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E0A9             ; "Earn 3 Good Awards for|an Extended Ending!"
  CALL LBEDE              ; Load archived string and show message char-by-char
LBC8B_20:
  CALL LADA1
  CALL L9FCF              ; Clear screen 9340/9872
  LD HL,$1D23
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E11F             ; "The End"
  CALL LBEDE              ; Load archived string and show message char-by-char
  CALL LBB7E_10
  JP LBF6F                ; The End
; This entry point is used by the routine at L9DBE.
LBC8B_21:
  LD HL,$0000
  LD ($DBD4),HL
  LD HL,$DBCB
  RST $28                 ; rBR_CALL
  DEFW $417A
  RST $28                 ; rBR_CALL
  DEFW $42F1
  JP C,L9E34              ; DataFile 'DESDATA' Not Found
  LD A,B
  OR A
  JP Z,L9E34              ; DataFile 'DESDATA' Not Found
  LD A,B
  LD ($DBC8),A
  LD HL,$0013
  ADD HL,DE
  LD ($DBD4),HL
  CALL LBF31
  LD ($DBC9),HL
  JP L9DBE_0

; Load archived string and show message char-by-char
;
; Used by the routines at LAB28, LAC54, LAD00, LAD4F, LADA9, LAE09, LB0A2,
; LB177, LB33F, LB513, LB930, LB9A2, LBA07, LBA93, LBADE, LBB7E, LBC8B and
; LBF6F.
;
; HL Address of archived string offset
LBEDE:
  LD A,($DBC8)
  LD B,A
  LD A,(HL)
  INC HL
  LD H,(HL)
  LD L,A
  LD DE,($DBC9)
  ADD HL,DE
  BIT 7,H
  JR Z,LBEDE_0
  LD DE,$7FFF
  SBC HL,DE
  LD DE,$3FFF
  ADD HL,DE
  INC B
LBEDE_0:
  CALL LBF47
  EI
  LD A,C
  OR A
  RET Z
  CP $7C
  JP Z,LBEDE_1
  RST $28                 ; rBR_CALL
  DEFW $455E              ; _VPutMap - Displays either a small variable width
                          ; or large 5x7 character at the current pen location
                          ; and updates penCol.
  RET C
  LD A,($DC85)
  OR A
  JR Z,LBEDE_0
  PUSH HL
  PUSH BC
  CALL LB2D0              ; Delay
  CALL L9FEA              ; Copy screen 9340/9872 to A28F/A58F
  POP BC
  POP HL
  JR LBEDE_0
LBEDE_1:
  PUSH BC
  LD A,($86D8)
  LD C,A
  LD A,($DCF4)
  ADD A,C
  LD ($86D8),A
  LD A,($DCF3)
  LD ($86D7),A
  POP BC
  JP LBEDE_0

; Routine??
;
; Used by the routine at LBC8B.
LBF31:
  BIT 7,H
  JR NZ,LBF31_0
  RET
LBF31_0:
  LD DE,$7FFF
  SBC HL,DE
  LD DE,$3FFF
  ADD HL,DE
  LD A,($DBC8)
  INC A
  LD ($DBC8),A
  RET

; Routine?? Load from Archive
;
; Used by the routine at LBEDE.
LBF47:
  RST $28                 ; rBR_CALL
  DEFW $501D              ; _LoadCIndPaged - Copies a byte from the archive to
                          ; C
  INC HL
  BIT 7,H
  RET Z
  INC B
  RES 7,H
  SET 6,H
  RET

; Set variables for Credits
;
; Used by the routines at LBF64 and LBF6F.
LBF54:
  XOR A
  LD ($DD57),A
  LD ($DD56),A
  LD ($DC85),A
  LD A,$96
  LD ($DC59),A
  RET

; Credits menu item selected
;
; Used by the routine at LBA93.
LBF64:
  CALL L9FCF              ; Clear screen 9340/9872
  CALL L9FEA              ; Copy screen 9340/9872 to A28F/A58F
  CALL LBF54
  JR LBF6F_0

; The End
;
; Used by the routine at LBC8B.
LBF6F:
  CALL L9FCF              ; Clear screen 9340/9872
  CALL LBF54
  LD HL,$1723
  LD ($86D7),HL           ; Set penRow/penCol
  LD HL,$E11F             ; "The End"
  CALL LBEDE              ; Load archived string and show message char-by-char
; Credits screen text scrolls up
LBF6F_0:
  LD A,$39
  LD ($86D8),A
LBF6F_1:
  JP LBF6F_4
LBF6F_2:
  CALL LB2D0              ; Delay
LBF6F_3:
  CALL LA0F1              ; Scan keyboard
  CP $37
  JP Z,LBA3D              ; Return to main Menu
  CALL LBF6F_5
  CALL LBF6F_6
  JR LBF6F_1
LBF6F_4:
  LD A,($DD56)
  INC A
  LD ($DD56),A
  CP $06
  JP NZ,LBF6F_2
  XOR A
  LD ($DD56),A
  LD A,($DD57)
  LD E,A
  LD D,$00
  LD HL,$DDF2
  ADD HL,DE
  LD A,(HL)
  LD ($86D7),A
  LD A,($DD57)
  LD HL,$DD58
  CALL LADFF
  CALL LBEDE              ; Load archived string and show message char-by-char
  LD A,($DD57)
  INC A
  LD ($DD57),A
  CP $47
  JP NZ,LBF6F_3
  JP LBA3D                ; Return to main Menu
LBF6F_5:
  LD DE,LA28F
  LD HL,$A29B
  LD BC,$02F4
  LDIR
  LD DE,$9340
  LD HL,$934C
  LD BC,$02F4
  LDIR
  RET
LBF6F_6:
  LD DE,$A2D7
  LD HL,$9340
  LD BC,$02B8
  LDIR
  RET

