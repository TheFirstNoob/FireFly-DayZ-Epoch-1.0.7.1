private ["_dir","_IslandMap","_pos","_randomKey","_findIndex","_characterID","_playerObj","_spawnSelection","_inventory","_playerID","_dummy","_worldspace","_state","_doLoop","_key","_primary","_medical","_stats","_humanity","_randomSpot","_position","_distance","_fractures","_score","_findSpot","_mkr","_j","_isIsland","_w","_clientID","_lastInstance"];
_characterID 		= 	_this select 0;
_playerObj 			= 	_this select 1;
_spawnSelection 	= 	_this select 3;
_inventory 			= 	_this select 4;
_playerID 			= 	getPlayerUID _playerObj;

#include "\z\addons\dayz_server\compile\server_toggle_debug.hpp"

if (isNull _playerObj) exitWith
{
	diag_log ("[СЕРВЕР]: [server_playerSetup.sqf]: [ИНИЦИАЛИЗАЦИЯ]: Выход, Игрок object является Нуль: " + str(_playerObj));
};

if (_playerID == "") then
{
	_playerID 	= 	getPlayerUID _playerObj;
};

if (_playerID == "") exitWith
{
	diag_log ("[СЕРВЕР]: [server_playerSetup.sqf]: [ИНИЦИАЛИЗАЦИЯ]: Выход, нет ID игрока: " + str(_playerObj));
};

_dummy 	= 	getPlayerUID _playerObj;

if (_playerID != _dummy) then
{
	diag_log format["[СЕРВЕР]: [server_playerSetup.sqf]: [ОТКЛАДКА]: _playerID не совпадает с UID! _playerID: %1",_playerID];
	_playerID 	= 	_dummy;
};

_worldspace 	= 	[];
_state 			= 	[];

// Попытка соединиться
_doLoop 	= 	0;
while {_doLoop < 5} do {
	_key 		= 	format["CHILD:102:%1:",_characterID];
	_primary 	= 	_key call server_hiveReadWrite;

	if (count _primary > 0) then
	{
		if ((_primary select 0) != "ERROR") then
		{
			_doLoop 	= 	9;
		};
	};
	_doLoop 	= 	_doLoop + 1;
};

if (isNull _playerObj || !isPlayer _playerObj) exitWith {
	diag_log ("[СЕРВЕР]: [server_playerSetup.sqf]: [ИНИЦИАЛИЗАЦИЯ]: Выход, Игрок object является Нуль: " + str(_playerObj));
};

_medical 		= 	_primary select 1;
_stats 			= 	_primary select 2;
_worldspace 	= 	_primary select 4;
_humanity 		= 	_primary select 5;
_lastInstance 	= 	_primary select 6;
_randomSpot 	= 	false;
_state 			= 	[["",""],_primary select 3 select 0] select (count _primary >= 4);
_dir 			= 	0;

if (count _worldspace > 0) then
{
	_dir 		= 	_worldspace select 0;
	_position 	= 	_worldspace select 1;

	if (count _position < 3) exitWith
	{
		_randomSpot 	= 	true;
	};

	_distance 	= 	respawn_west_original distance _position;
	if (_distance < 2000) then
	{
		_randomSpot 	= 	true;
	};

	_distance 	= 	[0,0,0] distance _position;

	if (_distance < 500) then
	{
		_randomSpot 	= 	true;
	};

	if (_lastInstance != dayZ_instance) then
	{
		_randomSpot 	= 	true;
	};
}
else
{
	_randomSpot 	= 	true;
};

// Установим медицинские значения
if (count _medical > 0) then
{
	_playerObj setVariable ["USEC_isDead",(_medical select 0),true];
	_playerObj setVariable ["NORRN_unconscious",(_medical select 1),true];
	_playerObj setVariable ["USEC_infected",(_medical select 2),true];
	_playerObj setVariable ["USEC_injured",(_medical select 3),true];
	_playerObj setVariable ["USEC_inPain",(_medical select 4),true];
	_playerObj setVariable ["USEC_isCardiac",(_medical select 5),true];
	_playerObj setVariable ["USEC_lowBlood",(_medical select 6),true];
	_playerObj setVariable ["USEC_BloodQty",(_medical select 7),true];

	// Добавим открытые раны
	{
		_playerObj setVariable ["hit_"+_x,true,true];
	} forEach (_medical select 8);

	// Добавим переломы
	_fractures 	= 	_medical select 9;
	_playerObj setVariable ["hit_legs",(_fractures select 0),true];
	_playerObj setVariable ["hit_hands",(_fractures select 1),true];
	
	_playerObj setVariable ["unconsciousTime",(_medical select 10),true];
	_playerObj setVariable ["messing",if (count _medical >= 14) then {(_medical select 13)} else {[0,0,0]},true];
	_playerObj setVariable ["blood_testdone",if (count _medical >= 15) then {(_medical select 14)} else {false},true];

	if (count _medical > 12 && {typeName (_medical select 11) == "STRING"}) then
	{
		_playerObj setVariable ["blood_type",(_medical select 11),true];
		_playerObj setVariable ["rh_factor",(_medical select 12),true];
	}
	else
	{
		_playerObj call player_bloodCalc;
		diag_log [ "[СЕРВЕР]: [server_playerSetup.sqf]: blood_type,rh_factor=",_playerObj getVariable ["blood_type", "?"],_playerObj getVariable ["rh_factor", "?"]];
	};
}
else
{
	// Сбросим открытые раны
    {
        _playerObj setVariable["hit_"+_x,false,true];
    } forEach USEC_typeOfWounds;

	// Сбросим переломы
	_playerObj setVariable ["hit_legs",0,true];
	_playerObj setVariable ["hit_hands",0,true];
	_playerObj setVariable ["USEC_injured",false,true];
	_playerObj setVariable ["USEC_inPain",false,true];
	_playerObj call player_bloodCalc;
	_playerObj setVariable ["messing",[0,0,0],true];
	_playerObj setVariable ["blood_testdone",false,true];
};

if (count _stats > 0) then
{
	// Регистрируем статистику
	_playerObj setVariable ["zombieKills",(_stats select 0),true];
	_playerObj setVariable ["headShots",(_stats select 1),true];
	_playerObj setVariable ["humanKills",(_stats select 2),true];
	_playerObj setVariable ["banditKills",(_stats select 3),true];

	// Убийства
	_playerObj setVariable ["ConfirmedHumanKills",(_stats select 2),true];
	_playerObj setVariable ["ConfirmedBanditKills",(_stats select 3),true];

	_playerObj addScore (_stats select 1);

	// Сохраняем счет
	_score 	= 	score _playerObj;
	_playerObj addScore ((_stats select 0) - _score);

	missionNamespace setVariable [_playerID,[_humanity,(_stats select 0),(_stats select 1),(_stats select 2),(_stats select 3)]];
}
else
{
	// Регистрируем статистику
	_playerObj setVariable ["zombieKills",0,true];
	_playerObj setVariable ["humanKills",0,true];
	_playerObj setVariable ["banditKills",0,true];
	_playerObj setVariable ["headShots",0,true];

	// Убийства
	_playerObj setVariable ["ConfirmedHumanKills",0,true];
	_playerObj setVariable ["ConfirmedBanditKills",0,true];

	missionNamespace setVariable [_playerID,[_humanity,0,0,0,0]];
};

if (_randomSpot) then
{
	if (!isDedicated) then
	{
		endLoadingScreen;
	};

	_IslandMap 	= 	(toLower worldName in ["caribou","cmr_ovaron","dayznogova","dingor","dzhg","fallujah","fapovo","fdf_isle1_a","isladuala","lingor","mbg_celle2","namalsk","napf","oring","panthera2","ruegen","sara","sauerland","smd_sahrani_a2","tasmania2010","tavi","taviana","trinity","utes"]);
	_findSpot 	= 	true;
	_mkr 		= 	[];
	_position 	= 	[0,0,0];
	_j 			= 	0;

	while {_findSpot && _j <= 100} do {
		if (_spawnSelection == 9) then
		{
			if (dayz_spawnselection == 1) then
			{
				_mkr 	= 	getMarkerPos ("spawn" + str(floor(random 6)));
			}
			else
			{
				_mkr 	= 	getMarkerPos ("spawn" + str(floor(random actualSpawnMarkerCount)));
			};
		}
		else
		{
			_mkr 	= 	getMarkerPos ("spawn" + str(_spawnSelection));
		};

		_position 	= 	([_mkr,0,spawnArea,10,0,2,spawnShoremode] call BIS_fnc_findSafePos);

		if ((count _position >= 2) && {(_position distance _mkr < spawnArea)}) then
		{
			_position set [2, 0];

			if (((ATLtoASL _position) select 2 > 2.5) && {({alive _x} count (_position nearEntities ["CAManBase",150]) == 0)}) then
			{
				_pos 		= 	+(_position);
				_isIsland 	= 	false;
				_w 			= 	0;

				while {_w != 809} do {
					_pos 	= 	[((_pos select 0) - _w),((_pos select 1) + _w),(_pos select 2)];

					if ((surfaceisWater _pos) && !_IslandMap) exitWith
					{
						_isIsland 	= 	true;
					};
					_w 	= 	((_w + 17) % 811);
				};

				if (!_isIsland) then
				{
					_findSpot 	= 	false
				};
			};
		};
		_j 	= 	_j + 1;
	};

	if (_findSpot && !_IslandMap) exitWith
	{
		diag_log format["[СЕРВЕР]: [server_playerSetup.sqf]: [ИНИЦИАЛИЗАЦИЯ]: %1: ОШИБКА, невозможно найти удобную точку спавна для игрока. Зона: %2",__FILE__, _mkr];
	};

	_worldspace = [_dir,_position];
	_state 	= 	["","reset"];
};

// Запишем позицию игрока локально для сервера
_playerObj setVariable ["characterID",_characterID,true];
_playerObj setVariable ["humanity",_humanity,true];
_playerObj setVariable ["lastPos",_position];

_clientID 	= 	owner _playerObj;
_randomKey 	= 	[];

for "_i" from 0 to 12 do {
	_randomKey set [_i, (ceil(random 128)) + 256]; 	// Латинский Extended-A characters не фильтруются в publicvariableval.txt
};

_randomKey 	= 	toString _randomKey;
_findIndex 	= 	dayz_serverPUIDArray find _playerID;

if (_findIndex > -1) then
{
	dayz_serverClientKeys set [_findIndex, [_clientID,_randomKey]];
}
else
{
	dayz_serverPUIDArray set [(count dayz_serverPUIDArray), _playerID];
	dayz_serverClientKeys set [(count dayz_serverClientKeys), [_clientID,_randomKey]];
};

// Синхронизируем погоду для JIP игрока
_clientID publicVariableClient "PVDZE_SetWeather";

PVCDZ_plr_Login2 	= 	[_worldspace,_state,_randomKey];
_clientID publicVariableClient "PVCDZ_plr_Login2";

if (dayz_townGenerator) then
{
	_clientID publicVariableClient "PVCDZ_plr_plantSpawner";
};

// Запишем стартовое время
_playerObj setVariable ["lastTime",diag_ticktime];

// Установим server-side переменную инвентаря чтобы мониторить инвентарь игрока
if (count _inventory > 2) then
{
	_playerObj setVariable["ServerMagArray",_inventory select 1, false];
};

// Запишем Вход/Выход игрока
[_playerID,_characterID,1,(_playerObj call fa_plr2str),((_worldspace select 1) call fa_coor2str)] call dayz_recordLogin;

PVDZ_plr_Login1 	= 	null;
PVDZ_plr_Login2 	= 	null;