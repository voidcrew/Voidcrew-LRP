//Just some alt-uniforms themed around Star Trek - Pls don't sue, Mr Roddenberry ;_;


/obj/item/clothing/under/trek
	can_adjust = FALSE
	icon = 'icons/obj/clothing/under/trek.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/trek.dmi'
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 15, "rad" = 15, "fire" = 40, "acid" = 40) // It's star trek, it deserves to be a bit better then your average jumpsuit
	strip_delay = 50


//TOS
/obj/item/clothing/under/trek/command
	name = "command uniform"
	desc = "The uniform worn by command officers."
	icon_state = "trek_command"
	item_state = "y_suit"
	armor = list("melee" = 10, "bullet" = 5, "laser" = 5,"energy" = 5, "bomb" = 10, "bio" = 15, "rad" = 15, "fire" = 75, "acid" = 50)


/obj/item/clothing/under/trek/engsec
	name = "engsec uniform"
	desc = "The uniform worn by engineering/security officers."
	icon_state = "trek_engsec"
	item_state = "r_suit"

/obj/item/clothing/under/trek/medsci
	name = "medsci uniform"
	desc = "The uniform worn by medical/science officers."
	icon_state = "trek_medsci"
	item_state = "b_suit"


//TNG
/obj/item/clothing/under/trek/command/next
	icon_state = "trek_next_command"
	item_state = "r_suit"

/obj/item/clothing/under/trek/engsec/next
	icon_state = "trek_next_engsec"
	item_state = "y_suit"

/obj/item/clothing/under/trek/medsci/next
	icon_state = "trek_next_medsci"


//ENT
/obj/item/clothing/under/trek/command/ent
	icon_state = "trek_ent_command"
	item_state = "bl_suit"

/obj/item/clothing/under/trek/engsec/ent
	icon_state = "trek_ent_engsec"
	item_state = "bl_suit"

/obj/item/clothing/under/trek/medsci/ent
	icon_state = "trek_ent_medsci"
	item_state = "bl_suit"


//Q
/obj/item/clothing/under/trek/Q
	name = "french marshall's uniform"
	desc = "Something about it feels off..."
	icon_state = "trek_Q"
	item_state = "r_suit"
