<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Order extends Model
{

    protected $table = 'orders';
    protected $primaryKey = 'id';
    public $timestamps = true;
    protected $guarded = ['id'];
    protected $fillable = [
                              'user_id',
                              'order_status_id',
                              'shipping_id',
                              'billing_address_id',
                              'shipping_address_id',
                              'currency_id',
                              'type_payment_id',
                              'comment',
                              'date_order',
                              'delivery_date',
                              'total_discount',
                              'total_shipping',
                              'total_tax',
                              'total',
                          ];

     // protected $hidden = [];
     protected $dates = ['created_at',
                         'updated_at'
                        ];

    public function user(){
        return $this->belongsTo('App\Models\User','user_id');
    }

    public function orderStatus(){
        return $this->belongsTo('App\Models\OrderStatus','order_status_id');
    } 
    
    public function shipping(){
        return $this->belongsTo('App\Models\Shipping','shipping_id');
    } 

    public function billingAddress(){
        return $this->belongsTo('App\Models\Addresse','billing_address_id');
    }

    public function shippingAddress(){
        return $this->belongsTo('App\Models\Addresse','shipping_address_id');
    }

    public function currency(){
        return $this->belongsTo('App\Models\Currency','currency_id');
    }

    public function TypePayment(){
        return $this->belongsTo('App\Models\TypePayment','type_payment_id');
    }

    public function products(){
        return $this->belongsToMany('App\Models\Product', 'order_product', 'order_id', 'product_id')->withPivot('price', 'quantity','is_discount','reduction','total')->withTimestamps();
    }

    
}
