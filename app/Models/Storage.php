<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Storage extends Model
{
    protected $table = 'storages';
    protected $primaryKey = 'id';
    public $timestamps = true;
    protected $guarded = ['id'];
    protected $fillable = [
                              'parent_id',
                              'name',
                              'url',
                              'type',
                              'size'
                          ];
    // protected $hidden = [];
     protected $dates = ['created_at',
                         'updated_at'
                        ];

    public function parent(){
        return $this->belongsTo('App\Models\Storage', 'parent_id');
    }
    
    public function children(){
        return $this->hasMany('App\Models\Storage', 'parent_id');
    }  
    
    public function user(){
        return $this->hasOne('App\Models\User','image_id');
    }

    public function typePayment(){
        return $this->hasOne('App\Models\TypePayment','image_id');
    }

    public function carrier(){
        return $this->hasOne('App\Models\Carrier','image_id');
    }

    public function product(){
        return $this->hasOne('App\Models\Product', 'image_id');
    }

    public function galleries(){
        return $this->belongsToMany('App\Models\Product', 'galleries', 'image_id','product_id');
    }

}
