/obj/structure/overmap/dynamic
	name = "weak energy signature"
	desc = "A very weak energy signal. It may not still be here if you leave it."
	icon_state = "strange_event"
	///The preset ruin template to load, if/when it is loaded.
	var/datum/map_template/template
	///The docking port in the reserve
	var/obj/docking_port/stationary/reserve_dock
	///The docking port in the reserve
	var/obj/docking_port/stationary/reserve_dock_secondary
	///What kind of planet the level is, if it's a planet at all.
	var/datum/overmap/planet/planet

	///Keeps track of docks taken
	var/first_dock_taken = FALSE
	var/second_dock_taken = FALSE

/obj/structure/overmap/dynamic/lava
	planet = /datum/overmap/planet/lava

/obj/structure/overmap/dynamic/ice
	planet = /datum/overmap/planet/ice

/obj/structure/overmap/dynamic/sand
	planet = /datum/overmap/planet/sand

/obj/structure/overmap/dynamic/jungle
	planet = /datum/overmap/planet/jungle

/obj/structure/overmap/dynamic/rock
	planet = /datum/overmap/planet/rock

/obj/structure/overmap/dynamic/energy_signal
	planet = /datum/overmap/planet/space
