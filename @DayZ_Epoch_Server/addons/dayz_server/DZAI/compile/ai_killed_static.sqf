private ["_victim","_killer","_unitGroup","_trigger","_dummy","_groupIsEmpty"];
_victim 		= 	_this select 0;
_killer 		= 	_this select 1;
_unitGroup 		= 	_this select 2;
_groupIsEmpty 	= 	_this select 3;
_trigger 		= 	_unitGroup getVariable ["trigger",DZAI_defaultTrigger];

if (_groupIsEmpty) then
{
	if (_trigger getVariable ["respawn",true]) then
	{
		_respawnCount 	= 	_trigger getVariable ["respawnLimit",-1];
		if (_respawnCount != 0) then
		{
			[0,_trigger,_unitGroup] call fnc_respawnHandler; // Если все еще возможно создать группу - создадим

			if (_respawnCount > -1) then
			{
				_trigger setVariable ["respawnLimit",(_respawnCount - 1)]; // Если создание группы невозможно - уменьшаем лимит

				if (DZAI_debugLevel > 0) then
				{
					diag_log format["[DZAI]: [ai_killer_static.sqf]: [ОТЛАДКА]: Осталось созданий ИИ для группы: %1: %2.",_unitGroup,(_unitGroup getVariable ["respawnLimit",-1])];
				};
			};
		}else
		{
			_trigger setVariable ["permadelete",true];	// Блокируем создание и создаем триггер для следующего создания.
		};
	} else {
		if ((!isNil "DZAI_debugMarkersEnabled") && {DZAI_debugMarkersEnabled}) then
		{
			deleteMarker str(_trigger)
		};
		_nul 	= 	_trigger spawn {
			_trigger 	= 	_this;
			_trigger setTriggerStatements ["this","true","false"]; 	// Отключим активацию или деактивацию триггера во время выполнения очистки
			if (DZAI_debugLevel > 0) then {diag_log format["[DZAI]: [ai_killer_static.sqf]: [ОТЛАДКА]: Удаляем кастомные триггера ИИ %1 на %2 за 30 секунд.",triggerText _trigger, mapGridPosition _trigger];};

			uiSleep 30;
			{
				_x setVariable ["GroupSize",-1];
			} forEach (_trigger getVariable ["GroupArray",[]]);
			deleteMarker (_trigger getVariable ["spawnmarker",""]);
			[_trigger,"DZAI_staticTriggerArray"] call DZAI_updateSpawnCount;
			deleteVehicle _trigger;
		};
	};
} else {
	if (!(_trigger getVariable ["respawn",true])) then
	{
		_maxUnits 	= 	_trigger getVariable ["maxUnits",[0,0]]; 	// Уменьшим максимальное кол-во ИИ на триггер за каждого убитого ИИ для Не-Создаваемых триггеров
		_maxUnits set [0,(_maxUnits select 0) - 1];

		if (DZAI_debugLevel > 1) then
		{
			diag_log format["[DZAI]: [ai_killer_static.sqf]: [РАСШИРЕННАЯ ОТЛАДКА]: MaxUnits переменная для группы: %1 была установлена на: %2.",_unitGroup,_maxUnits];
		};
	};
};

true