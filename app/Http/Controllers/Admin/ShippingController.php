<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use App\Models\Shipping;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class ShippingController extends Controller
{
    /**
     * Display a listing of the Shippings.
     *
     * @return \Illuminate\Http\Response $shippings
     */
    public function index()
    {
        $shippings = Shipping::with(['deliveryTo','deliveryFrom','currency','carrier','carrier.image'])->get();
        return (new Response(json_encode(["success"=>true,"shippings"=>$shippings]), 200));
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

        $exists = Shipping::where('from',$data->from->id)
                            ->where('to',$data->to->id)
                            ->where('price',$data->price)
                            ->where('estimated_delivery_min',$data->estimatedDeliveryMin)
                            ->where('estimated_delivery_max',$data->estimatedDeliveryMax)
                            ->where('carrier_id',$data->carrier->id)
                             ->exists();
        if ($exists) {
            return (new Response(json_encode(["success"=>false,"error"=>true,"message"=>"This Shipping already exists"]), 200));
        }
        
        DB::beginTransaction();

        /**
         *  Shipping
         *
        */
        $shipping                         = new Shipping();
        $shipping->from                   = $data->from->id;   
        $shipping->to                     = $data->to->id;   
        $shipping->carrier_id             = $data->carrier->id;   
        $shipping->estimated_delivery_min = $data->estimatedDeliveryMin;   
        $shipping->estimated_delivery_max = $data->estimatedDeliveryMax;   
        $shipping->price                  = $data->price;  
        $shipping->currency_id            = $data->currency->id;  
        $shipping->save();
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
    //     $carrier         = Carrier::findOrFail($id);
    //     $picture         = $carrier->image;
    //     $carrier         = $carrier->makeHidden(['image']);
    //    return (new Response(json_encode(["success"=>true,"carrier"=>$carrier,'picture'=>$picture]), 200));
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
        // DB::commit();
        // return (new Response(json_encode(["success"=>true,"error"=>false,"message"=>"Enregistrement a été effectué avec succès"]), 200));
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
        $shipping     = Shipping::findOrFail($id);
        $shipping->delete();
        DB::commit();
        return (new Response(json_encode(["success"=>true,"error"=>false,"message"=>"Suppression a été effectué avec succès"]), 200));

    }



}
