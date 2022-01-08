GLOBAL_LIST_INIT(duty_types, subtypesof(/datum/duty))

/datum/duty
	var/name = "Base duty"
	var/desc = "Awarded for successfully accomplishing a duty! You shouldn't be seeing this."
	var/tasks = 0 //How many times you need to do the required task to get rewarded. 0 means one task. Only use 2 and above.
	var/experience_value
	var/money_value

/mob/living/carbon/human/proc/award_duty(duty_type)
	var/datum/duty/duty = GetDutyRef(duty_type)
	return duty.award(src)

/datum/duty/proc/award(mob/living/carbon/human/M)
	if (!M.client)
		return
	var/tasks_completed
	if (!(name in M.client.prefs.duties))
		M.client.prefs.duties[name] = 0
	tasks_completed = M.client.prefs.duties[name]

	if (tasks && (tasks_completed < tasks))
		tasks_completed++
		if (tasks_completed < tasks)
			to_chat(M, span_nicegreen("Task completed: [name]. [tasks - tasks_completed] left."))
			M.client.prefs.duties[name] = tasks_completed
			return TRUE

	to_chat(M, span_nicegreen("Duty completed: <b>[name]</b>. [desc]"))
	M.grant_experience(experience_value)
	M.payact(money_value)
	M.client.prefs.duties[name] = 0
	M.save_clone_data()
	return TRUE

/datum/duty/repairman
	name = "Repairman"
	desc = "Get down and dirty in the name of the municipality."
	tasks = 5
	experience_value = 300
	money_value = 300

/datum/duty/chudhunter
	name = "Chud Hunter"
	desc = "Supply a fast-food place with delectable 'meat'."
	tasks = 5
	experience_value = 300
	money_value = 200