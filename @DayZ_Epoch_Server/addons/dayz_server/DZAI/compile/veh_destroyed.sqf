private ["_vehicle","_unitGroup","_unitsAlive"];
_vehicle 	= 	_this select 0;

if (_vehicle getVariable ["veh_disabled",false]) exitWith {};
_vehicle setVariable ["veh_disabled",true];
_unitGroup 	= 	_vehicle getVariable "unitGroup";
{
	_vehicle removeAllEventHandlers _x
} count ["HandleDamage","Killed"];
[_unitGroup,_vehicle] call DZAI_respawnAIVehicle;
_unitsAlive 	= 
{
	alive _x
} count (units _unitGroup);

if (_unitsAlive > 0) then
{
	for "_i" from ((count (waypoints _unitGroup)) - 1) to 0 step -1 do {
		deleteWaypoint [_unitGroup,_i];
	};
	
	_vehPos 	= 	ASLToATL getPosASL _vehicle;
	0 			= 	[_unitGroup,_vehPos,100] spawn DZAI_BIN_taskPatrol;
	
	// Создаем триггер
	_trigger 	= 	createTrigger ["EmptyDetector",_vehPos];
	_trigger setTriggerArea [600, 600, 0, false];
	_trigger setTriggerActivation ["ANY", "PRESENT", true];
	_trigger setTriggerTimeout [5, 5, 5, true];
	_trigger setTriggerText (format ["Abandoned AI Vehicle %1",mapGridPosition _vehicle]);
	_trigger setTriggerStatements ["{isPlayer _x} count thisList > 0;","","0 = [thisTrigger] spawn fnc_despawnBandits;"];

	//Установите необходимые переменные триггера и начнем удаление
	_trigger setVariable ["isCleaning",false];
	_trigger setVariable ["GroupArray",[_unitGroup]];
	_trigger setVariable ["equipType",DZAI_vehUnitLevel];
	_trigger setVariable ["maxUnits",[_unitsAlive,0]];
	_trigger setVariable ["respawn",false];
	_trigger setVariable ["permadelete",true];
	[_trigger,"DZAI_staticTriggerArray"] call DZAI_updateSpawnCount;
	0 	= 	[_trigger] spawn fnc_despawnBandits;
	_unitGroup setVariable ["unitType","static"];
	_unitGroup setVariable ["trigger",_trigger];
	_unitGroup setVariable ["groupSize",_unitsAlive];
	_unitGroup setBehaviour "AWARE";
	
	{
		unassignVehicle _x;
	} forEach (assignedCargo _vehicle);
}
else
{
	_unitGroup setVariable ["GroupSize",-1];
};

if (DZAI_debugLevel > 0) then
{
	diag_log format ["[DZAI]: [veh_destroyed.sqf]: [ОТЛАДКА]: Патруль ИИ на Технике был уничтожен на позиции: %1",mapGridPosition _vehicle];
};
