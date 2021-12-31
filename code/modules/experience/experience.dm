#define EXPERIENCE_LEVELS list(0, 1000, 2500, 7500, 15000)

/mob/living/carbon/human/proc/grant_experience(experience_gained)
	total_experience += experience_gained
	free_experience += experience_gained
	to_chat(src, span_nicegreen("You gain [experience_gained] XP."))
	check_levelup()

/mob/living/carbon/human/proc/spend_experience(experience_spent)
	free_experience -= experience_spent
	to_chat(src, span_nicegreen("You spend [experience_spent] XP."))
	save_clone_data()

/mob/living/carbon/human/proc/check_levelup()
	if (total_experience >= EXPERIENCE_LEVELS[experience_level+1])
		experience_level++
		playsound_local(src, 'sound/effects/drums.ogg', 50, TRUE)
		to_chat(src, span_nicegreen("<b>Level Up!</b>. You are now level [experience_level]."))
		save_clone_data()