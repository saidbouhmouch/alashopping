<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use App\Models\TypePayment;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class TypePaymentController extends Controller
{

    /**
     * Display a listing of the type payment.
     *
     * @return \Illuminate\Http\Response $typePayments
     */
    public function index()
    {
        $typePayments = TypePayment::with('image')->get();
        return (new Response(json_encode(["success"=>true,"typePayments"=>$typePayments]), 200));
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
        if (TypePayment::where('slug', $slug)->exists()) {
            return (new Response(json_encode(["success"=>false,"error"=>true,"message"=>"Cette Name '".$slug."' existe déjà"]), 200));
        }
        
        DB::beginTransaction();

        /**
         *  TypePayment
         *
        */

        $typePayment               = new TypePayment();
        $typePayment->name         = $data->name;      
        $typePayment->slug         = $slug;     
        $pictureName               = ($data->picture->name == '')?'ICON-PAYMENT': $data->picture->name ;
        $typePayment->image_id     = \PictureService::save($data->picture->url,$pictureName,'image','type-payments',[]);
        $typePayment->save();
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
        $typePayment     = TypePayment::findOrFail($id);
        $picture         = $typePayment->image;
        $typePayment     = $typePayment->makeHidden(['image']);
       return (new Response(json_encode(["success"=>true,"typePayment"=>$typePayment,'picture'=>$picture]), 200));
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
        if (TypePayment::where('slug', $slug)->where('id','!=', $id)->exists()) {
            return (new Response(json_encode(["success"=>false,"error"=>true,"message"=>"Cette Name '".$slug."' existe déjà"]), 200));
        }
        
        DB::beginTransaction();

        /**
         *  TypePayment
         *
        */

        $typePayment               = TypePayment::findOrFail($id);
        $typePayment->name         = $data->name;      
        $typePayment->slug         = $slug; 
        if ($data->picture->update) {
            $pictureName               = ($data->picture->name == '')?'ICON-PAYMENT': $data->picture->name ;
            $typePayment->image_id     = \PictureService::save($data->picture->url,$pictureName,'image','type-payments',[]);
        }
        
        $typePayment->update();
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
        $typePayment     = TypePayment::findOrFail($id);
        $image_id =  $typePayment->image_id;
        $typePayment->delete();
        \PictureService::delete($image_id);
        DB::commit();
        return (new Response(json_encode(["success"=>true,"error"=>false,"message"=>"Suppression a été effectué avec succès"]), 200));

    }

}
