BEGIN;

CREATE INDEX IF NOT EXISTS ix_security_logs_user_id
ON security.security_logs (user_id);

CREATE INDEX IF NOT EXISTS ix_security_logs_event_type
ON security.security_logs (event_type);

CREATE INDEX IF NOT EXISTS ix_security_logs_severity
ON security.security_logs (severity);

CREATE INDEX IF NOT EXISTS ix_security_logs_status_code
ON security.security_logs (status_code);

CREATE INDEX IF NOT EXISTS ix_security_logs_created_at
ON security.security_logs (created_at DESC);

CREATE INDEX IF NOT EXISTS ix_security_logs_ip_address
ON security.security_logs (ip_address);

COMMIT;
