<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SecurityLog extends Model
{
    protected $table = 'security.security_logs';

    public $timestamps = false;

    protected $fillable = [
        'user_id',
        'event_type',
        'severity',
        'ip_address',
        'endpoint',
        'http_method',
        'status_code',
        'user_agent',
        'metadata',
    ];

    protected $casts = [
        'metadata' => 'array',
        'created_at' => 'datetime',
    ];
}