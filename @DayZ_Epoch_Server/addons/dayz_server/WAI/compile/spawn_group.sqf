local _position 	= 	_this select 0;
local _pos_x 		= 	_position select 0;
local _pos_y 		= 	_position select 1;
local _pos_z 		= 	_position select 2;
local _unitnumber 	= 	_this select 1;
local _skill 		= 	_this select 2;
local _gun 			= 	_this select 3;
local _launcher 	= 	_this select 4;
local _backpack 	= 	_this select 5;
local _skin 		= 	_this select 6;
local _gear 		= 	_this select 7;
local _aitype 		= 	_this select 8;
local _mission 		= 	_this select 9;
local _gain 		= 	nil;
local _unit 		= 	objNull;
local _weapon 		= 	"";
local _unarmed 		= 	false;
local _pack 		= 	_backpack;

if (typeName _aitype == "ARRAY") then
{
	_gain 		= 	_aitype select 1;
	_aitype 	= 	_aitype select 0;
};

local _hero		= 	_aitype == "Hero";
local _bandit 	= 	_aitype == "Bandit";

local _unitGroup 	= 	[createGroup EAST, createGroup RESISTANCE] select _hero;
((WAI_MissionData select _mission) select 1) set [count ((WAI_MissionData select _mission) select 1), _unitGroup];

_unitGroup setVariable ["Respawn",[_position,_unitnumber,_skill,_gun,_launcher,_backpack,_skin,_gear,_aitype,_mission]];

if (_pos_z == 0) then
{
	if (floor(random 2) == 1) then
	{ 
		_pos_x 	= 	_pos_x - (15 + random(10));
	}
	else
	{
		_pos_x 	= 	_pos_x + (15 + random(10));
	};			

	if (floor(random 2) == 1) then
	{ 
		_pos_y 	= 	_pos_y - (15 + random(10));
	}
	else
	{
		_pos_y 	= 	_pos_y + (15 + random(10));
	};
};

for "_x" from 1 to _unitnumber do {
	local _aiskin 	= 	call {
		if (typeName _skin == "ARRAY") then
		{
			_skin call BIS_fnc_selectRandom;
		}
		else
		{
			if (_skin == "Hero") 	exitWith {WAI_HeroSkin call BIS_fnc_selectRandom;};
			if (_skin == "Bandit") 	exitWith {WAI_BanditSkin call BIS_fnc_selectRandom;};
			if (_skin == "Random") 	exitWith {WAI_AllSkin call BIS_fnc_selectRandom;};
			_skin;
		};
	};

	if (typeName _aiskin == "ARRAY") then
	{
		_aiskin 	= 	_aiskin call BIS_fnc_selectRandom;
	};

	_unit 	= 	_unitGroup createUnit [_aiskin,_position,[],0,"NONE"];

	removeAllWeapons _unit;
	removeAllItems _unit;

	call {
		if (typeName _gun == "ARRAY") then
		{
			_weapon 	= 	_gun call BIS_fnc_selectRandom;
		}
		else
		{
			if (_gun == "random") 	exitWith {_weapon 	= 	WAI_RandomWeapon call BIS_fnc_selectRandom;};
			if (_gun == "unarmed") 	exitWith {_unarmed 	= 	true;};
			_weapon = _gun;
		};
	};

	if (!_unarmed) then
	{
		if (typeName _weapon == "ARRAY") then
		{
			_weapon 	= 	_weapon call BIS_fnc_selectRandom;
		};

		if !(isClass (configFile >> "CfgWeapons" >> _weapon)) then
		{
			diag_log text format ["[WAI]: [spawn_group.sqf]: [ОШИБКА]: КлассНейм оружия (%1) неверен!",_weapon];
			_weapon = "M4A1_DZ";
		};

		local _magazine 	= 	_weapon call WAI_FindAmmo;
		local _mags 		= 	(round (random((WAI_AIMags select 1) - (WAI_AIMags select 0))) + (WAI_AIMags select 0));

		for "_i" from 1 to _mags do {
			_unit addMagazine _magazine;
		};

		_unit addWeapon _weapon;
		_unit selectWeapon _weapon;

		if (_hero) then
		{
			if (random 1 <= WAI_HeroDogtagChance) then
			{
				_unit addMagazine "ItemDogTagHero";
			};
		};

		if (_bandit) then
		{
			if (random 1 <= WAI_BanditDogtagChance) then
			{
				_unit addMagazine "ItemDogTagBandit";
			};
		};

		local _aigear 	= 	call {
			if (typeName _gear == "SCALAR") then
			{
				if (_gear == 0) exitWith {WAI_Gear0;};
				if (_gear == 1) exitWith {WAI_Gear1;};
				if (_gear == 2) exitWith {WAI_Gear2;};
				[];
			}
			else
			{
				if (_gear == "random") exitWith
				{
					WAI_GearRandom call BIS_fnc_selectRandom;
				};
				[];
			};
		};

		if (count _aigear > 0) then
		{
			for "_i" from 1 to (_aigear select 0) do {
				_unit addMagazine (WAI_Food call BIS_fnc_selectRandom);
			};

			for "_i" from 1 to (_aigear select 1) do {
				_unit addMagazine (WAI_Drink call BIS_fnc_selectRandom);
			};

			for "_i" from 1 to (_aigear select 2) do {
				_unit addMagazine (WAI_Medical call BIS_fnc_selectRandom);
			};

			local _tools 	= 	[];
			local _i 		= 	0;

			while {_i < (_aigear select 3)} do {
				local _tool 	= 	WAI_ToolsAll call BIS_fnc_selectRandom;

				if !(_tool in _tools) then
				{
					_unit addWeapon _tool;
					_tools set [count _tools, _tool];
					_i 	= 	_i + 1;
				};
			};

			if (random 1 <= (_aigear select 4)) then
			{
				_unit addMagazine "ItemDocument";
			};
		};
	};

	if (surfaceIsWater _position) then
	{
		_unit setPosASL _position;
	}
	else
	{
		_unit setPosATL _position;
	};

	[_unit] joinSilent _unitGroup;

	if (_hero) then
	{
		_unit setVariable ["Hero",true,false];
		_unit setVariable ["humanity", WAI_RemoveHumanity];
	};

	if (_bandit) then
	{
		_unit setVariable ["Bandit",true,false];
		_unit setVariable ["humanity", WAI_AddHumanity];
	};

	if (!isNil "_gain") then
	{
		_unit setVariable ["humanity", _gain];
	};

	call {
		if (typeName _backpack == "ARRAY") then
		{
			_pack 	= 	_backpack call BIS_fnc_selectRandom;
		}
		else
		{
			if (_backpack == "random") 	exitWith {_pack 	= 	WAI_PacksAll call BIS_fnc_selectRandom;};
			if (_backpack == "none") 	exitWith {_pack 	= 	"";};
		};
	};
	
	if (_pack != "") then
	{
		_unit addBackpack _pack;
	};

	if (sunOrMoon != 1 && {!("NVGoggles" in (weapons _unit))} && {!("NVGoggles_DZE" in (weapons _unit))}) then {
		_unit addWeapon "NVGoggles_DZE";
	};
	
	local _aicskill 	= 	call {
		if (_skill == "easy") 		exitWith {WAI_SkillEasy;};
		if (_skill == "medium") 	exitWith {WAI_SkillMedium;};
		if (_skill == "hard") 		exitWith {WAI_SkillHard;};
		if (_skill == "extreme") 	exitWith {WAI_SkillExtreme;};
		WAI_SkillRandom call BIS_fnc_selectRandom;
	};
	
	{
		_unit setSkill [(_x select 0),(_x select 1)]
	} count _aicskill;

	_unit addEventHandler ["Killed",{[_this select 0, _this select 1] call WAI_Onkill;}];

	if (!_unarmed) then
	{
		WAI_MissionData select _mission set [0, (((WAI_MissionData select _mission) select 0) + 1)];
	};

	_unit setVariable ["mission" + dayz_serverKey, _mission];
};

if (_launcher != "" && WAI_UseLaunchers) then
{
	_launcher 	= 	call {
		if (_launcher == "AT") exitWith {WAI_LaunchersAT call BIS_fnc_selectRandom;};
		if (_launcher == "AA") exitWith {WAI_LaunchersAA call BIS_fnc_selectRandom;};
		_launcher;
	};

	local _rocket = _launcher call WAI_FindAmmo;
	_unit addMagazine _rocket;
	_unit addMagazine _rocket;
	_unit addWeapon _launcher;
};

_unitGroup selectLeader ((units _unitGroup) select 0);
_unitGroup allowFleeing 0;

if (_hero) then
{
	_unitGroup setCombatMode WAI_HeroCombatmode;
	_unitGroup setBehaviour WAI_HeroBehaviour;
}
else
{
	_unitGroup setCombatMode WAI_BanditCombatMode;
	_unitGroup setBehaviour WAI_BanditBehaviour;
};

if !(_skill == "Patrol") then
{
	_unitGroup setFormation "ECH LEFT";
	[_unitGroup,[_pos_x,_pos_y,_pos_z],_skill] call WAI_SetWaypoints;
};


if (WAI_DebugMode) then
{
	diag_log format ["[WAI]: [spawn_group.sqf]: [ОТЛАДКА]: Создана группа из %1 ИИ (%3) на %2",_unitnumber,_position,_aitype];
};

_unitGroup