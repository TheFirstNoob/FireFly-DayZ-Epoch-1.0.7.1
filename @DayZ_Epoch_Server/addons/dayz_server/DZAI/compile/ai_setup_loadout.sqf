private ["_unit","_weapongrade","_weapons","_weapon","_magazine","_backpacks","_gadgetsArray","_backpack","_gadget","_inventory"];
_unit 			= 	_this select 0;
_weapongrade 	= 	_this select 1;

if (_unit getVariable ["loadoutDone",false]) exitWith
{
	diag_log format ["[DZAI]: [ai_setup_loadout.sqf]: [ОШИБКА]: ИИ уже выдан лут! (%1)",__FILE__];
};

if !(_weapongrade in DZAI_weaponGradesAll) then
{
	_weapongradeInvalid = _weapongrade;
	_weapongrade = DZAI_weaponGrades call BIS_fnc_selectRandom2;
	diag_log format ["[DZAI]: [ai_setup_loadout.sqf]: [ОШИБКА]: Указан неверный класс weapongrade: %1. Создаем новый класс weapongrade: %2. (%3)",_weapongradeInvalid,_weapongrade,__FILE__];
};

if ((count (weapons _unit)) > 0) then
{
	removeAllWeapons _unit;
	{_unit removeWeapon _x} count ["ItemMap","ItemGPS","ItemCompass","ItemRadio","ItemWatch"];
};

_weapons 	= 	missionNamespace getVariable ["DZAI_Rifles"+str(_weapongrade),DZAI_Rifles1+DZAI_Rifles2+DZAI_Rifles3];

if ((_weapongrade == 0) && {(0.25 call DZAI_chance)}) then
{
	_weapons 	= 	missionNamespace getVariable ("DZAI_Pistols" + str(floor(random 2)));
};

_backpacks 	= 	missionNamespace getVariable ["DZAI_Backpacks"+str(_weapongrade),DZAI_Backpacks1+DZAI_Backpacks2+DZAI_Backpacks3];

// Выбираем оружие и рюкзак
_weapon 	= 	_weapons call BIS_fnc_selectRandom2;
_backpack 	= 	_backpacks call BIS_fnc_selectRandom2;

// Добавляем оружие, патроны и рюкзак
_magazine 	= 	getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines") select 0;
_unit addMagazine _magazine;
_unit addWeapon _weapon;
_unit selectWeapon _weapon;
_unit addBackpack _backpack;

if ((getNumber (configFile >> "CfgWeapons" >> _weapon >> "type")) == 2) then
{
	_unit setVariable ["CanGivePistol",false]
};

if ((getNumber (configFile >> "CfgMagazines" >> _magazine >> "count")) < 8) then
{
	_unit addMagazine _magazine
};

_gadgetsArray 	= 	if (_weapongrade > 1) then
					{
						DZAI_gadgets1
					}
					else
					{
						DZAI_gadgets0
					};

for "_i" from 0 to ((count _gadgetsArray) - 1) do {
	if (((_gadgetsArray select _i) select 1) call DZAI_chance) then
	{
		_gadget 	= 	((_gadgetsArray select _i) select 0);
		_unit addWeapon _gadget;
	};
};

// Если ИИ выбран как weapongrade 2 или 3 и не был выдан ПНВ, тогда выдадим временное ПНВ которое удалится после смерти ИИ.
if (DZAI_tempNVGs) then
{
	if (!(_unit hasWeapon "NVGoggles") && {(_weapongrade > 0)} && {(daytime < 6 || daytime > 20)}) then {
		_nvg 	= 	_unit call DZAI_addTempNVG;

		if (DZAI_debugLevel > 1) then
		{
			diag_log "[DZAI]: [ai_setup_loadout.sqf]: [РАСШИРЕННАЯ ОТЛАДКА]: Выдаем временное ПНВ для ИИ.";
		};
	};
};

_unit setVariable ["loadoutDone",true];
_unit setVariable ["loadout",[[_weapon],[_magazine]]];

if (DZAI_debugLevel > 1) then
{
	diag_log format ["[DZAI]: [ai_setup_loadout.sqf]: [РАСШИРЕННАЯ ОТЛАДКА]: Создан лут для ИИ %1 (weapongrade: %2): [%3,%4,%5].",_unit,_weapongrade,_weapon,_magazine,_backpack];
};

true