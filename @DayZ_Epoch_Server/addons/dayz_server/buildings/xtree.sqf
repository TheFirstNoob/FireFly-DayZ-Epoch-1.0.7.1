_kordX 	= 	_this select 0;
_kordY 	= 	_this select 1;
_kordH 	= 	_this select 2;

if (isServer) then
{
	private ["_object","_objects"];

	_objects 	= 
	[
		["MAP_t_picea2s", [_kordX, _kordY, _kordH], -18.422382],
		["ASC_EU_BulbBLUB", [_kordX - 1.035, _kordY - 3.383, _kordH + 0.4800028], -18.422382],
		["ASC_EU_BulbBLUB", [_kordX - 2.574, _kordY - 1.429, _kordH + 2.2393854], -18.422382],
		["ASC_EU_BulbBLUB", [_kordX + 0.458, _kordY - 3.104, _kordH + 3.5452229], -18.422382],
		["ASC_EU_BulbBLUB", [_kordX + 2.969, _kordY - 2.394, _kordH + 0.8863241], -18.422382],
		["ASC_EU_BulbBLUB", [_kordX + 1.798, _kordY - 1.583, _kordH + 4.4461738], -18.422382],
		["ASC_EU_BulbBLUB", [_kordX + 2.587, _kordY + 1.084, _kordH + 3.4403078], -18.422382],
		["ASC_EU_BulbBLUB", [_kordX + 2.767, _kordY - 0.045, _kordH + 1.4464540], -18.422382],
		["ASC_EU_BulbBLUB", [_kordX + 1.451, _kordY + 2.146, _kordH + 6.5229389], -18.422382],
		["ASC_EU_BulbBLUB", [_kordX - 0.677, _kordY + 3.121, _kordH + 3.9876296], -18.422382],
		["ASC_EU_BulbBLUB", [_kordX - 1.879, _kordY + 2.028, _kordH + 5.3892333], -18.422382],
		["ASC_EU_BulbBLUB", [_kordX - 1.029, _kordY + 0.704, _kordH + 8.8637148], -18.422382],
		["ASC_EU_BulbBLUB", [_kordX - 1.727, _kordY - 0.22, _kordH + 4.839431], -18.422382],	
		["ASC_EU_BulbBLUB", [_kordX - 3.408, _kordY + 0.926, _kordH + 2.8890289], -18.422382],
		["ASC_EU_BulbBLUB", [_kordX - 1.77, _kordY - 0.049, _kordH + 9.85174760], -18.422382],
		["ASC_EU_BulbBLUB", [_kordX - 0.14, _kordY - 0.845, _kordH + 12.8339436], -18.422382],
		["ASC_EU_BulbBLUB", [_kordX - 0.198, _kordY - 0.092, _kordH + 15.8070846], -18.422382],
		["ASC_EU_BulbBLUB", [_kordX - 1.199, _kordY + 0.624, _kordH + 13.2495076], -18.422382],

		["ASC_EU_BulbYELB", [_kordX + 2.334, _kordY - 2.191, _kordH + 3.0081364], -18.422382],
		["ASC_EU_BulbYELB", [_kordX + 1.629, _kordY + 0.83, _kordH + 6.8121935], -18.422382],
		["ASC_EU_BulbYELB", [_kordX - 0.068, _kordY + 1.716, _kordH + 8.4128577], -18.422382],
		["ASC_EU_BulbYELB", [_kordX - 1.394, _kordY - 0.76, _kordH + 6.5734111], -18.422382],
		["ASC_EU_BulbYELB", [_kordX - 0.05, _kordY - 1.004, _kordH + 10.5587826], -18.422382],
		["ASC_EU_BulbYELB", [_kordX - 0.207, _kordY - 0.088, _kordH + 14.8400226], -18.422382],
		["ASC_EU_BulbYELB", [_kordX - 1.419, _kordY + 0.229, _kordH + 11.6107896], -18.422382],
		["ASC_EU_BulbYELB", [_kordX - 0.075, _kordY + 0.959, _kordH + 12.5374586], -18.422382],

		["ASC_EU_BulbGRNB", [_kordX + 1.291, _kordY - 0.445, _kordH + 8.1424328], -18.422382],
		["ASC_EU_BulbGRNB", [_kordX - 1.284, _kordY - 1.877, _kordH + 7.4936883], -18.422382],
		["ASC_EU_BulbGRNB", [_kordX - 2.839, _kordY - 0.041, _kordH + 2.6517586], -18.422382],
		["ASC_EU_BulbGRNB", [_kordX - 1.066, _kordY + 0.981, _kordH + 9.5326306], -18.422382],
		["ASC_EU_BulbGRNB", [_kordX + 0.318, _kordY + 1.68, _kordH + 6.8460652], -18.422382],
		["ASC_EU_BulbGRNB", [_kordX - 0.354, _kordY, _kordH + 17.1510366], -18.422382],
		["ASC_EU_BulbGRNB", [_kordX + 0.609, _kordY - 1.915, _kordH + 8.9215237], -18.422382],
		["ASC_EU_BulbGRNB", [_kordX - 0.908, _kordY - 1.246, _kordH + 9.6297216], -18.422382],
		["ASC_EU_BulbGRNB", [_kordX - 2.814, _kordY + 1.897, _kordH + 1.4971768], -18.422382],
		["ASC_EU_BulbGRNB", [_kordX + 1.669, _kordY - 0.357, _kordH + 6.1346818], -18.422382],

		["ASC_EU_BulbPURB", [_kordX - 0.089, _kordY - 2.33, _kordH + 2.0356511], -18.422382],
		["ASC_EU_BulbPURB", [_kordX - 1.686, _kordY - 1.656, _kordH + 4.7314641], -18.422382],
		["ASC_EU_BulbPURB", [_kordX - 1.409, _kordY + 0.277, _kordH + 5.8804156], -18.422382],
		["ASC_EU_BulbPURB", [_kordX + 0.855, _kordY + 2.681, _kordH + 5.966735], -18.422382],
		["ASC_EU_BulbPURB", [_kordX + 1.597, _kordY + 1.729, _kordH + 4.2028276], -18.422382],
		["ASC_EU_BulbPURB", [_kordX + 1.886, _kordY + 3.622, _kordH + 0.4854442], -18.422382],
		["ASC_EU_BulbPURB", [_kordX + 0.849, _kordY + 0.062, _kordH + 11.3539316], -18.422382],
		["ASC_EU_BulbPURB", [_kordX - 0.33, _kordY - 0.055, _kordH + 17.4104516], -18.422382],
		["ASC_EU_BulbPURB", [_kordX - 1.766, _kordY - 0.77, _kordH + 10.0770396], -18.422382],
		["ASC_EU_BulbPURB", [_kordX + 0.685, _kordY - 0.944, _kordH + 7.0869977], -18.422382],
		["ASC_EU_BulbPURB", [_kordX - 0.447, _kordY + 1.262, _kordH + 5.7954027], -18.422382],
		["ASC_EU_BulbPURB", [_kordX + 2.876, _kordY + 2.74, _kordH + 1.6223904], -18.422382],

		["ASC_EU_BulbREDB", [_kordX + 0.007, _kordY - 2.028, _kordH + 2.2662207], -18.422382],
		["ASC_EU_BulbREDB", [_kordX - 2.173, _kordY - 2.126, _kordH + 3.57574], -18.422382],
		["ASC_EU_BulbREDB", [_kordX - 1.233, _kordY + 1.297, _kordH + 5.8602659], -18.422382],
		["ASC_EU_BulbREDB", [_kordX + 2.317, _kordY + 2.037, _kordH + 1.9493076], -18.422382],
		["ASC_EU_BulbREDB", [_kordX + 2.024, _kordY - 0.583, _kordH + 4.8120591], -18.422382],
		["ASC_EU_BulbREDB", [_kordX + 1.129, _kordY - 1.599, _kordH + 1.2551607], -18.422382],
		["ASC_EU_BulbREDB", [_kordX - 1.463, _kordY - 0.655, _kordH + 10.2974666], -18.422382],
		["ASC_EU_BulbREDB", [_kordX + 0.444, _kordY - 0.448, _kordH + 12.7056006], -18.422382],
		["ASC_EU_BulbREDB", [_kordX - 1.009, _kordY - 0.299, _kordH + 13.3222076], -18.422382],
		["ASC_EU_BulbREDB", [_kordX - 0.49, _kordY - 1.628, _kordH + 4.2085811], -18.422382],

		["ASC_EU_BulbWHTB", [_kordX - 2.167, _kordY + 1.89, _kordH + 3.2470032], -18.422382],
		["ASC_EU_BulbWHTB", [_kordX + 0.096, _kordY + 1.711, _kordH + 4.0597946], -18.422382],
		["ASC_EU_BulbWHTB", [_kordX + 1.585, _kordY - 0.471, _kordH + 2.6976608], -18.422382],
		["ASC_EU_BulbWHTB", [_kordX - 0.585, _kordY - 1.511, _kordH + 6.8347241], -18.422382],
		["ASC_EU_BulbWHTB", [_kordX - 0.477, _kordY - 0.259, _kordH + 16.0696136], -18.422382],

		["LAND_ASC_runway_Yellowlight", [_kordX - 2.12, _kordY - 2.024, _kordH - 0.9112209], -18.422382],
		["LAND_ASC_runway_Yellowlight", [_kordX + 0.916, _kordY - 2.075, _kordH - 0.9111599], -18.422382],
		["LAND_ASC_runway_Yellowlight", [_kordX + 0.488, _kordY + 2.521, _kordH - 0.9111599], -18.422382],

		["LAND_ASC_runway_Bluelight", [_kordX - 1.694, _kordY + 1.002, _kordH - 0.9111599], -18.422382],
		["LAND_ASC_runway_Bluelight", [_kordX - 1, _kordY - 2.677, _kordH - 0.9112209], -18.422382],
		["LAND_ASC_runway_Bluelight", [_kordX + 2.736, _kordY + 0.984, _kordH - 0.9112209], -18.422382],

		["Land_fort_bagfence_long", [_kordX + 1.435, _kordY + 3.866, _kordH - 1.0693274], 14.136709],
		["Land_fort_bagfence_long", [_kordX - 1.272, _kordY + 3.656, _kordH - 1.1841706], -18.422382],
		["Land_fort_bagfence_long", [_kordX - 3.321, _kordY + 1.875, _kordH - 1.1388566], 104.77624],
		["Land_fort_bagfence_long", [_kordX - 3.487, _kordY - 0.985, _kordH - 1.1281799], 79.998413],
		["Land_fort_bagfence_long", [_kordX - 2.076, _kordY - 3.336, _kordH - 1.1298253], 34.89378],
		["Land_fort_bagfence_long", [_kordX + 0.505, _kordY - 3.789, _kordH - 1.1319437], -13.638905],
		["Land_fort_bagfence_long", [_kordX + 2.519, _kordY - 2.349, _kordH - 1.0876497], 116.35595],
		["Land_fort_bagfence_long", [_kordX + 3.028, _kordY + 2.205, _kordH - 1.0710061], 77.306702],
		["Land_fort_bagfence_long", [_kordX + 3.228, _kordY - 0.206, _kordH - 1.0787077], 103.96237]
	];

	{
		_object 	= 	(_x select 0) createVehicle (_x select 1);
		_object setDir (_x select 2);
		_object setPos (_x select 1);
	} count _objects;
};