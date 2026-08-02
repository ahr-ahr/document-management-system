<?php

use App\Support\Response\ApiResponse;
use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use Throwable;

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