CREATE DATABASE  IF NOT EXISTS `pharmacy` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `pharmacy`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: pharmacy
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `curezero`
--

DROP TABLE IF EXISTS `curezero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curezero` (
  `branch_id` int NOT NULL,
  `address` varchar(20) NOT NULL,
  `join_date` date NOT NULL,
  `admin_id` int DEFAULT NULL,
  PRIMARY KEY (`branch_id`),
  KEY `admin_id` (`admin_id`),
  CONSTRAINT `curezero_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `employee` (`ep_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curezero`
--

LOCK TABLES `curezero` WRITE;
/*!40000 ALTER TABLE `curezero` DISABLE KEYS */;
INSERT INTO `curezero` VALUES (101,'New Delhi','2016-03-18',1),(370,'Norfolk','2022-02-20',8),(444,'Lakewood','2020-09-13',9),(571,'Detroit','2016-05-07',2),(656,'Garland','2017-02-16',6),(862,'Worcester','2001-11-24',7),(896,'Zurich','2021-04-05',5);
/*!40000 ALTER TABLE `curezero` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `cust_id` int NOT NULL,
  `cust_name` char(20) NOT NULL,
  `cust_contact` char(10) DEFAULT NULL,
  `cust_address` varchar(50) DEFAULT NULL,
  `cust_pres` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`cust_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Aiden Callan','1143693096','Amarillo','Band-Aid'),(2,'George Edley','617748221','Bridgeport','Cosopt'),(3,'Leroy Ogilvy','158885008','Milano','Singulair'),(4,'Ethan Harper','749777662','Stockton','Coldrex'),(5,'Matthew Stone','1670579620','London','Visine'),(6,'William Lynn','919835925','Murfreesboro','Panadol'),(7,'Jayden Hood','1048413830','Washington','Singulair'),(8,'Luke Dickson','457610884','Jersey City','Exact'),(9,'Erick Hastings','677269021','Memphis','Zovirax'),(10,'Barry Ashley','975840076','Columbus','Advil'),(11,'Liam Poulton','1942459278','Worcester','Tylenol'),(12,'Danny Dixon','1456785535','Fullerton','Abilify'),(13,'Ron Egerton','401018172','Omaha','Nurofen'),(14,'Fred Gordon','1273536859','Charlotte','Claritin'),(15,'Domenic Gonzales','1560994988','Bellevue','Ibuprofen'),(16,'Phillip Phillips','1505456231','Kansas City','Prozac'),(17,'Josh Whatson','1204859923','Colorado Springs','Makena'),(18,'Ethan Broomfield','1768570911','Scottsdale','Risperdal'),(19,'Roger Funnell','1430405119','Richmond','Amaryl'),(20,'Johnathan Jarrett','1321361731','Paris','Advil'),(21,'Danny West','954721004','Jersey City','Novolin'),(22,'William Osmond','876578513','Los Angeles','Femibion'),(23,'Boris Dobson','2048473514','Laredo','Visine'),(24,'Cedrick Shaw','408931358','El Paso','Arcoxia'),(25,'Abdul Flanders','1728240632','Quebec','NyQuill'),(26,'Alexander Bayliss','1405452480','Cincinnati','Varivax'),(27,'Chuck Callan','1175092522','St. Louis','Makena'),(28,'Jack Watt','2090496291','Santa Ana','Zoloft'),(29,'Matthew Blackwall','430364568','Honolulu','Ibuprofen'),(30,'Owen Calderwood','1003762139','Baltimore','NyQuill');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `ep_id` int NOT NULL,
  `ep_name` char(20) NOT NULL,
  `ep_contact` char(10) NOT NULL,
  `ep_address` varchar(50) DEFAULT NULL,
  `ep_salary` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`ep_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'Puneet Singh','9274638290','Vasant Vihar, New Delhi',20000),(2,'Johnny Ashley','1184429848','Tallahassee',5387),(3,'Owen Mason','975712035','Saint Paul',46742),(4,'Daron Jenkins','685531599','Wien',69293),(5,'Hanna Torres','923126244','Jacksonville',77174),(6,'Bart Keys','1712780743','Charlotte',36040),(7,'Sloane Rogers','872600843','Reno',25605),(8,'Jacob Cunningham','1477455167','Quebec',85674),(9,'Daphne Tennant','469541451','Zurich',32004),(10,'Jolene Stevens','1755981180','Otawa',73836),(11,'Miriam Walsh','59799613','Venice',67791),(12,'Tess Jefferson','738154571','Berna',89399),(13,'Ally Wallace','1643082517','Berlin',55036),(14,'Percy Morgan','1207074263','Tokyo',94343),(15,'Chris Roman','47155134','Oklahoma City',1653),(16,'Hank Adler','135409227','Paris',41760),(17,'Nicholas Boyle','1961049047','Louisville',47692),(18,'Jayden Richardson','1671744893','Rochester',58356),(19,'Faith Edmonds','1940813651','Los Angeles',31546),(20,'Anais Phillips','1993877668','El Paso',54964),(21,'Aurelia Rose','1575165227','Fort Lauderdale',16975),(22,'Carina Snell','1332520310','Madison',7418),(23,'Bob Little','693497252','Springfield',27902),(24,'Maxwell Redwood','963886890','Salt Lake City',36664),(25,'Scarlett Saunders','1146631781','Huntsville',2039),(26,'Denny Watson','119804405','Louisville',30335),(27,'Skylar Palmer','559577852','Jersey City',15101),(28,'Henry Fisher','985868215','Tallahassee',35708),(29,'Michael Emmott','66399428','Baltimore',17515),(30,'Marla Spencer','1169694212','Lincoln',52011);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicine`
--

DROP TABLE IF EXISTS `medicine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicine` (
  `med_id` int NOT NULL,
  `med_name` char(20) NOT NULL,
  `company` varchar(10) DEFAULT NULL,
  `med_price` int NOT NULL,
  `category` varchar(20) DEFAULT NULL,
  `presc` char(3) DEFAULT NULL,
  `expiry_date` date NOT NULL,
  PRIMARY KEY (`med_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicine`
--

LOCK TABLES `medicine` WRITE;
/*!40000 ALTER TABLE `medicine` DISABLE KEYS */;
INSERT INTO `medicine` VALUES (1,'Arcoxia','PharmaCo',704,'Pepcid','Yes','2013-04-26'),(2,'Lisinopril','Divi',245,'Coldrex','No','2000-07-08'),(3,'Claritin','Alkem',3172,'Exact','No','2007-08-20'),(4,'Novolin','Torrent',3170,'Ibalgin','No','2014-09-28'),(5,'Makena','Glenmark',3141,'Prozac','Yes','2000-12-16'),(6,'Midodrine','PharmaCo',367,'NyQuill','No','2018-06-14'),(7,'Aspirin','Cipla',3878,'Emend','No','2018-12-26'),(8,'Risperdal','Divu',653,'Advil','Yes','2021-05-15'),(9,'Gravol','Lupin',1550,'Zoloft','Yes','2022-04-23'),(100,'Metformin','PharmaCo',500,'tablet','yes','2025-06-23');
/*!40000 ALTER TABLE `medicine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock` (
  `med_id` int NOT NULL,
  `med_name` char(20) NOT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`med_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` VALUES (1,'Arcoxia',34),(4,'Novolin',87),(7,'Aspirin',67),(9,'Gravol',54),(100,'Metformin',100);
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `sup_id` int NOT NULL,
  `sup_name` char(20) NOT NULL,
  `sup_contact` char(10) NOT NULL,
  `sup_address` varchar(50) NOT NULL,
  `sup_email` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`sup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES (1,'Anthony Riley','105413665','Columbus','Anthony_Riley7924@gmail.com'),(2,'Owen Greenwood','1476510196','Berlin','Owen_Greenwood8513@gmail.com'),(3,'Eduardo Carson','1055754553','Dallas','Eduardo_Carson2280@gmail.com'),(4,'Martin Cartwright','1917163201','New Orleans','Martin4750@gmail.com'),(5,'Gil Pond','1236029852','Otawa','Gil_Pond569@gmail.com'),(6,'Carter Addley','497444738','Atlanta','Carter_Addley399@gmail.com'),(7,'Chester Hastings','566844342','Albuquerque','Cheste@gmail.com'),(8,'Matt Mcguire','2076535903','El Paso','Matt_Mcguire5710@gmail.com'),(9,'Matt Murphy','1835704517','Lincoln','Matt_Murphy5437@gmail.com'),(10,'Mike Russell','1525142492','Portland','Mike_Russell1810@gmail.com'),(11,'Matt Brown','829945868','Berna','Matt_Brown1402@gmail.com'),(12,'Brad Murray','1455492193','Bucharest','Brad_Murray3336@gmail.com'),(13,'Bryon Windsor','1036349817','Honolulu','Bryon_Windsor8037@gmail.com'),(14,'Eduardo Fleming','935838128','Boston','Eduardo_Fleming2250@gmail.com'),(15,'Carl Roberts','1871035491','Paris','Carl_Roberts680@gmail.com'),(16,'Josh Reese','1680737952','Oklahoma City','Josh_Reese5233@gmail.com'),(17,'Elijah Taylor','1062366286','Rochester','Elijah_Taylor7615@gmail.com'),(18,'Tyson Kaur','1094189049','Murfreesboro','Tyson_Kaur9854@gmail.com'),(19,'Ron Cartwright','1869575080','Minneapolis','Ron_Cartwright3181@gmail.com'),(20,'Josh Reyes','6138762','Fayetteville','Josh_Reyes570@gmail.com'),(21,'Nicholas Hooper','23910774','Hollywood','Nicholas_Hooper2106@gmail.com'),(22,'Rocco Harrison','1629013202','Dallas','Rocco_Harrison1080@gmail.com'),(23,'Rocco Booth','1782593391','Anaheim','Rocco_Booth2252@gmail.com'),(24,'Alexander Hall','649176295','Lakewood','Alexander_Hall518@gmail.com'),(25,'Ronald Aldridge','419576527','Denver','Ronald_Aldridge403@gmail.com'),(26,'Cedrick Casey','1107666614','Anaheim','Cedrick_Casey9170@gmail.com'),(27,'John Khan','525435123','Glendale','John_Khan6240@gmail.com'),(28,'Benny Patel','331475397','Indianapolis','Benny_Patel8652@gmail.com'),(29,'Ryan Whinter','1363760553','Berna','Ryan_Whinter3909@gmail.com'),(30,'Hayden Talbot','1551383701','Springfield','Hayden_Talbot4495@gmail.com');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `transc_id` int NOT NULL,
  `cust_name` char(20) NOT NULL,
  `total_amount` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `transc_date` date NOT NULL,
  `payment_type` varchar(10) DEFAULT NULL,
  `med_id` int DEFAULT NULL,
  PRIMARY KEY (`transc_id`),
  KEY `med_id` (`med_id`),
  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`med_id`) REFERENCES `medicine` (`med_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (12,'Raman Singh',530,1,'2019-08-24','Cash',100);
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'pharmacy'
--

--
-- Dumping routines for database 'pharmacy'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-10 23:33:51
