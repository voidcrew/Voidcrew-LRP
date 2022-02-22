/datum/wires/subverter
	holder_type = /obj/machinery/subverter
	proper_name = "Subverter"

/datum/wires/subverter/New(atom/holder)
	wires = list(
		WIRE_HACK, WIRE_DISABLE,
		WIRE_SHOCK, WIRE_ZAP
	)
	add_duds(6)
	..()

/datum/wires/subverter/interactable(mob/user)
	var/obj/machinery/subverter/A = holder
	if(A.panel_open)
		return TRUE

/datum/wires/subverter/get_status()
	var/obj/machinery/subverter/A = holder
	var/list/status = list()
	status += "The red light is [A.disabled ? "on" : "off"]."
	status += "The blue light is [A.hacked ? "on" : "off"]."
	status += "The green indicator is [world.time < A.subverter_cooldown ? "blinking" : "off"]."
	return status

/datum/wires/subverter/on_pulse(wire)
	var/obj/machinery/subverter/A = holder
	switch(wire)
		if(WIRE_HACK)
			if (!A.hacked)
				A.adjust_hacked(TRUE)
				addtimer(CALLBACK(A, /obj/machinery/subverter.proc/reset, wire), 5)
		if(WIRE_SHOCK)
			A.shocked = !A.shocked
			addtimer(CALLBACK(A, /obj/machinery/subverter.proc/reset, wire), 60)
		if(WIRE_DISABLE)
			A.disabled = !A.disabled
			addtimer(CALLBACK(A, /obj/machinery/subverter.proc/reset, wire), 60)

/datum/wires/subverter/on_cut(wire, mend)
	var/obj/machinery/subverter/A = holder
	switch(wire)
		if(WIRE_HACK)
			A.shocked = !mend
		if(WIRE_DISABLE)
			A.disabled = !mend
		if(WIRE_ZAP)
			A.shock(usr, 50)
