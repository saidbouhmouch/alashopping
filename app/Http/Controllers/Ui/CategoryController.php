<?php

namespace App\Http\Controllers\Ui;

use App\Http\Controllers\Controller;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use App\Models\Category;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\DB;

class CategoryController extends Controller
{

    public function index()
    {
        $categories = Category::all();
        return (new Response(json_encode(["success"=>true,"categories"=>$categories]), 200));
    }

    public function listWithProductsTotal(){
        $categories = Category::withCount('products')->get();
        $categories = $categories->makeHidden(['created_at', 'description','updated_at']);
        return (new Response(json_encode(["success"=>true,"categories"=>$categories]), 200));
    }
}
