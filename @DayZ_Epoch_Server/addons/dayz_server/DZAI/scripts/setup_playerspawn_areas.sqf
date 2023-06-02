_index 	= 	0;

while {(getMarkerColor ("spawn" + (str _index))) != ""} do {
	_markerPos 	= 	getMarkerPos ("spawn" + (str _index));
	_blacklist 	= 	createLocation ["Strategic",_markerPos,DZAI_freshSpawnRaduis,DZAI_freshSpawnRaduis];
	_index 		= 	_index + 1;

	uiSleep 1;
};

if (DZAI_debugLevel > 1) then
{
	diag_log format ["[DZAI]: [setup_playerspawn_areas.sqf]: [РАСШИРЕННАЯ ОТЛАДКА]: Создано %1 динамических запрещенных областей создания ИИ для областей возрождения новых игроков.",_index]
};