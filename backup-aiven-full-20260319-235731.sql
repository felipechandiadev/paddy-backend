mysqldump: [Warning] Using a password on the command line interface can be insecure.
Warning: A partial dump from a server that has GTIDs will by default include the GTIDs of all transactions, even those that changed suppressed parts of the database. If you don't want to restore GTIDs, pass --set-gtid-purged=OFF. To make a complete dump, pass --all-databases --triggers --routines --events. 
-- MySQL dump 10.13  Distrib 9.5.0, for macos15.7 (arm64)
--
-- Host: mysql-15bd0b47-paddy-aygpaddy-cba2.g.aivencloud.com    Database: defaultdb
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
5e525c76-2202-11f1-b2b7-7e74ec16743d:1-341';

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
  `status` varchar(20) NOT NULL DEFAULT 'paid',
  `settlementId` int DEFAULT NULL,
  `description` text,
  `isActive` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_advance_settlement` (`settlementId`),
  KEY `idx_advance_producer_season` (`producerId`,`seasonId`),
  KEY `FK_7ec87561637e45aacb85d5ed163` (`seasonId`),
  CONSTRAINT `FK_7ec87561637e45aacb85d5ed163` FOREIGN KEY (`seasonId`) REFERENCES `seasons` (`id`),
  CONSTRAINT `FK_9b15148f8accaa174484be57721` FOREIGN KEY (`settlementId`) REFERENCES `settlements` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_cbfdf13ae32cf87a12be0b04dd5` FOREIGN KEY (`producerId`) REFERENCES `producers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advances`
--

LOCK TABLES `advances` WRITE;
/*!40000 ALTER TABLE `advances` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analysis_params`
--

LOCK TABLES `analysis_params` WRITE;
/*!40000 ALTER TABLE `analysis_params` DISABLE KEYS */;
INSERT INTO `analysis_params` VALUES (1,'2026-03-20 02:22:20.835693','2026-03-20 02:22:20.835693',NULL,1,'Humedad','%',15.01,15.50,1.00,0,1),(2,'2026-03-20 02:22:21.631134','2026-03-20 02:22:21.631134',NULL,1,'Humedad','%',15.51,16.00,1.50,0,1),(3,'2026-03-20 02:22:22.432209','2026-03-20 02:22:22.432209',NULL,1,'Humedad','%',16.01,16.50,2.00,0,1),(4,'2026-03-20 02:22:23.214358','2026-03-20 02:22:23.214358',NULL,1,'Humedad','%',16.51,17.00,2.50,0,1),(5,'2026-03-20 02:22:23.994764','2026-03-20 02:22:23.994764',NULL,1,'Humedad','%',17.01,17.50,3.00,0,1),(6,'2026-03-20 02:22:24.862333','2026-03-20 02:22:24.862333',NULL,1,'Humedad','%',17.51,18.00,4.03,0,1),(7,'2026-03-20 02:22:25.685345','2026-03-20 02:22:25.685345',NULL,1,'Humedad','%',18.01,18.50,4.62,0,1),(8,'2026-03-20 02:22:26.523944','2026-03-20 02:22:26.523944',NULL,1,'Humedad','%',18.51,19.00,5.21,0,1),(9,'2026-03-20 02:22:27.305923','2026-03-20 02:22:27.305923',NULL,1,'Humedad','%',19.01,19.50,5.79,0,1),(10,'2026-03-20 02:22:28.103879','2026-03-20 02:22:28.103879',NULL,1,'Humedad','%',19.51,20.00,6.38,0,1),(11,'2026-03-20 02:22:29.081171','2026-03-20 02:22:29.081171',NULL,1,'Humedad','%',20.01,20.50,6.97,0,1),(12,'2026-03-20 02:22:29.864622','2026-03-20 02:22:29.864622',NULL,1,'Humedad','%',20.51,21.00,7.56,0,1),(13,'2026-03-20 02:22:30.637461','2026-03-20 02:22:30.637461',NULL,1,'Humedad','%',21.01,21.50,8.15,0,1),(14,'2026-03-20 02:22:31.415168','2026-03-20 02:22:31.415168',NULL,1,'Humedad','%',21.51,22.00,8.74,0,1),(15,'2026-03-20 02:22:32.191992','2026-03-20 02:22:32.191992',NULL,1,'Humedad','%',22.01,22.50,9.32,0,1),(16,'2026-03-20 02:22:32.966793','2026-03-20 02:22:32.966793',NULL,1,'Humedad','%',22.51,23.00,9.91,0,1),(17,'2026-03-20 02:22:33.743349','2026-03-20 02:22:33.743349',NULL,1,'Humedad','%',23.01,23.50,10.50,0,1),(18,'2026-03-20 02:22:34.521373','2026-03-20 02:22:34.521373',NULL,1,'Humedad','%',23.51,24.00,11.09,0,1),(19,'2026-03-20 02:22:35.294204','2026-03-20 02:22:35.294204',NULL,1,'Humedad','%',24.01,24.50,11.68,0,1),(20,'2026-03-20 02:22:36.065691','2026-03-20 02:22:36.065691',NULL,1,'Humedad','%',24.51,25.00,12.26,0,1),(21,'2026-03-20 02:22:36.837722','2026-03-20 02:22:36.837722',NULL,1,'Humedad','%',25.51,100.00,100.00,0,1),(22,'2026-03-20 02:22:37.828596','2026-03-20 02:22:37.828596',NULL,2,'Granos Verdes','%',0.00,2.00,0.00,0,1),(23,'2026-03-20 02:22:38.614598','2026-03-20 02:22:38.614598',NULL,2,'Granos Verdes','%',2.01,2.50,0.25,0,1),(24,'2026-03-20 02:22:39.388805','2026-03-20 02:22:39.388805',NULL,2,'Granos Verdes','%',2.51,3.00,0.50,0,1),(25,'2026-03-20 02:22:40.198956','2026-03-20 02:22:40.198956',NULL,2,'Granos Verdes','%',3.01,3.50,0.75,0,1),(26,'2026-03-20 02:22:40.976468','2026-03-20 02:22:40.976468',NULL,2,'Granos Verdes','%',3.51,4.00,1.00,0,1),(27,'2026-03-20 02:22:41.747993','2026-03-20 02:22:41.747993',NULL,2,'Granos Verdes','%',4.01,4.50,1.25,0,1),(28,'2026-03-20 02:22:42.528082','2026-03-20 02:22:42.528082',NULL,2,'Granos Verdes','%',4.51,5.00,1.50,0,1),(29,'2026-03-20 02:22:43.301256','2026-03-20 02:22:43.301256',NULL,2,'Granos Verdes','%',5.01,5.50,1.75,0,1),(30,'2026-03-20 02:22:44.073316','2026-03-20 02:22:44.073316',NULL,2,'Granos Verdes','%',5.51,6.00,2.00,0,1),(31,'2026-03-20 02:22:44.965188','2026-03-20 02:22:44.965188',NULL,2,'Granos Verdes','%',6.01,6.50,2.25,0,1),(32,'2026-03-20 02:22:45.781707','2026-03-20 02:22:45.781707',NULL,2,'Granos Verdes','%',6.51,7.00,2.50,0,1),(33,'2026-03-20 02:22:46.554692','2026-03-20 02:22:46.554692',NULL,2,'Granos Verdes','%',7.01,7.50,2.75,0,1),(34,'2026-03-20 02:22:47.326103','2026-03-20 02:22:47.326103',NULL,2,'Granos Verdes','%',7.51,8.00,3.00,0,1),(35,'2026-03-20 02:22:48.096401','2026-03-20 02:22:48.096401',NULL,2,'Granos Verdes','%',8.01,8.50,3.25,0,1),(36,'2026-03-20 02:22:48.874575','2026-03-20 02:22:48.874575',NULL,2,'Granos Verdes','%',8.51,9.00,3.50,0,1),(37,'2026-03-20 02:22:49.652877','2026-03-20 02:22:49.652877',NULL,2,'Granos Verdes','%',9.01,9.50,3.75,0,1),(38,'2026-03-20 02:22:50.841184','2026-03-20 02:22:50.841184',NULL,2,'Granos Verdes','%',9.51,10.00,4.00,0,1),(39,'2026-03-20 02:22:52.028276','2026-03-20 02:22:52.028276',NULL,2,'Granos Verdes','%',10.01,100.00,100.00,0,1);
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
  `groupPercent` decimal(5,2) DEFAULT NULL,
  `groupTolerance` decimal(5,2) DEFAULT NULL,
  `dryPercent` decimal(5,2) DEFAULT NULL,
  `summaryPercent` decimal(7,2) DEFAULT NULL,
  `summaryTolerance` decimal(7,2) DEFAULT NULL,
  `summaryPenaltyKg` decimal(10,2) DEFAULT NULL,
  `bonusEnabled` tinyint NOT NULL DEFAULT '0',
  `bonusPercent` decimal(5,2) DEFAULT NULL,
  `userId` int DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_analysisrecord_reception` (`receptionId`),
  UNIQUE KEY `IDX_f6f6de10456afba7e8864868f1` (`receptionId`),
  UNIQUE KEY `REL_f6f6de10456afba7e8864868f1` (`receptionId`),
  KEY `FK_d2282d2900131a0230edb488717` (`templateId`),
  CONSTRAINT `FK_d2282d2900131a0230edb488717` FOREIGN KEY (`templateId`) REFERENCES `templates` (`id`),
  CONSTRAINT `FK_f6f6de10456afba7e8864868f12` FOREIGN KEY (`receptionId`) REFERENCES `receptions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analysis_records`
--

LOCK TABLES `analysis_records` WRITE;
/*!40000 ALTER TABLE `analysis_records` DISABLE KEYS */;
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_events`
--

LOCK TABLES `audit_events` WRITE;
/*!40000 ALTER TABLE `audit_events` DISABLE KEYS */;
INSERT INTO `audit_events` VALUES (1,'OPS.RECEPTIONS.SETTLE','OPERATIONS','EXECUTE','SUCCESS','CRITICAL',1,'pojeda@ayg.cl','ADMIN',NULL,NULL,'/api/v1/finances/settlements','GET','::1','node','f432b7cd-292b-4f86-a7cd-8010d1e92265','8a5f1613-b767-42c0-ad35-6a9c8deeda89',NULL,NULL,'{\"responseTime\": \"25ms\"}',NULL,'2026-03-20 02:26:19');
/*!40000 ALTER TABLE `audit_events` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producers`
--

LOCK TABLES `producers` WRITE;
/*!40000 ALTER TABLE `producers` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receptions`
--

LOCK TABLES `receptions` WRITE;
/*!40000 ALTER TABLE `receptions` DISABLE KEYS */;
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
INSERT INTO `rice_types` VALUES (1,'2026-03-20 02:22:13.517080','2026-03-20 02:22:13.517080',NULL,'DIAMANTE','Diamante',NULL,600,1),(2,'2026-03-20 02:22:14.705146','2026-03-20 02:22:14.705146',NULL,'ZAFIRO','Zafiro',NULL,550,1),(7,'2026-03-20 02:22:15.870102','2026-03-20 02:22:15.870102',NULL,'BR','Brillante',NULL,200,1),(8,'2026-03-20 02:22:17.053153','2026-03-20 02:22:17.053153',NULL,'HR','Harper',NULL,200,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seasons`
--

LOCK TABLES `seasons` WRITE;
/*!40000 ALTER TABLE `seasons` DISABLE KEYS */;
INSERT INTO `seasons` VALUES (1,'2026-03-20 02:22:18.035375','2026-03-20 02:22:18.035375',NULL,'SUMMER2026','Verano 2026',2026,'2025-12-31','2026-03-30',1,NULL),(2,'2026-03-20 02:22:19.041824','2026-03-20 02:22:19.041824',NULL,'WINTER2026','Invierno 2026',2026,'2026-03-31','2026-06-29',0,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templates`
--

LOCK TABLES `templates` WRITE;
/*!40000 ALTER TABLE `templates` DISABLE KEYS */;
INSERT INTO `templates` VALUES (1,'2026-03-20 02:22:19.825712','2026-03-20 02:22:19.825712',NULL,'newTemplate',NULL,1,1,4.00,'Análisis de Granos edit',1,0.00,0.00,1,0,1,0.00,0.00,1,1,1,0.00,0.00,0,1,0,0.00,0.00,0,0,0,0.00,0.00,0,0,1,0.00,0.00,0,1,1,0.00,0.00,0,1,0,0.00,0.00,0,0,1,0.00,1,0.00,1);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
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
  `createdAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updatedAt` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  `deletedAt` timestamp(6) NULL DEFAULT NULL,
  `userId` int NOT NULL,
  `permissionKey` varchar(100) NOT NULL,
  `effect` enum('GRANT','REVOKE') NOT NULL,
  `assignedByUserId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_upo_user_permission` (`userId`,`permissionKey`),
  KEY `FK_b87f3cd6df96ee88a5d242240b9` (`assignedByUserId`),
  CONSTRAINT `FK_b87f3cd6df96ee88a5d242240b9` FOREIGN KEY (`assignedByUserId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_c9ecc1acd8da3e948d8394fa42f` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'2026-03-20 02:22:12.284829','2026-03-20 02:22:12.284829',NULL,'admin@ayg.cl','$2a$10$FxznqEm0DATUraonT.4b1.aFCEgH.sNw62O.Hu0ArvWau1ApHdEfW','Administrador',NULL,NULL,'ADMIN',1,NULL,NULL);
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

-- Dump completed on 2026-03-19 23:58:14
