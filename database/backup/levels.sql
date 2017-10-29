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

 Date: 10/19/2017 14:41:59 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `levels`
-- ----------------------------
DROP TABLE IF EXISTS `levels`;
CREATE TABLE `levels` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `komisi_1` float(4,0) DEFAULT NULL,
  `komisi_2` float(4,0) DEFAULT NULL,
  `status` int(1) DEFAULT '2' COMMENT 'Note :\n- 1 = Pusat [tidak dapat dihapus]\n- 2 = Normal',
  `parent_id` int(6) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `created_by` int(6) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `levels`
-- ----------------------------
BEGIN;
INSERT INTO `levels` VALUES ('1', 'Java Pusat', '10', '10', '1', '0', '2017-10-19 06:39:12', '1', '2017-10-19 06:39:12', '1'), ('2', 'Cabang', '20', '20', '1', '1', '2017-10-19 07:27:44', '1', '2017-10-19 07:33:36', '1'), ('3', 'Master Distribution', '30', '30', '1', '2', '2017-10-19 07:33:58', '1', '2017-10-19 07:36:57', '1');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
