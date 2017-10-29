<?php

namespace App\Modules\Opentrip\Models;

use Illuminate\Database\Eloquent\Model;

class OpenTripQuota extends Model
{
    public function tour_class(){
        return $this->hasOne('App\Modules\Classtour\Models\ClassTour','id','class_tour_id');
    }
}
