<?php

namespace App\Http\Controllers;

use App\Http\Requests\LoginRequest;
use App\Http\Requests\RegisterRequest;
use App\Services\Auth\AuthService;
use App\Support\Response\ApiResponse;
use Illuminate\Http\Request;

class AuthController extends Controller
{
    public function __construct(
        protected AuthService $authService,
    ) {
    }


    public function register(
        RegisterRequest $request,
    ) {
        $result = $this->authService->register(
            $request->validated(),
        );


        return ApiResponse::created(
            data: $result,
            message: 'Registration successful.',
        );
    }


    public function login(
        LoginRequest $request,
    ) {
        $result = $this->authService->login(
            email: $request->email,
            password: $request->password,
        );


        return ApiResponse::success(
            data: $result,
            message: 'Login successful.',
        );
    }


    public function logout(
        Request $request,
    ) {
        $this->authService->logout(
            $request->user(),
        );


        return ApiResponse::success(
            message: 'Logout successful.',
        );
    }


    public function me(
        Request $request,
    ) {
        return ApiResponse::success(
            data: $request
                ->user()
                ->load('roles'),
            message: 'User profile retrieved successfully.',
        );
    }
}