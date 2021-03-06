/*
 Navicat Premium Data Transfer

 Source Server         : Java Tour
 Source Server Type    : MySQL
 Source Server Version : 50505
 Source Host           : develop.java-travel.co.id
 Source Database       : c1tour

 Target Server Type    : MySQL
 Target Server Version : 50505
 File Encoding         : utf-8

 Date: 10/25/2017 21:06:34 PM
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
--  Records of `activity_log`
-- ----------------------------
BEGIN;
INSERT INTO `activity_log` VALUES ('1', '4', 'Country', '0', 'Update', 'Ada kesalahan saat menyimpan data', 'SQLSTATE[23000]: Integrity constraint violation: 1452 Cannot add or update a child row: a foreign key constraint fails (`c1tour`.`countrys`, CONSTRAINT `countrys_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE) (SQL: insert into `countrys` (`name`, `region_id`, `is_active`, `created_by`, `updated_by`, `updated_at`, `created_at`) values (Indonesia, 0, 1, 4, 4, 2017-10-25 08:05:15, 2017-10-25 08:05:15))', '{\"user_id\":4,\"country\":\"Indonesia\",\"region_id\":\"0\"}', null, null, null, '36.88.132.36', 'Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36', '2017-10-25 08:05:16', '2017-10-25 08:05:16');
COMMIT;

-- ----------------------------
--  Table structure for `audit_logs`
-- ----------------------------
DROP TABLE IF EXISTS `audit_logs`;
CREATE TABLE `audit_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `last_logout` datetime DEFAULT NULL,
  `ip_address` varchar(16) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `address` text,
  `lat` decimal(10,8) DEFAULT NULL,
  `long` decimal(11,8) DEFAULT NULL,
  `device` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_id` (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `audit_logs`
-- ----------------------------
BEGIN;
INSERT INTO `audit_logs` VALUES ('1', '1', '2017-10-24 06:45:52', null, '::1', '2017-10-24 06:45:52', '2017-10-24 06:45:52', 'New Haven 06510 United States', '41.31000000', '-72.92000000', 'Desktop [Firefox]'), ('2', '1', '2017-10-24 06:46:26', null, '::1', '2017-10-24 06:46:26', '2017-10-24 06:46:26', 'New Haven 06510 United States', '41.31000000', '-72.92000000', 'Desktop [Firefox]'), ('3', '1', null, '2017-10-24 06:47:22', '::1', '2017-10-24 06:47:22', '2017-10-24 06:47:22', 'New Haven 06510 United States', '41.31000000', '-72.92000000', 'Desktop [Firefox]'), ('4', '8', '2017-10-24 07:07:14', null, '::1', '2017-10-24 07:07:14', '2017-10-24 07:07:14', 'New Haven 06510 United States', '41.31000000', '-72.92000000', 'Desktop [Firefox]'), ('5', '1', '2017-10-24 07:59:16', null, '112.215.235.108', '2017-10-24 07:59:16', '2017-10-24 07:59:16', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Mobile [iPhone|Safari]'), ('6', '1', null, '2017-10-24 08:01:47', '122.144.3.157', '2017-10-24 08:01:47', '2017-10-24 08:01:47', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Firefox]'), ('7', '1', '2017-10-24 08:01:59', null, '122.144.3.157', '2017-10-24 08:01:59', '2017-10-24 08:01:59', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Firefox]'), ('8', '1', null, '2017-10-24 08:04:40', '122.144.3.157', '2017-10-24 08:04:40', '2017-10-24 08:04:40', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Firefox]'), ('9', '1', '2017-10-24 08:08:47', null, '122.144.3.157', '2017-10-24 08:08:47', '2017-10-24 08:08:47', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Firefox]'), ('10', '1', null, '2017-10-24 08:08:55', '122.144.3.157', '2017-10-24 08:08:55', '2017-10-24 08:08:55', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Firefox]'), ('11', '7', '2017-10-24 08:09:20', null, '122.144.3.157', '2017-10-24 08:09:20', '2017-10-24 08:09:20', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Firefox]'), ('12', '7', null, '2017-10-24 08:10:03', '122.144.3.157', '2017-10-24 08:10:03', '2017-10-24 08:10:03', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Firefox]'), ('13', '5', null, '2017-10-24 08:59:49', '36.88.132.36', '2017-10-24 08:59:49', '2017-10-24 08:59:49', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Mobile [1|Chrome]'), ('14', '4', '2017-10-24 09:00:24', null, '36.88.132.36', '2017-10-24 09:00:24', '2017-10-24 09:00:24', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Mobile [WebKit|Chrome]'), ('15', '4', null, '2017-10-24 09:16:42', '36.88.132.36', '2017-10-24 09:16:42', '2017-10-24 09:16:42', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('16', '5', '2017-10-24 09:17:14', null, '36.88.132.36', '2017-10-24 09:17:14', '2017-10-24 09:17:14', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('17', '4', null, '2017-10-24 09:49:57', '36.88.132.36', '2017-10-24 09:49:57', '2017-10-24 09:49:57', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Mobile [1|Chrome]'), ('18', '5', null, '2017-10-24 10:02:48', '36.88.132.36', '2017-10-24 10:02:48', '2017-10-24 10:02:48', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('19', '5', '2017-10-24 10:12:40', null, '36.88.132.36', '2017-10-24 10:12:40', '2017-10-24 10:12:40', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('20', '5', null, '2017-10-24 11:32:06', '36.88.132.36', '2017-10-24 11:32:06', '2017-10-24 11:32:06', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('21', '5', '2017-10-24 11:32:29', null, '36.88.132.36', '2017-10-24 11:32:29', '2017-10-24 11:32:29', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('22', '5', null, '2017-10-24 11:49:24', '36.88.132.36', '2017-10-24 11:49:24', '2017-10-24 11:49:24', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('23', '4', '2017-10-24 11:49:46', null, '36.88.132.36', '2017-10-24 11:49:46', '2017-10-24 11:49:46', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('24', '5', '2017-10-24 13:09:10', null, '112.215.235.111', '2017-10-24 13:09:10', '2017-10-24 13:09:10', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Mobile [WebKit|Chrome]'), ('25', '1', '2017-10-24 15:05:45', null, '202.62.16.249', '2017-10-24 15:05:45', '2017-10-24 15:05:45', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Mobile [iPhone|Safari]'), ('26', '5', '2017-10-25 06:13:59', null, '36.88.132.36', '2017-10-25 06:13:59', '2017-10-25 06:13:59', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('27', '5', null, '2017-10-25 06:14:06', '36.88.132.36', '2017-10-25 06:14:06', '2017-10-25 06:14:06', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('28', '4', '2017-10-25 06:14:18', null, '36.88.132.36', '2017-10-25 06:14:18', '2017-10-25 06:14:18', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('29', '4', null, '2017-10-25 07:36:03', '36.88.132.36', '2017-10-25 07:36:03', '2017-10-25 07:36:03', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('30', '5', '2017-10-25 07:36:21', null, '36.88.132.36', '2017-10-25 07:36:21', '2017-10-25 07:36:21', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('31', '4', '2017-10-25 07:47:14', null, '36.88.132.36', '2017-10-25 07:47:14', '2017-10-25 07:47:14', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('32', '1', '2017-10-25 13:59:55', null, '202.62.18.24', '2017-10-25 13:59:55', '2017-10-25 13:59:55', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Safari]'), ('33', '1', null, '2017-10-25 14:05:52', '202.62.18.24', '2017-10-25 14:05:52', '2017-10-25 14:05:52', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Safari]');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `countrys`
-- ----------------------------
BEGIN;
INSERT INTO `countrys` VALUES ('1', 'Indonesia', '1', '1', '2017-10-15 14:02:04', '1', '2017-10-15 14:02:08', '1'), ('2', 'Mesir', '2', '1', '2017-10-25 07:00:17', '4', '2017-10-25 07:00:17', '4'), ('3', 'Mesir', '2', '1', '2017-10-25 07:00:21', '4', '2017-10-25 07:00:21', '4'), ('5', 'Indonesia', '2', '1', '2017-10-25 08:05:27', '4', '2017-10-25 08:05:27', '4');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `destinations`
-- ----------------------------
BEGIN;
INSERT INTO `destinations` VALUES ('1', 'Lampung', '1', '1', '1', '2017-10-15 14:02:32', '1', '2017-10-15 14:02:35', '1'), ('2', 'Jawa', '1', '1', '1', '2017-10-15 23:10:29', '1', '2017-10-15 23:10:34', '1'), ('3', 'Malang', '2', '5', '1', '2017-10-25 08:07:16', '4', '2017-10-25 08:07:16', '4');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `includes`
-- ----------------------------
BEGIN;
INSERT INTO `includes` VALUES ('1', 'Tiket Pesawat', 'fa fa-plane', null, '1', '2017-10-15 16:01:16', '1', '2017-10-15 16:01:19', '1'), ('2', 'Akomodasi sesuai paket', 'fa fa-car', null, '1', '2017-10-15 16:11:26', '1', '2017-10-15 16:11:30', '1'), ('3', 'Hotel', 'ti ti-home', null, '1', '2017-10-15 16:13:16', '1', '2017-10-15 16:13:20', '1'), ('4', 'Makan', null, 'Makan Sesuai Program', '1', '2017-10-25 07:06:04', '4', '2017-10-25 07:06:04', '4'), ('5', 'pengeluaran pribadi', null, 'segala jenis pengeluaran pribadi', '1', '2017-10-25 08:13:50', '4', '2017-10-25 08:13:50', '4'), ('6', 'travel insurance', null, 'tabungan perjalanan wisata', '1', '2017-10-25 08:14:37', '4', '2017-10-25 08:14:37', '4');
COMMIT;

-- ----------------------------
--  Table structure for `komisi_types`
-- ----------------------------
DROP TABLE IF EXISTS `komisi_types`;
CREATE TABLE `komisi_types` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` int(6) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `komisi_types`
-- ----------------------------
BEGIN;
INSERT INTO `komisi_types` VALUES ('1', 'Keagenan', '2017-10-21 21:25:17', '1', '2017-10-21 21:25:20', '1'), ('2', 'Transaksi', '2017-10-21 21:26:42', '1', '2017-10-21 21:26:45', '1');
COMMIT;

-- ----------------------------
--  Table structure for `komisis`
-- ----------------------------
DROP TABLE IF EXISTS `komisis`;
CREATE TABLE `komisis` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `komisi_type_id` int(6) DEFAULT NULL,
  `level_id` int(6) DEFAULT NULL,
  `level` int(6) DEFAULT NULL,
  `komisi` decimal(15,0) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` int(6) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `komisi_type_id` (`komisi_type_id`),
  KEY `level_id` (`level_id`),
  CONSTRAINT `komisis_ibfk_2` FOREIGN KEY (`level_id`) REFERENCES `levels` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `komisis_ibfk_3` FOREIGN KEY (`komisi_type_id`) REFERENCES `komisi_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `komisis`
-- ----------------------------
BEGIN;
INSERT INTO `komisis` VALUES ('1', '1', '4', '4', '60', '2017-10-21 15:52:12', '1', '2017-10-22 14:48:39', '1'), ('4', '2', '4', '2', '40', '2017-10-21 16:06:47', '1', '2017-10-22 14:48:34', '1');
COMMIT;

-- ----------------------------
--  Table structure for `levels`
-- ----------------------------
DROP TABLE IF EXISTS `levels`;
CREATE TABLE `levels` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `status` int(1) DEFAULT '2' COMMENT 'Note :\n- 1 = Pusat [tidak dapat dihapus]\n- 2 = Normal',
  `order` int(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` int(6) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `levels`
-- ----------------------------
BEGIN;
INSERT INTO `levels` VALUES ('1', 'Java Pusat', '1', '0', '2017-10-19 06:39:12', '1', '2017-10-19 06:39:12', '1'), ('2', 'Cabang', '1', '1', '2017-10-19 07:27:44', '1', '2017-10-19 07:33:36', '1'), ('3', 'Master Distributor', '1', '2', '2017-10-19 07:33:58', '1', '2017-10-19 07:36:57', '1'), ('4', 'Distributor', '1', '3', '2017-10-21 14:12:34', '1', '2017-10-22 14:55:51', '1'), ('5', 'Agen', '1', '4', '2017-10-23 14:59:53', '1', '2017-10-23 14:59:57', '1');
COMMIT;

-- ----------------------------
--  Table structure for `memberships`
-- ----------------------------
DROP TABLE IF EXISTS `memberships`;
CREATE TABLE `memberships` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `store_name` varchar(150) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `address` text,
  `province_id` int(6) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `upline` int(6) DEFAULT '0',
  `is_active` int(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` int(6) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `order` int(6) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `menus`
-- ----------------------------
BEGIN;
INSERT INTO `menus` VALUES ('1', 'Admin', null, 'admin-menu', 'fa fa-cog', '5', '0017-07-25 14:44:00', '2017-10-23 05:19:15'), ('3', 'Master', null, 'master-menu', 'glyphicon glyphicon-hdd', '4', '2017-10-02 08:10:05', '2017-10-23 05:19:04'), ('6', 'Layanan', null, 'layanan-menu', 'ti  ti-harddrives', '2', '2017-10-15 06:01:12', '2017-10-23 05:18:31'), ('7', 'Membership', null, 'membership-menu', 'fa fa-users', '3', '2017-10-19 15:02:07', '2017-10-23 05:18:44'), ('8', 'Profile Usaha', 'user/info', 'profile-menu', 'fa fa-user', '1', '2017-10-23 04:40:40', '2017-10-23 04:44:49');
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
INSERT INTO `permission_role` VALUES ('1', '1'), ('2', '1'), ('3', '1'), ('4', '1'), ('5', '1'), ('6', '1'), ('7', '1'), ('8', '1'), ('9', '1'), ('9', '2'), ('10', '1'), ('11', '1'), ('12', '1'), ('13', '1'), ('14', '1'), ('15', '1'), ('16', '1'), ('17', '1'), ('17', '2'), ('18', '1'), ('19', '1'), ('20', '1'), ('21', '1'), ('39', '1'), ('39', '2'), ('40', '1'), ('40', '2'), ('41', '1'), ('41', '2'), ('42', '1'), ('42', '2'), ('43', '1'), ('43', '2'), ('44', '1'), ('44', '2'), ('45', '1'), ('45', '2'), ('46', '1'), ('46', '2'), ('46', '4'), ('47', '1'), ('47', '2'), ('48', '1'), ('48', '2'), ('49', '1'), ('49', '2'), ('50', '1'), ('50', '2'), ('51', '1'), ('51', '2'), ('51', '4'), ('52', '1'), ('52', '2'), ('53', '1'), ('53', '2'), ('54', '1'), ('54', '2'), ('55', '1'), ('55', '2'), ('56', '1'), ('56', '2'), ('57', '1'), ('57', '2'), ('58', '1'), ('58', '2'), ('59', '1'), ('59', '2'), ('60', '1'), ('60', '2'), ('61', '1'), ('61', '2'), ('62', '1'), ('62', '2'), ('63', '1'), ('63', '2'), ('64', '1'), ('64', '2'), ('65', '1'), ('65', '2'), ('66', '1'), ('66', '2'), ('67', '1'), ('67', '2'), ('68', '1'), ('68', '2'), ('69', '1'), ('69', '2'), ('70', '1'), ('70', '2'), ('71', '1'), ('71', '2'), ('72', '1'), ('73', '1'), ('73', '2'), ('74', '1'), ('74', '2'), ('75', '1'), ('75', '2'), ('76', '1'), ('76', '2'), ('77', '1'), ('77', '2'), ('78', '1'), ('78', '2'), ('79', '1'), ('79', '2'), ('79', '4'), ('80', '1'), ('80', '2'), ('80', '4'), ('81', '1'), ('81', '2'), ('81', '4'), ('82', '1'), ('82', '2'), ('83', '1'), ('83', '2'), ('83', '4'), ('84', '1'), ('84', '2');
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
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
--  Records of `permissions`
-- ----------------------------
BEGIN;
INSERT INTO `permissions` VALUES ('1', 'permission-add', 'Permission Add', 'Access to add Permission', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('2', 'permission-edit', 'Permission Edit', 'access to edit Permission', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('3', 'permission-delete', 'Permission Delete', 'Access to delete Permission', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('4', 'permission-view', 'Permission View', 'Access to view Permission form', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('5', 'role-view', 'Role View', 'Access to view Role Page', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('6', 'role-add', 'Role Add', 'Access to add Role', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('7', 'role-edit', 'Role Edit', 'Access to edit Role', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('8', 'role-delete', 'Role Delete', 'Access to delete Role', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('9', 'menu-view', 'Menu View', 'Access to View Page Menu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('10', 'menu-add', 'Menu Add', 'Access to form add menu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('11', 'menu-edit', 'Menu Edit', 'Access to Edit Menu Form', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('12', 'menu-delete', 'Menu Delete', 'Access to Delete Menu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('13', 'submenu-view', 'Submenu View', 'Access to View Submenu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('14', 'submenu-add', 'Submenu Add', 'Access to Add Form Submenu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('15', 'submenu-edit', 'Submenu Edit', 'Access to Edit Submenu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('16', 'submenu-delete', 'Submenu Delete', 'Access to Delete Submenu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('17', 'user-management-view', 'User Management Menu', 'User Management Menu', '0000-00-00 00:00:00', '2017-10-15 03:43:22', '0'), ('18', 'thirdmenu-view', 'Thirdmenu View', 'Access to view Thirdmenu', '2017-08-21 14:17:29', '2017-08-21 14:17:55', '0'), ('19', 'thirdmenu-add', 'Thirdmenu Add', 'Access to Add New Thirdmenu', '2017-08-21 14:18:25', '2017-08-22 04:08:32', '18'), ('20', 'thirdmenu-edit', 'Thirdmenu Edit', 'Access to Edit Thirdmenu', '2017-08-21 14:18:56', '2017-08-22 04:08:51', '18'), ('21', 'thirdmenu-delete', 'Thirdmenu Delete', 'Access to Delete Thirdmenu', '2017-08-21 14:19:32', '2017-08-22 04:09:14', '18'), ('39', 'setting-view', 'Setting Menu', 'Setting Menu', '2017-10-14 16:38:14', '2017-10-14 16:38:14', '0'), ('40', 'setting-edit', 'Edit Setting System', 'Edit Setting System', '2017-10-15 03:19:01', '2017-10-15 03:19:01', '39'), ('41', 'user-management-edit', 'User Management Edit', 'User Management Edit', '2017-10-15 03:36:08', '2017-10-15 03:43:40', '17'), ('42', 'user-management-add', 'User Management Add New', 'User Management Add New', '2017-10-15 03:36:31', '2017-10-15 03:43:59', '17'), ('43', 'user-management-delete', 'User Management Delete', 'User Management Delete', '2017-10-15 03:38:28', '2017-10-15 03:44:21', '17'), ('44', 'user-management-inactive', 'User Management Inactive', 'User Management Inactive', '2017-10-15 04:04:47', '2017-10-15 04:04:47', '17'), ('45', 'master-menu', 'Master Menu', 'Master Menu', '2017-10-15 05:51:36', '2017-10-15 05:51:36', '0'), ('46', 'layanan-menu', 'Layanan Menu', 'Layanan Menu', '2017-10-15 05:59:31', '2017-10-15 05:59:31', '0'), ('47', 'tour-admin-view', 'Admin Tour Menu', 'Admin Tour Menu', '2017-10-15 06:37:45', '2017-10-15 06:37:45', '45'), ('48', 'tour-admin-add', 'Admin Tour Add New', 'Admin Tour Add New', '2017-10-15 06:38:06', '2017-10-15 06:38:06', '47'), ('49', 'tour-admin-edit', 'Admin Tour Edit', 'Admin Tour Edit', '2017-10-15 06:39:13', '2017-10-15 06:39:13', '47'), ('50', 'tour-admin-delete', 'Admin Tour Delete', 'Admin Tour Delete', '2017-10-15 06:39:48', '2017-10-15 06:39:48', '47'), ('51', 'tour-menu', 'Tour Menu', 'Tour Menu', '2017-10-15 12:43:08', '2017-10-15 12:43:08', '46'), ('52', 'region-admin-view', 'Region Menu', 'Region Menu', '2017-10-17 07:12:09', '2017-10-17 07:12:09', '45'), ('53', 'region-admin-add', 'Region Add New', 'Region Add New', '2017-10-17 07:13:16', '2017-10-17 07:13:16', '52'), ('54', 'region-admin-edit', 'Region Edit', 'Region Edit', '2017-10-17 07:13:48', '2017-10-17 07:13:48', '52'), ('55', 'region-admin-delete', 'Region Delete', 'Region Delete', '2017-10-17 07:14:09', '2017-10-17 07:14:09', '52'), ('56', 'region-admin-inactive', 'Region Inactive', 'Region Inactive', '2017-10-17 07:14:31', '2017-10-17 07:14:31', '52'), ('57', 'country-admin-view', 'Country Menu', 'Country Menu', '2017-10-17 10:14:40', '2017-10-17 14:29:12', '45'), ('58', 'country-admin-add', 'Country Add New', 'Country Add New', '2017-10-17 10:15:23', '2017-10-17 10:15:23', '57'), ('59', 'country-admin-edit', 'Country Edit', 'Country Edit', '2017-10-17 10:15:43', '2017-10-17 10:15:43', '57'), ('60', 'country-admin-delete', 'Country Delete', 'Country Delete', '2017-10-17 10:16:22', '2017-10-17 10:16:22', '57'), ('61', 'country-admin-inactive', 'Country Inactive', 'Country Inactive', '2017-10-17 10:16:43', '2017-10-17 10:16:43', '57'), ('62', 'country-admin-activate', 'Country Activate', 'Country Diaktifkan', '2017-10-17 14:27:43', '2017-10-17 14:27:43', '57'), ('63', 'destination-admin-view', 'Destination Menu', 'Destination Menu', '2017-10-17 19:31:57', '2017-10-17 19:31:57', '45'), ('64', 'destination-admin-add', 'Destination Add New', 'Destination Add New', '2017-10-17 19:32:25', '2017-10-17 19:32:25', '63'), ('65', 'destination-admin-edit', 'Destination Edit', 'Destination Edit', '2017-10-17 19:32:47', '2017-10-17 19:32:47', '63'), ('66', 'destination-admin-delete', 'Destination Delete', 'Destination Delete', '2017-10-17 19:33:13', '2017-10-17 19:33:13', '63'), ('67', 'destination-admin-inactive', 'Destination Inactive', 'Destination Inactive', '2017-10-17 19:33:45', '2017-10-17 19:33:45', '63'), ('68', 'destination-admin-activate', 'Destination Activate', 'Destination Activate', '2017-10-17 19:34:06', '2017-10-17 19:34:06', '63'), ('69', 'level-admin-view', 'Level Menu', 'Level Menu', '2017-10-19 03:55:19', '2017-10-19 03:55:19', '45'), ('70', 'level-admin-add', 'Level Add New', 'Level Add New', '2017-10-19 03:55:55', '2017-10-19 03:57:18', '69'), ('71', 'level-admin-edit', 'Level Edit', 'Leve Edit', '2017-10-19 03:57:03', '2017-10-19 03:57:03', '69'), ('72', 'level-admin-delete', 'Level Delete', 'Level Delete', '2017-10-19 03:57:46', '2017-10-19 03:57:46', '69'), ('73', 'include-admin-view', 'Include/Exclude Menu', 'Include/Exclude Menu', '2017-10-19 08:16:26', '2017-10-19 08:16:26', '45'), ('74', 'include-admin-add', 'Include/Exclude Add New', 'Include/Exclude Add New', '2017-10-19 08:16:47', '2017-10-19 08:16:47', '73'), ('75', 'include-admin-edit', 'Include/Exclude Edit', 'Include/Exclude Edit', '2017-10-19 08:17:08', '2017-10-19 08:17:08', '73'), ('76', 'include-admin-delete', 'Include/Exclude Delete', 'Include/Exclude Delete', '2017-10-19 08:17:40', '2017-10-19 08:17:40', '73'), ('77', 'include-admin-inactive', 'Include/Exclude Inactive', 'Include/Exclude Inactive', '2017-10-19 08:18:12', '2017-10-19 08:18:12', '73'), ('78', 'include-admin-activate', 'Include/Exclude Activate', 'Include/Exclude Activate', '2017-10-19 08:18:35', '2017-10-19 08:18:35', '73'), ('79', 'membership-menu', 'Membership Menu', 'Membership Menu', '2017-10-19 15:01:28', '2017-10-19 15:01:28', '0'), ('80', 'pendaftaran-agen-view', 'Pendaftaran Agen Menu', 'Pedaftaran Agen', '2017-10-19 15:03:05', '2017-10-19 15:04:44', '79'), ('81', 'pendaftaran-agen-add', 'Form Pendaftaran Agen', 'Form Pendaftaran Agen', '2017-10-19 15:05:10', '2017-10-19 15:05:10', '80'), ('82', 'admin-menu', 'Admin Menu', 'Admin Menu', '2017-10-23 04:37:30', '2017-10-23 04:37:30', '0'), ('83', 'profile-menu', 'Profile Menu', 'Profile Menu', '2017-10-23 04:39:56', '2017-10-23 04:39:56', '0'), ('84', 'region-admin-activate', 'Region Activate', 'Region Activate', '2017-10-25 14:04:40', '2017-10-25 14:04:40', '52');
COMMIT;

-- ----------------------------
--  Table structure for `provinces`
-- ----------------------------
DROP TABLE IF EXISTS `provinces`;
CREATE TABLE `provinces` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` int(6) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `provinces`
-- ----------------------------
BEGIN;
INSERT INTO `provinces` VALUES ('1', 'Sumatera Utara', null, null, null, null), ('2', 'Bali', null, null, null, null), ('3', 'Bangka Belitung', null, null, null, null), ('4', 'Banten', null, null, null, null), ('5', 'Bengkulu', null, null, null, null), ('6', 'DI Yogyakarta', null, null, null, null), ('7', 'DKI Jakarta', null, null, null, null), ('8', 'Gorontalo', null, null, null, null), ('9', 'Jambi', null, null, null, null), ('10', 'Jawa Barat', null, null, null, null), ('11', 'Jawa Tengah', null, null, null, null), ('12', 'Jawa Timur', null, null, null, null), ('13', 'Kalimantan Barat', null, null, null, null), ('14', 'Kalimantan Selatan', null, null, null, null), ('15', 'Kalimantan Tengah', null, null, null, null), ('16', 'Kalimantan Timur', null, null, null, null), ('17', 'Kalimantan Utara', null, null, null, null), ('18', 'Kepulauan Riau', null, null, null, null), ('19', 'Lampung', null, null, null, null), ('20', 'Maluku', null, null, null, null), ('21', 'Maluku Utara', null, null, null, null), ('22', 'Nanggroe Aceh Darussalam (NAD)', null, null, null, null), ('23', 'Nusa Tenggara Barat (NTB)', null, null, null, null), ('24', 'Nusa Tenggara Timur (NTT)', null, null, null, null), ('25', 'Papua', null, null, null, null), ('26', 'Papua Barat', null, null, null, null), ('27', 'Riau', null, null, null, null), ('28', 'Sulawesi Barat', null, null, null, null), ('29', 'Sulawesi Selatan', null, null, null, null), ('30', 'Sulawesi Tengah', null, null, null, null), ('31', 'Sulawesi Tenggara', null, null, null, null), ('32', 'Sulawesi Utara', null, null, null, null), ('33', 'Sumatera Barat', null, null, null, null), ('34', 'Sumatera Selatan', null, null, null, null);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `regions`
-- ----------------------------
BEGIN;
INSERT INTO `regions` VALUES ('1', 'Asia', '0', '2017-10-15 14:01:19', '1', '2017-10-25 06:58:55', '4'), ('2', 'Afrika', '1', '2017-10-25 06:58:07', '4', '2017-10-25 06:58:07', '4');
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
INSERT INTO `role_user` VALUES ('1', '1'), ('4', '2'), ('5', '4'), ('7', '4'), ('8', '4'), ('9', '4');
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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `submenus`
-- ----------------------------
BEGIN;
INSERT INTO `submenus` VALUES ('1', null, 'Add New', 'subemnu/add', 'fa fa-folder-open', '', 'submenu-add', '0017-07-25 14:56:00', '2017-08-21 15:10:46'), ('2', '1', 'Role', 'role/show', 'fa fa-cogs', '', 'role-view', '0017-07-25 14:58:00', '0017-07-25 14:58:00'), ('3', '1', 'Permission', 'permission/show', 'fa fa-unlock-alt', '', 'permission-view', '0017-07-25 15:32:00', '0017-07-25 15:32:00'), ('4', '1', 'Submenu', 'submenu/show', 'fa fa-folder-open', '', 'submenu-view', '0017-07-25 15:34:00', '0017-07-25 15:34:00'), ('5', '1', 'Thirdmenu', 'thirdmenu', 'fa fa-folder-open', null, 'thirdmenu-view', '2017-08-21 14:20:32', '2017-10-15 16:55:35'), ('6', '1', 'Menu', 'menu/show', 'fa fa-folder-open', null, 'menu-view', '2017-09-16 20:41:35', '2017-09-16 20:41:37'), ('14', '1', 'Setting', 'setting/show', 'fa fa-cog', null, 'setting-view', '2017-10-15 00:41:55', '2017-10-15 00:41:55'), ('15', '1', 'User Management', 'user/show', 'fa fa-user', null, 'user-management-view', '2017-10-15 03:35:39', '2017-10-15 03:45:16'), ('16', '3', 'Tour', 'tour/admin/show', 'ti ti-shopping-cart', null, 'tour-admin-view', '2017-10-15 06:44:48', '2017-10-15 06:44:48'), ('17', '0', 'Tour', null, 'ti ti-shopping-cart', null, '0', '2017-10-15 12:48:38', '2017-10-15 12:48:38'), ('18', '6', 'Tour', null, 'ti ti-shopping-cart', null, 'tour-menu', '2017-10-15 13:03:41', '2017-10-15 13:03:41'), ('19', '3', 'Region', null, 'fa fa-globe', null, 'region-admin-view', '2017-10-17 07:15:19', '2017-10-17 07:15:19'), ('20', '3', 'Negara', null, 'fa fa-flag', null, 'country-admin-view', '2017-10-17 13:46:01', '2017-10-17 13:47:10'), ('21', '3', 'Destinasi', null, 'ti ti-location-pin', null, 'destination-admin-view', '2017-10-17 19:35:01', '2017-10-17 19:35:01'), ('22', '3', 'Level', 'level', 'fa  fa-list-ol', null, 'level-admin-view', '2017-10-19 04:04:03', '2017-10-19 05:49:04'), ('23', '3', 'Include & Exclude', null, 'ti ti-import', null, 'include-admin-view', '2017-10-19 08:20:55', '2017-10-19 08:20:55'), ('24', '7', 'Pendaftaran Agen', null, 'fa fa-user', null, 'pendaftaran-agen-view', '2017-10-19 15:08:20', '2017-10-23 06:29:45');
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `thirdmenus`
-- ----------------------------
BEGIN;
INSERT INTO `thirdmenus` VALUES ('2', '6', '18', 'Cari paket', 'tour/search', 'fa fa-search', null, 'tour-menu', '2017-10-15 13:04:58', '2017-10-15 15:33:42'), ('3', '3', '0', 'Tambah', 'tour/admin/add', 'fa fa-plus', null, 'tour-admin-add', '2017-10-15 16:49:17', '2017-10-15 16:49:17'), ('4', '3', '16', 'Tambah', 'tour/admin/add', 'fa fa-plus', null, 'tour-admin-add', '2017-10-15 16:51:04', '2017-10-15 16:51:04'), ('5', '1', '5', 'Daftar', 'thirdmenu/show', 'fa fa-list', null, 'thirdmenu-view', '2017-10-15 16:57:16', '2017-10-15 17:02:47'), ('6', '1', '5', 'Tambah', 'thirdmenu/add', 'fa fa-plus', null, 'thirdmenu-add', '2017-10-15 16:58:34', '2017-10-15 17:00:30'), ('7', '3', '16', 'Daftar', 'tour/admin/show', 'fa fa-list', null, 'tour-admin-view', '2017-10-15 17:03:55', '2017-10-15 17:03:55'), ('8', '1', '15', 'Tambah', 'user/add', 'fa fa-plus', null, 'user-management-add', '2017-10-15 17:05:13', '2017-10-15 17:05:13'), ('9', '1', '15', 'Daftar', 'user/show', 'fa fa-list', null, 'user-management-view', '2017-10-15 17:06:07', '2017-10-15 17:06:07'), ('10', '3', '19', 'Tambah', 'region/add', 'fa fa-plus', null, 'region-admin-add', '2017-10-17 07:16:21', '2017-10-17 07:16:34'), ('11', '3', '19', 'Daftar', 'region/show', 'fa fa-list', null, 'region-admin-view', '2017-10-17 07:20:06', '2017-10-17 07:20:06'), ('12', '3', '20', 'Tambah', 'country/add', 'fa fa-plus', null, 'country-admin-add', '2017-10-17 13:47:52', '2017-10-17 13:47:52'), ('13', '3', '20', 'Daftar', 'country', 'fa fa-list', null, 'country-admin-view', '2017-10-17 13:48:28', '2017-10-17 13:48:28'), ('14', '3', '21', 'Tambah', 'destination/add', 'fa fa-plus', null, 'destination-admin-add', '2017-10-17 19:37:00', '2017-10-17 19:37:00'), ('15', '3', '21', 'Daftar', 'destination/show', 'fa fa-list', null, 'destination-admin-view', '2017-10-17 19:37:41', '2017-10-17 19:37:41'), ('16', '3', '23', 'Tambah', 'includes/add', 'fa fa-plus', null, 'include-admin-add', '2017-10-19 08:21:57', '2017-10-19 08:51:56'), ('17', '3', '23', 'Daftar', 'includes', 'fa fa-list', null, 'include-admin-view', '2017-10-19 08:22:41', '2017-10-19 08:51:38'), ('18', '7', '24', 'Form Pendaftaran Agen', 'membership/add', 'ti ti-clipboard', null, 'pendaftaran-agen-add', '2017-10-19 15:09:34', '2017-10-23 06:32:12');
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
  `cost_of_good` decimal(15,0) DEFAULT '0',
  `price` decimal(15,0) DEFAULT '0',
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
INSERT INTO `tours` VALUES ('4', '1', '1', '1', 'Jakarta - Lampung 3D', '3 Hari 2 Malam', '<p><strong>Day 1 :</strong></p>\r\n<p>Sesampainya di Pelabuhan Merak/Bandara Soekarno Hatta, langsung briefing dengan Local Guide (Java Tour Team)<br />berlanjut menuju Penginapan untuk Check In &ndash; Wisata Keliling Monas - Kota Tua sambil makan siang (nasi box) di<br />sekitar Kota Tua.<br />Perjalanan sholat isya ke Mesjid Istiqlal dan segera kembali ke penginapan, dan langsung makan malam (nasi box) &ndash;<br />free time.</p>\r\n<p>&nbsp;</p>\r\n<p><strong>Day 2 :</strong></p>\r\n<p>Setelah sarapan kita akan mengunjungi TMII selama seharian (full day) &ndash; makan siang (prasmanan) di salah satu<br />anjungan &ndash; explore museum2di TMII &ndash; makan malam (D&rsquo;cost)<br />Free time ke Tamini Square, untuk belanja oleh2 dan segeran kembali ke penginapan untuk beristirahat melanjutkan wisata besok.</p>\r\n<p>&nbsp;</p>\r\n<p><strong>Day 3 :</strong></p>\r\n<p>Setelah sarapan, langsung Check Out &ndash; perjalananan pulang ke Bandara Soekarno Hatta/menyebrang dari Merak ke<br />Bakauheni untuk menuju Pantai Pasir Putih, Lampung &ndash; makan siang di pinggir pantai. End of Service.<br />Terima kasih untuk keikutsertaan Anda bersama kami. Sampai jumpa dalam perjalanan tour lainnya.</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>', 'YOUTUBE', '<p>BIAYA &amp; PEMBAYARAN :</p>\r\n<ul>\r\n<li>Harga fleksibel, tergantung waktu keberangkatan, jumlah peserta dalam grup, jenis akomodasi yang<br />diminta, dan tempat-tempat yang ingin dituju sesuai permintaan khusus bila ada.</li>\r\n<li>Biaya International Airport tax / fuel charge dapat berubah sewaktu-waktu dengan / tanpa<br />pemberitahuan terlebih dahulu, sesuai dengan peraturan pihak penerbangan terkait</li>\r\n<li>Booking Fee Rp. 100.000,- sampai dengan tgl 18 Juli 2016 (non refundable)</li>\r\n<li>Deposit 50% maksimal 2 bln sebelum keberangkatan</li>\r\n<li>Pelunasan maksimal 1 bln sebelum keberangkatan</li>\r\n<li>Tidak ada pengembalian utk tour/object yg tdk terpakai</li>\r\n<li>Biaya pembatalan dlm waktu kurang dari 60 hari sebelum keberangkatan dikenakan biaya 70%</li>\r\n<li>Biaya pembatalan dlm waktu kurang dari 30 hari sebelum keberangkatan dikenakan biaya 100%</li>\r\n<li>Pembayaran dalam rupiah mengikuti kurs yang berlaku di pasaran (kurs BCA) pada saat terjadi<br />transaksi pembayaran</li>\r\n<li>Harga dapat berubah sewaktu-waktu</li>\r\n</ul>', '1', '2,3', '0', '1300000', '1', '2017-10-15 10:40:38', '1', '2017-10-15 12:33:09', '1'), ('5', '1', '1', '2', 'Cottage Pulau Seribu', '2 Hari 1 Malam', '<p><strong>Day 1 :</strong></p>\r\n<p>Para peserta berkumpul di Dermaga Marina, Pier 17 minimum 2 jam sebelum keberangkatan untuk memulai acara<br />perjalanan menuju Cottage di Pulau Seribu.<br />Tiba di salah satu Pulau Seribu tujuan, langsung check-in Cottage dan Makan Siang sebelum mempersiapkan main air.<br />Setelah Ishoma, menuju perahu kayu untuk kegiatan Snorkeling di gugusan pulau-pulau kecil di sekitar Cottage.<br />Menikmati Sunset di suatu pulau atau dalam perjalanan pulang menuju Cottage, setiba di Cottage bersih-bersih dan<br />langsung mempersiapkan diri untuk berkumpul bersama dalam Makan Malam dan BBQ.</p>\r\n<p>&nbsp;</p>\r\n<p><strong>Day 2 :</strong></p>\r\n<p>Bangun pagi dan langsung hunting Sunrise di sekitar dermaga Cottage, bersiap check out dan langsung menikmati Sarapan.<br />Menuju kapal cepat untuk perjalanan pulang menuju Jakarta.<br />Tiba di Jakarta. Terima kasih untuk keikutsertaan Anda bersama kami. Sampai jumpa dalam perjalanan tour lainnya.</p>', null, '<p><strong>PENTING :</strong><br />*)Bonus berlaku untuk Paket Rombongan (min.25 orang)<br />Kami berhak membatasi jumlah peserta sesuai kesepakatan, merubah jadwal keberangkatan dengan<br />alasan keselamatan (karena situasi yang tidak memungkinkan), men-set ulang rute-rute perjalanan<br />bila terjadi hal-hal diluar dugaan kami / force majeur, dengan terlebih dahulu menginformasikan<br />kepada Anda.</p>\r\n<p><br /><strong><em>BIAYA &amp; PEMBAYARAN :</em></strong></p>\r\n<ul>\r\n<li>Harga fleksibel, tergantung waktu keberangkatan, jumlah peserta dalam grup, jenis akomodasi yang<br />diminta, dan tempat-tempat yang ingin dituju sesuai permintaan khusus bila ada;</li>\r\n<li>Booking Fee minimal Rp 500.000,- langsung dibayarkan pada saat pendaftaran (non refundable);</li>\r\n<li>Deposit 50% minimal 1 hari setelah deal dan maksimal 2 bulan sebelum keberangkatan;</li>\r\n<li>Pelunasan maksimal 1 bulan sebelum keberangkatan;</li>\r\n<li>Tidak ada pengembalian untuk tour/obyek yg tidak terpakai;</li>\r\n<li>Biaya pembatalan dlm waktu kurang dari 20 hari sebelum keberangkatan dikenakan biaya 70%;</li>\r\n<li>Biaya pembatalan dlm waktu kurang dari 7 hari sebelum keberangkatan dikenakan biaya 100%;</li>\r\n<li>Harga dapat berubah sewaktu-waktu.</li>\r\n</ul>', '1', '2,3', '0', '850000', '1', '2017-10-15 16:13:17', '1', '2017-10-15 16:13:17', '1');
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
  `level_id` int(6) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_id` (`id`) USING BTREE,
  KEY `idx_wallet` (`wallet_realtime`,`wallet_update`) USING BTREE,
  KEY `idx_up` (`up`) USING BTREE,
  KEY `level_id` (`level_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`level_id`) REFERENCES `levels` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `users`
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES ('1', 'Barindra', 'barindra1988@gmail.com', '$2y$10$TXTSsJhhNW1U61.15Y59RejS5J1utOSawNvmteDS8S3f/4HpMb26S', '1988-07-19', 'Bogor', 'Bogor Baru B VII No. 7<br>', 'BOGOR', null, null, 'oNFIyQTGKX2k0igTqJqvqxSpgw2awQtO7fcf3gpapymaszm4efrMLO6mtHUc', '1', null, '', null, null, null, null, null, '1', null, '2017-08-20 16:11:28', null, '2017-08-22 16:33:00'), ('4', 'Barind testing', 'testing.website1988@gmail.com', '$2y$10$fc7egB3DoV7NNxMYrKJ5c.I2R/wUkoLwQxBLPFR3y8gn.EUC6Xyhy', null, null, null, null, null, 'dGVzdGluZy53ZWJzaXRlMTk4OEBnbWFpbC5jb20=', '2Ilc8trFTNAzNQyxW0sUCKMkFGdVhX2PV0bvsZfbwu8pVDHmOpNKRS83bLtF', '1', null, null, '0', '2017-10-04 10:43:31', '0', '2017-10-04 10:43:31', '1', '1', null, '2017-10-04 10:43:31', null, '2017-10-15 16:45:07'), ('5', 'Barindra Cabang', 'testing.website86@gmail.com', '$2y$10$KFplhtfoXQHp/nFcljWA9e.YZSZp5SobVlW52vspTLfeDPBk365jm', null, null, null, null, null, 'dGVzdGluZy53ZWJzaXRlODZAZ21haWwuY29t', 'sPa5bTANSw2GkBsEhpyRMyQuofnOlJKGhD3VhSYbCeFPJrA0tPT8O4jgsRXO', '1', null, null, null, null, null, null, '1', '2', null, '2017-10-15 22:58:01', null, '2017-10-15 23:00:23'), ('7', 'Barindra MD', 'bar1ndra@yahoo.com', '$2y$10$WNLGhm3rEExMECjvXo5FVexurxi/YlOvyNdz2fUYGFA1MGCkxXqTi', null, null, null, null, null, 'YmFyMW5kcmFAeWFob28uY29t', 'bHtOlTLq2DOlpgT0YVNtweIbUqvqDwCZsRK2WWfeWM6PPE5UPlQi20rVXEHo', '1', null, null, null, null, null, null, '5', '3', null, '2017-10-23 07:30:28', null, '2017-10-23 07:30:46'), ('8', 'Barindra Distri', 'developer.itmax@gmail.com', '$2y$10$G/I8T1FNyHce4XwnE8XnmOHJ6zXU2gkvLG9z5l3i4aVh5k19QloGa', null, null, null, null, null, 'ZGV2ZWxvcGVyLml0bWF4QGdtYWlsLmNvbQ==', 'hlXiB4IkZ9x2E84RxqKYXNnebEAjzOQ6tF1HzMkID0nhCUHNyYZuQRvcAIbN', '1', null, null, null, null, null, null, '7', '4', null, '2017-10-23 08:22:51', null, '2017-10-23 08:23:53'), ('9', 'Barind Agen', 'demo.lives88@gmail.com', '$2y$10$BRovp/FsFJkzuqt6XMkuTuur9oQcaHGYg.97J21gzcUhkmidB9Bai', null, null, null, null, null, 'ZGVtby5saXZlczg4QGdtYWlsLmNvbQ==', null, '1', null, null, null, null, null, null, '8', '5', null, '2017-10-23 08:23:39', null, '2017-10-23 08:24:04');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
