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
        Schema::create('order_character_images', function (Blueprint $table) {
            $table->id('image_id');
            $table->unsignedBigInteger('character_id');

            $table->string('image_url');

            $table->foreign('character_id')->references('character_id')->on('order_characters')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('order_character_images');
    }
};
