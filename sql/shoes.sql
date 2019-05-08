/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50722
Source Host           : localhost:3306
Source Database       : shoes

Target Server Type    : MYSQL
Target Server Version : 50722
File Encoding         : 65001

Date: 2019-05-08 20:15:40
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `addr_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键，自动增长',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户id,不用外键，通过代码来约束',
  `dft` varchar(1) NOT NULL DEFAULT '0' COMMENT '默认地址，‘1’是，‘0’否',
  `name` varchar(30) NOT NULL COMMENT '收货人',
  `address` varchar(50) NOT NULL COMMENT '收货地址',
  `tel` varchar(20) NOT NULL COMMENT '联系电话',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`addr_id`),
  UNIQUE KEY `user_addr_uk` (`user_id`,`addr_id`) USING BTREE,
  KEY `create_time_index` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for brand
-- ----------------------------
DROP TABLE IF EXISTS `brand`;
CREATE TABLE `brand` (
  `brandId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`brandId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for orderdetail
-- ----------------------------
DROP TABLE IF EXISTS `orderdetail`;
CREATE TABLE `orderdetail` (
  `order_detail_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单明细标识',
  `user_id` int(11) NOT NULL,
  `shoes_id` int(11) NOT NULL COMMENT '鞋子标识',
  `price` decimal(7,2) NOT NULL COMMENT '单价',
  `amount` int(11) NOT NULL COMMENT '数量',
  `shoes_size` decimal(7,2) NOT NULL COMMENT '鞋码',
  `name` varchar(30) NOT NULL COMMENT '收货人姓名',
  `tel` varchar(20) NOT NULL COMMENT '联系电话',
  `addr` varchar(255) NOT NULL COMMENT '收货地址',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '订单明细创建时间',
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '标志状态',
  `payMethod` int(11) NOT NULL DEFAULT '0' COMMENT '支付方式',
  `logistics_id` varchar(50) DEFAULT NULL COMMENT '物流编号',
  PRIMARY KEY (`order_detail_id`),
  KEY `create_time_index` (`create_time`),
  KEY `u_s_od` (`order_detail_id`,`user_id`,`shoes_id`),
  KEY `u_od_fk` (`shoes_id`),
  KEY `s_od_fk` (`user_id`),
  CONSTRAINT `s_od_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `u_od_fk` FOREIGN KEY (`shoes_id`) REFERENCES `shoes` (`shoes_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shoes
-- ----------------------------
DROP TABLE IF EXISTS `shoes`;
CREATE TABLE `shoes` (
  `shoes_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '标识',
  `user_id` int(11) NOT NULL COMMENT '用户标识  外键',
  `brand_id` int(11) NOT NULL DEFAULT '0',
  `img_uuid` varchar(32) NOT NULL COMMENT '图片uuid名',
  `img_suffix` varchar(10) NOT NULL COMMENT '图片后缀',
  `online_time` varchar(50) NOT NULL COMMENT '上架时间',
  `in_price` decimal(7,2) DEFAULT NULL COMMENT '进价',
  `out_price` decimal(7,2) NOT NULL COMMENT '售价',
  `ratio` decimal(5,2) DEFAULT '100.00' COMMENT '折扣',
  `stock_out` varchar(1) DEFAULT '1' COMMENT '是否下架，‘1’是，‘0’否',
  `name` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`shoes_id`),
  KEY `shoes_user_fk` (`user_id`),
  KEY `online_time_index` (`online_time`) USING BTREE,
  KEY `shoes_brand_index` (`brand_id`) USING BTREE,
  FULLTEXT KEY `name_index` (`name`),
  CONSTRAINT `shoes_user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shoesitem
-- ----------------------------
DROP TABLE IF EXISTS `shoesitem`;
CREATE TABLE `shoesitem` (
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `shoes_id` int(11) NOT NULL COMMENT '鞋子id',
  `shoes_size_id` int(11) NOT NULL COMMENT '鞋码',
  `amount` int(255) NOT NULL DEFAULT '1' COMMENT '该鞋子的数量',
  `flag` int(11) NOT NULL DEFAULT '0' COMMENT '标志位',
  PRIMARY KEY (`user_id`,`shoes_id`,`shoes_size_id`),
  UNIQUE KEY `u_s_ss_uk` (`user_id`,`shoes_id`,`shoes_size_id`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shoessize
-- ----------------------------
DROP TABLE IF EXISTS `shoessize`;
CREATE TABLE `shoessize` (
  `shoes_size_id` int(11) NOT NULL AUTO_INCREMENT,
  `shoes_id` int(11) NOT NULL COMMENT '外键，对应鞋子',
  `amount` int(11) NOT NULL DEFAULT '0' COMMENT '该鞋子每个尺码对应的库存数量',
  `value` decimal(3,1) NOT NULL COMMENT '尺码',
  `description` varchar(255) DEFAULT NULL COMMENT '相关描述',
  PRIMARY KEY (`shoes_size_id`),
  UNIQUE KEY `s_ss_uk` (`shoes_id`,`shoes_size_id`) USING BTREE,
  KEY `shoes_id_index` (`shoes_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=521 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键，自动增长',
  `username` varchar(20) NOT NULL COMMENT '用户名，唯一',
  `password` varchar(32) NOT NULL COMMENT '密码,MD5加密',
  `eMail` varchar(50) NOT NULL COMMENT '电子邮箱',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `flag` int(11) DEFAULT '0' COMMENT '标志位,标志当前用户的转态',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username_uk` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
