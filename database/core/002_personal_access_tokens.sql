BEGIN;

CREATE TABLE IF NOT EXISTS core.personal_access_tokens
(
    id BIGINT GENERATED ALWAYS AS IDENTITY,

    uuid UUID NOT NULL DEFAULT gen_random_uuid(),

    tokenable_type VARCHAR(255) NOT NULL,

    tokenable_id BIGINT NOT NULL,

    name TEXT NOT NULL,

    token VARCHAR(64) NOT NULL,

    abilities TEXT,

    last_used_at TIMESTAMPTZ,

    expires_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    CONSTRAINT pk_personal_access_tokens
        PRIMARY KEY (id),

    CONSTRAINT uq_personal_access_tokens_uuid
        UNIQUE (uuid),

    CONSTRAINT uq_personal_access_tokens_token
        UNIQUE (token)
);

CREATE INDEX idx_personal_access_tokens_tokenable
ON core.personal_access_tokens (
    tokenable_type,
    tokenable_id
);

CREATE INDEX idx_personal_access_tokens_expires_at
ON core.personal_access_tokens (
    expires_at
);

COMMENT ON TABLE core.personal_access_tokens IS
'Stores personal access tokens for Laravel Sanctum authentication.';

COMMIT;