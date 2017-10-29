<?php

namespace App\Modules\Hotoffer\Models;

use Illuminate\Database\Eloquent\Model;

class HotOffer extends Model
{
    public function tour(){
        return $this->hasOne('App\Modules\Tour\Models\Tour','id','tour_id');
    }
}
