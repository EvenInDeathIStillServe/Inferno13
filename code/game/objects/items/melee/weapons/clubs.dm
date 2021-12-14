/obj/item/melee/club
	icon = 'icons/obj/weapons/clubs.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/melee/club/baseball_bat
	name = "baseball bat"
	desc = "There ain't a skull in the league that can withstand a swatter."
	icon_state = "baseball_bat"
	force = 20
	wound_bonus = -10
	throwforce = 12
	attack_verb_continuous = list("beats", "smacks")
	attack_verb_simple = list("beat", "smack")
	custom_materials = list(/datum/material/wood = MINERAL_MATERIAL_AMOUNT * 3.5)

/obj/item/melee/club/crowbar
	name = "crowbar"
	desc = "It's a big crowbar. It doesn't fit in your pockets, because it's big."
	icon_state = "crowbar_large"
	force = 23
	charge_time = 2.2 SECONDS
	throw_speed = 3
	throw_range = 3