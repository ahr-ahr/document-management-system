<?php

namespace App\Models\Document;

use App\Models\User;
use App\Models\Master\DocumentStatus;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Project extends Model
{
    use SoftDeletes;

    protected $table = 'document.projects';


    protected $fillable = [
        'user_id',
        'project_code',
        'project_name',
        'description',
        'current_status_id',
        'submitted_at',
        'approved_at',
        'rejected_at',
    ];


    protected function casts(): array
    {
        return [
            'submitted_at' => 'datetime',
            'approved_at' => 'datetime',
            'rejected_at' => 'datetime',
            'deleted_at' => 'datetime',
        ];
    }


    public function applicant()
    {
        return $this->belongsTo(
            User::class,
            'user_id'
        );
    }


    public function status()
    {
        return $this->belongsTo(
            DocumentStatus::class,
            'current_status_id'
        );
    }

    public function getRouteKeyName(): string
    {
        return 'uuid';
    }
}