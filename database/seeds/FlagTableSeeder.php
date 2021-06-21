<?php

use Illuminate\Database\Seeder;
use App\Models\Storage;
use Illuminate\Support\Str;

class FlagTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
    

        $files = \Storage::disk('public')->allFiles('img/flag/');
        foreach ($files as $key => $value)
        {
            $name=Str::replaceLast('.png', '',$value);
            $name=Str::replaceLast('img/flag/', '',$name);
          if(!Storage::where('name',$name)->exists()){
                $image = new Storage();
                $image ->name  =   $name;
                $image ->url   =   $value;
                $image ->type  =   'image';
                $image ->size  =  'xs' ;   
                $image ->save();
          }
        }

             
    }
}
