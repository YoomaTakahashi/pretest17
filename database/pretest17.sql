-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Generation Time: Oct 06, 2026 at 07:24 AM
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

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_evadetail`
--
ALTER TABLE `tb_evadetail`
  ADD PRIMARY KEY (`id_detail`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_evadetail`
--
ALTER TABLE `tb_evadetail`
  MODIFY `id_detail` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
