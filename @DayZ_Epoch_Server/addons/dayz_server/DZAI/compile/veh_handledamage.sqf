private ["_unit","_hit","_damage","_source","_ammo"];
_hit 		=	_this select 1;
_damage 	=	_this select 2;
_ammo 		=	_this select 4; 

if (_ammo == "") then
{
	_damage = 0
};

_damage