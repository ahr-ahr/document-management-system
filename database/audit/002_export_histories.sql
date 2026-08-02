BEGIN;

CREATE TABLE IF NOT EXISTS audit.export_histories (
    id BIGINT GENERATED ALWAYS AS IDENTITY,

    uuid UUID NOT NULL DEFAULT uuidv7(),

    user_id BIGINT NOT NULL,

    export_type VARCHAR(50) NOT NULL,

    file_format VARCHAR(20) NOT NULL,

    filter_parameters JSONB,

    file_name VARCHAR(255),

    exported_at TIMESTAMPTZ NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT pk_export_histories
        PRIMARY KEY (id),

    CONSTRAINT uq_export_histories_uuid
        UNIQUE (uuid),

    CONSTRAINT fk_export_histories_user
        FOREIGN KEY (user_id)
        REFERENCES core.users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

COMMENT ON TABLE audit.export_histories IS
'Stores history of exported reports and documents.';

COMMENT ON COLUMN audit.export_histories.id IS
'Internal primary key.';

COMMENT ON COLUMN audit.export_histories.uuid IS
'Public unique identifier (UUID v7).';

COMMENT ON COLUMN audit.export_histories.user_id IS
'User who performed the export.';

COMMENT ON COLUMN audit.export_histories.export_type IS
'Type of exported data.';

COMMENT ON COLUMN audit.export_histories.file_format IS
'Export file format (PDF, XLSX, CSV, etc.).';

COMMENT ON COLUMN audit.export_histories.filter_parameters IS
'Filters used during export.';

COMMENT ON COLUMN audit.export_histories.file_name IS
'Generated export filename.';

COMMENT ON COLUMN audit.export_histories.exported_at IS
'Timestamp when export was generated.';

COMMENT ON COLUMN audit.export_histories.created_at IS
'Record creation timestamp.';

COMMIT;
