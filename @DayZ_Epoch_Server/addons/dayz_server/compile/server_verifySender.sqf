/*
	PVEH не предоставляет никакой информации об "отправителе" в A2, поэтому
	это необходимо для проверки того, что "отправитель" не был подделан.
	Это полезно для предотвращения и выявления читеров, которые пытаются массово удалить или создать объекты в Базе данных через PVS.
*/

local _params 		= 	_this select 0;
local _function 	= 	"Server_" + (_this select 1);
local _objPos 		= 	_this select 2;
local _clientKey 	= 	_this select 3;
local _playerUID 	= 	_this select 4;
local _player 		= 	_this select 5;
local _playerPos 	= 	[_player] call fnc_getPos;
local _index 		= 	dayz_serverPUIDArray find _playerUID;

local _exitReason = call {
	// Если Объект или Игрок является null дистанция вернет 9999+
	// Если Объект или Игрок был перемещен с помощью setPos на Клиенте, то позиция обновится через секунду на сервере
	// Вместо объекта можно использовать координаты
	if (_objPos distance _playerPos > (Z_VehicleDistance + 10)) exitwith
	{
		format["[СЕРВЕР]: [server_verifySender.sqf]: [БЕЗОПАСНОСТЬ]: %1 Ошибка: Верификация Не прошла. Игрок слишком далеко от Объекта. Дистанция: %2м/%3м лимит PV ARRAY: %4",_function,round (_objPos distance _playerPos),Z_VehicleDistance + 10,_params]
	};

	if (_index < 0) exitwith
	{
		format["[СЕРВЕР]: [server_verifySender.sqf]: [БЕЗОПАСНОСТЬ]: %1 Ошибка: PUID НЕ НАЙДЕН НА СЕРВЕРЕ! PV ARRAY: %2",_function,_params]
	};

	if (((dayz_serverClientKeys select _index) select 0 != owner _player) || ((dayz_serverClientKeys select _index) select 1 != _clientKey)) exitwith
	{
		format["[СЕРВЕР]: [server_verifySender.sqf]: [БЕЗОПАСНОСТЬ]: %1 Ошибка: КЛЮЧ ВЕРИФИКАЦИИ ИГРОКА НЕВЕРЕН ИЛИ НЕ РАСПОЗНАН! PV ARRAY: %2",_function,_params]
	};
	"";
};

_exitReason