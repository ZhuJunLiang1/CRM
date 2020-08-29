/*
Navicat MySQL Data Transfer

Source Server         : 8.0-3306
Source Server Version : 80019
Source Host           : localhost:3306
Source Database       : crm

Target Server Type    : MYSQL
Target Server Version : 80019
File Encoding         : 65001

Date: 2020-08-22 19:52:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tbl_activity`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_activity`;
CREATE TABLE `tbl_activity` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `startDate` char(10) DEFAULT NULL,
  `endDate` char(10) DEFAULT NULL,
  `cost` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_activity
-- ----------------------------
INSERT INTO `tbl_activity` VALUES ('5f00fbe847b4467ba39a23619280213d', '40f6cdea0bd34aceb77492a1656d9fb3', '13', '2020-07-30', '2020-07-29', '13', '13', '2020-08-17 20:56:04', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('6565ce0e3fb841b09ed553cb9facfd4b', '40f6cdea0bd34aceb77492a1656d9fb3', '市场活动2', '2020-08-12', '2020-08-20', '10000', '骚打劫21', '2020-08-17 16:39:12', '张三', '2020-08-17 22:06:34', '张三');
INSERT INTO `tbl_activity` VALUES ('974267315b38483ba8fb50bfb34bb019', '40f6cdea0bd34aceb77492a1656d9fb3', '扫大街1', '2020-08-02', '2020-08-12', '111111', '扫大街扫大街', '2020-08-17 16:58:41', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('b19cb21bb2aa42b190ff0a8261cdda3f', '40f6cdea0bd34aceb77492a1656d9fb3', '市场活动1', '2020-08-04', '2020-08-22', '20000', '扫大街', '2020-08-17 16:38:53', '张三', null, null);

-- ----------------------------
-- Table structure for `tbl_activity_remark`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_activity_remark`;
CREATE TABLE `tbl_activity_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL COMMENT '0表示未修改，1表示已修改',
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_activity_remark
-- ----------------------------
INSERT INTO `tbl_activity_remark` VALUES ('0d4bc90a613343b1ae0006d04d5fb3b5', '2', '2020-08-20 08:19:12', '张三', null, null, '0', '974267315b38483ba8fb50bfb34bb019');
INSERT INTO `tbl_activity_remark` VALUES ('4a5e01abdf5a49589d8ee5f16afd3bda', '1', '2020-08-17 22:00:46', '张三', null, null, '0', '974267315b38483ba8fb50bfb34bb019');
INSERT INTO `tbl_activity_remark` VALUES ('b099691e1d2c4ce1b451178f78c5c691', '123', '2020-08-17 22:06:23', '张三', null, null, '0', '6565ce0e3fb841b09ed553cb9facfd4b');

-- ----------------------------
-- Table structure for `tbl_clue`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue`;
CREATE TABLE `tbl_clue` (
  `id` char(32) NOT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `appellation` varchar(255) DEFAULT NULL,
  `owner` char(32) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `mphone` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_clue
-- ----------------------------
INSERT INTO `tbl_clue` VALUES ('04664d7beb094887af883acfcbe297d6', '王健林', '先生', '40f6cdea0bd34aceb77492a1656d9fb3', '万达集团', 'CEO', '1234', '123', '123', '1', '将来联系', '公开媒介', '张三', '2020-08-22 08:39:48', null, null, '123', '123', '2020-08-28', '');
INSERT INTO `tbl_clue` VALUES ('119af41abed541edbe6a65b8ecaf0615', '马云', '夫人', '40f6cdea0bd34aceb77492a1656d9fb3', '阿里巴巴', 'CEO', 'alibaba@163.com', '1234', 'alibaba.com', '12345', '已联系', '销售邮件', '张三', '2020-08-22 08:27:14', null, null, '1234', '1234', '2020-08-29', '12345');
INSERT INTO `tbl_clue` VALUES ('14a75b6f24ec411c9b4e66a66b072e62', '朱俊良', '', '40f6cdea0bd34aceb77492a1656d9fb3', '字节跳动', '', '', '', '', '', '', 'web调研', '张三', '2020-08-22 08:58:52', null, null, '', '', '', '');
INSERT INTO `tbl_clue` VALUES ('3dc1d33590304788837a9cec7a6bdd91', '朱俊良', '先生', '40f6cdea0bd34aceb77492a1656d9fb3', '腾讯', '', '', '', '', '1', '需要条件', 'web调研', '张三', '2020-08-22 08:40:37', null, null, '', '', '', '');
INSERT INTO `tbl_clue` VALUES ('5ea5974e55f64a70ac6173da084bb396', 'Jack', '先生', '40f6cdea0bd34aceb77492a1656d9fb3', '字节跳动', 'CTO', 'jack@163.com', '013212421', 'www.jack.com', '13544831353124', '将来联系', '聊天', '我都', null, '张三', '2020-08-16 11:47:35', 'n1421125215', '练习', '2020-08-22', '北京');
INSERT INTO `tbl_clue` VALUES ('63ca509fdee442a7b8614acb26bfe27d', '王健林', '先生', '40f6cdea0bd34aceb77492a1656d9fb3', '万达集团', 'CTO', 'wangjianlin.com', '123456789', 'wangjianlin.com', '12345678910', '将来联系', '内部研讨会', '张三', '2020-08-17 16:41:17', '张三', '2020-08-17 20:39:45', '这是王健林的线索描述1', '这是王健林的联系纪要', '2020-08-29', '这是王健林的详细地址');

-- ----------------------------
-- Table structure for `tbl_clue_activity_relation`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue_activity_relation`;
CREATE TABLE `tbl_clue_activity_relation` (
  `id` char(32) NOT NULL,
  `clueId` char(32) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_clue_activity_relation
-- ----------------------------
INSERT INTO `tbl_clue_activity_relation` VALUES ('372900b00e754467a88eb206325965f6', '14a75b6f24ec411c9b4e66a66b072e62', '6565ce0e3fb841b09ed553cb9facfd4b');
INSERT INTO `tbl_clue_activity_relation` VALUES ('6cff138c955445ebb3d8273979eb29cf', '04664d7beb094887af883acfcbe297d6', '5f00fbe847b4467ba39a23619280213d');
INSERT INTO `tbl_clue_activity_relation` VALUES ('707cfdaa4a8b4854a10d18a4aa557014', '5ea5974e55f64a70ac6173da084bb396', '974267315b38483ba8fb50bfb34bb019');
INSERT INTO `tbl_clue_activity_relation` VALUES ('8cde573b8e9f4857ae4f577c6cc0e012', '04664d7beb094887af883acfcbe297d6', '974267315b38483ba8fb50bfb34bb019');
INSERT INTO `tbl_clue_activity_relation` VALUES ('8ce22395910a49f78100509c3f4fadbc', '63ca509fdee442a7b8614acb26bfe27d', '6565ce0e3fb841b09ed553cb9facfd4b');
INSERT INTO `tbl_clue_activity_relation` VALUES ('91fa8cdaced140f8b2c2d2aa0ded9444', '5ea5974e55f64a70ac6173da084bb396', 'b19cb21bb2aa42b190ff0a8261cdda3f');
INSERT INTO `tbl_clue_activity_relation` VALUES ('dc0e14f2e066492e957de7c999b5ed65', '14a75b6f24ec411c9b4e66a66b072e62', 'b19cb21bb2aa42b190ff0a8261cdda3f');

-- ----------------------------
-- Table structure for `tbl_clue_remark`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_clue_remark`;
CREATE TABLE `tbl_clue_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `clueId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_clue_remark
-- ----------------------------
INSERT INTO `tbl_clue_remark` VALUES ('000e397c639441f3889cdbfa296107a4', '1', '张三', '2020-08-17 21:00:04', null, null, '0', '63ca509fdee442a7b8614acb26bfe27d');
INSERT INTO `tbl_clue_remark` VALUES ('06c81b23f122425da412369f6df678ca', '321', '张三', '2020-08-16 17:41:14', null, null, '0', '');
INSERT INTO `tbl_clue_remark` VALUES ('11d5e6accf164e4d8ca9dd50cd38b982', '2', '张三', '2020-08-17 21:58:22', null, null, '0', '63ca509fdee442a7b8614acb26bfe27d');
INSERT INTO `tbl_clue_remark` VALUES ('51f7d8ee43414c01a68cbac9fe1e5235', '你好', '张三', '2020-08-22 09:05:30', null, null, '0', '04664d7beb094887af883acfcbe297d6');
INSERT INTO `tbl_clue_remark` VALUES ('5ea5974e55f64a70ac6173da084bb392', '我都起飞了', null, null, null, null, null, '5ea5974e55f64a70ac6173da084bb396');
INSERT INTO `tbl_clue_remark` VALUES ('c80eb3719ba44495869a4d230e60cede', '3131', '张三', '2020-08-16 17:41:17', null, null, '0', '');

-- ----------------------------
-- Table structure for `tbl_contacts`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts`;
CREATE TABLE `tbl_contacts` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `appellation` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mphone` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `birth` char(10) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_contacts
-- ----------------------------
INSERT INTO `tbl_contacts` VALUES ('07c828dabbb94d9c8553718d7d143636', '40f6cdea0bd34aceb77492a1656d9fb3', '销售邮件', '9a823a44d6ab4e8f92a52c28ee608fea', '朱俊良0000', '', 'zhujunliang0831@163.com', '13849171575', 'CEO', '1899-12-20', '张三', '2020-08-19 17:03:45', '张三', '2020-08-19 20:40:16', '11', '2', '222', '222');
INSERT INTO `tbl_contacts` VALUES ('1340f2253ad54b20aa10b5ad56ced27c', '40f6cdea0bd34aceb77492a1656d9fb3', '合作伙伴研讨会', '2b899e69c46541e580a57d7211552468', '朱俊良', '先生', 'zhujunliang0831@163.com', '13849171575', 'CEO', '2020-08-21', '张三', '2020-08-21 10:38:12', null, null, '2', '3', '2020-08-29', '郑州');
INSERT INTO `tbl_contacts` VALUES ('17dbaf15577140bda3c224b80f31a507', '40f6cdea0bd34aceb77492a1656d9fb3', 'web调研', '2b899e69c46541e580a57d7211552468', '朱俊良12312', '夫人', 'zhujunliang0831@163.com', '13849171575', 'CEO', '2020-08-13', '张三', '2020-08-19 17:11:28', '张三', '2020-08-19 20:55:29', '31232', '123121', '1231', '13221');
INSERT INTO `tbl_contacts` VALUES ('371771c371e14716910268906d53966c', '40f6cdea0bd34aceb77492a1656d9fb3', '合作伙伴', 'e47beed47a774728b96f9668ac8d010f', 'Jack', '先生', 'Jack.com', '123', 'CEO', '2020-08-29', '张三', '2020-08-22 08:37:23', null, null, '123', '123', '2020-08-29', '123');
INSERT INTO `tbl_contacts` VALUES ('574ce309c4af4e24b91478e0a19a4d18', '40f6cdea0bd34aceb77492a1656d9fb3', '交易会', 'e47beed47a774728b96f9668ac8d010f', 'Cris', '先生', '11', '111', '11', '2020-08-22', '张三', '2020-08-21 16:39:41', '张三', '2020-08-22 08:37:36', '22', '22', '1899-12-23', '222');
INSERT INTO `tbl_contacts` VALUES ('66bd0e8f41494e3896542b618035f61e', '40f6cdea0bd34aceb77492a1656d9fb3', '聊天', '87fe9c4a696846aa985c138ef51dee0e', '马云', '先生', 'mayun.com', '123', 'CEO', '2020-08-20', '张三', '2020-08-22 08:30:45', null, null, '123', '124', '2020-08-21', '1421312');
INSERT INTO `tbl_contacts` VALUES ('c4679e6b5ca44e859bcdad88b3a77788', '40f6cdea0bd34aceb77492a1656d9fb3', '广告', '9a823a44d6ab4e8f92a52c28ee608fea', '朱俊良1', '先生', 'zhujunliang0831@163.com', '13849171575', 'CEO', '1998-08-31', '张三', '2020-08-19 11:21:52', '张三', '2020-08-19 18:00:46', '描述', '纪要', '2020-08-31', '1111');
INSERT INTO `tbl_contacts` VALUES ('efc7b0fef0d64b48b4c7ef864525a7a2', '40f6cdea0bd34aceb77492a1656d9fb3', '外部介绍', '2a1e3572039c49609350889646e53c10', '李彦宏', '先生', '1234', '123', 'CEO', '2020-08-29', '张三', '2020-08-22 08:31:45', null, null, '123', '123', '2020-08-29', '132');
INSERT INTO `tbl_contacts` VALUES ('fd245aad6d4341fd8c1ff2a65e79b95c', '40f6cdea0bd34aceb77492a1656d9fb3', '广告', '87fe9c4a696846aa985c138ef51dee0e', '马云2', '先生', 'alibaba.com', '12345678910', 'CTO', '2020-08-20', '张三', '2020-08-17 16:45:42', '张三', '2020-08-22 08:36:42', '这是一条马云的线索描述', '这是一条马云的联系纪要', '2020-08-22', '马云的详细地址');

-- ----------------------------
-- Table structure for `tbl_contacts_activity_relation`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts_activity_relation`;
CREATE TABLE `tbl_contacts_activity_relation` (
  `id` char(32) NOT NULL,
  `contactsId` char(32) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_contacts_activity_relation
-- ----------------------------
INSERT INTO `tbl_contacts_activity_relation` VALUES ('051294907fb3486f969ffb2d0d57ff4c', '17dbaf15577140bda3c224b80f31a507', '6565ce0e3fb841b09ed553cb9facfd4b');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('07c828dabbb94d9c8553718d7d143602', '07c828dabbb94d9c8553718d7d143636', '6565ce0e3fb841b09ed553cb9facfd4b');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('07c828dabbb94d9c8553718d7d143603', '07c828dabbb94d9c8553718d7d143636', '5f00fbe847b4467ba39a23619280213d');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('3656e2b12a0843b8a85336c1b7e7cc21', '1340f2253ad54b20aa10b5ad56ced27c', 'b19cb21bb2aa42b190ff0a8261cdda3f');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('612e4fc7aeec44fb89774d51e74acc6f', 'c4679e6b5ca44e859bcdad88b3a77788', 'b19cb21bb2aa42b190ff0a8261cdda3f');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('68934c52c8184c63a93b811c6933fd1e', 'fd245aad6d4341fd8c1ff2a65e79b95c', 'b19cb21bb2aa42b190ff0a8261cdda3f');

-- ----------------------------
-- Table structure for `tbl_contacts_remark`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_contacts_remark`;
CREATE TABLE `tbl_contacts_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `contactsId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_contacts_remark
-- ----------------------------
INSERT INTO `tbl_contacts_remark` VALUES ('1fbd495e3eb245ada26b43cfa69657ff', '456', '张三', '2020-08-20 09:13:55', null, null, '0', '07c828dabbb94d9c8553718d7d143636');
INSERT INTO `tbl_contacts_remark` VALUES ('c1cfb428add24e8ca2060618ea6036e5', '12312412414212412412412', '张三', '2020-08-17 20:54:17', null, null, '0', '0964a58518a34158bb022af9f1d21d69');
INSERT INTO `tbl_contacts_remark` VALUES ('e79a18c668524252abc171dd27b90fe2', '3', '张三', '2020-08-20 20:21:31', null, null, '0', 'c4679e6b5ca44e859bcdad88b3a77788');
INSERT INTO `tbl_contacts_remark` VALUES ('e873dd915830456286d01037d1be809e', '2321', '张三', '2020-08-19 22:15:27', '张三', '2020-08-19 22:16:51', '1', '07c828dabbb94d9c8553718d7d143636');
INSERT INTO `tbl_contacts_remark` VALUES ('eac7bf36cf134f9b9ca39e4c576ce485', '1', '张三', '2020-08-19 22:11:56', null, null, '0', '07c828dabbb94d9c8553718d7d143636');
INSERT INTO `tbl_contacts_remark` VALUES ('f9283309dc8249d39c0f0199aafcb8a1', '1', '张三', '2020-08-17 20:54:17', null, null, '0', '0964a58518a34158bb022af9f1d21d69');

-- ----------------------------
-- Table structure for `tbl_customer`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customer`;
CREATE TABLE `tbl_customer` (
  `id` char(32) NOT NULL,
  `owner` char(32) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_customer
-- ----------------------------
INSERT INTO `tbl_customer` VALUES ('2a1e3572039c49609350889646e53c10', '40f6cdea0bd34aceb77492a1656d9fb3', '百度', 'www.baidu.com', '123', '张三', '2020-08-22 08:29:55', '张三', '2020-08-22 08:34:40', '123', '2020-08-29', '123', '北京');
INSERT INTO `tbl_customer` VALUES ('2b899e69c46541e580a57d7211552468', '40f6cdea0bd34aceb77492a1656d9fb3', '字节跳动', '3', '2', '张三', '2020-08-20 20:19:51', '张三', '2020-08-22 08:32:46', '11', '2020-08-22', '2', '3');
INSERT INTO `tbl_customer` VALUES ('87fe9c4a696846aa985c138ef51dee0e', '40f6cdea0bd34aceb77492a1656d9fb3', '阿里巴巴', '124', '123', '张三', '2020-08-22 08:30:05', null, null, '24142', '2020-08-29', '1', '124');
INSERT INTO `tbl_customer` VALUES ('e47beed47a774728b96f9668ac8d010f', '40f6cdea0bd34aceb77492a1656d9fb3', 'Cisco', '', '', '张三', '2020-08-21 16:39:41', '张三', '2020-08-22 08:35:47', '22', '1899-12-23', '', '');
INSERT INTO `tbl_customer` VALUES ('ef9de174e4154968acf2b899ac02a03f', '40f6cdea0bd34aceb77492a1656d9fb3', '科大讯飞', '2', '2', '张三', '2020-08-22 08:36:19', null, null, '2', '2020-08-29', '2', '12');

-- ----------------------------
-- Table structure for `tbl_customer_remark`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customer_remark`;
CREATE TABLE `tbl_customer_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_customer_remark
-- ----------------------------
INSERT INTO `tbl_customer_remark` VALUES ('1690b6a846714648822b2d2f44d143e3', '321421421153', '张三', '2020-08-17 20:54:17', null, null, '0', '023793ab92ee4b4a91f00b7f48400ddb');
INSERT INTO `tbl_customer_remark` VALUES ('56f486d9dea1461bb1306ac302c8deec', '2', '张三', '2020-08-18 09:56:08', null, null, '0', 'f1fa52932c244c078095701a287dc869');
INSERT INTO `tbl_customer_remark` VALUES ('78d0abc75cfa4a7d9ac95f024e5e5bac', '1', '张三', '2020-08-17 20:54:17', null, null, '0', '023793ab92ee4b4a91f00b7f48400ddb');
INSERT INTO `tbl_customer_remark` VALUES ('7a6d3c9733884bf7935227e0da46560c', '1', '张三', '2020-08-18 09:56:07', null, null, '0', 'f1fa52932c244c078095701a287dc869');
INSERT INTO `tbl_customer_remark` VALUES ('9d1e65e61d3e47058580e48410a4fc8f', '32', '张三', '2020-08-18 09:56:30', null, null, '0', 'f1fa52932c244c078095701a287dc869');
INSERT INTO `tbl_customer_remark` VALUES ('b8b0cb9a285f489da2da19aa0852b285', '2', '张三', '2020-08-21 09:24:11', null, null, '0', '2b899e69c46541e580a57d7211552468');
INSERT INTO `tbl_customer_remark` VALUES ('c339ef37422446eb892c88910717e2fa', '王企鹅1', '张三', '2020-08-17 20:54:17', null, null, '0', '023793ab92ee4b4a91f00b7f48400ddb');
INSERT INTO `tbl_customer_remark` VALUES ('dfed5d6a12204bfd9427ebbc5631402b', '12312412414212412412412', '张三', '2020-08-17 20:54:17', null, null, '0', '023793ab92ee4b4a91f00b7f48400ddb');

-- ----------------------------
-- Table structure for `tbl_dic_type`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dic_type`;
CREATE TABLE `tbl_dic_type` (
  `code` varchar(255) NOT NULL COMMENT '编码是主键，不能为空，不能含有中文。',
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_dic_type
-- ----------------------------
INSERT INTO `tbl_dic_type` VALUES ('appellation', '称呼', '');
INSERT INTO `tbl_dic_type` VALUES ('clueState', '线索状态', '');
INSERT INTO `tbl_dic_type` VALUES ('returnPriority', '回访优先级', '');
INSERT INTO `tbl_dic_type` VALUES ('returnState', '回访状态', '');
INSERT INTO `tbl_dic_type` VALUES ('source', '来源', '');
INSERT INTO `tbl_dic_type` VALUES ('stage', '阶段', '');
INSERT INTO `tbl_dic_type` VALUES ('transactionType', '交易类型', '');

-- ----------------------------
-- Table structure for `tbl_dic_value`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dic_value`;
CREATE TABLE `tbl_dic_value` (
  `id` char(32) NOT NULL COMMENT '主键，采用UUID',
  `value` varchar(255) DEFAULT NULL COMMENT '不能为空，并且要求同一个字典类型下字典值不能重复，具有唯一性。',
  `text` varchar(255) DEFAULT NULL COMMENT '可以为空',
  `orderNo` varchar(255) DEFAULT NULL COMMENT '可以为空，但不为空的时候，要求必须是正整数',
  `typeCode` varchar(255) DEFAULT NULL COMMENT '外键',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_dic_value
-- ----------------------------
INSERT INTO `tbl_dic_value` VALUES ('06e3cbdf10a44eca8511dddfc6896c55', '虚假线索', '虚假线索', '4', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('0fe33840c6d84bf78df55d49b169a894', '销售邮件', '销售邮件', '8', 'source');
INSERT INTO `tbl_dic_value` VALUES ('12302fd42bd349c1bb768b19600e6b20', '交易会', '交易会', '11', 'source');
INSERT INTO `tbl_dic_value` VALUES ('1615f0bb3e604552a86cde9a2ad45bea', '最高', '最高', '2', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('176039d2a90e4b1a81c5ab8707268636', '教授', '教授', '5', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('1e0bd307e6ee425599327447f8387285', '将来联系', '将来联系', '2', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('2173663b40b949ce928db92607b5fe57', '丢失线索', '丢失线索', '5', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('2876690b7e744333b7f1867102f91153', '未启动', '未启动', '1', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('29805c804dd94974b568cfc9017b2e4c', '07成交', '07成交', '7', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('310e6a49bd8a4962b3f95a1d92eb76f4', '试图联系', '试图联系', '1', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('31539e7ed8c848fc913e1c2c93d76fd1', '博士', '博士', '4', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('37ef211719134b009e10b7108194cf46', '01资质审查', '01资质审查', '1', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('391807b5324d4f16bd58c882750ee632', '08丢失的线索', '08丢失的线索', '8', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('3a39605d67da48f2a3ef52e19d243953', '聊天', '聊天', '14', 'source');
INSERT INTO `tbl_dic_value` VALUES ('474ab93e2e114816abf3ffc596b19131', '低', '低', '3', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('48512bfed26145d4a38d3616e2d2cf79', '广告', '广告', '1', 'source');
INSERT INTO `tbl_dic_value` VALUES ('4d03a42898684135809d380597ed3268', '合作伙伴研讨会', '合作伙伴研讨会', '9', 'source');
INSERT INTO `tbl_dic_value` VALUES ('59795c49896947e1ab61b7312bd0597c', '先生', '先生', '1', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('5c6e9e10ca414bd499c07b886f86202a', '高', '高', '1', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('67165c27076e4c8599f42de57850e39c', '夫人', '夫人', '2', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('68a1b1e814d5497a999b8f1298ace62b', '09因竞争丢失关闭', '09因竞争丢失关闭', '9', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('6b86f215e69f4dbd8a2daa22efccf0cf', 'web调研', 'web调研', '13', 'source');
INSERT INTO `tbl_dic_value` VALUES ('72f13af8f5d34134b5b3f42c5d477510', '合作伙伴', '合作伙伴', '6', 'source');
INSERT INTO `tbl_dic_value` VALUES ('7c07db3146794c60bf975749952176df', '未联系', '未联系', '6', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('86c56aca9eef49058145ec20d5466c17', '内部研讨会', '内部研讨会', '10', 'source');
INSERT INTO `tbl_dic_value` VALUES ('9095bda1f9c34f098d5b92fb870eba17', '进行中', '进行中', '3', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('954b410341e7433faa468d3c4f7cf0d2', '已有业务', '已有业务', '1', 'transactionType');
INSERT INTO `tbl_dic_value` VALUES ('966170ead6fa481284b7d21f90364984', '已联系', '已联系', '3', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('96b03f65dec748caa3f0b6284b19ef2f', '推迟', '推迟', '2', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('97d1128f70294f0aac49e996ced28c8a', '新业务', '新业务', '2', 'transactionType');
INSERT INTO `tbl_dic_value` VALUES ('9ca96290352c40688de6596596565c12', '完成', '完成', '4', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('9e6d6e15232549af853e22e703f3e015', '需要条件', '需要条件', '7', 'clueState');
INSERT INTO `tbl_dic_value` VALUES ('9ff57750fac04f15b10ce1bbb5bb8bab', '02需求分析', '02需求分析', '2', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('a70dc4b4523040c696f4421462be8b2f', '等待某人', '等待某人', '5', 'returnState');
INSERT INTO `tbl_dic_value` VALUES ('a83e75ced129421dbf11fab1f05cf8b4', '推销电话', '推销电话', '2', 'source');
INSERT INTO `tbl_dic_value` VALUES ('ab8472aab5de4ae9b388b2f1409441c1', '常规', '常规', '5', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('ab8c2a3dc05f4e3dbc7a0405f721b040', '05提案/报价', '05提案/报价', '5', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('b924d911426f4bc5ae3876038bc7e0ad', 'web下载', 'web下载', '12', 'source');
INSERT INTO `tbl_dic_value` VALUES ('c13ad8f9e2f74d5aa84697bb243be3bb', '03价值建议', '03价值建议', '3', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('c83c0be184bc40708fd7b361b6f36345', '最低', '最低', '4', 'returnPriority');
INSERT INTO `tbl_dic_value` VALUES ('db867ea866bc44678ac20c8a4a8bfefb', '员工介绍', '员工介绍', '3', 'source');
INSERT INTO `tbl_dic_value` VALUES ('e44be1d99158476e8e44778ed36f4355', '04确定决策者', '04确定决策者', '4', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('e5f383d2622b4fc0959f4fe131dafc80', '女士', '女士', '3', 'appellation');
INSERT INTO `tbl_dic_value` VALUES ('e81577d9458f4e4192a44650a3a3692b', '06谈判/复审', '06谈判/复审', '6', 'stage');
INSERT INTO `tbl_dic_value` VALUES ('fb65d7fdb9c6483db02713e6bc05dd19', '在线商场', '在线商场', '5', 'source');
INSERT INTO `tbl_dic_value` VALUES ('fd677cc3b5d047d994e16f6ece4d3d45', '公开媒介', '公开媒介', '7', 'source');
INSERT INTO `tbl_dic_value` VALUES ('ff802a03ccea4ded8731427055681d48', '外部介绍', '外部介绍', '4', 'source');

-- ----------------------------
-- Table structure for `tbl_tran`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran`;
CREATE TABLE `tbl_tran` (
  `id` char(32) NOT NULL,
  `money` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `owner` char(32) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `expectedDate` char(10) DEFAULT NULL,
  `customerId` char(32) DEFAULT NULL,
  `stage` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `activityId` char(32) DEFAULT NULL,
  `contactsId` char(32) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `contactSummary` varchar(255) DEFAULT NULL,
  `nextContactTime` char(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_tran
-- ----------------------------
INSERT INTO `tbl_tran` VALUES ('0f9869a6f8e942c8a66ecba0b1faafc8', '100000000', '40f6cdea0bd34aceb77492a1656d9fb3', '收购计划', '2020-09-05', '87fe9c4a696846aa985c138ef51dee0e', '01资质审查', '新业务', '合作伙伴研讨会', 'b19cb21bb2aa42b190ff0a8261cdda3f', '66bd0e8f41494e3896542b618035f61e', '张三', '2020-08-22 09:34:24', null, null, '暂未发起', '不可能', '2020-08-31');
INSERT INTO `tbl_tran` VALUES ('314005966b0f45b1baac05a047eadddb', '50', '40f6cdea0bd34aceb77492a1656d9fb3', '李四', '2020-08-26', 'e47beed47a774728b96f9668ac8d010f', '03价值建议', '已有业务', '交易会', 'b19cb21bb2aa42b190ff0a8261cdda3f', 'c4679e6b5ca44e859bcdad88b3a77788', '张三', '2020-08-21 17:01:18', '张三', '2020-08-21 17:01:42', '123', null, '2020-08-29');
INSERT INTO `tbl_tran` VALUES ('925ce9e0aa904357abb08243eb5a0670', '15000', '40f6cdea0bd34aceb77492a1656d9fb3', '李四', '2020-08-08', 'e47beed47a774728b96f9668ac8d010f', '07成交', '已有业务', '员工介绍', '5f00fbe847b4467ba39a23619280213d', '17dbaf15577140bda3c224b80f31a507', '张三', '2020-08-21 21:18:52', null, null, '222', '333', '2020-08-29');
INSERT INTO `tbl_tran` VALUES ('a4a6a378158d43b6b35b6f192eccb2b1', '1', '40f6cdea0bd34aceb77492a1656d9fb3', '阿里', '2020-08-29', '87fe9c4a696846aa985c138ef51dee0e', '02需求分析', '新业务', 'web下载', '5f00fbe847b4467ba39a23619280213d', '17dbaf15577140bda3c224b80f31a507', '张三', '2020-08-20 20:18:41', '张三', '2020-08-21 16:13:06', '11', null, '2020-08-29');
INSERT INTO `tbl_tran` VALUES ('f1fa52932c244c078095701a287dc863', '1200', '40f6cdea0bd34aceb77492a1656d9fb3', '朱俊良的交易3', '2020-08-28', '2a1e3572039c49609350889646e53c10', '02需求分析', '已有业务', '内部研讨会', 'b19cb21bb2aa42b190ff0a8261cdda3f', '17dbaf15577140bda3c224b80f31a507', null, null, '张三', '2020-08-21 17:17:03', '1', null, '1899-12-30');

-- ----------------------------
-- Table structure for `tbl_tran_history`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran_history`;
CREATE TABLE `tbl_tran_history` (
  `id` char(32) NOT NULL,
  `stage` varchar(255) DEFAULT NULL,
  `money` varchar(255) DEFAULT NULL,
  `expectedDate` char(10) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `tranId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_tran_history
-- ----------------------------
INSERT INTO `tbl_tran_history` VALUES ('1167f48e1fad4373bc0d8b9ebbc18cc0', '04确定决策者', '100000000', '2020-08-29', '2020-08-21 13:52:54', '张三', 'a6dde827d7e948528e1b94379333774d');
INSERT INTO `tbl_tran_history` VALUES ('234b80444a384d8b9b6659a798fea17c', '03价值建议', '100000000', '2020-08-29', '2020-08-21 13:52:43', '张三', 'a6dde827d7e948528e1b94379333774d');
INSERT INTO `tbl_tran_history` VALUES ('3eeaeee7923941fd83010f16ab4d0f8c', '06谈判/复审', '100000000', '2020-08-29', '2020-08-21 13:53:53', '张三', 'a6dde827d7e948528e1b94379333774d');
INSERT INTO `tbl_tran_history` VALUES ('42a46360457b41ee8a2dd5182209dff6', '02需求分析', '100000000', '2020-08-29', '2020-08-21 13:54:10', '张三', 'a6dde827d7e948528e1b94379333774d');
INSERT INTO `tbl_tran_history` VALUES ('4519a1c764e74854a4d098bfff7a3c6e', '03价值建议', '15000', '2020-08-28', '2020-08-17 16:45:42', '张三', '14130a8f59524d8e83d469c02e4f960d');
INSERT INTO `tbl_tran_history` VALUES ('5666e02b36394346b2aa457d2517cb9a', '02需求分析', '15000', '2020-08-29', '2020-08-20 20:18:41', '张三', 'a4a6a378158d43b6b35b6f192eccb2b1');
INSERT INTO `tbl_tran_history` VALUES ('5698c57f97c54f56b732ea066503e7aa', '04确定决策者', '100000000', '2020-08-29', '2020-08-21 16:21:35', '张三', 'a6dde827d7e948528e1b94379333774d');
INSERT INTO `tbl_tran_history` VALUES ('ab15e84dda154774b424579a29d1fe3c', '03价值建议', '50', '2020-08-26', '2020-08-21 17:01:18', '张三', '314005966b0f45b1baac05a047eadddb');
INSERT INTO `tbl_tran_history` VALUES ('ba3d45dd7f68494c9fd1e25899177a43', '07成交', '15000', '2020-08-08', '2020-08-21 21:18:52', '张三', '925ce9e0aa904357abb08243eb5a0670');
INSERT INTO `tbl_tran_history` VALUES ('c03dec4e134d47c99725bced6da63c85', '02需求分析', '100000000', '2020-08-29', '2020-08-20 20:19:51', '张三', 'a6dde827d7e948528e1b94379333774d');
INSERT INTO `tbl_tran_history` VALUES ('dc7312bc4a784240b17bd8088ee2aea4', '07成交', '100000000', '2020-08-29', '2020-08-21 13:54:54', '张三', 'a6dde827d7e948528e1b94379333774d');
INSERT INTO `tbl_tran_history` VALUES ('e6d9d8a0accb4f1aac95dcd159061b41', '01资质审查', '100000000', '2020-09-05', '2020-08-22 09:34:24', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');

-- ----------------------------
-- Table structure for `tbl_tran_remark`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tran_remark`;
CREATE TABLE `tbl_tran_remark` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editFlag` char(1) DEFAULT NULL,
  `tranId` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_tran_remark
-- ----------------------------
INSERT INTO `tbl_tran_remark` VALUES ('cbdc82a867a04c0581ad08d88c31389b', '122', '张三', '2020-08-20 22:38:32', '张三', '2020-08-20 22:38:34', '1', 'a6dde827d7e948528e1b94379333774d');
INSERT INTO `tbl_tran_remark` VALUES ('f20a24caac2444edae8f2f7a6c905840', '2', '张三', '2020-08-20 22:38:27', null, null, '0', 'a6dde827d7e948528e1b94379333774d');

-- ----------------------------
-- Table structure for `tbl_user`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user` (
  `id` char(32) NOT NULL COMMENT 'uuid\r\n            ',
  `loginAct` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `loginPwd` varchar(255) DEFAULT NULL COMMENT '密码不能采用明文存储，采用密文，MD5加密之后的数据',
  `email` varchar(255) DEFAULT NULL,
  `expireTime` char(19) DEFAULT NULL COMMENT '失效时间为空的时候表示永不失效，失效时间为2018-10-10 10:10:10，则表示在该时间之前该账户可用。',
  `lockState` char(1) DEFAULT NULL COMMENT '锁定状态为空时表示启用，为0时表示锁定，为1时表示启用。',
  `deptno` char(4) DEFAULT NULL,
  `allowIps` varchar(255) DEFAULT NULL COMMENT '允许访问的IP为空时表示IP地址永不受限，允许访问的IP可以是一个，也可以是多个，当多个IP地址的时候，采用半角逗号分隔。允许IP是192.168.100.2，表示该用户只能在IP地址为192.168.100.2的机器上使用。',
  `createTime` char(19) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `editTime` char(19) DEFAULT NULL,
  `editBy` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_user
-- ----------------------------
INSERT INTO `tbl_user` VALUES ('06f5fc056eac41558a964f96daa7f27c', 'ls', '李四', '202cb962ac59075b964b07152d234b70', 'ls@163.com', '2018-11-27 21:50:05', '1', 'A001', '192.168.1.1', '2018-11-22 12:11:40', '李四', null, null);
INSERT INTO `tbl_user` VALUES ('40f6cdea0bd34aceb77492a1656d9fb3', 'zs', '张三', '202cb962ac59075b964b07152d234b70', 'zs@qq.com', '2020-11-30 23:50:55', '1', 'A001', '192.168.1.1,192.168.1.2,127.0.0.1', '2018-11-22 11:37:34', '张三', null, null);
