local _mission 		= 	count WAI_MissionData -1;
local _aiType 		= 	_this select 0; // "Bandit" или "Hero"
local _position 	= 	[30] call WAI_FindPos;
local _name 		= 	"Заброшенный базар";
local _startTime 	= 	diag_tickTime;
local _difficulty 	= 	"Random";
local _localName 	= 	"STR_CL_ABANDONEDTRADER_TITLE";

diag_log format["[WAI]: [abadoned_trader.sqf]: %1 %2 миссия началась на %3.",_difficulty,_name,_position];

local _messages 	=
[
	 "STR_CL_ABANDONEDTRADER_ANNOUNCE"
	,"STR_CL_ABANDONEDTRADER_WIN"
	,"STR_CL_ABANDONEDTRADER_FAIL"
];

local _markers 	= 	[1,1,1,1];
_markers set [0, [_position, "WAI" + str(_mission), "ColorBlue", "", "ELLIPSE", "Solid", [500,500], [], 0]];
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

	diag_log format["[WAI]: [abadoned_trader.sqf]: %1 %2 Время вышло.",_difficulty,_name];
};


// Ящик с лутом
local _loot 	= 	if (_aiType == "Hero") then
					{
						Loot_AbandonedTrader select 0;
					}
					else
					{
						Loot_AbandonedTrader select 1;
					};
[
	[
		[_loot,WAI_CrateMd,[.3,0]]
	],_position,_mission
] call WAI_SpawnCrate;

// Постройки
[
	[
		["Land_Misc_Garb_Heap_EP1",[-0.9,4.2,-0.01]],
		["Land_Misc_Garb_Heap_EP1",[-18,1.5,-0.01]],
		["Land_Shed_W03_EP1",[-4,4.7,-0.01]],
		["Land_Shed_M01_EP1",[-10,5,-0.01]],
		["Land_Market_shelter_EP1",[-10,-0.4,-0.01]],
		["Land_Market_stalls_02_EP1",[-10,-5.8,-0.01],-2.5],
		["Land_Market_stalls_01_EP1",[11,5,-0.01],-0.34],
		["Land_Market_stalls_02_EP1",[10,-5.8,-0.01]],
		["Land_Market_shelter_EP1",[10,-0.4,-0.01],2.32],
		["Land_transport_crates_EP1",[22,2,-0.01],-43.88],
		["Fort_Crate_wood",[18,-1,-0.01]],
		["UralWreck",[27,-3,-0.01],-67.9033],
		["Land_Canister_EP1",[18,1.4,-0.01],28.73],
		["MAP_ground_garbage_square5",[13.6,-2,-0.01]],
		["MAP_ground_garbage_square5",[-16,-2,-0.01]],
		["MAP_ground_garbage_long",[-0.4,-2,-0.01]],
		["MAP_garbage_misc",[-8,-2,-0.01]]
	],_position,_mission
] call WAI_SpawnObjects;

// Пешие ИИ
[_position,(ceil random 2),_difficulty,"random","","random",_aiType,"random",_aiType,_mission] call WAI_SpawnGroup;
[_position,(ceil random 7),_difficulty,"random","","random",_aiType,"random",_aiType,_mission] call WAI_SpawnGroup;

// Турели
if (random 1 <= WAI_ChanceForRandomStaticGun) then
{
	[
		[
			[(_position select 0) + 0.1, (_position select 1) + 20, 0],
			[(_position select 0) + 0.1, (_position select 1) - 20, 0]
		],"M2StaticMG",_difficulty,_aiType,_aiType,"random","random","random",_mission
	] call WAI_SpawnStatic;
};


// Добавим прожектора если время вечер/ночь
if ((daytime > 18) || (daytime < 6)) then
{
	[
		[
			[(_position select 0) + 5, (_position select 1) + 30, 0],
			[(_position select 0) + 10, (_position select 1) - 30, 0]
		],"SearchLight_RUS",_difficulty,_aiType,_aiType,"random","random","random",_mission
	] call WAI_SpawnStatic;
};

// Патрульная техника
if (random 1 <= WAI_ChanceForRandomLandPatrol) then
{
	[
		 [(_position select 0) + 100, _position select 1, 0],[(_position select 0) + 100, _position select 1, 0],50,2,"HMMWV_Armored_DZE","random",_aiType,_aiType,_mission
	] call WAI_VehPatrol;
};

// Минное поле
local _minefield 	= 	if (random 1 <= WAI_ChanceForRandomMinefield) then
						{
							true
						}
						else
						{
							false
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
	_minefield, 		// Минное поле доступно на этой миссии? (смотри выше)
	["crate"], 			// Формат завершения: ["crate"], ["kill"], или ["assassinate", _unitGroup],
	_messages
] spawn WAI_MissionMonitor;