diag_log "[DZAI]: [dzai_functions.sqf]: Компиляция функций DZAI.";

// Вспомогательные функции
if (isNil "SHK_pos_getPos") then
{
	call compile preprocessFile format ["%1\SHK_pos\shk_pos_init.sqf",DZAI_directory];
};

if (isNil "fnc_selectRandomWeighted") then
{
	fnc_selectRandomWeighted 	= 	compile preprocessFileLineNumbers format ["%1\compile\fn_selectRandomWeighted.sqf",DZAI_directory]
};

BIS_fnc_selectRandom2 	= 	compile preprocessFileLineNumbers format ["%1\compile\fn_selectRandom.sqf",DZAI_directory];
DZAI_checkClassname 	= 	compile preprocessFileLineNumbers format ["%1\compile\fn_checkclassname.sqf",DZAI_directory];

// Спавн функции
DZAI_setup_AI 				= 	compile preprocessFileLineNumbers format ["%1\compile\fn_spawnGroup.sqf",DZAI_directory];
DZAI_findSpawnPos 			= 	compile preprocessFileLineNumbers format ["%1\compile\fn_findspawnpos.sqf",DZAI_directory];
DZAI_setTrigVars 			= 	compile preprocessFileLineNumbers format ["%1\compile\fn_init_trigger.sqf",DZAI_directory];
fnc_spawnBandits_custom		= 	compile preprocessFileLineNumbers format ["%1\spawn_functions\spawnBandits_custom.sqf",DZAI_directory];
DZAI_spawnVehicle_custom 	= 	compile preprocessFileLineNumbers format ["%1\spawn_functions\spawnVehicle_custom.sqf",DZAI_directory];
DZAI_spawn_units 			= 	compile preprocessFileLineNumbers format ["%1\compile\fn_customSpawnUnits.sqf",DZAI_directory];
fnc_respawnBandits 			= 	compile preprocessFileLineNumbers format ["%1\spawn_functions\respawnBandits.sqf",DZAI_directory];
fnc_respawnHandler 			= 	compile preprocessFileLineNumbers format ["%1\spawn_functions\respawnHandler1.sqf",DZAI_directory];
fnc_respawnHandler2 		= 	compile preprocessFileLineNumbers format ["%1\spawn_functions\respawnHandler2.sqf",DZAI_directory];
fnc_despawnBandits 			= 	compile preprocessFileLineNumbers format ["%1\spawn_functions\despawnBandits.sqf",DZAI_directory];

// Функции ИИ
DZAI_AI_handledamage 	= 	compile preprocessFileLineNumbers format ["%1\compile\fn_damageHandlerAI2.sqf",DZAI_directory];
DZAI_unconscious 		= 	compile preprocessFileLineNumbers format ["%1\compile\ai_unconscious.sqf",DZAI_directory];
DZAI_BIN_taskPatrol 	= 	compile preprocessFileLineNumbers format ["%1\compile\BIN_taskPatrol.sqf",DZAI_directory];
DZAI_addLoot 			= 	compile preprocessFileLineNumbers format ["%1\compile\ai_generate_loot.sqf",DZAI_directory];
DZAI_setupLoadout 		= 	compile preprocessFileLineNumbers format ["%1\compile\ai_setup_loadout.sqf",DZAI_directory];
DZAI_autoRearm_group 	= 	compile preprocessFileLineNumbers format ["%1\compile\group_manager.sqf",DZAI_directory];
DZAI_heliAwareness 		= 	compile preprocessFileLineNumbers format ["%1\compile\heli_awareness.sqf",DZAI_directory];

// Функции убийства
DZAI_AI_killed_all 		= 	compile preprocessFileLineNumbers format ["%1\compile\ai_killed_all.sqf",DZAI_directory];
DZAI_AI_killed_static 	= 	compile preprocessFileLineNumbers format ["%1\compile\ai_killed_static.sqf",DZAI_directory];
DZAI_unitDeath 			= 	compile preprocessFileLineNumbers format ["%1\compile\ai_death.sqf",DZAI_directory];
DZAI_countKills 		= 	compile preprocessFileLineNumbers format ["%1\compile\fn_countkills.sqf",DZAI_directory];

// Функции Техники
DZAI_hHandleDamage 		= 	compile preprocessFileLineNumbers format ["%1\compile\heli_handledamage.sqf",DZAI_directory];
DZAI_vHandleDamage 		= 	compile preprocessFileLineNumbers format ["%1\compile\veh_handledamage.sqf",DZAI_directory];
DZAI_airLanding 		= 	compile preprocessFileLineNumbers format ["%1\compile\heli_airlanding.sqf",DZAI_directory];
DZAI_parachuteOut 		= 	compile preprocessFileLineNumbers format ["%1\compile\heli_parachute.sqf",DZAI_directory];
DZAI_heliDestroyed 		= 	compile preprocessFileLineNumbers format ["%1\compile\heli_destroyed.sqf",DZAI_directory];
DZAI_vehDestroyed 		= 	compile preprocessFileLineNumbers format ["%1\compile\veh_destroyed.sqf",DZAI_directory];
DZAI_AI_killed_air 		= 	compile preprocessFileLineNumbers format ["%1\compile\ai_killed_air.sqf",DZAI_directory];
DZAI_AI_killed_land 	= 	compile preprocessFileLineNumbers format ["%1\compile\ai_killed_land.sqf",DZAI_directory];
DZAI_vehRegroup 		= 	compile preprocessFileLineNumbers format ["%1\compile\veh_regroup.sqf",DZAI_directory];

// Функции Статичных ИИ
if (DZAI_staticAI) then
{
	fnc_spawnBandits 		= 	compile preprocessFileLineNumbers format ["%1\spawn_functions\spawnBandits.sqf",DZAI_directory];
	DZAI_spawnBandits_init 	= 	compile preprocessFileLineNumbers format ["%1\spawn_functions\spawnBandits_initialize.sqf",DZAI_directory];
	DZAI_static_spawn 		= 	compile preprocessFileLineNumbers format ["%1\compile\fn_createStaticSpawn.sqf",DZAI_directory];
};

// Функции Динамичных ИИ
if (DZAI_dynAISpawns) then
{
	DZAI_abortDynSpawn 			= 	compile preprocessFileLineNumbers format ["%1\compile\fn_abortdynspawn.sqf",DZAI_directory];
	fnc_spawnBandits_dynamic 	= 	compile preprocessFileLineNumbers format ["%1\spawn_functions\spawnBandits_dynamic.sqf",DZAI_directory];
	fnc_despawnBandits_dynamic 	= 	compile preprocessFileLineNumbers format ["%1\spawn_functions\despawnBandits_dynamic.sqf",DZAI_directory];
	DZAI_dyn_huntPlayer 		= 	compile preprocessFileLineNumbers format ["%1\compile\fn_seekPlayer.sqf",DZAI_directory];
	DZAI_AI_killed_dynamic 		= 	compile preprocessFileLineNumbers format ["%1\compile\ai_killed_dynamic.sqf",DZAI_directory];
};

if (DZAI_maxRandomSpawns > 0) then
{
	DZAI_createRandomSpawns 	= 	compile preprocessFileLineNumbers format ["%1\compile\createRandomSpawns.sqf",DZAI_directory];
	DZAI_abortRandSpawn 		= 	compile preprocessFileLineNumbers format ["%1\compile\fn_abortrandspawn.sqf",DZAI_directory];
	fnc_spawnBandits_random 	= 	compile preprocessFileLineNumbers format ["%1\spawn_functions\spawnBandits_random.sqf",DZAI_directory];
	fnc_despawnBandits_random 	= 	compile preprocessFileLineNumbers format ["%1\spawn_functions\despawnBandits_random.sqf",DZAI_directory];
	DZAI_AI_killed_random 		= 	compile preprocessFileLineNumbers format ["%1\compile\ai_killed_random.sqf",DZAI_directory];
};

if (DZAI_findKiller) then
{
	DZAI_huntKiller 	= 	compile preprocessFileLineNumbers format ["%1\compile\fn_findKiller.sqf",DZAI_directory];
};

if ((!isNil "DZAI_debugMarkersEnabled") && {DZAI_debugMarkersEnabled}) then
{
	//DZAI_updateSpawnMarker 	= 	compile preprocessFileLineNumbers format ["%1\compile\fn_refreshmarker.sqf",DZAI_directory];
};

// Функции Агрессии Зомби
if (DZAI_zombieEnemy && {DZAI_weaponNoise}) then
{
	DZAI_aiFired 		= 	compile preprocessFileLineNumbers format ["%1\compile\ai_fired.sqf",DZAI_directory];
	DZAI_alertZombies 	= 	compile preprocessFileLineNumbers format ["%1\compile\ai_alertzombies.sqf",DZAI_directory];
};

// Скрипты патрульной техники
if ((DZAI_maxHeliPatrols > 0) || {DZAI_maxLandPatrols > 0}) then
{
	DZAI_spawnVehiclePatrol 	= 	compile preprocessFileLineNumbers format ["%1\spawn_functions\spawnVehiclePatrol.sqf",DZAI_directory];

	if (DZAI_maxHeliPatrols > 0) then
	{
		DZAI_heliDetectPlayers 	= 	compile preprocessFileLineNumbers format ["%1\compile\heli_detectplayers.sqf",DZAI_directory];
		DZAI_heliRandomPatrol 	= 	compile preprocessFileLineNumbers format ["%1\compile\heli_randompatrol.sqf",DZAI_directory];

		if (DZAI_heliReinforceChance > 0) then
		{
			DZAI_heliReinforce 	= 	compile preprocessFileLineNumbers format ["%1\compile\heli_reinforce.sqf",DZAI_directory]
		};
	};

	if (DZAI_maxLandPatrols > 0) then
	{
		DZAI_vehPatrol 	= 	compile preprocessFileLineNumbers format ["%1\compile\veh_randompatrol.sqf",DZAI_directory];
	};
};


if (DZAI_lastManStanding) then
{
	DZAI_skillBoost 	= 	compile preprocessFileLineNumbers format ["%1\compile\fn_skillboost.sqf",DZAI_directory];
};


// Прочие функции
if (DZAI_radioMsgs) then
{
	if (DZAI_clientRadio) then
	{
		DZAI_radioSend 	=
		{
			DZAI_SMS 	= 	(_this select 1);
			(owner (_this select 0)) publicVariableClient "DZAI_SMS";
			true
		};
	}
	else
	{
		DZAI_radioSend 	=
		{
			[nil,(_this select 0),"loc",rTITLETEXT,(_this select 1),"PLAIN DOWN",2] call RE;
			true
		};
	};
};

if (DZAI_deathMessages) then
{
	DZAI_sendKillMessage 	=
	{
		private ["_killer","_victimName"];
		_killer 		= 	_this select 0;
		_victimName 	= 	_this select 1;
		{
			DZAI_killMSG 	= 	_victimName;
			(owner _x) publicVariableClient "DZAI_killMSG";
		} count (crew _killer);
	};
};

DZAI_updGroupCount 	=
{
	private ["_unitGroup","_isNewGroup"];
	_unitGroup 		= 	_this select 0;
	_isNewGroup 	= 	_this select 1;
	
	if (isNull _unitGroup) exitWith
	{
		false
	};
	
	if (_isNewGroup) then
	{
		DZAI_activeGroups 	= 	DZAI_activeGroups + [_unitGroup];
	}
	else
	{
		DZAI_activeGroups 	= 	DZAI_activeGroups - [_unitGroup];
	};
	true
};

// Функция группового назначения DZAI.
// Обнаруживает, когда East side имеет слишком много групп, тогда сменим на Resistance side.
DZAI_createGroup 	=
{
	private ["_groupSide","_unitGroup"];
	_groupSide 	= 	(if (({(side _x) == east} count allGroups) < 141) then
	{
		east
	}
	else
	{
		//Если достигнуто 140 East групп, Установим West/Resistance враждебными и назначим вместо Resistance.
		if ((resistance getFriend west) > 0) then
		{
			createCenter resistance;
			resistance setFriend [west,0];
			west setFriend [resistance,0];
			east setFriend [resistance, 1];
			resistance setFriend [east, 1];

			diag_log "[DZAI]: [dzai_functions.sqf]: [ВНИМАНИЕ]: Максимум группы достигнут за East side! Изменение Resistance side для использования DZAI. Рекомендуется уменьшить кол-во ИИ.";
		};
		resistance
	});
	
	_unitGroup 	= 	createGroup _groupSide;
	[_unitGroup,true] call DZAI_updGroupCount;
	
	_unitGroup
};

// Установим сложность ИИ в зависимости от WeaponGrade
DZAI_setSkills 	=
{
	private ["_unit","_weapongrade","_skillArray"];
	_unit 			= 	_this select 0;
	_weapongrade 	= 	_this select 1;
	_skillArray 	= 	missionNamespace getVariable ["DZAI_skill"+str(_weapongrade),DZAI_skill3];
	{
		_unit setskill [_x select 0,(((_x select 1) + random ((_x select 2)-(_x select 1))) min 1)];
	} forEach _skillArray;
};

// Создаем мух к трупам ИИ
DZAI_deathFlies 	=
{
	private ["_soundFlies"];
	_soundFlies 	= 	createSoundSource ["Sound_Flies",ASLtoATL getPosASL _this,[],0];
	_soundFlies attachTo [_this,[0,0,0]];
	_this setVariable ["sound_flies",_soundFlies];
	waitUntil {sleep 5; (speed (vehicle _this)) == 0}; 	//uiSleep
	_this enableSimulation false;
};

// Объединяет два массива и возвращает объединенный массив.
// Не добавляет повторяющиеся значения.
// Второй массив добавляется к первому массиву.
DZAI_append 	=
{
	if (((typeName (_this select 0)) != "ARRAY") && ((typeName (_this select 1)) != "ARRAY")) exitWith
	{
		diag_log "[DZAI]: [dzai_functions.sqf]: [ОШИБКА]: DZAI_append функция не получила два массива!";
	};
	{
		if !(_x in (_this select 0)) then
		{
			(_this select 0) set [(count (_this select 0)),_x];
		};
	} forEach (_this select 1);
	(_this select 0)
};

DZAI_findLootPile 	=
{
	private ["_lootPiles","_lootPos","_unitGroup","_searchRange"];
	_unitGroup 		= 	_this select 0;
	_searchRange 	= 	_this select 1;
	_lootPiles 		= 	(getPosASL (leader _unitGroup)) nearObjects ["ReammoBox",_searchRange];

	if ((count _lootPiles) > 0) then
	{
		_lootPos 	= 	ASLtoATL getPosASL (_lootPiles call BIS_fnc_selectRandom2);

		if ((behaviour (leader _unitGroup)) != "AWARE") then
		{
			_unitGroup setBehaviour "AWARE"
		};

		(units _unitGroup) doMove _lootPos;

		{
			_x moveTo _lootPos
		} forEach (units _unitGroup);
	};
};

// Предотвращает уничтожение/удаление объекта из Анти-Чит проверки DayZ.
DZAI_protectObject 	=
{
	private ["_objectMonitor","_object"];
	_object 		= 	_this;
	_objectMonitor 	= 	missionNamespace getVariable [DZAI_serverObjectMonitor,[]];
	_objectMonitor set [count _objectMonitor,_object];
	DZAI_monitoredObjects set [count DZAI_monitoredObjects,_object];
	_object setVariable ["ObjectID","1"];
	_object setVariable ["ObjectUID","1"];
	true
};

DZAI_getWeapongrade 	=
{
	private ["_indexWeighted"];

	_indexWeighted 	= 	call {
		if (_this == 0) exitWith {DZAI_gradeIndices0};
		if (_this == 1) exitWith {DZAI_gradeIndices1};
		if (_this == 2) exitWith {DZAI_gradeIndices2};
		if (_this == 3) exitWith {DZAI_gradeIndices3};
		if (_this == 4) exitWith {DZAI_gradeIndicesDyn};
		DZAI_gradeIndices1
	};
		
	DZAI_weaponGrades select (_indexWeighted call BIS_fnc_selectRandom2)
};

DZAI_spawn_vehicle 	=
{
	if ((getMarkerColor (_this select 0)) == "") exitWith
	{
		diag_log format ["[DZAI]: [dzai_functions.sqf]: [ОШИБКА]: Не удалось найти Маркер для создания %1 ИИ Техники!",(_this select 0)]
	};

	if (!([(_this select 1),"vehicle"] call DZAI_checkClassname)) exitWith
	{
		diag_log format ["[DZAI]: [dzai_functions.sqf]: [ОШИБКА]: Указанное Имя техники: %1 Забанен на сервере или КлассНейм Не существует!",(_this select 1)]
	};

	if ((typeName (_this select 2)) != "ARRAY") then
	{
		_this set [2,[3,3]]
	};

	if (!((_this select 3) in DZAI_weaponGradesAll)) then
	{
		_this set [3,1]
	};

	DZAI_customSpawnQueue set [(count DZAI_customSpawnQueue),_this];
};

DZAI_protectGroup 	=
{
	private ["_dummy"];
	_dummy 	= 	_this createUnit ["Logic",[0,0,0],[],0,"FORM"];
	[_dummy] joinSilent _this;
	_dummy disableAI "MOVE";
	_dummy setVariable ["unconscious",true];

	if ((behaviour _dummy) != "AWARE") then
	{
		_this setBehaviour "AWARE"
	};

	_this setVariable ["dummyUnit",_dummy];
	
	if (DZAI_debugLevel > 1) then
	{
		diag_log format["[DZAI]: [dzai_functions.sqf]: [РАСШИРЕННАЯ ОТЛАДКА]: Создано 1 манекен ИИ для сохранения группы: %1.",_this];
	};
	
	_dummy
};

DZAI_addTempNVG 	=
{
	_this addWeapon "NVGoggles_DZE";
	_this setVariable ["removeNVG",true];
	
	true
};

DZAI_respawnAIVehicle 	=
{
	private ["_vehicle","_unitType"];
	_unitType 	= 	(_this select 0) getVariable ["unitType",""];
	_vehicle 	= 	_this select 1;

	call {
		if (_unitType in ["aircustom","landcustom"]) exitWith
		{
			private ["_spawnParams"];

			_spawnParams 	= 	(_this select 0) getVariable ["spawnParams",false];

			if (_spawnParams select 4) then
			{
				[1,_spawnParams] call fnc_respawnHandler;
			};

			if (_vehicle isKindOf "Air") then
			{
				DZAI_curHeliPatrols 	= 	DZAI_curHeliPatrols - 1
			}
			else
			{
				DZAI_curLandPatrols 	= 	DZAI_curLandPatrols - 1
			};
		};

		if (_unitType in ["air","land"]) exitWith
		{
			[2,typeOf _vehicle] call fnc_respawnHandler;

			if (_vehicle isKindOf "Air") then
			{
				DZAI_curHeliPatrols 	= 	DZAI_curHeliPatrols - 1
			}
			else
			{
				DZAI_curLandPatrols 	= 	DZAI_curLandPatrols - 1
			};
		};
	};
	_vehicle setVariable ["DZAI_deathTime",diag_tickTime];
	true
};

DZAI_updateSpawnCount 	=
{
	private ["_trigger","_arrayString","_triggerArray"];
	_trigger 		= 	_this select 0;
	_arrayString 	= 	_this select 1;
	_triggerArray 	= 	missionNamespace getVariable [_arrayString,[]];

	if (!isNull _trigger) then
	{
		if (_trigger in _triggerArray) then
		{
			_triggerArray 	= 	_triggerArray - [_trigger];
		}
		else
		{
			if ((triggerStatements _trigger select 1) == "") then
			{
				_triggerArray set [count _triggerArray,_trigger];
			};
		};
	};
	
	_triggerArray 	= 	_triggerArray - [objNull];
	missionNamespace setVariable [_arrayString,_triggerArray];
};

DZAI_deleteGroup 	=
{
	private ["_groupManager"];
	[_this,false] call DZAI_updGroupCount;
	{
		if (alive _x) then
		{
			deleteVehicle _x;
		}
		else
		{
			[_x] joinSilent grpNull;
		};
	} count (units _this);
	deleteGroup _this;
	true
};

DZAI_chance 	=
{
	private ["_result"];
	_result 	= 	((random 1) < _this);
	_result
};


DZAI_addMapMarker 	=
{
	private ["_mapMarkerArray","_objectString"];
	_mapMarkerArray 	= 	missionNamespace getVariable ["DZAI_mapMarkerArray",[]];
	_objectString 		= 	str (_this);

	if !(_objectString in _mapMarkerArray) then
	{
		if ((getMarkerColor _objectString) == "") then
		{
			private ["_marker"];

			_marker = createMarker [_objectString, (getPosASL _this)];
			_marker setMarkerType "Defend";
			_marker setMarkerBrush "Solid";
		};
		_mapMarkerArray set [(count _mapMarkerArray),_objectString];
		missionNamespace setVariable ["DZAI_mapMarkerArray",_mapMarkerArray];
	};

	if (_this isKindOf "EmptyDetector") then
	{
		_objectString setMarkerText "СТАТИЧНЫЙ ТРИГГЕР (АКТИВНО)";
		_objectString setMarkerColor "ColorRed";
	};
};


diag_log "[DZAI]: [dzai_functions.sqf]: DZAI функции скомпилированы.";
