<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Weight extends Model
{
    protected $table = 'weights';

    protected $fillable = ['weight'];
    public function products()
    {
        return $this->belongsToMany('App\Product');
    }
}
