<?php

namespace App\Services;
use App\Models\Lang;

class LangService{
    

    public static function fetchAll()
    {
            return json_encode(Lang::with(['image'])->get());
    }

    public static function getIdByCode($code)
    {
        $lang_id = Lang::where('code',$code)->firstOrFail()->id;
       return  $lang_id;
    }

}