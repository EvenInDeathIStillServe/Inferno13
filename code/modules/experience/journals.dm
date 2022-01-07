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
	if (name in M.client.prefs.journals)
		return
	to_chat(M, span_nicegreen("Journal unlocked: <b>[name]</b>. [desc]"))
	M.grant_experience(experience_value)
	M.client.prefs.journals += name
	M.save_clone_data()
	return TRUE

/datum/journal/iconeic
	name = "Iconeic"
	desc = "Came up with a memorable logo."
	experience_value = 500