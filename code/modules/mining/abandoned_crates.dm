//Originally coded by ISaidNo, later modified by Kelenius. Ported from Baystation12.

/obj/structure/closet/crate/secure/loot
	name = "abandoned crate"
	desc = "What could be inside?"
	icon_state = "securecrate"
	integrity_failure = 0 //no breaking open the crate
	var/code = null
	var/lastattempt = null
	var/attempts = 10
	var/codelen = 4
	var/qdel_on_open = FALSE
	var/spawned_loot = FALSE
	tamperproof = 90

/obj/structure/closet/crate/secure/loot/Initialize()
	. = ..()
	var/list/digits = list("1", "2", "3", "4", "5", "6", "7", "8", "9", "0")
	code = ""
	for(var/i = 0, i < codelen, i++)
		var/dig = pick(digits)
		code += dig
		digits -= dig  //there are never matching digits in the answer

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/structure/closet/crate/secure/loot/attack_hand(mob/user)
	if(locked)
		to_chat(user, "<span class='notice'>The crate is locked with a Deca-code lock.</span>")
		var/input = input(usr, "Enter [codelen] digits. All digits must be unique.", "Deca-Code Lock", "") as text|null
		if(user.canUseTopic(src, BE_CLOSE))
			var/list/sanitised = list()
			var/sanitycheck = TRUE
			var/char = ""
			var/length_input = length(input)
			for(var/i = 1, i <= length_input, i += length(char)) //put the guess into a list
				char = input[i]
				sanitised += text2num(char)
			for(var/i = 1, i <= length(sanitised) - 1, i++) //compare each digit in the guess to all those following it
				for(var/j = i + 1, j <= length(sanitised), j++)
					if(sanitised[i] == sanitised[j])
						sanitycheck = FALSE //if a digit is repeated, reject the input
			if(input == code)
				to_chat(user, "<span class='notice'>The crate unlocks!</span>")
				locked = FALSE
				cut_overlays()
				add_overlay("securecrateg")
				tamperproof = 0 // set explosion chance to zero, so we dont accidently hit it with a multitool and instantly die
				if(!spawned_loot)
					spawn_loot()
			else if(!input || !sanitycheck || length(sanitised) != codelen)
				to_chat(user, "<span class='notice'>You leave the crate alone.</span>")
			else
				to_chat(user, "<span class='warning'>A red light flashes.</span>")
				lastattempt = input
				attempts--
				if(attempts == 0)
					boom(user)
	else
		return ..()

/obj/structure/closet/crate/secure/loot/AltClick(mob/living/user)
	if(!user.canUseTopic(src, BE_CLOSE))
		return
	return attack_hand(user) //this helps you not blow up so easily by overriding unlocking which results in an immediate boom.

/obj/structure/closet/crate/secure/loot/attackby(obj/item/W, mob/user)
	if(locked)
		if(W.tool_behaviour == TOOL_MULTITOOL)
			to_chat(user, "<span class='notice'>DECA-CODE LOCK REPORT:</span>")
			if(attempts == 1)
				to_chat(user, "<span class='warning'>* Anti-Tamper Bomb will activate on next failed access attempt.</span>")
			else
				to_chat(user, "<span class='notice'>* Anti-Tamper Bomb will activate after [attempts] failed access attempts.</span>")
			if(lastattempt != null)
				var/bulls = 0 //right position, right number
				var/cows = 0 //wrong position but in the puzzle

				var/lastattempt_char = ""
				var/length_lastattempt = length(lastattempt)
				var/lastattempt_it = 1

				var/code_char = ""
				var/length_code = length(code)
				var/code_it = 1

				while(lastattempt_it <= length_lastattempt && code_it <= length_code) // Go through list and count matches
					lastattempt_char = lastattempt[lastattempt_it]
					code_char = code[code_it]
					if(lastattempt_char == code_char)
						++bulls
					else if(findtext(code, lastattempt_char))
						++cows

					lastattempt_it += length(lastattempt_char)
					code_it += length(code_char)

				to_chat(user, "<span class='notice'>Last code attempt, [lastattempt], had [bulls] correct digits at correct positions and [cows] correct digits at incorrect positions.</span>")
			return
	return ..()

/obj/structure/closet/secure/loot/dive_into(mob/living/user)
	if(!locked)
		return ..()
	to_chat(user, "<span class='notice'>That seems like a stupid idea.</span>")
	return FALSE

/obj/structure/closet/crate/secure/loot/emag_act(mob/user)
	if(locked)
		boom(user)

/obj/structure/closet/crate/secure/loot/togglelock(mob/user)
	if(locked)
		boom(user)
	else
		if (qdel_on_open)
			qdel(src)
		..()

/obj/structure/closet/crate/secure/loot/deconstruct(disassembled = TRUE)
	if(locked)
		boom()
	else
		if (qdel_on_open)
			qdel(src)
		..()

/obj/structure/closet/crate/secure/loot/proc/spawn_loot()
	var/loot = rand(1,100) //different crates with varying chances of spawning
	//Voidcrew edit
	//Completly refactored the lootdrops of the crates, highest chance to lowest chance
	switch(loot)
		if(1 to 10)
			// Xenobio starter pack. 10% Chance
			new /obj/item/slimecross/recurring/grey(src)
			new /obj/item/stack/sheet/mineral/plasma/five(src)
			new /obj/item/storage/box/monkeycubes(src)
			new /obj/item/circuitboard/machine/processor/slime(src)
			new /obj/item/circuitboard/computer/xenobiology(src)
		if(11 to 21)
			// Material pack (Common). 10% chance
			new /obj/item/stack/sheet/mineral/plasma/twenty(src)
			new /obj/item/stack/sheet/metal/fifty(src)
			new /obj/item/stack/sheet/glass/fifty(src)
			new /obj/item/stack/sheet/plasteel/twenty(src)
		if(22 to 32)
			// Powercells (Common). 10% Chance
			new /obj/item/stock_parts/cell/upgraded/plus(src)
			new /obj/item/stock_parts/cell/upgraded(src)
		if(33 to 38)
			// Makeshift Weapons Pack. 5% chance
			new /obj/item/spear/bonespear(src)
			new /obj/item/spear(src)
		if(39 to 44)
			// Utility Recuring. 5% chance
			new /obj/item/slimecross/recurring/metal(src)
			new /obj/item/slimecross/recurring/darkpurple(src)
			new /obj/item/slimecross/recurring/silver(src)
		if(45 to 50)
			// Material pack (Uncommon). 5% Chance
			new /obj/item/stack/sheet/mineral/uranium/five(src)
			new /obj/item/stack/sheet/mineral/gold/five(src)
			new /obj/item/stack/sheet/mineral/silver/five(src)
			new /obj/item/stack/sheet/mineral/titanium/five(src)
		if(51 to 56)
			// Powercells (Uncommon). 5% chance
			new /obj/item/stock_parts/cell/high(src)
			new /obj/item/stock_parts/cell/high/plus(src)
		if(57 to 61)
			// Combat Recurring. 5% Chance
			new /obj/item/slimecross/recurring/oil(src)
			new /obj/item/slimecross/recurring/gold(src)
		if(62 to 65)
			// Material pack (Exotic). 3% Chance
			new /obj/item/stack/sheet/mineral/bananium/five(src)
			new /obj/item/stack/sheet/mineral/abductor/five(src)
			new /obj/item/stack/sheet/mineral/coal/five(src)
		if(66 to 69)
			// Powercells (Exotic). 3% Chance
			new /obj/item/stock_parts/cell/high/slime/hypercharged(src)
			new /obj/item/stock_parts/cell/high/slime(src)
			new /obj/item/stock_parts/cell/pulse/pistol(src)
		if(70 to 73)
			// Ayyductor Surgery Tools. 3% Chance
			new /obj/item/scalpel/alien(src)
			new /obj/item/hemostat/alien(src)
			new /obj/item/retractor/alien(src)
			new /obj/item/circular_saw/alien(src)
			new /obj/item/surgicaldrill/alien(src)
			new /obj/item/cautery/alien(src)
		if(74 to 77)
			// Ayyductor Tools. 3% chance
			new /obj/item/multitool/abductor(src)
			new /obj/item/screwdriver/abductor(src)
			new /obj/item/crowbar/abductor(src)
			new /obj/item/wrench/abductor(src)
			new /obj/item/wirecutters/abductor(src)
			new /obj/item/weldingtool/abductor(src)
		if(78 to 79)
			// Uplink, 10 TC. 1% Chance
			new /obj/item/uplink/old(src)
		if(80 to 81)
			// Nukie Implant kit. 1% Chance
			new /obj/item/implanter/storage(src)
			new /obj/item/implanter/stealth(src)
		if(82 to 83)
			// Krav Mega Gloves. 1% Chance
			new /obj/item/clothing/gloves/krav_maga/combatglovesplus(src)
		if(84 to 85)
			// Bulldog Shotgun + Magazines
			new /obj/item/gun/ballistic/shotgun/bulldog/unrestricted(src)
			new /obj/item/ammo_box/magazine/m12g/slug(src)
			new /obj/item/ammo_box/magazine/m12g(src)
		if(86 to 87)
			// Nuclear Bomb. 1% Chance
			new /obj/machinery/nuclearbomb(src)
		if(88 to 89)
			// Strange Seeds X50. 1% Chance
			for(var/i in 1 to 50)
				new /obj/item/seeds/random(src)
		if(90 to 91)
			// Armed syndicate minibomb sized explosion. 1% Chance
			explosion(src,1,2,4,2)
		if(92 to 93)
			// A goat. 1% Chance
			new /mob/living/simple_animal/hostile/retaliate/goat(src)
		if(94 to 95)
			// A cosmos bedsheet, and 10 random bedsheets. 1% Chance
			new /obj/item/bedsheet/cosmos(src)
			for(var/x in 1 to 10)
				new /obj/item/bedsheet/random(src)
		if(95 to 96)
			// Alot of booze. 1% Chance
			for(var/a in 1 to 5)
				new /obj/item/storage/cans/sixbeer(src)
		if(97 to 98)
			// Advanced RCD. Ranged capablity and extended storage. 1% Chance
			new /obj/item/construction/rcd/arcd(src)
		if(99 to 100)
			// Singo Toy. 1% Chance
			new /obj/item/toy/spinningtoy(src)
	spawned_loot = TRUE
