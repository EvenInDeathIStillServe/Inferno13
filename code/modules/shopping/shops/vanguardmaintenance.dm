/obj/machinery/shop_counter/vanguard_maintenance
	store = "Vanguard Maintenance Division"
//	bag_icon = "vanguardmaintenance

	shopkeeper_type = /mob/living/simple_animal/snm/interactible/shopkeeper/vanguard_technician

	say_purchase = "I'm always here."
	say_cant_afford = "Seems your credchip's lacking there, bud."
	say_sell = "Seems I'm authorized to buy that, alright."

/obj/machinery/shop_rack/vanguard_maintenance
	store = "Vanguard Maintenance Division"
	icon_state = "vanguard_tools"
	goods = list(
		new /datum/data/shopping_good("Vanguard Standard Screwdriver",				/obj/item/screwdriver,		75)
		)

/mob/living/simple_animal/snm/interactible/shopkeeper/vanguard_technician
	name = "Vanguard technician"
	desc = "A technician working for Vanguard Corp. He seems pleased with being relegated to tending a desk."
	icon_state = "vanguard_technician"
	icon_living = "vanguard_technician"
	icon_dead = "vanguard_technician"
	say_greet = "Well hello there."
	say_no_money = "I can't give you lessons for free or the company'll have my ass."
	say_no_exp = "Doesn't seem like you're ready for a lesson, sport."
	say_higher_level = "Well I'll be! You should be teaching me!"
	say_teach = "So you want to learn the fine art of maintenance, eh?"
	taught_skills = list("Repair" = 5)