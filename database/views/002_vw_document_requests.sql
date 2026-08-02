BEGIN;

DROP VIEW IF EXISTS document.vw_document_requests;

CREATE VIEW document.vw_document_requests AS
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
    dr.reviewed_at,
    dr.approved_at,
    dr.rejected_at,

    dr.created_at,
    dr.updated_at
FROM document.document_requests dr
INNER JOIN document.projects p
    ON p.id = dr.project_id
INNER JOIN core.users u
    ON u.id = p.user_id
INNER JOIN master.master_document_statuses s
    ON s.id = dr.current_status_id;

COMMENT ON VIEW document.vw_document_requests IS
'Provides document request information together with project, owner, and current status.';

COMMIT;
