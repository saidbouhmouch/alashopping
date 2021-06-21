<?php

namespace App\Http\Middleware;
use Illuminate\Http\Response;

use Closure;

class VerifyCsrfToken 
{

    public function handle($request, Closure $next)
    {
       
        if ("Bearer  ".$request->session()->get('_token') !=  $request->header('X-CSRF-TOKEN')) {
            return new Response(json_encode(["success"=>false,"message"=>"You are not authorized to access this api"]), 401);
        }
        return $next($request);
    }
}
