/datum/job/clone
	title = "Clone"
	faction = FACTION_STATION
	total_positions = 100
	spawn_positions = 100
	supervisors = "absolutely everyone"
	selection_color = "#bbe291"
	exp_granted_type = EXP_TYPE_CREW
	outfit = /datum/outfit/job/clone
	paycheck = 300

	paycheck_department = ACCOUNT_CIV
	display_order = JOB_DISPLAY_ORDER_CLONE

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/job/clone/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	Cinematic(CINEMATIC_CLONE_SPAWN,spawned)

/datum/outfit/job/clone
	name = "Clone"
	jobtype = /datum/job/clone

	id_trim = /datum/id_trim/job/clone
	uniform = /obj/item/clothing/under/color/grey
	backpack_contents = list()

	ears = null
	backpack = /obj/item/storage/backpack/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	duffelbag = /obj/item/storage/backpack/duffelbag/explorer

	box = null
	pda_slot = ITEM_SLOT_BELT