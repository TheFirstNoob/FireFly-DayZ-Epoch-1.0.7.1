private ["_unit","_pistol","_pistols","_weapongrade","_magazine","_currentWeapon","_toolselect","_chance","_tool","_toolsArray","_loot"];
_unit 			= 	_this select 0;
_weapongrade 	= 	_this select 1;

if (DZAI_debugLevel > 1) then
{
	diag_log format["[DZAI]: [ai_generate_loot.sqf]: [РАСШИРЕННАЯ ОТЛАДКА]: ИИ убит игроком на %1. Создаю лут на основе weapongrade: %2.",mapGridPosition _unit,_weapongrade];
};

_loot 	= 	[];

if (_unit getVariable ["CanGivePistol",true]) then
{
	_pistols 	= 	missionNamespace getVariable ["DZAI_Pistols"+str(_weapongrade),DZAI_Pistols0+DZAI_Pistols1+DZAI_Pistols2+DZAI_Pistols3];
	_pistol 	= 	_pistols call BIS_fnc_selectRandom2;
	_magazine 	= 	getArray (configFile >> "CfgWeapons" >> _pistol >> "magazines") select 0;
	_unit addMagazine _magazine;	
	_unit addWeapon _pistol;

	if (DZAI_debugLevel > 1) then
	{
		_loot set [count _loot,_pistol];
		_loot set [count _loot,_magazine];
	};
};

// Очистим рюкзак от ванильного лута
clearMagazineCargoGlobal _unit;

if (DZAI_GuaranteedBandage) then
{
	_unit addMagazine "ItemBandage";
};

for "_i" from 1 to DZAI_invedibles do {
	if (DZAI_chanceEdibles call DZAI_chance) then
	{
		_invedible 	= 	DZAI_Edibles call BIS_fnc_selectRandom2;
		_unit addMagazine _invedible;

		if (DZAI_debugLevel > 1) then
		{
			_loot set [count _loot,_invedible];
		};
	};
};

for "_i" from 1 to DZAI_bpedibles do {
	if (DZAI_chanceEdibles call DZAI_chance) then
	{
		_bpedible 	= 	DZAI_Edibles call BIS_fnc_selectRandom2;
		(unitBackpack _unit) addMagazineCargoGlobal [_bpedible, 1];

		if (DZAI_debugLevel > 1) then
		{
			_loot set [count _loot,_bpedible];
		};
	};
};

for "_i" from 1 to DZAI_numMiscItemS do {
	if (DZAI_chanceMiscItemS call DZAI_chance) then
	{
		_miscItemS 	= 	DZAI_MiscItemS call BIS_fnc_selectRandom2;
		(unitBackpack _unit) addMagazineCargoGlobal [_miscItemS,1];

		if (DZAI_debugLevel > 1) then
		{
			_loot set [count _loot,_miscItemS];
		};
	};
};

if (_weapongrade > 0) then
{
	// Шанс добавить разные предметы (большие) в рюкзак - только если вместимость рюкзака больше 10
	if ((getNumber (configFile >> "CfgVehicles" >> (str (unitBackpack _unit)) >> "transportMaxMagazines")) > 10) then
	{
		for "_i" from 1 to DZAI_numMiscItemL do {
			if (DZAI_chanceMiscItemL call DZAI_chance) then
			{
				_miscItemL 	= 	DZAI_MiscItemL call BIS_fnc_selectRandom2;
				(unitBackpack _unit) addMagazineCargoGlobal [_miscItemL,1];

				if (DZAI_debugLevel > 1) then
				{
					_loot set [count _loot,_miscItemL];
				};
			};
		};
	};
	
	// Добавим медицину в Рюкзак
	for "_i" from 1 to DZAI_bpmedicals do {
		if (DZAI_chanceMedicals call DZAI_chance) then {
			_bpmedical = DZAI_Medicals2 call BIS_fnc_selectRandom2;
			(unitBackpack _unit) addMagazineCargoGlobal [_bpmedical, 1];
			if (DZAI_debugLevel > 1) then {_loot set [count _loot,_bpmedical];};
		};
	};

	// Добавим медицину в Инвентарь
	for "_i" from 1 to DZAI_invmedicals do {
		if (DZAI_chanceMedicals call DZAI_chance) then {
			_invmedical = DZAI_Medicals1 call BIS_fnc_selectRandom2;
			_unit addMagazine _invmedical;
			if (DZAI_debugLevel > 1) then {_loot set [count _loot,_invmedical];};
		};
	};
	
	// Epoch валюта (Слитками)
	if (DZAI_modName == "epoch") then
	{
		_barsAdded 	= 	0;
		{
			if (_barsAdded >= DZAI_metalBarNum) exitWith {};

			if (((_x select 1) call DZAI_chance) && {[(_x select 0),"magazine"] call DZAI_checkClassname}) then
			{
				_unit addMagazine (_x select 0);
				_barsAdded 	= 	_barsAdded + 1;

				if (DZAI_debugLevel > 1) then
				{
					_loot set [count _loot,(_x select 0)];
				};
			}
		} count DZAI_metalBars;
	};
};

// Добавим инструменты
_toolsArray 	= 	if (_weapongrade < 2) then
					{
						DZAI_tools0
					}
					else
					{
						DZAI_tools1
					};
{
	if (((_x select 1) call DZAI_chance) && {[(_x select 0),"weapon"] call DZAI_checkClassname}) then
	{
		_unit addWeapon (_x select 0);

		if (DZAI_debugLevel > 1) then
		{
			_loot set [count _loot,(_x select 0)];
		};
	}
} count _toolsArray;

if (DZAI_debugLevel > 1) then
{
	diag_log format ["[DZAI]: [ai_generate_loot.sqf]: [РАСШИРЕННАЯ ОТЛАДКА]: Создан лут для мертвого ИИ: %1",_loot];
};