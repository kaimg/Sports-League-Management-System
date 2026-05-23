-- Bootstrap settings for a fresh PostgreSQL container.
-- The application user is created automatically from POSTGRES_USER.

DO $$
DECLARE
    dbname text := current_database();
BEGIN
    EXECUTE format('ALTER DATABASE %I SET search_path TO public', dbname);
END
$$;
