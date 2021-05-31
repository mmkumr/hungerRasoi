<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ProductWeight extends Model
{
    protected $table = 'product_weight';
    protected $fillable = ['product_id', 'weight_id'];
}
