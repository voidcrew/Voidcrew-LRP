/obj/effect/proc_holder/spell/aoe_turf/conjure/crystal_hivelord
	name = "Summon Hivelord Swarm"
	desc = "This spell tears the fabric of reality, allowing crystal hivelords to spill forth."

	school = "conjuration"
	charge_max = 600
	clothes_req = FALSE
	invocation = "SKEST ZA!"
	invocation_type = INVOCATION_SHOUT
	summon_amt = 3
	range = 3

	summon_type = list(/mob/living/simple_animal/hostile/asteroid/hivelord/beach)
	cast_sound = 'sound/magic/summonitems_generic.ogg'
