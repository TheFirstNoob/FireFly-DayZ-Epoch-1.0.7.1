local _mission 		= 	count WAI_MissionData -1;
local _aiType 		= 	_this select 0; // "Bandit" или "Hero"
local _position 	= 	[80] call WAI_FindPos;
local _name 		= 	"Рудник";
local _startTime 	= 	diag_tickTime;
local _difficulty 	= 	"Hard";
local _localName 	= 	"STR_CL_GOLDMINE_TITLE";

diag_log format["[WAI]: [gold_mine.sqf]: %1 %2 миссия началась на %3.",_difficulty,_name,_position];

local _messages 	=
[
	 "STR_CL_GOLDMINE_ANNOUNCE"
	,"STR_CL_GOLDMINE_WIN"
	,"STR_CL_GOLDMINE_FAIL"
];

local _markers 	= 	[1,1,1,1];
_markers set [0, [_position, "WAI" + str(_mission), "ColorRed", "", "ELLIPSE", "Solid", [900,900], [], 0]];
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

	diag_log format["[WAI]: [gold_mine.sqf]: %1 %2 Время вышло.",_difficulty,_name];
};

// Создаем ящики
[[[[0,2,[3,WAI_Parts],0,0],WAI_CrateLg,[0.2,0]]],_position,_mission] call WAI_SpawnCrate;

// Постройки
[
	[
		["MAP_R2_RockWall",[-24,11,-7.1],-85.388],
		["MAP_R2_RockWall",[6,16,-5.9],-151.6],
		["MAP_R2_RockWall",[30,3,-7.1],40.18],
		["MAP_R2_RockWall",[45,-18,-7.1],131.1],
		["MAP_R2_RockWall",[-29,-12,-7.1],-258.57],
		["MAP_R2_RockWall",[-0.1,15,16.85]],
		["MAP_R2_RockWall",[19,-9,17.6],-128.72],
		["MAP_R2_RockWall",[-11,-3,14.8],165.8],
		["MAP_R2_RockWall",[-3,-9,20.37]],
		["MAP_R2_RockWall",[-29,-27,-7.1],66.4],
		["MAP_R2_RockWall",[-20,-36,-7.1],23.5],
		["MAP_R2_RockWall",[-2,-25,16.2],-13.9],
		["MAP_R2_RockWall",[11,-30,16.2],-28.07],
		["MAP_R2_RockTower",[7,-24,-20.4]],
		["MAP_R2_Boulder2",[14,-27,-0.015]],
		["MAP_R2_Boulder1",[18,-37,-0.015]],
		["MAP_R2_Rock1",[-2,-7,-1.99,-25.05],-4.74],
		["MAP_Ind_HammerMill",[30,-53,-6.1],-69.97],
		["UralWreck",[34,-59,-0.01],14.54],
		["MAP_Ind_Conveyer",[22,-45,0.1],116.29],
		["Land_Dirthump01",[13,-38,-1.41],92.4],
		["Land_Dirthump01",[13,-39,-1.45],42.23],
		["MAP_R2_RockTower",[60,-55,-26.69]],
		["MAP_R2_RockTower",[12,-121,-0.02],98.4],
		["Gold_Vein_DZE",[13,-14,-0.01]],
		["Gold_Vein_DZE",[-6,-25,-0.01]],
		["Gold_Vein_DZE",[-8,-17,-0.01]],
		["fiberplant",[7,-1,-0.02]],
		["fiberplant",[5,-6,-0.02]],
		["fiberplant",[-13,-21,-0.02]],
		["fiberplant",[19,-21,-0.02]]
	],_position,_mission
] call WAI_SpawnObjects;

// Пешие ИИ
[[(_position select 0) + 20, (_position select 1) - 54, .01],(ceil random 4),_difficulty,"Random","","Random",WAI_GruSkin,3,_aiType,_mission] call WAI_SpawnGroup;
[[(_position select 0) - 15, (_position select 1) - 70, .01],(ceil random 5),_difficulty,"Random","","Random",WAI_GruSkin,3,_aiType,_mission] call WAI_SpawnGroup;
[[(_position select 0) + 60, (_position select 1) - 38, .01],(ceil random 6),_difficulty,"Random","","Random",WAI_GruSkin,3,_aiType,_mission] call WAI_SpawnGroup;
[[(_position select 0) + 33, (_position select 1) + 20, .01],(ceil random 6),_difficulty,"Random","","Random",WAI_GruSkin,3,_aiType,_mission] call WAI_SpawnGroup;

// Турели
[
	[
		[(_position select 0) + 44, (_position select 1) - 55, .01],
		[(_position select 0) + 4,  (_position select 1) - 70, .01]
	],"M2StaticMG",_difficulty,_aiType,_aiType,"random","random","random",_mission
] call WAI_SpawnStatic;

// Добавим прожектора если время вечер/ночь
if ((daytime > 18) || (daytime < 6)) then
{
	[
		[
			[(_position select 0) + 47, (_position select 1) - 58, 0],
			[(_position select 0) + 7, (_position select 1) - 73, 0]
		],"SearchLight_RUS",_difficulty,_aiType,_aiType,"random","random","random",_mission
	] call WAI_SpawnStatic;
};

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
	true, 				// Минное поле доступно на этой миссии? (смотри выше)
	["crate"], 			// Формат завершения: ["crate"], ["kill"], или ["assassinate", _unitGroup],
	_messages
] spawn WAI_MissionMonitor;