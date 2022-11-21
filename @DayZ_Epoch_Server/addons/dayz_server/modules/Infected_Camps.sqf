/*
Spawns infected camps

Author:
	Foxy
*/

#include "\z\addons\dayz_code\util\Math.hpp"
#include "\z\addons\dayz_code\loot\Loot.hpp"

//Number of infected camps to spawn
#define CAMP_NUM 6

//Minimum distance between camps
#define CAMP_MIN_DIST 800

//Base class of objects to add loot to
#define CAMP_CONTAINER_BASE "IC_Tent"

//Loot per tent
#define LOOT_MIN 2
#define LOOT_MAX 8

//Random objects per camp
#define OBJECT_MIN 4
#define OBJECT_MAX 12

//Radius around the camp in which random objects are spawned
#define OBJECT_RADIUS_MIN 8
#define OBJECT_RADIUS_MAX 15

#define SEARCH_CENTER getMarkerPos "center"
#define SEARCH_RADIUS (getMarkerSize "center") select 0
#define SEARCH_EXPRESSION "(5 * forest) + (4 * trees) + (3 * meadow) - (20 * houses) - (30 * sea)" //+ (3 * meadow) - (20 * houses) - (30 * sea)
#define SEARCH_PRECISION 30
#define SEARCH_ATTEMPTS 10

private
[
	"_typeGroup",
	"_lootGroup",
	"_objectGroup",
	"_type",
	"_position",
	"_composition",
	"_compositionObjects",
	"_objectPos",
	"_marker",
	"_marker_position",
	"_starttime",
	"_markerdot","_missiontype","_refreshmarker"
];

_typeGroup = Loot_GetGroup("InfectedCampType");
_lootGroup = Loot_GetGroup("InfectedCamp");
_objectGroup = Loot_GetGroup("InfectedCampObject");

for "_i" from 1 to (CAMP_NUM) do
{
	//Select type of camp
	_type = Loot_SelectSingle(_typeGroup);
	_composition = _type select 1;
	
	_startTime = time;
	//Find a position

	for "_j" from 1 to (SEARCH_ATTEMPTS) do
	{
		_position = ((selectBestPlaces [SEARCH_CENTER, SEARCH_RADIUS, SEARCH_EXPRESSION, SEARCH_PRECISION, 1]) select 0) select 0;
		_position set [2, 0];
		_marker_position = [_position,10,300,0,0,1500,0] call BIS_fnc_findSafePos;
		//_marker = createMarker [ format ["InfectedCamp_%1", _startTime], _marker_position];
		//_marker setMarkerType "mil_box";
		
		_markerdot = "mil_triangle";
		_missiontype = 1; //0=EPOCH_EVENT_RUNNING 1=SPECIAL_EVENT_RUNNING
		uiSleep 1;
		_refreshmarker = [_marker_position,_markerdot,_missiontype] execVM "\z\addons\dayz_server\modules\RefreshMarkers.sqf";
		
		//Check if a camp already exists within the minimum distance
		if (count (_position nearObjects [CAMP_CONTAINER_BASE,CAMP_MIN_DIST]) < 1) exitWith {};
	};
	
	diag_log format ["[СЕРВЕР]: [ЭВЕНТ]: [Зараженный лагерь]: Создаем (%1) на %2", _composition, _position];
	
	//Spawn composition
	_compositionObjects = [_position, random 360,_composition] call spawnComposition;
	
	//Add loot to containers
	{
		if (_x isKindOf (CAMP_CONTAINER_BASE)) then
		{
			Loot_InsertCargo(_x, _lootGroup, round Math_RandomRange(LOOT_MIN, LOOT_MAX));
		};
	} forEach _compositionObjects;
	
	//Spawn objects around the camp
	{
		_objectPos = [_position, OBJECT_RADIUS_MIN, OBJECT_RADIUS_MAX, 5] call fn_selectRandomLocation;
		
		Loot_Spawn(_x, _objectPos, "");
		
	} forEach Loot_Select(_objectGroup, round Math_RandomRange(OBJECT_MIN, OBJECT_MAX));
};