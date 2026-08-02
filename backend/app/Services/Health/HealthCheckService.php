<?php

namespace App\Services\Health;

use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Queue;
use Illuminate\Support\Facades\Redis;
use Illuminate\Support\Facades\Storage;

class HealthCheckService
{
    public function check(): array
    {
        return [
            'application' => [
                'status' => 'UP',
            ],

            'database' => $this->checkDatabase(),

            'redis' => $this->checkRedis(),

            'cache' => $this->checkCache(),

            'queue' => $this->checkQueue(),

            'storage' => $this->checkStorage(),
        ];
    }


    private function checkDatabase(): array
    {
        try {
            DB::connection()->getPdo();

            return [
                'status' => 'UP',
            ];
        } catch (\Throwable $e) {
            return [
                'status' => 'DOWN',
                'message' => 'Service unavailable.',
            ];
        }
    }


    private function checkRedis(): array
    {
        try {
            Redis::ping();

            return [
                'status' => 'UP',
            ];
        } catch (\Throwable $e) {
            return [
                'status' => 'DOWN',
                'message' => 'Service unavailable.',
            ];
        }
    }


    private function checkCache(): array
    {
        try {
            Cache::put('health_check', true, 10);

            return [
                'status' => Cache::get('health_check')
                    ? 'UP'
                    : 'DOWN',
            ];
        } catch (\Throwable $e) {
            return [
                'status' => 'DOWN',
                'message' => 'Service unavailable.',
            ];
        }
    }


    private function checkQueue(): array
    {
        try {
            Queue::size('default');

            return [
                'status' => 'UP',
            ];
        } catch (\Throwable $e) {
            return [
                'status' => 'DOWN',
                'message' => 'Service unavailable.',
            ];
        }
    }


    private function checkStorage(): array
    {
        try {
            Storage::disk()->exists('.health-check');

            return [
                'status' => 'UP',
            ];
        } catch (\Throwable $e) {
            return [
                'status' => 'DOWN',
                'message' => 'Service unavailable.',
            ];
        }
    }
}