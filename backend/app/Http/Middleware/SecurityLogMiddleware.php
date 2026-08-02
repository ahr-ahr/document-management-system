<?php

namespace App\Http\Middleware;

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


        $this->securityLog->record(
            eventType: 'HTTP_REQUEST',
            userId: auth()->id(),
            metadata: [
                'endpoint' => $request->path(),
                'method' => $request->method(),
                'status' => $response->getStatusCode(),
            ],
        );


        return $response;
    }
}