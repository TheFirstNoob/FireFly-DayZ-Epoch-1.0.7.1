private ["_unit","_anim","_hit","_knockoutTime","_launchWeapon","_launchAmmo"];
_unit = _this select 0;
_hit = _this select 1;

if ((vehicle _unit) == _unit) then 		// Блокируем возможность терять сознание ИИ внутри техники
{
	if ((animationState _unit) in ["amovppnemrunsnonwnondf","amovppnemstpsnonwnondnon","amovppnemstpsraswrfldnon","amovppnemsprslowwrfldf","aidlppnemstpsnonwnondnon0s","aidlppnemstpsnonwnondnon01"]) then
	{
		_anim 	= 	"adthppnemstpsraswpstdnon_2";
	}
	else
	{
		_anim 	= 	"adthpercmstpslowwrfldnon_4";
	};

	_unit switchMove _anim;
	_nul 	= 	[objNull, _unit, rSWITCHMOVE, _anim] call RE; 
	{
		_unit disableAI _x
	} forEach ["TARGET","MOVE","FSM"];

	_launchWeapon 	= 	(secondaryWeapon _unit);
	if (_launchWeapon in DZAI_launcherTypes) then
	{
		_launchAmmo 	= 	getArray (configFile >> "CfgWeapons" >> _launchWeapon >> "magazines") select 0;
		_unit removeWeapon _launchWeapon;
		_unit removeMagazines _launchAmmo;
		_loadout 		= 	_unit getVariable ["loadout",[]];
		(_loadout select 0) resize 1;
		(_loadout select 1) resize 1;

		if (DZAI_debugLevel > 1) then
		{
			diag_log format ["[DZAI]: [ai_unconscious.sqf]: [РАСШИРЕННАЯ ОТЛАДКА]: ИИ %1 упал в бессознание. Удаляем Гранатомет: %2 и Снаряды: %3.",_unit,_launchWeapon,_launchAmmo]
		};
	};
	
	_knockoutTime 	= 	if (_hit == "head_hit") then
						{
							40
						}
						else
						{
							20
						};

	if (DZAI_debugLevel > 1) then
	{
		diag_log format ["[DZAI]: [ai_unconscious.sqf]: [РАСШИРЕННАЯ ОТЛАДКА]: ИИ вышел из бессознания %1 за %2 секунд.",_unit,_knockoutTime]
	};

	uiSleep _knockoutTime;

	if (alive _unit) then
	{
		_nul 	= 	[objNull, _unit, rSWITCHMOVE, "AmovPpneMstpSnonWnonDnon_healed"] call RE;
		_unit switchMove "AmovPpneMstpSnonWnonDnon_healed";

		uiSleep 1.75;

		{
			_unit enableAI _x
		} forEach ["TARGET","MOVE","FSM"];
		_unit setVariable ["unconscious",false];
	};
}
else
{
	uiSleep 10;

	_unit setVariable ["unconscious",false];
};
