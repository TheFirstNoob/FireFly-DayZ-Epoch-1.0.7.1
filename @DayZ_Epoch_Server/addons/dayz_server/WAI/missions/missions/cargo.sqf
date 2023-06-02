local _mission 		= 	count WAI_MissionData -1;
local _aiType 		= 	_this select 0; // "Bandit" или "Hero"
local _position 	= 	[30] call WAI_FindPos;
local _name 		= 	"Нелегальный склад";
local _startTime 	= 	diag_tickTime;
local _difficulty 	= 	"Medium";
local _localName 	= 	"STR_CL_CARGO_TITLE";

diag_log format["[WAI]: [cargo.sqf]: %1 %2 миссия началась на %3.",_difficulty,_name,_position];

local _messages 	=
[
	 "STR_CL_CARGO_ANNOUNCE"
	,"STR_CL_CARGO_WIN"
	,"STR_CL_CARGO_FAIL"
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

	diag_log format["[WAI]: [cargo.sqf]: %1 %2 Время вышло.",_difficulty,_name];
};

// Создаем ящики
[[[[0,2,[3,WAI_Parts],0,0],WAI_CrateSm,[0.2,0]]],_position,_mission] call WAI_SpawnCrate;

// Постройки
[
	[
		["MAP_Misc_Cargo1Bo",[14,-10,-0.01]],
		["MAP_Misc_Cargo2A",[18,-10,-0.01],-89],
		["MAP_Misc_Cargo2B",[20,-3,-0.01],2],
		["MAP_Misc_Cargo2C",[14,1,-0.01]],
		["MAP_Misc_Cargo2C",[21,-17,-0.01],119],
		["MAP_Misc_Cargo1G",[9,-1,-0.01],39],
		["MAP_Misc_Cargo1E",[11,7,-0.01],86],
		["MAP_Misc_Cargo1C",[5,-15,-0.01]],
		["MAP_Misc_Cargo1B",[6,-8,-0.01],111],
		["MAP_Misc_Cargo2E",[3.5,6,-0.01],-40],
		["MAP_Misc_Cargo2D",[-2,-10,-0.01]],
		["MAP_Misc_Cargo1F",[-11,10,-0.01]],
		["MAP_Misc_Cargo1E",[-9,-4,-0.01]],
		["MAP_Misc_Cargo1D",[21,6,-0.01],-48],
		["MAP_Misc_Cargo1Bo",[-6,6,-0.01],-139],
		["MAP_Misc_Cargo1B",[-19,-7,-0.01],-41],
		["MAP_Misc_Cargo1A",[-15,-1,-0.01],14],
		["MAP_Misc_Cargo1G",[-4,16,-0.01],109],
		["MAP_Misc_Cargo2C",[7,11,-0.01],-114],
		["MAP_Misc_Cargo2B",[4,-24,-0.01],-74],
		["MAP_Misc_Cargo2C",[4,20,-0.01],-44],
		["MAP_Misc_Cargo2A",[-12,-13,-0.01],-22],
		["MAP_A_CraneCon",[-21,10,-0.01]]
	],_position,_mission
] call WAI_SpawnObjects;

// Пешие ИИ
[[(_position select 0) + 3,  (_position select 1) + 25, 0],(ceil random 3),_difficulty,"Random","","Random",WAI_GruSkin,3,_aiType,_mission] call WAI_SpawnGroup;
[[(_position select 0) - 27, (_position select 1) - 4, 	0],(ceil random 3),_difficulty,"Random","","Random",WAI_GruSkin,3,_aiType,_mission] call WAI_SpawnGroup;
[[(_position select 0) + 33, (_position select 1) - 2, 	0],(ceil random 3),_difficulty,"Random","","Random",WAI_GruSkin,3,_aiType,_mission] call WAI_SpawnGroup;
[[(_position select 0) + 10, (_position select 1) - 37, 0],(ceil random 3),_difficulty,"Random","","Random",WAI_GruSkin,3,_aiType,_mission] call WAI_SpawnGroup;

// Патрульная техника
[[(_position select 0) + 60, (_position select 1), 0],[(_position select 0) - 60, (_position select 1), 0],150,2,"HMMWV_M2_DZE",_difficulty,_aiType,_aiType,_mission] call WAI_VehPatrol;

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