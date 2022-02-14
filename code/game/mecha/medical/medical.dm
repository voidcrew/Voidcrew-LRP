/obj/mecha/medical
	internals_req_access = list() // VoidTest Edit

/obj/mecha/medical/mechturn(direction)
	. = ..()
	if(!strafe && !occupant.client.keys_held["Alt"])
		mechstep(direction) //agile mechs get to move and turn in the same step
