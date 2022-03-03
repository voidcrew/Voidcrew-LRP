/obj/structure/closet/secure_closet/hos_lite //Snowflake map item for VoidTest
	name = "\proper head of security's locker"
	req_access = list(ACCESS_HOS)
	icon_state = "hos"

/obj/structure/closet/secure_closet/hos_lite/PopulateContents()
	..()
	new /obj/item/storage/box/deputy(src) //WS edit - Small QoL Brig additions
	new /obj/item/clothing/neck/cloak/hos(src)
	new /obj/item/clothing/under/rank/command(src) //WS edit - better command uniforms
	new /obj/item/cartridge/hos(src)
	new /obj/item/radio/headset/heads/hos/alt(src) //WS edit - Small QoL Brig additions
	new /obj/item/radio/headset/heads/hos(src)
	new /obj/item/clothing/under/rank/security/head_of_security/parade/female(src)
	new /obj/item/clothing/under/rank/security/head_of_security/parade(src)
	new /obj/item/clothing/suit/armor/hos/trenchcoat(src) //WS edit - Small QoL Brig additions
	new /obj/item/clothing/suit/armor/hos(src)
	new /obj/item/clothing/under/rank/security/head_of_security/skirt(src)
	new /obj/item/clothing/under/rank/security/head_of_security/alt(src)
	new /obj/item/clothing/under/rank/security/head_of_security/alt/skirt(src)
	new /obj/item/clothing/suit/space/hardsuit/security/hos(src)
	new /obj/item/clothing/head/HoS(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses/eyepatch(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses/gars/supergars(src)
	new /obj/item/clothing/suit/armor/vest/security/hos(src) //WS Edit - Better security jumpsuit sprites
	new /obj/item/storage/lockbox/medal/sec(src)
	new /obj/item/megaphone/sec(src)
	new /obj/item/holosign_creator/security(src)
	new /obj/item/clothing/mask/gas/sechailer/swat(src)
	new /obj/item/storage/box/flashbangs(src)
	new /obj/item/shield/riot/tele(src)
	new /obj/item/storage/belt/security/full(src)
	new /obj/item/gun/ballistic/automatic/pistol/commander(src) //WS edit - free lethals
	new /obj/item/ammo_box/magazine/co9mm(src)
	new /obj/item/ammo_box/magazine/co9mm(src)
	new /obj/item/disk/design_disk/ammo_c9mm(src)
	new /obj/item/circuitboard/machine/techfab/department/security(src)
	new /obj/item/storage/photo_album/HoS(src)

/obj/structure/closet/secure_closet/pilot_officer // Snowflake map item for VoidTest
	name = "\proper pilot officer's locker"
	desc = "A storage unit containing useful equipment for a spacecraft pilot or mechanic."
	req_one_access = list(ACCESS_SECURITY, ACCESS_MINERAL_STOREROOM)
	icon_state = "sec"

/obj/structure/closet/secure_closet/pilot_officer/PopulateContents()
	..()
	new /obj/item/stack/sheet/metal(src, 25)
	new /obj/item/storage/box/metalfoam(src)
	new /obj/item/clothing/ears/earmuffs(src)
	new /obj/item/flashlight/flare(src)
	new /obj/item/flashlight/flare(src)
	new /obj/item/restraints/handcuffs/cable(src)
	new /obj/item/melee/classic_baton/telescopic(src)
	new /obj/item/gun/energy/e_gun/mini(src)
	new /obj/item/flashlight/seclite(src)
	new /obj/item/clothing/suit/space/pilot(src)
	new /obj/item/clothing/head/helmet/space/pilot(src)
	new /obj/item/clothing/shoes/jackboots(src)
