<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('orders', function (Blueprint $table) {
            $table->id('order_id');
            $table->unsignedBigInteger('user_id');
            $table->unsignedBigInteger('product_id');
            $table->unsignedBigInteger('payment_id')->nullable();

            $table->dateTime('order_date')->useCurrent();
            $table->dateTime('start_date')->nullable();
            $table->dateTime('finish_estimated')->nullable();

            $table->enum('progress_stage', [
                'Sketch Phase',
                'Sketch Approve',
                'Payment Pending',
                'Payment Receive',
                'Lineart Phase',
                'Coloring/Detailing',
                'Background and Finishing',
                'Complete'
            ])->default('Sketch Phase');

            $table->integer('admin_fee')->default(0);
            $table->integer('discount_amount')->default(0);
            $table->integer('total_price');

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('orders');
    }
};
