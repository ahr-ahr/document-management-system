<?php

namespace App\Services\Document;

use App\Models\Document\Project;
use App\Models\Master\DocumentStatus;
use Illuminate\Support\Facades\DB;

class ProjectService
{
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


        return $project->load([
            'status',
            'applicant',
        ]);
    }
}