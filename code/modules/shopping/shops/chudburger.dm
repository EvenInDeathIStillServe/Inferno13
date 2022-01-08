/obj/machinery/shop_counter/chudburger
	store = "Chud Burger"
	bag_icon = "chudburger"
	bought_objects = list(
		/obj/item/food/meat/slab/human/mutant/chud
		)

	shopkeeper_type = /mob/living/simple_animal/snm/interactible/shopkeeper/chudburger_guy

	say_purchase = "Uh, enjoy that, I guess."
	say_cant_afford = "Must be real tough if you can't even afford to eat here."
	say_sell = "Why do I have to handle meat deliveries? Ugh."

/obj/machinery/shop_rack/chudburger
	store = "Chud Burger"

/obj/machinery/shop_rack/chudburger/menu
	icon = 'icons/obj/economy.dmi'
	icon_state = "menu"
	goods = list(
		new /datum/data/shopping_good("Chudburger",			/obj/item/food/burger/chud,			50)
		)

/obj/machinery/shop_counter/chudburger/special_sell(obj/item/W, mob/living/carbon/human/user)
	if (istype(W, /obj/item/food/meat/slab/human/mutant/chud))
		user.award_duty(/datum/duty/chudhunter)

/mob/living/simple_animal/snm/interactible/shopkeeper/chudburger_guy
	name = "Chudburger guy"
	desc = "A scrawny-looking fellow with terrible makeup and an even more terrible wig. His employee tag identifies him as 'Bob'."
	icon_state = "chudburger_guy"
	icon_living = "chudburger_guy"
	icon_dead = "chudburger_guy"
	say_greet = "Yeah, hey. Welcome to Chudburger and all that."