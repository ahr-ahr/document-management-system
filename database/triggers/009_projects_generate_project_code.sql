BEGIN;

DROP TRIGGER IF EXISTS trg_projects_generate_code
ON document.projects;


CREATE OR REPLACE FUNCTION document.set_project_code()
RETURNS TRIGGER
LANGUAGE plpgsql
AS
$$
BEGIN

    IF NEW.project_code IS NULL THEN
        NEW.project_code := public.generate_project_code();
    END IF;

    RETURN NEW;

END;
$$;


CREATE TRIGGER trg_projects_generate_code
BEFORE INSERT
ON document.projects
FOR EACH ROW
EXECUTE FUNCTION document.set_project_code();


COMMENT ON TRIGGER trg_projects_generate_code
ON document.projects
IS 'Automatically generates project code before inserting a project.';


COMMIT;