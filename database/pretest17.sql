-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Generation Time: Oct 06, 2026 at 07:59 AM
-- Server version: 26.7.0
-- PHP Version: 8.3.35

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pretest17`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_eva`
--

CREATE TABLE `tb_eva` (
  `id_eva` int NOT NULL,
  `id_member` int NOT NULL,
  `id_sys` int NOT NULL,
  `status_eva` int NOT NULL,
  `day_eva` date NOT NULL,
  `total_eva` double(10,2) DEFAULT NULL,
  `total_commit` double(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_eva`
--

INSERT INTO `tb_eva` (`id_eva`, `id_member`, `id_sys`, `status_eva`, `day_eva`, `total_eva`, `total_commit`) VALUES
(1, 3, 1, 1, '2026-10-04', NULL, NULL),
(2, 3, 1, 2, '2026-10-04', 0.00, NULL),
(3, 4, 1, 2, '2026-10-04', 30.00, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tb_evadetail`
--

CREATE TABLE `tb_evadetail` (
  `id_detail` int NOT NULL,
  `id_eva` int DEFAULT NULL,
  `id_indicate` int DEFAULT NULL,
  `status_eva` int DEFAULT NULL,
  `detail_eva` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `score_member` int DEFAULT NULL,
  `score_commit` int DEFAULT NULL,
  `file_eva` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_evadetail`
--

INSERT INTO `tb_evadetail` (`id_detail`, `id_eva`, `id_indicate`, `status_eva`, `detail_eva`, `score_member`, `score_commit`, `file_eva`) VALUES
(1, 2, NULL, 1, 'test', 1, NULL, NULL),
(2, 2, NULL, 1, 'teste', 2, NULL, NULL),
(3, 2, NULL, 1, 'test', 3, NULL, NULL),
(4, 2, NULL, 1, 'tesdgsdg', 4, NULL, NULL),
(5, 2, NULL, 1, 'test', 1, NULL, NULL),
(6, 2, NULL, 1, 'teste', 2, NULL, NULL),
(7, 2, NULL, 1, 'test', 3, NULL, NULL),
(8, 2, NULL, 1, 'tesdgsdg', 4, NULL, NULL),
(9, 2, NULL, 1, 'test', 1, NULL, NULL),
(10, 2, NULL, 1, 'teste', 2, NULL, NULL),
(11, 2, NULL, 1, 'test', 3, NULL, NULL),
(12, 2, NULL, 1, 'tesdgsdg', 4, NULL, NULL),
(13, 2, NULL, 1, 'test', 1, NULL, NULL),
(14, 2, NULL, 1, 'teste', 2, NULL, NULL),
(15, 2, NULL, 1, 'test', 3, NULL, NULL),
(16, 2, NULL, 1, 'tesdgsdg', 4, NULL, NULL),
(17, 3, 1, 1, 'kjksdjf', 1, NULL, NULL),
(18, 3, 2, 1, 'dsflkajdskf', 2, NULL, NULL),
(19, 3, 3, 1, 'sdjaflkadsf', 3, NULL, NULL),
(20, 3, 4, 1, 'jaksdlfa;', 4, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tb_indicate`
--

CREATE TABLE `tb_indicate` (
  `id_indicate` int NOT NULL,
  `id_topic` int NOT NULL,
  `name_indicate` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `point_indicate` int NOT NULL,
  `detail_indicate` text NOT NULL,
  `check_indicate` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_indicate`
--

INSERT INTO `tb_indicate` (`id_indicate`, `id_topic`, `name_indicate`, `point_indicate`, `detail_indicate`, `check_indicate`) VALUES
(1, 1, 'aiระบบ', 1, 'ไม่มีรายละเอียด', 'y'),
(2, 1, 'ระบบai', 2, 'มีรายละเอียด ก็ได้', 'n'),
(3, 2, 'คอมพิวเตอร์', 3, 'รายระเอียดคอมพิวเตอร์', 'y'),
(4, 2, 'คอมพิวเตอร์ รายระเอีดย', 4, 'จ้าาาา', 'n');

-- --------------------------------------------------------

--
-- Table structure for table `tb_member`
--

CREATE TABLE `tb_member` (
  `id_member` int NOT NULL,
  `fname` varchar(100) NOT NULL,
  `lname` varchar(100) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `role` enum('ฝ่ายบุคลากร','ผู้รับการประเมินผล','กรรมการประเมิน') NOT NULL,
  `pic_user` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_member`
--

INSERT INTO `tb_member` (`id_member`, `fname`, `lname`, `username`, `email`, `role`, `pic_user`, `password`) VALUES
(1, 'test', 'tests', 'test', 'test@gmail.com', 'ผู้รับการประเมินผล', '', '123456'),
(2, 'test', 'tests', 'test', 'test@gmail.com', 'ผู้รับการประเมินผล', '', '123456'),
(3, ' sommai', ' sommai', ' sommai', ' sommai@gmail.com', 'ผู้รับการประเมินผล', '1791264471966.png', '$2b$10$MjcnztF9QlPpxjgoznPdx.cEhAcMt0PLL9Hr43DkY7WNegWg9pzm6'),
(4, 'supimon', 'supimon', 'supimon', 'supimon@gmail.com', 'ผู้รับการประเมินผล', '1791268994515.png', '[object Promise]');

-- --------------------------------------------------------

--
-- Table structure for table `tb_system`
--

CREATE TABLE `tb_system` (
  `id_sys` int NOT NULL,
  `day_open` date NOT NULL,
  `day_out` date NOT NULL,
  `round_sys` int NOT NULL,
  `year_sys` int NOT NULL,
  `status_sys` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_system`
--

INSERT INTO `tb_system` (`id_sys`, `day_open`, `day_out`, `round_sys`, `year_sys`, `status_sys`) VALUES
(1, '2026-10-01', '2035-10-11', 1, 2569, 'y'),
(2, '2026-10-01', '2035-10-11', 1, 2569, 'y');

-- --------------------------------------------------------

--
-- Table structure for table `tb_topic`
--

CREATE TABLE `tb_topic` (
  `id_topic` int NOT NULL,
  `name_topic` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_topic`
--

INSERT INTO `tb_topic` (`id_topic`, `name_topic`) VALUES
(1, 'ระบบai'),
(2, 'ระบบคอมพิวเตอร์');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_eva`
--
ALTER TABLE `tb_eva`
  ADD PRIMARY KEY (`id_eva`);

--
-- Indexes for table `tb_evadetail`
--
ALTER TABLE `tb_evadetail`
  ADD PRIMARY KEY (`id_detail`);

--
-- Indexes for table `tb_indicate`
--
ALTER TABLE `tb_indicate`
  ADD PRIMARY KEY (`id_indicate`);

--
-- Indexes for table `tb_member`
--
ALTER TABLE `tb_member`
  ADD PRIMARY KEY (`id_member`);

--
-- Indexes for table `tb_system`
--
ALTER TABLE `tb_system`
  ADD PRIMARY KEY (`id_sys`);

--
-- Indexes for table `tb_topic`
--
ALTER TABLE `tb_topic`
  ADD PRIMARY KEY (`id_topic`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_eva`
--
ALTER TABLE `tb_eva`
  MODIFY `id_eva` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tb_evadetail`
--
ALTER TABLE `tb_evadetail`
  MODIFY `id_detail` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `tb_indicate`
--
ALTER TABLE `tb_indicate`
  MODIFY `id_indicate` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tb_member`
--
ALTER TABLE `tb_member`
  MODIFY `id_member` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tb_system`
--
ALTER TABLE `tb_system`
  MODIFY `id_sys` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tb_topic`
--
ALTER TABLE `tb_topic`
  MODIFY `id_topic` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
