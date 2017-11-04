INSERT INTO users(
   userID
  ,userName
  ,docTypeID
  ,docNumber
  ,firstName
  ,lastName
  ,birthdate
  ,streetAddress
  ,cityID
  ,stateProvinceID
  ,countryID
  ,zipCode
  ,areaCode
  ,phoneNumber
  ,emailAddress
  ,sexID
) VALUES (
   NULL -- userID - IN int(11)
  ,'mpablo2011' -- userName - IN varchar(30)
  ,3 -- docTypeID - IN int(11)
  ,'33111560' -- docNumber - IN varchar(30)
  ,'Pablo'  -- firstName - IN varchar(100)
  ,'Maroli'  -- lastName - IN varchar(100)
  ,STR_TO_DATE('01/07/1987', '%d/%m/%Y')  -- birthdate - IN date
  ,'Fermin Rosell 685'  -- streetAddress - IN varchar(100)
  ,12 -- cityID - IN int(11)
  ,1 -- stateProvinceID - IN int(11)
  ,10   -- countryID - IN int(11)
  ,'2942'  -- zipCode - IN varchar(30)
  ,'3329'  -- areaCode - IN varchar(10)
  ,'684438'  -- phoneNumber - IN varchar(20)
  ,'mpablo2011@gmail.com' -- emailAddress - IN varchar(100)
  ,1 -- sexID - IN int(11)
);

INSERT INTO users(
   userID
  ,userName
  ,docTypeID
  ,docNumber
  ,firstName
  ,lastName
  ,birthdate
  ,streetAddress
  ,cityID
  ,stateProvinceID
  ,countryID
  ,zipCode
  ,areaCode
  ,phoneNumber
  ,emailAddress
  ,sexID
) VALUES (
   NULL -- userID - IN int(11)
  ,'DUMMY' -- userName - IN varchar(30)
  ,3 -- docTypeID - IN int(11)
  ,'12397240' -- docNumber - IN varchar(30)
  ,'DUMMY'  -- firstName - IN varchar(100)
  ,'DUMMY'  -- lastName - IN varchar(100)
  ,STR_TO_DATE('21/07/1990', '%d/%m/%Y')  -- birthdate - IN date
  ,'Calle Falsa 123'  -- streetAddress - IN varchar(100)
  ,12 -- cityID - IN int(11)
  ,1 -- stateProvinceID - IN int(11)
  ,2   -- countryID - IN int(11)
  ,'1111'  -- zipCode - IN varchar(30)
  ,'11'  -- areaCode - IN varchar(10)
  ,'22222222'  -- phoneNumber - IN varchar(20)
  ,'DUMMY@DUMMY.com' -- emailAddress - IN varchar(100)
  ,1 -- sexID - IN int(11)
);

CALL sp_setUserRole(1, 1);
CALL sp_setUserRole(1, 3);
CALL sp_setUserRole(1, 4);
CALL sp_setUserRole(2, 4);

CALL sp_setUserPassword(1, 'biohazard2');

CALL sp_setProfessional (1);

CALL sp_getProfessionalIDByUserID(1);

CALL sp_setProfessionalProfession(1, 1);

