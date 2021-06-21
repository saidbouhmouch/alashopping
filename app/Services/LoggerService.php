<?php

namespace App\Services;
use \Symfony\Component\Console\Output\ConsoleOutput;


class LoggerService{

    public static function writeln($arg)
    {
        $out = new ConsoleOutput();
        $out->writeln($arg);
    }

}