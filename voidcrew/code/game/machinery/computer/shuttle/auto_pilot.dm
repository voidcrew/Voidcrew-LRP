/obj/machinery/computer/autopilot
	name = "auxiliary shuttle console"
	desc = "A control computer that extends the shuttle's functionality."
	icon_screen = "shuttle"
	icon_keyboard = "tech_key"
	light_color = LIGHT_COLOR_CYAN
	circuit = /obj/item/circuitboard/computer/autopilot
	/// ID of the ship to control
	var/ship_id
	///The currently selected overmap object destination of the attached shuttle
	var/obj/structure/overmap/destination
	var/obj/structure/overmap/ship/simulated/subvert_target
	///The linked overmap shuttle
	var/obj/structure/overmap/ship/simulated/ship
	var/list/list/tgui_view_state = list()
	var/obj/machinery/subverter/sub

/obj/machinery/computer/autopilot/Initialize()
	. = ..()
	tgui_view_state["consoleMode"] = "autopilot"

/obj/machinery/computer/autopilot/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	ship = port.current_ship

/obj/machinery/computer/autopilot/proc/reload_ship()
	var/obj/docking_port/mobile/port = SSshuttle.get_containing_shuttle(src)
	if(port?.current_ship)
		ship = port.current_ship
		return TRUE
/*
/obj/machinery/computer/autopilot/attackby(obj/item/O, mob/user, params)
	if(multitool_act(usr, O))
		var/obj/item/multitool/multi = O
		if(multi.buffer && istype(multi.buffer, /obj/machinery/subverter) && multi.buffer != src)
			var/obj/machinery/subverter/masheen = multi.buffer
			sub = masheen
			masheen.aux = src
			visible_message("Linked to [masheen]!")
			say("External device found! Subverter mode enabled.")
		else
			multi.buffer = src
			visible_message("Saved [src] to buffer.")
	else
		. = ..()
*/
/obj/machinery/computer/autopilot/multitool_act(mob/living/user, obj/item/item)
	. = ..()
	var/obj/item/multitool/multi = item
	if(multi.buffer && istype(multi.buffer, /obj/machinery/subverter) && multi.buffer != src)
		var/obj/machinery/subverter/masheen = multi.buffer
		sub = masheen
		masheen.aux = src
		visible_message("Linked to [masheen]!")
		say("External device found! Subverter mode enabled.")
	else
		multi.buffer = src
		visible_message("Saved [src] to buffer.")
	return TRUE

/obj/machinery/computer/autopilot/ui_interact(mob/user, datum/tgui/ui)
	if(ship.is_player_in_crew(user) || !isliving(user) || isAdminGhostAI(user))
		if(!ship && !reload_ship())
			return
		ui = SStgui.try_update_ui(user, src, ui)
		if(!ui)
			ui = new(user, src, "AuxConsole", name)
			ui.open()
	else
		say("ERROR: Unrecognized bio-signature detected")
		return
/obj/machinery/computer/autopilot/ui_data(mob/user)
	var/list/data = list()
	var/obj/docking_port/mobile/mobile = ship.shuttle

	data["view"] = tgui_view_state

	data["docked_location"] = mobile ? mobile.get_status_text_tgui() : "Unknown"
	data["locations"] = list()
	data["locked"] = FALSE
	data["authorization_required"] = FALSE
	data["timer_str"] = ship ? ship.get_eta() : "--:--"
	data["destination"] = destination
	if(!ship?.shuttle)
		data["status"] = "Missing"
		return data

	switch(ship.state)
		if(OVERMAP_SHIP_UNDOCKING)
			data["status"] = "Undocking"
			data["locked"] = TRUE
		if(OVERMAP_SHIP_DOCKING)
			data["status"] = "Docking"
			data["locked"] = TRUE
		if(OVERMAP_SHIP_IDLE)
			data["status"] = "Idle"
		else
			if(ship.current_autopilot_target)
				data["status"] = "Flying | Autopilot active (Dest: [ship.current_autopilot_target])"
			else
				data["status"] = "Flying | Autopilot inactive"

	for(var/obj/structure/overmap/object in view(ship.sensor_range, get_turf(ship)))
		if(object == ship.loc || istype(object, /obj/structure/overmap/event) || object == ship)
			continue
		var/list/location_data = list(
			id = REF(object),
			name = object.name
		)
		data["locations"] += list(location_data)
	if(length(data["locations"]) == 1)
		for(var/location in data["locations"])
			destination = location["id"]
			data["destination"] = destination
	else if(!length(data["locations"]))
		data["locked"] = TRUE
		data["status"] = "Locked"
	/*
		Subverter ui data
	*/

	data["subverter"] = sub
	if (!sub)
		data["locked_b"] = TRUE
		data["status_b"] = "No interdictor connected"
		data["selected_target"] = null
		return data
	data["ships"] = list()
	data["locked_b"] = FALSE
	data["recharge_time_str"] = (!COOLDOWN_FINISHED(sub, subverter_cooldown)) && sub ? sub.get_recharge_str() : "--:--"
	data["selected_target"] = subvert_target
	data["status_b"] = "Ready"
	if(!ship?.shuttle)
		data["status_b"] = "Missing"
		return data

	switch(ship.state)
		if(OVERMAP_SHIP_UNDOCKING)
			data["locked_b"] = TRUE
		if(OVERMAP_SHIP_DOCKING)
			data["locked_b"] = TRUE

	for(var/obj/structure/overmap/ship/simulated/flying_ship in view(ship.sensor_range, get_turf(ship)))
		if(flying_ship == ship)
			continue
		var/list/location_data = list(
			id = REF(flying_ship),
			name = flying_ship.name
		)
		data["ships"] += list(location_data)
	if(length(data["ships"]) == 1)
		for(var/location in data["ships"])
			subvert_target = location["id"]
			data["selected_target"] = subvert_target
	else if(!length(data["ships"]))
		data["locked_b"] = TRUE
		data["status_b"] = "No Ships in Range"
	if(!COOLDOWN_FINISHED(sub, subverter_cooldown))
		data["locked_b"] = TRUE
		data["status_b"] = "Recharging"
	return data

/obj/machinery/computer/autopilot/ui_act(action, params)
	. = ..()
	if(.)
		return
	if(!allowed(usr))
		to_chat(usr, "<span class='danger'>Access denied.</span>")
		return

	switch(action)
		if("move")
			ship.current_autopilot_target = locate(params["shuttle_id"])
			if(!isturf(ship.loc))
				ship.undock()
			ship.tick_autopilot()
			return TRUE
		if("set_destination")
			var/target_destination = params["destination"]
			if(target_destination)
				destination = target_destination
				return TRUE
		if("subvert")
			var/obj/structure/overmap/ship/simulated/target_ship = locate(params["shuttle_id"])
			if (sub.attempt_to_subvert(target_ship))
				return TRUE
		if("set_subvert_target")
			var/sub_tar = params["selected_target"]
			if (sub_tar)
				subvert_target = sub_tar
				return TRUE
		if("set_view")
			for (var/key in params)
				if(key == "src")
					continue
				tgui_view_state[key] = params[key]
			return TRUE
