/*
Navicat MySQL Data Transfer

Source Server         : mysql5.6
Source Server Version : 50620
Source Host           : localhost:3306
Source Database       : shetuan_db

Target Server Type    : MYSQL
Target Server Version : 50620
File Encoding         : 65001

Date: 2020-04-20 22:34:36
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL DEFAULT '',
  `password` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_exercise`
-- ----------------------------
DROP TABLE IF EXISTS `t_exercise`;
CREATE TABLE `t_exercise` (
  `exerciseId` int(11) NOT NULL AUTO_INCREMENT COMMENT '活动id',
  `exerciseName` varchar(100) NOT NULL COMMENT '活动名称',
  `exerciseDate` varchar(20) DEFAULT NULL COMMENT '活动开始时间',
  `serviceTime` varchar(20) NOT NULL COMMENT '活动时长',
  `address` varchar(60) NOT NULL COMMENT '活动地点',
  `personNum` int(11) NOT NULL COMMENT '参与人数',
  `content` varchar(5000) NOT NULL COMMENT '活动内容',
  `teamObj` varchar(20) NOT NULL COMMENT '主办社团',
  PRIMARY KEY (`exerciseId`),
  KEY `teamObj` (`teamObj`),
  CONSTRAINT `t_exercise_ibfk_1` FOREIGN KEY (`teamObj`) REFERENCES `t_team` (`teamUserName`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_exercise
-- ----------------------------
INSERT INTO `t_exercise` VALUES ('1', '春季乒乓球比赛', '2020-04-30 15:00:00', '2个小时', '南校区体育馆', '500', '<p>不论你是男女，都可以来报名，全民运动！喜欢乒乓球的你，赶紧行动吧！</p><p><img src=\"/JavaWebProject/upload/20200420/1587391660467014757.jpg\" title=\"1587391660467014757.jpg\" alt=\"4.jpg\" width=\"426\" height=\"177\"/></p><p>这次是进行全民选拔赛，海选第一乱，最后有1万元大奖等着你哦！</p>', 'st001');
INSERT INTO `t_exercise` VALUES ('2', '乒乓球迎新晚会', '2020-04-28 19:00:00', '3个小时', '体院馆', '100', '<p>迎接新的乒乓球爱好者，一起庆祝</p>', 'st001');
INSERT INTO `t_exercise` VALUES ('3', '篮球交友活动', '2020-05-13 21:18:35', '2个小时', '学校篮球场', '200', '<p>我们学校为了提高大家的体育兴趣，将举办一个篮球交友活动，一切切磋篮球技术</p>', 'st002');

-- ----------------------------
-- Table structure for `t_leaveword`
-- ----------------------------
DROP TABLE IF EXISTS `t_leaveword`;
CREATE TABLE `t_leaveword` (
  `leaveWordId` int(11) NOT NULL AUTO_INCREMENT COMMENT '留言id',
  `leaveTitle` varchar(80) NOT NULL COMMENT '留言标题',
  `leaveContent` varchar(2000) NOT NULL COMMENT '留言内容',
  `userObj` varchar(20) NOT NULL COMMENT '留言人',
  `leaveTime` varchar(20) DEFAULT NULL COMMENT '留言时间',
  `replyContent` varchar(1000) DEFAULT NULL COMMENT '管理回复',
  `replyTime` varchar(20) DEFAULT NULL COMMENT '回复时间',
  PRIMARY KEY (`leaveWordId`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_leaveword_ibfk_1` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_leaveword
-- ----------------------------
INSERT INTO `t_leaveword` VALUES ('1', '这个不错啊', '我可以加入我喜欢的体育社团了', 'user1', '2020-04-19 23:13:21', '我们就是为大家办事的', '2020-04-19 23:13:26');
INSERT INTO `t_leaveword` VALUES ('2', '加入篮球社要交费吗', '需要交社团费吗？', 'user2', '2020-04-20 19:43:11', '我们都是自己的兴趣加入，不收费', '2020-04-20 22:02:37');

-- ----------------------------
-- Table structure for `t_notice`
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice` (
  `noticeId` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告id',
  `title` varchar(80) NOT NULL COMMENT '标题',
  `content` varchar(5000) NOT NULL COMMENT '公告内容',
  `publishDate` varchar(20) DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`noticeId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES ('1', '社团管理系统成立了', '<p>同学们可以来这里选择你喜欢的社团，提高大家的多方位兴趣！</p>', '2020-04-19 23:13:34');
INSERT INTO `t_notice` VALUES ('2', '想加入社团的来吧', '<p>搜到你感兴趣的社团，多参加社团活动，联系社团负责人电话加入即可</p>', '2020-04-20 22:04:35');

-- ----------------------------
-- Table structure for `t_signup`
-- ----------------------------
DROP TABLE IF EXISTS `t_signup`;
CREATE TABLE `t_signup` (
  `signUpId` int(11) NOT NULL AUTO_INCREMENT COMMENT '报名id',
  `exerciseObj` int(11) NOT NULL COMMENT '社团活动',
  `userObj` varchar(20) NOT NULL COMMENT '报名用户',
  `signUpTime` varchar(30) DEFAULT NULL COMMENT '报名时间',
  `signUpState` int(11) NOT NULL COMMENT '审核状态',
  PRIMARY KEY (`signUpId`),
  KEY `exerciseObj` (`exerciseObj`),
  KEY `userObj` (`userObj`),
  KEY `signUpState` (`signUpState`),
  CONSTRAINT `t_signup_ibfk_1` FOREIGN KEY (`exerciseObj`) REFERENCES `t_exercise` (`exerciseId`),
  CONSTRAINT `t_signup_ibfk_2` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`),
  CONSTRAINT `t_signup_ibfk_3` FOREIGN KEY (`signUpState`) REFERENCES `t_signupsate` (`stateId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_signup
-- ----------------------------
INSERT INTO `t_signup` VALUES ('1', '1', 'user1', '2020-04-19 20:15:30', '2');
INSERT INTO `t_signup` VALUES ('2', '1', 'user2', '2020-04-20 19:39:33', '1');
INSERT INTO `t_signup` VALUES ('3', '3', 'user2', '2020-04-20 21:30:16', '2');
INSERT INTO `t_signup` VALUES ('4', '3', 'user1', '2020-04-20 22:22:05', '1');

-- ----------------------------
-- Table structure for `t_signupsate`
-- ----------------------------
DROP TABLE IF EXISTS `t_signupsate`;
CREATE TABLE `t_signupsate` (
  `stateId` int(11) NOT NULL AUTO_INCREMENT COMMENT '状态id',
  `stateName` varchar(20) NOT NULL COMMENT '状态名称',
  PRIMARY KEY (`stateId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_signupsate
-- ----------------------------
INSERT INTO `t_signupsate` VALUES ('1', '待审核');
INSERT INTO `t_signupsate` VALUES ('2', '审核通过');
INSERT INTO `t_signupsate` VALUES ('3', '审核拒绝');

-- ----------------------------
-- Table structure for `t_team`
-- ----------------------------
DROP TABLE IF EXISTS `t_team`;
CREATE TABLE `t_team` (
  `teamUserName` varchar(20) NOT NULL COMMENT 'teamUserName',
  `password` varchar(20) NOT NULL COMMENT '登录密码',
  `teamName` varchar(60) NOT NULL COMMENT '社团名称',
  `shoolName` varchar(20) NOT NULL COMMENT '所属院校',
  `area` varchar(20) NOT NULL COMMENT '所在区域',
  `teamPhoto` varchar(60) NOT NULL COMMENT '社团Logo',
  `mainUnit` varchar(40) NOT NULL COMMENT '主管单位',
  `birthDate` varchar(20) DEFAULT NULL COMMENT '成立日期',
  `email` varchar(50) NOT NULL COMMENT '电子邮箱',
  `telephone` varchar(20) NOT NULL COMMENT '负责人电话',
  `chargeMan` varchar(20) NOT NULL COMMENT '负责人姓名',
  `address` varchar(80) NOT NULL COMMENT '详细地址',
  `personList` varchar(8000) NOT NULL COMMENT '社团成员',
  PRIMARY KEY (`teamUserName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_team
-- ----------------------------
INSERT INTO `t_team` VALUES ('st001', '123', '乒乓球社', '成都理工大学', '南校区', 'upload/f84f290f-e01c-4ce1-b87f-a9f59ba72d6e.jpg', '南校区体育学院', '2020-04-15', 'ppafafa@163.com', '18330841234', '王晓光', '崔家店路100号', '<p>双鱼林，王浩，李四</p>');
INSERT INTO `t_team` VALUES ('st002', '123', '篮球社团', '电子科技大学', '成华区', 'upload/b840a6a5-ea0f-488b-95a5-cf04c391b332.jpg', '电子科技大学体育协会', '2020-04-20', 'lafasgs@163.com', '13980108342', '李刚', '成都建设路100号', '<p>李晓旭，王斌，李天和</p>');

-- ----------------------------
-- Table structure for `t_userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_userinfo`;
CREATE TABLE `t_userinfo` (
  `user_name` varchar(20) NOT NULL COMMENT 'user_name',
  `password` varchar(20) NOT NULL COMMENT '登录密码',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `sex` varchar(4) NOT NULL COMMENT '性别',
  `userPhoto` varchar(60) NOT NULL COMMENT '用户照片',
  `schoolName` varchar(20) NOT NULL COMMENT '学校学院',
  `specialInfo` varchar(40) NOT NULL COMMENT '年级专业',
  `nation` varchar(20) DEFAULT NULL COMMENT '民族',
  `politicalStatus` varchar(20) DEFAULT NULL COMMENT '政治面貌',
  `birthday` varchar(20) DEFAULT NULL COMMENT '出生日期',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `address` varchar(80) NOT NULL COMMENT '联系地址',
  `interest` varchar(50) DEFAULT NULL COMMENT '有兴趣的项目',
  `introduce` varchar(5000) DEFAULT NULL COMMENT '个人介绍',
  PRIMARY KEY (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_userinfo
-- ----------------------------
INSERT INTO `t_userinfo` VALUES ('user1', '123', '双鱼林', '男', 'upload/fe9a5e31-19dc-41c7-97e7-2709c2617a58.jpg', '成都理工大学', '计算机专业', '汉', '团员', '2020-04-19', '13980083423', '成都红星路10号', '乒乓球', '<p>很喜欢玩乒乓球</p>');
INSERT INTO `t_userinfo` VALUES ('user2', '123', '王涛', '男', 'upload/07e88a4b-4e51-40e8-a78b-e519c862e278.jpg', '成都理工大学', '计算机专业', '汉', '团员', '2020-04-16', '13908130834', '南充滨江路12号', '篮球', '<p>我喜欢运动</p>');
