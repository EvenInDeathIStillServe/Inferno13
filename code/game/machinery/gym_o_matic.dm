/obj/machinery/gym_o_matic
	name = "Gym-O-Matic"
	desc = "Gone are the days where you had to spend hours on end working on your physique or mind. With Gym-O-Matic, perfection is just a moment away... and what an excruciating moment it is."
	icon = 'icons/obj/machines/fat_sucker.dmi'
	icon_state = "fat"
	state_open = FALSE
	density = TRUE
	var/processing = FALSE
	var/datum/looping_sound/microwave/soundloop


/obj/machinery/gym_o_matic/Initialize(mapload)
	. = ..()
	soundloop = new(src,  FALSE)
	update_appearance()

/obj/machinery/gym_o_matic/Destroy()
	QDEL_NULL(soundloop)
	. = ..()

/obj/machinery/gym_o_matic/close_machine(mob/living/carbon/human/user)
	if(panel_open)
		to_chat(user, span_warning("You need to close the maintenance hatch first!"))
		return
	..()
	playsound(src, 'sound/machines/click.ogg', 50)
	if(occupant)
		if(!ishuman(occupant))
			occupant.forceMove(drop_location())
			set_occupant(null)
			return
		var/mob/living/carbon/human/gymmer = occupant
		to_chat(gymmer, span_notice("You enter [src]."))
		if (gymmer.free_points < 1)
			to_chat(user, span_warning("You don't have any development points."))
			update_appearance()
			return
		var/list/choices = list(STAT_NEURONS = "neurons", STAT_MUSCLES = "muscles", STAT_HEART = "heart",
								STAT_NERVES = "nerves", STAT_SENSES = "senses", STAT_EGO = "ego")
		var/choice = show_radial_menu(
			gymmer,
			src,
			choices,
			custom_check = CALLBACK(src, .proc/check_occupant, gymmer),
			require_near = TRUE,
		)
		if (!choice)
			return
		var/points_to_spend = FLOOR(input(gymmer, "How many points do you want to spend?", "[capitalize(choice)]", 0) as num|null, 1)
		if (!points_to_spend || points_to_spend < 0)
			return
		if (gymmer.free_points < points_to_spend)
			to_chat(user, span_warning("You don't have enough development points."))
		else
			processing = TRUE
			soundloop.start()
			set_light(2, 1, "#ff0000")
			addtimer(CALLBACK(src, .proc/gym_it, gymmer, choice, points_to_spend), 50)
		update_appearance()

/obj/machinery/gym_o_matic/proc/gym_it(mob/living/carbon/human/gymmer, stat, points)
	if (processing && check_occupant(gymmer))
		gymmer.vars[stat] += points
		gymmer.free_points -= points
		to_chat(gymmer, span_notice("Your <b>[capitalize(stat)]</b> attribute has been increases by <b>[points] points</b>."))
		gymmer.save_clone_data()
		stop()
		open_machine()
		playsound(src, 'sound/machines/microwave/microwave-end.ogg', 100, FALSE)

/obj/machinery/gym_o_matic/proc/check_occupant(mob/living/carbon/human/user)
	if (!istype(user))
		return
	if (occupant == user)
		return TRUE

/obj/machinery/gym_o_matic/open_machine(mob/user)
	playsound(src, 'sound/machines/click.ogg', 50)
	if(processing)
		stop()
	..()

/obj/machinery/gym_o_matic/interact(mob/living/carbon/human/user)
	if (!istype(user))
		return
	if(state_open)
		close_machine()
	else if(!processing)
		open_machine()

/obj/machinery/gym_o_matic/update_overlays()
	. = ..()

	if(!state_open)
		if(processing)
			. += "[icon_state]_door_on"
			. += "[icon_state]_stack"
			. += "[icon_state]_smoke"
			. += "[icon_state]_green"
		else
			. += "[icon_state]_door_off"
			if(occupant)
				if(powered())
					. += "[icon_state]_stack"
					. += "[icon_state]_yellow"
			else
				. += "[icon_state]_red"
	else if(powered())
		. += "[icon_state]_red"
	if(panel_open)
		. += "[icon_state]_panel"

/obj/machinery/gym_o_matic/proc/stop()
	processing = FALSE
	soundloop.stop()
	set_light(0, 0)