<?php

namespace App\Providers;
use Illuminate\Support\Facades\DB;
use \Symfony\Component\Console\Output\ConsoleOutput;


use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{


    public function boot()
    {
        view()->share('version', '?v=1');
        $out = new ConsoleOutput();
        $out->writeln("start app");

        DB::listen(function ($query) use ($out) {
            $out->writeln("------------------------");
            $out->writeln($query->sql);
            $out->writeln($query->bindings);
            $out->writeln($query->time);
            $out->writeln("------------------------");
        });
    }


    public function register()
    {
        //
    }
}
