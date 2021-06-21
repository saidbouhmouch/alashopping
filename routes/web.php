<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

/**  Lgin */
$router->group(['prefix'=>'api/admin/login','middleware' => ['csrf']], function() use($router){
    $router->post('/', 'Admin\LoginController@login');
});

$router->group(['prefix'=>'api/admin/logout','middleware' => ['csrf']], function() use($router){
    $router->post('/', 'Admin\LoginController@logout');
});

/**  Roles */
$router->group(['prefix'=>'api/admin/roles','middleware' => ['csrf','admin']], function() use($router){
    $router->get('/', 'Admin\RoleController@index');
   /* $router->get('/create', 'Admin\RoleController@create');
    $router->get('/{id}', 'Admin\RoleController@show');
    $router->get('/{id}/edit', 'Admin\RoleController@edit');
    $router->put('/{id}', 'Admin\RoleController@update');
    $router->delete('/{id}', 'Admin\RoleController@destroy');*/

});

/**  Countries */
$router->group(['prefix'=>'api/admin/countries','middleware' => ['csrf','admin']], function() use($router){
    $router->get('/', 'Admin\CountryController@index');
   /* $router->get('/create', 'Admin\RoleController@create');
    $router->get('/{id}', 'Admin\RoleController@show');
    $router->get('/{id}/edit', 'Admin\RoleController@edit');
    $router->put('/{id}', 'Admin\RoleController@update');
    $router->delete('/{id}', 'Admin\RoleController@destroy');*/

});

/**  User */
$router->group(['prefix'=>'api/admin/users','middleware' => ['csrf','admin']], function() use($router){
    $router->get('/', 'Admin\UserController@index');
    // $router->get('/create', 'Admin\UserController@create');
    $router->post('/', 'Admin\UserController@store');
    $router->get('/{id}', 'Admin\UserController@show');
    $router->get('/{id}/edit', 'Admin\UserController@edit');
    $router->put('/{id}', 'Admin\UserController@update');
    $router->delete('/{id}', 'Admin\UserController@destroy');

});

/**  Categories */
$router->group(['prefix'=>'api/admin/categories','middleware' => ['csrf','admin']], function() use($router){
    $router->get('/', 'Admin\CategoryController@index');
    $router->post('/', 'Admin\CategoryController@store');
    $router->get('/{id}', 'Admin\CategoryController@show');
    $router->get('/{id}/edit', 'Admin\CategoryController@edit');
    $router->put('/{id}', 'Admin\CategoryController@update');
    $router->delete('/{id}', 'Admin\CategoryController@destroy');

});

/**  Tag */
$router->group(['prefix'=>'api/admin/tags','middleware' => ['csrf','admin']], function() use($router){
    $router->get('/', 'Admin\TagController@index');
    $router->post('/', 'Admin\TagController@store');
    $router->get('/{id}', 'Admin\TagController@show');
    $router->get('/{id}/edit', 'Admin\TagController@edit');
    $router->put('/{id}', 'Admin\TagController@update');
    $router->delete('/{id}', 'Admin\TagController@destroy');

});

/**  Taxes */
$router->group(['prefix'=>'api/admin/taxes','middleware' => ['csrf','admin']], function() use($router){
    $router->get('/', 'Admin\TaxeController@index');
    $router->post('/', 'Admin\TaxeController@store');
    $router->get('/{id}', 'Admin\TaxeController@show');
    $router->get('/{id}/edit', 'Admin\TaxeController@edit');
    $router->put('/{id}', 'Admin\TaxeController@update');
    $router->delete('/{id}', 'Admin\TaxeController@destroy');
});

/**  currencies */
$router->group(['prefix'=>'api/admin/currencies','middleware' => ['csrf','admin']], function() use($router){
    $router->get('/', 'Admin\CurrencyController@index');
    $router->post('/', 'Admin\CurrencyController@store');
    $router->get('/{id}', 'Admin\CurrencyController@show');
    $router->get('/{id}/edit', 'Admin\CurrencyController@edit');
    $router->put('/{id}', 'Admin\CurrencyController@update');
    $router->delete('/{id}', 'Admin\CurrencyController@destroy');
});



/**  type_payment */
$router->group(['prefix'=>'api/admin/type-payment','middleware' => ['csrf','admin']], function() use($router){
    $router->get('/', 'Admin\TypePaymentController@index');
    $router->post('/', 'Admin\TypePaymentController@store');
    $router->get('/{id}', 'Admin\TypePaymentController@show');
    $router->get('/{id}/edit', 'Admin\TypePaymentController@edit');
    $router->put('/{id}', 'Admin\TypePaymentController@update');
    $router->delete('/{id}', 'Admin\TypePaymentController@destroy');
});

/**  Carrier */
$router->group(['prefix'=>'api/admin/carriers','middleware' => ['csrf','admin']], function() use($router){
    $router->get('/', 'Admin\CarrierController@index');
    $router->post('/', 'Admin\CarrierController@store');
    $router->get('/{id}', 'Admin\CarrierController@show');
    $router->get('/{id}/edit', 'Admin\CarrierController@edit');
    $router->put('/{id}', 'Admin\CarrierController@update');
    $router->delete('/{id}', 'Admin\CarrierController@destroy');
});

/**  Product */
$router->group(['prefix'=>'api/admin/products','middleware' => ['csrf','admin']], function() use($router){
    $router->get('/', 'Admin\ProductController@index');
    $router->post('/', 'Admin\ProductController@store');
    $router->get('/{id}', 'Admin\ProductController@show');
    $router->get('/{id}/edit', 'Admin\ProductController@edit');
    $router->put('/{id}', 'Admin\ProductController@update');
    $router->delete('/{id}', 'Admin\ProductController@destroy');
});

/**  specific prices */
$router->group(['prefix'=>'api/admin/specific-prices','middleware' => ['csrf','admin']], function() use($router){
    $router->get('/', 'Admin\SpecificPriceController@index');
    $router->post('/', 'Admin\SpecificPriceController@store');
    $router->get('/{id}', 'Admin\SpecificPriceController@show');
    $router->get('/{id}/edit', 'Admin\SpecificPriceController@edit');
    $router->put('/{id}', 'Admin\SpecificPriceController@update');
    $router->delete('/{id}', 'Admin\SpecificPriceController@destroy');
});


/**  Upload File */
$router->group(['prefix'=>'upload-file','middleware' => ['csrf']], function() use($router){
    $router->post('/', 'UploadFileController@store');
});

/**  categories */
$router->group(['prefix'=>'api/categories','middleware' => ['csrf']], function() use($router){
    $router->get('/', 'Ui\CategoryController@index');
    $router->get('/products-total', 'Ui\CategoryController@listWithProductsTotal');
    // $router->post('/', 'Ui\CategoryController@store');
    // $router->get('/{id}', 'Ui\CategoryController@show');
    // $router->get('/{id}/edit', 'Ui\CategoryController@edit');
    // $router->put('/{id}', 'Ui\CategoryController@update');
    // $router->delete('/{id}', 'Ui\CategoryController@destroy');

});

/**  Product */
$router->group(['prefix'=>'api/products','middleware' => ['csrf']], function() use($router){
    $router->get('/max-price', 'Ui\ProductController@maxPrice');
    $router->post('/fetchByfilter', 'Ui\ProductController@fetchByfilter');
    $router->post('/fetchByIds', 'Ui\ProductController@fetchByIds');
    $router->get('/slug/{slug}', 'Ui\ProductController@findBySlug');
});


$router->get('admin/{any:.+}/', function ()  {
    return view('admin');
});

$router->get('/{any:.*}/', function ()  {
    return view('client');
});





