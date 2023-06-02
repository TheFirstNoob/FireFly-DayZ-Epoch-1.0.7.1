local _mission 		= 	count WAI_MissionData -1;
local _aiType 		= 	_this select 0; 	// "Bandit" or "Hero"
local _position 	= 	[30] call WAI_FindPos;
local _name 		= 	"Армейская база";
local _startTime 	= 	diag_tickTime;
local _difficulty 	= 	"Extreme";
local _localName 	= 	"STR_CL_ARMYBASE_TITLE";
local _text 		= 	_localName;

diag_log format["[WAI]: [armybase.sqf]: %1 %2 миссия началась на %3.",_difficulty,_name,_position];

local _messages 	=
[
	"STR_CL_ARMYBASE_ANNOUNCE"
	,"STR_CL_ARMYBASE_WIN"
	,"STR_CL_ARMYBASE_FAIL"
];

local _markers 	= 	[1,1,1,1];
_markers set [0, [_position, "WAI" + str(_mission), "ColorBlack", "", "ELLIPSE", "Solid", [1200,1200], [], 0]];
_markers set [1, [_position, "WAI" + str(_mission) + "dot", "ColorBlack", "mil_dot", "", "", [], _text, 0]];

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

	diag_log format["[WAI]: [armybase.sqf]: %1 %2 Время вышло.",_difficulty,_name];
};

//Spawn Crates
local _loot = if (_aiType == "Hero") then {Loot_ArmyBase select 0;} else {Loot_ArmyBase select 1;};
[[
	[_loot,WAI_CrateSm,[1.2,0]]
],_position,_mission] call WAI_SpawnCrate;

// Создаем объекты
[[
	["WarfareBCamp",[-1,-12.4,-0.12]],
	["Base_WarfareBBarrier10xTall",[15,-16,-0.64]],
	["Base_WarfareBBarrier10xTall",[-15,-16,-0.64]],
	["Base_WarfareBBarrier10xTall",[15,16,-0.64]],
	["Base_WarfareBBarrier10xTall",[-15,16,-0.64]],
	["MAP_posed",[17,11]],
	["MAP_posed",[-20,11]],
	["MAP_fort_artillery_nest",[-1,-31,-0.56],-178.615],
	["MAP_Fortress_02",[-27,-13]],
	["MAP_Fortress_02",[25,-13],-89.16],
	["MAP_fortified_nest_big",[26,13],-180.55],
	["MAP_fortified_nest_big",[-26,13],-179.808],
	["MAP_Barbedwire",[10,-20]],
	["MAP_Barbedwire",[-11,-20]],
	["MAP_Barbedwire",[16,-20]],
	["MAP_Barbedwire",[-17,-20]],
	["WarfareBDepot",[-0.02,20,-0.1],-179.832],
	["T72Wreck",[29,-30],82.75],
	["T72WreckTurret",[20,-36]],
	["MAP_T34",[2,5],-71.49],
	["Land_Fort_Watchtower_EP1",[26,-4],-180.097],
	["Land_Fort_Watchtower_EP1",[-28,-6],0.999],
	["Land_transport_crates_EP1",[-18,-9],52.43],
	["MAP_Barel4",[-16,-10]],
	["MAP_Barel1",[-16,-11]],
	["MAP_t_picea3f",[-8,-6]],
	["MAP_t_picea3f",[16,20]],
	["MAP_t_pinusS2f",[14,9]],
	["MAP_t_pinusS2f",[-3,-6],-99.19],
	["MAP_t_picea3f",[10,-13]],
	["MAP_t_pinusN2s",[14,-8]],
	["MAP_t_pinusN2s",[12,19],-73.36],
	["MAP_t_pinusN2s",[-21,-13],52.65],
	["MAP_t_pinusS2f",[-34,12]],
	["MAP_t_picea3f",[-13,21]],
	["MAP_t_picea2s",[-17,21]],
	["MAP_t_picea2s",[13,-12]],
	["MAP_t_picea1s",[30,-0.01]],
	["MAP_t_picea2s",[-47,-21]],
	["MAP_t_picea2s",[34,-48]],
	["MAP_t_pinusN2s",[31,-52]],
	["MAP_t_pinusS2f",[12,-5]],
	["Land_Fire_barrel_burning",[-0.01,-0.01]]
],_position,_mission] call WAI_SpawnObjects;

// Пешие ИИ
[[(_position select 0) - 12, (_position select 1) + 2, 0],5,_difficulty,"Random","","Random",WAI_GruSkin,3,_aiType,_mission] call WAI_SpawnGroup;
[[(_position select 0) + 2,  (_position select 1) + 2, 0],5,_difficulty,"Random","","Random",WAI_GruSkin,3,_aiType,_mission] call WAI_SpawnGroup;
[[(_position select 0) + 14, (_position select 1) - 35, 0],5,_difficulty,"Random","","Random",WAI_GruSkin,3,_aiType,_mission] call WAI_SpawnGroup;
[[(_position select 0) + 13, (_position select 1) + 35, 0],(ceil random 5),_difficulty,"Random","","Random",WAI_GruSkin,3,_aiType,_mission] call WAI_SpawnGroup;
[[(_position select 0) + 13, (_position select 1) + 35, 0],(ceil random 5),_difficulty,"Random","","Random",WAI_GruSkin,3,_aiType,_mission] call WAI_SpawnGroup;

// Патрульная техника
[[(_position select 0) - 32, (_position select 1) - 56, 0],[(_position select 0) + 22, (_position select 1) + 35, 0],150,2,"M113_UN_EP1_DZE",_difficulty,_aiType,_aiType,_mission] call WAI_VehPatrol;
[[(_position select 0) - 20, (_position select 1) - 65, 0],[(_position select 0) + 45, (_position select 1) + 50, 0],300,4,"HMMWV_M2_DZE",_difficulty,_aiType,_aiType,_mission] call WAI_VehPatrol;
[[(_position select 0) - 40, (_position select 1) - 80, 0],[(_position select 0) + 60, (_position select 1) + 75, 0],450,7,"UAZ_MG_CDF_DZE",_difficulty,_aiType,_aiType,_mission] call WAI_VehPatrol;

// Турели
[[
	[(_position select 0) - 0.01, (_position select 1) + 41, 0],
	[(_position select 0) + 0.1, (_position select 1) - 25, 0]
],"M2StaticMG",_difficulty,_aiType,_aiType,"Random","Random","Random",_mission] call WAI_SpawnStatic;

// Добавим прожектора если время вечер/ночь
if ((daytime > 18) || (daytime < 6)) then
{
	[
		[
			[(_position select 0) - 0.01, (_position select 1) + 39.5, 0],
			[(_position select 0) + 0.1, (_position select 1) - 23.5, 0]		
		],"SearchLight_RUS",_difficulty,_aiType,_aiType,"Random","Bandit5_DZ","Random",_mission
	] call WAI_SpawnStatic;
};

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
	true, 			// Показывать маркер миссии?
	true, 			// Минное поле доступно на этой миссии?
	["crate"], 		// Формат завершения: ["crate"], ["kill"], или ["assassinate", _unitGroup],
	_messages
] spawn WAI_MissionMonitor;