if (isServer) then
{
	_grp 			= 	_this select 0;
	_pos 			= 	_this select 1;
	_max_dist 		= 	_this select 2;
	_unitType 		= 	_grp getVariable ["unitType",""];
	_allowWater 	= 	(_unitType == "aircustom");
	_searchLoot 	= 	_unitType in ["static","dynamic"];
	_isVehicle 		= 	(_unitType == "landcustom");
	
	if (_max_dist < 75) then
	{
		_grp setSpeedMode "LIMITED"
	};

	_wpStatements = if ((_max_dist >= 100) && {_searchLoot}) then
	{
		"
			if ((random 3) > 2) then
			{
				group this setCurrentWaypoint [(group this), (floor (random (count (waypoints (group this)))))];
			}
			else
			{
				_nul 	= 	[(group this),100] spawn DZAI_findLootPile;};
		"
	}
	else
	{
		"
			if ((random 3) > 2) then
			{
				group this setCurrentWaypoint [(group this), (floor (random (count (waypoints (group this)))))];
			};
		"
	};

	_wpTimeouts 	= 	if (_max_dist >= 100) then
						{
							[0, 3, 10]
						}
						else
						{
							[5, 10, 15]
						};
	
	_center_x 	= 	(_pos) select 0;
	_center_y 	= 	(_pos) select 1;
	_center_z 	= 	(_pos) select 2;

	if (isNil "_center_z") then
	{
		_center_z 	= 	0;
	};

	_wp_count 			= 	4 + (floor random 3) + (floor (_max_dist / 100 ));
	_angle 				= 	(360 / (_wp_count -1));
	_newangle 			= 	0;
	_wp_array 			= 	[];
	_slack 				= 	_max_dist / 5.5;
	_completionRadius 	= 	if (_isVehicle) then
							{
								(5 + _slack) max 75
							}
							else
							{
								(5 + _slack)
							};

	if (_slack < 20) then
	{
		_slack 	= 	20
	};

	_angle_offset 	= 	random 180;
	while {count _wp_array < _wp_count} do 
	{
		private ["_x1","_y1","_wp_pos", "_prepos","_bldgpos","_bldgs","_a","_b"];
		
		_newangle 	= 	(count _wp_array * _angle) + _angle_offset;
		
		if ((_newangle > 360) || (_newangle < 0)) then
		{
			_newangle 	= 	abs (abs (_newangle) - 360);
		};
				
		if ((random 1) < 0.5) then 
		{
			_newangle 	= 	-_newangle;
			
			if ((_newangle > 360) || (_newangle < 0)) then
			 {
				_newangle 	= 	abs (abs (_newangle) - 360);
			 };
		};

		_x1 		= 	_center_x - (sin _newangle * _max_dist);
		_y1 		= 	_center_y - (cos _newangle * _max_dist);
		_prepos 	= 	[_x1, _y1, _center_z];

		if ( isNil "_center_z" ) then
		{
			_prepos 	= 	[_x1, _y1];
		};

		_wp_pos 	= 	[_prepos, 0, _slack, 6, 0, 50 * (pi / 180), 0, [],[_prepos]] call BIS_fnc_findSafePos;
		_a 			= 	0 + (_wp_pos select 0);
		_b 			= 	0 + (_wp_pos select 1);
		
		if (_searchLoot) then
		{
			_bldgpos 	= 	[];
			_bldgs 		= 	nearestObjects [[_a,_b,0], ["HouseBase"], 50];
			{
			  private ["_i","_y"];
				_i 	= 	0;
				_y 	= 	_x buildingPos _i;

				while {format["%1", _y] != "[0,0,0]"} do {
					_bldgpos 	= 	_bldgpos + [_y];
					_i 			= 	_i + 1;
					_y 			= 	_x buildingPos _i;
				};
			} forEach _bldgs;
			
			if (count _bldgpos != 0) then
			{
				_wp_pos 	= 	_bldgpos call BIS_fnc_selectRandom2;
			};
		}
		else
		{
			if (_isVehicle) then
			{
				_nearRoads 		= 	_wp_pos nearRoads ((_max_dist/2) min 100);
				_roadsCount 	= 	count _nearRoads;
				_returnPos 		= 	[];

				if (_roadsCount > 0) then
				{
					_returnPos 	= 	getPosASL (_nearRoads select 0);
					if (_roadsCount > 1) then
					{
						for "_i" from 1 to (_roadsCount -1) do {
							_comparePos 	= 	getPosASL (_nearRoads select _i);

							if ((_comparePos distance _wp_pos) < (_returnPos distance _wp_pos)) then
							{
								_returnPos 	= 	_comparePos;
							};
						};
					};
					_wp_pos 	= 	_returnPos;
				};
			};
		};
		_wp_array 	= 	_wp_array + [_wp_pos];

		uiSleep 0.5;
	};

	uiSleep 1;

	for "_i" from 1 to (_wp_count - 1) do
	{
		private ["_wp","_cur_pos"];

		_cur_pos 	= 	(_wp_array select _i);
		
		if ((!(surfaceIsWater _cur_pos)) or {_allowWater}) then
		{
			_wp 	= 	_grp addWaypoint [_cur_pos, 0];
			_wp setWaypointType "MOVE";
			_wp setWaypointCompletionRadius _completionRadius;
			_wp setWaypointTimeout [_wpTimeouts select 0, _wpTimeouts select 1, _wpTimeouts select 2];
			_wp setWaypointStatements ["true", _wpStatements];
		};
		uiSleep 0.25;
	};

	if (_searchLoot) then
	{
		_wp1 	= 	_grp addWaypoint [_pos, 0];
		_wp1 setWaypointType "SAD";
		_wp1 setWaypointCompletionRadius (_max_dist max 100);
		[_grp,(count waypoints _grp)] setWaypointStatements ["true", "group this setCurrentWaypoint [(group this), (round (random 2) + 1)];"];
	};

	_wp2 	= 	_grp addWaypoint [_pos, 0];
	_wp2 setWaypointType "CYCLE";
	_wp2 setWaypointCompletionRadius (_max_dist max 100);

	true
};