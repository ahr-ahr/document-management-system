BEGIN;

DROP TRIGGER IF EXISTS trg_users_set_updated_at
ON core.users;

CREATE TRIGGER trg_users_set_updated_at
BEFORE UPDATE
ON core.users
FOR EACH ROW
EXECUTE FUNCTION public.set_updated_at();

COMMENT ON TRIGGER trg_users_set_updated_at
ON core.users
IS 'Automatically updates the updated_at column before a user record is updated.';

COMMIT;
