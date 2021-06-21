<?php

namespace App\Services;

use Firebase\JWT\JWT;

class JweService{
    
    public static $credentials = '';

    public static function decrypt($token)
    {
       return JWT::decode($token,"secret", ['HS256']);
    }

    public static function encode($data)
    {
        return  JWT::encode($data,"secret",'HS256');
    }

}