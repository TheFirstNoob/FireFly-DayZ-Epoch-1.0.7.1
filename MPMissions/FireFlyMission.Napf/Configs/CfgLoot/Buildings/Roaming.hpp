class HouseRoaming : Residential
{
	zombieChance = 0.2;
	maxRoaming = 2;
};

class FarmRoaming : Farm
{
	zombieChance = 0.4;
	maxRoaming = 2;
};
class Land_Shed_W03 : HouseRoaming {};
class land_housev_3i3: HouseRoaming  {
	lootPos[] = {{-4.2334,0.291992,-1.47064},{1.10059,-2.99854,-0.790649},{3.53027,-2.34033,-1.74265}};
	lootPosSmall[] = {{-4.85645,0.550293,-0.340637},{2.21289,0.783691,-0.160645},{-0.833008,0.554199,-0.620636},{1.79785,-2.99902,-1.09064},{5.06055,-2.68164,-1.56265}};
	zedPos[] = {{-4.18457,-1.68164,-0.525635},{0.419922,-1.00781,-0.525635},{4.35059,-1.37939,-0.98764}};
};
class Land_HouseBlock_A1_2 : HouseRoaming {};
class Land_HouseBlock_A2 : HouseRoaming {};
class Land_HouseBlock_B2 : HouseRoaming {};

class Land_HouseBlock_B4: HouseRoaming{
	zedPos[] = {{0.0595703,-5.58252,-6.69312},{-1.1543,5.55225,-6.74633}};
	lootPosSmall[] = {{-0.0693359,4.82227,-7.28133}};
};
class Land_HouseBlock_C2 : HouseRoaming {};
class Land_HouseBlock_C3 : HouseRoaming {};
class Land_HouseBlock_C4 : HouseRoaming {
	zedPos[] = {{1.54199,3.79883,-4.57855},{-1.8208,-1.80664,-4.57855},{1.72363,-1.67188,-4.5746},{-2.75586,-3.64844,-4.57855},{-2.49805,4.07422,-4.57855}};
	lootPos[] = {{2.68457,3.71484,-5.46355},{-2.98145,3.95508,-5.46355},{-2.95117,-3.64258,-5.46355},{-2.81152,-3.53125,-1.49755},{3.00293,-3.85156,-1.49755},{-1.76465,0.222656,-1.48755}};
	lootPosSmall[] = {{-3.30518,-1.75488,-4.77355},{2.38623,-0.0947266,-4.5696},{-2.56396,-1.65137,-1.05755},{0.203613,-1.61328,-0.907551},{1.9502,-3.79883,-4.6796},{-1.77246,2.92285,-1.48755},{2.42285,1.17822,-4.75355}};
};
class Land_HouseBlock_C5 : HouseRoaming {};
class Land_Misc_Cargo1D : HouseRoaming {};
class Land_Ind_Shed_01_end : HouseRoaming {};

class Land_A_statue01 : HouseRoaming
{
	zombieClass[] ={"zZombie_Base","zZombie_Base","z_teacher","z_suit1","z_suit2","z_soldier","z_soldier_heavy","z_policeman"};
	minRoaming = 2;
	maxRoaming = 8;
};

class GraveCross1 : HouseRoaming {};
class GraveCross2 : HouseRoaming {};

class Grave : HouseRoaming
{
	maxRoaming = 3;
};

class GraveCrossHelmet : Military
{	
	maxRoaming = 4;
};

class Land_Dam_Conc_20 : HouseRoaming
{
	zedPos[] = {{3.11,1.22,9.09},{5.75,1.14,9.1},{-4.22,9.19,9.11}};
	lootChance = 0.4;
};

class Land_Misc_Scaffolding : HouseRoaming
{
	zedPos[] = {{-0.03,3.1,0.45},{0.43,6.92,0.45}};
};
// DAYZ AMP More buildings (DZE ADDED)
class Land_Shed_W02_EP1: FarmRoaming{};
class Land_MBG_ApartmentsOne_W: HouseRoaming{};
class Land_MBG_ApartmentsTwo_P: HouseRoaming{};
class Land_MBG_ApartmentsTwo_G: HouseRoaming{};
class Land_MBG_ApartmentsTwo_B: HouseRoaming{};
class Mass_grave_DZ: HouseRoaming {
	zombieClass[] = {"zZombie_Base","z_hunter","z_hunter","z_hunter","z_villager1","z_villager2","z_villager3","z_doctor","z_soldier_pilot","z_soldier_heavy"};
	minRoaming = 8;
	maxRoaming = 16;
	lootChance = 1;
	zombieChance = 1;
};
class Land_dum_olez_istan2: HouseRoaming{};
class Land_dum_olez_istan2_maly2: HouseRoaming{
	zedPos[] = {{-2.71582,-4.86133,-1.62356},{-2.76074,4.94531,-1.62356}};
};
class land_smd_dum02: HouseRoaming{
	zedPos[] = {{4.37305,1.68701,-2.7265},{-4.50977,1.54443,-3.41202}};
};
class land_dum_mesto: HouseRoaming{
	zedPos[] = {{-5.11328,-6.34717,-3.93972}};
};
class land_deutshe: HouseRoaming{
	zedPos[] = {{1.72949,4.62207,-3.0957},{1.69336,-4.75,-3.78851}};
};
class land_stanice: HouseRoaming{
	zedPos[] = {{-1.18945,4.63867,-1.83241}};
};
class land_smd_dum_mesto3_istan: HouseRoaming {
	zedPos[] = {{5.8457,-0.0634766,-2.34898},{-6.13281,0.0458984,-2.34898}};
};
class land_dum_mesto3_istan: HouseRoaming{};
class land_dum_istan2_03a: HouseRoaming{};
