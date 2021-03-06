/obj/effect/spawner/regenlootdrop/if13/meds
	name = "meds regenerative"

	loot = list(
				/obj/item/reagent_containers/hypospray/medipen/nanite = 10,
				/obj/item/stack/medical/gauze = 35,
				/obj/item/stack/medical/suture = 35,
				/obj/item/stack/medical/ointment = 20,
				)

/obj/effect/spawner/regenlootdrop/if13/money
	name = "money regenerative"
	var/money_max
	var/money_min

	loot = list(/obj/item/holochip = 100)

/obj/effect/spawner/regenlootdrop/if13/money/special_loot_act(obj/item/holochip/holo)
	holo.credits = rand(money_min, money_max)
	if (prob(75)) //Will most of the time be a multiple of 5, but there's always going to be a weirdo stashing 98 bucks
		holo.credits = round(holo.credits,5)
	holo.update_appearance()

/obj/effect/spawner/regenlootdrop/if13/money/low
	money_max = 100
	money_min = 25

/obj/effect/spawner/regenlootdrop/if13/money/medium
	money_max = 100
	money_min = 250

/obj/effect/spawner/regenlootdrop/if13/firestation
	loot = list(
				/obj/item/clothing/head/helmet/if13/turnout = 5,
				/obj/item/clothing/suit/armor/if13/turnout = 5,
				/obj/item/clothing/gloves/if13/turnout = 5,
				/obj/item/clothing/shoes/if13/turnout = 5,
				/obj/item/melee/club/fireaxe = 5,
				/obj/item/melee/club/crowbar = 15,
				/obj/item/extinguisher = 10,
				/obj/item/clothing/mask/gas = 10,
				/obj/item/flashlight = 10,
				/obj/item/clothing/head/cone = 10,
				/obj/item/storage/fancy/cigarettes = 10)

/obj/effect/spawner/regenlootdrop/if13/grave
	loot = list(
				/obj/item/treasure/watch = 3,
				/obj/item/treasure/rubberducky = 1,
				/obj/item/instrument/violin = 1,
				/obj/item/instrument/banjo = 1,
				/obj/item/instrument/guitar = 1,
				/obj/item/instrument/eguitar = 1,
				/obj/item/instrument/accordion = 1,
				/obj/item/instrument/trumpet = 1,
				/obj/item/instrument/harmonica = 1,
				/obj/item/storage/belt/holster = 2,
				/obj/item/treasure/documents = 3,
				/obj/item/clothing/under/suit/charcoal = 1,
				/obj/item/clothing/under/suit/navy = 1,
				/obj/item/clothing/under/suit/burgundy = 1,
				/obj/item/clothing/under/suit/checkered = 1,
				/obj/item/treasure/economy/coin/copper = 25,
				/obj/item/treasure/economy/coin/silver = 10,
				/obj/item/treasure/economy/coin/gold = 5)