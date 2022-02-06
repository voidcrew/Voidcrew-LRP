// This file contains code for the same path as simulated.dm has, but this is focused on more data-specific variables
// such as job slots, bank accounts, and manifest data.
#define INACTIVE_CREW 0
#define SSD_CREW 1
#define ACTIVE_CREW 2

#define CHECK_CREW_SSD 10 MINUTES
#define SHIP_RUIN 10 MINUTES
#define SHIP_DELETE 2 MINUTES

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
	// clear all the weakrefs and unreg signals
	for (var/datum/weakref/member in crewmembers)
		UnregisterSignal(member.resolve(), COMSIG_MOB_DEATH)
		member = null

/**
 * Check the status of the crew
 */
/obj/structure/overmap/ship/simulated/proc/is_active_crew()
	var/is_ssd = FALSE
	for (var/datum/weakref/crewmember in crewmembers)
		var/mob/living/carbon/human/member = crewmember.resolve()
		if (member.stat <= HARD_CRIT)
			if (isnull(member.client))
				is_ssd = TRUE
			else
				return ACTIVE_CREW
	if (is_ssd)
		return SSD_CREW
	return INACTIVE_CREW

/**
 * Decides what to do when a crew member dies, as long as there are live (whilst not SSD) crewmembers nothing will happen
 */
/obj/structure/overmap/ship/simulated/proc/handle_inactive_ship()
	SIGNAL_HANDLER

	switch (is_active_crew())
		if (ACTIVE_CREW)
			return
		if (SSD_CREW)
			addtimer(CALLBACK(src, .proc/finalize_inactive_ship, TRUE), CHECK_CREW_SSD)
		if (INACTIVE_CREW)
			finalize_inactive_ship()

/**
 * Go through the different statuses of the ship, and choose the proper deletion method of the ship
 *
 * Arguments:
 * * ssd_check - Should we double check if theres a crewmember that is SSD
 */
/obj/structure/overmap/ship/simulated/proc/finalize_inactive_ship(ssd_check = FALSE)
	if (ssd_check && (is_active_crew() == ACTIVE_CREW))
		return // ssd guy came back

	switch (state)
		if (OVERMAP_SHIP_FLYING)
			addtimer(CALLBACK(src, .proc/destroy_ship), SHIP_DELETE)
		if (OVERMAP_SHIP_UNDOCKING)
			addtimer(CALLBACK(src, .proc/destroy_ship), SHIP_DELETE)
		if (OVERMAP_SHIP_ACTING)
			// delete it because this is somewhat ambiguous (but they are technically flying here)
			destroy_ship()
		if (OVERMAP_SHIP_IDLE)
			addtimer(CALLBACK(shuttle, /obj/docking_port/mobile/.proc/mothball), SHIP_RUIN)
		if (OVERMAP_SHIP_DOCKING)
			addtimer(CALLBACK(shuttle, /obj/docking_port/mobile/.proc/mothball), SHIP_RUIN)

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
	RegisterSignal(H, COMSIG_MOB_DEATH, .proc/handle_inactive_ship)

#undef INACTIVE_CREW
#undef SSD_CREW
#undef ACTIVE_CREW

#undef CHECK_CREW_SSD
#undef SHIP_RUIN
#undef SHIP_DELETE
