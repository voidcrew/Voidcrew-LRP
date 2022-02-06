/obj/item/oil_cleanser
	name = "\improper oil cleanser"
	desc = "Sometimes those IPCs need an oil change."

	// fuck you im not spriting
	icon = 'icons/obj/syringe.dmi'
	icon_state = "maintenance"
	item_state = "medipen"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'

	item_flags = SURGICAL_TOOL
	force = 3
	w_class = WEIGHT_CLASS_TINY
	throwforce = 5
	throw_speed = 3
	throw_range = 5

	tool_behaviour = TOOL_OIL_CLEANSER
	toolspeed = 1

	custom_materials = list(/datum/material/iron = 2000, /datum/material/glass = 2000)
	attack_verb = list("attacked", "poked", "slapped", "oiled")
