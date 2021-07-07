<?php

use Illuminate\Database\Seeder;
use App\Models\OrderStatus;

class OrderStatusesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        //OrderStatus::delete();
    
        
        
    	$orderStatuses = [
    		[
                'name'  => 'Pending',
                'slug'  => 'pending',
    		],
            [
                'name'  => 'Shipped',
                'slug'  => 'shipped',
            ],
            [
                'name'  => 'Processing',
                'slug'  => 'processing'
            ],
            [
                'name'  => 'Cancelled',
                'slug'  => 'cancelled'
            ],
            [
                'name'  => 'Failed',
                'slug'  => 'failed'
            ],
            [
                'name'  => 'Done',
                'slug'  => 'done',
            ]
    	];

      

    	OrderStatus::insert($orderStatuses);
    }
}
