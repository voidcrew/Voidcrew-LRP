/obj/item/ship_parts
	name = "ship parts"
	icon = 'icons/obj/toy.dmi'
	desc = "Ship parts, use them in hand to redeem them. Used for building ships."
	icon_state = "ship"
	///The type of ship this is (ex: '/datum/ship_parts/neutral')
	var/datum/ship_parts/ship_type

/obj/item/ship_parts/Initialize()
	. = ..()
	name = initial(ship_type.name)

/obj/item/ship_parts/attack_self(mob/user)
	. = ..()
	if(!ship_type)
		CRASH("[src] used by a player without a ship_type!")
	user.client.prefs.ships_owned[ship_type]++
	user.client.prefs.save_ships()
	to_chat(user, "You have redeemed [src], you may redeem it to purchase future ships.")
	qdel(src)

/obj/item/ship_parts/neutral
	ship_type = /datum/ship_parts/neutral
	color = COLOR_BEIGE

/obj/item/ship_parts/neutral/medium
	ship_type = /datum/ship_parts/neutral/medium

/obj/item/ship_parts/neutral/high
	ship_type = /datum/ship_parts/neutral/high

/obj/item/ship_parts/nanotrasen
	ship_type = /datum/ship_parts/nanotrasen
	color = COLOR_BLUE_LIGHT

/obj/item/ship_parts/syndicate
	ship_type = /datum/ship_parts/syndicate
	color = COLOR_RED_LIGHT
