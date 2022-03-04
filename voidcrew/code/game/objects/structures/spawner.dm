/obj/structure/spawner/cave
	icon = 'voidcrew/icons/obj/animal_spawner.dmi'
	icon_state = "cave_den"
	mob_types = list(/mob/living/simple_animal/hostile/bear/cave)
	max_mobs = 3
	max_integrity = 650
	spawn_time = 210
	var/uses = 6
	var/used_count = 0
	var/caveloot = list(
		/obj/item/stack/spacecash/c10 = 70,
		/obj/item/stack/spacecash/c100 = 50,
		/obj/item/stack/spacecash/c10000 = 1,
		/obj/item/stack/ore/diamond = 50,
		/obj/item/stack/ore/uranium = 50,
		/obj/item/stack/ore/bananium = 5,
		/obj/item/stack/telecrystal/five = 1,
		/obj/item/weaponcrafting/gunkit/capgun_ugrade_kit = 5,
		/obj/item/gun/ballistic/rifle/boltaction/polymer = 10,
		/obj/item/reagent_containers/food/drinks/drinkingglass/filled/nuka_cola = 60,
		/obj/item/reagent_containers/food/snacks/breadslice/moldy = 60,
		/obj/item/slimecross/regenerative/rainbow = 1,
		/obj/item/slimecross/prismatic/darkpurple = 20,
		/obj/item/instrument/banjo = 20,
		/obj/item/instrument/guitar = 20,
		/obj/item/storage/fancy/cigarettes/derringer/gold = 1,
		/obj/item/spear/explosive = 15,
		/obj/item/gun/ballistic/bow = 40,
		/obj/item/ammo_casing/caseless/arrow/wood = 70,
		/obj/item/ammo_casing/caseless/arrow/bronze = 50,
		/obj/item/ammo_casing/caseless/arrow/bone = 20,
		/obj/item/survivalcapsule = 40,
		/obj/item/survivalcapsule/luxury = 25,
		/obj/item/survivalcapsule/luxuryelite = 5,
		/mob/living/simple_animal/hostile/cockroach/glockroach = 60,
		/obj/item/storage/box/stockparts/basic = 60,
		/obj/item/storage/box/stockparts/t2 = 40,
		/obj/item/storage/box/stockparts/t3 = 10,
		/obj/item/storage/box/stockparts/deluxe = 5,
		/obj/item/stock_parts/cell/high/plus = 10,
		/obj/item/strange_crystal = 40,
		/obj/item/clothing/mask/cigarette/rollie/mindbreaker = 40,
		/obj/item/clothing/mask/cigarette/rollie/cannabis = 30,
		/obj/item/wrench/abductor = 5,
		/obj/item/clothing/glasses/meson = 20,
		/obj/item/tank/jetpack/suit = 10,
		/obj/item/reagent_containers/hypospray/medipen/survival = 15,
		/obj/item/card/mining_point_card = 15,
		/obj/item/gps/mining = 40,
		/obj/item/extraction_pack = 25,
		/obj/item/reagent_containers/food/drinks/beer = 45,
		/obj/effect/spawner/lootdrop/maintenance = 50
	)

/obj/structure/spawner/cave/Initialize()
	. = ..()
	uses = rand(1,uses)

/obj/structure/spawner/cave/interact(mob/living/carbon/human/user)
	if(!istype(user))
		return
	if(obj_flags & IN_USE)
		return
	if(used_count == uses)
		to_chat(user, "<span class='warning'>There's nothing left to loot!</span>")
		return
	obj_flags |= IN_USE
	to_chat(user, "<span class='warning'>You start searching the cave for anything useful...</span>")
	if(do_after(user, 20, target = src))
		//Choose an item from the weighted list
		var/picked_loot = pickweight(caveloot)
		new picked_loot(loc)
		used_count += 1
		if (used_count == uses)
			to_chat(user, "<span class='warning'>You've emptied out the cave!</span>")
			spawner_type.max_mobs = 0
		//Clear the IN_USE flag
		obj_flags &= ~IN_USE
