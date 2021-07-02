<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Product extends Model {
    protected $table = 'products';
    protected $primaryKey = 'id';
    public $timestamps = true;
    protected $guarded = ['id'];
    protected $fillable = [
        'name',
        'slug',
        'price',
        'description_short',
        'description_long',
        'sku',
        'stock',
        'additional_information',
        'active',
        'currency_id',
        'image_id',
        'taxe_id',
        'user_id'
    ];

    // protected $hidden = [];
    protected $dates = ['created_at','updated_at'];

    // protected $appends = ['specific_price'];

    // public function getSpecificPriceAttribute() {

    //     return $this->specificPrices
    //                 ->where('start_date','>=',date("Y-m-d H:i:s"))
    //                 ->where('expiration_date','<=',date("Y-m-d H:i:s"))
    //                 ->get();

    // }

    public function currency() {
        return $this->belongsTo('App\Models\Currency', 'currency_id');
    }

    public function image() {
        return $this->belongsTo('App\Models\Storage', 'image_id');
    }

    public function taxe() {
        return $this->belongsTo('App\Models\Taxe', 'taxe_id');
    }

    public function user() {
        return $this->belongsTo('App\Models\User', 'user_id');
    }

    public function categories() {
        return $this->belongsToMany('App\Models\Category', 'category_product', 'product_id', 'category_id');
    }

    public function tags() {
        return $this->belongsToMany('App\Models\Tag', 'tag_product', 'product_id', 'tag_id');
    }

    public function galleries() {
        return $this->belongsToMany('App\Models\Storage', 'galleries', 'product_id', 'image_id');
    }

    public function specificPrices() {
        return $this->hasMany('App\Models\SpecificPrice', 'product_id');
    }

}
