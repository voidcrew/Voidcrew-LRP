/***********************************************
 Diagnostic HUDs!
************************************************/

/mob/living/proc/hud_set_nanite_indicator()
	var/image/holder = hud_list[NANITE_HUD]
	var/icon/I = icon(icon, icon_state, dir)
	holder.pixel_y = I.Height() - world.icon_size
	holder.icon_state = null
	if(src in SSnanites.nanite_monitored_mobs)
		holder.icon_state = "nanite_ping"
