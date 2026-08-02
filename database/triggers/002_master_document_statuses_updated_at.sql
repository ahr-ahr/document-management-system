BEGIN;

DROP TRIGGER IF EXISTS trg_master_document_statuses_set_updated_at
ON master.master_document_statuses;

CREATE TRIGGER trg_master_document_statuses_set_updated_at
BEFORE UPDATE
ON master.master_document_statuses
FOR EACH ROW
EXECUTE FUNCTION public.set_updated_at();

COMMENT ON TRIGGER trg_master_document_statuses_set_updated_at
ON master.master_document_statuses
IS 'Automatically updates the updated_at column before a document status is updated.';

COMMIT;
