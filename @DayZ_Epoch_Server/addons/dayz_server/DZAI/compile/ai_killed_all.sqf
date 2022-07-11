private ["_victim","_killer","_unitGroup","_unitType","_groupSize","_unitsAlive"];
_victim 		= 	_this select 0;
_killer 		= 	_this select 1;
_unitGroup 		= 	_this select 2;
_unitType 		= 	_this select 3;
_unitsAlive 	= 	if ((count _this) > 4) then
					{
						_this select 4
					}
					else
					{
						0
					};

if (isPlayer _killer) then
{
	_weapongrade 	= 	_unitGroup getVariable ["weapongrade",1];
	0 	= 	[_victim,_weapongrade] spawn DZAI_addLoot;
	0 	= 	[_killer,_victim,"banditKills"] call DZAI_countKills;

	if (_unitsAlive > 0) then
	{
		_unitGroup reveal [vehicle _killer,4];
		_unitGroup setFormDir ([(leader _unitGroup),_killer] call BIS_fnc_dirTo);
		(units _unitGroup) doTarget (vehicle _killer);
		(units _unitGroup) doFire (vehicle _killer);

		if (DZAI_findKiller) then
		{
			0 	= 	[_killer,_unitGroup] spawn DZAI_huntKiller
		};

		if (DZAI_lastManStanding && {_unitsAlive == 1}) then
		{
			0 	= 	_unitGroup spawn DZAI_skillBoost; 	// Режим "Последний боец" включен
		};

		if (DZAI_debugLevel > 0) then
		{
			diag_log format["[DZAI]: [ai_killer_all.sqf]: [ОТЛАДКА]: Группа ИИ %1 была убита, Выживших в группе %2.",_unitGroup,_unitsAlive];
		};
	};
} else {
	if (_killer == _victim) then
	{
		removeAllWeapons _victim;	// Очистим инвентарь ИИ, если смерть вызвана столкновением (Например переехали на технике).
		{_victim removeMagazines _x} count (magazines _victim);
		removeBackpack _victim;
	};
};

// Принудительная анимация смерти, если у ИИ есть пистолет и он в сознании, чтобы избежать ошибки «стоять мертвым»..
if ((vehicle _victim) == _victim) then
{
	if !((_victim getVariable ["CanGivePistol",true]) && {(_victim getVariable ["unconscious",false])}) then
	{
		_anim 	= 	if ((animationState _victim) in ["amovppnemrunsnonwnondf","amovppnemstpsnonwnondnon","amovppnemstpsraswrfldnon","amovppnemsprslowwrfldf","aidlppnemstpsnonwnondnon0s","aidlppnemstpsnonwnondnon01"]) then {"adthppnemstpsraswpstdnon_2"} else {"adthpercmstpslowwrfldnon_4"};
		_nul 	= 	[objNull, _victim, rSWITCHMOVE, _anim] call RE; 
	};
};

true