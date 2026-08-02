BEGIN;

CREATE TABLE IF NOT EXISTS document.document_files (
    id BIGINT GENERATED ALWAYS AS IDENTITY,

    uuid UUID NOT NULL DEFAULT uuidv7(),

    document_request_id BIGINT NOT NULL,

    document_type_id BIGINT NOT NULL,

    current_version INTEGER NOT NULL DEFAULT 1,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    deleted_at TIMESTAMPTZ,

    CONSTRAINT pk_document_files
        PRIMARY KEY (id),

    CONSTRAINT uq_document_files_uuid
        UNIQUE (uuid),

    CONSTRAINT fk_document_files_document_request
        FOREIGN KEY (document_request_id)
        REFERENCES document.document_requests(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_document_files_document_type
        FOREIGN KEY (document_type_id)
        REFERENCES master.document_types(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT uq_document_files_request_type
        UNIQUE (
            document_request_id,
            document_type_id
        ),

    CONSTRAINT ck_document_files_current_version
        CHECK (current_version > 0)
);

COMMENT ON TABLE document.document_files IS
'Stores document metadata for each document request.';

COMMENT ON COLUMN document.document_files.id IS
'Internal primary key.';

COMMENT ON COLUMN document.document_files.uuid IS
'Public unique identifier (UUID v7).';

COMMENT ON COLUMN document.document_files.document_request_id IS
'Related document request.';

COMMENT ON COLUMN document.document_files.document_type_id IS
'Type of uploaded document.';

COMMENT ON COLUMN document.document_files.current_version IS
'Current active document version.';

COMMENT ON COLUMN document.document_files.created_at IS
'Record creation timestamp.';

COMMENT ON COLUMN document.document_files.updated_at IS
'Record last update timestamp.';

COMMENT ON COLUMN document.document_files.deleted_at IS
'Soft delete timestamp.';

COMMIT;
