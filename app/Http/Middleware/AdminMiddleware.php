<?php

namespace App\Http\Middleware;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Auth;
use Closure;

class AdminMiddleware 
{

    public function handle($request, Closure $next)
    {
        if(Auth::check()){
             if(Auth::user()->isAdmin){
                $credentials =  app('request')->session()->get('Authorization');
                 if(  !$credentials || ("Bearer  ".$credentials !=  $request->header('Authorization')) ){
                     return new Response(json_encode(["success"=>false,"message"=>"You are not have access rights to the content"]), 403);
                 }else{
                     return $next($request);
                 }
                
             }else{
                return new Response(json_encode(["success"=>false,"message"=>"You are not have access rights to the content"]), 403);
             }
        }else{
            return new Response(json_encode(["success"=>false,"message"=>"You are not authorized"]), 401);
        }
    }
}
