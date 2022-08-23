/datum/hud/new_player

/datum/hud/new_player/New(mob/owner)
	..()
	if (owner?.client?.interviewee)
		return
	var/list/buttons = subtypesof(/atom/movable/screen/lobby)
	for(var/button in buttons)
		var/atom/movable/screen/lobbyscreen = new button()
		lobbyscreen.hud = src
		static_inventory += lobbyscreen

/atom/movable/screen/lobby
	plane = SPLASHSCREEN_PLANE
	layer = LOBBY_BUTTON_LAYER
	screen_loc = "TOP,CENTER"

/atom/movable/screen/lobby/background
	layer = LOBBY_BACKGROUND_LAYER
	icon = 'icons/hud/lobby/background.dmi'
	icon_state = "background"
	screen_loc = "TOP,CENTER:-61"

/atom/movable/screen/lobby/button
	///Is the button currently enabled?
	var/enabled = TRUE
	///Is the button currently being hovered over with the mouse?
	var/highlighted = FALSE

/atom/movable/screen/lobby/button/Click(location, control, params)
	. = ..()
	if(!enabled)
		return
	flick("[base_icon_state]_pressed", src)
	update_icon()
	return TRUE

/atom/movable/screen/lobby/button/MouseEntered(location,control,params)
	. = ..()
	highlighted = TRUE
	update_icon()

/atom/movable/screen/lobby/button/MouseExited()
	. = ..()
	highlighted = FALSE
	update_icon()

/atom/movable/screen/lobby/button/update_icon(updates)
	. = ..()
	if(!enabled)
		icon_state = "[base_icon_state]_disabled"
		return
	else if(highlighted)
		icon_state = "[base_icon_state]_highlighted"
		return
	icon_state = base_icon_state

/atom/movable/screen/lobby/button/proc/set_button_status(status)
	if(status == enabled)
		return FALSE
	enabled = status
	update_icon()
	return TRUE

///Prefs menu
/atom/movable/screen/lobby/button/character_setup
	screen_loc = "TOP:-70,CENTER:-54"
	icon = 'icons/hud/lobby/character_setup.dmi'
	icon_state = "character_setup"
	base_icon_state = "character_setup"

/atom/movable/screen/lobby/button/character_setup/Click(location, control, params)
	. = ..()
	if(!.)
		return
	hud.mymob.client.prefs.ShowChoices(hud.mymob)

///Button that appears before the game has started
/atom/movable/screen/lobby/button/ready
	screen_loc = "TOP:-8,CENTER:-65"
	icon = 'icons/hud/lobby/ready.dmi'
	icon_state = "not_ready"
	base_icon_state = "not_ready"
	var/ready = FALSE

/atom/movable/screen/lobby/button/ready/Initialize(mapload)
	. = ..()
	if(SSticker.current_state > GAME_STATE_PREGAME)
		set_button_status(FALSE)
	else
		RegisterSignal(SSticker, COMSIG_TICKER_ENTER_SETTING_UP, .proc/hide_ready_button)

/atom/movable/screen/lobby/button/ready/proc/hide_ready_button()
	SIGNAL_HANDLER
	set_button_status(FALSE)
	UnregisterSignal(SSticker, COMSIG_TICKER_ENTER_SETTING_UP)

/atom/movable/screen/lobby/button/ready/Click(location, control, params)
	. = ..()
	if(!.)
		return
	var/mob/dead/new_player/new_player = hud.mymob
	ready = !ready
	if(ready)
		new_player.ready = PLAYER_READY_TO_PLAY
		base_icon_state = "ready"
	else
		new_player.ready = PLAYER_NOT_READY
		base_icon_state = "not_ready"
	update_icon()

///Shown when the game has started
/atom/movable/screen/lobby/button/join
	screen_loc = "TOP:-13,CENTER:-58"
	icon = 'icons/hud/lobby/join.dmi'
	icon_state = "" //Default to not visible
	base_icon_state = "join_game"
	enabled = FALSE

/atom/movable/screen/lobby/button/join/Initialize(mapload)
	. = ..()
	if(SSticker.current_state > GAME_STATE_PREGAME)
		set_button_status(TRUE)
	else
		RegisterSignal(SSticker, COMSIG_TICKER_ENTER_SETTING_UP, .proc/show_join_button)

/atom/movable/screen/lobby/button/join/proc/show_join_button(status)
	SIGNAL_HANDLER
	set_button_status(TRUE)
	UnregisterSignal(SSticker, COMSIG_TICKER_ENTER_SETTING_UP)

/atom/movable/screen/lobby/button/observe
	screen_loc = "TOP:-40,CENTER:-54"
	icon = 'icons/hud/lobby/observe.dmi'
	icon_state = "observe_disabled"
	base_icon_state = "observe"
	enabled = FALSE

/atom/movable/screen/lobby/button/observe/Initialize(mapload)
	. = ..()
	if(SSticker.current_state > GAME_STATE_STARTUP)
		set_button_status(TRUE)
	else
		RegisterSignal(SSticker, COMSIG_TICKER_ENTER_PREGAME, .proc/enable_observing)

/atom/movable/screen/lobby/button/observe/Click(location, control, params)
	. = ..()
	if(!.)
		return
	var/mob/dead/new_player/new_player = hud.mymob
	new_player.make_me_an_observer()

/atom/movable/screen/lobby/button/observe/proc/enable_observing()
	SIGNAL_HANDLER
	flick("[base_icon_state]_enabled", src)
	set_button_status(TRUE)
	UnregisterSignal(SSticker, COMSIG_TICKER_ENTER_PREGAME, .proc/enable_observing)


/* This is here for a future settings menu that will come with the prefs rework, if this is not in by 2022 kill mothblocks.
/atom/movable/screen/lobby/button/settings
	icon = 'icons/hud/lobby/bottom_buttons.dmi'
	icon_state = "settings"
	base_icon_state = "settings"
	screen_loc = "TOP:-122,CENTER:+58"
/atom/movable/screen/lobby/button/settings/Click(location, control, params)
	. = ..()
	if(!.)
		return
	hud.mymob.client.prefs.ShowChoices(hud.mymob)
*/


/atom/movable/screen/lobby/button/changelog_button
	icon = 'icons/hud/lobby/bottom_buttons.dmi'
	icon_state = "changelog"
	base_icon_state = "changelog"
	screen_loc ="TOP:-122,CENTER:+58"


/atom/movable/screen/lobby/button/crew_manifest
	icon = 'icons/hud/lobby/bottom_buttons.dmi'
	icon_state = "crew_manifest"
	base_icon_state = "crew_manifest"
	screen_loc = "TOP:-122,CENTER:+30"

/atom/movable/screen/lobby/button/crew_manifest/Click(location, control, params)
	. = ..()
	if(!.)
		return
	var/mob/dead/new_player/new_player = hud.mymob
	new_player.ViewManifest()

/atom/movable/screen/lobby/button/changelog_button/Click(location, control, params)
	. = ..()
	usr.client?.changelog()

/atom/movable/screen/lobby/button/poll
	icon = 'icons/hud/lobby/bottom_buttons.dmi'
	icon_state = "poll"
	base_icon_state = "poll"
	screen_loc = "TOP:-122,CENTER:+2"

	var/new_poll = FALSE

///Need to use New due to init
/atom/movable/screen/lobby/button/poll/New(loc, ...)
	. = ..()
	if(!usr) //
		return
	var/mob/dead/new_player/new_player = usr
	if(IsGuestKey(new_player.key))
		set_button_status(FALSE)
		return
	if(!SSdbcore.Connect())
		set_button_status(FALSE)
		return
	var/isadmin = FALSE
	if(new_player.client?.holder)
		isadmin = TRUE

/atom/movable/screen/lobby/button/poll/update_overlays()
	. = ..()
	if(new_poll)
		. += mutable_appearance('icons/hud/lobby/poll_overlay.dmi', "new_poll")

/atom/movable/screen/lobby/button/poll/Click(location, control, params)
	. = ..()
	if(!.)
		return
	var/mob/dead/new_player/new_player = hud.mymob
	new_player.handle_player_polling()
