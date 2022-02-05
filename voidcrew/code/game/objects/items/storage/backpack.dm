/obj/item/storage/backpack/satchel/kepori
	name = "Kepori Satchel"
	desc = "A satchel designed with the kepori's light body in mind, has reduced capacity."
	icon_state = "satchel"
	item_state = "satchel"
	w_class = WEIGHT_CLASS_BULKY
	species_exception = list(/datum/species/kepori)

/obj/item/storage/backpack/satchel/kepori/ComponentInitialize()
	. = ..()
	var/datum/component/storage/bag = GetComponent(/datum/component/storage)
	bag.max_combined_w_class = 16
