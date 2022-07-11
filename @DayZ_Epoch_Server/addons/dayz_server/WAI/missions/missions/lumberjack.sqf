local _mission = count WAI_MissionData -1;
local _aiType = _this select 0; // "Bandit" or "Hero"
local _position = [80] call WAI_FindPos;
local _name = "Lumber Mill";
local _startTime = diag_tickTime;
local _difficulty = "Hard";
local _localized = ["STR_CL_MISSION_BANDIT", "STR_CL_MISSION_HERO"] select (_aiType == "Hero");
local _localName = "STR_CL_LUMBERMILL_TITLE";

diag_log format["[WAI]: %1 %2 started at %3.",_aiType,_name,_position];

local _messages = if (_aiType == "Hero") then {
	["STR_CL_HERO_LUMBER_ANNOUNCE","STR_CL_HERO_LUMBER_WIN","STR_CL_HERO_LUMBER_FAIL"];
} else {
	["STR_CL_BANDIT_LUMBERMILL_ANNOUNCE","STR_CL_BANDIT_LUMBERMILL_WIN","STR_CL_BANDIT_LUMBERMILL_FAIL"];
};

////////////////////// Do not edit this section ///////////////////////////
local _markers = [1,1,1,1];
//[position,createMarker,setMarkerColor,setMarkerType,setMarkerShape,setMarkerBrush,setMarkerSize,setMarkerText,setMarkerAlpha]
_markers set [0, [_position, "WAI" + str(_mission), "ColorRed", "", "ELLIPSE", "Solid", [300,300], [], 0]];
_markers set [1, [_position, "WAI" + str(_mission) + "dot", "ColorBlack", "mil_dot", "", "", [], [_localized,_localName], 0]];
if (WAI_AutoClaim) then {_markers set [2, [_position, "WAI" + str(_mission) + "auto", "ColorRed", "", "ELLIPSE", "Border", [WAI_AcAlertDistance,WAI_AcAlertDistance], [], 0]];};
DZE_ServerMarkerArray set [count DZE_ServerMarkerArray, _markers]; // Markers added to global array for JIP player requests.
_markerIndex = count DZE_ServerMarkerArray - 1;
PVDZ_ServerMarkerSend = ["start",_markers];
publicVariable "PVDZ_ServerMarkerSend";

WAI_MarkerReady = true;

// Add the mission's position to the global array so that other missions do not spawn near it.
DZE_MissionPositions set [count DZE_MissionPositions, _position];
local _posIndex = count DZE_MissionPositions - 1;

// Send announcement
[_difficulty,(_messages select 0)] call WAI_Message;

// Wait until a player is within range or timeout is reached.
local _timeout = false;
local _claimPlayer = objNull;

while {WAI_WaitForPlayer && !_timeout && {isNull _claimPlayer}} do {
	_claimPlayer = [_position, WAI_TimeoutDist] call isClosestPlayer;
	
	if (diag_tickTime - _startTime >= (WAI_Timeout * 60)) then {
		_timeout = true;
	};
	uiSleep 1;
};

if (_timeout) exitWith {
	[_mission, _aiType, _markerIndex, _posIndex] call WAI_AbortMission;
	[_difficulty,(_messages select 2)] call WAI_Message;
	diag_log format["WAI: %1 %2 aborted.",_aiType,_name,_position];
};
//////////////////////////////// End //////////////////////////////////////

//Spawn Crates
local _loot = if (_aiType == "Hero") then {Loot_LumberJack select 0;} else {Loot_LumberJack select 1;};
[[
	[_loot,WAI_CrateLg,[5,7]]
],_position,_mission] call WAI_SpawnCrate;

// Spawn Objects
[[
	["Land_Ind_SawMill",[-2.4,24]],
	["Land_Ind_Timbers",[11,8.6,-.1]],
	["Land_Ind_Timbers",[16,12,-.1],-10.45],
	["Land_Ind_Timbers",[6,-15],104.95],
	["Misc_palletsfoiled",[5,-9,-0.009]],
	["Misc_palletsfoiled_heap",[9,-8,-0.05]],
	["Land_water_tank",[-10,-7]],
	["UralWreck",[-17,5],59.2],
	["MAP_t_quercus3s",[22,25,-0.2]]
],_position,_mission] call WAI_SpawnObjects;

// Troops
[[(_position select 0) + 12, (_position select 1) + 22.5, 0],5,"extreme","Random","AT","LegendBackpack_DZE1",WAI_ApocalypticSkin,"random",[_aiType,150],_mission] call WAI_SpawnGroup;
[[(_position select 0) + 21, (_position select 1) + 11, 0],5,_difficulty,"Random","AA","LegendBackpack_DZE1",WAI_ApocalypticSkin,"random",_aiType,_mission] call WAI_SpawnGroup;
[[(_position select 0) - 1.12, (_position select 1) - 0.43, 0],5,"random","Random","","LegendBackpack_DZE1",WAI_ApocalypticSkin,"random",_aiType,_mission] call WAI_SpawnGroup;
[[(_position select 0) - 13, (_position select 1) - 23, 0],(ceil random 5),"random","Random","","WandererBackpack_DZE1",WAI_ApocalypticSkin,"random",_aiType,_mission] call WAI_SpawnGroup;
[[(_position select 0) - 13, (_position select 1) - 23, 0],(ceil random 5),"random","Random","","WandererBackpack_DZE1",WAI_ApocalypticSkin,"random",_aiType,_mission] call WAI_SpawnGroup;

[
	_mission, // Mission number
	_position, // Position of mission
	_difficulty, // Difficulty
	_name, // Name of Mission
	_localName, // localized marker text
	_aiType, // "Bandit" or "Hero"
	_markerIndex,
	_posIndex,
	_claimPlayer,
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup],
	_messages
] spawn WAI_MissionMonitor;