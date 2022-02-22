#define SHIP_GRACE_TIME (1 MINUTES)

/obj/structure/overmap/ship/simulated
	var/obj/machinery/computer/helm/most_recent_helm // For sending messages to the target's helm
	var/engine_cooldown = 0 // The point in time when your engines will work again
	var/antivirus_nodes = 0
	var/sub_grace = 0

/obj/machinery/computer/helm/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock)
	..()
	current_ship.most_recent_helm = src

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

/obj/structure/overmap/ship/simulated/proc/run_antivirus()
	. = FALSE
	if (antivirus_nodes > 0)
		antivirus_nodes--
		return TRUE

/obj/structure/overmap/ship/simulated/proc/stall_engines(var/amount)
	engine_cooldown = world.time + amount

/obj/structure/overmap/ship/simulated/proc/grace_period()
	sub_grace = world.time + SHIP_GRACE_TIME

/obj/structure/overmap/ship/simulated/proc/systems_restored()
	grace_period()
	most_recent_helm.say("Helm controls restored!")

/obj/structure/overmap/ship/simulated/proc/sub_blocked(obj/machinery/subverter/attacker)
	most_recent_helm.say("Viral agent blocked. Source: [attacker.ship.name]")

/obj/machinery/computer/helm/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	if (world.time < current_ship.engine_cooldown)
		say("Helm controls subverted!")
	else
		return ..()

/obj/machinery/computer/autopilot/ui_act(action, params)
	if (world.time < ship.engine_cooldown)
		say("Auxillary console unresponsive!")
	else
		return ..()
