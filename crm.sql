/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50636
Source Host           : localhost:3306
Source Database       : crm

Target Server Type    : MYSQL
Target Server Version : 50636
File Encoding         : 65001

Date: 2020-02-15 15:15:44
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` int(11) DEFAULT NULL,
  `tel` varchar(255) DEFAULT NULL,
  `qq` varchar(255) DEFAULT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  `source_id` bigint(20) DEFAULT NULL,
  `seller_id` bigint(20) DEFAULT NULL,
  `inputUser_id` bigint(20) DEFAULT NULL,
  `input_time` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES ('1', '王五', '22', '1', '1370000000', '10086', '1', '5', '2', '1', '2018-07-01 15:41:42', '2');
INSERT INTO `customer` VALUES ('2', '李四', '25', '1', '1560000000', '10052', '2', '4', '14', '1', '2018-08-03 15:17:57', '0');
INSERT INTO `customer` VALUES ('3', '周粥', '24', '0', '1870000000', '10071', '9', '5', '2', '1', '2018-08-03 15:56:30', '1');
INSERT INTO `customer` VALUES ('4', '李四', '17', '1', '1880000000', '10089', '2', '4', '11', '1', '2018-08-03 16:24:09', '3');
INSERT INTO `customer` VALUES ('5', '大飞', '29', '1', '1600000000', '11008', '2', '5', '11', '1', '2018-09-28 10:53:52', '0');
INSERT INTO `customer` VALUES ('6', '逍遥', '10', '0', '1340000000', '11009', '1', '6', '2', '1', '2018-09-28 10:53:48', '4');
INSERT INTO `customer` VALUES ('7', '李离', '26', '0', '1390000000', '11050', '2', '5', '15', '1', '2019-02-01 15:44:20', '0');
INSERT INTO `customer` VALUES ('8', '庄鱼', '23', '1', '1670000000', '11083', '3', '4', '15', '1', '2019-02-01 15:44:25', '1');
INSERT INTO `customer` VALUES ('9', '范伟', '27', '1', '1520000000', '11017', '3', '6', '2', '1', '2020-01-13 17:19:12', '0');
INSERT INTO `customer` VALUES ('10', '柳烟', '21', '0', '1820000000', '11091', '10', '6', '14', '1', '2020-01-07 00:11:28', '3');
INSERT INTO `customer` VALUES ('11', '郑倩', '26', '0', '1720000000', '11023', '10', '4', '11', '1', '2020-01-02 00:11:35', '2');
INSERT INTO `customer` VALUES ('12', '苏琳', '25', '0', '1130000000', '11084', '11', '5', '15', '14', '2020-01-16 00:16:08', '2');
INSERT INTO `customer` VALUES ('13', '吴丹', '28', '0', '1290000000', '11036', '1', '6', '11', '14', '2020-01-16 00:17:44', '4');

-- ----------------------------
-- Table structure for customer_trace_history
-- ----------------------------
DROP TABLE IF EXISTS `customer_trace_history`;
CREATE TABLE `customer_trace_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `trace_time` date DEFAULT NULL,
  `trace_details` varchar(255) DEFAULT NULL,
  `trace_type_id` bigint(20) DEFAULT NULL,
  `trace_result` int(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `input_user_id` bigint(20) DEFAULT NULL,
  `input_time` datetime DEFAULT NULL,
  `type` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of customer_trace_history
-- ----------------------------
INSERT INTO `customer_trace_history` VALUES ('1', '2018-08-02', '无人接听电话，联系不上', '21', '0', '无人接听电话，联系不上', '1', '11', '2018-08-03 17:27:20', '0');
INSERT INTO `customer_trace_history` VALUES ('2', '2018-08-04', '考虑中', '22', '1', '考虑中', '4', '11', '2018-08-04 15:49:18', '0');
INSERT INTO `customer_trace_history` VALUES ('3', '2018-08-04', '了解使用感受', '21', '1', '了解使用感受', '4', '2', '2018-08-04 18:40:00', '0');
INSERT INTO `customer_trace_history` VALUES ('4', '2018-08-04', '暂无培训想法', '19', '1', '暂无培训想法', '3', '14', '2018-08-04 18:55:08', '0');
INSERT INTO `customer_trace_history` VALUES ('5', '2018-09-27', '电话接通就挂掉，待跟进中', '19', '0', '电话接通就挂掉，待跟进中', '6', '14', '2018-09-25 13:21:12', '0');
INSERT INTO `customer_trace_history` VALUES ('6', '2018-09-19', '表示不认识，打错了', '20', '0', '表示不认识，打错了', '6', '14', '2018-09-28 13:21:00', '0');
INSERT INTO `customer_trace_history` VALUES ('7', '2019-02-11', '222222', '21', '1', '22257', '1', '11', '2019-02-01 15:07:01', '0');
INSERT INTO `customer_trace_history` VALUES ('8', '2019-02-01', '2', '19', '2', '475', '7', '14', '2019-02-01 15:45:07', '1');
INSERT INTO `customer_trace_history` VALUES ('9', '2019-05-04', 'xxx', '20', '0', '32423424', '1', '11', '2019-05-04 15:36:50', '0');

-- ----------------------------
-- Table structure for customer_transfer
-- ----------------------------
DROP TABLE IF EXISTS `customer_transfer`;
CREATE TABLE `customer_transfer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) DEFAULT NULL,
  `operator_id` bigint(20) DEFAULT NULL,
  `operate_time` datetime DEFAULT NULL,
  `oldSeller_id` bigint(20) DEFAULT NULL,
  `newSeller_id` bigint(20) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of customer_transfer
-- ----------------------------
INSERT INTO `customer_transfer` VALUES ('1', '1', '1', '2018-08-04 16:44:11', '2', '1', '离职资源移交');
INSERT INTO `customer_transfer` VALUES ('2', '1', '1', '2018-08-04 17:13:38', '2', '14', '休产假移交');
INSERT INTO `customer_transfer` VALUES ('3', '11', '1', '2018-08-04 17:19:54', '11', '14', '离职资源移交');
INSERT INTO `customer_transfer` VALUES ('4', '1', '1', '2018-08-04 17:45:38', '2', '11', '调岗移交');
INSERT INTO `customer_transfer` VALUES ('5', '13', '1', '2018-08-04 17:53:03', '14', '2', '离职资源移交');
INSERT INTO `customer_transfer` VALUES ('6', '1', '1', '2018-08-04 17:54:58', '2', '11', '离职资源移交');
INSERT INTO `customer_transfer` VALUES ('7', '2', '1', '2018-08-04 18:41:51', '2', '11', '工作调配移交');
INSERT INTO `customer_transfer` VALUES ('8', '6', '1', '2018-09-28 14:36:46', '11', '2', '离职资源移交');
INSERT INTO `customer_transfer` VALUES ('9', '5', '1', '2018-09-28 14:37:08', '14', '11', '工作调配移交');
INSERT INTO `customer_transfer` VALUES ('10', '5', '1', '2018-09-28 14:41:39', '2', '14', '离职资源移交');
INSERT INTO `customer_transfer` VALUES ('16', '6', '1', '2018-09-28 16:21:30', '2', '11', '工作调配移交');
INSERT INTO `customer_transfer` VALUES ('17', '5', '1', '2018-09-29 09:47:15', '11', '2', '离职资源移交');
INSERT INTO `customer_transfer` VALUES ('18', '5', '1', '2018-09-29 09:47:30', '14', '2', '调岗移交');
INSERT INTO `customer_transfer` VALUES ('19', '1', '1', '2019-02-01 15:06:00', '11', '2', '生病请假');
INSERT INTO `customer_transfer` VALUES ('20', '1', '1', '2019-02-01 15:06:06', '11', '14', '去旅游');
INSERT INTO `customer_transfer` VALUES ('21', '7', '1', '2019-02-01 15:45:21', '14', '2', '去培训');
INSERT INTO `customer_transfer` VALUES ('25', '1', '1', '2019-05-04 16:28:48', '2', '14', '调岗移交');
INSERT INTO `customer_transfer` VALUES ('30', '13', '2', '2020-01-20 00:41:48', '14', '11', '调岗移交');
INSERT INTO `customer_transfer` VALUES ('31', '8', '1', '2020-01-21 18:58:50', '14', '15', '客户要求');
INSERT INTO `customer_transfer` VALUES ('32', '7', '1', '2020-01-28 22:56:43', '14', '15', '客户所在地变更');
INSERT INTO `customer_transfer` VALUES ('33', '9', '1', '2020-01-28 22:57:51', '11', '2', '员工休长假');
INSERT INTO `customer_transfer` VALUES ('34', '12', '1', '2020-01-28 23:00:33', '2', '15', '生病请假');

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `sn` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('1', '销售部', 'xxx');
INSERT INTO `department` VALUES ('2', '运营部', 'yyy');
INSERT INTO `department` VALUES ('3', '研发部', 'zzz');
INSERT INTO `department` VALUES ('4', '产品部', 'ppp');
INSERT INTO `department` VALUES ('5', '总经办', 'aaa');
INSERT INTO `department` VALUES ('6', '人事部', 'bbb');
INSERT INTO `department` VALUES ('7', '设计部', 'vvv');

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `admin` bit(1) DEFAULT NULL,
  `dept_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES ('1', '小明', 'b8f21d4bb28b18e014e3a5ce499daeaf', '929214082@qq.com', '23', '', '3');
INSERT INTO `employee` VALUES ('2', '小李', 'bb02589e8efe1998481fad90bc3e8dc7', '929214085@qq.com', '26', '\0', '1');
INSERT INTO `employee` VALUES ('4', '小萱', 'c23ec38d8bbffd8d45f545c646febe24', '929214381@qq.com', '22', '\0', '2');
INSERT INTO `employee` VALUES ('5', '小张', '3745ad01fc1c9776e7e224580b519d9a', '929219382@qq.com', '25', '\0', '5');
INSERT INTO `employee` VALUES ('6', '小媚', 'd40b644cec1152cfd7fac8aca33a1af1', '929216382@qq.com', '20', '\0', '1');
INSERT INTO `employee` VALUES ('7', '小强', 'c2ccbe7f330f91b8e92aa581d3b43570', '929217382@qq.com', '28', '\0', '3');
INSERT INTO `employee` VALUES ('10', '小杨', '8ce09d178afff3a6a06f692b516b0873', '929213151@qq.com', '29', '\0', '7');
INSERT INTO `employee` VALUES ('11', '小海', 'b8fff46ea87691995c44e807757dd355', '929215283@qq.com', '31', '\0', '4');
INSERT INTO `employee` VALUES ('12', '小青', '96e79218965eb72c92a549dd5a330112', '929214583@qq.com', '20', '\0', '1');
INSERT INTO `employee` VALUES ('13', '小丽', 'cd87cd5ef753a06ee79fc75dc7cfe66c', '929415283@qq.com', '20', '\0', '3');
INSERT INTO `employee` VALUES ('14', '小东', '1669c31f539d87ee15ae51a1f149ca87', '929231084@qq.com', '28', '\0', '4');
INSERT INTO `employee` VALUES ('15', '小烟', '86f1b56f5140182282a5bcc1bb8af403', '929231@qq.com', '22', '\0', '1');

-- ----------------------------
-- Table structure for employee_role
-- ----------------------------
DROP TABLE IF EXISTS `employee_role`;
CREATE TABLE `employee_role` (
  `employee_id` bigint(20) DEFAULT NULL,
  `role_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of employee_role
-- ----------------------------
INSERT INTO `employee_role` VALUES ('4', '3');
INSERT INTO `employee_role` VALUES ('6', '1');
INSERT INTO `employee_role` VALUES ('5', '4');
INSERT INTO `employee_role` VALUES ('7', '2');
INSERT INTO `employee_role` VALUES ('10', '6');
INSERT INTO `employee_role` VALUES ('13', '2');
INSERT INTO `employee_role` VALUES ('11', '5');
INSERT INTO `employee_role` VALUES ('2', '7');
INSERT INTO `employee_role` VALUES ('11', '8');
INSERT INTO `employee_role` VALUES ('14', '8');
INSERT INTO `employee_role` VALUES ('15', '8');

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `expression` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES ('1', '删除部门', 'department:delete');
INSERT INTO `permission` VALUES ('2', '部门列表', 'department:list');
INSERT INTO `permission` VALUES ('3', '新增部门/更新部门', 'department:saveOrUpdate');
INSERT INTO `permission` VALUES ('4', '删除员工', 'employee:delete');
INSERT INTO `permission` VALUES ('5', '员工列表', 'employee:list');
INSERT INTO `permission` VALUES ('6', '编辑员工', 'employee:input');
INSERT INTO `permission` VALUES ('7', '新增员工/更新员工', 'employee:saveOrUpdate');
INSERT INTO `permission` VALUES ('8', '删除权限', 'permission:delete');
INSERT INTO `permission` VALUES ('10', '删除角色', 'role:delete');
INSERT INTO `permission` VALUES ('11', '角色列表', 'role:list');
INSERT INTO `permission` VALUES ('12', '编辑角色', 'role:input');
INSERT INTO `permission` VALUES ('13', '新增角色/更新角色', 'role:saveOrUpdate');
INSERT INTO `permission` VALUES ('14', '潜在客户报表', 'customerChart:list');
INSERT INTO `permission` VALUES ('15', '潜在客户饼图', 'customerChart:pieChart');
INSERT INTO `permission` VALUES ('16', '潜在客户柱状图', 'customerChart:barChart');
INSERT INTO `permission` VALUES ('17', '潜在客户列表', 'customer:potentialCustomerList');
INSERT INTO `permission` VALUES ('18', '正式客户列表', 'customer:formalCustomerList');
INSERT INTO `permission` VALUES ('19', '新增潜在客户/更新潜在客户', 'customer:saveOrUpdate');
INSERT INTO `permission` VALUES ('20', '更新潜在客户状态', 'customer:updateStatus');
INSERT INTO `permission` VALUES ('21', '客户列表', 'customer:customerList');
INSERT INTO `permission` VALUES ('22', '客户池列表', 'customer:poolCustomerList');
INSERT INTO `permission` VALUES ('23', '失败客户列表', 'customer:failCustomerList');
INSERT INTO `permission` VALUES ('24', '流失客户列表', 'customer:lostCustomerList');
INSERT INTO `permission` VALUES ('25', '跟进历史列表', 'customerTraceHistory:list');
INSERT INTO `permission` VALUES ('26', '更新跟进历史', 'customerTraceHistory:update');
INSERT INTO `permission` VALUES ('27', '移交历史列表', 'customerTransfer:list');
INSERT INTO `permission` VALUES ('28', '新增移交历史', 'customerTransfer:save');
INSERT INTO `permission` VALUES ('29', '员工导出', 'employee:exportXls');
INSERT INTO `permission` VALUES ('30', '员工导入', 'employee:importXls');
INSERT INTO `permission` VALUES ('31', '批量删除员工', 'employee:batchDelete');
INSERT INTO `permission` VALUES ('32', '删除数据字典目录', 'systemDictionary:delete');
INSERT INTO `permission` VALUES ('33', '数据字典目录列表', 'systemDictionary:list');
INSERT INTO `permission` VALUES ('34', '新增数据字典目录/更新数据字典目录', 'systemDictionary:saveOrUpdate');
INSERT INTO `permission` VALUES ('35', '删除数据字典明细', 'systemDictionaryItem:delete');
INSERT INTO `permission` VALUES ('36', '数据字典明细列表', 'systemDictionaryItem:list');
INSERT INTO `permission` VALUES ('37', '新增数据字典明细/更新数据字典明细', 'systemDictionaryItem:saveOrUpdate');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `sn` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '人事经理', 'HR');
INSERT INTO `role` VALUES ('2', '工程师', 'EE');
INSERT INTO `role` VALUES ('3', '秘书', 'SC');
INSERT INTO `role` VALUES ('4', '司机', 'DR');
INSERT INTO `role` VALUES ('5', '运管', 'OC');
INSERT INTO `role` VALUES ('6', '平面设计师', 'TT');
INSERT INTO `role` VALUES ('7', '市场经理', 'MM');
INSERT INTO `role` VALUES ('8', '市场专员', 'MY');

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `role_id` bigint(20) DEFAULT NULL,
  `permission_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
INSERT INTO `role_permission` VALUES ('2', '5');
INSERT INTO `role_permission` VALUES ('2', '2');
INSERT INTO `role_permission` VALUES ('6', '2');
INSERT INTO `role_permission` VALUES ('6', '5');
INSERT INTO `role_permission` VALUES ('1', '2');
INSERT INTO `role_permission` VALUES ('1', '3');
INSERT INTO `role_permission` VALUES ('1', '5');
INSERT INTO `role_permission` VALUES ('1', '6');
INSERT INTO `role_permission` VALUES ('1', '7');
INSERT INTO `role_permission` VALUES ('3', '1');
INSERT INTO `role_permission` VALUES ('3', '2');
INSERT INTO `role_permission` VALUES ('3', '3');
INSERT INTO `role_permission` VALUES ('3', '10');
INSERT INTO `role_permission` VALUES ('3', '11');
INSERT INTO `role_permission` VALUES ('3', '12');
INSERT INTO `role_permission` VALUES ('3', '13');
INSERT INTO `role_permission` VALUES ('3', '5');
INSERT INTO `role_permission` VALUES ('4', '2');
INSERT INTO `role_permission` VALUES ('4', '5');
INSERT INTO `role_permission` VALUES ('5', '32');
INSERT INTO `role_permission` VALUES ('5', '33');
INSERT INTO `role_permission` VALUES ('5', '34');
INSERT INTO `role_permission` VALUES ('5', '35');
INSERT INTO `role_permission` VALUES ('5', '36');
INSERT INTO `role_permission` VALUES ('5', '37');
INSERT INTO `role_permission` VALUES ('5', '10');
INSERT INTO `role_permission` VALUES ('5', '11');
INSERT INTO `role_permission` VALUES ('5', '12');
INSERT INTO `role_permission` VALUES ('5', '13');
INSERT INTO `role_permission` VALUES ('7', '5');
INSERT INTO `role_permission` VALUES ('7', '2');
INSERT INTO `role_permission` VALUES ('7', '14');
INSERT INTO `role_permission` VALUES ('7', '15');
INSERT INTO `role_permission` VALUES ('7', '16');
INSERT INTO `role_permission` VALUES ('7', '17');
INSERT INTO `role_permission` VALUES ('7', '18');
INSERT INTO `role_permission` VALUES ('7', '19');
INSERT INTO `role_permission` VALUES ('7', '20');
INSERT INTO `role_permission` VALUES ('7', '21');
INSERT INTO `role_permission` VALUES ('7', '22');
INSERT INTO `role_permission` VALUES ('7', '23');
INSERT INTO `role_permission` VALUES ('7', '24');
INSERT INTO `role_permission` VALUES ('7', '25');
INSERT INTO `role_permission` VALUES ('7', '26');
INSERT INTO `role_permission` VALUES ('7', '27');
INSERT INTO `role_permission` VALUES ('7', '28');
INSERT INTO `role_permission` VALUES ('8', '2');
INSERT INTO `role_permission` VALUES ('8', '5');
INSERT INTO `role_permission` VALUES ('8', '17');
INSERT INTO `role_permission` VALUES ('8', '18');
INSERT INTO `role_permission` VALUES ('8', '20');
INSERT INTO `role_permission` VALUES ('8', '21');
INSERT INTO `role_permission` VALUES ('8', '22');
INSERT INTO `role_permission` VALUES ('8', '23');
INSERT INTO `role_permission` VALUES ('8', '24');
INSERT INTO `role_permission` VALUES ('8', '25');
INSERT INTO `role_permission` VALUES ('8', '27');

-- ----------------------------
-- Table structure for system_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `system_dictionary`;
CREATE TABLE `system_dictionary` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sn` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `intro` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of system_dictionary
-- ----------------------------
INSERT INTO `system_dictionary` VALUES ('1', 'job', '职业', '客户职业');
INSERT INTO `system_dictionary` VALUES ('2', 'source', '来源', '客户来源渠道');
INSERT INTO `system_dictionary` VALUES ('3', 'marry', '婚否', '是否已婚');
INSERT INTO `system_dictionary` VALUES ('4', 'address', '居住地', '家庭地址');
INSERT INTO `system_dictionary` VALUES ('5', 'traceType', '交流方式', '交流的渠道');

-- ----------------------------
-- Table structure for system_dictionary_item
-- ----------------------------
DROP TABLE IF EXISTS `system_dictionary_item`;
CREATE TABLE `system_dictionary_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `sequence` int(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of system_dictionary_item
-- ----------------------------
INSERT INTO `system_dictionary_item` VALUES ('1', '1', '老师', '2');
INSERT INTO `system_dictionary_item` VALUES ('2', '1', '司机', '1');
INSERT INTO `system_dictionary_item` VALUES ('3', '1', '老板', '1');
INSERT INTO `system_dictionary_item` VALUES ('4', '2', '自身途径', '1');
INSERT INTO `system_dictionary_item` VALUES ('5', '2', '营销广告', '4');
INSERT INTO `system_dictionary_item` VALUES ('6', '2', '顾客推荐', '1');
INSERT INTO `system_dictionary_item` VALUES ('7', '3', '未婚', '1');
INSERT INTO `system_dictionary_item` VALUES ('8', '3', '已婚', '2');
INSERT INTO `system_dictionary_item` VALUES ('9', '1', '灯光师', '2');
INSERT INTO `system_dictionary_item` VALUES ('10', '1', '舞蹈老师', '3');
INSERT INTO `system_dictionary_item` VALUES ('11', '1', '学生', '1');
INSERT INTO `system_dictionary_item` VALUES ('12', '4', '广州市', '1');
INSERT INTO `system_dictionary_item` VALUES ('13', '4', '广东省内', '2');
INSERT INTO `system_dictionary_item` VALUES ('14', '4', '广东省外', '3');
INSERT INTO `system_dictionary_item` VALUES ('15', '4', '国外', '4');
INSERT INTO `system_dictionary_item` VALUES ('18', '3', '保密', '3');
INSERT INTO `system_dictionary_item` VALUES ('19', '5', '微信', '1');
INSERT INTO `system_dictionary_item` VALUES ('20', '5', 'email', '4');
INSERT INTO `system_dictionary_item` VALUES ('21', '5', '营销QQ', '2');
INSERT INTO `system_dictionary_item` VALUES ('22', '5', '电话', '3');
