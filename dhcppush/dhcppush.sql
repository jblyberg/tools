-- phpMyAdmin SQL Dump
-- version 3.3.7deb6
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 09, 2011 at 11:17 PM
-- Server version: 5.1.49
-- PHP Version: 5.3.3-7+squeeze3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

CREATE DATABASE IF NOT EXISTS `dhcp`
USE dhcp;

--
-- Database: `dhcp`
--

-- --------------------------------------------------------

--
-- Table structure for table `global_options`
--

CREATE TABLE IF NOT EXISTS `global_options` (
  `rec_num` tinyint(3) NOT NULL AUTO_INCREMENT,
  `options` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`rec_num`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='List of global options to put at the begining of dhcpd.conf' AUTO_INCREMENT=12 ;

INSERT INTO `global_options` (`rec_num`, `options`) VALUES
(1, 'option domain-name "darienlibrary.org"'),
(2, 'option domain-name-servers 10.0.0.11, 10.0.0.12'),
(3, 'option netbios-node-type 8'),
(5, 'default-lease-time 86400'),
(6, 'max-lease-time 86400'),
(7, 'allow booting'),
(8, 'allow bootp'),
(9, 'option time-servers 10.0.0.10'),
(10, 'option ntp-servers 10.0.0.10'),
(11, 'option time-offset -5');


-- --------------------------------------------------------

--
-- Table structure for table `guest`
--

CREATE TABLE IF NOT EXISTS `guest` (
  `gnum` varchar(13) NOT NULL DEFAULT '0',
  `lname` varchar(128) NOT NULL DEFAULT '',
  `fname` varchar(128) NOT NULL DEFAULT '',
  `address` varchar(254) NOT NULL DEFAULT '',
  `zip` varchar(10) NOT NULL DEFAULT '',
  `expire` date NOT NULL DEFAULT '0000-00-00',
  UNIQUE KEY `gnum` (`gnum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ranges`
--

CREATE TABLE IF NOT EXISTS `ranges` (
  `rec_num` int(5) NOT NULL AUTO_INCREMENT,
  `id` tinyint(3) NOT NULL DEFAULT '0',
  `first` varchar(15) NOT NULL DEFAULT '',
  `last` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`rec_num`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='IP range designation for leases' AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

CREATE TABLE IF NOT EXISTS `reservations` (
  `res_id` int(6) NOT NULL AUTO_INCREMENT,
  `mac` varchar(12) NOT NULL DEFAULT '',
  `ip` varchar(15) NOT NULL DEFAULT '',
  `subnet_id` tinyint(3) NOT NULL DEFAULT '1',
  `hostname` varchar(24) NOT NULL DEFAULT '',
  `domain` varchar(24) DEFAULT NULL,
  `gateway` varchar(15) DEFAULT NULL,
  `netmask` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`res_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='dhcp lease reservations' AUTO_INCREMENT=88 ;

-- --------------------------------------------------------

--
-- Table structure for table `subnets`
--

CREATE TABLE IF NOT EXISTS `subnets` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `interface` varchar(8) NOT NULL DEFAULT '',
  `network` varchar(15) NOT NULL DEFAULT '',
  `netmask` varchar(15) NOT NULL DEFAULT '',
  `gateway` varchar(15) NOT NULL DEFAULT '',
  `broadcast` varchar(15) NOT NULL DEFAULT '',
  `dns1` varchar(15) DEFAULT NULL,
  `dns2` varchar(15) DEFAULT NULL,
  `lease_time` int(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Subnet declarations for dhcp reservations' AUTO_INCREMENT=18 ;

-- --------------------------------------------------------

--
-- Table structure for table `wireless`
--

CREATE TABLE IF NOT EXISTS `wireless` (
  `host_id` int(5) NOT NULL AUTO_INCREMENT,
  `ip` varchar(15) NOT NULL DEFAULT '',
  `dhcp_res` int(6) DEFAULT NULL,
  `belongs_to` varchar(14) DEFAULT NULL,
  `active` enum('0','1') NOT NULL DEFAULT '0',
  `expires` date DEFAULT NULL,
  PRIMARY KEY (`host_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='IP/DHCP assignments for wireless users' AUTO_INCREMENT=1 ;
