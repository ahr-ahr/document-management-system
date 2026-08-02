BEGIN;

CREATE TABLE IF NOT EXISTS core.model_has_roles
(
    role_id BIGINT NOT NULL,

    model_type VARCHAR(255) NOT NULL,

    model_id BIGINT NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT pk_model_has_roles
        PRIMARY KEY (
            role_id,
            model_type,
            model_id
        ),

    CONSTRAINT fk_model_has_roles_role
        FOREIGN KEY (role_id)
        REFERENCES core.roles(id)
        ON DELETE CASCADE
);

CREATE INDEX idx_model_has_roles_model
ON core.model_has_roles (
    model_id,
    model_type
);

COMMENT ON TABLE core.model_has_roles IS
'Maps application models to roles for Spatie Laravel Permission.';

COMMENT ON COLUMN core.model_has_roles.role_id IS
'Referenced role identifier.';

COMMENT ON COLUMN core.model_has_roles.model_type IS
'Fully qualified model class name.';

COMMENT ON COLUMN core.model_has_roles.model_id IS
'Referenced model identifier.';

COMMIT;