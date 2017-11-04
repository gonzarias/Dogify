-- Dado un ID, devuelve la información del usuario.
DROP PROCEDURE IF EXISTS sp_getUserInformation;
DELIMITER $$
CREATE PROCEDURE sp_getUserInformation(
  IN _userID int)

BEGIN

SELECT userID, 
       userName, 
       userStatusID, 
       docTypeID, 
       docNumber, 
       firstName, 
       lastName, 
       birthdate, 
       isAuthenticated, 
       authenticationDate, 
       streetAddress, 
       cityID, 
       stateProvinceID, 
       countryID, 
       zipCode, 
       areaCode, 
       phoneNumber, 
       emailAddress, 
       sexID, 
       lastUpdate, 
       lastLoggin, 
       registerDate, 
       failCount
FROM quieroservicios.users
WHERE userID = _userID;


END $$
DELIMITER;


-- Devuelve el listado de provincias
DROP PROCEDURE IF EXISTS sp_getStateProvinces;
DELIMITER $$
CREATE PROCEDURE sp_getStateProvinces()

BEGIN

SELECT stateProvinceID, countryID, stateProvinceName
FROM stateprovinces;


END $$
DELIMITER;

-- Dado un ID devuelve la descripción de la provincia
DROP PROCEDURE IF EXISTS sp_getStateProvinceByID;
DELIMITER $$
CREATE PROCEDURE sp_getStateProvinceByID(IN _stateProvinceID int)

BEGIN

SELECT stateProvinceID, stateProvinceName
FROM stateprovinces
WHERE stateProvinceID = _stateProvinceID;


END $$
DELIMITER;


-- Devuelve el listado de ciudades
DROP PROCEDURE IF EXISTS sp_getCities;
DELIMITER $$
CREATE PROCEDURE sp_getCities()

BEGIN

SELECT cityID, cityName
FROM cities;


END $$
DELIMITER;

-- Dado un ID devuelve la descripción de la ciudad
DROP PROCEDURE IF EXISTS sp_getCityByID;
DELIMITER $$
CREATE PROCEDURE sp_getCityByID(IN _cityID int)

BEGIN

SELECT cityID, cityName
FROM cities
WHERE cityID = _cityID;


END $$
DELIMITER;



-- Devuelve el listado de ciudades asociadas a una provincia
DROP PROCEDURE IF EXISTS sp_getCitesByStateProvinceID;
DELIMITER $$
CREATE PROCEDURE sp_getCitesByStateProvinceID(IN _stateProvinceID int)

BEGIN

SELECT stateProvinceID, cityID, cityName
FROM cities
WHERE stateProvinceID = _StateProvinceID;


END $$
DELIMITER;


-- Devuelve el listado de roles de usuario
DROP PROCEDURE IF EXISTS sp_getRoles;
DELIMITER $$
CREATE PROCEDURE sp_getRoles()

BEGIN

SELECT roleID, roleName, roleDescription
FROM roles;


END $$
DELIMITER;


-- Devuelve el listado de roles de un usuario
DROP PROCEDURE IF EXISTS sp_getUserRolesByUserID;
DELIMITER $$
CREATE PROCEDURE sp_getUserRolesByUserID(IN _userID int)

BEGIN

IF ((SELECT COUNT(*) FROM userRoles WHERE userID = _userID) >= 1)
THEN
SELECT userID, roleID
FROM userRoles
WHERE userID = _userID;
ELSE
SELECT NULL, 2 FROM DUAL;
END IF;


END $$
DELIMITER;


-- Devuelve el listado de estados del usuario
DROP PROCEDURE IF EXISTS sp_getUserStatus;
DELIMITER $$
CREATE PROCEDURE sp_getUserStatus()

BEGIN

SELECT userStatusID, userStatusName, userStatusDescription
FROM userStatus;


END $$
DELIMITER;

-- Actualiza el estado de un usuario
DROP PROCEDURE IF EXISTS sp_setUserStatusByUserByID;
DELIMITER $$
CREATE PROCEDURE sp_setUserStatusByUserByID(IN _userID int, IN _userStatusID int)

BEGIN

UPDATE users SET userStatusID = _userStatusID
WHERE userID = _userID;

END $$
DELIMITER;


-- Incrementa el failCount de un usuario
DROP PROCEDURE IF EXISTS sp_increaseFailCountByUserID;
DELIMITER $$
CREATE PROCEDURE sp_increaseFailCountByUserID(IN _userID int)

BEGIN


SET @failCount = (SELECT failCount FROM users where userID = _userID);

UPDATE users SET failCount = @failCount+1 
WHERE userID = _userID;


END $$
DELIMITER;



DROP PROCEDURE IF EXISTS sp_setUserPassword;
DELIMITER $$
CREATE PROCEDURE sp_setUserPassword(IN _userID int, IN _newPassword varchar(50))

BEGIN

SET @oldPwdID = (SELECT userPasswordID FROM userPasswords where userID = _userID ORDER BY userPasswordID DESC LIMIT 1);

IF !ISNULL(@oldPwdID) THEN
UPDATE userPassowrds SET userPasswordStatusID = 2;
END IF;

INSERT INTO userpasswords 
(userID, userPassword, userPasswordStatusID, registerDate)
VALUES
(_userID, _newPassword, 1, CURRENT_TIMESTAMP());

END $$
DELIMITER;

-- Asocia un rol a un usuario
DROP PROCEDURE IF EXISTS sp_setUserRole;
DELIMITER $$
CREATE PROCEDURE sp_setUserRole(IN _userID int, IN _roleID int)

BEGIN

INSERT INTO userRoles
(userID, roleID)
VALUES
(_userID, _roleID);

END $$
DELIMITER;


-- Devuelve el listado de profesionales que trabajan en una determinada zona
DROP PROCEDURE IF EXISTS sp_getProfessionalsByWorkplaces;
DELIMITER $$
CREATE PROCEDURE sp_getProfessionalsByWorkplaces(IN _cityID int, IN _professionID int)

BEGIN

SELECT pp.professionalID
FROM professionalWorkplaces pw, ProfessionalProfessions pp
WHERE pp.professionalID = pw.professionalID
AND   pw.cityID = _cityID
AND   pp.professionID = _professionID;


END $$
DELIMITER;


-- Inserta un nuevo profesional
DROP PROCEDURE IF EXISTS sp_setProfessional;
DELIMITER $$
CREATE PROCEDURE sp_setProfessional(IN _userID int)

BEGIN

INSERT INTO professionals 
(userID)
VALUES
(_userID);

END $$
DELIMITER;

-- Inserta un nuevo cliente
DROP PROCEDURE IF EXISTS sp_setClient;
DELIMITER $$
CREATE PROCEDURE sp_setClient(IN _userID int)

BEGIN

INSERT INTO clients 
(userID)
VALUES
(_userID);

END $$
DELIMITER;


-- Genera una nueva asociacion entre un profesional y un lugar de trabajo
DROP PROCEDURE IF EXISTS sp_setProfessionalWorkplace;
DELIMITER $$
CREATE PROCEDURE sp_setProfessionalWorkplace(IN _professionalID int, IN _cityID int)

BEGIN

INSERT INTO professionalWorkplaces
(userID, cityID)
VALUES
(_userID, _cityID);

END $$
DELIMITER;


-- Genera una nueva asociacion entre un profesional y una profesion
DROP PROCEDURE IF EXISTS sp_setProfessionalProfession;
DELIMITER $$
CREATE PROCEDURE sp_setProfessionalProfession(IN _professionalID int, IN _professionID int)

BEGIN

INSERT INTO professionalProfessions
(professionalID, professionID)
VALUES
(_professionalID, _professionID);

END $$
DELIMITER;


-- Dado un userID devuelve el professionalID
DROP PROCEDURE IF EXISTS sp_getProfessionalIDByUserID;
DELIMITER $$
CREATE PROCEDURE sp_getProfessionalIDByUserID(IN _userID int)

BEGIN

SELECT professionalID
FROM professionals
WHERE userID = _userID;


END $$
DELIMITER;

-- Inserto una nueva profesión
DROP PROCEDURE IF EXISTS sp_setProfession;
DELIMITER $$
CREATE PROCEDURE sp_setProfession(IN _professionName varchar(50))
BEGIN

INSERT INTO professions
(professionName)
VALUES
(_professionName);

END $$
DELIMITER;

-- Actualizo una profesión
DROP PROCEDURE IF EXISTS sp_updateProfession;
DELIMITER $$
CREATE PROCEDURE sp_updateProfession(IN _professionID int, IN _professionName varchar(50))
BEGIN

update professions set
professionName = _professionName
where professionID = _professionID;

END $$
DELIMITER;

-- Elimino una profesión
DROP PROCEDURE IF EXISTS sp_deleteProfession;
DELIMITER $$
CREATE PROCEDURE sp_deleteProfession(IN _professionID int)
BEGIN

delete from professions where professionID = _professionID;

END $$
DELIMITER;

-- Obtengo el listado de ciudades asociadas a un Id de provincia
DROP PROCEDURE IF EXISTS sp_getCitiesByStateProvinceID;
DELIMITER $$
CREATE PROCEDURE sp_getCitiesByStateProvinceID(IN _stateProvinceID int)
BEGIN

SELECT stateProvinceID, cityID, cityName
FROM cities
WHERE stateProvinceID = _StateProvinceID;

END $$
DELIMITER;


-- Obtengo una profesión en base a su ID
DROP PROCEDURE IF EXISTS sp_getProfessionByID;
DELIMITER $$
CREATE PROCEDURE sp_getProfessionByID(IN _professionID int)
BEGIN

SELECT professionID, professionName
FROM professions
WHERE professionID = _professionID;

END $$
DELIMITER;


-- Obtengo el listado de profesiones
DROP PROCEDURE IF EXISTS sp_getProfessions;
DELIMITER $$
CREATE PROCEDURE sp_getProfessions()
BEGIN

SELECT professionID, professionName
FROM professions;

END $$
DELIMITER;

DROP PROCEDURE IF EXISTS sp_validateUser;
DELIMITER $$
CREATE PROCEDURE sp_validateUser(IN _userName varchar(30), IN _userPassword varchar(50))
BEGIN

SELECT usr.userID userID, usr.userStatusID userStatus, usr.failCount failCount FROM users usr, userPasswords upw 
 WHERE  usr.userID = upw.userID
 AND    usr.userName = _userName 
 AND    upw.userPassword = _userPassword
 AND    upw.userPasswordStatusID = 1;

END $$
DELIMITER;

