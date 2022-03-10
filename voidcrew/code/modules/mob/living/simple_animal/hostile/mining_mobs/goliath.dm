/obj/effect/temp_visual/goliath_tentacle/crystal
	name = "crystalline spire"
	icon = 'voidcrew/icons/effects/32x64.dmi'
	icon_state = "crystal"
	wiggle = "crystal_growth"
	retract = "crystal_reduction"
	difficulty = 5

/obj/effect/temp_visual/goliath_tentacle/crystal/get_directions()
	return GLOB.cardinals.Copy() + GLOB.diagonals.Copy()

/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient/crystal
	name = "crystal goliath"
	desc = "Once a goliath, it is now an abomination composed of undead flesh and crystals that sprout throughout it's decomposing body."
	icon = 'voidcrew/icons/mob/lavaland/lavaland_monsters.dmi'
	icon_state = "crystal_goliath"
	icon_living = "crystal_goliath"
	icon_aggro = "crystal_goliath"
	icon_dead = "crystal_goliath_dead"
	throw_message = "does nothing to the tough hide of the"
	pre_attack_icon = "crystal_goliath2"
	butcher_results = list(/obj/item/food/meat/slab/goliath = 2, /obj/item/stack/sheet/bone = 2, /obj/item/stack/sheet/sinew = 2, /obj/item/stack/ore/silver = 10, /obj/item/strange_crystal = 2)
	/// VC MOB TODO: Look into how to reimplement this
	//tentacle_type = /obj/effect/temp_visual/goliath_tentacle/crystal
	tentacle_recheck_cooldown = 50
	speed = 2
	/// VC MOB TODO
	//can_charge = FALSE

/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient/crystal/OpenFire()
	. = ..()
	visible_message("<span class='warning'>[src] expels it's matter, releasing a spray of crystalline shards!</span>")
	INVOKE_ASYNC(src,.proc/spray_of_crystals)
	/// VC MOB TODO: Figure out what this got changed to
	//shoot_projectile(Get_Angle(src,target) + 10)
	//shoot_projectile(Get_Angle(src,target))
	//shoot_projectile(Get_Angle(src,target) - 10)

/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient/crystal/proc/spray_of_crystals()
	for(var/i in 0 to 9)
		shoot_projectile(i*(180/NUM_E))
		sleep(3)

/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient/crystal/proc/shoot_projectile(angle)
	var/obj/projectile/P = new /obj/projectile/goliath(get_turf(src))
	P.preparePixelProjectile(get_step(src, pick(GLOB.alldirs)), get_turf(src))
	P.firer = src
	P.fire(angle)

/obj/projectile/goliath
	name = "Crystalline Shard"
	icon_state = "crystal_shard"
	damage = 25
	damage_type = BRUTE
	speed = 3

/obj/projectile/goliath/on_hit(atom/target, blocked)
	. = ..()
	var/turf/turf_hit = get_turf(target)
	new /obj/effect/temp_visual/goliath_tentacle/crystal(turf_hit,firer)

/obj/projectile/goliath/can_hit_target(atom/target, list/passthrough, direct_target, ignore_loc)
	if(istype(target,/mob/living/simple_animal/hostile/asteroid))
		return FALSE
	return ..()