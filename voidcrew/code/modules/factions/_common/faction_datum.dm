
/datum/faction
	///The group the hud resides in lets users in the same group view eachother
	var/faction_hud_type
	///name of the hud also the name of the hud icon
	var/faction_hud_name

/**
  *Called when you want to add the faction hud to a user
  *ARGUEMENTS:
  * faction_hud_type -> the group you want the faction to be a part of default is FACTION_HUD_GENERAL, this controls what mobs can see which huds
  *	faction_hud_name -> the icon name of the faction is set to be the faction prefix by default, this controls what image is displayed to the users
  *	mob/living/mob_override -> the mob in question that you want the hud to be applied to
  */
/proc/add_faction_hud(faction_hud_type, faction_hud_name, mob/living/mob_override)
	var/datum/atom_hud/faction/hud = GLOB.huds[faction_hud_type]
	hud.join_hud(mob_override)
	set_faction_hud(mob_override, faction_hud_name)
/**
  *Called when you want to remove a faction hud from a user. Needed to replace the hud nicely
  *ARGUEMENTS:
  *	faction_hud_type -> the group you want the faction to be a part of default is FACTION_HUD_GENERAL, this controls what huds are removed from the player if multiple groups are present
  *	mob/living/mob_override -> the mob in question that you want the hud to be removed from
  */
/proc/remove_faction_hud(faction_hud_type, mob/living/mob_override)
	var/datum/atom_hud/faction/hud = GLOB.huds[faction_hud_type]
	hud.leave_hud(mob_override)
	set_faction_hud(mob_override, null)
