BEGIN;

CREATE TABLE IF NOT EXISTS document.document_file_versions (
    id BIGINT GENERATED ALWAYS AS IDENTITY,

    uuid UUID NOT NULL DEFAULT uuidv7(),

    document_file_id BIGINT NOT NULL,

    version INTEGER NOT NULL,

    original_filename VARCHAR(255) NOT NULL,

    stored_filename VARCHAR(255) NOT NULL,

    file_path TEXT NOT NULL,

    mime_type VARCHAR(100) NOT NULL,

    file_extension VARCHAR(20) NOT NULL,

    file_size BIGINT NOT NULL,

    checksum VARCHAR(255),

    uploaded_by BIGINT NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT pk_document_file_versions
        PRIMARY KEY (id),

    CONSTRAINT uq_document_file_versions_uuid
        UNIQUE (uuid),

    CONSTRAINT uq_document_file_versions_document_version
        UNIQUE (
            document_file_id,
            version
        ),

    CONSTRAINT fk_document_file_versions_document_file
        FOREIGN KEY (document_file_id)
        REFERENCES document.document_files(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_document_file_versions_uploaded_by
        FOREIGN KEY (uploaded_by)
        REFERENCES core.users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT ck_document_file_versions_version
        CHECK (version > 0),

    CONSTRAINT ck_document_file_versions_file_size
        CHECK (file_size > 0)
);

COMMENT ON TABLE document.document_file_versions IS
'Stores every uploaded version of a document file.';

COMMENT ON COLUMN document.document_file_versions.id IS
'Internal primary key.';

COMMENT ON COLUMN document.document_file_versions.uuid IS
'Public unique identifier (UUID v7).';

COMMENT ON COLUMN document.document_file_versions.document_file_id IS
'Related document file.';

COMMENT ON COLUMN document.document_file_versions.version IS
'Document version number.';

COMMENT ON COLUMN document.document_file_versions.original_filename IS
'Original filename uploaded by the user.';

COMMENT ON COLUMN document.document_file_versions.stored_filename IS
'Filename stored on the server or object storage.';

COMMENT ON COLUMN document.document_file_versions.file_path IS
'Physical or object storage path of the file.';

COMMENT ON COLUMN document.document_file_versions.mime_type IS
'Detected MIME type of the uploaded file.';

COMMENT ON COLUMN document.document_file_versions.file_extension IS
'Uploaded file extension.';

COMMENT ON COLUMN document.document_file_versions.file_size IS
'File size in bytes.';

COMMENT ON COLUMN document.document_file_versions.checksum IS
'Checksum for integrity verification.';

COMMENT ON COLUMN document.document_file_versions.uploaded_by IS
'User who uploaded this version.';

COMMENT ON COLUMN document.document_file_versions.created_at IS
'Record creation timestamp.';

COMMIT;
