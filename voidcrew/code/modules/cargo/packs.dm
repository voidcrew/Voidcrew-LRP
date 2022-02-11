//////////////////////////////////////////////////////////////////////////////
//////////////////////////// Science /////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/science/xenobio
	name = "Xenobiology Lab Crate"
	desc = "In case a freak accident has rendered the xenobiology lab non-functional! Contains two grey slime extracts, some plasma, and the required circuit boards to set up your xenobiology lab up and running! Requires Xenobiology access to open."
	cost = 10000
	access = ACCESS_XENOBIOLOGY
	contains = list(/obj/item/slime_extract/grey,
					/obj/item/slime_extract/grey,
					/obj/item/reagent_containers/syringe/plasma,
					/obj/item/circuitboard/computer/xenobiology,
					/obj/item/circuitboard/machine/monkey_recycler,
					/obj/item/circuitboard/machine/processor/slime)
	crate_name = "xenobiology starter crate"
	crate_type = /obj/structure/closet/crate/secure/science

//////////////////////////////////////////////////////////////////////////////
/////////////////////////// Overmap Shuttles /////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/engineering/shuttle_in_a_box
	name = "Shuttle in a Box"
	desc = "The bare minimum amount of machine and computer boards required to create a working spacecraft."
	cost = 8000
	contains = list(
		/obj/item/circuitboard/computer/shuttle/helm,
		/obj/item/circuitboard/machine/shuttle/smes,
		/obj/item/circuitboard/machine/shuttle/engine/electric
	)
	crate_name = "Shuttle in a Box"
