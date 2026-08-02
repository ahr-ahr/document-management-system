<?php

use Illuminate\Http\Request;
use App\Support\Response\ApiResponse;
use Illuminate\Support\Facades\Route;
use App\Services\Health\HealthCheckService;
use App\Http\Controllers\AuthController;

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

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::get('/health', function (HealthCheckService $health) {

    return ApiResponse::success(
        data: [
            ...$health->check(),
            'timestamp' => now(),
        ],
        message: 'Application is healthy.',
    );

});