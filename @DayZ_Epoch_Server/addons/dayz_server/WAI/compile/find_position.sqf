local _i 			= 	0;
local _validspot 	= 	false;
local _position 	= 	[];
local _safepos 		= 	[];
local _color 		= 	"";

if (WAI_Blacklist) then
{
	_safepos 	= 	[getMarkerPos "center",150,((getMarkerSize "center") select 1),(_this select 0),0,0.4,0,waiBlackList];
}
else
{
	_safepos 	= 	[getMarkerPos "center",150,((getMarkerSize "center") select 1),(_this select 0),0,0.4,0];
};

while {!_validspot} do {
	_i 			= 	_i + 1;
	_position 	= 	if (!WAI_SpawnPoints) then
					{
						_safepos call BIS_fnc_findSafePos
					}
					else
					{
						waiSpawnPoints call BIS_fnc_selectRandom
					};
	_validspot 	= 	true;

	// Если количество выбранных позиций больше двух, то BIS_fnc_findSafePos не выполнен
	if (!WAI_SpawnPoints) then
	{
		if ((count _position) > 2) then
		{
			_validspot 	= 	false;
			_color 		= 	"ColorBlue";
		};
	};

	if (_validspot && {WAI_AvoidMissions != 0}) then
	{
		{
			if ((typeName _x) == "ARRAY" && {_position distance _x < WAI_AvoidMissions}) exitWith
			{
				if (WAI_DebugMode) then
				{
					diag_log format ["[WAI]: [ОТЛАДКА]: [find_position.sqf]: Неверная позиция: %1", _x];
				};

				_validspot 	= 	false;
				_color 		= 	"ColorBlue";
			};
		} count DZE_MissionPositions;
	};

	if (_validspot && {WAI_AvoidSafezones != 0}) then
	{
		{
			if (_position distance (_x select 0) < WAI_AvoidSafezones) exitWith
			{
				if (WAI_DebugMode) then
				{
					diag_log "[WAI]: [ОТЛАДКА]: [find_position.sqf]: Неверная позиция: (Торговая зона)";
				};

				_color 		= 	"ColorBrown";
				_validspot 	= 	false;
			};
		} forEach DZE_SafeZonePosArray;
	};

	if (_validspot && {WAI_AvoidWater != 0}) then
	{
		if ([_position,WAI_AvoidWater] call isNearWater) then
		{
			if (WAI_DebugMode) then
			{
				diag_log "[WAI]: [ОТЛАДКА]: [find_position.sqf]: Неверная позиция: (Вода)";
			};

			_color 		= 	"ColorBlue";
			_validspot 	= 	false;
		}; 
	};

	if (_validspot && {WAI_AvoidTown != 0}) then
	{
		if ([_position,WAI_AvoidTown] call isNearTown) then
		{
			if (WAI_DebugMode) then
			{
				diag_log "[WAI]: [ОТЛАДКА]: [find_position.sqf]: Неверная позиция: (Город)";
			};

			_color 		= 	"ColorGreen";
			_validspot 	= 	false;
		};
	};

	if (_validspot && {WAI_AvoidRoad != 0}) then
	{
		if ([_position,WAI_AvoidRoad] call isNearRoad) then
		{
			if (WAI_DebugMode) then
			{
				diag_log "[WAI]: [ОТЛАДКА]: [find_position.sqf]: Неверная позиция: (Дорога)";
			};

			_color 		= 	"ColorGrey";
			_validspot 	= 	false;
		};
	};

	if (_validspot && {WAI_AvoidPlayers != 0}) then
	{
		if ([_position,WAI_AvoidPlayers] call isNearPlayer) then
		{
			if (WAI_DebugMode) then
			{
				diag_log "[WAI]: [ОТЛАДКА]: [find_position.sqf]: Неверная позиция: (Игрок)";
			};

			_color 		= 	"ColorPink";
			_validspot 	= 	false;
		};
	};
	
	if (_validspot && {WAI_AvoidPlots != 0}) then
	{
		if (count (_position nearEntities ["Plastic_Pole_EP1_DZ", WAI_AvoidPlots]) > 0) then
		{
			if (WAI_DebugMode) then
			{
				diag_log "[WAI]: [ОТЛАДКА]: [find_position.sqf]: Неверная позиция: (Строй. Столб)";
			};

			_color 		= 	"ColorBlack";
			_validspot 	= 	false;
		};
	};

	if (!_validspot) then
	{
		if (WAI_DebugMode) then
		{
			_marker 	= 	createMarkerLocal ["spotMarker" + (str _i),[_position select 0,_position select 1]];
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerTypeLocal "DOT";
			_marker setMarkerColorLocal _color;
			_marker setMarkerSizeLocal [1.0, 1.0];
			_marker setMarkerText "ОШИБКА ПОЗИЦИИ";
		};
	};

	if (_validspot) then
	{
		if (WAI_DebugMode) then {diag_log format ["[WAI]: [ОТЛАДКА]: [find_position.sqf]: Loop complete, valid position %1 in %2 attempts.",_position,_i];};
	};
};

_position set [2, 0];
_position