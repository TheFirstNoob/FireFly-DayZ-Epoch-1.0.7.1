/*
	ВНИМАНИЕ: Объекты живых игроков удаляются в Arma вскоре после срабатывания onPlayerDisconnected.
	потому что DayZ использует disabledAI=1 https://community.bistudio.com/wiki/Description.ext#disabledAI
	
	Ссылки на объект игрока после этой точки будут возвращать objNull, поэтому эта функция
	и server_playerSync должны быть быстрыми, иначе игрок не сохранится.
*/
private ["_playerObj","_playerUID","_playerPos","_playerName","_characterID","_inCombat","_Sepsis"];

_playerUID = _this select 0;
_playerName = _this select 1;
_playerObj = nil;

// Ищем всех игроков которые смотрят на объект котрый совпадает с вашим UID
// Если игрок только что умер, то новый Юнит будет отреспавнен и найден (respawnDelay = 0 в description.ext)
{
	if ((getPlayerUID _x) == _playerUID) exitWith
	{
		_playerObj 	= 	_x;
		_playerPos 	= 	getPosATL _playerObj;
	};
} count playableUnits;

// Если playerObj не в playableUnits тогда выйдем из Дисконнект системы.
if (isNil "_playerObj") exitWith
{
	diag_log format["[СЕРВЕР]: [server_onPlayerDisconnect.sqf]: [ВЫХОД]: Игрок не в playableUnits. %1", _this];
};

// Живой игрок рядом с Дебаг-Зоной. Игрок скорее всего скоро Возродиться.
if (_playerPos distance respawn_west_original < 1500) exitWith
{
	diag_log format["[СЕРВЕР]: [server_onPlayerDisconnect.sqf]: [ВЫХОД]: Игрок рядом с respawn_west. Это нормально после смерти игрока. %1", _this];

	if (!isNull _playerObj) then
	{
		_playerObj call sched_co_deleteVehicle;
	};
};

_characterID 	= 	_playerObj getVariable["characterID", "?"];
_inCombat 		= 	_playerObj getVariable ["inCombat",false];
_Sepsis 		= 	_playerObj getVariable["USEC_Sepsis",false];

// Логин процедура не синхронизирована
if (_playerUID in dayz_ghostPlayers) exitWith
{
	// Обратим внимание что игрок жив (смотрим dayz_ghostPlayers ниже)
	diag_log format["[СЕРВЕР]: [server_onPlayerDisconnect.sqf]: [ОШИБКА]: Невозможно Синхронизировать игрока: [%1,%2]. Все еще в процессе авторизации загрузки.",_playerName,_playerUID]; 

	// Удалим объект
	if (!isNull _playerObj) then
	{ 
		_playerObj call sched_co_deleteVehicle;
	};
};

// Убедимся что мы знаем ID объекта перед тем как попытся синхронизировать информацию с Базой Данных
if (_characterID != "?") then
{
	// Если игрок имел Сепсис до выхода, то выдадим его заново при Авторизации.
	if (_Sepsis) then
	{
		_playerObj setVariable["USEC_infected",true,true];
	};
	
	// Если player object живой, тогда синхронизируем игрока и уберем тело, и если Призрак включен, то добавим player id в массив
	if (alive _playerObj) then
	{
		// ВЫСОКИЙ ПРИОРИТЕТ. Синхронизация должна быть завершена быстрее чем player object isNull
		[_playerObj,nil,nil,nil,_inCombat] call server_playerSync;
		
		/*
			Низкий приоритет кода ниже когда
			_playerObj уже не нужен и может быть Null.
		*/
		
		// РЕЖИМ БОЯ
		if (_inCombat) then
		{
			// Переместим setVariables к server_playerSync поскольку они в Высоком приоритете.			
			// Сообщения низкого приоритета. Player object не нужен.
			diag_log format["[СЕРВЕР]: [server_onPlayerDisconnect.sqf]: [ВЫХОД В БОЮ]: Игрок %1(%3) на локации: %2",_playerName,_playerPos,_playerUID];
			[nil, nil, rTitleText, format["ВЫХОД В БОЮ: Игрок %1(%3) на локации: %2",_playerName, mapGridPosition _playerPos], "PLAIN"] call RE;
		};
		
		if (dayz_enableGhosting) then
		{
			if (!(_playerUID in dayz_ghostPlayers)) then
			{ 
				dayz_ghostPlayers set [count dayz_ghostPlayers, _playerUID];
				dayz_activePlayers set [count dayz_activePlayers, [_playerUID,diag_ticktime]];
			};
		};
	}
	else
	{
		// Закончим в server_playerSync выше если игрок живой
		{
			[_x,"gear"] call server_updateObject
		} count (nearestObjects [[_playerObj] call FNC_GetPos,DayZ_GearedObjects,10]);
	};
	
	[_playerUID,_characterID,3,_playerName,(_playerPos call fa_coor2str)] call dayz_recordLogin;
};

missionNamespace setVariable [_playerUID,nil];

if (alive _playerObj) then
{
	_playerObj call sched_co_deleteVehicle;
};