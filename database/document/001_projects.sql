BEGIN;

CREATE TABLE IF NOT EXISTS document.projects (
    id BIGINT GENERATED ALWAYS AS IDENTITY,

    uuid UUID NOT NULL DEFAULT uuidv7(),

    user_id BIGINT NOT NULL,

    project_code VARCHAR(50) NOT NULL,

    project_name VARCHAR(255) NOT NULL,

    description TEXT,

    current_status_id BIGINT NOT NULL,

    submitted_at TIMESTAMPTZ,

    approved_at TIMESTAMPTZ,

    rejected_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    deleted_at TIMESTAMPTZ,

    CONSTRAINT pk_projects
        PRIMARY KEY (id),

    CONSTRAINT uq_projects_uuid
        UNIQUE (uuid),

    CONSTRAINT uq_projects_project_code
        UNIQUE (project_code),

    CONSTRAINT fk_projects_user
        FOREIGN KEY (user_id)
        REFERENCES core.users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_projects_current_status
        FOREIGN KEY (current_status_id)
        REFERENCES master.master_document_statuses(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

COMMENT ON TABLE document.projects IS
'Stores document submission projects created by applicants.';

COMMENT ON COLUMN document.projects.id IS
'Internal primary key.';

COMMENT ON COLUMN document.projects.uuid IS
'Public unique identifier (UUID v7).';

COMMENT ON COLUMN document.projects.user_id IS
'Applicant who owns the project.';

COMMENT ON COLUMN document.projects.project_code IS
'Unique project code.';

COMMENT ON COLUMN document.projects.project_name IS
'Project name.';

COMMENT ON COLUMN document.projects.description IS
'Project description.';

COMMENT ON COLUMN document.projects.current_status_id IS
'Current project status.';

COMMENT ON COLUMN document.projects.submitted_at IS
'Timestamp when the project was submitted.';

COMMENT ON COLUMN document.projects.approved_at IS
'Timestamp when the project was approved.';

COMMENT ON COLUMN document.projects.rejected_at IS
'Timestamp when the project was rejected.';

COMMENT ON COLUMN document.projects.created_at IS
'Record creation timestamp.';

COMMENT ON COLUMN document.projects.updated_at IS
'Record last update timestamp.';

COMMENT ON COLUMN document.projects.deleted_at IS
'Soft delete timestamp.';

COMMIT;
