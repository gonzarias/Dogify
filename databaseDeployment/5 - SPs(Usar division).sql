-- Dado un ID, devuelve la información del usuario.

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_getUserInformation $$

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
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_getStateProvinces $$
CREATE PROCEDURE sp_getStateProvinces()

BEGIN

SELECT stateProvinceID, countryID, stateProvinceName
FROM stateprovinces;


END $$
DELIMITER;

-- Dado un ID devuelve la descripción de la provincia

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_getStateProvinceByID $$
CREATE PROCEDURE sp_getStateProvinceByID(IN _stateProvinceID int)

BEGIN

SELECT stateProvinceID, stateProvinceName
FROM stateprovinces
WHERE stateProvinceID = _stateProvinceID;


END $$
DELIMITER;


-- Devuelve el listado de ciudades

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_getCities $$
CREATE PROCEDURE sp_getCities()

BEGIN

SELECT cityID, cityName
FROM cities;


END $$
DELIMITER;

-- Dado un ID devuelve la descripción de la ciudad

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_getCityByID $$
CREATE PROCEDURE sp_getCityByID(IN _cityID int)

BEGIN

SELECT cityID, cityName
FROM cities
WHERE cityID = _cityID;


END $$
DELIMITER;



-- Devuelve el listado de ciudades asociadas a una provincia

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_getCitesByStateProvinceID $$
CREATE PROCEDURE sp_getCitesByStateProvinceID(IN _stateProvinceID int)

BEGIN

SELECT stateProvinceID, cityID, cityName
FROM cities
WHERE stateProvinceID = _StateProvinceID;


END $$
DELIMITER;


-- Devuelve el listado de roles de usuario

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_getRoles $$
CREATE PROCEDURE sp_getRoles()

BEGIN

SELECT roleID, roleName, roleDescription
FROM roles;


END $$
DELIMITER;


-- Devuelve el listado de roles de un usuario

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_getUserRolesByUserID $$
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

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_getUserStatus $$
CREATE PROCEDURE sp_getUserStatus()

BEGIN

SELECT userStatusID, userStatusName, userStatusDescription
FROM userStatus;


END $$
DELIMITER;

-- Actualiza el estado de un usuario

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_updateUserStatusByUserByID $$
CREATE PROCEDURE sp_updateUserStatusByUserByID(IN _userID int, IN _userStatusID int)

BEGIN

UPDATE users SET userStatusID = _userStatusID
WHERE userID = _userID;

END $$
DELIMITER;


-- Incrementa el failCount de un usuario

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_increaseFailCountByUserID$$
CREATE PROCEDURE sp_increaseFailCountByUserID(IN _userID int)

BEGIN


SET @failCount = (SELECT failCount FROM users where userID = _userID);

UPDATE users SET failCount = @failCount+1 
WHERE userID = _userID;


END $$
DELIMITER;




DELIMITER $$
DROP PROCEDURE IF EXISTS sp_updateUserPassword $$
CREATE PROCEDURE sp_updateUserPassword(IN _userID int, IN _newPassword varchar(50))

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

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_insertUserRole $$
CREATE PROCEDURE sp_insertUserRole(IN _userID int, IN _roleID int)

BEGIN

INSERT INTO userRoles
(userID, roleID)
VALUES
(_userID, _roleID);

END $$
DELIMITER;


-- Devuelve el listado de profesionales que trabajan en una determinada zona

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_getProfessionalsByWorkplaces $$
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

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_insertProfessional $$
CREATE PROCEDURE sp_insertProfessional(IN _userID int)

BEGIN

INSERT INTO professionals 
(userID)
VALUES
(_userID);

END $$
DELIMITER;

-- Inserta un nuevo cliente

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_insertClient $$
CREATE PROCEDURE sp_insertClient(IN _userID int)

BEGIN

INSERT INTO clients 
(userID)
VALUES
(_userID);

END $$
DELIMITER;


-- Genera una nueva asociacion entre un profesional y un lugar de trabajo

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_insertProfessionalWorkplace $$
CREATE PROCEDURE sp_insertProfessionalWorkplace(IN _professionalID int, IN _cityID int)

BEGIN

INSERT INTO professionalWorkplaces
(userID, cityID)
VALUES
(_userID, _cityID);

END $$
DELIMITER;


-- Genera una nueva asociacion entre un profesional y una profesion

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_insertProfessionalProfession $$
CREATE PROCEDURE sp_insertProfessionalProfession(IN _professionalID int, IN _professionID int)

BEGIN

INSERT INTO professionalProfessions
(professionalID, professionID)
VALUES
(_professionalID, _professionID);

END $$
DELIMITER;


-- Dado un userID devuelve el professionalID

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_getProfessionalIDByUserID $$
CREATE PROCEDURE sp_getProfessionalIDByUserID(IN _userID int)

BEGIN

SELECT professionalID
FROM professionals
WHERE userID = _userID;


END $$
DELIMITER;

-- Inserto una nueva profesión

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_insertProfession $$
CREATE PROCEDURE sp_insertProfession(IN _professionName varchar(50))
BEGIN

INSERT INTO professions
(professionName)
VALUES
(_professionName);

END $$
DELIMITER;

-- Actualizo una profesión

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_updateProfession $$
CREATE PROCEDURE sp_updateProfession(IN _professionID int, IN _professionName varchar(50))
BEGIN

update professions set
professionName = _professionName
where professionID = _professionID;

END $$
DELIMITER;

-- Elimino una profesión

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_deleteProfession $$
CREATE PROCEDURE sp_deleteProfession(IN _professionID int)
BEGIN

delete from professions where professionID = _professionID;

END $$
DELIMITER;

-- Obtengo el listado de ciudades asociadas a un Id de provincia

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_getCitiesByStateProvinceID $$
CREATE PROCEDURE sp_getCitiesByStateProvinceID(IN _stateProvinceID int)
BEGIN

SELECT stateProvinceID, cityID, cityName
FROM cities
WHERE stateProvinceID = _StateProvinceID;

END $$
DELIMITER;


-- Obtengo una profesión en base a su ID

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_getProfessionByID $$
CREATE PROCEDURE sp_getProfessionByID(IN _professionID int)
BEGIN

SELECT professionID, professionName
FROM professions
WHERE professionID = _professionID;

END $$
DELIMITER;


-- Obtengo el listado de profesiones

DELIMITER $$
DROP PROCEDURE IF EXISTS sp_getProfessions $$
CREATE PROCEDURE sp_getProfessions()
BEGIN

SELECT professionID, professionName
FROM professions;

END $$
DELIMITER;


DELIMITER $$
DROP PROCEDURE IF EXISTS sp_validateUser $$
CREATE PROCEDURE sp_validateUser(IN _userName varchar(30), IN _userPassword varchar(50))
BEGIN

SELECT usr.userID userID, usr.userStatusID userStatus, usr.failCount failCount FROM users usr, userPasswords upw 
 WHERE  usr.userID = upw.userID
 AND    usr.userName = _userName 
 AND    upw.userPassword = _userPassword
 AND    upw.userPasswordStatusID = 1;

END $$


