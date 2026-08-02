BEGIN;

CREATE TABLE IF NOT EXISTS core.model_has_permissions
(
    permission_id BIGINT NOT NULL,

    model_type VARCHAR(255) NOT NULL,

    model_id BIGINT NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT pk_model_has_permissions
        PRIMARY KEY (
            permission_id,
            model_type,
            model_id
        ),

    CONSTRAINT fk_model_has_permissions_permission
        FOREIGN KEY (permission_id)
        REFERENCES core.permissions(id)
        ON DELETE CASCADE
);

CREATE INDEX idx_model_has_permissions_model
ON core.model_has_permissions (
    model_id,
    model_type
);

COMMENT ON TABLE core.model_has_permissions IS
'Maps application models directly to permissions for Spatie Laravel Permission.';

COMMENT ON COLUMN core.model_has_permissions.permission_id IS
'Referenced permission identifier.';

COMMENT ON COLUMN core.model_has_permissions.model_type IS
'Fully qualified model class name.';

COMMENT ON COLUMN core.model_has_permissions.model_id IS
'Referenced model identifier.';

COMMIT;