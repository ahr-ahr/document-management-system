<?php

namespace App\Http\Middleware;

use App\Enums\SecuritySeverity;
use App\Services\Security\SecurityLogService;
use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class SecurityLogMiddleware
{
    public function __construct(
        protected SecurityLogService $securityLog,
    ) {
    }


    public function handle(
        Request $request,
        Closure $next,
    ): Response {

        $response = $next($request);


        $statusCode = $response->getStatusCode();


        $severity = match (true) {

            $statusCode >= 500 =>
                SecuritySeverity::ERROR->value,


            $statusCode >= 400 =>
                SecuritySeverity::WARNING->value,


            default =>
                SecuritySeverity::INFO->value,
        };


        $this->securityLog->record(
            eventType: 'HTTP_REQUEST',
            userId: auth()->id(),
            severity: $severity,
            statusCode: $statusCode,
            metadata: [
                'endpoint' => $request->path(),
                'method' => $request->method(),
                'status' => $statusCode,
            ],
        );


        return $response;
    }
}