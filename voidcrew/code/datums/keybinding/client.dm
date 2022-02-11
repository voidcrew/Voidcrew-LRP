/datum/keybinding/carbon/remove_ship_part
	hotkey_keys = list("V")
	name = "admin_help"
	full_name = "Admin Help"
	description = "Ask an admin for help."
	keybind_signal = COMSIG_KB_CLIENT_GETHELP_DOWN

/datum/keybinding/carbon/remove_ship_part/down(client/user)
	. = ..()
	if(.)
		return
	var/all_ships = user.list_ship_parts()
	if(!all_ships)
		to_chat(user, "You do not have any ships.")
		return TRUE
	return TRUE
