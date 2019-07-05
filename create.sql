CREATE TABLE `acl_rule` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `handle` varchar(1024) NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `acl_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `fullname` varchar(1024) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `password` varchar(64) DEFAULT NULL,
  `state` tinyint(3) unsigned NOT NULL,
  `created` datetime NOT NULL,
  `updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `acl_auth_token` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acl_user_id` int(10) unsigned NOT NULL,
  `token` varchar(32) NOT NULL,
  `hwid` varchar(128) NOT NULL,
  `pcode` varchar(128) NOT NULL,
  `version` varchar(32) NOT NULL,
  `ip` varchar(16) NOT NULL,
  `issued` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `expire` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`,`acl_user_id`),
  KEY `auth_token_FKIndex1` (`acl_user_id`),
  CONSTRAINT `acl_auth_token_ibfk_1` FOREIGN KEY (`acl_user_id`) REFERENCES `acl_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `acl_user_meta_field` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `acl_user_field` (
  `acl_user_id` int(10) unsigned NOT NULL,
  `acl_user_meta_field_id` int(10) unsigned NOT NULL,
  `value` varchar(1024) NOT NULL,
  PRIMARY KEY (`acl_user_id`,`acl_user_meta_field_id`),
  KEY `user_field_FKIndex1` (`acl_user_id`),
  KEY `user_field_FKIndex2` (`acl_user_meta_field_id`),
  CONSTRAINT `acl_user_field_ibfk_1` FOREIGN KEY (`acl_user_id`) REFERENCES `acl_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `acl_user_field_ibfk_2` FOREIGN KEY (`acl_user_meta_field_id`) REFERENCES `acl_user_meta_field` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `acl_user_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `acl_user_group_has_rules` (
  `acl_user_group_id` int(10) unsigned NOT NULL,
  `acl_rule_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`acl_user_group_id`,`acl_rule_id`),
  KEY `user_group_has_rule_FKIndex1` (`acl_user_group_id`),
  KEY `user_group_has_rule_FKIndex2` (`acl_rule_id`),
  CONSTRAINT `acl_user_group_has_rules_ibfk_1` FOREIGN KEY (`acl_user_group_id`) REFERENCES `acl_user_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `acl_user_group_has_rules_ibfk_2` FOREIGN KEY (`acl_rule_id`) REFERENCES `acl_rule` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `acl_user_group_has_users` (
  `acl_user_group_id` int(10) unsigned NOT NULL,
  `acl_user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`acl_user_group_id`,`acl_user_id`),
  KEY `user_group_has_user_FKIndex1` (`acl_user_group_id`),
  KEY `user_group_has_user_FKIndex2` (`acl_user_id`),
  CONSTRAINT `acl_user_group_has_users_ibfk_1` FOREIGN KEY (`acl_user_group_id`) REFERENCES `acl_user_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `acl_user_group_has_users_ibfk_2` FOREIGN KEY (`acl_user_id`) REFERENCES `acl_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `acl_user_has_rules` (
  `acl_user_id` int(10) unsigned NOT NULL,
  `acl_rule_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`acl_user_id`,`acl_rule_id`),
  KEY `user_has_rule_FKIndex1` (`acl_user_id`),
  KEY `user_has_rule_FKIndex2` (`acl_rule_id`),
  CONSTRAINT `acl_user_has_rules_ibfk_1` FOREIGN KEY (`acl_user_id`) REFERENCES `acl_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `acl_user_has_rules_ibfk_2` FOREIGN KEY (`acl_rule_id`) REFERENCES `acl_rule` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `cfg_group_setting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acl_user_group_id` int(10) unsigned NOT NULL,
  `handle` varchar(255) NOT NULL,
  `val` varchar(1024) NOT NULL DEFAULT '',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cfg_group_setting_idx_handle` (`handle`),
  KEY `cfg_group_setting_updated` (`updated`),
  KEY `cfg_group_setting_FKIndex1` (`acl_user_group_id`),
  CONSTRAINT `cfg_group_setting_ibfk_1` FOREIGN KEY (`acl_user_group_id`) REFERENCES `acl_user_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `cfg_server_setting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `val` varchar(1024) NOT NULL DEFAULT '',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cfg_server_setting_idx_handle` (`handle`),
  KEY `cfg_server_setting_idx_updated` (`updated`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `cfg_setting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `val` varchar(1024) NOT NULL DEFAULT '',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cfg_setting_idx_handle` (`handle`),
  KEY `cfg_setting_idx_updated` (`updated`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `cfg_user_setting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acl_user_id` int(10) unsigned NOT NULL,
  `handle` varchar(255) NOT NULL,
  `val` varchar(1024) NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cfg_user_setting_idx_handle` (`acl_user_id`,`handle`),
  KEY `cfg_user_setting_idx_updated` (`updated`),
  KEY `cfg_user_setting_FKIndex1` (`acl_user_id`),
  CONSTRAINT `cfg_user_setting_ibfk_1` FOREIGN KEY (`acl_user_id`) REFERENCES `acl_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `contact` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `acl_user_id` int(10) unsigned NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `note` varchar(1023) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contact_fk1` (`acl_user_id`),
  CONSTRAINT `contact_fk1` FOREIGN KEY (`acl_user_id`) REFERENCES `acl_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `contact_detail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contact_id` int(10) unsigned NOT NULL,
  `type` tinyint(4) NOT NULL,
  `val` varchar(1023) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `contact_detail_fk1` (`contact_id`),
  CONSTRAINT `contact_detail_fk1` FOREIGN KEY (`contact_id`) REFERENCES `contact` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `cti_user_setting` (
  `acl_user_id` int(10) unsigned NOT NULL,
  `dnd` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `cfwd_all` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `cfwd_all_number` varchar(16) DEFAULT NULL,
  `cfwd_busy` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `cfwd_busy_number` varchar(16) DEFAULT NULL,
  `cfwd_unavailable` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `cfwd_unavailable_number` varchar(16) DEFAULT NULL,
  `crec_incoming` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `crec_outgoing` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `crec_internal` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `call_back` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`acl_user_id`),
  KEY `cti_user_setting_FKIndex1` (`acl_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `databasechangelog` (
  `ID` varchar(63) NOT NULL,
  `AUTHOR` varchar(63) NOT NULL,
  `FILENAME` varchar(200) NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int(11) NOT NULL,
  `EXECTYPE` varchar(10) NOT NULL,
  `MD5SUM` varchar(35) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `COMMENTS` varchar(255) DEFAULT NULL,
  `TAG` varchar(255) DEFAULT NULL,
  `LIQUIBASE` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`,`AUTHOR`,`FILENAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `databasechangeloglock` (
  `ID` int(11) NOT NULL,
  `LOCKED` tinyint(1) NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ext_web_app` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `address` varchar(1024) NOT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `queue` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `fullname` varchar(1023) DEFAULT NULL,
  `description` varchar(1023) DEFAULT NULL,
  `url` varchar(1023) DEFAULT NULL,
  `close_on_hangup` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `queue_idx1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `queue_agent` (
  `queue_id` int(10) unsigned NOT NULL,
  `acl_user_id` int(10) unsigned NOT NULL,
  `penalty` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`queue_id`,`acl_user_id`),
  KEY `queue_agent_fk1` (`queue_id`),
  KEY `queue_agent_fk2` (`acl_user_id`),
  CONSTRAINT `queue_agent_fk1` FOREIGN KEY (`queue_id`) REFERENCES `queue` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `queue_agent_fk2` FOREIGN KEY (`acl_user_id`) REFERENCES `acl_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE  TABLE `chat_message` (

  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT ,

  `from_id` INT(10) UNSIGNED NOT NULL ,

  `to_id` INT(10) UNSIGNED NOT NULL ,

  `datetime` DATETIME NULL ,

  `content` VARCHAR(1024) NULL DEFAULT NULL ,

  `type` INT(11) NULL DEFAULT NULL ,

  `is_new_id` INT(11) NULL DEFAULT 1 ,

  PRIMARY KEY (`id`) 
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

CREATE TABLE `outgouing_company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  `tm_created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `name` varchar(128) NOT NULL,
  `description` text NOT NULL,
  `state` tinyint(4) NOT NULL,
  `is_locked` tinyint(4) NOT NULL DEFAULT '0',
  `date_start` date NOT NULL,
  `date_finish` date NOT NULL,
  `time_start` time NOT NULL,
  `time_finish` time NOT NULL,
  `is_pause_on_day_off` tinyint(4) NOT NULL DEFAULT '0',
  `is_restart_on_day_start` tinyint(4) NOT NULL DEFAULT '0',
  `answer_timeout` int(11) NOT NULL DEFAULT '60',
  `call_tries` int(11) NOT NULL DEFAULT '1',
  `pause_after_conversation` int(11) NOT NULL DEFAULT '1',
  `pause_after_try` int(11) NOT NULL DEFAULT '10',
  `action` tinyint(2) NOT NULL DEFAULT '0',
  `action_value` varchar(64) NOT NULL DEFAULT '',
  `last_conversation` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `concurrent_calls_limit` int(11) NOT NULL DEFAULT '0',
  `call_duration_limit` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251 ROW_FORMAT=DYNAMIC;

CREATE TABLE `calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asteriskId` varchar(32) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `userId` int(11) NOT NULL DEFAULT '0',
  `type` tinyint(4) NOT NULL DEFAULT '0',
  `state` tinyint(4) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `tm_created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `tm_rbt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `tm_bridged` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `tm_done` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `caller` varchar(16) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `called` varchar(16) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `rbt_duration` int(11) NOT NULL DEFAULT '0',
  `duration` int(11) NOT NULL DEFAULT '0',
  `fn_mixmonitor` varchar(255) NOT NULL DEFAULT '',
  `hangup_cause` varchar(128) NOT NULL DEFAULT '',
  `hangup_code` int(11) NOT NULL DEFAULT '0',
  `q850_code` int(11) NOT NULL DEFAULT '0',
  `q850_reason` varchar(128) NOT NULL DEFAULT '',
  `sip_call_id` varchar(255) NOT NULL DEFAULT '',
  `qos` varchar(255) NOT NULL DEFAULT '',
  `dialstatus` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `called` (`called`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `outgouing_company_callerid` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `outgouing_company_id` int(11) DEFAULT NULL,
  `callerid` varchar(45) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `outgouing_company_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `outgouing_company_id` int(11) NOT NULL,
  `order` int(11) NOT NULL DEFAULT '0',
  `phone` varchar(64) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `state` tinyint(4) NOT NULL DEFAULT '0',
  `tries` int(11) NOT NULL DEFAULT '0',
  `last_call` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `dial_result` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`outgouing_company_id`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251 ROW_FORMAT=DYNAMIC;

CREATE TABLE `outgouing_company_contacts_calls` (
  `call_id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  PRIMARY KEY (`call_id`),
  UNIQUE KEY `contact_id` (`contact_id`,`company_id`,`call_id`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251 ROW_FORMAT=FIXED;

CREATE TABLE `outgouing_company_weekdays` (
  `outgouing_company_id` int(11) NOT NULL,
  `weekday_id` int(11) NOT NULL,
  PRIMARY KEY (`outgouing_company_id`,`weekday_id`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251 ROW_FORMAT=FIXED;

CREATE TABLE `sip_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tm` datetime NOT NULL,
  `sip_call_id` varchar(256) NOT NULL,
  `addr` varchar(32) NOT NULL,
  `data` varchar(2048) NOT NULL,
  `direction` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `queue_cdr` (
  `id` int(12) unsigned NOT NULL AUTO_INCREMENT,
  `calldate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `uniqid` varchar(32) NOT NULL DEFAULT '',
  `queue` varchar(80) NOT NULL DEFAULT '',
  `agentid` varchar(16) NOT NULL DEFAULT '',
  `agentname` varchar(80) NOT NULL DEFAULT '',
  `agentdev` varchar(80) NOT NULL DEFAULT '',
  `agentcalls` int(10) unsigned NOT NULL DEFAULT '0',
  `holdtime` int(10) unsigned NOT NULL DEFAULT '0',
  `talktime` int(10) unsigned NOT NULL DEFAULT '0',  
  `position` tinyint(2) NOT NULL DEFAULT '0',
  `origposition` tinyint(2) NOT NULL DEFAULT '0',
  `callerid` varchar(80) NOT NULL DEFAULT '',
  `src` varchar(80) NOT NULL DEFAULT '',
  `channel` varchar(80) NOT NULL DEFAULT '',
  `dstchannel` varchar(80) NOT NULL DEFAULT '',
  `disposition` varchar(32) NOT NULL DEFAULT '',
  `context` varchar(80) NOT NULL DEFAULT '',
  `exitcontext` varchar(80) NOT NULL DEFAULT '',
  `exten` varchar(32) NOT NULL DEFAULT '',
  `accountcode` varchar(80) NOT NULL DEFAULT '',
  `userfield` varchar(128) NOT NULL DEFAULT '',
  `appl` varchar(80) NOT NULL DEFAULT '',
  `data` varchar(80) NOT NULL DEFAULT '',
  `reason` varchar(32) NOT NULL DEFAULT '',
  `transferexten` varchar(32) NOT NULL DEFAULT '',
  `transfercontext` varchar(80) NOT NULL DEFAULT '',
  `server` varchar(80) NOT NULL,
  `outgoing` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `agentname` (`agentname`),
  KEY `queue` (`queue`),
  KEY `uniqid` (`uniqid`),
  KEY `calldate` (`calldate`),
  KEY `src` (`src`)
) ENGINE=MyISAM CHARSET=utf8;

CREATE TABLE `agents_events` (
  `id` int(12) unsigned NOT NULL AUTO_INCREMENT,
  `eventdate` datetime NOT NULL,
  `queuename` varchar(80) NOT NULL,
  `source` varchar(32) NOT NULL,
  `event` varchar(32) NOT NULL,
  `agentid` varchar(32),
  `agentname` varchar(80) NOT NULL,
  `agentdev` varchar(80) NOT NULL,
  `reason` varchar(80) NOT NULL,
  `penalty` varchar(16) NOT NULL,
  `oldstatus` tinyint(1) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL,
  `paused` tinyint(1) unsigned NOT NULL,
  `dynamic` tinyint(1) NOT NULL,
  `realtime` tinyint(1) NOT NULL,
  `calls` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

CREATE TABLE `cdr` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL DEFAULT '0',
  `calldate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `name` varchar(128) NOT NULL DEFAULT '',
  `clid` varchar(80) NOT NULL DEFAULT '',
  `src` varchar(80) NOT NULL DEFAULT '',
  `dst` varchar(80) NOT NULL DEFAULT '',
  `dst_bill` varchar(64) NOT NULL DEFAULT '',
  `dcontext` varchar(80) NOT NULL DEFAULT '',
  `channel` varchar(80) NOT NULL DEFAULT '',
  `dstchannel` varchar(80) NOT NULL DEFAULT '',
  `lastapp` varchar(80) NOT NULL DEFAULT '',
  `lastdata` varchar(80) NOT NULL DEFAULT '',
  `duration` int(11) NOT NULL DEFAULT '0',
  `billsec` int(11) NOT NULL DEFAULT '0',
  `ratesec` int(11) NOT NULL DEFAULT '0',
  `disposition` varchar(45) NOT NULL DEFAULT '',
  `amaflags` int(11) NOT NULL DEFAULT '0',
  `accountcode` varchar(80) NOT NULL DEFAULT '',
  `uniqueid` varchar(64) NOT NULL DEFAULT '',
  `userfield` varchar(255) NOT NULL DEFAULT '',
  `rate` decimal(8,5) NOT NULL DEFAULT '0.00000',
  `cost` decimal(8,5) NOT NULL DEFAULT '0.00000',
  `bstep` varchar(16) NOT NULL DEFAULT '',
  `currency` varchar(3) NOT NULL DEFAULT '',
  `t_name` varchar(64) NOT NULL DEFAULT '',
  `t_accountcode` varchar(64) NOT NULL DEFAULT '',
  `department` varchar(80) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `calldate` (`calldate`),
  KEY `dst_ind` (`dst`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
