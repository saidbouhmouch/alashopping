<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    protected $table = 'categories';
    protected $primaryKey = 'id';
    public $timestamps = true;
    protected $guarded = ['id'];
    protected $fillable = [
                              'name',
                              'slug',
                              'description',
                              'parent_id'
                          ];
    // protected $hidden = [];
     protected $dates = ['created_at',
                         'updated_at'
                        ];

    public function parent(){
        return $this->belongsTo('App\Models\Category', 'parent_id');
    }
    
    public function children(){
        return $this->hasMany('App\Models\Category', 'parent_id');
    }

    public function products(){
        return $this->belongsToMany('App\Models\Product', 'category_product', 'category_id', 'product_id');
    }

}
