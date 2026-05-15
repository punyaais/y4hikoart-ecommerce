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
        Schema::create('order_characters', function (Blueprint $table) {
            $table->id('character_id');
            $table->unsignedBigInteger('order_id');

            $table->enum('character_category', ['original', 'fanart']);
            $table->text('character_detail');

            $table->unsignedBigInteger('background_option_id')->nullable();
            $table->text('background_detail')->nullable();

            $table->integer('extra_price')->default(0);
            $table->integer('extra_duration')->default(0);

            $table->foreign('order_id')->references('order_id')->on('orders')->onDelete('cascade');
            $table->foreign('background_option_id')->references('id')->on('background_options')->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('order_characters');
    }
};
