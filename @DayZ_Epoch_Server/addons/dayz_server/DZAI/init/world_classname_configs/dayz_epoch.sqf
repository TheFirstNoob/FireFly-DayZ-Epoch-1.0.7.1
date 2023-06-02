/*
	DayZ Epoch конфигурация
	Описание: Добавляет DayZ Epoch - Специальные предметы в таблицы лута DZAI. Если Epoch включен.
	Последнее обновление: 5:10 PM 9/8/2013
*/

DZAI_metalBars 		= 	[["ItemSilverBar",0.15],["ItemSilverBar10oz",0.10],["ItemGoldBar",0.075],["ItemGoldBar10oz",0.035]]; //Format: [["Bar1Classname",Bar1Chance],["Bar2Classname",Bar2Chance],["Bar2Classname",Bar2Chance]]
DZAI_metalBarNum 	= 	0; 		// Макс. гарантированное кол-во слитков.

DZAI_banditTypesNew 	= 	["Bandit1_DZ","BanditW1_DZ","BanditW2_DZ","Camo1_DZ","Sniper1_DZ","Soldier1_DZ","Survivor2_DZ","SurvivorW2_DZ","GUE_Soldier_MG_DZ","GUE_Soldier_Sniper_DZ","GUE_Soldier_Crew_DZ","GUE_Soldier_2_DZ","RU_Policeman_DZ","Pilot_EP1_DZ","Haris_Press_EP1_DZ","Ins_Soldier_GL_DZ","GUE_Commander_DZ","Functionary1_EP1_DZ","Priest_DZ","Rocker1_DZ","Rocker2_DZ","Rocker3_DZ","Rocker4_DZ","TK_INS_Warlord_EP1_DZ","TK_INS_Soldier_EP1_DZ","Soldier_Sniper_PMC_DZ","Soldier_TL_PMC_DZ","FR_OHara_DZ","FR_Rodriguez_DZ","CZ_Soldier_Sniper_EP1_DZ","Graves_Light_DZ","Bandit2_DZ","SurvivorWcombat_DZ","CZ_Special_Forces_GL_DES_EP1_DZ","Soldier_Bodyguard_AA12_PMC_DZ","GUE_Soldier_CO_DZ"];
DZAI_ediblesNew 		= 	["ItemSodaRabbit","ItemSodaMtngreen","ItemSodaClays","ItemSodaSmasht","ItemSodaDrwaste","ItemSodaLemonade","ItemSodaLvg","ItemSodaMzly","FoodBioMeat","FoodCanGriff","FoodCanBadguy","FoodCanBoneboy","FoodCanCorn","FoodCanCurgon","FoodCanDemon","FoodCanFraggleos","FoodCanHerpy","FoodCanOrlok","FoodCanPowell","FoodCanTylers","FoodPumpkin","FoodSunFlowerSeed"];
DZAI_MiscItemSNew 		= 	["ItemZombieParts"];

DZAI_Backpacks0New 	= 	["TerminalPack_DZE1"];
DZAI_Backpacks1New 	= 	["TerminalPack_DZE1", "CompactPack_DZE1"];
DZAI_Backpacks2New 	= 	["CompactPack_DZE1","GunBag_DZE1"];
DZAI_Backpacks3New 	= 	["GunBag_DZE1","LargeGunBag_DZE1"];

//Не меняйте ничего ниже. Заменяет стандартный Топор и Спички на Epoch версии.
(DZAI_tools0 select 3) set [0,"ItemHatchet"];
(DZAI_tools0 select 7) set [0,"ItemMatchbox"];
(DZAI_tools1 select 3) set [0,"ItemHatchet"];
(DZAI_tools1 select 7) set [0,"ItemMatchbox"];

diag_log "[DZAI]: [Classnames]: [dayz_epoch.sqf]: Epoch КлассНеймы загружены.";