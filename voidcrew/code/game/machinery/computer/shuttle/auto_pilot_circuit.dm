/obj/item/circuitboard/computer/autopilot
	name = "Auxiliary Shuttle Console (Computer Board)"
	icon_state = "science"
	build_path = /obj/machinery/computer/autopilot

/datum/design/board/shuttle/autopilot
	name = "Computer Design (Auxiliary Shuttle Console)"
	desc = "The circuit board for an Auxiliary Shuttle Console."
	id = "shuttle_autopilot"
	build_path = /obj/item/circuitboard/computer/autopilot
	category = list("Computer Boards", "Shuttle Machinery")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_ENGINEERING
