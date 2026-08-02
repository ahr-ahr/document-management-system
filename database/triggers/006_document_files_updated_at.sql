BEGIN;

DROP TRIGGER IF EXISTS trg_document_files_set_updated_at
ON document.document_files;

CREATE TRIGGER trg_document_files_set_updated_at
BEFORE UPDATE
ON document.document_files
FOR EACH ROW
EXECUTE FUNCTION public.set_updated_at();

COMMENT ON TRIGGER trg_document_files_set_updated_at
ON document.document_files
IS 'Automatically updates the updated_at column before a document file is updated.';

COMMIT;
