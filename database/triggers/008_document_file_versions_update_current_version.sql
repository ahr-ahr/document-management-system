BEGIN;

DROP TRIGGER IF EXISTS trg_document_file_versions_update_current_version
ON document.document_file_versions;

CREATE TRIGGER trg_document_file_versions_update_current_version
AFTER INSERT
ON document.document_file_versions
FOR EACH ROW
EXECUTE FUNCTION public.update_document_current_version();

COMMENT ON TRIGGER trg_document_file_versions_update_current_version
ON document.document_file_versions
IS 'Automatically updates the current version of a document file after a new version is uploaded.';

COMMIT;
