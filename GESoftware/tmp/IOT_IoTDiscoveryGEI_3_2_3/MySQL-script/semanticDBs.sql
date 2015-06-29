-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.1.38-community


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema resourcedb
--

CREATE DATABASE IF NOT EXISTS resourcedb;
USE resourcedb;

--
-- Definition of table `Nodes`
--

DROP TABLE IF EXISTS `Nodes`;
CREATE TABLE `Nodes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hash` bigint(20) NOT NULL DEFAULT '0',
  `lex` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  `lang` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `datatype` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `type` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Hash` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8;


--
-- Definition of table `Prefixes`
--

DROP TABLE IF EXISTS `Prefixes`;
CREATE TABLE `Prefixes` (
  `prefix` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `uri` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`prefix`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Definition of table `Quads`
--

DROP TABLE IF EXISTS `Quads`;
CREATE TABLE `Quads` (
  `g` int(11) NOT NULL,
  `s` int(11) NOT NULL,
  `p` int(11) NOT NULL,
  `o` int(11) NOT NULL,
  PRIMARY KEY (`g`,`s`,`p`,`o`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Definition of table `Triples`
--

DROP TABLE IF EXISTS `Triples`;
CREATE TABLE `Triples` (
  `s` int(11) NOT NULL,
  `p` int(11) NOT NULL,
  `o` int(11) NOT NULL,
  PRIMARY KEY (`s`,`p`,`o`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Create schema entitydb
--

CREATE DATABASE IF NOT EXISTS entitydb;
USE entitydb;

--
-- Definition of table `Nodes`
--

DROP TABLE IF EXISTS `Nodes`;
CREATE TABLE `Nodes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hash` bigint(20) NOT NULL DEFAULT '0',
  `lex` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  `lang` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `datatype` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `type` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Hash` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8;


--
-- Definition of table `Prefixes`
--

DROP TABLE IF EXISTS `Prefixes`;
CREATE TABLE `Prefixes` (
  `prefix` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `uri` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`prefix`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Definition of table `Quads`
--

DROP TABLE IF EXISTS `Quads`;
CREATE TABLE `Quads` (
  `g` int(11) NOT NULL,
  `s` int(11) NOT NULL,
  `p` int(11) NOT NULL,
  `o` int(11) NOT NULL,
  PRIMARY KEY (`g`,`s`,`p`,`o`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Definition of table `Triples`
--

DROP TABLE IF EXISTS `Triples`;
CREATE TABLE `Triples` (
  `s` int(11) NOT NULL,
  `p` int(11) NOT NULL,
  `o` int(11) NOT NULL,
  PRIMARY KEY (`s`,`p`,`o`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Create schema servicedb
--

CREATE DATABASE IF NOT EXISTS servicedb;
USE servicedb;

--
-- Definition of table `Nodes`
--

DROP TABLE IF EXISTS `Nodes`;
CREATE TABLE `Nodes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hash` bigint(20) NOT NULL DEFAULT '0',
  `lex` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  `lang` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `datatype` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '',
  `type` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Hash` (`hash`)
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=utf8;


--
-- Definition of table `Prefixes`
--

DROP TABLE IF EXISTS `Prefixes`;
CREATE TABLE `Prefixes` (
  `prefix` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `uri` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`prefix`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Definition of table `Quads`
--

DROP TABLE IF EXISTS `Quads`;
CREATE TABLE `Quads` (
  `g` int(11) NOT NULL,
  `s` int(11) NOT NULL,
  `p` int(11) NOT NULL,
  `o` int(11) NOT NULL,
  PRIMARY KEY (`g`,`s`,`p`,`o`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Definition of table `Triples`
--

DROP TABLE IF EXISTS `Triples`;
CREATE TABLE `Triples` (
  `s` int(11) NOT NULL,
  `p` int(11) NOT NULL,
  `o` int(11) NOT NULL,
  PRIMARY KEY (`s`,`p`,`o`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
