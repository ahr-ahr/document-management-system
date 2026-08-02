BEGIN;

CREATE SEQUENCE IF NOT EXISTS public.request_number_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 10;

CREATE OR REPLACE FUNCTION public.generate_request_number()
RETURNS VARCHAR
LANGUAGE plpgsql
AS
$$
DECLARE
    v_sequence BIGINT;
BEGIN
    v_sequence := nextval('public.request_number_seq');

    RETURN
        'REQ-' ||
        TO_CHAR(CURRENT_DATE, 'YYYYMMDD') ||
        '-' ||
        LPAD(v_sequence::TEXT, 6, '0');
END;
$$;

COMMENT ON FUNCTION public.generate_request_number() IS
'Generates a unique document request number using PostgreSQL sequence.';

COMMIT;
