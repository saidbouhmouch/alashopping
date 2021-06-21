<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Str;

class UploadFileController extends Controller
{
    public function store(Request $request){
                $data =json_decode($request->data);
                $name    =  $data->name;
                $filename = \PictureService::store('temporary',$data->url,$name);
                return response()->json(["success"=>true,
                                        "error"   =>false,
                                        "message" =>"Enregistrement a été effectué avec succès",
                                        "url"     => $filename,
                                        "name"    => $name
                                        ]); 
      
    }
}


