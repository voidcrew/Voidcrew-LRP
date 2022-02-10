/datum/admins/proc/open_shuttlepanel()
	set category = "Admin.Events"
	set name = "Shuttle Manipulator"
	set desc = "Opens the shuttle manipulator UI."

	if(!check_rights(R_DEBUG))
		return

	SSshuttle.ui_interact(usr)


/obj/docking_port/mobile/proc/admin_fly_shuttle(mob/user)
	var/list/options = list()

	for(var/port in SSshuttle.stationary)
		if (istype(port, /obj/docking_port/stationary/transit))
			continue  // please don't do this
		var/obj/docking_port/stationary/S = port
		if (canDock(S) == SHUTTLE_CAN_DOCK)
			options[S.name] = S

	options += "--------"
	options += "Infinite Transit"
	options += "Delete Shuttle"
	options += "Into The Sunset (delete & greentext 'escape')"
	options += "Cancel Queued Deletion"

	var/selection = input(user, "Select where to fly [name]:", "Fly Shuttle") as null|anything in options
	if(!selection)
		return

	switch(selection)
		if("Infinite Transit")
			destination = null
			mode = SHUTTLE_IGNITING
			message_admins("\[SHUTTLE]: [key_name_admin(user)] has placed [name] into Infinite Transit.")
			log_admin("\[SHUTTLE]: [key_name_admin(user)] has placed [name] into Infinite Transit.")
			setTimer(ignitionTime)

		if("Delete Shuttle")
			if(alert(user, "Really delete [name]?", "Delete Shuttle", "Cancel", "Really!") != "Really!")
				return
			message_admins("\[SHUTTLE]: [key_name_admin(user)] has deleted [name].")
			log_admin("\[SHUTTLE]: [key_name_admin(user)] has deleted [name].")
			jumpToNullSpace()

		if("Into The Sunset (delete & greentext 'escape')")
			if(alert(user, "Really delete [name] and greentext escape objectives?", "Delete Shuttle", "Cancel", "Really!") != "Really!")
				return
			message_admins("\[SHUTTLE]: [key_name_admin(user)] has deleted [name], and granted the crew greentext.")
			log_admin("\[SHUTTLE]: [key_name_admin(user)] has deleted [name], and granted the crew greentext.")
			intoTheSunset()
		if("Cancel Queued Deletion")
			if (isnull(current_ship.deletion_timer))
				to_chat(user, "<span class='notice'>Ship not queued for deletion!</span>")
				return
			deltimer(current_ship.deletion_timer)
			current_ship.deletion_timer = null
			message_admins("\[SHUTTLE]: [key_name_admin(user)] has cancelled the deletion of [name]!")
			log_admin("\[SHUTTLE]: [key_name_admin(user)] has cancelled the deletion of [name]!")


		else
			if(options[selection])
				request(options[selection])
