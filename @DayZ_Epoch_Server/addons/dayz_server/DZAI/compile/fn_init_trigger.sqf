private["_trigger","_mode"];
_mode 		= 	_this select 0;
_trigger 	= 	_this select 1;

_trigger setVariable ["isCleaning",false];
_trigger setVariable ["GroupArray",(_this select 2)];

call {
	if (_mode == 0) exitWith {
		// Статичное создание ИИ
		_trigger setVariable ["patrolDist",(_this select 3)];
		_trigger setVariable ["equipType",(_this select 4)];
		_trigger setVariable ["locationArray",(_this select 5)];
		_trigger setVariable ["maxUnits",(_this select 6)];
		_trigger setVariable ["spawnChance",missionNamespace getVariable [format ["DZAI_spawnChance%1",(_this select 4)],1]];

		if (DZAI_debugLevel > 1) then
		{
			diag_log format["[DZAI]: [fn_init_trigger.sqf]: [РАСШИРЕННАЯ ОТЛАДКА]: Инициализация Статичных ИИ: %1. GroupArray: %2, PatrolDist: %3. equipType: %4. %LocationArray %5 позиций, MaxUnits: %6.",triggerText _trigger,(_this select 2),(_this select 3),(_this select 4),count (_this select 5),(_this select 6)];
		};
	};

	if (_mode == 1) exitWith {
		// Динамическое создание ИИ
		_location = createLocation ["Strategic",(getPosASL _trigger),600,600];
		_trigger setVariable ["triggerLocation",_location];

		if (DZAI_debugLevel > 1) then
		{
			diag_log format["[DZAI]: [fn_init_trigger.sqf]: [РАСШИРЕННАЯ ОТЛАДКА]: Инициализация Динамических ИИ: %1. GroupArray: %2.",triggerText _trigger,(_this select 2)];
		};
	};

	if (_mode == 2) exitWith
	{
		// Случайное создание ИИ
		_triggerPos 	= 	getPosASL _trigger;
		_location 		= 	_trigger getVariable ["triggerLocation",_triggerPos];

		if ((_triggerPos distance _location) > 0) then
		{
			_location setPosition _triggerPos;
		};

		if (DZAI_debugLevel > 1) then
		{
			diag_log format["[DZAI]: [fn_init_trigger.sqf]: [РАСШИРЕННАЯ ОТЛАДКА]: Инициализация Случайных ИИ: %1. GroupArray: %2.",triggerText _trigger,(_this select 2)];
		};
	};
	if (_mode == 3) exitWith
	{
		// Статичное создание ИИ (Свои позиции)
		_trigger setVariable ["patrolDist",(_this select 3)];
		_trigger setVariable ["equipType",(_this select 4)];
		_trigger setVariable ["locationArray",(_this select 5)];
		_trigger setVariable ["maxUnits",(_this select 6)];
		_trigger setVariable ["spawnChance",1];

		if (DZAI_debugLevel > 1) then
		{
			diag_log format["[DZAI]: [fn_init_trigger.sqf]: [РАСШИРЕННАЯ ОТЛАДКА]: Инициализация Статичных ИИ (Свои позиции): %1. GroupArray: %2, PatrolDist: %3. equipType: %4. %LocationArray %5 позиций, MaxUnits %6.",triggerText _trigger,(_this select 2),(_this select 3),(_this select 4),count (_this select 5),(_this select 6)];
		};
	};
};

_trigger setVariable ["triggerStatements",+(triggerStatements _trigger)];
_trigger setVariable ["initialized",true];

true