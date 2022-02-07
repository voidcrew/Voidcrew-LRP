// -----------------------------
//          Plant bag
// -----------------------------

/obj/item/storage/bag/plants
	name = "plant bag"
	//WS Begin - Better bag sprites
	icon = 'whitesands/icons/obj/bags.dmi'
	icon_state = "plantbag"
	//WS end
	resistance_flags = FLAMMABLE

/obj/item/storage/bag/plants/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_combined_w_class = 50
	STR.max_items = 100
	STR.set_holdable(list(
		/obj/item/reagent_containers/food/snacks/grown,
		/obj/item/seeds,
		/obj/item/grown,
		/obj/item/reagent_containers/honeycomb,
		/obj/item/disk/plantgene
		))
////////
