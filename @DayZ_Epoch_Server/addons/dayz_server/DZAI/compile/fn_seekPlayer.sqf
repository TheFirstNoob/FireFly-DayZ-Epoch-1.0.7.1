private ["_unitGroup","_spawnPos","_waypoint","_patrolDist","_statement","_targetPlayer","_triggerPos","_leader","_nearbyUnits","_radioSpeech","_radioText","_ableToChase"];
_unitGroup 		= 	_this select 0;
_spawnPos 		= 	_this select 1;
_patrolDist 	= 	_this select 2;
_targetPlayer 	= 	_this select 3;
_triggerPos 	= 	_this select 4;

_unitGroup setVariable ["seekActive",true];

_waypoint 	= 	[_unitGroup,0];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointCompletionRadius 35;
_waypoint setWaypointTimeout [10,12,15];
_waypoint setWPPos (ASLtoATL getPosASL _targetPlayer);
_unitGroup setCurrentWaypoint _waypoint;

if (DZAI_radioMsgs) then
{
	_leader 	= 	(leader _unitGroup);
	if (((_unitGroup getVariable ["GroupSize",0]) > 1) && {!(_leader getVariable ["unconscious",false])}) then
	{
		_nearbyUnits 	= 	(getPosASL _targetPlayer) nearEntities [["LandVehicle","CAManBase"],DZAI_TransmitRange];
		{
			if (isPlayer _x) then
			{
				if ((driver (vehicle _x)) hasWeapon "ItemRadio") then
				{
					_radioSpeech =
					[
						"[RADIO]: Вы слышите радио помехи, исходящие от вашего радио...",
						"[RADIO]: Ваше радио ловит сигнал..."
					] call BIS_fnc_selectRandom2;
					[_x,_radioSpeech] call DZAI_radioSend;
				}
				else
				{
					if (0.10 call DZAI_chance) then
					{
						_radioSpeech =
						[
							"Вы чувствуете, что как будто за вами наблюдают...",
							"Вы чувствуете, что за вами следят...",
							"Вы чувствуете, что что-то не так..."
						] call BIS_fnc_selectRandom2;
						[_x,_radioSpeech] call DZAI_radioSend;
					};
				};
			}
		} count _nearbyUnits;
	};
};

uiSleep 10;

// Начало фазы охоты
_ableToChase = true;
while {_ableToChase && {alive _targetPlayer} && {((_targetPlayer distance _triggerPos) < DZAI_SeekRange)}} do {
	if !(_unitGroup getVariable ["inPursuit",false]) then
	{
		_leader 	= 	(leader _unitGroup);

		if (((getWPPos [_unitGroup,0]) distance _targetPlayer) > 25) then
		{
			_waypoint setWPPos (ASLtoATL getPosASL _targetPlayer);
			_unitGroup setCurrentWaypoint _waypoint;
			_unitGroup setFormDir ([_leader,_targetPlayer] call BIS_fnc_dirTo);
			_unitGroup reveal [_targetPlayer,4];
		};

		(units _unitGroup) doTarget _targetPlayer;
		(units _unitGroup) doFire _targetPlayer;

		if (DZAI_radioMsgs) then
		{
			// Предупредим игрока о присутствии ИИ, если у него есть радио.
			if (((_unitGroup getVariable ["GroupSize",0]) > 1) && {!(_leader getVariable ["unconscious",false])} && {(_leader distance _targetPlayer) < 150}) then
			{
				_nearbyUnits 	= 	(ASLtoATL getPosASL _targetPlayer) nearEntities [["LandVehicle","CAManBase"],DZAI_TransmitRange];
				{
					if ((isPlayer _x)&&{((driver (vehicle _x)) hasWeapon "ItemRadio")}) then
					{
						_index 	= 	(floor (random 10));
						_radioSpeech = call {
							if (_index == 0) exitWith {format ["[RADIO]: %1 (Лидер ИИ): Ищите %2. Это наша цель!",(name _leader),(name _targetPlayer)]};
							if (_index == 1) exitWith {format ["[RADIO]: %1 (Лидер ИИ): Цель %2. Найдите его!",(name _leader),(getText (configFile >> "CfgVehicles" >> (typeOf _targetPlayer) >> "displayName"))]};
							if (_index == 2) exitWith {format ["[RADIO]: %1 (Лидер ИИ): Цель на расстоянии %2 метров. Убейте его!",(name _leader),round (_leader distance _targetPlayer)]};
							if (_index > 2) exitWith {"[RADIO]: ??? (Кто-то): .... (радиошумы)"};
							"[RADIO] ??? : ..."
						};
						[_x,_radioSpeech] call DZAI_radioSend;
					};
				} count _nearbyUnits;
			};
		};
	};

	uiSleep 19.5;

	_ableToChase 	= 	((!isNull _unitGroup) && {(_unitGroup getVariable ["GroupSize",0]) > 0});

	if (_ableToChase && {isNull _targetPlayer}) then
	{
		if (DZAI_debugLevel > 1) then
		{
			diag_log format ["[DZAI]: [fn_seekPlayer.sqf]: [РАСШИРЕННАЯ ОТЛАДКА]: Группа ИИ: %1 начала попытку найти новую цель для охоты.",_unitGroup];
		};

		_nearUnits 	= 	(leader _unitGroup) nearEntities ["CAManBase",200];
		{
			if (isPlayer _x) exitWith
			{
				_targetPlayer 	= 	_x;
				_unitGroup reveal [_targetPlayer,4];
			};
		} forEach _nearUnits;
	};
	uiSleep 0.5;
};

if ((isNull _unitGroup) || {(_unitGroup getVariable ["GroupSize",0]) < 1}) exitWith {};

if (DZAI_debugLevel > 0) then
{
	diag_log format ["[DZAI]: [fn_seekPlayer.sqf]: [ОТЛАДКА]: Группа ИИ %1 закончила Охоту и приступила к Патрулированию.",_unitGroup];
};

// Начало фазы патрулирования
_waypoint setWaypointStatements ["true","if ((random 1) < 0.50) then { group this setCurrentWaypoint [(group this), (floor (random (count (waypoints (group this)))))];};"];
0 	= 	[_unitGroup,_triggerPos,_patrolDist] spawn DZAI_BIN_taskPatrol;
_unitGroup setVariable ["seekActive",nil];

uiSleep 5;

if (DZAI_radioMsgs) then
{
	_leader 	= 	(leader _unitGroup);

	if (((_unitGroup getVariable ["GroupSize",0]) > 1) && {!(_leader getVariable ["unconscious",false])} && {!(isNull _targetPlayer)}) then
	{
		_nearbyUnits 	= 	(getPosASL _targetPlayer) nearEntities [["LandVehicle","CAManBase"],DZAI_TransmitRange];
		{
			if ((isPlayer _x) && {((driver (vehicle _x)) hasWeapon "ItemRadio")}) then
			{
				_radioText 		= 	if (alive _targetPlayer) then
									{
										"[RADIO]: %1 (Лидер ИИ): Цель потеряна. Уходим отсюда."
									}
									else
									{
										"[RADIO]: %1 (Лидер ИИ): Цель убита."
									};
				_radioSpeech 	= 	format [_radioText,(name _leader)];
				[_x,_radioSpeech] call DZAI_radioSend;
			};
		} count _nearbyUnits;
	};
};

true