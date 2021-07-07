<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateOrdersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('orders', function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->charset = 'utf8';
            $table->collation = 'utf8_unicode_ci';

            $table->bigIncrements('id');

            $table->bigInteger('user_id')->unsigned()->nullable();
            $table->foreign('user_id')->references('id')->on('users')->onDelete('SET NULL');

            $table->integer('order_status_id')->unsigned()->nullable();
            $table->foreign('order_status_id')->references('id')->on('order_status')->onDelete('SET NULL');
            
            $table->bigInteger('shipping_id')->unsigned()->nullable();
            $table->foreign('shipping_id')->references('id')->on('shipping')->onDelete('SET NULL');

            $table->bigInteger('billing_address_id')->unsigned()->nullable();
            $table->foreign('billing_address_id')->references('id')->on('addresses')->onDelete('SET NULL');

            $table->bigInteger('shipping_address_id')->unsigned()->nullable();
            $table->foreign('shipping_address_id')->references('id')->on('addresses')->onDelete('SET NULL');

            $table->integer('currency_id')->unsigned()->nullable();
            $table->foreign('currency_id')->references('id')->on('currencies') ->onDelete('SET NULL');

            $table->integer('type_payment_id')->unsigned()->nullable();
            $table->foreign('type_payment_id')->references('id')->on('type_payment') ->onDelete('SET NULL');

            $table->longText('comment')->nullable()->default(null);
            $table->dateTime('date_order')->nullable()->default(null);
            $table->dateTime('delivery_date')->nullable()->default(null);
            $table->decimal('total_discount')->nullable()->default(0);
            $table->decimal('total_shipping')->nullable()->default(0);
            $table->decimal('total_tax')->nullable()->default(0);
            $table->decimal('total')->nullable()->default(0);

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
        Schema::dropIfExists('orders');
    }
}
