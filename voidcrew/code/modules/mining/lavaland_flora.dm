/obj/structure/flora/ash/proc/consume(user)
	if(harvested)
		return 0

	icon_state = "[base_icon]p"
	name = harvested_name
	desc = harvested_desc
	harvested = TRUE
	addtimer(CALLBACK(src, .proc/regrow), rand(regrowth_time_low, regrowth_time_high))
	return 1

/obj/structure/flora/ash/lavaland/
	icon = 'voidcrew/icons/obj/lavaland/lavalandplants.dmi'

/obj/structure/flora/ash/lavaland/fern
	name = "cave fern"
	desc = "A species of fern with highly fibrous leaves."
	icon_state = "fern" //needs new sprites.
	harvested_name = "cave fern stems"
	harvested_desc = "A few cave fern stems, missing their leaves."
	harvest = /obj/item/food/grown/flora/ash/lavaland/fern
	harvest_amount_high = 4
	harvest_message_low = "You clip a single, suitable leaf."
	harvest_message_med = "You clip a number of leaves, leaving a few unsuitable ones."
	harvest_message_high = "You clip quite a lot of suitable leaves."
	regrowth_time_low = 3000
	regrowth_time_high = 5400

/obj/structure/flora/ash/lavaland/fireblossom
	name = "fire blossom"
	desc = "An odd flower that grows commonly near bodies of lava. The leaves can be ground up for a substance resembling capsaicin."
	icon_state = "fireblossom"
	harvested_name = "fire blossom stems"
	harvested_desc = "A few fire blossom stems, missing their flowers."
	harvest = /obj/item/food/grown/flora/ash/lavaland/fireblossom
	needs_sharp_harvest = FALSE
	harvest_amount_high = 3
	harvest_message_low = "You pluck a single, suitable flower."
	harvest_message_med = "You pluck a number of flowers, leaving a few unsuitable ones."
	harvest_message_high = "You pluck quite a lot of suitable flowers."
	regrowth_time_low = 2500
	regrowth_time_high = 4000

/obj/structure/flora/ash/lavaland/puce
	name = "Pucestal Growth"
	desc = "A collection of puce colored crystal growths."
	icon_state = "puce"
	harvested_name = "Pucestal fragments"
	harvested_desc = "A few pucestal fragments, slowly regrowing."
	harvest = /obj/item/food/grown/flora/ash/lavaland/puce
	harvest_amount_high = 6
	harvest_message_low = "You work a crystal free."
	harvest_message_med = "You cut a number of crystals free, leaving a few small ones."
	harvest_message_high = "You cut free quite a lot of crystals."
	regrowth_time_low = 10 MINUTES 				// Fast, for a crystal
	regrowth_time_high = 20 MINUTES

//SNACKS

/obj/item/food/grown/flora/ash/lavaland
	icon = 'voidcrew/icons/obj/lavaland/lavalandplants.dmi'

/obj/item/food/grown/flora/ash/lavaland/fern
	name = "fern leaf"
	desc = "A leaf from a cave fern."
	icon_state = "fern"
	seed = /obj/item/seeds/lavaland/fern
	wine_power = 10

/obj/item/food/grown/flora/ash/lavaland/fireblossom
	name = "fire blossom"
	desc = "A flower from a fire blossom."
	icon_state = "fireblossom"
	seed = /obj/item/seeds/lavaland/fireblossom
	wine_power = 40

/obj/item/food/grown/flora/ash/lavaland/puce
	name = "Pucestal Crystal"
	desc = "A crystal from a pucestal growth."
	icon_state = "puce"
	seed = /obj/item/seeds/lavaland/puce
	wine_power = 0		// It's a crystal

/// VC TODO: Replace this with the equivilent.
///obj/item/food/grown/flora/ash/lavaland/puce/canconsume(mob/eater, mob/user)
//	return FALSE

//SEEDS

/obj/item/seeds/lavaland
	icon = 'voidcrew/icons/obj/lavaland/lavalandplants.dmi'
	growing_icon = 'voidcrew/icons/obj/lavaland/lavalandplants.dmi'
	species = "fern" // begone test
	growthstages = 2

/obj/item/seeds/lavaland/fern
	name = "pack of cave fern seeds"
	desc = "These seeds grow into cave ferns."
	plantname = "Cave Fern"
	icon_state = "seed_fern"
	species = "fern"
	growthstages = 2
	product = /obj/item/food/grown/flora/ash/lavaland/fern
	genes = list(/datum/plant_gene/trait/fire_resistance, /datum/plant_gene/trait/plant_type/weed_hardy)
	/// VC REAGENT TODO
	//reagents_add = list(/datum/reagent/ash_fibers = 0.10)

///obj/item/seeds/lavaland/fern/Initialize(mapload,nogenes)
	//. = ..()
	//if(!nogenes)
		//unset_mutability(/datum/plant_gene/reagent, PLANT_GENE_EXTRACTABLE)

/obj/item/seeds/lavaland/fireblossom
	name = "pack of fire blossom seeds"
	desc = "These seeds grow into fire blossoms."
	plantname = "Fire Blossom"
	icon_state = "seed_fireblossom"
	species = "fireblossom"
	growthstages = 3
	product = /obj/item/food/grown/flora/ash/lavaland/fireblossom
	genes = list(/datum/plant_gene/trait/fire_resistance, /datum/plant_gene/trait/glow/yellow)   /// VC REAGENT TODO
	reagents_add = list(/datum/reagent/consumable/nutriment = 0.03, /datum/reagent/carbon = 0.05)//, /datum/reagent/consumable/pyre_elementum = 0.08)

/obj/item/seeds/lavaland/puce
	name = "puce cluster"
	desc = "These crystals can be grown into larger crystals."
	plantname = "Pucestal Growth"
	icon_state = "cluster_puce"
	species = "puce"
	growthstages = 3
	product = /obj/item/food/grown/flora/ash/lavaland/puce
	/// VC TODO: Port this gene
	//genes = list(/datum/plant_gene/trait/plant_type/crystal)
	/// VC REAGENT TODO
	//reagents_add = list(/datum/reagent/medicine/puce_essence = 0.10)

/// VC TODO: Not exactly sure what this stuff does but it don't work!
///obj/item/seeds/lavaland/puce/Initialize(mapload,nogenes)
	//. = ..()
	//if(!nogenes)
		//unset_mutability(/datum/plant_gene/reagent, PLANT_GENE_REMOVABLE)
		//unset_mutability(/datum/plant_gene/trait/plant_type/crystal, PLANT_GENE_REMOVABLE)

		//unset_mutability(/datum/plant_gene/reagent, PLANT_GENE_EXTRACTABLE)
		//unset_mutability(/datum/plant_gene/trait/plant_type/crystal, PLANT_GENE_EXTRACTABLE)
