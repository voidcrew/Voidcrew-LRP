/datum/species/squid
	// Cephalopod humanoids with squid-like features
	name = "Yuggolith"
	id = "squid"
	default_color = "#268074"
	species_traits = list(MUTCOLORS, EYECOLOR, NO_BONES)
	inherent_traits = list(TRAIT_NOSLIPALL)
	mutant_bodyparts = list("squid_face")
	default_features = list("mcolor" = "189", "squid_face" = "Squidward")
	coldmod = 0.6
	heatmod = 1.2
	burnmod = 1.4
	speedmod = 0.55
	punchdamagehigh = 8 //Tentacles make for weak noodle arms
	punchstunthreshold = 6 //Good for smacking down though
	attack_verb = "slap"
	attack_sound = 'sound/weapons/slap.ogg'
	miss_sound = 'sound/weapons/punchmiss.ogg'
	special_step_sounds = list('voidcrew/sound/effects/footstep/squid/squid1.ogg', 'voidcrew/sound/effects/footstep/squid/squid2.ogg', 'voidcrew/sound/effects/footstep/squid/squid3.ogg')
	disliked_food = JUNKFOOD
	liked_food = VEGETABLES | MEAT
	toxic_food = FRIED
	mutanttongue = /obj/item/organ/tongue/squid
	species_language_holder = /datum/language_holder/squid
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/squid
	exotic_bloodtype = "S"
	no_equip = list(ITEM_SLOT_FEET)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	loreblurb = "A race of squid-like amphibians with an odd appearance. \
	They posses the ability to change their pigmentation at will, often leading to confusion. \
	It's frequently rumored that they eat human grey matter. This is definitely, absolutely, most certainly not in any way at all true."

/datum/species/squid/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_squid_name()
	return squid_name()

/datum/species/squid/on_species_gain(mob/living/carbon/human/human, datum/species/old_species)
	. = ..()
	var/datum/action/innate/change_color/change_color = new
	//var/datum/action/cooldown/spit_ink/spit_ink = new
	change_color.Grant(human)
	//spit_ink.Grant(human)

/datum/species/squid/on_species_loss(mob/living/carbon/human/human)
	. = ..()
	fixed_mut_color = rgb(128,128,128)
	human.update_body()
	var/datum/action/innate/change_color/change_color = locate(/datum/action/innate/change_color) in human.actions
	change_color?.Remove(human)

/datum/action/innate/change_color
	name = "Change Color"
	check_flags = AB_CHECK_CONSCIOUS
	icon_icon = 'icons/mob/actions.dmi'
	button_icon_state = "squid_color"

/datum/action/innate/change_color/Activate()
	active = TRUE //Prevent promptspam
	var/mob/living/carbon/human/human_owner = owner
	var/color_choice = input(usr, "What color will you change to?", "Color Change") as null | color
	if (color_choice)
		var/temp_hsv = RGBtoHSV(color_choice)
		if (ReadHSV(temp_hsv)[3] >= ReadHSV("#191919")[3])
			human_owner.dna.species.fixed_mut_color = sanitize_hexcolor(color_choice)
			human_owner.update_body()
		else
			to_chat(usr, "<span class='danger'>Invalid color. Your color is not bright enough.</span>")
	active = FALSE

/datum/action/innate/change_color/IsAvailable()
	if(active)
		return FALSE
	return ..()
/* 	// Giving a roundstart species slip immunity, and the ability to create slips whenever is dumb
/datum/action/cooldown/spit_ink
	name = "Spit Ink"
	check_flags = AB_CHECK_CONSCIOUS | AB_CHECK_IMMOBILE
	icon_icon = 'icons/mob/actions.dmi'
	button_icon_state = "squid_ink"
	cooldown_time = 60
	var/ink_cost = 60

/datum/action/cooldown/spit_ink/Trigger() // VOID TODO this will need to be updated on TG due to the new action system
	var/mob/living/carbon/carbon_owner = owner
	var/turf/current_turf = get_turf(carbon_owner)
	if(!current_turf)
		to_chat(carbon_owner, "<span class='warning'>There's no room to spill ink here!</span>")
		return
	var/obj/effect/decal/cleanable/squid_ink/squid_ink = locate() in current_turf
	if(squid_ink)
		to_chat(carbon_owner, "<span class='warning'>There's already a puddle of ink here!</span>")
		return
	var/nutrition_threshold = NUTRITION_LEVEL_FED
	if (carbon_owner.nutrition >= nutrition_threshold)
		carbon_owner.adjust_nutrition(-ink_cost)
		playsound(carbon_owner, 'sound/effects/splat.ogg', 50, 1)
		new /obj/effect/decal/cleanable/squid_ink(current_turf, carbon_owner)
		carbon_owner.visible_message("<span class='danger'>[carbon_owner.name] sprays a puddle of slippery ink onto the floor!</span>", "<i>You spray ink all over the floor!</i>")
	else
		to_chat(carbon_owner, "<span class='warning'>You don't have enough neutrients to create ink, you need to eat!</span>")
		return
*/
#define SQUID_SPEEDMOD_GRAV 0.55
#define SQUID_SPEEDMOD_NO_GRAV 0
// Zero gravity movement
/datum/species/squid/spec_life(mob/living/carbon/human/human)
	var/area/area = get_area(human)
	speedmod = area.has_gravity ? SQUID_SPEEDMOD_GRAV : SQUID_SPEEDMOD_NO_GRAV
	..()
#undef SQUID_SPEEDMOD_GRAV
#undef SQUID_SPEEDMOD_NO_GRAV

/datum/species/squid/negates_gravity(mob/living/carbon/human/human)
	if(human.movement_type & !isspaceturf(human.loc))
		return TRUE
/world/proc/make_squid_datum_references_list()
	init_sprite_accessory_subtypes(/datum/sprite_accessory/squid_face, GLOB.squid_face_list)
