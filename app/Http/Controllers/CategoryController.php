<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Category;

class CategoryController extends Controller
{

    public function __construct(){
        $this->middleware('api.auth', ['except' => ['index', 'show']]);
    }

    public function index(){
        $categories = Category::all();

        $data = [
            'status' => 'SUCCESS',
            'categories' => $categories
        ];

        return response()->json($data);

    }

    public function show($id){
        
        
        $category = Category::where('id', $id)->first();

        if(is_object($category)){
            $data = [
                'status' => 'SUCCESS',
                'category' => $category
            ];
        } else {
            $data = [
                'status' => 'ERROR',
                'message' => 'No se encuentra la categoria.'
            ];
        }

        return response()->json($data);

    }

    public function store(Request $request){

        // Recoger los datos por POST
        $json = $request->input('json', null);
        $params_arr = json_decode($json, true);

        if(!empty($params_arr)) {

            // Validar los datos
            $validator = \Validator::make($params_arr, [
                'name' => 'required|alpha'
            ]);
            // Guardar la categoría
            if($validator->fails()){
                $data = [
                    'status' => 'ERROR',
                    'message' => 'No se ha guardado la categoria'
                ];
            } else {
                $category = new Category();
                $category->name = $params_arr['name'];
                $category->save();

                $data = [
                    'status' => 'SUCCESS',
                    'message' => 'Se ha guardado la categoria ' . $category->name,
                    'category' => $category
                ];
            }

        } else {
            $data = [
                'status' => 'ERROR',
                'message' => 'No se ha enviado ninguna categoria'
            ];
        }
        // Devolver resultados
        return response()->json($data);
    }

    public function update(Request $request, $id){

        // RECOGER LOS DATOS POR POST
        $json = $request->input('json', null);
        $params_arr = json_decode($json, true);

        if(!empty($params_arr)){
        
            // VALIDAR LOS DATOS
            $validator = \Validator::make($params_arr, [
                'name' => 'required'
            ]);

            if($validator->fails()){

                $data = [
                    'status' => 'ERROR',
                    'message' => 'La categoria no se pudo actualizar.'
                ];

            } else {

                //Quitar los campos que no quiero actualizar
                unset($params_arr['id']);
                unset($params_arr['created_at']);
                
                // ACTUALIZAR CATEGORIA
                $category_updated = Category::where('id', $id)->update($params_arr);

                if($category_updated == 0) {
                    $data = [
                        'status' => 'ERROR',
                        'message' => 'La categoria no existe.'
                    ];
                } else {
                    $data = [
                        'status' => 'SUCCESS',
                        'message' => 'Categoria actualizada con exito.',
                        'category_updated' => $category_updated
                    ];
                }               
                
            }
        } else {
            $data = [
                'status' => 'ERROR',
                'message' => 'No se ha enviado nombre de categoria para actualizar.'
            ];
        }

        return response()->json($data);
    }

}
