-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 20, 2013 at 06:16 AM
-- Server version: 5.5.32
-- PHP Version: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `starline`
--
CREATE DATABASE IF NOT EXISTS `starline` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `starline`;

-- --------------------------------------------------------

--
-- Table structure for table `administrativesupply`
--

CREATE TABLE IF NOT EXISTS `administrativesupply` (
  `AdminSupplyID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Description` varchar(120) NOT NULL,
  `LastOrdered` date NOT NULL,
  `StockLow` tinyint(1) NOT NULL DEFAULT '0',
  `Cost` double unsigned NOT NULL,
  `AmountLeft` double unsigned NOT NULL,
  `Maximum Capacity` double unsigned NOT NULL,
  `NonMedicalSupplyID` int(10) unsigned NOT NULL,
  `SupplyTypeID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`AdminSupplyID`,`NonMedicalSupplyID`,`SupplyTypeID`),
  KEY `fk_AdministrativeSupply_NonMedicalSupplies1_idx` (`NonMedicalSupplyID`,`SupplyTypeID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=25 ;

--
-- Dumping data for table `administrativesupply`
--

INSERT INTO `administrativesupply` (`AdminSupplyID`, `Description`, `LastOrdered`, `StockLow`, `Cost`, `AmountLeft`, `Maximum Capacity`, `NonMedicalSupplyID`, `SupplyTypeID`) VALUES
(1, 'pen', '2012-05-01', 0, 48, 266, 744, 1, 2),
(2, 'pencils', '2012-08-06', 0, 37, 798, 884, 1, 2),
(3, 'highlihters', '2012-08-18', 0, 21, 180, 906, 1, 2),
(4, 'eraser', '2012-02-14', 0, 27, 333, 822, 1, 2),
(5, 'paper', '2012-12-04', 0, 23, 266, 885, 1, 2),
(6, 'envelop', '2012-02-27', 0, 51, 631, 726, 1, 2),
(7, 'invoice', '2012-01-17', 1, 64, 70, 888, 1, 2),
(8, 'catridges', '2013-04-06', 0, 50, 387, 963, 1, 2),
(9, 'keyboard', '2012-11-26', 1, 61, 20, 750, 1, 2),
(10, 'mouse', '2013-04-24', 0, 21, 624, 999, 1, 2),
(11, 'check', '2012-11-12', 0, 20, 545, 773, 1, 2),
(12, 'cd', '2013-04-03', 0, 24, 520, 713, 1, 2),
(13, 'rulers', '2013-03-16', 0, 70, 531, 803, 1, 2),
(14, 'file', '2012-12-18', 0, 43, 343, 709, 1, 2),
(15, 'marker', '2013-04-01', 0, 46, 526, 889, 1, 2),
(16, 'clip', '2012-10-09', 0, 27, 405, 783, 1, 2),
(17, 'time card', '2012-03-10', 0, 47, 356, 732, 1, 2),
(18, 'protective sheet', '2012-02-26', 1, 31, 83, 883, 1, 2),
(19, 'post it', '2013-04-06', 0, 60, 683, 816, 1, 2),
(20, 'letter opener', '2012-10-12', 0, 45, 346, 713, 1, 2),
(21, 'trimmer', '2012-10-15', 0, 24, 311, 725, 1, 2),
(22, 'scissor', '2012-02-06', 1, 61, 93, 959, 1, 2),
(23, 'glue', '2013-01-08', 0, 59, 394, 837, 1, 2),
(24, 'label', '2013-02-08', 0, 52, 300, 301, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE IF NOT EXISTS `appointment` (
  `AppointmentID` int(11) NOT NULL AUTO_INCREMENT,
  `Notes` text,
  `StartTime` datetime NOT NULL,
  `EndTime` datetime NOT NULL,
  `ServiceID` int(11) DEFAULT NULL,
  `RoomID` int(11) DEFAULT NULL,
  `UnitID` int(10) unsigned NOT NULL,
  `PatientID` int(11) DEFAULT NULL,
  PRIMARY KEY (`AppointmentID`),
  KEY `ServiceID_idx` (`ServiceID`),
  KEY `RoomID_idx` (`RoomID`),
  KEY `UnitID_idx` (`UnitID`),
  KEY `PatientID_idx` (`PatientID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=34 ;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`AppointmentID`, `Notes`, `StartTime`, `EndTime`, `ServiceID`, `RoomID`, `UnitID`, `PatientID`) VALUES
(1, 'NULL', '2013-08-13 07:00:00', '2013-08-13 15:00:00', 1, 301, 3, 6055),
(2, 'NULL', '2013-08-13 09:00:00', '2013-08-13 10:00:00', 2, 101, 1, 6096),
(3, 'NULL', '2013-08-14 07:00:00', '2013-08-14 17:00:00', 3, 303, 3, 6344),
(4, 'NULL', '2013-08-15 09:00:00', '2013-08-15 10:00:00', 4, 201, 2, 6315),
(5, 'NULL', '2013-08-16 09:00:00', '2013-08-16 10:00:00', 5, 102, 1, 6363),
(6, 'NULL', '2013-08-12 10:00:00', '2013-08-12 11:00:00', 6, 202, 2, 6383),
(7, 'NULL', '2013-08-15 11:00:00', '2013-08-15 12:00:00', 7, 203, 2, 6470),
(9, 'NULL', '2013-08-13 11:00:00', '2013-08-13 14:00:00', 9, 304, 3, 6481),
(10, 'NULL', '2013-08-15 07:00:00', '2013-08-15 10:00:00', 10, 204, 2, 6523),
(11, 'NULL', '2013-08-15 10:00:00', '2013-08-15 13:00:00', 11, 105, 1, 6581),
(12, 'NULL', '2013-08-14 11:00:00', '2013-08-14 12:00:00', 12, 104, 1, 6596),
(13, 'NULL', '2013-08-16 10:00:00', '2013-08-16 14:00:00', 13, 105, 1, 6835),
(25, NULL, '2013-08-13 10:00:00', '2013-08-18 20:00:00', 3, 303, 3, 6106),
(28, NULL, '2013-08-13 10:00:00', '2013-08-13 16:00:00', 1, 305, 3, 6023),
(29, NULL, '2013-08-13 08:00:00', '2013-08-13 10:00:00', 7, 203, 2, 6067),
(32, NULL, '2013-08-14 08:00:00', '2013-08-14 10:00:00', 9, 304, 3, 6178),
(33, NULL, '2013-08-16 08:00:00', '2013-08-19 10:00:00', 3, 301, 3, 6023);

-- --------------------------------------------------------

--
-- Table structure for table `attendingphysician`
--

CREATE TABLE IF NOT EXISTS `attendingphysician` (
  `JuniorDoctorID` int(10) unsigned NOT NULL,
  `AttendingID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`JuniorDoctorID`,`AttendingID`),
  KEY `fk_Employee_has_Employee_Employee2_idx` (`AttendingID`),
  KEY `fk_Employee_has_Employee_Employee1_idx` (`JuniorDoctorID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `attendingphysician`
--

INSERT INTO `attendingphysician` (`JuniorDoctorID`, `AttendingID`) VALUES
(1003, 1039),
(1095, 1039),
(1013, 1059),
(1051, 1059),
(1265, 1059),
(1034, 1075),
(1043, 1075),
(1094, 1075),
(9, 1076),
(1000, 1076),
(1092, 1076),
(1058, 1083),
(1279, 1083),
(1053, 1084),
(1243, 1084),
(1050, 1098),
(1236, 1098),
(1047, 1201),
(1207, 1201),
(1237, 1201),
(1066, 1219),
(1292, 1219),
(1020, 1234),
(1266, 1234);

-- --------------------------------------------------------

--
-- Table structure for table `basicpatientsupply`
--

CREATE TABLE IF NOT EXISTS `basicpatientsupply` (
  `BasicPatientSupplyID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Description` varchar(120) NOT NULL,
  `LastOrdered` date NOT NULL,
  `StockLow` tinyint(1) NOT NULL DEFAULT '0',
  `Cost` double unsigned NOT NULL,
  `AmountLeft` double unsigned NOT NULL,
  `Maximum Capacity` double unsigned NOT NULL,
  `NonMedicalSupplyID` int(10) unsigned NOT NULL,
  `SupplyTypeID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`BasicPatientSupplyID`,`NonMedicalSupplyID`,`SupplyTypeID`),
  KEY `fk_BasicPatientSupply_NonMedicalSupplies1_idx` (`NonMedicalSupplyID`,`SupplyTypeID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=26 ;

--
-- Dumping data for table `basicpatientsupply`
--

INSERT INTO `basicpatientsupply` (`BasicPatientSupplyID`, `Description`, `LastOrdered`, `StockLow`, `Cost`, `AmountLeft`, `Maximum Capacity`, `NonMedicalSupplyID`, `SupplyTypeID`) VALUES
(1, 'bed', '2012-11-14', 0, 100, 8, 9, 2, 2),
(2, 'pillow', '2012-09-06', 0, 111, 6, 7, 2, 2),
(3, 'pillow case', '2013-01-21', 0, 84, 6, 10, 2, 2),
(4, 'sheet', '2013-03-28', 0, 96, 9, 8, 2, 2),
(5, 'comforter', '2012-04-19', 0, 81, 6, 18, 2, 2),
(6, 'drawsheet', '2012-12-07', 0, 88, 2, 12, 2, 2),
(7, 'diaper', '2013-03-29', 0, 98, 9, 14, 2, 2),
(8, 'tube', '2013-03-03', 0, 98, 8, 18, 2, 2),
(9, 'urin container', '2012-12-25', 0, 117, 2, 17, 2, 2),
(10, 'drapes', '2012-09-21', 0, 98, 6, 6, 2, 2),
(11, 'chair', '2012-11-16', 0, 90, 7, 11, 2, 2),
(12, 'bead table', '2012-02-28', 0, 117, 12, 19, 2, 2),
(13, 'bedside table', '2012-09-02', 0, 80, 14, 18, 2, 2),
(14, 'stool', '2012-09-03', 0, 118, 5, 13, 2, 2),
(15, 'gown', '2013-04-23', 0, 113, 1, 6, 2, 2),
(16, 'paper slippers', '2012-08-20', 0, 102, 8, 8, 2, 2),
(17, 'water pitcher', '2012-05-17', 0, 81, 7, 7, 2, 2),
(18, 'calling bell', '2012-11-14', 0, 116, 4, 5, 2, 2),
(19, 'mattreee', '2012-11-29', 0, 106, 8, 17, 2, 2),
(20, 'mirror', '2012-12-28', 0, 84, 12, 12, 2, 2),
(21, 'foot board', '2012-03-14', 0, 101, 6, 10, 2, 2),
(22, 'paper tissue', '2013-04-05', 0, 106, 16, 18, 2, 2),
(23, 'garbage can', '2012-02-14', 0, 118, 16, 16, 2, 2),
(24, 'iv pole', '2012-09-15', 0, 114, 18, 20, 2, 2),
(25, 'matress', '2103-01-08', 0, 117, 2, 10, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE IF NOT EXISTS `employee` (
  `EmployeeID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(45) NOT NULL,
  `LastName` varchar(45) NOT NULL,
  `Address` varchar(120) DEFAULT NULL,
  `PhoneNumber` varchar(15) DEFAULT NULL,
  `PostalCode` varchar(45) DEFAULT NULL,
  `StartDate` date DEFAULT NULL,
  `UnitID` int(10) unsigned NOT NULL,
  `JobID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`EmployeeID`),
  UNIQUE KEY `EmployeeID_UNIQUE` (`EmployeeID`),
  KEY `fk_Employee_Unit_idx` (`UnitID`),
  KEY `fk_Employee_JobPayroll1_idx` (`JobID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1500 ;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`EmployeeID`, `FirstName`, `LastName`, `Address`, `PhoneNumber`, `PostalCode`, `StartDate`, `UnitID`, `JobID`) VALUES
(8, ' Dollar', ' Narula', ' 123 Something', ' 514 555 5555', ' HOH OHO', '2013-08-10', 1, 1),
(9, ' Max', ' CowPig', ' 66 Wallaby Road', ' (201) 867-5309', ' H4H 4H4', '2010-01-01', 1, 8),
(1000, ' Armand', ' Cochran', ' 603-6264 Praesent Rd.', ' (952) 416-5585', ' G5K 9V9', '2013-04-21', 1, 5),
(1001, ' Donovan', ' Holland', ' Ap #688-2331 Interdum St.', ' (317) 886-3004', ' P1C 9A3', '1998-01-20', 3, 9),
(1002, ' Isabelle', ' Haynes', ' 591-6774 Vehicula. Street', ' (953) 685-7536', ' E1L 7B0', '1995-06-20', 1, 11),
(1003, ' Thane', ' Cook', ' Ap #518-3368 Etiam Avenue', ' (876) 436-9727', ' R6M 3J6', '2011-12-25', 1, 6),
(1005, ' Chantale', ' Rich', ' P.O. Box 686 1128 Adipiscing Rd.', ' (807) 745-5689', ' N5K 4A5', '1995-09-22', 1, 9),
(1006, ' Lucius', ' Finley', ' 2146 Magna. Ave', ' (587) 648-4551', ' P9P 9A5', '2008-07-30', 3, 2),
(1008, ' Allegra', ' Curry', ' Ap #733-6750 At St.', ' (673) 132-4701', ' B6X 9E7', '1999-04-15', 2, 9),
(1009, ' Wyatt', ' Pugh', ' 8474 Mauris Rd.', ' (819) 685-1591', ' N1V 1V2', '2000-07-06', 3, 3),
(1013, ' Damon', ' Freeman', ' 850-8286 Erat Street', ' (125) 192-5616', ' C9Y 6R9', '2012-02-16', 3, 6),
(1014, ' Ria', ' Sutton', ' 787-2124 Etiam Avenue', ' (905) 786-9468', ' S8L 1R5', '1992-05-21', 2, 3),
(1016, ' Abdul', ' Gomez', ' 8638 Neque. Rd.', ' (226) 722-7225', ' C6C 4G2', '2000-11-13', 2, 2),
(1018, ' Basia', ' Tyler', ' P.O. Box 108 9384 Ligula Street', ' (254) 713-0311', ' T4Z 6A2', '1999-05-21', 3, 3),
(1020, ' Leila', ' Reynolds', ' P.O. Box 110 5855 Gravida Rd.', ' (776) 543-5305', ' C7W 8R8', '2012-11-29', 2, 5),
(1021, ' Raymond', ' Craig', ' Ap #565-3539 Nec Rd.', ' (613) 660-4359', ' T5R 1R7', '2002-06-27', 3, 1),
(1025, ' Sloane', ' Hooper', ' 686-644 Nibh. St.', ' (743) 101-8246', ' X5C 7M6', '2007-01-18', 3, 10),
(1030, ' Teagan', ' Steele', ' 340-8545 Netus Street', ' (422) 316-5994', ' A4M 5S9', '2005-09-16', 2, 10),
(1034, ' Cassidy', ' Carr', ' 6348 Etiam Avenue', ' (970) 514-0445', ' S6X 4B7', '2009-09-27', 1, 8),
(1035, ' Sloane', ' Bradford', ' 335-2114 Lectus St.', ' (501) 361-9651', ' N1W 0A5', '2005-10-30', 1, 10),
(1037, ' Olympia', ' Greer', ' 1887 Amet Ave', ' (689) 378-4607', ' Y4H 3J0', '2008-08-21', 3, 10),
(1039, ' Alisa', ' Walker', ' 986-6010 Vulputate Road', ' (584) 429-5026', ' A4K 7C7', '2003-02-20', 1, 4),
(1040, ' Lila', ' Mcgowan', ' 855-9737 Ornare St.', ' (212) 277-0202', ' L2K 7X3', '2002-01-16', 1, 10),
(1042, ' Howard', ' Ramos', ' Ap #139-3074 Et St.', ' (826) 705-4870', ' R6K 5G1', '1996-01-02', 3, 2),
(1043, ' Hector', ' Cabrera', ' 554-6531 Quisque Avenue', ' (162) 190-3583', ' T3X 9G5', '2013-06-12', 1, 5),
(1046, ' Kalia', ' Cohen', ' 317-8507 Feugiat Avenue', ' (559) 347-0022', ' K4S 5J6', '2009-03-14', 2, 11),
(1047, ' Zia', ' Bowers', ' 571-3516 Lacus. St.', ' (257) 432-9354', ' G8B 9V4', '2009-09-23', 3, 8),
(1049, ' Harriet', ' Osborn', ' P.O. Box 585 6257 Nibh. St.', ' (237) 218-2357', ' L2P 2B6', '2007-11-03', 3, 11),
(1050, ' Hamish', ' Washington', ' P.O. Box 608 6935 Elit Avenue', ' (278) 730-0012', ' M2J 2H7', '2010-08-22', 3, 7),
(1051, ' Jermaine', ' Snyder', ' 462-5096 Convallis Rd.', ' (645) 207-9943', ' C7K 5H9', '2010-02-26', 3, 8),
(1053, ' Preston', ' Gross', ' 812-6483 Diam St.', ' (490) 184-2329', ' S7G 0A7', '2009-12-14', 2, 8),
(1058, ' Francesca', ' Weeks', ' Ap #655-7890 Enim. Ave', ' (738) 360-7693', ' L0P 4T9', '2010-07-26', 2, 8),
(1059, ' Scott', ' Knox', ' Ap #566-7830 Felis. Av.', ' (223) 801-1938', ' Y4Z 4X4', '1991-02-25', 3, 4),
(1063, ' Aphrodite', ' Mathews', ' Ap #219-4686 Ante. Rd.', ' (877) 848-4741', ' L3R 2B0', '2000-02-24', 2, 10),
(1065, ' Colt', ' George', ' 146-7949 Suspendisse Street', ' (599) 646-3444', ' B1E 2Y3', '2004-05-29', 2, 1),
(1066, ' Lawrence', ' Daniel', ' 4445 Fusce Street', ' (697) 195-5941', ' V5Y 2N2', '2013-07-18', 2, 5),
(1075, ' Gisela', ' Massey', ' Ap #361-6754 Dolor St.', ' (701) 740-2161', ' K6E 9Z7', '2001-10-04', 1, 4),
(1076, ' Nerea', ' Green', ' Ap #971-8677 Non Street', ' (215) 583-4099', ' S4J 9T7', '2009-06-18', 1, 4),
(1078, ' Bethany', ' Summers', ' Ap #617-7084 Mi. Av.', ' (313) 706-3588', ' C3K 6N7', '1996-01-21', 1, 3),
(1083, ' Quinn', ' Waters', ' 745-6331 Consectetuer St.', ' (166) 476-3892', ' P9T 8Z1', '2006-11-26', 2, 4),
(1084, ' Lunea', ' Taylor', ' 320-1772 Molestie St.', ' (434) 204-8785', ' J4A 5N6', '2008-11-09', 2, 4),
(1085, ' Jillian', ' Doyle', ' 147-3693 Vel Rd.', ' (827) 142-4835', ' G7S 4G0', '2002-03-06', 2, 3),
(1089, ' Damon', ' Duke', ' P.O. Box 274 1543 Vestibulum St.', ' (184) 788-3210', ' Y8N 4X1', '1999-02-01', 1, 3),
(1091, ' Alvin', ' Odom', ' 1686 A Avenue', ' (986) 314-5529', ' C6L 9R7', '1998-10-29', 1, 2),
(1092, ' Ainsley', ' Mooney', ' 386 Semper St.', ' (341) 232-1193', ' T5W 9S1', '2011-11-29', 1, 6),
(1093, ' Armando', ' Golden', ' 2810 Euismod St.', ' (166) 347-5986', ' K9C 7K0', '2008-08-24', 1, 2),
(1094, ' Kennedy', ' Walter', ' Ap #975-5381 Nullam Rd.', ' (945) 976-5490', ' Y0E 0X5', '2011-04-04', 1, 7),
(1095, ' Alfreda', ' Ayala', ' P.O. Box 854 3356 Morbi Road', ' (939) 888-3481', ' B4V 5J7', '2010-10-07', 1, 7),
(1098, ' Brooke', ' Cole', ' Ap #428-7046 A Ave', ' (980) 808-6681', ' N8Z 7A5', '1992-02-28', 3, 4),
(1200, ' Kim', ' Oneill', ' Ap #755-3989 Luctus Street', ' (138) 906-6358', ' A6S 8V3', '2005-03-11', 1, 10),
(1201, ' Ila', ' Duran', ' Ap #617-9803 Convallis Street', ' (395) 126-4154', ' J1C 0L1', '1994-05-09', 3, 4),
(1207, ' Serina', ' Ball', ' 2951 Nec Rd.', ' (678) 345-8293', ' J8V 7W8', '2012-12-16', 3, 5),
(1219, ' Haviva', ' Hardy', ' Ap #945-2348 Praesent St.', ' (978) 369-7582', ' J0R 1H4', '2002-12-10', 2, 4),
(1220, ' Bianca', ' Mcdowell', ' Ap #574-4625 Rhoncus St.', ' (361) 380-9636', ' L3N 7P9', '2012-02-01', 2, 2),
(1229, ' Aiko', ' Stout', ' P.O. Box 462 7270 Mi Rd.', ' (364) 141-3610', ' V6R 7B9', '2004-10-16', 3, 10),
(1231, ' Karen', ' Wheeler', ' P.O. Box 514 9037 Mus. Street', ' (108) 956-7848', ' C8Y 7K8', '2002-10-06', 2, 10),
(1234, ' Macon', ' Gonzalez', ' P.O. Box 669 8111 Metus Rd.', ' (746) 619-5273', ' V3R 5Z5', '2004-03-16', 2, 4),
(1236, ' Fleur', ' Sweet', ' 7977 Hymenaeos. Av.', ' (916) 492-0439', ' G9P 0N3', '2013-04-24', 3, 5),
(1237, ' Anika', ' Sosa', ' 161-8347 Eleifend. Rd.', ' (436) 216-3892', ' J9J 6L6', '2011-11-01', 3, 6),
(1243, ' Latifah', ' Dunlap', ' 766-868 Nisl. Rd.', ' (925) 918-8627', ' K2V 5R1', '2011-10-13', 2, 6),
(1265, ' Magee', ' Fleming', ' P.O. Box 505 8458 Aliquet Ave', ' (685) 500-0454', ' M2A 6A8', '2010-10-23', 3, 7),
(1266, ' Frances', ' Bridges', ' 2195 Consectetuer St.', ' (419) 667-2436', ' X9G 0L8', '2010-10-07', 2, 7),
(1279, ' Kylee', ' Jones', ' 8078 Fringilla Rd.', ' (109) 730-3853', ' Y2Z 4B3', '2011-08-23', 2, 6),
(1292, ' Merrill', ' Collins', ' P.O. Box 952 8262 Egestas Ave', ' (493) 782-8464', ' Y4V 6T1', '2010-12-19', 2, 7),
(1445, ' Neve', ' Deleon', ' Ap #510-4673 Facilisis Av.', ' (729) 482-2739', ' J6L 6N9', '2001-09-27', 3, 12),
(1453, ' Alana', ' Petersen', ' Ap #112-5433 Ipsum Av.', ' (362) 205-8198', ' J0A 0P1', '2012-01-22', 1, 15),
(1454, ' Abigail', ' Rogers', ' 359-9002 Hymenaeos. St.', ' (115) 168-7997', ' J6S 3L0', '2004-10-07', 1, 12),
(1469, ' Rebekah', ' Mcbride', ' Ap #688-213 Etiam Street', ' (902) 906-3359', ' J2K 6L5', '1999-07-31', 3, 14),
(1473, ' Hammett', ' Larsen', ' 1528 Lacus. Rd.', ' (567) 518-8964', ' N7V 7A5', '2011-09-27', 3, 15),
(1483, ' Basil', ' Allen', ' Ap #111-5399 At Ave', ' (339) 393-4948', ' K6S 4E4', '2000-11-30', 2, 13),
(1484, ' Jemima', ' Walker', ' Ap #106-1682 At St.', ' (278) 321-5144', ' X7X 7S3', '1991-04-03', 2, 14),
(1486, ' Cora', ' Nelson', ' 238-3896 Turpis Avenue', ' (699) 514-2659', ' N4B 1P9', '2009-07-17', 1, 14),
(1490, ' Zahir', ' Chavez', ' 9862 Egestas. St.', ' (235) 818-2784', ' Y1Y 5H9', '2003-01-03', 2, 12),
(1492, ' Robert', ' Alston', ' 9627 Eu St.', ' (318) 877-5561', ' M9G 6E0', '1992-06-30', 1, 13),
(1493, ' Lee', ' Sherman', ' 5669 Nullam Street', ' (193) 293-4013', ' J5A 6L1', '2009-10-26', 3, 13),
(1499, ' Whitney', ' Knox', ' Ap #427-3812 Arcu. Road', ' (106) 137-0168', ' T0J 4W3', '2009-05-26', 2, 15);

-- --------------------------------------------------------

--
-- Table structure for table `employee_appointment`
--

CREATE TABLE IF NOT EXISTS `employee_appointment` (
  `EmployeeID` int(10) unsigned NOT NULL,
  `AppointmentID` int(11) NOT NULL,
  PRIMARY KEY (`EmployeeID`,`AppointmentID`),
  KEY `ea_EmployeeID_idx` (`EmployeeID`),
  KEY `ea_AppointmentID_idx` (`AppointmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee_appointment`
--

INSERT INTO `employee_appointment` (`EmployeeID`, `AppointmentID`) VALUES
(1001, 6),
(1003, 33),
(1005, 5),
(1025, 7),
(1034, 11),
(1039, 25),
(1039, 28),
(1039, 29),
(1039, 33),
(1043, 2),
(1043, 4),
(1047, 32),
(1063, 1),
(1083, 32),
(1094, 10),
(1095, 13),
(1200, 9),
(1200, 12),
(1231, 3),
(1231, 33),
(1234, 1),
(1234, 3),
(1236, 32),
(1257, 28),
(1266, 1),
(1266, 3),
(1270, 25),
(1270, 28),
(1294, 25);

-- --------------------------------------------------------

--
-- Table structure for table `employee_schedule`
--

CREATE TABLE IF NOT EXISTS `employee_schedule` (
  `EmployeeID` int(10) unsigned NOT NULL,
  `ScheduleID` int(11) NOT NULL,
  PRIMARY KEY (`EmployeeID`,`ScheduleID`),
  KEY `es_ScheduleID_idx` (`ScheduleID`),
  KEY `fk_EmployeeID_idx` (`EmployeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employee_schedule`
--

INSERT INTO `employee_schedule` (`EmployeeID`, `ScheduleID`) VALUES
(8, 1),
(1002, 1),
(1006, 1),
(1009, 1),
(1014, 1),
(1016, 1),
(1018, 1),
(1021, 1),
(1042, 1),
(1046, 1),
(1049, 1),
(1065, 1),
(1078, 1),
(1085, 1),
(1091, 1),
(1093, 1),
(1220, 1),
(1445, 1),
(1453, 1),
(1454, 1),
(1469, 1),
(1477, 1),
(1483, 1),
(1484, 1),
(1486, 1),
(1490, 1),
(1492, 1),
(1493, 1),
(1499, 1),
(8, 2),
(1002, 2),
(1006, 2),
(1009, 2),
(1014, 2),
(1016, 2),
(1018, 2),
(1021, 2),
(1042, 2),
(1046, 2),
(1049, 2),
(1065, 2),
(1078, 2),
(1085, 2),
(1091, 2),
(1093, 2),
(1220, 2),
(1445, 2),
(1453, 2),
(1454, 2),
(1469, 2),
(1477, 2),
(1483, 2),
(1484, 2),
(1486, 2),
(1490, 2),
(1492, 2),
(1493, 2),
(1499, 2),
(8, 3),
(1002, 3),
(1006, 3),
(1009, 3),
(1014, 3),
(1016, 3),
(1018, 3),
(1021, 3),
(1042, 3),
(1046, 3),
(1049, 3),
(1065, 3),
(1078, 3),
(1085, 3),
(1091, 3),
(1093, 3),
(1220, 3),
(1445, 3),
(1453, 3),
(1454, 3),
(1469, 3),
(1477, 3),
(1483, 3),
(1484, 3),
(1486, 3),
(1490, 3),
(1492, 3),
(1493, 3),
(1499, 3),
(8, 4),
(1002, 4),
(1006, 4),
(1009, 4),
(1014, 4),
(1016, 4),
(1018, 4),
(1021, 4),
(1042, 4),
(1046, 4),
(1049, 4),
(1065, 4),
(1078, 4),
(1085, 4),
(1091, 4),
(1093, 4),
(1220, 4),
(1445, 4),
(1453, 4),
(1454, 4),
(1469, 4),
(1477, 4),
(1483, 4),
(1484, 4),
(1486, 4),
(1490, 4),
(1492, 4),
(1493, 4),
(1499, 4),
(8, 5),
(1002, 5),
(1006, 5),
(1009, 5),
(1014, 5),
(1016, 5),
(1018, 5),
(1021, 5),
(1042, 5),
(1046, 5),
(1049, 5),
(1065, 5),
(1078, 5),
(1085, 5),
(1091, 5),
(1093, 5),
(1220, 5),
(1445, 5),
(1453, 5),
(1454, 5),
(1469, 5),
(1477, 5),
(1483, 5),
(1484, 5),
(1486, 5),
(1490, 5),
(1492, 5),
(1493, 5),
(1499, 5),
(1499, 6),
(1001, 7),
(1020, 7),
(1034, 7),
(1043, 7),
(1050, 7),
(1075, 7),
(1094, 7),
(1098, 7),
(1200, 7),
(1231, 7),
(1234, 7),
(1236, 7),
(1266, 7),
(9, 8),
(1000, 8),
(1013, 8),
(1030, 8),
(1035, 8),
(1037, 8),
(1051, 8),
(1059, 8),
(1066, 8),
(1076, 8),
(1092, 8),
(1219, 8),
(1265, 8),
(1292, 8),
(1003, 9),
(1005, 9),
(1020, 9),
(1034, 9),
(1039, 9),
(1043, 9),
(1063, 9),
(1075, 9),
(1094, 9),
(1095, 9),
(1200, 9),
(1231, 9),
(1234, 9),
(1266, 9),
(9, 10),
(1000, 10),
(1013, 10),
(1030, 10),
(1040, 10),
(1051, 10),
(1059, 10),
(1066, 10),
(1076, 10),
(1092, 10),
(1219, 10),
(1229, 10),
(1265, 10),
(1292, 10),
(1001, 11),
(1020, 11),
(1034, 11),
(1043, 11),
(1050, 11),
(1075, 11),
(1094, 11),
(1098, 11),
(1200, 11),
(1231, 11),
(1234, 11),
(1236, 11),
(1266, 11),
(9, 12),
(1000, 12),
(1005, 12),
(1035, 12),
(1053, 12),
(1066, 12),
(1076, 12),
(1084, 12),
(1092, 12),
(1219, 12),
(1229, 12),
(1243, 12),
(1292, 12),
(1001, 13),
(1020, 13),
(1025, 13),
(1034, 13),
(1043, 13),
(1063, 13),
(1075, 13),
(1094, 13),
(1234, 13),
(1266, 13),
(9, 14),
(1000, 14),
(1005, 14),
(1013, 14),
(1040, 14),
(1051, 14),
(1059, 14),
(1066, 14),
(1076, 14),
(1092, 14),
(1219, 14),
(1229, 14),
(1265, 14),
(1292, 14),
(1003, 15),
(1005, 15),
(1025, 15),
(1039, 15),
(1050, 15),
(1053, 15),
(1084, 15),
(1095, 15),
(1098, 15),
(1231, 15),
(1236, 15),
(1243, 15),
(1008, 16),
(1035, 16),
(1047, 16),
(1058, 16),
(1083, 16),
(1201, 16),
(1207, 16),
(1237, 16),
(1279, 16),
(1003, 17),
(1025, 17),
(1039, 17),
(1053, 17),
(1063, 17),
(1084, 17),
(1095, 17),
(1243, 17),
(1008, 18),
(1013, 18),
(1040, 18),
(1047, 18),
(1051, 18),
(1058, 18),
(1059, 18),
(1083, 18),
(1201, 18),
(1207, 18),
(1237, 18),
(1265, 18),
(1279, 18),
(1003, 19),
(1037, 19),
(1039, 19),
(1050, 19),
(1053, 19),
(1063, 19),
(1084, 19),
(1095, 19),
(1098, 19),
(1236, 19),
(1243, 19),
(1008, 20),
(1030, 20),
(1040, 20),
(1047, 20),
(1058, 20),
(1083, 20),
(1201, 20),
(1207, 20),
(1237, 20),
(1279, 20);

-- --------------------------------------------------------

--
-- Table structure for table `jobpayroll`
--

CREATE TABLE IF NOT EXISTS `jobpayroll` (
  `JobID` int(10) unsigned NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Payroll` decimal(15,5) unsigned NOT NULL,
  `WageRate` varchar(45) NOT NULL,
  `OvertimeMultiplier` decimal(10,5) DEFAULT NULL,
  PRIMARY KEY (`JobID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jobpayroll`
--

INSERT INTO `jobpayroll` (`JobID`, `Name`, `Payroll`, `WageRate`, `OvertimeMultiplier`) VALUES
(1, 'Director', '125000.00000', 'year', '0.00000'),
(2, 'Senior Administrator', '98000.00000', 'year', '0.00000'),
(3, 'Administrator', '78500.00000', 'year', '0.00000'),
(4, 'Doctor', '0.00000', 'service', '0.00000'),
(5, 'Intern', '40000.00000', 'year', '0.00000'),
(6, 'Resident 1st Year', '42000.00000', 'year', '0.00000'),
(7, 'Resident 2nd Year', '44000.00000', 'year', '0.00000'),
(8, 'Resident 3rd Year', '46000.00000', 'year', '0.00000'),
(9, 'Supervisor Nurse', '28.25000', 'hour', '1.25000'),
(10, 'Nurse', '24.50000', 'hour', '1.25000'),
(11, 'Technician X-Ray', '18.50000', 'hour', '1.50000'),
(12, 'Technician Computer', '18.00000', 'hour', '1.50000'),
(13, 'Technician Blood-Work', '17.50000', 'hour', '1.50000'),
(14, 'Technician Sterilization', '16.00000', 'hour', '1.50000'),
(15, 'Technician Pediatric', '16.00000', 'hour', '1.50000');

-- --------------------------------------------------------

--
-- Table structure for table `medicalsupplies`
--

CREATE TABLE IF NOT EXISTS `medicalsupplies` (
  `SupplyTypeID` int(10) unsigned NOT NULL,
  `MedicalSupplyID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Type` varchar(45) NOT NULL,
  PRIMARY KEY (`MedicalSupplyID`,`SupplyTypeID`),
  KEY `fk_MedicalSupplies_Supplies_idx` (`SupplyTypeID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `medicalsupplies`
--

INSERT INTO `medicalsupplies` (`SupplyTypeID`, `MedicalSupplyID`, `Type`) VALUES
(1, 1, 'Medication'),
(1, 2, 'Surgical Equipment'),
(1, 3, 'Supporting Devices');

-- --------------------------------------------------------

--
-- Table structure for table `medication`
--

CREATE TABLE IF NOT EXISTS `medication` (
  `SupplyTypeID` int(10) unsigned NOT NULL,
  `MedicationID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `MedicalSupplyID` int(10) unsigned NOT NULL,
  `Description` varchar(120) NOT NULL,
  `LastOrdered` date NOT NULL,
  `Cost` double unsigned NOT NULL,
  `AmountLeft` double unsigned NOT NULL,
  `Maximum Capacity` double unsigned NOT NULL,
  PRIMARY KEY (`MedicationID`,`SupplyTypeID`,`MedicalSupplyID`),
  KEY `fk_Medication_MedicalSupplies1_idx` (`SupplyTypeID`,`MedicalSupplyID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=50 ;

--
-- Dumping data for table `medication`
--

INSERT INTO `medication` (`SupplyTypeID`, `MedicationID`, `MedicalSupplyID`, `Description`, `LastOrdered`, `Cost`, `AmountLeft`, `Maximum Capacity`) VALUES
(1, 1, 1, 'Adderall', '2012-05-14', 155, 152, 152),
(1, 2, 1, 'Ambien', '2012-08-04', 121, 195, 195),
(1, 3, 1, 'Amitriptyline', '2012-11-15', 186, 22, 160),
(1, 4, 1, 'Amoxicillin', '2012-03-17', 97, 59, 174),
(1, 5, 1, 'Atenolol', '2012-04-19', 131, 62, 157),
(1, 6, 1, 'Ativan', '2012-03-22', 62, 28, 195),
(1, 7, 1, 'Cephalexin', '2012-07-16', 196, 50, 193),
(1, 8, 1, 'Clonidine', '2013-01-02', 196, 102, 173),
(1, 9, 1, 'Cymbalta', '2013-01-04', 86, 86, 190),
(1, 10, 1, 'Diazepam', '2012-07-11', 76, 16, 175),
(1, 11, 1, 'Flexeril', '2013-04-10', 120, 26, 187),
(1, 12, 1, 'Gabapentin', '2012-03-30', 189, 105, 182),
(1, 13, 1, 'Hydrochlorothiazide', '2012-02-03', 95, 6, 188),
(1, 14, 1, 'Klonopin', '2012-06-04', 126, 82, 167),
(1, 15, 1, 'Lexapro', '2012-05-24', 50, 40, 188),
(1, 16, 1, 'Lipitor', '2012-02-24', 184, 14, 161),
(1, 17, 1, 'Lisinopril', '2012-11-24', 55, 156, 195),
(1, 18, 1, 'Lorazepam', '2012-10-05', 138, 35, 160),
(1, 19, 1, 'Lyrica', '2012-06-12', 111, 67, 186),
(1, 20, 1, 'Metformin', '2012-06-20', 62, 157, 190),
(1, 21, 1, 'Methadone', '2012-10-08', 171, 142, 175),
(1, 22, 1, 'Methocarbamol', '2012-11-23', 180, 9, 153),
(1, 23, 1, 'Metoprolol', '2012-01-01', 52, 135, 166),
(1, 24, 1, 'Morphine', '2012-06-23', 190, 82, 186),
(1, 25, 1, 'Neurontin', '2012-03-02', 133, 86, 189),
(1, 26, 1, 'Naproxen', '2012-10-08', 91, 110, 169),
(1, 27, 1, 'Omeprazole', '2013-03-17', 54, 116, 156),
(1, 28, 1, 'Oxycodone', '2012-07-03', 174, 76, 165),
(1, 29, 1, 'OxyContin', '2012-07-13', 121, 86, 188),
(1, 30, 1, 'Percocet', '2012-03-08', 124, 129, 180),
(1, 31, 1, 'Phentermine', '2013-04-23', 85, 68, 174),
(1, 32, 1, 'Seroquel', '2012-10-02', 157, 8, 189),
(1, 33, 1, 'Skelaxin', '2012-01-01', 127, 14, 152),
(1, 34, 1, 'Soma', '2013-04-14', 155, 49, 170),
(1, 35, 1, 'Tramadol', '2012-12-31', 142, 158, 193),
(1, 36, 1, 'Trazodone', '2012-10-23', 134, 155, 171),
(1, 37, 1, 'Valium', '2012-03-23', 132, 43, 154),
(1, 38, 1, 'Vicodin', '2012-02-05', 199, 146, 152),
(1, 39, 1, 'Xanax', '2012-02-13', 100, 76, 192),
(1, 40, 1, 'Zoloft', '2012-04-03', 181, 6, 196),
(1, 41, 1, 'Dafalgan', '2012-09-04', 54, 12, 175),
(1, 42, 1, 'Demerol', '2013-03-26', 73, 17, 184),
(1, 43, 1, 'Lipidil', '2013-04-02', 175, 180, 185),
(1, 44, 1, 'Calciparine', '2012-09-06', 69, 196, 196),
(1, 45, 1, 'Balsolen', '2012-01-25', 90, 150, 155),
(1, 46, 1, 'Fabrisim', '2012-01-31', 118, 160, 175),
(1, 47, 1, 'Gelox', '2012-09-15', 125, 146, 179),
(1, 48, 1, 'Inexium', '2013-03-13', 166, 128, 181),
(1, 49, 1, 'Kendix', '2012-08-12', 92, 100, 166);

-- --------------------------------------------------------

--
-- Table structure for table `medication_list`
--

CREATE TABLE IF NOT EXISTS `medication_list` (
  `MedicationListID` int(11) NOT NULL,
  `MedicationID` int(11) NOT NULL,
  PRIMARY KEY (`MedicationID`),
  UNIQUE KEY `MedicationID_UNIQUE` (`MedicationID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `medication_list`
--

INSERT INTO `medication_list` (`MedicationListID`, `MedicationID`) VALUES
(13, 2),
(15, 5),
(1, 7),
(12, 9),
(12, 10),
(1, 11),
(10, 13),
(8, 14),
(8, 15),
(5, 16),
(2, 17),
(5, 18),
(11, 19),
(9, 21),
(8, 22),
(2, 23),
(8, 25),
(9, 29),
(8, 31),
(15, 32),
(12, 33),
(6, 36),
(12, 37),
(6, 40),
(4, 41),
(14, 44),
(4, 45),
(7, 47),
(12, 48),
(6, 49);

-- --------------------------------------------------------

--
-- Table structure for table `nonmedicalsupplies`
--

CREATE TABLE IF NOT EXISTS `nonmedicalsupplies` (
  `NonMedicalSupplyID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Type` varchar(45) NOT NULL,
  `SupplyTypeID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`NonMedicalSupplyID`,`SupplyTypeID`),
  KEY `fk_NonMedicalSupplies_Supplies1_idx` (`SupplyTypeID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `nonmedicalsupplies`
--

INSERT INTO `nonmedicalsupplies` (`NonMedicalSupplyID`, `Type`, `SupplyTypeID`) VALUES
(1, 'Administrative Supplies', 2),
(2, 'Basic Patient Materials', 2);

-- --------------------------------------------------------

--
-- Table structure for table `nutritionalsupply`
--

CREATE TABLE IF NOT EXISTS `nutritionalsupply` (
  `NutritionalSupplyID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Type` varchar(45) NOT NULL,
  `LastOrdered` date NOT NULL,
  `NeedsFill` tinyint(1) NOT NULL DEFAULT '0',
  `SupplyTypeID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`NutritionalSupplyID`,`SupplyTypeID`),
  KEY `fk_NutritionalSupply_Supplies1_idx` (`SupplyTypeID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=51 ;

--
-- Dumping data for table `nutritionalsupply`
--

INSERT INTO `nutritionalsupply` (`NutritionalSupplyID`, `Type`, `LastOrdered`, `NeedsFill`, `SupplyTypeID`) VALUES
(1, 'menu', '2013-08-03', 0, 3),
(2, 'food tray', '2013-08-03', 0, 3),
(3, 'glasses', '2013-08-06', 0, 3),
(4, 'cup forks', '2013-08-07', 0, 3),
(5, 'knifes', '2013-08-05', 0, 3),
(6, 'spoon', '2013-08-09', 0, 3),
(7, 'plates', '2013-07-29', 1, 3),
(8, 'napkins', '2013-08-07', 0, 3),
(9, 'salt and pepper', '2013-08-03', 0, 3),
(10, 'sidecup', '2013-07-29', 1, 3),
(11, 'sugar', '2013-08-04', 0, 3),
(12, 'tea bag', '2013-07-27', 1, 3),
(13, 'tray troller', '2013-07-27', 1, 3),
(14, 'soup', '2013-08-03', 0, 3),
(15, 'jello', '2013-08-14', 0, 3),
(16, 'pudding', '2013-08-08', 0, 3),
(17, 'fruit cup', '2013-08-12', 0, 3),
(18, 'coffee', '2013-08-06', 0, 3),
(19, 'butter cup', '2013-08-06', 0, 3),
(20, 'potatoes', '2013-07-30', 1, 3),
(21, 'green beans', '2013-08-14', 0, 3),
(22, 'cauliflower', '2013-08-13', 0, 3),
(23, 'bread', '2013-08-02', 0, 3),
(24, 'chicken', '2013-08-07', 0, 3),
(25, 'roast beef', '2013-08-10', 0, 3),
(26, 'salisburry steak', '2013-08-03', 0, 3),
(27, 'veal escalope', '2013-08-04', 0, 3),
(28, 'turkey escaplope', '2013-08-07', 0, 3),
(29, 'rice', '2013-08-13', 0, 3),
(30, 'pastrie', '2013-08-08', 0, 3),
(31, 'cabbage', '2013-08-14', 0, 3),
(32, 'brocoli', '2013-08-08', 0, 3),
(33, 'spaghetti', '2013-08-11', 0, 3),
(34, 'lasagna', '2013-08-13', 0, 3),
(35, 'salade', '2013-08-09', 0, 3),
(36, 'carotte', '2013-08-09', 0, 3),
(37, 'beet', '2013-07-27', 1, 3),
(38, 'beef stew', '2013-08-05', 0, 3),
(39, 'cookies', '2013-07-27', 1, 3),
(40, 'mash potatoes', '2013-08-10', 0, 3),
(41, 'pancakes', '2013-08-13', 0, 3),
(42, 'salmon', '2013-07-29', 1, 3),
(43, 'white fish', '2013-07-28', 1, 3),
(44, 'oranges', '2013-08-06', 0, 3),
(45, 'omelettes', '2013-07-27', 1, 3),
(46, 'eggs', '2013-08-12', 0, 3),
(47, 'tomatoes', '2013-08-11', 0, 3),
(48, 'apple pies', '2013-08-01', 1, 3),
(49, 'oatmeal', '2013-08-02', 0, 3),
(50, 'ham', '2013-08-05', 0, 3);

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE IF NOT EXISTS `patient` (
  `HospitalCardID` int(11) NOT NULL AUTO_INCREMENT,
  `MedicareNumber` int(11) NOT NULL,
  `FirstName` varchar(45) NOT NULL,
  `LastName` varchar(45) NOT NULL,
  `MedicationListID` int(11) DEFAULT NULL,
  `DoctorNotes` text,
  `DoctorID` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`HospitalCardID`),
  UNIQUE KEY `MedicareNumber_UNIQUE` (`MedicareNumber`),
  UNIQUE KEY `HospitalCardID_UNIQUE` (`HospitalCardID`),
  KEY `MedicationListID_idx` (`MedicationListID`),
  KEY `DoctorID_idx` (`DoctorID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6994 ;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`HospitalCardID`, `MedicareNumber`, `FirstName`, `LastName`, `MedicationListID`, `DoctorNotes`, `DoctorID`) VALUES
(6023, 431805, 'Ingrid', 'Mcmillan', NULL, 'NULL', 1226),
(6025, 503425, 'Joan', 'Hubbard', NULL, 'NULL', 1433),
(6031, 691419, 'Abraham', 'Elliott', NULL, 'NULL', 1201),
(6036, 775839, 'Neil', 'Carter', NULL, 'NULL', 1039),
(6047, 360355, 'Lacota', 'Howell', NULL, 'NULL', 1465),
(6055, 252435, 'Olga', 'Riley', NULL, 'NULL', 1473),
(6067, 782866, 'Lawrence', 'Reilly', NULL, 'NULL', 1254),
(6070, 504649, 'Ivory', 'Sampson', NULL, 'NULL', 1039),
(6090, 608017, 'Serina', 'Davidson', NULL, 'NULL', 1222),
(6095, 338171, 'Tate', 'Carpenter', NULL, 'NULL', 1222),
(6096, 119366, 'Vera', 'Vargas', NULL, 'NULL', 1433),
(6106, 685929, 'Jonas', 'Castro', NULL, 'NULL', 1466),
(6114, 908431, 'Cherokee', 'Leblanc', NULL, 'NULL', 1097),
(6119, 564536, 'Richard', 'English', NULL, 'NULL', 1433),
(6128, 752855, 'Wesley', 'Puckett', NULL, 'NULL', 1076),
(6131, 538046, 'Axel', 'Smith', NULL, 'NULL', 1059),
(6178, 550679, 'Aaron', 'Clayton', NULL, 'NULL', 1098),
(6185, 726343, 'Paul', 'Dunn', NULL, 'NULL', 1201),
(6197, 814567, 'Jolie', 'Rojas', NULL, 'NULL', 1084),
(6198, 370140, 'Steel', 'Sanford', NULL, 'NULL', 1083),
(6202, 171641, 'Fleur', 'Berry', NULL, 'NULL', 1219),
(6210, 324016, 'Vernon', 'Kemp', NULL, 'NULL', 1226),
(6212, 240118, 'Clio', 'Shield', NULL, 'NULL', 1083),
(6217, 461893, 'Phyllis', 'Mckinney', NULL, 'NULL', 1039),
(6231, 908682, 'Mark', 'Clark', NULL, 'NULL', 1254),
(6232, 637854, 'Darius', 'Hunt', NULL, 'NULL', 1098),
(6236, 667654, 'Xandra', 'Jordan', NULL, 'NULL', 1075),
(6237, 987686, 'Freyar', 'Fisher', NULL, 'NULL', 1465),
(6239, 339407, 'Sarah', 'Mullins', NULL, 'NULL', 1465),
(6241, 458537, 'Xena', 'Gomez', NULL, 'NULL', 1087),
(6246, 760713, 'Lucy', 'Shannon', NULL, 'NULL', 1254),
(6254, 188004, 'Blaine', 'Vasquez', NULL, 'NULL', 1219),
(6255, 200805, 'Wayne', 'Herring', NULL, 'NULL', 1476),
(6260, 821091, 'Robin', 'Hogan', NULL, 'NULL', 1098),
(6261, 374634, 'Rigel', 'Fields', NULL, 'NULL', 1222),
(6285, 515138, 'Mannix', 'Ball', NULL, 'NULL', 1083),
(6294, 368506, 'Rina', 'Cross', NULL, 'NULL', 1201),
(6295, 235450, 'Guinevere', 'Faulkner', NULL, 'NULL', 1097),
(6315, 879541, 'Berk', 'Little', NULL, 'NULL', 1087),
(6317, 105972, 'Rina', 'Camacho', NULL, 'NULL', 1075),
(6322, 137516, 'Cadman', 'Boyer', NULL, 'NULL', 1083),
(6340, 197903, 'Brett', 'Park', NULL, 'NULL', 1466),
(6344, 820055, 'Fuller', 'Mendez', NULL, 'NULL', 1084),
(6363, 312001, 'Blaines', 'Foreman', NULL, 'NULL', 1076),
(6383, 338845, 'Morgan', 'Burton', NULL, 'NULL', 1476),
(6451, 793601, 'Farrah', 'Mcmahon', NULL, 'NULL', 1467),
(6457, 340841, 'Cole', 'Patton', NULL, 'NULL', 1234),
(6458, 557770, 'Lucas', 'Pacheco', NULL, 'NULL', 1222),
(6470, 244089, 'Nola', 'Tran', NULL, 'NULL', 1084),
(6473, 924269, 'Walker', 'Hyde', NULL, 'NULL', 1473),
(6474, 629752, 'Nathaniel', 'William', NULL, 'NULL', 1083),
(6476, 756945, 'Blake', 'Delgado', NULL, 'NULL', 1234),
(6479, 373001, 'Graham', 'Alford', NULL, 'NULL', 1467),
(6481, 258728, 'Lillian', 'Garcia', NULL, 'NULL', 1039),
(6484, 189401, 'Guinevere', 'Romero', NULL, 'NULL', 1234),
(6492, 425314, 'Hiram', 'Mcconnell', NULL, 'NULL', 1059),
(6523, 565690, 'Keefe', 'Noel', NULL, 'NULL', 1059),
(6550, 577487, 'Zena', 'Gordon', NULL, 'NULL', 1476),
(6566, 148756, 'Athea', 'Wilkerson', NULL, 'NULL', 1084),
(6581, 563759, 'Hoyt', 'Hyde', NULL, 'NULL', 1219),
(6590, 726708, 'Vincent', 'Johnson', NULL, 'NULL', 1076),
(6592, 275797, 'Indigo', 'Gregory', NULL, 'NULL', 1433),
(6594, 133004, 'Adren', 'Shaw', NULL, 'NULL', 1087),
(6596, 314891, 'Solomon', 'Hodge', NULL, 'NULL', 1473),
(6614, 717518, 'Yolanda', 'Ross', NULL, 'NULL', 1473),
(6651, 561976, 'Wallace', 'Talley', NULL, 'NULL', 1226),
(6662, 785733, 'Whitney', 'Byers', NULL, 'NULL', 1219),
(6670, 747880, 'Diana', 'Bryant', NULL, 'NULL', 1097),
(6672, 781679, 'Damian', 'Bowen', NULL, 'NULL', 1075),
(6679, 310299, 'Ignatius', 'Ware', NULL, 'NULL', 1098),
(6685, 742370, 'Paula', 'Walter', NULL, 'NULL', 1226),
(6689, 795544, 'Justin', 'Foster', NULL, 'NULL', 1466),
(6708, 405890, 'Kennedy', 'Montgomery', NULL, 'NULL', 1087),
(6739, 360986, 'Galvin', 'Walton', NULL, 'NULL', 1254),
(6747, 644260, 'Lilith', 'Cline', NULL, 'NULL', 1249),
(6753, 259593, 'Leonard', 'Combs', NULL, 'NULL', 1084),
(6757, 599305, 'Ignatius', 'Gregory', NULL, 'NULL', 1097),
(6771, 663206, 'Alexander', 'Cherry', NULL, 'NULL', 1249),
(6781, 809957, 'Abraham', 'Maxwell', NULL, 'NULL', 1249),
(6783, 118887, 'Vera', 'Ellison', NULL, 'NULL', 1097),
(6797, 700688, 'Ifeoma', 'Hamilton', NULL, 'NULL', 1059),
(6806, 445144, 'Roanna', 'Sanders', NULL, 'NULL', 1039),
(6835, 497237, 'Donovan', 'Wood', NULL, 'NULL', 1076),
(6836, 828562, 'Isaac', 'Mcpherson', NULL, 'NULL', 1076),
(6854, 893147, 'Adele', 'Mack', NULL, 'NULL', 1219),
(6858, 310958, 'Joshua', 'Mills', NULL, 'NULL', 1466),
(6864, 926628, 'Kelly', 'Mccal', NULL, 'NULL', 1467),
(6890, 892350, 'Ariel', 'Underwood', NULL, 'NULL', 1467),
(6897, 615494, 'Trevor', 'Curry', NULL, 'NULL', 1249),
(6898, 692757, 'Leandra', 'Rose', NULL, 'NULL', 1098),
(6925, 724003, 'Otto', 'Cervantes', NULL, 'NULL', 1465),
(6935, 661400, 'Zelenia', 'Garner', NULL, 'NULL', 1222),
(6947, 239818, 'Isabelle', 'Pace', NULL, 'NULL', 1476),
(6948, 689603, 'Maxwell', 'Myers', NULL, 'NULL', 1059),
(6953, 903526, 'Trevor', 'Gillespie', NULL, 'NULL', 1201),
(6960, 674794, 'Tasha', 'Haley', NULL, 'NULL', 1234),
(6968, 658953, 'Ora', 'Bonner', NULL, 'NULL', 1075),
(6969, 228495, 'Davis', 'Gilmore', NULL, 'NULL', 1087),
(6987, 172046, 'Cameran', 'Barber', NULL, 'NULL', 1075),
(6993, 911602, 'Xyla', 'Ayala', NULL, 'NULL', 1201);

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE IF NOT EXISTS `room` (
  `RoomID` int(11) NOT NULL,
  `UnitID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`RoomID`,`UnitID`),
  KEY `Unit_ID` (`UnitID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`RoomID`, `UnitID`) VALUES
(101, 1),
(102, 1),
(103, 1),
(104, 1),
(105, 1),
(201, 2),
(202, 2),
(203, 2),
(204, 2),
(205, 2),
(206, 2),
(207, 2),
(301, 3),
(302, 3),
(303, 3),
(304, 3),
(305, 3);

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE IF NOT EXISTS `schedule` (
  `ShiftID` int(11) NOT NULL AUTO_INCREMENT,
  `StartTime` datetime NOT NULL,
  `EndTime` datetime NOT NULL,
  PRIMARY KEY (`ShiftID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

--
-- Dumping data for table `schedule`
--

INSERT INTO `schedule` (`ShiftID`, `StartTime`, `EndTime`) VALUES
(1, '2013-08-12 09:00:00', '2013-08-12 17:00:00'),
(2, '2013-08-13 09:00:00', '2013-08-13 17:00:00'),
(3, '2013-08-14 09:00:00', '2013-08-14 17:00:00'),
(4, '2013-08-15 09:00:00', '2013-08-15 17:00:00'),
(5, '2013-08-16 09:00:00', '2013-08-16 17:00:00'),
(6, '2013-08-17 09:00:00', '2013-08-17 12:00:00'),
(7, '2013-08-12 07:00:00', '2013-08-12 19:00:00'),
(8, '2013-08-12 19:00:00', '2013-08-13 07:00:00'),
(9, '2013-08-13 07:00:00', '2013-08-13 19:00:00'),
(10, '2013-08-13 19:00:00', '2013-08-14 07:00:00'),
(11, '2013-08-14 07:00:00', '2013-08-14 19:00:00'),
(12, '2013-08-14 19:00:00', '2013-08-15 07:00:00'),
(13, '2013-08-15 07:00:00', '2013-08-15 19:00:00'),
(14, '2013-08-15 19:00:00', '2013-08-16 07:00:00'),
(15, '2013-08-16 07:00:00', '2013-08-16 19:00:00'),
(16, '2013-08-16 19:00:00', '2013-08-17 07:00:00'),
(17, '2013-08-17 07:00:00', '2013-08-17 19:00:00'),
(18, '2013-08-17 19:00:00', '2013-08-18 07:00:00'),
(19, '2013-08-18 07:00:00', '2013-08-18 18:00:00'),
(20, '2013-08-19 18:00:00', '2013-08-19 07:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE IF NOT EXISTS `service` (
  `ServiceID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  `AmountBillable` double DEFAULT NULL,
  PRIMARY KEY (`ServiceID`),
  UNIQUE KEY `Name_UNIQUE` (`Name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=18 ;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`ServiceID`, `Name`, `AmountBillable`) VALUES
(1, 'Kidney Transplant', 3500),
(2, 'Routine Check-up', 300),
(3, 'Hand Transplant', 990),
(4, 'Standard Diagnosis', 500),
(5, 'Nutrition', 10),
(6, 'Bathing', 30),
(7, 'Physiotherapy', 80),
(8, 'Oral Medicine', 20),
(9, 'Heart Surgery', 5000),
(10, 'Exercise', 30),
(11, 'Limb Cast', 50),
(12, 'Torso Cast', 120),
(13, 'Shot', 30),
(14, 'Pyschotherapy', 200),
(16, 'Walking', 15);

-- --------------------------------------------------------

--
-- Table structure for table `supplies`
--

CREATE TABLE IF NOT EXISTS `supplies` (
  `SupplyTypeID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Type` varchar(45) NOT NULL,
  PRIMARY KEY (`SupplyTypeID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `supplies`
--

INSERT INTO `supplies` (`SupplyTypeID`, `Type`) VALUES
(1, 'Medical'),
(2, 'NonMedical'),
(3, 'Nutritional');

-- --------------------------------------------------------

--
-- Table structure for table `supplyroom`
--

CREATE TABLE IF NOT EXISTS `supplyroom` (
  `SupplyRoomNumber` int(10) unsigned NOT NULL,
  `Floor` int(10) unsigned NOT NULL,
  PRIMARY KEY (`SupplyRoomNumber`,`Floor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `supplyroom`
--

INSERT INTO `supplyroom` (`SupplyRoomNumber`, `Floor`) VALUES
(110, 1),
(120, 2),
(130, 3),
(140, 4),
(150, 5),
(210, 1),
(220, 2),
(230, 3),
(240, 4),
(250, 5),
(310, 1),
(320, 2),
(330, 3),
(340, 4),
(350, 5);

-- --------------------------------------------------------

--
-- Table structure for table `supplyroom_has_basicpatientsupply`
--

CREATE TABLE IF NOT EXISTS `supplyroom_has_basicpatientsupply` (
  `SupplyRoomNumber` int(10) unsigned NOT NULL,
  `Floor` int(10) unsigned NOT NULL,
  `BasicPatientSupplyID` int(10) unsigned NOT NULL,
  `NonMedicalSupplyID` int(10) unsigned NOT NULL,
  `SupplyTypeID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`SupplyRoomNumber`,`Floor`,`BasicPatientSupplyID`,`NonMedicalSupplyID`,`SupplyTypeID`),
  KEY `fk_SupplyRoom_has_BasicPatientSupply_BasicPatientSupply1_idx` (`BasicPatientSupplyID`,`NonMedicalSupplyID`,`SupplyTypeID`),
  KEY `fk_SupplyRoom_has_BasicPatientSupply_SupplyRoom1_idx` (`SupplyRoomNumber`,`Floor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `supplyroom_has_basicpatientsupply`
--

INSERT INTO `supplyroom_has_basicpatientsupply` (`SupplyRoomNumber`, `Floor`, `BasicPatientSupplyID`, `NonMedicalSupplyID`, `SupplyTypeID`) VALUES
(110, 1, 1, 2, 2),
(110, 1, 2, 2, 2),
(110, 1, 3, 2, 2),
(110, 1, 4, 2, 2),
(110, 1, 5, 2, 2),
(120, 2, 6, 2, 2),
(120, 2, 7, 2, 2),
(120, 2, 8, 2, 2),
(120, 2, 9, 2, 2),
(120, 2, 10, 2, 2),
(130, 3, 11, 2, 2),
(130, 3, 12, 2, 2),
(130, 3, 13, 2, 2),
(130, 3, 14, 2, 2),
(130, 3, 15, 2, 2),
(140, 4, 16, 2, 2),
(140, 4, 17, 2, 2),
(140, 4, 18, 2, 2),
(140, 4, 19, 2, 2),
(140, 4, 20, 2, 2),
(150, 5, 21, 2, 2),
(150, 5, 22, 2, 2),
(150, 5, 23, 2, 2),
(150, 5, 24, 2, 2),
(150, 5, 25, 2, 2),
(210, 1, 1, 2, 2),
(210, 1, 2, 2, 2),
(210, 1, 3, 2, 2),
(210, 1, 4, 2, 2),
(210, 1, 5, 2, 2),
(220, 2, 6, 2, 2),
(220, 2, 7, 2, 2),
(220, 2, 8, 2, 2),
(220, 2, 9, 2, 2),
(220, 2, 10, 2, 2),
(230, 3, 11, 2, 2),
(230, 3, 12, 2, 2),
(230, 3, 13, 2, 2),
(230, 3, 14, 2, 2),
(230, 3, 15, 2, 2),
(240, 4, 16, 2, 2),
(240, 4, 17, 2, 2),
(240, 4, 18, 2, 2),
(240, 4, 19, 2, 2),
(240, 4, 20, 2, 2),
(250, 5, 21, 2, 2),
(250, 5, 22, 2, 2),
(250, 5, 23, 2, 2),
(250, 5, 24, 2, 2),
(250, 5, 25, 2, 2),
(310, 1, 1, 2, 2),
(310, 1, 2, 2, 2),
(310, 1, 3, 2, 2),
(310, 1, 4, 2, 2),
(310, 1, 5, 2, 2),
(320, 2, 6, 2, 2),
(320, 2, 7, 2, 2),
(320, 2, 8, 2, 2),
(320, 2, 9, 2, 2),
(320, 2, 10, 2, 2),
(330, 3, 11, 2, 2),
(330, 3, 12, 2, 2),
(330, 3, 13, 2, 2),
(330, 3, 14, 2, 2),
(330, 3, 15, 2, 2),
(340, 4, 16, 2, 2),
(340, 4, 17, 2, 2),
(340, 4, 18, 2, 2),
(340, 4, 19, 2, 2),
(340, 4, 20, 2, 2),
(350, 5, 21, 2, 2),
(350, 5, 22, 2, 2),
(350, 5, 23, 2, 2),
(350, 5, 24, 2, 2),
(350, 5, 25, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `supplyroom_has_medication`
--

CREATE TABLE IF NOT EXISTS `supplyroom_has_medication` (
  `SupplyRoomNumber` int(10) unsigned NOT NULL,
  `Floor` int(10) unsigned NOT NULL,
  `SupplyTypeID` int(10) unsigned NOT NULL,
  `MedicationID` int(10) unsigned NOT NULL,
  `MedicalSupplyID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Floor`,`SupplyTypeID`,`MedicationID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `supplyroom_has_medication`
--

INSERT INTO `supplyroom_has_medication` (`SupplyRoomNumber`, `Floor`, `SupplyTypeID`, `MedicationID`, `MedicalSupplyID`) VALUES
(110, 1, 1, 1, 1),
(110, 1, 1, 2, 1),
(110, 1, 1, 3, 1),
(110, 1, 1, 4, 1),
(110, 1, 1, 5, 1),
(120, 1, 1, 6, 1),
(120, 1, 1, 7, 1),
(120, 1, 1, 8, 1),
(120, 1, 1, 9, 1),
(120, 1, 1, 10, 1),
(130, 1, 1, 11, 1),
(130, 1, 1, 12, 1),
(130, 1, 1, 13, 1),
(130, 1, 1, 14, 1),
(130, 1, 1, 15, 1),
(140, 1, 1, 16, 1),
(140, 1, 1, 17, 1),
(140, 1, 1, 18, 1),
(140, 1, 1, 19, 1),
(140, 1, 1, 20, 1),
(150, 1, 1, 21, 1),
(150, 1, 1, 22, 1),
(150, 1, 1, 23, 1),
(150, 1, 1, 24, 1),
(150, 1, 1, 25, 1),
(250, 2, 1, 1, 1),
(210, 2, 1, 26, 1),
(210, 2, 1, 27, 1),
(210, 2, 1, 28, 1),
(210, 2, 1, 29, 1),
(210, 2, 1, 30, 1),
(220, 2, 1, 31, 1),
(220, 2, 1, 32, 1),
(220, 2, 1, 33, 1),
(220, 2, 1, 34, 1),
(220, 2, 1, 35, 1),
(230, 2, 1, 36, 1),
(230, 2, 1, 37, 1),
(230, 2, 1, 38, 1),
(230, 2, 1, 39, 1),
(230, 2, 1, 40, 1),
(240, 2, 1, 41, 1),
(240, 2, 1, 42, 1),
(240, 2, 1, 43, 1),
(240, 2, 1, 44, 1),
(240, 2, 1, 45, 1),
(250, 2, 1, 46, 1),
(250, 2, 1, 47, 1),
(250, 2, 1, 48, 1),
(250, 2, 1, 49, 1),
(310, 3, 1, 2, 1),
(310, 3, 1, 4, 1),
(310, 3, 1, 5, 1),
(310, 3, 1, 7, 1),
(310, 3, 1, 8, 1),
(320, 3, 1, 12, 1),
(350, 3, 1, 14, 1),
(350, 3, 1, 15, 1),
(350, 3, 1, 16, 1),
(350, 3, 1, 17, 1),
(350, 3, 1, 18, 1),
(340, 3, 1, 19, 1),
(340, 3, 1, 20, 1),
(340, 3, 1, 21, 1),
(340, 3, 1, 22, 1),
(340, 3, 1, 23, 1),
(330, 3, 1, 24, 1),
(330, 3, 1, 25, 1),
(330, 3, 1, 26, 1),
(330, 3, 1, 27, 1),
(330, 3, 1, 28, 1),
(320, 3, 1, 29, 1),
(320, 3, 1, 31, 1),
(320, 3, 1, 36, 1),
(320, 3, 1, 45, 1);

-- --------------------------------------------------------

--
-- Table structure for table `supportingdevices`
--

CREATE TABLE IF NOT EXISTS `supportingdevices` (
  `SupportingDevicesID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Description` varchar(120) NOT NULL,
  `LastOrdered` date NOT NULL,
  `StockLow` tinyint(1) NOT NULL DEFAULT '0',
  `Cost` double unsigned NOT NULL,
  `AmountLeft` double unsigned NOT NULL,
  `Maximum Capacity` double unsigned NOT NULL,
  `Rented` double DEFAULT NULL,
  `MedicalSupplyTypeID` int(10) unsigned NOT NULL,
  `MedicalSupplyID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`SupportingDevicesID`,`MedicalSupplyTypeID`,`MedicalSupplyID`),
  KEY `fk_SupportingDevices_MedicalSupplies1_idx` (`MedicalSupplyTypeID`,`MedicalSupplyID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `supportingdevices`
--

INSERT INTO `supportingdevices` (`SupportingDevicesID`, `Description`, `LastOrdered`, `StockLow`, `Cost`, `AmountLeft`, `Maximum Capacity`, `Rented`, `MedicalSupplyTypeID`, `MedicalSupplyID`) VALUES
(1, 'crutch', '2011-05-19', 0, 200, 5, 5, 0, 1, 3),
(2, 'Weelchair', '2010-08-15', 0, 400, 5, 5, 0, 1, 3),
(3, 'Walker', '2009-08-09', 0, 250, 5, 5, 0, 1, 3),
(4, 'Orthopedic Boot', '2010-06-03', 0, 425, 4, 5, 1, 1, 3),
(5, 'Stroller', '2010-12-02', 0, 500, 1, 5, 3, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `surgicalequipment`
--

CREATE TABLE IF NOT EXISTS `surgicalequipment` (
  `SurgicalID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Description` varchar(120) NOT NULL,
  `LastOrdered` date NOT NULL,
  `StockLow` tinyint(1) NOT NULL DEFAULT '0',
  `Cost` double unsigned NOT NULL,
  `AmountLeft` double unsigned NOT NULL,
  `Maximum Capacity` double unsigned NOT NULL,
  `MedicalSupplyTypeID` int(10) unsigned NOT NULL,
  `MedicalSupplyID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`SurgicalID`,`MedicalSupplyTypeID`,`MedicalSupplyID`),
  KEY `fk_SurgicalEquipment_MedicalSupplies1_idx` (`MedicalSupplyTypeID`,`MedicalSupplyID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Dumping data for table `surgicalequipment`
--

INSERT INTO `surgicalequipment` (`SurgicalID`, `Description`, `LastOrdered`, `StockLow`, `Cost`, `AmountLeft`, `Maximum Capacity`, `MedicalSupplyTypeID`, `MedicalSupplyID`) VALUES
(1, 'Surgical Bed', '2013-08-08', 0, 2560.34, 25, 25, 1, 2),
(2, 'Robe', '2012-08-17', 0, 496, 10, 16, 1, 2),
(3, 'Goggles', '2012-12-10', 0, 483, 17, 18, 1, 2),
(4, 'scalpel', '2012-05-22', 0, 345, 5, 16, 1, 2),
(5, 'clamp', '2013-04-01', 1, 305, 1, 19, 1, 2),
(6, 'saw', '2012-06-15', 0, 248, 17, 17, 1, 2),
(7, 'tubes', '2012-05-24', 0, 377, 14, 17, 1, 2),
(8, 'injection seringe', '2013-02-27', 0, 434, 15, 15, 1, 2),
(9, 'suture tred', '2013-02-05', 0, 490, 18, 18, 1, 2),
(10, 'oxygen bottle', '2013-03-16', 1, 260, 2, 18, 1, 2),
(11, 'mask', '2012-05-01', 0, 340, 15, 16, 1, 2),
(12, 'operation field', '2013-01-18', 0, 345, 14, 19, 1, 2),
(13, 'iodine', '2012-04-23', 0, 451, 13, 18, 1, 2),
(14, 'stapler', '2013-07-14', 0, 279, 5, 19, 1, 2),
(15, 'gloves', '2013-02-25', 0, 356, 20, 20, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `unit`
--

CREATE TABLE IF NOT EXISTS `unit` (
  `UnitID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  PRIMARY KEY (`UnitID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `unit`
--

INSERT INTO `unit` (`UnitID`, `Name`) VALUES
(1, 'Long Term Palliative Care\r\r\n'),
(2, 'Children\r\r\n'),
(3, 'Surgical\r\r\n');

-- --------------------------------------------------------

--
-- Table structure for table `unit_has_nutritionalsupply`
--

CREATE TABLE IF NOT EXISTS `unit_has_nutritionalsupply` (
  `UnitID` int(10) NOT NULL,
  `NutritionalSupplyID` int(10) unsigned NOT NULL,
  `SupplyTypeID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`NutritionalSupplyID`,`SupplyTypeID`),
  KEY `fk_Unit_has_NutritionalSupply_NutritionalSupply__idx` (`NutritionalSupplyID`,`SupplyTypeID`),
  KEY `fk_Unit_has_NutritionalSupply_Unit1_idx` (`UnitID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `unit_has_supplyroom`
--

CREATE TABLE IF NOT EXISTS `unit_has_supplyroom` (
  `UnitID` int(10) unsigned NOT NULL,
  `SupplyRoomNumber` int(10) unsigned NOT NULL,
  `Floor` int(10) unsigned NOT NULL,
  PRIMARY KEY (`UnitID`,`SupplyRoomNumber`,`Floor`),
  KEY `fk_Unit_has_SupplyRoom_SupplyRoom1_idx` (`SupplyRoomNumber`,`Floor`),
  KEY `fk_Unit_has_SupplyRoom_Unit1_idx` (`UnitID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `unit_has_supplyroom`
--

INSERT INTO `unit_has_supplyroom` (`UnitID`, `SupplyRoomNumber`, `Floor`) VALUES
(1, 110, 1),
(1, 120, 2),
(1, 130, 3),
(1, 140, 4),
(1, 150, 5),
(2, 210, 1),
(2, 220, 2),
(2, 230, 3),
(2, 240, 4),
(2, 250, 5),
(3, 310, 1),
(3, 320, 2),
(3, 330, 3),
(3, 340, 4),
(3, 350, 5);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `Login` varchar(100) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `EmployeeID` int(11) NOT NULL,
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`UserID`, `Login`, `Password`, `EmployeeID`) VALUES
(1, 'direct', 'dollar', 8),
(2, 'admin', 'dollar', 1006),
(3, 'doctor', 'dollar', 1039),
(4, 'nurse', 'dollar', 1231),
(5, 'resident', 'dollar', 1003);

-- --------------------------------------------------------

--
-- Table structure for table `yearsofserviceadjustement`
--

CREATE TABLE IF NOT EXISTS `yearsofserviceadjustement` (
  `JobID` int(11) NOT NULL,
  `YearsOfService` int(10) unsigned NOT NULL,
  `Add` decimal(10,5) unsigned DEFAULT NULL,
  `Multiply` decimal(10,5) unsigned DEFAULT NULL,
  PRIMARY KEY (`JobID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `yearsofserviceadjustement`
--

INSERT INTO `yearsofserviceadjustement` (`JobID`, `YearsOfService`, `Add`, `Multiply`) VALUES
(1, 1, '0.00000', '1.01500'),
(2, 1, '0.00000', '1.01500'),
(3, 1, '0.00000', '1.01000'),
(9, 5, '1.50000', '0.00000'),
(10, 5, '1.50000', '0.00000'),
(11, 8, '1.25000', '0.00000'),
(12, 8, '1.25000', '0.00000'),
(13, 8, '1.25000', '0.00000'),
(14, 8, '1.25000', '0.00000'),
(15, 8, '1.25000', '0.00000');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `administrativesupply`
--
ALTER TABLE `administrativesupply`
  ADD CONSTRAINT `fk_AdministrativeSupply_NonMedicalSupplies1` FOREIGN KEY (`NonMedicalSupplyID`, `SupplyTypeID`) REFERENCES `nonmedicalsupplies` (`NonMedicalSupplyID`, `SupplyTypeID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `appointment`
--
ALTER TABLE `appointment`
  ADD CONSTRAINT `PatientID` FOREIGN KEY (`PatientID`) REFERENCES `patient` (`HospitalCardID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `RoomID` FOREIGN KEY (`RoomID`) REFERENCES `room` (`RoomID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `ServiceID` FOREIGN KEY (`ServiceID`) REFERENCES `service` (`ServiceID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `UnitID` FOREIGN KEY (`UnitID`) REFERENCES `unit` (`UnitID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `attendingphysician`
--
ALTER TABLE `attendingphysician`
  ADD CONSTRAINT `fk_Employee_has_Employee_Employee1` FOREIGN KEY (`JuniorDoctorID`) REFERENCES `employee` (`EmployeeID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Employee_has_Employee_Employee2` FOREIGN KEY (`AttendingID`) REFERENCES `employee` (`EmployeeID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `basicpatientsupply`
--
ALTER TABLE `basicpatientsupply`
  ADD CONSTRAINT `fk_BasicPatientSupply_NonMedicalSupplies1` FOREIGN KEY (`NonMedicalSupplyID`, `SupplyTypeID`) REFERENCES `nonmedicalsupplies` (`NonMedicalSupplyID`, `SupplyTypeID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `fk_Employee_JobPayroll1` FOREIGN KEY (`JobID`) REFERENCES `jobpayroll` (`JobID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Employee_Unit` FOREIGN KEY (`UnitID`) REFERENCES `unit` (`UnitID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
