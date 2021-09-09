/*
SQLyog Community v13.1.6 (64 bit)
MySQL - 5.7.19 : Database - hsp_db03
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`hsp_db03` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;


/*Table structure for table `easyuser` */

DROP TABLE IF EXISTS `easyuser`;

CREATE TABLE `easyuser` (
  `id` int(24) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  `state` tinyint(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `easyuser` */

insert  into `easyuser`(`id`,`username`,`password`,`email`,`role`,`state`) values 
(1,'admin','123456','123@qq.com','超级管理员',1),
(2,'naughty','888888','456@qq.com','普通管理员',0),
(3,'flysky01','987654','qwe@qq.com','普通用户',1),
(4,'anglybirds','321654','aaaa@163.com','普通用户',0),
(7,'admin003','q123456','c@qq.com','普通用户',1),
(8,'admin005','123456','cxz@qq.com','普通用户',0),
(9,'admin007','123456','rty@qq.com','普通用户',0);

/*Table structure for table `mainmenu` */

DROP TABLE IF EXISTS `mainmenu`;

CREATE TABLE `mainmenu` (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8;

/*Data for the table `mainmenu` */

insert  into `mainmenu`(`id`,`title`,`path`) values 
(100,'权限管理','/admin'),
(200,'运动平台','/use');

/*Table structure for table `submenu` */

DROP TABLE IF EXISTS `submenu`;

CREATE TABLE `submenu` (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `mid` int(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mid` (`mid`),
  CONSTRAINT `submenu_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `mainmenu` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8;

/*Data for the table `submenu` */

insert  into `submenu`(`id`,`title`,`path`,`mid`) values 
(101,'用户列表','/user',100),
(102,'修改权限','/rights',100),
(103,' 运动模块','/sport',100),
(104,'商品模块','/goods',100),
(201,'运动科普','/Introduction',200),
(202,'卡路里','/calories',200),
(203,'营养配餐','/food',200);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
