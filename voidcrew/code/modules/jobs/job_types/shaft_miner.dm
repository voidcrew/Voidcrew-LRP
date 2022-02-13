/datum/outfit/job/miner/solgov
	name = "Pioneer (SolGov)"

	uniform = /obj/item/clothing/under/solgov
	accessory = /obj/item/clothing/accessory/armband/cargo
	head = /obj/item/clothing/head/beret/solgov/plain

/datum/outfit/job/miner/solgov/rebel
	name = "Pioneer (Deserter)"

	uniform = /obj/item/clothing/under/syndicate/camo
	head = /obj/item/clothing/head/beret/solgov/terragov/plain

/datum/outfit/job/miner/equipped
	name = "Shaft Miner (Equipment)"
	suit = /obj/item/clothing/suit/hooded/explorer
	mask = /obj/item/clothing/mask/gas/explorer
	glasses = /obj/item/clothing/glasses/meson
	suit_store = /obj/item/tank/internals/oxygen
	internals_slot = ITEM_SLOT_SUITSTORE
	backpack_contents = list(
		/obj/item/flashlight/seclite=1,\
		/obj/item/kitchen/knife/combat/survival=1,
		/obj/item/mining_voucher=1,
		/obj/item/gun/energy/kinetic_accelerator=1,\
		/obj/item/stack/marker_beacon/ten=1)

/datum/outfit/job/miner/equipped/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	if(istype(H.wear_suit, /obj/item/clothing/suit/hooded))
		var/obj/item/clothing/suit/hooded/S = H.wear_suit
		S.ToggleHood()

/datum/outfit/job/miner/equipped/hardsuit
	name = "Shaft Miner (Equipment + Hardsuit)"
	suit = /obj/item/clothing/suit/space/hardsuit/mining
	mask = /obj/item/clothing/mask/breath

//Shiptest Outfits

/datum/outfit/job/miner/hazard
	name = "Asteroid Miner (Hazard)"
	uniform = /obj/item/clothing/under/rank/cargo/miner/hazard
	alt_uniform = null
	alt_suit = /obj/item/clothing/suit/toggle/hazard

/datum/outfit/job/miner/solgov
	name = "Field Engineer (SolGov)"

	uniform = /obj/item/clothing/under/solgov
	accessory = /obj/item/clothing/accessory/armband/cargo
	head = /obj/item/clothing/head/hardhat/mining
	suit =  /obj/item/clothing/suit/hazardvest

/datum/outfit/job/miner/solgov/rebel
	name = "Field Engineer (Deserter)"

	uniform = /obj/item/clothing/under/syndicate/camo

/datum/outfit/job/miner/scientist
	name = "Minerologist"

	belt = /obj/item/pda/toxins
	uniform = /obj/item/clothing/under/rank/cargo/miner/hazard
	alt_uniform = /obj/item/clothing/under/rank/rnd/roboticist
	suit = /obj/item/clothing/suit/toggle/labcoat/science
	alt_suit = /obj/item/clothing/suit/toggle/hazard
	dcoat = /obj/item/clothing/suit/hooded/wintercoat/science

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/tox
	courierbag = /obj/item/storage/backpack/messenger/tox

/datum/outfit/job/miner/syndicate
	name = "Wrecker (Gorlex Marauders)"

	id = /obj/item/card/id/syndicate_command/crew_id
	ears = /obj/item/radio/headset/syndicate/alt
	uniform = /obj/item/clothing/under/syndicate/gorlex
	alt_uniform = null
	accessory = /obj/item/clothing/accessory/armband/cargo
	head = /obj/item/clothing/head/hardhat/orange

/datum/outfit/job/miner/old
	name = "Shaft Miner (Legacy)"
	suit = /obj/item/clothing/suit/hooded/explorer/old
	mask = /obj/item/clothing/mask/gas/explorer/old
	glasses = /obj/item/clothing/glasses/meson
	suit_store = /obj/item/tank/internals/oxygen
	gloves = /obj/item/clothing/gloves/explorer/old
	uniform = /obj/item/clothing/under/rank/cargo/miner/lavaland/old
	internals_slot = ITEM_SLOT_SUITSTORE
	backpack_contents = list(
		/obj/item/flashlight/seclite=1,\
		/obj/item/kitchen/knife/combat/survival=1,
		/obj/item/mining_scanner=1,
		/obj/item/reagent_containers/hypospray/medipen/survival,
		/obj/item/reagent_containers/hypospray/medipen/survival,\
		/obj/item/gun/energy/kinetic_accelerator/old=1,\
		/obj/item/stack/marker_beacon/ten=1)
