-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: May 05, 2024 at 08:20 AM
-- Server version: 5.7.39
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `findfunder`
--

-- --------------------------------------------------------

--
-- Table structure for table `Founder`
--

CREATE TABLE `Founder` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `InvestmentRounds`
--

CREATE TABLE `InvestmentRounds` (
  `round_id` int(11) NOT NULL,
  `startup_id` int(11) DEFAULT NULL,
  `round_type` varchar(50) DEFAULT NULL,
  `funding_amount` decimal(20,2) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `other_details` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Investments`
--

CREATE TABLE `Investments` (
  `investment_id` int(11) NOT NULL,
  `round_id` int(11) DEFAULT NULL,
  `investor_id` int(11) DEFAULT NULL,
  `investment_amount` decimal(20,2) DEFAULT NULL,
  `investment_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `INVESTOR`
--

CREATE TABLE `INVESTOR` (
  `ID` int(11) NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `NationalID` varchar(50) NOT NULL,
  `PhoneNumber` varchar(50) NOT NULL,
  `InvestorType` varchar(50) NOT NULL,
  `Description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `STARTUP`
--

CREATE TABLE `STARTUP` (
  `ID` int(11) NOT NULL,
  `CompanyName` varchar(50) NOT NULL,
  `FounderName` varchar(50) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `NationalID` varchar(50) NOT NULL,
  `PhoneNumber` varchar(50) NOT NULL,
  `InvestorTypeDescription` varchar(50) NOT NULL,
  `Description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `Startup_Founder`
--

CREATE TABLE `Startup_Founder` (
  `startup_id` int(11) NOT NULL,
  `founder_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tokens`
--

CREATE TABLE `tokens` (
  `token_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `token_type` enum('authentication','password_reset') NOT NULL,
  `token_value` varchar(255) NOT NULL,
  `expiry_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Founder`
--
ALTER TABLE `Founder`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `InvestmentRounds`
--
ALTER TABLE `InvestmentRounds`
  ADD PRIMARY KEY (`round_id`),
  ADD KEY `startup_id` (`startup_id`);

--
-- Indexes for table `Investments`
--
ALTER TABLE `Investments`
  ADD PRIMARY KEY (`investment_id`),
  ADD KEY `round_id` (`round_id`),
  ADD KEY `investor_id` (`investor_id`);

--
-- Indexes for table `INVESTOR`
--
ALTER TABLE `INVESTOR`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `STARTUP`
--
ALTER TABLE `STARTUP`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `Startup_Founder`
--
ALTER TABLE `Startup_Founder`
  ADD PRIMARY KEY (`startup_id`,`founder_id`),
  ADD KEY `founder_id` (`founder_id`);

--
-- Indexes for table `tokens`
--
ALTER TABLE `tokens`
  ADD PRIMARY KEY (`token_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Founder`
--
ALTER TABLE `Founder`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `INVESTOR`
--
ALTER TABLE `INVESTOR`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `STARTUP`
--
ALTER TABLE `STARTUP`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tokens`
--
ALTER TABLE `tokens`
  MODIFY `token_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `InvestmentRounds`
--
ALTER TABLE `InvestmentRounds`
  ADD CONSTRAINT `investmentrounds_ibfk_1` FOREIGN KEY (`startup_id`) REFERENCES `STARTUP` (`ID`);

--
-- Constraints for table `Investments`
--
ALTER TABLE `Investments`
  ADD CONSTRAINT `investments_ibfk_1` FOREIGN KEY (`round_id`) REFERENCES `InvestmentRounds` (`round_id`),
  ADD CONSTRAINT `investments_ibfk_2` FOREIGN KEY (`investor_id`) REFERENCES `INVESTOR` (`ID`);

--
-- Constraints for table `Startup_Founder`
--
ALTER TABLE `Startup_Founder`
  ADD CONSTRAINT `startup_founder_ibfk_1` FOREIGN KEY (`startup_id`) REFERENCES `STARTUP` (`ID`),
  ADD CONSTRAINT `startup_founder_ibfk_2` FOREIGN KEY (`founder_id`) REFERENCES `Founder` (`id`);

--
-- Constraints for table `tokens`
--
ALTER TABLE `tokens`
  ADD CONSTRAINT `tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
