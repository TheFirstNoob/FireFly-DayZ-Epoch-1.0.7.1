local _mission 		= 	count WAI_MissionData -1;
local _aiType 		= 	_this select 0; // "Bandit" или "Hero"
local _position 	= 	[30] call WAI_FindPos;
local _name 		= 	"Упавший спутник";
local _startTime 	= 	diag_tickTime;
local _difficulty 	= 	"Easy";
local _localName 	= 	"STR_CL_FALLENSATELLITE_TITLE";

diag_log format["[WAI]: [fallen_satelite.sqf]: %1 %2 миссия началась на %3.",_difficulty,_name,_position];

local _messages 	=
[
	 "STR_CL_FALLENSATELLITE_ANNOUNCE"
	,"STR_CL_FALLENSATELLITE_WIN"
	,"STR_CL_FALLENSATELLITE_FAIL"
];

local _markers 	= 	[1,1,1,1];
_markers set [0, [_position, "WAI" + str(_mission), "ColorGreen", "", "ELLIPSE", "Solid", [300,300], [], 0]];
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

	diag_log format["[WAI]: [fallen_satelite.sqf]: %1 %2 Время вышло.",_difficulty,_name];
};

// Создаем ящики
[[[[0,2,[3,WAI_Parts],0,0],WAI_CrateSm,[0,0]]],_position,_mission] call WAI_SpawnCrate;

// Постройки
[
	[
		["Satelit",[-8.41,3.37,-0.013]],
		["MAP_rubble_metal_plates_03",[-8.1,-3.8,0.01]],
		["MAP_rubble_metal_plates_01",[-6.8,-1.6,-0.015],61.76],
		["Land_Dirthump01",[-7.4,-2.8,-1.96],2.706],
		["Land_Dirthump01",[-7.4,-2.8,-1.99],-66.12],
		["Land_Fire_barrel_burning",[-6.1,-3.8,-0.85]]
	],_position,_mission
] call WAI_SpawnObjects;

// Пешие ИИ
[[(_position select 0) - 22, (_position select 1) + 7, 	0],(ceil random 3),_difficulty,"Random","","Random",WAI_GruSkin,3,_aiType,_mission] call WAI_SpawnGroup;
[[(_position select 0) + 15, (_position select 1) - 19, 0],(ceil random 4),_difficulty,"Random","","Random",WAI_GruSkin,3,_aiType,_mission] call WAI_SpawnGroup;

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