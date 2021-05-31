
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
DROP TABLE IF EXISTS `blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blocks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `blocks` WRITE;
/*!40000 ALTER TABLE `blocks` DISABLE KEYS */;
INSERT INTO `blocks` VALUES (15,'PMEC','2020-02-18 11:50:05','2020-02-18 11:50:05'),(16,'Narendrapur','2020-02-21 12:36:11','2020-02-21 12:36:11');
/*!40000 ALTER TABLE `blocks` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT '1',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_slug_unique` (`slug`),
  KEY `categories_parent_id_foreign` (`parent_id`),
  CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_name_unique` (`name`),
  UNIQUE KEY `category_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (10,'PMEC Specials','pmec-specials','2020-02-13 02:54:07','2020-02-13 02:54:07');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `category_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned DEFAULT NULL,
  `category_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_product_product_id_foreign` (`product_id`),
  KEY `category_product_category_id_foreign` (`category_id`),
  CONSTRAINT `category_product_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE,
  CONSTRAINT `category_product_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=251 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `category_product` WRITE;
/*!40000 ALTER TABLE `category_product` DISABLE KEYS */;
INSERT INTO `category_product` VALUES (249,87,10,'2020-02-28 13:25:42','2020-02-28 13:25:42'),(250,86,10,'2020-02-28 13:25:59','2020-02-28 13:25:59');
/*!40000 ALTER TABLE `category_product` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `coupons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` int(11) DEFAULT NULL,
  `percent_off` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `coupons_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `coupons` WRITE;
/*!40000 ALTER TABLE `coupons` DISABLE KEYS */;
INSERT INTO `coupons` VALUES (3,'off20','percent',NULL,20,'2019-11-28 02:13:26','2019-11-28 02:24:00');
/*!40000 ALTER TABLE `coupons` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `data_rows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_rows` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data_type_id` int(10) unsigned NOT NULL,
  `field` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `browse` tinyint(1) NOT NULL DEFAULT '1',
  `read` tinyint(1) NOT NULL DEFAULT '1',
  `edit` tinyint(1) NOT NULL DEFAULT '1',
  `add` tinyint(1) NOT NULL DEFAULT '1',
  `delete` tinyint(1) NOT NULL DEFAULT '1',
  `details` text COLLATE utf8_unicode_ci,
  `order` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `data_rows_data_type_id_foreign` (`data_type_id`),
  CONSTRAINT `data_rows_data_type_id_foreign` FOREIGN KEY (`data_type_id`) REFERENCES `data_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `data_rows` WRITE;
/*!40000 ALTER TABLE `data_rows` DISABLE KEYS */;
INSERT INTO `data_rows` VALUES (1,1,'id','number','ID',1,0,0,0,0,0,'\"\"',1),(2,1,'author_id','text','Author',1,0,1,1,0,1,'\"\"',2),(3,1,'category_id','text','Category',1,0,1,1,1,0,'\"\"',3),(4,1,'title','text','Title',1,1,1,1,1,1,'\"\"',4),(5,1,'excerpt','text_area','excerpt',1,0,1,1,1,1,'\"\"',5),(6,1,'body','rich_text_box','Body',1,0,1,1,1,1,'\"\"',6),(7,1,'image','image','Post Image',0,1,1,1,1,1,'\"{\\\"resize\\\":{\\\"width\\\":\\\"1000\\\",\\\"height\\\":\\\"null\\\"},\\\"quality\\\":\\\"70%\\\",\\\"upsize\\\":true,\\\"thumbnails\\\":[{\\\"name\\\":\\\"medium\\\",\\\"scale\\\":\\\"50%\\\"},{\\\"name\\\":\\\"small\\\",\\\"scale\\\":\\\"25%\\\"},{\\\"name\\\":\\\"cropped\\\",\\\"crop\\\":{\\\"width\\\":\\\"300\\\",\\\"height\\\":\\\"250\\\"}}]}\"',7),(8,1,'slug','text','slug',1,0,1,1,1,1,'\"{\\\"slugify\\\":{\\\"origin\\\":\\\"title\\\",\\\"forceUpdate\\\":true}}\"',8),(9,1,'meta_description','text_area','meta_description',1,0,1,1,1,1,'\"\"',9),(10,1,'meta_keywords','text_area','meta_keywords',1,0,1,1,1,1,'\"\"',10),(11,1,'status','select_dropdown','status',1,1,1,1,1,1,'\"{\\\"default\\\":\\\"DRAFT\\\",\\\"options\\\":{\\\"PUBLISHED\\\":\\\"published\\\",\\\"DRAFT\\\":\\\"draft\\\",\\\"PENDING\\\":\\\"pending\\\"}}\"',11),(12,1,'created_at','timestamp','created_at',0,1,1,0,0,0,'\"\"',12),(13,1,'updated_at','timestamp','updated_at',0,0,0,0,0,0,'\"\"',13),(14,2,'id','number','id',1,0,0,0,0,0,'\"\"',1),(15,2,'author_id','text','author_id',1,0,0,0,0,0,'\"\"',2),(16,2,'title','text','title',1,1,1,1,1,1,'\"\"',3),(17,2,'excerpt','text_area','excerpt',1,0,1,1,1,1,'\"\"',4),(18,2,'body','rich_text_box','body',1,0,1,1,1,1,'\"\"',5),(19,2,'slug','text','slug',1,0,1,1,1,1,'\"{\\\"slugify\\\":{\\\"origin\\\":\\\"title\\\"}}\"',6),(20,2,'meta_description','text','meta_description',1,0,1,1,1,1,'\"\"',7),(21,2,'meta_keywords','text','meta_keywords',1,0,1,1,1,1,'\"\"',8),(22,2,'status','select_dropdown','status',1,1,1,1,1,1,'\"{\\\"default\\\":\\\"INACTIVE\\\",\\\"options\\\":{\\\"INACTIVE\\\":\\\"INACTIVE\\\",\\\"ACTIVE\\\":\\\"ACTIVE\\\"}}\"',9),(23,2,'created_at','timestamp','created_at',1,1,1,0,0,0,'\"\"',10),(24,2,'updated_at','timestamp','updated_at',1,0,0,0,0,0,'\"\"',11),(25,2,'image','image','image',0,1,1,1,1,1,'\"\"',12),(26,3,'id','number','id',1,0,0,0,0,0,'\"\"',1),(27,3,'name','text','name',1,1,1,1,1,1,'\"\"',2),(28,3,'email','text','email',1,1,1,1,1,1,'\"\"',3),(29,3,'password','password','password',1,0,0,1,1,0,'\"\"',4),(30,3,'user_belongsto_role_relationship','relationship','Role',0,1,1,1,1,0,'{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsTo\",\"column\":\"role_id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"roles\",\"pivot\":\"0\",\"taggable\":\"0\"}',10),(31,3,'remember_token','text','remember_token',0,0,0,0,0,0,'\"\"',5),(32,3,'created_at','timestamp','created_at',0,1,1,0,0,0,'\"\"',6),(33,3,'updated_at','timestamp','updated_at',0,0,0,0,0,0,'\"\"',7),(34,3,'avatar','image','avatar',0,1,1,1,1,1,'\"\"',8),(35,5,'id','number','id',1,0,0,0,0,0,'\"\"',1),(36,5,'name','text','name',1,1,1,1,1,1,'\"\"',2),(37,5,'created_at','timestamp','created_at',0,0,0,0,0,0,'\"\"',3),(38,5,'updated_at','timestamp','updated_at',0,0,0,0,0,0,'\"\"',4),(39,4,'id','number','id',1,0,0,0,0,0,'\"\"',1),(40,4,'parent_id','select_dropdown','parent_id',0,0,1,1,1,1,'\"{\\\"default\\\":\\\"\\\",\\\"null\\\":\\\"\\\",\\\"options\\\":{\\\"\\\":\\\"-- None --\\\"},\\\"relationship\\\":{\\\"key\\\":\\\"id\\\",\\\"label\\\":\\\"name\\\"}}\"',2),(41,4,'order','text','order',1,1,1,1,1,1,'\"{\\\"default\\\":1}\"',3),(42,4,'name','text','name',1,1,1,1,1,1,'\"\"',4),(43,4,'slug','text','slug',1,1,1,1,1,1,'\"{\\\"slugify\\\":{\\\"origin\\\":\\\"name\\\"}}\"',5),(44,4,'created_at','timestamp','created_at',0,0,1,0,0,0,'\"\"',6),(45,4,'updated_at','timestamp','updated_at',0,0,0,0,0,0,'\"\"',7),(46,6,'id','number','id',1,0,0,0,0,0,'\"\"',1),(47,6,'name','text','Name',1,1,1,1,1,1,'\"\"',2),(48,6,'created_at','timestamp','created_at',0,0,0,0,0,0,'\"\"',3),(49,6,'updated_at','timestamp','updated_at',0,0,0,0,0,0,'\"\"',4),(50,6,'display_name','text','Display Name',1,1,1,1,1,1,'\"\"',5),(51,1,'seo_title','text','seo_title',0,1,1,1,1,1,'\"\"',14),(52,1,'featured','checkbox','featured',1,1,1,1,1,1,'\"\"',15),(53,3,'role_id','text','role_id',0,1,1,1,1,1,'\"\"',9),(54,3,'user_belongstomany_role_relationship','relationship','Roles',0,1,1,1,1,0,'{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsToMany\",\"column\":\"id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"user_roles\",\"pivot\":\"1\",\"taggable\":\"0\"}',11),(55,7,'id','hidden','Id',1,1,1,1,1,0,'\"\"',1),(56,7,'name','text','name',1,1,1,1,1,1,'\"{\\\"validation\\\":{\\\"rule\\\":\\\"max:100\\\"}}\"',2),(57,7,'slug','text','slug',1,1,1,1,1,1,'\"\"',3),(58,7,'details','text','Details',0,1,1,1,1,1,'\"\"',4),(59,7,'price','number','price',1,1,1,1,1,1,'\"{\\\"validation\\\":{\\\"rule\\\":\\\"required|regex:\\/^\\\\\\\\d*(\\\\\\\\.\\\\\\\\d{1,2})?$\\/\\\"}}\"',5),(60,7,'description','text','Description',1,1,1,1,1,1,'\"\"',6),(61,7,'featured','checkbox','Featured',1,1,1,1,1,1,'\"{\\\"on\\\":\\\"Yes\\\",\\\"off\\\":\\\"No\\\"}\"',7),(62,7,'image','image','Image',0,1,1,1,1,1,'null',8),(63,7,'images','multiple_images','Images',0,1,1,1,1,1,'\"\"',9),(64,7,'created_at','timestamp','Created At',0,1,1,1,1,1,'\"\"',10),(65,7,'updated_at','timestamp','Updated At',0,1,1,1,1,1,'\"\"',11),(66,7,'quantity','number','Quantity',1,1,1,1,1,1,'\"\"',8),(67,8,'id','hidden','Id',1,1,1,0,0,0,'\"\"',1),(68,8,'code','text','code',1,1,1,1,1,1,'\"\"',2),(69,8,'type','text','Type',1,1,1,1,1,1,'null',3),(70,8,'value','number','Value',0,1,1,1,1,1,'\"{\\\"null\\\":\\\"\\\"}\"',4),(71,8,'percent_off','number','Percent Off',0,1,1,1,1,1,'\"{\\\"null\\\":\\\"\\\"}\"',5),(72,8,'created_at','timestamp','Created At',0,0,1,0,0,0,'\"\"',6),(73,8,'updated_at','timestamp','Updated At',0,0,1,0,0,0,'\"\"',7),(74,9,'id','hidden','Id',1,1,1,0,0,0,'\"\"',1),(75,9,'name','text','Name',1,1,1,1,1,1,'\"\"',2),(76,9,'slug','text','Slug',1,1,1,1,1,1,'\"\"',3),(77,9,'created_at','timestamp','Created At',0,0,0,0,0,0,'\"\"',4),(78,9,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'\"\"',5),(79,10,'id','hidden','Id',1,0,0,0,0,0,'\"\"',1),(80,10,'product_id','number','Product Id',1,1,1,1,1,1,'\"\"',2),(81,10,'category_id','number','Category Id',1,1,1,1,1,1,'\"\"',3),(82,10,'created_at','timestamp','Created At',0,0,0,0,0,0,'\"\"',4),(83,10,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'\"\"',5),(84,11,'id','hidden','Id',1,1,1,0,0,0,'\"\"',1),(85,11,'user_id','number','User Id',0,1,1,0,0,0,'\"\"',2),(86,11,'billing_email','text','Billing Email',0,1,1,1,1,0,'\"\"',3),(87,11,'billing_name','text','Billing Name',0,1,1,1,1,0,'\"\"',4),(88,11,'billing_address','text','Billing Address',0,1,1,1,1,0,'\"\"',5),(89,11,'billing_city','text','Billing City',0,1,1,1,1,0,'\"\"',6),(90,11,'billing_province','text','Billing Province',0,0,1,1,1,0,'\"\"',7),(91,11,'billing_postalcode','text','Billing Postalcode',0,0,1,1,1,0,'\"\"',8),(92,11,'billing_phone','text','Billing Phone',0,0,1,1,1,0,'\"\"',9),(93,11,'billing_name_on_card','text','Billing Name On Card',0,1,1,1,1,0,'\"\"',10),(94,11,'billing_discount','number','Discount',1,1,1,0,0,0,'\"\"',11),(95,11,'billing_discount_code','text','Discount Code',0,0,1,0,0,0,'\"\"',12),(96,11,'billing_subtotal','number','Subtotal',1,1,1,0,0,0,'\"\"',13),(97,11,'billing_tax','number','Tax',1,1,1,0,0,0,'\"\"',14),(98,11,'billing_total','number','Total',1,1,1,0,0,0,'\"\"',15),(99,11,'payment_gateway','text','Payment Gateway',1,1,1,1,1,0,'\"\"',16),(100,11,'shipped','checkbox','Shipped',1,1,1,1,0,0,'\"{\\\"on\\\":\\\"Yes\\\",\\\"off\\\":\\\"No\\\"}\"',17),(101,11,'error','text','Error',0,1,1,0,0,0,'\"\"',18),(102,11,'created_at','timestamp','Created At',0,0,0,0,0,0,'\"\"',19),(103,11,'updated_at','timestamp','Updated At',0,0,0,0,0,0,'\"\"',20),(104,12,'id','hidden','Id',1,1,1,1,1,0,'{}',1),(105,12,'name','text','Name',1,1,1,1,1,1,'{}',2),(106,12,'email','text','Email',1,1,1,1,1,1,'{}',3),(107,12,'created_at','timestamp','Created At',0,1,1,0,0,0,'{}',4),(108,12,'updated_at','timestamp','Updated At',0,1,1,0,0,0,'{}',5),(109,3,'dp','image','Dp',0,1,1,1,1,1,'{}',3),(110,3,'phone','number','Phone',0,1,1,1,1,1,'{}',7),(111,3,'address','text','Address',0,1,1,1,1,1,'{}',8),(112,3,'city','text','City',0,1,1,1,1,1,'{}',9),(113,3,'state','text','State',0,1,1,1,1,1,'{}',10),(114,3,'pin_code','text','Pin Code',0,1,1,1,1,1,'{}',11),(115,3,'wallet','text','Wallet',0,1,1,1,1,1,'{}',13),(116,3,'referred','text','Referred',1,1,1,1,1,1,'{}',14),(117,3,'settings','text','Settings',0,1,1,1,1,1,'{}',16),(118,13,'id','text','Id',1,1,1,0,0,0,'{}',1),(119,13,'name','text','Name',1,1,1,1,1,1,'{}',2),(120,13,'created_at','timestamp','Created At',0,1,1,1,0,1,'{}',3),(121,13,'updated_at','timestamp','Updated At',0,1,1,1,0,1,'{}',4);
/*!40000 ALTER TABLE `data_rows` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `data_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `display_name_singular` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `display_name_plural` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `icon` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `policy_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `controller` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `generate_permissions` tinyint(1) NOT NULL DEFAULT '0',
  `server_side` tinyint(4) NOT NULL DEFAULT '0',
  `details` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `data_types_name_unique` (`name`),
  UNIQUE KEY `data_types_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `data_types` WRITE;
/*!40000 ALTER TABLE `data_types` DISABLE KEYS */;
INSERT INTO `data_types` VALUES (1,'posts','posts','Post','Posts','voyager-news','TCG\\Voyager\\Models\\Post','TCG\\Voyager\\Policies\\PostPolicy','','',1,0,NULL,'2019-07-17 06:04:37','2019-07-17 06:04:37'),(2,'pages','pages','Page','Pages','voyager-file-text','TCG\\Voyager\\Models\\Page',NULL,'','',1,0,NULL,'2019-07-17 06:04:37','2019-07-17 06:04:37'),(3,'users','users','User','Users','voyager-person','TCG\\Voyager\\Models\\User','TCG\\Voyager\\Policies\\UserPolicy','\\App\\Http\\Controllers\\Voyager\\UsersController',NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"desc\",\"default_search_key\":null,\"scope\":null}','2019-07-17 06:04:37','2019-07-20 05:42:35'),(4,'categories','categories','Category','Categories','voyager-categories','TCG\\Voyager\\Models\\Category',NULL,'','',1,0,NULL,'2019-07-17 06:04:37','2019-07-17 06:04:37'),(5,'menus','menus','Menu','Menus','voyager-list','TCG\\Voyager\\Models\\Menu',NULL,'','',1,0,NULL,'2019-07-17 06:04:37','2019-07-17 06:04:37'),(6,'roles','roles','Role','Roles','voyager-lock','TCG\\Voyager\\Models\\Role',NULL,'','',1,0,NULL,'2019-07-17 06:04:37','2019-07-17 06:04:37'),(7,'products','products','Product','Products','voyager-bag','App\\Product',NULL,'\\App\\Http\\Controllers\\Voyager\\ProductsController',NULL,1,1,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"desc\",\"default_search_key\":null,\"scope\":null}','2019-07-17 06:04:47','2019-11-29 01:31:01'),(8,'coupons','coupons','Coupon','Coupons','voyager-dollar','App\\Coupon',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"desc\",\"default_search_key\":null,\"scope\":null}','2019-07-17 06:04:47','2019-11-28 02:12:29'),(9,'category','category','Category','Categories','voyager-tag','App\\Category',NULL,'','',1,0,NULL,'2019-07-17 06:04:47','2019-07-17 06:04:47'),(10,'category-product','category-product','Category Product','Category Products','voyager-categories','App\\CategoryProduct',NULL,'','',1,0,NULL,'2019-07-17 06:04:47','2019-07-17 06:04:47'),(11,'orders','orders','Order','Orders','voyager-documentation','App\\Order',NULL,'\\App\\Http\\Controllers\\Voyager\\OrdersController',NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"desc\",\"default_search_key\":null,\"scope\":null}','2019-07-17 06:04:48','2019-07-20 14:45:11'),(12,'subscribe','subscribe','Subscribe','Subscribes','voyager-mail','App\\Subscriber',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}','2019-07-17 06:28:57','2019-07-17 06:28:57'),(13,'blocks','blocks','Block','Blocks',NULL,'App\\Block',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}','2019-11-18 04:55:02','2019-11-18 04:57:46');
/*!40000 ALTER TABLE `data_types` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `menu_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `menu_id` int(10) unsigned DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `target` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '_self',
  `icon_class` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `color` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `route` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parameters` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `menu_items_menu_id_foreign` (`menu_id`),
  CONSTRAINT `menu_items_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `menu_items` WRITE;
/*!40000 ALTER TABLE `menu_items` DISABLE KEYS */;
INSERT INTO `menu_items` VALUES (1,1,'Dashboard','','_self','voyager-boat',NULL,NULL,1,'2019-07-17 06:04:40','2019-07-17 06:04:40','voyager.dashboard',NULL),(2,1,'Media','','_self','voyager-images',NULL,NULL,10,'2019-07-17 06:04:40','2019-07-17 06:29:47','voyager.media.index',NULL),(3,1,'Posts','','_self','voyager-news',NULL,NULL,11,'2019-07-17 06:04:40','2019-07-17 06:29:47','voyager.posts.index',NULL),(4,1,'Users','','_self','voyager-person',NULL,NULL,9,'2019-07-17 06:04:40','2019-07-17 06:29:47','voyager.users.index',NULL),(5,1,'Categories','','_self','voyager-categories',NULL,NULL,16,'2019-07-17 06:04:40','2019-11-18 04:58:24','voyager.categories.index',NULL),(6,1,'Pages','','_self','voyager-file-text',NULL,NULL,12,'2019-07-17 06:04:40','2019-07-17 06:29:47','voyager.pages.index',NULL),(7,1,'Roles','','_self','voyager-lock',NULL,NULL,8,'2019-07-17 06:04:41','2019-07-17 06:29:47','voyager.roles.index',NULL),(8,1,'Tools','','_self','voyager-tools',NULL,NULL,14,'2019-07-17 06:04:41','2019-11-18 04:58:24',NULL,NULL),(9,1,'Menu Builder','','_self','voyager-list',NULL,8,1,'2019-07-17 06:04:41','2019-07-17 06:04:51','voyager.menus.index',NULL),(10,1,'Database','','_self','voyager-data',NULL,8,2,'2019-07-17 06:04:41','2019-07-17 06:04:51','voyager.database.index',NULL),(11,1,'Compass','','_self','voyager-compass',NULL,8,3,'2019-07-17 06:04:41','2019-07-17 06:04:51','voyager.compass.index',NULL),(12,1,'Settings','','_self','voyager-settings',NULL,NULL,15,'2019-07-17 06:04:41','2019-11-18 04:58:24','voyager.settings.index',NULL),(13,1,'Orders','/admin/orders','_self','voyager-documentation',NULL,NULL,2,'2019-07-17 06:04:50','2019-07-17 06:04:50',NULL,NULL),(14,1,'Products','/admin/products','_self','voyager-bag',NULL,NULL,3,'2019-07-17 06:04:50','2019-07-17 06:04:50',NULL,NULL),(15,1,'Categories','/admin/category','_self','voyager-tag',NULL,NULL,4,'2019-07-17 06:04:50','2019-07-17 06:04:50',NULL,NULL),(16,1,'Coupons','/admin/coupons','_self','voyager-dollar',NULL,NULL,6,'2019-07-17 06:04:50','2019-07-17 06:29:47',NULL,NULL),(17,1,'Category Products','/admin/category-product','_self','voyager-categories',NULL,NULL,7,'2019-07-17 06:04:50','2019-07-17 06:29:47',NULL,NULL),(18,2,'Shop','','_self',NULL,NULL,NULL,1,'2019-07-17 06:04:51','2019-07-17 06:04:51','shop.index',NULL),(19,2,'Orders','/admin/orders','_self',NULL,'#000000',NULL,2,'2019-07-17 06:04:51','2019-07-20 15:36:34',NULL,''),(20,2,'Blog','https://blog.laravelecommerceexample.ca','_self',NULL,NULL,NULL,3,'2019-07-17 06:04:51','2019-07-20 15:36:03',NULL,NULL),(26,1,'Subscribes','','_self','voyager-mail',NULL,NULL,5,'2019-07-17 06:28:57','2019-07-17 06:29:47','voyager.subscribe.index',NULL),(27,1,'Blocks','','_self',NULL,NULL,NULL,13,'2019-11-18 04:55:02','2019-11-18 04:58:23','voyager.blocks.index',NULL);
/*!40000 ALTER TABLE `menu_items` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menus` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menus_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES (1,'admin','2019-07-17 06:04:40','2019-07-17 06:04:40'),(2,'main','2019-07-17 06:04:50','2019-07-17 06:04:50');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2016_01_01_000000_add_voyager_user_fields',1),(4,'2016_01_01_000000_create_data_types_table',1),(5,'2016_01_01_000000_create_pages_table',1),(6,'2016_01_01_000000_create_posts_table',1),(7,'2016_02_15_204651_create_categories_table',1),(8,'2016_05_19_173453_create_menu_table',1),(9,'2016_10_21_190000_create_roles_table',1),(10,'2016_10_21_190000_create_settings_table',1),(11,'2016_11_30_135954_create_permission_table',1),(12,'2016_11_30_141208_create_permission_role_table',1),(13,'2016_12_26_201236_data_types__add__server_side',1),(14,'2017_01_13_000000_add_route_to_menu_items_table',1),(15,'2017_01_14_005015_create_translations_table',1),(16,'2017_01_15_000000_add_permission_group_id_to_permissions_table',1),(17,'2017_01_15_000000_create_permission_groups_table',1),(18,'2017_01_15_000000_make_table_name_nullable_in_permissions_table',1),(19,'2017_03_06_000000_add_controller_to_data_types_table',1),(20,'2017_04_11_000000_alter_post_nullable_fields_table',1),(21,'2017_04_21_000000_add_order_to_data_rows_table',1),(22,'2017_07_05_210000_add_policyname_to_data_types_table',1),(23,'2017_08_05_000000_add_group_to_settings_table',1),(24,'2017_11_26_013050_add_user_role_relationship',1),(25,'2017_11_26_015000_create_user_roles_table',1),(26,'2017_12_11_054653_create_products_table',1),(27,'2018_01_11_060124_create_category_table',1),(28,'2018_01_11_060548_create_category_product_table',1),(29,'2018_01_14_215535_create_coupons_table',1),(30,'2018_02_08_021546_add_image_to_products_table',1),(31,'2018_02_08_032544_add_images_to_products_table',1),(32,'2018_02_25_005243_create_orders_table',1),(33,'2018_02_25_010522_create_order_product_table',1),(34,'2018_03_11_000000_add_user_settings',1),(35,'2018_03_14_000000_add_details_to_data_types_table',1),(36,'2018_03_16_000000_make_settings_value_nullable',1),(37,'2018_04_23_011947_add_user_role_relationship_fix',1),(38,'2018_04_23_012009_create_user_roles_table_fix',1),(39,'2018_06_29_032914_add_quantity_to_products_table',1),(40,'2019_07_01_090241_create_subscribe_table',1),(41,'2019_07_02_121112_add_image_to_users_table',1),(42,'2019_11_18_100716_create_blocks_table',2),(43,'2019_11_19_205413_add_block_to_users_table',3);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `order_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT NULL,
  `product_id` int(10) unsigned DEFAULT NULL,
  `quantity` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_product_order_id_foreign` (`order_id`),
  KEY `order_product_product_id_foreign` (`product_id`),
  CONSTRAINT `order_product_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `order_product_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `order_product` WRITE;
/*!40000 ALTER TABLE `order_product` DISABLE KEYS */;
INSERT INTO `order_product` VALUES (1,NULL,NULL,1,'2019-07-17 06:04:36','2019-07-17 06:04:36'),(2,NULL,NULL,1,'2019-07-17 06:04:36','2019-07-17 06:04:36'),(3,NULL,NULL,1,'2019-07-17 06:04:36','2019-07-17 06:04:36'),(4,NULL,NULL,1,'2019-07-17 06:04:37','2019-07-17 06:04:37'),(5,NULL,NULL,1,'2019-07-17 06:04:37','2019-07-17 06:04:37'),(6,NULL,NULL,1,'2019-07-17 06:04:37','2019-07-17 06:04:37'),(7,NULL,NULL,1,'2019-07-20 06:17:19','2019-07-20 06:17:19'),(8,NULL,NULL,1,'2019-07-20 06:17:19','2019-07-20 06:17:19'),(9,NULL,NULL,1,'2019-07-20 06:17:19','2019-07-20 06:17:19'),(10,NULL,NULL,1,'2019-07-20 11:36:04','2019-07-20 11:36:04'),(11,NULL,NULL,1,'2019-07-20 11:36:04','2019-07-20 11:36:04'),(12,NULL,NULL,2,'2019-07-20 11:36:04','2019-07-20 11:36:04'),(13,NULL,NULL,3,'2019-07-20 11:36:04','2019-07-20 11:36:04'),(14,NULL,NULL,1,'2019-07-20 14:41:48','2019-07-20 14:41:48'),(15,NULL,NULL,1,'2019-07-20 14:41:48','2019-07-20 14:41:48'),(16,NULL,NULL,1,'2019-07-20 14:41:48','2019-07-20 14:41:48'),(17,NULL,NULL,1,'2019-07-20 15:08:00','2019-07-20 15:08:00'),(18,NULL,NULL,1,'2019-07-20 15:30:35','2019-07-20 15:30:35'),(19,NULL,NULL,1,'2019-07-20 15:30:35','2019-07-20 15:30:35'),(20,NULL,NULL,1,'2019-07-20 15:41:49','2019-07-20 15:41:49'),(21,NULL,NULL,1,'2019-07-20 15:41:49','2019-07-20 15:41:49'),(22,NULL,NULL,1,'2019-07-20 16:27:58','2019-07-20 16:27:58'),(23,NULL,NULL,1,'2019-07-20 16:27:58','2019-07-20 16:27:58'),(24,NULL,NULL,1,'2019-07-20 16:28:54','2019-07-20 16:28:54'),(25,NULL,NULL,1,'2019-07-20 16:28:54','2019-07-20 16:28:54'),(26,NULL,NULL,1,'2019-07-20 16:36:25','2019-07-20 16:36:25'),(27,NULL,NULL,1,'2019-07-20 16:36:25','2019-07-20 16:36:25'),(28,NULL,NULL,1,'2019-07-20 16:36:31','2019-07-20 16:36:31'),(29,NULL,NULL,1,'2019-07-20 16:36:31','2019-07-20 16:36:31'),(30,NULL,NULL,1,'2019-07-20 16:40:59','2019-07-20 16:40:59'),(31,NULL,NULL,1,'2019-07-20 16:40:59','2019-07-20 16:40:59'),(32,NULL,NULL,1,'2019-07-20 16:48:34','2019-07-20 16:48:34'),(33,NULL,NULL,1,'2019-07-20 16:48:34','2019-07-20 16:48:34'),(34,NULL,NULL,1,'2019-07-20 16:49:45','2019-07-20 16:49:45'),(35,NULL,NULL,1,'2019-07-20 16:49:45','2019-07-20 16:49:45'),(36,NULL,NULL,1,'2019-07-20 16:50:35','2019-07-20 16:50:35'),(37,NULL,NULL,1,'2019-07-20 16:50:35','2019-07-20 16:50:35'),(38,NULL,NULL,1,'2019-07-20 16:52:28','2019-07-20 16:52:28'),(39,NULL,NULL,1,'2019-07-20 16:52:28','2019-07-20 16:52:28'),(40,NULL,NULL,1,'2019-07-20 16:52:56','2019-07-20 16:52:56'),(41,NULL,NULL,1,'2019-07-20 16:52:56','2019-07-20 16:52:56'),(42,NULL,NULL,1,'2019-07-20 16:54:55','2019-07-20 16:54:55'),(43,NULL,NULL,1,'2019-07-20 16:54:55','2019-07-20 16:54:55'),(44,NULL,NULL,1,'2019-07-20 17:04:05','2019-07-20 17:04:05'),(45,NULL,NULL,1,'2019-07-20 17:04:05','2019-07-20 17:04:05'),(46,NULL,NULL,1,'2019-07-20 17:05:41','2019-07-20 17:05:41'),(47,NULL,NULL,1,'2019-07-20 17:05:41','2019-07-20 17:05:41'),(48,NULL,NULL,1,'2019-07-20 17:08:55','2019-07-20 17:08:55'),(49,NULL,NULL,1,'2019-07-20 17:08:55','2019-07-20 17:08:55'),(50,NULL,NULL,1,'2019-07-20 17:11:19','2019-07-20 17:11:19'),(51,NULL,NULL,1,'2019-07-20 17:11:19','2019-07-20 17:11:19'),(52,NULL,NULL,1,'2019-07-20 17:16:28','2019-07-20 17:16:28'),(53,NULL,NULL,1,'2019-07-20 17:16:28','2019-07-20 17:16:28'),(54,NULL,NULL,1,'2019-07-21 12:52:36','2019-07-21 12:52:36'),(55,NULL,NULL,1,'2019-07-21 12:52:36','2019-07-21 12:52:36'),(56,NULL,NULL,1,'2019-07-21 12:52:37','2019-07-21 12:52:37'),(57,NULL,NULL,1,'2019-07-21 13:01:51','2019-07-21 13:01:51'),(58,NULL,NULL,1,'2019-07-21 13:01:51','2019-07-21 13:01:51'),(59,NULL,NULL,1,'2019-07-21 13:01:51','2019-07-21 13:01:51'),(60,NULL,NULL,1,'2019-07-21 13:36:34','2019-07-21 13:36:34'),(61,NULL,NULL,1,'2019-07-21 13:36:35','2019-07-21 13:36:35'),(62,NULL,NULL,1,'2019-07-21 13:36:35','2019-07-21 13:36:35'),(63,NULL,NULL,1,'2019-07-21 13:39:08','2019-07-21 13:39:08'),(64,NULL,NULL,1,'2019-07-21 13:39:08','2019-07-21 13:39:08'),(65,NULL,NULL,1,'2019-07-21 13:39:08','2019-07-21 13:39:08'),(66,NULL,NULL,1,'2019-07-22 09:57:57','2019-07-22 09:57:57'),(67,NULL,NULL,1,'2019-07-22 09:57:57','2019-07-22 09:57:57'),(68,NULL,NULL,1,'2019-07-22 09:57:57','2019-07-22 09:57:57'),(69,NULL,NULL,1,'2019-07-22 09:57:57','2019-07-22 09:57:57'),(70,NULL,NULL,1,'2019-07-22 10:40:46','2019-07-22 10:40:46'),(71,NULL,NULL,1,'2019-07-22 10:40:46','2019-07-22 10:40:46'),(72,NULL,NULL,1,'2019-07-22 10:40:46','2019-07-22 10:40:46'),(73,NULL,NULL,5,'2019-07-23 11:12:50','2019-07-23 11:12:50'),(74,NULL,NULL,1,'2019-07-23 12:32:13','2019-07-23 12:32:13'),(75,NULL,NULL,1,'2019-07-23 12:32:13','2019-07-23 12:32:13'),(76,NULL,NULL,2,'2019-07-23 12:32:13','2019-07-23 12:32:13'),(77,NULL,NULL,1,'2019-07-24 14:44:34','2019-07-24 14:44:34'),(78,NULL,NULL,1,'2019-07-24 14:44:34','2019-07-24 14:44:34'),(79,NULL,NULL,1,'2019-07-24 14:44:34','2019-07-24 14:44:34'),(80,NULL,NULL,1,'2019-08-18 13:48:52','2019-08-18 13:48:52'),(81,NULL,NULL,1,'2019-08-18 13:48:52','2019-08-18 13:48:52'),(82,NULL,NULL,1,'2019-08-18 13:48:52','2019-08-18 13:48:52'),(83,NULL,NULL,1,'2019-08-18 13:48:52','2019-08-18 13:48:52'),(84,NULL,NULL,1,'2019-08-18 13:48:52','2019-08-18 13:48:52'),(85,NULL,NULL,1,'2019-08-18 13:48:52','2019-08-18 13:48:52'),(86,NULL,NULL,1,'2019-08-18 13:48:52','2019-08-18 13:48:52'),(87,NULL,NULL,1,'2019-08-18 13:48:52','2019-08-18 13:48:52'),(88,NULL,NULL,1,'2019-08-18 13:48:52','2019-08-18 13:48:52'),(89,NULL,NULL,1,'2019-08-18 13:48:52','2019-08-18 13:48:52'),(90,NULL,NULL,1,'2019-08-19 11:45:16','2019-08-19 11:45:16'),(91,NULL,NULL,1,'2019-11-20 09:15:10','2019-11-20 09:15:10'),(92,NULL,NULL,1,'2019-11-20 09:33:18','2019-11-20 09:33:18'),(93,NULL,NULL,1,'2019-11-20 09:45:56','2019-11-20 09:45:56'),(94,NULL,NULL,1,'2019-11-20 10:00:13','2019-11-20 10:00:13'),(95,NULL,NULL,1,'2019-11-20 10:02:00','2019-11-20 10:02:00'),(96,NULL,NULL,1,'2019-11-25 01:11:09','2019-11-25 01:11:09'),(97,NULL,NULL,1,'2019-11-25 01:20:45','2019-11-25 01:20:45'),(98,NULL,NULL,1,'2019-11-25 02:54:57','2019-11-25 02:54:57'),(99,NULL,NULL,1,'2019-11-25 03:02:46','2019-11-25 03:02:46'),(100,NULL,NULL,1,'2019-11-25 03:10:36','2019-11-25 03:10:36'),(101,NULL,NULL,1,'2019-11-25 03:17:26','2019-11-25 03:17:26'),(102,NULL,NULL,1,'2019-11-25 04:30:25','2019-11-25 04:30:25'),(103,NULL,NULL,1,'2019-11-25 21:33:35','2019-11-25 21:33:35'),(104,NULL,NULL,2,'2019-11-25 21:40:44','2019-11-25 21:40:44'),(105,NULL,NULL,2,'2019-11-25 21:40:44','2019-11-25 21:40:44'),(106,NULL,NULL,2,'2019-11-25 21:40:49','2019-11-25 21:40:49'),(107,NULL,NULL,2,'2019-11-25 21:40:49','2019-11-25 21:40:49'),(108,NULL,NULL,2,'2019-11-26 15:42:20','2019-11-26 15:42:20'),(109,NULL,NULL,1,'2019-11-28 02:28:28','2019-11-28 02:28:28'),(110,NULL,NULL,1,'2019-11-28 02:28:28','2019-11-28 02:28:28'),(111,NULL,NULL,1,'2019-11-28 02:33:35','2019-11-28 02:33:35'),(112,NULL,NULL,1,'2019-12-07 14:47:13','2019-12-07 14:47:13'),(113,NULL,NULL,1,'2019-12-19 21:27:17','2019-12-19 21:27:17'),(114,NULL,86,1,'2020-02-15 02:31:07','2020-02-15 02:31:07'),(115,NULL,87,5,'2020-02-18 04:37:32','2020-02-18 04:37:32'),(116,NULL,87,5,'2020-02-18 04:37:39','2020-02-18 04:37:39'),(117,NULL,87,4,'2020-02-18 13:06:56','2020-02-18 13:06:56'),(118,NULL,86,4,'2020-02-20 19:52:14','2020-02-20 19:52:14'),(119,NULL,87,2,'2020-02-20 20:11:43','2020-02-20 20:11:43'),(120,NULL,87,1,'2020-02-20 20:16:11','2020-02-20 20:16:11'),(121,NULL,86,1,'2020-02-20 20:41:00','2020-02-20 20:41:00'),(122,NULL,86,1,'2020-02-20 20:48:17','2020-02-20 20:48:17'),(123,NULL,86,1,'2020-02-20 21:00:02','2020-02-20 21:00:02'),(124,NULL,86,1,'2020-02-20 21:00:21','2020-02-20 21:00:21'),(125,NULL,86,1,'2020-02-20 21:01:06','2020-02-20 21:01:06'),(126,NULL,86,1,'2020-02-20 21:08:59','2020-02-20 21:08:59'),(127,NULL,86,1,'2020-02-20 21:09:37','2020-02-20 21:09:37'),(128,NULL,86,1,'2020-02-20 21:24:15','2020-02-20 21:24:15'),(129,NULL,87,1,'2020-02-21 12:38:02','2020-02-21 12:38:02'),(130,NULL,86,3,'2020-02-21 12:38:02','2020-02-21 12:38:02'),(131,13,87,1,'2020-02-21 12:38:08','2020-02-21 12:38:08'),(132,13,86,3,'2020-02-21 12:38:08','2020-02-21 12:38:08'),(133,14,86,2,'2020-02-22 14:13:50','2020-02-22 14:13:50'),(134,NULL,86,1,'2020-02-22 14:44:36','2020-02-22 14:44:36'),(135,NULL,86,1,'2020-02-22 14:54:43','2020-02-22 14:54:43'),(136,NULL,87,1,'2020-02-23 01:21:21','2020-02-23 01:21:21'),(137,15,87,5,'2020-02-26 14:51:25','2020-02-26 14:51:25'),(138,16,86,4,'2020-02-27 14:02:34','2020-02-27 14:02:34'),(139,NULL,86,4,'2020-02-27 14:02:48','2020-02-27 14:02:48');
/*!40000 ALTER TABLE `order_product` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `billing_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_province` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_postalcode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_name_on_card` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_discount` int(11) NOT NULL DEFAULT '0',
  `billing_discount_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `billing_subtotal` int(11) NOT NULL,
  `billing_tax` int(11) NOT NULL,
  `billing_total` int(11) NOT NULL,
  `payment_gateway` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'stripe',
  `shipped` tinyint(1) NOT NULL DEFAULT '0',
  `error` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_user_id_foreign` (`user_id`),
  CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (13,NULL,'bharatbhushan173@gmail.com','BASUDEV BHARAT BHUSHAN','Infront of sbi ATM(Narendrapur)','Berhampur','Odisha','760007','8249122911',NULL,0,NULL,16000,0,16000,'Cash On delivery',1,NULL,'2020-02-21 12:38:08','2020-02-21 18:31:08'),(14,NULL,'subratkumarbehera46@gmail.com','Subrat Kumar Behera','Near sbi atm front(Narendrapur)','Brahmapur','Odisha','760007','7008940612',NULL,0,NULL,8000,0,8000,'Cash On delivery',1,NULL,'2020-02-22 14:13:50','2020-02-22 14:52:15'),(15,NULL,'alokbanty15@gmail.com','PADMANAVA MISHRA','Patala Maharaja engineering colleges, Berhampur, Berhampur(PMEC)','BERHAMPUR','ODISHA','760001','7978599344',NULL,0,NULL,20000,0,20000,'Cash On delivery',1,NULL,'2020-02-26 14:51:25','2020-02-26 15:40:32'),(16,NULL,'alokbanty15@gmail.com','PADMANAVA MISHRA','Patala Maharaja engineering colleges, Berhampur, Berhampur(PMEC)','BERHAMPUR','ODISHA','760001','07978599344',NULL,0,NULL,16000,0,16000,'Cash On delivery',0,NULL,'2020-02-27 14:02:34','2020-02-27 14:02:34');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `excerpt` text COLLATE utf8_unicode_ci,
  `body` text COLLATE utf8_unicode_ci,
  `image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `meta_description` text COLLATE utf8_unicode_ci,
  `meta_keywords` text COLLATE utf8_unicode_ci,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'INACTIVE',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pages_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,0,'Hello World','Hang the jib grog grog blossom grapple dance the hempen jig gangway pressgang bilge rat to go on account lugger. Nelsons folly gabion line draught scallywag fire ship gaff fluke fathom case shot. Sea Legs bilge rat sloop matey gabion long clothes run a shot across the bow Gold Road cog league.','<p>Hello World. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>','pages/page1.jpg','hello-world','Yar Meta Description','Keyword1, Keyword2','ACTIVE','2019-07-17 06:04:46','2019-07-17 06:04:46');
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
INSERT INTO `password_resets` VALUES ('mmkumr.ping@gmail.com','$2y$10$SyOsosCAHe/0MUsG8Tb8oelF62S5F2AztZTmGRJ2drc3VQSOuZpa.','2019-11-25 21:38:26');
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `permission_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permission_groups_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `permission_groups` WRITE;
/*!40000 ALTER TABLE `permission_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `permission_groups` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `permission_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission_role` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `permission_role_permission_id_index` (`permission_id`),
  KEY `permission_role_role_id_index` (`role_id`),
  CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `permission_role` WRITE;
/*!40000 ALTER TABLE `permission_role` DISABLE KEYS */;
INSERT INTO `permission_role` VALUES (1,1),(1,3),(2,1),(2,3),(3,1),(4,1),(5,1),(6,1),(6,3),(7,1),(7,3),(8,1),(8,3),(9,1),(9,3),(10,1),(11,1),(11,3),(12,1),(12,3),(13,1),(13,3),(14,1),(14,3),(15,1),(16,1),(17,1),(18,1),(19,1),(20,1),(21,1),(22,1),(22,3),(23,1),(24,1),(25,1),(26,1),(26,3),(27,1),(27,3),(28,1),(28,3),(29,1),(29,3),(30,1),(31,1),(31,3),(32,1),(32,3),(33,1),(33,3),(34,1),(34,3),(35,1),(36,1),(36,3),(37,1),(37,3),(38,1),(38,3),(39,1),(39,3),(40,1),(41,1),(41,3),(42,1),(42,3),(43,1),(43,3),(44,1),(44,3),(45,1),(46,1),(46,3),(47,1),(47,3),(48,1),(48,3),(49,1),(49,3),(50,1),(51,1),(51,3),(52,1),(52,3),(53,1),(53,3),(54,1),(54,3),(55,1),(56,1),(56,3),(57,1),(57,3),(58,1),(58,3),(59,1),(59,3),(60,1),(61,1),(61,3),(62,1),(62,3),(63,1),(63,3),(64,1),(64,3),(65,1),(66,1),(67,1),(68,1),(69,1),(70,1),(71,1),(72,1),(73,1),(74,1),(75,1);
/*!40000 ALTER TABLE `permission_role` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `table_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `permission_group_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `permissions_key_index` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'browse_admin',NULL,'2019-07-17 06:04:41','2019-07-17 06:04:41',NULL),(2,'browse_bread',NULL,'2019-07-17 06:04:41','2019-07-17 06:04:41',NULL),(3,'browse_database',NULL,'2019-07-17 06:04:41','2019-07-17 06:04:41',NULL),(4,'browse_media',NULL,'2019-07-17 06:04:41','2019-07-17 06:04:41',NULL),(5,'browse_compass',NULL,'2019-07-17 06:04:41','2019-07-17 06:04:41',NULL),(6,'browse_menus','menus','2019-07-17 06:04:41','2019-07-17 06:04:41',NULL),(7,'read_menus','menus','2019-07-17 06:04:41','2019-07-17 06:04:41',NULL),(8,'edit_menus','menus','2019-07-17 06:04:41','2019-07-17 06:04:41',NULL),(9,'add_menus','menus','2019-07-17 06:04:41','2019-07-17 06:04:41',NULL),(10,'delete_menus','menus','2019-07-17 06:04:41','2019-07-17 06:04:41',NULL),(11,'browse_pages','pages','2019-07-17 06:04:41','2019-07-17 06:04:41',NULL),(12,'read_pages','pages','2019-07-17 06:04:41','2019-07-17 06:04:41',NULL),(13,'edit_pages','pages','2019-07-17 06:04:41','2019-07-17 06:04:41',NULL),(14,'add_pages','pages','2019-07-17 06:04:41','2019-07-17 06:04:41',NULL),(15,'delete_pages','pages','2019-07-17 06:04:42','2019-07-17 06:04:42',NULL),(16,'browse_roles','roles','2019-07-17 06:04:42','2019-07-17 06:04:42',NULL),(17,'read_roles','roles','2019-07-17 06:04:42','2019-07-17 06:04:42',NULL),(18,'edit_roles','roles','2019-07-17 06:04:42','2019-07-17 06:04:42',NULL),(19,'add_roles','roles','2019-07-17 06:04:42','2019-07-17 06:04:42',NULL),(20,'delete_roles','roles','2019-07-17 06:04:42','2019-07-17 06:04:42',NULL),(21,'browse_users','users','2019-07-17 06:04:42','2019-07-17 06:04:42',NULL),(22,'read_users','users','2019-07-17 06:04:42','2019-07-17 06:04:42',NULL),(23,'edit_users','users','2019-07-17 06:04:42','2019-07-17 06:04:42',NULL),(24,'add_users','users','2019-07-17 06:04:42','2019-07-17 06:04:42',NULL),(25,'delete_users','users','2019-07-17 06:04:42','2019-07-17 06:04:42',NULL),(26,'browse_posts','posts','2019-07-17 06:04:42','2019-07-17 06:04:42',NULL),(27,'read_posts','posts','2019-07-17 06:04:42','2019-07-17 06:04:42',NULL),(28,'edit_posts','posts','2019-07-17 06:04:42','2019-07-17 06:04:42',NULL),(29,'add_posts','posts','2019-07-17 06:04:42','2019-07-17 06:04:42',NULL),(30,'delete_posts','posts','2019-07-17 06:04:42','2019-07-17 06:04:42',NULL),(31,'browse_categories','categories','2019-07-17 06:04:42','2019-07-17 06:04:42',NULL),(32,'read_categories','categories','2019-07-17 06:04:42','2019-07-17 06:04:42',NULL),(33,'edit_categories','categories','2019-07-17 06:04:42','2019-07-17 06:04:42',NULL),(34,'add_categories','categories','2019-07-17 06:04:42','2019-07-17 06:04:42',NULL),(35,'delete_categories','categories','2019-07-17 06:04:43','2019-07-17 06:04:43',NULL),(36,'browse_settings','settings','2019-07-17 06:04:43','2019-07-17 06:04:43',NULL),(37,'read_settings','settings','2019-07-17 06:04:43','2019-07-17 06:04:43',NULL),(38,'edit_settings','settings','2019-07-17 06:04:43','2019-07-17 06:04:43',NULL),(39,'add_settings','settings','2019-07-17 06:04:43','2019-07-17 06:04:43',NULL),(40,'delete_settings','settings','2019-07-17 06:04:43','2019-07-17 06:04:43',NULL),(41,'browse_products','products','2019-07-17 06:04:51','2019-07-17 06:04:51',NULL),(42,'read_products','products','2019-07-17 06:04:51','2019-07-17 06:04:51',NULL),(43,'edit_products','products','2019-07-17 06:04:51','2019-07-17 06:04:51',NULL),(44,'add_products','products','2019-07-17 06:04:52','2019-07-17 06:04:52',NULL),(45,'delete_products','products','2019-07-17 06:04:52','2019-07-17 06:04:52',NULL),(46,'browse_coupons','coupons','2019-07-17 06:04:52','2019-07-17 06:04:52',NULL),(47,'read_coupons','coupons','2019-07-17 06:04:52','2019-07-17 06:04:52',NULL),(48,'edit_coupons','coupons','2019-07-17 06:04:52','2019-07-17 06:04:52',NULL),(49,'add_coupons','coupons','2019-07-17 06:04:52','2019-07-17 06:04:52',NULL),(50,'delete_coupons','coupons','2019-07-17 06:04:52','2019-07-17 06:04:52',NULL),(51,'browse_category','category','2019-07-17 06:04:52','2019-07-17 06:04:52',NULL),(52,'read_category','category','2019-07-17 06:04:52','2019-07-17 06:04:52',NULL),(53,'edit_category','category','2019-07-17 06:04:52','2019-07-17 06:04:52',NULL),(54,'add_category','category','2019-07-17 06:04:52','2019-07-17 06:04:52',NULL),(55,'delete_category','category','2019-07-17 06:04:52','2019-07-17 06:04:52',NULL),(56,'browse_category-product','category-product','2019-07-17 06:04:52','2019-07-17 06:04:52',NULL),(57,'read_category-product','category-product','2019-07-17 06:04:52','2019-07-17 06:04:52',NULL),(58,'edit_category-product','category-product','2019-07-17 06:04:53','2019-07-17 06:04:53',NULL),(59,'add_category-product','category-product','2019-07-17 06:04:53','2019-07-17 06:04:53',NULL),(60,'delete_category-product','category-product','2019-07-17 06:04:53','2019-07-17 06:04:53',NULL),(61,'browse_orders','orders','2019-07-17 06:04:53','2019-07-17 06:04:53',NULL),(62,'read_orders','orders','2019-07-17 06:04:53','2019-07-17 06:04:53',NULL),(63,'edit_orders','orders','2019-07-17 06:04:53','2019-07-17 06:04:53',NULL),(64,'add_orders','orders','2019-07-17 06:04:53','2019-07-17 06:04:53',NULL),(65,'delete_orders','orders','2019-07-17 06:04:53','2019-07-17 06:04:53',NULL),(66,'browse_subscribe','subscribe','2019-07-17 06:28:57','2019-07-17 06:28:57',NULL),(67,'read_subscribe','subscribe','2019-07-17 06:28:57','2019-07-17 06:28:57',NULL),(68,'edit_subscribe','subscribe','2019-07-17 06:28:57','2019-07-17 06:28:57',NULL),(69,'add_subscribe','subscribe','2019-07-17 06:28:57','2019-07-17 06:28:57',NULL),(70,'delete_subscribe','subscribe','2019-07-17 06:28:57','2019-07-17 06:28:57',NULL),(71,'browse_blocks','blocks','2019-11-18 04:55:02','2019-11-18 04:55:02',NULL),(72,'read_blocks','blocks','2019-11-18 04:55:02','2019-11-18 04:55:02',NULL),(73,'edit_blocks','blocks','2019-11-18 04:55:02','2019-11-18 04:55:02',NULL),(74,'add_blocks','blocks','2019-11-18 04:55:02','2019-11-18 04:55:02',NULL),(75,'delete_blocks','blocks','2019-11-18 04:55:02','2019-11-18 04:55:02',NULL);
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `author_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `seo_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `excerpt` text COLLATE utf8_unicode_ci,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `meta_description` text COLLATE utf8_unicode_ci,
  `meta_keywords` text COLLATE utf8_unicode_ci,
  `status` enum('PUBLISHED','DRAFT','PENDING') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'DRAFT',
  `featured` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `posts_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (1,0,NULL,'Lorem Ipsum Post',NULL,'This is the excerpt for the Lorem Ipsum Post','<p>This is the body of the lorem ipsum post</p>','posts/post1.jpg','lorem-ipsum-post','This is the meta description','keyword1, keyword2, keyword3','PUBLISHED',0,'2019-07-17 06:04:46','2019-07-17 06:04:46'),(2,0,NULL,'My Sample Post',NULL,'This is the excerpt for the sample Post','<p>This is the body for the sample post, which includes the body.</p>\n                <h2>We can use all kinds of format!</h2>\n                <p>And include a bunch of other stuff.</p>','posts/post2.jpg','my-sample-post','Meta Description for sample post','keyword1, keyword2, keyword3','PUBLISHED',0,'2019-07-17 06:04:46','2019-07-17 06:04:46'),(3,0,NULL,'Latest Post',NULL,'This is the excerpt for the latest post','<p>This is the body for the latest post</p>','posts/post3.jpg','latest-post','This is the meta description','keyword1, keyword2, keyword3','PUBLISHED',0,'2019-07-17 06:04:46','2019-07-17 06:04:46'),(4,0,NULL,'Yarr Post',NULL,'Reef sails nipperkin bring a spring upon her cable coffer jury mast spike marooned Pieces of Eight poop deck pillage. Clipper driver coxswain galleon hempen halter come about pressgang gangplank boatswain swing the lead. Nipperkin yard skysail swab lanyard Blimey bilge water ho quarter Buccaneer.','<p>Swab deadlights Buccaneer fire ship square-rigged dance the hempen jig weigh anchor cackle fruit grog furl. Crack Jennys tea cup chase guns pressgang hearties spirits hogshead Gold Road six pounders fathom measured fer yer chains. Main sheet provost come about trysail barkadeer crimp scuttle mizzenmast brig plunder.</p>\n<p>Mizzen league keelhaul galleon tender cog chase Barbary Coast doubloon crack Jennys tea cup. Blow the man down lugsail fire ship pinnace cackle fruit line warp Admiral of the Black strike colors doubloon. Tackle Jack Ketch come about crimp rum draft scuppers run a shot across the bow haul wind maroon.</p>\n<p>Interloper heave down list driver pressgang holystone scuppers tackle scallywag bilged on her anchor. Jack Tar interloper draught grapple mizzenmast hulk knave cable transom hogshead. Gaff pillage to go on account grog aft chase guns piracy yardarm knave clap of thunder.</p>','posts/post4.jpg','yarr-post','this be a meta descript','keyword1, keyword2, keyword3','PUBLISHED',0,'2019-07-17 06:04:46','2019-07-17 06:04:46');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `details` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `price` int(11) NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `featured` tinyint(1) NOT NULL DEFAULT '0',
  `quantity` int(10) unsigned NOT NULL DEFAULT '10',
  `image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `images` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `products_name_unique` (`name`),
  UNIQUE KEY `products_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (86,'Veg Biryani','veg-biryani','Items:- Veg Biryani, gravy, salad',4000,'--',0,0,'products/February2020/Vr1NFqr2kIobMXMvrzda.jpg',NULL,'2020-02-13 08:28:00','2020-02-27 14:02:00'),(87,'Veg Meal','veg-meal','Items:- Rice, Curry, Fry, Dal',4000,'--',0,0,'products/February2020/JvwDFAQ11CLwYMx9TLt2.jpg',NULL,'2020-02-13 09:44:00','2020-02-26 14:51:00');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin','Administrator','2019-07-17 06:04:41','2019-07-17 06:04:41'),(2,'user','Normal User','2019-07-17 06:04:41','2019-07-17 06:04:41'),(3,'adminweb','Admin Web','2019-07-17 06:04:51','2019-07-17 06:04:51');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `details` text COLLATE utf8_unicode_ci,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `order` int(11) NOT NULL DEFAULT '1',
  `group` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_key_unique` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,'site.title','Site Title','Site Title','','text',1,'Site'),(2,'site.description','Site Description','Site Description','','text',2,'Site'),(3,'site.logo','Site Logo','','','image',3,'Site'),(4,'site.google_analytics_tracking_id','Google Analytics Tracking ID','','','text',4,'Site'),(5,'admin.bg_image','Admin Background Image','','','image',5,'Admin'),(6,'admin.title','Admin Title','Voyager','','text',1,'Admin'),(7,'admin.description','Admin Description','Welcome to Voyager. The Missing Admin for Laravel','','text',2,'Admin'),(8,'admin.loader','Admin Loader','','','image',3,'Admin'),(9,'admin.icon_image','Admin Icon Image','','','image',4,'Admin'),(10,'admin.google_analytics_client_id','Google Analytics Client ID (used for admin dashboard)','','','text',1,'Admin'),(11,'site.stock_threshold','Stock Threshold','5','','text',6,'Site');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `subscribe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscribe` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subscribe_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `subscribe` WRITE;
/*!40000 ALTER TABLE `subscribe` DISABLE KEYS */;
INSERT INTO `subscribe` VALUES (1,'Amit Patro','amit.patro400@gmail.com','2019-08-18 14:00:14','2019-08-18 14:00:14'),(2,'Vegifruit','vegifruitcare@gmail.com','2019-08-18 14:09:04','2019-08-18 14:09:04');
/*!40000 ALTER TABLE `subscribe` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `table_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `column_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `foreign_key` int(10) unsigned NOT NULL,
  `locale` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `translations_table_name_column_name_foreign_key_locale_unique` (`table_name`,`column_name`,`foreign_key`,`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `translations` WRITE;
/*!40000 ALTER TABLE `translations` DISABLE KEYS */;
INSERT INTO `translations` VALUES (1,'data_types','display_name_singular',1,'pt','Post','2019-07-17 06:04:46','2019-07-17 06:04:46'),(2,'data_types','display_name_singular',2,'pt','Página','2019-07-17 06:04:46','2019-07-17 06:04:46'),(3,'data_types','display_name_singular',3,'pt','Utilizador','2019-07-17 06:04:46','2019-07-17 06:04:46'),(4,'data_types','display_name_singular',4,'pt','Categoria','2019-07-17 06:04:46','2019-07-17 06:04:46'),(5,'data_types','display_name_singular',5,'pt','Menu','2019-07-17 06:04:46','2019-07-17 06:04:46'),(6,'data_types','display_name_singular',6,'pt','Função','2019-07-17 06:04:46','2019-07-17 06:04:46'),(7,'data_types','display_name_plural',1,'pt','Posts','2019-07-17 06:04:46','2019-07-17 06:04:46'),(8,'data_types','display_name_plural',2,'pt','Páginas','2019-07-17 06:04:46','2019-07-17 06:04:46'),(9,'data_types','display_name_plural',3,'pt','Utilizadores','2019-07-17 06:04:46','2019-07-17 06:04:46'),(10,'data_types','display_name_plural',4,'pt','Categorias','2019-07-17 06:04:46','2019-07-17 06:04:46'),(11,'data_types','display_name_plural',5,'pt','Menus','2019-07-17 06:04:47','2019-07-17 06:04:47'),(12,'data_types','display_name_plural',6,'pt','Funções','2019-07-17 06:04:47','2019-07-17 06:04:47'),(13,'categories','slug',1,'pt','categoria-1','2019-07-17 06:04:47','2019-07-17 06:04:47'),(14,'categories','name',1,'pt','Categoria 1','2019-07-17 06:04:47','2019-07-17 06:04:47'),(15,'categories','slug',2,'pt','categoria-2','2019-07-17 06:04:47','2019-07-17 06:04:47'),(16,'categories','name',2,'pt','Categoria 2','2019-07-17 06:04:47','2019-07-17 06:04:47'),(17,'pages','title',1,'pt','Olá Mundo','2019-07-17 06:04:47','2019-07-17 06:04:47'),(18,'pages','slug',1,'pt','ola-mundo','2019-07-17 06:04:47','2019-07-17 06:04:47'),(19,'pages','body',1,'pt','<p>Olá Mundo. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\r\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>','2019-07-17 06:04:47','2019-07-17 06:04:47'),(20,'menu_items','title',1,'pt','Painel de Controle','2019-07-17 06:04:47','2019-07-17 06:04:47'),(21,'menu_items','title',2,'pt','Media','2019-07-17 06:04:47','2019-07-17 06:04:47'),(22,'menu_items','title',3,'pt','Publicações','2019-07-17 06:04:47','2019-07-17 06:04:47'),(23,'menu_items','title',4,'pt','Utilizadores','2019-07-17 06:04:47','2019-07-17 06:04:47'),(24,'menu_items','title',5,'pt','Categorias','2019-07-17 06:04:47','2019-07-17 06:04:47'),(25,'menu_items','title',6,'pt','Páginas','2019-07-17 06:04:47','2019-07-17 06:04:47'),(26,'menu_items','title',7,'pt','Funções','2019-07-17 06:04:47','2019-07-17 06:04:47'),(27,'menu_items','title',8,'pt','Ferramentas','2019-07-17 06:04:47','2019-07-17 06:04:47'),(28,'menu_items','title',9,'pt','Menus','2019-07-17 06:04:47','2019-07-17 06:04:47'),(29,'menu_items','title',10,'pt','Base de dados','2019-07-17 06:04:47','2019-07-17 06:04:47'),(30,'menu_items','title',12,'pt','Configurações','2019-07-17 06:04:47','2019-07-17 06:04:47');
/*!40000 ALTER TABLE `translations` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_roles` (
  `user_id` int(10) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `user_roles_user_id_index` (`user_id`),
  KEY `user_roles_role_id_index` (`role_id`),
  CONSTRAINT `user_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_roles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dp` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'users/default.jpg',
  `role_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'users/default.jpg',
  `phone` bigint(20) unsigned DEFAULT NULL,
  `block` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pin_code` int(10) unsigned DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `wallet` int(10) unsigned DEFAULT '0',
  `referred` tinyint(1) NOT NULL DEFAULT '0',
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `settings` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_role_id_foreign` (`role_id`),
  CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'users/default.jpg',1,'Admin','vegifruit@admin.com','users/default.jpg',NULL,NULL,NULL,NULL,NULL,NULL,'$2y$10$UBP6yf4M3EUZ0CxTdahbnek1re8jBInvHFIPfoLLb6KvCZMP0/Jja',0,0,'J5edeW3FHzjiULnKuJRbzzS2zaF1ZXfJpnOTrInBk4jOkBjRc4HfjLEBQTEF',NULL,'2019-07-17 06:04:46','2019-07-17 06:04:46'),(4,'users/mmkumr.ping@gmail.com.jpg',2,'Mukesh Kumar','mmkumr.ping@gmail.com','users/default.jpg',8337908779,NULL,'Co-operative colony lane 3rd','Berhampur','Orissa',760004,'$2y$10$MHetZXIwuZoPOK6DPzKXNeBnxqr1GB4RguTlBGHjF4RSLoSSEuy9O',0,0,NULL,NULL,'2019-07-25 13:49:38','2019-07-25 13:49:38'),(9,'users/users/default.jpg',2,'Suraj Kumar Marandi','singhsuraj215@gmail.com','users/default.jpg',7327862134,'Ambapua','Mamta Apartment','Brahmapur','Odisha',761003,'$2y$10$cpyfnEB2IXANDc17Ca0fh.bAkno0wTLj2hvBHSq5DDrmcfZ5ZJT8K',0,0,NULL,NULL,'2019-12-02 00:55:20','2019-12-02 00:55:20'),(10,'users/sudhansusekhar04313@gmail.com.jpg',2,'Sudhansu','sudhansusekhar04313@gmail.com','users/default.jpg',7978760113,'Ankuli','Brundaban nagar','Brahmapur','Odisha',760010,'$2y$10$xgDlqKgWHXdQ7bz9TTf5Le7BOU1PEbMPJ/lfivxPpYb5A4uMQ64Ua',0,0,NULL,NULL,'2019-12-02 13:57:46','2019-12-02 13:57:46'),(11,'users/users/default.jpg',2,'Sambit','sambit956@gmail.com','users/default.jpg',8917438216,'Ambapua','Pakudibandha','Brahmapur','Odisha',754103,'$2y$10$viexnQBv3b6SaXhst6mfautFRFrjUwgAttdms2SVMGrgUQNdk4n.e',0,0,NULL,NULL,'2019-12-03 21:46:30','2019-12-03 21:46:30'),(12,'users/users/default.jpg',2,'Arjun','yofewol294@mailmink.com','users/default.jpg',8210009861,'Ambapua','Pmec boys hostel 2','Brahmapur','Odisha',731001,'$2y$10$hlX/h/949v.NmAe.j0GVCuuQiDop4860ohVswUo8erJwysgxSftL2',0,0,NULL,NULL,'2020-02-15 02:07:44','2020-02-15 02:24:16'),(13,'users/users/default.jpg',2,'Manaswani','manaswanimallik@gmail.com','users/default.jpg',7008913302,'Ambapua','Girls hostel ,parala Maharaja engineering college, sitallapalli near narendrapur','Brahmapur','Odisha',761003,'$2y$10$szDRerEdSWWGE7HnchziFu8Tkwhx0.sKcfR2UFDHXyTUywKYT1opa',0,0,NULL,NULL,'2020-02-18 00:42:58','2020-02-18 00:42:58'),(14,'users/users/default.jpg',2,'Balaram Panda','pandabalram67@gmail.com','users/default.jpg',9938997943,'Ayodhya Nagar','Ayodhya nagar','Brahmapur','Odisha',760004,'$2y$10$vRaS.qA1EghQ9JWddSrH7OIQTucE8CXCDF4QNm8Y5QEbnErE1UAkm',0,0,NULL,NULL,'2020-02-18 04:35:59','2020-02-18 04:36:00'),(15,'users/users/default.jpg',2,'Subrat Kumar Behera','subratkumarbehera46@gmail.com','users/default.jpg',7008940612,'Narendrapur','Near sbi atm front','Brahmapur','Odisha',760007,'$2y$10$npPQWD72/Bq84M5OPA78OOhAEh2JjdlxiJwOIXcWf.gN0gCsVLDBW',0,0,NULL,NULL,'2020-02-22 14:12:46','2020-02-22 14:12:46'),(16,'users/users/default.jpg',2,'Kunal Bose','kunalbose234@gmail.com','users/default.jpg',6372924644,'Narendrapur','Sbi ATM narendrapur','Brahmapur','Odisha',760007,'$2y$10$wq6xpLQSa4tmQEOwMI3kuegY7aCLYwK5jbAd/AUS2mkX79qRm20hK',0,0,NULL,NULL,'2020-02-26 18:42:20','2020-02-26 18:42:20');
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

