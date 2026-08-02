<?php

namespace App\Http\Controllers\Document;

use App\Http\Controllers\Controller;
use App\Http\Requests\Document\StoreProjectRequest;
use App\Http\Requests\Document\UpdateProjectRequest;
use App\Models\Document\Project;
use App\Services\Document\ProjectService;
use App\Support\Response\ApiResponse;
use Illuminate\Http\JsonResponse;

class ProjectController extends Controller
{
    public function __construct(
        protected ProjectService $projectService,
    ) {
    }


    public function store(
        StoreProjectRequest $request,
    ): JsonResponse {

        $this->authorize(
            'create',
            Project::class,
        );


        $project = $this->projectService->create(
            data: $request->validated(),
            userId: $request->user()->id,
        );


        return ApiResponse::success(
            data: $project,
            message: 'Project created successfully.',
        );
    }


    public function show(
        Project $project,
    ): JsonResponse {

        $this->authorize(
            'view',
            $project,
        );


        return ApiResponse::success(
            data: $project->load([
                'status',
                'applicant',
            ]),
            message: 'Project retrieved successfully.',
        );
    }


    public function update(
        UpdateProjectRequest $request,
        Project $project,
    ): JsonResponse {

        $this->authorize(
            'update',
            $project,
        );


        $project = $this->projectService->update(
            project: $project,
            data: $request->validated(),
        );


        return ApiResponse::success(
            data: $project,
            message: 'Project updated successfully.',
        );
    }
}