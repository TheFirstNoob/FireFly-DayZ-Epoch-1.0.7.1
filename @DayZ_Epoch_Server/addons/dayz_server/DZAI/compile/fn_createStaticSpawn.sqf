private ["_spawnMarker","_minAI","_addAI","_positionArray","_equipType","_numGroups","_patrolDist","_onActStatements","_trigger","_abort"];
_spawnMarker 	= 	_this select 0;

if ((getMarkerColor _spawnMarker) == "") exitWith
{
	diag_log format ["[DZAI]: [fn_createStaticSpawn.sqf]: [ОШИБКА]: Статичная позиция создания %1 не существует!",_spawnMarker];
};

if ((markerAlpha _spawnMarker) > 0) then
{
	_spawnMarker setMarkerAlpha 0
};

_abort 	= 	true;
if ((count _this) > 1) then
{
	_minAI 	= 	(_this select 1) select 0;
	_addAI 	= 	(_this select 1) select 1;

	if ((_minAI + _addAI) > 0) then
	{
		_abort 	= 	false;
	};
}
else
{
	_minAI 	= 	1;
	_addAI 	= 	1;
};

if (_abort) exitWith
{
	diag_log format ["[DZAI]: [fn_createStaticSpawn.sqf]: [ОШИБКА]: Кол-во ИИ стало НОЛЬ для позиции: %1. Зона создания была не выбрана. (%2)",_spawnMarker,__FILE__];
	
	objNull
};

_positionArray 	= 	if ((count _this) > 2) then
					{
						_this select 2
					}
					else
					{
						[]
					};
_equipType 		= 	if ((count _this) > 3) then
					{
						_this select 3
					}
					else
					{
						1
					};
_numGroups 		= 	if ((count _this) > 4) then
					{
						_this select 4
					}
					else
					{
						1
					};
_patrolDist 	= 	(getMarkerSize _spawnMarker) select 0;

if !(_equipType in [0,1,2,3]) then {_equipType = 1};

_onActStatements 	= 	format ["_nul = [%1,%2,%3,thisTrigger,%4,%5,%6] call DZAI_spawnBandits_init;",_minAI,_addAI,_patrolDist,_positionArray,_equipType,_numGroups];
_trigger 			= 	createTrigger ["EmptyDetector", getMarkerPos(_spawnMarker)];
_trigger setTriggerArea [600, 600, 0, false];
_trigger setTriggerActivation ["ANY", "PRESENT", true];
_trigger setTriggerTimeout [10, 10, 10, true];
_trigger setTriggerText _spawnMarker;
_trigger setTriggerStatements ["{isPlayer _x} count thisList > 0;",_onActStatements,""];

deleteMarker _spawnMarker;

_trigger