BEGIN;

DROP TRIGGER IF EXISTS trg_document_request_reviews_set_updated_at
ON document.document_request_reviews;

CREATE TRIGGER trg_document_request_reviews_set_updated_at
BEFORE UPDATE
ON document.document_request_reviews
FOR EACH ROW
EXECUTE FUNCTION public.set_updated_at();

COMMENT ON TRIGGER trg_document_request_reviews_set_updated_at
ON document.document_request_reviews
IS 'Automatically updates the updated_at column before a document request review is updated.';

COMMIT;
