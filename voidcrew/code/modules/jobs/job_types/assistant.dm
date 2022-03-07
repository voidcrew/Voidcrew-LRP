/datum/outfit/job/assistant/solgov
	name = "Sailor (SolGov)"

	uniform = /obj/item/clothing/under/solgov
	shoes = /obj/item/clothing/shoes/combat
	head = /obj/item/clothing/head/beret/solgov/plain

/datum/outfit/job/assistant/solgov/rebel
	name = "Sailor (Deserter)"

	uniform = /obj/item/clothing/under/syndicate/camo
	head = /obj/item/clothing/head/beret/solgov/terragov/plain

/datum/outfit/job/assistant/intern
	name = "Assistant (Intern)"
	uniform = /obj/item/clothing/under/suit/black
	neck = /obj/item/clothing/neck/tie
	shoes = /obj/item/clothing/shoes/laceup
	r_pocket = /obj/item/pen/fountain

/datum/outfit/job/assistant/receptionist
	name = "Assistant (Receptionist)"
	uniform = /obj/item/clothing/under/suit/beige
	glasses = /obj/item/clothing/glasses/regular/hipster
	shoes = /obj/item/clothing/shoes/laceup
	r_pocket = /obj/item/pen/fourcolor
	l_pocket = /obj/item/clipboard

/datum/outfit/job/assistant/receptionist/pre_equip(mob/living/carbon/human/H)
	..()
	switch(H.jumpsuit_style)
		if(PREF_SUIT)
			uniform = initial(uniform)
		if(PREF_ALTSUIT)
			uniform = /obj/item/clothing/under/suit/blacktwopiece
		if(PREF_SKIRT)
			uniform = /obj/item/clothing/under/dress/skirt/plaid
		else
			uniform = /obj/item/clothing/under/suit/beige

/datum/outfit/job/assistant/pirate
	name = "Assistant (Pirate)"

	uniform = /obj/item/clothing/under/costume/sailor
	shoes = /obj/item/clothing/shoes/jackboots

/datum/outfit/job/assistant/corporate
	name = "Business Associate"

	uniform = /obj/item/clothing/under/suit/black
	shoes = /obj/item/clothing/shoes/laceup
	suit = /obj/item/clothing/suit/toggle/lawyer/black

/datum/outfit/job/assistant/syndicate
	name = "Junior Agent (Assistant)"

	id = /obj/item/card/id/syndicate_command/crew_id
	ears = /obj/item/radio/headset/syndicate
	uniform = /obj/item/clothing/under/syndicate
	alt_uniform = null
	shoes = /obj/item/clothing/shoes/jackboots

/datum/outfit/job/assistant/syndicate/gorlex
	name = "Junior Agent (Gorlex Marauders)"

	uniform = /obj/item/clothing/under/syndicate/gorlex
	alt_uniform = /obj/item/clothing/under/syndicate

/datum/outfit/job/assistant/ex_prisoner
	name = "Assistant (Ex-Prisoner)"

	glasses = /obj/item/clothing/glasses/sunglasses
	uniform = /obj/item/clothing/under/rank/prisoner
	shoes = /obj/item/clothing/shoes/sneakers/orange
	accessory = /obj/item/clothing/accessory/armband/deputy

/datum/outfit/job/assistant/provo
	name = "Provisional IRA Scientist"

	head = /obj/item/clothing/head/beret/sec/officer{name = "IRA beret"}
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/color/black
	neck = /obj/item/clothing/neck/tie/red
	uniform = /obj/item/clothing/under/suit/black_really
	shoes = /obj/item/clothing/shoes/laceup
