// This file contains code for the same path as simulated.dm has, but this is focused on more data-specific variables
// such as job slots, bank accounts, and manifest data.

/obj/structure/overmap/ship/simulated
	///Assoc list of remaining open job slots (job = remaining slots)
	var/list/job_slots = list(new /datum/job/captain() = 1, new /datum/job/assistant() = 5)
	///Manifest list of people on the ship
	var/list/manifest = list()
	///Shipwide bank account
	var/datum/bank_account/ship/ship_account
	///Whether or not new players are allowed to join the ship
	var/join_allowed = TRUE
	///Short memo of the ship shown to new joins
	var/memo = ""
	///Time that next job slot change can occur
	var/job_slot_adjustment_cooldown = 0

	///List of weakrefs of all the crewmembers
	var/list/crewmembers = list()

/obj/structure/overmap/ship/simulated/Initialize(mapload, obj/docking_port/mobile/_shuttle, datum/map_template/shuttle/_source_template)
	. = ..()
	job_slots = _source_template.job_slots.Copy()
	ship_account = new(name, 7500)

/obj/structure/overmap/ship/simulated/Destroy()
	. = ..()
	// clear all the weakrefs
	for (var/datum/weakref/member in crewmembers)
		member = null

/obj/structure/overmap/ship/simulated/proc/check_delete_ship(double_check = FALSE)
	SIGNAL_HANDLER

	for (var/datum/weakref/crewmember in crewmembers)
		var/mob/living/carbon/human/member = crewmember.resolve()
		if (member.stat <= HARD_CRIT)
			if (isnull(member.client) && !double_check)
				double_check_delete_ship()
				return
			else if (isnull(member.client) && double_check) // i know that there will be an edge case where if ANOTHER person goes ssd in between the 5 minutes this will still delete but fuck you
				continue
	shuttle.jumpToNullSpace()
	qdel(src)

/obj/structure/overmap/ship/simulated/proc/double_check_delete_ship()
	addtimer(CALLBACK(.proc/check_delete_ship, TRUE), 5 MINUTES) // check back in five minutes

/**
  * Bastardized version of GLOB.manifest.manifest_inject, but used per ship
  *
  */
/obj/structure/overmap/ship/simulated/proc/manifest_inject(mob/living/carbon/human/H, client/C, datum/job/human_job)
	set waitfor = FALSE
	if(H.mind && (H.mind.assigned_role != H.mind.special_role))
		manifest[H.real_name] = human_job

	var/datum/weakref/new_cremate = WEAKREF(H)
	crewmembers.Add(new_cremate)
	RegisterSignal(H, COMSIG_MOB_DEATH, .proc/check_delete_ship)
