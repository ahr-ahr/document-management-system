BEGIN;

CREATE INDEX IF NOT EXISTS ix_document_requests_project_id
ON document.document_requests (project_id);

CREATE INDEX IF NOT EXISTS ix_document_requests_current_status_id
ON document.document_requests (current_status_id);

CREATE INDEX IF NOT EXISTS ix_document_requests_submitted_at
ON document.document_requests (submitted_at);

CREATE INDEX IF NOT EXISTS ix_document_requests_created_at
ON document.document_requests (created_at);

CREATE INDEX IF NOT EXISTS ix_document_requests_deleted_at
ON document.document_requests (deleted_at);

CREATE INDEX IF NOT EXISTS ix_document_requests_project_status
ON document.document_requests (
    project_id,
    current_status_id
);

COMMIT;
