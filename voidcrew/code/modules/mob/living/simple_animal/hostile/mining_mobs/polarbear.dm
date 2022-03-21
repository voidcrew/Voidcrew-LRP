// Elite bear
/mob/living/simple_animal/hostile/asteroid/polarbear/warrior
	name = "polar warbear"
	desc = "An aggressive animal that defends its territory with incredible power. This one appears to be a remnant of the short-lived Wojtek-Aleph program."
	melee_damage_lower = 35
	melee_damage_upper = 35
	attack_verb_continuous = "CQB's"
	attack_verb_simple = "CQB"
	speed = 7
	move_to_delay = 7
	maxHealth = 300
	health = 300
	obj_damage = 60
	icon_state = "warbear"
	icon_living = "warbear"
	icon_dead = "warbear_dead"
	crusher_loot = /obj/item/crusher_trophy/war_paw
	crusher_drop_mod = 75
	butcher_results = list(/obj/item/food/meat/slab/bear = 3, /obj/item/stack/sheet/bone = 2, /obj/item/stack/sheet/animalhide/goliath_hide/polar_bear_hide = 3)
	guaranteed_butcher_results = list(/obj/item/stack/sheet/animalhide/goliath_hide/polar_bear_hide = 3, /obj/item/bear_armor = 1)

/obj/item/crusher_trophy/war_paw
	name = "Armored bear paw"
	desc = "It's a paw from a true warrior. Still remembers the basics of CQB."
	icon_state = "armor_paw"
	icon ='voidcrew/icons/obj/lavaland/elite_trophies.dmi'
	denied_type = /obj/item/crusher_trophy/war_paw

/obj/item/crusher_trophy/war_paw/effect_desc()
	return "doubled strikes when below 70% health"

/obj/item/crusher_trophy/war_paw/on_mark_detonation(mob/living/target, mob/living/user)
	if(user.health / user.maxHealth > 0.7)
		return
	var/obj/item/I = user.get_active_held_item()
	if(!I)
		return
	I.melee_attack_chain(user, target, null)

/mob/living/simple_animal/hostile/asteroid/polarbear/random/Initialize()
	. = ..()
	if(prob(15))
		new /mob/living/simple_animal/hostile/asteroid/polarbear/warrior(loc)
		return INITIALIZE_HINT_QDEL