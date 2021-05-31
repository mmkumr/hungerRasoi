<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class CakeWeight extends Model
{
    protected $table = 'cake_weights';
    protected $fillable = ['product_id', 'weigth_id'];
}
