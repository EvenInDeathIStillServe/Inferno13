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

/datum/journal/capitalismho
	name = "Capitalism, Ho!"
	desc = "Spent your hard-earned credits at a store."
	experience_value = 50

/datum/journal/basicsocialskill
	name = "Basic Social Skill"
	desc = "Interacted with a supernumerary in a way that did not result in the gruesome death of an interlocutor. It didn't, right?"
	experience_value = 50

/datum/journal/murderer
	name = "Murderer"
	desc = "Let this be the first of many."
	experience_value = 100

/datum/journal/tenant
	name = "Tenant"
	desc = "Finally get a place of your own. Well, not really your own: you're just renting it."
	experience_value = 100

/datum/journal/packitcarttheory
	name = "PackIt Cart Theory"
	desc = "The PackIt Cart is what determines whether a person is a good or bad member of society. You would have made the same decision even without the deposit thing, right?"
	experience_value = 100

/datum/journal/extinguished
	name = "Extinguished"
	desc = "Put out the flame in Rock Hardplace's heart. And his flamethrower too, I suppose."
	experience_value = 500

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

/datum/journal/visit/chemplant
	name = "Visit: Chemical Plant"
	desc = "All your senses are overloaded with an acidic tinge."