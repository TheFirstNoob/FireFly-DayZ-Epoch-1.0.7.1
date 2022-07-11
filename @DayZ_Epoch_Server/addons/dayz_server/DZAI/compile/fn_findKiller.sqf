private ["_unitGroup","_targetPlayer","_startPos","_chaseDistance"];

_targetPlayer 	= 	_this select 0;
_unitGroup 		= 	_this select 1;

// Отключаем поиск убийцы для динамических ИИ в режиме охоты
if (_unitGroup getVariable ["seekActive",false]) exitWith {};

//Если группа уже преследует игрока, а игрок убил другого члена группы ИИ, то продлим время преследования.
if (((_unitGroup getVariable ["pursuitTime",0]) > 0) && {((_unitGroup getVariable ["targetKiller",""]) == (name _targetPlayer))}) exitWith
{
	_unitGroup setVariable ["pursuitTime",((_unitGroup getVariable ["pursuitTime",0]) + DZAI_AddPursuitTimer)];

	if (DZAI_debugLevel > 0) then
	{
		diag_log format ["[DZAI]: [fn_findKiller.sqf]: [ОТЛАДКА]: Время преследования увеличено на %4 секунд для Группы: %1 (Цель: %2) к %3 секундам.",_unitGroup,name _targetPlayer,(_unitGroup getVariable ["pursuitTime",0]) - diag_tickTime, DZAI_AddPursuitTimer]
	};
};

_startPos = _unitGroup getVariable ["trigger",(getPosASL (leader _unitGroup))];
_chaseDistance = _unitGroup getVariable ["patrolDist",250];

// #define TRANSMIT_RANGE 50 //расстояние для трансляции радиотекста вокруг целевого игрока
// #define RECEIVE_DIST 150 //distance requirement to receive message from AI group leader

if ((_startPos distance _targetPlayer) < _chaseDistance) then
{
	private ["_targetPlayerPos","_leader","_ableToChase","_debugMarkers","_marker"];

	if (DZAI_debugLevel > 0) then
	{
		diag_log format ["[DZAI]: [fn_findKiller.sqf]: [ОТЛАДКА]: Группа: %1 начала преследование. Таймер: %3 секунд. Цель: %2.",_unitGroup,_targetPlayer,DZAI_PursuitTimer];
	};

	_unitGroup lockWP true;
	
	// Назначаем таймер
	_unitGroup setVariable ["pursuitTime",diag_tickTime+DZAI_PursuitTimer];
	_unitGroup setVariable ["targetKiller",name _targetPlayer];
	
	_debugMarkers 	= 	((!isNil "DZAI_debugMarkersEnabled") && {DZAI_debugMarkersEnabled});

	if (_debugMarkers) then
	{
		_markername 	= 	format ["%1 Target",_unitGroup];

		if ((getMarkerColor _markername) != "") then
		{
			deleteMarker _markername;
			uiSleep 1;
		};
		_marker = createMarker [_markername,getPosASL _targetPlayer];
		_marker setMarkerText _markername;
		_marker setMarkerType "Attack";
		_marker setMarkerColor "ColorRed";
		_marker setMarkerBrush "Solid";
	};
	
	// Начало фазы преследования.
	_ableToChase 	= 	true;
	while {_ableToChase && {alive _targetPlayer} && {((_startPos distance _targetPlayer) < _chaseDistance)} && {(!((vehicle _targetPlayer) isKindOf "Air"))}} do {
		
		if ((_unitGroup knowsAbout _targetPlayer) < 4) then
		{
			_unitGroup reveal [_targetPlayer,4]
		};
		_targetPlayerPos 	= 	ASLtoATL getPosASL _targetPlayer;
		(units _unitGroup) doMove _targetPlayerPos;
		(units _unitGroup) doTarget _targetPlayer;
		(units _unitGroup) doFire _targetPlayer;
		{
			if (alive _x) then
			{
				_x moveTo _targetPlayerPos
			};
		} count (units _unitGroup);
		
		if (DZAI_debugLevel > 1) then
		{
			diag_log format ["[DZAI]: [fn_findKiller.sqf]: [РАСШИРЕННАЯ ОТЛАДКА]: ИИ группа %1 в режиме преследования. Осталось: %2 секунд.",_unitGroup,(_unitGroup getVariable ["pursuitTime",0]) - diag_tickTime];
		};
		
		if (DZAI_radioMsgs) then
		{
			_leader 	= 	(leader _unitGroup);
			if (((_targetPlayer distance _leader) <= RECEIVE_DIST) && {!(_leader getVariable ["unconscious",false])}) then
			{
				private ["_nearbyUnits","_radioSpeech"];
				_nearbyUnits 	= 	_targetPlayerPos nearEntities [["LandVehicle","CAManBase"],DZAI_TransmitRange];

				if ((_unitGroup getVariable ["GroupSize",0]) > 1) then
				{
					{
						if ((isPlayer _x)&& {((driver (vehicle _x)) hasWeapon "ItemRadio")}) then
						{
							_speechIndex 	= 	(floor (random 3));
							_radioSpeech 	= 	call {
								if (_speechIndex == 0) exitWith
								{
									format ["[RADIO]: %1 (Лидер ИИ): %2 рядом. Это наша цель!",(name _leader),(name _targetPlayer)]
								};

								if (_speechIndex == 1) exitWith
								{
									format ["[RADIO]: %1 (Лидер ИИ): Цель выглядит как %2. Найдите его!",(name _leader),(getText (configFile >> "CfgVehicles" >> (typeOf _targetPlayer) >> "displayName"))]
								};

								if (_speechIndex == 2) exitWith
								{
									format ["[RADIO]: %1 (Лидер ИИ): Цель в %2 метрах. Прочешите эту местность!",(name _leader),round (_leader distance _targetPlayer)]
								};
								""
							};
							[_x,_radioSpeech] call DZAI_radioSend;
						};
					} count _nearbyUnits;
				}
				else
				{
					_radioSpeech = "[RADIO]: Ваше радио принимает сигнал поблизости.";
					{
						if ((isPlayer _x)&& {((driver (vehicle _x)) hasWeapon "ItemRadio")}) then
						{
							[_x,_radioSpeech] call DZAI_radioSend;
						};
					} count _nearbyUnits;
				};
			};
		};

		if (_debugMarkers) then
		{
			_marker setMarkerPos (getPosASL _targetPlayer);
		};

		uiSleep 19.5;

		_ableToChase 	= 	((!isNull _unitGroup) && {diag_tickTime < (_unitGroup getVariable ["pursuitTime",0])} && {(_unitGroup getVariable ["GroupSize",0]) > 0});

		if (_ableToChase && {isNull _targetPlayer}) then
		{
			if (DZAI_debugLevel > 1) then
			{
				diag_log format ["[DZAI]: [fn_findKiller.sqf]: [РАСШИРЕННАЯ ОТЛАДКА]: Группа ИИ: %1 пытается найти игрока: %2.",_unitGroup,_unitGroup getVariable "targetKiller"];
			};

			_nearUnits 	= 	_targetPlayerPos nearEntities ["CAManBase",100];
			{
				if ((isPlayer _x) && {((name _x) == _unitGroup getVariable "targetKiller")}) exitWith
				{
					_targetPlayer 	= 	_x
				};
			} forEach _nearUnits;
		};
		uiSleep 0.5;
	};

	if !(isNull _unitGroup) then
	{
		// Время преследования закончилось. Вернем патруль в режим патрулирования.
		_unitGroup setVariable ["pursuitTime",0];
		_unitGroup setVariable ["targetKiller",""];
		_unitGroup lockWP false;
		
		if ((_unitGroup getVariable ["GroupSize",0]) > 0) then
		{
			_waypoints 	= 	(waypoints _unitGroup);
			_unitGroup setCurrentWaypoint (_waypoints call BIS_fnc_selectRandom2);

			if (DZAI_debugLevel > 0) then
			{
				diag_log format ["[DZAI]: [fn_findKiller.sqf]: [ОТЛАДКА]: Группа ИИ: %1 закончила Преследование и приступила к Патрулированию.",_unitGroup];
			};
			
			if (DZAI_radioMsgs) then
			{
				_leader 	= 	(leader _unitGroup);

				if (((_targetPlayer distance _leader) <= RECEIVE_DIST) && {((_unitGroup getVariable ["GroupSize",0]) > 1)} && {!(_leader getVariable ["unconscious",false])} && {!(isNull _targetPlayer)}) then
				{
					private ["_nearbyUnits","_radioSpeech","_radioText"];
					_radioText 		= 	if (alive _targetPlayer) then
										{
											"[RADIO]: %1 (Лидер ИИ): Цель потеряна. Возвращаемся к патрулированию."
										}
										else
										{
											"[RADIO]: %1 (Лидер ИИ): Цель убита."
										};
					_radioSpeech 	= 	format [_radioText,(name (leader _unitGroup))];
					_nearbyUnits 	= 	(getPosASL _targetPlayer) nearEntities [["LandVehicle","CAManBase"],DZAI_TransmitRange];
					{
						if ((isPlayer _x) && {((driver (vehicle _x)) hasWeapon "ItemRadio")}) then
						{
							[_x,_radioSpeech] call DZAI_radioSend;
						};
					} count _nearbyUnits;
				};
			};
		};
	};

	if (_debugMarkers) then
	{
		deleteMarker _marker;
	};
};