<?php

namespace App\Http\Controllers\Admin;
use App\Http\Controllers\Controller;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use App\Models\Tag;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\DB;

class TagController extends Controller
{
    public function index()
    {
        $tags = Tag::all();
        return (new Response(json_encode(["success"=>true,"tags"=>$tags]), 200));
    }

    
    public function store(Request $request)
    {
        $data =json_decode($request->data);
        $slug=Str::slug($data->name, '-');
        if (Tag::where('slug', $slug)->exists()) {
            return (new Response(json_encode(["success"=>false,"error"=>true,"message"=>"Cette Tag '".$data->name."' existe déjà"]), 200));
        }
        DB::beginTransaction();

        /**
         *  Tag
         *
        */

        $tag               = new Tag();
        $tag->name         = $data->name;      
        $tag->slug         = $slug;     
        $tag->save();

        DB::commit();
        return (new Response(json_encode(["success"=>true,"error"=>false,"message"=>"Enregistrement a été effectué avec succès"]), 200));
    }


   
    public function show($id)
    {
        
    }

    
    public function edit($id)
    {
        $tag       = Tag::findOrFail($id);
        //$tag     = $user->makeHidden(['']);
       return (new Response(json_encode(["success"=>true,"tag"=>$tag]), 200));
    }

    public function update(Request $request, $id)
    {
        $data =json_decode($request->data);
        $slug=Str::slug($data->name, '-');
        if (Tag::where('slug', $slug)->where('id','!=', $id)->exists()) {
            return (new Response(json_encode(["success"=>false,"error"=>true,"message"=>"Cette tag '".$slug."' existe déjà"]), 200));
        }
        DB::beginTransaction();

        /**
         *  Tag
         *
        */

        $tag               = Tag::findOrFail($id);
        $tag->name         = $data->name;      
        $tag->slug         = $slug;     
        $tag->update();
        DB::commit();
        return (new Response(json_encode(["success"=>true,"error"=>false,"message"=>"Enregistrement a été effectué avec succès"]), 200));
    }


    public function destroy($id)
    {
        DB::beginTransaction();
        $tag  = Tag::findOrFail($id);
        $tag->delete();
        DB::commit();
        return (new Response(json_encode(["success"=>true,"error"=>false,"message"=>"Suppression a été effectué avec succès"]), 200));

    }


}
