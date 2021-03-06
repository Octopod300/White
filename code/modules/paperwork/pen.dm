/* Pens!
 * Contains:
 *		Pens
 *		Sleepy Pens
 *		Parapens
 */


/*
 * Pens
 */
/obj/item/weapon/pen
	desc = "It's a normal black ink pen."
	name = "pen"
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "pen"
	item_state = "pen"
	flags = FPRINT
	slot_flags = SLOT_BELT | SLOT_EARS
	throwforce = 0
	w_class = 1.0
	throw_speed = 7
	throw_range = 15
	m_amt = 10
	var/colour = "black"	//what colour the ink is!
	pressure_resistance = 2
	var/parrent_alog = 1   //write parrent attack log if 1


/obj/item/weapon/pen/blue
	desc = "It's a normal blue ink pen."
	icon_state = "pen_blue"
	colour = "blue"

/obj/item/weapon/pen/red
	desc = "It's a normal red ink pen."
	icon_state = "pen_red"
	colour = "red"

/obj/item/weapon/pen/invisible
	desc = "It's an invisble pen marker."
	icon_state = "pen"
	colour = "white"


/obj/item/weapon/pen/attack(mob/M as mob, mob/user as mob)
	if(!ismob(M))
		return
	user << "<span class='warning'>You stab [M] with the pen.</span>"
	M << "\red You feel a tiny prick!" //That's a whole lot of meta!
	if (parrent_alog)
		M.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been stabbed with [name]  by [user.name] ([user.ckey])</font>")
		user.attack_log += text("\[[time_stamp()]\] <font color='red'>Used the [name] to stab [M.name] ([M.ckey])</font>")

		//log_admin("ATTACK: [user] ([user.ckey]) stabbed [M] ([M.ckey]) with [src].")
		msg_admin_attack("[user] ([user.ckey])(<A HREF='?_src_=holder;adminplayerobservejump=\ref[user]'>JMP</A>) stabbed [M] ([M.ckey]) with [src].", 0)
		log_attack("[user.name] ([user.ckey]) Used the [src.name] to stab [M.name] ([M.ckey])")

	return


/*
 * Sleepy Pens
 */
/obj/item/weapon/pen/sleepypen
	desc = "It's a black ink pen with a sharp point and a carefully engraved \"Waffle Co.\""
	flags = FPRINT | OPENCONTAINER
	origin_tech = "materials=2;syndicate=5"
	parrent_alog = 0


/obj/item/weapon/pen/sleepypen/New()
	var/datum/reagents/R = new/datum/reagents(30) //Used to be 300
	reagents = R
	R.my_atom = src
	R.add_reagent("chloralhydrate", 22)	//Used to be 100 sleep toxin//30 Chloral seems to be fatal, reducing it to 22./N
	..()
	return


/obj/item/weapon/pen/sleepypen/attack(mob/M as mob, mob/user as mob)
	if(!(istype(M,/mob)))
		return
	..()
	var/contained = null
	var/list/injected = list()
	if(reagents.total_volume)
		if(M.reagents)
			for(var/datum/reagent/R in src.reagents.reagent_list)
				injected += R.name
			contained = english_list(injected)

			reagents.trans_to(M, 50) //used to be 150

	M.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been stabbed with [name]  by [user.name] ([user.ckey]). Reagents: [contained]</font>")
	user.attack_log += text("\[[time_stamp()]\] <font color='red'>Used the [name] to stab [M.name] ([M.ckey]). Reagents: [contained]</font>")

	msg_admin_attack("[user] ([user.ckey])(<A HREF='?_src_=holder;adminplayerobservejump=\ref[user]'>JMP</A>) stabbed [M] ([M.ckey]) with [src]. Reagents: [contained]", 0)
	log_attack("[user.name] ([user.ckey]) Used the [src.name] to stab [M.name] ([M.ckey]). Reagents: [contained]")

	return


/*
 * Parapens
 */
/obj/item/weapon/pen/paralysis
	flags = FPRINT | OPENCONTAINER
	origin_tech = "materials=2;syndicate=5"
	parrent_alog = 0

/obj/item/weapon/pen/paralysis/attack(mob/M as mob, mob/user as mob)
	if(!(istype(M,/mob)))
		return
	..()
	sleep(10)
	var/contained = null
	var/list/injected = list()
	if(reagents.total_volume)
		if(M && M.reagents)
			for(var/datum/reagent/R in src.reagents.reagent_list)
				injected += R.name
			contained = english_list(injected)

			reagents.trans_to(M, 25)
	if(M)
		M.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been stabbed with [name]  by [user.name] ([user.ckey]). Reagents: [contained]</font>")
		user.attack_log += text("\[[time_stamp()]\] <font color='red'>Used the [name] to stab [M.name] ([M.ckey]). Reagents: [contained]</font>")

		msg_admin_attack("[user] ([user.ckey])(<A HREF='?_src_=holder;adminplayerobservejump=\ref[user]'>JMP</A>) stabbed [M] ([M.ckey]) with [src]. Reagents: [contained]", 0)
		log_attack("[user.name] ([user.ckey]) Used the [src.name] to stab [M.name] ([M.ckey]). Reagents: [contained]")

	return

/obj/item/weapon/pen/paralysis/New()
	var/datum/reagents/R = new/datum/reagents(50)
	reagents = R
	R.my_atom = src
	R.add_reagent("zombiepowder", 20)
	R.add_reagent("cryptobiolin", 30)
	..()
	return