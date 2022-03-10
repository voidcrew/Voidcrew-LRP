GLOBAL_LIST_INIT(ws_survivor_default_loot, list(
	/obj/item/stack/sheet/animalhide/goliath_hide = 0.7,
	/obj/item/stack/sheet/bone = 0.8,
	/obj/item/reagent_containers/food/drinks/waterbottle = 0.2,
	/obj/item/reagent_containers/food/drinks/waterbottle/empty = 0.8,
	/obj/item/storage/firstaid/ancient/heirloom = 0.2,
	/obj/item/knife/combat/survival = 0.2,
	/obj/item/food/rationpack = 0.2
))

/obj/effect/spawner/random/whitesands
	name = "Whitesands Default loot spawner"

/obj/effect/spawner/random/whitesands/survivor
	name = "Whitesands Survivior loot spawner"
	loot = list()

/obj/effect/spawner/random/whitesands/survivor/Initialize()
	loot += GLOB.ws_survivor_default_loot
	return ..()

/obj/effect/spawner/random/whitesands/survivor/hunter
	name = "Whitesands Hunter loot spawner"
	loot = list(
		/obj/item/gun/ballistic/rifle/boltaction/polymer = 0.3,
		/obj/item/ammo_box/aac_300blk_stripper = 0.4
	)
/obj/effect/spawner/random/whitesands/survivor/gunslinger
	name = "Whitesands Gunslinger loot spawner"
	loot = list(
		/obj/item/gun/ballistic/automatic/aks74u = 0.1,
		/obj/item/ammo_box/magazine/aks74u = 0.4
	)
