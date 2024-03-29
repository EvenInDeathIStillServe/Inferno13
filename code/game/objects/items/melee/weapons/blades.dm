/obj/item/melee/blade
	icon = 'icons/obj/weapons/blades.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	attack_verb_continuous = list("slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	w_class = WEIGHT_CLASS_NORMAL
	sharpness = SHARP_EDGED
	hitsound = 'sound/weapons/bladeslice.ogg'
	damtype = SLASH
//	charging_slowdown = 0.4
	combat_skill = /datum/skill/blades

/obj/item/melee/blade/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/eyestab)
	set_butchering()

/obj/item/melee/blade/proc/set_butchering()
	AddComponent(/datum/component/butchering, 50 - force, 100, force - 10) //bonus chance increases depending on force

/obj/item/melee/blade/suicide_act(mob/user)
	user.visible_message(pick(span_suicide("[user] is slitting [user.p_their()] wrists with the [src.name]! It looks like [user.p_theyre()] trying to commit suicide."), \
						span_suicide("[user] is slitting [user.p_their()] throat with the [src.name]! It looks like [user.p_theyre()] trying to commit suicide."), \
						span_suicide("[user] is slitting [user.p_their()] stomach open with the [src.name]! It looks like [user.p_theyre()] trying to commit seppuku.")))
	return (BRUTELOSS)

/obj/item/melee/blade/kitchen_knife
	name = "kitchen knife"
	icon_state = "kitchen_knife"
	worn_icon_state = "knife"
	desc = "For putting food on the table, in more ways than one."
	flags_1 = CONDUCT_1
	force = 17
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 15
	throw_speed = 3
	throw_range = 6
	custom_materials = list(/datum/material/iron=12000)
	wound_bonus = 5
	bare_wound_bonus = 15
	tool_behaviour = TOOL_KNIFE
	charge_time = 1.5 SECONDS
	obj_value = 75

/obj/item/melee/blade/scrap_machete
	name = "scrap machete"
	icon_state = "scrap_machete"
	worn_icon_state = "knife"
	desc = "It's just a rusty lawnmower blade with a handle, but it'll do the job."
	flags_1 = CONDUCT_1
	force = 27
	throwforce = 25
	wound_bonus = 5
	bare_wound_bonus = 20
	tool_behaviour = TOOL_KNIFE
	charge_time = 1.8 SECONDS
	minimum_combat_skill = 4
	parry_class = 2
	obj_value = 300