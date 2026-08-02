BEGIN;

CREATE TABLE IF NOT EXISTS core.roles
(
    id BIGINT GENERATED ALWAYS AS IDENTITY,

    uuid UUID NOT NULL DEFAULT gen_random_uuid(),

    name VARCHAR(255) NOT NULL,

    guard_name VARCHAR(100) NOT NULL DEFAULT 'web',

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT pk_roles
        PRIMARY KEY (id),

    CONSTRAINT uq_roles_uuid
        UNIQUE (uuid),

    CONSTRAINT uq_roles_name_guard
        UNIQUE (name, guard_name)
);

COMMENT ON TABLE core.roles IS
'Stores application roles used by Spatie Laravel Permission.';

COMMENT ON COLUMN core.roles.name IS
'Unique role name.';

COMMENT ON COLUMN core.roles.guard_name IS
'Authentication guard associated with the role.';

COMMIT;