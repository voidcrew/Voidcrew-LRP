//Used in subvert_bark
#define SUBVERTER_BARK_FAILURE 'sound/machines/buzz-two.ogg'
#define SUBVERTER_BARK_SUCCESS 'sound/machines/ping.ogg'
//Default value for how long the subverter must recharge between uses
#define SUBVERTER_RECHARGE_TIME (2 MINUTES)
//Default value for how long a subversion target cannot control the ship
#define SUBVERTER_ENGINE_STALL_TIME (1 MINUTES)
//How hot the subverter makes the room when used
#define SUBVERTER_SPICINESS 300
/**
* These get returned by can_subvert, and are mostly used to make the helm console say different things when a subversion is attempted
*/
#define SUB_SUCCESS 0
#define SUB_TARGET_IS_NEU 1
#define SUB_WE_ARE_NEU 2
#define SUB_TARGET_IS_ALLY 3
#define SUB_RECHARGING 4
#define SUB_TARGET_SUBVERTED 5
#define SUB_TARGET_DOCKED 6
#define SUB_TARGET_DOCKING 7
#define SUB_TARGET_UNDOCKING 8
#define SUB_TARGET_GRACE 9
#define SUB_TARGET_ANTIVIRUS 10
#define SUB_OUT_OF_RANGE 11

/obj/machinery/subverter
	name = "interdictor"
	desc = "A piece of equipment used to upload programs to other vessels. It has no interface: It could be linked to an auxiliary console or the wires could be pulsed manually."
	icon = 'voidcrew/icons/obj/machines/space_hacking.dmi'
	icon_state = "subverter"
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 100
	active_power_usage = 1000
	circuit = /obj/item/circuitboard/machine/subverter
	layer = BELOW_OBJ_LAYER
	///Which ship the subverter is on
	var/obj/structure/overmap/ship/simulated/ship
	///Linked auxiliary console
	var/obj/machinery/computer/autopilot/aux
	///Standard machine stuff
	var/hacked = FALSE
	var/disabled = FALSE
	var/shocked = FALSE
	///Cooldown that handles the subverter recharging
	COOLDOWN_DECLARE(subverter_cooldown)
	///recharge time, gets affected by parts
	var/sub_recharge = SUBVERTER_RECHARGE_TIME
	///how long the target ship becomes immobile, affected by parts
	var/sub_engine = SUBVERTER_ENGINE_STALL_TIME
	///how hot the subverter makes the room, affected by parts
	var/spiciness = SUBVERTER_SPICINESS
	///range of the subverter, affected by parts
	var/range = 0

/obj/machinery/subverter/Initialize()
	. = ..()
	wires = new /datum/wires/subverter(src)
	update_stats()
	COOLDOWN_START(src, subverter_cooldown, sub_recharge)

/obj/machinery/subverter/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	ship = port.current_ship

/obj/machinery/subverter/on_deconstruction()
	if (aux)
		aux.sub = null
		aux = null
	return ..()

/**
*	Returns formatted remaining time till the subverter finishes recharging
*/
/obj/machinery/subverter/proc/get_recharge_str()
	. = COOLDOWN_TIMELEFT(src, subverter_cooldown) / 10
	return "[add_leading(num2text((. / 60) % 60), 2, "0")]:[add_leading(num2text(. % 60), 2, "0")]"

/**
*	Causes subverter to make a certain sound and the aux console to display a certain message
*	Exist to prevent player confusion when the subversion attempt fails
*
*	message - what the aux console will say
*	soundin - sound the subverter will make
*/
/obj/machinery/subverter/proc/subvert_bark(message, soundin = SUBVERTER_BARK_FAILURE)
	if (aux)
		aux.say(message)
	playsound(loc, soundin, 90, 1, 0)

/**
*	This handles the different contexts a subverter could bark in response to.
*	It will call subvert_bark with parameters that fit the situation.
*
*	subvert_flag - The context of the subversion attempt, returned by can_subvert
*	bark_success_message - (optional) Text displayed upon a successful subversion
*/
/obj/machinery/subverter/proc/bark_processing(subvert_flag, bark_success_message = "Agent was successful! Bringing target vessel out of hyperspace.")
	switch (subvert_flag)
		if (SUB_SUCCESS)
			subvert_bark(bark_success_message, SUBVERTER_BARK_SUCCESS)
		if (SUB_TARGET_IS_NEU)
			subvert_bark("Cannot subvert NEU vessels!")
		if (SUB_WE_ARE_NEU)
			subvert_bark("NEU Vessels cannot use the subverter!")
		if (SUB_TARGET_IS_ALLY)
			subvert_bark("Cannot subvert allied vessels!")
		if (SUB_RECHARGING)
			subvert_bark("Subverter recharging!")
		if (SUB_TARGET_SUBVERTED)
			subvert_bark("Target vessel is already subverted.")
		if (SUB_TARGET_DOCKED)
			subvert_bark("Target vessel is currently docked (outside of hyperspace).")
		if (SUB_TARGET_DOCKING)
			subvert_bark("Target vessel is currently docking.")
		if (SUB_TARGET_UNDOCKING)
			subvert_bark("Target vessel is currently undocking.")
		if (SUB_TARGET_GRACE)
			subvert_bark("Cannot subvert that vessel currently (Grace period).")
		if (SUB_TARGET_ANTIVIRUS)
			subvert_bark("Agent failed! Reason: Antivirus")
		if (SUB_OUT_OF_RANGE)
			subvert_bark("Target vessel is out of range ([range] tiles).")
		else
			subvert_bark("Failed to subvert (Unknown error)")

/**
*	Returns int used to determine the context of the subversion attempt
*
*	obj/structure/overmap/ship/simulated/target_ship - The target ship of the subversion attempt
*	antag - (optional) Not really used but if set to TRUE, will ignore factions. If antag ships are added they will likely use this
*/
/obj/machinery/subverter/proc/can_subvert(obj/structure/overmap/ship/simulated/target_ship, antag = FALSE)
	if (target_ship.faction_prefix == "NEU")
		return SUB_TARGET_IS_NEU
	if (!antag)
		if (ship)
			if (ship.faction_prefix == "NEU")
				return SUB_WE_ARE_NEU
			if (ship.faction_prefix != "KOS")
				if (ship.faction_prefix == target_ship.faction_prefix)
					return SUB_TARGET_IS_ALLY
	if (!COOLDOWN_FINISHED(src, subverter_cooldown))
		return SUB_RECHARGING
	if (get_dist(ship, target_ship) > range)
		return SUB_OUT_OF_RANGE
	if (!COOLDOWN_FINISHED(target_ship, engine_cooldown))
		return SUB_TARGET_SUBVERTED
	if (target_ship.state == OVERMAP_SHIP_IDLE)
		return SUB_TARGET_DOCKED
	if (target_ship.state == OVERMAP_SHIP_DOCKING)
		return SUB_TARGET_DOCKING
	if (target_ship.state == OVERMAP_SHIP_UNDOCKING)
		return SUB_TARGET_UNDOCKING
	if (!COOLDOWN_FINISHED(target_ship, sub_grace))
		return SUB_TARGET_GRACE
	if (target_ship.antivirus_nodes > 0)
		return SUB_TARGET_ANTIVIRUS
	return SUB_SUCCESS

/**
*	Whether or not the subversion attempt should cause the subverter to activate.
*	Does not necessarily mean the subversion attempt will actually work (antivirus)
*
*	sub_flag - subversion context to check (see can_subvert)
*/
/obj/machinery/subverter/proc/considered_valid_target(sub_flag)
	return (sub_flag == SUB_SUCCESS) || (sub_flag == SUB_TARGET_ANTIVIRUS)

/**
*	Cause ship to dock in empty space forcibly
*
*	obj/structure/overmap/ship/simulated/target_ship - The ship that will dock
*/
/obj/machinery/subverter/proc/force_dock(obj/structure/overmap/ship/simulated/target_ship)
	target_ship.decelerate(target_ship.max_speed)
	target_ship.dock_in_empty_space(usr)
	COOLDOWN_START(target_ship, engine_cooldown, sub_engine)
	target_ship.most_recent_helm.say("CRITICAL ERROR: SYSTEM TAKEOVER")
	playsound(target_ship.most_recent_helm, 'voidcrew/sound/voice/booterattack.ogg', 100, 0, 0)

/**
*	Begin the actual subversion attempt
*
*	obj/structure/overmap/ship/simulated/target_ship - Target ship of the attempt
*/
/obj/machinery/subverter/proc/attempt_to_subvert(obj/structure/overmap/ship/simulated/target_ship)
	. = FALSE
	var/can_sub_flag = can_subvert(target_ship)
	bark_processing(can_sub_flag)
	if (!considered_valid_target(can_sub_flag))
		return
	COOLDOWN_START(src, subverter_cooldown, sub_recharge)
	its_gettin_hot_in_here()
	if (!target_ship.run_antivirus())
		force_dock(target_ship)
		//If the ships under us, update our interaction list
		if (target_ship.loc == ship.loc)
			for (var/obj/structure/overmap/add in get_turf(ship))
				if (add == ship)
					continue
				LAZYOR(ship.close_overmap_objects, add)
			LAZYREMOVE(ship.close_overmap_objects, target_ship) //prevent confusion, since you wanna dock in the empty space
		addtimer(CALLBACK(target_ship, /obj/structure/overmap/ship/simulated/.proc/systems_restored), COOLDOWN_TIMELEFT(target_ship, engine_cooldown))
		return TRUE
	else
		target_ship.most_recent_helm.say("Viral agent blocked. Source: [ship.name]")
		COOLDOWN_START(target_ship, sub_grace, 5 MINUTES)

/**
*	Update the machine's stats depending on the parts
*/
/obj/machinery/subverter/proc/update_stats()
	sub_recharge = SUBVERTER_RECHARGE_TIME
	sub_engine = SUBVERTER_ENGINE_STALL_TIME
	active_power_usage = 1000
	for(var/obj/item/stock_parts/micro_laser/laser in component_parts)
		sub_engine += (laser.rating-1) * (15 SECONDS)
	for(var/obj/item/stock_parts/manipulator/manip in component_parts)
		sub_recharge -= (manip.rating-1) * (5 SECONDS)
	for(var/obj/item/stock_parts/capacitor/capac in component_parts)
		active_power_usage /= capac.rating
		spiciness /= capac.rating
	for(var/obj/item/stock_parts/scanning_module/scanner in component_parts)
		range = scanner.rating - 1

/obj/machinery/subverter/RefreshParts()
	update_stats()

/**
*	Causes the air around the subverter to heat up
*/
/obj/machinery/subverter/proc/its_gettin_hot_in_here()
	var/turf/sub_location = get_turf(src)
	var/datum/gas_mixture/env = sub_location.return_air()
	env.set_temperature(env.return_temperature()+spiciness)
	air_update_turf()

/**
*	Manual subverting for those who can't afford an auxiliary console
*
*	state - Whether or not the subverter got hacked
*/
/obj/machinery/subverter/proc/adjust_hacked(state)
	hacked = state
	if (!hacked)
		return
	if (ship.faction_prefix == "NEU")
		subvert_bark("NEU Vessels cannot use the subverter!")
		return
	//find nearest non-allied pvp ship and attempt to subvert
	var/obj/structure/overmap/ship/simulated/nearest
	var/ship_min_dist
	for (var/obj/structure/overmap/ship/simulated/ship_in_view in view(ship.sensor_range, get_turf(ship)))
		var/can_sub_flag = can_subvert(ship_in_view)
		if (ship_in_view == ship || !considered_valid_target(can_sub_flag))
			continue
		if (!nearest)
			nearest = ship_in_view
			ship_min_dist = get_dist(ship, nearest)
		else
			var/ship_dist = get_dist(ship, ship_in_view)
			if (ship_dist < ship_min_dist)
				nearest = ship_in_view
				ship_min_dist = ship_dist
	if (nearest)
		attempt_to_subvert(nearest)
	else
		subvert_bark("No subvertable vessels detected.")

//Normal machine hacking stuff
/obj/machinery/subverter/proc/shock(mob/user, prb)
	if(machine_stat & (BROKEN|NOPOWER))
		return FALSE
	if(!prob(prb))
		return FALSE
	var/datum/effect_system/spark_spread/spark = new /datum/effect_system/spark_spread
	spark.set_up(5, 1, src)
	spark.start()
	if (electrocute_mob(user, get_area(src), src, 0.7, TRUE))
		return TRUE

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

/obj/machinery/subverter/attackby(obj/item/item, mob/user, params)
	if(default_deconstruction_screwdriver(user, "subverter_t", "subverter", item))
		updateUsrDialog()
		return TRUE
	if(default_deconstruction_crowbar(item))
		return TRUE
	if(panel_open && is_wire_tool(item))
		wires.interact(user)
		return TRUE
	if(user.a_intent == INTENT_HARM)
		return ..()
	if(machine_stat)
		return TRUE
	return ..()

/obj/machinery/subverter/multitool_act(mob/living/user, obj/item/item)
	. = ..()
	if (panel_open)
		wires.interact(user)
		return TRUE
	var/obj/item/multitool/multi = item
	if(multi.buffer && istype(multi.buffer, /obj/machinery/computer/autopilot) && multi.buffer != src) //for linking to aux console
		var/obj/machinery/computer/autopilot/console = multi.buffer
		console.sub = src
		aux = console
		visible_message("Linked to [console]!")
		aux.say("External device found! Subverter mode enabled.")
	else
		multi.buffer = src
		visible_message("Saved [src] to buffer.")
	return TRUE

#undef SUBVERTER_BARK_FAILURE
#undef SUBVERTER_BARK_SUCCESS
#undef SUBVERTER_RECHARGE_TIME
#undef SUBVERTER_ENGINE_STALL_TIME
#undef SUBVERTER_SPICINESS

#undef SUB_SUCCESS
#undef SUB_TARGET_IS_NEU
#undef SUB_WE_ARE_NEU
#undef SUB_TARGET_IS_ALLY
#undef SUB_RECHARGING
#undef SUB_TARGET_SUBVERTED
#undef SUB_TARGET_DOCKED
#undef SUB_TARGET_DOCKING
#undef SUB_TARGET_UNDOCKING
#undef SUB_TARGET_GRACE
#undef SUB_TARGET_ANTIVIRUS
#undef SUB_OUT_OF_RANGE
