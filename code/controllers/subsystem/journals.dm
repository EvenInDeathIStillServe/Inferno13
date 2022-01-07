SUBSYSTEM_DEF(undertakings)
	name = "Undertakings"
	flags = SS_NO_FIRE
	///Dictionary of journal.type || journal ref
	var/list/all_journals = list()
	///Dictionary of duty.type || duty ref
	var/list/all_duties = list()

/datum/controller/subsystem/undertakings/Initialize(timeofday)
	InitializeJournals()
	InitializeDuties()
	return ..()

///Ran on initialize, populates the journal dictionary
/datum/controller/subsystem/undertakings/proc/InitializeJournals(timeofday)
	for(var/type in GLOB.journal_types)
		var/datum/journal/ref = new type
		all_journals[type] = ref

///Ran on initialize, populates the duty dictionary
/datum/controller/subsystem/undertakings/proc/InitializeDuties(timeofday)
	for(var/type in GLOB.duty_types)
		var/datum/duty/ref = new type
		all_duties[type] = ref