BEGIN;

CREATE INDEX IF NOT EXISTS ix_document_file_versions_document_file_id
ON document.document_file_versions (document_file_id);

CREATE INDEX IF NOT EXISTS ix_document_file_versions_uploaded_by
ON document.document_file_versions (uploaded_by);

CREATE INDEX IF NOT EXISTS ix_document_file_versions_created_at
ON document.document_file_versions (created_at);

COMMIT;
