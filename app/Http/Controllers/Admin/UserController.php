<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Role;
use App\Models\Addresse;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

class UserController extends Controller
{
    /**
     * Display a listing Users.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
       $users = User::with(['image','addresse','roles'])->get();

       return (new Response(json_encode(["success"=>true,"users"=>$users]), 200));
                //   ->header('Content-Type', "");
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(){}

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $data =json_decode($request->data);

        if(!filter_var($data->email, FILTER_VALIDATE_EMAIL )){
            return (new Response(json_encode(["success"=>false,"error"=>true,'email'=>false,"message"=>$data->email]), 200));
        }

        if (User::where('email', $data->email)->exists()) {
            return (new Response(json_encode(["success"=>false,"error"=>true,"message"=>"Cette adresse e-mail existe déjà"]), 200));
        }

        DB::beginTransaction();

        /**
         *  user
         *
        */

           $user                      = new User();
           $user->first_name          = $data->firstName;      
           $user->last_name           = $data->lastName;     
           $user->email               = $data->email; 
           $user->email_verified_at   = 0  ;             
           $user->password            = Hash::make($data->password);    
           $user->gender              = ($data->gender == 'MALE')? 'femme' : 'homme'; 
           $user->phone               = $data->phone; 
           $user->active              = 0 ;
           $pictureName = ($data->picture->name == '')?'AVATAR': $data->picture->name ;
           $user->image_id            = \PictureService::save($data->picture->url,$pictureName,'image','users',[]);
           $user->save();

        /**
         *   role
         *
        */

        $user->roles()->attach($data->role->id);

        /**
         *  address 
         *
        */

         $addresse              = new Addresse();
         $addresse->addresse    = $data->addresse->addresse;
         $addresse->country_id  = $data->addresse->country->id;
         $addresse->city        = $data->addresse->city;
         $addresse->zipcode     = $data->addresse->zipcode;
         $addresse->type        = (isset($data->addresse->type))? $data->addresse->type : 'billing'; //  enum['shipping','billing']
         $addresse->user_id     = $user->id;
         $addresse->save();
         

        DB::commit();
        return (new Response(json_encode(["success"=>true,"error"=>false,"message"=>"Enregistrement a été effectué avec succès"]), 200));


    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id){}

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $user     = User::findOrFail($id);
        $picture  = $user->image;
        $roles  = $user->roles;
        $addresse = Addresse::with(['country'])->where('user_id',$id)->where('type','billing')->first();  //'shipping','billing'
        $user     = $user->makeHidden(['addresse', 'image','roles']);
       return (new Response(json_encode(["success"=>true,"user"=>$user,'picture'=>$picture,'addresse'=>$addresse,'roles'=>$roles]), 200));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $data =json_decode($request->data);

        if(!filter_var($data->email, FILTER_VALIDATE_EMAIL )){
            return (new Response(json_encode(["success"=>false,"error"=>true,'email'=>false,"message"=>$data->email]), 200));
        }

        if (User::where('email', $data->email)->where('id','!=',$id)->exists()) {
            return (new Response(json_encode(["success"=>false,"error"=>true,"message"=>"Cette adresse e-mail existe déjà"]), 200));
        }

        DB::beginTransaction();

        /**
         *  user
         *
        */

           $user                      = User::findOrFail($id);
           $user->first_name          = $data->firstName;      
           $user->last_name           = $data->lastName;     
           $user->email               = $data->email; 
           $user->email_verified_at   = 0  ;             
           $user->gender              = ($data->gender == 'MALE')? 'femme' : 'homme'; 
           $user->phone               = $data->phone; 
           $user->active              = 0 ;
           $pictureName = ($data->picture->name == '')?'AVATAR': $data->picture->name ;
           if ($data->picture->update) {
               $user->image_id = \PictureService::save($data->picture->url,$pictureName,'image','users',[]);
           }
           $user->update();

        /**
         *   role
         *
        */

        $user->roles()->detach();
        $user->roles()->attach($data->role->id);

        /**
         *  address 
         *
        */

         $addresse              = Addresse::findOrFail($data->addresse->id);
         $addresse->addresse    = $data->addresse->addresse;
         $addresse->country_id  = $data->addresse->country->id;
         $addresse->city        = $data->addresse->city;
         $addresse->zipcode     = $data->addresse->zipcode;
         $addresse->update();
         

        DB::commit();
        return (new Response(json_encode(["success"=>true,"error"=>false,"message"=>"Enregistrement a été effectué avec succès"]), 200));

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        DB::beginTransaction();
        $user     = User::findOrFail($id);
        $image_id =  $user->image_id;
        $user->roles()->detach();
        Addresse::where('user_id',$id)->delete();
        $user->delete();
        \PictureService::delete($image_id);
        DB::commit();
        return (new Response(json_encode(["success"=>true,"error"=>false,"message"=>"Suppression a été effectué avec succès"]), 200));

    }
}
