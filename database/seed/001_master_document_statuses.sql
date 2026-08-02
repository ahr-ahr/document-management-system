BEGIN;

INSERT INTO master.master_document_statuses (
    code,
    name,
    description,
    color,
    sort_order,
    is_active,
    created_at,
    updated_at
)
VALUES
(
    'DRAFT',
    'Draft',
    'Document request is being prepared.',
    '#6B7280',
    1,
    TRUE,
    NOW(),
    NOW()
),
(
    'SUBMITTED',
    'Submitted',
    'Document request has been submitted.',
    '#3B82F6',
    2,
    TRUE,
    NOW(),
    NOW()
),
(
    'UNDER_REVIEW',
    'Under Review',
    'Document request is under review.',
    '#F59E0B',
    3,
    TRUE,
    NOW(),
    NOW()
),
(
    'REVISION',
    'Revision Required',
    'Document request requires revision.',
    '#EF4444',
    4,
    TRUE,
    NOW(),
    NOW()
),
(
    'APPROVED',
    'Approved',
    'Document request has been approved.',
    '#10B981',
    5,
    TRUE,
    NOW(),
    NOW()
),
(
    'REJECTED',
    'Rejected',
    'Document request has been rejected.',
    '#991B1B',
    6,
    TRUE,
    NOW(),
    NOW()
)
ON CONFLICT (code)
DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    color = EXCLUDED.color,
    sort_order = EXCLUDED.sort_order,
    is_active = EXCLUDED.is_active,
    updated_at = NOW();

COMMIT;
