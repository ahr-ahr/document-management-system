BEGIN;

CREATE INDEX IF NOT EXISTS ix_document_files_document_request_id
ON document.document_files (document_request_id);

CREATE INDEX IF NOT EXISTS ix_document_files_document_type_id
ON document.document_files (document_type_id);

CREATE INDEX IF NOT EXISTS ix_document_files_created_at
ON document.document_files (created_at);

CREATE INDEX IF NOT EXISTS ix_document_files_deleted_at
ON document.document_files (deleted_at);

COMMIT;
