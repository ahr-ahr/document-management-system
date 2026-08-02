<?php

namespace App\Models\Document;

use Illuminate\Database\Eloquent\Model;

class ProjectView extends Model
{
    protected $table = 'document.vw_projects';


    public $timestamps = false;


    protected $guarded = [];
}