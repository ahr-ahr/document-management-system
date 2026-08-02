<?php

use Illuminate\Http\Request;
use App\Support\Response\ApiResponse;
use Illuminate\Support\Facades\Route;
use App\Services\Health\HealthCheckService;

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