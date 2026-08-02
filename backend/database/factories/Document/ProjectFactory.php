<?php

namespace Database\Factories\Document;

use App\Models\Document\Project;
use App\Models\Master\DocumentStatus;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

class ProjectFactory extends Factory
{
    protected $model = Project::class;


    public function definition(): array
    {
        return [
            'uuid' => Str::uuid(),

            'user_id' => User::factory(),

            'project_code' => 'PRJ-TEST-' . fake()->unique()->numberBetween(10000, 99999),

            'project_name' => fake()->sentence(),

            'description' => fake()->paragraph(),

            'current_status_id' => DocumentStatus::where(
                'code',
                'DRAFT'
            )->value('id'),

            'submitted_at' => null,

            'approved_at' => null,

            'rejected_at' => null,
        ];
    }
}