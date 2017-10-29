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

 Date: 10/27/2017 16:26:14 PM
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
INSERT INTO `activity_log` VALUES ('1', '4', 'Country', '0', 'Update', 'Ada kesalahan saat menyimpan data', 'SQLSTATE[23000]: Integrity constraint violation: 1452 Cannot add or update a child row: a foreign key constraint fails (`c1tour`.`countrys`, CONSTRAINT `countrys_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE) (SQL: insert into `countrys` (`name`, `region_id`, `is_active`, `created_by`, `updated_by`, `updated_at`, `created_at`) values (Indonesia, 0, 1, 4, 4, 2017-10-25 08:05:15, 2017-10-25 08:05:15))', '{\"user_id\":4,\"country\":\"Indonesia\",\"region_id\":\"0\"}', null, null, null, '36.88.132.36', 'Mozilla/5.0 (Windows NT 10.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36', '2017-10-25 08:05:16', '2017-10-25 08:05:16'), ('2', '4', 'Open Trip Quota', '0', 'Update', 'ada error pada saat menyimpan level komisi', 'Trying to get property of non-object', '{\"user_id\":4,\"open_trip_id\":null,\"class_tour_id\":\"1\",\"cost_of_good\":\"1000000\",\"selling_price\":\"1100000\",\"quota\":\"30\",\"statusform\":\"add\"}', null, null, null, '36.88.132.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36', '2017-10-26 23:12:35', '2017-10-26 23:12:35'), ('3', '4', 'Open Trip Quota', '0', 'Update', 'ada error pada saat menyimpan level komisi', 'Trying to get property of non-object', '{\"user_id\":4,\"open_trip_id\":null,\"class_tour_id\":\"1\",\"cost_of_good\":\"1000000\",\"selling_price\":\"1100000\",\"quota\":\"30\",\"statusform\":\"add\"}', null, null, null, '36.88.132.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36', '2017-10-26 23:12:35', '2017-10-26 23:12:35'), ('4', '4', 'Open Trip Quota', '0', 'Update', 'ada error pada saat menyimpan level komisi', 'Trying to get property of non-object', '{\"user_id\":4,\"open_trip_id\":null,\"class_tour_id\":\"1\",\"cost_of_good\":\"1000000\",\"selling_price\":\"1100000\",\"quota\":\"30\",\"statusform\":\"add\"}', null, null, null, '36.88.132.36', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36', '2017-10-26 23:12:38', '2017-10-26 23:12:38');
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
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `audit_logs`
-- ----------------------------
BEGIN;
INSERT INTO `audit_logs` VALUES ('1', '1', '2017-10-24 06:45:52', null, '::1', '2017-10-24 06:45:52', '2017-10-24 06:45:52', 'New Haven 06510 United States', '41.31000000', '-72.92000000', 'Desktop [Firefox]'), ('2', '1', '2017-10-24 06:46:26', null, '::1', '2017-10-24 06:46:26', '2017-10-24 06:46:26', 'New Haven 06510 United States', '41.31000000', '-72.92000000', 'Desktop [Firefox]'), ('3', '1', null, '2017-10-24 06:47:22', '::1', '2017-10-24 06:47:22', '2017-10-24 06:47:22', 'New Haven 06510 United States', '41.31000000', '-72.92000000', 'Desktop [Firefox]'), ('4', '8', '2017-10-24 07:07:14', null, '::1', '2017-10-24 07:07:14', '2017-10-24 07:07:14', 'New Haven 06510 United States', '41.31000000', '-72.92000000', 'Desktop [Firefox]'), ('5', '1', '2017-10-24 07:59:16', null, '112.215.235.108', '2017-10-24 07:59:16', '2017-10-24 07:59:16', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Mobile [iPhone|Safari]'), ('6', '1', null, '2017-10-24 08:01:47', '122.144.3.157', '2017-10-24 08:01:47', '2017-10-24 08:01:47', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Firefox]'), ('7', '1', '2017-10-24 08:01:59', null, '122.144.3.157', '2017-10-24 08:01:59', '2017-10-24 08:01:59', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Firefox]'), ('8', '1', null, '2017-10-24 08:04:40', '122.144.3.157', '2017-10-24 08:04:40', '2017-10-24 08:04:40', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Firefox]'), ('9', '1', '2017-10-24 08:08:47', null, '122.144.3.157', '2017-10-24 08:08:47', '2017-10-24 08:08:47', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Firefox]'), ('10', '1', null, '2017-10-24 08:08:55', '122.144.3.157', '2017-10-24 08:08:55', '2017-10-24 08:08:55', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Firefox]'), ('11', '7', '2017-10-24 08:09:20', null, '122.144.3.157', '2017-10-24 08:09:20', '2017-10-24 08:09:20', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Firefox]'), ('12', '7', null, '2017-10-24 08:10:03', '122.144.3.157', '2017-10-24 08:10:03', '2017-10-24 08:10:03', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Firefox]'), ('13', '5', null, '2017-10-24 08:59:49', '36.88.132.36', '2017-10-24 08:59:49', '2017-10-24 08:59:49', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Mobile [1|Chrome]'), ('14', '4', '2017-10-24 09:00:24', null, '36.88.132.36', '2017-10-24 09:00:24', '2017-10-24 09:00:24', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Mobile [WebKit|Chrome]'), ('15', '4', null, '2017-10-24 09:16:42', '36.88.132.36', '2017-10-24 09:16:42', '2017-10-24 09:16:42', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('16', '5', '2017-10-24 09:17:14', null, '36.88.132.36', '2017-10-24 09:17:14', '2017-10-24 09:17:14', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('17', '4', null, '2017-10-24 09:49:57', '36.88.132.36', '2017-10-24 09:49:57', '2017-10-24 09:49:57', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Mobile [1|Chrome]'), ('18', '5', null, '2017-10-24 10:02:48', '36.88.132.36', '2017-10-24 10:02:48', '2017-10-24 10:02:48', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('19', '5', '2017-10-24 10:12:40', null, '36.88.132.36', '2017-10-24 10:12:40', '2017-10-24 10:12:40', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('20', '5', null, '2017-10-24 11:32:06', '36.88.132.36', '2017-10-24 11:32:06', '2017-10-24 11:32:06', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('21', '5', '2017-10-24 11:32:29', null, '36.88.132.36', '2017-10-24 11:32:29', '2017-10-24 11:32:29', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('22', '5', null, '2017-10-24 11:49:24', '36.88.132.36', '2017-10-24 11:49:24', '2017-10-24 11:49:24', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('23', '4', '2017-10-24 11:49:46', null, '36.88.132.36', '2017-10-24 11:49:46', '2017-10-24 11:49:46', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('24', '5', '2017-10-24 13:09:10', null, '112.215.235.111', '2017-10-24 13:09:10', '2017-10-24 13:09:10', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Mobile [WebKit|Chrome]'), ('25', '1', '2017-10-24 15:05:45', null, '202.62.16.249', '2017-10-24 15:05:45', '2017-10-24 15:05:45', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Mobile [iPhone|Safari]'), ('26', '5', '2017-10-25 06:13:59', null, '36.88.132.36', '2017-10-25 06:13:59', '2017-10-25 06:13:59', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('27', '5', null, '2017-10-25 06:14:06', '36.88.132.36', '2017-10-25 06:14:06', '2017-10-25 06:14:06', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('28', '4', '2017-10-25 06:14:18', null, '36.88.132.36', '2017-10-25 06:14:18', '2017-10-25 06:14:18', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('29', '4', null, '2017-10-25 07:36:03', '36.88.132.36', '2017-10-25 07:36:03', '2017-10-25 07:36:03', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('30', '5', '2017-10-25 07:36:21', null, '36.88.132.36', '2017-10-25 07:36:21', '2017-10-25 07:36:21', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('31', '4', '2017-10-25 07:47:14', null, '36.88.132.36', '2017-10-25 07:47:14', '2017-10-25 07:47:14', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('32', '1', '2017-10-25 13:59:55', null, '202.62.18.24', '2017-10-25 13:59:55', '2017-10-25 13:59:55', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Safari]'), ('33', '1', null, '2017-10-25 14:05:52', '202.62.18.24', '2017-10-25 14:05:52', '2017-10-25 14:05:52', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Safari]'), ('34', '1', '2017-10-25 14:36:00', null, '202.62.18.24', '2017-10-25 14:36:00', '2017-10-25 14:36:00', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Safari]'), ('35', '1', null, '2017-10-25 15:11:14', '202.62.18.24', '2017-10-25 15:11:14', '2017-10-25 15:11:14', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Safari]'), ('36', '1', '2017-10-25 15:11:31', null, '202.62.18.24', '2017-10-25 15:11:31', '2017-10-25 15:11:31', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Safari]'), ('37', '4', '2017-10-25 17:07:38', null, '112.215.65.188', '2017-10-25 17:07:38', '2017-10-25 17:07:38', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Mobile [WebKit|Chrome]'), ('38', '4', null, '2017-10-25 17:17:28', '112.215.65.188', '2017-10-25 17:17:28', '2017-10-25 17:17:28', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Mobile [1|Chrome]'), ('39', '1', '2017-10-26 02:27:12', null, '122.144.3.157', '2017-10-26 02:27:12', '2017-10-26 02:27:12', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Mobile [iPhone|Safari]'), ('40', '4', '2017-10-26 03:06:46', null, '36.88.132.36', '2017-10-26 03:06:46', '2017-10-26 03:06:46', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('41', '5', '2017-10-26 09:46:24', null, '36.88.132.36', '2017-10-26 09:46:24', '2017-10-26 09:46:24', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('42', '4', '2017-10-26 10:23:37', null, '114.124.208.40', '2017-10-26 10:23:37', '2017-10-26 10:23:37', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Mobile [WebKit|Chrome]'), ('43', '4', '2017-10-26 12:18:59', null, '36.88.132.36', '2017-10-26 12:18:59', '2017-10-26 12:18:59', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('44', '1', '2017-10-26 17:09:51', null, '202.62.17.191', '2017-10-26 17:09:51', '2017-10-26 17:09:51', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Firefox]'), ('45', '5', '2017-10-26 22:40:43', null, '36.88.132.36', '2017-10-26 22:40:43', '2017-10-26 22:40:43', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('46', '5', null, '2017-10-26 22:51:03', '36.88.132.36', '2017-10-26 22:51:03', '2017-10-26 22:51:03', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('47', '4', '2017-10-26 22:51:20', null, '36.88.132.36', '2017-10-26 22:51:20', '2017-10-26 22:51:20', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('48', '4', '2017-10-26 23:12:47', null, '112.215.171.196', '2017-10-26 23:12:47', '2017-10-26 23:12:47', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('49', '4', '2017-10-27 01:17:11', null, '36.88.132.36', '2017-10-27 01:17:11', '2017-10-27 01:17:11', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('50', '1', '2017-10-27 04:31:32', null, '122.144.3.157', '2017-10-27 04:31:32', '2017-10-27 04:31:32', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Firefox]'), ('51', '1', null, '2017-10-27 04:31:49', '122.144.3.157', '2017-10-27 04:31:49', '2017-10-27 04:31:49', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Firefox]'), ('52', '5', '2017-10-27 05:43:28', null, '112.215.235.153', '2017-10-27 05:43:28', '2017-10-27 05:43:28', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Mobile [WebKit|Chrome]'), ('53', '5', null, '2017-10-27 05:44:15', '112.215.235.153', '2017-10-27 05:44:15', '2017-10-27 05:44:15', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Mobile [1|Chrome]'), ('54', '4', null, '2017-10-27 05:44:26', '36.88.132.36', '2017-10-27 05:44:26', '2017-10-27 05:44:26', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('55', '5', '2017-10-27 05:44:35', null, '112.215.235.153', '2017-10-27 05:44:35', '2017-10-27 05:44:35', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Mobile [WebKit|Chrome]'), ('56', '5', '2017-10-27 05:44:48', null, '36.88.132.36', '2017-10-27 05:44:48', '2017-10-27 05:44:48', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('57', '5', null, '2017-10-27 05:45:23', '112.215.235.153', '2017-10-27 05:45:23', '2017-10-27 05:45:23', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Mobile [1|Chrome]'), ('58', '4', '2017-10-27 05:45:45', null, '112.215.235.153', '2017-10-27 05:45:45', '2017-10-27 05:45:45', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Mobile [WebKit|Chrome]'), ('59', '5', null, '2017-10-27 05:46:21', '36.88.132.36', '2017-10-27 05:46:21', '2017-10-27 05:46:21', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('60', '4', '2017-10-27 05:46:45', null, '36.88.132.36', '2017-10-27 05:46:45', '2017-10-27 05:46:45', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Chrome]'), ('61', '1', '2017-10-27 07:30:39', null, '122.144.3.157', '2017-10-27 07:30:39', '2017-10-27 07:30:39', 'Jakarta  Indonesia', '-6.17440000', '106.82940000', 'Desktop [Safari]');
COMMIT;

-- ----------------------------
--  Table structure for `class_tours`
-- ----------------------------
DROP TABLE IF EXISTS `class_tours`;
CREATE TABLE `class_tours` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `is_active` int(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` int(6) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `class_tours`
-- ----------------------------
BEGIN;
INSERT INTO `class_tours` VALUES ('1', 'Class A', '1', '2017-10-25 15:14:16', '1', '2017-10-25 15:14:16', '1');
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `countrys`
-- ----------------------------
BEGIN;
INSERT INTO `countrys` VALUES ('1', 'Indonesia', '1', '1', '2017-10-15 14:02:04', '1', '2017-10-15 14:02:08', '1'), ('3', 'Mesir', '2', '1', '2017-10-25 07:00:21', '4', '2017-10-25 07:00:21', '4'), ('6', 'Singapore', '1', '1', '2017-10-26 22:52:15', '4', '2017-10-26 22:52:15', '4'), ('8', 'Malaysia', '1', '1', '2017-10-26 23:46:48', '4', '2017-10-26 23:46:48', '4'), ('9', 'Jepang', '1', '1', '2017-10-27 00:20:24', '4', '2017-10-27 00:20:24', '4');
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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `destinations`
-- ----------------------------
BEGIN;
INSERT INTO `destinations` VALUES ('1', 'Lampung', '1', '1', '1', '2017-10-15 14:02:32', '1', '2017-10-15 14:02:35', '1'), ('2', 'Jawa', '1', '1', '1', '2017-10-15 23:10:29', '1', '2017-10-15 23:10:34', '1'), ('4', 'Malang', '1', '1', '1', '2017-10-26 12:21:03', '4', '2017-10-26 12:21:03', '4'), ('5', 'Sentosa Island', '1', '6', '1', '2017-10-26 22:53:30', '4', '2017-10-26 22:53:30', '4'), ('6', 'Universal Studio', '1', '6', '1', '2017-10-26 23:21:33', '4', '2017-10-26 23:21:33', '4'), ('7', 'Asia Alilla', '1', '8', '1', '2017-10-26 23:49:58', '4', '2017-10-26 23:49:58', '4'), ('8', 'Asia Aleya', '1', '8', '1', '2017-10-27 00:05:32', '4', '2017-10-27 00:05:32', '4'), ('9', 'Golden Route Japan', '1', '9', '1', '2017-10-27 00:22:51', '4', '2017-10-27 00:22:51', '4'), ('10', 'Bali', '1', '1', '1', '2017-10-27 01:21:31', '4', '2017-10-27 01:21:31', '4'), ('11', 'Explore Bangka', '1', '1', '1', '2017-10-27 01:30:21', '4', '2017-10-27 02:48:23', '4'), ('12', 'Tokyo Fujiyama', '1', '9', '1', '2017-10-27 01:41:47', '4', '2017-10-27 01:41:47', '4'), ('13', 'Laskar Belitung', '1', '1', '1', '2017-10-27 02:49:17', '4', '2017-10-27 02:49:17', '4'), ('14', 'Pesona Laskar  Belitung 3D', '1', '1', '1', '2017-10-27 03:37:10', '4', '2017-10-27 03:37:10', '4'), ('15', 'Wakatobi – Bali – Labuan Bajo 3D', '1', '1', '1', '2017-10-27 03:59:31', '4', '2017-10-27 03:59:31', '4'), ('16', 'ESCAPE TO BALI 3D', '1', '1', '1', '2017-10-27 05:42:17', '4', '2017-10-27 05:42:17', '4');
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `menus`
-- ----------------------------
BEGIN;
INSERT INTO `menus` VALUES ('1', 'Admin', null, 'admin-menu', 'fa fa-cog', '9', '0017-07-25 14:44:00', '2017-10-27 04:04:05'), ('3', 'Master', null, 'master-menu', 'glyphicon glyphicon-hdd', '4', '2017-10-02 08:10:05', '2017-10-23 05:19:04'), ('6', 'Layanan', null, 'layanan-menu', 'ti  ti-harddrives', '2', '2017-10-15 06:01:12', '2017-10-23 05:18:31'), ('7', 'Membership', null, 'membership-menu', 'fa fa-users', '3', '2017-10-19 15:02:07', '2017-10-23 05:18:44'), ('8', 'Profile Usaha', 'user/info', 'profile-menu', 'fa fa-user', '1', '2017-10-23 04:40:40', '2017-10-23 04:44:49'), ('9', 'Keuangan', null, 'finance-menu', 'ti  ti-money', '5', '2017-10-27 04:05:41', '2017-10-27 04:05:41'), ('10', 'Statistik', null, 'finance-menu', 'ti  ti-stats-up', '6', '2017-10-27 04:07:14', '2017-10-27 04:20:45');
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
--  Table structure for `open_trip_quotas`
-- ----------------------------
DROP TABLE IF EXISTS `open_trip_quotas`;
CREATE TABLE `open_trip_quotas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `open_trip_id` bigint(20) DEFAULT NULL,
  `class_tour_id` int(6) DEFAULT NULL,
  `cost_of_good` decimal(15,0) DEFAULT NULL,
  `selling_price` decimal(15,0) DEFAULT NULL,
  `quota` int(6) DEFAULT NULL,
  `volume` int(6) DEFAULT '0',
  `quota_update` datetime DEFAULT NULL,
  `is_active` int(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` int(6) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `open_trip_id` (`open_trip_id`),
  KEY `class_tour_id` (`class_tour_id`),
  KEY `quota` (`quota`,`volume`),
  CONSTRAINT `open_trip_quotas_ibfk_1` FOREIGN KEY (`open_trip_id`) REFERENCES `open_trips` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `open_trip_quotas_ibfk_2` FOREIGN KEY (`class_tour_id`) REFERENCES `class_tours` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `open_trip_quotas`
-- ----------------------------
BEGIN;
INSERT INTO `open_trip_quotas` VALUES ('1', '1', '1', '100000', '200000', '10', '0', '2017-10-26 16:32:27', null, '2017-10-26 16:32:27', '1', '2017-10-26 16:32:27', '1'), ('3', null, '1', '1000000', '1100000', '30', '0', '2017-10-26 23:12:35', null, '2017-10-26 23:12:35', '4', '2017-10-26 23:12:35', '4'), ('4', null, '1', '1000000', '1100000', '30', '0', '2017-10-26 23:12:35', null, '2017-10-26 23:12:35', '4', '2017-10-26 23:12:35', '4'), ('5', null, '1', '1000000', '1100000', '30', '0', '2017-10-26 23:12:38', null, '2017-10-26 23:12:38', '4', '2017-10-26 23:12:38', '4');
COMMIT;

-- ----------------------------
--  Table structure for `open_trips`
-- ----------------------------
DROP TABLE IF EXISTS `open_trips`;
CREATE TABLE `open_trips` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tour_id` bigint(20) DEFAULT NULL,
  `name` varchar(150) DEFAULT NULL,
  `departure_date` date DEFAULT NULL,
  `guide` varchar(150) DEFAULT NULL,
  `is_active` int(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` int(6) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `tour_id` (`tour_id`),
  CONSTRAINT `open_trips_ibfk_1` FOREIGN KEY (`tour_id`) REFERENCES `tours` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `open_trips`
-- ----------------------------
BEGIN;
INSERT INTO `open_trips` VALUES ('1', '4', 'Jakarta - Lampung 3D', '2017-10-27', 'Barind', '1', '2017-10-26 09:18:41', '1', '2017-10-26 09:18:41', '1');
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
INSERT INTO `permission_role` VALUES ('1', '1'), ('2', '1'), ('3', '1'), ('4', '1'), ('5', '1'), ('6', '1'), ('7', '1'), ('8', '1'), ('9', '1'), ('9', '2'), ('10', '1'), ('11', '1'), ('12', '1'), ('13', '1'), ('14', '1'), ('15', '1'), ('16', '1'), ('17', '1'), ('17', '2'), ('18', '1'), ('19', '1'), ('20', '1'), ('21', '1'), ('39', '1'), ('39', '2'), ('40', '1'), ('40', '2'), ('41', '1'), ('41', '2'), ('42', '1'), ('42', '2'), ('43', '1'), ('43', '2'), ('44', '1'), ('44', '2'), ('45', '1'), ('45', '2'), ('46', '1'), ('46', '2'), ('46', '4'), ('47', '1'), ('47', '2'), ('48', '1'), ('48', '2'), ('49', '1'), ('49', '2'), ('50', '1'), ('50', '2'), ('51', '1'), ('51', '2'), ('51', '4'), ('52', '1'), ('52', '2'), ('53', '1'), ('53', '2'), ('54', '1'), ('54', '2'), ('55', '1'), ('56', '1'), ('56', '2'), ('57', '1'), ('57', '2'), ('58', '1'), ('58', '2'), ('59', '1'), ('59', '2'), ('60', '1'), ('60', '2'), ('61', '1'), ('61', '2'), ('62', '1'), ('62', '2'), ('63', '1'), ('63', '2'), ('64', '1'), ('64', '2'), ('65', '1'), ('65', '2'), ('66', '1'), ('66', '2'), ('67', '1'), ('67', '2'), ('68', '1'), ('68', '2'), ('69', '1'), ('69', '2'), ('70', '1'), ('70', '2'), ('71', '1'), ('71', '2'), ('72', '1'), ('73', '1'), ('73', '2'), ('74', '1'), ('74', '2'), ('75', '1'), ('75', '2'), ('76', '1'), ('77', '1'), ('77', '2'), ('78', '1'), ('78', '2'), ('79', '1'), ('79', '2'), ('79', '4'), ('80', '1'), ('80', '2'), ('80', '4'), ('81', '1'), ('81', '2'), ('81', '4'), ('82', '1'), ('82', '2'), ('83', '1'), ('83', '2'), ('83', '4'), ('84', '1'), ('85', '1'), ('85', '2'), ('86', '1'), ('86', '2'), ('87', '1'), ('87', '2'), ('88', '1'), ('88', '2'), ('89', '1'), ('89', '2'), ('90', '1'), ('90', '2'), ('91', '1'), ('91', '2'), ('92', '1'), ('92', '2'), ('93', '1'), ('93', '2'), ('94', '1'), ('94', '2'), ('95', '1'), ('95', '2'), ('96', '1'), ('96', '2'), ('97', '1'), ('97', '2'), ('97', '4'), ('98', '1'), ('98', '2'), ('98', '4'), ('99', '1'), ('99', '2'), ('99', '4'), ('100', '1'), ('100', '2'), ('100', '4'), ('101', '1'), ('101', '2'), ('101', '4'), ('102', '1'), ('102', '2'), ('102', '4'), ('103', '1'), ('103', '2'), ('103', '4'), ('104', '1'), ('104', '2'), ('104', '4');
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
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
--  Records of `permissions`
-- ----------------------------
BEGIN;
INSERT INTO `permissions` VALUES ('1', 'permission-add', 'Permission Add', 'Access to add Permission', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('2', 'permission-edit', 'Permission Edit', 'access to edit Permission', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('3', 'permission-delete', 'Permission Delete', 'Access to delete Permission', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('4', 'permission-view', 'Permission View', 'Access to view Permission form', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('5', 'role-view', 'Role View', 'Access to view Role Page', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('6', 'role-add', 'Role Add', 'Access to add Role', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('7', 'role-edit', 'Role Edit', 'Access to edit Role', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('8', 'role-delete', 'Role Delete', 'Access to delete Role', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('9', 'menu-view', 'Menu View', 'Access to View Page Menu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('10', 'menu-add', 'Menu Add', 'Access to form add menu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('11', 'menu-edit', 'Menu Edit', 'Access to Edit Menu Form', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('12', 'menu-delete', 'Menu Delete', 'Access to Delete Menu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('13', 'submenu-view', 'Submenu View', 'Access to View Submenu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('14', 'submenu-add', 'Submenu Add', 'Access to Add Form Submenu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('15', 'submenu-edit', 'Submenu Edit', 'Access to Edit Submenu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('16', 'submenu-delete', 'Submenu Delete', 'Access to Delete Submenu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('17', 'user-management-view', 'User Management Menu', 'User Management Menu', '0000-00-00 00:00:00', '2017-10-15 03:43:22', '0'), ('18', 'thirdmenu-view', 'Thirdmenu View', 'Access to view Thirdmenu', '2017-08-21 14:17:29', '2017-08-21 14:17:55', '0'), ('19', 'thirdmenu-add', 'Thirdmenu Add', 'Access to Add New Thirdmenu', '2017-08-21 14:18:25', '2017-08-22 04:08:32', '18'), ('20', 'thirdmenu-edit', 'Thirdmenu Edit', 'Access to Edit Thirdmenu', '2017-08-21 14:18:56', '2017-08-22 04:08:51', '18'), ('21', 'thirdmenu-delete', 'Thirdmenu Delete', 'Access to Delete Thirdmenu', '2017-08-21 14:19:32', '2017-08-22 04:09:14', '18'), ('39', 'setting-view', 'Setting Menu', 'Setting Menu', '2017-10-14 16:38:14', '2017-10-14 16:38:14', '0'), ('40', 'setting-edit', 'Edit Setting System', 'Edit Setting System', '2017-10-15 03:19:01', '2017-10-15 03:19:01', '39'), ('41', 'user-management-edit', 'User Management Edit', 'User Management Edit', '2017-10-15 03:36:08', '2017-10-15 03:43:40', '17'), ('42', 'user-management-add', 'User Management Add New', 'User Management Add New', '2017-10-15 03:36:31', '2017-10-15 03:43:59', '17'), ('43', 'user-management-delete', 'User Management Delete', 'User Management Delete', '2017-10-15 03:38:28', '2017-10-15 03:44:21', '17'), ('44', 'user-management-inactive', 'User Management Inactive', 'User Management Inactive', '2017-10-15 04:04:47', '2017-10-15 04:04:47', '17'), ('45', 'master-menu', 'Master Menu', 'Master Menu', '2017-10-15 05:51:36', '2017-10-15 05:51:36', '0'), ('46', 'layanan-menu', 'Layanan Menu', 'Layanan Menu', '2017-10-15 05:59:31', '2017-10-15 05:59:31', '0'), ('47', 'tour-admin-view', 'Admin Tour Menu', 'Admin Tour Menu', '2017-10-15 06:37:45', '2017-10-15 06:37:45', '45'), ('48', 'tour-admin-add', 'Admin Tour Add New', 'Admin Tour Add New', '2017-10-15 06:38:06', '2017-10-15 06:38:06', '47'), ('49', 'tour-admin-edit', 'Admin Tour Edit', 'Admin Tour Edit', '2017-10-15 06:39:13', '2017-10-15 06:39:13', '47'), ('50', 'tour-admin-delete', 'Admin Tour Delete', 'Admin Tour Delete', '2017-10-15 06:39:48', '2017-10-15 06:39:48', '47'), ('51', 'tour-menu', 'Tour Menu', 'Tour Menu', '2017-10-15 12:43:08', '2017-10-15 12:43:08', '46'), ('52', 'region-admin-view', 'Region Menu', 'Region Menu', '2017-10-17 07:12:09', '2017-10-17 07:12:09', '45'), ('53', 'region-admin-add', 'Region Add New', 'Region Add New', '2017-10-17 07:13:16', '2017-10-17 07:13:16', '52'), ('54', 'region-admin-edit', 'Region Edit', 'Region Edit', '2017-10-17 07:13:48', '2017-10-17 07:13:48', '52'), ('55', 'region-admin-delete', 'Region Delete', 'Region Delete', '2017-10-17 07:14:09', '2017-10-17 07:14:09', '52'), ('56', 'region-admin-inactive', 'Region Inactive', 'Region Inactive', '2017-10-17 07:14:31', '2017-10-17 07:14:31', '52'), ('57', 'country-admin-view', 'Country Menu', 'Country Menu', '2017-10-17 10:14:40', '2017-10-17 14:29:12', '45'), ('58', 'country-admin-add', 'Country Add New', 'Country Add New', '2017-10-17 10:15:23', '2017-10-17 10:15:23', '57'), ('59', 'country-admin-edit', 'Country Edit', 'Country Edit', '2017-10-17 10:15:43', '2017-10-17 10:15:43', '57'), ('60', 'country-admin-delete', 'Country Delete', 'Country Delete', '2017-10-17 10:16:22', '2017-10-17 10:16:22', '57'), ('61', 'country-admin-inactive', 'Country Inactive', 'Country Inactive', '2017-10-17 10:16:43', '2017-10-17 10:16:43', '57'), ('62', 'country-admin-activate', 'Country Activate', 'Country Diaktifkan', '2017-10-17 14:27:43', '2017-10-17 14:27:43', '57'), ('63', 'destination-admin-view', 'Destination Menu', 'Destination Menu', '2017-10-17 19:31:57', '2017-10-17 19:31:57', '45'), ('64', 'destination-admin-add', 'Destination Add New', 'Destination Add New', '2017-10-17 19:32:25', '2017-10-17 19:32:25', '63'), ('65', 'destination-admin-edit', 'Destination Edit', 'Destination Edit', '2017-10-17 19:32:47', '2017-10-17 19:32:47', '63'), ('66', 'destination-admin-delete', 'Destination Delete', 'Destination Delete', '2017-10-17 19:33:13', '2017-10-17 19:33:13', '63'), ('67', 'destination-admin-inactive', 'Destination Inactive', 'Destination Inactive', '2017-10-17 19:33:45', '2017-10-17 19:33:45', '63'), ('68', 'destination-admin-activate', 'Destination Activate', 'Destination Activate', '2017-10-17 19:34:06', '2017-10-17 19:34:06', '63'), ('69', 'level-admin-view', 'Level Menu', 'Level Menu', '2017-10-19 03:55:19', '2017-10-19 03:55:19', '45'), ('70', 'level-admin-add', 'Level Add New', 'Level Add New', '2017-10-19 03:55:55', '2017-10-19 03:57:18', '69'), ('71', 'level-admin-edit', 'Level Edit', 'Leve Edit', '2017-10-19 03:57:03', '2017-10-19 03:57:03', '69'), ('72', 'level-admin-delete', 'Level Delete', 'Level Delete', '2017-10-19 03:57:46', '2017-10-19 03:57:46', '69'), ('73', 'include-admin-view', 'Include/Exclude Menu', 'Include/Exclude Menu', '2017-10-19 08:16:26', '2017-10-19 08:16:26', '45'), ('74', 'include-admin-add', 'Include/Exclude Add New', 'Include/Exclude Add New', '2017-10-19 08:16:47', '2017-10-19 08:16:47', '73'), ('75', 'include-admin-edit', 'Include/Exclude Edit', 'Include/Exclude Edit', '2017-10-19 08:17:08', '2017-10-19 08:17:08', '73'), ('76', 'include-admin-delete', 'Include/Exclude Delete', 'Include/Exclude Delete', '2017-10-19 08:17:40', '2017-10-19 08:17:40', '73'), ('77', 'include-admin-inactive', 'Include/Exclude Inactive', 'Include/Exclude Inactive', '2017-10-19 08:18:12', '2017-10-19 08:18:12', '73'), ('78', 'include-admin-activate', 'Include/Exclude Activate', 'Include/Exclude Activate', '2017-10-19 08:18:35', '2017-10-19 08:18:35', '73'), ('79', 'membership-menu', 'Membership Menu', 'Membership Menu', '2017-10-19 15:01:28', '2017-10-19 15:01:28', '0'), ('80', 'pendaftaran-agen-view', 'Pendaftaran Agen Menu', 'Pedaftaran Agen', '2017-10-19 15:03:05', '2017-10-19 15:04:44', '79'), ('81', 'pendaftaran-agen-add', 'Form Pendaftaran Agen', 'Form Pendaftaran Agen', '2017-10-19 15:05:10', '2017-10-19 15:05:10', '80'), ('82', 'admin-menu', 'Admin Menu', 'Admin Menu', '2017-10-23 04:37:30', '2017-10-23 04:37:30', '0'), ('83', 'profile-menu', 'Profile Menu', 'Profile Menu', '2017-10-23 04:39:56', '2017-10-23 04:39:56', '0'), ('84', 'region-admin-activate', 'Region Activate', 'Region Activate', '2017-10-25 10:01:27', '2017-10-25 10:01:27', '52'), ('85', 'classtour-admin-view', 'Class Tour Menu', 'Class Tour Menu', '2017-10-25 14:42:37', '2017-10-25 14:42:37', '45'), ('86', 'classtour-admin-add', 'Class Tour Add New', 'Class Tour Add New', '2017-10-25 14:43:01', '2017-10-25 14:43:01', '85'), ('87', 'classtour-admin-edit', 'Class Tour Edit', 'Class Tour Edit', '2017-10-25 14:43:40', '2017-10-25 14:43:40', '85'), ('88', 'classtour-admin-delete', 'Class Tour Delete', 'Class Tour Delete', '2017-10-25 14:44:07', '2017-10-25 14:44:07', '85'), ('89', 'classtour-admin-inactive', 'Class tour Inactive', 'Class tour Inactive', '2017-10-25 14:44:29', '2017-10-25 14:44:29', '85'), ('90', 'classtour-admin-activate', 'Class tour Activate', 'Class tour Activate', '2017-10-25 14:44:53', '2017-10-25 14:44:53', '85'), ('91', 'opentrip-admin-view', 'Open Trip Menu', 'Open Trip Menu', '2017-10-25 15:35:53', '2017-10-25 15:35:53', '45'), ('92', 'opentrip-admin-add', 'Open Trip Add New', 'Open Trip Add New', '2017-10-25 15:36:13', '2017-10-26 05:01:58', '91'), ('93', 'opentrip-admin-edit', 'Open Trip Edit', 'Open Trip Edit', '2017-10-25 15:36:34', '2017-10-25 15:36:34', '91'), ('94', 'opentrip-admin-delete', 'Open Trip Delete', 'Open Trip Delete', '2017-10-25 15:36:57', '2017-10-25 15:36:57', '91'), ('95', 'opentrip-admin-inactive', 'Open trip Inactive', 'Open trip Inactive', '2017-10-25 15:37:26', '2017-10-25 15:37:26', '91'), ('96', 'opentrip-admin-activate', 'Open Trip Activate', 'Open Trip Activate', '2017-10-25 15:38:31', '2017-10-25 15:38:31', '91'), ('97', 'finance-menu', 'Finance Menu', 'Finance Menu', '2017-10-27 03:56:10', '2017-10-27 03:56:10', '0'), ('98', 'cashbook-view', 'Buku Saldo', 'Buku Saldo', '2017-10-27 03:56:34', '2017-10-27 03:56:34', '97'), ('99', 'topup-submitted-view', 'Pengajuan Topup', 'Pengajuan Topup', '2017-10-27 03:58:57', '2017-10-27 04:01:08', '97'), ('100', 'topup-submitted-add', 'Pengajuan Topup Form', 'Pengajuan Topup Form', '2017-10-27 04:00:14', '2017-10-27 04:00:52', '99'), ('101', 'withdraw-view', 'Withdraw View', 'Withdraw View', '2017-10-27 04:01:57', '2017-10-27 04:01:57', '97'), ('102', 'withdraw-add', 'Withdraw Pengajuan', 'Withdraw Pengajuan', '2017-10-27 04:02:20', '2017-10-27 04:02:20', '101'), ('103', 'statistik-menu', 'Statistik Menu', 'Statistik Menu', '2017-10-27 04:02:57', '2017-10-27 04:02:57', '0'), ('104', 'report-tour', 'Report Tour', 'Report Tour', '2017-10-27 04:03:25', '2017-10-27 04:03:25', '103');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `regions`
-- ----------------------------
BEGIN;
INSERT INTO `regions` VALUES ('1', 'Asia', '1', '2017-10-15 14:01:19', '1', '2017-10-25 14:36:55', '1'), ('2', 'Afrika', '1', '2017-10-25 06:58:07', '4', '2017-10-25 06:58:07', '4'), ('3', 'Eropa', '1', '2017-10-26 23:43:49', '4', '2017-10-27 01:16:29', '4');
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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `submenus`
-- ----------------------------
BEGIN;
INSERT INTO `submenus` VALUES ('1', null, 'Add New', 'subemnu/add', 'fa fa-folder-open', '', 'submenu-add', '0017-07-25 14:56:00', '2017-08-21 15:10:46'), ('2', '1', 'Role', 'role/show', 'fa fa-cogs', '', 'role-view', '0017-07-25 14:58:00', '0017-07-25 14:58:00'), ('3', '1', 'Permission', 'permission/show', 'fa fa-unlock-alt', '', 'permission-view', '0017-07-25 15:32:00', '0017-07-25 15:32:00'), ('4', '1', 'Submenu', 'submenu/show', 'fa fa-folder-open', '', 'submenu-view', '0017-07-25 15:34:00', '0017-07-25 15:34:00'), ('5', '1', 'Thirdmenu', 'thirdmenu', 'fa fa-folder-open', null, 'thirdmenu-view', '2017-08-21 14:20:32', '2017-10-15 16:55:35'), ('6', '1', 'Menu', 'menu/show', 'fa fa-folder-open', null, 'menu-view', '2017-09-16 20:41:35', '2017-09-16 20:41:37'), ('14', '1', 'Setting', 'setting/show', 'fa fa-cog', null, 'setting-view', '2017-10-15 00:41:55', '2017-10-15 00:41:55'), ('15', '1', 'User Management', 'user/show', 'fa fa-user', null, 'user-management-view', '2017-10-15 03:35:39', '2017-10-15 03:45:16'), ('16', '3', 'Tour', 'tour/admin/show', 'ti ti-shopping-cart', null, 'tour-admin-view', '2017-10-15 06:44:48', '2017-10-15 06:44:48'), ('17', '0', 'Tour', null, 'ti ti-shopping-cart', null, '0', '2017-10-15 12:48:38', '2017-10-15 12:48:38'), ('18', '6', 'Tour', null, 'ti ti-shopping-cart', null, 'tour-menu', '2017-10-15 13:03:41', '2017-10-15 13:03:41'), ('19', '3', 'Region', null, 'fa fa-globe', null, 'region-admin-view', '2017-10-17 07:15:19', '2017-10-17 07:15:19'), ('20', '3', 'Negara', null, 'fa fa-flag', null, 'country-admin-view', '2017-10-17 13:46:01', '2017-10-17 13:47:10'), ('21', '3', 'Destinasi', null, 'ti ti-location-pin', null, 'destination-admin-view', '2017-10-17 19:35:01', '2017-10-17 19:35:01'), ('22', '3', 'Level', 'level', 'fa  fa-list-ol', null, 'level-admin-view', '2017-10-19 04:04:03', '2017-10-19 05:49:04'), ('23', '3', 'Include & Exclude', null, 'ti ti-import', null, 'include-admin-view', '2017-10-19 08:20:55', '2017-10-19 08:20:55'), ('24', '7', 'Pendaftaran Agen', null, 'fa fa-user', null, 'pendaftaran-agen-view', '2017-10-19 15:08:20', '2017-10-23 06:29:45'), ('25', '3', 'Tour Class', null, 'fa fa-sort-numeric-asc', null, 'classtour-admin-view', '2017-10-25 14:53:25', '2017-10-25 14:53:25'), ('26', '3', 'Open Trip', null, 'fa fa-globe', null, 'opentrip-admin-view', '2017-10-25 15:39:39', '2017-10-25 15:39:39'), ('27', '9', 'Buku Saldo', 'cashbook', 'ti  ti-money', null, 'cashbook-view', '2017-10-27 04:08:43', '2017-10-27 04:08:43'), ('28', '9', 'Topup', null, 'ti ti-upload', null, 'topup-submitted-view', '2017-10-27 04:09:48', '2017-10-27 04:09:48'), ('29', '9', 'Withdraw', null, 'ti ti-download', null, 'withdraw-view', '2017-10-27 04:10:20', '2017-10-27 04:10:20'), ('30', '10', 'Laporan Tour', 'report/tour', 'ti ti-bar-chart-alt', null, 'report-tour', '2017-10-27 04:17:03', '2017-10-27 04:17:03');
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `thirdmenus`
-- ----------------------------
BEGIN;
INSERT INTO `thirdmenus` VALUES ('2', '6', '18', 'Cari paket', 'tour/search', 'fa fa-search', null, 'tour-menu', '2017-10-15 13:04:58', '2017-10-15 15:33:42'), ('3', '3', '0', 'Tambah', 'tour/admin/add', 'fa fa-plus', null, 'tour-admin-add', '2017-10-15 16:49:17', '2017-10-15 16:49:17'), ('4', '3', '16', 'Tambah', 'tour/admin/add', 'fa fa-plus', null, 'tour-admin-add', '2017-10-15 16:51:04', '2017-10-15 16:51:04'), ('5', '1', '5', 'Daftar', 'thirdmenu/show', 'fa fa-list', null, 'thirdmenu-view', '2017-10-15 16:57:16', '2017-10-15 17:02:47'), ('6', '1', '5', 'Tambah', 'thirdmenu/add', 'fa fa-plus', null, 'thirdmenu-add', '2017-10-15 16:58:34', '2017-10-15 17:00:30'), ('7', '3', '16', 'Daftar', 'tour/admin/show', 'fa fa-list', null, 'tour-admin-view', '2017-10-15 17:03:55', '2017-10-15 17:03:55'), ('8', '1', '15', 'Tambah', 'user/add', 'fa fa-plus', null, 'user-management-add', '2017-10-15 17:05:13', '2017-10-15 17:05:13'), ('9', '1', '15', 'Daftar', 'user/show', 'fa fa-list', null, 'user-management-view', '2017-10-15 17:06:07', '2017-10-15 17:06:07'), ('10', '3', '19', 'Tambah', 'region/add', 'fa fa-plus', null, 'region-admin-add', '2017-10-17 07:16:21', '2017-10-17 07:16:34'), ('11', '3', '19', 'Daftar', 'region/show', 'fa fa-list', null, 'region-admin-view', '2017-10-17 07:20:06', '2017-10-17 07:20:06'), ('12', '3', '20', 'Tambah', 'country/add', 'fa fa-plus', null, 'country-admin-add', '2017-10-17 13:47:52', '2017-10-17 13:47:52'), ('13', '3', '20', 'Daftar', 'country', 'fa fa-list', null, 'country-admin-view', '2017-10-17 13:48:28', '2017-10-17 13:48:28'), ('14', '3', '21', 'Tambah', 'destination/add', 'fa fa-plus', null, 'destination-admin-add', '2017-10-17 19:37:00', '2017-10-17 19:37:00'), ('15', '3', '21', 'Daftar', 'destination/show', 'fa fa-list', null, 'destination-admin-view', '2017-10-17 19:37:41', '2017-10-17 19:37:41'), ('16', '3', '23', 'Tambah', 'includes/add', 'fa fa-plus', null, 'include-admin-add', '2017-10-19 08:21:57', '2017-10-19 08:51:56'), ('17', '3', '23', 'Daftar', 'includes', 'fa fa-list', null, 'include-admin-view', '2017-10-19 08:22:41', '2017-10-19 08:51:38'), ('18', '7', '24', 'Form Pendaftaran Agen', 'membership/add', 'ti ti-clipboard', null, 'pendaftaran-agen-add', '2017-10-19 15:09:34', '2017-10-23 06:32:12'), ('19', '3', '25', 'Tambah', 'classtour/add', 'fa fa-plus', null, 'tour-admin-add', '2017-10-25 14:54:10', '2017-10-25 14:54:10'), ('20', '3', '25', 'Daftar', 'classtour', 'fa fa-list', null, 'classtour-admin-view', '2017-10-25 14:54:49', '2017-10-25 14:54:49'), ('21', '3', '26', 'Daftar', 'opentrip/admin', 'fa fa-list', null, 'opentrip-admin-view', '2017-10-25 15:40:40', '2017-10-25 15:40:40'), ('22', '3', '26', 'Tambah', 'opentrip/admin/add', 'fa fa-plus', null, 'opentrip-admin-add', '2017-10-25 15:41:26', '2017-10-26 05:03:03'), ('23', '9', '28', 'Daftar', 'topup', 'fa fa-list', null, 'topup-submitted-view', '2017-10-27 04:11:34', '2017-10-27 04:19:51'), ('24', '9', '28', 'Pengajuan', 'topup/add', 'ti ti-file', null, 'topup-submitted-add', '2017-10-27 04:12:39', '2017-10-27 04:20:02'), ('25', '9', '29', 'Daftar', 'withdraw', 'fa fa-list', null, 'withdraw-view', '2017-10-27 04:14:44', '2017-10-27 04:20:14'), ('26', '9', '29', 'Pengajuan', 'withdraw/add', 'ti ti-file', null, 'withdraw-add', '2017-10-27 04:15:38', '2017-10-27 04:20:23');
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `tour_banners`
-- ----------------------------
BEGIN;
INSERT INTO `tour_banners` VALUES ('1', '4', null, null, '1508070998-Sumatera3.jpg', '2017-10-15 12:36:38', '1', '2017-10-15 12:36:38', null), ('2', '4', null, null, '1508071144-Sumatera2.jpg', '2017-10-15 12:39:04', '1', '2017-10-15 12:39:04', null), ('3', '4', null, null, '1508071249-Sumatera3.jpg', '2017-10-15 12:40:49', '1', '2017-10-15 12:40:49', null), ('4', '5', null, null, '1508084085-Jawa2.jpg', '2017-10-15 16:14:45', '1', '2017-10-15 16:14:45', null), ('5', '11', null, null, '1509069846-246.jpg', '2017-10-27 02:04:06', '4', '2017-10-27 02:04:06', null), ('6', '15', null, null, '1509076501-belitung-island-watermark-c2aa25.jpg', '2017-10-27 03:55:01', '4', '2017-10-27 03:55:01', null), ('7', '16', null, null, '1509078017-main-pool-at-viceroy-ubud-bali.jpg', '2017-10-27 04:20:17', '4', '2017-10-27 04:20:17', null), ('8', '17', null, null, '1509083547-160413160609-05-bali-bingin-beach-super-169.jpg', '2017-10-27 05:52:27', '4', '2017-10-27 05:52:27', null);
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `tours`
-- ----------------------------
BEGIN;
INSERT INTO `tours` VALUES ('4', '1', '1', '1', 'Jakarta - Lampung 3D', '3 Hari 2 Malam', '<p><strong>Day 1 :</strong></p>\r\n<p>Sesampainya di Pelabuhan Merak/Bandara Soekarno Hatta, langsung briefing dengan Local Guide (Java Tour Team)<br />berlanjut menuju Penginapan untuk Check In &ndash; Wisata Keliling Monas - Kota Tua sambil makan siang (nasi box) di<br />sekitar Kota Tua.<br />Perjalanan sholat isya ke Mesjid Istiqlal dan segera kembali ke penginapan, dan langsung makan malam (nasi box) &ndash;<br />free time.</p>\r\n<p>&nbsp;</p>\r\n<p><strong>Day 2 :</strong></p>\r\n<p>Setelah sarapan kita akan mengunjungi TMII selama seharian (full day) &ndash; makan siang (prasmanan) di salah satu<br />anjungan &ndash; explore museum2di TMII &ndash; makan malam (D&rsquo;cost)<br />Free time ke Tamini Square, untuk belanja oleh2 dan segeran kembali ke penginapan untuk beristirahat melanjutkan wisata besok.</p>\r\n<p>&nbsp;</p>\r\n<p><strong>Day 3 :</strong></p>\r\n<p>Setelah sarapan, langsung Check Out &ndash; perjalananan pulang ke Bandara Soekarno Hatta/menyebrang dari Merak ke<br />Bakauheni untuk menuju Pantai Pasir Putih, Lampung &ndash; makan siang di pinggir pantai. End of Service.<br />Terima kasih untuk keikutsertaan Anda bersama kami. Sampai jumpa dalam perjalanan tour lainnya.</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>', 'YOUTUBE', '<p>BIAYA &amp; PEMBAYARAN :</p>\r\n<ul>\r\n<li>Harga fleksibel, tergantung waktu keberangkatan, jumlah peserta dalam grup, jenis akomodasi yang<br />diminta, dan tempat-tempat yang ingin dituju sesuai permintaan khusus bila ada.</li>\r\n<li>Biaya International Airport tax / fuel charge dapat berubah sewaktu-waktu dengan / tanpa<br />pemberitahuan terlebih dahulu, sesuai dengan peraturan pihak penerbangan terkait</li>\r\n<li>Booking Fee Rp. 100.000,- sampai dengan tgl 18 Juli 2016 (non refundable)</li>\r\n<li>Deposit 50% maksimal 2 bln sebelum keberangkatan</li>\r\n<li>Pelunasan maksimal 1 bln sebelum keberangkatan</li>\r\n<li>Tidak ada pengembalian utk tour/object yg tdk terpakai</li>\r\n<li>Biaya pembatalan dlm waktu kurang dari 60 hari sebelum keberangkatan dikenakan biaya 70%</li>\r\n<li>Biaya pembatalan dlm waktu kurang dari 30 hari sebelum keberangkatan dikenakan biaya 100%</li>\r\n<li>Pembayaran dalam rupiah mengikuti kurs yang berlaku di pasaran (kurs BCA) pada saat terjadi<br />transaksi pembayaran</li>\r\n<li>Harga dapat berubah sewaktu-waktu</li>\r\n</ul>', '1', '2,3', '1250000', '1300000', '1', '2017-10-15 10:40:38', '1', '2017-10-26 03:09:20', '4'), ('5', '1', '1', '2', 'Cottage Pulau Seribu', '2 Hari 1 Malam', '<p><strong>Day 1 :</strong></p>\r\n<p>Para peserta berkumpul di Dermaga Marina, Pier 17 minimum 2 jam sebelum keberangkatan untuk memulai acara<br />perjalanan menuju Cottage di Pulau Seribu.<br />Tiba di salah satu Pulau Seribu tujuan, langsung check-in Cottage dan Makan Siang sebelum mempersiapkan main air.<br />Setelah Ishoma, menuju perahu kayu untuk kegiatan Snorkeling di gugusan pulau-pulau kecil di sekitar Cottage.<br />Menikmati Sunset di suatu pulau atau dalam perjalanan pulang menuju Cottage, setiba di Cottage bersih-bersih dan<br />langsung mempersiapkan diri untuk berkumpul bersama dalam Makan Malam dan BBQ.</p>\r\n<p>&nbsp;</p>\r\n<p><strong>Day 2 :</strong></p>\r\n<p>Bangun pagi dan langsung hunting Sunrise di sekitar dermaga Cottage, bersiap check out dan langsung menikmati Sarapan.<br />Menuju kapal cepat untuk perjalanan pulang menuju Jakarta.<br />Tiba di Jakarta. Terima kasih untuk keikutsertaan Anda bersama kami. Sampai jumpa dalam perjalanan tour lainnya.</p>', null, '<p><strong>PENTING :</strong><br />*)Bonus berlaku untuk Paket Rombongan (min.25 orang)<br />Kami berhak membatasi jumlah peserta sesuai kesepakatan, merubah jadwal keberangkatan dengan<br />alasan keselamatan (karena situasi yang tidak memungkinkan), men-set ulang rute-rute perjalanan<br />bila terjadi hal-hal diluar dugaan kami / force majeur, dengan terlebih dahulu menginformasikan<br />kepada Anda.</p>\r\n<p><br /><strong><em>BIAYA &amp; PEMBAYARAN :</em></strong></p>\r\n<ul>\r\n<li>Harga fleksibel, tergantung waktu keberangkatan, jumlah peserta dalam grup, jenis akomodasi yang<br />diminta, dan tempat-tempat yang ingin dituju sesuai permintaan khusus bila ada;</li>\r\n<li>Booking Fee minimal Rp 500.000,- langsung dibayarkan pada saat pendaftaran (non refundable);</li>\r\n<li>Deposit 50% minimal 1 hari setelah deal dan maksimal 2 bulan sebelum keberangkatan;</li>\r\n<li>Pelunasan maksimal 1 bulan sebelum keberangkatan;</li>\r\n<li>Tidak ada pengembalian untuk tour/obyek yg tidak terpakai;</li>\r\n<li>Biaya pembatalan dlm waktu kurang dari 20 hari sebelum keberangkatan dikenakan biaya 70%;</li>\r\n<li>Biaya pembatalan dlm waktu kurang dari 7 hari sebelum keberangkatan dikenakan biaya 100%;</li>\r\n<li>Harga dapat berubah sewaktu-waktu.</li>\r\n</ul>', '1', '2,3', '0', '850000', '1', '2017-10-15 16:13:17', '1', '2017-10-15 16:13:17', '1'), ('6', '1', '1', '4', 'Malang', '4D 3N', '<p><strong>Hari 01 :&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </strong>City Tour Malang&nbsp;<strong>(L,D)</strong></p>\r\n<p>&nbsp;</p>\r\n<p><strong>08.00&nbsp;</strong>Pick up di Airport Juanda Surabaya (Arrival 08.00am / ETD) Welcome Drink &amp; Breakfast Box</p>\r\n<p><strong>09.45 </strong>City Tour&nbsp;<strong>+&nbsp;</strong>Photo stop Surabaya melewati Tugu <strong>Pahlawan &amp; Museum Kapal Selam</strong></p>\r\n<p><strong>12.00&nbsp;</strong>Lunch di local Restaurant&nbsp;<strong>+&nbsp;</strong>sholat di Masjid</p>\r\n<p><strong>13.30&nbsp;</strong>Mlanjutkan perjalanan menuju kota Malang</p>\r\n<p><strong>15.30&nbsp;</strong>Tiba di Malang check in hotel / villa&nbsp;<strong>+</strong> Rooming</p>\r\n<p><strong>18.45</strong> Setelah Sholat Maghrib, menuju Batu Night Spectacular Tour (tiket masuk+voucher makan inculded)</p>\r\n<p><strong>22.15</strong> Bertemu di Meeting point dekat pintu masuk, untuk kembali ke hotel dan beristirahat.</p>\r\n<p>&nbsp;</p>\r\n<p><strong>Hari 02 :</strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Malang Full Day Adventure Program (B,L,D)</p>\r\n<p>&nbsp;</p>\r\n<p><strong>07.00</strong> Breakfast&nbsp;</p>\r\n<p><strong>08.30</strong> Internal Meeting di Meeting Room (Meeting equipment include : Air mineral, notes, flipchart, pointer, infocus mic)</p>\r\n<p><strong>11.45</strong> Setelah itu sholat Dzuhur dan makan siang di hotel (buffet) ditemani hiburan Organ Tunggal.</p>\r\n<p><strong>14.00</strong> Selanjutnya peserta bersiap untuk City Tour kota malang dengan melewati atau mampir di Alun-alun Kota Malang, Gereja Ghotic kayu Tangan, Masjid Jami Malang, Toko Oen, Ijen Boulevard Museum Angkut + Movie Star secukupnya waktu atau sesempatnya</p>\r\n<p><strong>18.00</strong> Sholat Maghrib di Masjid, Dinner local Restaurant</p>\r\n<p>&nbsp;</p>\r\n<p><strong>Hari 03</strong> :&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Malang City Tour <strong>(B,L,D)</strong></p>\r\n<p><strong>07.00</strong> sarapan</p>\r\n<p><strong>08.00</strong> Peserta bersiap-siap menuju lokasi Outbound, Dengan pilihan : Rafting sepanjang sungai 10KM dengan grade 3 atau Paint Ball BONUS dan Fun Games, peserta akan menikmati Full Day Adventure hari ini.</p>\r\n<p><strong>16.00</strong> Peserta bersih bersih ganti pakaian</p>\r\n<p><strong>18.00</strong> Sholat Maghrib di masjid, Dinner local Restaurant.</p>\r\n<p>&nbsp;</p>\r\n<p><strong>Hari 04</strong>:&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Malang <strong>(B,L)</strong></p>\r\n<p><strong>07.00</strong> Sarapan</p>\r\n<p><strong>08.00</strong> Check out peserta bersiap untuk ke surabaya, dan mampir untuk memetik apel &amp; berbelanja di pusat oleh-oleh</p>', null, '<ul>\r\n<li>Harga fleksibel tergantung waktu keberangkatan, jumlah peserta dalam group, enis akomodasi yang diminta dan tempat-tempat yang ingin di tuju sesuai permintaan khusus bila ada</li>\r\n<li>Biaya international Airport tax / fuel charge dapat berubah sewaktu-waktu dengan / tanpa pemberitahuan terlebih dahulu, sesuai dengan peraturan pihak penerbangan terkait</li>\r\n<li>Booking fee Rp.300.000/pax</li>\r\n<li>Maksimal dibayarkan pada tanggal 11 oct 2017</li>\r\n<li>Deposit (payment 1) 30% dibayarkan 60 hari sebelum keberangkatan,(pamet 2) sebesar 30% dibayarkan 30 hari sebelum keberangkatan</li>\r\n<li>Pelunasan maksimal 20 hari sebelum keberangkatan</li>\r\n<li>tidak ada pengembalian untuk tour/object yang tidak terpakai</li>\r\n<li>biaya pembatalan dalam waktu kurang dari 20 hari sebelum keberangkatan dikenakan biaya 70%</li>\r\n<li>Biaya pembatalan dalam waktu kurang dari 7 hari sebelum keberangkatan dikenakana biaya 100%</li>\r\n</ul>', '5', '', '3299000', '3299000', '1', '2017-10-26 13:21:54', '4', '2017-10-26 13:26:51', '4'), ('7', '1', '6', '5', 'Sentosa Island', '3D', '<p><strong>Hari 01 : Jakarta &ndash;</strong><br /><strong>Singapore (D)</strong></p>\r\n<p>Para peserta berkumpul di Bandara Internasional Soetta minimum 03 jam sebelum keberangkatan untuk<br />memulai acara perjalanan ke &rdquo;Singapore&rdquo;. Setelah tiba di Singapore, Anda akan diajak untuk beristirahat. Free<br />program.</p>\r\n<p>&nbsp;</p>\r\n<p><strong>Hari 02 : Sentosa Island</strong><br /><strong>Singapore (B)</strong></p>\r\n<p>&nbsp;</p>\r\n<p>Hari ini Anda akan menikmati keindahan pantai di Sentosa Island Singapore, sore harinya menyaksikan atraksi<br />laser Song of the sea yang spektakuler.</p>\r\n<p>&nbsp;</p>\r\n<p><strong>Hari 03 : Singapore &ndash;</strong><br /><strong>Jakarta (B)</strong></p>\r\n<p>&nbsp;</p>\r\n<p>Setelah sarapan Anda akan di antar untuk melihat Merlion (icon negara Singapore, kemudian dilanjutkan<br />menuju Orchad road shopping center, Takasimaya, Lucky Plaza, Bugis Street, Bugis Junction, dll (bila waktunya<br />memungkinkan) sebelum diantar menuju airport.<br />Terima kasih untuk keikutsertaan Anda bersama kami. Sampai jumpa dalam perjalanan tour lainnya. See You<br />and have a good day </p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>', null, '<p><strong>PENTING :</strong></p>\r\n<ul>\r\n<li>Kami berhak membatasi jumlah peserta sesuai kesepakatan, merubah jadwal keberangkatan dengan<br />alasan keselamatan (karena situasi yang tidak memungkinkan), men-set ulang rute-rute perjalanan<br />bila terjadi hal-hal diluar dugaan kami / force majeur, dengan terlebih dahulu menginformasikan<br />kepada Anda.</li>\r\n</ul>\r\n<p><strong>BIAYA &amp; PEMBAYARAN :</strong></p>\r\n<ul>\r\n<li>Harga fleksibel, tergantung waktu keberangkatan, jumlah peserta dalam grup, jenis akomodasi yang<br />diminta, dan tempat-tempat yang ingin dituju sesuai permintaan khusus bila ada.</li>\r\n<li>Biaya International Airport tax / fuel charge dapat berubah sewaktu-waktu dengan / tanpa<br />pemberitahuan terlebih dahulu, sesuai dengan peraturan pihak penerbangan terkait</li>\r\n<li>Booking Fee $ 50 saat pendaftaran (non refundable)</li>\r\n<li>Deposit 50% maksimal 1 bln sebelum keberangkatan</li>\r\n<li>Pelunasan maksimal 2 minggu sebelum keberangkatan</li>\r\n<li>Tidak ada pengembalian utk tour/object yg tdk terpakai</li>\r\n<li>Biaya pembatalan dlm waktu kurang dari 20 hari sebelum keberangkatan dikenakan biaya 70%</li>\r\n<li>Biaya pembatalan dlm waktu kurang dari 7 hari sebelum keberangkatan dikenakan biaya 100%</li>\r\n<li>Pembayaran dalam rupiah mengikuti kurs yang berlaku di pasaran (kurs BCA) pada saat terjadi<br />transaksi pembayaran</li>\r\n<li>Harga berubah sewaktu-waktu sebelum booking fee dibayarkan.</li>\r\n</ul>', '5,1,6', '2,4', '1111111', '1999999', '1', '2017-10-26 22:59:53', '4', '2017-10-26 22:59:53', '4'), ('8', '1', '6', '6', 'Singapore – Universal Studio 5D', '5 Hari', '<p><strong>Day 1 :</strong></p>\r\n<p>Para peserta berkumpul di Bandara Internasional Soetta minimum 03 jam sebelum keberangkatan untuk memulai<br />acara perjalanan ke &rdquo;Singapore&rdquo;. Setelah tiba di Singapore, Anda akan diajak untuk beristirahat. Free program.</p>\r\n<p>&nbsp;</p>\r\n<p><strong>Day 2 :</strong></p>\r\n<p>Pagi hari kita akan menuju Resort World di Sentosa Island utk menikmati Universal Studio, dimana terdapat<br />Battlestar Galactica (The World Tallest Pair of duelling Coaster), Far Far Away Castle, Madagascar (A Crate<br />Adventure), Water World, Revenge of the Mummy, Jurassic Park Rapids Adventure, Hollywood Boulevard, Festive<br />Walk, Marine Life Park.</p>\r\n<p>&nbsp;</p>\r\n<p><strong>Day 3 :</strong></p>\r\n<p>Menghabiskan waktu di surge belanja yang paling terkenal di Singapore, diantaranya: Takasimaya, Lucky Plaza, Bugis<br />Street, Bugis Junction, dll</p>\r\n<p>&nbsp;</p>\r\n<p><strong>Day 4 :</strong></p>\r\n<p>Setelah sarapan Anda akan di antar untuk melihat Merlion (icon negara Singapore, kemudian dilanjutkan menuju<br />Orchad road shopping center.</p>\r\n<p>&nbsp;</p>\r\n<p><strong>Day 5 :</strong></p>\r\n<p><strong>Setelah sarapan, bersiap check out dan free time untuk menunggu flight di Bandara Changi.<br />Terima kasih untuk keikutsertaan Anda bersama kami. Sampai jumpa dalam perjalanan tour lainnya. See You and<br />have a good day </strong></p>', null, '<p><strong>PENTING :</strong></p>\r\n<ul>\r\n<li>Kami berhak membatasi jumlah peserta sesuai kesepakatan, merubah jadwal keberangkatan dengan<br />alasan keselamatan (karena situasi yang tidak memungkinkan), men-set ulang rute-rute perjalanan<br />bila terjadi hal-hal diluar dugaan kami / force majeur, dengan terlebih dahulu menginformasikan<br />kepada Anda.</li>\r\n</ul>\r\n<p><br /><strong>BIAYA &amp; PEMBAYARAN :</strong></p>\r\n<ul>\r\n<li>Harga fleksibel, tergantung waktu keberangkatan, jumlah peserta dalam grup, jenis akomodasi yang<br />diminta, dan tempat-tempat yang ingin dituju sesuai permintaan khusus bila ada.</li>\r\n<li>Biaya International Airport tax / fuel charge dapat berubah sewaktu-waktu dengan / tanpa pemberitahuan terlebih dahulu, sesuai dengan peraturan pihak penerbangan terkait</li>\r\n<li>Booking Fee $ 50 saat pendaftaran (non refundable)</li>\r\n<li>Deposit 50% maksimal 1 bln sebelum keberangkatan</li>\r\n</ul>', '5,1,6', '2,4', '111111111', '1999999', '1', '2017-10-26 23:36:32', '4', '2017-10-27 00:03:06', '4'), ('9', '1', '8', '7', 'Asia Alilla', '6 Hari', '<p><strong>Day 1 Jakarta &ndash;<br />Singapore:</strong></p>\r\n<p>Para peserta berkumpul di Bandara Internasional Soetta minimum 03 jam sebelum keberangkatan menuju<br />Singapore. Setibanya di Singapore Anda akan diantarkan ke Hotel untuk beristirahat. Free Program.</p>\r\n<p><strong>Day 2 Singapore -B,L:</strong></p>\r\n<p>Hari ini kita akan sight seeing (city tour) mengunjungi Merlion, ikon negara Singapore, kemudian mengunjungi /<br />melewati Orchad Road / Bugis Street / China Town, Anda bisa berbelanja atau sekedar window shopping<br />disana, sebelum melanjutkan perjalanan menuju Vivo Mall, kemudian bila sempat dilanjutkan ke Sentosa Island<br />untuk menikmati pertunjukan &ldquo;Song of The Sea&rdquo;. Opsi lain adalah dengan menikmati Singapore di waktu malam<br />dengan boat quay / cruise.</p>\r\n<p><strong>Day 3&nbsp;Singapore &ndash; Johor Bahru Malaysia - B,L :</strong></p>\r\n<p>Setelah sarapan kita akan transfer ke Johor Bahru Malaysia untuk mengunjungi Legoland (ticket optional) dan<br />menikmati wahana bermain, sore harinya kita akan menuju Kuala Lumpur, setelah tiba di KL (malam hari), kita<br />akan sight seeing / keliling kota sejenak, menikmati suasana Kuala Lumpur di waktu malam, sebelum diantarkan<br />ke hotel untuk beristirahat.</p>\r\n<p><strong>Day 4&nbsp;Johor Bahru - KL Malaysia - B,L :</strong></p>\r\n<p>Hari ini, kita akan mengunjungi National Monument, National Palace/Istana Negara, Independent Square,<br />National Mosque, City Gallery, KLCC dan Twin Tower. Dilanjutkan ke area belanja, yaitu Little India / China<br />Town.</p>\r\n<p><strong>Day 5&nbsp;KL Malaysia &ndash; Singapore - B,L :</strong></p>\r\n<p>Pagi hari setelah sarapan kita akan menuju mengunjungi Genting Higland, yang sering disebut sebagai Las<br />Vegasnya Asia. (Theme Park Ticket &amp; Skyway Cable Car ride ticket are optional).</p>\r\n<p><strong>Day 6&nbsp;KL &ndash; Jakarta - B :</strong></p>\r\n<p>Hari ini kita akan bersiap-siap untuk kembali ke tanah air dengan membawa berjuta kenangan indah.<br />Tiba di Jakarta. Terima kasih untuk keikutsertaan Anda bersama kami. Sampai jumpa dalam perjalanan tour<br />lainnya. See You and have a good day&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>', null, '<p><strong>PENTING :</strong></p>\r\n<ul>\r\n<li>Kami berhak membatasi jumlah peserta sesuai kesepakatan, merubah jadwal keberangkatan dengan<br />alasan keselamatan (karena situasi yang tidak memungkinkan), men-set ulang rute-rute perjalanan<br />bila terjadi hal-hal diluar dugaan kami / force majeur, dengan terlebih dahulu menginformasikan<br />kepada Anda.</li>\r\n</ul>\r\n<p><br /><strong>BIAYA &amp; PEMBAYARAN :</strong></p>\r\n<ul>\r\n<li><br />Harga fleksibel, tergantung waktu keberangkatan, jumlah peserta dalam grup, jenis akomodasi yang<br />diminta, dan tempat-tempat yang ingin dituju sesuai permintaan khusus bila ada.</li>\r\n<li>Biaya International Airport tax / fuel charge dapat berubah sewaktu-waktu dengan / tanpa<br />pemberitahuan terlebih dahulu, sesuai dengan peraturan pihak penerbangan terkait</li>\r\n<li>Booking Fee $ 300 saat pendaftaran (non refundable)</li>\r\n<li>Deposit 50% maksimal 3 min ggu sebelum keberangkatan</li>\r\n<li>Pelunasan maksimal 1 minggu sebelum keberangkatan</li>\r\n<li>Tidak ada pengembalian utk tour/object yg tdk terpakai</li>\r\n<li>Biaya pembatalan dlm waktu kurang dari 20 hari sebelum keberangkatan dikenakan biaya 70%</li>\r\n<li>Biaya pembatalan dlm waktu kurang dari 7 hari sebelum keberangkatan dikenakan biaya 100%</li>\r\n<li>Pembayaran dalam rupiah mengikuti kurs yang berlaku di pasaran (kurs BCA) pada saat terjadi<br />transaksi pembayaran</li>\r\n</ul>', '5,1,6', '2,4', '111111111', '3325000', '1', '2017-10-27 00:00:59', '4', '2017-10-27 00:00:59', '4'), ('10', '1', '8', '8', 'Asia Aleya', '6 Hari', '<p><strong>Day 1&nbsp;Jakarta &ndash; Brunei Darussalam :</strong></p>\r\n<p>Para peserta berkumpul di Bandara Internasional Soetta minimum 03 jam sebelum keberangkatan menuju<br />Brunei Darussalam. Setibanya di Brunei Anda akan diantarkan ke Hotel untuk beristirahat. Free Program.</p>\r\n<p><strong>Day 2&nbsp;Brunei Darussalam - B :</strong></p>\r\n<p>One day trip<br />Dijemput dari hotel kemudian mengunjungi National Museum, Royal Ragalia Museum, Sultan palace Istana<br />Nurul Iman, mengunjungi masjid Sultan Omar dan James Asr Hassanal Bolkiah kemudian menuju Kampung<br />Ayer (old water village), dan kembali ke hotel</p>\r\n<p><strong>Day 3&nbsp;Brunei &ndash; KL Malaysia - B :</strong></p>\r\n<p>Setelah sarapan kita akan bersiap terbang menuju KL Malaysia, setelah tiba Anda akan diantarkan ke hotel<br />untuk beristirahat. Free Program / Meeting</p>\r\n<p><strong>Day 4&nbsp;KL - Malaysia B :</strong></p>\r\n<p>Pagi hari setelah sarapan kita akan mengunjungi Twin Tower, KLCC, Little India dan China town untuk<br />berbelanja oleh-oleh sebelum melanjutkan perjalanan menuju Singapore dengan pesawat.</p>\r\n<p><strong>Day 5&nbsp;KL Malaysia &ndash; Singapore - B :</strong></p>\r\n<p>Setiba di Singapore Kita akan city tour mengunjungi Merlion, ikon negara Singapore kemudian bila sempat<br />(waktunya mencukupi) dilanjutkan ke Sentosa Island untuk menikmati pertunjukan &ldquo;Song of The Sea&rdquo;. Opsi<br />lain adalah dengan menikmati Singapore di waktu malam dengan boat quay / cruise.</p>\r\n<p><strong>Day 6&nbsp;Singapore - Jakarta :</strong></p>\r\n<p>Sebelum kembali ke tanah air, Anda akan diajak untuk berbelanja di Orchad Road / Vivo / Bugis Street /<br />China Town.<br />Tiba di Jakarta. Terima kasih untuk keikutsertaan Anda bersama kami. Sampai jumpa dalam perjalanan tour<br />lainnya. See You and have a good day </p>', null, '<p><strong>PENTING :</strong></p>\r\n<ul>\r\n<li>Kami berhak membatasi jumlah peserta sesuai kesepakatan, merubah jadwal keberangkatan dengan<br />alasan keselamatan (karena situasi yang tidak memungkinkan), men-set ulang rute-rute perjalanan<br />bila terjadi hal-hal diluar dugaan kami / force majeur, dengan terlebih dahulu menginformasikan<br />kepada Anda.</li>\r\n</ul>\r\n<p><br /><strong>BIAYA &amp; PEMBAYARAN :</strong></p>\r\n<ul>\r\n<li>Harga fleksibel, tergantung waktu keberangkatan, jumlah peserta dalam grup, jenis akomodasi yang<br />diminta, dan tempat-tempat yang ingin dituju sesuai permintaan khusus bila ada.</li>\r\n<li>Biaya International Airport tax / fuel charge dapat berubah sewaktu-waktu dengan / tanpa<br />pemberitahuan terlebih dahulu, sesuai dengan peraturan pihak penerbangan terkait</li>\r\n<li>Booking Fee $ 300 saat pendaftaran (non refundable)</li>\r\n<li>Deposit 50% maksimal 3 min ggu sebelum keberangkatan</li>\r\n<li>Pelunasan maksimal 1 minggu sebelum keberangkatan</li>\r\n<li>Tidak ada pengembalian utk tour/object yg tdk terpakai</li>\r\n<li>Biaya pembatalan dlm waktu kurang dari 20 hari sebelum keberangkatan dikenakan biaya 70%</li>\r\n<li>Biaya pembatalan dlm waktu kurang dari 7 hari sebelum keberangkatan dikenakan biaya 100%</li>\r\n</ul>', '5,1,6', '2,4', '111111111', '6999999', '1', '2017-10-27 00:15:14', '4', '2017-10-27 00:15:14', '4'), ('11', '1', '9', '9', 'Golden Route Japan', '6 Hari', '<p><strong>Day 1 Jakarta - Osakao - On Board Meals :</strong></p>\r\n<p>Para peserta berkumpul di airport minimum 04 jam sebelum keberangkatan untuk memulai acara<br />perjalanan &rdquo;Golden Route Japan&rdquo;</p>\r\n<p><strong>Day 2&nbsp;Osaka Japan - L,D :&nbsp;</strong></p>\r\n<p>Setibanya di Osaka Anda akan dijemput oleh local guide, langsung mengunjungi Osaka Castle<br />kemudian makan siang, dan dilanjutkan menuju Osaka Central Mosque, Umeda Sky Building<br />(Floating Garden), kemudian berbelanja di Shinsaibashi / Dotonburi, bila ingin menggunakan kimono<br />Jepang, bisa mengunjungi tourist information kemudian berfoto dengan kimono.<br />Akomodasi : Plaza Osaka / setaraf *3</p>\r\n<p><strong>Day 3&nbsp;Osaka - Nara - Kyoto - Osaka -&nbsp;B,L,D&nbsp;:</strong></p>\r\n<p>Hari ini setelah sarapan pagi, kita akan mengunjungi Nara Deer Park dimana banyak rusa-rusa jinak<br />disekitar yang bisa diajak berfoto dengan pengunjung, kemudian makan siang dan ke Masjid Kyoto<br />untuk sholat, setelah itu Kiyomizu Temple (kuil Budha dengan pemandangan natural yang indah<br />disekitarnya), Sannen-Zakka Street, Arashiyama Park, kemudian kembali ke Osaka untuk beristiahat.<br />Akomodasi : Plaza Osaka / setaraf *3</p>\r\n<p><strong>Day 4&nbsp;Osaka - Tokyo - B,L,D :</strong></p>\r\n<p>Dengan Bullet Train menuju kota metropolitan Tokyo, setelah tiba Anda akan diantarkan ke masjid<br />Tokyo Cami Mosque, setelah sholat, melanjutkan perjalanan ke kuil Budha tertua di Jepang yaitu<br />Asakusa Kannon Temple, Nakami Souvenir Street, photo stop dengan latar belakang Tokyo Sky Tree,<br />menara dengan ketinggian sekitar 634m, selanjutnya bila sempat akan melewati Imperial Palace,<br />istana kerajaan Jepang, kemudian melanjutkan perjalanan menuju Shinjuku.<br />Akomodasi : APA Hotel Gyoenmae / setaraf *3</p>\r\n<p><strong>Day 5&nbsp; Tokyo-Jakarta-B,L,D :</strong></p>\r\n<p>Hari ini kita akan mengunjungi Hakkone, Danau Ashi dengan kapal pesiar, selanjutnya window<br />shopping / berbelanja di kawasan elite Ginza / Gottemba Premium Outlet / mengunjungi Hitachi<br />Seaside Park, yang seluas 190 hektar menawarkan keindahan dengan berbagai variasi hamparan<br />bunga-bunga cantik yang bersemi hampir sepanjang tahun (sesempatnya).<br />Akomodasi : APA Hotel Gyoenmae / setaraf *3</p>\r\n<p><strong>Day 6&nbsp;Tokyo - Jakarta-B :</strong></p>\r\n<p>Setelah sarapan, Anda akan bersiap menuju airport menuju tanah air dengan selamat bersama<br />kenangan indah selama di Jepang. Terima kasih untuk keikutsertaan Anda bersama kami. Sampai<br />jumpa dalam perjalanan tour lainnya. See You and have a good day&nbsp;</p>\r\n<p>&nbsp;</p>', null, '<p><strong>PENTING :</strong></p>\r\n<ul>\r\n<li>Kami berhak membatasi jumlah peserta sesuai kesepakatan, merubah jadwal keberangkatan dengan<br />alasan keselamatan (karena situasi yang tidak memungkinkan), men-set ulang rute-rute perjalanan<br />bila terjadi hal-hal diluar dugaan kami / force majeur, dengan terlebih dahulu menginformasikan<br />kepada Anda.</li>\r\n<li>Waktu keberangkatan dan kepulangan diusahakan sesuai dengan rencana, namun karena perjalanan<br />dilakukan pada saat peak session, maka penyesuaian tanggal keberangkatan maupun kepulangan<br />sangat mungkin terjadi, sesuai dengan ketersediaan seat pada maskapai perjalanan.</li>\r\n</ul>\r\n<p><strong>BIAYA &amp; PEMBAYARAN :</strong></p>\r\n<ul>\r\n<li>Harga fleksibel, tergantung waktu keberangkatan, jumlah peserta dalam grup, jenis akomodasi yang<br />diminta, dan tempat-tempat yang ingin dituju sesuai permintaan khusus bila ada.</li>\r\n<li>Biaya International Airport tax / fuel charge dapat berubah sewaktu-waktu dengan / tanpa<br />pemberitahuan terlebih dahulu, sesuai dengan peraturan pihak penerbangan terkait</li>\r\n<li>Tidak ada pengembalian utk tour/object yg tdk terpakai</li>\r\n<li>Harga berubah sewaktu-waktu tanpa pemberitahuan terlebih dahulu.</li>\r\n<li>Penawaran ini berlaku sampai dengan ..........., ditandai dengan pembayaran booking fee sebesar<br />50$/pax (not refundable)</li>\r\n<li>Down payment 50% dibayarkan maksimal pada .............. (non refundable), tetapi boleh ganti nama<br />peserta</li>\r\n<li>Pelunasan maksimal 4 minggu sebelum keberangkatan</li>\r\n<li>Pembayaran dalam rupiah mengikuti kurs yang berlaku di pasaran (kurs BCA) pada saat terjadi<br />transaksi pembayaran</li>\r\n</ul>', '5,6', '2,4,1', '111111111', '25680000', '1', '2017-10-27 00:42:11', '4', '2017-10-27 00:42:11', '4'), ('12', '1', '9', '12', 'Tokyo Fujiyama', '6D', '<p style=\"text-align: justify;\"><strong>Hari 01 : Jakarta - Tokyo&nbsp; L</strong></p>\r\n<p style=\"text-align: justify;\">Hari ini Anda berkumul di Soetta Airport untuk melakukan perjalanan melintasi &ldquo;Tokyo Fujiyama&rdquo; di Jepang. Setelah tiba di Tokyo, Anda akan diajak berkeliling kota Tokyo sejenak sebelum diantarkan ke hotel untuk beristirahat.</p>\r\n<p style=\"text-align: justify;\">Akomodasi : APA Hotel Gyoenmae / setaraf *3</p>\r\n<p style=\"text-align: justify;\"><strong>Hari 02 : Tokyo&nbsp;B</strong></p>\r\n<p style=\"text-align: justify;\">Setelah sarapan, para peserta berkumpul di lobby hotel dan akan dijemput oleh local guide untuk mengeksplor kota Tokyo. Anda akan diajak full day tour untuk mengunjungi Hakkone, Danau Ashi dengan kapal pesiar, selanjutnya window shopping / berbelanja di kawasan elite Ginza / Gottemba Premium Outlet / PERSONAL SHOPPING di Akihabara-Shibuya-Gotanda-Harajuku / mengunjungi Hitachi</p>\r\n<p style=\"text-align: justify;\">Seaside Park, yang seluas 190 hektar menawarkan keindahan dengan berbagai variasi hamparan bunga- bunga cantik yang bersemi hampir sepanjang tahun, juga melewati Imperial Palace, National Diet Building, dan State Guest House (sesempatnya).</p>\r\n<p style=\"text-align: justify;\">Akomodasi : APA Hotel Gyoenmae / setaraf *3</p>\r\n<p style=\"text-align: justify;\"><strong>Hari 03 : Tokyo - Yokohama B</strong></p>\r\n<p style=\"text-align: justify;\">Hari ini setelah sarapan pagi, kita akan menuju Yokohama untuk mengunjungi Samurai Town, diawali dari area Kamakura yang dibangun pada abad 12-14, kemudian menuju Tsuragaoka Hachimangu Shrine, Komachi Dori Street dimana banyak terdapat toko2 disepanjang jalan, kemudian menuju Kotokuin Temple yang terdapat Big Budha Statue yang dibuat pada abad ke 13, sehingga kita bisa merasakan atmosphire kuil ZEN disana.</p>\r\n<p style=\"text-align: justify;\">Akomodasi : APA Hotel Gyoenmae / setaraf *3</p>\r\n<p style=\"text-align: justify;\"><strong>Hari 04 : Tokyo - Shibazakura B</strong></p>\r\n<p style=\"text-align: justify;\">Pagi hari Anda akan dijemput oleh local guide, hari ini kita akan ke luar kota untuk mengunjungi Fuji Shibazakura Festival, setelah itu kita akan menyusuri Lake Kawaguchi, juga bersantai di Oshino Hakkai dimana terdapat banyak mata air yang bersumber dari Gunung Fuji, dilanjutkan dengan acara memetik buah strawberry. Bila sempat, kita juga akan mengunjungi Japan National Monument.</p>\r\n<p style=\"text-align: justify;\">Akomodasi : APA Hotel Gyoenmae / setaraf *3<strong>&nbsp;</strong></p>\r\n<p style=\"text-align: justify;\">&nbsp;</p>\r\n<p style=\"text-align: justify;\"><strong>Hari 05 : Tokyo B</strong></p>\r\n<p style=\"text-align: justify;\">Hari ini Anda akan diajak untuk berkeliling Asakusa, dengan mengunjungi Senso-ji Temple dan Asakua Kannon Temple yang didedikasikan kepada Bodhisattva Kannon, kemudian berjalan di Nakami shopping street, dimana terdapat banyak souvenir khas Jepang, setelah itu menuju Tokyo Skytree (ticket masuk optional) dimana Anda bisa menyaksikan panorama kota Tokyo dari ketinggian 634m.</p>\r\n<p style=\"text-align: justify;\">Akomodasi : APA Hotel Gyoenmae / setaraf *3</p>\r\n<p style=\"text-align: justify;\"><strong>Hari 06 : Tokyo - Jakarta&nbsp; B</strong></p>\r\n<p style=\"text-align: justify;\">Hari ini free program, Anda akan bersiap menuju airport menuju tanah air dengan selamat bersama kenangan indah selama di Jepang. Terima kasih untuk keikutsertaan Anda bersama kami. Sampai jumpa dalam perjalanan tour lainnya. See You and have a good day.</p>', null, '<p><strong>PENTING :</strong></p>\r\n<ul>\r\n<li>Kami berhak membatasi jumlah peserta sesuai kesepakatan, merubah jadwal keberangkatan dengan alasan keselamatan (karena situasi yang tidak memungkinkan), men-set ulang rute-rute perjalanan bila terjadi hal-hal diluar dugaan kami / force majeur, dengan terlebih dahulu menginformasikan kepada Anda.</li>\r\n<li>Waktu keberangkatan dan kepulangan diusahakan sesuai dengan rencana, namun karena perjalanan dilakukan pada saat peak session, maka penyesuaian tanggal keberangkatan maupun kepulangan sangat mungkin terjadi, sesuai dengan ketersediaan seat pada maskapai perjalanan.</li>\r\n</ul>\r\n<p><strong>BIAYA &amp; PEMBAYARAN :</strong></p>\r\n<ul>\r\n<li>Harga fleksibel, tergantung waktu keberangkatan, jumlah peserta dalam grup, jenis akomodasi yang diminta, dan tempat-tempat yang ingin dituju sesuai permintaan khusus bila ada.</li>\r\n<li>Biaya International Airport tax / fuel charge dapat berubah sewaktu-waktu dengan / tanpa pemberitahuan terlebih dahulu, sesuai dengan peraturan pihak penerbangan terkait.</li>\r\n<li>Tidak ada pengembalian utk tour/object yg tdk terpakai.</li>\r\n<li>Harga berubah sewaktu-waktu tanpa pemberitahuan terlebih dahulu.</li>\r\n<li>Penawaran ini berlaku sampai dengan ..........., ditandai dengan pembayaran booking fee sebesar 50$/pax (not refundable)</li>\r\n<li>Down payment 50% dibayarkan maksimal pada .... (non refundable), tetapi boleh ganti nama peserta</li>\r\n<li>Pelunasan maksimal 4 minggu sebelum keberangkatan</li>\r\n<li>Pembayaran dalam rupiah mengikuti kurs yang berlaku di pasaran (kurs BCA) pada saat terjadi transaksi pembayaran.</li>\r\n</ul>', '2,3,4,1', '5,6', '19999999', '23999000', '1', '2017-10-27 02:09:51', '4', '2017-10-27 02:09:51', '4'), ('13', '1', '1', '11', 'Bangka Belitung', '3D 2N', '<p><strong>Hari 1 :&nbsp;</strong>Menuju Bangka Belitung <strong>(B,L,D)</strong></p>\r\n<p>Setiba di Pangkal Pinang Meet and Greet dengan Tour Guide - Menikmati <strong>Roti Khas Bangka (Tung Tau) -&nbsp;</strong>Berkunjung di Klenteng Tertua&nbsp;<strong>- Museum Timah Indonesia - Patung Besar Dewi Kwan Im -&nbsp;</strong>makan siang di pinggir Pantai - visit <strong>Pantai Pasir Padi - Agro Wisata Bangka Botanical Garden (BBG) -&nbsp;</strong>Makan malam restorant local</p>\r\n<p>&nbsp;</p>\r\n<p><strong>HARI 2 :&nbsp;</strong>Full day Seminar&nbsp;<strong>(B,L,D)</strong></p>\r\n<p>Setelah sarapan menuju Jembatan Batu Rusa - Pantai Tikus - Pantai Tanjung Pesona - Pemandian Suci Dewi Kwan Im - Pantai Parai - Lanjut makan malam</p>\r\n<p><strong>HARI 3 :&nbsp;</strong>Last Day&nbsp;<strong>(B,L)</strong></p>\r\n<p>Sarapan dan bersiap Check Out, dan menuju Oleh-oleh Khas Bangka baju Aloi lalu mampir ke warung kopi Tung Tau. lanjut untuk makan siang dan belanja Oleh-oleh. Langsung menuju ke bandara untuk kembali pulang.</p>', null, '<p><strong>BIAYA &amp; PEMBAYARAN :</strong></p>\r\n<ul>\r\n<li>Harga fleksibel, tergantung waktu keberangkatan, jumlah peserta dalam group jenis akomodasi yang diminta, dan tempat0tempat yang ingin dituju sesuai permintaan khusus bila ada.</li>\r\n<li>Booking Fee langsung dibayarkan pada saat pendaftaran (non refundable)</li>\r\n<li>deposit 50% minimal 1 hari setelah deal dan maksimal 2 bulan sebelum keberangkatan&nbsp;</li>\r\n<li>pelunasan maksimal 1 bulan sebelum keberangkatan</li>\r\n<li>tidak ada pengembalian tour/obyek yang tidak terpakai</li>\r\n<li>biaya pembatalan dalam waktu kurang dari 20hari sebelum keberangkatan dikenakan biaya 70%</li>\r\n<li>biaya pembatalan dalam waktu kurang dari 7 hari sebelum keberangkatan dikenakan biaya 100%</li>\r\n<li>harga dapat berubah sewaktu-waktu</li>\r\n</ul>', '', '', '1850000', '1850000', '1', '2017-10-27 02:47:06', '4', '2017-10-27 02:47:06', '4'), ('14', '1', '1', '13', 'Laskar Belitung', '3D 2N', '<p><strong>Hari 1 :&nbsp;</strong>Bangka Belitung <strong>(L)</strong></p>\r\n<p>Paara peserta berkumpul di Bandara H.A.S Hanandjoeddin / Depati Amir untuk memulai acara perjalanan \" Laskar Belitung\" di tanjung pandan, Belitung. Langsung menuju Tanjung tinggi (tempat syuting film laskar pelasngi) dan langsung ke tanjung pendem&nbsp; untuk menikmati sunsetlalu kembali ke penginapan&nbsp; untuk Free Time dan makan malam disekitar penginapan</p>\r\n<p>&nbsp;</p>\r\n<p><strong>Hari 2 :&nbsp;</strong>Hopping Island Belitung&nbsp;<strong>(B,L)</strong></p>\r\n<p>Bangun pagi dan langsung hunting Sunrise di sekitar penginapan dan segera makan pagi untuk bersiap mengelilingi pulau Belitung.</p>\r\n<p>setelah sarapan, Snorkeling dari Pulau Pasir - Pulau Babi - Pulau Batu Berlayar - Pulau Lengkuas - Tanjung Kelayang dimana terdapat Mercusuar untuk melihat keindahan Pulau Belitung dari ketinggian. Setelah itu makan siang mie khas belitung yaitu mie Atep dan menuju Manggar mengunjungi Laskar Pelangi dan Museum Kata Andre Hirata. berlanjut kepenginapan atau keliling kota manggar untuk kuliner makan malam.</p>\r\n<p>&nbsp;</p>\r\n<p><strong>Hari 3 :&nbsp;</strong>Explore Belitung&nbsp;<strong>(B) </strong>Sarapan lanjut packing untuk ke danau Kaolin (Bekas Tambang) atau menuju pusat Oleh-oleh juga makan siang di sekitar kota Belitung, Menuju tanjung Pandan untuk kembali ke jakarta.</p>\r\n<p>&nbsp;</p>\r\n<p>tiba di kota tujuan, terima kasih untuk keikutsertaan Anda bersama kami. sampai jumpa dalam perjalanan tour lain nya, S<strong>ee You And Have a Good Day<img src=\"../../plugins/tinymce/plugins/emoticons/img/smiley-wink.gif\" alt=\"wink\" /></strong></p>\r\n<p>&nbsp;</p>', null, '<p><strong>BIAYA &amp; PEMBAYARAN :</strong></p>\r\n<ul>\r\n<li>Harga fleksibel, tergantung waktu keberangkatan, jumlah peserta dalam group,jenis akomodasi yang diminta,dan tempat tempat yang ingin di tuju sesuai permintaan khusus bila ada.</li>\r\n<li>Booking Fee minimal Rp. 1.000.000,- Langaung dibayarkan pada saat pendaftaran (non refundable)</li>\r\n<li>Deposit 50% minimal minimal 1 hari setelah Deal dan maksimal 2 bulan sebelum keberangkatan</li>\r\n<li>Pelunasan maksimal 1 bulan sebelum keberangkatan&nbsp;</li>\r\n<li>Fasilitas yang disewakan di tempat menjadi tanggung jawab peserta masing-masing</li>\r\n<li>Tidak ada pengembalian tour/objek yang tidak terpakai</li>\r\n<li>Biaya pembatalan dalam waktu kurang dari 20 hari sebelum keberangkatan dikenakan biaya 70%</li>\r\n<li>Biaya pembatalan dalam waktu kurang dari 7 hari sebelum keberangkatan deikenakan biaya 100%</li>\r\n<li>harga dapat berubah sewaktu-waktu.</li>\r\n</ul>', '', '', '1200000', '1200000', '1', '2017-10-27 03:31:52', '4', '2017-10-27 03:31:52', '4'), ('15', '1', '1', '14', 'Pesona Laskar  Belitung 3D', '3D 2N', '<h3><strong>Hari 1 : Jakarta &ndash; Tanjung Pandan -&gt;&nbsp;L</strong></h3>\r\n<p>Para peserta berkumpul di Bandara Soekarno-Hatta untuk memulai acara perjalanan &ldquo;Laskar Belitung&rdquo; di Tanjung Pandan,<br />Belitung. Tiba di Bandara, langsung menuju Tanjung Tinggi (tempat syuting film Laskar Pelangi) dan langsung ke Tanjung Pendem<br />untuk menikmati Sunset, lalu kembali ke Penginapan untuk Free Time dan makan malam di sekitar penginapan.<br /><br /></p>\r\n<h3><strong>Hari 2 : Hopping Island Belitung -&gt; B, L</strong></h3>\r\n<p>Bangun pagi dan langsung hunting Sunrise di sekitar penginapan, dan segera makan pagi untuk bersiap mengelilingi pulau<br />Belitung. Setelah sarapan, Snorkeling dari Pulau Pasir &ndash; Pulau Babi &ndash; Pulau Batu Berlayar &ndash; Pulau Lengkuas &ndash; Tanjung Kelayang<br />dimana terdapat Mercusuar untuk melihat keindahan Pulau Belitung dari ketinggian.</p>\r\n<p>Setelah itu makan siang mie khas Belitung yaitu Mie Atep dan menuju Manggar mengunjungi SD Laskar Pelangi dan Museum Kata Andre Hirata. Berlanjut ke penginapan atau keliling kota Manggar untuk kuliner makan malam.</p>\r\n<h3><br /><strong>Hari 3 : Explore Belitung -&gt; B</strong></h3>\r\n<p>Sarapan, lanjut Packing untuk ke Danau Kaolin (bekas tambang) atau menuju Pusat Oleh-Oleh juga makan siang di sekitar<br />Kota Belitung. Menuju Tanjung Pandan untuk kembali ke Jakarta.<br />Tiba di Kota tujuan. Terima kasih untuk keikutsertaan Anda bersama kami. Sampai jumpa dalam perjalanan tour lainnya. See<br />You and have a good day.</p>', null, '<h3><strong>&nbsp;BIAYA &amp; PEMBAYARAN :</strong></h3>\r\n<ul>\r\n<li>&nbsp;Harga fleksibel, tergantung waktu keberangkatan, jumlah peserta dalam grup, jenis akomodasi yang<br />&nbsp;diminta, dan tempat-tempat yang ingin dituju sesuai permintaan khusus bila ada.</li>\r\n<li>&nbsp;Booking Fee minimal Rp 1.000.000,- langsung dibayarkan pada saat pendaftaran (non refundable)</li>\r\n<li>&nbsp;Deposit 50% minimal 1 hari setelah deal dan maksimal 2 bulan sebelum keberangkatan</li>\r\n<li>&nbsp;Pelunasan maksimal 1 bulan sebelum keberangkatan</li>\r\n<li>&nbsp;Fasilitas yang disewakan di tempat menjadi tanggung jawab peserta masing-masing</li>\r\n<li>&nbsp;Tidak ada pengembalian untuk tour/obyek yang tidak terpakai</li>\r\n<li>&nbsp;Biaya pembatalan dlm waktu kurang dari 20 hari sebelum keberangkatan dikenakan biaya 70%</li>\r\n<li>&nbsp;Biaya pembatalan dlm waktu kurang dari 7 hari sebelum keberangkatan dikenakan biaya 100%</li>\r\n<li>&nbsp;Harga dapat berubah sewaktu-waktu</li>\r\n</ul>', '', '', '2200000', '2200000', '1', '2017-10-27 03:52:15', '4', '2017-10-27 03:52:15', '4'), ('16', '1', '1', '10', 'Wakatobi – Bali – Labuan Bajo 3D', '11D 10N', '<h3><strong>Hari 01 : Jakarta - Wakatobi -&gt; L, D</strong></h3>\r\n<p><strong><br /></strong>Sesampainya di Bandara Matahora, langsung briefing dengan Local Guide (Java Tour Team) kemudian langsung<br />menuju Patuno Resort, check in dan makan siang di lokal restauran dan langsung snorkeling, sunset di pantai waha<br />sambil minum kelapa muda makan malam di resort - makan malam di resort.</p>\r\n<h3><strong>Hari 02 : Pulau Hoga -&gt; B, L, D</strong></h3>\r\n<p>Setelah sarapan kita akan mengunjungi menuju ke Hoga perjalanan ditempuh selama 2 jam menggunakan kapal<br />regular &ndash;Makan siang di Guest House - Cultural trip - Check in di Hoga Dive resort resort - Makan malam di resort &ndash;<br />free program.</p>\r\n<h3><strong>Hari 03 : Pulau Hoga -&gt; B, L, D</strong></h3>\r\n<p>Setelah sarapan, mulai kegiatan untuk full snorkeling + 1 kali diving - makan siang (lunch box) - Sunset di tepi pantai<br />Hoga - Makan malam di resort.&nbsp;Setelah rombongan sarapan pagi di kapal dan kembali ke Pulau Wangi - Wangi jam 5 subuh menggunakan kapal laut, Tour menuju ke Kontamale dan Bukit Toliamba kemudian menuju bandara Sultan Hasanuddin &ndash; bandara Ngurah<br />Rai</p>\r\n<h3><strong>Hari 04 : Makassar - Bali -&gt; B</strong></h3>\r\n<p>Tiba di bandara Ngurah Rai sore hari langsung drop Hotel &amp; sunset time di Jimbaran &ndash; free program</p>\r\n<h3><strong>Hari 05 : Bali (Full day) -&gt; B, L, D</strong></h3>\r\n<p>Setelah sarapan &ndash; menuju Beratan Lake Bedugul &ndash; makan siang &ndash; Taman Ayun Temple &ndash; Sovenir Shop &ndash; Dinner &ndash;<br />free program</p>\r\n<h3><strong>Hari 06 : Tanjung Benoa -&gt; B</strong></h3>\r\n<p>Seperti biasa, seusai sarapan di Hotel bergegas menuju Tanjung Benoa untuk water sport &ndash; kemudian menuju Pantai<br />Pandawa &ndash; makan siang &ndash; GWK park &ndash; Uluwatu Temple &ndash; Kecak Fire Dance &ndash; back to hotel</p>\r\n<p><strong>Hari 07 : Kintamani -&gt; B</strong></p>\r\n<p>Setelah sarapan, menuju Bali Bird Zoo &ndash; Penglipur Village untuk photo stop &ndash; makan siang di Kintamani &ndash; Tamani &amp;<br />Batur Volcano &ndash; Coffee Plantation &ndash; Dinner &ndash; Free program</p>\r\n<h3><strong>Hari 08 : Bali - Labuan Bajo -&gt; B, L, D</strong></h3>\r\n<p>Setelah sarapan &ndash; Check Out dan menuju ke Labuan Bajo &ndash; menuju pelabuhan &ndash; makan siang di kapal &ndash; Pulau<br />Kanawa &ndash; Manta Point &ndash; Gili Laba Barat untuk Sunset Golden Point &ndash; LOB (Live On Boat)</p>\r\n<h3><strong>Hari 09 : Pink Beach -&gt; B, L, D</strong></h3>\r\n<p>Setelah sarapan, trekking di Gili Laba Barat keseluruhan view Pulau Flores - Taka Makassar untuk snorkeling di<br />Manta Point &ndash; pulau 9 (gosongan berbentuk angka 9) - lanjut Pink Beach untuk snorkeling - trekking ke puncak<br />untuk melihat keindahan pink beach dari atas - Pulau Kalong &ndash; LOB &ndash; free program</p>\r\n<h3><strong>Hari 10 : Pulau Wangi-Wangi -&gt; B,L, D</strong></h3>\r\n<p>Seusai sarapan - pagi-pagi menuju pulau Padar, salah satu best view di pulau Komodo - pulau Rinca melihat lebih<br />dekat kehidupan Komodo, treking ke bukit untuk melihat keindahan Loh Buay - mendarat kembali di Labuan Bajo<br />sebelumnya singgah di Pulau Kelor. Disini kita bisa snorkeling dan beaching - Tiba di hotel Acara bebas</p>', null, '<h2><strong>BIAYA &amp; PEMBAYARAN :</strong></h2>\r\n<ul>\r\n<li>Harga fleksibel, tergantung waktu keberangkatan, jumlah peserta dalam grup, jenis akomodasi yang<br />diminta, dan tempat-tempat yang ingin dituju sesuai permintaan khusus bila ada.</li>\r\n<li>Biaya International Airport tax / fuel charge dapat berubah sewaktu-waktu dengan / tanpa<br />pemberitahuan terlebih dahulu, sesuai dengan peraturan pihak penerbangan terkait</li>\r\n<li>Booking Fee 50 % dari harga paket (non refundable)</li>\r\n<li>Pelunasan maksimal 3 minggu sebelum keberangkatan</li>\r\n<li>Tidak ada pengembalian utk tour/object yg tdk terpakai</li>\r\n<li>Biaya pembatalan dlm waktu kurang dari 60 hari sebelum keberangkatan dikenakan biaya 70%</li>\r\n<li>Biaya pembatalan dlm waktu kurang dari 30 hari sebelum keberangkatan dikenakan biaya 100%</li>\r\n<li>Harga dapat berubah sewaktu-waktu</li>\r\n</ul>', '', '', '20000000', '20000000', '1', '2017-10-27 04:19:03', '4', '2017-10-27 04:19:03', '4'), ('17', '1', '1', '10', 'ESCAPE TO BALI 3D', '3D 2N', '<h3><strong>Hari 1 : Menuju Bali -&gt;&nbsp;L, D</strong></h3>\r\n<p>Transfer in &ndash; Full Day Tour<br />Setiba di Bali &ndash; Meet and Greet dengan Tour Guide &ndash; Makan siang di Restoran Lokal &ndash;visit Pantai Pandawa &ndash; Uluwatu &ndash;<br />Dinner @Jimbaran Pinggiran Pantai</p>\r\n<h3><strong>Hari 2 : Explore Bali -&gt;&nbsp;B, L, D</strong></h3>\r\n<p>Full Day Tour<br />Setelah Sarapan, langsung menuju wisata Bedugul, dan menikmati makan siang disana. Lalu mampir ke Alas Kedaton yang<br />terdapat Hutan Kera di Tanah Lot. Lanjut untuk makan malam di restoran sekitar Tanah Lot.<br />Kembali ke hotel, free time.</p>\r\n<h3><strong>Hari 3 : Last day -&gt;&nbsp;B, L</strong></h3>\r\n<p>Transfer Out<br />Sarapan dan bersiap Check Out, dan menuju ke Pulau Penyu. Lanjut untuk makan siang dan belanja Oleh-Oleh.<br />Langsung menuju ke Bandara untuk kembali pulang.</p>', null, '<h3><strong>BIAYA &amp; PEMBAYARAN :</strong></h3>\r\n<ul>\r\n<li>Harga fleksibel, tergantung waktu keberangkatan, jumlah peserta dalam grup, jenis akomodasi yang<br />diminta, dan tempat-tempat yang ingin dituju sesuai permintaan khusus bila ada.</li>\r\n<li>Booking Fee langsung dibayarkan pada saat pendaftaran (non refundable)</li>\r\n<li>Deposit 50% minimal 1 hari setelah deal dan maksimal 2 bulan sebelum keberangkatan</li>\r\n<li>Pelunasan maksimal 1 bulan sebelum keberangkatan</li>\r\n<li>Tidak ada pengembalian untuk tour/obyek yg tidak terpakai</li>\r\n<li>Biaya pembatalan dlm waktu kurang dari 20 hari sebelum keberangkatan dikenakan biaya 70%</li>\r\n<li>Biaya pembatalan dlm waktu kurang dari 7 hari sebelum keberangkatan dikenakan biaya 100%</li>\r\n<li>&nbsp;Harga dapat berubah sewaktu-waktu</li>\r\n</ul>', '', '', '1500000', '1500000', '1', '2017-10-27 05:49:53', '4', '2017-10-27 05:49:53', '4');
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
  `order` int(1) DEFAULT NULL,
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
INSERT INTO `types` VALUES ('1', 'Hot Offer', '1', '1', '1', '2017-10-15 12:55:55', '1', '2017-10-15 12:55:58', '1'), ('2', 'Private Trip', '1', '1', '3', '2017-10-15 12:56:38', '1', '2017-10-15 12:56:42', '1'), ('3', 'Open Trip', '1', '1', '2', '2017-10-15 12:57:20', '1', '2017-10-15 12:57:24', '1'), ('4', 'Custom Trip', '0', '1', '4', '2017-10-15 12:57:40', '1', '2017-10-15 12:57:45', '1');
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
INSERT INTO `users` VALUES ('1', 'Barindra', 'barindra1988@gmail.com', '$2y$10$TXTSsJhhNW1U61.15Y59RejS5J1utOSawNvmteDS8S3f/4HpMb26S', '1988-07-19', 'Bogor', 'Bogor Baru B VII No. 7<br>', 'BOGOR', null, null, 'j8HXpHwAFNxH1v74iZ3Q8HOt8QHZtdenHcpF8y87u3XaxR2FeD2HVw1fo3Sq', '1', null, '', null, null, null, null, null, '1', null, '2017-08-20 16:11:28', null, '2017-08-22 16:33:00'), ('4', 'Barind testing', 'testing.website1988@gmail.com', '$2y$10$fc7egB3DoV7NNxMYrKJ5c.I2R/wUkoLwQxBLPFR3y8gn.EUC6Xyhy', null, null, null, null, null, 'dGVzdGluZy53ZWJzaXRlMTk4OEBnbWFpbC5jb20=', 'Ska2PiIObGVghOclF6O96sQxiNILHvK8jE6NMw2maT9Uj9qJ7H2LPIDnKj7O', '1', null, null, '0', '2017-10-04 10:43:31', '0', '2017-10-04 10:43:31', '1', '1', null, '2017-10-04 10:43:31', null, '2017-10-15 16:45:07'), ('5', 'Barindra Cabang', 'testing.website86@gmail.com', '$2y$10$KFplhtfoXQHp/nFcljWA9e.YZSZp5SobVlW52vspTLfeDPBk365jm', null, null, null, null, null, 'dGVzdGluZy53ZWJzaXRlODZAZ21haWwuY29t', '3DeA229s3keqZF5DyVLiXYMi7Zh65tEZZYO2hYA9XERXyYG0H7UxHziUkjxO', '1', null, null, null, null, null, null, '1', '2', null, '2017-10-15 22:58:01', null, '2017-10-15 23:00:23'), ('7', 'Barindra MD', 'bar1ndra@yahoo.com', '$2y$10$WNLGhm3rEExMECjvXo5FVexurxi/YlOvyNdz2fUYGFA1MGCkxXqTi', null, null, null, null, null, 'YmFyMW5kcmFAeWFob28uY29t', 'bHtOlTLq2DOlpgT0YVNtweIbUqvqDwCZsRK2WWfeWM6PPE5UPlQi20rVXEHo', '1', null, null, null, null, null, null, '5', '3', null, '2017-10-23 07:30:28', null, '2017-10-23 07:30:46'), ('8', 'Barindra Distri', 'developer.itmax@gmail.com', '$2y$10$G/I8T1FNyHce4XwnE8XnmOHJ6zXU2gkvLG9z5l3i4aVh5k19QloGa', null, null, null, null, null, 'ZGV2ZWxvcGVyLml0bWF4QGdtYWlsLmNvbQ==', 'hlXiB4IkZ9x2E84RxqKYXNnebEAjzOQ6tF1HzMkID0nhCUHNyYZuQRvcAIbN', '1', null, null, null, null, null, null, '7', '4', null, '2017-10-23 08:22:51', null, '2017-10-23 08:23:53'), ('9', 'Barind Agen', 'demo.lives88@gmail.com', '$2y$10$BRovp/FsFJkzuqt6XMkuTuur9oQcaHGYg.97J21gzcUhkmidB9Bai', null, null, null, null, null, 'ZGVtby5saXZlczg4QGdtYWlsLmNvbQ==', null, '1', null, null, null, null, null, null, '8', '5', null, '2017-10-23 08:23:39', null, '2017-10-23 08:24:04');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
