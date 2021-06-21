<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateProductsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('products', function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->charset = 'utf8';
            $table->collation = 'utf8_unicode_ci';

            $table->increments('id');
            $table->string('name', 255)->nullable()->default(null);
            $table->float('price')->default(0);
            $table->longText('description_short')->nullable()->default(null);
            $table->longText('description_long')->nullable()->default(null);
            $table->string('slug');
            $table->unique(["slug"], 'unique_slug_products');
            $table->string('sku');
            $table->unique(["sku"], 'unique_skus_products');

            $table->integer('stock')->nullable()->default('0');
            $table->longText('additional_information')->nullable()->default(null);
            $table->boolean('active')->default(0);
            
            $table->integer('taxe_id')->unsigned()->nullable();
            $table->foreign('taxe_id')->references('id')->on('taxes') ->onDelete('SET NULL');

            $table->integer('currency_id')->unsigned()->nullable();
            $table->foreign('currency_id')->references('id')->on('currencies') ->onDelete('SET NULL');


            $table->bigInteger('image_id')->unsigned()->nullable();
            $table->foreign('image_id')->references('id')->on('storages') ->onDelete('SET NULL');

            $table->bigInteger('user_id')->unsigned()->nullable();
            $table->foreign('user_id')->references('id')->on('users')->onDelete('SET NULL');
            
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
        Schema::dropIfExists('products');
    }
}
