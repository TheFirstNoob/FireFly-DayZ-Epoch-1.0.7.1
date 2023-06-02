if (isServer) then {};

if (!isDedicated) then
{
	fnc_usec_selfActions 	= 	compile preprocessFileLineNumbers "dayz_code\compile\fn_selfActions.sqf";
	DZ_KeyDown_EH 			= 	compile preprocessFileLineNumbers "dayz_code\compile\keyboard.sqf";
	player_debug 			= 	compile preprocessFileLineNumbers "Scripts\DebugMonitor\player_debug.sqf";
	
	fnc_rotate_bot =
	{
		disableSerialization;
		local _input 	= 	_this select 0;
		local _bot 		= 	_this select 1;
		local _dir 		= 	getDir _bot;
		_dir 			= 	_dir + _input;
		_bot setDir _dir;
	};
	
	/* FIXES https://github.com/EpochModTeam/DayZ-Epoch/commit/3f350a04a600daf933c4347ae17366e189c36759 */
	if (DZE_Virtual_Garage) then
	{
		Player_MaintainVG 		= 	compile preprocessFileLineNumbers "dayz_code\actions\virtualGarage\player_MaintainVG.sqf";
	};
	fnc_issheltered 		= 	compile preprocessFileLineNumbers "dayz_code\compile\fn_isSheltered.sqf";

	//	Fix upgrading AAV_DZE to AAV_DZE1 did not work, only needed if you are using the AAV_DZE
	player_upgradeVehicle 	= 	compile preprocessFileLineNumbers "dayz_code\compile\player_upgradeVehicle.sqf";
};