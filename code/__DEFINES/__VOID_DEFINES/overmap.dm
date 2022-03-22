#define SHUTTLE_INACTIVE_CREW 0
#define SHUTTLE_SSD_CREW 1
#define SHUTTLE_ACTIVE_CREW 2

///zlevel location of the overmap (1 is for centcom)
#define OVERMAP_Z_LEVEL 1

#define OVERMAP_MIN_X 1
#define OVERMAP_MAX_X 17
#define OVERMAP_MIN_Y (world.maxy - 17)
#define OVERMAP_MAX_Y world.maxy

//Add new star types here
#define SMALLSTAR 1
#define TWOSTAR 2
#define MEDSTAR 3
#define BIGSTAR 4


//Amount of times the overmap generator will attempt to place something before giving up
#define MAX_OVERMAP_PLACEMENT_ATTEMPTS 5

//Possible ship states
#define OVERMAP_SHIP_IDLE "idle"
#define OVERMAP_SHIP_FLYING "flying"
#define OVERMAP_SHIP_ACTING "acting"
#define OVERMAP_SHIP_DOCKING "docking"
#define OVERMAP_SHIP_UNDOCKING "undocking"
