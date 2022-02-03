/datum/controller/subsystem/blackbox/LogBroadcast(freq)
	if (sealed)
		return
	if (freq == FREQ_SOLGOV)
		record_feedback("tally", "radio_usage", 1, "solgov")
	return ..()
