/*
	Medical Supply Camp by lazyink (Full credit for original code to TheSzerdi & TAW_Tonic)
	Updated to New Mission Format by Vampire
	Updated for DZMS 2.0 by JasonTM
*/

local _mission = count DZMSMissionData -1;
local _aiType = _this select 0;
local _coords = call DZMSFindPos;
local _name = "Medical Camp";
local _localName = "STR_CL_DZMS_MCAMP_TITLE";
local _hero = _aiType == "Hero";
local _markerColor = ["ColorRed","ColorBlue"] select _hero;
local _localized = ["STR_CL_MISSION_BANDIT","STR_CL_MISSION_HERO"] select _hero;
local _startTime = diag_tickTime;

diag_log format["[DZMS]: %1 %2 starting at %3.",_aiType,_name,_coords];

////////////////////// Do not edit this section ///////////////////////////
//[position,createMarker,setMarkerColor,setMarkerType,setMarkerShape,setMarkerBrush,setMarkerSize,setMarkerText,setMarkerAlpha]
local _markers = [1,1,1,1];
_markers set [0, [_coords,"DZMS" + str _mission,_markerColor,"","ELLIPSE","Grid",[200,200],[],0]];
_markers set [1, [_coords,"DZMSDot" + str _mission,"ColorBlack","Vehicle","","",[],[_localized,_localName],0]];
if (DZMSAutoClaim) then {_markers set [2, [_coords,"DZMSAuto" + str _mission,"ColorRed","","ELLIPSE","Border",[DZMSAutoClaimAlertDistance,DZMSAutoClaimAlertDistance],[],0]];};
DZE_ServerMarkerArray set [count DZE_ServerMarkerArray, _markers]; // Markers added to global array for JIP player requests.
local _markerIndex = count DZE_ServerMarkerArray - 1;
PVDZ_ServerMarkerSend = ["start",_markers];
publicVariable "PVDZ_ServerMarkerSend";
[_aiType,_localName,"STR_CL_DZMS_MCAMP_START"] call DZMSMessage;
DZMSMarkerReady = true;

// Add the mission's position to the global array so that other missions do not spawn near it.
DZE_MissionPositions set [count DZE_MissionPositions, _coords];
local _posIndex = count DZE_MissionPositions - 1;

// Wait until a player is within range or timeout is reached.
local _playerNear = false;
local _timeout = false;
while {!_playerNear && !_timeout} do {
	_playerNear = [_coords,DZMSTimeoutDistance] call DZMSNearPlayer;
	
	if (diag_tickTime - _startTime >= (DZMSMissionTimeOut * 60)) then {
		_timeout = true;
	};
	uiSleep 1;
};

if (_timeout) exitWith {
	[_mission, _aiType, _markerIndex, _posIndex] call DZMSAbortMission;
	[_aiType,_localName,"STR_CL_DZMS_MCAMP_FAIL"] call DZMSMessage;
	diag_log format["DZMS: %1 %2 aborted.",_aiType,_name];
};
//////////////////////////////// End //////////////////////////////////////

//Create the scenery
[[
	["Land_fort_artillery_nest",[-5.939,10.0459],-31.158424],
	["Land_fort_artillery_nest",[6.3374,-11.1944],-211.14516],
	["Land_fort_rampart",[12.2456,6.249],-120.93051],
	["Land_fort_rampart",[-11.4253,-7.628],59.42643],
	["Land_CamoNetVar_EAST",[4.1738,-7.9112],-27.004126],
	["PowGen_Big",[-0.8936,8.1582],-56.044361],
	["Barrel5",[-2.5074,7.3466]],
	["Barrel5",[-3.293,7.9179]],
	["Land_Campfire_burning",[3.1367,-5.087]],
	["FoldChair",[0.8589,-6.2676],-132.43658],
	["FoldChair",[2.6909,-7.4805],-184.45828],
	["FoldChair",[5.4175,-5.4903],96.993355],
	["FoldChair",[4.5722,-7.2305],142.91867],
	["FoldChair",[5.0542,-3.4649],55.969147]
],_coords,_mission] call DZMSSpawnObjects;

//Create the vehicles
[_mission,_coords,DZMSSmallVic,[-17.5078,5.2578]] call DZMSSpawnVeh;

//Create the loot
//[_mission,_coords,"USLaunchersBox","weapons",[-6.8277,5.6748]] call DZMSSpawnCrate;
[_mission,_coords,"DZ_MedBox","medical",[-7.1519,1.8144],-29.851013] call DZMSSpawnCrate;
[_mission,_coords,"DZ_MedBox","medical",[-7.4116,2.5244]] call DZMSSpawnCrate;

//DZMSAISpawn spawns AI to the mission.
//Usage: [_coords, count, skillLevel, Hero or Bandit, Mission Number]
[[(_coords select 0) - 0.5635,(_coords select 1) + 0.3173,0],3,0,_aiType,_mission] call DZMSAISpawn;
[[(_coords select 0) - 0.5635,(_coords select 1) + 0.3173,0],3,1,_aiType,_mission] call DZMSAISpawn;
[[(_coords select 0) - 0.5635,(_coords select 1) + 0.3173,0],3,2,_aiType,_mission] call DZMSAISpawn;
[[(_coords select 0) - 0.5635,(_coords select 1) + 0.3173,0],3,3,_aiType,_mission] call DZMSAISpawn;

// Start the mission loop.
[
	_mission,
	_coords,
	_aiType,
	_name,
	_localName,
	_markerIndex,
	_posIndex,
	"STR_CL_DZMS_MCAMP_WIN",
	"STR_CL_DZMS_MCAMP_FAIL"
] spawn DZMSWaitMissionComp;
