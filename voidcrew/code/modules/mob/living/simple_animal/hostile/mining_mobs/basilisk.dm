/obj/projectile/temp/basilisk/super
	temperature = -100
	damage = 5
	nodamage = FALSE

/obj/projectile/temp/basilisk/super/on_hit(atom/target, blocked)
	. = ..()
	if(isliving(target))
		var/mob/living/living_target = target
		living_target.Jitter(5)

/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/forgotten
	name = "forgotten watcher"
	desc = "This watcher has a cancerous crystal growth on it, forever scarring it and deforming it into this twisted form."
	icon = 'voidcrew/icons/mob/lavaland/watcher.dmi'
	icon_state = "forgotten"
	icon_living = "forgotten"
	icon_aggro = "forgotten"
	icon_dead = "forgotten_dead"
	aggro_vision_range = 10
	vision_range = 5
	maxHealth = 250
	health = 250
	melee_damage_lower = 25
	melee_damage_upper = 25
	speed = 1
	projectiletype = /obj/projectile/temp/basilisk/super
	ranged_cooldown_time = 10
	butcher_results = list(/obj/item/stack/ore/diamond = 2, /obj/item/stack/sheet/sinew = 2, /obj/item/stack/sheet/bone = 1, /obj/item/strange_crystal = 1)
