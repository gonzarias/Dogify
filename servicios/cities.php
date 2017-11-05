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

// obtengo todas las ciudades
$app->get('/getcities', function (Request $request, Response $response) {
    
     	// Preparar sentencia
		$consulta = "call sp_getCities();";

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


// obtengo una ciudad por id
$app->get('/getcitybyid/{cityID}', function (Request $request, Response $response) {
    
     	// Preparar sentencia
		$consulta = "call sp_getCityByID(:cityID);";

        //Obtengo y limpio las variables
        $cityID = $request->getAttribute('cityID');
        $cityID = clean_var($cityID);

        try {
            	//Creo una nueva conexión
                $conn = Database::getInstance()->getDb();
                //Preparo la consulta
                $comando = $conn->prepare($consulta);
                //bindeo el parámetro a la consulta
                $comando->bindValue(':cityID', $cityID);
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

// obtengo las ciudades asociadas a un estado.
$app->get('/getcitiesbystateproviceid/{stateProvinceID}', function (Request $request, Response $response) {
    
     	// Preparar sentencia
		$consulta = "call sp_getCitiesByStateProvinceID(:stateProvinceID);";

        //Obtengo y limpio las variables
        $stateProvinceID = $request->getAttribute('stateProvinceID');
        $stateProvinceID = clean_var($stateProvinceID);

        try {
            	//Creo una nueva conexión
                $conn = Database::getInstance()->getDb();
                //Preparo la consulta
                $comando = $conn->prepare($consulta);
                //bindeo el parámetro a la consulta
                $comando->bindValue(':stateProvinceID', $stateProvinceID);
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

//Ejecución de la sentencia del FW NO BORRAR
$app->run();
?>