<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use App\Models\Taxe;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\DB;

class TaxeController extends Controller
{
    public function index()
    {
        $taxes = Taxe::all();
        return (new Response(json_encode(["success"=>true,"taxes"=>$taxes]), 200));
    }

    public function store(Request $request)
    {
        $data =json_decode($request->data);
        if (Taxe::where('name', $data->name)->exists()) {
            return (new Response(json_encode(["success"=>false,"error"=>true,"message"=>"Cette Taxe '".$data->name."' existe déjà"]), 200));
        }
        DB::beginTransaction();

        /**
         *  Taxe
         *
        */

        $taxe               = new Taxe();
        $taxe->name         = $data->name;      
        $taxe->value        = $data->value; 
        $taxe->save();

        DB::commit();
        return (new Response(json_encode(["success"=>true,"error"=>false,"message"=>"Enregistrement a été effectué avec succès"]), 200));
    }

    public function show($id)
    {
        
    }

    
    public function edit($id)
    {
        $taxe       = Taxe::findOrFail($id);
        //$taxe     = $user->makeHidden(['']);
       return (new Response(json_encode(["success"=>true,"taxe"=>$taxe]), 200));
    }

    public function update(Request $request, $id)
    {
        $data =json_decode($request->data);
        if (Taxe::where('name', $data->name)->where('id','!=', $id)->exists()) {
            return (new Response(json_encode(["success"=>false,"error"=>true,"message"=>"Cette taxe '".$data->name."' existe déjà"]), 200));
        }
        DB::beginTransaction();

        /**
         *  taxe
         *
        */

        $taxe                = Taxe::findOrFail($id);
        $taxe->name          = $data->name ;     
        $taxe->value         = $data->value;      
        $taxe->update();
        DB::commit();
        return (new Response(json_encode(["success"=>true,"error"=>false,"message"=>"Enregistrement a été effectué avec succès"]), 200));
    }


    public function destroy($id)
    {
        DB::beginTransaction();
        $taxe  = Taxe::findOrFail($id);
        $taxe->delete();
        DB::commit();
        return (new Response(json_encode(["success"=>true,"error"=>false,"message"=>"Suppression a été effectué avec succès"]), 200));

    }
}
