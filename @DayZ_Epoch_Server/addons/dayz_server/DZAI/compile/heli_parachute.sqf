private ["_helicopter","_vehPos","_unitGroup"];
_helicopter 	= 	_this select 0;

if (_helicopter getVariable ["heli_disabled",false]) exitWith
{
	false
};

_helicopter setVariable ["heli_disabled",true];
{
	_helicopter removeAllEventHandlers _x
} count ["HandleDamage","GetOut","Killed"];

_unitGroup 	= 	_helicopter getVariable "unitGroup";
[_unitGroup,_helicopter] call DZAI_respawnAIVehicle;
_vehPos 	= 	ASLtoATL getPosASL _helicopter;

if (!surfaceIsWater _vehPos) then
{
	private ["_unitsAlive","_trigger","_weapongrade","_units","_waypointCount"];
	_weapongrade 	= 	_unitGroup getVariable ["weapongrade",1];
	_units 			= 	units _unitGroup;

	if (((_vehPos select 2) > 60) or {(0.40 call DZAI_chance)}) then
	{
		{
			if (alive _x) then
			{
				_health 	= 	_x getVariable ["unithealth",[]];

				if ((_health select 1) > 0) then
				{
					_health set [1,0];		// Если у ИИ есть повреждение ноги, вылечим его.
					_health set [2,false];	
					_x setHit["legs",0];
				};
				_x action ["eject",_helicopter];
				unassignVehicle _x;
			}
			else
			{
				0 	= 	[_x,_weapongrade] spawn DZAI_addLoot;
			};
		} forEach _units;
		
		_unitsAlive 	= 
		{
			alive _x
		} count _units;

		if (_unitsAlive > 0) then
		{
			for "_i" from ((count (waypoints _unitGroup)) - 1) to 0 step -1 do {
				deleteWaypoint [_unitGroup,_i];
			};
	
			0 	= 	[_unitGroup,_vehPos,75] spawn DZAI_BIN_taskPatrol;
			
			_unitGroup allowFleeing 0;

			// Создаем триггер
			_trigger = createTrigger ["EmptyDetector",_vehPos];
			_trigger setTriggerArea [600, 600, 0, false];
			_trigger setTriggerActivation ["ANY", "PRESENT", true];
			_trigger setTriggerTimeout [5, 5, 5, true];
			_trigger setTriggerText (format ["Heli AI Parachute %1",mapGridPosition _helicopter]);
			_trigger setTriggerStatements ["{isPlayer _x} count thisList > 0;","","0 = [thisTrigger] spawn fnc_despawnBandits;"];

			// Устанавливаем переменные
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
			_unitGroup setVariable ["groupSize",_unitsAlive];
			_unitGroup setBehaviour "AWARE";
		};
	}
	else
	{
		_unitGroup setVariable ["unitType","aircrashed"];
		{
			_x action ["eject",_helicopter];
			_nul 	= 	[_x,_x] call DZAI_unitDeath;
			0 		= 	[_x,_weapongrade] spawn DZAI_addLoot;
		} forEach _units;
		_unitGroup setVariable ["GroupSize",-1];
	};
}
else
{
	_unitGroup setVariable ["GroupSize",-1];
};

if (DZAI_debugLevel > 0) then
{
	diag_log format ["[DZAI]: [heli_parachute.sqf]: [ОТЛАДКА]: Вертолет ИИ: %1 эвакуирован на: %2.",typeOf _helicopter,mapGridPosition _helicopter];
};

true