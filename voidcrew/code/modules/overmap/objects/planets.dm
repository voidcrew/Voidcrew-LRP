/obj/structure/overmap/dynamic
	name = "weak energy signature"
	desc = "A very weak energy signal. It may not still be here if you leave it."
	icon_state = "strange_event"

	///The z level linked to this planet
	var/linked_zlevel
	///What kind of planet the level is, if it's a planet at all.
	var/datum/overmap/planet/planet


	//VOID TODO: probably remove all of these
	///The docking port in the reserve
	var/obj/docking_port/stationary/reserve_dock
	///The docking port in the reserve
	var/obj/docking_port/stationary/reserve_dock_secondary


	///Keeps track of docks taken
	var/first_dock_taken = FALSE
	var/second_dock_taken = FALSE

/obj/structure/overmap/dynamic/attack_ghost(mob/user)
	. = ..()

	if (!isnull(linked_zlevel))
		user.z = linked_zlevel // send them to da planet
