mysqldump: [Warning] Using a password on the command line interface can be insecure.
Warning: A partial dump from a server that has GTIDs will by default include the GTIDs of all transactions, even those that changed suppressed parts of the database. If you don't want to restore GTIDs, pass --set-gtid-purged=OFF. To make a complete dump, pass --all-databases --triggers --routines --events. 
Warning: A dump from a server that has GTIDs enabled will by default include the GTIDs of all transactions, even those that were executed during its extraction and might not be represented in the dumped data. This might result in an inconsistent data dump. 
In order to ensure a consistent backup of the database, pass --single-transaction or --lock-all-tables or --source-data. 
-- MySQL dump 10.13  Distrib 9.5.0, for macos15.7 (arm64)
--
-- Host: 165.227.14.126    Database: defaultdb
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '48773518-2122-11f1-aeda-0a17f6b3a545:1-158,
5e525c76-2202-11f1-b2b7-7e74ec16743d:1-245,
83da407b-240d-11f1-8c4e-9e21a2279039:1-15';

--
-- Table structure for table `advances`
--

DROP TABLE IF EXISTS `advances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advances` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` timestamp(6) NULL DEFAULT NULL,
  `producerId` int NOT NULL,
  `seasonId` int NOT NULL,
  `amount` bigint NOT NULL,
  `issueDate` date NOT NULL,
  `interestRate` decimal(5,2) NOT NULL DEFAULT '0.00',
  `interestEndDate` date DEFAULT NULL,
  `isInterestCalculationEnabled` tinyint NOT NULL DEFAULT '1',
  `status` varchar(20) NOT NULL DEFAULT 'paid' COMMENT 'paid, settled (para saber si puede editarse)',
  `settlementId` int DEFAULT NULL,
  `description` text,
  `isActive` tinyint NOT NULL DEFAULT '1',
  `interest_end_date` date DEFAULT NULL COMMENT 'Fecha de termino del interes (si es NULL, se usa hoy)',
  `is_interest_calculation_enabled` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Habilitar/Deshabilitar calculo de interes',
  PRIMARY KEY (`id`),
  KEY `idx_advance_settlement` (`settlementId`),
  KEY `idx_advance_producer_season` (`producerId`,`seasonId`),
  KEY `FK_7ec87561637e45aacb85d5ed163` (`seasonId`),
  CONSTRAINT `FK_7ec87561637e45aacb85d5ed163` FOREIGN KEY (`seasonId`) REFERENCES `seasons` (`id`),
  CONSTRAINT `FK_9b15148f8accaa174484be57721` FOREIGN KEY (`settlementId`) REFERENCES `settlements` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_cbfdf13ae32cf87a12be0b04dd5` FOREIGN KEY (`producerId`) REFERENCES `producers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advances`
--

LOCK TABLES `advances` WRITE;
/*!40000 ALTER TABLE `advances` DISABLE KEYS */;
INSERT INTO `advances` VALUES (1,'2026-03-18 18:13:45.224989','2026-03-19 13:37:34.000000',NULL,3,1,4000000,'2025-09-29',1.50,NULL,1,'paid',NULL,NULL,1,NULL,1),(2,'2026-03-18 18:18:22.963303','2026-03-18 18:18:22.963303',NULL,4,1,2000000,'2025-10-15',1.50,NULL,1,'paid',NULL,NULL,1,NULL,1),(3,'2026-03-19 13:41:35.760106','2026-03-19 13:41:35.760106',NULL,2,1,100000,'2026-01-01',1.50,NULL,1,'paid',NULL,NULL,1,NULL,1);
/*!40000 ALTER TABLE `advances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analysis_params`
--

DROP TABLE IF EXISTS `analysis_params`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `analysis_params` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` timestamp(6) NULL DEFAULT NULL,
  `discountCode` int NOT NULL,
  `discountName` varchar(100) NOT NULL,
  `unit` varchar(255) NOT NULL,
  `rangeStart` decimal(8,2) NOT NULL,
  `rangeEnd` decimal(8,2) NOT NULL,
  `discountPercent` decimal(5,2) NOT NULL,
  `priority` int NOT NULL DEFAULT '0',
  `isActive` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_analysisparam_code_range` (`discountCode`,`rangeStart`,`rangeEnd`)
) ENGINE=InnoDB AUTO_INCREMENT=693 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analysis_params`
--

LOCK TABLES `analysis_params` WRITE;
/*!40000 ALTER TABLE `analysis_params` DISABLE KEYS */;
INSERT INTO `analysis_params` VALUES (553,'2026-03-19 13:23:41.000000','2026-03-19 13:23:41.000000',NULL,1,'Humedad','%',15.01,15.50,1.00,0,1),(554,'2026-03-19 13:23:42.000000','2026-03-19 13:23:42.000000',NULL,1,'Humedad','%',15.51,16.00,1.50,1,1),(555,'2026-03-19 13:23:42.000000','2026-03-19 13:23:42.000000',NULL,1,'Humedad','%',16.01,16.50,2.00,2,1),(556,'2026-03-19 13:23:42.000000','2026-03-19 13:23:42.000000',NULL,1,'Humedad','%',16.51,17.00,2.50,3,1),(557,'2026-03-19 13:23:42.000000','2026-03-19 13:23:42.000000',NULL,1,'Humedad','%',17.01,17.50,3.00,4,1),(558,'2026-03-19 13:23:42.000000','2026-03-19 13:23:42.000000',NULL,1,'Humedad','%',17.51,18.00,4.03,5,1),(559,'2026-03-19 13:23:43.000000','2026-03-19 13:23:43.000000',NULL,1,'Humedad','%',18.01,18.50,4.62,6,1),(560,'2026-03-19 13:23:43.000000','2026-03-19 13:23:43.000000',NULL,1,'Humedad','%',18.51,19.00,5.21,7,1),(561,'2026-03-19 13:23:43.000000','2026-03-19 13:23:43.000000',NULL,1,'Humedad','%',19.01,19.50,5.79,8,1),(562,'2026-03-19 13:23:43.000000','2026-03-19 13:23:43.000000',NULL,1,'Humedad','%',19.51,20.00,6.38,9,1),(563,'2026-03-19 13:23:43.000000','2026-03-19 13:23:43.000000',NULL,1,'Humedad','%',20.01,20.50,6.97,10,1),(564,'2026-03-19 13:23:43.000000','2026-03-19 13:23:43.000000',NULL,1,'Humedad','%',20.51,21.00,7.56,11,1),(565,'2026-03-19 13:23:44.000000','2026-03-19 13:23:44.000000',NULL,1,'Humedad','%',21.01,21.50,8.15,12,1),(566,'2026-03-19 13:23:44.000000','2026-03-19 13:23:44.000000',NULL,1,'Humedad','%',21.51,22.00,8.74,13,1),(567,'2026-03-19 13:23:44.000000','2026-03-19 13:23:44.000000',NULL,1,'Humedad','%',22.01,22.50,9.32,14,1),(568,'2026-03-19 13:23:44.000000','2026-03-19 13:23:44.000000',NULL,1,'Humedad','%',22.51,23.00,9.91,15,1),(569,'2026-03-19 13:23:44.000000','2026-03-19 13:23:44.000000',NULL,1,'Humedad','%',23.01,23.50,10.50,16,1),(570,'2026-03-19 13:23:44.000000','2026-03-19 13:23:44.000000',NULL,1,'Humedad','%',23.51,24.00,11.09,17,1),(571,'2026-03-19 13:23:45.000000','2026-03-19 13:23:45.000000',NULL,1,'Humedad','%',24.01,24.50,11.68,18,1),(572,'2026-03-19 13:23:45.000000','2026-03-19 13:23:45.000000',NULL,1,'Humedad','%',24.51,25.00,12.26,19,1),(573,'2026-03-19 13:23:45.000000','2026-03-19 13:23:45.000000',NULL,1,'Humedad','%',25.51,100.00,100.00,20,1),(574,'2026-03-19 13:23:45.000000','2026-03-19 13:23:45.000000',NULL,2,'Granos Verdes','%',0.00,2.00,0.00,0,1),(575,'2026-03-19 13:23:46.000000','2026-03-19 13:23:46.000000',NULL,2,'Granos Verdes','%',2.01,2.50,0.25,1,1),(576,'2026-03-19 13:23:46.000000','2026-03-19 13:23:46.000000',NULL,2,'Granos Verdes','%',2.51,3.00,0.50,2,1),(577,'2026-03-19 13:23:46.000000','2026-03-19 13:23:46.000000',NULL,2,'Granos Verdes','%',3.01,3.50,0.75,3,1),(578,'2026-03-19 13:23:46.000000','2026-03-19 13:23:46.000000',NULL,2,'Granos Verdes','%',3.51,4.00,1.00,4,1),(579,'2026-03-19 13:23:46.000000','2026-03-19 13:23:46.000000',NULL,2,'Granos Verdes','%',4.01,4.50,1.25,5,1),(580,'2026-03-19 13:23:46.000000','2026-03-19 13:23:46.000000',NULL,2,'Granos Verdes','%',4.51,5.00,1.50,6,1),(581,'2026-03-19 13:23:47.000000','2026-03-19 13:23:47.000000',NULL,2,'Granos Verdes','%',5.01,5.50,1.75,7,1),(582,'2026-03-19 13:23:47.000000','2026-03-19 13:23:47.000000',NULL,2,'Granos Verdes','%',5.51,6.00,2.00,8,1),(583,'2026-03-19 13:23:47.000000','2026-03-19 13:23:47.000000',NULL,2,'Granos Verdes','%',6.01,6.50,2.25,9,1),(584,'2026-03-19 13:23:47.000000','2026-03-19 13:23:47.000000',NULL,2,'Granos Verdes','%',6.51,7.00,2.50,10,1),(585,'2026-03-19 13:23:47.000000','2026-03-19 13:23:47.000000',NULL,2,'Granos Verdes','%',7.01,7.50,2.75,11,1),(586,'2026-03-19 13:23:47.000000','2026-03-19 13:23:47.000000',NULL,2,'Granos Verdes','%',7.51,8.00,3.00,12,1),(587,'2026-03-19 13:23:48.000000','2026-03-19 13:23:48.000000',NULL,2,'Granos Verdes','%',8.01,8.50,3.25,13,1),(588,'2026-03-19 13:23:48.000000','2026-03-19 13:23:48.000000',NULL,2,'Granos Verdes','%',8.51,9.00,3.50,14,1),(589,'2026-03-19 13:23:48.000000','2026-03-19 13:23:48.000000',NULL,2,'Granos Verdes','%',9.01,9.50,3.75,15,1),(590,'2026-03-19 13:23:48.000000','2026-03-19 13:23:48.000000',NULL,2,'Granos Verdes','%',9.51,10.00,4.00,16,1),(591,'2026-03-19 13:23:48.000000','2026-03-19 13:23:48.000000',NULL,2,'Granos Verdes','%',10.01,100.00,100.00,17,1),(592,'2026-03-19 13:23:49.000000','2026-03-19 13:23:49.000000',NULL,3,'Impurezas','%',0.00,0.50,0.00,0,1),(593,'2026-03-19 13:23:49.000000','2026-03-19 13:23:49.000000',NULL,3,'Impurezas','%',0.51,1.00,0.00,1,1),(594,'2026-03-19 13:23:49.000000','2026-03-19 13:23:49.000000',NULL,3,'Impurezas','%',1.01,1.50,0.00,2,1),(595,'2026-03-19 13:23:49.000000','2026-03-19 13:23:49.000000',NULL,3,'Impurezas','%',1.51,1.99,0.00,3,1),(596,'2026-03-19 13:23:49.000000','2026-03-19 13:23:49.000000',NULL,3,'Impurezas','%',2.00,2.00,0.00,4,1),(597,'2026-03-19 13:23:50.000000','2026-03-19 13:23:50.000000',NULL,3,'Impurezas','%',2.01,2.50,0.50,5,1),(598,'2026-03-19 13:23:50.000000','2026-03-19 13:23:50.000000',NULL,3,'Impurezas','%',2.51,3.00,1.00,6,1),(599,'2026-03-19 13:23:50.000000','2026-03-19 13:23:50.000000',NULL,3,'Impurezas','%',3.01,3.50,1.50,7,1),(600,'2026-03-19 13:23:50.000000','2026-03-19 13:23:50.000000',NULL,3,'Impurezas','%',3.51,4.00,2.00,8,1),(601,'2026-03-19 13:23:50.000000','2026-03-19 13:23:50.000000',NULL,3,'Impurezas','%',4.01,4.50,2.50,9,1),(602,'2026-03-19 13:23:50.000000','2026-03-19 13:23:50.000000',NULL,3,'Impurezas','%',4.51,5.00,3.00,10,1),(603,'2026-03-19 13:23:51.000000','2026-03-19 13:23:51.000000',NULL,3,'Impurezas','%',5.01,5.50,3.50,11,1),(604,'2026-03-19 13:23:51.000000','2026-03-19 13:23:51.000000',NULL,3,'Impurezas','%',5.51,6.00,4.00,12,1),(605,'2026-03-19 13:23:51.000000','2026-03-19 13:23:51.000000',NULL,3,'Impurezas','%',6.01,6.50,4.50,13,1),(606,'2026-03-19 13:23:51.000000','2026-03-19 13:23:51.000000',NULL,3,'Impurezas','%',6.51,7.00,5.00,14,1),(607,'2026-03-19 13:23:51.000000','2026-03-19 13:23:51.000000',NULL,3,'Impurezas','%',7.01,7.50,5.50,15,1),(608,'2026-03-19 13:23:52.000000','2026-03-19 13:23:52.000000',NULL,3,'Impurezas','%',7.51,8.00,6.00,16,1),(609,'2026-03-19 13:23:52.000000','2026-03-19 13:23:52.000000',NULL,3,'Impurezas','%',8.01,8.50,6.50,17,1),(610,'2026-03-19 13:23:52.000000','2026-03-19 13:23:52.000000',NULL,3,'Impurezas','%',8.51,9.00,7.00,18,1),(611,'2026-03-19 13:23:52.000000','2026-03-19 13:23:52.000000',NULL,3,'Impurezas','%',9.01,9.50,7.50,19,1),(612,'2026-03-19 13:23:52.000000','2026-03-19 13:23:52.000000',NULL,3,'Impurezas','%',9.51,10.00,8.00,20,1),(613,'2026-03-19 13:23:52.000000','2026-03-19 13:23:52.000000',NULL,3,'Impurezas','%',10.00,100.00,8.00,21,1),(614,'2026-03-19 13:23:53.000000','2026-03-19 13:58:59.043052',NULL,6,'Granos Pelados y Partidos','%',0.00,1.00,0.00,0,1),(615,'2026-03-19 13:23:53.000000','2026-03-19 13:58:59.043052',NULL,6,'Granos Pelados y Partidos','%',1.01,2.00,1.00,1,1),(616,'2026-03-19 13:23:53.000000','2026-03-19 13:58:59.043052',NULL,6,'Granos Pelados y Partidos','%',2.01,3.00,2.00,2,1),(617,'2026-03-19 13:23:53.000000','2026-03-19 13:58:59.043052',NULL,6,'Granos Pelados y Partidos','%',3.01,4.00,3.00,3,1),(618,'2026-03-19 13:23:53.000000','2026-03-19 13:58:59.043052',NULL,6,'Granos Pelados y Partidos','%',4.01,5.00,4.00,4,1),(619,'2026-03-19 13:23:54.000000','2026-03-19 13:58:59.043052',NULL,6,'Granos Pelados y Partidos','%',5.01,6.00,5.00,5,1),(620,'2026-03-19 13:23:54.000000','2026-03-19 13:58:59.043052',NULL,6,'Granos Pelados y Partidos','%',6.01,7.00,6.00,6,1),(621,'2026-03-19 13:23:54.000000','2026-03-19 13:58:59.043052',NULL,6,'Granos Pelados y Partidos','%',7.01,8.00,7.00,7,1),(622,'2026-03-19 13:23:54.000000','2026-03-19 13:58:59.043052',NULL,6,'Granos Pelados y Partidos','%',8.01,9.00,8.00,8,1),(623,'2026-03-19 13:23:54.000000','2026-03-19 13:58:59.043052',NULL,6,'Granos Pelados y Partidos','%',9.01,10.00,9.00,9,1),(624,'2026-03-19 13:23:54.000000','2026-03-19 13:58:59.043052',NULL,6,'Granos Pelados y Partidos','%',10.01,100.00,100.00,10,1),(639,'2026-03-19 13:23:58.000000','2026-03-19 13:58:58.869381',NULL,5,'Hualcacho','%',0.01,0.50,0.75,0,1),(640,'2026-03-19 13:23:58.000000','2026-03-19 13:58:58.869381',NULL,5,'Hualcacho','%',0.51,1.00,1.50,1,1),(641,'2026-03-19 13:23:58.000000','2026-03-19 13:58:58.869381',NULL,5,'Hualcacho','%',1.01,1.50,2.25,2,1),(642,'2026-03-19 13:23:58.000000','2026-03-19 13:58:58.869381',NULL,5,'Hualcacho','%',1.51,2.00,3.00,3,1),(643,'2026-03-19 13:23:58.000000','2026-03-19 13:58:58.869381',NULL,5,'Hualcacho','%',2.01,2.50,3.75,4,1),(644,'2026-03-19 13:23:59.000000','2026-03-19 13:58:58.869381',NULL,5,'Hualcacho','%',2.51,3.00,4.50,5,1),(645,'2026-03-19 13:23:59.000000','2026-03-19 13:58:58.869381',NULL,5,'Hualcacho','%',3.01,3.50,5.25,6,1),(646,'2026-03-19 13:23:59.000000','2026-03-19 13:58:58.869381',NULL,5,'Hualcacho','%',3.51,4.00,6.00,7,1),(647,'2026-03-19 13:23:59.000000','2026-03-19 13:58:58.869381',NULL,5,'Hualcacho','%',4.01,4.50,6.75,8,1),(648,'2026-03-19 13:23:59.000000','2026-03-19 13:58:58.869381',NULL,5,'Hualcacho','%',4.51,5.00,7.50,9,1),(649,'2026-03-19 13:58:59.000000','2026-03-19 13:58:59.000000',NULL,4,'Granos Manchados','%',0.01,0.50,0.50,0,1),(650,'2026-03-19 13:58:59.000000','2026-03-19 13:58:59.000000',NULL,4,'Granos Manchados','%',0.51,1.00,1.00,1,1),(651,'2026-03-19 13:58:59.000000','2026-03-19 13:58:59.000000',NULL,4,'Granos Manchados','%',1.01,1.50,1.50,2,1),(652,'2026-03-19 13:58:59.000000','2026-03-19 13:58:59.000000',NULL,4,'Granos Manchados','%',1.51,2.00,2.00,3,1),(653,'2026-03-19 13:58:59.000000','2026-03-19 13:58:59.000000',NULL,4,'Granos Manchados','%',2.01,2.50,2.50,4,1),(654,'2026-03-19 13:59:00.000000','2026-03-19 13:59:00.000000',NULL,4,'Granos Manchados','%',2.51,3.00,3.00,5,1),(655,'2026-03-19 13:59:00.000000','2026-03-19 13:59:00.000000',NULL,4,'Granos Manchados','%',3.01,3.50,3.50,6,1),(656,'2026-03-19 13:59:00.000000','2026-03-19 13:59:00.000000',NULL,4,'Granos Manchados','%',3.51,4.00,4.00,7,1),(657,'2026-03-19 13:59:00.000000','2026-03-19 13:59:00.000000',NULL,4,'Granos Manchados','%',4.01,4.50,4.50,8,1),(658,'2026-03-19 13:59:00.000000','2026-03-19 13:59:00.000000',NULL,4,'Granos Manchados','%',4.51,5.00,5.00,9,1),(659,'2026-03-19 13:59:00.000000','2026-03-19 13:59:00.000000',NULL,4,'Granos Manchados','%',5.01,100.00,100.00,10,1),(660,'2026-03-19 13:59:01.000000','2026-03-19 13:59:01.000000',NULL,9,'Vano','%',0.00,0.50,0.00,0,1),(661,'2026-03-19 13:59:01.000000','2026-03-19 13:59:01.000000',NULL,9,'Vano','%',0.51,1.00,0.50,1,1),(662,'2026-03-19 13:59:01.000000','2026-03-19 13:59:01.000000',NULL,9,'Vano','%',1.01,1.50,1.00,2,1),(663,'2026-03-19 13:59:01.000000','2026-03-19 13:59:01.000000',NULL,9,'Vano','%',1.51,2.00,1.50,3,1),(664,'2026-03-19 13:59:01.000000','2026-03-19 13:59:01.000000',NULL,9,'Vano','%',2.01,2.50,2.00,4,1),(665,'2026-03-19 13:59:01.000000','2026-03-19 13:59:01.000000',NULL,9,'Vano','%',2.51,3.00,2.50,5,1),(666,'2026-03-19 13:59:02.000000','2026-03-19 13:59:02.000000',NULL,9,'Vano','%',3.01,3.50,3.00,6,1),(667,'2026-03-19 13:59:02.000000','2026-03-19 13:59:02.000000',NULL,9,'Vano','%',3.51,4.00,3.50,7,1),(668,'2026-03-19 13:59:02.000000','2026-03-19 13:59:02.000000',NULL,9,'Vano','%',4.01,4.50,4.00,8,1),(669,'2026-03-19 13:59:02.000000','2026-03-19 13:59:02.000000',NULL,9,'Vano','%',4.51,5.00,4.50,9,1),(670,'2026-03-19 13:59:02.000000','2026-03-19 13:59:02.000000',NULL,9,'Vano','%',5.01,100.00,100.00,10,1),(671,'2026-03-19 14:46:05.237866','2026-03-19 14:46:05.237866',NULL,7,'Granos Pelados','%',0.00,1.00,0.00,1,1),(672,'2026-03-19 14:46:05.551361','2026-03-19 14:46:05.551361',NULL,7,'Granos Pelados','%',1.01,2.00,1.00,2,1),(673,'2026-03-19 14:46:05.859342','2026-03-19 14:46:05.859342',NULL,7,'Granos Pelados','%',2.01,3.00,2.00,3,1),(674,'2026-03-19 14:46:06.165481','2026-03-19 14:46:06.165481',NULL,7,'Granos Pelados','%',3.01,4.00,3.00,4,1),(675,'2026-03-19 14:46:06.472968','2026-03-19 14:46:06.472968',NULL,7,'Granos Pelados','%',4.01,5.00,4.00,5,1),(676,'2026-03-19 14:46:06.779157','2026-03-19 14:46:06.779157',NULL,7,'Granos Pelados','%',5.01,6.00,5.00,6,1),(677,'2026-03-19 14:46:07.085258','2026-03-19 14:46:07.085258',NULL,7,'Granos Pelados','%',6.01,7.00,6.00,7,1),(678,'2026-03-19 14:46:07.392055','2026-03-19 14:46:07.392055',NULL,7,'Granos Pelados','%',7.01,8.00,7.00,8,1),(679,'2026-03-19 14:46:07.699632','2026-03-19 14:46:07.699632',NULL,7,'Granos Pelados','%',8.01,9.00,8.00,9,1),(680,'2026-03-19 14:46:08.009168','2026-03-19 14:46:08.009168',NULL,7,'Granos Pelados','%',9.01,10.00,9.00,10,1),(681,'2026-03-19 14:46:08.315263','2026-03-19 14:46:08.315263',NULL,7,'Granos Pelados','%',10.01,100.00,100.00,11,1),(682,'2026-03-19 14:46:14.483915','2026-03-19 14:46:14.483915',NULL,8,'Granos Yesosos','%',0.00,1.00,0.00,1,1),(683,'2026-03-19 14:46:14.789901','2026-03-19 14:46:14.789901',NULL,8,'Granos Yesosos','%',1.01,2.00,1.00,2,1),(684,'2026-03-19 14:46:15.090837','2026-03-19 14:46:15.090837',NULL,8,'Granos Yesosos','%',2.01,3.00,2.00,3,1),(685,'2026-03-19 14:46:15.390359','2026-03-19 14:46:15.390359',NULL,8,'Granos Yesosos','%',3.01,4.00,3.00,4,1),(686,'2026-03-19 14:46:15.690511','2026-03-19 14:46:15.690511',NULL,8,'Granos Yesosos','%',4.01,5.00,4.00,5,1),(687,'2026-03-19 14:46:15.990095','2026-03-19 14:46:15.990095',NULL,8,'Granos Yesosos','%',5.01,6.00,5.00,6,1),(688,'2026-03-19 14:46:16.289648','2026-03-19 14:46:16.289648',NULL,8,'Granos Yesosos','%',6.01,7.00,6.00,7,1),(689,'2026-03-19 14:46:16.589917','2026-03-19 14:46:16.589917',NULL,8,'Granos Yesosos','%',7.01,8.00,7.00,8,1),(690,'2026-03-19 14:46:16.889601','2026-03-19 14:46:16.889601',NULL,8,'Granos Yesosos','%',8.01,9.00,8.00,9,1),(691,'2026-03-19 14:46:17.190463','2026-03-19 14:46:17.190463',NULL,8,'Granos Yesosos','%',9.01,10.00,9.00,10,1),(692,'2026-03-19 14:46:17.490843','2026-03-19 14:46:17.490843',NULL,8,'Granos Yesosos','%',10.01,100.00,100.00,11,1);
/*!40000 ALTER TABLE `analysis_params` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `analysis_records`
--

DROP TABLE IF EXISTS `analysis_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `analysis_records` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` timestamp(6) NULL DEFAULT NULL,
  `receptionId` int NOT NULL,
  `templateId` int DEFAULT NULL,
  `useToleranceGroup` tinyint NOT NULL DEFAULT '0',
  `groupToleranceName` varchar(255) DEFAULT NULL,
  `groupToleranceValue` decimal(5,2) DEFAULT NULL,
  `humedadRange` decimal(5,2) DEFAULT NULL,
  `humedadPercent` decimal(5,2) DEFAULT NULL,
  `impurezasRange` decimal(5,2) DEFAULT NULL,
  `impurezasPercent` decimal(5,2) DEFAULT NULL,
  `verdesRange` decimal(5,2) DEFAULT NULL,
  `manchadosRange` decimal(5,2) DEFAULT NULL,
  `yesososRange` decimal(5,2) DEFAULT NULL,
  `peladosRange` decimal(5,2) DEFAULT NULL,
  `vanoRange` decimal(5,2) DEFAULT NULL,
  `hualcachoRange` decimal(5,2) DEFAULT NULL,
  `humedadValue` decimal(5,2) DEFAULT NULL,
  `humedadTolerance` decimal(5,2) DEFAULT NULL,
  `humedadIsGroup` tinyint NOT NULL DEFAULT '0',
  `humedadTolVisible` tinyint NOT NULL DEFAULT '1',
  `verdesValue` decimal(5,2) DEFAULT NULL,
  `verdesPercent` decimal(5,2) DEFAULT NULL,
  `verdesTolerance` decimal(5,2) DEFAULT NULL,
  `verdesIsGroup` tinyint NOT NULL DEFAULT '0',
  `verdesTolVisible` tinyint NOT NULL DEFAULT '1',
  `impurezasValue` decimal(5,2) DEFAULT NULL,
  `impurezasTolerance` decimal(5,2) DEFAULT NULL,
  `impurezasIsGroup` tinyint NOT NULL DEFAULT '0',
  `impurezasTolVisible` tinyint NOT NULL DEFAULT '1',
  `vanoValue` decimal(5,2) DEFAULT NULL,
  `vanoPercent` decimal(5,2) DEFAULT NULL,
  `vanoTolerance` decimal(5,2) DEFAULT NULL,
  `vanoIsGroup` tinyint NOT NULL DEFAULT '0',
  `vanoTolVisible` tinyint NOT NULL DEFAULT '1',
  `hualcachoValue` decimal(5,2) DEFAULT NULL,
  `hualcachoPercent` decimal(5,2) DEFAULT NULL,
  `hualcachoTolerance` decimal(5,2) DEFAULT NULL,
  `hualcachoIsGroup` tinyint NOT NULL DEFAULT '0',
  `hualcachoTolVisible` tinyint NOT NULL DEFAULT '1',
  `manchadosValue` decimal(5,2) DEFAULT NULL,
  `manchadosPercent` decimal(5,2) DEFAULT NULL,
  `manchadosTolerance` decimal(5,2) DEFAULT NULL,
  `manchadosIsGroup` tinyint NOT NULL DEFAULT '0',
  `manchadosTolVisible` tinyint NOT NULL DEFAULT '1',
  `peladosValue` decimal(5,2) DEFAULT NULL,
  `peladosPercent` decimal(5,2) DEFAULT NULL,
  `peladosTolerance` decimal(5,2) DEFAULT NULL,
  `peladosIsGroup` tinyint NOT NULL DEFAULT '0',
  `peladosTolVisible` tinyint NOT NULL DEFAULT '1',
  `yesososValue` decimal(5,2) DEFAULT NULL,
  `yesososPercent` decimal(5,2) DEFAULT NULL,
  `yesososTolerance` decimal(5,2) DEFAULT NULL,
  `yesososIsGroup` tinyint NOT NULL DEFAULT '0',
  `yesososTolVisible` tinyint NOT NULL DEFAULT '1',
  `totalGroupPercent` decimal(5,2) DEFAULT NULL,
  `groupTolerance` decimal(5,2) DEFAULT NULL,
  `dryPercent` decimal(5,2) DEFAULT NULL,
  `summaryPercent` decimal(7,2) DEFAULT NULL,
  `summaryTolerance` decimal(7,2) DEFAULT NULL,
  `summaryPenaltyKg` decimal(10,2) DEFAULT NULL,
  `bonusEnabled` tinyint NOT NULL DEFAULT '0',
  `bonusPercent` decimal(5,2) DEFAULT NULL,
  `userId` int DEFAULT NULL,
  `notes` text,
  `groupPercent` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_analysisrecord_reception` (`receptionId`),
  UNIQUE KEY `IDX_f6f6de10456afba7e8864868f1` (`receptionId`),
  UNIQUE KEY `REL_f6f6de10456afba7e8864868f1` (`receptionId`),
  KEY `FK_d2282d2900131a0230edb488717` (`templateId`),
  CONSTRAINT `FK_d2282d2900131a0230edb488717` FOREIGN KEY (`templateId`) REFERENCES `templates` (`id`),
  CONSTRAINT `FK_f6f6de10456afba7e8864868f12` FOREIGN KEY (`receptionId`) REFERENCES `receptions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analysis_records`
--

LOCK TABLES `analysis_records` WRITE;
/*!40000 ALTER TABLE `analysis_records` DISABLE KEYS */;
INSERT INTO `analysis_records` VALUES (1,'2026-03-19 13:35:02.739827','2026-03-19 13:35:02.739827',NULL,6,1,1,'Analisis de Granos',4.00,17.60,4.03,2.00,0.00,2.50,0.00,0.00,0.00,0.00,0.00,17.60,4.00,0,1,2.50,0.25,0.00,1,0,2.00,0.00,1,0,0.00,0.00,0.00,0,0,0.00,0.00,0.00,0,0,0.00,0.00,0.00,0,0,0.00,0.00,0.00,1,0,0.00,0.00,0.00,0,0,4.28,4.00,0.00,4.28,8.00,0.83,1,0.00,1,NULL,0.25),(2,'2026-03-19 13:45:09.467117','2026-03-19 13:45:09.467117',NULL,7,1,1,'Analisis de Granos',4.00,20.00,6.38,2.50,0.50,1.20,0.00,0.00,2.50,0.00,0.00,20.00,4.00,0,1,1.20,0.00,0.00,1,0,2.50,0.00,1,0,0.00,0.00,0.00,0,0,0.00,0.00,0.00,0,0,0.00,0.00,0.00,0,0,2.50,2.00,0.00,1,0,0.00,0.00,0.00,0,0,8.88,4.00,0.00,8.88,8.00,897.97,1,0.00,1,NULL,2.50);
/*!40000 ALTER TABLE `analysis_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_events`
--

DROP TABLE IF EXISTS `audit_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_events` (
  `id` int NOT NULL AUTO_INCREMENT,
  `eventCode` varchar(255) NOT NULL,
  `category` enum('AUTH','USERS','PRODUCERS','CONFIG','OPERATIONS','FINANCE','ANALYTICS','SYSTEM','SECURITY','VALIDATION') NOT NULL,
  `action` enum('CREATE','READ','UPDATE','DELETE','LOGIN','LOGOUT','REFRESH','CALCULATE','COMPLETE','CANCEL','EXECUTE','EXPORT') NOT NULL,
  `status` enum('SUCCESS','FAIL','DENIED') NOT NULL,
  `severity` enum('INFO','WARN','HIGH','CRITICAL') NOT NULL,
  `actorUserId` int DEFAULT NULL,
  `actorEmail` varchar(255) DEFAULT NULL,
  `actorRole` varchar(50) DEFAULT NULL,
  `entityType` varchar(100) DEFAULT NULL,
  `entityId` int DEFAULT NULL,
  `route` varchar(500) NOT NULL,
  `method` varchar(10) NOT NULL,
  `ip` varchar(50) DEFAULT NULL,
  `userAgent` text,
  `requestId` varchar(100) DEFAULT NULL,
  `correlationId` varchar(100) DEFAULT NULL,
  `beforeData` json DEFAULT NULL,
  `afterData` json DEFAULT NULL,
  `metadata` json DEFAULT NULL,
  `errorMessage` text,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `IDX_audit_events_eventCode` (`eventCode`),
  KEY `IDX_audit_events_actorUserId` (`actorUserId`),
  KEY `IDX_audit_events_createdAt` (`createdAt`),
  KEY `IDX_audit_events_severity` (`severity`),
  KEY `IDX_audit_events_correlationId` (`correlationId`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_events`
--

LOCK TABLES `audit_events` WRITE;
/*!40000 ALTER TABLE `audit_events` DISABLE KEYS */;
INSERT INTO `audit_events` VALUES (1,'CONFIG.TEMPLATES.DELETE','CONFIG','CREATE','SUCCESS','CRITICAL',2,'admin@ayg.cl','ADMIN',NULL,NULL,'/api/v1/configuration/templates/3','DELETE','::1','node','9dffb934-d623-4dfc-b812-4d4aac906bc8','78d411d7-5956-4489-b24b-0be5845ee77f',NULL,NULL,'{\"responseTime\": \"400ms\"}',NULL,'2026-03-19 12:09:28'),(2,'CONFIG.TEMPLATES.DELETE','CONFIG','CREATE','SUCCESS','CRITICAL',2,'admin@ayg.cl','ADMIN',NULL,NULL,'/api/v1/configuration/templates/2','DELETE','::1','node','accd596d-3b71-4d13-8d24-aecb20eeef12','5b93ce36-1f74-44f8-8e0a-5a35eb8cbdfa',NULL,NULL,'{\"responseTime\": \"395ms\"}',NULL,'2026-03-19 12:09:35'),(3,'PRODUCERS.UPDATE','PRODUCERS','UPDATE','SUCCESS','HIGH',2,'admin@ayg.cl','ADMIN',NULL,NULL,'/api/v1/producers/2','PUT','::1','node','bca12a3a-c852-446e-9d81-f81d0cb638f4','4907c4f5-d8fb-4f87-88c1-ba6d880de644',NULL,NULL,'{\"responseTime\": \"1174ms\"}',NULL,'2026-03-19 12:10:27'),(4,'PRODUCERS.UPDATE','PRODUCERS','UPDATE','SUCCESS','HIGH',2,'admin@ayg.cl','ADMIN',NULL,NULL,'/api/v1/producers/2','PUT','::1','node','07ea4cd4-e499-487a-9270-e5f6b5730443','5b638e14-dc01-45e5-8eda-2b8063c52700',NULL,NULL,'{\"responseTime\": \"1165ms\"}',NULL,'2026-03-19 12:10:43'),(5,'AUTH.LOGIN.ATTEMPT','AUTH','LOGIN','SUCCESS','HIGH',NULL,NULL,NULL,NULL,NULL,'/api/v1/auth/login','POST','::1','node','79ade528-c4d2-4d61-8604-210182fbd715','740f62cb-a65b-4471-86ee-491cba7d6c27',NULL,NULL,'{\"responseTime\": \"930ms\"}',NULL,'2026-03-19 13:33:33'),(6,'OPS.RECEPTIONS.SETTLE','OPERATIONS','EXECUTE','SUCCESS','CRITICAL',1,'pojeda@ayg.cl','ADMIN',NULL,NULL,'/api/v1/finances/settlements','GET','::1','node','2ea05c72-ba11-4d6f-a03c-4851349f7b3d','c5301e8a-c690-4485-9aae-8f3908496636',NULL,NULL,'{\"responseTime\": \"26ms\"}',NULL,'2026-03-19 13:33:35'),(7,'CONFIG.TEMPLATES.READ','CONFIG','EXECUTE','FAIL','WARN',1,'pojeda@ayg.cl','ADMIN',NULL,NULL,'/api/v1/configuration/templates/default','GET','::1','node','4a2237b2-507b-4db1-923e-4cbc042b89ba','c86da9f4-49e6-4e3e-81c0-6bb3159a576c',NULL,NULL,NULL,'No hay plantilla por defecto configurada','2026-03-19 13:33:57'),(8,'OPS.RECEPTIONS.CREATE','OPERATIONS','CREATE','SUCCESS','HIGH',1,'pojeda@ayg.cl','ADMIN',NULL,NULL,'/api/v1/operations/receptions/with-analysis','POST','::1','node','2e90b493-4748-43d7-9b82-6af0ef233443','fcd13635-1743-477f-b86f-de2c94b4561c',NULL,NULL,'{\"responseTime\": \"342ms\"}',NULL,'2026-03-19 13:35:02'),(9,'CONFIG.TEMPLATES.READ','CONFIG','EXECUTE','FAIL','WARN',1,'pojeda@ayg.cl','ADMIN',NULL,NULL,'/api/v1/configuration/templates/default','GET','::1','node','b212f2b3-d4cd-42f8-a71f-ee9aad1f4b11','a1f81287-6c8a-46ac-a7ab-791463c60bd0',NULL,NULL,NULL,'No hay plantilla por defecto configurada','2026-03-19 13:35:21'),(10,'CONFIG.TEMPLATES.PUT','CONFIG','CREATE','SUCCESS','INFO',1,'pojeda@ayg.cl','ADMIN',NULL,NULL,'/api/v1/configuration/templates/1','PUT','::1','node','a278aad5-5cc1-4102-8246-42f78d2836db','a77df96d-e523-4dd3-8224-c887cfee0639',NULL,NULL,'{\"responseTime\": \"105ms\"}',NULL,'2026-03-19 13:35:34'),(11,'FINANCE.ADVANCES.UPDATE','FINANCE','UPDATE','SUCCESS','HIGH',1,'pojeda@ayg.cl','ADMIN',NULL,NULL,'/api/v1/finances/advances/1','PATCH','::1','node','9b78a9a9-50e0-45ba-8dcf-5c018cbe8672','d066f184-642d-409b-8dd9-13064608b3fa',NULL,NULL,'{\"responseTime\": \"274ms\"}',NULL,'2026-03-19 13:37:35'),(12,'FINANCE.ADVANCES.CREATE','FINANCE','CREATE','SUCCESS','HIGH',1,'pojeda@ayg.cl','ADMIN',NULL,NULL,'/api/v1/finances/advances','POST','::1','node','76c2f00c-e2aa-4bd0-889a-4fc544945192','3e953927-0f66-4607-9959-9629106aa75d',NULL,NULL,'{\"responseTime\": \"213ms\"}',NULL,'2026-03-19 13:41:35'),(13,'OPS.ANALYSIS.UPDATE','OPERATIONS','UPDATE','SUCCESS','HIGH',1,'pojeda@ayg.cl','ADMIN',NULL,NULL,'/api/v1/configuration/analysis-params/616','PUT','::1','node','bfcdd9dc-03ac-4a78-8edc-44c2cc4e204b','a1bfd458-86ea-42f0-a801-757fe24dcfc4',NULL,NULL,'{\"responseTime\": \"91ms\"}',NULL,'2026-03-19 13:43:19'),(14,'OPS.RECEPTIONS.CREATE','OPERATIONS','CREATE','SUCCESS','HIGH',1,'pojeda@ayg.cl','ADMIN',NULL,NULL,'/api/v1/operations/receptions/with-analysis','POST','::1','node','4aaf9ed3-d014-490e-8f34-c6bd045e1984','18dbfeeb-16a8-4610-9ad7-153cd34835ec',NULL,NULL,'{\"responseTime\": \"294ms\"}',NULL,'2026-03-19 13:45:09'),(15,'AUTH.LOGIN.ATTEMPT','AUTH','LOGIN','SUCCESS','HIGH',NULL,NULL,NULL,NULL,NULL,'/api/v1/auth/login','POST','::1','node','7ed88a1d-b466-4277-984f-1007180f7d61','88692ca3-6a79-41de-adbe-a9765ea35982',NULL,NULL,'{\"responseTime\": \"681ms\"}',NULL,'2026-03-19 13:47:05'),(16,'OPS.RECEPTIONS.SETTLE','OPERATIONS','EXECUTE','SUCCESS','CRITICAL',1,'pojeda@ayg.cl','ADMIN',NULL,NULL,'/api/v1/finances/settlements','GET','::1','node','fcb7af53-891e-4c93-93aa-cc8370e238a0','3d50c5dc-4e54-4f46-9e21-1fb7550897ff',NULL,NULL,'{\"responseTime\": \"23ms\"}',NULL,'2026-03-19 13:47:06'),(17,'OPS.ANALYSIS.UPDATE','OPERATIONS','UPDATE','SUCCESS','HIGH',1,'pojeda@ayg.cl','ADMIN',NULL,NULL,'/api/v1/configuration/analysis-params/616','PUT','::1','node','1178914d-9af1-4677-84a5-ceb94dabbed5','0866dbe7-1335-4e8f-9f75-c844aae7f4b6',NULL,NULL,'{\"responseTime\": \"92ms\"}',NULL,'2026-03-19 13:49:06'),(18,'OPS.ANALYSIS.UPDATE','OPERATIONS','UPDATE','SUCCESS','HIGH',1,'pojeda@ayg.cl','ADMIN',NULL,NULL,'/api/v1/configuration/analysis-params/616','PUT','::1','node','c6ea15f6-5626-4dc6-9e18-9c2e40698806','b5cce83d-24a1-4495-9743-6e7bad57cd1d',NULL,NULL,'{\"responseTime\": \"95ms\"}',NULL,'2026-03-19 13:49:19'),(19,'OPS.RECEPTIONS.SETTLE','OPERATIONS','EXECUTE','SUCCESS','CRITICAL',1,'pojeda@ayg.cl','ADMIN',NULL,NULL,'/api/v1/finances/settlements','GET','::1','node','addb7a60-abfb-4c5a-b114-250fb228e9e5','5dab1168-5f6a-4bde-b604-4031364635fb',NULL,NULL,'{\"responseTime\": \"24ms\"}',NULL,'2026-03-19 13:50:56'),(20,'AUTH.LOGIN.ATTEMPT','AUTH','LOGIN','SUCCESS','HIGH',NULL,NULL,NULL,NULL,NULL,'/api/v1/auth/login','POST','::1','node','0458b0f0-0013-404d-b1c8-a829a57bc684','dd843147-dcde-4bcc-9233-e5de7d789dab',NULL,NULL,'{\"responseTime\": \"681ms\"}',NULL,'2026-03-19 14:18:58'),(21,'OPS.RECEPTIONS.SETTLE','OPERATIONS','EXECUTE','SUCCESS','CRITICAL',1,'pojeda@ayg.cl','ADMIN',NULL,NULL,'/api/v1/finances/settlements','GET','::1','node','06940dbb-155a-436a-9990-c922f125e506','1f221f83-5bdb-4af2-849a-81c1660db70b',NULL,NULL,'{\"responseTime\": \"24ms\"}',NULL,'2026-03-19 14:18:59'),(22,'AUTH.LOGIN.ATTEMPT','AUTH','EXECUTE','DENIED','HIGH',NULL,NULL,NULL,NULL,NULL,'/api/v1/auth/login','POST','::1','curl/8.7.1','071b3867-d9f4-4859-95fd-a7d53cfcb81f','4168f9d8-4dde-4d53-adfc-e6ef853f90a8',NULL,NULL,NULL,'Email o contraseña inválidos','2026-03-19 14:45:42'),(23,'AUTH.LOGIN.ATTEMPT','AUTH','EXECUTE','DENIED','HIGH',NULL,NULL,NULL,NULL,NULL,'/api/v1/auth/login','POST','::1','curl/8.7.1','d2bea7de-08a2-463a-886f-3411f80ffb13','337bcabf-6678-4dd6-be9a-f6c8b89ded24',NULL,NULL,NULL,'Email o contraseña inválidos','2026-03-19 14:45:45'),(24,'AUTH.LOGIN.ATTEMPT','AUTH','EXECUTE','DENIED','HIGH',NULL,NULL,NULL,NULL,NULL,'/api/v1/auth/login','POST','::1','node','da1ed788-b137-45d5-9f85-384d76f462d2','0b1c3573-9ae1-4078-9d8a-b1022c9b9f8a',NULL,NULL,NULL,'Email o contraseña inválidos','2026-03-19 17:12:17'),(25,'AUTH.LOGIN.ATTEMPT','AUTH','LOGIN','SUCCESS','HIGH',NULL,NULL,NULL,NULL,NULL,'/api/v1/auth/login','POST','::1','node','e2ef3d17-af26-40af-9819-00df55f1253f','f3ccfed4-236e-4ff5-b04e-8edffe6fb2d6',NULL,NULL,'{\"responseTime\": \"985ms\"}',NULL,'2026-03-19 17:12:24'),(26,'OPS.RECEPTIONS.SETTLE','OPERATIONS','EXECUTE','SUCCESS','CRITICAL',1,'pojeda@ayg.cl','ADMIN',NULL,NULL,'/api/v1/finances/settlements','GET','::1','node','5647af8b-642b-4513-b904-0fa9d24f2eef','a5a22d0d-1188-47e8-9885-3b791cc092e1',NULL,NULL,'{\"responseTime\": \"36ms\"}',NULL,'2026-03-19 17:12:26'),(27,'OPS.RECEPTIONS.SETTLE','OPERATIONS','EXECUTE','SUCCESS','CRITICAL',1,'pojeda@ayg.cl','ADMIN',NULL,NULL,'/api/v1/finances/settlements','GET','::1','node','0a649d4b-8cc3-496c-993e-838b906361a5','84e9a5e0-998d-4a90-9561-6eb9be3f864e',NULL,NULL,'{\"responseTime\": \"25ms\"}',NULL,'2026-03-19 18:03:37'),(28,'PRODUCERS.UPDATE','PRODUCERS','UPDATE','SUCCESS','HIGH',1,'pojeda@ayg.cl','ADMIN',NULL,NULL,'/api/v1/producers/2','PUT','::1','node','a290d67e-9eda-402d-b45d-ac78b50ea5dc','24466fd1-0aeb-4c34-bcb5-902ba6669a4b',NULL,NULL,'{\"responseTime\": \"325ms\"}',NULL,'2026-03-19 19:01:33'),(29,'AUTH.LOGIN.ATTEMPT','AUTH','LOGIN','SUCCESS','HIGH',NULL,NULL,NULL,NULL,NULL,'/api/v1/auth/login','POST','::1','node','a84854c1-40c8-4b79-a0b4-3348e72dea16','50c94250-557f-404b-babd-4870f191783d',NULL,NULL,'{\"responseTime\": \"868ms\"}',NULL,'2026-03-19 19:02:58'),(30,'OPS.RECEPTIONS.SETTLE','OPERATIONS','EXECUTE','SUCCESS','CRITICAL',1,'pojeda@ayg.cl','ADMIN',NULL,NULL,'/api/v1/finances/settlements','GET','::1','node','812e0bae-714d-47f5-9283-134e6045f9ee','6fa6d9c4-4506-444c-a9b0-55d02f792270',NULL,NULL,'{\"responseTime\": \"104ms\"}',NULL,'2026-03-19 19:02:59'),(31,'AUTH.LOGIN.ATTEMPT','AUTH','LOGIN','SUCCESS','HIGH',NULL,NULL,NULL,NULL,NULL,'/api/v1/auth/login','POST','::1','node','d1e0f626-3e84-4d23-b529-03ec93c29f03','4c76c207-eaf6-4b7e-81ae-8bc34cac831c',NULL,NULL,'{\"responseTime\": \"665ms\"}',NULL,'2026-03-19 20:29:42'),(32,'OPS.RECEPTIONS.SETTLE','OPERATIONS','EXECUTE','SUCCESS','CRITICAL',1,'pojeda@ayg.cl','ADMIN',NULL,NULL,'/api/v1/finances/settlements','GET','::1','node','b5e20aa0-65de-425c-a041-e923509d4dd1','bde99dfe-fb4f-4b65-a15e-05e3c52e1e4e',NULL,NULL,'{\"responseTime\": \"26ms\"}',NULL,'2026-03-19 20:29:44');
/*!40000 ALTER TABLE `audit_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `timestamp` bigint NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,1741689000000,'AddAllParametersToTemplate1741689000000'),(2,1772983328273,'AddNameToUsers1772983328273'),(3,1778497200000,'AddInterestFieldsToAdvance1778497200000'),(4,1778500000000,'AddConsultantRole1778500000000'),(5,1778600000000,'AddSettlementCompositionAndAdvanceLink1778600000000'),(6,1778620000000,'RenameAdvancePendingStatusToPaid1778620000000'),(7,1778700000000,'AddGroupToleranceNameToTemplate1778700000000'),(8,1778800000000,'AddAnalysisRecordSnapshotFields1778800000000'),(9,1778900000000,'ReplaceInProcessReceptionStatusWithCancelled1778900000000'),(10,1779000000000,'AddSettlementReceptionSnapshots1779000000000'),(11,1779800000000,'AddInventoryBookFields1779800000000'),(12,1780000000000,'AddUserPermissionOverrides1780000000000'),(13,1780001000000,'DeleteAlwaysGrantedAnalysisOverrides1780001000000'),(14,1710777600000,'CreateAuditEventsTable1710777600000'),(15,1781000000000,'AddGroupPercentToAnalysisRecords1781000000000'),(16,1780020000000,'UpdateAnalysisParamsRanges1780020000000'),(17,1780021000000,'AlignAnalysisParamsCodesToFrontend1780021000000');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producers`
--

DROP TABLE IF EXISTS `producers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` timestamp(6) NULL DEFAULT NULL,
  `rut` varchar(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `contactPerson` varchar(100) DEFAULT NULL,
  `bankAccounts` json DEFAULT NULL,
  `notes` text,
  `isActive` tinyint NOT NULL DEFAULT '1',
  `totalDebt` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_producer_rut` (`rut`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producers`
--

LOCK TABLES `producers` WRITE;
/*!40000 ALTER TABLE `producers` DISABLE KEYS */;
INSERT INTO `producers` VALUES (1,'2026-03-17 13:21:44.681927','2026-03-17 13:21:44.681927',NULL,'15699696-3','EDUARDO ANTONIO LEIVA LEIVA','PREDIO SANTA RITA ROL 89-182','SAN GREGORIO','+5693038474','','','[]',NULL,1,0.00),(2,'2026-03-18 17:59:43.764712','2026-03-19 19:01:33.000000',NULL,'16822404-4','FELIPE CHANDIA CASTILLO','','','','','','[]',NULL,1,0.00),(3,'2026-03-18 18:09:54.416985','2026-03-18 18:09:54.416985',NULL,'15826093-k','GONZALO LEIVA VALLADARES','PARCELA 4 LOTE 2 CURIPEUMO','PARRAL','','','','[]',NULL,1,0.00),(4,'2026-03-18 18:10:52.817451','2026-03-18 18:10:52.817451',NULL,'12966924-1','CESAR GONZALEZ CAMPOS','PREDIO EL PINO FUERTE VIEJO','PARRAL','','','','[]',NULL,1,0.00);
/*!40000 ALTER TABLE `producers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receptions`
--

DROP TABLE IF EXISTS `receptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` timestamp(6) NULL DEFAULT NULL,
  `producerId` int NOT NULL,
  `templateId` int NOT NULL,
  `seasonId` int NOT NULL,
  `riceTypeId` int NOT NULL,
  `guideNumber` varchar(50) NOT NULL,
  `receptionBookNumber` varchar(50) DEFAULT NULL,
  `receptionDate` date DEFAULT NULL,
  `licensePlate` varchar(50) NOT NULL,
  `ricePrice` decimal(10,2) NOT NULL,
  `grossWeight` decimal(10,2) NOT NULL,
  `tareWeight` decimal(10,2) NOT NULL,
  `netWeight` decimal(10,2) NOT NULL,
  `totalDiscountKg` decimal(10,2) DEFAULT NULL,
  `bonusKg` decimal(10,2) DEFAULT NULL,
  `finalNetWeight` decimal(10,2) DEFAULT NULL,
  `dryPercent` decimal(5,2) DEFAULT NULL,
  `dryFeeApplied` tinyint NOT NULL DEFAULT '0',
  `status` enum('cancelled','analyzed','settled') NOT NULL DEFAULT 'cancelled',
  `settlementId` int DEFAULT NULL,
  `userId` int DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  KEY `idx_reception_status` (`status`),
  KEY `idx_reception_producer_season` (`producerId`,`seasonId`),
  KEY `FK_81126cf7c97eede0a1ac12e7570` (`templateId`),
  KEY `FK_9935e3c5a90509d7404916c4479` (`seasonId`),
  KEY `FK_2793b26fbcd6c56b79c17471535` (`riceTypeId`),
  CONSTRAINT `FK_2793b26fbcd6c56b79c17471535` FOREIGN KEY (`riceTypeId`) REFERENCES `rice_types` (`id`),
  CONSTRAINT `FK_81126cf7c97eede0a1ac12e7570` FOREIGN KEY (`templateId`) REFERENCES `templates` (`id`),
  CONSTRAINT `FK_9935e3c5a90509d7404916c4479` FOREIGN KEY (`seasonId`) REFERENCES `seasons` (`id`),
  CONSTRAINT `FK_e4886fefc321677613897f44d38` FOREIGN KEY (`producerId`) REFERENCES `producers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receptions`
--

LOCK TABLES `receptions` WRITE;
/*!40000 ALTER TABLE `receptions` DISABLE KEYS */;
INSERT INTO `receptions` VALUES (6,'2026-03-19 13:35:02.552336','2026-03-19 13:35:02.782000',NULL,2,1,1,1,'11111','6','2026-03-19','BN-111',600.00,3000.00,250.00,2750.00,0.83,0.00,2749.17,0.00,0,'analyzed',NULL,1,NULL),(7,'2026-03-19 13:45:09.316580','2026-03-19 13:45:09.501000',NULL,1,1,1,7,'134','7','2026-03-19','SN5309',1.00,53800.00,16070.00,37730.00,897.97,0.00,36832.03,0.00,0,'analyzed',NULL,1,NULL);
/*!40000 ALTER TABLE `receptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rice_types`
--

DROP TABLE IF EXISTS `rice_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rice_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` timestamp(6) NULL DEFAULT NULL,
  `code` varchar(100) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `referencePrice` int DEFAULT NULL,
  `isActive` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_ricetype_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rice_types`
--

LOCK TABLES `rice_types` WRITE;
/*!40000 ALTER TABLE `rice_types` DISABLE KEYS */;
INSERT INTO `rice_types` VALUES (1,'2026-03-17 18:38:25.426603','2026-03-19 12:05:47.000000',NULL,'DIAMANTE','Diamante','',600,1),(2,'2026-03-17 18:38:43.958787','2026-03-19 12:05:48.000000',NULL,'ZAFIRO','Zafiro','',550,1),(7,'2026-03-19 12:05:49.827573','2026-03-19 12:05:49.827573',NULL,'BR','Brillante',NULL,200,1),(8,'2026-03-19 12:05:50.883466','2026-03-19 12:05:50.883466',NULL,'HR','Harper',NULL,200,1);
/*!40000 ALTER TABLE `rice_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seasons`
--

DROP TABLE IF EXISTS `seasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seasons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` timestamp(6) NULL DEFAULT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `year` int NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date NOT NULL,
  `isActive` tinyint NOT NULL DEFAULT '0',
  `notes` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_season_year_code` (`year`,`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seasons`
--

LOCK TABLES `seasons` WRITE;
/*!40000 ALTER TABLE `seasons` DISABLE KEYS */;
INSERT INTO `seasons` VALUES (1,'2026-03-16 10:41:56.681129','2026-03-16 10:41:56.681129',NULL,'COSECHA_2026','COSECHA 2026',2026,'2025-12-31','2026-12-30',1,'Temporada base para iniciar la operación'),(2,'2026-03-19 12:05:51.766913','2026-03-19 12:05:51.766913',NULL,'SUMMER2026','Verano 2026',2026,'2025-12-31','2026-03-30',1,NULL),(3,'2026-03-19 12:05:52.657628','2026-03-19 12:05:52.657628',NULL,'WINTER2026','Invierno 2026',2026,'2026-03-31','2026-06-29',0,NULL);
/*!40000 ALTER TABLE `seasons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settlement_reception_snapshots`
--

DROP TABLE IF EXISTS `settlement_reception_snapshots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settlement_reception_snapshots` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` timestamp(6) NULL DEFAULT NULL,
  `settlementId` int NOT NULL,
  `receptionId` int NOT NULL,
  `lineOrder` int NOT NULL DEFAULT '0',
  `receptionDate` datetime DEFAULT NULL,
  `guideNumber` varchar(50) DEFAULT NULL,
  `riceTypeName` varchar(150) DEFAULT NULL,
  `paddyKg` decimal(12,2) NOT NULL DEFAULT '0.00',
  `ricePrice` decimal(12,2) NOT NULL DEFAULT '0.00',
  `paddySubTotal` bigint NOT NULL DEFAULT '0',
  `paddyVat` bigint NOT NULL DEFAULT '0',
  `paddyTotal` bigint NOT NULL DEFAULT '0',
  `dryPercent` decimal(5,2) NOT NULL DEFAULT '0.00',
  `dryingSubTotal` bigint NOT NULL DEFAULT '0',
  `dryingVat` bigint NOT NULL DEFAULT '0',
  `dryingTotal` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_settlement_reception_snapshot_settlement_reception` (`settlementId`,`receptionId`),
  KEY `idx_settlement_reception_snapshot_order` (`settlementId`,`lineOrder`),
  KEY `idx_settlement_reception_snapshot_reception` (`receptionId`),
  KEY `idx_settlement_reception_snapshot_settlement` (`settlementId`),
  CONSTRAINT `FK_0489ad27a923b9efa9743ce8d46` FOREIGN KEY (`settlementId`) REFERENCES `settlements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_60f4b83c0fb65b0db3898672be0` FOREIGN KEY (`receptionId`) REFERENCES `receptions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settlement_reception_snapshots`
--

LOCK TABLES `settlement_reception_snapshots` WRITE;
/*!40000 ALTER TABLE `settlement_reception_snapshots` DISABLE KEYS */;
/*!40000 ALTER TABLE `settlement_reception_snapshots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settlements`
--

DROP TABLE IF EXISTS `settlements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settlements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` timestamp(6) NULL DEFAULT NULL,
  `producerId` int NOT NULL,
  `seasonId` int NOT NULL,
  `status` enum('draft','completed','cancelled') NOT NULL DEFAULT 'draft',
  `receptionIds` json DEFAULT NULL,
  `advanceIds` json DEFAULT NULL,
  `totalReceptions` bigint NOT NULL DEFAULT '0',
  `totalPrice` bigint NOT NULL DEFAULT '0',
  `totalDiscounts` bigint NOT NULL DEFAULT '0',
  `totalBonuses` bigint NOT NULL DEFAULT '0',
  `finalAmount` bigint NOT NULL DEFAULT '0',
  `totalAdvances` bigint NOT NULL DEFAULT '0',
  `totalInterest` bigint NOT NULL DEFAULT '0',
  `ivaRice` bigint NOT NULL DEFAULT '0',
  `ivaServices` bigint NOT NULL DEFAULT '0',
  `amountDue` bigint NOT NULL DEFAULT '0',
  `calculationDetails` json DEFAULT NULL,
  `issuedAt` date DEFAULT NULL,
  `settledAt` date DEFAULT NULL,
  `purchaseInvoiceNumber` varchar(80) DEFAULT NULL,
  `userId` int DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  KEY `idx_settlement_status` (`status`),
  KEY `idx_settlement_season` (`seasonId`),
  KEY `idx_settlement_producer` (`producerId`),
  KEY `idx_settlement_producer_season` (`producerId`,`seasonId`),
  CONSTRAINT `FK_5def1b6329d7910d90f4f473ca4` FOREIGN KEY (`producerId`) REFERENCES `producers` (`id`),
  CONSTRAINT `FK_c1a178e66d4f389d3a776636366` FOREIGN KEY (`seasonId`) REFERENCES `seasons` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settlements`
--

LOCK TABLES `settlements` WRITE;
/*!40000 ALTER TABLE `settlements` DISABLE KEYS */;
/*!40000 ALTER TABLE `settlements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templates`
--

DROP TABLE IF EXISTS `templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `templates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` timestamp(6) NULL DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `producerId` int DEFAULT NULL,
  `isDefault` tinyint NOT NULL DEFAULT '0',
  `useToleranceGroup` tinyint NOT NULL DEFAULT '0',
  `groupToleranceValue` decimal(5,2) NOT NULL DEFAULT '5.00',
  `groupToleranceName` varchar(255) DEFAULT NULL,
  `availableHumedad` tinyint NOT NULL DEFAULT '1',
  `percentHumedad` decimal(5,2) NOT NULL DEFAULT '0.00',
  `toleranceHumedad` decimal(5,2) NOT NULL DEFAULT '2.00',
  `showToleranceHumedad` tinyint NOT NULL DEFAULT '1',
  `groupToleranceHumedad` tinyint NOT NULL DEFAULT '0',
  `availableGranosVerdes` tinyint NOT NULL DEFAULT '1',
  `percentGranosVerdes` decimal(5,2) NOT NULL DEFAULT '0.00',
  `toleranceGranosVerdes` decimal(5,2) NOT NULL DEFAULT '2.00',
  `showToleranceGranosVerdes` tinyint NOT NULL DEFAULT '1',
  `groupToleranceGranosVerdes` tinyint NOT NULL DEFAULT '0',
  `availableImpurezas` tinyint NOT NULL DEFAULT '1',
  `percentImpurezas` decimal(5,2) NOT NULL DEFAULT '0.00',
  `toleranceImpurezas` decimal(5,2) NOT NULL DEFAULT '2.00',
  `showToleranceImpurezas` tinyint NOT NULL DEFAULT '1',
  `groupToleranceImpurezas` tinyint NOT NULL DEFAULT '0',
  `availableVano` tinyint NOT NULL DEFAULT '1',
  `percentVano` decimal(5,2) NOT NULL DEFAULT '0.00',
  `toleranceVano` decimal(5,2) NOT NULL DEFAULT '2.00',
  `showToleranceVano` tinyint NOT NULL DEFAULT '1',
  `groupToleranceVano` tinyint NOT NULL DEFAULT '0',
  `availableHualcacho` tinyint NOT NULL DEFAULT '1',
  `percentHualcacho` decimal(5,2) NOT NULL DEFAULT '0.00',
  `toleranceHualcacho` decimal(5,2) NOT NULL DEFAULT '2.00',
  `showToleranceHualcacho` tinyint NOT NULL DEFAULT '1',
  `groupToleranceHualcacho` tinyint NOT NULL DEFAULT '0',
  `availableGranosManchados` tinyint NOT NULL DEFAULT '1',
  `percentGranosManchados` decimal(5,2) NOT NULL DEFAULT '0.00',
  `toleranceGranosManchados` decimal(5,2) NOT NULL DEFAULT '2.00',
  `showToleranceGranosManchados` tinyint NOT NULL DEFAULT '1',
  `groupToleranceGranosManchados` tinyint NOT NULL DEFAULT '0',
  `availableGranosPelados` tinyint NOT NULL DEFAULT '1',
  `percentGranosPelados` decimal(5,2) NOT NULL DEFAULT '0.00',
  `toleranceGranosPelados` decimal(5,2) NOT NULL DEFAULT '2.00',
  `showToleranceGranosPelados` tinyint NOT NULL DEFAULT '1',
  `groupToleranceGranosPelados` tinyint NOT NULL DEFAULT '0',
  `availableGranosYesosos` tinyint NOT NULL DEFAULT '1',
  `percentGranosYesosos` decimal(5,2) NOT NULL DEFAULT '0.00',
  `toleranceGranosYesosos` decimal(5,2) NOT NULL DEFAULT '2.00',
  `showToleranceGranosYesosos` tinyint NOT NULL DEFAULT '1',
  `groupToleranceGranosYesosos` tinyint NOT NULL DEFAULT '0',
  `availableBonus` tinyint NOT NULL DEFAULT '1',
  `toleranceBonus` decimal(5,2) NOT NULL DEFAULT '3.00',
  `availableDry` tinyint NOT NULL DEFAULT '0',
  `percentDry` decimal(5,2) NOT NULL DEFAULT '8.00',
  `isActive` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templates`
--

LOCK TABLES `templates` WRITE;
/*!40000 ALTER TABLE `templates` DISABLE KEYS */;
INSERT INTO `templates` VALUES (1,'2026-03-16 10:41:57.861957','2026-03-19 13:35:34.000000',NULL,'COSECHA 2026',NULL,1,1,4.00,'Analisis de Granos',1,0.00,4.00,1,0,1,0.00,0.00,0,1,1,0.00,0.00,0,1,0,0.00,0.00,0,0,0,0.00,0.00,0,0,0,0.00,0.00,0,0,1,0.00,0.00,0,1,0,0.00,0.00,0,0,1,0.00,1,0.00,1),(2,'2026-03-19 12:04:25.111598','2026-03-19 13:35:34.000000','2026-03-19 12:09:34.000000','newTemplate',NULL,0,1,4.00,'Analisis de Granos edit',1,0.00,0.00,1,0,1,0.00,0.00,1,1,1,0.00,0.00,0,1,0,0.00,0.00,0,0,0,0.00,0.00,0,0,1,0.00,0.00,0,1,1,0.00,0.00,0,1,0,0.00,0.00,0,0,1,0.00,1,0.00,1),(3,'2026-03-19 12:05:53.364319','2026-03-19 13:35:34.000000','2026-03-19 12:09:28.000000','newTemplate',NULL,0,1,4.00,'Análisis de Granos edit',1,0.00,0.00,1,0,1,0.00,0.00,1,1,1,0.00,0.00,0,1,0,0.00,0.00,0,0,0,0.00,0.00,0,0,1,0.00,0.00,0,1,1,0.00,0.00,0,1,0,0.00,0.00,0,0,1,0.00,1,0.00,1);
/*!40000 ALTER TABLE `templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` timestamp(6) NULL DEFAULT NULL,
  `producerId` int NOT NULL,
  `receptionId` int DEFAULT NULL,
  `advanceId` int DEFAULT NULL,
  `settlementId` int DEFAULT NULL,
  `type` enum('advance','payment','deduction','interest','refund','settlement') NOT NULL,
  `amount` bigint NOT NULL,
  `metadata` json DEFAULT NULL,
  `referenceNumber` varchar(255) DEFAULT NULL,
  `transactionDate` date NOT NULL,
  `userId` int DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  KEY `idx_transaction_type` (`type`),
  KEY `idx_transaction_producer` (`producerId`),
  KEY `FK_ef9a2d1e5c42ef16c0252375f9b` (`receptionId`),
  KEY `FK_54d6254e0d2f180e33ced2637d3` (`advanceId`),
  KEY `FK_229024839b0907bd38774150327` (`settlementId`),
  CONSTRAINT `FK_229024839b0907bd38774150327` FOREIGN KEY (`settlementId`) REFERENCES `settlements` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_54d6254e0d2f180e33ced2637d3` FOREIGN KEY (`advanceId`) REFERENCES `advances` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_da5154d806f4371855fb5945d95` FOREIGN KEY (`producerId`) REFERENCES `producers` (`id`),
  CONSTRAINT `FK_ef9a2d1e5c42ef16c0252375f9b` FOREIGN KEY (`receptionId`) REFERENCES `receptions` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,'2026-03-18 18:13:45.286673','2026-03-19 13:37:35.000000',NULL,3,NULL,1,NULL,'advance',4000000,'{\"bankAccount\": null, \"checkDetails\": {\"dueDate\": \"2025-09-29\", \"bankName\": \"Banco Santander Chile\", \"payeeRut\": \"15826093-k\", \"issueDate\": \"2025-09-29\", \"payeeName\": \"GONZALO LEIVA VALLADARES\"}, \"paymentMethod\": \"check\", \"advanceDescription\": null}','331657','2025-09-29',1,NULL),(2,'2026-03-18 18:18:23.009655','2026-03-18 18:18:23.009655',NULL,4,NULL,2,NULL,'advance',2000000,'{\"bankAccount\": null, \"checkDetails\": {\"dueDate\": \"2025-10-15\", \"bankName\": \"Banco Santander Chile\", \"payeeRut\": \"12966924-1\", \"issueDate\": \"2025-10-15\", \"payeeName\": \"CESAR GONZALEZ CAMPOS\"}, \"paymentMethod\": \"check\", \"advanceDescription\": null}','331662','2025-10-15',1,NULL),(3,'2026-03-19 13:41:35.807616','2026-03-19 13:41:35.807616',NULL,2,NULL,3,NULL,'advance',100000,'{\"bankAccount\": null, \"checkDetails\": {\"dueDate\": \"2026-01-01\", \"bankName\": \"Banco de Chile\", \"payeeRut\": \"16822404-4\", \"issueDate\": \"2026-03-19\", \"payeeName\": \"FELIPE CHANDIA\"}, \"paymentMethod\": \"check\", \"advanceDescription\": null}','1234567','2026-01-01',1,NULL);
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_permission_overrides`
--

DROP TABLE IF EXISTS `user_permission_overrides`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_permission_overrides` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `permissionKey` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `effect` enum('GRANT','REVOKE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `assignedByUserId` int DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deletedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_upo_user_permission` (`userId`,`permissionKey`),
  KEY `fk_upo_assigned_by` (`assignedByUserId`),
  CONSTRAINT `fk_upo_assigned_by` FOREIGN KEY (`assignedByUserId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_upo_user` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_permission_overrides`
--

LOCK TABLES `user_permission_overrides` WRITE;
/*!40000 ALTER TABLE `user_permission_overrides` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_permission_overrides` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` timestamp(6) NULL DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `role` enum('ADMIN','CONSULTANT') NOT NULL DEFAULT 'ADMIN',
  `isActive` tinyint NOT NULL DEFAULT '1',
  `phone` varchar(20) DEFAULT NULL,
  `lastLogin` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'2026-03-16 10:41:55.700044','2026-03-19 20:29:42.000000',NULL,'pojeda@ayg.cl','$2a$10$zI5ZWp5DDus0wGwGGqOKTOp84EJFayMwOTXHwshScqvb1Lo/K1ATa','Pojeda',NULL,NULL,'ADMIN',1,NULL,'2026-03-19 20:29:42.495'),(2,'2026-03-19 12:05:46.626327','2026-03-19 12:05:46.626327',NULL,'admin@ayg.cl','$2a$10$NdIv9s3ahqSVlYy6nBcfp.W5eMcUaZhAybESShjBC7EOPhIQL6hc.','Administrador',NULL,NULL,'ADMIN',1,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-20  1:03:33
