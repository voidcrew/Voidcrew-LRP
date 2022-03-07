/obj/structure/spawner/cave
	name = "cave"
	desc = "A musty cave."
	icon = 'voidcrew/icons/obj/animal_spawner.dmi'
	icon_state = "cave_den"
	mob_types = list(/mob/living/simple_animal/hostile/bear/cave)
	max_mobs = 3
	max_integrity = 650
	spawn_time = 150
	faction = list("wasteland")
	var/uses = 6
	var/used_count = 0
	var/bite_chance = 15
	var/success_chance = 80
	var/caveloot = list(
		/obj/item/stack/spacecash/c10 = 50,
		/obj/item/stack/spacecash/c100 = 40,
		/obj/item/stack/spacecash/c10000 = 5,
		/obj/item/research_notes/loot/tiny = 50,
		/obj/item/research_notes/loot/small = 40,
		/obj/item/research_notes/loot/medium = 30,
		/obj/item/research_notes/loot/big = 20,
		/obj/item/research_notes/loot/genius = 10,
		/obj/item/stack/ore/uranium = 50,
		/obj/item/stack/ore/diamond = 30,
		/obj/item/stack/telecrystal/five = 5,
		/obj/item/gun/ballistic/rifle/boltaction/polymer = 10,
		/obj/item/gun/ballistic/shotgun/doublebarrel/improvised/sawn = 10,
		/obj/item/gun/ballistic/automatic/zip_pistol = 20,
		/obj/item/gun/ballistic/bow = 20,
		/obj/item/gun/ballistic/automatic/aks74u = 5,
		/obj/item/pickaxe/diamond = 20,
		/obj/item/binoculars = 30,
		/obj/item/grenade/frag/mega = 15,
		/obj/item/reagent_containers/food/drinks/drinkingglass/filled/nuka_cola = 50,
		/obj/item/reagent_containers/food/snacks/breadslice/moldy = 50,
		/obj/item/instrument/guitar = 20,
		/obj/item/storage/fancy/cigarettes/derringer/gold = 5,
		/obj/item/spear/explosive = 15,
		/obj/item/ammo_casing/caseless/arrow/wood = 50,
		/obj/item/ammo_casing/caseless/arrow/bone = 30,
		/obj/item/survivalcapsule = 40,
		/obj/item/survivalcapsule/luxuryelite = 5,
		/obj/item/storage/box/stockparts/basic = 50,
		/obj/item/storage/box/stockparts/deluxe = 5,
		/obj/item/stock_parts/cell/high/plus = 10,
		/obj/item/strange_crystal = 40,
		/obj/item/clothing/mask/cigarette/rollie/mindbreaker = 30,
		/obj/item/wrench/abductor = 5,
		/obj/item/clothing/glasses/meson = 20,
		/obj/item/clothing/suit/radiation = 40,
		/obj/item/clothing/head/radiation = 40,
		/obj/item/reagent_containers/hypospray/medipen/survival = 15,
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
	to_chat(user, "<span class='warning'>You start searching the [name] for anything useful...</span>")
	if(do_after(user, 40, target = src))
		if(prob(bite_chance))
			user.adjustBruteLoss(15)
			playsound(user.loc, 'sound/weapons/bite.ogg', 50, TRUE, -1)
			to_chat(user, "<span class='alert'>OW! Something bit you!</span>")
		if(prob(85))
			var/loot_amount = prob(5) ? 2 : 1
			if (loot_amount == 2)
				to_chat(user, "<span class='alert'>You pull out two things at once! What luck!</span>")
			else
				to_chat(user, "<span class='alert'>You found something!</span>")
			var/i = 0
			while(i <= loot_amount)
				var/picked_loot = pickweight(caveloot)
				new picked_loot(loc)
				i += 1
			used_count += 1
			if (used_count == uses)
				to_chat(user, "<span class='warning'>You've emptied out the [name]!</span>")
				qdel(spawner_type)
		else
			to_chat(user, "<span class='warning'>You didn't find anything, maybe try looking again?")
		obj_flags &= ~IN_USE
	else
		to_chat(user, "<span class='warning'><b>Your search was interrupted!</b></span>")
		obj_flags &= ~IN_USE

/obj/structure/spawner/cave/beach
	name = "oak barrel"
	desc = "A barrel. Reach in and unlock its mold-covered mysteries!"
	icon = 'icons/obj/objects.dmi'
	icon_state = "barrel"
	mob_types = list(/mob/living/simple_animal/hostile/pirate/melee/beach, /mob/living/simple_animal/hostile/pirate/ranged/beach)
	max_mobs = 2
	max_integrity = 250
	bite_chance = 0
	faction = list("beach")
	caveloot = list(
		/obj/item/storage/bag/money/vault = 40,
		/obj/item/research_notes/loot/tiny = 50,
		/obj/item/research_notes/loot/small = 35,
		/obj/item/research_notes/loot/medium = 25,
		/obj/item/research_notes/loot/big = 10,
		/obj/item/research_notes/loot/genius = 5,
		/obj/item/grenade/clusterbuster/slime = 1,
		/obj/item/grenade/chem_grenade/teargas/moustache = 5,
		/obj/item/slimecross/burning/blue = 10,
		/obj/item/slimecross/burning/lightpink = 10,
		/obj/item/slimecross/burning/bluespace = 5,
		/obj/item/slimecross/burning/sepia = 5,
		/obj/item/slimecross/burning/gold = 5,
		/obj/item/slimecross/burning/oil = 5,
		/obj/item/slimecross/burning/rainbow = 5,
		/obj/item/slimecross/regenerative/orange = 3,
		/obj/item/slimecross/regenerative/silver = 3,
		/obj/item/slimecross/regenerative/adamantine = 3,
		/obj/item/slimecross/regenerative/lightpink = 2,
		/obj/item/slimecross/regenerative/rainbow = 2,
		/obj/item/slimecross/stabilized/grey = 10,
		/obj/item/slimecross/stabilized/yellow = 10,
		/obj/item/slimecross/stabilized/purple = 10,
		/obj/item/slimecross/stabilized/rainbow = 10,
		/obj/item/slimecross/stabilized/cerulean = 5,
		/obj/item/slimecross/stabilized/pink = 2,
		/obj/item/slimecross/industrial/blue = 10,
		/obj/item/slimecross/industrial/oil = 10,
		/obj/item/slimecross/industrial/darkblue = 5,
		/obj/item/slimecross/charged/darkblue = 10,
		/obj/item/slimecross/charged/pyrite = 10,
		/obj/item/slimecross/charged/red = 10,
		/obj/item/slimecross/charged/pink = 10,
		/obj/item/slimecross/charged/black = 10,
		/obj/item/slimecross/chilling/yellow = 10,
		/obj/item/slimecross/chilling/pyrite = 10,
		/obj/item/slimecross/chilling/gold = 10,
		/obj/item/slimecross/chilling/adamantine = 5,
		/obj/item/slimecross/chilling/rainbow = 5,
		/obj/item/clothing/suit/pirate/captain = 30,
		/obj/item/clothing/head/pirate/captain = 30,
		/obj/item/instrument/banjo = 20,
		/obj/item/clothing/mask/cigarette/rollie/cannabis = 30
	)

