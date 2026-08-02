BEGIN;

DROP TRIGGER IF EXISTS trg_projects_set_updated_at
ON document.projects;

CREATE TRIGGER trg_projects_set_updated_at
BEFORE UPDATE
ON document.projects
FOR EACH ROW
EXECUTE FUNCTION public.set_updated_at();

COMMENT ON TRIGGER trg_projects_set_updated_at
ON document.projects
IS 'Automatically updates the updated_at column before a project is updated.';

COMMIT;
