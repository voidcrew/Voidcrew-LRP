#define WHITESANDS_PLANET_ATMOS "ws_atmos"

/datum/atmosphere/whitesands
	id = WHITESANDS_PLANET_ATMOS

	base_gases = list (
		/datum/gas/oxygen = 5,
		/datum/gas/nitrogen = 10,
	)
	normal_gases = list(
		/datum/gas/oxygen = 10,
		/datum/gas/nitrogen = 10,
		/datum/gas/carbon_dioxide = 10,
	)
	restricted_gases = list(
		/datum/gas/plasma = 0.1,
		/datum/gas/water_vapor = 0.1
	)
	restricted_chance = 50

	minimum_pressure = HAZARD_LOW_PRESSURE + 10
	maximum_pressure = LAVALAND_EQUIPMENT_EFFECT_PRESSURE - 1

	minimum_temp = 180
	maximum_temp = 180
