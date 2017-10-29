<?php

namespace App\Modules\Country\Models;

use Illuminate\Database\Eloquent\Model;

class Country extends Model
{
    protected $table = 'countrys';
    protected $connection;

    public function __construct(array $attributes = [])
    {
        $this->connection = env('DB_CONNECTION', 'mysql');
        parent::__construct($attributes);
    }

}
