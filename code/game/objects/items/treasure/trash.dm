/obj/item/treasure
	icon = 'icons/obj/treasure.dmi'

/obj/item/treasure/trash/tincan
	name = "tin can"
	desc = "An empty tin can. Nope, no use trying to drip it into your mouth."
	icon_state = "tincan1"
	obj_value = 10

/obj/item/treasure/trash/tincan/Initialize()
	..()
	icon_state = "tincan[rand(1,4)]"

/obj/item/treasure/trash/coffeepot
	name = "coffee pot"
	desc = "An old coffee pot. Probably not good for coffee anymore: who knows what's been living inside."
	icon_state = "coffee_pot"
	obj_value = 40

/obj/item/treasure/trash/pipe
	name = "pipe"
	desc = "An independent piece of pipe, out to strike its own fortune as a bludgeoning tool. It's not doing very well."
	icon_state = "pipe"
	obj_value = 20

/obj/item/treasure/rubberducky
	name = "rubber ducky"
	desc = "Rubber ducky you're so fine, you make bathtime lots of fuuun. Rubber ducky I'm awfully fooooond of yooooouuuu~"
	icon_state = "rubberducky"
	obj_value = 75

/obj/item/treasure/watch
	name = "pocket watch"
	desc = "A golden pocket watch. It's not ticking anymore, but who cares?"
	icon_state = "rubberducky"
	obj_value = 350

/obj/item/treasure/documents
	name = "pre-Calamity documents"
	desc = "Ancient documents of some kind. Might be of value to historians."
	icon_state = "docs"
	obj_value = 200

/obj/item/treasure/economy/coin/copper
	name = "copper coin"
	desc = "A pre-Calamity copper coin. Not really worth anything apart from collection value."
	icon_state = "coin_copper"
	obj_value = 25

/obj/item/treasure/economy/coin/silver
	name = "silver coin"
	desc = "A pre-Calamity silver coin. Might fetch a pretty penny."
	icon_state = "coin_silver"
	obj_value = 100

/obj/item/treasure/economy/coin/gold
	name = "gold coin"
	desc = "A pre-Calamity gold coin. Now THIS is worth money."
	icon_state = "coin_gold"
	obj_value = 250