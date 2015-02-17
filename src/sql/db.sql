CREATE DATABASE  IF NOT EXISTS `timereport` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `timereport`;
-- MySQL dump 10.13  Distrib 5.5.41, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: timereport
-- ------------------------------------------------------
-- Server version	5.5.41-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `activities`
--

DROP TABLE IF EXISTS `activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_activities_1_idx` (`companyId`),
  CONSTRAINT `fk_activities_1` FOREIGN KEY (`companyId`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=537 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `companies`
--

DROP TABLE IF EXISTS `companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data`
--

DROP TABLE IF EXISTS `data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `projectId` int(11) NOT NULL,
  `activityId` int(11) NOT NULL,
  `dt` varchar(10) NOT NULL,
  `hours` decimal(9,2) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_data_1_idx` (`userId`),
  KEY `fk_data_2_idx` (`projectId`),
  KEY `fk_data_3_idx` (`activityId`),
  CONSTRAINT `fk_data_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1743 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_activities`
--

DROP TABLE IF EXISTS `project_activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_activities` (
  `projectId` int(11) NOT NULL,
  `activityId` int(11) NOT NULL,
  PRIMARY KEY (`projectId`,`activityId`),
  KEY `fk_project_activities_2_idx` (`activityId`),
  CONSTRAINT `fk_project_activities_1` FOREIGN KEY (`projectId`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_activities_2` FOREIGN KEY (`activityId`) REFERENCES `activities` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_users`
--

DROP TABLE IF EXISTS `project_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_users` (
  `projectId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`projectId`,`userId`),
  KEY `fk_project_users_2_idx` (`userId`),
  CONSTRAINT `fk_project_users_1` FOREIGN KEY (`projectId`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_users_2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_projects_1_idx` (`companyId`),
  CONSTRAINT `fk_projects_1` FOREIGN KEY (`companyId`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=273 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyId` int(11) NOT NULL,
  `firstName` varchar(45) NOT NULL,
  `lastName` varchar(45) NOT NULL,
  `email` varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL,
  `lastLogin` date DEFAULT NULL,
  `activationHash` varchar(45) DEFAULT NULL,
  `isAdmin` tinyint(1) DEFAULT NULL,
  `isDemo` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQ_USERS_EMAIL` (`email`),
  KEY `fk_users_1_idx` (`companyId`),
  CONSTRAINT `fk_users_1` FOREIGN KEY (`companyId`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=202 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `v_activities`
--

DROP TABLE IF EXISTS `v_activities`;
/*!50001 DROP VIEW IF EXISTS `v_activities`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_activities` (
  `id` tinyint NOT NULL,
  `companyId` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `hours` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_project_activities_a`
--

DROP TABLE IF EXISTS `v_project_activities_a`;
/*!50001 DROP VIEW IF EXISTS `v_project_activities_a`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_project_activities_a` (
  `projectId` tinyint NOT NULL,
  `id` tinyint NOT NULL,
  `companyId` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `hours` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_project_activities_p`
--

DROP TABLE IF EXISTS `v_project_activities_p`;
/*!50001 DROP VIEW IF EXISTS `v_project_activities_p`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_project_activities_p` (
  `activityId` tinyint NOT NULL,
  `id` tinyint NOT NULL,
  `companyId` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `hours` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_project_users_p`
--

DROP TABLE IF EXISTS `v_project_users_p`;
/*!50001 DROP VIEW IF EXISTS `v_project_users_p`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_project_users_p` (
  `userId` tinyint NOT NULL,
  `id` tinyint NOT NULL,
  `companyId` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `hours` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_project_users_u`
--

DROP TABLE IF EXISTS `v_project_users_u`;
/*!50001 DROP VIEW IF EXISTS `v_project_users_u`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_project_users_u` (
  `projectId` tinyint NOT NULL,
  `id` tinyint NOT NULL,
  `companyId` tinyint NOT NULL,
  `firstName` tinyint NOT NULL,
  `lastName` tinyint NOT NULL,
  `email` tinyint NOT NULL,
  `password` tinyint NOT NULL,
  `lastLogin` tinyint NOT NULL,
  `activationHash` tinyint NOT NULL,
  `isAdmin` tinyint NOT NULL,
  `isDemo` tinyint NOT NULL,
  `hours` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_projects`
--

DROP TABLE IF EXISTS `v_projects`;
/*!50001 DROP VIEW IF EXISTS `v_projects`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_projects` (
  `id` tinyint NOT NULL,
  `companyId` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `hours` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_user_activities_a`
--

DROP TABLE IF EXISTS `v_user_activities_a`;
/*!50001 DROP VIEW IF EXISTS `v_user_activities_a`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_user_activities_a` (
  `userId` tinyint NOT NULL,
  `id` tinyint NOT NULL,
  `companyId` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `hours` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_user_activities_u`
--

DROP TABLE IF EXISTS `v_user_activities_u`;
/*!50001 DROP VIEW IF EXISTS `v_user_activities_u`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_user_activities_u` (
  `activityId` tinyint NOT NULL,
  `id` tinyint NOT NULL,
  `companyId` tinyint NOT NULL,
  `firstName` tinyint NOT NULL,
  `lastName` tinyint NOT NULL,
  `email` tinyint NOT NULL,
  `password` tinyint NOT NULL,
  `lastLogin` tinyint NOT NULL,
  `activationHash` tinyint NOT NULL,
  `isAdmin` tinyint NOT NULL,
  `isDemo` tinyint NOT NULL,
  `hours` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_users`
--

DROP TABLE IF EXISTS `v_users`;
/*!50001 DROP VIEW IF EXISTS `v_users`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `v_users` (
  `id` tinyint NOT NULL,
  `companyId` tinyint NOT NULL,
  `firstName` tinyint NOT NULL,
  `lastName` tinyint NOT NULL,
  `email` tinyint NOT NULL,
  `password` tinyint NOT NULL,
  `lastLogin` tinyint NOT NULL,
  `activationHash` tinyint NOT NULL,
  `isAdmin` tinyint NOT NULL,
  `isDemo` tinyint NOT NULL,
  `hours` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'timereport'
--
/*!50003 DROP PROCEDURE IF EXISTS `createDemoUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `createDemoUser`(IN companyId INT)
BEGIN

DECLARE userId1 INT;
DECLARE userId2 INT;
DECLARE userId3 INT;

DECLARE projectId1 INT;
DECLARE projectId2 INT;
DECLARE projectId3 INT;
DECLARE projectId4 INT;

DECLARE activityId1 INT;
DECLARE activityId2 INT;
DECLARE activityId3 INT;
DECLARE activityId4 INT;
DECLARE activityId5 INT;
DECLARE activityId6 INT;
DECLARE activityId7 INT;
DECLARE activityId8 INT;

-- USERS

INSERT INTO `users` (`companyId`, `firstName`, `lastName`, `email`, `password`, `isAdmin`, `isDemo`)
VALUES (companyId, 'Петр', 'Иванов', CONCAT('peter@company', companyId, '.ru'), '', 1, 1);
SELECT LAST_INSERT_ID() INTO userId1;

INSERT INTO `users` (`companyId`, `firstName`, `lastName`, `email`, `password`, `isAdmin`, `isDemo`)
VALUES (companyId, 'Михаил', 'Авдеев', CONCAT('michael@company', companyId, '.ru'), '', 0, 1);
SELECT LAST_INSERT_ID() INTO userId2;

INSERT INTO `users` (`companyId`, `firstName`, `lastName`, `email`, `password`, `isAdmin`, `isDemo`)
VALUES (companyId, 'Анна', 'Уварова', CONCAT('anna@company', companyId, '.ru'), '', 0, 1);
SELECT LAST_INSERT_ID() INTO userId3;

-- PROJECTS

INSERT INTO `projects` (`companyId`, `name`, `description`)
VALUES (companyId, 'Умный дом', 'Разработка проекта умного дома на базе ABB i-bus KNX.');
SELECT LAST_INSERT_ID() INTO projectId1;

INSERT INTO `projects` (`companyId`, `name`, `description`)
VALUES (companyId, 'Колорит 6x8', 'Разработка проекта двухэтажного монолитного железобетонного дома 6x8 \"Колорит\".');
SELECT LAST_INSERT_ID() INTO projectId2;

INSERT INTO `projects` (`companyId`, `name`, `description`)
VALUES (companyId, 'Договор №246 от 14.01.2015', 'Разработка проекта отопления для деревянного коттеджа по договору №246 от 14.01.2015.');
SELECT LAST_INSERT_ID() INTO projectId3;

INSERT INTO `projects` (`companyId`, `name`, `description`)
VALUES (companyId, 'Прочее', 'Задания, не имеющие отношения к какому-либо проекту.');
SELECT LAST_INSERT_ID() INTO projectId4;

-- ACTIVITIES

INSERT INTO `activities` (`companyId`, `name`)
VALUES (companyId, 'Предпроектное обследование');
SELECT LAST_INSERT_ID() INTO activityId1;

INSERT INTO `activities` (`companyId`, `name`)
VALUES (companyId, 'Выезд на объект');
SELECT LAST_INSERT_ID() INTO activityId2;

INSERT INTO `activities` (`companyId`, `name`)
VALUES (companyId, 'Переговоры с клиентом');
SELECT LAST_INSERT_ID() INTO activityId3;

INSERT INTO `activities` (`companyId`, `name`)
VALUES (companyId, 'Разработка чертежей');
SELECT LAST_INSERT_ID() INTO activityId4;

INSERT INTO `activities` (`companyId`, `name`)
VALUES (companyId, 'Подготовка документации');
SELECT LAST_INSERT_ID() INTO activityId5;

INSERT INTO `activities` (`companyId`, `name`)
VALUES (companyId, 'Совещания');
SELECT LAST_INSERT_ID() INTO activityId6;

INSERT INTO `activities` (`companyId`, `name`)
VALUES (companyId, 'Холодные звонки');
SELECT LAST_INSERT_ID() INTO activityId7;

INSERT INTO `activities` (`companyId`, `name`)
VALUES (companyId, 'Прочее');
SELECT LAST_INSERT_ID() INTO activityId8;

-- PROJECT USERS

INSERT INTO `project_users` (`projectId`, `userId`) VALUES (projectId1, userId1);
INSERT INTO `project_users` (`projectId`, `userId`) VALUES (projectId1, userId2);
INSERT INTO `project_users` (`projectId`, `userId`) VALUES (projectId1, userId3);

INSERT INTO `project_users` (`projectId`, `userId`) VALUES (projectId2, userId1);
INSERT INTO `project_users` (`projectId`, `userId`) VALUES (projectId2, userId2);
INSERT INTO `project_users` (`projectId`, `userId`) VALUES (projectId2, userId3);

INSERT INTO `project_users` (`projectId`, `userId`) VALUES (projectId3, userId1);
INSERT INTO `project_users` (`projectId`, `userId`) VALUES (projectId3, userId2);
INSERT INTO `project_users` (`projectId`, `userId`) VALUES (projectId3, userId3);

INSERT INTO `project_users` (`projectId`, `userId`) VALUES (projectId4, userId1);
INSERT INTO `project_users` (`projectId`, `userId`) VALUES (projectId4, userId3);

-- PROJECT_ACTIVITIES

INSERT INTO `project_activities` (`projectId`, `activityId`)
VALUES (projectId1, activityId1);
INSERT INTO `project_activities` (`projectId`, `activityId`)
VALUES (projectId1, activityId2);
INSERT INTO `project_activities` (`projectId`, `activityId`)
VALUES (projectId1, activityId3);
INSERT INTO `project_activities` (`projectId`, `activityId`)
VALUES (projectId1, activityId4);
INSERT INTO `project_activities` (`projectId`, `activityId`)
VALUES (projectId1, activityId5);
INSERT INTO `project_activities` (`projectId`, `activityId`)
VALUES (projectId1, activityId6);

INSERT INTO `project_activities` (`projectId`, `activityId`)
VALUES (projectId2, activityId4);
INSERT INTO `project_activities` (`projectId`, `activityId`)
VALUES (projectId2, activityId5);
INSERT INTO `project_activities` (`projectId`, `activityId`)
VALUES (projectId2, activityId6);

INSERT INTO `project_activities` (`projectId`, `activityId`)
VALUES (projectId3, activityId1);
INSERT INTO `project_activities` (`projectId`, `activityId`)
VALUES (projectId3, activityId2);
INSERT INTO `project_activities` (`projectId`, `activityId`)
VALUES (projectId3, activityId3);
INSERT INTO `project_activities` (`projectId`, `activityId`)
VALUES (projectId3, activityId4);
INSERT INTO `project_activities` (`projectId`, `activityId`)
VALUES (projectId3, activityId5);
INSERT INTO `project_activities` (`projectId`, `activityId`)
VALUES (projectId3, activityId6);
INSERT INTO `project_activities` (`projectId`, `activityId`)
VALUES (projectId3, activityId8);

INSERT INTO `project_activities` (`projectId`, `activityId`)
VALUES (projectId4, activityId5);
INSERT INTO `project_activities` (`projectId`, `activityId`)
VALUES (projectId4, activityId7);

-- DATA
-- User 1
INSERT INTO `data` (`userId`,`projectId`,`activityId`,`dt`,`hours`)
VALUES(userId1, projectId1, activityId1, DATE(subdate(NOW(), 3)), 5.00);
INSERT INTO `data` (`userId`,`projectId`,`activityId`,`dt`,`hours`)
VALUES(userId1, projectId1, activityId1, DATE(subdate(NOW(), 0)), 1.00);
INSERT INTO `data` (`userId`,`projectId`,`activityId`,`dt`,`hours`)
VALUES(userId1, projectId1, activityId2, DATE(subdate(NOW(), 0)), 2.00);
INSERT INTO `data` (`userId`,`projectId`,`activityId`,`dt`,`hours`)
VALUES(userId1, projectId1, activityId3, DATE(subdate(NOW(), 2)), 4.00);
INSERT INTO `data` (`userId`,`projectId`,`activityId`,`dt`,`hours`)
VALUES(userId1, projectId1, activityId3, DATE(subdate(NOW(), 12)), 5.00);
INSERT INTO `data` (`userId`,`projectId`,`activityId`,`dt`,`hours`)
VALUES(userId1, projectId1, activityId3, DATE(subdate(NOW(), 11)), 1.00);
INSERT INTO `data` (`userId`,`projectId`,`activityId`,`dt`,`hours`)
VALUES(userId1, projectId1, activityId3, DATE(subdate(NOW(), 10)), 4.00);
INSERT INTO `data` (`userId`,`projectId`,`activityId`,`dt`,`hours`)
VALUES(userId1, projectId1, activityId6, DATE(subdate(NOW(), 2)), 3.00);

INSERT INTO `data` (`userId`,`projectId`,`activityId`,`dt`,`hours`)
VALUES(userId1, projectId2, activityId4, DATE(subdate(NOW(), 1)), 7.00);
INSERT INTO `data` (`userId`,`projectId`,`activityId`,`dt`,`hours`)
VALUES(userId1, projectId2, activityId5, DATE(subdate(NOW(), 0)), 3.00);
INSERT INTO `data` (`userId`,`projectId`,`activityId`,`dt`,`hours`)
VALUES(userId1, projectId2, activityId5, DATE(subdate(NOW(), 13)), 4.00);

INSERT INTO `data` (`userId`,`projectId`,`activityId`,`dt`,`hours`)
VALUES(userId1, projectId3, activityId2, DATE(subdate(NOW(), 2)), 3.00);
INSERT INTO `data` (`userId`,`projectId`,`activityId`,`dt`,`hours`)
VALUES(userId1, projectId3, activityId2, DATE(subdate(NOW(), 13)), 3.00);
INSERT INTO `data` (`userId`,`projectId`,`activityId`,`dt`,`hours`)
VALUES(userId1, projectId3, activityId2, DATE(subdate(NOW(), 20)), 3.00);
INSERT INTO `data` (`userId`,`projectId`,`activityId`,`dt`,`hours`)
VALUES(userId1, projectId4, activityId5, DATE(subdate(NOW(), 3)), 1.50);

-- User 2
INSERT INTO `data` (`userId`,`projectId`,`activityId`,`dt`,`hours`)
VALUES(userId2, projectId1, activityId4, DATE(subdate(NOW(), 0)), 10.00);
INSERT INTO `data` (`userId`,`projectId`,`activityId`,`dt`,`hours`)
VALUES(userId2, projectId1, activityId5, DATE(subdate(NOW(), 1)), 8.00);
INSERT INTO `data` (`userId`,`projectId`,`activityId`,`dt`,`hours`)
VALUES(userId2, projectId1, activityId6, DATE(subdate(NOW(), 2)), 3.00);

INSERT INTO `data` (`userId`,`projectId`,`activityId`,`dt`,`hours`)
VALUES(userId2, projectId2, activityId4, DATE(subdate(NOW(), 0)), 20.00);
INSERT INTO `data` (`userId`,`projectId`,`activityId`,`dt`,`hours`)
VALUES(userId2, projectId2, activityId5, DATE(subdate(NOW(), 1)), 18.50);


-- User 3
INSERT INTO `data` (`userId`,`projectId`,`activityId`,`dt`,`hours`)
VALUES(userId3, projectId1, activityId5, DATE(subdate(NOW(), 1)), 8.00);
INSERT INTO `data` (`userId`,`projectId`,`activityId`,`dt`,`hours`)
VALUES(userId3, projectId1, activityId6, DATE(subdate(NOW(), 2)), 3.00);

INSERT INTO `data` (`userId`,`projectId`,`activityId`,`dt`,`hours`)
VALUES(userId3, projectId4, activityId7, DATE(subdate(NOW(), 0)), 8.00);
INSERT INTO `data` (`userId`,`projectId`,`activityId`,`dt`,`hours`)
VALUES(userId3, projectId4, activityId7, DATE(subdate(NOW(), 1)), 8.00);
INSERT INTO `data` (`userId`,`projectId`,`activityId`,`dt`,`hours`)
VALUES(userId3, projectId4, activityId7, DATE(subdate(NOW(), 2)), 8.00);

INSERT INTO `data` (`userId`,`projectId`,`activityId`,`dt`,`hours`)
VALUES(userId3, projectId3, activityId8, DATE(subdate(NOW(), 1)), 1.50);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `v_activities`
--

/*!50001 DROP TABLE IF EXISTS `v_activities`*/;
/*!50001 DROP VIEW IF EXISTS `v_activities`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_activities` AS select `a`.`id` AS `id`,`a`.`companyId` AS `companyId`,`a`.`name` AS `name`,`a`.`description` AS `description`,coalesce(sum(`d`.`hours`),0) AS `hours` from (`activities` `a` left join `data` `d` on((`a`.`id` = `d`.`activityId`))) where ((`d`.`deleted` = 0) or isnull(`d`.`deleted`)) group by `a`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_project_activities_a`
--

/*!50001 DROP TABLE IF EXISTS `v_project_activities_a`*/;
/*!50001 DROP VIEW IF EXISTS `v_project_activities_a`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_project_activities_a` AS select `pa`.`projectId` AS `projectId`,`a`.`id` AS `id`,`a`.`companyId` AS `companyId`,`a`.`name` AS `name`,`a`.`description` AS `description`,coalesce(sum(`d`.`hours`),0) AS `hours` from ((`project_activities` `pa` join `activities` `a` on((`a`.`id` = `pa`.`activityId`))) left join `data` `d` on(((`d`.`projectId` = `pa`.`projectId`) and (`d`.`activityId` = `pa`.`activityId`)))) where ((`d`.`deleted` = 0) or isnull(`d`.`deleted`)) group by `pa`.`projectId`,`pa`.`activityId` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_project_activities_p`
--

/*!50001 DROP TABLE IF EXISTS `v_project_activities_p`*/;
/*!50001 DROP VIEW IF EXISTS `v_project_activities_p`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_project_activities_p` AS select `pa`.`activityId` AS `activityId`,`p`.`id` AS `id`,`p`.`companyId` AS `companyId`,`p`.`name` AS `name`,`p`.`description` AS `description`,coalesce(sum(`d`.`hours`),0) AS `hours` from ((`project_activities` `pa` join `projects` `p` on((`p`.`id` = `pa`.`projectId`))) left join `data` `d` on(((`d`.`projectId` = `pa`.`projectId`) and (`d`.`activityId` = `pa`.`activityId`)))) where ((`d`.`deleted` = 0) or isnull(`d`.`deleted`)) group by `pa`.`activityId`,`pa`.`projectId` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_project_users_p`
--

/*!50001 DROP TABLE IF EXISTS `v_project_users_p`*/;
/*!50001 DROP VIEW IF EXISTS `v_project_users_p`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_project_users_p` AS select `pu`.`userId` AS `userId`,`p`.`id` AS `id`,`p`.`companyId` AS `companyId`,`p`.`name` AS `name`,`p`.`description` AS `description`,coalesce(sum(`d`.`hours`),0) AS `hours` from ((`project_users` `pu` join `projects` `p` on((`p`.`id` = `pu`.`projectId`))) left join `data` `d` on(((`d`.`userId` = `pu`.`userId`) and (`d`.`projectId` = `pu`.`projectId`)))) where ((`d`.`deleted` = 0) or isnull(`d`.`deleted`)) group by `pu`.`userId`,`pu`.`projectId` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_project_users_u`
--

/*!50001 DROP TABLE IF EXISTS `v_project_users_u`*/;
/*!50001 DROP VIEW IF EXISTS `v_project_users_u`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_project_users_u` AS select `pu`.`projectId` AS `projectId`,`u`.`id` AS `id`,`u`.`companyId` AS `companyId`,`u`.`firstName` AS `firstName`,`u`.`lastName` AS `lastName`,`u`.`email` AS `email`,`u`.`password` AS `password`,`u`.`lastLogin` AS `lastLogin`,`u`.`activationHash` AS `activationHash`,`u`.`isAdmin` AS `isAdmin`,`u`.`isDemo` AS `isDemo`,coalesce(sum(`d`.`hours`),0) AS `hours` from ((`project_users` `pu` join `users` `u` on((`u`.`id` = `pu`.`userId`))) left join `data` `d` on(((`d`.`userId` = `pu`.`userId`) and (`d`.`projectId` = `pu`.`projectId`)))) where ((`d`.`deleted` = 0) or isnull(`d`.`deleted`)) group by `pu`.`projectId`,`pu`.`userId` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_projects`
--

/*!50001 DROP TABLE IF EXISTS `v_projects`*/;
/*!50001 DROP VIEW IF EXISTS `v_projects`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_projects` AS select `p`.`id` AS `id`,`p`.`companyId` AS `companyId`,`p`.`name` AS `name`,`p`.`description` AS `description`,coalesce(sum(`d`.`hours`),0) AS `hours` from (`projects` `p` left join `data` `d` on((`p`.`id` = `d`.`projectId`))) where ((`d`.`deleted` = 0) or isnull(`d`.`deleted`)) group by `p`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_user_activities_a`
--

/*!50001 DROP TABLE IF EXISTS `v_user_activities_a`*/;
/*!50001 DROP VIEW IF EXISTS `v_user_activities_a`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_user_activities_a` AS select `d`.`userId` AS `userId`,`a`.`id` AS `id`,`a`.`companyId` AS `companyId`,`a`.`name` AS `name`,`a`.`description` AS `description`,coalesce(sum(`d`.`hours`),0) AS `hours` from (`data` `d` join `activities` `a` on((`a`.`id` = `d`.`activityId`))) where ((`d`.`deleted` = 0) or isnull(`d`.`deleted`)) group by `d`.`userId` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_user_activities_u`
--

/*!50001 DROP TABLE IF EXISTS `v_user_activities_u`*/;
/*!50001 DROP VIEW IF EXISTS `v_user_activities_u`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_user_activities_u` AS select `d`.`activityId` AS `activityId`,`u`.`id` AS `id`,`u`.`companyId` AS `companyId`,`u`.`firstName` AS `firstName`,`u`.`lastName` AS `lastName`,`u`.`email` AS `email`,`u`.`password` AS `password`,`u`.`lastLogin` AS `lastLogin`,`u`.`activationHash` AS `activationHash`,`u`.`isAdmin` AS `isAdmin`,`u`.`isDemo` AS `isDemo`,coalesce(sum(`d`.`hours`),0) AS `hours` from (`data` `d` join `users` `u` on((`u`.`id` = `d`.`userId`))) where ((`d`.`deleted` = 0) or isnull(`d`.`deleted`)) group by `d`.`activityId` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_users`
--

/*!50001 DROP TABLE IF EXISTS `v_users`*/;
/*!50001 DROP VIEW IF EXISTS `v_users`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_users` AS select `u`.`id` AS `id`,`u`.`companyId` AS `companyId`,`u`.`firstName` AS `firstName`,`u`.`lastName` AS `lastName`,`u`.`email` AS `email`,`u`.`password` AS `password`,`u`.`lastLogin` AS `lastLogin`,`u`.`activationHash` AS `activationHash`,`u`.`isAdmin` AS `isAdmin`,`u`.`isDemo` AS `isDemo`,coalesce(sum(`d`.`hours`),0) AS `hours` from (`users` `u` left join `data` `d` on((`u`.`id` = `d`.`userId`))) where ((`d`.`deleted` = 0) or isnull(`d`.`deleted`)) group by `u`.`id` */;
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

-- Dump completed on 2015-02-17 17:30:28
