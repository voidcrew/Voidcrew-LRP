/*

Heres the kinda plan


Create a new signal, send it on assembly holder when it sends recieve signal
accept it on here, and detonate



*/


/datum/component/plastic
	///The original explosive :(
	var/obj/explosive

	var/mutable_appearance/overlay

	var/atom/target //maybe this should be a weakref?

	var/detonate_time

	var/detonate_timer

	var/boom_sizes
	///Some C4 subtypes have specific detonation conditions
	var/pre_detonate_callback

	var/full_damage_on_mobs // what is this even used for? NOVA TODO CHECK

	var/aim_dir = NORTH
	///Should the charge direct its explosion?
	var/directional = FALSE

/datum/component/plastic/Initialize(overlay, detonate_time, boom_sizes, aim_dir, directional)
	. = ..()

	target = parent

	src.overlay = overlay
	src.detonate_time = detonate_time
	src.boom_sizes = boom_sizes
	src.aim_dir = aim_dir
	src.directional = directional

	if (src.overlay)
		target.add_overlay(overlay)

	RegisterSignal(parent, COMSIG_PARENT_QDELETING, .proc/Destroy)
	RegisterSignal(explosive, COMSIG_ASSEMBLY_HOLDER_ACTIVATE, .proc/detonate)

	pre_detonate()

/datum/component/plastic/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, COMSIG_PARENT_QDELETING)
	UnregisterSignal(explosive, COMSIG_ASSEMBLY_HOLDER_ACTIVATE)

/datum/component/plastic/Destroy(force, silent)
	. = ..()
	target = null

	if (!isnull(detonate_timer))
		deltimer(detonate_timer) // delete bxuz
	if (src.overlay)
		target.cut_overlay(overlay)

/datum/component/plastic/proc/pre_detonate()
	detonate_timer = addtimer(CALLBACK(src, .proc/detonate), detonate_time, TIMER_STOPPABLE)

/datum/component/plastic/proc/detonate()
	//NOVA TODO: fix up this proc
	detonate_timer = null
	var/turf/location = get_turf(target)

	if (!ismob(target) || full_damage_on_mobs)
		EX_ACT(target, EXPLODE_HEAVY, target)

	if (location)
		if(directional && target?.density)
			var/turf/turf = get_step(location, aim_dir)
			explosion(get_step(turf, aim_dir), devastation_range = boom_sizes[1], heavy_impact_range = boom_sizes[2], light_impact_range = boom_sizes[3], explosion_cause = src)
		else
			explosion(location, devastation_range = boom_sizes[1], heavy_impact_range = boom_sizes[2], light_impact_range = boom_sizes[3], explosion_cause = src)
	qdel(src)
	qdel(explosive)
