-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 20, 2024 at 07:32 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `feed_aid_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `beneficiary`
--

CREATE TABLE `beneficiary` (
  `B_id` int(11) NOT NULL,
  `B_name` varchar(50) NOT NULL,
  `B_address` varchar(200) NOT NULL,
  `B_contact` varchar(15) NOT NULL,
  `B_email` varchar(50) NOT NULL,
  `B_password` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `beneficiary`
--

INSERT INTO `beneficiary` (`B_id`, `B_name`, `B_address`, `B_contact`, `B_email`, `B_password`) VALUES
(1, 'Akshi', 'batti', '077', 'akshi@gmail.com', '123'),
(2, 'Sunil Dev', 'Kallady', '076', 'sunil@gmail.com', '123'),
(3, 'Kapil', 'Jaffna', '077', 'kapil@gmail.com', '123');

-- --------------------------------------------------------

--
-- Table structure for table `delivery`
--

CREATE TABLE `delivery` (
  `D_id` int(11) NOT NULL,
  `D_date` date NOT NULL,
  `D_H_id_fk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `delivery`
--

INSERT INTO `delivery` (`D_id`, `D_date`, `D_H_id_fk`) VALUES
(2, '2024-03-18', 6),
(3, '2024-03-18', 7),
(4, '2024-03-19', 8),
(5, '2024-03-19', 9),
(6, '2024-03-20', 10);

-- --------------------------------------------------------

--
-- Table structure for table `donar`
--

CREATE TABLE `donar` (
  `Dr_id` int(11) NOT NULL,
  `Dr_name` varchar(50) DEFAULT NULL,
  `Dr_address` varchar(200) NOT NULL,
  `Dr_contact` varchar(15) NOT NULL,
  `Dr_email` varchar(50) NOT NULL,
  `Dr_password` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `donar`
--

INSERT INTO `donar` (`Dr_id`, `Dr_name`, `Dr_address`, `Dr_contact`, `Dr_email`, `Dr_password`) VALUES
(3, 'Sathurcigan', 'Batticaloa', '0789', 'sathu@gmail.com', '123'),
(32, 'vinoth', 'kalmunai', '07897', 'vinoth@gmail.com', '1233');

-- --------------------------------------------------------

--
-- Table structure for table `donation`
--

CREATE TABLE `donation` (
  `D_id` int(11) NOT NULL,
  `D_F_id_fk` int(11) NOT NULL,
  `D_foodCount` int(11) NOT NULL,
  `D_Dr_id_fk` int(11) NOT NULL,
  `D_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `donation`
--

INSERT INTO `donation` (`D_id`, `D_F_id_fk`, `D_foodCount`, `D_Dr_id_fk`, `D_date`) VALUES
(6, 1, 10, 3, '2024-02-02'),
(9, 2, 2, 3, '2024-02-06'),
(10, 4, 20, 3, '2024-02-18'),
(11, 7, 15, 3, '2024-02-20'),
(12, 1, 10, 32, '2024-02-08'),
(13, 6, 20, 3, '2024-02-20');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `Fe_id` int(11) NOT NULL,
  `Fe_H_id_fk` int(11) NOT NULL,
  `Fe_summary` varchar(500) NOT NULL,
  `Fe_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`Fe_id`, `Fe_H_id_fk`, `Fe_summary`, `Fe_date`) VALUES
(6, 6, 'Amaizing service. Thank you.', '2024-03-18'),
(7, 7, 'Thank you so much.', '2024-03-18'),
(8, 8, 'Thank you for your help.', '2024-03-19'),
(9, 9, 'Thank you.', '2024-03-19'),
(10, 10, 'Thank you', '2024-03-20');

-- --------------------------------------------------------

--
-- Table structure for table `food`
--

CREATE TABLE `food` (
  `F_id` int(11) NOT NULL,
  `F_name` varchar(25) NOT NULL,
  `F_image` varchar(200) NOT NULL,
  `F_count` int(11) NOT NULL,
  `FT_id_fk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `food`
--

INSERT INTO `food` (`F_id`, `F_name`, `F_image`, `F_count`, `FT_id_fk`) VALUES
(1, 'Apple', 'apple.jpg', 10, 1),
(2, 'Orange', 'orange.jpg', 17, 1),
(3, 'Noodles', 'noodles.jpg', 1, 3),
(4, 'Rice', 'rice.jpg', 16, 7),
(5, 'Water', 'water.jpg', 1, 5),
(6, 'Chicken', 'chicken.jpg', 22, 4),
(7, 'Potato', 'potato.jpg', 17, 2),
(8, 'Tomato', 'tomato.jpg', 1, 2),
(9, 'Yogurd', 'yogurd.jpg', 20, 6);

-- --------------------------------------------------------

--
-- Table structure for table `food_type`
--

CREATE TABLE `food_type` (
  `FT_id` int(11) NOT NULL,
  `FT_type` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `food_type`
--

INSERT INTO `food_type` (`FT_id`, `FT_type`) VALUES
(1, 'Fruit'),
(2, 'Vegetables'),
(3, 'Fast food'),
(4, 'Meat'),
(5, 'Drinks'),
(6, 'Milk'),
(7, 'Groceries');

-- --------------------------------------------------------

--
-- Table structure for table `handling`
--

CREATE TABLE `handling` (
  `H_id` int(11) NOT NULL,
  `H_date` date NOT NULL,
  `H_R_id_fk` int(11) NOT NULL,
  `H_V_id_fk` int(11) NOT NULL,
  `H_D_id_fk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `handling`
--

INSERT INTO `handling` (`H_id`, `H_date`, `H_R_id_fk`, `H_V_id_fk`, `H_D_id_fk`) VALUES
(6, '2024-03-18', 11, 2, 3),
(7, '2024-03-18', 12, 4, 3),
(8, '2024-03-18', 13, 3, 3),
(9, '2024-03-18', 14, 1, 3),
(10, '2024-03-19', 15, 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `N_id` int(11) NOT NULL,
  `N_R_id_fk` int(11) NOT NULL,
  `N_status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `notification`
--

INSERT INTO `notification` (`N_id`, `N_R_id_fk`, `N_status`) VALUES
(7, 11, 'seen'),
(8, 12, 'seen'),
(9, 13, 'seen'),
(10, 14, 'seen'),
(11, 15, 'seen'),
(13, 21, 'not seen');

-- --------------------------------------------------------

--
-- Table structure for table `request`
--

CREATE TABLE `request` (
  `R_id` int(11) NOT NULL,
  `R_F_id_fk` int(11) NOT NULL,
  `R_food_count` int(11) NOT NULL,
  `R_reason` varchar(500) NOT NULL,
  `R_status` varchar(20) NOT NULL,
  `R_B_id_fk` int(11) NOT NULL,
  `R_date` date NOT NULL,
  `R_reuiredDate` date NOT NULL,
  `R_pickLocation` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `request`
--

INSERT INTO `request` (`R_id`, `R_F_id_fk`, `R_food_count`, `R_reason`, `R_status`, `R_B_id_fk`, `R_date`, `R_reuiredDate`, `R_pickLocation`) VALUES
(11, 4, 1, 'Earth quake', 'Delivered', 3, '2024-02-18', '2024-03-28', 'Jaffna'),
(12, 8, 1, 'Earth quake', 'Delivered', 3, '2024-02-18', '2024-03-28', 'Jaffna'),
(13, 5, 1, 'Earth quake', 'Delivered', 3, '2024-01-18', '2024-03-28', 'Jaffna'),
(14, 3, 1, 'Earth quake', 'Delivered', 3, '2024-12-18', '2024-03-28', 'Jaffna'),
(15, 4, 5, 'Emergency', 'Delivered', 3, '2024-03-19', '2024-03-31', 'Batticaloa'),
(16, 2, 20, 'Emergency', 'Active', 2, '2024-02-20', '2024-03-05', 'Kokkuvil'),
(18, 2, 20, 'Emergency', 'Active', 2, '2023-12-20', '2024-03-05', 'Kokkuvil'),
(21, 9, 10, 'emergency', 'Active', 2, '2024-02-20', '2024-03-29', 'batticaloa');

-- --------------------------------------------------------

--
-- Table structure for table `volunteer`
--

CREATE TABLE `volunteer` (
  `V_id` int(11) NOT NULL,
  `V_name` varchar(50) NOT NULL,
  `V_address` varchar(200) NOT NULL,
  `V_contact` varchar(15) NOT NULL,
  `V_email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `volunteer`
--

INSERT INTO `volunteer` (`V_id`, `V_name`, `V_address`, `V_contact`, `V_email`) VALUES
(1, 'Abilashagan', 'Kokkuvil', '077', 'abi@gmail.com'),
(2, 'kumar', 'kallady', '0789', 'kumar@gmail.com'),
(3, 'suman', 'trinco', '077', 'suman@gmail.com'),
(4, 'Kumar', 'Kandy', '077', 'kumar@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `beneficiary`
--
ALTER TABLE `beneficiary`
  ADD PRIMARY KEY (`B_id`);

--
-- Indexes for table `delivery`
--
ALTER TABLE `delivery`
  ADD PRIMARY KEY (`D_id`),
  ADD KEY `D_H_id_fk` (`D_H_id_fk`);

--
-- Indexes for table `donar`
--
ALTER TABLE `donar`
  ADD PRIMARY KEY (`Dr_id`);

--
-- Indexes for table `donation`
--
ALTER TABLE `donation`
  ADD PRIMARY KEY (`D_id`),
  ADD KEY `D_F_id_fk` (`D_F_id_fk`),
  ADD KEY `D_Dr_id_fk` (`D_Dr_id_fk`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`Fe_id`),
  ADD KEY `Fe_H_id_fk` (`Fe_H_id_fk`);

--
-- Indexes for table `food`
--
ALTER TABLE `food`
  ADD PRIMARY KEY (`F_id`),
  ADD KEY `FT_id_fk` (`FT_id_fk`);

--
-- Indexes for table `food_type`
--
ALTER TABLE `food_type`
  ADD PRIMARY KEY (`FT_id`);

--
-- Indexes for table `handling`
--
ALTER TABLE `handling`
  ADD PRIMARY KEY (`H_id`),
  ADD KEY `H_R_id_fk` (`H_R_id_fk`),
  ADD KEY `H_V_id_fk` (`H_V_id_fk`),
  ADD KEY `H_D_id_fk` (`H_D_id_fk`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`N_id`),
  ADD KEY `N_R_id_fk` (`N_R_id_fk`);

--
-- Indexes for table `request`
--
ALTER TABLE `request`
  ADD PRIMARY KEY (`R_id`),
  ADD KEY `R_F_id_fk` (`R_F_id_fk`),
  ADD KEY `R_B_id_fk` (`R_B_id_fk`);

--
-- Indexes for table `volunteer`
--
ALTER TABLE `volunteer`
  ADD PRIMARY KEY (`V_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `beneficiary`
--
ALTER TABLE `beneficiary`
  MODIFY `B_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `delivery`
--
ALTER TABLE `delivery`
  MODIFY `D_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `donar`
--
ALTER TABLE `donar`
  MODIFY `Dr_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `donation`
--
ALTER TABLE `donation`
  MODIFY `D_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `Fe_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `food`
--
ALTER TABLE `food`
  MODIFY `F_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `food_type`
--
ALTER TABLE `food_type`
  MODIFY `FT_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `handling`
--
ALTER TABLE `handling`
  MODIFY `H_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `N_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `request`
--
ALTER TABLE `request`
  MODIFY `R_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `volunteer`
--
ALTER TABLE `volunteer`
  MODIFY `V_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `delivery`
--
ALTER TABLE `delivery`
  ADD CONSTRAINT `D_H_id_fk` FOREIGN KEY (`D_H_id_fk`) REFERENCES `handling` (`H_id`);

--
-- Constraints for table `donation`
--
ALTER TABLE `donation`
  ADD CONSTRAINT `D_Dr_id_fk` FOREIGN KEY (`D_Dr_id_fk`) REFERENCES `donar` (`Dr_id`),
  ADD CONSTRAINT `D_F_id_fk` FOREIGN KEY (`D_F_id_fk`) REFERENCES `food` (`F_id`);

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `Fe_H_id_fk` FOREIGN KEY (`Fe_H_id_fk`) REFERENCES `handling` (`H_id`);

--
-- Constraints for table `food`
--
ALTER TABLE `food`
  ADD CONSTRAINT `FT_id_fk` FOREIGN KEY (`FT_id_fk`) REFERENCES `food_type` (`FT_id`);

--
-- Constraints for table `handling`
--
ALTER TABLE `handling`
  ADD CONSTRAINT `H_D_id_fk` FOREIGN KEY (`H_D_id_fk`) REFERENCES `donar` (`Dr_id`),
  ADD CONSTRAINT `H_R_id_fk` FOREIGN KEY (`H_R_id_fk`) REFERENCES `request` (`R_id`),
  ADD CONSTRAINT `H_V_id_fk` FOREIGN KEY (`H_V_id_fk`) REFERENCES `volunteer` (`V_id`);

--
-- Constraints for table `notification`
--
ALTER TABLE `notification`
  ADD CONSTRAINT `N_R_id_fk` FOREIGN KEY (`N_R_id_fk`) REFERENCES `request` (`R_id`);

--
-- Constraints for table `request`
--
ALTER TABLE `request`
  ADD CONSTRAINT `R_B_id_fk` FOREIGN KEY (`R_B_id_fk`) REFERENCES `beneficiary` (`B_id`),
  ADD CONSTRAINT `R_F_id_fk` FOREIGN KEY (`R_F_id_fk`) REFERENCES `food` (`F_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
