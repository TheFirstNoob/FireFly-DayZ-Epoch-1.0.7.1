private ["_unit","_hit","_damage","_source","_ammo","_unithealth","_scale","_blooddamage","_newbloodlevel","_headShots","_partdamage","_deathType","_headHit"];
_unit 		= 	_this select 0;
_hit 		= 	_this select 1;
_damage 	= 	_this select 2;
_source 	= 	_this select 3;
_ammo 		= 	_this select 4;

if ((group _unit) == (group _source)) then 			// Избавимся от Дружественного огня и урон от Коллизии.
{
	_damage = (_damage/10)
};
_unithealth = _unit getVariable "unithealth"; 		// Получим статистику Здоровья ИИ

_scale 		= 	300;
_deathType 	= 	"bled";
_headHit 	= 	(_hit == "head_hit");
if (_damage > 0.4) then
{
	call {
		if (_hit == "legs") exitWith
		{
			_partdamage 	= 	(_unithealth select 1) + (_damage/2);
			_unithealth set [1,_partdamage];

			if ((_partdamage > 0.99) && {!(_unithealth select 2)}) then
			{
				_nul 	= 	_unit spawn {_this setHit["legs",1]};
				[nil,_unit,rSAY,["z_fracture_1",40]] call RE;
				_unithealth set [2,true];
			}; 
		};

		if (_headHit) exitWith
		{
			_scale 	= 	_scale + 500;
		};
	};

	if (isPlayer _source) then
	{
		_scale 	= 	_scale + 800;

		if (_headHit) then
		{			
			if (_damage > 1.5) then
			{
				_deathType 	= 	"shothead";
				_scale 		= 	12000;
			}
			else
			{
				_scale 	= 	_scale + 500;
			};
		};
	};
	
	call {
		if (_ammo isKindOf "GrenadeBase") exitWith
		{
			_scale 	= 	_scale + 200;

			if (_damage > 4) then
			{
				_deathType 	= 	"explosion";
				_scale 		= 	12000;
			};
		};

		if ((_ammo isKindOf "B_127x107_Ball") || (_ammo isKindOf "B_127x99_Ball")) exitWith
		{
			_scale 	= 	_scale + 200;

			if (_damage > 4) then
			{
				_deathType 	= 	"shotheavy";
				_scale 		= 	12000;
			};
		};
	};
	
	_blooddamage 	= 	(_damage * _scale);
	_newbloodlevel 	= 	(_unithealth select 0) - _blooddamage;
	_unithealth set [0,_newbloodlevel];
	
	// Расскомментируйте строчку ниже для Отладки урона и подсчет крови ИИ
	//diag_log format ["[DZAI]: [fn_damageHandlerAI2.sqf]: [КРОВЬ И УРОН]: ИИ: %1 получил: %2 урона (по крови) в часть: %3 с патрона: %4 (Текущее значение крови: %5).",_unit,_blooddamage,_hit,_ammo,_newbloodlevel];
	
	if (_newbloodlevel < 0) then
	{
		_nul 	= 	[_unit,_source,_deathType] call DZAI_unitDeath;
	}
	else
	{
		if (!(_unit getVariable ["unconscious",false]) && {((_damage > 2) || {((_damage > 0.5) && (_hit == "head_hit"))})}) then
		{
			_nul 	= 	[_unit,_hit] spawn DZAI_unconscious;
			_unit setVariable ["unconscious",true];
		};
	};
};

0