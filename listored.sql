SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;


CREATE TABLE IF NOT EXISTS `ideas` (
  `userId` int(11) NOT NULL,
  `listId` int(11) NOT NULL,
  `idea` varbinary(300) NOT NULL,
  `order` int(11) NOT NULL AUTO_INCREMENT,
  `parent` int(11) NOT NULL DEFAULT '0',
  `checked` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`order`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3357 ;
DROP TRIGGER IF EXISTS `del_idea`;
DELIMITER //
CREATE TRIGGER `del_idea` AFTER DELETE ON `ideas`
 FOR EACH ROW UPDATE  lists SET updated=NOW() WHERE lists.listId=OLD.listId
//
DELIMITER ;
DROP TRIGGER IF EXISTS `ins_idea`;
DELIMITER //
CREATE TRIGGER `ins_idea` AFTER INSERT ON `ideas`
 FOR EACH ROW UPDATE  lists SET updated=NOW() WHERE lists.listId=NEW.listId
//
DELIMITER ;
DROP TRIGGER IF EXISTS `upd_idea`;
DELIMITER //
CREATE TRIGGER `upd_idea` AFTER UPDATE ON `ideas`
 FOR EACH ROW UPDATE  lists SET updated=NOW() WHERE lists.listId=NEW.listId
//
DELIMITER ;

CREATE TABLE IF NOT EXISTS `lists` (
  `listId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varbinary(100) NOT NULL,
  `users` varbinary(1000) NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`listId`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=42 ;

CREATE TABLE IF NOT EXISTS `users` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `currList` int(11) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`userId`),
  UNIQUE KEY `userName` (`userName`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=11 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
