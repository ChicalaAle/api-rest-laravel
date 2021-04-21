<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Post;


class PostController extends Controller
{
    public function __construct(){
        $this->middleware('api.auth', ['except' => [
            'index',
            'show',
            'getImage',
            'getPostsByCategory',
            'getPostsByUser'
            ]]);
    }

    public function index(){
        $posts = Post::orderBy('id', 'desc')->get()
                                    ->load('category')
                                    ->load('user');

        return response()->json([
            'status' => 'SUCCESS',
            'posts' => $posts
        ]);

    }


    public function show($id){
        
        $post = Post::find($id);
        $postDetailed = Post::find($id)->load('category')->load('user');

        if(is_object($post)){
            //$post->load('category');

            $data = [
                'status' => 'SUCCESS',
                'post' => $post,
                'postDetail' => $postDetailed
            ];
        } else {
            $data = [
                'status' => 'ERROR',
                'message' => 'La entrada no existe'
            ];
        }

        return response()->json($data);
    }

    public function store(Request $request){

        //CONSEGUIR DATOS POR POST
        $json = $request->input('json');
        $params = json_decode($json);
        $params_arr = json_decode($json, true);
        
        

        //VALIDAR LOS DATOS

        if(!empty($params_arr)){

            //Encontrar usuario identificado
            $user = $this->getIdentity($request);

            if(empty($params->image)){
                $params->image = NULL;
            }

            $validator = \Validator::make($params_arr, [
                'title' => 'required',
                'content' => 'required',
                'category_id' => 'required'
            ]);

            if($validator->fails()){

                $data = [
                    'status' => 'ERROR',
                    'message' => 'Error en la validacion de los campos'
                ];

            } else {
                // GUARDAR EL POST

                $post = new Post();
                $post->user_id      = $user->sub;
                $post->category_id  = $params->category_id;
                $post->title        = $params->title;
                $post->content      = $params->content;
                $post->image        = $params->image;
                
                $post->save();

                $data = [
                    'status' => 'SUCCESS',
                    'post' => $post,
                    'xd_valid' => $json
                ];

            }
        } else {
            $data = [
                'status' => 'ERROR',
                'message' => 'Datos invalidos.',
                'xd' => $json
            ];
        }
        
        // DEVOLVER MENSAJE

        return response()->json($data);
    }

    public function update(Request $request, $post_id){

        //CONSEGUIR LOS DATOS POR POST
        $json = $request->input('json', null);
        $params_arr = json_decode($json, true);      
        
        $data = [
            'status' => 'ERROR',
            'message' => 'Datos invalidos.'
        ];

        if(!empty($params_arr)){

            //Encontrar usuario identificado
            $user = $this->getIdentity($request);

            //VALIDAR LA INFORMACIÓN
            $validator = \Validator::make($params_arr, [
                'title' => 'required',
                'content' => 'required',
                'category_id' => 'required'
            ]);

            if($validator->fails()){
                $data['errors'] = $validator->errors();                
            } else {

                //ACTUALIZAR EL POST

                //QUITAR CAMPOS QUE NO QUIERO ACTUALIZAR
                unset($params_arr['user_id']);
                //unset($params_arr['id']);
                unset($params_arr['created_at']);
                unset($params_arr['user']);
                
                $post = Post::where('id', $post_id)
                            ->where('user_id', $user->sub);
                $post_exists = $post->first();

                //VERIFICAR QUE EL ID DEL POST EXISTE
                if(is_object($post_exists)){
                    $post->update($params_arr);

                    $data = [
                        'status' => 'SUCCESS',
                        'post_updated' => $params_arr
                    ];
                } else {
                    $data['message'] = 'No existe el post.';
                }

            }

        }

        //DEVOLVER MENSAJE

        return response()->json($data);

    }

    public function destroy($id, Request $request) {

        //Encontrar usuario identificado
        $user = $this->getIdentity($request);

        $data = [
            'status' => 'ERROR'
        ];

        //ENCONTRAR POST POR ID
        $post = Post::where('id', $id)
                    ->where('user_id', $user->sub)
                    ->first();

        if(is_null($post)){
            $data['message'] = 'No existe el post indicado.';
        } else {
            //ELIMINAR POST
            $post->delete();
            $data = [
                'status' => 'SUCCESS',
                'message' => 'Post eliminado exitosamente.'
            ];           
        }

        //DEVOLVER MENSAJE
        return response()->json($data);       

    }


    public function upload(Request $request)
    {
        //RECOGER LA IMAGEN DE LA PETICIÓN
        $image = $request->file('file0');
        //VALIDAR LA IMAGEN
        $validator = \Validator::make($request->all(), [
            'file0' => 'required|mimes:jpg,jpeg,png,gif'
        ]);
        //GUARDAR LA IMAGEN EN UN DISCO (images)
        if(!$image || $validator->fails()){
            $data = [
                'status' => 'ERROR',
                'message' => 'Error al subir la imagen'
            ];
        } else {
            $imageName = time() . $image->getClientOriginalName();
            \Storage::disk('images')->put($imageName, \File::get($image));

            $data = [
                'status' => 'SUCCESS',
                'image' => $imageName
            ];
            
        }
        //DEVOLVER DATOS
        return response()->json($data);
    }

    public function getImage($fileName)
    {
        //COMPROBAR SI EXISTE EL FICHERO
        $isset = \Storage::disk('images')->exists($fileName);
        
        if($isset){
            //CONSEGUIR LA IMAGEN
            $file = \Storage::disk('images')->get($fileName);
            //DEVOLVER LA IMAGEN

            return new Response($file);
        } else {
            //MOSTRAR ERROR
            $data = [
                'status' => 'SUCCESS',
                'message' => 'No existe la imagen'
            ];
            return response()->json($data);
        }
        
        
    }

    public function getPostsByCategory($category_id)
    {
        $posts = Post::where('category_id', $category_id)->get();

        $data = [
            'status' => 'SUCCESS',
            'posts' => $posts
        ];

        return response()->json($data);

    }

    public function getPostsByUser($user_id)
    {
        $posts = Post::where('user_id', $user_id)->get();

        $data = [
            'status' => 'SUCCESS',
            'posts' => $posts
        ];

        return response()->json($data);
    }

    // FUNCIONES AUXILIARES

    private function getIdentity($request){
        $jwt = new \JwtAuth();
        $user = $jwt->checkToken($request->header('Authorization'), true);
        return $user;
    }

}


