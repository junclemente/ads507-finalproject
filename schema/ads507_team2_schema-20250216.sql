CREATE DATABASE  IF NOT EXISTS `api_fetch_raw` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `api_fetch_raw`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: ads507-finalproject.mysql.database.azure.com    Database: api_fetch_raw
-- ------------------------------------------------------
-- Server version	8.0.39-azure

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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `road_lookup`
--

DROP TABLE IF EXISTS `road_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `road_lookup` (
  `raw_road_name` varchar(50) NOT NULL,
  `road_key` varchar(20) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=3529 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=1931 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=2123 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-16  7:56:11
