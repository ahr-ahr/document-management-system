<?php

use Illuminate\Http\Request;
use App\Support\Response\ApiResponse;
use Illuminate\Support\Facades\Route;
use App\Services\Health\HealthCheckService;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\Document\ProjectController;

Route::get('/health', function (HealthCheckService $health) {

    return ApiResponse::success(
        data: [
            ...$health->check(),
            'timestamp' => now(),
        ],
        message: 'Application is healthy.',
    );

});

Route::prefix('auth')->group(function () {

    Route::post('/register', [
        AuthController::class,
        'register',
    ]);

    Route::post('/login', [
        AuthController::class,
        'login',
    ]);


    Route::middleware('auth:sanctum')
        ->group(function () {

            Route::post('/logout', [
                AuthController::class,
                'logout',
            ]);

            Route::get('/me', [
                AuthController::class,
                'me',
            ]);

        });

});

Route::middleware('auth:sanctum')
    ->prefix('projects')
    ->group(function () {

        Route::post(
            '/',
            [ProjectController::class, 'store']
        );

        Route::get(
            '/{project:uuid}',
            [ProjectController::class, 'show']
        );

        Route::put(
            '/{project:uuid}',
            [ProjectController::class, 'update']
        );

    });