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

 Date: 10/23/2017 11:33:53 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `levels`
-- ----------------------------
BEGIN;
INSERT INTO `levels` VALUES ('1', 'Java Pusat', '1', '0', '2017-10-19 06:39:12', '1', '2017-10-19 06:39:12', '1'), ('2', 'Cabang', '1', '1', '2017-10-19 07:27:44', '1', '2017-10-19 07:33:36', '1'), ('3', 'Master Distribution', '1', '2', '2017-10-19 07:33:58', '1', '2017-10-19 07:36:57', '1'), ('4', 'Distribution', '1', '3', '2017-10-21 14:12:34', '1', '2017-10-22 14:55:51', '1');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
