<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use App\Models\Category;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\DB;


class CategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $categories = Category::all();
        return (new Response(json_encode(["success"=>true,"categories"=>$categories]), 200));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $data =json_decode($request->data);
        $slug=Str::slug($data->name, '-');
        if (Category::where('slug', $slug)->exists()) {
            return (new Response(json_encode(["success"=>false,"error"=>true,"message"=>"Cette slug '".$slug."' existe déjà"]), 200));
        }
        DB::beginTransaction();

        /**
         *  category
         *
        */

        $category               = new Category();
        $category->name         = $data->name;      
        $category->slug         = $slug;     
        $category->description  = $data->description; 
        $category->save();

        DB::commit();
        return (new Response(json_encode(["success"=>true,"error"=>false,"message"=>"Enregistrement a été effectué avec succès"]), 200));
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $category       = Category::findOrFail($id);
        //$category     = $user->makeHidden(['']);
       return (new Response(json_encode(["success"=>true,"category"=>$category]), 200));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $data =json_decode($request->data);
        $slug=Str::slug($data->name, '-');
        if (Category::where('slug', $slug)->where('id','!=', $id)->exists()) {
            return (new Response(json_encode(["success"=>false,"error"=>true,"message"=>"Cette slug '".$slug."' existe déjà"]), 200));
        }
        DB::beginTransaction();

        /**
         *  category
         *
        */

        $category               = Category::findOrFail($id);
        $category->name         = $data->name;      
        $category->slug         = $slug;     
        $category->description  = $data->description; 
        $category->update();

        DB::commit();
        return (new Response(json_encode(["success"=>true,"error"=>false,"message"=>"Enregistrement a été effectué avec succès"]), 200));
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        DB::beginTransaction();
        $category  = Category::findOrFail($id);
        $category->delete();
        DB::commit();
        return (new Response(json_encode(["success"=>true,"error"=>false,"message"=>"Suppression a été effectué avec succès"]), 200));

    }
}
