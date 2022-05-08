/datum/preference/numeric/stat
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE
	player_modifiable = FALSE
	minimum = 0
	maximum = 30

	abstract_type = /datum/preference/numeric/stat

/datum/preference/numeric/stat/create_default_value()
	return 8

/datum/preference/numeric/stat/apply_to_human(mob/living/carbon/human/target, value)
	target.vars[savefile_key] = value

/datum/preference/numeric/stat/muscles
	savefile_key = "muscles"

/datum/preference/numeric/stat/neurons
	savefile_key = "neurons"

/datum/preference/numeric/stat/heart
	savefile_key = "heart"

/datum/preference/numeric/stat/nerves
	savefile_key = "nerves"

/datum/preference/numeric/stat/senses
	savefile_key = "senses"

/datum/preference/numeric/stat/ego
	savefile_key = "ego"

/datum/preference/numeric/stat/experience_level
	savefile_key = "experience_level"
	minimum = 1
	maximum = 100

/datum/preference/numeric/stat/total_experience
	savefile_key = "total_experience"
	minimum = 0
	maximum = 1000000

/datum/preference/numeric/stat/free_experience
	savefile_key = "free_experience"
	minimum = 0
	maximum = 1000000

/datum/preference/numeric/stat/free_points
	savefile_key = "free_points"
	minimum = 0
	maximum = 1000000

/datum/preference/numeric/stat/free_points/create_default_value()
	return 6

/datum/preference/progress
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE
	player_modifiable = FALSE

	abstract_type = /datum/preference/progress

/datum/preference/progress/is_valid()
	return TRUE

/datum/preference/progress/create_default_value()
	return list()

/datum/preference/progress/deserialize(input, datum/preferences/preferences)
	return input

/datum/preference/progress/apply_to_human(mob/living/carbon/human/target, value)
	return

/datum/preference/progress/journals
	savefile_key = "journals"

/datum/preference/progress/duties
	savefile_key = "duties"

/datum/preference/progress/skills
	savefile_key = "skills"

/datum/preference/progress/skills/apply_to_human(mob/living/carbon/human/target, value)
	return