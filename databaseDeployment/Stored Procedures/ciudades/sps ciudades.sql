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
