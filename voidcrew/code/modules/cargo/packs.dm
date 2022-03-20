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

/datum/supply_pack/service/walkman_crate
	name = "Crate Of Walkmans"
	desc = "A Crate of 6 walkman from the old times, includes some blank cassettes aswell."
	cost = 2000
	contains = list(
		/obj/item/device/walkman,
		/obj/item/device/walkman,
		/obj/item/device/walkman,
		/obj/item/device/walkman,
		/obj/item/device/walkman,
		/obj/item/device/walkman,
		/obj/item/device/cassette_tape/blank,
		/obj/item/device/cassette_tape/blank,
		/obj/item/device/cassette_tape/blank,
		/obj/item/device/cassette_tape/blank,
		/obj/item/device/cassette_tape/blank,
		/obj/item/device/cassette_tape/blank
	)
	crate_name = "Crate Of Walkmans"

/datum/supply_pack/service/random_cassettes
	name = "Crate of Random Cassettes" // i want the odds to be roughly 25% chance of rolling a blank cassette
	desc = "A pack of 3 random cassettes"
	cost = 3000
	var/num_contained = 3 //number of items picked to be contained in a randomised crate
	contains = list(
		/obj/item/device/cassette_tape/blank,
		/obj/item/device/cassette_tape/blank,
		/obj/item/device/cassette_tape/friday,
	)
	crate_name = "Crate of Random Cassettes"
