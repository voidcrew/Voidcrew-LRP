/datum/design/miningcore_shell
	name = "Bluespace Mining Shell"
	desc = "An unfinished Bluespace Mining Core that requires stabilized gibtonite to finish."
	id = "miningcore_shell"
	build_type = PROTOLATHE
	materials = list(/datum/material/plasma = 2000,
					 /datum/material/iron = 2000)
	reagents_list = list(/datum/reagent/stabilizing_agent = 50)
	build_path = /obj/item/bluespace_parts/miningcore_shell
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE
