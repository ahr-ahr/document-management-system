<?php

namespace App\Support\Response;

use Illuminate\Http\JsonResponse;
use Symfony\Component\HttpFoundation\Response;

class ApiResponse
{
    /**
     * Success response.
     */
    public static function success(
        mixed $data = null,
        string $message = 'Success.',
        int $status = Response::HTTP_OK,
        ?array $meta = null,
    ): JsonResponse {
        return response()->json([
            'success' => true,
            'message' => $message,
            'data' => $data,
            'meta' => $meta,
        ], $status);
    }

    /**
     * 201 Created.
     */
    public static function created(
        mixed $data = null,
        string $message = 'Resource created successfully.',
        ?array $meta = null,
    ): JsonResponse {
        return self::success(
            data: $data,
            message: $message,
            status: Response::HTTP_CREATED,
            meta: $meta,
        );
    }

    /**
     * 202 Accepted.
     */
    public static function accepted(
        mixed $data = null,
        string $message = 'Request accepted.',
        ?array $meta = null,
    ): JsonResponse {
        return self::success(
            data: $data,
            message: $message,
            status: Response::HTTP_ACCEPTED,
            meta: $meta,
        );
    }

    /**
     * 204 No Content.
     */
    public static function noContent(): JsonResponse
    {
        return response()->noContent();
    }

    /**
     * Error response.
     */
    public static function error(
        string $message = 'Error.',
        int $status = Response::HTTP_INTERNAL_SERVER_ERROR,
        mixed $errors = null,
        ?array $meta = null,
    ): JsonResponse {
        return response()->json([
            'success' => false,
            'message' => $message,
            'errors' => $errors,
            'meta' => $meta,
        ], $status);
    }

    /**
     * 400 Bad Request.
     */
    public static function badRequest(
        string $message = 'Bad request.',
        mixed $errors = null,
    ): JsonResponse {
        return self::error(
            message: $message,
            status: Response::HTTP_BAD_REQUEST,
            errors: $errors,
        );
    }

    /**
     * 401 Unauthorized.
     */
    public static function unauthorized(
        string $message = 'Unauthorized.',
    ): JsonResponse {
        return self::error(
            message: $message,
            status: Response::HTTP_UNAUTHORIZED,
        );
    }

    /**
     * 403 Forbidden.
     */
    public static function forbidden(
        string $message = 'Forbidden.',
    ): JsonResponse {
        return self::error(
            message: $message,
            status: Response::HTTP_FORBIDDEN,
        );
    }

    /**
     * 404 Not Found.
     */
    public static function notFound(
        string $message = 'Resource not found.',
    ): JsonResponse {
        return self::error(
            message: $message,
            status: Response::HTTP_NOT_FOUND,
        );
    }

    /**
     * 409 Conflict.
     */
    public static function conflict(
        string $message = 'Conflict.',
    ): JsonResponse {
        return self::error(
            message: $message,
            status: Response::HTTP_CONFLICT,
        );
    }

    /**
     * 422 Validation Error.
     */
    public static function validation(
        mixed $errors,
        string $message = 'Validation failed.',
    ): JsonResponse {
        return self::error(
            message: $message,
            status: Response::HTTP_UNPROCESSABLE_ENTITY,
            errors: $errors,
        );
    }

    /**
     * 429 Too Many Requests.
     */
    public static function tooManyRequests(
        string $message = 'Too many requests.',
    ): JsonResponse {
        return self::error(
            message: $message,
            status: Response::HTTP_TOO_MANY_REQUESTS,
        );
    }

    /**
     * 500 Internal Server Error.
     */
    public static function serverError(
        string $message = 'Internal server error.',
    ): JsonResponse {
        return self::error(
            message: $message,
            status: Response::HTTP_INTERNAL_SERVER_ERROR,
        );
    }
}