BEGIN;

INSERT INTO core.role_has_permissions (
    permission_id,
    role_id
)
SELECT
    p.id,
    r.id
FROM core.permissions p
JOIN core.roles r
ON r.name = 'pemohon'
WHERE p.name IN (
    'document_request.create',
    'document_request.update',
    'document_request.upload',
    'document_request.submit',
    'document_request.view',
    'document_request.history'
)
ON CONFLICT DO NOTHING;


INSERT INTO core.role_has_permissions (
    permission_id,
    role_id
)
SELECT
    p.id,
    r.id
FROM core.permissions p
JOIN core.roles r
ON r.name = 'penilai'
WHERE p.name IN (
    'document_request.view',
    'document_request.history',
    'document_request.review',
    'document_request.revision',
    'document_request.approve',
    'document_request.reject'
)
ON CONFLICT DO NOTHING;


INSERT INTO core.role_has_permissions (
    permission_id,
    role_id
)
SELECT
    p.id,
    r.id
FROM core.permissions p
JOIN core.roles r
ON r.name = 'administrator'
ON CONFLICT DO NOTHING;


COMMIT;