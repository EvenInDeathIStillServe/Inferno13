/datum/corporation
	var/name = "Generic Inc."
	var/stock_symbol = "GNRC"
	var/list/members_by_code = list() //Associative list of codes to minds
	var/owner
	var/funds = 0
	var/list/contracts

/obj/item/business_license
	name = "business license"
	desc = "A business permit with the seal of the Catharsis City Council. Allows one to establish their own corporation: using it will allow your wristpad to interface with and process it."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "business_license"

/obj/item/business_license/attack_self(mob/living/carbon/human/user)
	if (!istype(user))
		return
	if (user.mind.corp)
		to_chat(user, span_warning("You're already in a corporation! What are you trying to pull?"))
		return
	var/corp_name = stripped_input(user, "What are you going to call your corporation?", "Corporation Naming", null , 30)
	if (corp_name && user.canUseTopic(src, BE_CLOSE))
		var/stock_name = stripped_input(user, "What is your stock symbol going to be? Five characters maximum.", "Stock Symbol", null , 5)
		if (stock_name && user.canUseTopic(src, BE_CLOSE))
			var/datum/corporation/new_corp = new
			new_corp.name = corp_name
			new_corp.stock_symbol = stock_name
			new_corp.owner = user.clone_tag
			new_corp.members_by_code["[user.clone_tag]"] = user.mind
			user.mind.corp = new_corp
			SScorporation.corporations += new_corp
			to_chat(user, span_notice("Congratulations! Your corporation has been successfully registered. Check your wristpad for your corporation menu."))
			playsound(src, 'sound/effects/license.ogg', 50, TRUE)
			qdel(src)