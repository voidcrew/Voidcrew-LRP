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
	options += "Check Crew Status"
	options += "Register All Humans Aboard the Ship into the Crewlist"
	options += "Unregister ALL Crewmembers"
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

		if("Check Crew Status")
			var/result = current_ship.is_active_crew()
			switch(result)
				if(SHUTTLE_INACTIVE_CREW)
					to_chat(user, "The crew is all dead!")
				if(SHUTTLE_SSD_CREW)
					to_chat(user, "The remaining crew members are SSD!")
				if(SHUTTLE_ACTIVE_CREW)
					to_chat(user, "At least one crewmember is alive and not SSD!")

		if("Register All Humans Aboard the Ship into the Crewlist")
			current_ship.register_all_crewmembers()
			message_admins("\[SHUTTLE]: [key_name_admin(user)] has added all humans aboard [name] into the crewlist.")

		if("Unregister ALL Crewmembers")
			current_ship.unregister_all_crewmembers()
			message_admins("\[SHUTTLE]: [key_name_admin(user)] has unregistered all crewmembers from [name].")

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
