-- MySQL dump 10.13  Distrib 5.1.69, for redhat-linux-gnu (i386)
--
-- Host: localhost    Database: diebesten
-- ------------------------------------------------------
-- Server version	5.1.69

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actions` (
  `aid` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique actions ID.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The object that that action acts on (node, user, comment, system or custom types.)',
  `callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback function that executes when the action runs.',
  `parameters` longblob NOT NULL COMMENT 'Parameters to be passed to the callback function.',
  `label` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Label of the action.',
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores action information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actions`
--
-- ORDER BY:  `aid`

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `actions` VALUES ('comment_publish_action','comment','comment_publish_action','','Publish comment');
INSERT INTO `actions` VALUES ('comment_save_action','comment','comment_save_action','','Save comment');
INSERT INTO `actions` VALUES ('comment_unpublish_action','comment','comment_unpublish_action','','Unpublish comment');
INSERT INTO `actions` VALUES ('node_make_sticky_action','node','node_make_sticky_action','','Make content sticky');
INSERT INTO `actions` VALUES ('node_make_unsticky_action','node','node_make_unsticky_action','','Make content unsticky');
INSERT INTO `actions` VALUES ('node_promote_action','node','node_promote_action','','Promote content to front page');
INSERT INTO `actions` VALUES ('node_publish_action','node','node_publish_action','','Publish content');
INSERT INTO `actions` VALUES ('node_save_action','node','node_save_action','','Save content');
INSERT INTO `actions` VALUES ('node_unpromote_action','node','node_unpromote_action','','Remove content from front page');
INSERT INTO `actions` VALUES ('node_unpublish_action','node','node_unpublish_action','','Unpublish content');
INSERT INTO `actions` VALUES ('system_block_ip_action','user','system_block_ip_action','','Ban IP address of current user');
INSERT INTO `actions` VALUES ('user_block_user_action','user','user_block_user_action','','Block current user');
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `authmap`
--

DROP TABLE IF EXISTS `authmap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authmap` (
  `aid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique authmap ID.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'User’s users.uid.',
  `authname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Unique authentication name.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'Module which is controlling the authentication.',
  PRIMARY KEY (`aid`),
  UNIQUE KEY `authname` (`authname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores distributed authentication mapping.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authmap`
--
-- ORDER BY:  `aid`

LOCK TABLES `authmap` WRITE;
/*!40000 ALTER TABLE `authmap` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `authmap` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `batch`
--

DROP TABLE IF EXISTS `batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch` (
  `bid` int(10) unsigned NOT NULL COMMENT 'Primary Key: Unique batch ID.',
  `token` varchar(64) NOT NULL COMMENT 'A string token generated against the current user’s session id and the batch id, used to ensure that only the user who submitted the batch can effectively access it.',
  `timestamp` int(11) NOT NULL COMMENT 'A Unix timestamp indicating when this batch was submitted for processing. Stale batches are purged at cron time.',
  `batch` longblob COMMENT 'A serialized array containing the processing data for the batch.',
  PRIMARY KEY (`bid`),
  KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores details about batches (processes that run in...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch`
--
-- ORDER BY:  `bid`

LOCK TABLES `batch` WRITE;
/*!40000 ALTER TABLE `batch` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `batch` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `block`
--

DROP TABLE IF EXISTS `block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block` (
  `bid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique block ID.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The module from which the block originates; for example, ’user’ for the Who’s Online block, and ’block’ for any custom blocks.',
  `delta` varchar(32) NOT NULL DEFAULT '0' COMMENT 'Unique ID for block within a module.',
  `theme` varchar(64) NOT NULL DEFAULT '' COMMENT 'The theme under which the block settings apply.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Block enabled status. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Block weight within region.',
  `region` varchar(64) NOT NULL DEFAULT '' COMMENT 'Theme region within which the block is set.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how users may control visibility of the block. (0 = Users cannot control, 1 = On by default, but can be hidden, 2 = Hidden by default, but can be shown)',
  `visibility` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how to show blocks on pages. (0 = Show on all pages except listed pages, 1 = Show only on listed pages, 2 = Use custom PHP code to determine visibility)',
  `pages` text NOT NULL COMMENT 'Contents of the "Pages" block; contains either a list of paths on which to include/exclude the block or PHP code, depending on "visibility" setting.',
  `title` varchar(64) NOT NULL DEFAULT '' COMMENT 'Custom title for the block. (Empty string will use block default title, <none> will remove the title, text will cause block to use specified title.)',
  `cache` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Binary flag to indicate block cache mode. (-2: Custom cache, -1: Do not cache, 1: Cache per role, 2: Cache per user, 4: Cache per page, 8: Block cache global) See DRUPAL_CACHE_* constants in ../includes/common.inc for more detailed information.',
  PRIMARY KEY (`bid`),
  UNIQUE KEY `tmd` (`theme`,`module`,`delta`),
  KEY `list` (`theme`,`status`,`region`,`weight`,`module`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='Stores block settings, such as region and visibility...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block`
--
-- ORDER BY:  `bid`

LOCK TABLES `block` WRITE;
/*!40000 ALTER TABLE `block` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `block` VALUES (1,'system','main','bartik',1,0,'content',0,0,'','',-1);
INSERT INTO `block` VALUES (2,'search','form','bartik',1,-1,'sidebar_first',0,0,'','',-1);
INSERT INTO `block` VALUES (3,'node','recent','seven',1,10,'dashboard_main',0,0,'','',-1);
INSERT INTO `block` VALUES (4,'user','login','bartik',1,0,'sidebar_first',0,0,'','',-1);
INSERT INTO `block` VALUES (5,'system','navigation','bartik',1,0,'sidebar_first',0,0,'','',-1);
INSERT INTO `block` VALUES (6,'system','powered-by','bartik',1,10,'footer',0,0,'','',-1);
INSERT INTO `block` VALUES (7,'system','help','bartik',1,0,'help',0,0,'','',-1);
INSERT INTO `block` VALUES (8,'system','main','seven',1,0,'content',0,0,'','',-1);
INSERT INTO `block` VALUES (9,'system','help','seven',1,0,'help',0,0,'','',-1);
INSERT INTO `block` VALUES (10,'user','login','seven',1,10,'content',0,0,'','',-1);
INSERT INTO `block` VALUES (11,'user','new','seven',1,0,'dashboard_sidebar',0,0,'','',-1);
INSERT INTO `block` VALUES (12,'search','form','seven',1,-10,'dashboard_sidebar',0,0,'','',-1);
INSERT INTO `block` VALUES (13,'comment','recent','bartik',0,0,'-1',0,0,'','',1);
INSERT INTO `block` VALUES (14,'node','syndicate','bartik',0,0,'-1',0,0,'','',-1);
INSERT INTO `block` VALUES (15,'node','recent','bartik',0,0,'-1',0,0,'','',1);
INSERT INTO `block` VALUES (16,'shortcut','shortcuts','bartik',0,0,'-1',0,0,'','',-1);
INSERT INTO `block` VALUES (17,'system','management','bartik',0,0,'-1',0,0,'','',-1);
INSERT INTO `block` VALUES (18,'system','user-menu','bartik',0,0,'-1',0,0,'','',-1);
INSERT INTO `block` VALUES (19,'system','main-menu','bartik',0,0,'-1',0,0,'','',-1);
INSERT INTO `block` VALUES (20,'user','new','bartik',0,0,'-1',0,0,'','',1);
INSERT INTO `block` VALUES (21,'user','online','bartik',0,0,'-1',0,0,'','',-1);
INSERT INTO `block` VALUES (22,'comment','recent','seven',1,0,'dashboard_inactive',0,0,'','',1);
INSERT INTO `block` VALUES (23,'node','syndicate','seven',0,0,'-1',0,0,'','',-1);
INSERT INTO `block` VALUES (24,'shortcut','shortcuts','seven',0,0,'-1',0,0,'','',-1);
INSERT INTO `block` VALUES (25,'system','powered-by','seven',0,10,'-1',0,0,'','',-1);
INSERT INTO `block` VALUES (26,'system','navigation','seven',0,0,'-1',0,0,'','',-1);
INSERT INTO `block` VALUES (27,'system','management','seven',0,0,'-1',0,0,'','',-1);
INSERT INTO `block` VALUES (28,'system','user-menu','seven',0,0,'-1',0,0,'','',-1);
INSERT INTO `block` VALUES (29,'system','main-menu','seven',0,0,'-1',0,0,'','',-1);
INSERT INTO `block` VALUES (30,'user','online','seven',1,0,'dashboard_inactive',0,0,'','',-1);
/*!40000 ALTER TABLE `block` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `block_custom`
--

DROP TABLE IF EXISTS `block_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_custom` (
  `bid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The block’s block.bid.',
  `body` longtext COMMENT 'Block contents.',
  `info` varchar(128) NOT NULL DEFAULT '' COMMENT 'Block description.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the block body.',
  PRIMARY KEY (`bid`),
  UNIQUE KEY `info` (`info`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores contents of custom-made blocks.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block_custom`
--
-- ORDER BY:  `bid`

LOCK TABLES `block_custom` WRITE;
/*!40000 ALTER TABLE `block_custom` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `block_custom` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `block_node_type`
--

DROP TABLE IF EXISTS `block_node_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_node_type` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type from node_type.type.',
  PRIMARY KEY (`module`,`delta`,`type`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up display criteria for blocks based on content types';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block_node_type`
--
-- ORDER BY:  `module`,`delta`,`type`

LOCK TABLES `block_node_type` WRITE;
/*!40000 ALTER TABLE `block_node_type` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `block_node_type` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `block_role`
--

DROP TABLE IF EXISTS `block_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_role` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `rid` int(10) unsigned NOT NULL COMMENT 'The user’s role ID from users_roles.rid.',
  PRIMARY KEY (`module`,`delta`,`rid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up access permissions for blocks based on user roles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block_role`
--
-- ORDER BY:  `module`,`delta`,`rid`

LOCK TABLES `block_role` WRITE;
/*!40000 ALTER TABLE `block_role` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `block_role` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `blocked_ips`
--

DROP TABLE IF EXISTS `blocked_ips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blocked_ips` (
  `iid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: unique ID for IP addresses.',
  `ip` varchar(40) NOT NULL DEFAULT '' COMMENT 'IP address',
  PRIMARY KEY (`iid`),
  KEY `blocked_ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores blocked IP addresses.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blocked_ips`
--
-- ORDER BY:  `iid`

LOCK TABLES `blocked_ips` WRITE;
/*!40000 ALTER TABLE `blocked_ips` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `blocked_ips` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--
-- ORDER BY:  `cid`

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `cache` VALUES ('schema:runtime:','a:10:{s:7:\"comment\";a:6:{s:6:\"fields\";a:14:{s:3:\"cid\";a:2:{s:4:\"type\";s:6:\"serial\";s:8:\"not null\";b:1;}s:3:\"pid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:3:\"nid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:3:\"uid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"subject\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:8:\"hostname\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:7:\"created\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"changed\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"status\";a:5:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:1;s:4:\"size\";s:4:\"tiny\";}s:6:\"thread\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;}s:4:\"name\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:60;s:8:\"not null\";b:0;}s:4:\"mail\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:0;}s:8:\"homepage\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:0;}s:8:\"language\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:12;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}}s:7:\"indexes\";a:5:{s:18:\"comment_status_pid\";a:2:{i:0;s:3:\"pid\";i:1;s:6:\"status\";}s:15:\"comment_num_new\";a:5:{i:0;s:3:\"nid\";i:1;s:6:\"status\";i:2;s:7:\"created\";i:3;s:3:\"cid\";i:4;s:6:\"thread\";}s:11:\"comment_uid\";a:1:{i:0;s:3:\"uid\";}s:20:\"comment_nid_language\";a:2:{i:0;s:3:\"nid\";i:1;s:8:\"language\";}s:15:\"comment_created\";a:1:{i:0;s:7:\"created\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"cid\";}s:12:\"foreign keys\";a:2:{s:12:\"comment_node\";a:2:{s:5:\"table\";s:4:\"node\";s:7:\"columns\";a:1:{s:3:\"nid\";s:3:\"nid\";}}s:14:\"comment_author\";a:2:{s:5:\"table\";s:5:\"users\";s:7:\"columns\";a:1:{s:3:\"uid\";s:3:\"uid\";}}}s:6:\"module\";s:7:\"comment\";s:4:\"name\";s:7:\"comment\";}s:4:\"node\";a:7:{s:6:\"fields\";a:14:{s:3:\"nid\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:3:\"vid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:0;s:7:\"default\";N;}s:4:\"type\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:8:\"language\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:12;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:5:\"title\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:3:\"uid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"status\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:1;}s:7:\"created\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"changed\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"comment\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"promote\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"sticky\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:4:\"tnid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:9:\"translate\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:7:\"indexes\";a:9:{s:12:\"node_changed\";a:1:{i:0;s:7:\"changed\";}s:12:\"node_created\";a:1:{i:0;s:7:\"created\";}s:14:\"node_frontpage\";a:4:{i:0;s:7:\"promote\";i:1;s:6:\"status\";i:2;s:6:\"sticky\";i:3;s:7:\"created\";}s:16:\"node_status_type\";a:3:{i:0;s:6:\"status\";i:1;s:4:\"type\";i:2;s:3:\"nid\";}s:15:\"node_title_type\";a:2:{i:0;s:5:\"title\";i:1;a:2:{i:0;s:4:\"type\";i:1;i:4;}}s:9:\"node_type\";a:1:{i:0;a:2:{i:0;s:4:\"type\";i:1;i:4;}}s:3:\"uid\";a:1:{i:0;s:3:\"uid\";}s:4:\"tnid\";a:1:{i:0;s:4:\"tnid\";}s:9:\"translate\";a:1:{i:0;s:9:\"translate\";}}s:11:\"unique keys\";a:1:{s:3:\"vid\";a:1:{i:0;s:3:\"vid\";}}s:12:\"foreign keys\";a:2:{s:13:\"node_revision\";a:2:{s:5:\"table\";s:13:\"node_revision\";s:7:\"columns\";a:1:{s:3:\"vid\";s:3:\"vid\";}}s:11:\"node_author\";a:2:{s:5:\"table\";s:5:\"users\";s:7:\"columns\";a:1:{s:3:\"uid\";s:3:\"uid\";}}}s:11:\"primary key\";a:1:{i:0;s:3:\"nid\";}s:6:\"module\";s:4:\"node\";s:4:\"name\";s:4:\"node\";}s:13:\"node_revision\";a:6:{s:6:\"fields\";a:10:{s:3:\"nid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:3:\"vid\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:3:\"uid\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:5:\"title\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:3:\"log\";a:3:{s:4:\"type\";s:4:\"text\";s:8:\"not null\";b:1;s:4:\"size\";s:3:\"big\";}s:9:\"timestamp\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"status\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:1;}s:7:\"comment\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:7:\"promote\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"sticky\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:7:\"indexes\";a:2:{s:3:\"nid\";a:1:{i:0;s:3:\"nid\";}s:3:\"uid\";a:1:{i:0;s:3:\"uid\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"vid\";}s:12:\"foreign keys\";a:2:{s:14:\"versioned_node\";a:2:{s:5:\"table\";s:4:\"node\";s:7:\"columns\";a:1:{s:3:\"nid\";s:3:\"nid\";}}s:14:\"version_author\";a:2:{s:5:\"table\";s:5:\"users\";s:7:\"columns\";a:1:{s:3:\"uid\";s:3:\"uid\";}}}s:6:\"module\";s:4:\"node\";s:4:\"name\";s:13:\"node_revision\";}s:12:\"file_managed\";a:7:{s:6:\"fields\";a:8:{s:3:\"fid\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:3:\"uid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:8:\"filename\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:3:\"uri\";a:5:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";s:6:\"binary\";b:1;}s:8:\"filemime\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:8:\"filesize\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"status\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:4:\"tiny\";}s:9:\"timestamp\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:7:\"indexes\";a:3:{s:3:\"uid\";a:1:{i:0;s:3:\"uid\";}s:6:\"status\";a:1:{i:0;s:6:\"status\";}s:9:\"timestamp\";a:1:{i:0;s:9:\"timestamp\";}}s:11:\"unique keys\";a:1:{s:3:\"uri\";a:1:{i:0;s:3:\"uri\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"fid\";}s:12:\"foreign keys\";a:1:{s:10:\"file_owner\";a:2:{s:5:\"table\";s:5:\"users\";s:7:\"columns\";a:1:{s:3:\"uid\";s:3:\"uid\";}}}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:12:\"file_managed\";}s:18:\"taxonomy_term_data\";a:6:{s:6:\"fields\";a:6:{s:3:\"tid\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:3:\"vid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:4:\"name\";a:5:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";s:12:\"translatable\";b:1;}s:11:\"description\";a:4:{s:4:\"type\";s:4:\"text\";s:8:\"not null\";b:0;s:4:\"size\";s:3:\"big\";s:12:\"translatable\";b:1;}s:6:\"format\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:0;}s:6:\"weight\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:11:\"primary key\";a:1:{i:0;s:3:\"tid\";}s:12:\"foreign keys\";a:1:{s:10:\"vocabulary\";a:2:{s:5:\"table\";s:19:\"taxonomy_vocabulary\";s:7:\"columns\";a:1:{s:3:\"vid\";s:3:\"vid\";}}}s:7:\"indexes\";a:3:{s:13:\"taxonomy_tree\";a:3:{i:0;s:3:\"vid\";i:1;s:6:\"weight\";i:2;s:4:\"name\";}s:8:\"vid_name\";a:2:{i:0;s:3:\"vid\";i:1;s:4:\"name\";}s:4:\"name\";a:1:{i:0;s:4:\"name\";}}s:6:\"module\";s:8:\"taxonomy\";s:4:\"name\";s:18:\"taxonomy_term_data\";}s:19:\"taxonomy_vocabulary\";a:6:{s:6:\"fields\";a:7:{s:3:\"vid\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;}s:4:\"name\";a:5:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";s:12:\"translatable\";b:1;}s:12:\"machine_name\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:11:\"description\";a:4:{s:4:\"type\";s:4:\"text\";s:8:\"not null\";b:0;s:4:\"size\";s:3:\"big\";s:12:\"translatable\";b:1;}s:9:\"hierarchy\";a:5:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:4:\"tiny\";}s:6:\"module\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:6:\"weight\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}}s:11:\"primary key\";a:1:{i:0;s:3:\"vid\";}s:7:\"indexes\";a:1:{s:4:\"list\";a:2:{i:0;s:6:\"weight\";i:1;s:4:\"name\";}}s:11:\"unique keys\";a:1:{s:12:\"machine_name\";a:1:{i:0;s:12:\"machine_name\";}}s:6:\"module\";s:8:\"taxonomy\";s:4:\"name\";s:19:\"taxonomy_vocabulary\";}s:5:\"users\";a:7:{s:6:\"fields\";a:16:{s:3:\"uid\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"unsigned\";b:1;s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:4:\"name\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:60;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:4:\"pass\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:128;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:4:\"mail\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:254;s:8:\"not null\";b:0;s:7:\"default\";s:0:\"\";}s:5:\"theme\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:9:\"signature\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:16:\"signature_format\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:0;}s:7:\"created\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"access\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:5:\"login\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"status\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:4:\"tiny\";}s:8:\"timezone\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:0;}s:8:\"language\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:12;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:7:\"picture\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:4:\"init\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:254;s:8:\"not null\";b:0;s:7:\"default\";s:0:\"\";}s:4:\"data\";a:4:{s:4:\"type\";s:4:\"blob\";s:8:\"not null\";b:0;s:4:\"size\";s:3:\"big\";s:9:\"serialize\";b:1;}}s:7:\"indexes\";a:4:{s:6:\"access\";a:1:{i:0;s:6:\"access\";}s:7:\"created\";a:1:{i:0;s:7:\"created\";}s:4:\"mail\";a:1:{i:0;s:4:\"mail\";}s:7:\"picture\";a:1:{i:0;s:7:\"picture\";}}s:11:\"unique keys\";a:1:{s:4:\"name\";a:1:{i:0;s:4:\"name\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"uid\";}s:12:\"foreign keys\";a:1:{s:16:\"signature_format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:16:\"signature_format\";s:6:\"format\";}}}s:6:\"module\";s:4:\"user\";s:4:\"name\";s:5:\"users\";}s:5:\"block\";a:6:{s:6:\"fields\";a:12:{s:3:\"bid\";a:2:{s:4:\"type\";s:6:\"serial\";s:8:\"not null\";b:1;}s:6:\"module\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:5:\"delta\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:32;s:8:\"not null\";b:1;s:7:\"default\";s:1:\"0\";}s:5:\"theme\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:6:\"status\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:4:\"tiny\";}s:6:\"weight\";a:3:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;}s:6:\"region\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";}s:6:\"custom\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:4:\"tiny\";}s:10:\"visibility\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:0;s:4:\"size\";s:4:\"tiny\";}s:5:\"pages\";a:2:{s:4:\"type\";s:4:\"text\";s:8:\"not null\";b:1;}s:5:\"title\";a:5:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:1;s:7:\"default\";s:0:\"\";s:12:\"translatable\";b:1;}s:5:\"cache\";a:4:{s:4:\"type\";s:3:\"int\";s:8:\"not null\";b:1;s:7:\"default\";i:1;s:4:\"size\";s:4:\"tiny\";}}s:11:\"primary key\";a:1:{i:0;s:3:\"bid\";}s:11:\"unique keys\";a:1:{s:3:\"tmd\";a:3:{i:0;s:5:\"theme\";i:1;s:6:\"module\";i:2;s:5:\"delta\";}}s:7:\"indexes\";a:1:{s:4:\"list\";a:5:{i:0;s:5:\"theme\";i:1;s:6:\"status\";i:2;s:6:\"region\";i:3;s:6:\"weight\";i:4;s:6:\"module\";}}s:6:\"module\";s:5:\"block\";s:4:\"name\";s:5:\"block\";}s:16:\"date_format_type\";a:5:{s:6:\"fields\";a:3:{s:4:\"type\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:1;}s:5:\"title\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:255;s:8:\"not null\";b:1;}s:6:\"locked\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:4:\"tiny\";s:7:\"default\";i:0;s:8:\"not null\";b:1;}}s:11:\"primary key\";a:1:{i:0;s:4:\"type\";}s:7:\"indexes\";a:1:{s:5:\"title\";a:1:{i:0;s:5:\"title\";}}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:16:\"date_format_type\";}s:12:\"date_formats\";a:5:{s:6:\"fields\";a:4:{s:4:\"dfid\";a:3:{s:4:\"type\";s:6:\"serial\";s:8:\"not null\";b:1;s:8:\"unsigned\";b:1;}s:6:\"format\";a:4:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:100;s:8:\"not null\";b:1;s:6:\"binary\";b:1;}s:4:\"type\";a:3:{s:4:\"type\";s:7:\"varchar\";s:6:\"length\";i:64;s:8:\"not null\";b:1;}s:6:\"locked\";a:4:{s:4:\"type\";s:3:\"int\";s:4:\"size\";s:4:\"tiny\";s:7:\"default\";i:0;s:8:\"not null\";b:1;}}s:11:\"primary key\";a:1:{i:0;s:4:\"dfid\";}s:11:\"unique keys\";a:1:{s:7:\"formats\";a:2:{i:0;s:6:\"format\";i:1;s:4:\"type\";}}s:6:\"module\";s:6:\"system\";s:4:\"name\";s:12:\"date_formats\";}}',0,1384776320,1);
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `cache_block`
--

DROP TABLE IF EXISTS `cache_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_block` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Block module to store already built...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_block`
--
-- ORDER BY:  `cid`

LOCK TABLES `cache_block` WRITE;
/*!40000 ALTER TABLE `cache_block` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `cache_block` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `cache_bootstrap`
--

DROP TABLE IF EXISTS `cache_bootstrap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_bootstrap` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for data required to bootstrap Drupal, may be...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_bootstrap`
--
-- ORDER BY:  `cid`

LOCK TABLES `cache_bootstrap` WRITE;
/*!40000 ALTER TABLE `cache_bootstrap` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `cache_bootstrap` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `cache_field`
--

DROP TABLE IF EXISTS `cache_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_field` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Generic cache table for caching things not separated out...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_field`
--
-- ORDER BY:  `cid`

LOCK TABLES `cache_field` WRITE;
/*!40000 ALTER TABLE `cache_field` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `cache_field` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `cache_filter`
--

DROP TABLE IF EXISTS `cache_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_filter` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Filter module to store already...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_filter`
--
-- ORDER BY:  `cid`

LOCK TABLES `cache_filter` WRITE;
/*!40000 ALTER TABLE `cache_filter` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `cache_filter` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `cache_form`
--

DROP TABLE IF EXISTS `cache_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_form` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the form system to store recently built...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_form`
--
-- ORDER BY:  `cid`

LOCK TABLES `cache_form` WRITE;
/*!40000 ALTER TABLE `cache_form` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `cache_form` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `cache_image`
--

DROP TABLE IF EXISTS `cache_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_image` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store information about image...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_image`
--
-- ORDER BY:  `cid`

LOCK TABLES `cache_image` WRITE;
/*!40000 ALTER TABLE `cache_image` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `cache_image` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `cache_menu`
--

DROP TABLE IF EXISTS `cache_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_menu` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the menu system to store router...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_menu`
--
-- ORDER BY:  `cid`

LOCK TABLES `cache_menu` WRITE;
/*!40000 ALTER TABLE `cache_menu` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `cache_menu` VALUES ('menu_custom','a:4:{s:9:\"main-menu\";a:3:{s:9:\"menu_name\";s:9:\"main-menu\";s:5:\"title\";s:9:\"Main menu\";s:11:\"description\";s:115:\"The <em>Main</em> menu is used on many sites to show the major sections of the site, often in a top navigation bar.\";}s:10:\"management\";a:3:{s:9:\"menu_name\";s:10:\"management\";s:5:\"title\";s:10:\"Management\";s:11:\"description\";s:69:\"The <em>Management</em> menu contains links for administrative tasks.\";}s:10:\"navigation\";a:3:{s:9:\"menu_name\";s:10:\"navigation\";s:5:\"title\";s:10:\"Navigation\";s:11:\"description\";s:150:\"The <em>Navigation</em> menu contains links intended for site visitors. Links are added to the <em>Navigation</em> menu automatically by some modules.\";}s:9:\"user-menu\";a:3:{s:9:\"menu_name\";s:9:\"user-menu\";s:5:\"title\";s:9:\"User menu\";s:11:\"description\";s:99:\"The <em>User</em> menu contains links related to the user\'s account, as well as the \'Log out\' link.\";}}',0,1384776320,1);
/*!40000 ALTER TABLE `cache_menu` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `cache_page`
--

DROP TABLE IF EXISTS `cache_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_page` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table used to store compressed pages for anonymous...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_page`
--
-- ORDER BY:  `cid`

LOCK TABLES `cache_page` WRITE;
/*!40000 ALTER TABLE `cache_page` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `cache_page` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `cache_path`
--

DROP TABLE IF EXISTS `cache_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_path` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for path alias lookup.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_path`
--
-- ORDER BY:  `cid`

LOCK TABLES `cache_path` WRITE;
/*!40000 ALTER TABLE `cache_path` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `cache_path` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `cache_update`
--

DROP TABLE IF EXISTS `cache_update`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_update` (
  `cid` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique cache ID.',
  `data` longblob COMMENT 'A collection of data to cache.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry should expire, or 0 for never.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when the cache entry was created.',
  `serialized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate whether content is serialized (1) or not (0).',
  PRIMARY KEY (`cid`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Cache table for the Update module to store information...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_update`
--
-- ORDER BY:  `cid`

LOCK TABLES `cache_update` WRITE;
/*!40000 ALTER TABLE `cache_update` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `cache_update` VALUES ('available_releases::drupal','a:11:{s:5:\"title\";s:11:\"Drupal core\";s:10:\"short_name\";s:6:\"drupal\";s:4:\"type\";s:12:\"project_core\";s:11:\"api_version\";s:3:\"7.x\";s:17:\"recommended_major\";s:1:\"7\";s:16:\"supported_majors\";s:1:\"7\";s:13:\"default_major\";s:1:\"7\";s:14:\"project_status\";s:9:\"published\";s:4:\"link\";s:32:\"http://drupal.org/project/drupal\";s:5:\"terms\";s:15:\"\n   \n   \n   \n  \";s:8:\"releases\";a:39:{s:4:\"7.23\";a:13:{s:4:\"name\";s:11:\"drupal 7.23\";s:7:\"version\";s:4:\"7.23\";s:3:\"tag\";s:4:\"7.23\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"23\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:43:\"http://drupal.org/drupal-7.23-release-notes\";s:13:\"download_link\";s:55:\"http://ftp.drupal.org/files/projects/drupal-7.23.tar.gz\";s:4:\"date\";s:10:\"1375928239\";s:6:\"mdhash\";s:32:\"0beca6fec15b8cf8c35a6fdda6675342\";s:8:\"filesize\";s:7:\"3191695\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:9:\"Bug fixes\";}}}s:4:\"7.22\";a:13:{s:4:\"name\";s:11:\"drupal 7.22\";s:7:\"version\";s:4:\"7.22\";s:3:\"tag\";s:4:\"7.22\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"22\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:43:\"http://drupal.org/drupal-7.22-release-notes\";s:13:\"download_link\";s:55:\"http://ftp.drupal.org/files/projects/drupal-7.22.tar.gz\";s:4:\"date\";s:10:\"1365027013\";s:6:\"mdhash\";s:32:\"068d7a77958fce6bb002659aa7ccaeb7\";s:8:\"filesize\";s:7:\"3183014\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:9:\"Bug fixes\";}}}s:4:\"7.21\";a:13:{s:4:\"name\";s:11:\"drupal 7.21\";s:7:\"version\";s:4:\"7.21\";s:3:\"tag\";s:4:\"7.21\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"21\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:43:\"http://drupal.org/drupal-7.21-release-notes\";s:13:\"download_link\";s:55:\"http://ftp.drupal.org/files/projects/drupal-7.21.tar.gz\";s:4:\"date\";s:10:\"1362616997\";s:6:\"mdhash\";s:32:\"eff054cd53be39ff719f77c81dce1aac\";s:8:\"filesize\";s:7:\"3163798\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:9:\"Bug fixes\";}}}s:4:\"7.20\";a:13:{s:4:\"name\";s:11:\"drupal 7.20\";s:7:\"version\";s:4:\"7.20\";s:3:\"tag\";s:4:\"7.20\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"20\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:43:\"http://drupal.org/drupal-7.20-release-notes\";s:13:\"download_link\";s:55:\"http://ftp.drupal.org/files/projects/drupal-7.20.tar.gz\";s:4:\"date\";s:10:\"1361393684\";s:6:\"mdhash\";s:32:\"ee576d63f1fd8a1f1c072a56978da0c5\";s:8:\"filesize\";s:7:\"3163257\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:15:\"Security update\";}}}s:4:\"7.19\";a:13:{s:4:\"name\";s:11:\"drupal 7.19\";s:7:\"version\";s:4:\"7.19\";s:3:\"tag\";s:4:\"7.19\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"19\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:43:\"http://drupal.org/drupal-7.19-release-notes\";s:13:\"download_link\";s:55:\"http://ftp.drupal.org/files/projects/drupal-7.19.tar.gz\";s:4:\"date\";s:10:\"1358374871\";s:6:\"mdhash\";s:32:\"c1dd3960f1555df208c80ef612e0c53a\";s:8:\"filesize\";s:7:\"3163130\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:15:\"Security update\";}}}s:4:\"7.18\";a:13:{s:4:\"name\";s:11:\"drupal 7.18\";s:7:\"version\";s:4:\"7.18\";s:3:\"tag\";s:4:\"7.18\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"18\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:43:\"http://drupal.org/drupal-7.18-release-notes\";s:13:\"download_link\";s:55:\"http://ftp.drupal.org/files/projects/drupal-7.18.tar.gz\";s:4:\"date\";s:10:\"1355944004\";s:6:\"mdhash\";s:32:\"5c048f60a53acd7cb3c2b6d5fe42f082\";s:8:\"filesize\";s:7:\"3162333\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:15:\"Security update\";}}}s:4:\"7.17\";a:13:{s:4:\"name\";s:11:\"drupal 7.17\";s:7:\"version\";s:4:\"7.17\";s:3:\"tag\";s:4:\"7.17\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"17\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:43:\"http://drupal.org/drupal-7.17-release-notes\";s:13:\"download_link\";s:55:\"http://ftp.drupal.org/files/projects/drupal-7.17.tar.gz\";s:4:\"date\";s:10:\"1352325358\";s:6:\"mdhash\";s:32:\"439e8ca7e6a33bb879a4624d8f01bed0\";s:8:\"filesize\";s:7:\"3162429\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:9:\"Bug fixes\";}}}s:4:\"7.16\";a:13:{s:4:\"name\";s:11:\"drupal 7.16\";s:7:\"version\";s:4:\"7.16\";s:3:\"tag\";s:4:\"7.16\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"16\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:30:\"http://drupal.org/node/1815904\";s:13:\"download_link\";s:55:\"http://ftp.drupal.org/files/projects/drupal-7.16.tar.gz\";s:4:\"date\";s:10:\"1350508568\";s:6:\"mdhash\";s:32:\"352497b2df94b5308e31cb8da020b631\";s:8:\"filesize\";s:7:\"3142889\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:15:\"Security update\";}}}s:4:\"7.15\";a:13:{s:4:\"name\";s:11:\"drupal 7.15\";s:7:\"version\";s:4:\"7.15\";s:3:\"tag\";s:4:\"7.15\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"15\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:30:\"http://drupal.org/node/1708292\";s:13:\"download_link\";s:55:\"http://ftp.drupal.org/files/projects/drupal-7.15.tar.gz\";s:4:\"date\";s:10:\"1343839327\";s:6:\"mdhash\";s:32:\"f42c9baccd74e1d035d61ff537ae21b4\";s:8:\"filesize\";s:7:\"3142219\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:9:\"Bug fixes\";}}}s:4:\"7.14\";a:13:{s:4:\"name\";s:11:\"drupal 7.14\";s:7:\"version\";s:4:\"7.14\";s:3:\"tag\";s:4:\"7.14\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"14\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:30:\"http://drupal.org/node/1558424\";s:13:\"download_link\";s:55:\"http://ftp.drupal.org/files/projects/drupal-7.14.tar.gz\";s:4:\"date\";s:10:\"1335997556\";s:6:\"mdhash\";s:32:\"af7abd95c03ecad4e1567ed94a438334\";s:8:\"filesize\";s:7:\"3128473\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:9:\"Bug fixes\";}}}s:4:\"7.13\";a:13:{s:4:\"name\";s:11:\"drupal 7.13\";s:7:\"version\";s:4:\"7.13\";s:3:\"tag\";s:4:\"7.13\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"13\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:30:\"http://drupal.org/node/1558412\";s:13:\"download_link\";s:55:\"http://ftp.drupal.org/files/projects/drupal-7.13.tar.gz\";s:4:\"date\";s:10:\"1335997261\";s:6:\"mdhash\";s:32:\"80587b66375c7fc539414a20a2c6f2de\";s:8:\"filesize\";s:7:\"3088448\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:15:\"Security update\";}}}s:4:\"7.12\";a:13:{s:4:\"name\";s:11:\"drupal 7.12\";s:7:\"version\";s:4:\"7.12\";s:3:\"tag\";s:4:\"7.12\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"12\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:30:\"http://drupal.org/node/1425104\";s:13:\"download_link\";s:55:\"http://ftp.drupal.org/files/projects/drupal-7.12.tar.gz\";s:4:\"date\";s:10:\"1328134561\";s:6:\"mdhash\";s:32:\"db2284beb97241c9bdca9c638cd8a4f1\";s:8:\"filesize\";s:7:\"3088472\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";}}}s:4:\"7.11\";a:13:{s:4:\"name\";s:11:\"drupal 7.11\";s:7:\"version\";s:4:\"7.11\";s:3:\"tag\";s:4:\"7.11\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"11\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:30:\"http://drupal.org/node/1425092\";s:13:\"download_link\";s:55:\"http://ftp.drupal.org/files/projects/drupal-7.11.tar.gz\";s:4:\"date\";s:10:\"1328134275\";s:6:\"mdhash\";s:32:\"e9857e1749762367d7631d74cc6564a7\";s:8:\"filesize\";s:7:\"2789336\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:15:\"Security update\";}}}s:4:\"7.10\";a:13:{s:4:\"name\";s:11:\"drupal 7.10\";s:7:\"version\";s:4:\"7.10\";s:3:\"tag\";s:4:\"7.10\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"10\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:30:\"http://drupal.org/node/1361968\";s:13:\"download_link\";s:55:\"http://ftp.drupal.org/files/projects/drupal-7.10.tar.gz\";s:4:\"date\";s:10:\"1323125439\";s:6:\"mdhash\";s:32:\"1caafb849bc756e62dd874b90b95ab31\";s:8:\"filesize\";s:7:\"3067653\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";}}}s:3:\"7.9\";a:13:{s:4:\"name\";s:10:\"drupal 7.9\";s:7:\"version\";s:3:\"7.9\";s:3:\"tag\";s:3:\"7.9\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"9\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:30:\"http://drupal.org/node/1322736\";s:13:\"download_link\";s:54:\"http://ftp.drupal.org/files/projects/drupal-7.9.tar.gz\";s:4:\"date\";s:10:\"1319660731\";s:6:\"mdhash\";s:32:\"7f45f109c413ca69ebb6e3140ed47225\";s:8:\"filesize\";s:7:\"2788086\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";}}}s:3:\"7.8\";a:13:{s:4:\"name\";s:10:\"drupal 7.8\";s:7:\"version\";s:3:\"7.8\";s:3:\"tag\";s:3:\"7.8\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"8\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:30:\"http://drupal.org/node/1265840\";s:13:\"download_link\";s:54:\"http://ftp.drupal.org/files/projects/drupal-7.8.tar.gz\";s:4:\"date\";s:10:\"1314817617\";s:6:\"mdhash\";s:32:\"e0226b56e8d5c57c6b126e8ed5866b1f\";s:8:\"filesize\";s:7:\"2766967\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:9:\"Bug fixes\";}}}s:3:\"7.7\";a:13:{s:4:\"name\";s:10:\"drupal 7.7\";s:7:\"version\";s:3:\"7.7\";s:3:\"tag\";s:3:\"7.7\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"7\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:30:\"http://drupal.org/node/1231826\";s:13:\"download_link\";s:54:\"http://ftp.drupal.org/files/projects/drupal-7.7.tar.gz\";s:4:\"date\";s:10:\"1311813880\";s:6:\"mdhash\";s:32:\"2eeb63fd1ef6b23b0a9f5f6b8aef8850\";s:8:\"filesize\";s:7:\"2754113\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:9:\"Bug fixes\";}}}s:3:\"7.6\";a:13:{s:4:\"name\";s:10:\"drupal 7.6\";s:7:\"version\";s:3:\"7.6\";s:3:\"tag\";s:3:\"7.6\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"6\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:30:\"http://drupal.org/node/1231586\";s:13:\"download_link\";s:54:\"http://ftp.drupal.org/files/projects/drupal-7.6.tar.gz\";s:4:\"date\";s:10:\"1311798716\";s:6:\"mdhash\";s:32:\"e88e63c4da9e5e170f089d050c88c827\";s:8:\"filesize\";s:7:\"2753784\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:9:\"Bug fixes\";}}}s:3:\"7.5\";a:13:{s:4:\"name\";s:10:\"drupal 7.5\";s:7:\"version\";s:3:\"7.5\";s:3:\"tag\";s:3:\"7.5\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"5\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:30:\"http://drupal.org/node/1231582\";s:13:\"download_link\";s:54:\"http://ftp.drupal.org/files/projects/drupal-7.5.tar.gz\";s:4:\"date\";s:10:\"1311798416\";s:6:\"mdhash\";s:32:\"36d65b7a97c58226c64a6abdf481de45\";s:8:\"filesize\";s:7:\"2744690\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:9:\"Bug fixes\";}}}s:3:\"7.4\";a:13:{s:4:\"name\";s:10:\"drupal 7.4\";s:7:\"version\";s:3:\"7.4\";s:3:\"tag\";s:3:\"7.4\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"4\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:30:\"http://drupal.org/node/1204634\";s:13:\"download_link\";s:54:\"http://ftp.drupal.org/files/projects/drupal-7.4.tar.gz\";s:4:\"date\";s:10:\"1309397516\";s:6:\"mdhash\";s:32:\"84704de078e9f5432c9bb5c6ecd841d4\";s:8:\"filesize\";s:7:\"2744808\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:9:\"Bug fixes\";}}}s:3:\"7.3\";a:13:{s:4:\"name\";s:10:\"drupal 7.3\";s:7:\"version\";s:3:\"7.3\";s:3:\"tag\";s:3:\"7.3\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"3\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:30:\"http://drupal.org/node/1204628\";s:13:\"download_link\";s:54:\"http://ftp.drupal.org/files/projects/drupal-7.3.tar.gz\";s:4:\"date\";s:10:\"1309397216\";s:6:\"mdhash\";s:32:\"c290775724bc309647d84d03ddb88e2e\";s:8:\"filesize\";s:7:\"2735461\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:15:\"Security update\";}}}s:3:\"7.2\";a:13:{s:4:\"name\";s:10:\"drupal 7.2\";s:7:\"version\";s:3:\"7.2\";s:3:\"tag\";s:3:\"7.2\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"2\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:30:\"http://drupal.org/node/1168946\";s:13:\"download_link\";s:54:\"http://ftp.drupal.org/files/projects/drupal-7.2.tar.gz\";s:4:\"date\";s:10:\"1306357017\";s:6:\"mdhash\";s:32:\"cf88c87e3694ebd15b62ba6f6a69124f\";s:8:\"filesize\";s:7:\"2731345\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:9:\"Bug fixes\";}}}s:3:\"7.1\";a:13:{s:4:\"name\";s:10:\"drupal 7.1\";s:7:\"version\";s:3:\"7.1\";s:3:\"tag\";s:3:\"7.1\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"1\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:30:\"http://drupal.org/node/1168910\";s:13:\"download_link\";s:54:\"http://ftp.drupal.org/files/projects/drupal-7.1.tar.gz\";s:4:\"date\";s:10:\"1306354916\";s:6:\"mdhash\";s:32:\"27eb45cb894a76f3a9ae6715584a10cc\";s:8:\"filesize\";s:7:\"2713977\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:15:\"Security update\";}}}s:3:\"7.0\";a:13:{s:4:\"name\";s:10:\"drupal 7.0\";s:7:\"version\";s:3:\"7.0\";s:3:\"tag\";s:3:\"7.0\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:30:\"http://drupal.org/node/1015392\";s:13:\"download_link\";s:54:\"http://ftp.drupal.org/files/projects/drupal-7.0.tar.gz\";s:4:\"date\";s:10:\"1294208759\";s:6:\"mdhash\";s:32:\"e96c0a5e47c5d7706897384069dfb920\";s:8:\"filesize\";s:7:\"2728271\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:9:\"Bug fixes\";}}}s:7:\"7.0-rc4\";a:14:{s:4:\"name\";s:14:\"drupal 7.0-rc4\";s:7:\"version\";s:7:\"7.0-rc4\";s:3:\"tag\";s:8:\"7.0-rc-4\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:3:\"rc4\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:30:\"http://drupal.org/node/1010382\";s:13:\"download_link\";s:58:\"http://ftp.drupal.org/files/projects/drupal-7.0-rc4.tar.gz\";s:4:\"date\";s:10:\"1293684084\";s:6:\"mdhash\";s:32:\"104c08e609c64bb1e45b55a7ad1ad857\";s:8:\"filesize\";s:7:\"2717666\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:9:\"Bug fixes\";}}}s:7:\"7.0-rc3\";a:14:{s:4:\"name\";s:14:\"drupal 7.0-rc3\";s:7:\"version\";s:7:\"7.0-rc3\";s:3:\"tag\";s:8:\"7.0-rc-3\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:3:\"rc3\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:30:\"http://drupal.org/node/1005976\";s:13:\"download_link\";s:58:\"http://ftp.drupal.org/files/projects/drupal-7.0-rc3.tar.gz\";s:4:\"date\";s:10:\"1293099424\";s:6:\"mdhash\";s:32:\"be9a3f190e2648fa03dcb2bf3d8be199\";s:8:\"filesize\";s:7:\"2719115\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:9:\"Bug fixes\";}}}s:7:\"7.0-rc2\";a:14:{s:4:\"name\";s:14:\"drupal 7.0-rc2\";s:7:\"version\";s:7:\"7.0-rc2\";s:3:\"tag\";s:8:\"7.0-rc-2\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:3:\"rc2\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:29:\"http://drupal.org/node/995778\";s:13:\"download_link\";s:58:\"http://ftp.drupal.org/files/projects/drupal-7.0-rc2.tar.gz\";s:4:\"date\";s:10:\"1292101847\";s:6:\"mdhash\";s:32:\"f31982c73f1707ddccb2927325bc9cb9\";s:8:\"filesize\";s:7:\"2705734\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:9:\"Bug fixes\";}}}s:7:\"7.0-rc1\";a:14:{s:4:\"name\";s:14:\"drupal 7.0-rc1\";s:7:\"version\";s:7:\"7.0-rc1\";s:3:\"tag\";s:8:\"7.0-rc-1\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:3:\"rc1\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:29:\"http://drupal.org/node/985946\";s:13:\"download_link\";s:58:\"http://ftp.drupal.org/files/projects/drupal-7.0-rc1.tar.gz\";s:4:\"date\";s:10:\"1291190142\";s:6:\"mdhash\";s:32:\"b554e79cf60c02d4dec592151c4b58ee\";s:8:\"filesize\";s:7:\"2694689\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:15:\"Security update\";i:1;s:12:\"New features\";i:2;s:9:\"Bug fixes\";}}}s:9:\"7.0-beta3\";a:14:{s:4:\"name\";s:16:\"drupal 7.0-beta3\";s:7:\"version\";s:9:\"7.0-beta3\";s:3:\"tag\";s:9:\"7.0-beta3\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:5:\"beta3\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:29:\"http://drupal.org/node/971088\";s:13:\"download_link\";s:60:\"http://ftp.drupal.org/files/projects/drupal-7.0-beta3.tar.gz\";s:4:\"date\";s:10:\"1289694735\";s:6:\"mdhash\";s:32:\"c942f010a2535586c4578cd7b107c652\";s:8:\"filesize\";s:7:\"2660883\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:15:\"Security update\";i:1;s:12:\"New features\";i:2;s:9:\"Bug fixes\";}}}s:9:\"7.0-beta2\";a:14:{s:4:\"name\";s:16:\"drupal 7.0-beta2\";s:7:\"version\";s:9:\"7.0-beta2\";s:3:\"tag\";s:9:\"7.0-beta2\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:5:\"beta2\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:29:\"http://drupal.org/node/950318\";s:13:\"download_link\";s:60:\"http://ftp.drupal.org/files/projects/drupal-7.0-beta2.tar.gz\";s:4:\"date\";s:10:\"1287812133\";s:6:\"mdhash\";s:32:\"c2de0bdb657b77af8c8369a355cab8ce\";s:8:\"filesize\";s:7:\"2638949\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";}}}s:9:\"7.0-beta1\";a:14:{s:4:\"name\";s:16:\"drupal 7.0-beta1\";s:7:\"version\";s:9:\"7.0-beta1\";s:3:\"tag\";s:9:\"7.0-beta1\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:5:\"beta1\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:29:\"http://drupal.org/node/934174\";s:13:\"download_link\";s:60:\"http://ftp.drupal.org/files/projects/drupal-7.0-beta1.tar.gz\";s:4:\"date\";s:10:\"1286422866\";s:6:\"mdhash\";s:32:\"490ce0d95eacc15f2918becd60f6821c\";s:8:\"filesize\";s:7:\"2622225\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:9:\"Bug fixes\";}}}s:10:\"7.0-alpha7\";a:14:{s:4:\"name\";s:17:\"drupal 7.0-alpha7\";s:7:\"version\";s:10:\"7.0-alpha7\";s:3:\"tag\";s:10:\"7.0-alpha7\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:6:\"alpha7\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:29:\"http://drupal.org/node/913030\";s:13:\"download_link\";s:61:\"http://ftp.drupal.org/files/projects/drupal-7.0-alpha7.tar.gz\";s:4:\"date\";s:10:\"1284599764\";s:6:\"mdhash\";s:32:\"15183fcf862be97f7e96991e6e56fe2e\";s:8:\"filesize\";s:7:\"2586833\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:9:\"Bug fixes\";}}}s:10:\"7.0-alpha6\";a:14:{s:4:\"name\";s:17:\"drupal 7.0-alpha6\";s:7:\"version\";s:10:\"7.0-alpha6\";s:3:\"tag\";s:10:\"7.0-alpha6\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:6:\"alpha6\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:29:\"http://drupal.org/node/848970\";s:13:\"download_link\";s:61:\"http://ftp.drupal.org/files/projects/drupal-7.0-alpha6.tar.gz\";s:4:\"date\";s:10:\"1278634809\";s:6:\"mdhash\";s:32:\"eb64647263affc36f76d1e7ffb751d32\";s:8:\"filesize\";s:7:\"2458211\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:15:\"Security update\";i:1;s:12:\"New features\";i:2;s:9:\"Bug fixes\";}}}s:10:\"7.0-alpha5\";a:14:{s:4:\"name\";s:17:\"drupal 7.0-alpha5\";s:7:\"version\";s:10:\"7.0-alpha5\";s:3:\"tag\";s:10:\"7.0-alpha5\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:6:\"alpha5\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:29:\"http://drupal.org/node/806978\";s:13:\"download_link\";s:61:\"http://ftp.drupal.org/files/projects/drupal-7.0-alpha5.tar.gz\";s:4:\"date\";s:10:\"1274628613\";s:6:\"mdhash\";s:32:\"de9c1d51f0ce730f7356bd0a160e8ce1\";s:8:\"filesize\";s:7:\"2424226\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:9:\"Bug fixes\";}}}s:10:\"7.0-alpha4\";a:14:{s:4:\"name\";s:17:\"drupal 7.0-alpha4\";s:7:\"version\";s:10:\"7.0-alpha4\";s:3:\"tag\";s:10:\"7.0-alpha4\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:6:\"alpha4\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:29:\"http://drupal.org/node/782394\";s:13:\"download_link\";s:61:\"http://ftp.drupal.org/files/projects/drupal-7.0-alpha4.tar.gz\";s:4:\"date\";s:10:\"1272318014\";s:6:\"mdhash\";s:32:\"c8f371a388bc65b2211d7d29856fb993\";s:8:\"filesize\";s:7:\"2403384\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:15:\"Security update\";i:1;s:9:\"Bug fixes\";}}}s:10:\"7.0-alpha3\";a:14:{s:4:\"name\";s:17:\"drupal 7.0-alpha3\";s:7:\"version\";s:10:\"7.0-alpha3\";s:3:\"tag\";s:10:\"7.0-alpha3\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:6:\"alpha3\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:29:\"http://drupal.org/node/748690\";s:13:\"download_link\";s:61:\"http://ftp.drupal.org/files/projects/drupal-7.0-alpha3.tar.gz\";s:4:\"date\";s:10:\"1269192317\";s:6:\"mdhash\";s:32:\"9efc083f09d6b523d655bc90a6869945\";s:8:\"filesize\";s:7:\"2357934\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:3:{i:0;s:15:\"Security update\";i:1;s:12:\"New features\";i:2;s:9:\"Bug fixes\";}}}s:10:\"7.0-alpha2\";a:14:{s:4:\"name\";s:17:\"drupal 7.0-alpha2\";s:7:\"version\";s:10:\"7.0-alpha2\";s:3:\"tag\";s:10:\"7.0-alpha2\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:6:\"alpha2\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:29:\"http://drupal.org/node/721114\";s:13:\"download_link\";s:61:\"http://ftp.drupal.org/files/projects/drupal-7.0-alpha2.tar.gz\";s:4:\"date\";s:10:\"1266777910\";s:6:\"mdhash\";s:32:\"cfbfdd2249638a266054f2532348065d\";s:8:\"filesize\";s:7:\"2314834\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:9:\"Bug fixes\";}}}s:10:\"7.0-alpha1\";a:14:{s:4:\"name\";s:17:\"drupal 7.0-alpha1\";s:7:\"version\";s:10:\"7.0-alpha1\";s:3:\"tag\";s:10:\"7.0-alpha1\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:1:\"0\";s:13:\"version_extra\";s:6:\"alpha1\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:29:\"http://drupal.org/node/685748\";s:13:\"download_link\";s:61:\"http://ftp.drupal.org/files/projects/drupal-7.0-alpha1.tar.gz\";s:4:\"date\";s:10:\"1263566711\";s:6:\"mdhash\";s:32:\"508109c6cf0ead868e02d8c3db2a4d1f\";s:8:\"filesize\";s:7:\"2283220\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:12:\"New features\";}}}s:7:\"7.x-dev\";a:13:{s:4:\"name\";s:14:\"Drupal 7.x-dev\";s:7:\"version\";s:7:\"7.x-dev\";s:3:\"tag\";s:3:\"7.x\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_extra\";s:3:\"dev\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:29:\"http://drupal.org/node/156281\";s:13:\"download_link\";s:58:\"http://ftp.drupal.org/files/projects/drupal-7.x-dev.tar.gz\";s:4:\"date\";s:10:\"1382057126\";s:6:\"mdhash\";s:32:\"fd3d5c0dc96c680763fd52f1f8723b69\";s:8:\"filesize\";s:7:\"3192197\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:2:{i:0;s:12:\"New features\";i:1;s:9:\"Bug fixes\";}}}}}',1384862665,1384776245,1);
INSERT INTO `cache_update` VALUES ('fetch_failures','a:0:{}',1384776565,1384776245,1);
INSERT INTO `cache_update` VALUES ('update_project_data','a:1:{s:6:\"drupal\";a:17:{s:4:\"name\";s:6:\"drupal\";s:4:\"info\";a:6:{s:4:\"name\";s:5:\"Block\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:16:\"_info_file_ctime\";i:1384335485;}s:9:\"datestamp\";s:10:\"1375928238\";s:8:\"includes\";a:31:{s:5:\"block\";s:5:\"Block\";s:5:\"color\";s:5:\"Color\";s:7:\"comment\";s:7:\"Comment\";s:10:\"contextual\";s:16:\"Contextual links\";s:9:\"dashboard\";s:9:\"Dashboard\";s:5:\"dblog\";s:16:\"Database logging\";s:5:\"field\";s:5:\"Field\";s:17:\"field_sql_storage\";s:17:\"Field SQL storage\";s:8:\"field_ui\";s:8:\"Field UI\";s:4:\"file\";s:4:\"File\";s:6:\"filter\";s:6:\"Filter\";s:4:\"help\";s:4:\"Help\";s:5:\"image\";s:5:\"Image\";s:4:\"list\";s:4:\"List\";s:4:\"menu\";s:4:\"Menu\";s:4:\"node\";s:4:\"Node\";s:6:\"number\";s:6:\"Number\";s:7:\"options\";s:7:\"Options\";s:7:\"overlay\";s:7:\"Overlay\";s:4:\"path\";s:4:\"Path\";s:3:\"rdf\";s:3:\"RDF\";s:6:\"search\";s:6:\"Search\";s:8:\"shortcut\";s:8:\"Shortcut\";s:6:\"system\";s:6:\"System\";s:8:\"taxonomy\";s:8:\"Taxonomy\";s:4:\"text\";s:4:\"Text\";s:7:\"toolbar\";s:7:\"Toolbar\";s:6:\"update\";s:14:\"Update manager\";s:4:\"user\";s:4:\"User\";s:6:\"bartik\";s:6:\"Bartik\";s:5:\"seven\";s:5:\"Seven\";}s:12:\"project_type\";s:4:\"core\";s:14:\"project_status\";b:1;s:10:\"sub_themes\";a:0:{}s:11:\"base_themes\";a:0:{}s:16:\"existing_version\";s:4:\"7.23\";s:14:\"existing_major\";s:1:\"7\";s:12:\"install_type\";s:8:\"official\";s:5:\"title\";s:11:\"Drupal core\";s:4:\"link\";s:32:\"http://drupal.org/project/drupal\";s:14:\"latest_version\";s:4:\"7.23\";s:8:\"releases\";a:1:{s:4:\"7.23\";a:13:{s:4:\"name\";s:11:\"drupal 7.23\";s:7:\"version\";s:4:\"7.23\";s:3:\"tag\";s:4:\"7.23\";s:13:\"version_major\";s:1:\"7\";s:13:\"version_patch\";s:2:\"23\";s:6:\"status\";s:9:\"published\";s:12:\"release_link\";s:43:\"http://drupal.org/drupal-7.23-release-notes\";s:13:\"download_link\";s:55:\"http://ftp.drupal.org/files/projects/drupal-7.23.tar.gz\";s:4:\"date\";s:10:\"1375928239\";s:6:\"mdhash\";s:32:\"0beca6fec15b8cf8c35a6fdda6675342\";s:8:\"filesize\";s:7:\"3191695\";s:5:\"files\";s:11:\"\n   \n   \n  \";s:5:\"terms\";a:1:{s:12:\"Release type\";a:1:{i:0;s:9:\"Bug fixes\";}}}}s:11:\"recommended\";s:4:\"7.23\";s:6:\"status\";i:5;}}',1384779845,1384776245,1);
INSERT INTO `cache_update` VALUES ('update_project_projects','a:1:{s:6:\"drupal\";a:8:{s:4:\"name\";s:6:\"drupal\";s:4:\"info\";a:6:{s:4:\"name\";s:5:\"Block\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:16:\"_info_file_ctime\";i:1384335485;}s:9:\"datestamp\";s:10:\"1375928238\";s:8:\"includes\";a:31:{s:5:\"block\";s:5:\"Block\";s:5:\"color\";s:5:\"Color\";s:7:\"comment\";s:7:\"Comment\";s:10:\"contextual\";s:16:\"Contextual links\";s:9:\"dashboard\";s:9:\"Dashboard\";s:5:\"dblog\";s:16:\"Database logging\";s:5:\"field\";s:5:\"Field\";s:17:\"field_sql_storage\";s:17:\"Field SQL storage\";s:8:\"field_ui\";s:8:\"Field UI\";s:4:\"file\";s:4:\"File\";s:6:\"filter\";s:6:\"Filter\";s:4:\"help\";s:4:\"Help\";s:5:\"image\";s:5:\"Image\";s:4:\"list\";s:4:\"List\";s:4:\"menu\";s:4:\"Menu\";s:4:\"node\";s:4:\"Node\";s:6:\"number\";s:6:\"Number\";s:7:\"options\";s:7:\"Options\";s:7:\"overlay\";s:7:\"Overlay\";s:4:\"path\";s:4:\"Path\";s:3:\"rdf\";s:3:\"RDF\";s:6:\"search\";s:6:\"Search\";s:8:\"shortcut\";s:8:\"Shortcut\";s:6:\"system\";s:6:\"System\";s:8:\"taxonomy\";s:8:\"Taxonomy\";s:4:\"text\";s:4:\"Text\";s:7:\"toolbar\";s:7:\"Toolbar\";s:6:\"update\";s:14:\"Update manager\";s:4:\"user\";s:4:\"User\";s:6:\"bartik\";s:6:\"Bartik\";s:5:\"seven\";s:5:\"Seven\";}s:12:\"project_type\";s:4:\"core\";s:14:\"project_status\";b:1;s:10:\"sub_themes\";a:0:{}s:11:\"base_themes\";a:0:{}}}',1384779845,1384776245,1);
/*!40000 ALTER TABLE `cache_update` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `cid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique comment ID.',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT 'The comment.cid to which this comment is a reply. If set to 0, this comment is not a reply to an existing comment.',
  `nid` int(11) NOT NULL DEFAULT '0' COMMENT 'The node.nid to which this comment is a reply.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid who authored the comment. If set to 0, this comment was created by an anonymous user.',
  `subject` varchar(64) NOT NULL DEFAULT '' COMMENT 'The comment title.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The author’s host name.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The time that the comment was created, as a Unix timestamp.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The time that the comment was last edited, as a Unix timestamp.',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'The published status of a comment. (0 = Not Published, 1 = Published)',
  `thread` varchar(255) NOT NULL COMMENT 'The vancode representation of the comment’s place in a thread.',
  `name` varchar(60) DEFAULT NULL COMMENT 'The comment author’s name. Uses users.name if the user is logged in, otherwise uses the value typed into the comment form.',
  `mail` varchar(64) DEFAULT NULL COMMENT 'The comment author’s e-mail address from the comment form, if user is anonymous, and the ’Anonymous users may/must leave their contact information’ setting is turned on.',
  `homepage` varchar(255) DEFAULT NULL COMMENT 'The comment author’s home page address from the comment form, if user is anonymous, and the ’Anonymous users may/must leave their contact information’ setting is turned on.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this comment.',
  PRIMARY KEY (`cid`),
  KEY `comment_status_pid` (`pid`,`status`),
  KEY `comment_num_new` (`nid`,`status`,`created`,`cid`,`thread`),
  KEY `comment_uid` (`uid`),
  KEY `comment_nid_language` (`nid`,`language`),
  KEY `comment_created` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores comments and associated data.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--
-- ORDER BY:  `cid`

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `date_format_locale`
--

DROP TABLE IF EXISTS `date_format_locale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `date_format_locale` (
  `format` varchar(100) NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `language` varchar(12) NOT NULL COMMENT 'A languages.language for this format to be used with.',
  PRIMARY KEY (`type`,`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date formats for each locale.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `date_format_locale`
--
-- ORDER BY:  `type`,`language`

LOCK TABLES `date_format_locale` WRITE;
/*!40000 ALTER TABLE `date_format_locale` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `date_format_locale` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `date_format_type`
--

DROP TABLE IF EXISTS `date_format_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `date_format_type` (
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `title` varchar(255) NOT NULL COMMENT 'The human readable name of the format type.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether or not this is a system provided format.',
  PRIMARY KEY (`type`),
  KEY `title` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configured date format types.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `date_format_type`
--
-- ORDER BY:  `type`

LOCK TABLES `date_format_type` WRITE;
/*!40000 ALTER TABLE `date_format_type` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `date_format_type` VALUES ('long','Long',1);
INSERT INTO `date_format_type` VALUES ('medium','Medium',1);
INSERT INTO `date_format_type` VALUES ('short','Short',1);
/*!40000 ALTER TABLE `date_format_type` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `date_formats`
--

DROP TABLE IF EXISTS `date_formats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `date_formats` (
  `dfid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The date format identifier.',
  `format` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'The date format string.',
  `type` varchar(64) NOT NULL COMMENT 'The date format type, e.g. medium.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether or not this format can be modified.',
  PRIMARY KEY (`dfid`),
  UNIQUE KEY `formats` (`format`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='Stores configured date formats.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `date_formats`
--
-- ORDER BY:  `dfid`

LOCK TABLES `date_formats` WRITE;
/*!40000 ALTER TABLE `date_formats` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `date_formats` VALUES (1,'Y-m-d H:i','short',1);
INSERT INTO `date_formats` VALUES (2,'m/d/Y - H:i','short',1);
INSERT INTO `date_formats` VALUES (3,'d/m/Y - H:i','short',1);
INSERT INTO `date_formats` VALUES (4,'Y/m/d - H:i','short',1);
INSERT INTO `date_formats` VALUES (5,'d.m.Y - H:i','short',1);
INSERT INTO `date_formats` VALUES (6,'m/d/Y - g:ia','short',1);
INSERT INTO `date_formats` VALUES (7,'d/m/Y - g:ia','short',1);
INSERT INTO `date_formats` VALUES (8,'Y/m/d - g:ia','short',1);
INSERT INTO `date_formats` VALUES (9,'M j Y - H:i','short',1);
INSERT INTO `date_formats` VALUES (10,'j M Y - H:i','short',1);
INSERT INTO `date_formats` VALUES (11,'Y M j - H:i','short',1);
INSERT INTO `date_formats` VALUES (12,'M j Y - g:ia','short',1);
INSERT INTO `date_formats` VALUES (13,'j M Y - g:ia','short',1);
INSERT INTO `date_formats` VALUES (14,'Y M j - g:ia','short',1);
INSERT INTO `date_formats` VALUES (15,'D, Y-m-d H:i','medium',1);
INSERT INTO `date_formats` VALUES (16,'D, m/d/Y - H:i','medium',1);
INSERT INTO `date_formats` VALUES (17,'D, d/m/Y - H:i','medium',1);
INSERT INTO `date_formats` VALUES (18,'D, Y/m/d - H:i','medium',1);
INSERT INTO `date_formats` VALUES (19,'F j, Y - H:i','medium',1);
INSERT INTO `date_formats` VALUES (20,'j F, Y - H:i','medium',1);
INSERT INTO `date_formats` VALUES (21,'Y, F j - H:i','medium',1);
INSERT INTO `date_formats` VALUES (22,'D, m/d/Y - g:ia','medium',1);
INSERT INTO `date_formats` VALUES (23,'D, d/m/Y - g:ia','medium',1);
INSERT INTO `date_formats` VALUES (24,'D, Y/m/d - g:ia','medium',1);
INSERT INTO `date_formats` VALUES (25,'F j, Y - g:ia','medium',1);
INSERT INTO `date_formats` VALUES (26,'j F Y - g:ia','medium',1);
INSERT INTO `date_formats` VALUES (27,'Y, F j - g:ia','medium',1);
INSERT INTO `date_formats` VALUES (28,'j. F Y - G:i','medium',1);
INSERT INTO `date_formats` VALUES (29,'l, F j, Y - H:i','long',1);
INSERT INTO `date_formats` VALUES (30,'l, j F, Y - H:i','long',1);
INSERT INTO `date_formats` VALUES (31,'l, Y,  F j - H:i','long',1);
INSERT INTO `date_formats` VALUES (32,'l, F j, Y - g:ia','long',1);
INSERT INTO `date_formats` VALUES (33,'l, j F Y - g:ia','long',1);
INSERT INTO `date_formats` VALUES (34,'l, Y,  F j - g:ia','long',1);
INSERT INTO `date_formats` VALUES (35,'l, j. F Y - G:i','long',1);
/*!40000 ALTER TABLE `date_formats` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `field_config`
--

DROP TABLE IF EXISTS `field_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field',
  `field_name` varchar(32) NOT NULL COMMENT 'The name of this field. Non-deleted field names are unique, but multiple deleted fields can have the same name.',
  `type` varchar(128) NOT NULL COMMENT 'The type of this field.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the field type.',
  `active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the module that implements the field type is enabled.',
  `storage_type` varchar(128) NOT NULL COMMENT 'The storage backend for the field.',
  `storage_module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the storage backend.',
  `storage_active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the module that implements the storage backend is enabled.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT '@TODO',
  `data` longblob NOT NULL COMMENT 'Serialized data containing the field properties that do not warrant a dedicated column.',
  `cardinality` tinyint(4) NOT NULL DEFAULT '0',
  `translatable` tinyint(4) NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `field_name` (`field_name`),
  KEY `active` (`active`),
  KEY `storage_active` (`storage_active`),
  KEY `deleted` (`deleted`),
  KEY `module` (`module`),
  KEY `storage_module` (`storage_module`),
  KEY `type` (`type`),
  KEY `storage_type` (`storage_type`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_config`
--
-- ORDER BY:  `id`

LOCK TABLES `field_config` WRITE;
/*!40000 ALTER TABLE `field_config` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `field_config` VALUES (1,'comment_body','text_long','text',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:1:{i:0;s:7:\"comment\";}s:12:\"translatable\";b:0;s:8:\"settings\";a:0:{}s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}}',1,0,0);
INSERT INTO `field_config` VALUES (2,'body','text_with_summary','text',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:12:\"entity_types\";a:1:{i:0;s:4:\"node\";}s:12:\"translatable\";b:0;s:8:\"settings\";a:0:{}s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"foreign keys\";a:1:{s:6:\"format\";a:2:{s:5:\"table\";s:13:\"filter_format\";s:7:\"columns\";a:1:{s:6:\"format\";s:6:\"format\";}}}s:7:\"indexes\";a:1:{s:6:\"format\";a:1:{i:0;s:6:\"format\";}}}',1,0,0);
INSERT INTO `field_config` VALUES (3,'field_tags','taxonomy_term_reference','taxonomy',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:8:\"settings\";a:1:{s:14:\"allowed_values\";a:1:{i:0;a:2:{s:10:\"vocabulary\";s:4:\"tags\";s:6:\"parent\";i:0;}}}s:12:\"entity_types\";a:0:{}s:12:\"translatable\";b:0;s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"foreign keys\";a:1:{s:3:\"tid\";a:2:{s:5:\"table\";s:18:\"taxonomy_term_data\";s:7:\"columns\";a:1:{s:3:\"tid\";s:3:\"tid\";}}}s:7:\"indexes\";a:1:{s:3:\"tid\";a:1:{i:0;s:3:\"tid\";}}}',-1,0,0);
INSERT INTO `field_config` VALUES (4,'field_image','image','image',1,'field_sql_storage','field_sql_storage',1,0,'a:6:{s:7:\"indexes\";a:1:{s:3:\"fid\";a:1:{i:0;s:3:\"fid\";}}s:8:\"settings\";a:2:{s:10:\"uri_scheme\";s:6:\"public\";s:13:\"default_image\";b:0;}s:7:\"storage\";a:4:{s:4:\"type\";s:17:\"field_sql_storage\";s:8:\"settings\";a:0:{}s:6:\"module\";s:17:\"field_sql_storage\";s:6:\"active\";i:1;}s:12:\"entity_types\";a:0:{}s:12:\"translatable\";b:0;s:12:\"foreign keys\";a:1:{s:3:\"fid\";a:2:{s:5:\"table\";s:12:\"file_managed\";s:7:\"columns\";a:1:{s:3:\"fid\";s:3:\"fid\";}}}}',1,0,0);
/*!40000 ALTER TABLE `field_config` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `field_config_instance`
--

DROP TABLE IF EXISTS `field_config_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_config_instance` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field instance',
  `field_id` int(11) NOT NULL COMMENT 'The identifier of the field attached by this instance',
  `field_name` varchar(32) NOT NULL DEFAULT '',
  `entity_type` varchar(32) NOT NULL DEFAULT '',
  `bundle` varchar(128) NOT NULL DEFAULT '',
  `data` longblob NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `field_name_bundle` (`field_name`,`entity_type`,`bundle`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_config_instance`
--
-- ORDER BY:  `id`

LOCK TABLES `field_config_instance` WRITE;
/*!40000 ALTER TABLE `field_config_instance` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `field_config_instance` VALUES (1,1,'comment_body','comment','comment_node_page','a:6:{s:5:\"label\";s:7:\"Comment\";s:8:\"settings\";a:2:{s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:8:\"required\";b:1;s:7:\"display\";a:1:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}}s:6:\"widget\";a:4:{s:4:\"type\";s:13:\"text_textarea\";s:8:\"settings\";a:1:{s:4:\"rows\";i:5;}s:6:\"weight\";i:0;s:6:\"module\";s:4:\"text\";}s:11:\"description\";s:0:\"\";}',0);
INSERT INTO `field_config_instance` VALUES (2,2,'body','node','page','a:6:{s:5:\"label\";s:4:\"Body\";s:6:\"widget\";a:4:{s:4:\"type\";s:26:\"text_textarea_with_summary\";s:8:\"settings\";a:2:{s:4:\"rows\";i:20;s:12:\"summary_rows\";i:5;}s:6:\"weight\";i:-4;s:6:\"module\";s:4:\"text\";}s:8:\"settings\";a:3:{s:15:\"display_summary\";b:1;s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:23:\"text_summary_or_trimmed\";s:8:\"settings\";a:1:{s:11:\"trim_length\";i:600;}s:6:\"module\";s:4:\"text\";s:6:\"weight\";i:0;}}s:8:\"required\";b:0;s:11:\"description\";s:0:\"\";}',0);
INSERT INTO `field_config_instance` VALUES (3,1,'comment_body','comment','comment_node_article','a:6:{s:5:\"label\";s:7:\"Comment\";s:8:\"settings\";a:2:{s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:8:\"required\";b:1;s:7:\"display\";a:1:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:6:\"weight\";i:0;s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";}}s:6:\"widget\";a:4:{s:4:\"type\";s:13:\"text_textarea\";s:8:\"settings\";a:1:{s:4:\"rows\";i:5;}s:6:\"weight\";i:0;s:6:\"module\";s:4:\"text\";}s:11:\"description\";s:0:\"\";}',0);
INSERT INTO `field_config_instance` VALUES (4,2,'body','node','article','a:6:{s:5:\"label\";s:4:\"Body\";s:6:\"widget\";a:4:{s:4:\"type\";s:26:\"text_textarea_with_summary\";s:8:\"settings\";a:2:{s:4:\"rows\";i:20;s:12:\"summary_rows\";i:5;}s:6:\"weight\";i:-4;s:6:\"module\";s:4:\"text\";}s:8:\"settings\";a:3:{s:15:\"display_summary\";b:1;s:15:\"text_processing\";i:1;s:18:\"user_register_form\";b:0;}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:12:\"text_default\";s:8:\"settings\";a:0:{}s:6:\"module\";s:4:\"text\";s:6:\"weight\";i:0;}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:23:\"text_summary_or_trimmed\";s:8:\"settings\";a:1:{s:11:\"trim_length\";i:600;}s:6:\"module\";s:4:\"text\";s:6:\"weight\";i:0;}}s:8:\"required\";b:0;s:11:\"description\";s:0:\"\";}',0);
INSERT INTO `field_config_instance` VALUES (5,3,'field_tags','node','article','a:6:{s:5:\"label\";s:4:\"Tags\";s:11:\"description\";s:63:\"Enter a comma-separated list of words to describe your content.\";s:6:\"widget\";a:4:{s:4:\"type\";s:21:\"taxonomy_autocomplete\";s:6:\"weight\";i:-4;s:8:\"settings\";a:2:{s:4:\"size\";i:60;s:17:\"autocomplete_path\";s:21:\"taxonomy/autocomplete\";}s:6:\"module\";s:8:\"taxonomy\";}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:4:\"type\";s:28:\"taxonomy_term_reference_link\";s:6:\"weight\";i:10;s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:6:\"module\";s:8:\"taxonomy\";}s:6:\"teaser\";a:5:{s:4:\"type\";s:28:\"taxonomy_term_reference_link\";s:6:\"weight\";i:10;s:5:\"label\";s:5:\"above\";s:8:\"settings\";a:0:{}s:6:\"module\";s:8:\"taxonomy\";}}s:8:\"settings\";a:1:{s:18:\"user_register_form\";b:0;}s:8:\"required\";b:0;}',0);
INSERT INTO `field_config_instance` VALUES (6,4,'field_image','node','article','a:6:{s:5:\"label\";s:5:\"Image\";s:11:\"description\";s:40:\"Upload an image to go with this article.\";s:8:\"required\";b:0;s:8:\"settings\";a:9:{s:14:\"file_directory\";s:11:\"field/image\";s:15:\"file_extensions\";s:16:\"png gif jpg jpeg\";s:12:\"max_filesize\";s:0:\"\";s:14:\"max_resolution\";s:0:\"\";s:14:\"min_resolution\";s:0:\"\";s:9:\"alt_field\";b:1;s:11:\"title_field\";s:0:\"\";s:13:\"default_image\";i:0;s:18:\"user_register_form\";b:0;}s:6:\"widget\";a:4:{s:4:\"type\";s:11:\"image_image\";s:8:\"settings\";a:2:{s:18:\"progress_indicator\";s:8:\"throbber\";s:19:\"preview_image_style\";s:9:\"thumbnail\";}s:6:\"weight\";i:-1;s:6:\"module\";s:5:\"image\";}s:7:\"display\";a:2:{s:7:\"default\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:5:\"image\";s:8:\"settings\";a:2:{s:11:\"image_style\";s:5:\"large\";s:10:\"image_link\";s:0:\"\";}s:6:\"weight\";i:-1;s:6:\"module\";s:5:\"image\";}s:6:\"teaser\";a:5:{s:5:\"label\";s:6:\"hidden\";s:4:\"type\";s:5:\"image\";s:8:\"settings\";a:2:{s:11:\"image_style\";s:6:\"medium\";s:10:\"image_link\";s:7:\"content\";}s:6:\"weight\";i:-1;s:6:\"module\";s:5:\"image\";}}}',0);
/*!40000 ALTER TABLE `field_config_instance` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `field_data_body`
--

DROP TABLE IF EXISTS `field_data_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `body_format` (`body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 2 (body)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_body`
--
-- ORDER BY:  `entity_type`,`entity_id`,`deleted`,`delta`,`language`

LOCK TABLES `field_data_body` WRITE;
/*!40000 ALTER TABLE `field_data_body` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `field_data_body` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `field_data_comment_body`
--

DROP TABLE IF EXISTS `field_data_comment_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_comment_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `comment_body_value` longtext,
  `comment_body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `comment_body_format` (`comment_body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 1 (comment_body)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_comment_body`
--
-- ORDER BY:  `entity_type`,`entity_id`,`deleted`,`delta`,`language`

LOCK TABLES `field_data_comment_body` WRITE;
/*!40000 ALTER TABLE `field_data_comment_body` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `field_data_comment_body` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `field_data_field_image`
--

DROP TABLE IF EXISTS `field_data_field_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_image_fid` (`field_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 4 (field_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_image`
--
-- ORDER BY:  `entity_type`,`entity_id`,`deleted`,`delta`,`language`

LOCK TABLES `field_data_field_image` WRITE;
/*!40000 ALTER TABLE `field_data_field_image` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `field_data_field_image` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `field_data_field_tags`
--

DROP TABLE IF EXISTS `field_data_field_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_data_field_tags` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_tags_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_tags_tid` (`field_tags_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 3 (field_tags)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_data_field_tags`
--
-- ORDER BY:  `entity_type`,`entity_id`,`deleted`,`delta`,`language`

LOCK TABLES `field_data_field_tags` WRITE;
/*!40000 ALTER TABLE `field_data_field_tags` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `field_data_field_tags` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `field_revision_body`
--

DROP TABLE IF EXISTS `field_revision_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `body_format` (`body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 2 (body)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_body`
--
-- ORDER BY:  `entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`

LOCK TABLES `field_revision_body` WRITE;
/*!40000 ALTER TABLE `field_revision_body` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `field_revision_body` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `field_revision_comment_body`
--

DROP TABLE IF EXISTS `field_revision_comment_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_comment_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `comment_body_value` longtext,
  `comment_body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `comment_body_format` (`comment_body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 1 (comment_body)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_comment_body`
--
-- ORDER BY:  `entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`

LOCK TABLES `field_revision_comment_body` WRITE;
/*!40000 ALTER TABLE `field_revision_comment_body` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `field_revision_comment_body` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `field_revision_field_image`
--

DROP TABLE IF EXISTS `field_revision_field_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_image_fid` (`field_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 4 (field_image)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_image`
--
-- ORDER BY:  `entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`

LOCK TABLES `field_revision_field_image` WRITE;
/*!40000 ALTER TABLE `field_revision_field_image` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `field_revision_field_image` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `field_revision_field_tags`
--

DROP TABLE IF EXISTS `field_revision_field_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_revision_field_tags` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_tags_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_tags_tid` (`field_tags_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 3 (field_tags)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_revision_field_tags`
--
-- ORDER BY:  `entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`

LOCK TABLES `field_revision_field_tags` WRITE;
/*!40000 ALTER TABLE `field_revision_field_tags` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `field_revision_field_tags` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `file_managed`
--

DROP TABLE IF EXISTS `file_managed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_managed` (
  `fid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'File ID.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The users.uid of the user who is associated with the file.',
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the file with no path components. This may differ from the basename of the URI if the file is renamed to avoid overwriting an existing file.',
  `uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'The URI to access the file (either local or remote).',
  `filemime` varchar(255) NOT NULL DEFAULT '' COMMENT 'The file’s MIME type.',
  `filesize` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The size of the file in bytes.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A field indicating the status of the file. Two status are defined in core: temporary (0) and permanent (1). Temporary files older than DRUPAL_MAXIMUM_TEMP_FILE_AGE will be removed during a cron run.',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'UNIX timestamp for when the file was added.',
  PRIMARY KEY (`fid`),
  UNIQUE KEY `uri` (`uri`),
  KEY `uid` (`uid`),
  KEY `status` (`status`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information for uploaded files.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_managed`
--
-- ORDER BY:  `fid`

LOCK TABLES `file_managed` WRITE;
/*!40000 ALTER TABLE `file_managed` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `file_managed` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `file_usage`
--

DROP TABLE IF EXISTS `file_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_usage` (
  `fid` int(10) unsigned NOT NULL COMMENT 'File ID.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the module that is using the file.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'The name of the object type in which the file is used.',
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The primary key of the object using the file.',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The number of times this file is used by this object.',
  PRIMARY KEY (`fid`,`type`,`id`,`module`),
  KEY `type_id` (`type`,`id`),
  KEY `fid_count` (`fid`,`count`),
  KEY `fid_module` (`fid`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Track where a file is used.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_usage`
--
-- ORDER BY:  `fid`,`type`,`id`,`module`

LOCK TABLES `file_usage` WRITE;
/*!40000 ALTER TABLE `file_usage` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `file_usage` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `filter`
--

DROP TABLE IF EXISTS `filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filter` (
  `format` varchar(255) NOT NULL COMMENT 'Foreign key: The filter_format.format to which this filter is assigned.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The origin module of the filter.',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Name of the filter being referenced.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of filter within format.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Filter enabled status. (1 = enabled, 0 = disabled)',
  `settings` longblob COMMENT 'A serialized array of name value pairs that store the filter settings for the specific format.',
  PRIMARY KEY (`format`,`name`),
  KEY `list` (`weight`,`module`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table that maps filters (HTML corrector) to text formats ...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filter`
--
-- ORDER BY:  `format`,`name`

LOCK TABLES `filter` WRITE;
/*!40000 ALTER TABLE `filter` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `filter` VALUES ('filtered_html','filter','filter_autop',2,1,'a:0:{}');
INSERT INTO `filter` VALUES ('filtered_html','filter','filter_html',1,1,'a:3:{s:12:\"allowed_html\";s:74:\"<a> <em> <strong> <cite> <blockquote> <code> <ul> <ol> <li> <dl> <dt> <dd>\";s:16:\"filter_html_help\";i:1;s:20:\"filter_html_nofollow\";i:0;}');
INSERT INTO `filter` VALUES ('filtered_html','filter','filter_htmlcorrector',10,1,'a:0:{}');
INSERT INTO `filter` VALUES ('filtered_html','filter','filter_html_escape',-10,0,'a:0:{}');
INSERT INTO `filter` VALUES ('filtered_html','filter','filter_url',0,1,'a:1:{s:17:\"filter_url_length\";i:72;}');
INSERT INTO `filter` VALUES ('full_html','filter','filter_autop',1,1,'a:0:{}');
INSERT INTO `filter` VALUES ('full_html','filter','filter_html',-10,0,'a:3:{s:12:\"allowed_html\";s:74:\"<a> <em> <strong> <cite> <blockquote> <code> <ul> <ol> <li> <dl> <dt> <dd>\";s:16:\"filter_html_help\";i:1;s:20:\"filter_html_nofollow\";i:0;}');
INSERT INTO `filter` VALUES ('full_html','filter','filter_htmlcorrector',10,1,'a:0:{}');
INSERT INTO `filter` VALUES ('full_html','filter','filter_html_escape',-10,0,'a:0:{}');
INSERT INTO `filter` VALUES ('full_html','filter','filter_url',0,1,'a:1:{s:17:\"filter_url_length\";i:72;}');
INSERT INTO `filter` VALUES ('plain_text','filter','filter_autop',2,1,'a:0:{}');
INSERT INTO `filter` VALUES ('plain_text','filter','filter_html',-10,0,'a:3:{s:12:\"allowed_html\";s:74:\"<a> <em> <strong> <cite> <blockquote> <code> <ul> <ol> <li> <dl> <dt> <dd>\";s:16:\"filter_html_help\";i:1;s:20:\"filter_html_nofollow\";i:0;}');
INSERT INTO `filter` VALUES ('plain_text','filter','filter_htmlcorrector',10,0,'a:0:{}');
INSERT INTO `filter` VALUES ('plain_text','filter','filter_html_escape',0,1,'a:0:{}');
INSERT INTO `filter` VALUES ('plain_text','filter','filter_url',1,1,'a:1:{s:17:\"filter_url_length\";i:72;}');
/*!40000 ALTER TABLE `filter` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `filter_format`
--

DROP TABLE IF EXISTS `filter_format`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `filter_format` (
  `format` varchar(255) NOT NULL COMMENT 'Primary Key: Unique machine name of the format.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the text format (Filtered HTML).',
  `cache` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate whether format is cacheable. (1 = cacheable, 0 = not cacheable)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'The status of the text format. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of text format to use when listing.',
  PRIMARY KEY (`format`),
  UNIQUE KEY `name` (`name`),
  KEY `status_weight` (`status`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores text formats: custom groupings of filters, such as...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filter_format`
--
-- ORDER BY:  `format`

LOCK TABLES `filter_format` WRITE;
/*!40000 ALTER TABLE `filter_format` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `filter_format` VALUES ('filtered_html','Filtered HTML',1,1,0);
INSERT INTO `filter_format` VALUES ('full_html','Full HTML',1,1,1);
INSERT INTO `filter_format` VALUES ('plain_text','Plain text',1,1,10);
/*!40000 ALTER TABLE `filter_format` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `flood`
--

DROP TABLE IF EXISTS `flood`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flood` (
  `fid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique flood event ID.',
  `event` varchar(64) NOT NULL DEFAULT '' COMMENT 'Name of event (e.g. contact).',
  `identifier` varchar(128) NOT NULL DEFAULT '' COMMENT 'Identifier of the visitor, such as an IP address or hostname.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp of the event.',
  `expiration` int(11) NOT NULL DEFAULT '0' COMMENT 'Expiration timestamp. Expired events are purged on cron run.',
  PRIMARY KEY (`fid`),
  KEY `allow` (`event`,`identifier`,`timestamp`),
  KEY `purge` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Flood controls the threshold of events, such as the...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flood`
--
-- ORDER BY:  `fid`

LOCK TABLES `flood` WRITE;
/*!40000 ALTER TABLE `flood` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `flood` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history` (
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that read the node nid.',
  `nid` int(11) NOT NULL DEFAULT '0' COMMENT 'The node.nid that was read.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp at which the read occurred.',
  PRIMARY KEY (`uid`,`nid`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A record of which users have read which nodes.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history`
--
-- ORDER BY:  `uid`,`nid`

LOCK TABLES `history` WRITE;
/*!40000 ALTER TABLE `history` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `history` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `image_effects`
--

DROP TABLE IF EXISTS `image_effects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_effects` (
  `ieid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image effect.',
  `isid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The image_styles.isid for an image style.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of the effect in the style.',
  `name` varchar(255) NOT NULL COMMENT 'The unique name of the effect to be executed.',
  `data` longblob NOT NULL COMMENT 'The configuration data for the effect.',
  PRIMARY KEY (`ieid`),
  KEY `isid` (`isid`),
  KEY `weight` (`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image effects.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_effects`
--
-- ORDER BY:  `ieid`

LOCK TABLES `image_effects` WRITE;
/*!40000 ALTER TABLE `image_effects` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `image_effects` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `image_styles`
--

DROP TABLE IF EXISTS `image_styles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `image_styles` (
  `isid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image style.',
  `name` varchar(255) NOT NULL COMMENT 'The style machine name.',
  `label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The style administrative name.',
  PRIMARY KEY (`isid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image styles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_styles`
--
-- ORDER BY:  `isid`

LOCK TABLES `image_styles` WRITE;
/*!40000 ALTER TABLE `image_styles` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `image_styles` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `menu_custom`
--

DROP TABLE IF EXISTS `menu_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_custom` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique key for menu. This is used as a block delta so length is 32.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Menu title; displayed at top of block.',
  `description` text COMMENT 'Menu description.',
  PRIMARY KEY (`menu_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds definitions for top-level custom menus (for example...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_custom`
--
-- ORDER BY:  `menu_name`

LOCK TABLES `menu_custom` WRITE;
/*!40000 ALTER TABLE `menu_custom` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `menu_custom` VALUES ('main-menu','Main menu','The <em>Main</em> menu is used on many sites to show the major sections of the site, often in a top navigation bar.');
INSERT INTO `menu_custom` VALUES ('management','Management','The <em>Management</em> menu contains links for administrative tasks.');
INSERT INTO `menu_custom` VALUES ('navigation','Navigation','The <em>Navigation</em> menu contains links intended for site visitors. Links are added to the <em>Navigation</em> menu automatically by some modules.');
INSERT INTO `menu_custom` VALUES ('user-menu','User menu','The <em>User</em> menu contains links related to the user\'s account, as well as the \'Log out\' link.');
/*!40000 ALTER TABLE `menu_custom` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `menu_links`
--

DROP TABLE IF EXISTS `menu_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_links` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The menu name. All links with the same menu name (such as ’navigation’) are part of the same menu.',
  `mlid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The menu link ID (mlid) is the integer primary key.',
  `plid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The parent link ID (plid) is the mlid of the link above in the hierarchy, or zero if the link is at the top level in its menu.',
  `link_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path or external path this link points to.',
  `router_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'For links corresponding to a Drupal path (external = 0), this connects the link to a menu_router.path for joins.',
  `link_title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The text displayed for the link, which may be modified by a title callback stored in menu_router.',
  `options` blob COMMENT 'A serialized array of options to be passed to the url() or l() function, such as a query string or HTML attributes.',
  `module` varchar(255) NOT NULL DEFAULT 'system' COMMENT 'The name of the module that generated this link.',
  `hidden` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag for whether the link should be rendered in menus. (1 = a disabled menu item that may be shown on admin screens, -1 = a menu callback, 0 = a normal, visible link)',
  `external` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate if the link points to a full URL starting with a protocol, like http:// (1 = external, 0 = internal).',
  `has_children` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag indicating whether any links have this link as a parent (1 = children exist, 0 = no children).',
  `expanded` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag for whether this link should be rendered as expanded in menus - expanded links always have their child links displayed, instead of only when the link is in the active trail (1 = expanded, 0 = not expanded)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Link weight among links in the same menu at the same depth.',
  `depth` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The depth relative to the top level. A link with plid == 0 will have depth == 1.',
  `customized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate that the user has manually created or edited the link (1 = customized, 0 = not customized).',
  `p1` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The first mlid in the materialized path. If N = depth, then pN must equal the mlid. If depth > 1 then p(N-1) must equal the plid. All pX where X > depth must equal zero. The columns p1 .. p9 are also called the parents.',
  `p2` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The second mlid in the materialized path. See p1.',
  `p3` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The third mlid in the materialized path. See p1.',
  `p4` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The fourth mlid in the materialized path. See p1.',
  `p5` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The fifth mlid in the materialized path. See p1.',
  `p6` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The sixth mlid in the materialized path. See p1.',
  `p7` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The seventh mlid in the materialized path. See p1.',
  `p8` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The eighth mlid in the materialized path. See p1.',
  `p9` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The ninth mlid in the materialized path. See p1.',
  `updated` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag that indicates that this link was generated during the update from Drupal 5.',
  PRIMARY KEY (`mlid`),
  KEY `path_menu` (`link_path`(128),`menu_name`),
  KEY `menu_plid_expand_child` (`menu_name`,`plid`,`expanded`,`has_children`),
  KEY `menu_parents` (`menu_name`,`p1`,`p2`,`p3`,`p4`,`p5`,`p6`,`p7`,`p8`,`p9`),
  KEY `router_path` (`router_path`(128))
) ENGINE=InnoDB AUTO_INCREMENT=270 DEFAULT CHARSET=utf8 COMMENT='Contains the individual links within a menu.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_links`
--
-- ORDER BY:  `mlid`

LOCK TABLES `menu_links` WRITE;
/*!40000 ALTER TABLE `menu_links` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `menu_links` VALUES ('management',1,0,'admin','admin','Administration','a:0:{}','system',0,0,1,0,9,1,0,1,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('user-menu',2,0,'user','user','User account','a:1:{s:5:\"alter\";b:1;}','system',0,0,0,0,-10,1,0,2,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',3,0,'comment/%','comment/%','Comment permalink','a:0:{}','system',0,0,1,0,0,1,0,3,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',4,0,'filter/tips','filter/tips','Compose tips','a:0:{}','system',1,0,0,0,0,1,0,4,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',5,0,'node/%','node/%','','a:0:{}','system',0,0,0,0,0,1,0,5,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',6,0,'node/add','node/add','Add content','a:0:{}','system',0,0,1,0,0,1,0,6,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',7,1,'admin/appearance','admin/appearance','Appearance','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:33:\"Select and configure your themes.\";}}','system',0,0,0,0,-6,2,0,1,7,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',8,1,'admin/config','admin/config','Configuration','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:20:\"Administer settings.\";}}','system',0,0,1,0,0,2,0,1,8,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',9,1,'admin/content','admin/content','Content','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:32:\"Administer content and comments.\";}}','system',0,0,1,0,-10,2,0,1,9,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('user-menu',10,2,'user/register','user/register','Create new account','a:0:{}','system',-1,0,0,0,0,2,0,2,10,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',11,1,'admin/dashboard','admin/dashboard','Dashboard','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:34:\"View and customize your dashboard.\";}}','system',0,0,0,0,-15,2,0,1,11,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',12,1,'admin/help','admin/help','Help','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:48:\"Reference for usage, configuration, and modules.\";}}','system',0,0,0,0,9,2,0,1,12,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',13,1,'admin/index','admin/index','Index','a:0:{}','system',-1,0,0,0,-18,2,0,1,13,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('user-menu',14,2,'user/login','user/login','Log in','a:0:{}','system',-1,0,0,0,0,2,0,2,14,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('user-menu',15,0,'user/logout','user/logout','Log out','a:0:{}','system',0,0,0,0,10,1,0,15,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',16,1,'admin/modules','admin/modules','Modules','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:26:\"Extend site functionality.\";}}','system',0,0,0,0,-2,2,0,1,16,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',17,0,'user/%','user/%','My account','a:0:{}','system',0,0,1,0,0,1,0,17,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',18,1,'admin/people','admin/people','People','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:45:\"Manage user accounts, roles, and permissions.\";}}','system',0,0,0,0,-4,2,0,1,18,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',19,1,'admin/reports','admin/reports','Reports','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:34:\"View reports, updates, and errors.\";}}','system',0,0,1,0,5,2,0,1,19,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('user-menu',20,2,'user/password','user/password','Request new password','a:0:{}','system',-1,0,0,0,0,2,0,2,20,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',21,1,'admin/structure','admin/structure','Structure','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:45:\"Administer blocks, content types, menus, etc.\";}}','system',0,0,1,0,-8,2,0,1,21,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',22,1,'admin/tasks','admin/tasks','Tasks','a:0:{}','system',-1,0,0,0,-20,2,0,1,22,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',23,0,'comment/reply/%','comment/reply/%','Add new comment','a:0:{}','system',0,0,0,0,0,1,0,23,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',24,3,'comment/%/approve','comment/%/approve','Approve','a:0:{}','system',0,0,0,0,1,2,0,3,24,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',25,3,'comment/%/delete','comment/%/delete','Delete','a:0:{}','system',-1,0,0,0,2,2,0,3,25,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',26,3,'comment/%/edit','comment/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,2,0,3,26,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',27,0,'taxonomy/term/%','taxonomy/term/%','Taxonomy term','a:0:{}','system',0,0,0,0,0,1,0,27,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',28,3,'comment/%/view','comment/%/view','View comment','a:0:{}','system',-1,0,0,0,-10,2,0,3,28,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',29,18,'admin/people/create','admin/people/create','Add user','a:0:{}','system',-1,0,0,0,0,3,0,1,18,29,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',30,21,'admin/structure/block','admin/structure/block','Blocks','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:79:\"Configure what block content appears in your site\'s sidebars and other regions.\";}}','system',0,0,1,0,0,3,0,1,21,30,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',31,17,'user/%/cancel','user/%/cancel','Cancel account','a:0:{}','system',0,0,1,0,0,2,0,17,31,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',32,9,'admin/content/comment','admin/content/comment','Comments','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:59:\"List and edit site comments and the comment approval queue.\";}}','system',0,0,0,0,0,3,0,1,9,32,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',33,11,'admin/dashboard/configure','admin/dashboard/configure','Configure available dashboard blocks','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:53:\"Configure which blocks can be shown on the dashboard.\";}}','system',-1,0,0,0,0,3,0,1,11,33,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',34,9,'admin/content/node','admin/content/node','Content','a:0:{}','system',-1,0,0,0,-10,3,0,1,9,34,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',35,8,'admin/config/content','admin/config/content','Content authoring','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:53:\"Settings related to formatting and authoring content.\";}}','system',0,0,1,0,-15,3,0,1,8,35,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',36,21,'admin/structure/types','admin/structure/types','Content types','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:92:\"Manage content types, including default status, front page promotion, comment settings, etc.\";}}','system',0,0,1,0,0,3,0,1,21,36,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',37,11,'admin/dashboard/customize','admin/dashboard/customize','Customize dashboard','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:25:\"Customize your dashboard.\";}}','system',-1,0,0,0,0,3,0,1,11,37,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',38,5,'node/%/delete','node/%/delete','Delete','a:0:{}','system',-1,0,0,0,1,2,0,5,38,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',39,8,'admin/config/development','admin/config/development','Development','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:18:\"Development tools.\";}}','system',0,0,1,0,-10,3,0,1,8,39,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',40,17,'user/%/edit','user/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,2,0,17,40,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',41,5,'node/%/edit','node/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,2,0,5,41,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',42,19,'admin/reports/fields','admin/reports/fields','Field list','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:39:\"Overview of fields on all entity types.\";}}','system',0,0,0,0,0,3,0,1,19,42,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',43,7,'admin/appearance/list','admin/appearance/list','List','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:31:\"Select and configure your theme\";}}','system',-1,0,0,0,-1,3,0,1,7,43,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',44,16,'admin/modules/list','admin/modules/list','List','a:0:{}','system',-1,0,0,0,0,3,0,1,16,44,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',45,18,'admin/people/people','admin/people/people','List','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:50:\"Find and manage people interacting with your site.\";}}','system',-1,0,0,0,-10,3,0,1,18,45,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',46,8,'admin/config/media','admin/config/media','Media','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:12:\"Media tools.\";}}','system',0,0,1,0,-10,3,0,1,8,46,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',47,21,'admin/structure/menu','admin/structure/menu','Menus','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:86:\"Add new menus to your site, edit existing menus, and rename and reorganize menu links.\";}}','system',0,0,1,0,0,3,0,1,21,47,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',48,8,'admin/config/people','admin/config/people','People','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:24:\"Configure user accounts.\";}}','system',0,0,1,0,-20,3,0,1,8,48,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',49,18,'admin/people/permissions','admin/people/permissions','Permissions','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:64:\"Determine access to features by selecting permissions for roles.\";}}','system',-1,0,0,0,0,3,0,1,18,49,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',50,19,'admin/reports/dblog','admin/reports/dblog','Recent log messages','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"View events that have recently been logged.\";}}','system',0,0,0,0,-1,3,0,1,19,50,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',51,8,'admin/config/regional','admin/config/regional','Regional and language','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:48:\"Regional settings, localization and translation.\";}}','system',0,0,1,0,-5,3,0,1,8,51,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',52,5,'node/%/revisions','node/%/revisions','Revisions','a:0:{}','system',-1,0,1,0,2,2,0,5,52,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',53,8,'admin/config/search','admin/config/search','Search and metadata','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:36:\"Local site search, metadata and SEO.\";}}','system',0,0,1,0,-10,3,0,1,8,53,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',54,7,'admin/appearance/settings','admin/appearance/settings','Settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:46:\"Configure default and theme specific settings.\";}}','system',-1,0,0,0,20,3,0,1,7,54,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',55,19,'admin/reports/status','admin/reports/status','Status report','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:74:\"Get a status report about your site\'s operation and any detected problems.\";}}','system',0,0,0,0,-60,3,0,1,19,55,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',56,8,'admin/config/system','admin/config/system','System','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:37:\"General system related configuration.\";}}','system',0,0,1,0,-20,3,0,1,8,56,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',57,21,'admin/structure/taxonomy','admin/structure/taxonomy','Taxonomy','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:67:\"Manage tagging, categorization, and classification of your content.\";}}','system',0,0,1,0,0,3,0,1,21,57,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',58,19,'admin/reports/access-denied','admin/reports/access-denied','Top \'access denied\' errors','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:35:\"View \'access denied\' errors (403s).\";}}','system',0,0,0,0,0,3,0,1,19,58,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',59,19,'admin/reports/page-not-found','admin/reports/page-not-found','Top \'page not found\' errors','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:36:\"View \'page not found\' errors (404s).\";}}','system',0,0,0,0,0,3,0,1,19,59,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',60,16,'admin/modules/uninstall','admin/modules/uninstall','Uninstall','a:0:{}','system',-1,0,0,0,20,3,0,1,16,60,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',61,8,'admin/config/user-interface','admin/config/user-interface','User interface','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:38:\"Tools that enhance the user interface.\";}}','system',0,0,1,0,-15,3,0,1,8,61,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',62,5,'node/%/view','node/%/view','View','a:0:{}','system',-1,0,0,0,-10,2,0,5,62,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',63,17,'user/%/view','user/%/view','View','a:0:{}','system',-1,0,0,0,-10,2,0,17,63,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',64,8,'admin/config/services','admin/config/services','Web services','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:30:\"Tools related to web services.\";}}','system',0,0,1,0,0,3,0,1,8,64,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',65,8,'admin/config/workflow','admin/config/workflow','Workflow','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"Content workflow, editorial workflow tools.\";}}','system',0,0,0,0,5,3,0,1,8,65,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',66,12,'admin/help/block','admin/help/block','block','a:0:{}','system',-1,0,0,0,0,3,0,1,12,66,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',67,12,'admin/help/color','admin/help/color','color','a:0:{}','system',-1,0,0,0,0,3,0,1,12,67,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',68,12,'admin/help/comment','admin/help/comment','comment','a:0:{}','system',-1,0,0,0,0,3,0,1,12,68,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',69,12,'admin/help/contextual','admin/help/contextual','contextual','a:0:{}','system',-1,0,0,0,0,3,0,1,12,69,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',70,12,'admin/help/dashboard','admin/help/dashboard','dashboard','a:0:{}','system',-1,0,0,0,0,3,0,1,12,70,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',71,12,'admin/help/dblog','admin/help/dblog','dblog','a:0:{}','system',-1,0,0,0,0,3,0,1,12,71,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',72,12,'admin/help/field','admin/help/field','field','a:0:{}','system',-1,0,0,0,0,3,0,1,12,72,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',73,12,'admin/help/field_sql_storage','admin/help/field_sql_storage','field_sql_storage','a:0:{}','system',-1,0,0,0,0,3,0,1,12,73,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',74,12,'admin/help/field_ui','admin/help/field_ui','field_ui','a:0:{}','system',-1,0,0,0,0,3,0,1,12,74,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',75,12,'admin/help/file','admin/help/file','file','a:0:{}','system',-1,0,0,0,0,3,0,1,12,75,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',76,12,'admin/help/filter','admin/help/filter','filter','a:0:{}','system',-1,0,0,0,0,3,0,1,12,76,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',77,12,'admin/help/help','admin/help/help','help','a:0:{}','system',-1,0,0,0,0,3,0,1,12,77,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',78,12,'admin/help/image','admin/help/image','image','a:0:{}','system',-1,0,0,0,0,3,0,1,12,78,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',79,12,'admin/help/list','admin/help/list','list','a:0:{}','system',-1,0,0,0,0,3,0,1,12,79,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',80,12,'admin/help/menu','admin/help/menu','menu','a:0:{}','system',-1,0,0,0,0,3,0,1,12,80,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',81,12,'admin/help/node','admin/help/node','node','a:0:{}','system',-1,0,0,0,0,3,0,1,12,81,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',82,12,'admin/help/options','admin/help/options','options','a:0:{}','system',-1,0,0,0,0,3,0,1,12,82,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',83,12,'admin/help/system','admin/help/system','system','a:0:{}','system',-1,0,0,0,0,3,0,1,12,83,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',84,12,'admin/help/taxonomy','admin/help/taxonomy','taxonomy','a:0:{}','system',-1,0,0,0,0,3,0,1,12,84,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',85,12,'admin/help/text','admin/help/text','text','a:0:{}','system',-1,0,0,0,0,3,0,1,12,85,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',86,12,'admin/help/user','admin/help/user','user','a:0:{}','system',-1,0,0,0,0,3,0,1,12,86,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',87,27,'taxonomy/term/%/edit','taxonomy/term/%/edit','Edit','a:0:{}','system',-1,0,0,0,10,2,0,27,87,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',88,27,'taxonomy/term/%/view','taxonomy/term/%/view','View','a:0:{}','system',-1,0,0,0,0,2,0,27,88,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',89,57,'admin/structure/taxonomy/%','admin/structure/taxonomy/%','','a:0:{}','system',0,0,0,0,0,4,0,1,21,57,89,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',90,48,'admin/config/people/accounts','admin/config/people/accounts','Account settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:109:\"Configure default behavior of users, including registration requirements, e-mails, fields, and user pictures.\";}}','system',0,0,0,0,-10,4,0,1,8,48,90,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',91,56,'admin/config/system/actions','admin/config/system/actions','Actions','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:41:\"Manage the actions defined for your site.\";}}','system',0,0,1,0,0,4,0,1,8,56,91,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',92,30,'admin/structure/block/add','admin/structure/block/add','Add block','a:0:{}','system',-1,0,0,0,0,4,0,1,21,30,92,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',93,36,'admin/structure/types/add','admin/structure/types/add','Add content type','a:0:{}','system',-1,0,0,0,0,4,0,1,21,36,93,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',94,47,'admin/structure/menu/add','admin/structure/menu/add','Add menu','a:0:{}','system',-1,0,0,0,0,4,0,1,21,47,94,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',95,57,'admin/structure/taxonomy/add','admin/structure/taxonomy/add','Add vocabulary','a:0:{}','system',-1,0,0,0,0,4,0,1,21,57,95,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',96,54,'admin/appearance/settings/bartik','admin/appearance/settings/bartik','Bartik','a:0:{}','system',-1,0,0,0,0,4,0,1,7,54,96,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',97,53,'admin/config/search/clean-urls','admin/config/search/clean-urls','Clean URLs','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"Enable or disable clean URLs for your site.\";}}','system',0,0,0,0,5,4,0,1,8,53,97,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',98,56,'admin/config/system/cron','admin/config/system/cron','Cron','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:40:\"Manage automatic site maintenance tasks.\";}}','system',0,0,0,0,20,4,0,1,8,56,98,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',99,51,'admin/config/regional/date-time','admin/config/regional/date-time','Date and time','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:44:\"Configure display formats for date and time.\";}}','system',0,0,0,0,-15,4,0,1,8,51,99,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',100,19,'admin/reports/event/%','admin/reports/event/%','Details','a:0:{}','system',0,0,0,0,0,3,0,1,19,100,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',101,46,'admin/config/media/file-system','admin/config/media/file-system','File system','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:68:\"Tell Drupal where to store uploaded files and how they are accessed.\";}}','system',0,0,0,0,-10,4,0,1,8,46,101,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',102,54,'admin/appearance/settings/garland','admin/appearance/settings/garland','Garland','a:0:{}','system',-1,0,0,0,0,4,0,1,7,54,102,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',103,54,'admin/appearance/settings/global','admin/appearance/settings/global','Global settings','a:0:{}','system',-1,0,0,0,-1,4,0,1,7,54,103,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',104,48,'admin/config/people/ip-blocking','admin/config/people/ip-blocking','IP address blocking','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:28:\"Manage blocked IP addresses.\";}}','system',0,0,1,0,10,4,0,1,8,48,104,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',105,46,'admin/config/media/image-styles','admin/config/media/image-styles','Image styles','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:78:\"Configure styles that can be used for resizing or adjusting images on display.\";}}','system',0,0,1,0,0,4,0,1,8,46,105,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',106,46,'admin/config/media/image-toolkit','admin/config/media/image-toolkit','Image toolkit','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:74:\"Choose which image toolkit to use if you have installed optional toolkits.\";}}','system',0,0,0,0,20,4,0,1,8,46,106,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',107,44,'admin/modules/list/confirm','admin/modules/list/confirm','List','a:0:{}','system',-1,0,0,0,0,4,0,1,16,44,107,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',108,36,'admin/structure/types/list','admin/structure/types/list','List','a:0:{}','system',-1,0,0,0,-10,4,0,1,21,36,108,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',109,57,'admin/structure/taxonomy/list','admin/structure/taxonomy/list','List','a:0:{}','system',-1,0,0,0,-10,4,0,1,21,57,109,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',110,47,'admin/structure/menu/list','admin/structure/menu/list','List menus','a:0:{}','system',-1,0,0,0,-10,4,0,1,21,47,110,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',111,39,'admin/config/development/logging','admin/config/development/logging','Logging and errors','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:154:\"Settings for logging and alerts modules. Various modules can route Drupal\'s system events to different destinations, such as syslog, database, email, etc.\";}}','system',0,0,0,0,-15,4,0,1,8,39,111,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',112,39,'admin/config/development/maintenance','admin/config/development/maintenance','Maintenance mode','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:62:\"Take the site offline for maintenance or bring it back online.\";}}','system',0,0,0,0,-10,4,0,1,8,39,112,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',113,39,'admin/config/development/performance','admin/config/development/performance','Performance','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:101:\"Enable or disable page caching for anonymous users and set CSS and JS bandwidth optimization options.\";}}','system',0,0,0,0,-20,4,0,1,8,39,113,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',114,49,'admin/people/permissions/list','admin/people/permissions/list','Permissions','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:64:\"Determine access to features by selecting permissions for roles.\";}}','system',-1,0,0,0,-8,4,0,1,18,49,114,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',115,32,'admin/content/comment/new','admin/content/comment/new','Published comments','a:0:{}','system',-1,0,0,0,-10,4,0,1,9,32,115,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',116,64,'admin/config/services/rss-publishing','admin/config/services/rss-publishing','RSS publishing','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:114:\"Configure the site description, the number of items per feed and whether feeds should be titles/teasers/full-text.\";}}','system',0,0,0,0,0,4,0,1,8,64,116,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',117,51,'admin/config/regional/settings','admin/config/regional/settings','Regional settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:54:\"Settings for the site\'s default time zone and country.\";}}','system',0,0,0,0,-20,4,0,1,8,51,117,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',118,49,'admin/people/permissions/roles','admin/people/permissions/roles','Roles','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:30:\"List, edit, or add user roles.\";}}','system',-1,0,1,0,-5,4,0,1,18,49,118,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',119,47,'admin/structure/menu/settings','admin/structure/menu/settings','Settings','a:0:{}','system',-1,0,0,0,5,4,0,1,21,47,119,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',120,54,'admin/appearance/settings/seven','admin/appearance/settings/seven','Seven','a:0:{}','system',-1,0,0,0,0,4,0,1,7,54,120,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',121,56,'admin/config/system/site-information','admin/config/system/site-information','Site information','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:104:\"Change site name, e-mail address, slogan, default front page, and number of posts per page, error pages.\";}}','system',0,0,0,0,-20,4,0,1,8,56,121,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',122,54,'admin/appearance/settings/stark','admin/appearance/settings/stark','Stark','a:0:{}','system',-1,0,0,0,0,4,0,1,7,54,122,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',123,35,'admin/config/content/formats','admin/config/content/formats','Text formats','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:127:\"Configure how content input by users is filtered, including allowed HTML tags. Also allows enabling of module-provided filters.\";}}','system',0,0,1,0,0,4,0,1,8,35,123,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',124,32,'admin/content/comment/approval','admin/content/comment/approval','Unapproved comments','a:0:{}','system',-1,0,0,0,0,4,0,1,9,32,124,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',125,60,'admin/modules/uninstall/confirm','admin/modules/uninstall/confirm','Uninstall','a:0:{}','system',-1,0,0,0,0,4,0,1,16,60,125,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',126,40,'user/%/edit/account','user/%/edit/account','Account','a:0:{}','system',-1,0,0,0,0,3,0,17,40,126,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',127,123,'admin/config/content/formats/%','admin/config/content/formats/%','','a:0:{}','system',0,0,1,0,0,5,0,1,8,35,123,127,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',128,105,'admin/config/media/image-styles/add','admin/config/media/image-styles/add','Add style','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:22:\"Add a new image style.\";}}','system',-1,0,0,0,2,5,0,1,8,46,105,128,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',129,89,'admin/structure/taxonomy/%/add','admin/structure/taxonomy/%/add','Add term','a:0:{}','system',-1,0,0,0,0,5,0,1,21,57,89,129,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',130,123,'admin/config/content/formats/add','admin/config/content/formats/add','Add text format','a:0:{}','system',-1,0,0,0,1,5,0,1,8,35,123,130,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',131,30,'admin/structure/block/list/bartik','admin/structure/block/list/bartik','Bartik','a:0:{}','system',-1,0,0,0,-10,4,0,1,21,30,131,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',132,91,'admin/config/system/actions/configure','admin/config/system/actions/configure','Configure an advanced action','a:0:{}','system',-1,0,0,0,0,5,0,1,8,56,91,132,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',133,47,'admin/structure/menu/manage/%','admin/structure/menu/manage/%','Customize menu','a:0:{}','system',0,0,1,0,0,4,0,1,21,47,133,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',134,89,'admin/structure/taxonomy/%/edit','admin/structure/taxonomy/%/edit','Edit','a:0:{}','system',-1,0,0,0,-10,5,0,1,21,57,89,134,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',135,36,'admin/structure/types/manage/%','admin/structure/types/manage/%','Edit content type','a:0:{}','system',0,0,1,0,0,4,0,1,21,36,135,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',136,99,'admin/config/regional/date-time/formats','admin/config/regional/date-time/formats','Formats','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:51:\"Configure display format strings for date and time.\";}}','system',-1,0,1,0,-9,5,0,1,8,51,99,136,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',137,30,'admin/structure/block/list/garland','admin/structure/block/list/garland','Garland','a:0:{}','system',-1,0,0,0,0,4,0,1,21,30,137,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',138,123,'admin/config/content/formats/list','admin/config/content/formats/list','List','a:0:{}','system',-1,0,0,0,0,5,0,1,8,35,123,138,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',139,89,'admin/structure/taxonomy/%/list','admin/structure/taxonomy/%/list','List','a:0:{}','system',-1,0,0,0,-20,5,0,1,21,57,89,139,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',140,105,'admin/config/media/image-styles/list','admin/config/media/image-styles/list','List','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:42:\"List the current image styles on the site.\";}}','system',-1,0,0,0,1,5,0,1,8,46,105,140,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',141,91,'admin/config/system/actions/manage','admin/config/system/actions/manage','Manage actions','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:41:\"Manage the actions defined for your site.\";}}','system',-1,0,0,0,-2,5,0,1,8,56,91,141,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',142,90,'admin/config/people/accounts/settings','admin/config/people/accounts/settings','Settings','a:0:{}','system',-1,0,0,0,-10,5,0,1,8,48,90,142,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',143,30,'admin/structure/block/list/seven','admin/structure/block/list/seven','Seven','a:0:{}','system',-1,0,0,0,0,4,0,1,21,30,143,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',144,30,'admin/structure/block/list/stark','admin/structure/block/list/stark','Stark','a:0:{}','system',-1,0,0,0,0,4,0,1,21,30,144,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',145,99,'admin/config/regional/date-time/types','admin/config/regional/date-time/types','Types','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:44:\"Configure display formats for date and time.\";}}','system',-1,0,1,0,-10,5,0,1,8,51,99,145,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',146,52,'node/%/revisions/%/delete','node/%/revisions/%/delete','Delete earlier revision','a:0:{}','system',0,0,0,0,0,3,0,5,52,146,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',147,52,'node/%/revisions/%/revert','node/%/revisions/%/revert','Revert to earlier revision','a:0:{}','system',0,0,0,0,0,3,0,5,52,147,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',148,52,'node/%/revisions/%/view','node/%/revisions/%/view','Revisions','a:0:{}','system',0,0,0,0,0,3,0,5,52,148,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',149,137,'admin/structure/block/list/garland/add','admin/structure/block/list/garland/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,1,21,30,137,149,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',150,143,'admin/structure/block/list/seven/add','admin/structure/block/list/seven/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,1,21,30,143,150,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',151,144,'admin/structure/block/list/stark/add','admin/structure/block/list/stark/add','Add block','a:0:{}','system',-1,0,0,0,0,5,0,1,21,30,144,151,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',152,145,'admin/config/regional/date-time/types/add','admin/config/regional/date-time/types/add','Add date type','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:18:\"Add new date type.\";}}','system',-1,0,0,0,-10,6,0,1,8,51,99,145,152,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',153,136,'admin/config/regional/date-time/formats/add','admin/config/regional/date-time/formats/add','Add format','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:43:\"Allow users to add additional date formats.\";}}','system',-1,0,0,0,-10,6,0,1,8,51,99,136,153,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',154,133,'admin/structure/menu/manage/%/add','admin/structure/menu/manage/%/add','Add link','a:0:{}','system',-1,0,0,0,0,5,0,1,21,47,133,154,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',155,30,'admin/structure/block/manage/%/%','admin/structure/block/manage/%/%','Configure block','a:0:{}','system',0,0,0,0,0,4,0,1,21,30,155,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',156,31,'user/%/cancel/confirm/%/%','user/%/cancel/confirm/%/%','Confirm account cancellation','a:0:{}','system',0,0,0,0,0,3,0,17,31,156,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',157,135,'admin/structure/types/manage/%/delete','admin/structure/types/manage/%/delete','Delete','a:0:{}','system',0,0,0,0,0,5,0,1,21,36,135,157,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',158,104,'admin/config/people/ip-blocking/delete/%','admin/config/people/ip-blocking/delete/%','Delete IP address','a:0:{}','system',0,0,0,0,0,5,0,1,8,48,104,158,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',159,91,'admin/config/system/actions/delete/%','admin/config/system/actions/delete/%','Delete action','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:17:\"Delete an action.\";}}','system',0,0,0,0,0,5,0,1,8,56,91,159,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',160,133,'admin/structure/menu/manage/%/delete','admin/structure/menu/manage/%/delete','Delete menu','a:0:{}','system',0,0,0,0,0,5,0,1,21,47,133,160,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',161,47,'admin/structure/menu/item/%/delete','admin/structure/menu/item/%/delete','Delete menu link','a:0:{}','system',0,0,0,0,0,4,0,1,21,47,161,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',162,118,'admin/people/permissions/roles/delete/%','admin/people/permissions/roles/delete/%','Delete role','a:0:{}','system',0,0,0,0,0,5,0,1,18,49,118,162,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',163,127,'admin/config/content/formats/%/disable','admin/config/content/formats/%/disable','Disable text format','a:0:{}','system',0,0,0,0,0,6,0,1,8,35,123,127,163,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',164,135,'admin/structure/types/manage/%/edit','admin/structure/types/manage/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,5,0,1,21,36,135,164,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',165,133,'admin/structure/menu/manage/%/edit','admin/structure/menu/manage/%/edit','Edit menu','a:0:{}','system',-1,0,0,0,0,5,0,1,21,47,133,165,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',166,47,'admin/structure/menu/item/%/edit','admin/structure/menu/item/%/edit','Edit menu link','a:0:{}','system',0,0,0,0,0,4,0,1,21,47,166,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',167,118,'admin/people/permissions/roles/edit/%','admin/people/permissions/roles/edit/%','Edit role','a:0:{}','system',0,0,0,0,0,5,0,1,18,49,118,167,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',168,105,'admin/config/media/image-styles/edit/%','admin/config/media/image-styles/edit/%','Edit style','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:25:\"Configure an image style.\";}}','system',0,0,1,0,0,5,0,1,8,46,105,168,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',169,133,'admin/structure/menu/manage/%/list','admin/structure/menu/manage/%/list','List links','a:0:{}','system',-1,0,0,0,-10,5,0,1,21,47,133,169,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',170,47,'admin/structure/menu/item/%/reset','admin/structure/menu/item/%/reset','Reset menu link','a:0:{}','system',0,0,0,0,0,4,0,1,21,47,170,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',171,105,'admin/config/media/image-styles/delete/%','admin/config/media/image-styles/delete/%','Delete style','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:22:\"Delete an image style.\";}}','system',0,0,0,0,0,5,0,1,8,46,105,171,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',172,105,'admin/config/media/image-styles/revert/%','admin/config/media/image-styles/revert/%','Revert style','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:22:\"Revert an image style.\";}}','system',0,0,0,0,0,5,0,1,8,46,105,172,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',173,135,'admin/structure/types/manage/%/comment/display','admin/structure/types/manage/%/comment/display','Comment display','a:0:{}','system',-1,0,0,0,4,5,0,1,21,36,135,173,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',174,135,'admin/structure/types/manage/%/comment/fields','admin/structure/types/manage/%/comment/fields','Comment fields','a:0:{}','system',-1,0,1,0,3,5,0,1,21,36,135,174,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',175,155,'admin/structure/block/manage/%/%/configure','admin/structure/block/manage/%/%/configure','Configure block','a:0:{}','system',-1,0,0,0,0,5,0,1,21,30,155,175,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',176,155,'admin/structure/block/manage/%/%/delete','admin/structure/block/manage/%/%/delete','Delete block','a:0:{}','system',-1,0,0,0,0,5,0,1,21,30,155,176,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',177,136,'admin/config/regional/date-time/formats/%/delete','admin/config/regional/date-time/formats/%/delete','Delete date format','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:47:\"Allow users to delete a configured date format.\";}}','system',0,0,0,0,0,6,0,1,8,51,99,136,177,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',178,145,'admin/config/regional/date-time/types/%/delete','admin/config/regional/date-time/types/%/delete','Delete date type','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:45:\"Allow users to delete a configured date type.\";}}','system',0,0,0,0,0,6,0,1,8,51,99,145,178,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',179,136,'admin/config/regional/date-time/formats/%/edit','admin/config/regional/date-time/formats/%/edit','Edit date format','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:45:\"Allow users to edit a configured date format.\";}}','system',0,0,0,0,0,6,0,1,8,51,99,136,179,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',180,168,'admin/config/media/image-styles/edit/%/add/%','admin/config/media/image-styles/edit/%/add/%','Add image effect','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:28:\"Add a new effect to a style.\";}}','system',0,0,0,0,0,6,0,1,8,46,105,168,180,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',181,168,'admin/config/media/image-styles/edit/%/effects/%','admin/config/media/image-styles/edit/%/effects/%','Edit image effect','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:39:\"Edit an existing effect within a style.\";}}','system',0,0,1,0,0,6,0,1,8,46,105,168,181,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',182,181,'admin/config/media/image-styles/edit/%/effects/%/delete','admin/config/media/image-styles/edit/%/effects/%/delete','Delete image effect','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:39:\"Delete an existing effect from a style.\";}}','system',0,0,0,0,0,7,0,1,8,46,105,168,181,182,0,0,0);
INSERT INTO `menu_links` VALUES ('management',183,47,'admin/structure/menu/manage/main-menu','admin/structure/menu/manage/%','Main menu','a:0:{}','menu',0,0,0,0,0,4,0,1,21,47,183,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',184,47,'admin/structure/menu/manage/management','admin/structure/menu/manage/%','Management','a:0:{}','menu',0,0,0,0,0,4,0,1,21,47,184,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',185,47,'admin/structure/menu/manage/navigation','admin/structure/menu/manage/%','Navigation','a:0:{}','menu',0,0,0,0,0,4,0,1,21,47,185,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',186,47,'admin/structure/menu/manage/user-menu','admin/structure/menu/manage/%','User menu','a:0:{}','menu',0,0,0,0,0,4,0,1,21,47,186,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',187,0,'search','search','Search','a:0:{}','system',1,0,0,0,0,1,0,187,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',188,187,'search/node','search/node','Content','a:0:{}','system',-1,0,0,0,-10,2,0,187,188,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',189,187,'search/user','search/user','Users','a:0:{}','system',-1,0,0,0,0,2,0,187,189,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',190,188,'search/node/%','search/node/%','Content','a:0:{}','system',-1,0,0,0,0,3,0,187,188,190,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',191,17,'user/%/shortcuts','user/%/shortcuts','Shortcuts','a:0:{}','system',-1,0,0,0,0,2,0,17,191,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',192,19,'admin/reports/search','admin/reports/search','Top search phrases','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:33:\"View most popular search phrases.\";}}','system',0,0,0,0,0,3,0,1,19,192,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',193,189,'search/user/%','search/user/%','Users','a:0:{}','system',-1,0,0,0,0,3,0,187,189,193,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',194,12,'admin/help/number','admin/help/number','number','a:0:{}','system',-1,0,0,0,0,3,0,1,12,194,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',195,12,'admin/help/overlay','admin/help/overlay','overlay','a:0:{}','system',-1,0,0,0,0,3,0,1,12,195,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',196,12,'admin/help/path','admin/help/path','path','a:0:{}','system',-1,0,0,0,0,3,0,1,12,196,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',197,12,'admin/help/rdf','admin/help/rdf','rdf','a:0:{}','system',-1,0,0,0,0,3,0,1,12,197,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',198,12,'admin/help/search','admin/help/search','search','a:0:{}','system',-1,0,0,0,0,3,0,1,12,198,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',199,12,'admin/help/shortcut','admin/help/shortcut','shortcut','a:0:{}','system',-1,0,0,0,0,3,0,1,12,199,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',200,53,'admin/config/search/settings','admin/config/search/settings','Search settings','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:67:\"Configure relevance settings for search and other indexing options.\";}}','system',0,0,0,0,-10,4,0,1,8,53,200,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',201,61,'admin/config/user-interface/shortcut','admin/config/user-interface/shortcut','Shortcuts','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:29:\"Add and modify shortcut sets.\";}}','system',0,0,1,0,0,4,0,1,8,61,201,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',202,53,'admin/config/search/path','admin/config/search/path','URL aliases','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:46:\"Change your site\'s URL paths by aliasing them.\";}}','system',0,0,1,0,-5,4,0,1,8,53,202,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',203,202,'admin/config/search/path/add','admin/config/search/path/add','Add alias','a:0:{}','system',-1,0,0,0,0,5,0,1,8,53,202,203,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',204,201,'admin/config/user-interface/shortcut/add-set','admin/config/user-interface/shortcut/add-set','Add shortcut set','a:0:{}','system',-1,0,0,0,0,5,0,1,8,61,201,204,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',205,200,'admin/config/search/settings/reindex','admin/config/search/settings/reindex','Clear index','a:0:{}','system',-1,0,0,0,0,5,0,1,8,53,200,205,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',206,201,'admin/config/user-interface/shortcut/%','admin/config/user-interface/shortcut/%','Edit shortcuts','a:0:{}','system',0,0,1,0,0,5,0,1,8,61,201,206,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',207,202,'admin/config/search/path/list','admin/config/search/path/list','List','a:0:{}','system',-1,0,0,0,-10,5,0,1,8,53,202,207,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',208,206,'admin/config/user-interface/shortcut/%/add-link','admin/config/user-interface/shortcut/%/add-link','Add shortcut','a:0:{}','system',-1,0,0,0,0,6,0,1,8,61,201,206,208,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',209,202,'admin/config/search/path/delete/%','admin/config/search/path/delete/%','Delete alias','a:0:{}','system',0,0,0,0,0,5,0,1,8,53,202,209,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',210,206,'admin/config/user-interface/shortcut/%/delete','admin/config/user-interface/shortcut/%/delete','Delete shortcut set','a:0:{}','system',0,0,0,0,0,6,0,1,8,61,201,206,210,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',211,202,'admin/config/search/path/edit/%','admin/config/search/path/edit/%','Edit alias','a:0:{}','system',0,0,0,0,0,5,0,1,8,53,202,211,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',212,206,'admin/config/user-interface/shortcut/%/edit','admin/config/user-interface/shortcut/%/edit','Edit set name','a:0:{}','system',-1,0,0,0,10,6,0,1,8,61,201,206,212,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',213,201,'admin/config/user-interface/shortcut/link/%','admin/config/user-interface/shortcut/link/%','Edit shortcut','a:0:{}','system',0,0,1,0,0,5,0,1,8,61,201,213,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',214,206,'admin/config/user-interface/shortcut/%/links','admin/config/user-interface/shortcut/%/links','List links','a:0:{}','system',-1,0,0,0,0,6,0,1,8,61,201,206,214,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',215,213,'admin/config/user-interface/shortcut/link/%/delete','admin/config/user-interface/shortcut/link/%/delete','Delete shortcut','a:0:{}','system',0,0,0,0,0,6,0,1,8,61,201,213,215,0,0,0,0);
INSERT INTO `menu_links` VALUES ('shortcut-set-1',216,0,'node/add','node/add','Add content','a:0:{}','menu',0,0,0,0,-20,1,0,216,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('shortcut-set-1',217,0,'admin/content','admin/content','Find content','a:0:{}','menu',0,0,0,0,-19,1,0,217,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('main-menu',218,0,'<front>','','Home','a:0:{}','menu',0,1,0,0,0,1,0,218,0,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',219,6,'node/add/article','node/add/article','Article','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:89:\"Use <em>articles</em> for time-sensitive content like news, press releases or blog posts.\";}}','system',0,0,0,0,0,2,0,6,219,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('navigation',220,6,'node/add/page','node/add/page','Basic page','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:77:\"Use <em>basic pages</em> for your static content, such as an \'About us\' page.\";}}','system',0,0,0,0,0,2,0,6,220,0,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',221,12,'admin/help/toolbar','admin/help/toolbar','toolbar','a:0:{}','system',-1,0,0,0,0,3,0,1,12,221,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',222,19,'admin/reports/updates','admin/reports/updates','Available updates','a:1:{s:10:\"attributes\";a:1:{s:5:\"title\";s:82:\"Get a status report about available updates for your installed modules and themes.\";}}','system',0,0,0,0,-50,3,0,1,19,222,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',223,7,'admin/appearance/install','admin/appearance/install','Install new theme','a:0:{}','system',-1,0,0,0,25,3,0,1,7,223,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',224,16,'admin/modules/update','admin/modules/update','Update','a:0:{}','system',-1,0,0,0,10,3,0,1,16,224,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',225,16,'admin/modules/install','admin/modules/install','Install new module','a:0:{}','system',-1,0,0,0,25,3,0,1,16,225,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',226,7,'admin/appearance/update','admin/appearance/update','Update','a:0:{}','system',-1,0,0,0,10,3,0,1,7,226,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',227,12,'admin/help/update','admin/help/update','update','a:0:{}','system',-1,0,0,0,0,3,0,1,12,227,0,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',228,222,'admin/reports/updates/install','admin/reports/updates/install','Install new module or theme','a:0:{}','system',-1,0,0,0,25,4,0,1,19,222,228,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',229,222,'admin/reports/updates/update','admin/reports/updates/update','Update','a:0:{}','system',-1,0,0,0,10,4,0,1,19,222,229,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',230,222,'admin/reports/updates/list','admin/reports/updates/list','List','a:0:{}','system',-1,0,0,0,0,4,0,1,19,222,230,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',231,222,'admin/reports/updates/settings','admin/reports/updates/settings','Settings','a:0:{}','system',-1,0,0,0,50,4,0,1,19,222,231,0,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',232,89,'admin/structure/taxonomy/%/display','admin/structure/taxonomy/%/display','Manage display','a:0:{}','system',-1,0,0,0,2,5,0,1,21,57,89,232,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',233,90,'admin/config/people/accounts/display','admin/config/people/accounts/display','Manage display','a:0:{}','system',-1,0,0,0,2,5,0,1,8,48,90,233,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',234,89,'admin/structure/taxonomy/%/fields','admin/structure/taxonomy/%/fields','Manage fields','a:0:{}','system',-1,0,1,0,1,5,0,1,21,57,89,234,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',235,90,'admin/config/people/accounts/fields','admin/config/people/accounts/fields','Manage fields','a:0:{}','system',-1,0,1,0,1,5,0,1,8,48,90,235,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',236,232,'admin/structure/taxonomy/%/display/default','admin/structure/taxonomy/%/display/default','Default','a:0:{}','system',-1,0,0,0,-10,6,0,1,21,57,89,232,236,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',237,233,'admin/config/people/accounts/display/default','admin/config/people/accounts/display/default','Default','a:0:{}','system',-1,0,0,0,-10,6,0,1,8,48,90,233,237,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',238,135,'admin/structure/types/manage/%/display','admin/structure/types/manage/%/display','Manage display','a:0:{}','system',-1,0,0,0,2,5,0,1,21,36,135,238,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',239,135,'admin/structure/types/manage/%/fields','admin/structure/types/manage/%/fields','Manage fields','a:0:{}','system',-1,0,1,0,1,5,0,1,21,36,135,239,0,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',240,232,'admin/structure/taxonomy/%/display/full','admin/structure/taxonomy/%/display/full','Taxonomy term page','a:0:{}','system',-1,0,0,0,0,6,0,1,21,57,89,232,240,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',241,233,'admin/config/people/accounts/display/full','admin/config/people/accounts/display/full','User account','a:0:{}','system',-1,0,0,0,0,6,0,1,8,48,90,233,241,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',242,234,'admin/structure/taxonomy/%/fields/%','admin/structure/taxonomy/%/fields/%','','a:0:{}','system',0,0,0,0,0,6,0,1,21,57,89,234,242,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',243,235,'admin/config/people/accounts/fields/%','admin/config/people/accounts/fields/%','','a:0:{}','system',0,0,0,0,0,6,0,1,8,48,90,235,243,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',244,238,'admin/structure/types/manage/%/display/default','admin/structure/types/manage/%/display/default','Default','a:0:{}','system',-1,0,0,0,-10,6,0,1,21,36,135,238,244,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',245,238,'admin/structure/types/manage/%/display/full','admin/structure/types/manage/%/display/full','Full content','a:0:{}','system',-1,0,0,0,0,6,0,1,21,36,135,238,245,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',246,238,'admin/structure/types/manage/%/display/rss','admin/structure/types/manage/%/display/rss','RSS','a:0:{}','system',-1,0,0,0,2,6,0,1,21,36,135,238,246,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',247,238,'admin/structure/types/manage/%/display/search_index','admin/structure/types/manage/%/display/search_index','Search index','a:0:{}','system',-1,0,0,0,3,6,0,1,21,36,135,238,247,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',248,238,'admin/structure/types/manage/%/display/search_result','admin/structure/types/manage/%/display/search_result','Search result','a:0:{}','system',-1,0,0,0,4,6,0,1,21,36,135,238,248,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',249,238,'admin/structure/types/manage/%/display/teaser','admin/structure/types/manage/%/display/teaser','Teaser','a:0:{}','system',-1,0,0,0,1,6,0,1,21,36,135,238,249,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',250,239,'admin/structure/types/manage/%/fields/%','admin/structure/types/manage/%/fields/%','','a:0:{}','system',0,0,0,0,0,6,0,1,21,36,135,239,250,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',251,242,'admin/structure/taxonomy/%/fields/%/delete','admin/structure/taxonomy/%/fields/%/delete','Delete','a:0:{}','system',-1,0,0,0,10,7,0,1,21,57,89,234,242,251,0,0,0);
INSERT INTO `menu_links` VALUES ('management',252,242,'admin/structure/taxonomy/%/fields/%/edit','admin/structure/taxonomy/%/fields/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,7,0,1,21,57,89,234,242,252,0,0,0);
INSERT INTO `menu_links` VALUES ('management',253,242,'admin/structure/taxonomy/%/fields/%/field-settings','admin/structure/taxonomy/%/fields/%/field-settings','Field settings','a:0:{}','system',-1,0,0,0,0,7,0,1,21,57,89,234,242,253,0,0,0);
INSERT INTO `menu_links` VALUES ('management',254,242,'admin/structure/taxonomy/%/fields/%/widget-type','admin/structure/taxonomy/%/fields/%/widget-type','Widget type','a:0:{}','system',-1,0,0,0,0,7,0,1,21,57,89,234,242,254,0,0,0);
INSERT INTO `menu_links` VALUES ('management',255,243,'admin/config/people/accounts/fields/%/delete','admin/config/people/accounts/fields/%/delete','Delete','a:0:{}','system',-1,0,0,0,10,7,0,1,8,48,90,235,243,255,0,0,0);
INSERT INTO `menu_links` VALUES ('management',256,243,'admin/config/people/accounts/fields/%/edit','admin/config/people/accounts/fields/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,7,0,1,8,48,90,235,243,256,0,0,0);
INSERT INTO `menu_links` VALUES ('management',257,243,'admin/config/people/accounts/fields/%/field-settings','admin/config/people/accounts/fields/%/field-settings','Field settings','a:0:{}','system',-1,0,0,0,0,7,0,1,8,48,90,235,243,257,0,0,0);
INSERT INTO `menu_links` VALUES ('management',258,243,'admin/config/people/accounts/fields/%/widget-type','admin/config/people/accounts/fields/%/widget-type','Widget type','a:0:{}','system',-1,0,0,0,0,7,0,1,8,48,90,235,243,258,0,0,0);
INSERT INTO `menu_links` VALUES ('management',259,173,'admin/structure/types/manage/%/comment/display/default','admin/structure/types/manage/%/comment/display/default','Default','a:0:{}','system',-1,0,0,0,-10,6,0,1,21,36,135,173,259,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',260,173,'admin/structure/types/manage/%/comment/display/full','admin/structure/types/manage/%/comment/display/full','Full comment','a:0:{}','system',-1,0,0,0,0,6,0,1,21,36,135,173,260,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',261,250,'admin/structure/types/manage/%/fields/%/delete','admin/structure/types/manage/%/fields/%/delete','Delete','a:0:{}','system',-1,0,0,0,10,7,0,1,21,36,135,239,250,261,0,0,0);
INSERT INTO `menu_links` VALUES ('management',262,174,'admin/structure/types/manage/%/comment/fields/%','admin/structure/types/manage/%/comment/fields/%','','a:0:{}','system',0,0,0,0,0,6,0,1,21,36,135,174,262,0,0,0,0);
INSERT INTO `menu_links` VALUES ('management',263,250,'admin/structure/types/manage/%/fields/%/edit','admin/structure/types/manage/%/fields/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,7,0,1,21,36,135,239,250,263,0,0,0);
INSERT INTO `menu_links` VALUES ('management',264,250,'admin/structure/types/manage/%/fields/%/field-settings','admin/structure/types/manage/%/fields/%/field-settings','Field settings','a:0:{}','system',-1,0,0,0,0,7,0,1,21,36,135,239,250,264,0,0,0);
INSERT INTO `menu_links` VALUES ('management',265,250,'admin/structure/types/manage/%/fields/%/widget-type','admin/structure/types/manage/%/fields/%/widget-type','Widget type','a:0:{}','system',-1,0,0,0,0,7,0,1,21,36,135,239,250,265,0,0,0);
INSERT INTO `menu_links` VALUES ('management',266,262,'admin/structure/types/manage/%/comment/fields/%/delete','admin/structure/types/manage/%/comment/fields/%/delete','Delete','a:0:{}','system',-1,0,0,0,10,7,0,1,21,36,135,174,262,266,0,0,0);
INSERT INTO `menu_links` VALUES ('management',267,262,'admin/structure/types/manage/%/comment/fields/%/edit','admin/structure/types/manage/%/comment/fields/%/edit','Edit','a:0:{}','system',-1,0,0,0,0,7,0,1,21,36,135,174,262,267,0,0,0);
INSERT INTO `menu_links` VALUES ('management',268,262,'admin/structure/types/manage/%/comment/fields/%/field-settings','admin/structure/types/manage/%/comment/fields/%/field-settings','Field settings','a:0:{}','system',-1,0,0,0,0,7,0,1,21,36,135,174,262,268,0,0,0);
INSERT INTO `menu_links` VALUES ('management',269,262,'admin/structure/types/manage/%/comment/fields/%/widget-type','admin/structure/types/manage/%/comment/fields/%/widget-type','Widget type','a:0:{}','system',-1,0,0,0,0,7,0,1,21,36,135,174,262,269,0,0,0);
/*!40000 ALTER TABLE `menu_links` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `menu_router`
--

DROP TABLE IF EXISTS `menu_router`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_router` (
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: the Drupal path this entry describes',
  `load_functions` blob NOT NULL COMMENT 'A serialized array of function names (like node_load) to be called to load an object corresponding to a part of the current path.',
  `to_arg_functions` blob NOT NULL COMMENT 'A serialized array of function names (like user_uid_optional_to_arg) to be called to replace a part of the router path with another string.',
  `access_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback which determines the access to this router path. Defaults to user_access.',
  `access_arguments` blob COMMENT 'A serialized array of arguments for the access callback.',
  `page_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function that renders the page.',
  `page_arguments` blob COMMENT 'A serialized array of arguments for the page callback.',
  `delivery_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function that sends the result of the page_callback function to the browser.',
  `fit` int(11) NOT NULL DEFAULT '0' COMMENT 'A numeric representation of how specific the path is.',
  `number_parts` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Number of parts in this router path.',
  `context` int(11) NOT NULL DEFAULT '0' COMMENT 'Only for local tasks (tabs) - the context of a local task to control its placement.',
  `tab_parent` varchar(255) NOT NULL DEFAULT '' COMMENT 'Only for local tasks (tabs) - the router path of the parent page (which may also be a local task).',
  `tab_root` varchar(255) NOT NULL DEFAULT '' COMMENT 'Router path of the closest non-tab parent page. For pages that are not local tasks, this will be the same as the path.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title for the current page, or the title for the tab if this is a local task.',
  `title_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'A function which will alter the title. Defaults to t()',
  `title_arguments` varchar(255) NOT NULL DEFAULT '' COMMENT 'A serialized array of arguments for the title callback. If empty, the title will be used as the sole argument for the title callback.',
  `theme_callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'A function which returns the name of the theme that will be used to render this page. If left empty, the default theme will be used.',
  `theme_arguments` varchar(255) NOT NULL DEFAULT '' COMMENT 'A serialized array of arguments for the theme callback.',
  `type` int(11) NOT NULL DEFAULT '0' COMMENT 'Numeric representation of the type of the menu item, like MENU_LOCAL_TASK.',
  `description` text NOT NULL COMMENT 'A description of this item.',
  `position` varchar(255) NOT NULL DEFAULT '' COMMENT 'The position of the block (left or right) on the system administration page for this item.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of the element. Lighter weights are higher up, heavier weights go down.',
  `include_file` mediumtext COMMENT 'The file to include for this element, usually the page callback function lives in this file.',
  PRIMARY KEY (`path`),
  KEY `fit` (`fit`),
  KEY `tab_parent` (`tab_parent`(64),`weight`,`title`),
  KEY `tab_root_weight_title` (`tab_root`(64),`weight`,`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps paths to various callbacks (access, page and title)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_router`
--
-- ORDER BY:  `path`

LOCK TABLES `menu_router` WRITE;
/*!40000 ALTER TABLE `menu_router` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `menu_router` VALUES ('admin','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',1,1,0,'','admin','Administration','t','','','a:0:{}',6,'','',9,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance','','','user_access','a:1:{i:0;s:17:\"administer themes\";}','system_themes_page','a:0:{}','',3,2,0,'','admin/appearance','Appearance','t','','','a:0:{}',6,'Select and configure your themes.','left',-6,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/default','','','user_access','a:1:{i:0;s:17:\"administer themes\";}','system_theme_default','a:0:{}','',7,3,0,'','admin/appearance/default','Set default theme','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/disable','','','user_access','a:1:{i:0;s:17:\"administer themes\";}','system_theme_disable','a:0:{}','',7,3,0,'','admin/appearance/disable','Disable theme','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/enable','','','user_access','a:1:{i:0;s:17:\"administer themes\";}','system_theme_enable','a:0:{}','',7,3,0,'','admin/appearance/enable','Enable theme','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/install','','','update_manager_access','a:0:{}','drupal_get_form','a:2:{i:0;s:27:\"update_manager_install_form\";i:1;s:5:\"theme\";}','',7,3,1,'admin/appearance','admin/appearance','Install new theme','t','','','a:0:{}',388,'','',25,'modules/update/update.manager.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/list','','','user_access','a:1:{i:0;s:17:\"administer themes\";}','system_themes_page','a:0:{}','',7,3,1,'admin/appearance','admin/appearance','List','t','','','a:0:{}',140,'Select and configure your theme','',-1,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/settings','','','user_access','a:1:{i:0;s:17:\"administer themes\";}','drupal_get_form','a:1:{i:0;s:21:\"system_theme_settings\";}','',7,3,1,'admin/appearance','admin/appearance','Settings','t','','','a:0:{}',132,'Configure default and theme specific settings.','',20,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/settings/bartik','','','_system_themes_access','a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:25:\"themes/bartik/bartik.info\";s:4:\"name\";s:6:\"bartik\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:6:\"Bartik\";s:11:\"description\";s:48:\"A flexible, recolorable theme with many regions.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:7:\"regions\";a:20:{s:6:\"header\";s:6:\"Header\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:11:\"highlighted\";s:11:\"Highlighted\";s:8:\"featured\";s:8:\"Featured\";s:7:\"content\";s:7:\"Content\";s:13:\"sidebar_first\";s:13:\"Sidebar first\";s:14:\"sidebar_second\";s:14:\"Sidebar second\";s:14:\"triptych_first\";s:14:\"Triptych first\";s:15:\"triptych_middle\";s:15:\"Triptych middle\";s:13:\"triptych_last\";s:13:\"Triptych last\";s:18:\"footer_firstcolumn\";s:19:\"Footer first column\";s:19:\"footer_secondcolumn\";s:20:\"Footer second column\";s:18:\"footer_thirdcolumn\";s:19:\"Footer third column\";s:19:\"footer_fourthcolumn\";s:20:\"Footer fourth column\";s:6:\"footer\";s:6:\"Footer\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"0\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:28:\"themes/bartik/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','drupal_get_form','a:2:{i:0;s:21:\"system_theme_settings\";i:1;s:6:\"bartik\";}','',15,4,1,'admin/appearance/settings','admin/appearance','Bartik','t','','','a:0:{}',132,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/settings/garland','','','_system_themes_access','a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:27:\"themes/garland/garland.info\";s:4:\"name\";s:7:\"garland\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:7:\"Garland\";s:11:\"description\";s:111:\"A multi-column theme which can be configured to modify colors and switch between fixed and fluid width layouts.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:8:\"settings\";a:1:{s:13:\"garland_width\";s:5:\"fluid\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:29:\"themes/garland/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','drupal_get_form','a:2:{i:0;s:21:\"system_theme_settings\";i:1;s:7:\"garland\";}','',15,4,1,'admin/appearance/settings','admin/appearance','Garland','t','','','a:0:{}',132,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/settings/global','','','user_access','a:1:{i:0;s:17:\"administer themes\";}','drupal_get_form','a:1:{i:0;s:21:\"system_theme_settings\";}','',15,4,1,'admin/appearance/settings','admin/appearance','Global settings','t','','','a:0:{}',140,'','',-1,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/settings/seven','','','_system_themes_access','a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:23:\"themes/seven/seven.info\";s:4:\"name\";s:5:\"seven\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:5:\"Seven\";s:11:\"description\";s:65:\"A simple one-column, tableless, fluid width administration theme.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"1\";}s:7:\"regions\";a:8:{s:7:\"content\";s:7:\"Content\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:13:\"sidebar_first\";s:13:\"First sidebar\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:14:\"regions_hidden\";a:3:{i:0;s:13:\"sidebar_first\";i:1;s:8:\"page_top\";i:2;s:11:\"page_bottom\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/seven/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','drupal_get_form','a:2:{i:0;s:21:\"system_theme_settings\";i:1;s:5:\"seven\";}','',15,4,1,'admin/appearance/settings','admin/appearance','Seven','t','','','a:0:{}',132,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/settings/stark','','','_system_themes_access','a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:23:\"themes/stark/stark.info\";s:4:\"name\";s:5:\"stark\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:17:{s:4:\"name\";s:5:\"Stark\";s:11:\"description\";s:208:\"This theme demonstrates Drupal\'s default HTML markup and CSS styles. To learn how to build your own theme and override Drupal\'s default code, see the <a href=\"http://drupal.org/theme-guide\">Theming Guide</a>.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/stark/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','drupal_get_form','a:2:{i:0;s:21:\"system_theme_settings\";i:1;s:5:\"stark\";}','',15,4,1,'admin/appearance/settings','admin/appearance','Stark','t','','','a:0:{}',132,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/appearance/update','','','update_manager_access','a:0:{}','drupal_get_form','a:2:{i:0;s:26:\"update_manager_update_form\";i:1;s:5:\"theme\";}','',7,3,1,'admin/appearance','admin/appearance','Update','t','','','a:0:{}',132,'','',10,'modules/update/update.manager.inc');
INSERT INTO `menu_router` VALUES ('admin/compact','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_compact_page','a:0:{}','',3,2,0,'','admin/compact','Compact mode','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_config_page','a:0:{}','',3,2,0,'','admin/config','Configuration','t','','','a:0:{}',6,'Administer settings.','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/content','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/content','Content authoring','t','','','a:0:{}',6,'Settings related to formatting and authoring content.','left',-15,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/content/formats','','','user_access','a:1:{i:0;s:18:\"administer filters\";}','drupal_get_form','a:1:{i:0;s:21:\"filter_admin_overview\";}','',15,4,0,'','admin/config/content/formats','Text formats','t','','','a:0:{}',6,'Configure how content input by users is filtered, including allowed HTML tags. Also allows enabling of module-provided filters.','',0,'modules/filter/filter.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/content/formats/%','a:1:{i:4;s:18:\"filter_format_load\";}','','user_access','a:1:{i:0;s:18:\"administer filters\";}','filter_admin_format_page','a:1:{i:0;i:4;}','',30,5,0,'','admin/config/content/formats/%','','filter_admin_format_title','a:1:{i:0;i:4;}','','a:0:{}',6,'','',0,'modules/filter/filter.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/content/formats/%/disable','a:1:{i:4;s:18:\"filter_format_load\";}','','_filter_disable_format_access','a:1:{i:0;i:4;}','drupal_get_form','a:2:{i:0;s:20:\"filter_admin_disable\";i:1;i:4;}','',61,6,0,'','admin/config/content/formats/%/disable','Disable text format','t','','','a:0:{}',6,'','',0,'modules/filter/filter.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/content/formats/add','','','user_access','a:1:{i:0;s:18:\"administer filters\";}','filter_admin_format_page','a:0:{}','',31,5,1,'admin/config/content/formats','admin/config/content/formats','Add text format','t','','','a:0:{}',388,'','',1,'modules/filter/filter.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/content/formats/list','','','user_access','a:1:{i:0;s:18:\"administer filters\";}','drupal_get_form','a:1:{i:0;s:21:\"filter_admin_overview\";}','',31,5,1,'admin/config/content/formats','admin/config/content/formats','List','t','','','a:0:{}',140,'','',0,'modules/filter/filter.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/development','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/development','Development','t','','','a:0:{}',6,'Development tools.','right',-10,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/development/logging','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:23:\"system_logging_settings\";}','',15,4,0,'','admin/config/development/logging','Logging and errors','t','','','a:0:{}',6,'Settings for logging and alerts modules. Various modules can route Drupal\'s system events to different destinations, such as syslog, database, email, etc.','',-15,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/development/maintenance','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:28:\"system_site_maintenance_mode\";}','',15,4,0,'','admin/config/development/maintenance','Maintenance mode','t','','','a:0:{}',6,'Take the site offline for maintenance or bring it back online.','',-10,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/development/performance','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:27:\"system_performance_settings\";}','',15,4,0,'','admin/config/development/performance','Performance','t','','','a:0:{}',6,'Enable or disable page caching for anonymous users and set CSS and JS bandwidth optimization options.','',-20,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/media','Media','t','','','a:0:{}',6,'Media tools.','left',-10,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/file-system','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:27:\"system_file_system_settings\";}','',15,4,0,'','admin/config/media/file-system','File system','t','','','a:0:{}',6,'Tell Drupal where to store uploaded files and how they are accessed.','',-10,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles','','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','image_style_list','a:0:{}','',15,4,0,'','admin/config/media/image-styles','Image styles','t','','','a:0:{}',6,'Configure styles that can be used for resizing or adjusting images on display.','',0,'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles/add','','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','drupal_get_form','a:1:{i:0;s:20:\"image_style_add_form\";}','',31,5,1,'admin/config/media/image-styles','admin/config/media/image-styles','Add style','t','','','a:0:{}',388,'Add a new image style.','',2,'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles/delete/%','a:1:{i:5;a:1:{s:16:\"image_style_load\";a:2:{i:0;N;i:1;s:1:\"1\";}}}','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','drupal_get_form','a:2:{i:0;s:23:\"image_style_delete_form\";i:1;i:5;}','',62,6,0,'','admin/config/media/image-styles/delete/%','Delete style','t','','','a:0:{}',6,'Delete an image style.','',0,'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles/edit/%','a:1:{i:5;s:16:\"image_style_load\";}','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','drupal_get_form','a:2:{i:0;s:16:\"image_style_form\";i:1;i:5;}','',62,6,0,'','admin/config/media/image-styles/edit/%','Edit style','t','','','a:0:{}',6,'Configure an image style.','',0,'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles/edit/%/add/%','a:2:{i:5;a:1:{s:16:\"image_style_load\";a:1:{i:0;i:5;}}i:7;a:1:{s:28:\"image_effect_definition_load\";a:1:{i:0;i:5;}}}','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','drupal_get_form','a:3:{i:0;s:17:\"image_effect_form\";i:1;i:5;i:2;i:7;}','',250,8,0,'','admin/config/media/image-styles/edit/%/add/%','Add image effect','t','','','a:0:{}',6,'Add a new effect to a style.','',0,'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles/edit/%/effects/%','a:2:{i:5;a:1:{s:16:\"image_style_load\";a:2:{i:0;i:5;i:1;s:1:\"3\";}}i:7;a:1:{s:17:\"image_effect_load\";a:2:{i:0;i:5;i:1;s:1:\"3\";}}}','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','drupal_get_form','a:3:{i:0;s:17:\"image_effect_form\";i:1;i:5;i:2;i:7;}','',250,8,0,'','admin/config/media/image-styles/edit/%/effects/%','Edit image effect','t','','','a:0:{}',6,'Edit an existing effect within a style.','',0,'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles/edit/%/effects/%/delete','a:2:{i:5;a:1:{s:16:\"image_style_load\";a:2:{i:0;i:5;i:1;s:1:\"3\";}}i:7;a:1:{s:17:\"image_effect_load\";a:2:{i:0;i:5;i:1;s:1:\"3\";}}}','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','drupal_get_form','a:3:{i:0;s:24:\"image_effect_delete_form\";i:1;i:5;i:2;i:7;}','',501,9,0,'','admin/config/media/image-styles/edit/%/effects/%/delete','Delete image effect','t','','','a:0:{}',6,'Delete an existing effect from a style.','',0,'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles/list','','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','image_style_list','a:0:{}','',31,5,1,'admin/config/media/image-styles','admin/config/media/image-styles','List','t','','','a:0:{}',140,'List the current image styles on the site.','',1,'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-styles/revert/%','a:1:{i:5;a:1:{s:16:\"image_style_load\";a:2:{i:0;N;i:1;s:1:\"2\";}}}','','user_access','a:1:{i:0;s:23:\"administer image styles\";}','drupal_get_form','a:2:{i:0;s:23:\"image_style_revert_form\";i:1;i:5;}','',62,6,0,'','admin/config/media/image-styles/revert/%','Revert style','t','','','a:0:{}',6,'Revert an image style.','',0,'modules/image/image.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/media/image-toolkit','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:29:\"system_image_toolkit_settings\";}','',15,4,0,'','admin/config/media/image-toolkit','Image toolkit','t','','','a:0:{}',6,'Choose which image toolkit to use if you have installed optional toolkits.','',20,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/people','People','t','','','a:0:{}',6,'Configure user accounts.','left',-20,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts','','','user_access','a:1:{i:0;s:16:\"administer users\";}','drupal_get_form','a:1:{i:0;s:19:\"user_admin_settings\";}','',15,4,0,'','admin/config/people/accounts','Account settings','t','','','a:0:{}',6,'Configure default behavior of users, including registration requirements, e-mails, fields, and user pictures.','',-10,'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/display','','','user_access','a:1:{i:0;s:16:\"administer users\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"user\";i:2;s:4:\"user\";i:3;s:7:\"default\";}','',31,5,1,'admin/config/people/accounts','admin/config/people/accounts','Manage display','t','','','a:0:{}',132,'','',2,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/display/default','','','_field_ui_view_mode_menu_access','a:5:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:7:\"default\";i:3;s:11:\"user_access\";i:4;s:16:\"administer users\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"user\";i:2;s:4:\"user\";i:3;s:7:\"default\";}','',63,6,1,'admin/config/people/accounts/display','admin/config/people/accounts','Default','t','','','a:0:{}',140,'','',-10,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/display/full','','','_field_ui_view_mode_menu_access','a:5:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:4:\"full\";i:3;s:11:\"user_access\";i:4;s:16:\"administer users\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"user\";i:2;s:4:\"user\";i:3;s:4:\"full\";}','',63,6,1,'admin/config/people/accounts/display','admin/config/people/accounts','User account','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/fields','','','user_access','a:1:{i:0;s:16:\"administer users\";}','drupal_get_form','a:3:{i:0;s:28:\"field_ui_field_overview_form\";i:1;s:4:\"user\";i:2;s:4:\"user\";}','',31,5,1,'admin/config/people/accounts','admin/config/people/accounts','Manage fields','t','','','a:0:{}',132,'','',1,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/fields/%','a:1:{i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:1:\"0\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:16:\"administer users\";}','drupal_get_form','a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:5;}','',62,6,0,'','admin/config/people/accounts/fields/%','','field_ui_menu_title','a:1:{i:0;i:5;}','','a:0:{}',6,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/fields/%/delete','a:1:{i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:1:\"0\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:16:\"administer users\";}','drupal_get_form','a:2:{i:0;s:26:\"field_ui_field_delete_form\";i:1;i:5;}','',125,7,1,'admin/config/people/accounts/fields/%','admin/config/people/accounts/fields/%','Delete','t','','','a:0:{}',132,'','',10,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/fields/%/edit','a:1:{i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:1:\"0\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:16:\"administer users\";}','drupal_get_form','a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:5;}','',125,7,1,'admin/config/people/accounts/fields/%','admin/config/people/accounts/fields/%','Edit','t','','','a:0:{}',140,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/fields/%/field-settings','a:1:{i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:1:\"0\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:16:\"administer users\";}','drupal_get_form','a:2:{i:0;s:28:\"field_ui_field_settings_form\";i:1;i:5;}','',125,7,1,'admin/config/people/accounts/fields/%','admin/config/people/accounts/fields/%','Field settings','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/fields/%/widget-type','a:1:{i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"user\";i:1;s:4:\"user\";i:2;s:1:\"0\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:16:\"administer users\";}','drupal_get_form','a:2:{i:0;s:25:\"field_ui_widget_type_form\";i:1;i:5;}','',125,7,1,'admin/config/people/accounts/fields/%','admin/config/people/accounts/fields/%','Widget type','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/accounts/settings','','','user_access','a:1:{i:0;s:16:\"administer users\";}','drupal_get_form','a:1:{i:0;s:19:\"user_admin_settings\";}','',31,5,1,'admin/config/people/accounts','admin/config/people/accounts','Settings','t','','','a:0:{}',140,'','',-10,'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/ip-blocking','','','user_access','a:1:{i:0;s:18:\"block IP addresses\";}','system_ip_blocking','a:0:{}','',15,4,0,'','admin/config/people/ip-blocking','IP address blocking','t','','','a:0:{}',6,'Manage blocked IP addresses.','',10,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/people/ip-blocking/delete/%','a:1:{i:5;s:15:\"blocked_ip_load\";}','','user_access','a:1:{i:0;s:18:\"block IP addresses\";}','drupal_get_form','a:2:{i:0;s:25:\"system_ip_blocking_delete\";i:1;i:5;}','',62,6,0,'','admin/config/people/ip-blocking/delete/%','Delete IP address','t','','','a:0:{}',6,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/regional','Regional and language','t','','','a:0:{}',6,'Regional settings, localization and translation.','left',-5,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:25:\"system_date_time_settings\";}','',15,4,0,'','admin/config/regional/date-time','Date and time','t','','','a:0:{}',6,'Configure display formats for date and time.','',-15,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time/formats','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','system_date_time_formats','a:0:{}','',31,5,1,'admin/config/regional/date-time','admin/config/regional/date-time','Formats','t','','','a:0:{}',132,'Configure display format strings for date and time.','',-9,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time/formats/%/delete','a:1:{i:5;N;}','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:2:{i:0;s:30:\"system_date_delete_format_form\";i:1;i:5;}','',125,7,0,'','admin/config/regional/date-time/formats/%/delete','Delete date format','t','','','a:0:{}',6,'Allow users to delete a configured date format.','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time/formats/%/edit','a:1:{i:5;N;}','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:2:{i:0;s:34:\"system_configure_date_formats_form\";i:1;i:5;}','',125,7,0,'','admin/config/regional/date-time/formats/%/edit','Edit date format','t','','','a:0:{}',6,'Allow users to edit a configured date format.','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time/formats/add','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:34:\"system_configure_date_formats_form\";}','',63,6,1,'admin/config/regional/date-time/formats','admin/config/regional/date-time','Add format','t','','','a:0:{}',388,'Allow users to add additional date formats.','',-10,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time/formats/lookup','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','system_date_time_lookup','a:0:{}','',63,6,0,'','admin/config/regional/date-time/formats/lookup','Date and time lookup','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time/types','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:25:\"system_date_time_settings\";}','',31,5,1,'admin/config/regional/date-time','admin/config/regional/date-time','Types','t','','','a:0:{}',140,'Configure display formats for date and time.','',-10,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time/types/%/delete','a:1:{i:5;N;}','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:2:{i:0;s:35:\"system_delete_date_format_type_form\";i:1;i:5;}','',125,7,0,'','admin/config/regional/date-time/types/%/delete','Delete date type','t','','','a:0:{}',6,'Allow users to delete a configured date type.','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/date-time/types/add','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:32:\"system_add_date_format_type_form\";}','',63,6,1,'admin/config/regional/date-time/types','admin/config/regional/date-time','Add date type','t','','','a:0:{}',388,'Add new date type.','',-10,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/regional/settings','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:24:\"system_regional_settings\";}','',15,4,0,'','admin/config/regional/settings','Regional settings','t','','','a:0:{}',6,'Settings for the site\'s default time zone and country.','',-20,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/search','Search and metadata','t','','','a:0:{}',6,'Local site search, metadata and SEO.','left',-10,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/clean-urls','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:25:\"system_clean_url_settings\";}','',15,4,0,'','admin/config/search/clean-urls','Clean URLs','t','','','a:0:{}',6,'Enable or disable clean URLs for your site.','',5,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/clean-urls/check','','','1','a:0:{}','drupal_json_output','a:1:{i:0;a:1:{s:6:\"status\";b:1;}}','',31,5,0,'','admin/config/search/clean-urls/check','Clean URL check','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/path','','','user_access','a:1:{i:0;s:22:\"administer url aliases\";}','path_admin_overview','a:0:{}','',15,4,0,'','admin/config/search/path','URL aliases','t','','','a:0:{}',6,'Change your site\'s URL paths by aliasing them.','',-5,'modules/path/path.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/path/add','','','user_access','a:1:{i:0;s:22:\"administer url aliases\";}','path_admin_edit','a:0:{}','',31,5,1,'admin/config/search/path','admin/config/search/path','Add alias','t','','','a:0:{}',388,'','',0,'modules/path/path.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/path/delete/%','a:1:{i:5;s:9:\"path_load\";}','','user_access','a:1:{i:0;s:22:\"administer url aliases\";}','drupal_get_form','a:2:{i:0;s:25:\"path_admin_delete_confirm\";i:1;i:5;}','',62,6,0,'','admin/config/search/path/delete/%','Delete alias','t','','','a:0:{}',6,'','',0,'modules/path/path.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/path/edit/%','a:1:{i:5;s:9:\"path_load\";}','','user_access','a:1:{i:0;s:22:\"administer url aliases\";}','path_admin_edit','a:1:{i:0;i:5;}','',62,6,0,'','admin/config/search/path/edit/%','Edit alias','t','','','a:0:{}',6,'','',0,'modules/path/path.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/path/list','','','user_access','a:1:{i:0;s:22:\"administer url aliases\";}','path_admin_overview','a:0:{}','',31,5,1,'admin/config/search/path','admin/config/search/path','List','t','','','a:0:{}',140,'','',-10,'modules/path/path.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/settings','','','user_access','a:1:{i:0;s:17:\"administer search\";}','drupal_get_form','a:1:{i:0;s:21:\"search_admin_settings\";}','',15,4,0,'','admin/config/search/settings','Search settings','t','','','a:0:{}',6,'Configure relevance settings for search and other indexing options.','',-10,'modules/search/search.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/search/settings/reindex','','','user_access','a:1:{i:0;s:17:\"administer search\";}','drupal_get_form','a:1:{i:0;s:22:\"search_reindex_confirm\";}','',31,5,0,'','admin/config/search/settings/reindex','Clear index','t','','','a:0:{}',4,'','',0,'modules/search/search.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/services','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/services','Web services','t','','','a:0:{}',6,'Tools related to web services.','right',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/services/rss-publishing','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:25:\"system_rss_feeds_settings\";}','',15,4,0,'','admin/config/services/rss-publishing','RSS publishing','t','','','a:0:{}',6,'Configure the site description, the number of items per feed and whether feeds should be titles/teasers/full-text.','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/system','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/system','System','t','','','a:0:{}',6,'General system related configuration.','right',-20,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/system/actions','','','user_access','a:1:{i:0;s:18:\"administer actions\";}','system_actions_manage','a:0:{}','',15,4,0,'','admin/config/system/actions','Actions','t','','','a:0:{}',6,'Manage the actions defined for your site.','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/system/actions/configure','','','user_access','a:1:{i:0;s:18:\"administer actions\";}','drupal_get_form','a:1:{i:0;s:24:\"system_actions_configure\";}','',31,5,0,'','admin/config/system/actions/configure','Configure an advanced action','t','','','a:0:{}',4,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/system/actions/delete/%','a:1:{i:5;s:12:\"actions_load\";}','','user_access','a:1:{i:0;s:18:\"administer actions\";}','drupal_get_form','a:2:{i:0;s:26:\"system_actions_delete_form\";i:1;i:5;}','',62,6,0,'','admin/config/system/actions/delete/%','Delete action','t','','','a:0:{}',6,'Delete an action.','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/system/actions/manage','','','user_access','a:1:{i:0;s:18:\"administer actions\";}','system_actions_manage','a:0:{}','',31,5,1,'admin/config/system/actions','admin/config/system/actions','Manage actions','t','','','a:0:{}',140,'Manage the actions defined for your site.','',-2,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/system/actions/orphan','','','user_access','a:1:{i:0;s:18:\"administer actions\";}','system_actions_remove_orphans','a:0:{}','',31,5,0,'','admin/config/system/actions/orphan','Remove orphans','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/system/cron','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:20:\"system_cron_settings\";}','',15,4,0,'','admin/config/system/cron','Cron','t','','','a:0:{}',6,'Manage automatic site maintenance tasks.','',20,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/system/site-information','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:32:\"system_site_information_settings\";}','',15,4,0,'','admin/config/system/site-information','Site information','t','','','a:0:{}',6,'Change site name, e-mail address, slogan, default front page, and number of posts per page, error pages.','',-20,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/user-interface','User interface','t','','','a:0:{}',6,'Tools that enhance the user interface.','right',-15,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut','','','user_access','a:1:{i:0;s:20:\"administer shortcuts\";}','shortcut_set_admin','a:0:{}','',15,4,0,'','admin/config/user-interface/shortcut','Shortcuts','t','','','a:0:{}',6,'Add and modify shortcut sets.','',0,'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/%','a:1:{i:4;s:17:\"shortcut_set_load\";}','','shortcut_set_edit_access','a:1:{i:0;i:4;}','drupal_get_form','a:2:{i:0;s:22:\"shortcut_set_customize\";i:1;i:4;}','',30,5,0,'','admin/config/user-interface/shortcut/%','Edit shortcuts','shortcut_set_title_callback','a:1:{i:0;i:4;}','','a:0:{}',6,'','',0,'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/%/add-link','a:1:{i:4;s:17:\"shortcut_set_load\";}','','shortcut_set_edit_access','a:1:{i:0;i:4;}','drupal_get_form','a:2:{i:0;s:17:\"shortcut_link_add\";i:1;i:4;}','',61,6,1,'admin/config/user-interface/shortcut/%','admin/config/user-interface/shortcut/%','Add shortcut','t','','','a:0:{}',388,'','',0,'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/%/add-link-inline','a:1:{i:4;s:17:\"shortcut_set_load\";}','','shortcut_set_edit_access','a:1:{i:0;i:4;}','shortcut_link_add_inline','a:1:{i:0;i:4;}','',61,6,0,'','admin/config/user-interface/shortcut/%/add-link-inline','Add shortcut','t','','','a:0:{}',0,'','',0,'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/%/delete','a:1:{i:4;s:17:\"shortcut_set_load\";}','','shortcut_set_delete_access','a:1:{i:0;i:4;}','drupal_get_form','a:2:{i:0;s:24:\"shortcut_set_delete_form\";i:1;i:4;}','',61,6,0,'','admin/config/user-interface/shortcut/%/delete','Delete shortcut set','t','','','a:0:{}',6,'','',0,'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/%/edit','a:1:{i:4;s:17:\"shortcut_set_load\";}','','shortcut_set_edit_access','a:1:{i:0;i:4;}','drupal_get_form','a:2:{i:0;s:22:\"shortcut_set_edit_form\";i:1;i:4;}','',61,6,1,'admin/config/user-interface/shortcut/%','admin/config/user-interface/shortcut/%','Edit set name','t','','','a:0:{}',132,'','',10,'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/%/links','a:1:{i:4;s:17:\"shortcut_set_load\";}','','shortcut_set_edit_access','a:1:{i:0;i:4;}','drupal_get_form','a:2:{i:0;s:22:\"shortcut_set_customize\";i:1;i:4;}','',61,6,1,'admin/config/user-interface/shortcut/%','admin/config/user-interface/shortcut/%','List links','t','','','a:0:{}',140,'','',0,'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/add-set','','','user_access','a:1:{i:0;s:20:\"administer shortcuts\";}','drupal_get_form','a:1:{i:0;s:21:\"shortcut_set_add_form\";}','',31,5,1,'admin/config/user-interface/shortcut','admin/config/user-interface/shortcut','Add shortcut set','t','','','a:0:{}',388,'','',0,'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/link/%','a:1:{i:5;s:14:\"menu_link_load\";}','','shortcut_link_access','a:1:{i:0;i:5;}','drupal_get_form','a:2:{i:0;s:18:\"shortcut_link_edit\";i:1;i:5;}','',62,6,0,'','admin/config/user-interface/shortcut/link/%','Edit shortcut','t','','','a:0:{}',6,'','',0,'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/user-interface/shortcut/link/%/delete','a:1:{i:5;s:14:\"menu_link_load\";}','','shortcut_link_access','a:1:{i:0;i:5;}','drupal_get_form','a:2:{i:0;s:20:\"shortcut_link_delete\";i:1;i:5;}','',125,7,0,'','admin/config/user-interface/shortcut/link/%/delete','Delete shortcut','t','','','a:0:{}',6,'','',0,'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/config/workflow','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',7,3,0,'','admin/config/workflow','Workflow','t','','','a:0:{}',6,'Content workflow, editorial workflow tools.','right',5,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/content','','','user_access','a:1:{i:0;s:23:\"access content overview\";}','drupal_get_form','a:1:{i:0;s:18:\"node_admin_content\";}','',3,2,0,'','admin/content','Content','t','','','a:0:{}',6,'Administer content and comments.','',-10,'modules/node/node.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/content/comment','','','user_access','a:1:{i:0;s:19:\"administer comments\";}','comment_admin','a:0:{}','',7,3,1,'admin/content','admin/content','Comments','t','','','a:0:{}',134,'List and edit site comments and the comment approval queue.','',0,'modules/comment/comment.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/content/comment/approval','','','user_access','a:1:{i:0;s:19:\"administer comments\";}','comment_admin','a:1:{i:0;s:8:\"approval\";}','',15,4,1,'admin/content/comment','admin/content','Unapproved comments','comment_count_unpublished','','','a:0:{}',132,'','',0,'modules/comment/comment.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/content/comment/new','','','user_access','a:1:{i:0;s:19:\"administer comments\";}','comment_admin','a:0:{}','',15,4,1,'admin/content/comment','admin/content','Published comments','t','','','a:0:{}',140,'','',-10,'modules/comment/comment.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/content/node','','','user_access','a:1:{i:0;s:23:\"access content overview\";}','drupal_get_form','a:1:{i:0;s:18:\"node_admin_content\";}','',7,3,1,'admin/content','admin/content','Content','t','','','a:0:{}',140,'','',-10,'modules/node/node.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/dashboard','','','user_access','a:1:{i:0;s:16:\"access dashboard\";}','dashboard_admin','a:0:{}','',3,2,0,'','admin/dashboard','Dashboard','t','','','a:0:{}',6,'View and customize your dashboard.','',-15,'');
INSERT INTO `menu_router` VALUES ('admin/dashboard/block-content/%/%','a:2:{i:3;N;i:4;N;}','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','dashboard_show_block_content','a:2:{i:0;i:3;i:1;i:4;}','',28,5,0,'','admin/dashboard/block-content/%/%','','t','','','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('admin/dashboard/configure','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','dashboard_admin_blocks','a:0:{}','',7,3,0,'','admin/dashboard/configure','Configure available dashboard blocks','t','','','a:0:{}',4,'Configure which blocks can be shown on the dashboard.','',0,'');
INSERT INTO `menu_router` VALUES ('admin/dashboard/customize','','','user_access','a:1:{i:0;s:16:\"access dashboard\";}','dashboard_admin','a:1:{i:0;b:1;}','',7,3,0,'','admin/dashboard/customize','Customize dashboard','t','','','a:0:{}',4,'Customize your dashboard.','',0,'');
INSERT INTO `menu_router` VALUES ('admin/dashboard/drawer','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','dashboard_show_disabled','a:0:{}','',7,3,0,'','admin/dashboard/drawer','','t','','','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('admin/dashboard/update','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','dashboard_update','a:0:{}','',7,3,0,'','admin/dashboard/update','','t','','','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('admin/help','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_main','a:0:{}','',3,2,0,'','admin/help','Help','t','','','a:0:{}',6,'Reference for usage, configuration, and modules.','',9,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/block','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/block','block','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/color','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/color','color','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/comment','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/comment','comment','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/contextual','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/contextual','contextual','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/dashboard','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/dashboard','dashboard','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/dblog','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/dblog','dblog','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/field','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/field','field','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/field_sql_storage','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/field_sql_storage','field_sql_storage','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/field_ui','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/field_ui','field_ui','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/file','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/file','file','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/filter','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/filter','filter','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/help','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/help','help','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/image','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/image','image','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/list','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/list','list','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/menu','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/menu','menu','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/node','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/node','node','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/number','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/number','number','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/options','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/options','options','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/overlay','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/overlay','overlay','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/path','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/path','path','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/rdf','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/rdf','rdf','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/search','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/search','search','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/shortcut','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/shortcut','shortcut','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/system','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/system','system','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/taxonomy','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/taxonomy','taxonomy','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/text','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/text','text','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/toolbar','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/toolbar','toolbar','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/update','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/update','update','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/help/user','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','help_page','a:1:{i:0;i:2;}','',7,3,0,'','admin/help/user','user','t','','','a:0:{}',4,'','',0,'modules/help/help.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/index','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_index','a:0:{}','',3,2,1,'admin','admin','Index','t','','','a:0:{}',132,'','',-18,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/modules','','','user_access','a:1:{i:0;s:18:\"administer modules\";}','drupal_get_form','a:1:{i:0;s:14:\"system_modules\";}','',3,2,0,'','admin/modules','Modules','t','','','a:0:{}',6,'Extend site functionality.','',-2,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/modules/install','','','update_manager_access','a:0:{}','drupal_get_form','a:2:{i:0;s:27:\"update_manager_install_form\";i:1;s:6:\"module\";}','',7,3,1,'admin/modules','admin/modules','Install new module','t','','','a:0:{}',388,'','',25,'modules/update/update.manager.inc');
INSERT INTO `menu_router` VALUES ('admin/modules/list','','','user_access','a:1:{i:0;s:18:\"administer modules\";}','drupal_get_form','a:1:{i:0;s:14:\"system_modules\";}','',7,3,1,'admin/modules','admin/modules','List','t','','','a:0:{}',140,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/modules/list/confirm','','','user_access','a:1:{i:0;s:18:\"administer modules\";}','drupal_get_form','a:1:{i:0;s:14:\"system_modules\";}','',15,4,0,'','admin/modules/list/confirm','List','t','','','a:0:{}',4,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/modules/uninstall','','','user_access','a:1:{i:0;s:18:\"administer modules\";}','drupal_get_form','a:1:{i:0;s:24:\"system_modules_uninstall\";}','',7,3,1,'admin/modules','admin/modules','Uninstall','t','','','a:0:{}',132,'','',20,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/modules/uninstall/confirm','','','user_access','a:1:{i:0;s:18:\"administer modules\";}','drupal_get_form','a:1:{i:0;s:24:\"system_modules_uninstall\";}','',15,4,0,'','admin/modules/uninstall/confirm','Uninstall','t','','','a:0:{}',4,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/modules/update','','','update_manager_access','a:0:{}','drupal_get_form','a:2:{i:0;s:26:\"update_manager_update_form\";i:1;s:6:\"module\";}','',7,3,1,'admin/modules','admin/modules','Update','t','','','a:0:{}',132,'','',10,'modules/update/update.manager.inc');
INSERT INTO `menu_router` VALUES ('admin/people','','','user_access','a:1:{i:0;s:16:\"administer users\";}','user_admin','a:1:{i:0;s:4:\"list\";}','',3,2,0,'','admin/people','People','t','','','a:0:{}',6,'Manage user accounts, roles, and permissions.','left',-4,'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/people/create','','','user_access','a:1:{i:0;s:16:\"administer users\";}','user_admin','a:1:{i:0;s:6:\"create\";}','',7,3,1,'admin/people','admin/people','Add user','t','','','a:0:{}',388,'','',0,'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/people/people','','','user_access','a:1:{i:0;s:16:\"administer users\";}','user_admin','a:1:{i:0;s:4:\"list\";}','',7,3,1,'admin/people','admin/people','List','t','','','a:0:{}',140,'Find and manage people interacting with your site.','',-10,'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/people/permissions','','','user_access','a:1:{i:0;s:22:\"administer permissions\";}','drupal_get_form','a:1:{i:0;s:22:\"user_admin_permissions\";}','',7,3,1,'admin/people','admin/people','Permissions','t','','','a:0:{}',132,'Determine access to features by selecting permissions for roles.','',0,'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/people/permissions/list','','','user_access','a:1:{i:0;s:22:\"administer permissions\";}','drupal_get_form','a:1:{i:0;s:22:\"user_admin_permissions\";}','',15,4,1,'admin/people/permissions','admin/people','Permissions','t','','','a:0:{}',140,'Determine access to features by selecting permissions for roles.','',-8,'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/people/permissions/roles','','','user_access','a:1:{i:0;s:22:\"administer permissions\";}','drupal_get_form','a:1:{i:0;s:16:\"user_admin_roles\";}','',15,4,1,'admin/people/permissions','admin/people','Roles','t','','','a:0:{}',132,'List, edit, or add user roles.','',-5,'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/people/permissions/roles/delete/%','a:1:{i:5;s:14:\"user_role_load\";}','','user_role_edit_access','a:1:{i:0;i:5;}','drupal_get_form','a:2:{i:0;s:30:\"user_admin_role_delete_confirm\";i:1;i:5;}','',62,6,0,'','admin/people/permissions/roles/delete/%','Delete role','t','','','a:0:{}',6,'','',0,'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/people/permissions/roles/edit/%','a:1:{i:5;s:14:\"user_role_load\";}','','user_role_edit_access','a:1:{i:0;i:5;}','drupal_get_form','a:2:{i:0;s:15:\"user_admin_role\";i:1;i:5;}','',62,6,0,'','admin/people/permissions/roles/edit/%','Edit role','t','','','a:0:{}',6,'','',0,'modules/user/user.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports','','','user_access','a:1:{i:0;s:19:\"access site reports\";}','system_admin_menu_block_page','a:0:{}','',3,2,0,'','admin/reports','Reports','t','','','a:0:{}',6,'View reports, updates, and errors.','left',5,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/access-denied','','','user_access','a:1:{i:0;s:19:\"access site reports\";}','dblog_top','a:1:{i:0;s:13:\"access denied\";}','',7,3,0,'','admin/reports/access-denied','Top \'access denied\' errors','t','','','a:0:{}',6,'View \'access denied\' errors (403s).','',0,'modules/dblog/dblog.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/dblog','','','user_access','a:1:{i:0;s:19:\"access site reports\";}','dblog_overview','a:0:{}','',7,3,0,'','admin/reports/dblog','Recent log messages','t','','','a:0:{}',6,'View events that have recently been logged.','',-1,'modules/dblog/dblog.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/event/%','a:1:{i:3;N;}','','user_access','a:1:{i:0;s:19:\"access site reports\";}','dblog_event','a:1:{i:0;i:3;}','',14,4,0,'','admin/reports/event/%','Details','t','','','a:0:{}',6,'','',0,'modules/dblog/dblog.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/fields','','','user_access','a:1:{i:0;s:24:\"administer content types\";}','field_ui_fields_list','a:0:{}','',7,3,0,'','admin/reports/fields','Field list','t','','','a:0:{}',6,'Overview of fields on all entity types.','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/page-not-found','','','user_access','a:1:{i:0;s:19:\"access site reports\";}','dblog_top','a:1:{i:0;s:14:\"page not found\";}','',7,3,0,'','admin/reports/page-not-found','Top \'page not found\' errors','t','','','a:0:{}',6,'View \'page not found\' errors (404s).','',0,'modules/dblog/dblog.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/search','','','user_access','a:1:{i:0;s:19:\"access site reports\";}','dblog_top','a:1:{i:0;s:6:\"search\";}','',7,3,0,'','admin/reports/search','Top search phrases','t','','','a:0:{}',6,'View most popular search phrases.','',0,'modules/dblog/dblog.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/status','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','system_status','a:0:{}','',7,3,0,'','admin/reports/status','Status report','t','','','a:0:{}',6,'Get a status report about your site\'s operation and any detected problems.','',-60,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/status/php','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','system_php','a:0:{}','',15,4,0,'','admin/reports/status/php','PHP','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/status/rebuild','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','drupal_get_form','a:1:{i:0;s:30:\"node_configure_rebuild_confirm\";}','',15,4,0,'','admin/reports/status/rebuild','Rebuild permissions','t','','','a:0:{}',0,'','',0,'modules/node/node.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/status/run-cron','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','system_run_cron','a:0:{}','',15,4,0,'','admin/reports/status/run-cron','Run cron','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/updates','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','update_status','a:0:{}','',7,3,0,'','admin/reports/updates','Available updates','t','','','a:0:{}',6,'Get a status report about available updates for your installed modules and themes.','',-50,'modules/update/update.report.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/updates/check','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','update_manual_status','a:0:{}','',15,4,0,'','admin/reports/updates/check','Manual update check','t','','','a:0:{}',0,'','',0,'modules/update/update.fetch.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/updates/install','','','update_manager_access','a:0:{}','drupal_get_form','a:2:{i:0;s:27:\"update_manager_install_form\";i:1;s:6:\"report\";}','',15,4,1,'admin/reports/updates','admin/reports/updates','Install new module or theme','t','','','a:0:{}',388,'','',25,'modules/update/update.manager.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/updates/list','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','update_status','a:0:{}','',15,4,1,'admin/reports/updates','admin/reports/updates','List','t','','','a:0:{}',140,'','',0,'modules/update/update.report.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/updates/settings','','','user_access','a:1:{i:0;s:29:\"administer site configuration\";}','drupal_get_form','a:1:{i:0;s:15:\"update_settings\";}','',15,4,1,'admin/reports/updates','admin/reports/updates','Settings','t','','','a:0:{}',132,'','',50,'modules/update/update.settings.inc');
INSERT INTO `menu_router` VALUES ('admin/reports/updates/update','','','update_manager_access','a:0:{}','drupal_get_form','a:2:{i:0;s:26:\"update_manager_update_form\";i:1;s:6:\"report\";}','',15,4,1,'admin/reports/updates','admin/reports/updates','Update','t','','','a:0:{}',132,'','',10,'modules/update/update.manager.inc');
INSERT INTO `menu_router` VALUES ('admin/structure','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',3,2,0,'','admin/structure','Structure','t','','','a:0:{}',6,'Administer blocks, content types, menus, etc.','right',-8,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','block_admin_display','a:1:{i:0;s:6:\"bartik\";}','',7,3,0,'','admin/structure/block','Blocks','t','','','a:0:{}',6,'Configure what block content appears in your site\'s sidebars and other regions.','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/add','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','drupal_get_form','a:1:{i:0;s:20:\"block_add_block_form\";}','',15,4,1,'admin/structure/block','admin/structure/block','Add block','t','','','a:0:{}',388,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/demo/bartik','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:25:\"themes/bartik/bartik.info\";s:4:\"name\";s:6:\"bartik\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:6:\"Bartik\";s:11:\"description\";s:48:\"A flexible, recolorable theme with many regions.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:7:\"regions\";a:20:{s:6:\"header\";s:6:\"Header\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:11:\"highlighted\";s:11:\"Highlighted\";s:8:\"featured\";s:8:\"Featured\";s:7:\"content\";s:7:\"Content\";s:13:\"sidebar_first\";s:13:\"Sidebar first\";s:14:\"sidebar_second\";s:14:\"Sidebar second\";s:14:\"triptych_first\";s:14:\"Triptych first\";s:15:\"triptych_middle\";s:15:\"Triptych middle\";s:13:\"triptych_last\";s:13:\"Triptych last\";s:18:\"footer_firstcolumn\";s:19:\"Footer first column\";s:19:\"footer_secondcolumn\";s:20:\"Footer second column\";s:18:\"footer_thirdcolumn\";s:19:\"Footer third column\";s:19:\"footer_fourthcolumn\";s:20:\"Footer fourth column\";s:6:\"footer\";s:6:\"Footer\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"0\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:28:\"themes/bartik/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_demo','a:1:{i:0;s:6:\"bartik\";}','',31,5,0,'','admin/structure/block/demo/bartik','Bartik','t','','_block_custom_theme','a:1:{i:0;s:6:\"bartik\";}',0,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/demo/garland','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:27:\"themes/garland/garland.info\";s:4:\"name\";s:7:\"garland\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:7:\"Garland\";s:11:\"description\";s:111:\"A multi-column theme which can be configured to modify colors and switch between fixed and fluid width layouts.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:8:\"settings\";a:1:{s:13:\"garland_width\";s:5:\"fluid\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:29:\"themes/garland/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_demo','a:1:{i:0;s:7:\"garland\";}','',31,5,0,'','admin/structure/block/demo/garland','Garland','t','','_block_custom_theme','a:1:{i:0;s:7:\"garland\";}',0,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/demo/seven','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:23:\"themes/seven/seven.info\";s:4:\"name\";s:5:\"seven\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:5:\"Seven\";s:11:\"description\";s:65:\"A simple one-column, tableless, fluid width administration theme.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"1\";}s:7:\"regions\";a:8:{s:7:\"content\";s:7:\"Content\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:13:\"sidebar_first\";s:13:\"First sidebar\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:14:\"regions_hidden\";a:3:{i:0;s:13:\"sidebar_first\";i:1;s:8:\"page_top\";i:2;s:11:\"page_bottom\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/seven/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_demo','a:1:{i:0;s:5:\"seven\";}','',31,5,0,'','admin/structure/block/demo/seven','Seven','t','','_block_custom_theme','a:1:{i:0;s:5:\"seven\";}',0,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/demo/stark','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:23:\"themes/stark/stark.info\";s:4:\"name\";s:5:\"stark\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:17:{s:4:\"name\";s:5:\"Stark\";s:11:\"description\";s:208:\"This theme demonstrates Drupal\'s default HTML markup and CSS styles. To learn how to build your own theme and override Drupal\'s default code, see the <a href=\"http://drupal.org/theme-guide\">Theming Guide</a>.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/stark/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_demo','a:1:{i:0;s:5:\"stark\";}','',31,5,0,'','admin/structure/block/demo/stark','Stark','t','','_block_custom_theme','a:1:{i:0;s:5:\"stark\";}',0,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/bartik','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:25:\"themes/bartik/bartik.info\";s:4:\"name\";s:6:\"bartik\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:6:\"Bartik\";s:11:\"description\";s:48:\"A flexible, recolorable theme with many regions.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:7:\"regions\";a:20:{s:6:\"header\";s:6:\"Header\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:11:\"highlighted\";s:11:\"Highlighted\";s:8:\"featured\";s:8:\"Featured\";s:7:\"content\";s:7:\"Content\";s:13:\"sidebar_first\";s:13:\"Sidebar first\";s:14:\"sidebar_second\";s:14:\"Sidebar second\";s:14:\"triptych_first\";s:14:\"Triptych first\";s:15:\"triptych_middle\";s:15:\"Triptych middle\";s:13:\"triptych_last\";s:13:\"Triptych last\";s:18:\"footer_firstcolumn\";s:19:\"Footer first column\";s:19:\"footer_secondcolumn\";s:20:\"Footer second column\";s:18:\"footer_thirdcolumn\";s:19:\"Footer third column\";s:19:\"footer_fourthcolumn\";s:20:\"Footer fourth column\";s:6:\"footer\";s:6:\"Footer\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"0\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:28:\"themes/bartik/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_display','a:1:{i:0;s:6:\"bartik\";}','',31,5,1,'admin/structure/block','admin/structure/block','Bartik','t','','','a:0:{}',140,'','',-10,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/garland','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:27:\"themes/garland/garland.info\";s:4:\"name\";s:7:\"garland\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:7:\"Garland\";s:11:\"description\";s:111:\"A multi-column theme which can be configured to modify colors and switch between fixed and fluid width layouts.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:8:\"settings\";a:1:{s:13:\"garland_width\";s:5:\"fluid\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:29:\"themes/garland/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_display','a:1:{i:0;s:7:\"garland\";}','',31,5,1,'admin/structure/block','admin/structure/block','Garland','t','','','a:0:{}',132,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/garland/add','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','drupal_get_form','a:1:{i:0;s:20:\"block_add_block_form\";}','',63,6,1,'admin/structure/block/list/garland','admin/structure/block','Add block','t','','','a:0:{}',388,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/seven','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:23:\"themes/seven/seven.info\";s:4:\"name\";s:5:\"seven\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"1\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:18:{s:4:\"name\";s:5:\"Seven\";s:11:\"description\";s:65:\"A simple one-column, tableless, fluid width administration theme.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"1\";}s:7:\"regions\";a:8:{s:7:\"content\";s:7:\"Content\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:13:\"sidebar_first\";s:13:\"First sidebar\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:14:\"regions_hidden\";a:3:{i:0;s:13:\"sidebar_first\";i:1;s:8:\"page_top\";i:2;s:11:\"page_bottom\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/seven/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_display','a:1:{i:0;s:5:\"seven\";}','',31,5,1,'admin/structure/block','admin/structure/block','Seven','t','','','a:0:{}',132,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/seven/add','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','drupal_get_form','a:1:{i:0;s:20:\"block_add_block_form\";}','',63,6,1,'admin/structure/block/list/seven','admin/structure/block','Add block','t','','','a:0:{}',388,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/stark','','','_block_themes_access','a:1:{i:0;O:8:\"stdClass\":12:{s:8:\"filename\";s:23:\"themes/stark/stark.info\";s:4:\"name\";s:5:\"stark\";s:4:\"type\";s:5:\"theme\";s:5:\"owner\";s:45:\"themes/engines/phptemplate/phptemplate.engine\";s:6:\"status\";s:1:\"0\";s:9:\"bootstrap\";s:1:\"0\";s:14:\"schema_version\";s:2:\"-1\";s:6:\"weight\";s:1:\"0\";s:4:\"info\";a:17:{s:4:\"name\";s:5:\"Stark\";s:11:\"description\";s:208:\"This theme demonstrates Drupal\'s default HTML markup and CSS styles. To learn how to build your own theme and override Drupal\'s default code, see the <a href=\"http://drupal.org/theme-guide\">Theming Guide</a>.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/stark/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}s:6:\"prefix\";s:11:\"phptemplate\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:6:\"engine\";s:11:\"phptemplate\";}}','block_admin_display','a:1:{i:0;s:5:\"stark\";}','',31,5,1,'admin/structure/block','admin/structure/block','Stark','t','','','a:0:{}',132,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/list/stark/add','','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','drupal_get_form','a:1:{i:0;s:20:\"block_add_block_form\";}','',63,6,1,'admin/structure/block/list/stark','admin/structure/block','Add block','t','','','a:0:{}',388,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/manage/%/%','a:2:{i:4;N;i:5;N;}','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','drupal_get_form','a:3:{i:0;s:21:\"block_admin_configure\";i:1;i:4;i:2;i:5;}','',60,6,0,'','admin/structure/block/manage/%/%','Configure block','t','','','a:0:{}',6,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/manage/%/%/configure','a:2:{i:4;N;i:5;N;}','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','drupal_get_form','a:3:{i:0;s:21:\"block_admin_configure\";i:1;i:4;i:2;i:5;}','',121,7,2,'admin/structure/block/manage/%/%','admin/structure/block/manage/%/%','Configure block','t','','','a:0:{}',140,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/block/manage/%/%/delete','a:2:{i:4;N;i:5;N;}','','user_access','a:1:{i:0;s:17:\"administer blocks\";}','drupal_get_form','a:3:{i:0;s:25:\"block_custom_block_delete\";i:1;i:4;i:2;i:5;}','',121,7,0,'admin/structure/block/manage/%/%','admin/structure/block/manage/%/%','Delete block','t','','','a:0:{}',132,'','',0,'modules/block/block.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu','','','user_access','a:1:{i:0;s:15:\"administer menu\";}','menu_overview_page','a:0:{}','',7,3,0,'','admin/structure/menu','Menus','t','','','a:0:{}',6,'Add new menus to your site, edit existing menus, and rename and reorganize menu links.','',0,'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/add','','','user_access','a:1:{i:0;s:15:\"administer menu\";}','drupal_get_form','a:2:{i:0;s:14:\"menu_edit_menu\";i:1;s:3:\"add\";}','',15,4,1,'admin/structure/menu','admin/structure/menu','Add menu','t','','','a:0:{}',388,'','',0,'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/item/%/delete','a:1:{i:4;s:14:\"menu_link_load\";}','','user_access','a:1:{i:0;s:15:\"administer menu\";}','menu_item_delete_page','a:1:{i:0;i:4;}','',61,6,0,'','admin/structure/menu/item/%/delete','Delete menu link','t','','','a:0:{}',6,'','',0,'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/item/%/edit','a:1:{i:4;s:14:\"menu_link_load\";}','','user_access','a:1:{i:0;s:15:\"administer menu\";}','drupal_get_form','a:4:{i:0;s:14:\"menu_edit_item\";i:1;s:4:\"edit\";i:2;i:4;i:3;N;}','',61,6,0,'','admin/structure/menu/item/%/edit','Edit menu link','t','','','a:0:{}',6,'','',0,'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/item/%/reset','a:1:{i:4;s:14:\"menu_link_load\";}','','user_access','a:1:{i:0;s:15:\"administer menu\";}','drupal_get_form','a:2:{i:0;s:23:\"menu_reset_item_confirm\";i:1;i:4;}','',61,6,0,'','admin/structure/menu/item/%/reset','Reset menu link','t','','','a:0:{}',6,'','',0,'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/list','','','user_access','a:1:{i:0;s:15:\"administer menu\";}','menu_overview_page','a:0:{}','',15,4,1,'admin/structure/menu','admin/structure/menu','List menus','t','','','a:0:{}',140,'','',-10,'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/manage/%','a:1:{i:4;s:9:\"menu_load\";}','','user_access','a:1:{i:0;s:15:\"administer menu\";}','drupal_get_form','a:2:{i:0;s:18:\"menu_overview_form\";i:1;i:4;}','',30,5,0,'','admin/structure/menu/manage/%','Customize menu','menu_overview_title','a:1:{i:0;i:4;}','','a:0:{}',6,'','',0,'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/manage/%/add','a:1:{i:4;s:9:\"menu_load\";}','','user_access','a:1:{i:0;s:15:\"administer menu\";}','drupal_get_form','a:4:{i:0;s:14:\"menu_edit_item\";i:1;s:3:\"add\";i:2;N;i:3;i:4;}','',61,6,1,'admin/structure/menu/manage/%','admin/structure/menu/manage/%','Add link','t','','','a:0:{}',388,'','',0,'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/manage/%/delete','a:1:{i:4;s:9:\"menu_load\";}','','user_access','a:1:{i:0;s:15:\"administer menu\";}','menu_delete_menu_page','a:1:{i:0;i:4;}','',61,6,0,'','admin/structure/menu/manage/%/delete','Delete menu','t','','','a:0:{}',6,'','',0,'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/manage/%/edit','a:1:{i:4;s:9:\"menu_load\";}','','user_access','a:1:{i:0;s:15:\"administer menu\";}','drupal_get_form','a:3:{i:0;s:14:\"menu_edit_menu\";i:1;s:4:\"edit\";i:2;i:4;}','',61,6,3,'admin/structure/menu/manage/%','admin/structure/menu/manage/%','Edit menu','t','','','a:0:{}',132,'','',0,'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/manage/%/list','a:1:{i:4;s:9:\"menu_load\";}','','user_access','a:1:{i:0;s:15:\"administer menu\";}','drupal_get_form','a:2:{i:0;s:18:\"menu_overview_form\";i:1;i:4;}','',61,6,3,'admin/structure/menu/manage/%','admin/structure/menu/manage/%','List links','t','','','a:0:{}',140,'','',-10,'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/parents','','','user_access','a:1:{i:0;b:1;}','menu_parent_options_js','a:0:{}','',15,4,0,'','admin/structure/menu/parents','Parent menu items','t','','','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('admin/structure/menu/settings','','','user_access','a:1:{i:0;s:15:\"administer menu\";}','drupal_get_form','a:1:{i:0;s:14:\"menu_configure\";}','',15,4,1,'admin/structure/menu','admin/structure/menu','Settings','t','','','a:0:{}',132,'','',5,'modules/menu/menu.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy','','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:1:{i:0;s:30:\"taxonomy_overview_vocabularies\";}','',7,3,0,'','admin/structure/taxonomy','Taxonomy','t','','','a:0:{}',6,'Manage tagging, categorization, and classification of your content.','',0,'modules/taxonomy/taxonomy.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%','a:1:{i:3;s:37:\"taxonomy_vocabulary_machine_name_load\";}','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:2:{i:0;s:23:\"taxonomy_overview_terms\";i:1;i:3;}','',14,4,0,'','admin/structure/taxonomy/%','','entity_label','a:2:{i:0;s:19:\"taxonomy_vocabulary\";i:1;i:3;}','','a:0:{}',6,'','',0,'modules/taxonomy/taxonomy.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/add','a:1:{i:3;s:37:\"taxonomy_vocabulary_machine_name_load\";}','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:3:{i:0;s:18:\"taxonomy_form_term\";i:1;a:0:{}i:2;i:3;}','',29,5,1,'admin/structure/taxonomy/%','admin/structure/taxonomy/%','Add term','t','','','a:0:{}',388,'','',0,'modules/taxonomy/taxonomy.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/display','a:1:{i:3;s:37:\"taxonomy_vocabulary_machine_name_load\";}','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:13:\"taxonomy_term\";i:2;i:3;i:3;s:7:\"default\";}','',29,5,1,'admin/structure/taxonomy/%','admin/structure/taxonomy/%','Manage display','t','','','a:0:{}',132,'','',2,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/display/default','a:1:{i:3;s:37:\"taxonomy_vocabulary_machine_name_load\";}','','_field_ui_view_mode_menu_access','a:5:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:7:\"default\";i:3;s:11:\"user_access\";i:4;s:19:\"administer taxonomy\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:13:\"taxonomy_term\";i:2;i:3;i:3;s:7:\"default\";}','',59,6,1,'admin/structure/taxonomy/%/display','admin/structure/taxonomy/%','Default','t','','','a:0:{}',140,'','',-10,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/display/full','a:1:{i:3;s:37:\"taxonomy_vocabulary_machine_name_load\";}','','_field_ui_view_mode_menu_access','a:5:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:4:\"full\";i:3;s:11:\"user_access\";i:4;s:19:\"administer taxonomy\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:13:\"taxonomy_term\";i:2;i:3;i:3;s:4:\"full\";}','',59,6,1,'admin/structure/taxonomy/%/display','admin/structure/taxonomy/%','Taxonomy term page','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/edit','a:1:{i:3;s:37:\"taxonomy_vocabulary_machine_name_load\";}','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:2:{i:0;s:24:\"taxonomy_form_vocabulary\";i:1;i:3;}','',29,5,1,'admin/structure/taxonomy/%','admin/structure/taxonomy/%','Edit','t','','','a:0:{}',132,'','',-10,'modules/taxonomy/taxonomy.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/fields','a:1:{i:3;s:37:\"taxonomy_vocabulary_machine_name_load\";}','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:3:{i:0;s:28:\"field_ui_field_overview_form\";i:1;s:13:\"taxonomy_term\";i:2;i:3;}','',29,5,1,'admin/structure/taxonomy/%','admin/structure/taxonomy/%','Manage fields','t','','','a:0:{}',132,'','',1,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/fields/%','a:2:{i:3;a:1:{s:37:\"taxonomy_vocabulary_machine_name_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:5;}','',58,6,0,'','admin/structure/taxonomy/%/fields/%','','field_ui_menu_title','a:1:{i:0;i:5;}','','a:0:{}',6,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/fields/%/delete','a:2:{i:3;a:1:{s:37:\"taxonomy_vocabulary_machine_name_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:2:{i:0;s:26:\"field_ui_field_delete_form\";i:1;i:5;}','',117,7,1,'admin/structure/taxonomy/%/fields/%','admin/structure/taxonomy/%/fields/%','Delete','t','','','a:0:{}',132,'','',10,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/fields/%/edit','a:2:{i:3;a:1:{s:37:\"taxonomy_vocabulary_machine_name_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:5;}','',117,7,1,'admin/structure/taxonomy/%/fields/%','admin/structure/taxonomy/%/fields/%','Edit','t','','','a:0:{}',140,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/fields/%/field-settings','a:2:{i:3;a:1:{s:37:\"taxonomy_vocabulary_machine_name_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:2:{i:0;s:28:\"field_ui_field_settings_form\";i:1;i:5;}','',117,7,1,'admin/structure/taxonomy/%/fields/%','admin/structure/taxonomy/%/fields/%','Field settings','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/fields/%/widget-type','a:2:{i:3;a:1:{s:37:\"taxonomy_vocabulary_machine_name_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}i:5;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:13:\"taxonomy_term\";i:1;i:3;i:2;s:1:\"3\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:2:{i:0;s:25:\"field_ui_widget_type_form\";i:1;i:5;}','',117,7,1,'admin/structure/taxonomy/%/fields/%','admin/structure/taxonomy/%/fields/%','Widget type','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/%/list','a:1:{i:3;s:37:\"taxonomy_vocabulary_machine_name_load\";}','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:2:{i:0;s:23:\"taxonomy_overview_terms\";i:1;i:3;}','',29,5,1,'admin/structure/taxonomy/%','admin/structure/taxonomy/%','List','t','','','a:0:{}',140,'','',-20,'modules/taxonomy/taxonomy.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/add','','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:1:{i:0;s:24:\"taxonomy_form_vocabulary\";}','',15,4,1,'admin/structure/taxonomy','admin/structure/taxonomy','Add vocabulary','t','','','a:0:{}',388,'','',0,'modules/taxonomy/taxonomy.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/taxonomy/list','','','user_access','a:1:{i:0;s:19:\"administer taxonomy\";}','drupal_get_form','a:1:{i:0;s:30:\"taxonomy_overview_vocabularies\";}','',15,4,1,'admin/structure/taxonomy','admin/structure/taxonomy','List','t','','','a:0:{}',140,'','',-10,'modules/taxonomy/taxonomy.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types','','','user_access','a:1:{i:0;s:24:\"administer content types\";}','node_overview_types','a:0:{}','',7,3,0,'','admin/structure/types','Content types','t','','','a:0:{}',6,'Manage content types, including default status, front page promotion, comment settings, etc.','',0,'modules/node/content_types.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/add','','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:1:{i:0;s:14:\"node_type_form\";}','',15,4,1,'admin/structure/types','admin/structure/types','Add content type','t','','','a:0:{}',388,'','',0,'modules/node/content_types.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/list','','','user_access','a:1:{i:0;s:24:\"administer content types\";}','node_overview_types','a:0:{}','',15,4,1,'admin/structure/types','admin/structure/types','List','t','','','a:0:{}',140,'','',-10,'modules/node/content_types.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%','a:1:{i:4;s:14:\"node_type_load\";}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:14:\"node_type_form\";i:1;i:4;}','',30,5,0,'','admin/structure/types/manage/%','Edit content type','node_type_page_title','a:1:{i:0;i:4;}','','a:0:{}',6,'','',0,'modules/node/content_types.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/display','a:1:{i:4;s:22:\"comment_node_type_load\";}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:7:\"comment\";i:2;i:4;i:3;s:7:\"default\";}','',123,7,1,'admin/structure/types/manage/%','admin/structure/types/manage/%','Comment display','t','','','a:0:{}',132,'','',4,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/display/default','a:1:{i:4;s:22:\"comment_node_type_load\";}','','_field_ui_view_mode_menu_access','a:5:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:7:\"default\";i:3;s:11:\"user_access\";i:4;s:24:\"administer content types\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:7:\"comment\";i:2;i:4;i:3;s:7:\"default\";}','',247,8,1,'admin/structure/types/manage/%/comment/display','admin/structure/types/manage/%','Default','t','','','a:0:{}',140,'','',-10,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/display/full','a:1:{i:4;s:22:\"comment_node_type_load\";}','','_field_ui_view_mode_menu_access','a:5:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:4:\"full\";i:3;s:11:\"user_access\";i:4;s:24:\"administer content types\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:7:\"comment\";i:2;i:4;i:3;s:4:\"full\";}','',247,8,1,'admin/structure/types/manage/%/comment/display','admin/structure/types/manage/%','Full comment','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/fields','a:1:{i:4;s:22:\"comment_node_type_load\";}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:3:{i:0;s:28:\"field_ui_field_overview_form\";i:1;s:7:\"comment\";i:2;i:4;}','',123,7,1,'admin/structure/types/manage/%','admin/structure/types/manage/%','Comment fields','t','','','a:0:{}',132,'','',3,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/fields/%','a:2:{i:4;a:1:{s:22:\"comment_node_type_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:7;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:7;}','',246,8,0,'','admin/structure/types/manage/%/comment/fields/%','','field_ui_menu_title','a:1:{i:0;i:7;}','','a:0:{}',6,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/fields/%/delete','a:2:{i:4;a:1:{s:22:\"comment_node_type_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:7;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:26:\"field_ui_field_delete_form\";i:1;i:7;}','',493,9,1,'admin/structure/types/manage/%/comment/fields/%','admin/structure/types/manage/%/comment/fields/%','Delete','t','','','a:0:{}',132,'','',10,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/fields/%/edit','a:2:{i:4;a:1:{s:22:\"comment_node_type_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:7;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:7;}','',493,9,1,'admin/structure/types/manage/%/comment/fields/%','admin/structure/types/manage/%/comment/fields/%','Edit','t','','','a:0:{}',140,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/fields/%/field-settings','a:2:{i:4;a:1:{s:22:\"comment_node_type_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:7;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:28:\"field_ui_field_settings_form\";i:1;i:7;}','',493,9,1,'admin/structure/types/manage/%/comment/fields/%','admin/structure/types/manage/%/comment/fields/%','Field settings','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/comment/fields/%/widget-type','a:2:{i:4;a:1:{s:22:\"comment_node_type_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:7;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:7:\"comment\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:25:\"field_ui_widget_type_form\";i:1;i:7;}','',493,9,1,'admin/structure/types/manage/%/comment/fields/%','admin/structure/types/manage/%/comment/fields/%','Widget type','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/delete','a:1:{i:4;s:14:\"node_type_load\";}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:24:\"node_type_delete_confirm\";i:1;i:4;}','',61,6,0,'','admin/structure/types/manage/%/delete','Delete','t','','','a:0:{}',6,'','',0,'modules/node/content_types.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/display','a:1:{i:4;s:14:\"node_type_load\";}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:7:\"default\";}','',61,6,1,'admin/structure/types/manage/%','admin/structure/types/manage/%','Manage display','t','','','a:0:{}',132,'','',2,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/display/default','a:1:{i:4;s:14:\"node_type_load\";}','','_field_ui_view_mode_menu_access','a:5:{i:0;s:4:\"node\";i:1;i:4;i:2;s:7:\"default\";i:3;s:11:\"user_access\";i:4;s:24:\"administer content types\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:7:\"default\";}','',123,7,1,'admin/structure/types/manage/%/display','admin/structure/types/manage/%','Default','t','','','a:0:{}',140,'','',-10,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/display/full','a:1:{i:4;s:14:\"node_type_load\";}','','_field_ui_view_mode_menu_access','a:5:{i:0;s:4:\"node\";i:1;i:4;i:2;s:4:\"full\";i:3;s:11:\"user_access\";i:4;s:24:\"administer content types\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:4:\"full\";}','',123,7,1,'admin/structure/types/manage/%/display','admin/structure/types/manage/%','Full content','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/display/rss','a:1:{i:4;s:14:\"node_type_load\";}','','_field_ui_view_mode_menu_access','a:5:{i:0;s:4:\"node\";i:1;i:4;i:2;s:3:\"rss\";i:3;s:11:\"user_access\";i:4;s:24:\"administer content types\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:3:\"rss\";}','',123,7,1,'admin/structure/types/manage/%/display','admin/structure/types/manage/%','RSS','t','','','a:0:{}',132,'','',2,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/display/search_index','a:1:{i:4;s:14:\"node_type_load\";}','','_field_ui_view_mode_menu_access','a:5:{i:0;s:4:\"node\";i:1;i:4;i:2;s:12:\"search_index\";i:3;s:11:\"user_access\";i:4;s:24:\"administer content types\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:12:\"search_index\";}','',123,7,1,'admin/structure/types/manage/%/display','admin/structure/types/manage/%','Search index','t','','','a:0:{}',132,'','',3,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/display/search_result','a:1:{i:4;s:14:\"node_type_load\";}','','_field_ui_view_mode_menu_access','a:5:{i:0;s:4:\"node\";i:1;i:4;i:2;s:13:\"search_result\";i:3;s:11:\"user_access\";i:4;s:24:\"administer content types\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:13:\"search_result\";}','',123,7,1,'admin/structure/types/manage/%/display','admin/structure/types/manage/%','Search result','t','','','a:0:{}',132,'','',4,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/display/teaser','a:1:{i:4;s:14:\"node_type_load\";}','','_field_ui_view_mode_menu_access','a:5:{i:0;s:4:\"node\";i:1;i:4;i:2;s:6:\"teaser\";i:3;s:11:\"user_access\";i:4;s:24:\"administer content types\";}','drupal_get_form','a:4:{i:0;s:30:\"field_ui_display_overview_form\";i:1;s:4:\"node\";i:2;i:4;i:3;s:6:\"teaser\";}','',123,7,1,'admin/structure/types/manage/%/display','admin/structure/types/manage/%','Teaser','t','','','a:0:{}',132,'','',1,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/edit','a:1:{i:4;s:14:\"node_type_load\";}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:14:\"node_type_form\";i:1;i:4;}','',61,6,1,'admin/structure/types/manage/%','admin/structure/types/manage/%','Edit','t','','','a:0:{}',140,'','',0,'modules/node/content_types.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/fields','a:1:{i:4;s:14:\"node_type_load\";}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:3:{i:0;s:28:\"field_ui_field_overview_form\";i:1;s:4:\"node\";i:2;i:4;}','',61,6,1,'admin/structure/types/manage/%','admin/structure/types/manage/%','Manage fields','t','','','a:0:{}',132,'','',1,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/fields/%','a:2:{i:4;a:1:{s:14:\"node_type_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:6;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:6;}','',122,7,0,'','admin/structure/types/manage/%/fields/%','','field_ui_menu_title','a:1:{i:0;i:6;}','','a:0:{}',6,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/fields/%/delete','a:2:{i:4;a:1:{s:14:\"node_type_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:6;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:26:\"field_ui_field_delete_form\";i:1;i:6;}','',245,8,1,'admin/structure/types/manage/%/fields/%','admin/structure/types/manage/%/fields/%','Delete','t','','','a:0:{}',132,'','',10,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/fields/%/edit','a:2:{i:4;a:1:{s:14:\"node_type_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:6;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:24:\"field_ui_field_edit_form\";i:1;i:6;}','',245,8,1,'admin/structure/types/manage/%/fields/%','admin/structure/types/manage/%/fields/%','Edit','t','','','a:0:{}',140,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/fields/%/field-settings','a:2:{i:4;a:1:{s:14:\"node_type_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:6;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:28:\"field_ui_field_settings_form\";i:1;i:6;}','',245,8,1,'admin/structure/types/manage/%/fields/%','admin/structure/types/manage/%/fields/%','Field settings','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/structure/types/manage/%/fields/%/widget-type','a:2:{i:4;a:1:{s:14:\"node_type_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}i:6;a:1:{s:18:\"field_ui_menu_load\";a:4:{i:0;s:4:\"node\";i:1;i:4;i:2;s:1:\"4\";i:3;s:4:\"%map\";}}}','','user_access','a:1:{i:0;s:24:\"administer content types\";}','drupal_get_form','a:2:{i:0;s:25:\"field_ui_widget_type_form\";i:1;i:6;}','',245,8,1,'admin/structure/types/manage/%/fields/%','admin/structure/types/manage/%/fields/%','Widget type','t','','','a:0:{}',132,'','',0,'modules/field_ui/field_ui.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/tasks','','','user_access','a:1:{i:0;s:27:\"access administration pages\";}','system_admin_menu_block_page','a:0:{}','',3,2,1,'admin','admin','Tasks','t','','','a:0:{}',140,'','',-20,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('admin/update/ready','','','update_manager_access','a:0:{}','drupal_get_form','a:1:{i:0;s:32:\"update_manager_update_ready_form\";}','',7,3,0,'','admin/update/ready','Ready to update','t','','','a:0:{}',0,'','',0,'modules/update/update.manager.inc');
INSERT INTO `menu_router` VALUES ('batch','','','1','a:0:{}','system_batch_page','a:0:{}','',1,1,0,'','batch','','t','','_system_batch_theme','a:0:{}',0,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('comment/%','a:1:{i:1;N;}','','user_access','a:1:{i:0;s:15:\"access comments\";}','comment_permalink','a:1:{i:0;i:1;}','',2,2,0,'','comment/%','Comment permalink','t','','','a:0:{}',6,'','',0,'');
INSERT INTO `menu_router` VALUES ('comment/%/approve','a:1:{i:1;N;}','','user_access','a:1:{i:0;s:19:\"administer comments\";}','comment_approve','a:1:{i:0;i:1;}','',5,3,0,'','comment/%/approve','Approve','t','','','a:0:{}',6,'','',1,'modules/comment/comment.pages.inc');
INSERT INTO `menu_router` VALUES ('comment/%/delete','a:1:{i:1;N;}','','user_access','a:1:{i:0;s:19:\"administer comments\";}','comment_confirm_delete_page','a:1:{i:0;i:1;}','',5,3,1,'comment/%','comment/%','Delete','t','','','a:0:{}',132,'','',2,'modules/comment/comment.admin.inc');
INSERT INTO `menu_router` VALUES ('comment/%/edit','a:1:{i:1;s:12:\"comment_load\";}','','comment_access','a:2:{i:0;s:4:\"edit\";i:1;i:1;}','comment_edit_page','a:1:{i:0;i:1;}','',5,3,1,'comment/%','comment/%','Edit','t','','','a:0:{}',132,'','',0,'');
INSERT INTO `menu_router` VALUES ('comment/%/view','a:1:{i:1;N;}','','user_access','a:1:{i:0;s:15:\"access comments\";}','comment_permalink','a:1:{i:0;i:1;}','',5,3,1,'comment/%','comment/%','View comment','t','','','a:0:{}',140,'','',-10,'');
INSERT INTO `menu_router` VALUES ('comment/reply/%','a:1:{i:2;s:9:\"node_load\";}','','node_access','a:2:{i:0;s:4:\"view\";i:1;i:2;}','comment_reply','a:1:{i:0;i:2;}','',6,3,0,'','comment/reply/%','Add new comment','t','','','a:0:{}',6,'','',0,'modules/comment/comment.pages.inc');
INSERT INTO `menu_router` VALUES ('file/ajax','','','user_access','a:1:{i:0;s:14:\"access content\";}','file_ajax_upload','a:0:{}','ajax_deliver',3,2,0,'','file/ajax','','t','','ajax_base_page_theme','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('file/progress','','','user_access','a:1:{i:0;s:14:\"access content\";}','file_ajax_progress','a:0:{}','',3,2,0,'','file/progress','','t','','ajax_base_page_theme','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('filter/tips','','','1','a:0:{}','filter_tips_long','a:0:{}','',3,2,0,'','filter/tips','Compose tips','t','','','a:0:{}',20,'','',0,'modules/filter/filter.pages.inc');
INSERT INTO `menu_router` VALUES ('node','','','user_access','a:1:{i:0;s:14:\"access content\";}','node_page_default','a:0:{}','',1,1,0,'','node','','t','','','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('node/%','a:1:{i:1;s:9:\"node_load\";}','','node_access','a:2:{i:0;s:4:\"view\";i:1;i:1;}','node_page_view','a:1:{i:0;i:1;}','',2,2,0,'','node/%','','node_page_title','a:1:{i:0;i:1;}','','a:0:{}',6,'','',0,'');
INSERT INTO `menu_router` VALUES ('node/%/delete','a:1:{i:1;s:9:\"node_load\";}','','node_access','a:2:{i:0;s:6:\"delete\";i:1;i:1;}','drupal_get_form','a:2:{i:0;s:19:\"node_delete_confirm\";i:1;i:1;}','',5,3,2,'node/%','node/%','Delete','t','','','a:0:{}',132,'','',1,'modules/node/node.pages.inc');
INSERT INTO `menu_router` VALUES ('node/%/edit','a:1:{i:1;s:9:\"node_load\";}','','node_access','a:2:{i:0;s:6:\"update\";i:1;i:1;}','node_page_edit','a:1:{i:0;i:1;}','',5,3,3,'node/%','node/%','Edit','t','','','a:0:{}',132,'','',0,'modules/node/node.pages.inc');
INSERT INTO `menu_router` VALUES ('node/%/revisions','a:1:{i:1;s:9:\"node_load\";}','','_node_revision_access','a:1:{i:0;i:1;}','node_revision_overview','a:1:{i:0;i:1;}','',5,3,1,'node/%','node/%','Revisions','t','','','a:0:{}',132,'','',2,'modules/node/node.pages.inc');
INSERT INTO `menu_router` VALUES ('node/%/revisions/%/delete','a:2:{i:1;a:1:{s:9:\"node_load\";a:1:{i:0;i:3;}}i:3;N;}','','_node_revision_access','a:2:{i:0;i:1;i:1;s:6:\"delete\";}','drupal_get_form','a:2:{i:0;s:28:\"node_revision_delete_confirm\";i:1;i:1;}','',21,5,0,'','node/%/revisions/%/delete','Delete earlier revision','t','','','a:0:{}',6,'','',0,'modules/node/node.pages.inc');
INSERT INTO `menu_router` VALUES ('node/%/revisions/%/revert','a:2:{i:1;a:1:{s:9:\"node_load\";a:1:{i:0;i:3;}}i:3;N;}','','_node_revision_access','a:2:{i:0;i:1;i:1;s:6:\"update\";}','drupal_get_form','a:2:{i:0;s:28:\"node_revision_revert_confirm\";i:1;i:1;}','',21,5,0,'','node/%/revisions/%/revert','Revert to earlier revision','t','','','a:0:{}',6,'','',0,'modules/node/node.pages.inc');
INSERT INTO `menu_router` VALUES ('node/%/revisions/%/view','a:2:{i:1;a:1:{s:9:\"node_load\";a:1:{i:0;i:3;}}i:3;N;}','','_node_revision_access','a:1:{i:0;i:1;}','node_show','a:2:{i:0;i:1;i:1;b:1;}','',21,5,0,'','node/%/revisions/%/view','Revisions','t','','','a:0:{}',6,'','',0,'');
INSERT INTO `menu_router` VALUES ('node/%/view','a:1:{i:1;s:9:\"node_load\";}','','node_access','a:2:{i:0;s:4:\"view\";i:1;i:1;}','node_page_view','a:1:{i:0;i:1;}','',5,3,1,'node/%','node/%','View','t','','','a:0:{}',140,'','',-10,'');
INSERT INTO `menu_router` VALUES ('node/add','','','_node_add_access','a:0:{}','node_add_page','a:0:{}','',3,2,0,'','node/add','Add content','t','','','a:0:{}',6,'','',0,'modules/node/node.pages.inc');
INSERT INTO `menu_router` VALUES ('node/add/article','','','node_access','a:2:{i:0;s:6:\"create\";i:1;s:7:\"article\";}','node_add','a:1:{i:0;s:7:\"article\";}','',7,3,0,'','node/add/article','Article','check_plain','','','a:0:{}',6,'Use <em>articles</em> for time-sensitive content like news, press releases or blog posts.','',0,'modules/node/node.pages.inc');
INSERT INTO `menu_router` VALUES ('node/add/page','','','node_access','a:2:{i:0;s:6:\"create\";i:1;s:4:\"page\";}','node_add','a:1:{i:0;s:4:\"page\";}','',7,3,0,'','node/add/page','Basic page','check_plain','','','a:0:{}',6,'Use <em>basic pages</em> for your static content, such as an \'About us\' page.','',0,'modules/node/node.pages.inc');
INSERT INTO `menu_router` VALUES ('overlay-ajax/%','a:1:{i:1;N;}','','user_access','a:1:{i:0;s:14:\"access overlay\";}','overlay_ajax_render_region','a:1:{i:0;i:1;}','',2,2,0,'','overlay-ajax/%','','t','','','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('overlay/dismiss-message','','','user_access','a:1:{i:0;s:14:\"access overlay\";}','overlay_user_dismiss_message','a:0:{}','',3,2,0,'','overlay/dismiss-message','','t','','','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('rss.xml','','','user_access','a:1:{i:0;s:14:\"access content\";}','node_feed','a:2:{i:0;b:0;i:1;a:0:{}}','',1,1,0,'','rss.xml','RSS feed','t','','','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('search','','','search_is_active','a:0:{}','search_view','a:0:{}','',1,1,0,'','search','Search','t','','','a:0:{}',20,'','',0,'modules/search/search.pages.inc');
INSERT INTO `menu_router` VALUES ('search/node','','','_search_menu_access','a:1:{i:0;s:4:\"node\";}','search_view','a:2:{i:0;s:4:\"node\";i:1;s:0:\"\";}','',3,2,1,'search','search','Content','t','','','a:0:{}',132,'','',-10,'modules/search/search.pages.inc');
INSERT INTO `menu_router` VALUES ('search/node/%','a:1:{i:2;a:1:{s:14:\"menu_tail_load\";a:2:{i:0;s:4:\"%map\";i:1;s:6:\"%index\";}}}','a:1:{i:2;s:16:\"menu_tail_to_arg\";}','_search_menu_access','a:1:{i:0;s:4:\"node\";}','search_view','a:2:{i:0;s:4:\"node\";i:1;i:2;}','',6,3,1,'search/node','search/node/%','Content','t','','','a:0:{}',132,'','',0,'modules/search/search.pages.inc');
INSERT INTO `menu_router` VALUES ('search/user','','','_search_menu_access','a:1:{i:0;s:4:\"user\";}','search_view','a:2:{i:0;s:4:\"user\";i:1;s:0:\"\";}','',3,2,1,'search','search','Users','t','','','a:0:{}',132,'','',0,'modules/search/search.pages.inc');
INSERT INTO `menu_router` VALUES ('search/user/%','a:1:{i:2;a:1:{s:14:\"menu_tail_load\";a:2:{i:0;s:4:\"%map\";i:1;s:6:\"%index\";}}}','a:1:{i:2;s:16:\"menu_tail_to_arg\";}','_search_menu_access','a:1:{i:0;s:4:\"user\";}','search_view','a:2:{i:0;s:4:\"user\";i:1;i:2;}','',6,3,1,'search/node','search/node/%','Users','t','','','a:0:{}',132,'','',0,'modules/search/search.pages.inc');
INSERT INTO `menu_router` VALUES ('sites/default/files/styles/%','a:1:{i:4;s:16:\"image_style_load\";}','','1','a:0:{}','image_style_deliver','a:1:{i:0;i:4;}','',30,5,0,'','sites/default/files/styles/%','Generate image style','t','','','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('system/ajax','','','1','a:0:{}','ajax_form_callback','a:0:{}','ajax_deliver',3,2,0,'','system/ajax','AHAH callback','t','','ajax_base_page_theme','a:0:{}',0,'','',0,'includes/form.inc');
INSERT INTO `menu_router` VALUES ('system/files','','','1','a:0:{}','file_download','a:1:{i:0;s:7:\"private\";}','',3,2,0,'','system/files','File download','t','','','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('system/files/styles/%','a:1:{i:3;s:16:\"image_style_load\";}','','1','a:0:{}','image_style_deliver','a:1:{i:0;i:3;}','',14,4,0,'','system/files/styles/%','Generate image style','t','','','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('system/temporary','','','1','a:0:{}','file_download','a:1:{i:0;s:9:\"temporary\";}','',3,2,0,'','system/temporary','Temporary files','t','','','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('system/timezone','','','1','a:0:{}','system_timezone','a:0:{}','',3,2,0,'','system/timezone','Time zone','t','','','a:0:{}',0,'','',0,'modules/system/system.admin.inc');
INSERT INTO `menu_router` VALUES ('taxonomy/autocomplete','','','user_access','a:1:{i:0;s:14:\"access content\";}','taxonomy_autocomplete','a:0:{}','',3,2,0,'','taxonomy/autocomplete','Autocomplete taxonomy','t','','','a:0:{}',0,'','',0,'modules/taxonomy/taxonomy.pages.inc');
INSERT INTO `menu_router` VALUES ('taxonomy/term/%','a:1:{i:2;s:18:\"taxonomy_term_load\";}','','user_access','a:1:{i:0;s:14:\"access content\";}','taxonomy_term_page','a:1:{i:0;i:2;}','',6,3,0,'','taxonomy/term/%','Taxonomy term','taxonomy_term_title','a:1:{i:0;i:2;}','','a:0:{}',6,'','',0,'modules/taxonomy/taxonomy.pages.inc');
INSERT INTO `menu_router` VALUES ('taxonomy/term/%/edit','a:1:{i:2;s:18:\"taxonomy_term_load\";}','','taxonomy_term_edit_access','a:1:{i:0;i:2;}','drupal_get_form','a:3:{i:0;s:18:\"taxonomy_form_term\";i:1;i:2;i:2;N;}','',13,4,1,'taxonomy/term/%','taxonomy/term/%','Edit','t','','','a:0:{}',132,'','',10,'modules/taxonomy/taxonomy.admin.inc');
INSERT INTO `menu_router` VALUES ('taxonomy/term/%/feed','a:1:{i:2;s:18:\"taxonomy_term_load\";}','','user_access','a:1:{i:0;s:14:\"access content\";}','taxonomy_term_feed','a:1:{i:0;i:2;}','',13,4,0,'','taxonomy/term/%/feed','Taxonomy term','taxonomy_term_title','a:1:{i:0;i:2;}','','a:0:{}',0,'','',0,'modules/taxonomy/taxonomy.pages.inc');
INSERT INTO `menu_router` VALUES ('taxonomy/term/%/view','a:1:{i:2;s:18:\"taxonomy_term_load\";}','','user_access','a:1:{i:0;s:14:\"access content\";}','taxonomy_term_page','a:1:{i:0;i:2;}','',13,4,1,'taxonomy/term/%','taxonomy/term/%','View','t','','','a:0:{}',140,'','',0,'modules/taxonomy/taxonomy.pages.inc');
INSERT INTO `menu_router` VALUES ('toolbar/toggle','','','user_access','a:1:{i:0;s:14:\"access toolbar\";}','toolbar_toggle_page','a:0:{}','',3,2,0,'','toolbar/toggle','Toggle drawer visibility','t','','','a:0:{}',0,'','',0,'');
INSERT INTO `menu_router` VALUES ('user','','','1','a:0:{}','user_page','a:0:{}','',1,1,0,'','user','User account','user_menu_title','','','a:0:{}',6,'','',-10,'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/%','a:1:{i:1;s:9:\"user_load\";}','','user_view_access','a:1:{i:0;i:1;}','user_view_page','a:1:{i:0;i:1;}','',2,2,0,'','user/%','My account','user_page_title','a:1:{i:0;i:1;}','','a:0:{}',6,'','',0,'');
INSERT INTO `menu_router` VALUES ('user/%/cancel','a:1:{i:1;s:9:\"user_load\";}','','user_cancel_access','a:1:{i:0;i:1;}','drupal_get_form','a:2:{i:0;s:24:\"user_cancel_confirm_form\";i:1;i:1;}','',5,3,0,'','user/%/cancel','Cancel account','t','','','a:0:{}',6,'','',0,'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/%/cancel/confirm/%/%','a:3:{i:1;s:9:\"user_load\";i:4;N;i:5;N;}','','user_cancel_access','a:1:{i:0;i:1;}','user_cancel_confirm','a:3:{i:0;i:1;i:1;i:4;i:2;i:5;}','',44,6,0,'','user/%/cancel/confirm/%/%','Confirm account cancellation','t','','','a:0:{}',6,'','',0,'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/%/edit','a:1:{i:1;s:9:\"user_load\";}','','user_edit_access','a:1:{i:0;i:1;}','drupal_get_form','a:2:{i:0;s:17:\"user_profile_form\";i:1;i:1;}','',5,3,1,'user/%','user/%','Edit','t','','','a:0:{}',132,'','',0,'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/%/edit/account','a:1:{i:1;a:1:{s:18:\"user_category_load\";a:2:{i:0;s:4:\"%map\";i:1;s:6:\"%index\";}}}','','user_edit_access','a:1:{i:0;i:1;}','drupal_get_form','a:2:{i:0;s:17:\"user_profile_form\";i:1;i:1;}','',11,4,1,'user/%/edit','user/%','Account','t','','','a:0:{}',140,'','',0,'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/%/shortcuts','a:1:{i:1;s:9:\"user_load\";}','','shortcut_set_switch_access','a:1:{i:0;i:1;}','drupal_get_form','a:2:{i:0;s:19:\"shortcut_set_switch\";i:1;i:1;}','',5,3,1,'user/%','user/%','Shortcuts','t','','','a:0:{}',132,'','',0,'modules/shortcut/shortcut.admin.inc');
INSERT INTO `menu_router` VALUES ('user/%/view','a:1:{i:1;s:9:\"user_load\";}','','user_view_access','a:1:{i:0;i:1;}','user_view_page','a:1:{i:0;i:1;}','',5,3,1,'user/%','user/%','View','t','','','a:0:{}',140,'','',-10,'');
INSERT INTO `menu_router` VALUES ('user/autocomplete','','','user_access','a:1:{i:0;s:20:\"access user profiles\";}','user_autocomplete','a:0:{}','',3,2,0,'','user/autocomplete','User autocomplete','t','','','a:0:{}',0,'','',0,'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/login','','','user_is_anonymous','a:0:{}','user_page','a:0:{}','',3,2,1,'user','user','Log in','t','','','a:0:{}',140,'','',0,'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/logout','','','user_is_logged_in','a:0:{}','user_logout','a:0:{}','',3,2,0,'','user/logout','Log out','t','','','a:0:{}',6,'','',10,'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/password','','','1','a:0:{}','drupal_get_form','a:1:{i:0;s:9:\"user_pass\";}','',3,2,1,'user','user','Request new password','t','','','a:0:{}',132,'','',0,'modules/user/user.pages.inc');
INSERT INTO `menu_router` VALUES ('user/register','','','user_register_access','a:0:{}','drupal_get_form','a:1:{i:0;s:18:\"user_register_form\";}','',3,2,1,'user','user','Create new account','t','','','a:0:{}',132,'','',0,'');
INSERT INTO `menu_router` VALUES ('user/reset/%/%/%','a:3:{i:2;N;i:3;N;i:4;N;}','','1','a:0:{}','drupal_get_form','a:4:{i:0;s:15:\"user_pass_reset\";i:1;i:2;i:2;i:3;i:3;i:4;}','',24,5,0,'','user/reset/%/%/%','Reset password','t','','','a:0:{}',0,'','',0,'modules/user/user.pages.inc');
/*!40000 ALTER TABLE `menu_router` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `node`
--

DROP TABLE IF EXISTS `node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node` (
  `nid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a node.',
  `vid` int(10) unsigned DEFAULT NULL COMMENT 'The current node_revision.vid version identifier.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The node_type.type of this node.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this node.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this node, always treated as non-markup plain text.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that owns this node; initially, this is the user that created it.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node is published (visible to non-administrators).',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was most recently saved.',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT 'Whether comments are allowed on this node: 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node should be displayed at the top of lists in which it appears.',
  `tnid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The translation set id for this node, which equals the node id of the source post in each set.',
  `translate` int(11) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this translation page needs to be updated.',
  PRIMARY KEY (`nid`),
  UNIQUE KEY `vid` (`vid`),
  KEY `node_changed` (`changed`),
  KEY `node_created` (`created`),
  KEY `node_frontpage` (`promote`,`status`,`sticky`,`created`),
  KEY `node_status_type` (`status`,`type`,`nid`),
  KEY `node_title_type` (`title`,`type`(4)),
  KEY `node_type` (`type`(4)),
  KEY `uid` (`uid`),
  KEY `tnid` (`tnid`),
  KEY `translate` (`translate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The base table for nodes.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `node`
--
-- ORDER BY:  `nid`

LOCK TABLES `node` WRITE;
/*!40000 ALTER TABLE `node` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `node` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `node_access`
--

DROP TABLE IF EXISTS `node_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_access` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid this record affects.',
  `gid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The grant ID a user must possess in the specified realm to gain this row’s privileges on the node.',
  `realm` varchar(255) NOT NULL DEFAULT '' COMMENT 'The realm in which the user must possess the grant ID. Each node access node can define one or more realms.',
  `grant_view` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can view this node.',
  `grant_update` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can edit this node.',
  `grant_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can delete this node.',
  PRIMARY KEY (`nid`,`gid`,`realm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Identifies which realm/grant pairs a user must possess in...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `node_access`
--
-- ORDER BY:  `nid`,`gid`,`realm`

LOCK TABLES `node_access` WRITE;
/*!40000 ALTER TABLE `node_access` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `node_access` VALUES (0,0,'all',1,0,0);
/*!40000 ALTER TABLE `node_access` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `node_comment_statistics`
--

DROP TABLE IF EXISTS `node_comment_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_comment_statistics` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid for which the statistics are compiled.',
  `cid` int(11) NOT NULL DEFAULT '0' COMMENT 'The comment.cid of the last comment.',
  `last_comment_timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp of the last comment that was posted within this node, from comment.changed.',
  `last_comment_name` varchar(60) DEFAULT NULL COMMENT 'The name of the latest author to post a comment on this node, from comment.name.',
  `last_comment_uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The user ID of the latest author to post a comment on this node, from comment.uid.',
  `comment_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The total number of comments on this node.',
  PRIMARY KEY (`nid`),
  KEY `node_comment_timestamp` (`last_comment_timestamp`),
  KEY `comment_count` (`comment_count`),
  KEY `last_comment_uid` (`last_comment_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains statistics of node and comments posts to show ...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `node_comment_statistics`
--
-- ORDER BY:  `nid`

LOCK TABLES `node_comment_statistics` WRITE;
/*!40000 ALTER TABLE `node_comment_statistics` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `node_comment_statistics` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `node_revision`
--

DROP TABLE IF EXISTS `node_revision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_revision` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node this version belongs to.',
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for this version.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that created this version.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this version.',
  `log` longtext NOT NULL COMMENT 'The log entry explaining the changes in this version.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when this version was created.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node (at the time of this revision) is published (visible to non-administrators).',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT 'Whether comments are allowed on this node (at the time of this revision): 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed at the top of lists in which it appears.',
  PRIMARY KEY (`vid`),
  KEY `nid` (`nid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about each saved version of a node.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `node_revision`
--
-- ORDER BY:  `vid`

LOCK TABLES `node_revision` WRITE;
/*!40000 ALTER TABLE `node_revision` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `node_revision` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `node_type`
--

DROP TABLE IF EXISTS `node_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_type` (
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The human-readable name of this type.',
  `base` varchar(255) NOT NULL COMMENT 'The base string used to construct callbacks corresponding to this node type.',
  `module` varchar(255) NOT NULL COMMENT 'The module defining this node type.',
  `description` mediumtext NOT NULL COMMENT 'A brief description of this type.',
  `help` mediumtext NOT NULL COMMENT 'Help information shown to the user when creating a node of this type.',
  `has_title` tinyint(3) unsigned NOT NULL COMMENT 'Boolean indicating whether this type uses the node.title field.',
  `title_label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The label displayed for the title field on the edit form.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this type is defined by a module (FALSE) or by a user via Add content type (TRUE).',
  `modified` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this type has been modified by an administrator; currently not used in any way.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether the administrator can change the machine name of this type.',
  `disabled` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether the node type is disabled.',
  `orig_type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The original machine-readable name of this node type. This may be different from the current type name if the locked field is 0.',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about all defined node types.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `node_type`
--
-- ORDER BY:  `type`

LOCK TABLES `node_type` WRITE;
/*!40000 ALTER TABLE `node_type` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `node_type` VALUES ('article','Article','node_content','node','Use <em>articles</em> for time-sensitive content like news, press releases or blog posts.','',1,'Title',1,1,0,0,'article');
INSERT INTO `node_type` VALUES ('page','Basic page','node_content','node','Use <em>basic pages</em> for your static content, such as an \'About us\' page.','',1,'Title',1,1,0,0,'page');
/*!40000 ALTER TABLE `node_type` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique item ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The queue name.',
  `data` longblob COMMENT 'The arbitrary data for the item.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the claim lease expires on the item.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the item was created.',
  PRIMARY KEY (`item_id`),
  KEY `name_created` (`name`,`created`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Stores items in queues.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queue`
--
-- ORDER BY:  `item_id`

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `rdf_mapping`
--

DROP TABLE IF EXISTS `rdf_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rdf_mapping` (
  `type` varchar(128) NOT NULL COMMENT 'The name of the entity type a mapping applies to (node, user, comment, etc.).',
  `bundle` varchar(128) NOT NULL COMMENT 'The name of the bundle a mapping applies to.',
  `mapping` longblob COMMENT 'The serialized mapping of the bundle type and fields to RDF terms.',
  PRIMARY KEY (`type`,`bundle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores custom RDF mappings for user defined content types...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rdf_mapping`
--
-- ORDER BY:  `type`,`bundle`

LOCK TABLES `rdf_mapping` WRITE;
/*!40000 ALTER TABLE `rdf_mapping` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `rdf_mapping` VALUES ('node','article','a:11:{s:11:\"field_image\";a:2:{s:10:\"predicates\";a:2:{i:0;s:8:\"og:image\";i:1;s:12:\"rdfs:seeAlso\";}s:4:\"type\";s:3:\"rel\";}s:10:\"field_tags\";a:2:{s:10:\"predicates\";a:1:{i:0;s:10:\"dc:subject\";}s:4:\"type\";s:3:\"rel\";}s:7:\"rdftype\";a:2:{i:0;s:9:\"sioc:Item\";i:1;s:13:\"foaf:Document\";}s:5:\"title\";a:1:{s:10:\"predicates\";a:1:{i:0;s:8:\"dc:title\";}}s:7:\"created\";a:3:{s:10:\"predicates\";a:2:{i:0;s:7:\"dc:date\";i:1;s:10:\"dc:created\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}s:7:\"changed\";a:3:{s:10:\"predicates\";a:1:{i:0;s:11:\"dc:modified\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}s:4:\"body\";a:1:{s:10:\"predicates\";a:1:{i:0;s:15:\"content:encoded\";}}s:3:\"uid\";a:2:{s:10:\"predicates\";a:1:{i:0;s:16:\"sioc:has_creator\";}s:4:\"type\";s:3:\"rel\";}s:4:\"name\";a:1:{s:10:\"predicates\";a:1:{i:0;s:9:\"foaf:name\";}}s:13:\"comment_count\";a:2:{s:10:\"predicates\";a:1:{i:0;s:16:\"sioc:num_replies\";}s:8:\"datatype\";s:11:\"xsd:integer\";}s:13:\"last_activity\";a:3:{s:10:\"predicates\";a:1:{i:0;s:23:\"sioc:last_activity_date\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}}');
INSERT INTO `rdf_mapping` VALUES ('node','page','a:9:{s:7:\"rdftype\";a:1:{i:0;s:13:\"foaf:Document\";}s:5:\"title\";a:1:{s:10:\"predicates\";a:1:{i:0;s:8:\"dc:title\";}}s:7:\"created\";a:3:{s:10:\"predicates\";a:2:{i:0;s:7:\"dc:date\";i:1;s:10:\"dc:created\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}s:7:\"changed\";a:3:{s:10:\"predicates\";a:1:{i:0;s:11:\"dc:modified\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}s:4:\"body\";a:1:{s:10:\"predicates\";a:1:{i:0;s:15:\"content:encoded\";}}s:3:\"uid\";a:2:{s:10:\"predicates\";a:1:{i:0;s:16:\"sioc:has_creator\";}s:4:\"type\";s:3:\"rel\";}s:4:\"name\";a:1:{s:10:\"predicates\";a:1:{i:0;s:9:\"foaf:name\";}}s:13:\"comment_count\";a:2:{s:10:\"predicates\";a:1:{i:0;s:16:\"sioc:num_replies\";}s:8:\"datatype\";s:11:\"xsd:integer\";}s:13:\"last_activity\";a:3:{s:10:\"predicates\";a:1:{i:0;s:23:\"sioc:last_activity_date\";}s:8:\"datatype\";s:12:\"xsd:dateTime\";s:8:\"callback\";s:12:\"date_iso8601\";}}');
/*!40000 ALTER TABLE `rdf_mapping` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `registry`
--

DROP TABLE IF EXISTS `registry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registry` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the function, class, or interface.',
  `type` varchar(9) NOT NULL DEFAULT '' COMMENT 'Either function or class or interface.',
  `filename` varchar(255) NOT NULL COMMENT 'Name of the file.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the module the file belongs to.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.',
  PRIMARY KEY (`name`,`type`),
  KEY `hook` (`type`,`weight`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Each record is a function, class, or interface name and...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registry`
--
-- ORDER BY:  `name`,`type`

LOCK TABLES `registry` WRITE;
/*!40000 ALTER TABLE `registry` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `registry` VALUES ('AccessDeniedTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('AdminMetaTagTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('ArchiverInterface','interface','includes/archiver.inc','',0);
INSERT INTO `registry` VALUES ('ArchiverTar','class','modules/system/system.archiver.inc','system',0);
INSERT INTO `registry` VALUES ('ArchiverZip','class','modules/system/system.archiver.inc','system',0);
INSERT INTO `registry` VALUES ('Archive_Tar','class','modules/system/system.tar.inc','system',0);
INSERT INTO `registry` VALUES ('BatchMemoryQueue','class','includes/batch.queue.inc','',0);
INSERT INTO `registry` VALUES ('BatchQueue','class','includes/batch.queue.inc','',0);
INSERT INTO `registry` VALUES ('BlockAdminThemeTestCase','class','modules/block/block.test','block',0);
INSERT INTO `registry` VALUES ('BlockCacheTestCase','class','modules/block/block.test','block',0);
INSERT INTO `registry` VALUES ('BlockHiddenRegionTestCase','class','modules/block/block.test','block',0);
INSERT INTO `registry` VALUES ('BlockHTMLIdTestCase','class','modules/block/block.test','block',0);
INSERT INTO `registry` VALUES ('BlockInvalidRegionTestCase','class','modules/block/block.test','block',0);
INSERT INTO `registry` VALUES ('BlockTemplateSuggestionsUnitTest','class','modules/block/block.test','block',0);
INSERT INTO `registry` VALUES ('BlockTestCase','class','modules/block/block.test','block',0);
INSERT INTO `registry` VALUES ('ColorTestCase','class','modules/color/color.test','color',0);
INSERT INTO `registry` VALUES ('CommentActionsTestCase','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CommentAnonymous','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CommentApprovalTest','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CommentBlockFunctionalTest','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CommentContentRebuild','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CommentController','class','modules/comment/comment.module','comment',0);
INSERT INTO `registry` VALUES ('CommentFieldsTest','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CommentHelperCase','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CommentInterfaceTest','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CommentNodeAccessTest','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CommentNodeChangesTestCase','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CommentPagerTest','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CommentPreviewTest','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CommentRSSUnitTest','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CommentThreadingTestCase','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('CommentTokenReplaceTestCase','class','modules/comment/comment.test','comment',0);
INSERT INTO `registry` VALUES ('ContextualDynamicContextTestCase','class','modules/contextual/contextual.test','contextual',0);
INSERT INTO `registry` VALUES ('CronRunTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('DashboardBlocksTestCase','class','modules/dashboard/dashboard.test','dashboard',0);
INSERT INTO `registry` VALUES ('Database','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseCondition','class','includes/database/query.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseConnection','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseConnectionNotDefinedException','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseConnection_mysql','class','includes/database/mysql/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseConnection_pgsql','class','includes/database/pgsql/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseConnection_sqlite','class','includes/database/sqlite/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseDriverNotSpecifiedException','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseLog','class','includes/database/log.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseSchema','class','includes/database/schema.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseSchemaObjectDoesNotExistException','class','includes/database/schema.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseSchemaObjectExistsException','class','includes/database/schema.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseSchema_mysql','class','includes/database/mysql/schema.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseSchema_pgsql','class','includes/database/pgsql/schema.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseSchema_sqlite','class','includes/database/sqlite/schema.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseStatementBase','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseStatementEmpty','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseStatementInterface','interface','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseStatementPrefetch','class','includes/database/prefetch.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseStatement_sqlite','class','includes/database/sqlite/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseTaskException','class','includes/install.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseTasks','class','includes/install.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseTasks_mysql','class','includes/database/mysql/install.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseTasks_pgsql','class','includes/database/pgsql/install.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseTasks_sqlite','class','includes/database/sqlite/install.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseTransaction','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseTransactionCommitFailedException','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseTransactionExplicitCommitNotAllowedException','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseTransactionNameNonUniqueException','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseTransactionNoActiveException','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('DatabaseTransactionOutOfOrderException','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('DateTimeFunctionalTest','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('DBLogTestCase','class','modules/dblog/dblog.test','dblog',0);
INSERT INTO `registry` VALUES ('DefaultMailSystem','class','modules/system/system.mail.inc','system',0);
INSERT INTO `registry` VALUES ('DeleteQuery','class','includes/database/query.inc','',0);
INSERT INTO `registry` VALUES ('DeleteQuery_sqlite','class','includes/database/sqlite/query.inc','',0);
INSERT INTO `registry` VALUES ('DrupalCacheArray','class','includes/bootstrap.inc','',0);
INSERT INTO `registry` VALUES ('DrupalCacheInterface','interface','includes/cache.inc','',0);
INSERT INTO `registry` VALUES ('DrupalDatabaseCache','class','includes/cache.inc','',0);
INSERT INTO `registry` VALUES ('DrupalDefaultEntityController','class','includes/entity.inc','',0);
INSERT INTO `registry` VALUES ('DrupalEntityControllerInterface','interface','includes/entity.inc','',0);
INSERT INTO `registry` VALUES ('DrupalFakeCache','class','includes/cache-install.inc','',0);
INSERT INTO `registry` VALUES ('DrupalLocalStreamWrapper','class','includes/stream_wrappers.inc','',0);
INSERT INTO `registry` VALUES ('DrupalPrivateStreamWrapper','class','includes/stream_wrappers.inc','',0);
INSERT INTO `registry` VALUES ('DrupalPublicStreamWrapper','class','includes/stream_wrappers.inc','',0);
INSERT INTO `registry` VALUES ('DrupalQueue','class','modules/system/system.queue.inc','system',0);
INSERT INTO `registry` VALUES ('DrupalQueueInterface','interface','modules/system/system.queue.inc','system',0);
INSERT INTO `registry` VALUES ('DrupalReliableQueueInterface','interface','modules/system/system.queue.inc','system',0);
INSERT INTO `registry` VALUES ('DrupalStreamWrapperInterface','interface','includes/stream_wrappers.inc','',0);
INSERT INTO `registry` VALUES ('DrupalTemporaryStreamWrapper','class','includes/stream_wrappers.inc','',0);
INSERT INTO `registry` VALUES ('DrupalUpdateException','class','includes/update.inc','',0);
INSERT INTO `registry` VALUES ('DrupalUpdaterInterface','interface','includes/updater.inc','',0);
INSERT INTO `registry` VALUES ('EnableDisableTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('EntityFieldQuery','class','includes/entity.inc','',0);
INSERT INTO `registry` VALUES ('EntityFieldQueryException','class','includes/entity.inc','',0);
INSERT INTO `registry` VALUES ('EntityMalformedException','class','includes/entity.inc','',0);
INSERT INTO `registry` VALUES ('EntityPropertiesTestCase','class','modules/field/tests/field.test','field',0);
INSERT INTO `registry` VALUES ('FieldAttachOtherTestCase','class','modules/field/tests/field.test','field',0);
INSERT INTO `registry` VALUES ('FieldAttachStorageTestCase','class','modules/field/tests/field.test','field',0);
INSERT INTO `registry` VALUES ('FieldAttachTestCase','class','modules/field/tests/field.test','field',0);
INSERT INTO `registry` VALUES ('FieldBulkDeleteTestCase','class','modules/field/tests/field.test','field',0);
INSERT INTO `registry` VALUES ('FieldCrudTestCase','class','modules/field/tests/field.test','field',0);
INSERT INTO `registry` VALUES ('FieldDisplayAPITestCase','class','modules/field/tests/field.test','field',0);
INSERT INTO `registry` VALUES ('FieldException','class','modules/field/field.module','field',0);
INSERT INTO `registry` VALUES ('FieldFormTestCase','class','modules/field/tests/field.test','field',0);
INSERT INTO `registry` VALUES ('FieldInfo','class','modules/field/field.info.class.inc','field',0);
INSERT INTO `registry` VALUES ('FieldInfoTestCase','class','modules/field/tests/field.test','field',0);
INSERT INTO `registry` VALUES ('FieldInstanceCrudTestCase','class','modules/field/tests/field.test','field',0);
INSERT INTO `registry` VALUES ('FieldsOverlapException','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('FieldSqlStorageTestCase','class','modules/field/modules/field_sql_storage/field_sql_storage.test','field_sql_storage',0);
INSERT INTO `registry` VALUES ('FieldTestCase','class','modules/field/tests/field.test','field',0);
INSERT INTO `registry` VALUES ('FieldTranslationsTestCase','class','modules/field/tests/field.test','field',0);
INSERT INTO `registry` VALUES ('FieldUIAlterTestCase','class','modules/field_ui/field_ui.test','field_ui',0);
INSERT INTO `registry` VALUES ('FieldUIManageDisplayTestCase','class','modules/field_ui/field_ui.test','field_ui',0);
INSERT INTO `registry` VALUES ('FieldUIManageFieldsTestCase','class','modules/field_ui/field_ui.test','field_ui',0);
INSERT INTO `registry` VALUES ('FieldUITestCase','class','modules/field_ui/field_ui.test','field_ui',0);
INSERT INTO `registry` VALUES ('FieldUpdateForbiddenException','class','modules/field/field.module','field',0);
INSERT INTO `registry` VALUES ('FieldValidationException','class','modules/field/field.attach.inc','field',0);
INSERT INTO `registry` VALUES ('FileFieldDisplayTestCase','class','modules/file/tests/file.test','file',0);
INSERT INTO `registry` VALUES ('FileFieldPathTestCase','class','modules/file/tests/file.test','file',0);
INSERT INTO `registry` VALUES ('FileFieldRevisionTestCase','class','modules/file/tests/file.test','file',0);
INSERT INTO `registry` VALUES ('FileFieldTestCase','class','modules/file/tests/file.test','file',0);
INSERT INTO `registry` VALUES ('FileFieldValidateTestCase','class','modules/file/tests/file.test','file',0);
INSERT INTO `registry` VALUES ('FileFieldWidgetTestCase','class','modules/file/tests/file.test','file',0);
INSERT INTO `registry` VALUES ('FileManagedFileElementTestCase','class','modules/file/tests/file.test','file',0);
INSERT INTO `registry` VALUES ('FilePrivateTestCase','class','modules/file/tests/file.test','file',0);
INSERT INTO `registry` VALUES ('FileTokenReplaceTestCase','class','modules/file/tests/file.test','file',0);
INSERT INTO `registry` VALUES ('FileTransfer','class','includes/filetransfer/filetransfer.inc','',0);
INSERT INTO `registry` VALUES ('FileTransferChmodInterface','interface','includes/filetransfer/filetransfer.inc','',0);
INSERT INTO `registry` VALUES ('FileTransferException','class','includes/filetransfer/filetransfer.inc','',0);
INSERT INTO `registry` VALUES ('FileTransferFTP','class','includes/filetransfer/ftp.inc','',0);
INSERT INTO `registry` VALUES ('FileTransferFTPExtension','class','includes/filetransfer/ftp.inc','',0);
INSERT INTO `registry` VALUES ('FileTransferLocal','class','includes/filetransfer/local.inc','',0);
INSERT INTO `registry` VALUES ('FileTransferSSH','class','includes/filetransfer/ssh.inc','',0);
INSERT INTO `registry` VALUES ('FilterAdminTestCase','class','modules/filter/filter.test','filter',0);
INSERT INTO `registry` VALUES ('FilterCRUDTestCase','class','modules/filter/filter.test','filter',0);
INSERT INTO `registry` VALUES ('FilterDefaultFormatTestCase','class','modules/filter/filter.test','filter',0);
INSERT INTO `registry` VALUES ('FilterFormatAccessTestCase','class','modules/filter/filter.test','filter',0);
INSERT INTO `registry` VALUES ('FilterHooksTestCase','class','modules/filter/filter.test','filter',0);
INSERT INTO `registry` VALUES ('FilterNoFormatTestCase','class','modules/filter/filter.test','filter',0);
INSERT INTO `registry` VALUES ('FilterSecurityTestCase','class','modules/filter/filter.test','filter',0);
INSERT INTO `registry` VALUES ('FilterSettingsTestCase','class','modules/filter/filter.test','filter',0);
INSERT INTO `registry` VALUES ('FilterUnitTestCase','class','modules/filter/filter.test','filter',0);
INSERT INTO `registry` VALUES ('FloodFunctionalTest','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('FrontPageTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('HelpTestCase','class','modules/help/help.test','help',0);
INSERT INTO `registry` VALUES ('HookRequirementsTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('ImageAdminStylesUnitTest','class','modules/image/image.test','image',0);
INSERT INTO `registry` VALUES ('ImageDimensionsScaleTestCase','class','modules/image/image.test','image',0);
INSERT INTO `registry` VALUES ('ImageDimensionsTestCase','class','modules/image/image.test','image',0);
INSERT INTO `registry` VALUES ('ImageEffectsUnitTest','class','modules/image/image.test','image',0);
INSERT INTO `registry` VALUES ('ImageFieldDefaultImagesTestCase','class','modules/image/image.test','image',0);
INSERT INTO `registry` VALUES ('ImageFieldDisplayTestCase','class','modules/image/image.test','image',0);
INSERT INTO `registry` VALUES ('ImageFieldTestCase','class','modules/image/image.test','image',0);
INSERT INTO `registry` VALUES ('ImageFieldValidateTestCase','class','modules/image/image.test','image',0);
INSERT INTO `registry` VALUES ('ImageStyleFlushTest','class','modules/image/image.test','image',0);
INSERT INTO `registry` VALUES ('ImageStylesPathAndUrlTestCase','class','modules/image/image.test','image',0);
INSERT INTO `registry` VALUES ('ImageThemeFunctionWebTestCase','class','modules/image/image.test','image',0);
INSERT INTO `registry` VALUES ('InfoFileParserTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('InsertQuery','class','includes/database/query.inc','',0);
INSERT INTO `registry` VALUES ('InsertQuery_mysql','class','includes/database/mysql/query.inc','',0);
INSERT INTO `registry` VALUES ('InsertQuery_pgsql','class','includes/database/pgsql/query.inc','',0);
INSERT INTO `registry` VALUES ('InsertQuery_sqlite','class','includes/database/sqlite/query.inc','',0);
INSERT INTO `registry` VALUES ('InvalidMergeQueryException','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('IPAddressBlockingTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('ListDynamicValuesTestCase','class','modules/field/modules/list/tests/list.test','list',0);
INSERT INTO `registry` VALUES ('ListDynamicValuesValidationTestCase','class','modules/field/modules/list/tests/list.test','list',0);
INSERT INTO `registry` VALUES ('ListFieldTestCase','class','modules/field/modules/list/tests/list.test','list',0);
INSERT INTO `registry` VALUES ('ListFieldUITestCase','class','modules/field/modules/list/tests/list.test','list',0);
INSERT INTO `registry` VALUES ('MailSystemInterface','interface','includes/mail.inc','',0);
INSERT INTO `registry` VALUES ('MemoryQueue','class','modules/system/system.queue.inc','system',0);
INSERT INTO `registry` VALUES ('MenuNodeTestCase','class','modules/menu/menu.test','menu',0);
INSERT INTO `registry` VALUES ('MenuTestCase','class','modules/menu/menu.test','menu',0);
INSERT INTO `registry` VALUES ('MergeQuery','class','includes/database/query.inc','',0);
INSERT INTO `registry` VALUES ('ModuleDependencyTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('ModuleRequiredTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('ModuleTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('ModuleUpdater','class','modules/system/system.updater.inc','system',0);
INSERT INTO `registry` VALUES ('ModuleVersionTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('MultiStepNodeFormBasicOptionsTest','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NewDefaultThemeBlocks','class','modules/block/block.test','block',0);
INSERT INTO `registry` VALUES ('NodeAccessBaseTableTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeAccessFieldTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeAccessPagerTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeAccessRebuildTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeAccessRecordsTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeAccessTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeAdminTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeBlockFunctionalTest','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeBlockTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeBuildContent','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeController','class','modules/node/node.module','node',0);
INSERT INTO `registry` VALUES ('NodeCreationTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeEntityFieldQueryAlter','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeEntityViewModeAlterTest','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeFeedTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeLoadHooksTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeLoadMultipleTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodePostSettingsTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeQueryAlter','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeRevisionPermissionsTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeRevisionsTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeRSSContentTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeSaveTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeTitleTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeTitleXSSTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeTokenReplaceTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeTypePersistenceTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeTypeTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NodeWebTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('NoFieldsException','class','includes/database/database.inc','',0);
INSERT INTO `registry` VALUES ('NoHelpTestCase','class','modules/help/help.test','help',0);
INSERT INTO `registry` VALUES ('NonDefaultBlockAdmin','class','modules/block/block.test','block',0);
INSERT INTO `registry` VALUES ('NumberFieldTestCase','class','modules/field/modules/number/number.test','number',0);
INSERT INTO `registry` VALUES ('OptionsSelectDynamicValuesTestCase','class','modules/field/modules/options/options.test','options',0);
INSERT INTO `registry` VALUES ('OptionsWidgetsTestCase','class','modules/field/modules/options/options.test','options',0);
INSERT INTO `registry` VALUES ('PageEditTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('PageNotFoundTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('PagePreviewTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('PagerDefault','class','includes/pager.inc','',0);
INSERT INTO `registry` VALUES ('PageTitleFiltering','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('PageViewTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('PathLanguageTestCase','class','modules/path/path.test','path',0);
INSERT INTO `registry` VALUES ('PathLanguageUITestCase','class','modules/path/path.test','path',0);
INSERT INTO `registry` VALUES ('PathMonolingualTestCase','class','modules/path/path.test','path',0);
INSERT INTO `registry` VALUES ('PathTaxonomyTermTestCase','class','modules/path/path.test','path',0);
INSERT INTO `registry` VALUES ('PathTestCase','class','modules/path/path.test','path',0);
INSERT INTO `registry` VALUES ('Query','class','includes/database/query.inc','',0);
INSERT INTO `registry` VALUES ('QueryAlterableInterface','interface','includes/database/query.inc','',0);
INSERT INTO `registry` VALUES ('QueryConditionInterface','interface','includes/database/query.inc','',0);
INSERT INTO `registry` VALUES ('QueryExtendableInterface','interface','includes/database/select.inc','',0);
INSERT INTO `registry` VALUES ('QueryPlaceholderInterface','interface','includes/database/query.inc','',0);
INSERT INTO `registry` VALUES ('QueueTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('RdfCommentAttributesTestCase','class','modules/rdf/rdf.test','rdf',0);
INSERT INTO `registry` VALUES ('RdfCrudTestCase','class','modules/rdf/rdf.test','rdf',0);
INSERT INTO `registry` VALUES ('RdfGetRdfNamespacesTestCase','class','modules/rdf/rdf.test','rdf',0);
INSERT INTO `registry` VALUES ('RdfMappingDefinitionTestCase','class','modules/rdf/rdf.test','rdf',0);
INSERT INTO `registry` VALUES ('RdfMappingHookTestCase','class','modules/rdf/rdf.test','rdf',0);
INSERT INTO `registry` VALUES ('RdfRdfaMarkupTestCase','class','modules/rdf/rdf.test','rdf',0);
INSERT INTO `registry` VALUES ('RdfTrackerAttributesTestCase','class','modules/rdf/rdf.test','rdf',0);
INSERT INTO `registry` VALUES ('RetrieveFileTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('SchemaCache','class','includes/bootstrap.inc','',0);
INSERT INTO `registry` VALUES ('SearchAdvancedSearchForm','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchBlockTestCase','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchCommentCountToggleTestCase','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchCommentTestCase','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchConfigSettingsForm','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchEmbedForm','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchExactTestCase','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchExcerptTestCase','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchExpressionInsertExtractTestCase','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchKeywordsConditions','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchLanguageTestCase','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchMatchTestCase','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchNodeAccessTest','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchNumberMatchingTestCase','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchNumbersTestCase','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchPageOverride','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchPageText','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchQuery','class','modules/search/search.extender.inc','search',0);
INSERT INTO `registry` VALUES ('SearchRankingTestCase','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchSimplifyTestCase','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SearchTokenizerTestCase','class','modules/search/search.test','search',0);
INSERT INTO `registry` VALUES ('SelectQuery','class','includes/database/select.inc','',0);
INSERT INTO `registry` VALUES ('SelectQueryExtender','class','includes/database/select.inc','',0);
INSERT INTO `registry` VALUES ('SelectQueryInterface','interface','includes/database/select.inc','',0);
INSERT INTO `registry` VALUES ('SelectQuery_pgsql','class','includes/database/pgsql/select.inc','',0);
INSERT INTO `registry` VALUES ('SelectQuery_sqlite','class','includes/database/sqlite/select.inc','',0);
INSERT INTO `registry` VALUES ('ShortcutLinksTestCase','class','modules/shortcut/shortcut.test','shortcut',0);
INSERT INTO `registry` VALUES ('ShortcutSetsTestCase','class','modules/shortcut/shortcut.test','shortcut',0);
INSERT INTO `registry` VALUES ('ShortcutTestCase','class','modules/shortcut/shortcut.test','shortcut',0);
INSERT INTO `registry` VALUES ('ShutdownFunctionsTest','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('SiteMaintenanceTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('SkipDotsRecursiveDirectoryIterator','class','includes/filetransfer/filetransfer.inc','',0);
INSERT INTO `registry` VALUES ('StreamWrapperInterface','interface','includes/stream_wrappers.inc','',0);
INSERT INTO `registry` VALUES ('SummaryLengthTestCase','class','modules/node/node.test','node',0);
INSERT INTO `registry` VALUES ('SystemAdminTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('SystemAuthorizeCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('SystemBlockTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('SystemIndexPhpTest','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('SystemInfoAlterTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('SystemMainContentFallback','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('SystemQueue','class','modules/system/system.queue.inc','system',0);
INSERT INTO `registry` VALUES ('SystemThemeFunctionalTest','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('TableSort','class','includes/tablesort.inc','',0);
INSERT INTO `registry` VALUES ('TaxonomyEFQTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyHooksTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyLegacyTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyLoadMultipleTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyRSSTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyTermController','class','modules/taxonomy/taxonomy.module','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyTermFieldMultipleVocabularyTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyTermFieldTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyTermFunctionTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyTermIndexTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyTermTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyThemeTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyTokenReplaceTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyVocabularyController','class','modules/taxonomy/taxonomy.module','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyVocabularyFunctionalTest','class','modules/taxonomy/taxonomy.test','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyVocabularyTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0);
INSERT INTO `registry` VALUES ('TaxonomyWebTestCase','class','modules/taxonomy/taxonomy.test','taxonomy',0);
INSERT INTO `registry` VALUES ('TestingMailSystem','class','modules/system/system.mail.inc','system',0);
INSERT INTO `registry` VALUES ('TextFieldTestCase','class','modules/field/modules/text/text.test','text',0);
INSERT INTO `registry` VALUES ('TextSummaryTestCase','class','modules/field/modules/text/text.test','text',0);
INSERT INTO `registry` VALUES ('TextTranslationTestCase','class','modules/field/modules/text/text.test','text',0);
INSERT INTO `registry` VALUES ('ThemeRegistry','class','includes/theme.inc','',0);
INSERT INTO `registry` VALUES ('ThemeUpdater','class','modules/system/system.updater.inc','system',0);
INSERT INTO `registry` VALUES ('TokenReplaceTestCase','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('TokenScanTest','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('TruncateQuery','class','includes/database/query.inc','',0);
INSERT INTO `registry` VALUES ('TruncateQuery_mysql','class','includes/database/mysql/query.inc','',0);
INSERT INTO `registry` VALUES ('TruncateQuery_sqlite','class','includes/database/sqlite/query.inc','',0);
INSERT INTO `registry` VALUES ('UpdateCoreTestCase','class','modules/update/update.test','update',0);
INSERT INTO `registry` VALUES ('UpdateCoreUnitTestCase','class','modules/update/update.test','update',0);
INSERT INTO `registry` VALUES ('UpdateQuery','class','includes/database/query.inc','',0);
INSERT INTO `registry` VALUES ('UpdateQuery_pgsql','class','includes/database/pgsql/query.inc','',0);
INSERT INTO `registry` VALUES ('UpdateQuery_sqlite','class','includes/database/sqlite/query.inc','',0);
INSERT INTO `registry` VALUES ('Updater','class','includes/updater.inc','',0);
INSERT INTO `registry` VALUES ('UpdaterException','class','includes/updater.inc','',0);
INSERT INTO `registry` VALUES ('UpdaterFileTransferException','class','includes/updater.inc','',0);
INSERT INTO `registry` VALUES ('UpdateScriptFunctionalTest','class','modules/system/system.test','system',0);
INSERT INTO `registry` VALUES ('UpdateTestContribCase','class','modules/update/update.test','update',0);
INSERT INTO `registry` VALUES ('UpdateTestHelper','class','modules/update/update.test','update',0);
INSERT INTO `registry` VALUES ('UpdateTestUploadCase','class','modules/update/update.test','update',0);
INSERT INTO `registry` VALUES ('UserAccountLinksUnitTests','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserAdminTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserAuthmapAssignmentTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserAutocompleteTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserBlocksUnitTests','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserCancelTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserController','class','modules/user/user.module','user',0);
INSERT INTO `registry` VALUES ('UserCreateTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserEditedOwnAccountTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserEditTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserLoginTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserPasswordResetTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserPermissionsTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserPictureTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserRegistrationTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserRoleAdminTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserRolesAssignmentTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserSaveTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserSignatureTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserTimeZoneFunctionalTest','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserTokenReplaceTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserUserSearchTestCase','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserValidateCurrentPassCustomForm','class','modules/user/user.test','user',0);
INSERT INTO `registry` VALUES ('UserValidationTestCase','class','modules/user/user.test','user',0);
/*!40000 ALTER TABLE `registry` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `registry_file`
--

DROP TABLE IF EXISTS `registry_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registry_file` (
  `filename` varchar(255) NOT NULL COMMENT 'Path to the file.',
  `hash` varchar(64) NOT NULL COMMENT 'sha-256 hash of the file’s contents when last parsed.',
  PRIMARY KEY (`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Files parsed to build the registry.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registry_file`
--
-- ORDER BY:  `filename`

LOCK TABLES `registry_file` WRITE;
/*!40000 ALTER TABLE `registry_file` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `registry_file` VALUES ('includes/actions.inc','f36b066681463c7dfe189e0430cb1a89bf66f7e228cbb53cdfcd93987193f759');
INSERT INTO `registry_file` VALUES ('includes/ajax.inc','8328ec7441a0c101c1b39ba8d415c1d951b400887d8b29d2831210ae207f86eb');
INSERT INTO `registry_file` VALUES ('includes/archiver.inc','bdbb21b712a62f6b913590b609fd17cd9f3c3b77c0d21f68e71a78427ed2e3e9');
INSERT INTO `registry_file` VALUES ('includes/authorize.inc','6d64d8c21aa01eb12fc29918732e4df6b871ed06e5d41373cb95c197ed661d13');
INSERT INTO `registry_file` VALUES ('includes/batch.inc','059da9e36e1f3717f27840aae73f10dea7d6c8daf16f6520401cc1ca3b4c0388');
INSERT INTO `registry_file` VALUES ('includes/batch.queue.inc','554b2e92e1dad0f7fd5a19cb8dff7e109f10fbe2441a5692d076338ec908de0f');
INSERT INTO `registry_file` VALUES ('includes/bootstrap.inc','025bd83ad086a9e2205de304ffcbdc9b19f74fa4cabfe32ad94c2dd0f49e6e9c');
INSERT INTO `registry_file` VALUES ('includes/cache-install.inc','e7ed123c5805703c84ad2cce9c1ca46b3ce8caeeea0d8ef39a3024a4ab95fa0e');
INSERT INTO `registry_file` VALUES ('includes/cache.inc','c1916375fcb92250a5c86aa53269d54854b983f34906d582fc912784f16ccaf4');
INSERT INTO `registry_file` VALUES ('includes/common.inc','d4954efd95278dc8e1127e0703353d8a38d393c10b223c46adaef25ce8cb357c');
INSERT INTO `registry_file` VALUES ('includes/database/database.inc','1597142a1fbd6fcff24f2bb92805a1c98b7bc36520cc68007bc7383effcaf890');
INSERT INTO `registry_file` VALUES ('includes/database/log.inc','9feb5a17ae2fabcf26a96d2a634ba73da501f7bcfc3599a693d916a6971d00d1');
INSERT INTO `registry_file` VALUES ('includes/database/mysql/database.inc','8d3a784845064385ccdce8a66860f3177d52207df83d9735c0d72c9703dd258e');
INSERT INTO `registry_file` VALUES ('includes/database/mysql/install.inc','6ae316941f771732fbbabed7e1d6b4cbb41b1f429dd097d04b3345aa15e461a0');
INSERT INTO `registry_file` VALUES ('includes/database/mysql/query.inc','48cee5e5290282ccbe3e77814e70ab33b69efe8f0c09716ee465e3e5f888c2ce');
INSERT INTO `registry_file` VALUES ('includes/database/mysql/schema.inc','d8d3904ea9c23a526c2f2a7acc8ba870b31c378aac2eb53e2e41a73c6209c5bd');
INSERT INTO `registry_file` VALUES ('includes/database/pgsql/database.inc','56726100fd44f461a04886c590c9c472cc2b2a1b92eb26c7674bf3821a76bb64');
INSERT INTO `registry_file` VALUES ('includes/database/pgsql/install.inc','585b80c5bbd6f134bff60d06397f15154657a577d4da8d1b181858905f09dea5');
INSERT INTO `registry_file` VALUES ('includes/database/pgsql/query.inc','cb4c84f8f1ffc73098ed71137248dcd078a505a7530e60d979d74b3a3cdaa658');
INSERT INTO `registry_file` VALUES ('includes/database/pgsql/schema.inc','8fd647e4557522283caef63e528c6e403fc0751a46e94aac867a281af85eac27');
INSERT INTO `registry_file` VALUES ('includes/database/pgsql/select.inc','fd4bba7887c1dc6abc8f080fc3a76c01d92ea085434e355dc1ecb50d8743c22d');
INSERT INTO `registry_file` VALUES ('includes/database/prefetch.inc','b5b207a66a69ecb52ee4f4459af16a7b5eabedc87254245f37cc33bebb61c0fb');
INSERT INTO `registry_file` VALUES ('includes/database/query.inc','cbc8fa88a15e58d39f3ae7a90bca55c48812202f8cdf74b9d4d7717ec54db469');
INSERT INTO `registry_file` VALUES ('includes/database/schema.inc','7eb7251f331109757173353263d1031493c1198ae17a165a6f5a03d3f14f93e7');
INSERT INTO `registry_file` VALUES ('includes/database/select.inc','1c74fa55c7721a704f5ef3389032604bf7a60fced15c40d844aee3e1cead7dc6');
INSERT INTO `registry_file` VALUES ('includes/database/sqlite/database.inc','ed2b9981794239cdad2cd04cf4bcdc896ad4d6b66179a4fa487b0d1ec2150a10');
INSERT INTO `registry_file` VALUES ('includes/database/sqlite/install.inc','381f3db8c59837d961978ba3097bb6443534ed1659fd713aa563963fa0c42cc5');
INSERT INTO `registry_file` VALUES ('includes/database/sqlite/query.inc','cd726af682495d8fe20283ddbc4d877536cad2df4a2df8afc2dc21be71a4eba8');
INSERT INTO `registry_file` VALUES ('includes/database/sqlite/schema.inc','238414785aa96dd27f10f48c961783f4d1091392beee8d0e7ca8ae774e917da2');
INSERT INTO `registry_file` VALUES ('includes/database/sqlite/select.inc','8d1c426dbd337733c206cce9f59a172546c6ed856d8ef3f1c7bef05a16f7bf68');
INSERT INTO `registry_file` VALUES ('includes/date.inc','18c047be64f201e16d189f1cc47ed9dcf0a145151b1ee187e90511b24e5d2b36');
INSERT INTO `registry_file` VALUES ('includes/entity.inc','43536d4fdfffdfcadf8606418a211113ba955b634d1d4a6df9c550df090bfa96');
INSERT INTO `registry_file` VALUES ('includes/errors.inc','58dc008b3b90ecc5e97fe2135ac25376b7719efec1fb74f43cde9068fedbf2ca');
INSERT INTO `registry_file` VALUES ('includes/file.inc','eb9f794ed93a8550547a02fcdb137ba071497a4466f0e2878c76b0b941c5db8b');
INSERT INTO `registry_file` VALUES ('includes/file.mimetypes.inc','f88c967550576694b7a1ce2afd0f2f1bbc1a91d21cc2c20f86c44d39ff353867');
INSERT INTO `registry_file` VALUES ('includes/filetransfer/filetransfer.inc','fdea8ae48345ec91885ac48a9bc53daf87616271472bb7c29b7e3ce219b22034');
INSERT INTO `registry_file` VALUES ('includes/filetransfer/ftp.inc','589ebf4b8bd4a2973aa56a156ac1fa83b6c73e703391361fb573167670e0d832');
INSERT INTO `registry_file` VALUES ('includes/filetransfer/local.inc','7cbfdb46abbdf539640db27e66fb30e5265128f31002bd0dfc3af16ae01a9492');
INSERT INTO `registry_file` VALUES ('includes/filetransfer/ssh.inc','002e24a24cac133d12728bd3843868ce378681237d7fad420761af84e6efe5ad');
INSERT INTO `registry_file` VALUES ('includes/form.inc','abb212b6be660bd10df31e248564411496ca972d3477a5b0ab529d413a5b3e5c');
INSERT INTO `registry_file` VALUES ('includes/graph.inc','8e0e313a8bb33488f371df11fc1b58d7cf80099b886cd1003871e2c896d1b536');
INSERT INTO `registry_file` VALUES ('includes/image.inc','bcdc7e1599c02227502b9d0fe36eeb2b529b130a392bc709eb737647bd361826');
INSERT INTO `registry_file` VALUES ('includes/install.core.inc','2a036b695c555d7339115099e0b7b06bf7fbafbaad6d7cc143e49969ff96c394');
INSERT INTO `registry_file` VALUES ('includes/install.inc','45864b9d208a9dba5ee3d523786f4935a0b0c9d0d752229981da997b700954df');
INSERT INTO `registry_file` VALUES ('includes/iso.inc','27730e6175b79c3b5d494582a124f6210289faa03bef099e16347bb914464c66');
INSERT INTO `registry_file` VALUES ('includes/json-encode.inc','02a822a652d00151f79db9aa9e171c310b69b93a12f549bc2ce00533a8efa14e');
INSERT INTO `registry_file` VALUES ('includes/language.inc','77ef0c210a8f01d4ad24b13b147db3db0dcef801dbae8b644124cedd562a8a57');
INSERT INTO `registry_file` VALUES ('includes/locale.inc','8cc571c114587f2b30e4e24db17e97e51e81f9cc395fa01f348aba12cee8523e');
INSERT INTO `registry_file` VALUES ('includes/lock.inc','daa62e95528f6b986b85680b600a896452bf2ce6f38921242857dcc5a3460a1b');
INSERT INTO `registry_file` VALUES ('includes/mail.inc','8b37b30d82941010eacf8f435abbf9cb5b6cfc2710c3446a5037192ae14d68bf');
INSERT INTO `registry_file` VALUES ('includes/menu.inc','3183e10659511cd5ad290c6a74bad9601a08827e7e6e025fcfd2cf9eea18cff0');
INSERT INTO `registry_file` VALUES ('includes/module.inc','ca3f2e6129181bbbc67e5e6058a882047f2152174ec8e95c0ea99ce610ace4d7');
INSERT INTO `registry_file` VALUES ('includes/pager.inc','6f9494b85c07a2cc3be4e54aff2d2757485238c476a7da084d25bde1d88be6d8');
INSERT INTO `registry_file` VALUES ('includes/password.inc','7550ac434a929562a3380e82c546afbf9163598b22f2351f0e7d3f19567fb6c9');
INSERT INTO `registry_file` VALUES ('includes/path.inc','d20d3efabcb752fcafafc887fc0f09704d87000742302f95cf58e62333d05279');
INSERT INTO `registry_file` VALUES ('includes/registry.inc','4ffb8c9c8c179c1417ff01790f339edf50b5f7cc0c8bb976eef6858cc71e9bc8');
INSERT INTO `registry_file` VALUES ('includes/session.inc','65764101f3746e25210e8a91a9c058218c83c7bf444051ba339c412a2d2bff63');
INSERT INTO `registry_file` VALUES ('includes/stream_wrappers.inc','b04e31585a9a397b0edf7b3586050cbd4b1f631e283296e1c93f4356662faeb9');
INSERT INTO `registry_file` VALUES ('includes/tablesort.inc','4cb2a5a2d41b2a204a13f59085096e3f64237d32639ea5d30752905099bc7540');
INSERT INTO `registry_file` VALUES ('includes/theme.inc','7fc0ffea33bf25419adb89b91f0fc892c183cd0db41e4f00958694b6f03e7335');
INSERT INTO `registry_file` VALUES ('includes/theme.maintenance.inc','39f068b3eee4d10a90d6aa3c86db587b6d25844c2919d418d34d133cfe330f5a');
INSERT INTO `registry_file` VALUES ('includes/token.inc','5e7898cd78689e2c291ed3cd8f41c032075656896f1db57e49217aac19ae0428');
INSERT INTO `registry_file` VALUES ('includes/unicode.entities.inc','2b858138596d961fbaa4c6e3986e409921df7f76b6ee1b109c4af5970f1e0f54');
INSERT INTO `registry_file` VALUES ('includes/unicode.inc','518ad21bd4f43814277d67f76ff8eb2b99bd1be4caa5e02b6e5f06cf65d84eb0');
INSERT INTO `registry_file` VALUES ('includes/update.inc','177ce24362efc7f28b384c90a09c3e485396bbd18c3721d4b21e57dd1733bd92');
INSERT INTO `registry_file` VALUES ('includes/updater.inc','d2da0e74ed86e93c209f16069f3d32e1a134ceb6c06a0044f78e841a1b54e380');
INSERT INTO `registry_file` VALUES ('includes/utility.inc','3458fd2b55ab004dd0cc529b8e58af12916e8bd36653b072bdd820b26b907ed5');
INSERT INTO `registry_file` VALUES ('includes/xmlrpc.inc','c5b6ea78adeb135373d11aeaaea057d9fa8995faa4e8c0fec9b7c647f15cc4e0');
INSERT INTO `registry_file` VALUES ('includes/xmlrpcs.inc','79dc6e9882f4c506123d7dd8e228a61e22c46979c3aab21a5b1afa315ef6639c');
INSERT INTO `registry_file` VALUES ('modules/block/block.test','7aefd627d62b44f9c1e9ee3aa9da6c6e2a7cfce01c6613e8bd24c0b9c464dd73');
INSERT INTO `registry_file` VALUES ('modules/color/color.test','013806279bd47ceb2f82ca854b57f880ba21058f7a2592c422afae881a7f5d15');
INSERT INTO `registry_file` VALUES ('modules/comment/comment.module','966005005058b4df64d515ce2a6049843b2085fc8c2067a2e8ccd59d85d054e9');
INSERT INTO `registry_file` VALUES ('modules/comment/comment.test','5404277c15b1306a1ad5eca6703f7d2003567fea6085ffd2b1c3d65896acdf21');
INSERT INTO `registry_file` VALUES ('modules/contextual/contextual.test','023dafa199bd325ecc55a17b2a3db46ac0a31e23059f701f789f3bc42427ba0b');
INSERT INTO `registry_file` VALUES ('modules/dashboard/dashboard.test','270378b5c8ed0e7d0e00fbc62e617813c6dec1d79396229786942bf9fb738e16');
INSERT INTO `registry_file` VALUES ('modules/dblog/dblog.test','c2bf857ac110f03b3fbb3469bcbad86e86b506f04153c6372de896fa26c0b3e6');
INSERT INTO `registry_file` VALUES ('modules/field/field.attach.inc','25d05fb8ab30ba559051ca2034ea7e61bd1326cacb12dfeb865e90e2ffd147e6');
INSERT INTO `registry_file` VALUES ('modules/field/field.info.class.inc','c2e4bc67ef51e4956c913be772914b1b2625aa5066ab67c74baf6404ed538174');
INSERT INTO `registry_file` VALUES ('modules/field/field.module','d2d9b9b324c256ca11e117f84afd9722c5271887a57497e2dd1f339adae7c12d');
INSERT INTO `registry_file` VALUES ('modules/field/modules/field_sql_storage/field_sql_storage.test','35c9c300bc922d3a7c40516ad0ddeb7dc0ef02dd6b7f3f12b4820c41ce912593');
INSERT INTO `registry_file` VALUES ('modules/field/modules/list/tests/list.test','97e55bd49f6f4b0562d04aa3773b5ab9b35063aee05c8c7231780cdcf9c97714');
INSERT INTO `registry_file` VALUES ('modules/field/modules/number/number.test','9ccf835bbf80ff31b121286f6fbcf59cc42b622a51ab56b22362b2f55c656e18');
INSERT INTO `registry_file` VALUES ('modules/field/modules/options/options.test','360c5d3028036423106445eedde49827c75f3ba609186d349e1d0b1353183c18');
INSERT INTO `registry_file` VALUES ('modules/field/modules/text/text.test','a1e5cb0fa8c0651c68d560d9bb7781463a84200f701b00b6e797a9ca792a7e42');
INSERT INTO `registry_file` VALUES ('modules/field/tests/field.test','73bc91bbb405f25021340c887f218ea3d1b38473599c234e4c90454e08db63e9');
INSERT INTO `registry_file` VALUES ('modules/field_ui/field_ui.test','da42e28d6f32d447b4a6e5b463a2f7d87d6ce32f149de04a98fa8e3f286c9f68');
INSERT INTO `registry_file` VALUES ('modules/file/tests/file.test','ca4f55f72e76eb1d8a5016f02b3ce3c67efbb3b49646d70ad0ff2248d6f77c38');
INSERT INTO `registry_file` VALUES ('modules/filter/filter.test','184fa79a4802b3903844d35a63fd065ba3d8d025ba39a70cf3ff0ac1ef108bb4');
INSERT INTO `registry_file` VALUES ('modules/help/help.test','bc934de8c71bd9874a05ccb5e8f927f4c227b3b2397d739e8504c8fd6ae5a83c');
INSERT INTO `registry_file` VALUES ('modules/image/image.test','9c064ef1b09c6e67f4a038d0511cba1cc784df280ada8f89d81eda2ecf214b11');
INSERT INTO `registry_file` VALUES ('modules/menu/menu.test','22a7d2b0e4819a670521c562fa868732b485dff2b58beca1896466ad62bffe44');
INSERT INTO `registry_file` VALUES ('modules/node/node.module','24bd6dbfa9fd1046baacc4590e9e18622b844278c10b4a1919902299325d09ee');
INSERT INTO `registry_file` VALUES ('modules/node/node.test','02eaf0f65000e2ed0d727ae8880d2e7d9ff8ba5e43ed605650770a75504ee04d');
INSERT INTO `registry_file` VALUES ('modules/path/path.test','2004183b2c7c86028bf78c519c6a7afc4397a8267874462b0c2b49b0f8c20322');
INSERT INTO `registry_file` VALUES ('modules/rdf/rdf.test','d586b165925f65c98adcc0ad1eb24b05e2803ea92f1acca351b3ce2dc8932f43');
INSERT INTO `registry_file` VALUES ('modules/search/search.extender.inc','fea036745113dca3fea52ba956af605c4789f4acfa2ab1650a5843c6e173d7fe');
INSERT INTO `registry_file` VALUES ('modules/search/search.test','765220b310a8c20cdae1a0cb32405de5f3474b65ba5a2ceccd035f7fa1b828ba');
INSERT INTO `registry_file` VALUES ('modules/shortcut/shortcut.test','0d78280d4d0a05aa772218e45911552e39611ca9c258b9dd436307914ac3f254');
INSERT INTO `registry_file` VALUES ('modules/system/system.archiver.inc','faa849f3e646a910ab82fd6c8bbf0a4e6b8c60725d7ba81ec0556bd716616cd1');
INSERT INTO `registry_file` VALUES ('modules/system/system.mail.inc','3c2c06b55bded609e72add89db41af3bb405d42b9553793acba5fe51be8861d8');
INSERT INTO `registry_file` VALUES ('modules/system/system.queue.inc','ef00fd41ca86de386fa134d5bc1d816f9af550cf0e1334a5c0ade3119688ca3c');
INSERT INTO `registry_file` VALUES ('modules/system/system.tar.inc','8a31d91f7b3cd7eac25b3fa46e1ed9a8527c39718ba76c3f8c0bbbeaa3aa4086');
INSERT INTO `registry_file` VALUES ('modules/system/system.test','459ab9edeb638b76a35a5a751b517844d2f380724de8e469e43fc59599e53ddc');
INSERT INTO `registry_file` VALUES ('modules/system/system.updater.inc','338cf14cb691ba16ee551b3b9e0fa4f579a2f25c964130658236726d17563b6a');
INSERT INTO `registry_file` VALUES ('modules/taxonomy/taxonomy.module','037a417dd82a22b6e6ac6bf2bc1f724e7f744ade8c9a25ffd277535e9677525f');
INSERT INTO `registry_file` VALUES ('modules/taxonomy/taxonomy.test','966f863d207701e81f8166f726546ef8627b9dff7612c80cdca79b1a1a33620c');
INSERT INTO `registry_file` VALUES ('modules/update/update.test','1ea3e22bd4d47afb8b2799057cdbdfbb57ce09013d9d5f2de7e61ef9c2ebc72d');
INSERT INTO `registry_file` VALUES ('modules/user/user.module','bb7081d863fc9e05c1417344482a661ad68d9ea674c5cf4afc609c0de94c2add');
INSERT INTO `registry_file` VALUES ('modules/user/user.test','e65ff6ba03c4b4afbc9a5e13a1b980749c1e711e7d9aa1052b5a6e534d68a47e');
/*!40000 ALTER TABLE `registry_file` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `rid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique role ID.',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT 'Unique role name.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this role in listings and the user interface.',
  PRIMARY KEY (`rid`),
  UNIQUE KEY `name` (`name`),
  KEY `name_weight` (`name`,`weight`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Stores user roles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--
-- ORDER BY:  `rid`

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `role` VALUES (1,'anonymous user',0);
INSERT INTO `role` VALUES (2,'authenticated user',1);
INSERT INTO `role` VALUES (3,'administrator',2);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `role_permission`
--

DROP TABLE IF EXISTS `role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_permission` (
  `rid` int(10) unsigned NOT NULL COMMENT 'Foreign Key: role.rid.',
  `permission` varchar(128) NOT NULL DEFAULT '' COMMENT 'A single permission granted to the role identified by rid.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module declaring the permission.',
  PRIMARY KEY (`rid`,`permission`),
  KEY `permission` (`permission`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the permissions assigned to user roles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permission`
--
-- ORDER BY:  `rid`,`permission`

LOCK TABLES `role_permission` WRITE;
/*!40000 ALTER TABLE `role_permission` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `role_permission` VALUES (1,'access comments','comment');
INSERT INTO `role_permission` VALUES (1,'access content','node');
INSERT INTO `role_permission` VALUES (1,'use text format filtered_html','filter');
INSERT INTO `role_permission` VALUES (2,'access comments','comment');
INSERT INTO `role_permission` VALUES (2,'access content','node');
INSERT INTO `role_permission` VALUES (2,'post comments','comment');
INSERT INTO `role_permission` VALUES (2,'skip comment approval','comment');
INSERT INTO `role_permission` VALUES (2,'use text format filtered_html','filter');
INSERT INTO `role_permission` VALUES (3,'access administration pages','system');
INSERT INTO `role_permission` VALUES (3,'access comments','comment');
INSERT INTO `role_permission` VALUES (3,'access content','node');
INSERT INTO `role_permission` VALUES (3,'access content overview','node');
INSERT INTO `role_permission` VALUES (3,'access contextual links','contextual');
INSERT INTO `role_permission` VALUES (3,'access dashboard','dashboard');
INSERT INTO `role_permission` VALUES (3,'access overlay','overlay');
INSERT INTO `role_permission` VALUES (3,'access site in maintenance mode','system');
INSERT INTO `role_permission` VALUES (3,'access site reports','system');
INSERT INTO `role_permission` VALUES (3,'access toolbar','toolbar');
INSERT INTO `role_permission` VALUES (3,'access user profiles','user');
INSERT INTO `role_permission` VALUES (3,'administer actions','system');
INSERT INTO `role_permission` VALUES (3,'administer blocks','block');
INSERT INTO `role_permission` VALUES (3,'administer comments','comment');
INSERT INTO `role_permission` VALUES (3,'administer content types','node');
INSERT INTO `role_permission` VALUES (3,'administer filters','filter');
INSERT INTO `role_permission` VALUES (3,'administer image styles','image');
INSERT INTO `role_permission` VALUES (3,'administer menu','menu');
INSERT INTO `role_permission` VALUES (3,'administer modules','system');
INSERT INTO `role_permission` VALUES (3,'administer nodes','node');
INSERT INTO `role_permission` VALUES (3,'administer permissions','user');
INSERT INTO `role_permission` VALUES (3,'administer search','search');
INSERT INTO `role_permission` VALUES (3,'administer shortcuts','shortcut');
INSERT INTO `role_permission` VALUES (3,'administer site configuration','system');
INSERT INTO `role_permission` VALUES (3,'administer software updates','system');
INSERT INTO `role_permission` VALUES (3,'administer taxonomy','taxonomy');
INSERT INTO `role_permission` VALUES (3,'administer themes','system');
INSERT INTO `role_permission` VALUES (3,'administer url aliases','path');
INSERT INTO `role_permission` VALUES (3,'administer users','user');
INSERT INTO `role_permission` VALUES (3,'block IP addresses','system');
INSERT INTO `role_permission` VALUES (3,'bypass node access','node');
INSERT INTO `role_permission` VALUES (3,'cancel account','user');
INSERT INTO `role_permission` VALUES (3,'change own username','user');
INSERT INTO `role_permission` VALUES (3,'create article content','node');
INSERT INTO `role_permission` VALUES (3,'create page content','node');
INSERT INTO `role_permission` VALUES (3,'create url aliases','path');
INSERT INTO `role_permission` VALUES (3,'customize shortcut links','shortcut');
INSERT INTO `role_permission` VALUES (3,'delete any article content','node');
INSERT INTO `role_permission` VALUES (3,'delete any page content','node');
INSERT INTO `role_permission` VALUES (3,'delete own article content','node');
INSERT INTO `role_permission` VALUES (3,'delete own page content','node');
INSERT INTO `role_permission` VALUES (3,'delete revisions','node');
INSERT INTO `role_permission` VALUES (3,'delete terms in 1','taxonomy');
INSERT INTO `role_permission` VALUES (3,'edit any article content','node');
INSERT INTO `role_permission` VALUES (3,'edit any page content','node');
INSERT INTO `role_permission` VALUES (3,'edit own article content','node');
INSERT INTO `role_permission` VALUES (3,'edit own comments','comment');
INSERT INTO `role_permission` VALUES (3,'edit own page content','node');
INSERT INTO `role_permission` VALUES (3,'edit terms in 1','taxonomy');
INSERT INTO `role_permission` VALUES (3,'post comments','comment');
INSERT INTO `role_permission` VALUES (3,'revert revisions','node');
INSERT INTO `role_permission` VALUES (3,'search content','search');
INSERT INTO `role_permission` VALUES (3,'select account cancellation method','user');
INSERT INTO `role_permission` VALUES (3,'skip comment approval','comment');
INSERT INTO `role_permission` VALUES (3,'switch shortcut sets','shortcut');
INSERT INTO `role_permission` VALUES (3,'use advanced search','search');
INSERT INTO `role_permission` VALUES (3,'use text format filtered_html','filter');
INSERT INTO `role_permission` VALUES (3,'use text format full_html','filter');
INSERT INTO `role_permission` VALUES (3,'view own unpublished content','node');
INSERT INTO `role_permission` VALUES (3,'view revisions','node');
INSERT INTO `role_permission` VALUES (3,'view the administration theme','system');
/*!40000 ALTER TABLE `role_permission` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `search_dataset`
--

DROP TABLE IF EXISTS `search_dataset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_dataset` (
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Search item ID, e.g. node ID for nodes.',
  `type` varchar(16) NOT NULL COMMENT 'Type of item, e.g. node.',
  `data` longtext NOT NULL COMMENT 'List of space-separated words from the item.',
  `reindex` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Set to force node reindexing.',
  PRIMARY KEY (`sid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items that will be searched.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_dataset`
--
-- ORDER BY:  `sid`,`type`

LOCK TABLES `search_dataset` WRITE;
/*!40000 ALTER TABLE `search_dataset` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `search_dataset` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `search_index`
--

DROP TABLE IF EXISTS `search_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_index` (
  `word` varchar(50) NOT NULL DEFAULT '' COMMENT 'The search_total.word that is associated with the search item.',
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The search_dataset.sid of the searchable item to which the word belongs.',
  `type` varchar(16) NOT NULL COMMENT 'The search_dataset.type of the searchable item to which the word belongs.',
  `score` float DEFAULT NULL COMMENT 'The numeric score of the word, higher being more important.',
  PRIMARY KEY (`word`,`sid`,`type`),
  KEY `sid_type` (`sid`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the search index, associating words, items and...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_index`
--
-- ORDER BY:  `word`,`sid`,`type`

LOCK TABLES `search_index` WRITE;
/*!40000 ALTER TABLE `search_index` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `search_index` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `search_node_links`
--

DROP TABLE IF EXISTS `search_node_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_node_links` (
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The search_dataset.sid of the searchable item containing the link to the node.',
  `type` varchar(16) NOT NULL DEFAULT '' COMMENT 'The search_dataset.type of the searchable item containing the link to the node.',
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid that this item links to.',
  `caption` longtext COMMENT 'The text used to link to the node.nid.',
  PRIMARY KEY (`sid`,`type`,`nid`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores items (like nodes) that link to other nodes, used...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_node_links`
--
-- ORDER BY:  `sid`,`type`,`nid`

LOCK TABLES `search_node_links` WRITE;
/*!40000 ALTER TABLE `search_node_links` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `search_node_links` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `search_total`
--

DROP TABLE IF EXISTS `search_total`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_total` (
  `word` varchar(50) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique word in the search index.',
  `count` float DEFAULT NULL COMMENT 'The count of the word in the index using Zipf’s law to equalize the probability distribution.',
  PRIMARY KEY (`word`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores search totals for words.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_total`
--
-- ORDER BY:  `word`

LOCK TABLES `search_total` WRITE;
/*!40000 ALTER TABLE `search_total` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `search_total` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `semaphore`
--

DROP TABLE IF EXISTS `semaphore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `semaphore` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique name.',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT 'A value for the semaphore.',
  `expire` double NOT NULL COMMENT 'A Unix timestamp with microseconds indicating when the semaphore should expire.',
  PRIMARY KEY (`name`),
  KEY `value` (`value`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table for holding semaphores, locks, flags, etc. that...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semaphore`
--
-- ORDER BY:  `name`

LOCK TABLES `semaphore` WRITE;
/*!40000 ALTER TABLE `semaphore` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `semaphore` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequences` (
  `value` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The value of the sequence.',
  PRIMARY KEY (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Stores IDs.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sequences`
--
-- ORDER BY:  `value`

LOCK TABLES `sequences` WRITE;
/*!40000 ALTER TABLE `sequences` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sequences` VALUES (1);
/*!40000 ALTER TABLE `sequences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `uid` int(10) unsigned NOT NULL COMMENT 'The users.uid corresponding to a session, or 0 for anonymous user.',
  `sid` varchar(128) NOT NULL COMMENT 'A session ID. The value is generated by Drupal’s session handlers.',
  `ssid` varchar(128) NOT NULL DEFAULT '' COMMENT 'Secure session ID. The value is generated by Drupal’s session handlers.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The IP address that last used this session ID (sid).',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when this session last requested a page. Old records are purged by PHP automatically.',
  `cache` int(11) NOT NULL DEFAULT '0' COMMENT 'The time of this user’s last post. This is used when the site has specified a minimum_cache_lifetime. See cache_get().',
  `session` longblob COMMENT 'The serialized contents of $_SESSION, an array of name/value pairs that persists across page requests by this session ID. Drupal loads $_SESSION from here at the start of each request and saves it at the end.',
  PRIMARY KEY (`sid`,`ssid`),
  KEY `timestamp` (`timestamp`),
  KEY `uid` (`uid`),
  KEY `ssid` (`ssid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Drupal’s session handlers read and write into the...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--
-- ORDER BY:  `sid`,`ssid`

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `shortcut_set`
--

DROP TABLE IF EXISTS `shortcut_set`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shortcut_set` (
  `set_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: The menu_links.menu_name under which the set’s links are stored.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of the set.',
  PRIMARY KEY (`set_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about sets of shortcuts links.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shortcut_set`
--
-- ORDER BY:  `set_name`

LOCK TABLES `shortcut_set` WRITE;
/*!40000 ALTER TABLE `shortcut_set` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `shortcut_set` VALUES ('shortcut-set-1','Default');
/*!40000 ALTER TABLE `shortcut_set` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `shortcut_set_users`
--

DROP TABLE IF EXISTS `shortcut_set_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shortcut_set_users` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The users.uid for this set.',
  `set_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The shortcut_set.set_name that will be displayed for this user.',
  PRIMARY KEY (`uid`),
  KEY `set_name` (`set_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to shortcut sets.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shortcut_set_users`
--
-- ORDER BY:  `uid`

LOCK TABLES `shortcut_set_users` WRITE;
/*!40000 ALTER TABLE `shortcut_set_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `shortcut_set_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `system`
--

DROP TABLE IF EXISTS `system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system` (
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'The path of the primary file for this item, relative to the Drupal root; e.g. modules/node/node.module.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the item; e.g. node.',
  `type` varchar(12) NOT NULL DEFAULT '' COMMENT 'The type of the item, either module, theme, or theme_engine.',
  `owner` varchar(255) NOT NULL DEFAULT '' COMMENT 'A theme’s ’parent’ . Can be either a theme or an engine.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether or not this item is enabled.',
  `bootstrap` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether this module is loaded during Drupal’s early bootstrapping phase (e.g. even before the page cache is consulted).',
  `schema_version` smallint(6) NOT NULL DEFAULT '-1' COMMENT 'The module’s database schema version number. -1 if the module is not installed (its tables do not exist); 0 or the largest N of the module’s hook_update_N() function that has either been run or existed when the module was first installed.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The order in which this module’s hooks should be invoked relative to other modules. Equal-weighted modules are ordered by name.',
  `info` blob COMMENT 'A serialized array containing information from the module’s .info file; keys can include name, description, package, version, core, dependencies, and php.',
  PRIMARY KEY (`filename`),
  KEY `system_list` (`status`,`bootstrap`,`type`,`weight`,`name`),
  KEY `type_name` (`type`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A list of all modules, themes, and theme engines that are...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system`
--
-- ORDER BY:  `filename`

LOCK TABLES `system` WRITE;
/*!40000 ALTER TABLE `system` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `system` VALUES ('modules/aggregator/aggregator.module','aggregator','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:10:\"Aggregator\";s:11:\"description\";s:57:\"Aggregates syndicated content (RSS, RDF, and Atom feeds).\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:15:\"aggregator.test\";}s:9:\"configure\";s:41:\"admin/config/services/aggregator/settings\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:14:\"aggregator.css\";s:33:\"modules/aggregator/aggregator.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/aggregator/tests/aggregator_test.module','aggregator_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:23:\"Aggregator module tests\";s:11:\"description\";s:46:\"Support module for aggregator related testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/block/block.module','block','module','',1,0,7008,-5,'a:12:{s:4:\"name\";s:5:\"Block\";s:11:\"description\";s:140:\"Controls the visual building blocks a page is constructed with. Blocks are boxes of content rendered into an area, or region, of a web page.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:10:\"block.test\";}s:9:\"configure\";s:21:\"admin/structure/block\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/block/tests/block_test.module','block_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:10:\"Block test\";s:11:\"description\";s:21:\"Provides test blocks.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/blog/blog.module','blog','module','',0,0,-1,0,'a:11:{s:4:\"name\";s:4:\"Blog\";s:11:\"description\";s:25:\"Enables multi-user blogs.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"blog.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/book/book.module','book','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:4:\"Book\";s:11:\"description\";s:66:\"Allows users to create and organize related content in an outline.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"book.test\";}s:9:\"configure\";s:27:\"admin/content/book/settings\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:8:\"book.css\";s:21:\"modules/book/book.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/color/color.module','color','module','',1,0,7001,0,'a:11:{s:4:\"name\";s:5:\"Color\";s:11:\"description\";s:70:\"Allows administrators to change the color scheme of compatible themes.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:10:\"color.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/comment/comment.module','comment','module','',1,0,7009,0,'a:13:{s:4:\"name\";s:7:\"Comment\";s:11:\"description\";s:57:\"Allows users to comment on and discuss published content.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:4:\"text\";}s:5:\"files\";a:2:{i:0;s:14:\"comment.module\";i:1;s:12:\"comment.test\";}s:9:\"configure\";s:21:\"admin/content/comment\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:11:\"comment.css\";s:27:\"modules/comment/comment.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/contact/contact.module','contact','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:7:\"Contact\";s:11:\"description\";s:61:\"Enables the use of both personal and site-wide contact forms.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:12:\"contact.test\";}s:9:\"configure\";s:23:\"admin/structure/contact\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/contextual/contextual.module','contextual','module','',1,0,0,0,'a:11:{s:4:\"name\";s:16:\"Contextual links\";s:11:\"description\";s:75:\"Provides contextual links to perform actions related to elements on a page.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:15:\"contextual.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/dashboard/dashboard.module','dashboard','module','',1,0,0,0,'a:12:{s:4:\"name\";s:9:\"Dashboard\";s:11:\"description\";s:136:\"Provides a dashboard page in the administrative interface for organizing administrative tasks and tracking information within your site.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:5:\"files\";a:1:{i:0;s:14:\"dashboard.test\";}s:12:\"dependencies\";a:1:{i:0;s:5:\"block\";}s:9:\"configure\";s:25:\"admin/dashboard/customize\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/dblog/dblog.module','dblog','module','',1,1,7002,0,'a:11:{s:4:\"name\";s:16:\"Database logging\";s:11:\"description\";s:47:\"Logs and records system events to the database.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:10:\"dblog.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/field/field.module','field','module','',1,0,7003,0,'a:13:{s:4:\"name\";s:5:\"Field\";s:11:\"description\";s:57:\"Field API to add fields to entities like nodes and users.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:4:{i:0;s:12:\"field.module\";i:1;s:16:\"field.attach.inc\";i:2;s:20:\"field.info.class.inc\";i:3;s:16:\"tests/field.test\";}s:12:\"dependencies\";a:1:{i:0;s:17:\"field_sql_storage\";}s:8:\"required\";b:1;s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:15:\"theme/field.css\";s:29:\"modules/field/theme/field.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/field/modules/field_sql_storage/field_sql_storage.module','field_sql_storage','module','',1,0,7002,0,'a:12:{s:4:\"name\";s:17:\"Field SQL storage\";s:11:\"description\";s:37:\"Stores field data in an SQL database.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:22:\"field_sql_storage.test\";}s:8:\"required\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/field/modules/list/list.module','list','module','',1,0,7002,0,'a:11:{s:4:\"name\";s:4:\"List\";s:11:\"description\";s:69:\"Defines list field types. Use with Options to create selection lists.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:2:{i:0;s:5:\"field\";i:1;s:7:\"options\";}s:5:\"files\";a:1:{i:0;s:15:\"tests/list.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/field/modules/list/tests/list_test.module','list_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:9:\"List test\";s:11:\"description\";s:41:\"Support module for the List module tests.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/field/modules/number/number.module','number','module','',1,0,0,0,'a:11:{s:4:\"name\";s:6:\"Number\";s:11:\"description\";s:28:\"Defines numeric field types.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:11:\"number.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/field/modules/options/options.module','options','module','',1,0,0,0,'a:11:{s:4:\"name\";s:7:\"Options\";s:11:\"description\";s:82:\"Defines selection, check box and radio button widgets for text and numeric fields.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:12:\"options.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/field/modules/text/text.module','text','module','',1,0,7000,0,'a:13:{s:4:\"name\";s:4:\"Text\";s:11:\"description\";s:32:\"Defines simple text field types.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:9:\"text.test\";}s:8:\"required\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;s:11:\"explanation\";s:73:\"Field type(s) in use - see <a href=\"/admin/reports/fields\">Field list</a>\";}');
INSERT INTO `system` VALUES ('modules/field/tests/field_test.module','field_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:14:\"Field API Test\";s:11:\"description\";s:39:\"Support module for the Field API tests.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:5:\"files\";a:1:{i:0;s:21:\"field_test.entity.inc\";}s:7:\"version\";s:4:\"7.23\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/field_ui/field_ui.module','field_ui','module','',1,0,0,0,'a:11:{s:4:\"name\";s:8:\"Field UI\";s:11:\"description\";s:33:\"User interface for the Field API.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:13:\"field_ui.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/file/file.module','file','module','',1,0,0,0,'a:11:{s:4:\"name\";s:4:\"File\";s:11:\"description\";s:26:\"Defines a file field type.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:5:\"field\";}s:5:\"files\";a:1:{i:0;s:15:\"tests/file.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/file/tests/file_module_test.module','file_module_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:9:\"File test\";s:11:\"description\";s:53:\"Provides hooks for testing File module functionality.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/filter/filter.module','filter','module','',1,0,7010,0,'a:13:{s:4:\"name\";s:6:\"Filter\";s:11:\"description\";s:43:\"Filters content in preparation for display.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:11:\"filter.test\";}s:8:\"required\";b:1;s:9:\"configure\";s:28:\"admin/config/content/formats\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/forum/forum.module','forum','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:5:\"Forum\";s:11:\"description\";s:27:\"Provides discussion forums.\";s:12:\"dependencies\";a:2:{i:0;s:8:\"taxonomy\";i:1;s:7:\"comment\";}s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:10:\"forum.test\";}s:9:\"configure\";s:21:\"admin/structure/forum\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:9:\"forum.css\";s:23:\"modules/forum/forum.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/help/help.module','help','module','',1,0,0,0,'a:11:{s:4:\"name\";s:4:\"Help\";s:11:\"description\";s:35:\"Manages the display of online help.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"help.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/image/image.module','image','module','',1,0,7005,0,'a:14:{s:4:\"name\";s:5:\"Image\";s:11:\"description\";s:34:\"Provides image manipulation tools.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:4:\"file\";}s:5:\"files\";a:1:{i:0;s:10:\"image.test\";}s:9:\"configure\";s:31:\"admin/config/media/image-styles\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;s:8:\"required\";b:1;s:11:\"explanation\";s:73:\"Field type(s) in use - see <a href=\"/admin/reports/fields\">Field list</a>\";}');
INSERT INTO `system` VALUES ('modules/image/tests/image_module_test.module','image_module_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:10:\"Image test\";s:11:\"description\";s:69:\"Provides hook implementations for testing Image module functionality.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:24:\"image_module_test.module\";}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/locale/locale.module','locale','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:6:\"Locale\";s:11:\"description\";s:119:\"Adds language handling functionality and enables the translation of the user interface to languages other than English.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:11:\"locale.test\";}s:9:\"configure\";s:30:\"admin/config/regional/language\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/locale/tests/locale_test.module','locale_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:11:\"Locale Test\";s:11:\"description\";s:42:\"Support module for the locale layer tests.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/menu/menu.module','menu','module','',1,0,7003,0,'a:12:{s:4:\"name\";s:4:\"Menu\";s:11:\"description\";s:60:\"Allows administrators to customize the site navigation menu.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"menu.test\";}s:9:\"configure\";s:20:\"admin/structure/menu\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/node/node.module','node','module','',1,0,7013,0,'a:14:{s:4:\"name\";s:4:\"Node\";s:11:\"description\";s:66:\"Allows content to be submitted to the site and displayed on pages.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:2:{i:0;s:11:\"node.module\";i:1;s:9:\"node.test\";}s:8:\"required\";b:1;s:9:\"configure\";s:21:\"admin/structure/types\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:8:\"node.css\";s:21:\"modules/node/node.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/node/tests/node_access_test.module','node_access_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:24:\"Node module access tests\";s:11:\"description\";s:43:\"Support module for node permission testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/node/tests/node_test.module','node_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:17:\"Node module tests\";s:11:\"description\";s:40:\"Support module for node related testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/node/tests/node_test_exception.module','node_test_exception','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:27:\"Node module exception tests\";s:11:\"description\";s:50:\"Support module for node related exception testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/openid/openid.module','openid','module','',0,0,-1,0,'a:11:{s:4:\"name\";s:6:\"OpenID\";s:11:\"description\";s:48:\"Allows users to log into your site using OpenID.\";s:7:\"version\";s:4:\"7.23\";s:7:\"package\";s:4:\"Core\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:11:\"openid.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/openid/tests/openid_test.module','openid_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:21:\"OpenID dummy provider\";s:11:\"description\";s:33:\"OpenID provider used for testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:6:\"openid\";}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/overlay/overlay.module','overlay','module','',1,1,0,0,'a:11:{s:4:\"name\";s:7:\"Overlay\";s:11:\"description\";s:59:\"Displays the Drupal administration interface in an overlay.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/path/path.module','path','module','',1,0,0,0,'a:12:{s:4:\"name\";s:4:\"Path\";s:11:\"description\";s:28:\"Allows users to rename URLs.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"path.test\";}s:9:\"configure\";s:24:\"admin/config/search/path\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/php/php.module','php','module','',0,0,-1,0,'a:11:{s:4:\"name\";s:10:\"PHP filter\";s:11:\"description\";s:50:\"Allows embedded PHP code/snippets to be evaluated.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:8:\"php.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/poll/poll.module','poll','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:4:\"Poll\";s:11:\"description\";s:95:\"Allows your site to capture votes on different topics in the form of multiple choice questions.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:9:\"poll.test\";}s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:8:\"poll.css\";s:21:\"modules/poll/poll.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/profile/profile.module','profile','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:7:\"Profile\";s:11:\"description\";s:36:\"Supports configurable user profiles.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:12:\"profile.test\";}s:9:\"configure\";s:27:\"admin/config/people/profile\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/rdf/rdf.module','rdf','module','',1,0,0,0,'a:11:{s:4:\"name\";s:3:\"RDF\";s:11:\"description\";s:148:\"Enriches your content with metadata to let other applications (e.g. search engines, aggregators) better understand its relationships and attributes.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:8:\"rdf.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/rdf/tests/rdf_test.module','rdf_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:16:\"RDF module tests\";s:11:\"description\";s:38:\"Support module for RDF module testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/search/search.module','search','module','',1,0,7000,0,'a:13:{s:4:\"name\";s:6:\"Search\";s:11:\"description\";s:36:\"Enables site-wide keyword searching.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:2:{i:0;s:19:\"search.extender.inc\";i:1;s:11:\"search.test\";}s:9:\"configure\";s:28:\"admin/config/search/settings\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"search.css\";s:25:\"modules/search/search.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/search/tests/search_embedded_form.module','search_embedded_form','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:20:\"Search embedded form\";s:11:\"description\";s:59:\"Support module for search module testing of embedded forms.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/search/tests/search_extra_type.module','search_extra_type','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:16:\"Test search type\";s:11:\"description\";s:41:\"Support module for search module testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/shortcut/shortcut.module','shortcut','module','',1,0,0,0,'a:12:{s:4:\"name\";s:8:\"Shortcut\";s:11:\"description\";s:60:\"Allows users to manage customizable lists of shortcut links.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:13:\"shortcut.test\";}s:9:\"configure\";s:36:\"admin/config/user-interface/shortcut\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/simpletest.module','simpletest','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:7:\"Testing\";s:11:\"description\";s:53:\"Provides a framework for unit and functional testing.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:48:{i:0;s:15:\"simpletest.test\";i:1;s:24:\"drupal_web_test_case.php\";i:2;s:18:\"tests/actions.test\";i:3;s:15:\"tests/ajax.test\";i:4;s:16:\"tests/batch.test\";i:5;s:20:\"tests/bootstrap.test\";i:6;s:16:\"tests/cache.test\";i:7;s:17:\"tests/common.test\";i:8;s:24:\"tests/database_test.test\";i:9;s:32:\"tests/entity_crud_hook_test.test\";i:10;s:23:\"tests/entity_query.test\";i:11;s:16:\"tests/error.test\";i:12;s:15:\"tests/file.test\";i:13;s:23:\"tests/filetransfer.test\";i:14;s:15:\"tests/form.test\";i:15;s:16:\"tests/graph.test\";i:16;s:16:\"tests/image.test\";i:17;s:15:\"tests/lock.test\";i:18;s:15:\"tests/mail.test\";i:19;s:15:\"tests/menu.test\";i:20;s:17:\"tests/module.test\";i:21;s:16:\"tests/pager.test\";i:22;s:19:\"tests/password.test\";i:23;s:15:\"tests/path.test\";i:24;s:19:\"tests/registry.test\";i:25;s:17:\"tests/schema.test\";i:26;s:18:\"tests/session.test\";i:27;s:20:\"tests/tablesort.test\";i:28;s:16:\"tests/theme.test\";i:29;s:18:\"tests/unicode.test\";i:30;s:17:\"tests/update.test\";i:31;s:17:\"tests/xmlrpc.test\";i:32;s:26:\"tests/upgrade/upgrade.test\";i:33;s:34:\"tests/upgrade/upgrade.comment.test\";i:34;s:33:\"tests/upgrade/upgrade.filter.test\";i:35;s:32:\"tests/upgrade/upgrade.forum.test\";i:36;s:33:\"tests/upgrade/upgrade.locale.test\";i:37;s:31:\"tests/upgrade/upgrade.menu.test\";i:38;s:31:\"tests/upgrade/upgrade.node.test\";i:39;s:35:\"tests/upgrade/upgrade.taxonomy.test\";i:40;s:34:\"tests/upgrade/upgrade.trigger.test\";i:41;s:39:\"tests/upgrade/upgrade.translatable.test\";i:42;s:33:\"tests/upgrade/upgrade.upload.test\";i:43;s:31:\"tests/upgrade/upgrade.user.test\";i:44;s:36:\"tests/upgrade/update.aggregator.test\";i:45;s:33:\"tests/upgrade/update.trigger.test\";i:46;s:31:\"tests/upgrade/update.field.test\";i:47;s:30:\"tests/upgrade/update.user.test\";}s:9:\"configure\";s:41:\"admin/config/development/testing/settings\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/actions_loop_test.module','actions_loop_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:17:\"Actions loop test\";s:11:\"description\";s:39:\"Support module for action loop testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/ajax_forms_test.module','ajax_forms_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:26:\"AJAX form test mock module\";s:11:\"description\";s:25:\"Test for AJAX form calls.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/ajax_test.module','ajax_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:9:\"AJAX Test\";s:11:\"description\";s:40:\"Support module for AJAX framework tests.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/batch_test.module','batch_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:14:\"Batch API test\";s:11:\"description\";s:35:\"Support module for Batch API tests.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/common_test.module','common_test','module','',0,0,-1,0,'a:13:{s:4:\"name\";s:11:\"Common Test\";s:11:\"description\";s:32:\"Support module for Common tests.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:15:\"common_test.css\";s:40:\"modules/simpletest/tests/common_test.css\";}s:5:\"print\";a:1:{s:21:\"common_test.print.css\";s:46:\"modules/simpletest/tests/common_test.print.css\";}}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/common_test_cron_helper.module','common_test_cron_helper','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:23:\"Common Test Cron Helper\";s:11:\"description\";s:56:\"Helper module for CronRunTestCase::testCronExceptions().\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/database_test.module','database_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:13:\"Database Test\";s:11:\"description\";s:40:\"Support module for Database layer tests.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/drupal_system_listing_compatible_test/drupal_system_listing_compatible_test.module','drupal_system_listing_compatible_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:37:\"Drupal system listing compatible test\";s:11:\"description\";s:62:\"Support module for testing the drupal_system_listing function.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/drupal_system_listing_incompatible_test/drupal_system_listing_incompatible_test.module','drupal_system_listing_incompatible_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:39:\"Drupal system listing incompatible test\";s:11:\"description\";s:62:\"Support module for testing the drupal_system_listing function.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/entity_cache_test.module','entity_cache_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:17:\"Entity cache test\";s:11:\"description\";s:40:\"Support module for testing entity cache.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:28:\"entity_cache_test_dependency\";}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/entity_cache_test_dependency.module','entity_cache_test_dependency','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:28:\"Entity cache test dependency\";s:11:\"description\";s:51:\"Support dependency module for testing entity cache.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/entity_crud_hook_test.module','entity_crud_hook_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:22:\"Entity CRUD Hooks Test\";s:11:\"description\";s:35:\"Support module for CRUD hook tests.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/entity_query_access_test.module','entity_query_access_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:24:\"Entity query access test\";s:11:\"description\";s:49:\"Support module for checking entity query results.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/error_test.module','error_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:10:\"Error test\";s:11:\"description\";s:47:\"Support module for error and exception testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/file_test.module','file_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:9:\"File test\";s:11:\"description\";s:39:\"Support module for file handling tests.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:16:\"file_test.module\";}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/filter_test.module','filter_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:18:\"Filter test module\";s:11:\"description\";s:33:\"Tests filter hooks and functions.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/form_test.module','form_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:12:\"FormAPI Test\";s:11:\"description\";s:34:\"Support module for Form API tests.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/image_test.module','image_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:10:\"Image test\";s:11:\"description\";s:39:\"Support module for image toolkit tests.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/menu_test.module','menu_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:15:\"Hook menu tests\";s:11:\"description\";s:37:\"Support module for menu hook testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/module_test.module','module_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:11:\"Module test\";s:11:\"description\";s:41:\"Support module for module system testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/path_test.module','path_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:15:\"Hook path tests\";s:11:\"description\";s:37:\"Support module for path hook testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/psr_0_test/psr_0_test.module','psr_0_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:16:\"PSR-0 Test cases\";s:11:\"description\";s:44:\"Test classes to be discovered by simpletest.\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/requirements1_test.module','requirements1_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:19:\"Requirements 1 Test\";s:11:\"description\";s:80:\"Tests that a module is not installed when it fails hook_requirements(\'install\').\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/requirements2_test.module','requirements2_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:19:\"Requirements 2 Test\";s:11:\"description\";s:98:\"Tests that a module is not installed when the one it depends on fails hook_requirements(\'install).\";s:12:\"dependencies\";a:2:{i:0;s:18:\"requirements1_test\";i:1;s:7:\"comment\";}s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/session_test.module','session_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:12:\"Session test\";s:11:\"description\";s:40:\"Support module for session data testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/system_dependencies_test.module','system_dependencies_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:22:\"System dependency test\";s:11:\"description\";s:47:\"Support module for testing system dependencies.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:12:\"dependencies\";a:1:{i:0;s:19:\"_missing_dependency\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/system_incompatible_core_version_dependencies_test.module','system_incompatible_core_version_dependencies_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:50:\"System incompatible core version dependencies test\";s:11:\"description\";s:47:\"Support module for testing system dependencies.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:12:\"dependencies\";a:1:{i:0;s:37:\"system_incompatible_core_version_test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/system_incompatible_core_version_test.module','system_incompatible_core_version_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:37:\"System incompatible core version test\";s:11:\"description\";s:47:\"Support module for testing system dependencies.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"5.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/system_incompatible_module_version_dependencies_test.module','system_incompatible_module_version_dependencies_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:52:\"System incompatible module version dependencies test\";s:11:\"description\";s:47:\"Support module for testing system dependencies.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:12:\"dependencies\";a:1:{i:0;s:46:\"system_incompatible_module_version_test (>2.0)\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/system_incompatible_module_version_test.module','system_incompatible_module_version_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:39:\"System incompatible module version test\";s:11:\"description\";s:47:\"Support module for testing system dependencies.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/system_test.module','system_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:11:\"System test\";s:11:\"description\";s:34:\"Support module for system testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:18:\"system_test.module\";}s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/taxonomy_test.module','taxonomy_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:20:\"Taxonomy test module\";s:11:\"description\";s:45:\"\"Tests functions and hooks not used in core\".\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:12:\"dependencies\";a:1:{i:0;s:8:\"taxonomy\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/theme_test.module','theme_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:10:\"Theme test\";s:11:\"description\";s:40:\"Support module for theme system testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/update_script_test.module','update_script_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:18:\"Update script test\";s:11:\"description\";s:41:\"Support module for update script testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/update_test_1.module','update_test_1','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:11:\"Update test\";s:11:\"description\";s:34:\"Support module for update testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/update_test_2.module','update_test_2','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:11:\"Update test\";s:11:\"description\";s:34:\"Support module for update testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/update_test_3.module','update_test_3','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:11:\"Update test\";s:11:\"description\";s:34:\"Support module for update testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/url_alter_test.module','url_alter_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:15:\"Url_alter tests\";s:11:\"description\";s:45:\"A support modules for url_alter hook testing.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/simpletest/tests/xmlrpc_test.module','xmlrpc_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:12:\"XML-RPC Test\";s:11:\"description\";s:75:\"Support module for XML-RPC tests according to the validator1 specification.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/statistics/statistics.module','statistics','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:10:\"Statistics\";s:11:\"description\";s:37:\"Logs access statistics for your site.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:15:\"statistics.test\";}s:9:\"configure\";s:30:\"admin/config/system/statistics\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/syslog/syslog.module','syslog','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:6:\"Syslog\";s:11:\"description\";s:41:\"Logs and records system events to syslog.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:11:\"syslog.test\";}s:9:\"configure\";s:32:\"admin/config/development/logging\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/system/system.module','system','module','',1,1,7078,0,'a:13:{s:4:\"name\";s:6:\"System\";s:11:\"description\";s:54:\"Handles general site configuration for administrators.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:6:{i:0;s:19:\"system.archiver.inc\";i:1;s:15:\"system.mail.inc\";i:2;s:16:\"system.queue.inc\";i:3;s:14:\"system.tar.inc\";i:4;s:18:\"system.updater.inc\";i:5;s:11:\"system.test\";}s:8:\"required\";b:1;s:9:\"configure\";s:19:\"admin/config/system\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/taxonomy/taxonomy.module','taxonomy','module','',1,0,7010,0,'a:14:{s:4:\"name\";s:8:\"Taxonomy\";s:11:\"description\";s:38:\"Enables the categorization of content.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:1:{i:0;s:7:\"options\";}s:5:\"files\";a:2:{i:0;s:15:\"taxonomy.module\";i:1;s:13:\"taxonomy.test\";}s:9:\"configure\";s:24:\"admin/structure/taxonomy\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;s:8:\"required\";b:1;s:11:\"explanation\";s:73:\"Field type(s) in use - see <a href=\"/admin/reports/fields\">Field list</a>\";}');
INSERT INTO `system` VALUES ('modules/toolbar/toolbar.module','toolbar','module','',1,0,0,0,'a:11:{s:4:\"name\";s:7:\"Toolbar\";s:11:\"description\";s:99:\"Provides a toolbar that shows the top-level administration menu items and links from other modules.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/tracker/tracker.module','tracker','module','',0,0,-1,0,'a:11:{s:4:\"name\";s:7:\"Tracker\";s:11:\"description\";s:45:\"Enables tracking of recent content for users.\";s:12:\"dependencies\";a:1:{i:0;s:7:\"comment\";}s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:12:\"tracker.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/translation/tests/translation_test.module','translation_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:24:\"Content Translation Test\";s:11:\"description\";s:49:\"Support module for the content translation tests.\";s:4:\"core\";s:3:\"7.x\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/translation/translation.module','translation','module','',0,0,-1,0,'a:11:{s:4:\"name\";s:19:\"Content translation\";s:11:\"description\";s:57:\"Allows content to be translated into different languages.\";s:12:\"dependencies\";a:1:{i:0;s:6:\"locale\";}s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:16:\"translation.test\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/trigger/tests/trigger_test.module','trigger_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:12:\"Trigger Test\";s:11:\"description\";s:33:\"Support module for Trigger tests.\";s:7:\"package\";s:7:\"Testing\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:4:\"7.23\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/trigger/trigger.module','trigger','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:7:\"Trigger\";s:11:\"description\";s:90:\"Enables actions to be fired on certain system events, such as when new content is created.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:12:\"trigger.test\";}s:9:\"configure\";s:23:\"admin/structure/trigger\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/update/tests/aaa_update_test.module','aaa_update_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:15:\"AAA Update test\";s:11:\"description\";s:41:\"Support module for update module testing.\";s:7:\"package\";s:7:\"Testing\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:4:\"7.23\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/update/tests/bbb_update_test.module','bbb_update_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:15:\"BBB Update test\";s:11:\"description\";s:41:\"Support module for update module testing.\";s:7:\"package\";s:7:\"Testing\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:4:\"7.23\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/update/tests/ccc_update_test.module','ccc_update_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:15:\"CCC Update test\";s:11:\"description\";s:41:\"Support module for update module testing.\";s:7:\"package\";s:7:\"Testing\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"version\";s:4:\"7.23\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/update/tests/update_test.module','update_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:11:\"Update test\";s:11:\"description\";s:41:\"Support module for update module testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/update/update.module','update','module','',1,0,7001,0,'a:12:{s:4:\"name\";s:14:\"Update manager\";s:11:\"description\";s:104:\"Checks for available updates, and can securely install or update modules and themes via a web interface.\";s:7:\"version\";s:4:\"7.23\";s:7:\"package\";s:4:\"Core\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:1:{i:0;s:11:\"update.test\";}s:9:\"configure\";s:30:\"admin/reports/updates/settings\";s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/user/tests/user_form_test.module','user_form_test','module','',0,0,-1,0,'a:12:{s:4:\"name\";s:22:\"User module form tests\";s:11:\"description\";s:37:\"Support module for user form testing.\";s:7:\"package\";s:7:\"Testing\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:6:\"hidden\";b:1;s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('modules/user/user.module','user','module','',1,0,7018,0,'a:14:{s:4:\"name\";s:4:\"User\";s:11:\"description\";s:47:\"Manages the user registration and login system.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:5:\"files\";a:2:{i:0;s:11:\"user.module\";i:1;s:9:\"user.test\";}s:8:\"required\";b:1;s:9:\"configure\";s:19:\"admin/config/people\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:8:\"user.css\";s:21:\"modules/user/user.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:12:\"dependencies\";a:0:{}s:3:\"php\";s:5:\"5.2.4\";s:9:\"bootstrap\";i:0;}');
INSERT INTO `system` VALUES ('profiles/standard/standard.profile','standard','module','',1,0,0,1000,'a:14:{s:4:\"name\";s:8:\"Standard\";s:11:\"description\";s:51:\"Install with commonly used features pre-configured.\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:12:\"dependencies\";a:21:{i:0;s:5:\"block\";i:1;s:5:\"color\";i:2;s:7:\"comment\";i:3;s:10:\"contextual\";i:4;s:9:\"dashboard\";i:5;s:4:\"help\";i:6;s:5:\"image\";i:7;s:4:\"list\";i:8;s:4:\"menu\";i:9;s:6:\"number\";i:10;s:7:\"options\";i:11;s:4:\"path\";i:12;s:8:\"taxonomy\";i:13;s:5:\"dblog\";i:14;s:6:\"search\";i:15;s:8:\"shortcut\";i:16;s:7:\"toolbar\";i:17;s:7:\"overlay\";i:18;s:8:\"field_ui\";i:19;s:4:\"file\";i:20;s:3:\"rdf\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:7:\"package\";s:5:\"Other\";s:3:\"php\";s:5:\"5.2.4\";s:5:\"files\";a:0:{}s:9:\"bootstrap\";i:0;s:6:\"hidden\";b:1;s:8:\"required\";b:1;s:17:\"distribution_name\";s:6:\"Drupal\";}');
INSERT INTO `system` VALUES ('themes/bartik/bartik.info','bartik','theme','themes/engines/phptemplate/phptemplate.engine',1,0,-1,0,'a:18:{s:4:\"name\";s:6:\"Bartik\";s:11:\"description\";s:48:\"A flexible, recolorable theme with many regions.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:3:{s:14:\"css/layout.css\";s:28:\"themes/bartik/css/layout.css\";s:13:\"css/style.css\";s:27:\"themes/bartik/css/style.css\";s:14:\"css/colors.css\";s:28:\"themes/bartik/css/colors.css\";}s:5:\"print\";a:1:{s:13:\"css/print.css\";s:27:\"themes/bartik/css/print.css\";}}s:7:\"regions\";a:20:{s:6:\"header\";s:6:\"Header\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:11:\"highlighted\";s:11:\"Highlighted\";s:8:\"featured\";s:8:\"Featured\";s:7:\"content\";s:7:\"Content\";s:13:\"sidebar_first\";s:13:\"Sidebar first\";s:14:\"sidebar_second\";s:14:\"Sidebar second\";s:14:\"triptych_first\";s:14:\"Triptych first\";s:15:\"triptych_middle\";s:15:\"Triptych middle\";s:13:\"triptych_last\";s:13:\"Triptych last\";s:18:\"footer_firstcolumn\";s:19:\"Footer first column\";s:19:\"footer_secondcolumn\";s:20:\"Footer second column\";s:18:\"footer_thirdcolumn\";s:19:\"Footer third column\";s:19:\"footer_fourthcolumn\";s:20:\"Footer fourth column\";s:6:\"footer\";s:6:\"Footer\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"0\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:28:\"themes/bartik/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}');
INSERT INTO `system` VALUES ('themes/garland/garland.info','garland','theme','themes/engines/phptemplate/phptemplate.engine',0,0,-1,0,'a:18:{s:4:\"name\";s:7:\"Garland\";s:11:\"description\";s:111:\"A multi-column theme which can be configured to modify colors and switch between fixed and fluid width layouts.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:2:{s:3:\"all\";a:1:{s:9:\"style.css\";s:24:\"themes/garland/style.css\";}s:5:\"print\";a:1:{s:9:\"print.css\";s:24:\"themes/garland/print.css\";}}s:8:\"settings\";a:1:{s:13:\"garland_width\";s:5:\"fluid\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:29:\"themes/garland/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}');
INSERT INTO `system` VALUES ('themes/seven/seven.info','seven','theme','themes/engines/phptemplate/phptemplate.engine',1,0,-1,0,'a:18:{s:4:\"name\";s:5:\"Seven\";s:11:\"description\";s:65:\"A simple one-column, tableless, fluid width administration theme.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:6:\"screen\";a:2:{s:9:\"reset.css\";s:22:\"themes/seven/reset.css\";s:9:\"style.css\";s:22:\"themes/seven/style.css\";}}s:8:\"settings\";a:1:{s:20:\"shortcut_module_link\";s:1:\"1\";}s:7:\"regions\";a:8:{s:7:\"content\";s:7:\"Content\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:13:\"sidebar_first\";s:13:\"First sidebar\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:14:\"regions_hidden\";a:3:{i:0;s:13:\"sidebar_first\";i:1;s:8:\"page_top\";i:2;s:11:\"page_bottom\";}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:6:\"engine\";s:11:\"phptemplate\";s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/seven/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}');
INSERT INTO `system` VALUES ('themes/stark/stark.info','stark','theme','themes/engines/phptemplate/phptemplate.engine',0,0,-1,0,'a:17:{s:4:\"name\";s:5:\"Stark\";s:11:\"description\";s:208:\"This theme demonstrates Drupal\'s default HTML markup and CSS styles. To learn how to build your own theme and override Drupal\'s default code, see the <a href=\"http://drupal.org/theme-guide\">Theming Guide</a>.\";s:7:\"package\";s:4:\"Core\";s:7:\"version\";s:4:\"7.23\";s:4:\"core\";s:3:\"7.x\";s:11:\"stylesheets\";a:1:{s:3:\"all\";a:1:{s:10:\"layout.css\";s:23:\"themes/stark/layout.css\";}}s:7:\"project\";s:6:\"drupal\";s:9:\"datestamp\";s:10:\"1375928238\";s:6:\"engine\";s:11:\"phptemplate\";s:7:\"regions\";a:12:{s:13:\"sidebar_first\";s:12:\"Left sidebar\";s:14:\"sidebar_second\";s:13:\"Right sidebar\";s:7:\"content\";s:7:\"Content\";s:6:\"header\";s:6:\"Header\";s:6:\"footer\";s:6:\"Footer\";s:11:\"highlighted\";s:11:\"Highlighted\";s:4:\"help\";s:4:\"Help\";s:8:\"page_top\";s:8:\"Page top\";s:11:\"page_bottom\";s:11:\"Page bottom\";s:14:\"dashboard_main\";s:16:\"Dashboard (main)\";s:17:\"dashboard_sidebar\";s:19:\"Dashboard (sidebar)\";s:18:\"dashboard_inactive\";s:20:\"Dashboard (inactive)\";}s:8:\"features\";a:9:{i:0;s:4:\"logo\";i:1;s:7:\"favicon\";i:2;s:4:\"name\";i:3;s:6:\"slogan\";i:4;s:17:\"node_user_picture\";i:5;s:20:\"comment_user_picture\";i:6;s:25:\"comment_user_verification\";i:7;s:9:\"main_menu\";i:8;s:14:\"secondary_menu\";}s:10:\"screenshot\";s:27:\"themes/stark/screenshot.png\";s:3:\"php\";s:5:\"5.2.4\";s:7:\"scripts\";a:0:{}s:15:\"overlay_regions\";a:5:{i:0;s:14:\"dashboard_main\";i:1;s:17:\"dashboard_sidebar\";i:2;s:18:\"dashboard_inactive\";i:3;s:7:\"content\";i:4;s:4:\"help\";}s:14:\"regions_hidden\";a:2:{i:0;s:8:\"page_top\";i:1;s:11:\"page_bottom\";}s:28:\"overlay_supplemental_regions\";a:1:{i:0;s:8:\"page_top\";}}');
/*!40000 ALTER TABLE `system` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `taxonomy_index`
--

DROP TABLE IF EXISTS `taxonomy_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxonomy_index` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid this record tracks.',
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The term ID.',
  `sticky` tinyint(4) DEFAULT '0' COMMENT 'Boolean indicating whether the node is sticky.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.',
  KEY `term_node` (`tid`,`sticky`,`created`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains denormalized information about node/term...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxonomy_index`
--

LOCK TABLES `taxonomy_index` WRITE;
/*!40000 ALTER TABLE `taxonomy_index` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `taxonomy_index` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `taxonomy_term_data`
--

DROP TABLE IF EXISTS `taxonomy_term_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxonomy_term_data` (
  `tid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique term ID.',
  `vid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The taxonomy_vocabulary.vid of the vocabulary to which the term is assigned.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The term name.',
  `description` longtext COMMENT 'A description of the term.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the description.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this term in relation to other terms.',
  PRIMARY KEY (`tid`),
  KEY `taxonomy_tree` (`vid`,`weight`,`name`),
  KEY `vid_name` (`vid`,`name`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores term information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxonomy_term_data`
--
-- ORDER BY:  `tid`

LOCK TABLES `taxonomy_term_data` WRITE;
/*!40000 ALTER TABLE `taxonomy_term_data` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `taxonomy_term_data` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `taxonomy_term_hierarchy`
--

DROP TABLE IF EXISTS `taxonomy_term_hierarchy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxonomy_term_hierarchy` (
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: The taxonomy_term_data.tid of the term.',
  `parent` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: The taxonomy_term_data.tid of the term’s parent. 0 indicates no parent.',
  PRIMARY KEY (`tid`,`parent`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the hierarchical relationship between terms.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxonomy_term_hierarchy`
--
-- ORDER BY:  `tid`,`parent`

LOCK TABLES `taxonomy_term_hierarchy` WRITE;
/*!40000 ALTER TABLE `taxonomy_term_hierarchy` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `taxonomy_term_hierarchy` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `taxonomy_vocabulary`
--

DROP TABLE IF EXISTS `taxonomy_vocabulary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taxonomy_vocabulary` (
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique vocabulary ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the vocabulary.',
  `machine_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The vocabulary machine name.',
  `description` longtext COMMENT 'Description of the vocabulary.',
  `hierarchy` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The type of hierarchy allowed within the vocabulary. (0 = disabled, 1 = single, 2 = multiple)',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module which created the vocabulary.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this vocabulary in relation to other vocabularies.',
  PRIMARY KEY (`vid`),
  UNIQUE KEY `machine_name` (`machine_name`),
  KEY `list` (`weight`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Stores vocabulary information.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxonomy_vocabulary`
--
-- ORDER BY:  `vid`

LOCK TABLES `taxonomy_vocabulary` WRITE;
/*!40000 ALTER TABLE `taxonomy_vocabulary` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `taxonomy_vocabulary` VALUES (1,'Tags','tags','Use tags to group articles on similar topics into categories.',0,'taxonomy',0);
/*!40000 ALTER TABLE `taxonomy_vocabulary` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `url_alias`
--

DROP TABLE IF EXISTS `url_alias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `url_alias` (
  `pid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'A unique path alias identifier.',
  `source` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path this alias is for; e.g. node/12.',
  `alias` varchar(255) NOT NULL DEFAULT '' COMMENT 'The alias for this path; e.g. title-of-the-story.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The language this alias is for; if ’und’, the alias will be used for unknown languages. Each Drupal path can have an alias for each supported language.',
  PRIMARY KEY (`pid`),
  KEY `alias_language_pid` (`alias`,`language`,`pid`),
  KEY `source_language_pid` (`source`,`language`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='A list of URL aliases for Drupal paths; a user may visit...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `url_alias`
--
-- ORDER BY:  `pid`

LOCK TABLES `url_alias` WRITE;
/*!40000 ALTER TABLE `url_alias` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `url_alias` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique user ID.',
  `name` varchar(60) NOT NULL DEFAULT '' COMMENT 'Unique user name.',
  `pass` varchar(128) NOT NULL DEFAULT '' COMMENT 'User’s password (hashed).',
  `mail` varchar(254) DEFAULT '' COMMENT 'User’s e-mail address.',
  `theme` varchar(255) NOT NULL DEFAULT '' COMMENT 'User’s default theme.',
  `signature` varchar(255) NOT NULL DEFAULT '' COMMENT 'User’s signature.',
  `signature_format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the signature.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for when user was created.',
  `access` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for previous time user accessed the site.',
  `login` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp for user’s last login.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Whether the user is active(1) or blocked(0).',
  `timezone` varchar(32) DEFAULT NULL COMMENT 'User’s time zone.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'User’s default language.',
  `picture` int(11) NOT NULL DEFAULT '0' COMMENT 'Foreign key: file_managed.fid of user’s picture.',
  `init` varchar(254) DEFAULT '' COMMENT 'E-mail address used for initial account creation.',
  `data` longblob COMMENT 'A serialized array of name value pairs that are related to the user. Any form values posted during user edit are stored and are loaded into the $user object during user_load(). Use of this field is discouraged and it will likely disappear in a future...',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `name` (`name`),
  KEY `access` (`access`),
  KEY `created` (`created`),
  KEY `mail` (`mail`),
  KEY `picture` (`picture`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores user data.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--
-- ORDER BY:  `uid`

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `users` VALUES (0,'','','','','',NULL,0,0,0,0,NULL,'',0,'',NULL);
INSERT INTO `users` VALUES (1,'admin@ferrero.com','$S$D3R0sLdkniRIw4uzOlL2FJ0A7kL5WEAv6R3ljTV3kGjBX6Rb6Wue','admin@ferrero.com','','',NULL,1384776245,0,1384776245,1,'Europe/Berlin','',0,'admin@ferrero.com','b:0;');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `users_roles`
--

DROP TABLE IF EXISTS `users_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_roles` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: users.uid for user.',
  `rid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: role.rid for role.',
  PRIMARY KEY (`uid`,`rid`),
  KEY `rid` (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maps users to roles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_roles`
--
-- ORDER BY:  `uid`,`rid`

LOCK TABLES `users_roles` WRITE;
/*!40000 ALTER TABLE `users_roles` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `users_roles` VALUES (1,3);
/*!40000 ALTER TABLE `users_roles` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `variable`
--

DROP TABLE IF EXISTS `variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variable` (
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The name of the variable.',
  `value` longblob NOT NULL COMMENT 'The value of the variable.',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Named variable/value pairs created by Drupal core or any...';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variable`
--
-- ORDER BY:  `name`

LOCK TABLES `variable` WRITE;
/*!40000 ALTER TABLE `variable` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `variable` VALUES ('admin_theme','s:5:\"seven\";');
INSERT INTO `variable` VALUES ('clean_url','b:1;');
INSERT INTO `variable` VALUES ('comment_page','i:0;');
INSERT INTO `variable` VALUES ('cron_key','s:43:\"05QXQAXLesIr7BhN-hr6HZPD-RTxV24hchOY9_zxWFk\";');
INSERT INTO `variable` VALUES ('cron_last','i:1384776245;');
INSERT INTO `variable` VALUES ('css_js_query_string','s:6:\"mwgk8w\";');
INSERT INTO `variable` VALUES ('date_default_timezone','s:13:\"Europe/Berlin\";');
INSERT INTO `variable` VALUES ('drupal_private_key','s:43:\"xCaNJwJoTRwP4ZQSvESbtV3EnxncNWWRZ2MrT-0JAcc\";');
INSERT INTO `variable` VALUES ('file_temporary_path','s:4:\"/tmp\";');
INSERT INTO `variable` VALUES ('filter_fallback_format','s:10:\"plain_text\";');
INSERT INTO `variable` VALUES ('install_profile','s:8:\"standard\";');
INSERT INTO `variable` VALUES ('install_task','s:4:\"done\";');
INSERT INTO `variable` VALUES ('install_time','i:1384776245;');
INSERT INTO `variable` VALUES ('menu_expanded','a:0:{}');
INSERT INTO `variable` VALUES ('menu_masks','a:34:{i:0;i:501;i:1;i:493;i:2;i:250;i:3;i:247;i:4;i:246;i:5;i:245;i:6;i:125;i:7;i:123;i:8;i:122;i:9;i:121;i:10;i:117;i:11;i:63;i:12;i:62;i:13;i:61;i:14;i:60;i:15;i:59;i:16;i:58;i:17;i:44;i:18;i:31;i:19;i:30;i:20;i:29;i:21;i:28;i:22;i:24;i:23;i:21;i:24;i:15;i:25;i:14;i:26;i:13;i:27;i:11;i:28;i:7;i:29;i:6;i:30;i:5;i:31;i:3;i:32;i:2;i:33;i:1;}');
INSERT INTO `variable` VALUES ('node_admin_theme','s:1:\"1\";');
INSERT INTO `variable` VALUES ('node_options_page','a:1:{i:0;s:6:\"status\";}');
INSERT INTO `variable` VALUES ('node_submitted_page','b:0;');
INSERT INTO `variable` VALUES ('path_alias_whitelist','a:0:{}');
INSERT INTO `variable` VALUES ('site_default_country','s:0:\"\";');
INSERT INTO `variable` VALUES ('site_mail','s:17:\"admin@example.com\";');
INSERT INTO `variable` VALUES ('site_name','b:0;');
INSERT INTO `variable` VALUES ('theme_default','s:6:\"bartik\";');
INSERT INTO `variable` VALUES ('update_last_check','i:1384776265;');
INSERT INTO `variable` VALUES ('update_notify_emails','a:1:{i:0;s:17:\"admin@ferrero.com\";}');
INSERT INTO `variable` VALUES ('user_admin_role','s:1:\"3\";');
INSERT INTO `variable` VALUES ('user_pictures','s:1:\"1\";');
INSERT INTO `variable` VALUES ('user_picture_dimensions','s:9:\"1024x1024\";');
INSERT INTO `variable` VALUES ('user_picture_file_size','s:3:\"800\";');
INSERT INTO `variable` VALUES ('user_picture_style','s:9:\"thumbnail\";');
INSERT INTO `variable` VALUES ('user_register','i:2;');
/*!40000 ALTER TABLE `variable` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `watchdog`
--

DROP TABLE IF EXISTS `watchdog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `watchdog` (
  `wid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique watchdog event ID.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid of the user who triggered the event.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'Type of log message, for example "user" or "page not found."',
  `message` longtext NOT NULL COMMENT 'Text of log message to be passed into the t() function.',
  `variables` longblob NOT NULL COMMENT 'Serialized array of variables that match the message string and that is passed into the t() function.',
  `severity` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The severity level of the event; ranges from 0 (Emergency) to 7 (Debug)',
  `link` varchar(255) DEFAULT '' COMMENT 'Link to view the result of the event.',
  `location` text NOT NULL COMMENT 'URL of the origin of the event.',
  `referer` text COMMENT 'URL of referring page.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'Hostname of the user who triggered the event.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'Unix timestamp of when event occurred.',
  PRIMARY KEY (`wid`),
  KEY `type` (`type`),
  KEY `uid` (`uid`),
  KEY `severity` (`severity`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COMMENT='Table that contains logs of all system events.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `watchdog`
--
-- ORDER BY:  `wid`

LOCK TABLES `watchdog` WRITE;
/*!40000 ALTER TABLE `watchdog` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `watchdog` VALUES (1,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:5:\"dblog\";}',6,'','http://default/index.php','','127.0.0.1',1384776252);
INSERT INTO `watchdog` VALUES (2,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:5:\"dblog\";}',6,'','http://default/index.php','','127.0.0.1',1384776252);
INSERT INTO `watchdog` VALUES (3,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:8:\"field_ui\";}',6,'','http://default/index.php','','127.0.0.1',1384776252);
INSERT INTO `watchdog` VALUES (4,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:8:\"field_ui\";}',6,'','http://default/index.php','','127.0.0.1',1384776252);
INSERT INTO `watchdog` VALUES (5,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:4:\"file\";}',6,'','http://default/index.php','','127.0.0.1',1384776252);
INSERT INTO `watchdog` VALUES (6,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:4:\"file\";}',6,'','http://default/index.php','','127.0.0.1',1384776252);
INSERT INTO `watchdog` VALUES (7,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:7:\"options\";}',6,'','http://default/index.php','','127.0.0.1',1384776253);
INSERT INTO `watchdog` VALUES (8,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:7:\"options\";}',6,'','http://default/index.php','','127.0.0.1',1384776253);
INSERT INTO `watchdog` VALUES (9,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:8:\"taxonomy\";}',6,'','http://default/index.php','','127.0.0.1',1384776253);
INSERT INTO `watchdog` VALUES (10,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:8:\"taxonomy\";}',6,'','http://default/index.php','','127.0.0.1',1384776253);
INSERT INTO `watchdog` VALUES (11,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:4:\"help\";}',6,'','http://default/index.php','','127.0.0.1',1384776253);
INSERT INTO `watchdog` VALUES (12,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:4:\"help\";}',6,'','http://default/index.php','','127.0.0.1',1384776253);
INSERT INTO `watchdog` VALUES (13,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:5:\"image\";}',6,'','http://default/index.php','','127.0.0.1',1384776253);
INSERT INTO `watchdog` VALUES (14,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:5:\"image\";}',6,'','http://default/index.php','','127.0.0.1',1384776253);
INSERT INTO `watchdog` VALUES (15,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:4:\"list\";}',6,'','http://default/index.php','','127.0.0.1',1384776253);
INSERT INTO `watchdog` VALUES (16,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:4:\"list\";}',6,'','http://default/index.php','','127.0.0.1',1384776253);
INSERT INTO `watchdog` VALUES (17,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:4:\"menu\";}',6,'','http://default/index.php','','127.0.0.1',1384776254);
INSERT INTO `watchdog` VALUES (18,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:4:\"menu\";}',6,'','http://default/index.php','','127.0.0.1',1384776256);
INSERT INTO `watchdog` VALUES (19,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:6:\"number\";}',6,'','http://default/index.php','','127.0.0.1',1384776256);
INSERT INTO `watchdog` VALUES (20,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:6:\"number\";}',6,'','http://default/index.php','','127.0.0.1',1384776256);
INSERT INTO `watchdog` VALUES (21,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:7:\"overlay\";}',6,'','http://default/index.php','','127.0.0.1',1384776256);
INSERT INTO `watchdog` VALUES (22,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:7:\"overlay\";}',6,'','http://default/index.php','','127.0.0.1',1384776256);
INSERT INTO `watchdog` VALUES (23,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:4:\"path\";}',6,'','http://default/index.php','','127.0.0.1',1384776256);
INSERT INTO `watchdog` VALUES (24,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:4:\"path\";}',6,'','http://default/index.php','','127.0.0.1',1384776256);
INSERT INTO `watchdog` VALUES (25,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:3:\"rdf\";}',6,'','http://default/index.php','','127.0.0.1',1384776256);
INSERT INTO `watchdog` VALUES (26,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:3:\"rdf\";}',6,'','http://default/index.php','','127.0.0.1',1384776256);
INSERT INTO `watchdog` VALUES (27,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:6:\"search\";}',6,'','http://default/index.php','','127.0.0.1',1384776257);
INSERT INTO `watchdog` VALUES (28,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:6:\"search\";}',6,'','http://default/index.php','','127.0.0.1',1384776257);
INSERT INTO `watchdog` VALUES (29,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:8:\"shortcut\";}',6,'','http://default/index.php','','127.0.0.1',1384776258);
INSERT INTO `watchdog` VALUES (30,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:8:\"shortcut\";}',6,'','http://default/index.php','','127.0.0.1',1384776258);
INSERT INTO `watchdog` VALUES (31,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:7:\"toolbar\";}',6,'','http://default/index.php','','127.0.0.1',1384776258);
INSERT INTO `watchdog` VALUES (32,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:7:\"toolbar\";}',6,'','http://default/index.php','','127.0.0.1',1384776258);
INSERT INTO `watchdog` VALUES (33,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:8:\"standard\";}',6,'','http://default/index.php','','127.0.0.1',1384776261);
INSERT INTO `watchdog` VALUES (34,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:8:\"standard\";}',6,'','http://default/index.php','','127.0.0.1',1384776261);
INSERT INTO `watchdog` VALUES (35,0,'actions','Action \'%action\' added.','a:1:{s:7:\"%action\";s:15:\"Publish comment\";}',5,'','http://default/index.php','','127.0.0.1',1384776261);
INSERT INTO `watchdog` VALUES (36,0,'actions','Action \'%action\' added.','a:1:{s:7:\"%action\";s:17:\"Unpublish comment\";}',5,'','http://default/index.php','','127.0.0.1',1384776261);
INSERT INTO `watchdog` VALUES (37,0,'actions','Action \'%action\' added.','a:1:{s:7:\"%action\";s:12:\"Save comment\";}',5,'','http://default/index.php','','127.0.0.1',1384776261);
INSERT INTO `watchdog` VALUES (38,0,'actions','Action \'%action\' added.','a:1:{s:7:\"%action\";s:15:\"Publish content\";}',5,'','http://default/index.php','','127.0.0.1',1384776261);
INSERT INTO `watchdog` VALUES (39,0,'actions','Action \'%action\' added.','a:1:{s:7:\"%action\";s:17:\"Unpublish content\";}',5,'','http://default/index.php','','127.0.0.1',1384776261);
INSERT INTO `watchdog` VALUES (40,0,'actions','Action \'%action\' added.','a:1:{s:7:\"%action\";s:19:\"Make content sticky\";}',5,'','http://default/index.php','','127.0.0.1',1384776261);
INSERT INTO `watchdog` VALUES (41,0,'actions','Action \'%action\' added.','a:1:{s:7:\"%action\";s:21:\"Make content unsticky\";}',5,'','http://default/index.php','','127.0.0.1',1384776261);
INSERT INTO `watchdog` VALUES (42,0,'actions','Action \'%action\' added.','a:1:{s:7:\"%action\";s:29:\"Promote content to front page\";}',5,'','http://default/index.php','','127.0.0.1',1384776261);
INSERT INTO `watchdog` VALUES (43,0,'actions','Action \'%action\' added.','a:1:{s:7:\"%action\";s:30:\"Remove content from front page\";}',5,'','http://default/index.php','','127.0.0.1',1384776261);
INSERT INTO `watchdog` VALUES (44,0,'actions','Action \'%action\' added.','a:1:{s:7:\"%action\";s:12:\"Save content\";}',5,'','http://default/index.php','','127.0.0.1',1384776261);
INSERT INTO `watchdog` VALUES (45,0,'actions','Action \'%action\' added.','a:1:{s:7:\"%action\";s:30:\"Ban IP address of current user\";}',5,'','http://default/index.php','','127.0.0.1',1384776261);
INSERT INTO `watchdog` VALUES (46,0,'actions','Action \'%action\' added.','a:1:{s:7:\"%action\";s:18:\"Block current user\";}',5,'','http://default/index.php','','127.0.0.1',1384776261);
INSERT INTO `watchdog` VALUES (47,0,'system','%module module installed.','a:1:{s:7:\"%module\";s:6:\"update\";}',6,'','http://default/index.php','','127.0.0.1',1384776263);
INSERT INTO `watchdog` VALUES (48,0,'system','%module module enabled.','a:1:{s:7:\"%module\";s:6:\"update\";}',6,'','http://default/index.php','','127.0.0.1',1384776263);
INSERT INTO `watchdog` VALUES (49,1,'user','Session opened for %name.','a:1:{s:5:\"%name\";s:17:\"admin@ferrero.com\";}',5,'','http://default/index.php','','127.0.0.1',1384776263);
INSERT INTO `watchdog` VALUES (50,0,'cron','Cron run completed.','a:0:{}',5,'','http://default/index.php','','127.0.0.1',1384776269);
/*!40000 ALTER TABLE `watchdog` ENABLE KEYS */;
UNLOCK TABLES;
commit;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-11-18 13:05:26
