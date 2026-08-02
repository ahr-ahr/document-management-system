BEGIN;

CREATE OR REPLACE FUNCTION public.update_document_current_version()
RETURNS TRIGGER
LANGUAGE plpgsql
AS
$$
BEGIN
    UPDATE document.document_files
    SET
        current_version = NEW.version,
        updated_at = NOW()
    WHERE id = NEW.document_file_id;

    RETURN NEW;
END;
$$;

COMMENT ON FUNCTION public.update_document_current_version() IS
'Updates the current version of a document file after a new version is inserted.';

COMMIT;
