BEGIN;

DROP VIEW IF EXISTS document.vw_dashboard_summary;

CREATE VIEW document.vw_dashboard_summary AS
SELECT
    COUNT(DISTINCT p.id) AS total_projects,

    COUNT(DISTINCT dr.id) AS total_document_requests,

    COUNT(*) FILTER (
        WHERE s.code = 'SUBMITTED'
    ) AS submitted_requests,

    COUNT(*) FILTER (
        WHERE s.code = 'UNDER_REVIEW'
    ) AS under_review_requests,

    COUNT(*) FILTER (
        WHERE s.code = 'REVISION'
    ) AS revision_requests,

    COUNT(*) FILTER (
        WHERE s.code = 'APPROVED'
    ) AS approved_requests,

    COUNT(*) FILTER (
        WHERE s.code = 'REJECTED'
    ) AS rejected_requests

FROM document.document_requests dr
INNER JOIN document.projects p
    ON p.id = dr.project_id
INNER JOIN master.master_document_statuses s
    ON s.id = dr.current_status_id;

COMMENT ON VIEW document.vw_dashboard_summary IS
'Provides aggregated statistics for the application dashboard.';

COMMIT;
