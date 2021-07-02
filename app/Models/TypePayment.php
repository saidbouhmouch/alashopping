<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TypePayment extends Model
{
    protected $table = 'type_payment';
    protected $primaryKey = 'id';
    public $timestamps = true;
    protected $guarded = ['id'];
    protected $fillable = [
                              'name',
                              'image_id',
                          ];
    // protected $hidden = [];
     protected $dates = ['created_at',
                         'updated_at'
                        ];

    public function image(){
        return $this->belongsTo('App\Models\Storage','image_id');
    } 
}


