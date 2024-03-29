diag_log "[DZAI]: [dzai_config.sqf]: Чтение файла конфигурации...";

/* 
	ВАЖНО: 
	- Скалирование урона можно найти в файле fn_damageHandlerAI2.sqf (Меняйте если знаете что делаете)
	- Для отладки Урона и Кол-во крови у ИИ расскомментируйте в файле fn_damageHandlerAI2.sqf строку 86
	- Проверку на вместимость инвентаря можно менять в ai_generate_loot.sqf строка 77.
	- Ряд функций имеет зависимость от других основных функции. Будьте внимательны где указаны комментарии.
	
	НОВОЕ:
	- Эти функции изначально были в DZAI, но без возможности конфигурации внутри конфиг файла.
*/



/* === DZAI Настройки === */
/*
	Вкл/Выкл отладку в arma2oaserver.rpt.
	Параметры: 0 - Отключено, 1 - Базовая отладка, 2 - Расширенная отладка.
	Включайте если нужно проверить новые параметры и правильность настройки, синтаксис и так далее.
*/
DZAI_debugLevel = 0;

/*
	Частота получения отладки (В секундах), (0 = отключить).
	Логгирует Макс. кол-во ИИ/Текущее кол-во ИИ, а так же динамические триггеры.
*/
DZAI_monitorRate = 0;

/*
	Вкл/Выкл проверку и исправление ошибок в таблицах ID предметов которые используют DZAI.
	Если ID будет неверен, то он удалится и выдаст лог в RPT.
	Рекомендуется true. Если ID будет неверным, то Клиент попытавшись считать ID с ИИ,
	То Клиент может вылететь из игры, либо просто поймать ошибку.
*/
DZAI_verifyTables = true;

/*
	(Функция в разработке и в целом работает, но допиливать ее никто не будет из авторов).
	Вкл/Выкл дополнительную проверку и исправление ошибок в определенных таблицах ID предметов.
	Не рекомендуется включать без особой надобности. Достаточно DZAI_verifyTables = true.
*/
DZAI_extendedVerify = false;

/*
	Вкл/Выкл чтобы серверная функция создания Объектов/Построек нормально создавалась на клиентах через DayZ CfgTownGenerator.
	Предотвращает Ходьбу/Стрельбу ИИ через кусты, объекты и т.д. которые используют CfgTownGenerator.
	ВАЖНО: true если DayZ Vanilla / false если DayZ Epoch!
*/
DZAI_objPatch = false;

/*
	Мин. время для очистки трупов/мусора/остовов техники (В секундах).
	Система не будет выполнять очистку если игрок рядом с трупами/мусором/остовами техники.
	ВАЖНО: Другие скрипты очистки ИИ/Трупов и т.д. могут принудительно выполнить удаление!
*/
DZAI_cleanupDelay = 900;

/*
	Вкл/Выкл проверку мода.
	В актуальное время остался только Epoch, так что оставьте true и не меняйте.
*/
DZAI_modAutoDetect = true;
/* === DZAI Настройки - Конец === */



/* === Настройки ИИ === */
/*
	Вкл/Выкл систему крови DayZ для ИИ. 
	Если true, то ИИ будут использовать DayZ систему крови (12000).
	Такие ИИ могут быть Оглушены, обездвижены и могут использовать медицину Epoch.
	Если false, то используется система Arma 2.
*/
DZAI_useHealthSystem = true;

/*
	Мин/Макс кол-во крови у ИИ при создании.
	Выбирается индивидуально и случайно в диапазоне для каждого ИИ. (Лимит: 12000 крови).
	ВАЖНО: Не влияет если DZAI_useHealthSystem = false.
*/
DZAI_unitBloodLevel = [5000,8000];

/*
	Кол-во крови, которое будет восстанавливаться до полного самоисцеления.
	Треть от общего количества восстанавливается 3 раза каждые 3 секунды. (Только для Пеших ИИ).
	ВАЖНО: Не влияет если DZAI_useHealthSystem = false.
*/
DZAI_unitHealAmount = 4000;

/*
	Below this blood level, AI may decide to heal themselves for amount specified by DZAI_unitHealAmount. Healing requires 9 seconds to fully complete and can be interrupted by knocking the unit unconscious. (Default: 5000)
	ВАЖНО: Не влияет если DZAI_useHealthSystem = false.
*/
DZAI_lowBloodLevel = 4000;

// NEW: Вкл/Выкл выдачу бинта гарантировано в каждого ИИ
DZAI_GuaranteedBandage = false;

/*
	Вкл\Выкл привлечение зомби выстрелами.
	Включение параметра может повлиять на производительность сервера т.к. скрипт будет выполняться на Каждый выстрел ИИ.
	ВАЖНО: Не влияет если DZAI_zombieEnemy = false (Смотрите ниже).
	ВАЖНО: Зомби не могут атаковать ИИ, но ИИ могут атаковать зомби. (Смотрите ниже).
*/
DZAI_weaponNoise = true;

/*
	Вкл/Выкл поиск убийцы ИИ.
	Если включено, то ИИ будут искать игрока который убил их товарища.
	Преследуемый игрок будет получать сообщения о его поиске (Смотри ниже).
	ВАЖНО: Не влияет если DZAI_staticAI = false.
*/
DZAI_findKiller = true;

// НОВОЕ: Таймер преследования игрока (В секундах)
// ВАЖНО: Не влияет если DZAI_findKiller = false.
DZAI_PursuitTimer = 180;

// НОВОЕ: Если игрок во время преследования убьет ИИ той же группы, то на сколько продлить таймер (В секундах).
// ВАЖНО: Не влияет если DZAI_findKiller = false.
DZAI_AddPursuitTimer = 30;

// Вкл/Выкл сообщения о преследовании игрока.
DZAI_radioMsgs = false;

// НОВОЕ: Расстояние для отправки радио-сообщений игроку (В метрах).
// ВАЖНО: Не влияет если DZAI_findKiller = false.
DZAI_TransmitRange = 150;

// НОВОЕ: Расстояние для передачи информации Лидера ИИ своим согруппникам.
// ВАЖНО: Не влияет если DZAI_findKiller = false.
DZAI_ReceiveDistance = 250;

/*
	Выдавать временное ПНВ.
	Если включено, то ИИ в Ночное время и с уровнем лута от Weapongrade 1 и Выше будет выдано временное ПНВ.
	Как только ИИ умрет - ПНВ удалиться из его инвентаря.
*/
DZAI_tempNVGs = false;

// Кол-во хуманити за убийство ИИ (Может быть отрицательным).
DZAI_humanityGain = 0;

/*
	Усиление последнего ИИ из группы.
	Если включено, то оставшийся последний выживший ИИ в каждой из групп получит прибавку к его Умениям.
	ВАЖНО: Не работает если ИИ изначально появился один.
*/
DZAI_lastManStanding = false;

/*
	Выдача денег на каждого ИИ.
	Параметры: [Вкл/Выкл,[Мин. кол-во денег,Макс. кол-во денег]];
	ВАЖНО: Работает только если Z_SingleCurrency = true; (ConfigVariables.sqf)
*/
DZAI_hasCoins = [true,[7,100]];
/* === Настройки ИИ - Конец === */



/* === Настройки ИИ КЛИЕНТ === */
// **ВНИМАНИЕ**: Параметры выставленные тут должны быть точно так же быть установлены в Миссии 1 в 1. (Scripts\DZAIClient\dzai_client_config.sqf)

// Использовать Клиент-Аддон для передачи сообщений игроку через аддон вместо удаленных запросов с сервера?
// Оставьте false если у сервера нет проблем с пропускной способностью.
DZAI_clientRadio = false;

// ИИ атакуют зомби?.
// Если включено, то ИИ будут атаковать зомби рядом с ними.
DZAI_zombieEnemy = true;

// Макс. дистанция когда лидер группы ИИ увидит зомби и отдаст приказ стрелять. (В метрах).
// ВНИМАНИЕ: Увеличение параметра больше чем по умолчанию может негативно сказаться на производительности сервера. (По умолчанию: 150)
DZAI_zDetectRange = 100;

/*
	Вкл/Выкл сообщения об убистве.
	Игрок будет получать сообщения об убистве каждого ИИ отдельно. 
	Сообщения будут использовать SystemChat в формате: "(Имя ИИ) был убит."
*/
DZAI_deathMessages = false;									
/* === Настройки ИИ КЛИЕНТ - Конец === */



/* === Настройки Статичных ИИ === */
// Вкл/Выкл статичные ИИ. (Координаты для ИИ прописаны в файле!)
// Если включено то ИИ будут появляться в деревнях, городах, больших территориях и так далее.
DZAI_staticAI = true;

// Мин. и макс. время переспавна ботов после их убийства на территории. (В секундах).						
DZAI_respawnTimeMin = 2400;
DZAI_respawnTimeMax = 3600;

// Время до удаления ИИ когда игрок вышел с Триггера ИИ (В секундах).
DZAI_despawnWait = 900;

// Лимит переспавна ИИ.
// Установите -1 чтобы отключить лимит.
DZAI_respawnLimit0 = 4; 	// Для Легких ИИ которые появляются в деревнях и малых территориях.
DZAI_respawnLimit1 = 3; 	// Для Средних ИИ которые появляются в городах и больших территориях.
DZAI_respawnLimit2 = 2; 	// Для Сложных ИИ которые появляются на военных территориях.
DZAI_respawnLimit3 = 1; 	// Для Эксперт ИИ которые появляются на военных территориях где очень много хорошего лута.

// Шанс спавна ИИ (0 - 100. Процент).
DZAI_spawnChance0 = 0.27;	// Для Легких ИИ которые появляются в деревнях и малых территориях.
DZAI_spawnChance1 = 0.38;	// Для Средних ИИ которые появляются в городах и больших территориях.
DZAI_spawnChance2 = 0.49;	// Для Сложных ИИ которые появляются на военных территориях.
DZAI_spawnChance3 = 0.60;	// Для Эксперт ИИ которые появляются на военных территориях где очень много хорошего лута.
/* === Настройки Статичных ИИ - Конец === */



/* === Настройки Динамичных ИИ === */
// Вкл/Выкл Динамичные ИИ. 
// Если включено, то случайный игрок будет спавнить рядом случайное кол-во ботов.
DZAI_dynAISpawns = false;

// Время которое должно пройти для Максимальной шанс спавна ИИ возле игрока. (В секундах).
// Меньшее число = более частые появления, Большее число = реже. (Рекомендуемые значения: 1200-2700).
DZAI_maxSpawnTime = 1200;

// Время позволяющее каждому игроку сохранить Максимальный шанс спавна. (В секундах).
DZAI_keepMaxSpawnTime = 1200;

//Probability for dynamic AI to actively hunt a targeted player. If probability check fails, dynamic AI will patrol the area instead of hunting
DZAI_huntingChance = 0.50;

// НОВОЕ: Расстояние от точки появления ДИНАМИЧЕСКИХ ИИ от которой ИИ могут отходить для преследования игрока (В метрах).
// ВАЖНО: Не влияет если DZAI_dynAISpawns = false;
DZAI_SeekRange = 300;

//Probability to send first available AI helicopter to reinforce dynamic AI group. No effect if DZAI_maxHeliPatrols is set to zero.
DZAI_heliReinforceChance = 0.1;

//Array of area blacklist markers. Players within marker areas will not be targeted for dynamic AI spawns (Example: ["BlacklistArea1","BlacklistArea2","BlacklistArea3"])
//Epoch: DZAI will automatically set up 200m-radius blacklist areas around each trader area.
DZAI_dynAreaBlacklist = [];

//Time to wait before despawning all AI units in dynamic spawn area when no players are present. (Default: 120)
DZAI_dynDespawnWait = 120;

//Enable or disable dynamic spawn-free zones of 600m radius around player spawn areas. (Default: false)
DZAI_freshSpawnSafeArea = true;

// NEW:
DZAI_FreshSpawnRaduis = 800;


/*	Random AI Spawning Settings (Feature in development) */

//Maximum number of placed random spawns on map
DZAI_maxRandomSpawns = 0;

//Time to wait before despawning all AI units in random spawn area when no players are present. (Default: 120)
DZAI_randDespawnWait = 1800;

//Array of area blacklist markers. Players within marker areas will not be targeted for random AI spawns (Example: ["BlacklistArea1","BlacklistArea2","BlacklistArea3"])
//Epoch: DZAI will automatically set up 200m-radius blacklist areas around each trader area.
//Tip: To use dynamic-spawn blacklist areas for random-spawn blacklist areas, simply set DZAI_randAreaBlacklist = DZAI_dynAreaBlacklist;
DZAI_randAreaBlacklist = DZAI_dynAreaBlacklist;


/*	AI Air vehicle patrol settings. */

//Global maximum number of active AI air vehicle patrols. Set at 0 to disable (Default: 0).							
DZAI_maxHeliPatrols = 0;

//Set minimum and maximum wait time in seconds to respawn an AI vehicle patrol after vehicle is destroyed or disabled. (Default: Min 600, Max 900).
DZAI_respawnTMinA = 600;
DZAI_respawnTMaxA = 900;

//Classnames of air vehicle types to use, with the maximum amount of each type to spawn.
DZAI_heliList = [
	//["UH1H_DZ",5],
	//["Mi17_DZ",5]
];

//Difficulty level of air vehicle patrol units. Difficulty level also affects unit loadout and loot. Possible values: 0 to 3 (Default: 3)
DZAI_heliUnitLevel = 3;

//Maximum number of gunner units per air vehicle. Limited by actual number of available gunner positions. (Default: 2)
DZAI_heliGunnerUnits = 3;

//Specify vehicle weapon for air vehicles that are unarmed by default. DZAI will arm these air vehicles with the specified weapons upon spawning each vehicle.
//Weapon classnames are verified. If the classname is invalid (banned or nonexistent), it will not be added to the vehicle.
//Format: Each row containing a vehicle classname will be equipped with the weapon from the corresponding row in weapon classnames section. DZAI will automatically select ammo type.
DZAI_airWeapons = [
	//Air vehicle classnames (Remember: no comma for last entry! Otherwise, separate each string with commas)
	//["Helicopter1_Example_Classname","Helicopter2_Example_Classname"]
	//,
	//Corresponding weapon classnames (Remember: no comma for last entry! Otherwise, separate each string with commas)
	//["Helicopter1_Example_Weapon","Helicopter2_Example_Weapon"]
];


/*AI Land vehicle patrol settings. These AI vehicles will randomly travel between different cities and towns. */

//Global maximum number of active AI land vehicle patrols. Set at 0 to disable (Default: 0).
DZAI_maxLandPatrols = 6;

//Set minimum and maximum wait time in seconds to respawn an AI vehicle patrol after vehicle is destroyed or disabled. (Default: Min 600, Max 900).
DZAI_respawnTMinL = 1800;
DZAI_respawnTMaxL = 3600;

//Classnames of land vehicle types to use, with the maximum amount of each type to spawn.
DZAI_vehList =
[
	 ["TT650_Civ_DZE",			3]
	,["TT650_Ins_DZE",			3]
	,["ATV_CZ_EP1_DZE",			3]
	,["Tractor_DZE",			3]
	,["TractorOld_DZE",			3]
	,["Tractor_Armored_DZE",	3]

	,["VWGolf_DZE",				2]
	//,["Mini_Cooper_DZE",		2] 	// Сломанные стекла (Не рекомендуется включать!)
	,["Skoda_DZE",				2]
	,["SkodaBlue_DZE",			2]
	,["SkodaRed_DZE",			2]
	,["SkodaGreen_DZE",			2]
	,["Lada1_DZE",				2]
	,["Lada2_DZE",				2]
	,["LadaLM_DZE",				2]
	,["GLT_M300_LT_DZE",		2]
	,["GLT_M300_ST_DZE",		2]
	,["car_hatchback_DZE",		2]
	,["car_hatchback_red_DZE",	2]
	,["car_sedan_DZE",			2]

	,["UAZ_RU_DZE",				1]
	,["UAZ_CDF_DZE",			1]
	,["UAZ_INS_DZE",			1]
	,["Jeep_DZE",				1]
	,["Hummer_DZE",				1]
	,["HMMWV_Ambulance_DZE",	1]
	,["Ikarus_White_DZE",		1]
	,["Ikarus_Armored_DZE",		1]
	
	,["SUV_Camo",				1]
	,["SUV_Blue",				1]
	,["SUV_Green",				1]
	,["SUV_Yellow", 			1]
	,["SUV_Red",				1]
	,["SUV_White", 				1]
	,["SUV_Pink",				1]
	,["SUV_Charcoal",			1]
	,["SUV_Orange",				1]
	,["SUV_Silver",				1]
	,["SUV_TK_CIV_EP1_DZE",		1]

	,["BTR40_TK_GUE_EP1_DZE",		1]
	,["BTR40_TK_INS_EP1_DZE",		1]
	,["BTR40_MG_TK_GUE_EP1_DZE",	1]
	,["BTR40_MG_TK_INS_EP1_DZE",	1]
	,["UAZ_MG_CDF_DZE",				1]
	,["UAZ_MG_INS_DZE",				1]
];

//Difficulty level of land vehicle patrol units. Difficulty level also affects unit loadout and loot. Possible values: 0 to 3 (Default: 3)
DZAI_vehUnitLevel = 1;

//Maximum number of gunner units per land vehicle. Limited by actual number of available gunner positions. (Default: 1)
DZAI_vehGunnerUnits = 1;

//Maximum number of cargo units per land vehicle. Limited by actual number of available cargo positions. (Default: 3)
DZAI_vehCargoUnits = 3;


/*	AI Vehicle (Air & Land) Settings */

//Array of area blacklist markers. Areas covered by marker will not be used as waypoints for vehicle patrols. (Example: ["BlacklistArea1","BlacklistArea2","BlacklistArea3"])
//Note: Vehicles may still pass through these areas but will not make stops unless enemies are encountered.
DZAI_waypointBlacklist = ["Allies1","Allies2","Allies3","Allies4"];


/*	AI weapon selection settings */

//True: Dynamically generate AI weapon list from CfgBuildingLoot (DayZ loot tables). False: Use preset weapon tables located near the end of this file. (Default: true).
//Highly recommended to enable DZAI_verifyTables if this option is set to false. 
DZAI_dynamicWeaponList = true;

//Determines whether DZAI reads from default DayZ loot tables for dynamic AI weapon generation or from user-installed custom loot tables. (Default: false)
//No effect if DZAI_dynamicWeaponList is 'false'. If DZAI is unable to find custom loot tables installed, default loot tables will be used instead. If no loot tables are found, DZAI will use prebuilt weapon tables.
DZAI_customLootTables = true;

//List of classnames of weapons that AI should never use. By default, AI may carry any lootable weapon. (Only if DZAI_dynamicWeaponList = true)
//Example: DZAI_banAIWeapons = ["M107_DZ","BAF_AS50_scoped"] will remove the M107 and AS50 from AI weapon tables if dynamic weapon list is enabled.
//Note: It is recommended to add all melee weapon classnames into this list as AI have issues using melee weapons.
//Pre-banned weapons by DZAI: "Crossbow_DZ","Crossbow","MeleeHatchet","MeleeCrowbar","MeleeMachete","MeleeBaseball","MeleeBaseBallBat","MeleeBaseBallBatBarbed","MeleeBaseBallBatNails"
DZAI_banAIWeapons = [];

//List of launcher-type weapons for mid/high-level AI to use (by default, weapongrade 1/2/3), example: ["M136"]. If left empty, AI will not use launcher weapons. (Default: [])
//If AI encounter an armored player vehicle, they will switch to a randomly-selected launcher-type weapon to engage.
//Weapon classnames added here are verified if DZAI_verifyTables is set to true. Note: Launcher weapons are removed from the AI unit upon death.
DZAI_launcherTypes = [];	

//List of AI weapongrades that are permitted to use launcher-type weapons. Individual custom weapongrade levels may be added to allow launcher use (Default: [1,2,3])
DZAI_launcherLevels = [1,2,3];

//Limit of number of launcher-type weapons to add to each AI group. Groups cannot have more launcher weapons than their weapongrade value (Default: 1).
DZAI_launchersPerGroup = 0;


/*	AI loot quantity settings */

//Number of selections of medical items (Inventory)
DZAI_invmedicals = 2;

//Number of selections of edible items (Inventory)
DZAI_invedibles = 2;

//Number of selections of medical items (Backpack)
DZAI_bpmedicals = 1;

//Number of selections of edible items (Backpack)
DZAI_bpedibles = 1;

//Maximum number of items to select from DZAI_MiscItemS table.
DZAI_numMiscItemS = 3;

//Maximum number of items to select from DZAI_MiscItemL table.
DZAI_numMiscItemL = 1;


/*	AI loot probability settings */

//Chance to add each medical item.
DZAI_chanceMedicals = 0.30;	

//Chance to add each edible item.
DZAI_chanceEdibles = 0.20;

//Chance to add each random item from DZAI_MiscItemS table.
DZAI_chanceMiscItemS = 0.30;

//Chance to add each random item from DZAI_MiscItemL table.
DZAI_chanceMiscItemL = 0.15;


/*AI weapon/skill probabilities (gradeChances should add up to 1.00) - [Civilian, Military, MilitarySpecial, HeliCrash] - Note: AI with higher grade weaponry will also have higher skill settings. */

//equipType level 0 - most AI will have basic pistols or rifles, and occasionally common military weapons.
DZAI_gradeChances0 = [0.90,0.10,0.00,0.00];

//equipType level 1 - most AI will have common rifles, many will have common military weapons. Very rarely, AI will spawn with high-grade military or helicrash weapons.
DZAI_gradeChances1 = [0.65,0.30,0.04,0.01];

//equipType level 2 - most AI carry military weapons, and occasionally high-grade military weapons.
DZAI_gradeChances2 = [0.15,0.65,0.15,0.05];

//equipType level 3 - All AI will carry at least a military-grade weapon. Many will be carrying high-grade military weapons. Note: Air and land vehicle patrols use equipType level 3.
DZAI_gradeChances3 = [0.00,0.50,0.35,0.15];	

//equipType level "dynamic" - Weapongrade chances for dynamic-spawned AI. Majority of dynamic AI will be carrying low-grade military weapons, some will carry high-grade military.
DZAI_gradeChancesDyn = [0.00,0.88,0.09,0.03];

/*
	AI skill settings
	Skill Level: Description
	0-1: Low to medium-skilled AI. Most common type of AI encountered. Intended to challenge players.
	2-3: High-skilled AI. Uncommon/rare type of AI found in places with military loot. Intended to kill players.
	Hint: The best way to quickly adjust AI difficulty is by modifying aimingAccuracy value. For all skill types, higher number = better skill.
*/

//AI skill settings level 0 (Skill, Minimum skill, Maximum skill). Baseline skill level: 0.50
DZAI_skill0 = [	
	["aimingAccuracy",0.10,0.125],
	["aimingShake",0.20,0.29],
	["aimingSpeed",0.20,0.29],
	["endurance",0.20,0.29],
	["spotDistance",0.20,0.29],
	["spotTime",0.20,0.29],
	["courage",0.20,0.29],
	["reloadSpeed",0.20,0.29],
	["commanding",0.20,0.29],
	["general",0.30,0.39]
];

//AI skill settings level 1 (Skill, Minimum skill, Maximum skill). Baseline skill level: 0.60
DZAI_skill1 = [	
	["aimingAccuracy",0.125,0.15],
	["aimingShake",0.30,0.39],
	["aimingSpeed",0.30,0.39],
	["endurance",0.30,0.39],
	["spotDistance",0.60,0.39],
	["spotTime",0.30,0.39],
	["courage",0.30,0.39],
	["reloadSpeed",0.30,0.39],
	["commanding",0.40,0.49],
	["general",0.40,0.49]
];

//AI skill settings level 2 (Skill, Minimum skill, Maximum skill). Baseline skill level: 0.70
DZAI_skill2 = [	
	["aimingAccuracy",0.175,0.225],
	["aimingShake",0.40,0.49],
	["aimingSpeed",0.40,0.49],
	["endurance",0.40,0.49],
	["spotDistance",0.40,0.49],
	["spotTime",0.40,0.49],
	["courage",0.40,0.49],
	["reloadSpeed",0.40,0.49],
	["commanding",0.50,0.59],
	["general",0.50,0.59]
];

//AI skill settings level 3 (Skill, Minimum skill, Maximum skill). Baseline skill level: 0.80
DZAI_skill3 = [	
	["aimingAccuracy",0.225,0.250],
	["aimingShake",0.50,0.59],
	["aimingSpeed",0.50,0.59],
	["endurance",0.50,0.59],
	["spotDistance",0.50,0.59],
	["spotTime",0.50,0.59],
	["courage",0.50,0.59],
	["reloadSpeed",0.50,0.59],
	["commanding",0.60,0.69],
	["general",0.60,0.69]
];


/*
	Additional AI skill settings can be defined (DZAI_skill4 - DZAI_skill9) for the corresponding custom weapongrade level using the same format above.
	Note: If a custom weapongrade is used without defining the corresponding custom skill settings, DZAI_skill3 settings will be used instead.
	Instructions: replace "nil" with the skill array. Refer to the above preset skill arrays for examples.
	Custom AI skill settings can only be used with custom-defined spawns (spawns created using the DZAI_spawn function).
*/

//weapongrade 4 skills
DZAI_skill4 = nil; 

//weapongrade 5 skills
DZAI_skill5 = nil; 

//weapongrade 6 skills
DZAI_skill6 = nil; 

//weapongrade 7 skills
DZAI_skill7 = nil; 

//weapongrade 8 skills
DZAI_skill8 = nil;

//weapongrade 9 skills
DZAI_skill9 = nil; 


/*
	AI weapon, loot, and equipment settings
	DZAI will first load the classname tables defined below, the modify the settings according to the DayZ map/mod being run.
	Example: DZAI will always first load the classname tables defined below, then if DayZ Epoch is detected, DZAI will add or overwrite settings specified by \world_classname_configs\epoch\dayz_epoch.sqf.
*/

//Default weapon classname tables - DZAI will ONLY use these tables if the dynamic weapon list (DZAI_dynamicWeaponList) is disabled, otherwise they are ignored and overwritten if it is enabled.
//Note: Low-level AI (weapongrade 0) may use pistols listed in DZAI_Pistols0 or DZAI_Pistols1. Mid/high level AI (weapongrade 1+) will carry pistol weapons but not use them - they will use rifle weapons instead.

DZAI_Pistols0 = ["Makarov_DZ","M1911_DZ","Revolver_DZ"]; 				//Weapongrade 0 pistols
DZAI_Pistols1 = ["M9_DZ","M9_SD_DZ","Makarov_SD_DZ","PDW_DZ","G17_FL_DZ"]; 	//Weapongrade 1 pistols
DZAI_Pistols2 = ["M9_SD_DZ","Makarov_SD_DZ","PDW_DZ","G17_FL_DZ"]; 		//Weapongrade 2 pistols
DZAI_Pistols3 = ["M9_SD_DZ","Makarov_SD_DZ","PDW_DZ","G17_FL_DZ"]; 		//Weapongrade 3 pistols

DZAI_Rifles0 = ["LeeEnfield_DZ","Winchester1866_DZ","MR43_DZ","CZ550_DZ","LeeEnfield_DZ","Winchester1866_DZ","MR43_DZ"]; //Weapongrade 0 rifles
DZAI_Rifles1 = ["M16A4_DZ","AK74_DZ","M4A1_CCO_DZ","AK74_Kobra_DZ","AKS74U_DZ","AKM_DZ","M24_DZ","M1014_DZ","M4A1_DZ","M14_CCO_DZ","Remington870_FL_DZ","MP5_DZ","MP5_SD_DZ","M4A3_CCO_EP1"]; //Weapongrade 1 rifles
DZAI_Rifles2 = ["M16A4_DZ","M249_DZ","AK74_DZ","M4A1_CCO_DZ","AK74_Kobra_DZ","AKS74U_DZ","AKM_DZ","M1014_DZ","DMR_DZ","M4A1_DZ","M14_CCO_DZ","Remington870_FL_DZ","M240_DZ","M16A4_ACOG_DZ","Mk48_CCO_DZ","M4A3_DES_CCO_DZ","M40A3_Gh_DZ","SA58_DZ","SA58_DZ"]; //Weapongrade 2 rifles
DZAI_Rifles3 = ["FNFAL_DZ","FN_FAL_ANPVS4_DZE","Mk48_CCO_DZ","M249_DZ","L85_Holo_DZ","G36C_DZ","AKM_DZ","AKS74U_DZ","M14_CCO_DZ","Bizon_SD_DZ","RPK74_DZ"]; //Weapongrade 3 rifles

	
/*
	Custom rifle tables can be defined below this line (DZAI_Rifles4 - DZAI_Rifles9) for the corresponding custom weapongrade level using the same format above.
	Note: If a custom weapongrade is used without defining the corresponding custom rifle array, the DZAI_Rifles3 array will be used instead.
	Instructions: Replace "nil" with the wanted rifle array. Refer to the above rifle arrays for examples on how to define custom rifle tables.
	Custom rifle tables can only be used with custom-defined spawns (spawns created using the DZAI_spawn function).
*/

DZAI_Rifles4 = nil; //weapongrade 4 weapons
DZAI_Rifles5 = nil; //weapongrade 5 weapons
DZAI_Rifles6 = nil; //weapongrade 6 weapons
DZAI_Rifles7 = nil; //weapongrade 7 weapons
DZAI_Rifles8 = nil; //weapongrade 8 weapons
DZAI_Rifles9 = nil; //weapongrade 9 weapons


//AI skin classnames. DZAI will use any of these classnames for AI spawned. Note: Additional skins may be included on a per-map or per-mod basis - see folders in \world_classname_configs
DZAI_BanditTypes = ["Survivor2_DZ", "SurvivorW2_DZ", "Bandit1_DZ", "BanditW1_DZ", "Camo1_DZ", "Sniper1_DZ"];

//AI Backpack types (for weapongrade levels 0-3)

DZAI_Backpacks0 = ["Patrol_Pack_DZE1","Czech_Vest_Pouch_DZE1","Assault_Pack_DZE1"];
DZAI_Backpacks1 = ["Patrol_Pack_DZE1","Czech_Vest_Pouch_DZE1","Assault_Pack_DZE1","British_ACU_DZE1","TK_Assault_Pack_DZE1","CzechBackpack_DZE1","ALICE_Pack_DZE1"];
DZAI_Backpacks2 = ["CzechBackpack_DZE1","British_ACU_DZE1","CoyoteBackpack_DZE1"];
DZAI_Backpacks3 = ["CzechBackpack_DZE1","CoyoteBackpack_DZE1"];

//AI Food/Medical item types. DZAI_Edibles: Drinkable and edible items. DZAI_Medicals1: List of common medical items to be added to AI inventory. DZAI_Medicals2: List of all medical items available only in hospitals to be added to AI backpack.
DZAI_Edibles = ["ItemSodaCoke", "ItemSodaPepsi", "ItemWaterbottle", "FoodCanSardines", "FoodCanBakedBeans", "FoodCanFrankBeans", "FoodCanPasta", "ItemWaterbottleUnfilled","ItemWaterbottleBoiled","FoodmuttonCooked","FoodchickenCooked","FoodBaconCooked","FoodRabbitCooked","FoodbaconRaw","FoodchickenRaw","FoodmuttonRaw","foodrabbitRaw","FoodCanUnlabeled","FoodPistachio","FoodNutmix","FoodMRE"];
DZAI_Medicals1 = ["ItemBandage", "ItemPainkiller"];
DZAI_Medicals2 = ["ItemPainkiller", "ItemMorphine", "ItemBandage", "ItemBloodbag", "ItemAntibiotic","ItemEpinephrine"];

//AI Miscellaneous item types. DZAI_MiscItemS: List of random low-value items. DZAI_MiscItemL: List of random semi-valuable/useful items
DZAI_MiscItemS = ["ItemHeatpack", "HandRoadFlare", "HandChemBlue", "HandChemRed", "HandChemGreen","SmokeShell","TrashTinCan","TrashJackDaniels","ItemSodaEmpty"];
DZAI_MiscItemL = ["ItemJerrycan", "PartWheel", "PartEngine", "PartFueltank", "PartGlass", "PartVRotor","PartWoodPile"];

//AI toolbelt item types. Toolbelt items are added to AI inventory upon death. Format: [item classname, item probability]
//Weapongrade level 0-1 AI will use DZAI_tools0 table, weapongrade level 2-3 AI will use DZAI_tools1 table. Custom-spawned AI will use DZAI_tools1 table.
//NOTE: Do not delete any elements from this list, set its chance to zero intead. Only add elements to the end of the array, not in the middle.
DZAI_tools0 = [["ItemFlashlight",0.65],["ItemWatch",0.65],["ItemKnife",0.50],["ItemHatchet",0.40],["ItemCompass",0.40],["ItemMap",0.35],["ItemToolbox",0.15],["ItemMatchbox",0.15],["ItemFlashlightRed",0.05],["ItemGPS",0.005],["ItemRadio",0.005],["ItemCrowbar",0.15]];
DZAI_tools1 = [["ItemFlashlight",0.75],["ItemWatch",0.75],["ItemKnife",0.75],["ItemHatchet",0.70],["ItemCompass",0.75],["ItemMap",0.70],["ItemToolbox",0.35],["ItemMatchbox",0.40],["ItemFlashlightRed",0.10],["ItemGPS",0.10],["ItemRadio",0.075],["ItemCrowbar",0.35]];

//AI-useable toolbelt item types. These items are added to AI inventory at unit creation and may be used by AI. Format: [item classname, item probability]
//Weapongrade level 0-1 AI will use DZAI_gadgets0 table, weapongrade level 2-3 AI will use DZAI_gadgets1 table. Custom-spawned AI will use DZAI_gadgets1 table.
DZAI_gadgets0 = [["binocular",0.40],["NVGoggles",0.00]];
DZAI_gadgets1 = [["binocular",0.60],["NVGoggles",0.05]];

diag_log "[DZAI]: [dzai_config.sqf]: DZAI файл конфигурации успешно загружен.";