/**
 * //TODO see if this needs to be removed (it might be virtual zlevels)
 * ##get_areatype_turfs
 *
 * Returns a list of all turfs in ALL areas of that type in the world.
 *
 * Arguments:
 * * areatype - The type of area to search for as a text string or typepath or instance
 * * target_z - The z level to search for areas on
 * * subtypes - Whether or not areas of a subtype type are included in the results
 */
/proc/get_areatype_turfs(areatype, target_z = 0, subtypes = FALSE)
	if (istext(areatype))
		areatype = text2path(areatype)
	else if (isarea(areatype))
		var/area/areatemp = areatype
		areatype = areatemp.type
	else if (!ispath(areatype))
		return null

	var/list/turfs = list()
	if (subtypes)
		var/list/cache = typecacheof(areatype)
		for (var/sorted_area in GLOB.sortedAreas)
			var/area/area = sorted_area
			if (!cache[area.type])
				continue
			for (var/turf/turf in area)
				if (target_z == 0 || target_z == turf.z)
					turfs += turf
	else
		for (var/sorted_area in GLOB.sortedAreas)
			var/area/area = sorted_area
			if (area.type != areatype)
				continue
			for (var/turf/turf in area)
				if (target_z == 0 || target_z == turf.z)
					turfs += turf
	return turfs
