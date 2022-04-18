/obj/structure/closet/crate/grave
	name = "grave"
	desc = "A marked patch of soil, showing signs of a burial long ago. You wouldn't disturb a grave... right?"
	icon_state = "grave"
	dense_when_open = FALSE
	material_drop = /obj/item/stack/ore/dirt
	material_drop_amount = 5
	anchorable = FALSE
	anchored = TRUE
	breakout_time = 900
	open_sound = 'sound/effects/shovel_dig.ogg'
	close_sound = 'sound/effects/shovel_dig.ogg'
	cutting_tool = /obj/item/melee/club/shovel
	can_install_electronics = FALSE

/obj/structure/closet/crate/grave/open(mob/living/user, obj/item/S, force = FALSE)
	if(!opened)
		to_chat(user, span_notice("The ground here is too hard to dig up with your bare hands. You'll need a shovel."))
	else
		to_chat(user, span_notice("The grave has already been dug up."))

/obj/structure/closet/crate/grave/tool_interact(obj/item/S, mob/living/carbon/user)
	if(!opened)
		if(istype(S,cutting_tool) && S.tool_behaviour == TOOL_SHOVEL)
			to_chat(user, span_notice("You start start to dig open \the [src]  with \the [S]..."))
			if (do_after(user,20, target = src))
				opened = TRUE
				dump_contents()
				update_appearance()
				return 1
			return 1
		else
			to_chat(user, span_notice("You can't dig up a grave with \the [S.name]."))
			return 1
	else
		to_chat(user, span_notice("The grave has already been dug up."))
		return 1
	return

/obj/structure/closet/crate/grave/bust_open()
	..()
	opened = TRUE
	update_appearance()
	dump_contents()
	return