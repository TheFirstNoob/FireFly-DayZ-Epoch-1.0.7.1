if (!_claimed) then
{
	// Найдем ближайшего игрока и отправим оповещение
	if (isNull _closestPlayer) then
	{
		if (!isNull _claimPlayer && {alive _claimPlayer} && {_claimPlayer distance _position <= WAI_AcAlertDistance}) then
		{
			_closestPlayer 	= 	_claimPlayer;
			_claimPlayer 	= 	objNull;
		}
		else
		{
			_closestPlayer 	= 	[_position, WAI_AcAlertDistance] call isClosestPlayer;
		};

		if (!isNull _closestPlayer) then
		{
			[_closestPlayer,_name,"Start"] call WAI_AutoClaimAlert;
			_claimTime 	= 	diag_tickTime;
		};
	};

	// По истечении времени задержки проверим местоположение игрока и либо Занято, либо Не Занято
	if ((diag_tickTime - _claimTime) > WAI_AcDelayTime) then
	{
		if ((_closestPlayer distance _position) > WAI_AcAlertDistance || {!alive _closestPlayer}) then
		{
			[_closestPlayer,_name,"Stop"] call WAI_AutoClaimAlert; 
			_closestPlayer 	= 	objNull;
			_acArray 		= 	[];
		}
		else
		{
			_claimed 	= 	true;
			[_closestPlayer,_name,"Claimed"] call WAI_AutoClaimAlert; 	// Сообщим всем

			diag_log text format ["[WAI]: [auto_claim.sqf]: Миссия %1 была занята игроком: %2",_name,(name _closestPlayer)];

			_acArray 	= 	[getplayerUID _closestPlayer, name _closestPlayer];
			_markers set [3, [[(_position select 0) + 100, (_position select 1) + 100],_autoMarkDot,"ColorBlack","mil_objective","","",[],["STR_CL_CLAIM_MARKER",(name _closestPlayer)],0]];
			DZE_ServerMarkerArray set [_markerIndex, _markers];
			PVDZ_ServerMarkerSend 	= 	["createSingle",(_markers select 3)];
			publicVariable "PVDZ_ServerMarkerSend";
		};
	};
};

if (_claimed) then
{
	// Используется в маркере когда игрок покинул зону миссии
	_leftTime 	= 	round (WAI_AcTimeout - (diag_tickTime - _claimTime));
	
	// Этот маркер должен работать постоянно пока миссия не будет не занята или игрок не вернется
	if (_left) then
	{
		_autoText 	= 	["STR_CL_TIMEOUT_MARKER",(_acArray select 1),_leftTime];
		(_markers select 3) set [7, _autoText];
		DZE_ServerMarkerArray set [_markerIndex, _markers];
		PVDZ_ServerMarkerSend 	= 	["textSingle",[_autoMarkDot,_autoText]];
		publicVariable "PVDZ_ServerMarkerSend";
	};
	
	// Если игрок умирает во время миссии, то изменим маркер на обратный отсчет и установим для переменной player значение null
	if ((!alive _closestPlayer) && !_left) then
	{
		_closestPlayer 	= 	objNull;
		_claimTime 		= 	diag_tickTime;
		_left 			= 	true;
	};
	
	// Проверим вернулся ли мертвый игрок в миссию.
	if (isNull _closestPlayer) then
	{
		_closestPlayer 	= 	[_position,_acArray] call isReturningPlayer;
	};
	
	// Сообщим игроку, что он за пределами зоны миссии
	if (!(isNull _closestPlayer) && ((_closestPlayer distance _position) > WAI_AcAlertDistance) && !_left) then
	{
		[_closestPlayer,_name,"Return"] call WAI_AutoClaimAlert;
		_claimTime 	= 	diag_tickTime;
		_left 		= 	true;
	};
	
	// Если игрок возвращается к миссии до истечения времени, то изменим маркер.
	if (!(isNull _closestPlayer) && ((_closestPlayer distance _position) < WAI_AcAlertDistance) && _left) then
	{
		[_closestPlayer,_name,"Reclaim"] call WAI_AutoClaimAlert;
		_left 		= 	false;
		_autoText 	= 	["STR_CL_CLAIM_MARKER",(name _closestPlayer)];
		(_markers select 3) set [7, _autoText];
		DZE_ServerMarkerArray set [_markerIndex, _markers];
		PVDZ_ServerMarkerSend 	= 	["textSingle",[_autoMarkDot,_autoText]];
		publicVariable "PVDZ_ServerMarkerSend";
	};
	
	// Предупредим других игроков в зоне миссии
	{
		local _inside 	= 	_x distance _position < WAI_AcAlertDistance;
		local _inArray 	= 	_x in _warnArray;

		if (!(_x in (units group _closestPlayer)) && _inside && !_inArray) then
		{
			RemoteMessage 	= 	["rollingMessages", ["STR_CL_CLAIM_WARNING",_acArray select 1]];
			(owner _x) publicVariableClient "RemoteMessage";
			_warnArray set [count _warnArray, _x];
		};
		
		if (!_inside && _inArray) then
		{
			_warnArray 	= 	_warnArray - [_x];
		};
	} count playableUnits;
	
	// Если игрок не вернулся по истечению таймера, то установим миссию как свободную и установим переменные по умолчанию
	// Игрок вышел с сервера
	if ((isNull _closestPlayer) && ((diag_tickTime - _claimTime) > WAI_AcTimeout)) then
	{
		[_acArray ,_name,"Unclaim"] call WAI_AutoClaimAlert; 	// Сообщим всем игрокам
		_claimed 				= 	false;
		_left 					= 	false;
		_acArray 				= 	[];
		_warnArray 				= 	[];
		PVDZ_ServerMarkerSend 	= 	["removeSingle",_autoMarkDot];
		publicVariable "PVDZ_ServerMarkerSend";
		_markers set [3, 1];
		DZE_ServerMarkerArray set [_markerIndex, _markers];
	}
	else
	{
		// Игрок жив, но не вернулся на миссию
		if (((diag_tickTime - _claimTime) > WAI_AcTimeout) && ((_closestPlayer distance _position) > WAI_AcAlertDistance)) then
		{
			[_closestPlayer,_name,"Unclaim"] call WAI_AutoClaimAlert; 	// Сообщим всем игрокам
			_closestPlayer 			= 	objNull;
			_claimed 				= 	false;
			_left 					= 	false;
			_acArray 				= 	[];
			_warnArray 				= 	[];
			PVDZ_ServerMarkerSend 	= 	["removeSingle",_autoMarkDot];
			publicVariable "PVDZ_ServerMarkerSend";
			_markers set [3, 1];
			DZE_ServerMarkerArray set [_markerIndex, _markers];
			
		};
	};
};