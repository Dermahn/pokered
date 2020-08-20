CeruleanPokecenter_Object:
	db $0 ; border block

	db 2 ; warps
	warp 3, 7, 2, LAST_MAP
	warp 4, 7, 2, LAST_MAP

	db 0 ; signs

	db 4 ; objects
	object SPRITE_NURSE, 3, 1, STAY, DOWN, 1 ; person
	object SPRITE_SUPER_NERD, 10, 5, WALK, ANY_DIR, 2 ; person
	object SPRITE_GENTLEMAN, 4, 3, STAY, DOWN, 3 ; person
	object SPRITE_LINK_RECEPTIONIST, 11, 2, STAY, DOWN, 4 ; person

	; warp-to
	warp_to 3, 7, CERULEAN_POKECENTER_WIDTH
	warp_to 4, 7, CERULEAN_POKECENTER_WIDTH
