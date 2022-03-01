/datum/revamped_biome/wasteland
	open_turf_types = list(/turf/open/floor/plating/wasteland/lit = 1)
	flora_spawn_list = list(
		/obj/structure/flora/rock/asteroid = 15,
		/obj/structure/flora/tree/dead/tall = 1,
		/obj/structure/flora/rock = 1,
		/obj/structure/flora/ash/cacti = 2,
	)
	flora_spawn_chance = 5
	feature_spawn_list = list(
		/obj/item/storage/firstaid = 10,
		/obj/item/bodypart/r_arm/robot = 10,
		/obj/item/assembly/prox_sensor = 10,
		/obj/item/healthanalyzer = 10,
		/obj/effect/mine/explosive = 2,
		/obj/structure/geyser/random = 1,
		/obj/item/shard = 10,
		/obj/item/stack/cable_coil/cut = 10,
		/obj/item/stack/rods = 10
	)
	feature_spawn_chance = 1

/datum/revamped_biome/wasteland/plains
	open_turf_types = list(/turf/open/floor/plating/dust/lit = 1)
	flora_spawn_list = list(/obj/structure/flora/deadgrass/tall = 50, /obj/structure/flora/deadgrass/tall/dense = 5, /obj/structure/flora/rock = 1)
	flora_spawn_chance = 45

/datum/revamped_biome/wasteland/forest
	open_turf_types = list(/turf/open/floor/plating/dirt/dry/lit = 1)
	flora_spawn_list = list(/obj/structure/flora/tree/dead/tall = 10, /obj/structure/flora/branches = 20, /obj/structure/flora/deadgrass = 30, /obj/structure/flora/tree/stonepine = 1)
	flora_spawn_chance = 25

/datum/revamped_biome/nuclear
	open_turf_types = list(/turf/open/floor/plating/sand = 5, /turf/open/floor/plating/sand/dark = 1)
	feature_spawn_chance = 1
	feature_spawn_list = list(
		/obj/structure/radioactive = 1,
		/obj/structure/radioactive/stack = 1,
		/obj/structure/radioactive/waste = 1,
		/obj/item/stack/ore/slag = 1
	)
	flora_spawn_chance = 1
	flora_spawn_list = list(/obj/structure/flora/rock = 20, /obj/effect/decal/cleanable/greenglow = 10, /obj/structure/elite_tumor = 1)

/datum/revamped_biome/ruins
	open_turf_types = list(/turf/open/floor/plating/dust/lit = 30, /turf/open/floor/plating/rust = 1)
	feature_spawn_chance = 5
	feature_spawn_list = list(
		/obj/structure/barrel/flaming = 3,
		/obj/structure/barrel = 5,
		/obj/structure/reagent_dispensers/fueltank = 3,
		/obj/item/shard = 6,
		/obj/item/stack/cable_coil/cut = 6,
		/obj/effect/mine/explosive = 1,
		/obj/item/reagent_containers/food/snacks/canned/beans = 1
	)
	flora_spawn_chance = 5
	flora_spawn_list = list(
		/obj/structure/girder = 45, /obj/structure/barricade/sandbags = 25, /obj/item/gun/ballistic/rifle/boltaction/polymer = 1, /obj/item/gun/ballistic/bow = 1
	)

/datum/revamped_biome/cave/wasteland
	open_turf_types = list(/turf/open/floor/plating/dirt/dry = 1, /turf/open/floor/plating/dust = 1)
	closed_turf_types = list(/turf/closed/mineral/random/asteroid = 1)
	flora_spawn_chance = 10
	flora_spawn_list = list(
		/obj/structure/flora/rock = 5,
		/obj/structure/flora/ash/leaf_shroom = 4,
		/obj/structure/flora/ash/cap_shroom = 4,
		/obj/structure/flora/ash/stem_shroom = 4,
		/obj/structure/flora/ash/cacti = 2,
		/obj/structure/flora/ash/tall_shroom = 4,
		/obj/structure/flora/ash/whitesands/puce = 1
	)
	feature_spawn_chance = 1
	feature_spawn_list = list(
		/obj/structure/spawner/ice_moon/demonic_portal/blobspore = 20,
		/obj/structure/spawner/ice_moon/demonic_portal/hivebot = 20,
		/obj/structure/closet/crate/grave = 40,
		/obj/structure/closet/crate/grave/lead_researcher = 20,
		/obj/item/pickaxe/rusted = 40,
		/obj/item/pickaxe/diamond = 1,
		/obj/item/shovel/serrated = 30,
		/obj/structure/radioactive = 30,
		/obj/structure/radioactive/stack = 50,
		/obj/structure/radioactive/waste = 50,
		/obj/item/stack/ore/slag = 60
	)

/datum/revamped_biome/cave/rubble
	open_turf_types = list(/turf/open/floor/plating/rubble = 1, /turf/open/floor/plating/tunnel = 6)
	closed_turf_types = list(/turf/closed/wall/r_wall/rust = 1, /turf/closed/wall/rust = 4, /turf/closed/mineral/random/asteroid = 10)
	feature_spawn_list = list(
		/obj/effect/spawner/lootdrop/maintenance = 10,
		/obj/item/stack/rods = 5,
		/obj/structure/closet/crate/secure/loot = 1,
		/obj/structure/spawner/mining = 1,
		/obj/structure/barrel/flaming = 1,
		/obj/structure/reagent_dispensers/fueltank = 1,
		/obj/structure/girder = 1,
		/obj/item/shard = 1,
		/obj/item/stack/cable_coil/cut = 1,
		/obj/effect/mine/explosive = 1,
		/obj/item/ammo_casing/caseless/arrow/bone = 1,
		/obj/item/gun/ballistic/bow = 1,
	)
	feature_spawn_chance = 5
	flora_spawn_list = list(/obj/structure/flora/rock = 1)
	flora_spawn_chance = 1

/datum/revamped_biome/cave/mossy_stone
	open_turf_types = list(/turf/open/floor/plating/mossy_stone = 1)
	feature_spawn_list = list(
		/obj/effect/decal/cleanable/greenglow = 30,
		/obj/machinery/portable_atmospherics/canister/toxins = 15,
		/obj/machinery/portable_atmospherics/canister/miasma = 15,
		/obj/machinery/portable_atmospherics/canister/carbon_dioxide = 15,
		/obj/structure/barrel/flaming = 20,
		/obj/structure/geyser/random = 1,
		/obj/structure/spawner/mining = 1,
		/obj/item/gun/ballistic/shotgun/doublebarrel/improvised/sawn = 1
	)
	feature_spawn_chance = 5
	flora_spawn_list = list(
		/obj/structure/flora/rock = 2,
		/obj/structure/flora/ash/leaf_shroom = 4,
		/obj/structure/flora/ash/cap_shroom = 4,
		/obj/structure/flora/ash/stem_shroom = 4,
	)
	flora_spawn_chance = 1
