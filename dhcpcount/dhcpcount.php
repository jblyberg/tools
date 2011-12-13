#!/usr/bin/php -q
<?php

// Simple script to keep track of the number of users who hop on our wireless
// network everyday.

// Simple configuration

$syslog = '/var/log/syslog.0';
$wireless_gateway = '10.0.64.2';

// Pull in DSN

require_once 'dsn.php';
require_once 'MDB2.php';

$syslog_contents = `grep $wireless_gateway $syslog | grep DHCPACK`;

$m = preg_match_all('%DHCPACK on (.+?) to (.+?) via ' . $wireless_gateway . '%s', $syslog_contents, $matches);

if ($m) {
  $mac_addr = array();
  $macs = array_unique($matches[2]);
  $count = count($macs) ? count($macs) : 0;

  $db =& MDB2::connect($dsn);
  if (PEAR::isError($db)) {
      die($db->getMessage());
  }
  
  $res =& $db->query('INSERT INTO wireless_counts VALUES (0, NOW(), ' . $count . ')');
  $res->free();
  
} else {
  // Do nothing
}


