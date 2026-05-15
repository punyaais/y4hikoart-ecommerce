<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('payments', function (Blueprint $table) {
            $table->id();

            // FK ke orders
            $table->foreignId('order_id')
                ->constrained('orders', 'order_id')
                ->cascadeOnDelete();

            $table->string('payment_method')->nullable(); 
            $table->string('payment_status')->default('pending'); 
            $table->string('transaction_id')->nullable();

            $table->integer('amount');

            $table->timestamp('paid_at')->nullable();

            // midtrans ready
            $table->string('snap_token')->nullable();
            $table->string('payment_url')->nullable();

            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('payments');
    }
};