BEGIN;

CREATE INDEX IF NOT EXISTS ix_document_request_reviews_document_request_id
ON document.document_request_reviews (document_request_id);

CREATE INDEX IF NOT EXISTS ix_document_request_reviews_reviewer_id
ON document.document_request_reviews (reviewer_id);

CREATE INDEX IF NOT EXISTS ix_document_request_reviews_review_result
ON document.document_request_reviews (review_result);

CREATE INDEX IF NOT EXISTS ix_document_request_reviews_reviewed_at
ON document.document_request_reviews (reviewed_at);

CREATE INDEX IF NOT EXISTS ix_document_request_reviews_request_reviewed
ON document.document_request_reviews (
    document_request_id,
    reviewed_at DESC
);

COMMIT;
