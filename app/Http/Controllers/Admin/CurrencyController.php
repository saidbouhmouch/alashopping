<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use App\Models\Currency;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\DB;

class CurrencyController extends Controller
{
    public function index()
    {
        $currencies = Currency::all();
        return (new Response(json_encode(["success"=>true,"currencies"=>$currencies]), 200));
    }

    public function store(Request $request)
    {
        $data =json_decode($request->data);
        if (Currency::where('name', $data->name)->exists()) {
            return (new Response(json_encode(["success"=>false,"error"=>true,"message"=>"Cette Currency '".$data->name."' existe déjà"]), 200));
        }
        DB::beginTransaction();

        /**
         *  Currency
         *
        */
        if($data->default){
            Currency::where('default',true)->update(['default' => false]);
        }

        $currency               = new Currency();
        $currency->name         = $data->name;      
        $currency->iso          = $data->iso;      
        $currency->value        = $data->value;      
        $currency->default      = $data->default;      
        $currency->save();

        DB::commit();
        return (new Response(json_encode(["success"=>true,"error"=>false,"message"=>"Enregistrement a été effectué avec succès"]), 200));
    }

    public function edit($id)
    {
        $currency = Currency::findOrFail($id);
        return (new Response(json_encode(["success"=>true,"currency"=>$currency]), 200));
    }

    public function update(Request $request , $id)
    {
        $data =json_decode($request->data);
        if (Currency::where('name', $data->name)->where('id','!=', $id)->exists()) {
            return (new Response(json_encode(["success"=>false,"error"=>true,"message"=>"Cette Currency '".$data->name."' existe déjà"]), 200));
        }
        DB::beginTransaction();

        /**
         *  Currency
         *
        */
        if($data->default){
            Currency::where('default',true)->update(['default' => false]);
        }

        $currency               = Currency::findOrFail($id);
        $currency->name         = $data->name;      
        $currency->iso          = $data->iso;      
        $currency->value        = $data->value;      
        $currency->default      = $data->default;      
        $currency->update();

        DB::commit();
        return (new Response(json_encode(["success"=>true,"error"=>false,"message"=>"Enregistrement a été effectué avec succès"]), 200));
    }

    public function destroy($id)
    {
        $currency = Currency::findOrFail($id);
        $currency->delete();
        return (new Response(json_encode(["success"=>true,"error"=>false,"message"=>"Suppression a été effectué avec succès"]), 200));
    }


}
