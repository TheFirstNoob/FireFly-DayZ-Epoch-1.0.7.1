if (isServer) then
{
	
};

if (!isDedicated) then
{
	fnc_usec_selfActions 	= 	compile preprocessFileLineNumbers "dayz_code\compile\fn_selfActions.sqf";
	DZ_KeyDown_EH 			= 	compile preprocessFileLineNumbers "dayz_code\compile\keyboard.sqf";
	player_debug 			= 	compile preprocessFileLineNumbers "Scripts\DebugMonitor\player_debug.sqf";
};