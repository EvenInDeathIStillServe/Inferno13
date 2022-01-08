/obj/structure/electrical_panel
	name = "electrical panel"
	desc = "A hatch containing various cables and electrical doodads."
	icon = 'icons/obj/wallmounts.dmi'
	icon_state = "caution"
	anchored = TRUE
	density = FALSE
	var/open = FALSE
	var/shorted = FALSE

/obj/structure/electrical_panel/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)
	short_out()

/obj/structure/electrical_panel/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/structure/electrical_panel/process(delta_time)
	if (shorted)
		if (DT_PROB(20, delta_time))
			do_sparks(rand(1,2), FALSE, src)

/obj/structure/electrical_panel/examine(mob/user)
	. = ..()
	if (shorted)
		. += span_warning("It looks broken.")

/obj/structure/electrical_panel/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if (.)
		return
	if (shorted)
		if (open)
			to_chat(user, span_warning("[src] is broken. It should be repaired before putting the hatch back."))
		else
			to_chat(user, span_notice("You open [src]."))
			open = TRUE
			playsound(src, 'sound/machines/closet2_open.ogg', 75, TRUE)
			update_appearance()

	else
		if (open)
			to_chat(user, span_notice("You close [src]."))
			open = FALSE
			playsound(src, 'sound/machines/closet2_close.ogg', 75, TRUE)
			user.award_duty(/datum/duty/repairman)
			update_appearance()
			addtimer(CALLBACK(src, .proc/short_out), rand(30 SECONDS, 2 MINUTES))
		else
			to_chat(user, span_warning("[src] isn't broken. No need to mess around with it."))

/obj/structure/electrical_panel/update_icon_state()
	if (open)
		icon_state = "maintenance_full"
	else
		icon_state = "caution"
	return ..()

/obj/structure/electrical_panel/attackby(obj/item/W, mob/user, params)
	if (!shorted)
		to_chat(user, span_warning("[src] isn't broken. No need to mess around with it."))
		return
	if (!open)
		to_chat(user, span_warning("[src] is closed. You need to slide it open first."))
		return
	if (W.tool_behaviour == TOOL_SCREWDRIVER)
		to_chat(user, span_notice("You start fixing [src]..."))
		if (W.use_tool(src, user, 50, volume=50))
			var/repair_skill = user.mind?.get_skill_level(/datum/skill/repair)
			if (repair_skill < 2)
				to_chat(user, span_warning("You can't make head nor tail of this!"))
				return
			repair_skill += rand(1,3)
			if (repair_skill >= 5)
				to_chat(user, span_notice("You managed to fix [src]. Time to close the hatch."))
				user.mind.adjust_experience(/datum/skill/repair, 50)
				shorted = FALSE
			else
				to_chat(user, span_warning("You didn't manage to fully fix [src]."))
				user.mind.adjust_experience(/datum/skill/repair, 25)
	else
		to_chat(user, span_warning("You need a screwdriver to fix [src]."))
		return

/obj/structure/electrical_panel/proc/short_out()
	shorted = TRUE