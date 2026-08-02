<?php

use App\Support\Response\ApiResponse;
use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use Throwable;
use Spatie\Permission\Exceptions\UnauthorizedException;
use Spatie\Permission\Middleware\PermissionMiddleware;
use Spatie\Permission\Middleware\RoleMiddleware;
use Spatie\Permission\Middleware\RoleOrPermissionMiddleware;
use Illuminate\Auth\AuthenticationException;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        api: __DIR__.'/../routes/api.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware): void {

        $middleware->api([
            \App\Http\Middleware\SecurityLogMiddleware::class,
        ]);


        $middleware->alias([
            'role' => RoleMiddleware::class,
            'permission' => PermissionMiddleware::class,
            'role_or_permission' => RoleOrPermissionMiddleware::class,
        ]);

    })
    ->withExceptions(function (Exceptions $exceptions): void {

        $exceptions->render(function (
            ValidationException $e,
            Request $request,
        ) {
            if (! $request->expectsJson()) {
                return null;
            }

            return ApiResponse::validation(
                errors: $e->errors(),
            );
        });

        $exceptions->render(function (
            AuthenticationException $e,
            Request $request,
        ) {

            if (! $request->expectsJson()) {
                return null;
            }

            return ApiResponse::unauthorized(
                message: 'Unauthenticated.',
            );
        });

        $exceptions->render(function (
            UnauthorizedException $e,
            Request $request,
        ) {

            if (! $request->expectsJson()) {
                return null;
            }

            return ApiResponse::forbidden(
                message: 'You do not have permission to access this resource.',
            );
        });

        $exceptions->render(function (
            NotFoundHttpException $e,
            Request $request,
        ) {
            if (! $request->expectsJson()) {
                return null;
            }

            return ApiResponse::notFound(
                message: 'Route not found.',
            );
        });

        $exceptions->render(function (
            Throwable $e,
            Request $request,
        ) {
            report($e);

            if (! $request->expectsJson()) {
                return null;
            }

            return ApiResponse::serverError(
                message: config('app.debug')
                    ? $e->getMessage()
                    : 'Internal server error.',
            );
        });

    })
    ->create();