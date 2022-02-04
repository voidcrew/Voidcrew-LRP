// IPC accessories.

/datum/sprite_accessory/ipc_screens
	icon = 'voidcrew/icons/mob/ipc_accessories.dmi'
	color_src = EYECOLOR

/datum/sprite_accessory/ipc_screens/blue
	name = "Blue"
	icon_state = "blue"
	color_src = 0

/datum/sprite_accessory/ipc_screens/bsod
	name = "BSOD"
	icon_state = "bsod"
	color_src = 0

/datum/sprite_accessory/ipc_screens/breakout
	name = "Breakout"
	icon_state = "breakout"

/datum/sprite_accessory/ipc_screens/console
	name = "Console"
	icon_state = "console"

/datum/sprite_accessory/ipc_screens/ecgwave
	name = "ECG Wave"
	icon_state = "ecgwave"

/datum/sprite_accessory/ipc_screens/eight
	name = "Eight"
	icon_state = "eight"

/datum/sprite_accessory/ipc_screens/eyes
	name = "Eyes"
	icon_state = "eyes"

/datum/sprite_accessory/ipc_screens/glider
	name = "Glider"
	icon_state = "glider"

/datum/sprite_accessory/ipc_screens/goggles
	name = "Goggles"
	icon_state = "goggles"

/datum/sprite_accessory/ipc_screens/green
	name = "Green"
	icon_state = "green"

/datum/sprite_accessory/ipc_screens/heart
	name = "Heart"
	icon_state = "heart"
	color_src = 0

/datum/sprite_accessory/ipc_screens/monoeye
	name = "Mono-eye"
	icon_state = "monoeye"

/datum/sprite_accessory/ipc_screens/nature
	name = "Nature"
	icon_state = "nature"

/datum/sprite_accessory/ipc_screens/orange
	name = "Orange"
	icon_state = "orange"

/datum/sprite_accessory/ipc_screens/pink
	name = "Pink"
	icon_state = "pink"

/datum/sprite_accessory/ipc_screens/purple
	name = "Purple"
	icon_state = "purple"

/datum/sprite_accessory/ipc_screens/rainbow
	name = "Rainbow"
	icon_state = "rainbow"
	color_src = 0

/datum/sprite_accessory/ipc_screens/red
	name = "Red"
	icon_state = "red"

/datum/sprite_accessory/ipc_screens/redtext
	name = "Red Text"
	icon_state = "redtext"
	color_src = 0

/datum/sprite_accessory/ipc_screens/rgb
	name = "RGB"
	icon_state = "rgb"

/datum/sprite_accessory/ipc_screens/scroll
	name = "Scanline"
	icon_state = "scroll"

/datum/sprite_accessory/ipc_screens/shower
	name = "Shower"
	icon_state = "shower"

/datum/sprite_accessory/ipc_screens/sinewave
	name = "Sinewave"
	icon_state = "sinewave"

/datum/sprite_accessory/ipc_screens/squarewave
	name = "Square wave"
	icon_state = "squarewave"

/datum/sprite_accessory/ipc_screens/static_screen
	name = "Static"
	icon_state = "static"

/datum/sprite_accessory/ipc_screens/yellow
	name = "Yellow"
	icon_state = "yellow"

/datum/sprite_accessory/ipc_screens/textdrop
	name = "Text drop"
	icon_state = "textdrop"

/datum/sprite_accessory/ipc_screens/stars
	name = "Stars"
	icon_state = "stars"

/datum/sprite_accessory/ipc_screens/loading
	name = "Loading"
	icon_state = "loading"

/datum/sprite_accessory/ipc_screens/windowsxp
	name = "Windows XP"
	icon_state = "windowsxp"

/datum/sprite_accessory/ipc_screens/tetris
	name = "Tetris"
	icon_state = "tetris"

/datum/sprite_accessory/ipc_screens/tv
	name = "Color Test"
	icon_state = "tv"

/datum/sprite_accessory/ipc_antennas
	icon = 'voidcrew/icons/mob/ipc_accessories.dmi'
	color_src = HAIR

/datum/sprite_accessory/ipc_antennas/none
	name = "None"
	icon_state = "None"

/datum/sprite_accessory/ipc_antennas/angled
	name = "Angled"
	icon_state = "antennae"

/datum/sprite_accessory/ipc_antennas/antlers
	name = "Antlers"
	icon_state = "antlers"

/datum/sprite_accessory/ipc_antennas/crowned
	name = "Crowned"
	icon_state = "crowned"

/datum/sprite_accessory/ipc_antennas/cyberhead
	name = "Cyberhead"
	icon_state = "cyberhead"

/datum/sprite_accessory/ipc_antennas/droneeyes
	name = "Drone Eyes"
	icon_state = "droneeyes"

/datum/sprite_accessory/ipc_antennas/light
	name = "Light"
	icon_state = "light"

/datum/sprite_accessory/ipc_antennas/sidelights
	name = "Sidelights"
	icon_state = "sidelights"

/datum/sprite_accessory/ipc_antennas/tesla
	name = "Tesla"
	icon_state = "tesla"

/datum/sprite_accessory/ipc_antennas/tv
	name = "TV Antenna"
	icon_state = "tvantennae"

/datum/sprite_accessory/ipc_chassis // Used for changing limb icons, doesn't need to hold the actual icon. That's handled in ipc.dm
	icon = null
	icon_state = "who cares fuck you" // In order to pull the chassis correctly, we need AN icon_state(see line 36-39). It doesn't have to be useful, because it isn't used.
	color_src = 0

/datum/sprite_accessory/ipc_chassis/mcgreyscale
	name = "Morpheus Cyberkinetics (Custom)"
	limbs_id = "mcgipc"
	color_src = MUTCOLORS

/datum/sprite_accessory/ipc_chassis/bishopcyberkinetics
	name = "Bishop Cyberkinetics"
	limbs_id = "bshipc"

/datum/sprite_accessory/ipc_chassis/bishopcyberkinetics2
	name = "Bishop Cyberkinetics 2.0"
	limbs_id = "bs2ipc"

/datum/sprite_accessory/ipc_chassis/hephaestussindustries
	name = "Hephaestus Industries"
	limbs_id = "hsiipc"

/datum/sprite_accessory/ipc_chassis/hephaestussindustries2
	name = "Hephaestus Industries 2.0"
	limbs_id = "hi2ipc"

/datum/sprite_accessory/ipc_chassis/shellguardmunitions
	name = "Shellguard Munitions Standard Series"
	limbs_id = "sgmipc"

/datum/sprite_accessory/ipc_chassis/wardtakahashimanufacturing
	name = "Ward-Takahashi Manufacturing"
	limbs_id = "wtmipc"

/datum/sprite_accessory/ipc_chassis/xionmanufacturinggroup
	name = "Xion Manufacturing Group"
	limbs_id = "xmgipc"

/datum/sprite_accessory/ipc_chassis/xionmanufacturinggroup2
	name = "Xion Manufacturing Group 2.0"
	limbs_id = "xm2ipc"

/datum/sprite_accessory/ipc_chassis/zenghupharmaceuticals
	name = "Zeng-Hu Pharmaceuticals"
	limbs_id = "zhpipc"

// Kepori accessories
/datum/sprite_accessory/kepori_feathers
	color_src = HAIR
	icon = 'voidcrew/icons/mob/kepori_parts.dmi'

/datum/sprite_accessory/kepori_feathers/none
	name = "None"

/datum/sprite_accessory/kepori_feathers/plain
	name = "Plain"
	icon_state = "plain"

/datum/sprite_accessory/kepori_feathers/spiky
	name = "Spiky"
	icon_state = "spiky"

/datum/sprite_accessory/kepori_feathers/bushy
	name = "Bushy"
	icon_state = "bushy"

/datum/sprite_accessory/kepori_feathers/mohawk
	name = "Mohawk"
	icon_state = "mohawk"

/datum/sprite_accessory/kepori_feathers/pointy
	name = "Pointy"
	icon_state = "pointy"

/datum/sprite_accessory/kepori_feathers/upright
	name = "Upright"
	icon_state = "upright"

/datum/sprite_accessory/kepori_feathers/mane
	name = "Mane"
	icon_state = "mane"

/datum/sprite_accessory/kepori_feathers/droopy
	name = "Droopy"
	icon_state = "droopy"

/datum/sprite_accessory/kepori_feathers/mushroom
	name = "Mushroom"
	icon_state = "mushroom"

/datum/sprite_accessory/kepori_feathers/backstrafe
	name = "Backstrafe"
	icon_state = "backstrafe"

/datum/sprite_accessory/kepori_feathers/longway
	name = "Longway"
	icon_state = "longway"

/datum/sprite_accessory/kepori_feathers/tree
	name = "Tree"
	icon_state = "tree"

/datum/sprite_accessory/kepori_feathers/thin_mohawk
	name = "Thin Mohawk"
	icon_state = "thinmohawk"

/datum/sprite_accessory/kepori_feathers/twies
	name = "Twies"
	icon_state = "twies"

/datum/sprite_accessory/kepori_feathers/thin
	name = "Thin"
	icon_state = "thin"

/datum/sprite_accessory/kepori_body_feathers
	color_src = FACEHAIR
	icon = 'voidcrew/icons/mob/kepori_parts.dmi'

/datum/sprite_accessory/kepori_body_feathers/plain
	name = "Plain"
	icon_state = "plain"

/datum/sprite_accessory/kepori_body_feathers/none
	name = "None"

//Squids
/datum/sprite_accessory/squid_face
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/squid_face/squidward
	name = "Squidward"
	icon_state = "squidward"

/datum/sprite_accessory/squid_face/illithid
	name = "Illithid"
	icon_state = "illithid"

/datum/sprite_accessory/squid_face/freaky
	name = "Freaky"
	icon_state = "freaky"

/datum/sprite_accessory/squid_face/grabbers
	name = "Grabbers"
	icon_state = "grabbers"
