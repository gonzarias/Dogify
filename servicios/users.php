<?php
//Defino la cabecera y el tipo de encoding
header('content-type: application/json; charset=utf-8');

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

//incluyo el framework
require '../vendor/autoload.php';

//incluyo la conexion a db y las funciones
require '../database/database.php';
require '../utiles/funciones.php';


//Variables de debug
$GLOBALS["debugMode"] = true; //Si está en false enmascara el error

//Unicializo el framework
$app = new \Slim\App();

// obtengo todaos los usuarios con el userName
$app->get('/getusers', function (Request $request, Response $response) {

    // Preparar sentencia
    $consulta = "call usr_getUsers();";

    try {
        //Creo una nueva conexión
        $conn = Database::getInstance()->getDb();
        //Preparo la consulta
        $comando = $conn->prepare($consulta);
        // Ejecutar sentencia preparada
        $comando->execute();
        //Obtengo el arreglo de registros
        $values = $comando->fetchAll(PDO::FETCH_ASSOC);

        //Armo la respuesta
        if($values)
        {
            $respuesta["status"] = array("code" => 200, "description" => requestStatus(200)); //OK
            $respuesta["values"] = $values;
        }
        else
        {
            $respuesta["status"] = array("code" => 502, "description" => requestStatus(502)); // No data found
        }

        //Elimino la conexión
        $comando  = null;
        $conn = null;
    }
    catch (PDOException $e)
    {
        if($GLOBALS["debugMode"] == true)
            $respuesta["status"] = array("errmsg" => $e->getMessage());
        else
            $respuesta["status"] = array("code" => 502, "description" => requestStatus(502));
    }
    catch (Exception $e)
    {
        if($GLOBALS["debugMode"] == true)
            $respuesta["status"] = array("errmsg" => $e->getMessage());
        else
            $respuesta["status"] = array("code" => 501, "description" => requestStatus(501));
    }

    //Realizo el envío del mensaje
    echo json_encode($respuesta, JSON_UNESCAPED_UNICODE);

});


// obtengo un ID de usuario a partir del nombre de usuario
$app->get('/getuseridbyname/{userName}', function (Request $request, Response $response) {

    // Preparar sentencia
    $consulta = "call usr_getUserIdByName(:userName);";

    //Obtengo y limpio las variables
    $userName = $request->getAttribute('userName');
    $userName = clean_var($userName);

    try {
        $conn = Database::getInstance()->getDb();
        //Preparo la consulta
        $comando = $conn->prepare($consulta);
        //bindeo el parámetro a la consulta
        $comando->bindValue(':userName', $userName);
        // Ejecutar sentencia preparada
        $comando->execute();
        //Obtengo el arreglo de registros
        $values = $comando->fetchAll(PDO::FETCH_ASSOC);

        //Armo la respuesta
        if($values)
        {
            $respuesta["status"] = array("code" => 200, "description" => requestStatus(200)); //OK
            $respuesta["values"] = $values;
        }
        else
        {
            $respuesta["status"] = array("code" => 502, "description" => requestStatus(502)); // No data found
        }

        //Elimino la conexión
        $comando  = null;
        $conn = null;
    }
    catch (PDOException $e)
    {
        if($GLOBALS["debugMode"] == true)
            $respuesta["status"] = array("errmsg" => $e->getMessage());
        else
            $respuesta["status"] = array("code" => 502, "description" => requestStatus(502));
    }
    catch (Exception $e)
    {
        if($GLOBALS["debugMode"] == true)
            $respuesta["status"] = array("errmsg" => $e->getMessage());
        else
            $respuesta["status"] = array("code" => 501, "description" => requestStatus(501));
    }

    //Realizo el envío del mensaje
    echo json_encode($respuesta, JSON_UNESCAPED_UNICODE);

});

// Inserto Informacion Basica del Usuario
$app->post('/insertuserbasicinformation', function (Request $request, Response $response) {

    // Preparar sentencia
    $consulta = "call usr_insertBasicInformation(:userName,:firstName,:lastName,:phoneNumber,:emailAdress);";

    //Obtengo y limpio las variables
    $userName = $request->getParam('userName');
    $userName = clean_var($userName);
    //$userName = 'Prueba';

    $firstName = $request->getParam('firstName');
    $firstName = clean_var($firstName);

    $lastName = $request->getParam('lastName');
    $lastName = clean_var($lastName);

    $phoneNumber = $request->getParam('phoneNumber');
    $phoneNumber = clean_var($phoneNumber);

    $emailAdress = $request->getParam('emailAdress');
    $emailAdress = clean_var($emailAdress);
    //$emailAdress = 'Prueba@prueba.com';

    try {
        //Creo una nueva conexión
        $conn = Database::getInstance()->getDb();
        //Preparo la consulta
        $comando = $conn->prepare($consulta);
        //bindeo el parámetro a la consulta
        $comando->bindValue(':userName', $userName);
        $comando->bindValue(':firstName', $firstName);
        $comando->bindValue(':lastName', $lastName);
        $comando->bindValue(':phoneNumber', $phoneNumber);
        $comando->bindValue(':emailAdress', $emailAdress);

        // Ejecutar sentencia preparada
        $comando->execute();
        //Obtengo el arreglo de registros

        //Armo la respuesta
        $respuesta["status"] = array("code" => 200, "description" => requestStatus(200)); //OK


        //Elimino la conexión
        $comando  = null;
        $conn = null;
    }
    catch (PDOException $e)
    {
        if($GLOBALS["debugMode"] == true)
            $respuesta["status"] = array("errmsg" => $e->getMessage());
        else
            $respuesta["status"] = array("code" => 502, "description" => requestStatus(502));
    }
    catch (Exception $e)
    {
        if($GLOBALS["debugMode"] == true)
            $respuesta["status"] = array("errmsg" => $e->getMessage());
        else
            $respuesta["status"] = array("code" => 501, "description" => requestStatus(501));
    }

    //Realizo el envío del mensaje
    echo json_encode($respuesta, JSON_UNESCAPED_UNICODE);

});
/*
// Actualizo una profesión
$app->put('/updateprofession', function (Request $request, Response $response) {

    // Preparar sentencia
    $consulta = "call sp_updateProfession(:professionID, :professionName);";

    //Obtengo y limpio las variables
    $professionName = $request->getParam('professionName');
    $professionName = clean_var($professionName);
    $professionID = $request->getParam('professionID');
    $professionID = clean_var($professionID);

    try {
        //Creo una nueva conexión
        $conn = Database::getInstance()->getDb();
        //Preparo la consulta
        $comando = $conn->prepare($consulta);
        //bindeo el parámetro a la consulta
        $comando->bindValue(':professionName', $professionName);
        $comando->bindValue(':professionID', $professionID);
        // Ejecutar sentencia preparada
        $comando->execute();
        //Obtengo el arreglo de registros

        //Armo la respuesta
        $respuesta["status"] = array("code" => 200, "description" => requestStatus(200)); //OK


        //Elimino la conexión
        $comando  = null;
        $conn = null;
    }
    catch (PDOException $e)
    {
        if($GLOBALS["debugMode"] == true)
            $respuesta["status"] = array("errmsg" => $e->getMessage());
        else
            $respuesta["status"] = array("code" => 502, "description" => requestStatus(502));
    }
    catch (Exception $e)
    {
        if($GLOBALS["debugMode"] == true)
            $respuesta["status"] = array("errmsg" => $e->getMessage());
        else
            $respuesta["status"] = array("code" => 501, "description" => requestStatus(501));
    }

    //Realizo el envío del mensaje
    echo json_encode($respuesta, JSON_UNESCAPED_UNICODE);

});

// Elimino una nueva profesión por su ID
$app->delete('/deleteprofession', function (Request $request, Response $response) {

    // Preparar sentencia
    $consulta = "call sp_deleteProfession(:professionID);";

    //Obtengo y limpio las variables
    $professionID = $request->getParam('professionID');
    $professionID = clean_var($professionID);

    try {
        //Creo una nueva conexión
        $conn = Database::getInstance()->getDb();
        //Preparo la consulta
        $comando = $conn->prepare($consulta);
        //bindeo el parámetro a la consulta
        $comando->bindValue(':professionID', $professionID);
        // Ejecutar sentencia preparada
        $comando->execute();
        //Obtengo el arreglo de registros

        //Armo la respuesta
        $respuesta["status"] = array("code" => 200, "description" => requestStatus(200)); //OK


        //Elimino la conexión
        $comando  = null;
        $conn = null;
    }
    catch (PDOException $e)
    {
        if($GLOBALS["debugMode"] == true)
            $respuesta["status"] = array("errmsg" => $e->getMessage());
        else
            $respuesta["status"] = array("code" => 502, "description" => requestStatus(502));
    }
    catch (Exception $e)
    {
        if($GLOBALS["debugMode"] == true)
            $respuesta["status"] = array("errmsg" => $e->getMessage());
        else
            $respuesta["status"] = array("code" => 501, "description" => requestStatus(501));
    }

    //Realizo el envío del mensaje
    echo json_encode($respuesta, JSON_UNESCAPED_UNICODE);

});*/

//Ejecución de la sentencia del FW NO BORRAR
$app->run();
?>