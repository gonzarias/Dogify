use dogify;
-- Dado un ID, devuelve la información del usuario.
DELIMITER $$
DROP PROCEDURE IF EXISTS loc_getLocationByWalkID $$
CREATE PROCEDURE loc_getLocationByWalkID(
  IN _walkID int)

BEGIN

SELECT *
FROM dogify.dogWalkerLocation
WHERE walkID = _walkID;


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





