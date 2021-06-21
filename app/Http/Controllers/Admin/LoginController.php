<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Http\Response;


class LoginController extends Controller
{

    public function login(Request $request)
    {
        $data =json_decode($request->data);
        $login = \JweService::decrypt($data);
        $login = json_decode($login->data);
        return new Response(json_encode(\LoginServices::login($login->username,$login->password,$login->remember,'admin')), 200);
    }

    public function logout(Request $request)
    {
        return new Response(json_encode(\LoginServices::logout()), 200);
    }

}
