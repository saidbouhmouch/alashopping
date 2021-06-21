-- MySQL dump 10.13  Distrib 8.0.19, for macos10.15 (x86_64)
--
-- Host: localhost    Database: PROD_lumen_vuejs_ecommerce
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
INSERT INTO `addresses` VALUES (2,'marrakech','marrakech','40170','shipping',131,1,'2020-09-19 15:53:41','2020-09-19 15:53:41');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carriers`
--

LOCK TABLES `carriers` WRITE;
/*!40000 ALTER TABLE `carriers` DISABLE KEYS */;
INSERT INTO `carriers` VALUES (1,'Dhl','dhl',20.00,'Dhl',258,'2020-10-21 14:45:54','2021-01-17 17:09:35'),(2,'Fedex Express','fedex-express',0.00,'Fedex Express',259,'2020-10-23 15:13:37','2021-01-17 17:09:51');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_product`
--

LOCK TABLES `category_product` WRITE;
/*!40000 ALTER TABLE `category_product` DISABLE KEYS */;
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
INSERT INTO `countries` VALUES (1,'Andorra','AD',1,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(2,'United Arab Emirates','AE',2,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(3,'Afghanistan','AF',3,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(4,'Antigua And Barbuda','AG',4,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(5,'Anguilla','AI',5,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(6,'Albania','AL',6,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(7,'Armenia','AM',7,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(8,'Angola','AO',9,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(9,'Argentina','AR',11,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(10,'American Samoa','AS',12,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(11,'Austria','AT',13,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(12,'Australia','AU',14,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(13,'Aruba','AW',15,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(14,'Azerbaijan','AZ',17,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(15,'Bosnia And Herzegovina','BA',18,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(16,'Barbados','BB',19,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(17,'Bangladesh','BD',20,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(18,'Belgium','BE',21,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(19,'Burkina Faso','BF',22,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(20,'Bulgaria','BG',23,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(21,'Bahrain','BH',24,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(22,'Burundi','BI',25,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(23,'Benin','BJ',26,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(24,'Saint Barthelemy','BL',27,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(25,'Bermuda','BM',28,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(26,'Brunei','BN',29,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(27,'Bolivia','BO',30,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(28,'Brazil','BR',32,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(29,'Bahamas, The','BS',33,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(30,'Bhutan','BT',34,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(31,'Botswana','BW',36,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(32,'Belarus','BY',37,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(33,'Belize','BZ',38,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(34,'Canada','CA',39,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(35,'Cocos (Keeling) Islands','CC',40,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(36,'Congo (Kinshasa)','CD',41,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(37,'Central African Republic','CF',42,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(38,'Congo (Brazzaville)','CG',43,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(39,'Switzerland','CH',44,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(40,'C\\ud892\\udd60D\\u04c9voire','CI',45,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(41,'Cook Islands','CK',46,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(42,'Chile','CL',47,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(43,'Cameroon','CM',48,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(44,'China','CN',49,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(45,'Colombia','CO',50,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(46,'Costa Rica','CR',51,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(47,'Cuba','CU',52,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(48,'Cabo Verde','CV',53,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(49,'Cura\\u88af','CW',54,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(50,'Christmas Island','CX',55,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(51,'Cyprus','CY',56,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(52,'Czechia','CZ',57,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(53,'Germany','DE',58,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(54,'Djibouti','DJ',59,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(55,'Denmark','DK',60,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(56,'Dominica','DM',61,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(57,'Dominican Republic','DO',62,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(58,'Algeria','DZ',63,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(59,'Ecuador','EC',64,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(60,'Estonia','EE',65,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(61,'Egypt','EG',66,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(62,'Western Sahara','EH',67,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(63,'Eritrea','ER',69,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(64,'Spain','ES',70,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(65,'Ethiopia','ET',71,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(66,'Finland','FI',72,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(67,'Fiji','FJ',73,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(68,'Falkland Islands (Islas Malvinas)','FK',74,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(69,'Micronesia, Federated States Of','FM',75,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(70,'Faroe Islands','FO',76,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(71,'France','FR',77,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(72,'Gabon','GA',78,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(73,'United Kingdom','GB',79,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(74,'Grenada','GD',80,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(75,'Georgia','GE',81,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(76,'French Guiana','GF',82,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(77,'Guernsey','GG',83,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(78,'Ghana','GH',84,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(79,'Gibraltar','GI',85,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(80,'Greenland','GL',86,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(81,'Gambia, The','GM',87,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(82,'Guinea','GN',88,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(83,'Guadeloupe','GP',89,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(84,'Equatorial Guinea','GQ',90,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(85,'Greece','GR',91,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(86,'South Georgia And South Sandwich Islands','GS',92,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(87,'Guatemala','GT',93,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(88,'Guam','GU',94,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(89,'Guinea-Bissau','GW',95,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(90,'Guyana','GY',96,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(91,'Hong Kong','HK',97,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(92,'Honduras','HN',99,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(93,'Croatia','HR',100,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(94,'Haiti','HT',101,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(95,'Hungary','HU',102,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(96,'Indonesia','ID',103,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(97,'Ireland','IE',104,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(98,'Isle Of Man','IM',105,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(99,'India','IN',106,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(100,'British Indian Ocean Territory','IO',107,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(101,'Iraq','IQ',108,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(102,'Iran','IR',109,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(103,'Iceland','IS',110,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(104,'Italy','IT',111,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(105,'Jersey','JE',113,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(106,'Jamaica','JM',114,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(107,'Jordan','JO',115,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(108,'Japan','JP',116,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(109,'Kenya','KE',117,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(110,'Kyrgyzstan','KG',118,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(111,'Cambodia','KH',119,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(112,'Kiribati','KI',120,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(113,'Comoros','KM',121,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(114,'Saint Kitts And Nevis','KN',122,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(115,'Korea, North','KP',123,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(116,'Korea, South','KR',124,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(117,'Kuwait','KW',125,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(118,'Cayman Islands','KY',126,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(119,'Kazakhstan','KZ',127,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(120,'Laos','LA',128,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(121,'Lebanon','LB',129,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(122,'Saint Lucia','LC',130,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(123,'Liechtenstein','LI',131,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(124,'Sri Lanka','LK',132,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(125,'Liberia','LR',133,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(126,'Lesotho','LS',134,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(127,'Lithuania','LT',135,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(128,'Luxembourg','LU',136,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(129,'Latvia','LV',137,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(130,'Libya','LY',138,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(131,'Morocco','MA',139,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(132,'Monaco','MC',140,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(133,'Moldova','MD',141,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(134,'Montenegro','ME',142,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(135,'Saint Martin','MF',143,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(136,'Madagascar','MG',144,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(137,'Marshall Islands','MH',145,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(138,'Macedonia','MK',146,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(139,'Mali','ML',147,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(140,'Burma','MM',148,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(141,'Mongolia','MN',149,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(142,'Macau','MO',150,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(143,'Northern Mariana Islands','MP',151,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(144,'Martinique','MQ',152,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(145,'Mauritania','MR',153,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(146,'Montserrat','MS',154,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(147,'Malta','MT',155,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(148,'Mauritius','MU',156,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(149,'Maldives','MV',157,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(150,'Malawi','MW',158,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(151,'Mexico','MX',159,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(152,'Malaysia','MY',160,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(153,'Mozambique','MZ',161,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(154,'Namibia','NA',162,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(155,'New Caledonia','NC',163,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(156,'Niger','NE',164,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(157,'Norfolk Island','NF',165,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(158,'Nigeria','NG',166,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(159,'Nicaragua','NI',167,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(160,'Netherlands','NL',168,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(161,'Norway','NO',169,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(162,'Nepal','NP',170,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(163,'Nauru','NR',171,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(164,'Niue','NU',172,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(165,'New Zealand','NZ',173,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(166,'Oman','OM',174,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(167,'Panama','PA',175,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(168,'Peru','PE',176,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(169,'French Polynesia','PF',177,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(170,'Papua New Guinea','PG',178,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(171,'Philippines','PH',179,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(172,'Pakistan','PK',180,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(173,'Poland','PL',181,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(174,'Saint Pierre And Miquelon','PM',182,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(175,'Pitcairn Islands','PN',183,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(176,'Puerto Rico','PR',184,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(177,'Portugal','PT',186,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(178,'Palau','PW',187,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(179,'Paraguay','PY',188,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(180,'Qatar','QA',189,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(181,'Reunion','RE',190,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(182,'Romania','RO',191,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(183,'Serbia','RS',192,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(184,'Russia','RU',193,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(185,'Rwanda','RW',194,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(186,'Saudi Arabia','SA',195,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(187,'Solomon Islands','SB',196,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(188,'Seychelles','SC',197,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(189,'Sudan','SD',198,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(190,'Sweden','SE',199,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(191,'Singapore','SG',200,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(192,'Saint Helena, Ascension, And Tristan Da Cunha','SH',201,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(193,'Slovenia','SI',202,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(194,'Slovakia','SK',204,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(195,'Sierra Leone','SL',205,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(196,'San Marino','SM',206,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(197,'Senegal','SN',207,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(198,'Somalia','SO',208,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(199,'Suriname','SR',209,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(200,'South Sudan','SS',210,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(201,'Sao Tome And Principe','ST',211,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(202,'El Salvador','SV',212,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(203,'Sint Maarten','SX',213,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(204,'Syria','SY',214,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(205,'Swaziland','SZ',215,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(206,'Turks And Caicos Islands','TC',216,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(207,'Chad','TD',217,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(208,'French Southern And Antarctic Lands','TF',218,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(209,'Togo','TG',219,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(210,'Thailand','TH',220,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(211,'Tajikistan','TJ',221,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(212,'Tokelau','TK',222,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(213,'Timor-Leste','TL',223,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(214,'Turkmenistan','TM',224,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(215,'Tunisia','TN',225,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(216,'Tonga','TO',226,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(217,'Turkey','TR',227,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(218,'Trinidad And Tobago','TT',228,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(219,'Tuvalu','TV',229,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(220,'Taiwan','TW',230,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(221,'Tanzania','TZ',231,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(222,'Ukraine','UA',232,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(223,'Uganda','UG',233,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(224,'United States','US',235,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(225,'Uruguay','UY',236,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(226,'Uzbekistan','UZ',237,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(227,'Saint Vincent And The Grenadines','VC',239,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(228,'Venezuela','VE',240,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(229,'Virgin Islands, British','VG',241,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(230,'Virgin Islands, U.S.','VI',242,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(231,'Vietnam','VN',243,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(232,'Vanuatu','VU',244,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(233,'Wallis And Futuna','WF',245,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(234,'Samoa','WS',246,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(235,'Kosovo','XK',247,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(236,'Yemen','YE',248,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(237,'Mayotte','YT',249,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(238,'South Africa','ZA',250,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(239,'Zambia','ZM',251,'2021-01-17 16:38:21','2021-01-17 16:38:21'),(240,'Zimbabw','ZW',252,'2021-01-17 16:38:21','2021-01-17 16:38:21');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2020_06_06_203546_create_storages_table',1),(2,'2020_06_06_203622_create_users_table',1),(3,'2020_06_06_203642_create_countries_table',1),(4,'2020_06_06_203659_create_addresses_table',1),(5,'2020_06_06_203748_create_roles_table',1),(6,'2020_06_06_204002_create_role_user_table',1),(7,'2020_08_28_212024_create_categories_table',1),(8,'2020_09_03_203947_create_tags_table',1),(9,'2020_09_14_202531_create_taxes_table',1),(10,'2020_09_19_165633_create_currencies_table',1),(11,'2020_10_19_094528_create_type_payment_table',1),(12,'2020_10_20_152742_create_carriers_table',1),(13,'2020_10_25_122531_create_products_table',1),(14,'2020_10_25_133542_create_category_product_table',1),(15,'2020_10_25_134037_create_tag_product_table',1),(16,'2020_11_04_222350_create_galleries_table',1);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_user`
--

LOCK TABLES `role_user` WRITE;
/*!40000 ALTER TABLE `role_user` DISABLE KEYS */;
INSERT INTO `role_user` VALUES (2,1,1,NULL,NULL);
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
INSERT INTO `roles` VALUES (1,'admin','api','2021-01-17 16:38:20','2021-01-17 16:38:20'),(2,'client','api','2021-01-17 16:38:20','2021-01-17 16:38:20');
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
) ENGINE=InnoDB AUTO_INCREMENT=260 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storages`
--

LOCK TABLES `storages` WRITE;
/*!40000 ALTER TABLE `storages` DISABLE KEYS */;
INSERT INTO `storages` VALUES (1,NULL,'ad','img/flag/ad.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(2,NULL,'ae','img/flag/ae.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(3,NULL,'af','img/flag/af.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(4,NULL,'ag','img/flag/ag.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(5,NULL,'ai','img/flag/ai.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(6,NULL,'al','img/flag/al.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(7,NULL,'am','img/flag/am.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(8,NULL,'an','img/flag/an.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(9,NULL,'ao','img/flag/ao.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(10,NULL,'aq','img/flag/aq.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(11,NULL,'ar','img/flag/ar.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(12,NULL,'as','img/flag/as.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(13,NULL,'at','img/flag/at.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(14,NULL,'au','img/flag/au.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(15,NULL,'aw','img/flag/aw.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(16,NULL,'ax','img/flag/ax.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(17,NULL,'az','img/flag/az.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(18,NULL,'ba','img/flag/ba.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(19,NULL,'bb','img/flag/bb.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(20,NULL,'bd','img/flag/bd.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(21,NULL,'be','img/flag/be.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(22,NULL,'bf','img/flag/bf.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(23,NULL,'bg','img/flag/bg.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(24,NULL,'bh','img/flag/bh.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(25,NULL,'bi','img/flag/bi.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(26,NULL,'bj','img/flag/bj.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(27,NULL,'bl','img/flag/bl.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(28,NULL,'bm','img/flag/bm.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(29,NULL,'bn','img/flag/bn.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(30,NULL,'bo','img/flag/bo.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(31,NULL,'bq','img/flag/bq.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(32,NULL,'br','img/flag/br.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(33,NULL,'bs','img/flag/bs.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(34,NULL,'bt','img/flag/bt.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(35,NULL,'bv','img/flag/bv.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(36,NULL,'bw','img/flag/bw.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(37,NULL,'by','img/flag/by.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(38,NULL,'bz','img/flag/bz.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(39,NULL,'ca','img/flag/ca.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(40,NULL,'cc','img/flag/cc.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(41,NULL,'cd','img/flag/cd.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(42,NULL,'cf','img/flag/cf.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(43,NULL,'cg','img/flag/cg.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(44,NULL,'ch','img/flag/ch.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(45,NULL,'ci','img/flag/ci.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(46,NULL,'ck','img/flag/ck.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(47,NULL,'cl','img/flag/cl.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(48,NULL,'cm','img/flag/cm.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(49,NULL,'cn','img/flag/cn.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(50,NULL,'co','img/flag/co.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(51,NULL,'cr','img/flag/cr.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(52,NULL,'cu','img/flag/cu.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(53,NULL,'cv','img/flag/cv.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(54,NULL,'cw','img/flag/cw.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(55,NULL,'cx','img/flag/cx.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(56,NULL,'cy','img/flag/cy.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(57,NULL,'cz','img/flag/cz.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(58,NULL,'de','img/flag/de.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(59,NULL,'dj','img/flag/dj.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(60,NULL,'dk','img/flag/dk.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(61,NULL,'dm','img/flag/dm.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(62,NULL,'do','img/flag/do.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(63,NULL,'dz','img/flag/dz.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(64,NULL,'ec','img/flag/ec.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(65,NULL,'ee','img/flag/ee.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(66,NULL,'eg','img/flag/eg.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(67,NULL,'eh','img/flag/eh.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(68,NULL,'en','img/flag/en.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(69,NULL,'er','img/flag/er.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(70,NULL,'es','img/flag/es.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(71,NULL,'et','img/flag/et.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(72,NULL,'fi','img/flag/fi.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(73,NULL,'fj','img/flag/fj.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(74,NULL,'fk','img/flag/fk.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(75,NULL,'fm','img/flag/fm.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(76,NULL,'fo','img/flag/fo.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(77,NULL,'fr','img/flag/fr.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(78,NULL,'ga','img/flag/ga.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(79,NULL,'gb','img/flag/gb.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(80,NULL,'gd','img/flag/gd.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(81,NULL,'ge','img/flag/ge.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(82,NULL,'gf','img/flag/gf.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(83,NULL,'gg','img/flag/gg.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(84,NULL,'gh','img/flag/gh.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(85,NULL,'gi','img/flag/gi.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(86,NULL,'gl','img/flag/gl.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(87,NULL,'gm','img/flag/gm.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(88,NULL,'gn','img/flag/gn.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(89,NULL,'gp','img/flag/gp.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(90,NULL,'gq','img/flag/gq.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(91,NULL,'gr','img/flag/gr.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(92,NULL,'gs','img/flag/gs.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(93,NULL,'gt','img/flag/gt.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(94,NULL,'gu','img/flag/gu.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(95,NULL,'gw','img/flag/gw.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(96,NULL,'gy','img/flag/gy.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(97,NULL,'hk','img/flag/hk.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(98,NULL,'hm','img/flag/hm.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(99,NULL,'hn','img/flag/hn.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(100,NULL,'hr','img/flag/hr.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(101,NULL,'ht','img/flag/ht.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(102,NULL,'hu','img/flag/hu.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(103,NULL,'id','img/flag/id.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(104,NULL,'ie','img/flag/ie.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(105,NULL,'im','img/flag/im.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(106,NULL,'in','img/flag/in.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(107,NULL,'io','img/flag/io.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(108,NULL,'iq','img/flag/iq.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(109,NULL,'ir','img/flag/ir.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(110,NULL,'is','img/flag/is.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(111,NULL,'it','img/flag/it.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(112,NULL,'ja','img/flag/ja.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(113,NULL,'je','img/flag/je.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(114,NULL,'jm','img/flag/jm.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(115,NULL,'jo','img/flag/jo.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(116,NULL,'jp','img/flag/jp.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(117,NULL,'ke','img/flag/ke.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(118,NULL,'kg','img/flag/kg.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(119,NULL,'kh','img/flag/kh.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(120,NULL,'ki','img/flag/ki.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(121,NULL,'km','img/flag/km.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(122,NULL,'kn','img/flag/kn.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(123,NULL,'kp','img/flag/kp.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(124,NULL,'kr','img/flag/kr.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(125,NULL,'kw','img/flag/kw.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(126,NULL,'ky','img/flag/ky.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(127,NULL,'kz','img/flag/kz.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(128,NULL,'la','img/flag/la.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(129,NULL,'lb','img/flag/lb.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(130,NULL,'lc','img/flag/lc.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(131,NULL,'li','img/flag/li.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(132,NULL,'lk','img/flag/lk.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(133,NULL,'lr','img/flag/lr.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(134,NULL,'ls','img/flag/ls.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(135,NULL,'lt','img/flag/lt.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(136,NULL,'lu','img/flag/lu.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(137,NULL,'lv','img/flag/lv.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(138,NULL,'ly','img/flag/ly.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(139,NULL,'ma','img/flag/ma.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(140,NULL,'mc','img/flag/mc.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(141,NULL,'md','img/flag/md.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(142,NULL,'me','img/flag/me.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(143,NULL,'mf','img/flag/mf.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(144,NULL,'mg','img/flag/mg.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(145,NULL,'mh','img/flag/mh.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(146,NULL,'mk','img/flag/mk.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(147,NULL,'ml','img/flag/ml.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(148,NULL,'mm','img/flag/mm.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(149,NULL,'mn','img/flag/mn.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(150,NULL,'mo','img/flag/mo.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(151,NULL,'mp','img/flag/mp.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(152,NULL,'mq','img/flag/mq.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(153,NULL,'mr','img/flag/mr.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(154,NULL,'ms','img/flag/ms.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(155,NULL,'mt','img/flag/mt.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(156,NULL,'mu','img/flag/mu.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(157,NULL,'mv','img/flag/mv.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(158,NULL,'mw','img/flag/mw.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(159,NULL,'mx','img/flag/mx.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(160,NULL,'my','img/flag/my.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(161,NULL,'mz','img/flag/mz.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(162,NULL,'na','img/flag/na.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(163,NULL,'nc','img/flag/nc.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(164,NULL,'ne','img/flag/ne.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(165,NULL,'nf','img/flag/nf.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(166,NULL,'ng','img/flag/ng.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(167,NULL,'ni','img/flag/ni.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(168,NULL,'nl','img/flag/nl.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(169,NULL,'no','img/flag/no.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(170,NULL,'np','img/flag/np.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(171,NULL,'nr','img/flag/nr.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(172,NULL,'nu','img/flag/nu.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(173,NULL,'nz','img/flag/nz.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(174,NULL,'om','img/flag/om.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(175,NULL,'pa','img/flag/pa.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(176,NULL,'pe','img/flag/pe.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(177,NULL,'pf','img/flag/pf.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(178,NULL,'pg','img/flag/pg.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(179,NULL,'ph','img/flag/ph.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(180,NULL,'pk','img/flag/pk.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(181,NULL,'pl','img/flag/pl.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(182,NULL,'pm','img/flag/pm.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(183,NULL,'pn','img/flag/pn.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(184,NULL,'pr','img/flag/pr.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(185,NULL,'ps','img/flag/ps.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(186,NULL,'pt','img/flag/pt.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(187,NULL,'pw','img/flag/pw.png','image','xs','2021-01-17 16:38:20','2021-01-17 16:38:20'),(188,NULL,'py','img/flag/py.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(189,NULL,'qa','img/flag/qa.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(190,NULL,'re','img/flag/re.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(191,NULL,'ro','img/flag/ro.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(192,NULL,'rs','img/flag/rs.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(193,NULL,'ru','img/flag/ru.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(194,NULL,'rw','img/flag/rw.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(195,NULL,'sa','img/flag/sa.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(196,NULL,'sb','img/flag/sb.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(197,NULL,'sc','img/flag/sc.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(198,NULL,'sd','img/flag/sd.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(199,NULL,'se','img/flag/se.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(200,NULL,'sg','img/flag/sg.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(201,NULL,'sh','img/flag/sh.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(202,NULL,'si','img/flag/si.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(203,NULL,'sj','img/flag/sj.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(204,NULL,'sk','img/flag/sk.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(205,NULL,'sl','img/flag/sl.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(206,NULL,'sm','img/flag/sm.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(207,NULL,'sn','img/flag/sn.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(208,NULL,'so','img/flag/so.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(209,NULL,'sr','img/flag/sr.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(210,NULL,'ss','img/flag/ss.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(211,NULL,'st','img/flag/st.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(212,NULL,'sv','img/flag/sv.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(213,NULL,'sx','img/flag/sx.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(214,NULL,'sy','img/flag/sy.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(215,NULL,'sz','img/flag/sz.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(216,NULL,'tc','img/flag/tc.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(217,NULL,'td','img/flag/td.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(218,NULL,'tf','img/flag/tf.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(219,NULL,'tg','img/flag/tg.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(220,NULL,'th','img/flag/th.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(221,NULL,'tj','img/flag/tj.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(222,NULL,'tk','img/flag/tk.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(223,NULL,'tl','img/flag/tl.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(224,NULL,'tm','img/flag/tm.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(225,NULL,'tn','img/flag/tn.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(226,NULL,'to','img/flag/to.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(227,NULL,'tr','img/flag/tr.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(228,NULL,'tt','img/flag/tt.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(229,NULL,'tv','img/flag/tv.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(230,NULL,'tw','img/flag/tw.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(231,NULL,'tz','img/flag/tz.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(232,NULL,'ua','img/flag/ua.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(233,NULL,'ug','img/flag/ug.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(234,NULL,'um','img/flag/um.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(235,NULL,'us','img/flag/us.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(236,NULL,'uy','img/flag/uy.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(237,NULL,'uz','img/flag/uz.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(238,NULL,'va','img/flag/va.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(239,NULL,'vc','img/flag/vc.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(240,NULL,'ve','img/flag/ve.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(241,NULL,'vg','img/flag/vg.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(242,NULL,'vi','img/flag/vi.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(243,NULL,'vn','img/flag/vn.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(244,NULL,'vu','img/flag/vu.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(245,NULL,'wf','img/flag/wf.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(246,NULL,'ws','img/flag/ws.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(247,NULL,'xk','img/flag/xk.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(248,NULL,'ye','img/flag/ye.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(249,NULL,'yt','img/flag/yt.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(250,NULL,'za','img/flag/za.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(251,NULL,'zm','img/flag/zm.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(252,NULL,'zw','img/flag/zw.png','image','xs','2021-01-17 16:38:21','2021-01-17 16:38:21'),(253,NULL,'said','/uploads/users/said.jpg','image','default','2021-01-13 20:19:18','2021-01-13 20:19:18'),(254,NULL,'especepng','/uploads/type-payments/especepng.jpg','image','default','2021-01-17 17:05:56','2021-01-17 17:05:56'),(255,NULL,'master-cardpng','/uploads/type-payments/master-cardpng.jpg','image','default','2021-01-17 17:06:11','2021-01-17 17:06:11'),(256,NULL,'paypalpng','/uploads/type-payments/paypalpng.jpg','image','default','2021-01-17 17:06:32','2021-01-17 17:06:32'),(257,NULL,'visa','/uploads/type-payments/visa.jpg','image','default','2021-01-17 17:06:51','2021-01-17 17:06:51'),(258,NULL,'dhl','/uploads/carriers/dhl.jpg','image','default','2021-01-17 17:09:35','2021-01-17 17:09:35'),(259,NULL,'fedex-express','/uploads/carriers/fedex-express.jpg','image','default','2021-01-17 17:09:51','2021-01-17 17:09:51');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag_product`
--

LOCK TABLES `tag_product` WRITE;
/*!40000 ALTER TABLE `tag_product` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_payment`
--

LOCK TABLES `type_payment` WRITE;
/*!40000 ALTER TABLE `type_payment` DISABLE KEYS */;
INSERT INTO `type_payment` VALUES (1,'paypal','paypal',256,'2020-10-19 11:08:44','2021-01-17 17:06:32'),(2,'master card','master-card',255,'2020-10-19 11:13:51','2021-01-17 17:06:11'),(3,'visa','visa',257,'2020-10-19 11:15:37','2021-01-17 17:06:51'),(4,'espèce','espece',254,'2020-10-19 11:19:54','2021-01-17 17:05:56');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'said','said','said.dev.info@gmail.com',0,'$2y$10$krUD/brX17lJe1dSAHXldu31rseNHW11mbmdCm9vMasPcoW/zv7Eu','homme','0670741714','TGWXDG5ayuyNUpl7jxLCqQ2jEVGMvc23x3M0hSBxSoclMrX8vrSzxXiYWTPM',0,253,'2020-09-19 14:53:41','2021-01-13 20:19:18');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-17 18:12:08
