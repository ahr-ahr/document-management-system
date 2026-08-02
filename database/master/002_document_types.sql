BEGIN;

CREATE TABLE IF NOT EXISTS master.document_types (
    id BIGINT GENERATED ALWAYS AS IDENTITY,

    code VARCHAR(50) NOT NULL,

    name VARCHAR(150) NOT NULL,

    description TEXT,

    allowed_extensions VARCHAR(255),

    max_file_size BIGINT NOT NULL,

    is_required BOOLEAN NOT NULL DEFAULT FALSE,

    sort_order INTEGER NOT NULL DEFAULT 0,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT pk_document_types
        PRIMARY KEY (id),

    CONSTRAINT uq_document_types_code
        UNIQUE (code),

    CONSTRAINT ck_document_types_max_file_size
        CHECK (max_file_size > 0),

    CONSTRAINT ck_document_types_sort_order
        CHECK (sort_order >= 0)
);

COMMENT ON TABLE master.document_types IS
'Master data for document types required in document requests.';

COMMENT ON COLUMN master.document_types.id IS
'Internal primary key.';

COMMENT ON COLUMN master.document_types.code IS
'Unique document type code.';

COMMENT ON COLUMN master.document_types.name IS
'Display name of the document type.';

COMMENT ON COLUMN master.document_types.description IS
'Description of the document type.';

COMMENT ON COLUMN master.document_types.allowed_extensions IS
'Allowed file extensions separated by commas.';

COMMENT ON COLUMN master.document_types.max_file_size IS
'Maximum allowed file size in bytes.';

COMMENT ON COLUMN master.document_types.is_required IS
'Indicates whether this document type is mandatory.';

COMMENT ON COLUMN master.document_types.sort_order IS
'Display order of the document type.';

COMMENT ON COLUMN master.document_types.is_active IS
'Indicates whether this document type is active.';

COMMENT ON COLUMN master.document_types.created_at IS
'Record creation timestamp.';

COMMENT ON COLUMN master.document_types.updated_at IS
'Record last update timestamp.';

COMMIT;
