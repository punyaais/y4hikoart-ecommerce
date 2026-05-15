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
        Schema::table('order_characters', function (Blueprint $table) {
            $table->unsignedBigInteger('background_id')->nullable();

            $table->foreign('background_id')
                ->references('id')
                ->on('background_options')
                ->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('order_characters', function (Blueprint $table) {
            $table->dropForeign(['background_id']);
            $table->dropColumn('background_id');
        });
    }
};
