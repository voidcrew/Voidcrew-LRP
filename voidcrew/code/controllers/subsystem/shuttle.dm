/datum/controller/subsystem/shuttle
	/// Timer ID of the timer used for telling which stage of an endround "jump" the ships are in
	var/jump_timer
	/// Current state of the jump
	var/jump_mode = BS_JUMP_IDLE
	/// Time taken for bluespace jump to begin after it is requested (in deciseconds)
	var/jump_request_time = 6000
	/// Time taken for a bluespace jump to complete after it initiates (in deciseconds)
	var/jump_completion_time = 1200

/*
 * Bluespace jump procs
 */

/**
 * ## request_jump
 *
 * Requests a bluespace jump, which, after jump_request_time deciseconds, will initiate a bluespace jump.
 *
 * Arguments:
 * * modifiers - (Optional) Modifies the length of the jump request time (defaults to 1)
 */
/datum/controller/subsystem/shuttle/proc/request_jump(modifier = 1)
	jump_mode = BS_JUMP_CALLED
	jump_timer = addtimer(CALLBACK(src, .proc/initiate_jump), jump_request_time * modifier, TIMER_STOPPABLE)
	priority_announce("Preparing for jump. ETD: [jump_request_time * modifier / 600] minutes.", null, null, "Priority")

/**
 * ##cancel_jump
 *
 * Cancels a currently requested bluespace jump.
 * Can only be done after the jump has been requested, but before the jump has actually begun.
 */
/datum/controller/subsystem/shuttle/proc/cancel_jump()
	if(jump_mode != BS_JUMP_CALLED)
		return
	deltimer(jump_timer)
	jump_mode = BS_JUMP_IDLE
	priority_announce("Bluespace jump cancelled.", null, null, "Priority")

/**
 * ##initiate_jump
 *
 * Initiates a bluespace jump, ending the round after a delay of jump_completion_time deciseconds.
 * This cannot be interrupted by conventional means.
 */
/datum/controller/subsystem/shuttle/proc/initiate_jump()
	jump_mode = BS_JUMP_INITIATED
	for(var/obj/docking_port/mobile/mobile_port as anything in mobile)
		mobile_port.hyperspace_sound(HYPERSPACE_WARMUP, mobile_port.shuttle_areas)
		mobile_port.on_emergency_launch()

	priority_announce("Jump initiated. ETA: [jump_completion_time / 600] minutes.", null, null, "Priority")
	jump_timer = addtimer(VARSET_CALLBACK(src, jump_mode, BS_JUMP_COMPLETED), jump_completion_time)

/*
 * Overriden SShuttle procs
 */

//There are a few lines removed from this to prevent shuttle calling, better just to fully overwrite this
/datum/controller/subsystem/shuttle/fire()
	for(var/obj/docking_port/mobile/mobile_port as anything in mobile)
		if(!mobile_port)
			mobile.Remove(mobile_port)
			continue
		mobile_port.check()

	for(var/obj/docking_port/stationary/transit/transit_dock as anything in transit)
		if(!transit_dock.owner)
			qdel(transit_dock, force=TRUE)
			continue
		// This next one removes transit docks/zones that aren't
		// immediately being used. This will mean that the zone creation
		// code will be running a lot.
		var/obj/docking_port/mobile/owner = transit_dock.owner
		if(owner)
			var/idle = owner.mode == SHUTTLE_IDLE
			var/not_centcom_evac = owner.launch_status == NOLAUNCH
			var/not_in_use = (!transit_dock.get_docked())
			if(idle && not_centcom_evac && not_in_use)
				qdel(transit_dock, force=TRUE)
				continue

	while(transit_requesters.len)
		var/requester = popleft(transit_requesters)
		var/success = generate_transit_dock(requester)
		if(!success) // BACK OF THE QUEUE
			transit_request_failures[requester]++
			if(transit_request_failures[requester] < MAX_TRANSIT_REQUEST_RETRIES)
				transit_requesters += requester
			else
				var/obj/docking_port/mobile/M = requester
				M.transit_failure()
		if(MC_TICK_CHECK)
			break

/**
  * ##action_load
  *
  * This proc loads a shuttle from a specified template.
  * If no destination port is specified, the shuttle will be
  * spawned at a generated transit doc. Doing this is how most ships are loaded.
  *
  * Arguments:
  * * loading_template - The shuttle map template to load. Can NOT be null.
  * * destination_port - The port the newly loaded shuttle will be sent to after being fully spawned in. If you want to have a transit dock be created, use [proc/load_template] instead. Should NOT be null.
  **/
/datum/controller/subsystem/shuttle/action_load(datum/map_template/shuttle/loading_template, obj/docking_port/stationary/destination_port)
	if(!destination_port)
		CRASH("No destination port specified for shuttle load, aborting.")
	var/obj/docking_port/mobile/new_shuttle = load_template(loading_template, FALSE)
	var/result = new_shuttle.canDock(destination_port)
	if((result != SHUTTLE_CAN_DOCK))
		WARNING("Template shuttle [new_shuttle] cannot dock at [destination_port] ([result]).")
		new_shuttle.jumpToNullSpace()
		return
	new_shuttle.initiate_docking(destination_port)

/**
  * This proc replaces the given shuttle with a fresh new one spawned from a template.
  * spawned at a generated transit doc. Doing this is how most ships are loaded.
  *
  * Hopefully this doesn't need to be used, it's a last resort for admin-coders at best,
  * but I wanted to preserve the functionality of old action_load() in case it was needed.
  *
  * * to_replace - The shuttle to replace. Should NOT be null.
  * * replacement - The shuttle map template to load in place of the old shuttle. Can NOT be null.
  **/
/datum/controller/subsystem/shuttle/replace_shuttle(obj/docking_port/mobile/to_replace, datum/map_template/shuttle/replacement)
	if(!to_replace || !replacement)
		return
	var/obj/docking_port/mobile/new_shuttle = load_template(replacement, FALSE)
	var/obj/docking_port/stationary/old_shuttle_location = to_replace.get_docked()
	var/result = new_shuttle.canDock(old_shuttle_location)

	if((result != SHUTTLE_CAN_DOCK) && (result != SHUTTLE_SOMEONE_ELSE_DOCKED)) //Someone else /IS/ docked, the old shuttle!
		WARNING("Template shuttle [new_shuttle] cannot dock at [old_shuttle_location] ([result]).")
		new_shuttle.jumpToNullSpace()
		return

	new_shuttle.timer = to_replace.timer //Copy some vars from the old shuttle
	new_shuttle.mode = to_replace.mode
	new_shuttle.current_ship.set_ship_name(to_replace.name)
	new_shuttle.current_ship.forceMove(to_replace.current_ship.loc) //Overmap location

	if(istype(old_shuttle_location, /obj/docking_port/stationary/transit))
		to_replace.assigned_transit = null
		new_shuttle.assigned_transit = old_shuttle_location

	to_replace.jumpToNullSpace() //This will destroy the old shuttle
	new_shuttle.initiate_docking(old_shuttle_location) //This will spawn the new shuttle
	return new_shuttle

/**
  * This proc is THE proc that loads a shuttle from a specified template. Anything else should go through this
  * in order to spawn a new shuttle.
  *
  * * template - The shuttle map template to load. Can NOT be null.
  * * spawn_transit - Whether or not to send the new shuttle to a newly-generated transit dock after loading.
  **/
/datum/controller/subsystem/shuttle/load_template(datum/map_template/shuttle/template, spawn_transit = TRUE)
	. = FALSE
	var/loading_mapzone = SSmapping.create_map_zone("Shuttle Loading Zone")
	var/datum/virtual_level/loading_zone = SSmapping.create_virtual_level("[template.name] Loading Level", list(ZTRAIT_RESERVED = TRUE), loading_mapzone, template.width, template.height, ALLOCATION_FREE)

	if(!loading_zone)
		CRASH("failed to reserve an area for shuttle template loading")
	loading_zone.fill_in(turf_type = /turf/open/space/transit/south)

	var/turf/BL = locate(loading_zone.low_x, loading_zone.low_y, loading_zone.z_value)
	template.load(BL, centered = FALSE, register = FALSE)

	var/affected = template.get_affected_turfs(BL, centered=FALSE)

	var/found = 0
	var/obj/docking_port/mobile/new_shuttle
	// Search the turfs for docking ports
	// - We need to find the mobile docking port because that is the heart of
	//   the shuttle.
	// - We need to check that no additional ports have slipped in from the
	//   template, because that causes unintended behaviour.
	for(var/T in affected)
		for(var/obj/docking_port/P in T)
			if(istype(P, /obj/docking_port/mobile))
				found++
				if(found > 1)
					qdel(P, force=TRUE)
					log_world("Map warning: Shuttle Template [template.mappath] has multiple mobile docking ports.")
				else
					new_shuttle = P
			if(istype(P, /obj/docking_port/stationary))
				log_world("Map warning: Shuttle Template [template.mappath] has a stationary docking port.")
	if(!found)
		var/msg = "load_template(): Shuttle Template [template.mappath] has no mobile docking port. Aborting import."
		for(var/T in affected)
			var/turf/T0 = T
			T0.empty()

		message_admins(msg)
		WARNING(msg)
		return

	var/obj/docking_port/mobile/transit_dock = generate_transit_dock(new_shuttle)

	if(!transit_dock)
		CRASH("No dock found/could be created for shuttle ([template.name]), aborting.")

	var/result = new_shuttle.canDock(transit_dock)
	if((result != SHUTTLE_CAN_DOCK))
		WARNING("Template shuttle [new_shuttle] cannot dock at [transit_dock] ([result]).")
		new_shuttle.jumpToNullSpace()
		return

	new_shuttle.initiate_docking(transit_dock)
	new_shuttle.linkup(transit_dock)
	QDEL_NULL(loading_zone)

	//Everything fine
	template.post_load(new_shuttle)
	new_shuttle.register()
	new_shuttle.reset_air()

	return new_shuttle
