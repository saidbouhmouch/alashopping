<?php

namespace App\Http\Controllers\Ui;

use App\Http\Controllers\Controller;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use App\Models\User;
//use App\Models\Role;
use App\Models\Addresse;
use Illuminate\Support\Facades\DB;
//use Illuminate\Support\Facades\Hash;
//use Illuminate\Support\Str;
use Illuminate\Support\Facades\Auth;

class UserController extends Controller
{
    

    public function getCurrentUser(){

        $user = null;
       if(Auth::check()){
            $user = User::findOrFail(Auth::id());
            $user->addresse = Addresse::with(['country'])->where('user_id',Auth::id())->where('type','billing')->first();  //'shipping','billing'
       }

        return (new Response(json_encode(["isConnected"=>($user)?true:false,"user"=>$user]), 200));

    }

    
    
}
