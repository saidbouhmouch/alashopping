<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Addresse extends Model
{
    protected $table = 'addresses';
    protected $primaryKey = 'id';
    public $timestamps = true;
    protected $guarded = ['id'];
    protected $fillable = [
                                'addresse',
                                'city',
                                'zipcode',
                                'type',
                                'country_id',
                                'user_id'
                            ];


    // protected $hidden = [];
    protected $dates = ['created_at',
                        'updated_at'
                        ];

            
    public function country(){
        return $this->belongsTo('App\Models\Country','country_id');
    } 

    public function user(){
        return $this->belongsTo('App\Models\User','user_id');
    }
}
