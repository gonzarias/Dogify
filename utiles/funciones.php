<?php

//Funcion para eliminar caracteres especiales
function quitar($mensaje)
{
	$nopermitidos = array("'",'\\','<','>',"\"");
	$mensaje = str_replace($nopermitidos, "", $mensaje);
	return $mensaje;
};

//fecha y hora del sistema
$hoy = date("Y-m-d H:i:s"); 

//Funcion para codificar a base64
function base64url_encode($plainText) {
	$base64    = base64_encode($plainText);
	$base64url = strtr($base64, '+/=', '-_,');
	return $base64url;
};

//Funcion para decodificar a base64
function base64url_decode($plainText) {
	$base64url = strtr($plainText, '-_,', '+/=');
	$base64    = base64_decode($base64url);
	return $base64;
};

//Obtener direcci�n IP Real remota
function getRealIPAddr()
{
 if (!empty($_SERVER['HTTP_CLIENT_IP']))   //Comprobar IP compartir internet
	 $ip=$_SERVER['HTTP_CLIENT_IP'];
 elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR']))   //para comprobar la ip es pasar de representacion
	 $ip=$_SERVER['HTTP_X_FORWARDED_FOR'];
 else
	 $ip=$_SERVER['REMOTE_ADDR'];
 return $ip;
};

//Validar Email
function validarMail()
{
	$email = $_POST['email'];
	if(preg_match("~([a-zA-Z0-9!#$%&'*+-/=?^_`{|}~])@([a-zA-Z0-9-]).([a-zA-Z0-9]{2,4})~",$email)) {
	 return '1';
	} else{
	 return '2';
	}
};

//Generador de cadena para recuperaci�n de contrase�as
# Genera un string de $tamanio caracteres
# tiene incluido tambien numeros
function generarPassword()
{
	$string = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	$tamanio = 15;
	for($i=0;$i<$tamanio;$i++){
		$pos = rand(0,48);
		$str .= $string{$pos};
	}
	return $str;
};

//filtrar palabras obsenas
function filtrado($texto, $reemplazo = false) {
    $filtradas = 'put?, mierda, pendej[ao]s?, pajero, idiota, conchud?';

    $f = explode(',', $filtradas);
    $f = array_map('trim', $f);
    $filtro = implode('|', $f);

    return ($reemplazo) ? preg_replace("#$filtro#i", $reemplazo, $texto) : preg_match("#$filtro#i", $texto) ;
};

//compara dos passwords
function validar_pwd($pass1,$pass2)
							{
								$valor = 2;
								
								if($pass1 <> '')
									if($pass1 == $pass2)
										$valor = 1;
									
								return $valor;
							};


//Recibe una fecha en formato europeo y la transforma a formato SQL
function fecha_sql($fecha)
{
	$fechasql = '';
	if($fecha <> '')
	{
		$fecha = quitar($fecha); //Elimino caracteres especiales, en caso de que haya
		$dia = substr($fecha, 0, 2); //Obtengo el d�a
		$mes   = substr($fecha, 3, 2); //Obtengo el mes
		$ano = substr($fecha, 6, 4); //Obtengo el a�o
		$fechasql = $ano . '/' . $mes . '/' . $dia; // fechal final realizada el cambio de formato a las fechas SQL
	}
	return $fechasql;
};

// Recibe una fecha en formato SQL y la transforma a formato europeo
function fechaeuropea($fecha)
{
	$fechaeuropea = '';
	if($fecha <> '')
	{
		$fecha = quitar($fecha); //Elimino caracteres especiales, en caso de que haya
		$dia = substr($fecha, 8, 2); //Obtengo el d�a
		$mes   = substr($fecha, 5, 2); //Obtengo el mes
		$ano = substr($fecha, 0, 4); //Obtengo el a�o
		$fechaeuropea = $dia . '/' . $mes . '/' . $ano; // fechal final realizada el cambio de formato a las fechas europeas
	}
	return $fechaeuropea;
};

// Recibo una cadena y la valido, en caso de que la misma est� vacia devuelvo vacio.
function validar_cadena($cadena)
{
	if($cadena <> '')
	$cadena_valida = quitar($cadena);
	else
	$cadena_valida = '';

	return $cadena_valida;
};


// Coloca un guion en caso de que la cadena de caracteres se encuentre vacia
function cargar_guion($v)
{
if ($v =='')
 return '-';
else
	return $v;
};

//Funcion para devolver el m�todo
function getMethod($method)
{    
    switch ($method) {
        case $method = 'GET':
            return $_GET;
            break;
        case $method = 'POST':
            return $_POST;
            break;
        default:
            return $_GET;
    }    
} ;

//Funcion para devolver el m�todo
function getVarByMethod($var, $method)
{    
    switch ($method) {
        case $method = 'GET':
            return stripslashes($_GET[$var]);
            break;
        case $method = 'POST':
            return stripslashes($_POST[$var]);
            break;
        default:
            return stripslashes($_GET[$var]);
    }    
} ;

// Funci�n para devolver los estados
function requestStatus($code) {
        $status = array(  
            200 => 'OK',
            404 => 'Not Found',   
            405 => 'Method Not Allowed',
            500 => 'Internal Server Error',
            501 => 'Unhandled Error',
            502 => 'SQL Error - No data found',
        ); 
        return ($status[$code])?$status[$code]:$status[500]; 
};

// Coloca un null en caso de que la cadena de caracteres se encuentre vacia adem�s limpia caracteres especiales
function clean_var($v)
{
if ($v ==='')
 return null;
else
	return quitar(stripslashes($v));
};

?>