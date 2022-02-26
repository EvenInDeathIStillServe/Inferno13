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
		preferences.experience_level = experience_level
		preferences.total_experience = total_experience
		preferences.free_experience = free_experience
		preferences.free_points = free_points
		preferences.muscles = muscles
		preferences.neurons = neurons
		preferences.heart = heart
		preferences.sinews = sinews
		preferences.senses = senses
		preferences.ego = ego
		preferences.save_character()
		to_chat(src, span_notice("Clone data saved."))