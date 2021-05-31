<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Subscriber extends Model
{
    public $table = 'subscribe';
    public $fillable = ['name','email'];
}
