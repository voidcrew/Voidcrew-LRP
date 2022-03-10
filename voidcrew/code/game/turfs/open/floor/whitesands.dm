/turf/open/floor/plating/asteroid/whitesands
	name = "salted sand"
	baseturfs = /turf/open/floor/plating/asteroid/whitesands
	icon = 'voidcrew/icons/turf/floors/whitesands.dmi'
	icon_state = "sand"
	planetary_atmos = TRUE
	initial_gas_mix = WHITESANDS_PLANET_ATMOS //Fallback, and used to tell the AACs that this is the exterior
	digResult = /obj/item/stack/ore/glass
	light_range = 2
	light_power = 0.6
	light_color = COLOR_VERY_LIGHT_GRAY

/// Drops itemstack when dug and changes icon
/turf/open/floor/plating/asteroid/getDug()
	new digResult(src, 5)
	icon_state = "[initial(src.icon_state)]_dug"
	dug = TRUE

/turf/open/floor/plating/asteroid/whitesands/dried
	name = "dried sand"
	baseturfs = /turf/open/floor/plating/asteroid/whitesands/dried
	icon_state = "dried_up"
	digResult = /obj/item/stack/ore/glass

/turf/open/floor/plating/asteroid/whitesands/remove_air(amount)
	return return_air()

/turf/open/floor/plating/grass/whitesands
	initial_gas_mix = WHITESANDS_PLANET_ATMOS
