BEGIN;

CREATE INDEX IF NOT EXISTS ix_export_histories_user_id
ON audit.export_histories (user_id);

CREATE INDEX IF NOT EXISTS ix_export_histories_export_type
ON audit.export_histories (export_type);

CREATE INDEX IF NOT EXISTS ix_export_histories_exported_at
ON audit.export_histories (exported_at DESC);

COMMIT;
