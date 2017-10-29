<?php

namespace App\Modules\Includes\Models;

use Illuminate\Database\Eloquent\Model;

class Includes extends Model
{
    protected $table = 'includes';
    protected $connection;

    public function __construct(array $attributes = [])
    {
        $this->connection = env('DB_CONNECTION', 'mysql');
        parent::__construct($attributes);
    }

}
