BEGIN;

CREATE TABLE IF NOT EXISTS core.role_has_permissions
(
    role_id BIGINT NOT NULL,

    permission_id BIGINT NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT pk_role_has_permissions
        PRIMARY KEY (
            role_id,
            permission_id
        ),

    CONSTRAINT fk_role_has_permissions_role
        FOREIGN KEY (role_id)
        REFERENCES core.roles(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_role_has_permissions_permission
        FOREIGN KEY (permission_id)
        REFERENCES core.permissions(id)
        ON DELETE CASCADE
);

COMMENT ON TABLE core.role_has_permissions IS
'Maps roles to permissions for Spatie Laravel Permission.';

COMMENT ON COLUMN core.role_has_permissions.role_id IS
'Referenced role identifier.';

COMMENT ON COLUMN core.role_has_permissions.permission_id IS
'Referenced permission identifier.';

COMMIT;