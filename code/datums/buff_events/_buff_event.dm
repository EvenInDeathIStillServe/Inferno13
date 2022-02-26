/datum/buff_event
	var/description ///For descriptions, use the span classes bold nicegreen, nicegreen, none, warning and boldwarning in order from great to horrible.
	var/timeout = 0
	var/hidden = FALSE//Not shown on examine
	var/category //string of what category this mood was added in as
	var/mob/owner

/datum/buff_event/New(mob/M, ...)
	owner = M
	var/list/params = args.Copy(2)
	add_effects(arglist(params))

/datum/buff_event/Destroy()
	remove_effects()
	owner = null
	return ..()

/datum/buff_event/proc/add_effects(param)
	return

/datum/buff_event/proc/remove_effects()
	return
