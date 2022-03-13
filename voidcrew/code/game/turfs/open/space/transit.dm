/atom/proc/throw_atom_into_space(atom/movable/moveable_atom)
	set waitfor = FALSE
	if (!moveable_atom || istype(moveable_atom, /obj/docking_port))
		return
	if (moveable_atom.loc != src)
		return
	if (iseffect(moveable_atom))
		return
	if (isliving(moveable_atom))
		var/mob/living/poor_soul = moveable_atom
		poor_soul.apply_damage_type(50, BRUTE)
		return
	qdel(moveable_atom)

/turf/open/space/transit/Initialize(mapload)
	. = ..()
	update_appearance()
	for (var/atom/movable/moveable_atom in src)
		throw_atom_into_space(moveable_atom)

/turf/open/space/transit/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if (!locate(/obj/structure/lattice) in src)
		throw_atom_into_space(arrived)
