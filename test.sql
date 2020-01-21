-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  mar. 21 jan. 2020 à 09:44
-- Version du serveur :  5.7.26
-- Version de PHP :  7.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `test2`
--

-- --------------------------------------------------------

--
-- Structure de la table `booking`
--

DROP TABLE IF EXISTS `booking`;
CREATE TABLE IF NOT EXISTS `booking` (
  `booking_id` int(11) NOT NULL AUTO_INCREMENT,
  `house_id` int(11) NOT NULL,
  `fromdate` date NOT NULL,
  `todate` date NOT NULL,
  `renter` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `validate` int(11) NOT NULL,
  PRIMARY KEY (`booking_id`),
  KEY `house_id` (`house_id`),
  KEY `renter` (`renter`),
  KEY `owner` (`owner`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `comments`
--

DROP TABLE IF EXISTS `comments`;
CREATE TABLE IF NOT EXISTS `comments` (
  `id_comments` int(11) NOT NULL AUTO_INCREMENT,
  `text` text NOT NULL,
  `id_house` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  PRIMARY KEY (`id_comments`),
  KEY `id_house` (`id_house`),
  KEY `id_user` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `house`
--

DROP TABLE IF EXISTS `house`;
CREATE TABLE IF NOT EXISTS `house` (
  `house_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `zip` int(11) NOT NULL,
  `city` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `distanceToCenter` int(11) NOT NULL,
  `maxCapacity` int(11) NOT NULL,
  `beds` int(11) NOT NULL,
  `IsSmokingAllowed` varchar(3) NOT NULL,
  `IsNoiseAfter11Allowed` varchar(3) NOT NULL,
  `IsPetsAllowed` varchar(3) NOT NULL,
  `Description` text NOT NULL,
  `bookable` int(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  `image1` longblob,
  `image2` longblob,
  `image3` longblob,
  PRIMARY KEY (`house_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(10) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `tel` varchar(20) NOT NULL,
  `admin` int(1) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`user_id`, `password`, `lastname`, `firstname`, `tel`, `admin`, `email`) VALUES
(1, 'kk', 'admin', 'admin', '0123232323', 1, 'admin@a.com\r\n'),
(2, '123456', 'Billy', 'Bob', '0112121212', 0, 'bob@bob.com\r\n');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `foreignkey_house` FOREIGN KEY (`house_id`) REFERENCES `house` (`house_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `foreignkey_owner` FOREIGN KEY (`owner`) REFERENCES `user` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `foreignkey_renter` FOREIGN KEY (`renter`) REFERENCES `user` (`user_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `fk_house` FOREIGN KEY (`id_house`) REFERENCES `booking` (`house_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`id_user`) REFERENCES `booking` (`renter`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `house`
--
ALTER TABLE `house`
  ADD CONSTRAINT `user_foreign_key` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
