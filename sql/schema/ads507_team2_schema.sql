CREATE DATABASE  IF NOT EXISTS `api_fetch_raw` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `api_fetch_raw`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: ads507-finalproject.mysql.database.azure.com    Database: api_fetch_raw
-- ------------------------------------------------------
-- Server version	8.0.40-azure

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `api_fetch`
--

DROP TABLE IF EXISTS `api_fetch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_fetch` (
  `my_row_id` bigint unsigned NOT NULL AUTO_INCREMENT /*!80023 INVISIBLE */,
  `timestamp` datetime DEFAULT NULL,
  `travel_times_response` bigint DEFAULT NULL,
  `traffic_alerts_response` bigint DEFAULT NULL,
  `weather_alerts_response` bigint DEFAULT NULL,
  `status` text,
  PRIMARY KEY (`my_row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_fetch_hist`
--

DROP TABLE IF EXISTS `api_fetch_hist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_fetch_hist` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `timestamp` datetime DEFAULT NULL,
  `travel_times_response` bigint DEFAULT NULL,
  `traffic_alerts_response` bigint DEFAULT NULL,
  `weather_alerts_response` bigint DEFAULT NULL,
  `status` varchar(20) DEFAULT 'pending',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `application_logs`
--

DROP TABLE IF EXISTS `application_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `application_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `log_timestamp` datetime DEFAULT CURRENT_TIMESTAMP,
  `log_level` varchar(20) DEFAULT NULL,
  `log_message` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=797 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `monitoring_mismatched_log`
--

DROP TABLE IF EXISTS `monitoring_mismatched_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `monitoring_mismatched_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `table_name` varchar(50) NOT NULL,
  `mismatched_records` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `monitoring_refresh_log`
--

DROP TABLE IF EXISTS `monitoring_refresh_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `monitoring_refresh_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `table_name` varchar(50) NOT NULL,
  `last_refresh` datetime NOT NULL,
  `last_updated` datetime NOT NULL,
  `days_difference` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `road_lookup`
--

DROP TABLE IF EXISTS `road_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `road_lookup` (
  `raw_road_name` varchar(50) NOT NULL,
  `road_key` varchar(20) NOT NULL,
  PRIMARY KEY (`raw_road_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_travel_dim`
--

DROP TABLE IF EXISTS `time_travel_dim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_travel_dim` (
  `tt_id` int NOT NULL,
  `avg_time` int DEFAULT NULL,
  `cur_time` int DEFAULT NULL,
  `distance` float DEFAULT NULL,
  `end_lat` float DEFAULT NULL,
  `end_long` float DEFAULT NULL,
  `end_loc_key` varchar(45) DEFAULT NULL,
  `end_mp` float DEFAULT NULL,
  `end_road_key` varchar(45) DEFAULT NULL,
  `end_direction` varchar(45) DEFAULT NULL,
  `start_lat` float DEFAULT NULL,
  `start_long` float DEFAULT NULL,
  `start_loc_key` varchar(45) DEFAULT NULL,
  `start_mp` float DEFAULT NULL,
  `start_road_key` varchar(45) DEFAULT NULL,
  `start_direction` varchar(45) DEFAULT NULL,
  `alert_time` datetime DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `last_refresh` datetime DEFAULT NULL,
  PRIMARY KEY (`tt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_travel_hist`
--

DROP TABLE IF EXISTS `time_travel_hist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_travel_hist` (
  `my_row_id` bigint unsigned NOT NULL AUTO_INCREMENT /*!80023 INVISIBLE */,
  `AverageTime` bigint DEFAULT NULL,
  `CurrentTime` bigint DEFAULT NULL,
  `Description` text,
  `Distance` double DEFAULT NULL,
  `EndPoint` text,
  `Name` text,
  `StartPoint` text,
  `TimeUpdated` text,
  `TravelTimeID` bigint DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`my_row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9577 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_travel_raw`
--

DROP TABLE IF EXISTS `time_travel_raw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_travel_raw` (
  `my_row_id` bigint unsigned NOT NULL AUTO_INCREMENT /*!80023 INVISIBLE */,
  `AverageTime` bigint DEFAULT NULL,
  `CurrentTime` bigint DEFAULT NULL,
  `Description` text,
  `Distance` double DEFAULT NULL,
  `EndPoint` text,
  `Name` text,
  `StartPoint` text,
  `TimeUpdated` text,
  `TravelTimeID` bigint DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`my_row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=169 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `traffic_alerts_dim`
--

DROP TABLE IF EXISTS `traffic_alerts_dim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `traffic_alerts_dim` (
  `alertid` int NOT NULL,
  `county` varchar(45) DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `end_direction` char(1) DEFAULT NULL,
  `end_lat` decimal(15,12) DEFAULT NULL,
  `end_long` decimal(15,12) DEFAULT NULL,
  `end_loc_key` varchar(45) DEFAULT NULL,
  `end_mp` decimal(5,2) DEFAULT NULL,
  `end_road_key` varchar(45) DEFAULT NULL,
  `start_time` varchar(45) DEFAULT NULL,
  `start_direction` char(1) DEFAULT NULL,
  `start_lat` decimal(15,12) DEFAULT NULL,
  `start_long` decimal(15,12) DEFAULT NULL,
  `start_loc_key` varchar(45) DEFAULT NULL,
  `start_mp` decimal(5,2) DEFAULT NULL,
  `start_road_key` varchar(45) DEFAULT NULL,
  `event_cat` varchar(255) DEFAULT NULL,
  `event_stat` varchar(45) DEFAULT NULL,
  `event_desc` longtext,
  `priority` varchar(45) DEFAULT NULL,
  `region` varchar(45) DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `last_refresh` datetime DEFAULT NULL,
  PRIMARY KEY (`alertid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `traffic_alerts_hist`
--

DROP TABLE IF EXISTS `traffic_alerts_hist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `traffic_alerts_hist` (
  `my_row_id` bigint unsigned NOT NULL AUTO_INCREMENT /*!80023 INVISIBLE */,
  `AlertID` bigint DEFAULT NULL,
  `County` text,
  `EndRoadwayLocation` text,
  `EndTime` text,
  `EventCategory` text,
  `EventStatus` text,
  `ExtendedDescription` text,
  `HeadlineDescription` text,
  `LastUpdatedTime` text,
  `Priority` text,
  `Region` text,
  `StartRoadwayLocation` text,
  `StartTime` text,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`my_row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5566 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `traffic_alerts_raw`
--

DROP TABLE IF EXISTS `traffic_alerts_raw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `traffic_alerts_raw` (
  `my_row_id` bigint unsigned NOT NULL AUTO_INCREMENT /*!80023 INVISIBLE */,
  `AlertID` bigint DEFAULT NULL,
  `County` text,
  `EndRoadwayLocation` text,
  `EndTime` text,
  `EventCategory` text,
  `EventStatus` text,
  `ExtendedDescription` text,
  `HeadlineDescription` text,
  `LastUpdatedTime` text,
  `Priority` text,
  `Region` text,
  `StartRoadwayLocation` text,
  `StartTime` text,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`my_row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `valid_roads`
--

DROP TABLE IF EXISTS `valid_roads`;
/*!50001 DROP VIEW IF EXISTS `valid_roads`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `valid_roads` AS SELECT 
 1 AS `alertid`,
 1 AS `county`,
 1 AS `end_time`,
 1 AS `end_direction`,
 1 AS `end_lat`,
 1 AS `end_long`,
 1 AS `end_loc_key`,
 1 AS `end_mp`,
 1 AS `end_road_key`,
 1 AS `start_time`,
 1 AS `start_direction`,
 1 AS `start_lat`,
 1 AS `start_long`,
 1 AS `start_loc_key`,
 1 AS `start_mp`,
 1 AS `start_road_key`,
 1 AS `event_cat`,
 1 AS `event_stat`,
 1 AS `event_desc`,
 1 AS `priority`,
 1 AS `region`,
 1 AS `updated`,
 1 AS `last_refresh`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `valid_traffic_roads`
--

DROP TABLE IF EXISTS `valid_traffic_roads`;
/*!50001 DROP VIEW IF EXISTS `valid_traffic_roads`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `valid_traffic_roads` AS SELECT 
 1 AS `alertid`,
 1 AS `county`,
 1 AS `end_time`,
 1 AS `end_direction`,
 1 AS `end_lat`,
 1 AS `end_long`,
 1 AS `end_loc_key`,
 1 AS `end_mp`,
 1 AS `end_road_key`,
 1 AS `start_time`,
 1 AS `start_direction`,
 1 AS `start_lat`,
 1 AS `start_long`,
 1 AS `start_loc_key`,
 1 AS `start_mp`,
 1 AS `start_road_key`,
 1 AS `event_cat`,
 1 AS `event_stat`,
 1 AS `event_desc`,
 1 AS `priority`,
 1 AS `region`,
 1 AS `updated`,
 1 AS `last_refresh`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `valid_travel_roads`
--

DROP TABLE IF EXISTS `valid_travel_roads`;
/*!50001 DROP VIEW IF EXISTS `valid_travel_roads`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `valid_travel_roads` AS SELECT 
 1 AS `tt_id`,
 1 AS `avg_time`,
 1 AS `cur_time`,
 1 AS `distance`,
 1 AS `end_lat`,
 1 AS `end_long`,
 1 AS `end_loc_key`,
 1 AS `end_mp`,
 1 AS `end_road_key`,
 1 AS `end_direction`,
 1 AS `start_lat`,
 1 AS `start_long`,
 1 AS `start_loc_key`,
 1 AS `start_mp`,
 1 AS `start_road_key`,
 1 AS `start_direction`,
 1 AS `alert_time`,
 1 AS `updated`,
 1 AS `last_refresh`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `valid_weather_roads`
--

DROP TABLE IF EXISTS `valid_weather_roads`;
/*!50001 DROP VIEW IF EXISTS `valid_weather_roads`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `valid_weather_roads` AS SELECT 
 1 AS `station_id`,
 1 AS `barometric_pressure`,
 1 AS `latitude`,
 1 AS `longitude`,
 1 AS `loc_key`,
 1 AS `percipitation`,
 1 AS `reading_time`,
 1 AS `humidity`,
 1 AS `sky_coverage`,
 1 AS `raw_roadname`,
 1 AS `road_key`,
 1 AS `mp`,
 1 AS `temp`,
 1 AS `visibility`,
 1 AS `wind_direction`,
 1 AS `wind_gust_speed`,
 1 AS `avg_wind_speed`,
 1 AS `updated`,
 1 AS `last_refresh`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `weather_alerts_dim`
--

DROP TABLE IF EXISTS `weather_alerts_dim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `weather_alerts_dim` (
  `station_id` varchar(45) NOT NULL,
  `barometric_pressure` float DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `loc_key` varchar(45) DEFAULT NULL,
  `percipitation` varchar(45) DEFAULT NULL,
  `reading_time` datetime DEFAULT NULL,
  `humidity` float DEFAULT NULL,
  `sky_coverage` varchar(45) DEFAULT NULL,
  `raw_roadname` varchar(45) DEFAULT NULL,
  `road_key` varchar(45) DEFAULT NULL,
  `mp` varchar(45) DEFAULT NULL,
  `temp` float DEFAULT NULL,
  `visibility` float DEFAULT NULL,
  `wind_direction` varchar(45) DEFAULT NULL,
  `wind_gust_speed` float DEFAULT NULL,
  `avg_wind_speed` float DEFAULT NULL,
  `updated` datetime DEFAULT NULL,
  `last_refresh` datetime DEFAULT NULL,
  PRIMARY KEY (`station_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `weather_alerts_hist`
--

DROP TABLE IF EXISTS `weather_alerts_hist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `weather_alerts_hist` (
  `my_row_id` bigint unsigned NOT NULL AUTO_INCREMENT /*!80023 INVISIBLE */,
  `BarometricPressure` double DEFAULT NULL,
  `Latitude` double DEFAULT NULL,
  `Longitude` double DEFAULT NULL,
  `PrecipitationInInches` text,
  `ReadingTime` text,
  `RelativeHumidity` double DEFAULT NULL,
  `SkyCoverage` text,
  `StationID` bigint DEFAULT NULL,
  `StationName` text,
  `TemperatureInFahrenheit` double DEFAULT NULL,
  `Visibility` double DEFAULT NULL,
  `WindDirection` double DEFAULT NULL,
  `WindDirectionCardinal` text,
  `WindGustSpeedInMPH` double DEFAULT NULL,
  `WindSpeedInMPH` double DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`my_row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5770 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `weather_alerts_raw`
--

DROP TABLE IF EXISTS `weather_alerts_raw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `weather_alerts_raw` (
  `my_row_id` bigint unsigned NOT NULL AUTO_INCREMENT /*!80023 INVISIBLE */,
  `BarometricPressure` double DEFAULT NULL,
  `Latitude` double DEFAULT NULL,
  `Longitude` double DEFAULT NULL,
  `PrecipitationInInches` text,
  `ReadingTime` text,
  `RelativeHumidity` double DEFAULT NULL,
  `SkyCoverage` text,
  `StationID` bigint DEFAULT NULL,
  `StationName` text,
  `TemperatureInFahrenheit` double DEFAULT NULL,
  `Visibility` double DEFAULT NULL,
  `WindDirection` double DEFAULT NULL,
  `WindDirectionCardinal` text,
  `WindGustSpeedInMPH` double DEFAULT NULL,
  `WindSpeedInMPH` double DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`my_row_id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'api_fetch_raw'
--
/*!50003 DROP PROCEDURE IF EXISTS `TransformTrafficAlerts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`sashal`@`%` PROCEDURE `TransformTrafficAlerts`()
BEGIN
    -- Clear existing data
    TRUNCATE TABLE traffic_alerts_dim;

    -- Insert transformed data
    INSERT INTO traffic_alerts_dim (
        alertid,
        county,
        end_time,
        end_direction,
        end_lat,
        end_long,
        end_loc_key,
        end_mp,
        end_road_key,
        start_time,
        start_direction,  
        start_lat,
        start_long,
        start_loc_key,
        start_mp,
        start_road_key,
        event_cat,
        event_stat,
        event_desc,
        priority,
        region,
        updated, 
        last_refresh
    )
   SELECT
        alertid,
        county,
        -- Convert endtime from Unix timestamp to DATETIME
        FROM_UNIXTIME(SUBSTRING_INDEX(SUBSTRING_INDEX(endtime, '(', -1), '-', 1) / 1000) AS end_time,

        -- End location extraction
        JSON_UNQUOTE(JSON_EXTRACT(endroadwaylocation, '$.Direction')) AS end_direction,
        JSON_UNQUOTE(JSON_EXTRACT(endroadwaylocation, '$.Latitude')) AS end_lat,
        JSON_UNQUOTE(JSON_EXTRACT(endroadwaylocation, '$.Longitude')) AS end_long,

        -- Create hashed end_loc_key
        MD5(CONCAT(
            IFNULL(ROUND(JSON_UNQUOTE(JSON_EXTRACT(endroadwaylocation, '$.Latitude')), 3), '0'), 
            IFNULL(ROUND(JSON_UNQUOTE(JSON_EXTRACT(endroadwaylocation, '$.Longitude')), 3), '0')
        )) AS end_loc_key,

        JSON_UNQUOTE(JSON_EXTRACT(endroadwaylocation, '$.MilePost')) AS end_mp,
         -- end road_key mapped to road_lookup
        (SELECT road_key FROM road_lookup 
         WHERE JSON_UNQUOTE(JSON_EXTRACT(endroadwaylocation, '$.RoadName')) = raw_road_name 
         LIMIT 1) AS end_road_key,

        -- Convert starttime from Unix timestamp to DATETIME
        FROM_UNIXTIME(SUBSTRING_INDEX(SUBSTRING_INDEX(starttime, '(', -1), '-', 1) / 1000) AS start_time,

        -- Start location extraction
        JSON_UNQUOTE(JSON_EXTRACT(startroadwaylocation, '$.Direction')) AS start_direction,
        JSON_UNQUOTE(JSON_EXTRACT(startroadwaylocation, '$.Latitude')) AS start_lat,
        JSON_UNQUOTE(JSON_EXTRACT(startroadwaylocation, '$.Longitude')) AS start_long,

        -- Create hashed start_loc_key
        MD5(CONCAT(
            IFNULL(ROUND(JSON_UNQUOTE(JSON_EXTRACT(startroadwaylocation, '$.Latitude')), 3), '0'), 
            IFNULL(ROUND(JSON_UNQUOTE(JSON_EXTRACT(startroadwaylocation, '$.Longitude')), 3), '0')
        )) AS start_loc_key,

        JSON_UNQUOTE(JSON_EXTRACT(startroadwaylocation, '$.MilePost')) AS start_mp,
        -- start road_key mapped to road_lookup
        (SELECT road_key FROM road_lookup 
         WHERE JSON_UNQUOTE(JSON_EXTRACT(startroadwaylocation, '$.RoadName')) = raw_road_name 
         LIMIT 1) AS start_road_key,

        -- Other direct mappings
        eventcategory AS event_cat, 
        eventstatus AS event_stat, 
        headlinedescription AS event_desc, 
        priority, 
        region, 
        timestamp AS updated, 
        -- Add timestamp for update
        NOW() AS last_refresh
    FROM traffic_alerts_raw;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TransformTravelTime` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`sashal`@`%` PROCEDURE `TransformTravelTime`()
BEGIN
    -- Clear existing data
    TRUNCATE TABLE time_travel_dim;

    -- Insert transformed data
    INSERT INTO time_travel_dim (
        tt_id,
        avg_time,
        cur_time,
        distance,
        end_lat,
        end_long,
        end_loc_key,
        end_mp,
        end_road_key,
        end_direction,
        start_lat,
        start_long,
        start_loc_key,
        start_mp,
        start_road_key,
        start_direction,
        alert_time,
        updated,
        last_refresh
    )
    SELECT
        -- Straight pull
        traveltimeid AS tt_id,
        averagetime AS avg_time,
        currenttime AS cur_time, 
        distance, 
        
        -- Endpoint extraction 
        JSON_UNQUOTE(JSON_EXTRACT(endpoint, '$.Latitude')) AS end_lat,
        JSON_UNQUOTE(JSON_EXTRACT(endpoint, '$.Longitude')) AS end_long,
         -- Create hashed end_loc_key
        MD5(CONCAT(
            IFNULL(ROUND(JSON_UNQUOTE(JSON_EXTRACT(endpoint, '$.Latitude')), 3), '0'), 
            IFNULL(ROUND(JSON_UNQUOTE(JSON_EXTRACT(endpoint, '$.Longitude')), 3), '0')
        )) AS end_loc_key,
        -- endpoint xtraction continue
        JSON_UNQUOTE(JSON_EXTRACT(endpoint, '$.MilePost')) AS end_mp,
        -- map roadname from road_lookup to standardize
        (SELECT road_key FROM road_lookup WHERE JSON_UNQUOTE(JSON_EXTRACT(endpoint, '$.RoadName')) = raw_road_name LIMIT 1) AS end_road_key,
		-- endpoint extraction continue
        JSON_UNQUOTE(JSON_EXTRACT(endpoint, '$.Direction')) AS end_direction,
        -- Startpoint extraction 
        JSON_UNQUOTE(JSON_EXTRACT(startpoint, '$.Latitude')) AS start_lat,
        JSON_UNQUOTE(JSON_EXTRACT(startpoint, '$.Longitude')) AS start_long,
        -- Create hashed start_loc_key
        MD5(CONCAT(
            IFNULL(ROUND(JSON_UNQUOTE(JSON_EXTRACT(startpoint, '$.Latitude')), 3), '0'), 
            IFNULL(ROUND(JSON_UNQUOTE(JSON_EXTRACT(startpoint, '$.Longitude')), 3), '0')
        )) AS start_loc_key,
        -- startpoint extraction continue
        JSON_UNQUOTE(JSON_EXTRACT(startpoint, '$.MilePost')) AS start_mp,
        -- roadmap 
        (SELECT road_key FROM road_lookup WHERE JSON_UNQUOTE(JSON_EXTRACT(startpoint, '$.RoadName')) = raw_road_name LIMIT 1) AS start_road_key,
        -- startpoint extraction continue
        JSON_UNQUOTE(JSON_EXTRACT(startpoint, '$.Direction')) AS start_direction, 
        
        -- Convert timeupdates from UNIX
        FROM_UNIXTIME(SUBSTRING_INDEX(SUBSTRING_INDEX(timeupdated, '(', -1), '-', 1) / 1000) AS alert_time,

        -- Other direct mappings
        timestamp AS updated, 
        
        -- Add timestamp for update
        NOW() AS last_refresh
    FROM time_travel_raw;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TransformWeatherAlerts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`sashal`@`%` PROCEDURE `TransformWeatherAlerts`()
BEGIN
    TRUNCATE TABLE weather_alerts_dim;

    INSERT INTO weather_alerts_dim (
        station_id, 
        barometric_pressure, 
        latitude, 
        longitude,
        loc_key,
        percipitation,
        reading_time,
        humidity, 
        sky_coverage,
        raw_roadname,
        road_key, 
        mp, 
        temp, 
        visibility, 
        wind_direction, 
        wind_gust_speed,
        avg_wind_speed,
        updated, 
        last_refresh
    ) 
    SELECT 
    -- direct selections
        stationID AS station_id, 
        raw.barometricpressure AS barometric_pressure,
        raw.latitude,
        raw.longitude,

-- create geohashkey for location
        MD5(CONCAT(
            IFNULL(ROUND(raw.latitude, 3), '0'), 
            '_', 
            IFNULL(ROUND(raw.longitude, 3), '0')
        )) AS loc_key,
        COALESCE(CAST(raw.precipitationininches AS CHAR), 'UNKNOWN') AS percipitation,
        FROM_UNIXTIME(SUBSTRING_INDEX(SUBSTRING_INDEX(raw.readingtime, '(', -1), '-', 1) / 1000) AS reading_time,
-- direct selection
        raw.relativehumidity AS humidity,
-- direct select sky coverage, but add UNKNOWN if null
        COALESCE(CAST(raw.skycoverage AS CHAR), 'UNKNOWN') AS sky_coverage,
-- REGEXP identifies a pattern in station name to help extract all roadnames
        CASE 
            WHEN raw.stationname REGEXP 'I-[0-9]+' THEN REGEXP_SUBSTR(raw.stationname, 'I-[0-9]+')
            WHEN raw.stationname REGEXP 'US [0-9]+' THEN REGEXP_SUBSTR(raw.stationname, 'US [0-9]+')
            WHEN raw.stationname REGEXP 'SR [0-9]+' THEN REGEXP_SUBSTR(raw.stationname, 'SR [0-9]+')
            ELSE 'UNKNOWN'
        END AS raw_roadname,
-- Go to the road look up key to make sure that we can normalize format
        (SELECT road_key FROM road_lookup 
         WHERE road_lookup.raw_road_name = 
            (CASE 
                WHEN raw.stationname REGEXP 'I-[0-9]+' THEN REGEXP_SUBSTR(raw.stationname, 'I-[0-9]+')
                WHEN raw.stationname REGEXP 'US [0-9]+' THEN REGEXP_SUBSTR(raw.stationname, 'US [0-9]+')
                WHEN raw.stationname REGEXP 'SR [0-9]+' THEN REGEXP_SUBSTR(raw.stationname, 'SR [0-9]+')
                ELSE 'UNKNOWN'
            END) 
         LIMIT 1) AS road_key,
-- regep pattern finds anything aferr MP to extract the milepost
        CASE 
            WHEN raw.stationname REGEXP 'mp [0-9]+\\.[0-9]+' THEN 
                SUBSTRING_INDEX(SUBSTRING_INDEX(raw.stationname, 'mp ', -1), ' ', 1)
            ELSE 'UNKNOWN'
        END AS mp,
-- direct pull
        raw.temperatureinfahrenheit AS temp, 
        raw.visibility, 
        raw.winddirectioncardinal AS wind_direction,
        raw.windgustspeedinmph AS wind_gust_speed,
        raw.windspeedinmph AS avg_wind_speed, 
        raw.timestamp AS updated, 
-- Add our last refresh for this procedure
        NOW() AS last_refresh
    FROM weather_alerts_raw AS raw;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_mismatched_log` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`amayranib`@`%` PROCEDURE `update_mismatched_log`()
Begin 
-- Clear existing data
TRUNCATE TABLE monitoring_mismatched_log;

-- Insert Traffic Alerts
INSERT INTO monitoring_mismatched_log( table_name, mismatched_records)
SELECT 
    'Traffic Alerts' AS table_name,
    COUNT(*) AS mismatched_records
FROM traffic_alerts_dim dim
JOIN traffic_alerts_raw raw ON dim.alertid = raw.AlertID
WHERE dim.updated <> FROM_UNIXTIME(raw.timestamp);

-- Insert Weather Alerts
INSERT INTO monitoring_mismatched_log( table_name, mismatched_records)
SELECT 
    'Weather Alerts' AS table_name,
    COUNT(*) AS mismatched_records
FROM weather_alerts_dim dim
JOIN weather_alerts_raw raw ON dim.station_id = CAST(raw.StationID AS CHAR)
WHERE dim.updated <> FROM_UNIXTIME(raw.timestamp);

-- Insert Time Travel Alerts
INSERT INTO monitoring_mismatched_log( table_name, mismatched_records)
SELECT 
    'Time Travel Alerts' AS table_name,
    COUNT(*) AS mismatched_records
FROM time_travel_dim dim
JOIN time_travel_raw raw ON dim.tt_id = raw.TravelTimeID
WHERE dim.updated <> FROM_UNIXTIME(raw.timestamp);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_monitoring_log` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`amayranib`@`%` PROCEDURE `update_monitoring_log`()
BEGIN

-- Clear existing data
    TRUNCATE TABLE monitoring_refresh_log;

-- Insert Traffic Alerts Monitoring
INSERT INTO monitoring_refresh_log( table_name, last_refresh, last_updated, days_difference)
SELECT 
	'Traffic Alerts' AS table_name,
     FROM_UNIXTIME(MAX(last_refresh)) AS last_refresh,
    MAX(updated) AS last_updated,
    TIMESTAMPDIFF(DAY, MAX(last_refresh), MAX(updated)) AS days_difference 
FROM traffic_alerts_dim
WHERE last_refresh IS NOT NULL AND updated IS NOT NULL;

-- Insert Weather Alerts Monitoring
INSERT INTO monitoring_refresh_log( table_name, last_refresh, last_updated, days_difference)
SELECT 
	'Weather Alerts' AS table_name,
   FROM_UNIXTIME(MAX(last_refresh)) AS last_refresh,
    MAX(updated) AS last_updated,
    TIMESTAMPDIFF(DAY, MAX(last_refresh), MAX(updated)) AS days_difference 
FROM weather_alerts_dim
WHERE last_refresh IS NOT NULL AND updated IS NOT NULL;

-- Insert Travel Time Alerts Monitoring
INSERT INTO monitoring_refresh_log( table_name, last_refresh, last_updated, days_difference)
SELECT 
	'Travel Time Alerts' AS table_name,
     FROM_UNIXTIME(MAX(last_refresh)) AS last_refresh,
    MAX(updated) AS last_updated,
    TIMESTAMPDIFF(DAY, MAX(last_refresh), MAX(updated)) AS days_difference 
FROM time_travel_dim
WHERE last_refresh IS NOT NULL AND updated IS NOT NULL;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `valid_roads`
--

/*!50001 DROP VIEW IF EXISTS `valid_roads`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`amayranib`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `valid_roads` AS select `traffic_alerts_dim`.`alertid` AS `alertid`,`traffic_alerts_dim`.`county` AS `county`,`traffic_alerts_dim`.`end_time` AS `end_time`,`traffic_alerts_dim`.`end_direction` AS `end_direction`,`traffic_alerts_dim`.`end_lat` AS `end_lat`,`traffic_alerts_dim`.`end_long` AS `end_long`,`traffic_alerts_dim`.`end_loc_key` AS `end_loc_key`,`traffic_alerts_dim`.`end_mp` AS `end_mp`,`traffic_alerts_dim`.`end_road_key` AS `end_road_key`,`traffic_alerts_dim`.`start_time` AS `start_time`,`traffic_alerts_dim`.`start_direction` AS `start_direction`,`traffic_alerts_dim`.`start_lat` AS `start_lat`,`traffic_alerts_dim`.`start_long` AS `start_long`,`traffic_alerts_dim`.`start_loc_key` AS `start_loc_key`,`traffic_alerts_dim`.`start_mp` AS `start_mp`,`traffic_alerts_dim`.`start_road_key` AS `start_road_key`,`traffic_alerts_dim`.`event_cat` AS `event_cat`,`traffic_alerts_dim`.`event_stat` AS `event_stat`,`traffic_alerts_dim`.`event_desc` AS `event_desc`,`traffic_alerts_dim`.`priority` AS `priority`,`traffic_alerts_dim`.`region` AS `region`,`traffic_alerts_dim`.`updated` AS `updated`,`traffic_alerts_dim`.`last_refresh` AS `last_refresh` from `traffic_alerts_dim` where ((`traffic_alerts_dim`.`start_road_key` is not null) or (`traffic_alerts_dim`.`end_road_key` is not null)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `valid_traffic_roads`
--

/*!50001 DROP VIEW IF EXISTS `valid_traffic_roads`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`amayranib`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `valid_traffic_roads` AS select `traffic_alerts_dim`.`alertid` AS `alertid`,`traffic_alerts_dim`.`county` AS `county`,`traffic_alerts_dim`.`end_time` AS `end_time`,`traffic_alerts_dim`.`end_direction` AS `end_direction`,`traffic_alerts_dim`.`end_lat` AS `end_lat`,`traffic_alerts_dim`.`end_long` AS `end_long`,`traffic_alerts_dim`.`end_loc_key` AS `end_loc_key`,`traffic_alerts_dim`.`end_mp` AS `end_mp`,`traffic_alerts_dim`.`end_road_key` AS `end_road_key`,`traffic_alerts_dim`.`start_time` AS `start_time`,`traffic_alerts_dim`.`start_direction` AS `start_direction`,`traffic_alerts_dim`.`start_lat` AS `start_lat`,`traffic_alerts_dim`.`start_long` AS `start_long`,`traffic_alerts_dim`.`start_loc_key` AS `start_loc_key`,`traffic_alerts_dim`.`start_mp` AS `start_mp`,`traffic_alerts_dim`.`start_road_key` AS `start_road_key`,`traffic_alerts_dim`.`event_cat` AS `event_cat`,`traffic_alerts_dim`.`event_stat` AS `event_stat`,`traffic_alerts_dim`.`event_desc` AS `event_desc`,`traffic_alerts_dim`.`priority` AS `priority`,`traffic_alerts_dim`.`region` AS `region`,`traffic_alerts_dim`.`updated` AS `updated`,`traffic_alerts_dim`.`last_refresh` AS `last_refresh` from `traffic_alerts_dim` where ((`traffic_alerts_dim`.`start_road_key` is not null) and (`traffic_alerts_dim`.`start_road_key` <> 'UNKNOWN') and (`traffic_alerts_dim`.`end_road_key` is not null) and (`traffic_alerts_dim`.`end_road_key` <> 'UNKNOWN')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `valid_travel_roads`
--

/*!50001 DROP VIEW IF EXISTS `valid_travel_roads`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`amayranib`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `valid_travel_roads` AS select `time_travel_dim`.`tt_id` AS `tt_id`,`time_travel_dim`.`avg_time` AS `avg_time`,`time_travel_dim`.`cur_time` AS `cur_time`,`time_travel_dim`.`distance` AS `distance`,`time_travel_dim`.`end_lat` AS `end_lat`,`time_travel_dim`.`end_long` AS `end_long`,`time_travel_dim`.`end_loc_key` AS `end_loc_key`,`time_travel_dim`.`end_mp` AS `end_mp`,`time_travel_dim`.`end_road_key` AS `end_road_key`,`time_travel_dim`.`end_direction` AS `end_direction`,`time_travel_dim`.`start_lat` AS `start_lat`,`time_travel_dim`.`start_long` AS `start_long`,`time_travel_dim`.`start_loc_key` AS `start_loc_key`,`time_travel_dim`.`start_mp` AS `start_mp`,`time_travel_dim`.`start_road_key` AS `start_road_key`,`time_travel_dim`.`start_direction` AS `start_direction`,`time_travel_dim`.`alert_time` AS `alert_time`,`time_travel_dim`.`updated` AS `updated`,`time_travel_dim`.`last_refresh` AS `last_refresh` from `time_travel_dim` where ((`time_travel_dim`.`start_road_key` is not null) and (`time_travel_dim`.`start_road_key` <> 'UNKNOWN') and (`time_travel_dim`.`end_road_key` is not null) and (`time_travel_dim`.`end_road_key` <> 'UNKNOWN')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `valid_weather_roads`
--

/*!50001 DROP VIEW IF EXISTS `valid_weather_roads`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`amayranib`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `valid_weather_roads` AS select `weather_alerts_dim`.`station_id` AS `station_id`,`weather_alerts_dim`.`barometric_pressure` AS `barometric_pressure`,`weather_alerts_dim`.`latitude` AS `latitude`,`weather_alerts_dim`.`longitude` AS `longitude`,`weather_alerts_dim`.`loc_key` AS `loc_key`,`weather_alerts_dim`.`percipitation` AS `percipitation`,`weather_alerts_dim`.`reading_time` AS `reading_time`,`weather_alerts_dim`.`humidity` AS `humidity`,`weather_alerts_dim`.`sky_coverage` AS `sky_coverage`,`weather_alerts_dim`.`raw_roadname` AS `raw_roadname`,`weather_alerts_dim`.`road_key` AS `road_key`,`weather_alerts_dim`.`mp` AS `mp`,`weather_alerts_dim`.`temp` AS `temp`,`weather_alerts_dim`.`visibility` AS `visibility`,`weather_alerts_dim`.`wind_direction` AS `wind_direction`,`weather_alerts_dim`.`wind_gust_speed` AS `wind_gust_speed`,`weather_alerts_dim`.`avg_wind_speed` AS `avg_wind_speed`,`weather_alerts_dim`.`updated` AS `updated`,`weather_alerts_dim`.`last_refresh` AS `last_refresh` from `weather_alerts_dim` where ((`weather_alerts_dim`.`road_key` is not null) and (`weather_alerts_dim`.`road_key` <> 'UNKNOWN')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-22  7:57:10
