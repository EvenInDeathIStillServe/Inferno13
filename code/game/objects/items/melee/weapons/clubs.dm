/obj/item/melee/club
	icon = 'icons/obj/weapons/clubs.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	hitsound = 'sound/weapons/genhit1.ogg'
	damtype = BEAT

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
	obj_value = 100

/obj/item/melee/club/crowbar
	name = "crowbar"
	desc = "It's a big crowbar. It doesn't fit in your pockets, because it's big."
	icon_state = "crowbar_large"
	force = 23
	charge_time = 2.2 SECONDS
	throw_speed = 3
	throw_range = 3
	obj_value = 120

/obj/item/melee/club/fireaxe
	name = "fire axe"
	desc = "Truly, the weapon of a madman. Who would think to fight fire with an axe?"
	icon_state = "fireaxe0"
	force = 15
	throwforce = 30
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	attack_verb_continuous = list("attacks", "chops", "cleaves", "tears", "lacerates", "cuts")
	attack_verb_simple = list("attack", "chop", "cleave", "tear", "lacerate", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	damtype = SLASH
	resistance_flags = FIRE_PROOF
	wound_bonus = -15
	bare_wound_bonus = 20
	charge_time = 3 SECONDS
	obj_value = 200

/obj/item/melee/club/fireaxe/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 100, 80, 0 , hitsound) //axes are not known for being precision butchering tools
	AddComponent(/datum/component/two_handed, force_unwielded=25, force_wielded=40, icon_wielded="fireaxe1")