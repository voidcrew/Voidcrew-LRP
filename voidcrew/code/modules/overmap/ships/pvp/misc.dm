#define SHIP_GRACE_TIME (1 MINUTES)

/obj/structure/overmap/ship/simulated
	var/obj/machinery/computer/helm/most_recent_helm // For sending messages to the target's helm
	///Cooldown for when you get subverted and cannot control the ship anymore
	COOLDOWN_DECLARE(engine_cooldown)
	///How many subversion attempts you can block
	var/antivirus_nodes = 0
	///How long you are immune to being subverted
	COOLDOWN_DECLARE(sub_grace)

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
	. += "<span class='notice'>It has [current_ship.antivirus_nodes] antiviral node[current_ship.antivirus_nodes > 1 ? "s" : ""] installed.</span>"

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

#undef SHIP_GRACE_TIME