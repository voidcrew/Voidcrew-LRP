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
	unregister_all_crewmembers()

/**
 * Unregister a crewmate from the crewmembers list
 *
 * Arguments:
 * * mob/living/carbon/human/crewmate - The mob to remove from the list of crewmembers
 */
/obj/structure/overmap/ship/simulated/proc/unregister_crewmember(mob/living/carbon/human/crewmate)
	for (var/datum/weakref/member in crewmembers)
		if (crewmate == member.resolve())
			var/mob/living/carbon/human/ex_crewmate = member.resolve()
			UnregisterSignal(ex_crewmate, COMSIG_MOB_DEATH)

			remove_faction_hud(FACTION_HUD_GENERAL, ex_crewmate)
			var/datum/mind/ex_crewmate_mind = ex_crewmate.mind
			var/datum/antagonist/to_remove = ex_crewmate_mind?.has_antag_datum(source_template?.antag_datum)
			if (!isnull(to_remove))
				ex_crewmate_mind.remove_antag_datum(to_remove)

			member = null

/**
 * Unregister ALL crewmates from the ship
 */
/obj/structure/overmap/ship/simulated/proc/unregister_all_crewmembers()
	for (var/datum/weakref/member in crewmembers)
		if (isnull(member.resolve()))
			member = null
			continue
		unregister_crewmember(member.resolve())
	crewmembers = list()

/**
 * Register a crewmate to the crewmembers list
 *
 * Arguments:
 * * mob/living/carbon/human/crewmate - The mob to add to the list of crewmembers
 */
/obj/structure/overmap/ship/simulated/proc/register_crewmember(mob/living/carbon/human/crewmate)
	var/datum/weakref/new_cremate = WEAKREF(crewmate)
	crewmembers.Add(new_cremate)
	RegisterSignal(crewmate, COMSIG_MOB_DEATH, .proc/handle_inactive_ship)
	//Adds a faction hud to a newplayer documentation in _HELPERS/game.dm
	add_faction_hud(FACTION_HUD_GENERAL, faction_prefix, crewmate)

	if (!isnull(source_template.antag_datum))
		var/datum/antagonist/ship_datum = new source_template.antag_datum
		crewmate.mind.add_antag_datum(ship_datum)

/**
 * ##register_all_crewmembers
 *
 * Takes all of the living humans on the ship and adds them as a crewmember
 */
/obj/structure/overmap/ship/simulated/proc/register_all_crewmembers()
	var/list/humans = shuttle.get_all_humans()
	for (var/mob/living/carbon/human/human_to_add as anything in humans)
		if(isnull(human_to_add.client))
			continue
		if(is_player_in_crew(human_to_add))
			continue
		register_crewmember(human_to_add)

/**Checks for verification before being aloud to open a console or object
  * Arguments:
  * mob/living/carbon/human/crewmate - The mob being checked for access
  */
/obj/structure/overmap/ship/simulated/proc/is_player_in_crew(mob/living/carbon/human/crewmate)
	for (var/datum/weakref/member in crewmembers)
		if (crewmate == member.resolve())
			return TRUE
	return FALSE

/**
  * Bastardized version of GLOB.manifest.manifest_inject, but used per ship
  *
  */
/obj/structure/overmap/ship/simulated/proc/manifest_inject(mob/living/carbon/human/H, client/C, datum/job/human_job)
	set waitfor = FALSE
	if(H.mind && (H.mind.assigned_role != H.mind.special_role))
		manifest[H.real_name] = human_job
	register_crewmember(H)

/**
 * Check the status of the crew
 */
/obj/structure/overmap/ship/simulated/proc/is_active_crew()
	var/is_ssd = FALSE
	for (var/datum/weakref/crewmember in crewmembers)
		var/mob/living/carbon/human/member = crewmember.resolve()
		if (isnull(member)) // this crewmate is gone
			continue
		if (shuttle.z != member.z) // different z, they don't matter anymore
			continue
		if (member.stat <= HARD_CRIT)
			if (isnull(member.client))
				is_ssd = TRUE
			else
				return SHUTTLE_ACTIVE_CREW
	if (is_ssd)
		return SHUTTLE_SSD_CREW
	return SHUTTLE_INACTIVE_CREW
