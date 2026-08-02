BEGIN;

CREATE INDEX IF NOT EXISTS ix_document_types_is_active
ON master.document_types (is_active);

CREATE INDEX IF NOT EXISTS ix_document_types_is_required
ON master.document_types (is_required);

CREATE INDEX IF NOT EXISTS ix_document_types_sort_order
ON master.document_types (sort_order);

COMMIT;
