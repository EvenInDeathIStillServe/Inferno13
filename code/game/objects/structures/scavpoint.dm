/obj/item/storage/scavpoint
	name = "pile of garbage"
	desc = "A pile of random stuff. Might be something good in it."
	icon = 'icons/obj/crafting.dmi'
	icon_state = "trash_1"
	anchored = TRUE
	density = FALSE
	var/list/loot_players = list()
	var/list/lootable_trash = list()
	var/list/garbage_list = list()
	var/rescavenge_time = 3 MINUTES

/obj/item/storage/scavpoint/proc/initialize_lootable_trash()
	garbage_list = get_loot_list()
	lootable_trash = list() //we are setting them to an empty list so you can't double the amount of stuff
	for(var/i in garbage_list)
		for(var/ii in i)
			lootable_trash += ii
			lootable_trash[ii] = i[ii]

/obj/item/storage/scavpoint/proc/get_loot_list()
/*	return list(GLOB.trash_ammo, GLOB.trash_chem, GLOB.trash_clothing, GLOB.trash_craft,
				GLOB.trash_gun, GLOB.trash_misc, GLOB.trash_money,
				GLOB.trash_part, GLOB.trash_tool) */
	return list(GLOB.sewer_loot)

/obj/item/storage/scavpoint/Initialize()
	. = ..()
	icon_state = "trash_[rand(1,3)]"
	GLOB.trash_piles += src
	initialize_lootable_trash()

/obj/item/storage/scavpoint/Destroy()
	GLOB.trash_piles -= src
	. = ..()

/obj/item/storage/scavpoint/attack_hand(mob/user)
	var/turf/ST = get_turf(src)
	if(ishuman(user) && !user:combat_mode)
		if(user in loot_players)
			to_chat(user, span_notice("You have already gone through [src] recently."))
			return
		if(do_after(user, 20, target = src))
			to_chat(user, span_notice("You scavenge through [src]."))
			var/scavmod = user.mind.get_effective_skill(/datum/skill/scavenging) + rand(-4,4)
			for(var/i=0, i<min(round(scavmod/7),5), i++)
				var/itemtype = pick_weight(lootable_trash)
				if (itemtype)
					var/obj/item/item = new itemtype(ST)
					if(istype(item))
						item.from_trash = TRUE
			user.mind.adjust_experience(/datum/skill/scavenging, 10)
			loot_players += user
			addtimer(CALLBACK(src, .proc/rescavenge, user), rescavenge_time)
	else
		return ..()

/obj/item/storage/scavpoint/proc/rescavenge(mob/scavenger)
	if (scavenger)
		loot_players -= scavenger

GLOBAL_LIST_INIT(sewer_loot, list(
	/obj/item/reagent_containers/syringe = 5,
	/obj/item/treasure/trash/tincan = 5,
	/obj/item/treasure/trash/coffeepot = 1,
	/obj/item/geiger_counter = 1,
	/obj/item/treasure/trash/pipe = 4,
	/obj/item/toy/crayon/spraycan = 1,
	/obj/item/broken_bottle = 3,
	/obj/item/stack/crafting/metalparts = 5,
	/obj/item/stack/crafting/metalparts/three = 1
))

/obj/item/storage/scavpoint/sewer/get_loot_list()
	return list(GLOB.sewer_loot)

GLOBAL_LIST_INIT(chemplant_loot, list(
	/obj/item/reagent_containers/glass/bottle/carbon = 3,
	/obj/item/reagent_containers/glass/bottle/sodium = 3,
	/obj/item/reagent_containers/glass/bottle/phosphorus = 3,
	/obj/item/reagent_containers/glass/bottle/sulfur = 3,
	/obj/item/reagent_containers/glass/bottle/saltpetre = 3,
	/obj/item/geiger_counter = 3
))

/obj/item/storage/scavpoint/chemplant/get_loot_list()
	return list(GLOB.chemplant_loot)