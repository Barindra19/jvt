<?php

namespace App\Modules\Komisi\Models;

use Illuminate\Database\Eloquent\Model;

class Komisi extends Model
{
    public function level(){
        return $this->hasOne('App\Modules\Level\Models\Level','id','level_id');
    }

    public function levels(){
        return $this->hasOne('App\Modules\Level\Models\Level','id','level');
    }

}
