
/obj/projectile/bullet/pellet
	var/tile_dropoff = 1		//WS Edit - Shotgun Nerf
	var/tile_dropoff_s = 0.8		//WS Edit - Shotgun Nerf

/obj/projectile/bullet/pellet/shotgun_rubbershot
	name = "rubbershot pellet"
	damage = 2						//WS Edit Begin - Shotgun Nerf
	stamina = 8
	armour_penetration = -20
	tile_dropoff = 0.2			// Keep it at 10% per tile	//WS Edit End

/obj/projectile/bullet/pellet/shotgun_incapacitate
	name = "incapacitating pellet"
	damage = 1
	stamina = 6

/obj/projectile/bullet/pellet/Range()
	..()
	if(damage > 0)
		damage -= tile_dropoff
	if(stamina > 0)
		stamina -= tile_dropoff_s
	if(damage < 0 && stamina < 0)
		qdel(src)

/obj/projectile/bullet/pellet/shotgun_improvised
	tile_dropoff = 0.45		//Come on it does 4.5 damage don't be like that.		//WS Edit - Shotgun nerf
	damage = 4.5			//WS Edit - Shotgun nerf
	armour_penetration = -20		//WS Edit - Shotgun nerf

/obj/projectile/bullet/pellet/shotgun_improvised/Initialize()
	. = ..()
	range = rand(1, 8)

/obj/projectile/bullet/pellet/shotgun_improvised/on_range()
	do_sparks(1, TRUE, src)
	..()

// Mech Scattershot

/obj/projectile/bullet/scattershot
	damage = 25 //VoidTest Edit, changes 24 to 25
