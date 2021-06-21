<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Role extends Model
{
    protected $table = 'roles';
    protected $primaryKey = 'id';
    public $timestamps = true;
    protected $guarded = ['id'];
    protected $fillable = [
                                'name',
                                'guard_name',
                            ];
    // protected $hidden = [];
    protected $dates = ['created_at',
                        'updated_at'
                        ];
        
    public function users(){
        return $this->belongsToMany('App\Models\User', 'role_user', 'role_id', 'user_id');
    }            
}
