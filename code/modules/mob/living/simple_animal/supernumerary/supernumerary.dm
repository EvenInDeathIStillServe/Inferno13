/mob/living/simple_animal/snm
	name = "supernumerary"
	desc = "An inconsequential extra."
	icon = 'icons/mob/supernumerary.dmi'
	icon_state = "male"
	icon_living = "male"
	icon_dead = "male"
	status_flags = GODMODE
//	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/human = 2)
	stop_automated_movement = 1
	anchored = TRUE

/mob/living/simple_animal/snm/interactible
	var/interacting = FALSE
	var/list/taught_skills = list()
	var/say_greet = "Hello there."
	var/say_no_money = "You can't afford it."
	var/say_no_exp = "You don't have enough experience."
	var/say_higher_level = "You know more than I can teach you."
	var/say_teach = "Here's what I know."

/mob/living/simple_animal/snm/interactible/attack_hand(mob/living/carbon/human/M)
	if(stat != DEAD && !M.combat_mode)
		snm_interacted(M)
	else
		..()

/mob/living/simple_animal/snm/interactible/proc/check_interactable(mob/living/carbon/human/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/mob/living/simple_animal/snm/interactible/proc/snm_interacted(mob/living/carbon/human/M)
	if (!check_interactable(M))
		return
	say(say_greet)
	if (!LAZYLEN(taught_skills))
		return
	var/list/choices = list()
	for (var/skill in taught_skills)
		choices[skill] = icon('icons/hud/radial.dmi', lowertext(skill))
	var/choice = show_radial_menu(
		M,
		src,
		choices,
		custom_check = CALLBACK(src, .proc/check_interactable, M),
		require_near = FALSE,
	)

	for (var/skillpath in SSskills.all_skills)
		if (choice == SSskills.all_skills[skillpath].name)
			var/next_level = M.mind.get_skill_level(skillpath)+1
			if (next_level > taught_skills[choice])
				say(say_higher_level)
				return
			var/exp_needed = M.mind.get_exp_to_level(skillpath, next_level) - M.mind.get_skill_exp(skillpath)
			if (M.free_experience < exp_needed)
				say(say_no_exp)
				to_chat(M, span_warning("You need [exp_needed] experience."))
				return
			if (!M.canpay(exp_needed))
				say(say_no_money)
				to_chat(M, span_warning("You need $[exp_needed]."))
				return
			M.payact(-exp_needed)
			say(say_teach)
			M.mind.set_level(skillpath, next_level, FALSE)
			M.spend_experience(exp_needed)
			break
	return

/mob/living/simple_animal/snm/interactible/Hear(message, atom/movable/speaker, message_langs, raw_message, radio_freq, spans, list/message_mods = list())
	. = ..()
	if (!ishuman(speaker) || radio_freq || stat || get_dist(src, speaker) > 4)
		return
	if (findtext(raw_message, "hi") || findtext(raw_message, "hello"))
		snm_interacted(speaker)

/mob/living/simple_animal/snm/interactible/lance
	name = "Lance"
	desc = "The man in charge of the meat factory. Seems to just be lazing about."
	icon_state = "lance"
	icon_living = "lance"
	icon_dead = "lance"
	anchored = TRUE
	var/list/beggars = list()

/mob/living/simple_animal/snm/interactible/lance/snm_interacted(mob/living/carbon/human/M)
	if (M in beggars)
		say("Hey! I'm not running a charity here. You're not getting anymore handouts from me.")
		return
	if (interacting)
		return
	interacting = TRUE
	say("You must be a new clone. Welcome to the meat factory. Hey, how about a job? There's plenty of defective clones that need...  processing.")
	spawn (50)
		if (!M.canUseTopic(src, BE_CLOSE))
			say("Guess you're too good for it, huh? Fine, suit yourself.")
			interacting = FALSE
			return
		var/obj/item/gun/ballistic/revolver/rusty/garbage = new /obj/item/gun/ballistic/revolver/rusty(src)
		M.put_in_hands(garbage)
		M.payact(100)
		M.visible_message("<span class='notice'>[src] rummages around his pockets, producing a rusty revolver that he hands to [M], then waves his credchip over the latter's.</span>", \
			"<span class='notice'>[src] rummages around in his pockets, producing a rusty revolver that he hands to you, then waves his credchip over yours.</span>")
		say("Here, you'll need this. It's not much, but hey, it's free. Here's some scratch for more ammo, too. Every defective you knock off is a load off my back, and pay for you.")
		beggars += M
		interacting = FALSE

/mob/living/simple_animal/snm/interactible/vanguard_graphic
	name = "\improper VanGuard graphic designer"
	desc = "A graphic designer working for the VanGuard corporation. He looks stuck."
	icon_state = "vanguard_graphic"
	icon_living = "vanguard_graphic"
	icon_dead = "vanguard_graphic"

/mob/living/simple_animal/snm/interactible/vanguard_graphic/snm_interacted(mob/living/carbon/human/M)
	if (interacting)
		return
	interacting = TRUE
	say("Oh, hello. I'm kind of in the middle of designing a logo for VanGuard's new video player software.")
	spawn (50)
		say("Argh, who am I kidding. This isn't going anywhere. Hey, if you get me some kind of inspiration, I'd be real grateful.")
		interacting = FALSE

/mob/living/simple_animal/snm/interactible/vanguard_graphic/attackby(obj/item/I, mob/living/carbon/human/M)
	if (istype(I, /obj/item/clothing/head/cone))
		if (M.award_journal(/datum/journal/iconeic))
			say("Yes, that's exactly it! Thank you so much! Here, some compensation for your trouble.")
			M.payact(1000)
			qdel(I)
		else
			say("Oh, you helped me out already. I'll finish this up eventually, no worries.")
	else
		say("No, no, that won't do. I need something that stands out, something... iconic.")


/mob/living/simple_animal/snm/interactible/shopkeeper
	anchored = TRUE

/mob/living/simple_animal/snm/interactible/bartender
	anchored = TRUE