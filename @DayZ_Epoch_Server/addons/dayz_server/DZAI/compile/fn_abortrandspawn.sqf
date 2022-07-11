private ["_trigger","_triggerLocation"];
_trigger 	= 	_this;

[_trigger,"DZAI_randTriggerArray"] call DZAI_updateSpawnCount;
if ((!isNil "DZAI_debugMarkersEnabled") && {DZAI_debugMarkersEnabled}) then
{
	deleteMarker (str _trigger)
};

_triggerLocation 	= 	_trigger getVariable "triggerLocation";
deleteLocation _triggerLocation;
deleteVehicle _trigger;

false