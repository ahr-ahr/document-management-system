BEGIN;

DROP TRIGGER IF EXISTS trg_document_requests_set_updated_at
ON document.document_requests;

CREATE TRIGGER trg_document_requests_set_updated_at
BEFORE UPDATE
ON document.document_requests
FOR EACH ROW
EXECUTE FUNCTION public.set_updated_at();

COMMENT ON TRIGGER trg_document_requests_set_updated_at
ON document.document_requests
IS 'Automatically updates the updated_at column before a document request is updated.';

COMMIT;
