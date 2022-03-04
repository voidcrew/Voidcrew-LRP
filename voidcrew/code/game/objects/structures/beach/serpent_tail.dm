//Necropolis Tendrils, which spawn lavaland monsters and break into a chasm when killed
/obj/structure/spawner/serpent
	name = "serpent tail"
	desc = "A tail of a serpent. Terrible monsters are pouring out from all around it."
	icon = 'voidcrew/icons/mob/beach/serpent.dmi'
	faction = list("beach")
	max_mobs = 2
	spawn_time = 150
	max_integrity = 650
	mob_types = list(/mob/living/simple_animal/hostile/carp/megacarp/beach)

	move_resist = INFINITY
	anchored = TRUE
	resistance_flags = FIRE_PROOF | LAVA_PROOF

	var/gps = null

GLOBAL_LIST_INIT(serpenttails, list())
/obj/structure/spawner/serpent/Initialize()
	. = ..()
	for(var/F in RANGE_TURFS(1, src))
		if(ismineralturf(F))
			var/turf/closed/mineral/M = F
			M.ScrapeAway(null, CHANGETURF_IGNORE_AIR)
	AddComponent(/datum/component/gps, "Eerie Signal")
	GLOB.tendrils += src

/obj/structure/spawner/serpent/deconstruct(disassembled)
	new /obj/structure/closet/crate/necropolis/tendril(loc)
	return ..()


/obj/structure/spawner/serpent/Destroy()
	var/last_tendril = TRUE
	if(GLOB.tendrils.len>1)
		last_tendril = FALSE

	if(last_tendril && !(flags_1 & ADMIN_SPAWNED_1))
		if(SSachievements.achievements_enabled)
			for(var/mob/living/L in view(7,src))
				if(L.stat || !L.client)
					continue
				L.client.give_award(/datum/award/achievement/boss/tendril_exterminator, L)
				L.client.give_award(/datum/award/score/tendril_score, L) //Progresses score by one
	GLOB.tendrils -= src
	QDEL_NULL(gps)
	return ..()

/obj/structure/spawner/serpent/pirate
	mob_types = list(/mob/living/simple_animal/hostile/pirate/melee/beach, /mob/living/simple_animal/hostile/pirate/ranged/beach)
