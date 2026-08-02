<?php

namespace App\Services\Security;

use App\Models\SecurityLog;

class SecurityLogService
{
    public function record(
        string $eventType,
        ?int $userId = null,
        string $severity = 'info',
        ?array $metadata = null,
        ?int $statusCode = null,
    ): SecurityLog {
        return SecurityLog::create([
            'user_id' => $userId,
            'event_type' => $eventType,
            'severity' => $severity,

            'ip_address' => request()->ip() ?? '0.0.0.0',
            'endpoint' => request()->path(),
            'http_method' => request()->method(),

            'status_code' => $statusCode,

            'user_agent' => request()->userAgent(),

            'metadata' => $metadata,
        ]);
    }
}