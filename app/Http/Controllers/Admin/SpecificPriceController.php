<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use App\Models\SpecificPrice;
use App\Models\Product;
use Illuminate\Support\Facades\DB;

class SpecificPriceController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $specificPrices = SpecificPrice::with(['product', 'product.currency'])->get();
        //$products = $products->makeHidden(['user']);
        return (new Response(json_encode(["success" => true, "specificPrices" => $specificPrices]), 200));
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

    public function CheckProductExistsBetweenTwoDates($productId, $startDate, $expirationDate, $specificPriceId)
    {

        $specificPrice  = SpecificPrice::where('product_id', $productId)->first();

        if ($specificPriceId) {
            $specificPrice = SpecificPrice::where('product_id', $productId)
                ->where('id', '!=', $specificPriceId)->first();
        }


        if ($specificPrice) {
            $date1 = strtotime($startDate);
            $date2 = strtotime($expirationDate);

            $start_date = strtotime($specificPrice->start_date);
            $expiration_date = strtotime($specificPrice->expiration_date);

            if (($date1 >= $start_date && $date1 <= $expiration_date) || ($date2 <= $expiration_date && $date2 >= $start_date)) {
                return true;
            }else if( $date1 <= $start_date && $date2 >= $expiration_date){
                return true;
            }else {
                return false;
            }
        }
    }

    public function store(Request $request)
    {
        $data = json_decode($request->data);
        DB::beginTransaction();

        foreach ($data->productsIds as $productId) {
            $product = Product::findOrFail($productId);

            if ($this->CheckProductExistsBetweenTwoDates($product->id, $data->specificPrice->startDate, $data->specificPrice->expirationDate, null)) {
                return (new Response(json_encode(["success" => false, "error" => true, "message" => $product->name . " exists between " . $data->specificPrice->startDate . " - " . $data->specificPrice->expirationDate]), 200));
            }
            $specificPrice                  = new SpecificPrice();
            $specificPrice->reduction       = $data->specificPrice->reduction;
            $specificPrice->discount_type   = $data->specificPrice->discountType;
            $specificPrice->start_date      = $data->specificPrice->startDate;
            $specificPrice->expiration_date = $data->specificPrice->expirationDate;

            $specificPrice->currency_id     = $product->currency_id;
            $specificPrice->product_id      = $product->id;
            $specificPrice->save();
        }
        DB::commit();
        return (new Response(json_encode(["success" => true, "error" => false, "message" => "Enregistrement a été effectué avec succès"]), 200));
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $specificPrice     = SpecificPrice::findOrFail($id);
        $product           = $specificPrice->product;
        $specificPrice     = $specificPrice->makeHidden(['product']);
        return (new Response(json_encode([
            "success" => true,
            "specificPrice" => $specificPrice,
            "product" => $product
        ]), 200));
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
        $data = json_decode($request->data);
        DB::beginTransaction();
        $specificPrice  = SpecificPrice::findOrFail($id);
        $product        = Product::findOrFail($specificPrice->product_id);

        if ($this->CheckProductExistsBetweenTwoDates($product->id, $data->startDate, $data->expirationDate, $id)) {
            return (new Response(json_encode(["success" => false, "error" => true, "message" => $product->name . " exists between " . $data->startDate . " - " . $data->expirationDate]), 200));
        }
        $specificPrice->reduction       = $data->reduction;
        $specificPrice->discount_type   = $data->discountType;
        $specificPrice->start_date      = $data->startDate;
        $specificPrice->expiration_date = $data->expirationDate;
        $specificPrice->update();
        DB::commit();
        return (new Response(json_encode(["success" => true, "error" => false, "message" => "Enregistrement a été effectué avec succès"]), 200));
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $specificPrice  = SpecificPrice::findOrFail($id);
        $specificPrice->delete();
        return (new Response(json_encode(["success" => true, "error" => false, "message" => "Suppression a été effectué avec succès"]), 200));
    }
}
