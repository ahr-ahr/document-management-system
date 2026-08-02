BEGIN;

CREATE TABLE IF NOT EXISTS document.document_requests (
    id BIGINT GENERATED ALWAYS AS IDENTITY,

    uuid UUID NOT NULL DEFAULT uuidv7(),

    project_id BIGINT NOT NULL,

    request_number VARCHAR(50) NOT NULL,

    current_status_id BIGINT NOT NULL,

    submission_note TEXT,

    submitted_at TIMESTAMPTZ,

    reviewed_at TIMESTAMPTZ,

    approved_at TIMESTAMPTZ,

    rejected_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    deleted_at TIMESTAMPTZ,

    CONSTRAINT pk_document_requests
        PRIMARY KEY (id),

    CONSTRAINT uq_document_requests_uuid
        UNIQUE (uuid),

    CONSTRAINT uq_document_requests_request_number
        UNIQUE (request_number),

    CONSTRAINT fk_document_requests_project
        FOREIGN KEY (project_id)
        REFERENCES document.projects(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_document_requests_current_status
        FOREIGN KEY (current_status_id)
        REFERENCES master.master_document_statuses(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

COMMENT ON TABLE document.document_requests IS
'Stores document submission requests for each project.';

COMMENT ON COLUMN document.document_requests.id IS
'Internal primary key.';

COMMENT ON COLUMN document.document_requests.uuid IS
'Public unique identifier (UUID v7).';

COMMENT ON COLUMN document.document_requests.project_id IS
'Related project.';

COMMENT ON COLUMN document.document_requests.request_number IS
'Unique document request number.';

COMMENT ON COLUMN document.document_requests.current_status_id IS
'Current document request status.';

COMMENT ON COLUMN document.document_requests.submission_note IS
'Applicant submission note.';

COMMENT ON COLUMN document.document_requests.submitted_at IS
'Timestamp when the request was submitted.';

COMMENT ON COLUMN document.document_requests.reviewed_at IS
'Timestamp when the request was reviewed.';

COMMENT ON COLUMN document.document_requests.approved_at IS
'Timestamp when the request was approved.';

COMMENT ON COLUMN document.document_requests.rejected_at IS
'Timestamp when the request was rejected.';

COMMENT ON COLUMN document.document_requests.created_at IS
'Record creation timestamp.';

COMMENT ON COLUMN document.document_requests.updated_at IS
'Record last update timestamp.';

COMMENT ON COLUMN document.document_requests.deleted_at IS
'Soft delete timestamp.';

COMMIT;
