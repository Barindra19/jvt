<?php

namespace App\Modules\Opentrip\Models;

use Illuminate\Database\Eloquent\Model;

class OpenTrip extends Model
{
    public function tour(){
        return $this->hasOne('App\Modules\Tour\Models\Tour','id','tour_id');
    }

    public function open_trip_quota(){
        return $this->hasMany('App\Modules\Opentrip\Models\OpenTripQuota','open_trip_id','id');
    }
}
