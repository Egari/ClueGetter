-- MySQL dump 10.15  Distrib 10.0.19-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: cluegetter
-- ------------------------------------------------------
-- Server version	10.0.19-MariaDB-1~trusty-log

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
-- Table structure for table `instance`
--

DROP TABLE IF EXISTS `instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET ascii NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message` (
  `id` varchar(25) CHARACTER SET ascii NOT NULL,
  `session` bigint(20) unsigned NOT NULL,
  `date` datetime NOT NULL,
  `sender` varchar(255) NOT NULL DEFAULT '',
  `rcpt_count` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `session` (`session`),
  CONSTRAINT `message_ibfk_1` FOREIGN KEY (`session`) REFERENCES `session` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `message_recipient`
--

DROP TABLE IF EXISTS `message_recipient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_recipient` (
  `message` varchar(25) CHARACTER SET ascii NOT NULL,
  `recipient` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`message`,`recipient`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quota`
--

DROP TABLE IF EXISTS `quota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quota` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `selector` enum('sender','recipient','client_address','sasl_username') NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `is_regex` tinyint(1) DEFAULT '0',
  `profile` bigint(20) unsigned NOT NULL,
  `instigator` bigint(20) unsigned DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `profile` (`profile`),
  KEY `selector_value` (`selector`,`value`),
  CONSTRAINT `quota_ibfk_1` FOREIGN KEY (`profile`) REFERENCES `quota_profile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=192 DEFAULT CHARSET=ascii;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quota_message`
--

DROP TABLE IF EXISTS `quota_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quota_message` (
  `quota` bigint(20) unsigned NOT NULL,
  `message` varchar(25) CHARACTER SET ascii NOT NULL,
  PRIMARY KEY (`quota`,`message`),
  KEY `message` (`message`),
  CONSTRAINT `quota_message_ibfk_1` FOREIGN KEY (`quota`) REFERENCES `quota` (`id`),
  CONSTRAINT `quota_message_ibfk_2` FOREIGN KEY (`message`) REFERENCES `message` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quota_profile`
--

DROP TABLE IF EXISTS `quota_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quota_profile` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cluegetter_instance` bigint(20) unsigned NOT NULL,
  `name` varchar(32) NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `cluegetter_instance` (`cluegetter_instance`),
  CONSTRAINT `quota_profile_ibfk_1` FOREIGN KEY (`cluegetter_instance`) REFERENCES `instance` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quota_profile_period`
--

DROP TABLE IF EXISTS `quota_profile_period`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quota_profile_period` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `profile` bigint(20) unsigned NOT NULL,
  `period` int(10) unsigned NOT NULL,
  `curb` int(10) unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `profile` (`profile`),
  CONSTRAINT `profile_id` FOREIGN KEY (`profile`) REFERENCES `quota_profile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipient`
--

DROP TABLE IF EXISTS `recipient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipient` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `local` varchar(64) DEFAULT NULL,
  `domain` varchar(253) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `local` (`local`,`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cluegetter_instance` bigint(20) unsigned NOT NULL,
  `date_connect` datetime NOT NULL,
  `date_disconnect` datetime DEFAULT NULL,
  `ip` varchar(45) CHARACTER SET ascii COLLATE ascii_bin NOT NULL DEFAULT '',
  `sasl_username` varchar(255) NOT NULL DEFAULT '',
  UNIQUE KEY `id` (`id`),
  KEY `cluegetter_instance` (`cluegetter_instance`),
  CONSTRAINT `session_ibfk_1` FOREIGN KEY (`cluegetter_instance`) REFERENCES `instance` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-06-05 20:40:02
