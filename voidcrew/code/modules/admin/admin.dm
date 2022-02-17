/datum/admins/proc/togglepurchasing()
	set category = "Server"
	set desc="People can't purchase ships"
	set name="Toggle Ship Purchasing"
	GLOB.ship_buying = !( GLOB.ship_buying )
	if (!( GLOB.ship_buying ))
		to_chat(world, "<B>New players may no longer purchase new ships.</B>", confidential = TRUE)
	else
		to_chat(world, "<B>New players may now purchase new ships.</B>", confidential = TRUE)
	log_admin("[key_name(usr)] toggled ship purchasing.")
	message_admins("<span class='adminnotice'>[key_name_admin(usr)] toggled ship purchasing.</span>")
	world.update_status()
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Ship Purchasing", "[GLOB.ship_buying ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
