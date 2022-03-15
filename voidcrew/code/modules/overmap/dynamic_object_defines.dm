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
	///If the level should be preserved. Useful for if you want to build an autismfort or something.
	var/preserve_level = FALSE
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

// /obj/structure/overmap/dynamic/asteroid
// 	planet = /datum/overmap/planet/asteroid

/obj/structure/overmap/dynamic/energy_signal
	planet = /datum/overmap/planet/space

/area/overmap_encounter
	name = "\improper Overmap Encounter"
	icon_state = "away"
	area_flags = HIDDEN_AREA | UNIQUE_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED | NOTELEPORT
	flags_1 = CAN_BE_DIRTY_1
	static_lighting = FALSE
	sound_environment = SOUND_ENVIRONMENT_STONEROOM
	ambientsounds = AMBIENCE_RUINS
	outdoors = TRUE

/area/overmap_encounter/planetoid
	name = "\improper Unknown Planetoid"
	sound_environment = SOUND_ENVIRONMENT_MOUNTAINS
	has_gravity = STANDARD_GRAVITY
	always_unpowered = TRUE

/area/overmap_encounter/planetoid/lava
	name = "\improper Volcanic Planetoid"
	ambientsounds = AMBIENCE_MINING

/area/overmap_encounter/planetoid/ice
	name = "\improper Frozen Planetoid"
	sound_environment = SOUND_ENVIRONMENT_CAVE
	ambientsounds = AMBIENCE_SPOOKY

/area/overmap_encounter/planetoid/sand
	name = "\improper Sandy Planetoid"
	sound_environment = SOUND_ENVIRONMENT_QUARRY
	ambientsounds = AMBIENCE_MINING

/area/overmap_encounter/planetoid/jungle
	name = "\improper Jungle Planetoid"
	sound_environment = SOUND_ENVIRONMENT_FOREST
	ambientsounds = AMBIENCE_AWAY

/area/overmap_encounter/planetoid/rockplanet
	name = "\improper Rocky Planetoid"
	sound_environment = SOUND_ENVIRONMENT_HANGAR
	ambientsounds = AMBIENCE_MAINT

/area/overmap_encounter/planetoid/rockplanet/explored//for use in ruins
	area_flags = UNIQUE_AREA
	area_flags = VALID_TERRITORY | UNIQUE_AREA
