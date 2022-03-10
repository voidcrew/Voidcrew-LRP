///////////////////////////////////
//////////Nanite Devices///////////
///////////////////////////////////
/datum/design/nanite_remote
	name = "Nanite Remote"
	desc = "Allows for the construction of a nanite remote."
	id = "nanite_remote"
	build_type = PROTOLATHE
	materials = list(/datum/material/glass = 500, /datum/material/iron = 500)
	build_path = /obj/item/nanite_remote
	category = list("Electronics")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/nanite_comm_remote
	name = "Nanite Communication Remote"
	desc = "Allows for the construction of a nanite communication remote."
	id = "nanite_comm_remote"
	build_type = PROTOLATHE
	materials = list(/datum/material/glass = 500, /datum/material/iron = 500)
	build_path = /obj/item/nanite_remote/comm
	category = list("Electronics")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/nanite_scanner
	name = "Nanite Scanner"
	desc = "Allows for the construction of a nanite scanner."
	id = "nanite_scanner"
	build_type = PROTOLATHE
	materials = list(/datum/material/glass = 500, /datum/material/iron = 500)
	build_path = /obj/item/nanite_scanner
	category = list("Electronics")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/nanite_disk
	name = "Nanite Program Disk"
	desc = "Stores nanite programs."
	id = "nanite_disk"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 300, /datum/material/glass = 100)
	build_path = /obj/item/disk/nanite_program
	category = list("Electronics")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/robo_id
	name = "Robotics ID Upgrade"
	desc = "A tiny chip that attaches to any standard ID card. This one is configured to access robotics equipment."
	id = "robo_access_card"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 200, /datum/material/glass = 100, /datum/material/silver = 500)
	build_path = /obj/item/card/robo_access_card
	category = list("Electronics")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_ENGINEERING
