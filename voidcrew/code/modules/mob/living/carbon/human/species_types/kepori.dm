/datum/species/kepori
	name = "\improper Kepori"
	id = SPECIES_KEPORI
	default_color = "6060FF"
	species_traits = list(MUTCOLORS, EYECOLOR, NO_UNDERWEAR)
	inherent_traits = list(TRAIT_HOLDABLE)
	mutant_bodyparts = list("kepori_feathers", "kepori_body_feathers")
	default_features = list("mcolor" = "0F0", "wings" = "None", "kepori_feathers" = "Plain", "kepori_body_feathers" = "Plain")
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/chicken
	disliked_food = GRAIN | GROSS
	liked_food = MEAT
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	loreblurb = "Kepori are a raptor-like species covered in feathers vaguely reminiscent of earth’s extinct troodontidae. They’re small and sometimes seen as weak by other species due to their hollow bones but make up for that in speed and reflexes. Those found in space usually lack a clutch, commonly known as rollaways. They tend to woop when excited, scared, or for any other reason at all."
	say_mod = "chirps"
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	species_clothing_path = 'voidcrew/icons/mob/clothing/species/kepori.dmi'
	species_eye_path = 'voidcrew/icons/mob/kepori_parts.dmi'
	offset_features = list(OFFSET_UNIFORM = list(0,0), OFFSET_ID = list(0,0), OFFSET_GLOVES = list(0,0), OFFSET_GLASSES = list(0,0), OFFSET_EARS = list(0,-4), OFFSET_SHOES = list(0,0), OFFSET_S_STORE = list(0,0), OFFSET_FACEMASK = list(0,-5), OFFSET_HEAD = list(0,-4), OFFSET_FACE = list(0,0), OFFSET_BELT = list(0,0), OFFSET_BACK = list(0,-4), OFFSET_SUIT = list(0,0), OFFSET_NECK = list(0,0), OFFSET_ACCESSORY = list(0, -4))
	punchdamagelow = 0
	punchdamagehigh = 6
	heatmod = 0.67
	coldmod = 1.5
	brutemod = 1.5
	burnmod = 1.5
	speedmod = -0.25
	bodytemp_normal = BODYTEMP_NORMAL + 30
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT + 30)
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT + 30)
	no_equip = list(ITEM_SLOT_BACK)
	mutanttongue = /obj/item/organ/tongue/kepori
	species_language_holder = /datum/language_holder/kepori

	species_chest = /obj/item/bodypart/chest/kepori
	species_head = /obj/item/bodypart/head/kepori
	species_l_arm = /obj/item/bodypart/l_arm/kepori
	species_r_arm = /obj/item/bodypart/r_arm/kepori
	species_l_leg = /obj/item/bodypart/l_leg/kepori
	species_r_leg = /obj/item/bodypart/r_leg/kepori

/datum/species/kepori/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_kepori_name()
	return kepori_name()

/datum/species/kepori/can_equip(obj/item/item, slot, disable_warning, mob/living/carbon/human/human, bypass_equip_delay_self, swap)
	if(slot == ITEM_SLOT_MASK)
		if(human.wear_mask && !swap)
			return FALSE
		if(item.w_class > WEIGHT_CLASS_SMALL)
			return FALSE
		if(!human.get_bodypart(BODY_ZONE_HEAD))
			return FALSE
		return equip_delay_self_check(item, human, bypass_equip_delay_self)
	. = ..()

#define KEPORI_TACKLE_STAM_COST 10
#define KEPORI_BASE_TACKLE_KNOCKDOWN (0.2 SECONDS)
#define KEPORI_TACKLE_RANGE 8
#define KEPORI_MIN_TACKLE_DISTANCE 1
#define KEPORI_TACKLE_SPEED 2
#define KEPORI_TACKLE_SKILL_MOD 2
/datum/species/kepori/on_species_gain(mob/living/carbon/carbon, datum/species/old_species, pref_load)
	..()
	carbon.AddComponent(/datum/component/tackler, stamina_cost = KEPORI_TACKLE_STAM_COST, base_knockdown = KEPORI_BASE_TACKLE_KNOCKDOWN, range = KEPORI_TACKLE_RANGE, speed = KEPORI_TACKLE_SPEED, skill_mod = KEPORI_TACKLE_SKILL_MOD, min_distance = KEPORI_MIN_TACKLE_DISTANCE)

#undef KEPORI_TACKLE_STAM_COST
#undef KEPORI_BASE_TACKLE_KNOCKDOWN
#undef KEPORI_TACKLE_RANGE
#undef KEPORI_MIN_TACKLE_DISTANCE
#undef KEPORI_TACKLE_SPEED
#undef KEPORI_TACKLE_SKILL_MOD

/datum/species/kepori/on_species_loss(mob/living/carbon/human/human, datum/species/new_species, pref_load)
	. = ..()
	qdel(human.GetComponent(/datum/component/tackler))

/world/proc/make_kepori_datum_references_list()
	init_sprite_accessory_subtypes(/datum/sprite_accessory/kepori_feathers, GLOB.kepori_feathers_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/kepori_body_feathers, GLOB.kepori_body_feathers_list)
