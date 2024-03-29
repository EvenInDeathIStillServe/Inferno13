/obj/item/proc/get_item_credit_value()
	return

/mob/living/carbon/human/proc/payact(value, target)
	var/datum/bank_account/account = get_bank_account()
	if(account && account.adjust_money(value))
		if(value < 0)
			account.bank_card_talk("<b>$[-value]</b> has been deducted from your credit chip[target ? " to <b>[target]</b>" : ""].")
		else
			account.bank_card_talk("Your credit implant beeps for a deposit of <b>$[value]</b>[target ? " from <b>[target]</b>" : ""].")
		return TRUE

/mob/living/carbon/human/proc/canpay(var/value)
	var/datum/bank_account/account = get_bank_account()
	return account.has_money(value)