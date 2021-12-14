#define ARMORID "armor-[beat]-[slash]-[stab]-[shot]-[enflame]-[electric]-[caustic]-[irradiation]-[cold]-[melee]-[bullet]-[laser]-[energy]-[bomb]-[bio]-[fire]-[acid]-[wound]"

/proc/getArmor(beat = 0, slash = 0, stab = 0, shot = 0, enflame = 0, electric = 0, caustic = 0, irradiation = 0, cold = 0, melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, fire = 0, acid = 0, wound = 0)
	. = locate(ARMORID)
	if (!.)
		. = new /datum/armor(beat, slash, stab, shot, enflame, electric, caustic, irradiation, cold, melee, bullet, laser, energy, bomb, bio, fire, acid, wound)

/datum/armor
	datum_flags = DF_USE_TAG
	var/beat
	var/slash
	var/stab
	var/shot
	var/enflame
	var/electric
	var/caustic
	var/irradiation
	var/cold

	var/melee
	var/bullet
	var/laser
	var/energy
	var/bomb
	var/bio
	var/fire
	var/acid
	var/wound
	var/consume

/datum/armor/New(beat = 0, slash = 0, stab = 0, shot = 0, enflame = 0, electric = 0, caustic = 0, irradiation = 0, cold = 0, melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, fire = 0, acid = 0, wound = 0)
	src.beat = beat
	src.slash = slash
	src.stab = stab
	src.shot = shot
	src.enflame = enflame
	src.electric = electric
	src.caustic = acid
	src.irradiation = irradiation
	src.cold = cold

	src.melee = melee
	src.bullet = bullet
	src.laser = laser
	src.energy = energy
	src.bomb = bomb
	src.bio = bio
	src.fire = fire
	src.acid = acid
	src.wound = wound
	src.consume = melee
	tag = ARMORID

/datum/armor/proc/modifyRating(beat = 0, slash = 0, stab = 0, shot = 0, enflame = 0, electric = 0, caustic = 0, irradiation = 0, cold = 0, melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, fire = 0, acid = 0, wound = 0)
	return getArmor(src.beat+beat, src.slash+slash, src.stab+stab, src.shot+shot, src.enflame+enflame, src.electric+electric, src.caustic+caustic, src.irradiation+irradiation, src.cold+cold, src.melee+melee, src.bullet+bullet, src.laser+laser, src.energy+energy, src.bomb+bomb, src.bio+bio, src.fire+fire, src.acid+acid, src.wound+wound)

/datum/armor/proc/modifyAllRatings(modifier = 0)
	return getArmor(beat+modifier, slash+modifier, stab+modifier, shot+modifier, enflame+modifier, electric+modifier, caustic+modifier, irradiation+modifier, cold+modifier, melee+modifier, bullet+modifier, laser+modifier, energy+modifier, bomb+modifier, bio+modifier, fire+modifier, acid+modifier, wound+modifier)

/datum/armor/proc/setRating(beat, slash, stab, shot, enflame, electric, caustic, irradiation, cold, melee, bullet, laser, energy, bomb, bio, fire, acid, wound)
	return getArmor((isnull(beat) ? src.beat : beat),\
					(isnull(slash) ? src.slash : slash),\
					(isnull(stab) ? src.stab : stab),\
					(isnull(shot) ? src.shot : shot),\
					(isnull(enflame) ? src.enflame : enflame),\
					(isnull(electric) ? src.electric : electric),\
					(isnull(caustic) ? src.caustic : caustic),\
					(isnull(irradiation) ? src.irradiation : irradiation),\
					(isnull(cold) ? src.cold : cold),\
					(isnull(melee) ? src.melee : melee),\
					(isnull(bullet) ? src.bullet : bullet),\
					(isnull(laser) ? src.laser : laser),\
					(isnull(energy) ? src.energy : energy),\
					(isnull(bomb) ? src.bomb : bomb),\
					(isnull(bio) ? src.bio : bio),\
					(isnull(fire) ? src.fire : fire),\
					(isnull(acid) ? src.acid : acid),\
					(isnull(wound) ? src.wound : wound))

/datum/armor/proc/getRating(rating)
	return vars[rating]

/datum/armor/proc/getList()
	return list("beat" = beat, "slash" = slash, "stab" = stab, "shot" = shot, "enflame" = enflame, "electric" = electric, "caustic" = caustic, "irradiation" = irradiation, "cold" = cold, MELEE = melee, BULLET = bullet, LASER = laser, ENERGY = energy, BOMB = bomb, BIO = bio, FIRE = fire, ACID = acid, WOUND = wound)

/datum/armor/proc/attachArmor(datum/armor/AA)
	return getArmor(beat+AA.beat, slash+AA.slash, stab+AA.stab, shot+AA.shot, enflame+AA.enflame, electric+AA.electric, caustic+AA.caustic, irradiation+AA.irradiation, cold+AA.cold, melee+AA.melee, bullet+AA.bullet, laser+AA.laser, energy+AA.energy, bomb+AA.bomb, bio+AA.bio, fire+AA.fire, acid+AA.acid, wound+AA.wound)

/datum/armor/proc/detachArmor(datum/armor/AA)
	return getArmor(beat-AA.beat, slash-AA.slash, stab-AA.stab, shot-AA.shot, enflame-AA.enflame, electric-AA.electric, caustic-AA.caustic, irradiation-AA.irradiation, cold-AA.cold, melee+AA.melee, bullet+AA.bullet, laser+AA.laser, energy-AA.energy, bomb-AA.bomb, bio-AA.bio, fire-AA.fire, acid-AA.acid, wound-AA.wound)

/datum/armor/vv_edit_var(var_name, var_value)
	if (var_name == NAMEOF(src, tag))
		return FALSE
	. = ..()
	tag = ARMORID // update tag in case armor values were edited

#undef ARMORID
