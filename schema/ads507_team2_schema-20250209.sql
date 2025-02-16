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
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `travel_times_response` varchar(20) DEFAULT NULL,
  `traffic_alerts_response` varchar(20) DEFAULT NULL,
  `weather_alerts_response` varchar(20) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='						';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `time_travel_raw`
--

DROP TABLE IF EXISTS `time_travel_raw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_travel_raw` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `averagetime` float DEFAULT NULL,
  `description` longtext,
  `currenttime` float DEFAULT NULL,
  `distance` float DEFAULT NULL,
  `endpoint` json DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `startpoint` json DEFAULT NULL,
  `timeupdated` varchar(45) DEFAULT NULL,
  `traveltimeid` varchar(45) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
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
  `end_mp` decimal(5,2) DEFAULT NULL,
  `end_roadname` varchar(45) DEFAULT NULL,
  `start_time` varchar(45) DEFAULT NULL,
  `start_direction` char(1) DEFAULT NULL,
  `start_lat` decimal(15,12) DEFAULT NULL,
  `start_long` decimal(15,12) DEFAULT NULL,
  `start_mp` decimal(5,2) DEFAULT NULL,
  `start_roadname` varchar(45) DEFAULT NULL,
  `event_cat` varchar(255) DEFAULT NULL,
  `event_stat` varchar(45) DEFAULT NULL,
  `event_desc` longtext,
  `priority` varchar(45) DEFAULT NULL,
  `region` varchar(45) DEFAULT NULL,
  `updated` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`alertid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `traffic_alerts_raw`
--

DROP TABLE IF EXISTS `traffic_alerts_raw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `traffic_alerts_raw` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `alertid` varchar(45) DEFAULT NULL,
  `county` varchar(45) DEFAULT NULL,
  `endroadwaylocation` json DEFAULT NULL,
  `endtime` varchar(45) DEFAULT NULL,
  `eventcategory` varchar(255) DEFAULT NULL,
  `eventstatus` varchar(45) DEFAULT NULL,
  `extendeddescription` varchar(45) DEFAULT NULL,
  `headlinedescription` longtext,
  `lastupdatedtime` varchar(45) DEFAULT NULL,
  `priority` varchar(45) DEFAULT NULL,
  `region` varchar(45) DEFAULT NULL,
  `startroadwaylocation` json DEFAULT NULL,
  `starttime` varchar(45) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `weather_alerts_raw`
--

DROP TABLE IF EXISTS `weather_alerts_raw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `weather_alerts_raw` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `barometricpressure` float DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `precipitationininches` float DEFAULT NULL,
  `readingtime` varchar(45) DEFAULT NULL,
  `relativehumidity` float DEFAULT NULL,
  `skycoverage` varchar(45) DEFAULT NULL,
  `stationid` varchar(45) DEFAULT NULL,
  `stationname` longtext,
  `temperatureinfahrenheit` float DEFAULT NULL,
  `visibility` varchar(45) DEFAULT NULL,
  `winddirection` varchar(45) DEFAULT NULL,
  `winddirectioncardinal` varchar(45) DEFAULT NULL,
  `windgustspeedinmph` float DEFAULT NULL,
  `windspeedinmph` float DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-09 13:13:41
