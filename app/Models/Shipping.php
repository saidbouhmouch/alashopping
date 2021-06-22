<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Shipping extends Model
{
    protected $table = 'shipping';
    protected $primaryKey = 'id';
    public $timestamps = true;
    protected $guarded = ['id'];
    protected $fillable = [
                            'from',
                            'to',
                            'carrier_id',
                            'estimated_delivery_min',
                            'estimated_delivery_max',
                            'price',
                            'currency_id',
                            ];
    // protected $hidden = [];
    protected $dates = ['created_at',
                        'updated_at'
                        ];
        
    public function deliveryFrom(){
        return $this->belongsTo('App\Models\Country', 'from');
    } 

    public function deliveryTo(){
        return $this->belongsTo('App\Models\Country', 'to');
    } 

    public function carrier(){
        return $this->belongsTo('App\Models\Carrier', 'carrier_id');
    } 

    public function currency() {
        return $this->belongsTo('App\Models\Currency', 'currency_id');
    }
}