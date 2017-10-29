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

 Date: 10/18/2017 16:47:28 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

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
INSERT INTO `permission_role` VALUES ('1', '1'), ('2', '1'), ('3', '1'), ('4', '1'), ('5', '1'), ('6', '1'), ('7', '1'), ('8', '1'), ('9', '1'), ('10', '1'), ('11', '1'), ('12', '1'), ('13', '1'), ('14', '1'), ('15', '1'), ('16', '1'), ('17', '1'), ('18', '1'), ('19', '1'), ('20', '1'), ('21', '1'), ('39', '1'), ('40', '1'), ('41', '1'), ('42', '1'), ('43', '1'), ('44', '1'), ('45', '1'), ('46', '1'), ('47', '1'), ('48', '1'), ('49', '1'), ('50', '1'), ('51', '1'), ('52', '1'), ('53', '1'), ('54', '1'), ('55', '1'), ('56', '1'), ('57', '1'), ('58', '1'), ('59', '1'), ('60', '1'), ('61', '1'), ('62', '1'), ('63', '1'), ('64', '1'), ('65', '1'), ('66', '1'), ('67', '1'), ('68', '1'), ('9', '2'), ('17', '2'), ('39', '2'), ('40', '2'), ('41', '2'), ('42', '2'), ('43', '2'), ('44', '2'), ('45', '2'), ('46', '2'), ('47', '2'), ('48', '2'), ('49', '2'), ('50', '2'), ('51', '2'), ('52', '2'), ('53', '2'), ('54', '2'), ('56', '2'), ('57', '2'), ('58', '2'), ('59', '2'), ('61', '2'), ('62', '2'), ('63', '2'), ('64', '2'), ('65', '2'), ('66', '2'), ('67', '2'), ('68', '2'), ('46', '4'), ('51', '4');
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
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
--  Records of `permissions`
-- ----------------------------
BEGIN;
INSERT INTO `permissions` VALUES ('1', 'permission-add', 'Permission Add', 'Access to add Permission', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('2', 'permission-edit', 'Permission Edit', 'access to edit Permission', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('3', 'permission-delete', 'Permission Delete', 'Access to delete Permission', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('4', 'permission-view', 'Permission View', 'Access to view Permission form', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('5', 'role-view', 'Role View', 'Access to view Role Page', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('6', 'role-add', 'Role Add', 'Access to add Role', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('7', 'role-edit', 'Role Edit', 'Access to edit Role', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('8', 'role-delete', 'Role Delete', 'Access to delete Role', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('9', 'menu-view', 'Menu View', 'Access to View Page Menu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('10', 'menu-add', 'Menu Add', 'Access to form add menu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('11', 'menu-edit', 'Menu Edit', 'Access to Edit Menu Form', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('12', 'menu-delete', 'Menu Delete', 'Access to Delete Menu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('13', 'submenu-view', 'Submenu View', 'Access to View Submenu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('14', 'submenu-add', 'Submenu Add', 'Access to Add Form Submenu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('15', 'submenu-edit', 'Submenu Edit', 'Access to Edit Submenu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('16', 'submenu-delete', 'Submenu Delete', 'Access to Delete Submenu', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0'), ('17', 'user-management-view', 'User Management Menu', 'User Management Menu', '0000-00-00 00:00:00', '2017-10-15 03:43:22', '0'), ('18', 'thirdmenu-view', 'Thirdmenu View', 'Access to view Thirdmenu', '2017-08-21 14:17:29', '2017-08-21 14:17:55', '0'), ('19', 'thirdmenu-add', 'Thirdmenu Add', 'Access to Add New Thirdmenu', '2017-08-21 14:18:25', '2017-08-22 04:08:32', '18'), ('20', 'thirdmenu-edit', 'Thirdmenu Edit', 'Access to Edit Thirdmenu', '2017-08-21 14:18:56', '2017-08-22 04:08:51', '18'), ('21', 'thirdmenu-delete', 'Thirdmenu Delete', 'Access to Delete Thirdmenu', '2017-08-21 14:19:32', '2017-08-22 04:09:14', '18'), ('39', 'setting-view', 'Setting Menu', 'Setting Menu', '2017-10-14 16:38:14', '2017-10-14 16:38:14', '0'), ('40', 'setting-edit', 'Edit Setting System', 'Edit Setting System', '2017-10-15 03:19:01', '2017-10-15 03:19:01', '39'), ('41', 'user-management-edit', 'User Management Edit', 'User Management Edit', '2017-10-15 03:36:08', '2017-10-15 03:43:40', '17'), ('42', 'user-management-add', 'User Management Add New', 'User Management Add New', '2017-10-15 03:36:31', '2017-10-15 03:43:59', '17'), ('43', 'user-management-delete', 'User Management Delete', 'User Management Delete', '2017-10-15 03:38:28', '2017-10-15 03:44:21', '17'), ('44', 'user-management-inactive', 'User Management Inactive', 'User Management Inactive', '2017-10-15 04:04:47', '2017-10-15 04:04:47', '17'), ('45', 'master-menu', 'Master Menu', 'Master Menu', '2017-10-15 05:51:36', '2017-10-15 05:51:36', '0'), ('46', 'layanan-menu', 'Layanan Menu', 'Layanan Menu', '2017-10-15 05:59:31', '2017-10-15 05:59:31', '0'), ('47', 'tour-admin-view', 'Admin Tour Menu', 'Admin Tour Menu', '2017-10-15 06:37:45', '2017-10-15 06:37:45', '45'), ('48', 'tour-admin-add', 'Admin Tour Add New', 'Admin Tour Add New', '2017-10-15 06:38:06', '2017-10-15 06:38:06', '47'), ('49', 'tour-admin-edit', 'Admin Tour Edit', 'Admin Tour Edit', '2017-10-15 06:39:13', '2017-10-15 06:39:13', '47'), ('50', 'tour-admin-delete', 'Admin Tour Delete', 'Admin Tour Delete', '2017-10-15 06:39:48', '2017-10-15 06:39:48', '47'), ('51', 'tour-menu', 'Tour Menu', 'Tour Menu', '2017-10-15 12:43:08', '2017-10-15 12:43:08', '46'), ('52', 'region-admin-view', 'Region Menu', 'Region Menu', '2017-10-17 07:12:09', '2017-10-17 07:12:09', '45'), ('53', 'region-admin-add', 'Region Add New', 'Region Add New', '2017-10-17 07:13:16', '2017-10-17 07:13:16', '52'), ('54', 'region-admin-edit', 'Region Edit', 'Region Edit', '2017-10-17 07:13:48', '2017-10-17 07:13:48', '52'), ('55', 'region-admin-delete', 'Region Delete', 'Region Delete', '2017-10-17 07:14:09', '2017-10-17 07:14:09', '52'), ('56', 'region-admin-inactive', 'Region Inactive', 'Region Inactive', '2017-10-17 07:14:31', '2017-10-17 07:14:31', '52'), ('57', 'country-admin-view', 'Country Menu', 'Country Menu', '2017-10-17 10:14:40', '2017-10-17 14:29:12', '45'), ('58', 'country-admin-add', 'Country Add New', 'Country Add New', '2017-10-17 10:15:23', '2017-10-17 10:15:23', '57'), ('59', 'country-admin-edit', 'Country Edit', 'Country Edit', '2017-10-17 10:15:43', '2017-10-17 10:15:43', '57'), ('60', 'country-admin-delete', 'Country Delete', 'Country Delete', '2017-10-17 10:16:22', '2017-10-17 10:16:22', '57'), ('61', 'country-admin-inactive', 'Country Inactive', 'Country Inactive', '2017-10-17 10:16:43', '2017-10-17 10:16:43', '57'), ('62', 'country-admin-activate', 'Country Activate', 'Country Diaktifkan', '2017-10-17 14:27:43', '2017-10-17 14:27:43', '57'), ('63', 'destination-admin-view', 'Destination Menu', 'Destination Menu', '2017-10-17 19:31:57', '2017-10-17 19:31:57', '45'), ('64', 'destination-admin-add', 'Destination Add New', 'Destination Add New', '2017-10-17 19:32:25', '2017-10-17 19:32:25', '63'), ('65', 'destination-admin-edit', 'Destination Edit', 'Destination Edit', '2017-10-17 19:32:47', '2017-10-17 19:32:47', '63'), ('66', 'destination-admin-delete', 'Destination Delete', 'Destination Delete', '2017-10-17 19:33:13', '2017-10-17 19:33:13', '63'), ('67', 'destination-admin-inactive', 'Destination Inactive', 'Destination Inactive', '2017-10-17 19:33:45', '2017-10-17 19:33:45', '63'), ('68', 'destination-admin-activate', 'Destination Activate', 'Destination Activate', '2017-10-17 19:34:06', '2017-10-17 19:34:06', '63');
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

SET FOREIGN_KEY_CHECKS = 1;
