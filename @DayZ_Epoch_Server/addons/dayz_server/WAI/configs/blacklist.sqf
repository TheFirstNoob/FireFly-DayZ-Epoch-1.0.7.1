waiBlackList 	= 	call {
    if (toLower worldName == "chernarus") exitWith
	{
		[
			[[0,16000,0],[1000,-0,0]],
			[[0,16000,0],[16000.0,14580.3,0]]
		];
	};
    [];
};

if (count waiBlackList > 0) then
{
	diag_log "[WAI]: [blacklist.sqf]: Черный список позиций загружен!";
}
else
{
	diag_log "[WAI]: [blacklist.sqf]: Вы используете неподдерживаемую карту (Либо данные для карты не прописаны)! Черный список недоступен.";
};