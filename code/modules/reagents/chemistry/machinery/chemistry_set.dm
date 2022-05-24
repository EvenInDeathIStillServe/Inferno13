/obj/machinery/chemistry_set
	name = "chemistry set"
	density = TRUE
	icon = 'icons/obj/chemical.dmi'
	icon_state = "chemistry_set"
	base_icon_state = "chemistry_set"
	resistance_flags = FIRE_PROOF | ACID_PROOF

	var/obj/item/reagent_containers/beaker = null
	var/on = FALSE

	var/static/radial_mix = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_mix")
	var/static/radial_eject = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_eject")

/obj/machinery/chemistry_set/Destroy()
	if(beaker)
		QDEL_NULL(beaker)
	return ..()


/obj/machinery/chemistry_set/update_icon_state()
	if (on)
		icon_state = "chemistry_set_active"
	else
		icon_state = "chemistry_set[beaker ? "_full" : ""]"
	return ..()

/obj/machinery/chemistry_set/attackby(obj/item/I, mob/user, params)
	if (beaker)
		if (istype(I, /obj/item/reagent_containers/dropper))
			var/obj/item/reagent_containers/dropper/D = I
			D.afterattack(beaker, user, 1)
			return
		if (istype(I, /obj/item/reagent_containers/syringe))
			var/obj/item/reagent_containers/syringe/S = I
			S.afterattack(beaker, user, 1)
			return
		if (istype(I, /obj/item/reagent_containers) && !(I.item_flags & ABSTRACT) && I.is_open_container())
			var/obj/item/reagent_containers/C = I
			C.afterattack(beaker, user, 1)
			return
	else if(istype(I, /obj/item/reagent_containers) && !(I.item_flags & ABSTRACT) && I.is_open_container())
		. = TRUE //no afterattack
		var/obj/item/reagent_containers/B = I
		if(!user.transferItemToLoc(B, src))
			return
		beaker = B
		to_chat(user, span_notice("You add [B] to [src]."))
		update_appearance()
		return

	return ..()

/obj/machinery/chemistry_set/interact(mob/living/carbon/human/user)
	if (!check_interactable(user))
		return

	var/list/choices = list()
	if (beaker?.reagents.total_volume)
		choices["mix"] = radial_mix
	choices["eject"] = radial_eject

	var/choice

	if(length(choices) < 1)
		return
	if(length(choices) == 1)
		for(var/key in choices)
			choice = key
	else
		choice = show_radial_menu(user, src, choices, require_near = !issilicon(user))

	if (!check_interactable(user))
		return

	switch (choice)
		if ("mix")
			mix_chemicals(user)
		if ("eject")
			eject_beaker(user)

/obj/machinery/chemistry_set/proc/mix_chemicals(mob/living/carbon/human/user)
	on = TRUE
	update_appearance()
	to_chat(user, span_notice("You set up [src] and start the reaction."))
	playsound(src.loc, 'sound/machines/hiss.ogg', 50, TRUE)
	var/chemistry_skill = user.mind.get_effective_skill(/datum/skill/science) + rand(-4,4)
	addtimer(CALLBACK(src, /obj/machinery/chemistry_set/proc/finish_reaction, chemistry_skill), 50)

/obj/machinery/chemistry_set/proc/finish_reaction(chemistry_skill)
	beaker.reagents.handle_reactions(TRUE, chemistry_skill)
	on = FALSE
	update_appearance()

/obj/machinery/chemistry_set/proc/eject_beaker(mob/living/carbon/human/user)
	try_put_in_hand(beaker, user)
	beaker = null
	update_appearance()
	return TRUE

/obj/machinery/chemistry_set/proc/check_interactable(mob/living/carbon/human/user)
	if (!user)
		return
	if (on)
		return
	if (!beaker)
		return
	return TRUE

/obj/machinery/chemistry_set/examine(mob/user)
	. = ..()
	if(!in_range(user, src) && !isobserver(user))
		. += span_warning("You're too far away to examine [src]'s contents and display!")
		return

	if(on)
		. += span_warning("\The [src] is operating.")
		return

	if(beaker)
		. += span_notice("\The [src] contains <b>\a [beaker]</b>.")
		for(var/datum/reagent/R in beaker.reagents.reagent_list)
			. += span_notice("- [R.volume] units of [R.name].")

/obj/machinery/chemistry_set/packit_up(mob/living/carbon/human/user)
	if (on)
		to_chat(user, span_warning("[src] is currently operating."))
		return
	if (beaker)
		beaker.forceMove(get_turf(src))
		beaker = null
	..()