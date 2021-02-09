-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 09, 2021 at 08:27 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `webcat_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `Posts`
--

CREATE TABLE `Posts` (
  `UserId` varchar(30) NOT NULL,
  `PostText` mediumtext DEFAULT NULL,
  `CommandText` mediumtext DEFAULT NULL,
  `CommandInt` int(11) DEFAULT NULL,
  `PostTimeStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Posts`
--

INSERT INTO `Posts` (`UserId`, `PostText`, `CommandText`, `CommandInt`, `PostTimeStamp`) VALUES
('Wolfman', '\n', 'Update Policies SSVS', 3, '2021-02-08 09:09:33'),
('Wolfman', '\n', 'Reset - Update CollectionSummary SSVS', 1, '2021-02-08 09:34:14'),
('Wolfman', '\n', 'Update CollectionMethod SSVS', 2, '2021-02-08 09:34:33'),
('Wolfman', '\n', 'Update Debicheck Policies', 115, '2021-02-08 11:50:13'),
('Wolfman', '\n', 'Reset - Update CollectionSummary DebiCheck', 117, '2021-02-08 12:31:53'),
('Wolfman', '\n', 'Update CollectionMethod Debicheck', 116, '2021-02-08 12:31:55'),
('Wolfman', '\n', 'Update CollectionMethod Debicheck', 116, '2021-02-08 12:39:11'),
('Wolfman', '\n', 'Reset - Update CollectionSummary DebiCheck', 117, '2021-02-08 12:39:13'),
('Wolfman', '\n', 'Update CollectionMethod Debicheck', 116, '2021-02-08 12:40:07'),
('Wolfman', '\n', 'Reset - Update CollectionSummary DebiCheck', 117, '2021-02-08 12:40:08'),
('Wolfman', '\n', 'Update CollectionMethod Debicheck', 116, '2021-02-08 12:41:13'),
('Wolfman', '\n', 'Reset - Update CollectionSummary DebiCheck', 117, '2021-02-08 12:41:14'),
('Wolfman', '\n', 'Update CollectionMethod Debicheck', 116, '2021-02-08 12:43:43'),
('Wolfman', '\n', 'Reset - Update CollectionSummary DebiCheck', 117, '2021-02-08 12:43:44'),
('Wolfman', '\n', 'Update CollectionMethod Debicheck', 116, '2021-02-08 12:44:47'),
('Wolfman', '\n', 'Reset - Update CollectionSummary DebiCheck', 117, '2021-02-08 12:44:48'),
('Wolfman', '\n', 'Update CollectionMethod Debicheck', 116, '2021-02-08 12:46:18'),
('Wolfman', '\n', 'Reset - Update CollectionSummary DebiCheck', 117, '2021-02-08 12:46:19');

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `Name` varchar(30) NOT NULL,
  `Surname` varchar(30) NOT NULL,
  `EmailAddress` varchar(50) NOT NULL,
  `Username` varchar(30) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `ProfilePicture` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`Name`, `Surname`, `EmailAddress`, `Username`, `Password`, `ProfilePicture`) VALUES
('b', 'b', 'b@c.c', 'Tester', '$2y$10$BtpVkXzoijpHZSLCNPjsquy/5JHMixnFCv6ORZnA/pO/PU8VJEQiW', 'images/webcat.png'),
('Trishca', 'Booyson', 'b.c@g.com', 'Trishca', '$2y$10$0O5cfwsGUov7BcuxJiaayu0OyTQFTmJ0V47GJ7cdwwTsoGof5V4tu', 'images/Trishca.png'),
('Brett', 'Coetzee', 'brett.john.coetzee@gmail.com', 'Webcat', '$2y$10$RJ3M490GgcDDIKKot3w5HuHtceS5Zbv2SgWVBpM0InjcBxVPL4fQ6', 'images/webcat.png'),
('Brett', 'Coetzee', 'brett.coetzee@stratusolve.com', 'Wolfman', '$2y$10$RbPnhVInrtBlRfq.fDypLONSLUCJ00PeXK.jrB7b6cGiK1B5A0jgK', 'images/Chirp.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Posts`
--
ALTER TABLE `Posts`
  ADD PRIMARY KEY (`PostTimeStamp`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`Username`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
