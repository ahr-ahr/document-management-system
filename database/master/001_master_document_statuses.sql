BEGIN;

CREATE TABLE IF NOT EXISTS master.master_document_statuses (
    id BIGINT GENERATED ALWAYS AS IDENTITY,

    code VARCHAR(50) NOT NULL,

    name VARCHAR(100) NOT NULL,

    description TEXT,

    color VARCHAR(20),

    sort_order INTEGER NOT NULL DEFAULT 0,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT pk_master_document_statuses
        PRIMARY KEY (id),

    CONSTRAINT uq_master_document_statuses_code
        UNIQUE (code),

    CONSTRAINT ck_master_document_statuses_sort_order
        CHECK (sort_order >= 0)
);

COMMENT ON TABLE master.master_document_statuses IS
'Master data for document request statuses.';

COMMENT ON COLUMN master.master_document_statuses.id IS
'Internal primary key.';

COMMENT ON COLUMN master.master_document_statuses.code IS
'Unique status code.';

COMMENT ON COLUMN master.master_document_statuses.name IS
'Display name of the status.';

COMMENT ON COLUMN master.master_document_statuses.description IS
'Status description.';

COMMENT ON COLUMN master.master_document_statuses.color IS
'Color used by the frontend to represent the status.';

COMMENT ON COLUMN master.master_document_statuses.sort_order IS
'Display order of the status.';

COMMENT ON COLUMN master.master_document_statuses.is_active IS
'Indicates whether the status is active.';

COMMENT ON COLUMN master.master_document_statuses.created_at IS
'Record creation timestamp.';

COMMENT ON COLUMN master.master_document_statuses.updated_at IS
'Record last update timestamp.';

COMMIT;
