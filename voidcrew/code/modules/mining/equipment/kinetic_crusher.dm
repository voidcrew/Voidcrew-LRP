/obj/item/crusher_trophy/shiny
	name = "shiny nugget"
	icon = 'voidcrew/icons/obj/lavaland/elite_trophies.dmi'
	desc = "A glimmering nugget of dull metal. As it turns out, the fools were right- pyrite is a far rarer substance than gold in the space age. You could probably sell this for a fair price."
	icon_state = "nugget"
	gender = PLURAL
	denied_type = /obj/item/crusher_trophy/shiny

/obj/item/crusher_trophy/shiny/effect_desc()
	return "empowered butchering chances"

/obj/item/crusher_trophy/shiny/add_to(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.AddComponent(/datum/component/butchering, 60, 210)

/obj/item/crusher_trophy/shiny/remove_from(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.AddComponent(/datum/component/butchering, 60, 110)