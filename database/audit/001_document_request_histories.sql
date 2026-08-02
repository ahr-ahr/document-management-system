BEGIN;

CREATE TABLE IF NOT EXISTS audit.document_request_histories (
    id BIGINT GENERATED ALWAYS AS IDENTITY,

    uuid UUID NOT NULL DEFAULT uuidv7(),

    document_request_id BIGINT NOT NULL,

    actor_id BIGINT NOT NULL,

    from_status_id BIGINT NOT NULL,

    to_status_id BIGINT NOT NULL,

    action history_action_enum NOT NULL,

    remarks TEXT,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT pk_document_request_histories
        PRIMARY KEY (id),

    CONSTRAINT uq_document_request_histories_uuid
        UNIQUE (uuid),

    CONSTRAINT fk_document_request_histories_document_request
        FOREIGN KEY (document_request_id)
        REFERENCES document.document_requests(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_document_request_histories_actor
        FOREIGN KEY (actor_id)
        REFERENCES core.users(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_document_request_histories_from_status
        FOREIGN KEY (from_status_id)
        REFERENCES master.master_document_statuses(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_document_request_histories_to_status
        FOREIGN KEY (to_status_id)
        REFERENCES master.master_document_statuses(id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

COMMENT ON TABLE audit.document_request_histories IS
'Stores complete workflow history of document requests.';

COMMENT ON COLUMN audit.document_request_histories.id IS
'Internal primary key.';

COMMENT ON COLUMN audit.document_request_histories.uuid IS
'Public unique identifier (UUID v7).';

COMMENT ON COLUMN audit.document_request_histories.document_request_id IS
'Related document request.';

COMMENT ON COLUMN audit.document_request_histories.actor_id IS
'User who performed the action.';

COMMENT ON COLUMN audit.document_request_histories.from_status_id IS
'Previous status.';

COMMENT ON COLUMN audit.document_request_histories.to_status_id IS
'New status.';

COMMENT ON COLUMN audit.document_request_histories.action IS
'Workflow action performed.';

COMMENT ON COLUMN audit.document_request_histories.remarks IS
'Additional remarks or notes.';

COMMENT ON COLUMN audit.document_request_histories.created_at IS
'Timestamp when the action occurred.';

COMMIT;
