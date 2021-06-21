<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Auth\Authenticatable;
use Illuminate\Contracts\Auth\Access\Authorizable as AuthorizableContract;
use Illuminate\Contracts\Auth\Authenticatable as AuthenticatableContract;
use Laravel\Lumen\Auth\Authorizable;


class User extends Model implements AuthenticatableContract, AuthorizableContract
{
    use Authenticatable, Authorizable;

    protected $table = 'users';
    protected $primaryKey = 'id';
    public $timestamps = true;
    protected $guarded = ['id'];
    protected $fillable = [
                            'first_name',
                            'last_name',
                            'email',
                            'email_verified_at',
                            'password',
                            'gender',
                            'phone',
                            'remember_token',
                            'active',
                            'image_id'
                            ];
                                                   
    protected $hidden = ['password','email_verified_at','remember_token','active'];
    protected $casts = ['email_verified_at' => 'datetime'];

    protected $dates = ['created_at',
                        'updated_at'
                        ];

    protected $appends = ['isAdmin'];  

    /**
     * The accessors 
     *
     */

    public function getIsAdminAttribute()
    {
         if($this->roles->where('name','admin')->count() > 0 )return true;
          return false;
    }

    public function image(){
        return $this->belongsTo('App\Models\Storage','image_id');
    } 


    public function addresse(){
        return $this->hasMany('App\Models\Addresse','user_id');
    } 

    public function roles(){
        return $this->belongsToMany('App\Models\Role', 'role_user', 'user_id', 'role_id');
    }

    public function products(){
        return $this->hasMany('App\Models\Product', 'user_id');
    }

}
