<?php

namespace App\Http\Controllers\Ui;

use App\Http\Controllers\Controller;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use App\Models\Shipping;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class ShippingController extends Controller
{
    
    public function show($id){
        $shipping = Shipping::with(['deliveryTo','deliveryFrom','currency','carrier','carrier.image'])
                            ->orderBy('price','asc')
                            ->findOrFail($id);         
        return (new Response(json_encode(["success"=>true,"shipping"=>$shipping]), 200));
    }

    public function getShippingByZone($from,$to){

        $shipping = Shipping::with(['deliveryTo','deliveryFrom','currency','carrier','carrier.image'])
                            ->whereHas('deliveryFrom', function ($query) use ($from) {
                                $query->where('code',$from);
                            })->whereHas('deliveryTo', function ($query) use ($to) {
                                $query->where('code',$to);
                            })->orderBy('price','asc')
                            ->firstOrFail();
                            
        return (new Response(json_encode(["success"=>true,"shipping"=>$shipping]), 200));
    }


    public function getShippingsByZone($from,$to){

        $shippings = Shipping::with(['deliveryTo','deliveryFrom','currency','carrier','carrier.image'])
                            ->whereHas('deliveryFrom', function ($query) use ($from) {
                                $query->where('code',$from);
                            })->whereHas('deliveryTo', function ($query) use ($to) {
                                $query->where('code',$to);
                            })
                            ->orderBy('price','asc')
                            ->get();
                            
        return (new Response(json_encode(["success"=>true,"shippings"=>$shippings]), 200));
    }

    
    



}
