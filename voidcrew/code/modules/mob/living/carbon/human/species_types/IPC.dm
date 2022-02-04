/datum/species/ipc
	name = "\improper Integrated Positronic Chassis"
	id = SPECIES_IPC
	sexes = FALSE
	say_mod = "states"
	species_traits = list(
		AGENDER,
		NOTRANSSTING,
		NOEYESPRITES,
		NO_DNA_COPY,
		NOBLOOD,
		TRAIT_EASYDISMEMBER,
		NOZOMBIE,
		MUTCOLORS,
		REVIVESBYHEALING,
		NOHUSK,
		NOMOUTH,
		NO_BONES,
		MUTCOLORS,
		NO_UNDERWEAR,
	)
	inherent_traits = list(
		TRAIT_RESISTCOLD,
		TRAIT_VIRUSIMMUNE,
		TRAIT_NOBREATH,
		TRAIT_RADIMMUNE,
		TRAIT_GENELESS,
		TRAIT_LIMBATTACHMENT,
	)
	inherent_biotypes = list(MOB_ROBOTIC, MOB_HUMANOID)
	mutantbrain = /obj/item/organ/brain/mmi_holder/posibrain
	mutanteyes = /obj/item/organ/eyes/robotic
	mutanttongue = /obj/item/organ/tongue/robot
	mutantliver = /obj/item/organ/liver/cybernetic/upgraded/ipc
	mutantstomach = /obj/item/organ/stomach/cell
	mutantears = /obj/item/organ/ears/robot
	mutantlungs = null
	mutantappendix = null
	mutant_organs = list(/obj/item/organ/cyberimp/arm/power_cord)
	mutant_bodyparts = list(
		"ipc_screen",
		"ipc_antenna",
		"ipc_chassis",
	)
	default_features = list(
		"mcolor" = "#7D7D7D",
		"ipc_screen" = "Static",
		"ipc_antenna" = "None",
		"ipc_chassis" = "Morpheus Cyberkinetics(Greyscale)",
	)
	meat = /obj/item/stack/sheet/plasteel{amount = 5}
	skinned_type = /obj/item/stack/sheet/metal{amount = 10}
	exotic_blood = /datum/reagent/fuel/oil
	damage_overlay_type = "synth"
	mutant_bodyparts = list("ipc_screen", "ipc_antenna", "ipc_chassis")
	default_features = list("ipc_screen" = "BSOD", "ipc_antenna" = "None")
	burnmod = 1.25
	heatmod = 1.5
	brutemod = 1
	siemens_coeff = 1.5
	reagent_tag = PROCESS_SYNTHETIC
	species_gibs = "robotic"
	attack_sound = 'sound/items/trayhit1.ogg'
	allow_numbers_in_name = TRUE
	deathsound = "sound/voice/borg_deathsound.ogg"
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	loreblurb = "Integrated Positronic Chassis or \"IPC\" for short, are synthetic lifeforms composed of an Artificial \
	Intelligence program encased in a bipedal robotic shell. They are fragile, allergic to EMPs, and the butt of endless toaster jokes. \
	Just as easy to repair as they are to destroy, they might just get their last laugh in as you're choking on neurotoxins. Beep Boop."
	ass_image = 'icons/ass/assmachine.png'

	species_chest = /obj/item/bodypart/chest/ipc
	species_head = /obj/item/bodypart/head/ipc
	species_l_arm = /obj/item/bodypart/l_arm/ipc
	species_r_arm = /obj/item/bodypart/r_arm/ipc
	species_l_leg = /obj/item/bodypart/l_leg/ipc
	species_r_leg = /obj/item/bodypart/r_leg/ipc

	/// The last screen used when the IPC died.
	var/saved_screen
	var/datum/action/innate/change_screen/change_screen

/datum/species/ipc/random_name(unique)
	var/ipc_name = "[pick(GLOB.posibrain_names)]-[rand(100, 999)]"
	return ipc_name

/datum/species/ipc/on_species_gain(mob/living/carbon/carbon) // Let's make that IPC actually robotic.
	. = ..()
	if(ishuman(carbon) && !change_screen)
		change_screen = new
		change_screen.Grant(carbon)

/datum/species/ipc/on_species_loss(mob/living/carbon/carbon)
	. = ..()
	if(change_screen)
		change_screen.Remove(carbon)

/datum/species/ipc/get_spans()
	return SPAN_ROBOT

/datum/species/ipc/after_equip_job(datum/job/job, mob/living/carbon/human/human)
	human.grant_language(/datum/language/machine)

/datum/species/ipc/spec_death(gibbed, mob/living/carbon/carbon)
	saved_screen = carbon.dna.features["ipc_screen"]
	carbon.dna.features["ipc_screen"] = "BSOD"
	carbon.update_body()
	addtimer(CALLBACK(src, .proc/post_death, carbon), 5 SECONDS)

/datum/species/ipc/proc/post_death(mob/living/carbon/carbon)
	if(carbon.stat < DEAD)
		return
	carbon.dna.features["ipc_screen"] = null // Turns off their monitor on death.
	carbon.update_body()

/datum/action/innate/change_screen
	name = "Change Display"
	check_flags = AB_CHECK_CONSCIOUS
	icon_icon = 'icons/mob/actions/actions_silicon.dmi'
	button_icon_state = "drone_vision"

/datum/action/innate/change_screen/Activate()
	var/screen_choice = input(usr, "Which screen do you want to use?", "Screen Change") as null | anything in GLOB.ipc_screens_list
	var/color_choice = input(usr, "Which color do you want your screen to be?", "Color Change") as null | color
	if(!screen_choice)
		return
	if(!color_choice)
		return
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/human = owner
	human.dna.features["ipc_screen"] = screen_choice
	human.eye_color = sanitize_hexcolor(color_choice)
	human.update_body()

/obj/item/apc_powercord
	name = "power cord"
	desc = "An internal power cord hooked up to a battery. Useful if you run on electricity. Not so much otherwise."
	icon = 'icons/obj/power.dmi'
	icon_state = "wire1"

/obj/item/apc_powercord/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if((!istype(target, /obj/machinery/power/apc) && !isethereal(target)) || !ishuman(user) || !proximity_flag)
		return ..()
	user.changeNext_move(CLICK_CD_MELEE)
	var/mob/living/carbon/human/human = user
	var/obj/item/organ/stomach/cell/battery = human.getorganslot(ORGAN_SLOT_STOMACH)
	if(!battery)
		to_chat(human, "<span class='warning'>You try to siphon energy from \the [target], but your power cell is gone!</span>")
		return

	if(istype(human) && human.nutrition >= NUTRITION_LEVEL_ALMOST_FULL)
		to_chat(user, "<span class='warning'>You are already fully charged!</span>")
		return

	if(istype(target, /obj/machinery/power/apc))
		var/obj/machinery/power/apc/apc = target
		if(apc.cell && apc.cell.charge > apc.cell.maxcharge/4)
			powerdraw_loop(apc, human, TRUE)
			return
		else
			to_chat(user, "<span class='warning'>There is not enough charge to draw from that APC.</span>")
			return

	if(isethereal(target))
		var/mob/living/carbon/human/target_ethereal = target
		var/obj/item/organ/stomach/ethereal/eth_stomach = target_ethereal.getorganslot(ORGAN_SLOT_STOMACH)
		if(target_ethereal.nutrition > 0 && eth_stomach)
			powerdraw_loop(eth_stomach, human, FALSE)
			return
		else
			to_chat(user, "<span class='warning'>There is not enough charge to draw from that being!</span>")
			return

/obj/item/apc_powercord/proc/powerdraw_loop(atom/target, mob/living/carbon/human/human, apc_target)
	human.visible_message("<span class='notice'>[human] inserts a power connector into the [target].</span>", "<span class='notice'>You begin to draw power from the [target].</span>")
	var/obj/item/organ/stomach/cell/battery = human.getorganslot(ORGAN_SLOT_STOMACH)
	if(apc_target)
		var/obj/machinery/power/apc/apc = target
		if(!istype(apc))
			return
		while(do_after(human, 10, target = apc))
			if(loc != human)
				to_chat(human, "<span class='warning'>You must keep your connector out while charging!</span>")
				break
			if(apc.cell.charge == 0)
				to_chat(human, "<span class='warning'>The [apc] doesn't have enough charge to spare.</span>")
				break
			apc.charging = 1
			if(apc.cell.charge >= 500)
				human.nutrition += 50
				apc.cell.charge -= 250
				to_chat(human, "<span class='notice'>You siphon off some of the stored charge for your own use.</span>")
			else
				human.nutrition += apc.cell.charge/10
				apc.cell.charge = 0
				to_chat(human, "<span class='notice'>You siphon off as much as the [apc] can spare.</span>")
				break
			if(human.nutrition > NUTRITION_LEVEL_WELL_FED)
				to_chat(human, "<span class='notice'>You are now fully charged.</span>")
				break
	else
		var/obj/item/organ/stomach/ethereal/eth_stomach = target
		if(!istype(eth_stomach))
			return
		var/siphon_amt
		while(do_after(human, 10, target = eth_stomach.owner))
			if(!battery)
				to_chat(human, "<span class='warning'>You need a battery to recharge!</span>")
				break
			if(loc != human)
				to_chat(human, "<span class='warning'>You must keep your connector out while charging!</span>")
				break
			if(eth_stomach.crystal_charge == 0)
				to_chat(human, "<span class='warning'>[eth_stomach] is completely drained!</span>")
				break
			siphon_amt = eth_stomach.crystal_charge <= (2 * ETHEREAL_CHARGE_SCALING_MULTIPLIER) ? eth_stomach.crystal_charge : (2 * ETHEREAL_CHARGE_SCALING_MULTIPLIER)
			eth_stomach.adjust_charge(-1 * siphon_amt)
			human.nutrition += (siphon_amt)
			if(human.nutrition > NUTRITION_LEVEL_WELL_FED)
				to_chat(human, "<span class='notice'>You are now fully charged.</span>")
				break

	human.visible_message("<span class='notice'>[human] unplugs from the [target].</span>", "<span class='notice'>You unplug from the [target].</span>")
	return

/datum/species/ipc/spec_life(mob/living/carbon/human/human)
	. = ..()
	if(human.health <= HEALTH_THRESHOLD_CRIT && human.stat != DEAD) // So they die eventually instead of being stuck in crit limbo.
		human.adjustFireLoss(6) // After BODYTYPE_ROBOTIC resistance this is ~2/second
		if(prob(5))
			to_chat(human, "<span class='warning'>Alert: Internal temperature regulation systems offline; thermal damage sustained. Shutdown imminent.</span>")
			human.visible_message("[human]'s cooling system fans stutter and stall. There is a faint, yet rapid beeping coming from inside their chassis.")


/datum/species/ipc/spec_revival(mob/living/carbon/human/human)
	human.dna.features["ipc_screen"] = "BSOD"
	human.update_body()
	human.say("Reactivating [pick("core systems", "central subroutines", "key functions")]...")
	addtimer(CALLBACK(src, .proc/post_revival, human), 6 SECONDS)

/datum/species/ipc/proc/post_revival(mob/living/carbon/human/human)
	if(human.stat < DEAD)
		return
	human.say("Unit [human.real_name] is fully functional. Have a nice day.")
	human.dna.features["ipc_screen"] = saved_screen
	human.update_body()

/datum/species/ipc/replace_body(mob/living/carbon/C, datum/species/new_species)
	..()

	var/datum/sprite_accessory/ipc_chassis/chassis_of_choice = GLOB.ipc_chassis_list[C.dna.features["ipc_chassis"]]

	for(var/obj/item/bodypart/BP as anything in C.bodyparts) //Override bodypart data as necessary
		BP.uses_mutcolor = chassis_of_choice.color_src ? TRUE : FALSE
		if(BP.uses_mutcolor)
			BP.should_draw_greyscale = TRUE
			BP.species_color = C.dna?.features["mcolor"]

		BP.limb_id = chassis_of_choice.limbs_id
		BP.name = "\improper[chassis_of_choice.name] [parse_zone(BP.body_zone)]"
		BP.update_limb()


///Used to modularly load IPC accesories
/world/proc/make_ipc_datum_references_list()
	init_sprite_accessory_subtypes(/datum/sprite_accessory/ipc_screens, GLOB.ipc_screens_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/ipc_antennas, GLOB.ipc_antennas_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/ipc_chassis, GLOB.ipc_chassis_list)
