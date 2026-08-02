BEGIN;

DROP VIEW IF EXISTS document.vw_projects;

CREATE VIEW document.vw_projects AS
SELECT
    p.id,
    p.uuid,

    p.project_code,
    p.project_name,
    p.description,

    u.id AS user_id,
    u.name AS owner_name,
    u.email AS owner_email,

    s.id AS status_id,
    s.code AS status_code,
    s.name AS status_name,
    s.color AS status_color,

    p.submitted_at,
    p.approved_at,
    p.rejected_at,

    p.created_at,
    p.updated_at
FROM document.projects p
INNER JOIN core.users u
    ON u.id = p.user_id
INNER JOIN master.master_document_statuses s
    ON s.id = p.current_status_id;

COMMENT ON VIEW document.vw_projects IS
'Provides project information along with owner and current document status.';

COMMIT;
