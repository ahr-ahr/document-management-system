BEGIN;

CREATE FUNCTION public.record_document_history(
    p_document_request_id BIGINT,
    p_actor_id BIGINT,
    p_from_status_id BIGINT,
    p_to_status_id BIGINT,
    p_action history_action_enum,
    p_remarks TEXT DEFAULT NULL
)
RETURNS BIGINT
LANGUAGE plpgsql
AS
$$
DECLARE
    v_history_id BIGINT;
BEGIN
    INSERT INTO audit.document_request_histories (
        document_request_id,
        actor_id,
        from_status_id,
        to_status_id,
        action,
        remarks,
        created_at
    )
    VALUES (
        p_document_request_id,
        p_actor_id,
        p_from_status_id,
        p_to_status_id,
        p_action,
        p_remarks,
        NOW()
    )
    RETURNING id
    INTO v_history_id;

    RETURN v_history_id;
END;
$$;

COMMENT ON FUNCTION public.record_document_history(
    BIGINT,
    BIGINT,
    BIGINT,
    BIGINT,
    history_action_enum,
    TEXT
)
IS 'Creates a document request history record and returns the generated history ID. Intended to be called by the application within a transaction.';

COMMIT;
