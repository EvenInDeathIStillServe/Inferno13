/obj/item/melee/club
	icon = 'icons/obj/weapons/clubs.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	hitsound = 'sound/weapons/genhit1.ogg'
	damtype = BEAT
	combat_skill = /datum/skill/clubs

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
	force = 25
	throwforce = 30
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	attack_verb_continuous = list("attacks", "chops", "cleaves", "tears", "lacerates", "cuts")
	attack_verb_simple = list("attack", "chop", "cleave", "tear", "lacerate", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	damtype = SLASH
	resistance_flags = FIRE_PROOF
	minimum_combat_skill = 5
	wound_bonus = -15
	bare_wound_bonus = 20
	charge_time = 3 SECONDS
	charging_slowdown = 0.7
	obj_value = 400

/obj/item/melee/club/fireaxe/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 100, 80, 0 , hitsound) //axes are not known for being precision butchering tools
	AddComponent(/datum/component/two_handed, force_unwielded=25, force_wielded=40, icon_wielded="fireaxe1")

/obj/item/melee/club/baton
	name = "baton"
	desc = "All it takes to turn a law enforcement implement into a deadly weapon is to strike directly at the skull with reckless abandon."
	icon_state = "baton"
	force = 27
	wound_bonus = -10
	throwforce = 15
	attack_verb_continuous = list("beats", "smacks")
	attack_verb_simple = list("beat", "smack")
	minimum_combat_skill = 3
	obj_value = 320

/obj/item/melee/club/shovel
	name = "shovel"
	desc = "A large tool for digging and moving dirt."
	icon_state = "shovel"
	flags_1 = CONDUCT_1
	force = 21
	throwforce = 15
	tool_behaviour = TOOL_SHOVEL
	toolspeed = 1
	usesound = 'sound/effects/shovel_dig.ogg'
	attack_verb_continuous = list("bashes", "bludgeons", "thrashes", "whacks")
	attack_verb_simple = list("bash", "bludgeon", "thrash", "whack")
	sharpness = SHARP_EDGED
	obj_value = 220

/obj/item/shovel/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, 150, 40) //it's sharp, so it works, but barely.

/obj/item/melee/club/shovel/serrated
	name = "serrated bone shovel"
	desc = "A wicked tool that cleaves through dirt just as easily as it does flesh. Serves a graverobber well in taking care of nosy people who care about petty concepts like respecting the dead."
	icon_state = "shovel_serr"
	force = 30
	throwforce = 20
	damtype = SLASH
	toolspeed = 0.7
	attack_verb_continuous = list("slashes", "impales", "thrash", "lacerates")
	attack_verb_simple = list("slash", "impale", "thrash", "lacerate")
	hitsound = 'sound/weapons/bladeslice.ogg'
	minimum_combat_skill = 4
	obj_value = 350