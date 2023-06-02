local _mission 		= 	count WAI_MissionData -1;
local _aiType 		= 	_this select 0; // "Bandit" или "Hero"
local _position 	= 	[40] call WAI_FindPos;
local _name 		= 	"Нефтяной склад";
local _startTime 	= 	diag_tickTime;
local _difficulty 	= 	"Medium";
local _localName 	= 	"STR_CL_OILDEPOT_TITLE";

diag_log format["[WAI]: [oil_depot.sqf]: %1 %2 миссия началась на %3.",_difficulty,_name,_position];

local _messages 	=
[
	 "STR_CL_OILDEPOT_ANNOUNCE"
	,"STR_CL_OILDEPOT_WIN"
	,"STR_CL_OILDEPOT_FAIL"
];

local _markers 	= 	[1,1,1,1];
_markers set [0, [_position, "WAI" + str(_mission), "ColorYellow", "", "ELLIPSE", "Solid", [600,600], [], 0]];
_markers set [1, [_position, "WAI" + str(_mission) + "dot", "ColorBlack", "mil_dot", "", "", [], [_localName], 0]];

if (WAI_AutoClaim) then
{
	_markers set [2, [_position, "WAI" + str(_mission) + "auto", "ColorRed", "", "ELLIPSE", "Border", [WAI_AcAlertDistance,WAI_AcAlertDistance], [], 0]];
};

DZE_ServerMarkerArray set [count DZE_ServerMarkerArray, _markers];
_markerIndex 			= 	count DZE_ServerMarkerArray - 1;
PVDZ_ServerMarkerSend 	= 	["start",_markers];
publicVariable "PVDZ_ServerMarkerSend";

WAI_MarkerReady 	= 	true;

DZE_MissionPositions set [count DZE_MissionPositions, _position];
local _posIndex 	= 	count DZE_MissionPositions - 1;

[_difficulty,(_messages select 0)] call WAI_Message;

local _timeout 		= 	false;
local _claimPlayer 	= 	objNull;

while {WAI_WaitForPlayer && !_timeout && {isNull _claimPlayer}} do {
	_claimPlayer 	= 	[_position, WAI_TimeoutDist] call isClosestPlayer;
	
	if (diag_tickTime - _startTime >= (WAI_Timeout * 60)) then
	{
		_timeout 	= 	true;
	};

	uiSleep 1;
};

if (_timeout) exitWith
{
	[_mission, _aiType, _markerIndex, _posIndex] call WAI_AbortMission;
	[_difficulty,(_messages select 2)] call WAI_Message;

	diag_log format["[WAI]: [oil_depot.sqf]: %1 %2 Время вышло.",_difficulty,_name];
};

// Создаем ящики
[[[[0,2,[3,WAI_Parts],0,0],WAI_CrateMd,[0.2,0]]],_position,_mission] call WAI_SpawnCrate;

// Постройки
[
	[
		["MAP_Ind_TankBig",[-9.5,7,-0.15]],
		["MAP_Ind_TankBig",[11,4,-0.15]],
		["MAP_Ind_TankBig",[-11,-12,-0.15]],
		["MAP_Ind_TankBig",[-28.5,-1.2,-0.15]],
		["MAP_Ind_TankBig",[-29,-12,-0.15]],
		["MAP_Ind_TankBig",[-26.2,20,-0.15]],
		["MAP_Ind_TankBig",[-6,28,-0.15]],
		["GUE_WarfareBVehicleServicePoint",[-30,-15,-0.015],-176.24],
		["GUE_WarfareBVehicleServicePoint",[21,3,-0.015],122.11],
		["GUE_WarfareBVehicleServicePoint",[-7,43,-0.015],-0.11],
		["Barrels",[0.1,6,-0.015],82.81],
		["Barrels",[-17,15,-0.015],-0.5],
		["Barrels",[18,-2,-0.015],-48],
		["Barrel1",[-16,-2,-0.015]],
		["Barrel1",[3,6,-0.015]],
		["Barrel1",[-11.6,18,-0.015]]
	],_position,_mission
] call WAI_SpawnObjects;

// Пешие ИИ
[[(_position select 0) - 25, (_position select 1) - 21, 0],(ceil random 2),_difficulty,"Random","","Random",WAI_GruSkin,3,_aiType,_mission] call WAI_SpawnGroup;
[[(_position select 0) + 32, (_position select 1) + 2, 0],(ceil random 3),_difficulty,"Random","","Random",WAI_GruSkin,3,_aiType,_mission] call WAI_SpawnGroup;
[[(_position select 0) + 9, (_position select 1) + 40, 0],(ceil random 5),_difficulty,"Random","","Random",WAI_GruSkin,3,_aiType,_mission] call WAI_SpawnGroup;
[[(_position select 0) - 41, (_position select 1) + 6, 0],(ceil random 5),_difficulty,"Random","","Random",WAI_GruSkin,3,_aiType,_mission] call WAI_SpawnGroup;

// Патрульная техника
[[(_position select 0) - 50, _position select 1, 0],[(_position select 0) - 50, _position select 1, 0],120,3,"Pickup_PK_GUE_DZE",_difficulty,"Bandit1_DZ",_aiType,_mission] call WAI_VehPatrol;

uiSleep 30;

[
	_mission,
	_position,
	_difficulty,
	_name,
	_localName,
	_aiType,
	_markerIndex,
	_posIndex,
	_claimPlayer,
	true, 				// Показывать маркер миссии?
	false, 				// Минное поле доступно на этой миссии? (смотри выше)
	["crate"], 			// Формат завершения: ["crate"], ["kill"], или ["assassinate", _unitGroup],
	_messages
] spawn WAI_MissionMonitor;