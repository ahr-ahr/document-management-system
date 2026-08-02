BEGIN;

CREATE TABLE IF NOT EXISTS core.permissions
(
    id BIGINT GENERATED ALWAYS AS IDENTITY,

    uuid UUID NOT NULL DEFAULT gen_random_uuid(),

    name VARCHAR(255) NOT NULL,

    guard_name VARCHAR(100) NOT NULL DEFAULT 'web',

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT pk_permissions
        PRIMARY KEY (id),

    CONSTRAINT uq_permissions_uuid
        UNIQUE (uuid),

    CONSTRAINT uq_permissions_name_guard
        UNIQUE (name, guard_name)
);

COMMENT ON TABLE core.permissions IS
'Stores application permissions used by Spatie Laravel Permission.';

COMMENT ON COLUMN core.permissions.name IS
'Unique permission name.';

COMMENT ON COLUMN core.permissions.guard_name IS
'Authentication guard associated with the permission.';

COMMIT;