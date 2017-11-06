--
-- Table structure for table DocTypes
--
DROP TABLE IF EXISTS DocTypes;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE DocTypes(
	docTypeID int NOT NULL AUTO_INCREMENT,
	docDescription varchar(30) NOT NULL,
	docCode varchar(4) NOT NULL,
	defaultValue int DEFAULT 0,
	registerDate datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creación del registro.',
	lastUpdate  datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (docTypeID)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table roles
--
DROP TABLE IF EXISTS roles;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE roles (
  roleID int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del rol del usuario.',
  roleName varchar(30) NOT NULL COMMENT 'Nombre del rol del usuario.',
  roleDescription varchar(100) NOT NULL COMMENT 'Descripción del rol.',
  PRIMARY KEY (roleID)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table scores
--
DROP TABLE IF EXISTS scores;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE scores (
  ScoreID int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del score.',
  scoreName varchar(30) NOT NULL COMMENT 'Nombre del score.',
  ScoreDescription varchar(100) NOT NULL COMMENT 'Descripción.',
  PRIMARY KEY (ScoreID)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table users
--

DROP TABLE IF EXISTS usersInformation;
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

DROP TABLE IF EXISTS usersInformation;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE usersInformation(
  userID int NOT NULL ,
  userName varchar(30) NOT NULL,
  docTypeID int NULL COMMENT 'Referencia a docTypes, tipos de documento.',
  docNumber varchar(30)  NULL,
  isAuthenticated int COMMENT 'Indica si el usuario está o no autenticado. 1)Autenticado 2) No autenticado' DEFAULT 2,
  authenticationDate date COMMENT 'Fecha de autenticación.' DEFAULT NULL,
  countryID int NULL,
  stateProvinceID int  NULL,
  cityID int  NULL,
  streetAddress varchar(100)  NULL,
  zipCode varchar(30)  NULL,
  areaCode varchar(10)  NULL,
  phoneNumber varchar(20)  NULL,
  registerDate datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de creación del usuario.',
  lastUpdate datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de ultima actualización.',
  lastLoggin datetime DEFAULT NULL COMMENT 'Fecha del ultimo acceso.',
  failCount tinyint NULL DEFAULT 0 COMMENT 'Cuenta la cantidad de ingresos fallidos.',
  PRIMARY KEY (userID),
    UNIQUE KEY (docTypeID, docNumber),
  CONSTRAINT FK_userUserInf FOREIGN KEY (userID)
  REFERENCES users(userID)
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
-- Estructura de tabla para la tabla professionals
--
DROP TABLE IF EXISTS professionals;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS professionals (
  professionalID int NOT NULL AUTO_INCREMENT,
  userID int NOT NULL,
  PRIMARY KEY (professionalID),
  UNIQUE KEY (userID)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;


--
-- Estructura de tabla para la tabla professions
--
DROP TABLE IF EXISTS professions;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS professions (
  professionID int NOT NULL AUTO_INCREMENT,
  professionName varchar(100) NOT NULL,
  PRIMARY KEY (professionID)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;


--
-- Estructura de tabla para la tabla clients
--
DROP TABLE IF EXISTS clients;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS clients (
  clientID int NOT NULL AUTO_INCREMENT,
  userID int NOT NULL,
  PRIMARY KEY (clientID),
  UNIQUE KEY (userID)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;


--
-- Table structure for table clientScores
--
DROP TABLE IF EXISTS clientScores;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE clientScores (
  clientScoreID int NOT NULL AUTO_INCREMENT,
  scoreID int NOT NULL COMMENT 'Identificador único del score.',
  professionalID int NOT NULL,
  comments text COMMENT 'Comentarios.',
  PRIMARY KEY (clientScoreID)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table professionalScores
--
DROP TABLE IF EXISTS professionalScores;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE professionalScores (
  professionalScoreID int NOT NULL AUTO_INCREMENT,
  scoreID int NOT NULL COMMENT 'Identificador único del score.',
  clientID int NOT NULL,
  comments text COMMENT 'Comentarios.',
  PRIMARY KEY (professionalScoreID)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table budgetStatus
--
DROP TABLE IF EXISTS budgetStatus;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE budgetStatus (
  budgetStatusID int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del estado del presupuesto.',
  statusName varchar(30) NOT NULL COMMENT 'Nombre del estado.',
  statusDescription text NOT NULL COMMENT 'Descripción del estado.',
  PRIMARY KEY (budgetStatusID)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table projectStatus
--
DROP TABLE IF EXISTS projectStatus;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE projectStatus (
  projectStatusID int NOT NULL AUTO_INCREMENT COMMENT 'Identificador único del estado del proyecto.',
  statusName varchar(30) NOT NULL COMMENT 'Nombre del estado.',
  statusDescription text NOT NULL COMMENT 'Descripción del estado.',
  PRIMARY KEY (projectStatusID)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Estructura de tabla para la tabla projects
--
DROP TABLE IF EXISTS projects;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS projects (
  projectID int NOT NULL AUTO_INCREMENT,
  clientID int NOT NULL,
  professionID int NOT NULL COMMENT 'Requested profession',
  registerDate date COMMENT 'Fecha de solicitud del proyecto.',
  projectStatusID int NOT NULL DEFAULT 1,
  projectDescription text,
  PRIMARY KEY (projectID)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;


--
-- Estructura de tabla para la tabla budgets
--
DROP TABLE IF EXISTS budgets;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS budgets (
  budgetID int NOT NULL AUTO_INCREMENT,
  projectID int NOT NULL,
  professionalID int NOT NULL,
  amount bigint NOT NULL DEFAULT 0,
  requestDate date COMMENT 'Fecha de solicitud del presupuesto.',
  budgetStatusID int NOT NULL DEFAULT 1,
  comments text,
  PRIMARY KEY (budgetID),
  UNIQUE KEY (projectID, professionalID)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;


--
-- Estructura de tabla para la tabla stateProvinces
--
DROP TABLE IF EXISTS stateProvinces;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS stateProvinces (
  stateProvinceID int NOT NULL AUTO_INCREMENT,
  countryID int not null,
  stateProvinceName varchar(255) NOT NULL,
  PRIMARY KEY (stateProvinceID)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;


--
-- Estructura de tabla para la tabla cities
--
DROP TABLE IF EXISTS cities;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS cities (
  cityID int NOT NULL AUTO_INCREMENT,
  stateProvinceID int NOT NULL,
  cityName varchar(255) NOT NULL,
  PRIMARY KEY (cityID)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;


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
-- Table structure for table professionalWorkplaces
--
DROP TABLE IF EXISTS professionalWorkplaces;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE professionalWorkplaces(
	professionalWorkplaceID int NOT NULL AUTO_INCREMENT,
  professionalID int NOT NULL,
	stateProvinceID int NOT NULL,
  cityID int NOT NULL,
  PRIMARY KEY (professionalWorkplaceID),
  UNIQUE KEY (professionalID, cityID)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table professionalProfessions
--
DROP TABLE IF EXISTS professionalProfessions;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE professionalProfessions(
	professionalProfessionsID int NOT NULL AUTO_INCREMENT,
  professionalID int NOT NULL,
	professionID int NOT NULL,
  PRIMARY KEY (professionalProfessionsID),
  UNIQUE KEY (professionalID, professionID)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table professionalProfessions
--
DROP TABLE IF EXISTS countries;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE countries(
countryID int NOT NULL auto_increment,
countryCode varchar(2) NOT NULL default '',
countryName varchar(100) NOT NULL default '',
PRIMARY KEY (countryID)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table sex
--
DROP TABLE IF EXISTS sex;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE sex (
  sexID int NOT NULL AUTO_INCREMENT COMMENT 'Identificador del sexo.',
  sexCode varchar(2) NOT NULL,
  sexName varchar(30) NOT NULL COMMENT 'Nombre del sexo.',
  PRIMARY KEY (sexID) 
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


--
-- CONSTRAINTS
--
-- ALTER TABLE users ADD CONSTRAINT user_DocTypes_fk FOREIGN KEY (docTypeID) REFERENCES docTypes (docTypeID);
-- ALTER TABLE roleGrants ADD CONSTRAINT `roleGRant_role_fk` FOREIGN KEY (roleID) REFERENCES roles(roleID);
-- ALTER TABLE roleGrants ADD CONSTRAINT roleGrant_grant_fk FOREIGN KEY (grantID) REFERENCES grants(grantID);
-- ALTER TABLE userRoles ADD CONSTRAINT userRoles_user_fk FOREIGN KEY (userID) REFERENCES users (userID);
-- ALTER TABLE userRoles ADD  userRoles_roles_fk FOREIGN KEY (roleID) REFERENCES roles (roleID);