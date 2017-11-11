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


//Inicializo el framework
$app = new \Slim\App();

// obtengo una ciudad por id
$app->get('/getlocationbywalkid/{walkID}', function (Request $request, Response $response) {
    
     	// Preparar sentencia
		$consulta = "call loc_getLocationByWalkID(:walkID);";

        //Obtengo y limpio las variables
        $walkID = $request->getAttribute('walkID');
        $walkID = clean_var($walkID);

        try {
            	//Creo una nueva conexión
                $conn = Database::getInstance()->getDb();
                //Preparo la consulta
                $comando = $conn->prepare($consulta);
                //bindeo el parámetro a la consulta
                $comando->bindValue(':walkID', $walkID);
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


// Inserto una nueva ciudad
$app->post('/insertlocation', function (Request $request, Response $response) {
    
        // Preparar sentencia
        $consulta = "call loc_insertlocation(:dogWalkerID, :walkerID,:walkID,:lat,:lng);";
        
        //Obtengo y limpio las variables
        $dogWalkerID = $request->getParam('dogWalkerID');
        $dogWalkerID = clean_var($dogWalkerID);

        $walkerID = $request->getParam('walkerID');
        $walkerID = clean_var($walkerID);

        $walkID = $request->getParam('walkID');
        $walkID = clean_var($walkID);

        $lat = $request->getParam('lat');
        $lat = clean_var($lat);

        $lng = $request->getParam('lng');
        $lng = clean_var($lng);

        try {                
                //Creo una nueva conexión
                $conn = Database::getInstance()->getDb();
                //Preparo la consulta
                $comando = $conn->prepare($consulta);
                //bindeo el parámetro a la consulta
                $comando->bindValue(':dogWalkerID', $dogWalkerID);
                $comando->bindValue(':walkerID', $walkerID);
                $comando->bindValue(':walkID', $walkID);
                $comando->bindValue(':lat', $lat);
                $comando->bindValue(':lng', $lng);
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

//Ejecución de la sentencia del FW NO BORRAR
$app->run();
?>