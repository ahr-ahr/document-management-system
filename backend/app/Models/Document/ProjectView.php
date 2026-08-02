<?php

namespace App\Models\Document;

use Illuminate\Database\Eloquent\Model;

class ProjectView extends Model
{
    protected $table = 'document.vw_projects';


    protected $primaryKey = 'id';


    public $timestamps = false;


    protected $guarded = [];


    protected function casts(): array
    {
        return [
            'submitted_at' => 'datetime',
            'approved_at' => 'datetime',
            'rejected_at' => 'datetime',
            'created_at' => 'datetime',
            'updated_at' => 'datetime',
        ];
    }
}