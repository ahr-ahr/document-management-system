<?php

namespace Tests\Feature;

use App\Constants\Role;
use App\Models\Document\Project;
use App\Models\Master\DocumentStatus;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class ProjectTest extends TestCase
{
    use RefreshDatabase;


    protected function setUp(): void
    {
        parent::setUp();

        /*
         * Karena menggunakan schema PostgreSQL custom,
         * pastikan migration/seed master tersedia.
         */
    }


    /**
     * 1. Authenticated user can create project.
     */
    public function test_authenticated_user_can_create_project(): void
    {
        $user = User::factory()->create();

        $user->assignRole(Role::PEMOHON);


        $response = $this
            ->actingAs($user, 'sanctum')
            ->postJson('/api/projects', [
                'project_name' => 'Project Test',
                'description' => 'Feature test project',
            ]);


        $response
            ->assertStatus(200)
            ->assertJson([
                'success' => true,
                'message' => 'Project created successfully.',
            ]);


        $this->assertDatabaseHas(
            'document.projects',
            [
                'user_id' => $user->id,
                'project_name' => 'Project Test',
            ],
            'pgsql'
        );
    }


    /**
     * 2. Authenticated user can view own project.
     */
    public function test_authenticated_user_can_view_own_project(): void
    {
        $user = User::factory()->create();

        $user->assignRole(Role::PEMOHON);


        $project = Project::factory()->create([
            'user_id' => $user->id,
        ]);


        $response = $this
            ->actingAs($user, 'sanctum')
            ->getJson(
                "/api/projects/{$project->uuid}"
            );


        $response
            ->assertStatus(200)
            ->assertJson([
                'success' => true,
                'message' => 'Project retrieved successfully.',
            ]);
    }


    /**
     * 3. Authenticated user can update own draft project.
     */
    public function test_authenticated_user_can_update_own_draft_project(): void
    {
        $user = User::factory()->create();

        $user->assignRole(Role::PEMOHON);


        $draft = DocumentStatus::where(
            'code',
            'DRAFT'
        )->firstOrFail();


        $project = Project::factory()->create([
            'user_id' => $user->id,
            'current_status_id' => $draft->id,
        ]);


        $response = $this
            ->actingAs($user, 'sanctum')
            ->putJson(
                "/api/projects/{$project->uuid}",
                [
                    'project_name' => 'Project Updated',
                    'description' => 'Updated description',
                ]
            );


        $response
            ->assertStatus(200)
            ->assertJson([
                'success' => true,
                'message' => 'Project updated successfully.',
            ]);


        $this->assertDatabaseHas(
            'document.projects',
            [
                'id' => $project->id,
                'project_name' => 'Project Updated',
            ],
            'pgsql'
        );
    }


    /**
     * 4. User cannot update another user's project.
     */
    public function test_user_cannot_update_another_users_project(): void
    {
        $owner = User::factory()->create();

        $owner->assignRole(Role::PEMOHON);


        $attacker = User::factory()->create();

        $attacker->assignRole(Role::PEMOHON);


        $draft = DocumentStatus::where(
            'code',
            'DRAFT'
        )->firstOrFail();


        $project = Project::factory()->create([
            'user_id' => $owner->id,
            'current_status_id' => $draft->id,
        ]);


        $response = $this
            ->actingAs($attacker, 'sanctum')
            ->putJson(
                "/api/projects/{$project->uuid}",
                [
                    'project_name' => 'Hacked Project',
                ]
            );


        $response
            ->assertStatus(403);


        $this->assertDatabaseMissing(
            'document.projects',
            [
                'id' => $project->id,
                'project_name' => 'Hacked Project',
            ],
            'pgsql'
        );
    }

    /**
     * 5. Project creation creates security log.
     */
    public function test_project_creation_creates_security_log(): void
    {
        $user = User::factory()->create();

        $user->assignRole(Role::PEMOHON);


        $response = $this
            ->actingAs($user, 'sanctum')
            ->postJson('/api/projects', [
                'project_name' => 'Audit Project',
                'description' => 'Audit testing',
            ]);


        $response->assertStatus(200);


        $this->assertDatabaseHas(
            'security.security_logs',
            [
                'event_type' => 'PROJECT_CREATED',
                'user_id' => $user->id,
            ],
            'pgsql'
        );
    }

    /**
     * 6. Unauthenticated user cannot create project.
     */
    public function test_unauthenticated_user_cannot_create_project(): void
    {
        $response = $this
            ->postJson('/api/projects', [
                'project_name' => 'Unauthorized Project',
                'description' => 'Testing',
            ]);


        $response
            ->assertStatus(401);
    }


    /**
     * 7. User without pemohon role cannot create project.
     */
    public function test_user_without_pemohon_role_cannot_create_project(): void
    {
        $user = User::factory()->create();


        $response = $this
            ->actingAs($user, 'sanctum')
            ->postJson('/api/projects', [
                'project_name' => 'Invalid Project',
                'description' => 'Testing',
            ]);


        $response
            ->assertStatus(403);
    }


    /**
     * 8. User cannot view another user's project.
     */
    public function test_user_cannot_view_another_users_project(): void
    {
        $owner = User::factory()->create();

        $owner->assignRole(Role::PEMOHON);


        $otherUser = User::factory()->create();

        $otherUser->assignRole(Role::PEMOHON);


        $project = Project::factory()->create([
            'user_id' => $owner->id,
        ]);


        $response = $this
            ->actingAs($otherUser, 'sanctum')
            ->getJson(
                "/api/projects/{$project->uuid}"
            );


        $response
            ->assertStatus(403);
    }


    /**
     * 9. User cannot update submitted project.
     */
    public function test_user_cannot_update_submitted_project(): void
    {
        $user = User::factory()->create();

        $user->assignRole(Role::PEMOHON);


        $submitted = DocumentStatus::where(
            'code',
            'SUBMITTED'
        )
        ->firstOrFail();


        $project = Project::factory()->create([
            'user_id' => $user->id,
            'current_status_id' => $submitted->id,
        ]);


        $response = $this
            ->actingAs($user, 'sanctum')
            ->putJson(
                "/api/projects/{$project->uuid}",
                [
                    'project_name' => 'Should Fail',
                ]
            );


        $response
            ->assertStatus(403);
    }


    /**
     * 10. Project update creates security log.
     */
    public function test_project_update_creates_security_log(): void
    {
        $user = User::factory()->create();

        $user->assignRole(Role::PEMOHON);


        $draft = DocumentStatus::where(
            'code',
            'DRAFT'
        )
        ->firstOrFail();


        $project = Project::factory()->create([
            'user_id' => $user->id,
            'current_status_id' => $draft->id,
        ]);


        $response = $this
            ->actingAs($user, 'sanctum')
            ->putJson(
                "/api/projects/{$project->uuid}",
                [
                    'project_name' => 'Updated For Audit',
                ]
            );


        $response
            ->assertStatus(200);


        $this->assertDatabaseHas(
            'security.security_logs',
            [
                'event_type' => 'PROJECT_UPDATED',
                'user_id' => $user->id,
            ],
            'pgsql'
        );
    }


    /**
     * 11. Project name validation required.
     */
    public function test_project_name_is_required(): void
    {
        $user = User::factory()->create();

        $user->assignRole(Role::PEMOHON);


        $response = $this
            ->actingAs($user, 'sanctum')
            ->postJson('/api/projects', [
                'description' => 'Missing project name',
            ]);


        $response
            ->assertStatus(422)
            ->assertJsonValidationErrors([
                'project_name',
            ]);
    }
}