CREATE TABLE `microposts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `to_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_microposts_on_user_id_and_created_at` (`user_id`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `relationships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `follower_id` int(11) DEFAULT NULL,
  `followed_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_relationships_on_follower_id_and_followed_id` (`follower_id`,`followed_id`),
  KEY `index_relationships_on_followed_id` (`followed_id`),
  KEY `index_relationships_on_follower_id` (`follower_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `password_digest` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remember_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `admin` tinyint(1) DEFAULT '0',
  `realname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_realname_and_name` (`realname`,`name`),
  KEY `index_users_on_remember_token` (`remember_token`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO schema_migrations (version) VALUES ('20120907034207');

INSERT INTO schema_migrations (version) VALUES ('20120907035835');

INSERT INTO schema_migrations (version) VALUES ('20120907040523');

INSERT INTO schema_migrations (version) VALUES ('20120907063905');

INSERT INTO schema_migrations (version) VALUES ('20120907120300');

INSERT INTO schema_migrations (version) VALUES ('20120908024500');

INSERT INTO schema_migrations (version) VALUES ('20120908044615');

INSERT INTO schema_migrations (version) VALUES ('20120919012401');

INSERT INTO schema_migrations (version) VALUES ('20120922085225');

INSERT INTO schema_migrations (version) VALUES ('20120922090656');

INSERT INTO schema_migrations (version) VALUES ('20120922091640');

INSERT INTO schema_migrations (version) VALUES ('20120922091831');