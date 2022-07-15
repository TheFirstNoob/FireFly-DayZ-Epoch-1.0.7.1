private ["_isZSC","_exitReason","_clientKey","_backpacks","_charID","_clientID","_dir","_holder","_lockCode","_lockedClass","_magazines","_name","_obj","_objectID","_objectUID","_ownerID","_packedClass","_player","_playerUID","_pos","_status","_statusText","_type","_unlockedClass","_vector","_weapons","_message","_suppliedCode","_damage","_coins","_wealth"];
_player 	= 	_this select 0;
_obj 		= 	_this select 1;
_status 	= 	_this select 2;

_name 			= 	["Dead Player",name _player] select (alive _player);
_type 			= 	typeOf _obj;
_pos 			= 	getPosATL _obj;
_dir 			= 	direction _obj;
_vector 		= 	[vectorDir _obj, vectorUp _obj];
_charID 		= 	_obj getVariable ["CharacterID","0"];
_objectID 		= 	_obj getVariable ["ObjectID","0"];
_objectUID 		= 	_obj getVariable ["ObjectUID","0"];
_ownerID 		= 	_obj getVariable ["ownerPUID","0"];
_lockCode 		= 	_charID;
_suppliedCode 	= 	[_charID,_this select 3] select (count _this > 3);
_exitReason 	= 	"";

if (_status != 3 && {_status != 6}) then {_lockCode = _suppliedCode;};

// Игрок может быть Отключен или Убит дотого как сообщение будет отправлено. Отправим запрос Закрыть/Открыть/Запаковать/Сохранить в любом случае
if (isNull _player) then
{
	diag_log "[СЕРВЕР]: [server_handleSafeGear.sqf]: [ОШИБКА]: Запрос с Нуль _player объект";
};

_clientID 	= 	owner _player;
_playerUID 	= 	getPlayerUID _player;

_statusText = call {
	if (_status == 0) exitwith {"ОТКРЫТО"}; 						// Открытие safe/lockbox
	if (_status == 1) exitwith {"ЗАКРЫТО"}; 						// Закрытие safe/lockbox
	if (_status == 5) exitwith {"ОТКРЫТО"}; 						// Дверь открыта
	if (_status == 4) exitwith {_lockCode = _charID; "ЗАКРЫТО"}; 	// Дверь закрыта
	if (_status == 3) exitwith {"НЕУДАЧНАЯ попытка открыть"}; 		// Неудачное открытие двери safe/lockbox
	if (_status == 6) exitwith {"НЕУДАЧНАЯ попытка открыть"}; 		// Неудачное открытие двери
	if (_status == 2) exitwith {"ЗАПАКОВАНО"}; 						// Запаковать safe/lockbox
};

if (isNull _obj) exitWith
{
	diag_log format["[СЕРВЕР]: [server_handleSafeGear.sqf]: [ОШИБКА]: Запрос с Нуль Объектом. Игрок: %1 (%2). Статус: %3 Попытка не удалась.",_name,_playerUID,_statusText];

	if (_status < 3) then
	{
		dze_waiting 	= 	"fail";
		_clientID publicVariableClient "dze_waiting";
	};
};

if !(_type in DZE_DoorsLocked) then
{
	_clientKey 		= 	_this select 4;
	_exitReason 	= 	[_this,_statusText,(getPosATL _obj),_clientKey,_playerUID,_player] call server_verifySender;
};

if (_exitReason != "") exitWith
{
	diag_log _exitReason
};

call {
	_isZSC 	= 	false;

	if (Z_singleCurrency) then
	{
		_isZSC 	= 	_type in DZE_MoneyStorageClasses;
	};
	
	if (_status == 0) exitwith
	{
		_unlockedClass 	= 	getText (configFile >> "CfgVehicles" >> _type >> "unlockedClass");
		_weapons 		= 	_obj getVariable ["WeaponCargo",[]];
		_magazines 		= 	_obj getVariable ["MagazineCargo",[]];
		_backpacks 		= 	_obj getVariable ["BackpackCargo",[]];

		if (_isZSC && {_unlockedClass in DZE_MoneyStorageClasses}) then
		{
			_coins 	= 	_obj getVariable ["cashMoney",0];
		};

		_damage 	= 	damage _obj;

		// Создадим Новый Открытый сейф, вместо Старого Закрытого
		_holder 	= 	_unlockedClass createVehicle [0,0,0];
		_holder setVariable ["memDir",_dir,true];
		_holder setVectorDirAndUp _vector;
		_holder setPosATL _pos;
		_holder setVariable ["CharacterID",_charID,true];
		_holder setVariable ["ObjectID",_objectID];
		_holder setVariable ["ObjectUID",_objectUID];
		_holder setDamage _damage;
		_holder setVariable ["ownerPUID",_ownerID,true];

		if (_isZSC && {_unlockedClass in DZE_MoneyStorageClasses}) then
		{
			_holder setVariable ["cashMoney",_coins,true];
		};

		deleteVehicle _obj;

		[_weapons,_magazines,_backpacks,_holder] call fn_addCargo;
	};
	if (_status == 1) exitwith
	{
		_lockedClass 	= 	getText (configFile >> "CfgVehicles" >> _type >> "lockedClass");

		// Сохраним в Базу Данных (так же происходит если игрок в пределах 10м от server_playerSync и server_onPlayerDisconnect)
		[_obj,"gear"] call server_updateObject;
		_weapons 	= 	getWeaponCargo _obj;
		_magazines 	= 	getMagazineCargo _obj;
		_backpacks 	= 	getBackpackCargo _obj;

		if (_isZSC && {_lockedClass in DZE_MoneyStorageClasses}) then
		{
			_coins 	= 	_obj getVariable ["cashMoney",0];
		};
		_damage 	= 	damage _obj;

		// Создадим Новый Закрытый сейф, вместо Старого Открытого
		_holder = _lockedClass createVehicle [0,0,0];
		_holder setVariable ["memDir",_dir,true];
		_holder setVectorDirAndUp _vector;
		_holder setPosATL _pos;
		_holder setVariable ["CharacterID",_charID,true];
		_holder setVariable ["ObjectID",_objectID];
		_holder setVariable ["ObjectUID",_objectUID];
		_holder setDamage _damage;
		_holder setVariable ["ownerPUID",_ownerID,true];

		if (_isZSC && {_lockedClass in DZE_MoneyStorageClasses}) then
		{
			_holder setVariable ["cashMoney",_coins,true];
		};

		deleteVehicle _obj;

		// Отправим Local setVariable содержимое на новый закрытый сейф, чтобы легко получить доступ при открытии в следующий раз.
		// Не отправляйте большие массивы по Сети! Они нужны только серверу.
		_holder setVariable ["WeaponCargo",_weapons,false];
		_holder setVariable ["MagazineCargo",_magazines,false];
		_holder setVariable ["BackpackCargo",_backpacks,false];
	};
	if (_status == 2) exitwith
	{
		_packedClass 	= 	getText (configFile >> "CfgVehicles" >> _type >> "packedClass");

		if (_packedClass == "") exitWith
		{
			diag_log format["[СЕРВЕР]: [server_handleSafeGear.sqf]: [ОШИБКА]: Неверный тип объекта при паковании: %1",_type];
		};

		_weapons 	= 	getWeaponCargo _obj;
		_magazines 	= 	getMagazineCargo _obj;
		_backpacks 	= 	getBackpackCargo _obj;

		if (_isZSC) then
		{
			_coins 	= 	_obj getVariable ["cashMoney",0];
		};

		_holder 	= 	_packedClass createVehicle [0,0,0];
		deleteVehicle _obj;

		_holder setDir _dir;
		_holder setPosATL _pos;
		_holder addMagazineCargoGlobal [getText(configFile >> "CfgVehicles" >> _packedClass >> "seedItem"),1];
		[_weapons,_magazines,_backpacks,_holder] call fn_addCargo;

		if (_isZSC && {_coins > 0}) then
		{
			private "_displayName";

			_displayName 	= 	getText (configFile >> "CfgVehicles" >> _type >> "displayName");
			_wealth 		= 	_player getVariable [(["cashMoney","globalMoney"] select Z_persistentMoney),0];
			_player setVariable [(["cashMoney","globalMoney"] select Z_persistentMoney),_wealth + _coins,true];

			RemoteMessage = ["systemChat",["STR_CL_ZSC_PACK_WARNING",_displayName,[_coins] call BIS_fnc_numberText,CurrencyName]];
			(owner _player) publicVariableClient "RemoteMessage";
		};

		// Удалим Сейф из Базы Данных
		[_objectID,_objectUID,_obj] call server_deleteObjDirect;
	};
};

if (_status < 4) then
{
	_type = call {
		if (_type in ["VaultStorageLocked","VaultStorage","VaultStorage2Locked","VaultStorage2","TallSafe","TallSafeLocked"]) exitwith
		{
			if (_ownerID == _playerUID) then
			{
				_lockCode = format["%1 - Owner",_lockCode];
			};
			"Safe"
		};

		if (_type in ["LockboxStorage","LockboxStorageLocked","LockboxStorage2","LockboxStorage2Locked","LockboxStorageWinterLocked","LockboxStorageWinter2Locked","LockboxStorageWinter","LockboxStorageWinter2"]) exitwith
		{
			if (_ownerID == _playerUID) then
			{
				_lockCode 	= 	_charID call fnc_lockCode;
				_lockCode 	= 	format["%1 - Owner",_lockCode];
			}
			else
			{
				_lockCode 	= 	_charID call fnc_lockCode;
			};

			if (_status == 3) then
			{
				_suppliedCode 	= 	_suppliedCode call fnc_lockCode;
			};
			"LockBox"
		};
	};
};

if (_statusText == "НЕУДАЧНАЯ попытка открыть") then
{
	_message 	= 	format["[СЕРВЕР]: [server_handleSafeGear.sqf]: Игрок: %1 (UID: %2) %3 %4 с Кодом: %5 (Правильный: %8) @%6 %7, ObjectID: %8, ObjectUID: %9",_name,_playerUID,_statusText,_type,_suppliedCode,mapGridPosition _pos,_pos,_lockCode,_objectID,_objectUID];
}
else
{
	_message 	= 	format["[СЕРВЕР]: [server_handleSafeGear.sqf]: Игрок: %1 (UID: %2) %3 %4 с Кодом: %5 @%6 %7, ObjectID: %8, ObjectUID: %9",_name,_playerUID,_statusText,_type,_lockCode,mapGridPosition _pos,_pos,_objectID,_objectUID];
};

diag_log _message;

if (_status < 3) then
{
	dze_waiting 	= 	"success";
	_clientID publicVariableClient "dze_waiting";
};
