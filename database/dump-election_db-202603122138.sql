-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: election_db
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `candidates`
--

DROP TABLE IF EXISTS `candidates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidates` (
  `CandidateID` int(11) NOT NULL AUTO_INCREMENT,
  `FullName` varchar(100) NOT NULL,
  `Party` varchar(50) DEFAULT NULL,
  `Biography` text DEFAULT NULL,
  `AvatarUrl` varchar(255) DEFAULT NULL,
  `CurrentSupportRate` float DEFAULT 0,
  PRIMARY KEY (`CandidateID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidates`
--

LOCK TABLES `candidates` WRITE;
/*!40000 ALTER TABLE `candidates` DISABLE KEYS */;
INSERT INTO `candidates` VALUES (1,'Nguyễn Văn A','Đảng Xanh','Chuyên gia kinh tế với 20 năm kinh nghiệm.','https://i.pravatar.cc/150?u=a',0),(2,'Trần Thị B','Đảng Đỏ','Nhà hoạt động xã hội vì quyền trẻ em.','https://i.pravatar.cc/150?u=b',0),(3,'Lê Hoàng C','Đảng Vàng','Cựu thị trưởng với nhiều dự án công nghệ.','https://i.pravatar.cc/150?u=c',0),(4,'Phạm Minh D','Đảng Tím','Luật sư tài năng, chuyên về luật quốc tế.','https://i.pravatar.cc/150?u=d',0),(5,'Hoàng Thị E','Đảng Cam','Doanh nhân trẻ khởi nghiệp trong ngành xanh.','https://i.pravatar.cc/150?u=e',0),(6,'Nguyễn Văn A','Đảng Xanh','Chuyên gia kinh tế với 20 năm kinh nghiệm.','https://i.pravatar.cc/150?u=a',0),(7,'Trần Thị B','Đảng Đỏ','Nhà hoạt động xã hội vì quyền trẻ em.','https://i.pravatar.cc/150?u=b',0),(8,'Lê Hoàng C','Đảng Vàng','Cựu thị trưởng với nhiều dự án công nghệ.','https://i.pravatar.cc/150?u=c',0),(9,'Phạm Minh D','Đảng Tím','Luật sư tài năng, chuyên về luật quốc tế.','https://i.pravatar.cc/150?u=d',0),(10,'Hoàng Thị E','Đảng Cam','Doanh nhân trẻ khởi nghiệp trong ngành xanh.','https://i.pravatar.cc/150?u=e',0),(11,'Nguyễn Văn A','Đảng Xanh','Chuyên gia kinh tế với 20 năm kinh nghiệm.','https://i.pravatar.cc/150?u=a',0),(12,'Trần Thị B','Đảng Đỏ','Nhà hoạt động xã hội vì quyền trẻ em.','https://i.pravatar.cc/150?u=b',0),(13,'Lê Hoàng C','Đảng Vàng','Cựu thị trưởng với nhiều dự án công nghệ.','https://i.pravatar.cc/150?u=c',0),(14,'Phạm Minh D','Đảng Tím','Luật sư tài năng, chuyên về luật quốc tế.','https://i.pravatar.cc/150?u=d',0),(15,'Hoàng Thị E','Đảng Cam','Doanh nhân trẻ khởi nghiệp trong ngành xanh.','https://i.pravatar.cc/150?u=e',0);
/*!40000 ALTER TABLE `candidates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `electionpredictions`
--

DROP TABLE IF EXISTS `electionpredictions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `electionpredictions` (
  `PredictionID` int(11) NOT NULL AUTO_INCREMENT,
  `CandidateID` int(11) DEFAULT NULL,
  `PredictionDate` date DEFAULT NULL,
  `PredictedSupportRate` float DEFAULT NULL,
  `ConfidenceLevel` float DEFAULT NULL,
  PRIMARY KEY (`PredictionID`),
  KEY `FK_PredCandidate` (`CandidateID`),
  CONSTRAINT `FK_PredCandidate` FOREIGN KEY (`CandidateID`) REFERENCES `candidates` (`CandidateID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `electionpredictions`
--

LOCK TABLES `electionpredictions` WRITE;
/*!40000 ALTER TABLE `electionpredictions` DISABLE KEYS */;
INSERT INTO `electionpredictions` VALUES (24,1,'2026-03-12',16.5,200),(25,2,'2026-03-12',37.5,30),(26,3,'2026-03-12',7.5,20),(27,4,'2026-03-12',7.5,30),(28,5,'2026-03-12',7.5,20);
/*!40000 ALTER TABLE `electionpredictions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sentimentresults`
--

DROP TABLE IF EXISTS `sentimentresults`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sentimentresults` (
  `ResultID` int(11) NOT NULL AUTO_INCREMENT,
  `DataID` int(11) DEFAULT NULL,
  `CandidateID` int(11) DEFAULT NULL,
  `SentimentLabel` varchar(20) DEFAULT NULL,
  `SentimentScore` float DEFAULT NULL,
  `AnalyzedAt` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`ResultID`),
  UNIQUE KEY `DataID` (`DataID`),
  KEY `FK_Candidate` (`CandidateID`),
  CONSTRAINT `FK_Candidate` FOREIGN KEY (`CandidateID`) REFERENCES `candidates` (`CandidateID`),
  CONSTRAINT `FK_SocialData` FOREIGN KEY (`DataID`) REFERENCES `socialdata` (`DataID`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sentimentresults`
--

LOCK TABLES `sentimentresults` WRITE;
/*!40000 ALTER TABLE `sentimentresults` DISABLE KEYS */;
INSERT INTO `sentimentresults` VALUES (1,1,2,'Positive',0.95,'2026-03-12 20:21:53'),(2,2,2,'Negative',-0.85,'2026-03-12 20:21:53'),(3,3,3,'Negative',-0.85,'2026-03-12 20:21:53'),(4,4,4,'Negative',-0.85,'2026-03-12 20:21:53'),(5,5,5,'Negative',-0.85,'2026-03-12 20:21:53'),(6,6,4,'Negative',-0.85,'2026-03-12 20:21:53'),(7,7,2,'Negative',-0.85,'2026-03-12 20:21:53'),(8,8,3,'Negative',-0.85,'2026-03-12 20:21:53'),(9,9,5,'Negative',-0.85,'2026-03-12 20:21:53'),(10,10,4,'Negative',-0.85,'2026-03-12 20:21:53'),(11,11,1,'Positive',0.95,'2026-03-12 20:21:53'),(12,12,1,'Negative',-0.85,'2026-03-12 20:21:53'),(13,13,1,'Negative',-0.85,'2026-03-12 20:21:53'),(14,14,1,'Negative',-0.85,'2026-03-12 20:21:53'),(15,15,1,'Negative',-0.85,'2026-03-12 20:21:53'),(16,16,1,'Negative',-0.85,'2026-03-12 20:21:53'),(17,17,1,'Negative',-0.85,'2026-03-12 20:21:53'),(18,18,1,'Negative',-0.85,'2026-03-12 20:21:53'),(19,19,1,'Negative',-0.85,'2026-03-12 20:21:53'),(20,20,1,'Negative',-0.85,'2026-03-12 20:21:53'),(21,21,1,'Positive',0.95,'2026-03-12 20:21:53'),(22,22,1,'Negative',-0.85,'2026-03-12 20:21:53'),(23,23,1,'Negative',-0.85,'2026-03-12 20:21:53'),(24,24,1,'Negative',-0.85,'2026-03-12 20:21:53'),(25,25,1,'Negative',-0.85,'2026-03-12 20:21:53'),(26,26,1,'Negative',-0.85,'2026-03-12 20:21:53'),(27,27,1,'Negative',-0.85,'2026-03-12 20:21:53'),(28,28,1,'Negative',-0.85,'2026-03-12 20:21:53'),(29,29,1,'Negative',-0.85,'2026-03-12 20:21:53'),(30,30,1,'Negative',-0.85,'2026-03-12 20:21:53');
/*!40000 ALTER TABLE `sentimentresults` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialdata`
--

DROP TABLE IF EXISTS `socialdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socialdata` (
  `DataID` int(11) NOT NULL AUTO_INCREMENT,
  `SourcePlatform` varchar(50) DEFAULT NULL,
  `RawContent` text NOT NULL,
  `AuthorName` varchar(100) DEFAULT NULL,
  `PostDate` datetime DEFAULT current_timestamp(),
  `Location` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`DataID`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialdata`
--

LOCK TABLES `socialdata` WRITE;
/*!40000 ALTER TABLE `socialdata` DISABLE KEYS */;
INSERT INTO `socialdata` VALUES (1,'Facebook','Ông Nguyễn Văn A có kế hoạch kinh tế rất tuyệt vời, tôi sẽ ủng hộ!','User123','2026-03-12 20:09:55','TP.HCM'),(2,'Twitter','Bà Trần Thị B hứa nhiều nhưng làm chẳng bao nhiêu, thất vọng.','AntiFan99','2026-03-12 20:09:55','Hà Nội'),(3,'Facebook','Tôi tin rằng Lê Hoàng C sẽ thay đổi bộ mặt công nghệ của thành phố.','TechLover','2026-03-12 20:09:55','Đà Nẵng'),(4,'News','Phạm Minh D tranh luận rất sắc sảo trong buổi đối thoại hôm qua.','NewsReader','2026-03-12 20:09:55','Cần Thơ'),(5,'Instagram','Hoàng Thị E còn quá trẻ, chưa đủ kinh nghiệm lãnh đạo đâu.','OldSchool','2026-03-12 20:09:55','Hải Phòng'),(6,'Facebook','Chính sách thuế của ông A sẽ giúp doanh nghiệp nhỏ phát triển.','BusinessOwner','2026-03-12 20:09:55','TP.HCM'),(7,'Twitter','Thật sự mệt mỏi với những lời hứa của bà B mỗi khi bầu cử.','CitizenX','2026-03-12 20:09:55','Hà Nội'),(8,'Facebook','Lê Hoàng C là người duy nhất hiểu về chuyển đổi số!','DigitalNomad','2026-03-12 20:09:55','Đà Lạt'),(9,'News','Dự án môi trường của bà E rất đáng khen ngợi, rất nhân văn.','EcoLover','2026-03-12 20:09:55','Huế'),(10,'Twitter','Ông D nói chuyện nghe thì hay nhưng thực tế thì khó làm lắm.','SkepticGuy','2026-03-12 20:09:55','Hà Nội'),(11,'Facebook','Ông Nguyễn Văn A có kế hoạch kinh tế rất tuyệt vời, tôi sẽ ủng hộ!','User123','2026-03-12 20:13:16','TP.HCM'),(12,'Twitter','Bà Trần Thị B hứa nhiều nhưng làm chẳng bao nhiêu, thất vọng.','AntiFan99','2026-03-12 20:13:16','Hà Nội'),(13,'Facebook','Tôi tin rằng Lê Hoàng C sẽ thay đổi bộ mặt công nghệ của thành phố.','TechLover','2026-03-12 20:13:16','Đà Nẵng'),(14,'News','Phạm Minh D tranh luận rất sắc sảo trong buổi đối thoại hôm qua.','NewsReader','2026-03-12 20:13:16','Cần Thơ'),(15,'Instagram','Hoàng Thị E còn quá trẻ, chưa đủ kinh nghiệm lãnh đạo đâu.','OldSchool','2026-03-12 20:13:16','Hải Phòng'),(16,'Facebook','Chính sách thuế của ông A sẽ giúp doanh nghiệp nhỏ phát triển.','BusinessOwner','2026-03-12 20:13:16','TP.HCM'),(17,'Twitter','Thật sự mệt mỏi với những lời hứa của bà B mỗi khi bầu cử.','CitizenX','2026-03-12 20:13:16','Hà Nội'),(18,'Facebook','Lê Hoàng C là người duy nhất hiểu về chuyển đổi số!','DigitalNomad','2026-03-12 20:13:16','Đà Lạt'),(19,'News','Dự án môi trường của bà E rất đáng khen ngợi, rất nhân văn.','EcoLover','2026-03-12 20:13:16','Huế'),(20,'Twitter','Ông D nói chuyện nghe thì hay nhưng thực tế thì khó làm lắm.','SkepticGuy','2026-03-12 20:13:16','Hà Nội'),(21,'Facebook','Ông Nguyễn Văn A có kế hoạch kinh tế rất tuyệt vời, tôi sẽ ủng hộ!','User123','2026-03-12 20:13:20','TP.HCM'),(22,'Twitter','Bà Trần Thị B hứa nhiều nhưng làm chẳng bao nhiêu, thất vọng.','AntiFan99','2026-03-12 20:13:20','Hà Nội'),(23,'Facebook','Tôi tin rằng Lê Hoàng C sẽ thay đổi bộ mặt công nghệ của thành phố.','TechLover','2026-03-12 20:13:20','Đà Nẵng'),(24,'News','Phạm Minh D tranh luận rất sắc sảo trong buổi đối thoại hôm qua.','NewsReader','2026-03-12 20:13:20','Cần Thơ'),(25,'Instagram','Hoàng Thị E còn quá trẻ, chưa đủ kinh nghiệm lãnh đạo đâu.','OldSchool','2026-03-12 20:13:20','Hải Phòng'),(26,'Facebook','Chính sách thuế của ông A sẽ giúp doanh nghiệp nhỏ phát triển.','BusinessOwner','2026-03-12 20:13:20','TP.HCM'),(27,'Twitter','Thật sự mệt mỏi với những lời hứa của bà B mỗi khi bầu cử.','CitizenX','2026-03-12 20:13:20','Hà Nội'),(28,'Facebook','Lê Hoàng C là người duy nhất hiểu về chuyển đổi số!','DigitalNomad','2026-03-12 20:13:20','Đà Lạt'),(29,'News','Dự án môi trường của bà E rất đáng khen ngợi, rất nhân văn.','EcoLover','2026-03-12 20:13:20','Huế'),(30,'Twitter','Ông D nói chuyện nghe thì hay nhưng thực tế thì khó làm lắm.','SkepticGuy','2026-03-12 20:13:20','Hà Nội'),(31,'Facebook','Ông Nguyễn Văn A có kế hoạch kinh tế rất tuyệt vời!','User1','2026-03-12 21:20:41','TP.HCM'),(32,'Twitter','Bà Trần Thị B hứa nhiều nhưng làm chẳng bao nhiêu.','User2','2026-03-12 21:20:41','Hà Nội'),(33,'Facebook','Lê Hoàng C sẽ thay đổi bộ mặt công nghệ.','User3','2026-03-12 21:20:41','Đà Nẵng'),(34,'News','Phạm Minh D tranh luận rất sắc sảo hôm qua.','User4','2026-03-12 21:20:41','Cần Thơ'),(35,'Instagram','Hoàng Thị E còn quá trẻ để lãnh đạo.','User5','2026-03-12 21:20:41','Hải Phòng'),(36,'Facebook','Chính sách thuế của ông A rất hợp lý.','User6','2026-03-12 21:20:41','TP.HCM'),(37,'Twitter','Thất vọng với những lời hứa của bà B.','User7','2026-03-12 21:20:41','Hà Nội'),(38,'Facebook','Anh C là người hiểu về chuyển đổi số nhất.','User8','2026-03-12 21:20:41','Đà Lạt'),(39,'News','Dự án môi trường của bà E rất đáng khen.','User9','2026-03-12 21:20:41','Huế'),(40,'Twitter','Ông D nói hay nhưng thực tế khó làm.','User10','2026-03-12 21:20:41','Hà Nội');
/*!40000 ALTER TABLE `socialdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'election_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-12 21:38:17
