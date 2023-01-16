CREATE DATABASE  IF NOT EXISTS `pet_care_bd` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `pet_care_bd`;
-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: pet_care_bd
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
-- Table structure for table `cat001_usuarios`
--

DROP TABLE IF EXISTS `cat001_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cat001_usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(25) NOT NULL,
  `apellido` varchar(25) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `celular` varchar(12) NOT NULL,
  `pass` varchar(150) NOT NULL,
  `tipo_usuario` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tipo_usuario` (`tipo_usuario`),
  CONSTRAINT `cat001_usuarios_ibfk_1` FOREIGN KEY (`tipo_usuario`) REFERENCES `cat002_tipo_usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat001_usuarios`
--

LOCK TABLES `cat001_usuarios` WRITE;
/*!40000 ALTER TABLE `cat001_usuarios` DISABLE KEYS */;
INSERT INTO `cat001_usuarios` VALUES (2,'Luis ','Lopez','luis.luis.la2002@gmail.com','55-5100-6817','$2a$08$vCOZ.ldpjewfYeXrZYhcK.jkKkq6J1eQ/DuNXX.j.lS/kbyInL09S',1),(3,'Eric','Lopez','eric@correo.com','55-8796-4789','$2a$08$STrtwtPznUHmlb2AK.9E6egmwKTTy4UZxl5y84Xr5t6pvwLEzrrri',3),(4,'Arcadio','Guerrero','arcadio@veterinario.com','55-8888-9999','$2a$08$vCOZ.ldpjewfYeXrZYhcK.jkKkq6J1eQ/DuNXX.j.lS/kbyInL09S',2),(5,'Eduardo ','Leon Arellano','eduardo.leon@veterinario.com','55-7687-0958','$2a$08$vCOZ.ldpjewfYeXrZYhcK.jkKkq6J1eQ/DuNXX.j.lS/kbyInL09S',2),(6,'Luis Daniel','Flores Navarro','daniel@gmail.com','55-7896-1452','$2a$08$SQ4msAn1Q2sHxUEZn/.ASuglMRkd2IfG.JUbbeBe.QCrVMR6nk1H2',3),(7,'Ricardo Angel','Ayala Gonzalez','ricardo@gmail.com','55-7896-1452','$2a$08$yLanLjTH5d9GPJwRWpuukObUcRHnsMWnyqqqVYskMnzKTuQATn7qe',2);
/*!40000 ALTER TABLE `cat001_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat002_tipo_usuario`
--

DROP TABLE IF EXISTS `cat002_tipo_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cat002_tipo_usuario` (
  `id` int NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat002_tipo_usuario`
--

LOCK TABLES `cat002_tipo_usuario` WRITE;
/*!40000 ALTER TABLE `cat002_tipo_usuario` DISABLE KEYS */;
INSERT INTO `cat002_tipo_usuario` VALUES (1,'Administrador'),(2,'Veterinario'),(3,'PetOwner');
/*!40000 ALTER TABLE `cat002_tipo_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat003_veterinario`
--

DROP TABLE IF EXISTS `cat003_veterinario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cat003_veterinario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `cedula` int DEFAULT NULL,
  `id_clinica` int DEFAULT NULL,
  `valoracion` double DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_clinica` (`id_clinica`),
  CONSTRAINT `cat003_veterinario_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `cat001_usuarios` (`id`),
  CONSTRAINT `cat003_veterinario_ibfk_2` FOREIGN KEY (`id_clinica`) REFERENCES `cat004_clinica` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat003_veterinario`
--

LOCK TABLES `cat003_veterinario` WRITE;
/*!40000 ALTER TABLE `cat003_veterinario` DISABLE KEYS */;
INSERT INTO `cat003_veterinario` VALUES (1,4,558796413,1,3.6),(2,5,55632147,2,5),(3,7,54896578,3,3);
/*!40000 ALTER TABLE `cat003_veterinario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat004_clinica`
--

DROP TABLE IF EXISTS `cat004_clinica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cat004_clinica` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `valoracion` double DEFAULT '0',
  `enlace_web` varchar(300) DEFAULT NULL,
  `visita_domicilio` tinyint(1) NOT NULL,
  `telefono` varchar(12) NOT NULL,
  `hora_entrada` time NOT NULL,
  `hora_salida` time NOT NULL,
  `is_checked` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat004_clinica`
--

LOCK TABLES `cat004_clinica` WRITE;
/*!40000 ALTER TABLE `cat004_clinica` DISABLE KEYS */;
INSERT INTO `cat004_clinica` VALUES (1,'Centro Veterinario Cergom',3.6,'https://consultorio-veterinario-cergom.negocio.site/',0,'','00:00:00','23:59:00',1),(2,'Veterinaria Kan Kan',5,'https://veterinaria-kan-kan.negocio.site/',1,'55-7108-4634','10:00:00','19:00:00',1),(3,'Casa Luna Tlalnepantla',3,'https://casaluna.com.mx/pages/tlalnepantla',0,'55-7005-0531','09:00:00','18:00:00',1),(5,'ESCOM Mascotas',0,'https://consultorio-veterinario-cergom.negocio.site/',1,'55-8964-7854','09:00:00','18:00:00',1);
/*!40000 ALTER TABLE `cat004_clinica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat005_direcciones`
--

DROP TABLE IF EXISTS `cat005_direcciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cat005_direcciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_clinica` int NOT NULL,
  `calle` varchar(150) NOT NULL,
  `estado` varchar(150) NOT NULL,
  `municipio` varchar(150) NOT NULL,
  `interior` varchar(6) DEFAULT NULL,
  `exterior` int NOT NULL,
  `colonia` varchar(150) NOT NULL,
  `codigo_postal` int NOT NULL,
  `latitud` double NOT NULL,
  `longitud` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_clinica` (`id_clinica`),
  CONSTRAINT `cat005_direcciones_ibfk_1` FOREIGN KEY (`id_clinica`) REFERENCES `cat004_clinica` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat005_direcciones`
--

LOCK TABLES `cat005_direcciones` WRITE;
/*!40000 ALTER TABLE `cat005_direcciones` DISABLE KEYS */;
INSERT INTO `cat005_direcciones` VALUES (1,1,'Granada','Estado de Mexico','Ciudad López Mateos','1',2,'Las Peñitas',52920,19.5915002,-99.2187428),(2,2,'Avenida Juarez','Estado de Mexico','Tlalnepantla de Baz','1',32,'San Pedro Barrientos',54010,19.5821458,-99.1991837),(3,3,'Francisco Sarabia','Estado de México','Tlalnepantla de Baz','1',28,'Tlalnepantla Centro',54000,19.54068166570881,-99.1938501),(5,5,'Melchor Ocampo','Estado de Mexico','Tlalnepantla de Baz','1',18,'San Pedro Barrientos',54010,19.52355289169168,-99.01153564453126);
/*!40000 ALTER TABLE `cat005_direcciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat008_tipo_mascota`
--

DROP TABLE IF EXISTS `cat008_tipo_mascota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cat008_tipo_mascota` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat008_tipo_mascota`
--

LOCK TABLES `cat008_tipo_mascota` WRITE;
/*!40000 ALTER TABLE `cat008_tipo_mascota` DISABLE KEYS */;
INSERT INTO `cat008_tipo_mascota` VALUES (1,'Perro'),(2,'Gato'),(3,'Roedor'),(4,'Pez'),(5,'Ave'),(6,'Reptil'),(7,'Aracnido');
/*!40000 ALTER TABLE `cat008_tipo_mascota` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat009_especies`
--

DROP TABLE IF EXISTS `cat009_especies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cat009_especies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_tipo` int NOT NULL,
  `especie` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_tipo` (`id_tipo`),
  CONSTRAINT `cat009_especies_ibfk_1` FOREIGN KEY (`id_tipo`) REFERENCES `cat008_tipo_mascota` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat009_especies`
--

LOCK TABLES `cat009_especies` WRITE;
/*!40000 ALTER TABLE `cat009_especies` DISABLE KEYS */;
INSERT INTO `cat009_especies` VALUES (1,1,'Pastor Aleman'),(2,1,'Husky Siberiano'),(3,1,'Alaska Malamute'),(4,1,'Chihuahua'),(5,1,'French Poodle'),(6,1,'Bulldog'),(7,1,'Pitbull'),(8,1,'Doberman'),(9,1,'Pug'),(10,1,'Bullterrier'),(11,1,'Schnauzer'),(12,1,'Labrador'),(13,1,'Golden Retriver'),(14,1,'Sabueso'),(15,1,'Pastor Belga'),(16,2,'Persa'),(17,2,'Azul Ruso'),(18,2,'Siames'),(19,2,'Abisino'),(20,2,'Angora'),(21,2,'Bombay'),(22,2,'Birmano'),(23,2,'Britanico de Pelo Corto'),(24,2,'Maine Coon'),(25,2,'Ragdol'),(26,2,'Esfinge'),(27,3,'Hamster'),(28,3,'Cuyo'),(29,3,'Raton'),(30,3,'Huron'),(31,3,'Chinchilla'),(32,3,'Conejo'),(33,4,'Beta'),(34,4,'Dorado'),(35,4,'Payaso'),(36,4,'Angel'),(37,4,'Guppy'),(38,4,'Platy'),(39,4,'Barbo Rosado'),(40,5,'Loro'),(41,5,'Agapornisa'),(42,5,'Perico'),(43,5,'Ninfa'),(44,5,'Jilguero'),(45,5,'Cacatua'),(46,6,'Iguana'),(47,6,'Gecko'),(48,6,'Camaleon'),(49,6,'Tortuga Marina'),(50,6,'Serpiente'),(51,7,'Tarantula'),(52,7,'Elegante Saltarodra'),(53,7,'Punta de Flecha'),(54,7,'Saltadora Espalda Roja'),(55,7,'Hormiga Saltadora'),(56,7,'Araña Mariquita'),(57,7,'Sonriente'),(58,7,'Saltadora Pesada'),(59,7,'Saltadora del Himalaya'),(60,7,'Espinosa'),(61,7,'Saltadora Verda'),(62,7,'Pavo Real'),(63,7,'Cara de Ogro'),(64,7,'Viciria Saltadora'),(65,7,'Cangrejo'),(66,7,'Espejo');
/*!40000 ALTER TABLE `cat009_especies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat010_mascota`
--

DROP TABLE IF EXISTS `cat010_mascota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cat010_mascota` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_owner` int NOT NULL,
  `tipo` int NOT NULL,
  `especie` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `sexo` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_owner` (`id_owner`),
  KEY `tipo` (`tipo`),
  KEY `especie` (`especie`),
  CONSTRAINT `cat010_mascota_ibfk_1` FOREIGN KEY (`id_owner`) REFERENCES `cat001_usuarios` (`id`),
  CONSTRAINT `cat010_mascota_ibfk_2` FOREIGN KEY (`tipo`) REFERENCES `cat008_tipo_mascota` (`id`),
  CONSTRAINT `cat010_mascota_ibfk_3` FOREIGN KEY (`especie`) REFERENCES `cat009_especies` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat010_mascota`
--

LOCK TABLES `cat010_mascota` WRITE;
/*!40000 ALTER TABLE `cat010_mascota` DISABLE KEYS */;
INSERT INTO `cat010_mascota` VALUES (1,3,2,23,'Tsuki','H'),(2,6,1,2,'Togo','M');
/*!40000 ALTER TABLE `cat010_mascota` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cat011_tipo_consulta`
--

DROP TABLE IF EXISTS `cat011_tipo_consulta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cat011_tipo_consulta` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cat011_tipo_consulta`
--

LOCK TABLES `cat011_tipo_consulta` WRITE;
/*!40000 ALTER TABLE `cat011_tipo_consulta` DISABLE KEYS */;
INSERT INTO `cat011_tipo_consulta` VALUES (1,'Urgencias'),(2,'Vacunacion'),(3,'Desparacitacion'),(4,'Revision Medica'),(5,'Consulta Medica'),(6,'Asesoramiento Medico'),(7,'Servicio de Estetica');
/*!40000 ALTER TABLE `cat011_tipo_consulta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `clinicas_view001`
--

DROP TABLE IF EXISTS `clinicas_view001`;
/*!50001 DROP VIEW IF EXISTS `clinicas_view001`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `clinicas_view001` AS SELECT 
 1 AS `id`,
 1 AS `nombre`,
 1 AS `valoracion`,
 1 AS `pagina`,
 1 AS `visita_domicilio`,
 1 AS `telefono`,
 1 AS `calle`,
 1 AS `exterior`,
 1 AS `interior`,
 1 AS `colonia`,
 1 AS `cp`,
 1 AS `municipio`,
 1 AS `estado`,
 1 AS `latitud`,
 1 AS `longitud`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `comentarios_view001`
--

DROP TABLE IF EXISTS `comentarios_view001`;
/*!50001 DROP VIEW IF EXISTS `comentarios_view001`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `comentarios_view001` AS SELECT 
 1 AS `id`,
 1 AS `id_usuario`,
 1 AS `nombre_usuario`,
 1 AS `apellido_usuario`,
 1 AS `id_veterinario`,
 1 AS `nombre_veterinario`,
 1 AS `apellido_veterinario`,
 1 AS `valoracion`,
 1 AS `titulo`,
 1 AS `mensaje`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `consultas_view001`
--

DROP TABLE IF EXISTS `consultas_view001`;
/*!50001 DROP VIEW IF EXISTS `consultas_view001`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `consultas_view001` AS SELECT 
 1 AS `id`,
 1 AS `id_veterinario`,
 1 AS `cedula_veterinario`,
 1 AS `veterinario_nombre`,
 1 AS `veterinario_apellido`,
 1 AS `veterinario_celular`,
 1 AS `veterinario_correo`,
 1 AS `id_clinica`,
 1 AS `clinica`,
 1 AS `clinica_telefono`,
 1 AS `clinica_calle`,
 1 AS `clinica_interior`,
 1 AS `clinica_exterior`,
 1 AS `clinica_colonia`,
 1 AS `clinica_municipio`,
 1 AS `clinica_estado`,
 1 AS `clinica_cp`,
 1 AS `id_mascota`,
 1 AS `mascota`,
 1 AS `id_owner`,
 1 AS `mascota_tipo`,
 1 AS `mascota_especie`,
 1 AS `mascota_sexo`,
 1 AS `dia`,
 1 AS `hora`,
 1 AS `tipo_consulta`,
 1 AS `tipo`,
 1 AS `descripcion`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `mascotas_view001`
--

DROP TABLE IF EXISTS `mascotas_view001`;
/*!50001 DROP VIEW IF EXISTS `mascotas_view001`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `mascotas_view001` AS SELECT 
 1 AS `id`,
 1 AS `id_owner`,
 1 AS `id_tipo`,
 1 AS `tipo`,
 1 AS `id_especie`,
 1 AS `especie`,
 1 AS `nombre`,
 1 AS `sexo`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `op001_consultas`
--

DROP TABLE IF EXISTS `op001_consultas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `op001_consultas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_veterinario` int NOT NULL,
  `id_mascota` int NOT NULL,
  `dia` date NOT NULL,
  `hora` time NOT NULL,
  `tipo_consulta` int NOT NULL,
  `descripcion` text,
  PRIMARY KEY (`id`),
  KEY `id_veterinario` (`id_veterinario`),
  KEY `id_mascota` (`id_mascota`),
  KEY `tipo_consulta` (`tipo_consulta`),
  CONSTRAINT `op001_consultas_ibfk_1` FOREIGN KEY (`id_veterinario`) REFERENCES `cat003_veterinario` (`id`),
  CONSTRAINT `op001_consultas_ibfk_2` FOREIGN KEY (`id_mascota`) REFERENCES `cat010_mascota` (`id`),
  CONSTRAINT `op001_consultas_ibfk_3` FOREIGN KEY (`tipo_consulta`) REFERENCES `cat011_tipo_consulta` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `op001_consultas`
--

LOCK TABLES `op001_consultas` WRITE;
/*!40000 ALTER TABLE `op001_consultas` DISABLE KEYS */;
INSERT INTO `op001_consultas` VALUES (1,1,1,'2023-01-10','15:00:00',1,'Ayudaaaa'),(4,1,2,'2023-02-03','14:36:00',3,'Quiero realizar la desparasitación de mi perro, pues comió de donde no debía'),(5,3,2,'2023-02-09','15:30:00',2,'Necesito Aplicar la vacunación antirabica'),(6,2,2,'2023-01-14','05:30:00',4,'Se reviso a Togo'),(7,2,2,'2023-01-16','15:00:00',1,'Transfucion a Togo por problemas en el riñon, se le recomienda reposo y cuidados especiales');
/*!40000 ALTER TABLE `op001_consultas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `op002_sugerencia`
--

DROP TABLE IF EXISTS `op002_sugerencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `op002_sugerencia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_clinica` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_clinica` (`id_clinica`),
  CONSTRAINT `op002_sugerencia_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `cat001_usuarios` (`id`),
  CONSTRAINT `op002_sugerencia_ibfk_2` FOREIGN KEY (`id_clinica`) REFERENCES `cat004_clinica` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `op002_sugerencia`
--

LOCK TABLES `op002_sugerencia` WRITE;
/*!40000 ALTER TABLE `op002_sugerencia` DISABLE KEYS */;
/*!40000 ALTER TABLE `op002_sugerencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `op003_comentario`
--

DROP TABLE IF EXISTS `op003_comentario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `op003_comentario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_veterinario` int NOT NULL,
  `valoracion` double NOT NULL,
  `titulo` varchar(155) NOT NULL,
  `mensaje` varchar(5000) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_veterinario` (`id_veterinario`),
  CONSTRAINT `op003_comentario_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `cat001_usuarios` (`id`),
  CONSTRAINT `op003_comentario_ibfk_2` FOREIGN KEY (`id_veterinario`) REFERENCES `cat003_veterinario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `op003_comentario`
--

LOCK TABLES `op003_comentario` WRITE;
/*!40000 ALTER TABLE `op003_comentario` DISABLE KEYS */;
INSERT INTO `op003_comentario` VALUES (1,3,1,5,'Buen Veterinario','Es muy veterinario, profesional y tiene gran amor a los animales'),(3,3,1,2,'Un poco decepcionado','La ultima vez nos atendió de una manera excelente, pero en esta ocasion fue muy grosero y poco humilde'),(5,3,2,5,'Muy buen veterinario','Atento, amable y se nota la pasion  por su profesion'),(6,3,1,5,'Excelente atencion','El mejor veterinario con el que he llevado a mi mascota'),(7,6,1,5,'Excelente Servicio','Llegué un poco antes y me atendió sin problemas, la atención fue de primera, muy amable y mi perrito lo adoró'),(8,6,3,3,'Servicio Regular','No me convenció mucho su forma de trabajar, siento que no dominaba su profesión, pero afortunadamente mi mascota salió adelante'),(9,3,1,1,'Pésimo Servicio','LLegó tarde, nos atendió de mal humor');
/*!40000 ALTER TABLE `op003_comentario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `sugerencias_view001`
--

DROP TABLE IF EXISTS `sugerencias_view001`;
/*!50001 DROP VIEW IF EXISTS `sugerencias_view001`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `sugerencias_view001` AS SELECT 
 1 AS `id`,
 1 AS `id_clinica`,
 1 AS `clinica`,
 1 AS `telefono`,
 1 AS `pagina`,
 1 AS `calle`,
 1 AS `colonia`,
 1 AS `cp`,
 1 AS `interior`,
 1 AS `exterior`,
 1 AS `municipio`,
 1 AS `estado`,
 1 AS `id_usuario`,
 1 AS `nombre_usuario`,
 1 AS `apellido_usuario`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `veterinario_view002`
--

DROP TABLE IF EXISTS `veterinario_view002`;
/*!50001 DROP VIEW IF EXISTS `veterinario_view002`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `veterinario_view002` AS SELECT 
 1 AS `id`,
 1 AS `id_usuario`,
 1 AS `nombre`,
 1 AS `apellido`,
 1 AS `correo`,
 1 AS `celular`,
 1 AS `cedula`,
 1 AS `valoracion`,
 1 AS `id_clinica`,
 1 AS `clinica`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `veterinario_view003`
--

DROP TABLE IF EXISTS `veterinario_view003`;
/*!50001 DROP VIEW IF EXISTS `veterinario_view003`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `veterinario_view003` AS SELECT 
 1 AS `id_veterinario`,
 1 AS `promedio`,
 1 AS `id_usuario`,
 1 AS `nombre`,
 1 AS `apellido`,
 1 AS `correo`,
 1 AS `celular`,
 1 AS `cedula`,
 1 AS `id_clinica`,
 1 AS `clinica`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `veterinarios_view001`
--

DROP TABLE IF EXISTS `veterinarios_view001`;
/*!50001 DROP VIEW IF EXISTS `veterinarios_view001`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `veterinarios_view001` AS SELECT 
 1 AS `id`,
 1 AS `nombre`,
 1 AS `apellido`,
 1 AS `correo`,
 1 AS `celular`,
 1 AS `cedula`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `clinicas_view001`
--

/*!50001 DROP VIEW IF EXISTS `clinicas_view001`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `clinicas_view001` AS select `cat004_clinica`.`id` AS `id`,`cat004_clinica`.`nombre` AS `nombre`,`cat004_clinica`.`valoracion` AS `valoracion`,`cat004_clinica`.`enlace_web` AS `pagina`,`cat004_clinica`.`visita_domicilio` AS `visita_domicilio`,`cat004_clinica`.`telefono` AS `telefono`,`cat005_direcciones`.`calle` AS `calle`,`cat005_direcciones`.`exterior` AS `exterior`,`cat005_direcciones`.`interior` AS `interior`,`cat005_direcciones`.`colonia` AS `colonia`,`cat005_direcciones`.`codigo_postal` AS `cp`,`cat005_direcciones`.`municipio` AS `municipio`,`cat005_direcciones`.`estado` AS `estado`,`cat005_direcciones`.`latitud` AS `latitud`,`cat005_direcciones`.`longitud` AS `longitud` from (`cat004_clinica` join `cat005_direcciones` on((`cat005_direcciones`.`id_clinica` = `cat004_clinica`.`id`))) where (`cat004_clinica`.`is_checked` = 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `comentarios_view001`
--

/*!50001 DROP VIEW IF EXISTS `comentarios_view001`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `comentarios_view001` AS select `op003_comentario`.`id` AS `id`,`op003_comentario`.`id_usuario` AS `id_usuario`,`cat001_usuarios`.`nombre` AS `nombre_usuario`,`cat001_usuarios`.`apellido` AS `apellido_usuario`,`op003_comentario`.`id_veterinario` AS `id_veterinario`,`veterinario_view002`.`nombre` AS `nombre_veterinario`,`veterinario_view002`.`apellido` AS `apellido_veterinario`,`op003_comentario`.`valoracion` AS `valoracion`,`op003_comentario`.`titulo` AS `titulo`,`op003_comentario`.`mensaje` AS `mensaje` from ((`op003_comentario` join `cat001_usuarios` on((`op003_comentario`.`id_usuario` = `cat001_usuarios`.`id`))) join `veterinario_view002` on((`op003_comentario`.`id_veterinario` = `veterinario_view002`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `consultas_view001`
--

/*!50001 DROP VIEW IF EXISTS `consultas_view001`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `consultas_view001` AS select `op001_consultas`.`id` AS `id`,`op001_consultas`.`id_veterinario` AS `id_veterinario`,`cat003_veterinario`.`cedula` AS `cedula_veterinario`,`cat001_usuarios`.`nombre` AS `veterinario_nombre`,`cat001_usuarios`.`apellido` AS `veterinario_apellido`,`cat001_usuarios`.`celular` AS `veterinario_celular`,`cat001_usuarios`.`correo` AS `veterinario_correo`,`cat003_veterinario`.`id_clinica` AS `id_clinica`,`cat004_clinica`.`nombre` AS `clinica`,`cat004_clinica`.`telefono` AS `clinica_telefono`,`cat005_direcciones`.`calle` AS `clinica_calle`,`cat005_direcciones`.`interior` AS `clinica_interior`,`cat005_direcciones`.`exterior` AS `clinica_exterior`,`cat005_direcciones`.`colonia` AS `clinica_colonia`,`cat005_direcciones`.`municipio` AS `clinica_municipio`,`cat005_direcciones`.`estado` AS `clinica_estado`,`cat005_direcciones`.`codigo_postal` AS `clinica_cp`,`op001_consultas`.`id_mascota` AS `id_mascota`,`cat010_mascota`.`nombre` AS `mascota`,`cat010_mascota`.`id_owner` AS `id_owner`,`cat008_tipo_mascota`.`tipo` AS `mascota_tipo`,`cat009_especies`.`especie` AS `mascota_especie`,`cat010_mascota`.`sexo` AS `mascota_sexo`,`op001_consultas`.`dia` AS `dia`,`op001_consultas`.`hora` AS `hora`,`op001_consultas`.`tipo_consulta` AS `tipo_consulta`,`cat011_tipo_consulta`.`tipo` AS `tipo`,`op001_consultas`.`descripcion` AS `descripcion` from ((((((((`op001_consultas` join `cat003_veterinario` on((`op001_consultas`.`id_veterinario` = `cat003_veterinario`.`id`))) join `cat001_usuarios` on((`cat003_veterinario`.`id_usuario` = `cat001_usuarios`.`id`))) join `cat004_clinica` on((`cat003_veterinario`.`id_clinica` = `cat004_clinica`.`id`))) join `cat005_direcciones` on((`cat004_clinica`.`id` = `cat005_direcciones`.`id_clinica`))) join `cat010_mascota` on((`op001_consultas`.`id_mascota` = `cat010_mascota`.`id`))) join `cat008_tipo_mascota` on((`cat010_mascota`.`tipo` = `cat008_tipo_mascota`.`id`))) join `cat009_especies` on((`cat010_mascota`.`especie` = `cat009_especies`.`id`))) join `cat011_tipo_consulta` on((`op001_consultas`.`tipo_consulta` = `cat011_tipo_consulta`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `mascotas_view001`
--

/*!50001 DROP VIEW IF EXISTS `mascotas_view001`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `mascotas_view001` AS select `cat010_mascota`.`id` AS `id`,`cat010_mascota`.`id_owner` AS `id_owner`,`cat010_mascota`.`tipo` AS `id_tipo`,`cat008_tipo_mascota`.`tipo` AS `tipo`,`cat010_mascota`.`especie` AS `id_especie`,`cat009_especies`.`especie` AS `especie`,`cat010_mascota`.`nombre` AS `nombre`,`cat010_mascota`.`sexo` AS `sexo` from ((`cat010_mascota` join `cat008_tipo_mascota` on((`cat010_mascota`.`tipo` = `cat008_tipo_mascota`.`id`))) join `cat009_especies` on((`cat010_mascota`.`especie` = `cat009_especies`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `sugerencias_view001`
--

/*!50001 DROP VIEW IF EXISTS `sugerencias_view001`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `sugerencias_view001` AS select `op002_sugerencia`.`id` AS `id`,`op002_sugerencia`.`id_clinica` AS `id_clinica`,`cat004_clinica`.`nombre` AS `clinica`,`cat004_clinica`.`telefono` AS `telefono`,`cat004_clinica`.`enlace_web` AS `pagina`,`cat005_direcciones`.`calle` AS `calle`,`cat005_direcciones`.`colonia` AS `colonia`,`cat005_direcciones`.`codigo_postal` AS `cp`,`cat005_direcciones`.`interior` AS `interior`,`cat005_direcciones`.`exterior` AS `exterior`,`cat005_direcciones`.`municipio` AS `municipio`,`cat005_direcciones`.`estado` AS `estado`,`op002_sugerencia`.`id_usuario` AS `id_usuario`,`cat001_usuarios`.`nombre` AS `nombre_usuario`,`cat001_usuarios`.`apellido` AS `apellido_usuario` from (((`op002_sugerencia` join `cat004_clinica` on((`op002_sugerencia`.`id_clinica` = `cat004_clinica`.`id`))) join `cat005_direcciones` on((`cat004_clinica`.`id` = `cat005_direcciones`.`id_clinica`))) join `cat001_usuarios` on((`op002_sugerencia`.`id_usuario` = `cat001_usuarios`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `veterinario_view002`
--

/*!50001 DROP VIEW IF EXISTS `veterinario_view002`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `veterinario_view002` AS select `cat003_veterinario`.`id` AS `id`,`cat003_veterinario`.`id_usuario` AS `id_usuario`,`cat001_usuarios`.`nombre` AS `nombre`,`cat001_usuarios`.`apellido` AS `apellido`,`cat001_usuarios`.`correo` AS `correo`,`cat001_usuarios`.`celular` AS `celular`,`cat003_veterinario`.`cedula` AS `cedula`,`cat003_veterinario`.`valoracion` AS `valoracion`,`cat003_veterinario`.`id_clinica` AS `id_clinica`,`cat004_clinica`.`nombre` AS `clinica` from ((`cat003_veterinario` join `cat001_usuarios` on((`cat003_veterinario`.`id_usuario` = `cat001_usuarios`.`id`))) join `cat004_clinica` on((`cat003_veterinario`.`id_clinica` = `cat004_clinica`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `veterinario_view003`
--

/*!50001 DROP VIEW IF EXISTS `veterinario_view003`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `veterinario_view003` AS select `op003_comentario`.`id_veterinario` AS `id_veterinario`,avg(`op003_comentario`.`valoracion`) AS `promedio`,`veterinario_view002`.`id_usuario` AS `id_usuario`,`veterinario_view002`.`nombre` AS `nombre`,`veterinario_view002`.`apellido` AS `apellido`,`veterinario_view002`.`correo` AS `correo`,`veterinario_view002`.`celular` AS `celular`,`veterinario_view002`.`cedula` AS `cedula`,`veterinario_view002`.`id_clinica` AS `id_clinica`,`veterinario_view002`.`clinica` AS `clinica` from (`op003_comentario` join `veterinario_view002` on((`op003_comentario`.`id_veterinario` = `veterinario_view002`.`id`))) group by `op003_comentario`.`id_veterinario` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `veterinarios_view001`
--

/*!50001 DROP VIEW IF EXISTS `veterinarios_view001`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `veterinarios_view001` AS select `cat003_veterinario`.`id_usuario` AS `id`,`cat001_usuarios`.`nombre` AS `nombre`,`cat001_usuarios`.`apellido` AS `apellido`,`cat001_usuarios`.`correo` AS `correo`,`cat001_usuarios`.`celular` AS `celular`,`cat003_veterinario`.`cedula` AS `cedula` from (`cat003_veterinario` join `cat001_usuarios` on((`cat003_veterinario`.`id_usuario` = `cat001_usuarios`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-01-16 15:33:36
