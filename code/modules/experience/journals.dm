GLOBAL_LIST_INIT(journal_types, subtypesof(/datum/journal))

/datum/journal
	var/name = "Base journal"
	var/desc = "Awarded for successfully getting the base journal! You shouldn't be seeing this."
	var/experience_value

/mob/living/carbon/human/proc/award_journal(journal_type)
	var/datum/journal/journal = GetJournalRef(journal_type)
	return journal.award(src)

/datum/journal/proc/award(mob/living/carbon/human/M)
	if (!M.client)
		return
	var/saved_journals = M.client.prefs.read_preference(/datum/preference/progress/journals)
	if (name in saved_journals)
		return
	to_chat(M, span_nicegreen("Journal unlocked: <b>[name]</b>. [desc]"))
	M.grant_experience(experience_value)
	M.client.prefs.update_preference(/datum/preference/progress/journals, saved_journals + name)
	M.save_clone_data()
	return TRUE

/datum/journal/iconeic
	name = "Iconeic"
	desc = "Came up with a memorable logo."
	experience_value = 500

/datum/journal/respawn
	name = "R-r-r-respawn!"
	desc = "No need to wait for a burial."
	experience_value = 200

/datum/journal/death
	name = "Death's Warm Embrace"
	desc = "It was bound to happen, but it's not the end: Reclone!"
	experience_value = 100

/datum/journal/eyeforvalue
	name = "An Eye for Value"
	desc = "Appraised an item."
	experience_value = 50

/datum/journal/soylentred
	name = "Soylent Red"
	desc = "Found the 'secret' behind soylent red. Everyone already knows about it, come on."
	experience_value = 200

/datum/journal/visit
	name = "Visit: Base"
	desc = "This is the base visit journal. How the fuck did you get this?"
	experience_value = 100

/datum/journal/visit/sewers
	name = "Visit: Sewers"
	desc = "Take a deep breath if you dare."

/datum/journal/visit/firestation
	name = "Visit: Fire Station"
	desc = "You're pretty sure you shouldn't be smelling napalm in a fire station."