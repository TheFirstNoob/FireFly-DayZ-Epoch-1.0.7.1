diag_log '[МИССИЯ]: [ConfigVariables.sqf]: Получение всех параметров и значений для Клиент/Сервер.';
// Не нужно перемещать отсюда переменные в init.sqf. Этот файл содержит все перменные в одном виде.

// Клиент и Сервер
setViewDistance 3000;	// Дальность прорисовки Сервера
setTerrainGrid 3.125;	// Дальность травы и геометрии (Установите 50 - Отключить траву и Геометрию и повысит FPS. Значение 25 - Стандарт).

dayz_REsec 						= 	1;		// DayZ RE Security / 1 = Вкл, 0 = Выкл.

// ФОРМАТ: [[[3D Позиция (X,Y,Z), Радиус], [3D Позиция (X,Y,Z), Радиус]]; 
// Отключает Спавн Лута и Зомби, а так же защищает игроков в указанных зонах. Обычно для Трейд-Зон.
DZE_SafeZonePosArray =
[
	 [[3164,12179,0],	85]		// ТЗ Церковь
	,[[9670,2955,0],	120]	// ТЗ Гора
	,[[10580,13110,0],	80]		// ТЗ Бункер
	,[[13155,6395,0],	90]		// ТЗ Сторож
];

// ТОЛЬКО ДЛЯ ЧЕРНОРУСИИ!!!
dayz_infectiouswaterholes 		= 	false; 	// Включить Зараженные водоемы?
infectedWaterHoles 				= 	[]; 	// Нужно для НЕ ЧЕРНО КАРТ (Массив не знаю!).
dayz_townGenerator 				= 	false; 	// Использовать Ванильный мусор вместо Epoch DynamicDebris? ТОЛЬКО ДЛЯ ЧЕРНО. (Негативно влияет на FPS)
dayz_townGeneratorBlackList 	= 	[]; 	// Если townGenerator = true, то в радиусе 150м от указанных позиций мусор не будет появляться. ПРИМЕРЫ ЧЕРНО ТОРГОВЦЕВ: [[4053,11668,0],[11463,11349,0],[6344,7806,0],[1606,7803,0],[12944,12766,0],[5075,9733,0],[12060,12638,0]]
dayz_spawnselection 			= 	0; 		// Включить выбор спавна? 0 = Рандом, 1 = Выбор (ТОЛЬКО ДЛЯ ЧЕРНО)

DZE_NoVehicleExplosions 	= 	false; 		// Выключить Взрыв от Техники? В случае поломки техники она не будет взрываться и наносить урон, а просто заменит модельку на сломанную. True - Да / False - Нет.
DZE_SafeZoneZombieLoot 		= 	false;  	// Разрешить Предметам и Зомби в зонах DZE_SafeZonePosArray?
dayz_ForcefullmoonNights 	= 	false; 		// Отключить лунный свет ночью? Выкручивание яркости в данном случае не поможет. True - Да / False - Нет.
dayz_classicBloodBagSystem 	= 	false; 		// Отключить систему Групп крови и использовать один тип крови для всех с ItemBloodbag? True - Да / False - Нет.
dayz_enableFlies 			= 	false; 		// Включить мух на Трупах? (Негативно влияет на FPS). True - Да / False - Нет.
DZE_PlayerZed 				= 	false; 		// Если игрок умер при заражении, то он может стать зомби? True - Да / False - Нет.
DZE_HeliLift 				= 	false; 		// Включить Epoch буксировочную систему? True - Да / False - Нет.

DZE_PlotPole 				= 	[30,45]; 	// [Радиус ЗНАК-ПЛОТ, Минимальное Расстояние в метрах между ЗНАК-ПЛОТ];
	
DZE_GodModeBase 			= 	false; 		// Включить Бессмертие на постройки? True - Да / False - Нет.
DZE_GodModeBaseExclude 		= 	[]; 		// Список Объектов которые будут Исключены для Бессмертия. Рекомендуется: Двери,ворота и т.п.
DZE_GodModeVehiclesPlot 	= 	false; 		// Disable vehicle damage at plot poles when the vehicle is locked and no crew is inside.

// Death Messages
DZE_DeathMsgChat 			= 	"none"; 	// "none","global","side","system" В какой чат будут отображаться сообщения об убийствах игроков.
DZE_DeathMsgDynamicText 	= 	false; 		// Отображать сообщения об убийствах игроков используя: dynamicText. (Сверху слева с иконками). True - Да / False - Нет.
DZE_DeathMsgRolling 		= 	false; 		// Отображать сообщения об убийствах игроков используя: rolling messages (По центру экрана). True - Да / False - Нет.

// ZSC
Z_SingleCurrency 	= 	true; 		// Включить Монетную систему?. True - Да / False - Нет.

if (Z_SingleCurrency) then
{
	Z_globalBanking 	= 	false; 		// Включить Банковскую систему?. True - Да / False - Нет.
	Z_persistentMoney 	= 	false; 		// Включить защиту денег у игрока при смерти? Валюта вместо player_data будет использовать character_data. Это значит что при смерти игрока он не потеряет деньги у себя в кармане и перенесет их на нового игрока. Только для PVE серверов. Переменная будет называться: "GlobalMoney". True - Да / False - Нет.
	CurrencyName 		= 	"Рублей"; 	// Отображаемое название вашей Валюты.

	// Список Объектов в которых игрок может хранить валюту. НАПРИМЕР: ["GunRack_DZ","WoodCrate_DZ"]
	DZE_MoneyStorageClasses 	= 
	[
		"VaultStorage"
		,"VaultStorage2"
		,"VaultStorageLocked"
		,"VaultStorage2Locked"
		,"LockboxStorageLocked"
		,"LockboxStorage2Locked"
		,"LockboxStorage"
		,"LockboxStorage2"
		,"LockboxStorageWinterLocked"
		,"LockboxStorageWinter2Locked"
		,"LockboxStorageWinter"
		,"LockboxStorageWinter2"
		,"TallSafe"
		,"TallSafeLocked"
	];
	ZSC_VehicleMoneyStorage 	= 	true;	// Включить хранение Валюты в Технике? Если техника взорвется, то и валюта пропадет! True - Да / False - Нет.
};

Z_VehicleDistance 	= 	40; 		// Макс. дистация техники из которой торговец сможет торговать (В метрах).

// Vehicle Key Changer
DZE_VehicleKey_Changer 	= 	true; // Enable Vehicle Key Changer. Create or change the key for a vehicle.

// Виртуальный гараж
DZE_Virtual_Garage 	= 	false; // Enable the Virtual Garage to store vehicles.

// Plot Management and Plot for Life
DZE_isRemovable 	= 
[
	"Plastic_Pole_EP1_DZ"
]; //Items that can be removed with a crowbar with no ownership or access required. To forbid base take overs remove plot pole from this list and add it to DZE_restrictRemoval. It is not necessary to add wrecks or items that inherit from 'BuiltItems' to this list.

// Door Management
DZE_doorManagement 	= 	true; // Enable Door Management by @DevZupa.

// Group System
dayz_groupSystem 	= 	true; // Enable group system

// Кровососы	
DZE_Bloodsuckers 	= 	true; // Enable bloodsucker spawning.

// ПСИ-Штормы
DZE_EVR 	= 	true; 	// Вкл/Выкл ПСИ-Штормы

// Захоронение и Разделывание трупов
DZE_Bury_Body 		= 	false; 	// Вкл/Выкл захоронение
DZE_Butcher_Body 	= 	false; 	// Вкл/Выкл разделывание

// Погода
// Параметры: 1 - Summer Static, 2 - Summer Dynamic, 3 - Winter Static, 4 - Winter Dynamic. If static is selected, the weather settings will be set at server startup and not change. Weather settings can be adjusted with array DZE_WeatherVariables.
DZE_Weather 	= 	2;

// The settings in the array below may be adjusted as desired. The default settings are designed to maximize client and server performance.
// Having several features enabled at once might have adverse effects on client performance. For instance, you could have snowfall, ground fog, and breath fog threads all running at once.
DZE_WeatherVariables =
[
	15, // Minimum time in minutes for the weather to change. (default value: 15).
	30, // Maximum time in minutes for the weather to change. (default value: 30).
	0, // Minimum fog intensity (0 = no fog, 1 = maximum fog). (default value: 0).
	.2, // Maximum fog intensity (0 = no fog, 1 = maximum fog). (default value: 0.8).
	0, // Minimum overcast intensity (0 = clear sky, 1 = completely overcast). (default value: 0). Note: Rain and snow will not occur when overcast is less than 0.70.
	.6, // Maximum overcast intensity (0 = clear sky, 1 = completely overcast). (default value: 1).
	0, // Minimum rain intensity (0 = no rain, 1 = maximum rain). Overcast needs to be at least 70% for it to rain.
	.6, // Maximum rain intensity (0 = no rain, 1 = maximum rain). Overcast needs to be at least 70% for it to rain.
	0, // Minimum wind strength (default value: 0).
	3, // Maximum wind strength (default value: 5).
	.25, // Probability for wind to change when weather changes. (default value: .25).
	1, // Minimum snow intensity (0 = no snow, 1 = maximum snow). Overcast needs to be at least 75% for it to snow.
	1, // Maximum snow intensity (0 = no snow, 1 = maximum snow). Overcast needs to be at least 75% for it to snow.
	.2,// Probability for a blizzard to occur when it is snowing. (0 = no blizzards, 1 = blizzard all the time). (default value: .2).
	10, // Blizzard interval in minutes. Set to zero to have the blizzard run for the whole interval, otherwise you can set a custom time interval for the blizzard.
	0, // Ground Fog Effects. Options: 0 - no ground fog, 1 - only at evening, night, and early morning, 2 - anytime, 3 - near cities and towns, at late evening, night, and early morning, 4 - near cities and towns, anytime.
	300, // Distance in meters from player to scan for buildings to spawn ground fog. By default, only the 15 nearest buildings will spawn ground fog.
	false, // Allow ground fog when it's snowing or raining?
	2 // Winter Breath Fog Effects. Options: 0 - no breath fog, 1 - anytime, 2 - only when snowing or blizzard. Note: breath fog is only available with winter weather enabled.
];

DZE_PlotManagementAdmins 	= 	[]; 	// Список Админских PlayerUIDов. UIDы которые будут иметь Полный доступ к Каждому ЗНАК-ПЛОТУ и его Меню.
DZE_doorManagementAdmins 	= 	[]; 	// Список Админских PlayerUIDов. UIDы которые будут иметь Полный доступ к Каждой Двери (замкам) и его Меню.
	
DZE_disableThermal 		= 	[]; 		// Массив техники где Тепловизор будет отключен при создании или покупке. Например: ["AH1Z","MTVR"];
DZE_clearStaticAmmo 	= 	false; 		// Clears the ammo of all built and spawned static guns	
DZE_clearVehicleAmmo 	= 	false; 		// Clears the ammo of vehicles spawned, bought, claimed and upgraded during the same restart	
DZE_clearVehicleFlares 	= 	false; 		// Clears the flares of vehicles during the same restart, DZE_clearVehicleAmmo must be true in order to work
DZE_addVehicleAmmo 		= 	false; 		// Adds ammo to all spawned, bought, claimed and upgraded vehicles during the same restart

//Server
if (isServer) then
{
	dayZ_instance 	= 	24; 	// ID NAPF Не трогать! 24.
	spawnArea 		= 	1000;	// Расстояние от точки спавна из Mission.sqm для спавна игрока (в метрах)
	spawnShoremode 	= 	0;		// Рандомный выбор спавна  1 = На берегу, 0 = Внутри острова

	// Ивенты (Берутся из DayZ_Server/Modules)
	EpochEvents =
	[
		// ФОРМАТ: [Год,месяц,день,минуты,Имя файла - .sqf] Установите где время -1, тогда сервер запустит ивент сразу. Используйте "any" для любой даты.
		// ["any","any","any","any",-1,"Infected_Camps"],
		["any","any","any","any",-1,"animated_crash_spawner"]
		,["any","any","any","any",-1,"Infected_Camps"]
		,["any","any","any","any",-1,"Care_Packages"]
		,["any","any","any","any",180,"animated_crash_spawner"]
		,["any","any","any","any",180,"abandoned_vaults"]
		
		,["any","any","any","any",150,"event_init"]
		,["any","any","any","any",250,"event_init"]
		,["any","any","any","any",350,"event_init"]
	];

	dayz_POIs = false; // Только для Черно!

	// Динамичная техника
	MaxVehicleLimit 			= 	150; 	// Всего рандомной техники на карте (ID = 0 в DB)
	DynamicVehicleDamageLow 	= 	60; 	// Мин. урон по технике при спавне (% = 0 - 100)
	DynamicVehicleDamageHigh 	= 	85; 	// Макс. урон по технике при спавне (% = 0 - 100)
	DynamicVehicleFuelLow 		= 	5; 		// Мин. бензина в технике при спавне (% = 0 - 100)
	DynamicVehicleFuelHigh 		= 	20; 	// Макс. бензина в технике при спавне (% = 0 - 100)

	// Динамичные объекты
	MaxDynamicDebris 	=	0;		// Кол-во Мусора на дорогах
	MaxAmmoBoxes 		=	0;		// Кол-во Ящиков Supply_Crate_DZE появится на карте
	MaxMineVeins 		=	0;		// Кол-во Руд появится на карте

	DZE_TRADER_SPAWNMODE 	=	false;	// Купленная техника будет появляться на парашюте?
	
	// Призрак (Спектатор после смерти)
	dayz_enableGhosting 	=	false;		// Вкл/Выкл режим Призрака?  / True - Да, False - Нет
	dayz_ghostTimer 		=	120;		// Время жизни Призрака (В секудах)

	// ZSC
	Z_globalBankingTraders 	= 	false;	// Вкл/Выкл Банковскую систему NPC в Трейд-Зонах?
	
	// Safe Zone перемещение техники
	DZE_SafeZone_Relocate 	= 	false; 	// Вкл/Выкл перемещение техники, оставленные в Торговых зонах, после перезапуска сервера?
	
	if (DZE_Virtual_Garage) then
	{
		vg_clearAmmo 	= 	true; 	// Clear the ammo of vehicles spawned during the same restart they are stored? (stops users storing a vehicle for a free rearm)
		vg_sortColumn 	= 	0; 		// 0 or an out of range value sorts by the default column 'DisplayName', otherwise 1 = 'DateStored', 2 = 'id', 3 = 'Name' (of storing player), 4 = 'DateMaintained'
	};
	
	// ПСИ-Штормы
	if (DZE_EVR) then
	{
		DZE_EVRFirstTime 	= 	[5, 10]; 	// Random time in minutes after server restart to begin the first EVR storm [min, max].
		DZE_EVRTimer 		= 	[45, 180]; 	// Random time in minutes between additional EVR storms [min, max].
	};
};

// Клиент
if (!isDedicated) then
{
	dayz_antihack 	= 	0; 		// DayZ Antihack / 1 = Вкл, 0 = Выкл. // Если Используется EPOCH AntiHack & AdminTool, то установите значение 0 по инструкции!
	dayZ_serverName 		= 	"FireFly"; 		// Показывает Водяной знак внизу слева экрана
	dayz_enableRules 		= 	true; 			// Включить Приветственное сообщение при входе игрока (Они же правила или новости. Файл Rules.sqf)
	dayz_randomMaxFuelAmount = 500; //Puts a random amount of fuel in all fuel stations.
	dayz_bleedingeffect 		= 	2; 			// 1 = Кровь остается на земле (Негативно влияет на FPS), 2 = Только эффект (Рекомендуется), 3 = Оба варианта вместе
	dayz_tameDogs 				= 	false;		// Приручать собак? (Скрипт очень лагучий и баганный. Доделываться он не будет!)
	
	DZE_DeathScreen 				= 	true; // True=Use Epoch death screen (Trade city obituaries have been amended) False=Use DayZ death screen (You are dead)
	DZE_R3F_WEIGHT = true; // Enable R3F weight. Players carrying too much will be overburdened and forced to move slowly.
	DZE_CombatTimer = 30; // Time how long a player is in combat after shooting or other combat actions
	DZE_Hide_Body = true; //Enable hide dead bodies. Hiding a dead body removes the corpse marker from the map too. Default = true
	DZE_PVE_Mode = false; //Disable the PvP damage on the server. If DZE_BackpackAntiTheft = true, the backpack anti theft is active on the whole server. This is just a basic support for PVE Servers. Default = false
	
	DZE_defaultSkin = [["Survivor2_DZ","Rocker1_DZ","Rocker2_DZ","Rocker3_DZ","Rocker4_DZ","Priest_DZ","Functionary1_EP1_DZ","Doctor_DZ","Assistant_DZ","Worker1_DZ","Worker3_DZ","Worker4_DZ","TK_CIV_Takistani01_EP1_DZ","TK_CIV_Takistani03_EP1_DZ","TK_CIV_Takistani04_EP1_DZ","TK_CIV_Takistani06_EP1_DZ","Firefighter1_DZ","Firefighter2_DZ","Firefighter3_DZ","Firefighter4_DZ","Firefighter5_DZ","Firefighter_Officer1_DZ","Firefighter_Officer2_DZ","Postman1_DZ","Postman2_DZ","Postman3_DZ","Postman4_DZ","SchoolTeacher_DZ","Gardener_DZ","RU_Policeman2_DZ","Hunter_DZ","Civilian1_DZ","Civilian3_DZ","Civilian5_DZ","Civilian7_DZ","Civilian9_DZ","Civilian11_DZ","Civilian13_DZ","Prisoner1_DZ","Prisoner2_DZ","Prisoner3_DZ","Reporter_DZ","MafiaBoss_DZ","Dealer_DZ","BusinessMan_DZ","Paramedic_DZ","Garbage_Man_DZ"],["SurvivorW2_DZ","SurvivorWcombat_DZ","SurvivorWdesert_DZ","SurvivorWurban_DZ","SurvivorWpink_DZ","SurvivorW3_DZ"]]; // Default player skin for fresh spawns, selected randomly DZE_defaultSkin = [["Male skin1","Male skin2"],["Female skin1","Female skin2"]], comment out the whole line to disable this feature.
	DZE_WarmClothes = []; //Array of warm clothes, type of player model must be added: E.g. ["MVD_Soldier_DZ","GUE_Soldier_2_DZ"];
	
	DZE_TempVars 				=
	[
		// Положительное значение
		  7			// Сидя в Технике
		, 15		// Костер / Огонь
		, 4			// Внутри Здания
		, 4			// При Движении игрока
		, 2			// На Солнце
		, 6			// Использование Хим.Грелки
		, 8			// Одет "Утепленный" скин
		
		// Отрицательное значение
		, 3			// Вода, Море и т.п.
		, 2			// Игрок не передвигается
		, 0.25		// Идет Дождь
		, 0.75		// Ветер
		, 0.5		// Ночь
		, 12		// Снег
		, 33		// Дрожь (Установите 26 чтобы отключить)
	];

	DZE_TwoPrimaries = 2; // 0 do not allow primary weapon on back. 1 allow primary weapon on back, but not when holding a primary weapon in hand. 2 allow player to hold two primary weapons, one on back and one in their hands.
	dayz_quickSwitch = false; //Turns on forced animation for weapon switch. (hotkeys 1,2,3) False = enable animations, True = disable animations
	DZE_NameTags = 0; // Name displays when looking at player up close  0 = Off, 1= On, 2 = Player choice
	DZE_ForceNameTagsInTrader = false; // Force name display when looking at player up close in traders. Overrides player choice.
	DZE_HumanityTargetDistance = 25; // Distance to show name tags (red for bandit, blue for hero, green for friend)
	DZE_HeartBeat = false; // Enable heartbeat sound when looking at bandit (<= -3000 humanity) up close
	DZE_RestrictSkins = []; // Clothes that players are not allowed to wear. i.e. ["Skin_GUE_Soldier_CO_DZ","Skin_GUE_Soldier_2_DZ"] etc.
	DZE_VanillaUICombatIcon = true; //Display or hide combat UI icon if using DZE_UI = "vanilla"; otherwise it has no affect.
	timezoneswitch = 0; // Changes murderMenu times with this offset in hours.
	dayz_maxGlobalZeds = 500; // Maximum allowed zeds on the map
	dayz_paraSpawn = false; // Helo jump spawn
	DZE_enableBloodRegen = true; // player slowly regains blood if they are well fed and resting
	DZE_SelfTransfuse = true; // Allow players to give themselves blood transfusions
	DZE_selfTransfuse_Values = [12000,15,120]; // [blood amount, infection chance, cool-down (seconds)]
	dayz_DamageMultiplier = 1; // Increases the damage to the player by zombie attacks	
	dayz_maxMaxWeaponHolders = 120; // Maximum number of loot piles that can spawn within 200 meters of a player.
	dayz_temperature_override = false; // Set to true to disable all temperature changes.
	dayz_nutritionValuesSystem = true; //true, Enables nutrition system, false, disables nutrition system.
	DZE_DisableVehicleUpgrade = []; // List of vehicles that cannot be upgraded with manuals E.g.: ["ArmoredSUV_PMC_DZE","LandRover_CZ_EP1_DZE"]
	DZE_debrisRefundParts = ["PartEngine","PartGeneric","PartFueltank","PartWheel","PartGlass","ItemJerrycan"]; // Dynamic debris wrecks refund

	// Ограничения Строительства
	DZE_NoBuildNear 				= 				// Массив объектов рядом с которыми нельзя строить. ФОРМАТ: ["Land_Mil_ControlTower","Land_SS_hangar"].
	[
		 "Land_Mil_Barracks"
		,"Land_Mil_Barracks_i"
		,"Land_Mil_House"
		,"Land_Mil_ControlTower"
		,"Land_SS_hangar"
		,"Land_A_Castle_Bergfrit"
		,"Land_MBG_Warehouse"
		,"Land_MBG_Killhouse_2"
		,"Land_Dam_Conc_20"
	];
	DZE_NoBuildNearDistance 		= 	150; 		// Дистанция в метрах от обьекта где нельзя строить.
	DZE_RestrictedBuildingZones	= []; // [["Balota Airfield", [5158.72, 2518.75, 0], 600]];	// [["description", [position], distance], ["description", [position], distance], ... ];
	DZE_BlacklistedBuildings = [];	// [["Fire Station", "Land_a_stationhouse", 250]];	// [["description", "className", distance], ["description", "className", distance], ... ];
	DZE_buildOnWater = true; // Allow building in or over sea water. Note: Sea level will change between low tide and high tide and may cause base flooding. This does not affect inland ponds, dams or lakes.
	DZE_maxSeaLevel	= 1.85;	// ASL height (in meters) of high tide. Objects placed below this level over sea water will trigger a warning message about potential flooding during high tide. Low tide is 06:00 hrs, high tide is 12:00 hrs, but maps may vary.

	DZE_requireplot 				= 	1; 			// Требуется ЗНАК-ПЛОТ для строительства? (1 - Да / 0 - Нет).
	DZE_requirePlotOverride 		= 	[]; // Add a list of classnames that require a plot pole to build. This will override the config settings. E.g. ["DomeTentStorage","VaultStorageLocked","VaultStorage2Locked","TallSafeLocked","LockboxStorageLocked","LockboxStorage2Locked","LockboxStorageWinterLocked","LockboxStorageWinter2Locked"];
	DZE_StaticConstructionCount		= 	0; 			// Кол-во шагов анимации при строительстве (ДЛЯ ВСЕХ ОБЪЕКТОВ СРАЗУ!). Установите 0 чтобы параметры шагов анимации были получены из Config файлов.
	DZE_BuildOnRoads 				= 	false; 		// Можно ли строить на дороге?
	DZE_BuildHeightLimit 			= 	0; 			// Ограничение строительства объектов по высоте. 0 = Нет лимита | >0 = Лимит в метрах.
	DZE_HeightLimitColor 			= 	true; // display plot boundary helpers in red if they are above DZE_BuildHeightLimit
	DZE_BuildingLimit 				= 	150; 		// Максимальное Кол-во объектов для строительства в ЗНАК-ПЛОТе
	DZE_AntiWallLimit 				= 	3; 			// Кол-во попыток прежде чем параметр: player_antiWall убьет игрока за попытку Глича со стенами. Lower is stricter, but may result in false positives.
	DZE_DamageBeforeMaint 			= 	0.09; 		// Мин. Кол-во урона требуется нанести постройкам чтобы оно было "Обслуживаемым"

	DZE_salvageLocked = true; //Enable or disable salvaging of locked vehicles, useful for stopping griefing on locked vehicles.
	DZE_DisabledChannels = [(localize "str_channel_side"),(localize "str_channel_global"),(localize "str_channel_command")]; //List of disabled voice channels. Other channels are: "str_channel_group","str_channel_direct","str_channel_vehicle"
	DZE_NutritionDivisor = [1, 1, 1, 1]; //array of DIVISORS that regulate the rate of [calories, thirst, hunger, temperature] use when "working" (keep in mind that temperature raises with actions) - min values 0.1 - Larger values slow the effect, smaller values accelerate it
	DZE_ZombieSpeed = [0,0]; //Default agro speed is 6 per zombie config, set array elements 0 and 1 the same for non-variable speed, set to 0 to disable. array format = [min, max];  Ex: [2, 6]; results in a range of speed between 2 and 6 (2 is the old DZE_slowZombies hard-coded speed)
	DZE_ZombieHumanity = 0;
	DZE_lockablesHarderPenalty = true; // Enforce an exponential wait on attempts between unlocking a safe/lockbox from a failed code.

	// Торговые зоны
	DZE_SafeZoneNoBuildItems		=	[]; 	// Список Объектов которые нельзя строить возле Трейд-Зон DZE_SafeZonePosArray (Смотри mission\init.sqf). Можно использовать свои значения расстояния для Определенного объекта. НАПРИМЕР: ["VaultStorageLocked","LockboxStorageLocked",["Plastic_Pole_EP1_DZ",1300]].
	DZE_SafeZoneNoBuildDistance		=	750; 	// Дистанция для объектов возле Трейд-Зон DZE_SafeZonePosArray (see mission\init.sqf) to disallow building near.
	DZE_BackpackAntiTheft 			= 	true;	// Предотвращать воровство из Рюкзаков для "Не отмеченных другом" игроков в Трейд-Зонах.

	// HALO Прыжок
	DZE_HaloAltitudeMeter 		= 	false; 	// Отображать Высоту и Скорость при прыжке? : True - Вкл / False - Выкл
	DZE_HaloOpenChuteHeight 	= 	180; 	// При какой высоте открывать автоматически парашют. Установите -1 чтобы отключить эту функцию.
	DZE_HaloSpawnHeight 		= 	2000; 	// Начальная высота прыжка когда игрок только возродился (В метрах).
	DZE_HaloJump 				= 	true; 	// Включить HALO прыжок если высота больше 400м : True - Вкл / False - Выкл

	// Настройка Торговли
	DZE_serverLogTrades 	= 	true; 	// Логгировать в Серверный RPT (Отправляет запрос publicVariableServer на каждую торговлю)

	DZE_GemChance 			= 	0.40;	// Шанс добычи добываемой руды (В процентах)

	// Установите Кол-во добываемых Руд при "Добывании"
	DZE_GemOccurance 		= 	
	[
		["ItemTopaz",		10]
		,["ItemObsidian",	8]
		,["ItemSapphire",	6]
		,["ItemAmethyst",	4]
		,["ItemEmerald",	3]
		,["ItemCitrine",	2]
		,["ItemRuby",		1]
	];
	
	// Цены за Руду при обмене с Торговцем. Установите DZE_GemWorthArray = []; чтобы отключить этот параметр.
	DZE_GemWorthArray 	= 	[];

	DZE_SaleRequiresKey 			= 	true; 		// Требуется Ключ от техники чтобы продать ее? True - Да / False - Нет. Ключ может быть где угодно у Игрока или в его Технике.
	DZE_keepVehicleKey 				= 	true; 		// Оставлять Ключ после продажи техники? True - Да / False - Нет. (Полезно для Скрипта с Key Changer)
	Z_AllowTakingMoneyFromBackpack 	= 	false; 		// Можно ли при Торговле брать деньги из Рюкзака? ТОЛЬКО ДЛЯ СТАНДАРТНОЙ ВАЛЮТЫ. True - Да / False - Нет.
	Z_AllowTakingMoneyFromVehicle 	= 	false; 		// Можно ли при Торговле брать деньги из Техники? ТОЛЬКО ДЛЯ СТАНДАРТНОЙ ВАЛЮТЫ. True - Да / False - Нет.

	// Plot Management and Plot for Life
	DZE_plotManagementMustBeClose = true; //Players must be within 10m of pole to be added as a plot friend.
	DZE_MaxPlotFriends = 10; //Max friends allowed on a plot. There is no character limit in the inventory field of the database, but lower values limit the max global setVariable size to improve performance.
	DZE_maintainCurrencyRate = 100; //The currency rate of what maintaining an item will be, for instance: at 100, 10 items will have a worth of 1000 (1 10oz gold or 1k coins) see actions/maintain_area.sqf for more examples.
	DZE_limitPlots = 0; // Limit the amount of plot poles per person, Use 0 to disable. UIDS in the DZE_PlotManagementAdmins array are exempt.
	DZE_PlotOzone = 10;	// distance (in meters) outside the plot radius where the player may stand while building, provided the object remains within the plot radius.
	DZE_AxialHelper	 = true; // when building within a plot radius, display a perpendicular line of helpers from the highest point to lowest point of the plot boundary.
	DZE_plotGreenTransparency = 0.4; // green plot pole helper transparency. min = 0.1, max = 1
	DZE_plotRedTransparency = 0.7; // red plot pole helper transparency. min = 0.1, max = 1
	DZE_restrictRemoval = ["FuelPump_DZ","FireBarrel_DZ","CanvasHut_DZ","ParkBench_DZ","DeerStand_DZ","MetalGate_DZ","Fence_corrugated_DZ","StickFence_DZ","LightPole_DZ","Scaffolding_DZ","Hedgehog_DZ","MetalPanel_DZ","Fort_RazorWire","FortifiedWire_DZ","BarbedGate_DZ","WoodGate_DZ","Notebook_DZ","Water_Pump_DZ","Greenhouse_DZ","Bed_DZ","Table_DZ","Office_Chair_DZ","Garage_Green_DZ","Garage_White_DZ","Garage_Brown_DZ","Garage_Grey_DZ","CCTV_DZ","Boggle_DZE","Satellite_Dish_DZE","Fueltank_DZE","Watertank_DZE","Watertower_DZE","Compost_Barrel_Empty_DZE","Compost_Barrel_Full_DZE","Plant_Patch_Pumpkin_DZE","Plant_Patch_Sunflower_DZE","Plant_Patch_Carrot_DZE","Plant_Patch_Potato_DZE","Plant_Patch_Hemp_DZE","Plant_Patch_Tobacco_DZE","Plant_Patch_Tea_DZE","Plant_Patch_Garlic_DZE","Plant_Patch_Comfrey_DZE","Sandbag1_DZ","BagFenceRound_DZ"]; //Items that can be removed with a crowbar only with proper ownership or access. It is not necessary to add doors, storage or items that inherit from 'ModularItems' to this list. Items that inherit from 'BuiltItems' can be added to this list if desired.
	DZE_DisableUpgrade 		= 	[];		// Список Объектов которые не могут быть Улучшены. НАПРИМЕР: DZE_DisableUpgrade = ["WoodShack_DZ","StorageShed_DZ"];

	// Snap Build and Build Vectors
	// Список Объектов которые нельзя Вращать при постройке. НАПРИМЕР: ["ItemVault","ItemTent","ItemDomeTent","ItemDesertTent"];
	DZE_noRotate 		= 	
	[
		"ItemWoodLadder"
		,"woodfence_foundation_kit"
		,"metalfence_foundation_kit"
		,"cook_tripod_kit"
		,"metal_drawbridge_kit"
		,"metal_drawbridge_kit_locked"
		,"storage_crate_kit"
	];
	DZE_vectorDegrees 		= 	[0.01, 0.1, 1, 5, 15, 45, 90]; 		// На какие углы можно вращать объекты.
	DZE_curDegree 			= 	45; 								// Начальный угол вращения объектов. Может быть любое значение которое указанно в массиве выше.
	DZE_snapDistance = 2; // maximum distance between two snapping points before snapping will occur. Default: 2 meters.
	DZE_snapAutoRefresh	= true;	// enable auto-refresh of snapping point helpers if player moves the current build object out of initial snapping range. Default: true.
	DZE_uiSnapText = true;	// enable on-screen helper text near the closest snapping point when building. Default: true

	// Remove/Deconstruct modular object variables
	DZE_refundModular = true; // enable/disable refunding of modular objects
	DZE_allowDeconstruct = true; // enable/disable the Deconstruct player action menu. If DZE_refundModular = false, this setting has no effect.
	DZE_displayHelpers = true;	// enable/disable display of modular object helpers
	DZE_displayOnlyIfNearby	= false; // if identical object types are nearby, display green helpers. If no identical types are nearby, then do not display. false = always display green helpers. (This setting does not apply to Red and Blue helpers). If DZE_displayHelpers is disabled, then this setting will be ignored.
	DZE_RefundDamageLimit = 0.25; // amount of damage an object can withstand before no refunded parts will be given. 0 = disable (will always refund)

	//	Refund single kits, or modular object recipes as per the build configs
	//	[[Enable, Modular Object, Refund Kit, [[Refund Class 1, Qty], [Refund Class 2, Qty], [Refund Class 3, Qty], [Refund Class 4, Qty]]]]
	//
	//	Enable:				bool		If DZE_refundModular = true, then set the Enable column to customize individual modular object refunds to on or off. Default = true.
	//	Modular Object:		class		CfgVehicles class of the built object. The string must be in quotes.
	//	Refund Kit:			class		CfgMagazines class of the refunded object when using the "Remove" action. Will refund a singular kit only.
	//	Refund Class n:		class		When using the "Deconstruct" action, refund multiple parts as per the config recipe.  Repeat for each material type, up to 4 types maximum.
	//	Qty:				integer		Quantity of each material type, as per the recipe. Or alternatively a range of values using an array, e.g [1,3] will refund a random integer between 1 and 3.

	DZE_modularConfig = 
	[
		//			// Стеклянные //
		[true,		"GlassFloor_DZ",					"glass_floor_kit",					[["glass_floor_half_kit",				2]]],
		[true,		"GlassFloor_Half_DZ",				"glass_floor_half_kit",				[["glass_floor_quarter_kit",			2]]],
		[true,		"GlassFloor_Quarter_DZ",			"glass_floor_quarter_kit",			[["ItemPole",							8],		["PartGlass",				4]]],

		//			// Металлические //
		[true,		"MetalFloor_DZ",					"metal_floor_kit",					[["metal_floor_half_kit",				2]]],
		[true,		"MetalFloor_Half_DZ",				"metal_floor_half_kit",				[["metal_floor_quarter_kit",			2]]],
		[true,		"MetalFloor_Quarter_DZ",			"metal_floor_quarter_kit",			[["ItemPole",							4],		["equip_metal_sheet",		4]]],
		[true,		"MetalFloor4x_DZ",					"metal_floor4x_kit",				[["metal_floor_kit",					4]]],
		[true,		"Metal_Drawbridge_DZ",				"metal_drawbridge_kit",				[["metal_floor_kit",					2],		["ItemRSJ",					6]]],
		[true,		"MetalPillar_DZ",					"metal_pillar_kit",					[["ItemPole",							1],		["equip_metal_sheet",		2]]],
		[true,		"DoorFrame_DZ",						"door_frame_kit",					[["ItemPole",							4],		["ItemTankTrap",			4],		["PartGeneric",			2]]],
		[true,		"Door_DZ",							"door_kit",							[["door_frame_kit",						1],		["ItemTankTrap",			1],		["ItemPole",			1]]],
		[true,		"MetalFence_1_foundation_DZ",		"metalfence_foundation_kit",		[["ItemStone",							8],		["MortarBucket",			1],		["ItemRSJ",				1]]],
		[true,		"MetalFence_1_frame_DZ",			"metalfence_frame_kit",				[["ItemPlank",							4],		["ItemRSJ",					1]]],
		[true,		"MetalFence_halfpanel_DZ",			"metalfence_halfpanel_kit",			[["ItemMetalSheet",						3],		["ItemScrews",				1]]],
		[true,		"MetalFence_thirdpanel_DZ",			"metalfence_thirdpanel_kit",		[["ItemMetalSheet",						3],		["ItemScrews",				1]]],
		[true,		"MetalFence_1_DZ",					"metalfence_1_kit",					[["ItemMetalSheet",						3],		["ItemScrews",				1]]],
		[true,		"MetalFence_2_DZ",					"metalfence_2_kit",					[["ItemMetalSheet",						4],		["ItemScrews",				1],		["ItemRSJ",				2]]],
		[true,		"MetalFence_3_DZ",					"metalfence_3_kit",					[["ItemMetalSheet",						4],		["ItemScrews",				1],		["ItemRSJ",				2]]],
		[true,		"MetalFence_4_DZ",					"metalfence_4_kit",					[["ItemScrews",							1],		["ItemRSJ",					4]]],
		[true,		"MetalFence_5_DZ",					"metalfence_5_kit",					[["ItemScrews",							1],		["ItemRSJ",					2]]],
		[true,		"MetalFence_6_DZ",					"metalfence_6_kit",					[["ItemScrews",							1],		["ItemPole",				4],		["equip_metal_sheet",	4]]],
		[true,		"MetalFence_7_DZ",					"metalfence_7_kit",					[["ItemScrews",							1],		["ItemPole",				6],		["PartGeneric",			2]]],
		[true,		"MetalContainer1A_DZ",				"metal_container_1a_kit",			[["metal_floor_quarter_kit",			2],		["metal_floor_half_kit",	4],		["ItemTankTrap",		2]]],
		[true,		"MetalContainer1B_DZ",				"metal_container_1b_kit",			[["metal_floor_quarter_kit",			2],		["metal_floor_half_kit",	4],		["ItemTankTrap",		2]]],
		[true,		"MetalContainer1G_DZ",				"metal_container_1g_kit",			[["metal_floor_quarter_kit",			2],		["metal_floor_half_kit",	4],		["ItemTankTrap",		2]]],
		[true,		"MetalContainer2D_DZ",				"metal_container_2d_kit",			[["metal_container_1a_kit",				2]]],

		//			// Бетонные //
		[true,		"CinderWallHalf_DZ",				"half_cinder_wall_kit",				[["CinderBlocks",						3],		["MortarBucket",			1]]],
		[true,		"CinderWallHalf_Gap_DZ",			"half_cinder_wall_gap_kit",			[["CinderBlocks",						3],		["MortarBucket",			1]]],
		[true,		"CinderWall_DZ",					"full_cinder_wall_kit",				[["CinderBlocks",						7],		["MortarBucket",			2]]],
		[true,		"CinderWallWindow_DZ",				"cinderwall_window_kit",			[["CinderBlocks",						5],		["MortarBucket",			1], 	["ItemTankTrap",		1],		["ItemPole",		1]]],
		[true,		"CinderWallSmallDoorway_DZ",		"cinder_door_frame_kit",			[["CinderBlocks",						4],		["MortarBucket",			1],		["ItemTankTrap",		1]]],
		[true,		"CinderWallDoorSmall_DZ",			"cinder_door_kit",					[["cinder_door_frame_kit",				1],		["ItemTankTrap",			1],		["ItemPole",			1]]],
		[true,		"CinderDoorHatch_DZ",				"cinder_door_hatch_kit",			[["CinderBlocks",						4],		["MortarBucket",			1],		["ItemTankTrap",		2],		["ItemPole",		1]]],
		[true,		"CinderWallDoorway_DZ",				"cinder_garage_frame_kit",			[["CinderBlocks",						3],		["MortarBucket",			1],		["ItemTankTrap",		1]]],
		[true,		"CinderWallDoor_DZ",				"cinder_garage_kit",				[["cinder_garage_frame_kit",			1],		["ItemTankTrap",			3],		["ItemPole",			3]]],
		[true,		"CinderGarageOpenTopFrame_DZ",		"cinder_garage_top_open_frame_kit",	[["CinderBlocks",						4],		["MortarBucket",			1]]],
		[true,		"CinderGarageOpenTop_DZ",			"cinder_garage_top_open_kit",		[["cinder_garage_top_open_frame_kit",	1],		["ItemTankTrap",			3],		["ItemPole",			3]]],
		[true,		"CinderGateFrame_DZ",				"cinder_gate_frame_kit",			[["CinderBlocks",						8],		["MortarBucket",			4]]],
		[true,		"CinderGate_DZ",					"cinder_gate_kit",					[["cinder_gate_frame_kit",				1],		["equip_metal_sheet",		6],		["ItemRSJ",				2],		["ItemScrews",		2]]],
		[true,		"Concrete_Bunker_DZ",				"cinder_bunker_kit",				[["full_cinder_wall_kit",				3],		["ItemConcreteBlock",		5],		["equip_metal_sheet",	3],		["ItemScrews",		1]]],

		//			// Деревянные //
		[true,		"WoodFloor_DZ",						"ItemWoodFloor",					[["ItemWoodFloorHalf",					2]]],
		[true,		"WoodFloor4x_DZ",					"ItemWoodFloor4x",					[["ItemWoodFloor",						4]]],
		[true,		"WoodFloorHalf_DZ",					"ItemWoodFloorHalf",				[["ItemWoodFloorQuarter",				2]]],
		[true,		"WoodFloorQuarter_DZ",				"ItemWoodFloorQuarter",				[["PartWoodPlywood",					3],		["PartWoodLumber",			3]]],
		[true,		"WoodSmallWall_DZ",					"ItemWoodWall",						[["ItemWoodWallThird",					3]]],
		[true,		"WoodTriangleWall_DZ",				"ItemTriangleWoodWall",				[["ItemWoodFloorHalf",					1],		["ItemWoodFloorQuarter",	1]]],
		[true,		"WoodSmallWallThird_DZ",			"ItemWoodWallThird",				[["PartWoodPlywood",					3],		["PartWoodLumber",			3]]],
		[true,		"WoodSmallWallWin_DZ",				"ItemWoodWallWindow",				[["ItemWoodWall",						1],		["PartGlass",				1]]],
		[true,		"WoodSmallWallDoor_DZ",				"ItemWoodWallDoor",					[["ItemWoodWallThird",					3]]],
		[true,		"Land_DZE_WoodDoor",				"ItemWoodWallWithDoor",				[["ItemWoodWallDoor",					1],		["PartWoodPlywood",			1],		["PartWoodLumber",	1]]],
		[true,		"Land_DZE_GarageWoodDoor",			"ItemWoodWallGarageDoor",			[["ItemWoodWallLg",						1],		["PartWoodLumber",			2]]],
		[true,		"Land_DZE_WoodOpenTopGarageDoor",	"ItemWoodOpenTopGarageDoor",		[["ItemWoodWallLg",						1],		["PartWoodLumber",			2]]],
		[true,		"WoodLargeWall_DZ",					"ItemWoodWallLg",					[["ItemWoodWall",						1],		["PartWoodPlywood",			1],		["PartWoodLumber",	1]]],
		[true,		"WoodLargeWallWin_DZ",				"ItemWoodWallWindowLg",				[["ItemWoodWallLg",						1],		["PartGlass",				1]]],
		[true,		"WoodLargeWallDoor_DZ",				"ItemWoodWallDoorLg",				[["ItemWoodWall",						1],		["PartWoodPlywood",			1],		["PartWoodLumber",	1]]],
		[true,		"Land_DZE_LargeWoodDoor",			"ItemWoodWallWithDoorLg",			[["ItemWoodWallDoorLg",					1],		["PartWoodPlywood",			1],		["PartWoodLumber",	1]]],
		[true,		"WoodGateFrame_DZ",					"ItemWoodGateFrame",				[["ItemWoodWallThird",					6]]],
		[true,		"Land_DZE_WoodGate",				"ItemWoodGate",						[["ItemWoodGateFrame",					1],		["PartWoodPlywood",			8],		["PartWoodLumber",	2],			["equip_nails",		1]]],
		[true,		"WoodFloorStairs_DZ",				"ItemWoodFloorStairs",				[["ItemWoodFloor",						1],		["ItemWoodStairs",			1]]],
		[true,		"WoodTriangleFloor_DZ",				"ItemTriangleWoodFloor",			[["ItemWoodFloorHalf",					1],		["ItemWoodFloorQuarter",	1]]],
		[true,		"WoodStairsSans_DZ",				"ItemWoodStairs",					[["PartWoodLumber",						8],		["equip_nails",				2]]],
		[true,		"WoodStairs_DZ",					"ItemWoodStairsSupport",			[["ItemWoodStairs",						1],		["PartWoodLumber",			2]]],
		[true,		"WoodStairsRails_DZ",				"ItemWoodStairsRails",				[["ItemWoodStairsSupport",				1],		["PartWoodLumber",			2]]],
		[true,		"WoodLadder_DZ",					"ItemWoodLadder",					[["PartWoodLumber",						8],		["equip_nails",				2]]],
		[true,		"WoodHandrail_DZ",					"ItemWoodHandRail",					[["PartWoodLumber",						3],		["equip_nails",				1]]],
		[true,		"WoodPillar_DZ",					"ItemWoodPillar",					[["PartWoodLumber",						4],		["equip_nails",				1]]],
		[true,		"WoodRamp_DZ",						"wood_ramp_kit",					[["ItemDocumentRamp",					1],		["PartWoodLumber",			8]]],
		[true, 		"WoodenFence_1_foundation_DZ",		"woodfence_foundation_kit",			[["ItemStone",							8],		["MortarBucket",			1],		["ItemPlank",		1]]],
		[true,		"WoodenFence_1_frame_DZ",			"woodfence_frame_kit",				[["woodfence_foundation_kit",			1],		["ItemPlank",				4],		["equip_nails",		1]]],
		[true,		"WoodenFence_quaterpanel_DZ",		"woodfence_quaterpanel_kit",		[["woodfence_frame_kit",				1],		["ItemPlank",				4],		["equip_nails",		1]]],
		[true,		"WoodenFence_halfpanel_DZ",			"woodfence_halfpanel_kit",			[["woodfence_quaterpanel_kit",			1],		["ItemPlank",				4],		["equip_nails",		1]]],
		[true,		"WoodenFence_thirdpanel_DZ",		"woodfence_thirdpanel_kit",			[["woodfence_halfpanel_kit",			1],		["ItemPlank",				4],		["equip_nails",		1]]],
		[true, 		"WoodenFence_1_DZ",					"woodfence_1_kit",					[["woodfence_thirdpanel_kit",			1],		["ItemPlank",				4],		["equip_nails",		1]]],
		[true,		"WoodenFence_2_DZ",					"woodfence_2_kit",					[["woodfence_1_kit",					1],		["ItemPlank",				8],		["equip_nails",		2]]],
		[true,		"WoodenFence_3_DZ",					"woodfence_3_kit",					[["woodfence_2_kit",					1],		["ItemPlank",				8],		["equip_nails",		2]]],
		[true,		"WoodenFence_4_DZ",					"woodfence_4_kit",					[["woodfence_3_kit",					1],		["ItemPlank",				8],		["equip_nails",		2]]],
		[true,		"WoodenFence_5_DZ",					"woodfence_5_kit",					[["woodfence_4_kit",					1],		["ItemLog",					5],		["equip_nails",		2]]],
		[true,		"WoodenFence_6_DZ",					"woodfence_6_kit",					[["woodfence_5_kit",					1],		["PartWoodPlywood",			4],		["ItemPlank",		2],			["equip_nails",		2]]],
		[true,		"WoodenFence_7_DZ",					"woodfence_7_kit",					[["woodfence_6_kit",					1],		["ItemWoodLadder",			1],		["equip_nails",		1]]],
		[true,		"WoodenGate_foundation_DZ",			"woodfence_gate_foundation_kit",	[["ItemLog",							6]]],
		[true,		"WoodenGate_1_DZ",					"woodfence_gate_1_kit",				[["woodfence_gate_foundation_kit",		1],		["ItemPlank",			8],			["equip_nails",		1],			["ItemComboLock",	1]]],
		[true,		"WoodenGate_2_DZ",					"woodfence_gate_2_kit",				[["woodfence_gate_1_kit",				1],		["ItemPlank",			10],		["equip_nails",		1]]],
		[true,		"WoodenGate_3_DZ",					"woodfence_gate_3_kit",				[["woodfence_gate_2_kit",				1],		["ItemPlank",			10],		["equip_nails",		1]]],
		[true,		"WoodenGate_4_DZ",					"woodfence_gate_4_kit",				[["woodfence_gate_3_kit",				1],		["ItemPlank",			10],		["equip_nails",		1]]],
		[true,		"WorkBench_DZ",						"workbench_kit",					[["PartWoodPlywood",					1],		["PartWoodLumber",		2]]],
		[true,		"SimpleFootbridge_DZ",				"simple_footbridge_kit",			[["ItemPlank",							3]]],
		[true,		"WoodenFootbridge_DZ",				"wooden_footbridge_kit",			[["ItemPlank",							3],		["PartWoodLumber",		2],			["equip_nails",		1]]],
		[true,		"Windbreak_DZ",						"windbreak_kit",					[["equip_wood_pallet",					2],		["PartWoodLumber",		2],			["equip_nails",		1]]],

		//			// Фортификации //
		[true,		"Land_HBarrier1_DZ",				"ItemSandbagLarge",					[["ItemSandbag",						3],		["ItemWire",			1],			["ItemTankTrap",	1]]],
		[true,		"Land_HBarrier3_DZ",				"ItemSandbagExLarge",				[["ItemSandbagLarge",					3]]],
		[true,		"Land_HBarrier5_DZ",				"ItemSandbagExLarge5x",				[["ItemSandbagExLarge",					1],		["ItemSandbagLarge",	2]]],
		[true,		"Land_HBarrier5Curved_DZ",			"ItemSandbagExLarge5xCurved",		[["ItemSandbagExLarge",					1],		["ItemSandbagLarge",	2]]],
		[true,		"HeavyBagFence_DZ",					"ItemSandbagHeavy_kit",				[["ItemSandbag",						2],		["PartWoodPile",		1]]],
		[true,		"HeavyBagFenceCorner_DZ",			"ItemSandBagHeavyCorner_kit",		[["ItemSandbagHeavy_kit",				2]]],
		[true,		"HeavyBagFenceRound_DZ",			"ItemSandbagHeavyRound_kit",		[["ItemSandbagHeavy_kit",				3]]],
		[true,		"SandNest_DZ",						"sandbag_nest_kit",					[["ItemSandbag",						4],		["PartWoodPlywood",		2],			["PartWoodLumber",	4]]],
		[true,		"SandNestLarge_DZ",					"sandbag_nest_large_kit",			[["ItemSandBagHeavyCorner_kit",			4],		["sandbag_nest_kit",	4]]],
		[true,		"Land_WarfareBarrier5x_DZ",			"ItemWarfareBarrier5x_kit",			[["ItemSandbagLarge",					5]]],
		[true,		"Land_WarfareBarrier10x_DZ",		"ItemWarfareBarrier10x_kit",		[["ItemWarfareBarrier5x_kit",			2]]],
		[true,		"Land_WarfareBarrier10xTall_DZ",	"ItemWarfareBarrier10xTall_kit",	[["ItemWarfareBarrier10x_kit",			3]]],
		[true,		"FortifiedWire_DZ",					"fortified_wire_kit",				[["ItemWire",							1],		["ItemTankTrap",		2]]],
		[true,		"BarbedGate_DZ",					"barbed_gate_kit",					[["ItemWire",							1],		["ItemTankTrap",		2],			["ItemPole",		2]]],
		[true,		"ConcreteBarrier_DZ",				"concrete_barrier_kit",				[["CementBag",							3],		["ItemStone",			2],			["ItemWire",		1]]],
		[true,		"ConcreteBarrierStriped_DZ",		"concrete_barrier_striped_kit",		[["CementBag",							3],		["ItemStone",			2],			["ItemWire",		1]]],
		[true,		"ConcreteWall_DZ",					"concrete_wall_kit",				[["concrete_barrier_kit",				5],		["CementBag",			2]]],
		[true,		"ConcretePipe_DZ",					"concrete_pipe_kit",				[["concrete_barrier_kit",				6],		["CementBag",			2]]],
		[true,		"DragonTeeth_DZ",					"dragonteeth_kit",					[["concrete_wall_kit",					1],		["ItemStone",			6],			["CementBag",		4]]],
		[true,		"DragonTeethBig_DZ",				"dragonteeth_big_kit",				[["dragonteeth_kit",					1],		["ItemStone",			6],			["CementBag",		4]]]
	];
	
	DZE_modularExclude = [];
	{
		if !(_x select 0) then
		{
			DZE_modularExclude 	= 	DZE_modularExclude + [_x select 1];
		};
	} count DZE_modularConfig;

	DZE_doorManagementMustBeClose 		= 	true; 		// Игроки должны быть в радиусе 10м от Двери чтобы добавить друг друга в Меню управления или Друзья.
	DZE_doorManagementAllowManualCode 	= 	true; 		// Для того чтобы открыть дверь нужно ввести комбинацию. Установите false чтобы вместо комбинации использовать Сканнер глаз.
	DZE_doorManagementMaxFriends 		= 	10; 		// Максимальное количество игроков разрешенное на Дверь.
	DZE_doorManagementHarderPenalty 	= 	true; 		// Включить "Пенальти" за неудачные взломы/открытия Дверей? : True - Вкл / False - Выкл

	// Групповая система
	dayz_markGroup 		= 	0; 			// Игроки могут видеть Членов своей группы на карте: 0 = Никогда, 1 = Всегда, 2 = Только при наличии GPS
	dayz_markSelf 		= 	0; 			// Игроки могут видеть Свою позицию на карте: 0 = Никогда, 1 = Всегда, 2 = Только при наличии GPS
	dayz_markBody 		= 	2; 			// Игроки могут видеть Свои Трупы на карте: 0 = Никогда, 1 = Всегда, 2 = Только при наличии GPS
	dayz_requireRadio 	= 	true; 		// Для создания Группы или Приглашений требуется Радио? True - Да / False - Нет.

	// Система Хуманити
	DZE_Hero 	= 	5000; 	// Сколько нужно Хуманити чтобы стать Героем?
	DZE_Bandit 	= 	-5000; 	// Сколько нужно Хуманити чтобы стать Бандитом?

	// ZSC
	if (Z_SingleCurrency) then
	{	
		Z_showCurrencyUI 	= true; 	// Отображать иконку денег в Инвентаре? Только если Z_SingleCurrency = True.
		Z_showBankUI 		= true; 	// Отображать иконку денег в Банке? Только если Z_globalBanking = True.

		ZSC_bankTraders 	= 	[""]; 	// Список НПС Торговцев с кем будет БАНКИНГ. НАПРИМЕР: Functionary1_EP1, Не используйте _DZ классы - они используют игровые скины
		ZSC_bankObjects 	= 	[""]; 	// Список Объектов с которыми будет БАНКИНГ. НАПРИМЕР:  ["Suitcase","Info_Board_EP1","Laptop_EP1","SatPhone"]
		
		ZSC_limitOnBank 	= 	true; 		// Банк имеет лимит хранения Денег? True - Да / False - Нет.
		ZSC_maxBankMoney 	= 	500000; 	// Какой лимит Денег хранимых в Юанке.
		
		ZSC_defaultStorageMultiplier 		= 	200; 		// Количество мест для хранения денег для тех объектов, у которых нет слотов для хранения: ["Suitcase","Info_Board_EP1","Laptop_EP1","SatPhone"]
		ZSC_MaxMoneyInStorageMultiplier 	= 	3500; 		// Множитель хранения денег в Объектах (Сейфы, техника и т.п.) на Количество слотов. НАПРИМЕР: 200 Предметных слотов * 5000 значение равняется 1 миллиону хранимых денег. (200 * 5000 = 1,000,000)

		ZSC_ZombieCoins 	= 	[true,[0,7]]; 		// Зомби имеют деньги при себе? True - Вкл / False - Выкл // Значения 0 - 5: Это От скольки и До скольки денег может быть случайно у Зомби.
	};

	// Инструменты
	dayz_toolBreaking 			= 	true; 	// Кувалда, Ломик и Топор имеют шанс сломаться при использовании? True - Да / False - Нет.
	dayz_knifeDulling 			= 	true; 	// Включить износ Охотничего ножа? Ножи будут затупляться после нескольких использований. True - Да / False - Нет.
	dayz_matchboxCount 			= 	true; 	// Включить траты Спичек? После 5 раз спички заканчиваются. True - Да / False - Нет.
	dayz_waterBottleBreaking 	= 	true; 	// Фляги с водой имеют шанс сломаться при Кипечении воды? Чтобы починить требуется Изолента. True - Да / False - Нет.
	DZE_bottleBreakChance 		= 	0.10; 	// Шанс поломки фляги при кипечении (В процентах)
	DZE_toolBreakChance 		= 	0.04;	// Шанс поломки инструмента при разборе постройки (В процентах)
	
	// Захоронение и Разделка трупов
	if (DZE_Bury_Body) then
	{
		DZE_Bury_Body_Value 	= 	30; 	// Кол-во хуманити которое получит игрок за Захоронение трупа.
		DZE_BuryOnRoad 			= 	false; 	// Можно ли это делать на дорогах? (ЭТО ОБЩАЯ ФУНКЦИЯ НИЖЕ)
	};

	if (DZE_Butcher_Body) then
	{
		DZE_Butcher_Body_Value 	= 	-30; 	// Кол-во хуманити которое потеряет игрок за Разделывание трупа.
		DZE_BuryOnRoad 			= 	false; 	// Можно ли это делать на дорогах? (ЭТО ОБЩАЯ ФУНКЦИЯ ВЫШЕ)
	};
	
	// Снять одежду (скин)
	DZE_Take_Clothes 			= 	false;		// Вкл/Выкл функцию Снятия одежды с Игроков и ИИ.
	DZE_Disable_Take_Clothes 	= 	[]; 		// Массив запрещеных скинов для Снятия одежды. Например: DZE_Disable_Take_Clothes = ["Doctor_DZ","Assistant_DZ","Worker1_DZ"];
	
	/*
		DZE_CLICK_ACTIONS
		Здесь можно указать что будет выполняться при ПКМ по предмету
		Формат -- (без запятой после последнего элемента массива)
		[_classname,_text,_execute,_condition],
		Параметры
		_classname  : Имя класса, по которому нужно нажать ПКМ (Например = "ItemBloodbag")
		_text       : the text for the option that is displayed when right clicking on the item (Например = "Перелить себе")
		_execute    : Код для выполнения при выборе опции (Например = "execVM 'my\scripts\self_transfuse.sqf';")
		_condition  : compiled code evaluated to determine whether or not the option is displayed (Например = {true})
	*/

	DZE_CLICK_ACTIONS = [		
	/*	["ItemGPS",localize "STR_CL_CA_SCAN_NEARBY",	"if(isNil 'CA_GPS_RANGE') then {CA_GPS_RANGE = 1500;};CA_ZOMBIE_COUNT = count ((position player) nearEntities ['zZombie_Base',CA_GPS_RANGE]); CA_MAN_COUNT = count ((position player) nearEntities ['CAManBase',CA_GPS_RANGE]); format[localize 'STR_CL_CA_SCAN',CA_GPS_RANGE,CA_MAN_COUNT - CA_ZOMBIE_COUNT,count ((position player) nearEntities ['zZombie_Base',CA_GPS_RANGE]),count ((position player) nearEntities ['allVehicles',CA_GPS_RANGE]) - CA_MAN_COUNT] call dayz_rollingMessages;","true"],
		["ItemGPS",localize "STR_CL_CA_RANGE_UP",		"if(isNil 'CA_GPS_RANGE') then {CA_GPS_RANGE = 1500;};CA_GPS_RANGE = (CA_GPS_RANGE + 100) min 2500; format[localize 'STR_CL_CA_RANGE_GPS',CA_GPS_RANGE] call dayz_rollingMessages;","true"],
		["ItemGPS",localize "STR_CL_CA_RANGE_DOWN",		"if(isNil 'CA_GPS_RANGE') then {CA_GPS_RANGE = 1500;};CA_GPS_RANGE = (CA_GPS_RANGE - 100) max 1000; format[localize 'STR_CL_CA_RANGE_GPS',CA_GPS_RANGE] call dayz_rollingMessages;","true"]
	*/
	];	

	// Удаленное управление техникой
	DZE_Remote_Vehicle 	= 	false;		// Вкл/Выкл the Remote Vehicle options like ejecting players from a vehicle or lock/unlock the vehicle from the distance just by the key.
	
	if (DZE_Remote_Vehicle) then
	{
		DZE_CLICK_ACTIONS = DZE_CLICK_ACTIONS + [
			 ["ItemKey",localize "STR_CL_RV_CA_EJECT",	"spawn remoteVehicle;","true",1]
			,["ItemKey",localize "STR_CL_RV_CA_ENGINE",	"spawn remoteVehicle;","true",2]
			,["ItemKey",localize "STR_CL_RV_CA_UNLOCK",	"spawn remoteVehicle;","true",3]
			,["ItemKey",localize "STR_CL_RV_CA_LOCK",	"spawn remoteVehicle;","true",4]
			,["ItemKey",localize "STR_CL_RV_CA_LIGHTS",	"spawn remoteVehicle;","true",5]		
		];
	};	

	// Локатор техники
	DZE_LocateVehicle 	= 	false;		// Вкл/Выкл функцию определения позиции привязанной техники через ПКМ по GPS.

	if (DZE_LocateVehicle) then
	{
		DZE_CLICK_ACTIONS = DZE_CLICK_ACTIONS + [
			["ItemGPS",localize "STR_CL_LV_LOCATE_VEHICLES","[] spawn locateVehicle;","true"]
		];
	};

	// Смена ключа
	if (DZE_VehicleKey_Changer) then
	{
		vkc_claimPrice 		= 	1000; 	// Сумма оплаты за привязки техники к ключу. См. выше часть этого скрипта для объяснения.
		vkc_changePrice 	= 	10000; 	// Сумма оплаты за смену ключа у техники. См. выше часть этого скрипта для объяснения.
	};
	
	// Виртуальный гараж
	if (DZE_Virtual_Garage) then
	{
		vg_list = ["Plastic_Pole_EP1_DZ"]; // List of objects/traders that are allowed to interact with virtual garage. i.e: ["Plastic_Pole_EP1_DZ","Worker2"];
		vg_blackListed = []; // Array of vehicle config classes as well as vehicle classnames that are blacklisted from being stored, i.e ["All","Land","Air","Ship","StaticWeapon","AH1Z","MTVR"]
		vg_heliPads = ["Helipad_Civil_DZ","Helipad_Rescue_DZ","Helipad_Army_DZ","Helipad_Cross_DZ","Helipad_ParkBorder_DZ"]; // Array of heli pad classnames
		vg_store_keyless_vehicles = false;	// Allow storing of keyless vehicle (map or mission spawned)
		vg_removeKey = true; // Remove the key from the players inventory after storing vehicle?
		vg_requireKey = true; // Require the player to have the key when storing a locked vehicle.
		vg_storeWithGear = true; // Allow storing vehicles with gear?
		vg_tiedToPole = true; // Tie the virtual garage to a local plot pole? If no plot pole is present (i.e a communal garage at a trader etc) the players UID will be used.
		vg_pricePer = 100; // Price in worth to store a vehicle per gear item, use 0 if you want it to be free.
		vg_maintainCost = 10000; //cost is 1000 per 10oz gold, gem cost is as defined in DZE_GemWorthArray; if you use ZSC then this is an amount of coins. This is a flate rate for all vehicles in the garage/per player depending on vg_tiedToPole
		vg_price = [["Land",500],["Air",500],["Ship",500]];
		/*
			vg_price can be an array of vehicle config classes as well as vehicle classnames, you need to put these in order of what you prefer to get checked first.
			Price is in worth for briefcases or coins for gold based servers (10,000 worth is considered 1 briefcase, 100,000 coins is considered 1 briefcase)

			Например:
			vg_price = [["Land",500],["Air",300],["Ship",100]];
			vg_price = [["350z_red",200],["Land",500],["AH1Z",1000],["Air",300],["Ship",100]];
		*/
		vg_limit = [["Land",5],["Air",5],["Ship",5]];
		/*
			vg_limit can be an array of vehicle config classes and classnames to narrow down what players can store or it can be a numerical value for a total limit.
			These can be classnames as well as config classnames, you need to put these in order of what you prefer to get checked first.

			Например:
			vg_limit = [["Land",5],["Air",3],["Ship",1]];
			vg_limit = [["350z_red",2],["Land",5],["AH1Z",1],["Air",3],["Ship",1]];
			vg_limit = 5;
		*/
	};
	
	// Кровососы		
	if (DZE_Bloodsuckers) then
	{
		DZE_BloodsuckerChance 				= 	1; 	// Шанс появления кровососа (В процентах).
		
		// Массив где Кровососы будут появляться возле указанных зданий.
		DZE_BloodsuckerBuildings 			=
		[
			 "Land_Hlidac_budka"
			,"Land_Mil_Barracks_i"
			,"CrashSite_RU"
			,"CrashSite_US"
			,"CrashSite_EU"
			,"CrashSite_UN"
		];

		DZE_BloodsuckersMaxGlobal 			= 	10; 	// Макс. кол-во кровососов которые могут появиться на карте за рестарт.
		DZE_BloodsuckersMaxNear 			= 	3; 		// Макс. кол-во кровососов которые могут появиться в радиусе 200 метров.
		DZE_BloodsuckersMaxLocal 			= 	2; 		// Макс. кол-во кровососов которые могут появиться за одного Клиента.
		DZE_BloodsuckerScreenEffect 		= 	true; 	// Вкл/Выкл эффект при атаке кровососа?
		DZE_BloodsuckerDeleteNearTrader 	= 	true; 	// Удалять кровососов рядом с Торговыми зонами?
		DZE_MutantHeartProtect 				= 	true; 	// Вкл/Выкл защиту игроков если в их Инвентаре есть Сердце мутанта? Кровосос будет игнорировать такие цели для атаки.
		DZE_MutantHumanity 					= 	20;
	};
	
	// ПСИ Штормы
	if (DZE_EVR) then
	{
		DZE_EVRWhiteFlash 			= 	true; 	// Вкл/Выкл белые вспышки при ПСИ-Шторме. Это важная опция для игроков страдающих эпилепсией.
		DZE_EVRHandleVehicles 		= 	true; 	// Вкл/Выкл отключение двигателя у Техники? Это не ломает двигатель, а выключает его если техника была заведена!
		DZE_EVRProtectInside 		= 	true; 	// Пропускает бессознательную анимацию, боль и потерю крови, когда игрок находится внутри здания.
		DZE_EVRDamageItemsChance 	= 	.15; 	// Вероятность поломки каждого предмета (В процентах). Процент считается отдельно для каждого предмета. От 0 до 1. Установите 0 - отключить.
		
		// [Предмет (Взят), Поврежденный предмет (Выдан)]. Предметы, которые могут быть повреждены ЭМИ.
		DZE_EVRDamageItems 			=
		[
			 ["Binocular_Vector",	"Binocular_VectorBroken"]
			,["NVGoggles_DZE",		"ItemNVGFullBroken_DZE"]
			,["NVGoggles",			"ItemNVGBroken_DZE"]
			,["ItemGPS",			"ItemGPSBroken_DZE"]
			,["ItemRadio",			"ItemRadioBroken_DZE"]
			,["Smartphone_DZE",		"SmartphoneBroken_DZE"]
		];

		DZE_EVRBloodLoss 			= 	[2000,6000]; 	// Мин-Макс кол-во крови которое потеряет игрок не имея APSI и/или не внутри здания. Игрок не умирает, есть минимум 1000 после расчета
	};

	// Garage Door Opener
	DZE_GarageDoor_Opener 	= 	true;	// Вкл/Выкл функцию открытия гаражных дверей из техники.
	
	if (DZE_GarageDoor_Opener) then
	{
		// Массив гаражных дверей для Garage Door Opener.
		DZE_GarageDoors 	=
		[
			 "CinderWallDoorLocked_DZ"
			,"Land_DZE_GarageWoodDoorLocked"
			,"Land_DZE_LargeWoodDoorLocked"
			,"WoodenGate_1_DZ"
			,"WoodenGate_2_DZ"
			,"WoodenGate_3_DZ"
			,"WoodenGate_4_DZ"
			,"Land_DZE_WoodGateLocked"
			,"CinderGateLocked_DZ"
			,"Land_DZE_WoodOpenTopGarageLocked"
			,"CinderGarageOpenTopLocked_DZ"
		];
		DZE_GarageDoor_Radius 	= 	25; 	// Дистанция отображение функции (В метрах). ВНИМАНИЕ: Высокое значение может негативно повлиять на FPS!
	};
	
	// АвтоСервис на заправках (Заправка, Починка и Перевооружение)
	DZE_Service_Points 	= 	false; 	// Вкл/Выкл функцию АвтоСервис?
	
	if (DZE_Service_Points) then
	{
		// Разрешенные классы конфигурации техники в качестве примера: "Air", "AllVehicles", "All", "APC", "Bicycle", "Car", "Helicopter", "Land", "Motorcycle", "Plane", "Ship", "Tank"
		// DZE_SP_Classes укажите классы заправок или вы можете использовать dayz_fuelpumparray который уже имеет все классы заправок
		DZE_SP_Classes 	=
		[
			 "Map_A_FuelStation_Feed"
			,"Land_A_FuelStation_Feed"
			,"FuelPump_DZ"
		];
		DZE_SP_MaxDistance 	= 	20; 	// Дистанция отображения функции (В метрах)
		
		// Параметры заправки
		DZE_SP_Refuel_Enable 	= 	false; 	// Вкл/Выкл функцию заправки?

		if (DZE_SP_Refuel_Enable) then
		{

			// DZE_SP_Refuel_Costs представляет собой массив, основанный на типе Vehicle.
			DZE_SP_Refuel_Costs =
			[
				//["Ship",localize "str_temp_param_disabled"], 	// Вся плавательная техника запрещена для заправки.
				["Land",localize "strwffree"], 					// Вся наземная техника заправляется бесплатно.
				["Air",1000] 									// 1000 рублей это 1 10oz gold для всей Воздушной техники
			];
			DZE_SP_Refuel_UpdateInterval 	= 	1; 		// Время интервала заправки (В секундах)
			DZE_SP_Refuel_Amount 			= 	0.01; 	// Количества топлива заправляемое в указанный интервал выше (В процентах)
		};
		
		
		// Параметры починки
		DZE_SP_Repair_Enable 	= 	false; 	// Вкл/Выкл функцию починки?

		if (DZE_SP_Repair_Enable) then 
		{
			DZE_SP_Repair_RepairTime 	= 	2; 	// Время до полной починки техники (В секундах)

			// DZE_SP_Repair_Costs представляет собой массив, основанный на типе Vehicle.
			DZE_SP_Repair_Costs =
			[
				["Air",4000], 			// 4000 рублей это 4 10oz gold.
				["AllVehicles",2000] 	// 2000 рублей это 2 10oz gold для всей остальной техники
			];
		};
		
		// Параметры перевооружения
		DZE_SP_Rearm_Enable 	= 	false; 	// Вкл/Выкл функцию перевооружения?

		if (DZE_SP_Rearm_Enable) then
		{
			DZE_SP_Rearm_Defaultcost 	= 	10000; 	// Начальная стоимость перевооружения. (10000 рублей = 1 брифкейс)
			DZE_SP_Rearm_MagazineCount 	= 	2; 		// Количество обойм которые будут добавлены при перевооружении
			
			// Массив вооружения которые не будут перезаряжаться.
			DZE_SP_Rearm_Ignore =
			[
				 (localize "str_dn_horn")
				,(localize "str_dn_laser_designator")
			];
			/*
				DZE_SP_Rearm_Costs представляет собой массив, основанный на типе AMMO. Например: M240, MK19, PKM, PKT, M134 и т.д. 
				Вы можете запретить перевооружение определенных типов боеприпасов, сделав цену отключенной.
				Например: ["M134",localize "str_temp_param_disabled"]
			*/			
			DZE_SP_Rearm_Costs =
			[
				[(localize "str_mn_40rnd_grad"),localize "str_temp_param_disabled"], // BM-21 Grad отключен (Тип вооружения сломан в игре)
				[(localize "str_dn_flarelauncher"),2000], 		// Ловушки или Сигнальные ракеты
				[(localize "str_ep1_dn_smokelauncher"),2000], 	// Дымовые

				[(localize "str_dn_pk"),5000], // PKM
				[(localize "str_dn_pkt"),5000], // PKT
				[(localize "str_sn_m134"),5000], // M134
				[(localize "str_dn_ags30"),5000], // AGS-30
				[(localize "str_dn_dshkm"),5000], // DSHKM
				[(localize "str_DN_VIKHR_CCP"),5000], // Vikhr 9A4172
				[(localize "str_baf_baf_l94a10"),5000], // L94A1 Chain Gun
				[(localize "str_baf_crv70"),5000], // CRV7
				[(localize "str_baf_ctws0"),5000], // CTWS
				[(localize "str_baf_m621_manual0"),5000], // M621
				[(localize "str_dn_2a38m"),5000], // 2A38M Gun
				[(localize "str_dn_2a42"),5000], // 2A42
				[(localize "str_dn_2a46m"),5000], // 2A46M Cannon
				[(localize "str_dn_2a46m_rocket"),5000], // 9M119M Refleks rocket
				[(localize "str_dn_2a70"),5000], // 2A70 100mm
				[(localize "str_dn_2a70_rocket"),5000], // 9M117M1 Arkan
				[(localize "str_dn_2a72"),5000], // 2A72 30mm
				[(localize "str_dn_80mmlauncher_burst"),5000], // S-8
				[(localize "str_dn_9m311laucher"),5000], // Tunguska 9M311
				[(localize "str_dn_ags17"),5000], // AGS-17
				[(localize "str_dn_d81"),5000], // D-81
				[(localize "str_dn_dt_veh"),5000], // DT
				[(localize "str_dn_hellfire"),5000], // AGM-114 Hellfire
				[(localize "str_dn_kord"),5000], // KORD
				[(localize "str_dn_m197"),5000], // M197
				[(localize "str_dn_m240"),5000], // M240
				[(localize "str_dn_m242"),5000], // M242
				[(localize "str_dn_m256"),5000], // M256
				[(localize "str_dn_sidewinderlaucher"),5000], // AIM-9L Sidewinder
				[(localize "str_dn_zis_s_53"),5000], // ZiS-S-53
				[(localize "str_ep1_dn_57mmlauncher"),5000], // S-5
				[(localize "str_ep1_dn_azp85"),5000], // AZP-23
				[(localize "str_ep1_dn_ffarlauncher"),5000], // Hydra
				[(localize "str_ep1_dn_m2"),5000], // M2 Machinegun
				[(localize "str_ep1_dn_m230"),5000], // M230
				[(localize "str_ep1_dn_m32_ep1"),5000], // M32
				[(localize "str_ep1_dn_mk19"),5000], // Mk19
				[(localize "str_ep1_dn_yakb"),5000], // Yak-B
				[(localize "str_mn_at2_mi24d"),5000], // Falanga 3M11
				[(localize "str_mn_at5_bmp2"),5000], // Konkurs 9M113
				[(localize "str_mn_stinger"),5000], // FIM-92F Stinger
				[(localize "str_mn_12rnd_mlrs"),5000], // MLRS
				[(localize "str_baf_baf_l2a10"),5000], // L111A1
				[(localize "STR_DN_D10_CCP"),5000], // D-10
				[(localize "str_dn_tow"),5000], // M220 TOW
				[(localize "str_dn_zu23"),5000], // ZU-23
				[(localize "str_dn_kpvt"),5000], // KPVT
				[(localize "str_dn_m3p"),5000], // M3P
				[(localize "str_dn_spg9"),5000], // SPG-9
				[(localize "str_dn_gau8"),5000], // GAU-8
				[(localize "str_dn_maverick"),5000], // AGM-65 Maverick
				[(localize "str_dn_gbu12"),5000], // GBU-12
				[(localize "str_dn_gau12"),5000], // GAU-12
				[(localize "STR_DN_KH29_CCP"),5000], // Kh-29L
				[(localize "str_dn_r73"),5000], // R-73
				[(localize "str_mn_fab250"),5000], // FAB-250
				[(localize "str_dn_gsh301"),5000], // GSh-301
				[(localize "str_mn_23mm_gsh23l"),5000], // GSh-23L
				[(localize "str_sn_grenade"),5000], // Grenade
				[(localize "str_mn_at9_mi24p"),5000], // Ataka-V 9M120
				[(localize "str_mn_at6_mi24v"),5000], // Shturm 9K114

				["SGMT",5000], 		// SGMT Нет локализации
				["M68",5000], 		// M68 Нет локализации
				["GAU-22",5000], 	// GAU-22 Нет локализации
				["GSh-30",5000], 	// GSh-30 Нет локализации
				["M60",5000], 		// M60 Нет локализации
				["GSh-30K",5000] 	// GSh-30K Нет локализации
			];
		};
	};
};

diag_log '[СЕРВЕР]: [МИССИЯ]: [ConfigVariables.sqf]: ВСЕ параметры и значения были получены.';