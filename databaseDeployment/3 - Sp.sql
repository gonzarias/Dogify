-- Dado un ID, devuelve la información del usuario.
DELIMITER $$
DROP PROCEDURE IF EXISTS loc_getLocationByID $$
CREATE PROCEDURE loc_getLocationByID(
  IN _locationID int)

BEGIN

SELECT *
FROM dogify.dogWalkerLocation
WHERE locationID = _locationID;


END $$
DELIMITER;

-- Asocia un rol a un usuario
DELIMITER $$
DROP PROCEDURE IF EXISTS loc_insertlocation $$
CREATE PROCEDURE loc_insertlocation(IN _dogWalkerID int, IN _walkerID int,IN _walkID int,IN _lat float, IN _lng float)

BEGIN

INSERT INTO dogWalkerLocation
(
dogWalkerID,
walkerID,
walkID,
lat,
lng,
registerDate
)

VALUES
(
_dogWalkerID,
_walkerID,
_walkID,
_lat,
_lng,
now()
);

END $$





