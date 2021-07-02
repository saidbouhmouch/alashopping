<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Model;

class Carrier extends Model
{
    protected $table = 'carriers';
    protected $primaryKey = 'id';
    public $timestamps = true;
    protected $guarded = ['id'];
    protected $fillable = [
                              'name',
                              'slug',
                              'price',
                              'delivery_text',
                              'image_id'
                          ];
    // protected $hidden = [];
     protected $dates = ['created_at',
                         'updated_at'
                        ];

                        


    public function image(){
        return $this->belongsTo('App\Models\Storage','image_id');
    }

    public function shipping(){
        return $this->hasMany('App\Models\Shipping','carrier_id');
    }
}
