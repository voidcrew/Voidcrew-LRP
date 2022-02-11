/mob/dead/new_player/LateChoices()
//	. = ..() // We do not call parent here, we're using our own custom latejoin settings
	var/list/shuttle_choices = list("Purchase ship..." = "Purchase") //Dummy for purchase option

	for(var/obj/structure/overmap/ship/simulated/S as anything in SSovermap.simulated_ships)
		if(isnull(S.shuttle))
			continue
		if((length(S.shuttle.spawn_points) < 1) || !S.join_allowed)
			continue
		shuttle_choices[S.name + " ([S.source_template.short_name ? S.source_template.short_name : "Unknown-class"])"] = S //Try to get the class name

	var/obj/structure/overmap/ship/simulated/selected_ship = shuttle_choices[tgui_input_list(src, "Select ship to spawn on.", "Welcome, [client?.prefs.real_name || "User"].", shuttle_choices)]
	if(!selected_ship)
		return

	if(selected_ship == "Purchase")
		usr.client.list_ship_parts()
		var/datum/map_template/shuttle/template = SSmapping.ship_purchase_list[tgui_input_list(src, "Please select ship to purchase!", "Welcome, [client.prefs.real_name].", SSmapping.ship_purchase_list)]
		if(!template)
			return LateChoices()
		if(!usr.client.get_ship_parts(template.prefix, template.parts_needed, template.ship_level))
			alert(src, "You lack the parts needed to build this ship! (Required: \
				[template.parts_needed][template.prefix == FACTION_NEUTRAL ? " [template.ship_level]" : ""] [template.prefix] parts)")
			return
		if(template.limit)
			var/count = 0
			for(var/obj/structure/overmap/ship/simulated/all_simulated_ships in SSovermap.simulated_ships)
				if(all_simulated_ships.source_template != template)
					continue
				count++
				if(template.limit <= count)
					alert(src, "The ship limit of [template.limit] has been reached this round.")
					return
		to_chat(usr, "<span class='danger'>Your [template.name] is being prepared. Please be patient!</span>")
		var/obj/docking_port/mobile/target = SSshuttle.load_template(template)
		if(!istype(target))
			to_chat(usr, "<span class='danger'>There was an error loading the ship (You have not been charged). Please contact admins!</span>")
			new_player_panel() // :middle_finger:
			return
		usr.client.remove_ship_cost(template.prefix, template.parts_needed, template.ship_level)
		SSblackbox.record_feedback("tally", "ship_purchased", 1, template.name) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
		if(!AttemptLateSpawn(target.current_ship.job_slots[1], target.current_ship)) //Try to spawn as the first listed job in the job slots (usually captain)
			to_chat(usr, "<span class='danger'>Ship spawned, but you were unable to be spawned. You can likely try to spawn in the ship through joining normally, but if not, please contact an admin.</span>")
			new_player_panel()
		return

	if(selected_ship.memo)
		var/memo_accept = tgui_alert(src, "Current ship memo: [selected_ship.memo]", "[selected_ship.name] Memo", list("OK", "Cancel"))
		if(memo_accept != "OK")
			return LateChoices() //Send them back to shuttle selection

	var/list/job_choices = list()
	for(var/datum/job/job as anything in selected_ship.job_slots)
		if(selected_ship.job_slots[job] < 1)
			continue
		job_choices["[job.title] ([selected_ship.job_slots[job]] positions)"] = job

	if(!length(job_choices))
		to_chat(usr, "<span class='danger'>There are no jobs available on this ship!</span>")
		return LateChoices() //Send them back to shuttle selection

	var/datum/job/selected_job = job_choices[tgui_input_list(src, "Select job.", "Welcome, [client.prefs.real_name].", job_choices)]
	if(!selected_job)
		return LateChoices() //Send them back to shuttle selection

	if(!SSticker?.IsRoundInProgress())
		to_chat(usr, "<span class='danger'>The round is either not ready, or has already finished...</span>")
		return

	if(!GLOB.enter_allowed)
		to_chat(usr, "<span class='notice'>There is an administrative lock on entering the game!</span>")
		return

	var/relevant_cap
	var/hpc = CONFIG_GET(number/hard_popcap)
	var/epc = CONFIG_GET(number/extreme_popcap)
	if(hpc && epc)
		relevant_cap = min(hpc, epc)
	else
		relevant_cap = max(hpc, epc)

	if(SSticker.queued_players.len && !(ckey(key) in GLOB.admin_datums))
		if((living_player_count() >= relevant_cap) || (src != SSticker.queued_players[1]))
			to_chat(usr, "<span class='warning'>Server is full.</span>")

	AttemptLateSpawn(selected_job, selected_ship)
