#include "\z\addons\dayz_server\compile\server_toggle_debug.hpp"

sched_co_deleteVehicle 	=
{
	private "_group";
	_this removeAllMPEventHandlers "mpkilled";
	_this removeAllMPEventHandlers "mphit";
	_this removeAllMPEventHandlers "mprespawn";
	_this removeAllEventHandlers "FiredNear";
	_this removeAllEventHandlers "HandleDamage";
	_this removeAllEventHandlers "Killed";
	_this removeAllEventHandlers "Fired";
	_this removeAllEventHandlers "GetIn";
	_this removeAllEventHandlers "GetOut";
	_this removeAllEventHandlers "Local";
	_this removeAllEventHandlers "Respawn";
	
	clearVehicleInit _this;
	_group 	= 	group _this;
	deleteVehicle _this;

	if (count units _group == 0) then
	{
		deleteGroup _group;
	};
		
	_this 	= 	nil;
};


sched_corpses = {
	private ["_delQtyG","_delQtyZ","_delQtyP","_addFlies","_x","_deathTime","_onoff","_delQtyAnimal","_sound","_deathPos","_cpos","_animal","_nearPlayer","_delQtyV"];
	// КАЖДЫЕ 2 МИНУТЫ
	_delQtyZ 	= 	0;
	_delQtyP 	= 	0;
	_delQtyG 	= 	0;
	_delQtyV 	= 	0;
	_addFlies 	= 	0;
	{
		if (local _x && {_x isKindOf "CAManBase"}) then
		{
			if (_x isKindOf "zZombie_Base" || {typeOf _x == "z_bloodsucker"}) then
			{
				_x call sched_co_deleteVehicle;
				_delQtyZ 	= 	_delQtyZ + 1;
			}
			else
			{
				_deathTime 	= 	_x getVariable ["sched_co_deathTime", -1];
				if (_x getVariable["bodyName",""] != "") then
				{
					if (_deathTime == -1) then
					{
						_deathTime 	= 	diag_tickTime;
						_x setVariable ["sched_co_deathTime", _deathTime];

						if (dayz_enableFlies) then
						{
							_x setVariable ["sched_co_fliesAdded", true];
							_addFlies 	= 	_addFlies + 1;
						};
					};

					if (diag_tickTime - _deathTime > 360*60) then
					{
						if (_x getVariable["sched_co_fliesDeleted",false] or !dayz_enableFlies) then
						{
							_sound 	= 	_x getVariable ["sched_co_fliesSource", nil];
							
							if !(isNil "_sound") then
							{
								detach _sound;
								deleteVehicle _sound;
							};
							
							_x call sched_co_deleteVehicle;
							_delQtyP 	= 	_delQtyP + 1;
						}
						else
						{
							PVCDZ_flies 	= 	[ 0, _x ];
							publicVariable "PVCDZ_flies";
							_x setVariable ["sched_co_fliesDeleted", true];
						};
					}
					else
					{
						if ((diag_tickTime - _deathTime < 10*60) or !dayz_enableFlies) exitWith {};
						_onoff 	= 	1;

						if (rain > 0.25) then
						{
							_onoff 	= 	0;
						};

						_sound = _x getVariable ["sched_co_fliesSource", nil];

						if !(isNil "_sound") then
						{
							detach _sound;
							deleteVehicle _sound;
							_x setVariable ["sched_co_fliesSource", nil];
						};

						if (_onoff == 1) then
						{
							_sound 	= 	createSoundSource["Sound_Flies",getPosATL _x,[],0];
							_sound attachTo [_x];
							_x setVariable ["sched_co_fliesSource", _sound,[false,true] select (DZE_Bury_Body || DZE_Butcher_Body)];
						};
						PVCDZ_flies 	= 	[ _onoff, _x ];
						publicVariable "PVCDZ_flies";
					};
				}
				else
				{
					if (_deathTime == -1) then
					{
						_deathTime 	= 	diag_tickTime;
						_x setVariable ["sched_co_deathTime", _deathTime];
					}
					else
					{
						if (diag_tickTime - _deathTime > 30) then
						{
							_x call sched_co_deleteVehicle;
							_delQtyG 	= 	_delQtyG + 1;
						};
					};
				};
			};
		};
		
		if (_x in vehicles) then
		{
			_deathTime 	= 	_x getVariable ["sched_co_deathTime", -1];
			
			if (_deathTime == -1) then
			{
				_deathTime 	= 	diag_tickTime;
				_x setVariable ["sched_co_deathTime", _deathTime];
			};
					
			if (diag_tickTime - _deathTime > 5*60) then
			{
				{
					deleteVehicle _x
				} forEach (_x nearObjects ["CraterLong",50]);
				_x call sched_co_deleteVehicle;
				_delQtyV 	= 	_delQtyV + 1;
			};
		};
	} forEach allDead;
	
	_delQtyAnimal = 0;
	{
		_animal 	= 	_x;
		if (local _animal) then
		{
			_nearPlayer 	=
			{
				isPlayer _x
			} count (_animal nearEntities ["CAManBase",150]);

			if (_nearPlayer == 0) then
			{
				_animal call sched_co_deleteVehicle;
				_delQtyAnimal 	= 	_delQtyAnimal + 1;
			};
		};
	} forEach entities "CAAnimalBase";

	_delQtyGrp 	= 	0;
	{
		if (count units _x == 0) then
		{
			deleteGroup _x;
			_delQtyGrp 	= 	_delQtyGrp + 1;
		};
	} forEach allGroups;
	
#ifdef SERVER_DEBUG
	if (_delQtyZ+_delQtyP+_addFlies+_delQtyGrp+_delQtyG+_delQtyV > 0) then
	{
		diag_log format ["[СЕРВЕР]: [sched_corpses.sqf]: [ПЛАНИРОВЩИК] %1: Удалено %2 неконтролируемых зомби, %3 неконтролируемых животных, %4 мертвых тел, %7 призраков, %8 уничтоженной техники и %5 пустых групп. Добавлено %6 мух.",__FILE__,
		_delQtyZ,_delQtyAnimal,_delQtyP,_delQtyGrp,_addFlies,_delQtyG,_delQtyV];
	};
#endif

	objNull
};