/world/proc/init_custom_say_radio_globs()
	GLOB.radiochannels |= list(RADIO_CHANNEL_SOLGOV = FREQ_SOLGOV, RADIO_CHANNEL_WIDEBAND = FREQ_WIDEBAND)
	GLOB.reverseradiochannels |= list("[FREQ_SOLGOV]" = RADIO_CHANNEL_SOLGOV, "[FREQ_WIDEBAND]" = RADIO_CHANNEL_WIDEBAND)

	GLOB.freqtospan |= list("[FREQ_SOLGOV]" = "solgovradio", "[FREQ_WIDEBAND]" = "widebandradio")
