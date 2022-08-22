private ["_playerID","_endMission","_0","_1","_timeleft","_doLoop","_key","_primary","_model","_inventory","_backpack","_survival","_CharacterCoins","_group","_playerCoins","_BankCoins","_hiveVer","_mags","_wpns","_bcpk","_config","_isInfected","_remaining","_playerObj","_playerName","_newPlayer","_isNew","_charID","_isHiveOk"];

#include "\z\addons\dayz_server\compile\server_toggle_debug.hpp"

_playerID 		= 	_this select 0;
_playerObj 		= 	_this select 1;
_playerName 	= 	name _playerObj;
if (_playerName == '__SERVER__' || _playerID == '' || local player) exitWith {};

// Отменим любую попытку Входа пока server_monitor не прекратит работу.
// Это обязательно потому что ВСЯ Техника должна быть отспавнена до того как Первый игрок появиться на карте.
// Иначе, Обработчики событий не будут созданы на всю технику на стороне Клиента.
if (isNil "sm_done") exitWith
{
	diag_log ("[СЕРВЕР]: [server_playerLogin.sqf]: Вход отменен. Сервер еще не готов принимать игроков." + str(_playerObj));
};

_inventory 			= 	[];
_backpack 			= 	[];
_survival 			= 	[0,0,0,0];
_model 				= 	"";
_isInfected 		= 	0;
_CharacterCoins 	= 	0;
_group 				= 	[];
_playerCoins 		= 	0;
_BankCoins 			= 	0;

if (_playerID == "") then
{
	_playerID 	= 	getPlayerUID _playerObj;
};

if ((_playerID == "") || (isNil "_playerID")) exitWith
{
	diag_log ("[СЕРВЕР]: [server_playerLogin.sqf]: [ОШИБКА]: Игрок [" + _playerName + "] не имеет ID для входа");
};

_endMission 	= 	false;
_timeleft 		= 	0;
{
	_0 			= 	_x select 0;
	_1 			= 	_x select 1;
	_timeleft 	= 	diag_ticktime - _1;

	if (_playerID == _0) then
	{
		if ((_timeleft > dayz_ghostTimer) || (_timeleft < 0)) then
		{
			dayz_ghostPlayers 	= 	dayz_ghostPlayers - [_0];
			dayz_activePlayers set [_forEachIndex, _0];
			dayz_activePlayers 	= 	dayz_activePlayers - [_0];
		}
		else
		{
			if (_playerID in dayz_died) then
			{
				dayz_died 			= 	dayz_died - [_playerID];
				dayz_ghostPlayers 	= 	dayz_ghostPlayers - [_0];
				dayz_activePlayers set [_forEachIndex, _0];
				dayz_activePlayers 	= 	dayz_activePlayers - [_0];
			}
			else
			{
				_endMission 	= 	true;
			};
		};
	};
} forEach dayz_activePlayers;

// Пробуем Авторизоваться
_doLoop 	= 	0;
while {_doLoop < 5} do {
	_key 		= 	format["CHILD:101:%1:%2:%3:",_playerID,dayZ_instance,_playerName];
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

if (isNull _playerObj || !isPlayer _playerObj) exitWith
{
	diag_log ("[СЕРВЕР]: [server_playerLogin.sqf]: [АВТОРИЗАЦИЯ]: Выходим, player object является Нуль: " + str(_playerObj));
};

if ((_primary select 0) == "ERROR") exitWith
{
    diag_log format ["[СЕРВЕР]: [server_playerLogin.sqf]: [АВТОРИЗАЦИЯ]: Выходим, ошибка загрузки _primary: %1 для игрока: %2 ",_primary,_playerID];
};

// Процесс запроса
_newPlayer 	= 	_primary select 1;
_isNew 		= 	count _primary < 10;
_charID 	= 	_primary select 2;
_hiveVer 	= 	0;

if (!_isNew) then
{
	_inventory 			= 	_primary select 4;
	_backpack 			= 	_primary select 5;
	_survival 			= 	_primary select 6;
	_CharacterCoins 	= 	_primary select 7;
	_model 				= 	_primary select 8;
	_group 				= 	_primary select 9;
	_playerCoins 		= 	_primary select 10;
	_BankCoins 			= 	_primary select 11;
	_hiveVer 			= 	_primary select 12;

	if !(_model in AllPlayers) then
	{
		_model 	= 	"Survivor2_DZ";
	};
}
else
{
	_isInfected 	= 	if (DZE_PlayerZed) then
						{
							_primary select 3
						}
						else
						{
							0
						};
	_model 			= 	_primary select 4;
	_group 			= 	_primary select 5;
	_playerCoins 	= 	_primary select 6;
	_BankCoins 		= 	_primary select 7;
	_hiveVer 		= 	_primary select 8;

	if (isNil "_model") then
	{
		_model 	= 	"Survivor2_DZ";
	}
	else
	{
		if (_model == "") then
		{
			_model = "Survivor2_DZ";
		};
	};
	
	// Запишем начальный инвентарь если игрок не зомби
	if (_isInfected != 1) then
	{
		_config 	= 	configFile >> "CfgSurvival" >> "Inventory" >> "Default";
		_mags 		= 	getArray (_config >> "magazines");
		_wpns 		= 	getArray (_config >> "weapons");
		_bcpk 		= 	getText (_config >> "backpack");

		if (!isNil "DefaultMagazines") then
		{
			_mags 	= 	DefaultMagazines;
		};

		if (!isNil "DefaultWeapons") then
		{
			_wpns 	= 	DefaultWeapons;
		};

		if (!isNil "DefaultBackpack") then
		{
			_bcpk 	= 	DefaultBackpack;
		};

		_key 	= 	str formatText["CHILD:203:%1:%2:%3:",_charID,[_wpns,_mags],[_bcpk,[],[]]];
		_key call server_hiveWrite;
	};
};

_isHiveOk 	= 	(_hiveVer >= dayz_hiveVersionNo);

if (_newPlayer) then
{
	_characterCoins = floor(random 35000);
};

PVCDZ_plr_Login 	= 	[_charID,_inventory,_backpack,_survival,_isNew,dayz_versionNo,_model,_isHiveOk,_newPlayer,_isInfected,_group,_CharacterCoins,_playerCoins,_BankCoins];
(owner _playerObj) publicVariableClient "PVCDZ_plr_Login";

// Заставим игрока ждать, пока таймер призрака не истечет.
if (_endMission) exitwith
{
	_remaining 	= 	dayz_ghostTimer - _timeleft;
	// Лог для GhostMode
	diag_log format["[СЕРВЕР]: [server_playerLogin.sqf]: [АВТОРИЗАЦИЯ]: Игрок: %1(UID:%2/CID%3). Статус: Вход отменен, GHOSTMODE. Времени осталось: %4",_playerName,_playerID,_charID,_remaining];

	PVCDZ_plr_Ghost 	= 	[_remaining];
	(owner _playerObj) publicVariableClient "PVCDZ_plr_Ghost";
};

// Синхронизируем срубленные деревья с JIP игроками
{
	_x setDamage 1
} count dayz_choppedTrees;


// Синхронизируем Групповую системус JIP игроком
if (count dayz_activeInvites > 0) then
{
	(owner _playerObj) publicVariableClient "dayz_activeInvites";
};

// Запишем Вход/Выход Игрока
[_playerID,_charID,2,(_playerObj call fa_plr2str),((getPosATL _playerObj) call fa_coor2str)] call dayz_recordLogin;

PVCDZ_plr_PlayerAccepted 	= 	[_playerName,diag_ticktime];
(owner _playerObj) publicVariableClient "PVCDZ_plr_PlayerAccepted";

if ((count DZE_ServerMarkerArray) > 0) then
{
	PVDZ_ServerMarkerSend 	= 	["JIP",DZE_ServerMarkerArray];
	(owner _playerObj) publicVariableClient "PVDZ_ServerMarkerSend";
};