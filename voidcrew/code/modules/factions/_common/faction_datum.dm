
/datum/faction
	var/antag_hud_type
	var/antag_hud_name

/datum/faction/proc/apply_innate_effects(mob/living/mob_override)
	return
/proc/add_faction_hud(faction_hud_type, faction_hud_name, mob/living/mob_override)
	var/datum/atom_hud/faction/hud = GLOB.huds[faction_hud_type]
	hud.join_hud(mob_override)
	set_faction_hud(mob_override, faction_hud_name)
