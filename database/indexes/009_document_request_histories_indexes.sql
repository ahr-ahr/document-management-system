BEGIN;

CREATE INDEX IF NOT EXISTS ix_document_request_histories_document_request_id
ON audit.document_request_histories (document_request_id);

CREATE INDEX IF NOT EXISTS ix_document_request_histories_actor_id
ON audit.document_request_histories (actor_id);

CREATE INDEX IF NOT EXISTS ix_document_request_histories_action
ON audit.document_request_histories (action);

CREATE INDEX IF NOT EXISTS ix_document_request_histories_created_at
ON audit.document_request_histories (created_at);

CREATE INDEX IF NOT EXISTS ix_document_request_histories_request_created
ON audit.document_request_histories (
    document_request_id,
    created_at DESC
);

COMMIT;
