/datum/map_generator/cave_generator/rockplanet
	open_turf_types = list(/turf/open/floor/plating/asteroid/rockplanet = 50,
						/turf/open/floor/plating/rust/rockplanet = 10,
						/turf/open/floor/plating/rockplanet = 5)

	closed_turf_types =  list(/turf/closed/mineral/random/asteroid/rockplanet = 45,
							/turf/closed/wall/rust = 10,)

	mob_spawn_chance = 3
	flora_spawn_chance = 6

	mob_spawn_list = list(
		//'regular' fauna, not too difficult
		/mob/living/simple_animal/hostile/netherworld/asteroid = 50,
		/mob/living/simple_animal/hostile/asteroid/fugu/asteroid = 50,
		/mob/living/simple_animal/hostile/netherworld/migo/asteroid = 40, //mariuce
		//crystal mobs, very difficult
		/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient/crystal = 1,
		/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/forgotten = 1,
		/mob/living/simple_animal/hostile/asteroid/hivelord/legion/crystal = 1,
		/mob/living/simple_animal/hostile/bear/russian/asteroid = 15,
		/mob/living/simple_animal/hostile/blob/blobbernaut/independent/asteroid = 10,
		/mob/living/simple_animal/hostile/poison/giant_spider/tarantula/asteroid = 7,
		/obj/structure/spawner/ice_moon/demonic_portal/blobspore = 5,
		/obj/structure/spawner/ice_moon/demonic_portal/hivebot = 5)

	flora_spawn_list = list(/obj/structure/mecha_wreckage/ripley = 5,
		/obj/structure/mecha_wreckage/ripley/firefighter = 3,
		/obj/structure/mecha_wreckage/ripley/mkii = 3,
		/obj/structure/reagent_dispensers/fueltank = 30,
		/obj/structure/girder = 30,
		/obj/item/stack/ore/slag = 10,
		/obj/item/stack/rods = 10,
		/obj/item/shard = 10,
		/obj/item/stack/cable_coil/cut = 10,
		/obj/effect/spawner/lootdrop/maintenance = 30,
		/obj/effect/decal/cleanable/greenglow = 20,
		/obj/structure/closet/crate/secure/loot = 1,
		/obj/machinery/portable_atmospherics/canister/toxins = 1,
		/obj/machinery/portable_atmospherics/canister/miasma = 1,
		/obj/machinery/portable_atmospherics/canister/carbon_dioxide = 1,
		/obj/structure/radioactive = 2,
		/obj/structure/radioactive/stack = 2,
		/obj/structure/radioactive/waste = 2,
		/obj/item/storage/firstaid = 4,
		/obj/item/bodypart/r_arm/robot = 4,
		/obj/item/assembly/prox_sensor = 4,
		/obj/item/healthanalyzer = 3)
	feature_spawn_list = list(/obj/structure/geyser/random = 1, /obj/effect/mine/shrapnel/human_only = 1)

	initial_closed_chance = 45
	smoothing_iterations = 50
	birth_limit = 4
	death_limit = 3

/turf/closed/mineral/random/asteroid/rockplanet
	name = "iron rock"
	icon = 'icons/turf/mining.dmi'
	icon_state = "redrock"
	smooth_icon = 'icons/turf/walls/red_wall.dmi'
	base_icon_state = "red_wall"
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	baseturfs = /turf/open/floor/plating/asteroid/rockplanet
	turf_type = /turf/open/floor/plating/asteroid/rockplanet
	mineralSpawnChanceList = list(/obj/item/stack/ore/uranium = 7, /obj/item/stack/ore/diamond = 1, /obj/item/stack/ore/gold = 5,
		/obj/item/stack/ore/silver = 7, /obj/item/stack/ore/plasma = 15, /obj/item/stack/ore/iron = 55, /obj/item/stack/ore/titanium = 6,
		/turf/closed/mineral/gibtonite/rockplanet = 4, /obj/item/stack/ore/bluespace_crystal = 1)
	mineralChance = 30

/turf/closed/mineral/gibtonite/rockplanet
	name = "iron rock"
	icon = 'icons/turf/mining.dmi'
	icon_state = "redrock"
	smooth_icon = 'icons/turf/walls/red_wall.dmi'
	base_icon_state = "red_wall"
	baseturfs = /turf/open/floor/plating/asteroid/rockplanet
	turf_type = /turf/open/floor/plating/asteroid/rockplanet


/turf/open/floor/plating/asteroid/rockplanet
	name = "rockplanet sand"
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/asteroid/rockplanet

/turf/open/floor/plating/rockplanet
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/asteroid/rockplanet

/turf/open/floor/plating/rust/rockplanet
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/asteroid/rockplanet
