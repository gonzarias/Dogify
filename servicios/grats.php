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

// obtengo todas las profesiones
$app->get('/getprofessions', function (Request $request, Response $response) {
    
     	// Preparar sentencia
		$consulta = "call sp_getProfessions();";

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


// obtengo una profesión por id
$app->get('/getprofessionbyid/{id}', function (Request $request, Response $response) {
    
     	// Preparar sentencia
		$consulta = "call sp_getProfessionByID(:id);";

        try {
        		//obtengo el id de la profesión a buscar
        		$id = $request->getAttribute('id');
        		//limpio la cadena de caracteres para prevenir SQL Injection
        		$id = stripslashes($id);
            	//Creo una nueva conexión
                $conn = Database::getInstance()->getDb();
                //Preparo la consulta
                $comando = $conn->prepare($consulta);
                //bindeo el parámetro a la consulta
                $comando->bindValue(':id', $id);
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

// Inserto una nueva profesión
$app->post('/setprofession', function (Request $request, Response $response) {
    
        // Preparar sentencia
        $consulta = "call sp_setProfession(:professionName);";
        
        //Obtengo y limpio las variables
        $professionName = $request->getParam('professionName');
        $professionName = clean_var($professionName);

        try {                
                //Creo una nueva conexión
                $conn = Database::getInstance()->getDb();
                //Preparo la consulta
                $comando = $conn->prepare($consulta);
                //bindeo el parámetro a la consulta
                $comando->bindValue(':professionName', $professionName);
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

// Actualizo una profesión
$app->put('/updateprofession', function (Request $request, Response $response) {
    
        // Preparar sentencia
        $consulta = "call sp_updateProfession(:professionID, :professionName);";

        try {
                //obtengo los parámetros
                $professionName = $request->getParam('professionName');
                $professionID = $request->getParam('professionID');
                //limpio la cadena de caracteres para prevenir SQL Injection
                $professionName = stripslashes($professionName);
                $professionID = stripslashes($professionID);
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

        try {
                //obtengo el ID de la profesión a insertar
                $professionID = $request->getParam('professionID');
                //limpio la cadena de caracteres para prevenir SQL Injection
                $professionID = stripslashes($professionID);
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

});

//Ejecución de la sentencia del FW NO BORRAR
$app->run();
?>