/obj/structure/simple_door/private
	name = "private door"
	desc = "A reinforced airlock controlled by a connected voice-activated panel. It appears to be impervious to damage: seems privacy is taken quite seriously around here."
	icon_state = "private"
	door_type = "private"
	open_sound = "sound/machines/private_open.ogg"
	close_sound = "sound/machines/private_close.ogg"
	explosion_block = 5
	hard_open = 0
	var/accommodation_id
	var/locked = TRUE
	var/obj/structure/simple_door/private/connected
	var/obj/machinery/door_panel/panel
	var/turf/open/floor/exit

/obj/structure/simple_door/private/Initialize(mapload)
	. = ..()

	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = .proc/on_entered
	)
	AddElement(/datum/element/connect_loc, loc_connections)

	for (var/carddir in GLOB.cardinals)
		var/turf/open/floor/current_turf = get_step(src, carddir)
		if (istype(current_turf))
			exit = current_turf
			break
	if (locked)
		icon_state = "[door_type]locked"

/obj/structure/simple_door/private/proc/on_entered(datum/source, atom/movable/AM)
	if (!connected)
		return
	if (!connected.exit)
		return
	if (ishuman(AM))
		var/mob/living/carbon/human/user = AM
		var/atom/movable/pulled = user.pulling
		if (pulled)
			pulled.forceMove(connected.exit)
		user.forceMove(connected.exit)
		if (pulled)
			user.start_pulling(pulled)
	else
		AM.forceMove(connected.exit)

/obj/structure/simple_door/private/TryToSwitchState(atom/user, animate)
	if(moving)
		return 0
	if(isliving(user))
		var/mob/living/M = user
		if(M.client)
			if (locked)
				playsound(src.loc, "sound/machines/airlock_deny.ogg", 30, 0, 0)
				flick("[door_type]deny", src)
				return 0
			if(iscarbon(M))
				var/mob/living/carbon/C = M
				if(!C.handcuffed)
					SwitchState(animate)
					return 1
			else
				SwitchState(animate)
				return 1
	return 0

/obj/structure/simple_door/private/proc/connect_door()

/obj/structure/simple_door/private/Open(animate)
	..()
	if (connected && !connected.moving && connected.density)
		connected?.Open(animate)

/obj/structure/simple_door/private/Close(animate)
	..()
	if (connected && !connected.moving && !connected.density)
		connected?.Close(animate)

/obj/structure/simple_door/private/proc/switch_lock()
	if (locked)
		unlock()
		connected?.unlock()
	else
		if (!density)
			playsound(loc, "sound/machines/airlock_deny.ogg", 30, 0, 0)
			return
		lock()
		connected?.lock()
	playsound(src.loc, "sound/machines/airlock_boltswitch.ogg", 30, 0, 0)

/obj/structure/simple_door/private/proc/lock()
	locked = TRUE
	icon_state = "[door_type]locked"

/obj/structure/simple_door/private/proc/unlock()
	locked = FALSE
	icon_state = "[door_type]"

/obj/structure/simple_door/private/outer/Initialize()
	. = ..()
	GLOB.outerdoors += src

/obj/structure/simple_door/private/outer/Destroy()
	GLOB.outerdoors -= src
	. = ..()

/obj/structure/simple_door/private/inner/Initialize()
	. = ..()
	GLOB.innerdoors += src

/obj/structure/simple_door/private/inner/Destroy()
	GLOB.innerdoors -= src
	. = ..()

/obj/structure/simple_door/private/outer/connect_door()
	if (connected)
		return
	for (var/obj/structure/simple_door/private/inner/inner in GLOB.innerdoors)
		if (accommodation_id == inner.accommodation_id)
			connected = inner
			inner.connected = src
			break

/obj/structure/simple_door/private/inner/connect_door()
	if (connected)
		return
	for (var/obj/structure/simple_door/private/outer/outer in GLOB.outerdoors)
		if (accommodation_id == outer.accommodation_id)
			connected = outer
			outer.connected = src
			break



/obj/machinery/door_panel
	name = "door panel"
	desc = "A VoxGuard palmpad, microphone and speaker combo that controls the locking mechanism for a private door."
	icon = 'icons/obj/wallmounts.dmi'
	icon_state = "door_panel"
	var/owner_tag //The clone tag of the owner
	var/obj/structure/simple_door/private/door

/obj/machinery/door_panel/Initialize(mapload)
	..()
	door = locate() in orange(1,src)
	if (door)
		door.panel = src

/obj/machinery/door_panel/examine(mob/user)
	. = ..()
	if(door)
		. += "<b>It's registered to apartment number <b>[door.accommodation_id]</b>. [owner_tag ? "It's occupied." : "It's available for rent."]"

/obj/machinery/door_panel/attack_hand(mob/living/carbon/human/user, list/modifiers)
	if (!door)
		return
	if (!ishuman(user))
		return
	if (!owner_tag)
		if (user.mind.rented_accommodation)
			to_chat(user, span_warning("Slow down, Donald Trump. You can only have one apartment."))
			return
		to_chat(user, span_notice("You interface your wristpad with [src] and begin registering yourself as the new owner of the apartment."))
		if (do_after(user, 5 SECONDS, target = src))
			if (user.payact(-2000))
				to_chat(user, span_nicegreen("You now own this apartment."))
				owner_tag = user.clone_tag
				door.connect_door()
				door.connected.panel.owner_tag = owner_tag
				user.award_journal(/datum/journal/tenant)
				return
			else
				to_chat(user, span_warning("You seem to be broke. Try not being so."))
				return
	if (user.clone_tag == owner_tag)
		door.switch_lock()
	else
		playsound(door.loc, "sound/machines/airlock_deny.ogg", 30, 0, 0)