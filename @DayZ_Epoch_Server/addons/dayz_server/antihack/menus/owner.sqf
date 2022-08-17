/* ******************************************************* */
/*         Создано специально для Epoch Community          */
/*               Авторы: BigEgg и Movinggun                */
/* ******************************************************* */

_AH_Admin 	= 	_AH_Admin + ("
	_keys 	= 	['Execute','Delete','Unlock','Lock','Info','Generate'];

	comment ('
		Execute: 	Позволяет администрации нажать F8 и выполнить antihack\test.sqf в своих игровых файлах
		Delete: 	Позволяет администрации нажать DEL и удалить объект
		Unlock: 	Позволяет администрации нажать 1 и открыть цель
		Lock: 		Позволяет администрации нажать 2 и закрыть цель
		Info: 		Позволяет администрации нажать I и получить информацию о цели
		Generate: 	Позволяет администрации нажать U и сгенерировать ключ для техники
	');

	admin_limitLists 	= 	false; 	comment 'Если true, то администрация может создавать только то, что есть у Торговцев';
	admin_adjblood 		= 	true; 	comment 'Если true, то администрация может менять значение КРОВЬ у игрока';
	admin_adjhumanity 	= 	true; 	comment 'Если true, то администрация может менять значение ХУМАНИТИ у игрока';
	admin_adjcoins 		= 	true; 	comment 'Если true, то администрация может менять значение КОШЕЛЕК у игрока';
	admin_adjbank 		= 	true; 	comment 'Если true, то администрация может менять значение БАНК у игрока';
	admin_forceTemp 	= 	false; 	comment 'Если true, то администрация НЕ может создавать постоянную технику';

	_main set [count _main, ['===============================================================', 0, []]];
	_main set [count _main, ['                     Переключаемые Скрипты', 0, []]];
	_main set [count _main, ['Бинды кнопок:', 0, []]];
	_main set [count _main, ['    Телепорт прямо', 1, []]];
	_main set [count _main, ['    Полет вверх', 1, []]];
	_main set [count _main, ['', 0, []]];
	_main set [count _main, ['Управление базами:', 0, []]];
	_main set [count _main, ['    Door Manager доступ', 1, []]];
	_main set [count _main, ['    Plot For Life доступ', 1, []]];
	_main set [count _main, ['    Быстрое строительство', 1, []]];
	_main set [count _main, ['    Строительство без ограничений', 1, []]];
	_main set [count _main, ['', 0, []]];
	_main set [count _main, ['Защита:', 0, []]];
	_main set [count _main, ['    Бессмертие', 1, []]];
	_main set [count _main, ['    Бессмертие для Техники', 1, []]];
	_main set [count _main, ['    Невидимость', 1, []]];
	_main set [count _main, ['    Отключить Агрессию Зомби', 1, []]];
	_main set [count _main, ['    Щит от Зомби', 1, []]];
	_main set [count _main, ['', 0, []]];
	_main set [count _main, ['Специальные возможности:', 0, []]];
	_main set [count _main, ['    [Alt + ЛКМ] Телепорт по карте', 1, []]];
	_main set [count _main, ['    ESP Игроков', 1, []]];
	_main set [count _main, ['    Отключить отдачу', 1, []]];
	_main set [count _main, ['    Быстрая стрельба', 1, []]];
	_main set [count _main, ['    Бесконечные патроны', 1, []]];
	_main set [count _main, ['    Ускорение техники', 1, []]];
	_main set [count _main, ['', 0, []]];
	_main set [count _main, ['Маркера на карте:', 0, []]];
	_main set [count _main, ['    Маркера Животных', 1, []]];
	_main set [count _main, ['    Маркера Трупов', 1, []]];
	_main set [count _main, ['    Маркера Строй.Столбов', 1, []]];
	_main set [count _main, ['    Маркера Сейфов', 1, []]];
	_main set [count _main, ['    Маркера Сейф-Ящиков', 1, []]];
	_main set [count _main, ['    Маркера Хранилищ', 1, []]];
	_main set [count _main, ['    Маркера Игроков', 1, []]];
	_main set [count _main, ['    Маркера Техники', 1, []]];
	_main set [count _main, ['', 0, []]];
	_main set [count _main, ['Иконки на карте:', 0, []]];
	_main set [count _main, ['    Иконки Юнитов', 1, []]];
	_main set [count _main, ['    Иконки Техники', 1, []]];
	_main set [count _main, ['===============================================================', 0, []]];
	_main set [count _main, ['                            Инструменты', 0, []]];
	_main set [count _main, ['>> Сохранить текущие параметры', 0, [], admin_cache]];
	_main set [count _main, ['>> Скопировать координаты в чат', 0, [], admin_coords]];
	_main set [count _main, ['>> Убить ИИ', 0, [], admin_killai]];
	_main set [count _main, ['>> Удалить Камуфляжные сетки', 0, [], admin_nets]];
	_main set [count _main, ['>> Удалить Строй.Столбы', 0, [], admin_poles]];
	_main set [count _main, ['', 0, []]];

	_targ set [count _targ, ['===============================================================', 0, []]];
	_targ set [count _targ, ['                      Действия с целью', 0, []]];
	if (Z_SingleCurrency) then {
		_targ set [count _targ, ['>> Изменить БАНК цели', 6, []]];
		_targ set [count _targ, ['>> Изменить КОШЕЛЕК цели', 6, []]];
	};
	_targ set [count _targ, ['>> Изменить ХУМАНИТИ цели', 6, []]];
	_targ set [count _targ, ['', 0, []]];
	_targ set [count _targ, ['>> Телепортироваться к Цели', 6, []]];
	_targ set [count _targ, ['>> Телепортировать Цель к Вам', 6, []]];
	_targ set [count _targ, ['', 0, []]];
	_targ set [count _targ, ['Положительные:', 0, [0.118,0.565,1,1]]];
	_targ set [count _targ, ['    >> Выдать Патроны Игроку', 6, [0.118,0.565,1,1]]];
	_targ set [count _targ, ['    >> Вылечить Игрока', 6, [0.118,0.565,1,1]]];
	_targ set [count _targ, ['    >> Переместиться в Технику Игрока', 6, [0.118,0.565,1,1]]];
	_targ set [count _targ, ['    >> Переместить Игрока в Вашу Технику', 6, [0.118,0.565,1,1]]];
	_targ set [count _targ, ['    >> Починить Технику Игрока', 6, [0.118,0.565,1,1]]];
	_targ set [count _targ, ['    >> Разморозить Игрока', 6, [0.118,0.565,1,1]]];
	_targ set [count _targ, ['', 0, []]];
	_targ set [count _targ, ['Негативные:', 0, [1,0,0,1]]];
	_targ set [count _targ, ['    >> Отключить от Сервера Игрока', 6, [1,0,0,1]]];
	_targ set [count _targ, ['    >> Высадить Игрока с Техники', 6, [1,0,0,1]]];
	_targ set [count _targ, ['    >> Заморозить Игрока', 6, [1,0,0,1]]];
	_targ set [count _targ, ['    >> Убить Игрока', 6, [1,0,0,1]]];
	_targ set [count _targ, ['    >> Заставить Игрока сделать Самоубийство', 6, [1,0,0,1]]];
	_targ set [count _targ, ['    >> Удалить Инвентарь Игрока', 6, [1,0,0,1]]];
	_targ set [count _targ, ['    >> Отправить Игрока в Небо', 6, [1,0,0,1]]];
	_targ set [count _targ, ['    >> Отправить Игрока в Океан', 6, [1,0,0,1]]];

	_logs set [count _logs, ['===============================================================', 0, []]];
	_logs set [count _logs, ['                  Выберите лог для просмотра', 0, []]];
	_logs set [count _logs, ['>> Логи Администрации', 7, []]];
	_logs set [count _logs, ['>> Логи Смертей', 7, []]];
	_logs set [count _logs, ['>> Логи Читеров', 7, []]];
	_logs set [count _logs, ['>> Логи Открытий/Закрытий', 7, []]];
	_logs set [count _logs, ['>> Логи Обслуживания', 7, []]];
	_logs set [count _logs, ['>> Логи Новых Игроков', 7, []]];
	_logs set [count _logs, ['>> Логи Игроков', 7, []]];
	_logs set [count _logs, ['>> Логи Безопасных Зон', 7, []]];
	_logs set [count _logs, ['>> Логи Наблюдений', 7, []]];
	_logs set [count _logs, ['>> Логи Торговли', 7, []]];

	if (count "+str EpochEvents+" > 0) then {
		_spwn set [count _spwn, ['===============================================================', 0, []]];
		_spwn set [count _spwn, ['                            Создать Ивент', 0, []]];
		{
			_spwn set [count _spwn, [format['>> %1', _x select 5], 13, []]];
		} count "+str EpochEvents+";
	};
	if ("+str _wai+") then {
		_spwn set [count _spwn, ['===============================================================', 0, []]];
		_spwn set [count _spwn, ['                           Создать Миссию', 0, []]];
		_spwn set [count _spwn, ['Создать Бандитскую Миссию', 1, []]];
		{
			_spwn set [count _spwn, [format['>> %1', _x], 14, []]];
		} count [
			'patrol',
			'black_hawk_crash',
			'armed_vehicle',
			'base',
			'captured_mv22',
			'scout_patrol',
			'ikea_convoy',
			'medi_camp',
			'broken_down_ural',
			'sniper_extraction',
			'mayors_mansion',
			'weapon_cache',
			'gem_tower',
			'cannibal_cave',
			'crop_raider',
			'drone_pilot',
			'slaughter_house',
			'drugbust',
			'armybase',
			'abandoned_trader',
			'lumberjack',
			'presidents_mansion',
			'tankcolumn',
			'macdonald',
			'radioshack',
			'junkyard',
			'outpost',
			'farmer',
			'firestation',
			'vehicle_drop',
			'castle_grayskull',
			'wuhan_lab',
			'apc'
		];
	};

	_envi set [count _envi, ['===============================================================', 0, []]];
	_envi set [count _envi, ['                          Серверное время', 0, []]];
	_envi set [count _envi, ['>> 00:00', 11, []]];
	_envi set [count _envi, ['>> 02:00', 11, []]];
	_envi set [count _envi, ['>> 04:00', 11, []]];
	_envi set [count _envi, ['>> 06:00', 11, []]];
	_envi set [count _envi, ['>> 08:00', 11, []]];
	_envi set [count _envi, ['>> 10:00', 11, []]];
	_envi set [count _envi, ['>> 12:00', 11, []]];
	_envi set [count _envi, ['>> 14:00', 11, []]];
	_envi set [count _envi, ['>> 16:00', 11, []]];
	_envi set [count _envi, ['>> 18:00', 11, []]];
	_envi set [count _envi, ['>> 20:00', 11, []]];
	_envi set [count _envi, ['>> 22:00', 11, []]];
	_envi set [count _envi, ['===============================================================', 0, []]];
	_envi set [count _envi, ['                         Серверная погода', 0, []]];
	_envi set [count _envi, ['>> Ясно', 12, []]];
	_envi set [count _envi, ['>> Облачно', 12, []]];
	_envi set [count _envi, ['>> Дождь', 12, []]];
	_envi set [count _envi, ['>> Шторм', 12, []]];

	admin_menus 	=
	[
		 ['Главное Меню', _main]
		,['Меню Рюкзаков', admin_backpacks]
		,['Меню Управления', _envi]
		,['Меню Логов', _logs]
		,['Меню Предметов', admin_magazines]
		,['Меню Создания', _spwn]
		,['Меню Цели', _targ]
		,['Меню Техники', admin_vehicles]
		,['Меню Оружий', admin_weapons]
	];
");