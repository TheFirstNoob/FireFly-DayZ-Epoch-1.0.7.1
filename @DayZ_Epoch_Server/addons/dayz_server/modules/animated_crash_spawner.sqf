/*
	Название скрипта: animated_crash_spawner.sqf
	Оригинальный автор: Grafzahl / Finest
	Модификация от BushWookie & Forgotten для Epoch
	Модификация от f3cuk для Epoch 1.0.5.1
	Модификация от JasonTM для Epoch 1.0.6.2
	Модификация от JasonTM для Epoch 1.0.7
	Версия скрипта: 1.3.4
	Последнее обновление: 05-31-2021
*/

#include "\z\addons\dayz_code\loot\Loot.hpp"

// КОНФИГ
#define DEBUG_MODE true 			// Включить режим диагностики? (Серверный RPT) (True - Да/False - Нет)
#define CRASH_TIMEOUT 21600 		// Время на исчезновение ивента, если игрок не нашел его (В Секундах)
#define GUARANTEED_LOOT	12 			// Гарантированное количество лута
#define RANDOM_LOOT	20 				// Случайное дополнительное количество лута
#define SPAWN_FIRE true 			// Создать Дым/Огонь над ХелиКрашем? (True - Да/False - Нет)
#define FADE_FIRE false				// Дым/Огонь исчезнет со временем?
#define PREWAYPOINTS 5 				// Количество точек, который должен пройти вертолет, чтобы упасть
#define MIN_LOOT_RADIUS 3 			// Минимальный радиус спавна лута от ХелиКраша (В Метрах)
#define MAX_LOOT_RADIUS 15 			// Максимальный радиус спавна лута от ХелиКраша (В Метрах)
#define MARKER_RADIUS 400 			// Радиус маркера (В Метрах)
#define SHOW_MARKER	true 			// Показывать маркер на карте? (True - Да/False - Нет)
#define MARKER_NAME false 			// Добавить название маркера (ХелиКраша)? , SHOW_MARKER должен быть True (True - Да/False - Нет) (ЗАМЕНЕН НА ИКОНКУ!!!) Старый код: _markers set [1, [_marker_pos, format ["dot_%1", _time], "ColorBlack", "mil_dot","", "", [], ["STR_CL_ESE_CRASHSITE_MARKER",_crashName], 0]];
#define LOWER_GRASS	true 			// Убирать траву в зоне ХелиКраша? (True - Да/False - Нет)

local _crashDamage 	= 	1; 				// Количество урона, которое вертолет может получить до падения (от 0,1 до 1) При меньшем значении вертолет может получить меньше урона до падения. 1 - полностью уничтожено. 0,1 - что-то вроде DMR может один раз выстрелить в вертолет и он будет считаться падающим.
local _exploRange 	= 	200; 			// На каком расстоянии от заданной точки падения вертолет должен начать падать?
local _messageType 	= 	"Hint"; 		// Тип вывода оповещения. Параметры: "Hint","TitleText". ***ВНИМАНИЕ: Hint появляется в том же месте экрана, что и обычные Hint где Дебаг монитор.
local _startDist 	= 	4000; 			// Увеличьте этот параметр, чтобы задержать время, необходимое для прибытия самолета/вертолета на миссию

#define TITLE_COLOR "#00FF11" 	// Hint параметры: Цвет верхней линии
#define TITLE_SIZE "2" 			// Hint параметры: Размер верхней линии
#define IMAGE_SIZE "4" 			// Hint параметры: Размер изображения

#define SEARCH_BLACKLIST [[[2092,14167],[10558,12505]]]		// Территории в которые не будет падать самолет\вертолет. Массив: [X coord, Z coord]...

// НИЧЕГО ТУТ НЕ МЕНЯЙТЕ.
local _ran15 		= 	0;
local _isClose1 	= 	false;
local _isClose2 	= 	false;
local _isClose3 	= 	false;
local _inFlight 	= 	true;
local _end 			= 	false;
local _lootArray 	= 	[];

// Не меняйте параметры ниже если не знаете зачем они!
// Массив: [ID вертолета, ID Остова, Это самолет?]
local _select 	= 
[
	 ["Mi17_DZE",			"Mi17Wreck",	false]
	,["UH60M_MEV_EP1_DZ",	"MH60Wreck",	false]
	,["MH60S_DZE",			"MH60Wreck",	false]
	,["UH1H_DZE",			"UH1YWreck",	false]
] call BIS_fnc_selectRandom;

local _heliModel 	= 	_select select 0;
local _crashModel 	= 	_select select 1;
local _plane 		= 	_select select 2;
local _crashName 	= 	getText (configFile >> "CfgVehicles" >> _heliModel >> "displayName");
local _img 			= 	(getText (configFile >> "CfgVehicles" >> _heliModel >> "picture"));

if (_messageType == "Hint") then
{
	RemoteMessage 	= 	["hintWithImage",["STR_CL_ACS_TITLE",["STR_CL_ACS_ANNOUNCE",_crashName]],[_img,TITLE_COLOR,TITLE_SIZE,IMAGE_SIZE]];
}
else
{
	RemoteMessage 	= 	["titleText",["STR_CL_ACS_ANNOUNCE",_crashName]];
};
publicVariable "RemoteMessage";

local _pos 	= 	[getMarkerPos "crashsites", 0, (getMarkerSize "crashsites") select 0, 20, 0, .3, 0, SEARCH_BLACKLIST] call BIS_fnc_findSafePos;
_pos set [2,0];

local _PorM 		= 	if (random 1 > .5) then {"+"} else {"-"};
local _PorM2 		= 	if (random 1 > .5) then {"+"} else {"-"};
local _heliStart 	= 	call compile format ["[(%1 select 0) %2 %4,(%1 select 1) %3 %4, 400]",_pos,_PorM,_PorM2,_startDist];

if (DEBUG_MODE) then
{
	diag_log format ["[СЕРВЕР]: [ЭВЕНТ]: [ХелиКраш]: %1 начал полет из %2 к %3 сейчас!(Время: %4)",_crashName,_heliStart,_pos,round(time)];
};

local _time 		= 	time;
local _crashwreck 	= 	createVehicle [_heliModel,_heliStart,[],0,"FLY"];
_crashwreck setPos _heliStart;
dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_crashwreck];
_crashwreck engineOn true;
_crashwreck flyInHeight 150;

if (_plane) then
{
	_crashDamage = .5;
	_crashwreck setDamage .4;
	_crashwreck forceSpeed 250;
	_crashwreck setSpeedMode "LIMITED";
}
else
{
	_crashwreck forceSpeed 150;
	_crashwreck setSpeedMode "NORMAL";
};

local _landingzone 	= 	"HeliHEmpty" createVehicle [0,0,0];
_landingzone setPos _pos;
local _aigroup 		= 	createGroup civilian;
local _pilot 		= 	_aigroup createUnit ["SurvivorW2_DZ",getPos _crashwreck,[],0,"FORM"];
_pilot setCombatMode "BLUE";
_pilot moveInDriver _crashwreck;
_pilot assignAsDriver _crashwreck;
local _wp 		= 	[];
local _vel 		= 	[];
local _dir 		= 	0;
local _speed 	= 	0;
local _crash 	= 	objNull;

uiSleep 0.5;

if(PREWAYPOINTS > 0) then
{
	for "_x" from 1 to PREWAYPOINTS do
	{
		local _preWaypointPos 	= 	[getMarkerPos "crashsites",0,(getMarkerSize "crashsites") select 0,10,0,3000,0] call BIS_fnc_findSafePos;
		_wp 					= 	_aigroup addWaypoint [_preWaypointPos,0];
		_wp setWaypointType "MOVE";
		_wp setWaypointBehaviour "CARELESS";
	};
};

_wp 	= 	_aigroup addWaypoint [position _landingzone, 0];
_wp setWaypointType "MOVE";
_wp setWaypointBehaviour "CARELESS";

while {_inFlight} do {
	if ((_crashwreck distance _pos) <= 1000 && !_isClose1) then
	{
		if (_plane) then
		{
			_crashwreck flyInHeight 100;
			_crashwreck forceSpeed 150;
			_crashwreck setSpeedMode "NORMAL";
			_exploRange 	= 	360;
		}
		else
		{
			_crashwreck flyInHeight 100;
			_crashwreck forceSpeed 100;
			_crashwreck setSpeedMode "NORMAL";
		};

		_isClose1 	= 	true;
	};
	
	if ((_crashwreck distance _pos) <= _exploRange && !_isClose2) then
	{
		if (_plane) then
		{
			_crashwreck setDamage 1;
			_vel 	= 	velocity _crashwreck;
			_dir 	= 	direction _crashwreck;
			_speed 	= 	100;
			_crashwreck setVelocity [(_vel select 0)-(sin _dir*_speed),(_vel select 1)-(cos _dir*_speed),(_vel select 2)-30];
		}
		else
		{
			_crashwreck setHit ["mala vrtule", 1];
			_ran15 	= 	random 15;
			_crashwreck setVelocity [_ran15,_ran15,-25];
			_crashwreck setDamage .9;
		};

		_isClose2 	= 	true;
	};
	
	if (getPos _crashwreck select 2 <= 30 && !_isClose3) then
	{
		_crashwreck setVelocity [_ran15,_ran15,-20];
		_isClose3 	= 	true;
	};
	
	if (getPos _crashwreck select 2 <= 5) then
	{
		deleteVehicle _pilot;
		_crashwreck setDamage 1;
		_inFlight 	= 	false;
	};

	uiSleep 1;
};

if (DEBUG_MODE) then
{
	diag_log format ["[СЕРВЕР]: [ЭВЕНТ]: [ХелиКраш]: %1 только что упал на: %2!",_crashName,getPos _crashwreck];
};

_pos 	= 	[getPos _crashwreck select 0,getPos _crashwreck select 1,0];
_dir 	= 	getDir _crashwreck;

deleteVehicle _crashwreck;
deleteVehicle _landingzone;

local _isWater 	= 	surfaceIsWater [getPos _crashwreck select 0,getPos _crashwreck select 1];

if (_isWater) then
{
	
	if (_messageType == "Hint") then
	{
		RemoteMessage 	= 	["hintWithImage",["STR_CL_ACS_TITLE",["STR_CL_ACS_WATERCRASH",_crashName]],[_img,TITLE_COLOR,TITLE_SIZE,IMAGE_SIZE]];
	}
	else
	{
		RemoteMessage 	= 	["titleText",["STR_CL_ACS_WATERCRASH",_crashName]];
	};

	publicVariable "RemoteMessage";
}
else
{
	_crash 	= 	_crashModel createVehicle [0,0,0];
	_crash setDir _dir;
	_crash setPos _pos;
	_crash setVariable ["permaLoot",true];
	
	if (SPAWN_FIRE) then
	{
		PVDZ_obj_Fire = [_crash,6,time,false,FADE_FIRE];
		publicVariable "PVDZ_obj_Fire";
	};
	
	local _num 			= 	round(random RANDOM_LOOT) + GUARANTEED_LOOT;
	local _itemTypes 	= 	Loot_SelectSingle(Loot_GetGroup("CrashSiteType"));
	local _lootGroup 	= 	Loot_GetGroup(_itemTypes select 2);
	local _radius 		= 	0;
	local _lootPos 		= 	[0,0,0];
	local _lootVeh 		= 	objNull;
	
	{
		_radius 	= 	(random MAX_LOOT_RADIUS) + MIN_LOOT_RADIUS;
		_lootPos 	= 	[_pos,_radius,random 360] call BIS_fnc_relPos;
		_lootPos set [2,0];
		_lootVeh 	= 	Loot_Spawn(_x,_lootPos,"");
		_lootVeh setVariable ["permaLoot",true];
		_lootArray set[count _lootArray,_lootVeh];

		if (LOWER_GRASS) then
		{
			createVehicle ["ClutterCutter_small_2_EP1",_lootPos,[],0,"CAN_COLLIDE"];
		};
		
	} forEach Loot_Select(_lootGroup, _num);
		
	if (DEBUG_MODE) then
	{
		diag_log(format["[СЕРВЕР]: [ЭВЕНТ]: [ХелиКраш]: Лут появился на: '%1' Категория лута: '%2'",_lootPos,(_itemTypes select 2)]);
	};
	
	local _endTime 	= 	time - _time;
	local _time 	= 	time;
	
	if (_messageType == "Hint") then
	{
		RemoteMessage 	= 	["hintWithImage",["STR_CL_ACS_TITLE",["STR_CL_ACS_CRASH",_crashName]],[_img,TITLE_COLOR,TITLE_SIZE,IMAGE_SIZE]];
	}
	else
	{
		RemoteMessage 	= 	["titleText",["STR_CL_ACS_CRASH",_crashName]];
	};
	publicVariable "RemoteMessage";
	
	if (DEBUG_MODE) then
	{
		diag_log(format["[СЕРВЕР]: [ЭВЕНТ]: [ХелиКраш]: Падение выполнено! Остов на: %2 - Прошло: %1 Секунд || Дистанция просчета до POC: %3 метров",round(_endTime),str(_pos),round(_pos distance _crash)]);
	};
	
	local _marker_pos 	= 	[_pos,0,MARKER_RADIUS,0,1,2000,0] call BIS_fnc_findSafePos;
	
	{
		deleteVehicle _x;
	} count (nearestObjects [_pos,["CraterLong"],50]);
	
	local _markers 		= 	[1,1];
	local _markerIndex 	= 	-1;
	
	if (SHOW_MARKER) then
	{
		//[position,createMarker,setMarkerColor,setMarkerType,setMarkerShape,setMarkerBrush,setMarkerSize,setMarkerText,setMarkerAlpha]

		_markers set [0, [_marker_pos, format ["HeliCrash_Marker_%1",_time],"","FOB","","",[],[],1]];

		if (MARKER_NAME) then
		{
			_markers set [1, [_marker_pos, format ["dot_%1",_time],"ColorBlack","FOB","","",[],["STR_CL_ESE_CRASHSITE_MARKER",_crashName],1]];
		};

		DZE_ServerMarkerArray set [count DZE_ServerMarkerArray, _markers]; 	// Маркера добавляются в запросы JIP игроков.
		_markerIndex 			= 	count DZE_ServerMarkerArray - 1;
		PVDZ_ServerMarkerSend 	= 	["start",_markers];
		publicVariable "PVDZ_ServerMarkerSend";
	};
	
	while {!_end} do {
		if ((time - _time) >= CRASH_TIMEOUT) then
		{
			deleteVehicle _crash;
			{
				deleteVehicle _x;
			} count _lootArray;
			
			if (_messageType == "Hint") then
			{
				RemoteMessage 	= 	["hintWithImage",["STR_CL_ACS_TITLE",["STR_CL_ACS_TIMEOUT",_crashName]],[_img,TITLE_COLOR,TITLE_SIZE,IMAGE_SIZE]];
			}
			else
			{
				RemoteMessage 	= 	["titleText",["STR_CL_ACS_TIMEOUT",_crashName]];
			};
			publicVariable "RemoteMessage";
			
			if (DEBUG_MODE) then
			{
				diag_log(format["[ХелиКраш]: %1 время вышло, убираем маркер",_crashName]);
			};
			_end 	= 	true;
		};
		
		/*
		{
			if ((isPlayer _x) && (_x distance _pos <= 25)) then
			{
				if (_messageType == "Hint") then
				{
					RemoteMessage 	= 	["hintWithImage",["STR_CL_ACS_TITLE",["STR_CL_ACS_SUCCESS",_crashName]],[_img,TITLE_COLOR,TITLE_SIZE,IMAGE_SIZE]];
				}
				else
				{
					RemoteMessage 	= 	["titleText",["STR_CL_ACS_SUCCESS",_crashName]];
				};
				publicVariable "RemoteMessage";
				
				if (DEBUG_MODE) then
				{
					diag_log(format["[ХелиКраш]: Был найден игроком: %1, убираем маркер",(name _x)]);
				};
				_end 	= 	true;
			};
		} count playableUnits;
		*/

		uiSleep 30;
	};
	
	if ((count _markers) > 0) then
	{
		// Говорим всем клиентам, что нужно убрать маркер
		local _remove 	= 	[];
		{
			if (typeName _x == "ARRAY") then
			{
				_remove set [count _remove,(_x select 1)];
			};
		} count _markers;
		PVDZ_ServerMarkerSend 	= 	["end",_remove];
		publicVariable "PVDZ_ServerMarkerSend";
		DZE_ServerMarkerArray set [_markerIndex,-1];
	};
};

deleteGroup _aigroup;