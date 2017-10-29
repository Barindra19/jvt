<?php

namespace App\Modules\Tour\Models;

use Illuminate\Database\Eloquent\Model;

class Tour extends Model
{
    public function tour_banner(){
        return $this->hasMany('App\Modules\Tour\Models\TourBanner','tour_id','id');
    }

    public function tour_banner_one(){
        return $this->hasOne('App\Modules\Tour\Models\TourBanner','tour_id','id');
    }

    public function region(){
        return $this->hasOne('App\Modules\Region\Models\Region','id','region_id');
    }

    public function country(){
        return $this->hasOne('App\Modules\Country\Models\Country','id','country_id');
    }

    public function destination(){
        return $this->hasOne('App\Modules\Destination\Models\Destination','id','destination_id');
    }

    public function open_trip(){
        return $this->hasMany('App\Modules\Opentrip\Models\OpenTrip','tour_id','id');
    }

}
