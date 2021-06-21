<?php

namespace App\Http\Controllers\Ui;

use App\Http\Controllers\Controller;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use App\Models\Product;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\DB;
use App\Classes\Pagination;

class ProductController extends Controller
{


    public function maxPrice(){
        $maxPrice = Product::max('price');
        return (new Response(json_encode(["success"=>true,"maxPrice"=>$maxPrice]), 200));
    }

    public function fetchByfilter(Request $request){
        $filter =json_decode($request->data);
        
        $where = array();
        $where []=['price','>',$filter->price->min];
        $where []=['active','=',1];  

        if($filter->price->max > 0){
            $where []=['price','<',$filter->price->max];
        }

        $orderby = array();
        foreach ($filter->sortBy as $key => $value) {

            if($value->value == 'price_low_to_high' && $value->selected){
                $orderby[]='price asc';
            }

            if($value->value == 'price_high_to_low' && $value->selected){
                $orderby[]='price desc';
            }
            if($value->value == 'newArrivals' && $value->selected){
                $orderby[]='updated_at desc';
            }

            if($value->value == 'alphabetically_az' && $value->selected){
                $orderby[]='name asc';
            }

            if($value->value == 'alphabetically_za' && $value->selected){
                $orderby[]='name desc';
            }
        }

        $products = [];

        $pagination = new Pagination();
        $pagination->setSize($filter->size);
        $pagination->setCurrentPage($filter->page);
        $pagination->calculOffset();


        if(count($orderby)==0){
            $orderby[]='updated_at asc';
        }


        if($filter->categories && count($filter->categories) > 0){
            $categories = $filter->categories;
            $products = Product::with(['image','image.children' => function ($query) {
                $query->where('size','xs');
            },'specificPrices'=> function ($query){
                        $query->where('start_date','<=',date("Y-m-d H:i:s"))
                        ->where('expiration_date','>=',date("Y-m-d H:i:s"));
            }])->where($where)
            ->whereHas('categories', function ($q) use ($categories) {
                $q->whereIn('slug',$categories); // where in for array
            })
            ->orderByRaw(implode(" , ", $orderby))
            ->paginate($pagination->getSize(), ['*'], 'page',$pagination->getCurrentPage());

        }else{
            $products = Product::with(['image','image.children' => function ($query) {
                $query->where('size','xs');
            },'specificPrices'=> function ($query){
                        $query->where('start_date','<=',date("Y-m-d H:i:s"))
                        ->where('expiration_date','>=',date("Y-m-d H:i:s"));
            }])->where($where)
            ->orderByRaw(implode(" , ", $orderby))
            ->paginate($pagination->getSize(), ['*'], 'page',$pagination->getCurrentPage());
        }
                    
        // \LoggerService::writeln("---->> count".count($productsIds));
        $TotalElements = Product::count();
        $products = $this->mappingData($products);
        $data = $pagination->generatePagination($products,$TotalElements);
        
        return (new Response(json_encode(["success"=>true,"products"=>$data]), 200));

    }

    public function findBySlug($slug){
        $product = Product::with(['specificPrices'=> function ($query){
                    $query->where('start_date','<=',date("Y-m-d H:i:s"))
                    ->where('expiration_date','>=',date("Y-m-d H:i:s"));
        }])
        ->where('slug',$slug)->firstOrFail();

        $prod = new \stdClass;
        $prod->id  = $product->id; 
        $prod->name  = $product->name; 
        $prod->price = $product->price;
        $prod->slug  = $product->slug;
        $prod->description_short = $product->description_short;
        $prod->description_long =$product->description_long;
        $prod->sku = $product->sku;
        $prod->stock = $product->stock;
        $prod->additionalInformation = $product->additional_information;
        $prod->picture     = $product->image;
        $prod->galleries   = $product->galleries;
        $tags        = implode(', ',array_map(function($tag){ return  $tag['name']; },$product->tags->toArray())) ;
        $categories  = implode(', ',array_map(function($category){ return  $category['name']; },$product->categories->toArray()));
        $prod->currency    = $product->currency;
        $prod->specificPrice = $product->specificPrices->first();
        // $product     = $product->makeHidden(['galleries', 'image','tags','categories','currency','specificPrices','taxe','user_id','taxe_id','active','image_id']);
       return (new Response(json_encode(["success"=>true,
                                         "product"=>$prod,
                                         "tags"=>$tags,
                                         "categories"=>$categories
                                         ]), 200));
    }

    public function fetchByIds(Request $request){

        $ids =json_decode($request->data);
        $prods = Product::with(['specificPrices'=> function ($query){
                    $query->where('start_date','<=',date("Y-m-d H:i:s"))
                    ->where('expiration_date','>=',date("Y-m-d H:i:s"));
        }])
        ->findMany($ids);
        
        $products = [];
        foreach ($prods as $key => $product) {
            $prod = new \stdClass;
            $prod->id  = $product->id; 
            $prod->name  = $product->name; 
            $prod->price = $product->price;
            $prod->slug  = $product->slug;
            $prod->picture     = $product->image;
            $prod->currency    = $product->currency;
            $prod->specificPrice = $product->specificPrices->first();
            $products[]=$prod;
        }
       return (new Response(json_encode(["success"=>true,
                                         "products"=>$products,
                                         ]), 200));
    }

    

    
    public function mappingData($data){
        $products = [];
       foreach ($data->toArray()['data'] as $key => $value) {
             $product = new \stdClass;
             $product->id  = $value['id']; 
             $product->name  = $value['name']; 
             $product->price = $value['price'];
             $product->slug  = $value['slug'];
             $product->image  = $value['image'];
             $product->specificPrice  = (isset($value['specific_prices']) && count($value['specific_prices']) > 0)?$value['specific_prices'][0] : null;
             $product->status  = (isset($value['specific_prices']) && count($value['specific_prices']) > 0)?'sale' : null;
            array_push( $products,$product);
       }
       return $products;
    }
    

}
