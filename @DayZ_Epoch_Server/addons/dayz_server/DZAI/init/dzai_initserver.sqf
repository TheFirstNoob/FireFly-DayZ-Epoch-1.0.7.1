private ["_startTime","_directoryAsArray","_worldname","_allUnits"];

if (!isServer || !isNil "DZAI_isActive") exitWith {};
DZAI_isActive 		= 	true;
_startTime 			= 	diag_tickTime;
_directoryAsArray 	= 	toArray __FILE__;
_directoryAsArray resize ((count _directoryAsArray) - 25);
DZAI_directory 		= 	toString _directoryAsArray;

if (isNil "_this") then
{
	_this = []
};
if ((count _this) > 0) then
{
	if ("readoverridefile" in _this) then
	{
		DZAI_overrideEnabled 	= 	true
	}
	else
	{
		DZAI_overrideEnabled 	= 	nil
	};

	if ("enabledebugmarkers" in _this) then
	{
		DZAI_debugMarkersEnabled 	= 	true
	}
	else
	{
		DZAI_debugMarkersEnabled 	= 	nil
	};
}
else
{
	DZAI_overrideEnabled 		= 	nil;
	DZAI_debugMarkersEnabled 	= 	nil;
};

#include "DZAI_version.txt"
diag_log format ["[DZAI]: [dzai_initserver.sqf]: Инициализация: %1 Версия: %2 Используется путь: %3.",DZAI_TYPE,DZAI_VERSION,DZAI_directory];

call compile preprocessFileLineNumbers format ["%1\init\dzai_config.sqf",DZAI_directory];

if ((!isNil "DZAI_overrideEnabled") && {DZAI_overrideEnabled}) then
{
	call compile preprocessFileLineNumbers format ["%1\DZAI_settings_override.sqf",DZAI_directory]
};

call compile preprocessFileLineNumbers format ["%1\init\dzai_functions.sqf",DZAI_directory];

_allUnits = +allUnits;
if (({(side _x) == west} count _allUnits) == 0) then
{
	createCenter west
};

if (({(side _x) == east} count _allUnits) == 0) then
{
	createCenter east
};
east setFriend [west, 0];        
west setFriend [east, 0];

if (isNil "DZAI_modName") then
{
	DZAI_modName 	= 	"Default"
};

if (isNil "DZAI_modVersion") then
{
	DZAI_modVersion 	= 	toLower (getText (configFile >> "CfgMods" >> "DayZ" >> "version"))
};

if (isNil "DZAI_modAutoDetect") then
{
	DZAI_modAutoDetect 	= 	true
};

if (DZAI_modAutoDetect) then
{
	private ["_modVariant"];
	_modVariant 	= 	toLower (getText (configFile >> "CfgMods" >> "DayZ" >> "dir"));

	if (DZAI_debugLevel > 0) then
	{
		diag_log format ["[DZAI]: [dzai_initserver.sqf]: [ОТЛАДКА]: Обнаружен мод: %1.",_modVariant];
	};

	DZAI_modName 	= 	call {
		if (_modVariant == "@dayz_epoch") exitWith
		{
			"epoch"
		};

		if ((isClass (configFile >> "CfgWeapons" >> "ItemHatchet")) && {isClass (configFile >> "CfgWeapons" >> "ItemMatchbox")}) exitWith
		{
			"epoch"
		};
		""
	};
};

if (isNil "DZAI_maxHeliPatrols") then
{
	DZAI_maxHeliPatrols 	= 	0
};

if (isNil "DZAI_maxLandPatrols") then
{
	DZAI_maxLandPatrols 	= 	0
};

_centerPos = getMarkerPos 'center';
_markerSize = [7000, 7000];
_centerMarker = createMarker ["DZAI_centerMarker", _centerPos];
_centerMarker setMarkerShape "ELLIPSE";
_centerMarker setMarkerType "Empty";
_centerMarker setMarkerBrush "Solid";
_centerMarker setMarkerAlpha 0;

_worldname = (toLower worldName);
call {
	if (_worldname in ["chernarus","chernarus_winter"]) exitWith
	{
		_worldname 		= 	"chernarus";
		_centerPos 		= 	[7652.9634, 7870.8076];
		_markerSize 	= 	[5500, 5500];
	};

	if (_worldname == "napf") exitWith
	{
		_centerPos 		= 	[10725.096, 9339.918];
		_markerSize 	= 	[8500, 8500];
	};

	if ((_centerPos distance [0,0,0]) < 5) then
	{
		_centerPos = getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");
	};
};
_centerMarker setMarkerPos _centerPos;
_centerMarker setMarkerSize _markerSize;

if (_worldname in ["chernarus","chernarus_winter","napf"]) then
{
	if (DZAI_modAutoDetect) then {
		if (DZAI_modName == "epoch") then
		{
			call compile preprocessFileLineNumbers format ["%1\init\world_classname_configs\dayz_%2.sqf",DZAI_directory,DZAI_modName];
		}
		else
		{
			call compile preprocessFileLineNumbers format ["%1\init\world_classname_configs\default_classnames\%2.sqf",DZAI_directory,_worldname];
		};
	};
	[] execVM format ["%1\init\world_spawn_configs\world_%2.sqf",DZAI_directory,_worldname];
}
else
{
	if (DZAI_modAutoDetect) then
	{
		if (DZAI_modName == "epoch") then
		{
			call compile preprocessFileLineNumbers format ["%1\init\world_classname_configs\dayz_epoch_classnames.sqf",DZAI_directory];
		};
	};

	if (DZAI_staticAI) then
	{
		[] execVM format ["%1\scripts\setup_autoStaticSpawns.sqf",DZAI_directory];
	};
};

[] execVM format ['%1\scripts\DZAI_startup.sqf',DZAI_directory];

diag_log format ["[DZAI]: [dzai_initserver.sqf]: DZAI Параметры: Уровень Отладки: %1. Отладка Маркеров: %2. Карта: %3. Мод: %4 (Версия: %5). DZAI_dynamicWeaponList: %6. VerifyTables: %7.",DZAI_debugLevel,((!isNil "DZAI_debugMarkersEnabled") && {DZAI_debugMarkersEnabled}),_worldname,DZAI_modName,DZAI_modVersion,DZAI_dynamicWeaponList,DZAI_verifyTables];
diag_log format ["[DZAI]: [dzai_initserver.sqf]: ИИ Параметры спавна: Статичные: %1. Динамичные: %2. Случайно: %3. Воздушные: %4. Наземные: %5.",DZAI_staticAI,DZAI_dynAISpawns,(DZAI_maxRandomSpawns > 0),(DZAI_maxHeliPatrols>0),(DZAI_maxLandPatrols>0)];
diag_log format ["[DZAI]: [dzai_initserver.sqf]: ИИ Параметры: DZAI_findKiller: %1. DZAI_useHealthSystem: %2. DZAI_weaponNoise: %3. DZAI_zombieEnemy: %4.",DZAI_findKiller,DZAI_useHealthSystem,DZAI_weaponNoise,DZAI_zombieEnemy];
diag_log format ["[DZAI]: [dzai_initserver.sqf]: DZAI загрузка завершена за %1 секунд.",(diag_tickTime - _startTime)];
