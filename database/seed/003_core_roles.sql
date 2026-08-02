BEGIN;

INSERT INTO core.roles (
    uuid,
    name,
    guard_name,
    created_at,
    updated_at
)
VALUES
(
    uuidv7(),
    'administrator',
    'web',
    NOW(),
    NOW()
),
(
    uuidv7(),
    'pemohon',
    'web',
    NOW(),
    NOW()
),
(
    uuidv7(),
    'penilai',
    'web',
    NOW(),
    NOW()
)
ON CONFLICT (name, guard_name)
DO UPDATE SET
    updated_at = NOW();

COMMIT;