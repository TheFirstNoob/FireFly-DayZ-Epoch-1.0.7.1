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
	
	/* FIXES */
	// https://github.com/EpochModTeam/DayZ-Epoch/commit/2d00a515cd828221c080499f86a2ec955f4ae4f7
	Player_MaintainVG 		= 	compile preprocessFileLineNumbers "dayz_code\actions\virtualGarage\player_MaintainVG.sqf";
	// https://github.com/EpochModTeam/DayZ-Epoch/commit/1b08487791b394a2896bbf258be953c434769818
	fnc_issheltered 		= 	compile preprocessFileLineNumbers "dayz_code\compile\fn_isSheltered.sqf";
	
	// FIX EVR hit player inside DZE_SafeZonePosArray with Screen Effects
	// https://github.com/EpochModTeam/DayZ-Epoch/issues/2187#issuecomment-1221432669
	//fnc_evr1 	= 	fnc_evr;
	//fnc_evr 	=
	//{
	//	if (({player distance (_x select 0) < _x select 1} count DZE_SafeZonePosArray) > 0 && _this == "Stage7") exitWith {};
	//	_this call fnc_evr1;
	//};
};