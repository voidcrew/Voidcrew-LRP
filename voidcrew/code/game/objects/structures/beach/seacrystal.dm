/obj/structure/spawner/sea_crystal
	name = "sea crystal"
	desc = "A large crystal. Terrible monsters are pouring out from all around it."
	icon = 'voidcrew/icons/obj/seacrystal.dmi'
	icon_state = "seacrystal"
	faction = list("beach")
	max_mobs = 2
	spawn_time = 10
	max_integrity = 1350
	pixel_x = -18
	pixel_y = -5
	mob_types = list(/mob/living/simple_animal/hostile/carp/megacarp/beach)
	move_resist = INFINITY
	anchored = TRUE
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	layer = FLY_LAYER
	light_color = LIGHT_COLOR_ELECTRIC_GREEN
	light_power = 1
	light_range = 4
	var/cooldown_time = 20 SECONDS
	var/newcolor = "#1302ad"

	COOLDOWN_DECLARE(summon_cooldown)

/obj/structure/spawner/sea_crystal/Initialize()
	. = ..()
	for(var/turf in RANGE_TURFS(1, src))
		if(ismineralturf(turf))
			var/turf/closed/mineral/mineral = turf
			mineral.ScrapeAway(null, CHANGETURF_IGNORE_AIR)

/obj/structure/spawner/sea_crystal/deconstruct(disassembled)
	playsound(loc,'sound/effects/tendril_destroyed.ogg', 200, FALSE, 50, TRUE, TRUE)
	new /obj/effect/temp_visual/seacrystal/sparks(loc)
	new /obj/item/sea_crystal(loc)
	return ..()

/obj/structure/spawner/sea_crystal/attackby(obj/item/I, mob/user, params)
	. = ..()
	summon_minions()

/obj/structure/spawner/sea_crystal/attack_animal(mob/living/simple_animal)
	. = ..()
	summon_minions()

/obj/structure/spawner/sea_crystal/bullet_act(obj/projectile/proj)
	. = ..()
	summon_minions()

/obj/structure/spawner/sea_crystal/proc/summon_minions()
	if(!COOLDOWN_FINISHED(src, summon_cooldown))
		return
	COOLDOWN_START(src, summon_cooldown, cooldown_time)
	crystal_power()
	var/turf/T = get_turf(src.loc)
	var/turf/X1 = get_step(T, pick(1,2))
	var/turf/X2 = get_step(T, pick(4,6))
	var/turf/X3 = get_step(T, pick(6,8))
	sleep(25)
	telegraph()
	new /obj/effect/temp_visual/seacrystal/sparks(X1)
	new /obj/effect/temp_visual/seacrystal/sparks(X2)
	new /obj/effect/temp_visual/seacrystal/sparks(X3)
	playsound(src.loc,'sound/magic/exit_blood.ogg', 200, 1)
	new /obj/effect/temp_visual/seacrystal/jaunt(X1)
	new /obj/effect/temp_visual/seacrystal/jaunt(X2)
	new /obj/effect/temp_visual/seacrystal/jaunt(X3)
	sleep(10)
	new /mob/living/simple_animal/hostile/asteroid/hivelord/beach(X1)
	new /mob/living/simple_animal/hostile/asteroid/hivelord/beach(X2)
	new /mob/living/simple_animal/hostile/asteroid/hivelord/beach(X3)
	crystal_depower()

/obj/structure/spawner/sea_crystal/proc/crystal_power()
	playsound(src.loc, 'sound/magic/clockwork/narsie_attack.ogg', 200, TRUE)
	src.add_atom_colour(newcolor, TEMPORARY_COLOUR_PRIORITY)
	for (var/i in 1 to 8)
		new /obj/effect/temp_visual/seacrystal/sparks(get_step(src.loc, i))

/obj/structure/spawner/sea_crystal/proc/crystal_depower()
	src.remove_atom_colour(TEMPORARY_COLOUR_PRIORITY, newcolor)

/obj/structure/spawner/sea_crystal/proc/telegraph()
	for(var/mob/mob in range(10,src.loc))
		if(mob.client)
			shake_camera(mob, 2, 1)

/obj/item/sea_crystal
	name = "sea crystal"
	desc = "A small crystalline object, it pulses in sync with the waves. You feel compelled to use it..."
	icon = 'whitesands/icons/obj/lavaland/newlavalandplants.dmi'
	icon_state = "unnamed_crystal"
	color = COLOR_DARK_CYAN

/obj/item/sea_crystal/attack_self(mob/living/carbon/human/user)
	if(!istype(user))
		return
	to_chat(user, "<span class='danger'>Power courses through you! You can now shift your form at will.</span>")
	if(user.mind)
		var/obj/effect/proc_holder/spell/targeted/shapeshift/sea_crystal/crystal = new
		user.mind.AddSpell(crystal)
	playsound(user.loc, 'sound/effects/glassbr1.ogg', 100, TRUE)
	qdel(src)
