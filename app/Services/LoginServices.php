<?php

namespace App\Services;
use App\Models\Role;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Contracts\Auth\PasswordBroker;
// use App\Jobs\ProcessSendResetLinkEmail;


class LoginServices{
    

    public static function login($email,$password,$remember,$role)
    {
        if(!filter_var($email, FILTER_VALIDATE_EMAIL )){
            return ["success"=>false,"error"=>true,"message"=>"This email address is invalid"];
        }

        if (!User::with(['roles'])->where('email', $email)->whereHas('roles', function ($query) use ($role) {
            $query->where('name', '=',$role);
        })->exists()) {
            return ["success"=>false,"error"=>true,"message"=>"This email address does not exist"];
        }

        // if (!User::with(['roles'])->where('email', $email)->where('active',1)->whereHas('roles', function ($query) use ($role) {
        //     $query->where('name', '=',$role);
        // })->exists()) {
        //     return ["success"=>false,"error"=>true,"message"=>"This account does not activate"];
        // }
           
        if (Auth::attempt(['email' => $email, 'password' => $password],$remember)) {
            $user = Auth::user();
            
            $token = array(
                "role" => "admin",
                "email" => $email,
                "remember" => $remember,
                "expiresIn" => 86400,
                'firstName'=>$user->first_name,
                'lastName'=>$user->last_name,
                "image" =>$user->image->url,
                "algorithm" =>  "HS256",
                "iss" =>  url()
            );
            $token = \JweService::encode($token);
            
            app('request')->session()->put('Authorization',$token);
            return ["success"=>true,"error"=>false,"token"=>$token];
          }else {
            return ["success"=>false,"error"=>true,"message"=>"incorrect password"];
          }

    }

    public static function logout(){
      if(Auth::check()){
           Auth::logout();
         return ["success"=>true,"error"=>false,"message"=>"logout"];
       }else {
         return ["success"=>false,"error"=>true,'email'=>false,"message"=>"Error disconnect"];
       }
    }

    public static function checkPassword($email,$password){
        if (Auth::attempt(['email' => $email, 'password' => $password])) {
            return true;
          }else {
            return false;
          }
    }


    public static function sendResetLinkEmail($email,$role)
    {
        if(!filter_var($email, FILTER_VALIDATE_EMAIL )){
            return ["success"=>false,"error"=>true,'email'=>false,"message"=>"This email address is invalid"];
        }

        if (!User::with(['roles'])->where('email', $email)->whereHas('roles', function ($query) use ($role) {
            $query->where('name', '=',$role);
        })->exists()) {
            return ["success"=>false,"error"=>true,"message"=>"This email address does not exist"];
        }


        // 

        DB::beginTransaction();

        DB::table('password_resets')->where('email',$email)->delete();
        DB::table('password_resets')->insert([
          'email' => $email,
          'token' => str_random(60), //change 60 to any length you want
          'created_at' => \Carbon\Carbon::now()
         ]);

        $tokenData = DB::table('password_resets')->where('email',$email)->first();
        $url=url('/password/reset/'.$tokenData->token);
        if($role !="client"){ $url=url('/admin/password/reset/'.$tokenData->token);}

        // ProcessSendResetLinkEmail::dispatch($email,$url)->onQueue('processing');

         DB::commit();
         return ["success"=>true,"email"=>false,"error"=>false,"message"=>"A password link has been sent to your email address"];
        

    }

    public static function showResetForm($token)
    {
        
          DB::beginTransaction();

          $passwordReset = DB::table('password_resets')->where('token', $token)->first();
       
          if (!$passwordReset)
              return ["success"=>false,"error"=>true,"message"=>"This password reset token is invalid.","token"=>''];

          if (\Carbon\Carbon::parse($passwordReset->created_at)->addMinutes(720)->isPast()) {
            DB::table('password_resets')->where('token', $token)->delete();
              return ["success"=>false,"error"=>true,"message"=>"This password reset token is invalid.","token"=>''];
          }

          DB::commit();
          return ["success"=>true,"error"=>false,"message"=>"","token"=>$passwordReset->token];

    }

    public static function reset($email,$newPassword,$confirmNewPassword,$token,$role)
    {

          DB::beginTransaction();

          if(!filter_var($email, FILTER_VALIDATE_EMAIL )){
            return ["success"=>false,"error"=>true,'email'=>false,"message"=>"This email address is invalid"];
           }

          $passwordReset = DB::table('password_resets')->where('email', $email)->where('token', $token)->first();
                 
          if (!$passwordReset)
              return ["success"=>false,"error"=>true,"message"=>"This password reset token is invalid.","token"=>''];

            if (!User::with(['roles'])->where('email', $email)->whereHas('roles', function ($query) use ($role) {
                $query->where('name', '=',$role);
            })->exists()) {
                return ["success"=>false,"error"=>true,"message"=>"This email address does not exist"];
            }

            if($newPassword != $confirmNewPassword){
              return ["success"=>false,"error"=>true,"message"=>"new password and confirm does not match."];
            }

            $user = User::where('email', $email)->firstOrFail();
           
            $user->password = \Hash::make($newPassword);  
            $user->update();
            DB::table('password_resets')->where('email', $email)->where('token', $token)->delete();
            DB::commit();
            return ["success"=>true,"error"=>false,"message"=>"Your password has been reset successfully"];

    }

    






}