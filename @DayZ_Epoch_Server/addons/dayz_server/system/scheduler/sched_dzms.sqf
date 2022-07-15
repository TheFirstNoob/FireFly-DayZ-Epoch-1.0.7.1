sched_dzms_init 	=
{
	diag_log("[DZMS]: [sched_dzms.sqf]: Планировщик запущен");
	local _array 		= 	+DZMSMissionArray;
	local _timeBandit 	= 	((random(DZMSBanditMax - DZMSBanditMin) + DZMSBanditMin) * 60);
	local _timeHero 	= 	((random(DZMSHeroMax - DZMSHeroMin) + DZMSHeroMin) * 60);
	[_array,_timeBandit,_timeHero]
};

sched_dzms =
{
	local _array 		= 	_this select 0;
	local _timeBandit 	= 	_this select 1;
	local _timeHero 	= 	_this select 2;
	local _varName 		= 	"";
	
	// Таймер бандитских миссий
	if (((diag_tickTime - DZMSBanditEndTime) >= _timeBandit) && {DZMSBanditRunning < DZMSBanditLimit} && {DZMSMarkerReady}) then
	{
		DZMSMarkerReady 	= 	false;
		_varName 			= 	_array call BIS_fnc_selectRandom;
		DZMSMissionData 	= 	DZMSMissionData + [[0,[],[],[],[],[]]];
		DZMSBanditEndTime 	= 	diag_tickTime;
		DZMSBanditRunning 	= 	DZMSBanditRunning + 1;
		["Bandit"] execVM format ["\z\addons\dayz_server\DZMS\Missions\%1.sqf",_varName];

		if (DZMSDebug) then
		{
			diag_log text format ["[DZMS]: [sched_dzms.sqf]: Запускаем Бандитскую миссию: %1.",_varName];
		};
	};
	
	// Таймер геройских миссий
	if (((diag_tickTime - DZMSHeroEndTime) >= _timeHero) && {DZMSHeroRunning < DZMSHeroLimit} && {DZMSMarkerReady}) then
	{
		DZMSMarkerReady 	= 	false;
		_varName 			= 	_array call BIS_fnc_selectRandom;
		DZMSMissionData 	= 	DZMSMissionData + [[0,[],[],[],[],[]]];
		DZMSHeroEndTime 	= 	diag_tickTime;
		DZMSHeroRunning 	= 	DZMSHeroRunning + 1;
		["Hero"] execVM format ["\z\addons\dayz_server\DZMS\Missions\%1.sqf",_varName];
	
		if (DZMSDebug) then
		{
			diag_log text format ["[DZMS]: [sched_dzms.sqf]: Запускаем Геройскую миссию: %1.",_varName];
		};
	};

	_array 	= 	_array - [_varName];

	if (count _array == 0) then
	{
		_array 	= 	+DZMSMissionArray;
	};
	
	// Сбрасываем таймер
	_timeBandit 	= 	((random(DZMSBanditMax - DZMSBanditMin) + DZMSBanditMin) * 60);
	_timeHero 		= 	((random(DZMSHeroMax - DZMSHeroMin) + DZMSHeroMin) * 60);

	[_array,_timeBandit,_timeHero]
};