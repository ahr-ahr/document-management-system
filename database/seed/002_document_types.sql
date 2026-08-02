BEGIN;

INSERT INTO master.document_types (
    code,
    name,
    description,
    allowed_extensions,
    max_file_size,
    is_required,
    sort_order,
    is_active,
    created_at,
    updated_at
)
VALUES
(
    'KTP',
    'Kartu Tanda Penduduk',
    'National identity card.',
    'pdf,jpg,jpeg,png',
    5242880,
    TRUE,
    1,
    TRUE,
    NOW(),
    NOW()
),
(
    'KK',
    'Kartu Keluarga',
    'Family card.',
    'pdf,jpg,jpeg,png',
    5242880,
    TRUE,
    2,
    TRUE,
    NOW(),
    NOW()
),
(
    'NPWP',
    'Nomor Pokok Wajib Pajak',
    'Tax identification number document.',
    'pdf,jpg,jpeg,png',
    5242880,
    FALSE,
    3,
    TRUE,
    NOW(),
    NOW()
),
(
    'NIB',
    'Nomor Induk Berusaha',
    'Business identification number.',
    'pdf',
    10485760,
    FALSE,
    4,
    TRUE,
    NOW(),
    NOW()
),
(
    'SIUP',
    'Surat Izin Usaha Perdagangan',
    'Business trading license.',
    'pdf',
    10485760,
    FALSE,
    5,
    TRUE,
    NOW(),
    NOW()
),
(
    'AKTA',
    'Akta Pendirian',
    'Company establishment deed.',
    'pdf',
    10485760,
    FALSE,
    6,
    TRUE,
    NOW(),
    NOW()
)
ON CONFLICT (code)
DO UPDATE SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    allowed_extensions = EXCLUDED.allowed_extensions,
    max_file_size = EXCLUDED.max_file_size,
    is_required = EXCLUDED.is_required,
    sort_order = EXCLUDED.sort_order,
    is_active = EXCLUDED.is_active,
    updated_at = NOW();

COMMIT;
