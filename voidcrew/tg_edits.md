## List of all edits voidcrew code touches, within TG files:

- build.js - Adds our files to be checked when building

- code/__HELPERS/mobs.dm
	- Modifies /proc/random_features() for IPC sprite accessories
- code/datums/emotes.dm
	- Modifies /datum/emote/proc/select_message_type(), checks for IPC specific emotes
- code/modules/client/preferences_savefile.dm
	- Modifies /datum/preferences/save_preferences(), IPC preferences
- code/modules/client/preferences.dm
	- Modifies /datum/preferences/proc/ShowChoices, IPC preferences
- code/modules/mob/living/carbon/human/species.dm
	- Modifies /datum/species/proc/handle_mutant_bodyparts(), IPC parts
- code/modules/reagents/chemistry/holder.dm
	- Modifies /datum/reagents/proc/metabolize() for the reagent flag consumption
- code/modules/surgery/organ_manipulation.dm
	- Modifies /datum/surgery_step/manipulate_organs/preop()
