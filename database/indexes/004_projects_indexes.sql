BEGIN;

CREATE INDEX IF NOT EXISTS ix_projects_user_id
ON document.projects (user_id);

CREATE INDEX IF NOT EXISTS ix_projects_current_status_id
ON document.projects (current_status_id);

CREATE INDEX IF NOT EXISTS ix_projects_created_at
ON document.projects (created_at);

CREATE INDEX IF NOT EXISTS ix_projects_deleted_at
ON document.projects (deleted_at);

CREATE INDEX IF NOT EXISTS ix_projects_user_status
ON document.projects (user_id, current_status_id);

CREATE INDEX IF NOT EXISTS ix_projects_project_name_trgm
ON document.projects
USING gin (project_name gin_trgm_ops);

COMMIT;
