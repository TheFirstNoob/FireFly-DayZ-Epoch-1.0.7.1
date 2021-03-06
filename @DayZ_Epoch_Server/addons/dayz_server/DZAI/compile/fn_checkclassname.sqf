private ["_classname","_checkType","_result","_config","_banString","_check","_configIndex"];
_classname 		= 	_this select 0;
_checkType 		= 	_this select 1;
_result 		= 	false;
_configIndex 	= 	-1;
_checkType 		= 	(toLower _checkType);
_startTime 		= 	diag_tickTime;

call {
	if (_checkType == "weapon") exitWith
	{
		if (_classname in (DZAI_checkedClassnames select 0)) then
		{
			_result 	= 	true;
		}
		else
		{
			if (!(_classname in (DZAI_invalidClassnames select 0))) then
			{
				_config 		= 	"CfgWeapons";
				_banString 		= 	"bin\config.bin/CfgWeapons/FakeWeapon";
				_configIndex 	= 	0;
			};
		};
	};

	if (_checkType == "magazine") exitWith
	{
		if (_classname in (DZAI_checkedClassnames select 1)) then
		{
			_result 	= 	true;
		}
		else
		{
			if (!(_classname in (DZAI_invalidClassnames select 0))) then
			{
				_config 		= 	"CfgMagazines";
				_banString 		= 	"bin\config.bin/CfgMagazines/FakeMagazine";
				_configIndex 	= 	1;
			};
		};
	};

	if (_checkType == "vehicle") exitWith
	{
		if (_classname in (DZAI_checkedClassnames select 2)) then
		{
			_result 	= 	true;
		}
		else
		{
			if (!(_classname in (DZAI_invalidClassnames select 0))) then
			{
				_config 		= 	"CfgVehicles";
				_banString 		= 	"bin\config.bin/CfgVehicles/Banned";
				_configIndex 	= 	2;
			};
		};
	};

	diag_log format ["[DZAI]: [fn_checkclassname.sqf]: [ОШИБКА]: Попытка проверить %1 как недопустимый тип имени класса! Предоставленный тип: %2. Допустимые типы: Оружие, Магазин, Техника.",_checkType];
};

if (_configIndex > -1) then
{
	_check 				= 	(str(inheritsFrom (configFile >> _config >> _classname)));
	_classnameArray 	= 	[];

	if ((_check != "") && {(_check != _banString)} && {(getNumber (configFile >> _config >> _classname >> "scope")) != 0}) then
	{
		_classnameArray 	= 	DZAI_checkedClassnames;
		_result 			= 	true;
	}
	else
	{
		_classnameArray = DZAI_invalidClassnames;

		diag_log format ["[DZAI]: [fn_checkclassname.sqf]: [ОШИБКА]: %1 является неправильным типом %2 класснейма!",_classname,_checkType];
	};
	(_classnameArray select _configIndex) set [(count (_classnameArray select _configIndex)),_classname]; // Теперь известно, что имя класса является действительным или недействительным, нет необходимости проверять его снова
};

_result