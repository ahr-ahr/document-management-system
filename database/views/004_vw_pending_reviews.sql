BEGIN;

DROP VIEW IF EXISTS document.vw_pending_reviews;

CREATE VIEW document.vw_pending_reviews AS
SELECT
    dr.id,
    dr.uuid,

    dr.request_number,

    p.id AS project_id,
    p.project_code,
    p.project_name,

    u.id AS owner_id,
    u.name AS owner_name,
    u.email AS owner_email,

    s.id AS status_id,
    s.code AS status_code,
    s.name AS status_name,
    s.color AS status_color,

    dr.submission_note,

    dr.submitted_at,
    dr.created_at

FROM document.document_requests dr
INNER JOIN document.projects p
    ON p.id = dr.project_id
INNER JOIN core.users u
    ON u.id = p.user_id
INNER JOIN master.master_document_statuses s
    ON s.id = dr.current_status_id

WHERE s.code IN (
    'SUBMITTED',
    'UNDER_REVIEW',
    'REVISION'
)

ORDER BY
    dr.submitted_at ASC NULLS LAST,
    dr.created_at ASC;

COMMENT ON VIEW document.vw_pending_reviews IS
'Provides document requests that are waiting for review or revision.';

COMMIT;
