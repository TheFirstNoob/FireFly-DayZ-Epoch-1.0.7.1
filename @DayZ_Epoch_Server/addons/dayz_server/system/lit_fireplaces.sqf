private ["_blocked","_fires","_flame","_position"];

// ЧЕРНО!
_fires 	= 	[];

if (dayz_townGenerator) then
{
	_fires 	= 	_fires + [];
};

if (dayz_POIs) then
{
	_fires 	= 	_fires + [];
};

{
	_blocked 	= 	false;
	_position 	= 	_x;
	{
		if (_position distance _x < 150) exitWith
		{
			_blocked 	= 	true;
		};
	} forEach dayz_townGeneratorBlackList;

	if (!_blocked && (random 1 < 0.33)) then
	{
		_flame 	= 	"flamable_DZ" createVehicle [0,0,0];
		_flame setPosATL _x;
		_flame inflame true;
		_flame setVariable ["permaLoot",true];
	};
	uiSleep 1;
} count _fires;