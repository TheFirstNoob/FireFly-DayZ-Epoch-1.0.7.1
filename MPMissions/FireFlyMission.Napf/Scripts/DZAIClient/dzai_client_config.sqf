if (isServer) exitWith {};

// Использовать client-side функции Радио-сообщений? DZAI_clientRadio должен быть установлен на 'true\false' в dzai_config.sqf.
DZAIC_radio = false;

// Использовать AI стреляют по Зомби? DZAI_zombieEnemy должен быть установлен на 'true\false' в dzai_config.sqf.
DZAIC_zombieEnemy = true;

// Использовать оповещения об убийствах игроком AI? DZAI_deathMessages должен быть установлен на 'true\false' в dzai_config.sqf
DZAIC_deathMessages = false;