if (dayz_actionInProgress) exitWith
{
	localize "str_player_actionslimit" call dayz_rollingMessages;
};

local _playerNear =
{
	isPlayer _x
} count (([player] call FNC_GetPos) nearEntities ["CAManBase", 5]) > 1;

if (_playerNear) exitWith
{
	localize "STR_EPOCH_PLAYER_16" call dayz_rollingMessages;
};

dayz_actionInProgress = true;
SystemChat "Действие начато";

local _amountOfMagazine = 2;
_amountOfMagazine = {_x == "30Rnd_545x39_AK"} count magazines player;

local _hasItems =
[
	"equip_duct_tape"
] call player_checkItems;

if (_hasItems) then
{
	player removeMagazine "30Rnd_545x39_AK";
	player removeMagazine "30Rnd_545x39_AK";
	
	if ([TFN_DuctTapeRemoveChance] call fn_chance) then
	{
		player removeMagazine "equip_duct_tape";
		SystemChat "Не повезло. Скотч закончился.";
	};

    player playActionNow "PutDown";
    player addMagazine "60Rnd_545x39_AK_Taped";

	SystemChat "Патроны объеденены";
};

call player_forceSave;
SystemChat "Принудительное сохранение";
uiSleep 1;
dayz_actionInProgress = false;
SystemChat "Действие окончено";