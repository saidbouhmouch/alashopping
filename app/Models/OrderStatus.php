<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class OrderStatus extends Model
{
    protected $table = 'order_status';
    protected $primaryKey = 'id';
    public $timestamps = true;
    protected $guarded = ['id'];
    protected $fillable = [
                                'name',
                                'slug',
                            ];
    // protected $hidden = [];
    protected $dates = ['created_at',
                        'updated_at'
                        ];
        
    public function orders(){
        return $this->hasMany('App\Models\Order','order_status_id');
    }            
}
