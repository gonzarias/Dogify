
DROP TABLE IF EXISTS users;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE users(
  userID int NOT NULL AUTO_INCREMENT,
  userStatusID int NOT NULL COMMENT 'Estados del usuario definidos en la tabla userStatus' DEFAULT 1,
  firstName varchar(100) NOT NULL,
  lastName varchar(100) NOT NULL,
  birthdate date NOT NULL,
  -- Se agrega check para que permite ingreso de direcciones de email validas.
  emailAddress varchar(100) NOT NULL,
  sexID int NOT NULL,
  registerDate datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creación del usuario.',
  PRIMARY KEY (userID),
  UNIQUE KEY (emailAddress)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table userStatus
--
DROP TABLE IF EXISTS userStatus;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE userStatus (
  userStatusID int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del estado del usuario.',
  statusName varchar(30) NOT NULL COMMENT 'Nombre del estado.',
  statusDescription text NOT NULL COMMENT 'Descripción del estado.',
  PRIMARY KEY (userStatusID)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table grants
--
DROP TABLE IF EXISTS grants;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE grants (
  grantID int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del permiso.',
  grantName varchar(50) NOT NULL COMMENT 'Nombre del permiso.',
  grantDescription varchar(120) NOT NULL COMMENT 'Descripción del permiso.',
  grantLink varchar(300) NOT NULL COMMENT 'Link para PHP',
  menuOption int NOT NULL COMMENT 'Especifica si es una opción de menu o no',
  PRIMARY KEY (grantID)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table roleGrants
--
DROP TABLE IF EXISTS roleGrants;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE roleGrants (
  roleGrantID int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de permiso asociado al rol.',
  roleID int NOT NULL COMMENT 'Identificador del rol.',
  grantID int NOT NULL COMMENT 'Identificador del permiso.',
  PRIMARY KEY (roleGrantID),
  UNIQUE KEY (roleID, grantID)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table userRoles
--
DROP TABLE IF EXISTS userRoles;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE userRoles (
  userRoleID int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único de la asociación entre el rol y el usuario',
  userID int NOT NULL COMMENT 'ID del usuario.',
  roleID int NOT NULL COMMENT 'ID del rol.',
  PRIMARY KEY (userRoleID),
  UNIQUE KEY (userID, roleID)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Table structure for table userPasswords
--
DROP TABLE IF EXISTS userPasswords;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE userPasswords(
	userPasswordID int NOT NULL AUTO_INCREMENT,
  userID int NOT NULL,
	userPasswordStatusID int NOT NULL COMMENT '1 Vigente, 2 Historico' DEFAULT 1,
  userPassword varchar(50) NOT NULL COMMENT 'Password del usuario',
	registerDate datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creación de la password.',
  PRIMARY KEY (userPasswordID)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table loginAttempts
-- Tabla para identificar la cantidad de veces que un usuario intenta loguearse.
DROP TABLE IF EXISTS loginAttempts;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE loginAttempts (
  loginAttemptID int NOT NULL AUTO_INCREMENT,
  IP varchar(50) NOT NULL,
  Attempts int(11) NOT NULL,
  LastLogin datetime NOT NULL,
  emailAddress varchar(65) DEFAULT NULL,
  PRIMARY KEY (loginAttemptID)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

DROP TABLE IF EXISTS dogWalkerLocation;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE dogWalkerLocation(
  locationID int NOT NULL AUTO_INCREMENT,
  dogWalkerID int NOT NULL,
  walkerID int NOT NULL,
  walkID int NOT NULL,
  lat float NULL,
  lng float NULL,
  registerDate datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creación del registro.',
  PRIMARY KEY (locationID),
  UNIQUE KEY (dogWalkerID,walkerID,walkID)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

