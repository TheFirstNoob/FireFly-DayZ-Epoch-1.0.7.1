if (isServer) then {};

if (!isDedicated) then
{
	fnc_usec_selfActions 	= 	compile preprocessFileLineNumbers "dayz_code\compile\fn_selfActions.sqf";
	DZ_KeyDown_EH 			= 	compile preprocessFileLineNumbers "dayz_code\compile\keyboard.sqf";
	player_debug 			= 	compile preprocessFileLineNumbers "Scripts\DebugMonitor\player_debug.sqf";
	
	/* FIXES */
	// https://github.com/EpochModTeam/DayZ-Epoch/commit/2d00a515cd828221c080499f86a2ec955f4ae4f7
	Player_MaintainVG 		= 	compile preprocessFileLineNumbers "dayz_code\actions\virtualGarage\player_MaintainVG.sqf";
	// https://github.com/EpochModTeam/DayZ-Epoch/commit/1b08487791b394a2896bbf258be953c434769818
	fnc_issheltered 		= 	compile preprocessFileLineNumbers "dayz_code\compile\fn_isSheltered.sqf";
};