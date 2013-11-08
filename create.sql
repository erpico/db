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

CREATE TABLE `acl_user_meta_field` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
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