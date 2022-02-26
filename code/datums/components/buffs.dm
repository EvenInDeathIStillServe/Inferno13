/datum/component/buffs
	var/list/datum/buff_event/buff_events = list()

/datum/component/buffs/Initialize()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE

	START_PROCESSING(SSbuffs, src)

	RegisterSignal(parent, COMSIG_ADD_BUFF, .proc/add_buff)
	RegisterSignal(parent, COMSIG_CLEAR_BUFF, .proc/clear_buff)

/datum/component/buffs/Destroy()
	STOP_PROCESSING(SSbuffs, src)
	return ..()

/datum/component/buffs/proc/add_buff(datum/source, category, type, ...) //Category will override any events in the same category, should be unique unless the event is based on the same thing like hunger.
	SIGNAL_HANDLER

	var/datum/buff_event/the_event
	if(!ispath(type, /datum/buff_event))
		return
	if(!istext(category))
		category = REF(category)
	if(buff_events[category])
		the_event = buff_events[category]
		if(the_event.type != type)
			clear_buff(null, category)
		else
			if(the_event.timeout)
				addtimer(CALLBACK(src, .proc/clear_buff, null, category), the_event.timeout, TIMER_UNIQUE|TIMER_OVERRIDE)
			return //Don't have to update the event.
	var/list/params = args.Copy(4)
	params.Insert(1, parent)
	the_event = new type(arglist(params))

	buff_events[category] = the_event
	the_event.category = category
	update_buffs()

	if(the_event.timeout)
		addtimer(CALLBACK(src, .proc/clear_buff, null, category), the_event.timeout, TIMER_UNIQUE|TIMER_OVERRIDE)

/datum/component/buffs/proc/clear_buff(datum/source, category)
	SIGNAL_HANDLER

	if(!istext(category))
		category = REF(category)
	var/datum/buff_event/event = buff_events[category]
	if(!event)
		return

	buff_events -= category
	qdel(event)
	update_buffs()

///Called after buffevent/s have been added/removed.
/datum/component/buffs/proc/update_buffs()
