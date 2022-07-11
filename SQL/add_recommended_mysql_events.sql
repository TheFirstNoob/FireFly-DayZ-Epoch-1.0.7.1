--
-- http://epochmod.gamepedia.com/A2Epoch:Server_Installation_Instructions_Extended
--

-- ----------------------------
-- Function structure for FindVehicleKeysCount
-- ----------------------------
DROP FUNCTION IF EXISTS `FindVehicleKeysCount`;
DELIMITER ;;
CREATE FUNCTION `FindVehicleKeysCount`(`keyId` INT)
	RETURNS int(11)
	DETERMINISTIC
BEGIN
    DECLARE totalKeys INT DEFAULT 0;
    DECLARE keyName VARCHAR(32) DEFAULT "";
    DECLARE keysInChar INT DEFAULT 0;
    DECLARE keysInObj INT DEFAULT 0;

    SET keyName = (CASE
        WHEN `keyId` < 2501 THEN CONCAT('ItemKeyGreen', `keyId`)
        WHEN `keyId` < 5001 THEN CONCAT('ItemKeyRed', `keyId` - 2500)
        WHEN `keyId` < 7501 THEN CONCAT('ItemKeyBlue', `keyId` - 5000)
        WHEN `keyId` < 10001 THEN CONCAT('ItemKeyYellow', `keyId` - 7500)
        WHEN `keyId` < 12501 THEN CONCAT('ItemKeyBlack', `keyId` - 10000)
        ELSE 'ERROR'
    END);

    SET keysInChar = (SELECT COUNT(*) FROM `Character_DATA` WHERE `Alive` = '1' AND (`Inventory` LIKE CONCAT('%', keyName, '%') OR `Backpack` LIKE CONCAT('%', keyName, '%')));
    SET keysInObj = (SELECT COUNT(*) FROM `Object_DATA` WHERE `Inventory` LIKE CONCAT('%', keyName, '%'));

    RETURN (keysInChar + keysInObj);
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for DeleteNonKeyVehicles
-- Example usage: SELECT DeleteNonKeyVehicles();
-- ----------------------------
DROP FUNCTION IF EXISTS `DeleteNonKeyVehicles`;
DELIMITER ;;
CREATE FUNCTION `DeleteNonKeyVehicles`()
	RETURNS int(11)
	DETERMINISTIC
BEGIN
	DELETE FROM
		`Object_DATA`
	WHERE
		`Object_DATA`.`CharacterID` <> 0
		AND `Object_DATA`.`CharacterID` <= 12500
		AND `Object_DATA`.`Classname` NOT LIKE '%Tent%'
		AND `Object_DATA`.`Classname` NOT LIKE '%Locked'
		AND `Object_DATA`.`Classname` NOT LIKE 'Land\_%' -- added escape character so LandRover vehicles are not ignored
		AND `Object_DATA`.`Classname` NOT LIKE 'Cinder%'
		AND `Object_DATA`.`Classname` NOT LIKE 'Wood%'
		AND `Object_DATA`.`Classname` NOT LIKE 'Metal%'
		AND `Object_DATA`.`Classname` NOT LIKE '%Storage%'
		AND `Object_DATA`.`Classname` NOT LIKE '%CamoNet_DZ'
		AND `Object_DATA`.`Classname` NOT LIKE 'Concrete%'
		AND `Object_DATA`.`Classname` NOT LIKE 'Glass%'
		AND `Object_DATA`.`Classname` NOT LIKE 'Stash%'
		AND `Object_DATA`.`Classname` NOT LIKE 'Door%'
		AND `Object_DATA`.`Classname` NOT LIKE 'Garage%'
		AND `Object_DATA`.`Classname` NOT LIKE 'Helipad%'
		AND `Object_DATA`.`Classname` NOT LIKE '%Bench%'
		AND `Object_DATA`.`Classname` NOT LIKE 'Vendmachine%'
		AND `Object_DATA`.`Classname` NOT LIKE '%Trap%'
		AND `Object_DATA`.`Classname` NOT LIKE 'GunRack%'
		AND `Object_DATA`.`Classname` NOT LIKE '%_Static_DZ'
		AND `Object_DATA`.`Classname` NOT LIKE 'Plant_%'
		AND `Object_DATA`.`Classname` NOT LIKE 'Compost_Barrel_%'
		AND `Object_DATA`.`Classname` NOT LIKE 'DragonTeeth_%'
		AND `Object_DATA`.`Classname` NOT LIKE '%Footbridge_DZ'
		AND `Object_DATA`.`Classname` NOT LIKE 'HeavyBagFence%'
		AND `Object_DATA`.`Classname` NOT LIKE 'SandNest%'
		AND `Object_DATA`.`Classname` NOT LIKE 'StorageBarrel%'
		AND `Object_DATA`.`Classname` NOT LIKE '%Crate_DZ'
		AND `Object_DATA`.`Classname` NOT LIKE '%_Stable_DZE'
		AND `Object_DATA`.`Classname` NOT IN ('Wild_Bee_Hive_DZE','Watertower_DZE','Watertank_DZE','Fueltank_DZE','Satellite_Dish_DZE','Boggle_DZE','Postbox_DZE','Doghouse_DZE','Chicken_Coop_DZE','Rabbit_Hutch_DZE','Windbreak_DZ','BarbedGate_DZ','FortifiedWire_DZ','Arcade_DZ','Sofa_DZ','Armchair_DZ','ATM_DZ','Server_Rack_DZ','Washing_Machine_DZ','Fridge_DZ','Wardrobe_DZ','Commode_DZ','Stoneoven_DZ','CookTripod_DZ','CCTV_DZ','Office_Chair_DZ','Table_DZ','Bed_DZ','Water_Pump_DZ','Greenhouse_DZ','Notebook_DZ','Scaffolding_DZ','OutHouse_DZ','Sandbag1_DZ', 'FireBarrel_DZ', 'StickFence_DZ', 'LightPole_DZ', 'DeerStand_DZ', 'Plastic_Pole_EP1_DZ', 'Hedgehog_DZ', 'FuelPump_DZ', 'Fort_RazorWire', 'Fence_corrugated_DZ', 'CanvasHut_DZ', 'Generator_DZ', 'BagFenceRound_DZ')
		AND FindVehicleKeysCount(Object_DATA.CharacterID) = 0;

	RETURN ROW_COUNT();
END
;;
DELIMITER ;

-- ----------------------------
-- Removes destroyed vehicles and objects
-- ----------------------------
DROP EVENT IF EXISTS `removeDamagedVehicles`;
DELIMITER ;;
CREATE EVENT `removeDamagedVehicles` ON SCHEDULE EVERY 1 DAY COMMENT 'Removes destroyed vehicles and objects' DO DELETE FROM `Object_DATA` WHERE Damage >= 1
;;
DELIMITER ;

-- ----------------------------
-- Removes old objects and vehicles after 14 days if not updated
-- ----------------------------
DROP EVENT IF EXISTS `removeObjectOld`;
DELIMITER ;;
CREATE EVENT `removeObjectOld` ON SCHEDULE EVERY 1 DAY COMMENT 'Removes old objects and vehicles after 14 days if not updated' DO DELETE FROM `Object_DATA` WHERE `LastUpdated` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 14 DAY)
;;
DELIMITER ;

-- ----------------------------
-- Sets damage on objects so they can be maintained
-- ----------------------------
DROP EVENT IF EXISTS `setDamageOnAge`;
DELIMITER ;;
CREATE EVENT `setDamageOnAge` ON SCHEDULE EVERY 1 DAY COMMENT 'Sets damage on objects so they can be maintained' DO UPDATE `Object_DATA` SET `Damage`=0.1 WHERE `Hitpoints` = '[]' AND `Fuel` = 0.0 AND `Datestamp` < DATE_SUB(CURRENT_TIMESTAMP, INTERVAL 3 DAY)
;;
DELIMITER ;

-- ----------------------------
-- Event structure for UnlockNonKeyVehicles
-- ----------------------------
DROP EVENT IF EXISTS `UnlockNonKeyVehicles`;
DELIMITER ;;
CREATE EVENT `UnlockNonKeyVehicles` ON SCHEDULE EVERY 1 DAY DO UPDATE
			`Object_DATA`
		SET
			`Object_DATA`.`CharacterID` = 0
		WHERE
			`Object_DATA`.`CharacterID` <> 0
			AND `Object_DATA`.`CharacterID` <= 12500
			AND `Object_DATA`.`Classname` NOT LIKE '%Tent%'
			AND `Object_DATA`.`Classname` NOT LIKE '%Locked'
			AND `Object_DATA`.`Classname` NOT LIKE 'Land\_%' -- added escape character so LandRover vehicles are not ignored
			AND `Object_DATA`.`Classname` NOT LIKE 'Cinder%'
			AND `Object_DATA`.`Classname` NOT LIKE 'Wood%'
			AND `Object_DATA`.`Classname` NOT LIKE 'Metal%'
			AND `Object_DATA`.`Classname` NOT LIKE '%Storage%'
			AND `Object_DATA`.`Classname` NOT LIKE '%CamoNet_DZ'
			AND `Object_DATA`.`Classname` NOT LIKE 'Concrete%'
			AND `Object_DATA`.`Classname` NOT LIKE 'Glass%'
			AND `Object_DATA`.`Classname` NOT LIKE 'Stash%'
			AND `Object_DATA`.`Classname` NOT LIKE 'Door%'
			AND `Object_DATA`.`Classname` NOT LIKE 'Garage%'
			AND `Object_DATA`.`Classname` NOT LIKE 'Helipad%'
			AND `Object_DATA`.`Classname` NOT LIKE '%Bench%'
			AND `Object_DATA`.`Classname` NOT LIKE 'Vendmachine%'
			AND `Object_DATA`.`Classname` NOT LIKE '%Trap%'
			AND `Object_DATA`.`Classname` NOT LIKE 'GunRack%'
			AND `Object_DATA`.`Classname` NOT LIKE '%_Static_DZ'
			AND `Object_DATA`.`Classname` NOT LIKE 'Plant_%'
			AND `Object_DATA`.`Classname` NOT LIKE 'Compost_Barrel_%'
			AND `Object_DATA`.`Classname` NOT LIKE 'DragonTeeth_%'
			AND `Object_DATA`.`Classname` NOT LIKE '%Footbridge_DZ'
			AND `Object_DATA`.`Classname` NOT LIKE 'HeavyBagFence%'
			AND `Object_DATA`.`Classname` NOT LIKE 'SandNest%'
			AND `Object_DATA`.`Classname` NOT LIKE 'StorageBarrel%'
			AND `Object_DATA`.`Classname` NOT LIKE '%Crate_DZ'
			AND `Object_DATA`.`Classname` NOT LIKE '%_Stable_DZE'
			AND `Object_DATA`.`Classname` NOT IN ('Wild_Bee_Hive_DZE','Watertower_DZE','Watertank_DZE','Fueltank_DZE','Satellite_Dish_DZE','Boggle_DZE','Postbox_DZE','Doghouse_DZE','Chicken_Coop_DZE','Rabbit_Hutch_DZE','Windbreak_DZ','BarbedGate_DZ','FortifiedWire_DZ','Arcade_DZ','Sofa_DZ','Armchair_DZ','ATM_DZ','Server_Rack_DZ','Washing_Machine_DZ','Fridge_DZ','Wardrobe_DZ','Commode_DZ','Stoneoven_DZ','CookTripod_DZ','CCTV_DZ','Office_Chair_DZ','Table_DZ','Bed_DZ','Water_Pump_DZ','Greenhouse_DZ','Notebook_DZ','Scaffolding_DZ','OutHouse_DZ','Sandbag1_DZ', 'FireBarrel_DZ', 'StickFence_DZ', 'LightPole_DZ', 'DeerStand_DZ', 'Plastic_Pole_EP1_DZ', 'Hedgehog_DZ', 'FuelPump_DZ', 'Fort_RazorWire', 'Fence_corrugated_DZ', 'CanvasHut_DZ', 'Generator_DZ', 'BagFenceRound_DZ')
			AND FindVehicleKeysCount(Object_DATA.CharacterID) = 0
;;
DELIMITER ;
