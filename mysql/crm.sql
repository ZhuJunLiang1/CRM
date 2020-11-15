/*
Navicat MySQL Data Transfer

Source Server         : 8.0-3306
Source Server Version : 80019
Source Host           : localhost:3306
Source Database       : crm

Target Server Type    : MYSQL
Target Server Version : 80019
File Encoding         : 65001

Date: 2020-11-15 16:30:25
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
INSERT INTO `tbl_activity` VALUES ('16a76c82f5b34cf1976c755a0d6f1859', '40f6cdea0bd34aceb77492a1656d9fb3', '客户交流会', '2020-09-26', '2020-11-13', '2000', '客户交流会', '2020-09-23 17:12:59', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('2fb475f55ed044739d38fab9f5111d43', '40f6cdea0bd34aceb77492a1656d9fb3', '公司年会', '2021-01-15', '2021-02-19', '50000', '公司年会', '2020-09-23 17:14:59', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('5f005649c5a94a9fb7d05e83edd1b32d', '40f6cdea0bd34aceb77492a1656d9fb3', '客户答谢会', '2020-09-07', '2020-10-02', '20000', '客户答谢会', '2020-09-23 17:14:44', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('6dd97f7759814f6c841b840ccecf3df4', '40f6cdea0bd34aceb77492a1656d9fb3', '行业交流会', '2020-09-09', '2020-09-26', '50000', '行业交流会', '2020-09-23 17:15:27', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('8bf851fd22fe4d3f9791d8f783ff0fd6', '40f6cdea0bd34aceb77492a1656d9fb3', '新产品发布会', '2020-09-01', '2020-09-26', '60000', '产品发布会', '2020-09-23 17:13:42', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('97ca00ebbd944c6fb9e16b316a16a570', '40f6cdea0bd34aceb77492a1656d9fb3', '产品体验会', '2020-09-02', '2020-09-19', '50000', '产品体验会', '2020-09-23 17:14:26', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('b385b9b904cb4cb5b9306d86045b1f43', '40f6cdea0bd34aceb77492a1656d9fb3', '研讨会', '2020-09-14', '2020-09-19', '1000', '市场研讨会', '2020-09-23 17:12:39', '张三', null, null);
INSERT INTO `tbl_activity` VALUES ('e09a889645294c5f962e25e9d0af1978', '40f6cdea0bd34aceb77492a1656d9fb3', '演示会', '2020-09-08', '2020-09-18', '5000', '产品演示会', '2020-09-23 17:13:22', '张三', null, null);

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
INSERT INTO `tbl_activity_remark` VALUES ('374cb82140d64c709a872f699ebc272e', '222', '2020-11-03 15:33:28', '张三', null, null, '0', '6dd97f7759814f6c841b840ccecf3df4');
INSERT INTO `tbl_activity_remark` VALUES ('3ad2c46864e048329b94794d1f968c4b', '这是行业交流会，你好', '2020-10-07 15:30:07', '张三', null, null, '0', '6dd97f7759814f6c841b840ccecf3df4');

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
INSERT INTO `tbl_clue` VALUES ('47c2d48b45644ac794283d4c33510a76', '张一鸣', '先生', '40f6cdea0bd34aceb77492a1656d9fb3', '北京字节跳动科技有限公司', 'CEO', 'zhangyiming@163.com', 'bd@bytedance.com', 'www.bytedance.com', 'bd@bytedance.com', '试图联系', '合作伙伴', '张三', '2020-09-23 18:22:49', null, null, '北京字节跳动科技有限公司', '北京字节跳动科技有限公司', '2020-10-03', '北京市海淀区知春路甲48号2号楼10A室');
INSERT INTO `tbl_clue` VALUES ('62f897dbf33e4d60ae97b498a7ab0b43', '丁磊', '先生', '40f6cdea0bd34aceb77492a1656d9fb3', '网易公司', 'CEO', 'dinglei@163.com', '(+8610)-82558163', 'www.163.com', '(+8610)-82558163', '将来联系', '广告', '张三', '2020-09-23 18:29:07', null, null, '网易', '网易', '2020-10-10', '北京市海淀区西北旺东路10号院 中关村软件园二期西区7号');
INSERT INTO `tbl_clue` VALUES ('c2cc958bd3324056b00131c3e8ad351b', '马化腾', '先生', '40f6cdea0bd34aceb77492a1656d9fb3', '腾讯集团', 'CEO', 'mahuateng@163.com', '83765566', 'www.tencent.com', '83765566', '试图联系', '广告', '张三', '2020-09-23 18:14:05', null, null, '腾讯集团', '腾讯集团', '2020-09-26', '深圳市高新科技园南区高新南一道飞亚达高科技大厦3-10层');
INSERT INTO `tbl_clue` VALUES ('c7930cdf1f17434faae9f2e054aa720f', '王健林', '先生', '40f6cdea0bd34aceb77492a1656d9fb3', '中国万达集团', 'CEO', 'wangjianlin.@163.com', '010-85853216', 'www.wanda.cn', '010-85853216', '将来联系', '外部介绍', '张三', '2020-09-23 18:16:17', '张三', '2020-09-23 18:23:21', '万达集团', '万达集团', '2020-12-25', '北京市朝阳区建国路93号万达广场B座17层');
INSERT INTO `tbl_clue` VALUES ('d111f934f5cd4ed5b89b8ef3faef535e', '马云', '先生', '40f6cdea0bd34aceb77492a1656d9fb3', '阿里巴巴网络技术有限公司', 'CEO', 'mayun@163.com', '571-8502-2088', 'www.alibaba.com', '571-8502-2088', '试图联系', '内部研讨会', '张三', '2020-09-23 18:10:44', '张三', '2020-09-23 18:24:52', '阿里巴巴', '阿里巴巴', '2020-09-26', '中国浙江省杭州市余杭区文一西路969号 (311121)');
INSERT INTO `tbl_clue` VALUES ('d9ae864658bd41c9a4520355895b8169', '余承东', '先生', '40f6cdea0bd34aceb77492a1656d9fb3', '华为技术有限公司', 'CEO', 'yvchengdong@163.com', '400-822-9999', 'www.huawei.com', '400-822-9999', '将来联系', '公开媒介', '张三', '2020-09-23 18:18:40', '张三', '2020-09-23 18:23:08', '华为', '华为', '2020-09-26', '深圳市龙岗区坂田华为基地');
INSERT INTO `tbl_clue` VALUES ('de3d211c58584b5782969252e430e82f', 'Larry Ellison', '先生', '40f6cdea0bd34aceb77492a1656d9fb3', 'Oracle', 'CEO', 'Larry Ellison@163.com', '86-10-6106 6000', 'www.oracle.com', '86-10-6106 6000', '未联系', '合作伙伴', '张三', '2020-09-23 18:31:28', null, null, 'Oracle', 'Oracle', '2020-10-02', '北京市海淀区中关村软件园24号楼甲骨文大厦');
INSERT INTO `tbl_clue` VALUES ('f0fbd45c503c46189be46add3bb888f7', '李彦宏', '先生', '40f6cdea0bd34aceb77492a1656d9fb3', '百度公司', 'CEO', 'liyanhong@163.com', '(+86 10)5992 8888', 'home.baidu.com', '(+86 10)5992 8888', '将来联系', 'web下载', '张三', '2020-09-23 18:27:08', null, null, '百度公司', '百度公司', '2020-09-05', '北京市海淀区上地十街10号百度大厦');

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
INSERT INTO `tbl_clue_activity_relation` VALUES ('212b079f425543a5b38ffe632a275357', '47c2d48b45644ac794283d4c33510a76', '6dd97f7759814f6c841b840ccecf3df4');
INSERT INTO `tbl_clue_activity_relation` VALUES ('28cec9ec22024365975be042f9b24c9c', '62f897dbf33e4d60ae97b498a7ab0b43', '2fb475f55ed044739d38fab9f5111d43');
INSERT INTO `tbl_clue_activity_relation` VALUES ('47d9b37640dc4760ad217c3d3eb804ba', 'f0fbd45c503c46189be46add3bb888f7', '5f005649c5a94a9fb7d05e83edd1b32d');
INSERT INTO `tbl_clue_activity_relation` VALUES ('4ef3abfac25f4630a09fc3f0c770439d', '119af41abed541edbe6a65b8ecaf0615', '13835471d7df4fbb9ecf8c3c41c0348a');
INSERT INTO `tbl_clue_activity_relation` VALUES ('6cff138c955445ebb3d8273979eb29cf', '04664d7beb094887af883acfcbe297d6', '5f00fbe847b4467ba39a23619280213d');
INSERT INTO `tbl_clue_activity_relation` VALUES ('707cfdaa4a8b4854a10d18a4aa557014', '5ea5974e55f64a70ac6173da084bb396', '974267315b38483ba8fb50bfb34bb019');
INSERT INTO `tbl_clue_activity_relation` VALUES ('8cde573b8e9f4857ae4f577c6cc0e012', '04664d7beb094887af883acfcbe297d6', '974267315b38483ba8fb50bfb34bb019');
INSERT INTO `tbl_clue_activity_relation` VALUES ('8ce22395910a49f78100509c3f4fadbc', '63ca509fdee442a7b8614acb26bfe27d', '6565ce0e3fb841b09ed553cb9facfd4b');
INSERT INTO `tbl_clue_activity_relation` VALUES ('900efa5c6a35434d9ffc610e780f07ca', '3dc1d33590304788837a9cec7a6bdd91', '6565ce0e3fb841b09ed553cb9facfd4b');
INSERT INTO `tbl_clue_activity_relation` VALUES ('91fa8cdaced140f8b2c2d2aa0ded9444', '5ea5974e55f64a70ac6173da084bb396', 'b19cb21bb2aa42b190ff0a8261cdda3f');
INSERT INTO `tbl_clue_activity_relation` VALUES ('9d6d345ae79c4bb3879709c228de2763', 'd111f934f5cd4ed5b89b8ef3faef535e', 'e09a889645294c5f962e25e9d0af1978');
INSERT INTO `tbl_clue_activity_relation` VALUES ('ae8398903d8c4b24bbd491d69b6fb3f1', 'c2cc958bd3324056b00131c3e8ad351b', 'b385b9b904cb4cb5b9306d86045b1f43');
INSERT INTO `tbl_clue_activity_relation` VALUES ('c3669781a76b48f58ded390f351330e3', 'd9ae864658bd41c9a4520355895b8169', '8bf851fd22fe4d3f9791d8f783ff0fd6');
INSERT INTO `tbl_clue_activity_relation` VALUES ('d29515d45d564563ba6fc81e9ac2ceb5', '3dc1d33590304788837a9cec7a6bdd91', 'b19cb21bb2aa42b190ff0a8261cdda3f');
INSERT INTO `tbl_clue_activity_relation` VALUES ('d9a14eeaa72b4e709d73e6e6f5da56c7', 'c7930cdf1f17434faae9f2e054aa720f', '97ca00ebbd944c6fb9e16b316a16a570');
INSERT INTO `tbl_clue_activity_relation` VALUES ('e3f5c8c3ffd14d0a80f59e82601daa84', 'de3d211c58584b5782969252e430e82f', '16a76c82f5b34cf1976c755a0d6f1859');
INSERT INTO `tbl_clue_activity_relation` VALUES ('ee5af0aebe1e4a81867a1a04e426d485', '04664d7beb094887af883acfcbe297d6', '6b2fb343b6e848499f6c736526f7c28f');

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
INSERT INTO `tbl_clue_remark` VALUES ('06c81b23f122425da412369f6df678ca', '321', '张三', '2020-08-16 17:41:14', null, null, '0', '');
INSERT INTO `tbl_clue_remark` VALUES ('4c67c9c4e0b24e31bf8934cade3ec5b3', '腾讯', '张三', '2020-09-23 18:33:53', null, null, '0', 'c2cc958bd3324056b00131c3e8ad351b');
INSERT INTO `tbl_clue_remark` VALUES ('607dcc90e4234b7a9b0bc42c6e64674b', '字节跳动', '张三', '2020-09-23 18:33:09', null, null, '0', '47c2d48b45644ac794283d4c33510a76');
INSERT INTO `tbl_clue_remark` VALUES ('60ff4f2358f446789b2edc33ff7bfd3a', '阿里巴巴', '张三', '2020-09-23 18:34:05', null, null, '0', 'd111f934f5cd4ed5b89b8ef3faef535e');
INSERT INTO `tbl_clue_remark` VALUES ('b7cb1859e97249f3a62da3e8b5c45fc7', '网易', '张三', '2020-09-23 18:32:28', null, null, '0', '62f897dbf33e4d60ae97b498a7ab0b43');
INSERT INTO `tbl_clue_remark` VALUES ('c80eb3719ba44495869a4d230e60cede', '3131', '张三', '2020-08-16 17:41:17', null, null, '0', '');
INSERT INTO `tbl_clue_remark` VALUES ('d7ce20a0eee44627b2d33ee43d9a684b', '华为', '张三', '2020-09-23 18:33:23', null, null, '0', 'd9ae864658bd41c9a4520355895b8169');
INSERT INTO `tbl_clue_remark` VALUES ('f2982030cc674b41ad40dc2ecfae9e28', '万达', '张三', '2020-09-23 18:33:39', null, null, '0', 'c7930cdf1f17434faae9f2e054aa720f');
INSERT INTO `tbl_clue_remark` VALUES ('f4e148cf24054813b5dc497817a8f2a8', 'Oracle', '张三', '2020-09-23 18:32:11', null, null, '0', 'de3d211c58584b5782969252e430e82f');
INSERT INTO `tbl_clue_remark` VALUES ('fc556cda542d484dac7787e5f50249f0', '百度', '张三', '2020-09-23 18:32:46', null, null, '0', 'f0fbd45c503c46189be46add3bb888f7');

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
INSERT INTO `tbl_contacts` VALUES ('17dbaf15577140bda3c224b80f31a507', '40f6cdea0bd34aceb77492a1656d9fb3', 'web调研', '2b899e69c46541e580a57d7211552468', '朱俊良12312', '夫人', 'zhujunliang0831@163.com', '13849171575', 'CEO', '2020-08-13', '张三', '2020-08-19 17:11:28', '张三', '2020-08-19 20:55:29', '31232', '123121', '1231', '13221');
INSERT INTO `tbl_contacts` VALUES ('371771c371e14716910268906d53966c', '40f6cdea0bd34aceb77492a1656d9fb3', '合作伙伴', 'e47beed47a774728b96f9668ac8d010f', 'Jack', '先生', 'Jack.com', '123', 'CEO', '2020-08-29', '张三', '2020-08-22 08:37:23', null, null, '123', '123', '2020-08-29', '123');
INSERT INTO `tbl_contacts` VALUES ('574ce309c4af4e24b91478e0a19a4d18', '40f6cdea0bd34aceb77492a1656d9fb3', '交易会', 'e47beed47a774728b96f9668ac8d010f', 'Cris', '先生', '11', '111', '11', '2020-08-22', '张三', '2020-08-21 16:39:41', '张三', '2020-08-22 08:37:36', '22', '22', '1899-12-23', '222');
INSERT INTO `tbl_contacts` VALUES ('66bd0e8f41494e3896542b618035f61e', '40f6cdea0bd34aceb77492a1656d9fb3', '聊天', '87fe9c4a696846aa985c138ef51dee0e', '马云', '先生', 'mayun.com', '123', 'CEO', '2020-08-20', '张三', '2020-08-22 08:30:45', null, null, '123', '124', '2020-08-21', '1421312');
INSERT INTO `tbl_contacts` VALUES ('873deb8138ad40559b3fb6a38f838ee4', '40f6cdea0bd34aceb77492a1656d9fb3', 'web调研', '2b899e69c46541e580a57d7211552468', '朱俊良', '', '', '', '', null, '张三', '2020-09-23 15:09:00', null, null, '', '', '', '');
INSERT INTO `tbl_contacts` VALUES ('9a755b0a01f54e398761cf4953655296', '40f6cdea0bd34aceb77492a1656d9fb3', 'web调研', '4549dc3d27c14be69c8d7ed063d84d01', '李彦宏', '夫人', '', '513', '123', '2020-09-26', '张三', '2020-09-23 14:18:15', '张三', '2020-09-23 15:07:31', '', '', '', '');
INSERT INTO `tbl_contacts` VALUES ('afec400c24604dcaaae63909a4e9de42', '40f6cdea0bd34aceb77492a1656d9fb3', '交易会', '2d98884b21df467f961e308cd3475ed8', '111111', '夫人', '1111111', '1111111', '11111', null, '张三', '2020-09-23 15:59:20', null, null, '1', '1', '2020-09-26', '111');
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
INSERT INTO `tbl_contacts_activity_relation` VALUES ('0502fafef2d9401083965faa58f361f3', '873deb8138ad40559b3fb6a38f838ee4', 'b19cb21bb2aa42b190ff0a8261cdda3f');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('051294907fb3486f969ffb2d0d57ff4c', '17dbaf15577140bda3c224b80f31a507', '6565ce0e3fb841b09ed553cb9facfd4b');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('0584b97ae9b24588a4e9162ba3764686', '9a755b0a01f54e398761cf4953655296', '974267315b38483ba8fb50bfb34bb019');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('07c828dabbb94d9c8553718d7d143602', '07c828dabbb94d9c8553718d7d143636', '6565ce0e3fb841b09ed553cb9facfd4b');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('07c828dabbb94d9c8553718d7d143603', '07c828dabbb94d9c8553718d7d143636', '5f00fbe847b4467ba39a23619280213d');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('184342503cf54a55ad4f74f9b6bc7380', '873deb8138ad40559b3fb6a38f838ee4', '974267315b38483ba8fb50bfb34bb019');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('612e4fc7aeec44fb89774d51e74acc6f', 'c4679e6b5ca44e859bcdad88b3a77788', 'b19cb21bb2aa42b190ff0a8261cdda3f');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('62aeedd848e14948832e388d0b05a064', 'afec400c24604dcaaae63909a4e9de42', '2fb475f55ed044739d38fab9f5111d43');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('68934c52c8184c63a93b811c6933fd1e', 'fd245aad6d4341fd8c1ff2a65e79b95c', 'b19cb21bb2aa42b190ff0a8261cdda3f');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('6a77123858b840268f760611436c0b50', '9a755b0a01f54e398761cf4953655296', 'b19cb21bb2aa42b190ff0a8261cdda3f');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('768af4d2f2f44eb4816d0d1f4c1fc0e0', '9a755b0a01f54e398761cf4953655296', '6565ce0e3fb841b09ed553cb9facfd4b');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('d417b29806ed4a3c9ff5fa0cedbc2aa4', '9a755b0a01f54e398761cf4953655296', '974267315b38483ba8fb50bfb34bb019');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('d8a09d229f364e6dac33ae25df373f14', '9a755b0a01f54e398761cf4953655296', 'b19cb21bb2aa42b190ff0a8261cdda3f');
INSERT INTO `tbl_contacts_activity_relation` VALUES ('eb6a50ba178c4174942d1c17f0ad7064', '873deb8138ad40559b3fb6a38f838ee4', '6565ce0e3fb841b09ed553cb9facfd4b');

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
INSERT INTO `tbl_contacts_remark` VALUES ('00cee3b30f0247178430a841aff33be7', '111', '张三', '2020-10-07 20:23:14', null, null, '0', 'afec400c24604dcaaae63909a4e9de42');
INSERT INTO `tbl_contacts_remark` VALUES ('0313a5434e344fea8806b7895a40b2db', '43', '张三', '2020-09-23 15:09:00', null, null, '0', '873deb8138ad40559b3fb6a38f838ee4');
INSERT INTO `tbl_contacts_remark` VALUES ('06d1a9f2b49141e9a3f173acf270316c', '111', '张三', '2020-10-07 20:23:17', null, null, '0', 'afec400c24604dcaaae63909a4e9de42');
INSERT INTO `tbl_contacts_remark` VALUES ('1fbd495e3eb245ada26b43cfa69657ff', '456', '张三', '2020-08-20 09:13:55', null, null, '0', '07c828dabbb94d9c8553718d7d143636');
INSERT INTO `tbl_contacts_remark` VALUES ('3b28b67798e14a3dbeac1c2d15907c04', '1234', '张三', '2020-09-23 15:09:00', null, null, '0', '873deb8138ad40559b3fb6a38f838ee4');
INSERT INTO `tbl_contacts_remark` VALUES ('6ca0bd11365f4d5e964190a2b34d8440', '3', '张三', '2020-09-23 14:18:15', null, null, '0', '9a755b0a01f54e398761cf4953655296');
INSERT INTO `tbl_contacts_remark` VALUES ('9d0aca6e27384522b60a50141ac468d9', '20.0.', '张三', '2020-09-23 14:18:15', null, null, '0', '9a755b0a01f54e398761cf4953655296');
INSERT INTO `tbl_contacts_remark` VALUES ('c1cfb428add24e8ca2060618ea6036e5', '12312412414212412412412', '张三', '2020-08-17 20:54:17', null, null, '0', '0964a58518a34158bb022af9f1d21d69');
INSERT INTO `tbl_contacts_remark` VALUES ('e1a5db4160ee44699bbe80a6cff1a2aa', '恶31', '张三', '2020-09-23 15:09:00', null, null, '0', '873deb8138ad40559b3fb6a38f838ee4');
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
INSERT INTO `tbl_customer` VALUES ('2d98884b21df467f961e308cd3475ed8', '40f6cdea0bd34aceb77492a1656d9fb3', '1111111', '11111', '11111', '张三', '2020-09-23 15:59:20', null, null, '1', '2020-09-26', '1', '111');
INSERT INTO `tbl_customer` VALUES ('392928960d9e42e5848fab1f23f2f655', '40f6cdea0bd34aceb77492a1656d9fb3', '新建客户', null, null, '张三', '2020-09-23 15:06:15', null, null, '', '', null, null);
INSERT INTO `tbl_customer` VALUES ('4549dc3d27c14be69c8d7ed063d84d01', '40f6cdea0bd34aceb77492a1656d9fb3', '阿里', '', '123', '张三', '2020-09-23 14:18:15', null, null, '', '', '', '');
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
INSERT INTO `tbl_customer_remark` VALUES ('11239c05608f4482b190d7f4f76152a1', '恶31', '张三', '2020-09-23 15:09:00', null, null, '0', '2b899e69c46541e580a57d7211552468');
INSERT INTO `tbl_customer_remark` VALUES ('1690b6a846714648822b2d2f44d143e3', '321421421153', '张三', '2020-08-17 20:54:17', null, null, '0', '023793ab92ee4b4a91f00b7f48400ddb');
INSERT INTO `tbl_customer_remark` VALUES ('212b6c10560c448aa626760858932f70', '20.0.', '张三', '2020-09-23 14:18:15', null, null, '0', '4549dc3d27c14be69c8d7ed063d84d01');
INSERT INTO `tbl_customer_remark` VALUES ('56f486d9dea1461bb1306ac302c8deec', '2', '张三', '2020-08-18 09:56:08', null, null, '0', 'f1fa52932c244c078095701a287dc869');
INSERT INTO `tbl_customer_remark` VALUES ('5cc6710a7958477e99543028c8bac3f3', '43', '张三', '2020-09-23 15:09:00', null, null, '0', '2b899e69c46541e580a57d7211552468');
INSERT INTO `tbl_customer_remark` VALUES ('78d0abc75cfa4a7d9ac95f024e5e5bac', '1', '张三', '2020-08-17 20:54:17', null, null, '0', '023793ab92ee4b4a91f00b7f48400ddb');
INSERT INTO `tbl_customer_remark` VALUES ('7a6d3c9733884bf7935227e0da46560c', '1', '张三', '2020-08-18 09:56:07', null, null, '0', 'f1fa52932c244c078095701a287dc869');
INSERT INTO `tbl_customer_remark` VALUES ('9451684c34384ec0a9f7a15c9e172cc5', '123214', '张三', '2020-09-22 09:02:20', null, null, '0', 'ef9de174e4154968acf2b899ac02a03f');
INSERT INTO `tbl_customer_remark` VALUES ('9d1e65e61d3e47058580e48410a4fc8f', '32', '张三', '2020-08-18 09:56:30', null, null, '0', 'f1fa52932c244c078095701a287dc869');
INSERT INTO `tbl_customer_remark` VALUES ('a015e7aed7e54407aef98b19fbf87fbe', '3', '张三', '2020-09-23 14:02:37', null, null, '0', '87fe9c4a696846aa985c138ef51dee0e');
INSERT INTO `tbl_customer_remark` VALUES ('a573c2c99c0846409ad765d5de430d47', '3', '张三', '2020-09-23 14:18:15', null, null, '0', '4549dc3d27c14be69c8d7ed063d84d01');
INSERT INTO `tbl_customer_remark` VALUES ('b61cd07c692346d591ddca06e8ec17a4', '1234', '张三', '2020-09-23 15:09:00', null, null, '0', '2b899e69c46541e580a57d7211552468');
INSERT INTO `tbl_customer_remark` VALUES ('b8b0cb9a285f489da2da19aa0852b285', '2', '张三', '2020-08-21 09:24:11', null, null, '0', '2b899e69c46541e580a57d7211552468');
INSERT INTO `tbl_customer_remark` VALUES ('c339ef37422446eb892c88910717e2fa', '王企鹅1', '张三', '2020-08-17 20:54:17', null, null, '0', '023793ab92ee4b4a91f00b7f48400ddb');
INSERT INTO `tbl_customer_remark` VALUES ('cc70088dfaa64717bb19f5ca40c382ef', '1', '张三', '2020-11-14 18:24:18', null, null, '0', '2d98884b21df467f961e308cd3475ed8');
INSERT INTO `tbl_customer_remark` VALUES ('dfed5d6a12204bfd9427ebbc5631402b', '12312412414212412412412', '张三', '2020-08-17 20:54:17', null, null, '0', '023793ab92ee4b4a91f00b7f48400ddb');

-- ----------------------------
-- Table structure for `tbl_dept`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_dept`;
CREATE TABLE `tbl_dept` (
  `no` varchar(4) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `manager` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_dept
-- ----------------------------
INSERT INTO `tbl_dept` VALUES ('A001', '管理部', '张三', '010-66638', '公司管理部');
INSERT INTO `tbl_dept` VALUES ('A002', '销售部', '李四', '010-445566', '公司销售部');
INSERT INTO `tbl_dept` VALUES ('A003', '市场部', '123', '123', '132');

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
-- Table structure for `tbl_notice`
-- ----------------------------
DROP TABLE IF EXISTS `tbl_notice`;
CREATE TABLE `tbl_notice` (
  `id` char(32) NOT NULL,
  `noteContent` varchar(255) DEFAULT NULL,
  `createBy` varchar(255) DEFAULT NULL,
  `createTime` char(19) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_notice
-- ----------------------------
INSERT INTO `tbl_notice` VALUES ('07fa1e8dbda245be8ffedae2209e47c3', 'nihao', '张三', '2020-11-15 16:09:30');
INSERT INTO `tbl_notice` VALUES ('11cddb3a46e24e4f98c80a308a87a144', '明天公司放假一周。', '张三', '2020-11-04 20:49:07');
INSERT INTO `tbl_notice` VALUES ('2152a6c23ded48ef8a882499851e614d', '今天加班到晚上十点：望周知！', '张三', '2020-11-04 17:05:44');
INSERT INTO `tbl_notice` VALUES ('722f31ef9d864f338afa8a28dc063e52', '41241', '张三', '2020-11-04 17:11:19');
INSERT INTO `tbl_notice` VALUES ('79bfd14e7a004fc3a15ac4ab34d0c745', '31231', '张三', '2020-11-04 17:11:14');
INSERT INTO `tbl_notice` VALUES ('b0ce87e83f16452eb2d8bc068ca355fe', '3', '张三', '2020-11-04 17:01:10');
INSERT INTO `tbl_notice` VALUES ('bb84a058e9ef466d939cdb8f14c1d031', '2', '张三', '2020-11-04 17:00:22');
INSERT INTO `tbl_notice` VALUES ('dd1d41daf2a84f09a022856f2578510b', '321321', '张三', '2020-11-04 17:11:10');
INSERT INTO `tbl_notice` VALUES ('eec5ae75f2564bad8e1883bd786d4078', '12414', '张三', '2020-11-04 17:11:16');

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
INSERT INTO `tbl_tran` VALUES ('0f9869a6f8e942c8a66ecba0b1faafc8', '100000000', '40f6cdea0bd34aceb77492a1656d9fb3', '收购计划', '2020-09-05', '87fe9c4a696846aa985c138ef51dee0e', '05提案/报价', '新业务', '合作伙伴研讨会', 'b19cb21bb2aa42b190ff0a8261cdda3f', '66bd0e8f41494e3896542b618035f61e', '张三', '2020-08-22 09:34:24', '张三', '2020-09-23 14:27:37', '暂未发起1', null, '2020-08-31');
INSERT INTO `tbl_tran` VALUES ('314005966b0f45b1baac05a047eadddb', '50', '40f6cdea0bd34aceb77492a1656d9fb3', '李四', '2020-08-26', 'e47beed47a774728b96f9668ac8d010f', '03价值建议', '已有业务', '交易会', 'b19cb21bb2aa42b190ff0a8261cdda3f', 'c4679e6b5ca44e859bcdad88b3a77788', '张三', '2020-08-21 17:01:18', '张三', '2020-08-21 17:01:42', '123', null, '2020-08-29');
INSERT INTO `tbl_tran` VALUES ('7d2102bb10d346f5a67b50413346e5fc', '100000000', '40f6cdea0bd34aceb77492a1656d9fb3', '测试交易', '2020-11-06', '2d98884b21df467f961e308cd3475ed8', '02需求分析', '新业务', '广告', '2fb475f55ed044739d38fab9f5111d43', 'afec400c24604dcaaae63909a4e9de42', '张三', '2020-10-07 22:37:03', '张三', '2020-10-07 22:37:15', '测试交易', '测试交易', '2020-10-31');
INSERT INTO `tbl_tran` VALUES ('83173f66067a4e458f101e800505cb11', '1414147', '40f6cdea0bd34aceb77492a1656d9fb3', '李四', '2020-10-31', '392928960d9e42e5848fab1f23f2f655', '04确定决策者', '已有业务', '内部研讨会', 'b19cb21bb2aa42b190ff0a8261cdda3f', 'c4679e6b5ca44e859bcdad88b3a77788', '张三', '2020-09-23 15:06:15', null, null, '', '', '');
INSERT INTO `tbl_tran` VALUES ('925ce9e0aa904357abb08243eb5a0670', '15000', '40f6cdea0bd34aceb77492a1656d9fb3', '李四', '2020-08-08', 'e47beed47a774728b96f9668ac8d010f', '07成交', '已有业务', '员工介绍', '5f00fbe847b4467ba39a23619280213d', '17dbaf15577140bda3c224b80f31a507', '张三', '2020-08-21 21:18:52', null, null, '222', '333', '2020-08-29');
INSERT INTO `tbl_tran` VALUES ('a4a6a378158d43b6b35b6f192eccb2b1', '1', '40f6cdea0bd34aceb77492a1656d9fb3', '阿里', '2020-08-29', '87fe9c4a696846aa985c138ef51dee0e', '02需求分析', '新业务', 'web下载', '5f00fbe847b4467ba39a23619280213d', '17dbaf15577140bda3c224b80f31a507', '张三', '2020-08-20 20:18:41', '张三', '2020-08-21 16:13:06', '11', null, '2020-08-29');
INSERT INTO `tbl_tran` VALUES ('b18ac35056644ae3b99308599c722f18', '111111', '40f6cdea0bd34aceb77492a1656d9fb3', '11111', '1899-12-30', '2d98884b21df467f961e308cd3475ed8', '05提案/报价', '新业务', '交易会', 'b19cb21bb2aa42b190ff0a8261cdda3f', 'afec400c24604dcaaae63909a4e9de42', '张三', '2020-09-23 15:59:20', '张三', '2020-10-02 16:22:29', '1', null, '2020-09-26');
INSERT INTO `tbl_tran` VALUES ('e3217fd14f134da2b3a43256cd29d36d', '138491715', '40f6cdea0bd34aceb77492a1656d9fb3', 'wwww', '2020-09-30', '2b899e69c46541e580a57d7211552468', '04确定决策者', null, 'web调研', '6565ce0e3fb841b09ed553cb9facfd4b', '873deb8138ad40559b3fb6a38f838ee4', '张三', '2020-09-23 15:09:00', '张三', '2020-10-06 17:06:30', '', '', '');
INSERT INTO `tbl_tran` VALUES ('f1fa52932c244c078095701a287dc863', '1200', '40f6cdea0bd34aceb77492a1656d9fb3', '朱俊良的交易3', '2020-08-28', '2a1e3572039c49609350889646e53c10', '07成交', '已有业务', '内部研讨会', 'b19cb21bb2aa42b190ff0a8261cdda3f', '17dbaf15577140bda3c224b80f31a507', null, null, '张三', '2020-09-22 09:13:24', '1', null, '1899-12-30');

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
INSERT INTO `tbl_tran_history` VALUES ('07c3a5f0b46c429aa3b8fcbbee56e6c6', '05提案/报价', '100000000', '2020-09-05', '2020-09-21 10:20:06', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('0cc2c96c36824a4ebca558b79fb8fde3', '04确定决策者', '100000000', '2020-09-05', '2020-09-22 09:03:06', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('0dd4083ae44c4bca883c82812c087e1e', '05提案/报价', '100000000', '2020-09-05', '2020-09-22 09:03:20', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('1167f48e1fad4373bc0d8b9ebbc18cc0', '04确定决策者', '100000000', '2020-08-29', '2020-08-21 13:52:54', '张三', 'a6dde827d7e948528e1b94379333774d');
INSERT INTO `tbl_tran_history` VALUES ('12334e417cc14195a781314a042d4b92', '02需求分析', '100000000', '2020-11-06', '2020-10-07 22:37:15', '张三', '7d2102bb10d346f5a67b50413346e5fc');
INSERT INTO `tbl_tran_history` VALUES ('1427a35264234afe9acee98b734de3a6', '07成交', '111111', '1899-12-30', '2020-10-02 16:22:25', '张三', 'b18ac35056644ae3b99308599c722f18');
INSERT INTO `tbl_tran_history` VALUES ('14da09f85ce64fe59dc0e8336620abc7', '07成交', '1200', '2020-08-28', '2020-09-22 09:13:24', '张三', 'f1fa52932c244c078095701a287dc863');
INSERT INTO `tbl_tran_history` VALUES ('234b80444a384d8b9b6659a798fea17c', '03价值建议', '100000000', '2020-08-29', '2020-08-21 13:52:43', '张三', 'a6dde827d7e948528e1b94379333774d');
INSERT INTO `tbl_tran_history` VALUES ('2764c484558f49799fe1bca828cd4418', '04确定决策者', '100000000', '2020-09-05', '2020-09-22 09:03:20', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('29d0e3c084154cfb9da16342d9792818', '03价值建议', '100000000', '2020-09-05', '2020-09-21 10:20:09', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('29dfbaca78254f9db03d385b08ed4146', '07成交', '100000000', '2020-09-05', '2020-09-22 20:41:29', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('2a9d4bc72c1f4ce19e8333b722b3c854', '05提案/报价', '100000000', '2020-09-05', '2020-09-07 11:44:46', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('2e2729f7da804989b427955773f2be27', '07成交', '100000000', '2020-09-05', '2020-09-22 09:03:15', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('3edeece06ebd4f5dbc90ec9a096fe53e', '04确定决策者', '100000000', '2020-09-05', '2020-09-21 10:20:07', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('3eeaeee7923941fd83010f16ab4d0f8c', '06谈判/复审', '100000000', '2020-08-29', '2020-08-21 13:53:53', '张三', 'a6dde827d7e948528e1b94379333774d');
INSERT INTO `tbl_tran_history` VALUES ('402d9f32b05a498cb64c62962682cc86', '04确定决策者', '1200', '2020-08-28', '2020-09-22 09:13:17', '张三', 'f1fa52932c244c078095701a287dc863');
INSERT INTO `tbl_tran_history` VALUES ('42a46360457b41ee8a2dd5182209dff6', '02需求分析', '100000000', '2020-08-29', '2020-08-21 13:54:10', '张三', 'a6dde827d7e948528e1b94379333774d');
INSERT INTO `tbl_tran_history` VALUES ('4519a1c764e74854a4d098bfff7a3c6e', '03价值建议', '15000', '2020-08-28', '2020-08-17 16:45:42', '张三', '14130a8f59524d8e83d469c02e4f960d');
INSERT INTO `tbl_tran_history` VALUES ('4c9fbd2862bc4bec9ec35a6055cb8df3', '04确定决策者', '100000000', '2020-09-05', '2020-09-07 11:44:38', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('4ff114fc75ae49fe90f24f9d85632fd4', '07成交', '100000000', '2020-09-05', '2020-09-22 09:03:02', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('5666e02b36394346b2aa457d2517cb9a', '02需求分析', '15000', '2020-08-29', '2020-08-20 20:18:41', '张三', 'a4a6a378158d43b6b35b6f192eccb2b1');
INSERT INTO `tbl_tran_history` VALUES ('568b575faf2b4fb6a6524b781551181c', '06谈判/复审', '100000000', '2020-09-05', '2020-09-22 09:03:12', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('5698c57f97c54f56b732ea066503e7aa', '04确定决策者', '100000000', '2020-08-29', '2020-08-21 16:21:35', '张三', 'a6dde827d7e948528e1b94379333774d');
INSERT INTO `tbl_tran_history` VALUES ('59c26510bb514f20ba4db9262d9ef9ba', '05提案/报价', '111111', '1899-12-30', '2020-10-02 16:22:23', '张三', 'b18ac35056644ae3b99308599c722f18');
INSERT INTO `tbl_tran_history` VALUES ('5b750e5f3832467a811d947d570009c6', '01资质审查', '138491715', '2020-09-30', '2020-09-23 15:09:00', '张三', 'e3217fd14f134da2b3a43256cd29d36d');
INSERT INTO `tbl_tran_history` VALUES ('5ca07741dd3e4d8380539fd342e61778', '08丢失的线索', '100000000', '2020-09-05', '2020-09-22 09:03:14', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('5dd58c4ced924df9bad7bd026a5afbf2', '06谈判/复审', '1200', '2020-08-28', '2020-09-22 09:13:22', '张三', 'f1fa52932c244c078095701a287dc863');
INSERT INTO `tbl_tran_history` VALUES ('5dffdb8cdb56481d9721029305c72106', '06谈判/复审', '100000000', '2020-09-05', '2020-09-22 09:03:01', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('60500faf575c4fe59934b8ebd848758d', '02需求分析', '138491715', '2020-09-30', '2020-10-06 17:06:28', '张三', 'e3217fd14f134da2b3a43256cd29d36d');
INSERT INTO `tbl_tran_history` VALUES ('637e9b4064f34a6fa5606da7580ce70b', '05提案/报价', '100000000', '2020-09-05', '2020-09-22 09:03:07', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('63a3d3bc3f9c4486bfd2144773f39e1c', '06谈判/复审', '111111', '1899-12-30', '2020-10-02 16:22:24', '张三', 'b18ac35056644ae3b99308599c722f18');
INSERT INTO `tbl_tran_history` VALUES ('65bdfc470cd8453888a5eef26da3778d', '05提案/报价', '111111', '1899-12-30', '2020-10-02 16:22:29', '张三', 'b18ac35056644ae3b99308599c722f18');
INSERT INTO `tbl_tran_history` VALUES ('6b65177ec2da4263b94f435a7ab6761c', '04确定决策者', '100000000', '2020-09-05', '2020-09-07 11:44:46', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('6d2d1ad44a004c388e438b76887f5138', '03价值建议', '100000000', '2020-09-05', '2020-09-07 11:44:52', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('71867b40a21a4ad9b210e7fc9b1c562b', '07成交', '100000000', '2020-09-05', '2020-09-22 09:03:13', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('71fb8ddf205443d0892407ec036434ae', '05提案/报价', '100000000', '2020-09-05', '2020-09-22 09:03:11', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('74f423396a7347b0922529f75f716974', '04确定决策者', '111111', '1899-12-30', '2020-09-23 15:59:20', '张三', 'b18ac35056644ae3b99308599c722f18');
INSERT INTO `tbl_tran_history` VALUES ('76d931740dc9493d91e7b79db3f94f61', '08丢失的线索', '111111', '1899-12-30', '2020-10-02 16:22:25', '张三', 'b18ac35056644ae3b99308599c722f18');
INSERT INTO `tbl_tran_history` VALUES ('7d08a96101cd42008fcdb6e946840dc3', '04确定决策者', '100000000', '2020-09-05', '2020-09-07 11:44:51', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('898ca659c5824ec19dd0a3ccf805da63', '02需求分析', '100000000', '2020-09-05', '2020-09-07 11:44:37', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('89d0f04fa373410ba3f08290344844e9', '06谈判/复审', '111111', '1899-12-30', '2020-10-02 16:22:29', '张三', 'b18ac35056644ae3b99308599c722f18');
INSERT INTO `tbl_tran_history` VALUES ('8d7f59818cb74a97a71186456b306a77', '05提案/报价', '111111', '1899-12-30', '2020-10-02 16:22:28', '张三', 'b18ac35056644ae3b99308599c722f18');
INSERT INTO `tbl_tran_history` VALUES ('8e096990eb594374b55824fac547fad0', '04确定决策者', '100000000', '2020-09-05', '2020-09-07 11:44:48', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('91e2a0677784442282dd300fcb82b0eb', '06谈判/复审', '100000000', '2020-09-05', '2020-09-07 11:44:50', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('9974d9dff4204a999aa7414266f92343', '03价值建议', '100000000', '2020-09-05', '2020-09-07 11:44:42', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('9b9fc941ce20449c92efa3833837ffb0', '05提案/报价', '100000000', '2020-09-05', '2020-09-07 11:44:49', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('9c2b365856c14a7495995b7fa4225562', '01资质审查', '100000000', '2020-11-06', '2020-10-07 22:37:03', '张三', '7d2102bb10d346f5a67b50413346e5fc');
INSERT INTO `tbl_tran_history` VALUES ('9c8918578a274231bc2c30f4785460ca', '04确定决策者', '100000000', '2020-09-05', '2020-09-22 09:03:00', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('9cfd7377837a4ddb86a42cee2df33c07', '08丢失的线索', '100000000', '2020-09-05', '2020-09-21 10:20:05', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('a47d1cd49f4b42f380f10568b32e76ef', '07成交', '100000000', '2020-09-05', '2020-09-21 10:20:02', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('ab15e84dda154774b424579a29d1fe3c', '03价值建议', '50', '2020-08-26', '2020-08-21 17:01:18', '张三', '314005966b0f45b1baac05a047eadddb');
INSERT INTO `tbl_tran_history` VALUES ('af9613c38f6246a3a347867f42978960', '05提案/报价', '100000000', '2020-09-05', '2020-09-07 11:44:39', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('b442b1ea8b984ba08250af1afc93a7a1', '07成交', '100000000', '2020-09-05', '2020-09-21 10:20:01', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('b69789bce1214bc3922cecf0a4f5f9e7', '04确定决策者', '1414147', '2020-10-31', '2020-09-23 15:06:15', '张三', '83173f66067a4e458f101e800505cb11');
INSERT INTO `tbl_tran_history` VALUES ('b8b2cb0c885f430e83d0d895f4ea72ef', '05提案/报价', '100000000', '2020-09-05', '2020-09-22 09:03:01', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('ba3d45dd7f68494c9fd1e25899177a43', '07成交', '15000', '2020-08-08', '2020-08-21 21:18:52', '张三', '925ce9e0aa904357abb08243eb5a0670');
INSERT INTO `tbl_tran_history` VALUES ('c03dec4e134d47c99725bced6da63c85', '02需求分析', '100000000', '2020-08-29', '2020-08-20 20:19:51', '张三', 'a6dde827d7e948528e1b94379333774d');
INSERT INTO `tbl_tran_history` VALUES ('c216e81250314e4597e752b41b0f60c9', '07成交', '100000000', '2020-09-05', '2020-09-22 09:03:19', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('c41e0eca672c40f79223234506f000a9', '06谈判/复审', '100000000', '2020-09-05', '2020-09-07 11:44:47', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('c6e645080997487eb587519319a8030c', '02需求分析', '100000000', '2020-09-05', '2020-09-22 09:03:05', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('cc5fe938e9eb46108c4c8eed7d66ef8b', '03价值建议', '1200', '2020-08-28', '2020-09-22 09:13:15', '张三', 'f1fa52932c244c078095701a287dc863');
INSERT INTO `tbl_tran_history` VALUES ('cdc89f4e9c444a779aaf8cb100f5c8a0', '08丢失的线索', '100000000', '2020-09-05', '2020-09-22 09:03:16', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('cfbb2c1133244277866aad79eec92271', '06谈判/复审', '100000000', '2020-09-05', '2020-09-07 11:44:54', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('d029409427aa49729cea542d7e70fc74', '09因竞争丢失关闭', '100000000', '2020-09-05', '2020-09-22 09:03:17', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('d164aa75addb49babf526d71864e47c1', '04确定决策者', '100000000', '2020-09-05', '2020-09-22 20:41:29', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('d1e79e2bf79e4611a3b2db3982e04064', '04确定决策者', '100000000', '2020-09-05', '2020-09-07 11:44:53', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('d5d3262514ee463d89e3e4dc6b35e5bf', '04确定决策者', '138491715', '2020-09-30', '2020-10-06 17:06:30', '张三', 'e3217fd14f134da2b3a43256cd29d36d');
INSERT INTO `tbl_tran_history` VALUES ('dadd5cf22e5447039cc9b001a2922264', '04确定决策者', '100000000', '2020-09-05', '2020-09-22 09:03:11', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('dc7312bc4a784240b17bd8088ee2aea4', '07成交', '100000000', '2020-08-29', '2020-08-21 13:54:54', '张三', 'a6dde827d7e948528e1b94379333774d');
INSERT INTO `tbl_tran_history` VALUES ('e64bc3c779c04238a0cb79e73c6a3d24', '06谈判/复审', '100000000', '2020-09-05', '2020-09-07 11:44:41', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('e6d9d8a0accb4f1aac95dcd159061b41', '01资质审查', '100000000', '2020-09-05', '2020-08-22 09:34:24', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('e735be2a08764d5380291ffa8a1d3662', '05提案/报价', '1200', '2020-08-28', '2020-09-22 09:13:20', '张三', 'f1fa52932c244c078095701a287dc863');
INSERT INTO `tbl_tran_history` VALUES ('e8b7533e39f54d3f90493a55602f5f2c', '03价值建议', '138491715', '2020-09-30', '2020-10-06 17:06:29', '张三', 'e3217fd14f134da2b3a43256cd29d36d');
INSERT INTO `tbl_tran_history` VALUES ('e9996dc47c064c11a81015ff229fa18e', '03价值建议', '100000000', '2020-09-05', '2020-09-22 09:03:03', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('f10efc3e7fab4f60b0411bebdaad99e0', '05提案/报价', '100000000', '2020-09-05', '2020-09-21 10:20:00', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');
INSERT INTO `tbl_tran_history` VALUES ('fa2f9ddb8e244bf8ae55487e30a306cb', '05提案/报价', '100000000', '2020-09-05', '2020-09-22 20:57:05', '张三', '0f9869a6f8e942c8a66ecba0b1faafc8');

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
INSERT INTO `tbl_tran_remark` VALUES ('786e96a7fd264436b41921fabe63fd57', '12', '张三', '2020-10-04 15:38:06', '张三', '2020-10-04 15:38:09', '1', '925ce9e0aa904357abb08243eb5a0670');
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
INSERT INTO `tbl_user` VALUES ('06f5fc056eac41558a964f96daa7f27c', 'ls', '李四', '202cb962ac59075b964b07152d234b70', 'ls@163.com', '2020-11-27 21:50:05', '1', 'A002', '192.168.1.1', '2019-11-22 12:11:40', '李四', null, null);
INSERT INTO `tbl_user` VALUES ('3d3e964274cd475fa70f9621fda8d43c', '111', '111', '698d51a19d8a121ce581499d7b701668', '123@qq.com', '2020-12-04 15:13:07', '1', 'A002', '127.0.0.1', '2020-11-04 15:13:07', '111', null, null);
INSERT INTO `tbl_user` VALUES ('40f6cdea0bd34aceb77492a1656d9fb3', 'zs', '张三', '202cb962ac59075b964b07152d234b70', 'zs@qq.com', '2020-11-30 23:50:55', '1', 'A001', '192.168.1.1,192.168.1.2,127.0.0.1', '2019-11-22 11:37:34', '张三', null, null);
INSERT INTO `tbl_user` VALUES ('7643c7e1a30d4666aafa582d70e038bc', 'www', '王五', '202cb962ac59075b964b07152d234b70', 'wangwu@qq.com', 'wangwu@qq.com', '1', 'A001', '127.0.0.1', '2020-09-22 14:53:00', '张三', '2020-09-22 16:06:42', '张三');
INSERT INTO `tbl_user` VALUES ('997d8738931041f482029136f693c7a3', 'ZJL', '朱俊良', '202cb962ac59075b964b07152d234b70', 'zhujunliang0831@163.com', '2020-11-13', '0', 'A002', '127.0.0.1', '2020-09-22 15:23:12', '张三', '2020-10-08 10:05:05', '张三');
