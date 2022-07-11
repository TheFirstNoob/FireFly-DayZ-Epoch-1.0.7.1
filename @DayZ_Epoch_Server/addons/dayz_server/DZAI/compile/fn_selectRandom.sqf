private "_ret";
if (count _this > 0) then
{
    _ret 	= 	count _this;
    _ret 	= 	floor (random _ret);
    _ret 	= 	_this select _ret;
};
_ret