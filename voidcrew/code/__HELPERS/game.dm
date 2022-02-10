/**
 * Notifies a human mob of their faction and enemies
 *
 * Arguments:
 * * mob/living/carbon/human/character - the human character mob you want to notify
 * * obj/structure/overmap/ship/simulated/ship - Simulated ship that contains the ship's prefix
 */
/proc/NotifyFaction(mob/living/carbon/human/character, obj/structure/overmap/ship/simulated/ship)
	switch(ship.source_template.prefix)
		if("NT-C")
			to_chat(character, "<h1>Your faction: Nanotrasen Combat Vessel (NT-C)</h1>")
			to_chat(character, "<h1>NT-C enemies: SYN-C and KOS</h1>")
		if("SYN-C")
			to_chat(character, "<h1>Your faction: Syndicate Combat Vessel (SYN-C)</h1>")
			to_chat(character, "<h1>SYN-C ship enemies: NT-C and KOS</h1>")
		if("NEU")
			to_chat(character, "<h1>Your faction: Neutral (NEU)</h1>")
			to_chat(character, "<h1>NEU ship enemies: NONE</h1>")
			to_chat(character, "<h2>Tag your ship with KOS to fight NT-C, SYN-C, and KOS ships</h2>")
		else
			return
