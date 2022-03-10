/obj/item/bodypart/heal_damage(brute, burn, stamina, required_status, updating_health = TRUE)
	. = ..()

	if (isnull(owner))
		return
	if (isnull(owner.dna?.species) || !(REVIVESBYHEALING in owner.dna.species.species_traits))
		return
	if (owner.health <= 0)
		return
	owner.revive(full_heal = FALSE)
	owner.cure_husk()
	return
