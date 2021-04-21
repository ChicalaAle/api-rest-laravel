<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\User;

class UserController extends Controller
{
    public function pruebas(){
        return 'Index de usercontroller funcionando.';
    }

    public function register(Request $request){

        //Recoger los datos de usuario ($request)
        $json = $request->input('json', null);
        $params = json_decode($json);
        $params_arr = json_decode($json, true);
        

        if(!empty($params) && !empty($params_arr)) {

                //Limpiar datos
                $params_arr = array_map('trim', $params_arr);

                //Validar los datos entrantes
                $validator = \Validator::make($params_arr, 
                    [
                        'name'      => 'required|alpha',
                        'surname'   => 'required|alpha',
                        'email'     => 'required|email|unique:users',
                        'password'  => 'required'
                    ]
                );

                if($validator->fails()){

                    //La validación falló
                    
                    $data = [
                        'status' => 'ERROR',
                        'message' => 'No se ha podido crear el usuario',
                        'errors'  => $validator->errors()
                    ];

                    
                } else {

                    //Cifrar la contraseña

                    $pwd = hash('sha256', $params->password);

                    //Crear el usuario

                    $user = new User();
                    $user->name         = $params_arr['name'];
                    $user->surname      = $params_arr['surname'];
                    $user->email        = $params_arr['email'];
                    $user->password     = $pwd;
                    $user->role         = 'ROLE_USER';

                    //Guardar usuario
                    $user->save();


                    $data = [
                        'status' => 'SUCCESS',
                        'message' => 'El usuario se ha creado correctamente',
                        'user'    => $user
                    ];

                }
            
        } else {
            $data = [
                'status' => 'ERROR',
                'message' => 'Los datos introducidos no son correctos'
            ];
        }

        //Devolver mensaje
        return response()->json($data);
    }

    public function login(Request $request){

        $jwt = new \JwtAuth();

        //Recibir datos por POST
        $json = $request->input('json');
        $params = json_decode($json);
        $params_arr = json_decode($json, true);

        //VAlidar los datos

        $validator = \Validator::make($params_arr, [
            'email'     => 'required|email',
            'password'  => 'required'
        ]);
        

        if($validator->fails()) {
            $signup = [
                'status' => 'ERROR',
                'message' => 'No se ha podido loguear al usuario',
                'errors' => $validator->errors()
            ];
        } else {
            //Cifrar la contraseña
            $pwd = hash('sha256', $params->password);

            //Devolver token o datos
            $signup = $jwt->signup($params->email, $pwd);

            if(!empty($params->gettoken)){
                $signup = $jwt->signup($params->email, $pwd, true);
            }

        }        
        

        return response()->json($signup);
    }

    public function update(Request $request){
        $token = $request->header('Authorization');
        $jwtAuth = new \JwtAuth();
        $checkToken = $jwtAuth->checkToken($token);


        $json = $request->input('json', null);
        $params_arr = json_decode($json, true);

        if($checkToken && !empty($params_arr)){


            // RECOGER DATOS POR POTS

            

            //Sacar usuario identificado
            $user = $jwtAuth->checkToken($token, true);

            // VALIDAR LOS DATOS 

            $validator = \Validator::make($params_arr, 
                    [
                        'name'      => 'required|alpha',
                        'surname'   => 'required|alpha',
                        'email'     => 'required|email|unique:users, ' . $user->sub
                    ]
            );

            // QUITAR LOS CAMPOS QUE NO QUIERO ACTUALIZAR

            unset($params_arr['id']);
            unset($params_arr['role']);
            unset($params_arr['password']);
            unset($params_arr['created_at']);
            unset($params_arr['remember_token']);

            // ACTUALIZAR USUARIO EN BBDD

            $user_update = User::where('id', $user->sub)->update($params_arr);

            // DEVOLVER ARRAY CON RESULTADO

            $data = array(
                'status' => 'SUCCESS',
                'user' => $user_update,
                'sub' => $user->sub,
                'changes' => $params_arr
            );
        } else {
            $data = array(
                'status' => 'ERROR',
                'message' => 'El usuario no está identificado'
            );
        }


        return response()->json($data);
    }


    public function upload(Request $request){

        // RECOGER LOS DATOS DE LA PETICION
        $image = $request->file('file0');

        // VAlidar la imagen

        $validator = \Validator::make($request->all(), [
            'file0' => 'required|mimes:jpg,jpeg,png,gif'
        ]);

        // GUARDAR LA IMAGEN
        if(!$image || $validator->fails()){

            $data = array(
                'status' => 'ERROR',
                'message' => 'Error al subir la imagen'
            );

        } else {
            
            $image_name = time() . $image->getClientOriginalName();
            \Storage::disk('users')->put($image_name, \File::get($image));

            $data = [
                'status' => 'SUCCESS',
                'image' => $image_name
            ];

        }


        

        return response()->json($data);
        
    }


    public function getImage($filename){

        $image_exists = \Storage::disk('users')->exists($filename);

        if($image_exists){
            $image = \Storage::disk('users')->get($filename);

            return new Response($image, 200);
        } else {

            $data = [
                'status' => 'ERROR',
                'message' => 'No existe la imagen'
            ];


            return response()->json($data);
        }
       

    }

    public function detail($id){

        $user = User::find($id);

        if(is_object($user)){
            $data = [
                'status' => 'SUCCESS',
                'user' => $user
            ];
        }else {
            $data = [
                'status' => 'ERROR',
                'message' => 'El usuario no existe'
            ];
        }


        return response()->json($data);

    }

}
