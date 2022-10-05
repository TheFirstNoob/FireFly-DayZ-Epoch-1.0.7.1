if (isServer) then
{
	
};

if (!isDedicated) then
{
	dayz_resetSelfActions1 	= 	dayz_resetSelfActions;

	dayz_resetSelfActions =
	{
		call dayz_resetSelfActions1;
		
		// New Func here
		s_player_gamblefree = -1;
		s_player_gamble1 = -1;
		s_player_gamble2 = -1;
		s_player_gamble3 = -1;
	
	};
	call dayz_resetSelfActions;	

	vehicle_bot = objNull;
	preview_bot = objNull;
	preview_camera = nil;
	preview_cameraPos = nil; 
};