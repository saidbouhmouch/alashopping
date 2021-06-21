  SET FOREIGN_KEY_CHECKS = 0;
-- MySQL dump 10.13  Distrib 8.0.19, for macos10.15 (x86_64)
--
-- Host: localhost    Database: TUTO_lumen_vuejs_ecommerce
-- ------------------------------------------------------
-- Server version	8.0.19

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

--
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addresses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `addresse` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zipcode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country_id` int unsigned DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `addresses_country_id_foreign` (`country_id`),
  KEY `addresses_user_id_foreign` (`user_id`),
  CONSTRAINT `addresses_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `addresses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
INSERT INTO `addresses` VALUES (1,'marrakech','marrakech','78888','shipping',131,1,'2020-09-19 15:53:41','2020-09-19 15:53:41');
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carriers`
--

DROP TABLE IF EXISTS `carriers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carriers` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` double(8,2) NOT NULL DEFAULT '0.00',
  `delivery_text` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug_unique_carriers` (`slug`),
  KEY `carriers_image_id_foreign` (`image_id`),
  CONSTRAINT `carriers_image_id_foreign` FOREIGN KEY (`image_id`) REFERENCES `storages` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carriers`
--

LOCK TABLES `carriers` WRITE;
/*!40000 ALTER TABLE `carriers` DISABLE KEYS */;
INSERT INTO `carriers` VALUES (1,'Dhl','dhl',20.00,'Dhl',266,'2020-10-21 14:45:54','2020-10-21 14:45:54'),(2,'Fedex Express','fedex-express',0.00,'Fedex Express',267,'2020-10-23 15:13:37','2020-10-23 15:13:37');
/*!40000 ALTER TABLE `carriers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `parent_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug_unique_categories` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Outdoor plants','outdoor-plants','Outdoor plants',NULL,'2020-09-19 15:55:35','2020-09-19 15:55:35'),(2,'Indoor plants','indoor-plants','Indoor plants',NULL,'2020-09-19 15:55:47','2020-09-19 15:55:47'),(3,'Office Plants','office-plants','Office Plants',NULL,'2020-09-19 15:55:59','2020-09-19 15:55:59'),(4,'Potted','potted','Potted',NULL,'2020-09-19 15:56:11','2020-09-19 15:56:11'),(5,'Others','others','Others',NULL,'2020-09-19 15:56:21','2020-09-19 15:56:21');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_product`
--

DROP TABLE IF EXISTS `category_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_product` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int unsigned DEFAULT NULL,
  `category_id` int unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_product_product_id_foreign` (`product_id`),
  KEY `category_product_category_id_foreign` (`category_id`),
  CONSTRAINT `category_product_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `category_product_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_product`
--

LOCK TABLES `category_product` WRITE;
/*!40000 ALTER TABLE `category_product` DISABLE KEYS */;
INSERT INTO `category_product` VALUES (4,NULL,2,NULL,NULL),(5,NULL,1,NULL,NULL),(6,NULL,3,NULL,NULL),(7,NULL,1,NULL,NULL),(8,1,1,NULL,NULL);
/*!40000 ALTER TABLE `category_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `countries_image_id_foreign` (`image_id`),
  CONSTRAINT `countries_image_id_foreign` FOREIGN KEY (`image_id`) REFERENCES `storages` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'Andorra','AD',1,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(2,'United Arab Emirates','AE',2,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(3,'Afghanistan','AF',3,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(4,'Antigua And Barbuda','AG',4,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(5,'Anguilla','AI',5,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(6,'Albania','AL',6,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(7,'Armenia','AM',7,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(8,'Angola','AO',9,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(9,'Argentina','AR',11,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(10,'American Samoa','AS',12,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(11,'Austria','AT',13,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(12,'Australia','AU',14,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(13,'Aruba','AW',15,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(14,'Azerbaijan','AZ',17,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(15,'Bosnia And Herzegovina','BA',18,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(16,'Barbados','BB',19,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(17,'Bangladesh','BD',20,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(18,'Belgium','BE',21,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(19,'Burkina Faso','BF',22,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(20,'Bulgaria','BG',23,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(21,'Bahrain','BH',24,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(22,'Burundi','BI',25,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(23,'Benin','BJ',26,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(24,'Saint Barthelemy','BL',27,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(25,'Bermuda','BM',28,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(26,'Brunei','BN',29,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(27,'Bolivia','BO',30,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(28,'Brazil','BR',32,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(29,'Bahamas, The','BS',33,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(30,'Bhutan','BT',34,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(31,'Botswana','BW',36,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(32,'Belarus','BY',37,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(33,'Belize','BZ',38,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(34,'Canada','CA',39,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(35,'Cocos (Keeling) Islands','CC',40,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(36,'Congo (Kinshasa)','CD',41,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(37,'Central African Republic','CF',42,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(38,'Congo (Brazzaville)','CG',43,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(39,'Switzerland','CH',44,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(40,'C\\ud892\\udd60D\\u04c9voire','CI',45,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(41,'Cook Islands','CK',46,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(42,'Chile','CL',47,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(43,'Cameroon','CM',48,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(44,'China','CN',49,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(45,'Colombia','CO',50,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(46,'Costa Rica','CR',51,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(47,'Cuba','CU',52,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(48,'Cabo Verde','CV',53,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(49,'Cura\\u88af','CW',54,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(50,'Christmas Island','CX',55,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(51,'Cyprus','CY',56,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(52,'Czechia','CZ',57,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(53,'Germany','DE',58,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(54,'Djibouti','DJ',59,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(55,'Denmark','DK',60,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(56,'Dominica','DM',61,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(57,'Dominican Republic','DO',62,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(58,'Algeria','DZ',63,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(59,'Ecuador','EC',64,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(60,'Estonia','EE',65,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(61,'Egypt','EG',66,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(62,'Western Sahara','EH',67,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(63,'Eritrea','ER',69,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(64,'Spain','ES',70,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(65,'Ethiopia','ET',71,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(66,'Finland','FI',72,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(67,'Fiji','FJ',73,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(68,'Falkland Islands (Islas Malvinas)','FK',74,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(69,'Micronesia, Federated States Of','FM',75,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(70,'Faroe Islands','FO',76,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(71,'France','FR',77,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(72,'Gabon','GA',78,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(73,'United Kingdom','GB',79,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(74,'Grenada','GD',80,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(75,'Georgia','GE',81,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(76,'French Guiana','GF',82,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(77,'Guernsey','GG',83,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(78,'Ghana','GH',84,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(79,'Gibraltar','GI',85,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(80,'Greenland','GL',86,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(81,'Gambia, The','GM',87,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(82,'Guinea','GN',88,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(83,'Guadeloupe','GP',89,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(84,'Equatorial Guinea','GQ',90,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(85,'Greece','GR',91,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(86,'South Georgia And South Sandwich Islands','GS',92,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(87,'Guatemala','GT',93,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(88,'Guam','GU',94,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(89,'Guinea-Bissau','GW',95,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(90,'Guyana','GY',96,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(91,'Hong Kong','HK',97,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(92,'Honduras','HN',99,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(93,'Croatia','HR',100,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(94,'Haiti','HT',101,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(95,'Hungary','HU',102,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(96,'Indonesia','ID',103,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(97,'Ireland','IE',104,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(98,'Isle Of Man','IM',105,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(99,'India','IN',106,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(100,'British Indian Ocean Territory','IO',107,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(101,'Iraq','IQ',108,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(102,'Iran','IR',109,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(103,'Iceland','IS',110,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(104,'Italy','IT',111,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(105,'Jersey','JE',113,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(106,'Jamaica','JM',114,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(107,'Jordan','JO',115,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(108,'Japan','JP',116,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(109,'Kenya','KE',117,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(110,'Kyrgyzstan','KG',118,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(111,'Cambodia','KH',119,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(112,'Kiribati','KI',120,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(113,'Comoros','KM',121,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(114,'Saint Kitts And Nevis','KN',122,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(115,'Korea, North','KP',123,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(116,'Korea, South','KR',124,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(117,'Kuwait','KW',125,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(118,'Cayman Islands','KY',126,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(119,'Kazakhstan','KZ',127,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(120,'Laos','LA',128,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(121,'Lebanon','LB',129,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(122,'Saint Lucia','LC',130,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(123,'Liechtenstein','LI',131,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(124,'Sri Lanka','LK',132,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(125,'Liberia','LR',133,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(126,'Lesotho','LS',134,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(127,'Lithuania','LT',135,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(128,'Luxembourg','LU',136,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(129,'Latvia','LV',137,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(130,'Libya','LY',138,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(131,'Morocco','MA',139,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(132,'Monaco','MC',140,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(133,'Moldova','MD',141,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(134,'Montenegro','ME',142,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(135,'Saint Martin','MF',143,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(136,'Madagascar','MG',144,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(137,'Marshall Islands','MH',145,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(138,'Macedonia','MK',146,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(139,'Mali','ML',147,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(140,'Burma','MM',148,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(141,'Mongolia','MN',149,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(142,'Macau','MO',150,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(143,'Northern Mariana Islands','MP',151,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(144,'Martinique','MQ',152,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(145,'Mauritania','MR',153,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(146,'Montserrat','MS',154,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(147,'Malta','MT',155,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(148,'Mauritius','MU',156,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(149,'Maldives','MV',157,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(150,'Malawi','MW',158,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(151,'Mexico','MX',159,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(152,'Malaysia','MY',160,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(153,'Mozambique','MZ',161,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(154,'Namibia','NA',162,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(155,'New Caledonia','NC',163,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(156,'Niger','NE',164,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(157,'Norfolk Island','NF',165,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(158,'Nigeria','NG',166,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(159,'Nicaragua','NI',167,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(160,'Netherlands','NL',168,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(161,'Norway','NO',169,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(162,'Nepal','NP',170,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(163,'Nauru','NR',171,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(164,'Niue','NU',172,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(165,'New Zealand','NZ',173,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(166,'Oman','OM',174,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(167,'Panama','PA',175,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(168,'Peru','PE',176,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(169,'French Polynesia','PF',177,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(170,'Papua New Guinea','PG',178,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(171,'Philippines','PH',179,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(172,'Pakistan','PK',180,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(173,'Poland','PL',181,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(174,'Saint Pierre And Miquelon','PM',182,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(175,'Pitcairn Islands','PN',183,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(176,'Puerto Rico','PR',184,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(177,'Portugal','PT',186,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(178,'Palau','PW',187,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(179,'Paraguay','PY',188,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(180,'Qatar','QA',189,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(181,'Reunion','RE',190,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(182,'Romania','RO',191,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(183,'Serbia','RS',192,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(184,'Russia','RU',193,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(185,'Rwanda','RW',194,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(186,'Saudi Arabia','SA',195,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(187,'Solomon Islands','SB',196,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(188,'Seychelles','SC',197,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(189,'Sudan','SD',198,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(190,'Sweden','SE',199,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(191,'Singapore','SG',200,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(192,'Saint Helena, Ascension, And Tristan Da Cunha','SH',201,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(193,'Slovenia','SI',202,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(194,'Slovakia','SK',204,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(195,'Sierra Leone','SL',205,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(196,'San Marino','SM',206,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(197,'Senegal','SN',207,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(198,'Somalia','SO',208,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(199,'Suriname','SR',209,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(200,'South Sudan','SS',210,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(201,'Sao Tome And Principe','ST',211,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(202,'El Salvador','SV',212,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(203,'Sint Maarten','SX',213,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(204,'Syria','SY',214,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(205,'Swaziland','SZ',215,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(206,'Turks And Caicos Islands','TC',216,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(207,'Chad','TD',217,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(208,'French Southern And Antarctic Lands','TF',218,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(209,'Togo','TG',219,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(210,'Thailand','TH',220,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(211,'Tajikistan','TJ',221,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(212,'Tokelau','TK',222,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(213,'Timor-Leste','TL',223,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(214,'Turkmenistan','TM',224,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(215,'Tunisia','TN',225,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(216,'Tonga','TO',226,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(217,'Turkey','TR',227,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(218,'Trinidad And Tobago','TT',228,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(219,'Tuvalu','TV',229,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(220,'Taiwan','TW',230,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(221,'Tanzania','TZ',231,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(222,'Ukraine','UA',232,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(223,'Uganda','UG',233,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(224,'United States','US',235,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(225,'Uruguay','UY',236,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(226,'Uzbekistan','UZ',237,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(227,'Saint Vincent And The Grenadines','VC',239,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(228,'Venezuela','VE',240,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(229,'Virgin Islands, British','VG',241,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(230,'Virgin Islands, U.S.','VI',242,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(231,'Vietnam','VN',243,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(232,'Vanuatu','VU',244,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(233,'Wallis And Futuna','WF',245,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(234,'Samoa','WS',246,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(235,'Kosovo','XK',247,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(236,'Yemen','YE',248,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(237,'Mayotte','YT',249,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(238,'South Africa','ZA',250,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(239,'Zambia','ZM',251,'2020-09-19 15:52:15','2020-09-19 15:52:15'),(240,'Zimbabw','ZW',252,'2020-09-19 15:52:15','2020-09-19 15:52:15');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currencies` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `iso` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` double(8,2) NOT NULL DEFAULT '0.00',
  `default` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currencies`
--

LOCK TABLES `currencies` WRITE;
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
INSERT INTO `currencies` VALUES (1,'Euro','EUR',1.00,0,'2020-09-19 17:58:54','2020-10-29 23:26:41'),(2,'dollar','dollar',10.00,1,'2020-09-19 17:59:17','2020-09-19 17:59:17');
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `galleries`
--

DROP TABLE IF EXISTS `galleries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `galleries` (
  `product_id` int unsigned DEFAULT NULL,
  `image_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `galleries_product_id_foreign` (`product_id`),
  KEY `galleries_image_id_foreign` (`image_id`),
  CONSTRAINT `galleries_image_id_foreign` FOREIGN KEY (`image_id`) REFERENCES `storages` (`id`) ON DELETE SET NULL,
  CONSTRAINT `galleries_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `galleries`
--

LOCK TABLES `galleries` WRITE;
/*!40000 ALTER TABLE `galleries` DISABLE KEYS */;
INSERT INTO `galleries` VALUES (NULL,287,NULL,NULL),(NULL,288,NULL,NULL),(NULL,289,NULL,NULL),(NULL,293,NULL,NULL),(1,298,NULL,NULL);
/*!40000 ALTER TABLE `galleries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (10,'2020_06_06_203546_create_storages_table',1),(11,'2020_06_06_203622_create_users_table',1),(12,'2020_06_06_203642_create_countries_table',1),(13,'2020_06_06_203659_create_addresses_table',1),(14,'2020_06_06_203748_create_roles_table',1),(15,'2020_06_06_204002_create_role_user_table',1),(16,'2020_08_28_212024_create_categories_table',1),(17,'2020_09_03_203947_create_tags_table',1),(18,'2020_09_14_202531_create_taxes_table',1),(19,'2020_09_19_165633_create_currencies_table',2),(21,'2020_10_19_094528_create_type_payment_table',3),(22,'2020_10_20_152742_create_carriers_table',4),(23,'2020_10_25_122531_create_products_table',5),(24,'2020_10_25_133542_create_category_product_table',5),(25,'2020_10_25_134037_create_tag_product_table',6),(26,'2020_11_04_222350_create_galleries_table',7);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` double(8,2) NOT NULL DEFAULT '0.00',
  `description_short` longtext COLLATE utf8_unicode_ci,
  `description_long` longtext COLLATE utf8_unicode_ci,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sku` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `stock` int DEFAULT '0',
  `additional_information` longtext COLLATE utf8_unicode_ci,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `taxe_id` int unsigned DEFAULT NULL,
  `currency_id` int unsigned DEFAULT NULL,
  `image_id` bigint unsigned DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_slug_products` (`slug`),
  UNIQUE KEY `unique_skus_products` (`sku`),
  KEY `products_taxe_id_foreign` (`taxe_id`),
  KEY `products_currency_id_foreign` (`currency_id`),
  KEY `products_image_id_foreign` (`image_id`),
  KEY `products_user_id_foreign` (`user_id`),
  CONSTRAINT `products_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE SET NULL,
  CONSTRAINT `products_image_id_foreign` FOREIGN KEY (`image_id`) REFERENCES `storages` (`id`) ON DELETE SET NULL,
  CONSTRAINT `products_taxe_id_foreign` FOREIGN KEY (`taxe_id`) REFERENCES `taxes` (`id`) ON DELETE SET NULL,
  CONSTRAINT `products_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'RECUERDOS PLANT',28.00,'','','recuerdos-plant','CT201807',13,'',0,1,1,297,1,'2021-01-17 15:11:34','2021-01-17 15:11:34');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_user`
--

DROP TABLE IF EXISTS `role_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int unsigned DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_user_role_id_foreign` (`role_id`),
  KEY `role_user_user_id_foreign` (`user_id`),
  CONSTRAINT `role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE SET NULL,
  CONSTRAINT `role_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_user`
--

LOCK TABLES `role_user` WRITE;
/*!40000 ALTER TABLE `role_user` DISABLE KEYS */;
INSERT INTO `role_user` VALUES (5,1,1,NULL,NULL);
/*!40000 ALTER TABLE `role_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `guard_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin','api','2020-09-19 15:52:14','2020-09-19 15:52:14'),(2,'client','api','2020-09-19 15:52:14','2020-09-19 15:52:14');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storages`
--

DROP TABLE IF EXISTS `storages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `url` longtext COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `size` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=302 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storages`
--

LOCK TABLES `storages` WRITE;
/*!40000 ALTER TABLE `storages` DISABLE KEYS */;
INSERT INTO `storages` VALUES (1,NULL,'ad','img/flag/ad.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(2,NULL,'ae','img/flag/ae.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(3,NULL,'af','img/flag/af.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(4,NULL,'ag','img/flag/ag.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(5,NULL,'ai','img/flag/ai.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(6,NULL,'al','img/flag/al.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(7,NULL,'am','img/flag/am.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(8,NULL,'an','img/flag/an.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(9,NULL,'ao','img/flag/ao.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(10,NULL,'aq','img/flag/aq.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(11,NULL,'ar','img/flag/ar.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(12,NULL,'as','img/flag/as.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(13,NULL,'at','img/flag/at.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(14,NULL,'au','img/flag/au.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(15,NULL,'aw','img/flag/aw.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(16,NULL,'ax','img/flag/ax.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(17,NULL,'az','img/flag/az.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(18,NULL,'ba','img/flag/ba.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(19,NULL,'bb','img/flag/bb.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(20,NULL,'bd','img/flag/bd.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(21,NULL,'be','img/flag/be.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(22,NULL,'bf','img/flag/bf.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(23,NULL,'bg','img/flag/bg.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(24,NULL,'bh','img/flag/bh.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(25,NULL,'bi','img/flag/bi.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(26,NULL,'bj','img/flag/bj.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(27,NULL,'bl','img/flag/bl.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(28,NULL,'bm','img/flag/bm.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(29,NULL,'bn','img/flag/bn.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(30,NULL,'bo','img/flag/bo.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(31,NULL,'bq','img/flag/bq.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(32,NULL,'br','img/flag/br.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(33,NULL,'bs','img/flag/bs.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(34,NULL,'bt','img/flag/bt.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(35,NULL,'bv','img/flag/bv.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(36,NULL,'bw','img/flag/bw.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(37,NULL,'by','img/flag/by.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(38,NULL,'bz','img/flag/bz.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(39,NULL,'ca','img/flag/ca.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(40,NULL,'cc','img/flag/cc.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(41,NULL,'cd','img/flag/cd.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(42,NULL,'cf','img/flag/cf.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(43,NULL,'cg','img/flag/cg.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(44,NULL,'ch','img/flag/ch.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(45,NULL,'ci','img/flag/ci.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(46,NULL,'ck','img/flag/ck.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(47,NULL,'cl','img/flag/cl.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(48,NULL,'cm','img/flag/cm.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(49,NULL,'cn','img/flag/cn.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(50,NULL,'co','img/flag/co.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(51,NULL,'cr','img/flag/cr.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(52,NULL,'cu','img/flag/cu.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(53,NULL,'cv','img/flag/cv.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(54,NULL,'cw','img/flag/cw.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(55,NULL,'cx','img/flag/cx.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(56,NULL,'cy','img/flag/cy.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(57,NULL,'cz','img/flag/cz.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(58,NULL,'de','img/flag/de.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(59,NULL,'dj','img/flag/dj.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(60,NULL,'dk','img/flag/dk.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(61,NULL,'dm','img/flag/dm.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(62,NULL,'do','img/flag/do.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(63,NULL,'dz','img/flag/dz.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(64,NULL,'ec','img/flag/ec.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(65,NULL,'ee','img/flag/ee.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(66,NULL,'eg','img/flag/eg.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(67,NULL,'eh','img/flag/eh.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(68,NULL,'en','img/flag/en.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(69,NULL,'er','img/flag/er.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(70,NULL,'es','img/flag/es.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(71,NULL,'et','img/flag/et.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(72,NULL,'fi','img/flag/fi.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(73,NULL,'fj','img/flag/fj.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(74,NULL,'fk','img/flag/fk.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(75,NULL,'fm','img/flag/fm.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(76,NULL,'fo','img/flag/fo.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(77,NULL,'fr','img/flag/fr.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(78,NULL,'ga','img/flag/ga.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(79,NULL,'gb','img/flag/gb.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(80,NULL,'gd','img/flag/gd.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(81,NULL,'ge','img/flag/ge.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(82,NULL,'gf','img/flag/gf.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(83,NULL,'gg','img/flag/gg.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(84,NULL,'gh','img/flag/gh.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(85,NULL,'gi','img/flag/gi.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(86,NULL,'gl','img/flag/gl.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(87,NULL,'gm','img/flag/gm.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(88,NULL,'gn','img/flag/gn.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(89,NULL,'gp','img/flag/gp.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(90,NULL,'gq','img/flag/gq.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(91,NULL,'gr','img/flag/gr.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(92,NULL,'gs','img/flag/gs.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(93,NULL,'gt','img/flag/gt.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(94,NULL,'gu','img/flag/gu.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(95,NULL,'gw','img/flag/gw.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(96,NULL,'gy','img/flag/gy.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(97,NULL,'hk','img/flag/hk.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(98,NULL,'hm','img/flag/hm.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(99,NULL,'hn','img/flag/hn.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(100,NULL,'hr','img/flag/hr.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(101,NULL,'ht','img/flag/ht.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(102,NULL,'hu','img/flag/hu.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(103,NULL,'id','img/flag/id.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(104,NULL,'ie','img/flag/ie.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(105,NULL,'im','img/flag/im.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(106,NULL,'in','img/flag/in.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(107,NULL,'io','img/flag/io.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(108,NULL,'iq','img/flag/iq.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(109,NULL,'ir','img/flag/ir.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(110,NULL,'is','img/flag/is.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(111,NULL,'it','img/flag/it.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(112,NULL,'ja','img/flag/ja.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(113,NULL,'je','img/flag/je.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(114,NULL,'jm','img/flag/jm.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(115,NULL,'jo','img/flag/jo.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(116,NULL,'jp','img/flag/jp.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(117,NULL,'ke','img/flag/ke.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(118,NULL,'kg','img/flag/kg.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(119,NULL,'kh','img/flag/kh.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(120,NULL,'ki','img/flag/ki.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(121,NULL,'km','img/flag/km.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(122,NULL,'kn','img/flag/kn.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(123,NULL,'kp','img/flag/kp.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(124,NULL,'kr','img/flag/kr.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(125,NULL,'kw','img/flag/kw.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(126,NULL,'ky','img/flag/ky.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(127,NULL,'kz','img/flag/kz.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(128,NULL,'la','img/flag/la.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(129,NULL,'lb','img/flag/lb.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(130,NULL,'lc','img/flag/lc.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(131,NULL,'li','img/flag/li.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(132,NULL,'lk','img/flag/lk.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(133,NULL,'lr','img/flag/lr.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(134,NULL,'ls','img/flag/ls.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(135,NULL,'lt','img/flag/lt.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(136,NULL,'lu','img/flag/lu.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(137,NULL,'lv','img/flag/lv.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(138,NULL,'ly','img/flag/ly.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(139,NULL,'ma','img/flag/ma.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(140,NULL,'mc','img/flag/mc.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(141,NULL,'md','img/flag/md.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(142,NULL,'me','img/flag/me.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(143,NULL,'mf','img/flag/mf.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(144,NULL,'mg','img/flag/mg.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(145,NULL,'mh','img/flag/mh.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(146,NULL,'mk','img/flag/mk.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(147,NULL,'ml','img/flag/ml.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(148,NULL,'mm','img/flag/mm.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(149,NULL,'mn','img/flag/mn.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(150,NULL,'mo','img/flag/mo.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(151,NULL,'mp','img/flag/mp.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(152,NULL,'mq','img/flag/mq.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(153,NULL,'mr','img/flag/mr.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(154,NULL,'ms','img/flag/ms.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(155,NULL,'mt','img/flag/mt.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(156,NULL,'mu','img/flag/mu.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(157,NULL,'mv','img/flag/mv.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(158,NULL,'mw','img/flag/mw.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(159,NULL,'mx','img/flag/mx.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(160,NULL,'my','img/flag/my.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(161,NULL,'mz','img/flag/mz.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(162,NULL,'na','img/flag/na.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(163,NULL,'nc','img/flag/nc.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(164,NULL,'ne','img/flag/ne.png','image','xs','2020-09-19 15:52:14','2020-09-19 15:52:14'),(165,NULL,'nf','img/flag/nf.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(166,NULL,'ng','img/flag/ng.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(167,NULL,'ni','img/flag/ni.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(168,NULL,'nl','img/flag/nl.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(169,NULL,'no','img/flag/no.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(170,NULL,'np','img/flag/np.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(171,NULL,'nr','img/flag/nr.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(172,NULL,'nu','img/flag/nu.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(173,NULL,'nz','img/flag/nz.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(174,NULL,'om','img/flag/om.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(175,NULL,'pa','img/flag/pa.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(176,NULL,'pe','img/flag/pe.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(177,NULL,'pf','img/flag/pf.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(178,NULL,'pg','img/flag/pg.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(179,NULL,'ph','img/flag/ph.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(180,NULL,'pk','img/flag/pk.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(181,NULL,'pl','img/flag/pl.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(182,NULL,'pm','img/flag/pm.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(183,NULL,'pn','img/flag/pn.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(184,NULL,'pr','img/flag/pr.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(185,NULL,'ps','img/flag/ps.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(186,NULL,'pt','img/flag/pt.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(187,NULL,'pw','img/flag/pw.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(188,NULL,'py','img/flag/py.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(189,NULL,'qa','img/flag/qa.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(190,NULL,'re','img/flag/re.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(191,NULL,'ro','img/flag/ro.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(192,NULL,'rs','img/flag/rs.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(193,NULL,'ru','img/flag/ru.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(194,NULL,'rw','img/flag/rw.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(195,NULL,'sa','img/flag/sa.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(196,NULL,'sb','img/flag/sb.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(197,NULL,'sc','img/flag/sc.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(198,NULL,'sd','img/flag/sd.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(199,NULL,'se','img/flag/se.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(200,NULL,'sg','img/flag/sg.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(201,NULL,'sh','img/flag/sh.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(202,NULL,'si','img/flag/si.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(203,NULL,'sj','img/flag/sj.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(204,NULL,'sk','img/flag/sk.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(205,NULL,'sl','img/flag/sl.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(206,NULL,'sm','img/flag/sm.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(207,NULL,'sn','img/flag/sn.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(208,NULL,'so','img/flag/so.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(209,NULL,'sr','img/flag/sr.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(210,NULL,'ss','img/flag/ss.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(211,NULL,'st','img/flag/st.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(212,NULL,'sv','img/flag/sv.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(213,NULL,'sx','img/flag/sx.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(214,NULL,'sy','img/flag/sy.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(215,NULL,'sz','img/flag/sz.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(216,NULL,'tc','img/flag/tc.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(217,NULL,'td','img/flag/td.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(218,NULL,'tf','img/flag/tf.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(219,NULL,'tg','img/flag/tg.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(220,NULL,'th','img/flag/th.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(221,NULL,'tj','img/flag/tj.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(222,NULL,'tk','img/flag/tk.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(223,NULL,'tl','img/flag/tl.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(224,NULL,'tm','img/flag/tm.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(225,NULL,'tn','img/flag/tn.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(226,NULL,'to','img/flag/to.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(227,NULL,'tr','img/flag/tr.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(228,NULL,'tt','img/flag/tt.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(229,NULL,'tv','img/flag/tv.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(230,NULL,'tw','img/flag/tw.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(231,NULL,'tz','img/flag/tz.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(232,NULL,'ua','img/flag/ua.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(233,NULL,'ug','img/flag/ug.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(234,NULL,'um','img/flag/um.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(235,NULL,'us','img/flag/us.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(236,NULL,'uy','img/flag/uy.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(237,NULL,'uz','img/flag/uz.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(238,NULL,'va','img/flag/va.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(239,NULL,'vc','img/flag/vc.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(240,NULL,'ve','img/flag/ve.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(241,NULL,'vg','img/flag/vg.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(242,NULL,'vi','img/flag/vi.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(243,NULL,'vn','img/flag/vn.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(244,NULL,'vu','img/flag/vu.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(245,NULL,'wf','img/flag/wf.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(246,NULL,'ws','img/flag/ws.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(247,NULL,'xk','img/flag/xk.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(248,NULL,'ye','img/flag/ye.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(249,NULL,'yt','img/flag/yt.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(250,NULL,'za','img/flag/za.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(251,NULL,'zm','img/flag/zm.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(252,NULL,'zw','img/flag/zw.png','image','xs','2020-09-19 15:52:15','2020-09-19 15:52:15'),(253,NULL,'Screen Shot 2020-04-06 at 10.png','/uploads/users/screen-shot-2020-04-06-at-10png-3.jpg','image','default','2020-09-19 15:53:41','2020-09-19 15:53:41'),(255,NULL,'paypal.png','/uploads/type-payments/paypalpng-0.jpg','image','default','2020-10-19 11:08:44','2020-10-19 11:08:44'),(256,NULL,'master_card.png','/uploads/type-payments/master-cardpng.jpg','image','default','2020-10-19 11:13:51','2020-10-19 11:13:51'),(257,NULL,'visa.png','/uploads/type-payments/visapng.jpg','image','default','2020-10-19 11:15:37','2020-10-19 11:15:37'),(258,NULL,'espèce.png','/uploads/type-payments/especepng.jpg','image','default','2020-10-19 11:19:54','2020-10-19 11:19:54'),(259,NULL,'visa','/uploads/type-payments/visa.jpg','image','default','2020-10-19 11:43:02','2020-10-19 11:43:02'),(266,NULL,'dhl','/uploads/carriers/dhl.jpg','image','default','2020-10-21 14:45:54','2020-10-21 14:45:54'),(267,NULL,'fedex_express','/uploads/carriers/fedex-express.jpg','image','default','2020-10-23 15:13:37','2020-10-23 15:13:37'),(286,NULL,'semainier','/uploads/products/semainier-8.jpg','image','default','2020-11-04 22:26:23','2020-11-04 22:26:23'),(287,NULL,'semainier','/uploads/galleries/semainier-0.jpg','image','default','2020-11-04 22:26:23','2020-11-04 22:26:23'),(288,NULL,'117656758_191956445625480_7659057770717506870_n','/uploads/galleries/117656758-191956445625480-7659057770717506870-n.jpg','image','default','2020-11-04 22:26:23','2020-11-04 22:26:23'),(289,NULL,'afriqua','/uploads/galleries/afriqua.jpg','image','default','2020-11-04 22:26:23','2020-11-04 22:26:23'),(290,NULL,'CCB-header-brainstorming-offi','/uploads/users/ccb-header-brainstorming-offi.jpg','image','default','2021-01-13 21:18:00','2021-01-13 21:18:00'),(291,NULL,'Screen Shot 2020-12-02 at 7.36.35 PM','/uploads/users/screen-shot-2020-12-02-at-73635-pm.jpg','image','default','2021-01-13 21:19:18','2021-01-13 21:19:18'),(292,NULL,'43','/uploads/products/43.jpg','image','default','2021-01-17 15:01:04','2021-01-17 15:01:04'),(293,NULL,'49','/uploads/galleries/49.jpg','image','default','2021-01-17 15:01:04','2021-01-17 15:01:04'),(294,293,'49','/uploads/galleries/49-0.jpg','image','md','2021-01-17 15:01:04','2021-01-17 15:01:04'),(295,293,'49','/uploads/galleries/49-1.jpg','image','sm','2021-01-17 15:01:04','2021-01-17 15:01:04'),(296,293,'49','/uploads/galleries/49-2.jpg','image','xs','2021-01-17 15:01:04','2021-01-17 15:01:04'),(297,NULL,'43','/uploads/products/43-0.jpg','image','default','2021-01-17 15:11:34','2021-01-17 15:11:34'),(298,NULL,'49','/uploads/galleries/49-3.jpg','image','default','2021-01-17 15:11:34','2021-01-17 15:11:34'),(299,298,'49','/uploads/galleries/49-4.jpg','image','md','2021-01-17 15:11:34','2021-01-17 15:11:34'),(300,298,'49','/uploads/galleries/49-5.jpg','image','sm','2021-01-17 15:11:34','2021-01-17 15:11:34'),(301,298,'49','/uploads/galleries/49-6.jpg','image','xs','2021-01-17 15:11:34','2021-01-17 15:11:34');
/*!40000 ALTER TABLE `storages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag_product`
--

DROP TABLE IF EXISTS `tag_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag_product` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int unsigned DEFAULT NULL,
  `tag_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tag_product_product_id_foreign` (`product_id`),
  KEY `tag_product_tag_id_foreign` (`tag_id`),
  CONSTRAINT `tag_product_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL,
  CONSTRAINT `tag_product_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag_product`
--

LOCK TABLES `tag_product` WRITE;
/*!40000 ALTER TABLE `tag_product` DISABLE KEYS */;
INSERT INTO `tag_product` VALUES (3,NULL,2,NULL,NULL),(4,NULL,1,NULL,NULL),(5,NULL,1,NULL,NULL),(6,NULL,2,NULL,NULL),(7,NULL,3,NULL,NULL),(8,1,1,NULL,NULL),(9,1,3,NULL,NULL),(10,1,2,NULL,NULL);
/*!40000 ALTER TABLE `tag_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug_unique_tags` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,' plants','plants','2020-09-19 15:57:06','2020-09-19 15:57:06'),(2,'green','green','2020-09-19 15:57:13','2020-09-19 15:57:13'),(3,'cactus','cactus','2020-09-19 15:57:19','2020-09-19 15:57:19');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxes`
--

DROP TABLE IF EXISTS `taxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taxes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` double(8,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxes`
--

LOCK TABLES `taxes` WRITE;
/*!40000 ALTER TABLE `taxes` DISABLE KEYS */;
INSERT INTO `taxes` VALUES (1,'tva',0.20,'2020-10-19 09:39:51','2020-10-19 09:39:51');
/*!40000 ALTER TABLE `taxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type_payment`
--

DROP TABLE IF EXISTS `type_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type_payment` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug_unique_type_payment` (`slug`),
  KEY `type_payment_image_id_foreign` (`image_id`),
  CONSTRAINT `type_payment_image_id_foreign` FOREIGN KEY (`image_id`) REFERENCES `storages` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_payment`
--

LOCK TABLES `type_payment` WRITE;
/*!40000 ALTER TABLE `type_payment` DISABLE KEYS */;
INSERT INTO `type_payment` VALUES (1,'paypal','paypal',255,'2020-10-19 11:08:44','2020-10-19 11:08:44'),(2,'master card','master-card',256,'2020-10-19 11:13:51','2020-10-19 11:13:51'),(3,'visa','visa',257,'2020-10-19 11:15:37','2020-10-19 11:15:37'),(4,'espèce','espece',258,'2020-10-19 11:19:54','2020-10-19 11:19:54');
/*!40000 ALTER TABLE `type_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_verified_at` tinyint(1) NOT NULL DEFAULT '0',
  `password` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gender` enum('homme','femme') COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_token` longtext COLLATE utf8_unicode_ci,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `image_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `users_image_id_foreign` (`image_id`),
  CONSTRAINT `users_image_id_foreign` FOREIGN KEY (`image_id`) REFERENCES `storages` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'said','said','said.dev.info@gmail.com',0,'$2y$10$krUD/brX17lJe1dSAHXldu31rseNHW11mbmdCm9vMasPcoW/zv7Eu','homme','0670741714','TGWXDG5ayuyNUpl7jxLCqQ2jEVGMvc23x3M0hSBxSoclMrX8vrSzxXiYWTPM',0,291,'2020-09-19 15:53:41','2021-01-13 21:19:18');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'TUTO_lumen_vuejs_ecommerce'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-17 17:12:11

 SET FOREIGN_KEY_CHECKS = 1;