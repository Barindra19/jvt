/*
 Navicat Premium Data Transfer

 Source Server         : Localhost
 Source Server Type    : MySQL
 Source Server Version : 50635
 Source Host           : localhost
 Source Database       : db_javatour

 Target Server Type    : MySQL
 Target Server Version : 50635
 File Encoding         : utf-8

 Date: 10/15/2017 23:15:42 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `activity_log`
-- ----------------------------
DROP TABLE IF EXISTS `activity_log`;
CREATE TABLE `activity_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `content_type` varchar(72) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content_id` int(11) DEFAULT NULL,
  `action` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` text COLLATE utf8mb4_unicode_ci,
  `data` text COLLATE utf8mb4_unicode_ci,
  `language_key` tinyint(1) DEFAULT NULL,
  `public` tinyint(1) DEFAULT NULL,
  `developer` tinyint(1) DEFAULT NULL,
  `ip_address` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
--  Records of `activity_log`
-- ----------------------------
BEGIN;
INSERT INTO `activity_log` VALUES ('1', '1', 'Setting', '1', 'Update', 'SQLSTATE[42S22]: Column not found: 1054 Unknown column \'meta_keywords\' in \'field list\' (SQL: update `settings` set `title` = asdasad, `updated_at` = 2017-10-05 09:35:13, `meta_keywords` = , `meta_description` =  where `id` = 1)', 'ada kesalahan pada saat Perubahan data', null, null, null, null, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:55.0) Gecko/20100101 Firefox/55.0', '2017-10-05 09:35:13', '2017-10-05 09:35:13'), ('2', '1', 'Confirmation Request', '16', 'Update', 'Ada kesalahan teknis pada form confirmation', 'SQLSTATE[42S22]: Column not found: 1054 Unknown column \'confirmation_type\' in \'field list\' (SQL: insert into `confirmations` (`user_id`, `website_id`, `invoice_id`, `confirmation_type`, `name`, `bank_information`, `account_of_bank`, `date_transaction`, `total`, `created_by`, `updated_by`, `updated_at`, `created_at`) values (1, 2, 16, 1, Barindra Maslo, bca, 7380317421, 2017-10-06, 500000, 1, 1, 2017-10-06 11:24:25, 2017-10-06 11:24:25))', '{\"user_id\":1,\"website_id\":2,\"invoice_id\":\"16\",\"name\":\"Barindra Maslo\",\"bank_information\":\"bca\",\"account_of_bank\":\"7380317421\",\"date_transaction\":\"06-10-2017\",\"total\":\"Rp ___.500.000\"}', null, null, null, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:56.0) Gecko/20100101 Firefox/56.0', '2017-10-06 11:24:25', '2017-10-06 11:24:25'), ('3', '1', 'Confirmation Approve', '0', 'Update', 'Ada kesalahan teknis pada Simpan cashbook/Saldo realtime', 'Call to undefined method Illuminate\\Database\\Query\\Builder::id()', '{\"debit\":500000,\"credit\":0,\"ref_id\":\"2\",\"flow\":\"I\",\"status\":1,\"date_transaction\":\"2017-10-10 15:52:53\",\"description\":\"Pembayaran Invoice 1710060016\",\"website_id\":2,\"user_id\":1,\"flag\":0,\"url\":\"http:\\/\\/localhost:8080\\/myinvitation\\/public\\/invoice\\/verified\\/16\",\"invoice_id\":16}', null, null, null, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:56.0) Gecko/20100101 Firefox/56.0', '2017-10-10 15:52:53', '2017-10-10 15:52:53'), ('4', '1', 'Confirmation Approve', '0', 'Update', 'Ada kesalahan teknis pada Simpan cashbook/Saldo realtime', 'Call to undefined method Illuminate\\Database\\Query\\Builder::id()', '{\"debit\":500000,\"credit\":0,\"ref_id\":\"2\",\"flow\":\"I\",\"status\":1,\"date_transaction\":\"2017-10-10 16:01:03\",\"description\":\"Pembayaran Invoice 1710060016\",\"website_id\":2,\"user_id\":1,\"flag\":0,\"url\":\"http:\\/\\/localhost:8080\\/myinvitation\\/public\\/invoice\\/verified\\/16\",\"invoice_id\":16}', null, null, null, '::1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:56.0) Gecko/20100101 Firefox/56.0', '2017-10-10 16:01:03', '2017-10-10 16:01:03');
COMMIT;

-- ----------------------------
--  Table structure for `countrys`
-- ----------------------------
DROP TABLE IF EXISTS `countrys`;
CREATE TABLE `countrys` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `region_id` int(6) DEFAULT NULL,
  `is_active` int(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` int(6) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `region_id` (`region_id`),
  CONSTRAINT `countrys_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `countrys`
-- ----------------------------
BEGIN;
INSERT INTO `countrys` VALUES ('1', 'Indonesia', '1', '1', '2017-10-15 14:02:04', '1', '2017-10-15 14:02:08', '1');
COMMIT;

-- ----------------------------
--  Table structure for `destinations`
-- ----------------------------
DROP TABLE IF EXISTS `destinations`;
CREATE TABLE `destinations` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `region_id` int(6) DEFAULT NULL,
  `country_id` int(6) DEFAULT NULL,
  `is_active` int(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` int(6) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `region_id` (`region_id`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `destinations_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `destinations_ibfk_2` FOREIGN KEY (`country_id`) REFERENCES `countrys` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `destinations`
-- ----------------------------
BEGIN;
INSERT INTO `destinations` VALUES ('1', 'Lampung', '1', '1', '1', '2017-10-15 14:02:32', '1', '2017-10-15 14:02:35', '1'), ('2', 'Jawa', '1', '1', '1', '2017-10-15 23:10:29', '1', '2017-10-15 23:10:34', '1');
COMMIT;

-- ----------------------------
--  Table structure for `includes`
-- ----------------------------
DROP TABLE IF EXISTS `includes`;
CREATE TABLE `includes` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `icon` varchar(50) DEFAULT NULL,
  `description` text,
  `is_active` int(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` int(6) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `includes`
-- ----------------------------
BEGIN;
INSERT INTO `includes` VALUES ('1', 'Tiket Pesawat', 'fa fa-plane', null, '1', '2017-10-15 16:01:16', '1', '2017-10-15 16:01:19', '1'), ('2', 'Akomodasi sesuai paket', 'fa fa-car', null, '1', '2017-10-15 16:11:26', '1', '2017-10-15 16:11:30', '1'), ('3', 'Hotel', 'ti ti-home', null, '1', '2017-10-15 16:13:16', '1', '2017-10-15 16:13:20', '1');
COMMIT;

-- ----------------------------
--  Table structure for `menus`
-- ----------------------------
DROP TABLE IF EXISTS `menus`;
CREATE TABLE `menus` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) DEFAULT NULL,
  `url` varchar(191) DEFAULT NULL,
  `permission` varchar(191) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `menus`
-- ----------------------------
BEGIN;
INSERT INTO `menus` VALUES ('1', 'Admin', 'menu/show', 'menu-view', 'fa fa-cog', '0017-07-25 14:44:00', '0017-07-25 14:44:00'), ('3', 'Master', null, 'master-menu', 'glyphicon glyphicon-hdd', '2017-10-02 08:10:05', '2017-10-15 05:52:09'), ('6', 'Layanan', null, 'layanan-menu', 'ti  ti-harddrives', '2017-10-15 06:01:12', '2017-10-15 06:01:12');
COMMIT;

-- ----------------------------
--  Table structure for `migrations`
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
--  Records of `migrations`
-- ----------------------------
BEGIN;
INSERT INTO `migrations` VALUES ('1', '2017_08_20_161431_entrust_setup_tables', '1'), ('2', '2013_09_12_234559_create_activity_log_table', '2'), ('3', '2016_05_12_142519_alter_activity_log_table_add_additional_fields', '2');
COMMIT;

-- ----------------------------
--  Table structure for `permission_role`
-- ----------------------------
DROP TABLE IF EXISTS `permission_role`;
CREATE TABLE `permission_role` (
  `permission_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `permission_role_role_id_foreign` (`role_id`),
  CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
--  Records of `permission_role`
-- ----------------------------
BEGIN;
INSERT INTO `permission_role` VALUES ('1', '1'), ('2', '1'), ('3', '1'), ('4', '1'), ('5', '1'), ('6', '1'), ('7', '1'), ('8', '1'), ('9', '1'), ('10', '1'), ('11', '1'), ('12', '1'), ('13', '1'), ('14', '1'), ('15', '1'), ('16', '1'), ('17', '1'), ('18', '1'), ('19', '1'), ('20', '1'), ('21', '1'), ('39', '1'), ('40', '1'), ('41', '1'), ('42', '1'), ('43', '1'), ('44', '1'), ('45', '1'), ('46', '1'), ('47', '1'), ('48', '1'), ('49', '1'), ('50', '1'), ('51', '1'), ('17', '2'), ('39', '2'), ('40', '2'), ('41', '2'), ('43', '2'), ('44', '2'), ('45', '2'), ('46', '2'), ('47', '2'), ('48', '2'), ('49', '2'), ('50', '2'), ('51', '2'), ('1', '4'), ('2', '4'), ('3', '4'), ('4', '4'), ('5', '4'), ('6', '4'), ('7', '4'), ('8', '4'), ('9', '4'), ('10', '4'), ('11', '4'), ('12', '4'), ('13', '4'), ('14', '4'), ('15', '4'), ('16', '4'), ('17', '4'), ('18', '4'), ('19', '4'), ('20', '4'), ('21', '4'), ('39', '4'), ('40', '4'), ('41', '4'), ('42', '4'), ('43', '4'), ('44', '4'), ('45', '4'), ('46', '4'), ('47', '4'), ('48', '4'), ('49', '4'), ('50', '4'), ('51', '4');
COMMIT;

-- ----------------------------
--  Table structure for `permissions`
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `parent_id` int(10) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
--  Records of `permissions`
-- ----------------------------
BEGIN;
INSERT INTO `permissions` VALUES ('1', 'permission-add', 'Permission Add', 'Access to add Permission', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('2', 'permission-edit', 'Permission Edit', 'access to edit Permission', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('3', 'permission-delete', 'Permission Delete', 'Access to delete Permission', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('4', 'permission-view', 'Permission View', 'Access to view Permission form', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('5', 'role-view', 'Role View', 'Access to view Role Page', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('6', 'role-add', 'Role Add', 'Access to add Role', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('7', 'role-edit', 'Role Edit', 'Access to edit Role', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('8', 'role-delete', 'Role Delete', 'Access to delete Role', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('9', 'menu-view', 'Menu View', 'Access to View Page Menu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('10', 'menu-add', 'Menu Add', 'Access to form add menu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('11', 'menu-edit', 'Menu Edit', 'Access to Edit Menu Form', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('12', 'menu-delete', 'Menu Delete', 'Access to Delete Menu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('13', 'submenu-view', 'Submenu View', 'Access to View Submenu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('14', 'submenu-add', 'Submenu Add', 'Access to Add Form Submenu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('15', 'submenu-edit', 'Submenu Edit', 'Access to Edit Submenu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('16', 'submenu-delete', 'Submenu Delete', 'Access to Delete Submenu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('17', 'user-management-view', 'User Management Menu', 'User Management Menu', '0000-00-00 00:00:00', '2017-10-15 03:43:22', '0'), ('18', 'thirdmenu-view', 'Thirdmenu View', 'Access to view Thirdmenu', '2017-08-21 14:17:29', '2017-08-21 14:17:55', '0'), ('19', 'thirdmenu-add', 'Thirdmenu Add', 'Access to Add New Thirdmenu', '2017-08-21 14:18:25', '2017-08-22 04:08:32', '18'), ('20', 'thirdmenu-edit', 'Thirdmenu Edit', 'Access to Edit Thirdmenu', '2017-08-21 14:18:56', '2017-08-22 04:08:51', '18'), ('21', 'thirdmenu-delete', 'Thirdmenu Delete', 'Access to Delete Thirdmenu', '2017-08-21 14:19:32', '2017-08-22 04:09:14', '18'), ('39', 'setting-view', 'Setting Menu', 'Setting Menu', '2017-10-14 16:38:14', '2017-10-14 16:38:14', '0'), ('40', 'setting-edit', 'Edit Setting System', 'Edit Setting System', '2017-10-15 03:19:01', '2017-10-15 03:19:01', '39'), ('41', 'user-management-edit', 'User Management Edit', 'User Management Edit', '2017-10-15 03:36:08', '2017-10-15 03:43:40', '17'), ('42', 'user-management-add', 'User Management Add New', 'User Management Add New', '2017-10-15 03:36:31', '2017-10-15 03:43:59', '17'), ('43', 'user-management-delete', 'User Management Delete', 'User Management Delete', '2017-10-15 03:38:28', '2017-10-15 03:44:21', '17'), ('44', 'user-management-inactive', 'User Management Inactive', 'User Management Inactive', '2017-10-15 04:04:47', '2017-10-15 04:04:47', '17'), ('45', 'master-menu', 'Master Menu', 'Master Menu', '2017-10-15 05:51:36', '2017-10-15 05:51:36', '0'), ('46', 'layanan-menu', 'Layanan Menu', 'Layanan Menu', '2017-10-15 05:59:31', '2017-10-15 05:59:31', '0'), ('47', 'tour-admin-view', 'Admin Tour Menu', 'Admin Tour Menu', '2017-10-15 06:37:45', '2017-10-15 06:37:45', '45'), ('48', 'tour-admin-add', 'Admin Tour Add New', 'Admin Tour Add New', '2017-10-15 06:38:06', '2017-10-15 06:38:06', '47'), ('49', 'tour-admin-edit', 'Admin Tour Edit', 'Admin Tour Edit', '2017-10-15 06:39:13', '2017-10-15 06:39:13', '47'), ('50', 'tour-admin-delete', 'Admin Tour Delete', 'Admin Tour Delete', '2017-10-15 06:39:48', '2017-10-15 06:39:48', '47'), ('51', 'tour-menu', 'Tour Menu', 'Tour Menu', '2017-10-15 12:43:08', '2017-10-15 12:43:08', '46');
COMMIT;

-- ----------------------------
--  Table structure for `regions`
-- ----------------------------
DROP TABLE IF EXISTS `regions`;
CREATE TABLE `regions` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `is_active` int(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` int(6) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `regions`
-- ----------------------------
BEGIN;
INSERT INTO `regions` VALUES ('1', 'Asia', '1', '2017-10-15 14:01:19', '1', '2017-10-15 14:01:24', '1');
COMMIT;

-- ----------------------------
--  Table structure for `role_user`
-- ----------------------------
DROP TABLE IF EXISTS `role_user`;
CREATE TABLE `role_user` (
  `user_id` bigint(20) NOT NULL,
  `role_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`),
  KEY `role_id_2` (`role_id`),
  CONSTRAINT `role_user_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `role_user_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `role_user`
-- ----------------------------
BEGIN;
INSERT INTO `role_user` VALUES ('1', '1'), ('4', '2');
COMMIT;

-- ----------------------------
--  Table structure for `roles`
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
--  Records of `roles`
-- ----------------------------
BEGIN;
INSERT INTO `roles` VALUES ('1', 'super-admin', 'Super Admin', 'Akses Super ke Seluruh Menu', '2017-08-21 13:47:15', '2017-10-15 15:41:50'), ('2', 'admin', 'admin', 'Akses Admin', '2017-10-04 10:37:19', '2017-10-15 15:43:24'), ('4', 'mitra', 'Mitra', 'akses untuk client', '2017-10-15 15:43:54', '2017-10-15 15:43:54');
COMMIT;

-- ----------------------------
--  Table structure for `settings`
-- ----------------------------
DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `project_name` varchar(75) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `meta_keywords` varchar(255) DEFAULT NULL,
  `meta_description` varchar(255) DEFAULT NULL,
  `logo` text,
  `icon` text,
  `misi` text,
  `visi` text,
  `phone` varchar(25) DEFAULT NULL,
  `mobile` varchar(25) DEFAULT NULL,
  `whatsapp` varchar(25) DEFAULT NULL,
  `facebook` text,
  `twitter` text,
  `instagram` text,
  `address` text,
  `linkedin` text,
  `googleplus` text,
  `email` varchar(75) DEFAULT NULL,
  `developer` varchar(150) DEFAULT NULL,
  `location` text,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `google_analytic` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `creted_by` int(6) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `settings`
-- ----------------------------
BEGIN;
INSERT INTO `settings` VALUES ('1', 'Java Tour', 'Java Tour', 'Java, Tour, Java Tour', 'MarketPlace Tour Terbesar di Indonesia', 'Java, Tour, Java Tour', 'MarketPlace Tour Terbesar di Indonesia', '1508038121-352.png', '1508038100-352.png', null, null, '0251 8312163', '+6281908884313', '+6281908884313', '1', '2', '3', '<p>Bogor Baru B VII No. 7<br /> Bogor</p>', null, '4', 'barindra1988@gmail.com', null, null, null, null, '<script>\r\n  (function(i,s,o,g,r,a,m){i[\'GoogleAnalyticsObject\']=r;i[r]=i[r]||function(){\r\n  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),\r\n  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)\r\n  })(window,document,\'script\',\'https://www.google-analytics.com/analytics.js\',\'ga\');\r\n\r\n  ga(\'create\', \'UA-106002769-1\', \'auto\');\r\n  ga(\'send\', \'pageview\');\r\n\r\n</script>', null, null, '2017-10-15 03:28:41', null);
COMMIT;

-- ----------------------------
--  Table structure for `submenus`
-- ----------------------------
DROP TABLE IF EXISTS `submenus`;
CREATE TABLE `submenus` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `name` varchar(191) DEFAULT NULL,
  `url` varchar(191) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `description` varchar(191) DEFAULT NULL,
  `permission` varchar(191) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `submenus`
-- ----------------------------
BEGIN;
INSERT INTO `submenus` VALUES ('1', null, 'Add New', 'subemnu/add', 'fa fa-folder-open', '', 'submenu-add', '0017-07-25 14:56:00', '2017-08-21 15:10:46'), ('2', '1', 'Role', 'role/show', 'fa fa-cogs', '', 'role-view', '0017-07-25 14:58:00', '0017-07-25 14:58:00'), ('3', '1', 'Permission', 'permission/show', 'fa fa-unlock-alt', '', 'permission-view', '0017-07-25 15:32:00', '0017-07-25 15:32:00'), ('4', '1', 'Submenu', 'submenu/show', 'fa fa-folder-open', '', 'submenu-view', '0017-07-25 15:34:00', '0017-07-25 15:34:00'), ('5', '1', 'Thirdmenu', 'thirdmenu/show', 'fa fa-folder-open', null, 'thirdmenu-view', '2017-08-21 14:20:32', '2017-08-21 14:20:32'), ('6', '1', 'Menu', 'menu/show', 'fa fa-folder-open', null, 'menu-view', '2017-09-16 20:41:35', '2017-09-16 20:41:37'), ('14', '1', 'Setting', 'setting/show', 'fa fa-cog', null, 'setting-view', '2017-10-15 00:41:55', '2017-10-15 00:41:55'), ('15', '1', 'User Management', 'user/show', 'fa fa-user', null, 'user-management-view', '2017-10-15 03:35:39', '2017-10-15 03:45:16'), ('16', '3', 'Tour', 'tour/admin/show', 'ti ti-shopping-cart', null, 'tour-admin-view', '2017-10-15 06:44:48', '2017-10-15 06:44:48'), ('17', '0', 'Tour', null, 'ti ti-shopping-cart', null, '0', '2017-10-15 12:48:38', '2017-10-15 12:48:38'), ('18', '6', 'Tour', null, 'ti ti-shopping-cart', null, 'tour-menu', '2017-10-15 13:03:41', '2017-10-15 13:03:41');
COMMIT;

-- ----------------------------
--  Table structure for `thirdmenus`
-- ----------------------------
DROP TABLE IF EXISTS `thirdmenus`;
CREATE TABLE `thirdmenus` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `menu_id` int(11) DEFAULT NULL,
  `submenu_id` int(11) DEFAULT NULL,
  `name` varchar(191) DEFAULT NULL,
  `url` varchar(191) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `description` varchar(191) DEFAULT NULL,
  `permission` varchar(191) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `thirdmenus`
-- ----------------------------
BEGIN;
INSERT INTO `thirdmenus` VALUES ('2', '6', '18', 'Cari paket', 'tour/search', 'fa fa-search', null, 'tour-menu', '2017-10-15 13:04:58', '2017-10-15 15:33:42');
COMMIT;

-- ----------------------------
--  Table structure for `tour_banners`
-- ----------------------------
DROP TABLE IF EXISTS `tour_banners`;
CREATE TABLE `tour_banners` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `tour_id` bigint(20) DEFAULT NULL,
  `name` varchar(150) DEFAULT NULL,
  `description` text,
  `file` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` int(6) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `tour_id` (`tour_id`),
  CONSTRAINT `tour_banners_ibfk_1` FOREIGN KEY (`tour_id`) REFERENCES `tours` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `tour_banners`
-- ----------------------------
BEGIN;
INSERT INTO `tour_banners` VALUES ('1', '4', null, null, '1508070998-Sumatera3.jpg', '2017-10-15 12:36:38', '1', '2017-10-15 12:36:38', null), ('2', '4', null, null, '1508071144-Sumatera2.jpg', '2017-10-15 12:39:04', '1', '2017-10-15 12:39:04', null), ('3', '4', null, null, '1508071249-Sumatera3.jpg', '2017-10-15 12:40:49', '1', '2017-10-15 12:40:49', null), ('4', '5', null, null, '1508084085-Jawa2.jpg', '2017-10-15 16:14:45', '1', '2017-10-15 16:14:45', null);
COMMIT;

-- ----------------------------
--  Table structure for `tour_types`
-- ----------------------------
DROP TABLE IF EXISTS `tour_types`;
CREATE TABLE `tour_types` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tour_id` bigint(20) DEFAULT NULL,
  `type_id` int(6) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` int(6) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `tour_id` (`tour_id`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `tour_types_ibfk_1` FOREIGN KEY (`tour_id`) REFERENCES `tours` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tour_types_ibfk_2` FOREIGN KEY (`type_id`) REFERENCES `types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `tours`
-- ----------------------------
DROP TABLE IF EXISTS `tours`;
CREATE TABLE `tours` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `region_id` int(6) DEFAULT NULL,
  `country_id` int(6) DEFAULT NULL,
  `destination_id` int(6) DEFAULT NULL,
  `name` varchar(150) DEFAULT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `itinerary` text,
  `youtube` text,
  `term_condition` text,
  `exclude` varchar(50) DEFAULT NULL,
  `include` varchar(50) DEFAULT NULL,
  `price` double(15,0) DEFAULT NULL,
  `is_active` int(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` int(6) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `region_id` (`region_id`),
  KEY `destination_id` (`destination_id`),
  FULLTEXT KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `tours`
-- ----------------------------
BEGIN;
INSERT INTO `tours` VALUES ('4', '1', '1', '1', 'Jakarta - Lampung 3D', '3 Hari 2 Malam', '<p><strong>Day 1 :</strong></p>\r\n<p>Sesampainya di Pelabuhan Merak/Bandara Soekarno Hatta, langsung briefing dengan Local Guide (Java Tour Team)<br />berlanjut menuju Penginapan untuk Check In &ndash; Wisata Keliling Monas - Kota Tua sambil makan siang (nasi box) di<br />sekitar Kota Tua.<br />Perjalanan sholat isya ke Mesjid Istiqlal dan segera kembali ke penginapan, dan langsung makan malam (nasi box) &ndash;<br />free time.</p>\r\n<p>&nbsp;</p>\r\n<p><strong>Day 2 :</strong></p>\r\n<p>Setelah sarapan kita akan mengunjungi TMII selama seharian (full day) &ndash; makan siang (prasmanan) di salah satu<br />anjungan &ndash; explore museum2di TMII &ndash; makan malam (D&rsquo;cost)<br />Free time ke Tamini Square, untuk belanja oleh2 dan segeran kembali ke penginapan untuk beristirahat melanjutkan wisata besok.</p>\r\n<p>&nbsp;</p>\r\n<p><strong>Day 3 :</strong></p>\r\n<p>Setelah sarapan, langsung Check Out &ndash; perjalananan pulang ke Bandara Soekarno Hatta/menyebrang dari Merak ke<br />Bakauheni untuk menuju Pantai Pasir Putih, Lampung &ndash; makan siang di pinggir pantai. End of Service.<br />Terima kasih untuk keikutsertaan Anda bersama kami. Sampai jumpa dalam perjalanan tour lainnya.</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>', 'YOUTUBE', '<p>BIAYA &amp; PEMBAYARAN :</p>\r\n<ul>\r\n<li>Harga fleksibel, tergantung waktu keberangkatan, jumlah peserta dalam grup, jenis akomodasi yang<br />diminta, dan tempat-tempat yang ingin dituju sesuai permintaan khusus bila ada.</li>\r\n<li>Biaya International Airport tax / fuel charge dapat berubah sewaktu-waktu dengan / tanpa<br />pemberitahuan terlebih dahulu, sesuai dengan peraturan pihak penerbangan terkait</li>\r\n<li>Booking Fee Rp. 100.000,- sampai dengan tgl 18 Juli 2016 (non refundable)</li>\r\n<li>Deposit 50% maksimal 2 bln sebelum keberangkatan</li>\r\n<li>Pelunasan maksimal 1 bln sebelum keberangkatan</li>\r\n<li>Tidak ada pengembalian utk tour/object yg tdk terpakai</li>\r\n<li>Biaya pembatalan dlm waktu kurang dari 60 hari sebelum keberangkatan dikenakan biaya 70%</li>\r\n<li>Biaya pembatalan dlm waktu kurang dari 30 hari sebelum keberangkatan dikenakan biaya 100%</li>\r\n<li>Pembayaran dalam rupiah mengikuti kurs yang berlaku di pasaran (kurs BCA) pada saat terjadi<br />transaksi pembayaran</li>\r\n<li>Harga dapat berubah sewaktu-waktu</li>\r\n</ul>', '1', '2,3', '1300000', '1', '2017-10-15 10:40:38', '1', '2017-10-15 12:33:09', '1'), ('5', '1', '1', '2', 'Cottage Pulau Seribu', '2 Hari 1 Malam', '<p><strong>Day 1 :</strong></p>\r\n<p>Para peserta berkumpul di Dermaga Marina, Pier 17 minimum 2 jam sebelum keberangkatan untuk memulai acara<br />perjalanan menuju Cottage di Pulau Seribu.<br />Tiba di salah satu Pulau Seribu tujuan, langsung check-in Cottage dan Makan Siang sebelum mempersiapkan main air.<br />Setelah Ishoma, menuju perahu kayu untuk kegiatan Snorkeling di gugusan pulau-pulau kecil di sekitar Cottage.<br />Menikmati Sunset di suatu pulau atau dalam perjalanan pulang menuju Cottage, setiba di Cottage bersih-bersih dan<br />langsung mempersiapkan diri untuk berkumpul bersama dalam Makan Malam dan BBQ.</p>\r\n<p>&nbsp;</p>\r\n<p><strong>Day 2 :</strong></p>\r\n<p>Bangun pagi dan langsung hunting Sunrise di sekitar dermaga Cottage, bersiap check out dan langsung menikmati Sarapan.<br />Menuju kapal cepat untuk perjalanan pulang menuju Jakarta.<br />Tiba di Jakarta. Terima kasih untuk keikutsertaan Anda bersama kami. Sampai jumpa dalam perjalanan tour lainnya.</p>', null, '<p><strong>PENTING :</strong><br />*)Bonus berlaku untuk Paket Rombongan (min.25 orang)<br />Kami berhak membatasi jumlah peserta sesuai kesepakatan, merubah jadwal keberangkatan dengan<br />alasan keselamatan (karena situasi yang tidak memungkinkan), men-set ulang rute-rute perjalanan<br />bila terjadi hal-hal diluar dugaan kami / force majeur, dengan terlebih dahulu menginformasikan<br />kepada Anda.</p>\r\n<p><br /><strong><em>BIAYA &amp; PEMBAYARAN :</em></strong></p>\r\n<ul>\r\n<li>Harga fleksibel, tergantung waktu keberangkatan, jumlah peserta dalam grup, jenis akomodasi yang<br />diminta, dan tempat-tempat yang ingin dituju sesuai permintaan khusus bila ada;</li>\r\n<li>Booking Fee minimal Rp 500.000,- langsung dibayarkan pada saat pendaftaran (non refundable);</li>\r\n<li>Deposit 50% minimal 1 hari setelah deal dan maksimal 2 bulan sebelum keberangkatan;</li>\r\n<li>Pelunasan maksimal 1 bulan sebelum keberangkatan;</li>\r\n<li>Tidak ada pengembalian untuk tour/obyek yg tidak terpakai;</li>\r\n<li>Biaya pembatalan dlm waktu kurang dari 20 hari sebelum keberangkatan dikenakan biaya 70%;</li>\r\n<li>Biaya pembatalan dlm waktu kurang dari 7 hari sebelum keberangkatan dikenakan biaya 100%;</li>\r\n<li>Harga dapat berubah sewaktu-waktu.</li>\r\n</ul>', '1', '2,3', '850000', '1', '2017-10-15 16:13:17', '1', '2017-10-15 16:13:17', '1');
COMMIT;

-- ----------------------------
--  Table structure for `types`
-- ----------------------------
DROP TABLE IF EXISTS `types`;
CREATE TABLE `types` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(75) DEFAULT NULL,
  `show` int(1) DEFAULT NULL,
  `is_active` int(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` int(6) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `types`
-- ----------------------------
BEGIN;
INSERT INTO `types` VALUES ('1', 'Hot Offer', '1', '1', '2017-10-15 12:55:55', '1', '2017-10-15 12:55:58', '1'), ('2', 'Private Trip', '1', '1', '2017-10-15 12:56:38', '1', '2017-10-15 12:56:42', '1'), ('3', 'Open Trip', '1', '1', '2017-10-15 12:57:20', '1', '2017-10-15 12:57:24', '1'), ('4', 'Custom Trip', '0', '1', '2017-10-15 12:57:40', '1', '2017-10-15 12:57:45', '1');
COMMIT;

-- ----------------------------
--  Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `date_of_bird` date DEFAULT NULL,
  `place_of_bird` varchar(150) DEFAULT NULL,
  `address` text,
  `city` varchar(150) DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `email_token` varchar(255) DEFAULT NULL,
  `remember_token` varchar(150) DEFAULT NULL,
  `is_active` varchar(1) DEFAULT NULL COMMENT '0 = inactive, 1 active',
  `last_login` datetime DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL COMMENT 'link to media/users',
  `wallet` float(15,0) DEFAULT NULL,
  `wallet_date` datetime DEFAULT NULL,
  `wallet_realtime` float(15,0) DEFAULT NULL,
  `wallet_update` datetime DEFAULT NULL,
  `up` int(20) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_id` (`id`) USING BTREE,
  KEY `idx_wallet` (`wallet_realtime`,`wallet_update`) USING BTREE,
  KEY `idx_up` (`up`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `users`
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES ('1', 'Barindra', 'barindra1988@gmail.com', '$2y$10$TXTSsJhhNW1U61.15Y59RejS5J1utOSawNvmteDS8S3f/4HpMb26S', '1988-07-19', 'Bogor', 'Bogor Baru B VII No. 7<br>', 'BOGOR', null, null, 'B7X3EcQKjOImCtx5dLgMumK1SrBYkmaQqhhiRVIJTOjs5BsVf2q7uAtJo37h', '1', null, '', null, null, null, null, null, null, '2017-08-20 16:11:28', null, '2017-08-22 16:33:00'), ('4', 'Barind testing', 'testing.website1988@gmail.com', '$2y$10$EvmVYczrY1vG/kGZl4LHZ.eUvBlkpzQ5ZeLX1aYL3ZIGJDZnvqQva', null, null, null, null, null, 'dGVzdGluZy53ZWJzaXRlMTk4OEBnbWFpbC5jb20=', 'Uz40mIeeqaL8KiMjuk4eCG6FXniKUwdLsk8QSlE42PSbZ6OALZKPHilOigS6', '1', null, null, '0', '2017-10-04 10:43:31', '0', '2017-10-04 10:43:31', '0', null, '2017-10-04 10:43:31', null, '2017-10-15 15:57:57');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
