/**********************Lava Planet Areas**************************/

/area/lavaplanet
	icon_state = "mining"
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	area_flags = VALID_TERRITORY | UNIQUE_AREA | FLORA_ALLOWED
	sound_environment = SOUND_ENVIRONMENT_MOUNTAINS

/area/lavaplanet/surface
	name = "\improper Volcanic Planetoid"
	icon_state = "explored"
	always_unpowered = TRUE
	poweralm = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	ambientsounds = MINING

/area/lavaplanet/underground
	name = "\improper Volcanic Planetoid"
	icon_state = "unexplored"
	always_unpowered = TRUE
	requires_power = TRUE
	poweralm = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	ambientsounds = MINING


/area/lavaplanet/surface/outdoors
	name = "\improper Volcanic Planetoid"
	icon_state = "away1"
	outdoors = TRUE



/**********************Ice Planet Areas**************************/

/area/iceplanet
	icon_state = "mining"
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	area_flags = UNIQUE_AREA | FLORA_ALLOWED
	sound_environment = SOUND_ENVIRONMENT_CAVE

/area/iceplanet/surface
	name = "\improper Frozen Planetoid"
	icon_state = "explored"
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	ambientsounds = MINING
	poweralm = FALSE
	area_flags = UNIQUE_AREA | FLORA_ALLOWED

/area/iceplanet/surface/outdoors // weather happens here
	name = "\improper Frozen Planetoid"
	icon_state = "away1"
	outdoors = TRUE



/**********************Jungle Planet Areas**************************/

/area/jungleplanet
	icon_state = "mining"
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	area_flags = VALID_TERRITORY | UNIQUE_AREA | FLORA_ALLOWED
	sound_environment = SOUND_ENVIRONMENT_MOUNTAINS

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
	sound_environment = SOUND_ENVIRONMENT_MOUNTAINS

/area/beachplanet/surface
	name = "\improper Oceanic Planetoid"
	icon_state = "explored"
	always_unpowered = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	ambientsounds = AWAY_MISSION
	poweralm = FALSE
	area_flags = UNIQUE_AREA | FLORA_ALLOWED

/area/beachplanet/surface/outdoors // weather happens here
	name = "\improper Oceanic Planetoid"
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
	ambientsounds = AWAY_MISSION
	poweralm = FALSE
	area_flags = UNIQUE_AREA | FLORA_ALLOWED

/area/wastelandplanet/surface/outdoors // weather happens here
	name = "\improper Apocalyptic Planetoid"
	icon_state = "away1"
	outdoors = TRUE
