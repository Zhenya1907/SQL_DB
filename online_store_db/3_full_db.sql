-- MariaDB dump 10.19  Distrib 10.5.12-MariaDB, for Linux (x86_64)
--
-- Host: mysql.hostinger.ro    Database: u574849695_17
-- ------------------------------------------------------
-- Server version	10.5.12-MariaDB-cll-lve

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `customer_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `index_` bigint(20) DEFAULT NULL,
  `country` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `street` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `house_number` int(11) DEFAULT NULL,
  `flat_number` int(11) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES 
(1,64822,'Italy','Port Nathanaelfort','Suite 931',51,884),
(2,3614,'Nicaragua','New Murray','Suite 984',94,439),
(3,74720,'Seychelles','Sigurdberg','Suite 593',56,152),
(4,58261,'Saint Martin','Fatimaton','Apt. 874',39,850),
(5,63603,'Ukraine','Lake Trystan','Suite 744',82,177),
(6,91808,'Taiwan','West Berenicebury','Apt. 532',40,130),
(7,35757,'Namibia','East Ole','Apt. 672',67,719),
(8,12157,'Nigeria','New Naomie','Suite 195',59,648),
(9,83028,'French Polynesia','New Zion','Apt. 524',64,862),
(10,57583,'Czech Republic','Riceshire','Suite 729',73,241);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart` (
  `customer_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (7,1),(1,2),(2,4),(8,4),(9,4),(3,6),(5,8),(10,13),(6,16),(4,20);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` bigint(20) DEFAULT NULL,
  `password_hash` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `customer_firstname_lastname_idx` (`firstname`,`lastname`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES 
(1,'Polina','Karen','alvis89@example.net',95348160518,'25f783d4de18fedb41705858f79b1be2834ceefa'),
(2,'Valery','Mia','malcolm79@example.org',91430162740,'8f4a10ae03fdd4918016c9775b67f83ac65f1bd2'),
(3,'Liza','Jacinthe','bbogisich@example.com',97358372132,'e28e1bbd891c110fb6c1ccc4152d2f8ab596cc53'),
(4,'Antonina','Kylie','aboyer@example.org',98000510516,'54113bab41b360ee8f89911a169e8507fae54ab7'),
(5,'Anastasia','Sister','shana.murphy@example.org',93704010215,'0382e049036cabb79e93675eff6cb03ca755d373'),
(6,'Inna','Kameron','lonzo28@example.com',99531734958,'18042bf24cbd0f2f91d1b921b1a5f1b6e3193785'),
(7,'Julia','Beryl','eschumm@example.org',90298053263,'4d16611febbb077f59c99278f024d30db17e74a4'),
(8,'Yana','Elisabeth','tbernhard@example.com',95525713358,'d72fb6f1602ccad1675762f35e46f931920d0015'),
(9,'Marina','Laverna','ugoldner@example.net',93865904356,'756d435171644911cba71ca723106293f015a6d6'),
(10,'Evgenia','Lexi','nkuhic@example.com',97723747729,'0283c42b60384a48c10023ca13be535795daa711');

/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery`
--

DROP TABLE IF EXISTS `delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `delivery` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `status` enum('Ожидает отправки','Отправлен','Доставлен') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `address_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `delivery_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `address` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery`
--

LOCK TABLES `delivery` WRITE;
/*!40000 ALTER TABLE `delivery` DISABLE KEYS */;
INSERT INTO `delivery` VALUES 
(1,'Отправлен','1971-02-11 12:22:55','2006-11-15 21:31:00',2),
(2,'Отправлен','2011-09-20 07:59:26','1987-09-20 20:54:18',2),
(3,'Ожидает отправки','1975-05-09 19:05:36','2018-02-28 08:34:32',3),
(4,'Доставлен','2008-09-06 16:57:22','1982-10-02 19:05:49',2),
(5,'Ожидает отправки','2016-05-28 22:30:55','1999-02-25 15:15:22',9);
/*!40000 ALTER TABLE `delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `filename` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES 
(1,'etx.jpg',286),(2,'pfm.jpg',487),(3,'xbap.jpg',278),(4,'dart.jpg',143),(5,'tfm.jpg',260),
(6,'xenc.jpg',396),(7,'xsm.jpg',162),(8,'sid.jpg',427),(9,'pfa.jpg',515),(10,'wmlc.jpg',496);
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_number` int(11) DEFAULT NULL,
  `customer_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `to_delivery_id` bigint(20) unsigned NOT NULL,
  `payment_method` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('Оплачен','В работе','Отправлен','Закрыт') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  KEY `product_id` (`product_id`),
  KEY `to_delivery_id` (`to_delivery_id`),
  KEY `order_number_idx` (`order_number`),
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `order_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `order_ibfk_3` FOREIGN KEY (`to_delivery_id`) REFERENCES `delivery` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES 
(1,101,1,2,1,'ЮMoney','Оплачен','2013-04-16 05:30:33','2008-12-18 19:50:19'),
(2,101,1,13,2,'ЮMoney','Оплачен','2013-04-16 05:30:33','2008-12-18 19:50:19'),
(3,102,6,4,3,'ЮMoney','Оплачен','2001-10-07 13:53:50','1972-08-04 13:00:08'),
(4,103,7,10,4,'Банковская карта','В работе','2004-09-14 10:54:54','2018-04-02 17:07:00'),
(5,103,7,3,5,'Банковская карта','В работе','2004-09-14 10:54:54','2018-04-02 17:07:00');

/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `types_id` bigint(20) unsigned NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `availability` tinyint(1) DEFAULT NULL,
  `media_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `types_id` (`types_id`),
  KEY `media_id` (`media_id`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`types_id`) REFERENCES `types` (`id`),
  CONSTRAINT `product_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES 
(1,1,'Хлоя','80D','Белый',2009,1,7),
(2,3,'Кира','S','Белый',2353,1,2),
(3,1,'Джиа','75C','Белый',2552,1,3),
(4,2,'Хлоя','M','Белый',3125,0,5),
(5,1,'Джиа','75C','Черный',2598,1,8),
(6,3,'Кира','L','Черный',2963,1,3),
(7,3,'Кира','M','Черный',3037,1,8),
(8,1,'Джиа','70B','Белый',3088,1,1),
(9,1,'Хлоя','75C','Черный',3159,1,8),
(10,2,'Джиа','M','Черный',2715,1,8),
(11,3,'Кира','S','Белый',2516,1,2),
(12,2,'Джиа','S','Красный',2562,1,1),
(13,1,'Хлоя','70B','Черный',3280,1,6),
(14,2,'Хлоя','S','Черный',2069,1,1),
(15,2,'Хлоя','L','Черный',2388,1,1),
(16,2,'Хлоя','M','Белый',3011,1,8),
(17,1,'Джиа','70B','Красный',2578,1,6),
(18,2,'Хлоя','M','Белый',3466,1,7),
(19,3,'Кира','M','Красный',2271,1,5),
(20,2,'Хлоя','L','Красный',2979,1,1);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `types`
--

DROP TABLE IF EXISTS `types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type_name` (`type_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `types`
--

LOCK TABLES `types` WRITE;
/*!40000 ALTER TABLE `types` DISABLE KEYS */;
INSERT INTO `types` VALUES 
(1,'Бюст'),(2,'Трусы'),(3,'Боди');
/*!40000 ALTER TABLE `types` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-01 11:21:13
