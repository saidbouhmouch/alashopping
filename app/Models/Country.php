<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Country extends Model
{
    protected $table = 'countries';
    protected $primaryKey = 'id';
    public $timestamps = true;
    protected $guarded = ['id'];
    protected $fillable = [
                              'name',
                              'code',
                              'image_id'
                          ];
    // protected $hidden = [];
     protected $dates = ['created_at',
                         'updated_at'
                        ];


    public function image(){
        return $this->belongsTo('App\Models\Storage','image_id');
    }  

    public function addresse(){
        return $this->hasOne('App\Models\Addresse','country_id');
    } 
}
