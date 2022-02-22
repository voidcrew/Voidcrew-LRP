#define SUBVERTER_BARK_FAILURE 'sound/machines/buzz-two.ogg'
#define SUBVERTER_BARK_SUCCESS 'sound/machines/ping.ogg'

#define SUBVERTER_RECHARGE_TIME (2 MINUTES)
#define SUBVERTER_ENGINE_STALL_TIME (1 MINUTES)

#define SUBVERTER_SPICINESS 150

/obj/machinery/subverter
	name = "interdictor"
	desc = "A piece of equipment used to upload programs to other vessels. It has no interface: It could be linked to an auxillary console or the wires could be pulsed manually."
	icon = 'voidcrew/icons/obj/machines/space_hacking.dmi'
	icon_state = "subverter"
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 10
	active_power_usage = 1000
	circuit = /obj/item/circuitboard/machine/subverter
	layer = BELOW_OBJ_LAYER
	var/obj/structure/overmap/ship/simulated/ship
	var/obj/machinery/computer/autopilot/aux
	var/hacked = FALSE
	var/disabled = FALSE
	var/shocked = FALSE
	//TODO: keep track of which map the subverter is on
	var/subverter_cooldown = 0
	var/sub_recharge = SUBVERTER_RECHARGE_TIME
	var/sub_engine = SUBVERTER_ENGINE_STALL_TIME
	var/spiciness = SUBVERTER_SPICINESS

/obj/machinery/subverter/Initialize()
	. = ..()
	wires = new /datum/wires/subverter(src)
	update_stats()
	subverter_cooldown = world.time + sub_recharge

/obj/machinery/subverter/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	ship = port.current_ship

/obj/machinery/subverter/on_deconstruction()
	//unlink autopilot
	if (aux)
		aux.sub = null
		aux = null
	..()

/obj/machinery/subverter/proc/get_recharge_str()
	. = (subverter_cooldown - world.time) / 10
	. *= . > 0
	return "[add_leading(num2text((. / 60) % 60), 2, "0")]:[add_leading(num2text(. % 60), 2, "0")]"

/obj/machinery/subverter/proc/subvert_bark(message, soundin = SUBVERTER_BARK_FAILURE)
	if (aux)
		aux.say(message)
	playsound(loc, soundin, 90, 1, 0)

/*
	This handles the different contexts a subverter could bark in response to.
	There is also a single-line version of the logical operations in "can_subvert" (note that it excludes the antivirus check)

	antag - Set to true if you want to ignore factions entirely
*/
/obj/machinery/subverter/proc/bark_processing(obj/structure/overmap/ship/simulated/target_ship, antag = FALSE, bark_success_message = "Agent was successful! Bringing [target_ship.name] out of hyperspace.")
	. = FALSE
	if (!antag)
		if (target_ship.prefix == "NEU")
			subvert_bark("Cannot subvert NEU vessels!")
			return
		if (ship)
			if (ship.prefix == "NEU")
				subvert_bark("NEU Vessels cannot use the subverter!")
				return
			if (ship.prefix != "KOS")
				if (ship.prefix == target_ship.prefix)
					subvert_bark("Cannot subvert allied vessels!")
					return
	if (world.time < subverter_cooldown)
		subvert_bark("Subverter recharging!")
		return
	if (world.time < target_ship.engine_cooldown)
		subvert_bark("Target vessel is already subverted.")
		return
	if (target_ship.state == OVERMAP_SHIP_IDLE)
		subvert_bark("Target vessel is currently docked (outside of hyperspace).")
		return
	if (target_ship.state == OVERMAP_SHIP_DOCKING)
		subvert_bark("Target vessel is currently docking.")
		return
	if (target_ship.state == OVERMAP_SHIP_UNDOCKING)
		subvert_bark("Target vessel is currently undocking.")
		return
	if (world.time < target_ship.sub_grace)
		subvert_bark("Cannot subvert that vessel currently (Grace period).")
		return
	if (target_ship.antivirus_nodes > 0)
		subvert_bark("Agent failed! Reason: Antivirus")
		return
	if (!can_subvert(target_ship))
		subvert_bark("Failed to subvert (Unknown error)")
		return
	subvert_bark(bark_success_message, SUBVERTER_BARK_SUCCESS)
	return TRUE

//quick maths
/obj/machinery/subverter/proc/can_subvert(obj/structure/overmap/ship/simulated/target_ship, antag = FALSE)
	return !(((!antag) && (target_ship.prefix == "NEU" || (ship && (ship.prefix == "NEU" || (ship.prefix != "KOS" && ship.prefix == target_ship.prefix))))) || world.time < subverter_cooldown || world.time < target_ship.engine_cooldown || world.time < target_ship.sub_grace || target_ship.state != OVERMAP_SHIP_FLYING)

/obj/machinery/subverter/proc/force_dock(obj/structure/overmap/ship/simulated/target_ship)
	target_ship.decelerate(target_ship.max_speed)
	target_ship.dock_in_empty_space(usr)
	target_ship.stall_engines(sub_engine)
	target_ship.most_recent_helm.say("CRITICAL ERROR: SYSTEM TAKEOVER")
	playsound(target_ship.most_recent_helm, 'voidcrew/sound/voice/booterattack.ogg', 100, 0, 0)

/obj/machinery/subverter/proc/attempt_to_subvert(obj/structure/overmap/ship/simulated/target_ship)
	. = FALSE
	bark_processing(target_ship)
	if (can_subvert(target_ship))
		subverter_cooldown = world.time + sub_recharge
		its_gettin_hot_in_here()
		//use_power(active_power_usage)
		if (!target_ship.run_antivirus())
			force_dock(target_ship)
			addtimer(CALLBACK(target_ship, /obj/structure/overmap/ship/simulated/.proc/systems_restored), target_ship.engine_cooldown - world.time)
			return TRUE
		else
			target_ship.sub_blocked(src)

/obj/machinery/subverter/proc/update_stats()
	sub_recharge = SUBVERTER_RECHARGE_TIME
	sub_engine = SUBVERTER_ENGINE_STALL_TIME
	active_power_usage = 1000
	for(var/obj/item/stock_parts/micro_laser/B in component_parts)
		sub_engine += (B.rating-1) * (15 SECONDS)
	for(var/obj/item/stock_parts/manipulator/M in component_parts)
		sub_recharge -= (M.rating-1) * (5 SECONDS)
	for(var/obj/item/stock_parts/capacitor/P in component_parts)
		active_power_usage /= P.rating
		spiciness /= P.rating

/obj/machinery/subverter/RefreshParts()
	update_stats()

/obj/machinery/subverter/proc/its_gettin_hot_in_here()
	//var/turf/T = get_turf(src)
	var/turf/L = loc
	var/datum/gas_mixture/env = L.return_air()
	env.set_temperature(env.return_temperature()+spiciness)
	air_update_turf()

/*
	Manual subverting for those who can't afford an auxillary console
*/
/obj/machinery/subverter/proc/adjust_hacked(state)
	hacked = state
	if (hacked)
		if (ship.prefix == "NEU")
			subvert_bark("NEU Vessels cannot use the subverter!")
		else
			//find nearest non-allied pvp ship and attempt to subvert
			var/obj/structure/overmap/ship/simulated/N
			var/ship_min_dist
			for (var/obj/structure/overmap/ship/simulated/O in view(ship.sensor_range, get_turf(ship)))
				if (O == ship || !can_subvert(O))
					continue
				if (!N)
					N = O
					ship_min_dist = get_dist(ship, N)
				else
					var/ship_dist = get_dist(ship, O)
					if (ship_dist < ship_min_dist)
						N = O
						ship_min_dist = ship_dist
			if (N)
				attempt_to_subvert(N)
			else
				subvert_bark("No subvertable vessels detected.")

/obj/machinery/subverter/proc/shock(mob/user, prb)
	if(machine_stat & (BROKEN|NOPOWER))		// unpowered, no shock
		return FALSE
	if(!prob(prb))
		return FALSE
	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	s.set_up(5, 1, src)
	s.start()
	if (electrocute_mob(user, get_area(src), src, 0.7, TRUE))
		return TRUE
	else
		return FALSE

/obj/machinery/subverter/proc/reset(wire)
	switch(wire)
		if(WIRE_HACK)
			if(!wires.is_cut(wire))
				adjust_hacked(FALSE)
		if(WIRE_SHOCK)
			if(!wires.is_cut(wire))
				shocked = FALSE
		if(WIRE_DISABLE)
			if(!wires.is_cut(wire))
				disabled = FALSE

/obj/machinery/subverter/attackby(obj/item/O, mob/user, params)
	if(default_deconstruction_screwdriver(user, "subverter_t", "subverter", O))
		updateUsrDialog()
		return TRUE

	if(default_deconstruction_crowbar(O))
		return TRUE

	if(panel_open && is_wire_tool(O))
		wires.interact(user)
		return TRUE

	if(istype(O, /obj/item/multitool))
		var/obj/item/multitool/multi = O
		if(multi.buffer && istype(multi.buffer, /obj/machinery/computer/autopilot) && multi.buffer != src)
			var/obj/machinery/computer/autopilot/console = multi.buffer
			console.sub = src
			aux = console
			visible_message("Linked to [console]!")
			aux.say("External device found! Subverter mode enabled.")
		else
			multi.buffer = src
			visible_message("Saved [src] to buffer.")
		return TRUE

	if(user.a_intent == INTENT_HARM)
		return ..()

	if(machine_stat)
		return TRUE

	return ..()
