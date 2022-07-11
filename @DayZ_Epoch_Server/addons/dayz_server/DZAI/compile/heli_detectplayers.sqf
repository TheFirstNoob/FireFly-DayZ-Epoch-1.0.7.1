private ["_unitGroup","_detectBase","_detectFactor","_detectRange","_helicopter"];
_unitGroup 		= 	_this select 0;
_helicopter 	= 	vehicle (leader _unitGroup);
_detectRange 	= 	if (_unitGroup getVariable ["DetectPlayersWide",false]) then
					{
						_unitGroup setVariable ["DetectPlayersWide",false];
						375
					}
					else
					{
						250
					};

uiSleep 3;

if (_unitGroup getVariable ["HeliDetectReady",true]) then
{
	_unitGroup setVariable ["HeliDetectReady",false];
	_detectStartPos 	= 	getPosASL _helicopter;
	while {!(_helicopter getVariable ["heli_disabled",false])} do {
		private ["_detected","_detectOrigin","_detectedCount","_startPos"];
		_startPos 		= 	getPosASL _helicopter;
		_detectOrigin 	= 	[_startPos,100,getDir _helicopter,1] call SHK_pos;
		_detectOrigin set [2,0];
		_detected 		= 	_detectOrigin nearEntities [["CAManBase","LandVehicle"],_detectRange];
		_detectedCount 	= 	(count _detected);

		if (_detectedCount > 0) then
		{
			if (_detectedCount > 15) then
			{
				_detected resize 15
			};
			{
				if (isPlayer _x) then
				{
					_heliAimPos 	= 	aimPos _helicopter;
					_playerAimPos 	= 	aimPos _x;

					// Eсли между вертолетом и игроком нет пересечения местности и объектов, то раскрываем игрока
					if (!(terrainIntersectASL [_heliAimPos,_playerAimPos]) && {!(lineIntersects [_heliAimPos,_playerAimPos,_helicopter,_x])}) then
					{
						_unitGroup reveal [_x,2.5];
					};
				};
				uiSleep 0.1;
			} forEach _detected;
			
			if (((_helicopter distance _detectStartPos) > 700) || {_helicopter getVariable ["heli_disabled",false]}) exitWith
			{
				_unitGroup setVariable ["HeliDetectReady",true]
			};
			uiSleep 15;
		}
		else
		{
			uiSleep 7.5;
		};
	};
};
