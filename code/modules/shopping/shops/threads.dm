/obj/machinery/shop_counter/threads
	store = "Threads"
	bag_icon = "threads"
	bought_objects = list(
		/obj/item/clothing/suit,
		/obj/item/clothing/head,
		/obj/item/clothing/gloves,
		/obj/item/clothing/shoes)
	unwanted_objects = list(
		/obj/item/clothing/suit/armor/if13,
		/obj/item/clothing/head/helmet/if13,
		/obj/item/clothing/gloves/if13,
		/obj/item/clothing/shoes/if13,
		)
	sell_modifier = 0.8

/obj/machinery/shop_rack/threads
	store = "Threads"

/obj/machinery/shop_rack/threads/shoes
	icon_state = "shoes"
	goods = list(
		new /datum/data/shopping_good("Jackboots",			/obj/item/clothing/shoes/sneakers/red,				90),
		new /datum/data/shopping_good("Laceups",			/obj/item/clothing/shoes/laceup,					70),
		new /datum/data/shopping_good("Winter Boots",		/obj/item/clothing/shoes/winterboots,				80),
		new /datum/data/shopping_good("Sandals",			/obj/item/clothing/shoes/sandal,					20),
		new /datum/data/shopping_good("Brown Shoes",		/obj/item/clothing/shoes/sneakers/brown,			50),
		new /datum/data/shopping_good("Black Shoes",		/obj/item/clothing/shoes/sneakers/black,			50),
		new /datum/data/shopping_good("Red Shoes",			/obj/item/clothing/shoes/sneakers/red,				60)
		)

/obj/machinery/shop_rack/threads/hats
	icon_state = "hats"
	goods = list(
		new /datum/data/shopping_good("Flatcap",				/obj/item/clothing/head/flatcap,					70),
		new /datum/data/shopping_good("Pirate Hat",				/obj/item/clothing/head/pirate,						100),
		new /datum/data/shopping_good("Bowler Hat",				/obj/item/clothing/head/bowler,						80),
		new /datum/data/shopping_good("Tophat",					/obj/item/clothing/head/that,						100),
		new /datum/data/shopping_good("Green Striped Beanie",	/obj/item/clothing/head/beanie/stripedgreen,		60),
		new /datum/data/shopping_good("Red Beanie",				/obj/item/clothing/head/beanie/red,					60)
		)

/obj/machinery/shop_rack/threads/under
	icon_state = "under"
	goods = list(
		new /datum/data/shopping_good("Tactical Turtleneck",	/obj/item/clothing/under/syndicate/tacticool,				150),
		new /datum/data/shopping_good("Camo Fatigues",			/obj/item/clothing/under/syndicate/camo,					150),
		new /datum/data/shopping_good("Scavenger's Jumpsuit",	/obj/item/clothing/under/rank/cargo/miner/lavaland,			120),
		new /datum/data/shopping_good("Hazard Jumpsuit",		/obj/item/clothing/under/rank/engineering/engineer/hazard,	100)
		)