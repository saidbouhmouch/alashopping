<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateShippingTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('shipping', function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->charset = 'utf8';
            $table->collation = 'utf8_unicode_ci';
            $table->id();
            
            $table->integer('from')->unsigned()->nullable();
            $table->foreign('from')->references('id')->on('countries')->onDelete('SET NULL');

            $table->integer('to')->unsigned()->nullable();
            $table->foreign('to')->references('id')->on('countries')->onDelete('SET NULL');


            $table->integer('carrier_id')->unsigned()->nullable();
            $table->foreign('carrier_id')->references('id')->on('carriers')->onDelete('SET NULL');

            $table->integer('currency_id')->unsigned()->nullable();
            $table->foreign('currency_id')->references('id')->on('currencies') ->onDelete('SET NULL');


            $table->integer('estimated_delivery_min');
            $table->integer('estimated_delivery_max');

            $table->float('price')->default(0);

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('shipping');
    }
}
