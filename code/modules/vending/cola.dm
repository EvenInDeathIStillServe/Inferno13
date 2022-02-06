
/obj/machinery/vending/cola
	name = "\improper VanGuard Refreshments"
	desc = "A softdrink vendor provided by VanGuard Corporation."
	icon_state = "Cola_Machine"
	panel_type = "panel2"
	product_slogans = "VanGuard Refreshments: You want it!"
	product_ads = "Refreshing!;Hope you're thirsty!;Thirsty? Why not cola?;Please, have a drink!;Drink up!;For Catharsis' finest!"
	products = list(
		/obj/item/reagent_containers/food/drinks/soda_cans/vanguard_cola = 10,
		/obj/item/reagent_containers/food/drinks/soda_cans/crater_gust = 10,
		/obj/item/reagent_containers/food/drinks/soda_cans/delta_delight = 10,
		/obj/item/reagent_containers/food/drinks/waterbottle = 10
	)
	refill_canister = /obj/item/vending_refill/cola
	default_price = PAYCHECK_ASSISTANT * 0.7
	extra_price = PAYCHECK_MEDIUM
	payment_department = ACCOUNT_SRV


/obj/item/vending_refill/cola
	machine_name = "Vanguard Refreshments"
	icon_state = "refill_cola"

/obj/machinery/vending/cola/blue
	icon_state = "Cola_Machine"
	light_mask = "cola-light-mask"
	light_color = COLOR_MODERATE_BLUE

/obj/machinery/vending/cola/black
	icon_state = "cola_black"
	light_mask = "cola-light-mask"

/obj/machinery/vending/cola/red
	icon_state = "red_cola"
	light_mask = "red_cola-light-mask"
	light_color = COLOR_DARK_RED

/obj/machinery/vending/cola/space_up
	icon_state = "space_up"
	light_mask = "space_up-light-mask"
	light_color = COLOR_DARK_MODERATE_LIME_GREEN

/obj/machinery/vending/cola/starkist
	icon_state = "starkist"
	panel_type = "panel7"
	light_mask = "starkist-light-mask"
	light_color = COLOR_LIGHT_ORANGE

/obj/machinery/vending/cola/sodie
	icon_state = "soda"
	panel_type = "panel7"
	light_mask = "soda-light-mask"
	light_color = COLOR_WHITE

/obj/machinery/vending/cola/pwr_game
	icon_state = "pwr_game"
	light_mask = "pwr_game-light-mask"
	light_color = COLOR_STRONG_VIOLET

/obj/machinery/vending/cola/delta_delight
	icon_state = "delta_delight"
	light_mask = "delta_delight-light-mask"
	light_color = COLOR_MOSTLY_PURE_PINK
