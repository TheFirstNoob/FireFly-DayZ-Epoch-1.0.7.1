private ["_victim","_killer","_groupIsEmpty","_trigger","_unitGroup"];
_victim 		= 	_this select 0;
_killer 		= 	_this select 1;
_unitGroup 		= 	_this select 2;
_groupIsEmpty 	= 	_this select 3;
_trigger 		= 	_unitGroup getVariable ["trigger",DZAI_defaultTrigger];

if (_groupIsEmpty) then
{
	[_trigger,true] spawn fnc_despawnBandits_dynamic;	// Принудительно удалим ИИ даже если игрок находится в Триггере.
};

true