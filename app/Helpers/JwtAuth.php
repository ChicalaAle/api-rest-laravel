<?php 

namespace App\Helpers;

use Firebase\JWT\JWT;
use Illuminate\Support\Facades\BD;
use App\User;

class JwtAuth {

    public $key;

    public function __construct(){
        $this->key = 'ESTO_ES_UNA_CLAVE_SUPER_SECRETA-29384194812';
    }

    public function signup($email, $password, $getToken = null){
        // Buscar si existe el usuario con sus credenciales
        $user = User::where([
            'email' => $email,
            'password' => $password
        ])->first();

        // Comprobar si son correctas (Objeto)

        $signup = false;

        if(is_object($user)) {
            $signup = true;
        }

        // Generar el token con los datos
        
        if($signup) {
            $token = ['sub' => $user->id, 'email' => $user->email, 'name' => $user->name, 'surname' => $user->surname, 'description' => $user->description, 'image' => $user->image , 'iat' => time(), 'exp' => time() + (7 * 24 * 60 * 60) ];
            $jwt = JWT::encode($token, $this->key, 'HS256');

            

            // Devolver los datos decodificados o el token en función de un parámetro
            if(is_null($getToken)){

                $data = $jwt;

            } else {

                $decoded = JWT::decode($jwt, $this->key, ['HS256']);
                $data = $decoded;

            }

        } else {
            $data = [
                'status' => 'ERROR',
                'message' => 'El email y/o la contraseña no son válidos'
            ];
        }

        

        return $data;
    }


    public function checkToken($jwt, $getIdentity = false){
        
        $auth = false;

        try{
            $jwt = str_replace('"', '', $jwt);
            $decoded = JWT::decode($jwt, $this->key, ['HS256']); 
        } catch(\UnexpectedValueException $e){$auth=false;}
          catch(\DomainException $e){$auth=false;}

        if(!empty($decoded) && is_object($decoded) && isset($decoded->sub)){
            $auth = true;
        }

        if($getIdentity){
            return $decoded;
        }

        return $auth;

    }

    
}