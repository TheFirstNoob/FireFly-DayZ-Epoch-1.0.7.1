local _mission 		= 	count WAI_MissionData -1;
local _aiType 		= 	_this select 0; // "Bandit" или "Hero"
local _position 	= 	[30] call WAI_FindPos;
local _name 		= 	"Лагерь беженцев";
local _startTime 	= 	diag_tickTime;
local _difficulty 	= 	"Easy";
local _localName 	= 	"STR_CL_REFUGEE_TITLE";

diag_log format["[WAI]: [refugee.sqf]: %1 %2 миссия началась на %3.",_difficulty,_name,_position];

local _messages 	=
[
	 "STR_CL_REFUGEE_ANNOUNCE"
	,"STR_CL_REFUGEE_WIN"
	,"STR_CL_REFUGEE_FAIL"
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

	diag_log format["[WAI]: [refugee.sqf]: %1 %2 Время вышло.",_difficulty,_name];
};

// Создаем ящики
[
	[
		[
			[[2,WAI_LowLevelGearWeapon],2,[6,WAI_Camps],2,1],WAI_CrateMd,[0,0,-0.15]
		]
	],_position,_mission
] call WAI_SpawnCrate;

// Постройки
[
	[
		["MAP_Astan",[-3,-5.4,-0.15]],
		["MAP_A_tent",[3.8,-1,-0.15],64],
		["Land_Campfire_burning",[-2,-1,-0.15]],
		["Fuel_can",[0.1,-3,-0.15]],
		["Land_Blankets_EP1",[-4,0.4,-0.15]],
		["Park_bench1",[-1,4,-0.15]],
		["MAP_Astan",[-4,10,-0.15],128],
		["Land_Bag_EP1",[1,7,-0.015],-176.24],
		["Land_A_tent",[-10,-6,-0.015],-166.5],
		["LADAWreck",[-11,2,-0.015],16.4],
		["Land_transport_cart_EP1",[-9,7,-0.015],23]
	],_position,_mission
] call WAI_SpawnObjects;

// Пешие ИИ
[[(_position select 0) - 13, (_position select 1) - 7, 0],(ceil random 2),_difficulty,WAI_LowLevelGearWeapon,"",WAI_SmallSizePacks,WAI_AllUnmilitarySkin,0,_aiType,_mission] call WAI_SpawnGroup;
[[(_position select 0) + 7, (_position select 1) + 15, 0],(ceil random 2),_difficulty,WAI_LowLevelGearWeapon,"",WAI_SmallSizePacks,WAI_AllUnmilitarySkin,0,_aiType,_mission] call WAI_SpawnGroup;
[[(_position select 0) + 4, (_position select 1) - 14, 0],(ceil random 2),_difficulty,WAI_LowLevelGearWeapon,"",WAI_SmallSizePacks,WAI_AllUnmilitarySkin,0,_aiType,_mission] call WAI_SpawnGroup;
[[(_position select 0) + 9, (_position select 1) - 3, 0],(ceil random 2),_difficulty,WAI_LowLevelGearWeapon,"",WAI_SmallSizePacks,WAI_AllUnmilitarySkin,0,_aiType,_mission] call WAI_SpawnGroup;

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
	["kill"], 			// Формат завершения: ["crate"], ["kill"], или ["assassinate", _unitGroup],
	_messages
] spawn WAI_MissionMonitor;