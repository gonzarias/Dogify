<?php 

////////////////////////////////////////////////////////////////////////////////
// SERVICIO: getProfessionalById                                             ///
// Descripción: Dado un id retorna la descripción de una profesión          ///
///////////////////////////////////////////////////////////////////////////////

//incluyo la conexion a db y las funciones
require '../database/database.php';
require '../utiles/funciones.php';

//Defino la cabecera y el tipo de encoding
header('content-type: application/json; charset=utf-8');

//Variables de debug
$debugMode = false; //Si está en false enmascara el error
$method = 'GET'; //Defino el método a usar (para pruebas se recomienda GET) 
$serviceType = 'PUBLIC'; // Si el servicio es público no valido el token ni el userID.

//Verifico el método y las variables
if($_SERVER['REQUEST_METHOD'] == $method)
{
    if(!empty(getMethod($method)))
    {    
        // obtengo el id enviado por parámetro
        $id = getVarByMethod('id', $method);

        try {
             	// Preparar sentencia
            	$consulta = "call sp_getProfessionByID(:id);";
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
                    $response["status"] = array("code" => 200, "description" => requestStatus(200)); //OK
                    $response["values"] = $values;
                }
                else
                {
                    $response["status"] = array("code" => 502, "description" => requestStatus(502)); // No data found
                }

                //Elimino la conexión
                $comando  = null;
                $conn = null;
        }  
        catch (PDOException $e) 
        {
            if($debugMode == true)
                $response["status"] = array("errmsg" => $e->getMessage());
            else
                $response["status"] = array("code" => 502, "description" => requestStatus(502));       
        } 
        catch (Exception $e) 
        {
        if($debugMode == true)
                $response["status"] = array("errmsg" => $e->getMessage());
            else
                $response["status"] = array("code" => 501, "description" => requestStatus(501));       
        }      

        //Realizo el envío del mensaje
    	echo json_encode($response, JSON_UNESCAPED_UNICODE);
    }
    else
    {
        //Armo la respuesta de error
        $response["status"] = array("code" => 500, "description" => requestStatus(500));

        echo json_encode($response);        
    }
}
else
{
	//Armo la respuesta de error
    $response["status"] = array("code" => 405, "description" => requestStatus(405)); //Method not alowed

	echo json_encode($response);
}

?>