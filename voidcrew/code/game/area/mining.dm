/**********************Jungle Planet Areas**************************/

/area/jungleplanet
	icon_state = "mining"
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	area_flags = VALID_TERRITORY | UNIQUE_AREA | FLORA_ALLOWED
	sound_environment = SOUND_ENVIRONMENT_FOREST

/area/jungleplanet/surface
	name = "\improper Jungle Planetoid"
	icon_state = "explored"
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	ambientsounds = AWAY_MISSION
	poweralm = FALSE
	area_flags = UNIQUE_AREA | FLORA_ALLOWED

/area/jungleplanet/surface/outdoors // weather happens here
	name = "\improper Jungle Planetoid"
	icon_state = "away1"
	outdoors = TRUE



/**********************Beach Planet Areas**************************/

/area/beachplanet
	icon_state = "mining"
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	area_flags = VALID_TERRITORY | UNIQUE_AREA | FLORA_ALLOWED
	sound_environment = SOUND_ENVIRONMENT_FOREST

/area/beachplanet/surface
	name = "\improper Beach Planetoid"
	icon_state = "explored"
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	ambientsounds = BEACH
	poweralm = FALSE
	area_flags = UNIQUE_AREA | FLORA_ALLOWED

/area/beachplanet/surface/outdoors // weather happens here
	name = "\improper Beach Planetoid"
	icon_state = "away1"
	outdoors = TRUE



/**********************Wasteland Planet Areas**************************/

/area/wastelandplanet
	icon_state = "mining"
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	area_flags = VALID_TERRITORY | UNIQUE_AREA | FLORA_ALLOWED
	sound_environment = SOUND_ENVIRONMENT_MOUNTAINS

/area/wastelandplanet/surface
	name = "\improper Apocalyptic Planetoid"
	icon_state = "explored"
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	ambientsounds = MINING
	poweralm = FALSE
	area_flags = UNIQUE_AREA | FLORA_ALLOWED

/area/wastelandplanet/surface/outdoors // weather happens here
	name = "\improper Apocalyptic Planetoid"
	icon_state = "away1"
	outdoors = TRUE
