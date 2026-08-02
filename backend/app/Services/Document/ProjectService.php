<?php

namespace App\Services\Document;

use App\Enums\SecuritySeverity;
use App\Models\Document\Project;
use App\Models\Master\DocumentStatus;
use App\Services\Security\SecurityLogService;
use Illuminate\Support\Facades\DB;

class ProjectService
{
    public function __construct(
        protected SecurityLogService $securityLog,
    ) {
    }


    public function create(
        array $data,
        int $userId,
    ): Project {

        return DB::transaction(function () use (
            $data,
            $userId
        ) {

            $draftStatus = DocumentStatus::where(
                'code',
                'DRAFT'
            )
            ->firstOrFail();


            $project = Project::create([
                'user_id' => $userId,

                'project_name' => $data['project_name'],

                'description' => $data['description'] ?? null,

                'current_status_id' => $draftStatus->id,
            ]);


            $project->refresh();


            $this->securityLog->record(
                eventType: 'PROJECT_CREATED',
                userId: $userId,
                severity: SecuritySeverity::INFO->value,
                metadata: [
                    'project_id' => $project->id,
                    'project_code' => $project->project_code,
                    'project_name' => $project->project_name,
                ],
            );


            return $project->load([
                'status',
                'applicant',
            ]);
        });
    }


    public function update(
        Project $project,
        array $data,
    ): Project {

        $project->update([
            'project_name' => $data['project_name']
                ?? $project->project_name,

            'description' => array_key_exists(
                'description',
                $data
            )
                ? $data['description']
                : $project->description,
        ]);


        $this->securityLog->record(
            eventType: 'PROJECT_UPDATED',
            userId: $project->user_id,
            severity: SecuritySeverity::INFO->value,
            metadata: [
                'project_id' => $project->id,
                'project_code' => $project->project_code,
            ],
        );


        return $project->load([
            'status',
            'applicant',
        ]);
    }
}