BEGIN;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_type
        WHERE typname = 'review_result_enum'
    ) THEN
        CREATE TYPE review_result_enum AS ENUM (
            'approved',
            'revision',
            'rejected'
        );
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_type
        WHERE typname = 'history_action_enum'
    ) THEN
        CREATE TYPE history_action_enum AS ENUM (
            'submit',
            'review',
            'revision',
            'resubmit',
            'approve',
            'reject'
        );
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_type
        WHERE typname = 'security_severity_enum'
    ) THEN
        CREATE TYPE security_severity_enum AS ENUM (
            'info',
            'warning',
            'error',
            'critical'
        );
    END IF;
END $$;

COMMIT;
