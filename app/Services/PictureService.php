<?php

namespace App\Services;
use App\Models\Storage;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Intervention\Image\ImageManagerStatic as Image;
class PictureService{


    public static function store($destination,$file,$name)
    {
            $filename = '';
            $image = Image::make($file);
            $filename = self::file_newname($destination,Str::slug($name, '-'),'jpg');
            \Storage::disk('public')->put(env('APP_STORAGE').'/'.$destination.'/'. $filename, $image->stream());
            $filename=env('APP_STORAGE').'/'.$destination.'/'. $filename;
            return $filename;
    }

    public static function resize($file_id,$file,$fileName,$fileType,$destination,$sizes){
         // array size=[{type : sm , size : }]  xs=320 , sm=600 , md=800 , lg= 1000, xl=1200

         foreach ($sizes as $key => $size) {
            
            $url = '';
            $file = Image::make($file)->resize($size['size'], null, function($constraint) {
                    $constraint->aspectRatio();
            });
            $url = self::file_newname($destination,Str::slug($fileName, '-'),'jpg');;
            \Storage::disk('public')->put(env('APP_STORAGE').'/'.$destination.'/'.$url, $file->stream());
            $url=env('APP_STORAGE').'/'.$destination.'/'.$url;

            $image = new Storage();
            $image->parent_id=$file_id;
            $image->name=$fileName;
            $image->url=$url;
            $image->type=$fileType;// img video 
            $image->size= $size['type'];// sm md
            $image->save();
         }

    }


    public static function save($file,$fileName,$fileType,$destination,$sizes)
    {
        
           if (!Str::startsWith($file, 'data:image')) {
                $file= Str::replaceFirst('/', '', $file);
            }
            
            $image          = new Storage();
            $image->name    = $fileName;
            $image->url     = self::store($destination,$file,$fileName);
            $image->type    = $fileType;// img video 
            $image->size    = 'default'; // sm md  default MD
            $image->save();
            $image_id=$image->id;
            self::resize($image_id,$file,$fileName,$fileType,$destination,$sizes);
        //     self::deleteWithUrl($file);
            return $image_id;
    }

    public static function delete($id){

            $image     = Storage::findOrFail($id);
            if(\Storage::disk('public')->exists($image->url)){
                \Storage::disk('public')->delete($image->url); 
            }
          
            $image->delete();
    }

    public static function deleteWithUrl($url){
                
                // $url= Str::replaceFirst('/', '',$url);
                if(\Storage::disk('public')->exists($url)){
                    \Storage::disk('public')->delete($url); 
                }
    }

    public static function file_newname($destination,$name,$ext){

        $newpath = $destination.'/'.$name.'.'.$ext;
        $newname = $name.'.'.$ext;
        $counter = 0;
        while (\Storage::disk('public')->exists(env('APP_STORAGE').'/'.$newpath)) {
               $newname = $name .'-'.$counter.'.'.$ext;
               $newpath = $destination.'/'.$newname;
               $counter++;
         }
    
        return $newname;
    }

}



