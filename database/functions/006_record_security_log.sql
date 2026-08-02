BEGIN;

CREATE OR REPLACE FUNCTION public.record_security_log(
    p_user_id BIGINT,
    p_event_type VARCHAR(50),
    p_severity security_severity_enum,
    p_ip_address INET,
    p_endpoint VARCHAR(255) DEFAULT NULL,
    p_http_method VARCHAR(10) DEFAULT NULL,
    p_status_code SMALLINT DEFAULT NULL,
    p_user_agent TEXT DEFAULT NULL,
    p_metadata JSONB DEFAULT NULL
)
RETURNS BIGINT
LANGUAGE plpgsql
AS
$$
DECLARE
    v_log_id BIGINT;
BEGIN
    INSERT INTO security.security_logs (
        user_id,
        event_type,
        severity,
        ip_address,
        endpoint,
        http_method,
        status_code,
        user_agent,
        metadata,
        created_at
    )
    VALUES (
        p_user_id,
        p_event_type,
        p_severity,
        p_ip_address,
        p_endpoint,
        p_http_method,
        p_status_code,
        p_user_agent,
        p_metadata,
        NOW()
    )
    RETURNING id
    INTO v_log_id;

    RETURN v_log_id;
END;
$$;

COMMENT ON FUNCTION public.record_security_log(
    BIGINT,
    VARCHAR,
    security_severity_enum,
    INET,
    VARCHAR,
    VARCHAR,
    SMALLINT,
    TEXT,
    JSONB
)
IS 'Creates a security log entry and returns the generated log ID. Intended to be called by the application.';

COMMIT;
