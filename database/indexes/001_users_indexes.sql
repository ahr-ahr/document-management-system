BEGIN;

CREATE INDEX IF NOT EXISTS ix_users_is_active
ON core.users (is_active);

CREATE INDEX IF NOT EXISTS ix_users_last_login_at
ON core.users (last_login_at);

CREATE INDEX IF NOT EXISTS ix_users_deleted_at
ON core.users (deleted_at);

CREATE INDEX IF NOT EXISTS ix_users_name_trgm
ON core.users
USING gin (name gin_trgm_ops);

COMMIT;
