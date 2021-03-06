CIRCLE_TILE_ID EQU $70

DisplayDiploma::
	call SaveScreenTilesToBuffer2
	call GBPalWhiteOutWithDelay3
	call ClearScreen
	xor a
	ld [wUpdateSpritesEnabled], a
	ld hl, wd730
	set 6, [hl]
	call DisableLCD
	ld hl, CircleTile
	ld de, vChars2 tile CIRCLE_TILE_ID
	ld bc, $10
	ld a, BANK(CircleTile)
	call FarCopyData2
	hlcoord 0, 0
	lb bc, 16, 18
	predef Diploma_TextBoxBorder
	ld hl, DiplomaTextPointersAndCoords
	ld c, $5
.asm_56715
	push bc
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	push hl
	ld h, [hl]
	ld l, a
	call PlaceString
	pop hl
	inc hl
	pop bc
	dec c
	jr nz, .asm_56715
IF DEF(_ENGLISH)
	hlcoord 10, 4
ENDC
IF DEF(_GERMAN)
	hlcoord 9, 6
ENDC
	ld de, wPlayerName
	call PlaceString
	farcall DrawPlayerCharacter

; Move the player 33 pixels right and set the priority bit so he appears
; behind the background layer.
	ld hl, wOAMBuffer + $01
	lb bc, $80, $28
.adjustPlayerGfxLoop
	ld a, [hl] ; X
	add 33
	ld [hli], a
	inc hl
	ld a, b
	ld [hli], a ; attributes
	inc hl
	dec c
	jr nz, .adjustPlayerGfxLoop

	call EnableLCD
	farcall LoadTrainerInfoTextBoxTiles
	ld b, SET_PAL_GENERIC
	call RunPaletteCommand
	call Delay3
	call GBPalNormal
	ld a, $90
	ldh [rOBP0], a
	call WaitForTextScrollButtonPress
	ld hl, wd730
	res 6, [hl]
	call GBPalWhiteOutWithDelay3
	call RestoreScreenTilesAndReloadTilePatterns
	call Delay3
	jp GBPalNormal

UnusedPlayerNameLengthFunc:
; Unused function that does a calculation involving the length of the player's
; name.
	ld hl, wPlayerName
	lb bc, $ff, $00
.loop
	ld a, [hli]
	cp "@"
	ret z
	dec c
	jr .loop

IF DEF(_ENGLISH)
DiplomaTextPointersAndCoords:
	dw DiplomaTitle
	dwcoord 5, 2
	dw DiplomaHeader1
	dwcoord 3, 4
	dw DiplomaHeader2
	dwcoord 15, 4
	dw DiplomaBody
	dwcoord 2, 6
	dw DiplomaGameFreak
	dwcoord 9, 16

DiplomaTitle:
	db CIRCLE_TILE_ID, "Diploma", CIRCLE_TILE_ID, "@"

DiplomaHeader1:
	db "Player@"

DiplomaHeader2:
	db "@"

DiplomaBody:
	db   "Congrats! This"
	next "diploma certifies"
	next "that you have"
	next "completed your"
	next "#DEX.@"

DiplomaGameFreak:
	db "GAME FREAK@"
ENDC

IF DEF(_GERMAN)
DiplomaTextPointersAndCoords:
	dw DiplomaTitle
	dwcoord 6, 2
	dw DiplomaHeader1
	dwcoord 2, 4
	dw DiplomaHeader2
	dwcoord 2, 6
	dw DiplomaBody
	dwcoord 2, 8
	dw DiplomaGameFreak
	dwcoord 9, 16

DiplomaTitle:
	db CIRCLE_TILE_ID, "Diplom", CIRCLE_TILE_ID, "@"

DiplomaHeader1:
	db "Herzlichen Glück-@"

DiplomaHeader2:	
	db "wunsch         !@"

DiplomaBody:	
	db   "Du hast es ge-"
	next "schafft, den"
	next "#DEX zu"
	next "vervollständigen@"

DiplomaGameFreak:	
	db "GAME FREAK@"
ENDC
