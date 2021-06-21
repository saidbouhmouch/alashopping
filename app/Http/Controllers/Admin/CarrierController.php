<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use App\Models\Carrier;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class CarrierController extends Controller
{
    /**
     * Display a listing of the carriers.
     *
     * @return \Illuminate\Http\Response $carriers
     */
    public function index()
    {
        $carriers = Carrier::with('image')->get();
        return (new Response(json_encode(["success"=>true,"carriers"=>$carriers]), 200));
    }

    
    /**
     * Store a newly created.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */

    public function store(Request $request)
    {
        $data =json_decode($request->data);

        $slug=Str::slug($data->name, '-');
        if (Carrier::where('slug', $slug)->exists()) {
            return (new Response(json_encode(["success"=>false,"error"=>true,"message"=>"Cette Name '".$slug."' existe déjà"]), 200));
        }
        
        DB::beginTransaction();

        /**
         *  Carrier
         *
        */

        $carrier                    = new Carrier();
        $carrier->name              = $data->name;      
        $carrier->slug              = $slug; 
        $carrier->price             = $data->price;      
        $carrier->delivery_text     = $data->deliveryText;      
        $pictureName                = ($data->picture->name == '')?'CARRIER': $data->picture->name ;
        $carrier->image_id          = \PictureService::save($data->picture->url,$pictureName,'image','carriers',[]);
        $carrier->save();
        DB::commit();
        return (new Response(json_encode(["success"=>true,"error"=>false,"message"=>"Enregistrement a été effectué avec succès"]), 200));
    }

       
    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $carrier         = Carrier::findOrFail($id);
        $picture         = $carrier->image;
        $carrier         = $carrier->makeHidden(['image']);
       return (new Response(json_encode(["success"=>true,"carrier"=>$carrier,'picture'=>$picture]), 200));
    }

    /**
     * Update a newly created.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int   id  
     * @return \Illuminate\Http\Response
     */

    public function update(Request $request,$id)
    {
        $data =json_decode($request->data);

        $slug=Str::slug($data->name, '-');
        if (Carrier::where('slug', $slug)->where('id','!=', $id)->exists()) {
            return (new Response(json_encode(["success"=>false,"error"=>true,"message"=>"Cette Name '".$slug."' existe déjà"]), 200));
        }
        
        DB::beginTransaction();

        /**
         *  Carrier
         *
        */

        $carrier                    = Carrier::findOrFail($id);
        $carrier->name              = $data->name;      
        $carrier->slug              = $slug; 
        $carrier->price             = $data->price;      
        $carrier->delivery_text     = $data->deliveryText;      
        if ($data->picture->update) {
            $pictureName                = ($data->picture->name == '')?'CARRIER': $data->picture->name ;
            $carrier->image_id          = \PictureService::save($data->picture->url,$pictureName,'image','carriers',[]);
        }

        $carrier->update();
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
        $carrier     = Carrier::findOrFail($id);
        $image_id =  $carrier->image_id;
        $carrier->delete();
        \PictureService::delete($image_id);
        DB::commit();
        return (new Response(json_encode(["success"=>true,"error"=>false,"message"=>"Suppression a été effectué avec succès"]), 200));

    }



}


