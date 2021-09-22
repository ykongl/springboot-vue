/*
 Navicat Premium Data Transfer

 Source Server         : 123
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : localhost:3306
 Source Schema         : sport

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 22/09/2021 17:34:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for easyuser
-- ----------------------------
DROP TABLE IF EXISTS `easyuser`;
CREATE TABLE `easyuser`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用戶名稱',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密碼',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '郵箱地址',
  `roleId` int NULL DEFAULT NULL COMMENT '角色',
  `state` tinyint NULL DEFAULT 0 COMMENT '狀態',
  `isVip` tinyint(1) NULL DEFAULT 0 COMMENT '是否是會員',
  `delete_flag` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '刪除',
  `account` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '賬號',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手機號',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of easyuser
-- ----------------------------
INSERT INTO `easyuser` VALUES (1, 'admin', '123456', '123456@qq.com', 1, 1, 0, '0', '1001', '17354946037');
INSERT INTO `easyuser` VALUES (2, 'naughty', '888888', '456@qq.com', 2, 1, 0, '0', '1002', '18851269705');
INSERT INTO `easyuser` VALUES (3, 'flysky01', '987654', 'qwe@qq.com', 3, 1, 1, '0', '1003', '15551263408');
INSERT INTO `easyuser` VALUES (4, 'anglybirds', '321654', 'aaaa@163.com', 3, 0, 1, '0', '1004', '15951042119');
INSERT INTO `easyuser` VALUES (5, 'admin003', 'q123456', 'c@qq.com', 4, 1, 0, '0', '1005', '12345678911');
INSERT INTO `easyuser` VALUES (6, 'admin005', '123456', 'cxz@qq.com', 4, 0, 0, '0', '1006', '17946852301');
INSERT INTO `easyuser` VALUES (7, 'admin007', '123456', 'rty@qq.com', 4, 0, 0, '0', '1007', '18845691375');
INSERT INTO `easyuser` VALUES (8, 'ykongl', '123456', 'Mjy@163.com', 3, 0, 1, '0', '1008', '15951055308');
INSERT INTO `easyuser` VALUES (9, 'xuyin', '123456', 'xuyin@qq.com', 3, 0, 1, '0', '1009', '15951038510');
INSERT INTO `easyuser` VALUES (10, 'wenzi', '123456', 'wenzi@qq.com', 3, 0, 0, '0', '1010', '18851269632');
INSERT INTO `easyuser` VALUES (11, 'asd', '123456', 'asd@163.com', 3, 0, 0, '0', '1011', '11012011691');

-- ----------------------------
-- Table structure for mainmenu
-- ----------------------------
DROP TABLE IF EXISTS `mainmenu`;
CREATE TABLE `mainmenu`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 401 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mainmenu
-- ----------------------------
INSERT INTO `mainmenu` VALUES (100, '用戶管理', '/admin');
INSERT INTO `mainmenu` VALUES (200, '运动平台', '/use');
INSERT INTO `mainmenu` VALUES (300, '運動商品', '/mall');
INSERT INTO `mainmenu` VALUES (400, '教練員', '/teacher');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主鍵Id',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色',
  `roleId` int NULL DEFAULT NULL COMMENT '関連easyuser表',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, '超級管理員', 1);
INSERT INTO `role` VALUES (2, '管理員', 2);
INSERT INTO `role` VALUES (3, 'VIP會員', 3);
INSERT INTO `role` VALUES (4, '普通用戶', 4);

-- ----------------------------
-- Table structure for submenu
-- ----------------------------
DROP TABLE IF EXISTS `submenu`;
CREATE TABLE `submenu`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mid` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mid`(`mid`) USING BTREE,
  CONSTRAINT `submenu_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `mainmenu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 303 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of submenu
-- ----------------------------
INSERT INTO `submenu` VALUES (101, '用户列表', '/user', 100);
INSERT INTO `submenu` VALUES (102, '修改权限', '/rights', 100);
INSERT INTO `submenu` VALUES (103, '會員列表', '/userVip', 100);
INSERT INTO `submenu` VALUES (201, '运动科普', '/Introduction', 200);
INSERT INTO `submenu` VALUES (202, '卡路里', '/calories', 200);
INSERT INTO `submenu` VALUES (203, '运动類別', '/sport', 200);
INSERT INTO `submenu` VALUES (301, '商品模块', '/goods', 300);
INSERT INTO `submenu` VALUES (302, '营养配餐', '/food', 300);

SET FOREIGN_KEY_CHECKS = 1;
