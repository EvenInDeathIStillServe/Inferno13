/obj/machinery/lamarck_terminal
	name = "\improper Lamarck terminal"
	desc = "This terminal stores a clone's DNA along with developmental progress thanks to epigenetic memory."
	icon = 'icons/obj/machines/cloning.dmi'
	icon_state = "lamarck_terminal"
	base_icon_state = "lamarck_terminal"
	density = FALSE
	use_power = NO_POWER_USE
	var/cooldown_time

/obj/machinery/lamarck_terminal/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if (user && (cooldown_time <= world.time))
		cooldown_time = world.time + 2 SECONDS
		user.save_clone_data()
		playsound(src, 'sound/machines/high_tech_confirm.ogg', 50)
		balloon_alert(user, "Clone data saved!", COLOR_DARK_CYAN)

/mob/living/carbon/human/proc/save_clone_data()
		var/datum/preferences/preferences = client.prefs
		preferences.update_preference(/datum/preference/numeric/stat/experience_level, experience_level)
		preferences.update_preference(/datum/preference/numeric/stat/total_experience, total_experience)
		preferences.update_preference(/datum/preference/numeric/stat/free_experience, free_experience)
		preferences.update_preference(/datum/preference/numeric/stat/free_points, free_points)
		preferences.update_preference(/datum/preference/numeric/stat/muscles, muscles)
		preferences.update_preference(/datum/preference/numeric/stat/neurons, neurons)
		preferences.update_preference(/datum/preference/numeric/stat/heart, heart)
		preferences.update_preference(/datum/preference/numeric/stat/nerves, nerves)
		preferences.update_preference(/datum/preference/numeric/stat/senses, senses)
		preferences.update_preference(/datum/preference/numeric/stat/ego, ego)
		preferences.save_character()
		to_chat(src, span_notice("Clone data saved."))