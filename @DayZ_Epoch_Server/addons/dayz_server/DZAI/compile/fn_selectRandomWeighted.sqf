private ["_array", "_weights","_index","_weighted","_i"];
_array 		= 	_this select 0;
_weights 	= 	_this select 1;

// Проверка параметров.
if ((typeName _array) != (typeName [])) exitWith
{
	//debugLog "Log: [selectRandomWeighted] Array (0) must be an Array!";
	nil
};

if ((typeName _weights) != (typeName [])) exitWith
{
	//debugLog "Log: [selectRandomWeighted] Weights (1) must be an Array!";
	nil
};

if ((count _array) > (count _weights)) exitWith
{
	//debugLog "Log: [selectRandomWeighted] There must be at least as many elements in Weights (1) as there are in Array (0)!";
	nil
};

// Создаем взвешенный массив индексов
private ["_weighted"];
_weighted 	= 	[];
for "_i" from 0 to ((count _weights) - 1) do 
{
	private ["_weight"];
	_weight 	= 	_weights select _i;

	// Проверим что это ЧИСЛО.
	if ((typeName _weight) != (typeName 0)) then
	{
		//debugLog "Log: [selectRandomWeighted] Weights should be Numbers; weight set to 0!";
		_weight 	= 	0
	};
	
	//The weight should be a Number between 0 and 1.
	if (_weight < 0) then
	{
		//debugLog "Log: [selectRandomWeighted] Weights should be more than or equal to 0; weight set to 0!";
		_weight 	= 	0
	};

	// Переуточним вес для точности в сотни.
	_weight 	= 	round(_weight * 100);
	
	for "_k" from 0 to (_weight - 1) do 
	{
		_weighted 	= 	_weighted + [_i];
	};
};

private ["_index"];
_index 	= 	_weighted call BIS_fnc_selectRandom2;
_array select _index