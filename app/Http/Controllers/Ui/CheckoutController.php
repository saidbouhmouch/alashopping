<?php

namespace App\Http\Controllers\Ui;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Addresse;
use App\Models\User;
use App\Models\Shipping;
use App\Models\Order;
use App\Models\TypePayment;
use App\Models\OrderStatus;
use App\Models\Product;
use Illuminate\Support\Facades\Auth;

class CheckoutController extends Controller
{
    
    /**
     * Place Order.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */

    public function placeOrder(Request $request){
        $data =json_decode($request->data);

        DB::beginTransaction();
    
        $user = User::findOrFail(Auth::id());
        $shipping = Shipping::findOrFail($data->shippingId);
        $order = new Order();
        $order->user_id = $user->id;
        $order->order_status_id = OrderStatus::where('slug','pending')->firstOrFail()->id ;
        $order->shipping_id = $shipping->id;
        $order->billing_address_id = Addresse::where('user_id',$user->id)->where('type','billing')->firstOrFail()->id;
        $order->shipping_address_id = Addresse::where('user_id',$user->id)->where('type','shipping')->firstOrFail()->id;
        $order->currency_id = 1 ;
        $order->type_payment_id = TypePayment::where('slug', $data->typePayment)->firstOrFail()->id ;
        $order->comment = $data->comment;
        $order->date_order = date("Y-m-d h:i:s") ;
        $order->delivery_date =  date("Y-m-d h:i:s");
        $order->total_shipping =  $shipping->price;
        $order->total_tax = 0; // TODO : 

        // $total =  $this->addProduct(json_decode(json_encode($data->products), true));

        // add product

        $productIds = $names = array_map(
                        function($prd) { return $prd['productId']; },
                        json_decode(json_encode($data->products))
                        );
    
        $products = Product::with(['specificPrices'=> function ($query){
                    $query->where('start_date','<=',date("Y-m-d H:i:s"))
                    ->where('expiration_date','>=',date("Y-m-d H:i:s"));
                }])
                ->findMany($productIds);

        $totalDiscount = 0;
        $total = 0;
        
        foreach ($products as $key => $product) {
        // \LoggerService::writeln("---->> product ++ ".$product->id);
            $specificPrice = $product->specificPrices->first();
            $sum=0;
            $discount=0;
            $isDiscount=false;

            $item = $this->find(json_decode(json_encode($data->products)),'productId',$product->id);
            if($item){
                if($specificPrice){
                        if($specificPrice->discount_type == 'amount'){
                            $discount = ($item['quantity'] * $specificPrice->reduction);
                            $sum = ($item['quantity'] * $product->price) - ($item['quantity'] * $specificPrice->reduction);
                            
                        }elseif($specificPrice->discount_type == 'percent'){
                            $discount= ($item['quantity'] * ($product->price *  ( $specificPrice->reduction/ 100 )));
                            $sum=($item['quantity'] * $product->price) - ($item['quantity'] * ($product->price *  ( $specificPrice->reduction/ 100 )));
                        }
                        $isDiscount = true;
                        $totalDiscount+=$discount;
                        $total+= $sum;
                }else{
                    $sum = $product->price * $item['quantity'];
                    $total+= $sum;
                }
                $order->products()->attach($product->id, ['price' => $product->price, 'quantity' => $item['quantity'],'is_discount'=>$isDiscount,'reduction'=>$discount,'total'=>$sum]);

            }else{
                    // TODO
            }

        }


        $order->total_discount =  $totalDiscount;
        $order->total =$total+$shipping->price;
        $order->save();
        DB::commit();
        return (new Response(json_encode(["success"=>true,"error"=>false,"message"=>"your order is processed",'orderId'=>$order->id]), 200));
    }

    

    function find($array, $property, $value_to_find) {

        usort($array, function($a, $b) {
            return $a['productId'] - $b['productId'];
        });

        $index = 0;
        $arrayLength = count($array) - 1;
        $i = 0;
        while ($index <= $arrayLength) {
            $i = floor(($index + $arrayLength) / 2);
            if ($array[$i][$property] < $value_to_find) {
                $index = $i + 1;
            } else if ($array[$i][$property] > $value_to_find) {
                $arrayLength = $i - 1;
            } else {
                return $array[$i];
            }
        }
        return false;
    }

    /*
    function addProduct($data){

        $ids = $names = array_map(
                    function($prd) { return $prd['productId']; },
                    $data
            );
            
        $products = Product::with(['specificPrices'=> function ($query){
                    $query->where('start_date','<=',date("Y-m-d H:i:s"))
                    ->where('expiration_date','>=',date("Y-m-d H:i:s"));
                }])
                ->findMany($ids);
        
        $totalDiscount = 0;
        $total = 0;
        foreach ($products as $key => $product) {
           // \LoggerService::writeln("---->> product ++ ".$product->id);
            $specificPrice = $product->specificPrices->first();
            if($specificPrice){
                 $item = $this->find($data,'productId',$product->id);
                 if($item){
                    if($specificPrice->discount_type == 'amount'){
                        $totalDiscount+=($item['quantity'] * $specificPrice->reduction);
                        $total+= ($item['quantity'] * $product->price) - ($item['quantity'] * $specificPrice->reduction);
                    }elseif($specificPrice->discount_type == 'percent'){
                        $totalDiscount+= ($item['quantity'] * ($product->price *  ( $specificPrice->reduction/ 100 )));
                        $total+=($item['quantity'] * $product->price) - ($item['quantity'] * ($product->price *  ( $specificPrice->reduction/ 100 )));
                    }
                 }
            }else{
                $total+= $product->price;
            }

            $shop->products()->attach(1, ['products_amount' => 100, 'price' => 49.99]);
        }
        return [$totalDiscount,$total];
    }
    */

}
