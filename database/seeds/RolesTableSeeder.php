<?php

use Illuminate\Support\Str;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\Role;

class RolesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $role = new Role();
        $role->name = 'admin' ;
        $role->guard_name = 'api' ;
        $role->save();

        $role = new Role();
        $role->name = 'client' ;
        $role->guard_name = 'api' ;
        $role->save();


    }
}
