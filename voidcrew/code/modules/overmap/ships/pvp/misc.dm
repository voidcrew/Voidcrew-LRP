#define SHIP_GRACE_TIME (3 MINUTES)

/obj/structure/overmap/ship/simulated
	var/obj/machinery/computer/helm/most_recent_helm // For sending messages to the target's helm
	///Cooldown for when you get subverted and cannot control the ship anymore
	COOLDOWN_DECLARE(engine_cooldown)
	///How many subversion attempts you can block
	var/antivirus_nodes = 0
	///How long you are immune to being subverted
	COOLDOWN_DECLARE(sub_grace)
	///Ship that is requesting to dock with you
	var/obj/structure/overmap/ship/simulated/requesting_ship
	///prevent spamming
	COOLDOWN_DECLARE(request_cooldown)
	///prevent someone from sending docking requests to multiple ships and probably breaking the game
	var/sent_request = FALSE

//For uploading an antivirus
/obj/machinery/computer/helm/attackby(obj/item/O, mob/user, params)
	if (istype(O, /obj/item/disk/antivirus))
		current_ship.antivirus_nodes++
		playsound(loc, 'sound/misc/compiler-stage2.ogg', 90, 1, 0)
		say("Uploaded antiviral node!")
		qdel(O)
	else
		return ..()

/obj/machinery/computer/helm/examine(mob/user)
	. = ..()
	. += "<span class='notice'>It has [current_ship.antivirus_nodes] antiviral node[(current_ship.antivirus_nodes > 1) || (current_ship.antivirus_nodes == 0) ? "s" : ""] installed.</span>"

/**
*	Try to block a sub attempt. If successful, use up an antivirus node and return TRUE
*/
/obj/structure/overmap/ship/simulated/proc/run_antivirus()
	. = FALSE
	if (antivirus_nodes > 0)
		antivirus_nodes--
		return TRUE

/**
*	You just survived a subversion, start the grace period and make the helm say something
*/
/obj/structure/overmap/ship/simulated/proc/systems_restored()
	COOLDOWN_START(src, sub_grace, SHIP_GRACE_TIME)
	most_recent_helm.say("Helm controls restored!")

//Prevent subverted ship from being able to do anything
/obj/machinery/computer/helm/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	if (!COOLDOWN_FINISHED(current_ship, engine_cooldown))
		say("Helm controls subverted!")
	else
		return ..()

/obj/machinery/computer/autopilot/ui_act(action, params)
	if (!COOLDOWN_FINISHED(ship, engine_cooldown))
		say("Auxillary console unresponsive!")
	else
		return ..()

/**
*	Used for request docking
*
*	mob/user - player who initiated the dock
*	obj/structure/overmap/ship/simulated/acting - ship that asked to dock
*/
/obj/structure/overmap/ship/simulated/proc/duo_dock(mob/user, obj/structure/overmap/ship/simulated/acting)
	var/obj/structure/overmap/dynamic/empty/E
	E = locate() in get_turf(src)
	if(!E)
		E = new(get_turf(src))
	if(E)
		acting.decelerate(acting.max_speed)
		decelerate(max_speed)
		return overmap_object_act(user, E, acting)

/**
*	New interaction for ships: request docking. This will send a request to the other ship's helm console
*	that will allow them to both dock in an empty space at the same time
*
*	mob/user - player who made the request
*	obj/structure/overmap/ship/simulated/acting - the requesting ship
*/
/obj/structure/overmap/ship/simulated/ship_act(mob/user, obj/structure/overmap/ship/simulated/acting)
	if (acting.sent_request)
		acting.most_recent_helm.say("Request already sent.")
		return
	if (requesting_ship)
		acting.most_recent_helm.say("That ship is already dealing with a docking request.")
		return
	if (!COOLDOWN_FINISHED(acting, request_cooldown))
		acting.most_recent_helm.say("[num2text(COOLDOWN_TIMELEFT(acting, request_cooldown)/10)] seconds before you can request another dock.")
		return
	if (state != OVERMAP_SHIP_FLYING)
		acting.most_recent_helm.say("The [name] is busy.")
		return
	if (acting.state != OVERMAP_SHIP_FLYING)
		acting.most_recent_helm.say("Must be in hyperspace to request docking.")
		return
	if (loc != acting.loc)
		acting.most_recent_helm.say("Not in docking range.")
		return
	var/poll_client = tgui_alert(usr, "Request to dock with [name]?", "Requesting dock", list("Yes", "No"))
	if (poll_client == "Yes")
		if (loc != acting.loc)
			acting.most_recent_helm.say("Too far to request docking.")
			return
		acting.sent_request = TRUE
		acting.most_recent_helm.say("Requested to dock with [name].")
		most_recent_helm.say("Docking request recieved from [acting.name].")
		playsound(most_recent_helm.loc, 'sound/machines/buzz-two.ogg', 90, 1, 0)
		requesting_ship = acting
		COOLDOWN_START(acting, request_cooldown, 10 SECONDS)


#undef SHIP_GRACE_TIME
