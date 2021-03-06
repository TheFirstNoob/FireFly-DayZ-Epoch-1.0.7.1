#include "\z\addons\dayz_server\compile\server_toggle_debug.hpp"

private ["_character","_clientID"];
_character 	= 	_this select 0;
_clientID 	= 	owner _character;

#ifdef SERVER_DEBUG
diag_log ("[БАЗА ДАННЫХ]: [server_playerDeaths]: Список смертей игроков был запрошен ClientID: "+ str(_clientID));
diag_log(PlayerDeaths);
#endif

PVDZE_plr_DeathBResult 	= 	PlayerDeaths;

if(!isNull _character) then
{
	_clientID publicVariableClient "PVDZE_plr_DeathBResult";
};

PlayerDeaths