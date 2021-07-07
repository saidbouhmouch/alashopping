<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Currency extends Model
{
    protected $table = 'currencies';
    protected $primaryKey = 'id';
    public $timestamps = true;
    protected $guarded = ['id'];
    protected $fillable = [
                              'name',
                              'iso',
                              'value',
                              'default',
                          ];

     // protected $hidden = [];
     protected $dates = ['created_at',
                         'updated_at'
                        ];

    public function products(){
        return $this->hasMany('App\Models\Product', 'currency_id');
    }

    public function specificPrice(){
        return $this->hasMany('App\Models\SpecificPrice', 'currency_id');
    }

    public function orders(){
        return $this->hasMany('App\Models\Order','currency_id');
    }

}
