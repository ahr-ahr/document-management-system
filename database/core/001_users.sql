BEGIN;

CREATE TABLE IF NOT EXISTS core.users (
    id BIGINT GENERATED ALWAYS AS IDENTITY,

    uuid UUID NOT NULL DEFAULT uuidv7(),

    name VARCHAR(150) NOT NULL,

    email VARCHAR(255) NOT NULL,

    password VARCHAR(255) NOT NULL,

    email_verified_at TIMESTAMPTZ,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    last_login_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    deleted_at TIMESTAMPTZ,

    CONSTRAINT pk_users
        PRIMARY KEY (id),

    CONSTRAINT uq_users_uuid
        UNIQUE (uuid),

    CONSTRAINT uq_users_email
        UNIQUE (email)
);

COMMENT ON TABLE core.users IS
'Stores all application users.';

COMMENT ON COLUMN core.users.id IS
'Internal primary key.';

COMMENT ON COLUMN core.users.uuid IS
'Public unique identifier (UUID v7).';

COMMENT ON COLUMN core.users.name IS
'Full name of the user.';

COMMENT ON COLUMN core.users.email IS
'User email address.';

COMMENT ON COLUMN core.users.password IS
'Hashed password.';

COMMENT ON COLUMN core.users.email_verified_at IS
'Timestamp when the email was verified.';

COMMENT ON COLUMN core.users.is_active IS
'Indicates whether the user account is active.';

COMMENT ON COLUMN core.users.last_login_at IS
'Timestamp of the last successful login.';

COMMENT ON COLUMN core.users.created_at IS
'Record creation timestamp.';

COMMENT ON COLUMN core.users.updated_at IS
'Record last update timestamp.';

COMMENT ON COLUMN core.users.deleted_at IS
'Soft delete timestamp.';

COMMIT;
