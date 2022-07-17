// Updated mission example for DayZ Epoch 1.0.7+. Please review missions in the hero and bandit folder for additional examples.

// Note: One of the DayZ Epoch devs discovered through testing that using the local command when creating a variable is faster than using the private array so it has been used here.

local _mission = count WAI_MissionData -1; // Do Not Change This Line.
local _aiType = _this select 0; // Type of AI - "Hero" or "Bandit" - this is sent from the scheduler.
local _position = [80] call WAI_FindPos; // Get a safe position 80 meters from the nearest object. You can change this number.
local _name = "Mission Name"; // this is mainly used for rpt entries
local _startTime = diag_tickTime; // used for timeout below
local _difficulty = "Hard"; // Options: "Easy", "Medium", "Hard", "Extreme".
local _markerColor = "ColorRed"; // Color of the mission marker. https://community.bistudio.com/wiki/Arma_3:_CfgMarkerColors
local _localized = ["STR_CL_MISSION_BANDIT", "STR_CL_MISSION_HERO"] select (_aiType == "Hero"); // These localized strings will place "Hero" or "Bandit" text in front of the mission text.
local _localName = "STR_CL_MISSIONNAME_TITLE"; // This localized string name is used for the mission marker. It does not have to be a localized string.

// Sends a message to the server's rpt file
diag_log format["[WAI]: %1 %2 started at %3.",_aiType,_name,_position];

// Mission messages examples
local _messages = [
	"A Mission has spawned, hurry up to claim the loot!",	// mission announcement - this message displays when the mission starts
	"The mission was complete/objective reached",			// mission success - this message displays when the mission is completed by a player
	"The mission timed out and nobody was in the vicinity"	// mission fail - this message displays when a mission times out.
];

// Example with localized message strings
local _messages = if (_aiType == "Hero") then {
	["STR_CL_HERO_MISSIONNAME_ANNOUNCE","STR_CL_HERO_MISSIONNAME_WIN","STR_CL_HERO_MISSIONNAME_FAIL"];
} else {
	["STR_CL_BANDIT_MISSIONNAME_ANNOUNCE","STR_CL_BANDIT_MISSIONNAME_WIN","STR_CL_BANDIT_MISSIONNAME_FAIL"];
};

////////////////////// Do not edit this section ///////////////////////////
local _markers = [1,1,1,1];
//[position,createMarker,setMarkerColor,setMarkerType,setMarkerShape,setMarkerBrush,setMarkerSize,setMarkerText,setMarkerAlpha]
_markers set [0, [_position, "WAI" + str(_mission), _markerColor, "", "ELLIPSE", "Solid", [300,300], [], 0]];
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

// Crate Spawning Format - [loot, position, crate type(array or class name), [x-offset, y-offset,z-coordinate(optional)],direction(optional)]
// Multiple crates can be spawned. See Firestation mission for example.
// See lines 246-248 in config.sqf for crate classnames

// Dynamic loot array example
// Parameters:	0: _crate
//				1: Max number of long guns OR [MAX number of long guns,gun_array]
//				2: Max number of tools OR [MAX number of tools,tool_array]
//				3: Max number of items OR [MAX number of items,item_array]
//				4: Max number of pistols OR [MAX number of pistol,pistol_array]
//				5: Max number of backpacks OR [MAX number of backpacks,backpack_array]
//[16,8,[3,WAI_HighValue],3,[4,WAI_PacksLg]] - example of calling custom arrays instead of default

// Save loot array to a variable
local _loot = [10,[4,WAI_ToolsBuildable],[30,WAI_Ikea],3,4];

//Spawn Crate with loot variable in first position.
[[
	[_loot,WAI_CrateLg,[0,0]] // [loot variable, crate array, 2d offsets]
],_position,_mission] call WAI_SpawnCrate;

//Spawn Crate with fixed classname and loot array not previously save to variable. It works either way.
[[
	[[8,5,15,3,2],"DZ_AmmoBoxBigUS",[.3,0,-.01],30] // [[loot array, crate classname, 3d offests], direction]
],_position,_mission] call WAI_SpawnCrate;

// Mission object Spawning Format - [class name, [x-offset, y-offset,z-offset(optional)],direction(optional)]
// Offsets are modifications to the [x,y,z] coordinates relative to the [0,0,0] mission center position.
// If no z-coordinate or direction are provided, then the function will set them to 0.
[[
	["land_fortified_nest_big",[-40,0],90],
	["land_fortified_nest_big",[40,0],270],
	["land_fortified_nest_big",[0,-40]],
	["land_fortified_nest_big",[0,40],180],
	["Land_Fort_Watchtower",[-10,0]],
	["Land_Fort_Watchtower",[10,0],180],
	["Land_Fort_Watchtower",[0,-10],270],
	["Land_Fort_Watchtower",[0,10],90]
],_position,_mission] call WAI_SpawnObjects;

// Group Spawn Examples
// Parameters:	0: Position
//				1: Unit Count
//				2: Unit Skill ("easy","medium","hard","extreme" or "random")
//				3: Primary gun - "Random", "Unarmed", "Classname", Array
//				4: Launcher - "AT", "AA", or "" for no launcher
//				5: Backpack - "Random", "Classname", "none" or Array
//				6: Skin (_aiType, "Random","classname", array)
//				7: Gearset - 0,1,2, or "Random"
//				8: AI Type (_aiType, or ["type", #] format to overwrite default gain amount) ***Used to determine humanity gain or loss***
//				9: Mission variable from line 5 (_mission)

local _num = round (random 3) + 4; // You can use this to get a random number of AI between 4 and 7.
[[_position select 0, _position select 1, 0],_num,"extreme","random","AT","random",_aiType,"random",[_aiType,150],_mission] call WAI_SpawnGroup;
[[_position select 0, _position select 1, 0],4,_difficulty,"random","AA","random",_aiType,"random",_aiType,_mission] call WAI_SpawnGroup;
[[_position select 0, _position select 1, 0],4,"random","random","","random",_aiType,"random",_aiType,_mission] call WAI_SpawnGroup;
[[_position select 0, _position select 1, 0],4,"random","random","","random",_aiType,"random",_aiType,_mission] call WAI_SpawnGroup;
[[_position select 0, _position select 1, 0],4,"random","random","","random",_aiType,"random",_aiType,_mission] call WAI_SpawnGroup;

// Assassination target example
// This is the same as normal group spawns but we assign it to a variable instead for use in the trigger below (if there are multiple units in this group you'll need to kill them all)
local _unitGroup = [[_position select 0, _position select 1, 0],1,"hard","random","","random",_aiType,"random",_aiType,_mission] call WAI_SpawnGroup;


// Humvee Patrol Example
// Parameters:	0: Patrol position
//				1: Starting position
//				2: Patrol radius
//				3: Number of Waypoints
//				4: Vehicle classname
//				5: Unit Skill ("easy","medium","hard","extreme" or "random")
//				6: Skin ("Hero","bandit","random" or "classname")
//				7: AI Type ("bandit","Hero") ***Used to determine humanity gain or loss***
//				8: Mission Variable from line 5 (_mission)
[[(_position select 0) + 100, _position select 1, 0],[(_position select 0) + 100, _position select 1, 0],50,2,"HMMWV_Armored","random",_aiType,_aiType,_mission] call WAI_VehPatrol;
 
// Static Turret Examples
// Parameters:	0: Positions
//				1: Classname ("classname" or "random" to pick from WAI_StaticWeapons)
//				2: Unit Skill ("easy","medium","hard","extreme" or "random") ***NO effect if WAI_StaticSkills = true;***
//				3: Skin (_aiType,"random","classname", or array)
//				4: AI Type _aiType ("Hero" or "Bandit") ***Used to determine humanity gain or loss***
//				3: Primary gun - "Random", "Unarmed", "Classname", Array
//				6: Backpack - "Random", "Classname", "none" or Array
//				7: Gearset - 0,1,2, or "Random"
//				8: Mission variable from line 5 (_mission)
};
[[
	[(_position select 0) - 10, (_position select 1) + 10, 0],
	[(_position select 0) + 10, (_position select 1) - 10, 0],
	[(_position select 0) + 10, (_position select 1) + 10, 0],
	[(_position select 0) - 10, (_position select 1) - 10, 0]
],"M2StaticMG","easy",_aiType,_aiType,"Random","Random","Random",_mission] call WAI_SpawnStatic;

// Heli Paradrop Example
// Parameters:	0: Paradrop position
//				1: Trigger radius
//				2: Vehicle classname
//				3: Direction of approach for the helicopter. Options: "North","South","East","West"
//				4: Random distance from the mission the helicopter should start. [min distance, max distance].
//				5: Fly in height of the helicopter. Be careful that the height is not too low or the AI might die when they hit the ground
//				6: Time in seconds between each deployed paratrooper. Higher number means paradropped AI will be more spread apart. Time of 0 means they all jump out rapidly.
//				7: Distance from the mission the helicopter should start dropping paratroopers
//				8: Amount of paratroopers
//				9: Unit Skill ("easy","medium","hard","extreme" or "random")
//				10: Primary gun - "Random", "Unarmed", "Classname", Array
//				11: Launcher options: ("AT", "AA", "classname", or "" for no launcher)
//				12: Backpack - "Random", "Classname", "none" or Array
//				13: Skin ("Hero","bandit","random", or "classname")
//				14: Gearset - 0,1,2, or "Random"
//				15: AI Type ("bandit" or "Hero") ***Used to determine humanity gain or loss***
//				16: Heli stay and fight after troop deployment? (true or false)
//				17: Mission variable from line 5 (_mission)

[_position,400,"UH60M_EP1_DZE","East",[3000,4000],150,1.0,200,10,"Random","Random","AT","Random",_aiType,"Random",_aiType,false,_mission] spawn WAI_HeliPara;

// Spawn Mission Vehicle Example
// Parameters:	0: Classname or Array from config.sqf
//				1: Position
//				2: Mission variable
//				3: Fixed vehicle position? If false the mission will pick a random position for the vehicle
//				4: Optional direction. If no number provided the mission will select a random direction

["MV22_DZ",[(_position select 0) - 20.5,(_position select 1) - 5.2,0], _mission,true,-82.5] call WAI_PublishVeh; // with declared vehicle class, optional fixed position, and optional direction
[cargo_trucks,_position,_mission] call WAI_PublishVeh; // with vehicle array, random position, and random direction
local _vehicle = [cargo_trucks,_position,_mission] call WAI_PublishVeh; // Same as above but saved to variable if necessary

// This example is for spawning a DZE armed vehicle and then loading ammo into the turrets and gear.
local _vehicle = [WAI_ArmedVeh ,[(_position select 0) - 20.5, (_position select 1) - 5],_mission,true, 0] call WAI_PublishVeh;
[_vehicle,(typeOf _vehicle),2] call WAI_LoadAmmo;

// Array of options to send to WAI_MissionMonitor.
[
	_mission, // Mission Variable - This is a number.
	_position, // Position of mission
	_difficulty, // Difficulty as defined above
	_name, // Name of Mission
	_localName, // localized marker text. Does not have to be localized.
	_aiType, // "Bandit" or "Hero"
	_markerIndex,
	_posIndex,
	_claimPlayer,
	true, // show mission marker?
	true, // make minefields available for this mission
	["crate"], // Completion type: ["crate"], ["kill"], or ["assassinate", _unitGroup], : crate - you have to get within 20 meters of the crate and kill at least the number of ai defined by variable WAI_KillPercent in config.sqf. kill = you have to kill all of the AI. assassinate - you have to kill a special ai (see Mayor's Mansion mission).
	_messages
] spawn WAI_MissionMonitor;