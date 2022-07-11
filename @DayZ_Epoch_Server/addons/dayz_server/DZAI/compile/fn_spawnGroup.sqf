private ["_totalAI","_spawnPos","_unitGroup","_trigger","_attempts","_baseDist","_dummy","_weapongrade"];
if (!isServer) exitWith {};
	
_totalAI 		= 	_this select 0;
_spawnPos 		= 	_this select 2;
_trigger 		= 	_this select 3;
_weapongrade 	= 	_this select 4;
_pos 			= 	[];
_attempts 		= 	0;
_baseDist 		= 	25;

while {((count _pos) < 1) && {(_attempts < 3)}} do {
	_pos 	= 	_spawnPos findEmptyPosition [0.5,_baseDist,"Misc_cargo_cont_small_EP1"];

	if ((count _pos) > 1) then
	{
		_pos 	= 	_pos isFlatEmpty [0,0,0.75,5,0,false,objNull];
	};

	if ((count _pos) < 1) then
	{
		_baseDist 	= 	(_baseDist + 25);
		_attempts 	= 	(_attempts + 1);

		if (_attempts == 3) then
		{
			_pos 		= 	[_trigger,random (_trigger getVariable ["patrolDist",125]),random(360),0] call SHK_pos;
			_attempts 	= 	(_attempts + 1);
		};
	};
};
_pos set [2,0];

if (DZAI_debugLevel > 1) then
{
	diag_log format ["[DZAI]: [fn_spawnGroup.sqf]: [РАСШИРЕННАЯ ОТЛАДКА]: Найдено место создания в %3 метров дальше от позиции %1 после %2 попыток.",_pos,_attempts,(_pos distance _spawnPos)]
};

_unitGroup = if (isNull (_this select 1)) then {[] call DZAI_createGroup} else {_this select 1};
if (({isPlayer _x} count (_pos nearEntities ["CAManBase",100])) == 0) then
{
	_unitGroup setCombatMode "RED";	
}
else
{
	_unitGroup setCombatMode "BLUE";
	_nul 	= 	_unitGroup spawn {

		uiSleep 10;

		_this setCombatMode "RED";
	};
};

for "_i" from 1 to _totalAI do {
	private ["_type","_unit"];
	_type 	= 	DZAI_BanditTypes call BIS_fnc_selectRandom2;
	_unit 	= 	_unitGroup createUnit [_type, _pos, [], 0, "FORM"];
	_unit setPos _pos;
	[_unit] joinSilent _unitGroup;

	_unit setVariable ["bodyName",(name _unit)];
	_unit setVariable ["unithealth",[(DZAI_baseBlood + (random DZAI_bonusBlood)),0,false]];
	_unit setVariable ["unconscious",false];
	_unit addEventHandler [DZAI_healthType, DZAI_healthStatements];
	0 	= 	[_unit, _weapongrade] call DZAI_setupLoadout;
	0 	= 	[_unit, _weapongrade] call DZAI_setSkills;
	if (DZAI_weaponNoise) then {_unit addEventHandler ["Fired", {_this call DZAI_aiFired;}];};
	if (DZAI_debugLevel > 1) then {diag_log format["DZAI Extended Debug: Spawned AI Type %1 with weapongrade %2 for group %3 (fnc_createGroup).",_type,_weapongrade,_unitGroup];};
};

//Delete dummy if it exists, and clear group's "dummy" variable.
_dummy = _unitGroup getVariable "dummyUnit";
if (!isNil "_dummy") then {
	deleteVehicle _dummy;
	_unitGroup setVariable ["dummyUnit",nil];
	if (DZAI_debugLevel > 1) then {diag_log format["DZAI Extended Debug: Deleted 1 dummy AI unit for group %1. (fnc_createGroup)",_unitGroup];};
};

_unitGroup selectLeader ((units _unitGroup) select 0);
_unitGroup setVariable ["trigger",_trigger];
_unitGroup setVariable ["GroupSize",_totalAI];
_unitGroup setVariable ["weapongrade",_weapongrade];
if (isNull _trigger) then {_unitGroup setVariable ["spawnPos",_spawnPos]}; 	//If group was spawned directly by scripting instead of a trigger object, record spawn position instead of trigger position as anchoring point
//(DZAI_numAIUnits + _totalAI) call DZAI_updateUnitCount;
0 = [_unitGroup,_weapongrade] spawn DZAI_autoRearm_group;	//start group-level manager
_unitGroup setFormDir (random 360);

_unitGroup