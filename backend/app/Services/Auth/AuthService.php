<?php

namespace App\Services\Auth;

use App\Constants\Role;
use App\Models\User;
use App\Enums\SecuritySeverity;
use App\Services\Security\SecurityLogService;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthService
{
    public function __construct(
        protected SecurityLogService $securityLog,
    ) {
    }


    public function register(array $data): array
    {
        return DB::transaction(function () use ($data) {

            $user = User::create([
                'name' => $data['name'],
                'email' => $data['email'],
                'password' => Hash::make($data['password']),
            ]);


            $user->assignRole(Role::PEMOHON);


            $token = $user
                ->createToken('api-token')
                ->plainTextToken;


            $this->securityLog->record(
                eventType: 'REGISTER_SUCCESS',
                severity: SecuritySeverity::INFO->value,
                userId: $user->id,
                metadata: [
                    'name' => $user->name,
                    'email' => $user->email,
                    'role' => Role::PEMOHON,
                ],
            );


            return [
                'user' => $user->load('roles'),
                'token' => $token,
            ];
        });
    }


    public function login(
        string $email,
        string $password,
    ): array {

        return DB::transaction(function () use (
            $email,
            $password
        ) {

            $user = User::where('email', $email)
                ->whereNull('deleted_at')
                ->first();


            if (! $user || ! Hash::check($password, $user->password)) {

                $this->securityLog->record(
                    eventType: 'LOGIN_FAILED',
                    severity: SecuritySeverity::WARNING->value,
                    metadata: [
                        'email' => $email,
                    ],
                );


                throw ValidationException::withMessages([
                    'email' => [
                        'Invalid credentials.',
                    ],
                ]);
            }


            if (! $user->is_active) {

                $this->securityLog->record(
                    eventType: 'LOGIN_FAILED',
                    userId: $user->id,
                    severity: SecuritySeverity::WARNING->value,
                    metadata: [
                        'reason' => 'inactive_account',
                    ],
                );


                throw ValidationException::withMessages([
                    'email' => [
                        'Account is inactive.',
                    ],
                ]);
            }


            $user->update([
                'last_login_at' => now(),
            ]);


            $token = $user
                ->createToken('api-token')
                ->plainTextToken;


            $this->securityLog->record(
                eventType: 'LOGIN_SUCCESS',
                severity: SecuritySeverity::INFO->value,
                userId: $user->id,
                metadata: [
                    'email' => $user->email,
                ],
            );


            return [
                'user' => $user->load('roles'),
                'token' => $token,
            ];
        });
    }


    public function logout(User $user): void
    {
        $user
            ->currentAccessToken()
            ->delete();


        $this->securityLog->record(
            eventType: 'LOGOUT_SUCCESS',
            userId: $user->id,
        );
    }
}