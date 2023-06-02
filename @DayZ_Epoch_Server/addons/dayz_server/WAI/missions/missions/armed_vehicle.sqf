local _mission 		= 	count WAI_MissionData -1;
local _aiType 		= 	_this select 0; 	// "Bandit" or "Hero"
local _position 	= 	[30] call WAI_FindPos;
local _vehclass 	= 	WAI_ArmedVeh call BIS_fnc_selectRandom;
local _vehname 		= 	getText (configFile >> "CfgVehicles" >> _vehclass >> "displayName");
local _name 		= 	format["Разбитый %1",_vehname];
local _startTime 	= 	diag_tickTime;
local _difficulty 	= 	"Medium";
local _localName 	= 	["STR_CL_ARMEDVEHICLE_TITLE",_vehname];
local _text 		= 	_localName;

diag_log format["[WAI]: [armed_vehicle.sqf]: %1 %2 миссия началась на %3.",_difficulty,_name,_position];

local _messages 	= 
[
	"STR_CL_ARMEDVEHICLE_ANNOUNCE"
	,"STR_CL_ARMEDVEHICLE_WIN"
	,"STR_CL_ARMEDVEHICLE_FAIL"
];

local _markers 	= 	[1,1,1,1];
_markers set [0, [_position, "WAI" + str(_mission), "ColorYellow", "", "ELLIPSE", "Solid", [600,600], [], 0]];
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

	diag_log format["[WAI]: [armed_vehicle.sqf]: %1 %2 Время вышло.",_difficulty,_name];
};

// Создаем ящики
[[[[0,2,[3,WAI_Parts],0,0],WAI_CrateMd,[0,7]]],_position,_mission] call WAI_SpawnCrate;
[[[[1,0,[3,WAI_VehAmmo],1,1],WAI_CrateMd,[7,0]]],_position,_mission] call WAI_SpawnCrate;
[[[[0,0,[20,WAI_AcloTrash],0,0],WAI_CrateMd,[3,5]]],_position,_mission] call WAI_SpawnCrate;

// Пешие ИИ
[_position,(ceil random 2),_difficulty,"Random","","Random","Bandit1_DZ",1,_aiType,_mission] call WAI_SpawnGroup;
[_position,(ceil random 2),_difficulty,"Random","","Random","Bandit2_DZ",1,_aiType,_mission] call WAI_SpawnGroup;
[_position,(ceil random 2),_difficulty,"Random","","Random","Bandit3_DZ",1,_aiType,_mission] call WAI_SpawnGroup;
[_position,(ceil random 3),_difficulty,"Random","","Random","Bandit4_DZ",1,_aiType,_mission] call WAI_SpawnGroup;
[_position,(ceil random 2),_difficulty,"Random","","Random","Bandit5_DZ",1,_aiType,_mission] call WAI_SpawnGroup;

// Добавим прожектора если время вечер/ночь
if ((daytime > 18) || (daytime < 6)) then
{
	[
		[
			[(_position select 0) + 15,(_position select 1) + 10, 0]
		],"SearchLight_RUS",_difficulty,_aiType,_aiType,"Random","Bandit5_DZ","Random",_mission
	] call WAI_SpawnStatic;
};

// Патрульная техника
[[(_position select 0) - 30, _position select 1, 0],[(_position select 0) - 30, _position select 1, 0],120,3,"Pickup_PK_GUE_DZE",_difficulty,"Bandit1_DZ",_aiType,_mission] call WAI_VehPatrol;

// Создаем технику (Статичная)
local _vehicle 	= 	[_vehclass,_position,_mission] call WAI_PublishVeh;
[_vehicle,_vehclass,2] call WAI_LoadAmmo;

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
	false, 			// Минное поле доступно на этой миссии?
	["kill"], 		// Формат завершения: ["crate"], ["kill"], или ["assassinate", _unitGroup],
	_messages
] spawn WAI_MissionMonitor;
