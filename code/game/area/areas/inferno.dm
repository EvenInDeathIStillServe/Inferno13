//INFERNO
/area/if13
	name = "error"
	icon_state = "error"
	has_gravity = STANDARD_GRAVITY
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED

/area/if13/wasteland
	name = "Wasteland"
	icon_state = "wasteland"
	ambientsounds = list('sound/if13ambience/battle_1.ogg','sound/if13ambience/battle_2.ogg','sound/if13ambience/battle_3.ogg', \
	'sound/if13ambience/rattlesnake_1.ogg','sound/if13ambience/rattlesnake_2.ogg','sound/if13ambience/rattlesnake_3.ogg','sound/if13ambience/bird_1.ogg','sound/if13ambience/bird_2.ogg','sound/if13ambience/bird_3.ogg','sound/if13ambience/bird_4.ogg')
	outdoors = TRUE
	sound_environment = SOUND_ENVIRONMENT_PLAIN

/area/if13/building
	name = "Building"
	icon_state = "building"
	ambientsounds = list('sound/if13ambience/ambigen_3.ogg','sound/if13ambience/ambigen_4.ogg','sound/if13ambience/ambigen_5.ogg', \
	'sound/if13ambience/ambigen_6.ogg','sound/if13ambience/ambigen_7.ogg','sound/if13ambience/ambigen_8.ogg','sound/if13ambience/ambigen_9.ogg')
	sound_environment = SOUND_ENVIRONMENT_ROOM

/area/if13/building/firestation
	name = "Fire Station"
	icon_state = "firestation"
	visit_journal = /datum/journal/visit/firestation

/area/if13/building/chemplant
	name = "Chemical Plant"
	icon_state = "chemplant"
	visit_journal = /datum/journal/visit/chemplant

/area/if13/building/accommodation
	name = "Accommodation"
	icon_state = "accommodation"
	area_flags = UNIQUE_AREA | FURNITURE_DEPLOYABLE

/area/if13/tunnel
	name = "Tunnel"
	icon_state = "tunnel"
	ambientsounds = list('sound/if13ambience/ambigen_9.ogg','sound/if13ambience/ambigen_12.ogg','sound/if13ambience/ambigen_15.ogg','sound/if13ambience/ambigen_16.ogg','sound/effects/steam_short.ogg','sound/effects/steam_long.ogg')
	sound_environment = SOUND_ENVIRONMENT_SEWER_PIPE

/area/if13/sewer
	name = "Sewer"
	icon_state = "sewer"
	ambientsounds = list('sound/if13ambience/ambigen_9.ogg','sound/effects/steam_short.ogg','sound/effects/steam_long.ogg')
	sound_environment = SOUND_ENVIRONMENT_SEWER_PIPE
	visit_journal = /datum/journal/visit/sewers

/area/if13/caves
	name = "Caves"
	icon_state = "caves"
	ambientsounds = list('sound/if13ambience/ambigen_15.ogg','sound/if13ambience/ambigen_16.ogg','sound/if13ambience/ambigen_17.ogg','sound/if13ambience/ambigen_18.ogg','sound/if13ambience/ambigen_19.ogg')
	sound_environment = SOUND_ENVIRONMENT_CAVE