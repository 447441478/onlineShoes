/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50722
Source Host           : localhost:3306
Source Database       : shoes

Target Server Type    : MYSQL
Target Server Version : 50722
File Encoding         : 65001

Date: 2019-05-08 20:16:22
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
-- Records of address
-- ----------------------------

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
-- Records of brand
-- ----------------------------
INSERT INTO `brand` VALUES ('0', '首页', null);
INSERT INTO `brand` VALUES ('1', 'Nike', null);
INSERT INTO `brand` VALUES ('2', 'Adidas', null);
INSERT INTO `brand` VALUES ('3', 'NewBlance', null);
INSERT INTO `brand` VALUES ('4', 'Vans', null);

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
-- Records of orderdetail
-- ----------------------------
INSERT INTO `orderdetail` VALUES ('1', '1', '38', '108.00', '1', '43.00', '小鲸鱼', '17711111111', '湖南省益阳市赫山区湖南城市学院', '2019-04-13 19:38:00', '0', '0', null);
INSERT INTO `orderdetail` VALUES ('2', '1', '38', '108.00', '2', '44.00', '小鲸鱼', '17711111111', '湖南省益阳市赫山区湖南城市学院', '2019-04-13 19:38:00', '1', '0', '123123');
INSERT INTO `orderdetail` VALUES ('3', '1', '38', '108.00', '4', '44.00', '白', '13111111111', '111', '2019-04-14 15:58:23', '5', '5', '1111');

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
-- Records of shoes
-- ----------------------------
INSERT INTO `shoes` VALUES ('38', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-05 22:47:34', '99.00', '120.00', '90.00', '0', 'Nike 耐克官方 KYRIE 5 EP男子篮球鞋 AO29');
INSERT INTO `shoes` VALUES ('40', '1', '1', '89545b0d33144145b9a8f44ff56f93af', '.jpeg', '2019-03-05 22:48:54', '89.00', '135.50', '100.00', '0', '11');
INSERT INTO `shoes` VALUES ('41', '1', '1', '3140d45587294473b27163468b7de3bd', '.jpeg', '2019-03-05 22:49:13', '89.00', '140.60', '100.00', '1', '11');
INSERT INTO `shoes` VALUES ('42', '1', '1', 'e8ddf269c6f6454aa1ae01a83f71ff31', '.jpeg', '2019-03-05 22:49:22', '89.00', '140.60', '60.00', '0', '11');
INSERT INTO `shoes` VALUES ('43', '1', '2', '133d4562b7f0451484668bf9aa00a9d6', '.jpg', '2019-03-05 22:49:42', '89.00', '140.60', '100.00', '0', '11');
INSERT INTO `shoes` VALUES ('44', '1', '2', 'b89f619debc74821acb577bb29fe299f', '.jpeg', '2019-03-05 22:49:49', '89.00', '140.60', '100.00', '0', '11');
INSERT INTO `shoes` VALUES ('45', '1', '2', '7a525f45553e4cf788a54132fb3409f2', '.jpg', '2019-03-05 22:49:56', '89.00', '140.60', '100.00', '0', '11');
INSERT INTO `shoes` VALUES ('46', '1', '2', 'abd4ab4173584f7983b368a75c52adb0', '.jpeg', '2019-03-05 22:50:04', '89.00', '140.60', '100.00', '0', '22222');
INSERT INTO `shoes` VALUES ('47', '1', '3', '9c05a8b03b7b4622a0a52258858733db', '.jpg', '2019-03-05 22:50:12', '89.00', '140.60', '100.00', '0', '3');
INSERT INTO `shoes` VALUES ('48', '1', '3', '7497a66232d24abdbb7057e9a19a2652', '.jpg', '2019-03-05 22:50:26', '89.00', '140.60', '100.00', '0', '33');
INSERT INTO `shoes` VALUES ('49', '1', '3', '01c97842b2ce496eba6f44ec9d2a429e', '.jpg', '2019-03-05 22:50:33', '89.00', '140.60', '100.00', '0', '3333');
INSERT INTO `shoes` VALUES ('50', '1', '4', 'c1eb2647d555457fba97ff277c5c56f7', '.jpeg', '2019-03-05 22:50:41', '89.00', '140.60', '100.00', '0', '4');
INSERT INTO `shoes` VALUES ('51', '1', '4', '4cab1b490b2f42beb29a281e431f7360', '.jpg', '2019-03-05 22:50:47', '89.00', '140.60', '100.00', '0', '44');
INSERT INTO `shoes` VALUES ('52', '1', '4', '09945ac15e53428f83d981397d4b9957', '.jpg', '2019-03-05 22:51:00', '89.00', '140.60', '100.00', '0', '444');
INSERT INTO `shoes` VALUES ('53', '1', '4', '078a138c629b4c7c897eaad53fa04c9d', '.jpg', '2019-03-05 22:51:08', '89.00', '140.60', '100.00', '0', '4444');
INSERT INTO `shoes` VALUES ('154', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:36', '35.56', '121.00', '0.10', '1', '工展不受这，。形鞋一');
INSERT INTO `shoes` VALUES ('155', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:37', '52.34', '101.60', '0.30', '1', '。的受了毛样在克鞋受');
INSERT INTO `shoes` VALUES ('156', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:37', '84.35', '141.26', '0.31', '1', '样在子明韶不早成保期');
INSERT INTO `shoes` VALUES ('157', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:37', '28.02', '67.36', '0.21', '1', '脚子不鞋们殊。0鞋原');
INSERT INTO `shoes` VALUES ('158', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:37', '51.40', '147.12', '0.65', '0', '殊缝难形缝况特始子。');
INSERT INTO `shoes` VALUES ('159', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:37', '58.57', '65.06', '0.85', '0', '了是者具在能0一就子');
INSERT INTO `shoes` VALUES ('160', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:37', '16.56', '55.47', '0.51', '1', '鞋子功史发出现缝功5');
INSERT INTO `shoes` VALUES ('163', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:37', '56.51', '192.26', '0.12', '1', '子皮种特随化0能化鞋');
INSERT INTO `shoes` VALUES ('164', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:38', '55.59', '99.91', '0.78', '1', '随有就出发5鞋多子在');
INSERT INTO `shoes` VALUES ('165', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:38', '65.14', '179.70', '0.85', '1', '多工们原子受，伤多特');
INSERT INTO `shoes` VALUES ('166', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:38', '99.41', '155.89', '0.42', '1', '子悠们，5者脚化期悠');
INSERT INTO `shoes` VALUES ('167', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:38', '1.72', '108.35', '0.31', '1', '克。见多脚或鞋子有原');
INSERT INTO `shoes` VALUES ('168', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:38', '33.90', '35.39', '0.46', '1', '的就样伤早的期，鞋见');
INSERT INTO `shoes` VALUES ('169', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:38', '23.15', '171.83', '0.07', '1', '形最受，鞋情最是化式');
INSERT INTO `shoes` VALUES ('170', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:38', '51.24', '109.84', '0.43', '1', '人化们子文一殊克鞋子');
INSERT INTO `shoes` VALUES ('172', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:38', '19.58', '139.34', '0.58', '1', '0韶现韶鞋毛原0受不');
INSERT INTO `shoes` VALUES ('173', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:38', '76.33', '111.88', '0.96', '1', '久具子前种仰在在种了');
INSERT INTO `shoes` VALUES ('176', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:38', '27.68', '84.72', '0.21', '1', '。鞋皮形原发年0皮们');
INSERT INTO `shoes` VALUES ('177', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:38', '21.84', '72.09', '0.19', '1', '韶约。了克就了。仰随');
INSERT INTO `shoes` VALUES ('178', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:38', '94.52', '186.73', '0.77', '1', '种5人，就的展约特到');
INSERT INTO `shoes` VALUES ('179', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:38', '40.09', '124.71', '0.81', '1', '着。在化文现人是是这');
INSERT INTO `shoes` VALUES ('180', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:38', '47.82', '185.46', '0.08', '1', '现的个种种最发这情在');
INSERT INTO `shoes` VALUES ('182', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:38', '69.32', '87.90', '0.75', '1', '鞋现在在多出受难的鞋');
INSERT INTO `shoes` VALUES ('183', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:38', '79.18', '120.24', '0.49', '1', '式发就现样脚到在子鞋');
INSERT INTO `shoes` VALUES ('184', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:38', '82.65', '25.59', '0.47', '1', '到是子样。原殊在悠在');
INSERT INTO `shoes` VALUES ('187', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:39', '91.77', '100.40', '0.67', '0', '伤子个种克或不时各的');
INSERT INTO `shoes` VALUES ('188', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:39', '81.90', '159.04', '0.30', '1', '了殊最缝最人。人0伤');
INSERT INTO `shoes` VALUES ('189', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:39', '58.17', '139.36', '0.16', '0', '子者不了子是们子鞋子');
INSERT INTO `shoes` VALUES ('190', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:39', '71.21', '177.85', '0.56', '1', '各就式鞋式的发服情种');
INSERT INTO `shoes` VALUES ('191', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:39', '29.13', '185.69', '0.05', '0', '的。，多发制子皮了皮');
INSERT INTO `shoes` VALUES ('192', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:39', '0.08', '192.98', '0.85', '1', '服早子，脚成见难。鞋');
INSERT INTO `shoes` VALUES ('193', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:39', '69.06', '99.45', '50.00', '1', '。现者出人展样化种样');
INSERT INTO `shoes` VALUES ('194', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:39', '56.49', '133.72', '95.00', '1', '化制时时久服的，展。');
INSERT INTO `shoes` VALUES ('195', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:39', '78.20', '144.44', '0.82', '1', '现在子仰年文韶难种人');
INSERT INTO `shoes` VALUES ('196', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:39', '2.81', '149.74', '0.43', '1', '毛者了，发，受子脚脚');
INSERT INTO `shoes` VALUES ('197', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:39', '57.64', '155.41', '0.55', '1', '就在情受了在样文展韶');
INSERT INTO `shoes` VALUES ('199', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:39', '13.96', '154.30', '0.85', '1', '到韶了悠子受鞋了的皮');
INSERT INTO `shoes` VALUES ('200', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:39', '96.12', '141.13', '0.57', '1', '为年皮个发形保了情。');
INSERT INTO `shoes` VALUES ('201', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:40', '27.20', '91.07', '0.50', '1', '受了情子鞋子子了者者');
INSERT INTO `shoes` VALUES ('202', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:40', '16.40', '107.50', '0.92', '1', '伤久鞋难0鞋能。受子');
INSERT INTO `shoes` VALUES ('204', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:40', '56.10', '83.20', '0.81', '1', '仰鞋多伤鞋，情子展况');
INSERT INTO `shoes` VALUES ('205', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:40', '39.58', '159.62', '0.94', '1', '00伤久脚展不就制不');
INSERT INTO `shoes` VALUES ('206', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:40', '74.12', '97.57', '0.19', '1', '护时护多现成早的鞋受');
INSERT INTO `shoes` VALUES ('209', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:40', '40.95', '109.41', '0.41', '1', '随毛情前式韶情就伤兽');
INSERT INTO `shoes` VALUES ('211', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:40', '19.79', '196.17', '0.14', '1', '不了人，始早的就子处');
INSERT INTO `shoes` VALUES ('212', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:40', '86.50', '119.60', '0.14', '1', '展为的种兽发现样的皮');
INSERT INTO `shoes` VALUES ('214', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:40', '21.36', '198.44', '0.90', '1', '鞋个让难约形随伤特兽');
INSERT INTO `shoes` VALUES ('215', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:40', '63.34', '74.20', '0.96', '1', '。处韶明鞋就的，是鞋');
INSERT INTO `shoes` VALUES ('216', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:40', '13.50', '61.85', '0.19', '1', '悠受或悠0。多发鞋0');
INSERT INTO `shoes` VALUES ('217', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:40', '18.15', '169.42', '0.29', '1', '最者鞋者护现文的护子');
INSERT INTO `shoes` VALUES ('218', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:40', '26.01', '44.24', '0.35', '1', '鞋早出种的脚样成，见');
INSERT INTO `shoes` VALUES ('220', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:40', '60.43', '71.88', '0.26', '1', '人各。仰久0或年，鞋');
INSERT INTO `shoes` VALUES ('222', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:41', '73.81', '194.90', '0.85', '1', '制种前了受鞋功明样不');
INSERT INTO `shoes` VALUES ('223', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:41', '3.36', '57.24', '0.82', '1', '在的受展文样的的的子');
INSERT INTO `shoes` VALUES ('224', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:41', '36.35', '160.77', '0.62', '1', '展兽文形现特出有就始');
INSERT INTO `shoes` VALUES ('225', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:41', '52.40', '20.29', '0.47', '1', '不前。种见缝能史原年');
INSERT INTO `shoes` VALUES ('226', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:41', '7.58', '24.84', '0.69', '1', '殊了难5史现人了子就');
INSERT INTO `shoes` VALUES ('227', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:41', '48.34', '187.48', '0.75', '1', '就的子这，化出鞋史最');
INSERT INTO `shoes` VALUES ('228', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:41', '79.96', '181.92', '0.75', '1', '多子处各化保见发形伤');
INSERT INTO `shoes` VALUES ('229', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:41', '13.69', '38.25', '0.42', '1', '人展毛鞋不原服者能缝');
INSERT INTO `shoes` VALUES ('230', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:41', '84.23', '188.59', '0.95', '1', '原发仰伤受展处可，就');
INSERT INTO `shoes` VALUES ('231', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:41', '61.22', '72.81', '0.35', '1', '在脚期了，最脚的年。');
INSERT INTO `shoes` VALUES ('232', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:41', '50.87', '192.62', '0.64', '1', '情就子形着原，0悠受');
INSERT INTO `shoes` VALUES ('236', '1', '1', '7d39b3b1ff3a4d2fb7e7cda858295278', '.jpeg', '2019-03-09 19:37:41', '16.70', '43.00', '0.20', '1', '形。在时子能年鞋的脚');
INSERT INTO `shoes` VALUES ('237', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:41', '13.22', '147.73', '0.78', '1', '种皮式现了韶年有了到');
INSERT INTO `shoes` VALUES ('239', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:41', '3.00', '164.81', '0.29', '1', '脚护护制见受久一制现');
INSERT INTO `shoes` VALUES ('241', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:41', '72.18', '144.21', '0.45', '1', '时脚的鞋克了脚难能者');
INSERT INTO `shoes` VALUES ('242', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:41', '94.28', '43.03', '0.51', '1', '0原的护式样最，们者');
INSERT INTO `shoes` VALUES ('243', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:42', '4.15', '144.41', '0.60', '1', '们就发各时，。可大，');
INSERT INTO `shoes` VALUES ('246', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:42', '14.08', '190.22', '0.11', '1', '人在最展式克现们久现');
INSERT INTO `shoes` VALUES ('248', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:42', '17.98', '67.19', '0.96', '1', '护受悠们，，皮受见出');
INSERT INTO `shoes` VALUES ('249', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:42', '43.93', '107.87', '0.41', '1', '出子5。发子脚5缝人');
INSERT INTO `shoes` VALUES ('250', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:42', '23.84', '68.83', '0.91', '1', '各成展早子鞋现的可种');
INSERT INTO `shoes` VALUES ('251', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:42', '0.39', '77.75', '0.76', '1', '到了文成多就随鞋。了');
INSERT INTO `shoes` VALUES ('252', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:42', '72.25', '63.13', '0.71', '1', '了能形韶各功就的鞋，');
INSERT INTO `shoes` VALUES ('253', '1', '1', '2ee005c0572a4eed9f84e76bda099afc', '.jpeg', '2019-03-09 19:37:42', '60.88', '155.66', '0.51', '0', '0发们们的种不，具仰');
INSERT INTO `shoes` VALUES ('254', '2', '1', '020b255893ed470ba87be841a58b1dc8', '.jpeg', '2019-03-23 15:30:13', '89.00', '140.60', '98.00', '0', 'Nike王');
INSERT INTO `shoes` VALUES ('255', '2', '1', '9a4f087998bc41ae8483c8f4980e19c5', '.jpeg', '2019-03-23 15:31:19', '89.00', '140.60', '98.00', '1', 'Nike王');

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
-- Records of shoesitem
-- ----------------------------
INSERT INTO `shoesitem` VALUES ('1', '38', '19', '1', '1');
INSERT INTO `shoesitem` VALUES ('1', '38', '20', '5', '1');
INSERT INTO `shoesitem` VALUES ('1', '38', '21', '4', '2');
INSERT INTO `shoesitem` VALUES ('1', '38', '22', '0', '2');
INSERT INTO `shoesitem` VALUES ('1', '38', '23', '0', '2');
INSERT INTO `shoesitem` VALUES ('1', '40', '31', '1', '2');
INSERT INTO `shoesitem` VALUES ('1', '41', '37', '1', '1');
INSERT INTO `shoesitem` VALUES ('1', '41', '39', '1', '1');
INSERT INTO `shoesitem` VALUES ('1', '42', '47', '1', '2');

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
-- Records of shoessize
-- ----------------------------
INSERT INTO `shoessize` VALUES ('18', '38', '10', '39.0', '');
INSERT INTO `shoessize` VALUES ('19', '38', '15', '40.0', '');
INSERT INTO `shoessize` VALUES ('20', '38', '20', '41.0', '');
INSERT INTO `shoessize` VALUES ('21', '38', '15', '42.0', '');
INSERT INTO `shoessize` VALUES ('22', '38', '3', '43.0', '');
INSERT INTO `shoessize` VALUES ('23', '38', '0', '44.0', '');
INSERT INTO `shoessize` VALUES ('30', '40', '10', '39.0', '');
INSERT INTO `shoessize` VALUES ('31', '40', '15', '40.0', '');
INSERT INTO `shoessize` VALUES ('32', '40', '20', '41.0', '');
INSERT INTO `shoessize` VALUES ('33', '40', '15', '42.0', '');
INSERT INTO `shoessize` VALUES ('34', '40', '10', '43.0', '');
INSERT INTO `shoessize` VALUES ('35', '40', '10', '44.0', '');
INSERT INTO `shoessize` VALUES ('36', '41', '10', '39.0', '');
INSERT INTO `shoessize` VALUES ('37', '41', '15', '40.0', '');
INSERT INTO `shoessize` VALUES ('38', '41', '17', '41.0', '');
INSERT INTO `shoessize` VALUES ('39', '41', '15', '42.0', '');
INSERT INTO `shoessize` VALUES ('40', '41', '10', '43.0', '');
INSERT INTO `shoessize` VALUES ('41', '41', '10', '44.0', '');
INSERT INTO `shoessize` VALUES ('42', '42', '10', '39.0', '');
INSERT INTO `shoessize` VALUES ('43', '42', '15', '40.0', '');
INSERT INTO `shoessize` VALUES ('44', '42', '20', '41.0', '');
INSERT INTO `shoessize` VALUES ('45', '42', '15', '42.0', '');
INSERT INTO `shoessize` VALUES ('46', '42', '10', '43.0', '');
INSERT INTO `shoessize` VALUES ('47', '42', '10', '44.0', '');
INSERT INTO `shoessize` VALUES ('48', '43', '10', '39.0', '');
INSERT INTO `shoessize` VALUES ('49', '43', '15', '40.0', '');
INSERT INTO `shoessize` VALUES ('50', '43', '20', '41.0', '');
INSERT INTO `shoessize` VALUES ('51', '43', '15', '42.0', '');
INSERT INTO `shoessize` VALUES ('52', '43', '10', '43.0', '');
INSERT INTO `shoessize` VALUES ('53', '43', '10', '44.0', '');
INSERT INTO `shoessize` VALUES ('54', '44', '10', '39.0', '');
INSERT INTO `shoessize` VALUES ('55', '44', '15', '40.0', '');
INSERT INTO `shoessize` VALUES ('56', '44', '20', '41.0', '');
INSERT INTO `shoessize` VALUES ('57', '44', '15', '42.0', '');
INSERT INTO `shoessize` VALUES ('58', '44', '10', '43.0', '');
INSERT INTO `shoessize` VALUES ('59', '44', '10', '44.0', '');
INSERT INTO `shoessize` VALUES ('60', '45', '10', '39.0', '');
INSERT INTO `shoessize` VALUES ('61', '45', '15', '40.0', '');
INSERT INTO `shoessize` VALUES ('62', '45', '20', '41.0', '');
INSERT INTO `shoessize` VALUES ('63', '45', '15', '42.0', '');
INSERT INTO `shoessize` VALUES ('64', '45', '10', '43.0', '');
INSERT INTO `shoessize` VALUES ('65', '45', '10', '44.0', '');
INSERT INTO `shoessize` VALUES ('66', '46', '10', '39.0', '');
INSERT INTO `shoessize` VALUES ('67', '46', '15', '40.0', '');
INSERT INTO `shoessize` VALUES ('68', '46', '20', '41.0', '');
INSERT INTO `shoessize` VALUES ('69', '46', '15', '42.0', '');
INSERT INTO `shoessize` VALUES ('70', '46', '10', '43.0', '');
INSERT INTO `shoessize` VALUES ('71', '46', '10', '44.0', '');
INSERT INTO `shoessize` VALUES ('72', '47', '10', '39.0', '');
INSERT INTO `shoessize` VALUES ('73', '47', '15', '40.0', '');
INSERT INTO `shoessize` VALUES ('74', '47', '20', '41.0', '');
INSERT INTO `shoessize` VALUES ('75', '47', '15', '42.0', '');
INSERT INTO `shoessize` VALUES ('76', '47', '10', '43.0', '');
INSERT INTO `shoessize` VALUES ('77', '47', '10', '44.0', '');
INSERT INTO `shoessize` VALUES ('78', '48', '10', '39.0', '');
INSERT INTO `shoessize` VALUES ('79', '48', '15', '40.0', '');
INSERT INTO `shoessize` VALUES ('80', '48', '20', '41.0', '');
INSERT INTO `shoessize` VALUES ('81', '48', '15', '42.0', '');
INSERT INTO `shoessize` VALUES ('82', '48', '10', '43.0', '');
INSERT INTO `shoessize` VALUES ('83', '48', '10', '44.0', '');
INSERT INTO `shoessize` VALUES ('84', '49', '10', '39.0', '');
INSERT INTO `shoessize` VALUES ('85', '49', '15', '40.0', '');
INSERT INTO `shoessize` VALUES ('86', '49', '20', '41.0', '');
INSERT INTO `shoessize` VALUES ('87', '49', '15', '42.0', '');
INSERT INTO `shoessize` VALUES ('88', '49', '10', '43.0', '');
INSERT INTO `shoessize` VALUES ('89', '49', '10', '44.0', '');
INSERT INTO `shoessize` VALUES ('90', '50', '10', '39.0', '');
INSERT INTO `shoessize` VALUES ('91', '50', '15', '40.0', '');
INSERT INTO `shoessize` VALUES ('92', '50', '20', '41.0', '');
INSERT INTO `shoessize` VALUES ('93', '50', '15', '42.0', '');
INSERT INTO `shoessize` VALUES ('94', '50', '10', '43.0', '');
INSERT INTO `shoessize` VALUES ('95', '50', '10', '44.0', '');
INSERT INTO `shoessize` VALUES ('96', '51', '10', '39.0', '');
INSERT INTO `shoessize` VALUES ('97', '51', '15', '40.0', '');
INSERT INTO `shoessize` VALUES ('98', '51', '20', '41.0', '');
INSERT INTO `shoessize` VALUES ('99', '51', '15', '42.0', '');
INSERT INTO `shoessize` VALUES ('100', '51', '10', '43.0', '');
INSERT INTO `shoessize` VALUES ('101', '51', '10', '44.0', '');
INSERT INTO `shoessize` VALUES ('102', '52', '10', '39.0', '');
INSERT INTO `shoessize` VALUES ('103', '52', '15', '40.0', '');
INSERT INTO `shoessize` VALUES ('104', '52', '20', '41.0', '');
INSERT INTO `shoessize` VALUES ('105', '52', '15', '42.0', '');
INSERT INTO `shoessize` VALUES ('106', '52', '10', '43.0', '');
INSERT INTO `shoessize` VALUES ('107', '52', '10', '44.0', '');
INSERT INTO `shoessize` VALUES ('108', '53', '10', '39.0', '');
INSERT INTO `shoessize` VALUES ('109', '53', '15', '40.0', '');
INSERT INTO `shoessize` VALUES ('110', '53', '20', '41.0', '');
INSERT INTO `shoessize` VALUES ('111', '53', '15', '42.0', '');
INSERT INTO `shoessize` VALUES ('112', '53', '10', '43.0', '');
INSERT INTO `shoessize` VALUES ('113', '53', '10', '44.0', '');
INSERT INTO `shoessize` VALUES ('314', '154', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('315', '154', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('316', '155', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('317', '155', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('318', '156', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('319', '156', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('320', '157', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('321', '157', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('323', '158', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('324', '159', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('325', '159', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('326', '160', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('327', '160', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('332', '163', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('333', '163', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('334', '164', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('335', '164', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('336', '165', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('337', '165', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('338', '166', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('339', '166', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('340', '167', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('341', '167', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('342', '168', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('343', '168', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('344', '169', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('345', '169', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('346', '170', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('347', '170', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('350', '172', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('351', '172', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('352', '173', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('353', '173', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('358', '176', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('359', '176', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('360', '177', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('361', '177', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('362', '178', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('363', '178', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('364', '179', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('365', '179', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('366', '180', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('367', '180', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('370', '182', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('371', '182', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('372', '183', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('373', '183', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('374', '184', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('375', '184', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('380', '187', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('381', '187', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('382', '188', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('383', '188', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('384', '189', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('385', '189', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('386', '190', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('387', '190', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('388', '191', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('389', '191', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('390', '192', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('391', '192', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('392', '193', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('393', '193', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('394', '194', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('395', '194', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('396', '195', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('397', '195', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('398', '196', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('399', '196', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('400', '197', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('401', '197', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('404', '199', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('405', '199', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('406', '200', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('407', '200', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('408', '201', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('409', '201', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('410', '202', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('411', '202', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('414', '204', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('415', '204', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('416', '205', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('417', '205', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('418', '206', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('419', '206', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('424', '209', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('425', '209', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('428', '211', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('429', '211', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('430', '212', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('431', '212', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('434', '214', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('435', '214', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('436', '215', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('437', '215', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('438', '216', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('439', '216', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('440', '217', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('441', '217', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('442', '218', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('443', '218', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('446', '220', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('447', '220', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('450', '222', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('451', '222', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('452', '223', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('453', '223', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('454', '224', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('455', '224', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('456', '225', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('457', '225', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('458', '226', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('459', '226', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('460', '227', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('461', '227', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('462', '228', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('463', '228', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('464', '229', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('465', '229', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('466', '230', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('467', '230', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('468', '231', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('469', '231', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('470', '232', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('471', '232', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('478', '236', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('479', '236', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('480', '237', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('481', '237', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('484', '239', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('485', '239', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('488', '241', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('489', '241', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('490', '242', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('491', '242', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('492', '243', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('493', '243', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('498', '246', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('499', '246', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('502', '248', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('503', '248', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('504', '249', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('505', '249', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('506', '250', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('507', '250', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('508', '251', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('509', '251', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('510', '252', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('511', '252', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('512', '253', '10', '40.0', '');
INSERT INTO `shoessize` VALUES ('513', '253', '20', '41.0', '');
INSERT INTO `shoessize` VALUES ('515', '158', '11', '40.5', '');
INSERT INTO `shoessize` VALUES ('517', '158', '11', '41.5', '');
INSERT INTO `shoessize` VALUES ('518', '254', '16', '39.0', '');
INSERT INTO `shoessize` VALUES ('519', '254', '20', '39.5', '');
INSERT INTO `shoessize` VALUES ('520', '255', '1', '39.0', '');

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

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'adm', '202cb962ac59075b964b07152d234b70', 'admin@onlineShoes.com', '2019-03-19 22:10:12', '2147483615');
INSERT INTO `user` VALUES ('2', 'jack', '202cb962ac59075b964b07152d234b70', 'jack@onlineShoes.com', '2019-03-19 22:10:12', '7');
INSERT INTO `user` VALUES ('3', 'rose', 'e10adc3949ba59abbe56e057f20f883e', 'rose@onlineShoes.com', '2019-03-19 22:10:12', '0');
INSERT INTO `user` VALUES ('4', 'sjy', 'e10adc3949ba59abbe56e057f20f883e', '1@1.com', '2019-03-19 22:10:12', '0');
INSERT INTO `user` VALUES ('6', 'sjy2', 'e10adc3949ba59abbe56e057f20f883e', '1@1.com1', '2019-03-19 22:10:12', '0');
INSERT INTO `user` VALUES ('7', '111', '698d51a19d8a121ce581499d7b701668', '1@1.1', '2019-03-19 22:10:12', '0');
INSERT INTO `user` VALUES ('8', 'sjy1', '698d51a19d8a121ce581499d7b701668', '447441478@qq.com', '2019-03-19 23:06:26', '0');
