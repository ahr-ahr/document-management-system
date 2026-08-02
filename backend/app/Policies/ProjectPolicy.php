<?php

namespace App\Policies;

use App\Constants\Role;
use App\Models\Document\Project;
use App\Models\User;

class ProjectPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->hasAnyRole([
            Role::PEMOHON,
            Role::PENILAI,
            Role::ADMINISTRATOR,
        ]);
    }


    public function view(
        User $user,
        Project $project,
    ): bool {
        return $user->hasRole(Role::ADMINISTRATOR)
            || $user->id === $project->user_id;
    }


    public function create(User $user): bool
    {
        return $user->hasRole(Role::PEMOHON);
    }


    public function update(
        User $user,
        Project $project,
    ): bool {
        return $user->id === $project->user_id
            && $project->status?->code === 'DRAFT';
    }


    public function delete(
        User $user,
        Project $project,
    ): bool {
        return $user->id === $project->user_id
            && $project->status?->code === 'DRAFT';
    }


    public function restore(
        User $user,
        Project $project,
    ): bool {
        return $user->hasRole(Role::ADMINISTRATOR);
    }


    public function forceDelete(
        User $user,
        Project $project,
    ): bool {
        return $user->hasRole(Role::ADMINISTRATOR);
    }
}