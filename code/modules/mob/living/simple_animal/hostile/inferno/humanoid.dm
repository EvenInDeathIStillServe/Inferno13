/mob/living/simple_animal/hostile/humanoid
	gender = MALE
	icon = 'icons/mob/infernomobs.dmi'
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	speak_chance = 0
	turns_per_move = 5
	speed = 1
	attack_verb_continuous = "hits"
	attack_verb_simple = "hit"
	attack_sound = 'sound/weapons/punch1.ogg'
	combat_mode = TRUE
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	faction = list("nefarious")
	status_flags = CANPUSH
	butcher_results = list(/obj/item/food/meat/slab/human = 2, /obj/item/stack/sheet/leather = 2)
	deathmessage = "keels over and falls limp."
	ranged = TRUE
	ranged_message = "swings"
	projectiletype = /obj/projectile/melee
	projectile_name = "punch"
	projectilesound = 'sound/weapons/punchmiss.ogg'
	footstep_type = FOOTSTEP_MOB_SHOE
	flip_on_death = TRUE
	blood_volume = BLOOD_VOLUME_NORMAL

/mob/living/simple_animal/hostile/humanoid/clone
	name = "defective clone"
	desc = "Another reject churned out by the clone tubes."
	icon_state = "clone_1"
	icon_living = "clone_1"
	icon_dead = "clone_1"
	maxHealth = 60
	health = 60
	harm_intent_damage = 8
	melee_damage_lower = 8
	melee_damage_upper = 12
	attack_skill = 8
	experience_on_kill = 10
	aggro_chance = 20
	random_prefix = list("mutated", "defective", "deformed", "unwanted", "sick")
	random_suffix = list("clone", "failure", "meatsack", "humanoid", "tubeborn")

/mob/living/simple_animal/hostile/humanoid/clone/female
	gender = FEMALE

/mob/living/simple_animal/hostile/humanoid/clone/Initialize()
	..()
	var/random = rand(1,6)
	if(gender == FEMALE)
		icon_living = "femclone_[random]"
	else
		icon_living = "clone_[random]"
	icon_dead = icon_living
	icon_state = icon_living

/mob/living/simple_animal/hostile/humanoid/crackhead
	name = "crackhead"
	desc = "Rotten yellow teeth accompanied by a crazed glazed gaze. Accompanied is too friendly of a word... Let's go with emboldened."
	icon_state = "crackhead_1"
	icon_living = "crackhead_1"
	icon_dead = "crackhead_1"
	maxHealth = 100
	health = 100
	harm_intent_damage = 20
	melee_damage_lower = 18
	melee_damage_upper = 22
	attack_skill = 10
	cash_loot_min = 0
	cash_loot_max = 50
	experience_on_kill = 20

	random_prefix = list("crazy", "mad", "barmy", "nutty", "agitated")
	random_suffix = list("junkie", "crackhead", "squatter", "druggie", "addict")

/mob/living/simple_animal/hostile/humanoid/crackhead/Initialize()
	..()
	icon_living = "crackhead_[rand(1,3)]"
	icon_dead = icon_living
	icon_state = icon_living

/mob/living/simple_animal/hostile/humanoid/crackhead/baseball
	ranged_message = "swings a bat"
	projectile_name = "baseball bat"
	weapon_overlay = "baseball"
	attack_sound = 'sound/weapons/genhit1.ogg'
	loot = list(/obj/item/melee/club/baseball_bat)
	parry_class = 2

/mob/living/simple_animal/hostile/humanoid/crackhead/crowbar
	ranged_message = "swings a crowbar"
	projectile_name = "crowbar"
	weapon_overlay = "crowbar"
	attack_sound = 'sound/weapons/genhit1.ogg'
	loot = list(/obj/item/melee/club/crowbar)
	parry_class = 2

/mob/living/simple_animal/hostile/humanoid/crackhead/knife
	ranged_message = "thrusts a knife"
	projectile_name = "kitchen knife"
	weapon_overlay = "knife"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	loot = list(/obj/item/melee/blade/kitchen_knife)
	melee_damage_type = STAB

/mob/living/simple_animal/hostile/humanoid/chud
	name = "chud"
	desc = "A lurching figure with greyish leathery skin. It seems to have been human once, surely it can be dispatched as easily as one."
	icon_state = "chud_1"
	icon_living = "chud_1"
	icon_dead = "chud_1"
	maxHealth = 120
	health = 120
	harm_intent_damage = 22
	melee_damage_lower = 18
	melee_damage_upper = 24
	melee_damage_type = SLASH
	attack_skill = 14
	ranged_message = "claws"
	projectile_name = "claws"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	emote_taunt = list("gnashes its teeth")
	butcher_results = list(/obj/item/food/meat/slab/human/mutant/chud = 2, /obj/item/stack/sheet/animalhide/chud = 2)
	experience_on_kill = 30

	random_prefix = list("hungry", "ravenous", "creeping", "murderous", "monstrous", "blood-splattered")
	random_suffix = list("chud", "C.H.U.D", "sewerman", "undergrounder", "humanoid")

/mob/living/simple_animal/hostile/humanoid/chud/Initialize()
	..()
	icon_living = "chud_[rand(1,4)]"
	icon_dead = icon_living
	icon_state = icon_living

/mob/living/simple_animal/hostile/humanoid/firefighter
	name = "firefighter"
	desc = "A stalwart member of the Catharsis City Fire Brigade. The Brigade is independent from the city itself and take no monetary compensation: they take care of fires in exchange for taking care of whoever is responsible."
	icon_state = "firefighter_1"
	icon_living = "firefighter_1"
	icon_dead = "firefighter_1"
	maxHealth = 130
	health = 130
	taunt_chance = 70
	say_taunt = list("Who the fuck are you?!", "Arsonist!", "Get some!", "GAAAAAAAAH!!!", "Get 'em!")
	armor = list("beat" = 8, "slash" = 8, "stab" = 8, "shot" = 4, "enflame" = 20, "electric" = 12, "acid" = 12, "irradiation" = 5, "cold" = 14)
	harm_intent_damage = 35
	melee_damage_lower = 30
	melee_damage_upper = 40
	attack_skill = 16
	parry_class = 3
	melee_damage_type = SLASH
	ranged_message = "swings an axe"
	projectile_name = "fire axe"
	weapon_overlay = "fireaxe"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	cash_loot_min = 50
	cash_loot_max = 100
	loot = list(/obj/item/melee/club/fireaxe)
	deep_loot = list(
				/obj/item/clothing/head/helmet/if13/turnout = 10,
				/obj/item/clothing/suit/armor/if13/turnout = 10,
				/obj/item/clothing/gloves/if13/turnout = 10,
				/obj/item/clothing/shoes/if13/turnout = 10)
	experience_on_kill = 75
	random_prefix = list("fiery", "raging", "heated", "hot-headed", "blazing", "charred")
	random_suffix = list("firefighter")

/mob/living/simple_animal/hostile/humanoid/firefighter/Initialize()
	..()
	icon_living = "firefighter_[rand(1,4)]"
	icon_dead = icon_living
	icon_state = icon_living

/mob/living/simple_animal/hostile/humanoid/hardplace
	name = "Rock Hardplace"
	desc = "Chief Hardplace is feared among arsonists all over Catharsis. Hulking, unyielding, and absolutely merciless."
	icon_state = "rockhardplace"
	icon_living = "rockhardplace"
	icon_dead = "rockhardplace"
	maxHealth = 250
	health = 250
	taunt_chance = 100
	say_taunt = list("The fuck are you doing down here?!", "You're getting cooked!", "Burn!", "Nice roast coming up!", "You're FIRED!")
	armor = list("beat" = 8, "slash" = 8, "stab" = 8, "shot" = 4, "enflame" = 20, "electric" = 12, "acid" = 12, "irradiation" = 5, "cold" = 14)
	retreat_distance = 2
	minimum_distance = 2
	harm_intent_damage = 35
	melee_damage_lower = 30
	melee_damage_upper = 38
	attack_skill = 20
	parry_class = 0
	projectiletype = /obj/projectile/energy/flame
	ranged_message = "flames away"
	projectile_name = "flame blast"
	projectilesound = 'sound/weapons/flamethrower.ogg'
	weapon_overlay = "flamethrower"
	cash_loot_min = 500
	cash_loot_max = 1000
	deep_loot = list(
				/obj/item/clothing/head/helmet/if13/turnout = 100,
				/obj/item/clothing/suit/armor/if13/turnout = 100,
				/obj/item/clothing/gloves/if13/turnout = 100,
				/obj/item/clothing/shoes/if13/turnout = 100)
	experience_on_kill = 300

/mob/living/simple_animal/hostile/humanoid/hardplace/death(gibbed)
	..()
	for (var/mob/living/carbon/human/attacker in player_attackers)
		attacker.award_journal(/datum/journal/extinguished)

/mob/living/simple_animal/hostile/humanoid/graverobber
	name = "graverobber"
	desc = "An economically-minded individual, taking part in a radical recycling initiative."
	icon_state = "graverobber_1"
	icon_living = "graverobber_1"
	icon_dead = "graverobber_1"
	maxHealth = 120
	health = 120
	taunt_chance = 70
	say_taunt = list("You're digging your own grave!", "Got a death wish?!", "Plenty of graves to choose from!", "Wanna die?!", "Bury you six feet under!")
	armor = list("beat" = 10, "slash" = 10, "stab" = 10, "shot" = 6, "enflame" = 4, "electric" = 4, "acid" = 4, "irradiation" = 5, "cold" = 5)
	harm_intent_damage = 30
	melee_damage_lower = 25
	melee_damage_upper = 35
	attack_skill = 18
	parry_class = 2
	cash_loot_min = 100
	cash_loot_max = 200
	experience_on_kill = 100
	aggro_chance = 5
	deep_loot = list(
				/obj/item/flashlight/seclite = 15,
				/obj/item/flashlight/lantern = 10,
				/obj/item/dice/d6 = 10,
				/obj/item/razor = 7)
	random_prefix = list("sly", "opportunistic", "wily", "dirt-covered", "grubby")
	random_suffix = list("looter", "graverobber", "archeologist", "pilferer")

/mob/living/simple_animal/hostile/humanoid/graverobber/Initialize()
	..()
	icon_living = "graverobber_[rand(1,3)]"
	icon_dead = icon_living
	icon_state = icon_living

/mob/living/simple_animal/hostile/humanoid/graverobber/shovel
	ranged_message = "swings a shovel"
	projectile_name = "serrated shovel"
	weapon_overlay = "shovel_serr"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	loot = list(/obj/item/melee/club/shovel/serrated)
	melee_damage_type = SLASH

/mob/living/simple_animal/hostile/humanoid/graverobber/baton
	ranged_message = "swings a baton"
	projectile_name = "baton"
	weapon_overlay = "baton"
	attack_sound = 'sound/weapons/genhit1.ogg'
	loot = list(/obj/item/melee/club/baton)

/mob/living/simple_animal/hostile/humanoid/graverobber/machete
	ranged_message = "swings a machete"
	projectile_name = "scrap machete"
	weapon_overlay = "scrap_machete"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	loot = list(/obj/item/melee/blade/scrap_machete)
	melee_damage_type = SLASH

/mob/living/simple_animal/hostile/humanoid/acf_trooper
	name = "\improper ACF trooper"
	desc = "A soldier of the Armée Coloniale Française, clad in composite plastic armor and armed with a submachine gun."
	icon_state = "acf_trooper"
	icon_living = "acf_trooper"
	icon_dead = "acf_trooper"
	maxHealth = 150
	health = 150
	taunt_chance = 70
	say_taunt = list("Putain!", "Espèce de chien!", "Hé, un pékin? Tu veux mourir?!", "Pas de capitulation!", "C'est le jour de l'abat!")
	armor = list("beat" = 10, "slash" = 14, "stab" = 14, "shot" = 20, "enflame" = 8, "electric" = 8, "acid" = 8, "irradiation" = 8, "cold" = 10)
	harm_intent_damage = 30
	melee_damage_lower = 25
	melee_damage_upper = 35
	attack_skill = 18
	retreat_distance = 5
	minimum_distance = 5
	rapid = 2
	projectiletype = /obj/projectile/bullet/c45
	ranged_message = "fires an SMG"
	projectile_name = "bullet"
	projectilesound = 'sound/weapons/gun/smg/shot.ogg'
	weapon_overlay = "smg"
	parry_class = 0
	cash_loot_min = 200
	cash_loot_max = 300
	experience_on_kill = 200
	deep_loot = list(
				/obj/item/clothing/head/helmet/if13/acf = 10,
				/obj/item/clothing/suit/armor/if13/acf = 10,
				/obj/item/clothing/gloves/if13/acf = 10,
				/obj/item/clothing/shoes/if13/acf = 10)

/mob/living/simple_animal/hostile/humanoid/chemplant_mutant
	name = "chemplant mutant"
	desc = "A former employee at the MERCURE CHIM chemical plant, now severely mutated and with a crazed look in his eyes. Looks like someone didn't use proper PPE."
	icon_state = "mutant_1"
	icon_living = "mutant_1"
	icon_dead = "mutant_1"
	maxHealth = 150
	health = 150
	armor = list("beat" = 6, "slash" = 6, "stab" = 6, "shot" = 6, "enflame" = 12, "electric" = 15, "acid" = 12, "irradiation" = 20, "cold" = 8)
	harm_intent_damage = 35
	melee_damage_lower = 30
	melee_damage_upper = 38
	attack_skill = 16
	parry_class = 1
	cash_loot_min = 50
	cash_loot_max = 100
	experience_on_kill = 100
	random_prefix = list("mutated", "freak", "deformed", "monstrous", "irradiated", "acidified")
	random_suffix = list("chemical operator", "chemical engineer", "chemical inspector", "waste handler", "chemist", "chemical specialist")

/mob/living/simple_animal/hostile/humanoid/chemplant_mutant/Initialize()
	..()
	icon_living = "chemplantmutant_[rand(1,4)]"
	icon_dead = icon_living
	icon_state = icon_living