[		
		/* ТЗ Церковь */
			// Оружие
		["US_Delta_Force_AR_EP1", [3175, 12179, 0], 270]
			// Патроны
		,["Graves", [3175, 12181, 0], 270]
			// Техника
		,["GUE_Commander", [3174, 12170, 0], 179]
			// Еда и Рюкзаки
		,["Damsel3", [3182, 12191, 0], 275]
			// Стройка
		,["GUE_Woodlander2", [3171, 12191, 0], 100]
			// Медик
		,["Dr_Annie_Baker_EP1",[3147, 12203, 0], 175]
		
		/* ТЗ Эверест */
			// Оружие
		,["Soldier_MG_PKM_PMC", [8939, 3418, 0], 182]
			// Патроны
		,["GUE_Worker2", [8937, 3418, 0.4], 182]
			// Техника
		,["GUE_Woodlander3", [8962, 3440, 0], 88]
			// Еда и Рюкзаки
		,["CIV_EuroWoman01_EP1", [8950, 3407, 0], 358]
			// Стройка
		,["GUE_Villager3", [8957, 3431, 0], 185]
			// Медик
		,["Dr_Hladik_EP1",[8948, 3432, 0], 271]
		
		/* ТЗ Бункер */
			// Оружие
		,["Ins_Soldier_AR", [10582, 13088, 0], 80]
			// Патроны
		,["Ins_Lopotev", [10582, 13086, 0], 80]
			// Техника
		,["Ins_Worker2", [10569, 13114, 0], 75]
			// Еда и Рюкзаки
		,["Damsel5", [10600, 13098, 0], 260]
			// Стройка
		,["Ins_Woodlander3", [10592, 13091, 0], 69]
			// Медик
		,["pook_Doc_Bell47",[10600, 13109, 0], 232]
		
		/* ТЗ Сторож */
			// Оружие
		,["Drake_Light", [13139, 6364, 0], 100]
			// Патроны
		,["Soldier_GL_PMC", [13140, 6367, 0], 100]
			// Техника
		,["RUS_Commander", [13161, 6401, 0], 5]
			// Еда и Рюкзаки
		,["TK_Special_Forces_EP1", [13161, 6366, 0], 10]
			// Стройка
		,["TK_Special_Forces_MG_EP1", [13150, 6363, 0], 15]
			// Медик
		,["Ins_Woodlander2",[13175, 6357, 0], 352]
] call server_spawnTraders;

execVM "\z\addons\dayz_server\buildings\Trade_Cerkov.sqf";
uiSleep 1;
execVM "\z\addons\dayz_server\buildings\Trade_Everest.sqf";
uiSleep 1;
execVM "\z\addons\dayz_server\buildings\Trade_Bunker.sqf";
uiSleep 1;
execVM "\z\addons\dayz_server\buildings\Trade_Storosh.sqf";
uiSleep 1;