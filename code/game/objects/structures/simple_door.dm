/obj/structure/simple_door
	name = "wooden door"
	desc = "It opens and closes - nothing out of the ordinary."
	icon = 'icons/obj/doors/infernodoors.dmi'
	icon_state = "house"
	opacity = TRUE
	density = TRUE
	anchored = TRUE
	layer = CLOSED_DOOR_LAYER
	explosion_block = 0.5
	var/can_hold_padlock = FALSE
	var/obj/item/lock_construct/padlock
	var/door_type = "house"
	var/base_opacity = TRUE
	var/manual_opened = 0
	var/material_count = 10
	var/hard_open = 1
	var/moving = 0
	var/material_type = /obj/item/stack/sheet/mineral/wood
	var/can_disasemble = 0
	var/open_sound = 'sound/machines/door_open.ogg'
	var/close_sound = 'sound/machines/door_close.ogg'
	var/opening_time = 2
	var/closing_time = 4

/obj/structure/simple_door/Initialize()
	. = ..()
	var/static/list/loc_connection = list(
		COMSIG_ATOM_EXITED =.proc/check_exit,
	)
	AddElement(/datum/element/connect_loc, loc_connection)
	icon_state = door_type


/obj/structure/simple_door/Destroy()
	if(padlock)
		padlock.forceMove(get_turf(src))
		padlock = null
	return ..()

/obj/structure/simple_door/update_overlays()
	..()
	if (padlock)
		. += "padlock"

/obj/structure/simple_door/proc/attach_padlock(obj/item/lock_construct/P, force = FALSE, mob/user)
	if(!force && (!can_hold_padlock || !P ))
		return FALSE
	if(padlock)
		to_chat(user, "[src] already has \a [padlock] attached")
		return FALSE
	padlock = P
	padlock.forceMove(src)
	update_icon()

/obj/structure/simple_door/proc/remove_padlock(force = FALSE)
	if(!force && (!padlock))
		return FALSE
	padlock.forceMove(get_turf(src))
	padlock = null
	update_icon()

/obj/structure/simple_door/Bumped(atom/user)
	..()
	if(density)
		if(hard_open)
			return TryToSwitchState(user, 0)
		else
			return TryToSwitchState(user, 1)
	return

/obj/structure/simple_door/proc/Open(animate)
	playsound(src.loc, open_sound, 30, 0, 0)
	if(animate)
		moving = 1
		flick("[door_type]opening", src)
		sleep(opening_time)
		moving = 0
	set_opacity(0)
	density = 0
	icon_state = "[door_type]open"
	layer = OPEN_DOOR_LAYER
	spawn (10 SECONDS)
		if (!density)
			SwitchState(TRUE)

/obj/structure/simple_door/proc/Close(animate)
	playsound(src.loc, close_sound, 30, 0, 0)
	manual_opened = 0
	if(animate)
		moving = 1
		flick("[door_type]closing", src)
		sleep(closing_time)
	icon_state = door_type
	set_opacity(base_opacity)
	density = 1
	moving = 0
	layer = CLOSED_DOOR_LAYER

/* can crowbar off a lock, to force a door open. This is overriden in airlock so shouldnt be an issue */
/obj/structure/simple_door/proc/try_to_crowbar(obj/item/I, mob/user)
	if(padlock) /* attempt to pry the lock off */
		if(padlock.pry_off(user,src))
			qdel(padlock)
			padlock = null
			src.desc = "[initial(desc)]"
	return

/obj/structure/simple_door/proc/SwitchState(animate)
	if(density)
		if(padlock)
			if(!padlock.locked)
				Open(animate)
			else
				playsound(src.loc, pick('sound/effects/door_knock1.wav', 'sound/effects/door_knock2.wav', 'sound/effects/door_knock3.wav', 'sound/effects/door_knock4.wav'), 80, 0, 0)

		else
			Open(animate)

	else
		var/turf/T = get_turf(src)
		for(var/mob/living/L in T)
			return
		Close(animate)
	return 1

/obj/structure/simple_door/attackby(obj/item/I, mob/living/user, params)
	if(!user.combat_mode && (istype(I, /obj/item/crowbar)))
		try_to_crowbar(I, user)
		return TRUE
	if(istype(I, /obj/item/screwdriver))
		if(padlock)
			to_chat(user, span_warning("Remove padlock before door dissasembling."))
			return 1
		else
			if(can_disasemble && do_after(user, 60, target = src))
				for(var/i = 1, i <= material_count, i++)
					new material_type(get_turf(src))
				to_chat(user,span_notice("You disassemble [name]."))
				playsound(loc, 'sound/items/Screwdriver.ogg', 25, -3)
				qdel(src)
				return 1
/*	if(istype(I, /obj/item/storage/keys_set))
		var/obj/item/storage/keys_set/S = I
		if(padlock)
			var/obj/item/key/K = S.get_key_with_id(padlock.id)
			if(istype(K))
				I = K
		if(istype(user.get_inactive_held_item(), /obj/item/lock))
			var/obj/item/lock/L = user.get_inactive_held_item()
			var/obj/item/key/K = S.get_key_with_id(L.id)
			if(istype(K))
				I = K
				*/
				//I'll deal with that shit later -harcourt
	if(istype(I, /obj/item/lock_construct) && can_hold_padlock)
		if(padlock)
			to_chat(user, "[src] already has \a [padlock] attached")
			return
		else
			if(user.transferItemToLoc(I, src))
				user.visible_message(span_notice("[user] adds [I] to [src]."), \
								span_notice("You add [I] to [src]."))
				if (istype(I, /obj/item/lock_construct))
					desc = "[src.desc] Has a lock."//Fuck it im not doing this bullshit tonight. This will do. :) -with love, harcourt
				padlock = I
	if(istype(I, /obj/item/key))
		if(!padlock)
			to_chat(user, "[src] has no lock attached")
			return
		else
			return padlock.check_key(I,user)
	if(user.combat_mode)
//		if(padlock)
//			add_logs(user, src, "attacked", src)
		return ..()
	attack_hand(user)



/obj/structure/simple_door/proc/TryToSwitchState(atom/user, animate)
	if(moving)
		return 0
	if(isliving(user))
		var/mob/living/M = user
		if(/obj/structure/barricade in loc)
			M << "It won't budge!"
			return 0
		if(M.client)
			if(iscarbon(M))
				var/mob/living/carbon/C = M
				if(!C.handcuffed)
					SwitchState(animate)
					return 1
			else
				SwitchState(animate)
				return 1
	return 0

/obj/structure/simple_door/attack_hand(mob/user)
	if(TryToSwitchState(user, 1) && !density)
		manual_opened = 1
	..()


/obj/structure/simple_door/attack_tk(mob/user)
	if(TryToSwitchState(user, 1) && !density)
		manual_opened = 1
	..()

/obj/structure/simple_door/proc/check_exit(atom/movable/O as mob|obj, target)
	if(O.loc == loc)
		return 1
	return !density

// Inferno 13 general doors directory

/obj/structure/simple_door/tentflap_leather
	name = "leather tent entrance"
	icon_state = "tentflap_leather"
	door_type = "tentflap_leather"
	can_disasemble = FALSE
	can_hold_padlock = FALSE
	open_sound = 'sound/effects/footstep/hardbarefoot4.ogg'
	close_sound = 'sound/effects/footstep/hardbarefoot5.ogg'

/obj/structure/simple_door/tentflap_cloth
	name = "cotton tent entrance"
	icon_state = "tentflap_cloth"
	door_type = "tentflap_cloth"
	can_disasemble = FALSE
	can_hold_padlock = FALSE
	open_sound = 'sound/effects/footstep/hardbarefoot4.ogg'
	close_sound = 'sound/effects//footstep/hardbarefoot5.ogg'

/obj/structure/simple_door/house
	icon_state = "house"
	door_type = "house"
	can_disasemble = 1
	can_hold_padlock = TRUE

/obj/structure/simple_door/interior
	icon_state = "interior"
	door_type = "interior"
	can_disasemble = 1
	can_hold_padlock = TRUE

/obj/structure/simple_door/room
	icon_state = "room"
	door_type = "room"
	can_disasemble = 1
	can_hold_padlock = TRUE

/obj/structure/simple_door/dirtyglass
	desc = "The glass is dirty, you can't see a thing behind it."
	icon_state = "dirtyglass"
	door_type = "dirtyglass"
	can_hold_padlock = TRUE

/obj/structure/simple_door/fakeglass
	name = "old damaged door"
	desc = "It still opens and closes somehow."
	icon_state = "fakeglass"
	door_type = "fakeglass"
	can_hold_padlock = TRUE

/obj/structure/simple_door/brokenglass
	name = "shattered door"
	desc = "It still opens and closes somehow."
	icon_state = "brokenglass"
	door_type = "brokenglass"
	opacity = FALSE
	base_opacity = FALSE
	can_hold_padlock = TRUE

/obj/structure/simple_door/glass
	desc = "The glass is quite clean, someone took care of this door."
	icon_state = "glass"
	door_type = "glass"
	opacity = FALSE
	base_opacity = FALSE
	can_hold_padlock = TRUE

/obj/structure/simple_door/wood
	icon_state = "wood"
	door_type = "wood"
	can_disasemble = 1
	can_hold_padlock = TRUE

/obj/structure/simple_door/metal
	name = "metal door"
	icon_state = "metal"
	material_type = /obj/item/stack/sheet/iron
	open_sound = "sound/machines/doorstore_open.ogg"
	close_sound = "sound/machines/doorstore_close.ogg"
	explosion_block = 2

/obj/structure/simple_door/metal/dirtystore
	desc = "A metal door with dirty glass. You can't see a thing behind it."
	icon_state = "dirtystore"
	door_type = "dirtystore"
	can_hold_padlock = TRUE

/obj/structure/simple_door/metal/store
	icon_state = "store"
	door_type = "store"
	opacity = FALSE
	base_opacity = FALSE
	can_disasemble = 1
	can_hold_padlock = TRUE

/obj/structure/simple_door/metal/iron
	name = "iron door"
	desc = "A heavy iron door."
	icon_state = "metal"
	door_type = "metal"
	explosion_block = 5
	can_hold_padlock = TRUE
	opening_time = 15
	closing_time = 10
	hard_open = 0

/obj/structure/simple_door/metal/barred
	name = "barred door"
	desc = "Bars. No matter which side we're on, aren't we always behind them?"
	icon_state = "barred"
	door_type = "barred"
	open_sound = "sound/machines/doorchainlink_open.ogg"
	close_sound = "sound/machines/doorchainlink_close.ogg"
	opacity = FALSE
	base_opacity = FALSE
	can_hold_padlock = TRUE

/obj/structure/simple_door/metal/ventilation
	name = "ventilation system"
	desc = "As you take a closer look, you notice a handle at the bottom of ventilation system access hatch."
	icon_state = "ventilation"
	door_type = "ventilation"
	open_sound = "sound/machines/doorhidden_open.ogg"
	close_sound = "sound/machines/doorhidden_close.ogg"
	hard_open = 0
	opening_time = 25
	closing_time = 20

/obj/structure/simple_door/blast
	name = "blast door"
	desc = "A blast door, alternatively referred to as a shielded door or safety door, is a type of door designed to be especially reliable and durable."
	icon_state = "blastdoor"
	door_type = "blastdoor"
	material_type = /obj/item/stack/sheet/plasteel
	open_sound = "sound/machines/doorblast_open.ogg"
	close_sound = "sound/machines/doorblast_close.ogg"
	explosion_block = 10
	hard_open = 0
	opening_time = 30
	closing_time = 20

/obj/structure/simple_door/bunker
	name = "airlock"
	desc = "An olive green painted airlock.<br>The door mechanism itself is a complex mix of an electic engine and hydraulic motion.<br>This particular door looks like a pre-Calamity military tech."
	icon_state = "bunker"
	door_type = "bunker"
	material_type = /obj/item/stack/sheet/iron
	open_sound = "sound/machines/doorairlock_open.ogg"
	close_sound = "sound/machines/doorairlock_close.ogg"
	explosion_block = 5
	hard_open = 0

/obj/structure/simple_door/bunker/glass
	desc = "An olive green painted airlock, with semi-transparent glass window.<br>The door mechanism itself is a complex mix of an electic engine and hydraulic motion.<br>This particular door looks like a pre-Calamity military tech."
	icon_state = "bunkerglass"
	door_type = "bunkerglass"
	explosion_block = 4 //A glass window in it, reduces the resistance, am I right?
	opacity = FALSE
	base_opacity = FALSE

/obj/structure/simple_door/tent
	name = "tent flap"
	desc = "A fairly simple looking entrance to a war tent."
	icon_state = "tent"
	door_type = "tent"
	material_type = /obj/item/stack/sheet/cloth
	open_sound = "sound/effects/curtain.ogg"
	close_sound = "sound/effects/curtain.ogg"
	can_hold_padlock = TRUE
	hard_open = 0

/obj/effect/door_chime
	name = "door chime"
	invisibility = INVISIBILITY_ABSTRACT

/obj/effect/door_chime/Initialize(mapload)
	. = ..()

	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = .proc/on_entered
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/effect/door_chime/proc/on_entered(datum/source, atom/movable/AM)
	if (ishuman(AM))
		playsound(src, 'sound/machines/door_chime.ogg', 50, TRUE)