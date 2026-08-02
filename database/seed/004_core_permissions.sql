BEGIN;

INSERT INTO core.permissions (
    uuid,
    name,
    guard_name,
    created_at,
    updated_at
)
VALUES

(
    uuidv7(),
    'document_request.create',
    'web',
    NOW(),
    NOW()
),

(
    uuidv7(),
    'document_request.update',
    'web',
    NOW(),
    NOW()
),

(
    uuidv7(),
    'document_request.upload',
    'web',
    NOW(),
    NOW()
),

(
    uuidv7(),
    'document_request.submit',
    'web',
    NOW(),
    NOW()
),

(
    uuidv7(),
    'document_request.view',
    'web',
    NOW(),
    NOW()
),

(
    uuidv7(),
    'document_request.history',
    'web',
    NOW(),
    NOW()
),

(
    uuidv7(),
    'document_request.review',
    'web',
    NOW(),
    NOW()
),

(
    uuidv7(),
    'document_request.revision',
    'web',
    NOW(),
    NOW()
),

(
    uuidv7(),
    'document_request.approve',
    'web',
    NOW(),
    NOW()
),

(
    uuidv7(),
    'document_request.reject',
    'web',
    NOW(),
    NOW()
)

ON CONFLICT (name, guard_name)
DO UPDATE SET
    updated_at = NOW();

COMMIT;