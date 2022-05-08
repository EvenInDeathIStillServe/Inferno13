/datum/contract
	var/name
	var/desc

/datum/contract/proc/get_contract_info()
	return "Eh? Someone messed up this contract."

/datum/contract/extermination
	var/list/targets = list()

/datum/contract/extermination/get_contract_info()
	var/target_data
	for(var/valid_type in targets)
		var/mob/valid_target = valid_type
		target_data += "[initial(valid_target.name)] ($[targets[valid_type]])"
		if (valid_type == targets[targets.len])
			target_data += "."
		else
			target_data += ", "
	return target_data

/datum/contract/extermination/catharsis_city
	name = "Catharsis City Cleansing"
	desc = "Catharsis City is plagued by fiends, ruffians, scoundrels, and all manner of pests. Get rid of them."
	targets = list(
	/mob/living/simple_animal/hostile/humanoid/clone = 15,
	/mob/living/simple_animal/hostile/humanoid/crackhead = 40,
	/mob/living/simple_animal/hostile/humanoid/chud = 50,
	/mob/living/simple_animal/hostile/humanoid/firefighter = 70,
	/mob/living/simple_animal/hostile/humanoid/graverobber = 90)

/datum/contract/extermination/acf_elimination
	name = "ACF elimination"
	desc = "The ACF must not be allowed to gain a foothold in Catharsis. Take out some froggies for a nice reward."
	targets = list(
	/mob/living/simple_animal/hostile/humanoid/acf_trooper = 250)

/obj/item/contract
	name = "contract"
	desc = "A corporate contract of some kind. Seems... Blank."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "contract"
	var/datum/contract/contract_datum

/obj/item/contract/attack_self(mob/living/carbon/human/user)
	if (!istype(user))
		return
	if (!user.mind.corp)
		to_chat(user, span_warning("This contract is limited to corporations only! Consider joining one."))
		return
	if (locate(contract_datum) in user.mind.corp.contracts)
		to_chat(user, span_warning("Your corporation already has a contract of this type active."))
		return
	var/datum/contract/new_contract = new contract_datum
	user.mind.corp.contracts += new_contract
	playsound(src, 'sound/effects/license.ogg', 50, TRUE)
	to_chat(user, span_notice("<b>[new_contract.name]<b/>: [new_contract.desc]"))
	to_chat(user, span_nicegreen("[new_contract.get_contract_info()]"))
	qdel(src)

/obj/item/contract/extermination
	name = "extermination contract"
	desc = "A limited-time contract offering compensation for extermination of certain undesirable entities."

/obj/item/contract/extermination/catharsis_city
	name = "\improper Catharsis City cleansing contract"
	contract_datum = /datum/contract/extermination/catharsis_city

/obj/item/contract/extermination/acf_elimination
	name = "\improper ACF elimination contract"
	contract_datum = /datum/contract/extermination/acf_elimination