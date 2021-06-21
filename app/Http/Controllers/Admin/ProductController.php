<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use App\Models\Product;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
class ProductController extends Controller
{
    /**
     * Display a listing of the products.
     *
     * @return \Illuminate\Http\Response $products
     */
    public function index()
    {
        $products = Product::with(['image','image.children' => function ($query) {
            $query->where('size','xs');
        }])->get();
        $products = $products->makeHidden(['user']);
        return (new Response(json_encode(["success"=>true,"products"=>$products]), 200));
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
        if (Product::where('slug', $slug)->exists()) {
            return (new Response(json_encode(["success"=>false,"error"=>true,"message"=>"Cette Name '".$slug."' existe déjà"]), 200));
        }

        if (Product::where('sku', $data->sku)->exists()) {
            return (new Response(json_encode(["success"=>false,"error"=>true,"message"=>"Cet SKU '".$data->sku."' existe déjà"]), 200));
        }

        DB::beginTransaction();

        $sizes = array(
            array('type' => 'xs' , 'size' => "64" )
         );

        $product                          = new Product();
        $product->name                    = $data->name;
        $product->slug                    = $slug;
        $product->price                   = $data->price;
        $product->description_short       = $data->descriptionShort;
        $product->description_long        = $data->descriptionLong;
        $product->sku                     = $data->sku;
        $product->stock                   = $data->stock;
        $product->additional_information  = $data->additionalInformation;
        $product->active                  = $data->active;
        $product->currency_id             = $data->currency->id;
        $pictureName                      = ($data->picture->name == '')?'PRODUCT': $data->picture->name ;
        $product->image_id                =  \PictureService::save($data->picture->url,$pictureName,'image','products',$sizes);
        $product->taxe_id                 = $data->taxe->id;
        $product->user_id                 = Auth::user()->id;
        $product->save(); 

        foreach ($data->categories as $key => $value) {
            $product->categories()->attach($value->id); 
        }

        foreach ($data->tags as $key => $value) {
            $product->tags()->attach($value->id); 
        }


        foreach ($data->galleries as $key => $value) {
            // $sizes = [];
            $sizes = array(
                array('type' => 'md' , 'size' => "500" ),
                array('type' => 'sm' , 'size' => "250" ),
                array('type' => 'xs' , 'size' => "100" )
             );
            $pictureName  = ($value->name == '')?'GALLERY': $value->name ;
            $imageId = \PictureService::save($value->url,$pictureName,'image','galleries',$sizes);
            $product->galleries()->attach($imageId);
        }

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
        $product     = Product::findOrFail($id);
        $picture     = $product->image;
        $galleries   = $product->galleries;
        $tags        = $product->tags;
        $categories  = $product->categories;
        $currency    = $product->currency;
        $taxe        = $product->taxe;

        $product     = $product->makeHidden(['galleries', 'image','tags','categories','currency']);
       return (new Response(json_encode(["success"=>true,
                                         "product"=>$product,
                                         'picture'=>$picture,
                                         'galleries'=>$galleries,
                                         'tags'=>$tags,
                                         'categories'=>$categories,
                                         'currency'=>$currency,
                                         "taxe"=>$taxe
                                         ]), 200));
    }

    /**
     * Update.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */

    public function update(Request $request,$id)
    {
        $data =json_decode($request->data);

        $slug=Str::slug($data->name, '-');
        if (Product::where('slug', $slug)->where('id','!=',$id)->exists()) {
            return (new Response(json_encode(["success"=>false,"error"=>true,"message"=>"Cette Name '".$slug."' existe déjà"]), 200));
        }

        if (Product::where('sku', $data->sku)->where('id','!=',$id)->exists()) {
            return (new Response(json_encode(["success"=>false,"error"=>true,"message"=>"Cet SKU '".$data->sku."' existe déjà"]), 200));
        }



        DB::beginTransaction();

        $sizes = array(
            array('type' => 'xs' , 'size' => "64" )
         );

        $product                          = Product::findOrFail($id);;
        $product->name                    = $data->name;
        $product->slug                    = $slug;
        $product->price                   = $data->price;
        $product->description_short       = $data->descriptionShort;
        $product->description_long        = $data->descriptionLong;
        $product->sku                     = $data->sku;
        $product->stock                   = $data->stock;
        $product->additional_information  = $data->additionalInformation;
        $product->active                  = $data->active;
        $product->currency_id             = $data->currency->id;
        $pictureName                      = ($data->picture->name == '')?'PRODUCT': $data->picture->name ;
        if ($data->picture->update) {
            $product->image_id =  \PictureService::save($data->picture->url,$pictureName,'image','products',$sizes);
        }
        $product->taxe_id                 = $data->taxe->id;
        $product->user_id                 = Auth::user()->id;
        $product->update(); 

        $product->categories()->detach();
        foreach ($data->categories as $key => $value) {
            $product->categories()->attach($value->id); 
        }

        $product->tags()->detach();
        foreach ($data->tags as $key => $value) {
            $product->tags()->attach($value->id); 
        }

        $product->galleries()->detach();
        foreach ($data->galleries as $key => $value) {
            // $sizes = [];
            $sizes = array(
                array('type' => 'md' , 'size' => "500" ),
                array('type' => 'sm' , 'size' => "250" ),
                array('type' => 'xs' , 'size' => "100" )
             );
            $pictureName  = ($value->name == '')?'GALLERY': $value->name ;
            $imageId = \PictureService::save($value->url,$pictureName,'image','galleries',$sizes);
            $product->galleries()->attach($imageId);
        }

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
        $product     = Product::findOrFail($id);
        $image_id =  $product->image_id;
        $product->categories()->detach();
        $product->tags()->detach();
        // $product->galleries()->detach();
        \PictureService::delete($image_id);
        foreach ($product->galleries as $key => $value) {
            \PictureService::delete($value->id);
        }
        $product->delete();
        DB::commit();
        return (new Response(json_encode(["success"=>true,"error"=>false,"message"=>"Suppression a été effectué avec succès"]), 200));

    }

}
