private ["_helicopter","_trigger","_heliPos","_unitsAlive","_unitGroup","_waypointCount"];
_helicopter 	= 	_this select 0;

if (_helicopter getVariable ["heli_disabled",false]) exitWith {};

_helicopter setVariable ["heli_disabled",true];
{
	_helicopter removeAllEventHandlers _x
} count ["HandleDamage","GetOut","Killed"];

_unitGroup 	= 	_helicopter getVariable ["unitGroup",(group (_this select 2))];
[_unitGroup,_helicopter] call DZAI_respawnAIVehicle;

_unitsAlive =
{
	alive _x
} count (units _unitGroup);

if (_unitsAlive > 0) then {
	// Преобразуем десант в наземные ИИ
	{
		if (alive _x) then {
			_health = _x getVariable ["unithealth",[]];
			if ((_health select 1) > 0) then
			{
				_health set [1,0]; 	// Если ИИ сломал ногу, вылечим
				_health set [2,false];	
				_x setHit["legs",0];
			};
			unassignVehicle _x;
		};
	} count (units _unitGroup);

	for "_i" from ((count (waypoints _unitGroup)) - 1) to 0 step -1 do {
		deleteWaypoint [_unitGroup,_i];
	};

	_heliPos 	= 	ASLtoATL getPosASL _helicopter;
	0 			= 	[_unitGroup,_heliPos,75] spawn DZAI_BIN_taskPatrol;

	// Создадим триггер
	_trigger 	= 	createTrigger ["EmptyDetector",_heliPos];
	_trigger setTriggerArea [600, 600, 0, false];
	_trigger setTriggerActivation ["ANY", "PRESENT", true];
	_trigger setTriggerTimeout [5, 5, 5, true];
	_trigger setTriggerText (format ["HeliLandingArea_%1",mapGridPosition _helicopter]);
	_trigger setTriggerStatements ["{isPlayer _x} count thisList > 0;","","0 = [thisTrigger] spawn fnc_despawnBandits;"];

	// Установим переменные
	_trigger setVariable ["isCleaning",false];
	_trigger setVariable ["GroupArray",[_unitGroup]];
	_trigger setVariable ["equipType",DZAI_heliUnitLevel];
	_trigger setVariable ["maxUnits",[_unitsAlive,0]];
	_trigger setVariable ["respawn",false];
	_trigger setVariable ["permadelete",true];
	[_trigger,"DZAI_staticTriggerArray"] call DZAI_updateSpawnCount;
	0 	= 	[_trigger] spawn fnc_despawnBandits;

	_unitGroup setVariable ["unitType","static"];
	_unitGroup setVariable ["trigger",_trigger];
	_unitGroup setVariable ["GroupSize",_unitsAlive];
	_unitGroup setBehaviour "AWARE";
	_unitGroup allowFleeing 0;

	if (DZAI_debugLevel > 0) then
	{
		diag_log format ["[DZAI]: [heli_airlanding.sqf]: [ОТЛАДКА]: Вертолет ИИ %1 сел на позиции: %2.",typeOf _helicopter,mapGridPosition _helicopter];
	};
};
