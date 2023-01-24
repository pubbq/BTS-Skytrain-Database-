-- MySQL dump 10.13  Distrib 8.0.31, for macos12 (x86_64)
--
-- Host: 127.0.0.1    Database: btsskytrain
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice` (
  `Inv_No` char(20) NOT NULL,
  `TotalPrice` decimal(9,2) NOT NULL,
  `Inv_Datetime` datetime NOT NULL,
  `Order_No` varchar(20) NOT NULL,
  PRIMARY KEY (`Inv_No`),
  KEY `Fk_InvoiceOrderID` (`Order_No`),
  CONSTRAINT `Fk_InvoiceOrderID` FOREIGN KEY (`Order_No`) REFERENCES `setorder` (`Order_No`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoiceline`
--

DROP TABLE IF EXISTS `invoiceline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoiceline` (
  `InvLine_No` char(6) NOT NULL,
  `Ticket_Type` varchar(20) NOT NULL,
  `Ticket_Price` decimal(9,2) NOT NULL,
  `Tax_ID` char(13) NOT NULL,
  `Subtotal_Price` decimal(9,2) NOT NULL,
  `Ticket_Quantity` int NOT NULL,
  `INV_No` char(20) NOT NULL,
  PRIMARY KEY (`InvLine_No`),
  KEY `Fk_invoiceINV_No` (`INV_No`),
  CONSTRAINT `Fk_invoiceINV_No` FOREIGN KEY (`INV_No`) REFERENCES `invoice` (`Inv_No`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoiceline`
--

LOCK TABLES `invoiceline` WRITE;
/*!40000 ALTER TABLE `invoiceline` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoiceline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `make`
--

DROP TABLE IF EXISTS `make`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `make` (
  `Psg_ID` char(9) NOT NULL,
  `Pm_ID` char(9) NOT NULL,
  `Order_No` char(20) NOT NULL,
  KEY `Fk_MakePsgID` (`Psg_ID`),
  KEY `Fk_MakePmID` (`Pm_ID`),
  KEY `Fk_MakeOrderNo` (`Order_No`),
  CONSTRAINT `Fk_MakeOrderNo` FOREIGN KEY (`Order_No`) REFERENCES `setorder` (`Order_No`),
  CONSTRAINT `Fk_MakePmID` FOREIGN KEY (`Pm_ID`) REFERENCES `payment` (`Pm_ID`),
  CONSTRAINT `Fk_MakePsgID` FOREIGN KEY (`Psg_ID`) REFERENCES `passenger` (`Psg_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `make`
--

LOCK TABLES `make` WRITE;
/*!40000 ALTER TABLE `make` DISABLE KEYS */;
/*!40000 ALTER TABLE `make` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passenger`
--

DROP TABLE IF EXISTS `passenger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passenger` (
  `Psg_ID` char(9) NOT NULL,
  `Psg_BD` date NOT NULL,
  `Psg_Occupation` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Psg_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passenger`
--

LOCK TABLES `passenger` WRITE;
/*!40000 ALTER TABLE `passenger` DISABLE KEYS */;
/*!40000 ALTER TABLE `passenger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `Pm_ID` char(9) NOT NULL,
  `Pm_Method` varchar(50) NOT NULL,
  `Pm_DateTime` datetime NOT NULL,
  PRIMARY KEY (`Pm_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rabbitcard`
--

DROP TABLE IF EXISTS `rabbitcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rabbitcard` (
  `Ticket_ID` char(12) NOT NULL,
  `Card_Type` varchar(10) NOT NULL,
  KEY `Fk_RabbitCardTicket_ID` (`Ticket_ID`),
  CONSTRAINT `Fk_RabbitCardTicket_ID` FOREIGN KEY (`Ticket_ID`) REFERENCES `ticket` (`Ticket_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rabbitcard`
--

LOCK TABLES `rabbitcard` WRITE;
/*!40000 ALTER TABLE `rabbitcard` DISABLE KEYS */;
/*!40000 ALTER TABLE `rabbitcard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setorder`
--

DROP TABLE IF EXISTS `setorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `setorder` (
  `Order_No` char(20) NOT NULL,
  `Order_DateTime` datetime NOT NULL,
  PRIMARY KEY (`Order_No`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setorder`
--

LOCK TABLES `setorder` WRITE;
/*!40000 ALTER TABLE `setorder` DISABLE KEYS */;
/*!40000 ALTER TABLE `setorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `singlejourneyticket`
--

DROP TABLE IF EXISTS `singlejourneyticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `singlejourneyticket` (
  `Ticket_ID` char(12) NOT NULL,
  `Destination` varchar(20) NOT NULL,
  KEY `Fk_SingleJourneyTicket_ID` (`Ticket_ID`),
  CONSTRAINT `Fk_SingleJourneyTicket_ID` FOREIGN KEY (`Ticket_ID`) REFERENCES `ticket` (`Ticket_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `singlejourneyticket`
--

LOCK TABLES `singlejourneyticket` WRITE;
/*!40000 ALTER TABLE `singlejourneyticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `singlejourneyticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `Ticket_ID` char(12) NOT NULL,
  `Purchasing_Date` date NOT NULL,
  `Expiration_Date` date NOT NULL,
  `Balance` decimal(10,2) NOT NULL,
  `Ticket_Type` varchar(20) NOT NULL,
  `Order_No` varchar(20) NOT NULL,
  `Staff_ID` char(6) DEFAULT NULL,
  PRIMARY KEY (`Ticket_ID`),
  KEY `Fk_TicketOrderNo` (`Order_No`),
  KEY `Fk_TicketStaffId` (`Staff_ID`),
  CONSTRAINT `Fk_TicketOrderNo` FOREIGN KEY (`Order_No`) REFERENCES `setorder` (`Order_No`),
  CONSTRAINT `Fk_TicketStaffId` FOREIGN KEY (`Staff_ID`) REFERENCES `ticketseller` (`Staff_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticketseller`
--

DROP TABLE IF EXISTS `ticketseller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticketseller` (
  `Staff_ID` char(6) NOT NULL,
  `Counter_ID` char(3) NOT NULL,
  `Tk_Status` char(1) NOT NULL,
  `FirstName` varchar(100) NOT NULL,
  `LastName` varchar(100) NOT NULL,
  PRIMARY KEY (`Staff_ID`),
  CONSTRAINT `Tk_Status` CHECK ((`Tk_Status` in (_utf8mb4'O',_utf8mb4'C')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticketseller`
--

LOCK TABLES `ticketseller` WRITE;
/*!40000 ALTER TABLE `ticketseller` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticketseller` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-28  9:48:05
