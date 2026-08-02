BEGIN;

DROP TRIGGER IF EXISTS trg_document_types_set_updated_at
ON master.document_types;

CREATE TRIGGER trg_document_types_set_updated_at
BEFORE UPDATE
ON master.document_types
FOR EACH ROW
EXECUTE FUNCTION public.set_updated_at();

COMMENT ON TRIGGER trg_document_types_set_updated_at
ON master.document_types
IS 'Automatically updates the updated_at column before a document type is updated.';

COMMIT;
