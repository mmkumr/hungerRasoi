<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name');
            $table->string('email')->unique();
            $table->unsignedBigInteger('phone')->nullable();
            $table->string('block')->nullable();
            $table->string('address')->nullable();
            $table->string('city')->nullable();           
            $table->string('state')->nullable();
            $table->unsignedInteger('pin_code')->nullable();
            $table->string('password');
            $table->unsignedInteger('wallet')->nullable()->default(0);
            $table->boolean('referred')->default(false);
            $table->rememberToken();
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
        Schema::dropIfExists('users');
    }
}
