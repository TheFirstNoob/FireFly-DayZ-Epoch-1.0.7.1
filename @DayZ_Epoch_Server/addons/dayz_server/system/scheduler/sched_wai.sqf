sched_wai_init 	=
{
	diag_log("[WAI]: [sched_wai]: Планировщик запущен...");
	local _hArray 	= 	+WAI_HeroMissions;
	local _bArray 	= 	+WAI_BanditMissions;
	local _hTime 	= 	(random ((WAI_Timer select 1) - (WAI_Timer select 0)) + (WAI_Timer select 0)) * 60;
	local _bTime 	= 	(random ((WAI_Timer select 1) - (WAI_Timer select 0)) + (WAI_Timer select 0)) * 60;
	[_hArray,_bArray,_bTime,_hTime]
};

sched_wai 	=
{
	local _hArray 	= 	_this select 0;
	local _bArray 	= 	_this select 1;
	local _bTime 	= 	_this select 2;
	local _hTime 	= 	_this select 3;
	local _mission 	= 	"";
	
	// Таймер бандитских миссий
	if (WAI_MarkerReady && {diag_tickTime - WAI_BanditStartTime >= _bTime} && {WAI_BanditRunning < WAI_BanditLimit}) then
	{	
		WAI_MarkerReady 	= 	false;
		local _selected 	= 	false;
		_bTime 				= 	(random ((WAI_Timer select 1) - (WAI_Timer select 0)) + (WAI_Timer select 0)) * 60;
		
		while {!_selected} do {
			if (WAI_DebugMode) then
			{
				diag_log format["[WAI]: [sched_wai]: Массив Бандитских: %1",_bArray];
			};

			_bArray 	= 	[_bArray, 25] call fn_shuffleArray;
			_mission 	= 	_bArray select 0;
			_bArray 	= 	[_bArray, 0] call fnc_deleteAt;

			if (count _bArray == 0) then
			{
				_bArray 	= 	+WAI_BanditMissions;
			};

			if ((_mission select 1) >= random 1) then
			{
				_selected 	= 	true;

				if (WAI_DebugMode) then
				{
					diag_log format["[WAI]: [sched_wai]: Бандитская миссия %1 выбрана.",(_mission select 0)];
				};
			}
			else
			{
				if (WAI_DebugMode) then
				{
					diag_log format["[WAI]: [sched_wai]: Бандитская миссия %1 НЕ выбрана.",(_mission select 0)];
				};
			};
		};
			
		WAI_BanditRunning 		= 	WAI_BanditRunning + 1;
		WAI_BanditStartTime 	= 	diag_tickTime;
		WAI_MissionData 		= 	WAI_MissionData + [[0,[],[],[],[],[]]]; // [AI Count, UnitGroups, Crates, AI Vehicles, Vehicles, Objects]
		["Bandit"] execVM format ["\z\addons\dayz_server\WAI\missions\missions\%1.sqf",(_mission select 0)];
	};
	
	// Таймер геройских миссий
	if (WAI_MarkerReady && {diag_tickTime - WAI_HeroStartTime >= _hTime} && {WAI_HeroRunning < WAI_HeroLimit}) then
	{
		WAI_MarkerReady 	= 	false;
		local _selected 	= 	false;
		_hTime 				= 	(random ((WAI_Timer select 1) - (WAI_Timer select 0)) + (WAI_Timer select 0)) * 60;
		
		while {!_selected} do {
			if (WAI_DebugMode) then
			{
				diag_log format["[WAI]: [sched_wai]: Массив Геройских: %1",_hArray];
			};

			_hArray 	= 	[_hArray, 25] call fn_shuffleArray;
			_mission 	= 	_hArray select 0;
			_hArray 	= 	[_hArray, 0] call fnc_deleteAt;

			if (count _hArray == 0) then
			{
				_hArray 	= 	+WAI_HeroMissions;
			};

			if ((_mission select 1) >= random 1) then
			{
				_selected 	= 	true;

				if (WAI_DebugMode) then
				{
					diag_log format["[WAI]: [sched_wai]: Геройская миссия %1 выбрана.",(_mission select 0)];
				};
			}
			else
			{
				if (WAI_DebugMode) then
				{
					diag_log format["[WAI]: [sched_wai]: Геройская миссия %1 НЕ выбрана.",(_mission select 0)];
				};
			};
		};
			
		WAI_HeroRunning 	= 	WAI_HeroRunning + 1;
		WAI_HeroStartTime 	= 	diag_tickTime;
		WAI_MissionData 	= 	WAI_MissionData + [[0,[],[],[],[],[]]]; // [AI Count, UnitGroups, Crates, AI Vehicles, Vehicles, Objects]
		["Hero"] execVM format ["\z\addons\dayz_server\WAI\missions\missions\%1.sqf",(_mission select 0)];
	};
	[_hArray,_bArray,_bTime,_hTime]
};