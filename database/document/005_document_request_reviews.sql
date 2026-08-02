BEGIN;

CREATE TABLE IF NOT EXISTS document.document_request_reviews (
    id BIGINT GENERATED ALWAYS AS IDENTITY,

    uuid UUID NOT NULL DEFAULT uuidv7(),

    document_request_id BIGINT NOT NULL,

    reviewer_id BIGINT NOT NULL,

    review_result review_result_enum NOT NULL,

    review_notes TEXT,

    reviewed_at TIMESTAMPTZ NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT pk_document_request_reviews
        PRIMARY KEY (id),

    CONSTRAINT uq_document_request_reviews_uuid
        UNIQUE (uuid),

    CONSTRAINT fk_document_request_reviews_document_request
        FOREIGN KEY (document_request_id)
        REFERENCES document.document_requests(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_document_request_reviews_reviewer
        FOREIGN KEY (reviewer_id)
        REFERENCES core.users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

COMMENT ON TABLE document.document_request_reviews IS
'Stores review results performed by reviewers for each document request.';

COMMENT ON COLUMN document.document_request_reviews.id IS
'Internal primary key.';

COMMENT ON COLUMN document.document_request_reviews.uuid IS
'Public unique identifier (UUID v7).';

COMMENT ON COLUMN document.document_request_reviews.document_request_id IS
'Related document request.';

COMMENT ON COLUMN document.document_request_reviews.reviewer_id IS
'Reviewer who evaluated the request.';

COMMENT ON COLUMN document.document_request_reviews.review_result IS
'Result of the review.';

COMMENT ON COLUMN document.document_request_reviews.review_notes IS
'Reviewer notes or revision comments.';

COMMENT ON COLUMN document.document_request_reviews.reviewed_at IS
'Timestamp when the review was completed.';

COMMENT ON COLUMN document.document_request_reviews.created_at IS
'Record creation timestamp.';

COMMENT ON COLUMN document.document_request_reviews.updated_at IS
'Record last update timestamp.';

COMMIT;
