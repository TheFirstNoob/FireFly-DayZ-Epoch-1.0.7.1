/* ОСНОВНЫЕ НАСТРОЙКИ */
WAI_DebugMode 		= 	false; 	// Включить отладку?
WAI_SpawnPoints 	= 	false; 	// Использовать статичные точки спавна из файла WAI\configs\spawnpoints.sqf. Если False, то создание миссии будет использовать функцию поиска позиций случайно.
WAI_Blacklist 		= 	true; 	// Использовать запрещенные зоны спавна указанные в WAI\configs\blacklist.sqf.
/* ОСНОВНЫЕ НАСТРОЙКИ - Конец */
	
/* НАСТРОЙКИ ИИ */
WAI_ShowCount 			= 	false; 			// Отображать в маркере миссии сколько ИИ осталось в живых?
WAI_HasMoney 			= 	true; 			// ТОЛЬКО ЕСЛИ ZSC Включено на сервере. Выдавать деньги ИИ в инвентарь?
WAI_RandomMoney 		= 	true; 			// Рандомизировать деньги в ИИ? Например WAI_MoneyCount = 3500 тогда у ботов будет случайное количество денег не более 3500 на каждого.
WAI_MoneyCount 			= 	3500; 			// Количество денег в инвентаре ИИ?
WAI_ClearBody 			= 	false; 			// Очищать ИИ после их смерти? УДАЛЯЕТСЯ ВООБЩЕ ВСЕ! 
DZE_NPC_CleanUp_Time 	= 	30; 			// Время для очистки трупов (В минутах)
WAI_CleanRoadKill 		= 	false; 			// Очищать ИИ если их передавили техникой (Полезно если ИИ давят например танком...)
WAI_RkDamageWeapon 		= 	0; 				// Шанс (от 0 до 100) что бот будет очищен если его передавили техникой. Данный параметр не будет работать если WAI_CleanRoadKill = true
WAI_BanditCombatMode 	= 	"RED"; 			// Боевой режим для Бандитских миссии. (Сложные) https://community.bistudio.com/wiki/setCombatMode
WAI_BanditBehaviour 	= 	"STEALTH"; 		// Поведение ИИ для Бандитских миссий. (Сложные) https://community.bistudio.com/wiki/behaviour
WAI_HeroCombatmode 		= 	"WHITE"; 		// Боевой режим для Геройских миссии. (Легкие)
WAI_HeroBehaviour 		= 	"CARELESS"; 	// Поведение ИИ для Геройских миссий. (Легкие)
WAI_ShareInfo 			= 	true; 			// ИИ передают информацию о позиции игрока друг другу?
WAI_ShareDist 			= 	100; 			// Расстояние от убитого ИИ, чтобы живой ИИ мог поделиться своим ИИ вашим примерным местоположением
WAI_KillsGain 			= 	false; 			// Добавлять убитых ИИ в счетчик убитых (Для дебаг-монитора)?
WAI_HumanityGain 		= 	false; 			// Изменять Хуманити (в зависимости от миссии) игроку за убийство ИИ?
WAI_AddHumanity 		= 	0; 				// Сколько Добавлять хуманити (за Геройские миссии)? 0 - чтобы отключить.
WAI_RemoveHumanity 		= 	0; 				// Сколько Отнимать хуманити (за Бандитские миссии)? 0 - чтобы отключить.
WAI_RewardVehGunner 	= 	true; 			// Позволяет Стрелку или "effectiveCommander" техники использовать Убийства и Хуманити за убийство?
WAI_KillFeed 			= 	false; 			// Отправлять личные сообщения игроку за убийство ИИ? Повышает нагрузку на интернет-протокол сервера.
WAI_Caching 			= 	true; 			// Кэшировать ИИ? Если true, то ИИ вне радиуса игрока просто не будут отображаться и будут храниться в памяти сервера, пока игрок не зайдет в триггер. Полезно для снижения нагрузки на сервер.

// https://community.bistudio.com/wiki/skill
// Настройки сложности ИИ для каждого типа миссий
WAI_SkillExtreme 	= 	[["aimingAccuracy",1.00],["aimingShake",1.00],["aimingSpeed",1.00],["endurance",1.00],["spotDistance",1.00],["spotTime",1.00],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]];
WAI_SkillHard 		= 	[["aimingAccuracy",0.80],["aimingShake",0.80],["aimingSpeed",0.80],["endurance",1.00],["spotDistance",0.80],["spotTime",0.80],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]];
WAI_SkillMedium 	= 	[["aimingAccuracy",0.60],["aimingShake",0.60],["aimingSpeed",0.60],["endurance",1.00],["spotDistance",0.60],["spotTime",0.60],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]];
WAI_SkillEasy 		= 	[["aimingAccuracy",0.40],["aimingShake",0.50],["aimingSpeed",0.50],["endurance",1.00],["spotDistance",0.50],["spotTime",0.50],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]];
// Рандом выбирается как 100% деленное на количество (Шанс). (Условно).
WAI_SkillRandom 	= 	[WAI_SkillExtreme,WAI_SkillHard,WAI_SkillHard,WAI_SkillHard,WAI_SkillHard,WAI_SkillMedium,WAI_SkillMedium,WAI_SkillMedium,WAI_SkillMedium,WAI_SkillEasy];

WAI_StaticUseWeapon 	= 	false; 	// Выдавать ИИ за Турелями отдельное оружие?

// Массив Турелей (для Random! Турели настраиваются отдельно в каждом файле миссии).
WAI_StaticWeapons 		=
[
	"KORD_high_TK_EP1"
	,"DSHKM_Ins"
	,"M2StaticMG"
];

WAI_StaticSkills 		= 	false; 	// Использовать СВОИ настройки сложности для Турелей? (Если False, то настройки будут взяты из сложности самой миссии).
WAI_StaticSkillArray 	= 	[["aimingAccuracy",0.20],["aimingShake",0.70],["aimingSpeed",0.75],["endurance",1.00],["spotDistance",0.70],["spotTime",0.50],["courage",1.00],["reloadSpeed",1.00],["commanding",1.00],["general",1.00]];

// Массив количества предметов у ИИ. [WAI_Food, WAI_Drink, WAI_Medical, WAI_ToolsAll, Шанс документа]
WAI_Gear0 		= 	[1,1,1,3,.10];
WAI_Gear1 		= 	[2,2,1,1,.10];
WAI_Gear2 		= 	[1,1,3,1,.10];
WAI_GearRandom 	= 	[WAI_Gear0,WAI_Gear1,WAI_Gear2];
WAI_AIMags 		= 	[1,3]; 	// Кол-во обойм у каждого ИИ [Мин,Макс]

// Шанс выдачи dog ИИ. Они могут быть обменены у Торговца Героя/Бандита для изменения +/- humanity (.20 = 20%)
WAI_BanditDogtagChance	= 	0;
WAI_HeroDogtagChance 	= 	0;

// Скины ИИ
WAI_HeroSkin 			= 	["Soldier_Sniper_PMC_DZ","Drake_Light_DZ","CZ_Special_Forces_GL_DES_EP1_DZ","FR_Rodriguez_DZ","FR_Marksman_DZ","FR_R_DZ","FR_Sapper_DZ","FR_TL_DZ","FR_OHara_DZ","USMC_Soldier_MG_DZ","US_Soldier_EP1_DZ","UN_CDF_Soldier_Guard_EP1_DZ","GER_Soldier_TL_EP1_DZ","BAF_Soldier_Officer_MTP_DZ","BAF_Soldier_N_MTP_DZ"];
WAI_BanditSkin 			= 	["Ins_Soldier_GL_DZ","TK_INS_Soldier_EP1_DZ","TK_INS_Warlord_EP1_DZ","GUE_Commander_DZ","GUE_Soldier_Sniper_DZ","GUE_Soldier_MG_DZ","GUE_Soldier_Crew_DZ","GUE_Soldier_2_DZ","GUE_Soldier_CO_DZ","BanditW1_DZ","BanditW2_DZ","Bandit1_DZ","Bandit2_DZ","MVD_Soldier_DZ","Ins_Soldier_2_DZ","CDF_Soldier_DZ","RUS_Soldier1_DZ"];
WAI_FirefighterSkin 	= 	["Firefighter1_DZ","Firefighter2_DZ","Firefighter3_DZ","Firefighter4_DZ","Firefighter5_DZ","Firefighter_Officer1_DZ","Firefighter_Officer2_DZ"];
WAI_StalkerSkin 		= 	["gsc_eco_stalker_mask_neutralW_DZ","gsc_eco_stalker_mask_fredW_DZ","gsc_eco_stalker_mask_dutyW_DZ","gsc_eco_stalker_mask_camoW_DZ"];
WAI_GhillieSkin 		= 	["GhillieFull_Desert05_DZ","GhillieFull_Desert06_DZ","GhillieFull_Desert07_DZ","GhillieFull_Desert08_DZ","GhillieFull_Snow01_DZ","GhillieFull_Snow02_DZ","GhillieFull_Snow03_DZ","GhillieFull_Snow04_DZ","GhillieFull_Snow05_DZ","GhillieFull_Urban01_DZ","GhillieFull_Wood01_DZ","GhillieFull_Wood02_DZ","GhillieFull_Wood03_DZ","GhillieFull_Wood04_DZ","GhillieFull_Wood05_DZ","GhillieFull_Wood06_DZ","GhillieFull_Wood07_DZ","GhillieFull_Wood08_DZ","GhillieFull_Wood09_DZ","GhillieFull_Wood10_DZ","GhillieFull_Wood11_DZ","GhillieFull_Wood12_DZ","GhillieFull_Wood13_DZ","GhillieFull_Wood14_DZ","GhillieFull_Wood15_DZ","GhillieFull_Wood16_DZ"];
WAI_ApocalypticSkin 	= 	["Apo_Rifleman_01_DZ","Apo_Rifleman_02_DZ","Apo_Rifleman_03_DZ","Apo_Rifleman_04_DZ","Apo_Rifleman_05_DZ","Apo_Rifleman_06_DZ"];
WAI_AcrSkin 			= 	["CZ_Soldier805_DES_ACR_DZ","CZ_Soldier_805_Wdl_ACR_DZ","CZ_Soldier_Crew_Dst_ACR_DZ","CZ_Soldier_Officer_Wdl_ACR_DZ","CZ_Soldier_Recon_Wdl_ACR_DZ","CZ_Soldier_Spec1_Wdl_ACR_DZ","CZ_Soldier_Spec2_Wdl_ACR_DZ","CZ_Soldier_Spec3_Wdl_ACR_DZ","CZ_Soldier_Spec_Demo_Dst_ACR_DZ","CZ_Soldier_Sniper_ACR_DZ","CZ_Soldier_Light_Wdl_ACR_DZ"];
WAI_GruSkin 			= 	["SG_GRU_TL_DZ","SG_GRU_Scout_DZ","SG_GRU_Sniper_DZ","SG_GRU_Spotter_DZ","SG_GRU_TL_W_DZ","SG_GRU_Scout_W_DZ","SG_GRU_Assaultman_W_DZ","SG_GRU_Medic_W_DZ","SG_GRU_TL_D_DZ","SG_GRU_Scout_D_DZ","SG_GRU_Marksman_D_DZ","SG_GRU_Operator_D_DZ","SG_GRU_MG_D_DZ"];
WAI_ScientistSkin 		= 	["gsc_scientist1_DZ","gsc_scientist1_head_DZ","gsc_scientist2_DZ","gsc_scientist2_head_DZ"];
WAI_NacSoldier 			= 	["Nac_Soldier_DZ","Nac_SoldierW_DZ"];
WAI_RockerSkin 			= 	["Rocker1_DZ","Rocker2_DZ","Rocker3_DZ","Rocker4_DZ"];
WAI_AllSkin 			= 	[WAI_HeroSkin,WAI_BanditSkin,WAI_FirefighterSkin,WAI_StalkerSkin,WAI_GhillieSkin,WAI_ApocalypticSkin,WAI_AcrSkin,WAI_GruSkin,WAI_ScientistSkin,WAI_NacSoldier,WAI_RockerSkin];
WAI_AddSkin 			= 	false; 	// Добавлять скин в труп ИИ? Установите False если включен в Конфиге миссии параметр TakeCloth.
/* НАСТРОЙКИ ИИ - Конец */

/* НАСТРОЙКИ МИССИЙ */
// Параметры избегания миссий если ... (В метрах)
WAI_AvoidMissions 	= 	600; 	// Избегать другие миссии. Если включен auto claim, то должен быть больше в 2x если WAI_AcAlertDistance.
WAI_AvoidSafezones 	= 	600; 	// Избегать Торговые зоны
WAI_AvoidTown 		= 	0; 		// Избегать Города, *** Не работает если установлен infiSTAR ***
WAI_AvoidRoad 		= 	0; 		// Избегать Дороги
WAI_AvoidWater 		= 	50; 	// Избегать Воду
WAI_AvoidPlayers 	= 	500; 	// Избегать Игроков (если они рядом с предполагаемой точкой создания миссии)
WAI_AvoidPlots 		= 	500; 	// Избегать Строй.Столбы
WAI_WaitForPlayer 	= 	true; 	// Ждать игрока пока он не окажется в пределах диапазона WAI_TimeoutDist, чтобы создать объекты миссии и ИИ.. Если включен auto-claim, то убедитесь что WAI_TimeoutDist и WAI_AcAlertDistance равны. Это хорошо для оптимизации сервера, но может быть проблемным на серверах, работающих на слабом оборудовании.																																																																										   

WAI_Timer 			= 	[5,30]; 	// Время (В минутах) между созданием миссий. [Мин, Макс]
WAI_Timeout 		= 	120; 		// Время (В минутах) время работы миссии (если они не активны).
WAI_TimeoutDist 	= 	1000; 		// Если игрок рядом с миссией (В метрах), то тайм-аут будет заморожен или обнулен. Напрямую влияет если WAI_Caching = true

WAI_CleanMissionTime 	= 	30; 				// Время (В минутах) после окончания миссии и она будет очищена. (-1 - отключить)
WAI_CleanMissionCrate 	= 	true; 				// Очищать ящик когда миссия закончилась. Если игрок находится в пределах 100 метров от ящиков, скрипт очистки будет ждать. Не распространяется на миссии с тайм-аутом (когда вышло время).
WAI_CleanWhenClear 		= 	["Road Block"]; 	// Эти имена миссий будут очищены мгновенно вне зависимости от WAI_CleanMissionTime

WAI_GodModeObj 	= 	true; 				// Отключить урон по Постройкам на миссиях
WAI_VehFuel 	= 	[5,30]; 			// Кол-во топлива в технике на миссиях [Мин%,Макс%]
WAI_VehDam 		= 	[5,40]; 			// Состояние техники на миссиях [Мин%,Макс%]
WAI_KeepVeh 	= 	false; 				// Сохранять технику в Базе Данных после рестарта? Игрок должен сесть в технику чтобы скрипт сработал.
WAI_GodModeVeh 	= 	false; 				// Отключить урон по Технике на миссиях
WAI_VehKeys 	= 	"NoVehicleKey"; 	// Где хранить ключ к технике? Параметры: "KeyonAI", "KeyinVehicle", "KeyinCrate", "NoVehicleKey".
WAI_VehMessage 	= 	true; 				// Показывать сообщение игроку когда он садится в Технику миссии

WAI_CrateSmoke 	= 	false; 		// Показывать где ящик Дымом когда миссия завершена? (Днем)
WAI_CrateFlare 	= 	false; 		// Показывать где ящик Фаером когда миссия завершена? (Ночью)

WAI_PlayersOnline 		= 	1; 			// Мин. кол-во игроков для старта миссий (Не рекомендуется 0!)
WAI_KillPercent 		= 	100; 		// Процент убитых ИИ чтобы миссия считалась Завершенной
WAI_HighValueChance 	= 	15; 		// Шанс выдачи в ящик редких предметов
WAI_NumMags 			= 	[2,8]; 		// Кол-во патронов для оружия в ящике [Мин,Макс]

WAI_EnableMineField 	= 	true; 		// Включить минное поле на миссиях?
WAI_EnableStaticGuns 	= 	true; 		// Включить турели на миссиях?
WAI_EnableParadrops 	= 	true; 		// Включить Десант на миссиях?
WAI_EnablePatrols 		= 	true; 		// Включить Тяжелую технику на миссиях?
WAI_UseLaunchers 		= 	false; 		// ИИ могут использовать гранатометы?
WAI_RemoveLauncher 		= 	true; 		// Удалять Гранатометы при смерти ИИ?

// Параметры для миссий сложности Random
// ВНИМАНИЕ. ЭТИ ПАРАМЕТРЫ СДЕЛАНЫ ОТДЕЛЬНО ПОД КАЖДУЮ МИССИЮ СЛОЖНОСТИ RANDOM
// Смотри: abandoned_trader, 
WAI_ChanceForRandomStaticGun 	= .25; 	// Шанс спавна Турелей на миссии сложности Random? (0 - 1)
WAI_ChanceForRandomLandPatrol 	= .25; 	// Шанс спавна Наземных патрулей на миссии сложности Random? (0 - 1)
WAI_ChanceForRandomHeliDrop 	= .25; 	// Шанс спавна Десанта на миссии сложности Random? (0 - 1)
WAI_ChanceForRandomMinefield 	= .25; 	// Шанс спавна Минного поля на миссии сложности Random? (0 - 1)

WAI_MessageType = "DynamicText"; 		// Вывод сообщений о миссиях. Параметры: "Radio", "DynamicText", "titleText"

WAI_HeroLimit 		= 	2; 		// Макс. кол-во миссий запущенных одновременно (Легкие)
WAI_BanditLimit 	= 	1; 		// Макс. кол-во миссий запущенных одновременно (Сложные)

// Массив Миссий
// [Название миссии, Шанс спавна]

// Здесь будут отмечены только миссии сложности Легкие, Средние, Рандом
WAI_HeroMissions 	=
[
	["abandoned_trader",1] 		// Random (2 разных типа лута)
	,["captured_mv22",1]
	,
	["patrol",1],
	["black_hawk_crash",1],
	["armed_vehicle",1],
	["base",1],
	["scout_patrol",1],
	["ikea_convoy",1],
	["medi_camp",1],
	["broken_down_ural",1],
	["sniper_extraction",1],
	["mayors_mansion",1],
	["weapon_cache",1],
	["gem_tower",1],
	["cannibal_cave",1],
	["crop_raider",1],
	["drone_pilot",1],
	["slaughter_house",1],
	["drugbust",1],
	["armybase",1],
	["lumberjack",1],
	["tankcolumn",1],
	["macdonald",1],
	["radioshack",1],
	["junkyard",1],
	["outpost",1],
	["presidents_mansion",1],
	["farmer",1],
	["firestation",1],
	["vehicle_drop",1],
	["castle_grayskull",1],
	["wuhan_lab",1],
	["apc",1]
];

// Здесь будут отмечены только миссии сложности Тяжелые, Очень тяжелые, Уникальные, Рандом
WAI_BanditMissions 	=
[
	["abandoned_trader",1] 	// Random (2 разных типа лута)
	,["captured_mv22",1]
	,
	["patrol",1],
	["black_hawk_crash",1],
	["armed_vehicle",1],
	["base",1],
	["scout_patrol",1],
	["ikea_convoy",1],
	["medi_camp",1],
	["broken_down_ural",1],
	["sniper_extraction",1],
	["mayors_mansion",1],
	["weapon_cache",1],
	["gem_tower",1],
	["cannibal_cave",1],
	["crop_raider",1],
	["drone_pilot",1],
	["slaughter_house",1],
	["drugbust",1],
	["armybase",1],
	["lumberjack",1],
	["presidents_mansion",1],
	["tankcolumn",1],
	["macdonald",1],
	["radioshack",1],
	["junkyard",1],
	["outpost",1],
	["farmer",1],
	["firestation",1],
	["vehicle_drop",1],
	["castle_grayskull",1],
	["wuhan_lab",1],
	["apc",1]
];
/* НАСТРОЙКИ МИССИЙ - Конец */

// Массив оружий
WAI_AK 				= 	["AK74_Kobra_DZ","AK74_Kobra_SD_DZ","AK74_GL_Kobra_DZ","AK74_GL_Kobra_SD_DZ","AK74_DZ","AK74_SD_DZ","AK74_GL_DZ","AK74_GL_SD_DZ","AK74_PSO1_DZ","AK74_PSO1_SD_DZ","AK74_GL_PSO1_DZ","AK74_GL_PSO1_SD_DZ","AK107_Kobra_DZ","AK107_DZ","AK107_GL_DZ","AK107_PSO_DZ","AK107_GL_PSO_DZ","AK107_GL_Kobra_DZ","AN94_DZ","AN94_GL_DZ","AKS74U_Kobra_DZ","AKS74U_Kobra_SD_DZ","AKS74U_DZ","AKS74U_SD_DZ","AKM_DZ","AKM_Kobra_DZ","AKM_PSO1_DZ","AKS_Gold_DZ","AKS_Silver_DZ","AKS_DZ"];
WAI_RK95 			= 	["RK95_DZ","RK95_SD_DZ","RK95_CCO_SD_DZ","RK95_ACOG_SD_DZ","RK95_CCO_DZ","RK95_ACOG_DZ"];
WAI_Groza 			= 	["Groza9_DZ","Groza9_Sniper_DZ","Groza9_GL_DZ","Groza9_GL_Sniper_DZ","Groza9_SD_DZ","Groza9_Sniper_SD_DZ","Groza1_DZ","Groza1_Sniper_DZ","Groza1_SD_DZ","Groza1_Sniper_SD_DZ"];
WAI_Scar 			= 	["SCAR_H_AK_DZ","SCAR_H_AK_CCO_DZ","SCAR_H_B_AK_CCO_DZ","SCAR_H_AK_HOLO_DZ","SCAR_H_AK_ACOG_DZ"];
WAI_Sniper 			= 	["WA2000_DZ","Barrett_MRAD_Iron_DZ","Barrett_MRAD_CCO_DZ","Barrett_MRAD_Sniper_DZ","MSR_DZ","MSR_SD_DZ","MSR_NV_DZ","MSR_NV_SD_DZ","XM2010_DZ","XM2010_SD_DZ","XM2010_NV_DZ","XM2010_NV_SD_DZ","Anzio_20_DZ","BAF_AS50_scoped_DZ","m107_DZ","M4SPR_DZE","M200_CheyTac_DZ","M200_CheyTac_SD_DZ","L115A3_DZ","L115A3_2_DZ","KSVK_DZE","VSS_vintorez_DZE","M24_DZ","M24_Gh_DZ","M24_DES_DZ","M40A3_Gh_DZ","M40A3_DZ","CZ750_DZ","M110_NV_DZ","MK17_Sniper_DZ","MK17_Sniper_SD_DZ","MK14_Sniper_DZ","MK14_Sniper_SD_DZ","M21_DZ","M21A5_DZ","M21A5_SD_DZ","HK417_Sniper_DZ","HK417_Sniper_SD_DZ","M1A_SC16_BL_Sniper_DZ","M1A_SC2_BL_Sniper_DZ","M1A_SC16_TAN_Sniper_DZ","DMR_DZ","DMR_SKN","DMR_Gh_DZ","DMR_DZE","DMR_Gh_DZE","RSASS_DZ","RSASS_SD_DZ","FNFAL_DZ","FNFAL_CCO_DZ","FNFAL_Holo_DZ","FNFAL_ANPVS4_DZ","FN_FAL_ANPVS4_DZE","G3_DZ"];
WAI_G36 			= 	["G36K_Camo_DZ","G36K_Camo_SD_DZ","G36A_Camo_DZ","G36A_Camo_SD_DZ","G36C_DZ","G36C_SD_DZ","G36C_CCO_DZ","G36C_CCO_SD_DZ","G36C_Holo_DZ","G36C_Holo_SD_DZ","G36C_ACOG_DZ","G36C_ACOG_SD_DZ","G36C_Camo_DZ","G36C_Camo_Holo_SD_DZ"];
WAI_M4 				= 	["M4A1_DZ","M4A1_FL_DZ","M4A1_MFL_DZ","M4A1_SD_DZ","M4A1_SD_FL_DZ","M4A1_SD_MFL_DZ","M4A1_GL_DZ","M4A1_GL_FL_DZ","M4A1_GL_MFL_DZ","M4A1_GL_SD_DZ","M4A1_GL_SD_FL_DZ","M4A1_GL_SD_MFL_DZ","M4A1_CCO_DZ","M4A1_CCO_FL_DZ","M4A1_CCO_MFL_DZ","M4A1_CCO_SD_DZ","M4A1_CCO_SD_FL_DZ","M4A1_CCO_SD_MFL_DZ","M4A1_GL_CCO_DZ","M4A1_GL_CCO_FL_DZ","M4A1_GL_CCO_MFL_DZ","M4A1_GL_CCO_SD_DZ","M4A1_GL_CCO_SD_FL_DZ","M4A1_GL_CCO_SD_MFL_DZ","M4A1_Holo_DZ","M4A1_Holo_FL_DZ","M4A1_Holo_MFL_DZ","M4A1_Holo_SD_DZ","M4A1_Holo_SD_FL_DZ","M4A1_Holo_SD_MFL_DZ","M4A1_GL_Holo_DZ","M4A1_GL_Holo_FL_DZ","M4A1_GL_Holo_MFL_DZ","M4A1_GL_Holo_SD_DZ","M4A1_GL_Holo_SD_FL_DZ","M4A1_GL_Holo_SD_MFL_DZ","M4A1_ACOG_DZ","M4A1_ACOG_FL_DZ","M4A1_ACOG_MFL_DZ","M4A1_ACOG_SD_DZ","M4A1_ACOG_SD_FL_DZ","M4A1_ACOG_SD_MFL_DZ","M4A1_GL_ACOG_DZ","M4A1_GL_ACOG_FL_DZ","M4A1_GL_ACOG_MFL_DZ","M4A1_GL_ACOG_SD_DZ","M4A1_GL_ACOG_SD_FL_DZ","M4A1_GL_ACOG_SD_MFL_DZ","M4A1_Rusty_DZ","M4A1_Camo_CCO_DZ","M4A1_Camo_CCO_SD_DZ","M4A1_Camo_Holo_GL_DZ","M4A1_Camo_Holo_GL_SD_DZ","M4A3_DES_CCO_DZ","M4A3_ACOG_GL_DZ","M4A3_Camo_DZ","M4A3_Camo_ACOG_DZ"];
WAI_HK416 			= 	["HK416_DZ","HK416_SD_DZ","HK416_GL_DZ","HK416_GL_SD_DZ","HK416_CCO_DZ","HK416_CCO_SD_DZ","HK416_GL_CCO_DZ","HK416_GL_CCO_SD_DZ","HK416_Holo_DZ","HK416_Holo_SD_DZ","HK416_GL_Holo_DZ","HK416C_DZ","HK416C_GL_DZ","HK416C_CCO_DZ","HK416C_GL_CCO_DZ","HK416C_Holo_DZ","HK416C_GL_Holo_DZ","HK416C_ACOG_DZ","HK416C_GL_ACOG_DZ"];
WAI_SteyrAug 		= 	["SteyrAug_A3_Green_DZ","SteyrAug_A3_Black_DZ","SteyrAug_A3_Blue_DZ","SteyrAug_A3_ACOG_Green_DZ","SteyrAug_A3_ACOG_Black_DZ","SteyrAug_A3_ACOG_Blue_DZ","SteyrAug_A3_Holo_Green_DZ","SteyrAug_A3_Holo_Black_DZ","SteyrAug_A3_Holo_Blue_DZ","SteyrAug_A3_GL_Green_DZ","SteyrAug_A3_GL_Black_DZ","SteyrAug_A3_GL_Blue_DZ","SteyrAug_A3_ACOG_GL_Green_DZ","SteyrAug_A3_ACOG_GL_Black_DZ","SteyrAug_A3_ACOG_GL_Blue_DZ","SteyrAug_A3_Holo_GL_Green_DZ","SteyrAug_A3_Holo_GL_Black_DZ","SteyrAug_A3_Holo_GL_Blue_DZ"];
WAI_HK53 			= 	["HK53A3_DZ","HK53A3_CCO_DZ","HK53A3_Holo_DZ"];
WAI_MagpulPDR 		= 	["PDR_DZ","PDR_CCO_DZ","PDR_Holo_DZ"];
WAI_Famas 			= 	["Famas_DZ","Famas_CCO_DZ","Famas_Holo_DZ","Famas_SD_DZ","Famas_CCO_SD_DZ","Famas_Holo_SD_DZ"];
WAI_ACR 			= 	["ACR_WDL_DZ","ACR_WDL_SD_DZ","ACR_WDL_GL_DZ","ACR_WDL_GL_SD_DZ","ACR_WDL_CCO_DZ","ACR_WDL_CCO_SD_DZ","ACR_WDL_CCO_GL_DZ","ACR_WDL_CCO_GL_SD_DZ","ACR_WDL_Holo_DZ","ACR_WDL_Holo_SD_DZ","ACR_WDL_Holo_GL_DZ","ACR_WDL_Holo_GL_SD_DZ","ACR_WDL_ACOG_DZ","ACR_WDL_ACOG_SD_DZ","ACR_WDL_ACOG_GL_DZ","ACR_WDL_ACOG_GL_SD_DZ","ACR_WDL_NV_DZ","ACR_WDL_NV_SD_DZ","ACR_WDL_NV_GL_DZ","ACR_WDL_NV_GL_SD_DZ","ACR_BL_DZ","ACR_BL_SD_DZ","ACR_BL_GL_DZ","ACR_BL_GL_SD_DZ","ACR_BL_CCO_DZ","ACR_BL_CCO_SD_DZ","ACR_BL_CCO_GL_DZ","ACR_BL_CCO_GL_SD_DZ","ACR_BL_Holo_DZ","ACR_BL_Holo_SD_DZ","ACR_BL_Holo_GL_DZ","ACR_BL_Holo_GL_SD_DZ","ACR_BL_ACOG_DZ","ACR_BL_ACOG_SD_DZ","ACR_BL_ACOG_GL_DZ","ACR_BL_ACOG_GL_SD_DZ","ACR_BL_NV_DZ","ACR_BL_NV_SD_DZ","ACR_BL_NV_GL_DZ","ACR_BL_NV_GL_SD_DZ","ACR_DES_DZ","ACR_DES_SD_DZ","ACR_DES_GL_DZ","ACR_DES_GL_SD_DZ","ACR_DES_CCO_DZ","ACR_DES_CCO_SD_DZ","ACR_DES_CCO_GL_DZ","ACR_DES_CCO_GL_SD_DZ","ACR_DES_Holo_DZ","ACR_DES_Holo_SD_DZ","ACR_DES_Holo_GL_DZ","ACR_DES_Holo_GL_SD_DZ","ACR_DES_ACOG_DZ","ACR_DES_ACOG_SD_DZ","ACR_DES_ACOG_GL_DZ","ACR_DES_ACOG_GL_SD_DZ","ACR_DES_NV_DZ","ACR_DES_NV_SD_DZ","ACR_DES_NV_GL_DZ","ACR_DES_NV_GL_SD_DZ","ACR_SNOW_DZ","ACR_SNOW_SD_DZ","ACR_SNOW_GL_DZ","ACR_SNOW_GL_SD_DZ","ACR_SNOW_CCO_DZ","ACR_SNOW_CCO_SD_DZ","ACR_SNOW_CCO_GL_DZ","ACR_SNOW_CCO_GL_SD_DZ","ACR_SNOW_Holo_DZ","ACR_SNOW_Holo_SD_DZ","ACR_SNOW_Holo_GL_DZ","ACR_SNOW_Holo_GL_SD_DZ","ACR_SNOW_ACOG_DZ","ACR_SNOW_ACOG_SD_DZ","ACR_SNOW_ACOG_GL_DZ","ACR_SNOW_ACOG_GL_SD_DZ","ACR_SNOW_NV_DZ","ACR_SNOW_NV_SD_DZ","ACR_SNOW_NV_GL_DZ","ACR_SNOW_NV_GL_SD_DZ"];
WAI_KAC 			= 	["KAC_PDW_DZ","KAC_PDW_CCO_DZ","KAC_PDW_HOLO_DZ","KAC_PDW_ACOG_DZ"];
WAI_Tavor 			= 	["CTAR21_DZ","CTAR21_CCO_DZ","CTAR21_ACOG_DZ"];
WAI_Masada 			= 	["Masada_DZ","Masada_SD_DZ","Masada_CCO_DZ","Masada_CCO_SD_DZ","Masada_Holo_DZ","Masada_Holo_SD_DZ","Masada_ACOG_DZ","Masada_ACOG_SD_DZ","Masada_BL_DZ","Masada_BL_SD_DZ","Masada_BL_CCO_DZ","Masada_BL_CCO_SD_DZ","Masada_BL_Holo_DZ","Masada_BL_Holo_SD_DZ","Masada_BL_ACOG_DZ","Masada_BL_ACOG_SD_DZ"];
WAI_MK16 			= 	["MK16_DZ","MK16_CCO_DZ","MK16_Holo_DZ","MK16_ACOG_DZ","MK16_GL_DZ","MK16_GL_CCO_DZ","MK16_GL_Holo_DZ","MK16_GL_ACOG_DZ","MK16_CCO_SD_DZ","MK16_Holo_SD_DZ","MK16_ACOG_SD_DZ","MK16_GL_CCO_SD_DZ","MK16_GL_Holo_SD_DZ","MK16_GL_ACOG_SD_DZ","MK16_BL_CCO_DZ","MK16_BL_GL_ACOG_DZ","MK16_BL_Holo_SD_DZ","MK16_BL_GL_CCO_SD_DZ"];
WAI_XM8 			= 	["XM8_DZ","XM8_DES_DZ","XM8_GREY_DZ","XM8_GREY_2_DZ","XM8_GL_DZ","XM8_DES_GL_DZ","XM8_GREY_GL_DZ","XM8_Compact_DZ","XM8_DES_Compact_DZ","XM8_GREY_Compact_DZ","XM8_GREY_2_Compact_DZ","XM8_Sharpsh_DZ","XM8_DES_Sharpsh_DZ","XM8_GREY_Sharpsh_DZ","XM8_SAW_DZ","XM8_DES_SAW_DZ","XM8_GREY_SAW_DZ","XM8_SD_DZ"];
WAI_M14 			= 	["M14_DZ","M14_Gh_DZ","M14_CCO_DZ","M14_CCO_Gh_DZ","M14_Holo_DZ","M14_Holo_Gh_DZ","M1A_SC16_BL_DZ","M1A_SC16_BL_ACOG_DZ","M1A_SC16_BL_CCO_DZ","M1A_SC16_BL_HOLO_DZ","M1A_SC16_BL_PU_DZ","M1A_SC16_TAN_DZ","M1A_SC16_TAN_ACOG_DZ","M1A_SC16_TAN_CCO_DZ","M1A_SC16_TAN_HOLO_DZ","M1A_SC16_TAN_PU_DZ","M1A_SC2_BL_DZ","M1A_SC2_BL_ACOG_DZ","M1A_SC2_BL_CCO_DZ","M1A_SC2_BL_HOLO_DZ","M1A_SC2_BL_PU_DZ"];
WAI_HK417 			= 	["HK417_DZ","HK417_SD_DZ","HK417_CCO_DZ","HK417_CCO_SD_DZ","HK417_Holo_DZ","HK417_Holo_SD_DZ","HK417_ACOG_DZ","HK417_ACOG_SD_DZ","HK417C_DZ","HK417C_GL_DZ","HK417C_CCO_DZ","HK417C_GL_CCO_DZ","HK417C_Holo_DZ","HK417C_GL_Holo_DZ","HK417C_ACOG_DZ","HK417C_GL_ACOG_DZ"];
WAI_MK14 			= 	["MK14_DZ","MK14_CCO_DZ","MK14_Holo_DZ","MK14_ACOG_DZ","MK14_SD_DZ","MK14_CCO_SD_DZ","MK14_Holo_SD_DZ","MK14_ACOG_SD_DZ"];
WAI_MK17 			= 	["MK17_DZ","MK17_CCO_DZ","MK17_Holo_DZ","MK17_ACOG_DZ","MK17_GL_DZ","MK17_GL_CCO_DZ","MK17_GL_Holo_DZ","MK17_GL_ACOG_DZ","MK17_CCO_SD_DZ","MK17_Holo_SD_DZ","MK17_ACOG_SD_DZ","MK17_GL_CCO_SD_DZ","MK17_GL_Holo_SD_DZ","MK17_BL_Holo_DZ","MK17_BL_GL_ACOG_DZ","MK17_BL_CCO_SD_DZ","MK17_BL_GL_Holo_SD_DZ"];
WAI_CZ805 			= 	["CZ805_A1_DZ","CZ805_A1_GL_DZ","CZ805_A2_DZ","CZ805_A2_SD_DZ","CZ805_B_GL_DZ"];
WAI_Shotgun 		= 	["MR43_DZ","Winchester1866_DZ","Remington870_DZ","Remington870_FL_DZ","Remington870_MFL_DZ","Saiga12K_DZ","USAS12_DZ","AA12_DZ","M1014_DZ","M1014_CCO_DZ","M1014_Holo_DZ"];
WAI_SVD 			= 	["SVD_PSO1_DZ","SVD_PSO1_Gh_DZ","SVD_DZ","SVD_Gh_DZ","SVD_PSO1_Gh_DES_DZ","SVD_NSPU_DZ","SVD_Gold_DZ","SVU_PSO1_DZ"];
WAI_Mosin 			= 	["Mosin_DZ","Mosin_FL_DZ","Mosin_MFL_DZ","Mosin_Belt_DZ","Mosin_Belt_FL_DZ","Mosin_Belt_MFL_DZ","Mosin_PU_DZ","Mosin_PU_FL_DZ","Mosin_PU_MFL_DZ","Mosin_PU_Belt_DZ","Mosin_PU_Belt_FL_DZ","Mosin_PU_Belt_MFL_DZ"];
WAI_M16 			= 	["M16A2_DZ","M16A2_GL_DZ","M16A2_Rusty_DZ","M16A4_DZ","M16A4_FL_DZ","M16A4_MFL_DZ","M16A4_GL_DZ","M16A4_GL_FL_DZ","M16A4_GL_MFL_DZ","M16A4_CCO_DZ","M16A4_CCO_FL_DZ","M16A4_CCO_MFL_DZ","M16A4_GL_CCO_DZ","M16A4_GL_CCO_FL_DZ","M16A4_GL_CCO_MFL_DZ","M16A4_Holo_DZ","M16A4_Holo_FL_DZ","M16A4_Holo_MFL_DZ","M16A4_GL_Holo_DZ","M16A4_GL_Holo_FL_DZ","M16A4_GL_Holo_MFL_DZ","M16A4_ACOG_DZ","M16A4_ACOG_FL_DZ","M16A4_ACOG_MFL_DZ","M16A4_GL_ACOG_DZ","M16A4_GL_ACOG_FL_DZ","M16A4_GL_ACOG_MFL_DZ"];
WAI_SA58 			= 	["SA58_DZ","SA58_RIS_DZ","SA58_RIS_FL_DZ","SA58_RIS_MFL_DZ","SA58_CCO_DZ","SA58_CCO_FL_DZ","SA58_CCO_MFL_DZ","SA58_Holo_DZ","SA58_Holo_FL_DZ","SA58_Holo_MFL_DZ","SA58_ACOG_DZ","SA58_ACOG_FL_DZ","SA58_ACOG_MFL_DZ","Sa58V_DZ","Sa58V_Camo_CCO_DZ","Sa58V_Camo_ACOG_DZ"];
WAI_L85 			= 	["L85A2_DZ","L85A2_FL_DZ","L85A2_MFL_DZ","L85A2_SD_DZ","L85A2_SD_FL_DZ","L85A2_SD_MFL_DZ","L85A2_CCO_DZ","L85A2_CCO_FL_DZ","L85A2_CCO_MFL_DZ","L85A2_CCO_SD_DZ","L85A2_CCO_SD_FL_DZ","L85A2_CCO_SD_MFL_DZ","L85A2_Holo_DZ","L85A2_Holo_FL_DZ","L85A2_Holo_MFL_DZ","L85A2_Holo_SD_DZ","L85A2_Holo_SD_FL_DZ","L85A2_Holo_SD_MFL_DZ","L85A2_ACOG_DZ","L85A2_ACOG_FL_DZ","L85A2_ACOG_MFL_DZ","L85A2_ACOG_SD_DZ","L85A2_ACOG_SD_FL_DZ","L85A2_ACOG_SD_MFL_DZ"];
WAI_Pistol 			= 	["M9_DZ","M9_SD_DZ","M9_Camo_DZ","M9_Camo_SD_DZ","M93R_DZ","P99_Black_DZ","P99_Black_SD_DZ","P99_Green_DZ","P99_Green_SD_DZ","P99_Silver_DZ","P99_Silver_SD_DZ","BrowningHP_DZ","P226_DZ","P226_Silver_DZ","P38_DZ","PPK_DZ","MK22_DZ","MK22_2_DZ","MK22_SD_DZ","MK22_2_SD_DZ","G17_DZ","G17_FL_DZ","G17_MFL_DZ","G17_SD_DZ","G17_SD_FL_DZ","G17_SD_MFL_DZ","G18_DZ","M1911_DZ","M1911_2_DZ","Kimber_M1911_DZ","Kimber_M1911_SD_DZ","USP_DZ","USP_SD_DZ","Makarov_DZ","Makarov_SD_DZ","Tokarew_TT33_DZ","Ruger_MK2_DZ","APS_DZ","APS_SD_DZ","PDW_DZ","PDW_SD_DZ","TEC9_DZ","Mac10_DZ","Revolver_DZ","Revolver_Gold_DZ","Colt_Anaconda_DZ","Colt_Anaconda_Gold_DZ","Colt_Bull_DZ","Colt_Python_DZ","Colt_Revolver_DZ","CZ75P_DZ","CZ75D_DZ","CZ75SP_DZ","CZ75SP_SD_DZ","DesertEagle_DZ","DesertEagle_Gold_DZ","DesertEagle_Silver_DZ","DesertEagle_Modern_DZ","Sa61_DZ"];
WAI_SMG 			= 	["Bizon_DZ","Bizon_Kobra_DZ","Bizon_SD_DZ","Bizon_Kobra_SD_DZ","MP5_DZ","MP5_SD_DZ","Kriss_DZ","Kriss_CCO_DZ","Kriss_Holo_DZ","Kriss_SD_DZ","Kriss_CCO_SD_DZ","Kriss_Holo_SD_DZ","Scorpion_Evo3_DZ","Scorpion_Evo3_CCO_DZ","Scorpion_Evo3_CCO_SD_DZ","MP7_DZ","MP7_FL_DZ","MP7_MFL_DZ","MP7_Holo_DZ","MP7_Holo_FL_DZ","MP7_Holo_MFL_DZ","MP7_CCO_DZ","MP7_CCO_FL_DZ","MP7_CCO_MFL_DZ","MP7_ACOG_DZ","MP7_ACOG_FL_DZ","MP7_ACOG_MFL_DZ","MP7_SD_DZ","MP7_SD_FL_DZ","MP7_SD_MFL_DZ","MP7_Holo_SD_DZ","MP7_Holo_SD_FL_DZ","MP7_Holo_SD_MFL_DZ","MP7_CCO_SD_DZ","MP7_CCO_SD_FL_DZ","MP7_CCO_SD_MFL_DZ","MP7_ACOG_SD_DZ","MP7_ACOG_SD_FL_DZ","MP7_ACOG_SD_MFL_DZ","TMP_DZ","TMP_CCO_DZ","TMP_Holo_DZ","TMP_SD_DZ","TMP_CCO_SD_DZ","TMP_Holo_SD_DZ","UMP_DZ","UMP_CCO_DZ","UMP_Holo_DZ","UMP_SD_DZ","UMP_CCO_SD_DZ","UMP_Holo_SD_DZ","P90_DZ","P90_CCO_DZ","P90_Holo_DZ","P90_SD_DZ","P90_CCO_SD_DZ","P90_Holo_SD_DZ","Sten_MK_DZ","MAT49_DZ","M31_DZ","VAL_DZ","VAL_Kobra_DZ","VAL_PSO1_DZ"];
WAI_LMG 			= 	["RPK_DZ","RPK_Kobra_DZ","RPK_PSO1_DZ","MG36_DZ","MG36_Camo_DZ","M249_CCO_DZ","M249_DZ","M249_Holo_DZ","M249_EP1_DZ","M249_m145_EP1_DZE","L110A1_CCO_DZ","L110A1_Holo_DZ","L110A1_DZ","BAF_L110A1_Aim_DZE","M240_DZ","M240_CCO_DZ","M240_Holo_DZ","m240_scoped_EP1_DZE","M60A4_EP1_DZE","Mk43_DZ","MK43_Holo_DZ","MK43_ACOG_DZ","MK43_M145_DZ","Mk48_CCO_DZ","Mk48_DZ","Mk48_Holo_DZ","Mk48_DES_CCO_DZ","PKM_DZ","Pecheneg_DZ","UK59_DZ","RPK74_Kobra_DZ","RPK74_DZ","RPK74_PSO1_DZ","L86A2_LSW_DZ"];
WAI_TWS 			= 	["RSASS_TWS_DZ","RSASS_TWS_SD_DZ","XM2010_TWS_DZ","XM2010_TWS_SD_DZ","MSR_TWS_DZ","MSR_TWS_SD_DZ","AKS_74_GOSHAWK","BAF_AS50_TWS","BAF_L85A2_RIS_TWS_DZ","M249_TWS_EP1_Small","m107_TWS_EP1_Small","m8_tws","m8_tws_sd","SCAR_L_STD_EGLM_TWS","SCAR_H_STD_TWS_SD","M110_TWS_EP1","ACR_WDL_TWS_GL_DZ","ACR_WDL_TWS_SD_DZ","ACR_WDL_TWS_GL_SD_DZ","ACR_WDL_TWS_DZ","ACR_BL_TWS_DZ","ACR_BL_TWS_GL_DZ","ACR_BL_TWS_SD_DZ","ACR_BL_TWS_GL_SD_DZ","ACR_DES_TWS_DZ","ACR_DES_TWS_GL_DZ","ACR_DES_TWS_SD_DZ","ACR_DES_TWS_GL_SD_DZ","ACR_SNOW_TWS_DZ","ACR_SNOW_TWS_GL_DZ","ACR_SNOW_TWS_SD_DZ","ACR_SNOW_TWS_GL_SD_DZ"];
WAI_RandomWeapon 	= 	[WAI_AK,WAI_RK95,WAI_Groza,WAI_Scar,WAI_Sniper,WAI_G36,WAI_M4,WAI_HK416,WAI_SteyrAug,WAI_HK53,WAI_MagpulPDR,WAI_Famas,WAI_ACR,WAI_KAC,WAI_Tavor,WAI_Masada,WAI_MK16,WAI_XM8,WAI_M14,WAI_HK417,WAI_MK14,WAI_MK17,WAI_CZ805,WAI_Shotgun,WAI_SVD,WAI_Mosin,WAI_M16,WAI_SA58,WAI_L85,WAI_SMG,WAI_LMG];

// Массив ПТ и ПВО оружий
WAI_LaunchersAT 	= 	["M136","RPG18","JAVELIN"];
WAI_LaunchersAA 	= 	["Strela","Igla","STINGER"];

// Массив Рюкзаков
WAI_Packs 			= 	["Patrol_Pack_DZE1","GymBag_Camo_DZE1","GymBag_Green_DZE1","Czech_Vest_Pouch_DZE1","Assault_Pack_DZE1","TerminalPack_DZE1","TinyPack_DZE1","ALICE_Pack_DZE1","TK_Assault_Pack_DZE1","School_Bag_DZE1","CompactPack_DZE1","British_ACU_DZE1","GunBag_DZE1","PartyPack_DZE1","NightPack_DZE1","SurvivorPack_DZE1","AirwavesPack_DZE1","CzechBackpack_DZE1","CzechBackpack_Camping_DZE1","CzechBackpack_OD_DZE1","CzechBackpack_DES_DZE1","CzechBackpack_3DES_DZE1","CzechBackpack_WDL_DZE1","CzechBackpack_MAR_DZE1","CzechBackpack_DMAR_DZE1","CzechBackpack_UCP_DZE1","CzechBackpack_6DES_DZE1","CzechBackpack_TAK_DZE1","CzechBackpack_NVG_DZE1","CzechBackpack_BLK_DZE1","CzechBackpack_DPM_DZE1","CzechBackpack_FIN_DZE1","CzechBackpack_MTC_DZE1","CzechBackpack_NOR_DZE1","CzechBackpack_WIN_DZE1","CzechBackpack_ATC_DZE1","CzechBackpack_MTL_DZE1","CzechBackpack_FTN_DZE1","WandererBackpack_DZE1","LegendBackpack_DZE1","CoyoteBackpack_DZE1","CoyoteBackpackDes_DZE1","CoyoteBackpackWdl_DZE1","CoyoteBackpack_Camping_DZE1","LargeGunBag_DZE1"];
WAI_PacksUpgraded 	= 	["Patrol_Pack_DZE2","GymBag_Camo_DZE2","GymBag_Green_DZE2","Czech_Vest_Pouch_DZE2","Assault_Pack_DZE2","TerminalPack_DZE2","TinyPack_DZE2","ALICE_Pack_DZE2","TK_Assault_Pack_DZE2","School_Bag_DZE2","CompactPack_DZE2","British_ACU_DZE2","GunBag_DZE2","PartyPack_DZE2","NightPack_DZE2","SurvivorPack_DZE2","AirwavesPack_DZE2","CzechBackpack_DZE2","CzechBackpack_Camping_DZE2","CzechBackpack_OD_DZE2","CzechBackpack_DES_DZE2","CzechBackpack_3DES_DZE2","CzechBackpack_WDL_DZE2","CzechBackpack_MAR_DZE2","CzechBackpack_DMAR_DZE2","CzechBackpack_UCP_DZE2","CzechBackpack_6DES_DZE2","CzechBackpack_TAK_DZE2","CzechBackpack_NVG_DZE2","CzechBackpack_BLK_DZE2","CzechBackpack_DPM_DZE2","CzechBackpack_FIN_DZE2","CzechBackpack_MTC_DZE2","CzechBackpack_NOR_DZE2","CzechBackpack_WIN_DZE2","CzechBackpack_ATC_DZE2","CzechBackpack_MTL_DZE2","CzechBackpack_FTN_DZE2","WandererBackpack_DZE2","LegendBackpack_DZE2","CoyoteBackpack_DZE2","CoyoteBackpackDes_DZE2","CoyoteBackpackWdl_DZE2","CoyoteBackpack_Camping_DZE2","LargeGunBag_DZE2"];
WAI_PacksLg 		= 	["LegendBackpack_DZE1","CoyoteBackpack_DZE1","CoyoteBackpackDes_DZE1","CoyoteBackpackWdl_DZE1","CoyoteBackpack_Camping_DZE1","LargeGunBag_DZE1","LegendBackpack_DZE2","CoyoteBackpack_DZE2","CoyoteBackpackDes_DZE2","CoyoteBackpackWdl_DZE2","CoyoteBackpack_Camping_DZE2","LargeGunBag_DZE2"];
WAI_PacksAll 		= 	["Patrol_Pack_DZE1","GymBag_Camo_DZE1","GymBag_Green_DZE1","Czech_Vest_Pouch_DZE1","Assault_Pack_DZE1","TerminalPack_DZE1","TinyPack_DZE1","ALICE_Pack_DZE1","TK_Assault_Pack_DZE1","School_Bag_DZE1","CompactPack_DZE1","British_ACU_DZE1","GunBag_DZE1","PartyPack_DZE1","NightPack_DZE1","SurvivorPack_DZE1","AirwavesPack_DZE1","CzechBackpack_DZE1","CzechBackpack_Camping_DZE1","CzechBackpack_OD_DZE1","CzechBackpack_DES_DZE1","CzechBackpack_3DES_DZE1","CzechBackpack_WDL_DZE1","CzechBackpack_MAR_DZE1","CzechBackpack_DMAR_DZE1","CzechBackpack_UCP_DZE1","CzechBackpack_6DES_DZE1","CzechBackpack_TAK_DZE1","CzechBackpack_NVG_DZE1","CzechBackpack_BLK_DZE1","CzechBackpack_DPM_DZE1","CzechBackpack_FIN_DZE1","CzechBackpack_MTC_DZE1","CzechBackpack_NOR_DZE1","CzechBackpack_WIN_DZE1","CzechBackpack_ATC_DZE1","CzechBackpack_MTL_DZE1","CzechBackpack_FTN_DZE1","WandererBackpack_DZE1","LegendBackpack_DZE1","CoyoteBackpack_DZE1","CoyoteBackpackDes_DZE1","CoyoteBackpackWdl_DZE1","CoyoteBackpack_Camping_DZE1","LargeGunBag_DZE1","Patrol_Pack_DZE2","GymBag_Camo_DZE2","GymBag_Green_DZE2","Czech_Vest_Pouch_DZE2","Assault_Pack_DZE2","TerminalPack_DZE2","TinyPack_DZE2","ALICE_Pack_DZE2","TK_Assault_Pack_DZE2","School_Bag_DZE2","CompactPack_DZE2","British_ACU_DZE2","GunBag_DZE2","PartyPack_DZE2","NightPack_DZE2","SurvivorPack_DZE2","AirwavesPack_DZE2","CzechBackpack_DZE2","CzechBackpack_Camping_DZE2","CzechBackpack_OD_DZE2","CzechBackpack_DES_DZE2","CzechBackpack_3DES_DZE2","CzechBackpack_WDL_DZE2","CzechBackpack_MAR_DZE2","CzechBackpack_DMAR_DZE2","CzechBackpack_UCP_DZE2","CzechBackpack_6DES_DZE2","CzechBackpack_TAK_DZE2","CzechBackpack_NVG_DZE2","CzechBackpack_BLK_DZE2","CzechBackpack_DPM_DZE2","CzechBackpack_FIN_DZE2","CzechBackpack_MTC_DZE2","CzechBackpack_NOR_DZE2","CzechBackpack_WIN_DZE2","CzechBackpack_ATC_DZE2","CzechBackpack_MTL_DZE2","CzechBackpack_FTN_DZE2","WandererBackpack_DZE2","LegendBackpack_DZE2","CoyoteBackpack_DZE2","CoyoteBackpackDes_DZE2","CoyoteBackpackWdl_DZE2","CoyoteBackpack_Camping_DZE2","LargeGunBag_DZE2"];

// Массив Техники
WAI_ArmedVeh 			= 	["ArmoredSUV_PMC_DZE","GAZ_Vodnik_DZE","HMMWV_M1151_M2_CZ_DES_EP1_DZE","HMMWV_M998A2_SOV_DES_EP1_DZE","LandRover_MG_TK_EP1_DZE","LandRover_Special_CZ_EP1_DZE","Offroad_DSHKM_Gue_DZE","UAZ_MG_TK_EP1_DZE","Pickup_PK_GUE_DZE","Pickup_PK_INS_DZE","Pickup_PK_TK_GUE_EP1_DZE","BAF_Jackal2_L2A1_D_DZE","BAF_Jackal2_L2A1_W_DZE","BTR40_MG_TK_INS_EP1_DZE","HMMWV_Armored_DZE","HMMWV_M1114_DSHKM_ACR_DZE","UAZ_MG_WINTER_DZE","HMMWV_GPK_M2_WINTER_DZE","BTR40_MG_TK_GUE_EP1_DZE","ArmoredSUV_PKT_DZE","HMMWV_M1114_AGS_ACR_DZE","Dingo_WDL_ACR_DZE","Dingo_DST_ACR_DZE","UAZ_AGS30_TK_EP1_DZE","UAZ_MG_RUST_EP1_DZE","HMMWV_DES_MK19_DZE","UAZ_AGS30_RUST_DZE","HMMWV_M2_DZE","HMMWV_Winter_Armored_DZE","T810A_PKT_DES_ACR_DZE","T810A_PKT_ACR_DZE","BAF_Jackal2_GMG_D_DZE","BAF_Jackal2_GMG_W_DZE","Dingo_GL_Wdl_ACR_DZE","Dingo_GL_DST_ACR_DZE","HMMWV_MK19_DZE","UAZ_AGS30_WINTER_DZE"];
WAI_UnarmedTrackedVeh 	= 	["M113Ambul_TK_EP1_DZE1","M113Ambul_UN_EP1_DZE1","BMP2_Ambul_CDF_DZE","BMP2_Ambul_Winter_DZE","BMP2_Ambul_INS_DZE"];
WAI_APC 				= 	["LAV25_HQ_DZE","M113_UN_EP1_DZE","M113_TK_EP1_DZE","BRDM2_HQ_WINTER_DZE","BRDM2_WINTER_DZE","BRDM2_RUST_DZE","BRDM2_TK_EP1_DZE","BMP2_HQ_INS_DZE","BMP2_HQ_CDF_DZE","BMP2_HQ_TK_EP1_DZE","BRDM2_Desert_ACR_DZE","BTR60_TK_EP1_DZE","BTR90_HQ_DZE","BTR60_Gue_DZE","BRDM2_HQ_RUST_DZE","BRDM2_CDF_DZE","BRDM2_HQ_CDF_DZE","BRDM2_TK_GUE_EP1_DZE"];
WAI_ArmedHeli 			= 	["CH_47F_EP1_DZE","CH_47F_EP1_Black_DZE","CH_47F_EP1_GREY_DZE","CH_47F_EP1_DES_DZE","UH1H_DZE","Mi17_DZE","UH60M_EP1_DZE","UH1Y_DZE","MH60S_DZE","Ka60_GL_PMC_DZE","AW159_Lynx_BAF_DZE","UH1H_2_DZE","UH1H_CDF_DZE","pook_transport_DZE","pook_gunship_DZE","Mi17_TK_EP1_DZE","Mi17_UN_CDF_EP1_DZE","Mi17_CDF_DZE","Mi171Sh_CZ_EP1_DZE","Mi17_DES_DZE","Mi17_GREEN_DZE","Mi17_BLUE_DZE","Mi17_BLACK_DZE","Mi17_RUST_DZE","Mi17_WINTER_DZE","UH1H_WD_DZE","UH1H_DES_DZE","UH1H_GREY_DZE","UH1H_BLACK_DZE","UH1H_SAR_DZE","UH1H_WINTER_DZE","UH1Y_M240_DZE","AH6J_EP1_DZE","pook_gunship_m134_DZE","pook_gunship_CDF_DZE","pook_gunship_CDF_m134_DZE","pook_gunship_DZE","pook_transport_DZE","pook_transport_CDF_DZE"];
WAI_CivilHeli 			= 	["AH6X_DZ","BAF_Merlin_DZE","MH6J_DZ","Mi17_Civilian_DZ","MTVR_Bird_DZE","pook_H13_civ_DZE","UH60M_MEV_EP1_DZ","CH53_DZE","pook_H13_civ_white_DZE","pook_H13_civ_slate_DZE","pook_H13_civ_black_DZE","pook_H13_civ_yellow_DZE","CSJ_GyroC_DZE","pook_medevac_DZE","pook_medevac_CDF_DZE","pook_medevac_CIV_DZE"];
WAI_MilUnarmed 			= 	["GAZ_Vodnik_MedEvac_DZE","HMMWV_Ambulance_DZE","HMMWV_Ambulance_CZ_DES_EP1_DZE","HMMWV_DES_EP1_DZE","HMMWV_DZ","HMMWV_M1035_DES_EP1_DZE","LandRover_CZ_EP1_DZE","LandRover_TK_CIV_EP1_DZE","UAZ_CDF_DZE","UAZ_INS_DZE","UAZ_RU_DZE","UAZ_Unarmed_TK_CIV_EP1_DZE","UAZ_Unarmed_TK_EP1_DZE","UAZ_Unarmed_UN_EP1_DZE","LandRover_Ambulance_ACR_DZE"];
WAI_CargoTruck 			= 	["Ural_INS_DZE","Ural_CDF_DZE","UralOpen_CDF_DZE","Ural_TK_CIV_EP1_DZE","Ural_UN_EP1_DZE","UralCivil_DZE","UralCivil2_DZE","UralSupply_TK_EP1_DZE","UralReammo_CDF_DZE","UralReammo_INS_DZE","UralRepair_CDF_DZE","UralRepair_INS_DZE","V3S_Open_TK_CIV_EP1_DZE","V3S_Open_TK_EP1_DZE","V3S_Civ_DZE","V3S_TK_EP1_DZE","V3S_Camper_DZE","V3S_RA_TK_GUE_EP1_DZE","Kamaz_DZE","KamazOpen_DZE","KamazRepair_DZE","KamazReammo_DZE","MTVR_DES_EP1_DZE","MTVR_DZE","MTVR_Open_DZE","MtvrRepair_DZE","MtvrReammo_DZE","T810A_ACR_DZE","T810A_ACR_DES_DZE","T810A_ACR_OPEN_DZE","T810A_ACR_DES_OPEN_DZE","T810_ACR_REAMMO_DZE","T810_ACR_REAMMO_DES_DZE","T810_ACR_REPAIR_DZE","T810_ACR_REPAIR_DES_DZE"];
WAI_RefuelTruck 		= 	["KamazRefuel_DZ","MtvrRefuel_DES_EP1_DZ","UralRefuel_TK_EP1_DZ","V3S_Refuel_TK_GUE_EP1_DZ","T810A_ACR_REFUEL_DZE","T810A_ACR_REFUEL_DES_DZE"];
WAI_CivilVeh 			= 	["hilux1_civil_1_open_DZE","hilux1_civil_2_covered_DZE","hilux1_civil_3_open_DZE","SUV_Blue","SUV_Camo","SUV_Charcoal","SUV_Green","SUV_Orange","SUV_Pink","SUV_Red","SUV_Silver","SUV_TK_CIV_EP1_DZE","SUV_White","SUV_Yellow","Jeep_DZE","Tractor_Armored_DZE","ScrapAPC_DZE"];

// Массив видов Ящиков
WAI_CrateLg 	= 	["DZ_AmmoBoxBigUS","DZ_AmmoBoxBigRU"];
WAI_CrateMd 	= 	["DZ_AmmoBoxMedium1US","DZ_AmmoBoxMedium2US","DZ_AmmoBoxLong2RU","DZ_AmmoBoxLongGUE"];
WAI_CrateSm 	= 	["DZ_AmmoBoxSmallUS","DZ_AmmoBoxFlatUS","DZ_AmmoBoxSmallRU","DZ_AmmoBoxSmallUN","DZ_AmmoBoxSmallGUE"];

local _bloodbag 	= 	["bloodBagONEG","ItemBloodbag"] select dayz_classicBloodBagSystem;

// Массив Предметов
WAI_Chainsaws 		= 	["ChainSaw","ChainSawB","ChainSawG","ChainSawP","ChainSawR"];
WAI_ToolsAll 		= 	["ItemKeyKit","Binocular","Binocular_Vector","ItemCompass","ItemCrowbar","ItemEtool","ItemFishingPole","ItemFlashlightRed","ItemGPS","ItemHatchet","ItemKnife","ItemMachete","ItemMatchbox","ItemToolbox","NVGoggles_DZE","ItemSolder_DZE","ItemRadio","Hammer_DZE","ItemSledge","Handsaw_DZE"];
WAI_ToolsBuildable 	= 	["ItemToolbox","ItemEtool","ItemCrowbar","ItemKnife","Hammer_DZE","ItemSledge","Handsaw_DZE"];
WAI_BaseAddons 		= 	["outhouse_kit","cook_tripod_kit","stoneoven_kit","commode_kit","wardrobe_kit","fridge_kit","washing_machine_kit","server_rack_kit","atm_kit","armchair_kit","sofa_kit","arcade_kit","vendmachine1_kit","vendmachine2_kit","storage_crate_kit","camo_storage_crate_kit","ItemTent","ItemTentWinter","ItemDomeTent","ItemWinterDomeTent","ItemDesertTent","ItemFireBarrel_kit","workbench_kit","advanced_workBench_kit","fuel_pump_kit","light_pole_kit","deer_stand_kit","rusty_gate_kit","stick_fence_kit","sun_shade_kit","park_bench_kit","ItemScaffoldingKit","notebook_kit","water_pump_kit","greenhouse_kit","bed_kit","table_kit","office_chair_kit","garage_green_kit","garage_white_kit","garage_brown_kit","garage_grey_kit","helipad_civil_kit","helipad_rescue_kit","helipad_army_kit","helipad_cross_kit","helipad_parkborder_kit","cctv_kit","storage_shed_kit","ItemGunRackKit","ItemWoodCrateKit"];
WAI_HighValue 		= 	["ItemBriefcase100oz","ItemVault","plot_pole_kit","ItemHotwireKit","ItemVault2","ItemTallSafe","ItemLockbox","ItemLockbox2","ItemLockboxWinter","ItemLockboxWinter2"];
WAI_Food 			= 	["FoodCanBakedBeans","FoodCanFrankBeans","FoodCanPasta","FoodCanSardines","FoodCanBeef","FoodCanPotatoes","FoodCanGriff","FoodCanBadguy","FoodCanBoneboy","FoodCanCorn","FoodCanCurgon","FoodCanDemon","FoodCanFraggleos","FoodCanHerpy","FoodCanDerpy","FoodCanOrlok","FoodCanPowell","FoodCanTylers","FoodCanUnlabeled","FoodCanRusUnlabeled","FoodCanRusStew","FoodCanRusPork","FoodCanRusPeas","FoodCanRusMilk","FoodCanRusCorn","FoodChipsSulahoops","FoodChipsMysticales","FoodChipsChocolate","FoodCandyChubby","FoodCandyAnders","FoodCandyLegacys","FoodCakeCremeCakeClean","FoodCandyMintception","FoodPistachio","FoodNutmix","FoodMRE","FoodbaconCooked","FoodbeefCooked","FoodchickenCooked","FoodGoatCooked","FoodmuttonCooked","FoodrabbitCooked","FishCookedTrout","FishCookedSeaBass","FishCookedTuna"];
WAI_Drink 			= 	["ItemSodaCoke","ItemSodaPepsi","ItemSodaMdew","ItemSodaMtngreen","ItemSodaR4z0r","ItemSodaClays","ItemSodaSmasht","ItemSodaDrwaste","ItemSodaFranka","ItemSodaLemonade","ItemSodaLirik","ItemSodaLvg","ItemSodaMzly","ItemSodaPeppsy","ItemSodaRabbit","ItemSodaSacrite","ItemSodaRocketFuel","ItemSodaGrapeDrink","ItemSherbet","ItemSodaRbull","ItemSodaOrangeSherbet","ItemWaterbottle","ItemWaterBottleSafe","ItemWaterBottleBoiled","ItemWaterBottleHerbal","ItemPlasticWaterBottleSafe","ItemPlasticWaterBottleBoiled","ItemPlasticWaterBottleHerbal"];
WAI_Ikea 			= 	[["ItemPole",12],"forest_large_net_kit","ItemSandbagExLarge5X","ItemComboLock",["CinderBlocks",14],["MortarBucket",4],["ItemLightBulb",5],"bulk_ItemSandbag","bulk_ItemTankTrap","bulk_ItemWire","bulk_PartGeneric",["ItemConcreteBlock",4],["ItemRSJ",2],["ItemCorrugated",6]];
WAI_Parts 			= 	["PartEngine","PartFueltank",["PartGeneric",4],["PartGlass",3],"PartVRotor",["PartWheel",4],"ItemFuelcan","ItemJerrycan","ItemFuelBarrel"];
WAI_Medical 		= 	["ItemAntibiotic6","ItemEpinephrine","ItemHeatPack","ItemMorphine","ItemBandage","ItemAntibacterialWipe","ItemPainkiller6","ItemSepsisBandage","equip_woodensplint",_bloodbag];
WAI_VehAmmo 		= 	["100Rnd_127x99_M2","150Rnd_127x107_DSHKM","29Rnd_30mm_AGS30","50Rnd_127x107_DSHKM","48Rnd_40mm_MK19","200Rnd_762x54_PKT","1500Rnd_762x54_PKT"];
WAI_HeliAmmo 		= 	["200Rnd_762x51_M240","pook_12Rnd_Grenade_Camel","pook_1300Rnd_762x51_M60","3Rnd_GyroGrenade","pook_250Rnd_762x51"];
WAI_Presidents 		= 	["ItemDocument","ItemGoldBar10oz"];
WAI_Gems 			= 	["ItemRuby","ItemCitrine","ItemEmerald","ItemAmethyst","ItemSapphire","ItemObsidian","ItemTopaz"];
WAI_Hemp 			= 	["ItemKiloHemp"];
WAI_Wood 			= 	[["PartPlankPack",5],["PartPlywoodPack",10],["ItemWoodFloorQuarter",5],["ItemWoodStairs",2],["ItemWoodLadder",2],["ItemWoodWallThird",5],"ItemWoodWallGarageDoor",["ItemWoodWallLg",3],"ItemWoodWallWithDoorLg","wood_ramp_kit","ItemWoodFloor4x","ItemTriangleWoodFloor",["ItemWoodHandRail",5],"ItemWoodPillar","ItemTriangleWoodWall","ItemWoodGate","ItemWoodOpenTopGarageDoor","wooden_shed_kit","ItemWoodFloorStairs","wood_shack_kit",["equip_nails",6]];
WAI_Misc 			= 	["ItemGoldBar","ItemGoldBar10oz","desert_net_kit","forest_net_kit","winter_net_kit",["ItemCanvas",5],"ItemTent","ItemTentWinter","ItemDomeTent","ItemWinterDomeTent","ItemDesertTent","ItemTrapTripwireGrenade","ItemTrapTripwireSmoke","ItemTrapTripwireFlare",["equip_metal_sheet",5],["equip_floppywire",4],["equip_scrapelectronics",4],["ItemScrews",4],"equip_rope","ItemMixOil"];
WAI_ItemsRandom = [WAI_Food, WAI_Drink, WAI_Parts, WAI_Medical, WAI_VehAmmo, WAI_HeliAmmo, WAI_Hemp, WAI_BaseAddons, WAI_Misc];

/* КОНФИГ ЗАНЯТИЯ МИССИИ */
WAI_AutoClaim 			= 	false; 	// Включить функцию занятия миссий?
WAI_AcAlertDistance 	= 	1000; 	// Расстояние от миссии, которую Занятый игрок использует для оповещения ближайшего игрока
WAI_AcDelayTime 		= 	30; 	// Время, в течение которого Занятая миссия ожидает объявления запроса и размещения маркера (В секундах)
WAI_AcTimeout 			= 	60; 	// Время когда игрок покинул миссию и она станет Не занятой (в секундах)
/* КОНФИГ ЗАНЯТИЯ МИССИИ - Конец */

// Не трогать!
WAIconfigloaded = true;