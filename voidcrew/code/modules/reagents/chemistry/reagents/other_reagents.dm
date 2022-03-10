/datum/reagent/mutationtoxin/ipc
	name = "IPC Mutation Toxin"
	description = "An integrated positronic toxin."
	race = /datum/species/ipc
	color = "5EFF3B"

/datum/reagent/mutationtoxin/kepi
	name = "Kepori Mutation Toxin"
	description = "A feathery toxin."
	race = /datum/species/kepori
	taste_description = "a familiar white meat"

/datum/reagent/mutationtoxin/squid
	name = "Squid Mutation Toxin"
	description = "A salty toxin."
	color = "#5EFF3B"
	race = /datum/species/squid

/datum/reagent/crystal_reagent
	name = "Crystal Reagent"
	description = "A strange crystal substance. Heals faster than omnizine."
	reagent_state = LIQUID
	color = "#1B9681"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 20
	taste_description = "rocks"
	var/healing = 0.65

/datum/reagent/crystal_reagent/on_mob_life(mob/living/carbon/carbon)
	carbon.adjustToxLoss(-healing * REM, 0)
	carbon.adjustOxyLoss(-healing * REM, 0)
	carbon.adjustBruteLoss(-healing * REM, 0)
	carbon.adjustFireLoss(-healing * REM, 0)
	..()
	. = 1

/datum/reagent/crystal_reagent/overdose_process(mob/living/carbon/human/human)
	to_chat(human,"<span class='danger'>You feel your heart rupturing in two!</span>")
	human.adjustStaminaLoss(10)
	human.adjustOrganLoss(ORGAN_SLOT_HEART, 100)
	human.set_heartattack(TRUE)
