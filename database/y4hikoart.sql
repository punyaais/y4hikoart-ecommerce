-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: ecommerce-new
-- ------------------------------------------------------
-- Server version	8.0.30

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
-- Table structure for table `app_settings`
--

DROP TABLE IF EXISTS `app_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `total_slots` int unsigned NOT NULL,
  `remaining_slots` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_settings`
--

LOCK TABLES `app_settings` WRITE;
/*!40000 ALTER TABLE `app_settings` DISABLE KEYS */;
INSERT INTO `app_settings` VALUES (2,20,15,'2026-05-14 22:20:17','2026-05-15 01:15:08');
/*!40000 ALTER TABLE `app_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `background_options`
--

DROP TABLE IF EXISTS `background_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `background_options` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `background_options`
--

LOCK TABLES `background_options` WRITE;
/*!40000 ALTER TABLE `background_options` DISABLE KEYS */;
INSERT INTO `background_options` VALUES (1,'none',0,NULL,NULL),(2,'simple',20000,NULL,NULL),(3,'detailed',50000,NULL,NULL);
/*!40000 ALTER TABLE `background_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
INSERT INTO `cache` VALUES ('laravel-cache-livewire-rate-limiter:16d36dff9abd246c67dfac3e63b993a169af77e6','i:1;',1778831661),('laravel-cache-livewire-rate-limiter:16d36dff9abd246c67dfac3e63b993a169af77e6:timer','i:1778831661;',1778831661);
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_items`
--

DROP TABLE IF EXISTS `cart_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `cart_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_items_cart_id_foreign` (`cart_id`),
  KEY `cart_items_product_id_foreign` (`product_id`),
  CONSTRAINT `cart_items_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_items`
--

LOCK TABLES `cart_items` WRITE;
/*!40000 ALTER TABLE `cart_items` DISABLE KEYS */;
INSERT INTO `cart_items` VALUES (16,2,11,2,'2026-05-14 09:20:13','2026-05-14 09:23:31'),(17,2,6,1,'2026-05-14 09:21:57','2026-05-14 09:21:57'),(35,4,11,1,'2026-05-15 01:12:57','2026-05-15 01:12:57');
/*!40000 ALTER TABLE `cart_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carts_user_id_foreign` (`user_id`),
  CONSTRAINT `carts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
INSERT INTO `carts` VALUES (2,1,'2026-05-03 03:22:26','2026-05-03 03:22:26'),(3,3,'2026-05-14 09:30:06','2026-05-14 09:30:06'),(4,2,'2026-05-14 09:30:06','2026-05-14 09:30:06');
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'CUSTOM',NULL,NULL),(2,'YCH',NULL,NULL);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2026_04_09_011142_create_products_table',2),(5,'2026_04_09_014523_create_categories_table',3),(6,'2026_04_25_101351_create_orders_table',4),(7,'2026_04_25_101418_create_order_characters_table',4),(8,'2026_04_25_101426_create_order_character_images_table',4),(9,'2026_04_25_112543_create_add_customer_to_orders_tables_table',5),(10,'2026_04_25_143255_create_add_character_required_to_products_tables_table',6),(11,'2026_04_27_211549_create_background_options_table',7),(12,'2026_04_27_212819_add_background_id_to_order_characters',8),(13,'2026_04_27_214007_create_payments_table',9),(14,'2026_05_03_100220_create_carts_table',10),(15,'2026_05_03_100228_create_cart_items_table',10),(16,'2026_05_06_141908_add_external_id_to_payments_table',11),(17,'2026_05_07_034259_add_username_to_users_table',12),(18,'2026_05_07_034459_create_personal_access_tokens_table',13),(19,'2026_05_09_132106_create_app_settings_table',14),(20,'2026_05_13_001356_add_status_to_orders_table',15),(21,'2026_05_13_060645_create_testimonials_table',16),(22,'2026_05_14_171445_add_quantity_to_orders_table',17),(23,'2026_05_15_042455_make_username_nullable_on_users_table',18);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_character_images`
--

DROP TABLE IF EXISTS `order_character_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_character_images` (
  `image_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `character_id` bigint unsigned NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`image_id`),
  KEY `order_character_images_character_id_foreign` (`character_id`),
  CONSTRAINT `order_character_images_character_id_foreign` FOREIGN KEY (`character_id`) REFERENCES `order_characters` (`character_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_character_images`
--

LOCK TABLES `order_character_images` WRITE;
/*!40000 ALTER TABLE `order_character_images` DISABLE KEYS */;
INSERT INTO `order_character_images` VALUES (1,1,'https://example.com/image1.jpg'),(2,1,'https://example.com/image2.jpg'),(3,2,'https://example.com/image3.jpg'),(4,5,'/storage/characters/xOMeBCAhPAmDnJ3ohza83Y2RlYDfXJSHJ1bNc0mU.png'),(5,6,'/storage/characters/yN7BqfAVFYmhAsZJSV50sr3D1h5HY71Yx9tFhKot.png'),(6,7,'/storage/characters/VCX98T4bXid9LEPCwd0I0l18ACV1RfdPmc8dB45Y.png'),(7,8,'/storage/characters/EEuxEmtjkrAcXkoYtE1yKAwGCFr1MF4vsXZldBsx.png'),(8,9,'/storage/characters/J6SrEs8EabqzHirPGojZnxQR5wAVP22Qv1aoG7xY.png'),(9,10,'/storage/characters/jLvV8B8o3lCir4JDxHmsfVzMO0imqSly2oAkMs7E.png'),(10,11,'/storage/characters/ftTmIFYhgthHmFkwhmotLkNbbMAAVGExc8gHUaCc.png'),(11,12,'/storage/characters/ubuWQCHX666bKb5ZtyqgCq1bCH5POqbizzvB70rH.png'),(12,13,'/storage/characters/Bpzx4lSGoU9vjsN5DXqcYecCqN09baWsqhnmlV0s.png'),(13,14,'/storage/characters/lypiDCwj0ZMsEfsGMOj5InzvYjXskwrnuMm1PU1l.png'),(14,15,'/storage/characters/55NszWQc94FaOtV2jIcq4gkokrVuPLRATK8qruUF.png'),(15,16,'/storage/characters/pU9wrwb6Brqubqx3AaScGFJWHiXe6pp9kTF90hwA.png'),(16,17,'/storage/characters/CgUy0M4duoxC0kba26jJMSYPypfkLKoFyJfPG3W0.png'),(17,18,'/storage/characters/xF9p1w40BRetmkMfbvKsGVRmbeJgX4LQbn80uOEE.png'),(18,19,'/storage/characters/fnJt8XFMS6fYff12ls009FbWgUbzMQIHV2tSovkQ.png'),(19,20,'/storage/characters/cLnj32VE50ImiLkYpbLvPZpNHHp27818V7PjaFVA.png'),(20,21,'/storage/characters/dXoR018Bm8zl3cVHCSRbG04Zts9s4Fp3GePA8ve2.png'),(21,22,'/storage/characters/EX40c0uFYhnmKoXaHvTAKmHKZzvpISMKAl48aHI3.png'),(22,23,'/storage/characters/hUG2OC2iQUBkgLNRLYc34tEZWJfrMEsMf1qsk4f6.png'),(23,24,'/storage/characters/foEuGqUkQyGIAofrafpWjediUnfUZKyzefprqRIR.png'),(24,25,'/storage/characters/dTOqY6qoTFKunkAs2Vu3nMP3y7a4wBDAs4wZ2O03.png'),(25,26,'/storage/characters/YjpbHUoiUmHY4ykMLwRz9cDugmetEkzRkRhyEGH7.png'),(26,27,'/storage/characters/B6SGu9rtJAwjaJ3VQbgvrLdM7EzVFdJwhk2vn3Gn.png'),(27,28,'/storage/characters/jmCxAPlEIVeSLQxWdqZ6GcNDgBi7B9CmPOs5gAKG.png'),(28,29,'/storage/characters/0rmNPug9poO9vYCPBFVJjEjSEYUworCAKzHyvdZU.png'),(29,30,'/storage/characters/mrOBQb5rfSL0lToo1R9iPPUd1QMPG3XAHiSUvt1F.png'),(30,31,'/storage/characters/sJ0JIW5OEljzy1prMKHoocmuc18UCecdlAJo7731.png'),(31,32,'/storage/characters/FVg4sMy0JzaJ1BWJPEJ6f6IjoSS2IM2DtmDpV3A3.png'),(32,33,'/storage/characters/F1bX7jgUSJOJ2AUajwo79HhhM9doEezqz58BG0yG.png'),(33,34,'/storage/characters/nzkaxY4aEs9ACS1xeQMxRoJgcRjVlsTkn1zAZYTU.png'),(34,35,'/storage/characters/JwvylddpALZvprUkQDHS4rSXaW0xRP8i3rt1hU4d.png'),(35,36,'/storage/characters/Ja4CekrRRwhUunlU6Ui8UvHKgexEaRPhaR90r9qN.png'),(36,37,'/storage/characters/Y3Xv4039LQPFsDrjznLn96RniJG2sJKllVJTg37v.png'),(37,38,'/storage/characters/XuGu5xN5xPl1ULB8xoYbg3VQRFOx52tKpZDwMEU0.png'),(38,39,'/storage/characters/yZ1sSEhTuKt7VP1ewy35yTpuZPYXRDLHswY7ekz7.png'),(39,40,'/storage/characters/5BYhYDNa4T9tAePKQRTe2EK806MoOmTUnDIb2mNa.png'),(40,41,'/storage/characters/d6MHbEUCYInQQK5k99Ua5Jy5JVZnxBZk7VTcNJEA.png'),(41,42,'/storage/characters/sQUki0oipZo61OaamxdS3tLSWnefHdHmFHcrwrik.png'),(42,43,'/storage/characters/VaKLoVqPaHXa2NPM3rGvY05uSPaUDZwuLpBUJ8Nc.png'),(43,44,'/storage/characters/JQDDzirLs0TzSpEEu7SiaqnmhFftNdOUZApafjuR.png'),(44,45,'/storage/characters/TGBHCtWiDgoKRL02QcvMhbo3KmaBoEyXJY8tPZAH.png'),(45,46,'/storage/characters/rIEyi9R6i7PWaDG7iF1mcd3k9fU0mzMea2o1PCrZ.png'),(46,47,'/storage/characters/ECrBrHiXrHat8OoHG0DlNlDfGe9NJvfeyiCB7Cnd.png'),(47,48,'/storage/characters/ZkXh1FBUsymRfJGfMnjelWyGZEiug61j4RWfIe0L.png'),(48,49,'/storage/characters/FEsX4BURBLM52kAJxm7nFMSXAJ9SmnUozRfEtknw.png'),(49,50,'/storage/characters/i6LIDFRdGxV69hRdbr7No2KEF3ffyxXara0ebteW.png'),(50,51,'/storage/characters/x2KROqsigeP2T5H8Q1qOwavEAcqfdasfJwxx8kIp.png'),(51,52,'/storage/characters/ecDaaRtdttsLAn5SlmZ2JiJG2s3xAzEPuafvfy2A.png'),(52,53,'/storage/characters/hRebwCGr8Z2UjDPGvJQf8ntKmngmNKnAy5nf8zT5.png'),(53,54,'/storage/characters/i0XXIS4UuW1XhNH35OjaW3xY5dP6SrxQveBYxXg7.png'),(54,55,'/storage/characters/rtHh100L6VBGzbh9m6wFYhfrdweSJAcfnFH2SkxZ.png'),(55,56,'/storage/characters/yQi0jGKBKOUP1KG9WtV1qP6LegrYfg3ITRQlfFS5.png'),(56,57,'/storage/characters/9KCRhgoFJQyCMeK2vdysGuJ3bS2RYiHLdhCNYyCZ.png'),(57,58,'/storage/characters/eLnZZSAQAsBoXUFzsZoJf7DecDXcfb4DDHHVBE44.png'),(58,59,'/storage/characters/K9oAz9ggwzz2wDWDsKSv7wKCjmQN10vC58kADjhs.png'),(59,60,'/storage/characters/1z1kFBfm33bC90ylJ3oyJ64UegW81MxOdwyGhhXx.png'),(60,61,'/storage/characters/0wxAKHtAKVKxxosJxDcKD6lYg6nDeqEpKtQTivHT.png'),(61,62,'/storage/characters/sU0nNKIgj8LTK6TxcDv0mFcPUpZ2psQ7px6vQCvB.png'),(62,63,'/storage/characters/I9qfZX6XXp0yKDCBCauceLWHGUHqemNdwxc6X1Jl.png'),(63,64,'/storage/characters/53WKqMD8g5BrcOhFv9cO4FHPZBUwNNyIQoNl9yYH.png'),(64,65,'/storage/characters/dWzg9jptKnVhprrOIkGIC2NQsmqX3T3wWqIC7Pwo.png'),(65,66,'/storage/characters/cYrjAUpaKcCcoKgM9BKglwb5MS9esHzBhGlf7FXu.png'),(66,67,'/storage/characters/RcjhqgsBrie7HpcNEpKab9h0puGbT1wMAA8bfsW3.png'),(67,68,'/storage/characters/89sMSjeCBCvQKaJ2oMrP9VP0noEPmFLqJWNoMZoJ.png'),(68,69,'/storage/characters/pxc4a9iQq4GVLyf5AWzuE5yEJVxpZGUaOevszRIV.png'),(69,70,'/storage/characters/GFArZReMPApP2H34Q86rFiie8iMSXrVOj7zffA3k.png'),(70,71,'/storage/characters/Mjzo2KUrlAK51RsY3tesioSBzUIyhqqWdEcDefzQ.png'),(71,72,'/storage/characters/MJ4XwfQQauLu0KgIxrYLuyVPnWVNlIs8cghvZvAV.png'),(72,73,'/storage/characters/NwnILAR8CFWSp31PxYyS7O3bUoLNxv0JsATfYyMt.png'),(73,74,'/storage/characters/HLNUxqtXPUXA9acXQoVQ195uK4WcQITk24Oji53q.png'),(74,75,'/storage/characters/ZHCTWCFa4Da06TfFsQlVLwPgtWa0VEF2hMCtpByW.png'),(75,76,'/storage/characters/t71Ofdn6SA8Ap9X4rDcJBPhtT7DjvBmFMseNGBjU.png'),(76,77,'/storage/characters/HkynQJF0zEw0RLZ0VwLp9iJO6qToCIWB7UaVxcuQ.png'),(77,78,'/storage/characters/XOIcy5eNmVoxZfWHsvekilcDepVWasL1ShgWeRWO.png'),(78,79,'/storage/characters/OJher8OgugTE3tYSaqmPhmMPnXtB1khDwCF7XTnF.png'),(79,80,'/storage/characters/HDDMmdAtiZRovE2I29znkMmjgJGSnssTIoQOHixX.png'),(80,81,'/storage/characters/2hf9W2zoAnySzvZ7uRQEXU8kxUJhAEHTMrvjFDNN.png'),(81,82,'/storage/characters/3i5yu7fRo2Nsbw82T55BmIoN5cr2voIC8m4hHibK.png'),(82,83,'/storage/characters/fqZVlI3ojUpX1zOVd7rfzbYZOc5fJ6BvbhdIdtGX.png'),(83,84,'/storage/characters/sbLbxPKTkwsEeKFxBVU0AvNEJ0AC1oeCHOMqhiza.png'),(84,85,'/storage/characters/tqCRogTWQN6xstZrkoN8iDDHZrRvnvEypWz0MRua.png'),(85,86,'/storage/characters/h6Nzq3A0046vxBr7QmsR1ggpiqRkqutFfcKSszms.png'),(86,87,'/storage/characters/sXxTaTIL46pRq6iBg7QAJfXveHhu97RpPmaNU1T4.png'),(87,88,'/storage/characters/4sxJf1njH3l6BdsOtf1nJWfvhxvn5zg5c8Xvdf9o.png'),(88,89,'/storage/characters/UItGwOlSQVwgl0sD3F1qntLYinhrZtkCb6MOICih.png'),(89,89,'/storage/characters/21VyliNqkRZmyAScmjhTqR7b0k0gySoi040nb3ii.png'),(90,90,'/storage/characters/1b5suL8bTQ6cIrwVwLzsLAbE8X8LvZyk7FL6QYLU.png'),(91,90,'/storage/characters/M0UiFEIxnboyxantNZ0wjGB0Ubtxwqx4qNklBTy0.png'),(92,91,'/storage/characters/z3T31DjpfwMk8W04HKBXAY6w8I886sd7SNY4t6ni.png'),(93,92,'/storage/characters/wNUQtD6UD1w8W1IAuIBVNDG2DIYBf7EhFjMFMy96.png'),(94,93,'/storage/characters/weCR3XARNGtGhlApCWKXcZAfzDgVKamBqE0Ukpq4.png'),(95,94,'/storage/characters/RjOZfydt1yC27Yw3LzROa0NQm5q33pTbTfD1Khcj.png'),(96,95,'/storage/characters/KhNg2tLarRDQtztzF2QvJMNXUtZPzF92uIUtI1ls.png'),(97,96,'/storage/characters/CnlxwjelcPG78sL8y7GiBsZi4zn9aF3SYSWX2Foi.png'),(98,97,'/storage/characters/1IKKkYqPDNnl80D3MgTuvHTGRn2G18XfzdgMJh14.png'),(99,98,'/storage/characters/z1QlEITjOxTOsDbSsunqLzurwWOVO5O18E8nSSZk.png'),(100,99,'/storage/characters/NDOAqNwhB8EN695x2rVbErNEt8wOw299pWQu3vsP.png'),(101,100,'/storage/characters/J2pC2E6zZx4aqrv4n7LkRXrlYHRscBYrCoTdNXlj.png'),(102,101,'/storage/characters/zJaqtvb085pd2Oixs7tqgZlM3ZKmm3puc060UMJM.png'),(103,102,'/storage/characters/8DoIPchbWVNnlnGIKfEYqgYIqwMeULXjamRTEOek.png'),(104,103,'/storage/characters/V5sp029QURQ4mtme90QihYjjXaUvkAzYsEECttiJ.png'),(105,104,'/storage/characters/wzf2YUSaZC2UVtkqnNwx9oLB5rFbwYPo3422MA3k.png'),(106,105,'/storage/characters/V7sVTUt1Ti7Jr5KcKambIYFfwFR0qkOaxPGZSTWS.png'),(107,106,'/storage/characters/SRumHcYkrab1RaMneNFKvR0N7hflJKXPzRTyCnXz.png'),(108,107,'/storage/characters/Qfv9zAkcHiv2kRPCxiOR6gTArfTdstHvgMHHGuSP.png'),(109,108,'/storage/characters/3ZWPf8elleqyCVQxVkJCDKGUmkO2bj74x4m5ilVK.png'),(110,109,'/storage/characters/qV6TpeK0rmEpQryggF9wyOjIz6539bkiqyUfQEo0.png'),(111,110,'/storage/characters/t2Dfrcr12z5WOzdyE2wKMdRt3j7xVnluYRIAeyo7.png'),(112,111,'/storage/characters/JDImS7JiCL3FxVabDZaLzVxOd5BJhJchssWGHO3j.png'),(113,112,'/storage/characters/EcflUOfNnFqWXclNKlwRLQgLPS3nukP3EqSMjJUM.png'),(114,113,'/storage/characters/CMtKtDeXfeLRhMnKSNXlPHZmGi6Z85d6EnwlSyPS.png'),(115,114,'/storage/characters/PSgYnfvGYGb6uF417JD8rQuEgm8vmfuOoGWpCw38.png'),(116,115,'/storage/characters/euMcppVfxJRUQlNioPDa2DOmcDcILvjH2F6b9vDZ.png'),(117,116,'/storage/characters/fNLstDeI0wTdKfflWmNLFFWASLB4DHN0AgWpuhc6.png'),(118,117,'/storage/characters/iavLy7uzY3yQuMF3gpvt5ptrbazN26Ezvj60whyz.png'),(119,118,'/storage/characters/5E5gXd2cl9KlgcPBiCYS9xNytSb37IwmclFo8tsu.png'),(120,119,'/storage/characters/0s5vwDwUiaNIeNkHAIfmkd9ihGXaPdsvxmxl4tSu.png'),(121,120,'/storage/characters/IkKnRIML6gNnrl0uBTjDGXCWatlN9iW30NcH5eZL.png'),(122,121,'/storage/characters/ejHpPPe6HajZ1RbOekh2P8OzNm0LN1THr0GObW9c.png'),(123,121,'/storage/characters/3IOMbHL7HZZylK2wn1H7hkwo0l6V9UGgvIdhc0nj.png'),(124,121,'/storage/characters/zjgthK61XCOJdPoB8qvn5EgvOPxhwZg2nYUIVg7Y.png');
/*!40000 ALTER TABLE `order_character_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_characters`
--

DROP TABLE IF EXISTS `order_characters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_characters` (
  `character_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `character_category` enum('original','fanart') COLLATE utf8mb4_unicode_ci NOT NULL,
  `character_detail` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `background_category` enum('none','simple','detailed') COLLATE utf8mb4_unicode_ci NOT NULL,
  `background_detail` text COLLATE utf8mb4_unicode_ci,
  `extra_price` int NOT NULL DEFAULT '0',
  `extra_duration` int NOT NULL DEFAULT '0',
  `background_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`character_id`),
  KEY `order_characters_order_id_foreign` (`order_id`),
  KEY `order_characters_background_id_foreign` (`background_id`),
  CONSTRAINT `order_characters_background_id_foreign` FOREIGN KEY (`background_id`) REFERENCES `background_options` (`id`) ON DELETE SET NULL,
  CONSTRAINT `order_characters_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_characters`
--

LOCK TABLES `order_characters` WRITE;
/*!40000 ALTER TABLE `order_characters` DISABLE KEYS */;
INSERT INTO `order_characters` VALUES (1,1,'original','anime girl rambut biru, mata merah','simple','langit sore',5000,0,NULL),(2,1,'fanart','karakter genshin impact','none','',0,0,NULL),(3,2,'fanart','Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur.','simple','color: blue',0,0,NULL),(4,3,'original','Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur.','detailed','Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur.',0,0,NULL),(5,4,'original','axcvbnm,','none','xcvbnm',0,0,NULL),(6,9,'original','Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur.','none','Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur.',0,0,NULL),(7,10,'original','Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed.','none','Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur.',0,0,NULL),(8,11,'original','Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed.','none','Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur.',0,0,NULL),(9,12,'original','Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur.','none','Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur. Libero ut suspendisse volutpat aliquam pellentesque sed. Ipsum interdum faucibus eu aliquam posuere. Lorem ipsum dolor sit amet consectetur.',0,0,NULL),(10,13,'fanart','use App\\Http\\Controllers\\Api\\ProductController;','none','asdfghjkyuiuse App\\Http\\Controllers\\Api\\ProductController;',0,0,2),(11,14,'original','use App\\Http\\Controllers\\Api\\ProductController;','none','use App\\Http\\Controllers\\Api\\ProductController;',0,0,3),(12,15,'fanart','{{ order?.product?.name || \'-\' }}\r\n{{ order?.payment?.payment_method || \'-\' }}\r\n{{ char.background?.name || \'No background\' }}','none','{{ order?.product?.name || \'-\' }}\r\n{{ order?.payment?.payment_method || \'-\' }}\r\n{{ char.background?.name || \'No background\' }}',0,0,2),(13,16,'original','asdfghjkl;wertyuiopcghnm','none','asdfghjkl;wertyuiopcghnm',0,0,2),(14,17,'fanart','asdfghjkl;wertyuiopcghnm','none','asdfghjkl;wertyuiopcghnm',0,0,3),(15,17,'original','asdfghjkl;wertyuiopcghnm','none','asdfghjkl;wertyuiopcghnm',0,0,1),(16,18,'original','wqwsdfghjkl;\'','none','asdfghjklsdfghjk;',0,0,2),(17,19,'original','asdfgyjiokefgujoksdfghk','none','asdfghjil;zdxfgbml;\'ghjkml,.',0,0,2),(18,20,'original','adfghjlk;aedfgjiplrtgujokl','none','aafgjl;\'ewrtyuoipdfghjkl;rtyui',0,0,2),(19,21,'original','ADSFGJKL','none','SDFGCVBHJNKL',0,0,2),(20,22,'fanart','DFGHJKL','none','ASDFGJKL',0,0,3),(21,23,'original','sadfghjk','none','azxcvbnm,',0,0,2),(22,24,'fanart','adsfghjkl;','none','asdfcgbjml,',0,0,3),(23,25,'original','asdfghjksdfghjkl','none','asdfghjklertyuiopsdfghj',0,0,2),(24,26,'original','asdfghjksdfghjkl','none','asdfghjklertyuiopsdfghj',0,0,2),(25,27,'original','asdfghbjnkmrdtfyguhjk','none','fguhjikqwertyuioxcvbnm456789',0,0,2),(26,28,'original','asdfghbjnkmrdtfyguhjk','none','fguhjikqwertyuioxcvbnm456789',0,0,2),(27,29,'fanart','sdfghjkl;werdghjkl;','none','asdfghjkolpaesrdfgyujik',0,0,2),(28,30,'original','awesrdtyuiol;fguiol\'','none','sdfgyop[sdfghjkoeasrtgui',0,0,2),(29,31,'original','sdfghjkl,rtfyuhjok','none','szdxfcghbjkmldfgvhb',0,0,2),(30,32,'original','waeftgjokp','none','ertyuikl;',0,0,2),(31,33,'original','waeftgjokp','none','ertyuikl;',0,0,2),(32,34,'original','waeftgjokp','none','ertyuikl;',0,0,2),(33,35,'original','waeftgjokp','none','ertyuikl;',0,0,2),(34,36,'original','asdfghjlkpsdfyguiop','none','awsdrfgyjokpwasertygui',0,0,2),(35,37,'original','asdfghjlkpsdfyguiop','none','awsdrfgyjokpwasertygui',0,0,2),(36,38,'original','asdfghjlkpsdfyguiop','none','awsdrfgyjokpwasertygui',0,0,2),(37,39,'fanart','dfghjkl;\'erdtguiopl[]','none','dfghjkl;\'wertfyujokp',0,0,2),(38,40,'fanart','dfghjkl;\'erdtguiopl[]','none','dfghjkl;\'wertfyujokp',0,0,2),(39,41,'original','wesdftghjkl;sdrtgyui','none','waerdtfgyujiowertfyuhijo',0,0,2),(40,42,'original','wesdftghjkl;sdrtgyui','none','waerdtfgyujiowertfyuhijo',0,0,2),(41,43,'original','wesdftghjkl;sdrtgyui','none','waerdtfgyujiowertfyuhijo',0,0,2),(42,44,'original','wesdftghjkl;sdrtgyui','none','waerdtfgyujiowertfyuhijo',0,0,2),(43,45,'original','wesdftghjkl;sdrtgyui','none','waerdtfgyujiowertfyuhijo',0,0,2),(44,46,'original','wesdftghjkl;sdrtgyui','none','waerdtfgyujiowertfyuhijo',0,0,2),(45,47,'original','wesrfguok[;','none','eesdfghjkl;\'',0,0,2),(46,48,'original','wesrfguok[;','none','eesdfghjkl;\'',0,0,2),(47,49,'fanart','asdfghjkl;\'','none','sdfgjilprdtgyjik',0,0,2),(48,50,'fanart','szdfghjklsdfgyjokp[','none','sdfghjlk;werdtgujok',0,0,3),(49,51,'fanart','szdfghjklsdfgyjokp[','none','sdfghjlk;werdtgujok',0,0,3),(50,52,'original','qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm','none','qwertyuiopasdfghjklzxcvbnm,qwertyuiopasdfghjklzxcvbnm',0,0,3),(51,53,'fanart','asdfghjkl;sdfghjkl;\'','none','dfghjkleasrdfghjklwerfghjkl',0,0,2),(52,54,'fanart','qwertyuiop;[\'szcfgbjl;sdxfgbmkl;sdfghl;dfghjk','none','sdfghjklawergjkl;szdfghmk,rtyguhihbjnkmcvbjnkldjkl',0,0,2),(53,55,'fanart','qwertyuiop[asdfgbml,.\'/wertyuiop[]\\','none','wdfghjl;[zxcvbnm,l;qwertyuiop[sdfghjkl;\'',0,0,2),(54,56,'original','rtyuiozsdfgyujioqwert6ui','none','sdxfcgbhmk,lrdtfgyjioksdxfcgvhjk',0,0,2),(55,57,'fanart','wertyuiopasdfghjkl;\'asdfuolp','none','qwesrfgyjklxcvbnm,.asertyuhiop',0,0,3),(56,58,'original','qwertyuiodfghjk23456789qwertyuiopasdfghjklzxcvbnmmnxzzlkjhgfdsaoiuytrewq','none','qwertyuiodfghjk23456789qwertyuiopasdfghjklzxcvbnmmnxzzlkjhgfdsaoiuytrewq',0,0,2),(57,59,'fanart','qwertyuiop[asdfghjkl;zxcvbnm,','none','qwertyuiop[asdfghjkl;zxcvbnm,',0,0,3),(58,60,'fanart','qwertyuiopasdfghjklzxcvbnm,','none','qwertyuiopasdfghjklzxcvbnm,',0,0,2),(59,61,'original','qwertyuiopasdfghjklzxcvbnm,','none','qwertyuiopasdfghjklzxcvbnm,',0,0,3),(60,62,'original','qwertyuiopasdfghjklzxcvbnm,','none','qwertyuiopasdfghjklzxcvbnm,',0,0,2),(61,62,'fanart','qwertyuiopasdfghjklzxcvbnm,','none','qwertyuiopasdfghjklzxcvbnm,',0,0,3),(62,63,'original','qwertyuiop','none','qwertyuiop',0,0,2),(63,64,'original','qwertyuioasdfghjkl','none','qwertyuioasdfghjkl',0,0,2),(64,65,'original','qwertyuiopasdfghjklzxcvbnmqwertyuiopasdfghjkl','none','qwertyuiopasdfghjklzxcvbnmqwertyuiopasdfghjkl',0,0,3),(65,66,'original','qwertyuiopasdfghjklzxcvbnmqwertyuiopasdfghjkl','none','qwertyuiopasdfghjklzxcvbnmqwertyuiopasdfghjkl',0,0,3),(66,67,'fanart','qwertyuiopasdfghjklzxcvbnm,','none','qwertyuiopasdfghjklzxcvbnm',0,0,1),(67,68,'fanart','qwertyuiopqwertyuiopqwertyuiopqwertyuiop','none','qwertyuiopqwertyuiopqwertyuiopqwertyuiop',0,0,1),(68,69,'fanart','qwertyuiopasdfghjklqwertyuiop','none','qwertyuiopqwertyuiop',0,0,2),(69,70,'fanart','qwertyiopqwertyip[qwertyiop','none','qwetyiopqwertyip[',0,0,1),(70,71,'original','qwertyuiopqwertyuiopqwertyuiop[','none','qwiopqwertyuioqwertyuiop',0,0,1),(71,72,'original','qweqweasasdfqawsderftgyjiolp;aswdertgyhjiolpasdfghjklp','none','qertyuioqaswdefthkl;qwefgthklp;[sdfrtgyuiop',0,0,2),(72,73,'fanart','qwertyuiopqweriopq','none','qwertyuiopqweriopq',0,0,2),(73,74,'fanart','qwertyuiopqwertyuiopqwertyuiop','none','qwertyuiopqwertyuiopqwertyuiop',0,0,1),(74,75,'original','qwertyuiopqwertyuiop[qwertyuiop[qwertyuiop[','none','qwertyuiopqwertyuiop[qwertyuiop[qwertyuiop[',0,0,2),(75,76,'fanart','qwertyuioqwertyuiopqwertyuiop','none','qwertyuiopqwertyuiopqwertyuiop',0,0,1),(76,77,'fanart','qwertyuiopqwertyuiopqwertyuiop[qwertyuiop','none','qwertyuiopqwertyuiopqwertyuiop[qwertyuiop',0,0,2),(77,78,'fanart','qwertyuiopqwertyuiop','none','qwertyuiopqwertyuiopqwertyuiop',0,0,2),(78,79,'original','qwertyuiopqwertyuiopqwertyuio','none','qwertyuiopqwertyuiopqwertyuiop',0,0,2),(79,80,'fanart','wertyuiopwertyuiop[ertyuio','none','wertyuiopwertyuiop[ertyuio',0,0,1),(80,81,'fanart','wertyuiopwertyuiop[ertyuio','none','wertyuiopwertyuiop[ertyuio',0,0,3),(81,82,'fanart','wertyuiopwertyuiop[ertyuio','none','wertyuiopwertyuiop[ertyuio',0,0,3),(82,83,'fanart','wertyuiopwertyuiop[ertyuio','none','wertyuiopwertyuiop[ertyuio',0,0,2),(83,84,'fanart','wertyuiopwertyuiop[ertyuio','none','wertyuiopwertyuiop[ertyuio',0,0,2),(84,85,'fanart','wertyuiopwertyuiop[ertyuio','none','wertyuiopwertyuiop[ertyuio',0,0,2),(85,86,'fanart','wertyuiopwertyuiop[ertyuio','none','wertyuiopwertyuiop[ertyuio',0,0,2),(86,87,'original','qwertyuiop[qwertyuiopasdfghjkl','none','qwertyuiop[qwertyuiopasdfghjkl',0,0,2),(87,88,'original','qwertyuiop[qwertyuiopasdfghjkl','none','qwertyuiop[qwertyuiopasdfghjkl',0,0,1),(88,89,'original','qwertyuiop[qwertyuiopasdfghjkl','none','qwertyuiop[qwertyuiopasdfghjkl',0,0,1),(89,90,'original','qwertyuiopqwertyuiopqwertyuiop','none','qwertyuiopqwertyuiopqwertyuiop',0,0,2),(90,91,'original','qwertyuiopqwertyuiopqwertyuiop','none','qwertyuiopqwertyuiopqwertyuiop',0,0,2),(91,92,'fanart','qwertyuiopqwertyuiopqwertyuiop','none','qwertyuiopqwertyuiopqwertyuio',0,0,2),(92,93,'original','qwertyuiopqwertyuiopqwertyuio','none','qwertyuiopqwertyuiopqwertyuio',0,0,2),(93,94,'original','qwertyuiopqwertyuiopqwertyuio','none','qwertyuiopqwertyuiopqwertyuio',0,0,1),(94,95,'fanart','qwertyuiopqwertyuiop','none','qwertyuiopqwertyuiop',0,0,1),(95,96,'original','qwertyuiopqwertyuiop','none','qwertyuiopqwertyuiop',0,0,1),(96,97,'fanart','The Rising of the Shield Hero','none','The Rising of the Shield Hero',0,0,2),(97,97,'fanart','The Rising of the Shield Hero','none','The Rising of the Shield Hero',0,0,1),(98,98,'original','The Rising of the Shield Hero','none','The Rising of the Shield Hero',0,0,1),(99,98,'original','The Rising of the Shield Hero','none','The Rising of the Shield Hero',0,0,2),(100,99,'original','The Rising of the Shield Hero','none','The Rising of the Shield Hero',0,0,3),(101,100,'original','The Rising of the Shield Hero','none','The Rising of the Shield Hero',0,0,2),(102,101,'original','The Rising of the Shield Hero','none','The Rising of the Shield Hero',0,0,2),(103,102,'original','The Rising of the Shield Hero','none','The Rising of the Shield Hero',0,0,3),(104,103,'original','qwertyuiowertyuioqwertyuio','none','qwertyuiowertyuioqwertyuio',0,0,1),(105,103,'original','qwertyuiowertyuioqwertyuio','none','qwertyuiowertyuioqwertyuio',0,0,1),(106,104,'fanart','qwertyuiowertyuioqwertyuio','none','qwertyuiowertyuioqwertyuio',0,0,2),(107,104,'original','qwertyuiowertyuioqwertyuio','none','qwertyuiowertyuioqwertyuio',0,0,3),(108,105,'original','qwertyuioplkjhgfdsazxcvbnm','none','qwertyuioplkjhgfdsazxcvbnm',0,0,2),(109,106,'original','qwertyuioplkjhgfdsazxcvbnm','none','qwertyuioplkjhgfdsazxcvbnm',0,0,3),(110,107,'fanart','qwertyuioplkjhgfdsazxcvbnm','none','qwertyuioplkjhgfdsazxcvbnm',0,0,2),(111,108,'original','qwertyuioplkjhgfdsazxcvbnm','none','qwertyuioplkjhgfdsazxcvbnm',0,0,2),(112,109,'fanart','qwertyuioplkjhgfdsazxcvbnm','none','qwertyuioplkjhgfdsazxcvbnm',0,0,2),(113,110,'original','qwertyuioplkjhgfdsazxcvbnm','none','qwertyuioplkjhgfdsazxcvbnm',0,0,2),(114,111,'original','qwertyuiopqwertyuiopqwertyuiop','none','qwertyuiopqwertyuiopqwertyuiop',0,0,2),(115,112,'fanart','qwertyuioqwertyuiop','none','qwertyuioqwertyuiop',0,0,2),(116,113,'original','qwertyuioqwertyuiop','none','qwertyuioqwertyuiop',0,0,3),(117,114,'fanart','qwertyuiopqwertyuiopqwertyuiop','none','qwertyuiopqwertyuiopqwertyuiop',0,0,2),(118,115,'fanart','qwertyuiopqwertyuiopqwertyuiop','none','qwertyuiopqwertyuiopqwertyuiop',0,0,2),(119,117,'fanart','qwertyuiopqwertyuiopqwertyuiop','detailed','qwertyuiopqwertyuiopqwertyuiop',0,0,3),(120,118,'fanart','qwertyuiopqwertyuiopqwertyuiop','detailed','qwertyuiopqwertyuiopqwertyuiop',0,0,3),(121,119,'fanart','wertyuiopqwertyuioasdfghjklsdfghjklsdfghjwasedrgyujioertvfbguhj erdtvfghjyh','detailed','wertyuiopqwertyuioasdfghjklsdfghjklsdfghjwasedrgyujioertvfbguhj erdtvfghjyh',0,0,3);
/*!40000 ALTER TABLE `order_characters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `payment_id` bigint unsigned DEFAULT NULL,
  `order_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `start_date` datetime DEFAULT NULL,
  `finish_estimated` datetime DEFAULT NULL,
  `progress_stage` enum('Sketch Phase','Sketch Approve','Payment Pending','Payment Receive','Lineart Phase','Coloring/Detailing','Background and Finishing','Complete') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Sketch Phase',
  `admin_fee` int NOT NULL DEFAULT '0',
  `discount_amount` int NOT NULL DEFAULT '0',
  `total_price` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `customer_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'wip',
  `quantity` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,1,NULL,'2026-04-25 17:48:16',NULL,NULL,'Sketch Phase',0,0,150000,'2026-04-25 03:48:16','2026-04-25 03:48:16','','','wip',1),(2,1,10,NULL,'2026-04-25 18:11:43',NULL,NULL,'Sketch Phase',0,0,100000,'2026-04-25 04:11:43','2026-04-25 04:11:43','','','wip',1),(3,1,10,NULL,'2026-04-25 18:34:38',NULL,NULL,'Sketch Phase',0,0,100000,'2026-04-25 04:34:38','2026-04-25 04:34:38','cici','cici@gmail.com','wip',1),(4,1,10,NULL,'2026-04-30 13:25:46',NULL,NULL,'Sketch Phase',0,0,120000,'2026-04-29 23:25:46','2026-04-29 23:25:46','sdfghbjnm','punyaais.mf@gmail.com','wip',1),(9,1,10,NULL,'2026-05-03 08:51:37',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-02 18:51:37','2026-05-02 18:51:37','fghjk','dfghjkl@gamail.com','wip',1),(10,1,10,NULL,'2026-05-03 08:53:58',NULL,NULL,'Sketch Phase',0,0,100000,'2026-05-02 18:53:58','2026-05-02 18:53:58','popo','popo@gmail.com','wip',1),(11,1,10,NULL,'2026-05-03 08:55:35',NULL,NULL,'Sketch Phase',0,0,100000,'2026-05-02 18:55:35','2026-05-02 18:55:35','popo','popo@gmail.com','wip',1),(12,1,10,NULL,'2026-05-03 09:00:34',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-02 19:00:34','2026-05-02 19:00:34','lina','lina@gmail.com','wip',1),(13,1,9,5,'2026-05-03 13:44:30',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-02 23:44:30','2026-05-02 23:44:30','elo','elo@gmail.com','wip',1),(14,1,9,6,'2026-05-03 13:55:43',NULL,NULL,'Sketch Phase',0,0,150000,'2026-05-02 23:55:43','2026-05-02 23:55:43','moe','moe@gmail.com','wip',1),(15,1,9,7,'2026-05-03 14:05:19',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-03 00:05:19','2026-05-03 00:05:19','kuki','kuki@gmail.com','wip',1),(16,1,9,8,'2026-05-05 20:22:19',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-05 06:22:19','2026-05-05 06:22:19','luwy','luwy@gmail.com','wip',1),(17,1,8,9,'2026-05-05 20:22:20',NULL,NULL,'Sketch Phase',0,0,190000,'2026-05-05 06:22:20','2026-05-05 06:22:20','luwy','luwy@gmail.com','wip',1),(18,1,10,10,'2026-05-06 09:45:35',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-05 19:45:35','2026-05-05 19:45:35','lili','lili@gmail.com','wip',1),(19,1,7,11,'2026-05-06 11:18:39',NULL,NULL,'Sketch Phase',0,0,160000,'2026-05-05 21:18:39','2026-05-05 21:18:39','popo','popo@gmail.com','wip',1),(20,1,10,12,'2026-05-06 11:18:40',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-05 21:18:40','2026-05-05 21:18:40','popo','popo@gmail.com','wip',1),(21,1,7,13,'2026-05-06 12:53:54',NULL,NULL,'Sketch Phase',0,0,160000,'2026-05-05 22:53:54','2026-05-05 22:53:54','SDFG','SDFGH','wip',1),(22,1,10,14,'2026-05-06 12:53:54',NULL,NULL,'Sketch Phase',0,0,150000,'2026-05-05 22:53:54','2026-05-05 22:53:54','SDFG','SDFGH','wip',1),(23,1,7,15,'2026-05-06 12:59:22',NULL,NULL,'Sketch Phase',0,0,160000,'2026-05-05 22:59:22','2026-05-05 22:59:22','fghjk','zvbnm,','wip',1),(24,1,10,16,'2026-05-06 12:59:22',NULL,NULL,'Sketch Phase',0,0,150000,'2026-05-05 22:59:22','2026-05-05 22:59:22','fghjk','zvbnm,','wip',1),(25,1,10,17,'2026-05-06 18:33:02',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-06 04:33:02','2026-05-06 04:33:02','kiki','kiki@gmail.com','wip',1),(26,1,10,18,'2026-05-06 18:33:38',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-06 04:33:38','2026-05-06 04:33:38','kiki','kiki@gmail.com','wip',1),(27,1,10,19,'2026-05-06 20:08:53',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-06 06:08:53','2026-05-06 06:08:53','lily','lily@gmail.com','wip',1),(28,1,10,20,'2026-05-06 20:09:34',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-06 06:09:34','2026-05-06 06:09:34','lily','lily@gmail.com','wip',1),(29,1,10,21,'2026-05-06 20:12:53',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-06 06:12:53','2026-05-06 06:12:53','pipi','pipi@gmail.com','wip',1),(30,1,10,22,'2026-05-06 21:36:54',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-06 07:36:54','2026-05-06 07:36:54','lulu','lulu@gmail.com','wip',1),(31,1,10,23,'2026-05-06 22:00:48',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-06 08:00:48','2026-05-06 08:00:48','wawa','wawa@gmail.com','wip',1),(32,1,10,24,'2026-05-06 22:02:02',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-06 08:02:02','2026-05-06 08:02:02','wawa','wawa2gmail.com','wip',1),(33,1,10,25,'2026-05-06 22:04:12',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-06 08:04:12','2026-05-06 08:04:12','wawa','wawa2gmail.com','wip',1),(34,1,10,26,'2026-05-06 22:05:06',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-06 08:05:06','2026-05-06 08:05:06','wawa','wawa2gmail.com','wip',1),(35,1,10,27,'2026-05-06 22:18:32',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-06 08:18:32','2026-05-06 08:18:32','wawa','wawa2gmail.com','wip',1),(36,1,10,28,'2026-05-06 22:19:28',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-06 08:19:28','2026-05-06 08:19:28','wawa','wawa@gmail.com','wip',1),(37,1,10,29,'2026-05-06 22:25:07',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-06 08:25:07','2026-05-06 08:25:07','wawa','wawa@gmail.com','wip',1),(38,1,10,30,'2026-05-06 22:27:45',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-06 08:27:45','2026-05-06 08:27:45','wawa','wawa@gmail.com','wip',1),(39,1,10,31,'2026-05-06 22:28:18',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-06 08:28:18','2026-05-06 08:28:18','wawa','wawa@gmail.com','wip',1),(40,1,10,32,'2026-05-06 22:35:32',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-06 08:35:32','2026-05-06 08:35:32','wawa','wawa@gmail.com','wip',1),(41,1,10,33,'2026-05-06 22:38:55',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-06 08:38:55','2026-05-06 08:38:55','wawa','wawa@gmail.com','wip',1),(42,1,10,34,'2026-05-06 22:41:26',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-06 08:41:26','2026-05-06 08:41:26','wawa','wawa@gmail.com','wip',1),(43,1,10,35,'2026-05-06 22:42:36',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-06 08:42:36','2026-05-06 08:42:36','wawa','wawa@gmail.com','wip',1),(44,1,10,36,'2026-05-06 22:51:36',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-06 08:51:36','2026-05-06 08:51:36','wawa','wawa@gmail.com','wip',1),(45,1,10,37,'2026-05-06 23:00:00',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-06 09:00:00','2026-05-06 09:00:00','wawa','wawa@gmail.com','wip',1),(46,1,10,38,'2026-05-06 23:03:09',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-06 09:03:09','2026-05-06 09:03:09','wawa','wawa@gmail.com','wip',1),(47,1,10,39,'2026-05-07 04:25:23',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-06 14:25:23','2026-05-06 14:25:23','wawa','wawa@gmail.com','wip',1),(48,1,10,40,'2026-05-07 04:25:27',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-06 14:25:27','2026-05-06 14:25:27','wawa','wawa@gmail.com','wip',1),(49,1,10,41,'2026-05-07 04:28:14',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-06 14:28:14','2026-05-06 14:28:14','kuki','kuki@gmail.com','wip',1),(50,1,10,42,'2026-05-07 04:39:59',NULL,NULL,'Sketch Phase',0,0,150000,'2026-05-06 14:39:59','2026-05-06 14:39:59','lily','lily@gmail.com','wip',1),(51,1,10,43,'2026-05-07 04:40:03',NULL,NULL,'Sketch Phase',0,0,150000,'2026-05-06 14:40:03','2026-05-06 14:40:03','lily','lily@gmail.com','wip',1),(52,1,10,44,'2026-05-07 04:46:43',NULL,NULL,'Sketch Phase',0,0,150000,'2026-05-06 14:46:43','2026-05-06 14:46:43','jiji','jiji@gmail.com','wip',1),(53,1,7,45,'2026-05-07 04:54:01',NULL,NULL,'Sketch Phase',0,0,160000,'2026-05-06 14:54:01','2026-05-06 14:54:01','pipi','pipi@gmail.com','wip',1),(54,1,10,46,'2026-05-07 04:54:01',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-06 14:54:01','2026-05-06 14:54:01','pipi','pipi@gmail.com','wip',1),(55,1,7,47,'2026-05-07 10:17:15',NULL,NULL,'Sketch Phase',0,0,160000,'2026-05-06 20:17:14','2026-05-06 20:17:15','lily','lily@gmail.com','wip',1),(56,1,7,48,'2026-05-07 10:27:04',NULL,NULL,'Sketch Phase',0,0,160000,'2026-05-06 20:27:04','2026-05-06 20:27:04','lily','lily@gmail.com','wip',1),(57,1,7,49,'2026-05-07 10:36:16',NULL,NULL,'Sketch Phase',0,0,190000,'2026-05-06 20:36:16','2026-05-06 20:36:16','kuki','kuki@gmail.com','wip',1),(58,1,10,50,'2026-05-09 21:41:42',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-09 07:41:42','2026-05-09 07:41:42','lily','lily@gmail.com','wip',1),(59,2,7,51,'2026-05-10 08:19:19',NULL,NULL,'Sketch Phase',0,0,190000,'2026-05-09 18:19:19','2026-05-09 18:19:19','lily','lily@gmail.com','wip',1),(60,2,7,52,'2026-05-10 08:40:04',NULL,NULL,'Sketch Phase',0,0,160000,'2026-05-09 18:40:04','2026-05-09 18:40:04','lily','lily@gmail.com','wip',1),(61,2,10,53,'2026-05-10 08:40:05',NULL,NULL,'Sketch Phase',0,0,150000,'2026-05-09 18:40:05','2026-05-09 18:40:05','lily','lily@gmail.com','wip',1),(62,2,10,54,'2026-05-10 08:46:49',NULL,NULL,'Sketch Phase',0,0,270000,'2026-05-09 18:46:49','2026-05-09 18:46:49','lily','lily@gmail.com','wip',1),(63,2,2,55,'2026-05-13 08:06:51',NULL,NULL,'Sketch Phase',0,0,70000,'2026-05-12 18:06:51','2026-05-12 18:06:51','sdfgh','asdf@gmail.com','done',1),(64,2,5,56,'2026-05-13 10:01:48',NULL,NULL,'Sketch Phase',0,0,220000,'2026-05-12 20:01:48','2026-05-12 20:01:48','lily','lily@gmail.com','wip',1),(65,2,6,57,'2026-05-13 10:09:58',NULL,NULL,'Sketch Phase',0,0,160000,'2026-05-12 20:09:58','2026-05-12 20:09:58','lily','lily@gmail.com','wip',1),(66,2,6,58,'2026-05-13 10:13:59',NULL,NULL,'Sketch Phase',0,0,160000,'2026-05-12 20:13:59','2026-05-12 20:13:59','lily','lily@gmail.com','wip',1),(67,2,2,59,'2026-05-13 10:39:04',NULL,NULL,'Sketch Phase',0,0,50000,'2026-05-12 20:39:04','2026-05-12 20:39:04','lily','lily@gmail.com','wip',1),(68,2,4,60,'2026-05-13 10:51:33',NULL,NULL,'Sketch Phase',0,0,70000,'2026-05-12 20:51:33','2026-05-12 20:51:33','uly','lily@gmail.com','wip',1),(69,2,10,61,'2026-05-13 10:58:03',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-12 20:58:03','2026-05-12 20:58:03','lily','lily@gmail.com','wip',1),(70,2,2,62,'2026-05-13 11:16:51',NULL,NULL,'Sketch Phase',0,0,50000,'2026-05-12 21:16:51','2026-05-12 21:16:51','lilly','lily@gmail.com','wip',1),(71,2,5,63,'2026-05-13 11:22:51',NULL,NULL,'Sketch Phase',0,0,200000,'2026-05-12 21:22:51','2026-05-12 21:22:51','qwert','qwert@gmail.com','wip',1),(72,2,2,64,'2026-05-13 11:34:29',NULL,NULL,'Sketch Phase',0,0,70000,'2026-05-12 21:34:29','2026-05-12 21:34:29','lily','lily@gmail.com','wip',1),(73,2,2,65,'2026-05-13 11:37:23',NULL,NULL,'Sketch Phase',0,0,70000,'2026-05-12 21:37:23','2026-05-12 21:37:23','cvbn','xcvbn@gmail.com','wip',1),(74,2,4,66,'2026-05-13 12:00:54',NULL,NULL,'Sketch Phase',0,0,70000,'2026-05-12 22:00:54','2026-05-12 22:00:55','sdfghj','sdfghj@gmail.com','wip',1),(75,2,4,67,'2026-05-14 08:14:06',NULL,NULL,'Sketch Phase',0,0,90000,'2026-05-13 18:14:06','2026-05-13 18:14:06','lily','lily@gmail.com','wip',1),(76,2,4,68,'2026-05-14 08:28:10',NULL,NULL,'Payment Receive',0,0,70000,'2026-05-13 18:28:10','2026-05-14 06:28:53','lily','lily@gmail.com','wip',1),(77,2,4,69,'2026-05-14 08:32:27',NULL,NULL,'Sketch Phase',0,0,90000,'2026-05-13 18:32:27','2026-05-14 07:14:52','dfgh','sdfg@gmail.com','canceled',1),(78,2,4,70,'2026-05-14 09:18:53',NULL,NULL,'Sketch Phase',0,0,90000,'2026-05-13 19:18:53','2026-05-13 19:18:53','sdfg','dfgh@gmail.com','wip',1),(79,2,4,71,'2026-05-14 09:22:19',NULL,NULL,'Sketch Phase',0,0,90000,'2026-05-13 19:22:19','2026-05-13 19:22:19','sdfg','sdfg@gmail.com','wip',1),(80,2,4,72,'2026-05-14 09:26:17',NULL,NULL,'Sketch Phase',0,0,70000,'2026-05-13 19:26:17','2026-05-13 19:26:17','dfgh','cvbnm@gmail.com','wip',1),(81,2,5,73,'2026-05-14 09:28:47',NULL,NULL,'Complete',0,0,250000,'2026-05-13 19:28:47','2026-05-14 06:09:15','wertyu','sdfgh@gmail.com','done',1),(82,2,5,74,'2026-05-14 09:28:47',NULL,NULL,'Sketch Phase',0,0,250000,'2026-05-13 19:28:47','2026-05-14 07:16:41','wertyu','sdfgh@gmail.com','canceled',1),(83,2,5,75,'2026-05-14 09:31:42',NULL,NULL,'Complete',0,0,220000,'2026-05-13 19:31:42','2026-05-14 05:59:30','sdasdfgh','asdfghjk@gmail.com','done',1),(84,2,5,76,'2026-05-14 09:31:46',NULL,NULL,'Sketch Phase',0,0,220000,'2026-05-13 19:31:46','2026-05-14 07:12:29','sdasdfgh','asdfghjk@gmail.com','canceled',1),(85,2,7,77,'2026-05-14 09:34:50',NULL,NULL,'Sketch Phase',0,0,160000,'2026-05-13 19:34:50','2026-05-13 19:34:50','sdhj','dfghjk@gmail.com','wip',1),(86,2,9,78,'2026-05-14 09:37:34',NULL,NULL,'Payment Receive',0,0,120000,'2026-05-13 19:37:34','2026-05-14 07:37:53','srtyuk','ertyui@gmail.com','wip',1),(87,2,5,79,'2026-05-14 11:06:44',NULL,NULL,'Complete',0,0,220000,'2026-05-13 21:06:44','2026-05-14 05:52:39','sdfghjkl','asdfghjk@gmail.com','done',1),(88,2,5,80,'2026-05-14 11:08:51',NULL,NULL,'Complete',0,0,200000,'2026-05-13 21:08:51','2026-05-14 05:58:46','wertyu','werty@gmail.com','done',1),(89,2,5,81,'2026-05-14 11:10:26',NULL,NULL,'Complete',0,0,200000,'2026-05-13 21:10:26','2026-05-14 05:37:07','asdfg','asdfgh@gmail.com','done',1),(90,2,4,82,'2026-05-14 12:05:45',NULL,NULL,'Sketch Phase',0,0,90000,'2026-05-13 22:05:45','2026-05-13 22:05:45','lily','lily@gmail.com','wip',1),(91,2,4,83,'2026-05-14 12:05:49',NULL,NULL,'Complete',0,0,90000,'2026-05-13 22:05:49','2026-05-14 06:18:15','lily','lily@gmail.com','done',1),(92,2,4,84,'2026-05-14 12:10:58',NULL,NULL,'Complete',0,0,90000,'2026-05-13 22:10:58','2026-05-14 06:18:26','ghjk','ghk@gmail.com','done',1),(93,3,11,85,'2026-05-14 23:47:24',NULL,NULL,'Payment Receive',0,0,100000,'2026-05-14 09:47:24','2026-05-14 09:47:40','kuki','kuki@gmail.com','wip',1),(94,3,6,86,'2026-05-14 23:47:24',NULL,NULL,'Sketch Phase',0,0,140000,'2026-05-14 09:47:24','2026-05-14 09:47:24','kuki','kuki@gmail.com','wip',1),(95,3,7,87,'2026-05-14 23:50:14',NULL,NULL,'Payment Receive',0,0,110000,'2026-05-14 09:50:14','2026-05-14 10:01:39','kuki','kuki@gmail.com','wip',1),(96,3,4,88,'2026-05-14 23:50:14',NULL,NULL,'Sketch Phase',0,0,70000,'2026-05-14 09:50:14','2026-05-14 09:50:14','kuki','kuki@gmail.com','wip',1),(97,3,10,89,'2026-05-14 23:57:01',NULL,NULL,'Payment Receive',0,0,420000,'2026-05-14 09:57:01','2026-05-14 09:57:13','kuki','kuki@gmail.com','wip',1),(98,3,11,90,'2026-05-15 00:03:23',NULL,NULL,'Payment Receive',0,0,180000,'2026-05-14 10:03:23','2026-05-14 10:03:35','kuki','kuki@gmail.com','wip',1),(99,3,9,91,'2026-05-15 00:03:24',NULL,NULL,'Sketch Phase',0,0,200000,'2026-05-14 10:03:24','2026-05-14 10:03:24','kuki','kuki@gmail.com','wip',1),(100,3,11,92,'2026-05-15 00:05:58',NULL,NULL,'Payment Receive',0,0,100000,'2026-05-14 10:05:58','2026-05-14 10:06:09','kuki','kuki@gmail.com','wip',1),(101,3,4,93,'2026-05-15 00:05:58',NULL,NULL,'Sketch Phase',0,0,90000,'2026-05-14 10:05:58','2026-05-14 10:05:58','kuki','kuki@gmail.com','wip',1),(102,3,2,94,'2026-05-15 00:05:59',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-14 10:05:59','2026-05-14 10:05:59','kuki','kuki@gmail.com','wip',1),(103,3,9,95,'2026-05-15 00:18:54',NULL,NULL,'Payment Receive',0,0,300000,'2026-05-14 10:18:54','2026-05-14 10:19:04','kuki','kuki@gmail.com','wip',2),(104,3,6,96,'2026-05-15 00:20:20',NULL,NULL,'Payment Receive',0,0,350000,'2026-05-14 10:20:20','2026-05-14 10:20:42','kuki','kuki@gmail.com','wip',2),(105,3,4,97,'2026-05-15 00:24:23',NULL,NULL,'Sketch Phase',0,0,90000,'2026-05-14 10:24:23','2026-05-14 10:24:23','kuki','kuki@gmail.com','wip',1),(106,3,2,98,'2026-05-15 00:24:23',NULL,NULL,'Sketch Phase',0,0,120000,'2026-05-14 10:24:23','2026-05-14 10:24:23','kuki','kuki@gmail.com','wip',1),(107,3,4,99,'2026-05-15 00:26:29',NULL,NULL,'Sketch Phase',0,0,90000,'2026-05-14 10:26:29','2026-05-14 10:26:29','kuki','kuki@gmail.com','wip',1),(108,3,2,100,'2026-05-15 00:26:30',NULL,NULL,'Sketch Phase',0,0,90000,'2026-05-14 10:26:30','2026-05-14 10:26:30','kuki','kuki@gmail.com','wip',1),(109,3,4,101,'2026-05-15 00:27:10',NULL,NULL,'Sketch Phase',0,0,90000,'2026-05-14 10:27:10','2026-05-14 10:27:10','kuki','kuki@gmail.com','wip',1),(110,3,2,102,'2026-05-15 00:27:11',NULL,NULL,'Payment Receive',0,0,90000,'2026-05-14 10:27:11','2026-05-14 10:38:33','kuki','kuki@gmail.com','wip',1),(111,3,6,103,'2026-05-15 00:28:14',NULL,NULL,'Payment Receive',0,0,160000,'2026-05-14 10:28:14','2026-05-14 10:38:12','kuki','kuki@gmail.com','wip',1),(112,3,6,104,'2026-05-15 00:37:33',NULL,NULL,'Payment Receive',0,0,160000,'2026-05-14 10:37:33','2026-05-14 10:37:46','kuki','kuki@gmail.com','wip',1),(113,3,7,105,'2026-05-15 00:37:33',NULL,NULL,'Payment Receive',0,0,160000,'2026-05-14 10:37:33','2026-05-14 10:37:46','kuki','kuki@gmail.com','wip',1),(114,2,4,106,'2026-05-15 13:23:06',NULL,NULL,'Sketch Phase',0,0,90000,'2026-05-14 23:23:06','2026-05-14 23:23:06','lily','lily@gmail.com','wip',1),(115,2,4,107,'2026-05-15 13:23:12',NULL,NULL,'Sketch Phase',0,0,90000,'2026-05-14 23:23:12','2026-05-14 23:23:12','lily','lily@gmail.com','wip',1),(117,2,11,109,'2026-05-15 13:37:07',NULL,NULL,'Sketch Phase',0,0,130000,'2026-05-14 23:37:07','2026-05-14 23:37:07','lily','lily@gmail.com','wip',1),(118,2,11,110,'2026-05-15 13:37:13',NULL,NULL,'Complete',0,0,130000,'2026-05-14 23:37:13','2026-05-15 00:35:37','lily','lily@gmail.com','wip',1),(119,2,6,111,'2026-05-15 15:15:08',NULL,NULL,'Sketch Phase',0,0,190000,'2026-05-15 01:15:08','2026-05-15 01:15:08','lily','lily@gmail.com','wip',1);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `payment_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `transaction_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `external_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` int NOT NULL,
  `paid_at` timestamp NULL DEFAULT NULL,
  `snap_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payments_order_id_foreign` (`order_id`),
  CONSTRAINT `payments_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,9,'gopay','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-02 18:51:37','2026-05-02 18:51:37'),(2,10,'gopay','pending',NULL,NULL,100000,NULL,NULL,NULL,'2026-05-02 18:53:58','2026-05-02 18:53:58'),(3,11,'gopay','pending',NULL,NULL,100000,NULL,NULL,NULL,'2026-05-02 18:55:35','2026-05-02 18:55:35'),(4,12,'gopay','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-02 19:00:34','2026-05-02 19:00:34'),(5,13,'dana','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-02 23:44:30','2026-05-02 23:44:30'),(6,14,'bank','pending',NULL,NULL,150000,NULL,NULL,NULL,'2026-05-02 23:55:43','2026-05-02 23:55:43'),(7,15,'gopay','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-03 00:05:19','2026-05-03 00:05:19'),(8,16,'dana','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-05 06:22:19','2026-05-05 06:22:19'),(9,17,'dana','pending',NULL,NULL,190000,NULL,NULL,NULL,'2026-05-05 06:22:20','2026-05-05 06:22:20'),(10,18,'gopay','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-05 19:45:35','2026-05-05 19:45:35'),(11,19,'bank','pending',NULL,NULL,160000,NULL,NULL,NULL,'2026-05-05 21:18:39','2026-05-05 21:18:39'),(12,20,'bank','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-05 21:18:40','2026-05-05 21:18:40'),(13,21,'bank','pending',NULL,NULL,160000,NULL,NULL,NULL,'2026-05-05 22:53:54','2026-05-05 22:53:54'),(14,22,'bank','pending',NULL,NULL,150000,NULL,NULL,NULL,'2026-05-05 22:53:54','2026-05-05 22:53:54'),(15,23,'bank','pending',NULL,NULL,160000,NULL,NULL,NULL,'2026-05-05 22:59:22','2026-05-05 22:59:22'),(16,24,'bank','pending',NULL,NULL,150000,NULL,NULL,NULL,'2026-05-05 22:59:22','2026-05-05 22:59:22'),(17,25,'now','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-06 04:33:02','2026-05-06 04:33:02'),(18,26,'later','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-06 04:33:38','2026-05-06 04:33:38'),(19,27,'now','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-06 06:08:53','2026-05-06 06:08:53'),(20,28,'later','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-06 06:09:34','2026-05-06 06:09:34'),(21,29,'now','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-06 06:12:53','2026-05-06 06:12:53'),(22,30,'now','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-06 07:36:54','2026-05-06 07:36:54'),(23,31,'now','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-06 08:00:48','2026-05-06 08:00:48'),(24,32,'now','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-06 08:02:02','2026-05-06 08:02:02'),(25,33,'now','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-06 08:04:12','2026-05-06 08:04:12'),(26,34,'now','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-06 08:05:06','2026-05-06 08:05:06'),(27,35,'now','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-06 08:18:32','2026-05-06 08:18:32'),(28,36,'now','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-06 08:19:28','2026-05-06 08:19:28'),(29,37,'now','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-06 08:25:07','2026-05-06 08:25:07'),(30,38,'now','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-06 08:27:45','2026-05-06 08:27:45'),(31,39,'now','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-06 08:28:18','2026-05-06 08:28:18'),(32,40,'now','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-06 08:35:32','2026-05-06 08:35:32'),(33,41,'now','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-06 08:38:55','2026-05-06 08:38:55'),(34,42,'now','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-06 08:41:26','2026-05-06 08:41:26'),(35,43,'now','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-06 08:42:36','2026-05-06 08:42:36'),(36,44,'now','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-06 08:51:36','2026-05-06 08:51:36'),(37,45,'now','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-06 09:00:00','2026-05-06 09:00:00'),(38,46,'now','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-06 09:03:09','2026-05-06 09:03:09'),(39,47,'xendit','pending','69fbb1c4171632a4f746e5f1','order-47',120000,NULL,NULL,'https://checkout-staging.xendit.co/web/69fbb1c4171632a4f746e5f1','2026-05-06 14:25:23','2026-05-06 14:25:26'),(40,48,'now','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-06 14:25:27','2026-05-06 14:25:27'),(41,49,'xendit','pending','69fbb26f171632a4f746e696','order-49',120000,NULL,NULL,'https://checkout-staging.xendit.co/web/69fbb26f171632a4f746e696','2026-05-06 14:28:14','2026-05-06 14:28:17'),(42,50,'xendit','pending','69fbb530171632a4f746e97e','order-50',150000,NULL,NULL,'https://checkout-staging.xendit.co/web/69fbb530171632a4f746e97e','2026-05-06 14:39:59','2026-05-06 14:40:02'),(43,51,'now','pending',NULL,NULL,150000,NULL,NULL,NULL,'2026-05-06 14:40:03','2026-05-06 14:40:03'),(44,52,'xendit','pending','69fbb6c4171632a4f746eb3b','order-52',150000,NULL,NULL,'https://checkout-staging.xendit.co/web/69fbb6c4171632a4f746eb3b','2026-05-06 14:46:43','2026-05-06 14:46:46'),(45,53,'xendit','pending','69fbb87a171632a4f746ecd2','order-53-54',160000,NULL,NULL,'https://checkout-staging.xendit.co/web/69fbb87a171632a4f746ecd2','2026-05-06 14:54:01','2026-05-06 14:54:04'),(46,54,'xendit','pending','69fbb87a171632a4f746ecd2','order-53-54',120000,NULL,NULL,'https://checkout-staging.xendit.co/web/69fbb87a171632a4f746ecd2','2026-05-06 14:54:01','2026-05-06 14:54:04'),(47,55,'later','pending',NULL,NULL,160000,NULL,NULL,NULL,'2026-05-06 20:17:15','2026-05-06 20:17:15'),(48,56,'xendit','pending','69fc06887f2c88af2d760053','order-56',160000,NULL,NULL,'https://checkout-staging.xendit.co/web/69fc06887f2c88af2d760053','2026-05-06 20:27:04','2026-05-06 20:27:07'),(49,57,'xendit','pending','69fc08b07f2c88af2d760408','order-57',190000,NULL,NULL,'https://checkout-staging.xendit.co/web/69fc08b07f2c88af2d760408','2026-05-06 20:36:16','2026-05-06 20:36:18'),(50,58,'xendit','pending','69ff47a8171632a4f74bf8bc','order-58',120000,NULL,NULL,'https://checkout-staging.xendit.co/web/69ff47a8171632a4f74bf8bc','2026-05-09 07:41:42','2026-05-09 07:41:45'),(51,59,'xendit','pending','69ffdd177f2c88af2d7b4a10','order-59',190000,NULL,NULL,'https://checkout-staging.xendit.co/web/69ffdd177f2c88af2d7b4a10','2026-05-09 18:19:19','2026-05-09 18:19:21'),(52,60,'xendit','pending','69ffe1f57f2c88af2d7b4f52','order-60-61',160000,NULL,NULL,'https://checkout-staging.xendit.co/web/69ffe1f57f2c88af2d7b4f52','2026-05-09 18:40:04','2026-05-09 18:40:07'),(53,61,'xendit','pending','69ffe1f57f2c88af2d7b4f52','order-60-61',150000,NULL,NULL,'https://checkout-staging.xendit.co/web/69ffe1f57f2c88af2d7b4f52','2026-05-09 18:40:05','2026-05-09 18:40:07'),(54,62,'later','pending',NULL,NULL,270000,NULL,NULL,NULL,'2026-05-09 18:46:49','2026-05-09 18:46:49'),(55,63,'xendit','pending','6a03ceac0168694c2c2abb7e','order-63',70000,NULL,NULL,'https://checkout-staging.xendit.co/web/6a03ceac0168694c2c2abb7e','2026-05-12 18:06:51','2026-05-12 18:06:54'),(56,64,'xendit','pending','6a03e99eb30934f497e5accb','order-64',220000,NULL,NULL,'https://checkout-staging.xendit.co/web/6a03e99eb30934f497e5accb','2026-05-12 20:01:48','2026-05-12 20:01:52'),(57,65,'now','pending',NULL,NULL,160000,NULL,NULL,NULL,'2026-05-12 20:09:58','2026-05-12 20:09:58'),(58,66,'xendit','pending','6a03ec78b30934f497e5b1b3','order-66',160000,NULL,NULL,'https://checkout-staging.xendit.co/web/6a03ec78b30934f497e5b1b3','2026-05-12 20:13:59','2026-05-12 20:14:02'),(59,67,'xendit','pending','6a03f259b30934f497e5bded','order-67',50000,NULL,NULL,'https://checkout-staging.xendit.co/web/6a03f259b30934f497e5bded','2026-05-12 20:39:04','2026-05-12 20:39:06'),(60,68,'xendit','pending','6a03f546b30934f497e5c363','order-68',70000,NULL,NULL,'https://checkout-staging.xendit.co/web/6a03f546b30934f497e5c363','2026-05-12 20:51:33','2026-05-12 20:51:35'),(61,69,'xendit','pending','6a03f6cc0168694c2c2afe99','order-69',120000,NULL,NULL,'https://checkout-staging.xendit.co/web/6a03f6cc0168694c2c2afe99','2026-05-12 20:58:03','2026-05-12 20:58:05'),(62,70,'xendit','pending','6a03fb340168694c2c2b0686','order-70',50000,NULL,NULL,'https://checkout-staging.xendit.co/web/6a03fb340168694c2c2b0686','2026-05-12 21:16:51','2026-05-12 21:16:53'),(63,71,'xendit','pending','6a03fc9cb30934f497e5d04e','order-71',200000,NULL,NULL,'https://checkout-staging.xendit.co/web/6a03fc9cb30934f497e5d04e','2026-05-12 21:22:51','2026-05-12 21:22:53'),(64,72,'xendit','pending','6a03ff57b30934f497e5d542','order-72',70000,NULL,NULL,'https://checkout-staging.xendit.co/web/6a03ff57b30934f497e5d542','2026-05-12 21:34:29','2026-05-12 21:34:32'),(65,73,'xendit','pending','6a0400040168694c2c2b0ed9','order-73',70000,NULL,NULL,'https://checkout-staging.xendit.co/web/6a0400040168694c2c2b0ed9','2026-05-12 21:37:23','2026-05-12 21:37:25'),(66,74,'xendit','paid','6a0405880168694c2c2b1859','order-74',70000,'2026-05-12 22:01:05',NULL,'https://checkout-staging.xendit.co/web/6a0405880168694c2c2b1859','2026-05-12 22:00:54','2026-05-12 22:01:05'),(67,75,'xendit','paid','6a0521deb30934f497e76a45','order-75',90000,'2026-05-14 00:14:54',NULL,'https://checkout-staging.xendit.co/web/6a0521deb30934f497e76a45','2026-05-13 18:14:06','2026-05-14 00:14:54'),(68,76,'xendit','paid','6a05252ab30934f497e76e62','order-76',70000,'2026-05-14 06:28:53',NULL,'https://checkout-staging.xendit.co/web/6a05252ab30934f497e76e62','2026-05-13 18:28:10','2026-05-14 06:28:53'),(69,77,'later','pending',NULL,NULL,90000,NULL,NULL,NULL,'2026-05-13 18:32:27','2026-05-13 18:32:27'),(70,78,'xendit','paid','6a05310d0168694c2c2cb84e','order-78',90000,'2026-05-13 22:19:52',NULL,'https://checkout-staging.xendit.co/web/6a05310d0168694c2c2cb84e','2026-05-13 19:18:53','2026-05-13 22:19:52'),(71,79,'xendit','paid','6a0531dbb30934f497e77f68','order-79',90000,'2026-05-13 22:22:53',NULL,'https://checkout-staging.xendit.co/web/6a0531dbb30934f497e77f68','2026-05-13 19:22:19','2026-05-13 22:22:53'),(72,80,'xendit','paid','6a0532c9b30934f497e78059','order-80',70000,'2026-05-13 22:26:54',NULL,'https://checkout-staging.xendit.co/web/6a0532c9b30934f497e78059','2026-05-13 19:26:17','2026-05-13 22:26:54'),(73,81,'xendit','paid','6a053361b30934f497e7812c','order-81',250000,'2026-05-13 22:29:52',NULL,'https://checkout-staging.xendit.co/web/6a053361b30934f497e7812c','2026-05-13 19:28:47','2026-05-13 22:29:52'),(74,82,'xendit','pending','6a053363b30934f497e78133','order-82',250000,NULL,NULL,'https://checkout-staging.xendit.co/web/6a053363b30934f497e78133','2026-05-13 19:28:47','2026-05-13 19:28:53'),(75,83,'xendit','paid','6a05340f0168694c2c2cbc3b','order-83',220000,'2026-05-13 22:32:53',NULL,'https://checkout-staging.xendit.co/web/6a05340f0168694c2c2cbc3b','2026-05-13 19:31:42','2026-05-13 22:32:53'),(76,84,'now','pending',NULL,NULL,220000,NULL,NULL,NULL,'2026-05-13 19:31:46','2026-05-13 19:31:46'),(77,85,'xendit','paid','6a0534ca0168694c2c2cbcfa','order-85',160000,'2026-05-13 22:35:54',NULL,'https://checkout-staging.xendit.co/web/6a0534ca0168694c2c2cbcfa','2026-05-13 19:34:50','2026-05-13 22:35:54'),(78,86,'xendit','paid','6a05356e0168694c2c2cbdd0','order-86',120000,'2026-05-14 07:37:53',NULL,'https://checkout-staging.xendit.co/web/6a05356e0168694c2c2cbdd0','2026-05-13 19:37:34','2026-05-14 07:37:53'),(79,87,'xendit','paid','6a054a540168694c2c2cdac4','order-87',220000,'2026-05-14 00:07:52',NULL,'https://checkout-staging.xendit.co/web/6a054a540168694c2c2cdac4','2026-05-13 21:06:44','2026-05-14 00:07:52'),(80,88,'xendit','paid','6a054ad3b30934f497e7a1ab','order-88',200000,'2026-05-14 00:09:53',NULL,'https://checkout-staging.xendit.co/web/6a054ad3b30934f497e7a1ab','2026-05-13 21:08:51','2026-05-14 00:09:53'),(81,89,'xendit','paid','6a054b32b30934f497e7a21d','order-89',200000,'2026-05-14 00:10:52',NULL,'https://checkout-staging.xendit.co/web/6a054b32b30934f497e7a21d','2026-05-13 21:10:26','2026-05-14 00:10:52'),(82,90,'xendit','paid','6a05582a0168694c2c2ced0a','order-90',90000,'2026-05-13 22:05:55',NULL,'https://checkout-staging.xendit.co/web/6a05582a0168694c2c2ced0a','2026-05-13 22:05:45','2026-05-13 22:05:55'),(83,91,'now','pending',NULL,NULL,90000,NULL,NULL,NULL,'2026-05-13 22:05:49','2026-05-13 22:05:49'),(84,92,'xendit','paid','6a055962b30934f497e7b4c7','order-92',90000,'2026-05-13 22:11:11',NULL,'https://checkout-staging.xendit.co/web/6a055962b30934f497e7b4c7','2026-05-13 22:10:58','2026-05-13 22:11:11'),(85,93,'xendit','paid','6a05fc9d0168694c2c2dc4c1','order-93-94',100000,'2026-05-14 09:47:40',NULL,'https://checkout-staging.xendit.co/web/6a05fc9d0168694c2c2dc4c1','2026-05-14 09:47:24','2026-05-14 09:47:40'),(86,94,'xendit','pending','6a05fc9d0168694c2c2dc4c1','order-93-94',140000,NULL,NULL,'https://checkout-staging.xendit.co/web/6a05fc9d0168694c2c2dc4c1','2026-05-14 09:47:24','2026-05-14 09:47:26'),(87,95,'xendit','paid','6a05ffebb30934f497e890e8','order-95',110000,'2026-05-14 10:01:39',NULL,'https://checkout-staging.xendit.co/web/6a05ffebb30934f497e890e8','2026-05-14 09:50:14','2026-05-14 10:01:39'),(88,96,'later','pending',NULL,NULL,70000,NULL,NULL,NULL,'2026-05-14 09:50:14','2026-05-14 09:50:14'),(89,97,'xendit','paid','6a05fedd0168694c2c2dc756','order-97',420000,'2026-05-14 09:57:13',NULL,'https://checkout-staging.xendit.co/web/6a05fedd0168694c2c2dc756','2026-05-14 09:57:01','2026-05-14 09:57:13'),(90,98,'xendit','paid','6a06005cb30934f497e89172','order-98-99',180000,'2026-05-14 10:03:35',NULL,'https://checkout-staging.xendit.co/web/6a06005cb30934f497e89172','2026-05-14 10:03:23','2026-05-14 10:03:35'),(91,99,'xendit','pending','6a06005cb30934f497e89172','order-98-99',200000,NULL,NULL,'https://checkout-staging.xendit.co/web/6a06005cb30934f497e89172','2026-05-14 10:03:24','2026-05-14 10:03:26'),(92,100,'xendit','paid','6a0600f7b30934f497e89230','order-100-101-102',100000,'2026-05-14 10:06:09',NULL,'https://checkout-staging.xendit.co/web/6a0600f7b30934f497e89230','2026-05-14 10:05:58','2026-05-14 10:06:09'),(93,101,'xendit','pending','6a0600f7b30934f497e89230','order-100-101-102',90000,NULL,NULL,'https://checkout-staging.xendit.co/web/6a0600f7b30934f497e89230','2026-05-14 10:05:58','2026-05-14 10:06:01'),(94,102,'xendit','pending','6a0600f7b30934f497e89230','order-100-101-102',120000,NULL,NULL,'https://checkout-staging.xendit.co/web/6a0600f7b30934f497e89230','2026-05-14 10:05:59','2026-05-14 10:06:01'),(95,103,'xendit','paid','6a0603ff0168694c2c2dcea1','order-103',300000,'2026-05-14 10:19:04',NULL,'https://checkout-staging.xendit.co/web/6a0603ff0168694c2c2dcea1','2026-05-14 10:18:54','2026-05-14 10:19:04'),(96,104,'xendit','paid','6a060460b30934f497e89695','order-104',350000,'2026-05-14 10:20:42',NULL,'https://checkout-staging.xendit.co/web/6a060460b30934f497e89695','2026-05-14 10:20:20','2026-05-14 10:20:42'),(97,105,'now','pending',NULL,NULL,90000,NULL,NULL,NULL,'2026-05-14 10:24:23','2026-05-14 10:24:23'),(98,106,'now','pending',NULL,NULL,120000,NULL,NULL,NULL,'2026-05-14 10:24:23','2026-05-14 10:24:23'),(99,107,'now','pending',NULL,NULL,90000,NULL,NULL,NULL,'2026-05-14 10:26:29','2026-05-14 10:26:29'),(100,108,'now','pending',NULL,NULL,90000,NULL,NULL,NULL,'2026-05-14 10:26:30','2026-05-14 10:26:30'),(101,109,'now','pending',NULL,NULL,90000,NULL,NULL,NULL,'2026-05-14 10:27:10','2026-05-14 10:27:10'),(102,110,'xendit','paid','6a060892b30934f497e89b9b','order-110',90000,'2026-05-14 10:38:33',NULL,'https://checkout-staging.xendit.co/web/6a060892b30934f497e89b9b','2026-05-14 10:27:11','2026-05-14 10:38:33'),(103,111,'xendit','paid','6a06062eb30934f497e89882','order-111',160000,'2026-05-14 10:43:53',NULL,'https://checkout-staging.xendit.co/web/6a06087cb30934f497e89b7d','2026-05-14 10:28:14','2026-05-14 10:43:53'),(104,112,'xendit','paid','6a06085eb30934f497e89b49','order-112-113',160000,'2026-05-14 10:37:46',NULL,'https://checkout-staging.xendit.co/web/6a06085eb30934f497e89b49','2026-05-14 10:37:33','2026-05-14 10:37:46'),(105,113,'xendit','paid','6a06085eb30934f497e89b49','order-112-113',160000,'2026-05-14 10:37:46',NULL,'https://checkout-staging.xendit.co/web/6a06085eb30934f497e89b49','2026-05-14 10:37:33','2026-05-14 10:37:46'),(106,114,'xendit','pending','6a06bbcbb30934f497e988fc','order-114',90000,NULL,NULL,'https://checkout-staging.xendit.co/web/6a06bbcbb30934f497e988fc','2026-05-14 23:23:06','2026-05-14 23:23:11'),(107,115,'xendit','pending','6a06bbd0b30934f497e98900','order-115',90000,NULL,NULL,'https://checkout-staging.xendit.co/web/6a06bbd0b30934f497e98900','2026-05-14 23:23:12','2026-05-14 23:23:14'),(109,117,'xendit','pending','6a06bf160168694c2c2ec713','order-117',130000,NULL,NULL,'https://checkout-staging.xendit.co/web/6a06bf160168694c2c2ec713','2026-05-14 23:37:07','2026-05-14 23:37:12'),(110,118,'xendit','pending','6a06bf1ab30934f497e98f25','order-118',130000,NULL,NULL,'https://checkout-staging.xendit.co/web/6a06bf1ab30934f497e98f25','2026-05-14 23:37:13','2026-05-14 23:37:16'),(111,119,'xendit','pending','6a06d60c0168694c2c2eee6c','order-119',190000,NULL,NULL,'https://checkout-staging.xendit.co/web/6a06d60c0168694c2c2eee6c','2026-05-15 01:15:08','2026-05-15 01:15:11');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (1,'App\\Models\\User',2,'auth_token','3709f4e264e9b48278e81192893ad166d042b292ff6e8e116c3966afd2b266b7','[\"*\"]',NULL,NULL,'2026-05-07 00:02:41','2026-05-07 00:02:41'),(2,'App\\Models\\User',2,'auth_token','5f1f19b06fd6aa96cdeb081a9e624a0724f56dbcb73a1f60dac9a0c369c2ac5d','[\"*\"]',NULL,NULL,'2026-05-09 00:59:57','2026-05-09 00:59:57'),(3,'App\\Models\\User',2,'auth_token','45622fdfc1d8b41667dbedddc5edddc4600fcb928edfcfdc574384c229dda562','[\"*\"]',NULL,NULL,'2026-05-09 01:49:09','2026-05-09 01:49:09'),(4,'App\\Models\\User',2,'auth_token','02a0fe89a27ef197d2dc80affbd7bb36443322e878813c0a3f91f64a3da95688','[\"*\"]',NULL,NULL,'2026-05-09 04:22:49','2026-05-09 04:22:49'),(5,'App\\Models\\User',2,'auth_token','01a26386367b8622b040669df8bda2f532c374f54e8471b2a9e42046ca839cf5','[\"*\"]','2026-05-09 22:19:26',NULL,'2026-05-09 05:43:48','2026-05-09 22:19:26'),(6,'App\\Models\\User',2,'auth_token','bb338f419ad0c7c0607c575a593870acaf5704b879ee28908568293fa935ffb3','[\"*\"]','2026-05-09 22:29:59',NULL,'2026-05-09 22:19:34','2026-05-09 22:29:59'),(7,'App\\Models\\User',2,'auth_token','5d1a632cb38358f1453996c3067d1abc5932467e3c207a85995f0fde5bd298a0','[\"*\"]','2026-05-15 01:16:30',NULL,'2026-05-09 22:30:09','2026-05-15 01:16:30'),(8,'App\\Models\\User',3,'auth_token','a6abfc33fcc20517c45a2a03502d0a8cbb176da22c4a18e3e105eea469f3fde0','[\"*\"]','2026-05-14 10:48:13',NULL,'2026-05-14 07:20:58','2026-05-14 10:48:13');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `price` int NOT NULL,
  `category_id` bigint unsigned NOT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `character_required` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (2,'headshot','A headshot commission that focuses closely on the character’s face and expression. Ideal for profile pictures, avatars, social media icons, or simple character portraits. The artwork highlights eyes, hairstyle, emotion, and soft coloring to create a charming and expressive anime styled illustration',70000,1,'/storage/products/O0VhX7VcSGR8oPtuyRaIBfOpLmhGxh9HW9anM61P.png',1,'2026-04-08 22:22:48','2026-05-14 09:00:45',1),(4,'bust-up','A bust-up commission focused on facial expressions, hairstyle, and upper body details. Perfect for profile pictures, icons, VTuber references, or simple character illustrations with clean presentation. This style emphasizes expression, emotion, and soft anime rendering while keeping the composition elegant and minimal',70000,1,'/storage/products/Q2FI4pO52cOlA0ylHedzJUMD38NL1Kh4fCOrQ9PI.png',1,'2026-04-15 20:34:03','2026-05-14 08:59:55',1),(5,'full-body','A full-body commission that fully showcases your character from head to toe. Recommended for detailed outfit designs, fantasy characters, game characters, or original concepts that require complete visibility of the costume and accessories. This commission includes dynamic posing and detailed rendering for a more complete artwork presentation',200000,1,'/storage/products/mz6I8mtiEGRqyDTeWB54lBK9plFaZEyMw9f1wPoJ.png',1,'2026-04-15 20:37:29','2026-05-14 21:54:43',1),(6,'thigh-up','A thigh-up commission that provides more space for pose, outfit details, and character personality. This type is ideal for showcasing fashion designs, dynamic poses, accessories, or elegant character expressions while still keeping the artwork clean and focused on the character',140000,1,'/storage/products/AydKAJg7mIGjkGDVK78mqmWAx3hfzz8g6rdDarVm.png',1,'2026-04-15 20:38:21','2026-05-14 08:58:33',1),(7,'half-body','A half-body commission with balanced composition between character details and expressive posing. Great for profile illustrations, original characters, fanart, or social media displays. The artwork highlights facial expressions, upper body movement, and costume details with a polished anime style finish.',110000,1,'/storage/products/wycD8l1IeKqYHi6vjllDfjfTqZJwFtHuiuaLorHY.png',1,'2026-04-15 20:39:23','2026-05-14 08:57:16',1),(8,'couple-ych','A couple themed YCH commission made for two characters in one artwork. Suitable for partners, friends, original characters, or favorite ships from anime and games. The composition focuses on chemistry, matching expressions, and warm interactions while keeping the artwork soft, colorful, and visually balanced.',400000,2,'/storage/products/uDJ1e6hNPCvT5Y8H1qCk62eeWvFwXYEsuHUVmiAi.png',1,'2026-04-15 20:39:55','2026-05-14 08:53:33',2),(9,'idol-ych','An idol inspired YCH commission designed with a bright stage performance aesthetic. Your character will be illustrated in a stylish idol outfit with energetic expressions, sparkling details, and a colorful anime atmosphere. Perfect for VTubers, original characters, fan characters, or anyone who wants a cheerful and performance themed illustration',150000,2,'/storage/products/W5ffE9CIByC10GuP4hIukYLa0yOkEgKw6w9nY3tf.png',1,'2026-04-15 20:40:32','2026-05-14 08:52:06',1),(10,'halloween-ych','A special Halloween themed YCH commission with a cute and playful atmosphere. Perfect for original characters, anime fan characters, or matching couple concepts with spooky costumes, pumpkins, witches, ghosts, and other seasonal accessories. This commission focuses on expressive poses, colorful details, and a soft anime art style that keeps the artwork charming rather than scary',200000,2,'/storage/products/IyqYx4Z9tF3FrNOYaYCHFMshSAAw8y3Qz9tEVnYi.png',1,'2026-04-19 03:14:59','2026-05-14 08:50:20',1),(11,'chibi','A chibi style commission featuring your character in a cute super deformed anime style with oversized expressions, simplified proportions, and colorful details. Perfect for profile pictures, stickers, emotes, keychains, VTuber mascots, or original characters. The artwork focuses on charm, playful poses, and soft anime rendering that gives the character an adorable and lively appearance',80000,1,'/storage/products/immj3nRfpX5LBW3M5sbBJUkkNnbjywQdRNhDkrvc.png',1,'2026-05-14 09:03:29','2026-05-14 09:03:29',1),(12,'chibi-couple','A couple chibi commission designed for two characters in an adorable matching chibi style illustration. Suitable for couples, friends, original characters, VTuber duos, or favorite anime ships. The artwork emphasizes chemistry, cute interactions, matching outfits or poses, and a cheerful anime atmosphere while keeping the composition compact, expressive, and visually balanced',150000,1,'/storage/products/WOXEyGF21Rb5Pyv4U3OyBOfTGtx6ptwdhyze9e1t.png',1,'2026-05-14 09:05:17','2026-05-14 09:11:09',2);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('D3VAiYXcIhltoqog9JfOhBo05sqAKAH9qrXqXWlX',4,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36','eyJfdG9rZW4iOiJWMG1zU0ZjR2FMdXUza3NMdEk5VGFqYjBhRllPMlg3clVLc2NMR3hhIiwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119LCJfcHJldmlvdXMiOnsidXJsIjoiaHR0cDpcL1wvMTI3LjAuMC4xOjgwMDBcL2FkbWluXC90ZXN0aW1vbmlhbHNcLzEiLCJyb3V0ZSI6ImZpbGFtZW50LmFkbWluLnJlc291cmNlcy50ZXN0aW1vbmlhbHMudmlldyJ9LCJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI6NCwicGFzc3dvcmRfaGFzaF93ZWIiOiI1YzVkN2I1ZTk0NjJhZTA0MDZkMjU4NDRlYzdlNDU3MjI5MDE4OGU4ODI2NWUzZDRjMjUwY2I1MDhjOWQ0ZDcyIiwidGFibGVzIjp7IjczMWQ5MDQwYmZhNDkyNzI4N2EwMWFhMDFmN2NlOTMyX2NvbHVtbnMiOlt7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoidG90YWxfc2xvdHMiLCJsYWJlbCI6IlRvdGFsIHNsb3RzIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6InJlbWFpbmluZ19zbG90cyIsImxhYmVsIjoiUmVtYWluaW5nIHNsb3RzIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6ImNyZWF0ZWRfYXQiLCJsYWJlbCI6IkNyZWF0ZWQgYXQiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6ZmFsc2UsImlzVG9nZ2xlYWJsZSI6dHJ1ZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0Ijp0cnVlfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoidXBkYXRlZF9hdCIsImxhYmVsIjoiVXBkYXRlZCBhdCIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjpmYWxzZSwiaXNUb2dnbGVhYmxlIjp0cnVlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOnRydWV9XSwiZGRjMWQwOGViZWZhNjUyMjkwM2FiMWYzN2MzY2I4YWNfY29sdW1ucyI6W3sidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJpZCIsImxhYmVsIjoiSWQiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoibmFtZSIsImxhYmVsIjoiTmFtZSIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJjcmVhdGVkX2F0IiwibGFiZWwiOiJDcmVhdGVkIGF0IiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH1dLCJlNzkzYTI3OWQ1NmU0NTA2MDk3NTQwMjBkNjI3YmVlY19jb2x1bW5zIjpbeyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6Im9yZGVyX2lkIiwibGFiZWwiOiJJRCIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJjdXN0b21lcl9uYW1lIiwibGFiZWwiOiJDdXN0b21lciBuYW1lIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6InByb2R1Y3QubmFtZSIsImxhYmVsIjoiUHJvZHVjdCIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJxdWFudGl0eSIsImxhYmVsIjoiUXVhbnRpdHkiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoidG90YWxfcHJpY2UiLCJsYWJlbCI6IlRvdGFsIHByaWNlIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6InN0YXR1cyIsImxhYmVsIjoiU3RhdHVzIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6InBheW1lbnQucGF5bWVudF9zdGF0dXMiLCJsYWJlbCI6IlBheW1lbnQiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoicHJvZ3Jlc3Nfc3RhZ2UiLCJsYWJlbCI6IlByb2dyZXNzIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6ImNyZWF0ZWRfYXQiLCJsYWJlbCI6IkNyZWF0ZWQgYXQiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfV0sImU3OTNhMjc5ZDU2ZTQ1MDYwOTc1NDAyMGQ2MjdiZWVjX3Blcl9wYWdlIjoiNTAiLCI4ZmFjNmViMWNlYzI2ODAzYjNmN2ZiNDQwYTI3MTExYl9jb2x1bW5zIjpbeyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6ImltYWdlX3VybCIsImxhYmVsIjoiSW1hZ2UiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoibmFtZSIsImxhYmVsIjoiTmFtZSIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJjYXRlZ29yeS5uYW1lIiwibGFiZWwiOiJDYXRlZ29yeSIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJwcmljZSIsImxhYmVsIjoiUHJpY2UiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoiY2hhcmFjdGVyX3JlcXVpcmVkIiwibGFiZWwiOiJDaGFyYWN0ZXIiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoiaXNfYWN0aXZlIiwibGFiZWwiOiJPcGVuIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6ImNyZWF0ZWRfYXQiLCJsYWJlbCI6IkNyZWF0ZWQgYXQiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfV0sIjZjNDQ0MzI0MmNhMjcxM2M0N2ExZmNiMDAwNjJiNWQzX2NvbHVtbnMiOlt7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoib3JkZXJfaWQiLCJsYWJlbCI6Ik9yZGVyIGlkIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6InVzZXJfaWQiLCJsYWJlbCI6IlVzZXIgaWQiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoicmF0aW5nIiwibGFiZWwiOiJSYXRpbmciLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoic2hvd191c2VybmFtZSIsImxhYmVsIjoiU2hvdyB1c2VybmFtZSIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJjcmVhdGVkX2F0IiwibGFiZWwiOiJDcmVhdGVkIGF0IiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOmZhbHNlLCJpc1RvZ2dsZWFibGUiOnRydWUsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6dHJ1ZX0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6InVwZGF0ZWRfYXQiLCJsYWJlbCI6IlVwZGF0ZWQgYXQiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6ZmFsc2UsImlzVG9nZ2xlYWJsZSI6dHJ1ZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0Ijp0cnVlfV19fQ==',1778833165);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testimonials`
--

DROP TABLE IF EXISTS `testimonials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `testimonials` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `rating` int NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `show_username` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testimonials`
--

LOCK TABLES `testimonials` WRITE;
/*!40000 ALTER TABLE `testimonials` DISABLE KEYS */;
INSERT INTO `testimonials` VALUES (1,89,2,5,'Absolutely amazing artwork and very detailed result! The artist was super friendly and followed all of my requests perfectly. Highly recommended!',1,'2026-05-14 05:50:09','2026-05-14 05:50:09'),(2,87,2,4,'I really love the final result. The coloring and background are beautiful, and the communication during the progress was very clear.',1,'2026-05-14 05:58:11','2026-05-14 05:58:11'),(3,88,2,5,'Super satisfied with this commission! The artist understood my character design perfectly and delivered exactly what I imagined.',1,'2026-05-14 05:59:05','2026-05-14 05:59:05'),(4,83,2,5,'The artwork quality is incredible. Fast response, smooth process, and very professional overall.',1,'2026-05-14 05:59:49','2026-05-14 05:59:49'),(5,86,2,4,'Beautiful art style and amazing attention to detail. Thank you so much for bringing my character to life!',1,'2026-05-14 06:00:48','2026-05-14 06:00:48'),(6,81,2,4,'One of the best commission experiences I’ve had. Every stage update was clear and the final art exceeded my expectations.',0,'2026-05-14 06:10:13','2026-05-14 06:10:13'),(7,92,2,5,'Everything was delivered exactly as requested. Amazing quality and worth every penny.',1,'2026-05-14 06:19:16','2026-05-14 06:19:16'),(8,91,2,3,'The artist paid attention to even the smallest details. I’m really happy with the final result.',0,'2026-05-14 06:19:41','2026-05-14 06:19:41');
/*!40000 ALTER TABLE `testimonials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_username_unique` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'','test user','test@gmail.com',NULL,'123456',NULL,NULL,NULL),(2,'LILY','uly','lily@gmail.com',NULL,'$2y$12$UiYOekC9V/eeSOBCJWxwu.rP0HZTuhYhehyi8g6cdCXE/NkSWntH6',NULL,'2026-05-07 00:02:25','2026-05-09 22:29:59'),(3,'kuki_miaw','kuki','kuki@gmail.com',NULL,'$2y$12$0Un2vtBiVFxRkv6UxnGlouyFF/GM7GRO9ZQEM2Hw8ynnwvK1e18HK',NULL,'2026-05-14 07:20:47','2026-05-14 10:39:51'),(4,NULL,'Admin','punyaais.mf@gmail.com',NULL,'$2y$12$JQFk7.64Qt/kcCVgLefh7u5BYEFeGkMMcAu.VNQpUngytZbjVo5UK','iiJceweIQDnn43nuiIpnSXARkvFT81GvYuEqFLBruxudGGj8CHwHOAD1wIT3','2026-05-14 21:25:59','2026-05-14 21:25:59');
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

-- Dump completed on 2026-05-15 16:57:20
