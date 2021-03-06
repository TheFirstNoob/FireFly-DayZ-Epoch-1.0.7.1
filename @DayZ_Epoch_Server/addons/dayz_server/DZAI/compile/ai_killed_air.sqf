private ["_vehicle","_victim","_unitGroup","_parachuted"];
_victim 	= 	_this select 0;
_unitGroup 	= 	_this select 1;
_vehicle 	= 	(_unitGroup getVariable ["assignedVehicle",objNull]);

if (alive _vehicle) then
{
	if (_victim getVariable ["isDriver",false]) then
	{
		_unitGroup setVariable ["unitType","aircrashed"];	// Отключим проверку катапультирования для НЕ-ИИ (Юнитов)
		_parachuted 	= 	[_vehicle] call DZAI_parachuteOut;

		if (_parachuted) then
		{
			_nul 	= 	_vehicle spawn {
				_this setFuel 0;
				_this setVehicleAmmo 0;

				uiSleep 2.5;

				_this setDamage 1;
			};

			if (DZAI_debugLevel > 0) then {diag_log format ["[DZAI]: [ai_killer_air.sqf]: [ОТЛАДКА]: Пилот ИИ %1 %2 был убит. Катапультируем живых ИИ.",(typeOf _vehicle),(typeOf _victim)];};
		};
	}
	else
	{
		0 	= 	[_victim,(_unitGroup getVariable ["weapongrade",1])] spawn DZAI_addLoot;
	};
};

true