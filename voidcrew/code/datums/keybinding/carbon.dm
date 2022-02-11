/datum/keybinding/carbon/remove_ship_part
	hotkey_keys = list("V")
	name = "takeshippart"
	full_name = "Take ship part"
	description = "Remove ship parts from your preferences."
	keybind_signal = COMSIG_KB_CARBON_TAKESHIPPART

/datum/keybinding/carbon/remove_ship_part/down(client/user)
	. = ..()
	if(.)
		return
	var/mob/living/carbon/carbon_user = user.mob
	var/list/owned_ships = user.get_ships()
	if(!length(owned_ships))
		return
	user.list_ship_parts()
	var/ship_response = tgui_input_list(carbon_user, "Select a ship part to take out.", "Ship construction", owned_ships)
	if(!ship_response || !owned_ships[ship_response])
		return
	var/datum/ship_parts/removed_parts = owned_ships[ship_response]
//	var/datum/ship_parts/new_part = new removed_parts
	user.prefs.ships_owned[removed_parts]--
//	var/obj/item/ship_parts/new_parts = new initial(removed_part.part_type.type)
//	carbon_user.put_in_hand(new_parts)
	to_chat(carbon_user, "[removed_parts] selected.")
	return TRUE
