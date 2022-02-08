
/datum/faction
	var/faction_hud_type
	var/faction_hud_name

/datum/faction/proc/apply_innate_effects(mob/living/mob_override)
	return
/proc/add_faction_hud(faction_hud_type, faction_hud_name, mob/living/mob_override)
	var/datum/atom_hud/faction/hud = GLOB.huds[faction_hud_type]
	hud.join_hud(mob_override)
	set_faction_hud(mob_override, faction_hud_name)

/proc/remove_faction_hud(faction_hud_type, mob/living/mob_override)
	var/datum/atom_hud/faction/hud = GLOB.huds[faction_hud_type]
	hud.leave_hud(mob_override)
	set_faction_hud(mob_override, null)
