<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Block extends Model
{
    public $table = 'blocks';
    public $fillable = ['name'];
}
