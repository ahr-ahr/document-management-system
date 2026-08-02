<?php

namespace App\Services\Security;

use App\Models\SecurityLog;
use Illuminate\Http\Request;

class SecurityLogService
{
    public function record(
        string $eventType,
        ?int $userId = null,
        string $severity = 'info',
        ?array $metadata = null,
    ): SecurityLog {
        return SecurityLog::create([
            'user_id' => $userId,
            'event_type' => $eventType,
            'severity' => $severity,

            'ip_address' => request()->ip() ?? '0.0.0.0',
            'endpoint' => request()->path(),
            'http_method' => request()->method(),
            'status_code' => http_response_code(),

            'user_agent' => request()->userAgent(),

            'metadata' => $metadata,
        ]);
    }
}