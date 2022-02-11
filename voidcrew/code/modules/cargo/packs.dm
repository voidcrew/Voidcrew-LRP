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
