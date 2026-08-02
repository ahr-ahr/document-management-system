BEGIN;

CREATE OR REPLACE FUNCTION public.generate_project_code()
RETURNS VARCHAR
LANGUAGE plpgsql
AS
$$
DECLARE
    v_sequence BIGINT;
BEGIN
    v_sequence := nextval('public.project_code_seq');

    RETURN
        'PRJ-' ||
        TO_CHAR(CURRENT_DATE, 'YYYYMMDD') ||
        '-' ||
        LPAD(v_sequence::TEXT, 6, '0');
END;
$$;

COMMENT ON FUNCTION public.generate_project_code() IS
'Generates a unique project code using PostgreSQL sequence.';

COMMIT;
