<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SpecificPrice extends Model
{
    protected $table = 'specific_prices';
    protected $primaryKey = 'id';
    public $timestamps = true;
    protected $guarded = ['id'];
    protected $fillable = [
                                "discount_type",
                                "start_date",
                                "expiration_date",
                                "currency_id",
                                "product_id",
                                'reduction'
                            ];
    // protected $hidden = [];
    protected $dates = ['created_at',
                        'updated_at'
                        ];

    public function product(){
        return $this->belongsTo('App\Models\Product', 'product_id');
    }

    public function currency(){
        return $this->belongsTo('App\Models\Currency','currency_id');
    }
}
